Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4033237F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 08:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhBXHem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 02:34:42 -0500
Received: from mga03.intel.com ([134.134.136.65]:35969 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232417AbhBXHe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:34:28 -0500
IronPort-SDR: UYKq9zGdFxi4DeidkldOgvnxF6RPL4CtNzWX7cNERAimgzQe6gYZAg8eLjMKQGvcc8y38NhVzr
 Kf0hJFdWhgoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="185131699"
X-IronPort-AV: E=Sophos;i="5.81,202,1610438400"; 
   d="yaml'?scan'208";a="185131699"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 23:33:16 -0800
IronPort-SDR: 2NCAQXFAfyPwsUsMJnXFWZ7nH/NAdyc9XwW/S6AqF58OvHiKuc9+3VzEWP1sNug+Ki29wPBAi3
 zowIwPIQU1dA==
X-IronPort-AV: E=Sophos;i="5.81,202,1610438400"; 
   d="yaml'?scan'208";a="391456079"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 23:33:10 -0800
Date:   Wed, 24 Feb 2021 15:48:41 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: [drm/i915/gt]  8c3b1ba0e7:
 perf-sanity-tests.Parse_event_definition_strings.fail
Message-ID: <20210224074841.GD6114@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8nsIa27JVQLqB7/C"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: 8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813 ("drm/i915/gt: Track the o=
verall awake/busy time")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: perf-sanity-tests
version:=20
with following parameters:

	perf_compiler: gcc
	ucode: 0xe2



on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G=
 memory

caused below changes (please refer to attached dmesg/kmsg for entire log/ba=
cktrace):




If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>

please be noted this was reported on last December
https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/ZPLGWG47V7CIZI=
L3TEP3E7NBT6E5C3XA/

since already merged into mainline and the issue still exist on current mas=
ter HEAD,
report again.


2020-12-24 12:50:16 make ARCH=3D EXTRA_CFLAGS=3D-fno-omit-frame-pointer -fs=
anitize=3Dundefined -fsanitize=3Daddress -C /usr/src/perf_selftests-x86_64-=
rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e=
7ea9a80b0ee4b4445ea59c806787813/tools/perf'
  BUILD:   Doing 'make =1B[33m-j4=1B[m' parallel build
  HOSTCC   fixdep.o
  HOSTLD   fixdep-in.o
  LINK     fixdep
diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
diff -u tools/arch/x86/lib/memset_64.S arch/x86/lib/memset_64.S

Auto-detecting system features:
=2E..                         dwarf: [ =1B[32mon=1B[m  ]
=2E..            dwarf_getlocations: [ =1B[32mon=1B[m  ]
=2E..                         glibc: [ =1B[32mon=1B[m  ]
=2E..                        libbfd: [ =1B[32mon=1B[m  ]
=2E..                libbfd-buildid: [ =1B[32mon=1B[m  ]
=2E..                        libcap: [ =1B[32mon=1B[m  ]
=2E..                        libelf: [ =1B[32mon=1B[m  ]
=2E..                       libnuma: [ =1B[32mon=1B[m  ]
=2E..        numa_num_possible_cpus: [ =1B[32mon=1B[m  ]
=2E..                       libperl: [ =1B[32mon=1B[m  ]
=2E..                     libpython: [ =1B[32mon=1B[m  ]
=2E..                     libcrypto: [ =1B[32mon=1B[m  ]
=2E..                     libunwind: [ =1B[32mon=1B[m  ]
=2E..            libdw-dwarf-unwind: [ =1B[32mon=1B[m  ]
=2E..                          zlib: [ =1B[32mon=1B[m  ]
=2E..                          lzma: [ =1B[32mon=1B[m  ]
=2E..                     get_cpuid: [ =1B[32mon=1B[m  ]
=2E..                           bpf: [ =1B[32mon=1B[m  ]
=2E..                        libaio: [ =1B[32mon=1B[m  ]
=2E..                       libzstd: [ =1B[32mon=1B[m  ]
=2E..        disassembler-four-args: [ =1B[32mon=1B[m  ]

  CC       fd/array.o
  CC       exec-cmd.o
  CC       event-parse.o
  CC       core.o
  LD       fd/libapi-in.o
  CC       fs/fs.o
  CC       cpumap.o
  CC       help.o
  CC       fs/tracing_path.o
  CC       fs/cgroup.o
  LD       fs/libapi-in.o
  CC       cpu.o
  CC       threadmap.o
  CC       debug.o
  CC       pager.o
  CC       str_error_r.o
  LD       libapi-in.o
  AR       libapi.a
  CC       parse-options.o
  CC       event-plugin.o
  CC       evsel.o
  CC       trace-seq.o
  CC       parse-filter.o
  CC       evlist.o
  CC       mmap.o
  CC       parse-utils.o
  CC       kbuffer-parse.o
  CC       zalloc.o
  CC       tep_strerror.o
  CC       event-parse-api.o
  CC       xyarray.o
  LD       libtraceevent-in.o
  LINK     libtraceevent.a
  CC       lib.o
  GEN      bpf_helper_defs.h
  MKDIR    staticobjs/
  CC       staticobjs/libbpf.o
  LD       libperf-in.o
  AR       libperf.a
  GEN      common-cmds.h
  CC       run-command.o
  CC       sigchain.o
  CC       subcmd-config.o
  LD       libsubcmd-in.o
  MKDIR    staticobjs/
  AR       libsubcmd.a
  CC       staticobjs/bpf.o
  CC       staticobjs/nlattr.o
  CC       staticobjs/btf.o
  HOSTCC   pmu-events/json.o
  HOSTCC   pmu-events/jsmn.o
  HOSTCC   pmu-events/jevents.o
  HOSTLD   pmu-events/jevents-in.o
  CC       plugin_jbd2.o
  LD       plugin_jbd2-in.o
  CC       plugin_hrtimer.o
  LD       plugin_hrtimer-in.o
  CC       plugin_kmem.o
  LD       plugin_kmem-in.o
  CC       plugin_kvm.o
  LD       plugin_kvm-in.o
  CC       staticobjs/libbpf_errno.o
  CC       plugin_mac80211.o
  CC       staticobjs/str_error.o
  CC       staticobjs/netlink.o
  LD       plugin_mac80211-in.o
  CC       plugin_sched_switch.o
  LD       plugin_sched_switch-in.o
  CC       plugin_function.o
  CC       staticobjs/bpf_prog_linfo.o
  LD       plugin_function-in.o
  CC       plugin_futex.o
  CC       staticobjs/libbpf_probes.o
  LD       plugin_futex-in.o
  CC       plugin_xen.o
  CC       staticobjs/xsk.o
  LD       plugin_xen-in.o
  CC       plugin_scsi.o
  CC       staticobjs/hashmap.o
  LD       plugin_scsi-in.o
  CC       plugin_tlb.o
  CC       plugin_cfg80211.o
  CC       jvmti/libjvmti.o
  LD       plugin_cfg80211-in.o
  GEN      perf-archive
  LD       plugin_tlb-in.o
  LINK     plugin_jbd2.so
  GEN      perf-with-kcore
  CC       jvmti/jvmti_agent.o
  CC       staticobjs/btf_dump.o
  LINK     plugin_hrtimer.so
  LINK     plugin_kmem.so
  LINK     plugin_kvm.so
  LINK     plugin_mac80211.so
  CC       staticobjs/ringbuf.o
  LINK     plugin_sched_switch.so
  LINK     plugin_function.so
  LINK     plugin_futex.so
  LINK     plugin_xen.so
  LD       staticobjs/libbpf-in.o
  LINK     libbpf.a
  LINK     plugin_scsi.so
  CC       jvmti/libstring.o
  LINK     plugin_cfg80211.so
  CC       builtin-bench.o
  LINK     plugin_tlb.so
  GEN      libtraceevent-dynamic-list
  CC       jvmti/libctype.o
  CC       builtin-annotate.o
  CC       builtin-config.o
  LD       jvmti/jvmti-in.o
  CC       builtin-diff.o
  LINK     pmu-events/jevents
  CC       builtin-evlist.o
  CC       builtin-ftrace.o
  LINK     libperf-jvmti.so
  CC       builtin-help.o
  CC       builtin-sched.o
  CC       builtin-buildid-list.o
  CC       builtin-buildid-cache.o
  CC       builtin-kallsyms.o
  CC       builtin-list.o
  CC       builtin-record.o
  CC       builtin-report.o
  CC       builtin-stat.o
  CC       builtin-timechart.o
  CC       builtin-top.o
  CC       builtin-script.o
  CC       builtin-kmem.o
  CC       builtin-lock.o
  CC       builtin-kvm.o
  CC       builtin-inject.o
  CC       builtin-mem.o
  CC       builtin-data.o
  CC       builtin-version.o
  CC       builtin-c2c.o
  CC       builtin-trace.o
  CC       builtin-probe.o
  CC       bench/sched-messaging.o
  CC       bench/sched-pipe.o
  CC       bench/syscall.o
  CC       bench/mem-functions.o
  CC       bench/futex-hash.o
  CC       bench/futex-wake.o
  CC       bench/futex-wake-parallel.o
  CC       bench/futex-requeue.o
  CC       bench/futex-lock-pi.o
  CC       tests/builtin-test.o
  CC       bench/epoll-wait.o
  CC       bench/epoll-ctl.o
  CC       tests/parse-events.o
  CC       util/annotate.o
  CC       bench/synthesize.o
  CC       bench/kallsyms-parse.o
  CC       bench/find-bit-bench.o
  CC       bench/inject-buildid.o
  CC       bench/mem-memcpy-x86-64-asm.o
  CC       bench/mem-memset-x86-64-asm.o
  CC       bench/numa.o
  CC       tests/dso-data.o
  CC       tests/attr.o
  CC       tests/vmlinux-kallsyms.o
  LD       bench/perf-in.o
  CC       arch/common.o
  CC       tests/openat-syscall.o
  CC       arch/x86/util/header.o
  CC       tests/openat-syscall-all-cpus.o
  CC       arch/x86/util/tsc.o
  CC       arch/x86/util/pmu.o
  CC       tests/openat-syscall-tp-fields.o
  CC       arch/x86/util/kvm-stat.o
  CC       tests/mmap-basic.o
  CC       arch/x86/util/perf_regs.o
  CC       arch/x86/util/topdown.o
  CC       tests/perf-record.o
  CC       arch/x86/util/machine.o
  CC       arch/x86/tests/regs_load.o
  CC       arch/x86/tests/dwarf-unwind.o
  CC       util/block-info.o
  CC       arch/x86/tests/arch-tests.o
  CC       arch/x86/util/event.o
  CC       arch/x86/tests/rdpmc.o
  CC       tests/evsel-roundtrip-name.o
  CC       arch/x86/util/dwarf-regs.o
  CC       arch/x86/util/unwind-libunwind.o
  CC       arch/x86/tests/perf-time-to-tsc.o
  CC       arch/x86/util/auxtrace.o
  CC       tests/evsel-tp-sched.o
  CC       arch/x86/util/archinsn.o
  CC       tests/fdarray.o
  CC       arch/x86/tests/insn-x86.o
  CC       arch/x86/util/intel-pt.o
  CC       arch/x86/tests/intel-pt-pkt-decoder-test.o
  CC       tests/pmu.o
  CC       arch/x86/tests/bp-modify.o
  CC       util/block-range.o
  CC       tests/pmu-events.o
  LD       arch/x86/tests/perf-in.o
  CC       tests/hists_common.o
  CC       tests/hists_link.o
  CC       util/build-id.o
  CC       ui/setup.o
  CC       tests/hists_filter.o
  CC       arch/x86/util/intel-bts.o
  CC       ui/helpline.o
  CC       ui/progress.o
  CC       ui/util.o
  CC       ui/hist.o
  CC       tests/hists_output.o
  CC       util/cacheline.o
  CC       util/config.o
  LD       arch/x86/util/perf-in.o
  LD       arch/x86/perf-in.o
  LD       arch/perf-in.o
  CC       tests/hists_cumulate.o
  CC       util/copyfile.o
  CC       util/ctype.o
  CC       util/db-export.o
  CC       tests/python-use.o
  CC       tests/bp_signal.o
  CC       tests/bp_signal_overflow.o
  CC       tests/bp_account.o
  CC       tests/wp.o
  CC       tests/task-exit.o
  CC       tests/sw-clock.o
  CC       tests/mmap-thread-lookup.o
  CC       util/env.o
  CC       scripts/perl/Perf-Trace-Util/Context.o
  CC       tests/thread-maps-share.o
  CC       util/event.o
  CC       tests/switch-tracking.o
  LD       scripts/perl/Perf-Trace-Util/perf-in.o
  CC       scripts/python/Perf-Trace-Util/Context.o
  LD       scripts/python/Perf-Trace-Util/perf-in.o
  LD       scripts/perf-in.o
  CC       trace/beauty/clone.o
  CC       tests/keep-tracking.o
  CC       trace/beauty/fcntl.o
  CC       tests/code-reading.o
  CC       trace/beauty/flock.o
  CC       util/evlist.o
  CC       trace/beauty/fsmount.o
  CC       trace/beauty/fspick.o
  CC       trace/beauty/ioctl.o
  CC       trace/beauty/kcmp.o
  CC       trace/beauty/mount_flags.o
  CC       trace/beauty/move_mount.o
  CC       trace/beauty/pkey_alloc.o
  CC       tests/sample-parsing.o
  CC       trace/beauty/arch_prctl.o
  CC       trace/beauty/prctl.o
  CC       trace/beauty/renameat.o
  CC       trace/beauty/sockaddr.o
  CC       trace/beauty/socket.o
  CC       trace/beauty/statx.o
  CC       tests/parse-no-sample-id-all.o
  CC       trace/beauty/sync_file_range.o
  CC       tests/kmod-path.o
  CC       trace/beauty/tracepoints/x86_irq_vectors.o
  CC       trace/beauty/tracepoints/x86_msr.o
  LD       trace/beauty/tracepoints/perf-in.o
  LD       trace/beauty/perf-in.o
  CC       perf.o
  CC       tests/thread-map.o
  CC       tests/llvm.o
  CC       tests/bpf.o
  CC       util/sideband_evlist.o
  CC       util/evsel.o
  CC       util/evsel_fprintf.o
  CC       tests/topology.o
  CC       tests/mem.o
  CC       tests/cpumap.o
  CC       tests/stat.o
  CC       tests/event_update.o
  CC       ui/stdio/hist.o
  CC       util/perf_event_attr_fprintf.o
  CC       tests/event-times.o
  CC       tests/expr.o
  CC       util/evswitch.o
  CC       tests/backward-ring-buffer.o
  CC       util/find_bit.o
  CC       tests/sdt.o
  CC       util/get_current_dir_name.o
  CC       util/kallsyms.o
  CC       tests/is_printable_array.o
  CC       tests/bitmap.o
  CC       util/levenshtein.o
  CC       ui/browser.o
  CC       tests/perf-hooks.o
  CC       tests/clang.o
  CC       util/llvm-utils.o
  CC       tests/unit_number__scnprintf.o
  CC       tests/mem2node.o
  CC       tests/maps.o
  CC       util/mmap.o
  CC       tests/time-utils-test.o
  CC       util/memswap.o
  CC       ui/browsers/annotate.o
  BISON    util/parse-events-bison.c
  CC       util/perf_regs.o
  CC       util/path.o
  CC       tests/genelf.o
  CC       ui/browsers/hists.o
  CC       tests/api-io.o
  CC       tests/demangle-java-test.o
  CC       tests/pfm.o
  CC       tests/parse-metric.o
  CC       util/print_binary.o
  CC       util/rlimit.o
  CC       tests/pe-file-parsing.o
  CC       util/argv_split.o
  CC       tests/expand-cgroup.o
  CC       ui/browsers/map.o
  CC       util/rbtree.o
  CC       ui/browsers/scripts.o
  CC       tests/dwarf-unwind.o
  CC       ui/browsers/header.o
  CC       tests/llvm-src-base.o
  CC       tests/llvm-src-kbuild.o
  CC       tests/llvm-src-prologue.o
  CC       tests/llvm-src-relocation.o
  CC       ui/browsers/res_sample.o
  LD       tests/perf-in.o
  CC       util/libstring.o
  CC       util/bitmap.o
  CC       util/hweight.o
  CC       util/smt.o
  CC       ui/tui/setup.o
  CC       util/strbuf.o
  CC       util/string.o
  CC       ui/tui/util.o
  CC       util/strlist.o
  CC       util/strfilter.o
  CC       ui/tui/helpline.o
  CC       util/top.o
  CC       ui/tui/progress.o
  LD       ui/tui/perf-in.o
  CC       util/usage.o
  CC       util/dso.o
  CC       util/dsos.o
  CC       util/symbol.o
  CC       util/symbol_fprintf.o
  CC       util/color.o
  CC       util/color_config.o
  CC       util/metricgroup.o
  CC       util/header.o
  CC       util/callchain.o
  CC       util/values.o
  CC       util/debug.o
  CC       util/fncache.o
  CC       util/machine.o
  CC       util/map.o
  CC       util/pstack.o
  CC       util/session.o
  CC       util/sample-raw.o
  CC       util/s390-sample-raw.o
  CC       util/syscalltbl.o
  CC       util/ordered-events.o
  CC       util/namespaces.o
  LD       ui/browsers/perf-in.o
  LD       ui/perf-in.o
  CC       util/comm.o
  CC       util/thread.o
  CC       util/thread_map.o
  CC       util/trace-event-parse.o
  CC       util/parse-events-bison.o
  BISON    util/pmu-bison.c
  CC       util/trace-event-read.o
  CC       util/trace-event-info.o
  GEN      python/perf.so
  CC       util/trace-event-scripting.o
  CC       util/trace-event.o
  CC       util/svghelper.o
  CC       util/sort.o
  CC       util/hist.o
  CC       util/util.o
  CC       util/cpumap.o
  CC       util/affinity.o
  CC       util/cputopo.o
  CC       util/cgroup.o
  CC       util/target.o
  CC       util/rblist.o
  CC       util/intlist.o
  CC       util/vdso.o
  CC       util/counts.o
  CC       util/stat.o
  CC       util/stat-shadow.o
  CC       util/stat-display.o
  CC       util/perf_api_probe.o
  CC       util/record.o
  CC       util/srcline.o
  CC       util/srccode.o
  CC       util/synthetic-events.o
  CC       util/data.o
  CC       util/tsc.o
  CC       util/cloexec.o
  CC       util/call-path.o
  CC       util/rwsem.o
  CC       util/thread-stack.o
  CC       util/spark.o
  CC       util/topdown.o
  CC       util/stream.o
  CC       util/auxtrace.o
  CC       util/intel-pt-decoder/intel-pt-pkt-decoder.o
  GEN      util/intel-pt-decoder/inat-tables.c
  CC       util/intel-pt-decoder/intel-pt-log.o
  CC       util/intel-pt-decoder/intel-pt-decoder.o
  CC       util/arm-spe-decoder/arm-spe-pkt-decoder.o
  CC       util/arm-spe-decoder/arm-spe-decoder.o
  LD       util/arm-spe-decoder/perf-in.o
  CC       util/scripting-engines/trace-event-perl.o
  GEN      pmu-events/pmu-events.c
  CC       pmu-events/pmu-events.o
  CC       util/scripting-engines/trace-event-python.o
  CC       util/intel-pt.o
  LD       pmu-events/pmu-events-in.o
  CC       util/intel-bts.o
  CC       util/arm-spe.o
  CC       util/intel-pt-decoder/intel-pt-insn-decoder.o
  LD       util/scripting-engines/perf-in.o
  CC       util/s390-cpumsf.o
  CC       util/parse-branch-options.o
  CC       util/dump-insn.o
  CC       util/parse-regs-options.o
  CC       util/parse-sublevel-options.o
  CC       util/term.o
  CC       util/help-unknown-cmd.o
  CC       util/mem-events.o
  CC       util/vsprintf.o
  LD       util/intel-pt-decoder/perf-in.o
  CC       util/units.o
  CC       util/time-utils.o
  BISON    util/expr-bison.c
  CC       util/branch.o
  CC       util/mem2node.o
  CC       util/clockid.o
  CC       util/bpf-loader.o
  CC       util/bpf_map.o
  CC       util/bpf-prologue.o
  CC       util/symbol-elf.o
  CC       util/probe-file.o
  CC       util/probe-event.o
  CC       util/probe-finder.o
  CC       util/dwarf-aux.o
  CC       util/dwarf-regs.o
  CC       util/unwind-libunwind-local.o
  CC       util/unwind-libunwind.o
  CC       util/data-convert-bt.o
  CC       util/zlib.o
  CC       util/lzma.o
  CC       util/zstd.o
  CC       util/cap.o
  CC       util/demangle-java.o
  CC       util/demangle-rust.o
  CC       util/jitdump.o
  CC       util/genelf.o
  CC       util/genelf_debug.o
  CC       util/perf-hooks.o
  CC       util/bpf-event.o
  FLEX     util/parse-events-flex.c
  FLEX     util/pmu-flex.c
  CC       util/pmu-bison.o
  FLEX     util/expr-flex.c
  CC       util/expr-bison.o
  CC       util/expr.o
  CC       util/parse-events.o
  CC       util/parse-events-flex.o
  CC       util/pmu.o
  CC       util/pmu-flex.o
  CC       util/expr-flex.o
  LD       util/perf-in.o
  LD       perf-in.o
  LINK     perf
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf'
2020-12-24 12:51:30 cd /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea=
9a80b0ee4b4445ea59c806787813/tools/perf
2020-12-24 12:51:30 mkdir -p /pkg
2020-12-24 12:51:30 mkdir -p /kbuild/obj/consumer/x86_64-rhel-8.3
2020-12-24 12:51:30 cp /pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0e=
e4b4445ea59c806787813/vmlinux.xz /tmp
2020-12-24 12:51:31 unxz -k /tmp/vmlinux.xz
2020-12-24 12:51:35 cp /tmp/vmlinux /kbuild/obj/consumer/x86_64-rhel-8.3
ignored_by_lkp: BPF filter
ignored_by_lkp: LLVM search and compile
ignored_by_lkp: Add vfs_getname probe to get syscall args filenames
ignored_by_lkp: Use vfs_getname probe to get syscall args filenames
ignored_by_lkp: Check open filename arg using perf trace + vfs_getname
ignored_by_lkp: builtin clang support
2020-12-24 12:51:35 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 1
 1: vmlinux symtab matches kallsyms                                 : Ok
2020-12-24 12:51:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 2
 2: Detect openat syscall event                                     : Ok
2020-12-24 12:51:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 3
 3: Detect openat syscall event on all cpus                         : Ok
2020-12-24 12:51:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 4
 4: Read samples using the mmap interface                           : FAILE=
D!
2020-12-24 12:51:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 5
 5: Test data source output                                         : Ok
2020-12-24 12:51:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 6
 6: Parse event definition strings                                  : FAILE=
D!
2020-12-24 12:51:37 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 7
 7: Simple expression parser                                        : Ok
2020-12-24 12:51:38 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 8
 8: PERF_RECORD_* events & perf_sample fields                       : Ok
2020-12-24 12:51:40 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 9
 9: Parse perf pmu format                                           : Ok
2020-12-24 12:51:40 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 10
10: PMU events                                                      :
10.1: PMU event table sanity                                        : Ok
10.2: PMU event map aliases                                         : Ok
10.3: Parsing of PMU event table metrics                            : Skip =
(some metrics failed)
10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
2020-12-24 12:51:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 11
11: DSO data read                                                   : Ok
2020-12-24 12:51:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 12
12: DSO data cache                                                  : Ok
2020-12-24 12:51:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 13
13: DSO data reopen                                                 : Ok
2020-12-24 12:51:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 14
14: Roundtrip evsel->name                                           : Ok
2020-12-24 12:51:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 15
15: Parse sched tracepoints fields                                  : Ok
2020-12-24 12:51:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 16
16: syscalls:sys_enter_openat event fields                          : Ok
2020-12-24 12:51:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 17
17: Setup struct perf_event_attr                                    : Ok
2020-12-24 12:51:56 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 18
18: Match and link multiple hists                                   : Ok
2020-12-24 12:51:56 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 19
19: 'import perf' in python                                         : FAILE=
D!
2020-12-24 12:51:56 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 20
20: Breakpoint overflow signal handler                              : Ok
2020-12-24 12:51:56 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 21
21: Breakpoint overflow sampling                                    : Ok
2020-12-24 12:51:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 22
22: Breakpoint accounting                                           : Ok
2020-12-24 12:51:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 23
23: Watchpoint                                                      :
23.1: Read Only Watchpoint                                          : Skip
23.2: Write Only Watchpoint                                         : Ok
23.3: Read / Write Watchpoint                                       : Ok
23.4: Modify Watchpoint                                             : Ok
2020-12-24 12:51:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 24
24: Number of exit events of a simple workload                      : FAILE=
D!
2020-12-24 12:51:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 25
25: Software clock events period values                             : FAILE=
D!
2020-12-24 12:51:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 26
26: Object code reading                                             : FAILE=
D!
2020-12-24 12:52:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 27
27: Sample parsing                                                  : Ok
2020-12-24 12:52:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 28
28: Use a dummy software event to keep tracking                     : FAILE=
D!
2020-12-24 12:52:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 29
29: Parse with no sample_id_all bit set                             : Ok
2020-12-24 12:52:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 30
30: Filter hist entries                                             : Ok
2020-12-24 12:52:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 31
31: Lookup mmap thread                                              : FAILE=
D!
2020-12-24 12:52:01 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 32
32: Share thread maps                                               : Ok
2020-12-24 12:52:01 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 33
33: Sort output of hist entries                                     : Ok
2020-12-24 12:52:01 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 34
34: Cumulate child hist entries                                     : Ok
2020-12-24 12:52:01 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 35
35: Track with sched_switch                                         : FAILE=
D!
2020-12-24 12:52:01 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 36
36: Filter fds with revents mask in a fdarray                       : Ok
2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 37
37: Add fd to a fdarray, making it autogrow                         : Ok
2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 38
38: kmod_path__parse                                                : Ok
2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 39
39: Thread map                                                      : Ok
2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 41
41: Session topology                                                : FAILE=
D!
2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 43
43: Synthesize thread map                                           : FAILE=
D!
2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 44
44: Remove thread map                                               : FAILE=
D!
2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 45
45: Synthesize cpu map                                              : Ok
2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 46
46: Synthesize stat config                                          : Ok
2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 47
47: Synthesize stat                                                 : Ok
2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 48
48: Synthesize stat round                                           : Ok
2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 49
49: Synthesize attr update                                          : FAILE=
D!
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 50
50: Event times                                                     : Ok
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 51
51: Read backward ring buffer                                       : Ok
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 52
52: Print cpu map                                                   : FAILE=
D!
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 53
53: Merge cpu map                                                   : Ok
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 54
54: Probe SDT events                                                : Ok
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 55
55: is_printable_array                                              : Ok
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 56
56: Print bitmap                                                    : Ok
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 57
57: perf hooks                                                      : Ok
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 59
59: unit_number__scnprintf                                          : Ok
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 60
60: mem2node                                                        : Ok
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 61
61: time utils                                                      : Ok
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 62
62: Test jit_write_elf                                              : Ok
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 63
63: Test libpfm4 support                                            : Skip =
(not compiled in)
2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 64
64: Test api io                                                     : Ok
2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 65
65: maps__merge_in                                                  : FAILE=
D!
2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 66
66: Demangle Java                                                   : Ok
2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 67
67: Parse and process metrics                                       : Ok
2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 68
68: PE file support                                                 : FAILE=
D!
2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 69
69: Event expansion for cgroups                                     : Ok
2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 70
70: x86 rdpmc                                                       : Ok
2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 71
71: Convert perf time to TSC                                        : FAILE=
D!
2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 72
72: DWARF unwind                                                    : FAILE=
D!
2020-12-24 12:52:05 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 73
73: x86 instruction decoder - new instructions                      : Ok
2020-12-24 12:52:05 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 74
74: Intel PT packet decoder                                         : Ok
2020-12-24 12:52:05 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 75
75: x86 bp modify                                                   : Ok
2020-12-24 12:52:05 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 76
76: probe libc's inet_pton & backtrace it with ping                 : Ok
2020-12-24 12:52:07 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 77
77: Check Arm CoreSight trace data recording and synthesized samples: Skip
2020-12-24 12:52:07 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 78
78: build id cache operations                                       : FAILE=
D!
2020-12-24 12:52:08 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 81
81: Zstd perf.data compression/decompression                        : FAILE=
D!



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install                job.yaml  # job file is attached in =
this email
        bin/lkp split-job --compatible job.yaml
        bin/lkp run                    compatible-job.yaml



Thanks,
Oliver Sang


--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='perf-sanity-tests'
	export testcase='perf-sanity-tests'
	export category='functional'
	export need_memory='2G'
	export job_origin='/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-skl-d04/perf-sanity-tests.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-skl-d04'
	export tbox_group='lkp-skl-d04'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='5fe49e2bb99997296ce28ab9'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813-20201224-10604-1smgflm-2.yaml'
	export id='2328ebc5ab86b596d1cf265ac0241d3781f54e8f'
	export queuer_version='/lkp-src'
	export model='Skylake'
	export nr_cpu=4
	export memory='32G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/ata-ST1000DM003-1ER162_Z4YB7AEL-part*'
	export ssd_partitions='/dev/disk/by-id/wwn-0x55cd2e404b64c499-part2'
	export rootfs_partition='/dev/disk/by-id/wwn-0x55cd2e404b64c499-part1'
	export brand='Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz'
	export need_linux_perf=true
	export commit='8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813'
	export need_kconfig_hw='CONFIG_E1000E=y
CONFIG_SATA_AHCI'
	export ucode='0xe2'
	export enqueue_time='2020-12-24 21:57:03 +0800'
	export _id='5fe49e2bb99997296ce28ab9'
	export _rt='/result/perf-sanity-tests/gcc-ucode=0xe2/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='1b32c6cf0d6c9a541f095fe99e23c9ecd80eee26'
	export base_commit='2c85ebc57b3e1817b6ce1a6b703928e113a90442'
	export branch='drm-intel/drm-intel-gt-next'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/perf-sanity-tests/gcc-ucode=0xe2/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/3'
	export scheduler_version='/lkp/lkp/.src-20201224-092605'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813-20201224-10604-1smgflm-2.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=drm-intel/drm-intel-gt-next
commit=8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/vmlinuz-5.10.0-rc3-01127-g8c3b1ba0e7ea
max_uptime=2100
RESULT_ROOT=/result/perf-sanity-tests/gcc-ucode=0xe2/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/3
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/modules.cgz'
	export linux_perf_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/linux-perf.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf-sanity-tests_20201111.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-fa02fcd94b0c-1_20201126.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20201117.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='4.20.0'
	export repeat_to=4
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/vmlinuz-5.10.0-rc3-01127-g8c3b1ba0e7ea'
	export dequeue_time='2020-12-24 22:00:59 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813-20201224-10604-1smgflm-2.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test perf_compiler='gcc' $LKP_SRC/tests/wrapper perf-sanity-tests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper perf-sanity-tests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time perf-sanity-tests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg
Content-Transfer-Encoding: quoted-printable

Decompressing Linux... Parsing ELF... No relocation needed... done.
Booting the kernel.
[    0.000000] Linux version 5.10.0-rc3-01127-g8c3b1ba0e7ea (kbuild@ef0b816=
f83ac) (gcc-9 (Debian 9.3.0-15) 9.3.0, GNU ld (GNU Binutils for Debian) 2.3=
5) #1 SMP Thu Dec 24 12:43:54 CST 2020
[    0.000000] Command line: ip=3D::::lkp-skl-d04::dhcp root=3D/dev/ram0 us=
er=3Dlkp job=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=
=3D0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c8067=
87813-20201226-25066-sfkgan-4.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3 =
branch=3Ddrm-intel/drm-intel-gt-next commit=3D8c3b1ba0e7ea9a80b0ee4b4445ea5=
9c806787813 BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b=
0ee4b4445ea59c806787813/vmlinuz-5.10.0-rc3-01127-g8c3b1ba0e7ea max_uptime=
=3D2100 RESULT_ROOT=3D/result/perf-sanity-tests/gcc-ucode=3D0xe2/lkp-skl-d0=
4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0e=
e4b4445ea59c806787813/5 LKP_SERVER=3Dinternal-lkp-server nokaslr selinux=3D=
0 debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D=
100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi=
_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.min=
or_count=3D8 systemd.log_level=3Derr ignore_loglevel console=3Dtty0 earlypr=
intk=3DttyS0,11
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registe=
rs'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 b=
ytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000100-0x000000000009c7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009c800-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007caa5fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007caa6000-0x000000007caa6fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000007caa7000-0x000000007cad0fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007cad1000-0x000000007cb22fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007cb23000-0x000000007d323fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007d324000-0x0000000086f56fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000086f57000-0x00000000872bcfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000872bd000-0x0000000087309fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000008730a000-0x0000000087abefff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000087abf000-0x0000000087ffefff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000087fff000-0x0000000087ffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000871ffffff] usable
[    0.000000] printk: debug: ignoring loglevel setting.
[    0.000000] printk: bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
[    0.000000] tsc: Detected 3200.000 MHz processor
[    0.000000] tsc: Detected 3199.980 MHz TSC
[    0.000624] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.011117] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.016616] last_pfn =3D 0x872000 max_arch_pfn =3D 0x400000000
[    0.022022] MTRR default type: write-back
[    0.025970] MTRR fixed ranges enabled:
[    0.029660]   00000-9FFFF write-back
[    0.033182]   A0000-BFFFF uncachable
[    0.036700]   C0000-FFFFF write-protect
[    0.040479] MTRR variable ranges enabled:
[    0.044427]   0 base 00C0000000 mask 7FC0000000 uncachable
[    0.049836]   1 base 00A0000000 mask 7FE0000000 uncachable
[    0.055245]   2 base 0090000000 mask 7FF0000000 uncachable
[    0.060653]   3 base 008C000000 mask 7FFC000000 uncachable
[    0.066062]   4 base 008A000000 mask 7FFE000000 uncachable
[    0.071470]   5 base 0089800000 mask 7FFF800000 uncachable
[    0.076878]   6 disabled
[    0.079366]   7 disabled
[    0.081858]   8 disabled
[    0.084347]   9 disabled
[    0.087123] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.094209] last_pfn =3D 0x88000 max_arch_pfn =3D 0x400000000
[    0.099411] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.104574] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.109724] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.120345] found SMP MP-table at [mem 0x000fcde0-0x000fcdef]
[    0.125856]   mpc: fcbb0-fcd5c
[    0.128871] Using GB pages for direct mapping
[    0.133596] RAMDISK: [mem 0x83bb72000-0x86ebfffff]
[    0.138166] ACPI: Early table checksum verification disabled
[    0.143742] ACPI: RSDP 0x00000000000F05B0 000024 (v02 DELL  )
[    0.149407] ACPI: XSDT 0x00000000872DD0A0 0000C4 (v01 DELL   CBX3     01=
072009 AMI  00010013)
[    0.157819] ACPI: FACP 0x00000000872FE7C0 00010C (v05 DELL   CBX3     01=
072009 AMI  00010013)
[    0.166241] ACPI: DSDT 0x00000000872DD1F8 0215C8 (v02 DELL   CBX3     01=
072009 INTL 20120913)
[    0.174667] ACPI: FACS 0x0000000087ABEF80 000040
[    0.179223] ACPI: APIC 0x00000000872FE8D0 000084 (v03 DELL   CBX3     01=
072009 AMI  00010013)
[    0.187652] ACPI: FPDT 0x00000000872FE958 000044 (v01 DELL   CBX3     01=
072009 AMI  00010013)
[    0.196067] ACPI: FIDT 0x00000000872FE9A0 00009C (v01 DELL   CBX3     01=
072009 AMI  00010013)
[    0.204480] ACPI: MCFG 0x00000000872FEA40 00003C (v01 DELL   CBX3     01=
072009 MSFT 00000097)
[    0.212893] ACPI: HPET 0x00000000872FEA80 000038 (v01 DELL   CBX3     01=
072009 AMI. 0005000B)
[    0.221308] ACPI: SSDT 0x00000000872FEAB8 00036D (v01 SataRe SataTabl 00=
001000 INTL 20120913)
[    0.229722] ACPI: SSDT 0x00000000872FEE28 0053B2 (v02 SaSsdt SaSsdt   00=
003000 INTL 20120913)
[    0.238135] ACPI: UEFI 0x00000000873041E0 000042 (v01                 00=
000000      00000000)
[    0.246551] ACPI: LPIT 0x0000000087304228 000094 (v01 INTEL  SKL      00=
000000 MSFT 0000005F)
[    0.254962] ACPI: SSDT 0x00000000873042C0 000248 (v02 INTEL  sensrhub 00=
000000 INTL 20120913)
[    0.263376] ACPI: SSDT 0x0000000087304508 002BAE (v02 INTEL  PtidDevc 00=
001000 INTL 20120913)
[    0.271790] ACPI: SSDT 0x00000000873070B8 000C45 (v02 INTEL  Ther_Rvp 00=
001000 INTL 20120913)
[    0.280203] ACPI: DBGP 0x0000000087307D00 000034 (v01 INTEL           00=
000000 MSFT 0000005F)
[    0.288616] ACPI: DBG2 0x0000000087307D38 000054 (v00 INTEL           00=
000000 MSFT 0000005F)
[    0.297030] ACPI: SSDT 0x0000000087307D90 000613 (v02 INTEL  DELL__MT 00=
000000 INTL 20120913)
[    0.305442] ACPI: SSDT 0x00000000873083A8 000E58 (v02 CpuRef CpuSsdt  00=
003000 INTL 20120913)
[    0.313855] ACPI: SLIC 0x0000000087309200 000176 (v03 DELL   CBX3     01=
072009 MSFT 00010013)
[    0.322268] ACPI: DMAR 0x0000000087309378 0000A8 (v01 INTEL  SKL      00=
000001 INTL 00000001)
[    0.330680] ACPI: ASF! 0x0000000087309420 0000A5 (v32 INTEL   HCG     00=
000001 TFSM 000F4240)
[    0.339098] ACPI: Local APIC address 0xfee00000
[    0.343561] mapped APIC to ffffffffff5fc000 (        fee00000)
[    0.349448] No NUMA configuration found
[    0.353087] Faking a node at [mem 0x0000000000000000-0x0000000871ffffff]
[    0.359703] NODE_DATA(0) allocated [mem 0x871fd5000-0x871ffffff]
[    0.365823] cma: Reserved 200 MiB at 0x000000082f000000
[    0.370848] Zone ranges:
[    0.373309]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.379406]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.385502]   Normal   [mem 0x0000000100000000-0x0000000871ffffff]
[    0.391598]   Device   empty
[    0.394431] Movable zone start for each node
[    0.398642] Early memory node ranges
[    0.402167]   node   0: [mem 0x0000000000001000-0x000000000009bfff]
[    0.408358]   node   0: [mem 0x0000000000100000-0x000000007caa5fff]
[    0.414549]   node   0: [mem 0x000000007cad1000-0x000000007cb22fff]
[    0.420740]   node   0: [mem 0x000000007d324000-0x0000000086f56fff]
[    0.426931]   node   0: [mem 0x0000000087fff000-0x0000000087ffffff]
[    0.433113]   node   0: [mem 0x0000000100000000-0x0000000871ffffff]
[    0.439535] Zeroed struct page in unavailable ranges: 31033 pages
[    0.439536] Initmem setup node 0 [mem 0x0000000000001000-0x0000000871fff=
fff]
[    0.452347] On node 0 totalpages: 8357575
[    0.456294]   DMA zone: 64 pages used for memmap
[    0.460845]   DMA zone: 21 pages reserved
[    0.464795]   DMA zone: 3995 pages, LIFO batch:0
[    0.469371]   DMA32 zone: 8541 pages used for memmap
[    0.474239]   DMA32 zone: 546604 pages, LIFO batch:63
[    0.482815]   Normal zone: 121984 pages used for memmap
[    0.487811]   Normal zone: 7806976 pages, LIFO batch:63
[    0.493193] Reserving Intel graphics memory at [mem 0x8a000000-0x8bfffff=
f]
[    0.500003] ACPI: PM-Timer IO Port: 0x1808
[    0.503883] ACPI: Local APIC address 0xfee00000
[    0.508349] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.514184] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.520023] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.525859] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.531722] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.538565] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.544832] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 2, APIC =
INT 02
[    0.551957] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.558481] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 2, APIC =
INT 09
[    0.565606] ACPI: IRQ0 used by override.
[    0.569471] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 2, APIC =
INT 01
[    0.576596] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 2, APIC =
INT 03
[    0.583719] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 2, APIC =
INT 04
[    0.590847] Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 2, APIC =
INT 05
[    0.597971] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 2, APIC =
INT 06
[    0.605095] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 2, APIC =
INT 07
[    0.612221] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 2, APIC =
INT 08
[    0.619344] ACPI: IRQ9 used by override.
[    0.623208] Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 2, APIC =
INT 0a
[    0.630335] Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 2, APIC =
INT 0b
[    0.637463] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 2, APIC =
INT 0c
[    0.644601] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 2, APIC =
INT 0d
[    0.651740] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 2, APIC =
INT 0e
[    0.658878] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 2, APIC =
INT 0f
[    0.666016] Using ACPI (MADT) for SMP configuration information
[    0.671855] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.676922] TSC deadline timer available
[    0.680786] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.685682] mapped IOAPIC to ffffffffff5fb000 (fec00000)
[    0.690927] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.698389] PM: hibernation: Registered nosave memory: [mem 0x0009c000-0=
x0009cfff]
[    0.705859] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0=
x0009ffff]
[    0.713329] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000dffff]
[    0.720799] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0=
x000fffff]
[    0.728269] PM: hibernation: Registered nosave memory: [mem 0x7caa6000-0=
x7caa6fff]
[    0.735739] PM: hibernation: Registered nosave memory: [mem 0x7caa7000-0=
x7cad0fff]
[    0.743209] PM: hibernation: Registered nosave memory: [mem 0x7cb23000-0=
x7d323fff]
[    0.750677] PM: hibernation: Registered nosave memory: [mem 0x86f57000-0=
x872bcfff]
[    0.758146] PM: hibernation: Registered nosave memory: [mem 0x872bd000-0=
x87309fff]
[    0.765617] PM: hibernation: Registered nosave memory: [mem 0x8730a000-0=
x87abefff]
[    0.773085] PM: hibernation: Registered nosave memory: [mem 0x87abf000-0=
x87ffefff]
[    0.780554] PM: hibernation: Registered nosave memory: [mem 0x88000000-0=
x89ffffff]
[    0.788022] PM: hibernation: Registered nosave memory: [mem 0x8a000000-0=
x8bffffff]
[    0.795492] PM: hibernation: Registered nosave memory: [mem 0x8c000000-0=
xdfffffff]
[    0.802962] PM: hibernation: Registered nosave memory: [mem 0xe0000000-0=
xefffffff]
[    0.810432] PM: hibernation: Registered nosave memory: [mem 0xf0000000-0=
xfdffffff]
[    0.817902] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0=
xfe010fff]
[    0.825374] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0=
xfebfffff]
[    0.832843] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0=
xfec00fff]
[    0.840313] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0=
xfedfffff]
[    0.847783] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0=
xfee00fff]
[    0.855255] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0=
xfeffffff]
[    0.862724] PM: hibernation: Registered nosave memory: [mem 0xff000000-0=
xffffffff]
[    0.870195] [mem 0x8c000000-0xdfffffff] available for PCI devices
[    0.876209] Booting paravirtualized kernel on bare hardware
[    0.881714] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 1910969940391419 ns
[    0.896167] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr=
_node_ids:1
[    0.903683] percpu: Embedded 55 pages/cpu s188416 r8192 d28672 u524288
[    0.910023] pcpu-alloc: s188416 r8192 d28672 u524288 alloc=3D1*2097152
[    0.916288] pcpu-alloc: [0] 0 1 2 3=20
[    0.919825] Built 1 zonelists, mobility grouping on.  Total pages: 82269=
65
[    0.926593] Policy zone: Normal
[    0.929685] Kernel command line: ip=3D::::lkp-skl-d04::dhcp root=3D/dev/=
ram0 user=3Dlkp job=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc=
-ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea5=
9c806787813-20201226-25066-sfkgan-4.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhe=
l-8.3 branch=3Ddrm-intel/drm-intel-gt-next commit=3D8c3b1ba0e7ea9a80b0ee4b4=
445ea59c806787813 BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7e=
a9a80b0ee4b4445ea59c806787813/vmlinuz-5.10.0-rc3-01127-g8c3b1ba0e7ea max_up=
time=3D2100 RESULT_ROOT=3D/result/perf-sanity-tests/gcc-ucode=3D0xe2/lkp-sk=
l-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a8=
0b0ee4b4445ea59c806787813/5 LKP_SERVER=3Dinternal-lkp-server nokaslr selinu=
x=3D0 debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeou=
t=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1=
 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd=
=2Eminor_count=3D8 systemd.log_level=3Derr ignore_loglevel console=3Dtty0 e=
arlyprintk=3Dt
[    0.929897] sysrq: sysrq always enabled.
[    1.020059] ignoring the deprecated load_ramdisk=3D option
[    1.026451] Dentry cache hash table entries: 4194304 (order: 13, 3355443=
2 bytes, linear)
[    1.034851] Inode-cache hash table entries: 2097152 (order: 12, 16777216=
 bytes, linear)
[    1.042627] mem auto-init: stack:off, heap alloc:off, heap free:off
[    1.072392] Memory: 2267592K/33430300K available (14347K kernel code, 61=
42K rwdata, 4812K rodata, 2432K init, 5268K bss, 1517728K reserved, 204800K=
 cma-reserved)
[    1.086516] random: get_random_u64 called from cache_random_seq_create+0=
x80/0x180 with crng_init=3D0
[    1.086564] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    1.101783] Kernel/User page tables isolation: enabled
[    1.106850] ftrace: allocating 45690 entries in 179 pages
[    1.124398] ftrace: allocated 179 pages with 5 groups
[    1.129287] rcu: Hierarchical RCU implementation.
[    1.133876] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D4.
[    1.140584] 	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_ti=
meout).
[    1.147797] 	Trampoline variant of Tasks RCU enabled.
[    1.152778] 	Rude variant of Tasks RCU enabled.
[    1.157243] 	Tracing variant of Tasks RCU enabled.
[    1.161967] rcu: RCU calculated value of scheduler-enlistment delay is 1=
00 jiffies.
[    1.169521] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D4
[    1.178909] NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs: 16
[    1.187148] Console: colour VGA+ 80x25
[    1.218889] printk: console [tty0] enabled
[    1.222902] printk: console [ttyS0] enabled
[    1.222902] printk: console [ttyS0] enabled
[    1.231135] printk: bootconsole [earlyser0] disabled
[    1.231135] printk: bootconsole [earlyser0] disabled
[    1.240941] ACPI: Core revision 20200925
[    1.245163] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 79635855245 ns
[    1.254313] APIC: Switch to symmetric I/O mode setup
[    1.259361] DMAR: Host address width 39
[    1.263293] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    1.268689] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660=
462 ecap 7e3ff0505e
[    1.277114] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    1.282510] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c406604=
62 ecap f050da
[    1.290504] DMAR: RMRR base: 0x0000008715f000 end: 0x0000008717efff
[    1.296843] DMAR: RMRR base: 0x00000089800000 end: 0x0000008bffffff
[    1.303186] DMAR: [Firmware Bug]: No firmware reserved region can cover =
this RMRR [0x0000000089800000-0x000000008bffffff], contact BIOS vendor for =
fixes
[    1.316860] DMAR: [Firmware Bug]: Your BIOS is broken; bad RMRR [0x00000=
00089800000-0x000000008bffffff]
[    1.316860] BIOS vendor: Dell Inc.; Ver: 1.1.1; Product Version:=20
[    1.332361] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    1.338786] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    1.344266] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out=
 bit.
[    1.344266] DMAR-IR: Use 'intremap=3Dno_x2apic_optout' to override the B=
IOS setting.
[    1.359239] DMAR-IR: IRQ remapping was enabled on dmar0 but we are not i=
n kdump mode
[    1.367186] DMAR-IR: IRQ remapping was enabled on dmar1 but we are not i=
n kdump mode
[    1.376246] DMAR-IR: Enabled IRQ remapping in xapic mode
[    1.381617] x2apic: IRQ remapping doesn't support X2APIC mode
[    1.387450] masked ExtINT on CPU#0
[    1.394676] ENABLING IO-APIC IRQs
[    1.398064] init IO_APIC IRQs
[    1.401108]  apic 2 pin 0 not connected
[    1.405015] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.418495] IOAPIC[0]: Set routing entry (2-1 -> 0xef -> IRQ 1 Mode:0 Ac=
tive:0 Dest:1)
[    1.426464] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:30 Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.439947] IOAPIC[0]: Set routing entry (2-2 -> 0x30 -> IRQ 0 Mode:0 Ac=
tive:0 Dest:1)
[    1.447915] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.461398] IOAPIC[0]: Set routing entry (2-3 -> 0xef -> IRQ 3 Mode:0 Ac=
tive:0 Dest:1)
[    1.469368] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.482846] IOAPIC[0]: Set routing entry (2-4 -> 0xef -> IRQ 4 Mode:0 Ac=
tive:0 Dest:1)
[    1.490817] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.505098] IOAPIC[0]: Set routing entry (2-5 -> 0xef -> IRQ 5 Mode:0 Ac=
tive:0 Dest:1)
[    1.513067] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.526546] IOAPIC[0]: Set routing entry (2-6 -> 0xef -> IRQ 6 Mode:0 Ac=
tive:0 Dest:1)
[    1.534514] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.547997] IOAPIC[0]: Set routing entry (2-7 -> 0xef -> IRQ 7 Mode:0 Ac=
tive:0 Dest:1)
[    1.555966] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.569445] IOAPIC[0]: Set routing entry (2-8 -> 0xef -> IRQ 8 Mode:0 Ac=
tive:0 Dest:1)
[    1.577412] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.590897] IOAPIC[0]: Set routing entry (2-9 -> 0xef -> IRQ 9 Mode:1 Ac=
tive:0 Dest:1)
[    1.598880] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.612383] IOAPIC[0]: Set routing entry (2-10 -> 0xef -> IRQ 10 Mode:0 =
Active:0 Dest:1)
[    1.620530] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.634009] IOAPIC[0]: Set routing entry (2-11 -> 0xef -> IRQ 11 Mode:0 =
Active:0 Dest:1)
[    1.642149] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.655633] IOAPIC[0]: Set routing entry (2-12 -> 0xef -> IRQ 12 Mode:0 =
Active:0 Dest:1)
[    1.663775] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.677257] IOAPIC[0]: Set routing entry (2-13 -> 0xef -> IRQ 13 Mode:0 =
Active:0 Dest:1)
[    1.685400] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.698886] IOAPIC[0]: Set routing entry (2-14 -> 0xef -> IRQ 14 Mode:0 =
Active:0 Dest:1)
[    1.707028] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.720511] IOAPIC[0]: Set routing entry (2-15 -> 0xef -> IRQ 15 Mode:0 =
Active:0 Dest:1)
[    1.728653]  apic 2 pin 16 not connected
[    1.732645]  apic 2 pin 17 not connected
[    1.736634]  apic 2 pin 18 not connected
[    1.740625]  apic 2 pin 19 not connected
[    1.744615]  apic 2 pin 20 not connected
[    1.748605]  apic 2 pin 21 not connected
[    1.752595]  apic 2 pin 22 not connected
[    1.756585]  apic 2 pin 23 not connected
[    1.760575]  apic 2 pin 24 not connected
[    1.764564]  apic 2 pin 25 not connected
[    1.768554]  apic 2 pin 26 not connected
[    1.772544]  apic 2 pin 27 not connected
[    1.776535]  apic 2 pin 28 not connected
[    1.780526]  apic 2 pin 29 not connected
[    1.784515]  apic 2 pin 30 not connected
[    1.788506]  apic 2 pin 31 not connected
[    1.792494]  apic 2 pin 32 not connected
[    1.796485]  apic 2 pin 33 not connected
[    1.800475]  apic 2 pin 34 not connected
[    1.804466]  apic 2 pin 35 not connected
[    1.808458]  apic 2 pin 36 not connected
[    1.812450]  apic 2 pin 37 not connected
[    1.816440]  apic 2 pin 38 not connected
[    1.820431]  apic 2 pin 39 not connected
[    1.824422]  apic 2 pin 40 not connected
[    1.828419]  apic 2 pin 41 not connected
[    1.832417]  apic 2 pin 42 not connected
[    1.836411]  apic 2 pin 43 not connected
[    1.840408]  apic 2 pin 44 not connected
[    1.844403]  apic 2 pin 45 not connected
[    1.848401]  apic 2 pin 46 not connected
[    1.852400]  apic 2 pin 47 not connected
[    1.856392]  apic 2 pin 48 not connected
[    1.860383]  apic 2 pin 49 not connected
[    1.864374]  apic 2 pin 50 not connected
[    1.868365]  apic 2 pin 51 not connected
[    1.872354]  apic 2 pin 52 not connected
[    1.876343]  apic 2 pin 53 not connected
[    1.880333]  apic 2 pin 54 not connected
[    1.884324]  apic 2 pin 55 not connected
[    1.888314]  apic 2 pin 56 not connected
[    1.892306]  apic 2 pin 57 not connected
[    1.896297]  apic 2 pin 58 not connected
[    1.900287]  apic 2 pin 59 not connected
[    1.904278]  apic 2 pin 60 not connected
[    1.908268]  apic 2 pin 61 not connected
[    1.912260]  apic 2 pin 62 not connected
[    1.916250]  apic 2 pin 63 not connected
[    1.920239]  apic 2 pin 64 not connected
[    1.924228]  apic 2 pin 65 not connected
[    1.928220]  apic 2 pin 66 not connected
[    1.932209]  apic 2 pin 67 not connected
[    1.936201]  apic 2 pin 68 not connected
[    1.940190]  apic 2 pin 69 not connected
[    1.944179]  apic 2 pin 70 not connected
[    1.948169]  apic 2 pin 71 not connected
[    1.952159]  apic 2 pin 72 not connected
[    1.956150]  apic 2 pin 73 not connected
[    1.960142]  apic 2 pin 74 not connected
[    1.964133]  apic 2 pin 75 not connected
[    1.968123]  apic 2 pin 76 not connected
[    1.972113]  apic 2 pin 77 not connected
[    1.976104]  apic 2 pin 78 not connected
[    1.980095]  apic 2 pin 79 not connected
[    1.984085]  apic 2 pin 80 not connected
[    1.988075]  apic 2 pin 81 not connected
[    1.992064]  apic 2 pin 82 not connected
[    1.996054]  apic 2 pin 83 not connected
[    2.000045]  apic 2 pin 84 not connected
[    2.004035]  apic 2 pin 85 not connected
[    2.008026]  apic 2 pin 86 not connected
[    2.012017]  apic 2 pin 87 not connected
[    2.016008]  apic 2 pin 88 not connected
[    2.019999]  apic 2 pin 89 not connected
[    2.023988]  apic 2 pin 90 not connected
[    2.027978]  apic 2 pin 91 not connected
[    2.031967]  apic 2 pin 92 not connected
[    2.035956]  apic 2 pin 93 not connected
[    2.039947]  apic 2 pin 94 not connected
[    2.043937]  apic 2 pin 95 not connected
[    2.047926]  apic 2 pin 96 not connected
[    2.051916]  apic 2 pin 97 not connected
[    2.055908]  apic 2 pin 98 not connected
[    2.059899]  apic 2 pin 99 not connected
[    2.063893]  apic 2 pin 100 not connected
[    2.067977]  apic 2 pin 101 not connected
[    2.072056]  apic 2 pin 102 not connected
[    2.076141]  apic 2 pin 103 not connected
[    2.080225]  apic 2 pin 104 not connected
[    2.084305]  apic 2 pin 105 not connected
[    2.088390]  apic 2 pin 106 not connected
[    2.092470]  apic 2 pin 107 not connected
[    2.096546]  apic 2 pin 108 not connected
[    2.100622]  apic 2 pin 109 not connected
[    2.104700]  apic 2 pin 110 not connected
[    2.108777]  apic 2 pin 111 not connected
[    2.112853]  apic 2 pin 112 not connected
[    2.116929]  apic 2 pin 113 not connected
[    2.121004]  apic 2 pin 114 not connected
[    2.125082]  apic 2 pin 115 not connected
[    2.129158]  apic 2 pin 116 not connected
[    2.133236]  apic 2 pin 117 not connected
[    2.137311]  apic 2 pin 118 not connected
[    2.141387]  apic 2 pin 119 not connected
[    2.145619] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    2.155996] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x2e2036ff8d5, max_idle_ns: 440795275316 ns
[    2.166546] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 6399.96 BogoMIPS (lpj=3D3199980)
[    2.167545] pid_max: default: 32768 minimum: 301
[    2.168563] LSM: Security Framework initializing
[    2.169551] Yama: becoming mindful.
[    2.170560] AppArmor: AppArmor initialized
[    2.171586] Mount-cache hash table entries: 65536 (order: 7, 524288 byte=
s, linear)
[    2.172583] Mountpoint-cache hash table entries: 65536 (order: 7, 524288=
 bytes, linear)
Poking KASLR using RDRAND RDTSC...
[    2.176877] mce: CPU0: Thermal monitoring enabled (TM1)
[    2.177557] process: using mwait in idle threads
[    2.178546] Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
[    2.180545] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    2.181547] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    2.182547] Spectre V2 : Mitigation: Full generic retpoline
[    2.183545] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    2.184545] Spectre V2 : Enabling Restricted Speculation for firmware ca=
lls
[    2.185547] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    2.186547] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl and seccomp
[    2.187546] TAA: Mitigation: Clear CPU buffers
[    2.188546] SRBDS: Mitigation: Microcode
[    2.189545] MDS: Mitigation: Clear CPU buffers
[    2.191571] Freeing SMP alternatives memory: 40K
[    2.194021] smpboot: CPU0: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (fami=
ly: 0x6, model: 0x5e, stepping: 0x3)
[    2.194604] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR,=
 full-width counters, Broken BIOS detected, complain to your hardware vendo=
r.
[    2.195546] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR=
 189 is 100430000)
[    2.196545] Intel PMU driver.
[    2.196546] ... version:                4
[    2.198545] ... bit width:              48
[    2.199545] ... generic registers:      8
[    2.200545] ... value mask:             0000ffffffffffff
[    2.201545] ... max period:             00007fffffffffff
[    2.202545] ... fixed-purpose events:   3
[    2.203545] ... event mask:             00000007000000ff
[    2.204624] rcu: Hierarchical SRCU implementation.
[    2.205976] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    2.206580] smp: Bringing up secondary CPUs ...
[    2.207597] x86: Booting SMP configuration:
[    2.208547] .... node  #0, CPUs:      #1
[    0.957511] masked ExtINT on CPU#1
[    2.216193]  #2
[    0.957511] masked ExtINT on CPU#2
[    2.221803]  #3
[    0.957511] masked ExtINT on CPU#3
[    2.227295] smp: Brought up 1 node, 4 CPUs
[    2.227546] smpboot: Max logical packages: 1
[    2.228546] smpboot: Total of 4 processors activated (25599.84 BogoMIPS)
[    2.262668] node 0 deferred pages initialised in 33ms
[    2.268941] devtmpfs: initialized
[    2.269575] x86/mm: Memory block size: 128MB
[    2.272046] PM: Registering ACPI NVS region [mem 0x7caa6000-0x7caa6fff] =
(4096 bytes)
[    2.272547] PM: Registering ACPI NVS region [mem 0x8730a000-0x87abefff] =
(8081408 bytes)
[    2.273670] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 1911260446275000 ns
[    2.274548] futex hash table entries: 1024 (order: 4, 65536 bytes, linea=
r)
[    2.276010] pinctrl core: initialized pinctrl subsystem
[    2.276639] NET: Registered protocol family 16
[    2.277713] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic alloca=
tions
[    2.278553] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    2.279551] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    2.280550] audit: initializing netlink subsys (disabled)
[    2.281552] audit: type=3D2000 audit(1608913432.140:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    2.281605] thermal_sys: Registered thermal governor 'fair_share'
[    2.282546] thermal_sys: Registered thermal governor 'bang_bang'
[    2.283545] thermal_sys: Registered thermal governor 'step_wise'
[    2.284545] thermal_sys: Registered thermal governor 'user_space'
[    2.285550] cpuidle: using governor menu
[    2.287651] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    2.288546] ACPI: bus type PCI registered
[    2.289545] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    2.290593] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    2.291547] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    2.292555] PCI: Using configuration type 1 for base access
[    2.294888] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    2.295546] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    2.296561] cryptd: max_cpu_qlen set to 1000
[    2.297582] ACPI: Added _OSI(Module Device)
[    2.298546] ACPI: Added _OSI(Processor Device)
[    2.306547] ACPI: Added _OSI(3.0 _SCP Extensions)
[    2.311545] ACPI: Added _OSI(Processor Aggregator Device)
[    2.316547] ACPI: Added _OSI(Linux-Dell-Video)
[    2.317549] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    2.318546] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    2.346028] ACPI: 8 ACPI AML tables successfully acquired and loaded
[    2.348354] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    2.351306] ACPI: Dynamic OEM Table Load:
[    2.351549] ACPI: SSDT 0xFFFF888100CB2800 0006A2 (v02 PmRef  Cpu0Ist  00=
003000 INTL 20120913)
[    2.353458] ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
[    2.354717] ACPI: Dynamic OEM Table Load:
[    2.355548] ACPI: SSDT 0xFFFF8888714EB800 00037F (v02 PmRef  Cpu0Cst  00=
003001 INTL 20120913)
[    2.357423] ACPI: Dynamic OEM Table Load:
[    2.357547] ACPI: SSDT 0xFFFF888871CFA6C0 00008E (v02 PmRef  Cpu0Hwp  00=
003000 INTL 20120913)
[    2.359339] ACPI: Dynamic OEM Table Load:
[    2.359547] ACPI: SSDT 0xFFFF88887158FC00 000130 (v02 PmRef  HwpLvt   00=
003000 INTL 20120913)
[    2.361727] ACPI: Dynamic OEM Table Load:
[    2.362548] ACPI: SSDT 0xFFFF888100CB3800 0005AA (v02 PmRef  ApIst    00=
003000 INTL 20120913)
[    2.364580] ACPI: Dynamic OEM Table Load:
[    2.365547] ACPI: SSDT 0xFFFF88887158F400 000119 (v02 PmRef  ApHwp    00=
003000 INTL 20120913)
[    2.367406] ACPI: Dynamic OEM Table Load:
[    2.367547] ACPI: SSDT 0xFFFF88887158E800 000119 (v02 PmRef  ApCst    00=
003000 INTL 20120913)
[    2.371494] ACPI: Interpreter enabled
[    2.371576] ACPI: (supports S0 S3 S4 S5)
[    2.372545] ACPI: Using IOAPIC for interrupt routing
[    2.373573] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    2.375210] ACPI: Enabled 7 GPEs in block 00 to 7F
[    2.377310] ACPI: Power Resource [PG00] (on)
[    2.377840] ACPI: Power Resource [PG01] (on)
[    2.378819] ACPI: Power Resource [PG02] (on)
[    2.381374] ACPI: Power Resource [WRST] (off)
[    2.381787] ACPI: Power Resource [WRST] (off)
[    2.382788] ACPI: Power Resource [WRST] (off)
[    2.383785] ACPI: Power Resource [WRST] (off)
[    2.384784] ACPI: Power Resource [WRST] (off)
[    2.385789] ACPI: Power Resource [WRST] (off)
[    2.386784] ACPI: Power Resource [WRST] (off)
[    2.387791] ACPI: Power Resource [WRST] (off)
[    2.388790] ACPI: Power Resource [WRST] (off)
[    2.389784] ACPI: Power Resource [WRST] (off)
[    2.390785] ACPI: Power Resource [WRST] (off)
[    2.391784] ACPI: Power Resource [WRST] (off)
[    2.392785] ACPI: Power Resource [WRST] (off)
[    2.393784] ACPI: Power Resource [WRST] (off)
[    2.394783] ACPI: Power Resource [WRST] (off)
[    2.395783] ACPI: Power Resource [WRST] (off)
[    2.396783] ACPI: Power Resource [WRST] (off)
[    2.397784] ACPI: Power Resource [WRST] (off)
[    2.398790] ACPI: Power Resource [WRST] (off)
[    2.399787] ACPI: Power Resource [WRST] (off)
[    2.410318] ACPI: Power Resource [FN00] (off)
[    2.410592] ACPI: Power Resource [FN01] (off)
[    2.411590] ACPI: Power Resource [FN02] (off)
[    2.412589] ACPI: Power Resource [FN03] (off)
[    2.413590] ACPI: Power Resource [FN04] (off)
[    2.415345] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    2.415550] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    2.417777] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME AER PCIeCapability LTR]
[    2.418546] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    2.420044] PCI host bridge to bus 0000:00
[    2.420549] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    2.421571] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    2.422554] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    2.423546] pci_bus 0000:00: root bus resource [mem 0x8c000000-0xdffffff=
f window]
[    2.424550] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7ffff=
f window]
[    2.425546] pci_bus 0000:00: root bus resource [bus 00-fe]
[    2.426558] pci 0000:00:00.0: [8086:191f] type 00 class 0x060000
[    2.427802] pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
[    2.428581] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    2.429696] pci 0000:00:02.0: [8086:1912] type 00 class 0x030000
[    2.430552] pci 0000:00:02.0: reg 0x10: [mem 0xde000000-0xdeffffff 64bit]
[    2.431549] pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff 64bit=
 pref]
[    2.432548] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    2.433712] pci 0000:00:14.0: [8086:a12f] type 00 class 0x0c0330
[    2.434562] pci 0000:00:14.0: reg 0x10: [mem 0xdf030000-0xdf03ffff 64bit]
[    2.435605] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    2.436661] pci 0000:00:14.2: [8086:a131] type 00 class 0x118000
[    2.437561] pci 0000:00:14.2: reg 0x10: [mem 0xdf04e000-0xdf04efff 64bit]
[    2.438687] pci 0000:00:16.0: [8086:a13a] type 00 class 0x078000
[    2.439559] pci 0000:00:16.0: reg 0x10: [mem 0xdf04d000-0xdf04dfff 64bit]
[    2.440614] pci 0000:00:16.0: PME# supported from D3hot
[    2.441673] pci 0000:00:17.0: [8086:a102] type 00 class 0x010601
[    2.442555] pci 0000:00:17.0: reg 0x10: [mem 0xdf048000-0xdf049fff]
[    2.443550] pci 0000:00:17.0: reg 0x14: [mem 0xdf04c000-0xdf04c0ff]
[    2.444550] pci 0000:00:17.0: reg 0x18: [io  0xf090-0xf097]
[    2.445550] pci 0000:00:17.0: reg 0x1c: [io  0xf080-0xf083]
[    2.446550] pci 0000:00:17.0: reg 0x20: [io  0xf060-0xf07f]
[    2.447550] pci 0000:00:17.0: reg 0x24: [mem 0xdf04b000-0xdf04b7ff]
[    2.448579] pci 0000:00:17.0: PME# supported from D3hot
[    2.449664] pci 0000:00:1c.0: [8086:a110] type 01 class 0x060400
[    2.450605] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    2.451713] pci 0000:00:1f.0: [8086:a146] type 00 class 0x060100
[    2.452742] pci 0000:00:1f.2: [8086:a121] type 00 class 0x058000
[    2.453557] pci 0000:00:1f.2: reg 0x10: [mem 0xdf044000-0xdf047fff]
[    2.454695] pci 0000:00:1f.3: [8086:a170] type 00 class 0x040300
[    2.455565] pci 0000:00:1f.3: reg 0x10: [mem 0xdf040000-0xdf043fff 64bit]
[    2.456573] pci 0000:00:1f.3: reg 0x20: [mem 0xdf020000-0xdf02ffff 64bit]
[    2.457589] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    2.458708] pci 0000:00:1f.4: [8086:a123] type 00 class 0x0c0500
[    2.459600] pci 0000:00:1f.4: reg 0x10: [mem 0xdf04a000-0xdf04a0ff 64bit]
[    2.460613] pci 0000:00:1f.4: reg 0x20: [io  0xf040-0xf05f]
[    2.461730] pci 0000:00:1f.6: [8086:15b7] type 00 class 0x020000
[    2.462563] pci 0000:00:1f.6: reg 0x10: [mem 0xdf000000-0xdf01ffff]
[    2.463647] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    2.464673] pci 0000:00:01.0: PCI bridge to [bus 01]
[    2.465606] pci 0000:02:00.0: [104c:8240] type 01 class 0x060400
[    2.466679] pci 0000:02:00.0: supports D1 D2
[    2.467655] pci 0000:00:1c.0: PCI bridge to [bus 02-03]
[    2.468596] pci_bus 0000:03: extended config space not accessible
[    2.469609] pci 0000:02:00.0: PCI bridge to [bus 03]
[    2.472072] ACPI: PCI Interrupt Link [LNKA] (IRQs *7 12), disabled.
[    2.472581] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *10), disabled.
[    2.473579] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 *5), disabled.
[    2.474579] ACPI: PCI Interrupt Link [LNKD] (IRQs 6 *11), disabled.
[    2.475578] ACPI: PCI Interrupt Link [LNKE] (IRQs *7 11), disabled.
[    2.476578] ACPI: PCI Interrupt Link [LNKF] (IRQs *3 10), disabled.
[    2.477578] ACPI: PCI Interrupt Link [LNKG] (IRQs *4 5), disabled.
[    2.478578] ACPI: PCI Interrupt Link [LNKH] (IRQs 6 12) *11, disabled.
[    2.479931] iommu: Default domain type: Translated=20
[    2.480557] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    2.481544] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[    2.481547] pci 0000:00:02.0: vgaarb: bridge control possible
[    2.482545] vgaarb: loaded
[    2.483600] SCSI subsystem initialized
[    2.484556] ACPI: bus type USB registered
[    2.485554] usbcore: registered new interface driver usbfs
[    2.486549] usbcore: registered new interface driver hub
[    2.487555] usbcore: registered new device driver usb
[    2.488556] pps_core: LinuxPPS API ver. 1 registered
[    2.489545] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    2.490546] PTP clock support registered
[    2.491556] EDAC MC: Ver: 3.0.0
[    2.492641] NetLabel: Initializing
[    2.493546] NetLabel:  domain hash size =3D 128
[    2.494545] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    2.495556] NetLabel:  unlabeled traffic allowed by default
[    2.496545] PCI: Using ACPI for IRQ routing
[    2.525098] PCI: pci_cache_line_size set to 64 bytes
[    2.525585] e820: reserve RAM buffer [mem 0x0009c800-0x0009ffff]
[    2.526546] e820: reserve RAM buffer [mem 0x7caa6000-0x7fffffff]
[    2.527545] e820: reserve RAM buffer [mem 0x7cb23000-0x7fffffff]
[    2.528545] e820: reserve RAM buffer [mem 0x86f57000-0x87ffffff]
[    2.529546] e820: reserve RAM buffer [mem 0x872000000-0x873ffffff]
[    2.530662] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    2.531546] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    2.534554] clocksource: Switched to clocksource tsc-early
[    2.562347] VFS: Disk quotas dquot_6.6.0
[    2.566353] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    2.573341] AppArmor: AppArmor Filesystem Enabled
[    2.578119] pnp: PnP ACPI init
[    2.581432] system 00:00: [io  0x0a00-0x0a3f] has been reserved
[    2.587408] system 00:00: [io  0x0a40-0x0a7f] has been reserved
[    2.593382] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.600687] pnp 00:01: [dma 0 disabled]
[    2.604621] pnp 00:01: Plug and Play ACPI device, IDs PNP0501 (active)
[    2.611325] system 00:02: [io  0x0680-0x069f] has been reserved
[    2.617298] system 00:02: [io  0xffff] has been reserved
[    2.622667] system 00:02: [io  0xffff] has been reserved
[    2.628039] system 00:02: [io  0xffff] has been reserved
[    2.633408] system 00:02: [io  0x1800-0x18fe] has been reserved
[    2.639382] system 00:02: [io  0x164e-0x164f] has been reserved
[    2.645355] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.652252] system 00:03: [io  0x0800-0x087f] has been reserved
[    2.658228] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.665075] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    2.671671] system 00:05: [io  0x1854-0x1857] has been reserved
[    2.677644] system 00:05: Plug and Play ACPI device, IDs INT3f0d PNP0c02=
 (active)
[    2.685343] system 00:06: [mem 0xfed10000-0xfed17fff] has been reserved
[    2.692017] system 00:06: [mem 0xfed18000-0xfed18fff] has been reserved
[    2.698688] system 00:06: [mem 0xfed19000-0xfed19fff] has been reserved
[    2.705360] system 00:06: [mem 0xe0000000-0xefffffff] has been reserved
[    2.712034] system 00:06: [mem 0xfed20000-0xfed3ffff] has been reserved
[    2.718697] system 00:06: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    2.725702] system 00:06: [mem 0xfed45000-0xfed8ffff] has been reserved
[    2.732363] system 00:06: [mem 0xff000000-0xffffffff] has been reserved
[    2.739025] system 00:06: [mem 0xfee00000-0xfeefffff] could not be reser=
ved
[    2.746030] system 00:06: [mem 0xdffe0000-0xdfffffff] has been reserved
[    2.752691] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.759551] system 00:07: [mem 0xfd000000-0xfdabffff] has been reserved
[    2.766213] system 00:07: [mem 0xfdad0000-0xfdadffff] has been reserved
[    2.772873] system 00:07: [mem 0xfdb00000-0xfdffffff] has been reserved
[    2.779534] system 00:07: [mem 0xfe000000-0xfe01ffff] could not be reser=
ved
[    2.786537] system 00:07: [mem 0xfe036000-0xfe03bfff] has been reserved
[    2.793196] system 00:07: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    2.799857] system 00:07: [mem 0xfe410000-0xfe7fffff] has been reserved
[    2.806517] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.813571] system 00:08: [io  0xff00-0xfffe] has been reserved
[    2.819544] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.827189] system 00:09: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    2.833849] system 00:09: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    2.840509] system 00:09: [mem 0xfdac0000-0xfdacffff] has been reserved
[    2.847171] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.854635] pnp: PnP ACPI: found 10 devices
[    2.864140] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    2.873093] NET: Registered protocol family 2
[    2.877611] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6=
, 262144 bytes, linear)
[    2.886380] TCP established hash table entries: 262144 (order: 9, 209715=
2 bytes, linear)
[    2.894696] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes,=
 linear)
[    2.902230] TCP: Hash tables configured (established 262144 bind 65536)
[    2.908906] UDP hash table entries: 16384 (order: 7, 524288 bytes, linea=
r)
[    2.915868] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, =
linear)
[    2.923303] NET: Registered protocol family 1
[    2.927802] RPC: Registered named UNIX socket transport module.
[    2.933783] RPC: Registered udp transport module.
[    2.938558] RPC: Registered tcp transport module.
[    2.943330] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.949830] NET: Registered protocol family 44
[    2.954345] pci 0000:00:01.0: PCI bridge to [bus 01]
[    2.959378] pci 0000:02:00.0: PCI bridge to [bus 03]
[    2.964418] pci 0000:00:1c.0: PCI bridge to [bus 02-03]
[    2.969707] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    2.975939] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    2.982172] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    2.989090] pci_bus 0000:00: resource 7 [mem 0x8c000000-0xdfffffff windo=
w]
[    2.996009] pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff windo=
w]
[    3.003016] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    3.011498] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    3.024980] IOAPIC[0]: Set routing entry (2-18 -> 0xef -> IRQ 18 Mode:1 =
Active:1 Dest:1)
[    3.033208] pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x620 took 212=
74 usecs
[    3.040687] PCI: CLS 0 bytes, default 64
[    3.044701] Trying to unpack rootfs image as initramfs...
[   10.755007] Freeing initrd memory: 836152K
[   10.759205] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[   10.765692] software IO TLB: mapped [mem 0x0000000082f57000-0x0000000086=
f57000] (64MB)
[   10.774350] Initialise system trusted keyrings
[   10.778870] Key type blacklist registered
[   10.782975] workingset: timestamp_bits=3D36 max_order=3D23 bucket_order=
=3D0
[   10.790328] zbud: loaded
[   10.800104] NET: Registered protocol family 38
[   10.804615] Key type asymmetric registered
[   10.808780] Asymmetric key parser 'x509' registered
[   10.813723] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 247)
[   10.821196] io scheduler mq-deadline registered
[   10.825791] io scheduler kyber registered
[   10.829885] io scheduler bfq registered
[   10.833815] atomic64_test: passed for x86-64 platform with CX8 and with =
SSE
[   10.840952] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[   10.854433] IOAPIC[0]: Set routing entry (2-16 -> 0xef -> IRQ 16 Mode:1 =
Active:1 Dest:1)
[   10.862610] pcieport 0000:00:01.0: PME: Signaling with IRQ 122
[   10.868638] pcieport 0000:00:1c.0: PME: Signaling with IRQ 123
[   10.874561] pcieport 0000:00:1c.0: AER: enabled with IRQ 123
[   10.880350] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   10.887116] intel_idle: MWAIT substates: 0x142120
[   10.891885] intel_idle: v0.5.1 model 0x5E
[   10.896224] intel_idle: Local APIC timer is reliable in all C-states
[   10.902795] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input0
[   10.911224] ACPI: Sleep Button [SLPB]
[   10.914991] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input1
[   10.923402] ACPI: Power Button [PWRB]
[   10.927184] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input2
[   10.934668] ACPI: Power Button [PWRF]
[   10.939393] thermal LNXTHERM:00: registered as thermal_zone0
[   10.945110] ACPI: Thermal Zone [TZ00] (28 C)
[   10.949527] thermal LNXTHERM:01: registered as thermal_zone1
[   10.955241] ACPI: Thermal Zone [TZ01] (30 C)
[   10.959636] ERST DBG: ERST support is disabled.
[   10.964365] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   10.970755] 00:01: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[   10.978998] Non-volatile memory driver v1.3
[   10.983664] rdac: device handler registered
[   10.988046] hp_sw: device handler registered
[   10.992382] emc: device handler registered
[   10.996608] alua: device handler registered
[   11.000931] e1000: Intel(R) PRO/1000 Network Driver
[   11.005867] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   11.011681] e1000e: Intel(R) PRO/1000 Network Driver
[   11.016712] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   11.022795] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[   11.038757] IOAPIC[0]: Set routing entry (2-19 -> 0xef -> IRQ 19 Mode:1 =
Active:1 Dest:1)
[   11.046967] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) se=
t to dynamic conservative mode
[   11.286393] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered=
 PHC clock
[   11.359761] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 64:=
00:6a:30:92:35
[   11.367739] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connecti=
on
[   11.374763] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0=
FF
[   11.381695] igb: Intel(R) Gigabit Ethernet Network Driver
[   11.387151] igb: Copyright (c) 2007-2014 Intel Corporation.
[   11.392787] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
[   11.398930] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[   11.404956] i40e: Intel(R) Ethernet Connection XL710 Network Driver
[   11.411275] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
[   11.417249] usbcore: registered new interface driver r8152
[   11.422809] usbcore: registered new interface driver asix
[   11.428266] usbcore: registered new interface driver ax88179_178a
[   11.434552] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   11.441148] ehci-pci: EHCI PCI platform driver
[   11.445666] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   11.451911] ohci-pci: OHCI PCI platform driver
[   11.456424] uhci_hcd: USB Universal Host Controller Interface driver
[   11.462973] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[   11.476453] IOAPIC[0]: Set routing entry (2-18 -> 0xef -> IRQ 18 Mode:1 =
Active:1 Dest:1)
[   11.484636] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   11.490086] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[   11.498640] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
00 quirks 0x0000000001109810
[   11.507896] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[   11.514886] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.10
[   11.523201] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   11.530480] usb usb1: Product: xHCI Host Controller
[   11.535420] usb usb1: Manufacturer: Linux 5.10.0-rc3-01127-g8c3b1ba0e7ea=
 xhci-hcd
[   11.542958] usb usb1: SerialNumber: 0000:00:14.0
[   11.547851] hub 1-0:1.0: USB hub found
[   11.551729] hub 1-0:1.0: 16 ports detected
[   11.556711] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   11.562144] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[   11.569600] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[   11.575954] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.10
[   11.584280] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   11.591558] usb usb2: Product: xHCI Host Controller
[   11.596496] usb usb2: Manufacturer: Linux 5.10.0-rc3-01127-g8c3b1ba0e7ea=
 xhci-hcd
[   11.604033] usb usb2: SerialNumber: 0000:00:14.0
[   11.608927] hub 2-0:1.0: USB hub found
[   11.612778] hub 2-0:1.0: 10 ports detected
[   11.617313] usb: port power management may be unreliable
[   11.622891] i8042: PNP: No PS/2 controller found.
[   11.627739] mousedev: PS/2 mouse device common for all mice
[   11.633511] rtc_cmos 00:04: RTC can wake from S4
[   11.638839] rtc_cmos 00:04: registered as rtc0
[   11.643509] rtc_cmos 00:04: setting system clock to 2020-12-25T16:24:04 =
UTC (1608913444)
[   11.651660] rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram=
, hpet irqs
[   11.659516] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[   11.665458] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[   11.675002] i2c i2c-0: 4/4 memory slots populated (from DMI)
[   11.681232] i2c i2c-0: Successfully instantiated SPD at 0x50
[   11.687468] i2c i2c-0: Successfully instantiated SPD at 0x51
[   11.693715] i2c i2c-0: Successfully instantiated SPD at 0x52
[   11.699950] i2c i2c-0: Successfully instantiated SPD at 0x53
[   11.705717] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   11.711427] iTCO_wdt: Found a Intel PCH TCO device (Version=3D4, TCOBASE=
=3D0x0400)
[   11.719034] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[   11.725126] iTCO_vendor_support: vendor-support=3D0
[   11.729916] intel_pstate: Intel P-state driver initializing
[   11.736271] intel_pstate: HWP enabled
[   11.740240] hid: raw HID events driver (C) Jiri Kosina
[   11.745481] usbcore: registered new interface driver usbhid
[   11.751113] usbhid: USB HID core driver
[   11.755047] drop_monitor: Initializing network drop monitor service
[   11.761406] Initializing XFRM netlink socket
[   11.765807] NET: Registered protocol family 10
[   11.770514] Segment Routing with IPv6
[   11.774260] NET: Registered protocol family 17
[   11.778962] 9pnet: Installing 9P2000 support
[   11.783314] mpls_gso: MPLS GSO support
[   11.787762] microcode: sig=3D0x506e3, pf=3D0x2, revision=3D0xe2
[   11.793429] microcode: Microcode Update Driver: v2.2.
[   11.793446] IPI shorthand broadcast: enabled
[   11.803013] ... APIC ID:      00000000 (0)
[   11.804011] ... APIC VERSION: 01060015
[   11.804011] 000000000000000000000000000000000000000000000000000000000000=
0000
[   11.804011] 000000000000000000000000000000000000000000000000000000000000=
0000
[   11.804011] 000000000000000000000000000000000000000000000000000000000800=
1000
[   11.804011]=20
[   11.832284] number of MP IRQ sources: 15.
[   11.837596] tsc: Refined TSC clocksource calibration: 3192.000 MHz
[   11.837939] number of IO-APIC #2 registers: 120.
[   11.844174] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2e0=
2c4a121d, max_idle_ns: 440795236083 ns
[   11.848852] testing the IO APIC.......................
[   11.864099] IO APIC #2......
[   11.867057] .... register #00: 02000000
[   11.870964] .......    : physical APIC id: 02
[   11.875387] .......    : Delivery Type: 0
[   11.879467] .......    : LTS          : 0
[   11.883543] .... register #01: 00770020
[   11.887449] .......     : max redirection entries: 77
[   11.892561] .......     : PRQ implemented: 0
[   11.896895] .......     : IO APIC version: 20
[   11.901318] .... register #02: 00000000
[   11.905223] .......     : arbitration: 00
[   11.909302] .... IRQ redirection table:
[   11.913208] IOAPIC 0:
[   11.915574]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.923465]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.931357]  pin02, enabled , edge , high, V(02), IRR(0), S(0), remapped=
, I(0001),  Z(0)
[   11.939508]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.947400]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.955293]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.963197]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.971102]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.979008]  pin08, enabled , edge , high, V(08), IRR(0), S(0), remapped=
, I(0007),  Z(0)
[   11.987171]  pin09, enabled , level, high, V(09), IRR(0), S(0), remapped=
, I(0008),  Z(0)
[   11.995322]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.003217]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.011110]  pin0c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.019004]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.026897]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.034789]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.042683]  pin10, enabled , level, low , V(10), IRR(0), S(0), remapped=
, I(000F),  Z(0)
[   12.050833]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.058725]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.066618]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.074510]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.082403]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.090296]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.098187]  pin17, disabled, edge , high, V(00), IRR(0), S(0), remapped=
, I(0000),  Z(2)
[   12.106337]  pin18, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.114230]  pin19, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.122123]  pin1a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.130015]  pin1b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.137906]  pin1c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.145798]  pin1d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.153688]  pin1e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.164077]  pin1f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.171970]  pin20, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.179862]  pin21, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.187754]  pin22, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.195648]  pin23, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.203556]  pin24, disabled, edge , high, V(21), IRR(0), S(0), physical=
, D(00), M(2)
[   12.211463]  pin25, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.219367]  pin26, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.227267]  pin27, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(01), M(2)
[   12.235161]  pin28, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.243053]  pin29, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.250947]  pin2a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.258839]  pin2b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.266733]  pin2c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.274627]  pin2d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.282521]  pin2e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.290413]  pin2f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.298306]  pin30, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.306199]  pin31, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.314092]  pin32, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.321983]  pin33, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.329876]  pin34, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.337768]  pin35, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.345660]  pin36, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.353552]  pin37, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.361444]  pin38, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.369335]  pin39, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.377226]  pin3a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.385119]  pin3b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.393009]  pin3c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.400899]  pin3d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.408789]  pin3e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.416680]  pin3f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.424573]  pin40, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.432464]  pin41, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.440372]  pin42, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.448278]  pin43, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.456182]  pin44, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.464084]  pin45, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.471974]  pin46, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.479866]  pin47, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.487758]  pin48, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.495651]  pin49, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.503542]  pin4a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(08), M(2)
[   12.511432]  pin4b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.519323]  pin4c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.527215]  pin4d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.535107]  pin4e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.542999]  pin4f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.550888]  pin50, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.558780]  pin51, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.566672]  pin52, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(80), M(2)
[   12.574565]  pin53, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.582457]  pin54, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.590348]  pin55, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.598240]  pin56, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.606132]  pin57, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.614024]  pin58, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.621918]  pin59, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.629810]  pin5a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.637702]  pin5b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.645597]  pin5c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.653489]  pin5d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.661380]  pin5e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.669271]  pin5f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.677177]  pin60, disabled, edge , high, V(20), IRR(0), S(0), physical=
, D(08), M(2)
[   12.685081]  pin61, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.692986]  pin62, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.700891]  pin63, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.708784]  pin64, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.716679]  pin65, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.724574]  pin66, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.732466]  pin67, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.740358]  pin68, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.748252]  pin69, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.756145]  pin6a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.764038]  pin6b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.771930]  pin6c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.779822]  pin6d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.787712]  pin6e, disabled, edge , high, V(00), IRR(0), S(0), logical =
, D(00), M(2)
[   12.795603]  pin6f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.803494]  pin70, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.811386]  pin71, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.819279]  pin72, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.827169]  pin73, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.835060]  pin74, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.842953]  pin75, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.850847]  pin76, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.858738]  pin77, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.866625] IRQ to pin mappings:
[   12.872424] IRQ0 -> 0:2
[   12.874954] IRQ1 -> 0:1
[   12.877483] IRQ3 -> 0:3
[   12.880013] IRQ4 -> 0:4
[   12.882542] IRQ5 -> 0:5
[   12.885071] IRQ6 -> 0:6
[   12.887599] IRQ7 -> 0:7
[   12.890129] IRQ8 -> 0:8
[   12.892658] IRQ9 -> 0:9
[   12.895187] IRQ10 -> 0:10
[   12.897889] IRQ11 -> 0:11
[   12.900590] IRQ12 -> 0:12
[   12.903290] IRQ13 -> 0:13
[   12.905990] IRQ14 -> 0:14
[   12.908693] IRQ15 -> 0:15
[   12.911399] IRQ16 -> 0:16
[   12.914107] IRQ18 -> 0:18
[   12.916812] IRQ19 -> 0:19
[   12.919517] .................................... done.
[   12.924730] clocksource: Switched to clocksource tsc
[   12.924735] AVX2 version of gcm_enc/dec engaged.
[   12.934478] AES CTR mode by8 optimization enabled
[   12.941097] sched_clock: Marking stable (11984581635, 956511572)->(13986=
499829, -1045406622)
[   12.949934] registered taskstats version 1
[   12.954115] Loading compiled-in X.509 certificates
[   12.959849] Loaded X.509 cert 'Build time autogenerated kernel key: bf0a=
41d88f630fbef6db60a8bcbfaf331b5b9e32'
[   12.969832] zswap: loaded using pool lzo/zbud
[   12.974530] Key type ._fscrypt registered
[   12.978665] Key type .fscrypt registered
[   12.982710] Key type fscrypt-provisioning registered
[   12.990520] Key type encrypted registered
[   12.994654] AppArmor: AppArmor sha1 policy hashing enabled
[   13.000213] ima: No TPM chip found, activating TPM-bypass!
[   13.005772] ima: Allocated hash algorithm: sha1
[   13.010381] ima: No architecture policies found
[   13.014990] evm: Initialising EVM extended attributes:
[   13.020198] evm: security.selinux
[   13.023638] evm: security.apparmor
[   13.027122] evm: security.ima
[   13.030176] evm: security.capability
[   13.033831] evm: HMAC attrs: 0x1
[   17.943423] e1000e 0000:00:1f.6 eth0: NIC Link is Up 1000 Mbps Full Dupl=
ex, Flow Control: Rx/Tx
[   17.953843] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   17.965774] Sending DHCP requests ., OK
[   17.973550] IP-Config: Got DHCP answer from 192.168.3.2, my address is 1=
92.168.3.95
[   17.981292] IP-Config: Complete:
[   17.984629]      device=3Deth0, hwaddr=3D64:00:6a:30:92:35, ipaddr=3D192=
=2E168.3.95, mask=3D255.255.255.0, gw=3D192.168.3.200
[   17.994944]      host=3Dlkp-skl-d04, domain=3Dlkp.intel.com, nis-domain=
=3D(none)
[   18.001876]      bootserver=3D192.168.3.200, rootserver=3D192.168.3.200,=
 rootpath=3D
[   18.001877]      nameserver0=3D192.168.3.200
[   18.013346]=20
[   18.013377] TAP version 14
[   18.017755] 1..1
[   18.019685]     # Subtest: property-entry
[   18.019686]     1..7
[   18.024050]     ok 1 - pe_test_uints
[   18.026490]     ok 2 - pe_test_uint_arrays
[   18.030419]     ok 3 - pe_test_strings
[   18.034911]     ok 4 - pe_test_bool
[   18.038857]     ok 5 - pe_test_move_inline_u8
[   18.042568]     ok 6 - pe_test_move_inline_str
[   18.047278]     ok 7 - pe_test_reference
[   18.051813] ok 1 - property-entry
[   18.060245] Freeing unused decrypted memory: 2036K
[   18.065468] Freeing unused kernel image (initmem) memory: 2432K
[   18.076689] Write protecting the kernel read-only data: 22528k
[   18.083184] Freeing unused kernel image (text/rodata gap) memory: 2036K
[   18.090211] Freeing unused kernel image (rodata/data gap) memory: 1332K
[   18.102667] Run /init as init process
[   18.106412]   with arguments:
[   18.109465]     /init
[   18.111826]     nokaslr
[   18.114360]   with environment:
[   18.117611]     HOME=3D/
[   18.120059]     TERM=3Dlinux
[   18.122854]     user=3Dlkp
[   18.125474]     job=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-=
gcc-ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445=
ea59c806787813-20201226-25066-sfkgan-4.yaml
[   18.142107]     ARCH=3Dx86_64
[   18.144986]     kconfig=3Dx86_64-rhel-8.3
[   18.148901]     branch=3Ddrm-intel/drm-intel-gt-next
[   18.153767]     commit=3D8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813
[   18.159761]     BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/vmlinuz-5.10.0-rc3-01127-g8c3b1ba0e7ea
[   18.172337]     max_uptime=3D2100
[   18.175573]     RESULT_ROOT=3D/result/perf-sanity-tests/gcc-ucode=3D0xe2=
/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0=
e7ea9a80b0ee4b4445ea59c806787813/5
[   18.191439]     LKP_SERVER=3Dinternal-lkp-server
[   18.195960]     softlockup_panic=3D1
[   18.199444]     prompt_ramdisk=3D0
[   18.202756]     vga=3Dnormal
[   18.209377] systemd[1]: RTC configured in localtime, applying delta of 0=
 minutes to system time.


         Mou
[   18.378974] wmi_bus wmi_bus-PNP0C14:00: WQBC data block query control me=
thod not found
ssage Queue File
[   18.427963] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   18.435013] RAPL PMU: hw unit of domain package 2^-14 Joules
         Startin
[   18.442050] RAPL PMU: hw unit of domain dram 2^-14 Joules
nt Root and Kern
[   18.456254] ahci 0000:00:17.0: version 3.0
39mRPC Pipe File
[   18.478997] IOAPIC[0]: Set routing entry (2-17 -> 0xef -> IRQ 17 Mode:1 =
Active:1 Dest:1)
ess NFS configur
[   18.666287] scsi host1: ahci
 =20
[   18.670430] scsi host2: ahci
       Starting=20
[   18.674508] scsi host3: ahci
rnel Device Mana
[   18.687548] ata2: SATA max UDMA/133 abar m2048@0xdf04b000 port 0xdf04b18=
0 irq 127
[   18.755674] i915 0000:00:02.0: vgaarb: deactivate vga console
[   18.763457] Console: switching to colour dummy device 80x25
r to synchronize
[   18.781328] i915 0000:00:02.0: Direct firmware load for i915/skl_dmc_ver=
1_27.bin failed with error -2
 boot up for ifu
[   18.791792] i915 0000:00:02.0: [drm] Failed to load DMC firmware i915/sk=
l_dmc_ver1_27.bin. Disabling runtime power management.
[   18.804413] i915 0000:00:02.0: [drm] DMC firmware homepage: https://git.=
kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
[   18.818133] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on mi=
nor 0
 Journal to Pers
[   18.836178] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/LNXVIDEO:00/input/input4
[   18.850210] random: fast init done
         Startin
[   18.871517] intel_rapl_common: Found RAPL domain package
[   18.884593] intel_rapl_common: Found RAPL domain uncore
[   18.889782] intel_rapl_common: Found RAPL domain dram
[   19.019708] ata4: SATA link down (SStatus 4 SControl 300)
[   19.025078] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   19.031218] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   19.031260] ata3: SATA link down (SStatus 4 SControl 300)
[   19.050686] ata2.00: 2344225968 sectors, multi 1: LBA48 NCQ (depth 32)
m.
[   18.250605] rc.local[290]: PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sb=
in:/usr/bin:/sbin:/bin:/lkp/lkp/src/bin
LKP: HOSTNAME lkp-skl-d04, MAC 64:00:6a:30:92:35, kernel 5.10.0-rc3-01127-g=
8c3b1ba0e7ea 1, serial console /dev/ttyS0
         Startin
[   19.250920] ata1.00: ATA-9: ST1000DM003-1ER162, CC45, max UDMA/133

[   19.271750] scsi 0:0:0:0: Direct-Access     ATA      ST1000DM003-1ER1 CC=
45 PQ: 0 ANSI: 5
[   19.280244] scsi 1:0:0:0: Direct-Access     ATA      INTEL SSDSC2BB01 00=
23 PQ: 0 ANSI: 5
1;39mSystem Logg
[   19.302976] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[   19.306697] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 =
TB/932 GiB)

[   19.321745] sd 0:0:0:0: [sda] 4096-byte physical blocks
[   19.321899] sd 1:0:0:0: [sdb] 2344225968 512-byte logical blocks: (1.20 =
TB/1.09 TiB)
[   19.333464] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[   19.333750] sd 1:0:0:0: [sdb] 4096-byte physical blocks
[   19.335589] sd 0:0:0:0: [sda] Write Protect is off
[   19.335590] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   19.335598] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   19.335694] sd 1:0:0:0: Attached scsi generic sg1 type 0
[   19.376861] sd 1:0:0:0: [sdb] Write Protect is off
0m
[   19.388029] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   19.403025] ata2.00: Enabling discard_zeroes_data
[   19.408785] sd 1:0:0:0: [sdb] Attached SCSI disk
al Compatibility
[   19.421854] sd 0:0:0:0: [sda] Attached SCSI disk
[   19.448136] ipmi device interface
[   19.461579] ipmi_si: IPMI System Interface driver
[   19.466972] ipmi_si: Unable to find any System Interface(s)
See 'systemctl status openipmi.service' for details.
[   20.404571] random: crng init done
[   20.407949] random: 2 urandom warning(s) missed due to ratelimiting
[   24.066557] Kernel tests: Boot OK!
[   24.066560]=20
[   28.234253] install debs round one: dpkg -i --force-confdef --force-depe=
nds /opt/deb/ntpdate_1%3a4.2.8p12+dfsg-4_amd64.deb
[   28.234256]=20
[   28.247737] /opt/deb/libperl5.28_5.28.1-6+deb10u1_amd64.deb
[   28.247739]=20
[   28.255613] /opt/deb/perl_5.28.1-6+deb10u1_amd64.deb
[   28.255615]=20
[   28.262930] /opt/deb/perl-base_5.28.1-6+deb10u1_amd64.deb
[   28.262931]=20
[   28.270833] /opt/deb/perl-modules-5.28_5.28.1-6+deb10u1_all.deb
[   28.270834]=20
[   28.279463] /opt/deb/libpython3.7-minimal_3.7.3-2+deb10u2_amd64.deb
[   28.279465]=20
[   28.288319] /opt/deb/python3.7-minimal_3.7.3-2+deb10u2_amd64.deb
[   28.288320]=20
[   28.296617] /opt/deb/python3-minimal_3.7.3-1_amd64.deb
[   28.296618]=20
[   28.304505] /opt/deb/libpython3.7-stdlib_3.7.3-2+deb10u2_amd64.deb
[   28.304506]=20
[   28.313029] /opt/deb/python3.7_3.7.3-2+deb10u2_amd64.deb
[   28.313030]=20
[   28.320693] /opt/deb/libpython3-stdlib_3.7.3-1_amd64.deb
[   28.320694]=20
[   28.328190] /opt/deb/python3_3.7.3-1_amd64.deb
[   28.328191]=20
[   28.335088] /opt/deb/gtk-update-icon-cache_3.24.5-1_amd64.deb
[   28.335089]=20
[   28.343097] /opt/deb/libthai-data_0.1.28-2_all.deb
[   28.343099]=20
[   28.350146] /opt/deb/libdatrie1_0.2.12-2_amd64.deb
[   28.350147]=20
[   28.357376] /opt/deb/libavahi-common-data_0.7-4+b1_amd64.deb
[   28.357378]=20
[   28.365341] /opt/deb/libasound2-data_1.1.8-1_all.deb
[   28.365342]=20
[   28.372919] /opt/deb/ca-certificates-java_20190405_all.deb
[   28.372921]=20
[   28.380651] /opt/deb/libatomic1_8.3.0-6_amd64.deb
[   28.380652]=20
[   28.387559] /opt/deb/libquadmath0_8.3.0-6_amd64.deb
[   28.387560]=20
[   28.394693] /opt/deb/libgcc-8-dev_8.3.0-6_amd64.deb
[   28.394694]=20
[   28.401822] /opt/deb/lib32gcc1_1%3a8.3.0-6_amd64.deb
[   28.401823]=20
[   28.408922] /opt/deb/gcc-8_8.3.0-6_amd64.deb
[   28.408923]=20
[   28.415416] /opt/deb/gcc_4%3a8.3.0-1_amd64.deb
[   28.415417]=20
[   28.421986] /opt/deb/g++-8_8.3.0-6_amd64.deb
[   28.421987]=20
[   28.428558] /opt/deb/g++_4%3a8.3.0-1_amd64.deb
[   28.428560]=20
[   28.435459] /opt/deb/libatk1.0-data_2.30.0-2_all.deb
[   28.435461]=20
[   28.442747] /opt/deb/libatk1.0-0_2.30.0-2_amd64.deb
[   28.442748]=20
[   28.449970] /opt/deb/gir1.2-atk-1.0_2.30.0-2_amd64.deb
[   28.449971]=20
[   28.457316] /opt/deb/libdpkg-perl_1.19.7_all.deb
[   28.457317]=20
[   28.464354] /opt/deb/libglib2.0-data_2.58.3-2+deb10u2_all.deb
[   28.464355]=20
[   28.472379] /opt/deb/python3-lib2to3_3.7.3-1_all.deb
[   28.472380]=20
[   28.479631] /opt/deb/python3-distutils_3.7.3-1_all.deb
[   28.479632]=20
[   28.487076] /opt/deb/libatk1.0-dev_2.30.0-2_amd64.deb
[   28.487077]=20
[   28.494622] /opt/deb/libexpat1-dev_2.2.6-2+deb10u1_amd64.deb
[   28.494623]=20
[   28.502675] /opt/deb/libperl-dev_5.28.1-6+deb10u1_amd64.deb
[   28.502677]=20
[   28.510770] /opt/deb/libpython2.7_2.7.16-2+deb10u1_amd64.deb
[   28.510771]=20
[   28.519038] /opt/deb/libpython2.7-dev_2.7.16-2+deb10u1_amd64.deb
[   28.519039]=20
[   28.527366] /opt/deb/libpython2-dev_2.7.16-1_amd64.deb
[   28.527367]=20
[   28.534858] /opt/deb/libpython-dev_2.7.16-1_amd64.deb
[   28.534872]=20
[   28.542194] /opt/deb/patch_2.7.6-3+deb10u1_amd64.deb
[   28.542195]=20
[   28.549594] /opt/deb/python2.7-dev_2.7.16-2+deb10u1_amd64.deb
[   28.549595]=20
[   28.557658] /opt/deb/python2-dev_2.7.16-1_amd64.deb
[   28.557659]=20
[   28.564746] /opt/deb/python-dev_2.7.16-1_amd64.deb
[   28.564747]=20
[   28.571786] /opt/deb/gawk_1%3a4.2.1+dfsg-1_amd64.deb
[   28.571787]=20
[   28.579237] Selecting previously unselected package ntpdate.
[   28.579239]=20
[   28.587874] (Reading database ... 16553 files and directories currently =
installed.)
[   28.587876]=20
[   28.598601] Preparing to unpack .../ntpdate_1%3a4.2.8p12+dfsg-4_amd64.de=
b ...
[   28.598603]=20
[   28.608134] Unpacking ntpdate (1:4.2.8p12+dfsg-4) ...
[   28.608135]=20
[   28.616076] Preparing to unpack .../libperl5.28_5.28.1-6+deb10u1_amd64.d=
eb ...
[   28.616077]=20
[   28.626252] Unpacking libperl5.28:amd64 (5.28.1-6+deb10u1) over (5.28.1-=
6) ...
[   28.626254]=20
[   28.636207] Preparing to unpack .../perl_5.28.1-6+deb10u1_amd64.deb ...
[   28.636208]=20
[   28.645398] Unpacking perl (5.28.1-6+deb10u1) over (5.28.1-6) ...
[   28.645399]=20
[   28.654355] Preparing to unpack .../perl-base_5.28.1-6+deb10u1_amd64.deb=
 ...
[   28.654356]=20
[   28.664068] Unpacking perl-base (5.28.1-6+deb10u1) over (5.28.1-6) ...
[   28.664070]=20
[   28.673584] Preparing to unpack .../perl-modules-5.28_5.28.1-6+deb10u1_a=
ll.deb ...
[   28.673586]=20
[   28.684020] Unpacking perl-modules-5.28 (5.28.1-6+deb10u1) over (5.28.1-=
6) ...
[   28.684021]=20
[   28.694120] Selecting previously unselected package libpython3.7-minimal=
:amd64.
[   28.694121]=20
[   28.704460] Preparing to unpack .../libpython3.7-minimal_3.7.3-2+deb10u2=
_amd64.deb ...
[   28.704461]=20
[   28.715078] Unpacking libpython3.7-minimal:amd64 (3.7.3-2+deb10u2) ...
[   28.715079]=20
[   28.724291] Selecting previously unselected package python3.7-minimal.
[   28.724292]=20
[   28.733865] Preparing to unpack .../python3.7-minimal_3.7.3-2+deb10u2_am=
d64.deb ...
[   28.733866]=20
[   28.743973] Unpacking python3.7-minimal (3.7.3-2+deb10u2) ...
[   28.743974]=20
[   28.752384] Selecting previously unselected package python3-minimal.
[   28.752385]=20
[   28.761467] Preparing to unpack .../python3-minimal_3.7.3-1_amd64.deb ...
[   28.761468]=20
[   28.770458] Unpacking python3-minimal (3.7.3-1) ...
[   28.770459]=20
[   28.778198] Selecting previously unselected package libpython3.7-stdlib:=
amd64.
[   28.778200]=20
[   28.788441] Preparing to unpack .../libpython3.7-stdlib_3.7.3-2+deb10u2_=
amd64.deb ...
[   28.788443]=20
[   28.798917] Unpacking libpython3.7-stdlib:amd64 (3.7.3-2+deb10u2) ...
[   28.798918]=20
[   28.807853] Selecting previously unselected package python3.7.
[   28.807854]=20
[   28.816466] Preparing to unpack .../python3.7_3.7.3-2+deb10u2_amd64.deb =
=2E..
[   28.816467]=20
[   28.825681] Unpacking python3.7 (3.7.3-2+deb10u2) ...
[   28.825682]=20
[   28.833495] Selecting previously unselected package libpython3-stdlib:am=
d64.
[   28.833496]=20
[   28.843217] Preparing to unpack .../libpython3-stdlib_3.7.3-1_amd64.deb =
=2E..
[   28.843219]=20
[   28.852578] Unpacking libpython3-stdlib:amd64 (3.7.3-1) ...
[   28.852580]=20
[   28.860633] Selecting previously unselected package python3.
[   28.860635]=20
[   28.869034] Preparing to unpack .../deb/python3_3.7.3-1_amd64.deb ...
[   28.869035]=20
[   28.877555] Unpacking python3 (3.7.3-1) ...
[   28.877557]=20
[   28.884450] Selecting previously unselected package gtk-update-icon-cach=
e.
[   28.884451]=20
[   28.894143] Preparing to unpack .../gtk-update-icon-cache_3.24.5-1_amd64=
=2Edeb ...
[   28.894144]=20
[   29.464714] No diversion 'diversion of /usr/sbin/update-icon-caches to /=
usr/sbin/update-icon-caches.gtk2 by libgtk-3-bin', none removed.
[   29.464716]=20
[   30.594291] No diversion 'diversion of /usr/share/man/man8/update-icon-c=
aches.8.gz to /usr/share/man/man8/update-icon-caches.gtk2.8.gz by libgtk-3-=
bin', none removed.
[   30.594294]=20
[   30.611523] Unpacking gtk-update-icon-cache (3.24.5-1) ...
[   30.611525]=20
[   30.619892] Selecting previously unselected package libthai-data.
[   30.619907]=20
[   30.630338] Preparing to unpack .../libthai-data_0.1.28-2_all.deb ...
[   30.630339]=20
[   30.637576] SGI XFS with ACLs, security attributes, realtime, scrub, rep=
air, quota, fatal assert, debug enabled
[   30.638981] Unpacking libthai-data (0.1.28-2) ...
[   30.648203]=20
[   30.655115] XFS (sdb1): Deprecated V4 format (crc=3D0) will not be suppo=
rted after September 2030.
[   30.655724] Selecting previously unselected package libdatrie1:amd64.
[   30.663826]=20
[   30.671774] XFS (sdb1): Mounting V4 Filesystem
[   30.672927] Preparing to unpack .../libdatrie1_0.2.12-2_amd64.deb ...
[   30.676179]=20
[   30.685001] Unpacking libdatrie1:amd64 (0.2.12-2) ...
[   30.685002]=20
[   30.692952] Selecting previously unselected package libavahi-common-data=
:amd64.
[   30.692953]=20
[   30.703055] Preparing to unpack .../libavahi-common-data_0.7-4+b1_amd64.=
deb ...
[   30.703056]=20
[   30.712874] Unpacking libavahi-common-data:amd64 (0.7-4+b1) ...
[   30.712875]=20
[   30.721404] Selecting previously unselected package libasound2-data.
[   30.721405]=20
[   30.730534] Preparing to unpack .../libasound2-data_1.1.8-1_all.deb ...
[   30.730536]=20
[   30.739400] Unpacking libasound2-data (1.1.8-1) ...
[   30.739401]=20
[   30.747033] Selecting previously unselected package ca-certificates-java.
[   30.747034]=20
[   30.756715] Preparing to unpack .../ca-certificates-java_20190405_all.de=
b ...
[   30.756716]=20
[   30.763913] XFS (sdb1): Starting recovery (logdev: internal)
[   30.766237] Unpacking ca-certificates-java (20190405) ...
[   30.770892]=20
[   30.779105] Selecting previously unselected package libatomic1:amd64.
[   30.779107]=20
[   30.788257] Preparing to unpack .../libatomic1_8.3.0-6_amd64.deb ...
[   30.788258]=20
[   30.797134] Unpacking libatomic1:amd64 (8.3.0-6) ...
[   30.797135]=20
[   30.805046] Selecting previously unselected package libquadmath0:amd64.
[   30.805047]=20
[   30.814399] XFS (sdb1): Ending recovery (logdev: internal)
[   30.814630] Preparing to unpack .../libquadmath0_8.3.0-6_amd64.deb ...
[   30.819837]=20
[   30.828862] Unpacking libquadmath0:amd64 (8.3.0-6) ...
[   30.828863]=20
[   30.836267] xfs filesystem being mounted at /opt/rootfs supports timesta=
mps until 2038 (0x7fffffff)
[   30.836846] Selecting previously unselected package libgcc-8-dev:amd64.
[   30.845235]=20
[   30.854664] Preparing to unpack .../libgcc-8-dev_8.3.0-6_amd64.deb ...
[   30.854665]=20
[   30.863521] Unpacking libgcc-8-dev:amd64 (8.3.0-6) ...
[   30.863522]=20
[   30.871169] Selecting previously unselected package lib32gcc1.
[   30.871170]=20
[   30.879642] Preparing to unpack .../lib32gcc1_1%3a8.3.0-6_amd64.deb ...
[   30.879644]=20
[   30.888394] Unpacking lib32gcc1 (1:8.3.0-6) ...
[   30.888396]=20
[   30.895466] Selecting previously unselected package gcc-8.
[   30.895467]=20
[   30.903469] Preparing to unpack .../deb/gcc-8_8.3.0-6_amd64.deb ...
[   30.903470]=20
[   30.911801] Unpacking gcc-8 (8.3.0-6) ...
[   30.911802]=20
[   30.918129] Selecting previously unselected package gcc.
[   30.918130]=20
[   30.926019] Preparing to unpack .../deb/gcc_4%3a8.3.0-1_amd64.deb ...
[   30.926020]=20
[   30.934450] Unpacking gcc (4:8.3.0-1) ...
[   30.934451]=20
[   30.940835] Selecting previously unselected package g++-8.
[   30.940836]=20
[   30.948856] Preparing to unpack .../deb/g++-8_8.3.0-6_amd64.deb ...
[   30.948857]=20
[   30.957156] Unpacking g++-8 (8.3.0-6) ...
[   30.957157]=20
[   30.963469] Selecting previously unselected package g++.
[   30.963470]=20
[   30.971361] Preparing to unpack .../deb/g++_4%3a8.3.0-1_amd64.deb ...
[   30.971362]=20
[   30.979840] Unpacking g++ (4:8.3.0-1) ...
[   30.979841]=20
[   30.986392] Selecting previously unselected package libatk1.0-data.
[   30.986393]=20
[   30.995289] Preparing to unpack .../libatk1.0-data_2.30.0-2_all.deb ...
[   30.995290]=20
[   31.004131] Unpacking libatk1.0-data (2.30.0-2) ...
[   31.004132]=20
[   31.011710] Selecting previously unselected package libatk1.0-0:amd64.
[   31.011711]=20
[   31.020820] Preparing to unpack .../libatk1.0-0_2.30.0-2_amd64.deb ...
[   31.020821]=20
[   31.029639] Unpacking libatk1.0-0:amd64 (2.30.0-2) ...
[   31.029640]=20
[   31.037443] Selecting previously unselected package gir1.2-atk-1.0:amd64.
[   31.037444]=20
[   31.046876] Preparing to unpack .../gir1.2-atk-1.0_2.30.0-2_amd64.deb ...
[   31.046877]=20
[   31.056027] Unpacking gir1.2-atk-1.0:amd64 (2.30.0-2) ...
[   31.056028]=20
[   31.063953] Selecting previously unselected package libdpkg-perl.
[   31.063954]=20
[   31.072669] Preparing to unpack .../libdpkg-perl_1.19.7_all.deb ...
[   31.072670]=20
[   31.081105] Unpacking libdpkg-perl (1.19.7) ...
[   31.081106]=20
[   31.088217] Selecting previously unselected package libglib2.0-data.
[   31.088218]=20
[   31.097348] Preparing to unpack .../libglib2.0-data_2.58.3-2+deb10u2_all=
=2Edeb ...
[   31.097349]=20
[   31.107128] Unpacking libglib2.0-data (2.58.3-2+deb10u2) ...
[   31.107129]=20
[   31.115334] Selecting previously unselected package python3-lib2to3.
[   31.115335]=20
[   31.124292] Preparing to unpack .../python3-lib2to3_3.7.3-1_all.deb ...
[   31.124293]=20
[   31.133130] Unpacking python3-lib2to3 (3.7.3-1) ...
[   31.133131]=20
[   31.140701] Selecting previously unselected package python3-distutils.
[   31.140702]=20
[   31.149863] Preparing to unpack .../python3-distutils_3.7.3-1_all.deb ...
[   31.149864]=20
[   31.158942] Unpacking python3-distutils (3.7.3-1) ...
[   31.158944]=20
[   31.166693] Selecting previously unselected package libatk1.0-dev:amd64.
[   31.166694]=20
[   31.176014] Preparing to unpack .../libatk1.0-dev_2.30.0-2_amd64.deb ...
[   31.176015]=20
[   31.185031] Unpacking libatk1.0-dev:amd64 (2.30.0-2) ...
[   31.185032]=20
[   31.192967] Selecting previously unselected package libexpat1-dev:amd64.
[   31.192968]=20
[   31.202426] Preparing to unpack .../libexpat1-dev_2.2.6-2+deb10u1_amd64.=
deb ...
[   31.202427]=20
[   31.212174] Unpacking libexpat1-dev:amd64 (2.2.6-2+deb10u1) ...
[   31.212175]=20
[   31.220597] Selecting previously unselected package libperl-dev.
[   31.220598]=20
[   31.229341] Preparing to unpack .../libperl-dev_5.28.1-6+deb10u1_amd64.d=
eb ...
[   31.229342]=20
[   31.238887] Unpacking libperl-dev (5.28.1-6+deb10u1) ...
[   31.238888]=20
[   31.246819] Selecting previously unselected package libpython2.7:amd64.
[   31.246820]=20
[   31.256182] Preparing to unpack .../libpython2.7_2.7.16-2+deb10u1_amd64.=
deb ...
[   31.256183]=20
[   31.265940] Unpacking libpython2.7:amd64 (2.7.16-2+deb10u1) ...
[   31.265941]=20
[   31.274576] Selecting previously unselected package libpython2.7-dev:amd=
64.
[   31.274577]=20
[   31.284420] Preparing to unpack .../libpython2.7-dev_2.7.16-2+deb10u1_am=
d64.deb ...
[   31.284421]=20
[   31.294675] Unpacking libpython2.7-dev:amd64 (2.7.16-2+deb10u1) ...
[   31.294676]=20
[   31.303667] Selecting previously unselected package libpython2-dev:amd64.
[   31.303668]=20
[   31.313087] Preparing to unpack .../libpython2-dev_2.7.16-1_amd64.deb ...
[   31.313088]=20
[   31.322209] Unpacking libpython2-dev:amd64 (2.7.16-1) ...
[   31.322210]=20
[   31.330254] Selecting previously unselected package libpython-dev:amd64.
[   31.330255]=20
[   31.339667] Preparing to unpack .../libpython-dev_2.7.16-1_amd64.deb ...
[   31.339668]=20
[   31.348684] Unpacking libpython-dev:amd64 (2.7.16-1) ...
[   31.348685]=20
[   31.356372] Selecting previously unselected package patch.
[   31.356373]=20
[   31.364470] Preparing to unpack .../patch_2.7.6-3+deb10u1_amd64.deb ...
[   31.364471]=20
[   31.373298] Unpacking patch (2.7.6-3+deb10u1) ...
[   31.373299]=20
[   31.380562] Selecting previously unselected package python2.7-dev.
[   31.380563]=20
[   31.389532] Preparing to unpack .../python2.7-dev_2.7.16-2+deb10u1_amd64=
=2Edeb ...
[   31.389533]=20
[   31.399303] Unpacking python2.7-dev (2.7.16-2+deb10u1) ...
[   31.399304]=20
[   31.407265] Selecting previously unselected package python2-dev.
[   31.407266]=20
[   31.415854] Preparing to unpack .../python2-dev_2.7.16-1_amd64.deb ...
[   31.415855]=20
[   31.424510] Unpacking python2-dev (2.7.16-1) ...
[   31.424511]=20
[   31.431620] Selecting previously unselected package python-dev.
[   31.431621]=20
[   31.440106] Preparing to unpack .../python-dev_2.7.16-1_amd64.deb ...
[   31.440107]=20
[   31.448701] Unpacking python-dev (2.7.16-1) ...
[   31.448702]=20
[   31.455542] Selecting previously unselected package gawk.
[   31.455543]=20
[   31.463535] Preparing to unpack .../gawk_1%3a4.2.1+dfsg-1_amd64.deb ...
[   31.463536]=20
[   31.472260] Unpacking gawk (1:4.2.1+dfsg-1) ...
[   31.472261]=20
[   31.479084] Setting up ntpdate (1:4.2.8p12+dfsg-4) ...
[   31.479085]=20
[   31.486492] Setting up perl-base (5.28.1-6+deb10u1) ...
[   31.486493]=20
[   31.494206] Setting up perl-modules-5.28 (5.28.1-6+deb10u1) ...
[   31.494207]=20
[   31.502776] Setting up libpython3.7-minimal:amd64 (3.7.3-2+deb10u2) ...
[   31.502777]=20
[   31.511836] Setting up python3.7-minimal (3.7.3-2+deb10u2) ...
[   31.511837]=20
[   31.519946] Setting up python3-minimal (3.7.3-1) ...
[   31.519947]=20
[   31.527126] Setting up libthai-data (0.1.28-2) ...
[   31.527127]=20
[   31.534221] Setting up libdatrie1:amd64 (0.2.12-2) ...
[   31.534222]=20
[   31.541840] Setting up libavahi-common-data:amd64 (0.7-4+b1) ...
[   31.541841]=20
[   31.550092] Setting up libasound2-data (1.1.8-1) ...
[   31.550093]=20
[   31.557325] Setting up libatomic1:amd64 (8.3.0-6) ...
[   31.557326]=20
[   31.564706] Setting up libquadmath0:amd64 (8.3.0-6) ...
[   31.564707]=20
[   31.572185] Setting up libatk1.0-data (2.30.0-2) ...
[   31.572186]=20
[   31.579553] Setting up libglib2.0-data (2.58.3-2+deb10u2) ...
[   31.579554]=20
[   31.587780] Setting up libpython2.7:amd64 (2.7.16-2+deb10u1) ...
[   31.587781]=20
[   31.596000] Setting up patch (2.7.6-3+deb10u1) ...
[   31.596001]=20
[   31.603255] Setting up libperl5.28:amd64 (5.28.1-6+deb10u1) ...
[   31.603256]=20
[   31.611355] Setting up perl (5.28.1-6+deb10u1) ...
[   31.611356]=20
[   31.618300] Setting up libdpkg-perl (1.19.7) ...
[   31.618301]=20
[   31.625297] Setting up libperl-dev (5.28.1-6+deb10u1) ...
[   31.625298]=20
[   31.633260] Setting up libpython2.7-dev:amd64 (2.7.16-2+deb10u1) ...
[   31.633261]=20
[   31.641982] Setting up libpython2-dev:amd64 (2.7.16-1) ...
[   31.641983]=20
[   31.649821] Setting up libpython-dev:amd64 (2.7.16-1) ...
[   31.649822]=20
[   31.657589] Setting up python2.7-dev (2.7.16-2+deb10u1) ...
[   31.657590]=20
[   31.665344] Setting up python2-dev (2.7.16-1) ...
[   31.665345]=20
[   31.672280] Setting up python-dev (2.7.16-1) ...
[   31.672281]=20
[   31.679076] Setting up gawk (1:4.2.1+dfsg-1) ...
[   31.679077]=20
[   31.686305] Setting up libpython3.7-stdlib:amd64 (3.7.3-2+deb10u2) ...
[   31.686306]=20
[   31.695114] Setting up python3.7 (3.7.3-2+deb10u2) ...
[   31.695115]=20
[   31.702668] Setting up libpython3-stdlib:amd64 (3.7.3-1) ...
[   31.702669]=20
[   31.710378] Setting up python3 (3.7.3-1) ...
[   31.710379]=20
[   31.717058] running python rtupdate hooks for python3.7...
[   31.717060]=20
[   31.724926] Setting up gtk-update-icon-cache (3.24.5-1) ...
[   31.724927]=20
[   31.732858] Setting up ca-certificates-java (20190405) ...
[   31.732859]=20
[   31.740533] Adding debian:GeoTrust_Universal_CA.pem
[   31.740534]=20
[   31.747883] Adding debian:Staat_der_Nederlanden_EV_Root_CA.pem
[   31.747884]=20
[   31.755981] Adding debian:thawte_Primary_Root_CA.pem
[   31.755982]=20
[   31.763112] Adding debian:Amazon_Root_CA_2.pem
[   31.763113]=20
[   31.769996] Adding debian:OISTE_WISeKey_Global_Root_GC_CA.pem
[   31.769997]=20
[   31.778201] Adding debian:TWCA_Root_Certification_Authority.pem
[   31.778202]=20
[   31.786595] Adding debian:COMODO_RSA_Certification_Authority.pem
[   31.786596]=20
[   31.794848] Adding debian:SwissSign_Gold_CA_-_G2.pem
[   31.794849]=20
[   31.802441] Adding debian:Entrust.net_Premium_2048_Secure_Server_CA.pem
[   31.802442]=20
[   31.811415] Adding debian:DigiCert_Assured_ID_Root_G3.pem
[   31.811416]=20
[   31.819402] Adding debian:DigiCert_High_Assurance_EV_Root_CA.pem
[   31.819404]=20
[   31.827826] Adding debian:COMODO_Certification_Authority.pem
[   31.827827]=20
[   31.835660] Adding debian:SecureSign_RootCA11.pem
[   31.835661]=20
[   31.843724] Adding debian:VeriSign_Class_3_Public_Primary_Certification_=
Authority_-_G4.pem
[   31.843726]=20
[   31.854598] Adding debian:Security_Communication_RootCA2.pem
[   31.854599]=20
[   31.862565] Adding debian:QuoVadis_Root_CA_3_G3.pem
[   31.862567]=20
[   31.870826] Adding debian:Deutsche_Telekom_Root_CA_2.pem
[   31.870828]=20
[   31.874021] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   31.876932] Adding debian:SecureTrust_CA.pem
[   31.877812] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.889451]=20
[   31.893607] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.906163] Adding debian:AffirmTrust_Commercial.pem
[   31.906787] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   31.918495]=20
[   31.919111] Adding debian:Izenpe.com.pem
[   31.923782] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.935142]=20
[   31.936185] Adding debian:T-TeleSec_GlobalRoot_Class_2.pem
[   31.936632] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.940515]=20
[   31.942227] Adding debian:Verisign_Class_3_Public_Primary_Certification_=
Authority_-_G3.pem
[   31.952251] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   31.953715]=20
[   31.954589] Adding debian:Trustis_FPS_Root_CA.pem
[   31.959292] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.970874]=20
[   31.972471] Adding debian:Hellenic_Academic_and_Research_Institutions_Ro=
otCA_2011.pem
[   31.980556] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.992292]=20
[   31.993265] Adding debian:SwissSign_Silver_CA_-_G2.pem
[   31.993787] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   31.998446]=20
[   31.999240] Adding debian:QuoVadis_Root_CA.pem
[   32.010318] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.011658]=20
[   32.013052] Adding debian:TUBITAK_Kamu_SM_SSL_Kok_Sertifikasi_-_Surum_1.=
pem
[   32.019425] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.031142]=20
[   32.032187] Adding debian:thawte_Primary_Root_CA_-_G3.pem
[   32.032630] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.037715]=20
[   32.038497] Adding debian:AC_RAIZ_FNMT-RCM.pem
[   32.049619] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.050928]=20
[   32.055334] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.067978] Adding debian:thawte_Primary_Root_CA_-_G2.pem
[   32.068605] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.075423]=20
[   32.087312] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.089530] Adding debian:Comodo_AAA_Services_root.pem
[   32.094012] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.105727]=20
[   32.107232] Adding debian:Hellenic_Academic_and_Research_Institutions_Ro=
otCA_2015.pem
[   32.111623] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.123334]=20
[   32.124456] Adding debian:Entrust_Root_Certification_Authority.pem
[   32.124953] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.136538]=20
[   32.137356] Adding debian:Cybertrust_Global_Root.pem
[   32.141896] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.153626]=20
[   32.155111] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.167834] Adding debian:Security_Communication_Root_CA.pem
[   32.172053] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.183636]=20
[   32.184381] Adding debian:GlobalSign_Root_CA.pem
[   32.185119] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.192875]=20
[   32.194297] Adding debian:Starfield_Services_Root_Certificate_Authority_=
-_G2.pem
[   32.204624] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.206090]=20
[   32.207110] Adding debian:IdenTrust_Commercial_Root_CA_1.pem
[   32.212355] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.223955]=20
[   32.225250] Adding debian:GeoTrust_Primary_Certification_Authority_-_G3.=
pem
[   32.225439] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.230365]=20
[   32.231200] Adding debian:AffirmTrust_Networking.pem
[   32.242116] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.243588]=20
[   32.244532] Adding debian:T-TeleSec_GlobalRoot_Class_3.pem
[   32.255493] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.260936]=20
[   32.261688] Adding debian:Amazon_Root_CA_4.pem
[   32.272665] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.274139]=20
[   32.274788] Adding debian:Taiwan_GRCA.pem
[   32.278779] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.290439]=20
[   32.291139] Adding debian:Amazon_Root_CA_1.pem
[   32.292053] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.299248]=20
[   32.300475] Adding debian:Entrust_Root_Certification_Authority_-_G2.pem
[   32.310976] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.312447]=20
[   32.313335] Adding debian:Baltimore_CyberTrust_Root.pem
[   32.318075] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.329778]=20
[   32.330518] Adding debian:QuoVadis_Root_CA_2.pem
[   32.331425] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.338158]=20
[   32.339415] Adding debian:Entrust_Root_Certification_Authority_-_EC1.pem
[   32.349890] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.351358]=20
[   32.352630] Adding debian:SSL.com_EV_Root_Certification_Authority_ECC.pem
[   32.356293] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.368003]=20
[   32.368926] Adding debian:Certum_Trusted_Network_CA.pem
[   32.369654] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.374919]=20
[   32.386646] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.388847] Adding debian:SZAFIR_ROOT_CA2.pem
[   32.392535] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.404247]=20
[   32.405120] Adding debian:GlobalSign_Root_CA_-_R6.pem
[   32.405863] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.409700]=20
[   32.410902] Adding debian:SSL.com_Root_Certification_Authority_ECC.pem
[   32.421427] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.422901]=20
[   32.423935] Adding debian:EE_Certification_Centre_Root_CA.pem
[   32.427315] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.439027]=20
[   32.439856] Adding debian:AffirmTrust_Premium.pem
[   32.440677] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.447061]=20
[   32.458795] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.460944] Adding debian:DST_Root_CA_X3.pem
[   32.670198]=20
[   32.676857] Adding debian:GlobalSign_Root_CA_-_R2.pem
[   32.676858]=20
[   32.684265] Adding debian:Certum_Trusted_Network_CA_2.pem
[   32.684266]=20
[   32.692013] Adding debian:Atos_TrustedRoot_2011.pem
[   32.692014]=20
[   32.699579] Adding debian:Starfield_Root_Certificate_Authority_-_G2.pem
[   32.699580]=20
[   32.708824] Adding debian:Go_Daddy_Root_Certificate_Authority_-_G2.pem
[   32.708826]=20
[   32.717615] Adding debian:TrustCor_RootCert_CA-1.pem
[   32.717617]=20
[   32.725124] Adding debian:OISTE_WISeKey_Global_Root_GB_CA.pem
[   32.725125]=20
[   32.733345] Adding debian:OISTE_WISeKey_Global_Root_GA_CA.pem
[   32.733346]=20
[   32.741329] Adding debian:TrustCor_RootCert_CA-2.pem
[   32.741330]=20
[   32.748231] Adding debian:Certigna.pem
[   32.748232]=20
[   32.754220] Adding debian:TWCA_Global_Root_CA.pem
[   32.754221]=20
[   32.761149] Adding debian:Certinomis_-_Root_CA.pem
[   32.761150]=20
[   32.768118] Adding debian:TrustCor_ECA-1.pem
[   32.768119]=20
[   32.774851] Adding debian:D-TRUST_Root_Class_3_CA_2_2009.pem
[   32.774853]=20
[   32.782955] Adding debian:IdenTrust_Public_Sector_Root_CA_1.pem
[   32.782956]=20
[   32.791292] Adding debian:Chambers_of_Commerce_Root_-_2008.pem
[   32.791294]=20
[   32.799492] Adding debian:AffirmTrust_Premium_ECC.pem
[   32.799493]=20
[   32.806764] Adding debian:QuoVadis_Root_CA_2_G3.pem
[   32.806765]=20
[   32.813973] Adding debian:DigiCert_Global_Root_CA.pem
[   32.813974]=20
[   32.821222] Adding debian:QuoVadis_Root_CA_3.pem
[   32.821223]=20
[   32.828277] Adding debian:Global_Chambersign_Root_-_2008.pem
[   32.828278]=20
[   32.836277] Adding debian:Sonera_Class_2_Root_CA.pem
[   32.836278]=20
[   32.843582] Adding debian:Buypass_Class_2_Root_CA.pem
[   32.843583]=20
[   32.851160] Adding debian:ePKI_Root_Certification_Authority.pem
[   32.851161]=20
[   32.859254] Adding debian:GeoTrust_Global_CA.pem
[   32.859255]=20
[   32.866244] Adding debian:Buypass_Class_3_Root_CA.pem
[   32.866245]=20
[   32.873789] Adding debian:GlobalSign_ECC_Root_CA_-_R4.pem
[   32.873791]=20
[   32.881435] Adding debian:CA_Disig_Root_R2.pem
[   32.881437]=20
[   32.888238] Adding debian:Starfield_Class_2_CA.pem
[   32.888240]=20
[   32.895425] Adding debian:XRamp_Global_CA_Root.pem
[   32.895427]=20
[   32.902414] Adding debian:certSIGN_ROOT_CA.pem
[   32.902416]=20
[   32.909701] Adding debian:VeriSign_Universal_Root_Certification_Authorit=
y.pem
[   32.909703]=20
[   32.919220] Adding debian:GlobalSign_ECC_Root_CA_-_R5.pem
[   32.919222]=20
[   32.926818] Adding debian:Secure_Global_CA.pem
[   32.926820]=20
[   32.933483] Adding debian:Go_Daddy_Class_2_CA.pem
[   32.933485]=20
[   32.941047] Adding debian:D-TRUST_Root_Class_3_CA_2_EV_2009.pem
[   32.941049]=20
[   32.949478] Adding debian:GDCA_TrustAUTH_R5_ROOT.pem
[   32.949480]=20
[   32.957199] Adding debian:Network_Solutions_Certificate_Authority.pem
[   32.957201]=20
[   32.965945] Adding debian:DigiCert_Global_Root_G3.pem
[   32.965947]=20
[   32.973621] Adding debian:USERTrust_ECC_Certification_Authority.pem
[   32.973623]=20
[   32.982073] Adding debian:Amazon_Root_CA_3.pem
[   32.982074]=20
[   32.988980] Adding debian:DigiCert_Trusted_Root_G4.pem
[   32.988981]=20
[   32.996683] Adding debian:COMODO_ECC_Certification_Authority.pem
[   32.996684]=20
[   33.005142] Adding debian:AddTrust_External_Root.pem
[   33.005144]=20
[   33.012613] Adding debian:DigiCert_Global_Root_G2.pem
[   33.012615]=20
[   33.019833] Adding debian:ISRG_Root_X1.pem
[   33.019834]=20
[   33.026960] Adding debian:GeoTrust_Primary_Certification_Authority_-_G2.=
pem
[   33.026962]=20
[   33.036062] Adding debian:ACCVRAIZ1.pem
[   33.036064]=20
[   33.042436] Adding debian:Microsec_e-Szigno_Root_CA_2009.pem
[   33.042438]=20
[   33.050577] Adding debian:Actalis_Authentication_Root_CA.pem
[   33.050578]=20
[   33.058610] Adding debian:DigiCert_Assured_ID_Root_CA.pem
[   33.058611]=20
[   33.066333] Adding debian:TeliaSonera_Root_CA_v1.pem
[   33.066335]=20
[   33.372724] error: dpkg -i /opt/deb/python3_3.7.3-1_amd64.deb failed.
[   33.372727]=20
[   33.495996]=20
[   33.505341] Adding debian:DigiCert_Assured_ID_Root_G2.pem
[   33.505343]=20
[   33.513296] Adding debian:E-Tugra_Certification_Authority.pem
[   33.513298]=20
[   33.522293] Adding debian:VeriSign_Class_3_Public_Primary_Certification_=
Authority_-_G5.pem
[   33.522295]=20
[   33.533231] Adding debian:USERTrust_RSA_Certification_Authority.pem
[   33.533233]=20
[   33.542040] Adding debian:Staat_der_Nederlanden_Root_CA_-_G2.pem
[   33.542041]=20
[   33.550448] Adding debian:Certplus_Class_2_Primary_CA.pem
[   33.550450]=20
[   33.559161] Adding debian:Hellenic_Academic_and_Research_Institutions_EC=
C_RootCA_2015.pem
[   33.559163]=20
[   33.570231] Adding debian:SSL.com_EV_Root_Certification_Authority_RSA_R2=
=2Epem
[   33.570232]=20
[   33.579676] Adding debian:Hongkong_Post_Root_CA_1.pem
[   33.579677]=20
[   33.586841] Adding debian:CFCA_EV_ROOT.pem
[   33.586842]=20
[   33.594042] Adding debian:Autoridad_de_Certificacion_Firmaprofesional_CI=
F_A62634068.pem
[   33.594044]=20
[   33.604336] Adding debian:QuoVadis_Root_CA_1_G3.pem
[   33.604337]=20
[   33.611562] Adding debian:LuxTrust_Global_Root_2.pem
[   33.611564]=20
[   33.619204] Adding debian:SSL.com_Root_Certification_Authority_RSA.pem
[   33.619205]=20
[   33.628033] Adding debian:GeoTrust_Universal_CA_2.pem
[   33.628035]=20
[   33.635646] Adding debian:Staat_der_Nederlanden_Root_CA_-_G3.pem
[   33.635648]=20
[   33.643981] Adding debian:GlobalSign_Root_CA_-_R3.pem
[   33.643983]=20
[   33.651731] Adding debian:GeoTrust_Primary_Certification_Authority.pem
[   33.651733]=20
[   33.660239] Adding debian:EC-ACC.pem
[   33.660241]=20
[   33.665451] done.
[   33.665452]=20
[   33.669776] Setting up libgcc-8-dev:amd64 (8.3.0-6) ...
[   33.669778]=20
[   33.677242] Setting up lib32gcc1 (1:8.3.0-6) ...
[   33.677244]=20
[   33.684002] Setting up gcc-8 (8.3.0-6) ...
[   33.684003]=20
[   33.690201] Setting up gcc (4:8.3.0-1) ...
[   33.690202]=20
[   33.696467] Setting up g++-8 (8.3.0-6) ...
[   33.696469]=20
[   33.702665] Setting up g++ (4:8.3.0-1) ...
[   33.702667]=20
[   33.709991] update-alternatives: using /usr/bin/g++ to provide /usr/bin/=
c++ (c++) in auto mode
[   33.709993]=20
[   33.720930] Setting up libatk1.0-0:amd64 (2.30.0-2) ...
[   33.720932]=20
[   33.728580] Setting up gir1.2-atk-1.0:amd64 (2.30.0-2) ...
[   33.728582]=20
[   33.736368] Setting up python3-lib2to3 (3.7.3-1) ...
[   33.736370]=20
[   33.743741] Setting up python3-distutils (3.7.3-1) ...
[   33.743742]=20
[   33.751314] Setting up libatk1.0-dev:amd64 (2.30.0-2) ...
[   33.751316]=20
[   33.759317] Setting up libexpat1-dev:amd64 (2.2.6-2+deb10u1) ...
[   33.759319]=20
[   33.767727] Processing triggers for libc-bin (2.28-10) ...
[   33.767728]=20
[   33.775608] Processing triggers for mime-support (3.62) ...
[   33.775609]=20
[   33.783755] Processing triggers for ca-certificates (20190110) ...
[   33.783757]=20
[   33.792259] Updating certificates in /etc/ssl/certs...
[   33.792261]=20
[   33.799368] 0 added, 0 removed; done.
[   33.799369]=20
[   33.805602] Running hooks in /etc/ca-certificates/update.d...
[   33.805604]=20
[   33.812805]=20
[   33.812806]=20
[   33.815888] done.
[   33.815890]=20
[   33.819399] done.
[   33.819401]=20
[   33.825045] dpkg: regarding .../python3-minimal_3.7.3-1_amd64.deb contai=
ning python3-minimal, pre-dependency problem:
[   33.825047]=20
[   33.838398]  python3-minimal pre-depends on python3.7-minimal (>=3D 3.7.=
3-1~)
[   33.838400]=20
[   33.848200]   python3.7-minimal is unpacked, but has never been configur=
ed.
[   33.848202]=20
[   33.856635]=20
[   33.856636]=20
[   33.860696] dpkg: warning: ignoring pre-dependency problem!
[   33.860698]=20
[   33.869895] dpkg: regarding .../deb/python3_3.7.3-1_amd64.deb containing=
 python3, pre-dependency problem:
[   33.869897]=20
[   33.882117]  python3 pre-depends on python3-minimal (=3D 3.7.3-1)
[   33.882119]=20
[   33.890879]   python3-minimal is unpacked, but has never been configured.
[   33.890880]=20
[   33.899132]=20
[   33.899133]=20
[   33.903084] dpkg: warning: ignoring pre-dependency problem!
[   33.903086]=20
[   33.912071] dpkg: regarding .../gawk_1%3a4.2.1+dfsg-1_amd64.deb containi=
ng gawk, pre-dependency problem:
[   33.912073]=20
[   33.923810]  gawk pre-depends on libmpfr6 (>=3D 3.1.3)
[   33.923812]=20
[   33.930846]   libmpfr6 is not installed.
[   33.930848]=20
[   33.936248]=20
[   33.936249]=20
[   33.940284] dpkg: warning: ignoring pre-dependency problem!
[   33.940286]=20
[   33.949273] dpkg: regarding .../gawk_1%3a4.2.1+dfsg-1_amd64.deb containi=
ng gawk, pre-dependency problem:
[   33.949274]=20
[   33.961045]  gawk pre-depends on libsigsegv2 (>=3D 2.9)
[   33.961046]=20
[   33.968270]   libsigsegv2 is not installed.
[   33.968271]=20
[   33.973953]=20
[   33.973954]=20
[   33.978007] dpkg: warning: ignoring pre-dependency problem!
[   33.978009]=20
[   33.986728] dpkg: libperl-dev: dependency problems, but configuring anyw=
ay as you requested:
[   33.986729]=20
[   33.997811]  libperl-dev depends on libc6-dev | libc-dev; however:
[   33.997813]=20
[   34.006335]   Package libc6-dev is not installed.
[   34.006336]=20
[   34.013327]   Package libc-dev is not installed.
[   34.013329]=20
[   34.019417]=20
[   34.019418]=20
[   34.024455] dpkg: libpython2.7-dev:amd64: dependency problems, but confi=
guring anyway as you requested:
[   34.024456]=20
[   34.036296]  libpython2.7-dev:amd64 depends on libexpat1-dev.
[   34.036297]=20
[   34.043499]=20
[   34.043500]=20
[   34.048369] dpkg: python2.7-dev: dependency problems, but configuring an=
yway as you requested:
[   34.048371]=20
[   34.059347]  python2.7-dev depends on libexpat1-dev.
[   34.059349]=20
[   34.065776]=20
[   34.065777]=20
[   34.070407] dpkg: gawk: dependency problems, but configuring anyway as y=
ou requested:
[   34.070409]=20
[   34.080650]  gawk depends on libmpfr6 (>=3D 3.1.3); however:
[   34.080651]=20
[   34.088466]   Package libmpfr6 is not installed.
[   34.088467]=20
[   34.095525]  gawk depends on libsigsegv2 (>=3D 2.9); however:
[   34.095527]=20
[   34.103344]   Package libsigsegv2 is not installed.
[   34.103345]=20
[   34.109682]=20
[   34.109683]=20
[   34.114718] dpkg: libpython3.7-stdlib:amd64: dependency problems, but co=
nfiguring anyway as you requested:
[   34.114721]=20
[   34.127128]  libpython3.7-stdlib:amd64 depends on libmpdec2; however:
[   34.127129]=20
[   34.135898]   Package libmpdec2 is not installed.
[   34.135899]=20
[   34.142114]=20
[   34.142115]=20
[   34.146366] dpkg-query: package 'libglib2.0-dev-bin' is not installed
[   34.146368]=20
[   34.155954] Use dpkg --contents (=3D dpkg-deb --contents) to list archiv=
e files contents.
[   34.155956]=20
[   34.166121] Traceback (most recent call last):
[   34.166122]=20
[   34.173036]   File "/usr/bin/py3clean", line 210, in <module>
[   34.173038]=20
[   34.180439]     main()
[   34.180440]=20
[   34.185202]   File "/usr/bin/py3clean", line 196, in main
[   34.185203]=20
[   34.193220]     pfiles =3D set(dpf.from_package(options.package))
[   34.193222]=20
[   34.202136]   File "/usr/share/python3/debpython/files.py", line 53, in =
=66rom_package
[   34.202138]=20
[   34.212672]     raise Exception("cannot get content of %s" % package_nam=
e)
[   34.212674]=20
[   34.222096] Exception: cannot get content of libglib2.0-dev-bin
[   34.222098]=20
[   34.230600] error running python rtupdate hook libglib2.0-dev-bin
[   34.230601]=20
[   34.239197] dpkg: error processing package python3 (--install):
[   34.239198]=20
[   34.248611]  installed python3 package post-installation script subproce=
ss returned error exit status 4
[   34.248613]=20
[   34.261590] dpkg: gtk-update-icon-cache: dependency problems, but config=
uring anyway as you requested:
[   34.261592]=20
[   34.274036]  gtk-update-icon-cache depends on libgdk-pixbuf2.0-0 (>=3D 2=
=2E30.0); however:
[   34.274038]=20
[   34.284453]   Package libgdk-pixbuf2.0-0 is not installed.
[   34.284456]=20
[   34.292890]  gtk-update-icon-cache depends on libglib2.0-0 (>=3D 2.55.2)=
; however:
[   34.292892]=20
[   34.302575]   Package libglib2.0-0 is not installed.
[   34.302577]=20
[   34.309001]=20
[   34.309002]=20
[   34.314009] dpkg: ca-certificates-java: dependency problems, but configu=
ring anyway as you requested:
[   34.314011]=20
[   34.326503]  ca-certificates-java depends on default-jre-headless | java=
8-runtime-headless; however:
[   34.326505]=20
[   34.338099]   Package default-jre-headless is not installed.
[   34.338101]=20
[   34.346251]   Package java8-runtime-headless is not installed.
[   34.346253]=20
[   34.354951]  ca-certificates-java depends on libnss3 (>=3D 3.12.10-2~); =
however:
[   34.354953]=20
[   34.364314]   Package libnss3 is not installed.
[   34.364316]=20
[   34.370347]=20
[   34.370348]=20
[   34.375304] head: cannot open '/etc/ssl/certs/java/cacerts' for reading:=
 No such file or directory
[   34.375306]=20
[   34.386814] dpkg-query: package 'libnss3' is not installed
[   34.386816]=20
[   34.395302] Use dpkg --contents (=3D dpkg-deb --contents) to list archiv=
e files contents.
[   34.395304]=20
[   34.406575] dpkg: libgcc-8-dev:amd64: dependency problems, but configuri=
ng anyway as you requested:
[   34.406576]=20
[   34.418327]  libgcc-8-dev:amd64 depends on libgomp1 (>=3D 8.3.0-6); howe=
ver:
[   34.418329]=20
[   34.427372]   Package libgomp1 is not installed.
[   34.427374]=20
[   34.434900]  libgcc-8-dev:amd64 depends on libitm1 (>=3D 8.3.0-6); howev=
er:
[   34.434901]=20
[   34.443897]   Package libitm1 is not installed.
[   34.443899]=20
[   34.451145]  libgcc-8-dev:amd64 depends on libasan5 (>=3D 8.3.0-6); howe=
ver:
[   34.451146]=20
[   34.460230]   Package libasan5 is not installed.
[   34.460232]=20
[   34.467611]  libgcc-8-dev:amd64 depends on liblsan0 (>=3D 8.3.0-6); howe=
ver:
[   34.467612]=20
[   34.476670]   Package liblsan0 is not installed.
[   34.476672]=20
[   34.484043]  libgcc-8-dev:amd64 depends on libtsan0 (>=3D 8.3.0-6); howe=
ver:
[   34.484045]=20
[   34.493124]   Package libtsan0 is not installed.
[   34.493126]=20
[   34.500520]  libgcc-8-dev:amd64 depends on libubsan1 (>=3D 8.3.0-6); how=
ever:
[   34.500522]=20
[   34.509687]   Package libubsan1 is not installed.
[   34.509688]=20
[   34.517198]  libgcc-8-dev:amd64 depends on libmpx2 (>=3D 8.3.0-6); howev=
er:
[   34.517199]=20
[   34.526193]   Package libmpx2 is not installed.
[   34.526194]=20
[   34.532193]=20
[   34.532195]=20
[   34.536846] dpkg: lib32gcc1: dependency problems, but configuring anyway=
 as you requested:
[   34.536848]=20
[   34.547742]  lib32gcc1 depends on libc6-i386 (>=3D 2.2.4); however:
[   34.547743]=20
[   34.556129]   Package libc6-i386 is not installed.
[   34.556131]=20
[   34.562411]=20
[   34.562412]=20
[   34.567070] dpkg: gcc-8: dependency problems, but configuring anyway as =
you requested:
[   34.567072]=20
[   34.577356]  gcc-8 depends on cpp-8 (=3D 8.3.0-6); however:
[   34.577358]=20
[   34.584915]   Package cpp-8 is not installed.
[   34.584917]=20
[   34.591729]  gcc-8 depends on libcc1-0 (>=3D 8.3.0-6); however:
[   34.591730]=20
[   34.599783]   Package libcc1-0 is not installed.
[   34.599784]=20
[   34.606868]  gcc-8 depends on binutils (>=3D 2.31.1); however:
[   34.606870]=20
[   34.614784]   Package binutils is not installed.
[   34.614786]=20
[   34.621856]  gcc-8 depends on libisl19 (>=3D 0.15); however:
[   34.621858]=20
[   34.629566]   Package libisl19 is not installed.
[   34.629569]=20
[   34.636445]  gcc-8 depends on libmpc3; however:
[   34.636448]=20
[   34.643175]   Package libmpc3 is not installed.
[   34.643176]=20
[   34.650144]  gcc-8 depends on libmpfr6 (>=3D 3.1.3); however:
[   34.650145]=20
[   34.657904]   Package libmpfr6 is not installed.
[   34.657906]=20
[   34.663987]=20
[   34.663988]=20
[   34.668519] dpkg: gcc: dependency problems, but configuring anyway as yo=
u requested:
[   34.668521]=20
[   34.678700]  gcc depends on cpp (=3D 4:8.3.0-1); however:
[   34.678701]=20
[   34.686051]   Package cpp is not installed.
[   34.686053]=20
[   34.691724]=20
[   34.691726]=20
[   34.696440] dpkg: g++-8: dependency problems, but configuring anyway as =
you requested:
[   34.696442]=20
[   34.707082]  g++-8 depends on libstdc++-8-dev (=3D 8.3.0-6); however:
[   34.707084]=20
[   34.715696]   Package libstdc++-8-dev is not installed.
[   34.715697]=20
[   34.723362]  g++-8 depends on libisl19 (>=3D 0.15); however:
[   34.723363]=20
[   34.731019]   Package libisl19 is not installed.
[   34.731021]=20
[   34.737788]  g++-8 depends on libmpc3; however:
[   34.737789]=20
[   34.744507]   Package libmpc3 is not installed.
[   34.744508]=20
[   34.751445]  g++-8 depends on libmpfr6 (>=3D 3.1.3); however:
[   34.751446]=20
[   34.759239]   Package libmpfr6 is not installed.
[   34.759240]=20
[   34.765339]=20
[   34.765341]=20
[   34.769933] dpkg: g++: dependency problems, but configuring anyway as yo=
u requested:
[   34.769935]=20
[   34.780024]  g++ depends on cpp (=3D 4:8.3.0-1); however:
[   34.780026]=20
[   34.787443]   Package cpp is not installed.
[   34.787445]=20
[   34.793106]=20
[   34.793107]=20
[   34.797948] dpkg: libatk1.0-0:amd64: dependency problems, but configurin=
g anyway as you requested:
[   34.797950]=20
[   34.809757]  libatk1.0-0:amd64 depends on libglib2.0-0 (>=3D 2.55.2); ho=
wever:
[   34.809759]=20
[   34.819068]   Package libglib2.0-0 is not installed.
[   34.819069]=20
[   34.825485]=20
[   34.825486]=20
[   34.830296] dpkg: gir1.2-atk-1.0:amd64: dependency problems, but configu=
ring anyway as you requested:
[   34.830297]=20
[   34.842364]  gir1.2-atk-1.0:amd64 depends on gir1.2-glib-2.0 (>=3D 1.32.=
0); however:
[   34.842365]=20
[   34.852277]   Package gir1.2-glib-2.0 is not installed.
[   34.852278]=20
[   34.858974]=20
[   34.858975]=20
[   34.863718] dpkg: python3-lib2to3: dependency problems, but configuring =
anyway as you requested:
[   34.863719]=20
[   34.875144]  python3-lib2to3 depends on python3 (>=3D 3.7.1-1~); however:
[   34.875146]=20
[   34.884033]   Package python3 is not configured yet.
[   34.884035]=20
[   34.891610]  python3-lib2to3 depends on python3 (<< 3.8); however:
[   34.891611]=20
[   34.900062]   Package python3 is not configured yet.
[   34.900063]=20
[   34.906493]=20
[   34.906494]=20
[   34.911297] dpkg: python3-distutils: dependency problems, but configurin=
g anyway as you requested:
[   34.911299]=20
[   34.922933]  python3-distutils depends on python3 (>=3D 3.7.1-1~); howev=
er:
[   34.922934]=20
[   34.931988]   Package python3 is not configured yet.
[   34.931990]=20
[   34.939643]  python3-distutils depends on python3 (<< 3.8); however:
[   34.939645]=20
[   34.948275]   Package python3 is not configured yet.
[   34.948277]=20
[   34.954701]=20
[   34.954702]=20
[   34.959515] dpkg: libatk1.0-dev:amd64: dependency problems, but configur=
ing anyway as you requested:
[   34.959517]=20
[   34.971168]  libatk1.0-dev:amd64 depends on pkg-config; however:
[   34.971170]=20
[   34.979488]   Package pkg-config is not installed.
[   34.979490]=20
[   34.987323]  libatk1.0-dev:amd64 depends on libglib2.0-dev (>=3D 2.31.2)=
; however:
[   34.987324]=20
[   34.997116]   Package libglib2.0-dev is not installed.
[   34.997118]=20
[   35.003719]=20
[   35.003720]=20
[   35.008673] dpkg: libexpat1-dev:amd64: dependency problems, but configur=
ing anyway as you requested:
[   35.008675]=20
[   35.020610]  libexpat1-dev:amd64 depends on libc6-dev | libc-dev; howeve=
r:
[   35.020612]=20
[   35.029760]   Package libc6-dev is not installed.
[   35.029762]=20
[   35.036867]   Package libc-dev is not installed.
[   35.036869]=20
[   35.043051]=20
[   35.043052]=20
[   35.047192] dpkg-query: package 'libnss3' is not installed
[   35.047194]=20
[   35.055815] Use dpkg --contents (=3D dpkg-deb --contents) to list archiv=
e files contents.
[   35.055817]=20
[   35.066255] dpkg-query: package 'libnss3' is not installed
[   35.066257]=20
[   35.074967] Use dpkg --contents (=3D dpkg-deb --contents) to list archiv=
e files contents.
[   35.074970]=20
[   35.085345] Errors were encountered while processing:
[   35.085347]=20
[   35.092043]  python3
[   35.092044]=20
[   35.096305] handle /opt/deb/keep-deb.hw...
[   35.096306]=20
[   35.104223] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/ntpdate_1%3a4.2.8p12+dfsg-4_amd64.deb
[   35.104226]=20
[   35.118159] (Reading database ... 18840 files and directories currently =
installed.)
[   35.118161]=20
[   35.128652] Preparing to unpack .../ntpdate_1%3a4.2.8p12+dfsg-4_amd64.de=
b ...
[   35.128655]=20
[   35.138660] Unpacking ntpdate (1:4.2.8p12+dfsg-4) over (1:4.2.8p12+dfsg-=
4) ...
[   35.138661]=20
[   35.148421] Setting up ntpdate (1:4.2.8p12+dfsg-4) ...
[   35.148423]=20
[   35.156046] handle /opt/deb/keep-deb.perf-sanity-tests...
[   35.156048]=20
[   35.165472] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/libperl5.28_5.28.1-6+deb10u1_amd64.deb
[   35.165474]=20
[   35.179586] (Reading database ... 18840 files and directories currently =
installed.)
[   35.179588]=20
[   35.190129] Preparing to unpack .../libperl5.28_5.28.1-6+deb10u1_amd64.d=
eb ...
[   35.190131]=20
[   35.200602] Unpacking libperl5.28:amd64 (5.28.1-6+deb10u1) over (5.28.1-=
6+deb10u1) ...
[   35.200604]=20
[   35.211217] Setting up libperl5.28:amd64 (5.28.1-6+deb10u1) ...
[   35.211219]=20
[   35.219653] Processing triggers for libc-bin (2.28-10) ...
[   35.219654]=20
[   35.229193] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/perl_5.28.1-6+deb10u1_amd64.deb
[   35.229196]=20
[   35.242803] (Reading database ... 18840 files and directories currently =
installed.)
[   35.242805]=20
[   35.253115] Preparing to unpack .../perl_5.28.1-6+deb10u1_amd64.deb ...
[   35.253117]=20
[   35.262468] Unpacking perl (5.28.1-6+deb10u1) over (5.28.1-6+deb10u1) ...
[   35.262470]=20
[   35.271527] Setting up perl (5.28.1-6+deb10u1) ...
[   35.271528]=20
[   35.280330] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/perl-base_5.28.1-6+deb10u1_amd64.deb
[   35.280331]=20
[   35.294253] (Reading database ... 18840 files and directories currently =
installed.)
[   35.294255]=20
[   35.304785] Preparing to unpack .../perl-base_5.28.1-6+deb10u1_amd64.deb=
 ...
[   35.304787]=20
[   35.314730] Unpacking perl-base (5.28.1-6+deb10u1) over (5.28.1-6+deb10u=
1) ...
[   35.314732]=20
[   35.324361] Setting up perl-base (5.28.1-6+deb10u1) ...
[   35.324363]=20
[   35.333532] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/perl-modules-5.28_5.28.1-6+deb10u1_all.deb
[   35.333534]=20
[   35.347929] (Reading database ... 18840 files and directories currently =
installed.)
[   35.347931]=20
[   35.358457] Preparing to unpack .../perl-modules-5.28_5.28.1-6+deb10u1_a=
ll.deb ...
[   35.358459]=20
[   35.369042] Unpacking perl-modules-5.28 (5.28.1-6+deb10u1) over (5.28.1-=
6+deb10u1) ...
[   35.369044]=20
[   35.379457] Setting up perl-modules-5.28 (5.28.1-6+deb10u1) ...
[   35.379459]=20
[   35.389377] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/libpython3.7-minimal_3.7.3-2+deb10u2_amd64.deb
[   35.389380]=20
[   35.404087] (Reading database ... 18840 files and directories currently =
installed.)
[   35.404089]=20
[   35.414865] Preparing to unpack .../libpython3.7-minimal_3.7.3-2+deb10u2=
_amd64.deb ...
[   35.414867]=20
[   35.425966] Unpacking libpython3.7-minimal:amd64 (3.7.3-2+deb10u2) over =
(3.7.3-2+deb10u2) ...
[   35.425968]=20
[   35.437193] Setting up libpython3.7-minimal:amd64 (3.7.3-2+deb10u2) ...
[   35.437194]=20
[   35.447924] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/python3.7-minimal_3.7.3-2+deb10u2_amd64.deb
[   35.447926]=20
[   35.462659] (Reading database ... 18840 files and directories currently =
installed.)
[   35.462661]=20
[   35.473330] Preparing to unpack .../python3.7-minimal_3.7.3-2+deb10u2_am=
d64.deb ...
[   35.473332]=20
[   35.483955] Unpacking python3.7-minimal (3.7.3-2+deb10u2) over (3.7.3-2+=
deb10u2) ...
[   35.483957]=20
[   35.494189] Setting up python3.7-minimal (3.7.3-2+deb10u2) ...
[   35.494190]=20
[   35.503755] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/python3-minimal_3.7.3-1_amd64.deb
[   35.503757]=20
[   35.517447] (Reading database ... 18840 files and directories currently =
installed.)
[   35.517450]=20
[   35.527936] Preparing to unpack .../python3-minimal_3.7.3-1_amd64.deb ...
[   35.527938]=20
[   35.537355] Unpacking python3-minimal (3.7.3-1) over (3.7.3-1) ...
[   35.537357]=20
[   35.546027] Setting up python3-minimal (3.7.3-1) ...
[   35.546029]=20
[   35.554996] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/libpython3.7-stdlib_3.7.3-2+deb10u2_amd64.deb
[   35.554998]=20
[   35.569760] (Reading database ... 18840 files and directories currently =
installed.)
[   35.569762]=20
[   35.580481] Preparing to unpack .../libpython3.7-stdlib_3.7.3-2+deb10u2_=
amd64.deb ...
[   35.580483]=20
[   35.591550] Unpacking libpython3.7-stdlib:amd64 (3.7.3-2+deb10u2) over (=
3.7.3-2+deb10u2) ...
[   35.591552]=20
[   35.602680] Setting up libpython3.7-stdlib:amd64 (3.7.3-2+deb10u2) ...
[   35.602682]=20
[   35.613062] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/python3.7_3.7.3-2+deb10u2_amd64.deb
[   35.613064]=20
[   35.626958] (Reading database ... 18840 files and directories currently =
installed.)
[   35.626960]=20
[   35.637402] Preparing to unpack .../python3.7_3.7.3-2+deb10u2_amd64.deb =
=2E..
[   35.637404]=20
[   35.647117] Unpacking python3.7 (3.7.3-2+deb10u2) over (3.7.3-2+deb10u2)=
 ...
[   35.647119]=20
[   35.656452] Setting up python3.7 (3.7.3-2+deb10u2) ...
[   35.656453]=20
[   35.664035] Processing triggers for mime-support (3.62) ...
[   35.664036]=20
[   35.673406] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/libpython3-stdlib_3.7.3-1_amd64.deb
[   35.673408]=20
[   35.687232] (Reading database ... 18840 files and directories currently =
installed.)
[   35.687234]=20
[   35.697640] Preparing to unpack .../libpython3-stdlib_3.7.3-1_amd64.deb =
=2E..
[   35.697641]=20
[   35.707450] Unpacking libpython3-stdlib:amd64 (3.7.3-1) over (3.7.3-1) .=
=2E.
[   35.707451]=20
[   35.716892] Setting up libpython3-stdlib:amd64 (3.7.3-1) ...
[   35.716894]=20
[   35.726093] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/python3_3.7.3-1_amd64.deb
[   35.726095]=20
[   35.739198] (Reading database ... 18840 files and directories currently =
installed.)
[   35.739200]=20
[   35.749503] Preparing to unpack .../deb/python3_3.7.3-1_amd64.deb ...
[   35.749505]=20
[   35.758566] running python pre-rtupdate hooks for python3.7...
[   35.758567]=20
[   35.766929] Unpacking python3 (3.7.3-1) over (3.7.3-1) ...
[   35.766930]=20
[   35.774508] Setting up python3 (3.7.3-1) ...
[   35.774510]=20
[   35.781219] running python rtupdate hooks for python3.7...
[   35.781220]=20
[   35.789345] dpkg-query: package 'libglib2.0-dev-bin' is not installed
[   35.789347]=20
[   35.798830] Use dpkg --contents (=3D dpkg-deb --contents) to list archiv=
e files contents.
[   35.798833]=20
[   35.809051] Traceback (most recent call last):
[   35.809053]=20
[   35.815978]   File "/usr/bin/py3clean", line 210, in <module>
[   35.815979]=20
[   35.823410]     main()
[   35.823411]=20
[   35.828273]   File "/usr/bin/py3clean", line 196, in main
[   35.828274]=20
[   35.836222]     pfiles =3D set(dpf.from_package(options.package))
[   35.836224]=20
[   35.845225]   File "/usr/share/python3/debpython/files.py", line 53, in =
=66rom_package
[   35.845226]=20
[   35.855733]     raise Exception("cannot get content of %s" % package_nam=
e)
[   35.855734]=20
[   35.865151] Exception: cannot get content of libglib2.0-dev-bin
[   35.865153]=20
[   35.873784] error running python rtupdate hook libglib2.0-dev-bin
[   35.873786]=20
[   35.882454] dpkg: error processing package python3 (--install):
[   35.882456]=20
[   35.891881]  installed python3 package post-installation script subproce=
ss returned error exit status 4
[   35.891883]=20
[   35.903510] Errors were encountered while processing:
[   35.903512]=20
[   35.910195]  python3
[   35.910197]=20
[   35.914411] /lkp/lkp/src/bin/run-lkp
[   35.914413]=20
[   36.179370] RESULT_ROOT=3D/result/perf-sanity-tests/gcc-ucode=3D0xe2/lkp=
-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea=
9a80b0ee4b4445ea59c806787813/5
[   36.179372]=20
[   36.435520] Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_d=
rm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
[   36.435522]=20
[   36.452245] Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.=
S' differs from latest version at 'arch/x86/lib/memcpy_64.S'
[   36.452247]=20
[   36.468457] Warning: Kernel ABI header at 'tools/arch/x86/lib/memset_64.=
S' differs from latest version at 'arch/x86/lib/memset_64.S'
[   36.468460]=20
[   36.519676] job=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-=
ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59=
c806787813-20201226-25066-sfkgan-4.yaml
[   36.519679]=20
[   40.350636]   PERF_VERSION =3D 5.10.0-rc3
[   40.350639]=20
[   40.360168] result_service: raw_upload, RESULT_MNT: /internal-lkp-server=
/result, RESULT_ROOT: /internal-lkp-server/result/perf-sanity-tests/gcc-uco=
de=3D0xe2/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9=
/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/5, TMP_RESULT_ROOT: /tmp/lkp/resu=
lt
[   40.360171]=20
[   40.392382] run-job /lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gc=
c-ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea=
59c806787813-20201226-25066-sfkgan-4.yaml
[   40.392385]=20
[   41.611992] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=3D=
0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c8067878=
13-20201226-25066-sfkgan-4.yaml&job_state=3Drunning -O /dev/null
[   41.611996]=20
[   41.644528] target ucode: 0xe2
[   41.644530]=20
[   41.649924] current_version: e2, target_version: e2
[   41.649926]=20
[   41.660932] 2020-12-25 16:24:25 make ARCH=3D EXTRA_CFLAGS=3D-fno-omit-fr=
ame-pointer -fsanitize=3Dundefined -fsanitize=3Daddress -C /usr/src/perf_se=
lftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf
[   41.660934]=20
[   41.683892] make: Entering directory '/usr/src/perf_selftests-x86_64-rhe=
l-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf'
[   41.683894]=20
[   41.698151]=20
[   41.705851]   HOSTCC   fixdep.o
[   41.705852]=20
[   41.710930]   HOSTLD   fixdep-in.o
[   41.710932]=20
[   41.716176]   LINK     fixdep
[   41.716178]=20
[   41.722095] diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i=
915_drm.h
[   41.722097]=20
[   41.732334] diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_6=
4.S
[   41.732336]=20
[   41.742050] diff -u tools/arch/x86/lib/memset_64.S arch/x86/lib/memset_6=
4.S
[   41.742051]=20
[   41.750609]=20
[   41.750611]=20
[   41.754328] Auto-detecting system features:
[   41.754329]=20
[   41.761182]=20
[   41.769690]=20
[   41.778208]=20
[   41.786893]=20
[   41.795429]=20
[   41.803979]=20
[   41.812619]=20
[   41.821159]=20
[   41.829636]=20
[   41.838123]=20
[   41.846659]=20
[   41.855116]=20
[   41.863563]=20
[   41.872017]=20
[   41.880470]=20
[   41.888932]=20
[   41.897438]=20
[   41.905966]=20
[   41.914454]=20
[   41.922950]=20
[   41.931442]=20
[   41.938855]=20
[   41.938856]=20
[   41.942405]   CC       fd/array.o
[   41.942406]=20
[   41.947824]   CC       exec-cmd.o
[   41.947826]=20
[   41.953263]   CC       event-parse.o
[   41.953265]=20
[   41.958811]   CC       core.o
[   41.958813]=20
[   41.963933]   LD       fd/libapi-in.o
[   41.963935]=20
[   41.969600]   CC       fs/fs.o
[   41.969602]=20
[   41.974676]   CC       cpumap.o
[   41.974678]=20
[   41.979796]   CC       help.o
[   41.979798]=20
[   41.984990]   CC       fs/tracing_path.o
[   41.984992]=20
[   41.990989]   CC       fs/cgroup.o
[   41.990991]=20
[   41.996521]   LD       fs/libapi-in.o
[   41.996523]=20
[   42.002134]   CC       cpu.o
[   42.002136]=20
[   42.007025]   CC       pager.o
[   42.007027]=20
[   42.012081]   CC       debug.o
[   42.012083]=20
[   42.017218]   CC       threadmap.o
[   42.017220]=20
[   42.022773]   CC       str_error_r.o
[   42.022775]=20
[   42.028425]   LD       libapi-in.o
[   42.028427]=20
[   42.033864]   AR       libapi.a
[   42.033866]=20
[   42.039022]   CC       evsel.o
[   42.039024]=20
[   42.044251]   CC       parse-options.o
[   42.044253]=20
[   42.050020]   CC       evlist.o
[   42.050022]=20
[   42.055125]   CC       mmap.o
[   42.055127]=20
[   42.060233]   CC       event-plugin.o
[   42.060236]=20
[   42.065978]   CC       trace-seq.o
[   42.065981]=20
[   42.071507]   CC       parse-filter.o
[   42.071509]=20
[   42.077037]   CC       zalloc.o
[   42.077039]=20
[   42.082078]   CC       xyarray.o
[   42.082079]=20
[   42.087148]   CC       lib.o
[   42.087149]=20
[   42.092034]   CC       run-command.o
[   42.092036]=20
[   42.097578]   LD       libperf-in.o
[   42.097580]=20
[   42.102974]   AR       libperf.a
[   42.102976]=20
[   42.108186]   CC       parse-utils.o
[   42.108188]=20
[   42.113823]   GEN      bpf_helper_defs.h
[   42.113824]=20
[   42.119767]   CC       kbuffer-parse.o
[   42.119768]=20
[   42.125451]   MKDIR    staticobjs/
[   42.125453]=20
[   42.130967]   CC       staticobjs/libbpf.o
[   42.130968]=20
[   42.136981]   CC       sigchain.o
[   42.136982]=20
[   42.142317]   CC       subcmd-config.o
[   42.142319]=20
[   42.147998]   MKDIR    staticobjs/
[   42.148000]=20
[   42.153436]   CC       staticobjs/bpf.o
[   42.153438]=20
[   42.159264]   CC       tep_strerror.o
[   42.159266]=20
[   42.164937]   LD       libsubcmd-in.o
[   42.164939]=20
[   42.170671]   CC       event-parse-api.o
[   42.170673]=20
[   42.176516]   AR       libsubcmd.a
[   42.176517]=20
[   42.182002]   LD       libtraceevent-in.o
[   42.182004]=20
[   42.188029]   LINK     libtraceevent.a
[   42.188030]=20
[   42.193886]   CC       staticobjs/nlattr.o
[   42.193887]=20
[   42.200021]   CC       staticobjs/btf.o
[   42.200023]=20
[   42.206069]   CC       staticobjs/libbpf_errno.o
[   42.206070]=20
[   42.212842]   CC       staticobjs/str_error.o
[   42.212844]=20
[   42.219160]   GEN      common-cmds.h
[   42.219161]=20
[   42.224853]   CC       staticobjs/netlink.o
[   42.224854]=20
[   42.231300]   CC       staticobjs/bpf_prog_linfo.o
[   42.231301]=20
[   42.238327]   CC       staticobjs/libbpf_probes.o
[   42.238329]=20
[   42.245076]   CC       staticobjs/xsk.o
[   42.245078]=20
[   42.251040]   CC       staticobjs/hashmap.o
[   42.251042]=20
[   42.257357]   CC       staticobjs/btf_dump.o
[   42.257358]=20
[   42.263732]   CC       staticobjs/ringbuf.o
[   42.263734]=20
[   42.269965]   HOSTCC   pmu-events/json.o
[   42.269966]=20
[   42.275933]   HOSTCC   pmu-events/jsmn.o
[   42.275934]=20
[   42.281827]   CC       plugin_jbd2.o
[   42.281829]=20
[   42.287509]   HOSTCC   pmu-events/jevents.o
[   42.287511]=20
[   42.293723]   LD       plugin_jbd2-in.o
[   42.293724]=20
[   42.299592]   CC       plugin_hrtimer.o
[   42.299594]=20
[   42.305512]   LD       plugin_hrtimer-in.o
[   42.305514]=20
[   42.311590]   CC       plugin_kmem.o
[   42.311591]=20
[   42.317338]   HOSTLD   pmu-events/jevents-in.o
[   42.317340]=20
[   42.323814]   CC       jvmti/libjvmti.o
[   42.323815]=20
[   42.329691]   LD       plugin_kmem-in.o
[   42.329692]=20
[   42.335464]   CC       plugin_kvm.o
[   42.335466]=20
[   42.340966]   LD       plugin_kvm-in.o
[   42.340968]=20
[   42.346774]   CC       plugin_mac80211.o
[   42.346776]=20
[   42.352845]   LD       staticobjs/libbpf-in.o
[   42.352847]=20
[   42.359054]   LINK     libbpf.a
[   42.359055]=20
[   42.364143]   GEN      perf-archive
[   42.364144]=20
[   42.369647]   GEN      perf-with-kcore
[   42.369649]=20
[   42.375463]   LINK     pmu-events/jevents
[   42.375465]=20
[   42.381594]   LD       plugin_mac80211-in.o
[   42.381595]=20
[   42.387904]   CC       plugin_sched_switch.o
[   42.387905]=20
[   42.394217]   CC       plugin_function.o
[   42.394218]=20
[   42.400334]   LD       plugin_sched_switch-in.o
[   42.400336]=20
[   42.407035]   GEN      pmu-events/pmu-events.c
[   42.407036]=20
[   42.413591]   LD       plugin_function-in.o
[   42.413592]=20
[   42.419766]   CC       plugin_futex.o
[   42.419768]=20
[   42.425470]   LD       plugin_futex-in.o
[   42.425472]=20
[   42.431339]   CC       plugin_xen.o
[   42.431341]=20
[   42.436841]   LD       plugin_xen-in.o
[   42.436842]=20
[   42.442575]   CC       plugin_scsi.o
[   42.442576]=20
[   42.448329]   CC       pmu-events/pmu-events.o
[   42.448331]=20
[   42.454864]   CC       jvmti/jvmti_agent.o
[   42.454865]=20
[   42.460995]   LD       plugin_scsi-in.o
[   42.460997]=20
[   42.466887]   CC       plugin_cfg80211.o
[   42.466889]=20
[   42.472927]   LD       plugin_cfg80211-in.o
[   42.472929]=20
[   42.479056]   CC       plugin_tlb.o
[   42.479058]=20
[   42.484574]   LD       plugin_tlb-in.o
[   42.484576]=20
[   42.490319]   LINK     plugin_jbd2.so
[   42.490321]=20
[   42.496039]   LINK     plugin_hrtimer.so
[   42.496041]=20
[   42.501950]   LINK     plugin_kmem.so
[   42.501952]=20
[   42.507595]   LINK     plugin_kvm.so
[   42.507597]=20
[   42.513227]   CC       jvmti/libstring.o
[   42.513229]=20
[   42.519204]   LINK     plugin_mac80211.so
[   42.519205]=20
[   42.525227]   CC       jvmti/libctype.o
[   42.525229]=20
[   42.531217]   LINK     plugin_sched_switch.so
[   42.531219]=20
[   42.537645]   LINK     plugin_function.so
[   42.537647]=20
[   42.543672]   LINK     plugin_futex.so
[   42.543673]=20
[   42.549390]   LINK     plugin_xen.so
[   42.549392]=20
[   42.554969]   LINK     plugin_scsi.so
[   42.554971]=20
[   42.560719]   LINK     plugin_cfg80211.so
[   42.560721]=20
[   42.566703]   LINK     plugin_tlb.so
[   42.566705]=20
[   42.572527]   GEN      libtraceevent-dynamic-list
[   42.572529]=20
[   42.579230]   CC       builtin-bench.o
[   42.579231]=20
[   42.585022]   LD       jvmti/jvmti-in.o
[   42.585023]=20
[   42.590887]   LINK     libperf-jvmti.so
[   42.590889]=20
[   42.596795]   CC       builtin-annotate.o
[   42.596796]=20
[   42.602794]   GEN      python/perf.so
[   42.602795]=20
[   42.608703]   LD       pmu-events/pmu-events-in.o
[   42.608705]=20
[   42.615422]   CC       builtin-config.o
[   42.615423]=20
[   42.621241]   CC       builtin-diff.o
[   42.621243]=20
[   42.626929]   CC       builtin-evlist.o
[   42.626930]=20
[   42.632782]   CC       builtin-ftrace.o
[   42.632784]=20
[   42.908623]   CC       builtin-help.o
[   42.908626]=20
[   43.278131]   CC       builtin-sched.o
[   43.278134]=20
[   43.479903]   CC       builtin-buildid-list.o
[   43.479906]=20
[   43.637961]   CC       builtin-buildid-cache.o
[   43.637964]=20
[   44.178879]   CC       builtin-kallsyms.o
[   44.178882]=20
[   44.296438]   CC       builtin-list.o
[   44.296441]=20
[   44.541360]   CC       builtin-record.o
[   44.541363]=20
[   44.681860]   CC       builtin-report.o
[   44.681863]=20
[   46.229454]   CC       builtin-stat.o
[   46.229458]=20
[   47.575999]   CC       builtin-timechart.o
[   47.576001]=20
[   47.775263]   CC       builtin-top.o
[   47.775266]=20
[   49.082379]   CC       builtin-script.o
[   49.082382]=20
[   50.194480]   CC       builtin-kmem.o
[   50.194483]=20
[   50.734297]   CC       builtin-lock.o
[   50.734300]=20
[   51.831119]   CC       builtin-kvm.o
[   51.831123]=20
[   51.987510]   CC       builtin-inject.o
[   51.987513]=20
[   52.427698]   CC       builtin-mem.o
[   52.427701]=20
[   52.905983]   CC       builtin-data.o
[   52.905987]=20
[   52.996708]   CC       builtin-version.o
[   52.996711]=20
[   53.075336]   CC       builtin-c2c.o
[   53.075339]=20
[   53.093168]   CC       builtin-trace.o
[   53.093171]=20
[   53.532551]   CC       builtin-probe.o
[   53.532555]=20
[   54.232259]   CC       bench/sched-messaging.o
[   54.232263]=20
[   54.540743]   CC       bench/sched-pipe.o
[   54.540746]=20
[   54.682993]   CC       bench/syscall.o
[   54.682996]=20
[   54.769056]   CC       bench/mem-functions.o
[   54.769059]=20
[   54.854904]   CC       tests/builtin-test.o
[   54.854907]=20
[   55.022920]   CC       bench/futex-hash.o
[   55.022923]=20
[   55.228906]   CC       bench/futex-wake.o
[   55.228910]=20
[   55.342497]   CC       tests/parse-events.o
[   55.342500]=20
[   55.396411]   CC       bench/futex-wake-parallel.o
[   55.396414]=20
[   55.637476]   CC       bench/futex-requeue.o
[   55.637479]=20
[   55.821312]   CC       bench/futex-lock-pi.o
[   55.821315]=20
[   56.045377]   CC       bench/epoll-wait.o
[   56.045381]=20
[   56.097953]   CC       util/annotate.o
[   56.097956]=20
[   56.453692]   CC       bench/epoll-ctl.o
[   56.453695]=20
[   56.861059]   CC       bench/synthesize.o
[   56.861062]=20
[   57.084508]   CC       bench/kallsyms-parse.o
[   57.084511]=20
[   57.180344]   CC       bench/find-bit-bench.o
[   57.180347]=20
[   57.324215]   CC       bench/inject-buildid.o
[   57.324217]=20
[   57.758673]   CC       bench/mem-memcpy-x86-64-asm.o
[   57.758676]=20
[   57.781607]   CC       bench/mem-memset-x86-64-asm.o
[   57.781609]=20
[   57.795426]   CC       bench/numa.o
[   57.795428]=20
[   57.923166]   CC       tests/dso-data.o
[   57.923170]=20
[   58.193362]   CC       tests/attr.o
[   58.193365]=20
[   58.543834]   CC       tests/vmlinux-kallsyms.o
[   58.543837]=20
[   58.796486]   CC       tests/openat-syscall.o
[   58.796489]=20
[   58.907726]   CC       tests/openat-syscall-all-cpus.o
[   58.907730]=20
[   59.113706]   CC       tests/openat-syscall-tp-fields.o
[   59.113709]=20
[   59.282651]   CC       tests/mmap-basic.o
[   59.282654]=20
[   59.608964]   CC       tests/perf-record.o
[   59.608967]=20
[   59.987542]   CC       tests/evsel-roundtrip-name.o
[   59.987554]=20
[   60.124199]   CC       tests/evsel-tp-sched.o
[   60.124202]=20
[   60.195016]   CC       util/block-info.o
[   60.195019]=20
[   60.218099]   CC       tests/fdarray.o
[   60.218103]=20
[   60.224448]   LD       bench/perf-in.o
[   60.224450]=20
[   60.260887]   CC       arch/common.o
[   60.260890]=20
[   60.291710]   CC       util/block-range.o
[   60.291713]=20
[   60.384170]   CC       arch/x86/util/header.o
[   60.384173]=20
[   60.523369]   CC       arch/x86/util/tsc.o
[   60.523373]=20
[   60.545488]   CC       tests/pmu.o
[   60.545491]=20
[   60.560608]   CC       arch/x86/util/pmu.o
[   60.560610]=20
[   60.646667]   CC       arch/x86/util/kvm-stat.o
[   60.646669]=20
[   60.680378]   CC       tests/pmu-events.o
[   60.680381]=20
[   60.734988]   CC       arch/x86/tests/regs_load.o
[   60.734991]=20
[   60.757917]   CC       arch/x86/tests/dwarf-unwind.o
[   60.757920]=20
[   60.789298]   CC       arch/x86/util/perf_regs.o
[   60.789301]=20
[   60.877259]   CC       arch/x86/tests/arch-tests.o
[   60.877262]=20
[   60.912394]   CC       arch/x86/tests/rdpmc.o
[   60.912397]=20
[   60.972954]   CC       arch/x86/util/topdown.o
[   60.972957]=20
[   61.062087]   CC       arch/x86/util/machine.o
[   61.062090]=20
[   61.114775]   CC       arch/x86/tests/perf-time-to-tsc.o
[   61.114778]=20
[   61.154451]   CC       util/build-id.o
[   61.154454]=20
[   61.219174]   CC       arch/x86/util/event.o
[   61.219177]=20
[   61.308495]   CC       arch/x86/tests/insn-x86.o
[   61.308499]=20
[   61.349020]   CC       tests/hists_common.o
[   61.349023]=20
[   61.361523]   CC       arch/x86/util/dwarf-regs.o
[   61.361526]=20
[   61.420332]   CC       arch/x86/util/unwind-libunwind.o
[   61.420335]=20
[   61.473851]   CC       arch/x86/util/auxtrace.o
[   61.473854]=20
[   61.528840]   CC       arch/x86/tests/intel-pt-pkt-decoder-test.o
[   61.528843]=20
[   61.617734]   CC       tests/hists_link.o
[   61.617737]=20
[   61.632890]   CC       arch/x86/util/archinsn.o
[   61.632893]=20
[   61.683991]   CC       arch/x86/tests/bp-modify.o
[   61.683994]=20
[   61.751476]   CC       arch/x86/util/intel-pt.o
[   61.751479]=20
[   61.835086]   LD       arch/x86/tests/perf-in.o
[   61.835089]=20
[   61.847769]   CC       arch/x86/util/intel-bts.o
[   61.847772]=20
[   61.867443]   CC       util/cacheline.o
[   61.867446]=20
[   61.904239]   CC       util/config.o
[   61.904242]=20
[   61.977941]   CC       tests/hists_filter.o
[   61.977944]=20
[   62.382008]   CC       tests/hists_output.o
[   62.382011]=20
[   62.405733]   CC       tests/hists_cumulate.o
[   62.405736]=20
[   62.545049]   CC       util/copyfile.o
[   62.545052]=20
[   62.672113]   CC       util/ctype.o
[   62.672116]=20
[   62.702029]   CC       util/db-export.o
[   62.702032]=20
[   63.013555]   LD       arch/x86/util/perf-in.o
[   63.013558]=20
[   63.041420]   LD       arch/x86/perf-in.o
[   63.041423]=20
[   63.061942]   LD       arch/perf-in.o
[   63.061945]=20
[   63.083470]   CC       ui/setup.o
[   63.083473]=20
[   63.179757]   CC       ui/helpline.o
[   63.179760]=20
[   63.285982]   CC       ui/progress.o
[   63.285985]=20
[   63.358594]   CC       ui/util.o
[   63.358596]=20
[   63.436649]   CC       ui/hist.o
[   63.436652]=20
[   63.472374]   CC       tests/python-use.o
[   63.472377]=20
[   63.529827]   CC       tests/bp_signal.o
[   63.529829]=20
[   63.607608]   CC       util/env.o
[   63.607610]=20
[   63.658651]   CC       tests/bp_signal_overflow.o
[   63.658654]=20
[   63.669882]   CC       tests/bp_account.o
[   63.669885]=20
[   63.766963]   CC       tests/wp.o
[   63.766966]=20
[   63.943679]   CC       util/event.o
[   63.943682]=20
[   63.991261]   CC       tests/task-exit.o
[   63.991264]=20
[   64.040936]   CC       util/evlist.o
[   64.040938]=20
[   64.132153]   CC       tests/sw-clock.o
[   64.132156]=20
[   64.275927]   CC       tests/mmap-thread-lookup.o
[   64.275930]=20
[   64.520073]   CC       tests/thread-maps-share.o
[   64.520076]=20
[   64.693439]   CC       tests/switch-tracking.o
[   64.693442]=20
[   64.721448]   CC       util/sideband_evlist.o
[   64.721451]=20
[   64.903392]   CC       util/evsel.o
[   64.903395]=20
[   65.173948]   CC       tests/keep-tracking.o
[   65.173951]=20
[   65.324399]   CC       tests/code-reading.o
[   65.324402]=20
[   66.082243]   CC       tests/sample-parsing.o
[   66.082246]=20
[   66.181531]   CC       util/evsel_fprintf.o
[   66.181534]=20
[   66.504389]   CC       util/perf_event_attr_fprintf.o
[   66.504392]=20
[   66.651780]   CC       tests/parse-no-sample-id-all.o
[   66.651783]=20
[   66.777145]   CC       tests/kmod-path.o
[   66.777148]=20
[   67.034998]   CC       util/evswitch.o
[   67.035001]=20
[   67.094623]   CC       tests/thread-map.o
[   67.094626]=20
[   67.147435]   CC       util/find_bit.o
[   67.147438]=20
[   67.269026]   CC       tests/llvm.o
[   67.269030]=20
[   67.278967]   CC       util/get_current_dir_name.o
[   67.278969]=20
[   67.302902]   CC       util/kallsyms.o
[   67.302905]=20
[   67.408239]   CC       tests/bpf.o
[   67.408243]=20
[   67.556698]   CC       util/levenshtein.o
[   67.556701]=20
[   67.672587]   CC       tests/topology.o
[   67.672590]=20
[   67.683532]   CC       util/llvm-utils.o
[   67.683535]=20
[   67.859475]   CC       tests/mem.o
[   67.859478]=20
[   67.946671]   CC       tests/cpumap.o
[   67.946674]=20
[   68.023789]   CC       util/mmap.o
[   68.023792]=20
[   68.137902]   CC       tests/stat.o
[   68.137905]=20
[   68.319832]   CC       tests/event_update.o
[   68.319835]=20
[   68.357681]   CC       util/memswap.o
[   68.357684]=20
[   68.400539]   BISON    util/parse-events-bison.c
[   68.400541]=20
[   68.466551]   CC       util/perf_regs.o
[   68.466554]=20
[   68.488897]   CC       util/path.o
[   68.488899]=20
[   68.509521]   CC       tests/event-times.o
[   68.509524]=20
[   68.549676]   CC       util/print_binary.o
[   68.549679]=20
[   68.584966]   CC       util/rlimit.o
[   68.584969]=20
[   68.625501]   CC       util/argv_split.o
[   68.625504]=20
[   68.647172]   CC       util/rbtree.o
[   68.647175]=20
[   68.716127]   CC       util/libstring.o
[   68.716130]=20
[   68.821941]   CC       tests/expr.o
[   68.821944]=20
[   68.831499]   CC       util/bitmap.o
[   68.831501]=20
[   68.969502]   CC       tests/backward-ring-buffer.o
[   68.969505]=20
[   68.987170]   CC       tests/sdt.o
[   68.987173]=20
[   69.107211]   CC       tests/is_printable_array.o
[   69.107214]=20
[   69.130092]   CC       tests/bitmap.o
[   69.130095]=20
[   69.189765]   CC       tests/perf-hooks.o
[   69.189768]=20
[   69.231346]   CC       tests/clang.o
[   69.231348]=20
[   69.247785]   CC       tests/unit_number__scnprintf.o
[   69.247787]=20
[   69.269065]   CC       util/hweight.o
[   69.269068]=20
[   69.315200]   CC       tests/mem2node.o
[   69.315203]=20
[   69.321009]   CC       util/smt.o
[   69.321011]=20
[   69.399954]   CC       util/strbuf.o
[   69.399956]=20
[   69.452258]   CC       tests/maps.o
[   69.452260]=20
[   69.502244]   CC       ui/stdio/hist.o
[   69.502247]=20
[   69.612967]   CC       util/string.o
[   69.612969]=20
[   69.669331]   CC       tests/time-utils-test.o
[   69.669334]=20
[   69.743839]   CC       util/strlist.o
[   69.743842]=20
[   69.852182]   CC       util/strfilter.o
[   69.852185]=20
[   69.921236]   CC       util/top.o
[   69.921240]=20
[   69.972555]   CC       tests/genelf.o
[   69.972558]=20
[   70.045834]   CC       tests/api-io.o
[   70.045837]=20
[   70.211602]   CC       util/usage.o
[   70.211605]=20
[   70.267615]   CC       util/dso.o
[   70.267618]=20
[   70.406124]   CC       tests/demangle-java-test.o
[   70.406127]=20
[   70.509956]   CC       tests/pfm.o
[   70.509959]=20
[   70.582724]   CC       tests/parse-metric.o
[   70.582728]=20
[   70.664368]   CC       ui/browser.o
[   70.664371]=20
[   70.856669]   CC       tests/pe-file-parsing.o
[   70.856672]=20
[   70.997726]   CC       tests/expand-cgroup.o
[   70.997729]=20
[   71.323272]   CC       tests/dwarf-unwind.o
[   71.323275]=20
[   71.475913]   CC       ui/browsers/annotate.o
[   71.475916]=20
[   71.503834]   CC       tests/llvm-src-base.o
[   71.503837]=20
[   71.531506]   CC       tests/llvm-src-kbuild.o
[   71.531509]=20
[   71.542163]   CC       util/dsos.o
[   71.542166]=20
[   71.559260]   CC       tests/llvm-src-prologue.o
[   71.559262]=20
[   71.586296]   CC       tests/llvm-src-relocation.o
[   71.586300]=20
[   71.612823]   LD       tests/perf-in.o
[   71.612825]=20
[   71.732652]   CC       scripts/perl/Perf-Trace-Util/Context.o
[   71.732655]=20
[   71.897947]   CC       util/symbol.o
[   71.897950]=20
[   71.996256]   CC       scripts/python/Perf-Trace-Util/Context.o
[   71.996259]=20
[   72.132653]   LD       scripts/python/Perf-Trace-Util/perf-in.o
[   72.132656]=20
[   72.140899]   CC       util/symbol_fprintf.o
[   72.140901]=20
[   72.300213]   CC       util/color.o
[   72.300215]=20
[   72.320392]   LD       scripts/perl/Perf-Trace-Util/perf-in.o
[   72.320395]=20
[   72.346610]   LD       scripts/perf-in.o
[   72.346612]=20
[   72.373291]   CC       util/color_config.o
[   72.373294]=20
[   72.479749]   CC       trace/beauty/clone.o
[   72.479752]=20
[   72.491422]   CC       perf.o
[   72.491424]=20
[   72.627074]   CC       trace/beauty/fcntl.o
[   72.627076]=20
[   72.720004]   CC       trace/beauty/flock.o
[   72.720007]=20
[   72.812593]   CC       trace/beauty/fsmount.o
[   72.812596]=20
[   72.857013]   CC       util/metricgroup.o
[   72.857016]=20
[   72.866773]   CC       trace/beauty/fspick.o
[   72.866776]=20
[   72.879195]   CC       ui/browsers/hists.o
[   72.879198]=20
[   72.928231]   CC       trace/beauty/ioctl.o
[   72.928234]=20
[   73.097468]   CC       trace/beauty/kcmp.o
[   73.097471]=20
[   73.169861]   CC       trace/beauty/mount_flags.o
[   73.169864]=20
[   73.229390]   CC       trace/beauty/move_mount.o
[   73.229393]=20
[   73.281588]   CC       trace/beauty/pkey_alloc.o
[   73.281591]=20
[   73.439799]   CC       trace/beauty/arch_prctl.o
[   73.439802]=20
[   73.484894]   CC       trace/beauty/prctl.o
[   73.484897]=20
[   73.567834]   CC       trace/beauty/renameat.o
[   73.567837]=20
[   73.614854]   CC       trace/beauty/sockaddr.o
[   73.614857]=20
[   73.734373]   CC       trace/beauty/socket.o
[   73.734376]=20
[   73.787273]   CC       trace/beauty/statx.o
[   73.787276]=20
[   73.916600]   CC       trace/beauty/sync_file_range.o
[   73.916603]=20
[   73.983966]   CC       trace/beauty/tracepoints/x86_irq_vectors.o
[   73.983969]=20
[   74.040825]   CC       trace/beauty/tracepoints/x86_msr.o
[   74.040828]=20
[   74.101781]   LD       trace/beauty/tracepoints/perf-in.o
[   74.101784]=20
[   74.109507]   LD       trace/beauty/perf-in.o
[   74.109509]=20
[   74.126086]   CC       util/header.o
[   74.126089]=20
[   74.145426]   CC       util/callchain.o
[   74.145429]=20
[   74.255289]   CC       util/values.o
[   74.255292]=20
[   74.816935]   CC       util/debug.o
[   74.816939]=20
[   75.043371]   CC       util/fncache.o
[   75.043373]=20
[   75.180838]   CC       util/machine.o
[   75.180841]=20
[   76.172052]   CC       util/map.o
[   76.172056]=20
[   77.536682]   CC       util/pstack.o
[   77.536685]=20
[   77.644249]   CC       util/session.o
[   77.644251]=20
[   78.843021]   CC       util/sample-raw.o
[   78.843024]=20
[   78.885600]   CC       util/s390-sample-raw.o
[   78.885603]=20
[   78.931757]   CC       util/syscalltbl.o
[   78.931760]=20
[   79.103228]   CC       util/ordered-events.o
[   79.103231]=20
[   79.161504]   CC       util/namespaces.o
[   79.161507]=20
[   79.469658]   CC       util/comm.o
[   79.469661]=20
[   79.649867]   CC       util/thread.o
[   79.649870]=20
[   79.801952]   CC       util/thread_map.o
[   79.801955]=20
[   80.095891]   CC       ui/browsers/map.o
[   80.095894]=20
[   80.203011]   CC       util/trace-event-parse.o
[   80.203014]=20
[   80.259837]   CC       util/parse-events-bison.o
[   80.259841]=20
[   80.270866]   CC       ui/browsers/scripts.o
[   80.270869]=20
[   80.390410]   CC       ui/browsers/header.o
[   80.390413]=20
[   80.551060]   CC       ui/browsers/res_sample.o
[   80.551063]=20
[   80.581507]   BISON    util/pmu-bison.c
[   80.581510]=20
[   80.609574]   CC       util/trace-event-read.o
[   80.609578]=20
[   80.717878]   CC       util/trace-event-info.o
[   80.717881]=20
[   80.843929]   CC       util/trace-event-scripting.o
[   80.843932]=20
[   80.939917]   CC       util/trace-event.o
[   80.939920]=20
[   81.091798]   CC       util/svghelper.o
[   81.091801]=20
[   81.162072]   CC       util/sort.o
[   81.162075]=20
[   81.825775]   CC       util/hist.o
[   81.825777]=20
[   82.330656]   CC       util/util.o
[   82.330659]=20
[   82.665015]   CC       util/cpumap.o
[   82.665018]=20
[   82.883485]   LD       ui/browsers/perf-in.o
[   82.883488]=20
[   82.918031]   CC       ui/tui/setup.o
[   82.918034]=20
[   83.048132]   CC       ui/tui/util.o
[   83.048136]=20
[   83.293443]   CC       ui/tui/helpline.o
[   83.293446]=20
[   83.328496]   CC       util/affinity.o
[   83.328499]=20
[   83.378411]   CC       ui/tui/progress.o
[   83.378414]=20
[   83.423236]   CC       util/cputopo.o
[   83.423239]=20
[   83.490525]   LD       ui/tui/perf-in.o
[   83.490528]=20
[   83.498892]   LD       ui/perf-in.o
[   83.498895]=20
[   83.546776]   CC       util/cgroup.o
[   83.546779]=20
[   83.702682]   CC       util/target.o
[   83.702685]=20
[   83.837416]   CC       util/rblist.o
[   83.837420]=20
[   83.990294]   CC       util/intlist.o
[   83.990298]=20
[   84.079340]   CC       util/vdso.o
[   84.079343]=20
[   84.156148]   CC       util/counts.o
[   84.156151]=20
[   84.163841]   CC       util/stat.o
[   84.163844]=20
[   84.269112]   CC       util/stat-shadow.o
[   84.269115]=20
[   84.339768]   CC       util/stat-display.o
[   84.339771]=20
[   84.894150]   CC       util/perf_api_probe.o
[   84.894154]=20
[   85.174366]   CC       util/record.o
[   85.174370]=20
[   85.489153]   CC       util/srcline.o
[   85.489156]=20
[   86.063672]   CC       util/srccode.o
[   86.063674]=20
[   86.236314]   CC       util/synthetic-events.o
[   86.236317]=20
[   86.310802]   CC       util/data.o
[   86.310805]=20
[   86.563642]   CC       util/tsc.o
[   86.563645]=20
[   86.722854]   CC       util/cloexec.o
[   86.722857]=20
[   86.786063]   CC       util/call-path.o
[   86.786066]=20
[   86.846848]   CC       util/rwsem.o
[   86.846851]=20
[   86.923062]   CC       util/thread-stack.o
[   86.923065]=20
[   87.053689]   CC       util/spark.o
[   87.053692]=20
[   87.129038]   CC       util/topdown.o
[   87.129041]=20
[   87.137141]   CC       util/stream.o
[   87.137143]=20
[   87.239820]   CC       util/auxtrace.o
[   87.239822]=20
[   87.487416]   CC       util/intel-pt-decoder/intel-pt-pkt-decoder.o
[   87.487419]=20
[   87.969830]   GEN      util/intel-pt-decoder/inat-tables.c
[   87.969834]=20
[   87.989383]   CC       util/intel-pt-decoder/intel-pt-log.o
[   87.989386]=20
[   88.098416]   CC       util/intel-pt-decoder/intel-pt-decoder.o
[   88.098420]=20
[   88.587384]   CC       util/arm-spe-decoder/arm-spe-pkt-decoder.o
[   88.587387]=20
[   88.758135]   CC       util/scripting-engines/trace-event-perl.o
[   88.758138]=20
[   88.923360]   CC       util/arm-spe-decoder/arm-spe-decoder.o
[   88.923364]=20
[   89.141085]   LD       util/arm-spe-decoder/perf-in.o
[   89.141088]=20
[   89.154143]   CC       util/intel-pt.o
[   89.154145]=20
[   90.111447]   CC       util/scripting-engines/trace-event-python.o
[   90.111450]=20
[   90.340128]   CC       util/intel-bts.o
[   90.340131]=20
[   91.314036]   CC       util/arm-spe.o
[   91.314039]=20
[   92.139767]   CC       util/intel-pt-decoder/intel-pt-insn-decoder.o
[   92.139770]=20
[   92.418047]   CC       util/s390-cpumsf.o
[   92.418050]=20
[   92.484918] IPMI BMC is not supported on this machine, skip bmc-watchdog=
 setup!
[   92.484920]=20
[   92.730034]   LD       util/scripting-engines/perf-in.o
[   92.730036]=20
[   92.746003]   CC       util/parse-branch-options.o
[   92.746006]=20
[   92.836998]   CC       util/dump-insn.o
[   92.837001]=20
[   92.874219]   CC       util/parse-regs-options.o
[   92.874222]=20
[   92.973847]   CC       util/parse-sublevel-options.o
[   92.973850]=20
[   93.049678]   CC       util/term.o
[   93.049681]=20
[   93.120614]   CC       util/help-unknown-cmd.o
[   93.120617]=20
[   93.271369]   CC       util/mem-events.o
[   93.271372]=20
[   93.326866]   LD       util/intel-pt-decoder/perf-in.o
[   93.326869]=20
[   93.339617]   CC       util/vsprintf.o
[   93.339620]=20
[   93.381871]   CC       util/units.o
[   93.381874]=20
[   93.406993]   CC       util/time-utils.o
[   93.406996]=20
[   93.463545]   BISON    util/expr-bison.c
[   93.463553]=20
[   93.504588]   CC       util/branch.o
[   93.504591]=20
[   93.762057]   CC       util/mem2node.o
[   93.762060]=20
[   93.815592]   CC       util/clockid.o
[   93.815595]=20
[   93.881437]   CC       util/bpf-loader.o
[   93.881440]=20
[   93.915771]   CC       util/bpf_map.o
[   93.915773]=20
[   93.951612]   CC       util/bpf-prologue.o
[   93.951614]=20
[   94.001444]   CC       util/symbol-elf.o
[   94.001447]=20
[   94.477775]   CC       util/probe-file.o
[   94.477778]=20
[   94.504345]   CC       util/probe-event.o
[   94.504348]=20
[   95.181043]   CC       util/probe-finder.o
[   95.181046]=20
[   95.489640]   CC       util/dwarf-aux.o
[   95.489643]=20
[   95.962112]   CC       util/dwarf-regs.o
[   95.962116]=20
[   96.036715]   CC       util/unwind-libunwind-local.o
[   96.036718]=20
[   96.193677]   CC       util/unwind-libunwind.o
[   96.193680]=20
[   96.335833]   CC       util/data-convert-bt.o
[   96.335837]=20
[   96.394239]   CC       util/zlib.o
[   96.394242]=20
[   96.481037]   CC       util/lzma.o
[   96.481040]=20
[   96.586914]   CC       util/zstd.o
[   96.586918]=20
[   96.686258]   CC       util/cap.o
[   96.686261]=20
[   96.724492]   CC       util/demangle-java.o
[   96.724495]=20
[   96.906327]   CC       util/demangle-rust.o
[   96.906330]=20
[   96.961749]   CC       util/jitdump.o
[   96.961752]=20
[   97.260961]   CC       util/genelf.o
[   97.260965]=20
[   97.509677]   CC       util/genelf_debug.o
[   97.509680]=20
[   97.688485]   CC       util/perf-hooks.o
[   97.688488]=20
[   97.817401]   CC       util/bpf-event.o
[   97.817404]=20
[   97.823441]   FLEX     util/parse-events-flex.c
[   97.823443]=20
[   97.852623]   FLEX     util/pmu-flex.c
[   97.852626]=20
[   97.871335]   CC       util/pmu-bison.o
[   97.871338]=20
[   98.072121]   FLEX     util/expr-flex.c
[   98.072124]=20
[   98.084325]   CC       util/expr-bison.o
[   98.084328]=20
[   98.134994]   CC       util/expr.o
[   98.134997]=20
[   98.336288]   CC       util/parse-events.o
[   98.336291]=20
[   98.373211]   CC       util/parse-events-flex.o
[   98.373214]=20
[   98.668838]   CC       util/pmu.o
[   98.668841]=20
[   98.766785]   CC       util/pmu-flex.o
[   98.766788]=20
[   99.801582]   CC       util/expr-flex.o
[   99.801584]=20
[  105.305151]   LD       util/perf-in.o
[  105.305153]=20
[  105.608741]   LD       perf-in.o
[  105.608743]=20
[  105.912677]   LINK     perf
[  105.912679]=20
[  106.861220] make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf'
[  106.861223]=20
[  106.876156] Key type dns_resolver registered
[  106.876872] 2020-12-25 16:25:39 cd /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf
[  106.880391]=20
[  106.893875] 2020-12-25 16:25:39 mkdir -p /pkg
[  106.893876]=20
[  106.900982] 2020-12-25 16:25:39 mkdir -p /kbuild/obj/consumer/x86_64-rhe=
l-8.3
[  106.900983]=20
[  107.022136] NFS: Registering the id_resolver key type
[  107.027153] Key type id_resolver registered
[  107.031317] Key type id_legacy registered
[  107.080318] 2020-12-25 16:25:39 cp /pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b=
1ba0e7ea9a80b0ee4b4445ea59c806787813/vmlinux.xz /tmp
[  107.080320]=20
[  107.568302] 2020-12-25 16:25:40 unxz -k /tmp/vmlinux.xz
[  107.568304]=20
[  111.277609] 2020-12-25 16:25:44 cp /tmp/vmlinux /kbuild/obj/consumer/x86=
_64-rhel-8.3
[  111.277612]=20
[  111.408565] ignored_by_lkp: BPF filter
[  111.408567]=20
[  111.450570] ignored_by_lkp: LLVM search and compile
[  111.450573]=20
[  111.491919] ignored_by_lkp: Add vfs_getname probe to get syscall args fi=
lenames
[  111.491923]=20
[  111.532915] ignored_by_lkp: Use vfs_getname probe to get syscall args fi=
lenames
[  111.532918]=20
[  111.574082] ignored_by_lkp: Check open filename arg using perf trace + v=
fs_getname
[  111.574085]=20
[  111.614721] ignored_by_lkp: builtin clang support
[  111.614737]=20
[  111.662896] 2020-12-25 16:25:44 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 1
[  111.662898]=20
[  112.494369]  1: vmlinux symtab matches kallsyms                         =
        : Ok
[  112.494373]=20
[  112.515321] 2020-12-25 16:25:45 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 2
[  112.515323]=20
[  112.580941]  2: Detect openat syscall event                             =
        : Ok
[  112.580944]=20
[  112.601463] 2020-12-25 16:25:45 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 3
[  112.601465]=20
[  112.670091]  3: Detect openat syscall event on all cpus                 =
        : Ok
[  112.670094]=20
[  112.691113] 2020-12-25 16:25:45 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 4
[  112.691116]=20
[  112.813020]  4: Read samples using the mmap interface                   =
        : FAILED!
[  112.813023]=20
[  112.834024] 2020-12-25 16:25:45 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 5
[  112.834027]=20
[  112.878434]  5: Test data source output                                 =
        : Ok
[  112.878436]=20
[  112.898869] 2020-12-25 16:25:45 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 6
[  112.898872]=20
[  114.181584]  6: Parse event definition strings                          =
        : FAILED!
[  114.181601]=20
[  114.201812] 2020-12-25 16:25:47 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 7
[  114.201814]=20
[  114.247836]  7: Simple expression parser                                =
        : Ok
[  114.247839]=20
[  114.268764] 2020-12-25 16:25:47 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 8
[  114.268767]=20
[  116.326288]  8: PERF_RECORD_* events & perf_sample fields               =
        : Ok
[  116.326291]=20
[  116.346857] 2020-12-25 16:25:49 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 9
[  116.346859]=20
[  116.398116]  9: Parse perf pmu format                                   =
        : Ok
[  116.398119]=20
[  116.418850] 2020-12-25 16:25:49 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 10
[  116.418853]=20
[  116.445990] 10: PMU events                                              =
        :
[  116.445993]=20
[  116.464657] 10.1: PMU event table sanity                                =
        : Ok
[  116.464660]=20
[  116.551692] 10.2: PMU event map aliases                                 =
        : Ok
[  116.551694]=20
[  118.242663] 10.3: Parsing of PMU event table metrics                    =
        : Skip (some metrics failed)
[  118.242666]=20
[  118.371444] 10.4: Parsing of PMU event table metrics with fake PMUs     =
        : Ok
[  118.371447]=20
[  118.392337] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 11
[  118.392339]=20
[  118.438031] 11: DSO data read                                           =
        : Ok
[  118.438034]=20
[  118.458965] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 12
[  118.458967]=20
[  118.505934] 12: DSO data cache                                          =
        : Ok
[  118.505937]=20
[  118.526529] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 13
[  118.526531]=20
[  118.573140] 13: DSO data reopen                                         =
        : Ok
[  118.573143]=20
[  118.593876] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 14
[  118.593879]=20
[  118.640613] 14: Roundtrip evsel->name                                   =
        : Ok
[  118.640617]=20
[  118.661177] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 15
[  118.661180]=20
[  118.708521] 15: Parse sched tracepoints fields                          =
        : Ok
[  118.708523]=20
[  118.729055] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 16
[  118.729057]=20
[  118.796829] 16: syscalls:sys_enter_openat event fields                  =
        : Ok
[  118.796831]=20
[  118.817097] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 17
[  118.817100]=20
[  132.920286] 17: Setup struct perf_event_attr                            =
        : Ok
[  132.920288]=20
[  132.940728] 2020-12-25 16:26:05 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 18
[  132.940730]=20
[  132.985757] 18: Match and link multiple hists                           =
        : Ok
[  132.985760]=20
[  133.006200] 2020-12-25 16:26:05 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 19
[  133.006202]=20
[  133.063471] 19: 'import perf' in python                                 =
        : FAILED!
[  133.063474]=20
[  133.083996] 2020-12-25 16:26:05 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 20
[  133.083999]=20
[  133.130030] 20: Breakpoint overflow signal handler                      =
        : Ok
[  133.130033]=20
[  133.151059] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 21
[  133.151061]=20
[  133.204150] 21: Breakpoint overflow sampling                            =
        : Ok
[  133.204153]=20
[  133.224792] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 22
[  133.224794]=20
[  133.270011] 22: Breakpoint accounting                                   =
        : Ok
[  133.270014]=20
[  133.290812] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 23
[  133.290814]=20
[  133.317877] 23: Watchpoint                                              =
        :
[  133.317880]=20
[  133.336340] 23.1: Read Only Watchpoint                                  =
        : Skip
[  133.336342]=20
[  133.354651] 23.2: Write Only Watchpoint                                 =
        : Ok
[  133.354653]=20
[  133.372948] 23.3: Read / Write Watchpoint                               =
        : Ok
[  133.372951]=20
[  133.391146] 23.4: Modify Watchpoint                                     =
        : Ok
[  133.391148]=20
[  133.411988] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 24
[  133.411990]=20
[  133.488894] 24: Number of exit events of a simple workload              =
        : FAILED!
[  133.488897]=20
[  133.509502] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 25
[  133.509504]=20
[  133.615162] 25: Software clock events period values                     =
        : FAILED!
[  133.615165]=20
[  133.635244] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 26
[  133.635246]=20
[  134.075631] perf: interrupt took too long (2601 > 2500), lowering kernel=
=2Eperf_event_max_sample_rate to 76000
[  136.755784] 26: Object code reading                                     =
        : FAILED!
[  136.755786]=20
[  136.776297] 2020-12-25 16:26:09 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 27
[  136.776300]=20
[  136.821956] 27: Sample parsing                                          =
        : Ok
[  136.821959]=20
[  136.842807] 2020-12-25 16:26:09 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 28
[  136.842810]=20
[  136.918980] 28: Use a dummy software event to keep tracking             =
        : FAILED!
[  136.918983]=20
[  136.939689] 2020-12-25 16:26:09 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 29
[  136.939692]=20
[  136.985042] 29: Parse with no sample_id_all bit set                     =
        : Ok
[  136.985045]=20
[  137.005701] 2020-12-25 16:26:09 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 30
[  137.005703]=20
[  137.051953] 30: Filter hist entries                                     =
        : Ok
[  137.051956]=20
[  137.073083] 2020-12-25 16:26:09 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 31
[  137.073086]=20
[  137.487808] 31: Lookup mmap thread                                      =
        : FAILED!
[  137.487811]=20
[  137.508920] 2020-12-25 16:26:10 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 32
[  137.508923]=20
[  137.554376] 32: Share thread maps                                       =
        : Ok
[  137.554379]=20
[  137.575109] 2020-12-25 16:26:10 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 33
[  137.575112]=20
[  137.621995] 33: Sort output of hist entries                             =
        : Ok
[  137.621997]=20
[  137.643113] 2020-12-25 16:26:10 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 34
[  137.643116]=20
[  137.689930] 34: Cumulate child hist entries                             =
        : Ok
[  137.689933]=20
[  137.710669] 2020-12-25 16:26:10 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 35
[  137.710671]=20
[  138.186132] 35: Track with sched_switch                                 =
        : FAILED!
[  138.186135]=20
[  138.206753] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 36
[  138.206756]=20
[  138.252009] 36: Filter fds with revents mask in a fdarray               =
        : Ok
[  138.252012]=20
[  138.272663] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 37
[  138.272666]=20
[  138.317606] 37: Add fd to a fdarray, making it autogrow                 =
        : Ok
[  138.317609]=20
[  138.338054] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 38
[  138.338057]=20
[  138.383303] 38: kmod_path__parse                                        =
        : Ok
[  138.383306]=20
[  138.403887] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 39
[  138.403889]=20
[  138.449721] 39: Thread map                                              =
        : Ok
[  138.449724]=20
[  138.472155] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 41
[  138.472158]=20
[  138.700130] 41: Session topology                                        =
        : FAILED!
[  138.700133]=20
[  138.722000] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 43
[  138.722002]=20
[  138.796404] 43: Synthesize thread map                                   =
        : FAILED!
[  138.796406]=20
[  138.817104] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 44
[  138.817106]=20
[  138.888377] 44: Remove thread map                                       =
        : FAILED!
[  138.888380]=20
[  138.908976] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 45
[  138.908978]=20
[  138.954887] 45: Synthesize cpu map                                      =
        : Ok
[  138.954890]=20
[  138.975511] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 46
[  138.975514]=20
[  139.020705] 46: Synthesize stat config                                  =
        : Ok
[  139.020708]=20
[  139.041376] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 47
[  139.041378]=20
[  139.085894] 47: Synthesize stat                                         =
        : Ok
[  139.085897]=20
[  139.106184] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 48
[  139.106187]=20
[  139.152015] 48: Synthesize stat round                                   =
        : Ok
[  139.152018]=20
[  139.173141] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 49
[  139.173144]=20
[  139.253527] 49: Synthesize attr update                                  =
        : FAILED!
[  139.253530]=20
[  139.274504] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 50
[  139.274507]=20
[  139.332635] 50: Event times                                             =
        : Ok
[  139.332638]=20
[  139.353134] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 51
[  139.353137]=20
[  139.487719] 51: Read backward ring buffer                               =
        : Ok
[  139.487722]=20
[  139.508250] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 52
[  139.508252]=20
[  139.583084] 52: Print cpu map                                           =
        : FAILED!
[  139.583086]=20
[  139.603431] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 53
[  139.603433]=20
[  139.648935] 53: Merge cpu map                                           =
        : Ok
[  139.648937]=20
[  139.669741] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 54
[  139.669744]=20
[  139.716023] 54: Probe SDT events                                        =
        : Ok
[  139.716025]=20
[  139.736752] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 55
[  139.736755]=20
[  139.780981] 55: is_printable_array                                      =
        : Ok
[  139.780984]=20
[  139.801687] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 56
[  139.801690]=20
[  139.847641] 56: Print bitmap                                            =
        : Ok
[  139.847644]=20
[  139.868185] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 57
[  139.868188]=20
[  139.913098] 57: perf hooks                                              =
        : Ok
[  139.913100]=20
[  139.934734] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 59
[  139.934737]=20
[  139.979489] 59: unit_number__scnprintf                                  =
        : Ok
[  139.979492]=20
[  140.000147] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 60
[  140.000150]=20
[  140.044935] 60: mem2node                                                =
        : Ok
[  140.044938]=20
[  140.065505] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 61
[  140.065507]=20
[  140.111033] 61: time utils                                              =
        : Ok
[  140.111035]=20
[  140.131867] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 62
[  140.131870]=20
[  140.178067] 62: Test jit_write_elf                                      =
        : Ok
[  140.178070]=20
[  140.199296] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 63
[  140.199298]=20
[  140.226438] 63: Test libpfm4 support                                    =
        : Skip (not compiled in)
[  140.226441]=20
[  140.245694] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 64
[  140.245696]=20
[  140.291678] 64: Test api io                                             =
        : Ok
[  140.291681]=20
[  140.312114] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 65
[  140.312116]=20
[  140.392987] 65: maps__merge_in                                          =
        : FAILED!
[  140.392989]=20
[  140.413807] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 66
[  140.413810]=20
[  140.459562] 66: Demangle Java                                           =
        : Ok
[  140.459579]=20
[  140.480666] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 67
[  140.480669]=20
[  140.529782] 67: Parse and process metrics                               =
        : Ok
[  140.529785]=20
[  140.550204] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 68
[  140.550206]=20
[  140.623476] 68: PE file support                                         =
        : FAILED!
[  140.623478]=20
[  140.644073] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 69
[  140.644075]=20
[  140.690168] 69: Event expansion for cgroups                             =
        : Ok
[  140.690171]=20
[  140.710643] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 70
[  140.710646]=20
[  140.944296] 70: x86 rdpmc                                               =
        : Ok
[  140.944299]=20
[  140.964817] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 71
[  140.964820]=20
[  141.041137] 71: Convert perf time to TSC                                =
        : FAILED!
[  141.041140]=20
[  141.061746] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 72
[  141.061748]=20
[  141.457682] 72: DWARF unwind                                            =
        : FAILED!
[  141.457685]=20
[  141.478307] 2020-12-25 16:26:14 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 73
[  141.478310]=20
[  141.525183] 73: x86 instruction decoder - new instructions              =
        : Ok
[  141.525186]=20
[  141.545833] 2020-12-25 16:26:14 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 74
[  141.545836]=20
[  141.591564] 74: Intel PT packet decoder                                 =
        : Ok
[  141.591567]=20
[  141.612192] 2020-12-25 16:26:14 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 75
[  141.612194]=20
[  141.665823] 75: x86 bp modify                                           =
        : Ok
[  141.665825]=20
[  141.686216] 2020-12-25 16:26:14 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 76
[  141.686219]=20
[  143.484830] 76: probe libc's inet_pton & backtrace it with ping         =
        : Ok
[  143.484833]=20
[  143.505402] 2020-12-25 16:26:16 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 77
[  143.505404]=20
[  143.695126] 77: Check Arm CoreSight trace data recording and synthesized=
 samples: Skip
[  143.695129]=20
[  143.715677] 2020-12-25 16:26:16 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 78
[  143.715680]=20
[  145.157288] 78: build id cache operations                               =
        : FAILED!
[  145.157291]=20
[  145.180175] 2020-12-25 16:26:18 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 81
[  145.180178]=20
[  146.486914] 81: Zstd perf.data compression/decompression                =
        : FAILED!
[  146.486917]=20
[  146.537605] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=3D=
0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c8067878=
13-20201226-25066-sfkgan-4.yaml&job_state=3Dpost_run -O /dev/null
[  146.537608]=20
[  148.252191] kill 2507 vmstat --timestamp -n 10=20
[  148.252194]=20
[  148.258935] kill 2505 dmesg --follow --decode=20
[  148.258936]=20
[  148.266035] wait for background processes: 2510 2512 meminfo oom-killer
[  148.266036]=20
[  154.480959] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=3D=
0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c8067878=
13-20201226-25066-sfkgan-4.yaml&loadavg=3D1.83%201.13%200.45%201/135%208978=
&start_time=3D1608913465&end_time=3D1608913579&version=3D/lkp/lkp/.src-2020=
1225-151440:04492474:3e57f6440& -O /dev/null
[  154.480962]=20
[  154.531104] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=3D=
0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c8067878=
13-20201226-25066-sfkgan-4.yaml&job_state=3Dfinished -O /dev/null
[  154.531105]=20
[  154.570198] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-post-run?job_file=
=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=3D0xe2-debia=
n-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813-2020122=
6-25066-sfkgan-4.yaml -O /dev/null
[  154.570199]=20
[  154.903935] getting new job...
[  154.903938]=20
[  154.935136] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/gpxelinux.cgi?hostnam=
e=3Dlkp-skl-d04&mac=3D64:00:6a:30:92:35&last_kernel=3D/pkg/linux/x86_64-rhe=
l-8.3/gcc-9/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/vmlinuz-5.10.0-rc3-011=
27-g8c3b1ba0e7ea&lkp_wtmp -O /tmp/next-job-lkp
[  154.935139]=20
[  160.893508] 22 blocks
[  160.893511]=20
[  160.895323] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp//lkp/jobs/scheduled/lkp-skl-d=
04/hwsim-group-22-ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-bcf876870b95=
592b52519ed4aafcf9d95999bc9c-20201226-1429-g4u7i0-0.cgz -O /tmp/next-job.cgz
[  160.897280]=20
[  160.939474] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-wtmp?tbox_name=3D=
lkp-skl-d04&tbox_state=3Dkexec_to_next_job -O /dev/null
[  160.939476]=20
[  161.471655] downloading kernel image ...
[  161.471657]=20
[  161.502653] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-22-ucode=3D0xe2-de=
bian-10.4-x86_64-20200603.cgz-bcf876870b95592b52519ed4aafcf9d95999bc9c-2020=
1226-1429-g4u7i0-0.yaml&job_state=3Dwget_kernel -O /dev/null
[  161.502655]=20
[  162.154018] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/pkg/linux/x86_64-rhel-8.3/gcc=
-9/bcf876870b95592b52519ed4aafcf9d95999bc9c/vmlinuz-5.8.0 -N -P /opt/rootfs=
/tmp/pkg/linux/x86_64-rhel-8.3/gcc-9/bcf876870b95592b52519ed4aafcf9d95999bc=
9c
[  162.154021]=20
[  162.181728] downloading initrds ...
[  162.181730]=20
[  162.194272] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-22-ucode=3D0xe2-de=
bian-10.4-x86_64-20200603.cgz-bcf876870b95592b52519ed4aafcf9d95999bc9c-2020=
1226-1429-g4u7i0-0.yaml&job_state=3Dwget_initrd -O /dev/null
[  162.194274]=20
[  162.746326] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/debian/debian-10.4-x8=
6_64-20200603.cgz -N -P /opt/rootfs/tmp/osimage/debian
[  162.746329]=20
[  162.919387] /opt/rootfs/tmp/osimage/debian/debian-10.4-x86_64-20200603.c=
gz isn't modified
[  162.919390]=20
[  162.936434] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/lkp/jobs/scheduled/lkp-skl-d0=
4/hwsim-group-22-ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-bcf876870b955=
92b52519ed4aafcf9d95999bc9c-20201226-1429-g4u7i0-0.cgz -N -P /opt/rootfs/tm=
p/lkp/jobs/scheduled/lkp-skl-d04
[  162.936436]=20
[  162.936681] 22 blocks
[  162.966051]=20
[  162.968198] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/user/lkp/lkp-x86_64.c=
gz -N -P /opt/rootfs/tmp/osimage/user/lkp
[  162.969801]=20
[  162.988840] /opt/rootfs/tmp/osimage/user/lkp/lkp-x86_64.cgz isn't modifi=
ed
[  162.988841]=20
[  163.002717] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/deps/debian-10.4-x86_=
64-20200603.cgz/run-ipconfig_20200608.cgz -N -P /opt/rootfs/tmp/osimage/dep=
s/debian-10.4-x86_64-20200603.cgz
[  163.002719]=20
[  163.028313] /opt/rootfs/tmp/osimage/deps/debian-10.4-x86_64-20200603.cgz=
/run-ipconfig_20200608.cgz isn't modified
[  163.028314]=20
[  163.044992] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/deps/debian-10.4-x86_=
64-20200603.cgz/lkp_20201211.cgz -N -P /opt/rootfs/tmp/osimage/deps/debian-=
10.4-x86_64-20200603.cgz
[  163.044993]=20
[  163.069417] /opt/rootfs/tmp/osimage/deps/debian-10.4-x86_64-20200603.cgz=
/lkp_20201211.cgz isn't modified
[  163.069418]=20
[  163.085370] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/deps/debian-10.4-x86_=
64-20200603.cgz/rsync-rootfs_20200608.cgz -N -P /opt/rootfs/tmp/osimage/dep=
s/debian-10.4-x86_64-20200603.cgz
[  163.085371]=20
[  163.110809] /opt/rootfs/tmp/osimage/deps/debian-10.4-x86_64-20200603.cgz=
/rsync-rootfs_20200608.cgz isn't modified
[  163.110810]=20
[  163.127488] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/deps/debian-10.4-x86_=
64-20200603.cgz/hwsim_20201110.cgz -N -P /opt/rootfs/tmp/osimage/deps/debia=
n-10.4-x86_64-20200603.cgz
[  163.127489]=20
[  163.314539] /opt/rootfs/tmp/osimage/deps/debian-10.4-x86_64-20200603.cgz=
/hwsim_20201110.cgz isn't modified
[  163.314541]=20
[  163.331135] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/pkg/debian-10.4-x86_6=
4-20200603.cgz/hwsim-x86_64-537ab94-1_20201123.cgz -N -P /opt/rootfs/tmp/os=
image/pkg/debian-10.4-x86_64-20200603.cgz
[  163.331136]=20
[  163.357474] /opt/rootfs/tmp/osimage/pkg/debian-10.4-x86_64-20200603.cgz/=
hwsim-x86_64-537ab94-1_20201123.cgz isn't modified
[  163.357475]=20
[  163.375188] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/deps/debian-10.4-x86_=
64-20200603.cgz/hw_20200715.cgz -N -P /opt/rootfs/tmp/osimage/deps/debian-1=
0.4-x86_64-20200603.cgz
[  163.375189]=20
[  163.399666] /opt/rootfs/tmp/osimage/deps/debian-10.4-x86_64-20200603.cgz=
/hw_20200715.cgz isn't modified
[  163.399668]=20
[  163.417104] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/pkg/linux/x86_64-rhel-8.3/gcc=
-9/bcf876870b95592b52519ed4aafcf9d95999bc9c/modules.cgz -N -P /opt/rootfs/t=
mp/pkg/linux/x86_64-rhel-8.3/gcc-9/bcf876870b95592b52519ed4aafcf9d95999bc9c
[  163.417105]=20
[  163.679305] /opt/rootfs/tmp/pkg/linux/x86_64-rhel-8.3/gcc-9/bcf876870b95=
592b52519ed4aafcf9d95999bc9c/modules.cgz isn't modified
[  163.679308]=20
[  163.696313] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/ucode/intel-ucode-202=
01117.cgz -N -P /opt/rootfs/tmp/osimage/ucode
[  163.696315]=20
[  163.715750] /opt/rootfs/tmp/osimage/ucode/intel-ucode-20201117.cgz isn't=
 modified
[  163.715751]=20
[  164.604333] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-22-ucode=3D0xe2-de=
bian-10.4-x86_64-20200603.cgz-bcf876870b95592b52519ed4aafcf9d95999bc9c-2020=
1226-1429-g4u7i0-0.yaml&last_kernel=3D5.10.0-rc3-01127-g8c3b1ba0e7ea -O /de=
v/null
[  164.604335]=20
[  165.104519] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-22-ucode=3D0xe2-de=
bian-10.4-x86_64-20200603.cgz-bcf876870b95592b52519ed4aafcf9d95999bc9c-2020=
1226-1429-g4u7i0-0.yaml&job_state=3Dbooting -O /dev/null
[  165.104521]=20
[  165.663906] LKP: kexec loading...
[  165.663908]=20
[  165.672092] kexec --noefi -l /opt/rootfs/tmp/pkg/linux/x86_64-rhel-8.3/g=
cc-9/bcf876870b95592b52519ed4aafcf9d95999bc9c/vmlinuz-5.8.0 --initrd=3D/opt=
/rootfs/tmp/initrd-concatenated
[  165.672093]=20
[  168.641536] --append=3Dip=3D::::lkp-skl-d04::dhcp root=3D/dev/ram0 user=
=3Dlkp job=3D/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-22-ucode=3D0xe2-de=
bian-10.4-x86_64-20200603.cgz-bcf876870b95592b52519ed4aafcf9d95999bc9c-2020=
1226-1429-g4u7i0-0.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3 branch=3Din=
ternal-devel/devel-hourly-2020122418 commit=3Dbcf876870b95592b52519ed4aafcf=
9d95999bc9c BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/bcf876870b95592b5=
2519ed4aafcf9d95999bc9c/vmlinuz-5.8.0 max_uptime=3D2100 RESULT_ROOT=3D/resu=
lt/hwsim/group-22-ucode=3D0xe2/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/=
x86_64-rhel-8.3/gcc-9/bcf876870b95592b52519ed4aafcf9d95999bc9c/25 LKP_SERVE=
R=3Dinternal-lkp-server nokaslr selinux=3D0 debug apic=3Ddebug sysrq_always=
_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkms=
g=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic lo=
ad_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_lev
[  168.641539]=20
LKP: rebooting
[  169.708755] e1000e 0000:00:1f.6 eth0: NIC Link is Down
[  169.713966] kvm: exiting hardware virtualization
[  169.718708] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
[  169.723948] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  169.729419] e1000e: EEE TX LPI TIMER: 00000011
Starting new kernel
Decompressing Linux... Parsing ELF... No relocation needed... done.
Booting the kernel.
[    0.000000] Linux version 5.10.0-rc3-01127-g8c3b1ba0e7ea (kbuild@ef0b816=
f83ac) (gcc-9 (Debian 9.3.0-15) 9.3.0, GNU ld (GNU Binutils for Debian) 2.3=
5) #1 SMP Thu Dec 24 12:43:54 CST 2020
APPEND dmesg: /result/perf-sanity-tests/gcc-ucode=3D0xe2/lkp-skl-d04/debian=
-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0ee4b4445e=
a59c806787813/5/dmesg already exists
[    0.000000] Command line: ip=3D::::lkp-skl-d04::dhcp root=3D/dev/ram0 us=
er=3Dlkp job=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=
=3D0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c8067=
87813-20201226-25066-sfkgan-4.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3 =
branch=3Ddrm-intel/drm-intel-gt-next commit=3D8c3b1ba0e7ea9a80b0ee4b4445ea5=
9c806787813 BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b=
0ee4b4445ea59c806787813/vmlinuz-5.10.0-rc3-01127-g8c3b1ba0e7ea max_uptime=
=3D2100 RESULT_ROOT=3D/result/perf-sanity-tests/gcc-ucode=3D0xe2/lkp-skl-d0=
4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0e=
e4b4445ea59c806787813/5 LKP_SERVER=3Dinternal-lkp-server nokaslr selinux=3D=
0 debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D=
100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi=
_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.min=
or_count=3D8 systemd.log_level=3Derr ignore_loglevel console=3Dtty0 earlypr=
intk=3DttyS0,11
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registe=
rs'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 b=
ytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000100-0x000000000009c7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009c800-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007caa5fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007caa6000-0x000000007caa6fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000007caa7000-0x000000007cad0fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007cad1000-0x000000007cb22fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007cb23000-0x000000007d323fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007d324000-0x0000000086f56fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000086f57000-0x00000000872bcfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000872bd000-0x0000000087309fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000008730a000-0x0000000087abefff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000087abf000-0x0000000087ffefff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000087fff000-0x0000000087ffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000871ffffff] usable
[    0.000000] printk: debug: ignoring loglevel setting.
[    0.000000] printk: bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
[    0.000000] tsc: Detected 3200.000 MHz processor
[    0.000000] tsc: Detected 3199.980 MHz TSC
[    0.000624] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.011117] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.016616] last_pfn =3D 0x872000 max_arch_pfn =3D 0x400000000
[    0.022022] MTRR default type: write-back
[    0.025970] MTRR fixed ranges enabled:
[    0.029660]   00000-9FFFF write-back
[    0.033182]   A0000-BFFFF uncachable
[    0.036700]   C0000-FFFFF write-protect
[    0.040479] MTRR variable ranges enabled:
[    0.044427]   0 base 00C0000000 mask 7FC0000000 uncachable
[    0.049836]   1 base 00A0000000 mask 7FE0000000 uncachable
[    0.055245]   2 base 0090000000 mask 7FF0000000 uncachable
[    0.060653]   3 base 008C000000 mask 7FFC000000 uncachable
[    0.066062]   4 base 008A000000 mask 7FFE000000 uncachable
[    0.071470]   5 base 0089800000 mask 7FFF800000 uncachable
[    0.076878]   6 disabled
[    0.079366]   7 disabled
[    0.081858]   8 disabled
[    0.084347]   9 disabled
[    0.087123] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.094209] last_pfn =3D 0x88000 max_arch_pfn =3D 0x400000000
[    0.099411] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.104574] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.109724] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.120345] found SMP MP-table at [mem 0x000fcde0-0x000fcdef]
[    0.125856]   mpc: fcbb0-fcd5c
[    0.128871] Using GB pages for direct mapping
[    0.133596] RAMDISK: [mem 0x83bb72000-0x86ebfffff]
[    0.138166] ACPI: Early table checksum verification disabled
[    0.143742] ACPI: RSDP 0x00000000000F05B0 000024 (v02 DELL  )
[    0.149407] ACPI: XSDT 0x00000000872DD0A0 0000C4 (v01 DELL   CBX3     01=
072009 AMI  00010013)
[    0.157819] ACPI: FACP 0x00000000872FE7C0 00010C (v05 DELL   CBX3     01=
072009 AMI  00010013)
[    0.166241] ACPI: DSDT 0x00000000872DD1F8 0215C8 (v02 DELL   CBX3     01=
072009 INTL 20120913)
[    0.174667] ACPI: FACS 0x0000000087ABEF80 000040
[    0.179223] ACPI: APIC 0x00000000872FE8D0 000084 (v03 DELL   CBX3     01=
072009 AMI  00010013)
[    0.187652] ACPI: FPDT 0x00000000872FE958 000044 (v01 DELL   CBX3     01=
072009 AMI  00010013)
[    0.196067] ACPI: FIDT 0x00000000872FE9A0 00009C (v01 DELL   CBX3     01=
072009 AMI  00010013)
[    0.204480] ACPI: MCFG 0x00000000872FEA40 00003C (v01 DELL   CBX3     01=
072009 MSFT 00000097)
[    0.212893] ACPI: HPET 0x00000000872FEA80 000038 (v01 DELL   CBX3     01=
072009 AMI. 0005000B)
[    0.221308] ACPI: SSDT 0x00000000872FEAB8 00036D (v01 SataRe SataTabl 00=
001000 INTL 20120913)
[    0.229722] ACPI: SSDT 0x00000000872FEE28 0053B2 (v02 SaSsdt SaSsdt   00=
003000 INTL 20120913)
[    0.238135] ACPI: UEFI 0x00000000873041E0 000042 (v01                 00=
000000      00000000)
[    0.246551] ACPI: LPIT 0x0000000087304228 000094 (v01 INTEL  SKL      00=
000000 MSFT 0000005F)
[    0.254962] ACPI: SSDT 0x00000000873042C0 000248 (v02 INTEL  sensrhub 00=
000000 INTL 20120913)
[    0.263376] ACPI: SSDT 0x0000000087304508 002BAE (v02 INTEL  PtidDevc 00=
001000 INTL 20120913)
[    0.271790] ACPI: SSDT 0x00000000873070B8 000C45 (v02 INTEL  Ther_Rvp 00=
001000 INTL 20120913)
[    0.280203] ACPI: DBGP 0x0000000087307D00 000034 (v01 INTEL           00=
000000 MSFT 0000005F)
[    0.288616] ACPI: DBG2 0x0000000087307D38 000054 (v00 INTEL           00=
000000 MSFT 0000005F)
[    0.297030] ACPI: SSDT 0x0000000087307D90 000613 (v02 INTEL  DELL__MT 00=
000000 INTL 20120913)
[    0.305442] ACPI: SSDT 0x00000000873083A8 000E58 (v02 CpuRef CpuSsdt  00=
003000 INTL 20120913)
[    0.313855] ACPI: SLIC 0x0000000087309200 000176 (v03 DELL   CBX3     01=
072009 MSFT 00010013)
[    0.322268] ACPI: DMAR 0x0000000087309378 0000A8 (v01 INTEL  SKL      00=
000001 INTL 00000001)
[    0.330680] ACPI: ASF! 0x0000000087309420 0000A5 (v32 INTEL   HCG     00=
000001 TFSM 000F4240)
[    0.339098] ACPI: Local APIC address 0xfee00000
[    0.343561] mapped APIC to ffffffffff5fc000 (        fee00000)
[    0.349448] No NUMA configuration found
[    0.353087] Faking a node at [mem 0x0000000000000000-0x0000000871ffffff]
[    0.359703] NODE_DATA(0) allocated [mem 0x871fd5000-0x871ffffff]
[    0.365823] cma: Reserved 200 MiB at 0x000000082f000000
[    0.370848] Zone ranges:
[    0.373309]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.379406]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.385502]   Normal   [mem 0x0000000100000000-0x0000000871ffffff]
[    0.391598]   Device   empty
[    0.394431] Movable zone start for each node
[    0.398642] Early memory node ranges
[    0.402167]   node   0: [mem 0x0000000000001000-0x000000000009bfff]
[    0.408358]   node   0: [mem 0x0000000000100000-0x000000007caa5fff]
[    0.414549]   node   0: [mem 0x000000007cad1000-0x000000007cb22fff]
[    0.420740]   node   0: [mem 0x000000007d324000-0x0000000086f56fff]
[    0.426931]   node   0: [mem 0x0000000087fff000-0x0000000087ffffff]
[    0.433113]   node   0: [mem 0x0000000100000000-0x0000000871ffffff]
[    0.439535] Zeroed struct page in unavailable ranges: 31033 pages
[    0.439536] Initmem setup node 0 [mem 0x0000000000001000-0x0000000871fff=
fff]
[    0.452347] On node 0 totalpages: 8357575
[    0.456294]   DMA zone: 64 pages used for memmap
[    0.460845]   DMA zone: 21 pages reserved
[    0.464795]   DMA zone: 3995 pages, LIFO batch:0
[    0.469371]   DMA32 zone: 8541 pages used for memmap
[    0.474239]   DMA32 zone: 546604 pages, LIFO batch:63
[    0.482815]   Normal zone: 121984 pages used for memmap
[    0.487811]   Normal zone: 7806976 pages, LIFO batch:63
[    0.493193] Reserving Intel graphics memory at [mem 0x8a000000-0x8bfffff=
f]
[    0.500003] ACPI: PM-Timer IO Port: 0x1808
[    0.503883] ACPI: Local APIC address 0xfee00000
[    0.508349] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.514184] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.520023] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.525859] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.531722] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.538565] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.544832] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 2, APIC =
INT 02
[    0.551957] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.558481] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 2, APIC =
INT 09
[    0.565606] ACPI: IRQ0 used by override.
[    0.569471] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 2, APIC =
INT 01
[    0.576596] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 2, APIC =
INT 03
[    0.583719] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 2, APIC =
INT 04
[    0.590847] Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 2, APIC =
INT 05
[    0.597971] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 2, APIC =
INT 06
[    0.605095] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 2, APIC =
INT 07
[    0.612221] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 2, APIC =
INT 08
[    0.619344] ACPI: IRQ9 used by override.
[    0.623208] Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 2, APIC =
INT 0a
[    0.630335] Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 2, APIC =
INT 0b
[    0.637463] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 2, APIC =
INT 0c
[    0.644601] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 2, APIC =
INT 0d
[    0.651740] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 2, APIC =
INT 0e
[    0.658878] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 2, APIC =
INT 0f
[    0.666016] Using ACPI (MADT) for SMP configuration information
[    0.671855] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.676922] TSC deadline timer available
[    0.680786] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.685682] mapped IOAPIC to ffffffffff5fb000 (fec00000)
[    0.690927] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.698389] PM: hibernation: Registered nosave memory: [mem 0x0009c000-0=
x0009cfff]
[    0.705859] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0=
x0009ffff]
[    0.713329] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000dffff]
[    0.720799] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0=
x000fffff]
[    0.728269] PM: hibernation: Registered nosave memory: [mem 0x7caa6000-0=
x7caa6fff]
[    0.735739] PM: hibernation: Registered nosave memory: [mem 0x7caa7000-0=
x7cad0fff]
[    0.743209] PM: hibernation: Registered nosave memory: [mem 0x7cb23000-0=
x7d323fff]
[    0.750677] PM: hibernation: Registered nosave memory: [mem 0x86f57000-0=
x872bcfff]
[    0.758146] PM: hibernation: Registered nosave memory: [mem 0x872bd000-0=
x87309fff]
[    0.765617] PM: hibernation: Registered nosave memory: [mem 0x8730a000-0=
x87abefff]
[    0.773085] PM: hibernation: Registered nosave memory: [mem 0x87abf000-0=
x87ffefff]
[    0.780554] PM: hibernation: Registered nosave memory: [mem 0x88000000-0=
x89ffffff]
[    0.788022] PM: hibernation: Registered nosave memory: [mem 0x8a000000-0=
x8bffffff]
[    0.795492] PM: hibernation: Registered nosave memory: [mem 0x8c000000-0=
xdfffffff]
[    0.802962] PM: hibernation: Registered nosave memory: [mem 0xe0000000-0=
xefffffff]
[    0.810432] PM: hibernation: Registered nosave memory: [mem 0xf0000000-0=
xfdffffff]
[    0.817902] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0=
xfe010fff]
[    0.825374] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0=
xfebfffff]
[    0.832843] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0=
xfec00fff]
[    0.840313] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0=
xfedfffff]
[    0.847783] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0=
xfee00fff]
[    0.855255] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0=
xfeffffff]
[    0.862724] PM: hibernation: Registered nosave memory: [mem 0xff000000-0=
xffffffff]
[    0.870195] [mem 0x8c000000-0xdfffffff] available for PCI devices
[    0.876209] Booting paravirtualized kernel on bare hardware
[    0.881714] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 1910969940391419 ns
[    0.896167] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr=
_node_ids:1
[    0.903683] percpu: Embedded 55 pages/cpu s188416 r8192 d28672 u524288
[    0.910023] pcpu-alloc: s188416 r8192 d28672 u524288 alloc=3D1*2097152
[    0.916288] pcpu-alloc: [0] 0 1 2 3=20
[    0.919825] Built 1 zonelists, mobility grouping on.  Total pages: 82269=
65
[    0.926593] Policy zone: Normal
[    0.929685] Kernel command line: ip=3D::::lkp-skl-d04::dhcp root=3D/dev/=
ram0 user=3Dlkp job=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc=
-ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea5=
9c806787813-20201226-25066-sfkgan-4.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhe=
l-8.3 branch=3Ddrm-intel/drm-intel-gt-next commit=3D8c3b1ba0e7ea9a80b0ee4b4=
445ea59c806787813 BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7e=
a9a80b0ee4b4445ea59c806787813/vmlinuz-5.10.0-rc3-01127-g8c3b1ba0e7ea max_up=
time=3D2100 RESULT_ROOT=3D/result/perf-sanity-tests/gcc-ucode=3D0xe2/lkp-sk=
l-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a8=
0b0ee4b4445ea59c806787813/5 LKP_SERVER=3Dinternal-lkp-server nokaslr selinu=
x=3D0 debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeou=
t=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1=
 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd=
=2Eminor_count=3D8 systemd.log_level=3Derr ignore_loglevel console=3Dtty0 e=
arlyprintk=3Dt
[    0.929897] sysrq: sysrq always enabled.
[    1.020059] ignoring the deprecated load_ramdisk=3D option
[    1.026451] Dentry cache hash table entries: 4194304 (order: 13, 3355443=
2 bytes, linear)
[    1.034851] Inode-cache hash table entries: 2097152 (order: 12, 16777216=
 bytes, linear)
[    1.042627] mem auto-init: stack:off, heap alloc:off, heap free:off
[    1.072392] Memory: 2267592K/33430300K available (14347K kernel code, 61=
42K rwdata, 4812K rodata, 2432K init, 5268K bss, 1517728K reserved, 204800K=
 cma-reserved)
[    1.086516] random: get_random_u64 called from cache_random_seq_create+0=
x80/0x180 with crng_init=3D0
[    1.086564] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    1.101783] Kernel/User page tables isolation: enabled
[    1.106850] ftrace: allocating 45690 entries in 179 pages
[    1.124398] ftrace: allocated 179 pages with 5 groups
[    1.129287] rcu: Hierarchical RCU implementation.
[    1.133876] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D4.
[    1.140584] 	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_ti=
meout).
[    1.147797] 	Trampoline variant of Tasks RCU enabled.
[    1.152778] 	Rude variant of Tasks RCU enabled.
[    1.157243] 	Tracing variant of Tasks RCU enabled.
[    1.161967] rcu: RCU calculated value of scheduler-enlistment delay is 1=
00 jiffies.
[    1.169521] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D4
[    1.178909] NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs: 16
[    1.187148] Console: colour VGA+ 80x25
[    1.218889] printk: console [tty0] enabled
[    1.222902] printk: console [ttyS0] enabled
[    1.222902] printk: console [ttyS0] enabled
[    1.231135] printk: bootconsole [earlyser0] disabled
[    1.231135] printk: bootconsole [earlyser0] disabled
[    1.240941] ACPI: Core revision 20200925
[    1.245163] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 79635855245 ns
[    1.254313] APIC: Switch to symmetric I/O mode setup
[    1.259361] DMAR: Host address width 39
[    1.263293] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    1.268689] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660=
462 ecap 7e3ff0505e
[    1.277114] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    1.282510] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c406604=
62 ecap f050da
[    1.290504] DMAR: RMRR base: 0x0000008715f000 end: 0x0000008717efff
[    1.296843] DMAR: RMRR base: 0x00000089800000 end: 0x0000008bffffff
[    1.303186] DMAR: [Firmware Bug]: No firmware reserved region can cover =
this RMRR [0x0000000089800000-0x000000008bffffff], contact BIOS vendor for =
fixes
[    1.316860] DMAR: [Firmware Bug]: Your BIOS is broken; bad RMRR [0x00000=
00089800000-0x000000008bffffff]
[    1.316860] BIOS vendor: Dell Inc.; Ver: 1.1.1; Product Version:=20
[    1.332361] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    1.338786] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    1.344266] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out=
 bit.
[    1.344266] DMAR-IR: Use 'intremap=3Dno_x2apic_optout' to override the B=
IOS setting.
[    1.359239] DMAR-IR: IRQ remapping was enabled on dmar0 but we are not i=
n kdump mode
[    1.367186] DMAR-IR: IRQ remapping was enabled on dmar1 but we are not i=
n kdump mode
[    1.376246] DMAR-IR: Enabled IRQ remapping in xapic mode
[    1.381617] x2apic: IRQ remapping doesn't support X2APIC mode
[    1.387450] masked ExtINT on CPU#0
[    1.394676] ENABLING IO-APIC IRQs
[    1.398064] init IO_APIC IRQs
[    1.401108]  apic 2 pin 0 not connected
[    1.405015] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.418495] IOAPIC[0]: Set routing entry (2-1 -> 0xef -> IRQ 1 Mode:0 Ac=
tive:0 Dest:1)
[    1.426464] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:30 Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.439947] IOAPIC[0]: Set routing entry (2-2 -> 0x30 -> IRQ 0 Mode:0 Ac=
tive:0 Dest:1)
[    1.447915] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.461398] IOAPIC[0]: Set routing entry (2-3 -> 0xef -> IRQ 3 Mode:0 Ac=
tive:0 Dest:1)
[    1.469368] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.482846] IOAPIC[0]: Set routing entry (2-4 -> 0xef -> IRQ 4 Mode:0 Ac=
tive:0 Dest:1)
[    1.490817] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.505098] IOAPIC[0]: Set routing entry (2-5 -> 0xef -> IRQ 5 Mode:0 Ac=
tive:0 Dest:1)
[    1.513067] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.526546] IOAPIC[0]: Set routing entry (2-6 -> 0xef -> IRQ 6 Mode:0 Ac=
tive:0 Dest:1)
[    1.534514] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.547997] IOAPIC[0]: Set routing entry (2-7 -> 0xef -> IRQ 7 Mode:0 Ac=
tive:0 Dest:1)
[    1.555966] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.569445] IOAPIC[0]: Set routing entry (2-8 -> 0xef -> IRQ 8 Mode:0 Ac=
tive:0 Dest:1)
[    1.577412] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.590897] IOAPIC[0]: Set routing entry (2-9 -> 0xef -> IRQ 9 Mode:1 Ac=
tive:0 Dest:1)
[    1.598880] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.612383] IOAPIC[0]: Set routing entry (2-10 -> 0xef -> IRQ 10 Mode:0 =
Active:0 Dest:1)
[    1.620530] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.634009] IOAPIC[0]: Set routing entry (2-11 -> 0xef -> IRQ 11 Mode:0 =
Active:0 Dest:1)
[    1.642149] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.655633] IOAPIC[0]: Set routing entry (2-12 -> 0xef -> IRQ 12 Mode:0 =
Active:0 Dest:1)
[    1.663775] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.677257] IOAPIC[0]: Set routing entry (2-13 -> 0xef -> IRQ 13 Mode:0 =
Active:0 Dest:1)
[    1.685400] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.698886] IOAPIC[0]: Set routing entry (2-14 -> 0xef -> IRQ 14 Mode:0 =
Active:0 Dest:1)
[    1.707028] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.720511] IOAPIC[0]: Set routing entry (2-15 -> 0xef -> IRQ 15 Mode:0 =
Active:0 Dest:1)
[    1.728653]  apic 2 pin 16 not connected
[    1.732645]  apic 2 pin 17 not connected
[    1.736634]  apic 2 pin 18 not connected
[    1.740625]  apic 2 pin 19 not connected
[    1.744615]  apic 2 pin 20 not connected
[    1.748605]  apic 2 pin 21 not connected
[    1.752595]  apic 2 pin 22 not connected
[    1.756585]  apic 2 pin 23 not connected
[    1.760575]  apic 2 pin 24 not connected
[    1.764564]  apic 2 pin 25 not connected
[    1.768554]  apic 2 pin 26 not connected
[    1.772544]  apic 2 pin 27 not connected
[    1.776535]  apic 2 pin 28 not connected
[    1.780526]  apic 2 pin 29 not connected
[    1.784515]  apic 2 pin 30 not connected
[    1.788506]  apic 2 pin 31 not connected
[    1.792494]  apic 2 pin 32 not connected
[    1.796485]  apic 2 pin 33 not connected
[    1.800475]  apic 2 pin 34 not connected
[    1.804466]  apic 2 pin 35 not connected
[    1.808458]  apic 2 pin 36 not connected
[    1.812450]  apic 2 pin 37 not connected
[    1.816440]  apic 2 pin 38 not connected
[    1.820431]  apic 2 pin 39 not connected
[    1.824422]  apic 2 pin 40 not connected
[    1.828419]  apic 2 pin 41 not connected
[    1.832417]  apic 2 pin 42 not connected
[    1.836411]  apic 2 pin 43 not connected
[    1.840408]  apic 2 pin 44 not connected
[    1.844403]  apic 2 pin 45 not connected
[    1.848401]  apic 2 pin 46 not connected
[    1.852400]  apic 2 pin 47 not connected
[    1.856392]  apic 2 pin 48 not connected
[    1.860383]  apic 2 pin 49 not connected
[    1.864374]  apic 2 pin 50 not connected
[    1.868365]  apic 2 pin 51 not connected
[    1.872354]  apic 2 pin 52 not connected
[    1.876343]  apic 2 pin 53 not connected
[    1.880333]  apic 2 pin 54 not connected
[    1.884324]  apic 2 pin 55 not connected
[    1.888314]  apic 2 pin 56 not connected
[    1.892306]  apic 2 pin 57 not connected
[    1.896297]  apic 2 pin 58 not connected
[    1.900287]  apic 2 pin 59 not connected
[    1.904278]  apic 2 pin 60 not connected
[    1.908268]  apic 2 pin 61 not connected
[    1.912260]  apic 2 pin 62 not connected
[    1.916250]  apic 2 pin 63 not connected
[    1.920239]  apic 2 pin 64 not connected
[    1.924228]  apic 2 pin 65 not connected
[    1.928220]  apic 2 pin 66 not connected
[    1.932209]  apic 2 pin 67 not connected
[    1.936201]  apic 2 pin 68 not connected
[    1.940190]  apic 2 pin 69 not connected
[    1.944179]  apic 2 pin 70 not connected
[    1.948169]  apic 2 pin 71 not connected
[    1.952159]  apic 2 pin 72 not connected
[    1.956150]  apic 2 pin 73 not connected
[    1.960142]  apic 2 pin 74 not connected
[    1.964133]  apic 2 pin 75 not connected
[    1.968123]  apic 2 pin 76 not connected
[    1.972113]  apic 2 pin 77 not connected
[    1.976104]  apic 2 pin 78 not connected
[    1.980095]  apic 2 pin 79 not connected
[    1.984085]  apic 2 pin 80 not connected
[    1.988075]  apic 2 pin 81 not connected
[    1.992064]  apic 2 pin 82 not connected
[    1.996054]  apic 2 pin 83 not connected
[    2.000045]  apic 2 pin 84 not connected
[    2.004035]  apic 2 pin 85 not connected
[    2.008026]  apic 2 pin 86 not connected
[    2.012017]  apic 2 pin 87 not connected
[    2.016008]  apic 2 pin 88 not connected
[    2.019999]  apic 2 pin 89 not connected
[    2.023988]  apic 2 pin 90 not connected
[    2.027978]  apic 2 pin 91 not connected
[    2.031967]  apic 2 pin 92 not connected
[    2.035956]  apic 2 pin 93 not connected
[    2.039947]  apic 2 pin 94 not connected
[    2.043937]  apic 2 pin 95 not connected
[    2.047926]  apic 2 pin 96 not connected
[    2.051916]  apic 2 pin 97 not connected
[    2.055908]  apic 2 pin 98 not connected
[    2.059899]  apic 2 pin 99 not connected
[    2.063893]  apic 2 pin 100 not connected
[    2.067977]  apic 2 pin 101 not connected
[    2.072056]  apic 2 pin 102 not connected
[    2.076141]  apic 2 pin 103 not connected
[    2.080225]  apic 2 pin 104 not connected
[    2.084305]  apic 2 pin 105 not connected
[    2.088390]  apic 2 pin 106 not connected
[    2.092470]  apic 2 pin 107 not connected
[    2.096546]  apic 2 pin 108 not connected
[    2.100622]  apic 2 pin 109 not connected
[    2.104700]  apic 2 pin 110 not connected
[    2.108777]  apic 2 pin 111 not connected
[    2.112853]  apic 2 pin 112 not connected
[    2.116929]  apic 2 pin 113 not connected
[    2.121004]  apic 2 pin 114 not connected
[    2.125082]  apic 2 pin 115 not connected
[    2.129158]  apic 2 pin 116 not connected
[    2.133236]  apic 2 pin 117 not connected
[    2.137311]  apic 2 pin 118 not connected
[    2.141387]  apic 2 pin 119 not connected
[    2.145619] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    2.155996] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x2e2036ff8d5, max_idle_ns: 440795275316 ns
[    2.166546] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 6399.96 BogoMIPS (lpj=3D3199980)
[    2.167545] pid_max: default: 32768 minimum: 301
[    2.168563] LSM: Security Framework initializing
[    2.169551] Yama: becoming mindful.
[    2.170560] AppArmor: AppArmor initialized
[    2.171586] Mount-cache hash table entries: 65536 (order: 7, 524288 byte=
s, linear)
[    2.172583] Mountpoint-cache hash table entries: 65536 (order: 7, 524288=
 bytes, linear)
Poking KASLR using RDRAND RDTSC...
[    2.176877] mce: CPU0: Thermal monitoring enabled (TM1)
[    2.177557] process: using mwait in idle threads
[    2.178546] Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
[    2.180545] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    2.181547] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    2.182547] Spectre V2 : Mitigation: Full generic retpoline
[    2.183545] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    2.184545] Spectre V2 : Enabling Restricted Speculation for firmware ca=
lls
[    2.185547] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    2.186547] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl and seccomp
[    2.187546] TAA: Mitigation: Clear CPU buffers
[    2.188546] SRBDS: Mitigation: Microcode
[    2.189545] MDS: Mitigation: Clear CPU buffers
[    2.191571] Freeing SMP alternatives memory: 40K
[    2.194021] smpboot: CPU0: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (fami=
ly: 0x6, model: 0x5e, stepping: 0x3)
[    2.194604] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR,=
 full-width counters, Broken BIOS detected, complain to your hardware vendo=
r.
[    2.195546] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR=
 189 is 100430000)
[    2.196545] Intel PMU driver.
[    2.196546] ... version:                4
[    2.198545] ... bit width:              48
[    2.199545] ... generic registers:      8
[    2.200545] ... value mask:             0000ffffffffffff
[    2.201545] ... max period:             00007fffffffffff
[    2.202545] ... fixed-purpose events:   3
[    2.203545] ... event mask:             00000007000000ff
[    2.204624] rcu: Hierarchical SRCU implementation.
[    2.205976] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    2.206580] smp: Bringing up secondary CPUs ...
[    2.207597] x86: Booting SMP configuration:
[    2.208547] .... node  #0, CPUs:      #1
[    0.957511] masked ExtINT on CPU#1
[    2.216193]  #2
[    0.957511] masked ExtINT on CPU#2
[    2.221803]  #3
[    0.957511] masked ExtINT on CPU#3
[    2.227295] smp: Brought up 1 node, 4 CPUs
[    2.227546] smpboot: Max logical packages: 1
[    2.228546] smpboot: Total of 4 processors activated (25599.84 BogoMIPS)
[    2.262668] node 0 deferred pages initialised in 33ms
[    2.268941] devtmpfs: initialized
[    2.269575] x86/mm: Memory block size: 128MB
[    2.272046] PM: Registering ACPI NVS region [mem 0x7caa6000-0x7caa6fff] =
(4096 bytes)
[    2.272547] PM: Registering ACPI NVS region [mem 0x8730a000-0x87abefff] =
(8081408 bytes)
[    2.273670] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 1911260446275000 ns
[    2.274548] futex hash table entries: 1024 (order: 4, 65536 bytes, linea=
r)
[    2.276010] pinctrl core: initialized pinctrl subsystem
[    2.276639] NET: Registered protocol family 16
[    2.277713] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic alloca=
tions
[    2.278553] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    2.279551] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    2.280550] audit: initializing netlink subsys (disabled)
[    2.281552] audit: type=3D2000 audit(1608913432.140:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    2.281605] thermal_sys: Registered thermal governor 'fair_share'
[    2.282546] thermal_sys: Registered thermal governor 'bang_bang'
[    2.283545] thermal_sys: Registered thermal governor 'step_wise'
[    2.284545] thermal_sys: Registered thermal governor 'user_space'
[    2.285550] cpuidle: using governor menu
[    2.287651] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    2.288546] ACPI: bus type PCI registered
[    2.289545] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    2.290593] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    2.291547] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    2.292555] PCI: Using configuration type 1 for base access
[    2.294888] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    2.295546] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    2.296561] cryptd: max_cpu_qlen set to 1000
[    2.297582] ACPI: Added _OSI(Module Device)
[    2.298546] ACPI: Added _OSI(Processor Device)
[    2.306547] ACPI: Added _OSI(3.0 _SCP Extensions)
[    2.311545] ACPI: Added _OSI(Processor Aggregator Device)
[    2.316547] ACPI: Added _OSI(Linux-Dell-Video)
[    2.317549] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    2.318546] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    2.346028] ACPI: 8 ACPI AML tables successfully acquired and loaded
[    2.348354] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    2.351306] ACPI: Dynamic OEM Table Load:
[    2.351549] ACPI: SSDT 0xFFFF888100CB2800 0006A2 (v02 PmRef  Cpu0Ist  00=
003000 INTL 20120913)
[    2.353458] ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
[    2.354717] ACPI: Dynamic OEM Table Load:
[    2.355548] ACPI: SSDT 0xFFFF8888714EB800 00037F (v02 PmRef  Cpu0Cst  00=
003001 INTL 20120913)
[    2.357423] ACPI: Dynamic OEM Table Load:
[    2.357547] ACPI: SSDT 0xFFFF888871CFA6C0 00008E (v02 PmRef  Cpu0Hwp  00=
003000 INTL 20120913)
[    2.359339] ACPI: Dynamic OEM Table Load:
[    2.359547] ACPI: SSDT 0xFFFF88887158FC00 000130 (v02 PmRef  HwpLvt   00=
003000 INTL 20120913)
[    2.361727] ACPI: Dynamic OEM Table Load:
[    2.362548] ACPI: SSDT 0xFFFF888100CB3800 0005AA (v02 PmRef  ApIst    00=
003000 INTL 20120913)
[    2.364580] ACPI: Dynamic OEM Table Load:
[    2.365547] ACPI: SSDT 0xFFFF88887158F400 000119 (v02 PmRef  ApHwp    00=
003000 INTL 20120913)
[    2.367406] ACPI: Dynamic OEM Table Load:
[    2.367547] ACPI: SSDT 0xFFFF88887158E800 000119 (v02 PmRef  ApCst    00=
003000 INTL 20120913)
[    2.371494] ACPI: Interpreter enabled
[    2.371576] ACPI: (supports S0 S3 S4 S5)
[    2.372545] ACPI: Using IOAPIC for interrupt routing
[    2.373573] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    2.375210] ACPI: Enabled 7 GPEs in block 00 to 7F
[    2.377310] ACPI: Power Resource [PG00] (on)
[    2.377840] ACPI: Power Resource [PG01] (on)
[    2.378819] ACPI: Power Resource [PG02] (on)
[    2.381374] ACPI: Power Resource [WRST] (off)
[    2.381787] ACPI: Power Resource [WRST] (off)
[    2.382788] ACPI: Power Resource [WRST] (off)
[    2.383785] ACPI: Power Resource [WRST] (off)
[    2.384784] ACPI: Power Resource [WRST] (off)
[    2.385789] ACPI: Power Resource [WRST] (off)
[    2.386784] ACPI: Power Resource [WRST] (off)
[    2.387791] ACPI: Power Resource [WRST] (off)
[    2.388790] ACPI: Power Resource [WRST] (off)
[    2.389784] ACPI: Power Resource [WRST] (off)
[    2.390785] ACPI: Power Resource [WRST] (off)
[    2.391784] ACPI: Power Resource [WRST] (off)
[    2.392785] ACPI: Power Resource [WRST] (off)
[    2.393784] ACPI: Power Resource [WRST] (off)
[    2.394783] ACPI: Power Resource [WRST] (off)
[    2.395783] ACPI: Power Resource [WRST] (off)
[    2.396783] ACPI: Power Resource [WRST] (off)
[    2.397784] ACPI: Power Resource [WRST] (off)
[    2.398790] ACPI: Power Resource [WRST] (off)
[    2.399787] ACPI: Power Resource [WRST] (off)
[    2.410318] ACPI: Power Resource [FN00] (off)
[    2.410592] ACPI: Power Resource [FN01] (off)
[    2.411590] ACPI: Power Resource [FN02] (off)
[    2.412589] ACPI: Power Resource [FN03] (off)
[    2.413590] ACPI: Power Resource [FN04] (off)
[    2.415345] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    2.415550] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    2.417777] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME AER PCIeCapability LTR]
[    2.418546] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    2.420044] PCI host bridge to bus 0000:00
[    2.420549] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    2.421571] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    2.422554] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    2.423546] pci_bus 0000:00: root bus resource [mem 0x8c000000-0xdffffff=
f window]
[    2.424550] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7ffff=
f window]
[    2.425546] pci_bus 0000:00: root bus resource [bus 00-fe]
[    2.426558] pci 0000:00:00.0: [8086:191f] type 00 class 0x060000
[    2.427802] pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
[    2.428581] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    2.429696] pci 0000:00:02.0: [8086:1912] type 00 class 0x030000
[    2.430552] pci 0000:00:02.0: reg 0x10: [mem 0xde000000-0xdeffffff 64bit]
[    2.431549] pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff 64bit=
 pref]
[    2.432548] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    2.433712] pci 0000:00:14.0: [8086:a12f] type 00 class 0x0c0330
[    2.434562] pci 0000:00:14.0: reg 0x10: [mem 0xdf030000-0xdf03ffff 64bit]
[    2.435605] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    2.436661] pci 0000:00:14.2: [8086:a131] type 00 class 0x118000
[    2.437561] pci 0000:00:14.2: reg 0x10: [mem 0xdf04e000-0xdf04efff 64bit]
[    2.438687] pci 0000:00:16.0: [8086:a13a] type 00 class 0x078000
[    2.439559] pci 0000:00:16.0: reg 0x10: [mem 0xdf04d000-0xdf04dfff 64bit]
[    2.440614] pci 0000:00:16.0: PME# supported from D3hot
[    2.441673] pci 0000:00:17.0: [8086:a102] type 00 class 0x010601
[    2.442555] pci 0000:00:17.0: reg 0x10: [mem 0xdf048000-0xdf049fff]
[    2.443550] pci 0000:00:17.0: reg 0x14: [mem 0xdf04c000-0xdf04c0ff]
[    2.444550] pci 0000:00:17.0: reg 0x18: [io  0xf090-0xf097]
[    2.445550] pci 0000:00:17.0: reg 0x1c: [io  0xf080-0xf083]
[    2.446550] pci 0000:00:17.0: reg 0x20: [io  0xf060-0xf07f]
[    2.447550] pci 0000:00:17.0: reg 0x24: [mem 0xdf04b000-0xdf04b7ff]
[    2.448579] pci 0000:00:17.0: PME# supported from D3hot
[    2.449664] pci 0000:00:1c.0: [8086:a110] type 01 class 0x060400
[    2.450605] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    2.451713] pci 0000:00:1f.0: [8086:a146] type 00 class 0x060100
[    2.452742] pci 0000:00:1f.2: [8086:a121] type 00 class 0x058000
[    2.453557] pci 0000:00:1f.2: reg 0x10: [mem 0xdf044000-0xdf047fff]
[    2.454695] pci 0000:00:1f.3: [8086:a170] type 00 class 0x040300
[    2.455565] pci 0000:00:1f.3: reg 0x10: [mem 0xdf040000-0xdf043fff 64bit]
[    2.456573] pci 0000:00:1f.3: reg 0x20: [mem 0xdf020000-0xdf02ffff 64bit]
[    2.457589] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    2.458708] pci 0000:00:1f.4: [8086:a123] type 00 class 0x0c0500
[    2.459600] pci 0000:00:1f.4: reg 0x10: [mem 0xdf04a000-0xdf04a0ff 64bit]
[    2.460613] pci 0000:00:1f.4: reg 0x20: [io  0xf040-0xf05f]
[    2.461730] pci 0000:00:1f.6: [8086:15b7] type 00 class 0x020000
[    2.462563] pci 0000:00:1f.6: reg 0x10: [mem 0xdf000000-0xdf01ffff]
[    2.463647] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    2.464673] pci 0000:00:01.0: PCI bridge to [bus 01]
[    2.465606] pci 0000:02:00.0: [104c:8240] type 01 class 0x060400
[    2.466679] pci 0000:02:00.0: supports D1 D2
[    2.467655] pci 0000:00:1c.0: PCI bridge to [bus 02-03]
[    2.468596] pci_bus 0000:03: extended config space not accessible
[    2.469609] pci 0000:02:00.0: PCI bridge to [bus 03]
[    2.472072] ACPI: PCI Interrupt Link [LNKA] (IRQs *7 12), disabled.
[    2.472581] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *10), disabled.
[    2.473579] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 *5), disabled.
[    2.474579] ACPI: PCI Interrupt Link [LNKD] (IRQs 6 *11), disabled.
[    2.475578] ACPI: PCI Interrupt Link [LNKE] (IRQs *7 11), disabled.
[    2.476578] ACPI: PCI Interrupt Link [LNKF] (IRQs *3 10), disabled.
[    2.477578] ACPI: PCI Interrupt Link [LNKG] (IRQs *4 5), disabled.
[    2.478578] ACPI: PCI Interrupt Link [LNKH] (IRQs 6 12) *11, disabled.
[    2.479931] iommu: Default domain type: Translated=20
[    2.480557] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    2.481544] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[    2.481547] pci 0000:00:02.0: vgaarb: bridge control possible
[    2.482545] vgaarb: loaded
[    2.483600] SCSI subsystem initialized
[    2.484556] ACPI: bus type USB registered
[    2.485554] usbcore: registered new interface driver usbfs
[    2.486549] usbcore: registered new interface driver hub
[    2.487555] usbcore: registered new device driver usb
[    2.488556] pps_core: LinuxPPS API ver. 1 registered
[    2.489545] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    2.490546] PTP clock support registered
[    2.491556] EDAC MC: Ver: 3.0.0
[    2.492641] NetLabel: Initializing
[    2.493546] NetLabel:  domain hash size =3D 128
[    2.494545] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    2.495556] NetLabel:  unlabeled traffic allowed by default
[    2.496545] PCI: Using ACPI for IRQ routing
[    2.525098] PCI: pci_cache_line_size set to 64 bytes
[    2.525585] e820: reserve RAM buffer [mem 0x0009c800-0x0009ffff]
[    2.526546] e820: reserve RAM buffer [mem 0x7caa6000-0x7fffffff]
[    2.527545] e820: reserve RAM buffer [mem 0x7cb23000-0x7fffffff]
[    2.528545] e820: reserve RAM buffer [mem 0x86f57000-0x87ffffff]
[    2.529546] e820: reserve RAM buffer [mem 0x872000000-0x873ffffff]
[    2.530662] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    2.531546] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    2.534554] clocksource: Switched to clocksource tsc-early
[    2.562347] VFS: Disk quotas dquot_6.6.0
[    2.566353] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    2.573341] AppArmor: AppArmor Filesystem Enabled
[    2.578119] pnp: PnP ACPI init
[    2.581432] system 00:00: [io  0x0a00-0x0a3f] has been reserved
[    2.587408] system 00:00: [io  0x0a40-0x0a7f] has been reserved
[    2.593382] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.600687] pnp 00:01: [dma 0 disabled]
[    2.604621] pnp 00:01: Plug and Play ACPI device, IDs PNP0501 (active)
[    2.611325] system 00:02: [io  0x0680-0x069f] has been reserved
[    2.617298] system 00:02: [io  0xffff] has been reserved
[    2.622667] system 00:02: [io  0xffff] has been reserved
[    2.628039] system 00:02: [io  0xffff] has been reserved
[    2.633408] system 00:02: [io  0x1800-0x18fe] has been reserved
[    2.639382] system 00:02: [io  0x164e-0x164f] has been reserved
[    2.645355] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.652252] system 00:03: [io  0x0800-0x087f] has been reserved
[    2.658228] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.665075] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    2.671671] system 00:05: [io  0x1854-0x1857] has been reserved
[    2.677644] system 00:05: Plug and Play ACPI device, IDs INT3f0d PNP0c02=
 (active)
[    2.685343] system 00:06: [mem 0xfed10000-0xfed17fff] has been reserved
[    2.692017] system 00:06: [mem 0xfed18000-0xfed18fff] has been reserved
[    2.698688] system 00:06: [mem 0xfed19000-0xfed19fff] has been reserved
[    2.705360] system 00:06: [mem 0xe0000000-0xefffffff] has been reserved
[    2.712034] system 00:06: [mem 0xfed20000-0xfed3ffff] has been reserved
[    2.718697] system 00:06: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    2.725702] system 00:06: [mem 0xfed45000-0xfed8ffff] has been reserved
[    2.732363] system 00:06: [mem 0xff000000-0xffffffff] has been reserved
[    2.739025] system 00:06: [mem 0xfee00000-0xfeefffff] could not be reser=
ved
[    2.746030] system 00:06: [mem 0xdffe0000-0xdfffffff] has been reserved
[    2.752691] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.759551] system 00:07: [mem 0xfd000000-0xfdabffff] has been reserved
[    2.766213] system 00:07: [mem 0xfdad0000-0xfdadffff] has been reserved
[    2.772873] system 00:07: [mem 0xfdb00000-0xfdffffff] has been reserved
[    2.779534] system 00:07: [mem 0xfe000000-0xfe01ffff] could not be reser=
ved
[    2.786537] system 00:07: [mem 0xfe036000-0xfe03bfff] has been reserved
[    2.793196] system 00:07: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    2.799857] system 00:07: [mem 0xfe410000-0xfe7fffff] has been reserved
[    2.806517] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.813571] system 00:08: [io  0xff00-0xfffe] has been reserved
[    2.819544] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.827189] system 00:09: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    2.833849] system 00:09: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    2.840509] system 00:09: [mem 0xfdac0000-0xfdacffff] has been reserved
[    2.847171] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.854635] pnp: PnP ACPI: found 10 devices
[    2.864140] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    2.873093] NET: Registered protocol family 2
[    2.877611] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6=
, 262144 bytes, linear)
[    2.886380] TCP established hash table entries: 262144 (order: 9, 209715=
2 bytes, linear)
[    2.894696] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes,=
 linear)
[    2.902230] TCP: Hash tables configured (established 262144 bind 65536)
[    2.908906] UDP hash table entries: 16384 (order: 7, 524288 bytes, linea=
r)
[    2.915868] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, =
linear)
[    2.923303] NET: Registered protocol family 1
[    2.927802] RPC: Registered named UNIX socket transport module.
[    2.933783] RPC: Registered udp transport module.
[    2.938558] RPC: Registered tcp transport module.
[    2.943330] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.949830] NET: Registered protocol family 44
[    2.954345] pci 0000:00:01.0: PCI bridge to [bus 01]
[    2.959378] pci 0000:02:00.0: PCI bridge to [bus 03]
[    2.964418] pci 0000:00:1c.0: PCI bridge to [bus 02-03]
[    2.969707] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    2.975939] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    2.982172] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    2.989090] pci_bus 0000:00: resource 7 [mem 0x8c000000-0xdfffffff windo=
w]
[    2.996009] pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff windo=
w]
[    3.003016] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    3.011498] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    3.024980] IOAPIC[0]: Set routing entry (2-18 -> 0xef -> IRQ 18 Mode:1 =
Active:1 Dest:1)
[    3.033208] pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x620 took 212=
74 usecs
[    3.040687] PCI: CLS 0 bytes, default 64
[    3.044701] Trying to unpack rootfs image as initramfs...
[   10.755007] Freeing initrd memory: 836152K
[   10.759205] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[   10.765692] software IO TLB: mapped [mem 0x0000000082f57000-0x0000000086=
f57000] (64MB)
[   10.774350] Initialise system trusted keyrings
[   10.778870] Key type blacklist registered
[   10.782975] workingset: timestamp_bits=3D36 max_order=3D23 bucket_order=
=3D0
[   10.790328] zbud: loaded
[   10.800104] NET: Registered protocol family 38
[   10.804615] Key type asymmetric registered
[   10.808780] Asymmetric key parser 'x509' registered
[   10.813723] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 247)
[   10.821196] io scheduler mq-deadline registered
[   10.825791] io scheduler kyber registered
[   10.829885] io scheduler bfq registered
[   10.833815] atomic64_test: passed for x86-64 platform with CX8 and with =
SSE
[   10.840952] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[   10.854433] IOAPIC[0]: Set routing entry (2-16 -> 0xef -> IRQ 16 Mode:1 =
Active:1 Dest:1)
[   10.862610] pcieport 0000:00:01.0: PME: Signaling with IRQ 122
[   10.868638] pcieport 0000:00:1c.0: PME: Signaling with IRQ 123
[   10.874561] pcieport 0000:00:1c.0: AER: enabled with IRQ 123
[   10.880350] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   10.887116] intel_idle: MWAIT substates: 0x142120
[   10.891885] intel_idle: v0.5.1 model 0x5E
[   10.896224] intel_idle: Local APIC timer is reliable in all C-states
[   10.902795] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input0
[   10.911224] ACPI: Sleep Button [SLPB]
[   10.914991] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input1
[   10.923402] ACPI: Power Button [PWRB]
[   10.927184] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input2
[   10.934668] ACPI: Power Button [PWRF]
[   10.939393] thermal LNXTHERM:00: registered as thermal_zone0
[   10.945110] ACPI: Thermal Zone [TZ00] (28 C)
[   10.949527] thermal LNXTHERM:01: registered as thermal_zone1
[   10.955241] ACPI: Thermal Zone [TZ01] (30 C)
[   10.959636] ERST DBG: ERST support is disabled.
[   10.964365] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   10.970755] 00:01: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[   10.978998] Non-volatile memory driver v1.3
[   10.983664] rdac: device handler registered
[   10.988046] hp_sw: device handler registered
[   10.992382] emc: device handler registered
[   10.996608] alua: device handler registered
[   11.000931] e1000: Intel(R) PRO/1000 Network Driver
[   11.005867] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   11.011681] e1000e: Intel(R) PRO/1000 Network Driver
[   11.016712] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   11.022795] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[   11.038757] IOAPIC[0]: Set routing entry (2-19 -> 0xef -> IRQ 19 Mode:1 =
Active:1 Dest:1)
[   11.046967] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) se=
t to dynamic conservative mode
[   11.286393] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered=
 PHC clock
[   11.359761] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 64:=
00:6a:30:92:35
[   11.367739] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connecti=
on
[   11.374763] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0=
FF
[   11.381695] igb: Intel(R) Gigabit Ethernet Network Driver
[   11.387151] igb: Copyright (c) 2007-2014 Intel Corporation.
[   11.392787] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
[   11.398930] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[   11.404956] i40e: Intel(R) Ethernet Connection XL710 Network Driver
[   11.411275] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
[   11.417249] usbcore: registered new interface driver r8152
[   11.422809] usbcore: registered new interface driver asix
[   11.428266] usbcore: registered new interface driver ax88179_178a
[   11.434552] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   11.441148] ehci-pci: EHCI PCI platform driver
[   11.445666] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   11.451911] ohci-pci: OHCI PCI platform driver
[   11.456424] uhci_hcd: USB Universal Host Controller Interface driver
[   11.462973] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[   11.476453] IOAPIC[0]: Set routing entry (2-18 -> 0xef -> IRQ 18 Mode:1 =
Active:1 Dest:1)
[   11.484636] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   11.490086] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[   11.498640] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
00 quirks 0x0000000001109810
[   11.507896] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[   11.514886] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.10
[   11.523201] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   11.530480] usb usb1: Product: xHCI Host Controller
[   11.535420] usb usb1: Manufacturer: Linux 5.10.0-rc3-01127-g8c3b1ba0e7ea=
 xhci-hcd
[   11.542958] usb usb1: SerialNumber: 0000:00:14.0
[   11.547851] hub 1-0:1.0: USB hub found
[   11.551729] hub 1-0:1.0: 16 ports detected
[   11.556711] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   11.562144] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[   11.569600] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[   11.575954] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.10
[   11.584280] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   11.591558] usb usb2: Product: xHCI Host Controller
[   11.596496] usb usb2: Manufacturer: Linux 5.10.0-rc3-01127-g8c3b1ba0e7ea=
 xhci-hcd
[   11.604033] usb usb2: SerialNumber: 0000:00:14.0
[   11.608927] hub 2-0:1.0: USB hub found
[   11.612778] hub 2-0:1.0: 10 ports detected
[   11.617313] usb: port power management may be unreliable
[   11.622891] i8042: PNP: No PS/2 controller found.
[   11.627739] mousedev: PS/2 mouse device common for all mice
[   11.633511] rtc_cmos 00:04: RTC can wake from S4
[   11.638839] rtc_cmos 00:04: registered as rtc0
[   11.643509] rtc_cmos 00:04: setting system clock to 2020-12-25T16:24:04 =
UTC (1608913444)
[   11.651660] rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram=
, hpet irqs
[   11.659516] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[   11.665458] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[   11.675002] i2c i2c-0: 4/4 memory slots populated (from DMI)
[   11.681232] i2c i2c-0: Successfully instantiated SPD at 0x50
[   11.687468] i2c i2c-0: Successfully instantiated SPD at 0x51
[   11.693715] i2c i2c-0: Successfully instantiated SPD at 0x52
[   11.699950] i2c i2c-0: Successfully instantiated SPD at 0x53
[   11.705717] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   11.711427] iTCO_wdt: Found a Intel PCH TCO device (Version=3D4, TCOBASE=
=3D0x0400)
[   11.719034] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[   11.725126] iTCO_vendor_support: vendor-support=3D0
[   11.729916] intel_pstate: Intel P-state driver initializing
[   11.736271] intel_pstate: HWP enabled
[   11.740240] hid: raw HID events driver (C) Jiri Kosina
[   11.745481] usbcore: registered new interface driver usbhid
[   11.751113] usbhid: USB HID core driver
[   11.755047] drop_monitor: Initializing network drop monitor service
[   11.761406] Initializing XFRM netlink socket
[   11.765807] NET: Registered protocol family 10
[   11.770514] Segment Routing with IPv6
[   11.774260] NET: Registered protocol family 17
[   11.778962] 9pnet: Installing 9P2000 support
[   11.783314] mpls_gso: MPLS GSO support
[   11.787762] microcode: sig=3D0x506e3, pf=3D0x2, revision=3D0xe2
[   11.793429] microcode: Microcode Update Driver: v2.2.
[   11.793446] IPI shorthand broadcast: enabled
[   11.803013] ... APIC ID:      00000000 (0)
[   11.804011] ... APIC VERSION: 01060015
[   11.804011] 000000000000000000000000000000000000000000000000000000000000=
0000
[   11.804011] 000000000000000000000000000000000000000000000000000000000000=
0000
[   11.804011] 000000000000000000000000000000000000000000000000000000000800=
1000
[   11.804011]=20
[   11.832284] number of MP IRQ sources: 15.
[   11.837596] tsc: Refined TSC clocksource calibration: 3192.000 MHz
[   11.837939] number of IO-APIC #2 registers: 120.
[   11.844174] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2e0=
2c4a121d, max_idle_ns: 440795236083 ns
[   11.848852] testing the IO APIC.......................
[   11.864099] IO APIC #2......
[   11.867057] .... register #00: 02000000
[   11.870964] .......    : physical APIC id: 02
[   11.875387] .......    : Delivery Type: 0
[   11.879467] .......    : LTS          : 0
[   11.883543] .... register #01: 00770020
[   11.887449] .......     : max redirection entries: 77
[   11.892561] .......     : PRQ implemented: 0
[   11.896895] .......     : IO APIC version: 20
[   11.901318] .... register #02: 00000000
[   11.905223] .......     : arbitration: 00
[   11.909302] .... IRQ redirection table:
[   11.913208] IOAPIC 0:
[   11.915574]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.923465]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.931357]  pin02, enabled , edge , high, V(02), IRR(0), S(0), remapped=
, I(0001),  Z(0)
[   11.939508]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.947400]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.955293]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.963197]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.971102]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.979008]  pin08, enabled , edge , high, V(08), IRR(0), S(0), remapped=
, I(0007),  Z(0)
[   11.987171]  pin09, enabled , level, high, V(09), IRR(0), S(0), remapped=
, I(0008),  Z(0)
[   11.995322]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.003217]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.011110]  pin0c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.019004]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.026897]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.034789]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.042683]  pin10, enabled , level, low , V(10), IRR(0), S(0), remapped=
, I(000F),  Z(0)
[   12.050833]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.058725]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.066618]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.074510]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.082403]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.090296]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.098187]  pin17, disabled, edge , high, V(00), IRR(0), S(0), remapped=
, I(0000),  Z(2)
[   12.106337]  pin18, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.114230]  pin19, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.122123]  pin1a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.130015]  pin1b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.137906]  pin1c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.145798]  pin1d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.153688]  pin1e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.164077]  pin1f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.171970]  pin20, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.179862]  pin21, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.187754]  pin22, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.195648]  pin23, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.203556]  pin24, disabled, edge , high, V(21), IRR(0), S(0), physical=
, D(00), M(2)
[   12.211463]  pin25, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.219367]  pin26, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.227267]  pin27, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(01), M(2)
[   12.235161]  pin28, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.243053]  pin29, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.250947]  pin2a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.258839]  pin2b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.266733]  pin2c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.274627]  pin2d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.282521]  pin2e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.290413]  pin2f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.298306]  pin30, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.306199]  pin31, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.314092]  pin32, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.321983]  pin33, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.329876]  pin34, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.337768]  pin35, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.345660]  pin36, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.353552]  pin37, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.361444]  pin38, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.369335]  pin39, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.377226]  pin3a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.385119]  pin3b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.393009]  pin3c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.400899]  pin3d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.408789]  pin3e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.416680]  pin3f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.424573]  pin40, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.432464]  pin41, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.440372]  pin42, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.448278]  pin43, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.456182]  pin44, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.464084]  pin45, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.471974]  pin46, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.479866]  pin47, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.487758]  pin48, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.495651]  pin49, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.503542]  pin4a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(08), M(2)
[   12.511432]  pin4b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.519323]  pin4c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.527215]  pin4d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.535107]  pin4e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.542999]  pin4f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.550888]  pin50, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.558780]  pin51, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.566672]  pin52, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(80), M(2)
[   12.574565]  pin53, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.582457]  pin54, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.590348]  pin55, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.598240]  pin56, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.606132]  pin57, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.614024]  pin58, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.621918]  pin59, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.629810]  pin5a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.637702]  pin5b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.645597]  pin5c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.653489]  pin5d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.661380]  pin5e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.669271]  pin5f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.677177]  pin60, disabled, edge , high, V(20), IRR(0), S(0), physical=
, D(08), M(2)
[   12.685081]  pin61, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.692986]  pin62, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.700891]  pin63, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.708784]  pin64, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.716679]  pin65, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.724574]  pin66, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.732466]  pin67, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.740358]  pin68, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.748252]  pin69, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.756145]  pin6a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.764038]  pin6b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.771930]  pin6c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.779822]  pin6d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.787712]  pin6e, disabled, edge , high, V(00), IRR(0), S(0), logical =
, D(00), M(2)
[   12.795603]  pin6f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.803494]  pin70, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.811386]  pin71, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.819279]  pin72, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.827169]  pin73, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.835060]  pin74, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.842953]  pin75, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.850847]  pin76, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.858738]  pin77, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.866625] IRQ to pin mappings:
[   12.872424] IRQ0 -> 0:2
[   12.874954] IRQ1 -> 0:1
[   12.877483] IRQ3 -> 0:3
[   12.880013] IRQ4 -> 0:4
[   12.882542] IRQ5 -> 0:5
[   12.885071] IRQ6 -> 0:6
[   12.887599] IRQ7 -> 0:7
[   12.890129] IRQ8 -> 0:8
[   12.892658] IRQ9 -> 0:9
[   12.895187] IRQ10 -> 0:10
[   12.897889] IRQ11 -> 0:11
[   12.900590] IRQ12 -> 0:12
[   12.903290] IRQ13 -> 0:13
[   12.905990] IRQ14 -> 0:14
[   12.908693] IRQ15 -> 0:15
[   12.911399] IRQ16 -> 0:16
[   12.914107] IRQ18 -> 0:18
[   12.916812] IRQ19 -> 0:19
[   12.919517] .................................... done.
[   12.924730] clocksource: Switched to clocksource tsc
[   12.924735] AVX2 version of gcm_enc/dec engaged.
[   12.934478] AES CTR mode by8 optimization enabled
[   12.941097] sched_clock: Marking stable (11984581635, 956511572)->(13986=
499829, -1045406622)
[   12.949934] registered taskstats version 1
[   12.954115] Loading compiled-in X.509 certificates
[   12.959849] Loaded X.509 cert 'Build time autogenerated kernel key: bf0a=
41d88f630fbef6db60a8bcbfaf331b5b9e32'
[   12.969832] zswap: loaded using pool lzo/zbud
[   12.974530] Key type ._fscrypt registered
[   12.978665] Key type .fscrypt registered
[   12.982710] Key type fscrypt-provisioning registered
[   12.990520] Key type encrypted registered
[   12.994654] AppArmor: AppArmor sha1 policy hashing enabled
[   13.000213] ima: No TPM chip found, activating TPM-bypass!
[   13.005772] ima: Allocated hash algorithm: sha1
[   13.010381] ima: No architecture policies found
[   13.014990] evm: Initialising EVM extended attributes:
[   13.020198] evm: security.selinux
[   13.023638] evm: security.apparmor
[   13.027122] evm: security.ima
[   13.030176] evm: security.capability
[   13.033831] evm: HMAC attrs: 0x1
[   17.943423] e1000e 0000:00:1f.6 eth0: NIC Link is Up 1000 Mbps Full Dupl=
ex, Flow Control: Rx/Tx
[   17.953843] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   17.965774] Sending DHCP requests ., OK
[   17.973550] IP-Config: Got DHCP answer from 192.168.3.2, my address is 1=
92.168.3.95
[   17.981292] IP-Config: Complete:
[   17.984629]      device=3Deth0, hwaddr=3D64:00:6a:30:92:35, ipaddr=3D192=
=2E168.3.95, mask=3D255.255.255.0, gw=3D192.168.3.200
[   17.994944]      host=3Dlkp-skl-d04, domain=3Dlkp.intel.com, nis-domain=
=3D(none)
[   18.001876]      bootserver=3D192.168.3.200, rootserver=3D192.168.3.200,=
 rootpath=3D
[   18.001877]      nameserver0=3D192.168.3.200
[   18.013346]=20
[   18.013377] TAP version 14
[   18.017755] 1..1
[   18.019685]     # Subtest: property-entry
[   18.019686]     1..7
[   18.024050]     ok 1 - pe_test_uints
[   18.026490]     ok 2 - pe_test_uint_arrays
[   18.030419]     ok 3 - pe_test_strings
[   18.034911]     ok 4 - pe_test_bool
[   18.038857]     ok 5 - pe_test_move_inline_u8
[   18.042568]     ok 6 - pe_test_move_inline_str
[   18.047278]     ok 7 - pe_test_reference
[   18.051813] ok 1 - property-entry
[   18.060245] Freeing unused decrypted memory: 2036K
[   18.065468] Freeing unused kernel image (initmem) memory: 2432K
[   18.076689] Write protecting the kernel read-only data: 22528k
[   18.083184] Freeing unused kernel image (text/rodata gap) memory: 2036K
[   18.090211] Freeing unused kernel image (rodata/data gap) memory: 1332K
[   18.102667] Run /init as init process
[   18.106412]   with arguments:
[   18.109465]     /init
[   18.111826]     nokaslr
[   18.114360]   with environment:
[   18.117611]     HOME=3D/
[   18.120059]     TERM=3Dlinux
[   18.122854]     user=3Dlkp
[   18.125474]     job=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-=
gcc-ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445=
ea59c806787813-20201226-25066-sfkgan-4.yaml
[   18.142107]     ARCH=3Dx86_64
[   18.144986]     kconfig=3Dx86_64-rhel-8.3
[   18.148901]     branch=3Ddrm-intel/drm-intel-gt-next
[   18.153767]     commit=3D8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813
[   18.159761]     BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/vmlinuz-5.10.0-rc3-01127-g8c3b1ba0e7ea
[   18.172337]     max_uptime=3D2100
[   18.175573]     RESULT_ROOT=3D/result/perf-sanity-tests/gcc-ucode=3D0xe2=
/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0=
e7ea9a80b0ee4b4445ea59c806787813/5
[   18.191439]     LKP_SERVER=3Dinternal-lkp-server
[   18.195960]     softlockup_panic=3D1
[   18.199444]     prompt_ramdisk=3D0
[   18.202756]     vga=3Dnormal
[   18.209377] systemd[1]: RTC configured in localtime, applying delta of 0=
 minutes to system time.


         Mou
[   18.378974] wmi_bus wmi_bus-PNP0C14:00: WQBC data block query control me=
thod not found
ssage Queue File
[   18.427963] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   18.435013] RAPL PMU: hw unit of domain package 2^-14 Joules
         Startin
[   18.442050] RAPL PMU: hw unit of domain dram 2^-14 Joules
nt Root and Kern
[   18.456254] ahci 0000:00:17.0: version 3.0
39mRPC Pipe File
[   18.478997] IOAPIC[0]: Set routing entry (2-17 -> 0xef -> IRQ 17 Mode:1 =
Active:1 Dest:1)
ess NFS configur
[   18.666287] scsi host1: ahci
 =20
[   18.670430] scsi host2: ahci
       Starting=20
[   18.674508] scsi host3: ahci
rnel Device Mana
[   18.687548] ata2: SATA max UDMA/133 abar m2048@0xdf04b000 port 0xdf04b18=
0 irq 127
[   18.755674] i915 0000:00:02.0: vgaarb: deactivate vga console
[   18.763457] Console: switching to colour dummy device 80x25
r to synchronize
[   18.781328] i915 0000:00:02.0: Direct firmware load for i915/skl_dmc_ver=
1_27.bin failed with error -2
 boot up for ifu
[   18.791792] i915 0000:00:02.0: [drm] Failed to load DMC firmware i915/sk=
l_dmc_ver1_27.bin. Disabling runtime power management.
[   18.804413] i915 0000:00:02.0: [drm] DMC firmware homepage: https://git.=
kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
[   18.818133] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on mi=
nor 0
 Journal to Pers
[   18.836178] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/LNXVIDEO:00/input/input4
[   18.850210] random: fast init done
         Startin
[   18.871517] intel_rapl_common: Found RAPL domain package
[   18.884593] intel_rapl_common: Found RAPL domain uncore
[   18.889782] intel_rapl_common: Found RAPL domain dram
[   19.019708] ata4: SATA link down (SStatus 4 SControl 300)
[   19.025078] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   19.031218] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   19.031260] ata3: SATA link down (SStatus 4 SControl 300)
[   19.050686] ata2.00: 2344225968 sectors, multi 1: LBA48 NCQ (depth 32)
m.
[   18.250605] rc.local[290]: PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sb=
in:/usr/bin:/sbin:/bin:/lkp/lkp/src/bin
LKP: HOSTNAME lkp-skl-d04, MAC 64:00:6a:30:92:35, kernel 5.10.0-rc3-01127-g=
8c3b1ba0e7ea 1, serial console /dev/ttyS0
         Startin
[   19.250920] ata1.00: ATA-9: ST1000DM003-1ER162, CC45, max UDMA/133

[   19.271750] scsi 0:0:0:0: Direct-Access     ATA      ST1000DM003-1ER1 CC=
45 PQ: 0 ANSI: 5
[   19.280244] scsi 1:0:0:0: Direct-Access     ATA      INTEL SSDSC2BB01 00=
23 PQ: 0 ANSI: 5
1;39mSystem Logg
[   19.302976] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[   19.306697] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 =
TB/932 GiB)

[   19.321745] sd 0:0:0:0: [sda] 4096-byte physical blocks
[   19.321899] sd 1:0:0:0: [sdb] 2344225968 512-byte logical blocks: (1.20 =
TB/1.09 TiB)
[   19.333464] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[   19.333750] sd 1:0:0:0: [sdb] 4096-byte physical blocks
[   19.335589] sd 0:0:0:0: [sda] Write Protect is off
[   19.335590] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   19.335598] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   19.335694] sd 1:0:0:0: Attached scsi generic sg1 type 0
[   19.376861] sd 1:0:0:0: [sdb] Write Protect is off
0m
[   19.388029] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   19.403025] ata2.00: Enabling discard_zeroes_data
[   19.408785] sd 1:0:0:0: [sdb] Attached SCSI disk
al Compatibility
[   19.421854] sd 0:0:0:0: [sda] Attached SCSI disk
[   19.448136] ipmi device interface
[   19.461579] ipmi_si: IPMI System Interface driver
[   19.466972] ipmi_si: Unable to find any System Interface(s)
See 'systemctl status openipmi.service' for details.
[   20.404571] random: crng init done
[   20.407949] random: 2 urandom warning(s) missed due to ratelimiting
[   24.066557] Kernel tests: Boot OK!
[   24.066560]=20
[   28.234253] install debs round one: dpkg -i --force-confdef --force-depe=
nds /opt/deb/ntpdate_1%3a4.2.8p12+dfsg-4_amd64.deb
[   28.234256]=20
[   28.247737] /opt/deb/libperl5.28_5.28.1-6+deb10u1_amd64.deb
[   28.247739]=20
[   28.255613] /opt/deb/perl_5.28.1-6+deb10u1_amd64.deb
[   28.255615]=20
[   28.262930] /opt/deb/perl-base_5.28.1-6+deb10u1_amd64.deb
[   28.262931]=20
[   28.270833] /opt/deb/perl-modules-5.28_5.28.1-6+deb10u1_all.deb
[   28.270834]=20
[   28.279463] /opt/deb/libpython3.7-minimal_3.7.3-2+deb10u2_amd64.deb
[   28.279465]=20
[   28.288319] /opt/deb/python3.7-minimal_3.7.3-2+deb10u2_amd64.deb
[   28.288320]=20
[   28.296617] /opt/deb/python3-minimal_3.7.3-1_amd64.deb
[   28.296618]=20
[   28.304505] /opt/deb/libpython3.7-stdlib_3.7.3-2+deb10u2_amd64.deb
[   28.304506]=20
[   28.313029] /opt/deb/python3.7_3.7.3-2+deb10u2_amd64.deb
[   28.313030]=20
[   28.320693] /opt/deb/libpython3-stdlib_3.7.3-1_amd64.deb
[   28.320694]=20
[   28.328190] /opt/deb/python3_3.7.3-1_amd64.deb
[   28.328191]=20
[   28.335088] /opt/deb/gtk-update-icon-cache_3.24.5-1_amd64.deb
[   28.335089]=20
[   28.343097] /opt/deb/libthai-data_0.1.28-2_all.deb
[   28.343099]=20
[   28.350146] /opt/deb/libdatrie1_0.2.12-2_amd64.deb
[   28.350147]=20
[   28.357376] /opt/deb/libavahi-common-data_0.7-4+b1_amd64.deb
[   28.357378]=20
[   28.365341] /opt/deb/libasound2-data_1.1.8-1_all.deb
[   28.365342]=20
[   28.372919] /opt/deb/ca-certificates-java_20190405_all.deb
[   28.372921]=20
[   28.380651] /opt/deb/libatomic1_8.3.0-6_amd64.deb
[   28.380652]=20
[   28.387559] /opt/deb/libquadmath0_8.3.0-6_amd64.deb
[   28.387560]=20
[   28.394693] /opt/deb/libgcc-8-dev_8.3.0-6_amd64.deb
[   28.394694]=20
[   28.401822] /opt/deb/lib32gcc1_1%3a8.3.0-6_amd64.deb
[   28.401823]=20
[   28.408922] /opt/deb/gcc-8_8.3.0-6_amd64.deb
[   28.408923]=20
[   28.415416] /opt/deb/gcc_4%3a8.3.0-1_amd64.deb
[   28.415417]=20
[   28.421986] /opt/deb/g++-8_8.3.0-6_amd64.deb
[   28.421987]=20
[   28.428558] /opt/deb/g++_4%3a8.3.0-1_amd64.deb
[   28.428560]=20
[   28.435459] /opt/deb/libatk1.0-data_2.30.0-2_all.deb
[   28.435461]=20
[   28.442747] /opt/deb/libatk1.0-0_2.30.0-2_amd64.deb
[   28.442748]=20
[   28.449970] /opt/deb/gir1.2-atk-1.0_2.30.0-2_amd64.deb
[   28.449971]=20
[   28.457316] /opt/deb/libdpkg-perl_1.19.7_all.deb
[   28.457317]=20
[   28.464354] /opt/deb/libglib2.0-data_2.58.3-2+deb10u2_all.deb
[   28.464355]=20
[   28.472379] /opt/deb/python3-lib2to3_3.7.3-1_all.deb
[   28.472380]=20
[   28.479631] /opt/deb/python3-distutils_3.7.3-1_all.deb
[   28.479632]=20
[   28.487076] /opt/deb/libatk1.0-dev_2.30.0-2_amd64.deb
[   28.487077]=20
[   28.494622] /opt/deb/libexpat1-dev_2.2.6-2+deb10u1_amd64.deb
[   28.494623]=20
[   28.502675] /opt/deb/libperl-dev_5.28.1-6+deb10u1_amd64.deb
[   28.502677]=20
[   28.510770] /opt/deb/libpython2.7_2.7.16-2+deb10u1_amd64.deb
[   28.510771]=20
[   28.519038] /opt/deb/libpython2.7-dev_2.7.16-2+deb10u1_amd64.deb
[   28.519039]=20
[   28.527366] /opt/deb/libpython2-dev_2.7.16-1_amd64.deb
[   28.527367]=20
[   28.534858] /opt/deb/libpython-dev_2.7.16-1_amd64.deb
[   28.534872]=20
[   28.542194] /opt/deb/patch_2.7.6-3+deb10u1_amd64.deb
[   28.542195]=20
[   28.549594] /opt/deb/python2.7-dev_2.7.16-2+deb10u1_amd64.deb
[   28.549595]=20
[   28.557658] /opt/deb/python2-dev_2.7.16-1_amd64.deb
[   28.557659]=20
[   28.564746] /opt/deb/python-dev_2.7.16-1_amd64.deb
[   28.564747]=20
[   28.571786] /opt/deb/gawk_1%3a4.2.1+dfsg-1_amd64.deb
[   28.571787]=20
[   28.579237] Selecting previously unselected package ntpdate.
[   28.579239]=20
[   28.587874] (Reading database ... 16553 files and directories currently =
installed.)
[   28.587876]=20
[   28.598601] Preparing to unpack .../ntpdate_1%3a4.2.8p12+dfsg-4_amd64.de=
b ...
[   28.598603]=20
[   28.608134] Unpacking ntpdate (1:4.2.8p12+dfsg-4) ...
[   28.608135]=20
[   28.616076] Preparing to unpack .../libperl5.28_5.28.1-6+deb10u1_amd64.d=
eb ...
[   28.616077]=20
[   28.626252] Unpacking libperl5.28:amd64 (5.28.1-6+deb10u1) over (5.28.1-=
6) ...
[   28.626254]=20
[   28.636207] Preparing to unpack .../perl_5.28.1-6+deb10u1_amd64.deb ...
[   28.636208]=20
[   28.645398] Unpacking perl (5.28.1-6+deb10u1) over (5.28.1-6) ...
[   28.645399]=20
[   28.654355] Preparing to unpack .../perl-base_5.28.1-6+deb10u1_amd64.deb=
 ...
[   28.654356]=20
[   28.664068] Unpacking perl-base (5.28.1-6+deb10u1) over (5.28.1-6) ...
[   28.664070]=20
[   28.673584] Preparing to unpack .../perl-modules-5.28_5.28.1-6+deb10u1_a=
ll.deb ...
[   28.673586]=20
[   28.684020] Unpacking perl-modules-5.28 (5.28.1-6+deb10u1) over (5.28.1-=
6) ...
[   28.684021]=20
[   28.694120] Selecting previously unselected package libpython3.7-minimal=
:amd64.
[   28.694121]=20
[   28.704460] Preparing to unpack .../libpython3.7-minimal_3.7.3-2+deb10u2=
_amd64.deb ...
[   28.704461]=20
[   28.715078] Unpacking libpython3.7-minimal:amd64 (3.7.3-2+deb10u2) ...
[   28.715079]=20
[   28.724291] Selecting previously unselected package python3.7-minimal.
[   28.724292]=20
[   28.733865] Preparing to unpack .../python3.7-minimal_3.7.3-2+deb10u2_am=
d64.deb ...
[   28.733866]=20
[   28.743973] Unpacking python3.7-minimal (3.7.3-2+deb10u2) ...
[   28.743974]=20
[   28.752384] Selecting previously unselected package python3-minimal.
[   28.752385]=20
[   28.761467] Preparing to unpack .../python3-minimal_3.7.3-1_amd64.deb ...
[   28.761468]=20
[   28.770458] Unpacking python3-minimal (3.7.3-1) ...
[   28.770459]=20
[   28.778198] Selecting previously unselected package libpython3.7-stdlib:=
amd64.
[   28.778200]=20
[   28.788441] Preparing to unpack .../libpython3.7-stdlib_3.7.3-2+deb10u2_=
amd64.deb ...
[   28.788443]=20
[   28.798917] Unpacking libpython3.7-stdlib:amd64 (3.7.3-2+deb10u2) ...
[   28.798918]=20
[   28.807853] Selecting previously unselected package python3.7.
[   28.807854]=20
[   28.816466] Preparing to unpack .../python3.7_3.7.3-2+deb10u2_amd64.deb =
=2E..
[   28.816467]=20
[   28.825681] Unpacking python3.7 (3.7.3-2+deb10u2) ...
[   28.825682]=20
[   28.833495] Selecting previously unselected package libpython3-stdlib:am=
d64.
[   28.833496]=20
[   28.843217] Preparing to unpack .../libpython3-stdlib_3.7.3-1_amd64.deb =
=2E..
[   28.843219]=20
[   28.852578] Unpacking libpython3-stdlib:amd64 (3.7.3-1) ...
[   28.852580]=20
[   28.860633] Selecting previously unselected package python3.
[   28.860635]=20
[   28.869034] Preparing to unpack .../deb/python3_3.7.3-1_amd64.deb ...
[   28.869035]=20
[   28.877555] Unpacking python3 (3.7.3-1) ...
[   28.877557]=20
[   28.884450] Selecting previously unselected package gtk-update-icon-cach=
e.
[   28.884451]=20
[   28.894143] Preparing to unpack .../gtk-update-icon-cache_3.24.5-1_amd64=
=2Edeb ...
[   28.894144]=20
[   29.464714] No diversion 'diversion of /usr/sbin/update-icon-caches to /=
usr/sbin/update-icon-caches.gtk2 by libgtk-3-bin', none removed.
[   29.464716]=20
[   30.594291] No diversion 'diversion of /usr/share/man/man8/update-icon-c=
aches.8.gz to /usr/share/man/man8/update-icon-caches.gtk2.8.gz by libgtk-3-=
bin', none removed.
[   30.594294]=20
[   30.611523] Unpacking gtk-update-icon-cache (3.24.5-1) ...
[   30.611525]=20
[   30.619892] Selecting previously unselected package libthai-data.
[   30.619907]=20
[   30.630338] Preparing to unpack .../libthai-data_0.1.28-2_all.deb ...
[   30.630339]=20
[   30.637576] SGI XFS with ACLs, security attributes, realtime, scrub, rep=
air, quota, fatal assert, debug enabled
[   30.638981] Unpacking libthai-data (0.1.28-2) ...
[   30.648203]=20
[   30.655115] XFS (sdb1): Deprecated V4 format (crc=3D0) will not be suppo=
rted after September 2030.
[   30.655724] Selecting previously unselected package libdatrie1:amd64.
[   30.663826]=20
[   30.671774] XFS (sdb1): Mounting V4 Filesystem
[   30.672927] Preparing to unpack .../libdatrie1_0.2.12-2_amd64.deb ...
[   30.676179]=20
[   30.685001] Unpacking libdatrie1:amd64 (0.2.12-2) ...
[   30.685002]=20
[   30.692952] Selecting previously unselected package libavahi-common-data=
:amd64.
[   30.692953]=20
[   30.703055] Preparing to unpack .../libavahi-common-data_0.7-4+b1_amd64.=
deb ...
[   30.703056]=20
[   30.712874] Unpacking libavahi-common-data:amd64 (0.7-4+b1) ...
[   30.712875]=20
[   30.721404] Selecting previously unselected package libasound2-data.
[   30.721405]=20
[   30.730534] Preparing to unpack .../libasound2-data_1.1.8-1_all.deb ...
[   30.730536]=20
[   30.739400] Unpacking libasound2-data (1.1.8-1) ...
[   30.739401]=20
[   30.747033] Selecting previously unselected package ca-certificates-java.
[   30.747034]=20
[   30.756715] Preparing to unpack .../ca-certificates-java_20190405_all.de=
b ...
[   30.756716]=20
[   30.763913] XFS (sdb1): Starting recovery (logdev: internal)
[   30.766237] Unpacking ca-certificates-java (20190405) ...
[   30.770892]=20
[   30.779105] Selecting previously unselected package libatomic1:amd64.
[   30.779107]=20
[   30.788257] Preparing to unpack .../libatomic1_8.3.0-6_amd64.deb ...
[   30.788258]=20
[   30.797134] Unpacking libatomic1:amd64 (8.3.0-6) ...
[   30.797135]=20
[   30.805046] Selecting previously unselected package libquadmath0:amd64.
[   30.805047]=20
[   30.814399] XFS (sdb1): Ending recovery (logdev: internal)
[   30.814630] Preparing to unpack .../libquadmath0_8.3.0-6_amd64.deb ...
[   30.819837]=20
[   30.828862] Unpacking libquadmath0:amd64 (8.3.0-6) ...
[   30.828863]=20
[   30.836267] xfs filesystem being mounted at /opt/rootfs supports timesta=
mps until 2038 (0x7fffffff)
[   30.836846] Selecting previously unselected package libgcc-8-dev:amd64.
[   30.845235]=20
[   30.854664] Preparing to unpack .../libgcc-8-dev_8.3.0-6_amd64.deb ...
[   30.854665]=20
[   30.863521] Unpacking libgcc-8-dev:amd64 (8.3.0-6) ...
[   30.863522]=20
[   30.871169] Selecting previously unselected package lib32gcc1.
[   30.871170]=20
[   30.879642] Preparing to unpack .../lib32gcc1_1%3a8.3.0-6_amd64.deb ...
[   30.879644]=20
[   30.888394] Unpacking lib32gcc1 (1:8.3.0-6) ...
[   30.888396]=20
[   30.895466] Selecting previously unselected package gcc-8.
[   30.895467]=20
[   30.903469] Preparing to unpack .../deb/gcc-8_8.3.0-6_amd64.deb ...
[   30.903470]=20
[   30.911801] Unpacking gcc-8 (8.3.0-6) ...
[   30.911802]=20
[   30.918129] Selecting previously unselected package gcc.
[   30.918130]=20
[   30.926019] Preparing to unpack .../deb/gcc_4%3a8.3.0-1_amd64.deb ...
[   30.926020]=20
[   30.934450] Unpacking gcc (4:8.3.0-1) ...
[   30.934451]=20
[   30.940835] Selecting previously unselected package g++-8.
[   30.940836]=20
[   30.948856] Preparing to unpack .../deb/g++-8_8.3.0-6_amd64.deb ...
[   30.948857]=20
[   30.957156] Unpacking g++-8 (8.3.0-6) ...
[   30.957157]=20
[   30.963469] Selecting previously unselected package g++.
[   30.963470]=20
[   30.971361] Preparing to unpack .../deb/g++_4%3a8.3.0-1_amd64.deb ...
[   30.971362]=20
[   30.979840] Unpacking g++ (4:8.3.0-1) ...
[   30.979841]=20
[   30.986392] Selecting previously unselected package libatk1.0-data.
[   30.986393]=20
[   30.995289] Preparing to unpack .../libatk1.0-data_2.30.0-2_all.deb ...
[   30.995290]=20
[   31.004131] Unpacking libatk1.0-data (2.30.0-2) ...
[   31.004132]=20
[   31.011710] Selecting previously unselected package libatk1.0-0:amd64.
[   31.011711]=20
[   31.020820] Preparing to unpack .../libatk1.0-0_2.30.0-2_amd64.deb ...
[   31.020821]=20
[   31.029639] Unpacking libatk1.0-0:amd64 (2.30.0-2) ...
[   31.029640]=20
[   31.037443] Selecting previously unselected package gir1.2-atk-1.0:amd64.
[   31.037444]=20
[   31.046876] Preparing to unpack .../gir1.2-atk-1.0_2.30.0-2_amd64.deb ...
[   31.046877]=20
[   31.056027] Unpacking gir1.2-atk-1.0:amd64 (2.30.0-2) ...
[   31.056028]=20
[   31.063953] Selecting previously unselected package libdpkg-perl.
[   31.063954]=20
[   31.072669] Preparing to unpack .../libdpkg-perl_1.19.7_all.deb ...
[   31.072670]=20
[   31.081105] Unpacking libdpkg-perl (1.19.7) ...
[   31.081106]=20
[   31.088217] Selecting previously unselected package libglib2.0-data.
[   31.088218]=20
[   31.097348] Preparing to unpack .../libglib2.0-data_2.58.3-2+deb10u2_all=
=2Edeb ...
[   31.097349]=20
[   31.107128] Unpacking libglib2.0-data (2.58.3-2+deb10u2) ...
[   31.107129]=20
[   31.115334] Selecting previously unselected package python3-lib2to3.
[   31.115335]=20
[   31.124292] Preparing to unpack .../python3-lib2to3_3.7.3-1_all.deb ...
[   31.124293]=20
[   31.133130] Unpacking python3-lib2to3 (3.7.3-1) ...
[   31.133131]=20
[   31.140701] Selecting previously unselected package python3-distutils.
[   31.140702]=20
[   31.149863] Preparing to unpack .../python3-distutils_3.7.3-1_all.deb ...
[   31.149864]=20
[   31.158942] Unpacking python3-distutils (3.7.3-1) ...
[   31.158944]=20
[   31.166693] Selecting previously unselected package libatk1.0-dev:amd64.
[   31.166694]=20
[   31.176014] Preparing to unpack .../libatk1.0-dev_2.30.0-2_amd64.deb ...
[   31.176015]=20
[   31.185031] Unpacking libatk1.0-dev:amd64 (2.30.0-2) ...
[   31.185032]=20
[   31.192967] Selecting previously unselected package libexpat1-dev:amd64.
[   31.192968]=20
[   31.202426] Preparing to unpack .../libexpat1-dev_2.2.6-2+deb10u1_amd64.=
deb ...
[   31.202427]=20
[   31.212174] Unpacking libexpat1-dev:amd64 (2.2.6-2+deb10u1) ...
[   31.212175]=20
[   31.220597] Selecting previously unselected package libperl-dev.
[   31.220598]=20
[   31.229341] Preparing to unpack .../libperl-dev_5.28.1-6+deb10u1_amd64.d=
eb ...
[   31.229342]=20
[   31.238887] Unpacking libperl-dev (5.28.1-6+deb10u1) ...
[   31.238888]=20
[   31.246819] Selecting previously unselected package libpython2.7:amd64.
[   31.246820]=20
[   31.256182] Preparing to unpack .../libpython2.7_2.7.16-2+deb10u1_amd64.=
deb ...
[   31.256183]=20
[   31.265940] Unpacking libpython2.7:amd64 (2.7.16-2+deb10u1) ...
[   31.265941]=20
[   31.274576] Selecting previously unselected package libpython2.7-dev:amd=
64.
[   31.274577]=20
[   31.284420] Preparing to unpack .../libpython2.7-dev_2.7.16-2+deb10u1_am=
d64.deb ...
[   31.284421]=20
[   31.294675] Unpacking libpython2.7-dev:amd64 (2.7.16-2+deb10u1) ...
[   31.294676]=20
[   31.303667] Selecting previously unselected package libpython2-dev:amd64.
[   31.303668]=20
[   31.313087] Preparing to unpack .../libpython2-dev_2.7.16-1_amd64.deb ...
[   31.313088]=20
[   31.322209] Unpacking libpython2-dev:amd64 (2.7.16-1) ...
[   31.322210]=20
[   31.330254] Selecting previously unselected package libpython-dev:amd64.
[   31.330255]=20
[   31.339667] Preparing to unpack .../libpython-dev_2.7.16-1_amd64.deb ...
[   31.339668]=20
[   31.348684] Unpacking libpython-dev:amd64 (2.7.16-1) ...
[   31.348685]=20
[   31.356372] Selecting previously unselected package patch.
[   31.356373]=20
[   31.364470] Preparing to unpack .../patch_2.7.6-3+deb10u1_amd64.deb ...
[   31.364471]=20
[   31.373298] Unpacking patch (2.7.6-3+deb10u1) ...
[   31.373299]=20
[   31.380562] Selecting previously unselected package python2.7-dev.
[   31.380563]=20
[   31.389532] Preparing to unpack .../python2.7-dev_2.7.16-2+deb10u1_amd64=
=2Edeb ...
[   31.389533]=20
[   31.399303] Unpacking python2.7-dev (2.7.16-2+deb10u1) ...
[   31.399304]=20
[   31.407265] Selecting previously unselected package python2-dev.
[   31.407266]=20
[   31.415854] Preparing to unpack .../python2-dev_2.7.16-1_amd64.deb ...
[   31.415855]=20
[   31.424510] Unpacking python2-dev (2.7.16-1) ...
[   31.424511]=20
[   31.431620] Selecting previously unselected package python-dev.
[   31.431621]=20
[   31.440106] Preparing to unpack .../python-dev_2.7.16-1_amd64.deb ...
[   31.440107]=20
[   31.448701] Unpacking python-dev (2.7.16-1) ...
[   31.448702]=20
[   31.455542] Selecting previously unselected package gawk.
[   31.455543]=20
[   31.463535] Preparing to unpack .../gawk_1%3a4.2.1+dfsg-1_amd64.deb ...
[   31.463536]=20
[   31.472260] Unpacking gawk (1:4.2.1+dfsg-1) ...
[   31.472261]=20
[   31.479084] Setting up ntpdate (1:4.2.8p12+dfsg-4) ...
[   31.479085]=20
[   31.486492] Setting up perl-base (5.28.1-6+deb10u1) ...
[   31.486493]=20
[   31.494206] Setting up perl-modules-5.28 (5.28.1-6+deb10u1) ...
[   31.494207]=20
[   31.502776] Setting up libpython3.7-minimal:amd64 (3.7.3-2+deb10u2) ...
[   31.502777]=20
[   31.511836] Setting up python3.7-minimal (3.7.3-2+deb10u2) ...
[   31.511837]=20
[   31.519946] Setting up python3-minimal (3.7.3-1) ...
[   31.519947]=20
[   31.527126] Setting up libthai-data (0.1.28-2) ...
[   31.527127]=20
[   31.534221] Setting up libdatrie1:amd64 (0.2.12-2) ...
[   31.534222]=20
[   31.541840] Setting up libavahi-common-data:amd64 (0.7-4+b1) ...
[   31.541841]=20
[   31.550092] Setting up libasound2-data (1.1.8-1) ...
[   31.550093]=20
[   31.557325] Setting up libatomic1:amd64 (8.3.0-6) ...
[   31.557326]=20
[   31.564706] Setting up libquadmath0:amd64 (8.3.0-6) ...
[   31.564707]=20
[   31.572185] Setting up libatk1.0-data (2.30.0-2) ...
[   31.572186]=20
[   31.579553] Setting up libglib2.0-data (2.58.3-2+deb10u2) ...
[   31.579554]=20
[   31.587780] Setting up libpython2.7:amd64 (2.7.16-2+deb10u1) ...
[   31.587781]=20
[   31.596000] Setting up patch (2.7.6-3+deb10u1) ...
[   31.596001]=20
[   31.603255] Setting up libperl5.28:amd64 (5.28.1-6+deb10u1) ...
[   31.603256]=20
[   31.611355] Setting up perl (5.28.1-6+deb10u1) ...
[   31.611356]=20
[   31.618300] Setting up libdpkg-perl (1.19.7) ...
[   31.618301]=20
[   31.625297] Setting up libperl-dev (5.28.1-6+deb10u1) ...
[   31.625298]=20
[   31.633260] Setting up libpython2.7-dev:amd64 (2.7.16-2+deb10u1) ...
[   31.633261]=20
[   31.641982] Setting up libpython2-dev:amd64 (2.7.16-1) ...
[   31.641983]=20
[   31.649821] Setting up libpython-dev:amd64 (2.7.16-1) ...
[   31.649822]=20
[   31.657589] Setting up python2.7-dev (2.7.16-2+deb10u1) ...
[   31.657590]=20
[   31.665344] Setting up python2-dev (2.7.16-1) ...
[   31.665345]=20
[   31.672280] Setting up python-dev (2.7.16-1) ...
[   31.672281]=20
[   31.679076] Setting up gawk (1:4.2.1+dfsg-1) ...
[   31.679077]=20
[   31.686305] Setting up libpython3.7-stdlib:amd64 (3.7.3-2+deb10u2) ...
[   31.686306]=20
[   31.695114] Setting up python3.7 (3.7.3-2+deb10u2) ...
[   31.695115]=20
[   31.702668] Setting up libpython3-stdlib:amd64 (3.7.3-1) ...
[   31.702669]=20
[   31.710378] Setting up python3 (3.7.3-1) ...
[   31.710379]=20
[   31.717058] running python rtupdate hooks for python3.7...
[   31.717060]=20
[   31.724926] Setting up gtk-update-icon-cache (3.24.5-1) ...
[   31.724927]=20
[   31.732858] Setting up ca-certificates-java (20190405) ...
[   31.732859]=20
[   31.740533] Adding debian:GeoTrust_Universal_CA.pem
[   31.740534]=20
[   31.747883] Adding debian:Staat_der_Nederlanden_EV_Root_CA.pem
[   31.747884]=20
[   31.755981] Adding debian:thawte_Primary_Root_CA.pem
[   31.755982]=20
[   31.763112] Adding debian:Amazon_Root_CA_2.pem
[   31.763113]=20
[   31.769996] Adding debian:OISTE_WISeKey_Global_Root_GC_CA.pem
[   31.769997]=20
[   31.778201] Adding debian:TWCA_Root_Certification_Authority.pem
[   31.778202]=20
[   31.786595] Adding debian:COMODO_RSA_Certification_Authority.pem
[   31.786596]=20
[   31.794848] Adding debian:SwissSign_Gold_CA_-_G2.pem
[   31.794849]=20
[   31.802441] Adding debian:Entrust.net_Premium_2048_Secure_Server_CA.pem
[   31.802442]=20
[   31.811415] Adding debian:DigiCert_Assured_ID_Root_G3.pem
[   31.811416]=20
[   31.819402] Adding debian:DigiCert_High_Assurance_EV_Root_CA.pem
[   31.819404]=20
[   31.827826] Adding debian:COMODO_Certification_Authority.pem
[   31.827827]=20
[   31.835660] Adding debian:SecureSign_RootCA11.pem
[   31.835661]=20
[   31.843724] Adding debian:VeriSign_Class_3_Public_Primary_Certification_=
Authority_-_G4.pem
[   31.843726]=20
[   31.854598] Adding debian:Security_Communication_RootCA2.pem
[   31.854599]=20
[   31.862565] Adding debian:QuoVadis_Root_CA_3_G3.pem
[   31.862567]=20
[   31.870826] Adding debian:Deutsche_Telekom_Root_CA_2.pem
[   31.870828]=20
[   31.874021] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   31.876932] Adding debian:SecureTrust_CA.pem
[   31.877812] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.889451]=20
[   31.893607] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.906163] Adding debian:AffirmTrust_Commercial.pem
[   31.906787] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   31.918495]=20
[   31.919111] Adding debian:Izenpe.com.pem
[   31.923782] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.935142]=20
[   31.936185] Adding debian:T-TeleSec_GlobalRoot_Class_2.pem
[   31.936632] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.940515]=20
[   31.942227] Adding debian:Verisign_Class_3_Public_Primary_Certification_=
Authority_-_G3.pem
[   31.952251] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   31.953715]=20
[   31.954589] Adding debian:Trustis_FPS_Root_CA.pem
[   31.959292] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.970874]=20
[   31.972471] Adding debian:Hellenic_Academic_and_Research_Institutions_Ro=
otCA_2011.pem
[   31.980556] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.992292]=20
[   31.993265] Adding debian:SwissSign_Silver_CA_-_G2.pem
[   31.993787] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   31.998446]=20
[   31.999240] Adding debian:QuoVadis_Root_CA.pem
[   32.010318] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.011658]=20
[   32.013052] Adding debian:TUBITAK_Kamu_SM_SSL_Kok_Sertifikasi_-_Surum_1.=
pem
[   32.019425] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.031142]=20
[   32.032187] Adding debian:thawte_Primary_Root_CA_-_G3.pem
[   32.032630] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.037715]=20
[   32.038497] Adding debian:AC_RAIZ_FNMT-RCM.pem
[   32.049619] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.050928]=20
[   32.055334] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.067978] Adding debian:thawte_Primary_Root_CA_-_G2.pem
[   32.068605] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.075423]=20
[   32.087312] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.089530] Adding debian:Comodo_AAA_Services_root.pem
[   32.094012] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.105727]=20
[   32.107232] Adding debian:Hellenic_Academic_and_Research_Institutions_Ro=
otCA_2015.pem
[   32.111623] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.123334]=20
[   32.124456] Adding debian:Entrust_Root_Certification_Authority.pem
[   32.124953] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.136538]=20
[   32.137356] Adding debian:Cybertrust_Global_Root.pem
[   32.141896] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.153626]=20
[   32.155111] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.167834] Adding debian:Security_Communication_Root_CA.pem
[   32.172053] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.183636]=20
[   32.184381] Adding debian:GlobalSign_Root_CA.pem
[   32.185119] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.192875]=20
[   32.194297] Adding debian:Starfield_Services_Root_Certificate_Authority_=
-_G2.pem
[   32.204624] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.206090]=20
[   32.207110] Adding debian:IdenTrust_Commercial_Root_CA_1.pem
[   32.212355] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.223955]=20
[   32.225250] Adding debian:GeoTrust_Primary_Certification_Authority_-_G3.=
pem
[   32.225439] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.230365]=20
[   32.231200] Adding debian:AffirmTrust_Networking.pem
[   32.242116] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.243588]=20
[   32.244532] Adding debian:T-TeleSec_GlobalRoot_Class_3.pem
[   32.255493] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.260936]=20
[   32.261688] Adding debian:Amazon_Root_CA_4.pem
[   32.272665] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.274139]=20
[   32.274788] Adding debian:Taiwan_GRCA.pem
[   32.278779] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.290439]=20
[   32.291139] Adding debian:Amazon_Root_CA_1.pem
[   32.292053] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.299248]=20
[   32.300475] Adding debian:Entrust_Root_Certification_Authority_-_G2.pem
[   32.310976] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.312447]=20
[   32.313335] Adding debian:Baltimore_CyberTrust_Root.pem
[   32.318075] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.329778]=20
[   32.330518] Adding debian:QuoVadis_Root_CA_2.pem
[   32.331425] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.338158]=20
[   32.339415] Adding debian:Entrust_Root_Certification_Authority_-_EC1.pem
[   32.349890] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.351358]=20
[   32.352630] Adding debian:SSL.com_EV_Root_Certification_Authority_ECC.pem
[   32.356293] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.368003]=20
[   32.368926] Adding debian:Certum_Trusted_Network_CA.pem
[   32.369654] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.374919]=20
[   32.386646] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.388847] Adding debian:SZAFIR_ROOT_CA2.pem
[   32.392535] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.404247]=20
[   32.405120] Adding debian:GlobalSign_Root_CA_-_R6.pem
[   32.405863] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.409700]=20
[   32.410902] Adding debian:SSL.com_Root_Certification_Authority_ECC.pem
[   32.421427] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.422901]=20
[   32.423935] Adding debian:EE_Certification_Centre_Root_CA.pem
[   32.427315] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.439027]=20
[   32.439856] Adding debian:AffirmTrust_Premium.pem
[   32.440677] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.447061]=20
[   32.458795] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.460944] Adding debian:DST_Root_CA_X3.pem
[   32.670198]=20
[   32.676857] Adding debian:GlobalSign_Root_CA_-_R2.pem
[   32.676858]=20
[   32.684265] Adding debian:Certum_Trusted_Network_CA_2.pem
[   32.684266]=20
[   32.692013] Adding debian:Atos_TrustedRoot_2011.pem
[   32.692014]=20
[   32.699579] Adding debian:Starfield_Root_Certificate_Authority_-_G2.pem
[   32.699580]=20
[   32.708824] Adding debian:Go_Daddy_Root_Certificate_Authority_-_G2.pem
[   32.708826]=20
[   32.717615] Adding debian:TrustCor_RootCert_CA-1.pem
[   32.717617]=20
[   32.725124] Adding debian:OISTE_WISeKey_Global_Root_GB_CA.pem
[   32.725125]=20
[   32.733345] Adding debian:OISTE_WISeKey_Global_Root_GA_CA.pem
[   32.733346]=20
[   32.741329] Adding debian:TrustCor_RootCert_CA-2.pem
[   32.741330]=20
[   32.748231] Adding debian:Certigna.pem
[   32.748232]=20
[   32.754220] Adding debian:TWCA_Global_Root_CA.pem
[   32.754221]=20
[   32.761149] Adding debian:Certinomis_-_Root_CA.pem
[   32.761150]=20
[   32.768118] Adding debian:TrustCor_ECA-1.pem
[   32.768119]=20
[   32.774851] Adding debian:D-TRUST_Root_Class_3_CA_2_2009.pem
[   32.774853]=20
[   32.782955] Adding debian:IdenTrust_Public_Sector_Root_CA_1.pem
[   32.782956]=20
[   32.791292] Adding debian:Chambers_of_Commerce_Root_-_2008.pem
[   32.791294]=20
[   32.799492] Adding debian:AffirmTrust_Premium_ECC.pem
[   32.799493]=20
[   32.806764] Adding debian:QuoVadis_Root_CA_2_G3.pem
[   32.806765]=20
[   32.813973] Adding debian:DigiCert_Global_Root_CA.pem
[   32.813974]=20
[   32.821222] Adding debian:QuoVadis_Root_CA_3.pem
[   32.821223]=20
[   32.828277] Adding debian:Global_Chambersign_Root_-_2008.pem
[   32.828278]=20
[   32.836277] Adding debian:Sonera_Class_2_Root_CA.pem
[   32.836278]=20
[   32.843582] Adding debian:Buypass_Class_2_Root_CA.pem
[   32.843583]=20
[   32.851160] Adding debian:ePKI_Root_Certification_Authority.pem
[   32.851161]=20
[   32.859254] Adding debian:GeoTrust_Global_CA.pem
[   32.859255]=20
[   32.866244] Adding debian:Buypass_Class_3_Root_CA.pem
[   32.866245]=20
[   32.873789] Adding debian:GlobalSign_ECC_Root_CA_-_R4.pem
[   32.873791]=20
[   32.881435] Adding debian:CA_Disig_Root_R2.pem
[   32.881437]=20
[   32.888238] Adding debian:Starfield_Class_2_CA.pem
[   32.888240]=20
[   32.895425] Adding debian:XRamp_Global_CA_Root.pem
[   32.895427]=20
[   32.902414] Adding debian:certSIGN_ROOT_CA.pem
[   32.902416]=20
[   32.909701] Adding debian:VeriSign_Universal_Root_Certification_Authorit=
y.pem
[   32.909703]=20
[   32.919220] Adding debian:GlobalSign_ECC_Root_CA_-_R5.pem
[   32.919222]=20
[   32.926818] Adding debian:Secure_Global_CA.pem
[   32.926820]=20
[   32.933483] Adding debian:Go_Daddy_Class_2_CA.pem
[   32.933485]=20
[   32.941047] Adding debian:D-TRUST_Root_Class_3_CA_2_EV_2009.pem
[   32.941049]=20
[   32.949478] Adding debian:GDCA_TrustAUTH_R5_ROOT.pem
[   32.949480]=20
[   32.957199] Adding debian:Network_Solutions_Certificate_Authority.pem
[   32.957201]=20
[   32.965945] Adding debian:DigiCert_Global_Root_G3.pem
[   32.965947]=20
[   32.973621] Adding debian:USERTrust_ECC_Certification_Authority.pem
[   32.973623]=20
[   32.982073] Adding debian:Amazon_Root_CA_3.pem
[   32.982074]=20
[   32.988980] Adding debian:DigiCert_Trusted_Root_G4.pem
[   32.988981]=20
[   32.996683] Adding debian:COMODO_ECC_Certification_Authority.pem
[   32.996684]=20
[   33.005142] Adding debian:AddTrust_External_Root.pem
[   33.005144]=20
[   33.012613] Adding debian:DigiCert_Global_Root_G2.pem
[   33.012615]=20
[   33.019833] Adding debian:ISRG_Root_X1.pem
[   33.019834]=20
[   33.026960] Adding debian:GeoTrust_Primary_Certification_Authority_-_G2.=
pem
[   33.026962]=20
[   33.036062] Adding debian:ACCVRAIZ1.pem
[   33.036064]=20
[   33.042436] Adding debian:Microsec_e-Szigno_Root_CA_2009.pem
[   33.042438]=20
[   33.050577] Adding debian:Actalis_Authentication_Root_CA.pem
[   33.050578]=20
[   33.058610] Adding debian:DigiCert_Assured_ID_Root_CA.pem
[   33.058611]=20
[   33.066333] Adding debian:TeliaSonera_Root_CA_v1.pem
[   33.066335]=20
[   33.372724] error: dpkg -i /opt/deb/python3_3.7.3-1_amd64.deb failed.
[   33.372727]=20
[   33.495996]=20
[   33.505341] Adding debian:DigiCert_Assured_ID_Root_G2.pem
[   33.505343]=20
[   33.513296] Adding debian:E-Tugra_Certification_Authority.pem
[   33.513298]=20
[   33.522293] Adding debian:VeriSign_Class_3_Public_Primary_Certification_=
Authority_-_G5.pem
[   33.522295]=20
[   33.533231] Adding debian:USERTrust_RSA_Certification_Authority.pem
[   33.533233]=20
[   33.542040] Adding debian:Staat_der_Nederlanden_Root_CA_-_G2.pem
[   33.542041]=20
[   33.550448] Adding debian:Certplus_Class_2_Primary_CA.pem
[   33.550450]=20
[   33.559161] Adding debian:Hellenic_Academic_and_Research_Institutions_EC=
C_RootCA_2015.pem
[   33.559163]=20
[   33.570231] Adding debian:SSL.com_EV_Root_Certification_Authority_RSA_R2=
=2Epem
[   33.570232]=20
[   33.579676] Adding debian:Hongkong_Post_Root_CA_1.pem
[   33.579677]=20
[   33.586841] Adding debian:CFCA_EV_ROOT.pem
[   33.586842]=20
[   33.594042] Adding debian:Autoridad_de_Certificacion_Firmaprofesional_CI=
F_A62634068.pem
[   33.594044]=20
[   33.604336] Adding debian:QuoVadis_Root_CA_1_G3.pem
[   33.604337]=20
[   33.611562] Adding debian:LuxTrust_Global_Root_2.pem
[   33.611564]=20
[   33.619204] Adding debian:SSL.com_Root_Certification_Authority_RSA.pem
[   33.619205]=20
[   33.628033] Adding debian:GeoTrust_Universal_CA_2.pem
[   33.628035]=20
[   33.635646] Adding debian:Staat_der_Nederlanden_Root_CA_-_G3.pem
[   33.635648]=20
[   33.643981] Adding debian:GlobalSign_Root_CA_-_R3.pem
[   33.643983]=20
[   33.651731] Adding debian:GeoTrust_Primary_Certification_Authority.pem
[   33.651733]=20
[   33.660239] Adding debian:EC-ACC.pem
[   33.660241]=20
[   33.665451] done.
[   33.665452]=20
[   33.669776] Setting up libgcc-8-dev:amd64 (8.3.0-6) ...
[   33.669778]=20
[   33.677242] Setting up lib32gcc1 (1:8.3.0-6) ...
[   33.677244]=20
[   33.684002] Setting up gcc-8 (8.3.0-6) ...
[   33.684003]=20
[   33.690201] Setting up gcc (4:8.3.0-1) ...
[   33.690202]=20
[   33.696467] Setting up g++-8 (8.3.0-6) ...
[   33.696469]=20
[   33.702665] Setting up g++ (4:8.3.0-1) ...
[   33.702667]=20
[   33.709991] update-alternatives: using /usr/bin/g++ to provide /usr/bin/=
c++ (c++) in auto mode
[   33.709993]=20
[   33.720930] Setting up libatk1.0-0:amd64 (2.30.0-2) ...
[   33.720932]=20
[   33.728580] Setting up gir1.2-atk-1.0:amd64 (2.30.0-2) ...
[   33.728582]=20
[   33.736368] Setting up python3-lib2to3 (3.7.3-1) ...
[   33.736370]=20
[   33.743741] Setting up python3-distutils (3.7.3-1) ...
[   33.743742]=20
[   33.751314] Setting up libatk1.0-dev:amd64 (2.30.0-2) ...
[   33.751316]=20
[   33.759317] Setting up libexpat1-dev:amd64 (2.2.6-2+deb10u1) ...
[   33.759319]=20
[   33.767727] Processing triggers for libc-bin (2.28-10) ...
[   33.767728]=20
[   33.775608] Processing triggers for mime-support (3.62) ...
[   33.775609]=20
[   33.783755] Processing triggers for ca-certificates (20190110) ...
[   33.783757]=20
[   33.792259] Updating certificates in /etc/ssl/certs...
[   33.792261]=20
[   33.799368] 0 added, 0 removed; done.
[   33.799369]=20
[   33.805602] Running hooks in /etc/ca-certificates/update.d...
[   33.805604]=20
[   33.812805]=20
[   33.812806]=20
[   33.815888] done.
[   33.815890]=20
[   33.819399] done.
[   33.819401]=20
[   33.825045] dpkg: regarding .../python3-minimal_3.7.3-1_amd64.deb contai=
ning python3-minimal, pre-dependency problem:
[   33.825047]=20
[   33.838398]  python3-minimal pre-depends on python3.7-minimal (>=3D 3.7.=
3-1~)
[   33.838400]=20
[   33.848200]   python3.7-minimal is unpacked, but has never been configur=
ed.
[   33.848202]=20
[   33.856635]=20
[   33.856636]=20
[   33.860696] dpkg: warning: ignoring pre-dependency problem!
[   33.860698]=20
[   33.869895] dpkg: regarding .../deb/python3_3.7.3-1_amd64.deb containing=
 python3, pre-dependency problem:
[   33.869897]=20
[   33.882117]  python3 pre-depends on python3-minimal (=3D 3.7.3-1)
[   33.882119]=20
[   33.890879]   python3-minimal is unpacked, but has never been configured.
[   33.890880]=20
[   33.899132]=20
[   33.899133]=20
[   33.903084] dpkg: warning: ignoring pre-dependency problem!
[   33.903086]=20
[   33.912071] dpkg: regarding .../gawk_1%3a4.2.1+dfsg-1_amd64.deb containi=
ng gawk, pre-dependency problem:
[   33.912073]=20
[   33.923810]  gawk pre-depends on libmpfr6 (>=3D 3.1.3)
[   33.923812]=20
[   33.930846]   libmpfr6 is not installed.
[   33.930848]=20
[   33.936248]=20
[   33.936249]=20
[   33.940284] dpkg: warning: ignoring pre-dependency problem!
[   33.940286]=20
[   33.949273] dpkg: regarding .../gawk_1%3a4.2.1+dfsg-1_amd64.deb containi=
ng gawk, pre-dependency problem:
[   33.949274]=20
[   33.961045]  gawk pre-depends on libsigsegv2 (>=3D 2.9)
[   33.961046]=20
[   33.968270]   libsigsegv2 is not installed.
[   33.968271]=20
[   33.973953]=20
[   33.973954]=20
[   33.978007] dpkg: warning: ignoring pre-dependency problem!
[   33.978009]=20
[   33.986728] dpkg: libperl-dev: dependency problems, but configuring anyw=
ay as you requested:
[   33.986729]=20
[   33.997811]  libperl-dev depends on libc6-dev | libc-dev; however:
[   33.997813]=20
[   34.006335]   Package libc6-dev is not installed.
[   34.006336]=20
[   34.013327]   Package libc-dev is not installed.
[   34.013329]=20
[   34.019417]=20
[   34.019418]=20
[   34.024455] dpkg: libpython2.7-dev:amd64: dependency problems, but confi=
guring anyway as you requested:
[   34.024456]=20
[   34.036296]  libpython2.7-dev:amd64 depends on libexpat1-dev.
[   34.036297]=20
[   34.043499]=20
[   34.043500]=20
[   34.048369] dpkg: python2.7-dev: dependency problems, but configuring an=
yway as you requested:
[   34.048371]=20
[   34.059347]  python2.7-dev depends on libexpat1-dev.
[   34.059349]=20
[   34.065776]=20
[   34.065777]=20
[   34.070407] dpkg: gawk: dependency problems, but configuring anyway as y=
ou requested:
[   34.070409]=20
[   34.080650]  gawk depends on libmpfr6 (>=3D 3.1.3); however:
[   34.080651]=20
[   34.088466]   Package libmpfr6 is not installed.
[   34.088467]=20
[   34.095525]  gawk depends on libsigsegv2 (>=3D 2.9); however:
[   34.095527]=20
[   34.103344]   Package libsigsegv2 is not installed.
[   34.103345]=20
[   34.109682]=20
[   34.109683]=20
[   34.114718] dpkg: libpython3.7-stdlib:amd64: dependency problems, but co=
nfiguring anyway as you requested:
[   34.114721]=20
[   34.127128]  libpython3.7-stdlib:amd64 depends on libmpdec2; however:
[   34.127129]=20
[   34.135898]   Package libmpdec2 is not installed.
[   34.135899]=20
[   34.142114]=20
[   34.142115]=20
[   34.146366] dpkg-query: package 'libglib2.0-dev-bin' is not installed
[   34.146368]=20
[   34.155954] Use dpkg --contents (=3D dpkg-deb --contents) to list archiv=
e files contents.
[   34.155956]=20
[   34.166121] Traceback (most recent call last):
[   34.166122]=20
[   34.173036]   File "/usr/bin/py3clean", line 210, in <module>
[   34.173038]=20
[   34.180439]     main()
[   34.180440]=20
[   34.185202]   File "/usr/bin/py3clean", line 196, in main
[   34.185203]=20
[   34.193220]     pfiles =3D set(dpf.from_package(options.package))
[   34.193222]=20
[   34.202136]   File "/usr/share/python3/debpython/files.py", line 53, in =
=66rom_package
[   34.202138]=20
[   34.212672]     raise Exception("cannot get content of %s" % package_nam=
e)
[   34.212674]=20
[   34.222096] Exception: cannot get content of libglib2.0-dev-bin
[   34.222098]=20
[   34.230600] error running python rtupdate hook libglib2.0-dev-bin
[   34.230601]=20
[   34.239197] dpkg: error processing package python3 (--install):
[   34.239198]=20
[   34.248611]  installed python3 package post-installation script subproce=
ss returned error exit status 4
[   34.248613]=20
[   34.261590] dpkg: gtk-update-icon-cache: dependency problems, but config=
uring anyway as you requested:
[   34.261592]=20
[   34.274036]  gtk-update-icon-cache depends on libgdk-pixbuf2.0-0 (>=3D 2=
=2E30.0); however:
[   34.274038]=20
[   34.284453]   Package libgdk-pixbuf2.0-0 is not installed.
[   34.284456]=20
[   34.292890]  gtk-update-icon-cache depends on libglib2.0-0 (>=3D 2.55.2)=
; however:
[   34.292892]=20
[   34.302575]   Package libglib2.0-0 is not installed.
[   34.302577]=20
[   34.309001]=20
[   34.309002]=20
[   34.314009] dpkg: ca-certificates-java: dependency problems, but configu=
ring anyway as you requested:
[   34.314011]=20
[   34.326503]  ca-certificates-java depends on default-jre-headless | java=
8-runtime-headless; however:
[   34.326505]=20
[   34.338099]   Package default-jre-headless is not installed.
[   34.338101]=20
[   34.346251]   Package java8-runtime-headless is not installed.
[   34.346253]=20
[   34.354951]  ca-certificates-java depends on libnss3 (>=3D 3.12.10-2~); =
however:
[   34.354953]=20
[   34.364314]   Package libnss3 is not installed.
[   34.364316]=20
[   34.370347]=20
[   34.370348]=20
[   34.375304] head: cannot open '/etc/ssl/certs/java/cacerts' for reading:=
 No such file or directory
[   34.375306]=20
[   34.386814] dpkg-query: package 'libnss3' is not installed
[   34.386816]=20
[   34.395302] Use dpkg --contents (=3D dpkg-deb --contents) to list archiv=
e files contents.
[   34.395304]=20
[   34.406575] dpkg: libgcc-8-dev:amd64: dependency problems, but configuri=
ng anyway as you requested:
[   34.406576]=20
[   34.418327]  libgcc-8-dev:amd64 depends on libgomp1 (>=3D 8.3.0-6); howe=
ver:
[   34.418329]=20
[   34.427372]   Package libgomp1 is not installed.
[   34.427374]=20
[   34.434900]  libgcc-8-dev:amd64 depends on libitm1 (>=3D 8.3.0-6); howev=
er:
[   34.434901]=20
[   34.443897]   Package libitm1 is not installed.
[   34.443899]=20
[   34.451145]  libgcc-8-dev:amd64 depends on libasan5 (>=3D 8.3.0-6); howe=
ver:
[   34.451146]=20
[   34.460230]   Package libasan5 is not installed.
[   34.460232]=20
[   34.467611]  libgcc-8-dev:amd64 depends on liblsan0 (>=3D 8.3.0-6); howe=
ver:
[   34.467612]=20
[   34.476670]   Package liblsan0 is not installed.
[   34.476672]=20
[   34.484043]  libgcc-8-dev:amd64 depends on libtsan0 (>=3D 8.3.0-6); howe=
ver:
[   34.484045]=20
[   34.493124]   Package libtsan0 is not installed.
[   34.493126]=20
[   34.500520]  libgcc-8-dev:amd64 depends on libubsan1 (>=3D 8.3.0-6); how=
ever:
[   34.500522]=20
[   34.509687]   Package libubsan1 is not installed.
[   34.509688]=20
[   34.517198]  libgcc-8-dev:amd64 depends on libmpx2 (>=3D 8.3.0-6); howev=
er:
[   34.517199]=20
[   34.526193]   Package libmpx2 is not installed.
[   34.526194]=20
[   34.532193]=20
[   34.532195]=20
[   34.536846] dpkg: lib32gcc1: dependency problems, but configuring anyway=
 as you requested:
[   34.536848]=20
[   34.547742]  lib32gcc1 depends on libc6-i386 (>=3D 2.2.4); however:
[   34.547743]=20
[   34.556129]   Package libc6-i386 is not installed.
[   34.556131]=20
[   34.562411]=20
[   34.562412]=20
[   34.567070] dpkg: gcc-8: dependency problems, but configuring anyway as =
you requested:
[   34.567072]=20
[   34.577356]  gcc-8 depends on cpp-8 (=3D 8.3.0-6); however:
[   34.577358]=20
[   34.584915]   Package cpp-8 is not installed.
[   34.584917]=20
[   34.591729]  gcc-8 depends on libcc1-0 (>=3D 8.3.0-6); however:
[   34.591730]=20
[   34.599783]   Package libcc1-0 is not installed.
[   34.599784]=20
[   34.606868]  gcc-8 depends on binutils (>=3D 2.31.1); however:
[   34.606870]=20
[   34.614784]   Package binutils is not installed.
[   34.614786]=20
[   34.621856]  gcc-8 depends on libisl19 (>=3D 0.15); however:
[   34.621858]=20
[   34.629566]   Package libisl19 is not installed.
[   34.629569]=20
[   34.636445]  gcc-8 depends on libmpc3; however:
[   34.636448]=20
[   34.643175]   Package libmpc3 is not installed.
[   34.643176]=20
[   34.650144]  gcc-8 depends on libmpfr6 (>=3D 3.1.3); however:
[   34.650145]=20
[   34.657904]   Package libmpfr6 is not installed.
[   34.657906]=20
[   34.663987]=20
[   34.663988]=20
[   34.668519] dpkg: gcc: dependency problems, but configuring anyway as yo=
u requested:
[   34.668521]=20
[   34.678700]  gcc depends on cpp (=3D 4:8.3.0-1); however:
[   34.678701]=20
[   34.686051]   Package cpp is not installed.
[   34.686053]=20
[   34.691724]=20
[   34.691726]=20
[   34.696440] dpkg: g++-8: dependency problems, but configuring anyway as =
you requested:
[   34.696442]=20
[   34.707082]  g++-8 depends on libstdc++-8-dev (=3D 8.3.0-6); however:
[   34.707084]=20
[   34.715696]   Package libstdc++-8-dev is not installed.
[   34.715697]=20
[   34.723362]  g++-8 depends on libisl19 (>=3D 0.15); however:
[   34.723363]=20
[   34.731019]   Package libisl19 is not installed.
[   34.731021]=20
[   34.737788]  g++-8 depends on libmpc3; however:
[   34.737789]=20
[   34.744507]   Package libmpc3 is not installed.
[   34.744508]=20
[   34.751445]  g++-8 depends on libmpfr6 (>=3D 3.1.3); however:
[   34.751446]=20
[   34.759239]   Package libmpfr6 is not installed.
[   34.759240]=20
[   34.765339]=20
[   34.765341]=20
[   34.769933] dpkg: g++: dependency problems, but configuring anyway as yo=
u requested:
[   34.769935]=20
[   34.780024]  g++ depends on cpp (=3D 4:8.3.0-1); however:
[   34.780026]=20
[   34.787443]   Package cpp is not installed.
[   34.787445]=20
[   34.793106]=20
[   34.793107]=20
[   34.797948] dpkg: libatk1.0-0:amd64: dependency problems, but configurin=
g anyway as you requested:
[   34.797950]=20
[   34.809757]  libatk1.0-0:amd64 depends on libglib2.0-0 (>=3D 2.55.2); ho=
wever:
[   34.809759]=20
[   34.819068]   Package libglib2.0-0 is not installed.
[   34.819069]=20
[   34.825485]=20
[   34.825486]=20
[   34.830296] dpkg: gir1.2-atk-1.0:amd64: dependency problems, but configu=
ring anyway as you requested:
[   34.830297]=20
[   34.842364]  gir1.2-atk-1.0:amd64 depends on gir1.2-glib-2.0 (>=3D 1.32.=
0); however:
[   34.842365]=20
[   34.852277]   Package gir1.2-glib-2.0 is not installed.
[   34.852278]=20
[   34.858974]=20
[   34.858975]=20
[   34.863718] dpkg: python3-lib2to3: dependency problems, but configuring =
anyway as you requested:
[   34.863719]=20
[   34.875144]  python3-lib2to3 depends on python3 (>=3D 3.7.1-1~); however:
[   34.875146]=20
[   34.884033]   Package python3 is not configured yet.
[   34.884035]=20
[   34.891610]  python3-lib2to3 depends on python3 (<< 3.8); however:
[   34.891611]=20
[   34.900062]   Package python3 is not configured yet.
[   34.900063]=20
[   34.906493]=20
[   34.906494]=20
[   34.911297] dpkg: python3-distutils: dependency problems, but configurin=
g anyway as you requested:
[   34.911299]=20
[   34.922933]  python3-distutils depends on python3 (>=3D 3.7.1-1~); howev=
er:
[   34.922934]=20
[   34.931988]   Package python3 is not configured yet.
[   34.931990]=20
[   34.939643]  python3-distutils depends on python3 (<< 3.8); however:
[   34.939645]=20
[   34.948275]   Package python3 is not configured yet.
[   34.948277]=20
[   34.954701]=20
[   34.954702]=20
[   34.959515] dpkg: libatk1.0-dev:amd64: dependency problems, but configur=
ing anyway as you requested:
[   34.959517]=20
[   34.971168]  libatk1.0-dev:amd64 depends on pkg-config; however:
[   34.971170]=20
[   34.979488]   Package pkg-config is not installed.
[   34.979490]=20
[   34.987323]  libatk1.0-dev:amd64 depends on libglib2.0-dev (>=3D 2.31.2)=
; however:
[   34.987324]=20
[   34.997116]   Package libglib2.0-dev is not installed.
[   34.997118]=20
[   35.003719]=20
[   35.003720]=20
[   35.008673] dpkg: libexpat1-dev:amd64: dependency problems, but configur=
ing anyway as you requested:
[   35.008675]=20
[   35.020610]  libexpat1-dev:amd64 depends on libc6-dev | libc-dev; howeve=
r:
[   35.020612]=20
[   35.029760]   Package libc6-dev is not installed.
[   35.029762]=20
[   35.036867]   Package libc-dev is not installed.
[   35.036869]=20
[   35.043051]=20
[   35.043052]=20
[   35.047192] dpkg-query: package 'libnss3' is not installed
[   35.047194]=20
[   35.055815] Use dpkg --contents (=3D dpkg-deb --contents) to list archiv=
e files contents.
[   35.055817]=20
[   35.066255] dpkg-query: package 'libnss3' is not installed
[   35.066257]=20
[   35.074967] Use dpkg --contents (=3D dpkg-deb --contents) to list archiv=
e files contents.
[   35.074970]=20
[   35.085345] Errors were encountered while processing:
[   35.085347]=20
[   35.092043]  python3
[   35.092044]=20
[   35.096305] handle /opt/deb/keep-deb.hw...
[   35.096306]=20
[   35.104223] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/ntpdate_1%3a4.2.8p12+dfsg-4_amd64.deb
[   35.104226]=20
[   35.118159] (Reading database ... 18840 files and directories currently =
installed.)
[   35.118161]=20
[   35.128652] Preparing to unpack .../ntpdate_1%3a4.2.8p12+dfsg-4_amd64.de=
b ...
[   35.128655]=20
[   35.138660] Unpacking ntpdate (1:4.2.8p12+dfsg-4) over (1:4.2.8p12+dfsg-=
4) ...
[   35.138661]=20
[   35.148421] Setting up ntpdate (1:4.2.8p12+dfsg-4) ...
[   35.148423]=20
[   35.156046] handle /opt/deb/keep-deb.perf-sanity-tests...
[   35.156048]=20
[   35.165472] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/libperl5.28_5.28.1-6+deb10u1_amd64.deb
[   35.165474]=20
[   35.179586] (Reading database ... 18840 files and directories currently =
installed.)
[   35.179588]=20
[   35.190129] Preparing to unpack .../libperl5.28_5.28.1-6+deb10u1_amd64.d=
eb ...
[   35.190131]=20
[   35.200602] Unpacking libperl5.28:amd64 (5.28.1-6+deb10u1) over (5.28.1-=
6+deb10u1) ...
[   35.200604]=20
[   35.211217] Setting up libperl5.28:amd64 (5.28.1-6+deb10u1) ...
[   35.211219]=20
[   35.219653] Processing triggers for libc-bin (2.28-10) ...
[   35.219654]=20
[   35.229193] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/perl_5.28.1-6+deb10u1_amd64.deb
[   35.229196]=20
[   35.242803] (Reading database ... 18840 files and directories currently =
installed.)
[   35.242805]=20
[   35.253115] Preparing to unpack .../perl_5.28.1-6+deb10u1_amd64.deb ...
[   35.253117]=20
[   35.262468] Unpacking perl (5.28.1-6+deb10u1) over (5.28.1-6+deb10u1) ...
[   35.262470]=20
[   35.271527] Setting up perl (5.28.1-6+deb10u1) ...
[   35.271528]=20
[   35.280330] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/perl-base_5.28.1-6+deb10u1_amd64.deb
[   35.280331]=20
[   35.294253] (Reading database ... 18840 files and directories currently =
installed.)
[   35.294255]=20
[   35.304785] Preparing to unpack .../perl-base_5.28.1-6+deb10u1_amd64.deb=
 ...
[   35.304787]=20
[   35.314730] Unpacking perl-base (5.28.1-6+deb10u1) over (5.28.1-6+deb10u=
1) ...
[   35.314732]=20
[   35.324361] Setting up perl-base (5.28.1-6+deb10u1) ...
[   35.324363]=20
[   35.333532] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/perl-modules-5.28_5.28.1-6+deb10u1_all.deb
[   35.333534]=20
[   35.347929] (Reading database ... 18840 files and directories currently =
installed.)
[   35.347931]=20
[   35.358457] Preparing to unpack .../perl-modules-5.28_5.28.1-6+deb10u1_a=
ll.deb ...
[   35.358459]=20
[   35.369042] Unpacking perl-modules-5.28 (5.28.1-6+deb10u1) over (5.28.1-=
6+deb10u1) ...
[   35.369044]=20
[   35.379457] Setting up perl-modules-5.28 (5.28.1-6+deb10u1) ...
[   35.379459]=20
[   35.389377] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/libpython3.7-minimal_3.7.3-2+deb10u2_amd64.deb
[   35.389380]=20
[   35.404087] (Reading database ... 18840 files and directories currently =
installed.)
[   35.404089]=20
[   35.414865] Preparing to unpack .../libpython3.7-minimal_3.7.3-2+deb10u2=
_amd64.deb ...
[   35.414867]=20
[   35.425966] Unpacking libpython3.7-minimal:amd64 (3.7.3-2+deb10u2) over =
(3.7.3-2+deb10u2) ...
[   35.425968]=20
[   35.437193] Setting up libpython3.7-minimal:amd64 (3.7.3-2+deb10u2) ...
[   35.437194]=20
[   35.447924] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/python3.7-minimal_3.7.3-2+deb10u2_amd64.deb
[   35.447926]=20
[   35.462659] (Reading database ... 18840 files and directories currently =
installed.)
[   35.462661]=20
[   35.473330] Preparing to unpack .../python3.7-minimal_3.7.3-2+deb10u2_am=
d64.deb ...
[   35.473332]=20
[   35.483955] Unpacking python3.7-minimal (3.7.3-2+deb10u2) over (3.7.3-2+=
deb10u2) ...
[   35.483957]=20
[   35.494189] Setting up python3.7-minimal (3.7.3-2+deb10u2) ...
[   35.494190]=20
[   35.503755] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/python3-minimal_3.7.3-1_amd64.deb
[   35.503757]=20
[   35.517447] (Reading database ... 18840 files and directories currently =
installed.)
[   35.517450]=20
[   35.527936] Preparing to unpack .../python3-minimal_3.7.3-1_amd64.deb ...
[   35.527938]=20
[   35.537355] Unpacking python3-minimal (3.7.3-1) over (3.7.3-1) ...
[   35.537357]=20
[   35.546027] Setting up python3-minimal (3.7.3-1) ...
[   35.546029]=20
[   35.554996] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/libpython3.7-stdlib_3.7.3-2+deb10u2_amd64.deb
[   35.554998]=20
[   35.569760] (Reading database ... 18840 files and directories currently =
installed.)
[   35.569762]=20
[   35.580481] Preparing to unpack .../libpython3.7-stdlib_3.7.3-2+deb10u2_=
amd64.deb ...
[   35.580483]=20
[   35.591550] Unpacking libpython3.7-stdlib:amd64 (3.7.3-2+deb10u2) over (=
3.7.3-2+deb10u2) ...
[   35.591552]=20
[   35.602680] Setting up libpython3.7-stdlib:amd64 (3.7.3-2+deb10u2) ...
[   35.602682]=20
[   35.613062] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/python3.7_3.7.3-2+deb10u2_amd64.deb
[   35.613064]=20
[   35.626958] (Reading database ... 18840 files and directories currently =
installed.)
[   35.626960]=20
[   35.637402] Preparing to unpack .../python3.7_3.7.3-2+deb10u2_amd64.deb =
=2E..
[   35.637404]=20
[   35.647117] Unpacking python3.7 (3.7.3-2+deb10u2) over (3.7.3-2+deb10u2)=
 ...
[   35.647119]=20
[   35.656452] Setting up python3.7 (3.7.3-2+deb10u2) ...
[   35.656453]=20
[   35.664035] Processing triggers for mime-support (3.62) ...
[   35.664036]=20
[   35.673406] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/libpython3-stdlib_3.7.3-1_amd64.deb
[   35.673408]=20
[   35.687232] (Reading database ... 18840 files and directories currently =
installed.)
[   35.687234]=20
[   35.697640] Preparing to unpack .../libpython3-stdlib_3.7.3-1_amd64.deb =
=2E..
[   35.697641]=20
[   35.707450] Unpacking libpython3-stdlib:amd64 (3.7.3-1) over (3.7.3-1) .=
=2E.
[   35.707451]=20
[   35.716892] Setting up libpython3-stdlib:amd64 (3.7.3-1) ...
[   35.716894]=20
[   35.726093] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/python3_3.7.3-1_amd64.deb
[   35.726095]=20
[   35.739198] (Reading database ... 18840 files and directories currently =
installed.)
[   35.739200]=20
[   35.749503] Preparing to unpack .../deb/python3_3.7.3-1_amd64.deb ...
[   35.749505]=20
[   35.758566] running python pre-rtupdate hooks for python3.7...
[   35.758567]=20
[   35.766929] Unpacking python3 (3.7.3-1) over (3.7.3-1) ...
[   35.766930]=20
[   35.774508] Setting up python3 (3.7.3-1) ...
[   35.774510]=20
[   35.781219] running python rtupdate hooks for python3.7...
[   35.781220]=20
[   35.789345] dpkg-query: package 'libglib2.0-dev-bin' is not installed
[   35.789347]=20
[   35.798830] Use dpkg --contents (=3D dpkg-deb --contents) to list archiv=
e files contents.
[   35.798833]=20
[   35.809051] Traceback (most recent call last):
[   35.809053]=20
[   35.815978]   File "/usr/bin/py3clean", line 210, in <module>
[   35.815979]=20
[   35.823410]     main()
[   35.823411]=20
[   35.828273]   File "/usr/bin/py3clean", line 196, in main
[   35.828274]=20
[   35.836222]     pfiles =3D set(dpf.from_package(options.package))
[   35.836224]=20
[   35.845225]   File "/usr/share/python3/debpython/files.py", line 53, in =
=66rom_package
[   35.845226]=20
[   35.855733]     raise Exception("cannot get content of %s" % package_nam=
e)
[   35.855734]=20
[   35.865151] Exception: cannot get content of libglib2.0-dev-bin
[   35.865153]=20
[   35.873784] error running python rtupdate hook libglib2.0-dev-bin
[   35.873786]=20
[   35.882454] dpkg: error processing package python3 (--install):
[   35.882456]=20
[   35.891881]  installed python3 package post-installation script subproce=
ss returned error exit status 4
[   35.891883]=20
[   35.903510] Errors were encountered while processing:
[   35.903512]=20
[   35.910195]  python3
[   35.910197]=20
[   35.914411] /lkp/lkp/src/bin/run-lkp
[   35.914413]=20
[   36.179370] RESULT_ROOT=3D/result/perf-sanity-tests/gcc-ucode=3D0xe2/lkp=
-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea=
9a80b0ee4b4445ea59c806787813/5
[   36.179372]=20
[   36.435520] Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_d=
rm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
[   36.435522]=20
[   36.452245] Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.=
S' differs from latest version at 'arch/x86/lib/memcpy_64.S'
[   36.452247]=20
[   36.468457] Warning: Kernel ABI header at 'tools/arch/x86/lib/memset_64.=
S' differs from latest version at 'arch/x86/lib/memset_64.S'
[   36.468460]=20
[   36.519676] job=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-=
ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59=
c806787813-20201226-25066-sfkgan-4.yaml
[   36.519679]=20
[   40.350636]   PERF_VERSION =3D 5.10.0-rc3
[   40.350639]=20
[   40.360168] result_service: raw_upload, RESULT_MNT: /internal-lkp-server=
/result, RESULT_ROOT: /internal-lkp-server/result/perf-sanity-tests/gcc-uco=
de=3D0xe2/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9=
/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/5, TMP_RESULT_ROOT: /tmp/lkp/resu=
lt
[   40.360171]=20
[   40.392382] run-job /lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gc=
c-ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea=
59c806787813-20201226-25066-sfkgan-4.yaml
[   40.392385]=20
[   41.611992] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=3D=
0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c8067878=
13-20201226-25066-sfkgan-4.yaml&job_state=3Drunning -O /dev/null
[   41.611996]=20
[   41.644528] target ucode: 0xe2
[   41.644530]=20
[   41.649924] current_version: e2, target_version: e2
[   41.649926]=20
[   41.660932] 2020-12-25 16:24:25 make ARCH=3D EXTRA_CFLAGS=3D-fno-omit-fr=
ame-pointer -fsanitize=3Dundefined -fsanitize=3Daddress -C /usr/src/perf_se=
lftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf
[   41.660934]=20
[   41.683892] make: Entering directory '/usr/src/perf_selftests-x86_64-rhe=
l-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf'
[   41.683894]=20
[   41.698151]=20
[   41.705851]   HOSTCC   fixdep.o
[   41.705852]=20
[   41.710930]   HOSTLD   fixdep-in.o
[   41.710932]=20
[   41.716176]   LINK     fixdep
[   41.716178]=20
[   41.722095] diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i=
915_drm.h
[   41.722097]=20
[   41.732334] diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_6=
4.S
[   41.732336]=20
[   41.742050] diff -u tools/arch/x86/lib/memset_64.S arch/x86/lib/memset_6=
4.S
[   41.742051]=20
[   41.750609]=20
[   41.750611]=20
[   41.754328] Auto-detecting system features:
[   41.754329]=20
[   41.761182]=20
[   41.769690]=20
[   41.778208]=20
[   41.786893]=20
[   41.795429]=20
[   41.803979]=20
[   41.812619]=20
[   41.821159]=20
[   41.829636]=20
[   41.838123]=20
[   41.846659]=20
[   41.855116]=20
[   41.863563]=20
[   41.872017]=20
[   41.880470]=20
[   41.888932]=20
[   41.897438]=20
[   41.905966]=20
[   41.914454]=20
[   41.922950]=20
[   41.931442]=20
[   41.938855]=20
[   41.938856]=20
[   41.942405]   CC       fd/array.o
[   41.942406]=20
[   41.947824]   CC       exec-cmd.o
[   41.947826]=20
[   41.953263]   CC       event-parse.o
[   41.953265]=20
[   41.958811]   CC       core.o
[   41.958813]=20
[   41.963933]   LD       fd/libapi-in.o
[   41.963935]=20
[   41.969600]   CC       fs/fs.o
[   41.969602]=20
[   41.974676]   CC       cpumap.o
[   41.974678]=20
[   41.979796]   CC       help.o
[   41.979798]=20
[   41.984990]   CC       fs/tracing_path.o
[   41.984992]=20
[   41.990989]   CC       fs/cgroup.o
[   41.990991]=20
[   41.996521]   LD       fs/libapi-in.o
[   41.996523]=20
[   42.002134]   CC       cpu.o
[   42.002136]=20
[   42.007025]   CC       pager.o
[   42.007027]=20
[   42.012081]   CC       debug.o
[   42.012083]=20
[   42.017218]   CC       threadmap.o
[   42.017220]=20
[   42.022773]   CC       str_error_r.o
[   42.022775]=20
[   42.028425]   LD       libapi-in.o
[   42.028427]=20
[   42.033864]   AR       libapi.a
[   42.033866]=20
[   42.039022]   CC       evsel.o
[   42.039024]=20
[   42.044251]   CC       parse-options.o
[   42.044253]=20
[   42.050020]   CC       evlist.o
[   42.050022]=20
[   42.055125]   CC       mmap.o
[   42.055127]=20
[   42.060233]   CC       event-plugin.o
[   42.060236]=20
[   42.065978]   CC       trace-seq.o
[   42.065981]=20
[   42.071507]   CC       parse-filter.o
[   42.071509]=20
[   42.077037]   CC       zalloc.o
[   42.077039]=20
[   42.082078]   CC       xyarray.o
[   42.082079]=20
[   42.087148]   CC       lib.o
[   42.087149]=20
[   42.092034]   CC       run-command.o
[   42.092036]=20
[   42.097578]   LD       libperf-in.o
[   42.097580]=20
[   42.102974]   AR       libperf.a
[   42.102976]=20
[   42.108186]   CC       parse-utils.o
[   42.108188]=20
[   42.113823]   GEN      bpf_helper_defs.h
[   42.113824]=20
[   42.119767]   CC       kbuffer-parse.o
[   42.119768]=20
[   42.125451]   MKDIR    staticobjs/
[   42.125453]=20
[   42.130967]   CC       staticobjs/libbpf.o
[   42.130968]=20
[   42.136981]   CC       sigchain.o
[   42.136982]=20
[   42.142317]   CC       subcmd-config.o
[   42.142319]=20
[   42.147998]   MKDIR    staticobjs/
[   42.148000]=20
[   42.153436]   CC       staticobjs/bpf.o
[   42.153438]=20
[   42.159264]   CC       tep_strerror.o
[   42.159266]=20
[   42.164937]   LD       libsubcmd-in.o
[   42.164939]=20
[   42.170671]   CC       event-parse-api.o
[   42.170673]=20
[   42.176516]   AR       libsubcmd.a
[   42.176517]=20
[   42.182002]   LD       libtraceevent-in.o
[   42.182004]=20
[   42.188029]   LINK     libtraceevent.a
[   42.188030]=20
[   42.193886]   CC       staticobjs/nlattr.o
[   42.193887]=20
[   42.200021]   CC       staticobjs/btf.o
[   42.200023]=20
[   42.206069]   CC       staticobjs/libbpf_errno.o
[   42.206070]=20
[   42.212842]   CC       staticobjs/str_error.o
[   42.212844]=20
[   42.219160]   GEN      common-cmds.h
[   42.219161]=20
[   42.224853]   CC       staticobjs/netlink.o
[   42.224854]=20
[   42.231300]   CC       staticobjs/bpf_prog_linfo.o
[   42.231301]=20
[   42.238327]   CC       staticobjs/libbpf_probes.o
[   42.238329]=20
[   42.245076]   CC       staticobjs/xsk.o
[   42.245078]=20
[   42.251040]   CC       staticobjs/hashmap.o
[   42.251042]=20
[   42.257357]   CC       staticobjs/btf_dump.o
[   42.257358]=20
[   42.263732]   CC       staticobjs/ringbuf.o
[   42.263734]=20
[   42.269965]   HOSTCC   pmu-events/json.o
[   42.269966]=20
[   42.275933]   HOSTCC   pmu-events/jsmn.o
[   42.275934]=20
[   42.281827]   CC       plugin_jbd2.o
[   42.281829]=20
[   42.287509]   HOSTCC   pmu-events/jevents.o
[   42.287511]=20
[   42.293723]   LD       plugin_jbd2-in.o
[   42.293724]=20
[   42.299592]   CC       plugin_hrtimer.o
[   42.299594]=20
[   42.305512]   LD       plugin_hrtimer-in.o
[   42.305514]=20
[   42.311590]   CC       plugin_kmem.o
[   42.311591]=20
[   42.317338]   HOSTLD   pmu-events/jevents-in.o
[   42.317340]=20
[   42.323814]   CC       jvmti/libjvmti.o
[   42.323815]=20
[   42.329691]   LD       plugin_kmem-in.o
[   42.329692]=20
[   42.335464]   CC       plugin_kvm.o
[   42.335466]=20
[   42.340966]   LD       plugin_kvm-in.o
[   42.340968]=20
[   42.346774]   CC       plugin_mac80211.o
[   42.346776]=20
[   42.352845]   LD       staticobjs/libbpf-in.o
[   42.352847]=20
[   42.359054]   LINK     libbpf.a
[   42.359055]=20
[   42.364143]   GEN      perf-archive
[   42.364144]=20
[   42.369647]   GEN      perf-with-kcore
[   42.369649]=20
[   42.375463]   LINK     pmu-events/jevents
[   42.375465]=20
[   42.381594]   LD       plugin_mac80211-in.o
[   42.381595]=20
[   42.387904]   CC       plugin_sched_switch.o
[   42.387905]=20
[   42.394217]   CC       plugin_function.o
[   42.394218]=20
[   42.400334]   LD       plugin_sched_switch-in.o
[   42.400336]=20
[   42.407035]   GEN      pmu-events/pmu-events.c
[   42.407036]=20
[   42.413591]   LD       plugin_function-in.o
[   42.413592]=20
[   42.419766]   CC       plugin_futex.o
[   42.419768]=20
[   42.425470]   LD       plugin_futex-in.o
[   42.425472]=20
[   42.431339]   CC       plugin_xen.o
[   42.431341]=20
[   42.436841]   LD       plugin_xen-in.o
[   42.436842]=20
[   42.442575]   CC       plugin_scsi.o
[   42.442576]=20
[   42.448329]   CC       pmu-events/pmu-events.o
[   42.448331]=20
[   42.454864]   CC       jvmti/jvmti_agent.o
[   42.454865]=20
[   42.460995]   LD       plugin_scsi-in.o
[   42.460997]=20
[   42.466887]   CC       plugin_cfg80211.o
[   42.466889]=20
[   42.472927]   LD       plugin_cfg80211-in.o
[   42.472929]=20
[   42.479056]   CC       plugin_tlb.o
[   42.479058]=20
[   42.484574]   LD       plugin_tlb-in.o
[   42.484576]=20
[   42.490319]   LINK     plugin_jbd2.so
[   42.490321]=20
[   42.496039]   LINK     plugin_hrtimer.so
[   42.496041]=20
[   42.501950]   LINK     plugin_kmem.so
[   42.501952]=20
[   42.507595]   LINK     plugin_kvm.so
[   42.507597]=20
[   42.513227]   CC       jvmti/libstring.o
[   42.513229]=20
[   42.519204]   LINK     plugin_mac80211.so
[   42.519205]=20
[   42.525227]   CC       jvmti/libctype.o
[   42.525229]=20
[   42.531217]   LINK     plugin_sched_switch.so
[   42.531219]=20
[   42.537645]   LINK     plugin_function.so
[   42.537647]=20
[   42.543672]   LINK     plugin_futex.so
[   42.543673]=20
[   42.549390]   LINK     plugin_xen.so
[   42.549392]=20
[   42.554969]   LINK     plugin_scsi.so
[   42.554971]=20
[   42.560719]   LINK     plugin_cfg80211.so
[   42.560721]=20
[   42.566703]   LINK     plugin_tlb.so
[   42.566705]=20
[   42.572527]   GEN      libtraceevent-dynamic-list
[   42.572529]=20
[   42.579230]   CC       builtin-bench.o
[   42.579231]=20
[   42.585022]   LD       jvmti/jvmti-in.o
[   42.585023]=20
[   42.590887]   LINK     libperf-jvmti.so
[   42.590889]=20
[   42.596795]   CC       builtin-annotate.o
[   42.596796]=20
[   42.602794]   GEN      python/perf.so
[   42.602795]=20
[   42.608703]   LD       pmu-events/pmu-events-in.o
[   42.608705]=20
[   42.615422]   CC       builtin-config.o
[   42.615423]=20
[   42.621241]   CC       builtin-diff.o
[   42.621243]=20
[   42.626929]   CC       builtin-evlist.o
[   42.626930]=20
[   42.632782]   CC       builtin-ftrace.o
[   42.632784]=20
[   42.908623]   CC       builtin-help.o
[   42.908626]=20
[   43.278131]   CC       builtin-sched.o
[   43.278134]=20
[   43.479903]   CC       builtin-buildid-list.o
[   43.479906]=20
[   43.637961]   CC       builtin-buildid-cache.o
[   43.637964]=20
[   44.178879]   CC       builtin-kallsyms.o
[   44.178882]=20
[   44.296438]   CC       builtin-list.o
[   44.296441]=20
[   44.541360]   CC       builtin-record.o
[   44.541363]=20
[   44.681860]   CC       builtin-report.o
[   44.681863]=20
[   46.229454]   CC       builtin-stat.o
[   46.229458]=20
[   47.575999]   CC       builtin-timechart.o
[   47.576001]=20
[   47.775263]   CC       builtin-top.o
[   47.775266]=20
[   49.082379]   CC       builtin-script.o
[   49.082382]=20
[   50.194480]   CC       builtin-kmem.o
[   50.194483]=20
[   50.734297]   CC       builtin-lock.o
[   50.734300]=20
[   51.831119]   CC       builtin-kvm.o
[   51.831123]=20
[   51.987510]   CC       builtin-inject.o
[   51.987513]=20
[   52.427698]   CC       builtin-mem.o
[   52.427701]=20
[   52.905983]   CC       builtin-data.o
[   52.905987]=20
[   52.996708]   CC       builtin-version.o
[   52.996711]=20
[   53.075336]   CC       builtin-c2c.o
[   53.075339]=20
[   53.093168]   CC       builtin-trace.o
[   53.093171]=20
[   53.532551]   CC       builtin-probe.o
[   53.532555]=20
[   54.232259]   CC       bench/sched-messaging.o
[   54.232263]=20
[   54.540743]   CC       bench/sched-pipe.o
[   54.540746]=20
[   54.682993]   CC       bench/syscall.o
[   54.682996]=20
[   54.769056]   CC       bench/mem-functions.o
[   54.769059]=20
[   54.854904]   CC       tests/builtin-test.o
[   54.854907]=20
[   55.022920]   CC       bench/futex-hash.o
[   55.022923]=20
[   55.228906]   CC       bench/futex-wake.o
[   55.228910]=20
[   55.342497]   CC       tests/parse-events.o
[   55.342500]=20
[   55.396411]   CC       bench/futex-wake-parallel.o
[   55.396414]=20
[   55.637476]   CC       bench/futex-requeue.o
[   55.637479]=20
[   55.821312]   CC       bench/futex-lock-pi.o
[   55.821315]=20
[   56.045377]   CC       bench/epoll-wait.o
[   56.045381]=20
[   56.097953]   CC       util/annotate.o
[   56.097956]=20
[   56.453692]   CC       bench/epoll-ctl.o
[   56.453695]=20
[   56.861059]   CC       bench/synthesize.o
[   56.861062]=20
[   57.084508]   CC       bench/kallsyms-parse.o
[   57.084511]=20
[   57.180344]   CC       bench/find-bit-bench.o
[   57.180347]=20
[   57.324215]   CC       bench/inject-buildid.o
[   57.324217]=20
[   57.758673]   CC       bench/mem-memcpy-x86-64-asm.o
[   57.758676]=20
[   57.781607]   CC       bench/mem-memset-x86-64-asm.o
[   57.781609]=20
[   57.795426]   CC       bench/numa.o
[   57.795428]=20
[   57.923166]   CC       tests/dso-data.o
[   57.923170]=20
[   58.193362]   CC       tests/attr.o
[   58.193365]=20
[   58.543834]   CC       tests/vmlinux-kallsyms.o
[   58.543837]=20
[   58.796486]   CC       tests/openat-syscall.o
[   58.796489]=20
[   58.907726]   CC       tests/openat-syscall-all-cpus.o
[   58.907730]=20
[   59.113706]   CC       tests/openat-syscall-tp-fields.o
[   59.113709]=20
[   59.282651]   CC       tests/mmap-basic.o
[   59.282654]=20
[   59.608964]   CC       tests/perf-record.o
[   59.608967]=20
[   59.987542]   CC       tests/evsel-roundtrip-name.o
[   59.987554]=20
[   60.124199]   CC       tests/evsel-tp-sched.o
[   60.124202]=20
[   60.195016]   CC       util/block-info.o
[   60.195019]=20
[   60.218099]   CC       tests/fdarray.o
[   60.218103]=20
[   60.224448]   LD       bench/perf-in.o
[   60.224450]=20
[   60.260887]   CC       arch/common.o
[   60.260890]=20
[   60.291710]   CC       util/block-range.o
[   60.291713]=20
[   60.384170]   CC       arch/x86/util/header.o
[   60.384173]=20
[   60.523369]   CC       arch/x86/util/tsc.o
[   60.523373]=20
[   60.545488]   CC       tests/pmu.o
[   60.545491]=20
[   60.560608]   CC       arch/x86/util/pmu.o
[   60.560610]=20
[   60.646667]   CC       arch/x86/util/kvm-stat.o
[   60.646669]=20
[   60.680378]   CC       tests/pmu-events.o
[   60.680381]=20
[   60.734988]   CC       arch/x86/tests/regs_load.o
[   60.734991]=20
[   60.757917]   CC       arch/x86/tests/dwarf-unwind.o
[   60.757920]=20
[   60.789298]   CC       arch/x86/util/perf_regs.o
[   60.789301]=20
[   60.877259]   CC       arch/x86/tests/arch-tests.o
[   60.877262]=20
[   60.912394]   CC       arch/x86/tests/rdpmc.o
[   60.912397]=20
[   60.972954]   CC       arch/x86/util/topdown.o
[   60.972957]=20
[   61.062087]   CC       arch/x86/util/machine.o
[   61.062090]=20
[   61.114775]   CC       arch/x86/tests/perf-time-to-tsc.o
[   61.114778]=20
[   61.154451]   CC       util/build-id.o
[   61.154454]=20
[   61.219174]   CC       arch/x86/util/event.o
[   61.219177]=20
[   61.308495]   CC       arch/x86/tests/insn-x86.o
[   61.308499]=20
[   61.349020]   CC       tests/hists_common.o
[   61.349023]=20
[   61.361523]   CC       arch/x86/util/dwarf-regs.o
[   61.361526]=20
[   61.420332]   CC       arch/x86/util/unwind-libunwind.o
[   61.420335]=20
[   61.473851]   CC       arch/x86/util/auxtrace.o
[   61.473854]=20
[   61.528840]   CC       arch/x86/tests/intel-pt-pkt-decoder-test.o
[   61.528843]=20
[   61.617734]   CC       tests/hists_link.o
[   61.617737]=20
[   61.632890]   CC       arch/x86/util/archinsn.o
[   61.632893]=20
[   61.683991]   CC       arch/x86/tests/bp-modify.o
[   61.683994]=20
[   61.751476]   CC       arch/x86/util/intel-pt.o
[   61.751479]=20
[   61.835086]   LD       arch/x86/tests/perf-in.o
[   61.835089]=20
[   61.847769]   CC       arch/x86/util/intel-bts.o
[   61.847772]=20
[   61.867443]   CC       util/cacheline.o
[   61.867446]=20
[   61.904239]   CC       util/config.o
[   61.904242]=20
[   61.977941]   CC       tests/hists_filter.o
[   61.977944]=20
[   62.382008]   CC       tests/hists_output.o
[   62.382011]=20
[   62.405733]   CC       tests/hists_cumulate.o
[   62.405736]=20
[   62.545049]   CC       util/copyfile.o
[   62.545052]=20
[   62.672113]   CC       util/ctype.o
[   62.672116]=20
[   62.702029]   CC       util/db-export.o
[   62.702032]=20
[   63.013555]   LD       arch/x86/util/perf-in.o
[   63.013558]=20
[   63.041420]   LD       arch/x86/perf-in.o
[   63.041423]=20
[   63.061942]   LD       arch/perf-in.o
[   63.061945]=20
[   63.083470]   CC       ui/setup.o
[   63.083473]=20
[   63.179757]   CC       ui/helpline.o
[   63.179760]=20
[   63.285982]   CC       ui/progress.o
[   63.285985]=20
[   63.358594]   CC       ui/util.o
[   63.358596]=20
[   63.436649]   CC       ui/hist.o
[   63.436652]=20
[   63.472374]   CC       tests/python-use.o
[   63.472377]=20
[   63.529827]   CC       tests/bp_signal.o
[   63.529829]=20
[   63.607608]   CC       util/env.o
[   63.607610]=20
[   63.658651]   CC       tests/bp_signal_overflow.o
[   63.658654]=20
[   63.669882]   CC       tests/bp_account.o
[   63.669885]=20
[   63.766963]   CC       tests/wp.o
[   63.766966]=20
[   63.943679]   CC       util/event.o
[   63.943682]=20
[   63.991261]   CC       tests/task-exit.o
[   63.991264]=20
[   64.040936]   CC       util/evlist.o
[   64.040938]=20
[   64.132153]   CC       tests/sw-clock.o
[   64.132156]=20
[   64.275927]   CC       tests/mmap-thread-lookup.o
[   64.275930]=20
[   64.520073]   CC       tests/thread-maps-share.o
[   64.520076]=20
[   64.693439]   CC       tests/switch-tracking.o
[   64.693442]=20
[   64.721448]   CC       util/sideband_evlist.o
[   64.721451]=20
[   64.903392]   CC       util/evsel.o
[   64.903395]=20
[   65.173948]   CC       tests/keep-tracking.o
[   65.173951]=20
[   65.324399]   CC       tests/code-reading.o
[   65.324402]=20
[   66.082243]   CC       tests/sample-parsing.o
[   66.082246]=20
[   66.181531]   CC       util/evsel_fprintf.o
[   66.181534]=20
[   66.504389]   CC       util/perf_event_attr_fprintf.o
[   66.504392]=20
[   66.651780]   CC       tests/parse-no-sample-id-all.o
[   66.651783]=20
[   66.777145]   CC       tests/kmod-path.o
[   66.777148]=20
[   67.034998]   CC       util/evswitch.o
[   67.035001]=20
[   67.094623]   CC       tests/thread-map.o
[   67.094626]=20
[   67.147435]   CC       util/find_bit.o
[   67.147438]=20
[   67.269026]   CC       tests/llvm.o
[   67.269030]=20
[   67.278967]   CC       util/get_current_dir_name.o
[   67.278969]=20
[   67.302902]   CC       util/kallsyms.o
[   67.302905]=20
[   67.408239]   CC       tests/bpf.o
[   67.408243]=20
[   67.556698]   CC       util/levenshtein.o
[   67.556701]=20
[   67.672587]   CC       tests/topology.o
[   67.672590]=20
[   67.683532]   CC       util/llvm-utils.o
[   67.683535]=20
[   67.859475]   CC       tests/mem.o
[   67.859478]=20
[   67.946671]   CC       tests/cpumap.o
[   67.946674]=20
[   68.023789]   CC       util/mmap.o
[   68.023792]=20
[   68.137902]   CC       tests/stat.o
[   68.137905]=20
[   68.319832]   CC       tests/event_update.o
[   68.319835]=20
[   68.357681]   CC       util/memswap.o
[   68.357684]=20
[   68.400539]   BISON    util/parse-events-bison.c
[   68.400541]=20
[   68.466551]   CC       util/perf_regs.o
[   68.466554]=20
[   68.488897]   CC       util/path.o
[   68.488899]=20
[   68.509521]   CC       tests/event-times.o
[   68.509524]=20
[   68.549676]   CC       util/print_binary.o
[   68.549679]=20
[   68.584966]   CC       util/rlimit.o
[   68.584969]=20
[   68.625501]   CC       util/argv_split.o
[   68.625504]=20
[   68.647172]   CC       util/rbtree.o
[   68.647175]=20
[   68.716127]   CC       util/libstring.o
[   68.716130]=20
[   68.821941]   CC       tests/expr.o
[   68.821944]=20
[   68.831499]   CC       util/bitmap.o
[   68.831501]=20
[   68.969502]   CC       tests/backward-ring-buffer.o
[   68.969505]=20
[   68.987170]   CC       tests/sdt.o
[   68.987173]=20
[   69.107211]   CC       tests/is_printable_array.o
[   69.107214]=20
[   69.130092]   CC       tests/bitmap.o
[   69.130095]=20
[   69.189765]   CC       tests/perf-hooks.o
[   69.189768]=20
[   69.231346]   CC       tests/clang.o
[   69.231348]=20
[   69.247785]   CC       tests/unit_number__scnprintf.o
[   69.247787]=20
[   69.269065]   CC       util/hweight.o
[   69.269068]=20
[   69.315200]   CC       tests/mem2node.o
[   69.315203]=20
[   69.321009]   CC       util/smt.o
[   69.321011]=20
[   69.399954]   CC       util/strbuf.o
[   69.399956]=20
[   69.452258]   CC       tests/maps.o
[   69.452260]=20
[   69.502244]   CC       ui/stdio/hist.o
[   69.502247]=20
[   69.612967]   CC       util/string.o
[   69.612969]=20
[   69.669331]   CC       tests/time-utils-test.o
[   69.669334]=20
[   69.743839]   CC       util/strlist.o
[   69.743842]=20
[   69.852182]   CC       util/strfilter.o
[   69.852185]=20
[   69.921236]   CC       util/top.o
[   69.921240]=20
[   69.972555]   CC       tests/genelf.o
[   69.972558]=20
[   70.045834]   CC       tests/api-io.o
[   70.045837]=20
[   70.211602]   CC       util/usage.o
[   70.211605]=20
[   70.267615]   CC       util/dso.o
[   70.267618]=20
[   70.406124]   CC       tests/demangle-java-test.o
[   70.406127]=20
[   70.509956]   CC       tests/pfm.o
[   70.509959]=20
[   70.582724]   CC       tests/parse-metric.o
[   70.582728]=20
[   70.664368]   CC       ui/browser.o
[   70.664371]=20
[   70.856669]   CC       tests/pe-file-parsing.o
[   70.856672]=20
[   70.997726]   CC       tests/expand-cgroup.o
[   70.997729]=20
[   71.323272]   CC       tests/dwarf-unwind.o
[   71.323275]=20
[   71.475913]   CC       ui/browsers/annotate.o
[   71.475916]=20
[   71.503834]   CC       tests/llvm-src-base.o
[   71.503837]=20
[   71.531506]   CC       tests/llvm-src-kbuild.o
[   71.531509]=20
[   71.542163]   CC       util/dsos.o
[   71.542166]=20
[   71.559260]   CC       tests/llvm-src-prologue.o
[   71.559262]=20
[   71.586296]   CC       tests/llvm-src-relocation.o
[   71.586300]=20
[   71.612823]   LD       tests/perf-in.o
[   71.612825]=20
[   71.732652]   CC       scripts/perl/Perf-Trace-Util/Context.o
[   71.732655]=20
[   71.897947]   CC       util/symbol.o
[   71.897950]=20
[   71.996256]   CC       scripts/python/Perf-Trace-Util/Context.o
[   71.996259]=20
[   72.132653]   LD       scripts/python/Perf-Trace-Util/perf-in.o
[   72.132656]=20
[   72.140899]   CC       util/symbol_fprintf.o
[   72.140901]=20
[   72.300213]   CC       util/color.o
[   72.300215]=20
[   72.320392]   LD       scripts/perl/Perf-Trace-Util/perf-in.o
[   72.320395]=20
[   72.346610]   LD       scripts/perf-in.o
[   72.346612]=20
[   72.373291]   CC       util/color_config.o
[   72.373294]=20
[   72.479749]   CC       trace/beauty/clone.o
[   72.479752]=20
[   72.491422]   CC       perf.o
[   72.491424]=20
[   72.627074]   CC       trace/beauty/fcntl.o
[   72.627076]=20
[   72.720004]   CC       trace/beauty/flock.o
[   72.720007]=20
[   72.812593]   CC       trace/beauty/fsmount.o
[   72.812596]=20
[   72.857013]   CC       util/metricgroup.o
[   72.857016]=20
[   72.866773]   CC       trace/beauty/fspick.o
[   72.866776]=20
[   72.879195]   CC       ui/browsers/hists.o
[   72.879198]=20
[   72.928231]   CC       trace/beauty/ioctl.o
[   72.928234]=20
[   73.097468]   CC       trace/beauty/kcmp.o
[   73.097471]=20
[   73.169861]   CC       trace/beauty/mount_flags.o
[   73.169864]=20
[   73.229390]   CC       trace/beauty/move_mount.o
[   73.229393]=20
[   73.281588]   CC       trace/beauty/pkey_alloc.o
[   73.281591]=20
[   73.439799]   CC       trace/beauty/arch_prctl.o
[   73.439802]=20
[   73.484894]   CC       trace/beauty/prctl.o
[   73.484897]=20
[   73.567834]   CC       trace/beauty/renameat.o
[   73.567837]=20
[   73.614854]   CC       trace/beauty/sockaddr.o
[   73.614857]=20
[   73.734373]   CC       trace/beauty/socket.o
[   73.734376]=20
[   73.787273]   CC       trace/beauty/statx.o
[   73.787276]=20
[   73.916600]   CC       trace/beauty/sync_file_range.o
[   73.916603]=20
[   73.983966]   CC       trace/beauty/tracepoints/x86_irq_vectors.o
[   73.983969]=20
[   74.040825]   CC       trace/beauty/tracepoints/x86_msr.o
[   74.040828]=20
[   74.101781]   LD       trace/beauty/tracepoints/perf-in.o
[   74.101784]=20
[   74.109507]   LD       trace/beauty/perf-in.o
[   74.109509]=20
[   74.126086]   CC       util/header.o
[   74.126089]=20
[   74.145426]   CC       util/callchain.o
[   74.145429]=20
[   74.255289]   CC       util/values.o
[   74.255292]=20
[   74.816935]   CC       util/debug.o
[   74.816939]=20
[   75.043371]   CC       util/fncache.o
[   75.043373]=20
[   75.180838]   CC       util/machine.o
[   75.180841]=20
[   76.172052]   CC       util/map.o
[   76.172056]=20
[   77.536682]   CC       util/pstack.o
[   77.536685]=20
[   77.644249]   CC       util/session.o
[   77.644251]=20
[   78.843021]   CC       util/sample-raw.o
[   78.843024]=20
[   78.885600]   CC       util/s390-sample-raw.o
[   78.885603]=20
[   78.931757]   CC       util/syscalltbl.o
[   78.931760]=20
[   79.103228]   CC       util/ordered-events.o
[   79.103231]=20
[   79.161504]   CC       util/namespaces.o
[   79.161507]=20
[   79.469658]   CC       util/comm.o
[   79.469661]=20
[   79.649867]   CC       util/thread.o
[   79.649870]=20
[   79.801952]   CC       util/thread_map.o
[   79.801955]=20
[   80.095891]   CC       ui/browsers/map.o
[   80.095894]=20
[   80.203011]   CC       util/trace-event-parse.o
[   80.203014]=20
[   80.259837]   CC       util/parse-events-bison.o
[   80.259841]=20
[   80.270866]   CC       ui/browsers/scripts.o
[   80.270869]=20
[   80.390410]   CC       ui/browsers/header.o
[   80.390413]=20
[   80.551060]   CC       ui/browsers/res_sample.o
[   80.551063]=20
[   80.581507]   BISON    util/pmu-bison.c
[   80.581510]=20
[   80.609574]   CC       util/trace-event-read.o
[   80.609578]=20
[   80.717878]   CC       util/trace-event-info.o
[   80.717881]=20
[   80.843929]   CC       util/trace-event-scripting.o
[   80.843932]=20
[   80.939917]   CC       util/trace-event.o
[   80.939920]=20
[   81.091798]   CC       util/svghelper.o
[   81.091801]=20
[   81.162072]   CC       util/sort.o
[   81.162075]=20
[   81.825775]   CC       util/hist.o
[   81.825777]=20
[   82.330656]   CC       util/util.o
[   82.330659]=20
[   82.665015]   CC       util/cpumap.o
[   82.665018]=20
[   82.883485]   LD       ui/browsers/perf-in.o
[   82.883488]=20
[   82.918031]   CC       ui/tui/setup.o
[   82.918034]=20
[   83.048132]   CC       ui/tui/util.o
[   83.048136]=20
[   83.293443]   CC       ui/tui/helpline.o
[   83.293446]=20
[   83.328496]   CC       util/affinity.o
[   83.328499]=20
[   83.378411]   CC       ui/tui/progress.o
[   83.378414]=20
[   83.423236]   CC       util/cputopo.o
[   83.423239]=20
[   83.490525]   LD       ui/tui/perf-in.o
[   83.490528]=20
[   83.498892]   LD       ui/perf-in.o
[   83.498895]=20
[   83.546776]   CC       util/cgroup.o
[   83.546779]=20
[   83.702682]   CC       util/target.o
[   83.702685]=20
[   83.837416]   CC       util/rblist.o
[   83.837420]=20
[   83.990294]   CC       util/intlist.o
[   83.990298]=20
[   84.079340]   CC       util/vdso.o
[   84.079343]=20
[   84.156148]   CC       util/counts.o
[   84.156151]=20
[   84.163841]   CC       util/stat.o
[   84.163844]=20
[   84.269112]   CC       util/stat-shadow.o
[   84.269115]=20
[   84.339768]   CC       util/stat-display.o
[   84.339771]=20
[   84.894150]   CC       util/perf_api_probe.o
[   84.894154]=20
[   85.174366]   CC       util/record.o
[   85.174370]=20
[   85.489153]   CC       util/srcline.o
[   85.489156]=20
[   86.063672]   CC       util/srccode.o
[   86.063674]=20
[   86.236314]   CC       util/synthetic-events.o
[   86.236317]=20
[   86.310802]   CC       util/data.o
[   86.310805]=20
[   86.563642]   CC       util/tsc.o
[   86.563645]=20
[   86.722854]   CC       util/cloexec.o
[   86.722857]=20
[   86.786063]   CC       util/call-path.o
[   86.786066]=20
[   86.846848]   CC       util/rwsem.o
[   86.846851]=20
[   86.923062]   CC       util/thread-stack.o
[   86.923065]=20
[   87.053689]   CC       util/spark.o
[   87.053692]=20
[   87.129038]   CC       util/topdown.o
[   87.129041]=20
[   87.137141]   CC       util/stream.o
[   87.137143]=20
[   87.239820]   CC       util/auxtrace.o
[   87.239822]=20
[   87.487416]   CC       util/intel-pt-decoder/intel-pt-pkt-decoder.o
[   87.487419]=20
[   87.969830]   GEN      util/intel-pt-decoder/inat-tables.c
[   87.969834]=20
[   87.989383]   CC       util/intel-pt-decoder/intel-pt-log.o
[   87.989386]=20
[   88.098416]   CC       util/intel-pt-decoder/intel-pt-decoder.o
[   88.098420]=20
[   88.587384]   CC       util/arm-spe-decoder/arm-spe-pkt-decoder.o
[   88.587387]=20
[   88.758135]   CC       util/scripting-engines/trace-event-perl.o
[   88.758138]=20
[   88.923360]   CC       util/arm-spe-decoder/arm-spe-decoder.o
[   88.923364]=20
[   89.141085]   LD       util/arm-spe-decoder/perf-in.o
[   89.141088]=20
[   89.154143]   CC       util/intel-pt.o
[   89.154145]=20
[   90.111447]   CC       util/scripting-engines/trace-event-python.o
[   90.111450]=20
[   90.340128]   CC       util/intel-bts.o
[   90.340131]=20
[   91.314036]   CC       util/arm-spe.o
[   91.314039]=20
[   92.139767]   CC       util/intel-pt-decoder/intel-pt-insn-decoder.o
[   92.139770]=20
[   92.418047]   CC       util/s390-cpumsf.o
[   92.418050]=20
[   92.484918] IPMI BMC is not supported on this machine, skip bmc-watchdog=
 setup!
[   92.484920]=20
[   92.730034]   LD       util/scripting-engines/perf-in.o
[   92.730036]=20
[   92.746003]   CC       util/parse-branch-options.o
[   92.746006]=20
[   92.836998]   CC       util/dump-insn.o
[   92.837001]=20
[   92.874219]   CC       util/parse-regs-options.o
[   92.874222]=20
[   92.973847]   CC       util/parse-sublevel-options.o
[   92.973850]=20
[   93.049678]   CC       util/term.o
[   93.049681]=20
[   93.120614]   CC       util/help-unknown-cmd.o
[   93.120617]=20
[   93.271369]   CC       util/mem-events.o
[   93.271372]=20
[   93.326866]   LD       util/intel-pt-decoder/perf-in.o
[   93.326869]=20
[   93.339617]   CC       util/vsprintf.o
[   93.339620]=20
[   93.381871]   CC       util/units.o
[   93.381874]=20
[   93.406993]   CC       util/time-utils.o
[   93.406996]=20
[   93.463545]   BISON    util/expr-bison.c
[   93.463553]=20
[   93.504588]   CC       util/branch.o
[   93.504591]=20
[   93.762057]   CC       util/mem2node.o
[   93.762060]=20
[   93.815592]   CC       util/clockid.o
[   93.815595]=20
[   93.881437]   CC       util/bpf-loader.o
[   93.881440]=20
[   93.915771]   CC       util/bpf_map.o
[   93.915773]=20
[   93.951612]   CC       util/bpf-prologue.o
[   93.951614]=20
[   94.001444]   CC       util/symbol-elf.o
[   94.001447]=20
[   94.477775]   CC       util/probe-file.o
[   94.477778]=20
[   94.504345]   CC       util/probe-event.o
[   94.504348]=20
[   95.181043]   CC       util/probe-finder.o
[   95.181046]=20
[   95.489640]   CC       util/dwarf-aux.o
[   95.489643]=20
[   95.962112]   CC       util/dwarf-regs.o
[   95.962116]=20
[   96.036715]   CC       util/unwind-libunwind-local.o
[   96.036718]=20
[   96.193677]   CC       util/unwind-libunwind.o
[   96.193680]=20
[   96.335833]   CC       util/data-convert-bt.o
[   96.335837]=20
[   96.394239]   CC       util/zlib.o
[   96.394242]=20
[   96.481037]   CC       util/lzma.o
[   96.481040]=20
[   96.586914]   CC       util/zstd.o
[   96.586918]=20
[   96.686258]   CC       util/cap.o
[   96.686261]=20
[   96.724492]   CC       util/demangle-java.o
[   96.724495]=20
[   96.906327]   CC       util/demangle-rust.o
[   96.906330]=20
[   96.961749]   CC       util/jitdump.o
[   96.961752]=20
[   97.260961]   CC       util/genelf.o
[   97.260965]=20
[   97.509677]   CC       util/genelf_debug.o
[   97.509680]=20
[   97.688485]   CC       util/perf-hooks.o
[   97.688488]=20
[   97.817401]   CC       util/bpf-event.o
[   97.817404]=20
[   97.823441]   FLEX     util/parse-events-flex.c
[   97.823443]=20
[   97.852623]   FLEX     util/pmu-flex.c
[   97.852626]=20
[   97.871335]   CC       util/pmu-bison.o
[   97.871338]=20
[   98.072121]   FLEX     util/expr-flex.c
[   98.072124]=20
[   98.084325]   CC       util/expr-bison.o
[   98.084328]=20
[   98.134994]   CC       util/expr.o
[   98.134997]=20
[   98.336288]   CC       util/parse-events.o
[   98.336291]=20
[   98.373211]   CC       util/parse-events-flex.o
[   98.373214]=20
[   98.668838]   CC       util/pmu.o
[   98.668841]=20
[   98.766785]   CC       util/pmu-flex.o
[   98.766788]=20
[   99.801582]   CC       util/expr-flex.o
[   99.801584]=20
[  105.305151]   LD       util/perf-in.o
[  105.305153]=20
[  105.608741]   LD       perf-in.o
[  105.608743]=20
[  105.912677]   LINK     perf
[  105.912679]=20
[  106.861220] make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf'
[  106.861223]=20
[  106.876156] Key type dns_resolver registered
[  106.876872] 2020-12-25 16:25:39 cd /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf
[  106.880391]=20
[  106.893875] 2020-12-25 16:25:39 mkdir -p /pkg
[  106.893876]=20
[  106.900982] 2020-12-25 16:25:39 mkdir -p /kbuild/obj/consumer/x86_64-rhe=
l-8.3
[  106.900983]=20
[  107.022136] NFS: Registering the id_resolver key type
[  107.027153] Key type id_resolver registered
[  107.031317] Key type id_legacy registered
[  107.080318] 2020-12-25 16:25:39 cp /pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b=
1ba0e7ea9a80b0ee4b4445ea59c806787813/vmlinux.xz /tmp
[  107.080320]=20
[  107.568302] 2020-12-25 16:25:40 unxz -k /tmp/vmlinux.xz
[  107.568304]=20
[  111.277609] 2020-12-25 16:25:44 cp /tmp/vmlinux /kbuild/obj/consumer/x86=
_64-rhel-8.3
[  111.277612]=20
[  111.408565] ignored_by_lkp: BPF filter
[  111.408567]=20
[  111.450570] ignored_by_lkp: LLVM search and compile
[  111.450573]=20
[  111.491919] ignored_by_lkp: Add vfs_getname probe to get syscall args fi=
lenames
[  111.491923]=20
[  111.532915] ignored_by_lkp: Use vfs_getname probe to get syscall args fi=
lenames
[  111.532918]=20
[  111.574082] ignored_by_lkp: Check open filename arg using perf trace + v=
fs_getname
[  111.574085]=20
[  111.614721] ignored_by_lkp: builtin clang support
[  111.614737]=20
[  111.662896] 2020-12-25 16:25:44 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 1
[  111.662898]=20
[  112.494369]  1: vmlinux symtab matches kallsyms                         =
        : Ok
[  112.494373]=20
[  112.515321] 2020-12-25 16:25:45 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 2
[  112.515323]=20
[  112.580941]  2: Detect openat syscall event                             =
        : Ok
[  112.580944]=20
[  112.601463] 2020-12-25 16:25:45 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 3
[  112.601465]=20
[  112.670091]  3: Detect openat syscall event on all cpus                 =
        : Ok
[  112.670094]=20
[  112.691113] 2020-12-25 16:25:45 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 4
[  112.691116]=20
[  112.813020]  4: Read samples using the mmap interface                   =
        : FAILED!
[  112.813023]=20
[  112.834024] 2020-12-25 16:25:45 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 5
[  112.834027]=20
[  112.878434]  5: Test data source output                                 =
        : Ok
[  112.878436]=20
[  112.898869] 2020-12-25 16:25:45 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 6
[  112.898872]=20
[  114.181584]  6: Parse event definition strings                          =
        : FAILED!
[  114.181601]=20
[  114.201812] 2020-12-25 16:25:47 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 7
[  114.201814]=20
[  114.247836]  7: Simple expression parser                                =
        : Ok
[  114.247839]=20
[  114.268764] 2020-12-25 16:25:47 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 8
[  114.268767]=20
[  116.326288]  8: PERF_RECORD_* events & perf_sample fields               =
        : Ok
[  116.326291]=20
[  116.346857] 2020-12-25 16:25:49 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 9
[  116.346859]=20
[  116.398116]  9: Parse perf pmu format                                   =
        : Ok
[  116.398119]=20
[  116.418850] 2020-12-25 16:25:49 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 10
[  116.418853]=20
[  116.445990] 10: PMU events                                              =
        :
[  116.445993]=20
[  116.464657] 10.1: PMU event table sanity                                =
        : Ok
[  116.464660]=20
[  116.551692] 10.2: PMU event map aliases                                 =
        : Ok
[  116.551694]=20
[  118.242663] 10.3: Parsing of PMU event table metrics                    =
        : Skip (some metrics failed)
[  118.242666]=20
[  118.371444] 10.4: Parsing of PMU event table metrics with fake PMUs     =
        : Ok
[  118.371447]=20
[  118.392337] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 11
[  118.392339]=20
[  118.438031] 11: DSO data read                                           =
        : Ok
[  118.438034]=20
[  118.458965] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 12
[  118.458967]=20
[  118.505934] 12: DSO data cache                                          =
        : Ok
[  118.505937]=20
[  118.526529] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 13
[  118.526531]=20
[  118.573140] 13: DSO data reopen                                         =
        : Ok
[  118.573143]=20
[  118.593876] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 14
[  118.593879]=20
[  118.640613] 14: Roundtrip evsel->name                                   =
        : Ok
[  118.640617]=20
[  118.661177] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 15
[  118.661180]=20
[  118.708521] 15: Parse sched tracepoints fields                          =
        : Ok
[  118.708523]=20
[  118.729055] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 16
[  118.729057]=20
[  118.796829] 16: syscalls:sys_enter_openat event fields                  =
        : Ok
[  118.796831]=20
[  118.817097] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 17
[  118.817100]=20
[  132.920286] 17: Setup struct perf_event_attr                            =
        : Ok
[  132.920288]=20
[  132.940728] 2020-12-25 16:26:05 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 18
[  132.940730]=20
[  132.985757] 18: Match and link multiple hists                           =
        : Ok
[  132.985760]=20
[  133.006200] 2020-12-25 16:26:05 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 19
[  133.006202]=20
[  133.063471] 19: 'import perf' in python                                 =
        : FAILED!
[  133.063474]=20
[  133.083996] 2020-12-25 16:26:05 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 20
[  133.083999]=20
[  133.130030] 20: Breakpoint overflow signal handler                      =
        : Ok
[  133.130033]=20
[  133.151059] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 21
[  133.151061]=20
[  133.204150] 21: Breakpoint overflow sampling                            =
        : Ok
[  133.204153]=20
[  133.224792] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 22
[  133.224794]=20
[  133.270011] 22: Breakpoint accounting                                   =
        : Ok
[  133.270014]=20
[  133.290812] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 23
[  133.290814]=20
[  133.317877] 23: Watchpoint                                              =
        :
[  133.317880]=20
[  133.336340] 23.1: Read Only Watchpoint                                  =
        : Skip
[  133.336342]=20
[  133.354651] 23.2: Write Only Watchpoint                                 =
        : Ok
[  133.354653]=20
[  133.372948] 23.3: Read / Write Watchpoint                               =
        : Ok
[  133.372951]=20
[  133.391146] 23.4: Modify Watchpoint                                     =
        : Ok
[  133.391148]=20
[  133.411988] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 24
[  133.411990]=20
[  133.488894] 24: Number of exit events of a simple workload              =
        : FAILED!
[  133.488897]=20
[  133.509502] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 25
[  133.509504]=20
[  133.615162] 25: Software clock events period values                     =
        : FAILED!
[  133.615165]=20
[  133.635244] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 26
[  133.635246]=20
[  134.075631] perf: interrupt took too long (2601 > 2500), lowering kernel=
=2Eperf_event_max_sample_rate to 76000
[  136.755784] 26: Object code reading                                     =
        : FAILED!
[  136.755786]=20
[  136.776297] 2020-12-25 16:26:09 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 27
[  136.776300]=20
[  136.821956] 27: Sample parsing                                          =
        : Ok
[  136.821959]=20
[  136.842807] 2020-12-25 16:26:09 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 28
[  136.842810]=20
[  136.918980] 28: Use a dummy software event to keep tracking             =
        : FAILED!
[  136.918983]=20
[  136.939689] 2020-12-25 16:26:09 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 29
[  136.939692]=20
[  136.985042] 29: Parse with no sample_id_all bit set                     =
        : Ok
[  136.985045]=20
[  137.005701] 2020-12-25 16:26:09 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 30
[  137.005703]=20
[  137.051953] 30: Filter hist entries                                     =
        : Ok
[  137.051956]=20
[  137.073083] 2020-12-25 16:26:09 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 31
[  137.073086]=20
[  137.487808] 31: Lookup mmap thread                                      =
        : FAILED!
[  137.487811]=20
[  137.508920] 2020-12-25 16:26:10 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 32
[  137.508923]=20
[  137.554376] 32: Share thread maps                                       =
        : Ok
[  137.554379]=20
[  137.575109] 2020-12-25 16:26:10 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 33
[  137.575112]=20
[  137.621995] 33: Sort output of hist entries                             =
        : Ok
[  137.621997]=20
[  137.643113] 2020-12-25 16:26:10 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 34
[  137.643116]=20
[  137.689930] 34: Cumulate child hist entries                             =
        : Ok
[  137.689933]=20
[  137.710669] 2020-12-25 16:26:10 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 35
[  137.710671]=20
[  138.186132] 35: Track with sched_switch                                 =
        : FAILED!
[  138.186135]=20
[  138.206753] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 36
[  138.206756]=20
[  138.252009] 36: Filter fds with revents mask in a fdarray               =
        : Ok
[  138.252012]=20
[  138.272663] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 37
[  138.272666]=20
[  138.317606] 37: Add fd to a fdarray, making it autogrow                 =
        : Ok
[  138.317609]=20
[  138.338054] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 38
[  138.338057]=20
[  138.383303] 38: kmod_path__parse                                        =
        : Ok
[  138.383306]=20
[  138.403887] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 39
[  138.403889]=20
[  138.449721] 39: Thread map                                              =
        : Ok
[  138.449724]=20
[  138.472155] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 41
[  138.472158]=20
[  138.700130] 41: Session topology                                        =
        : FAILED!
[  138.700133]=20
[  138.722000] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 43
[  138.722002]=20
[  138.796404] 43: Synthesize thread map                                   =
        : FAILED!
[  138.796406]=20
[  138.817104] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 44
[  138.817106]=20
[  138.888377] 44: Remove thread map                                       =
        : FAILED!
[  138.888380]=20
[  138.908976] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 45
[  138.908978]=20
[  138.954887] 45: Synthesize cpu map                                      =
        : Ok
[  138.954890]=20
[  138.975511] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 46
[  138.975514]=20
[  139.020705] 46: Synthesize stat config                                  =
        : Ok
[  139.020708]=20
[  139.041376] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 47
[  139.041378]=20
[  139.085894] 47: Synthesize stat                                         =
        : Ok
[  139.085897]=20
[  139.106184] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 48
[  139.106187]=20
[  139.152015] 48: Synthesize stat round                                   =
        : Ok
[  139.152018]=20
[  139.173141] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 49
[  139.173144]=20
[  139.253527] 49: Synthesize attr update                                  =
        : FAILED!
[  139.253530]=20
[  139.274504] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 50
[  139.274507]=20
[  139.332635] 50: Event times                                             =
        : Ok
[  139.332638]=20
[  139.353134] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 51
[  139.353137]=20
[  139.487719] 51: Read backward ring buffer                               =
        : Ok
[  139.487722]=20
[  139.508250] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 52
[  139.508252]=20
[  139.583084] 52: Print cpu map                                           =
        : FAILED!
[  139.583086]=20
[  139.603431] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 53
[  139.603433]=20
[  139.648935] 53: Merge cpu map                                           =
        : Ok
[  139.648937]=20
[  139.669741] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 54
[  139.669744]=20
[  139.716023] 54: Probe SDT events                                        =
        : Ok
[  139.716025]=20
[  139.736752] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 55
[  139.736755]=20
[  139.780981] 55: is_printable_array                                      =
        : Ok
[  139.780984]=20
[  139.801687] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 56
[  139.801690]=20
[  139.847641] 56: Print bitmap                                            =
        : Ok
[  139.847644]=20
[  139.868185] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 57
[  139.868188]=20
[  139.913098] 57: perf hooks                                              =
        : Ok
[  139.913100]=20
[  139.934734] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 59
[  139.934737]=20
[  139.979489] 59: unit_number__scnprintf                                  =
        : Ok
[  139.979492]=20
[  140.000147] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 60
[  140.000150]=20
[  140.044935] 60: mem2node                                                =
        : Ok
[  140.044938]=20
[  140.065505] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 61
[  140.065507]=20
[  140.111033] 61: time utils                                              =
        : Ok
[  140.111035]=20
[  140.131867] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 62
[  140.131870]=20
[  140.178067] 62: Test jit_write_elf                                      =
        : Ok
[  140.178070]=20
[  140.199296] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 63
[  140.199298]=20
[  140.226438] 63: Test libpfm4 support                                    =
        : Skip (not compiled in)
[  140.226441]=20
[  140.245694] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 64
[  140.245696]=20
[  140.291678] 64: Test api io                                             =
        : Ok
[  140.291681]=20
[  140.312114] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 65
[  140.312116]=20
[  140.392987] 65: maps__merge_in                                          =
        : FAILED!
[  140.392989]=20
[  140.413807] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 66
[  140.413810]=20
[  140.459562] 66: Demangle Java                                           =
        : Ok
[  140.459579]=20
[  140.480666] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 67
[  140.480669]=20
[  140.529782] 67: Parse and process metrics                               =
        : Ok
[  140.529785]=20
[  140.550204] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 68
[  140.550206]=20
[  140.623476] 68: PE file support                                         =
        : FAILED!
[  140.623478]=20
[  140.644073] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 69
[  140.644075]=20
[  140.690168] 69: Event expansion for cgroups                             =
        : Ok
[  140.690171]=20
[  140.710643] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 70
[  140.710646]=20
[  140.944296] 70: x86 rdpmc                                               =
        : Ok
[  140.944299]=20
[  140.964817] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 71
[  140.964820]=20
[  141.041137] 71: Convert perf time to TSC                                =
        : FAILED!
[  141.041140]=20
[  141.061746] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 72
[  141.061748]=20
[  141.457682] 72: DWARF unwind                                            =
        : FAILED!
[  141.457685]=20
[  141.478307] 2020-12-25 16:26:14 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 73
[  141.478310]=20
[  141.525183] 73: x86 instruction decoder - new instructions              =
        : Ok
[  141.525186]=20
[  141.545833] 2020-12-25 16:26:14 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 74
[  141.545836]=20
[  141.591564] 74: Intel PT packet decoder                                 =
        : Ok
[  141.591567]=20
[  141.612192] 2020-12-25 16:26:14 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 75
[  141.612194]=20
[  141.665823] 75: x86 bp modify                                           =
        : Ok
[  141.665825]=20
[  141.686216] 2020-12-25 16:26:14 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 76
[  141.686219]=20
[  143.484830] 76: probe libc's inet_pton & backtrace it with ping         =
        : Ok
[  143.484833]=20
[  143.505402] 2020-12-25 16:26:16 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 77
[  143.505404]=20
[  143.695126] 77: Check Arm CoreSight trace data recording and synthesized=
 samples: Skip
[  143.695129]=20
[  143.715677] 2020-12-25 16:26:16 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 78
[  143.715680]=20
[  145.157288] 78: build id cache operations                               =
        : FAILED!
[  145.157291]=20
[  145.180175] 2020-12-25 16:26:18 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 81
[  145.180178]=20
[  146.486914] 81: Zstd perf.data compression/decompression                =
        : FAILED!
[  146.486917]=20
[  146.537605] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=3D=
0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c8067878=
13-20201226-25066-sfkgan-4.yaml&job_state=3Dpost_run -O /dev/null
[  146.537608]=20
[  148.252191] kill 2507 vmstat --timestamp -n 10=20
[  148.252194]=20
[  148.258935] kill 2505 dmesg --follow --decode=20
[  148.258936]=20
[  148.266035] wait for background processes: 2510 2512 meminfo oom-killer
[  148.266036]=20
[  154.480959] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=3D=
0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c8067878=
13-20201226-25066-sfkgan-4.yaml&loadavg=3D1.83%201.13%200.45%201/135%208978=
&start_time=3D1608913465&end_time=3D1608913579&version=3D/lkp/lkp/.src-2020=
1225-151440:04492474:3e57f6440& -O /dev/null
[  154.480962]=20
[  154.531104] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=3D=
0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c8067878=
13-20201226-25066-sfkgan-4.yaml&job_state=3Dfinished -O /dev/null
[  154.531105]=20
[  154.570198] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-post-run?job_file=
=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=3D0xe2-debia=
n-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813-2020122=
6-25066-sfkgan-4.yaml -O /dev/null
[  154.570199]=20
[  154.903935] getting new job...
[  154.903938]=20
[  154.935136] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/gpxelinux.cgi?hostnam=
e=3Dlkp-skl-d04&mac=3D64:00:6a:30:92:35&last_kernel=3D/pkg/linux/x86_64-rhe=
l-8.3/gcc-9/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/vmlinuz-5.10.0-rc3-011=
27-g8c3b1ba0e7ea&lkp_wtmp -O /tmp/next-job-lkp
[  154.935139]=20
[  160.893508] 22 blocks
[  160.893511]=20
[  160.895323] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp//lkp/jobs/scheduled/lkp-skl-d=
04/hwsim-group-22-ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-bcf876870b95=
592b52519ed4aafcf9d95999bc9c-20201226-1429-g4u7i0-0.cgz -O /tmp/next-job.cgz
[  160.897280]=20
[  160.939474] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-wtmp?tbox_name=3D=
lkp-skl-d04&tbox_state=3Dkexec_to_next_job -O /dev/null
[  160.939476]=20
[  161.471655] downloading kernel image ...
[  161.471657]=20
[  161.502653] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-22-ucode=3D0xe2-de=
bian-10.4-x86_64-20200603.cgz-bcf876870b95592b52519ed4aafcf9d95999bc9c-2020=
1226-1429-g4u7i0-0.yaml&job_state=3Dwget_kernel -O /dev/null
[  161.502655]=20
[  162.154018] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/pkg/linux/x86_64-rhel-8.3/gcc=
-9/bcf876870b95592b52519ed4aafcf9d95999bc9c/vmlinuz-5.8.0 -N -P /opt/rootfs=
/tmp/pkg/linux/x86_64-rhel-8.3/gcc-9/bcf876870b95592b52519ed4aafcf9d95999bc=
9c
[  162.154021]=20
[  162.181728] downloading initrds ...
[  162.181730]=20
[  162.194272] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-22-ucode=3D0xe2-de=
bian-10.4-x86_64-20200603.cgz-bcf876870b95592b52519ed4aafcf9d95999bc9c-2020=
1226-1429-g4u7i0-0.yaml&job_state=3Dwget_initrd -O /dev/null
[  162.194274]=20
[  162.746326] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/debian/debian-10.4-x8=
6_64-20200603.cgz -N -P /opt/rootfs/tmp/osimage/debian
[  162.746329]=20
[  162.919387] /opt/rootfs/tmp/osimage/debian/debian-10.4-x86_64-20200603.c=
gz isn't modified
[  162.919390]=20
[  162.936434] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/lkp/jobs/scheduled/lkp-skl-d0=
4/hwsim-group-22-ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-bcf876870b955=
92b52519ed4aafcf9d95999bc9c-20201226-1429-g4u7i0-0.cgz -N -P /opt/rootfs/tm=
p/lkp/jobs/scheduled/lkp-skl-d04
[  162.936436]=20
[  162.936681] 22 blocks
[  162.966051]=20
[  162.968198] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/user/lkp/lkp-x86_64.c=
gz -N -P /opt/rootfs/tmp/osimage/user/lkp
[  162.969801]=20
[  162.988840] /opt/rootfs/tmp/osimage/user/lkp/lkp-x86_64.cgz isn't modifi=
ed
[  162.988841]=20
[  163.002717] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/deps/debian-10.4-x86_=
64-20200603.cgz/run-ipconfig_20200608.cgz -N -P /opt/rootfs/tmp/osimage/dep=
s/debian-10.4-x86_64-20200603.cgz
[  163.002719]=20
[  163.028313] /opt/rootfs/tmp/osimage/deps/debian-10.4-x86_64-20200603.cgz=
/run-ipconfig_20200608.cgz isn't modified
[  163.028314]=20
[  163.044992] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/deps/debian-10.4-x86_=
64-20200603.cgz/lkp_20201211.cgz -N -P /opt/rootfs/tmp/osimage/deps/debian-=
10.4-x86_64-20200603.cgz
[  163.044993]=20
[  163.069417] /opt/rootfs/tmp/osimage/deps/debian-10.4-x86_64-20200603.cgz=
/lkp_20201211.cgz isn't modified
[  163.069418]=20
[  163.085370] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/deps/debian-10.4-x86_=
64-20200603.cgz/rsync-rootfs_20200608.cgz -N -P /opt/rootfs/tmp/osimage/dep=
s/debian-10.4-x86_64-20200603.cgz
[  163.085371]=20
[  163.110809] /opt/rootfs/tmp/osimage/deps/debian-10.4-x86_64-20200603.cgz=
/rsync-rootfs_20200608.cgz isn't modified
[  163.110810]=20
[  163.127488] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/deps/debian-10.4-x86_=
64-20200603.cgz/hwsim_20201110.cgz -N -P /opt/rootfs/tmp/osimage/deps/debia=
n-10.4-x86_64-20200603.cgz
[  163.127489]=20
[  163.314539] /opt/rootfs/tmp/osimage/deps/debian-10.4-x86_64-20200603.cgz=
/hwsim_20201110.cgz isn't modified
[  163.314541]=20
[  163.331135] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/pkg/debian-10.4-x86_6=
4-20200603.cgz/hwsim-x86_64-537ab94-1_20201123.cgz -N -P /opt/rootfs/tmp/os=
image/pkg/debian-10.4-x86_64-20200603.cgz
[  163.331136]=20
[  163.357474] /opt/rootfs/tmp/osimage/pkg/debian-10.4-x86_64-20200603.cgz/=
hwsim-x86_64-537ab94-1_20201123.cgz isn't modified
[  163.357475]=20
[  163.375188] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/deps/debian-10.4-x86_=
64-20200603.cgz/hw_20200715.cgz -N -P /opt/rootfs/tmp/osimage/deps/debian-1=
0.4-x86_64-20200603.cgz
[  163.375189]=20
[  163.399666] /opt/rootfs/tmp/osimage/deps/debian-10.4-x86_64-20200603.cgz=
/hw_20200715.cgz isn't modified
[  163.399668]=20
[  163.417104] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/pkg/linux/x86_64-rhel-8.3/gcc=
-9/bcf876870b95592b52519ed4aafcf9d95999bc9c/modules.cgz -N -P /opt/rootfs/t=
mp/pkg/linux/x86_64-rhel-8.3/gcc-9/bcf876870b95592b52519ed4aafcf9d95999bc9c
[  163.417105]=20
[  163.679305] /opt/rootfs/tmp/pkg/linux/x86_64-rhel-8.3/gcc-9/bcf876870b95=
592b52519ed4aafcf9d95999bc9c/modules.cgz isn't modified
[  163.679308]=20
[  163.696313] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/ucode/intel-ucode-202=
01117.cgz -N -P /opt/rootfs/tmp/osimage/ucode
[  163.696315]=20
[  163.715750] /opt/rootfs/tmp/osimage/ucode/intel-ucode-20201117.cgz isn't=
 modified
[  163.715751]=20
[  164.604333] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-22-ucode=3D0xe2-de=
bian-10.4-x86_64-20200603.cgz-bcf876870b95592b52519ed4aafcf9d95999bc9c-2020=
1226-1429-g4u7i0-0.yaml&last_kernel=3D5.10.0-rc3-01127-g8c3b1ba0e7ea -O /de=
v/null
[  164.604335]=20
[  165.104519] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-22-ucode=3D0xe2-de=
bian-10.4-x86_64-20200603.cgz-bcf876870b95592b52519ed4aafcf9d95999bc9c-2020=
1226-1429-g4u7i0-0.yaml&job_state=3Dbooting -O /dev/null
[  165.104521]=20
[  165.663906] LKP: kexec loading...
[  165.663908]=20
[  165.672092] kexec --noefi -l /opt/rootfs/tmp/pkg/linux/x86_64-rhel-8.3/g=
cc-9/bcf876870b95592b52519ed4aafcf9d95999bc9c/vmlinuz-5.8.0 --initrd=3D/opt=
/rootfs/tmp/initrd-concatenated
[  165.672093]=20
[  168.641536] --append=3Dip=3D::::lkp-skl-d04::dhcp root=3D/dev/ram0 user=
=3Dlkp job=3D/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-22-ucode=3D0xe2-de=
bian-10.4-x86_64-20200603.cgz-bcf876870b95592b52519ed4aafcf9d95999bc9c-2020=
1226-1429-g4u7i0-0.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3 branch=3Din=
ternal-devel/devel-hourly-2020122418 commit=3Dbcf876870b95592b52519ed4aafcf=
9d95999bc9c BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/bcf876870b95592b5=
2519ed4aafcf9d95999bc9c/vmlinuz-5.8.0 max_uptime=3D2100 RESULT_ROOT=3D/resu=
lt/hwsim/group-22-ucode=3D0xe2/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/=
x86_64-rhel-8.3/gcc-9/bcf876870b95592b52519ed4aafcf9d95999bc9c/25 LKP_SERVE=
R=3Dinternal-lkp-server nokaslr selinux=3D0 debug apic=3Ddebug sysrq_always=
_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkms=
g=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic lo=
ad_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_lev
[  168.641539]=20
LKP: rebooting
[  169.708755] e1000e 0000:00:1f.6 eth0: NIC Link is Down
[  169.713966] kvm: exiting hardware virtualization
[  169.718708] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
[  169.723948] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  169.729419] e1000e: EEE TX LPI TIMER: 00000011
Starting new kernel
Decompressing Linux... Parsing ELF... No relocation needed... done.
Booting the kernel.
[    0.000000] Linux version 5.10.0-rc3-01127-g8c3b1ba0e7ea (kbuild@ef0b816=
f83ac) (gcc-9 (Debian 9.3.0-15) 9.3.0, GNU ld (GNU Binutils for Debian) 2.3=
5) #1 SMP Thu Dec 24 12:43:54 CST 2020
APPEND dmesg: /result/perf-sanity-tests/gcc-ucode=3D0xe2/lkp-skl-d04/debian=
-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0ee4b4445e=
a59c806787813/5/dmesg already exists
[    0.000000] Command line: ip=3D::::lkp-skl-d04::dhcp root=3D/dev/ram0 us=
er=3Dlkp job=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=
=3D0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c8067=
87813-20201226-25066-sfkgan-4.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3 =
branch=3Ddrm-intel/drm-intel-gt-next commit=3D8c3b1ba0e7ea9a80b0ee4b4445ea5=
9c806787813 BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b=
0ee4b4445ea59c806787813/vmlinuz-5.10.0-rc3-01127-g8c3b1ba0e7ea max_uptime=
=3D2100 RESULT_ROOT=3D/result/perf-sanity-tests/gcc-ucode=3D0xe2/lkp-skl-d0=
4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0e=
e4b4445ea59c806787813/5 LKP_SERVER=3Dinternal-lkp-server nokaslr selinux=3D=
0 debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D=
100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi=
_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.min=
or_count=3D8 systemd.log_level=3Derr ignore_loglevel console=3Dtty0 earlypr=
intk=3DttyS0,11
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registe=
rs'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 b=
ytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000100-0x000000000009c7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009c800-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007caa5fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007caa6000-0x000000007caa6fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000007caa7000-0x000000007cad0fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007cad1000-0x000000007cb22fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007cb23000-0x000000007d323fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007d324000-0x0000000086f56fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000086f57000-0x00000000872bcfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000872bd000-0x0000000087309fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000008730a000-0x0000000087abefff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000087abf000-0x0000000087ffefff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000087fff000-0x0000000087ffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000871ffffff] usable
[    0.000000] printk: debug: ignoring loglevel setting.
[    0.000000] printk: bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
[    0.000000] tsc: Detected 3200.000 MHz processor
[    0.000000] tsc: Detected 3199.980 MHz TSC
[    0.000624] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.011117] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.016616] last_pfn =3D 0x872000 max_arch_pfn =3D 0x400000000
[    0.022022] MTRR default type: write-back
[    0.025970] MTRR fixed ranges enabled:
[    0.029660]   00000-9FFFF write-back
[    0.033182]   A0000-BFFFF uncachable
[    0.036700]   C0000-FFFFF write-protect
[    0.040479] MTRR variable ranges enabled:
[    0.044427]   0 base 00C0000000 mask 7FC0000000 uncachable
[    0.049836]   1 base 00A0000000 mask 7FE0000000 uncachable
[    0.055245]   2 base 0090000000 mask 7FF0000000 uncachable
[    0.060653]   3 base 008C000000 mask 7FFC000000 uncachable
[    0.066062]   4 base 008A000000 mask 7FFE000000 uncachable
[    0.071470]   5 base 0089800000 mask 7FFF800000 uncachable
[    0.076878]   6 disabled
[    0.079366]   7 disabled
[    0.081858]   8 disabled
[    0.084347]   9 disabled
[    0.087123] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.094209] last_pfn =3D 0x88000 max_arch_pfn =3D 0x400000000
[    0.099411] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.104574] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.109724] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.120345] found SMP MP-table at [mem 0x000fcde0-0x000fcdef]
[    0.125856]   mpc: fcbb0-fcd5c
[    0.128871] Using GB pages for direct mapping
[    0.133596] RAMDISK: [mem 0x83bb72000-0x86ebfffff]
[    0.138166] ACPI: Early table checksum verification disabled
[    0.143742] ACPI: RSDP 0x00000000000F05B0 000024 (v02 DELL  )
[    0.149407] ACPI: XSDT 0x00000000872DD0A0 0000C4 (v01 DELL   CBX3     01=
072009 AMI  00010013)
[    0.157819] ACPI: FACP 0x00000000872FE7C0 00010C (v05 DELL   CBX3     01=
072009 AMI  00010013)
[    0.166241] ACPI: DSDT 0x00000000872DD1F8 0215C8 (v02 DELL   CBX3     01=
072009 INTL 20120913)
[    0.174667] ACPI: FACS 0x0000000087ABEF80 000040
[    0.179223] ACPI: APIC 0x00000000872FE8D0 000084 (v03 DELL   CBX3     01=
072009 AMI  00010013)
[    0.187652] ACPI: FPDT 0x00000000872FE958 000044 (v01 DELL   CBX3     01=
072009 AMI  00010013)
[    0.196067] ACPI: FIDT 0x00000000872FE9A0 00009C (v01 DELL   CBX3     01=
072009 AMI  00010013)
[    0.204480] ACPI: MCFG 0x00000000872FEA40 00003C (v01 DELL   CBX3     01=
072009 MSFT 00000097)
[    0.212893] ACPI: HPET 0x00000000872FEA80 000038 (v01 DELL   CBX3     01=
072009 AMI. 0005000B)
[    0.221308] ACPI: SSDT 0x00000000872FEAB8 00036D (v01 SataRe SataTabl 00=
001000 INTL 20120913)
[    0.229722] ACPI: SSDT 0x00000000872FEE28 0053B2 (v02 SaSsdt SaSsdt   00=
003000 INTL 20120913)
[    0.238135] ACPI: UEFI 0x00000000873041E0 000042 (v01                 00=
000000      00000000)
[    0.246551] ACPI: LPIT 0x0000000087304228 000094 (v01 INTEL  SKL      00=
000000 MSFT 0000005F)
[    0.254962] ACPI: SSDT 0x00000000873042C0 000248 (v02 INTEL  sensrhub 00=
000000 INTL 20120913)
[    0.263376] ACPI: SSDT 0x0000000087304508 002BAE (v02 INTEL  PtidDevc 00=
001000 INTL 20120913)
[    0.271790] ACPI: SSDT 0x00000000873070B8 000C45 (v02 INTEL  Ther_Rvp 00=
001000 INTL 20120913)
[    0.280203] ACPI: DBGP 0x0000000087307D00 000034 (v01 INTEL           00=
000000 MSFT 0000005F)
[    0.288616] ACPI: DBG2 0x0000000087307D38 000054 (v00 INTEL           00=
000000 MSFT 0000005F)
[    0.297030] ACPI: SSDT 0x0000000087307D90 000613 (v02 INTEL  DELL__MT 00=
000000 INTL 20120913)
[    0.305442] ACPI: SSDT 0x00000000873083A8 000E58 (v02 CpuRef CpuSsdt  00=
003000 INTL 20120913)
[    0.313855] ACPI: SLIC 0x0000000087309200 000176 (v03 DELL   CBX3     01=
072009 MSFT 00010013)
[    0.322268] ACPI: DMAR 0x0000000087309378 0000A8 (v01 INTEL  SKL      00=
000001 INTL 00000001)
[    0.330680] ACPI: ASF! 0x0000000087309420 0000A5 (v32 INTEL   HCG     00=
000001 TFSM 000F4240)
[    0.339098] ACPI: Local APIC address 0xfee00000
[    0.343561] mapped APIC to ffffffffff5fc000 (        fee00000)
[    0.349448] No NUMA configuration found
[    0.353087] Faking a node at [mem 0x0000000000000000-0x0000000871ffffff]
[    0.359703] NODE_DATA(0) allocated [mem 0x871fd5000-0x871ffffff]
[    0.365823] cma: Reserved 200 MiB at 0x000000082f000000
[    0.370848] Zone ranges:
[    0.373309]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.379406]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.385502]   Normal   [mem 0x0000000100000000-0x0000000871ffffff]
[    0.391598]   Device   empty
[    0.394431] Movable zone start for each node
[    0.398642] Early memory node ranges
[    0.402167]   node   0: [mem 0x0000000000001000-0x000000000009bfff]
[    0.408358]   node   0: [mem 0x0000000000100000-0x000000007caa5fff]
[    0.414549]   node   0: [mem 0x000000007cad1000-0x000000007cb22fff]
[    0.420740]   node   0: [mem 0x000000007d324000-0x0000000086f56fff]
[    0.426931]   node   0: [mem 0x0000000087fff000-0x0000000087ffffff]
[    0.433113]   node   0: [mem 0x0000000100000000-0x0000000871ffffff]
[    0.439535] Zeroed struct page in unavailable ranges: 31033 pages
[    0.439536] Initmem setup node 0 [mem 0x0000000000001000-0x0000000871fff=
fff]
[    0.452347] On node 0 totalpages: 8357575
[    0.456294]   DMA zone: 64 pages used for memmap
[    0.460845]   DMA zone: 21 pages reserved
[    0.464795]   DMA zone: 3995 pages, LIFO batch:0
[    0.469371]   DMA32 zone: 8541 pages used for memmap
[    0.474239]   DMA32 zone: 546604 pages, LIFO batch:63
[    0.482815]   Normal zone: 121984 pages used for memmap
[    0.487811]   Normal zone: 7806976 pages, LIFO batch:63
[    0.493193] Reserving Intel graphics memory at [mem 0x8a000000-0x8bfffff=
f]
[    0.500003] ACPI: PM-Timer IO Port: 0x1808
[    0.503883] ACPI: Local APIC address 0xfee00000
[    0.508349] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.514184] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.520023] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.525859] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.531722] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.538565] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.544832] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 2, APIC =
INT 02
[    0.551957] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.558481] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 2, APIC =
INT 09
[    0.565606] ACPI: IRQ0 used by override.
[    0.569471] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 2, APIC =
INT 01
[    0.576596] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 2, APIC =
INT 03
[    0.583719] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 2, APIC =
INT 04
[    0.590847] Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 2, APIC =
INT 05
[    0.597971] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 2, APIC =
INT 06
[    0.605095] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 2, APIC =
INT 07
[    0.612221] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 2, APIC =
INT 08
[    0.619344] ACPI: IRQ9 used by override.
[    0.623208] Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 2, APIC =
INT 0a
[    0.630335] Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 2, APIC =
INT 0b
[    0.637463] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 2, APIC =
INT 0c
[    0.644601] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 2, APIC =
INT 0d
[    0.651740] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 2, APIC =
INT 0e
[    0.658878] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 2, APIC =
INT 0f
[    0.666016] Using ACPI (MADT) for SMP configuration information
[    0.671855] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.676922] TSC deadline timer available
[    0.680786] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.685682] mapped IOAPIC to ffffffffff5fb000 (fec00000)
[    0.690927] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.698389] PM: hibernation: Registered nosave memory: [mem 0x0009c000-0=
x0009cfff]
[    0.705859] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0=
x0009ffff]
[    0.713329] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000dffff]
[    0.720799] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0=
x000fffff]
[    0.728269] PM: hibernation: Registered nosave memory: [mem 0x7caa6000-0=
x7caa6fff]
[    0.735739] PM: hibernation: Registered nosave memory: [mem 0x7caa7000-0=
x7cad0fff]
[    0.743209] PM: hibernation: Registered nosave memory: [mem 0x7cb23000-0=
x7d323fff]
[    0.750677] PM: hibernation: Registered nosave memory: [mem 0x86f57000-0=
x872bcfff]
[    0.758146] PM: hibernation: Registered nosave memory: [mem 0x872bd000-0=
x87309fff]
[    0.765617] PM: hibernation: Registered nosave memory: [mem 0x8730a000-0=
x87abefff]
[    0.773085] PM: hibernation: Registered nosave memory: [mem 0x87abf000-0=
x87ffefff]
[    0.780554] PM: hibernation: Registered nosave memory: [mem 0x88000000-0=
x89ffffff]
[    0.788022] PM: hibernation: Registered nosave memory: [mem 0x8a000000-0=
x8bffffff]
[    0.795492] PM: hibernation: Registered nosave memory: [mem 0x8c000000-0=
xdfffffff]
[    0.802962] PM: hibernation: Registered nosave memory: [mem 0xe0000000-0=
xefffffff]
[    0.810432] PM: hibernation: Registered nosave memory: [mem 0xf0000000-0=
xfdffffff]
[    0.817902] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0=
xfe010fff]
[    0.825374] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0=
xfebfffff]
[    0.832843] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0=
xfec00fff]
[    0.840313] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0=
xfedfffff]
[    0.847783] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0=
xfee00fff]
[    0.855255] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0=
xfeffffff]
[    0.862724] PM: hibernation: Registered nosave memory: [mem 0xff000000-0=
xffffffff]
[    0.870195] [mem 0x8c000000-0xdfffffff] available for PCI devices
[    0.876209] Booting paravirtualized kernel on bare hardware
[    0.881714] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 1910969940391419 ns
[    0.896167] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr=
_node_ids:1
[    0.903683] percpu: Embedded 55 pages/cpu s188416 r8192 d28672 u524288
[    0.910023] pcpu-alloc: s188416 r8192 d28672 u524288 alloc=3D1*2097152
[    0.916288] pcpu-alloc: [0] 0 1 2 3=20
[    0.919825] Built 1 zonelists, mobility grouping on.  Total pages: 82269=
65
[    0.926593] Policy zone: Normal
[    0.929685] Kernel command line: ip=3D::::lkp-skl-d04::dhcp root=3D/dev/=
ram0 user=3Dlkp job=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc=
-ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea5=
9c806787813-20201226-25066-sfkgan-4.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhe=
l-8.3 branch=3Ddrm-intel/drm-intel-gt-next commit=3D8c3b1ba0e7ea9a80b0ee4b4=
445ea59c806787813 BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7e=
a9a80b0ee4b4445ea59c806787813/vmlinuz-5.10.0-rc3-01127-g8c3b1ba0e7ea max_up=
time=3D2100 RESULT_ROOT=3D/result/perf-sanity-tests/gcc-ucode=3D0xe2/lkp-sk=
l-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a8=
0b0ee4b4445ea59c806787813/5 LKP_SERVER=3Dinternal-lkp-server nokaslr selinu=
x=3D0 debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeou=
t=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1=
 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd=
=2Eminor_count=3D8 systemd.log_level=3Derr ignore_loglevel console=3Dtty0 e=
arlyprintk=3Dt
[    0.929897] sysrq: sysrq always enabled.
[    1.020059] ignoring the deprecated load_ramdisk=3D option
[    1.026451] Dentry cache hash table entries: 4194304 (order: 13, 3355443=
2 bytes, linear)
[    1.034851] Inode-cache hash table entries: 2097152 (order: 12, 16777216=
 bytes, linear)
[    1.042627] mem auto-init: stack:off, heap alloc:off, heap free:off
[    1.072392] Memory: 2267592K/33430300K available (14347K kernel code, 61=
42K rwdata, 4812K rodata, 2432K init, 5268K bss, 1517728K reserved, 204800K=
 cma-reserved)
[    1.086516] random: get_random_u64 called from cache_random_seq_create+0=
x80/0x180 with crng_init=3D0
[    1.086564] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    1.101783] Kernel/User page tables isolation: enabled
[    1.106850] ftrace: allocating 45690 entries in 179 pages
[    1.124398] ftrace: allocated 179 pages with 5 groups
[    1.129287] rcu: Hierarchical RCU implementation.
[    1.133876] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D4.
[    1.140584] 	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_ti=
meout).
[    1.147797] 	Trampoline variant of Tasks RCU enabled.
[    1.152778] 	Rude variant of Tasks RCU enabled.
[    1.157243] 	Tracing variant of Tasks RCU enabled.
[    1.161967] rcu: RCU calculated value of scheduler-enlistment delay is 1=
00 jiffies.
[    1.169521] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D4
[    1.178909] NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs: 16
[    1.187148] Console: colour VGA+ 80x25
[    1.218889] printk: console [tty0] enabled
[    1.222902] printk: console [ttyS0] enabled
[    1.222902] printk: console [ttyS0] enabled
[    1.231135] printk: bootconsole [earlyser0] disabled
[    1.231135] printk: bootconsole [earlyser0] disabled
[    1.240941] ACPI: Core revision 20200925
[    1.245163] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 79635855245 ns
[    1.254313] APIC: Switch to symmetric I/O mode setup
[    1.259361] DMAR: Host address width 39
[    1.263293] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    1.268689] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660=
462 ecap 7e3ff0505e
[    1.277114] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    1.282510] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c406604=
62 ecap f050da
[    1.290504] DMAR: RMRR base: 0x0000008715f000 end: 0x0000008717efff
[    1.296843] DMAR: RMRR base: 0x00000089800000 end: 0x0000008bffffff
[    1.303186] DMAR: [Firmware Bug]: No firmware reserved region can cover =
this RMRR [0x0000000089800000-0x000000008bffffff], contact BIOS vendor for =
fixes
[    1.316860] DMAR: [Firmware Bug]: Your BIOS is broken; bad RMRR [0x00000=
00089800000-0x000000008bffffff]
[    1.316860] BIOS vendor: Dell Inc.; Ver: 1.1.1; Product Version:=20
[    1.332361] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    1.338786] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    1.344266] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out=
 bit.
[    1.344266] DMAR-IR: Use 'intremap=3Dno_x2apic_optout' to override the B=
IOS setting.
[    1.359239] DMAR-IR: IRQ remapping was enabled on dmar0 but we are not i=
n kdump mode
[    1.367186] DMAR-IR: IRQ remapping was enabled on dmar1 but we are not i=
n kdump mode
[    1.376246] DMAR-IR: Enabled IRQ remapping in xapic mode
[    1.381617] x2apic: IRQ remapping doesn't support X2APIC mode
[    1.387450] masked ExtINT on CPU#0
[    1.394676] ENABLING IO-APIC IRQs
[    1.398064] init IO_APIC IRQs
[    1.401108]  apic 2 pin 0 not connected
[    1.405015] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.418495] IOAPIC[0]: Set routing entry (2-1 -> 0xef -> IRQ 1 Mode:0 Ac=
tive:0 Dest:1)
[    1.426464] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:30 Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.439947] IOAPIC[0]: Set routing entry (2-2 -> 0x30 -> IRQ 0 Mode:0 Ac=
tive:0 Dest:1)
[    1.447915] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.461398] IOAPIC[0]: Set routing entry (2-3 -> 0xef -> IRQ 3 Mode:0 Ac=
tive:0 Dest:1)
[    1.469368] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.482846] IOAPIC[0]: Set routing entry (2-4 -> 0xef -> IRQ 4 Mode:0 Ac=
tive:0 Dest:1)
[    1.490817] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.505098] IOAPIC[0]: Set routing entry (2-5 -> 0xef -> IRQ 5 Mode:0 Ac=
tive:0 Dest:1)
[    1.513067] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.526546] IOAPIC[0]: Set routing entry (2-6 -> 0xef -> IRQ 6 Mode:0 Ac=
tive:0 Dest:1)
[    1.534514] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.547997] IOAPIC[0]: Set routing entry (2-7 -> 0xef -> IRQ 7 Mode:0 Ac=
tive:0 Dest:1)
[    1.555966] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.569445] IOAPIC[0]: Set routing entry (2-8 -> 0xef -> IRQ 8 Mode:0 Ac=
tive:0 Dest:1)
[    1.577412] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.590897] IOAPIC[0]: Set routing entry (2-9 -> 0xef -> IRQ 9 Mode:1 Ac=
tive:0 Dest:1)
[    1.598880] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.612383] IOAPIC[0]: Set routing entry (2-10 -> 0xef -> IRQ 10 Mode:0 =
Active:0 Dest:1)
[    1.620530] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.634009] IOAPIC[0]: Set routing entry (2-11 -> 0xef -> IRQ 11 Mode:0 =
Active:0 Dest:1)
[    1.642149] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.655633] IOAPIC[0]: Set routing entry (2-12 -> 0xef -> IRQ 12 Mode:0 =
Active:0 Dest:1)
[    1.663775] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.677257] IOAPIC[0]: Set routing entry (2-13 -> 0xef -> IRQ 13 Mode:0 =
Active:0 Dest:1)
[    1.685400] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.698886] IOAPIC[0]: Set routing entry (2-14 -> 0xef -> IRQ 14 Mode:0 =
Active:0 Dest:1)
[    1.707028] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.720511] IOAPIC[0]: Set routing entry (2-15 -> 0xef -> IRQ 15 Mode:0 =
Active:0 Dest:1)
[    1.728653]  apic 2 pin 16 not connected
[    1.732645]  apic 2 pin 17 not connected
[    1.736634]  apic 2 pin 18 not connected
[    1.740625]  apic 2 pin 19 not connected
[    1.744615]  apic 2 pin 20 not connected
[    1.748605]  apic 2 pin 21 not connected
[    1.752595]  apic 2 pin 22 not connected
[    1.756585]  apic 2 pin 23 not connected
[    1.760575]  apic 2 pin 24 not connected
[    1.764564]  apic 2 pin 25 not connected
[    1.768554]  apic 2 pin 26 not connected
[    1.772544]  apic 2 pin 27 not connected
[    1.776535]  apic 2 pin 28 not connected
[    1.780526]  apic 2 pin 29 not connected
[    1.784515]  apic 2 pin 30 not connected
[    1.788506]  apic 2 pin 31 not connected
[    1.792494]  apic 2 pin 32 not connected
[    1.796485]  apic 2 pin 33 not connected
[    1.800475]  apic 2 pin 34 not connected
[    1.804466]  apic 2 pin 35 not connected
[    1.808458]  apic 2 pin 36 not connected
[    1.812450]  apic 2 pin 37 not connected
[    1.816440]  apic 2 pin 38 not connected
[    1.820431]  apic 2 pin 39 not connected
[    1.824422]  apic 2 pin 40 not connected
[    1.828419]  apic 2 pin 41 not connected
[    1.832417]  apic 2 pin 42 not connected
[    1.836411]  apic 2 pin 43 not connected
[    1.840408]  apic 2 pin 44 not connected
[    1.844403]  apic 2 pin 45 not connected
[    1.848401]  apic 2 pin 46 not connected
[    1.852400]  apic 2 pin 47 not connected
[    1.856392]  apic 2 pin 48 not connected
[    1.860383]  apic 2 pin 49 not connected
[    1.864374]  apic 2 pin 50 not connected
[    1.868365]  apic 2 pin 51 not connected
[    1.872354]  apic 2 pin 52 not connected
[    1.876343]  apic 2 pin 53 not connected
[    1.880333]  apic 2 pin 54 not connected
[    1.884324]  apic 2 pin 55 not connected
[    1.888314]  apic 2 pin 56 not connected
[    1.892306]  apic 2 pin 57 not connected
[    1.896297]  apic 2 pin 58 not connected
[    1.900287]  apic 2 pin 59 not connected
[    1.904278]  apic 2 pin 60 not connected
[    1.908268]  apic 2 pin 61 not connected
[    1.912260]  apic 2 pin 62 not connected
[    1.916250]  apic 2 pin 63 not connected
[    1.920239]  apic 2 pin 64 not connected
[    1.924228]  apic 2 pin 65 not connected
[    1.928220]  apic 2 pin 66 not connected
[    1.932209]  apic 2 pin 67 not connected
[    1.936201]  apic 2 pin 68 not connected
[    1.940190]  apic 2 pin 69 not connected
[    1.944179]  apic 2 pin 70 not connected
[    1.948169]  apic 2 pin 71 not connected
[    1.952159]  apic 2 pin 72 not connected
[    1.956150]  apic 2 pin 73 not connected
[    1.960142]  apic 2 pin 74 not connected
[    1.964133]  apic 2 pin 75 not connected
[    1.968123]  apic 2 pin 76 not connected
[    1.972113]  apic 2 pin 77 not connected
[    1.976104]  apic 2 pin 78 not connected
[    1.980095]  apic 2 pin 79 not connected
[    1.984085]  apic 2 pin 80 not connected
[    1.988075]  apic 2 pin 81 not connected
[    1.992064]  apic 2 pin 82 not connected
[    1.996054]  apic 2 pin 83 not connected
[    2.000045]  apic 2 pin 84 not connected
[    2.004035]  apic 2 pin 85 not connected
[    2.008026]  apic 2 pin 86 not connected
[    2.012017]  apic 2 pin 87 not connected
[    2.016008]  apic 2 pin 88 not connected
[    2.019999]  apic 2 pin 89 not connected
[    2.023988]  apic 2 pin 90 not connected
[    2.027978]  apic 2 pin 91 not connected
[    2.031967]  apic 2 pin 92 not connected
[    2.035956]  apic 2 pin 93 not connected
[    2.039947]  apic 2 pin 94 not connected
[    2.043937]  apic 2 pin 95 not connected
[    2.047926]  apic 2 pin 96 not connected
[    2.051916]  apic 2 pin 97 not connected
[    2.055908]  apic 2 pin 98 not connected
[    2.059899]  apic 2 pin 99 not connected
[    2.063893]  apic 2 pin 100 not connected
[    2.067977]  apic 2 pin 101 not connected
[    2.072056]  apic 2 pin 102 not connected
[    2.076141]  apic 2 pin 103 not connected
[    2.080225]  apic 2 pin 104 not connected
[    2.084305]  apic 2 pin 105 not connected
[    2.088390]  apic 2 pin 106 not connected
[    2.092470]  apic 2 pin 107 not connected
[    2.096546]  apic 2 pin 108 not connected
[    2.100622]  apic 2 pin 109 not connected
[    2.104700]  apic 2 pin 110 not connected
[    2.108777]  apic 2 pin 111 not connected
[    2.112853]  apic 2 pin 112 not connected
[    2.116929]  apic 2 pin 113 not connected
[    2.121004]  apic 2 pin 114 not connected
[    2.125082]  apic 2 pin 115 not connected
[    2.129158]  apic 2 pin 116 not connected
[    2.133236]  apic 2 pin 117 not connected
[    2.137311]  apic 2 pin 118 not connected
[    2.141387]  apic 2 pin 119 not connected
[    2.145619] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    2.155996] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x2e2036ff8d5, max_idle_ns: 440795275316 ns
[    2.166546] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 6399.96 BogoMIPS (lpj=3D3199980)
[    2.167545] pid_max: default: 32768 minimum: 301
[    2.168563] LSM: Security Framework initializing
[    2.169551] Yama: becoming mindful.
[    2.170560] AppArmor: AppArmor initialized
[    2.171586] Mount-cache hash table entries: 65536 (order: 7, 524288 byte=
s, linear)
[    2.172583] Mountpoint-cache hash table entries: 65536 (order: 7, 524288=
 bytes, linear)
Poking KASLR using RDRAND RDTSC...
[    2.176877] mce: CPU0: Thermal monitoring enabled (TM1)
[    2.177557] process: using mwait in idle threads
[    2.178546] Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
[    2.180545] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    2.181547] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    2.182547] Spectre V2 : Mitigation: Full generic retpoline
[    2.183545] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    2.184545] Spectre V2 : Enabling Restricted Speculation for firmware ca=
lls
[    2.185547] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    2.186547] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl and seccomp
[    2.187546] TAA: Mitigation: Clear CPU buffers
[    2.188546] SRBDS: Mitigation: Microcode
[    2.189545] MDS: Mitigation: Clear CPU buffers
[    2.191571] Freeing SMP alternatives memory: 40K
[    2.194021] smpboot: CPU0: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (fami=
ly: 0x6, model: 0x5e, stepping: 0x3)
[    2.194604] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR,=
 full-width counters, Broken BIOS detected, complain to your hardware vendo=
r.
[    2.195546] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR=
 189 is 100430000)
[    2.196545] Intel PMU driver.
[    2.196546] ... version:                4
[    2.198545] ... bit width:              48
[    2.199545] ... generic registers:      8
[    2.200545] ... value mask:             0000ffffffffffff
[    2.201545] ... max period:             00007fffffffffff
[    2.202545] ... fixed-purpose events:   3
[    2.203545] ... event mask:             00000007000000ff
[    2.204624] rcu: Hierarchical SRCU implementation.
[    2.205976] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    2.206580] smp: Bringing up secondary CPUs ...
[    2.207597] x86: Booting SMP configuration:
[    2.208547] .... node  #0, CPUs:      #1
[    0.957511] masked ExtINT on CPU#1
[    2.216193]  #2
[    0.957511] masked ExtINT on CPU#2
[    2.221803]  #3
[    0.957511] masked ExtINT on CPU#3
[    2.227295] smp: Brought up 1 node, 4 CPUs
[    2.227546] smpboot: Max logical packages: 1
[    2.228546] smpboot: Total of 4 processors activated (25599.84 BogoMIPS)
[    2.262668] node 0 deferred pages initialised in 33ms
[    2.268941] devtmpfs: initialized
[    2.269575] x86/mm: Memory block size: 128MB
[    2.272046] PM: Registering ACPI NVS region [mem 0x7caa6000-0x7caa6fff] =
(4096 bytes)
[    2.272547] PM: Registering ACPI NVS region [mem 0x8730a000-0x87abefff] =
(8081408 bytes)
[    2.273670] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 1911260446275000 ns
[    2.274548] futex hash table entries: 1024 (order: 4, 65536 bytes, linea=
r)
[    2.276010] pinctrl core: initialized pinctrl subsystem
[    2.276639] NET: Registered protocol family 16
[    2.277713] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic alloca=
tions
[    2.278553] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    2.279551] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    2.280550] audit: initializing netlink subsys (disabled)
[    2.281552] audit: type=3D2000 audit(1608913432.140:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    2.281605] thermal_sys: Registered thermal governor 'fair_share'
[    2.282546] thermal_sys: Registered thermal governor 'bang_bang'
[    2.283545] thermal_sys: Registered thermal governor 'step_wise'
[    2.284545] thermal_sys: Registered thermal governor 'user_space'
[    2.285550] cpuidle: using governor menu
[    2.287651] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    2.288546] ACPI: bus type PCI registered
[    2.289545] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    2.290593] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    2.291547] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    2.292555] PCI: Using configuration type 1 for base access
[    2.294888] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    2.295546] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    2.296561] cryptd: max_cpu_qlen set to 1000
[    2.297582] ACPI: Added _OSI(Module Device)
[    2.298546] ACPI: Added _OSI(Processor Device)
[    2.306547] ACPI: Added _OSI(3.0 _SCP Extensions)
[    2.311545] ACPI: Added _OSI(Processor Aggregator Device)
[    2.316547] ACPI: Added _OSI(Linux-Dell-Video)
[    2.317549] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    2.318546] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    2.346028] ACPI: 8 ACPI AML tables successfully acquired and loaded
[    2.348354] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    2.351306] ACPI: Dynamic OEM Table Load:
[    2.351549] ACPI: SSDT 0xFFFF888100CB2800 0006A2 (v02 PmRef  Cpu0Ist  00=
003000 INTL 20120913)
[    2.353458] ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
[    2.354717] ACPI: Dynamic OEM Table Load:
[    2.355548] ACPI: SSDT 0xFFFF8888714EB800 00037F (v02 PmRef  Cpu0Cst  00=
003001 INTL 20120913)
[    2.357423] ACPI: Dynamic OEM Table Load:
[    2.357547] ACPI: SSDT 0xFFFF888871CFA6C0 00008E (v02 PmRef  Cpu0Hwp  00=
003000 INTL 20120913)
[    2.359339] ACPI: Dynamic OEM Table Load:
[    2.359547] ACPI: SSDT 0xFFFF88887158FC00 000130 (v02 PmRef  HwpLvt   00=
003000 INTL 20120913)
[    2.361727] ACPI: Dynamic OEM Table Load:
[    2.362548] ACPI: SSDT 0xFFFF888100CB3800 0005AA (v02 PmRef  ApIst    00=
003000 INTL 20120913)
[    2.364580] ACPI: Dynamic OEM Table Load:
[    2.365547] ACPI: SSDT 0xFFFF88887158F400 000119 (v02 PmRef  ApHwp    00=
003000 INTL 20120913)
[    2.367406] ACPI: Dynamic OEM Table Load:
[    2.367547] ACPI: SSDT 0xFFFF88887158E800 000119 (v02 PmRef  ApCst    00=
003000 INTL 20120913)
[    2.371494] ACPI: Interpreter enabled
[    2.371576] ACPI: (supports S0 S3 S4 S5)
[    2.372545] ACPI: Using IOAPIC for interrupt routing
[    2.373573] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    2.375210] ACPI: Enabled 7 GPEs in block 00 to 7F
[    2.377310] ACPI: Power Resource [PG00] (on)
[    2.377840] ACPI: Power Resource [PG01] (on)
[    2.378819] ACPI: Power Resource [PG02] (on)
[    2.381374] ACPI: Power Resource [WRST] (off)
[    2.381787] ACPI: Power Resource [WRST] (off)
[    2.382788] ACPI: Power Resource [WRST] (off)
[    2.383785] ACPI: Power Resource [WRST] (off)
[    2.384784] ACPI: Power Resource [WRST] (off)
[    2.385789] ACPI: Power Resource [WRST] (off)
[    2.386784] ACPI: Power Resource [WRST] (off)
[    2.387791] ACPI: Power Resource [WRST] (off)
[    2.388790] ACPI: Power Resource [WRST] (off)
[    2.389784] ACPI: Power Resource [WRST] (off)
[    2.390785] ACPI: Power Resource [WRST] (off)
[    2.391784] ACPI: Power Resource [WRST] (off)
[    2.392785] ACPI: Power Resource [WRST] (off)
[    2.393784] ACPI: Power Resource [WRST] (off)
[    2.394783] ACPI: Power Resource [WRST] (off)
[    2.395783] ACPI: Power Resource [WRST] (off)
[    2.396783] ACPI: Power Resource [WRST] (off)
[    2.397784] ACPI: Power Resource [WRST] (off)
[    2.398790] ACPI: Power Resource [WRST] (off)
[    2.399787] ACPI: Power Resource [WRST] (off)
[    2.410318] ACPI: Power Resource [FN00] (off)
[    2.410592] ACPI: Power Resource [FN01] (off)
[    2.411590] ACPI: Power Resource [FN02] (off)
[    2.412589] ACPI: Power Resource [FN03] (off)
[    2.413590] ACPI: Power Resource [FN04] (off)
[    2.415345] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    2.415550] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    2.417777] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME AER PCIeCapability LTR]
[    2.418546] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    2.420044] PCI host bridge to bus 0000:00
[    2.420549] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    2.421571] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    2.422554] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    2.423546] pci_bus 0000:00: root bus resource [mem 0x8c000000-0xdffffff=
f window]
[    2.424550] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7ffff=
f window]
[    2.425546] pci_bus 0000:00: root bus resource [bus 00-fe]
[    2.426558] pci 0000:00:00.0: [8086:191f] type 00 class 0x060000
[    2.427802] pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
[    2.428581] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    2.429696] pci 0000:00:02.0: [8086:1912] type 00 class 0x030000
[    2.430552] pci 0000:00:02.0: reg 0x10: [mem 0xde000000-0xdeffffff 64bit]
[    2.431549] pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff 64bit=
 pref]
[    2.432548] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    2.433712] pci 0000:00:14.0: [8086:a12f] type 00 class 0x0c0330
[    2.434562] pci 0000:00:14.0: reg 0x10: [mem 0xdf030000-0xdf03ffff 64bit]
[    2.435605] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    2.436661] pci 0000:00:14.2: [8086:a131] type 00 class 0x118000
[    2.437561] pci 0000:00:14.2: reg 0x10: [mem 0xdf04e000-0xdf04efff 64bit]
[    2.438687] pci 0000:00:16.0: [8086:a13a] type 00 class 0x078000
[    2.439559] pci 0000:00:16.0: reg 0x10: [mem 0xdf04d000-0xdf04dfff 64bit]
[    2.440614] pci 0000:00:16.0: PME# supported from D3hot
[    2.441673] pci 0000:00:17.0: [8086:a102] type 00 class 0x010601
[    2.442555] pci 0000:00:17.0: reg 0x10: [mem 0xdf048000-0xdf049fff]
[    2.443550] pci 0000:00:17.0: reg 0x14: [mem 0xdf04c000-0xdf04c0ff]
[    2.444550] pci 0000:00:17.0: reg 0x18: [io  0xf090-0xf097]
[    2.445550] pci 0000:00:17.0: reg 0x1c: [io  0xf080-0xf083]
[    2.446550] pci 0000:00:17.0: reg 0x20: [io  0xf060-0xf07f]
[    2.447550] pci 0000:00:17.0: reg 0x24: [mem 0xdf04b000-0xdf04b7ff]
[    2.448579] pci 0000:00:17.0: PME# supported from D3hot
[    2.449664] pci 0000:00:1c.0: [8086:a110] type 01 class 0x060400
[    2.450605] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    2.451713] pci 0000:00:1f.0: [8086:a146] type 00 class 0x060100
[    2.452742] pci 0000:00:1f.2: [8086:a121] type 00 class 0x058000
[    2.453557] pci 0000:00:1f.2: reg 0x10: [mem 0xdf044000-0xdf047fff]
[    2.454695] pci 0000:00:1f.3: [8086:a170] type 00 class 0x040300
[    2.455565] pci 0000:00:1f.3: reg 0x10: [mem 0xdf040000-0xdf043fff 64bit]
[    2.456573] pci 0000:00:1f.3: reg 0x20: [mem 0xdf020000-0xdf02ffff 64bit]
[    2.457589] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    2.458708] pci 0000:00:1f.4: [8086:a123] type 00 class 0x0c0500
[    2.459600] pci 0000:00:1f.4: reg 0x10: [mem 0xdf04a000-0xdf04a0ff 64bit]
[    2.460613] pci 0000:00:1f.4: reg 0x20: [io  0xf040-0xf05f]
[    2.461730] pci 0000:00:1f.6: [8086:15b7] type 00 class 0x020000
[    2.462563] pci 0000:00:1f.6: reg 0x10: [mem 0xdf000000-0xdf01ffff]
[    2.463647] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    2.464673] pci 0000:00:01.0: PCI bridge to [bus 01]
[    2.465606] pci 0000:02:00.0: [104c:8240] type 01 class 0x060400
[    2.466679] pci 0000:02:00.0: supports D1 D2
[    2.467655] pci 0000:00:1c.0: PCI bridge to [bus 02-03]
[    2.468596] pci_bus 0000:03: extended config space not accessible
[    2.469609] pci 0000:02:00.0: PCI bridge to [bus 03]
[    2.472072] ACPI: PCI Interrupt Link [LNKA] (IRQs *7 12), disabled.
[    2.472581] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *10), disabled.
[    2.473579] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 *5), disabled.
[    2.474579] ACPI: PCI Interrupt Link [LNKD] (IRQs 6 *11), disabled.
[    2.475578] ACPI: PCI Interrupt Link [LNKE] (IRQs *7 11), disabled.
[    2.476578] ACPI: PCI Interrupt Link [LNKF] (IRQs *3 10), disabled.
[    2.477578] ACPI: PCI Interrupt Link [LNKG] (IRQs *4 5), disabled.
[    2.478578] ACPI: PCI Interrupt Link [LNKH] (IRQs 6 12) *11, disabled.
[    2.479931] iommu: Default domain type: Translated=20
[    2.480557] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    2.481544] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[    2.481547] pci 0000:00:02.0: vgaarb: bridge control possible
[    2.482545] vgaarb: loaded
[    2.483600] SCSI subsystem initialized
[    2.484556] ACPI: bus type USB registered
[    2.485554] usbcore: registered new interface driver usbfs
[    2.486549] usbcore: registered new interface driver hub
[    2.487555] usbcore: registered new device driver usb
[    2.488556] pps_core: LinuxPPS API ver. 1 registered
[    2.489545] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    2.490546] PTP clock support registered
[    2.491556] EDAC MC: Ver: 3.0.0
[    2.492641] NetLabel: Initializing
[    2.493546] NetLabel:  domain hash size =3D 128
[    2.494545] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    2.495556] NetLabel:  unlabeled traffic allowed by default
[    2.496545] PCI: Using ACPI for IRQ routing
[    2.525098] PCI: pci_cache_line_size set to 64 bytes
[    2.525585] e820: reserve RAM buffer [mem 0x0009c800-0x0009ffff]
[    2.526546] e820: reserve RAM buffer [mem 0x7caa6000-0x7fffffff]
[    2.527545] e820: reserve RAM buffer [mem 0x7cb23000-0x7fffffff]
[    2.528545] e820: reserve RAM buffer [mem 0x86f57000-0x87ffffff]
[    2.529546] e820: reserve RAM buffer [mem 0x872000000-0x873ffffff]
[    2.530662] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    2.531546] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    2.534554] clocksource: Switched to clocksource tsc-early
[    2.562347] VFS: Disk quotas dquot_6.6.0
[    2.566353] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    2.573341] AppArmor: AppArmor Filesystem Enabled
[    2.578119] pnp: PnP ACPI init
[    2.581432] system 00:00: [io  0x0a00-0x0a3f] has been reserved
[    2.587408] system 00:00: [io  0x0a40-0x0a7f] has been reserved
[    2.593382] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.600687] pnp 00:01: [dma 0 disabled]
[    2.604621] pnp 00:01: Plug and Play ACPI device, IDs PNP0501 (active)
[    2.611325] system 00:02: [io  0x0680-0x069f] has been reserved
[    2.617298] system 00:02: [io  0xffff] has been reserved
[    2.622667] system 00:02: [io  0xffff] has been reserved
[    2.628039] system 00:02: [io  0xffff] has been reserved
[    2.633408] system 00:02: [io  0x1800-0x18fe] has been reserved
[    2.639382] system 00:02: [io  0x164e-0x164f] has been reserved
[    2.645355] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.652252] system 00:03: [io  0x0800-0x087f] has been reserved
[    2.658228] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.665075] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    2.671671] system 00:05: [io  0x1854-0x1857] has been reserved
[    2.677644] system 00:05: Plug and Play ACPI device, IDs INT3f0d PNP0c02=
 (active)
[    2.685343] system 00:06: [mem 0xfed10000-0xfed17fff] has been reserved
[    2.692017] system 00:06: [mem 0xfed18000-0xfed18fff] has been reserved
[    2.698688] system 00:06: [mem 0xfed19000-0xfed19fff] has been reserved
[    2.705360] system 00:06: [mem 0xe0000000-0xefffffff] has been reserved
[    2.712034] system 00:06: [mem 0xfed20000-0xfed3ffff] has been reserved
[    2.718697] system 00:06: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    2.725702] system 00:06: [mem 0xfed45000-0xfed8ffff] has been reserved
[    2.732363] system 00:06: [mem 0xff000000-0xffffffff] has been reserved
[    2.739025] system 00:06: [mem 0xfee00000-0xfeefffff] could not be reser=
ved
[    2.746030] system 00:06: [mem 0xdffe0000-0xdfffffff] has been reserved
[    2.752691] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.759551] system 00:07: [mem 0xfd000000-0xfdabffff] has been reserved
[    2.766213] system 00:07: [mem 0xfdad0000-0xfdadffff] has been reserved
[    2.772873] system 00:07: [mem 0xfdb00000-0xfdffffff] has been reserved
[    2.779534] system 00:07: [mem 0xfe000000-0xfe01ffff] could not be reser=
ved
[    2.786537] system 00:07: [mem 0xfe036000-0xfe03bfff] has been reserved
[    2.793196] system 00:07: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    2.799857] system 00:07: [mem 0xfe410000-0xfe7fffff] has been reserved
[    2.806517] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.813571] system 00:08: [io  0xff00-0xfffe] has been reserved
[    2.819544] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.827189] system 00:09: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    2.833849] system 00:09: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    2.840509] system 00:09: [mem 0xfdac0000-0xfdacffff] has been reserved
[    2.847171] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.854635] pnp: PnP ACPI: found 10 devices
[    2.864140] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    2.873093] NET: Registered protocol family 2
[    2.877611] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6=
, 262144 bytes, linear)
[    2.886380] TCP established hash table entries: 262144 (order: 9, 209715=
2 bytes, linear)
[    2.894696] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes,=
 linear)
[    2.902230] TCP: Hash tables configured (established 262144 bind 65536)
[    2.908906] UDP hash table entries: 16384 (order: 7, 524288 bytes, linea=
r)
[    2.915868] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, =
linear)
[    2.923303] NET: Registered protocol family 1
[    2.927802] RPC: Registered named UNIX socket transport module.
[    2.933783] RPC: Registered udp transport module.
[    2.938558] RPC: Registered tcp transport module.
[    2.943330] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.949830] NET: Registered protocol family 44
[    2.954345] pci 0000:00:01.0: PCI bridge to [bus 01]
[    2.959378] pci 0000:02:00.0: PCI bridge to [bus 03]
[    2.964418] pci 0000:00:1c.0: PCI bridge to [bus 02-03]
[    2.969707] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    2.975939] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    2.982172] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    2.989090] pci_bus 0000:00: resource 7 [mem 0x8c000000-0xdfffffff windo=
w]
[    2.996009] pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff windo=
w]
[    3.003016] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    3.011498] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    3.024980] IOAPIC[0]: Set routing entry (2-18 -> 0xef -> IRQ 18 Mode:1 =
Active:1 Dest:1)
[    3.033208] pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x620 took 212=
74 usecs
[    3.040687] PCI: CLS 0 bytes, default 64
[    3.044701] Trying to unpack rootfs image as initramfs...
[   10.755007] Freeing initrd memory: 836152K
[   10.759205] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[   10.765692] software IO TLB: mapped [mem 0x0000000082f57000-0x0000000086=
f57000] (64MB)
[   10.774350] Initialise system trusted keyrings
[   10.778870] Key type blacklist registered
[   10.782975] workingset: timestamp_bits=3D36 max_order=3D23 bucket_order=
=3D0
[   10.790328] zbud: loaded
[   10.800104] NET: Registered protocol family 38
[   10.804615] Key type asymmetric registered
[   10.808780] Asymmetric key parser 'x509' registered
[   10.813723] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 247)
[   10.821196] io scheduler mq-deadline registered
[   10.825791] io scheduler kyber registered
[   10.829885] io scheduler bfq registered
[   10.833815] atomic64_test: passed for x86-64 platform with CX8 and with =
SSE
[   10.840952] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[   10.854433] IOAPIC[0]: Set routing entry (2-16 -> 0xef -> IRQ 16 Mode:1 =
Active:1 Dest:1)
[   10.862610] pcieport 0000:00:01.0: PME: Signaling with IRQ 122
[   10.868638] pcieport 0000:00:1c.0: PME: Signaling with IRQ 123
[   10.874561] pcieport 0000:00:1c.0: AER: enabled with IRQ 123
[   10.880350] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   10.887116] intel_idle: MWAIT substates: 0x142120
[   10.891885] intel_idle: v0.5.1 model 0x5E
[   10.896224] intel_idle: Local APIC timer is reliable in all C-states
[   10.902795] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input0
[   10.911224] ACPI: Sleep Button [SLPB]
[   10.914991] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input1
[   10.923402] ACPI: Power Button [PWRB]
[   10.927184] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input2
[   10.934668] ACPI: Power Button [PWRF]
[   10.939393] thermal LNXTHERM:00: registered as thermal_zone0
[   10.945110] ACPI: Thermal Zone [TZ00] (28 C)
[   10.949527] thermal LNXTHERM:01: registered as thermal_zone1
[   10.955241] ACPI: Thermal Zone [TZ01] (30 C)
[   10.959636] ERST DBG: ERST support is disabled.
[   10.964365] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   10.970755] 00:01: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[   10.978998] Non-volatile memory driver v1.3
[   10.983664] rdac: device handler registered
[   10.988046] hp_sw: device handler registered
[   10.992382] emc: device handler registered
[   10.996608] alua: device handler registered
[   11.000931] e1000: Intel(R) PRO/1000 Network Driver
[   11.005867] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   11.011681] e1000e: Intel(R) PRO/1000 Network Driver
[   11.016712] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   11.022795] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[   11.038757] IOAPIC[0]: Set routing entry (2-19 -> 0xef -> IRQ 19 Mode:1 =
Active:1 Dest:1)
[   11.046967] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) se=
t to dynamic conservative mode
[   11.286393] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered=
 PHC clock
[   11.359761] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 64:=
00:6a:30:92:35
[   11.367739] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connecti=
on
[   11.374763] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0=
FF
[   11.381695] igb: Intel(R) Gigabit Ethernet Network Driver
[   11.387151] igb: Copyright (c) 2007-2014 Intel Corporation.
[   11.392787] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
[   11.398930] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[   11.404956] i40e: Intel(R) Ethernet Connection XL710 Network Driver
[   11.411275] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
[   11.417249] usbcore: registered new interface driver r8152
[   11.422809] usbcore: registered new interface driver asix
[   11.428266] usbcore: registered new interface driver ax88179_178a
[   11.434552] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   11.441148] ehci-pci: EHCI PCI platform driver
[   11.445666] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   11.451911] ohci-pci: OHCI PCI platform driver
[   11.456424] uhci_hcd: USB Universal Host Controller Interface driver
[   11.462973] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[   11.476453] IOAPIC[0]: Set routing entry (2-18 -> 0xef -> IRQ 18 Mode:1 =
Active:1 Dest:1)
[   11.484636] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   11.490086] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[   11.498640] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
00 quirks 0x0000000001109810
[   11.507896] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[   11.514886] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.10
[   11.523201] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   11.530480] usb usb1: Product: xHCI Host Controller
[   11.535420] usb usb1: Manufacturer: Linux 5.10.0-rc3-01127-g8c3b1ba0e7ea=
 xhci-hcd
[   11.542958] usb usb1: SerialNumber: 0000:00:14.0
[   11.547851] hub 1-0:1.0: USB hub found
[   11.551729] hub 1-0:1.0: 16 ports detected
[   11.556711] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   11.562144] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[   11.569600] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[   11.575954] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.10
[   11.584280] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   11.591558] usb usb2: Product: xHCI Host Controller
[   11.596496] usb usb2: Manufacturer: Linux 5.10.0-rc3-01127-g8c3b1ba0e7ea=
 xhci-hcd
[   11.604033] usb usb2: SerialNumber: 0000:00:14.0
[   11.608927] hub 2-0:1.0: USB hub found
[   11.612778] hub 2-0:1.0: 10 ports detected
[   11.617313] usb: port power management may be unreliable
[   11.622891] i8042: PNP: No PS/2 controller found.
[   11.627739] mousedev: PS/2 mouse device common for all mice
[   11.633511] rtc_cmos 00:04: RTC can wake from S4
[   11.638839] rtc_cmos 00:04: registered as rtc0
[   11.643509] rtc_cmos 00:04: setting system clock to 2020-12-25T16:24:04 =
UTC (1608913444)
[   11.651660] rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram=
, hpet irqs
[   11.659516] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[   11.665458] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[   11.675002] i2c i2c-0: 4/4 memory slots populated (from DMI)
[   11.681232] i2c i2c-0: Successfully instantiated SPD at 0x50
[   11.687468] i2c i2c-0: Successfully instantiated SPD at 0x51
[   11.693715] i2c i2c-0: Successfully instantiated SPD at 0x52
[   11.699950] i2c i2c-0: Successfully instantiated SPD at 0x53
[   11.705717] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   11.711427] iTCO_wdt: Found a Intel PCH TCO device (Version=3D4, TCOBASE=
=3D0x0400)
[   11.719034] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[   11.725126] iTCO_vendor_support: vendor-support=3D0
[   11.729916] intel_pstate: Intel P-state driver initializing
[   11.736271] intel_pstate: HWP enabled
[   11.740240] hid: raw HID events driver (C) Jiri Kosina
[   11.745481] usbcore: registered new interface driver usbhid
[   11.751113] usbhid: USB HID core driver
[   11.755047] drop_monitor: Initializing network drop monitor service
[   11.761406] Initializing XFRM netlink socket
[   11.765807] NET: Registered protocol family 10
[   11.770514] Segment Routing with IPv6
[   11.774260] NET: Registered protocol family 17
[   11.778962] 9pnet: Installing 9P2000 support
[   11.783314] mpls_gso: MPLS GSO support
[   11.787762] microcode: sig=3D0x506e3, pf=3D0x2, revision=3D0xe2
[   11.793429] microcode: Microcode Update Driver: v2.2.
[   11.793446] IPI shorthand broadcast: enabled
[   11.803013] ... APIC ID:      00000000 (0)
[   11.804011] ... APIC VERSION: 01060015
[   11.804011] 000000000000000000000000000000000000000000000000000000000000=
0000
[   11.804011] 000000000000000000000000000000000000000000000000000000000000=
0000
[   11.804011] 000000000000000000000000000000000000000000000000000000000800=
1000
[   11.804011]=20
[   11.832284] number of MP IRQ sources: 15.
[   11.837596] tsc: Refined TSC clocksource calibration: 3192.000 MHz
[   11.837939] number of IO-APIC #2 registers: 120.
[   11.844174] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2e0=
2c4a121d, max_idle_ns: 440795236083 ns
[   11.848852] testing the IO APIC.......................
[   11.864099] IO APIC #2......
[   11.867057] .... register #00: 02000000
[   11.870964] .......    : physical APIC id: 02
[   11.875387] .......    : Delivery Type: 0
[   11.879467] .......    : LTS          : 0
[   11.883543] .... register #01: 00770020
[   11.887449] .......     : max redirection entries: 77
[   11.892561] .......     : PRQ implemented: 0
[   11.896895] .......     : IO APIC version: 20
[   11.901318] .... register #02: 00000000
[   11.905223] .......     : arbitration: 00
[   11.909302] .... IRQ redirection table:
[   11.913208] IOAPIC 0:
[   11.915574]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.923465]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.931357]  pin02, enabled , edge , high, V(02), IRR(0), S(0), remapped=
, I(0001),  Z(0)
[   11.939508]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.947400]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.955293]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.963197]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.971102]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.979008]  pin08, enabled , edge , high, V(08), IRR(0), S(0), remapped=
, I(0007),  Z(0)
[   11.987171]  pin09, enabled , level, high, V(09), IRR(0), S(0), remapped=
, I(0008),  Z(0)
[   11.995322]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.003217]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.011110]  pin0c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.019004]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.026897]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.034789]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.042683]  pin10, enabled , level, low , V(10), IRR(0), S(0), remapped=
, I(000F),  Z(0)
[   12.050833]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.058725]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.066618]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.074510]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.082403]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.090296]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.098187]  pin17, disabled, edge , high, V(00), IRR(0), S(0), remapped=
, I(0000),  Z(2)
[   12.106337]  pin18, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.114230]  pin19, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.122123]  pin1a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.130015]  pin1b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.137906]  pin1c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.145798]  pin1d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.153688]  pin1e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.164077]  pin1f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.171970]  pin20, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.179862]  pin21, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.187754]  pin22, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.195648]  pin23, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.203556]  pin24, disabled, edge , high, V(21), IRR(0), S(0), physical=
, D(00), M(2)
[   12.211463]  pin25, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.219367]  pin26, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.227267]  pin27, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(01), M(2)
[   12.235161]  pin28, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.243053]  pin29, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.250947]  pin2a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.258839]  pin2b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.266733]  pin2c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.274627]  pin2d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.282521]  pin2e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.290413]  pin2f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.298306]  pin30, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.306199]  pin31, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.314092]  pin32, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.321983]  pin33, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.329876]  pin34, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.337768]  pin35, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.345660]  pin36, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.353552]  pin37, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.361444]  pin38, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.369335]  pin39, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.377226]  pin3a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.385119]  pin3b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.393009]  pin3c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.400899]  pin3d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.408789]  pin3e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.416680]  pin3f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.424573]  pin40, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.432464]  pin41, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.440372]  pin42, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.448278]  pin43, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.456182]  pin44, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.464084]  pin45, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.471974]  pin46, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.479866]  pin47, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.487758]  pin48, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.495651]  pin49, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.503542]  pin4a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(08), M(2)
[   12.511432]  pin4b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.519323]  pin4c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.527215]  pin4d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.535107]  pin4e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.542999]  pin4f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.550888]  pin50, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.558780]  pin51, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.566672]  pin52, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(80), M(2)
[   12.574565]  pin53, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.582457]  pin54, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.590348]  pin55, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.598240]  pin56, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.606132]  pin57, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.614024]  pin58, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.621918]  pin59, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.629810]  pin5a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.637702]  pin5b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.645597]  pin5c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.653489]  pin5d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.661380]  pin5e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.669271]  pin5f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.677177]  pin60, disabled, edge , high, V(20), IRR(0), S(0), physical=
, D(08), M(2)
[   12.685081]  pin61, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.692986]  pin62, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.700891]  pin63, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.708784]  pin64, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.716679]  pin65, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.724574]  pin66, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.732466]  pin67, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.740358]  pin68, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.748252]  pin69, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.756145]  pin6a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.764038]  pin6b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.771930]  pin6c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.779822]  pin6d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.787712]  pin6e, disabled, edge , high, V(00), IRR(0), S(0), logical =
, D(00), M(2)
[   12.795603]  pin6f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.803494]  pin70, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.811386]  pin71, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.819279]  pin72, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.827169]  pin73, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.835060]  pin74, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.842953]  pin75, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.850847]  pin76, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.858738]  pin77, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.866625] IRQ to pin mappings:
[   12.872424] IRQ0 -> 0:2
[   12.874954] IRQ1 -> 0:1
[   12.877483] IRQ3 -> 0:3
[   12.880013] IRQ4 -> 0:4
[   12.882542] IRQ5 -> 0:5
[   12.885071] IRQ6 -> 0:6
[   12.887599] IRQ7 -> 0:7
[   12.890129] IRQ8 -> 0:8
[   12.892658] IRQ9 -> 0:9
[   12.895187] IRQ10 -> 0:10
[   12.897889] IRQ11 -> 0:11
[   12.900590] IRQ12 -> 0:12
[   12.903290] IRQ13 -> 0:13
[   12.905990] IRQ14 -> 0:14
[   12.908693] IRQ15 -> 0:15
[   12.911399] IRQ16 -> 0:16
[   12.914107] IRQ18 -> 0:18
[   12.916812] IRQ19 -> 0:19
[   12.919517] .................................... done.
[   12.924730] clocksource: Switched to clocksource tsc
[   12.924735] AVX2 version of gcm_enc/dec engaged.
[   12.934478] AES CTR mode by8 optimization enabled
[   12.941097] sched_clock: Marking stable (11984581635, 956511572)->(13986=
499829, -1045406622)
[   12.949934] registered taskstats version 1
[   12.954115] Loading compiled-in X.509 certificates
[   12.959849] Loaded X.509 cert 'Build time autogenerated kernel key: bf0a=
41d88f630fbef6db60a8bcbfaf331b5b9e32'
[   12.969832] zswap: loaded using pool lzo/zbud
[   12.974530] Key type ._fscrypt registered
[   12.978665] Key type .fscrypt registered
[   12.982710] Key type fscrypt-provisioning registered
[   12.990520] Key type encrypted registered
[   12.994654] AppArmor: AppArmor sha1 policy hashing enabled
[   13.000213] ima: No TPM chip found, activating TPM-bypass!
[   13.005772] ima: Allocated hash algorithm: sha1
[   13.010381] ima: No architecture policies found
[   13.014990] evm: Initialising EVM extended attributes:
[   13.020198] evm: security.selinux
[   13.023638] evm: security.apparmor
[   13.027122] evm: security.ima
[   13.030176] evm: security.capability
[   13.033831] evm: HMAC attrs: 0x1
[   17.943423] e1000e 0000:00:1f.6 eth0: NIC Link is Up 1000 Mbps Full Dupl=
ex, Flow Control: Rx/Tx
[   17.953843] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   17.965774] Sending DHCP requests ., OK
[   17.973550] IP-Config: Got DHCP answer from 192.168.3.2, my address is 1=
92.168.3.95
[   17.981292] IP-Config: Complete:
[   17.984629]      device=3Deth0, hwaddr=3D64:00:6a:30:92:35, ipaddr=3D192=
=2E168.3.95, mask=3D255.255.255.0, gw=3D192.168.3.200
[   17.994944]      host=3Dlkp-skl-d04, domain=3Dlkp.intel.com, nis-domain=
=3D(none)
[   18.001876]      bootserver=3D192.168.3.200, rootserver=3D192.168.3.200,=
 rootpath=3D
[   18.001877]      nameserver0=3D192.168.3.200
[   18.013346]=20
[   18.013377] TAP version 14
[   18.017755] 1..1
[   18.019685]     # Subtest: property-entry
[   18.019686]     1..7
[   18.024050]     ok 1 - pe_test_uints
[   18.026490]     ok 2 - pe_test_uint_arrays
[   18.030419]     ok 3 - pe_test_strings
[   18.034911]     ok 4 - pe_test_bool
[   18.038857]     ok 5 - pe_test_move_inline_u8
[   18.042568]     ok 6 - pe_test_move_inline_str
[   18.047278]     ok 7 - pe_test_reference
[   18.051813] ok 1 - property-entry
[   18.060245] Freeing unused decrypted memory: 2036K
[   18.065468] Freeing unused kernel image (initmem) memory: 2432K
[   18.076689] Write protecting the kernel read-only data: 22528k
[   18.083184] Freeing unused kernel image (text/rodata gap) memory: 2036K
[   18.090211] Freeing unused kernel image (rodata/data gap) memory: 1332K
[   18.102667] Run /init as init process
[   18.106412]   with arguments:
[   18.109465]     /init
[   18.111826]     nokaslr
[   18.114360]   with environment:
[   18.117611]     HOME=3D/
[   18.120059]     TERM=3Dlinux
[   18.122854]     user=3Dlkp
[   18.125474]     job=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-=
gcc-ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445=
ea59c806787813-20201226-25066-sfkgan-4.yaml
[   18.142107]     ARCH=3Dx86_64
[   18.144986]     kconfig=3Dx86_64-rhel-8.3
[   18.148901]     branch=3Ddrm-intel/drm-intel-gt-next
[   18.153767]     commit=3D8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813
[   18.159761]     BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/vmlinuz-5.10.0-rc3-01127-g8c3b1ba0e7ea
[   18.172337]     max_uptime=3D2100
[   18.175573]     RESULT_ROOT=3D/result/perf-sanity-tests/gcc-ucode=3D0xe2=
/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0=
e7ea9a80b0ee4b4445ea59c806787813/5
[   18.191439]     LKP_SERVER=3Dinternal-lkp-server
[   18.195960]     softlockup_panic=3D1
[   18.199444]     prompt_ramdisk=3D0
[   18.202756]     vga=3Dnormal
[   18.209377] systemd[1]: RTC configured in localtime, applying delta of 0=
 minutes to system time.


         Mou
[   18.378974] wmi_bus wmi_bus-PNP0C14:00: WQBC data block query control me=
thod not found
ssage Queue File
[   18.427963] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   18.435013] RAPL PMU: hw unit of domain package 2^-14 Joules
         Startin
[   18.442050] RAPL PMU: hw unit of domain dram 2^-14 Joules
nt Root and Kern
[   18.456254] ahci 0000:00:17.0: version 3.0
39mRPC Pipe File
[   18.478997] IOAPIC[0]: Set routing entry (2-17 -> 0xef -> IRQ 17 Mode:1 =
Active:1 Dest:1)
ess NFS configur
[   18.666287] scsi host1: ahci
 =20
[   18.670430] scsi host2: ahci
       Starting=20
[   18.674508] scsi host3: ahci
rnel Device Mana
[   18.687548] ata2: SATA max UDMA/133 abar m2048@0xdf04b000 port 0xdf04b18=
0 irq 127
[   18.755674] i915 0000:00:02.0: vgaarb: deactivate vga console
[   18.763457] Console: switching to colour dummy device 80x25
r to synchronize
[   18.781328] i915 0000:00:02.0: Direct firmware load for i915/skl_dmc_ver=
1_27.bin failed with error -2
 boot up for ifu
[   18.791792] i915 0000:00:02.0: [drm] Failed to load DMC firmware i915/sk=
l_dmc_ver1_27.bin. Disabling runtime power management.
[   18.804413] i915 0000:00:02.0: [drm] DMC firmware homepage: https://git.=
kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
[   18.818133] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on mi=
nor 0
 Journal to Pers
[   18.836178] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/LNXVIDEO:00/input/input4
[   18.850210] random: fast init done
         Startin
[   18.871517] intel_rapl_common: Found RAPL domain package
[   18.884593] intel_rapl_common: Found RAPL domain uncore
[   18.889782] intel_rapl_common: Found RAPL domain dram
[   19.019708] ata4: SATA link down (SStatus 4 SControl 300)
[   19.025078] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   19.031218] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   19.031260] ata3: SATA link down (SStatus 4 SControl 300)
[   19.050686] ata2.00: 2344225968 sectors, multi 1: LBA48 NCQ (depth 32)
m.
[   18.250605] rc.local[290]: PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sb=
in:/usr/bin:/sbin:/bin:/lkp/lkp/src/bin
LKP: HOSTNAME lkp-skl-d04, MAC 64:00:6a:30:92:35, kernel 5.10.0-rc3-01127-g=
8c3b1ba0e7ea 1, serial console /dev/ttyS0
         Startin
[   19.250920] ata1.00: ATA-9: ST1000DM003-1ER162, CC45, max UDMA/133

[   19.271750] scsi 0:0:0:0: Direct-Access     ATA      ST1000DM003-1ER1 CC=
45 PQ: 0 ANSI: 5
[   19.280244] scsi 1:0:0:0: Direct-Access     ATA      INTEL SSDSC2BB01 00=
23 PQ: 0 ANSI: 5
1;39mSystem Logg
[   19.302976] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[   19.306697] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 =
TB/932 GiB)

[   19.321745] sd 0:0:0:0: [sda] 4096-byte physical blocks
[   19.321899] sd 1:0:0:0: [sdb] 2344225968 512-byte logical blocks: (1.20 =
TB/1.09 TiB)
[   19.333464] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[   19.333750] sd 1:0:0:0: [sdb] 4096-byte physical blocks
[   19.335589] sd 0:0:0:0: [sda] Write Protect is off
[   19.335590] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   19.335598] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   19.335694] sd 1:0:0:0: Attached scsi generic sg1 type 0
[   19.376861] sd 1:0:0:0: [sdb] Write Protect is off
0m
[   19.388029] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   19.403025] ata2.00: Enabling discard_zeroes_data
[   19.408785] sd 1:0:0:0: [sdb] Attached SCSI disk
al Compatibility
[   19.421854] sd 0:0:0:0: [sda] Attached SCSI disk
[   19.448136] ipmi device interface
[   19.461579] ipmi_si: IPMI System Interface driver
[   19.466972] ipmi_si: Unable to find any System Interface(s)
See 'systemctl status openipmi.service' for details.
[   20.404571] random: crng init done
[   20.407949] random: 2 urandom warning(s) missed due to ratelimiting
[   24.066557] Kernel tests: Boot OK!
[   24.066560]=20
[   28.234253] install debs round one: dpkg -i --force-confdef --force-depe=
nds /opt/deb/ntpdate_1%3a4.2.8p12+dfsg-4_amd64.deb
[   28.234256]=20
[   28.247737] /opt/deb/libperl5.28_5.28.1-6+deb10u1_amd64.deb
[   28.247739]=20
[   28.255613] /opt/deb/perl_5.28.1-6+deb10u1_amd64.deb
[   28.255615]=20
[   28.262930] /opt/deb/perl-base_5.28.1-6+deb10u1_amd64.deb
[   28.262931]=20
[   28.270833] /opt/deb/perl-modules-5.28_5.28.1-6+deb10u1_all.deb
[   28.270834]=20
[   28.279463] /opt/deb/libpython3.7-minimal_3.7.3-2+deb10u2_amd64.deb
[   28.279465]=20
[   28.288319] /opt/deb/python3.7-minimal_3.7.3-2+deb10u2_amd64.deb
[   28.288320]=20
[   28.296617] /opt/deb/python3-minimal_3.7.3-1_amd64.deb
[   28.296618]=20
[   28.304505] /opt/deb/libpython3.7-stdlib_3.7.3-2+deb10u2_amd64.deb
[   28.304506]=20
[   28.313029] /opt/deb/python3.7_3.7.3-2+deb10u2_amd64.deb
[   28.313030]=20
[   28.320693] /opt/deb/libpython3-stdlib_3.7.3-1_amd64.deb
[   28.320694]=20
[   28.328190] /opt/deb/python3_3.7.3-1_amd64.deb
[   28.328191]=20
[   28.335088] /opt/deb/gtk-update-icon-cache_3.24.5-1_amd64.deb
[   28.335089]=20
[   28.343097] /opt/deb/libthai-data_0.1.28-2_all.deb
[   28.343099]=20
[   28.350146] /opt/deb/libdatrie1_0.2.12-2_amd64.deb
[   28.350147]=20
[   28.357376] /opt/deb/libavahi-common-data_0.7-4+b1_amd64.deb
[   28.357378]=20
[   28.365341] /opt/deb/libasound2-data_1.1.8-1_all.deb
[   28.365342]=20
[   28.372919] /opt/deb/ca-certificates-java_20190405_all.deb
[   28.372921]=20
[   28.380651] /opt/deb/libatomic1_8.3.0-6_amd64.deb
[   28.380652]=20
[   28.387559] /opt/deb/libquadmath0_8.3.0-6_amd64.deb
[   28.387560]=20
[   28.394693] /opt/deb/libgcc-8-dev_8.3.0-6_amd64.deb
[   28.394694]=20
[   28.401822] /opt/deb/lib32gcc1_1%3a8.3.0-6_amd64.deb
[   28.401823]=20
[   28.408922] /opt/deb/gcc-8_8.3.0-6_amd64.deb
[   28.408923]=20
[   28.415416] /opt/deb/gcc_4%3a8.3.0-1_amd64.deb
[   28.415417]=20
[   28.421986] /opt/deb/g++-8_8.3.0-6_amd64.deb
[   28.421987]=20
[   28.428558] /opt/deb/g++_4%3a8.3.0-1_amd64.deb
[   28.428560]=20
[   28.435459] /opt/deb/libatk1.0-data_2.30.0-2_all.deb
[   28.435461]=20
[   28.442747] /opt/deb/libatk1.0-0_2.30.0-2_amd64.deb
[   28.442748]=20
[   28.449970] /opt/deb/gir1.2-atk-1.0_2.30.0-2_amd64.deb
[   28.449971]=20
[   28.457316] /opt/deb/libdpkg-perl_1.19.7_all.deb
[   28.457317]=20
[   28.464354] /opt/deb/libglib2.0-data_2.58.3-2+deb10u2_all.deb
[   28.464355]=20
[   28.472379] /opt/deb/python3-lib2to3_3.7.3-1_all.deb
[   28.472380]=20
[   28.479631] /opt/deb/python3-distutils_3.7.3-1_all.deb
[   28.479632]=20
[   28.487076] /opt/deb/libatk1.0-dev_2.30.0-2_amd64.deb
[   28.487077]=20
[   28.494622] /opt/deb/libexpat1-dev_2.2.6-2+deb10u1_amd64.deb
[   28.494623]=20
[   28.502675] /opt/deb/libperl-dev_5.28.1-6+deb10u1_amd64.deb
[   28.502677]=20
[   28.510770] /opt/deb/libpython2.7_2.7.16-2+deb10u1_amd64.deb
[   28.510771]=20
[   28.519038] /opt/deb/libpython2.7-dev_2.7.16-2+deb10u1_amd64.deb
[   28.519039]=20
[   28.527366] /opt/deb/libpython2-dev_2.7.16-1_amd64.deb
[   28.527367]=20
[   28.534858] /opt/deb/libpython-dev_2.7.16-1_amd64.deb
[   28.534872]=20
[   28.542194] /opt/deb/patch_2.7.6-3+deb10u1_amd64.deb
[   28.542195]=20
[   28.549594] /opt/deb/python2.7-dev_2.7.16-2+deb10u1_amd64.deb
[   28.549595]=20
[   28.557658] /opt/deb/python2-dev_2.7.16-1_amd64.deb
[   28.557659]=20
[   28.564746] /opt/deb/python-dev_2.7.16-1_amd64.deb
[   28.564747]=20
[   28.571786] /opt/deb/gawk_1%3a4.2.1+dfsg-1_amd64.deb
[   28.571787]=20
[   28.579237] Selecting previously unselected package ntpdate.
[   28.579239]=20
[   28.587874] (Reading database ... 16553 files and directories currently =
installed.)
[   28.587876]=20
[   28.598601] Preparing to unpack .../ntpdate_1%3a4.2.8p12+dfsg-4_amd64.de=
b ...
[   28.598603]=20
[   28.608134] Unpacking ntpdate (1:4.2.8p12+dfsg-4) ...
[   28.608135]=20
[   28.616076] Preparing to unpack .../libperl5.28_5.28.1-6+deb10u1_amd64.d=
eb ...
[   28.616077]=20
[   28.626252] Unpacking libperl5.28:amd64 (5.28.1-6+deb10u1) over (5.28.1-=
6) ...
[   28.626254]=20
[   28.636207] Preparing to unpack .../perl_5.28.1-6+deb10u1_amd64.deb ...
[   28.636208]=20
[   28.645398] Unpacking perl (5.28.1-6+deb10u1) over (5.28.1-6) ...
[   28.645399]=20
[   28.654355] Preparing to unpack .../perl-base_5.28.1-6+deb10u1_amd64.deb=
 ...
[   28.654356]=20
[   28.664068] Unpacking perl-base (5.28.1-6+deb10u1) over (5.28.1-6) ...
[   28.664070]=20
[   28.673584] Preparing to unpack .../perl-modules-5.28_5.28.1-6+deb10u1_a=
ll.deb ...
[   28.673586]=20
[   28.684020] Unpacking perl-modules-5.28 (5.28.1-6+deb10u1) over (5.28.1-=
6) ...
[   28.684021]=20
[   28.694120] Selecting previously unselected package libpython3.7-minimal=
:amd64.
[   28.694121]=20
[   28.704460] Preparing to unpack .../libpython3.7-minimal_3.7.3-2+deb10u2=
_amd64.deb ...
[   28.704461]=20
[   28.715078] Unpacking libpython3.7-minimal:amd64 (3.7.3-2+deb10u2) ...
[   28.715079]=20
[   28.724291] Selecting previously unselected package python3.7-minimal.
[   28.724292]=20
[   28.733865] Preparing to unpack .../python3.7-minimal_3.7.3-2+deb10u2_am=
d64.deb ...
[   28.733866]=20
[   28.743973] Unpacking python3.7-minimal (3.7.3-2+deb10u2) ...
[   28.743974]=20
[   28.752384] Selecting previously unselected package python3-minimal.
[   28.752385]=20
[   28.761467] Preparing to unpack .../python3-minimal_3.7.3-1_amd64.deb ...
[   28.761468]=20
[   28.770458] Unpacking python3-minimal (3.7.3-1) ...
[   28.770459]=20
[   28.778198] Selecting previously unselected package libpython3.7-stdlib:=
amd64.
[   28.778200]=20
[   28.788441] Preparing to unpack .../libpython3.7-stdlib_3.7.3-2+deb10u2_=
amd64.deb ...
[   28.788443]=20
[   28.798917] Unpacking libpython3.7-stdlib:amd64 (3.7.3-2+deb10u2) ...
[   28.798918]=20
[   28.807853] Selecting previously unselected package python3.7.
[   28.807854]=20
[   28.816466] Preparing to unpack .../python3.7_3.7.3-2+deb10u2_amd64.deb =
=2E..
[   28.816467]=20
[   28.825681] Unpacking python3.7 (3.7.3-2+deb10u2) ...
[   28.825682]=20
[   28.833495] Selecting previously unselected package libpython3-stdlib:am=
d64.
[   28.833496]=20
[   28.843217] Preparing to unpack .../libpython3-stdlib_3.7.3-1_amd64.deb =
=2E..
[   28.843219]=20
[   28.852578] Unpacking libpython3-stdlib:amd64 (3.7.3-1) ...
[   28.852580]=20
[   28.860633] Selecting previously unselected package python3.
[   28.860635]=20
[   28.869034] Preparing to unpack .../deb/python3_3.7.3-1_amd64.deb ...
[   28.869035]=20
[   28.877555] Unpacking python3 (3.7.3-1) ...
[   28.877557]=20
[   28.884450] Selecting previously unselected package gtk-update-icon-cach=
e.
[   28.884451]=20
[   28.894143] Preparing to unpack .../gtk-update-icon-cache_3.24.5-1_amd64=
=2Edeb ...
[   28.894144]=20
[   29.464714] No diversion 'diversion of /usr/sbin/update-icon-caches to /=
usr/sbin/update-icon-caches.gtk2 by libgtk-3-bin', none removed.
[   29.464716]=20
[   30.594291] No diversion 'diversion of /usr/share/man/man8/update-icon-c=
aches.8.gz to /usr/share/man/man8/update-icon-caches.gtk2.8.gz by libgtk-3-=
bin', none removed.
[   30.594294]=20
[   30.611523] Unpacking gtk-update-icon-cache (3.24.5-1) ...
[   30.611525]=20
[   30.619892] Selecting previously unselected package libthai-data.
[   30.619907]=20
[   30.630338] Preparing to unpack .../libthai-data_0.1.28-2_all.deb ...
[   30.630339]=20
[   30.637576] SGI XFS with ACLs, security attributes, realtime, scrub, rep=
air, quota, fatal assert, debug enabled
[   30.638981] Unpacking libthai-data (0.1.28-2) ...
[   30.648203]=20
[   30.655115] XFS (sdb1): Deprecated V4 format (crc=3D0) will not be suppo=
rted after September 2030.
[   30.655724] Selecting previously unselected package libdatrie1:amd64.
[   30.663826]=20
[   30.671774] XFS (sdb1): Mounting V4 Filesystem
[   30.672927] Preparing to unpack .../libdatrie1_0.2.12-2_amd64.deb ...
[   30.676179]=20
[   30.685001] Unpacking libdatrie1:amd64 (0.2.12-2) ...
[   30.685002]=20
[   30.692952] Selecting previously unselected package libavahi-common-data=
:amd64.
[   30.692953]=20
[   30.703055] Preparing to unpack .../libavahi-common-data_0.7-4+b1_amd64.=
deb ...
[   30.703056]=20
[   30.712874] Unpacking libavahi-common-data:amd64 (0.7-4+b1) ...
[   30.712875]=20
[   30.721404] Selecting previously unselected package libasound2-data.
[   30.721405]=20
[   30.730534] Preparing to unpack .../libasound2-data_1.1.8-1_all.deb ...
[   30.730536]=20
[   30.739400] Unpacking libasound2-data (1.1.8-1) ...
[   30.739401]=20
[   30.747033] Selecting previously unselected package ca-certificates-java.
[   30.747034]=20
[   30.756715] Preparing to unpack .../ca-certificates-java_20190405_all.de=
b ...
[   30.756716]=20
[   30.763913] XFS (sdb1): Starting recovery (logdev: internal)
[   30.766237] Unpacking ca-certificates-java (20190405) ...
[   30.770892]=20
[   30.779105] Selecting previously unselected package libatomic1:amd64.
[   30.779107]=20
[   30.788257] Preparing to unpack .../libatomic1_8.3.0-6_amd64.deb ...
[   30.788258]=20
[   30.797134] Unpacking libatomic1:amd64 (8.3.0-6) ...
[   30.797135]=20
[   30.805046] Selecting previously unselected package libquadmath0:amd64.
[   30.805047]=20
[   30.814399] XFS (sdb1): Ending recovery (logdev: internal)
[   30.814630] Preparing to unpack .../libquadmath0_8.3.0-6_amd64.deb ...
[   30.819837]=20
[   30.828862] Unpacking libquadmath0:amd64 (8.3.0-6) ...
[   30.828863]=20
[   30.836267] xfs filesystem being mounted at /opt/rootfs supports timesta=
mps until 2038 (0x7fffffff)
[   30.836846] Selecting previously unselected package libgcc-8-dev:amd64.
[   30.845235]=20
[   30.854664] Preparing to unpack .../libgcc-8-dev_8.3.0-6_amd64.deb ...
[   30.854665]=20
[   30.863521] Unpacking libgcc-8-dev:amd64 (8.3.0-6) ...
[   30.863522]=20
[   30.871169] Selecting previously unselected package lib32gcc1.
[   30.871170]=20
[   30.879642] Preparing to unpack .../lib32gcc1_1%3a8.3.0-6_amd64.deb ...
[   30.879644]=20
[   30.888394] Unpacking lib32gcc1 (1:8.3.0-6) ...
[   30.888396]=20
[   30.895466] Selecting previously unselected package gcc-8.
[   30.895467]=20
[   30.903469] Preparing to unpack .../deb/gcc-8_8.3.0-6_amd64.deb ...
[   30.903470]=20
[   30.911801] Unpacking gcc-8 (8.3.0-6) ...
[   30.911802]=20
[   30.918129] Selecting previously unselected package gcc.
[   30.918130]=20
[   30.926019] Preparing to unpack .../deb/gcc_4%3a8.3.0-1_amd64.deb ...
[   30.926020]=20
[   30.934450] Unpacking gcc (4:8.3.0-1) ...
[   30.934451]=20
[   30.940835] Selecting previously unselected package g++-8.
[   30.940836]=20
[   30.948856] Preparing to unpack .../deb/g++-8_8.3.0-6_amd64.deb ...
[   30.948857]=20
[   30.957156] Unpacking g++-8 (8.3.0-6) ...
[   30.957157]=20
[   30.963469] Selecting previously unselected package g++.
[   30.963470]=20
[   30.971361] Preparing to unpack .../deb/g++_4%3a8.3.0-1_amd64.deb ...
[   30.971362]=20
[   30.979840] Unpacking g++ (4:8.3.0-1) ...
[   30.979841]=20
[   30.986392] Selecting previously unselected package libatk1.0-data.
[   30.986393]=20
[   30.995289] Preparing to unpack .../libatk1.0-data_2.30.0-2_all.deb ...
[   30.995290]=20
[   31.004131] Unpacking libatk1.0-data (2.30.0-2) ...
[   31.004132]=20
[   31.011710] Selecting previously unselected package libatk1.0-0:amd64.
[   31.011711]=20
[   31.020820] Preparing to unpack .../libatk1.0-0_2.30.0-2_amd64.deb ...
[   31.020821]=20
[   31.029639] Unpacking libatk1.0-0:amd64 (2.30.0-2) ...
[   31.029640]=20
[   31.037443] Selecting previously unselected package gir1.2-atk-1.0:amd64.
[   31.037444]=20
[   31.046876] Preparing to unpack .../gir1.2-atk-1.0_2.30.0-2_amd64.deb ...
[   31.046877]=20
[   31.056027] Unpacking gir1.2-atk-1.0:amd64 (2.30.0-2) ...
[   31.056028]=20
[   31.063953] Selecting previously unselected package libdpkg-perl.
[   31.063954]=20
[   31.072669] Preparing to unpack .../libdpkg-perl_1.19.7_all.deb ...
[   31.072670]=20
[   31.081105] Unpacking libdpkg-perl (1.19.7) ...
[   31.081106]=20
[   31.088217] Selecting previously unselected package libglib2.0-data.
[   31.088218]=20
[   31.097348] Preparing to unpack .../libglib2.0-data_2.58.3-2+deb10u2_all=
=2Edeb ...
[   31.097349]=20
[   31.107128] Unpacking libglib2.0-data (2.58.3-2+deb10u2) ...
[   31.107129]=20
[   31.115334] Selecting previously unselected package python3-lib2to3.
[   31.115335]=20
[   31.124292] Preparing to unpack .../python3-lib2to3_3.7.3-1_all.deb ...
[   31.124293]=20
[   31.133130] Unpacking python3-lib2to3 (3.7.3-1) ...
[   31.133131]=20
[   31.140701] Selecting previously unselected package python3-distutils.
[   31.140702]=20
[   31.149863] Preparing to unpack .../python3-distutils_3.7.3-1_all.deb ...
[   31.149864]=20
[   31.158942] Unpacking python3-distutils (3.7.3-1) ...
[   31.158944]=20
[   31.166693] Selecting previously unselected package libatk1.0-dev:amd64.
[   31.166694]=20
[   31.176014] Preparing to unpack .../libatk1.0-dev_2.30.0-2_amd64.deb ...
[   31.176015]=20
[   31.185031] Unpacking libatk1.0-dev:amd64 (2.30.0-2) ...
[   31.185032]=20
[   31.192967] Selecting previously unselected package libexpat1-dev:amd64.
[   31.192968]=20
[   31.202426] Preparing to unpack .../libexpat1-dev_2.2.6-2+deb10u1_amd64.=
deb ...
[   31.202427]=20
[   31.212174] Unpacking libexpat1-dev:amd64 (2.2.6-2+deb10u1) ...
[   31.212175]=20
[   31.220597] Selecting previously unselected package libperl-dev.
[   31.220598]=20
[   31.229341] Preparing to unpack .../libperl-dev_5.28.1-6+deb10u1_amd64.d=
eb ...
[   31.229342]=20
[   31.238887] Unpacking libperl-dev (5.28.1-6+deb10u1) ...
[   31.238888]=20
[   31.246819] Selecting previously unselected package libpython2.7:amd64.
[   31.246820]=20
[   31.256182] Preparing to unpack .../libpython2.7_2.7.16-2+deb10u1_amd64.=
deb ...
[   31.256183]=20
[   31.265940] Unpacking libpython2.7:amd64 (2.7.16-2+deb10u1) ...
[   31.265941]=20
[   31.274576] Selecting previously unselected package libpython2.7-dev:amd=
64.
[   31.274577]=20
[   31.284420] Preparing to unpack .../libpython2.7-dev_2.7.16-2+deb10u1_am=
d64.deb ...
[   31.284421]=20
[   31.294675] Unpacking libpython2.7-dev:amd64 (2.7.16-2+deb10u1) ...
[   31.294676]=20
[   31.303667] Selecting previously unselected package libpython2-dev:amd64.
[   31.303668]=20
[   31.313087] Preparing to unpack .../libpython2-dev_2.7.16-1_amd64.deb ...
[   31.313088]=20
[   31.322209] Unpacking libpython2-dev:amd64 (2.7.16-1) ...
[   31.322210]=20
[   31.330254] Selecting previously unselected package libpython-dev:amd64.
[   31.330255]=20
[   31.339667] Preparing to unpack .../libpython-dev_2.7.16-1_amd64.deb ...
[   31.339668]=20
[   31.348684] Unpacking libpython-dev:amd64 (2.7.16-1) ...
[   31.348685]=20
[   31.356372] Selecting previously unselected package patch.
[   31.356373]=20
[   31.364470] Preparing to unpack .../patch_2.7.6-3+deb10u1_amd64.deb ...
[   31.364471]=20
[   31.373298] Unpacking patch (2.7.6-3+deb10u1) ...
[   31.373299]=20
[   31.380562] Selecting previously unselected package python2.7-dev.
[   31.380563]=20
[   31.389532] Preparing to unpack .../python2.7-dev_2.7.16-2+deb10u1_amd64=
=2Edeb ...
[   31.389533]=20
[   31.399303] Unpacking python2.7-dev (2.7.16-2+deb10u1) ...
[   31.399304]=20
[   31.407265] Selecting previously unselected package python2-dev.
[   31.407266]=20
[   31.415854] Preparing to unpack .../python2-dev_2.7.16-1_amd64.deb ...
[   31.415855]=20
[   31.424510] Unpacking python2-dev (2.7.16-1) ...
[   31.424511]=20
[   31.431620] Selecting previously unselected package python-dev.
[   31.431621]=20
[   31.440106] Preparing to unpack .../python-dev_2.7.16-1_amd64.deb ...
[   31.440107]=20
[   31.448701] Unpacking python-dev (2.7.16-1) ...
[   31.448702]=20
[   31.455542] Selecting previously unselected package gawk.
[   31.455543]=20
[   31.463535] Preparing to unpack .../gawk_1%3a4.2.1+dfsg-1_amd64.deb ...
[   31.463536]=20
[   31.472260] Unpacking gawk (1:4.2.1+dfsg-1) ...
[   31.472261]=20
[   31.479084] Setting up ntpdate (1:4.2.8p12+dfsg-4) ...
[   31.479085]=20
[   31.486492] Setting up perl-base (5.28.1-6+deb10u1) ...
[   31.486493]=20
[   31.494206] Setting up perl-modules-5.28 (5.28.1-6+deb10u1) ...
[   31.494207]=20
[   31.502776] Setting up libpython3.7-minimal:amd64 (3.7.3-2+deb10u2) ...
[   31.502777]=20
[   31.511836] Setting up python3.7-minimal (3.7.3-2+deb10u2) ...
[   31.511837]=20
[   31.519946] Setting up python3-minimal (3.7.3-1) ...
[   31.519947]=20
[   31.527126] Setting up libthai-data (0.1.28-2) ...
[   31.527127]=20
[   31.534221] Setting up libdatrie1:amd64 (0.2.12-2) ...
[   31.534222]=20
[   31.541840] Setting up libavahi-common-data:amd64 (0.7-4+b1) ...
[   31.541841]=20
[   31.550092] Setting up libasound2-data (1.1.8-1) ...
[   31.550093]=20
[   31.557325] Setting up libatomic1:amd64 (8.3.0-6) ...
[   31.557326]=20
[   31.564706] Setting up libquadmath0:amd64 (8.3.0-6) ...
[   31.564707]=20
[   31.572185] Setting up libatk1.0-data (2.30.0-2) ...
[   31.572186]=20
[   31.579553] Setting up libglib2.0-data (2.58.3-2+deb10u2) ...
[   31.579554]=20
[   31.587780] Setting up libpython2.7:amd64 (2.7.16-2+deb10u1) ...
[   31.587781]=20
[   31.596000] Setting up patch (2.7.6-3+deb10u1) ...
[   31.596001]=20
[   31.603255] Setting up libperl5.28:amd64 (5.28.1-6+deb10u1) ...
[   31.603256]=20
[   31.611355] Setting up perl (5.28.1-6+deb10u1) ...
[   31.611356]=20
[   31.618300] Setting up libdpkg-perl (1.19.7) ...
[   31.618301]=20
[   31.625297] Setting up libperl-dev (5.28.1-6+deb10u1) ...
[   31.625298]=20
[   31.633260] Setting up libpython2.7-dev:amd64 (2.7.16-2+deb10u1) ...
[   31.633261]=20
[   31.641982] Setting up libpython2-dev:amd64 (2.7.16-1) ...
[   31.641983]=20
[   31.649821] Setting up libpython-dev:amd64 (2.7.16-1) ...
[   31.649822]=20
[   31.657589] Setting up python2.7-dev (2.7.16-2+deb10u1) ...
[   31.657590]=20
[   31.665344] Setting up python2-dev (2.7.16-1) ...
[   31.665345]=20
[   31.672280] Setting up python-dev (2.7.16-1) ...
[   31.672281]=20
[   31.679076] Setting up gawk (1:4.2.1+dfsg-1) ...
[   31.679077]=20
[   31.686305] Setting up libpython3.7-stdlib:amd64 (3.7.3-2+deb10u2) ...
[   31.686306]=20
[   31.695114] Setting up python3.7 (3.7.3-2+deb10u2) ...
[   31.695115]=20
[   31.702668] Setting up libpython3-stdlib:amd64 (3.7.3-1) ...
[   31.702669]=20
[   31.710378] Setting up python3 (3.7.3-1) ...
[   31.710379]=20
[   31.717058] running python rtupdate hooks for python3.7...
[   31.717060]=20
[   31.724926] Setting up gtk-update-icon-cache (3.24.5-1) ...
[   31.724927]=20
[   31.732858] Setting up ca-certificates-java (20190405) ...
[   31.732859]=20
[   31.740533] Adding debian:GeoTrust_Universal_CA.pem
[   31.740534]=20
[   31.747883] Adding debian:Staat_der_Nederlanden_EV_Root_CA.pem
[   31.747884]=20
[   31.755981] Adding debian:thawte_Primary_Root_CA.pem
[   31.755982]=20
[   31.763112] Adding debian:Amazon_Root_CA_2.pem
[   31.763113]=20
[   31.769996] Adding debian:OISTE_WISeKey_Global_Root_GC_CA.pem
[   31.769997]=20
[   31.778201] Adding debian:TWCA_Root_Certification_Authority.pem
[   31.778202]=20
[   31.786595] Adding debian:COMODO_RSA_Certification_Authority.pem
[   31.786596]=20
[   31.794848] Adding debian:SwissSign_Gold_CA_-_G2.pem
[   31.794849]=20
[   31.802441] Adding debian:Entrust.net_Premium_2048_Secure_Server_CA.pem
[   31.802442]=20
[   31.811415] Adding debian:DigiCert_Assured_ID_Root_G3.pem
[   31.811416]=20
[   31.819402] Adding debian:DigiCert_High_Assurance_EV_Root_CA.pem
[   31.819404]=20
[   31.827826] Adding debian:COMODO_Certification_Authority.pem
[   31.827827]=20
[   31.835660] Adding debian:SecureSign_RootCA11.pem
[   31.835661]=20
[   31.843724] Adding debian:VeriSign_Class_3_Public_Primary_Certification_=
Authority_-_G4.pem
[   31.843726]=20
[   31.854598] Adding debian:Security_Communication_RootCA2.pem
[   31.854599]=20
[   31.862565] Adding debian:QuoVadis_Root_CA_3_G3.pem
[   31.862567]=20
[   31.870826] Adding debian:Deutsche_Telekom_Root_CA_2.pem
[   31.870828]=20
[   31.874021] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   31.876932] Adding debian:SecureTrust_CA.pem
[   31.877812] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.889451]=20
[   31.893607] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.906163] Adding debian:AffirmTrust_Commercial.pem
[   31.906787] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   31.918495]=20
[   31.919111] Adding debian:Izenpe.com.pem
[   31.923782] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.935142]=20
[   31.936185] Adding debian:T-TeleSec_GlobalRoot_Class_2.pem
[   31.936632] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.940515]=20
[   31.942227] Adding debian:Verisign_Class_3_Public_Primary_Certification_=
Authority_-_G3.pem
[   31.952251] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   31.953715]=20
[   31.954589] Adding debian:Trustis_FPS_Root_CA.pem
[   31.959292] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.970874]=20
[   31.972471] Adding debian:Hellenic_Academic_and_Research_Institutions_Ro=
otCA_2011.pem
[   31.980556] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.992292]=20
[   31.993265] Adding debian:SwissSign_Silver_CA_-_G2.pem
[   31.993787] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   31.998446]=20
[   31.999240] Adding debian:QuoVadis_Root_CA.pem
[   32.010318] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.011658]=20
[   32.013052] Adding debian:TUBITAK_Kamu_SM_SSL_Kok_Sertifikasi_-_Surum_1.=
pem
[   32.019425] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.031142]=20
[   32.032187] Adding debian:thawte_Primary_Root_CA_-_G3.pem
[   32.032630] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.037715]=20
[   32.038497] Adding debian:AC_RAIZ_FNMT-RCM.pem
[   32.049619] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.050928]=20
[   32.055334] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.067978] Adding debian:thawte_Primary_Root_CA_-_G2.pem
[   32.068605] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.075423]=20
[   32.087312] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.089530] Adding debian:Comodo_AAA_Services_root.pem
[   32.094012] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.105727]=20
[   32.107232] Adding debian:Hellenic_Academic_and_Research_Institutions_Ro=
otCA_2015.pem
[   32.111623] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.123334]=20
[   32.124456] Adding debian:Entrust_Root_Certification_Authority.pem
[   32.124953] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.136538]=20
[   32.137356] Adding debian:Cybertrust_Global_Root.pem
[   32.141896] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.153626]=20
[   32.155111] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.167834] Adding debian:Security_Communication_Root_CA.pem
[   32.172053] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.183636]=20
[   32.184381] Adding debian:GlobalSign_Root_CA.pem
[   32.185119] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.192875]=20
[   32.194297] Adding debian:Starfield_Services_Root_Certificate_Authority_=
-_G2.pem
[   32.204624] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.206090]=20
[   32.207110] Adding debian:IdenTrust_Commercial_Root_CA_1.pem
[   32.212355] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.223955]=20
[   32.225250] Adding debian:GeoTrust_Primary_Certification_Authority_-_G3.=
pem
[   32.225439] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.230365]=20
[   32.231200] Adding debian:AffirmTrust_Networking.pem
[   32.242116] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.243588]=20
[   32.244532] Adding debian:T-TeleSec_GlobalRoot_Class_3.pem
[   32.255493] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.260936]=20
[   32.261688] Adding debian:Amazon_Root_CA_4.pem
[   32.272665] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.274139]=20
[   32.274788] Adding debian:Taiwan_GRCA.pem
[   32.278779] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.290439]=20
[   32.291139] Adding debian:Amazon_Root_CA_1.pem
[   32.292053] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.299248]=20
[   32.300475] Adding debian:Entrust_Root_Certification_Authority_-_G2.pem
[   32.310976] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.312447]=20
[   32.313335] Adding debian:Baltimore_CyberTrust_Root.pem
[   32.318075] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.329778]=20
[   32.330518] Adding debian:QuoVadis_Root_CA_2.pem
[   32.331425] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.338158]=20
[   32.339415] Adding debian:Entrust_Root_Certification_Authority_-_EC1.pem
[   32.349890] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.351358]=20
[   32.352630] Adding debian:SSL.com_EV_Root_Certification_Authority_ECC.pem
[   32.356293] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.368003]=20
[   32.368926] Adding debian:Certum_Trusted_Network_CA.pem
[   32.369654] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.374919]=20
[   32.386646] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.388847] Adding debian:SZAFIR_ROOT_CA2.pem
[   32.392535] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.404247]=20
[   32.405120] Adding debian:GlobalSign_Root_CA_-_R6.pem
[   32.405863] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.409700]=20
[   32.410902] Adding debian:SSL.com_Root_Certification_Authority_ECC.pem
[   32.421427] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.422901]=20
[   32.423935] Adding debian:EE_Certification_Centre_Root_CA.pem
[   32.427315] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.439027]=20
[   32.439856] Adding debian:AffirmTrust_Premium.pem
[   32.440677] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.447061]=20
[   32.458795] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.460944] Adding debian:DST_Root_CA_X3.pem
[   32.670198]=20
[   32.676857] Adding debian:GlobalSign_Root_CA_-_R2.pem
[   32.676858]=20
[   32.684265] Adding debian:Certum_Trusted_Network_CA_2.pem
[   32.684266]=20
[   32.692013] Adding debian:Atos_TrustedRoot_2011.pem
[   32.692014]=20
[   32.699579] Adding debian:Starfield_Root_Certificate_Authority_-_G2.pem
[   32.699580]=20
[   32.708824] Adding debian:Go_Daddy_Root_Certificate_Authority_-_G2.pem
[   32.708826]=20
[   32.717615] Adding debian:TrustCor_RootCert_CA-1.pem
[   32.717617]=20
[   32.725124] Adding debian:OISTE_WISeKey_Global_Root_GB_CA.pem
[   32.725125]=20
[   32.733345] Adding debian:OISTE_WISeKey_Global_Root_GA_CA.pem
[   32.733346]=20
[   32.741329] Adding debian:TrustCor_RootCert_CA-2.pem
[   32.741330]=20
[   32.748231] Adding debian:Certigna.pem
[   32.748232]=20
[   32.754220] Adding debian:TWCA_Global_Root_CA.pem
[   32.754221]=20
[   32.761149] Adding debian:Certinomis_-_Root_CA.pem
[   32.761150]=20
[   32.768118] Adding debian:TrustCor_ECA-1.pem
[   32.768119]=20
[   32.774851] Adding debian:D-TRUST_Root_Class_3_CA_2_2009.pem
[   32.774853]=20
[   32.782955] Adding debian:IdenTrust_Public_Sector_Root_CA_1.pem
[   32.782956]=20
[   32.791292] Adding debian:Chambers_of_Commerce_Root_-_2008.pem
[   32.791294]=20
[   32.799492] Adding debian:AffirmTrust_Premium_ECC.pem
[   32.799493]=20
[   32.806764] Adding debian:QuoVadis_Root_CA_2_G3.pem
[   32.806765]=20
[   32.813973] Adding debian:DigiCert_Global_Root_CA.pem
[   32.813974]=20
[   32.821222] Adding debian:QuoVadis_Root_CA_3.pem
[   32.821223]=20
[   32.828277] Adding debian:Global_Chambersign_Root_-_2008.pem
[   32.828278]=20
[   32.836277] Adding debian:Sonera_Class_2_Root_CA.pem
[   32.836278]=20
[   32.843582] Adding debian:Buypass_Class_2_Root_CA.pem
[   32.843583]=20
[   32.851160] Adding debian:ePKI_Root_Certification_Authority.pem
[   32.851161]=20
[   32.859254] Adding debian:GeoTrust_Global_CA.pem
[   32.859255]=20
[   32.866244] Adding debian:Buypass_Class_3_Root_CA.pem
[   32.866245]=20
[   32.873789] Adding debian:GlobalSign_ECC_Root_CA_-_R4.pem
[   32.873791]=20
[   32.881435] Adding debian:CA_Disig_Root_R2.pem
[   32.881437]=20
[   32.888238] Adding debian:Starfield_Class_2_CA.pem
[   32.888240]=20
[   32.895425] Adding debian:XRamp_Global_CA_Root.pem
[   32.895427]=20
[   32.902414] Adding debian:certSIGN_ROOT_CA.pem
[   32.902416]=20
[   32.909701] Adding debian:VeriSign_Universal_Root_Certification_Authorit=
y.pem
[   32.909703]=20
[   32.919220] Adding debian:GlobalSign_ECC_Root_CA_-_R5.pem
[   32.919222]=20
[   32.926818] Adding debian:Secure_Global_CA.pem
[   32.926820]=20
[   32.933483] Adding debian:Go_Daddy_Class_2_CA.pem
[   32.933485]=20
[   32.941047] Adding debian:D-TRUST_Root_Class_3_CA_2_EV_2009.pem
[   32.941049]=20
[   32.949478] Adding debian:GDCA_TrustAUTH_R5_ROOT.pem
[   32.949480]=20
[   32.957199] Adding debian:Network_Solutions_Certificate_Authority.pem
[   32.957201]=20
[   32.965945] Adding debian:DigiCert_Global_Root_G3.pem
[   32.965947]=20
[   32.973621] Adding debian:USERTrust_ECC_Certification_Authority.pem
[   32.973623]=20
[   32.982073] Adding debian:Amazon_Root_CA_3.pem
[   32.982074]=20
[   32.988980] Adding debian:DigiCert_Trusted_Root_G4.pem
[   32.988981]=20
[   32.996683] Adding debian:COMODO_ECC_Certification_Authority.pem
[   32.996684]=20
[   33.005142] Adding debian:AddTrust_External_Root.pem
[   33.005144]=20
[   33.012613] Adding debian:DigiCert_Global_Root_G2.pem
[   33.012615]=20
[   33.019833] Adding debian:ISRG_Root_X1.pem
[   33.019834]=20
[   33.026960] Adding debian:GeoTrust_Primary_Certification_Authority_-_G2.=
pem
[   33.026962]=20
[   33.036062] Adding debian:ACCVRAIZ1.pem
[   33.036064]=20
[   33.042436] Adding debian:Microsec_e-Szigno_Root_CA_2009.pem
[   33.042438]=20
[   33.050577] Adding debian:Actalis_Authentication_Root_CA.pem
[   33.050578]=20
[   33.058610] Adding debian:DigiCert_Assured_ID_Root_CA.pem
[   33.058611]=20
[   33.066333] Adding debian:TeliaSonera_Root_CA_v1.pem
[   33.066335]=20
[   33.372724] error: dpkg -i /opt/deb/python3_3.7.3-1_amd64.deb failed.
[   33.372727]=20
[   33.495996]=20
[   33.505341] Adding debian:DigiCert_Assured_ID_Root_G2.pem
[   33.505343]=20
[   33.513296] Adding debian:E-Tugra_Certification_Authority.pem
[   33.513298]=20
[   33.522293] Adding debian:VeriSign_Class_3_Public_Primary_Certification_=
Authority_-_G5.pem
[   33.522295]=20
[   33.533231] Adding debian:USERTrust_RSA_Certification_Authority.pem
[   33.533233]=20
[   33.542040] Adding debian:Staat_der_Nederlanden_Root_CA_-_G2.pem
[   33.542041]=20
[   33.550448] Adding debian:Certplus_Class_2_Primary_CA.pem
[   33.550450]=20
[   33.559161] Adding debian:Hellenic_Academic_and_Research_Institutions_EC=
C_RootCA_2015.pem
[   33.559163]=20
[   33.570231] Adding debian:SSL.com_EV_Root_Certification_Authority_RSA_R2=
=2Epem
[   33.570232]=20
[   33.579676] Adding debian:Hongkong_Post_Root_CA_1.pem
[   33.579677]=20
[   33.586841] Adding debian:CFCA_EV_ROOT.pem
[   33.586842]=20
[   33.594042] Adding debian:Autoridad_de_Certificacion_Firmaprofesional_CI=
F_A62634068.pem
[   33.594044]=20
[   33.604336] Adding debian:QuoVadis_Root_CA_1_G3.pem
[   33.604337]=20
[   33.611562] Adding debian:LuxTrust_Global_Root_2.pem
[   33.611564]=20
[   33.619204] Adding debian:SSL.com_Root_Certification_Authority_RSA.pem
[   33.619205]=20
[   33.628033] Adding debian:GeoTrust_Universal_CA_2.pem
[   33.628035]=20
[   33.635646] Adding debian:Staat_der_Nederlanden_Root_CA_-_G3.pem
[   33.635648]=20
[   33.643981] Adding debian:GlobalSign_Root_CA_-_R3.pem
[   33.643983]=20
[   33.651731] Adding debian:GeoTrust_Primary_Certification_Authority.pem
[   33.651733]=20
[   33.660239] Adding debian:EC-ACC.pem
[   33.660241]=20
[   33.665451] done.
[   33.665452]=20
[   33.669776] Setting up libgcc-8-dev:amd64 (8.3.0-6) ...
[   33.669778]=20
[   33.677242] Setting up lib32gcc1 (1:8.3.0-6) ...
[   33.677244]=20
[   33.684002] Setting up gcc-8 (8.3.0-6) ...
[   33.684003]=20
[   33.690201] Setting up gcc (4:8.3.0-1) ...
[   33.690202]=20
[   33.696467] Setting up g++-8 (8.3.0-6) ...
[   33.696469]=20
[   33.702665] Setting up g++ (4:8.3.0-1) ...
[   33.702667]=20
[   33.709991] update-alternatives: using /usr/bin/g++ to provide /usr/bin/=
c++ (c++) in auto mode
[   33.709993]=20
[   33.720930] Setting up libatk1.0-0:amd64 (2.30.0-2) ...
[   33.720932]=20
[   33.728580] Setting up gir1.2-atk-1.0:amd64 (2.30.0-2) ...
[   33.728582]=20
[   33.736368] Setting up python3-lib2to3 (3.7.3-1) ...
[   33.736370]=20
[   33.743741] Setting up python3-distutils (3.7.3-1) ...
[   33.743742]=20
[   33.751314] Setting up libatk1.0-dev:amd64 (2.30.0-2) ...
[   33.751316]=20
[   33.759317] Setting up libexpat1-dev:amd64 (2.2.6-2+deb10u1) ...
[   33.759319]=20
[   33.767727] Processing triggers for libc-bin (2.28-10) ...
[   33.767728]=20
[   33.775608] Processing triggers for mime-support (3.62) ...
[   33.775609]=20
[   33.783755] Processing triggers for ca-certificates (20190110) ...
[   33.783757]=20
[   33.792259] Updating certificates in /etc/ssl/certs...
[   33.792261]=20
[   33.799368] 0 added, 0 removed; done.
[   33.799369]=20
[   33.805602] Running hooks in /etc/ca-certificates/update.d...
[   33.805604]=20
[   33.812805]=20
[   33.812806]=20
[   33.815888] done.
[   33.815890]=20
[   33.819399] done.
[   33.819401]=20
[   33.825045] dpkg: regarding .../python3-minimal_3.7.3-1_amd64.deb contai=
ning python3-minimal, pre-dependency problem:
[   33.825047]=20
[   33.838398]  python3-minimal pre-depends on python3.7-minimal (>=3D 3.7.=
3-1~)
[   33.838400]=20
[   33.848200]   python3.7-minimal is unpacked, but has never been configur=
ed.
[   33.848202]=20
[   33.856635]=20
[   33.856636]=20
[   33.860696] dpkg: warning: ignoring pre-dependency problem!
[   33.860698]=20
[   33.869895] dpkg: regarding .../deb/python3_3.7.3-1_amd64.deb containing=
 python3, pre-dependency problem:
[   33.869897]=20
[   33.882117]  python3 pre-depends on python3-minimal (=3D 3.7.3-1)
[   33.882119]=20
[   33.890879]   python3-minimal is unpacked, but has never been configured.
[   33.890880]=20
[   33.899132]=20
[   33.899133]=20
[   33.903084] dpkg: warning: ignoring pre-dependency problem!
[   33.903086]=20
[   33.912071] dpkg: regarding .../gawk_1%3a4.2.1+dfsg-1_amd64.deb containi=
ng gawk, pre-dependency problem:
[   33.912073]=20
[   33.923810]  gawk pre-depends on libmpfr6 (>=3D 3.1.3)
[   33.923812]=20
[   33.930846]   libmpfr6 is not installed.
[   33.930848]=20
[   33.936248]=20
[   33.936249]=20
[   33.940284] dpkg: warning: ignoring pre-dependency problem!
[   33.940286]=20
[   33.949273] dpkg: regarding .../gawk_1%3a4.2.1+dfsg-1_amd64.deb containi=
ng gawk, pre-dependency problem:
[   33.949274]=20
[   33.961045]  gawk pre-depends on libsigsegv2 (>=3D 2.9)
[   33.961046]=20
[   33.968270]   libsigsegv2 is not installed.
[   33.968271]=20
[   33.973953]=20
[   33.973954]=20
[   33.978007] dpkg: warning: ignoring pre-dependency problem!
[   33.978009]=20
[   33.986728] dpkg: libperl-dev: dependency problems, but configuring anyw=
ay as you requested:
[   33.986729]=20
[   33.997811]  libperl-dev depends on libc6-dev | libc-dev; however:
[   33.997813]=20
[   34.006335]   Package libc6-dev is not installed.
[   34.006336]=20
[   34.013327]   Package libc-dev is not installed.
[   34.013329]=20
[   34.019417]=20
[   34.019418]=20
[   34.024455] dpkg: libpython2.7-dev:amd64: dependency problems, but confi=
guring anyway as you requested:
[   34.024456]=20
[   34.036296]  libpython2.7-dev:amd64 depends on libexpat1-dev.
[   34.036297]=20
[   34.043499]=20
[   34.043500]=20
[   34.048369] dpkg: python2.7-dev: dependency problems, but configuring an=
yway as you requested:
[   34.048371]=20
[   34.059347]  python2.7-dev depends on libexpat1-dev.
[   34.059349]=20
[   34.065776]=20
[   34.065777]=20
[   34.070407] dpkg: gawk: dependency problems, but configuring anyway as y=
ou requested:
[   34.070409]=20
[   34.080650]  gawk depends on libmpfr6 (>=3D 3.1.3); however:
[   34.080651]=20
[   34.088466]   Package libmpfr6 is not installed.
[   34.088467]=20
[   34.095525]  gawk depends on libsigsegv2 (>=3D 2.9); however:
[   34.095527]=20
[   34.103344]   Package libsigsegv2 is not installed.
[   34.103345]=20
[   34.109682]=20
[   34.109683]=20
[   34.114718] dpkg: libpython3.7-stdlib:amd64: dependency problems, but co=
nfiguring anyway as you requested:
[   34.114721]=20
[   34.127128]  libpython3.7-stdlib:amd64 depends on libmpdec2; however:
[   34.127129]=20
[   34.135898]   Package libmpdec2 is not installed.
[   34.135899]=20
[   34.142114]=20
[   34.142115]=20
[   34.146366] dpkg-query: package 'libglib2.0-dev-bin' is not installed
[   34.146368]=20
[   34.155954] Use dpkg --contents (=3D dpkg-deb --contents) to list archiv=
e files contents.
[   34.155956]=20
[   34.166121] Traceback (most recent call last):
[   34.166122]=20
[   34.173036]   File "/usr/bin/py3clean", line 210, in <module>
[   34.173038]=20
[   34.180439]     main()
[   34.180440]=20
[   34.185202]   File "/usr/bin/py3clean", line 196, in main
[   34.185203]=20
[   34.193220]     pfiles =3D set(dpf.from_package(options.package))
[   34.193222]=20
[   34.202136]   File "/usr/share/python3/debpython/files.py", line 53, in =
=66rom_package
[   34.202138]=20
[   34.212672]     raise Exception("cannot get content of %s" % package_nam=
e)
[   34.212674]=20
[   34.222096] Exception: cannot get content of libglib2.0-dev-bin
[   34.222098]=20
[   34.230600] error running python rtupdate hook libglib2.0-dev-bin
[   34.230601]=20
[   34.239197] dpkg: error processing package python3 (--install):
[   34.239198]=20
[   34.248611]  installed python3 package post-installation script subproce=
ss returned error exit status 4
[   34.248613]=20
[   34.261590] dpkg: gtk-update-icon-cache: dependency problems, but config=
uring anyway as you requested:
[   34.261592]=20
[   34.274036]  gtk-update-icon-cache depends on libgdk-pixbuf2.0-0 (>=3D 2=
=2E30.0); however:
[   34.274038]=20
[   34.284453]   Package libgdk-pixbuf2.0-0 is not installed.
[   34.284456]=20
[   34.292890]  gtk-update-icon-cache depends on libglib2.0-0 (>=3D 2.55.2)=
; however:
[   34.292892]=20
[   34.302575]   Package libglib2.0-0 is not installed.
[   34.302577]=20
[   34.309001]=20
[   34.309002]=20
[   34.314009] dpkg: ca-certificates-java: dependency problems, but configu=
ring anyway as you requested:
[   34.314011]=20
[   34.326503]  ca-certificates-java depends on default-jre-headless | java=
8-runtime-headless; however:
[   34.326505]=20
[   34.338099]   Package default-jre-headless is not installed.
[   34.338101]=20
[   34.346251]   Package java8-runtime-headless is not installed.
[   34.346253]=20
[   34.354951]  ca-certificates-java depends on libnss3 (>=3D 3.12.10-2~); =
however:
[   34.354953]=20
[   34.364314]   Package libnss3 is not installed.
[   34.364316]=20
[   34.370347]=20
[   34.370348]=20
[   34.375304] head: cannot open '/etc/ssl/certs/java/cacerts' for reading:=
 No such file or directory
[   34.375306]=20
[   34.386814] dpkg-query: package 'libnss3' is not installed
[   34.386816]=20
[   34.395302] Use dpkg --contents (=3D dpkg-deb --contents) to list archiv=
e files contents.
[   34.395304]=20
[   34.406575] dpkg: libgcc-8-dev:amd64: dependency problems, but configuri=
ng anyway as you requested:
[   34.406576]=20
[   34.418327]  libgcc-8-dev:amd64 depends on libgomp1 (>=3D 8.3.0-6); howe=
ver:
[   34.418329]=20
[   34.427372]   Package libgomp1 is not installed.
[   34.427374]=20
[   34.434900]  libgcc-8-dev:amd64 depends on libitm1 (>=3D 8.3.0-6); howev=
er:
[   34.434901]=20
[   34.443897]   Package libitm1 is not installed.
[   34.443899]=20
[   34.451145]  libgcc-8-dev:amd64 depends on libasan5 (>=3D 8.3.0-6); howe=
ver:
[   34.451146]=20
[   34.460230]   Package libasan5 is not installed.
[   34.460232]=20
[   34.467611]  libgcc-8-dev:amd64 depends on liblsan0 (>=3D 8.3.0-6); howe=
ver:
[   34.467612]=20
[   34.476670]   Package liblsan0 is not installed.
[   34.476672]=20
[   34.484043]  libgcc-8-dev:amd64 depends on libtsan0 (>=3D 8.3.0-6); howe=
ver:
[   34.484045]=20
[   34.493124]   Package libtsan0 is not installed.
[   34.493126]=20
[   34.500520]  libgcc-8-dev:amd64 depends on libubsan1 (>=3D 8.3.0-6); how=
ever:
[   34.500522]=20
[   34.509687]   Package libubsan1 is not installed.
[   34.509688]=20
[   34.517198]  libgcc-8-dev:amd64 depends on libmpx2 (>=3D 8.3.0-6); howev=
er:
[   34.517199]=20
[   34.526193]   Package libmpx2 is not installed.
[   34.526194]=20
[   34.532193]=20
[   34.532195]=20
[   34.536846] dpkg: lib32gcc1: dependency problems, but configuring anyway=
 as you requested:
[   34.536848]=20
[   34.547742]  lib32gcc1 depends on libc6-i386 (>=3D 2.2.4); however:
[   34.547743]=20
[   34.556129]   Package libc6-i386 is not installed.
[   34.556131]=20
[   34.562411]=20
[   34.562412]=20
[   34.567070] dpkg: gcc-8: dependency problems, but configuring anyway as =
you requested:
[   34.567072]=20
[   34.577356]  gcc-8 depends on cpp-8 (=3D 8.3.0-6); however:
[   34.577358]=20
[   34.584915]   Package cpp-8 is not installed.
[   34.584917]=20
[   34.591729]  gcc-8 depends on libcc1-0 (>=3D 8.3.0-6); however:
[   34.591730]=20
[   34.599783]   Package libcc1-0 is not installed.
[   34.599784]=20
[   34.606868]  gcc-8 depends on binutils (>=3D 2.31.1); however:
[   34.606870]=20
[   34.614784]   Package binutils is not installed.
[   34.614786]=20
[   34.621856]  gcc-8 depends on libisl19 (>=3D 0.15); however:
[   34.621858]=20
[   34.629566]   Package libisl19 is not installed.
[   34.629569]=20
[   34.636445]  gcc-8 depends on libmpc3; however:
[   34.636448]=20
[   34.643175]   Package libmpc3 is not installed.
[   34.643176]=20
[   34.650144]  gcc-8 depends on libmpfr6 (>=3D 3.1.3); however:
[   34.650145]=20
[   34.657904]   Package libmpfr6 is not installed.
[   34.657906]=20
[   34.663987]=20
[   34.663988]=20
[   34.668519] dpkg: gcc: dependency problems, but configuring anyway as yo=
u requested:
[   34.668521]=20
[   34.678700]  gcc depends on cpp (=3D 4:8.3.0-1); however:
[   34.678701]=20
[   34.686051]   Package cpp is not installed.
[   34.686053]=20
[   34.691724]=20
[   34.691726]=20
[   34.696440] dpkg: g++-8: dependency problems, but configuring anyway as =
you requested:
[   34.696442]=20
[   34.707082]  g++-8 depends on libstdc++-8-dev (=3D 8.3.0-6); however:
[   34.707084]=20
[   34.715696]   Package libstdc++-8-dev is not installed.
[   34.715697]=20
[   34.723362]  g++-8 depends on libisl19 (>=3D 0.15); however:
[   34.723363]=20
[   34.731019]   Package libisl19 is not installed.
[   34.731021]=20
[   34.737788]  g++-8 depends on libmpc3; however:
[   34.737789]=20
[   34.744507]   Package libmpc3 is not installed.
[   34.744508]=20
[   34.751445]  g++-8 depends on libmpfr6 (>=3D 3.1.3); however:
[   34.751446]=20
[   34.759239]   Package libmpfr6 is not installed.
[   34.759240]=20
[   34.765339]=20
[   34.765341]=20
[   34.769933] dpkg: g++: dependency problems, but configuring anyway as yo=
u requested:
[   34.769935]=20
[   34.780024]  g++ depends on cpp (=3D 4:8.3.0-1); however:
[   34.780026]=20
[   34.787443]   Package cpp is not installed.
[   34.787445]=20
[   34.793106]=20
[   34.793107]=20
[   34.797948] dpkg: libatk1.0-0:amd64: dependency problems, but configurin=
g anyway as you requested:
[   34.797950]=20
[   34.809757]  libatk1.0-0:amd64 depends on libglib2.0-0 (>=3D 2.55.2); ho=
wever:
[   34.809759]=20
[   34.819068]   Package libglib2.0-0 is not installed.
[   34.819069]=20
[   34.825485]=20
[   34.825486]=20
[   34.830296] dpkg: gir1.2-atk-1.0:amd64: dependency problems, but configu=
ring anyway as you requested:
[   34.830297]=20
[   34.842364]  gir1.2-atk-1.0:amd64 depends on gir1.2-glib-2.0 (>=3D 1.32.=
0); however:
[   34.842365]=20
[   34.852277]   Package gir1.2-glib-2.0 is not installed.
[   34.852278]=20
[   34.858974]=20
[   34.858975]=20
[   34.863718] dpkg: python3-lib2to3: dependency problems, but configuring =
anyway as you requested:
[   34.863719]=20
[   34.875144]  python3-lib2to3 depends on python3 (>=3D 3.7.1-1~); however:
[   34.875146]=20
[   34.884033]   Package python3 is not configured yet.
[   34.884035]=20
[   34.891610]  python3-lib2to3 depends on python3 (<< 3.8); however:
[   34.891611]=20
[   34.900062]   Package python3 is not configured yet.
[   34.900063]=20
[   34.906493]=20
[   34.906494]=20
[   34.911297] dpkg: python3-distutils: dependency problems, but configurin=
g anyway as you requested:
[   34.911299]=20
[   34.922933]  python3-distutils depends on python3 (>=3D 3.7.1-1~); howev=
er:
[   34.922934]=20
[   34.931988]   Package python3 is not configured yet.
[   34.931990]=20
[   34.939643]  python3-distutils depends on python3 (<< 3.8); however:
[   34.939645]=20
[   34.948275]   Package python3 is not configured yet.
[   34.948277]=20
[   34.954701]=20
[   34.954702]=20
[   34.959515] dpkg: libatk1.0-dev:amd64: dependency problems, but configur=
ing anyway as you requested:
[   34.959517]=20
[   34.971168]  libatk1.0-dev:amd64 depends on pkg-config; however:
[   34.971170]=20
[   34.979488]   Package pkg-config is not installed.
[   34.979490]=20
[   34.987323]  libatk1.0-dev:amd64 depends on libglib2.0-dev (>=3D 2.31.2)=
; however:
[   34.987324]=20
[   34.997116]   Package libglib2.0-dev is not installed.
[   34.997118]=20
[   35.003719]=20
[   35.003720]=20
[   35.008673] dpkg: libexpat1-dev:amd64: dependency problems, but configur=
ing anyway as you requested:
[   35.008675]=20
[   35.020610]  libexpat1-dev:amd64 depends on libc6-dev | libc-dev; howeve=
r:
[   35.020612]=20
[   35.029760]   Package libc6-dev is not installed.
[   35.029762]=20
[   35.036867]   Package libc-dev is not installed.
[   35.036869]=20
[   35.043051]=20
[   35.043052]=20
[   35.047192] dpkg-query: package 'libnss3' is not installed
[   35.047194]=20
[   35.055815] Use dpkg --contents (=3D dpkg-deb --contents) to list archiv=
e files contents.
[   35.055817]=20
[   35.066255] dpkg-query: package 'libnss3' is not installed
[   35.066257]=20
[   35.074967] Use dpkg --contents (=3D dpkg-deb --contents) to list archiv=
e files contents.
[   35.074970]=20
[   35.085345] Errors were encountered while processing:
[   35.085347]=20
[   35.092043]  python3
[   35.092044]=20
[   35.096305] handle /opt/deb/keep-deb.hw...
[   35.096306]=20
[   35.104223] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/ntpdate_1%3a4.2.8p12+dfsg-4_amd64.deb
[   35.104226]=20
[   35.118159] (Reading database ... 18840 files and directories currently =
installed.)
[   35.118161]=20
[   35.128652] Preparing to unpack .../ntpdate_1%3a4.2.8p12+dfsg-4_amd64.de=
b ...
[   35.128655]=20
[   35.138660] Unpacking ntpdate (1:4.2.8p12+dfsg-4) over (1:4.2.8p12+dfsg-=
4) ...
[   35.138661]=20
[   35.148421] Setting up ntpdate (1:4.2.8p12+dfsg-4) ...
[   35.148423]=20
[   35.156046] handle /opt/deb/keep-deb.perf-sanity-tests...
[   35.156048]=20
[   35.165472] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/libperl5.28_5.28.1-6+deb10u1_amd64.deb
[   35.165474]=20
[   35.179586] (Reading database ... 18840 files and directories currently =
installed.)
[   35.179588]=20
[   35.190129] Preparing to unpack .../libperl5.28_5.28.1-6+deb10u1_amd64.d=
eb ...
[   35.190131]=20
[   35.200602] Unpacking libperl5.28:amd64 (5.28.1-6+deb10u1) over (5.28.1-=
6+deb10u1) ...
[   35.200604]=20
[   35.211217] Setting up libperl5.28:amd64 (5.28.1-6+deb10u1) ...
[   35.211219]=20
[   35.219653] Processing triggers for libc-bin (2.28-10) ...
[   35.219654]=20
[   35.229193] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/perl_5.28.1-6+deb10u1_amd64.deb
[   35.229196]=20
[   35.242803] (Reading database ... 18840 files and directories currently =
installed.)
[   35.242805]=20
[   35.253115] Preparing to unpack .../perl_5.28.1-6+deb10u1_amd64.deb ...
[   35.253117]=20
[   35.262468] Unpacking perl (5.28.1-6+deb10u1) over (5.28.1-6+deb10u1) ...
[   35.262470]=20
[   35.271527] Setting up perl (5.28.1-6+deb10u1) ...
[   35.271528]=20
[   35.280330] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/perl-base_5.28.1-6+deb10u1_amd64.deb
[   35.280331]=20
[   35.294253] (Reading database ... 18840 files and directories currently =
installed.)
[   35.294255]=20
[   35.304785] Preparing to unpack .../perl-base_5.28.1-6+deb10u1_amd64.deb=
 ...
[   35.304787]=20
[   35.314730] Unpacking perl-base (5.28.1-6+deb10u1) over (5.28.1-6+deb10u=
1) ...
[   35.314732]=20
[   35.324361] Setting up perl-base (5.28.1-6+deb10u1) ...
[   35.324363]=20
[   35.333532] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/perl-modules-5.28_5.28.1-6+deb10u1_all.deb
[   35.333534]=20
[   35.347929] (Reading database ... 18840 files and directories currently =
installed.)
[   35.347931]=20
[   35.358457] Preparing to unpack .../perl-modules-5.28_5.28.1-6+deb10u1_a=
ll.deb ...
[   35.358459]=20
[   35.369042] Unpacking perl-modules-5.28 (5.28.1-6+deb10u1) over (5.28.1-=
6+deb10u1) ...
[   35.369044]=20
[   35.379457] Setting up perl-modules-5.28 (5.28.1-6+deb10u1) ...
[   35.379459]=20
[   35.389377] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/libpython3.7-minimal_3.7.3-2+deb10u2_amd64.deb
[   35.389380]=20
[   35.404087] (Reading database ... 18840 files and directories currently =
installed.)
[   35.404089]=20
[   35.414865] Preparing to unpack .../libpython3.7-minimal_3.7.3-2+deb10u2=
_amd64.deb ...
[   35.414867]=20
[   35.425966] Unpacking libpython3.7-minimal:amd64 (3.7.3-2+deb10u2) over =
(3.7.3-2+deb10u2) ...
[   35.425968]=20
[   35.437193] Setting up libpython3.7-minimal:amd64 (3.7.3-2+deb10u2) ...
[   35.437194]=20
[   35.447924] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/python3.7-minimal_3.7.3-2+deb10u2_amd64.deb
[   35.447926]=20
[   35.462659] (Reading database ... 18840 files and directories currently =
installed.)
[   35.462661]=20
[   35.473330] Preparing to unpack .../python3.7-minimal_3.7.3-2+deb10u2_am=
d64.deb ...
[   35.473332]=20
[   35.483955] Unpacking python3.7-minimal (3.7.3-2+deb10u2) over (3.7.3-2+=
deb10u2) ...
[   35.483957]=20
[   35.494189] Setting up python3.7-minimal (3.7.3-2+deb10u2) ...
[   35.494190]=20
[   35.503755] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/python3-minimal_3.7.3-1_amd64.deb
[   35.503757]=20
[   35.517447] (Reading database ... 18840 files and directories currently =
installed.)
[   35.517450]=20
[   35.527936] Preparing to unpack .../python3-minimal_3.7.3-1_amd64.deb ...
[   35.527938]=20
[   35.537355] Unpacking python3-minimal (3.7.3-1) over (3.7.3-1) ...
[   35.537357]=20
[   35.546027] Setting up python3-minimal (3.7.3-1) ...
[   35.546029]=20
[   35.554996] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/libpython3.7-stdlib_3.7.3-2+deb10u2_amd64.deb
[   35.554998]=20
[   35.569760] (Reading database ... 18840 files and directories currently =
installed.)
[   35.569762]=20
[   35.580481] Preparing to unpack .../libpython3.7-stdlib_3.7.3-2+deb10u2_=
amd64.deb ...
[   35.580483]=20
[   35.591550] Unpacking libpython3.7-stdlib:amd64 (3.7.3-2+deb10u2) over (=
3.7.3-2+deb10u2) ...
[   35.591552]=20
[   35.602680] Setting up libpython3.7-stdlib:amd64 (3.7.3-2+deb10u2) ...
[   35.602682]=20
[   35.613062] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/python3.7_3.7.3-2+deb10u2_amd64.deb
[   35.613064]=20
[   35.626958] (Reading database ... 18840 files and directories currently =
installed.)
[   35.626960]=20
[   35.637402] Preparing to unpack .../python3.7_3.7.3-2+deb10u2_amd64.deb =
=2E..
[   35.637404]=20
[   35.647117] Unpacking python3.7 (3.7.3-2+deb10u2) over (3.7.3-2+deb10u2)=
 ...
[   35.647119]=20
[   35.656452] Setting up python3.7 (3.7.3-2+deb10u2) ...
[   35.656453]=20
[   35.664035] Processing triggers for mime-support (3.62) ...
[   35.664036]=20
[   35.673406] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/libpython3-stdlib_3.7.3-1_amd64.deb
[   35.673408]=20
[   35.687232] (Reading database ... 18840 files and directories currently =
installed.)
[   35.687234]=20
[   35.697640] Preparing to unpack .../libpython3-stdlib_3.7.3-1_amd64.deb =
=2E..
[   35.697641]=20
[   35.707450] Unpacking libpython3-stdlib:amd64 (3.7.3-1) over (3.7.3-1) .=
=2E.
[   35.707451]=20
[   35.716892] Setting up libpython3-stdlib:amd64 (3.7.3-1) ...
[   35.716894]=20
[   35.726093] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/python3_3.7.3-1_amd64.deb
[   35.726095]=20
[   35.739198] (Reading database ... 18840 files and directories currently =
installed.)
[   35.739200]=20
[   35.749503] Preparing to unpack .../deb/python3_3.7.3-1_amd64.deb ...
[   35.749505]=20
[   35.758566] running python pre-rtupdate hooks for python3.7...
[   35.758567]=20
[   35.766929] Unpacking python3 (3.7.3-1) over (3.7.3-1) ...
[   35.766930]=20
[   35.774508] Setting up python3 (3.7.3-1) ...
[   35.774510]=20
[   35.781219] running python rtupdate hooks for python3.7...
[   35.781220]=20
[   35.789345] dpkg-query: package 'libglib2.0-dev-bin' is not installed
[   35.789347]=20
[   35.798830] Use dpkg --contents (=3D dpkg-deb --contents) to list archiv=
e files contents.
[   35.798833]=20
[   35.809051] Traceback (most recent call last):
[   35.809053]=20
[   35.815978]   File "/usr/bin/py3clean", line 210, in <module>
[   35.815979]=20
[   35.823410]     main()
[   35.823411]=20
[   35.828273]   File "/usr/bin/py3clean", line 196, in main
[   35.828274]=20
[   35.836222]     pfiles =3D set(dpf.from_package(options.package))
[   35.836224]=20
[   35.845225]   File "/usr/share/python3/debpython/files.py", line 53, in =
=66rom_package
[   35.845226]=20
[   35.855733]     raise Exception("cannot get content of %s" % package_nam=
e)
[   35.855734]=20
[   35.865151] Exception: cannot get content of libglib2.0-dev-bin
[   35.865153]=20
[   35.873784] error running python rtupdate hook libglib2.0-dev-bin
[   35.873786]=20
[   35.882454] dpkg: error processing package python3 (--install):
[   35.882456]=20
[   35.891881]  installed python3 package post-installation script subproce=
ss returned error exit status 4
[   35.891883]=20
[   35.903510] Errors were encountered while processing:
[   35.903512]=20
[   35.910195]  python3
[   35.910197]=20
[   35.914411] /lkp/lkp/src/bin/run-lkp
[   35.914413]=20
[   36.179370] RESULT_ROOT=3D/result/perf-sanity-tests/gcc-ucode=3D0xe2/lkp=
-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea=
9a80b0ee4b4445ea59c806787813/5
[   36.179372]=20
[   36.435520] Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_d=
rm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
[   36.435522]=20
[   36.452245] Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.=
S' differs from latest version at 'arch/x86/lib/memcpy_64.S'
[   36.452247]=20
[   36.468457] Warning: Kernel ABI header at 'tools/arch/x86/lib/memset_64.=
S' differs from latest version at 'arch/x86/lib/memset_64.S'
[   36.468460]=20
[   36.519676] job=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-=
ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59=
c806787813-20201226-25066-sfkgan-4.yaml
[   36.519679]=20
[   40.350636]   PERF_VERSION =3D 5.10.0-rc3
[   40.350639]=20
[   40.360168] result_service: raw_upload, RESULT_MNT: /internal-lkp-server=
/result, RESULT_ROOT: /internal-lkp-server/result/perf-sanity-tests/gcc-uco=
de=3D0xe2/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9=
/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/5, TMP_RESULT_ROOT: /tmp/lkp/resu=
lt
[   40.360171]=20
[   40.392382] run-job /lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gc=
c-ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea=
59c806787813-20201226-25066-sfkgan-4.yaml
[   40.392385]=20
[   41.611992] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=3D=
0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c8067878=
13-20201226-25066-sfkgan-4.yaml&job_state=3Drunning -O /dev/null
[   41.611996]=20
[   41.644528] target ucode: 0xe2
[   41.644530]=20
[   41.649924] current_version: e2, target_version: e2
[   41.649926]=20
[   41.660932] 2020-12-25 16:24:25 make ARCH=3D EXTRA_CFLAGS=3D-fno-omit-fr=
ame-pointer -fsanitize=3Dundefined -fsanitize=3Daddress -C /usr/src/perf_se=
lftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf
[   41.660934]=20
[   41.683892] make: Entering directory '/usr/src/perf_selftests-x86_64-rhe=
l-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf'
[   41.683894]=20
[   41.698151]=20
[   41.705851]   HOSTCC   fixdep.o
[   41.705852]=20
[   41.710930]   HOSTLD   fixdep-in.o
[   41.710932]=20
[   41.716176]   LINK     fixdep
[   41.716178]=20
[   41.722095] diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i=
915_drm.h
[   41.722097]=20
[   41.732334] diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_6=
4.S
[   41.732336]=20
[   41.742050] diff -u tools/arch/x86/lib/memset_64.S arch/x86/lib/memset_6=
4.S
[   41.742051]=20
[   41.750609]=20
[   41.750611]=20
[   41.754328] Auto-detecting system features:
[   41.754329]=20
[   41.761182]=20
[   41.769690]=20
[   41.778208]=20
[   41.786893]=20
[   41.795429]=20
[   41.803979]=20
[   41.812619]=20
[   41.821159]=20
[   41.829636]=20
[   41.838123]=20
[   41.846659]=20
[   41.855116]=20
[   41.863563]=20
[   41.872017]=20
[   41.880470]=20
[   41.888932]=20
[   41.897438]=20
[   41.905966]=20
[   41.914454]=20
[   41.922950]=20
[   41.931442]=20
[   41.938855]=20
[   41.938856]=20
[   41.942405]   CC       fd/array.o
[   41.942406]=20
[   41.947824]   CC       exec-cmd.o
[   41.947826]=20
[   41.953263]   CC       event-parse.o
[   41.953265]=20
[   41.958811]   CC       core.o
[   41.958813]=20
[   41.963933]   LD       fd/libapi-in.o
[   41.963935]=20
[   41.969600]   CC       fs/fs.o
[   41.969602]=20
[   41.974676]   CC       cpumap.o
[   41.974678]=20
[   41.979796]   CC       help.o
[   41.979798]=20
[   41.984990]   CC       fs/tracing_path.o
[   41.984992]=20
[   41.990989]   CC       fs/cgroup.o
[   41.990991]=20
[   41.996521]   LD       fs/libapi-in.o
[   41.996523]=20
[   42.002134]   CC       cpu.o
[   42.002136]=20
[   42.007025]   CC       pager.o
[   42.007027]=20
[   42.012081]   CC       debug.o
[   42.012083]=20
[   42.017218]   CC       threadmap.o
[   42.017220]=20
[   42.022773]   CC       str_error_r.o
[   42.022775]=20
[   42.028425]   LD       libapi-in.o
[   42.028427]=20
[   42.033864]   AR       libapi.a
[   42.033866]=20
[   42.039022]   CC       evsel.o
[   42.039024]=20
[   42.044251]   CC       parse-options.o
[   42.044253]=20
[   42.050020]   CC       evlist.o
[   42.050022]=20
[   42.055125]   CC       mmap.o
[   42.055127]=20
[   42.060233]   CC       event-plugin.o
[   42.060236]=20
[   42.065978]   CC       trace-seq.o
[   42.065981]=20
[   42.071507]   CC       parse-filter.o
[   42.071509]=20
[   42.077037]   CC       zalloc.o
[   42.077039]=20
[   42.082078]   CC       xyarray.o
[   42.082079]=20
[   42.087148]   CC       lib.o
[   42.087149]=20
[   42.092034]   CC       run-command.o
[   42.092036]=20
[   42.097578]   LD       libperf-in.o
[   42.097580]=20
[   42.102974]   AR       libperf.a
[   42.102976]=20
[   42.108186]   CC       parse-utils.o
[   42.108188]=20
[   42.113823]   GEN      bpf_helper_defs.h
[   42.113824]=20
[   42.119767]   CC       kbuffer-parse.o
[   42.119768]=20
[   42.125451]   MKDIR    staticobjs/
[   42.125453]=20
[   42.130967]   CC       staticobjs/libbpf.o
[   42.130968]=20
[   42.136981]   CC       sigchain.o
[   42.136982]=20
[   42.142317]   CC       subcmd-config.o
[   42.142319]=20
[   42.147998]   MKDIR    staticobjs/
[   42.148000]=20
[   42.153436]   CC       staticobjs/bpf.o
[   42.153438]=20
[   42.159264]   CC       tep_strerror.o
[   42.159266]=20
[   42.164937]   LD       libsubcmd-in.o
[   42.164939]=20
[   42.170671]   CC       event-parse-api.o
[   42.170673]=20
[   42.176516]   AR       libsubcmd.a
[   42.176517]=20
[   42.182002]   LD       libtraceevent-in.o
[   42.182004]=20
[   42.188029]   LINK     libtraceevent.a
[   42.188030]=20
[   42.193886]   CC       staticobjs/nlattr.o
[   42.193887]=20
[   42.200021]   CC       staticobjs/btf.o
[   42.200023]=20
[   42.206069]   CC       staticobjs/libbpf_errno.o
[   42.206070]=20
[   42.212842]   CC       staticobjs/str_error.o
[   42.212844]=20
[   42.219160]   GEN      common-cmds.h
[   42.219161]=20
[   42.224853]   CC       staticobjs/netlink.o
[   42.224854]=20
[   42.231300]   CC       staticobjs/bpf_prog_linfo.o
[   42.231301]=20
[   42.238327]   CC       staticobjs/libbpf_probes.o
[   42.238329]=20
[   42.245076]   CC       staticobjs/xsk.o
[   42.245078]=20
[   42.251040]   CC       staticobjs/hashmap.o
[   42.251042]=20
[   42.257357]   CC       staticobjs/btf_dump.o
[   42.257358]=20
[   42.263732]   CC       staticobjs/ringbuf.o
[   42.263734]=20
[   42.269965]   HOSTCC   pmu-events/json.o
[   42.269966]=20
[   42.275933]   HOSTCC   pmu-events/jsmn.o
[   42.275934]=20
[   42.281827]   CC       plugin_jbd2.o
[   42.281829]=20
[   42.287509]   HOSTCC   pmu-events/jevents.o
[   42.287511]=20
[   42.293723]   LD       plugin_jbd2-in.o
[   42.293724]=20
[   42.299592]   CC       plugin_hrtimer.o
[   42.299594]=20
[   42.305512]   LD       plugin_hrtimer-in.o
[   42.305514]=20
[   42.311590]   CC       plugin_kmem.o
[   42.311591]=20
[   42.317338]   HOSTLD   pmu-events/jevents-in.o
[   42.317340]=20
[   42.323814]   CC       jvmti/libjvmti.o
[   42.323815]=20
[   42.329691]   LD       plugin_kmem-in.o
[   42.329692]=20
[   42.335464]   CC       plugin_kvm.o
[   42.335466]=20
[   42.340966]   LD       plugin_kvm-in.o
[   42.340968]=20
[   42.346774]   CC       plugin_mac80211.o
[   42.346776]=20
[   42.352845]   LD       staticobjs/libbpf-in.o
[   42.352847]=20
[   42.359054]   LINK     libbpf.a
[   42.359055]=20
[   42.364143]   GEN      perf-archive
[   42.364144]=20
[   42.369647]   GEN      perf-with-kcore
[   42.369649]=20
[   42.375463]   LINK     pmu-events/jevents
[   42.375465]=20
[   42.381594]   LD       plugin_mac80211-in.o
[   42.381595]=20
[   42.387904]   CC       plugin_sched_switch.o
[   42.387905]=20
[   42.394217]   CC       plugin_function.o
[   42.394218]=20
[   42.400334]   LD       plugin_sched_switch-in.o
[   42.400336]=20
[   42.407035]   GEN      pmu-events/pmu-events.c
[   42.407036]=20
[   42.413591]   LD       plugin_function-in.o
[   42.413592]=20
[   42.419766]   CC       plugin_futex.o
[   42.419768]=20
[   42.425470]   LD       plugin_futex-in.o
[   42.425472]=20
[   42.431339]   CC       plugin_xen.o
[   42.431341]=20
[   42.436841]   LD       plugin_xen-in.o
[   42.436842]=20
[   42.442575]   CC       plugin_scsi.o
[   42.442576]=20
[   42.448329]   CC       pmu-events/pmu-events.o
[   42.448331]=20
[   42.454864]   CC       jvmti/jvmti_agent.o
[   42.454865]=20
[   42.460995]   LD       plugin_scsi-in.o
[   42.460997]=20
[   42.466887]   CC       plugin_cfg80211.o
[   42.466889]=20
[   42.472927]   LD       plugin_cfg80211-in.o
[   42.472929]=20
[   42.479056]   CC       plugin_tlb.o
[   42.479058]=20
[   42.484574]   LD       plugin_tlb-in.o
[   42.484576]=20
[   42.490319]   LINK     plugin_jbd2.so
[   42.490321]=20
[   42.496039]   LINK     plugin_hrtimer.so
[   42.496041]=20
[   42.501950]   LINK     plugin_kmem.so
[   42.501952]=20
[   42.507595]   LINK     plugin_kvm.so
[   42.507597]=20
[   42.513227]   CC       jvmti/libstring.o
[   42.513229]=20
[   42.519204]   LINK     plugin_mac80211.so
[   42.519205]=20
[   42.525227]   CC       jvmti/libctype.o
[   42.525229]=20
[   42.531217]   LINK     plugin_sched_switch.so
[   42.531219]=20
[   42.537645]   LINK     plugin_function.so
[   42.537647]=20
[   42.543672]   LINK     plugin_futex.so
[   42.543673]=20
[   42.549390]   LINK     plugin_xen.so
[   42.549392]=20
[   42.554969]   LINK     plugin_scsi.so
[   42.554971]=20
[   42.560719]   LINK     plugin_cfg80211.so
[   42.560721]=20
[   42.566703]   LINK     plugin_tlb.so
[   42.566705]=20
[   42.572527]   GEN      libtraceevent-dynamic-list
[   42.572529]=20
[   42.579230]   CC       builtin-bench.o
[   42.579231]=20
[   42.585022]   LD       jvmti/jvmti-in.o
[   42.585023]=20
[   42.590887]   LINK     libperf-jvmti.so
[   42.590889]=20
[   42.596795]   CC       builtin-annotate.o
[   42.596796]=20
[   42.602794]   GEN      python/perf.so
[   42.602795]=20
[   42.608703]   LD       pmu-events/pmu-events-in.o
[   42.608705]=20
[   42.615422]   CC       builtin-config.o
[   42.615423]=20
[   42.621241]   CC       builtin-diff.o
[   42.621243]=20
[   42.626929]   CC       builtin-evlist.o
[   42.626930]=20
[   42.632782]   CC       builtin-ftrace.o
[   42.632784]=20
[   42.908623]   CC       builtin-help.o
[   42.908626]=20
[   43.278131]   CC       builtin-sched.o
[   43.278134]=20
[   43.479903]   CC       builtin-buildid-list.o
[   43.479906]=20
[   43.637961]   CC       builtin-buildid-cache.o
[   43.637964]=20
[   44.178879]   CC       builtin-kallsyms.o
[   44.178882]=20
[   44.296438]   CC       builtin-list.o
[   44.296441]=20
[   44.541360]   CC       builtin-record.o
[   44.541363]=20
[   44.681860]   CC       builtin-report.o
[   44.681863]=20
[   46.229454]   CC       builtin-stat.o
[   46.229458]=20
[   47.575999]   CC       builtin-timechart.o
[   47.576001]=20
[   47.775263]   CC       builtin-top.o
[   47.775266]=20
[   49.082379]   CC       builtin-script.o
[   49.082382]=20
[   50.194480]   CC       builtin-kmem.o
[   50.194483]=20
[   50.734297]   CC       builtin-lock.o
[   50.734300]=20
[   51.831119]   CC       builtin-kvm.o
[   51.831123]=20
[   51.987510]   CC       builtin-inject.o
[   51.987513]=20
[   52.427698]   CC       builtin-mem.o
[   52.427701]=20
[   52.905983]   CC       builtin-data.o
[   52.905987]=20
[   52.996708]   CC       builtin-version.o
[   52.996711]=20
[   53.075336]   CC       builtin-c2c.o
[   53.075339]=20
[   53.093168]   CC       builtin-trace.o
[   53.093171]=20
[   53.532551]   CC       builtin-probe.o
[   53.532555]=20
[   54.232259]   CC       bench/sched-messaging.o
[   54.232263]=20
[   54.540743]   CC       bench/sched-pipe.o
[   54.540746]=20
[   54.682993]   CC       bench/syscall.o
[   54.682996]=20
[   54.769056]   CC       bench/mem-functions.o
[   54.769059]=20
[   54.854904]   CC       tests/builtin-test.o
[   54.854907]=20
[   55.022920]   CC       bench/futex-hash.o
[   55.022923]=20
[   55.228906]   CC       bench/futex-wake.o
[   55.228910]=20
[   55.342497]   CC       tests/parse-events.o
[   55.342500]=20
[   55.396411]   CC       bench/futex-wake-parallel.o
[   55.396414]=20
[   55.637476]   CC       bench/futex-requeue.o
[   55.637479]=20
[   55.821312]   CC       bench/futex-lock-pi.o
[   55.821315]=20
[   56.045377]   CC       bench/epoll-wait.o
[   56.045381]=20
[   56.097953]   CC       util/annotate.o
[   56.097956]=20
[   56.453692]   CC       bench/epoll-ctl.o
[   56.453695]=20
[   56.861059]   CC       bench/synthesize.o
[   56.861062]=20
[   57.084508]   CC       bench/kallsyms-parse.o
[   57.084511]=20
[   57.180344]   CC       bench/find-bit-bench.o
[   57.180347]=20
[   57.324215]   CC       bench/inject-buildid.o
[   57.324217]=20
[   57.758673]   CC       bench/mem-memcpy-x86-64-asm.o
[   57.758676]=20
[   57.781607]   CC       bench/mem-memset-x86-64-asm.o
[   57.781609]=20
[   57.795426]   CC       bench/numa.o
[   57.795428]=20
[   57.923166]   CC       tests/dso-data.o
[   57.923170]=20
[   58.193362]   CC       tests/attr.o
[   58.193365]=20
[   58.543834]   CC       tests/vmlinux-kallsyms.o
[   58.543837]=20
[   58.796486]   CC       tests/openat-syscall.o
[   58.796489]=20
[   58.907726]   CC       tests/openat-syscall-all-cpus.o
[   58.907730]=20
[   59.113706]   CC       tests/openat-syscall-tp-fields.o
[   59.113709]=20
[   59.282651]   CC       tests/mmap-basic.o
[   59.282654]=20
[   59.608964]   CC       tests/perf-record.o
[   59.608967]=20
[   59.987542]   CC       tests/evsel-roundtrip-name.o
[   59.987554]=20
[   60.124199]   CC       tests/evsel-tp-sched.o
[   60.124202]=20
[   60.195016]   CC       util/block-info.o
[   60.195019]=20
[   60.218099]   CC       tests/fdarray.o
[   60.218103]=20
[   60.224448]   LD       bench/perf-in.o
[   60.224450]=20
[   60.260887]   CC       arch/common.o
[   60.260890]=20
[   60.291710]   CC       util/block-range.o
[   60.291713]=20
[   60.384170]   CC       arch/x86/util/header.o
[   60.384173]=20
[   60.523369]   CC       arch/x86/util/tsc.o
[   60.523373]=20
[   60.545488]   CC       tests/pmu.o
[   60.545491]=20
[   60.560608]   CC       arch/x86/util/pmu.o
[   60.560610]=20
[   60.646667]   CC       arch/x86/util/kvm-stat.o
[   60.646669]=20
[   60.680378]   CC       tests/pmu-events.o
[   60.680381]=20
[   60.734988]   CC       arch/x86/tests/regs_load.o
[   60.734991]=20
[   60.757917]   CC       arch/x86/tests/dwarf-unwind.o
[   60.757920]=20
[   60.789298]   CC       arch/x86/util/perf_regs.o
[   60.789301]=20
[   60.877259]   CC       arch/x86/tests/arch-tests.o
[   60.877262]=20
[   60.912394]   CC       arch/x86/tests/rdpmc.o
[   60.912397]=20
[   60.972954]   CC       arch/x86/util/topdown.o
[   60.972957]=20
[   61.062087]   CC       arch/x86/util/machine.o
[   61.062090]=20
[   61.114775]   CC       arch/x86/tests/perf-time-to-tsc.o
[   61.114778]=20
[   61.154451]   CC       util/build-id.o
[   61.154454]=20
[   61.219174]   CC       arch/x86/util/event.o
[   61.219177]=20
[   61.308495]   CC       arch/x86/tests/insn-x86.o
[   61.308499]=20
[   61.349020]   CC       tests/hists_common.o
[   61.349023]=20
[   61.361523]   CC       arch/x86/util/dwarf-regs.o
[   61.361526]=20
[   61.420332]   CC       arch/x86/util/unwind-libunwind.o
[   61.420335]=20
[   61.473851]   CC       arch/x86/util/auxtrace.o
[   61.473854]=20
[   61.528840]   CC       arch/x86/tests/intel-pt-pkt-decoder-test.o
[   61.528843]=20
[   61.617734]   CC       tests/hists_link.o
[   61.617737]=20
[   61.632890]   CC       arch/x86/util/archinsn.o
[   61.632893]=20
[   61.683991]   CC       arch/x86/tests/bp-modify.o
[   61.683994]=20
[   61.751476]   CC       arch/x86/util/intel-pt.o
[   61.751479]=20
[   61.835086]   LD       arch/x86/tests/perf-in.o
[   61.835089]=20
[   61.847769]   CC       arch/x86/util/intel-bts.o
[   61.847772]=20
[   61.867443]   CC       util/cacheline.o
[   61.867446]=20
[   61.904239]   CC       util/config.o
[   61.904242]=20
[   61.977941]   CC       tests/hists_filter.o
[   61.977944]=20
[   62.382008]   CC       tests/hists_output.o
[   62.382011]=20
[   62.405733]   CC       tests/hists_cumulate.o
[   62.405736]=20
[   62.545049]   CC       util/copyfile.o
[   62.545052]=20
[   62.672113]   CC       util/ctype.o
[   62.672116]=20
[   62.702029]   CC       util/db-export.o
[   62.702032]=20
[   63.013555]   LD       arch/x86/util/perf-in.o
[   63.013558]=20
[   63.041420]   LD       arch/x86/perf-in.o
[   63.041423]=20
[   63.061942]   LD       arch/perf-in.o
[   63.061945]=20
[   63.083470]   CC       ui/setup.o
[   63.083473]=20
[   63.179757]   CC       ui/helpline.o
[   63.179760]=20
[   63.285982]   CC       ui/progress.o
[   63.285985]=20
[   63.358594]   CC       ui/util.o
[   63.358596]=20
[   63.436649]   CC       ui/hist.o
[   63.436652]=20
[   63.472374]   CC       tests/python-use.o
[   63.472377]=20
[   63.529827]   CC       tests/bp_signal.o
[   63.529829]=20
[   63.607608]   CC       util/env.o
[   63.607610]=20
[   63.658651]   CC       tests/bp_signal_overflow.o
[   63.658654]=20
[   63.669882]   CC       tests/bp_account.o
[   63.669885]=20
[   63.766963]   CC       tests/wp.o
[   63.766966]=20
[   63.943679]   CC       util/event.o
[   63.943682]=20
[   63.991261]   CC       tests/task-exit.o
[   63.991264]=20
[   64.040936]   CC       util/evlist.o
[   64.040938]=20
[   64.132153]   CC       tests/sw-clock.o
[   64.132156]=20
[   64.275927]   CC       tests/mmap-thread-lookup.o
[   64.275930]=20
[   64.520073]   CC       tests/thread-maps-share.o
[   64.520076]=20
[   64.693439]   CC       tests/switch-tracking.o
[   64.693442]=20
[   64.721448]   CC       util/sideband_evlist.o
[   64.721451]=20
[   64.903392]   CC       util/evsel.o
[   64.903395]=20
[   65.173948]   CC       tests/keep-tracking.o
[   65.173951]=20
[   65.324399]   CC       tests/code-reading.o
[   65.324402]=20
[   66.082243]   CC       tests/sample-parsing.o
[   66.082246]=20
[   66.181531]   CC       util/evsel_fprintf.o
[   66.181534]=20
[   66.504389]   CC       util/perf_event_attr_fprintf.o
[   66.504392]=20
[   66.651780]   CC       tests/parse-no-sample-id-all.o
[   66.651783]=20
[   66.777145]   CC       tests/kmod-path.o
[   66.777148]=20
[   67.034998]   CC       util/evswitch.o
[   67.035001]=20
[   67.094623]   CC       tests/thread-map.o
[   67.094626]=20
[   67.147435]   CC       util/find_bit.o
[   67.147438]=20
[   67.269026]   CC       tests/llvm.o
[   67.269030]=20
[   67.278967]   CC       util/get_current_dir_name.o
[   67.278969]=20
[   67.302902]   CC       util/kallsyms.o
[   67.302905]=20
[   67.408239]   CC       tests/bpf.o
[   67.408243]=20
[   67.556698]   CC       util/levenshtein.o
[   67.556701]=20
[   67.672587]   CC       tests/topology.o
[   67.672590]=20
[   67.683532]   CC       util/llvm-utils.o
[   67.683535]=20
[   67.859475]   CC       tests/mem.o
[   67.859478]=20
[   67.946671]   CC       tests/cpumap.o
[   67.946674]=20
[   68.023789]   CC       util/mmap.o
[   68.023792]=20
[   68.137902]   CC       tests/stat.o
[   68.137905]=20
[   68.319832]   CC       tests/event_update.o
[   68.319835]=20
[   68.357681]   CC       util/memswap.o
[   68.357684]=20
[   68.400539]   BISON    util/parse-events-bison.c
[   68.400541]=20
[   68.466551]   CC       util/perf_regs.o
[   68.466554]=20
[   68.488897]   CC       util/path.o
[   68.488899]=20
[   68.509521]   CC       tests/event-times.o
[   68.509524]=20
[   68.549676]   CC       util/print_binary.o
[   68.549679]=20
[   68.584966]   CC       util/rlimit.o
[   68.584969]=20
[   68.625501]   CC       util/argv_split.o
[   68.625504]=20
[   68.647172]   CC       util/rbtree.o
[   68.647175]=20
[   68.716127]   CC       util/libstring.o
[   68.716130]=20
[   68.821941]   CC       tests/expr.o
[   68.821944]=20
[   68.831499]   CC       util/bitmap.o
[   68.831501]=20
[   68.969502]   CC       tests/backward-ring-buffer.o
[   68.969505]=20
[   68.987170]   CC       tests/sdt.o
[   68.987173]=20
[   69.107211]   CC       tests/is_printable_array.o
[   69.107214]=20
[   69.130092]   CC       tests/bitmap.o
[   69.130095]=20
[   69.189765]   CC       tests/perf-hooks.o
[   69.189768]=20
[   69.231346]   CC       tests/clang.o
[   69.231348]=20
[   69.247785]   CC       tests/unit_number__scnprintf.o
[   69.247787]=20
[   69.269065]   CC       util/hweight.o
[   69.269068]=20
[   69.315200]   CC       tests/mem2node.o
[   69.315203]=20
[   69.321009]   CC       util/smt.o
[   69.321011]=20
[   69.399954]   CC       util/strbuf.o
[   69.399956]=20
[   69.452258]   CC       tests/maps.o
[   69.452260]=20
[   69.502244]   CC       ui/stdio/hist.o
[   69.502247]=20
[   69.612967]   CC       util/string.o
[   69.612969]=20
[   69.669331]   CC       tests/time-utils-test.o
[   69.669334]=20
[   69.743839]   CC       util/strlist.o
[   69.743842]=20
[   69.852182]   CC       util/strfilter.o
[   69.852185]=20
[   69.921236]   CC       util/top.o
[   69.921240]=20
[   69.972555]   CC       tests/genelf.o
[   69.972558]=20
[   70.045834]   CC       tests/api-io.o
[   70.045837]=20
[   70.211602]   CC       util/usage.o
[   70.211605]=20
[   70.267615]   CC       util/dso.o
[   70.267618]=20
[   70.406124]   CC       tests/demangle-java-test.o
[   70.406127]=20
[   70.509956]   CC       tests/pfm.o
[   70.509959]=20
[   70.582724]   CC       tests/parse-metric.o
[   70.582728]=20
[   70.664368]   CC       ui/browser.o
[   70.664371]=20
[   70.856669]   CC       tests/pe-file-parsing.o
[   70.856672]=20
[   70.997726]   CC       tests/expand-cgroup.o
[   70.997729]=20
[   71.323272]   CC       tests/dwarf-unwind.o
[   71.323275]=20
[   71.475913]   CC       ui/browsers/annotate.o
[   71.475916]=20
[   71.503834]   CC       tests/llvm-src-base.o
[   71.503837]=20
[   71.531506]   CC       tests/llvm-src-kbuild.o
[   71.531509]=20
[   71.542163]   CC       util/dsos.o
[   71.542166]=20
[   71.559260]   CC       tests/llvm-src-prologue.o
[   71.559262]=20
[   71.586296]   CC       tests/llvm-src-relocation.o
[   71.586300]=20
[   71.612823]   LD       tests/perf-in.o
[   71.612825]=20
[   71.732652]   CC       scripts/perl/Perf-Trace-Util/Context.o
[   71.732655]=20
[   71.897947]   CC       util/symbol.o
[   71.897950]=20
[   71.996256]   CC       scripts/python/Perf-Trace-Util/Context.o
[   71.996259]=20
[   72.132653]   LD       scripts/python/Perf-Trace-Util/perf-in.o
[   72.132656]=20
[   72.140899]   CC       util/symbol_fprintf.o
[   72.140901]=20
[   72.300213]   CC       util/color.o
[   72.300215]=20
[   72.320392]   LD       scripts/perl/Perf-Trace-Util/perf-in.o
[   72.320395]=20
[   72.346610]   LD       scripts/perf-in.o
[   72.346612]=20
[   72.373291]   CC       util/color_config.o
[   72.373294]=20
[   72.479749]   CC       trace/beauty/clone.o
[   72.479752]=20
[   72.491422]   CC       perf.o
[   72.491424]=20
[   72.627074]   CC       trace/beauty/fcntl.o
[   72.627076]=20
[   72.720004]   CC       trace/beauty/flock.o
[   72.720007]=20
[   72.812593]   CC       trace/beauty/fsmount.o
[   72.812596]=20
[   72.857013]   CC       util/metricgroup.o
[   72.857016]=20
[   72.866773]   CC       trace/beauty/fspick.o
[   72.866776]=20
[   72.879195]   CC       ui/browsers/hists.o
[   72.879198]=20
[   72.928231]   CC       trace/beauty/ioctl.o
[   72.928234]=20
[   73.097468]   CC       trace/beauty/kcmp.o
[   73.097471]=20
[   73.169861]   CC       trace/beauty/mount_flags.o
[   73.169864]=20
[   73.229390]   CC       trace/beauty/move_mount.o
[   73.229393]=20
[   73.281588]   CC       trace/beauty/pkey_alloc.o
[   73.281591]=20
[   73.439799]   CC       trace/beauty/arch_prctl.o
[   73.439802]=20
[   73.484894]   CC       trace/beauty/prctl.o
[   73.484897]=20
[   73.567834]   CC       trace/beauty/renameat.o
[   73.567837]=20
[   73.614854]   CC       trace/beauty/sockaddr.o
[   73.614857]=20
[   73.734373]   CC       trace/beauty/socket.o
[   73.734376]=20
[   73.787273]   CC       trace/beauty/statx.o
[   73.787276]=20
[   73.916600]   CC       trace/beauty/sync_file_range.o
[   73.916603]=20
[   73.983966]   CC       trace/beauty/tracepoints/x86_irq_vectors.o
[   73.983969]=20
[   74.040825]   CC       trace/beauty/tracepoints/x86_msr.o
[   74.040828]=20
[   74.101781]   LD       trace/beauty/tracepoints/perf-in.o
[   74.101784]=20
[   74.109507]   LD       trace/beauty/perf-in.o
[   74.109509]=20
[   74.126086]   CC       util/header.o
[   74.126089]=20
[   74.145426]   CC       util/callchain.o
[   74.145429]=20
[   74.255289]   CC       util/values.o
[   74.255292]=20
[   74.816935]   CC       util/debug.o
[   74.816939]=20
[   75.043371]   CC       util/fncache.o
[   75.043373]=20
[   75.180838]   CC       util/machine.o
[   75.180841]=20
[   76.172052]   CC       util/map.o
[   76.172056]=20
[   77.536682]   CC       util/pstack.o
[   77.536685]=20
[   77.644249]   CC       util/session.o
[   77.644251]=20
[   78.843021]   CC       util/sample-raw.o
[   78.843024]=20
[   78.885600]   CC       util/s390-sample-raw.o
[   78.885603]=20
[   78.931757]   CC       util/syscalltbl.o
[   78.931760]=20
[   79.103228]   CC       util/ordered-events.o
[   79.103231]=20
[   79.161504]   CC       util/namespaces.o
[   79.161507]=20
[   79.469658]   CC       util/comm.o
[   79.469661]=20
[   79.649867]   CC       util/thread.o
[   79.649870]=20
[   79.801952]   CC       util/thread_map.o
[   79.801955]=20
[   80.095891]   CC       ui/browsers/map.o
[   80.095894]=20
[   80.203011]   CC       util/trace-event-parse.o
[   80.203014]=20
[   80.259837]   CC       util/parse-events-bison.o
[   80.259841]=20
[   80.270866]   CC       ui/browsers/scripts.o
[   80.270869]=20
[   80.390410]   CC       ui/browsers/header.o
[   80.390413]=20
[   80.551060]   CC       ui/browsers/res_sample.o
[   80.551063]=20
[   80.581507]   BISON    util/pmu-bison.c
[   80.581510]=20
[   80.609574]   CC       util/trace-event-read.o
[   80.609578]=20
[   80.717878]   CC       util/trace-event-info.o
[   80.717881]=20
[   80.843929]   CC       util/trace-event-scripting.o
[   80.843932]=20
[   80.939917]   CC       util/trace-event.o
[   80.939920]=20
[   81.091798]   CC       util/svghelper.o
[   81.091801]=20
[   81.162072]   CC       util/sort.o
[   81.162075]=20
[   81.825775]   CC       util/hist.o
[   81.825777]=20
[   82.330656]   CC       util/util.o
[   82.330659]=20
[   82.665015]   CC       util/cpumap.o
[   82.665018]=20
[   82.883485]   LD       ui/browsers/perf-in.o
[   82.883488]=20
[   82.918031]   CC       ui/tui/setup.o
[   82.918034]=20
[   83.048132]   CC       ui/tui/util.o
[   83.048136]=20
[   83.293443]   CC       ui/tui/helpline.o
[   83.293446]=20
[   83.328496]   CC       util/affinity.o
[   83.328499]=20
[   83.378411]   CC       ui/tui/progress.o
[   83.378414]=20
[   83.423236]   CC       util/cputopo.o
[   83.423239]=20
[   83.490525]   LD       ui/tui/perf-in.o
[   83.490528]=20
[   83.498892]   LD       ui/perf-in.o
[   83.498895]=20
[   83.546776]   CC       util/cgroup.o
[   83.546779]=20
[   83.702682]   CC       util/target.o
[   83.702685]=20
[   83.837416]   CC       util/rblist.o
[   83.837420]=20
[   83.990294]   CC       util/intlist.o
[   83.990298]=20
[   84.079340]   CC       util/vdso.o
[   84.079343]=20
[   84.156148]   CC       util/counts.o
[   84.156151]=20
[   84.163841]   CC       util/stat.o
[   84.163844]=20
[   84.269112]   CC       util/stat-shadow.o
[   84.269115]=20
[   84.339768]   CC       util/stat-display.o
[   84.339771]=20
[   84.894150]   CC       util/perf_api_probe.o
[   84.894154]=20
[   85.174366]   CC       util/record.o
[   85.174370]=20
[   85.489153]   CC       util/srcline.o
[   85.489156]=20
[   86.063672]   CC       util/srccode.o
[   86.063674]=20
[   86.236314]   CC       util/synthetic-events.o
[   86.236317]=20
[   86.310802]   CC       util/data.o
[   86.310805]=20
[   86.563642]   CC       util/tsc.o
[   86.563645]=20
[   86.722854]   CC       util/cloexec.o
[   86.722857]=20
[   86.786063]   CC       util/call-path.o
[   86.786066]=20
[   86.846848]   CC       util/rwsem.o
[   86.846851]=20
[   86.923062]   CC       util/thread-stack.o
[   86.923065]=20
[   87.053689]   CC       util/spark.o
[   87.053692]=20
[   87.129038]   CC       util/topdown.o
[   87.129041]=20
[   87.137141]   CC       util/stream.o
[   87.137143]=20
[   87.239820]   CC       util/auxtrace.o
[   87.239822]=20
[   87.487416]   CC       util/intel-pt-decoder/intel-pt-pkt-decoder.o
[   87.487419]=20
[   87.969830]   GEN      util/intel-pt-decoder/inat-tables.c
[   87.969834]=20
[   87.989383]   CC       util/intel-pt-decoder/intel-pt-log.o
[   87.989386]=20
[   88.098416]   CC       util/intel-pt-decoder/intel-pt-decoder.o
[   88.098420]=20
[   88.587384]   CC       util/arm-spe-decoder/arm-spe-pkt-decoder.o
[   88.587387]=20
[   88.758135]   CC       util/scripting-engines/trace-event-perl.o
[   88.758138]=20
[   88.923360]   CC       util/arm-spe-decoder/arm-spe-decoder.o
[   88.923364]=20
[   89.141085]   LD       util/arm-spe-decoder/perf-in.o
[   89.141088]=20
[   89.154143]   CC       util/intel-pt.o
[   89.154145]=20
[   90.111447]   CC       util/scripting-engines/trace-event-python.o
[   90.111450]=20
[   90.340128]   CC       util/intel-bts.o
[   90.340131]=20
[   91.314036]   CC       util/arm-spe.o
[   91.314039]=20
[   92.139767]   CC       util/intel-pt-decoder/intel-pt-insn-decoder.o
[   92.139770]=20
[   92.418047]   CC       util/s390-cpumsf.o
[   92.418050]=20
[   92.484918] IPMI BMC is not supported on this machine, skip bmc-watchdog=
 setup!
[   92.484920]=20
[   92.730034]   LD       util/scripting-engines/perf-in.o
[   92.730036]=20
[   92.746003]   CC       util/parse-branch-options.o
[   92.746006]=20
[   92.836998]   CC       util/dump-insn.o
[   92.837001]=20
[   92.874219]   CC       util/parse-regs-options.o
[   92.874222]=20
[   92.973847]   CC       util/parse-sublevel-options.o
[   92.973850]=20
[   93.049678]   CC       util/term.o
[   93.049681]=20
[   93.120614]   CC       util/help-unknown-cmd.o
[   93.120617]=20
[   93.271369]   CC       util/mem-events.o
[   93.271372]=20
[   93.326866]   LD       util/intel-pt-decoder/perf-in.o
[   93.326869]=20
[   93.339617]   CC       util/vsprintf.o
[   93.339620]=20
[   93.381871]   CC       util/units.o
[   93.381874]=20
[   93.406993]   CC       util/time-utils.o
[   93.406996]=20
[   93.463545]   BISON    util/expr-bison.c
[   93.463553]=20
[   93.504588]   CC       util/branch.o
[   93.504591]=20
[   93.762057]   CC       util/mem2node.o
[   93.762060]=20
[   93.815592]   CC       util/clockid.o
[   93.815595]=20
[   93.881437]   CC       util/bpf-loader.o
[   93.881440]=20
[   93.915771]   CC       util/bpf_map.o
[   93.915773]=20
[   93.951612]   CC       util/bpf-prologue.o
[   93.951614]=20
[   94.001444]   CC       util/symbol-elf.o
[   94.001447]=20
[   94.477775]   CC       util/probe-file.o
[   94.477778]=20
[   94.504345]   CC       util/probe-event.o
[   94.504348]=20
[   95.181043]   CC       util/probe-finder.o
[   95.181046]=20
[   95.489640]   CC       util/dwarf-aux.o
[   95.489643]=20
[   95.962112]   CC       util/dwarf-regs.o
[   95.962116]=20
[   96.036715]   CC       util/unwind-libunwind-local.o
[   96.036718]=20
[   96.193677]   CC       util/unwind-libunwind.o
[   96.193680]=20
[   96.335833]   CC       util/data-convert-bt.o
[   96.335837]=20
[   96.394239]   CC       util/zlib.o
[   96.394242]=20
[   96.481037]   CC       util/lzma.o
[   96.481040]=20
[   96.586914]   CC       util/zstd.o
[   96.586918]=20
[   96.686258]   CC       util/cap.o
[   96.686261]=20
[   96.724492]   CC       util/demangle-java.o
[   96.724495]=20
[   96.906327]   CC       util/demangle-rust.o
[   96.906330]=20
[   96.961749]   CC       util/jitdump.o
[   96.961752]=20
[   97.260961]   CC       util/genelf.o
[   97.260965]=20
[   97.509677]   CC       util/genelf_debug.o
[   97.509680]=20
[   97.688485]   CC       util/perf-hooks.o
[   97.688488]=20
[   97.817401]   CC       util/bpf-event.o
[   97.817404]=20
[   97.823441]   FLEX     util/parse-events-flex.c
[   97.823443]=20
[   97.852623]   FLEX     util/pmu-flex.c
[   97.852626]=20
[   97.871335]   CC       util/pmu-bison.o
[   97.871338]=20
[   98.072121]   FLEX     util/expr-flex.c
[   98.072124]=20
[   98.084325]   CC       util/expr-bison.o
[   98.084328]=20
[   98.134994]   CC       util/expr.o
[   98.134997]=20
[   98.336288]   CC       util/parse-events.o
[   98.336291]=20
[   98.373211]   CC       util/parse-events-flex.o
[   98.373214]=20
[   98.668838]   CC       util/pmu.o
[   98.668841]=20
[   98.766785]   CC       util/pmu-flex.o
[   98.766788]=20
[   99.801582]   CC       util/expr-flex.o
[   99.801584]=20
[  105.305151]   LD       util/perf-in.o
[  105.305153]=20
[  105.608741]   LD       perf-in.o
[  105.608743]=20
[  105.912677]   LINK     perf
[  105.912679]=20
[  106.861220] make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf'
[  106.861223]=20
[  106.876156] Key type dns_resolver registered
[  106.876872] 2020-12-25 16:25:39 cd /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf
[  106.880391]=20
[  106.893875] 2020-12-25 16:25:39 mkdir -p /pkg
[  106.893876]=20
[  106.900982] 2020-12-25 16:25:39 mkdir -p /kbuild/obj/consumer/x86_64-rhe=
l-8.3
[  106.900983]=20
[  107.022136] NFS: Registering the id_resolver key type
[  107.027153] Key type id_resolver registered
[  107.031317] Key type id_legacy registered
[  107.080318] 2020-12-25 16:25:39 cp /pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b=
1ba0e7ea9a80b0ee4b4445ea59c806787813/vmlinux.xz /tmp
[  107.080320]=20
[  107.568302] 2020-12-25 16:25:40 unxz -k /tmp/vmlinux.xz
[  107.568304]=20
[  111.277609] 2020-12-25 16:25:44 cp /tmp/vmlinux /kbuild/obj/consumer/x86=
_64-rhel-8.3
[  111.277612]=20
[  111.408565] ignored_by_lkp: BPF filter
[  111.408567]=20
[  111.450570] ignored_by_lkp: LLVM search and compile
[  111.450573]=20
[  111.491919] ignored_by_lkp: Add vfs_getname probe to get syscall args fi=
lenames
[  111.491923]=20
[  111.532915] ignored_by_lkp: Use vfs_getname probe to get syscall args fi=
lenames
[  111.532918]=20
[  111.574082] ignored_by_lkp: Check open filename arg using perf trace + v=
fs_getname
[  111.574085]=20
[  111.614721] ignored_by_lkp: builtin clang support
[  111.614737]=20
[  111.662896] 2020-12-25 16:25:44 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 1
[  111.662898]=20
[  112.494369]  1: vmlinux symtab matches kallsyms                         =
        : Ok
[  112.494373]=20
[  112.515321] 2020-12-25 16:25:45 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 2
[  112.515323]=20
[  112.580941]  2: Detect openat syscall event                             =
        : Ok
[  112.580944]=20
[  112.601463] 2020-12-25 16:25:45 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 3
[  112.601465]=20
[  112.670091]  3: Detect openat syscall event on all cpus                 =
        : Ok
[  112.670094]=20
[  112.691113] 2020-12-25 16:25:45 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 4
[  112.691116]=20
[  112.813020]  4: Read samples using the mmap interface                   =
        : FAILED!
[  112.813023]=20
[  112.834024] 2020-12-25 16:25:45 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 5
[  112.834027]=20
[  112.878434]  5: Test data source output                                 =
        : Ok
[  112.878436]=20
[  112.898869] 2020-12-25 16:25:45 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 6
[  112.898872]=20
[  114.181584]  6: Parse event definition strings                          =
        : FAILED!
[  114.181601]=20
[  114.201812] 2020-12-25 16:25:47 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 7
[  114.201814]=20
[  114.247836]  7: Simple expression parser                                =
        : Ok
[  114.247839]=20
[  114.268764] 2020-12-25 16:25:47 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 8
[  114.268767]=20
[  116.326288]  8: PERF_RECORD_* events & perf_sample fields               =
        : Ok
[  116.326291]=20
[  116.346857] 2020-12-25 16:25:49 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 9
[  116.346859]=20
[  116.398116]  9: Parse perf pmu format                                   =
        : Ok
[  116.398119]=20
[  116.418850] 2020-12-25 16:25:49 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 10
[  116.418853]=20
[  116.445990] 10: PMU events                                              =
        :
[  116.445993]=20
[  116.464657] 10.1: PMU event table sanity                                =
        : Ok
[  116.464660]=20
[  116.551692] 10.2: PMU event map aliases                                 =
        : Ok
[  116.551694]=20
[  118.242663] 10.3: Parsing of PMU event table metrics                    =
        : Skip (some metrics failed)
[  118.242666]=20
[  118.371444] 10.4: Parsing of PMU event table metrics with fake PMUs     =
        : Ok
[  118.371447]=20
[  118.392337] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 11
[  118.392339]=20
[  118.438031] 11: DSO data read                                           =
        : Ok
[  118.438034]=20
[  118.458965] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 12
[  118.458967]=20
[  118.505934] 12: DSO data cache                                          =
        : Ok
[  118.505937]=20
[  118.526529] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 13
[  118.526531]=20
[  118.573140] 13: DSO data reopen                                         =
        : Ok
[  118.573143]=20
[  118.593876] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 14
[  118.593879]=20
[  118.640613] 14: Roundtrip evsel->name                                   =
        : Ok
[  118.640617]=20
[  118.661177] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 15
[  118.661180]=20
[  118.708521] 15: Parse sched tracepoints fields                          =
        : Ok
[  118.708523]=20
[  118.729055] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 16
[  118.729057]=20
[  118.796829] 16: syscalls:sys_enter_openat event fields                  =
        : Ok
[  118.796831]=20
[  118.817097] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 17
[  118.817100]=20
[  132.920286] 17: Setup struct perf_event_attr                            =
        : Ok
[  132.920288]=20
[  132.940728] 2020-12-25 16:26:05 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 18
[  132.940730]=20
[  132.985757] 18: Match and link multiple hists                           =
        : Ok
[  132.985760]=20
[  133.006200] 2020-12-25 16:26:05 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 19
[  133.006202]=20
[  133.063471] 19: 'import perf' in python                                 =
        : FAILED!
[  133.063474]=20
[  133.083996] 2020-12-25 16:26:05 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 20
[  133.083999]=20
[  133.130030] 20: Breakpoint overflow signal handler                      =
        : Ok
[  133.130033]=20
[  133.151059] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 21
[  133.151061]=20
[  133.204150] 21: Breakpoint overflow sampling                            =
        : Ok
[  133.204153]=20
[  133.224792] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 22
[  133.224794]=20
[  133.270011] 22: Breakpoint accounting                                   =
        : Ok
[  133.270014]=20
[  133.290812] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 23
[  133.290814]=20
[  133.317877] 23: Watchpoint                                              =
        :
[  133.317880]=20
[  133.336340] 23.1: Read Only Watchpoint                                  =
        : Skip
[  133.336342]=20
[  133.354651] 23.2: Write Only Watchpoint                                 =
        : Ok
[  133.354653]=20
[  133.372948] 23.3: Read / Write Watchpoint                               =
        : Ok
[  133.372951]=20
[  133.391146] 23.4: Modify Watchpoint                                     =
        : Ok
[  133.391148]=20
[  133.411988] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 24
[  133.411990]=20
[  133.488894] 24: Number of exit events of a simple workload              =
        : FAILED!
[  133.488897]=20
[  133.509502] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 25
[  133.509504]=20
[  133.615162] 25: Software clock events period values                     =
        : FAILED!
[  133.615165]=20
[  133.635244] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 26
[  133.635246]=20
[  134.075631] perf: interrupt took too long (2601 > 2500), lowering kernel=
=2Eperf_event_max_sample_rate to 76000
[  136.755784] 26: Object code reading                                     =
        : FAILED!
[  136.755786]=20
[  136.776297] 2020-12-25 16:26:09 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 27
[  136.776300]=20
[  136.821956] 27: Sample parsing                                          =
        : Ok
[  136.821959]=20
[  136.842807] 2020-12-25 16:26:09 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 28
[  136.842810]=20
[  136.918980] 28: Use a dummy software event to keep tracking             =
        : FAILED!
[  136.918983]=20
[  136.939689] 2020-12-25 16:26:09 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 29
[  136.939692]=20
[  136.985042] 29: Parse with no sample_id_all bit set                     =
        : Ok
[  136.985045]=20
[  137.005701] 2020-12-25 16:26:09 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 30
[  137.005703]=20
[  137.051953] 30: Filter hist entries                                     =
        : Ok
[  137.051956]=20
[  137.073083] 2020-12-25 16:26:09 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 31
[  137.073086]=20
[  137.487808] 31: Lookup mmap thread                                      =
        : FAILED!
[  137.487811]=20
[  137.508920] 2020-12-25 16:26:10 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 32
[  137.508923]=20
[  137.554376] 32: Share thread maps                                       =
        : Ok
[  137.554379]=20
[  137.575109] 2020-12-25 16:26:10 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 33
[  137.575112]=20
[  137.621995] 33: Sort output of hist entries                             =
        : Ok
[  137.621997]=20
[  137.643113] 2020-12-25 16:26:10 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 34
[  137.643116]=20
[  137.689930] 34: Cumulate child hist entries                             =
        : Ok
[  137.689933]=20
[  137.710669] 2020-12-25 16:26:10 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 35
[  137.710671]=20
[  138.186132] 35: Track with sched_switch                                 =
        : FAILED!
[  138.186135]=20
[  138.206753] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 36
[  138.206756]=20
[  138.252009] 36: Filter fds with revents mask in a fdarray               =
        : Ok
[  138.252012]=20
[  138.272663] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 37
[  138.272666]=20
[  138.317606] 37: Add fd to a fdarray, making it autogrow                 =
        : Ok
[  138.317609]=20
[  138.338054] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 38
[  138.338057]=20
[  138.383303] 38: kmod_path__parse                                        =
        : Ok
[  138.383306]=20
[  138.403887] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 39
[  138.403889]=20
[  138.449721] 39: Thread map                                              =
        : Ok
[  138.449724]=20
[  138.472155] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 41
[  138.472158]=20
[  138.700130] 41: Session topology                                        =
        : FAILED!
[  138.700133]=20
[  138.722000] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 43
[  138.722002]=20
[  138.796404] 43: Synthesize thread map                                   =
        : FAILED!
[  138.796406]=20
[  138.817104] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 44
[  138.817106]=20
[  138.888377] 44: Remove thread map                                       =
        : FAILED!
[  138.888380]=20
[  138.908976] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 45
[  138.908978]=20
[  138.954887] 45: Synthesize cpu map                                      =
        : Ok
[  138.954890]=20
[  138.975511] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 46
[  138.975514]=20
[  139.020705] 46: Synthesize stat config                                  =
        : Ok
[  139.020708]=20
[  139.041376] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 47
[  139.041378]=20
[  139.085894] 47: Synthesize stat                                         =
        : Ok
[  139.085897]=20
[  139.106184] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 48
[  139.106187]=20
[  139.152015] 48: Synthesize stat round                                   =
        : Ok
[  139.152018]=20
[  139.173141] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 49
[  139.173144]=20
[  139.253527] 49: Synthesize attr update                                  =
        : FAILED!
[  139.253530]=20
[  139.274504] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 50
[  139.274507]=20
[  139.332635] 50: Event times                                             =
        : Ok
[  139.332638]=20
[  139.353134] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 51
[  139.353137]=20
[  139.487719] 51: Read backward ring buffer                               =
        : Ok
[  139.487722]=20
[  139.508250] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 52
[  139.508252]=20
[  139.583084] 52: Print cpu map                                           =
        : FAILED!
[  139.583086]=20
[  139.603431] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 53
[  139.603433]=20
[  139.648935] 53: Merge cpu map                                           =
        : Ok
[  139.648937]=20
[  139.669741] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 54
[  139.669744]=20
[  139.716023] 54: Probe SDT events                                        =
        : Ok
[  139.716025]=20
[  139.736752] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 55
[  139.736755]=20
[  139.780981] 55: is_printable_array                                      =
        : Ok
[  139.780984]=20
[  139.801687] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 56
[  139.801690]=20
[  139.847641] 56: Print bitmap                                            =
        : Ok
[  139.847644]=20
[  139.868185] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 57
[  139.868188]=20
[  139.913098] 57: perf hooks                                              =
        : Ok
[  139.913100]=20
[  139.934734] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 59
[  139.934737]=20
[  139.979489] 59: unit_number__scnprintf                                  =
        : Ok
[  139.979492]=20
[  140.000147] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 60
[  140.000150]=20
[  140.044935] 60: mem2node                                                =
        : Ok
[  140.044938]=20
[  140.065505] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 61
[  140.065507]=20
[  140.111033] 61: time utils                                              =
        : Ok
[  140.111035]=20
[  140.131867] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 62
[  140.131870]=20
[  140.178067] 62: Test jit_write_elf                                      =
        : Ok
[  140.178070]=20
[  140.199296] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 63
[  140.199298]=20
[  140.226438] 63: Test libpfm4 support                                    =
        : Skip (not compiled in)
[  140.226441]=20
[  140.245694] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 64
[  140.245696]=20
[  140.291678] 64: Test api io                                             =
        : Ok
[  140.291681]=20
[  140.312114] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 65
[  140.312116]=20
[  140.392987] 65: maps__merge_in                                          =
        : FAILED!
[  140.392989]=20
[  140.413807] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 66
[  140.413810]=20
[  140.459562] 66: Demangle Java                                           =
        : Ok
[  140.459579]=20
[  140.480666] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 67
[  140.480669]=20
[  140.529782] 67: Parse and process metrics                               =
        : Ok
[  140.529785]=20
[  140.550204] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 68
[  140.550206]=20
[  140.623476] 68: PE file support                                         =
        : FAILED!
[  140.623478]=20
[  140.644073] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 69
[  140.644075]=20
[  140.690168] 69: Event expansion for cgroups                             =
        : Ok
[  140.690171]=20
[  140.710643] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 70
[  140.710646]=20
[  140.944296] 70: x86 rdpmc                                               =
        : Ok
[  140.944299]=20
[  140.964817] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 71
[  140.964820]=20
[  141.041137] 71: Convert perf time to TSC                                =
        : FAILED!
[  141.041140]=20
[  141.061746] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 72
[  141.061748]=20
[  141.457682] 72: DWARF unwind                                            =
        : FAILED!
[  141.457685]=20
[  141.478307] 2020-12-25 16:26:14 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 73
[  141.478310]=20
[  141.525183] 73: x86 instruction decoder - new instructions              =
        : Ok
[  141.525186]=20
[  141.545833] 2020-12-25 16:26:14 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 74
[  141.545836]=20
[  141.591564] 74: Intel PT packet decoder                                 =
        : Ok
[  141.591567]=20
[  141.612192] 2020-12-25 16:26:14 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 75
[  141.612194]=20
[  141.665823] 75: x86 bp modify                                           =
        : Ok
[  141.665825]=20
[  141.686216] 2020-12-25 16:26:14 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 76
[  141.686219]=20
[  143.484830] 76: probe libc's inet_pton & backtrace it with ping         =
        : Ok
[  143.484833]=20
[  143.505402] 2020-12-25 16:26:16 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 77
[  143.505404]=20
[  143.695126] 77: Check Arm CoreSight trace data recording and synthesized=
 samples: Skip
[  143.695129]=20
[  143.715677] 2020-12-25 16:26:16 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 78
[  143.715680]=20
[  145.157288] 78: build id cache operations                               =
        : FAILED!
[  145.157291]=20
[  145.180175] 2020-12-25 16:26:18 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 81
[  145.180178]=20
[  146.486914] 81: Zstd perf.data compression/decompression                =
        : FAILED!
[  146.486917]=20
[  146.537605] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=3D=
0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c8067878=
13-20201226-25066-sfkgan-4.yaml&job_state=3Dpost_run -O /dev/null
[  146.537608]=20
[  148.252191] kill 2507 vmstat --timestamp -n 10=20
[  148.252194]=20
[  148.258935] kill 2505 dmesg --follow --decode=20
[  148.258936]=20
[  148.266035] wait for background processes: 2510 2512 meminfo oom-killer
[  148.266036]=20
[  154.480959] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=3D=
0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c8067878=
13-20201226-25066-sfkgan-4.yaml&loadavg=3D1.83%201.13%200.45%201/135%208978=
&start_time=3D1608913465&end_time=3D1608913579&version=3D/lkp/lkp/.src-2020=
1225-151440:04492474:3e57f6440& -O /dev/null
[  154.480962]=20
[  154.531104] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=3D=
0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c8067878=
13-20201226-25066-sfkgan-4.yaml&job_state=3Dfinished -O /dev/null
[  154.531105]=20
[  154.570198] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-post-run?job_file=
=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=3D0xe2-debia=
n-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813-2020122=
6-25066-sfkgan-4.yaml -O /dev/null
[  154.570199]=20
[  154.903935] getting new job...
[  154.903938]=20
[  154.935136] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/gpxelinux.cgi?hostnam=
e=3Dlkp-skl-d04&mac=3D64:00:6a:30:92:35&last_kernel=3D/pkg/linux/x86_64-rhe=
l-8.3/gcc-9/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/vmlinuz-5.10.0-rc3-011=
27-g8c3b1ba0e7ea&lkp_wtmp -O /tmp/next-job-lkp
[  154.935139]=20
[  160.893508] 22 blocks
[  160.893511]=20
[  160.895323] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp//lkp/jobs/scheduled/lkp-skl-d=
04/hwsim-group-22-ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-bcf876870b95=
592b52519ed4aafcf9d95999bc9c-20201226-1429-g4u7i0-0.cgz -O /tmp/next-job.cgz
[  160.897280]=20
[  160.939474] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-wtmp?tbox_name=3D=
lkp-skl-d04&tbox_state=3Dkexec_to_next_job -O /dev/null
[  160.939476]=20
[  161.471655] downloading kernel image ...
[  161.471657]=20
[  161.502653] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-22-ucode=3D0xe2-de=
bian-10.4-x86_64-20200603.cgz-bcf876870b95592b52519ed4aafcf9d95999bc9c-2020=
1226-1429-g4u7i0-0.yaml&job_state=3Dwget_kernel -O /dev/null
[  161.502655]=20
[  162.154018] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/pkg/linux/x86_64-rhel-8.3/gcc=
-9/bcf876870b95592b52519ed4aafcf9d95999bc9c/vmlinuz-5.8.0 -N -P /opt/rootfs=
/tmp/pkg/linux/x86_64-rhel-8.3/gcc-9/bcf876870b95592b52519ed4aafcf9d95999bc=
9c
[  162.154021]=20
[  162.181728] downloading initrds ...
[  162.181730]=20
[  162.194272] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-22-ucode=3D0xe2-de=
bian-10.4-x86_64-20200603.cgz-bcf876870b95592b52519ed4aafcf9d95999bc9c-2020=
1226-1429-g4u7i0-0.yaml&job_state=3Dwget_initrd -O /dev/null
[  162.194274]=20
[  162.746326] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/debian/debian-10.4-x8=
6_64-20200603.cgz -N -P /opt/rootfs/tmp/osimage/debian
[  162.746329]=20
[  162.919387] /opt/rootfs/tmp/osimage/debian/debian-10.4-x86_64-20200603.c=
gz isn't modified
[  162.919390]=20
[  162.936434] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/lkp/jobs/scheduled/lkp-skl-d0=
4/hwsim-group-22-ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-bcf876870b955=
92b52519ed4aafcf9d95999bc9c-20201226-1429-g4u7i0-0.cgz -N -P /opt/rootfs/tm=
p/lkp/jobs/scheduled/lkp-skl-d04
[  162.936436]=20
[  162.936681] 22 blocks
[  162.966051]=20
[  162.968198] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/user/lkp/lkp-x86_64.c=
gz -N -P /opt/rootfs/tmp/osimage/user/lkp
[  162.969801]=20
[  162.988840] /opt/rootfs/tmp/osimage/user/lkp/lkp-x86_64.cgz isn't modifi=
ed
[  162.988841]=20
[  163.002717] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/deps/debian-10.4-x86_=
64-20200603.cgz/run-ipconfig_20200608.cgz -N -P /opt/rootfs/tmp/osimage/dep=
s/debian-10.4-x86_64-20200603.cgz
[  163.002719]=20
[  163.028313] /opt/rootfs/tmp/osimage/deps/debian-10.4-x86_64-20200603.cgz=
/run-ipconfig_20200608.cgz isn't modified
[  163.028314]=20
[  163.044992] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/deps/debian-10.4-x86_=
64-20200603.cgz/lkp_20201211.cgz -N -P /opt/rootfs/tmp/osimage/deps/debian-=
10.4-x86_64-20200603.cgz
[  163.044993]=20
[  163.069417] /opt/rootfs/tmp/osimage/deps/debian-10.4-x86_64-20200603.cgz=
/lkp_20201211.cgz isn't modified
[  163.069418]=20
[  163.085370] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/deps/debian-10.4-x86_=
64-20200603.cgz/rsync-rootfs_20200608.cgz -N -P /opt/rootfs/tmp/osimage/dep=
s/debian-10.4-x86_64-20200603.cgz
[  163.085371]=20
[  163.110809] /opt/rootfs/tmp/osimage/deps/debian-10.4-x86_64-20200603.cgz=
/rsync-rootfs_20200608.cgz isn't modified
[  163.110810]=20
[  163.127488] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/deps/debian-10.4-x86_=
64-20200603.cgz/hwsim_20201110.cgz -N -P /opt/rootfs/tmp/osimage/deps/debia=
n-10.4-x86_64-20200603.cgz
[  163.127489]=20
[  163.314539] /opt/rootfs/tmp/osimage/deps/debian-10.4-x86_64-20200603.cgz=
/hwsim_20201110.cgz isn't modified
[  163.314541]=20
[  163.331135] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/pkg/debian-10.4-x86_6=
4-20200603.cgz/hwsim-x86_64-537ab94-1_20201123.cgz -N -P /opt/rootfs/tmp/os=
image/pkg/debian-10.4-x86_64-20200603.cgz
[  163.331136]=20
[  163.357474] /opt/rootfs/tmp/osimage/pkg/debian-10.4-x86_64-20200603.cgz/=
hwsim-x86_64-537ab94-1_20201123.cgz isn't modified
[  163.357475]=20
[  163.375188] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/deps/debian-10.4-x86_=
64-20200603.cgz/hw_20200715.cgz -N -P /opt/rootfs/tmp/osimage/deps/debian-1=
0.4-x86_64-20200603.cgz
[  163.375189]=20
[  163.399666] /opt/rootfs/tmp/osimage/deps/debian-10.4-x86_64-20200603.cgz=
/hw_20200715.cgz isn't modified
[  163.399668]=20
[  163.417104] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/pkg/linux/x86_64-rhel-8.3/gcc=
-9/bcf876870b95592b52519ed4aafcf9d95999bc9c/modules.cgz -N -P /opt/rootfs/t=
mp/pkg/linux/x86_64-rhel-8.3/gcc-9/bcf876870b95592b52519ed4aafcf9d95999bc9c
[  163.417105]=20
[  163.679305] /opt/rootfs/tmp/pkg/linux/x86_64-rhel-8.3/gcc-9/bcf876870b95=
592b52519ed4aafcf9d95999bc9c/modules.cgz isn't modified
[  163.679308]=20
[  163.696313] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/ucode/intel-ucode-202=
01117.cgz -N -P /opt/rootfs/tmp/osimage/ucode
[  163.696315]=20
[  163.715750] /opt/rootfs/tmp/osimage/ucode/intel-ucode-20201117.cgz isn't=
 modified
[  163.715751]=20
[  164.604333] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-22-ucode=3D0xe2-de=
bian-10.4-x86_64-20200603.cgz-bcf876870b95592b52519ed4aafcf9d95999bc9c-2020=
1226-1429-g4u7i0-0.yaml&last_kernel=3D5.10.0-rc3-01127-g8c3b1ba0e7ea -O /de=
v/null
[  164.604335]=20
[  165.104519] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-22-ucode=3D0xe2-de=
bian-10.4-x86_64-20200603.cgz-bcf876870b95592b52519ed4aafcf9d95999bc9c-2020=
1226-1429-g4u7i0-0.yaml&job_state=3Dbooting -O /dev/null
[  165.104521]=20
[  165.663906] LKP: kexec loading...
[  165.663908]=20
[  165.672092] kexec --noefi -l /opt/rootfs/tmp/pkg/linux/x86_64-rhel-8.3/g=
cc-9/bcf876870b95592b52519ed4aafcf9d95999bc9c/vmlinuz-5.8.0 --initrd=3D/opt=
/rootfs/tmp/initrd-concatenated
[  165.672093]=20
[  168.641536] --append=3Dip=3D::::lkp-skl-d04::dhcp root=3D/dev/ram0 user=
=3Dlkp job=3D/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-22-ucode=3D0xe2-de=
bian-10.4-x86_64-20200603.cgz-bcf876870b95592b52519ed4aafcf9d95999bc9c-2020=
1226-1429-g4u7i0-0.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3 branch=3Din=
ternal-devel/devel-hourly-2020122418 commit=3Dbcf876870b95592b52519ed4aafcf=
9d95999bc9c BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/bcf876870b95592b5=
2519ed4aafcf9d95999bc9c/vmlinuz-5.8.0 max_uptime=3D2100 RESULT_ROOT=3D/resu=
lt/hwsim/group-22-ucode=3D0xe2/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/=
x86_64-rhel-8.3/gcc-9/bcf876870b95592b52519ed4aafcf9d95999bc9c/25 LKP_SERVE=
R=3Dinternal-lkp-server nokaslr selinux=3D0 debug apic=3Ddebug sysrq_always=
_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkms=
g=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic lo=
ad_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_lev
[  168.641539]=20
LKP: rebooting
[  169.708755] e1000e 0000:00:1f.6 eth0: NIC Link is Down
[  169.713966] kvm: exiting hardware virtualization
[  169.718708] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
[  169.723948] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  169.729419] e1000e: EEE TX LPI TIMER: 00000011
Starting new kernel
Decompressing Linux... Parsing ELF... No relocation needed... done.
Booting the kernel.
[    0.000000] Linux version 5.10.0-rc3-01127-g8c3b1ba0e7ea (kbuild@ef0b816=
f83ac) (gcc-9 (Debian 9.3.0-15) 9.3.0, GNU ld (GNU Binutils for Debian) 2.3=
5) #1 SMP Thu Dec 24 12:43:54 CST 2020
APPEND dmesg: /result/perf-sanity-tests/gcc-ucode=3D0xe2/lkp-skl-d04/debian=
-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0ee4b4445e=
a59c806787813/5/dmesg already exists
[    0.000000] Command line: ip=3D::::lkp-skl-d04::dhcp root=3D/dev/ram0 us=
er=3Dlkp job=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=
=3D0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c8067=
87813-20201226-25066-sfkgan-4.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3 =
branch=3Ddrm-intel/drm-intel-gt-next commit=3D8c3b1ba0e7ea9a80b0ee4b4445ea5=
9c806787813 BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b=
0ee4b4445ea59c806787813/vmlinuz-5.10.0-rc3-01127-g8c3b1ba0e7ea max_uptime=
=3D2100 RESULT_ROOT=3D/result/perf-sanity-tests/gcc-ucode=3D0xe2/lkp-skl-d0=
4/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0e=
e4b4445ea59c806787813/5 LKP_SERVER=3Dinternal-lkp-server nokaslr selinux=3D=
0 debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=3D=
100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1 nmi=
_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd.min=
or_count=3D8 systemd.log_level=3Derr ignore_loglevel console=3Dtty0 earlypr=
intk=3DttyS0,11
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registe=
rs'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 b=
ytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000100-0x000000000009c7ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009c800-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007caa5fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007caa6000-0x000000007caa6fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000007caa7000-0x000000007cad0fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007cad1000-0x000000007cb22fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007cb23000-0x000000007d323fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007d324000-0x0000000086f56fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000086f57000-0x00000000872bcfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000872bd000-0x0000000087309fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000008730a000-0x0000000087abefff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x0000000087abf000-0x0000000087ffefff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000087fff000-0x0000000087ffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000871ffffff] usable
[    0.000000] printk: debug: ignoring loglevel setting.
[    0.000000] printk: bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
[    0.000000] tsc: Detected 3200.000 MHz processor
[    0.000000] tsc: Detected 3199.980 MHz TSC
[    0.000624] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.011117] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.016616] last_pfn =3D 0x872000 max_arch_pfn =3D 0x400000000
[    0.022022] MTRR default type: write-back
[    0.025970] MTRR fixed ranges enabled:
[    0.029660]   00000-9FFFF write-back
[    0.033182]   A0000-BFFFF uncachable
[    0.036700]   C0000-FFFFF write-protect
[    0.040479] MTRR variable ranges enabled:
[    0.044427]   0 base 00C0000000 mask 7FC0000000 uncachable
[    0.049836]   1 base 00A0000000 mask 7FE0000000 uncachable
[    0.055245]   2 base 0090000000 mask 7FF0000000 uncachable
[    0.060653]   3 base 008C000000 mask 7FFC000000 uncachable
[    0.066062]   4 base 008A000000 mask 7FFE000000 uncachable
[    0.071470]   5 base 0089800000 mask 7FFF800000 uncachable
[    0.076878]   6 disabled
[    0.079366]   7 disabled
[    0.081858]   8 disabled
[    0.084347]   9 disabled
[    0.087123] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.094209] last_pfn =3D 0x88000 max_arch_pfn =3D 0x400000000
[    0.099411] Scan for SMP in [mem 0x00000000-0x000003ff]
[    0.104574] Scan for SMP in [mem 0x0009fc00-0x0009ffff]
[    0.109724] Scan for SMP in [mem 0x000f0000-0x000fffff]
[    0.120345] found SMP MP-table at [mem 0x000fcde0-0x000fcdef]
[    0.125856]   mpc: fcbb0-fcd5c
[    0.128871] Using GB pages for direct mapping
[    0.133596] RAMDISK: [mem 0x83bb72000-0x86ebfffff]
[    0.138166] ACPI: Early table checksum verification disabled
[    0.143742] ACPI: RSDP 0x00000000000F05B0 000024 (v02 DELL  )
[    0.149407] ACPI: XSDT 0x00000000872DD0A0 0000C4 (v01 DELL   CBX3     01=
072009 AMI  00010013)
[    0.157819] ACPI: FACP 0x00000000872FE7C0 00010C (v05 DELL   CBX3     01=
072009 AMI  00010013)
[    0.166241] ACPI: DSDT 0x00000000872DD1F8 0215C8 (v02 DELL   CBX3     01=
072009 INTL 20120913)
[    0.174667] ACPI: FACS 0x0000000087ABEF80 000040
[    0.179223] ACPI: APIC 0x00000000872FE8D0 000084 (v03 DELL   CBX3     01=
072009 AMI  00010013)
[    0.187652] ACPI: FPDT 0x00000000872FE958 000044 (v01 DELL   CBX3     01=
072009 AMI  00010013)
[    0.196067] ACPI: FIDT 0x00000000872FE9A0 00009C (v01 DELL   CBX3     01=
072009 AMI  00010013)
[    0.204480] ACPI: MCFG 0x00000000872FEA40 00003C (v01 DELL   CBX3     01=
072009 MSFT 00000097)
[    0.212893] ACPI: HPET 0x00000000872FEA80 000038 (v01 DELL   CBX3     01=
072009 AMI. 0005000B)
[    0.221308] ACPI: SSDT 0x00000000872FEAB8 00036D (v01 SataRe SataTabl 00=
001000 INTL 20120913)
[    0.229722] ACPI: SSDT 0x00000000872FEE28 0053B2 (v02 SaSsdt SaSsdt   00=
003000 INTL 20120913)
[    0.238135] ACPI: UEFI 0x00000000873041E0 000042 (v01                 00=
000000      00000000)
[    0.246551] ACPI: LPIT 0x0000000087304228 000094 (v01 INTEL  SKL      00=
000000 MSFT 0000005F)
[    0.254962] ACPI: SSDT 0x00000000873042C0 000248 (v02 INTEL  sensrhub 00=
000000 INTL 20120913)
[    0.263376] ACPI: SSDT 0x0000000087304508 002BAE (v02 INTEL  PtidDevc 00=
001000 INTL 20120913)
[    0.271790] ACPI: SSDT 0x00000000873070B8 000C45 (v02 INTEL  Ther_Rvp 00=
001000 INTL 20120913)
[    0.280203] ACPI: DBGP 0x0000000087307D00 000034 (v01 INTEL           00=
000000 MSFT 0000005F)
[    0.288616] ACPI: DBG2 0x0000000087307D38 000054 (v00 INTEL           00=
000000 MSFT 0000005F)
[    0.297030] ACPI: SSDT 0x0000000087307D90 000613 (v02 INTEL  DELL__MT 00=
000000 INTL 20120913)
[    0.305442] ACPI: SSDT 0x00000000873083A8 000E58 (v02 CpuRef CpuSsdt  00=
003000 INTL 20120913)
[    0.313855] ACPI: SLIC 0x0000000087309200 000176 (v03 DELL   CBX3     01=
072009 MSFT 00010013)
[    0.322268] ACPI: DMAR 0x0000000087309378 0000A8 (v01 INTEL  SKL      00=
000001 INTL 00000001)
[    0.330680] ACPI: ASF! 0x0000000087309420 0000A5 (v32 INTEL   HCG     00=
000001 TFSM 000F4240)
[    0.339098] ACPI: Local APIC address 0xfee00000
[    0.343561] mapped APIC to ffffffffff5fc000 (        fee00000)
[    0.349448] No NUMA configuration found
[    0.353087] Faking a node at [mem 0x0000000000000000-0x0000000871ffffff]
[    0.359703] NODE_DATA(0) allocated [mem 0x871fd5000-0x871ffffff]
[    0.365823] cma: Reserved 200 MiB at 0x000000082f000000
[    0.370848] Zone ranges:
[    0.373309]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.379406]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.385502]   Normal   [mem 0x0000000100000000-0x0000000871ffffff]
[    0.391598]   Device   empty
[    0.394431] Movable zone start for each node
[    0.398642] Early memory node ranges
[    0.402167]   node   0: [mem 0x0000000000001000-0x000000000009bfff]
[    0.408358]   node   0: [mem 0x0000000000100000-0x000000007caa5fff]
[    0.414549]   node   0: [mem 0x000000007cad1000-0x000000007cb22fff]
[    0.420740]   node   0: [mem 0x000000007d324000-0x0000000086f56fff]
[    0.426931]   node   0: [mem 0x0000000087fff000-0x0000000087ffffff]
[    0.433113]   node   0: [mem 0x0000000100000000-0x0000000871ffffff]
[    0.439535] Zeroed struct page in unavailable ranges: 31033 pages
[    0.439536] Initmem setup node 0 [mem 0x0000000000001000-0x0000000871fff=
fff]
[    0.452347] On node 0 totalpages: 8357575
[    0.456294]   DMA zone: 64 pages used for memmap
[    0.460845]   DMA zone: 21 pages reserved
[    0.464795]   DMA zone: 3995 pages, LIFO batch:0
[    0.469371]   DMA32 zone: 8541 pages used for memmap
[    0.474239]   DMA32 zone: 546604 pages, LIFO batch:63
[    0.482815]   Normal zone: 121984 pages used for memmap
[    0.487811]   Normal zone: 7806976 pages, LIFO batch:63
[    0.493193] Reserving Intel graphics memory at [mem 0x8a000000-0x8bfffff=
f]
[    0.500003] ACPI: PM-Timer IO Port: 0x1808
[    0.503883] ACPI: Local APIC address 0xfee00000
[    0.508349] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.514184] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.520023] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.525859] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.531722] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-=
119
[    0.538565] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.544832] Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 2, APIC =
INT 02
[    0.551957] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.558481] Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 2, APIC =
INT 09
[    0.565606] ACPI: IRQ0 used by override.
[    0.569471] Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 2, APIC =
INT 01
[    0.576596] Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 2, APIC =
INT 03
[    0.583719] Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 2, APIC =
INT 04
[    0.590847] Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 2, APIC =
INT 05
[    0.597971] Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 2, APIC =
INT 06
[    0.605095] Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 2, APIC =
INT 07
[    0.612221] Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 2, APIC =
INT 08
[    0.619344] ACPI: IRQ9 used by override.
[    0.623208] Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 2, APIC =
INT 0a
[    0.630335] Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 2, APIC =
INT 0b
[    0.637463] Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 2, APIC =
INT 0c
[    0.644601] Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 2, APIC =
INT 0d
[    0.651740] Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 2, APIC =
INT 0e
[    0.658878] Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 2, APIC =
INT 0f
[    0.666016] Using ACPI (MADT) for SMP configuration information
[    0.671855] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.676922] TSC deadline timer available
[    0.680786] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.685682] mapped IOAPIC to ffffffffff5fb000 (fec00000)
[    0.690927] PM: hibernation: Registered nosave memory: [mem 0x00000000-0=
x00000fff]
[    0.698389] PM: hibernation: Registered nosave memory: [mem 0x0009c000-0=
x0009cfff]
[    0.705859] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0=
x0009ffff]
[    0.713329] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0=
x000dffff]
[    0.720799] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0=
x000fffff]
[    0.728269] PM: hibernation: Registered nosave memory: [mem 0x7caa6000-0=
x7caa6fff]
[    0.735739] PM: hibernation: Registered nosave memory: [mem 0x7caa7000-0=
x7cad0fff]
[    0.743209] PM: hibernation: Registered nosave memory: [mem 0x7cb23000-0=
x7d323fff]
[    0.750677] PM: hibernation: Registered nosave memory: [mem 0x86f57000-0=
x872bcfff]
[    0.758146] PM: hibernation: Registered nosave memory: [mem 0x872bd000-0=
x87309fff]
[    0.765617] PM: hibernation: Registered nosave memory: [mem 0x8730a000-0=
x87abefff]
[    0.773085] PM: hibernation: Registered nosave memory: [mem 0x87abf000-0=
x87ffefff]
[    0.780554] PM: hibernation: Registered nosave memory: [mem 0x88000000-0=
x89ffffff]
[    0.788022] PM: hibernation: Registered nosave memory: [mem 0x8a000000-0=
x8bffffff]
[    0.795492] PM: hibernation: Registered nosave memory: [mem 0x8c000000-0=
xdfffffff]
[    0.802962] PM: hibernation: Registered nosave memory: [mem 0xe0000000-0=
xefffffff]
[    0.810432] PM: hibernation: Registered nosave memory: [mem 0xf0000000-0=
xfdffffff]
[    0.817902] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0=
xfe010fff]
[    0.825374] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0=
xfebfffff]
[    0.832843] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0=
xfec00fff]
[    0.840313] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0=
xfedfffff]
[    0.847783] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0=
xfee00fff]
[    0.855255] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0=
xfeffffff]
[    0.862724] PM: hibernation: Registered nosave memory: [mem 0xff000000-0=
xffffffff]
[    0.870195] [mem 0x8c000000-0xdfffffff] available for PCI devices
[    0.876209] Booting paravirtualized kernel on bare hardware
[    0.881714] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 1910969940391419 ns
[    0.896167] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr=
_node_ids:1
[    0.903683] percpu: Embedded 55 pages/cpu s188416 r8192 d28672 u524288
[    0.910023] pcpu-alloc: s188416 r8192 d28672 u524288 alloc=3D1*2097152
[    0.916288] pcpu-alloc: [0] 0 1 2 3=20
[    0.919825] Built 1 zonelists, mobility grouping on.  Total pages: 82269=
65
[    0.926593] Policy zone: Normal
[    0.929685] Kernel command line: ip=3D::::lkp-skl-d04::dhcp root=3D/dev/=
ram0 user=3Dlkp job=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc=
-ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea5=
9c806787813-20201226-25066-sfkgan-4.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhe=
l-8.3 branch=3Ddrm-intel/drm-intel-gt-next commit=3D8c3b1ba0e7ea9a80b0ee4b4=
445ea59c806787813 BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7e=
a9a80b0ee4b4445ea59c806787813/vmlinuz-5.10.0-rc3-01127-g8c3b1ba0e7ea max_up=
time=3D2100 RESULT_ROOT=3D/result/perf-sanity-tests/gcc-ucode=3D0xe2/lkp-sk=
l-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a8=
0b0ee4b4445ea59c806787813/5 LKP_SERVER=3Dinternal-lkp-server nokaslr selinu=
x=3D0 debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeou=
t=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1=
 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd=
=2Eminor_count=3D8 systemd.log_level=3Derr ignore_loglevel console=3Dtty0 e=
arlyprintk=3Dt
[    0.929897] sysrq: sysrq always enabled.
[    1.020059] ignoring the deprecated load_ramdisk=3D option
[    1.026451] Dentry cache hash table entries: 4194304 (order: 13, 3355443=
2 bytes, linear)
[    1.034851] Inode-cache hash table entries: 2097152 (order: 12, 16777216=
 bytes, linear)
[    1.042627] mem auto-init: stack:off, heap alloc:off, heap free:off
[    1.072392] Memory: 2267592K/33430300K available (14347K kernel code, 61=
42K rwdata, 4812K rodata, 2432K init, 5268K bss, 1517728K reserved, 204800K=
 cma-reserved)
[    1.086516] random: get_random_u64 called from cache_random_seq_create+0=
x80/0x180 with crng_init=3D0
[    1.086564] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    1.101783] Kernel/User page tables isolation: enabled
[    1.106850] ftrace: allocating 45690 entries in 179 pages
[    1.124398] ftrace: allocated 179 pages with 5 groups
[    1.129287] rcu: Hierarchical RCU implementation.
[    1.133876] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D4.
[    1.140584] 	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_ti=
meout).
[    1.147797] 	Trampoline variant of Tasks RCU enabled.
[    1.152778] 	Rude variant of Tasks RCU enabled.
[    1.157243] 	Tracing variant of Tasks RCU enabled.
[    1.161967] rcu: RCU calculated value of scheduler-enlistment delay is 1=
00 jiffies.
[    1.169521] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D4
[    1.178909] NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs: 16
[    1.187148] Console: colour VGA+ 80x25
[    1.218889] printk: console [tty0] enabled
[    1.222902] printk: console [ttyS0] enabled
[    1.222902] printk: console [ttyS0] enabled
[    1.231135] printk: bootconsole [earlyser0] disabled
[    1.231135] printk: bootconsole [earlyser0] disabled
[    1.240941] ACPI: Core revision 20200925
[    1.245163] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 79635855245 ns
[    1.254313] APIC: Switch to symmetric I/O mode setup
[    1.259361] DMAR: Host address width 39
[    1.263293] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    1.268689] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660=
462 ecap 7e3ff0505e
[    1.277114] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    1.282510] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c406604=
62 ecap f050da
[    1.290504] DMAR: RMRR base: 0x0000008715f000 end: 0x0000008717efff
[    1.296843] DMAR: RMRR base: 0x00000089800000 end: 0x0000008bffffff
[    1.303186] DMAR: [Firmware Bug]: No firmware reserved region can cover =
this RMRR [0x0000000089800000-0x000000008bffffff], contact BIOS vendor for =
fixes
[    1.316860] DMAR: [Firmware Bug]: Your BIOS is broken; bad RMRR [0x00000=
00089800000-0x000000008bffffff]
[    1.316860] BIOS vendor: Dell Inc.; Ver: 1.1.1; Product Version:=20
[    1.332361] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    1.338786] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    1.344266] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out=
 bit.
[    1.344266] DMAR-IR: Use 'intremap=3Dno_x2apic_optout' to override the B=
IOS setting.
[    1.359239] DMAR-IR: IRQ remapping was enabled on dmar0 but we are not i=
n kdump mode
[    1.367186] DMAR-IR: IRQ remapping was enabled on dmar1 but we are not i=
n kdump mode
[    1.376246] DMAR-IR: Enabled IRQ remapping in xapic mode
[    1.381617] x2apic: IRQ remapping doesn't support X2APIC mode
[    1.387450] masked ExtINT on CPU#0
[    1.394676] ENABLING IO-APIC IRQs
[    1.398064] init IO_APIC IRQs
[    1.401108]  apic 2 pin 0 not connected
[    1.405015] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.418495] IOAPIC[0]: Set routing entry (2-1 -> 0xef -> IRQ 1 Mode:0 Ac=
tive:0 Dest:1)
[    1.426464] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:30 Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.439947] IOAPIC[0]: Set routing entry (2-2 -> 0x30 -> IRQ 0 Mode:0 Ac=
tive:0 Dest:1)
[    1.447915] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.461398] IOAPIC[0]: Set routing entry (2-3 -> 0xef -> IRQ 3 Mode:0 Ac=
tive:0 Dest:1)
[    1.469368] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.482846] IOAPIC[0]: Set routing entry (2-4 -> 0xef -> IRQ 4 Mode:0 Ac=
tive:0 Dest:1)
[    1.490817] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.505098] IOAPIC[0]: Set routing entry (2-5 -> 0xef -> IRQ 5 Mode:0 Ac=
tive:0 Dest:1)
[    1.513067] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.526546] IOAPIC[0]: Set routing entry (2-6 -> 0xef -> IRQ 6 Mode:0 Ac=
tive:0 Dest:1)
[    1.534514] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.547997] IOAPIC[0]: Set routing entry (2-7 -> 0xef -> IRQ 7 Mode:0 Ac=
tive:0 Dest:1)
[    1.555966] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.569445] IOAPIC[0]: Set routing entry (2-8 -> 0xef -> IRQ 8 Mode:0 Ac=
tive:0 Dest:1)
[    1.577412] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.590897] IOAPIC[0]: Set routing entry (2-9 -> 0xef -> IRQ 9 Mode:1 Ac=
tive:0 Dest:1)
[    1.598880] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.612383] IOAPIC[0]: Set routing entry (2-10 -> 0xef -> IRQ 10 Mode:0 =
Active:0 Dest:1)
[    1.620530] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.634009] IOAPIC[0]: Set routing entry (2-11 -> 0xef -> IRQ 11 Mode:0 =
Active:0 Dest:1)
[    1.642149] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.655633] IOAPIC[0]: Set routing entry (2-12 -> 0xef -> IRQ 12 Mode:0 =
Active:0 Dest:1)
[    1.663775] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.677257] IOAPIC[0]: Set routing entry (2-13 -> 0xef -> IRQ 13 Mode:0 =
Active:0 Dest:1)
[    1.685400] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.698886] IOAPIC[0]: Set routing entry (2-14 -> 0xef -> IRQ 14 Mode:0 =
Active:0 Dest:1)
[    1.707028] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    1.720511] IOAPIC[0]: Set routing entry (2-15 -> 0xef -> IRQ 15 Mode:0 =
Active:0 Dest:1)
[    1.728653]  apic 2 pin 16 not connected
[    1.732645]  apic 2 pin 17 not connected
[    1.736634]  apic 2 pin 18 not connected
[    1.740625]  apic 2 pin 19 not connected
[    1.744615]  apic 2 pin 20 not connected
[    1.748605]  apic 2 pin 21 not connected
[    1.752595]  apic 2 pin 22 not connected
[    1.756585]  apic 2 pin 23 not connected
[    1.760575]  apic 2 pin 24 not connected
[    1.764564]  apic 2 pin 25 not connected
[    1.768554]  apic 2 pin 26 not connected
[    1.772544]  apic 2 pin 27 not connected
[    1.776535]  apic 2 pin 28 not connected
[    1.780526]  apic 2 pin 29 not connected
[    1.784515]  apic 2 pin 30 not connected
[    1.788506]  apic 2 pin 31 not connected
[    1.792494]  apic 2 pin 32 not connected
[    1.796485]  apic 2 pin 33 not connected
[    1.800475]  apic 2 pin 34 not connected
[    1.804466]  apic 2 pin 35 not connected
[    1.808458]  apic 2 pin 36 not connected
[    1.812450]  apic 2 pin 37 not connected
[    1.816440]  apic 2 pin 38 not connected
[    1.820431]  apic 2 pin 39 not connected
[    1.824422]  apic 2 pin 40 not connected
[    1.828419]  apic 2 pin 41 not connected
[    1.832417]  apic 2 pin 42 not connected
[    1.836411]  apic 2 pin 43 not connected
[    1.840408]  apic 2 pin 44 not connected
[    1.844403]  apic 2 pin 45 not connected
[    1.848401]  apic 2 pin 46 not connected
[    1.852400]  apic 2 pin 47 not connected
[    1.856392]  apic 2 pin 48 not connected
[    1.860383]  apic 2 pin 49 not connected
[    1.864374]  apic 2 pin 50 not connected
[    1.868365]  apic 2 pin 51 not connected
[    1.872354]  apic 2 pin 52 not connected
[    1.876343]  apic 2 pin 53 not connected
[    1.880333]  apic 2 pin 54 not connected
[    1.884324]  apic 2 pin 55 not connected
[    1.888314]  apic 2 pin 56 not connected
[    1.892306]  apic 2 pin 57 not connected
[    1.896297]  apic 2 pin 58 not connected
[    1.900287]  apic 2 pin 59 not connected
[    1.904278]  apic 2 pin 60 not connected
[    1.908268]  apic 2 pin 61 not connected
[    1.912260]  apic 2 pin 62 not connected
[    1.916250]  apic 2 pin 63 not connected
[    1.920239]  apic 2 pin 64 not connected
[    1.924228]  apic 2 pin 65 not connected
[    1.928220]  apic 2 pin 66 not connected
[    1.932209]  apic 2 pin 67 not connected
[    1.936201]  apic 2 pin 68 not connected
[    1.940190]  apic 2 pin 69 not connected
[    1.944179]  apic 2 pin 70 not connected
[    1.948169]  apic 2 pin 71 not connected
[    1.952159]  apic 2 pin 72 not connected
[    1.956150]  apic 2 pin 73 not connected
[    1.960142]  apic 2 pin 74 not connected
[    1.964133]  apic 2 pin 75 not connected
[    1.968123]  apic 2 pin 76 not connected
[    1.972113]  apic 2 pin 77 not connected
[    1.976104]  apic 2 pin 78 not connected
[    1.980095]  apic 2 pin 79 not connected
[    1.984085]  apic 2 pin 80 not connected
[    1.988075]  apic 2 pin 81 not connected
[    1.992064]  apic 2 pin 82 not connected
[    1.996054]  apic 2 pin 83 not connected
[    2.000045]  apic 2 pin 84 not connected
[    2.004035]  apic 2 pin 85 not connected
[    2.008026]  apic 2 pin 86 not connected
[    2.012017]  apic 2 pin 87 not connected
[    2.016008]  apic 2 pin 88 not connected
[    2.019999]  apic 2 pin 89 not connected
[    2.023988]  apic 2 pin 90 not connected
[    2.027978]  apic 2 pin 91 not connected
[    2.031967]  apic 2 pin 92 not connected
[    2.035956]  apic 2 pin 93 not connected
[    2.039947]  apic 2 pin 94 not connected
[    2.043937]  apic 2 pin 95 not connected
[    2.047926]  apic 2 pin 96 not connected
[    2.051916]  apic 2 pin 97 not connected
[    2.055908]  apic 2 pin 98 not connected
[    2.059899]  apic 2 pin 99 not connected
[    2.063893]  apic 2 pin 100 not connected
[    2.067977]  apic 2 pin 101 not connected
[    2.072056]  apic 2 pin 102 not connected
[    2.076141]  apic 2 pin 103 not connected
[    2.080225]  apic 2 pin 104 not connected
[    2.084305]  apic 2 pin 105 not connected
[    2.088390]  apic 2 pin 106 not connected
[    2.092470]  apic 2 pin 107 not connected
[    2.096546]  apic 2 pin 108 not connected
[    2.100622]  apic 2 pin 109 not connected
[    2.104700]  apic 2 pin 110 not connected
[    2.108777]  apic 2 pin 111 not connected
[    2.112853]  apic 2 pin 112 not connected
[    2.116929]  apic 2 pin 113 not connected
[    2.121004]  apic 2 pin 114 not connected
[    2.125082]  apic 2 pin 115 not connected
[    2.129158]  apic 2 pin 116 not connected
[    2.133236]  apic 2 pin 117 not connected
[    2.137311]  apic 2 pin 118 not connected
[    2.141387]  apic 2 pin 119 not connected
[    2.145619] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    2.155996] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x2e2036ff8d5, max_idle_ns: 440795275316 ns
[    2.166546] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 6399.96 BogoMIPS (lpj=3D3199980)
[    2.167545] pid_max: default: 32768 minimum: 301
[    2.168563] LSM: Security Framework initializing
[    2.169551] Yama: becoming mindful.
[    2.170560] AppArmor: AppArmor initialized
[    2.171586] Mount-cache hash table entries: 65536 (order: 7, 524288 byte=
s, linear)
[    2.172583] Mountpoint-cache hash table entries: 65536 (order: 7, 524288=
 bytes, linear)
Poking KASLR using RDRAND RDTSC...
[    2.176877] mce: CPU0: Thermal monitoring enabled (TM1)
[    2.177557] process: using mwait in idle threads
[    2.178546] Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
[    2.180545] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    2.181547] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    2.182547] Spectre V2 : Mitigation: Full generic retpoline
[    2.183545] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    2.184545] Spectre V2 : Enabling Restricted Speculation for firmware ca=
lls
[    2.185547] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    2.186547] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl and seccomp
[    2.187546] TAA: Mitigation: Clear CPU buffers
[    2.188546] SRBDS: Mitigation: Microcode
[    2.189545] MDS: Mitigation: Clear CPU buffers
[    2.191571] Freeing SMP alternatives memory: 40K
[    2.194021] smpboot: CPU0: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (fami=
ly: 0x6, model: 0x5e, stepping: 0x3)
[    2.194604] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR,=
 full-width counters, Broken BIOS detected, complain to your hardware vendo=
r.
[    2.195546] [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR=
 189 is 100430000)
[    2.196545] Intel PMU driver.
[    2.196546] ... version:                4
[    2.198545] ... bit width:              48
[    2.199545] ... generic registers:      8
[    2.200545] ... value mask:             0000ffffffffffff
[    2.201545] ... max period:             00007fffffffffff
[    2.202545] ... fixed-purpose events:   3
[    2.203545] ... event mask:             00000007000000ff
[    2.204624] rcu: Hierarchical SRCU implementation.
[    2.205976] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    2.206580] smp: Bringing up secondary CPUs ...
[    2.207597] x86: Booting SMP configuration:
[    2.208547] .... node  #0, CPUs:      #1
[    0.957511] masked ExtINT on CPU#1
[    2.216193]  #2
[    0.957511] masked ExtINT on CPU#2
[    2.221803]  #3
[    0.957511] masked ExtINT on CPU#3
[    2.227295] smp: Brought up 1 node, 4 CPUs
[    2.227546] smpboot: Max logical packages: 1
[    2.228546] smpboot: Total of 4 processors activated (25599.84 BogoMIPS)
[    2.262668] node 0 deferred pages initialised in 33ms
[    2.268941] devtmpfs: initialized
[    2.269575] x86/mm: Memory block size: 128MB
[    2.272046] PM: Registering ACPI NVS region [mem 0x7caa6000-0x7caa6fff] =
(4096 bytes)
[    2.272547] PM: Registering ACPI NVS region [mem 0x8730a000-0x87abefff] =
(8081408 bytes)
[    2.273670] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 1911260446275000 ns
[    2.274548] futex hash table entries: 1024 (order: 4, 65536 bytes, linea=
r)
[    2.276010] pinctrl core: initialized pinctrl subsystem
[    2.276639] NET: Registered protocol family 16
[    2.277713] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic alloca=
tions
[    2.278553] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomi=
c allocations
[    2.279551] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for ato=
mic allocations
[    2.280550] audit: initializing netlink subsys (disabled)
[    2.281552] audit: type=3D2000 audit(1608913432.140:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    2.281605] thermal_sys: Registered thermal governor 'fair_share'
[    2.282546] thermal_sys: Registered thermal governor 'bang_bang'
[    2.283545] thermal_sys: Registered thermal governor 'step_wise'
[    2.284545] thermal_sys: Registered thermal governor 'user_space'
[    2.285550] cpuidle: using governor menu
[    2.287651] ACPI FADT declares the system doesn't support PCIe ASPM, so =
disable it
[    2.288546] ACPI: bus type PCI registered
[    2.289545] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    2.290593] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000=
-0xefffffff] (base 0xe0000000)
[    2.291547] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    2.292555] PCI: Using configuration type 1 for base access
[    2.294888] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    2.295546] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    2.296561] cryptd: max_cpu_qlen set to 1000
[    2.297582] ACPI: Added _OSI(Module Device)
[    2.298546] ACPI: Added _OSI(Processor Device)
[    2.306547] ACPI: Added _OSI(3.0 _SCP Extensions)
[    2.311545] ACPI: Added _OSI(Processor Aggregator Device)
[    2.316547] ACPI: Added _OSI(Linux-Dell-Video)
[    2.317549] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    2.318546] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    2.346028] ACPI: 8 ACPI AML tables successfully acquired and loaded
[    2.348354] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    2.351306] ACPI: Dynamic OEM Table Load:
[    2.351549] ACPI: SSDT 0xFFFF888100CB2800 0006A2 (v02 PmRef  Cpu0Ist  00=
003000 INTL 20120913)
[    2.353458] ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
[    2.354717] ACPI: Dynamic OEM Table Load:
[    2.355548] ACPI: SSDT 0xFFFF8888714EB800 00037F (v02 PmRef  Cpu0Cst  00=
003001 INTL 20120913)
[    2.357423] ACPI: Dynamic OEM Table Load:
[    2.357547] ACPI: SSDT 0xFFFF888871CFA6C0 00008E (v02 PmRef  Cpu0Hwp  00=
003000 INTL 20120913)
[    2.359339] ACPI: Dynamic OEM Table Load:
[    2.359547] ACPI: SSDT 0xFFFF88887158FC00 000130 (v02 PmRef  HwpLvt   00=
003000 INTL 20120913)
[    2.361727] ACPI: Dynamic OEM Table Load:
[    2.362548] ACPI: SSDT 0xFFFF888100CB3800 0005AA (v02 PmRef  ApIst    00=
003000 INTL 20120913)
[    2.364580] ACPI: Dynamic OEM Table Load:
[    2.365547] ACPI: SSDT 0xFFFF88887158F400 000119 (v02 PmRef  ApHwp    00=
003000 INTL 20120913)
[    2.367406] ACPI: Dynamic OEM Table Load:
[    2.367547] ACPI: SSDT 0xFFFF88887158E800 000119 (v02 PmRef  ApCst    00=
003000 INTL 20120913)
[    2.371494] ACPI: Interpreter enabled
[    2.371576] ACPI: (supports S0 S3 S4 S5)
[    2.372545] ACPI: Using IOAPIC for interrupt routing
[    2.373573] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    2.375210] ACPI: Enabled 7 GPEs in block 00 to 7F
[    2.377310] ACPI: Power Resource [PG00] (on)
[    2.377840] ACPI: Power Resource [PG01] (on)
[    2.378819] ACPI: Power Resource [PG02] (on)
[    2.381374] ACPI: Power Resource [WRST] (off)
[    2.381787] ACPI: Power Resource [WRST] (off)
[    2.382788] ACPI: Power Resource [WRST] (off)
[    2.383785] ACPI: Power Resource [WRST] (off)
[    2.384784] ACPI: Power Resource [WRST] (off)
[    2.385789] ACPI: Power Resource [WRST] (off)
[    2.386784] ACPI: Power Resource [WRST] (off)
[    2.387791] ACPI: Power Resource [WRST] (off)
[    2.388790] ACPI: Power Resource [WRST] (off)
[    2.389784] ACPI: Power Resource [WRST] (off)
[    2.390785] ACPI: Power Resource [WRST] (off)
[    2.391784] ACPI: Power Resource [WRST] (off)
[    2.392785] ACPI: Power Resource [WRST] (off)
[    2.393784] ACPI: Power Resource [WRST] (off)
[    2.394783] ACPI: Power Resource [WRST] (off)
[    2.395783] ACPI: Power Resource [WRST] (off)
[    2.396783] ACPI: Power Resource [WRST] (off)
[    2.397784] ACPI: Power Resource [WRST] (off)
[    2.398790] ACPI: Power Resource [WRST] (off)
[    2.399787] ACPI: Power Resource [WRST] (off)
[    2.410318] ACPI: Power Resource [FN00] (off)
[    2.410592] ACPI: Power Resource [FN01] (off)
[    2.411590] ACPI: Power Resource [FN02] (off)
[    2.412589] ACPI: Power Resource [FN03] (off)
[    2.413590] ACPI: Power Resource [FN04] (off)
[    2.415345] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    2.415550] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    2.417777] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME AER PCIeCapability LTR]
[    2.418546] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using B=
IOS configuration
[    2.420044] PCI host bridge to bus 0000:00
[    2.420549] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    2.421571] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    2.422554] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    2.423546] pci_bus 0000:00: root bus resource [mem 0x8c000000-0xdffffff=
f window]
[    2.424550] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7ffff=
f window]
[    2.425546] pci_bus 0000:00: root bus resource [bus 00-fe]
[    2.426558] pci 0000:00:00.0: [8086:191f] type 00 class 0x060000
[    2.427802] pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
[    2.428581] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    2.429696] pci 0000:00:02.0: [8086:1912] type 00 class 0x030000
[    2.430552] pci 0000:00:02.0: reg 0x10: [mem 0xde000000-0xdeffffff 64bit]
[    2.431549] pci 0000:00:02.0: reg 0x18: [mem 0xc0000000-0xcfffffff 64bit=
 pref]
[    2.432548] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    2.433712] pci 0000:00:14.0: [8086:a12f] type 00 class 0x0c0330
[    2.434562] pci 0000:00:14.0: reg 0x10: [mem 0xdf030000-0xdf03ffff 64bit]
[    2.435605] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    2.436661] pci 0000:00:14.2: [8086:a131] type 00 class 0x118000
[    2.437561] pci 0000:00:14.2: reg 0x10: [mem 0xdf04e000-0xdf04efff 64bit]
[    2.438687] pci 0000:00:16.0: [8086:a13a] type 00 class 0x078000
[    2.439559] pci 0000:00:16.0: reg 0x10: [mem 0xdf04d000-0xdf04dfff 64bit]
[    2.440614] pci 0000:00:16.0: PME# supported from D3hot
[    2.441673] pci 0000:00:17.0: [8086:a102] type 00 class 0x010601
[    2.442555] pci 0000:00:17.0: reg 0x10: [mem 0xdf048000-0xdf049fff]
[    2.443550] pci 0000:00:17.0: reg 0x14: [mem 0xdf04c000-0xdf04c0ff]
[    2.444550] pci 0000:00:17.0: reg 0x18: [io  0xf090-0xf097]
[    2.445550] pci 0000:00:17.0: reg 0x1c: [io  0xf080-0xf083]
[    2.446550] pci 0000:00:17.0: reg 0x20: [io  0xf060-0xf07f]
[    2.447550] pci 0000:00:17.0: reg 0x24: [mem 0xdf04b000-0xdf04b7ff]
[    2.448579] pci 0000:00:17.0: PME# supported from D3hot
[    2.449664] pci 0000:00:1c.0: [8086:a110] type 01 class 0x060400
[    2.450605] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    2.451713] pci 0000:00:1f.0: [8086:a146] type 00 class 0x060100
[    2.452742] pci 0000:00:1f.2: [8086:a121] type 00 class 0x058000
[    2.453557] pci 0000:00:1f.2: reg 0x10: [mem 0xdf044000-0xdf047fff]
[    2.454695] pci 0000:00:1f.3: [8086:a170] type 00 class 0x040300
[    2.455565] pci 0000:00:1f.3: reg 0x10: [mem 0xdf040000-0xdf043fff 64bit]
[    2.456573] pci 0000:00:1f.3: reg 0x20: [mem 0xdf020000-0xdf02ffff 64bit]
[    2.457589] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    2.458708] pci 0000:00:1f.4: [8086:a123] type 00 class 0x0c0500
[    2.459600] pci 0000:00:1f.4: reg 0x10: [mem 0xdf04a000-0xdf04a0ff 64bit]
[    2.460613] pci 0000:00:1f.4: reg 0x20: [io  0xf040-0xf05f]
[    2.461730] pci 0000:00:1f.6: [8086:15b7] type 00 class 0x020000
[    2.462563] pci 0000:00:1f.6: reg 0x10: [mem 0xdf000000-0xdf01ffff]
[    2.463647] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    2.464673] pci 0000:00:01.0: PCI bridge to [bus 01]
[    2.465606] pci 0000:02:00.0: [104c:8240] type 01 class 0x060400
[    2.466679] pci 0000:02:00.0: supports D1 D2
[    2.467655] pci 0000:00:1c.0: PCI bridge to [bus 02-03]
[    2.468596] pci_bus 0000:03: extended config space not accessible
[    2.469609] pci 0000:02:00.0: PCI bridge to [bus 03]
[    2.472072] ACPI: PCI Interrupt Link [LNKA] (IRQs *7 12), disabled.
[    2.472581] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *10), disabled.
[    2.473579] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 *5), disabled.
[    2.474579] ACPI: PCI Interrupt Link [LNKD] (IRQs 6 *11), disabled.
[    2.475578] ACPI: PCI Interrupt Link [LNKE] (IRQs *7 11), disabled.
[    2.476578] ACPI: PCI Interrupt Link [LNKF] (IRQs *3 10), disabled.
[    2.477578] ACPI: PCI Interrupt Link [LNKG] (IRQs *4 5), disabled.
[    2.478578] ACPI: PCI Interrupt Link [LNKH] (IRQs 6 12) *11, disabled.
[    2.479931] iommu: Default domain type: Translated=20
[    2.480557] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    2.481544] pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[    2.481547] pci 0000:00:02.0: vgaarb: bridge control possible
[    2.482545] vgaarb: loaded
[    2.483600] SCSI subsystem initialized
[    2.484556] ACPI: bus type USB registered
[    2.485554] usbcore: registered new interface driver usbfs
[    2.486549] usbcore: registered new interface driver hub
[    2.487555] usbcore: registered new device driver usb
[    2.488556] pps_core: LinuxPPS API ver. 1 registered
[    2.489545] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    2.490546] PTP clock support registered
[    2.491556] EDAC MC: Ver: 3.0.0
[    2.492641] NetLabel: Initializing
[    2.493546] NetLabel:  domain hash size =3D 128
[    2.494545] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    2.495556] NetLabel:  unlabeled traffic allowed by default
[    2.496545] PCI: Using ACPI for IRQ routing
[    2.525098] PCI: pci_cache_line_size set to 64 bytes
[    2.525585] e820: reserve RAM buffer [mem 0x0009c800-0x0009ffff]
[    2.526546] e820: reserve RAM buffer [mem 0x7caa6000-0x7fffffff]
[    2.527545] e820: reserve RAM buffer [mem 0x7cb23000-0x7fffffff]
[    2.528545] e820: reserve RAM buffer [mem 0x86f57000-0x87ffffff]
[    2.529546] e820: reserve RAM buffer [mem 0x872000000-0x873ffffff]
[    2.530662] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    2.531546] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    2.534554] clocksource: Switched to clocksource tsc-early
[    2.562347] VFS: Disk quotas dquot_6.6.0
[    2.566353] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    2.573341] AppArmor: AppArmor Filesystem Enabled
[    2.578119] pnp: PnP ACPI init
[    2.581432] system 00:00: [io  0x0a00-0x0a3f] has been reserved
[    2.587408] system 00:00: [io  0x0a40-0x0a7f] has been reserved
[    2.593382] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.600687] pnp 00:01: [dma 0 disabled]
[    2.604621] pnp 00:01: Plug and Play ACPI device, IDs PNP0501 (active)
[    2.611325] system 00:02: [io  0x0680-0x069f] has been reserved
[    2.617298] system 00:02: [io  0xffff] has been reserved
[    2.622667] system 00:02: [io  0xffff] has been reserved
[    2.628039] system 00:02: [io  0xffff] has been reserved
[    2.633408] system 00:02: [io  0x1800-0x18fe] has been reserved
[    2.639382] system 00:02: [io  0x164e-0x164f] has been reserved
[    2.645355] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.652252] system 00:03: [io  0x0800-0x087f] has been reserved
[    2.658228] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.665075] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    2.671671] system 00:05: [io  0x1854-0x1857] has been reserved
[    2.677644] system 00:05: Plug and Play ACPI device, IDs INT3f0d PNP0c02=
 (active)
[    2.685343] system 00:06: [mem 0xfed10000-0xfed17fff] has been reserved
[    2.692017] system 00:06: [mem 0xfed18000-0xfed18fff] has been reserved
[    2.698688] system 00:06: [mem 0xfed19000-0xfed19fff] has been reserved
[    2.705360] system 00:06: [mem 0xe0000000-0xefffffff] has been reserved
[    2.712034] system 00:06: [mem 0xfed20000-0xfed3ffff] has been reserved
[    2.718697] system 00:06: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    2.725702] system 00:06: [mem 0xfed45000-0xfed8ffff] has been reserved
[    2.732363] system 00:06: [mem 0xff000000-0xffffffff] has been reserved
[    2.739025] system 00:06: [mem 0xfee00000-0xfeefffff] could not be reser=
ved
[    2.746030] system 00:06: [mem 0xdffe0000-0xdfffffff] has been reserved
[    2.752691] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.759551] system 00:07: [mem 0xfd000000-0xfdabffff] has been reserved
[    2.766213] system 00:07: [mem 0xfdad0000-0xfdadffff] has been reserved
[    2.772873] system 00:07: [mem 0xfdb00000-0xfdffffff] has been reserved
[    2.779534] system 00:07: [mem 0xfe000000-0xfe01ffff] could not be reser=
ved
[    2.786537] system 00:07: [mem 0xfe036000-0xfe03bfff] has been reserved
[    2.793196] system 00:07: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    2.799857] system 00:07: [mem 0xfe410000-0xfe7fffff] has been reserved
[    2.806517] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.813571] system 00:08: [io  0xff00-0xfffe] has been reserved
[    2.819544] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.827189] system 00:09: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    2.833849] system 00:09: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    2.840509] system 00:09: [mem 0xfdac0000-0xfdacffff] has been reserved
[    2.847171] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.854635] pnp: PnP ACPI: found 10 devices
[    2.864140] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    2.873093] NET: Registered protocol family 2
[    2.877611] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6=
, 262144 bytes, linear)
[    2.886380] TCP established hash table entries: 262144 (order: 9, 209715=
2 bytes, linear)
[    2.894696] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes,=
 linear)
[    2.902230] TCP: Hash tables configured (established 262144 bind 65536)
[    2.908906] UDP hash table entries: 16384 (order: 7, 524288 bytes, linea=
r)
[    2.915868] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, =
linear)
[    2.923303] NET: Registered protocol family 1
[    2.927802] RPC: Registered named UNIX socket transport module.
[    2.933783] RPC: Registered udp transport module.
[    2.938558] RPC: Registered tcp transport module.
[    2.943330] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.949830] NET: Registered protocol family 44
[    2.954345] pci 0000:00:01.0: PCI bridge to [bus 01]
[    2.959378] pci 0000:02:00.0: PCI bridge to [bus 03]
[    2.964418] pci 0000:00:1c.0: PCI bridge to [bus 02-03]
[    2.969707] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    2.975939] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    2.982172] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    2.989090] pci_bus 0000:00: resource 7 [mem 0x8c000000-0xdfffffff windo=
w]
[    2.996009] pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff windo=
w]
[    3.003016] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    3.011498] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[    3.024980] IOAPIC[0]: Set routing entry (2-18 -> 0xef -> IRQ 18 Mode:1 =
Active:1 Dest:1)
[    3.033208] pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x620 took 212=
74 usecs
[    3.040687] PCI: CLS 0 bytes, default 64
[    3.044701] Trying to unpack rootfs image as initramfs...
[   10.755007] Freeing initrd memory: 836152K
[   10.759205] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[   10.765692] software IO TLB: mapped [mem 0x0000000082f57000-0x0000000086=
f57000] (64MB)
[   10.774350] Initialise system trusted keyrings
[   10.778870] Key type blacklist registered
[   10.782975] workingset: timestamp_bits=3D36 max_order=3D23 bucket_order=
=3D0
[   10.790328] zbud: loaded
[   10.800104] NET: Registered protocol family 38
[   10.804615] Key type asymmetric registered
[   10.808780] Asymmetric key parser 'x509' registered
[   10.813723] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 247)
[   10.821196] io scheduler mq-deadline registered
[   10.825791] io scheduler kyber registered
[   10.829885] io scheduler bfq registered
[   10.833815] atomic64_test: passed for x86-64 platform with CX8 and with =
SSE
[   10.840952] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[   10.854433] IOAPIC[0]: Set routing entry (2-16 -> 0xef -> IRQ 16 Mode:1 =
Active:1 Dest:1)
[   10.862610] pcieport 0000:00:01.0: PME: Signaling with IRQ 122
[   10.868638] pcieport 0000:00:1c.0: PME: Signaling with IRQ 123
[   10.874561] pcieport 0000:00:1c.0: AER: enabled with IRQ 123
[   10.880350] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   10.887116] intel_idle: MWAIT substates: 0x142120
[   10.891885] intel_idle: v0.5.1 model 0x5E
[   10.896224] intel_idle: Local APIC timer is reliable in all C-states
[   10.902795] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0E:00/input/input0
[   10.911224] ACPI: Sleep Button [SLPB]
[   10.914991] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input1
[   10.923402] ACPI: Power Button [PWRB]
[   10.927184] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input2
[   10.934668] ACPI: Power Button [PWRF]
[   10.939393] thermal LNXTHERM:00: registered as thermal_zone0
[   10.945110] ACPI: Thermal Zone [TZ00] (28 C)
[   10.949527] thermal LNXTHERM:01: registered as thermal_zone1
[   10.955241] ACPI: Thermal Zone [TZ01] (30 C)
[   10.959636] ERST DBG: ERST support is disabled.
[   10.964365] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[   10.970755] 00:01: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[   10.978998] Non-volatile memory driver v1.3
[   10.983664] rdac: device handler registered
[   10.988046] hp_sw: device handler registered
[   10.992382] emc: device handler registered
[   10.996608] alua: device handler registered
[   11.000931] e1000: Intel(R) PRO/1000 Network Driver
[   11.005867] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   11.011681] e1000e: Intel(R) PRO/1000 Network Driver
[   11.016712] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   11.022795] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[   11.038757] IOAPIC[0]: Set routing entry (2-19 -> 0xef -> IRQ 19 Mode:1 =
Active:1 Dest:1)
[   11.046967] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) se=
t to dynamic conservative mode
[   11.286393] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered=
 PHC clock
[   11.359761] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 64:=
00:6a:30:92:35
[   11.367739] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connecti=
on
[   11.374763] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0=
FF
[   11.381695] igb: Intel(R) Gigabit Ethernet Network Driver
[   11.387151] igb: Copyright (c) 2007-2014 Intel Corporation.
[   11.392787] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
[   11.398930] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[   11.404956] i40e: Intel(R) Ethernet Connection XL710 Network Driver
[   11.411275] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
[   11.417249] usbcore: registered new interface driver r8152
[   11.422809] usbcore: registered new interface driver asix
[   11.428266] usbcore: registered new interface driver ax88179_178a
[   11.434552] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   11.441148] ehci-pci: EHCI PCI platform driver
[   11.445666] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   11.451911] ohci-pci: OHCI PCI platform driver
[   11.456424] uhci_hcd: USB Universal Host Controller Interface driver
[   11.462973] IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1=
 Trig_Mode:0 Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000100 SID:F0F8 SQ:0 SVT=
:1)
[   11.476453] IOAPIC[0]: Set routing entry (2-18 -> 0xef -> IRQ 18 Mode:1 =
Active:1 Dest:1)
[   11.484636] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   11.490086] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 1
[   11.498640] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x1=
00 quirks 0x0000000001109810
[   11.507896] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[   11.514886] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.10
[   11.523201] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   11.530480] usb usb1: Product: xHCI Host Controller
[   11.535420] usb usb1: Manufacturer: Linux 5.10.0-rc3-01127-g8c3b1ba0e7ea=
 xhci-hcd
[   11.542958] usb usb1: SerialNumber: 0000:00:14.0
[   11.547851] hub 1-0:1.0: USB hub found
[   11.551729] hub 1-0:1.0: 16 ports detected
[   11.556711] xhci_hcd 0000:00:14.0: xHCI Host Controller
[   11.562144] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus =
number 2
[   11.569600] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[   11.575954] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.10
[   11.584280] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   11.591558] usb usb2: Product: xHCI Host Controller
[   11.596496] usb usb2: Manufacturer: Linux 5.10.0-rc3-01127-g8c3b1ba0e7ea=
 xhci-hcd
[   11.604033] usb usb2: SerialNumber: 0000:00:14.0
[   11.608927] hub 2-0:1.0: USB hub found
[   11.612778] hub 2-0:1.0: 10 ports detected
[   11.617313] usb: port power management may be unreliable
[   11.622891] i8042: PNP: No PS/2 controller found.
[   11.627739] mousedev: PS/2 mouse device common for all mice
[   11.633511] rtc_cmos 00:04: RTC can wake from S4
[   11.638839] rtc_cmos 00:04: registered as rtc0
[   11.643509] rtc_cmos 00:04: setting system clock to 2020-12-25T16:24:04 =
UTC (1608913444)
[   11.651660] rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram=
, hpet irqs
[   11.659516] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[   11.665458] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[   11.675002] i2c i2c-0: 4/4 memory slots populated (from DMI)
[   11.681232] i2c i2c-0: Successfully instantiated SPD at 0x50
[   11.687468] i2c i2c-0: Successfully instantiated SPD at 0x51
[   11.693715] i2c i2c-0: Successfully instantiated SPD at 0x52
[   11.699950] i2c i2c-0: Successfully instantiated SPD at 0x53
[   11.705717] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   11.711427] iTCO_wdt: Found a Intel PCH TCO device (Version=3D4, TCOBASE=
=3D0x0400)
[   11.719034] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[   11.725126] iTCO_vendor_support: vendor-support=3D0
[   11.729916] intel_pstate: Intel P-state driver initializing
[   11.736271] intel_pstate: HWP enabled
[   11.740240] hid: raw HID events driver (C) Jiri Kosina
[   11.745481] usbcore: registered new interface driver usbhid
[   11.751113] usbhid: USB HID core driver
[   11.755047] drop_monitor: Initializing network drop monitor service
[   11.761406] Initializing XFRM netlink socket
[   11.765807] NET: Registered protocol family 10
[   11.770514] Segment Routing with IPv6
[   11.774260] NET: Registered protocol family 17
[   11.778962] 9pnet: Installing 9P2000 support
[   11.783314] mpls_gso: MPLS GSO support
[   11.787762] microcode: sig=3D0x506e3, pf=3D0x2, revision=3D0xe2
[   11.793429] microcode: Microcode Update Driver: v2.2.
[   11.793446] IPI shorthand broadcast: enabled
[   11.803013] ... APIC ID:      00000000 (0)
[   11.804011] ... APIC VERSION: 01060015
[   11.804011] 000000000000000000000000000000000000000000000000000000000000=
0000
[   11.804011] 000000000000000000000000000000000000000000000000000000000000=
0000
[   11.804011] 000000000000000000000000000000000000000000000000000000000800=
1000
[   11.804011]=20
[   11.832284] number of MP IRQ sources: 15.
[   11.837596] tsc: Refined TSC clocksource calibration: 3192.000 MHz
[   11.837939] number of IO-APIC #2 registers: 120.
[   11.844174] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2e0=
2c4a121d, max_idle_ns: 440795236083 ns
[   11.848852] testing the IO APIC.......................
[   11.864099] IO APIC #2......
[   11.867057] .... register #00: 02000000
[   11.870964] .......    : physical APIC id: 02
[   11.875387] .......    : Delivery Type: 0
[   11.879467] .......    : LTS          : 0
[   11.883543] .... register #01: 00770020
[   11.887449] .......     : max redirection entries: 77
[   11.892561] .......     : PRQ implemented: 0
[   11.896895] .......     : IO APIC version: 20
[   11.901318] .... register #02: 00000000
[   11.905223] .......     : arbitration: 00
[   11.909302] .... IRQ redirection table:
[   11.913208] IOAPIC 0:
[   11.915574]  pin00, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.923465]  pin01, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.931357]  pin02, enabled , edge , high, V(02), IRR(0), S(0), remapped=
, I(0001),  Z(0)
[   11.939508]  pin03, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.947400]  pin04, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.955293]  pin05, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.963197]  pin06, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.971102]  pin07, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   11.979008]  pin08, enabled , edge , high, V(08), IRR(0), S(0), remapped=
, I(0007),  Z(0)
[   11.987171]  pin09, enabled , level, high, V(09), IRR(0), S(0), remapped=
, I(0008),  Z(0)
[   11.995322]  pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.003217]  pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.011110]  pin0c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.019004]  pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.026897]  pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.034789]  pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.042683]  pin10, enabled , level, low , V(10), IRR(0), S(0), remapped=
, I(000F),  Z(0)
[   12.050833]  pin11, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.058725]  pin12, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.066618]  pin13, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.074510]  pin14, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.082403]  pin15, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.090296]  pin16, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.098187]  pin17, disabled, edge , high, V(00), IRR(0), S(0), remapped=
, I(0000),  Z(2)
[   12.106337]  pin18, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.114230]  pin19, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.122123]  pin1a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.130015]  pin1b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.137906]  pin1c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.145798]  pin1d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.153688]  pin1e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.164077]  pin1f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.171970]  pin20, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.179862]  pin21, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.187754]  pin22, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.195648]  pin23, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.203556]  pin24, disabled, edge , high, V(21), IRR(0), S(0), physical=
, D(00), M(2)
[   12.211463]  pin25, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.219367]  pin26, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.227267]  pin27, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(01), M(2)
[   12.235161]  pin28, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.243053]  pin29, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.250947]  pin2a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.258839]  pin2b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.266733]  pin2c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.274627]  pin2d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.282521]  pin2e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.290413]  pin2f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.298306]  pin30, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.306199]  pin31, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.314092]  pin32, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.321983]  pin33, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.329876]  pin34, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.337768]  pin35, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.345660]  pin36, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.353552]  pin37, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.361444]  pin38, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.369335]  pin39, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.377226]  pin3a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.385119]  pin3b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.393009]  pin3c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.400899]  pin3d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.408789]  pin3e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.416680]  pin3f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.424573]  pin40, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.432464]  pin41, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.440372]  pin42, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.448278]  pin43, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.456182]  pin44, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.464084]  pin45, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.471974]  pin46, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.479866]  pin47, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.487758]  pin48, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.495651]  pin49, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.503542]  pin4a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(08), M(2)
[   12.511432]  pin4b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.519323]  pin4c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.527215]  pin4d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.535107]  pin4e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.542999]  pin4f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.550888]  pin50, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.558780]  pin51, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.566672]  pin52, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(80), M(2)
[   12.574565]  pin53, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.582457]  pin54, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.590348]  pin55, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.598240]  pin56, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.606132]  pin57, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.614024]  pin58, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.621918]  pin59, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.629810]  pin5a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.637702]  pin5b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.645597]  pin5c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.653489]  pin5d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.661380]  pin5e, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.669271]  pin5f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.677177]  pin60, disabled, edge , high, V(20), IRR(0), S(0), physical=
, D(08), M(2)
[   12.685081]  pin61, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.692986]  pin62, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.700891]  pin63, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.708784]  pin64, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.716679]  pin65, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.724574]  pin66, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.732466]  pin67, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.740358]  pin68, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.748252]  pin69, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.756145]  pin6a, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.764038]  pin6b, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.771930]  pin6c, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.779822]  pin6d, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.787712]  pin6e, disabled, edge , high, V(00), IRR(0), S(0), logical =
, D(00), M(2)
[   12.795603]  pin6f, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.803494]  pin70, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.811386]  pin71, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.819279]  pin72, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.827169]  pin73, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.835060]  pin74, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.842953]  pin75, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.850847]  pin76, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.858738]  pin77, disabled, edge , high, V(00), IRR(0), S(0), physical=
, D(00), M(0)
[   12.866625] IRQ to pin mappings:
[   12.872424] IRQ0 -> 0:2
[   12.874954] IRQ1 -> 0:1
[   12.877483] IRQ3 -> 0:3
[   12.880013] IRQ4 -> 0:4
[   12.882542] IRQ5 -> 0:5
[   12.885071] IRQ6 -> 0:6
[   12.887599] IRQ7 -> 0:7
[   12.890129] IRQ8 -> 0:8
[   12.892658] IRQ9 -> 0:9
[   12.895187] IRQ10 -> 0:10
[   12.897889] IRQ11 -> 0:11
[   12.900590] IRQ12 -> 0:12
[   12.903290] IRQ13 -> 0:13
[   12.905990] IRQ14 -> 0:14
[   12.908693] IRQ15 -> 0:15
[   12.911399] IRQ16 -> 0:16
[   12.914107] IRQ18 -> 0:18
[   12.916812] IRQ19 -> 0:19
[   12.919517] .................................... done.
[   12.924730] clocksource: Switched to clocksource tsc
[   12.924735] AVX2 version of gcm_enc/dec engaged.
[   12.934478] AES CTR mode by8 optimization enabled
[   12.941097] sched_clock: Marking stable (11984581635, 956511572)->(13986=
499829, -1045406622)
[   12.949934] registered taskstats version 1
[   12.954115] Loading compiled-in X.509 certificates
[   12.959849] Loaded X.509 cert 'Build time autogenerated kernel key: bf0a=
41d88f630fbef6db60a8bcbfaf331b5b9e32'
[   12.969832] zswap: loaded using pool lzo/zbud
[   12.974530] Key type ._fscrypt registered
[   12.978665] Key type .fscrypt registered
[   12.982710] Key type fscrypt-provisioning registered
[   12.990520] Key type encrypted registered
[   12.994654] AppArmor: AppArmor sha1 policy hashing enabled
[   13.000213] ima: No TPM chip found, activating TPM-bypass!
[   13.005772] ima: Allocated hash algorithm: sha1
[   13.010381] ima: No architecture policies found
[   13.014990] evm: Initialising EVM extended attributes:
[   13.020198] evm: security.selinux
[   13.023638] evm: security.apparmor
[   13.027122] evm: security.ima
[   13.030176] evm: security.capability
[   13.033831] evm: HMAC attrs: 0x1
[   17.943423] e1000e 0000:00:1f.6 eth0: NIC Link is Up 1000 Mbps Full Dupl=
ex, Flow Control: Rx/Tx
[   17.953843] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   17.965774] Sending DHCP requests ., OK
[   17.973550] IP-Config: Got DHCP answer from 192.168.3.2, my address is 1=
92.168.3.95
[   17.981292] IP-Config: Complete:
[   17.984629]      device=3Deth0, hwaddr=3D64:00:6a:30:92:35, ipaddr=3D192=
=2E168.3.95, mask=3D255.255.255.0, gw=3D192.168.3.200
[   17.994944]      host=3Dlkp-skl-d04, domain=3Dlkp.intel.com, nis-domain=
=3D(none)
[   18.001876]      bootserver=3D192.168.3.200, rootserver=3D192.168.3.200,=
 rootpath=3D
[   18.001877]      nameserver0=3D192.168.3.200
[   18.013346]=20
[   18.013377] TAP version 14
[   18.017755] 1..1
[   18.019685]     # Subtest: property-entry
[   18.019686]     1..7
[   18.024050]     ok 1 - pe_test_uints
[   18.026490]     ok 2 - pe_test_uint_arrays
[   18.030419]     ok 3 - pe_test_strings
[   18.034911]     ok 4 - pe_test_bool
[   18.038857]     ok 5 - pe_test_move_inline_u8
[   18.042568]     ok 6 - pe_test_move_inline_str
[   18.047278]     ok 7 - pe_test_reference
[   18.051813] ok 1 - property-entry
[   18.060245] Freeing unused decrypted memory: 2036K
[   18.065468] Freeing unused kernel image (initmem) memory: 2432K
[   18.076689] Write protecting the kernel read-only data: 22528k
[   18.083184] Freeing unused kernel image (text/rodata gap) memory: 2036K
[   18.090211] Freeing unused kernel image (rodata/data gap) memory: 1332K
[   18.102667] Run /init as init process
[   18.106412]   with arguments:
[   18.109465]     /init
[   18.111826]     nokaslr
[   18.114360]   with environment:
[   18.117611]     HOME=3D/
[   18.120059]     TERM=3Dlinux
[   18.122854]     user=3Dlkp
[   18.125474]     job=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-=
gcc-ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445=
ea59c806787813-20201226-25066-sfkgan-4.yaml
[   18.142107]     ARCH=3Dx86_64
[   18.144986]     kconfig=3Dx86_64-rhel-8.3
[   18.148901]     branch=3Ddrm-intel/drm-intel-gt-next
[   18.153767]     commit=3D8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813
[   18.159761]     BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/vmlinuz-5.10.0-rc3-01127-g8c3b1ba0e7ea
[   18.172337]     max_uptime=3D2100
[   18.175573]     RESULT_ROOT=3D/result/perf-sanity-tests/gcc-ucode=3D0xe2=
/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0=
e7ea9a80b0ee4b4445ea59c806787813/5
[   18.191439]     LKP_SERVER=3Dinternal-lkp-server
[   18.195960]     softlockup_panic=3D1
[   18.199444]     prompt_ramdisk=3D0
[   18.202756]     vga=3Dnormal
[   18.209377] systemd[1]: RTC configured in localtime, applying delta of 0=
 minutes to system time.


         Mou
[   18.378974] wmi_bus wmi_bus-PNP0C14:00: WQBC data block query control me=
thod not found
ssage Queue File
[   18.427963] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   18.435013] RAPL PMU: hw unit of domain package 2^-14 Joules
         Startin
[   18.442050] RAPL PMU: hw unit of domain dram 2^-14 Joules
nt Root and Kern
[   18.456254] ahci 0000:00:17.0: version 3.0
39mRPC Pipe File
[   18.478997] IOAPIC[0]: Set routing entry (2-17 -> 0xef -> IRQ 17 Mode:1 =
Active:1 Dest:1)
ess NFS configur
[   18.666287] scsi host1: ahci
 =20
[   18.670430] scsi host2: ahci
       Starting=20
[   18.674508] scsi host3: ahci
rnel Device Mana
[   18.687548] ata2: SATA max UDMA/133 abar m2048@0xdf04b000 port 0xdf04b18=
0 irq 127
[   18.755674] i915 0000:00:02.0: vgaarb: deactivate vga console
[   18.763457] Console: switching to colour dummy device 80x25
r to synchronize
[   18.781328] i915 0000:00:02.0: Direct firmware load for i915/skl_dmc_ver=
1_27.bin failed with error -2
 boot up for ifu
[   18.791792] i915 0000:00:02.0: [drm] Failed to load DMC firmware i915/sk=
l_dmc_ver1_27.bin. Disabling runtime power management.
[   18.804413] i915 0000:00:02.0: [drm] DMC firmware homepage: https://git.=
kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
[   18.818133] [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on mi=
nor 0
 Journal to Pers
[   18.836178] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08=
:00/LNXVIDEO:00/input/input4
[   18.850210] random: fast init done
         Startin
[   18.871517] intel_rapl_common: Found RAPL domain package
[   18.884593] intel_rapl_common: Found RAPL domain uncore
[   18.889782] intel_rapl_common: Found RAPL domain dram
[   19.019708] ata4: SATA link down (SStatus 4 SControl 300)
[   19.025078] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   19.031218] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   19.031260] ata3: SATA link down (SStatus 4 SControl 300)
[   19.050686] ata2.00: 2344225968 sectors, multi 1: LBA48 NCQ (depth 32)
m.
[   18.250605] rc.local[290]: PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sb=
in:/usr/bin:/sbin:/bin:/lkp/lkp/src/bin
LKP: HOSTNAME lkp-skl-d04, MAC 64:00:6a:30:92:35, kernel 5.10.0-rc3-01127-g=
8c3b1ba0e7ea 1, serial console /dev/ttyS0
         Startin
[   19.250920] ata1.00: ATA-9: ST1000DM003-1ER162, CC45, max UDMA/133

[   19.271750] scsi 0:0:0:0: Direct-Access     ATA      ST1000DM003-1ER1 CC=
45 PQ: 0 ANSI: 5
[   19.280244] scsi 1:0:0:0: Direct-Access     ATA      INTEL SSDSC2BB01 00=
23 PQ: 0 ANSI: 5
1;39mSystem Logg
[   19.302976] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[   19.306697] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 =
TB/932 GiB)

[   19.321745] sd 0:0:0:0: [sda] 4096-byte physical blocks
[   19.321899] sd 1:0:0:0: [sdb] 2344225968 512-byte logical blocks: (1.20 =
TB/1.09 TiB)
[   19.333464] i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
[   19.333750] sd 1:0:0:0: [sdb] 4096-byte physical blocks
[   19.335589] sd 0:0:0:0: [sda] Write Protect is off
[   19.335590] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   19.335598] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   19.335694] sd 1:0:0:0: Attached scsi generic sg1 type 0
[   19.376861] sd 1:0:0:0: [sdb] Write Protect is off
0m
[   19.388029] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   19.403025] ata2.00: Enabling discard_zeroes_data
[   19.408785] sd 1:0:0:0: [sdb] Attached SCSI disk
al Compatibility
[   19.421854] sd 0:0:0:0: [sda] Attached SCSI disk
[   19.448136] ipmi device interface
[   19.461579] ipmi_si: IPMI System Interface driver
[   19.466972] ipmi_si: Unable to find any System Interface(s)
See 'systemctl status openipmi.service' for details.
[   20.404571] random: crng init done
[   20.407949] random: 2 urandom warning(s) missed due to ratelimiting
[   24.066557] Kernel tests: Boot OK!
[   24.066560]=20
[   28.234253] install debs round one: dpkg -i --force-confdef --force-depe=
nds /opt/deb/ntpdate_1%3a4.2.8p12+dfsg-4_amd64.deb
[   28.234256]=20
[   28.247737] /opt/deb/libperl5.28_5.28.1-6+deb10u1_amd64.deb
[   28.247739]=20
[   28.255613] /opt/deb/perl_5.28.1-6+deb10u1_amd64.deb
[   28.255615]=20
[   28.262930] /opt/deb/perl-base_5.28.1-6+deb10u1_amd64.deb
[   28.262931]=20
[   28.270833] /opt/deb/perl-modules-5.28_5.28.1-6+deb10u1_all.deb
[   28.270834]=20
[   28.279463] /opt/deb/libpython3.7-minimal_3.7.3-2+deb10u2_amd64.deb
[   28.279465]=20
[   28.288319] /opt/deb/python3.7-minimal_3.7.3-2+deb10u2_amd64.deb
[   28.288320]=20
[   28.296617] /opt/deb/python3-minimal_3.7.3-1_amd64.deb
[   28.296618]=20
[   28.304505] /opt/deb/libpython3.7-stdlib_3.7.3-2+deb10u2_amd64.deb
[   28.304506]=20
[   28.313029] /opt/deb/python3.7_3.7.3-2+deb10u2_amd64.deb
[   28.313030]=20
[   28.320693] /opt/deb/libpython3-stdlib_3.7.3-1_amd64.deb
[   28.320694]=20
[   28.328190] /opt/deb/python3_3.7.3-1_amd64.deb
[   28.328191]=20
[   28.335088] /opt/deb/gtk-update-icon-cache_3.24.5-1_amd64.deb
[   28.335089]=20
[   28.343097] /opt/deb/libthai-data_0.1.28-2_all.deb
[   28.343099]=20
[   28.350146] /opt/deb/libdatrie1_0.2.12-2_amd64.deb
[   28.350147]=20
[   28.357376] /opt/deb/libavahi-common-data_0.7-4+b1_amd64.deb
[   28.357378]=20
[   28.365341] /opt/deb/libasound2-data_1.1.8-1_all.deb
[   28.365342]=20
[   28.372919] /opt/deb/ca-certificates-java_20190405_all.deb
[   28.372921]=20
[   28.380651] /opt/deb/libatomic1_8.3.0-6_amd64.deb
[   28.380652]=20
[   28.387559] /opt/deb/libquadmath0_8.3.0-6_amd64.deb
[   28.387560]=20
[   28.394693] /opt/deb/libgcc-8-dev_8.3.0-6_amd64.deb
[   28.394694]=20
[   28.401822] /opt/deb/lib32gcc1_1%3a8.3.0-6_amd64.deb
[   28.401823]=20
[   28.408922] /opt/deb/gcc-8_8.3.0-6_amd64.deb
[   28.408923]=20
[   28.415416] /opt/deb/gcc_4%3a8.3.0-1_amd64.deb
[   28.415417]=20
[   28.421986] /opt/deb/g++-8_8.3.0-6_amd64.deb
[   28.421987]=20
[   28.428558] /opt/deb/g++_4%3a8.3.0-1_amd64.deb
[   28.428560]=20
[   28.435459] /opt/deb/libatk1.0-data_2.30.0-2_all.deb
[   28.435461]=20
[   28.442747] /opt/deb/libatk1.0-0_2.30.0-2_amd64.deb
[   28.442748]=20
[   28.449970] /opt/deb/gir1.2-atk-1.0_2.30.0-2_amd64.deb
[   28.449971]=20
[   28.457316] /opt/deb/libdpkg-perl_1.19.7_all.deb
[   28.457317]=20
[   28.464354] /opt/deb/libglib2.0-data_2.58.3-2+deb10u2_all.deb
[   28.464355]=20
[   28.472379] /opt/deb/python3-lib2to3_3.7.3-1_all.deb
[   28.472380]=20
[   28.479631] /opt/deb/python3-distutils_3.7.3-1_all.deb
[   28.479632]=20
[   28.487076] /opt/deb/libatk1.0-dev_2.30.0-2_amd64.deb
[   28.487077]=20
[   28.494622] /opt/deb/libexpat1-dev_2.2.6-2+deb10u1_amd64.deb
[   28.494623]=20
[   28.502675] /opt/deb/libperl-dev_5.28.1-6+deb10u1_amd64.deb
[   28.502677]=20
[   28.510770] /opt/deb/libpython2.7_2.7.16-2+deb10u1_amd64.deb
[   28.510771]=20
[   28.519038] /opt/deb/libpython2.7-dev_2.7.16-2+deb10u1_amd64.deb
[   28.519039]=20
[   28.527366] /opt/deb/libpython2-dev_2.7.16-1_amd64.deb
[   28.527367]=20
[   28.534858] /opt/deb/libpython-dev_2.7.16-1_amd64.deb
[   28.534872]=20
[   28.542194] /opt/deb/patch_2.7.6-3+deb10u1_amd64.deb
[   28.542195]=20
[   28.549594] /opt/deb/python2.7-dev_2.7.16-2+deb10u1_amd64.deb
[   28.549595]=20
[   28.557658] /opt/deb/python2-dev_2.7.16-1_amd64.deb
[   28.557659]=20
[   28.564746] /opt/deb/python-dev_2.7.16-1_amd64.deb
[   28.564747]=20
[   28.571786] /opt/deb/gawk_1%3a4.2.1+dfsg-1_amd64.deb
[   28.571787]=20
[   28.579237] Selecting previously unselected package ntpdate.
[   28.579239]=20
[   28.587874] (Reading database ... 16553 files and directories currently =
installed.)
[   28.587876]=20
[   28.598601] Preparing to unpack .../ntpdate_1%3a4.2.8p12+dfsg-4_amd64.de=
b ...
[   28.598603]=20
[   28.608134] Unpacking ntpdate (1:4.2.8p12+dfsg-4) ...
[   28.608135]=20
[   28.616076] Preparing to unpack .../libperl5.28_5.28.1-6+deb10u1_amd64.d=
eb ...
[   28.616077]=20
[   28.626252] Unpacking libperl5.28:amd64 (5.28.1-6+deb10u1) over (5.28.1-=
6) ...
[   28.626254]=20
[   28.636207] Preparing to unpack .../perl_5.28.1-6+deb10u1_amd64.deb ...
[   28.636208]=20
[   28.645398] Unpacking perl (5.28.1-6+deb10u1) over (5.28.1-6) ...
[   28.645399]=20
[   28.654355] Preparing to unpack .../perl-base_5.28.1-6+deb10u1_amd64.deb=
 ...
[   28.654356]=20
[   28.664068] Unpacking perl-base (5.28.1-6+deb10u1) over (5.28.1-6) ...
[   28.664070]=20
[   28.673584] Preparing to unpack .../perl-modules-5.28_5.28.1-6+deb10u1_a=
ll.deb ...
[   28.673586]=20
[   28.684020] Unpacking perl-modules-5.28 (5.28.1-6+deb10u1) over (5.28.1-=
6) ...
[   28.684021]=20
[   28.694120] Selecting previously unselected package libpython3.7-minimal=
:amd64.
[   28.694121]=20
[   28.704460] Preparing to unpack .../libpython3.7-minimal_3.7.3-2+deb10u2=
_amd64.deb ...
[   28.704461]=20
[   28.715078] Unpacking libpython3.7-minimal:amd64 (3.7.3-2+deb10u2) ...
[   28.715079]=20
[   28.724291] Selecting previously unselected package python3.7-minimal.
[   28.724292]=20
[   28.733865] Preparing to unpack .../python3.7-minimal_3.7.3-2+deb10u2_am=
d64.deb ...
[   28.733866]=20
[   28.743973] Unpacking python3.7-minimal (3.7.3-2+deb10u2) ...
[   28.743974]=20
[   28.752384] Selecting previously unselected package python3-minimal.
[   28.752385]=20
[   28.761467] Preparing to unpack .../python3-minimal_3.7.3-1_amd64.deb ...
[   28.761468]=20
[   28.770458] Unpacking python3-minimal (3.7.3-1) ...
[   28.770459]=20
[   28.778198] Selecting previously unselected package libpython3.7-stdlib:=
amd64.
[   28.778200]=20
[   28.788441] Preparing to unpack .../libpython3.7-stdlib_3.7.3-2+deb10u2_=
amd64.deb ...
[   28.788443]=20
[   28.798917] Unpacking libpython3.7-stdlib:amd64 (3.7.3-2+deb10u2) ...
[   28.798918]=20
[   28.807853] Selecting previously unselected package python3.7.
[   28.807854]=20
[   28.816466] Preparing to unpack .../python3.7_3.7.3-2+deb10u2_amd64.deb =
=2E..
[   28.816467]=20
[   28.825681] Unpacking python3.7 (3.7.3-2+deb10u2) ...
[   28.825682]=20
[   28.833495] Selecting previously unselected package libpython3-stdlib:am=
d64.
[   28.833496]=20
[   28.843217] Preparing to unpack .../libpython3-stdlib_3.7.3-1_amd64.deb =
=2E..
[   28.843219]=20
[   28.852578] Unpacking libpython3-stdlib:amd64 (3.7.3-1) ...
[   28.852580]=20
[   28.860633] Selecting previously unselected package python3.
[   28.860635]=20
[   28.869034] Preparing to unpack .../deb/python3_3.7.3-1_amd64.deb ...
[   28.869035]=20
[   28.877555] Unpacking python3 (3.7.3-1) ...
[   28.877557]=20
[   28.884450] Selecting previously unselected package gtk-update-icon-cach=
e.
[   28.884451]=20
[   28.894143] Preparing to unpack .../gtk-update-icon-cache_3.24.5-1_amd64=
=2Edeb ...
[   28.894144]=20
[   29.464714] No diversion 'diversion of /usr/sbin/update-icon-caches to /=
usr/sbin/update-icon-caches.gtk2 by libgtk-3-bin', none removed.
[   29.464716]=20
[   30.594291] No diversion 'diversion of /usr/share/man/man8/update-icon-c=
aches.8.gz to /usr/share/man/man8/update-icon-caches.gtk2.8.gz by libgtk-3-=
bin', none removed.
[   30.594294]=20
[   30.611523] Unpacking gtk-update-icon-cache (3.24.5-1) ...
[   30.611525]=20
[   30.619892] Selecting previously unselected package libthai-data.
[   30.619907]=20
[   30.630338] Preparing to unpack .../libthai-data_0.1.28-2_all.deb ...
[   30.630339]=20
[   30.637576] SGI XFS with ACLs, security attributes, realtime, scrub, rep=
air, quota, fatal assert, debug enabled
[   30.638981] Unpacking libthai-data (0.1.28-2) ...
[   30.648203]=20
[   30.655115] XFS (sdb1): Deprecated V4 format (crc=3D0) will not be suppo=
rted after September 2030.
[   30.655724] Selecting previously unselected package libdatrie1:amd64.
[   30.663826]=20
[   30.671774] XFS (sdb1): Mounting V4 Filesystem
[   30.672927] Preparing to unpack .../libdatrie1_0.2.12-2_amd64.deb ...
[   30.676179]=20
[   30.685001] Unpacking libdatrie1:amd64 (0.2.12-2) ...
[   30.685002]=20
[   30.692952] Selecting previously unselected package libavahi-common-data=
:amd64.
[   30.692953]=20
[   30.703055] Preparing to unpack .../libavahi-common-data_0.7-4+b1_amd64.=
deb ...
[   30.703056]=20
[   30.712874] Unpacking libavahi-common-data:amd64 (0.7-4+b1) ...
[   30.712875]=20
[   30.721404] Selecting previously unselected package libasound2-data.
[   30.721405]=20
[   30.730534] Preparing to unpack .../libasound2-data_1.1.8-1_all.deb ...
[   30.730536]=20
[   30.739400] Unpacking libasound2-data (1.1.8-1) ...
[   30.739401]=20
[   30.747033] Selecting previously unselected package ca-certificates-java.
[   30.747034]=20
[   30.756715] Preparing to unpack .../ca-certificates-java_20190405_all.de=
b ...
[   30.756716]=20
[   30.763913] XFS (sdb1): Starting recovery (logdev: internal)
[   30.766237] Unpacking ca-certificates-java (20190405) ...
[   30.770892]=20
[   30.779105] Selecting previously unselected package libatomic1:amd64.
[   30.779107]=20
[   30.788257] Preparing to unpack .../libatomic1_8.3.0-6_amd64.deb ...
[   30.788258]=20
[   30.797134] Unpacking libatomic1:amd64 (8.3.0-6) ...
[   30.797135]=20
[   30.805046] Selecting previously unselected package libquadmath0:amd64.
[   30.805047]=20
[   30.814399] XFS (sdb1): Ending recovery (logdev: internal)
[   30.814630] Preparing to unpack .../libquadmath0_8.3.0-6_amd64.deb ...
[   30.819837]=20
[   30.828862] Unpacking libquadmath0:amd64 (8.3.0-6) ...
[   30.828863]=20
[   30.836267] xfs filesystem being mounted at /opt/rootfs supports timesta=
mps until 2038 (0x7fffffff)
[   30.836846] Selecting previously unselected package libgcc-8-dev:amd64.
[   30.845235]=20
[   30.854664] Preparing to unpack .../libgcc-8-dev_8.3.0-6_amd64.deb ...
[   30.854665]=20
[   30.863521] Unpacking libgcc-8-dev:amd64 (8.3.0-6) ...
[   30.863522]=20
[   30.871169] Selecting previously unselected package lib32gcc1.
[   30.871170]=20
[   30.879642] Preparing to unpack .../lib32gcc1_1%3a8.3.0-6_amd64.deb ...
[   30.879644]=20
[   30.888394] Unpacking lib32gcc1 (1:8.3.0-6) ...
[   30.888396]=20
[   30.895466] Selecting previously unselected package gcc-8.
[   30.895467]=20
[   30.903469] Preparing to unpack .../deb/gcc-8_8.3.0-6_amd64.deb ...
[   30.903470]=20
[   30.911801] Unpacking gcc-8 (8.3.0-6) ...
[   30.911802]=20
[   30.918129] Selecting previously unselected package gcc.
[   30.918130]=20
[   30.926019] Preparing to unpack .../deb/gcc_4%3a8.3.0-1_amd64.deb ...
[   30.926020]=20
[   30.934450] Unpacking gcc (4:8.3.0-1) ...
[   30.934451]=20
[   30.940835] Selecting previously unselected package g++-8.
[   30.940836]=20
[   30.948856] Preparing to unpack .../deb/g++-8_8.3.0-6_amd64.deb ...
[   30.948857]=20
[   30.957156] Unpacking g++-8 (8.3.0-6) ...
[   30.957157]=20
[   30.963469] Selecting previously unselected package g++.
[   30.963470]=20
[   30.971361] Preparing to unpack .../deb/g++_4%3a8.3.0-1_amd64.deb ...
[   30.971362]=20
[   30.979840] Unpacking g++ (4:8.3.0-1) ...
[   30.979841]=20
[   30.986392] Selecting previously unselected package libatk1.0-data.
[   30.986393]=20
[   30.995289] Preparing to unpack .../libatk1.0-data_2.30.0-2_all.deb ...
[   30.995290]=20
[   31.004131] Unpacking libatk1.0-data (2.30.0-2) ...
[   31.004132]=20
[   31.011710] Selecting previously unselected package libatk1.0-0:amd64.
[   31.011711]=20
[   31.020820] Preparing to unpack .../libatk1.0-0_2.30.0-2_amd64.deb ...
[   31.020821]=20
[   31.029639] Unpacking libatk1.0-0:amd64 (2.30.0-2) ...
[   31.029640]=20
[   31.037443] Selecting previously unselected package gir1.2-atk-1.0:amd64.
[   31.037444]=20
[   31.046876] Preparing to unpack .../gir1.2-atk-1.0_2.30.0-2_amd64.deb ...
[   31.046877]=20
[   31.056027] Unpacking gir1.2-atk-1.0:amd64 (2.30.0-2) ...
[   31.056028]=20
[   31.063953] Selecting previously unselected package libdpkg-perl.
[   31.063954]=20
[   31.072669] Preparing to unpack .../libdpkg-perl_1.19.7_all.deb ...
[   31.072670]=20
[   31.081105] Unpacking libdpkg-perl (1.19.7) ...
[   31.081106]=20
[   31.088217] Selecting previously unselected package libglib2.0-data.
[   31.088218]=20
[   31.097348] Preparing to unpack .../libglib2.0-data_2.58.3-2+deb10u2_all=
=2Edeb ...
[   31.097349]=20
[   31.107128] Unpacking libglib2.0-data (2.58.3-2+deb10u2) ...
[   31.107129]=20
[   31.115334] Selecting previously unselected package python3-lib2to3.
[   31.115335]=20
[   31.124292] Preparing to unpack .../python3-lib2to3_3.7.3-1_all.deb ...
[   31.124293]=20
[   31.133130] Unpacking python3-lib2to3 (3.7.3-1) ...
[   31.133131]=20
[   31.140701] Selecting previously unselected package python3-distutils.
[   31.140702]=20
[   31.149863] Preparing to unpack .../python3-distutils_3.7.3-1_all.deb ...
[   31.149864]=20
[   31.158942] Unpacking python3-distutils (3.7.3-1) ...
[   31.158944]=20
[   31.166693] Selecting previously unselected package libatk1.0-dev:amd64.
[   31.166694]=20
[   31.176014] Preparing to unpack .../libatk1.0-dev_2.30.0-2_amd64.deb ...
[   31.176015]=20
[   31.185031] Unpacking libatk1.0-dev:amd64 (2.30.0-2) ...
[   31.185032]=20
[   31.192967] Selecting previously unselected package libexpat1-dev:amd64.
[   31.192968]=20
[   31.202426] Preparing to unpack .../libexpat1-dev_2.2.6-2+deb10u1_amd64.=
deb ...
[   31.202427]=20
[   31.212174] Unpacking libexpat1-dev:amd64 (2.2.6-2+deb10u1) ...
[   31.212175]=20
[   31.220597] Selecting previously unselected package libperl-dev.
[   31.220598]=20
[   31.229341] Preparing to unpack .../libperl-dev_5.28.1-6+deb10u1_amd64.d=
eb ...
[   31.229342]=20
[   31.238887] Unpacking libperl-dev (5.28.1-6+deb10u1) ...
[   31.238888]=20
[   31.246819] Selecting previously unselected package libpython2.7:amd64.
[   31.246820]=20
[   31.256182] Preparing to unpack .../libpython2.7_2.7.16-2+deb10u1_amd64.=
deb ...
[   31.256183]=20
[   31.265940] Unpacking libpython2.7:amd64 (2.7.16-2+deb10u1) ...
[   31.265941]=20
[   31.274576] Selecting previously unselected package libpython2.7-dev:amd=
64.
[   31.274577]=20
[   31.284420] Preparing to unpack .../libpython2.7-dev_2.7.16-2+deb10u1_am=
d64.deb ...
[   31.284421]=20
[   31.294675] Unpacking libpython2.7-dev:amd64 (2.7.16-2+deb10u1) ...
[   31.294676]=20
[   31.303667] Selecting previously unselected package libpython2-dev:amd64.
[   31.303668]=20
[   31.313087] Preparing to unpack .../libpython2-dev_2.7.16-1_amd64.deb ...
[   31.313088]=20
[   31.322209] Unpacking libpython2-dev:amd64 (2.7.16-1) ...
[   31.322210]=20
[   31.330254] Selecting previously unselected package libpython-dev:amd64.
[   31.330255]=20
[   31.339667] Preparing to unpack .../libpython-dev_2.7.16-1_amd64.deb ...
[   31.339668]=20
[   31.348684] Unpacking libpython-dev:amd64 (2.7.16-1) ...
[   31.348685]=20
[   31.356372] Selecting previously unselected package patch.
[   31.356373]=20
[   31.364470] Preparing to unpack .../patch_2.7.6-3+deb10u1_amd64.deb ...
[   31.364471]=20
[   31.373298] Unpacking patch (2.7.6-3+deb10u1) ...
[   31.373299]=20
[   31.380562] Selecting previously unselected package python2.7-dev.
[   31.380563]=20
[   31.389532] Preparing to unpack .../python2.7-dev_2.7.16-2+deb10u1_amd64=
=2Edeb ...
[   31.389533]=20
[   31.399303] Unpacking python2.7-dev (2.7.16-2+deb10u1) ...
[   31.399304]=20
[   31.407265] Selecting previously unselected package python2-dev.
[   31.407266]=20
[   31.415854] Preparing to unpack .../python2-dev_2.7.16-1_amd64.deb ...
[   31.415855]=20
[   31.424510] Unpacking python2-dev (2.7.16-1) ...
[   31.424511]=20
[   31.431620] Selecting previously unselected package python-dev.
[   31.431621]=20
[   31.440106] Preparing to unpack .../python-dev_2.7.16-1_amd64.deb ...
[   31.440107]=20
[   31.448701] Unpacking python-dev (2.7.16-1) ...
[   31.448702]=20
[   31.455542] Selecting previously unselected package gawk.
[   31.455543]=20
[   31.463535] Preparing to unpack .../gawk_1%3a4.2.1+dfsg-1_amd64.deb ...
[   31.463536]=20
[   31.472260] Unpacking gawk (1:4.2.1+dfsg-1) ...
[   31.472261]=20
[   31.479084] Setting up ntpdate (1:4.2.8p12+dfsg-4) ...
[   31.479085]=20
[   31.486492] Setting up perl-base (5.28.1-6+deb10u1) ...
[   31.486493]=20
[   31.494206] Setting up perl-modules-5.28 (5.28.1-6+deb10u1) ...
[   31.494207]=20
[   31.502776] Setting up libpython3.7-minimal:amd64 (3.7.3-2+deb10u2) ...
[   31.502777]=20
[   31.511836] Setting up python3.7-minimal (3.7.3-2+deb10u2) ...
[   31.511837]=20
[   31.519946] Setting up python3-minimal (3.7.3-1) ...
[   31.519947]=20
[   31.527126] Setting up libthai-data (0.1.28-2) ...
[   31.527127]=20
[   31.534221] Setting up libdatrie1:amd64 (0.2.12-2) ...
[   31.534222]=20
[   31.541840] Setting up libavahi-common-data:amd64 (0.7-4+b1) ...
[   31.541841]=20
[   31.550092] Setting up libasound2-data (1.1.8-1) ...
[   31.550093]=20
[   31.557325] Setting up libatomic1:amd64 (8.3.0-6) ...
[   31.557326]=20
[   31.564706] Setting up libquadmath0:amd64 (8.3.0-6) ...
[   31.564707]=20
[   31.572185] Setting up libatk1.0-data (2.30.0-2) ...
[   31.572186]=20
[   31.579553] Setting up libglib2.0-data (2.58.3-2+deb10u2) ...
[   31.579554]=20
[   31.587780] Setting up libpython2.7:amd64 (2.7.16-2+deb10u1) ...
[   31.587781]=20
[   31.596000] Setting up patch (2.7.6-3+deb10u1) ...
[   31.596001]=20
[   31.603255] Setting up libperl5.28:amd64 (5.28.1-6+deb10u1) ...
[   31.603256]=20
[   31.611355] Setting up perl (5.28.1-6+deb10u1) ...
[   31.611356]=20
[   31.618300] Setting up libdpkg-perl (1.19.7) ...
[   31.618301]=20
[   31.625297] Setting up libperl-dev (5.28.1-6+deb10u1) ...
[   31.625298]=20
[   31.633260] Setting up libpython2.7-dev:amd64 (2.7.16-2+deb10u1) ...
[   31.633261]=20
[   31.641982] Setting up libpython2-dev:amd64 (2.7.16-1) ...
[   31.641983]=20
[   31.649821] Setting up libpython-dev:amd64 (2.7.16-1) ...
[   31.649822]=20
[   31.657589] Setting up python2.7-dev (2.7.16-2+deb10u1) ...
[   31.657590]=20
[   31.665344] Setting up python2-dev (2.7.16-1) ...
[   31.665345]=20
[   31.672280] Setting up python-dev (2.7.16-1) ...
[   31.672281]=20
[   31.679076] Setting up gawk (1:4.2.1+dfsg-1) ...
[   31.679077]=20
[   31.686305] Setting up libpython3.7-stdlib:amd64 (3.7.3-2+deb10u2) ...
[   31.686306]=20
[   31.695114] Setting up python3.7 (3.7.3-2+deb10u2) ...
[   31.695115]=20
[   31.702668] Setting up libpython3-stdlib:amd64 (3.7.3-1) ...
[   31.702669]=20
[   31.710378] Setting up python3 (3.7.3-1) ...
[   31.710379]=20
[   31.717058] running python rtupdate hooks for python3.7...
[   31.717060]=20
[   31.724926] Setting up gtk-update-icon-cache (3.24.5-1) ...
[   31.724927]=20
[   31.732858] Setting up ca-certificates-java (20190405) ...
[   31.732859]=20
[   31.740533] Adding debian:GeoTrust_Universal_CA.pem
[   31.740534]=20
[   31.747883] Adding debian:Staat_der_Nederlanden_EV_Root_CA.pem
[   31.747884]=20
[   31.755981] Adding debian:thawte_Primary_Root_CA.pem
[   31.755982]=20
[   31.763112] Adding debian:Amazon_Root_CA_2.pem
[   31.763113]=20
[   31.769996] Adding debian:OISTE_WISeKey_Global_Root_GC_CA.pem
[   31.769997]=20
[   31.778201] Adding debian:TWCA_Root_Certification_Authority.pem
[   31.778202]=20
[   31.786595] Adding debian:COMODO_RSA_Certification_Authority.pem
[   31.786596]=20
[   31.794848] Adding debian:SwissSign_Gold_CA_-_G2.pem
[   31.794849]=20
[   31.802441] Adding debian:Entrust.net_Premium_2048_Secure_Server_CA.pem
[   31.802442]=20
[   31.811415] Adding debian:DigiCert_Assured_ID_Root_G3.pem
[   31.811416]=20
[   31.819402] Adding debian:DigiCert_High_Assurance_EV_Root_CA.pem
[   31.819404]=20
[   31.827826] Adding debian:COMODO_Certification_Authority.pem
[   31.827827]=20
[   31.835660] Adding debian:SecureSign_RootCA11.pem
[   31.835661]=20
[   31.843724] Adding debian:VeriSign_Class_3_Public_Primary_Certification_=
Authority_-_G4.pem
[   31.843726]=20
[   31.854598] Adding debian:Security_Communication_RootCA2.pem
[   31.854599]=20
[   31.862565] Adding debian:QuoVadis_Root_CA_3_G3.pem
[   31.862567]=20
[   31.870826] Adding debian:Deutsche_Telekom_Root_CA_2.pem
[   31.870828]=20
[   31.874021] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   31.876932] Adding debian:SecureTrust_CA.pem
[   31.877812] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.889451]=20
[   31.893607] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.906163] Adding debian:AffirmTrust_Commercial.pem
[   31.906787] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   31.918495]=20
[   31.919111] Adding debian:Izenpe.com.pem
[   31.923782] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.935142]=20
[   31.936185] Adding debian:T-TeleSec_GlobalRoot_Class_2.pem
[   31.936632] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.940515]=20
[   31.942227] Adding debian:Verisign_Class_3_Public_Primary_Certification_=
Authority_-_G3.pem
[   31.952251] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   31.953715]=20
[   31.954589] Adding debian:Trustis_FPS_Root_CA.pem
[   31.959292] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.970874]=20
[   31.972471] Adding debian:Hellenic_Academic_and_Research_Institutions_Ro=
otCA_2011.pem
[   31.980556] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   31.992292]=20
[   31.993265] Adding debian:SwissSign_Silver_CA_-_G2.pem
[   31.993787] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   31.998446]=20
[   31.999240] Adding debian:QuoVadis_Root_CA.pem
[   32.010318] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.011658]=20
[   32.013052] Adding debian:TUBITAK_Kamu_SM_SSL_Kok_Sertifikasi_-_Surum_1.=
pem
[   32.019425] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.031142]=20
[   32.032187] Adding debian:thawte_Primary_Root_CA_-_G3.pem
[   32.032630] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.037715]=20
[   32.038497] Adding debian:AC_RAIZ_FNMT-RCM.pem
[   32.049619] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.050928]=20
[   32.055334] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.067978] Adding debian:thawte_Primary_Root_CA_-_G2.pem
[   32.068605] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.075423]=20
[   32.087312] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.089530] Adding debian:Comodo_AAA_Services_root.pem
[   32.094012] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.105727]=20
[   32.107232] Adding debian:Hellenic_Academic_and_Research_Institutions_Ro=
otCA_2015.pem
[   32.111623] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.123334]=20
[   32.124456] Adding debian:Entrust_Root_Certification_Authority.pem
[   32.124953] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.136538]=20
[   32.137356] Adding debian:Cybertrust_Global_Root.pem
[   32.141896] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.153626]=20
[   32.155111] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.167834] Adding debian:Security_Communication_Root_CA.pem
[   32.172053] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.183636]=20
[   32.184381] Adding debian:GlobalSign_Root_CA.pem
[   32.185119] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.192875]=20
[   32.194297] Adding debian:Starfield_Services_Root_Certificate_Authority_=
-_G2.pem
[   32.204624] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.206090]=20
[   32.207110] Adding debian:IdenTrust_Commercial_Root_CA_1.pem
[   32.212355] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.223955]=20
[   32.225250] Adding debian:GeoTrust_Primary_Certification_Authority_-_G3.=
pem
[   32.225439] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.230365]=20
[   32.231200] Adding debian:AffirmTrust_Networking.pem
[   32.242116] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.243588]=20
[   32.244532] Adding debian:T-TeleSec_GlobalRoot_Class_3.pem
[   32.255493] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.260936]=20
[   32.261688] Adding debian:Amazon_Root_CA_4.pem
[   32.272665] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.274139]=20
[   32.274788] Adding debian:Taiwan_GRCA.pem
[   32.278779] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.290439]=20
[   32.291139] Adding debian:Amazon_Root_CA_1.pem
[   32.292053] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.299248]=20
[   32.300475] Adding debian:Entrust_Root_Certification_Authority_-_G2.pem
[   32.310976] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.312447]=20
[   32.313335] Adding debian:Baltimore_CyberTrust_Root.pem
[   32.318075] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.329778]=20
[   32.330518] Adding debian:QuoVadis_Root_CA_2.pem
[   32.331425] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.338158]=20
[   32.339415] Adding debian:Entrust_Root_Certification_Authority_-_EC1.pem
[   32.349890] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.351358]=20
[   32.352630] Adding debian:SSL.com_EV_Root_Certification_Authority_ECC.pem
[   32.356293] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.368003]=20
[   32.368926] Adding debian:Certum_Trusted_Network_CA.pem
[   32.369654] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.374919]=20
[   32.386646] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.388847] Adding debian:SZAFIR_ROOT_CA2.pem
[   32.392535] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.404247]=20
[   32.405120] Adding debian:GlobalSign_Root_CA_-_R6.pem
[   32.405863] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.409700]=20
[   32.410902] Adding debian:SSL.com_Root_Certification_Authority_ECC.pem
[   32.421427] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.422901]=20
[   32.423935] Adding debian:EE_Certification_Centre_Root_CA.pem
[   32.427315] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x00000000-0x00000fff], got write-back
[   32.439027]=20
[   32.439856] Adding debian:AffirmTrust_Premium.pem
[   32.440677] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.447061]=20
[   32.458795] x86/PAT: bmc-watchdog:2557 map pfn expected mapping type unc=
ached-minus for [mem 0x872dd000-0x872ddfff], got write-back
[   32.460944] Adding debian:DST_Root_CA_X3.pem
[   32.670198]=20
[   32.676857] Adding debian:GlobalSign_Root_CA_-_R2.pem
[   32.676858]=20
[   32.684265] Adding debian:Certum_Trusted_Network_CA_2.pem
[   32.684266]=20
[   32.692013] Adding debian:Atos_TrustedRoot_2011.pem
[   32.692014]=20
[   32.699579] Adding debian:Starfield_Root_Certificate_Authority_-_G2.pem
[   32.699580]=20
[   32.708824] Adding debian:Go_Daddy_Root_Certificate_Authority_-_G2.pem
[   32.708826]=20
[   32.717615] Adding debian:TrustCor_RootCert_CA-1.pem
[   32.717617]=20
[   32.725124] Adding debian:OISTE_WISeKey_Global_Root_GB_CA.pem
[   32.725125]=20
[   32.733345] Adding debian:OISTE_WISeKey_Global_Root_GA_CA.pem
[   32.733346]=20
[   32.741329] Adding debian:TrustCor_RootCert_CA-2.pem
[   32.741330]=20
[   32.748231] Adding debian:Certigna.pem
[   32.748232]=20
[   32.754220] Adding debian:TWCA_Global_Root_CA.pem
[   32.754221]=20
[   32.761149] Adding debian:Certinomis_-_Root_CA.pem
[   32.761150]=20
[   32.768118] Adding debian:TrustCor_ECA-1.pem
[   32.768119]=20
[   32.774851] Adding debian:D-TRUST_Root_Class_3_CA_2_2009.pem
[   32.774853]=20
[   32.782955] Adding debian:IdenTrust_Public_Sector_Root_CA_1.pem
[   32.782956]=20
[   32.791292] Adding debian:Chambers_of_Commerce_Root_-_2008.pem
[   32.791294]=20
[   32.799492] Adding debian:AffirmTrust_Premium_ECC.pem
[   32.799493]=20
[   32.806764] Adding debian:QuoVadis_Root_CA_2_G3.pem
[   32.806765]=20
[   32.813973] Adding debian:DigiCert_Global_Root_CA.pem
[   32.813974]=20
[   32.821222] Adding debian:QuoVadis_Root_CA_3.pem
[   32.821223]=20
[   32.828277] Adding debian:Global_Chambersign_Root_-_2008.pem
[   32.828278]=20
[   32.836277] Adding debian:Sonera_Class_2_Root_CA.pem
[   32.836278]=20
[   32.843582] Adding debian:Buypass_Class_2_Root_CA.pem
[   32.843583]=20
[   32.851160] Adding debian:ePKI_Root_Certification_Authority.pem
[   32.851161]=20
[   32.859254] Adding debian:GeoTrust_Global_CA.pem
[   32.859255]=20
[   32.866244] Adding debian:Buypass_Class_3_Root_CA.pem
[   32.866245]=20
[   32.873789] Adding debian:GlobalSign_ECC_Root_CA_-_R4.pem
[   32.873791]=20
[   32.881435] Adding debian:CA_Disig_Root_R2.pem
[   32.881437]=20
[   32.888238] Adding debian:Starfield_Class_2_CA.pem
[   32.888240]=20
[   32.895425] Adding debian:XRamp_Global_CA_Root.pem
[   32.895427]=20
[   32.902414] Adding debian:certSIGN_ROOT_CA.pem
[   32.902416]=20
[   32.909701] Adding debian:VeriSign_Universal_Root_Certification_Authorit=
y.pem
[   32.909703]=20
[   32.919220] Adding debian:GlobalSign_ECC_Root_CA_-_R5.pem
[   32.919222]=20
[   32.926818] Adding debian:Secure_Global_CA.pem
[   32.926820]=20
[   32.933483] Adding debian:Go_Daddy_Class_2_CA.pem
[   32.933485]=20
[   32.941047] Adding debian:D-TRUST_Root_Class_3_CA_2_EV_2009.pem
[   32.941049]=20
[   32.949478] Adding debian:GDCA_TrustAUTH_R5_ROOT.pem
[   32.949480]=20
[   32.957199] Adding debian:Network_Solutions_Certificate_Authority.pem
[   32.957201]=20
[   32.965945] Adding debian:DigiCert_Global_Root_G3.pem
[   32.965947]=20
[   32.973621] Adding debian:USERTrust_ECC_Certification_Authority.pem
[   32.973623]=20
[   32.982073] Adding debian:Amazon_Root_CA_3.pem
[   32.982074]=20
[   32.988980] Adding debian:DigiCert_Trusted_Root_G4.pem
[   32.988981]=20
[   32.996683] Adding debian:COMODO_ECC_Certification_Authority.pem
[   32.996684]=20
[   33.005142] Adding debian:AddTrust_External_Root.pem
[   33.005144]=20
[   33.012613] Adding debian:DigiCert_Global_Root_G2.pem
[   33.012615]=20
[   33.019833] Adding debian:ISRG_Root_X1.pem
[   33.019834]=20
[   33.026960] Adding debian:GeoTrust_Primary_Certification_Authority_-_G2.=
pem
[   33.026962]=20
[   33.036062] Adding debian:ACCVRAIZ1.pem
[   33.036064]=20
[   33.042436] Adding debian:Microsec_e-Szigno_Root_CA_2009.pem
[   33.042438]=20
[   33.050577] Adding debian:Actalis_Authentication_Root_CA.pem
[   33.050578]=20
[   33.058610] Adding debian:DigiCert_Assured_ID_Root_CA.pem
[   33.058611]=20
[   33.066333] Adding debian:TeliaSonera_Root_CA_v1.pem
[   33.066335]=20
[   33.372724] error: dpkg -i /opt/deb/python3_3.7.3-1_amd64.deb failed.
[   33.372727]=20
[   33.495996]=20
[   33.505341] Adding debian:DigiCert_Assured_ID_Root_G2.pem
[   33.505343]=20
[   33.513296] Adding debian:E-Tugra_Certification_Authority.pem
[   33.513298]=20
[   33.522293] Adding debian:VeriSign_Class_3_Public_Primary_Certification_=
Authority_-_G5.pem
[   33.522295]=20
[   33.533231] Adding debian:USERTrust_RSA_Certification_Authority.pem
[   33.533233]=20
[   33.542040] Adding debian:Staat_der_Nederlanden_Root_CA_-_G2.pem
[   33.542041]=20
[   33.550448] Adding debian:Certplus_Class_2_Primary_CA.pem
[   33.550450]=20
[   33.559161] Adding debian:Hellenic_Academic_and_Research_Institutions_EC=
C_RootCA_2015.pem
[   33.559163]=20
[   33.570231] Adding debian:SSL.com_EV_Root_Certification_Authority_RSA_R2=
=2Epem
[   33.570232]=20
[   33.579676] Adding debian:Hongkong_Post_Root_CA_1.pem
[   33.579677]=20
[   33.586841] Adding debian:CFCA_EV_ROOT.pem
[   33.586842]=20
[   33.594042] Adding debian:Autoridad_de_Certificacion_Firmaprofesional_CI=
F_A62634068.pem
[   33.594044]=20
[   33.604336] Adding debian:QuoVadis_Root_CA_1_G3.pem
[   33.604337]=20
[   33.611562] Adding debian:LuxTrust_Global_Root_2.pem
[   33.611564]=20
[   33.619204] Adding debian:SSL.com_Root_Certification_Authority_RSA.pem
[   33.619205]=20
[   33.628033] Adding debian:GeoTrust_Universal_CA_2.pem
[   33.628035]=20
[   33.635646] Adding debian:Staat_der_Nederlanden_Root_CA_-_G3.pem
[   33.635648]=20
[   33.643981] Adding debian:GlobalSign_Root_CA_-_R3.pem
[   33.643983]=20
[   33.651731] Adding debian:GeoTrust_Primary_Certification_Authority.pem
[   33.651733]=20
[   33.660239] Adding debian:EC-ACC.pem
[   33.660241]=20
[   33.665451] done.
[   33.665452]=20
[   33.669776] Setting up libgcc-8-dev:amd64 (8.3.0-6) ...
[   33.669778]=20
[   33.677242] Setting up lib32gcc1 (1:8.3.0-6) ...
[   33.677244]=20
[   33.684002] Setting up gcc-8 (8.3.0-6) ...
[   33.684003]=20
[   33.690201] Setting up gcc (4:8.3.0-1) ...
[   33.690202]=20
[   33.696467] Setting up g++-8 (8.3.0-6) ...
[   33.696469]=20
[   33.702665] Setting up g++ (4:8.3.0-1) ...
[   33.702667]=20
[   33.709991] update-alternatives: using /usr/bin/g++ to provide /usr/bin/=
c++ (c++) in auto mode
[   33.709993]=20
[   33.720930] Setting up libatk1.0-0:amd64 (2.30.0-2) ...
[   33.720932]=20
[   33.728580] Setting up gir1.2-atk-1.0:amd64 (2.30.0-2) ...
[   33.728582]=20
[   33.736368] Setting up python3-lib2to3 (3.7.3-1) ...
[   33.736370]=20
[   33.743741] Setting up python3-distutils (3.7.3-1) ...
[   33.743742]=20
[   33.751314] Setting up libatk1.0-dev:amd64 (2.30.0-2) ...
[   33.751316]=20
[   33.759317] Setting up libexpat1-dev:amd64 (2.2.6-2+deb10u1) ...
[   33.759319]=20
[   33.767727] Processing triggers for libc-bin (2.28-10) ...
[   33.767728]=20
[   33.775608] Processing triggers for mime-support (3.62) ...
[   33.775609]=20
[   33.783755] Processing triggers for ca-certificates (20190110) ...
[   33.783757]=20
[   33.792259] Updating certificates in /etc/ssl/certs...
[   33.792261]=20
[   33.799368] 0 added, 0 removed; done.
[   33.799369]=20
[   33.805602] Running hooks in /etc/ca-certificates/update.d...
[   33.805604]=20
[   33.812805]=20
[   33.812806]=20
[   33.815888] done.
[   33.815890]=20
[   33.819399] done.
[   33.819401]=20
[   33.825045] dpkg: regarding .../python3-minimal_3.7.3-1_amd64.deb contai=
ning python3-minimal, pre-dependency problem:
[   33.825047]=20
[   33.838398]  python3-minimal pre-depends on python3.7-minimal (>=3D 3.7.=
3-1~)
[   33.838400]=20
[   33.848200]   python3.7-minimal is unpacked, but has never been configur=
ed.
[   33.848202]=20
[   33.856635]=20
[   33.856636]=20
[   33.860696] dpkg: warning: ignoring pre-dependency problem!
[   33.860698]=20
[   33.869895] dpkg: regarding .../deb/python3_3.7.3-1_amd64.deb containing=
 python3, pre-dependency problem:
[   33.869897]=20
[   33.882117]  python3 pre-depends on python3-minimal (=3D 3.7.3-1)
[   33.882119]=20
[   33.890879]   python3-minimal is unpacked, but has never been configured.
[   33.890880]=20
[   33.899132]=20
[   33.899133]=20
[   33.903084] dpkg: warning: ignoring pre-dependency problem!
[   33.903086]=20
[   33.912071] dpkg: regarding .../gawk_1%3a4.2.1+dfsg-1_amd64.deb containi=
ng gawk, pre-dependency problem:
[   33.912073]=20
[   33.923810]  gawk pre-depends on libmpfr6 (>=3D 3.1.3)
[   33.923812]=20
[   33.930846]   libmpfr6 is not installed.
[   33.930848]=20
[   33.936248]=20
[   33.936249]=20
[   33.940284] dpkg: warning: ignoring pre-dependency problem!
[   33.940286]=20
[   33.949273] dpkg: regarding .../gawk_1%3a4.2.1+dfsg-1_amd64.deb containi=
ng gawk, pre-dependency problem:
[   33.949274]=20
[   33.961045]  gawk pre-depends on libsigsegv2 (>=3D 2.9)
[   33.961046]=20
[   33.968270]   libsigsegv2 is not installed.
[   33.968271]=20
[   33.973953]=20
[   33.973954]=20
[   33.978007] dpkg: warning: ignoring pre-dependency problem!
[   33.978009]=20
[   33.986728] dpkg: libperl-dev: dependency problems, but configuring anyw=
ay as you requested:
[   33.986729]=20
[   33.997811]  libperl-dev depends on libc6-dev | libc-dev; however:
[   33.997813]=20
[   34.006335]   Package libc6-dev is not installed.
[   34.006336]=20
[   34.013327]   Package libc-dev is not installed.
[   34.013329]=20
[   34.019417]=20
[   34.019418]=20
[   34.024455] dpkg: libpython2.7-dev:amd64: dependency problems, but confi=
guring anyway as you requested:
[   34.024456]=20
[   34.036296]  libpython2.7-dev:amd64 depends on libexpat1-dev.
[   34.036297]=20
[   34.043499]=20
[   34.043500]=20
[   34.048369] dpkg: python2.7-dev: dependency problems, but configuring an=
yway as you requested:
[   34.048371]=20
[   34.059347]  python2.7-dev depends on libexpat1-dev.
[   34.059349]=20
[   34.065776]=20
[   34.065777]=20
[   34.070407] dpkg: gawk: dependency problems, but configuring anyway as y=
ou requested:
[   34.070409]=20
[   34.080650]  gawk depends on libmpfr6 (>=3D 3.1.3); however:
[   34.080651]=20
[   34.088466]   Package libmpfr6 is not installed.
[   34.088467]=20
[   34.095525]  gawk depends on libsigsegv2 (>=3D 2.9); however:
[   34.095527]=20
[   34.103344]   Package libsigsegv2 is not installed.
[   34.103345]=20
[   34.109682]=20
[   34.109683]=20
[   34.114718] dpkg: libpython3.7-stdlib:amd64: dependency problems, but co=
nfiguring anyway as you requested:
[   34.114721]=20
[   34.127128]  libpython3.7-stdlib:amd64 depends on libmpdec2; however:
[   34.127129]=20
[   34.135898]   Package libmpdec2 is not installed.
[   34.135899]=20
[   34.142114]=20
[   34.142115]=20
[   34.146366] dpkg-query: package 'libglib2.0-dev-bin' is not installed
[   34.146368]=20
[   34.155954] Use dpkg --contents (=3D dpkg-deb --contents) to list archiv=
e files contents.
[   34.155956]=20
[   34.166121] Traceback (most recent call last):
[   34.166122]=20
[   34.173036]   File "/usr/bin/py3clean", line 210, in <module>
[   34.173038]=20
[   34.180439]     main()
[   34.180440]=20
[   34.185202]   File "/usr/bin/py3clean", line 196, in main
[   34.185203]=20
[   34.193220]     pfiles =3D set(dpf.from_package(options.package))
[   34.193222]=20
[   34.202136]   File "/usr/share/python3/debpython/files.py", line 53, in =
=66rom_package
[   34.202138]=20
[   34.212672]     raise Exception("cannot get content of %s" % package_nam=
e)
[   34.212674]=20
[   34.222096] Exception: cannot get content of libglib2.0-dev-bin
[   34.222098]=20
[   34.230600] error running python rtupdate hook libglib2.0-dev-bin
[   34.230601]=20
[   34.239197] dpkg: error processing package python3 (--install):
[   34.239198]=20
[   34.248611]  installed python3 package post-installation script subproce=
ss returned error exit status 4
[   34.248613]=20
[   34.261590] dpkg: gtk-update-icon-cache: dependency problems, but config=
uring anyway as you requested:
[   34.261592]=20
[   34.274036]  gtk-update-icon-cache depends on libgdk-pixbuf2.0-0 (>=3D 2=
=2E30.0); however:
[   34.274038]=20
[   34.284453]   Package libgdk-pixbuf2.0-0 is not installed.
[   34.284456]=20
[   34.292890]  gtk-update-icon-cache depends on libglib2.0-0 (>=3D 2.55.2)=
; however:
[   34.292892]=20
[   34.302575]   Package libglib2.0-0 is not installed.
[   34.302577]=20
[   34.309001]=20
[   34.309002]=20
[   34.314009] dpkg: ca-certificates-java: dependency problems, but configu=
ring anyway as you requested:
[   34.314011]=20
[   34.326503]  ca-certificates-java depends on default-jre-headless | java=
8-runtime-headless; however:
[   34.326505]=20
[   34.338099]   Package default-jre-headless is not installed.
[   34.338101]=20
[   34.346251]   Package java8-runtime-headless is not installed.
[   34.346253]=20
[   34.354951]  ca-certificates-java depends on libnss3 (>=3D 3.12.10-2~); =
however:
[   34.354953]=20
[   34.364314]   Package libnss3 is not installed.
[   34.364316]=20
[   34.370347]=20
[   34.370348]=20
[   34.375304] head: cannot open '/etc/ssl/certs/java/cacerts' for reading:=
 No such file or directory
[   34.375306]=20
[   34.386814] dpkg-query: package 'libnss3' is not installed
[   34.386816]=20
[   34.395302] Use dpkg --contents (=3D dpkg-deb --contents) to list archiv=
e files contents.
[   34.395304]=20
[   34.406575] dpkg: libgcc-8-dev:amd64: dependency problems, but configuri=
ng anyway as you requested:
[   34.406576]=20
[   34.418327]  libgcc-8-dev:amd64 depends on libgomp1 (>=3D 8.3.0-6); howe=
ver:
[   34.418329]=20
[   34.427372]   Package libgomp1 is not installed.
[   34.427374]=20
[   34.434900]  libgcc-8-dev:amd64 depends on libitm1 (>=3D 8.3.0-6); howev=
er:
[   34.434901]=20
[   34.443897]   Package libitm1 is not installed.
[   34.443899]=20
[   34.451145]  libgcc-8-dev:amd64 depends on libasan5 (>=3D 8.3.0-6); howe=
ver:
[   34.451146]=20
[   34.460230]   Package libasan5 is not installed.
[   34.460232]=20
[   34.467611]  libgcc-8-dev:amd64 depends on liblsan0 (>=3D 8.3.0-6); howe=
ver:
[   34.467612]=20
[   34.476670]   Package liblsan0 is not installed.
[   34.476672]=20
[   34.484043]  libgcc-8-dev:amd64 depends on libtsan0 (>=3D 8.3.0-6); howe=
ver:
[   34.484045]=20
[   34.493124]   Package libtsan0 is not installed.
[   34.493126]=20
[   34.500520]  libgcc-8-dev:amd64 depends on libubsan1 (>=3D 8.3.0-6); how=
ever:
[   34.500522]=20
[   34.509687]   Package libubsan1 is not installed.
[   34.509688]=20
[   34.517198]  libgcc-8-dev:amd64 depends on libmpx2 (>=3D 8.3.0-6); howev=
er:
[   34.517199]=20
[   34.526193]   Package libmpx2 is not installed.
[   34.526194]=20
[   34.532193]=20
[   34.532195]=20
[   34.536846] dpkg: lib32gcc1: dependency problems, but configuring anyway=
 as you requested:
[   34.536848]=20
[   34.547742]  lib32gcc1 depends on libc6-i386 (>=3D 2.2.4); however:
[   34.547743]=20
[   34.556129]   Package libc6-i386 is not installed.
[   34.556131]=20
[   34.562411]=20
[   34.562412]=20
[   34.567070] dpkg: gcc-8: dependency problems, but configuring anyway as =
you requested:
[   34.567072]=20
[   34.577356]  gcc-8 depends on cpp-8 (=3D 8.3.0-6); however:
[   34.577358]=20
[   34.584915]   Package cpp-8 is not installed.
[   34.584917]=20
[   34.591729]  gcc-8 depends on libcc1-0 (>=3D 8.3.0-6); however:
[   34.591730]=20
[   34.599783]   Package libcc1-0 is not installed.
[   34.599784]=20
[   34.606868]  gcc-8 depends on binutils (>=3D 2.31.1); however:
[   34.606870]=20
[   34.614784]   Package binutils is not installed.
[   34.614786]=20
[   34.621856]  gcc-8 depends on libisl19 (>=3D 0.15); however:
[   34.621858]=20
[   34.629566]   Package libisl19 is not installed.
[   34.629569]=20
[   34.636445]  gcc-8 depends on libmpc3; however:
[   34.636448]=20
[   34.643175]   Package libmpc3 is not installed.
[   34.643176]=20
[   34.650144]  gcc-8 depends on libmpfr6 (>=3D 3.1.3); however:
[   34.650145]=20
[   34.657904]   Package libmpfr6 is not installed.
[   34.657906]=20
[   34.663987]=20
[   34.663988]=20
[   34.668519] dpkg: gcc: dependency problems, but configuring anyway as yo=
u requested:
[   34.668521]=20
[   34.678700]  gcc depends on cpp (=3D 4:8.3.0-1); however:
[   34.678701]=20
[   34.686051]   Package cpp is not installed.
[   34.686053]=20
[   34.691724]=20
[   34.691726]=20
[   34.696440] dpkg: g++-8: dependency problems, but configuring anyway as =
you requested:
[   34.696442]=20
[   34.707082]  g++-8 depends on libstdc++-8-dev (=3D 8.3.0-6); however:
[   34.707084]=20
[   34.715696]   Package libstdc++-8-dev is not installed.
[   34.715697]=20
[   34.723362]  g++-8 depends on libisl19 (>=3D 0.15); however:
[   34.723363]=20
[   34.731019]   Package libisl19 is not installed.
[   34.731021]=20
[   34.737788]  g++-8 depends on libmpc3; however:
[   34.737789]=20
[   34.744507]   Package libmpc3 is not installed.
[   34.744508]=20
[   34.751445]  g++-8 depends on libmpfr6 (>=3D 3.1.3); however:
[   34.751446]=20
[   34.759239]   Package libmpfr6 is not installed.
[   34.759240]=20
[   34.765339]=20
[   34.765341]=20
[   34.769933] dpkg: g++: dependency problems, but configuring anyway as yo=
u requested:
[   34.769935]=20
[   34.780024]  g++ depends on cpp (=3D 4:8.3.0-1); however:
[   34.780026]=20
[   34.787443]   Package cpp is not installed.
[   34.787445]=20
[   34.793106]=20
[   34.793107]=20
[   34.797948] dpkg: libatk1.0-0:amd64: dependency problems, but configurin=
g anyway as you requested:
[   34.797950]=20
[   34.809757]  libatk1.0-0:amd64 depends on libglib2.0-0 (>=3D 2.55.2); ho=
wever:
[   34.809759]=20
[   34.819068]   Package libglib2.0-0 is not installed.
[   34.819069]=20
[   34.825485]=20
[   34.825486]=20
[   34.830296] dpkg: gir1.2-atk-1.0:amd64: dependency problems, but configu=
ring anyway as you requested:
[   34.830297]=20
[   34.842364]  gir1.2-atk-1.0:amd64 depends on gir1.2-glib-2.0 (>=3D 1.32.=
0); however:
[   34.842365]=20
[   34.852277]   Package gir1.2-glib-2.0 is not installed.
[   34.852278]=20
[   34.858974]=20
[   34.858975]=20
[   34.863718] dpkg: python3-lib2to3: dependency problems, but configuring =
anyway as you requested:
[   34.863719]=20
[   34.875144]  python3-lib2to3 depends on python3 (>=3D 3.7.1-1~); however:
[   34.875146]=20
[   34.884033]   Package python3 is not configured yet.
[   34.884035]=20
[   34.891610]  python3-lib2to3 depends on python3 (<< 3.8); however:
[   34.891611]=20
[   34.900062]   Package python3 is not configured yet.
[   34.900063]=20
[   34.906493]=20
[   34.906494]=20
[   34.911297] dpkg: python3-distutils: dependency problems, but configurin=
g anyway as you requested:
[   34.911299]=20
[   34.922933]  python3-distutils depends on python3 (>=3D 3.7.1-1~); howev=
er:
[   34.922934]=20
[   34.931988]   Package python3 is not configured yet.
[   34.931990]=20
[   34.939643]  python3-distutils depends on python3 (<< 3.8); however:
[   34.939645]=20
[   34.948275]   Package python3 is not configured yet.
[   34.948277]=20
[   34.954701]=20
[   34.954702]=20
[   34.959515] dpkg: libatk1.0-dev:amd64: dependency problems, but configur=
ing anyway as you requested:
[   34.959517]=20
[   34.971168]  libatk1.0-dev:amd64 depends on pkg-config; however:
[   34.971170]=20
[   34.979488]   Package pkg-config is not installed.
[   34.979490]=20
[   34.987323]  libatk1.0-dev:amd64 depends on libglib2.0-dev (>=3D 2.31.2)=
; however:
[   34.987324]=20
[   34.997116]   Package libglib2.0-dev is not installed.
[   34.997118]=20
[   35.003719]=20
[   35.003720]=20
[   35.008673] dpkg: libexpat1-dev:amd64: dependency problems, but configur=
ing anyway as you requested:
[   35.008675]=20
[   35.020610]  libexpat1-dev:amd64 depends on libc6-dev | libc-dev; howeve=
r:
[   35.020612]=20
[   35.029760]   Package libc6-dev is not installed.
[   35.029762]=20
[   35.036867]   Package libc-dev is not installed.
[   35.036869]=20
[   35.043051]=20
[   35.043052]=20
[   35.047192] dpkg-query: package 'libnss3' is not installed
[   35.047194]=20
[   35.055815] Use dpkg --contents (=3D dpkg-deb --contents) to list archiv=
e files contents.
[   35.055817]=20
[   35.066255] dpkg-query: package 'libnss3' is not installed
[   35.066257]=20
[   35.074967] Use dpkg --contents (=3D dpkg-deb --contents) to list archiv=
e files contents.
[   35.074970]=20
[   35.085345] Errors were encountered while processing:
[   35.085347]=20
[   35.092043]  python3
[   35.092044]=20
[   35.096305] handle /opt/deb/keep-deb.hw...
[   35.096306]=20
[   35.104223] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/ntpdate_1%3a4.2.8p12+dfsg-4_amd64.deb
[   35.104226]=20
[   35.118159] (Reading database ... 18840 files and directories currently =
installed.)
[   35.118161]=20
[   35.128652] Preparing to unpack .../ntpdate_1%3a4.2.8p12+dfsg-4_amd64.de=
b ...
[   35.128655]=20
[   35.138660] Unpacking ntpdate (1:4.2.8p12+dfsg-4) over (1:4.2.8p12+dfsg-=
4) ...
[   35.138661]=20
[   35.148421] Setting up ntpdate (1:4.2.8p12+dfsg-4) ...
[   35.148423]=20
[   35.156046] handle /opt/deb/keep-deb.perf-sanity-tests...
[   35.156048]=20
[   35.165472] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/libperl5.28_5.28.1-6+deb10u1_amd64.deb
[   35.165474]=20
[   35.179586] (Reading database ... 18840 files and directories currently =
installed.)
[   35.179588]=20
[   35.190129] Preparing to unpack .../libperl5.28_5.28.1-6+deb10u1_amd64.d=
eb ...
[   35.190131]=20
[   35.200602] Unpacking libperl5.28:amd64 (5.28.1-6+deb10u1) over (5.28.1-=
6+deb10u1) ...
[   35.200604]=20
[   35.211217] Setting up libperl5.28:amd64 (5.28.1-6+deb10u1) ...
[   35.211219]=20
[   35.219653] Processing triggers for libc-bin (2.28-10) ...
[   35.219654]=20
[   35.229193] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/perl_5.28.1-6+deb10u1_amd64.deb
[   35.229196]=20
[   35.242803] (Reading database ... 18840 files and directories currently =
installed.)
[   35.242805]=20
[   35.253115] Preparing to unpack .../perl_5.28.1-6+deb10u1_amd64.deb ...
[   35.253117]=20
[   35.262468] Unpacking perl (5.28.1-6+deb10u1) over (5.28.1-6+deb10u1) ...
[   35.262470]=20
[   35.271527] Setting up perl (5.28.1-6+deb10u1) ...
[   35.271528]=20
[   35.280330] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/perl-base_5.28.1-6+deb10u1_amd64.deb
[   35.280331]=20
[   35.294253] (Reading database ... 18840 files and directories currently =
installed.)
[   35.294255]=20
[   35.304785] Preparing to unpack .../perl-base_5.28.1-6+deb10u1_amd64.deb=
 ...
[   35.304787]=20
[   35.314730] Unpacking perl-base (5.28.1-6+deb10u1) over (5.28.1-6+deb10u=
1) ...
[   35.314732]=20
[   35.324361] Setting up perl-base (5.28.1-6+deb10u1) ...
[   35.324363]=20
[   35.333532] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/perl-modules-5.28_5.28.1-6+deb10u1_all.deb
[   35.333534]=20
[   35.347929] (Reading database ... 18840 files and directories currently =
installed.)
[   35.347931]=20
[   35.358457] Preparing to unpack .../perl-modules-5.28_5.28.1-6+deb10u1_a=
ll.deb ...
[   35.358459]=20
[   35.369042] Unpacking perl-modules-5.28 (5.28.1-6+deb10u1) over (5.28.1-=
6+deb10u1) ...
[   35.369044]=20
[   35.379457] Setting up perl-modules-5.28 (5.28.1-6+deb10u1) ...
[   35.379459]=20
[   35.389377] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/libpython3.7-minimal_3.7.3-2+deb10u2_amd64.deb
[   35.389380]=20
[   35.404087] (Reading database ... 18840 files and directories currently =
installed.)
[   35.404089]=20
[   35.414865] Preparing to unpack .../libpython3.7-minimal_3.7.3-2+deb10u2=
_amd64.deb ...
[   35.414867]=20
[   35.425966] Unpacking libpython3.7-minimal:amd64 (3.7.3-2+deb10u2) over =
(3.7.3-2+deb10u2) ...
[   35.425968]=20
[   35.437193] Setting up libpython3.7-minimal:amd64 (3.7.3-2+deb10u2) ...
[   35.437194]=20
[   35.447924] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/python3.7-minimal_3.7.3-2+deb10u2_amd64.deb
[   35.447926]=20
[   35.462659] (Reading database ... 18840 files and directories currently =
installed.)
[   35.462661]=20
[   35.473330] Preparing to unpack .../python3.7-minimal_3.7.3-2+deb10u2_am=
d64.deb ...
[   35.473332]=20
[   35.483955] Unpacking python3.7-minimal (3.7.3-2+deb10u2) over (3.7.3-2+=
deb10u2) ...
[   35.483957]=20
[   35.494189] Setting up python3.7-minimal (3.7.3-2+deb10u2) ...
[   35.494190]=20
[   35.503755] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/python3-minimal_3.7.3-1_amd64.deb
[   35.503757]=20
[   35.517447] (Reading database ... 18840 files and directories currently =
installed.)
[   35.517450]=20
[   35.527936] Preparing to unpack .../python3-minimal_3.7.3-1_amd64.deb ...
[   35.527938]=20
[   35.537355] Unpacking python3-minimal (3.7.3-1) over (3.7.3-1) ...
[   35.537357]=20
[   35.546027] Setting up python3-minimal (3.7.3-1) ...
[   35.546029]=20
[   35.554996] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/libpython3.7-stdlib_3.7.3-2+deb10u2_amd64.deb
[   35.554998]=20
[   35.569760] (Reading database ... 18840 files and directories currently =
installed.)
[   35.569762]=20
[   35.580481] Preparing to unpack .../libpython3.7-stdlib_3.7.3-2+deb10u2_=
amd64.deb ...
[   35.580483]=20
[   35.591550] Unpacking libpython3.7-stdlib:amd64 (3.7.3-2+deb10u2) over (=
3.7.3-2+deb10u2) ...
[   35.591552]=20
[   35.602680] Setting up libpython3.7-stdlib:amd64 (3.7.3-2+deb10u2) ...
[   35.602682]=20
[   35.613062] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/python3.7_3.7.3-2+deb10u2_amd64.deb
[   35.613064]=20
[   35.626958] (Reading database ... 18840 files and directories currently =
installed.)
[   35.626960]=20
[   35.637402] Preparing to unpack .../python3.7_3.7.3-2+deb10u2_amd64.deb =
=2E..
[   35.637404]=20
[   35.647117] Unpacking python3.7 (3.7.3-2+deb10u2) over (3.7.3-2+deb10u2)=
 ...
[   35.647119]=20
[   35.656452] Setting up python3.7 (3.7.3-2+deb10u2) ...
[   35.656453]=20
[   35.664035] Processing triggers for mime-support (3.62) ...
[   35.664036]=20
[   35.673406] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/libpython3-stdlib_3.7.3-1_amd64.deb
[   35.673408]=20
[   35.687232] (Reading database ... 18840 files and directories currently =
installed.)
[   35.687234]=20
[   35.697640] Preparing to unpack .../libpython3-stdlib_3.7.3-1_amd64.deb =
=2E..
[   35.697641]=20
[   35.707450] Unpacking libpython3-stdlib:amd64 (3.7.3-1) over (3.7.3-1) .=
=2E.
[   35.707451]=20
[   35.716892] Setting up libpython3-stdlib:amd64 (3.7.3-1) ...
[   35.716894]=20
[   35.726093] install debs round two: dpkg -i --force-confdef --force-depe=
nds /opt/deb/python3_3.7.3-1_amd64.deb
[   35.726095]=20
[   35.739198] (Reading database ... 18840 files and directories currently =
installed.)
[   35.739200]=20
[   35.749503] Preparing to unpack .../deb/python3_3.7.3-1_amd64.deb ...
[   35.749505]=20
[   35.758566] running python pre-rtupdate hooks for python3.7...
[   35.758567]=20
[   35.766929] Unpacking python3 (3.7.3-1) over (3.7.3-1) ...
[   35.766930]=20
[   35.774508] Setting up python3 (3.7.3-1) ...
[   35.774510]=20
[   35.781219] running python rtupdate hooks for python3.7...
[   35.781220]=20
[   35.789345] dpkg-query: package 'libglib2.0-dev-bin' is not installed
[   35.789347]=20
[   35.798830] Use dpkg --contents (=3D dpkg-deb --contents) to list archiv=
e files contents.
[   35.798833]=20
[   35.809051] Traceback (most recent call last):
[   35.809053]=20
[   35.815978]   File "/usr/bin/py3clean", line 210, in <module>
[   35.815979]=20
[   35.823410]     main()
[   35.823411]=20
[   35.828273]   File "/usr/bin/py3clean", line 196, in main
[   35.828274]=20
[   35.836222]     pfiles =3D set(dpf.from_package(options.package))
[   35.836224]=20
[   35.845225]   File "/usr/share/python3/debpython/files.py", line 53, in =
=66rom_package
[   35.845226]=20
[   35.855733]     raise Exception("cannot get content of %s" % package_nam=
e)
[   35.855734]=20
[   35.865151] Exception: cannot get content of libglib2.0-dev-bin
[   35.865153]=20
[   35.873784] error running python rtupdate hook libglib2.0-dev-bin
[   35.873786]=20
[   35.882454] dpkg: error processing package python3 (--install):
[   35.882456]=20
[   35.891881]  installed python3 package post-installation script subproce=
ss returned error exit status 4
[   35.891883]=20
[   35.903510] Errors were encountered while processing:
[   35.903512]=20
[   35.910195]  python3
[   35.910197]=20
[   35.914411] /lkp/lkp/src/bin/run-lkp
[   35.914413]=20
[   36.179370] RESULT_ROOT=3D/result/perf-sanity-tests/gcc-ucode=3D0xe2/lkp=
-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea=
9a80b0ee4b4445ea59c806787813/5
[   36.179372]=20
[   36.435520] Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_d=
rm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
[   36.435522]=20
[   36.452245] Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.=
S' differs from latest version at 'arch/x86/lib/memcpy_64.S'
[   36.452247]=20
[   36.468457] Warning: Kernel ABI header at 'tools/arch/x86/lib/memset_64.=
S' differs from latest version at 'arch/x86/lib/memset_64.S'
[   36.468460]=20
[   36.519676] job=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-=
ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59=
c806787813-20201226-25066-sfkgan-4.yaml
[   36.519679]=20
[   40.350636]   PERF_VERSION =3D 5.10.0-rc3
[   40.350639]=20
[   40.360168] result_service: raw_upload, RESULT_MNT: /internal-lkp-server=
/result, RESULT_ROOT: /internal-lkp-server/result/perf-sanity-tests/gcc-uco=
de=3D0xe2/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9=
/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/5, TMP_RESULT_ROOT: /tmp/lkp/resu=
lt
[   40.360171]=20
[   40.392382] run-job /lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gc=
c-ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea=
59c806787813-20201226-25066-sfkgan-4.yaml
[   40.392385]=20
[   41.611992] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=3D=
0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c8067878=
13-20201226-25066-sfkgan-4.yaml&job_state=3Drunning -O /dev/null
[   41.611996]=20
[   41.644528] target ucode: 0xe2
[   41.644530]=20
[   41.649924] current_version: e2, target_version: e2
[   41.649926]=20
[   41.660932] 2020-12-25 16:24:25 make ARCH=3D EXTRA_CFLAGS=3D-fno-omit-fr=
ame-pointer -fsanitize=3Dundefined -fsanitize=3Daddress -C /usr/src/perf_se=
lftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf
[   41.660934]=20
[   41.683892] make: Entering directory '/usr/src/perf_selftests-x86_64-rhe=
l-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf'
[   41.683894]=20
[   41.698151]=20
[   41.705851]   HOSTCC   fixdep.o
[   41.705852]=20
[   41.710930]   HOSTLD   fixdep-in.o
[   41.710932]=20
[   41.716176]   LINK     fixdep
[   41.716178]=20
[   41.722095] diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i=
915_drm.h
[   41.722097]=20
[   41.732334] diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_6=
4.S
[   41.732336]=20
[   41.742050] diff -u tools/arch/x86/lib/memset_64.S arch/x86/lib/memset_6=
4.S
[   41.742051]=20
[   41.750609]=20
[   41.750611]=20
[   41.754328] Auto-detecting system features:
[   41.754329]=20
[   41.761182]=20
[   41.769690]=20
[   41.778208]=20
[   41.786893]=20
[   41.795429]=20
[   41.803979]=20
[   41.812619]=20
[   41.821159]=20
[   41.829636]=20
[   41.838123]=20
[   41.846659]=20
[   41.855116]=20
[   41.863563]=20
[   41.872017]=20
[   41.880470]=20
[   41.888932]=20
[   41.897438]=20
[   41.905966]=20
[   41.914454]=20
[   41.922950]=20
[   41.931442]=20
[   41.938855]=20
[   41.938856]=20
[   41.942405]   CC       fd/array.o
[   41.942406]=20
[   41.947824]   CC       exec-cmd.o
[   41.947826]=20
[   41.953263]   CC       event-parse.o
[   41.953265]=20
[   41.958811]   CC       core.o
[   41.958813]=20
[   41.963933]   LD       fd/libapi-in.o
[   41.963935]=20
[   41.969600]   CC       fs/fs.o
[   41.969602]=20
[   41.974676]   CC       cpumap.o
[   41.974678]=20
[   41.979796]   CC       help.o
[   41.979798]=20
[   41.984990]   CC       fs/tracing_path.o
[   41.984992]=20
[   41.990989]   CC       fs/cgroup.o
[   41.990991]=20
[   41.996521]   LD       fs/libapi-in.o
[   41.996523]=20
[   42.002134]   CC       cpu.o
[   42.002136]=20
[   42.007025]   CC       pager.o
[   42.007027]=20
[   42.012081]   CC       debug.o
[   42.012083]=20
[   42.017218]   CC       threadmap.o
[   42.017220]=20
[   42.022773]   CC       str_error_r.o
[   42.022775]=20
[   42.028425]   LD       libapi-in.o
[   42.028427]=20
[   42.033864]   AR       libapi.a
[   42.033866]=20
[   42.039022]   CC       evsel.o
[   42.039024]=20
[   42.044251]   CC       parse-options.o
[   42.044253]=20
[   42.050020]   CC       evlist.o
[   42.050022]=20
[   42.055125]   CC       mmap.o
[   42.055127]=20
[   42.060233]   CC       event-plugin.o
[   42.060236]=20
[   42.065978]   CC       trace-seq.o
[   42.065981]=20
[   42.071507]   CC       parse-filter.o
[   42.071509]=20
[   42.077037]   CC       zalloc.o
[   42.077039]=20
[   42.082078]   CC       xyarray.o
[   42.082079]=20
[   42.087148]   CC       lib.o
[   42.087149]=20
[   42.092034]   CC       run-command.o
[   42.092036]=20
[   42.097578]   LD       libperf-in.o
[   42.097580]=20
[   42.102974]   AR       libperf.a
[   42.102976]=20
[   42.108186]   CC       parse-utils.o
[   42.108188]=20
[   42.113823]   GEN      bpf_helper_defs.h
[   42.113824]=20
[   42.119767]   CC       kbuffer-parse.o
[   42.119768]=20
[   42.125451]   MKDIR    staticobjs/
[   42.125453]=20
[   42.130967]   CC       staticobjs/libbpf.o
[   42.130968]=20
[   42.136981]   CC       sigchain.o
[   42.136982]=20
[   42.142317]   CC       subcmd-config.o
[   42.142319]=20
[   42.147998]   MKDIR    staticobjs/
[   42.148000]=20
[   42.153436]   CC       staticobjs/bpf.o
[   42.153438]=20
[   42.159264]   CC       tep_strerror.o
[   42.159266]=20
[   42.164937]   LD       libsubcmd-in.o
[   42.164939]=20
[   42.170671]   CC       event-parse-api.o
[   42.170673]=20
[   42.176516]   AR       libsubcmd.a
[   42.176517]=20
[   42.182002]   LD       libtraceevent-in.o
[   42.182004]=20
[   42.188029]   LINK     libtraceevent.a
[   42.188030]=20
[   42.193886]   CC       staticobjs/nlattr.o
[   42.193887]=20
[   42.200021]   CC       staticobjs/btf.o
[   42.200023]=20
[   42.206069]   CC       staticobjs/libbpf_errno.o
[   42.206070]=20
[   42.212842]   CC       staticobjs/str_error.o
[   42.212844]=20
[   42.219160]   GEN      common-cmds.h
[   42.219161]=20
[   42.224853]   CC       staticobjs/netlink.o
[   42.224854]=20
[   42.231300]   CC       staticobjs/bpf_prog_linfo.o
[   42.231301]=20
[   42.238327]   CC       staticobjs/libbpf_probes.o
[   42.238329]=20
[   42.245076]   CC       staticobjs/xsk.o
[   42.245078]=20
[   42.251040]   CC       staticobjs/hashmap.o
[   42.251042]=20
[   42.257357]   CC       staticobjs/btf_dump.o
[   42.257358]=20
[   42.263732]   CC       staticobjs/ringbuf.o
[   42.263734]=20
[   42.269965]   HOSTCC   pmu-events/json.o
[   42.269966]=20
[   42.275933]   HOSTCC   pmu-events/jsmn.o
[   42.275934]=20
[   42.281827]   CC       plugin_jbd2.o
[   42.281829]=20
[   42.287509]   HOSTCC   pmu-events/jevents.o
[   42.287511]=20
[   42.293723]   LD       plugin_jbd2-in.o
[   42.293724]=20
[   42.299592]   CC       plugin_hrtimer.o
[   42.299594]=20
[   42.305512]   LD       plugin_hrtimer-in.o
[   42.305514]=20
[   42.311590]   CC       plugin_kmem.o
[   42.311591]=20
[   42.317338]   HOSTLD   pmu-events/jevents-in.o
[   42.317340]=20
[   42.323814]   CC       jvmti/libjvmti.o
[   42.323815]=20
[   42.329691]   LD       plugin_kmem-in.o
[   42.329692]=20
[   42.335464]   CC       plugin_kvm.o
[   42.335466]=20
[   42.340966]   LD       plugin_kvm-in.o
[   42.340968]=20
[   42.346774]   CC       plugin_mac80211.o
[   42.346776]=20
[   42.352845]   LD       staticobjs/libbpf-in.o
[   42.352847]=20
[   42.359054]   LINK     libbpf.a
[   42.359055]=20
[   42.364143]   GEN      perf-archive
[   42.364144]=20
[   42.369647]   GEN      perf-with-kcore
[   42.369649]=20
[   42.375463]   LINK     pmu-events/jevents
[   42.375465]=20
[   42.381594]   LD       plugin_mac80211-in.o
[   42.381595]=20
[   42.387904]   CC       plugin_sched_switch.o
[   42.387905]=20
[   42.394217]   CC       plugin_function.o
[   42.394218]=20
[   42.400334]   LD       plugin_sched_switch-in.o
[   42.400336]=20
[   42.407035]   GEN      pmu-events/pmu-events.c
[   42.407036]=20
[   42.413591]   LD       plugin_function-in.o
[   42.413592]=20
[   42.419766]   CC       plugin_futex.o
[   42.419768]=20
[   42.425470]   LD       plugin_futex-in.o
[   42.425472]=20
[   42.431339]   CC       plugin_xen.o
[   42.431341]=20
[   42.436841]   LD       plugin_xen-in.o
[   42.436842]=20
[   42.442575]   CC       plugin_scsi.o
[   42.442576]=20
[   42.448329]   CC       pmu-events/pmu-events.o
[   42.448331]=20
[   42.454864]   CC       jvmti/jvmti_agent.o
[   42.454865]=20
[   42.460995]   LD       plugin_scsi-in.o
[   42.460997]=20
[   42.466887]   CC       plugin_cfg80211.o
[   42.466889]=20
[   42.472927]   LD       plugin_cfg80211-in.o
[   42.472929]=20
[   42.479056]   CC       plugin_tlb.o
[   42.479058]=20
[   42.484574]   LD       plugin_tlb-in.o
[   42.484576]=20
[   42.490319]   LINK     plugin_jbd2.so
[   42.490321]=20
[   42.496039]   LINK     plugin_hrtimer.so
[   42.496041]=20
[   42.501950]   LINK     plugin_kmem.so
[   42.501952]=20
[   42.507595]   LINK     plugin_kvm.so
[   42.507597]=20
[   42.513227]   CC       jvmti/libstring.o
[   42.513229]=20
[   42.519204]   LINK     plugin_mac80211.so
[   42.519205]=20
[   42.525227]   CC       jvmti/libctype.o
[   42.525229]=20
[   42.531217]   LINK     plugin_sched_switch.so
[   42.531219]=20
[   42.537645]   LINK     plugin_function.so
[   42.537647]=20
[   42.543672]   LINK     plugin_futex.so
[   42.543673]=20
[   42.549390]   LINK     plugin_xen.so
[   42.549392]=20
[   42.554969]   LINK     plugin_scsi.so
[   42.554971]=20
[   42.560719]   LINK     plugin_cfg80211.so
[   42.560721]=20
[   42.566703]   LINK     plugin_tlb.so
[   42.566705]=20
[   42.572527]   GEN      libtraceevent-dynamic-list
[   42.572529]=20
[   42.579230]   CC       builtin-bench.o
[   42.579231]=20
[   42.585022]   LD       jvmti/jvmti-in.o
[   42.585023]=20
[   42.590887]   LINK     libperf-jvmti.so
[   42.590889]=20
[   42.596795]   CC       builtin-annotate.o
[   42.596796]=20
[   42.602794]   GEN      python/perf.so
[   42.602795]=20
[   42.608703]   LD       pmu-events/pmu-events-in.o
[   42.608705]=20
[   42.615422]   CC       builtin-config.o
[   42.615423]=20
[   42.621241]   CC       builtin-diff.o
[   42.621243]=20
[   42.626929]   CC       builtin-evlist.o
[   42.626930]=20
[   42.632782]   CC       builtin-ftrace.o
[   42.632784]=20
[   42.908623]   CC       builtin-help.o
[   42.908626]=20
[   43.278131]   CC       builtin-sched.o
[   43.278134]=20
[   43.479903]   CC       builtin-buildid-list.o
[   43.479906]=20
[   43.637961]   CC       builtin-buildid-cache.o
[   43.637964]=20
[   44.178879]   CC       builtin-kallsyms.o
[   44.178882]=20
[   44.296438]   CC       builtin-list.o
[   44.296441]=20
[   44.541360]   CC       builtin-record.o
[   44.541363]=20
[   44.681860]   CC       builtin-report.o
[   44.681863]=20
[   46.229454]   CC       builtin-stat.o
[   46.229458]=20
[   47.575999]   CC       builtin-timechart.o
[   47.576001]=20
[   47.775263]   CC       builtin-top.o
[   47.775266]=20
[   49.082379]   CC       builtin-script.o
[   49.082382]=20
[   50.194480]   CC       builtin-kmem.o
[   50.194483]=20
[   50.734297]   CC       builtin-lock.o
[   50.734300]=20
[   51.831119]   CC       builtin-kvm.o
[   51.831123]=20
[   51.987510]   CC       builtin-inject.o
[   51.987513]=20
[   52.427698]   CC       builtin-mem.o
[   52.427701]=20
[   52.905983]   CC       builtin-data.o
[   52.905987]=20
[   52.996708]   CC       builtin-version.o
[   52.996711]=20
[   53.075336]   CC       builtin-c2c.o
[   53.075339]=20
[   53.093168]   CC       builtin-trace.o
[   53.093171]=20
[   53.532551]   CC       builtin-probe.o
[   53.532555]=20
[   54.232259]   CC       bench/sched-messaging.o
[   54.232263]=20
[   54.540743]   CC       bench/sched-pipe.o
[   54.540746]=20
[   54.682993]   CC       bench/syscall.o
[   54.682996]=20
[   54.769056]   CC       bench/mem-functions.o
[   54.769059]=20
[   54.854904]   CC       tests/builtin-test.o
[   54.854907]=20
[   55.022920]   CC       bench/futex-hash.o
[   55.022923]=20
[   55.228906]   CC       bench/futex-wake.o
[   55.228910]=20
[   55.342497]   CC       tests/parse-events.o
[   55.342500]=20
[   55.396411]   CC       bench/futex-wake-parallel.o
[   55.396414]=20
[   55.637476]   CC       bench/futex-requeue.o
[   55.637479]=20
[   55.821312]   CC       bench/futex-lock-pi.o
[   55.821315]=20
[   56.045377]   CC       bench/epoll-wait.o
[   56.045381]=20
[   56.097953]   CC       util/annotate.o
[   56.097956]=20
[   56.453692]   CC       bench/epoll-ctl.o
[   56.453695]=20
[   56.861059]   CC       bench/synthesize.o
[   56.861062]=20
[   57.084508]   CC       bench/kallsyms-parse.o
[   57.084511]=20
[   57.180344]   CC       bench/find-bit-bench.o
[   57.180347]=20
[   57.324215]   CC       bench/inject-buildid.o
[   57.324217]=20
[   57.758673]   CC       bench/mem-memcpy-x86-64-asm.o
[   57.758676]=20
[   57.781607]   CC       bench/mem-memset-x86-64-asm.o
[   57.781609]=20
[   57.795426]   CC       bench/numa.o
[   57.795428]=20
[   57.923166]   CC       tests/dso-data.o
[   57.923170]=20
[   58.193362]   CC       tests/attr.o
[   58.193365]=20
[   58.543834]   CC       tests/vmlinux-kallsyms.o
[   58.543837]=20
[   58.796486]   CC       tests/openat-syscall.o
[   58.796489]=20
[   58.907726]   CC       tests/openat-syscall-all-cpus.o
[   58.907730]=20
[   59.113706]   CC       tests/openat-syscall-tp-fields.o
[   59.113709]=20
[   59.282651]   CC       tests/mmap-basic.o
[   59.282654]=20
[   59.608964]   CC       tests/perf-record.o
[   59.608967]=20
[   59.987542]   CC       tests/evsel-roundtrip-name.o
[   59.987554]=20
[   60.124199]   CC       tests/evsel-tp-sched.o
[   60.124202]=20
[   60.195016]   CC       util/block-info.o
[   60.195019]=20
[   60.218099]   CC       tests/fdarray.o
[   60.218103]=20
[   60.224448]   LD       bench/perf-in.o
[   60.224450]=20
[   60.260887]   CC       arch/common.o
[   60.260890]=20
[   60.291710]   CC       util/block-range.o
[   60.291713]=20
[   60.384170]   CC       arch/x86/util/header.o
[   60.384173]=20
[   60.523369]   CC       arch/x86/util/tsc.o
[   60.523373]=20
[   60.545488]   CC       tests/pmu.o
[   60.545491]=20
[   60.560608]   CC       arch/x86/util/pmu.o
[   60.560610]=20
[   60.646667]   CC       arch/x86/util/kvm-stat.o
[   60.646669]=20
[   60.680378]   CC       tests/pmu-events.o
[   60.680381]=20
[   60.734988]   CC       arch/x86/tests/regs_load.o
[   60.734991]=20
[   60.757917]   CC       arch/x86/tests/dwarf-unwind.o
[   60.757920]=20
[   60.789298]   CC       arch/x86/util/perf_regs.o
[   60.789301]=20
[   60.877259]   CC       arch/x86/tests/arch-tests.o
[   60.877262]=20
[   60.912394]   CC       arch/x86/tests/rdpmc.o
[   60.912397]=20
[   60.972954]   CC       arch/x86/util/topdown.o
[   60.972957]=20
[   61.062087]   CC       arch/x86/util/machine.o
[   61.062090]=20
[   61.114775]   CC       arch/x86/tests/perf-time-to-tsc.o
[   61.114778]=20
[   61.154451]   CC       util/build-id.o
[   61.154454]=20
[   61.219174]   CC       arch/x86/util/event.o
[   61.219177]=20
[   61.308495]   CC       arch/x86/tests/insn-x86.o
[   61.308499]=20
[   61.349020]   CC       tests/hists_common.o
[   61.349023]=20
[   61.361523]   CC       arch/x86/util/dwarf-regs.o
[   61.361526]=20
[   61.420332]   CC       arch/x86/util/unwind-libunwind.o
[   61.420335]=20
[   61.473851]   CC       arch/x86/util/auxtrace.o
[   61.473854]=20
[   61.528840]   CC       arch/x86/tests/intel-pt-pkt-decoder-test.o
[   61.528843]=20
[   61.617734]   CC       tests/hists_link.o
[   61.617737]=20
[   61.632890]   CC       arch/x86/util/archinsn.o
[   61.632893]=20
[   61.683991]   CC       arch/x86/tests/bp-modify.o
[   61.683994]=20
[   61.751476]   CC       arch/x86/util/intel-pt.o
[   61.751479]=20
[   61.835086]   LD       arch/x86/tests/perf-in.o
[   61.835089]=20
[   61.847769]   CC       arch/x86/util/intel-bts.o
[   61.847772]=20
[   61.867443]   CC       util/cacheline.o
[   61.867446]=20
[   61.904239]   CC       util/config.o
[   61.904242]=20
[   61.977941]   CC       tests/hists_filter.o
[   61.977944]=20
[   62.382008]   CC       tests/hists_output.o
[   62.382011]=20
[   62.405733]   CC       tests/hists_cumulate.o
[   62.405736]=20
[   62.545049]   CC       util/copyfile.o
[   62.545052]=20
[   62.672113]   CC       util/ctype.o
[   62.672116]=20
[   62.702029]   CC       util/db-export.o
[   62.702032]=20
[   63.013555]   LD       arch/x86/util/perf-in.o
[   63.013558]=20
[   63.041420]   LD       arch/x86/perf-in.o
[   63.041423]=20
[   63.061942]   LD       arch/perf-in.o
[   63.061945]=20
[   63.083470]   CC       ui/setup.o
[   63.083473]=20
[   63.179757]   CC       ui/helpline.o
[   63.179760]=20
[   63.285982]   CC       ui/progress.o
[   63.285985]=20
[   63.358594]   CC       ui/util.o
[   63.358596]=20
[   63.436649]   CC       ui/hist.o
[   63.436652]=20
[   63.472374]   CC       tests/python-use.o
[   63.472377]=20
[   63.529827]   CC       tests/bp_signal.o
[   63.529829]=20
[   63.607608]   CC       util/env.o
[   63.607610]=20
[   63.658651]   CC       tests/bp_signal_overflow.o
[   63.658654]=20
[   63.669882]   CC       tests/bp_account.o
[   63.669885]=20
[   63.766963]   CC       tests/wp.o
[   63.766966]=20
[   63.943679]   CC       util/event.o
[   63.943682]=20
[   63.991261]   CC       tests/task-exit.o
[   63.991264]=20
[   64.040936]   CC       util/evlist.o
[   64.040938]=20
[   64.132153]   CC       tests/sw-clock.o
[   64.132156]=20
[   64.275927]   CC       tests/mmap-thread-lookup.o
[   64.275930]=20
[   64.520073]   CC       tests/thread-maps-share.o
[   64.520076]=20
[   64.693439]   CC       tests/switch-tracking.o
[   64.693442]=20
[   64.721448]   CC       util/sideband_evlist.o
[   64.721451]=20
[   64.903392]   CC       util/evsel.o
[   64.903395]=20
[   65.173948]   CC       tests/keep-tracking.o
[   65.173951]=20
[   65.324399]   CC       tests/code-reading.o
[   65.324402]=20
[   66.082243]   CC       tests/sample-parsing.o
[   66.082246]=20
[   66.181531]   CC       util/evsel_fprintf.o
[   66.181534]=20
[   66.504389]   CC       util/perf_event_attr_fprintf.o
[   66.504392]=20
[   66.651780]   CC       tests/parse-no-sample-id-all.o
[   66.651783]=20
[   66.777145]   CC       tests/kmod-path.o
[   66.777148]=20
[   67.034998]   CC       util/evswitch.o
[   67.035001]=20
[   67.094623]   CC       tests/thread-map.o
[   67.094626]=20
[   67.147435]   CC       util/find_bit.o
[   67.147438]=20
[   67.269026]   CC       tests/llvm.o
[   67.269030]=20
[   67.278967]   CC       util/get_current_dir_name.o
[   67.278969]=20
[   67.302902]   CC       util/kallsyms.o
[   67.302905]=20
[   67.408239]   CC       tests/bpf.o
[   67.408243]=20
[   67.556698]   CC       util/levenshtein.o
[   67.556701]=20
[   67.672587]   CC       tests/topology.o
[   67.672590]=20
[   67.683532]   CC       util/llvm-utils.o
[   67.683535]=20
[   67.859475]   CC       tests/mem.o
[   67.859478]=20
[   67.946671]   CC       tests/cpumap.o
[   67.946674]=20
[   68.023789]   CC       util/mmap.o
[   68.023792]=20
[   68.137902]   CC       tests/stat.o
[   68.137905]=20
[   68.319832]   CC       tests/event_update.o
[   68.319835]=20
[   68.357681]   CC       util/memswap.o
[   68.357684]=20
[   68.400539]   BISON    util/parse-events-bison.c
[   68.400541]=20
[   68.466551]   CC       util/perf_regs.o
[   68.466554]=20
[   68.488897]   CC       util/path.o
[   68.488899]=20
[   68.509521]   CC       tests/event-times.o
[   68.509524]=20
[   68.549676]   CC       util/print_binary.o
[   68.549679]=20
[   68.584966]   CC       util/rlimit.o
[   68.584969]=20
[   68.625501]   CC       util/argv_split.o
[   68.625504]=20
[   68.647172]   CC       util/rbtree.o
[   68.647175]=20
[   68.716127]   CC       util/libstring.o
[   68.716130]=20
[   68.821941]   CC       tests/expr.o
[   68.821944]=20
[   68.831499]   CC       util/bitmap.o
[   68.831501]=20
[   68.969502]   CC       tests/backward-ring-buffer.o
[   68.969505]=20
[   68.987170]   CC       tests/sdt.o
[   68.987173]=20
[   69.107211]   CC       tests/is_printable_array.o
[   69.107214]=20
[   69.130092]   CC       tests/bitmap.o
[   69.130095]=20
[   69.189765]   CC       tests/perf-hooks.o
[   69.189768]=20
[   69.231346]   CC       tests/clang.o
[   69.231348]=20
[   69.247785]   CC       tests/unit_number__scnprintf.o
[   69.247787]=20
[   69.269065]   CC       util/hweight.o
[   69.269068]=20
[   69.315200]   CC       tests/mem2node.o
[   69.315203]=20
[   69.321009]   CC       util/smt.o
[   69.321011]=20
[   69.399954]   CC       util/strbuf.o
[   69.399956]=20
[   69.452258]   CC       tests/maps.o
[   69.452260]=20
[   69.502244]   CC       ui/stdio/hist.o
[   69.502247]=20
[   69.612967]   CC       util/string.o
[   69.612969]=20
[   69.669331]   CC       tests/time-utils-test.o
[   69.669334]=20
[   69.743839]   CC       util/strlist.o
[   69.743842]=20
[   69.852182]   CC       util/strfilter.o
[   69.852185]=20
[   69.921236]   CC       util/top.o
[   69.921240]=20
[   69.972555]   CC       tests/genelf.o
[   69.972558]=20
[   70.045834]   CC       tests/api-io.o
[   70.045837]=20
[   70.211602]   CC       util/usage.o
[   70.211605]=20
[   70.267615]   CC       util/dso.o
[   70.267618]=20
[   70.406124]   CC       tests/demangle-java-test.o
[   70.406127]=20
[   70.509956]   CC       tests/pfm.o
[   70.509959]=20
[   70.582724]   CC       tests/parse-metric.o
[   70.582728]=20
[   70.664368]   CC       ui/browser.o
[   70.664371]=20
[   70.856669]   CC       tests/pe-file-parsing.o
[   70.856672]=20
[   70.997726]   CC       tests/expand-cgroup.o
[   70.997729]=20
[   71.323272]   CC       tests/dwarf-unwind.o
[   71.323275]=20
[   71.475913]   CC       ui/browsers/annotate.o
[   71.475916]=20
[   71.503834]   CC       tests/llvm-src-base.o
[   71.503837]=20
[   71.531506]   CC       tests/llvm-src-kbuild.o
[   71.531509]=20
[   71.542163]   CC       util/dsos.o
[   71.542166]=20
[   71.559260]   CC       tests/llvm-src-prologue.o
[   71.559262]=20
[   71.586296]   CC       tests/llvm-src-relocation.o
[   71.586300]=20
[   71.612823]   LD       tests/perf-in.o
[   71.612825]=20
[   71.732652]   CC       scripts/perl/Perf-Trace-Util/Context.o
[   71.732655]=20
[   71.897947]   CC       util/symbol.o
[   71.897950]=20
[   71.996256]   CC       scripts/python/Perf-Trace-Util/Context.o
[   71.996259]=20
[   72.132653]   LD       scripts/python/Perf-Trace-Util/perf-in.o
[   72.132656]=20
[   72.140899]   CC       util/symbol_fprintf.o
[   72.140901]=20
[   72.300213]   CC       util/color.o
[   72.300215]=20
[   72.320392]   LD       scripts/perl/Perf-Trace-Util/perf-in.o
[   72.320395]=20
[   72.346610]   LD       scripts/perf-in.o
[   72.346612]=20
[   72.373291]   CC       util/color_config.o
[   72.373294]=20
[   72.479749]   CC       trace/beauty/clone.o
[   72.479752]=20
[   72.491422]   CC       perf.o
[   72.491424]=20
[   72.627074]   CC       trace/beauty/fcntl.o
[   72.627076]=20
[   72.720004]   CC       trace/beauty/flock.o
[   72.720007]=20
[   72.812593]   CC       trace/beauty/fsmount.o
[   72.812596]=20
[   72.857013]   CC       util/metricgroup.o
[   72.857016]=20
[   72.866773]   CC       trace/beauty/fspick.o
[   72.866776]=20
[   72.879195]   CC       ui/browsers/hists.o
[   72.879198]=20
[   72.928231]   CC       trace/beauty/ioctl.o
[   72.928234]=20
[   73.097468]   CC       trace/beauty/kcmp.o
[   73.097471]=20
[   73.169861]   CC       trace/beauty/mount_flags.o
[   73.169864]=20
[   73.229390]   CC       trace/beauty/move_mount.o
[   73.229393]=20
[   73.281588]   CC       trace/beauty/pkey_alloc.o
[   73.281591]=20
[   73.439799]   CC       trace/beauty/arch_prctl.o
[   73.439802]=20
[   73.484894]   CC       trace/beauty/prctl.o
[   73.484897]=20
[   73.567834]   CC       trace/beauty/renameat.o
[   73.567837]=20
[   73.614854]   CC       trace/beauty/sockaddr.o
[   73.614857]=20
[   73.734373]   CC       trace/beauty/socket.o
[   73.734376]=20
[   73.787273]   CC       trace/beauty/statx.o
[   73.787276]=20
[   73.916600]   CC       trace/beauty/sync_file_range.o
[   73.916603]=20
[   73.983966]   CC       trace/beauty/tracepoints/x86_irq_vectors.o
[   73.983969]=20
[   74.040825]   CC       trace/beauty/tracepoints/x86_msr.o
[   74.040828]=20
[   74.101781]   LD       trace/beauty/tracepoints/perf-in.o
[   74.101784]=20
[   74.109507]   LD       trace/beauty/perf-in.o
[   74.109509]=20
[   74.126086]   CC       util/header.o
[   74.126089]=20
[   74.145426]   CC       util/callchain.o
[   74.145429]=20
[   74.255289]   CC       util/values.o
[   74.255292]=20
[   74.816935]   CC       util/debug.o
[   74.816939]=20
[   75.043371]   CC       util/fncache.o
[   75.043373]=20
[   75.180838]   CC       util/machine.o
[   75.180841]=20
[   76.172052]   CC       util/map.o
[   76.172056]=20
[   77.536682]   CC       util/pstack.o
[   77.536685]=20
[   77.644249]   CC       util/session.o
[   77.644251]=20
[   78.843021]   CC       util/sample-raw.o
[   78.843024]=20
[   78.885600]   CC       util/s390-sample-raw.o
[   78.885603]=20
[   78.931757]   CC       util/syscalltbl.o
[   78.931760]=20
[   79.103228]   CC       util/ordered-events.o
[   79.103231]=20
[   79.161504]   CC       util/namespaces.o
[   79.161507]=20
[   79.469658]   CC       util/comm.o
[   79.469661]=20
[   79.649867]   CC       util/thread.o
[   79.649870]=20
[   79.801952]   CC       util/thread_map.o
[   79.801955]=20
[   80.095891]   CC       ui/browsers/map.o
[   80.095894]=20
[   80.203011]   CC       util/trace-event-parse.o
[   80.203014]=20
[   80.259837]   CC       util/parse-events-bison.o
[   80.259841]=20
[   80.270866]   CC       ui/browsers/scripts.o
[   80.270869]=20
[   80.390410]   CC       ui/browsers/header.o
[   80.390413]=20
[   80.551060]   CC       ui/browsers/res_sample.o
[   80.551063]=20
[   80.581507]   BISON    util/pmu-bison.c
[   80.581510]=20
[   80.609574]   CC       util/trace-event-read.o
[   80.609578]=20
[   80.717878]   CC       util/trace-event-info.o
[   80.717881]=20
[   80.843929]   CC       util/trace-event-scripting.o
[   80.843932]=20
[   80.939917]   CC       util/trace-event.o
[   80.939920]=20
[   81.091798]   CC       util/svghelper.o
[   81.091801]=20
[   81.162072]   CC       util/sort.o
[   81.162075]=20
[   81.825775]   CC       util/hist.o
[   81.825777]=20
[   82.330656]   CC       util/util.o
[   82.330659]=20
[   82.665015]   CC       util/cpumap.o
[   82.665018]=20
[   82.883485]   LD       ui/browsers/perf-in.o
[   82.883488]=20
[   82.918031]   CC       ui/tui/setup.o
[   82.918034]=20
[   83.048132]   CC       ui/tui/util.o
[   83.048136]=20
[   83.293443]   CC       ui/tui/helpline.o
[   83.293446]=20
[   83.328496]   CC       util/affinity.o
[   83.328499]=20
[   83.378411]   CC       ui/tui/progress.o
[   83.378414]=20
[   83.423236]   CC       util/cputopo.o
[   83.423239]=20
[   83.490525]   LD       ui/tui/perf-in.o
[   83.490528]=20
[   83.498892]   LD       ui/perf-in.o
[   83.498895]=20
[   83.546776]   CC       util/cgroup.o
[   83.546779]=20
[   83.702682]   CC       util/target.o
[   83.702685]=20
[   83.837416]   CC       util/rblist.o
[   83.837420]=20
[   83.990294]   CC       util/intlist.o
[   83.990298]=20
[   84.079340]   CC       util/vdso.o
[   84.079343]=20
[   84.156148]   CC       util/counts.o
[   84.156151]=20
[   84.163841]   CC       util/stat.o
[   84.163844]=20
[   84.269112]   CC       util/stat-shadow.o
[   84.269115]=20
[   84.339768]   CC       util/stat-display.o
[   84.339771]=20
[   84.894150]   CC       util/perf_api_probe.o
[   84.894154]=20
[   85.174366]   CC       util/record.o
[   85.174370]=20
[   85.489153]   CC       util/srcline.o
[   85.489156]=20
[   86.063672]   CC       util/srccode.o
[   86.063674]=20
[   86.236314]   CC       util/synthetic-events.o
[   86.236317]=20
[   86.310802]   CC       util/data.o
[   86.310805]=20
[   86.563642]   CC       util/tsc.o
[   86.563645]=20
[   86.722854]   CC       util/cloexec.o
[   86.722857]=20
[   86.786063]   CC       util/call-path.o
[   86.786066]=20
[   86.846848]   CC       util/rwsem.o
[   86.846851]=20
[   86.923062]   CC       util/thread-stack.o
[   86.923065]=20
[   87.053689]   CC       util/spark.o
[   87.053692]=20
[   87.129038]   CC       util/topdown.o
[   87.129041]=20
[   87.137141]   CC       util/stream.o
[   87.137143]=20
[   87.239820]   CC       util/auxtrace.o
[   87.239822]=20
[   87.487416]   CC       util/intel-pt-decoder/intel-pt-pkt-decoder.o
[   87.487419]=20
[   87.969830]   GEN      util/intel-pt-decoder/inat-tables.c
[   87.969834]=20
[   87.989383]   CC       util/intel-pt-decoder/intel-pt-log.o
[   87.989386]=20
[   88.098416]   CC       util/intel-pt-decoder/intel-pt-decoder.o
[   88.098420]=20
[   88.587384]   CC       util/arm-spe-decoder/arm-spe-pkt-decoder.o
[   88.587387]=20
[   88.758135]   CC       util/scripting-engines/trace-event-perl.o
[   88.758138]=20
[   88.923360]   CC       util/arm-spe-decoder/arm-spe-decoder.o
[   88.923364]=20
[   89.141085]   LD       util/arm-spe-decoder/perf-in.o
[   89.141088]=20
[   89.154143]   CC       util/intel-pt.o
[   89.154145]=20
[   90.111447]   CC       util/scripting-engines/trace-event-python.o
[   90.111450]=20
[   90.340128]   CC       util/intel-bts.o
[   90.340131]=20
[   91.314036]   CC       util/arm-spe.o
[   91.314039]=20
[   92.139767]   CC       util/intel-pt-decoder/intel-pt-insn-decoder.o
[   92.139770]=20
[   92.418047]   CC       util/s390-cpumsf.o
[   92.418050]=20
[   92.484918] IPMI BMC is not supported on this machine, skip bmc-watchdog=
 setup!
[   92.484920]=20
[   92.730034]   LD       util/scripting-engines/perf-in.o
[   92.730036]=20
[   92.746003]   CC       util/parse-branch-options.o
[   92.746006]=20
[   92.836998]   CC       util/dump-insn.o
[   92.837001]=20
[   92.874219]   CC       util/parse-regs-options.o
[   92.874222]=20
[   92.973847]   CC       util/parse-sublevel-options.o
[   92.973850]=20
[   93.049678]   CC       util/term.o
[   93.049681]=20
[   93.120614]   CC       util/help-unknown-cmd.o
[   93.120617]=20
[   93.271369]   CC       util/mem-events.o
[   93.271372]=20
[   93.326866]   LD       util/intel-pt-decoder/perf-in.o
[   93.326869]=20
[   93.339617]   CC       util/vsprintf.o
[   93.339620]=20
[   93.381871]   CC       util/units.o
[   93.381874]=20
[   93.406993]   CC       util/time-utils.o
[   93.406996]=20
[   93.463545]   BISON    util/expr-bison.c
[   93.463553]=20
[   93.504588]   CC       util/branch.o
[   93.504591]=20
[   93.762057]   CC       util/mem2node.o
[   93.762060]=20
[   93.815592]   CC       util/clockid.o
[   93.815595]=20
[   93.881437]   CC       util/bpf-loader.o
[   93.881440]=20
[   93.915771]   CC       util/bpf_map.o
[   93.915773]=20
[   93.951612]   CC       util/bpf-prologue.o
[   93.951614]=20
[   94.001444]   CC       util/symbol-elf.o
[   94.001447]=20
[   94.477775]   CC       util/probe-file.o
[   94.477778]=20
[   94.504345]   CC       util/probe-event.o
[   94.504348]=20
[   95.181043]   CC       util/probe-finder.o
[   95.181046]=20
[   95.489640]   CC       util/dwarf-aux.o
[   95.489643]=20
[   95.962112]   CC       util/dwarf-regs.o
[   95.962116]=20
[   96.036715]   CC       util/unwind-libunwind-local.o
[   96.036718]=20
[   96.193677]   CC       util/unwind-libunwind.o
[   96.193680]=20
[   96.335833]   CC       util/data-convert-bt.o
[   96.335837]=20
[   96.394239]   CC       util/zlib.o
[   96.394242]=20
[   96.481037]   CC       util/lzma.o
[   96.481040]=20
[   96.586914]   CC       util/zstd.o
[   96.586918]=20
[   96.686258]   CC       util/cap.o
[   96.686261]=20
[   96.724492]   CC       util/demangle-java.o
[   96.724495]=20
[   96.906327]   CC       util/demangle-rust.o
[   96.906330]=20
[   96.961749]   CC       util/jitdump.o
[   96.961752]=20
[   97.260961]   CC       util/genelf.o
[   97.260965]=20
[   97.509677]   CC       util/genelf_debug.o
[   97.509680]=20
[   97.688485]   CC       util/perf-hooks.o
[   97.688488]=20
[   97.817401]   CC       util/bpf-event.o
[   97.817404]=20
[   97.823441]   FLEX     util/parse-events-flex.c
[   97.823443]=20
[   97.852623]   FLEX     util/pmu-flex.c
[   97.852626]=20
[   97.871335]   CC       util/pmu-bison.o
[   97.871338]=20
[   98.072121]   FLEX     util/expr-flex.c
[   98.072124]=20
[   98.084325]   CC       util/expr-bison.o
[   98.084328]=20
[   98.134994]   CC       util/expr.o
[   98.134997]=20
[   98.336288]   CC       util/parse-events.o
[   98.336291]=20
[   98.373211]   CC       util/parse-events-flex.o
[   98.373214]=20
[   98.668838]   CC       util/pmu.o
[   98.668841]=20
[   98.766785]   CC       util/pmu-flex.o
[   98.766788]=20
[   99.801582]   CC       util/expr-flex.o
[   99.801584]=20
[  105.305151]   LD       util/perf-in.o
[  105.305153]=20
[  105.608741]   LD       perf-in.o
[  105.608743]=20
[  105.912677]   LINK     perf
[  105.912679]=20
[  106.861220] make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf'
[  106.861223]=20
[  106.876156] Key type dns_resolver registered
[  106.876872] 2020-12-25 16:25:39 cd /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf
[  106.880391]=20
[  106.893875] 2020-12-25 16:25:39 mkdir -p /pkg
[  106.893876]=20
[  106.900982] 2020-12-25 16:25:39 mkdir -p /kbuild/obj/consumer/x86_64-rhe=
l-8.3
[  106.900983]=20
[  107.022136] NFS: Registering the id_resolver key type
[  107.027153] Key type id_resolver registered
[  107.031317] Key type id_legacy registered
[  107.080318] 2020-12-25 16:25:39 cp /pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b=
1ba0e7ea9a80b0ee4b4445ea59c806787813/vmlinux.xz /tmp
[  107.080320]=20
[  107.568302] 2020-12-25 16:25:40 unxz -k /tmp/vmlinux.xz
[  107.568304]=20
[  111.277609] 2020-12-25 16:25:44 cp /tmp/vmlinux /kbuild/obj/consumer/x86=
_64-rhel-8.3
[  111.277612]=20
[  111.408565] ignored_by_lkp: BPF filter
[  111.408567]=20
[  111.450570] ignored_by_lkp: LLVM search and compile
[  111.450573]=20
[  111.491919] ignored_by_lkp: Add vfs_getname probe to get syscall args fi=
lenames
[  111.491923]=20
[  111.532915] ignored_by_lkp: Use vfs_getname probe to get syscall args fi=
lenames
[  111.532918]=20
[  111.574082] ignored_by_lkp: Check open filename arg using perf trace + v=
fs_getname
[  111.574085]=20
[  111.614721] ignored_by_lkp: builtin clang support
[  111.614737]=20
[  111.662896] 2020-12-25 16:25:44 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 1
[  111.662898]=20
[  112.494369]  1: vmlinux symtab matches kallsyms                         =
        : Ok
[  112.494373]=20
[  112.515321] 2020-12-25 16:25:45 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 2
[  112.515323]=20
[  112.580941]  2: Detect openat syscall event                             =
        : Ok
[  112.580944]=20
[  112.601463] 2020-12-25 16:25:45 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 3
[  112.601465]=20
[  112.670091]  3: Detect openat syscall event on all cpus                 =
        : Ok
[  112.670094]=20
[  112.691113] 2020-12-25 16:25:45 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 4
[  112.691116]=20
[  112.813020]  4: Read samples using the mmap interface                   =
        : FAILED!
[  112.813023]=20
[  112.834024] 2020-12-25 16:25:45 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 5
[  112.834027]=20
[  112.878434]  5: Test data source output                                 =
        : Ok
[  112.878436]=20
[  112.898869] 2020-12-25 16:25:45 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 6
[  112.898872]=20
[  114.181584]  6: Parse event definition strings                          =
        : FAILED!
[  114.181601]=20
[  114.201812] 2020-12-25 16:25:47 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 7
[  114.201814]=20
[  114.247836]  7: Simple expression parser                                =
        : Ok
[  114.247839]=20
[  114.268764] 2020-12-25 16:25:47 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 8
[  114.268767]=20
[  116.326288]  8: PERF_RECORD_* events & perf_sample fields               =
        : Ok
[  116.326291]=20
[  116.346857] 2020-12-25 16:25:49 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 9
[  116.346859]=20
[  116.398116]  9: Parse perf pmu format                                   =
        : Ok
[  116.398119]=20
[  116.418850] 2020-12-25 16:25:49 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 10
[  116.418853]=20
[  116.445990] 10: PMU events                                              =
        :
[  116.445993]=20
[  116.464657] 10.1: PMU event table sanity                                =
        : Ok
[  116.464660]=20
[  116.551692] 10.2: PMU event map aliases                                 =
        : Ok
[  116.551694]=20
[  118.242663] 10.3: Parsing of PMU event table metrics                    =
        : Skip (some metrics failed)
[  118.242666]=20
[  118.371444] 10.4: Parsing of PMU event table metrics with fake PMUs     =
        : Ok
[  118.371447]=20
[  118.392337] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 11
[  118.392339]=20
[  118.438031] 11: DSO data read                                           =
        : Ok
[  118.438034]=20
[  118.458965] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 12
[  118.458967]=20
[  118.505934] 12: DSO data cache                                          =
        : Ok
[  118.505937]=20
[  118.526529] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 13
[  118.526531]=20
[  118.573140] 13: DSO data reopen                                         =
        : Ok
[  118.573143]=20
[  118.593876] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 14
[  118.593879]=20
[  118.640613] 14: Roundtrip evsel->name                                   =
        : Ok
[  118.640617]=20
[  118.661177] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 15
[  118.661180]=20
[  118.708521] 15: Parse sched tracepoints fields                          =
        : Ok
[  118.708523]=20
[  118.729055] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 16
[  118.729057]=20
[  118.796829] 16: syscalls:sys_enter_openat event fields                  =
        : Ok
[  118.796831]=20
[  118.817097] 2020-12-25 16:25:51 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 17
[  118.817100]=20
[  132.920286] 17: Setup struct perf_event_attr                            =
        : Ok
[  132.920288]=20
[  132.940728] 2020-12-25 16:26:05 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 18
[  132.940730]=20
[  132.985757] 18: Match and link multiple hists                           =
        : Ok
[  132.985760]=20
[  133.006200] 2020-12-25 16:26:05 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 19
[  133.006202]=20
[  133.063471] 19: 'import perf' in python                                 =
        : FAILED!
[  133.063474]=20
[  133.083996] 2020-12-25 16:26:05 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 20
[  133.083999]=20
[  133.130030] 20: Breakpoint overflow signal handler                      =
        : Ok
[  133.130033]=20
[  133.151059] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 21
[  133.151061]=20
[  133.204150] 21: Breakpoint overflow sampling                            =
        : Ok
[  133.204153]=20
[  133.224792] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 22
[  133.224794]=20
[  133.270011] 22: Breakpoint accounting                                   =
        : Ok
[  133.270014]=20
[  133.290812] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 23
[  133.290814]=20
[  133.317877] 23: Watchpoint                                              =
        :
[  133.317880]=20
[  133.336340] 23.1: Read Only Watchpoint                                  =
        : Skip
[  133.336342]=20
[  133.354651] 23.2: Write Only Watchpoint                                 =
        : Ok
[  133.354653]=20
[  133.372948] 23.3: Read / Write Watchpoint                               =
        : Ok
[  133.372951]=20
[  133.391146] 23.4: Modify Watchpoint                                     =
        : Ok
[  133.391148]=20
[  133.411988] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 24
[  133.411990]=20
[  133.488894] 24: Number of exit events of a simple workload              =
        : FAILED!
[  133.488897]=20
[  133.509502] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 25
[  133.509504]=20
[  133.615162] 25: Software clock events period values                     =
        : FAILED!
[  133.615165]=20
[  133.635244] 2020-12-25 16:26:06 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 26
[  133.635246]=20
[  134.075631] perf: interrupt took too long (2601 > 2500), lowering kernel=
=2Eperf_event_max_sample_rate to 76000
[  136.755784] 26: Object code reading                                     =
        : FAILED!
[  136.755786]=20
[  136.776297] 2020-12-25 16:26:09 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 27
[  136.776300]=20
[  136.821956] 27: Sample parsing                                          =
        : Ok
[  136.821959]=20
[  136.842807] 2020-12-25 16:26:09 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 28
[  136.842810]=20
[  136.918980] 28: Use a dummy software event to keep tracking             =
        : FAILED!
[  136.918983]=20
[  136.939689] 2020-12-25 16:26:09 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 29
[  136.939692]=20
[  136.985042] 29: Parse with no sample_id_all bit set                     =
        : Ok
[  136.985045]=20
[  137.005701] 2020-12-25 16:26:09 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 30
[  137.005703]=20
[  137.051953] 30: Filter hist entries                                     =
        : Ok
[  137.051956]=20
[  137.073083] 2020-12-25 16:26:09 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 31
[  137.073086]=20
[  137.487808] 31: Lookup mmap thread                                      =
        : FAILED!
[  137.487811]=20
[  137.508920] 2020-12-25 16:26:10 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 32
[  137.508923]=20
[  137.554376] 32: Share thread maps                                       =
        : Ok
[  137.554379]=20
[  137.575109] 2020-12-25 16:26:10 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 33
[  137.575112]=20
[  137.621995] 33: Sort output of hist entries                             =
        : Ok
[  137.621997]=20
[  137.643113] 2020-12-25 16:26:10 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 34
[  137.643116]=20
[  137.689930] 34: Cumulate child hist entries                             =
        : Ok
[  137.689933]=20
[  137.710669] 2020-12-25 16:26:10 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 35
[  137.710671]=20
[  138.186132] 35: Track with sched_switch                                 =
        : FAILED!
[  138.186135]=20
[  138.206753] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 36
[  138.206756]=20
[  138.252009] 36: Filter fds with revents mask in a fdarray               =
        : Ok
[  138.252012]=20
[  138.272663] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 37
[  138.272666]=20
[  138.317606] 37: Add fd to a fdarray, making it autogrow                 =
        : Ok
[  138.317609]=20
[  138.338054] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 38
[  138.338057]=20
[  138.383303] 38: kmod_path__parse                                        =
        : Ok
[  138.383306]=20
[  138.403887] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 39
[  138.403889]=20
[  138.449721] 39: Thread map                                              =
        : Ok
[  138.449724]=20
[  138.472155] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 41
[  138.472158]=20
[  138.700130] 41: Session topology                                        =
        : FAILED!
[  138.700133]=20
[  138.722000] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 43
[  138.722002]=20
[  138.796404] 43: Synthesize thread map                                   =
        : FAILED!
[  138.796406]=20
[  138.817104] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 44
[  138.817106]=20
[  138.888377] 44: Remove thread map                                       =
        : FAILED!
[  138.888380]=20
[  138.908976] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 45
[  138.908978]=20
[  138.954887] 45: Synthesize cpu map                                      =
        : Ok
[  138.954890]=20
[  138.975511] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 46
[  138.975514]=20
[  139.020705] 46: Synthesize stat config                                  =
        : Ok
[  139.020708]=20
[  139.041376] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 47
[  139.041378]=20
[  139.085894] 47: Synthesize stat                                         =
        : Ok
[  139.085897]=20
[  139.106184] 2020-12-25 16:26:11 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 48
[  139.106187]=20
[  139.152015] 48: Synthesize stat round                                   =
        : Ok
[  139.152018]=20
[  139.173141] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 49
[  139.173144]=20
[  139.253527] 49: Synthesize attr update                                  =
        : FAILED!
[  139.253530]=20
[  139.274504] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 50
[  139.274507]=20
[  139.332635] 50: Event times                                             =
        : Ok
[  139.332638]=20
[  139.353134] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 51
[  139.353137]=20
[  139.487719] 51: Read backward ring buffer                               =
        : Ok
[  139.487722]=20
[  139.508250] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 52
[  139.508252]=20
[  139.583084] 52: Print cpu map                                           =
        : FAILED!
[  139.583086]=20
[  139.603431] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 53
[  139.603433]=20
[  139.648935] 53: Merge cpu map                                           =
        : Ok
[  139.648937]=20
[  139.669741] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 54
[  139.669744]=20
[  139.716023] 54: Probe SDT events                                        =
        : Ok
[  139.716025]=20
[  139.736752] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 55
[  139.736755]=20
[  139.780981] 55: is_printable_array                                      =
        : Ok
[  139.780984]=20
[  139.801687] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 56
[  139.801690]=20
[  139.847641] 56: Print bitmap                                            =
        : Ok
[  139.847644]=20
[  139.868185] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 57
[  139.868188]=20
[  139.913098] 57: perf hooks                                              =
        : Ok
[  139.913100]=20
[  139.934734] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 59
[  139.934737]=20
[  139.979489] 59: unit_number__scnprintf                                  =
        : Ok
[  139.979492]=20
[  140.000147] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 60
[  140.000150]=20
[  140.044935] 60: mem2node                                                =
        : Ok
[  140.044938]=20
[  140.065505] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 61
[  140.065507]=20
[  140.111033] 61: time utils                                              =
        : Ok
[  140.111035]=20
[  140.131867] 2020-12-25 16:26:12 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 62
[  140.131870]=20
[  140.178067] 62: Test jit_write_elf                                      =
        : Ok
[  140.178070]=20
[  140.199296] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 63
[  140.199298]=20
[  140.226438] 63: Test libpfm4 support                                    =
        : Skip (not compiled in)
[  140.226441]=20
[  140.245694] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 64
[  140.245696]=20
[  140.291678] 64: Test api io                                             =
        : Ok
[  140.291681]=20
[  140.312114] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 65
[  140.312116]=20
[  140.392987] 65: maps__merge_in                                          =
        : FAILED!
[  140.392989]=20
[  140.413807] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 66
[  140.413810]=20
[  140.459562] 66: Demangle Java                                           =
        : Ok
[  140.459579]=20
[  140.480666] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 67
[  140.480669]=20
[  140.529782] 67: Parse and process metrics                               =
        : Ok
[  140.529785]=20
[  140.550204] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 68
[  140.550206]=20
[  140.623476] 68: PE file support                                         =
        : FAILED!
[  140.623478]=20
[  140.644073] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 69
[  140.644075]=20
[  140.690168] 69: Event expansion for cgroups                             =
        : Ok
[  140.690171]=20
[  140.710643] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 70
[  140.710646]=20
[  140.944296] 70: x86 rdpmc                                               =
        : Ok
[  140.944299]=20
[  140.964817] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 71
[  140.964820]=20
[  141.041137] 71: Convert perf time to TSC                                =
        : FAILED!
[  141.041140]=20
[  141.061746] 2020-12-25 16:26:13 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 72
[  141.061748]=20
[  141.457682] 72: DWARF unwind                                            =
        : FAILED!
[  141.457685]=20
[  141.478307] 2020-12-25 16:26:14 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 73
[  141.478310]=20
[  141.525183] 73: x86 instruction decoder - new instructions              =
        : Ok
[  141.525186]=20
[  141.545833] 2020-12-25 16:26:14 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 74
[  141.545836]=20
[  141.591564] 74: Intel PT packet decoder                                 =
        : Ok
[  141.591567]=20
[  141.612192] 2020-12-25 16:26:14 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 75
[  141.612194]=20
[  141.665823] 75: x86 bp modify                                           =
        : Ok
[  141.665825]=20
[  141.686216] 2020-12-25 16:26:14 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 76
[  141.686219]=20
[  143.484830] 76: probe libc's inet_pton & backtrace it with ping         =
        : Ok
[  143.484833]=20
[  143.505402] 2020-12-25 16:26:16 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 77
[  143.505404]=20
[  143.695126] 77: Check Arm CoreSight trace data recording and synthesized=
 samples: Skip
[  143.695129]=20
[  143.715677] 2020-12-25 16:26:16 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 78
[  143.715680]=20
[  145.157288] 78: build id cache operations                               =
        : FAILED!
[  145.157291]=20
[  145.180175] 2020-12-25 16:26:18 sudo /usr/src/perf_selftests-x86_64-rhel=
-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 81
[  145.180178]=20
[  146.486914] 81: Zstd perf.data compression/decompression                =
        : FAILED!
[  146.486917]=20
[  146.537605] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=3D=
0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c8067878=
13-20201226-25066-sfkgan-4.yaml&job_state=3Dpost_run -O /dev/null
[  146.537608]=20
[  148.252191] kill 2507 vmstat --timestamp -n 10=20
[  148.252194]=20
[  148.258935] kill 2505 dmesg --follow --decode=20
[  148.258936]=20
[  148.266035] wait for background processes: 2510 2512 meminfo oom-killer
[  148.266036]=20
[  154.480959] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=3D=
0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c8067878=
13-20201226-25066-sfkgan-4.yaml&loadavg=3D1.83%201.13%200.45%201/135%208978=
&start_time=3D1608913465&end_time=3D1608913579&version=3D/lkp/lkp/.src-2020=
1225-151440:04492474:3e57f6440& -O /dev/null
[  154.480962]=20
[  154.531104] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=3D=
0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c8067878=
13-20201226-25066-sfkgan-4.yaml&job_state=3Dfinished -O /dev/null
[  154.531105]=20
[  154.570198] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-post-run?job_file=
=3D/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=3D0xe2-debia=
n-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813-2020122=
6-25066-sfkgan-4.yaml -O /dev/null
[  154.570199]=20
[  154.903935] getting new job...
[  154.903938]=20
[  154.935136] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/gpxelinux.cgi?hostnam=
e=3Dlkp-skl-d04&mac=3D64:00:6a:30:92:35&last_kernel=3D/pkg/linux/x86_64-rhe=
l-8.3/gcc-9/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/vmlinuz-5.10.0-rc3-011=
27-g8c3b1ba0e7ea&lkp_wtmp -O /tmp/next-job-lkp
[  154.935139]=20
[  160.893508] 22 blocks
[  160.893511]=20
[  160.895323] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp//lkp/jobs/scheduled/lkp-skl-d=
04/hwsim-group-22-ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-bcf876870b95=
592b52519ed4aafcf9d95999bc9c-20201226-1429-g4u7i0-0.cgz -O /tmp/next-job.cgz
[  160.897280]=20
[  160.939474] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-wtmp?tbox_name=3D=
lkp-skl-d04&tbox_state=3Dkexec_to_next_job -O /dev/null
[  160.939476]=20
[  161.471655] downloading kernel image ...
[  161.471657]=20
[  161.502653] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-22-ucode=3D0xe2-de=
bian-10.4-x86_64-20200603.cgz-bcf876870b95592b52519ed4aafcf9d95999bc9c-2020=
1226-1429-g4u7i0-0.yaml&job_state=3Dwget_kernel -O /dev/null
[  161.502655]=20
[  162.154018] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/pkg/linux/x86_64-rhel-8.3/gcc=
-9/bcf876870b95592b52519ed4aafcf9d95999bc9c/vmlinuz-5.8.0 -N -P /opt/rootfs=
/tmp/pkg/linux/x86_64-rhel-8.3/gcc-9/bcf876870b95592b52519ed4aafcf9d95999bc=
9c
[  162.154021]=20
[  162.181728] downloading initrds ...
[  162.181730]=20
[  162.194272] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-22-ucode=3D0xe2-de=
bian-10.4-x86_64-20200603.cgz-bcf876870b95592b52519ed4aafcf9d95999bc9c-2020=
1226-1429-g4u7i0-0.yaml&job_state=3Dwget_initrd -O /dev/null
[  162.194274]=20
[  162.746326] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/debian/debian-10.4-x8=
6_64-20200603.cgz -N -P /opt/rootfs/tmp/osimage/debian
[  162.746329]=20
[  162.919387] /opt/rootfs/tmp/osimage/debian/debian-10.4-x86_64-20200603.c=
gz isn't modified
[  162.919390]=20
[  162.936434] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/lkp/jobs/scheduled/lkp-skl-d0=
4/hwsim-group-22-ucode=3D0xe2-debian-10.4-x86_64-20200603.cgz-bcf876870b955=
92b52519ed4aafcf9d95999bc9c-20201226-1429-g4u7i0-0.cgz -N -P /opt/rootfs/tm=
p/lkp/jobs/scheduled/lkp-skl-d04
[  162.936436]=20
[  162.936681] 22 blocks
[  162.966051]=20
[  162.968198] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/user/lkp/lkp-x86_64.c=
gz -N -P /opt/rootfs/tmp/osimage/user/lkp
[  162.969801]=20
[  162.988840] /opt/rootfs/tmp/osimage/user/lkp/lkp-x86_64.cgz isn't modifi=
ed
[  162.988841]=20
[  163.002717] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/deps/debian-10.4-x86_=
64-20200603.cgz/run-ipconfig_20200608.cgz -N -P /opt/rootfs/tmp/osimage/dep=
s/debian-10.4-x86_64-20200603.cgz
[  163.002719]=20
[  163.028313] /opt/rootfs/tmp/osimage/deps/debian-10.4-x86_64-20200603.cgz=
/run-ipconfig_20200608.cgz isn't modified
[  163.028314]=20
[  163.044992] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/deps/debian-10.4-x86_=
64-20200603.cgz/lkp_20201211.cgz -N -P /opt/rootfs/tmp/osimage/deps/debian-=
10.4-x86_64-20200603.cgz
[  163.044993]=20
[  163.069417] /opt/rootfs/tmp/osimage/deps/debian-10.4-x86_64-20200603.cgz=
/lkp_20201211.cgz isn't modified
[  163.069418]=20
[  163.085370] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/deps/debian-10.4-x86_=
64-20200603.cgz/rsync-rootfs_20200608.cgz -N -P /opt/rootfs/tmp/osimage/dep=
s/debian-10.4-x86_64-20200603.cgz
[  163.085371]=20
[  163.110809] /opt/rootfs/tmp/osimage/deps/debian-10.4-x86_64-20200603.cgz=
/rsync-rootfs_20200608.cgz isn't modified
[  163.110810]=20
[  163.127488] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/deps/debian-10.4-x86_=
64-20200603.cgz/hwsim_20201110.cgz -N -P /opt/rootfs/tmp/osimage/deps/debia=
n-10.4-x86_64-20200603.cgz
[  163.127489]=20
[  163.314539] /opt/rootfs/tmp/osimage/deps/debian-10.4-x86_64-20200603.cgz=
/hwsim_20201110.cgz isn't modified
[  163.314541]=20
[  163.331135] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/pkg/debian-10.4-x86_6=
4-20200603.cgz/hwsim-x86_64-537ab94-1_20201123.cgz -N -P /opt/rootfs/tmp/os=
image/pkg/debian-10.4-x86_64-20200603.cgz
[  163.331136]=20
[  163.357474] /opt/rootfs/tmp/osimage/pkg/debian-10.4-x86_64-20200603.cgz/=
hwsim-x86_64-537ab94-1_20201123.cgz isn't modified
[  163.357475]=20
[  163.375188] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/deps/debian-10.4-x86_=
64-20200603.cgz/hw_20200715.cgz -N -P /opt/rootfs/tmp/osimage/deps/debian-1=
0.4-x86_64-20200603.cgz
[  163.375189]=20
[  163.399666] /opt/rootfs/tmp/osimage/deps/debian-10.4-x86_64-20200603.cgz=
/hw_20200715.cgz isn't modified
[  163.399668]=20
[  163.417104] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/pkg/linux/x86_64-rhel-8.3/gcc=
-9/bcf876870b95592b52519ed4aafcf9d95999bc9c/modules.cgz -N -P /opt/rootfs/t=
mp/pkg/linux/x86_64-rhel-8.3/gcc-9/bcf876870b95592b52519ed4aafcf9d95999bc9c
[  163.417105]=20
[  163.679305] /opt/rootfs/tmp/pkg/linux/x86_64-rhel-8.3/gcc-9/bcf876870b95=
592b52519ed4aafcf9d95999bc9c/modules.cgz isn't modified
[  163.679308]=20
[  163.696313] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/osimage/ucode/intel-ucode-202=
01117.cgz -N -P /opt/rootfs/tmp/osimage/ucode
[  163.696315]=20
[  163.715750] /opt/rootfs/tmp/osimage/ucode/intel-ucode-20201117.cgz isn't=
 modified
[  163.715751]=20
[  164.604333] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-22-ucode=3D0xe2-de=
bian-10.4-x86_64-20200603.cgz-bcf876870b95592b52519ed4aafcf9d95999bc9c-2020=
1226-1429-g4u7i0-0.yaml&last_kernel=3D5.10.0-rc3-01127-g8c3b1ba0e7ea -O /de=
v/null
[  164.604335]=20
[  165.104519] /usr/bin/wget -q --timeout=3D1800 --tries=3D1 --local-encodi=
ng=3DUTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-va=
r?job_file=3D/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-22-ucode=3D0xe2-de=
bian-10.4-x86_64-20200603.cgz-bcf876870b95592b52519ed4aafcf9d95999bc9c-2020=
1226-1429-g4u7i0-0.yaml&job_state=3Dbooting -O /dev/null
[  165.104521]=20
[  165.663906] LKP: kexec loading...
[  165.663908]=20
[  165.672092] kexec --noefi -l /opt/rootfs/tmp/pkg/linux/x86_64-rhel-8.3/g=
cc-9/bcf876870b95592b52519ed4aafcf9d95999bc9c/vmlinuz-5.8.0 --initrd=3D/opt=
/rootfs/tmp/initrd-concatenated
[  165.672093]=20
[  168.641536] --append=3Dip=3D::::lkp-skl-d04::dhcp root=3D/dev/ram0 user=
=3Dlkp job=3D/lkp/jobs/scheduled/lkp-skl-d04/hwsim-group-22-ucode=3D0xe2-de=
bian-10.4-x86_64-20200603.cgz-bcf876870b95592b52519ed4aafcf9d95999bc9c-2020=
1226-1429-g4u7i0-0.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-8.3 branch=3Din=
ternal-devel/devel-hourly-2020122418 commit=3Dbcf876870b95592b52519ed4aafcf=
9d95999bc9c BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3/gcc-9/bcf876870b95592b5=
2519ed4aafcf9d95999bc9c/vmlinuz-5.8.0 max_uptime=3D2100 RESULT_ROOT=3D/resu=
lt/hwsim/group-22-ucode=3D0xe2/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/=
x86_64-rhel-8.3/gcc-9/bcf876870b95592b52519ed4aafcf9d95999bc9c/25 LKP_SERVE=
R=3Dinternal-lkp-server nokaslr selinux=3D0 debug apic=3Ddebug sysrq_always=
_enabled rcupdate.rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkms=
g=3Don panic=3D-1 softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic lo=
ad_ramdisk=3D2 prompt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_lev
[  168.641539]=20
LKP: rebooting
[  169.708755] e1000e 0000:00:1f.6 eth0: NIC Link is Down
[  169.713966] kvm: exiting hardware virtualization
[  169.718708] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
[  169.723948] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  169.729419] e1000e: EEE TX LPI TIMER: 00000011
Starting new kernel

--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=perf-sanity-tests
Content-Transfer-Encoding: quoted-printable

2020-12-24 12:50:16 make ARCH=3D EXTRA_CFLAGS=3D-fno-omit-frame-pointer -fs=
anitize=3Dundefined -fsanitize=3Daddress -C /usr/src/perf_selftests-x86_64-=
rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e=
7ea9a80b0ee4b4445ea59c806787813/tools/perf'
  BUILD:   Doing 'make =1B[33m-j4=1B[m' parallel build
  HOSTCC   fixdep.o
  HOSTLD   fixdep-in.o
  LINK     fixdep
diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
diff -u tools/arch/x86/lib/memset_64.S arch/x86/lib/memset_64.S

Auto-detecting system features:
=2E..                         dwarf: [ =1B[32mon=1B[m  ]
=2E..            dwarf_getlocations: [ =1B[32mon=1B[m  ]
=2E..                         glibc: [ =1B[32mon=1B[m  ]
=2E..                        libbfd: [ =1B[32mon=1B[m  ]
=2E..                libbfd-buildid: [ =1B[32mon=1B[m  ]
=2E..                        libcap: [ =1B[32mon=1B[m  ]
=2E..                        libelf: [ =1B[32mon=1B[m  ]
=2E..                       libnuma: [ =1B[32mon=1B[m  ]
=2E..        numa_num_possible_cpus: [ =1B[32mon=1B[m  ]
=2E..                       libperl: [ =1B[32mon=1B[m  ]
=2E..                     libpython: [ =1B[32mon=1B[m  ]
=2E..                     libcrypto: [ =1B[32mon=1B[m  ]
=2E..                     libunwind: [ =1B[32mon=1B[m  ]
=2E..            libdw-dwarf-unwind: [ =1B[32mon=1B[m  ]
=2E..                          zlib: [ =1B[32mon=1B[m  ]
=2E..                          lzma: [ =1B[32mon=1B[m  ]
=2E..                     get_cpuid: [ =1B[32mon=1B[m  ]
=2E..                           bpf: [ =1B[32mon=1B[m  ]
=2E..                        libaio: [ =1B[32mon=1B[m  ]
=2E..                       libzstd: [ =1B[32mon=1B[m  ]
=2E..        disassembler-four-args: [ =1B[32mon=1B[m  ]

  CC       fd/array.o
  CC       exec-cmd.o
  CC       event-parse.o
  CC       core.o
  LD       fd/libapi-in.o
  CC       fs/fs.o
  CC       cpumap.o
  CC       help.o
  CC       fs/tracing_path.o
  CC       fs/cgroup.o
  LD       fs/libapi-in.o
  CC       cpu.o
  CC       threadmap.o
  CC       debug.o
  CC       pager.o
  CC       str_error_r.o
  LD       libapi-in.o
  AR       libapi.a
  CC       parse-options.o
  CC       event-plugin.o
  CC       evsel.o
  CC       trace-seq.o
  CC       parse-filter.o
  CC       evlist.o
  CC       mmap.o
  CC       parse-utils.o
  CC       kbuffer-parse.o
  CC       zalloc.o
  CC       tep_strerror.o
  CC       event-parse-api.o
  CC       xyarray.o
  LD       libtraceevent-in.o
  LINK     libtraceevent.a
  CC       lib.o
  GEN      bpf_helper_defs.h
  MKDIR    staticobjs/
  CC       staticobjs/libbpf.o
  LD       libperf-in.o
  AR       libperf.a
  GEN      common-cmds.h
  CC       run-command.o
  CC       sigchain.o
  CC       subcmd-config.o
  LD       libsubcmd-in.o
  MKDIR    staticobjs/
  AR       libsubcmd.a
  CC       staticobjs/bpf.o
  CC       staticobjs/nlattr.o
  CC       staticobjs/btf.o
  HOSTCC   pmu-events/json.o
  HOSTCC   pmu-events/jsmn.o
  HOSTCC   pmu-events/jevents.o
  HOSTLD   pmu-events/jevents-in.o
  CC       plugin_jbd2.o
  LD       plugin_jbd2-in.o
  CC       plugin_hrtimer.o
  LD       plugin_hrtimer-in.o
  CC       plugin_kmem.o
  LD       plugin_kmem-in.o
  CC       plugin_kvm.o
  LD       plugin_kvm-in.o
  CC       staticobjs/libbpf_errno.o
  CC       plugin_mac80211.o
  CC       staticobjs/str_error.o
  CC       staticobjs/netlink.o
  LD       plugin_mac80211-in.o
  CC       plugin_sched_switch.o
  LD       plugin_sched_switch-in.o
  CC       plugin_function.o
  CC       staticobjs/bpf_prog_linfo.o
  LD       plugin_function-in.o
  CC       plugin_futex.o
  CC       staticobjs/libbpf_probes.o
  LD       plugin_futex-in.o
  CC       plugin_xen.o
  CC       staticobjs/xsk.o
  LD       plugin_xen-in.o
  CC       plugin_scsi.o
  CC       staticobjs/hashmap.o
  LD       plugin_scsi-in.o
  CC       plugin_tlb.o
  CC       plugin_cfg80211.o
  CC       jvmti/libjvmti.o
  LD       plugin_cfg80211-in.o
  GEN      perf-archive
  LD       plugin_tlb-in.o
  LINK     plugin_jbd2.so
  GEN      perf-with-kcore
  CC       jvmti/jvmti_agent.o
  CC       staticobjs/btf_dump.o
  LINK     plugin_hrtimer.so
  LINK     plugin_kmem.so
  LINK     plugin_kvm.so
  LINK     plugin_mac80211.so
  CC       staticobjs/ringbuf.o
  LINK     plugin_sched_switch.so
  LINK     plugin_function.so
  LINK     plugin_futex.so
  LINK     plugin_xen.so
  LD       staticobjs/libbpf-in.o
  LINK     libbpf.a
  LINK     plugin_scsi.so
  CC       jvmti/libstring.o
  LINK     plugin_cfg80211.so
  CC       builtin-bench.o
  LINK     plugin_tlb.so
  GEN      libtraceevent-dynamic-list
  CC       jvmti/libctype.o
  CC       builtin-annotate.o
  CC       builtin-config.o
  LD       jvmti/jvmti-in.o
  CC       builtin-diff.o
  LINK     pmu-events/jevents
  CC       builtin-evlist.o
  CC       builtin-ftrace.o
  LINK     libperf-jvmti.so
  CC       builtin-help.o
  CC       builtin-sched.o
  CC       builtin-buildid-list.o
  CC       builtin-buildid-cache.o
  CC       builtin-kallsyms.o
  CC       builtin-list.o
  CC       builtin-record.o
  CC       builtin-report.o
  CC       builtin-stat.o
  CC       builtin-timechart.o
  CC       builtin-top.o
  CC       builtin-script.o
  CC       builtin-kmem.o
  CC       builtin-lock.o
  CC       builtin-kvm.o
  CC       builtin-inject.o
  CC       builtin-mem.o
  CC       builtin-data.o
  CC       builtin-version.o
  CC       builtin-c2c.o
  CC       builtin-trace.o
  CC       builtin-probe.o
  CC       bench/sched-messaging.o
  CC       bench/sched-pipe.o
  CC       bench/syscall.o
  CC       bench/mem-functions.o
  CC       bench/futex-hash.o
  CC       bench/futex-wake.o
  CC       bench/futex-wake-parallel.o
  CC       bench/futex-requeue.o
  CC       bench/futex-lock-pi.o
  CC       tests/builtin-test.o
  CC       bench/epoll-wait.o
  CC       bench/epoll-ctl.o
  CC       tests/parse-events.o
  CC       util/annotate.o
  CC       bench/synthesize.o
  CC       bench/kallsyms-parse.o
  CC       bench/find-bit-bench.o
  CC       bench/inject-buildid.o
  CC       bench/mem-memcpy-x86-64-asm.o
  CC       bench/mem-memset-x86-64-asm.o
  CC       bench/numa.o
  CC       tests/dso-data.o
  CC       tests/attr.o
  CC       tests/vmlinux-kallsyms.o
  LD       bench/perf-in.o
  CC       arch/common.o
  CC       tests/openat-syscall.o
  CC       arch/x86/util/header.o
  CC       tests/openat-syscall-all-cpus.o
  CC       arch/x86/util/tsc.o
  CC       arch/x86/util/pmu.o
  CC       tests/openat-syscall-tp-fields.o
  CC       arch/x86/util/kvm-stat.o
  CC       tests/mmap-basic.o
  CC       arch/x86/util/perf_regs.o
  CC       arch/x86/util/topdown.o
  CC       tests/perf-record.o
  CC       arch/x86/util/machine.o
  CC       arch/x86/tests/regs_load.o
  CC       arch/x86/tests/dwarf-unwind.o
  CC       util/block-info.o
  CC       arch/x86/tests/arch-tests.o
  CC       arch/x86/util/event.o
  CC       arch/x86/tests/rdpmc.o
  CC       tests/evsel-roundtrip-name.o
  CC       arch/x86/util/dwarf-regs.o
  CC       arch/x86/util/unwind-libunwind.o
  CC       arch/x86/tests/perf-time-to-tsc.o
  CC       arch/x86/util/auxtrace.o
  CC       tests/evsel-tp-sched.o
  CC       arch/x86/util/archinsn.o
  CC       tests/fdarray.o
  CC       arch/x86/tests/insn-x86.o
  CC       arch/x86/util/intel-pt.o
  CC       arch/x86/tests/intel-pt-pkt-decoder-test.o
  CC       tests/pmu.o
  CC       arch/x86/tests/bp-modify.o
  CC       util/block-range.o
  CC       tests/pmu-events.o
  LD       arch/x86/tests/perf-in.o
  CC       tests/hists_common.o
  CC       tests/hists_link.o
  CC       util/build-id.o
  CC       ui/setup.o
  CC       tests/hists_filter.o
  CC       arch/x86/util/intel-bts.o
  CC       ui/helpline.o
  CC       ui/progress.o
  CC       ui/util.o
  CC       ui/hist.o
  CC       tests/hists_output.o
  CC       util/cacheline.o
  CC       util/config.o
  LD       arch/x86/util/perf-in.o
  LD       arch/x86/perf-in.o
  LD       arch/perf-in.o
  CC       tests/hists_cumulate.o
  CC       util/copyfile.o
  CC       util/ctype.o
  CC       util/db-export.o
  CC       tests/python-use.o
  CC       tests/bp_signal.o
  CC       tests/bp_signal_overflow.o
  CC       tests/bp_account.o
  CC       tests/wp.o
  CC       tests/task-exit.o
  CC       tests/sw-clock.o
  CC       tests/mmap-thread-lookup.o
  CC       util/env.o
  CC       scripts/perl/Perf-Trace-Util/Context.o
  CC       tests/thread-maps-share.o
  CC       util/event.o
  CC       tests/switch-tracking.o
  LD       scripts/perl/Perf-Trace-Util/perf-in.o
  CC       scripts/python/Perf-Trace-Util/Context.o
  LD       scripts/python/Perf-Trace-Util/perf-in.o
  LD       scripts/perf-in.o
  CC       trace/beauty/clone.o
  CC       tests/keep-tracking.o
  CC       trace/beauty/fcntl.o
  CC       tests/code-reading.o
  CC       trace/beauty/flock.o
  CC       util/evlist.o
  CC       trace/beauty/fsmount.o
  CC       trace/beauty/fspick.o
  CC       trace/beauty/ioctl.o
  CC       trace/beauty/kcmp.o
  CC       trace/beauty/mount_flags.o
  CC       trace/beauty/move_mount.o
  CC       trace/beauty/pkey_alloc.o
  CC       tests/sample-parsing.o
  CC       trace/beauty/arch_prctl.o
  CC       trace/beauty/prctl.o
  CC       trace/beauty/renameat.o
  CC       trace/beauty/sockaddr.o
  CC       trace/beauty/socket.o
  CC       trace/beauty/statx.o
  CC       tests/parse-no-sample-id-all.o
  CC       trace/beauty/sync_file_range.o
  CC       tests/kmod-path.o
  CC       trace/beauty/tracepoints/x86_irq_vectors.o
  CC       trace/beauty/tracepoints/x86_msr.o
  LD       trace/beauty/tracepoints/perf-in.o
  LD       trace/beauty/perf-in.o
  CC       perf.o
  CC       tests/thread-map.o
  CC       tests/llvm.o
  CC       tests/bpf.o
  CC       util/sideband_evlist.o
  CC       util/evsel.o
  CC       util/evsel_fprintf.o
  CC       tests/topology.o
  CC       tests/mem.o
  CC       tests/cpumap.o
  CC       tests/stat.o
  CC       tests/event_update.o
  CC       ui/stdio/hist.o
  CC       util/perf_event_attr_fprintf.o
  CC       tests/event-times.o
  CC       tests/expr.o
  CC       util/evswitch.o
  CC       tests/backward-ring-buffer.o
  CC       util/find_bit.o
  CC       tests/sdt.o
  CC       util/get_current_dir_name.o
  CC       util/kallsyms.o
  CC       tests/is_printable_array.o
  CC       tests/bitmap.o
  CC       util/levenshtein.o
  CC       ui/browser.o
  CC       tests/perf-hooks.o
  CC       tests/clang.o
  CC       util/llvm-utils.o
  CC       tests/unit_number__scnprintf.o
  CC       tests/mem2node.o
  CC       tests/maps.o
  CC       util/mmap.o
  CC       tests/time-utils-test.o
  CC       util/memswap.o
  CC       ui/browsers/annotate.o
  BISON    util/parse-events-bison.c
  CC       util/perf_regs.o
  CC       util/path.o
  CC       tests/genelf.o
  CC       ui/browsers/hists.o
  CC       tests/api-io.o
  CC       tests/demangle-java-test.o
  CC       tests/pfm.o
  CC       tests/parse-metric.o
  CC       util/print_binary.o
  CC       util/rlimit.o
  CC       tests/pe-file-parsing.o
  CC       util/argv_split.o
  CC       tests/expand-cgroup.o
  CC       ui/browsers/map.o
  CC       util/rbtree.o
  CC       ui/browsers/scripts.o
  CC       tests/dwarf-unwind.o
  CC       ui/browsers/header.o
  CC       tests/llvm-src-base.o
  CC       tests/llvm-src-kbuild.o
  CC       tests/llvm-src-prologue.o
  CC       tests/llvm-src-relocation.o
  CC       ui/browsers/res_sample.o
  LD       tests/perf-in.o
  CC       util/libstring.o
  CC       util/bitmap.o
  CC       util/hweight.o
  CC       util/smt.o
  CC       ui/tui/setup.o
  CC       util/strbuf.o
  CC       util/string.o
  CC       ui/tui/util.o
  CC       util/strlist.o
  CC       util/strfilter.o
  CC       ui/tui/helpline.o
  CC       util/top.o
  CC       ui/tui/progress.o
  LD       ui/tui/perf-in.o
  CC       util/usage.o
  CC       util/dso.o
  CC       util/dsos.o
  CC       util/symbol.o
  CC       util/symbol_fprintf.o
  CC       util/color.o
  CC       util/color_config.o
  CC       util/metricgroup.o
  CC       util/header.o
  CC       util/callchain.o
  CC       util/values.o
  CC       util/debug.o
  CC       util/fncache.o
  CC       util/machine.o
  CC       util/map.o
  CC       util/pstack.o
  CC       util/session.o
  CC       util/sample-raw.o
  CC       util/s390-sample-raw.o
  CC       util/syscalltbl.o
  CC       util/ordered-events.o
  CC       util/namespaces.o
  LD       ui/browsers/perf-in.o
  LD       ui/perf-in.o
  CC       util/comm.o
  CC       util/thread.o
  CC       util/thread_map.o
  CC       util/trace-event-parse.o
  CC       util/parse-events-bison.o
  BISON    util/pmu-bison.c
  CC       util/trace-event-read.o
  CC       util/trace-event-info.o
  GEN      python/perf.so
  CC       util/trace-event-scripting.o
  CC       util/trace-event.o
  CC       util/svghelper.o
  CC       util/sort.o
  CC       util/hist.o
  CC       util/util.o
  CC       util/cpumap.o
  CC       util/affinity.o
  CC       util/cputopo.o
  CC       util/cgroup.o
  CC       util/target.o
  CC       util/rblist.o
  CC       util/intlist.o
  CC       util/vdso.o
  CC       util/counts.o
  CC       util/stat.o
  CC       util/stat-shadow.o
  CC       util/stat-display.o
  CC       util/perf_api_probe.o
  CC       util/record.o
  CC       util/srcline.o
  CC       util/srccode.o
  CC       util/synthetic-events.o
  CC       util/data.o
  CC       util/tsc.o
  CC       util/cloexec.o
  CC       util/call-path.o
  CC       util/rwsem.o
  CC       util/thread-stack.o
  CC       util/spark.o
  CC       util/topdown.o
  CC       util/stream.o
  CC       util/auxtrace.o
  CC       util/intel-pt-decoder/intel-pt-pkt-decoder.o
  GEN      util/intel-pt-decoder/inat-tables.c
  CC       util/intel-pt-decoder/intel-pt-log.o
  CC       util/intel-pt-decoder/intel-pt-decoder.o
  CC       util/arm-spe-decoder/arm-spe-pkt-decoder.o
  CC       util/arm-spe-decoder/arm-spe-decoder.o
  LD       util/arm-spe-decoder/perf-in.o
  CC       util/scripting-engines/trace-event-perl.o
  GEN      pmu-events/pmu-events.c
  CC       pmu-events/pmu-events.o
  CC       util/scripting-engines/trace-event-python.o
  CC       util/intel-pt.o
  LD       pmu-events/pmu-events-in.o
  CC       util/intel-bts.o
  CC       util/arm-spe.o
  CC       util/intel-pt-decoder/intel-pt-insn-decoder.o
  LD       util/scripting-engines/perf-in.o
  CC       util/s390-cpumsf.o
  CC       util/parse-branch-options.o
  CC       util/dump-insn.o
  CC       util/parse-regs-options.o
  CC       util/parse-sublevel-options.o
  CC       util/term.o
  CC       util/help-unknown-cmd.o
  CC       util/mem-events.o
  CC       util/vsprintf.o
  LD       util/intel-pt-decoder/perf-in.o
  CC       util/units.o
  CC       util/time-utils.o
  BISON    util/expr-bison.c
  CC       util/branch.o
  CC       util/mem2node.o
  CC       util/clockid.o
  CC       util/bpf-loader.o
  CC       util/bpf_map.o
  CC       util/bpf-prologue.o
  CC       util/symbol-elf.o
  CC       util/probe-file.o
  CC       util/probe-event.o
  CC       util/probe-finder.o
  CC       util/dwarf-aux.o
  CC       util/dwarf-regs.o
  CC       util/unwind-libunwind-local.o
  CC       util/unwind-libunwind.o
  CC       util/data-convert-bt.o
  CC       util/zlib.o
  CC       util/lzma.o
  CC       util/zstd.o
  CC       util/cap.o
  CC       util/demangle-java.o
  CC       util/demangle-rust.o
  CC       util/jitdump.o
  CC       util/genelf.o
  CC       util/genelf_debug.o
  CC       util/perf-hooks.o
  CC       util/bpf-event.o
  FLEX     util/parse-events-flex.c
  FLEX     util/pmu-flex.c
  CC       util/pmu-bison.o
  FLEX     util/expr-flex.c
  CC       util/expr-bison.o
  CC       util/expr.o
  CC       util/parse-events.o
  CC       util/parse-events-flex.o
  CC       util/pmu.o
  CC       util/pmu-flex.o
  CC       util/expr-flex.o
  LD       util/perf-in.o
  LD       perf-in.o
  LINK     perf
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf'
2020-12-24 12:51:30 cd /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea=
9a80b0ee4b4445ea59c806787813/tools/perf
2020-12-24 12:51:30 mkdir -p /pkg
2020-12-24 12:51:30 mkdir -p /kbuild/obj/consumer/x86_64-rhel-8.3
2020-12-24 12:51:30 cp /pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0e=
e4b4445ea59c806787813/vmlinux.xz /tmp
2020-12-24 12:51:31 unxz -k /tmp/vmlinux.xz
2020-12-24 12:51:35 cp /tmp/vmlinux /kbuild/obj/consumer/x86_64-rhel-8.3
ignored_by_lkp: BPF filter
ignored_by_lkp: LLVM search and compile
ignored_by_lkp: Add vfs_getname probe to get syscall args filenames
ignored_by_lkp: Use vfs_getname probe to get syscall args filenames
ignored_by_lkp: Check open filename arg using perf trace + vfs_getname
ignored_by_lkp: builtin clang support
2020-12-24 12:51:35 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 1
 1: vmlinux symtab matches kallsyms                                 : Ok
2020-12-24 12:51:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 2
 2: Detect openat syscall event                                     : Ok
2020-12-24 12:51:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 3
 3: Detect openat syscall event on all cpus                         : Ok
2020-12-24 12:51:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 4
 4: Read samples using the mmap interface                           : FAILE=
D!
2020-12-24 12:51:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 5
 5: Test data source output                                         : Ok
2020-12-24 12:51:36 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 6
 6: Parse event definition strings                                  : FAILE=
D!
2020-12-24 12:51:37 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 7
 7: Simple expression parser                                        : Ok
2020-12-24 12:51:38 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 8
 8: PERF_RECORD_* events & perf_sample fields                       : Ok
2020-12-24 12:51:40 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 9
 9: Parse perf pmu format                                           : Ok
2020-12-24 12:51:40 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 10
10: PMU events                                                      :
10.1: PMU event table sanity                                        : Ok
10.2: PMU event map aliases                                         : Ok
10.3: Parsing of PMU event table metrics                            : Skip =
(some metrics failed)
10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
2020-12-24 12:51:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 11
11: DSO data read                                                   : Ok
2020-12-24 12:51:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 12
12: DSO data cache                                                  : Ok
2020-12-24 12:51:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 13
13: DSO data reopen                                                 : Ok
2020-12-24 12:51:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 14
14: Roundtrip evsel->name                                           : Ok
2020-12-24 12:51:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 15
15: Parse sched tracepoints fields                                  : Ok
2020-12-24 12:51:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 16
16: syscalls:sys_enter_openat event fields                          : Ok
2020-12-24 12:51:42 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 17
17: Setup struct perf_event_attr                                    : Ok
2020-12-24 12:51:56 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 18
18: Match and link multiple hists                                   : Ok
2020-12-24 12:51:56 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 19
19: 'import perf' in python                                         : FAILE=
D!
2020-12-24 12:51:56 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 20
20: Breakpoint overflow signal handler                              : Ok
2020-12-24 12:51:56 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 21
21: Breakpoint overflow sampling                                    : Ok
2020-12-24 12:51:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 22
22: Breakpoint accounting                                           : Ok
2020-12-24 12:51:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 23
23: Watchpoint                                                      :
23.1: Read Only Watchpoint                                          : Skip
23.2: Write Only Watchpoint                                         : Ok
23.3: Read / Write Watchpoint                                       : Ok
23.4: Modify Watchpoint                                             : Ok
2020-12-24 12:51:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 24
24: Number of exit events of a simple workload                      : FAILE=
D!
2020-12-24 12:51:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 25
25: Software clock events period values                             : FAILE=
D!
2020-12-24 12:51:57 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 26
26: Object code reading                                             : FAILE=
D!
2020-12-24 12:52:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 27
27: Sample parsing                                                  : Ok
2020-12-24 12:52:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 28
28: Use a dummy software event to keep tracking                     : FAILE=
D!
2020-12-24 12:52:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 29
29: Parse with no sample_id_all bit set                             : Ok
2020-12-24 12:52:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 30
30: Filter hist entries                                             : Ok
2020-12-24 12:52:00 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 31
31: Lookup mmap thread                                              : FAILE=
D!
2020-12-24 12:52:01 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 32
32: Share thread maps                                               : Ok
2020-12-24 12:52:01 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 33
33: Sort output of hist entries                                     : Ok
2020-12-24 12:52:01 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 34
34: Cumulate child hist entries                                     : Ok
2020-12-24 12:52:01 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 35
35: Track with sched_switch                                         : FAILE=
D!
2020-12-24 12:52:01 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 36
36: Filter fds with revents mask in a fdarray                       : Ok
2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 37
37: Add fd to a fdarray, making it autogrow                         : Ok
2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 38
38: kmod_path__parse                                                : Ok
2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 39
39: Thread map                                                      : Ok
2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 41
41: Session topology                                                : FAILE=
D!
2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 43
43: Synthesize thread map                                           : FAILE=
D!
2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 44
44: Remove thread map                                               : FAILE=
D!
2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 45
45: Synthesize cpu map                                              : Ok
2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 46
46: Synthesize stat config                                          : Ok
2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 47
47: Synthesize stat                                                 : Ok
2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 48
48: Synthesize stat round                                           : Ok
2020-12-24 12:52:02 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 49
49: Synthesize attr update                                          : FAILE=
D!
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 50
50: Event times                                                     : Ok
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 51
51: Read backward ring buffer                                       : Ok
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 52
52: Print cpu map                                                   : FAILE=
D!
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 53
53: Merge cpu map                                                   : Ok
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 54
54: Probe SDT events                                                : Ok
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 55
55: is_printable_array                                              : Ok
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 56
56: Print bitmap                                                    : Ok
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 57
57: perf hooks                                                      : Ok
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 59
59: unit_number__scnprintf                                          : Ok
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 60
60: mem2node                                                        : Ok
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 61
61: time utils                                                      : Ok
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 62
62: Test jit_write_elf                                              : Ok
2020-12-24 12:52:03 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 63
63: Test libpfm4 support                                            : Skip =
(not compiled in)
2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 64
64: Test api io                                                     : Ok
2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 65
65: maps__merge_in                                                  : FAILE=
D!
2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 66
66: Demangle Java                                                   : Ok
2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 67
67: Parse and process metrics                                       : Ok
2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 68
68: PE file support                                                 : FAILE=
D!
2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 69
69: Event expansion for cgroups                                     : Ok
2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 70
70: x86 rdpmc                                                       : Ok
2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 71
71: Convert perf time to TSC                                        : FAILE=
D!
2020-12-24 12:52:04 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 72
72: DWARF unwind                                                    : FAILE=
D!
2020-12-24 12:52:05 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 73
73: x86 instruction decoder - new instructions                      : Ok
2020-12-24 12:52:05 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 74
74: Intel PT packet decoder                                         : Ok
2020-12-24 12:52:05 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 75
75: x86 bp modify                                                   : Ok
2020-12-24 12:52:05 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 76
76: probe libc's inet_pton & backtrace it with ping                 : Ok
2020-12-24 12:52:07 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 77
77: Check Arm CoreSight trace data recording and synthesized samples: Skip
2020-12-24 12:52:07 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 78
78: build id cache operations                                       : FAILE=
D!
2020-12-24 12:52:08 sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7=
ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 81
81: Zstd perf.data compression/decompression                        : FAILE=
D!

--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/perf-sanity-tests.yaml
suite: perf-sanity-tests
testcase: perf-sanity-tests
category: functional
need_memory: 2G
perf-sanity-tests:
  perf_compiler: gcc
job_origin: "/lkp-src/allot/cyclic:p1:linux-devel:devel-hourly/lkp-skl-d04/perf-sanity-tests.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d04
tbox_group: lkp-skl-d04
kconfig: x86_64-rhel-8.3
submit_id: 5fe3ff3470445544196c20e0
job_file: "/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813-20201224-17433-ad87v-0.yaml"
id: a36e0dfa5afd04a7db3aaf1a8c7028b3ae79bbe8
queuer_version: "/lkp-src"

#! hosts/lkp-skl-d04
model: Skylake
nr_cpu: 4
memory: 32G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/ata-ST1000DM003-1ER162_Z4YB7AEL-part*"
ssd_partitions: "/dev/disk/by-id/wwn-0x55cd2e404b64c499-part2"
rootfs_partition: "/dev/disk/by-id/wwn-0x55cd2e404b64c499-part1"
brand: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz

#! include/category/functional
kmsg: 
heartbeat: 
meminfo: 

#! include/perf-sanity-tests
need_linux_perf: true

#! include/queue/cyclic
commit: 8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813

#! include/testbox/lkp-skl-d04
need_kconfig_hw:
- CONFIG_E1000E=y
- CONFIG_SATA_AHCI
ucode: '0xe2'
enqueue_time: 2020-12-24 10:38:44.982170496 +08:00
_id: 5fe3ff3470445544196c20e0
_rt: "/result/perf-sanity-tests/gcc-ucode=0xe2/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: 1b32c6cf0d6c9a541f095fe99e23c9ecd80eee26
base_commit: 2c85ebc57b3e1817b6ce1a6b703928e113a90442
branch: linux-devel/devel-hourly-2020122300
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/perf-sanity-tests/gcc-ucode=0xe2/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/0"
scheduler_version: "/lkp/lkp/.src-20201224-092605"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-skl-d04/perf-sanity-tests-gcc-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813-20201224-17433-ad87v-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-2020122300
- commit=8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/vmlinuz-5.10.0-rc3-01127-g8c3b1ba0e7ea
- max_uptime=2100
- RESULT_ROOT=/result/perf-sanity-tests/gcc-ucode=0xe2/lkp-skl-d04/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/0
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/modules.cgz"
linux_perf_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/linux-perf.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf-sanity-tests_20201111.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-fa02fcd94b0c-1_20201126.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20201117.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20201222-091527/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.10.0-wt-g9d789f5d070b

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/vmlinuz-5.10.0-rc3-01127-g8c3b1ba0e7ea"
dequeue_time: 2020-12-24 12:52:40.297634523 +08:00

#! /lkp/lkp/.src-20201224-092605/include/site/inn
job_state: finished
loadavg: 1.82 1.10 0.44 1/136 9143
start_time: '1608781335'
end_time: '1608781450'
version: "/lkp/lkp/.src-20201224-092638:04492474:85b1a3dae"

--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

make ARCH= EXTRA_CFLAGS=-fno-omit-frame-pointer -fsanitize=undefined -fsanitize=address -C /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf
cd /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf
mkdir -p /pkg
mkdir -p /kbuild/obj/consumer/x86_64-rhel-8.3
cp /pkg/linux/x86_64-rhel-8.3/gcc-9/8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/vmlinux.xz /tmp
unxz -k /tmp/vmlinux.xz
cp /tmp/vmlinux /kbuild/obj/consumer/x86_64-rhel-8.3
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 1
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 2
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 3
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 4
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 5
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 6
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 7
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 8
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 9
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 10
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 11
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 12
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 13
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 14
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 15
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 16
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 17
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 18
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 19
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 20
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 21
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 22
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 23
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 24
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 25
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 26
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 27
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 28
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 29
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 30
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 31
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 32
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 33
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 34
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 35
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 36
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 37
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 38
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 39
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 41
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 43
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 44
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 45
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 46
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 47
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 48
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 49
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 50
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 51
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 52
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 53
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 54
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 55
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 56
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 57
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 59
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 60
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 61
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 62
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 63
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 64
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 65
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 66
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 67
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 68
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 69
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 70
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 71
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 72
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 73
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 74
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 75
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 76
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 77
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 78
sudo /usr/src/perf_selftests-x86_64-rhel-8.3-8c3b1ba0e7ea9a80b0ee4b4445ea59c806787813/tools/perf/perf test 81

--8nsIa27JVQLqB7/C--
