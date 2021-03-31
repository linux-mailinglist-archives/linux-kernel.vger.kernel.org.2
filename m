Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90032345E49
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhCWMh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:37:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230258AbhCWMhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:37:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A531E6157F;
        Tue, 23 Mar 2021 12:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616503065;
        bh=yPklveboAIAFds3NtCnjUcZpdz+bhgb3n6F2xoXKgAE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lzOicV2s3Ao1DWxfjsue4GHcUGwqWI4yC8PqwcUC6YiVLsRRLtPtCBeELqFz5nIIp
         oN4fAXMLgTcvmoCywwGp7peGieE+yNXj+Vgi1Ztkcv7RI2z9C0uLztVJxKAJjnEd5H
         zmz94T+58+yie7zpspOwlZ8dawr0QFz+Gal+FjkHYPqZV5dVRsDVEbObqKZGdwcuR/
         TQUbH654BVYNYHbfRMgGTiwrlLFGxDpNsUn93/mrpf7SA6P6EPAVYFAtgQXLKX91Hm
         Tkb4M1OJicHv/nLv3kAF+IR4AJcPcT224CJPfMSYbtaueNHWnTS+hZ2FmfgJMirLWU
         KVmaxBoisjtHw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A6E7640647; Tue, 23 Mar 2021 09:37:42 -0300 (-03)
Date:   Tue, 23 Mar 2021 09:37:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, acme@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org
Subject: Re: [PATCH v2 1/3] perf-stat: introduce bperf, share hardware PMCs
 with BPF
Message-ID: <YFnhFugY4wmchhwi@kernel.org>
References: <20210316211837.910506-1-songliubraving@fb.com>
 <20210316211837.910506-2-songliubraving@fb.com>
 <YFPC4UbLWzTuzyER@krava>
 <YFTwdWxUvqHDNe1x@kernel.org>
 <YFneUHDiAt8Rg0cc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFneUHDiAt8Rg0cc@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 23, 2021 at 09:25:52AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Mar 19, 2021 at 03:41:57PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Mar 18, 2021 at 10:15:13PM +0100, Jiri Olsa escreveu:
> > > On Tue, Mar 16, 2021 at 02:18:35PM -0700, Song Liu wrote:
> > > > bperf is off by default. To enable it, pass --bpf-counters option to
> > > > perf-stat. bperf uses a BPF hashmap to share information about BPF
> > > > programs and maps used by bperf. This map is pinned to bpffs. The default
> > > > path is /sys/fs/bpf/perf_attr_map. The user could change the path with
> > > > option --bpf-attr-map.
> > > > 
> > > > Signed-off-by: Song Liu <songliubraving@fb.com>
> > > 
> > > Reviewed-by: Jiri Olsa <jolsa@redhat.com>
> > 
> > After applying just this first patch in the series I'm getting this
> > after a 'make -C tools/ clean', now I'm checking if I need some new
> > clang, ideas?
> 
> Works now with clang from fedora 33, I was using a locally built, older,
> now I get this when trying as non-root, expected, but we need to improve
> the wording.

Fails as root as well, investigating:

[root@five ~]# ls -lad /sys/fs/bpf/
drwx-----T. 2 root root 0 Mar 23 06:03 /sys/fs/bpf/
[root@five ~]# strace -e bpf perf stat --bpf-counters sleep 1
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=120, value_size=8, max_entries=16, map_flags=0, inner_map_fd=0, map_name="", map_ifindex=0, btf_fd=0, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = -1 EPERM (Operation not permitted)
Failed to lock perf_event_attr map
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_KILLED, si_pid=13916, si_uid=0, si_status=SIGTERM, si_utime=0, si_stime=0} ---
+++ exited with 255 +++
[root@five ~]#
 
