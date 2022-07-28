#
# Docker Engine API
# 
# The Engine API is an HTTP API served by Docker Engine. It is the API the Docker client uses to communicate with the Engine, so everything the Docker client can do can be done with the API.  Most of the client's commands map directly to API endpoints (e.g. `docker ps` is `GET /containers/json`). The notable exception is running containers, which consists of several API calls.  # Errors  The API uses standard HTTP status codes to indicate the success or failure of the API call. The body of the response will be JSON in the following format:  ``` {   \"message\": \"page not found\" } ```  # Versioning  The API is usually changed in each release, so API calls are versioned to ensure that clients don't break. To lock to a specific version of the API, you prefix the URL with its version, for example, call `/v1.30/info` to use the v1.30 version of the `/info` endpoint. If the API version specified in the URL is not supported by the daemon, a HTTP `400 Bad Request` error message is returned.  If you omit the version-prefix, the current version of the API (v1.41) is used. For example, calling `/info` is the same as calling `/v1.41/info`. Using the API without a version-prefix is deprecated and will be removed in a future release.  Engine releases in the near future should support this version of the API, so your client will continue to work even if it is talking to a newer Engine.  The API uses an open schema model, which means server may add extra properties to responses. Likewise, the server will ignore any extra query parameters and request body properties. When you write clients, you need to ignore additional properties in responses to ensure they do not break when talking to newer daemons.   # Authentication  Authentication for registries is handled client side. The client has to send authentication details to various endpoints that need to communicate with registries, such as `POST /images/(name)/push`. These are sent as `X-Registry-Auth` header as a [base64url encoded](https://tools.ietf.org/html/rfc4648#section-5) (JSON) string with the following structure:  ``` {   \"username\": \"string\",   \"password\": \"string\",   \"email\": \"string\",   \"serveraddress\": \"string\" } ```  The `serveraddress` is a domain/IP without a protocol. Throughout this structure, double quotes are required.  If you have already got an identity token from the [`/auth` endpoint](#operation/SystemAuth), you can just pass this instead of credentials:  ``` {   \"identitytoken\": \"9cbaf023786cd7...\" } ``` 
# The version of the OpenAPI document: 1.41
# 
# Generated by: https://openapi-generator.tech
#


import model_host_config_all_of_log_config
import tables
import model_mount
import model_port_binding
import model_restart_policy

# type CgroupnsMode* {.pure.} = enum
#   Private
#   Host

# type Isolation* {.pure.} = enum
#   Default
#   Process
#   Hyperv

type CgroupnsMode* {.pure.} = enum
  Private = "private"
  Host = "host"

type Isolation* {.pure.} = enum
  Default = "default"
  Process = "process"
  Hyperv = "hyperv"

