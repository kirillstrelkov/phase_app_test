# frozen_string_literal: true

require 'aws-sdk'

module ArticlesHelper
  include RedisHelper

  def translate_article(article)
    {
      answer: get_translation(article, :answer),
      question: get_translation(article, :question)
    }
  end

  private

  def get_translation(article, field)
    key = "#{article.id}_#{field}"
    translation = get(key)
    unless translation
      translation = translate_text(article.send(field))
      set(key, translation)
    end
    translation
  end

  def translate_text(text)
    Rails.logger.debug "Translating:\n'#{text}'"
    begin
      @client ||= Aws::Translate::Client.new(
        region: ENV['AWS_REGION'] || 'eu-central-1'
      )
      resp = @client.translate_text(
        text: text,
        source_language_code: 'en',
        target_language_code: 'de'
      ).translated_text
    rescue Aws::Translate::Errors::ServiceError => e
      Rails.logger.debug "ERROR: #{e}"
    end
  end
end
