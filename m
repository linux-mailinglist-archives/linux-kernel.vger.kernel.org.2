Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411313B95C2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 19:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhGASBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 14:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:32990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229844AbhGASBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 14:01:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C94E613DD;
        Thu,  1 Jul 2021 17:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625162345;
        bh=38IVHmfcHjvmyK++pyTnP0a07T1mByqOx5BYQ6GVlcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ENZRel84fJHl6pLDkKR6VXPef6PG95Qk6LzNpF3K2qft8haCMP82OnlhpaMUQEbw1
         tsLwwEN8z2uSGWIRt7D0sRaooqx+YeFTwMq15kkKD8YK0II3zhy31rSIwWqPMCAiSk
         RZ6RSs0SGgjySoEAgdN6TZD9RoSAuSlMm/e/BEUgsKYfNGWSe3wMcuSKXmnz8ZHJp+
         bYXgsCY6NngkkEw7HHxoLrOihQmKHRx34rf4turS22oEV8Arh4ECfKY/qjz8QZvjjW
         VSvILrHWzL4gzE50GtTYAT5thQaW7riIqu5kqwY/ku9YTn5AEfACIz6fFoz8htMocE
         rtByghrRUrxmw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 186B540B1A; Thu,  1 Jul 2021 14:59:02 -0300 (-03)
Date:   Thu, 1 Jul 2021 14:59:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH 1/4] perf tools: Add read_cgroup_id() function
Message-ID: <YN4CZbkN5ZrKHXo/@kernel.org>
References: <20210625071826.608504-1-namhyung@kernel.org>
 <20210625071826.608504-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625071826.608504-2-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 25, 2021 at 12:18:23AM -0700, Namhyung Kim escreveu:
