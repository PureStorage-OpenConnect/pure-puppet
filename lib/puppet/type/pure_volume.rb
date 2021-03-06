Puppet::Type.newtype(:pure_volume) do
  @doc = "It does CRUD operations for volumes on a Pure Storage flash array."

  validate do
    raise ArgumentError, "size attribute is mandatory" if value(:size).nil?
  end 

  apply_to_all
  ensurable

  newparam(:name) do
    desc "The name of the volume."
    isnamevar
  end

  newproperty(:size) do
    desc "The volume size. Valid format is [0-9]+[MGT]"
    validate do |value|
      unless value =~ /^\d+[MGT]$/
        raise ArgumentError, "%s is not a valid volume size" % value
      end
    end
  end

  newparam(:device_url) do
    desc "URL in the form of https://<user>:<passwd>@<FQ_Device_Name or IP>"
  end
end
