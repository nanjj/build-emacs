require 'fileutils'

class VerboseShell
  @@verbose = nil
  def self.verbose;     @@verbose;     end
  def self.verbose=(v); @@verbose = v; end

  def self.system_trace(*args)
    return unless @@verbose
    puts "+ "+args.map{|a| a =~ /\s/ ? '"'+a+'"' : a}.join(' ')
  end

  def self.system(*args)
    system_trace *args
    Kernel.system *args or abort "#{args[0]} failed"
  end

  def self.mv(src,dest,options={})
    system_trace *%W"mv #{src} #{dest}"
    FileUtils.mv(src, dest, options)
  end

  def self.cp(src,dest,options={})
    system_trace *%W"cp #{src} #{dest}"
    FileUtils.cp(src, dest, options)
  end

  def self.cp_r(src,dest,options={})
    system_trace *%W"cp -r #{src} #{dest}"
    FileUtils.cp_r(src, dest, options)
  end

  def self.ln_s(src,dest,options={})
    system_trace *%W"ln -s #{src} #{dest}"
    FileUtils.ln_s(src, dest, options)
  end

  def self.rm_rf(file,options={})
    system_trace *%W"rm -rf #{file}"
    FileUtils.rm_rf file, options
  end

  def self.mkdir_p(file,options={})
    system_trace *%W"mkdir -p #{file}"
    FileUtils.mkdir_p file, options
  end
end