> [acme@five perf]$ perf stat --bpf-counters sleep 1
> Failed to lock perf_event_attr map
> [acme@five perf]$
>  
> > - Arnaldo
> > 
> > [acme@quaco perf]$ make O=/tmp/build/perf -C tools/perf BUILD_BPF_SKEL=1 PYTHON=python3 install-bin
> > make: Entering directory '/home/acme/git/perf/tools/perf'
> >   BUILD:   Doing 'make -j8' parallel build
> > Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
> > diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
> > Warning: Kernel ABI header at 'tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl' differs from latest version at 'arch/mips/kernel/syscalls/syscall_n64.tbl'
> > diff -u tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl arch/mips/kernel/syscalls/syscall_n64.tbl
> > 
> > Auto-detecting system features:
> > ...                         dwarf: [ on  ]
> > ...            dwarf_getlocations: [ on  ]
> > ...                         glibc: [ on  ]
> > ...                        libbfd: [ on  ]
> > ...                libbfd-buildid: [ on  ]
> > ...                        libcap: [ on  ]
> > ...                        libelf: [ on  ]
> > ...                       libnuma: [ on  ]
> > ...        numa_num_possible_cpus: [ on  ]
> > ...                       libperl: [ on  ]
> > ...                     libpython: [ on  ]
> > ...                     libcrypto: [ on  ]
> > ...                     libunwind: [ on  ]
> > ...            libdw-dwarf-unwind: [ on  ]
> > ...                          zlib: [ on  ]
> > ...                          lzma: [ on  ]
> > ...                     get_cpuid: [ on  ]
> > ...                           bpf: [ on  ]
> > ...                        libaio: [ on  ]
> > ...                       libzstd: [ on  ]
> > ...        disassembler-four-args: [ on  ]
> > 
> >   GEN      /tmp/build/perf/common-cmds.h
> >   CC       /tmp/build/perf/exec-cmd.o
> >   MKDIR    /tmp/build/perf/fd/
> >   MKDIR    /tmp/build/perf/fs/
> >   CC       /tmp/build/perf/fs/fs.o
> >   CC       /tmp/build/perf/event-parse.o
> >   CC       /tmp/build/perf/fd/array.o
> >   CC       /tmp/build/perf/core.o
> >   GEN      /tmp/build/perf/bpf_helper_defs.h
> >   CC       /tmp/build/perf/event-plugin.o
> >   MKDIR    /tmp/build/perf/staticobjs/
> >   PERF_VERSION = 5.12.rc2.g3df07f57f205
> >   CC       /tmp/build/perf/staticobjs/libbpf.o
> >   CC       /tmp/build/perf/cpu.o
> >   LD       /tmp/build/perf/fd/libapi-in.o
> >   CC       /tmp/build/perf/cpumap.o
> >   CC       /tmp/build/perf/help.o
> >   MKDIR    /tmp/build/perf/fs/
> >   CC       /tmp/build/perf/fs/tracing_path.o
> >   CC       /tmp/build/perf/fs/cgroup.o
> >   CC       /tmp/build/perf/trace-seq.o
> >   CC       /tmp/build/perf/pager.o
> >   CC       /tmp/build/perf/parse-options.o
> >   LD       /tmp/build/perf/fs/libapi-in.o
> >   CC       /tmp/build/perf/debug.o
> >   CC       /tmp/build/perf/str_error_r.o
> >   CC       /tmp/build/perf/run-command.o
> >   CC       /tmp/build/perf/sigchain.o
> >   LD       /tmp/build/perf/libapi-in.o
> >   AR       /tmp/build/perf/libapi.a
> >   CC       /tmp/build/perf/subcmd-config.o
> >   CC       /tmp/build/perf/threadmap.o
> >   CC       /tmp/build/perf/evsel.o
> >   CC       /tmp/build/perf/parse-filter.o
> >   MKDIR    /tmp/build/perf/staticobjs/
> >   CC       /tmp/build/perf/staticobjs/bpf.o
> >   CC       /tmp/build/perf/evlist.o
> >   CC       /tmp/build/perf/parse-utils.o
> >   CC       /tmp/build/perf/kbuffer-parse.o
> >   CC       /tmp/build/perf/tep_strerror.o
> >   CC       /tmp/build/perf/mmap.o
> >   CC       /tmp/build/perf/zalloc.o
> >   CC       /tmp/build/perf/event-parse-api.o
> >   LD       /tmp/build/perf/libsubcmd-in.o
> >   AR       /tmp/build/perf/libsubcmd.a
> >   CC       /tmp/build/perf/xyarray.o
> >   LD       /tmp/build/perf/libtraceevent-in.o
> >   LINK     /tmp/build/perf/libtraceevent.a
> >   CC       /tmp/build/perf/staticobjs/nlattr.o
> >   CC       /tmp/build/perf/staticobjs/btf.o
> >   CC       /tmp/build/perf/lib.o
> >   CC       /tmp/build/perf/staticobjs/libbpf_errno.o
> >   CC       /tmp/build/perf/staticobjs/str_error.o
> >   CC       /tmp/build/perf/staticobjs/netlink.o
> >   CC       /tmp/build/perf/staticobjs/bpf_prog_linfo.o
> >   CC       /tmp/build/perf/staticobjs/libbpf_probes.o
> >   LD       /tmp/build/perf/libperf-in.o
> >   AR       /tmp/build/perf/libperf.a
> >   MKDIR    /tmp/build/perf/pmu-events/
> >   HOSTCC   /tmp/build/perf/pmu-events/json.o
> >   CC       /tmp/build/perf/plugin_jbd2.o
> >   CC       /tmp/build/perf/staticobjs/xsk.o
> >   MKDIR    /tmp/build/perf/pmu-events/
> >   HOSTCC   /tmp/build/perf/pmu-events/jsmn.o
> >   CC       /tmp/build/perf/staticobjs/hashmap.o
> >   LD       /tmp/build/perf/plugin_jbd2-in.o
> >   CC       /tmp/build/perf/staticobjs/btf_dump.o
> >   CC       /tmp/build/perf/plugin_hrtimer.o
> >   HOSTCC   /tmp/build/perf/pmu-events/jevents.o
> >   LD       /tmp/build/perf/plugin_hrtimer-in.o
> >   CC       /tmp/build/perf/plugin_kmem.o
> >   CC       /tmp/build/perf/staticobjs/ringbuf.o
> >   LD       /tmp/build/perf/plugin_kmem-in.o
> >   CC       /tmp/build/perf/plugin_kvm.o
> >   HOSTLD   /tmp/build/perf/pmu-events/jevents-in.o
> >   CC       /tmp/build/perf/perf-read-vdso32
> >   CC       /tmp/build/perf/plugin_mac80211.o
> >   LD       /tmp/build/perf/plugin_kvm-in.o
> >   CC       /tmp/build/perf/plugin_sched_switch.o
> >   CC       /tmp/build/perf/plugin_function.o
> >   MKDIR    /tmp/build/perf/jvmti/
> >   CC       /tmp/build/perf/jvmti/libjvmti.o
> >   LD       /tmp/build/perf/plugin_mac80211-in.o
> >   GEN      perf-archive
> >   LD       /tmp/build/perf/plugin_sched_switch-in.o
> >   CC       /tmp/build/perf/plugin_futex.o
> >   CC       /tmp/build/perf/plugin_xen.o
> >   CC       /tmp/build/perf/plugin_scsi.o
> >   LD       /tmp/build/perf/plugin_function-in.o
> >   CC       /tmp/build/perf/plugin_cfg80211.o
> >   LD       /tmp/build/perf/plugin_futex-in.o
> >   LD       /tmp/build/perf/plugin_xen-in.o
> >   LINK     /tmp/build/perf/plugin_jbd2.so
> >   LINK     /tmp/build/perf/plugin_hrtimer.so
> >   CC       /tmp/build/perf/plugin_tlb.o
> >   LINK     /tmp/build/perf/plugin_kmem.so
> >   LINK     /tmp/build/perf/plugin_kvm.so
> >   LD       /tmp/build/perf/plugin_scsi-in.o
> >   LINK     /tmp/build/perf/plugin_mac80211.so
> >   LINK     /tmp/build/perf/plugin_sched_switch.so
> >   LINK     /tmp/build/perf/plugin_function.so
> >   LINK     /tmp/build/perf/plugin_futex.so
> >   LD       /tmp/build/perf/plugin_cfg80211-in.o
> >   LINK     /tmp/build/perf/plugin_xen.so
> >   LINK     /tmp/build/perf/plugin_scsi.so
> >   LD       /tmp/build/perf/plugin_tlb-in.o
> >   MKDIR    /tmp/build/perf/jvmti/
> >   LINK     /tmp/build/perf/plugin_cfg80211.so
> >   CC       /tmp/build/perf/jvmti/jvmti_agent.o
> >   LINK     /tmp/build/perf/plugin_tlb.so
> >   GEN      perf-with-kcore
> >   CC       /tmp/build/perf/jvmti/libstring.o
> > CFLAGS= make -C ../bpf/bpftool \
> > 	OUTPUT=/tmp/build/perf/util/bpf_skel/.tmp/ bootstrap
> >   CC       /tmp/build/perf/jvmti/libctype.o
> >   GEN      /tmp/build/perf/libtraceevent-dynamic-list
> >   LINK     /tmp/build/perf/pmu-events/jevents
> >   DESCEND  plugins
> >   GEN      /tmp/build/perf/python/perf.so
> >   GEN      /tmp/build/perf/pmu-events/pmu-events.c
> >   CC       /tmp/build/perf/plugins/plugin_jbd2.o
> >   CC       /tmp/build/perf/plugins/plugin_hrtimer.o
> >   LD       /tmp/build/perf/plugins/plugin_jbd2-in.o
> >   LD       /tmp/build/perf/plugins/plugin_hrtimer-in.o
> >   CC       /tmp/build/perf/plugins/plugin_kmem.o
> >   CC       /tmp/build/perf/plugins/plugin_kvm.o
> >   LD       /tmp/build/perf/jvmti/jvmti-in.o
> >   LD       /tmp/build/perf/plugins/plugin_kmem-in.o
> >   LINK     /tmp/build/perf/libperf-jvmti.so
> >   CC       /tmp/build/perf/plugins/plugin_mac80211.o
> >   CC       /tmp/build/perf/plugins/plugin_sched_switch.o
> >   CC       /tmp/build/perf/pmu-events/pmu-events.o
> >   LD       /tmp/build/perf/plugins/plugin_kvm-in.o
> >   CC       /tmp/build/perf/plugins/plugin_function.o
> >   LD       /tmp/build/perf/plugins/plugin_mac80211-in.o
> >   CC       /tmp/build/perf/plugins/plugin_futex.o
> >   LD       /tmp/build/perf/plugins/plugin_sched_switch-in.o
> >   CC       /tmp/build/perf/plugins/plugin_xen.o
> >   LD       /tmp/build/perf/plugins/plugin_function-in.o
> >   CC       /tmp/build/perf/plugins/plugin_scsi.o
> >   LD       /tmp/build/perf/plugins/plugin_futex-in.o
> >   CC       /tmp/build/perf/plugins/plugin_cfg80211.o
> >   LD       /tmp/build/perf/plugins/plugin_xen-in.o
> >   CC       /tmp/build/perf/plugins/plugin_tlb.o
> >   LD       /tmp/build/perf/plugins/plugin_scsi-in.o
> >   LD       /tmp/build/perf/plugins/plugin_cfg80211-in.o
> >   LINK     /tmp/build/perf/plugins/plugin_jbd2.so
> >   LINK     /tmp/build/perf/plugins/plugin_hrtimer.so
> >   LINK     /tmp/build/perf/plugins/plugin_kmem.so
> >   LINK     /tmp/build/perf/plugins/plugin_kvm.so
> >   LINK     /tmp/build/perf/plugins/plugin_mac80211.so
> >   LD       /tmp/build/perf/plugins/plugin_tlb-in.o
> >   LINK     /tmp/build/perf/plugins/plugin_function.so
> >   LINK     /tmp/build/perf/plugins/plugin_sched_switch.so
> >   LINK     /tmp/build/perf/plugins/plugin_futex.so
> >   LINK     /tmp/build/perf/plugins/plugin_xen.so
> >   LINK     /tmp/build/perf/plugins/plugin_scsi.so
> >   LINK     /tmp/build/perf/plugins/plugin_cfg80211.so
> >   LINK     /tmp/build/perf/plugins/plugin_tlb.so
> >   INSTALL  trace_plugins
> >   LD       /tmp/build/perf/pmu-events/pmu-events-in.o
> > 
> > Auto-detecting system features:
> > ...                        libbfd: [ on  ]
> > ...        disassembler-four-args: [ on  ]
> > ...                          zlib: [ on  ]
> > ...                        libcap: [ on  ]
> > ...               clang-bpf-co-re: [ on  ]
> > 
> >   MKDIR    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/
> >   MKDIR    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/
> >   CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/main.o
> >   CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/common.o
> >   CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/json_writer.o
> >   CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/gen.o
> >   CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/btf.o
> >   GEN      /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/bpf_helper_defs.h
> >   MKDIR    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
> >   MKDIR    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
> >   CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf.o
> >   CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/bpf.o
> >   MKDIR    /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/
> >   CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/nlattr.o
> >   CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/btf.o
> >   CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf_errno.o
> >   CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/str_error.o
> >   CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/netlink.o
> >   CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/bpf_prog_linfo.o
> >   CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf_probes.o
> >   CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/xsk.o
> >   CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/hashmap.o
> >   CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/btf_dump.o
> >   CC       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/ringbuf.o
> >   LD       /tmp/build/perf/staticobjs/libbpf-in.o
> >   LINK     /tmp/build/perf/libbpf.a
> >   CLANG    /tmp/build/perf/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o
> >   CLANG    /tmp/build/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o
> >   CLANG    /tmp/build/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o
> >   LD       /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/staticobjs/libbpf-in.o
> >   LINK     /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/libbpf/libbpf.a
> >   LINK     /tmp/build/perf/util/bpf_skel/.tmp//bootstrap/bpftool
> >   GEN-SKEL /tmp/build/perf/util/bpf_skel/bpf_prog_profiler.skel.h
> >   GEN-SKEL /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h
> >   GEN-SKEL /tmp/build/perf/util/bpf_skel/bperf_follower.skel.h
> > libbpf: map 'prev_readings': unexpected def kind var.
> > Error: failed to open BPF object file: Invalid argument
> > libbpf: map 'diff_readings': unexpected def kind var.
> > Error: failed to open BPF object file: Invalid argument
> > make[2]: *** [Makefile.perf:1029: /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h] Error 255
> > make[2]: *** Waiting for unfinished jobs....
> > make[2]: *** [Makefile.perf:1029: /tmp/build/perf/util/bpf_skel/bperf_follower.skel.h] Error 255
> > make[1]: *** [Makefile.perf:236: sub-make] Error 2
> > make: *** [Makefile:110: install-bin] Error 2
> > make: Leaving directory '/home/acme/git/perf/tools/perf'
> > [acme@quaco perf]$ clang -v
> > clang version 11.0.0 (https://github.com/llvm/llvm-project 67420f1b0e9c673ee638f2680fa83f468019004f)
> > Target: x86_64-unknown-linux-gnu
> > Thread model: posix
> > InstalledDir: /usr/local/bin
> > Found candidate GCC installation: /usr/lib/gcc/x86_64-redhat-linux/10
> > Selected GCC installation: /usr/lib/gcc/x86_64-redhat-linux/10
> > Candidate multilib: .;@m64
> > Candidate multilib: 32;@m32
> > Selected multilib: .;@m64
> > [acme@quaco perf]$
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