type HostConfigAllOf* = object
  ## 
  binds*: seq[string] ## A list of volume bindings for this container. Each volume binding is a string in one of these forms:  - `host-src:container-dest[:options]` to bind-mount a host path   into the container. Both `host-src`, and `container-dest` must   be an _absolute_ path. - `volume-name:container-dest[:options]` to bind-mount a volume   managed by a volume driver into the container. `container-dest`   must be an _absolute_ path.  `options` is an optional, comma-delimited list of:  - `nocopy` disables automatic copying of data from the container   path to the volume. The `nocopy` flag only applies to named volumes. - `[ro|rw]` mounts a volume read-only or read-write, respectively.   If omitted or set to `rw`, volumes are mounted read-write. - `[z|Z]` applies SELinux labels to allow or deny multiple containers   to read and write to the same volume.     - `z`: a _shared_ content label is applied to the content. This       label indicates that multiple containers can share the volume       content, for both reading and writing.     - `Z`: a _private unshared_ label is applied to the content.       This label indicates that only the current container can use       a private volume. Labeling systems such as SELinux require       proper labels to be placed on volume content that is mounted       into a container. Without a label, the security system can       prevent a container's processes from using the content. By       default, the labels set by the host operating system are not       modified. - `[[r]shared|[r]slave|[r]private]` specifies mount   [propagation behavior](https://www.kernel.org/doc/Documentation/filesystems/sharedsubtree.txt).   This only applies to bind-mounted volumes, not internal volumes   or named volumes. Mount propagation requires the source mount   point (the location where the source directory is mounted in the   host operating system) to have the correct propagation properties.   For shared volumes, the source mount point must be set to `shared`.   For slave volumes, the mount must be set to either `shared` or   `slave`. 
  containerIDFile*: string ## Path to a file where the container ID is written
  logConfig*: HostConfig_allOf_LogConfig
  networkMode*: string ## Network mode to use for this container. Supported standard values are: `bridge`, `host`, `none`, and `container:<name|id>`. Any other value is taken as a custom network's name to which this container should connect to. 
  portBindings*: Table[string, seq[PortBinding]] ## PortMap describes the mapping of container ports to host ports, using the container's port-number and protocol as key in the format `<port>/<protocol>`, for example, `80/udp`.  If a container's port is mapped for multiple protocols, separate entries are added to the mapping table. 
  restartPolicy*: RestartPolicy
  autoRemove*: bool ## Automatically remove the container when the container's process exits. This has no effect if `RestartPolicy` is set. 
  volumeDriver*: string ## Driver that this container uses to mount volumes.
  volumesFrom*: seq[string] ## A list of volumes to inherit from another container, specified in the form `<container name>[:<ro|rw>]`. 
  mounts*: seq[Mount] ## Specification for mounts to be added to the container. 
  capAdd*: seq[string] ## A list of kernel capabilities to add to the container. Conflicts with option 'Capabilities'. 
  capDrop*: seq[string] ## A list of kernel capabilities to drop from the container. Conflicts with option 'Capabilities'. 
  cgroupnsMode*: CgroupnsMode ## cgroup namespace mode for the container. Possible values are:  - `\"private\"`: the container runs in its own private cgroup namespace - `\"host\"`: use the host system's cgroup namespace  If not specified, the daemon default is used, which can either be `\"private\"` or `\"host\"`, depending on daemon version, kernel support and configuration. 
  dns*: seq[string] ## A list of DNS servers for the container to use.
  dnsOptions*: seq[string] ## A list of DNS options.
  dnsSearch*: seq[string] ## A list of DNS search domains.
  extraHosts*: seq[string] ## A list of hostnames/IP mappings to add to the container's `/etc/hosts` file. Specified in the form `[\"hostname:IP\"]`. 
  groupAdd*: seq[string] ## A list of additional groups that the container process will run as. 
  ipcMode*: string ## IPC sharing mode for the container. Possible values are:  - `\"none\"`: own private IPC namespace, with /dev/shm not mounted - `\"private\"`: own private IPC namespace - `\"shareable\"`: own private IPC namespace, with a possibility to share it with other containers - `\"container:<name|id>\"`: join another (shareable) container's IPC namespace - `\"host\"`: use the host system's IPC namespace  If not specified, daemon default is used, which can either be `\"private\"` or `\"shareable\"`, depending on daemon version and configuration. 
  cgroup*: string ## Cgroup to use for the container.
  links*: seq[string] ## A list of links for the container in the form `container_name:alias`. 
  oomScoreAdj*: int ## An integer value containing the score given to the container in order to tune OOM killer preferences. 
  pidMode*: string ## Set the PID (Process) Namespace mode for the container. It can be either:  - `\"container:<name|id>\"`: joins another container's PID namespace - `\"host\"`: use the host's PID namespace inside the container 
  privileged*: bool ## Gives the container full access to the host.
  publishAllPorts*: bool ## Allocates an ephemeral host port for all of a container's exposed ports.  Ports are de-allocated when the container stops and allocated when the container starts. The allocated port might be changed when restarting the container.  The port is selected from the ephemeral port range that depends on the kernel. For example, on Linux the range is defined by `/proc/sys/net/ipv4/ip_local_port_range`. 
  readonlyRootfs*: bool ## Mount the container's root filesystem as read only.
  securityOpt*: seq[string] ## A list of string values to customize labels for MLS systems, such as SELinux. 
  storageOpt*: Table[string, string] ## Storage driver options for this container, in the form `{\"size\": \"120G\"}`. 
  tmpfs*: Table[string, string] ## A map of container directories which should be replaced by tmpfs mounts, and their corresponding mount options. For example:  ``` { \"/run\": \"rw,noexec,nosuid,size=65536k\" } ``` 
  uTSMode*: string ## UTS namespace to use for the container.
  usernsMode*: string ## Sets the usernamespace mode for the container when usernamespace remapping option is enabled. 
  shmSize*: int ## Size of `/dev/shm` in bytes. If omitted, the system uses 64MB. 
  sysctls*: Table[string, string] ## A list of kernel parameters (sysctls) to set in the container. For example:  ``` {\"net.ipv4.ip_forward\": \"1\"} ``` 
  runtime*: string ## Runtime to use with this container.
  consoleSize*: seq[int] ## Initial console size, as an `[height, width]` array. (Windows only) 
  isolation*: Isolation ## Isolation technology of the container. (Windows only) 
  maskedPaths*: seq[string] ## The list of paths to be masked inside the container (this overrides the default set of paths). 
  readonlyPaths*: seq[string] ## The list of paths to be set as read-only inside the container (this overrides the default set of paths). 

# func `%`*(v: CgroupnsMode): JsonNode =
#   let str = case v:
#     of CgroupnsMode.Private: "private"
#     of CgroupnsMode.Host: "host"

#   JsonNode(kind: JString, str: str)

# func `$`*(v: CgroupnsMode): string =
#   result = case v:
#     of CgroupnsMode.Private: "private"
#     of CgroupnsMode.Host: "host"

# func `%`*(v: Isolation): JsonNode =
#   let str = case v:
#     of Isolation.Default: "default"
#     of Isolation.Process: "process"
#     of Isolation.Hyperv: "hyperv"

#   JsonNode(kind: JString, str: str)

# func `$`*(v: Isolation): string =
#   result = case v:
#     of Isolation.Default: "default"
#     of Isolation.Process: "process"
#     of Isolation.Hyperv: "hyperv"