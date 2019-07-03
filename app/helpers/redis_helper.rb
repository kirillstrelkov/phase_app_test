# frozen_string_literal: true

module RedisHelper
  def get(key)
    value = Rails.cache.read(key)
    Rails.logger.debug "RedisHelper.get('#{key}') -> '#{value}'"
    value
  end

  def set(key, value)
    Rails.logger.debug "RedisHelper.set('#{key}', '#{value}')"
    Rails.cache.write(key, value)
  end
  end