> The read_cgroup_id() is to read a cgroup id from a file handle using
> name_to_handle_at(2) for the given cgroup.  It'll be used by bperf
> cgroup stat later.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/cgroup.c | 25 +++++++++++++++++++++++++
>  tools/perf/util/cgroup.h |  9 +++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> index f24ab4585553..ef18c988c681 100644
> --- a/tools/perf/util/cgroup.c
> +++ b/tools/perf/util/cgroup.c
> @@ -45,6 +45,31 @@ static int open_cgroup(const char *name)
>  	return fd;
>  }
>  
> +#ifdef HAVE_FILE_HANDLE
> +int read_cgroup_id(struct cgroup *cgrp)
> +{
> +	char path[PATH_MAX + 1];
> +	char mnt[PATH_MAX + 1];
> +	struct {
> +		struct file_handle fh;
> +		uint64_t cgroup_id;
> +	} handle;
> +	int mount_id;
> +
> +	if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1, "perf_event"))
> +		return -1;
> +
> +	scnprintf(path, PATH_MAX, "%s/%s", mnt, cgrp->name);
> +
> +	handle.fh.handle_bytes = sizeof(handle.cgroup_id);
> +	if (name_to_handle_at(AT_FDCWD, path, &handle.fh, &mount_id, 0) < 0)
> +		return -1;
> +
> +	cgrp->id = handle.cgroup_id;
> +	return 0;
> +}
> +#endif  /* HAVE_FILE_HANDLE */
> +
>  static struct cgroup *evlist__find_cgroup(struct evlist *evlist, const char *str)
>  {
>  	struct evsel *counter;
> diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
> index 162906f3412a..707adbe25123 100644
> --- a/tools/perf/util/cgroup.h
> +++ b/tools/perf/util/cgroup.h
> @@ -38,4 +38,13 @@ struct cgroup *cgroup__find(struct perf_env *env, uint64_t id);
>  
>  void perf_env__purge_cgroups(struct perf_env *env);
>  
> +#ifdef HAVE_FILE_HANDLE
> +int read_cgroup_id(struct cgroup *cgrp);
> +#else
> +int read_cgroup_id(struct cgroup *cgrp)
> +{
> +	return -1;
> +}
> +#endif  /* HAVE_FILE_HANDLE */
> +
>  #endif /* __CGROUP_H__ */
> -- 
> 2.32.0.93.g670b81a890-goog
> 


You forgot the __maybe_unused in the !HAVE_FILE_HANDLE case, also the
static inline for functions defined in headers, I'm fixing this up:

Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
Target: x86_64-alpine-linux-musl
Thread model: posix
InstalledDir: /usr/bin
Found candidate GCC installation: /usr/bin/../lib/gcc/x86_64-alpine-linux-musl/8.3.0
Found candidate GCC installation: /usr/lib/gcc/x86_64-alpine-linux-musl/8.3.0
Selected GCC installation: /usr/bin/../lib/gcc/x86_64-alpine-linux-musl/8.3.0
Candidate multilib: .;@m64
Selected multilib: .;@m64
+ rm -rf /tmp/build/perf
+ mkdir /tmp/build/perf
+ make 'ARCH=' 'CROSS_COMPILE=' 'EXTRA_CFLAGS=' -C tools/perf 'O=/tmp/build/perf' 'CC=clang'
make: Entering directory '/git/perf-5.13.0/tools/perf'
  BUILD:   Doing 'make -j24' parallel build
  HOSTCC  /tmp/build/perf/fixdep.o
  HOSTLD  /tmp/build/perf/fixdep-in.o
  LINK    /tmp/build/perf/fixdep
Makefile.config:439: No libdw DWARF unwind found, Please install elfutils-devel/libdw-dev >= 0.158 and/or set LIBDW_DIR
Makefile.config:444: No libdw.h found or old libdw.h found or elfutils is older than 0.138, disables dwarf support. Please install new elfutils-devel/libdw-dev
Makefile.config:563: DWARF support is off, BPF prologue is disabled
Makefile.config:571: No sys/sdt.h found, no SDT events are defined, please install systemtap-sdt-devel or systemtap-sdt-dev
Makefile.config:998: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:1024: No alternatives command found, you need to set JDIR= to point to the root of your Java directory

Auto-detecting system features:
...                         dwarf: [ OFF ]
...            dwarf_getlocations: [ OFF ]
...                         glibc: [ OFF ]
...                        libbfd: [ on  ]
...                libbfd-buildid: [ on  ]
...                        libcap: [ on  ]
...                        libelf: [ on  ]
...                       libnuma: [ on  ]
...        numa_num_possible_cpus: [ on  ]
...                       libperl: [ on  ]
...                     libpython: [ on  ]
...                     libcrypto: [ on  ]
...                     libunwind: [ on  ]
...            libdw-dwarf-unwind: [ OFF ]
...                          zlib: [ on  ]
...                          lzma: [ on  ]
...                     get_cpuid: [ on  ]
...                           bpf: [ on  ]
...                        libaio: [ on  ]
...                       libzstd: [ on  ]
...        disassembler-four-args: [ on  ]


  GEN     /tmp/build/perf/common-cmds.h
  PERF_VERSION = 5.13.gfdf19665b1fb
  MKDIR   /tmp/build/perf/pmu-events/
  MKDIR   /tmp/build/perf/pmu-events/
  MKDIR   /tmp/build/perf/pmu-events/
  HOSTCC  /tmp/build/perf/pmu-events/json.o
  HOSTCC  /tmp/build/perf/pmu-events/jsmn.o
  HOSTCC  /tmp/build/perf/pmu-events/jevents.o
  GEN     perf-archive
  GEN     perf-with-kcore
  GEN     perf-iostat
  CC      /tmp/build/perf/exec-cmd.o
  CC      /tmp/build/perf/help.o
  CC      /tmp/build/perf/pager.o
  CC      /tmp/build/perf/parse-options.o
  CC      /tmp/build/perf/run-command.o
  CC      /tmp/build/perf/sigchain.o
  CC      /tmp/build/perf/subcmd-config.o
  CC      /tmp/build/perf/cpu.o
  CC      /tmp/build/perf/debug.o
  MKDIR   /tmp/build/perf/fd/
  MKDIR   /tmp/build/perf/fs/
  CC      /tmp/build/perf/str_error_r.o
  MKDIR   /tmp/build/perf/fs/
  CC      /tmp/build/perf/fd/array.o
  MKDIR   /tmp/build/perf/fs/
  CC      /tmp/build/perf/fs/fs.o
  CC      /tmp/build/perf/fs/tracing_path.o
  CC      /tmp/build/perf/fs/cgroup.o
  CC      /tmp/build/perf/event-parse.o
  CC      /tmp/build/perf/event-plugin.o
  CC      /tmp/build/perf/trace-seq.o
  CC      /tmp/build/perf/parse-filter.o
  CC      /tmp/build/perf/parse-utils.o
  CC      /tmp/build/perf/kbuffer-parse.o
  CC      /tmp/build/perf/core.o
  CC      /tmp/build/perf/cpumap.o
  GEN     /tmp/build/perf/bpf_helper_defs.h
  CC      /tmp/build/perf/threadmap.o
  CC      /tmp/build/perf/evsel.o
  LD      /tmp/build/perf/fd/libapi-in.o
  CC      /tmp/build/perf/tep_strerror.o
  CC      /tmp/build/perf/plugin_jbd2.o
  CC      /tmp/build/perf/plugin_hrtimer.o
  CC      /tmp/build/perf/event-parse-api.o
  HOSTLD  /tmp/build/perf/pmu-events/jevents-in.o
  CC      /tmp/build/perf/plugin_kvm.o
  CC      /tmp/build/perf/plugin_kmem.o
  LINK    /tmp/build/perf/pmu-events/jevents
  CC      /tmp/build/perf/evlist.o
  CC      /tmp/build/perf/mmap.o
  LD      /tmp/build/perf/fs/libapi-in.o
  CC      /tmp/build/perf/plugin_mac80211.o
  GEN     /tmp/build/perf/pmu-events/pmu-events.c
  CC      /tmp/build/perf/zalloc.o
  LD      /tmp/build/perf/libapi-in.o
  AR      /tmp/build/perf/libapi.a
  CC      /tmp/build/perf/xyarray.o
  CC      /tmp/build/perf/lib.o
  CC      /tmp/build/perf/plugin_sched_switch.o
  LD      /tmp/build/perf/plugin_kmem-in.o
  LD      /tmp/build/perf/plugin_jbd2-in.o
  CC      /tmp/build/perf/plugin_function.o
  LD      /tmp/build/perf/plugin_hrtimer-in.o
  CC      /tmp/build/perf/plugin_futex.o
  CC      /tmp/build/perf/plugin_scsi.o
  CC      /tmp/build/perf/plugin_cfg80211.o
  LD      /tmp/build/perf/plugin_kvm-in.o
  MKDIR   /tmp/build/perf/staticobjs/
  CC      /tmp/build/perf/staticobjs/libbpf.o
  CC      /tmp/build/perf/plugin_xen.o
  MKDIR   /tmp/build/perf/staticobjs/
  CC      /tmp/build/perf/staticobjs/bpf.o
  CC      /tmp/build/perf/plugin_tlb.o
  CC      /tmp/build/perf/staticobjs/nlattr.o
  CC      /tmp/build/perf/staticobjs/btf.o
  LD      /tmp/build/perf/plugin_mac80211-in.o
  CC      /tmp/build/perf/staticobjs/libbpf_errno.o
  CC      /tmp/build/perf/staticobjs/str_error.o
  LD      /tmp/build/perf/plugin_sched_switch-in.o
  LINK    /tmp/build/perf/plugin_jbd2.so
  CC      /tmp/build/perf/staticobjs/netlink.o
  CC      /tmp/build/perf/staticobjs/bpf_prog_linfo.o
  CC      /tmp/build/perf/staticobjs/libbpf_probes.o
  LD      /tmp/build/perf/plugin_function-in.o
  LD      /tmp/build/perf/plugin_cfg80211-in.o
  LD      /tmp/build/perf/plugin_futex-in.o
  LD      /tmp/build/perf/plugin_xen-in.o
  LINK    /tmp/build/perf/plugin_hrtimer.so
  LINK    /tmp/build/perf/plugin_kmem.so
  LD      /tmp/build/perf/plugin_scsi-in.o
  LINK    /tmp/build/perf/plugin_kvm.so
  LINK    /tmp/build/perf/plugin_mac80211.so
  LINK    /tmp/build/perf/plugin_sched_switch.so
  LD      /tmp/build/perf/plugin_tlb-in.o
  LINK    /tmp/build/perf/plugin_futex.so
  LINK    /tmp/build/perf/plugin_function.so
  CC      /tmp/build/perf/staticobjs/xsk.o
  CC      /tmp/build/perf/staticobjs/hashmap.o
  LINK    /tmp/build/perf/plugin_xen.so
  LINK    /tmp/build/perf/plugin_scsi.so
  CC      /tmp/build/perf/staticobjs/btf_dump.o
  LINK    /tmp/build/perf/plugin_tlb.so
  LINK    /tmp/build/perf/plugin_cfg80211.so
  CC      /tmp/build/perf/staticobjs/ringbuf.o
  CC      /tmp/build/perf/staticobjs/strset.o
  CC      /tmp/build/perf/staticobjs/linker.o
  GEN     /tmp/build/perf/libtraceevent-dynamic-list
  CC      /tmp/build/perf/pmu-events/pmu-events.o
  LD      /tmp/build/perf/libsubcmd-in.o
  AR      /tmp/build/perf/libsubcmd.a
  LD      /tmp/build/perf/libperf-in.o
  AR      /tmp/build/perf/libperf.a
  LD      /tmp/build/perf/libtraceevent-in.o
  LINK    /tmp/build/perf/libtraceevent.a
  GEN     /tmp/build/perf/python/perf.so
  CC      /tmp/build/perf/builtin-bench.o
  CC      /tmp/build/perf/builtin-annotate.o
  CC      /tmp/build/perf/builtin-config.o
  CC      /tmp/build/perf/builtin-diff.o
  CC      /tmp/build/perf/builtin-evlist.o
  CC      /tmp/build/perf/builtin-ftrace.o
  CC      /tmp/build/perf/builtin-help.o
  CC      /tmp/build/perf/builtin-sched.o
  CC      /tmp/build/perf/builtin-buildid-list.o
  CC      /tmp/build/perf/builtin-buildid-cache.o
  CC      /tmp/build/perf/builtin-kallsyms.o
  CC      /tmp/build/perf/builtin-list.o
  CC      /tmp/build/perf/builtin-record.o
  CC      /tmp/build/perf/builtin-report.o
  CC      /tmp/build/perf/builtin-stat.o
  CC      /tmp/build/perf/builtin-timechart.o
  CC      /tmp/build/perf/builtin-top.o
  CC      /tmp/build/perf/builtin-script.o
  CC      /tmp/build/perf/builtin-kmem.o
In file included from builtin-top.c:25:
/git/perf-5.13.0/tools/perf/util/cgroup.h:44:35: error: unused parameter 'cgrp' [-Werror,-Wunused-parameter]
int read_cgroup_id(struct cgroup *cgrp)
                                  ^
/git/perf-5.13.0/tools/perf/util/cgroup.h:44:5: error: no previous prototype for function 'read_cgroup_id' [-Werror,-Wmissing-prototypes]
int read_cgroup_id(struct cgroup *cgrp)
    ^
In file included from builtin-stat.c:45:
/git/perf-5.13.0/tools/perf/util/cgroup.h:44:35: error: unused parameter 'cgrp' [-Werror,-Wunused-parameter]
int read_cgroup_id(struct cgroup *cgrp)
                                  ^
/git/perf-5.13.0/tools/perf/util/cgroup.h:44:5: error: no previous prototype for function 'read_cgroup_id' [-Werror,-Wmissing-prototypes]
int read_cgroup_id(struct cgroup *cgrp)
    ^
In file included from builtin-record.c:17:
/git/perf-5.13.0/tools/perf/util/cgroup.h:44:35: error: unused parameter 'cgrp' [-Werror,-Wunused-parameter]
int read_cgroup_id(struct cgroup *cgrp)
                                  ^
/git/perf-5.13.0/tools/perf/util/cgroup.h:44:5: error: no previous prototype for function 'read_cgroup_id' [-Werror,-Wmissing-prototypes]
int read_cgroup_id(struct cgroup *cgrp)
    ^
  CC      /tmp/build/perf/builtin-lock.o
  CC      /tmp/build/perf/builtin-kvm.o
  CC      /tmp/build/perf/builtin-mem.o
  CC      /tmp/build/perf/builtin-data.o
  CC      /tmp/build/perf/builtin-version.o
  CC      /tmp/build/perf/builtin-inject.o
2 errors generated.
make[3]: *** [/git/perf-5.13.0/tools/build/Makefile.build:97: /tmp/build/perf/builtin-record.o] Error 1
make[3]: *** Waiting for unfinished jobs....
2 errors generated.
make[3]: *** [/git/perf-5.13.0/tools/build/Makefile.build:97: /tmp/build/perf/builtin-top.o] Error 1
2 errors generated.
make[3]: *** [/git/perf-5.13.0/tools/build/Makefile.build:97: /tmp/build/perf/builtin-stat.o] Error 1
  LD      /tmp/build/perf/pmu-events/pmu-events-in.o
In file included from /git/perf-5.13.0/tools/perf/util/evsel.c:30:
/git/perf-5.13.0/tools/perf/util/cgroup.h:44:5: error: no previous prototype for function 'read_cgroup_id' [-Werror,-Wmissing-prototypes]

