module RightAws #:nodoc:
  module VERSION #:nodoc:
    MAJOR = 3  unless defined?(MAJOR)
    MINOR = 2  unless defined?(MINOR)
    TINY  = 0  unless defined?(TINY)

    STRING = [MAJOR, MINOR, TINY, 'coupa'].join('.') unless defined?(STRING)
  end
end
