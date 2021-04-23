Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885A4369A86
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243794AbhDWSzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243822AbhDWSzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:55:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5E92613F5;
        Fri, 23 Apr 2021 18:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619204076;
        bh=evTGS4XH+/PMZ/E+mxz+F+W+zS1n3pKE6LNG3BMage8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ftV6o+gZBVvyaaoNfg91UEiH8otFwxm3TYtPZEI+bqmrgKgldPjTV6bPppE+TgkXm
         PD/QuzxyYMwhCQD750RHoYplJWNC4tPy99Ue3EosKnlNvODT8kR/OYTr5wGaw6Dj00
         8pa7xAr/ddyfq51AjqDyhMx95Qg2LocBNXT8m5+OVOACpoKjNWBAdl9kSayU5I9/AH
         AF9aW5KZOdmYoSpXlVPJY1jJjAtBuGZjuI++UY0+CZzMt5BlfHVPwg2gIKgSOHSTkL
         dCDO9kKBgtVACRZZHoLXf8FRcP1bddZeYQrBlvVQNfPozZHqtEFquuPx/ay9Ojw3AR
         ebEKOjHR03Wqg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3921C40647; Fri, 23 Apr 2021 15:54:15 -0300 (-03)
Date:   Fri, 23 Apr 2021 15:54:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools build: Fix quiet cmd indentation
Message-ID: <YIMX164sB0CjPHUW@kernel.org>
References: <20210421185848.1292167-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421185848.1292167-1-keescook@chromium.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 21, 2021 at 11:58:48AM -0700, Kees Cook escreveu:
> The tools quiet cmd output has mismatched indentation (and extra space
> character between cmd name and target name) compared to the rest of
> kbuild out:
> 
>   HOSTCC  scripts/insert-sys-cert
>   LD       /srv/code/tools/objtool/arch/x86/objtool-in.o
>   LD       /srv/code/tools/objtool/libsubcmd-in.o
>   AR       /srv/code/tools/objtool/libsubcmd.a
>   HOSTLD  scripts/genksyms/genksyms
>   CC      scripts/mod/empty.o
>   HOSTCC  scripts/mod/mk_elfconfig
>   CC      scripts/mod/devicetable-offsets.s
>   MKELF   scripts/mod/elfconfig.h
>   HOSTCC  scripts/mod/modpost.o
>   HOSTCC  scripts/mod/file2alias.o
>   HOSTCC  scripts/mod/sumversion.o
>   LD       /srv/code/tools/objtool/objtool-in.o
>   LINK     /srv/code/tools/objtool/objtool
>   HOSTLD  scripts/mod/modpost
>   CC      kernel/bounds.s
> 
> Adjust to match the rest of kbuild.

Is this some recent regression? I never noticed this when build perf,
with what I have in perf/urgent:


6b0bb32ece1be801 (HEAD -> perf/urgent) perf ftrace: Fix access to pid in array when setting a pid filter
b14585d9f18dc617 perf auxtrace: Fix potential NULL pointer dereference
f2211881e737cade perf data: Fix error return code in perf_data__create_dir()
7af08140979a6e7e (torvalds/master) Revert "gcov: clang: fix clang-11+ build"
bf05bf16c76bb44a (tag: v5.12-rc8) Linux 5.12-rc8
5ffe04ccd69ae56a Merge tag 'arm-fixes-5.12-3' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
f5ce0466dc96326e Merge tag 'for-linus' of git://git.armlinux.org.uk/~rmk/linux-arm
d2f7eca60b290062 ARM: 9071/1: uprobes: Don't hook on thumb instructions
c98ff1d013d2d539 Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
aba5970c4da0059e Merge tag 'drm-fixes-2021-04-18' of git://anongit.freedesktop.org/drm/drm
[acme@five perf]$

It seems nicely aligned:

[acme@five perf]$[acme@five perf]$ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf ; make -C tools/perf O=/tmp/build/perf install-bin
make: Entering directory '/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j24' parallel build
  HOSTCC   /tmp/build/perf/fixdep.o
  HOSTLD   /tmp/build/perf/fixdep-in.o
  LINK     /tmp/build/perf/fixdep

