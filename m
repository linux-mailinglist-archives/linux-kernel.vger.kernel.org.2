Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9901C324BC3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 09:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbhBYIIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 03:08:50 -0500
Received: from mga11.intel.com ([192.55.52.93]:22134 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235612AbhBYIIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 03:08:22 -0500
IronPort-SDR: 27CfFGBu3KlNJsq3ehBfzJYFpfWekGwcG1qwHSt96rYPqCFStEEE0KK+EmrmIvjOgXJBFj1zec
 YSkxP7iXG1HA==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="182021024"
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; 
   d="scan'208";a="182021024"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 00:06:30 -0800
IronPort-SDR: 6IY7gqXvzb2BS2GtgLpu5aUlu1hLYgZlQ/lK1lkmcVVzFAsYusEOQYu+oYgH7DPrVI/2C8B3/N
 niHdLCkEnnZg==
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; 
   d="scan'208";a="381407447"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 00:06:26 -0800
Subject: Re: [drm/i915/gt] 8c3b1ba0e7:
 perf-sanity-tests.Parse_event_definition_strings.fail
To:     kernel test robot <oliver.sang@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@intel.com>, "Jin, Yao" <yao.jin@intel.com>,
        "Yi, Ammy" <ammy.yi@intel.com>
References: <20210224074841.GD6114@xsang-OptiPlex-9020>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <cabd8692-07ca-13c8-efb5-e088b4547f80@linux.intel.com>
Date:   Thu, 25 Feb 2021 16:06:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224074841.GD6114@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris, Arnaldo, Jiri,

We observe the parsing error for "software/xxx/" on some platforms.

For example,

# perf stat -e software/r1a/ -a -- sleep 1
event syntax error: 'software/r1a/'
                      \___ parser error
Run 'perf list' for a list of valid events

  Usage: perf stat [<options>] [<command>]

     -e, --event <event>   event selector. use 'perf list' to list available events

And perf test is failed too.

# perf test 6 -vv
...
running test 4 'software/r1a/'failed to parse event 'software/r1a/', err 1, str 'parser error'
event syntax error: 'software/r1a/'
                      \___ parser error

running test 4 'software/r0x1a/'failed to parse event 'software/r0x1a/', err 1, str 'parser error'
event syntax error: 'software/r0x1a/'
                      \___ parser error
...

The issue should be the conflict between event "i915/software-gt-awake-time/" and pmu "software".

# perf list | grep i915/software
   i915/software-gt-awake-time/                       [Kernel PMU event]

Perf supports the event format as "prefix-xxx-suffix", so the "software" string in 
"software-gt-awake-time" is added to perf_pmu_events_list as PMU_EVENT_SYMBOL_PREFIX. When parsing 
the string such as "software/xxx/", it’s parsed as PMU_EVENT_SYMBOL_PREFIX for "software", then it 
would error out in next processing.

So the easy way is to rename "software-gt-awake-time" to "gt-awake-time", right? Otherwise we have 
to hardcode something in perf tool.

What do you think of this issue and the solution?

BTW, as the robot reported, it's related to the commit 8c3b1ba0e7ea ("drm/i915/gt: Track the overall 
awake/busy time").

Thanks
Jin Yao

On 2/24/2021 3:48 PM, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813 ("drm/i915/gt: Track the overall awake/busy time")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: perf-sanity-tests
> version:
> with following parameters:
> 
> 	perf_compiler: gcc
> 	ucode: 0xe2
> 
> 
> 
> on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> please be noted this was reported on last December
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/ZPLGWG47V7CIZIL3TEP3E7NBT6E5C3XA/
> 
> since already merged into mainline and the issue still exist on current master HEAD,
> report again.
> 
> 
> 2020-12-24 12:50:16 make ARCH= EXTRA_CFLAGS=-fno-omit-frame-pointer -fsanitize=undefined -fsanitize=address -C /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf
> make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf'
>    BUILD:   Doing 'make [33m-j4[m' parallel build
>    HOSTCC   fixdep.o
>    HOSTLD   fixdep-in.o
>    LINK     fixdep
> diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
> diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
> diff -u tools/arch/x86/lib/memset_64.S arch/x86/lib/memset_64.S
> 
> Auto-detecting system features:
> ...                         dwarf: [ [32mon[m  ]
> ...            dwarf_getlocations: [ [32mon[m  ]
> ...                         glibc: [ [32mon[m  ]
> ...                        libbfd: [ [32mon[m  ]
> ...                libbfd-buildid: [ [32mon[m  ]
> ...                        libcap: [ [32mon[m  ]
> ...                        libelf: [ [32mon[m  ]
> ...                       libnuma: [ [32mon[m  ]
> ...        numa_num_possible_cpus: [ [32mon[m  ]
> ...                       libperl: [ [32mon[m  ]
> ...                     libpython: [ [32mon[m  ]
> ...                     libcrypto: [ [32mon[m  ]
> ...                     libunwind: [ [32mon[m  ]
> ...            libdw-dwarf-unwind: [ [32mon[m  ]
> ...                          zlib: [ [32mon[m  ]
> ...                          lzma: [ [32mon[m  ]
> ...                     get_cpuid: [ [32mon[m  ]
> ...                           bpf: [ [32mon[m  ]
> ...                        libaio: [ [32mon[m  ]
> ...                       libzstd: [ [32mon[m  ]
> ...        disassembler-four-args: [ [32mon[m  ]
> 
>    CC       fd/array.o
>    CC       exec-cmd.o
>    CC       event-parse.o
>    CC       core.o
>    LD       fd/libapi-in.o
>    CC       fs/fs.o
>    CC       cpumap.o
>    CC       help.o
>    CC       fs/tracing_path.o
>    CC       fs/cgroup.o
>    LD       fs/libapi-in.o
>    CC       cpu.o
>    CC       threadmap.o
>    CC       debug.o
>    CC       pager.o
>    CC       str_error_r.o
>    LD       libapi-in.o
>    AR       libapi.a
>    CC       parse-options.o
>    CC       event-plugin.o
>    CC       evsel.o
>    CC       trace-seq.o
>    CC       parse-filter.o
>    CC       evlist.o
>    CC       mmap.o
>    CC       parse-utils.o
>    CC       kbuffer-parse.o
>    CC       zalloc.o
>    CC       tep_strerror.o
>    CC       event-parse-api.o
>    CC       xyarray.o
>    LD       libtraceevent-in.o
>    LINK     libtraceevent.a
>    CC       lib.o
>    GEN      bpf_helper_defs.h
>    MKDIR    staticobjs/
>    CC       staticobjs/libbpf.o
>    LD       libperf-in.o
>    AR       libperf.a
>    GEN      common-cmds.h
>    CC       run-command.o
>    CC       sigchain.o
>    CC       subcmd-config.o
>    LD       libsubcmd-in.o
>    MKDIR    staticobjs/
>    AR       libsubcmd.a
>    CC       staticobjs/bpf.o
>    CC       staticobjs/nlattr.o
>    CC       staticobjs/btf.o
>    HOSTCC   pmu-events/json.o
>    HOSTCC   pmu-events/jsmn.o
>    HOSTCC   pmu-events/jevents.o
>    HOSTLD   pmu-events/jevents-in.o
>    CC       plugin_jbd2.o
>    LD       plugin_jbd2-in.o
>    CC       plugin_hrtimer.o
>    LD       plugin_hrtimer-in.o
>    CC       plugin_kmem.o
>    LD       plugin_kmem-in.o
>    CC       plugin_kvm.o
>    LD       plugin_kvm-in.o
>    CC       staticobjs/libbpf_errno.o
>    CC       plugin_mac80211.o
>    CC       staticobjs/str_error.o
>    CC       staticobjs/netlink.o
>    LD       plugin_mac80211-in.o
>    CC       plugin_sched_switch.o
>    LD       plugin_sched_switch-in.o
>    CC       plugin_function.o
>    CC       staticobjs/bpf_prog_linfo.o
>    LD       plugin_function-in.o
>    CC       plugin_futex.o
>    CC       staticobjs/libbpf_probes.o
>    LD       plugin_futex-in.o
>    CC       plugin_xen.o
>    CC       staticobjs/xsk.o
>    LD       plugin_xen-in.o
>    CC       plugin_scsi.o
>    CC       staticobjs/hashmap.o
>    LD       plugin_scsi-in.o
>    CC       plugin_tlb.o
>    CC       plugin_cfg80211.o
>    CC       jvmti/libjvmti.o
>    LD       plugin_cfg80211-in.o
>    GEN      perf-archive
>    LD       plugin_tlb-in.o
>    LINK     plugin_jbd2.so
>    GEN      perf-with-kcore
>    CC       jvmti/jvmti_agent.o
>    CC       staticobjs/btf_dump.o
>    LINK     plugin_hrtimer.so
>    LINK     plugin_kmem.so
>    LINK     plugin_kvm.so
>    LINK     plugin_mac80211.so
>    CC       staticobjs/ringbuf.o
>    LINK     plugin_sched_switch.so
>    LINK     plugin_function.so
>    LINK     plugin_futex.so
>    LINK     plugin_xen.so
>    LD       staticobjs/libbpf-in.o
>    LINK     libbpf.a
>    LINK     plugin_scsi.so
>    CC       jvmti/libstring.o
>    LINK     plugin_cfg80211.so
>    CC       builtin-bench.o
>    LINK     plugin_tlb.so
>    GEN      libtraceevent-dynamic-list
>    CC       jvmti/libctype.o
>    CC       builtin-annotate.o
>    CC       builtin-config.o
>    LD       jvmti/jvmti-in.o
>    CC       builtin-diff.o
>    LINK     pmu-events/jevents
>    CC       builtin-evlist.o
>    CC       builtin-ftrace.o
>    LINK     libperf-jvmti.so
>    CC       builtin-help.o
>    CC       builtin-sched.o
>    CC       builtin-buildid-list.o
>    CC       builtin-buildid-cache.o
>    CC       builtin-kallsyms.o
>    CC       builtin-list.o
>    CC       builtin-record.o
>    CC       builtin-report.o
>    CC       builtin-stat.o
>    CC       builtin-timechart.o
>    CC       builtin-top.o
>    CC       builtin-script.o
>    CC       builtin-kmem.o
>    CC       builtin-lock.o
>    CC       builtin-kvm.o
>    CC       builtin-inject.o
>    CC       builtin-mem.o
>    CC       builtin-data.o
>    CC       builtin-version.o
>    CC       builtin-c2c.o
>    CC       builtin-trace.o
>    CC       builtin-probe.o
>    CC       bench/sched-messaging.o
>    CC       bench/sched-pipe.o
>    CC       bench/syscall.o
>    CC       bench/mem-functions.o
>    CC       bench/futex-hash.o
>    CC       bench/futex-wake.o
>    CC       bench/futex-wake-parallel.o
>    CC       bench/futex-requeue.o
>    CC       bench/futex-lock-pi.o
>    CC       tests/builtin-test.o
>    CC       bench/epoll-wait.o
>    CC       bench/epoll-ctl.o
>    CC       tests/parse-events.o
>    CC       util/annotate.o
>    CC       bench/synthesize.o
>    CC       bench/kallsyms-parse.o
>    CC       bench/find-bit-bench.o
>    CC       bench/inject-buildid.o
>    CC       bench/mem-memcpy-x86-64-asm.o
>    CC       bench/mem-memset-x86-64-asm.o
>    CC       bench/numa.o
>    CC       tests/dso-data.o
>    CC       tests/attr.o
>    CC       tests/vmlinux-kallsyms.o
>    LD       bench/perf-in.o
>    CC       arch/common.o
>    CC       tests/openat-syscall.o
>    CC       arch/x86/util/header.o
>    CC       tests/openat-syscall-all-cpus.o
>    CC       arch/x86/util/tsc.o
>    CC       arch/x86/util/pmu.o
>    CC       tests/openat-syscall-tp-fields.o
>    CC       arch/x86/util/kvm-stat.o
>    CC       tests/mmap-basic.o
>    CC       arch/x86/util/perf_regs.o
>    CC       arch/x86/util/topdown.o
>    CC       tests/perf-record.o
>    CC       arch/x86/util/machine.o
>    CC       arch/x86/tests/regs_load.o
>    CC       arch/x86/tests/dwarf-unwind.o
>    CC       util/block-info.o
>    CC       arch/x86/tests/arch-tests.o
>    CC       arch/x86/util/event.o
>    CC       arch/x86/tests/rdpmc.o
>    CC       tests/evsel-roundtrip-name.o
>    CC       arch/x86/util/dwarf-regs.o
>    CC       arch/x86/util/unwind-libunwind.o
>    CC       arch/x86/tests/perf-time-to-tsc.o
>    CC       arch/x86/util/auxtrace.o
>    CC       tests/evsel-tp-sched.o
>    CC       arch/x86/util/archinsn.o
>    CC       tests/fdarray.o
>    CC       arch/x86/tests/insn-x86.o
>    CC       arch/x86/util/intel-pt.o
>    CC       arch/x86/tests/intel-pt-pkt-decoder-test.o
>    CC       tests/pmu.o
>    CC       arch/x86/tests/bp-modify.o
>    CC       util/block-range.o
>    CC       tests/pmu-events.o
>    LD       arch/x86/tests/perf-in.o
>    CC       tests/hists_common.o
>    CC       tests/hists_link.o
>    CC       util/build-id.o
>    CC       ui/setup.o
>    CC       tests/hists_filter.o
>    CC       arch/x86/util/intel-bts.o
>    CC       ui/helpline.o
>    CC       ui/progress.o
>    CC       ui/util.o
>    CC       ui/hist.o
>    CC       tests/hists_output.o
>    CC       util/cacheline.o
>    CC       util/config.o
>    LD       arch/x86/util/perf-in.o
>    LD       arch/x86/perf-in.o
>    LD       arch/perf-in.o
>    CC       tests/hists_cumulate.o
>    CC       util/copyfile.o
>    CC       util/ctype.o
>    CC       util/db-export.o
>    CC       tests/python-use.o
>    CC       tests/bp_signal.o
>    CC       tests/bp_signal_overflow.o
>    CC       tests/bp_account.o
>    CC       tests/wp.o
>    CC       tests/task-exit.o
>    CC       tests/sw-clock.o
>    CC       tests/mmap-thread-lookup.o
>    CC       util/env.o
>    CC       scripts/perl/Perf-Trace-Util/Context.o
>    CC       tests/thread-maps-share.o
>    CC       util/event.o
>    CC       tests/switch-tracking.o
>    LD       scripts/perl/Perf-Trace-Util/perf-in.o
>    CC       scripts/python/Perf-Trace-Util/Context.o
>    LD       scripts/python/Perf-Trace-Util/perf-in.o
>    LD       scripts/perf-in.o
>    CC       trace/beauty/clone.o
>    CC       tests/keep-tracking.o
>    CC       trace/beauty/fcntl.o
>    CC       tests/code-reading.o
>    CC       trace/beauty/flock.o
>    CC       util/evlist.o
>    CC       trace/beauty/fsmount.o
>    CC       trace/beauty/fspick.o
>    CC       trace/beauty/ioctl.o
>    CC       trace/beauty/kcmp.o
>    CC       trace/beauty/mount_flags.o
>    CC       trace/beauty/move_mount.o
>    CC       trace/beauty/pkey_alloc.o
>    CC       tests/sample-parsing.o
>    CC       trace/beauty/arch_prctl.o
>    CC       trace/beauty/prctl.o
>    CC       trace/beauty/renameat.o
>    CC       trace/beauty/sockaddr.o
>    CC       trace/beauty/socket.o
>    CC       trace/beauty/statx.o
>    CC       tests/parse-no-sample-id-all.o
>    CC       trace/beauty/sync_file_range.o
>    CC       tests/kmod-path.o
>    CC       trace/beauty/tracepoints/x86_irq_vectors.o
>    CC       trace/beauty/tracepoints/x86_msr.o
>    LD       trace/beauty/tracepoints/perf-in.o
>    LD       trace/beauty/perf-in.o
>    CC       perf.o
>    CC       tests/thread-map.o
>    CC       tests/llvm.o
>    CC       tests/bpf.o
>    CC       util/sideband_evlist.o
>    CC       util/evsel.o
>    CC       util/evsel_fprintf.o
>    CC       tests/topology.o
>    CC       tests/mem.o
>    CC       tests/cpumap.o
>    CC       tests/stat.o
>    CC       tests/event_update.o
>    CC       ui/stdio/hist.o
>    CC       util/perf_event_attr_fprintf.o
>    CC       tests/event-times.o
>    CC       tests/expr.o
>    CC       util/evswitch.o
>    CC       tests/backward-ring-buffer.o
>    CC       util/find_bit.o
>    CC       tests/sdt.o
>    CC       util/get_current_dir_name.o
>    CC       util/kallsyms.o
>    CC       tests/is_printable_array.o
>    CC       tests/bitmap.o
>    CC       util/levenshtein.o
>    CC       ui/browser.o
>    CC       tests/perf-hooks.o
>    CC       tests/clang.o
>    CC       util/llvm-utils.o
>    CC       tests/unit_number__scnprintf.o
>    CC       tests/mem2node.o
>    CC       tests/maps.o
>    CC       util/mmap.o
>    CC       tests/time-utils-test.o
>    CC       util/memswap.o
>    CC       ui/browsers/annotate.o
>    BISON    util/parse-events-bison.c
>    CC       util/perf_regs.o
>    CC       util/path.o
>    CC       tests/genelf.o
>    CC       ui/browsers/hists.o
>    CC       tests/api-io.o
>    CC       tests/demangle-java-test.o
>    CC       tests/pfm.o
>    CC       tests/parse-metric.o
>    CC       util/print_binary.o
>    CC       util/rlimit.o
>    CC       tests/pe-file-parsing.o
>    CC       util/argv_split.o
>    CC       tests/expand-cgroup.o
>    CC       ui/browsers/map.o
>    CC       util/rbtree.o
>    CC       ui/browsers/scripts.o
>    CC       tests/dwarf-unwind.o
>    CC       ui/browsers/header.o
>    CC       tests/llvm-src-base.o
>    CC       tests/llvm-src-kbuild.o
>    CC       tests/llvm-src-prologue.o
>    CC       tests/llvm-src-relocation.o
>    CC       ui/browsers/res_sample.o
>    LD       tests/perf-in.o
>    CC       util/libstring.o
>    CC       util/bitmap.o
>    CC       util/hweight.o
>    CC       util/smt.o
>    CC       ui/tui/setup.o
>    CC       util/strbuf.o
>    CC       util/string.o
>    CC       ui/tui/util.o
>    CC       util/strlist.o
>    CC       util/strfilter.o
>    CC       ui/tui/helpline.o
>    CC       util/top.o
>    CC       ui/tui/progress.o
>    LD       ui/tui/perf-in.o
>    CC       util/usage.o
>    CC       util/dso.o
>    CC       util/dsos.o
>    CC       util/symbol.o
>    CC       util/symbol_fprintf.o
>    CC       util/color.o
>    CC       util/color_config.o
>    CC       util/metricgroup.o
>    CC       util/header.o
>    CC       util/callchain.o
>    CC       util/values.o
>    CC       util/debug.o
>    CC       util/fncache.o
>    CC       util/machine.o
>    CC       util/map.o
>    CC       util/pstack.o
>    CC       util/session.o
>    CC       util/sample-raw.o
>    CC       util/s390-sample-raw.o
>    CC       util/syscalltbl.o
>    CC       util/ordered-events.o
>    CC       util/namespaces.o
>    LD       ui/browsers/perf-in.o
>    LD       ui/perf-in.o
>    CC       util/comm.o
>    CC       util/thread.o
>    CC       util/thread_map.o
>    CC       util/trace-event-parse.o
>    CC       util/parse-events-bison.o
>    BISON    util/pmu-bison.c
>    CC       util/trace-event-read.o
>    CC       util/trace-event-info.o
>    GEN      python/perf.so
>    CC       util/trace-event-scripting.o
>    CC       util/trace-event.o
>    CC       util/svghelper.o
>    CC       util/sort.o
>    CC       util/hist.o
>    CC       util/util.o
>    CC       util/cpumap.o
>    CC       util/affinity.o
>    CC       util/cputopo.o
>    CC       util/cgroup.o
>    CC       util/target.o
>    CC       util/rblist.o
>    CC       util/intlist.o
>    CC       util/vdso.o
>    CC       util/counts.o
>    CC       util/stat.o
>    CC       util/stat-shadow.o
>    CC       util/stat-display.o
>    CC       util/perf_api_probe.o
>    CC       util/record.o
>    CC       util/srcline.o
>    CC       util/srccode.o
>    CC       util/synthetic-events.o
>    CC       util/data.o
>    CC       util/tsc.o
>    CC       util/cloexec.o
>    CC       util/call-path.o
>    CC       util/rwsem.o
>    CC       util/thread-stack.o
>    CC       util/spark.o
>    CC       util/topdown.o
>    CC       util/stream.o
>    CC       util/auxtrace.o
>    CC       util/intel-pt-decoder/intel-pt-pkt-decoder.o
>    GEN      util/intel-pt-decoder/inat-tables.c
>    CC       util/intel-pt-decoder/intel-pt-log.o
>    CC       util/intel-pt-decoder/intel-pt-decoder.o
>    CC       util/arm-spe-decoder/arm-spe-pkt-decoder.o
>    CC       util/arm-spe-decoder/arm-spe-decoder.o
>    LD       util/arm-spe-decoder/perf-in.o
>    CC       util/scripting-engines/trace-event-perl.o
>    GEN      pmu-events/pmu-events.c
>    CC       pmu-events/pmu-events.o
>    CC       util/scripting-engines/trace-event-python.o
>    CC       util/intel-pt.o
>    LD       pmu-events/pmu-events-in.o
>    CC       util/intel-bts.o
>    CC       util/arm-spe.o
>    CC       util/intel-pt-decoder/intel-pt-insn-decoder.o
>    LD       util/scripting-engines/perf-in.o
>    CC       util/s390-cpumsf.o
>    CC       util/parse-branch-options.o
>    CC       util/dump-insn.o
>    CC       util/parse-regs-options.o
>    CC       util/parse-sublevel-options.o
>    CC       util/term.o
>    CC       util/help-unknown-cmd.o
>    CC       util/mem-events.o
>    CC       util/vsprintf.o
>    LD       util/intel-pt-decoder/perf-in.o
>    CC       util/units.o
>    CC       util/time-utils.o
>    BISON    util/expr-bison.c
>    CC       util/branch.o
>    CC       util/mem2node.o
>    CC       util/clockid.o
>    CC       util/bpf-loader.o
>    CC       util/bpf_map.o
>    CC       util/bpf-prologue.o
>    CC       util/symbol-elf.o
>    CC       util/probe-file.o
>    CC       util/probe-event.o
>    CC       util/probe-finder.o
>    CC       util/dwarf-aux.o
>    CC       util/dwarf-regs.o
>    CC       util/unwind-libunwind-local.o
>    CC       util/unwind-libunwind.o
>    CC       util/data-convert-bt.o
>    CC       util/zlib.o
>    CC       util/lzma.o
>    CC       util/zstd.o
>    CC       util/cap.o
>    CC       util/demangle-java.o
>    CC       util/demangle-rust.o
>    CC       util/jitdump.o
>    CC       util/genelf.o
>    CC       util/genelf_debug.o
>    CC       util/perf-hooks.o
>    CC       util/bpf-event.o
>    FLEX     util/parse-events-flex.c
>    FLEX     util/pmu-flex.c
>    CC       util/pmu-bison.o
>    FLEX     util/expr-flex.c
>    CC       util/expr-bison.o
>    CC       util/expr.o
>    CC       util/parse-events.o
>    CC       util/parse-events-flex.o
>    CC       util/pmu.o
>    CC       util/pmu-flex.o
>    CC       util/expr-flex.o
>    LD       util/perf-in.o
>    LD       perf-in.o
>    LINK     perf
> make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf'
> 2020-12-24 12:51:30 cd /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf
> 2020-12-24 12:51:30 mkdir -p /pkg
> 2020-12-24 12:51:30 mkdir -p /kbuild/obj/consumer/x86_64-rhel-8.3
> 2020-12-24 12:51:30 cp /pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/vmlinux.xz /tmp
> 2020-12-24 12:51:31 unxz -k /tmp/vmlinux.xz
> 2020-12-24 12:51:35 cp /tmp/vmlinux /kbuild/obj/consumer/x86_64-rhel-8.3
> ignored_by_lkp: BPF filter
> ignored_by_lkp: LLVM search and compile
> ignored_by_lkp: Add vfs_getname probe to get syscall args filenames
> ignored_by_lkp: Use vfs_getname probe to get syscall args filenames
> ignored_by_lkp: Check open filename arg using perf trace + vfs_getname
> ignored_by_lkp: builtin clang support
> 2020-12-24 12:51:35 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 1
>   1: vmlinux symtab matches kallsyms                                 : Ok
> 2020-12-24 12:51:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 2
>   2: Detect openat syscall event                                     : Ok
> 2020-12-24 12:51:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 3
>   3: Detect openat syscall event on all cpus                         : Ok
> 2020-12-24 12:51:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 4
>   4: Read samples using the mmap interface                           : FAILED!
> 2020-12-24 12:51:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 5
>   5: Test data source output                                         : Ok
> 2020-12-24 12:51:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 6
>   6: Parse event definition strings                                  : FAILED!
> 2020-12-24 12:51:37 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 7
>   7: Simple expression parser                                        : Ok
> 2020-12-24 12:51:38 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 8
>   8: PERF_RECORD_* events & perf_sample fields                       : Ok
> 2020-12-24 12:51:40 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 9
>   9: Parse perf pmu format                                           : Ok
> 2020-12-24 12:51:40 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 10
> 10: PMU events                                                      :
> 10.1: PMU event table sanity                                        : Ok
> 10.2: PMU event map aliases                                         : Ok
> 10.3: Parsing of PMU event table metrics                            : Skip (some metrics failed)
> 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> 2020-12-24 12:51:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 11
> 11: DSO data read                                                   : Ok
> 2020-12-24 12:51:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 12
> 12: DSO data cache                                                  : Ok
> 2020-12-24 12:51:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 13
> 13: DSO data reopen                                                 : Ok
> 2020-12-24 12:51:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 14
> 14: Roundtrip evsel->name                                           : Ok
> 2020-12-24 12:51:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 15
> 15: Parse sched tracepoints fields                                  : Ok
> 2020-12-24 12:51:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 16
> 16: syscalls:sys_enter_openat event fields                          : Ok
> 2020-12-24 12:51:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 17
> 17: Setup struct perf_event_attr                                    : Ok
> 2020-12-24 12:51:56 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 18
> 18: Match and link multiple hists                                   : Ok
> 2020-12-24 12:51:56 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 19
> 19: 'import perf' in python                                         : FAILED!
> 2020-12-24 12:51:56 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 20
> 20: Breakpoint overflow signal handler                              : Ok
> 2020-12-24 12:51:56 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 21
> 21: Breakpoint overflow sampling                                    : Ok
> 2020-12-24 12:51:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 22
> 22: Breakpoint accounting                                           : Ok
> 2020-12-24 12:51:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 23
> 23: Watchpoint                                                      :
> 23.1: Read Only Watchpoint                                          : Skip
> 23.2: Write Only Watchpoint                                         : Ok
> 23.3: Read / Write Watchpoint                                       : Ok
> 23.4: Modify Watchpoint                                             : Ok
> 2020-12-24 12:51:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 24
> 24: Number of exit events of a simple workload                      : FAILED!
> 2020-12-24 12:51:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 25
> 25: Software clock events period values                             : FAILED!
> 2020-12-24 12:51:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 26
> 26: Object code reading                                             : FAILED!
> 2020-12-24 12:52:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 27
> 27: Sample parsing                                                  : Ok
> 2020-12-24 12:52:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 28
> 28: Use a dummy software event to keep tracking                     : FAILED!
> 2020-12-24 12:52:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 29
> 29: Parse with no sample_id_all bit set                             : Ok
> 2020-12-24 12:52:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 30
> 30: Filter hist entries                                             : Ok
> 2020-12-24 12:52:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 31
> 31: Lookup mmap thread                                              : FAILED!
> 2020-12-24 12:52:01 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 32
> 32: Share thread maps                                               : Ok
> 2020-12-24 12:52:01 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 33
> 33: Sort output of hist entries                                     : Ok
> 2020-12-24 12:52:01 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 34
> 34: Cumulate child hist entries                                     : Ok
> 2020-12-24 12:52:01 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 35
> 35: Track with sched_switch                                         : FAILED!
> 2020-12-24 12:52:01 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 36
> 36: Filter fds with revents mask in a fdarray                       : Ok
> 2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 37
> 37: Add fd to a fdarray, making it autogrow                         : Ok
> 2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 38
> 38: kmod_path__parse                                                : Ok
> 2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 39
> 39: Thread map                                                      : Ok
> 2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 41
> 41: Session topology                                                : FAILED!
> 2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 43
> 43: Synthesize thread map                                           : FAILED!
> 2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 44
> 44: Remove thread map                                               : FAILED!
> 2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 45
> 45: Synthesize cpu map                                              : Ok
> 2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 46
> 46: Synthesize stat config                                          : Ok
> 2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 47
> 47: Synthesize stat                                                 : Ok
> 2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 48
> 48: Synthesize stat round                                           : Ok
> 2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 49
> 49: Synthesize attr update                                          : FAILED!
> 2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 50
> 50: Event times                                                     : Ok
> 2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 51
> 51: Read backward ring buffer                                       : Ok
> 2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 52
> 52: Print cpu map                                                   : FAILED!
> 2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 53
> 53: Merge cpu map                                                   : Ok
> 2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 54
> 54: Probe SDT events                                                : Ok
> 2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 55
> 55: is_printable_array                                              : Ok
> 2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 56
> 56: Print bitmap                                                    : Ok
> 2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 57
> 57: perf hooks                                                      : Ok
> 2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 59
> 59: unit_number__scnprintf                                          : Ok
> 2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 60
> 60: mem2node                                                        : Ok
> 2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 61
> 61: time utils                                                      : Ok
> 2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 62
> 62: Test jit_write_elf                                              : Ok
> 2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 63
> 63: Test libpfm4 support                                            : Skip (not compiled in)
> 2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 64
> 64: Test api io                                                     : Ok
> 2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 65
> 65: maps__merge_in                                                  : FAILED!
> 2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 66
> 66: Demangle Java                                                   : Ok
> 2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 67
> 67: Parse and process metrics                                       : Ok
> 2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 68
> 68: PE file support                                                 : FAILED!
> 2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 69
> 69: Event expansion for cgroups                                     : Ok
> 2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 70
> 70: x86 rdpmc                                                       : Ok
> 2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 71
> 71: Convert perf time to TSC                                        : FAILED!
> 2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 72
> 72: DWARF unwind                                                    : FAILED!
> 2020-12-24 12:52:05 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 73
> 73: x86 instruction decoder - new instructions                      : Ok
> 2020-12-24 12:52:05 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 74
> 74: Intel PT packet decoder                                         : Ok
> 2020-12-24 12:52:05 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 75
> 75: x86 bp modify                                                   : Ok
> 2020-12-24 12:52:05 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 76
> 76: probe libc's inet_pton & backtrace it with ping                 : Ok
> 2020-12-24 12:52:07 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 77
> 77: Check Arm CoreSight trace data recording and synthesized samples: Skip
> 2020-12-24 12:52:07 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 78
> 78: build id cache operations                                       : FAILED!
> 2020-12-24 12:52:08 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 81
> 81: Zstd perf.data compression/decompression                        : FAILED!
> 
> 
> 
> To reproduce:
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp install                job.yaml  # job file is attached in this email
>          bin/lkp split-job --compatible job.yaml
>          bin/lkp run                    compatible-job.yaml
> 
> 
> 
> Thanks,
> Oliver Sang
> 