Auto-detecting system features:
...                         dwarf: [ on  ]
...            dwarf_getlocations: [ on  ]
...                         glibc: [ on  ]
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
...            libdw-dwarf-unwind: [ on  ]
...                          zlib: [ on  ]
...                          lzma: [ on  ]
...                     get_cpuid: [ on  ]
...                           bpf: [ on  ]
...                        libaio: [ on  ]
...                       libzstd: [ on  ]
...        disassembler-four-args: [ on  ]

  GEN      /tmp/build/perf/common-cmds.h
  CC       /tmp/build/perf/perf-read-vdso32
  CC       /tmp/build/perf/exec-cmd.o
  MKDIR    /tmp/build/perf/fd/
  MKDIR    /tmp/build/perf/pmu-events/
  MKDIR    /tmp/build/perf/pmu-events/
  CC       /tmp/build/perf/cpu.o
  MKDIR    /tmp/build/perf/fs/
  HOSTCC   /tmp/build/perf/pmu-events/json.o
  CC       /tmp/build/perf/fd/array.o
  CC       /tmp/build/perf/help.o
  MKDIR    /tmp/build/perf/jvmti/
  CC       /tmp/build/perf/debug.o
  CC       /tmp/build/perf/fs/fs.o
  MKDIR    /tmp/build/perf/pmu-events/
  HOSTCC   /tmp/build/perf/pmu-events/jsmn.o
  MKDIR    /tmp/build/perf/fs/
  CC       /tmp/build/perf/pager.o
  CC       /tmp/build/perf/str_error_r.o
  CC       /tmp/build/perf/jvmti/libjvmti.o
  CC       /tmp/build/perf/parse-options.o
  HOSTCC   /tmp/build/perf/pmu-events/jevents.o
  CC       /tmp/build/perf/fs/tracing_path.o
  CC       /tmp/build/perf/fs/cgroup.o
  MKDIR    /tmp/build/perf/jvmti/
  CC       /tmp/build/perf/run-command.o
  CC       /tmp/build/perf/sigchain.o
  CC       /tmp/build/perf/event-parse.o
  LD       /tmp/build/perf/fd/libapi-in.o
  CC       /tmp/build/perf/jvmti/jvmti_agent.o
  CC       /tmp/build/perf/jvmti/libstring.o
  CC       /tmp/build/perf/subcmd-config.o
  CC       /tmp/build/perf/trace-seq.o
  CC       /tmp/build/perf/event-plugin.o
  CC       /tmp/build/perf/parse-filter.o
  HOSTLD   /tmp/build/perf/pmu-events/jevents-in.o
  CC       /tmp/build/perf/parse-utils.o
  LD       /tmp/build/perf/fs/libapi-in.o
  CC       /tmp/build/perf/jvmti/libctype.o
  CC       /tmp/build/perf/core.o
  CC       /tmp/build/perf/threadmap.o
  CC       /tmp/build/perf/kbuffer-parse.o
  CC       /tmp/build/perf/cpumap.o
  GEN      /tmp/build/perf/bpf_helper_defs.h
  CC       /tmp/build/perf/evsel.o
  LD       /tmp/build/perf/libsubcmd-in.o
  CC       /tmp/build/perf/evlist.o
  CC       /tmp/build/perf/mmap.o
  LD       /tmp/build/perf/libapi-in.o
  CC       /tmp/build/perf/tep_strerror.o
  CC       /tmp/build/perf/event-parse-api.o
  LINK     /tmp/build/perf/pmu-events/jevents
  CC       /tmp/build/perf/zalloc.o
  CC       /tmp/build/perf/xyarray.o
  CC       /tmp/build/perf/lib.o
  AR       /tmp/build/perf/libapi.a
  AR       /tmp/build/perf/libsubcmd.a
  LD       /tmp/build/perf/libtraceevent-in.o
  CC       /tmp/build/perf/plugin_jbd2.o
  CC       /tmp/build/perf/plugin_kmem.o
  CC       /tmp/build/perf/plugin_mac80211.o
  CC       /tmp/build/perf/plugin_hrtimer.o
  CC       /tmp/build/perf/plugin_sched_switch.o
  CC       /tmp/build/perf/plugin_function.o
  CC       /tmp/build/perf/plugin_kvm.o
  CC       /tmp/build/perf/plugin_scsi.o
  CC       /tmp/build/perf/plugin_futex.o
  CC       /tmp/build/perf/plugin_cfg80211.o
  CC       /tmp/build/perf/plugin_xen.o
  LD       /tmp/build/perf/libperf-in.o
  LINK     /tmp/build/perf/libtraceevent.a
  LD       /tmp/build/perf/plugin_hrtimer-in.o
  LD       /tmp/build/perf/plugin_jbd2-in.o
  CC       /tmp/build/perf/plugin_tlb.o
  LD       /tmp/build/perf/plugin_sched_switch-in.o
  LD       /tmp/build/perf/plugin_kvm-in.o
  LD       /tmp/build/perf/plugin_scsi-in.o
  LD       /tmp/build/perf/plugin_function-in.o
  LD       /tmp/build/perf/plugin_futex-in.o
  LD       /tmp/build/perf/plugin_mac80211-in.o
  LINK     /tmp/build/perf/plugin_hrtimer.so
  LD       /tmp/build/perf/plugin_kmem-in.o
  LD       /tmp/build/perf/plugin_cfg80211-in.o
  LINK     /tmp/build/perf/plugin_sched_switch.so
  LD       /tmp/build/perf/plugin_xen-in.o
  LINK     /tmp/build/perf/plugin_jbd2.so
  LINK     /tmp/build/perf/plugin_scsi.so
  LINK     /tmp/build/perf/plugin_kvm.so
  LINK     /tmp/build/perf/plugin_mac80211.so
  LINK     /tmp/build/perf/plugin_function.so
  AR       /tmp/build/perf/libperf.a
  LD       /tmp/build/perf/plugin_tlb-in.o
  LINK     /tmp/build/perf/plugin_futex.so
  LINK     /tmp/build/perf/plugin_kmem.so
  LINK     /tmp/build/perf/plugin_cfg80211.so
  LINK     /tmp/build/perf/plugin_xen.so
  GEN      /tmp/build/perf/pmu-events/pmu-events.c
  LINK     /tmp/build/perf/plugin_tlb.so
  PERF_VERSION = 5.12.rc8.g6b0bb32ece1b
  GEN      /tmp/build/perf/libtraceevent-dynamic-list
  GEN      perf-archive
  GEN      perf-with-kcore
  MKDIR    /tmp/build/perf/staticobjs/
  MKDIR    /tmp/build/perf/staticobjs/
  MKDIR    /tmp/build/perf/staticobjs/
  MKDIR    /tmp/build/perf/staticobjs/
  MKDIR    /tmp/build/perf/staticobjs/
  MKDIR    /tmp/build/perf/staticobjs/
  MKDIR    /tmp/build/perf/staticobjs/
  MKDIR    /tmp/build/perf/staticobjs/
  CC       /tmp/build/perf/staticobjs/libbpf_probes.o
  CC       /tmp/build/perf/staticobjs/bpf.o
  CC       /tmp/build/perf/staticobjs/libbpf.o
  CC       /tmp/build/perf/staticobjs/nlattr.o
  CC       /tmp/build/perf/staticobjs/xsk.o
  CC       /tmp/build/perf/staticobjs/btf.o
  CC       /tmp/build/perf/staticobjs/libbpf_errno.o
  CC       /tmp/build/perf/staticobjs/str_error.o
  CC       /tmp/build/perf/staticobjs/netlink.o
  CC       /tmp/build/perf/staticobjs/bpf_prog_linfo.o
  CC       /tmp/build/perf/staticobjs/hashmap.o
  CC       /tmp/build/perf/staticobjs/btf_dump.o
  CC       /tmp/build/perf/staticobjs/ringbuf.o
  LD       /tmp/build/perf/staticobjs/libbpf-in.o
  LINK     /tmp/build/perf/libbpf.a
  DESCEND  plugins
  GEN      /tmp/build/perf/python/perf.so
  CC       /tmp/build/perf/plugins/plugin_jbd2.o
  CC       /tmp/build/perf/plugins/plugin_hrtimer.o
  CC       /tmp/build/perf/plugins/plugin_kmem.o
  CC       /tmp/build/perf/plugins/plugin_mac80211.o
  CC       /tmp/build/perf/plugins/plugin_sched_switch.o
  CC       /tmp/build/perf/plugins/plugin_function.o
  CC       /tmp/build/perf/plugins/plugin_kvm.o
  CC       /tmp/build/perf/plugins/plugin_futex.o
  CC       /tmp/build/perf/plugins/plugin_scsi.o
  CC       /tmp/build/perf/plugins/plugin_xen.o
  CC       /tmp/build/perf/plugins/plugin_cfg80211.o
  CC       /tmp/build/perf/plugins/plugin_tlb.o
  LD       /tmp/build/perf/plugins/plugin_hrtimer-in.o
  LD       /tmp/build/perf/plugins/plugin_jbd2-in.o
  LD       /tmp/build/perf/plugins/plugin_kmem-in.o
  LD       /tmp/build/perf/plugins/plugin_function-in.o
  LD       /tmp/build/perf/plugins/plugin_kvm-in.o
  LD       /tmp/build/perf/plugins/plugin_mac80211-in.o
  LD       /tmp/build/perf/plugins/plugin_sched_switch-in.o
  LD       /tmp/build/perf/plugins/plugin_futex-in.o
  LD       /tmp/build/perf/plugins/plugin_scsi-in.o
  LD       /tmp/build/perf/plugins/plugin_xen-in.o
  LD       /tmp/build/perf/plugins/plugin_tlb-in.o
  LD       /tmp/build/perf/plugins/plugin_cfg80211-in.o
  LINK     /tmp/build/perf/plugins/plugin_hrtimer.so
  LINK     /tmp/build/perf/plugins/plugin_jbd2.so
  LINK     /tmp/build/perf/plugins/plugin_kmem.so
  LINK     /tmp/build/perf/plugins/plugin_function.so
  LINK     /tmp/build/perf/plugins/plugin_kvm.so
  LINK     /tmp/build/perf/plugins/plugin_mac80211.so
  LINK     /tmp/build/perf/plugins/plugin_sched_switch.so
  LINK     /tmp/build/perf/plugins/plugin_futex.so
  LINK     /tmp/build/perf/plugins/plugin_scsi.so
  LINK     /tmp/build/perf/plugins/plugin_xen.so
  LINK     /tmp/build/perf/plugins/plugin_cfg80211.so
  LINK     /tmp/build/perf/plugins/plugin_tlb.so
  INSTALL  trace_plugins
  CC       /tmp/build/perf/pmu-events/pmu-events.o
  LD       /tmp/build/perf/jvmti/jvmti-in.o
  LINK     /tmp/build/perf/libperf-jvmti.so
  CC       /tmp/build/perf/builtin-bench.o
  CC       /tmp/build/perf/builtin-annotate.o
  CC       /tmp/build/perf/builtin-config.o
  CC       /tmp/build/perf/builtin-diff.o
  CC       /tmp/build/perf/builtin-evlist.o
  CC       /tmp/build/perf/builtin-ftrace.o
  CC       /tmp/build/perf/builtin-help.o
  CC       /tmp/build/perf/builtin-sched.o
  CC       /tmp/build/perf/builtin-buildid-list.o
  CC       /tmp/build/perf/builtin-buildid-cache.o
  CC       /tmp/build/perf/builtin-kallsyms.o
  CC       /tmp/build/perf/builtin-list.o
  CC       /tmp/build/perf/builtin-record.o
  CC       /tmp/build/perf/builtin-report.o
  CC       /tmp/build/perf/builtin-stat.o
  CC       /tmp/build/perf/builtin-timechart.o
  CC       /tmp/build/perf/builtin-top.o
  CC       /tmp/build/perf/builtin-script.o
  CC       /tmp/build/perf/builtin-kmem.o
  CC       /tmp/build/perf/builtin-lock.o
  CC       /tmp/build/perf/builtin-kvm.o
  CC       /tmp/build/perf/builtin-inject.o
  CC       /tmp/build/perf/builtin-mem.o
  CC       /tmp/build/perf/builtin-data.o
  CC       /tmp/build/perf/builtin-version.o
  CC       /tmp/build/perf/builtin-c2c.o
  CC       /tmp/build/perf/builtin-daemon.o
  CC       /tmp/build/perf/builtin-trace.o
  CC       /tmp/build/perf/builtin-probe.o
  MKDIR    /tmp/build/perf/bench/
  CC       /tmp/build/perf/bench/sched-messaging.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/builtin-test.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/annotate.o
  CC       /tmp/build/perf/arch/common.o
  MKDIR    /tmp/build/perf/ui/
  CC       /tmp/build/perf/ui/setup.o
  MKDIR    /tmp/build/perf/scripts/perl/Perf-Trace-Util/
  CC       /tmp/build/perf/scripts/perl/Perf-Trace-Util/Context.o
  MKDIR    /tmp/build/perf/bench/
  CC       /tmp/build/perf/trace/beauty/clone.o
  CC       /tmp/build/perf/bench/sched-pipe.o
  CC       /tmp/build/perf/perf.o
  MKDIR    /tmp/build/perf/arch/x86/util/
  CC       /tmp/build/perf/arch/x86/util/header.o
  MKDIR    /tmp/build/perf/ui/
  CC       /tmp/build/perf/ui/helpline.o
  MKDIR    /tmp/build/perf/arch/x86/tests/
  CC       /tmp/build/perf/arch/x86/tests/regs_load.o
  CC       /tmp/build/perf/trace/beauty/fcntl.o
  MKDIR    /tmp/build/perf/tests/
  CC       /tmp/build/perf/tests/parse-events.o
  CC       /tmp/build/perf/bench/syscall.o
  MKDIR    /tmp/build/perf/arch/x86/tests/
  CC       /tmp/build/perf/arch/x86/tests/dwarf-unwind.o
  LD       /tmp/build/perf/pmu-events/pmu-events-in.o
  CC       /tmp/build/perf/trace/beauty/flock.o
  CC       /tmp/build/perf/trace/beauty/fsmount.o
  MKDIR    /tmp/build/perf/arch/x86/util/
  CC       /tmp/build/perf/arch/x86/util/tsc.o
  CC       /tmp/build/perf/ui/progress.o
  CC       /tmp/build/perf/trace/beauty/fspick.o
  CC       /tmp/build/perf/bench/mem-functions.o
  CC       /tmp/build/perf/bench/futex-hash.o
  CC       /tmp/build/perf/bench/futex-wake.o
  CC       /tmp/build/perf/arch/x86/util/pmu.o
  CC       /tmp/build/perf/arch/x86/util/kvm-stat.o
  MKDIR    /tmp/build/perf/util/
  CC       /tmp/build/perf/util/block-info.o
  CC       /tmp/build/perf/trace/beauty/ioctl.o
  CC       /tmp/build/perf/ui/util.o
  CC       /tmp/build/perf/util/block-range.o
  CC       /tmp/build/perf/trace/beauty/kcmp.o
  CC       /tmp/build/perf/arch/x86/tests/arch-tests.o
  CC       /tmp/build/perf/ui/hist.o
  MKDIR    /tmp/build/perf/ui/stdio/
  CC       /tmp/build/perf/ui/stdio/hist.o
  CC       /tmp/build/perf/ui/browser.o
  CC       /tmp/build/perf/arch/x86/util/perf_regs.o
  CC       /tmp/build/perf/arch/x86/tests/rdpmc.o
  CC       /tmp/build/perf/arch/x86/tests/sample-parsing.o
  CC       /tmp/build/perf/arch/x86/tests/insn-x86.o
  CC       /tmp/build/perf/trace/beauty/mount_flags.o
  CC       /tmp/build/perf/arch/x86/tests/intel-pt-pkt-decoder-test.o
  MKDIR    /tmp/build/perf/scripts/python/Perf-Trace-Util/
  CC       /tmp/build/perf/scripts/python/Perf-Trace-Util/Context.o
  CC       /tmp/build/perf/trace/beauty/move_mount.o
  CC       /tmp/build/perf/bench/futex-wake-parallel.o
  CC       /tmp/build/perf/bench/futex-requeue.o
  CC       /tmp/build/perf/bench/futex-lock-pi.o
  CC       /tmp/build/perf/util/build-id.o
  CC       /tmp/build/perf/trace/beauty/pkey_alloc.o
  CC       /tmp/build/perf/trace/beauty/arch_prctl.o
  CC       /tmp/build/perf/arch/x86/tests/bp-modify.o
  CC       /tmp/build/perf/arch/x86/util/topdown.o
  CC       /tmp/build/perf/arch/x86/util/machine.o
  CC       /tmp/build/perf/util/cacheline.o
  CC       /tmp/build/perf/trace/beauty/prctl.o
  CC       /tmp/build/perf/trace/beauty/renameat.o
  CC       /tmp/build/perf/trace/beauty/sockaddr.o
  CC       /tmp/build/perf/trace/beauty/socket.o
  LD       /tmp/build/perf/scripts/python/Perf-Trace-Util/perf-in.o
  CC       /tmp/build/perf/tests/dso-data.o
  CC       /tmp/build/perf/bench/epoll-wait.o
  CC       /tmp/build/perf/util/config.o
  CC       /tmp/build/perf/bench/epoll-ctl.o
  CC       /tmp/build/perf/util/copyfile.o
  LD       /tmp/build/perf/arch/x86/tests/perf-in.o
  CC       /tmp/build/perf/bench/synthesize.o
  CC       /tmp/build/perf/arch/x86/util/event.o
  CC       /tmp/build/perf/util/ctype.o
  CC       /tmp/build/perf/trace/beauty/statx.o
  CC       /tmp/build/perf/arch/x86/util/evlist.o
  CC       /tmp/build/perf/trace/beauty/sync_file_range.o
  MKDIR    /tmp/build/perf/ui/browsers/
  CC       /tmp/build/perf/ui/browsers/annotate.o
  MKDIR    /tmp/build/perf/trace/beauty/tracepoints/
  CC       /tmp/build/perf/trace/beauty/tracepoints/x86_irq_vectors.o
  LD       /tmp/build/perf/scripts/perl/Perf-Trace-Util/perf-in.o
  CC       /tmp/build/perf/util/db-export.o
  LD       /tmp/build/perf/scripts/perf-in.o
  CC       /tmp/build/perf/util/env.o
  CC       /tmp/build/perf/util/event.o
  MKDIR    /tmp/build/perf/trace/beauty/tracepoints/
  CC       /tmp/build/perf/trace/beauty/tracepoints/x86_msr.o
  CC       /tmp/build/perf/util/evlist.o
  CC       /tmp/build/perf/util/sideband_evlist.o
  CC       /tmp/build/perf/arch/x86/util/mem-events.o
  CC       /tmp/build/perf/util/evsel.o
  CC       /tmp/build/perf/util/evsel_fprintf.o
  CC       /tmp/build/perf/arch/x86/util/evsel.o
  LD       /tmp/build/perf/trace/beauty/tracepoints/perf-in.o
  LD       /tmp/build/perf/trace/beauty/perf-in.o
  CC       /tmp/build/perf/util/perf_event_attr_fprintf.o
  MKDIR    /tmp/build/perf/ui/tui/
  CC       /tmp/build/perf/ui/tui/setup.o
  CC       /tmp/build/perf/tests/attr.o
  CC       /tmp/build/perf/bench/kallsyms-parse.o
  CC       /tmp/build/perf/tests/vmlinux-kallsyms.o
  CC       /tmp/build/perf/bench/find-bit-bench.o
  CC       /tmp/build/perf/arch/x86/util/dwarf-regs.o
  CC       /tmp/build/perf/arch/x86/util/unwind-libunwind.o
  CC       /tmp/build/perf/util/evswitch.o
  CC       /tmp/build/perf/util/find_bit.o
  CC       /tmp/build/perf/arch/x86/util/auxtrace.o
  CC       /tmp/build/perf/bench/inject-buildid.o
  CC       /tmp/build/perf/util/get_current_dir_name.o
  MKDIR    /tmp/build/perf/ui/tui/
  CC       /tmp/build/perf/arch/x86/util/archinsn.o
  CC       /tmp/build/perf/ui/tui/util.o
  CC       /tmp/build/perf/util/kallsyms.o
  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
  CC       /tmp/build/perf/util/levenshtein.o
  CC       /tmp/build/perf/tests/openat-syscall.o
  CC       /tmp/build/perf/util/llvm-utils.o
  CC       /tmp/build/perf/util/mmap.o
  CC       /tmp/build/perf/tests/openat-syscall-all-cpus.o
  CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o
  CC       /tmp/build/perf/ui/tui/helpline.o
  CC       /tmp/build/perf/util/memswap.o
  CC       /tmp/build/perf/tests/openat-syscall-tp-fields.o
  CC       /tmp/build/perf/bench/numa.o
  CC       /tmp/build/perf/tests/mmap-basic.o
  BISON    /tmp/build/perf/util/parse-events-bison.c
  CC       /tmp/build/perf/util/perf_regs.o
  MKDIR    /tmp/build/perf/ui/browsers/
  CC       /tmp/build/perf/ui/browsers/hists.o
  CC       /tmp/build/perf/tests/perf-record.o
  CC       /tmp/build/perf/arch/x86/util/intel-pt.o
  CC       /tmp/build/perf/tests/evsel-roundtrip-name.o
  CC       /tmp/build/perf/arch/x86/util/intel-bts.o
  CC       /tmp/build/perf/ui/browsers/map.o
  CC       /tmp/build/perf/ui/tui/progress.o
  CC       /tmp/build/perf/tests/evsel-tp-sched.o
  CC       /tmp/build/perf/util/path.o
  CC       /tmp/build/perf/ui/browsers/scripts.o
  CC       /tmp/build/perf/util/print_binary.o
  CC       /tmp/build/perf/ui/browsers/header.o
  CC       /tmp/build/perf/util/rlimit.o
  CC       /tmp/build/perf/tests/fdarray.o
  CC       /tmp/build/perf/util/argv_split.o
  LD       /tmp/build/perf/ui/tui/perf-in.o
  CC       /tmp/build/perf/util/rbtree.o
  CC       /tmp/build/perf/util/libstring.o
  CC       /tmp/build/perf/tests/pmu.o
  CC       /tmp/build/perf/util/bitmap.o
  CC       /tmp/build/perf/ui/browsers/res_sample.o
  CC       /tmp/build/perf/tests/pmu-events.o
  CC       /tmp/build/perf/util/hweight.o
  CC       /tmp/build/perf/util/smt.o
  CC       /tmp/build/perf/tests/hists_common.o
  CC       /tmp/build/perf/util/strbuf.o
  CC       /tmp/build/perf/util/string.o
  CC       /tmp/build/perf/tests/hists_link.o
  CC       /tmp/build/perf/util/strlist.o
  CC       /tmp/build/perf/tests/hists_filter.o
  CC       /tmp/build/perf/util/strfilter.o
  CC       /tmp/build/perf/tests/hists_output.o
  CC       /tmp/build/perf/tests/hists_cumulate.o
  CC       /tmp/build/perf/tests/python-use.o
  CC       /tmp/build/perf/util/top.o
  CC       /tmp/build/perf/util/usage.o
  CC       /tmp/build/perf/util/dso.o
  CC       /tmp/build/perf/util/dsos.o
  CC       /tmp/build/perf/util/symbol.o
  CC       /tmp/build/perf/tests/bp_signal.o
  CC       /tmp/build/perf/util/symbol_fprintf.o
  CC       /tmp/build/perf/util/color.o
  CC       /tmp/build/perf/util/color_config.o
  CC       /tmp/build/perf/tests/bp_signal_overflow.o
  CC       /tmp/build/perf/util/metricgroup.o
  CC       /tmp/build/perf/util/header.o
  CC       /tmp/build/perf/util/callchain.o
  CC       /tmp/build/perf/util/values.o
  LD       /tmp/build/perf/arch/x86/util/perf-in.o
  CC       /tmp/build/perf/tests/bp_account.o
  CC       /tmp/build/perf/tests/wp.o
  CC       /tmp/build/perf/tests/task-exit.o
  LD       /tmp/build/perf/arch/x86/perf-in.o
  CC       /tmp/build/perf/util/debug.o
  CC       /tmp/build/perf/tests/sw-clock.o
  CC       /tmp/build/perf/tests/mmap-thread-lookup.o
  LD       /tmp/build/perf/arch/perf-in.o
  CC       /tmp/build/perf/tests/thread-maps-share.o
  CC       /tmp/build/perf/tests/switch-tracking.o
  CC       /tmp/build/perf/util/fncache.o
  CC       /tmp/build/perf/util/machine.o
  CC       /tmp/build/perf/util/map.o
  CC       /tmp/build/perf/tests/keep-tracking.o
  CC       /tmp/build/perf/util/pstack.o
  LD       /tmp/build/perf/bench/perf-in.o
  CC       /tmp/build/perf/util/session.o
  CC       /tmp/build/perf/tests/code-reading.o
  CC       /tmp/build/perf/tests/sample-parsing.o
  CC       /tmp/build/perf/util/sample-raw.o
  CC       /tmp/build/perf/tests/parse-no-sample-id-all.o
  CC       /tmp/build/perf/tests/kmod-path.o
  CC       /tmp/build/perf/util/s390-sample-raw.o
  CC       /tmp/build/perf/tests/thread-map.o
  CC       /tmp/build/perf/tests/llvm.o
  CC       /tmp/build/perf/util/syscalltbl.o
  CC       /tmp/build/perf/util/ordered-events.o
  CC       /tmp/build/perf/util/namespaces.o
  CC       /tmp/build/perf/util/comm.o
  CC       /tmp/build/perf/tests/bpf.o
  CC       /tmp/build/perf/util/thread.o
  CC       /tmp/build/perf/tests/topology.o
  CC       /tmp/build/perf/tests/mem.o
  CC       /tmp/build/perf/tests/cpumap.o
  CC       /tmp/build/perf/tests/stat.o
  CC       /tmp/build/perf/tests/event_update.o
  CC       /tmp/build/perf/util/thread_map.o
  CC       /tmp/build/perf/util/trace-event-parse.o
  CC       /tmp/build/perf/tests/event-times.o
  CC       /tmp/build/perf/util/parse-events-bison.o
  BISON    /tmp/build/perf/util/pmu-bison.c
  CC       /tmp/build/perf/util/trace-event-read.o
  CC       /tmp/build/perf/util/trace-event-info.o
  CC       /tmp/build/perf/util/trace-event-scripting.o
  CC       /tmp/build/perf/tests/expr.o
  CC       /tmp/build/perf/tests/backward-ring-buffer.o
  CC       /tmp/build/perf/util/trace-event.o
  CC       /tmp/build/perf/util/svghelper.o
  CC       /tmp/build/perf/util/sort.o
  CC       /tmp/build/perf/tests/sdt.o
  CC       /tmp/build/perf/tests/is_printable_array.o
  CC       /tmp/build/perf/util/hist.o
  CC       /tmp/build/perf/tests/bitmap.o
  CC       /tmp/build/perf/util/util.o
  CC       /tmp/build/perf/util/cpumap.o
  CC       /tmp/build/perf/tests/perf-hooks.o
  CC       /tmp/build/perf/tests/clang.o
  CC       /tmp/build/perf/util/affinity.o
  CC       /tmp/build/perf/tests/unit_number__scnprintf.o
  CC       /tmp/build/perf/util/cputopo.o
  CC       /tmp/build/perf/tests/mem2node.o
  CC       /tmp/build/perf/util/cgroup.o
  CC       /tmp/build/perf/tests/maps.o
  CC       /tmp/build/perf/util/target.o
  CC       /tmp/build/perf/tests/time-utils-test.o
  CC       /tmp/build/perf/tests/genelf.o
  CC       /tmp/build/perf/util/rblist.o
  CC       /tmp/build/perf/tests/api-io.o
  CC       /tmp/build/perf/util/intlist.o
  CC       /tmp/build/perf/tests/demangle-java-test.o
  CC       /tmp/build/perf/util/vdso.o
  CC       /tmp/build/perf/util/counts.o
  CC       /tmp/build/perf/tests/demangle-ocaml-test.o
  CC       /tmp/build/perf/util/stat.o
  CC       /tmp/build/perf/tests/pfm.o
  CC       /tmp/build/perf/tests/parse-metric.o
  CC       /tmp/build/perf/util/stat-shadow.o
  CC       /tmp/build/perf/util/stat-display.o
  CC       /tmp/build/perf/util/perf_api_probe.o
  CC       /tmp/build/perf/util/record.o
  CC       /tmp/build/perf/util/srcline.o
  CC       /tmp/build/perf/tests/pe-file-parsing.o
  CC       /tmp/build/perf/tests/expand-cgroup.o
  CC       /tmp/build/perf/tests/perf-time-to-tsc.o
  CC       /tmp/build/perf/tests/dwarf-unwind.o
  CC       /tmp/build/perf/tests/llvm-src-base.o
  CC       /tmp/build/perf/util/srccode.o
  LD       /tmp/build/perf/ui/browsers/perf-in.o
  LD       /tmp/build/perf/ui/perf-in.o
  CC       /tmp/build/perf/util/synthetic-events.o
  CC       /tmp/build/perf/util/data.o
  CC       /tmp/build/perf/tests/llvm-src-kbuild.o
  CC       /tmp/build/perf/tests/llvm-src-prologue.o
  CC       /tmp/build/perf/util/tsc.o
  CC       /tmp/build/perf/tests/llvm-src-relocation.o
  CC       /tmp/build/perf/util/cloexec.o
  CC       /tmp/build/perf/util/call-path.o
  CC       /tmp/build/perf/util/rwsem.o
  CC       /tmp/build/perf/util/thread-stack.o
  CC       /tmp/build/perf/util/spark.o
  CC       /tmp/build/perf/util/topdown.o
  CC       /tmp/build/perf/util/stream.o
  CC       /tmp/build/perf/util/auxtrace.o
  MKDIR    /tmp/build/perf/util/intel-pt-decoder/
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-pkt-decoder.o
  MKDIR    /tmp/build/perf/util/intel-pt-decoder/
  MKDIR    /tmp/build/perf/util/arm-spe-decoder/
  MKDIR    /tmp/build/perf/util/scripting-engines/
  CC       /tmp/build/perf/util/scripting-engines/trace-event-perl.o
  GEN      /tmp/build/perf/util/intel-pt-decoder/inat-tables.c
  CC       /tmp/build/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.o
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-log.o
  MKDIR    /tmp/build/perf/util/arm-spe-decoder/
  LD       /tmp/build/perf/tests/perf-in.o
  CC       /tmp/build/perf/util/arm-spe-decoder/arm-spe-decoder.o
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-decoder.o
  CC       /tmp/build/perf/util/intel-pt.o
  CC       /tmp/build/perf/util/intel-bts.o
  CC       /tmp/build/perf/util/arm-spe.o
  CC       /tmp/build/perf/util/s390-cpumsf.o
  CC       /tmp/build/perf/util/parse-branch-options.o
  CC       /tmp/build/perf/util/dump-insn.o
  CC       /tmp/build/perf/util/intel-pt-decoder/intel-pt-insn-decoder.o
  CC       /tmp/build/perf/util/parse-regs-options.o
  CC       /tmp/build/perf/util/parse-sublevel-options.o
  CC       /tmp/build/perf/util/term.o
  LD       /tmp/build/perf/util/arm-spe-decoder/perf-in.o
  CC       /tmp/build/perf/util/help-unknown-cmd.o
  CC       /tmp/build/perf/util/mem-events.o
  CC       /tmp/build/perf/util/vsprintf.o
  CC       /tmp/build/perf/util/units.o
  CC       /tmp/build/perf/util/time-utils.o
  BISON    /tmp/build/perf/util/expr-bison.c
  CC       /tmp/build/perf/util/branch.o
  CC       /tmp/build/perf/util/mem2node.o
  CC       /tmp/build/perf/util/clockid.o
  CC       /tmp/build/perf/util/bpf-loader.o
  CC       /tmp/build/perf/util/bpf_map.o
  CC       /tmp/build/perf/util/bpf-prologue.o
  CC       /tmp/build/perf/util/symbol-elf.o
  MKDIR    /tmp/build/perf/util/scripting-engines/
  CC       /tmp/build/perf/util/scripting-engines/trace-event-python.o
  CC       /tmp/build/perf/util/probe-file.o
  CC       /tmp/build/perf/util/probe-event.o
  CC       /tmp/build/perf/util/probe-finder.o
  CC       /tmp/build/perf/util/dwarf-aux.o
  CC       /tmp/build/perf/util/dwarf-regs.o
  CC       /tmp/build/perf/util/unwind-libunwind-local.o
  CC       /tmp/build/perf/util/unwind-libunwind.o
  CC       /tmp/build/perf/util/zlib.o
  CC       /tmp/build/perf/util/data-convert-bt.o
  CC       /tmp/build/perf/util/lzma.o
  CC       /tmp/build/perf/util/zstd.o
  CC       /tmp/build/perf/util/cap.o
  CC       /tmp/build/perf/util/demangle-ocaml.o
  CC       /tmp/build/perf/util/demangle-java.o
  CC       /tmp/build/perf/util/demangle-rust.o
  CC       /tmp/build/perf/util/jitdump.o
  CC       /tmp/build/perf/util/genelf.o
  CC       /tmp/build/perf/util/genelf_debug.o
  CC       /tmp/build/perf/util/perf-hooks.o
  CC       /tmp/build/perf/util/bpf-event.o
  FLEX     /tmp/build/perf/util/parse-events-flex.c
  FLEX     /tmp/build/perf/util/pmu-flex.c
  CC       /tmp/build/perf/util/pmu-bison.o
  FLEX     /tmp/build/perf/util/expr-flex.c
  CC       /tmp/build/perf/util/expr-bison.o
  CC       /tmp/build/perf/util/expr.o
  CC       /tmp/build/perf/util/parse-events.o
  CC       /tmp/build/perf/util/parse-events-flex.o
  CC       /tmp/build/perf/util/pmu.o
  CC       /tmp/build/perf/util/pmu-flex.o
  CC       /tmp/build/perf/util/expr-flex.o
  LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
  LD       /tmp/build/perf/util/scripting-engines/perf-in.o
  LD       /tmp/build/perf/util/perf-in.o
  LD       /tmp/build/perf/perf-in.o
  LINK     /tmp/build/perf/perf
  INSTALL  tests
  INSTALL  binaries
  INSTALL  perf-read-vdso32
  INSTALL  libperf-jvmti.so
  INSTALL  libexec
  INSTALL  bpf-headers
  INSTALL  bpf-examples
  INSTALL  perf-archive
  INSTALL  perf-with-kcore
  INSTALL  strace/groups
  INSTALL  perl-scripts
  INSTALL  python-scripts
  INSTALL  perf_completion-script
  INSTALL  perf-tip
make: Leaving directory '/home/acme/git/perf/tools/perf'
[acme@five perf]$
