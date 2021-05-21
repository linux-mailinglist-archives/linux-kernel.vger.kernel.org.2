Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543E938BC5F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 04:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbhEUCXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 22:23:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:45678 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhEUCXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 22:23:15 -0400
IronPort-SDR: vVfc6YbJ6CctAVjVZ5wwCMFK0VJaH88Yb6Jvahn+u9hkpaV85TylljDWsRFUMLEtMWeuy+TjUj
 TCKGtZkjzUzw==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="201093211"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="xz'?yaml'?scan'208";a="201093211"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 19:21:50 -0700
IronPort-SDR: WDYqjDCXNpom/br570rDuhpiuu+GtGanjLg/Q/mZWIkw2Apk9U6lLBo78x+ammH10arQMpdise
 MTujUma4rO1Q==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="xz'?yaml'?scan'208";a="474305878"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 19:21:44 -0700
Date:   Fri, 21 May 2021 10:38:34 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Marco Elver <elver@google.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: [tools headers UAPI]  71d7924b3e:
 kmsg.sanitizer.util/parse-events.c:#:#:runtime_error:load_of_null_pointer_of_type'const_char'
Message-ID: <20210521023833.GB25531@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: 71d7924b3e8acaca6a3b0fc3261170031ada3b70 ("tools headers UAPI: Sync=
 perf_event.h with the kernel sources")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


in testcase: perf-test
version: perf-test-x86_64-git-1_20210508
with following parameters:

	type: lkp
	ucode: 0xde

test-description: The internal Perf Test suite.


on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GH=
z with 32G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/ba=
cktrace):




If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>

CPU architecture is skylake
2021-05-20 08:55:33 make ARCH=3D DEBUG=3D1 EXTRA_CFLAGS=3D-fno-omit-frame-p=
ointer -fsanitize=3Dundefined -fsanitize=3Daddress -C /usr/src/linux-perf-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-71d7924b3=
e8acaca6a3b0fc3261170031ada3b70/tools/perf'
  BUILD:   Doing 'make =1B[33m-j8=1B[m' parallel build
  HOSTCC   fixdep.o
  HOSTLD   fixdep-in.o
  LINK     fixdep

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

=2E..                      /tmp/lkp: [ =1B[31mOFF=1B[m ]

  GEN      common-cmds.h
  CC       fd/array.o
  CC       exec-cmd.o
  CC       event-parse.o
  CC       core.o
  CC       cpumap.o
  CC       event-plugin.o
  GEN      bpf_helper_defs.h
  MKDIR    staticobjs/
  CC       trace-seq.o
  CC       staticobjs/libbpf.o
  CC       help.o
  LD       fd/libapi-in.o
  CC       fs/fs.o
  CC       threadmap.o
  CC       parse-filter.o
  CC       parse-utils.o
  CC       kbuffer-parse.o
  CC       fs/tracing_path.o
  CC       evsel.o
  CC       pager.o
  CC       parse-options.o
  CC       fs/cgroup.o
  CC       evlist.o
  LD       fs/libapi-in.o
  CC       tep_strerror.o
  CC       cpu.o
  CC       mmap.o
  CC       event-parse-api.o
  CC       debug.o
  CC       str_error_r.o
  LD       libapi-in.o
  CC       zalloc.o
  AR       libapi.a
  CC       run-command.o
  CC       sigchain.o
  CC       subcmd-config.o
  CC       xyarray.o
  CC       lib.o
  MKDIR    staticobjs/
  CC       staticobjs/bpf.o
  CC       staticobjs/nlattr.o
  LD       libperf-in.o
  LD       libsubcmd-in.o
  AR       libperf.a
  CC       staticobjs/btf.o
  AR       libsubcmd.a
  CC       staticobjs/libbpf_errno.o
  CC       staticobjs/str_error.o
  CC       staticobjs/netlink.o
  CC       staticobjs/bpf_prog_linfo.o
  CC       staticobjs/libbpf_probes.o
  CC       staticobjs/xsk.o
  CC       staticobjs/hashmap.o
  CC       staticobjs/btf_dump.o
  CC       staticobjs/ringbuf.o
  CC       staticobjs/strset.o
  CC       staticobjs/linker.o
  HOSTCC   pmu-events/json.o
  HOSTCC   pmu-events/jsmn.o
  CC       plugin_jbd2.o
  HOSTCC   pmu-events/jevents.o
  LD       plugin_jbd2-in.o
  CC       plugin_hrtimer.o
  LD       libtraceevent-in.o
  CC       plugin_kmem.o
  LD       plugin_hrtimer-in.o
  LINK     libtraceevent.a
  CC       jvmti/libjvmti.o
  CC       plugin_kvm.o
  LD       plugin_kmem-in.o
  GEN      perf-archive
  CC       plugin_mac80211.o
  HOSTLD   pmu-events/jevents-in.o
  CC       plugin_sched_switch.o
  LD       plugin_mac80211-in.o
  GEN      perf-with-kcore
  LD       plugin_kvm-in.o
  GEN      perf-iostat
  CC       plugin_function.o
  CC       jvmti/jvmti_agent.o
  LD       plugin_sched_switch-in.o
  CC       jvmti/libstring.o
  CC       plugin_futex.o
  LD       plugin_function-in.o
  CC       jvmti/libctype.o
  CC       plugin_xen.o
  LD       plugin_futex-in.o
  CC       plugin_scsi.o
  CC       plugin_cfg80211.o
  LD       jvmti/jvmti-in.o
  CC       plugin_tlb.o
  LINK     pmu-events/jevents
  LINK     libperf-jvmti.so
  LD       plugin_cfg80211-in.o
  LINK     plugin_jbd2.so
  LD       plugin_xen-in.o
  LD       plugin_tlb-in.o
  LINK     plugin_hrtimer.so
  LINK     plugin_kmem.so
  LINK     plugin_kvm.so
  LINK     plugin_mac80211.so
  LINK     plugin_sched_switch.so
  LINK     plugin_function.so
  GEN      pmu-events/pmu-events.c
  LINK     plugin_futex.so
  LINK     plugin_xen.so
  LINK     plugin_cfg80211.so
  LD       plugin_scsi-in.o
  LINK     plugin_tlb.so
  LINK     plugin_scsi.so
  CC       builtin-bench.o
  CC       builtin-annotate.o
  CC       builtin-config.o
  CC       builtin-diff.o
  GEN      libtraceevent-dynamic-list
  CC       builtin-evlist.o
  CC       builtin-ftrace.o
  CC       builtin-help.o
  CC       pmu-events/pmu-events.o
  CC       builtin-sched.o
  CC       builtin-buildid-list.o
  CC       builtin-buildid-cache.o
  CC       builtin-kallsyms.o
  CC       builtin-list.o
  CC       builtin-record.o
  CC       builtin-report.o
  CC       builtin-stat.o
  GEN      python/perf.so
  CC       builtin-timechart.o
  LD       staticobjs/libbpf-in.o
  LINK     libbpf.a
  CC       builtin-top.o
  CC       builtin-script.o
  LD       pmu-events/pmu-events-in.o
  CC       builtin-kmem.o
  CC       builtin-lock.o
  CC       builtin-kvm.o
  CC       builtin-inject.o
  CC       builtin-mem.o
  CC       builtin-data.o
  CC       builtin-version.o
  CC       builtin-c2c.o
  CC       builtin-daemon.o
  CC       builtin-trace.o
  CC       builtin-probe.o
  CC       bench/sched-messaging.o
  CC       tests/builtin-test.o
  CC       bench/sched-pipe.o
  CC       bench/syscall.o
  CC       tests/parse-events.o
  CC       bench/mem-functions.o
  CC       bench/futex-hash.o
  CC       util/annotate.o
  CC       bench/futex-wake.o
  CC       bench/futex-wake-parallel.o
  CC       bench/futex-requeue.o
  CC       bench/futex-lock-pi.o
  CC       arch/common.o
  CC       arch/x86/util/header.o
  CC       bench/epoll-wait.o
  CC       arch/x86/tests/regs_load.o
  CC       tests/dso-data.o
  CC       arch/x86/util/tsc.o
  CC       arch/x86/tests/dwarf-unwind.o
  CC       arch/x86/util/pmu.o
  CC       arch/x86/tests/arch-tests.o
  CC       bench/epoll-ctl.o
  CC       arch/x86/tests/rdpmc.o
  CC       arch/x86/util/kvm-stat.o
  CC       arch/x86/util/perf_regs.o
  CC       arch/x86/tests/sample-parsing.o
  CC       arch/x86/util/topdown.o
  CC       bench/synthesize.o
  CC       arch/x86/util/machine.o
  CC       tests/attr.o
  CC       tests/vmlinux-kallsyms.o
  CC       arch/x86/tests/insn-x86.o
  CC       arch/x86/util/event.o
  CC       tests/openat-syscall.o
  CC       bench/kallsyms-parse.o
  CC       tests/openat-syscall-all-cpus.o
  CC       arch/x86/util/evlist.o
  CC       arch/x86/tests/intel-pt-pkt-decoder-test.o
  CC       tests/openat-syscall-tp-fields.o
  CC       bench/find-bit-bench.o
  CC       tests/mmap-basic.o
  CC       arch/x86/util/mem-events.o
  CC       arch/x86/tests/bp-modify.o
  CC       bench/inject-buildid.o
  CC       tests/perf-record.o
  CC       arch/x86/util/evsel.o
  CC       util/block-info.o
  CC       ui/setup.o
  LD       arch/x86/tests/perf-in.o
  CC       ui/helpline.o
  CC       arch/x86/util/iostat.o
  CC       arch/x86/util/dwarf-regs.o
  CC       tests/evsel-roundtrip-name.o
  CC       ui/progress.o
  CC       tests/evsel-tp-sched.o
  CC       tests/fdarray.o
  CC       bench/mem-memcpy-x86-64-asm.o
  CC       ui/util.o
  CC       bench/mem-memset-x86-64-asm.o
  CC       util/block-range.o
  CC       ui/hist.o
  CC       arch/x86/util/unwind-libunwind.o
  CC       tests/pmu.o
  CC       bench/numa.o
  CC       arch/x86/util/auxtrace.o
  CC       tests/pmu-events.o
  CC       tests/hists_common.o
  CC       tests/hists_link.o
  CC       util/build-id.o
  CC       arch/x86/util/archinsn.o
  CC       tests/hists_filter.o
  CC       arch/x86/util/intel-pt.o
  CC       tests/hists_output.o
  CC       ui/stdio/hist.o
  CC       ui/browser.o
  CC       util/cacheline.o
  CC       util/config.o
  CC       tests/hists_cumulate.o
  LD       bench/perf-in.o
  CC       scripts/perl/Perf-Trace-Util/Context.o
  CC       ui/browsers/annotate.o
  CC       ui/tui/setup.o
  CC       tests/python-use.o
  CC       arch/x86/util/intel-bts.o
  CC       util/copyfile.o
  CC       tests/bp_signal.o
  CC       ui/tui/util.o
  CC       util/ctype.o
  CC       tests/bp_signal_overflow.o
  CC       util/db-export.o
  CC       tests/bp_account.o
  CC       ui/tui/helpline.o
  LD       arch/x86/util/perf-in.o
  LD       scripts/perl/Perf-Trace-Util/perf-in.o
  CC       tests/wp.o
  CC       scripts/python/Perf-Trace-Util/Context.o
  CC       ui/browsers/hists.o
  LD       arch/x86/perf-in.o
  CC       tests/task-exit.o
  LD       arch/perf-in.o
  CC       ui/tui/progress.o
  CC       trace/beauty/clone.o
  CC       tests/sw-clock.o
  CC       util/env.o
  LD       ui/tui/perf-in.o
  CC       trace/beauty/fcntl.o
  CC       trace/beauty/flock.o
  LD       scripts/python/Perf-Trace-Util/perf-in.o
  CC       tests/mmap-thread-lookup.o
  LD       scripts/perf-in.o
  CC       perf.o
  CC       tests/thread-maps-share.o
  CC       trace/beauty/fsmount.o
  CC       trace/beauty/fspick.o
  CC       trace/beauty/ioctl.o
  CC       tests/switch-tracking.o
  CC       util/event.o
  CC       trace/beauty/kcmp.o
  CC       util/evlist.o
  CC       ui/browsers/map.o
  CC       trace/beauty/mount_flags.o
  CC       trace/beauty/move_mount.o
  CC       trace/beauty/pkey_alloc.o
  CC       trace/beauty/arch_prctl.o
  CC       ui/browsers/scripts.o
  CC       tests/keep-tracking.o
  CC       trace/beauty/prctl.o
  CC       trace/beauty/renameat.o
  CC       ui/browsers/header.o
  CC       ui/browsers/res_sample.o
  CC       trace/beauty/sockaddr.o
  CC       tests/code-reading.o
  CC       util/evlist-hybrid.o
  CC       trace/beauty/socket.o
  CC       trace/beauty/statx.o
  CC       tests/sample-parsing.o
  CC       trace/beauty/sync_file_range.o
  CC       tests/parse-no-sample-id-all.o
  CC       tests/kmod-path.o
  CC       util/sideband_evlist.o
  CC       trace/beauty/tracepoints/x86_irq_vectors.o
  CC       trace/beauty/tracepoints/x86_msr.o
  CC       util/evsel.o
  CC       tests/thread-map.o
  CC       tests/llvm.o
  LD       trace/beauty/tracepoints/perf-in.o
  LD       trace/beauty/perf-in.o
  CC       util/evsel_fprintf.o
  CC       tests/bpf.o
  CC       tests/topology.o
  CC       tests/mem.o
  CC       tests/cpumap.o
  LD       ui/browsers/perf-in.o
  LD       ui/perf-in.o
  CC       tests/stat.o
  CC       tests/event_update.o
  CC       util/perf_event_attr_fprintf.o
  CC       util/evswitch.o
  CC       tests/event-times.o
  CC       util/find_bit.o
  CC       tests/expr.o
  CC       util/get_current_dir_name.o
  CC       util/kallsyms.o
  CC       tests/backward-ring-buffer.o
  CC       util/levenshtein.o
  CC       util/llvm-utils.o
  CC       tests/sdt.o
  CC       tests/is_printable_array.o
  CC       tests/bitmap.o
  CC       util/mmap.o
  CC       util/memswap.o
  CC       tests/perf-hooks.o
  BISON    util/parse-events-bison.c
  CC       tests/clang.o
  CC       tests/unit_number__scnprintf.o
  CC       util/parse-events-hybrid.o
  CC       util/perf_regs.o
  CC       tests/mem2node.o
  CC       util/path.o
  CC       util/print_binary.o
  CC       tests/maps.o
  CC       util/rlimit.o
  CC       tests/time-utils-test.o
  CC       util/argv_split.o
  CC       tests/genelf.o
  CC       util/rbtree.o
  CC       tests/api-io.o
  CC       util/libstring.o
  CC       tests/demangle-java-test.o
  CC       tests/demangle-ocaml-test.o
  CC       util/bitmap.o
  CC       util/hweight.o
  CC       tests/pfm.o
  CC       tests/parse-metric.o
  CC       tests/pe-file-parsing.o
  CC       tests/expand-cgroup.o
  CC       tests/perf-time-to-tsc.o
  CC       tests/dwarf-unwind.o
  CC       util/smt.o
  CC       util/strbuf.o
  CC       util/string.o
  CC       util/strlist.o
  CC       tests/llvm-src-base.o
  CC       tests/llvm-src-kbuild.o
  CC       util/strfilter.o
  CC       util/top.o
  CC       tests/llvm-src-prologue.o
  CC       util/usage.o
  CC       tests/llvm-src-relocation.o
  CC       util/dso.o
  CC       util/dsos.o
  CC       util/symbol.o
  CC       util/symbol_fprintf.o
  LD       tests/perf-in.o
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
  CC       util/comm.o
  CC       util/thread.o
  CC       util/thread_map.o
  CC       util/trace-event-parse.o
  CC       util/parse-events-bison.o
  BISON    util/pmu-bison.c
  CC       util/pmu-hybrid.o
  CC       util/trace-event-read.o
  CC       util/trace-event-info.o
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
  CC       util/iostat.o
  CC       util/stream.o
  CC       util/auxtrace.o
  CC       util/intel-pt-decoder/intel-pt-pkt-decoder.o
  GEN      util/intel-pt-decoder/inat-tables.c
  CC       util/arm-spe-decoder/arm-spe-pkt-decoder.o
  CC       util/intel-pt-decoder/intel-pt-log.o
  CC       util/arm-spe-decoder/arm-spe-decoder.o
  CC       util/scripting-engines/trace-event-perl.o
  CC       util/intel-pt-decoder/intel-pt-decoder.o
  CC       util/scripting-engines/trace-event-python.o
  LD       util/arm-spe-decoder/perf-in.o
  CC       util/intel-pt.o
  CC       util/intel-bts.o
  CC       util/arm-spe.o
  CC       util/s390-cpumsf.o
  CC       util/parse-branch-options.o
  CC       util/dump-insn.o
  CC       util/parse-regs-options.o
  CC       util/parse-sublevel-options.o
  CC       util/term.o
  CC       util/help-unknown-cmd.o
  LD       util/scripting-engines/perf-in.o
  CC       util/mem-events.o
  CC       util/vsprintf.o
  CC       util/units.o
  CC       util/time-utils.o
  BISON    util/expr-bison.c
  CC       util/branch.o
  CC       util/mem2node.o
  CC       util/clockid.o
  CC       util/intel-pt-decoder/intel-pt-insn-decoder.o
  CC       util/bpf-loader.o
  CC       util/bpf_map.o
  CC       util/bpf-prologue.o
  CC       util/symbol-elf.o
  CC       util/probe-file.o
  CC       util/probe-event.o
  CC       util/probe-finder.o
  LD       util/intel-pt-decoder/perf-in.o
  CC       util/dwarf-aux.o
  CC       util/dwarf-regs.o
  CC       util/unwind-libunwind-local.o
  CC       util/unwind-libunwind.o
  CC       util/data-convert-bt.o
  CC       util/data-convert-json.o
  CC       util/zlib.o
  CC       util/lzma.o
  CC       util/zstd.o
  CC       util/cap.o
  CC       util/demangle-ocaml.o
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
  CC       util/parse-events.o
  CC       util/parse-events-flex.o
  CC       util/pmu.o
  CC       util/pmu-flex.o
  CC       util/expr-flex.o
  CC       util/expr.o
  LD       util/perf-in.o
  LD       perf-in.o
  LINK     perf
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-71d7924b3e=
8acaca6a3b0fc3261170031ada3b70/tools/perf'
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D8027=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x00000000=
0000 (pc 0x55bc424bee4b bp 0x7ffd874c3670 sp 0x7ffd874c3500 T0)
=3D=3D8027=3D=3DThe signal is caused by a READ memory access.
=3D=3D8027=3D=3DHint: address points to the zero page.
    #0 0x55bc424bee4a in print_symbol_events util/parse-events.c:2945
    #1 0x55bc424bf82e in print_events util/parse-events.c:2994
    #2 0x55bc42177d42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x55bc423ee029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x55bc423ee7d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x55bc423eecf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x55bc423ef6d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7fbf13f2f09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x55bc42119999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D8027=3D=3DABORTING
Installing test event list
output file: ../../test_suite/test-primitives-scripts/test-event-list/event=
-list
Dump all  JSON file evens to output event list file
output file: ../../test_suite/test-primitives-scripts/test-event-list/pebs-=
event-list
Dump PEBS  JSON file evens to output event list file
output file: ../../test_suite/test-primitives-scripts/test-event-list/kerne=
l_config_file_list-for-hardware-cache-event
Dump config file hardware cache event to output file
output file: ../../test_suite/test-primitives-scripts/test-event-list/ht_le=
ak_test_rules
Dump ht_leak_event_relation  to output file
output file: ../../test_suite/test-primitives-scripts/test-event-list/kerne=
l-pmu-event-list
Dump kernel omu event to output file
output file: ../../test_suite/test-primitives-scripts/test-event-list/event=
-list-for-skid-check
Dump skid event file  to output file
output file: ../../test_suite/test-primitives-scripts/test-event-list/offco=
re-event-list
Dump all  JSON file evens to output event list file
event file: Skylake_matrix_V25.json
output file: ../../test_suite/test-primitives-scripts/test-event-list/uncor=
e-event-list
Dump uncore event file  to output file
output file: ../../test_suite/test-primitives-scripts/test-event-list/rapl-=
event-list
output file: ../../test_suite/test-primitives-scripts/test-event-list/../.t=
est_case_config_for_host
Dump config file for host to output file
output file: ../../test_suite/test-primitives-scripts/test-event-list/../.t=
est_case_config_for_guest
Dump config file for guest to output file
output file: ../../test_suite/test-primitives-scripts/test-event-list/core_=
event_relation
output file: ../../test_suite/test-primitives-scripts/uncore_test/uncore_ev=
ent_relation
output file: ../../test_suite/test-primitives-scripts/calibrator_uncore_test
output file: ../../test_suite/test-primitives-scripts/test-event-list/topdo=
wn-event-list
output file: ../../test_suite/test-primitives-scripts/test-event-list/event=
-list-for-pebs-test
Dump pebs_test file  to output file

 usage: perf_test [--version] [--help] COMMAND [ARGS]

The perf test cases include:
	count		test primitive for counting
	sample		test primitive for sampling

 See 'perf_test TESTCASE --help' for more information on a specific command.

perf_test sanity case is pass!
rm -f *.o \
tchain_edit
gcc -Wall -c tchain_edit.c
gcc -static tchain_edit.o -o tchain_edit
cp ../../kernels/cache_kernels/code_rw/code_rw ./topdown_test/kernels
cp ../../kernels/cache_kernels/br_instr/br_instr ./calibrator_test/kernels
cp ../../kernels/cache_kernels/dtlb/dtlb ./calibrator_test/kernels
cp ../../kernels/cache_kernels/dtlb/dtlb ./topdown_test/kernels
cp ../../kernels/cache_kernels/hittest/hittest ./calibrator_test/kernels
cp ../../kernels/rdpmc_kernels/*.so ./rdpmc_test/
cp ../../kernels/rdpmc_kernels/rdpmc_reset ./rdpmc_test/
cp ../../kernels/rdpmc_kernels/rdpmc_dtlb ./rdpmc_test/
cp ../../kernels/tl-micros/mispredict1 ./topdown_test/kernels
cp ../../kernels/pebs_kernel/tchain_edit_zero ./pebs_test/
cp ../../kernels/cache_kernels/dtlb/dtlb ./pebs_test/
cd ../../kernels/tsx_kernels && cp capacity cpuid hle-abort-forever long-tx=
 ntload ntload-event-relation rtm-abort rtm-loop string2 hle-loop hle-in-rt=
m rtm-in-hle hle-rtm-event-relation vzeroupper vzeroupper-event-relation rt=
m-nest rtm-nest-event-relation abort-wc conflict-rtm conflict-hle conflict-=
event-relation rtm-abort-watchdog hle-abort-watchdog abort-watchdog-event-r=
elation hle-buffer-full hle-buffer-mismatch hle-buffer-event-relation hle-c=
ommit-nest hle-commit hle-flush rtm-flush hle-store-to-lock hle-unsupported=
-align interrupt-hle interrupt-rtm texception-hle texception-rtm texception=
-event-relation rtm-misc1-flowmarker rtm-string rtm-write-capacity rtm-writ=
e-capacity-event-relation hle-selfmod rtm-selfmod selfmode-event-relation h=
le-read-capacity rtm-read-capacity read-capacity-event-relation ../../test_=
suite/test-primitives-scripts/tsx_test
cp ../../kernels/breakpoint_kernels/bp_test ./breakpoint_test/
cp ../../kernels/breakpoint_kernels/dtlb ./breakpoint_test/
cp ../../kernels/mem_addr_kernels/*.so ./mem_addr_profile_test/
cp ../../kernels/mem_addr_kernels/perf_mem_mix ./mem_addr_profile_test/
cp ../../kernels/skid_test_kernel/dtlb* ../../kernels/skid_test_kernel/tria=
d_loop* ./skid_test/
cp ../../kernels/lbr_kernel/tchain_edit.c ./lbr_test/
cp ../../kernels/lbr_kernel/tchain_edit ./lbr_test/
cp ../../kernels/mlc/mlc_3.1a ./calibrator_uncore_test/kernels/mlc
cp ../../test_primitives/perf_test .
cp ../../kernels/commands/triad_loop .
cp ../../test_primitives/tar_log.sh .
cp ../../test_primitives/event-relation-list ./common_event-relation-list
cp ../../kernels/cache_kernels/itlb/itlb ./topdown_test/kernels
cp ../../kernels/cache_kernels/icmiss/icmiss ./topdown_test/kernels
2021-05-20 08:55:53 ./breakpoint_test/run.sh
Thu May 20 08:55:53 UTC 2021
0 test cases pass for breakpoint_checking test. 0 test cases fail for break=
point_checking test.
2021-05-20 08:55:53 ./calibrator_test/run.sh
SKIP for calibrator_test test
2021-05-20 08:55:53 ./calibrator_uncore_test/run.sh
SKIP for calibrator_uncore_test test
2021-05-20 08:55:53 ./event_list_test/run.sh
Thu May 20 09:08:37 UTC 2021
632 test cases pass for perf_event_list_test test. 0 test cases fail for pe=
rf_event_list_test test.
Test Case perf_event_list_count_branch-instructions PASS!
Test Case perf_event_list_count_branch-misses PASS!
Test Case perf_event_list_count_bus-cycles PASS!
Test Case perf_event_list_count_cache-misses PASS!
Test Case perf_event_list_count_cache-references PASS!
Test Case perf_event_list_count_cpu-cycles PASS!
Test Case perf_event_list_count_cycles-ct PASS!
Test Case perf_event_list_count_cycles-t PASS!
Test Case perf_event_list_count_el-abort PASS!
Test Case perf_event_list_count_el-capacity PASS!
Test Case perf_event_list_count_el-commit PASS!
Test Case perf_event_list_count_el-conflict PASS!
Test Case perf_event_list_count_el-start PASS!
Test Case perf_event_list_count_instructions PASS!
Test Case perf_event_list_count_mem-loads PASS!
Test Case perf_event_list_count_mem-stores PASS!
Test Case perf_event_list_count_ref-cycles PASS!
Test Case perf_event_list_count_tx-abort PASS!
Test Case perf_event_list_count_tx-capacity PASS!
Test Case perf_event_list_count_tx-commit PASS!
Test Case perf_event_list_count_tx-conflict PASS!
Test Case perf_event_list_count_tx-start PASS!
Test Case perf_event_list_count_cstate_core/c3-residency/ PASS!
Test Case perf_event_list_count_cstate_core/c6-residency/ PASS!
Test Case perf_event_list_count_cstate_core/c7-residency/ PASS!
Test Case perf_event_list_count_cstate_pkg/c10-residency/ PASS!
Test Case perf_event_list_count_cstate_pkg/c2-residency/ PASS!
Test Case perf_event_list_count_cstate_pkg/c3-residency/ PASS!
Test Case perf_event_list_count_cstate_pkg/c6-residency/ PASS!
Test Case perf_event_list_count_cstate_pkg/c7-residency/ PASS!
Test Case perf_event_list_count_cstate_pkg/c8-residency/ PASS!
Test Case perf_event_list_count_cstate_pkg/c9-residency/ PASS!
Test Case perf_event_list_count_i915/actual-frequency/ PASS!
Test Case perf_event_list_count_i915/bcs0-busy/ PASS!
Test Case perf_event_list_count_i915/bcs0-sema/ PASS!
Test Case perf_event_list_count_i915/bcs0-wait/ PASS!
Test Case perf_event_list_count_i915/interrupts/ PASS!
Test Case perf_event_list_count_i915/rc6-residency/ PASS!
Test Case perf_event_list_count_i915/rcs0-busy/ PASS!
Test Case perf_event_list_count_i915/rcs0-sema/ PASS!
Test Case perf_event_list_count_i915/rcs0-wait/ PASS!
Test Case perf_event_list_count_i915/requested-frequency/ PASS!
Test Case perf_event_list_count_i915/software-gt-awake-time/ PASS!
Test Case perf_event_list_count_i915/vcs0-busy/ PASS!
Test Case perf_event_list_count_i915/vcs0-sema/ PASS!
Test Case perf_event_list_count_i915/vcs0-wait/ PASS!
Test Case perf_event_list_count_i915/vecs0-busy/ PASS!
Test Case perf_event_list_count_i915/vecs0-sema/ PASS!
Test Case perf_event_list_count_i915/vecs0-wait/ PASS!
Test Case perf_event_list_count_msr/aperf/ PASS!
Test Case perf_event_list_count_msr/cpu_thermal_margin/ PASS!
Test Case perf_event_list_count_msr/mperf/ PASS!
Test Case perf_event_list_count_msr/pperf/ PASS!
Test Case perf_event_list_count_msr/smi/ PASS!
Test Case perf_event_list_count_msr/tsc/ PASS!
Test Case perf_event_list_count_power/energy-cores/ PASS!
Test Case perf_event_list_count_power/energy-gpu/ PASS!
Test Case perf_event_list_count_power/energy-pkg/ PASS!
Test Case perf_event_list_count_power/energy-ram/ PASS!
Test Case perf_event_list_count_uncore_cbox_0/clockticks/ PASS!
Test Case perf_event_list_count_uncore_imc/data_reads/ PASS!
Test Case perf_event_list_count_uncore_imc/data_writes/ PASS!
Test Case perf_event_list_count_uncore_imc/gt_requests/ PASS!
Test Case perf_event_list_count_uncore_imc/ia_requests/ PASS!
Test Case perf_event_list_count_uncore_imc/io_requests/ PASS!
Test Case perf_event_list_count_l1d.replacement PASS!
Test Case perf_event_list_count_l1d_pend_miss.fb_full PASS!
Test Case perf_event_list_count_l1d_pend_miss.pending PASS!
Test Case perf_event_list_count_l1d_pend_miss.pending_cycles PASS!
Test Case perf_event_list_count_l1d_pend_miss.pending_cycles_any PASS!
Test Case perf_event_list_count_l2_lines_in.all PASS!
Test Case perf_event_list_count_l2_lines_out.non_silent PASS!
Test Case perf_event_list_count_l2_lines_out.silent PASS!
Test Case perf_event_list_count_l2_lines_out.useless_hwpf PASS!
Test Case perf_event_list_count_l2_lines_out.useless_pref PASS!
Test Case perf_event_list_count_l2_rqsts.all_code_rd PASS!
Test Case perf_event_list_count_l2_rqsts.all_demand_data_rd PASS!
Test Case perf_event_list_count_l2_rqsts.all_demand_miss PASS!
Test Case perf_event_list_count_l2_rqsts.all_demand_references PASS!
Test Case perf_event_list_count_l2_rqsts.all_pf PASS!
Test Case perf_event_list_count_l2_rqsts.all_rfo PASS!
Test Case perf_event_list_count_l2_rqsts.code_rd_hit PASS!
Test Case perf_event_list_count_l2_rqsts.code_rd_miss PASS!
Test Case perf_event_list_count_l2_rqsts.demand_data_rd_hit PASS!
Test Case perf_event_list_count_l2_rqsts.demand_data_rd_miss PASS!
Test Case perf_event_list_count_l2_rqsts.miss PASS!
Test Case perf_event_list_count_l2_rqsts.pf_hit PASS!
Test Case perf_event_list_count_l2_rqsts.pf_miss PASS!
Test Case perf_event_list_count_l2_rqsts.references PASS!
Test Case perf_event_list_count_l2_rqsts.rfo_hit PASS!
Test Case perf_event_list_count_l2_rqsts.rfo_miss PASS!
Test Case perf_event_list_count_l2_trans.l2_wb PASS!
Test Case perf_event_list_count_longest_lat_cache.miss PASS!
Test Case perf_event_list_count_longest_lat_cache.reference PASS!
Test Case perf_event_list_count_mem_inst_retired.all_loads PASS!
Test Case perf_event_list_count_mem_inst_retired.all_stores PASS!
Test Case perf_event_list_count_mem_inst_retired.lock_loads PASS!
Test Case perf_event_list_count_mem_inst_retired.split_loads PASS!
Test Case perf_event_list_count_mem_inst_retired.split_stores PASS!
Test Case perf_event_list_count_mem_inst_retired.stlb_miss_loads PASS!
Test Case perf_event_list_count_mem_inst_retired.stlb_miss_stores PASS!
Test Case perf_event_list_count_mem_load_l3_hit_retired.xsnp_hit PASS!
Test Case perf_event_list_count_mem_load_l3_hit_retired.xsnp_hitm PASS!
Test Case perf_event_list_count_mem_load_l3_hit_retired.xsnp_miss PASS!
Test Case perf_event_list_count_mem_load_l3_hit_retired.xsnp_none PASS!
Test Case perf_event_list_count_mem_load_misc_retired.uc PASS!
Test Case perf_event_list_count_mem_load_retired.fb_hit PASS!
Test Case perf_event_list_count_mem_load_retired.l1_hit PASS!
Test Case perf_event_list_count_mem_load_retired.l1_miss PASS!
Test Case perf_event_list_count_mem_load_retired.l2_hit PASS!
Test Case perf_event_list_count_mem_load_retired.l2_miss PASS!
Test Case perf_event_list_count_mem_load_retired.l3_hit PASS!
Test Case perf_event_list_count_mem_load_retired.l3_miss PASS!
Test Case perf_event_list_count_offcore_requests.all_data_rd PASS!
Test Case perf_event_list_count_offcore_requests.all_requests PASS!
Test Case perf_event_list_count_offcore_requests.demand_code_rd PASS!
Test Case perf_event_list_count_offcore_requests.demand_data_rd PASS!
Test Case perf_event_list_count_offcore_requests.demand_rfo PASS!
Test Case perf_event_list_count_offcore_requests_buffer.sq_full PASS!
Test Case perf_event_list_count_offcore_requests_outstanding.all_data_rd PA=
SS!
Test Case perf_event_list_count_offcore_requests_outstanding.cycles_with_da=
ta_rd PASS!
Test Case perf_event_list_count_offcore_requests_outstanding.cycles_with_de=
mand_code_rd PASS!
Test Case perf_event_list_count_offcore_requests_outstanding.cycles_with_de=
mand_data_rd PASS!
Test Case perf_event_list_count_offcore_requests_outstanding.cycles_with_de=
mand_rfo PASS!
Test Case perf_event_list_count_offcore_requests_outstanding.demand_code_rd=
 PASS!
Test Case perf_event_list_count_offcore_requests_outstanding.demand_data_rd=
 PASS!
Test Case perf_event_list_count_offcore_requests_outstanding.demand_data_rd=
_ge_6 PASS!
Test Case perf_event_list_count_offcore_requests_outstanding.demand_rfo PAS=
S!
Test Case perf_event_list_count_offcore_response PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.any_respons=
e PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit.any_=
snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit.snoo=
p_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit.snoo=
p_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit.snoo=
p_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit.snoo=
p_none PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit.snoo=
p_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit.spl_=
hit PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_e.an=
y_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_e.sn=
oop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_e.sn=
oop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_e.sn=
oop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_e.sn=
oop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_e.sn=
oop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_e.sp=
l_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_m.an=
y_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_m.sn=
oop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_m.sn=
oop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_m.sn=
oop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_m.sn=
oop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_m.sn=
oop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_m.sp=
l_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_s.an=
y_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_s.sn=
oop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_s.sn=
oop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_s.sn=
oop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_s.sn=
oop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_s.sn=
oop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_s.sp=
l_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l4_hit_loca=
l_l4.any_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l4_hit_loca=
l_l4.snoop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l4_hit_loca=
l_l4.snoop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l4_hit_loca=
l_l4.snoop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l4_hit_loca=
l_l4.snoop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l4_hit_loca=
l_l4.snoop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l4_hit_loca=
l_l4.spl_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.supplier_no=
ne.any_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.supplier_no=
ne.snoop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.supplier_no=
ne.snoop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.supplier_no=
ne.snoop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.supplier_no=
ne.snoop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.supplier_no=
ne.snoop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.supplier_no=
ne.spl_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.any_respons=
e PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit.any_=
snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit.snoo=
p_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit.snoo=
p_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit.snoo=
p_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit.snoo=
p_none PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit.snoo=
p_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit.spl_=
hit PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_e.an=
y_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_e.sn=
oop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_e.sn=
oop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_e.sn=
oop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_e.sn=
oop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_e.sn=
oop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_e.sp=
l_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_m.an=
y_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_m.sn=
oop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_m.sn=
oop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_m.sn=
oop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_m.sn=
oop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_m.sn=
oop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_m.sp=
l_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_s.an=
y_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_s.sn=
oop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_s.sn=
oop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_s.sn=
oop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_s.sn=
oop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_s.sn=
oop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_s.sp=
l_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l4_hit_loca=
l_l4.any_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l4_hit_loca=
l_l4.snoop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l4_hit_loca=
l_l4.snoop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l4_hit_loca=
l_l4.snoop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l4_hit_loca=
l_l4.snoop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l4_hit_loca=
l_l4.snoop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l4_hit_loca=
l_l4.spl_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.supplier_no=
ne.any_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.supplier_no=
ne.snoop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.supplier_no=
ne.snoop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.supplier_no=
ne.snoop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.supplier_no=
ne.snoop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.supplier_no=
ne.snoop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.supplier_no=
ne.spl_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.any_response PA=
SS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit.any_snoo=
p PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit.snoop_hi=
t_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit.snoop_hi=
tm PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit.snoop_mi=
ss PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit.snoop_no=
ne PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit.snoop_no=
t_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit.spl_hit =
PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_e.any_sn=
oop PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_e.snoop_=
hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_e.snoop_=
hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_e.snoop_=
miss PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_e.snoop_=
none PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_e.snoop_=
not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_e.spl_hi=
t PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_m.any_sn=
oop PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_m.snoop_=
hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_m.snoop_=
hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_m.snoop_=
miss PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_m.snoop_=
none PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_m.snoop_=
not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_m.spl_hi=
t PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_s.any_sn=
oop PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_s.snoop_=
hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_s.snoop_=
hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_s.snoop_=
miss PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_s.snoop_=
none PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_s.snoop_=
not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_s.spl_hi=
t PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l4_hit_local_l4=
=2Eany_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l4_hit_local_l4=
=2Esnoop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l4_hit_local_l4=
=2Esnoop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l4_hit_local_l4=
=2Esnoop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l4_hit_local_l4=
=2Esnoop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l4_hit_local_l4=
=2Esnoop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l4_hit_local_l4=
=2Espl_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.supplier_none.a=
ny_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.supplier_none.s=
noop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.supplier_none.s=
noop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.supplier_none.s=
noop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.supplier_none.s=
noop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.supplier_none.s=
noop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.supplier_none.s=
pl_hit PASS!
Test Case perf_event_list_count_offcore_response.other.any_response PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit.any_snoop PAS=
S!
Test Case perf_event_list_count_offcore_response.other.l3_hit.snoop_hit_no_=
fwd PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit.snoop_hitm PA=
SS!
Test Case perf_event_list_count_offcore_response.other.l3_hit.snoop_miss PA=
SS!
Test Case perf_event_list_count_offcore_response.other.l3_hit.snoop_none PA=
SS!
Test Case perf_event_list_count_offcore_response.other.l3_hit.snoop_not_nee=
ded PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit.spl_hit PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_e.any_snoop P=
ASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_e.snoop_hit_n=
o_fwd PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_e.snoop_hitm =
PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_e.snoop_miss =
PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_e.snoop_none =
PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_e.snoop_not_n=
eeded PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_e.spl_hit PAS=
S!
Test Case perf_event_list_count_offcore_response.other.l3_hit_m.any_snoop P=
ASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_m.snoop_hit_n=
o_fwd PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_m.snoop_hitm =
PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_m.snoop_miss =
PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_m.snoop_none =
PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_m.snoop_not_n=
eeded PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_m.spl_hit PAS=
S!
Test Case perf_event_list_count_offcore_response.other.l3_hit_s.any_snoop P=
ASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_s.snoop_hit_n=
o_fwd PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_s.snoop_hitm =
PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_s.snoop_miss =
PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_s.snoop_none =
PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_s.snoop_not_n=
eeded PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_s.spl_hit PAS=
S!
Test Case perf_event_list_count_offcore_response.other.l4_hit_local_l4.any_=
snoop PASS!
Test Case perf_event_list_count_offcore_response.other.l4_hit_local_l4.snoo=
p_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.other.l4_hit_local_l4.snoo=
p_hitm PASS!
Test Case perf_event_list_count_offcore_response.other.l4_hit_local_l4.snoo=
p_miss PASS!
Test Case perf_event_list_count_offcore_response.other.l4_hit_local_l4.snoo=
p_none PASS!
Test Case perf_event_list_count_offcore_response.other.l4_hit_local_l4.snoo=
p_not_needed PASS!
Test Case perf_event_list_count_offcore_response.other.l4_hit_local_l4.spl_=
hit PASS!
Test Case perf_event_list_count_offcore_response.other.supplier_none.any_sn=
oop PASS!
Test Case perf_event_list_count_offcore_response.other.supplier_none.snoop_=
hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.other.supplier_none.snoop_=
hitm PASS!
Test Case perf_event_list_count_offcore_response.other.supplier_none.snoop_=
miss PASS!
Test Case perf_event_list_count_offcore_response.other.supplier_none.snoop_=
none PASS!
Test Case perf_event_list_count_offcore_response.other.supplier_none.snoop_=
not_needed PASS!
Test Case perf_event_list_count_offcore_response.other.supplier_none.spl_hi=
t PASS!
Test Case perf_event_list_count_sq_misc.split_lock PASS!
Test Case perf_event_list_count_fp_arith_inst_retired.128b_packed_double PA=
SS!
Test Case perf_event_list_count_fp_arith_inst_retired.128b_packed_single PA=
SS!
Test Case perf_event_list_count_fp_arith_inst_retired.256b_packed_double PA=
SS!
Test Case perf_event_list_count_fp_arith_inst_retired.256b_packed_single PA=
SS!
Test Case perf_event_list_count_fp_arith_inst_retired.scalar_double PASS!
Test Case perf_event_list_count_fp_arith_inst_retired.scalar_single PASS!
Test Case perf_event_list_count_fp_assist.any PASS!
Test Case perf_event_list_count_baclears.any PASS!
Test Case perf_event_list_count_dsb2mite_switches.count PASS!
Test Case perf_event_list_count_dsb2mite_switches.penalty_cycles PASS!
Test Case perf_event_list_count_frontend_retired.dsb_miss PASS!
Test Case perf_event_list_count_frontend_retired.itlb_miss PASS!
Test Case perf_event_list_count_frontend_retired.l1i_miss PASS!
Test Case perf_event_list_count_frontend_retired.l2_miss PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_1 PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_128 PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_16 PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_2 PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_256 PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_2_bubbles_ge_1 =
PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_2_bubbles_ge_2 =
PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_2_bubbles_ge_3 =
PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_32 PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_4 PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_512 PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_64 PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_8 PASS!
Test Case perf_event_list_count_frontend_retired.stlb_miss PASS!
Test Case perf_event_list_count_icache_16b.ifdata_stall PASS!
Test Case perf_event_list_count_icache_64b.iftag_hit PASS!
Test Case perf_event_list_count_icache_64b.iftag_miss PASS!
Test Case perf_event_list_count_icache_64b.iftag_stall PASS!
Test Case perf_event_list_count_idq.all_dsb_cycles_4_uops PASS!
Test Case perf_event_list_count_idq.all_dsb_cycles_any_uops PASS!
Test Case perf_event_list_count_idq.all_mite_cycles_4_uops PASS!
Test Case perf_event_list_count_idq.all_mite_cycles_any_uops PASS!
Test Case perf_event_list_count_idq.dsb_cycles PASS!
Test Case perf_event_list_count_idq.dsb_uops PASS!
Test Case perf_event_list_count_idq.mite_cycles PASS!
Test Case perf_event_list_count_idq.mite_uops PASS!
Test Case perf_event_list_count_idq.ms_cycles PASS!
Test Case perf_event_list_count_idq.ms_dsb_cycles PASS!
Test Case perf_event_list_count_idq.ms_mite_uops PASS!
Test Case perf_event_list_count_idq.ms_switches PASS!
Test Case perf_event_list_count_idq.ms_uops PASS!
Test Case perf_event_list_count_idq_uops_not_delivered.core PASS!
Test Case perf_event_list_count_idq_uops_not_delivered.cycles_0_uops_deliv.=
core PASS!
Test Case perf_event_list_count_idq_uops_not_delivered.cycles_fe_was_ok PAS=
S!
Test Case perf_event_list_count_idq_uops_not_delivered.cycles_le_1_uop_deli=
v.core PASS!
Test Case perf_event_list_count_idq_uops_not_delivered.cycles_le_2_uop_deli=
v.core PASS!
Test Case perf_event_list_count_idq_uops_not_delivered.cycles_le_3_uop_deli=
v.core PASS!
Test Case perf_event_list_count_cycle_activity.cycles_l3_miss PASS!
Test Case perf_event_list_count_cycle_activity.stalls_l3_miss PASS!
Test Case perf_event_list_count_hle_retired.aborted PASS!
Test Case perf_event_list_count_hle_retired.aborted_events PASS!
Test Case perf_event_list_count_hle_retired.aborted_mem PASS!
Test Case perf_event_list_count_hle_retired.aborted_memtype PASS!
Test Case perf_event_list_count_hle_retired.aborted_timer PASS!
Test Case perf_event_list_count_hle_retired.aborted_unfriendly PASS!
Test Case perf_event_list_count_hle_retired.commit PASS!
Test Case perf_event_list_count_hle_retired.start PASS!
Test Case perf_event_list_count_machine_clears.memory_ordering PASS!
Test Case perf_event_list_count_mem_trans_retired.load_latency_gt_128 PASS!
Test Case perf_event_list_count_mem_trans_retired.load_latency_gt_16 PASS!
Test Case perf_event_list_count_mem_trans_retired.load_latency_gt_256 PASS!
Test Case perf_event_list_count_mem_trans_retired.load_latency_gt_32 PASS!
Test Case perf_event_list_count_mem_trans_retired.load_latency_gt_4 PASS!
Test Case perf_event_list_count_mem_trans_retired.load_latency_gt_512 PASS!
Test Case perf_event_list_count_mem_trans_retired.load_latency_gt_64 PASS!
Test Case perf_event_list_count_mem_trans_retired.load_latency_gt_8 PASS!
Test Case perf_event_list_count_offcore_requests.l3_miss_demand_data_rd PAS=
S!
Test Case perf_event_list_count_offcore_requests_outstanding.cycles_with_l3=
_miss_demand_data_rd PASS!
Test Case perf_event_list_count_offcore_requests_outstanding.l3_miss_demand=
_data_rd PASS!
Test Case perf_event_list_count_offcore_requests_outstanding.l3_miss_demand=
_data_rd_ge_6 PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit.snoo=
p_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_e.sn=
oop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_m.sn=
oop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_s.sn=
oop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss.any=
_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss.sno=
op_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss.sno=
op_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss.sno=
op_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss.sno=
op_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss.sno=
op_none PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss.sno=
op_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss.spl=
_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss_loc=
al_dram.any_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss_loc=
al_dram.snoop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss_loc=
al_dram.snoop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss_loc=
al_dram.snoop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss_loc=
al_dram.snoop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss_loc=
al_dram.snoop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss_loc=
al_dram.snoop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss_loc=
al_dram.spl_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l4_hit_loca=
l_l4.snoop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.supplier_no=
ne.snoop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit.snoo=
p_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_e.sn=
oop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_m.sn=
oop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_s.sn=
oop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss.any=
_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss.sno=
op_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss.sno=
op_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss.sno=
op_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss.sno=
op_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss.sno=
op_none PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss.sno=
op_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss.spl=
_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss_loc=
al_dram.any_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss_loc=
al_dram.snoop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss_loc=
al_dram.snoop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss_loc=
al_dram.snoop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss_loc=
al_dram.snoop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss_loc=
al_dram.snoop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss_loc=
al_dram.snoop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss_loc=
al_dram.spl_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l4_hit_loca=
l_l4.snoop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.supplier_no=
ne.snoop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit.snoop_no=
n_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_e.snoop_=
non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_m.snoop_=
non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_s.snoop_=
non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss.any_sno=
op PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss.snoop_h=
it_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss.snoop_h=
itm PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss.snoop_m=
iss PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss.snoop_n=
on_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss.snoop_n=
one PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss.snoop_n=
ot_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss.spl_hit=
 PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss_local_d=
ram.any_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss_local_d=
ram.snoop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss_local_d=
ram.snoop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss_local_d=
ram.snoop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss_local_d=
ram.snoop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss_local_d=
ram.snoop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss_local_d=
ram.snoop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss_local_d=
ram.spl_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l4_hit_local_l4=
=2Esnoop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.supplier_none.s=
noop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit.snoop_non_dra=
m PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_e.snoop_non_d=
ram PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_m.snoop_non_d=
ram PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_s.snoop_non_d=
ram PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss.any_snoop PA=
SS!
Test Case perf_event_list_count_offcore_response.other.l3_miss.snoop_hit_no=
_fwd PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss.snoop_hitm P=
ASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss.snoop_miss P=
ASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss.snoop_non_dr=
am PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss.snoop_none P=
ASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss.snoop_not_ne=
eded PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss.spl_hit PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss_local_dram.a=
ny_snoop PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss_local_dram.s=
noop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss_local_dram.s=
noop_hitm PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss_local_dram.s=
noop_miss PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss_local_dram.s=
noop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss_local_dram.s=
noop_none PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss_local_dram.s=
noop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss_local_dram.s=
pl_hit PASS!
Test Case perf_event_list_count_offcore_response.other.l4_hit_local_l4.snoo=
p_non_dram PASS!
Test Case perf_event_list_count_offcore_response.other.supplier_none.snoop_=
non_dram PASS!
Test Case perf_event_list_count_rtm_retired.aborted PASS!
Test Case perf_event_list_count_rtm_retired.aborted_events PASS!
Test Case perf_event_list_count_rtm_retired.aborted_mem PASS!
Test Case perf_event_list_count_rtm_retired.aborted_memtype PASS!
Test Case perf_event_list_count_rtm_retired.aborted_timer PASS!
Test Case perf_event_list_count_rtm_retired.aborted_unfriendly PASS!
Test Case perf_event_list_count_rtm_retired.commit PASS!
Test Case perf_event_list_count_rtm_retired.start PASS!
Test Case perf_event_list_count_tx_exec.misc1 PASS!
Test Case perf_event_list_count_tx_exec.misc2 PASS!
Test Case perf_event_list_count_tx_exec.misc3 PASS!
Test Case perf_event_list_count_tx_exec.misc4 PASS!
Test Case perf_event_list_count_tx_exec.misc5 PASS!
Test Case perf_event_list_count_tx_mem.abort_capacity PASS!
Test Case perf_event_list_count_tx_mem.abort_conflict PASS!
Test Case perf_event_list_count_tx_mem.abort_hle_elision_buffer_mismatch PA=
SS!
Test Case perf_event_list_count_tx_mem.abort_hle_elision_buffer_not_empty P=
ASS!
Test Case perf_event_list_count_tx_mem.abort_hle_elision_buffer_unsupported=
_alignment PASS!
Test Case perf_event_list_count_tx_mem.abort_hle_store_to_elided_lock PASS!
Test Case perf_event_list_count_tx_mem.hle_elision_buffer_full PASS!
Test Case perf_event_list_count_hw_interrupts.received PASS!
Test Case perf_event_list_count_memory_disambiguation.history_reset PASS!
Test Case perf_event_list_count_sw_prefetch_access.nta PASS!
Test Case perf_event_list_count_sw_prefetch_access.prefetchw PASS!
Test Case perf_event_list_count_sw_prefetch_access.t0 PASS!
Test Case perf_event_list_count_sw_prefetch_access.t1_t2 PASS!
Test Case perf_event_list_count_arith.divider_active PASS!
Test Case perf_event_list_count_br_inst_retired.all_branches PASS!
Test Case perf_event_list_count_br_inst_retired.all_branches_pebs PASS!
Test Case perf_event_list_count_br_inst_retired.cond_ntaken PASS!
Test Case perf_event_list_count_br_inst_retired.conditional PASS!
Test Case perf_event_list_count_br_inst_retired.far_branch PASS!
Test Case perf_event_list_count_br_inst_retired.near_call PASS!
Test Case perf_event_list_count_br_inst_retired.near_return PASS!
Test Case perf_event_list_count_br_inst_retired.near_taken PASS!
Test Case perf_event_list_count_br_inst_retired.not_taken PASS!
Test Case perf_event_list_count_br_misp_retired.all_branches PASS!
Test Case perf_event_list_count_br_misp_retired.all_branches_pebs PASS!
Test Case perf_event_list_count_br_misp_retired.conditional PASS!
Test Case perf_event_list_count_br_misp_retired.near_call PASS!
Test Case perf_event_list_count_br_misp_retired.near_taken PASS!
Test Case perf_event_list_count_cpu_clk_thread_unhalted.one_thread_active P=
ASS!
Test Case perf_event_list_count_cpu_clk_thread_unhalted.ref_xclk PASS!
Test Case perf_event_list_count_cpu_clk_thread_unhalted.ref_xclk_any PASS!
Test Case perf_event_list_count_cpu_clk_unhalted.one_thread_active PASS!
Test Case perf_event_list_count_cpu_clk_unhalted.ref_tsc PASS!
Test Case perf_event_list_count_cpu_clk_unhalted.ref_xclk PASS!
Test Case perf_event_list_count_cpu_clk_unhalted.ref_xclk_any PASS!
Test Case perf_event_list_count_cpu_clk_unhalted.ring0_trans PASS!
Test Case perf_event_list_count_cpu_clk_unhalted.thread PASS!
Test Case perf_event_list_count_cpu_clk_unhalted.thread_any PASS!
Test Case perf_event_list_count_cpu_clk_unhalted.thread_p PASS!
Test Case perf_event_list_count_cpu_clk_unhalted.thread_p_any PASS!
Test Case perf_event_list_count_cycle_activity.cycles_l1d_miss PASS!
Test Case perf_event_list_count_cycle_activity.cycles_l2_miss PASS!
Test Case perf_event_list_count_cycle_activity.cycles_mem_any PASS!
Test Case perf_event_list_count_cycle_activity.stalls_l1d_miss PASS!
Test Case perf_event_list_count_cycle_activity.stalls_l2_miss PASS!
Test Case perf_event_list_count_cycle_activity.stalls_mem_any PASS!
Test Case perf_event_list_count_cycle_activity.stalls_total PASS!
Test Case perf_event_list_count_exe_activity.1_ports_util PASS!
Test Case perf_event_list_count_exe_activity.2_ports_util PASS!
Test Case perf_event_list_count_exe_activity.3_ports_util PASS!
Test Case perf_event_list_count_exe_activity.4_ports_util PASS!
Test Case perf_event_list_count_exe_activity.bound_on_stores PASS!
Test Case perf_event_list_count_exe_activity.exe_bound_0_ports PASS!
Test Case perf_event_list_count_ild_stall.lcp PASS!
Test Case perf_event_list_count_inst_retired.any PASS!
Test Case perf_event_list_count_inst_retired.any_p PASS!
Test Case perf_event_list_count_inst_retired.prec_dist PASS!
Test Case perf_event_list_count_inst_retired.total_cycles_ps PASS!
Test Case perf_event_list_count_int_misc.clear_resteer_cycles PASS!
Test Case perf_event_list_count_int_misc.recovery_cycles PASS!
Test Case perf_event_list_count_int_misc.recovery_cycles_any PASS!
Test Case perf_event_list_count_ld_blocks.no_sr PASS!
Test Case perf_event_list_count_ld_blocks.store_forward PASS!
Test Case perf_event_list_count_ld_blocks_partial.address_alias PASS!
Test Case perf_event_list_count_load_hit_pre.sw_pf PASS!
Test Case perf_event_list_count_lsd.cycles_4_uops PASS!
Test Case perf_event_list_count_lsd.cycles_active PASS!
Test Case perf_event_list_count_lsd.uops PASS!
Test Case perf_event_list_count_machine_clears.count PASS!
Test Case perf_event_list_count_machine_clears.smc PASS!
Test Case perf_event_list_count_other_assists.any PASS!
Test Case perf_event_list_count_partial_rat_stalls.scoreboard PASS!
Test Case perf_event_list_count_resource_stalls.any PASS!
Test Case perf_event_list_count_resource_stalls.sb PASS!
Test Case perf_event_list_count_rob_misc_events.lbr_inserts PASS!
Test Case perf_event_list_count_rob_misc_events.pause_inst PASS!
Test Case perf_event_list_count_rs_events.empty_cycles PASS!
Test Case perf_event_list_count_rs_events.empty_end PASS!
Test Case perf_event_list_count_uops_dispatched_port.port_0 PASS!
Test Case perf_event_list_count_uops_dispatched_port.port_1 PASS!
Test Case perf_event_list_count_uops_dispatched_port.port_2 PASS!
Test Case perf_event_list_count_uops_dispatched_port.port_3 PASS!
Test Case perf_event_list_count_uops_dispatched_port.port_4 PASS!
Test Case perf_event_list_count_uops_dispatched_port.port_5 PASS!
Test Case perf_event_list_count_uops_dispatched_port.port_6 PASS!
Test Case perf_event_list_count_uops_dispatched_port.port_7 PASS!
Test Case perf_event_list_count_uops_executed.core PASS!
Test Case perf_event_list_count_uops_executed.core_cycles_ge_1 PASS!
Test Case perf_event_list_count_uops_executed.core_cycles_ge_2 PASS!
Test Case perf_event_list_count_uops_executed.core_cycles_ge_3 PASS!
Test Case perf_event_list_count_uops_executed.core_cycles_ge_4 PASS!
Test Case perf_event_list_count_uops_executed.core_cycles_none PASS!
Test Case perf_event_list_count_uops_executed.cycles_ge_1_uop_exec PASS!
Test Case perf_event_list_count_uops_executed.cycles_ge_2_uops_exec PASS!
Test Case perf_event_list_count_uops_executed.cycles_ge_3_uops_exec PASS!
Test Case perf_event_list_count_uops_executed.cycles_ge_4_uops_exec PASS!
Test Case perf_event_list_count_uops_executed.stall_cycles PASS!
Test Case perf_event_list_count_uops_executed.thread PASS!
Test Case perf_event_list_count_uops_executed.x87 PASS!
Test Case perf_event_list_count_uops_issued.any PASS!
Test Case perf_event_list_count_uops_issued.slow_lea PASS!
Test Case perf_event_list_count_uops_issued.stall_cycles PASS!
Test Case perf_event_list_count_uops_issued.vector_width_mismatch PASS!
Test Case perf_event_list_count_uops_retired.macro_fused PASS!
Test Case perf_event_list_count_uops_retired.retire_slots PASS!
Test Case perf_event_list_count_uops_retired.stall_cycles PASS!
Test Case perf_event_list_count_uops_retired.total_cycles PASS!
Test Case perf_event_list_count_unc_arb_coh_trk_requests.all PASS!
Test Case perf_event_list_count_unc_arb_trk_occupancy.all PASS!
Test Case perf_event_list_count_unc_arb_trk_occupancy.cycles_with_any_reque=
st PASS!
Test Case perf_event_list_count_unc_arb_trk_requests.all PASS!
Test Case perf_event_list_count_unc_arb_trk_requests.drd_direct PASS!
Test Case perf_event_list_count_unc_arb_trk_requests.writes PASS!
Test Case perf_event_list_count_unc_cbo_cache_lookup.any_es PASS!
Test Case perf_event_list_count_unc_cbo_cache_lookup.any_i PASS!
Test Case perf_event_list_count_unc_cbo_cache_lookup.any_m PASS!
Test Case perf_event_list_count_unc_cbo_cache_lookup.any_mesi PASS!
Test Case perf_event_list_count_unc_cbo_cache_lookup.read_es PASS!
Test Case perf_event_list_count_unc_cbo_cache_lookup.read_i PASS!
Test Case perf_event_list_count_unc_cbo_cache_lookup.read_mesi PASS!
Test Case perf_event_list_count_unc_cbo_cache_lookup.write_es PASS!
Test Case perf_event_list_count_unc_cbo_cache_lookup.write_m PASS!
Test Case perf_event_list_count_unc_cbo_cache_lookup.write_mesi PASS!
Test Case perf_event_list_count_unc_cbo_xsnp_response.hit_xcore PASS!
Test Case perf_event_list_count_unc_cbo_xsnp_response.hitm_xcore PASS!
Test Case perf_event_list_count_unc_cbo_xsnp_response.miss_eviction PASS!
Test Case perf_event_list_count_unc_cbo_xsnp_response.miss_xcore PASS!
Test Case perf_event_list_count_dtlb_load_misses.miss_causes_a_walk PASS!
Test Case perf_event_list_count_dtlb_load_misses.stlb_hit PASS!
Test Case perf_event_list_count_dtlb_load_misses.walk_active PASS!
Test Case perf_event_list_count_dtlb_load_misses.walk_completed PASS!
Test Case perf_event_list_count_dtlb_load_misses.walk_completed_1g PASS!
Test Case perf_event_list_count_dtlb_load_misses.walk_completed_2m_4m PASS!
Test Case perf_event_list_count_dtlb_load_misses.walk_completed_4k PASS!
Test Case perf_event_list_count_dtlb_load_misses.walk_pending PASS!
Test Case perf_event_list_count_dtlb_store_misses.miss_causes_a_walk PASS!
Test Case perf_event_list_count_dtlb_store_misses.stlb_hit PASS!
Test Case perf_event_list_count_dtlb_store_misses.walk_active PASS!
Test Case perf_event_list_count_dtlb_store_misses.walk_completed PASS!
Test Case perf_event_list_count_dtlb_store_misses.walk_completed_1g PASS!
Test Case perf_event_list_count_dtlb_store_misses.walk_completed_2m_4m PASS!
Test Case perf_event_list_count_dtlb_store_misses.walk_completed_4k PASS!
Test Case perf_event_list_count_dtlb_store_misses.walk_pending PASS!
Test Case perf_event_list_count_ept.walk_pending PASS!
Test Case perf_event_list_count_itlb.itlb_flush PASS!
Test Case perf_event_list_count_itlb_misses.miss_causes_a_walk PASS!
Test Case perf_event_list_count_itlb_misses.stlb_hit PASS!
Test Case perf_event_list_count_itlb_misses.walk_active PASS!
Test Case perf_event_list_count_itlb_misses.walk_completed PASS!
Test Case perf_event_list_count_itlb_misses.walk_completed_1g PASS!
Test Case perf_event_list_count_itlb_misses.walk_completed_2m_4m PASS!
Test Case perf_event_list_count_itlb_misses.walk_completed_4k PASS!
Test Case perf_event_list_count_itlb_misses.walk_pending PASS!
Test Case perf_event_list_count_tlb_flush.dtlb_thread PASS!
Test Case perf_event_list_count_tlb_flush.stlb_any PASS!
2021-05-20 09:08:39 ./events_relation_test/run.sh
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31716=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x55d91e51ee4b bp 0x7fffcb59c180 sp 0x7fffcb59c010 T0)
=3D=3D31716=3D=3DThe signal is caused by a READ memory access.
=3D=3D31716=3D=3DHint: address points to the zero page.
    #0 0x55d91e51ee4a in print_symbol_events util/parse-events.c:2945
    #1 0x55d91e51f82e in print_events util/parse-events.c:2994
    #2 0x55d91e1d7d42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x55d91e44e029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x55d91e44e7d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x55d91e44ecf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x55d91e44f6d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f7649d2209a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x55d91e179999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31716=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31719=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x561c83441e4b bp 0x7ffd689d33a0 sp 0x7ffd689d3230 T0)
=3D=3D31719=3D=3DThe signal is caused by a READ memory access.
=3D=3D31719=3D=3DHint: address points to the zero page.
    #0 0x561c83441e4a in print_symbol_events util/parse-events.c:2945
    #1 0x561c8344282e in print_events util/parse-events.c:2994
    #2 0x561c830fad42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x561c83371029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x561c833717d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x561c83371cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x561c833726d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f465cdae09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x561c8309c999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31719=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31722=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x557ef65c6e4b bp 0x7ffd5c093f30 sp 0x7ffd5c093dc0 T0)
=3D=3D31722=3D=3DThe signal is caused by a READ memory access.
=3D=3D31722=3D=3DHint: address points to the zero page.
    #0 0x557ef65c6e4a in print_symbol_events util/parse-events.c:2945
    #1 0x557ef65c782e in print_events util/parse-events.c:2994
    #2 0x557ef627fd42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x557ef64f6029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x557ef64f67d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x557ef64f6cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x557ef64f76d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f577db5009a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x557ef6221999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31722=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31725=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x55989846ee4b bp 0x7fff66e534e0 sp 0x7fff66e53370 T0)
=3D=3D31725=3D=3DThe signal is caused by a READ memory access.
=3D=3D31725=3D=3DHint: address points to the zero page.
    #0 0x55989846ee4a in print_symbol_events util/parse-events.c:2945
    #1 0x55989846f82e in print_events util/parse-events.c:2994
    #2 0x559898127d42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x55989839e029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x55989839e7d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x55989839ecf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x55989839f6d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7fb940c6409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x5598980c9999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31725=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31728=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x55f09f1ebe4b bp 0x7ffe456ba9d0 sp 0x7ffe456ba860 T0)
=3D=3D31728=3D=3DThe signal is caused by a READ memory access.
=3D=3D31728=3D=3DHint: address points to the zero page.
    #0 0x55f09f1ebe4a in print_symbol_events util/parse-events.c:2945
    #1 0x55f09f1ec82e in print_events util/parse-events.c:2994
    #2 0x55f09eea4d42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x55f09f11b029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x55f09f11b7d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x55f09f11bcf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x55f09f11c6d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f7ec568809a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x55f09ee46999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31728=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31731=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x5641a2371e4b bp 0x7ffc78d00da0 sp 0x7ffc78d00c30 T0)
=3D=3D31731=3D=3DThe signal is caused by a READ memory access.
=3D=3D31731=3D=3DHint: address points to the zero page.
    #0 0x5641a2371e4a in print_symbol_events util/parse-events.c:2945
    #1 0x5641a237282e in print_events util/parse-events.c:2994
    #2 0x5641a202ad42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x5641a22a1029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x5641a22a17d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x5641a22a1cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x5641a22a26d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f35344e809a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x5641a1fcc999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31731=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31734=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x558dcf194e4b bp 0x7ffdd414f060 sp 0x7ffdd414eef0 T0)
=3D=3D31734=3D=3DThe signal is caused by a READ memory access.
=3D=3D31734=3D=3DHint: address points to the zero page.
    #0 0x558dcf194e4a in print_symbol_events util/parse-events.c:2945
    #1 0x558dcf19582e in print_events util/parse-events.c:2994
    #2 0x558dcee4dd42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x558dcf0c4029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x558dcf0c47d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x558dcf0c4cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x558dcf0c56d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f463592309a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x558dcedef999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31734=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31737=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x55a67dd24e4b bp 0x7fffff062910 sp 0x7fffff0627a0 T0)
=3D=3D31737=3D=3DThe signal is caused by a READ memory access.
=3D=3D31737=3D=3DHint: address points to the zero page.
    #0 0x55a67dd24e4a in print_symbol_events util/parse-events.c:2945
    #1 0x55a67dd2582e in print_events util/parse-events.c:2994
    #2 0x55a67d9ddd42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x55a67dc54029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x55a67dc547d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x55a67dc54cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x55a67dc556d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f06e9bc809a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x55a67d97f999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31737=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31740=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x564dc3772e4b bp 0x7fffd2ec33d0 sp 0x7fffd2ec3260 T0)
=3D=3D31740=3D=3DThe signal is caused by a READ memory access.
=3D=3D31740=3D=3DHint: address points to the zero page.
    #0 0x564dc3772e4a in print_symbol_events util/parse-events.c:2945
    #1 0x564dc377382e in print_events util/parse-events.c:2994
    #2 0x564dc342bd42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x564dc36a2029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x564dc36a27d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x564dc36a2cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x564dc36a36d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7fb6c761409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x564dc33cd999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31740=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31743=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x5612b2ef7e4b bp 0x7fff51898480 sp 0x7fff51898310 T0)
=3D=3D31743=3D=3DThe signal is caused by a READ memory access.
=3D=3D31743=3D=3DHint: address points to the zero page.
    #0 0x5612b2ef7e4a in print_symbol_events util/parse-events.c:2945
    #1 0x5612b2ef882e in print_events util/parse-events.c:2994
    #2 0x5612b2bb0d42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x5612b2e27029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x5612b2e277d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x5612b2e27cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x5612b2e286d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f34617cf09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x5612b2b52999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31743=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31746=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x5615a0956e4b bp 0x7fffbdb85b00 sp 0x7fffbdb85990 T0)
=3D=3D31746=3D=3DThe signal is caused by a READ memory access.
=3D=3D31746=3D=3DHint: address points to the zero page.
    #0 0x5615a0956e4a in print_symbol_events util/parse-events.c:2945
    #1 0x5615a095782e in print_events util/parse-events.c:2994
    #2 0x5615a060fd42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x5615a0886029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x5615a08867d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x5615a0886cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x5615a08876d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7ff7ce17709a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x5615a05b1999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31746=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31749=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x55f0c2fb4e4b bp 0x7fffa5c49570 sp 0x7fffa5c49400 T0)
=3D=3D31749=3D=3DThe signal is caused by a READ memory access.
=3D=3D31749=3D=3DHint: address points to the zero page.
    #0 0x55f0c2fb4e4a in print_symbol_events util/parse-events.c:2945
    #1 0x55f0c2fb582e in print_events util/parse-events.c:2994
    #2 0x55f0c2c6dd42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x55f0c2ee4029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x55f0c2ee47d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x55f0c2ee4cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x55f0c2ee56d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f51da74309a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x55f0c2c0f999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31749=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31752=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x558a25a30e4b bp 0x7fff522f2970 sp 0x7fff522f2800 T0)
=3D=3D31752=3D=3DThe signal is caused by a READ memory access.
=3D=3D31752=3D=3DHint: address points to the zero page.
    #0 0x558a25a30e4a in print_symbol_events util/parse-events.c:2945
    #1 0x558a25a3182e in print_events util/parse-events.c:2994
    #2 0x558a256e9d42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x558a25960029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x558a259607d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x558a25960cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x558a259616d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f8e46c6009a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x558a2568b999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31752=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31755=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x5629de062e4b bp 0x7ffc2793da00 sp 0x7ffc2793d890 T0)
=3D=3D31755=3D=3DThe signal is caused by a READ memory access.
=3D=3D31755=3D=3DHint: address points to the zero page.
    #0 0x5629de062e4a in print_symbol_events util/parse-events.c:2945
    #1 0x5629de06382e in print_events util/parse-events.c:2994
    #2 0x5629ddd1bd42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x5629ddf92029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x5629ddf927d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x5629ddf92cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x5629ddf936d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f3c13ef009a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x5629ddcbd999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31755=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31761=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x55b18f01be4b bp 0x7ffc6a1b6c30 sp 0x7ffc6a1b6ac0 T0)
=3D=3D31761=3D=3DThe signal is caused by a READ memory access.
=3D=3D31761=3D=3DHint: address points to the zero page.
    #0 0x55b18f01be4a in print_symbol_events util/parse-events.c:2945
    #1 0x55b18f01c82e in print_events util/parse-events.c:2994
    #2 0x55b18ecd4d42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x55b18ef4b029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x55b18ef4b7d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x55b18ef4bcf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x55b18ef4c6d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f112c20409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x55b18ec76999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31761=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31764=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x5560d8e8fe4b bp 0x7ffe0bb44fb0 sp 0x7ffe0bb44e40 T0)
=3D=3D31764=3D=3DThe signal is caused by a READ memory access.
=3D=3D31764=3D=3DHint: address points to the zero page.
    #0 0x5560d8e8fe4a in print_symbol_events util/parse-events.c:2945
    #1 0x5560d8e9082e in print_events util/parse-events.c:2994
    #2 0x5560d8b48d42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x5560d8dbf029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x5560d8dbf7d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x5560d8dbfcf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x5560d8dc06d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7fabbdea109a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x5560d8aea999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31764=3D=3DABORTING
Thu May 20 09:08:40 UTC 2021
0 test cases pass for event_relation_checking test. 0 test cases fail for e=
vent_relation_checking test.
2021-05-20 09:08:40 ./freq_test/run.sh
util/cpumap.c:48:22: runtime error: member access within misaligned address=
 0x7fd4bb31103a for type 'struct perf_record_record_cpu_map', which require=
s 8 byte alignment
0x7fd4bb31103a: note: pointer points here
 20 00  01 00 01 00 08 00 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00=
 00 00  11 00 00 00 00 00
              ^=20
util/cpumap.c:48:33: runtime error: member access within misaligned address=
 0x7fd4bb31103a for type 'struct perf_record_record_cpu_map', which require=
s 8 byte alignment
0x7fd4bb31103a: note: pointer points here
 20 00  01 00 01 00 08 00 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00=
 00 00  11 00 00 00 00 00
              ^=20
util/cpumap.c:50:25: runtime error: member access within misaligned address=
 0x7fd4bb31103a for type 'struct perf_record_record_cpu_map', which require=
s 8 byte alignment
0x7fd4bb31103a: note: pointer points here
 20 00  01 00 01 00 08 00 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00=
 00 00  11 00 00 00 00 00
              ^=20
=2E./lib/bitmap.c:13:8: runtime error: load of misaligned address 0x7fd4bb3=
11042 for type 'const long unsigned int', which requires 8 byte alignment
0x7fd4bb311042: note: pointer points here
 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00 00 00  11 00 00 00 00 00=
 48 00  90 b4 00 c0 ff ff
              ^=20
util/cpumap.c:56:3: runtime error: member access within misaligned address =
0x7fd4bb31103a for type 'struct perf_record_record_cpu_map', which requires=
 8 byte alignment
0x7fd4bb31103a: note: pointer points here
 20 00  01 00 01 00 08 00 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00=
 00 00  11 00 00 00 00 00
              ^=20
=2E./lib/find_bit.c:91:11: runtime error: load of misaligned address 0x7fd4=
bb311042 for type 'const long unsigned int', which requires 8 byte alignment
0x7fd4bb311042: note: pointer points here
 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00 00 00  11 00 00 00 00 00=
 48 00  90 b4 00 c0 ff ff
              ^=20
=2E./lib/find_bit.c:92:11: runtime error: load of misaligned address 0x7fd4=
bb311042 for type 'const long unsigned int', which requires 8 byte alignment
0x7fd4bb311042: note: pointer points here
 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00 00 00  11 00 00 00 00 00=
 48 00  90 b4 00 c0 ff ff
              ^=20
util/cpumap.c:56:3: runtime error: member access within misaligned address =
0x7fd4bb31103a for type 'struct perf_record_record_cpu_map', which requires=
 8 byte alignment
0x7fd4bb31103a: note: pointer points here
 20 00  01 00 01 00 08 00 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00=
 00 00  11 00 00 00 00 00
              ^=20
=2E./lib/find_bit.c:41:6: runtime error: load of misaligned address 0x7fd4b=
b311042 for type 'const long unsigned int', which requires 8 byte alignment
0x7fd4bb311042: note: pointer points here
 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00 00 00  11 00 00 00 00 00=
 48 00  90 b4 00 c0 ff ff
              ^=20
util/bpf-event.c:57:7: runtime error: load of misaligned address 0x61500000=
18ae for type 'u64', which requires 8 byte alignment
0x6150000018ae: note: pointer points here
 5d 5b c9 c3 90 b4  00 c0 ff ff ff ff c6 00  00 00 7b e4 9e 39 34 a1  25 ba=
 be be be be be be  00 00
             ^=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31833=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 2736 byte(s) in 6 object(s) allocated from:
    #0 0x7fd4c04bf330 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/li=
basan.so.5+0xe9330)
    #1 0x555d2dc57b2f in process_bpf_prog_info util/header.c:2901
    #2 0x555d2dc5f604 in perf_file_section__process util/header.c:3651
    #3 0x555d2dc5d6dd in perf_header__process_sections util/header.c:3427
    #4 0x555d2dc61b80 in perf_session__read_header util/header.c:3886
    #5 0x555d2dcafc8c in perf_session__open util/session.c:109
    #6 0x555d2dcb0b91 in perf_session__new util/session.c:213
    #7 0x555d2d8c314b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #8 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 2208 byte(s) in 6 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dca5506 in map__new2 util/map.c:216
    #2 0x555d2dc88ba0 in machine__process_ksymbol_register util/machine.c:7=
78
    #3 0x555d2dc89abe in machine__process_ksymbol util/machine.c:844
    #4 0x555d2db60c0d in perf_event__process_ksymbol util/event.c:261
    #5 0x555d2dcc2ae5 in machines__deliver_event util/session.c:1547
    #6 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #7 0x555d2dcc5e7d in perf_session__process_event util/session.c:1803
    #8 0x555d2dccb69e in process_simple util/session.c:2267
    #9 0x555d2dccaefc in reader__process_events util/session.c:2233
    #10 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #11 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #12 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #13 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #14 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #15 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #16 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #17 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #18 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 736 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf720 in __interceptor_realloc (/usr/lib/x86_64-linux-gnu/l=
ibasan.so.5+0xe9720)
    #1 0x555d2dbf5b94 in strbuf_grow util/strbuf.c:64
    #2 0x555d2dbf600c in strbuf_add util/strbuf.c:86
    #3 0x555d2dd6c676 in strbuf_addstr util/strbuf.h:87
    #4 0x555d2dd8dd54 in add_key util/sort.c:3348
    #5 0x555d2dd8dfbe in add_sort_string util/sort.c:3361
    #6 0x555d2dd8e2e2 in sort_help util/sort.c:3387
    #7 0x555d2d8bdd35 in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1203
    #8 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 736 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf720 in __interceptor_realloc (/usr/lib/x86_64-linux-gnu/l=
ibasan.so.5+0xe9720)
    #1 0x555d2dbf5b94 in strbuf_grow util/strbuf.c:64
    #2 0x555d2dbf65ac in strbuf_addv util/strbuf.c:112
    #3 0x555d2dbf6a92 in strbuf_addf util/strbuf.c:134
    #4 0x555d2dd8ddd6 in add_key util/sort.c:3351
    #5 0x555d2dd8dfbe in add_sort_string util/sort.c:3361
    #6 0x555d2dd8e2e2 in sort_help util/sort.c:3387
    #7 0x555d2d8bdea9 in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1205
    #8 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 136 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf330 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/li=
basan.so.5+0xe9330)
    #1 0x555d2dbf2b2a in memdup ../lib/string.c:31
    #2 0x555d2dd838e5 in __hpp_dimension__alloc_hpp util/sort.c:2126
    #3 0x555d2dd8922a in __hpp_dimension__add_output util/sort.c:2761
    #4 0x555d2dd893c4 in hpp_dimension__add_output util/sort.c:2773
    #5 0x555d2e0445f4 in perf_hpp__init ui/hist.c:560
    #6 0x555d2dd8da6d in setup_sorting util/sort.c:3311
    #7 0x555d2d8c4d1f in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1535
    #8 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 129 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf720 in __interceptor_realloc (/usr/lib/x86_64-linux-gnu/l=
ibasan.so.5+0xe9720)
    #1 0x555d2dbf5b94 in strbuf_grow util/strbuf.c:64
    #2 0x555d2dbf559d in strbuf_init util/strbuf.c:25
    #3 0x555d2dc59090 in process_cpu_pmu_caps util/header.c:3022
    #4 0x555d2dc5f604 in perf_file_section__process util/header.c:3651
    #5 0x555d2dc5d6dd in perf_header__process_sections util/header.c:3427
    #6 0x555d2dc61b80 in perf_session__read_header util/header.c:3886
    #7 0x555d2dcafc8c in perf_session__open util/session.c:109
    #8 0x555d2dcb0b91 in perf_session__new util/session.c:213
    #9 0x555d2d8c314b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #10 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #11 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #12 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #13 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #14 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 64 byte(s) in 2 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dcd8e94 in nsinfo__copy util/namespaces.c:169
    #2 0x555d2dca4f7a in map__new util/map.c:168
    #3 0x555d2dc92e3d in machine__process_mmap2_event util/machine.c:1787
    #4 0x555d2db625a8 in perf_event__process_mmap2 util/event.c:368
    #5 0x555d2dcc1c75 in machines__deliver_event util/session.c:1507
    #6 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #7 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #8 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #9 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #10 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #11 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #12 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #13 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #14 0x555d2dccb69e in process_simple util/session.c:2267
    #15 0x555d2dccaefc in reader__process_events util/session.c:2233
    #16 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #17 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #18 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #19 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #20 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #21 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #22 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #23 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #24 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 24 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf720 in __interceptor_realloc (/usr/lib/x86_64-linux-gnu/l=
ibasan.so.5+0xe9720)
    #1 0x555d2dbf5b94 in strbuf_grow util/strbuf.c:64
    #2 0x555d2dbf600c in strbuf_add util/strbuf.c:86
    #3 0x555d2dc53311 in process_cpu_topology util/header.c:2470
    #4 0x555d2dc5f604 in perf_file_section__process util/header.c:3651
    #5 0x555d2dc5d6dd in perf_header__process_sections util/header.c:3427
    #6 0x555d2dc61b80 in perf_session__read_header util/header.c:3886
    #7 0x555d2dcafc8c in perf_session__open util/session.c:109
    #8 0x555d2dcb0b91 in perf_session__new util/session.c:213
    #9 0x555d2d8c314b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #10 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #11 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #12 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #13 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #14 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 8949742 byte(s) in 123484 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dc15e04 in symbol__new util/symbol.c:269
    #2 0x555d2dc19881 in map__process_kallsym_symbol util/symbol.c:710
    #3 0x555d2dbb0bb7 in kallsyms__parse ../lib/symbol/kallsyms.c:71
    #4 0x555d2dc1992c in dso__load_all_kallsyms util/symbol.c:729
    #5 0x555d2dc20acc in __dso__load_kallsyms util/symbol.c:1453
    #6 0x555d2dc20ffa in dso__load_kallsyms util/symbol.c:1476
    #7 0x555d2dc27724 in dso__load_kernel_sym util/symbol.c:2235
    #8 0x555d2dc24289 in dso__load util/symbol.c:1778
    #9 0x555d2dca67fb in map__load util/map.c:332
    #10 0x555d2db65569 in thread__find_map util/event.c:605
    #11 0x555d2db6642c in machine__resolve util/event.c:675
    #12 0x555d2d8b0b41 in process_sample_event /usr/src/perf_selftests-x86_=
64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-rep=
ort.c:273
    #13 0x555d2dcc1580 in evlist__deliver_sample util/session.c:1464
    #14 0x555d2dcc19de in machines__deliver_event util/session.c:1501
    #15 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #16 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #17 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #18 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #19 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #20 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #21 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #22 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #23 0x555d2dccb69e in process_simple util/session.c:2267
    #24 0x555d2dccaefc in reader__process_events util/session.c:2233
    #25 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #26 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #27 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #28 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #29 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313

Indirect leak of 448760 byte(s) in 863 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2dd98a9a in hist_entry__zalloc util/hist.c:535
    #3 0x555d2dd98d1d in hist_entry__new util/hist.c:562
    #4 0x555d2dd99ca0 in hists__findnew_entry util/hist.c:657
    #5 0x555d2dd9bd74 in __hists__add_entry util/hist.c:751
    #6 0x555d2dd9c112 in hists__add_entry util/hist.c:768
    #7 0x555d2dd9e6cb in iter_add_single_normal_entry util/hist.c:995
    #8 0x555d2dda0e11 in hist_entry_iter__add util/hist.c:1231
    #9 0x555d2d8b1733 in process_sample_event /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-repo=
rt.c:315
    #10 0x555d2dcc1580 in evlist__deliver_sample util/session.c:1464
    #11 0x555d2dcc19de in machines__deliver_event util/session.c:1501
    #12 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #13 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #14 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #15 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #16 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #17 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #18 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #19 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #20 0x555d2dccb69e in process_simple util/session.c:2267
    #21 0x555d2dccaefc in reader__process_events util/session.c:2233
    #22 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #23 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #24 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #25 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #26 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #27 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #28 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #29 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539

Indirect leak of 116376 byte(s) in 1927 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dc15e04 in symbol__new util/symbol.c:269
    #2 0x555d2df51239 in dso__load_sym util/symbol-elf.c:1283
    #3 0x555d2dc24f3a in dso__load util/symbol.c:1897
    #4 0x555d2dca67fb in map__load util/map.c:332
    #5 0x555d2dca6d61 in map__find_symbol util/map.c:366
    #6 0x555d2db6749a in machine__resolve util/event.c:707
    #7 0x555d2d8b0b41 in process_sample_event /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-repo=
rt.c:273
    #8 0x555d2dcc1580 in evlist__deliver_sample util/session.c:1464
    #9 0x555d2dcc19de in machines__deliver_event util/session.c:1501
    #10 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #11 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #12 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #13 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #15 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #16 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #18 0x555d2dccb69e in process_simple util/session.c:2267
    #19 0x555d2dccaefc in reader__process_events util/session.c:2233
    #20 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #21 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #22 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 2748 byte(s) in 6 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dc0be64 in dso__new_id util/dso.c:1256
    #2 0x555d2dc0d003 in dso__new util/dso.c:1295
    #3 0x555d2dc88aea in machine__process_ksymbol_register util/machine.c:7=
74
    #4 0x555d2dc89abe in machine__process_ksymbol util/machine.c:844
    #5 0x555d2db60c0d in perf_event__process_ksymbol util/event.c:261
    #6 0x555d2dcc2ae5 in machines__deliver_event util/session.c:1547
    #7 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #8 0x555d2dcc5e7d in perf_session__process_event util/session.c:1803
    #9 0x555d2dccb69e in process_simple util/session.c:2267
    #10 0x555d2dccaefc in reader__process_events util/session.c:2233
    #11 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #12 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #13 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #14 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #15 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #16 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #17 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #18 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #19 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 2704 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2db6ad31 in evlist__new util/evlist.c:77
    #3 0x555d2dc60d16 in perf_session__read_header util/header.c:3797
    #4 0x555d2dcafc8c in perf_session__open util/session.c:109
    #5 0x555d2dcb0b91 in perf_session__new util/session.c:213
    #6 0x555d2d8c314b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #7 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #8 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #9 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #10 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #11 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 2586 byte(s) in 47 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dc15e04 in symbol__new util/symbol.c:269
    #2 0x555d2df473e5 in dso__synthesize_plt_symbols util/symbol-elf.c:405
    #3 0x555d2dc24f72 in dso__load util/symbol.c:1904
    #4 0x555d2dca67fb in map__load util/map.c:332
    #5 0x555d2dca6d61 in map__find_symbol util/map.c:366
    #6 0x555d2db6749a in machine__resolve util/event.c:707
    #7 0x555d2d8b0b41 in process_sample_event /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-repo=
rt.c:273
    #8 0x555d2dcc1580 in evlist__deliver_sample util/session.c:1464
    #9 0x555d2dcc19de in machines__deliver_event util/session.c:1501
    #10 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #11 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #12 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #13 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #15 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #16 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #18 0x555d2dccb69e in process_simple util/session.c:2267
    #19 0x555d2dccaefc in reader__process_events util/session.c:2233
    #20 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #21 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #22 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 2321 byte(s) in 5 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dc0be64 in dso__new_id util/dso.c:1256
    #2 0x555d2dc11a0c in __dsos__addnew_id util/dsos.c:248
    #3 0x555d2dc11b99 in __dsos__findnew_id util/dsos.c:271
    #4 0x555d2dc11c45 in dsos__findnew_id util/dsos.c:278
    #5 0x555d2dca1d82 in machine__findnew_dso_id util/machine.c:3139
    #6 0x555d2dca5091 in map__new util/map.c:177
    #7 0x555d2dc92e3d in machine__process_mmap2_event util/machine.c:1787
    #8 0x555d2db625a8 in perf_event__process_mmap2 util/event.c:368
    #9 0x555d2dcc1c75 in machines__deliver_event util/session.c:1507
    #10 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #11 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #12 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #13 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #15 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #16 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #18 0x555d2dccb69e in process_simple util/session.c:2267
    #19 0x555d2dccaefc in reader__process_events util/session.c:2233
    #20 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #21 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #22 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 1440 byte(s) in 15 object(s) allocated from:
    #0 0x7fd4c04bf330 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/li=
basan.so.5+0xe9330)
    #1 0x555d2dca4be7 in map__new util/map.c:135
    #2 0x555d2dc92e3d in machine__process_mmap2_event util/machine.c:1787
    #3 0x555d2db625a8 in perf_event__process_mmap2 util/event.c:368
    #4 0x555d2dcc1c75 in machines__deliver_event util/session.c:1507
    #5 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #6 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #7 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #8 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #9 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #10 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #11 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #12 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #13 0x555d2dccb69e in process_simple util/session.c:2267
    #14 0x555d2dccaefc in reader__process_events util/session.c:2233
    #15 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #16 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #17 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #18 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #19 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #20 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #21 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #22 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #23 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 1356 byte(s) in 3 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dc0be64 in dso__new_id util/dso.c:1256
    #2 0x555d2dc11a0c in __dsos__addnew_id util/dsos.c:248
    #3 0x555d2dc11b99 in __dsos__findnew_id util/dsos.c:271
    #4 0x555d2dc11c45 in dsos__findnew_id util/dsos.c:278
    #5 0x555d2dca1d82 in machine__findnew_dso_id util/machine.c:3139
    #6 0x555d2dca1dcf in machine__findnew_dso util/machine.c:3144
    #7 0x555d2dc4edf8 in __event_process_build_id util/header.c:2080
    #8 0x555d2dc4fc81 in perf_header__read_build_ids util/header.c:2199
    #9 0x555d2dc50acb in process_build_id util/header.c:2232
    #10 0x555d2dc5f604 in perf_file_section__process util/header.c:3651
    #11 0x555d2dc5d6dd in perf_header__process_sections util/header.c:3427
    #12 0x555d2dc61b80 in perf_session__read_header util/header.c:3886
    #13 0x555d2dcafc8c in perf_session__open util/session.c:109
    #14 0x555d2dcb0b91 in perf_session__new util/session.c:213
    #15 0x555d2d8c314b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #16 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #17 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #18 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #19 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #20 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 1344 byte(s) in 14 object(s) allocated from:
    #0 0x7fd4c04bf330 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/li=
basan.so.5+0xe9330)
    #1 0x555d2dbf2b2a in memdup ../lib/string.c:31
    #2 0x555d2dca7169 in map__clone util/map.c:391
    #3 0x555d2dcac370 in maps__clone util/map.c:849
    #4 0x555d2dce13ff in thread__clone_maps util/thread.c:388
    #5 0x555d2dce163a in thread__fork util/thread.c:404
    #6 0x555d2dc9498c in machine__process_fork_event util/machine.c:1965
    #7 0x555d2db6288e in perf_event__process_fork util/event.c:383
    #8 0x555d2dcc1e9d in machines__deliver_event util/session.c:1515
    #9 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #10 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #11 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #12 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #13 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #14 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #15 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #16 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #17 0x555d2dccb69e in process_simple util/session.c:2267
    #18 0x555d2dccaefc in reader__process_events util/session.c:2233
    #19 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #20 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #21 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #22 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #23 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #24 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #25 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #26 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #27 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 904 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2db83341 in evsel__new_idx util/evsel.c:268
    #3 0x555d2dc3b444 in evsel__new util/evsel.h:210
    #4 0x555d2dc6163f in perf_session__read_header util/header.c:3853
    #5 0x555d2dcafc8c in perf_session__open util/session.c:109
    #6 0x555d2dcb0b91 in perf_session__new util/session.c:213
    #7 0x555d2d8c314b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #8 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 560 byte(s) in 2 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2dcddda8 in thread__new util/thread.c:43
    #3 0x555d2dc86dd5 in ____machine__findnew_thread util/machine.c:543
    #4 0x555d2dc870e9 in __machine__findnew_thread util/machine.c:574
    #5 0x555d2dc8719f in machine__findnew_thread util/machine.c:584
    #6 0x555d2dc94850 in machine__process_fork_event util/machine.c:1945
    #7 0x555d2db6288e in perf_event__process_fork util/event.c:383
    #8 0x555d2dcc1e9d in machines__deliver_event util/session.c:1515
    #9 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #10 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #11 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #12 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #13 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #14 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #15 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #16 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #17 0x555d2dccb69e in process_simple util/session.c:2267
    #18 0x555d2dccaefc in reader__process_events util/session.c:2233
    #19 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #20 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #21 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #22 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #23 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #24 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #25 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #26 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #27 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 520 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2dd98a9a in hist_entry__zalloc util/hist.c:535
    #3 0x555d2dd98d1d in hist_entry__new util/hist.c:562
    #4 0x555d2dd99ca0 in hists__findnew_entry util/hist.c:657
    #5 0x555d2dd9bd74 in __hists__add_entry util/hist.c:751
    #6 0x555d2dd9c112 in hists__add_entry util/hist.c:768
    #7 0x555d2dd9e6cb in iter_add_single_normal_entry util/hist.c:995
    #8 0x555d2dda0e11 in hist_entry_iter__add util/hist.c:1231
    #9 0x555d2d8b1733 in process_sample_event /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-repo=
rt.c:315
    #10 0x555d2dcc1580 in evlist__deliver_sample util/session.c:1464
    #11 0x555d2dcc19de in machines__deliver_event util/session.c:1501
    #12 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #13 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #14 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #15 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #16 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #17 0x555d2dccbb98 in __perf_session__process_events util/session.c:2294
    #18 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #19 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #20 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #21 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #22 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #23 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #24 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #25 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 488 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2e0e95d4 in xyarray__new /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/lib/perf/xyarray.c:10
    #3 0x555d2e0d82bc in perf_evsel__alloc_id /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/lib/perf/evsel.c:=
361
    #4 0x555d2dc618a2 in perf_session__read_header util/header.c:3871
    #5 0x555d2dcafc8c in perf_session__open util/session.c:109
    #6 0x555d2dcb0b91 in perf_session__new util/session.c:213
    #7 0x555d2d8c314b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #8 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 444 byte(s) in 6 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dc15e04 in symbol__new util/symbol.c:269
    #2 0x555d2dc89467 in machine__process_ksymbol_register util/machine.c:8=
03
    #3 0x555d2dc89abe in machine__process_ksymbol util/machine.c:844
    #4 0x555d2db60c0d in perf_event__process_ksymbol util/event.c:261
    #5 0x555d2dcc2ae5 in machines__deliver_event util/session.c:1547
    #6 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #7 0x555d2dcc5e7d in perf_session__process_event util/session.c:1803
    #8 0x555d2dccb69e in process_simple util/session.c:2267
    #9 0x555d2dccaefc in reader__process_events util/session.c:2233
    #10 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #11 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #12 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #13 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #14 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #15 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #16 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #17 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #18 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 368 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dca5506 in map__new2 util/map.c:216
    #2 0x555d2dc8cdc4 in __machine__create_kernel_maps util/machine.c:1202
    #3 0x555d2dc91a93 in machine__process_kernel_mmap_event util/machine.c:=
1706
    #4 0x555d2dc935eb in machine__process_mmap_event util/machine.c:1833
    #5 0x555d2db62554 in perf_event__process_mmap util/event.c:360
    #6 0x555d2dcc1a68 in machines__deliver_event util/session.c:1503
    #7 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #8 0x555d2dcc5e7d in perf_session__process_event util/session.c:1803
    #9 0x555d2dccb69e in process_simple util/session.c:2267
    #10 0x555d2dccaefc in reader__process_events util/session.c:2233
    #11 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #12 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #13 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #14 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #15 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #16 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #17 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #18 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #19 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 280 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2dcddda8 in thread__new util/thread.c:43
    #3 0x555d2dc86dd5 in ____machine__findnew_thread util/machine.c:543
    #4 0x555d2dc870e9 in __machine__findnew_thread util/machine.c:574
    #5 0x555d2dc8719f in machine__findnew_thread util/machine.c:584
    #6 0x555d2dc876b3 in machine__process_comm_event util/machine.c:631
    #7 0x555d2db60979 in perf_event__process_comm util/event.c:197
    #8 0x555d2dcc1cff in machines__deliver_event util/session.c:1509
    #9 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #10 0x555d2dcc5e7d in perf_session__process_event util/session.c:1803
    #11 0x555d2dccb69e in process_simple util/session.c:2267
    #12 0x555d2dccaefc in reader__process_events util/session.c:2233
    #13 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #14 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #15 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #16 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #17 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #18 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #19 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #20 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #21 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 240 byte(s) in 2 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2dcaa107 in maps__new util/map.c:630
    #3 0x555d2dcddb46 in thread__init_maps util/thread.c:27
    #4 0x555d2dc86e98 in ____machine__findnew_thread util/machine.c:555
    #5 0x555d2dc870e9 in __machine__findnew_thread util/machine.c:574
    #6 0x555d2dc8719f in machine__findnew_thread util/machine.c:584
    #7 0x555d2dc94850 in machine__process_fork_event util/machine.c:1945
    #8 0x555d2db6288e in perf_event__process_fork util/event.c:383
    #9 0x555d2dcc1e9d in machines__deliver_event util/session.c:1515
    #10 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #11 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #12 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #13 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #15 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #16 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #18 0x555d2dccb69e in process_simple util/session.c:2267
    #19 0x555d2dccaefc in reader__process_events util/session.c:2233
    #20 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #21 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #22 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 144 byte(s) in 3 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2dcdbab6 in comm__new util/comm.c:110
    #3 0x555d2dcdfc3d in ____thread__set_comm util/thread.c:250
    #4 0x555d2dcdfec5 in __thread__set_comm util/thread.c:270
    #5 0x555d2dc87962 in machine__process_comm_event util/machine.c:644
    #6 0x555d2db60979 in perf_event__process_comm util/event.c:197
    #7 0x555d2dcc1cff in machines__deliver_event util/session.c:1509
    #8 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #9 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #10 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #11 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #12 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #13 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #14 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #15 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #16 0x555d2dccb69e in process_simple util/session.c:2267
    #17 0x555d2dccaefc in reader__process_events util/session.c:2233
    #18 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #19 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #20 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #21 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #22 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #23 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #24 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #25 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #26 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 120 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2dcaa107 in maps__new util/map.c:630
    #3 0x555d2dcddb46 in thread__init_maps util/thread.c:27
    #4 0x555d2dc86e98 in ____machine__findnew_thread util/machine.c:555
    #5 0x555d2dc870e9 in __machine__findnew_thread util/machine.c:574
    #6 0x555d2dc8719f in machine__findnew_thread util/machine.c:584
    #7 0x555d2dc876b3 in machine__process_comm_event util/machine.c:631
    #8 0x555d2db60979 in perf_event__process_comm util/event.c:197
    #9 0x555d2dcc1cff in machines__deliver_event util/session.c:1509
    #10 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #11 0x555d2dcc5e7d in perf_session__process_event util/session.c:1803
    #12 0x555d2dccb69e in process_simple util/session.c:2267
    #13 0x555d2dccaefc in reader__process_events util/session.c:2233
    #14 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #15 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #16 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #17 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #18 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #19 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #20 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #21 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #22 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 96 byte(s) in 2 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2dcdbab6 in comm__new util/comm.c:110
    #3 0x555d2dcde217 in thread__new util/thread.c:61
    #4 0x555d2dc86dd5 in ____machine__findnew_thread util/machine.c:543
    #5 0x555d2dc870e9 in __machine__findnew_thread util/machine.c:574
    #6 0x555d2dc8719f in machine__findnew_thread util/machine.c:584
    #7 0x555d2dc94850 in machine__process_fork_event util/machine.c:1945
    #8 0x555d2db6288e in perf_event__process_fork util/event.c:383
    #9 0x555d2dcc1e9d in machines__deliver_event util/session.c:1515
    #10 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #11 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #12 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #13 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #15 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #16 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #18 0x555d2dccb69e in process_simple util/session.c:2267
    #19 0x555d2dccaefc in reader__process_events util/session.c:2233
    #20 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #21 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #22 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 68 byte(s) in 5 object(s) allocated from:
    #0 0x7fd4c0410810 in strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3=
a810)
    #1 0x555d2dc118bd in dso__set_basename util/dsos.c:236
    #2 0x555d2dc11a36 in __dsos__addnew_id util/dsos.c:252
    #3 0x555d2dc11b99 in __dsos__findnew_id util/dsos.c:271
    #4 0x555d2dc11c45 in dsos__findnew_id util/dsos.c:278
    #5 0x555d2dca1d82 in machine__findnew_dso_id util/machine.c:3139
    #6 0x555d2dca5091 in map__new util/map.c:177
    #7 0x555d2dc92e3d in machine__process_mmap2_event util/machine.c:1787
    #8 0x555d2db625a8 in perf_event__process_mmap2 util/event.c:368
    #9 0x555d2dcc1c75 in machines__deliver_event util/session.c:1507
    #10 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #11 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #12 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #13 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #15 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #16 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #18 0x555d2dccb69e in process_simple util/session.c:2267
    #19 0x555d2dccaefc in reader__process_events util/session.c:2233
    #20 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #21 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #22 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 64 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2e0d83d6 in perf_evsel__alloc_id /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/lib/perf/evsel.c:=
365
    #3 0x555d2dc618a2 in perf_session__read_header util/header.c:3871
    #4 0x555d2dcafc8c in perf_session__open util/session.c:109
    #5 0x555d2dcb0b91 in perf_session__new util/session.c:213
    #6 0x555d2d8c314b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #7 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #8 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #9 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #10 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #11 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2dcdbab6 in comm__new util/comm.c:110
    #3 0x555d2dcde217 in thread__new util/thread.c:61
    #4 0x555d2dc86dd5 in ____machine__findnew_thread util/machine.c:543
    #5 0x555d2dc870e9 in __machine__findnew_thread util/machine.c:574
    #6 0x555d2dc8719f in machine__findnew_thread util/machine.c:584
    #7 0x555d2dc876b3 in machine__process_comm_event util/machine.c:631
    #8 0x555d2db60979 in perf_event__process_comm util/event.c:197
    #9 0x555d2dcc1cff in machines__deliver_event util/session.c:1509
    #10 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #11 0x555d2dcc5e7d in perf_session__process_event util/session.c:1803
    #12 0x555d2dccb69e in process_simple util/session.c:2267
    #13 0x555d2dccaefc in reader__process_events util/session.c:2233
    #14 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #15 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #16 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #17 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #18 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #19 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #20 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #21 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #22 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 38 byte(s) in 3 object(s) allocated from:
    #0 0x7fd4c0410810 in strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3=
a810)
    #1 0x555d2dc118bd in dso__set_basename util/dsos.c:236
    #2 0x555d2dc11a36 in __dsos__addnew_id util/dsos.c:252
    #3 0x555d2dc11b99 in __dsos__findnew_id util/dsos.c:271
    #4 0x555d2dc11c45 in dsos__findnew_id util/dsos.c:278
    #5 0x555d2dca1d82 in machine__findnew_dso_id util/machine.c:3139
    #6 0x555d2dca1dcf in machine__findnew_dso util/machine.c:3144
    #7 0x555d2dc4edf8 in __event_process_build_id util/header.c:2080
    #8 0x555d2dc4fc81 in perf_header__read_build_ids util/header.c:2199
    #9 0x555d2dc50acb in process_build_id util/header.c:2232
    #10 0x555d2dc5f604 in perf_file_section__process util/header.c:3651
    #11 0x555d2dc5d6dd in perf_header__process_sections util/header.c:3427
    #12 0x555d2dc61b80 in perf_session__read_header util/header.c:3886
    #13 0x555d2dcafc8c in perf_session__open util/session.c:109
    #14 0x555d2dcb0b91 in perf_session__new util/session.c:213
    #15 0x555d2d8c314b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #16 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #17 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #18 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #19 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #20 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dcd8ac2 in nsinfo__new util/namespaces.c:142
    #2 0x555d2dcde3bf in thread__new util/thread.c:70
    #3 0x555d2dc86dd5 in ____machine__findnew_thread util/machine.c:543
    #4 0x555d2dc870e9 in __machine__findnew_thread util/machine.c:574
    #5 0x555d2dc8719f in machine__findnew_thread util/machine.c:584
    #6 0x555d2dc94850 in machine__process_fork_event util/machine.c:1945
    #7 0x555d2db6288e in perf_event__process_fork util/event.c:383
    #8 0x555d2dcc1e9d in machines__deliver_event util/session.c:1515
    #9 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #10 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #11 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #12 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #13 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #14 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #15 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #16 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #17 0x555d2dccb69e in process_simple util/session.c:2267
    #18 0x555d2dccaefc in reader__process_events util/session.c:2233
    #19 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #20 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #21 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #22 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #23 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #24 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #25 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #26 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #27 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dcd8e94 in nsinfo__copy util/namespaces.c:169
    #2 0x555d2dca4f7a in map__new util/map.c:168
    #3 0x555d2dc92e3d in machine__process_mmap2_event util/machine.c:1787
    #4 0x555d2db625a8 in perf_event__process_mmap2 util/event.c:368
    #5 0x555d2dcc1c75 in machines__deliver_event util/session.c:1507
    #6 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #7 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #8 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #9 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #10 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #11 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #12 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #13 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #14 0x555d2dccb69e in process_simple util/session.c:2267
    #15 0x555d2dccaefc in reader__process_events util/session.c:2233
    #16 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #17 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #18 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #19 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #20 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #21 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #22 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #23 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #24 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 12 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c0410810 in strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3=
a810)
    #1 0x555d2dc20235 in dso__load_kcore util/symbol.c:1402
    #2 0x555d2dc20e04 in __dso__load_kallsyms util/symbol.c:1467
    #3 0x555d2dc20ffa in dso__load_kallsyms util/symbol.c:1476
    #4 0x555d2dc27724 in dso__load_kernel_sym util/symbol.c:2235
    #5 0x555d2dc24289 in dso__load util/symbol.c:1778
    #6 0x555d2dca67fb in map__load util/map.c:332
    #7 0x555d2db65569 in thread__find_map util/event.c:605
    #8 0x555d2db6642c in machine__resolve util/event.c:675
    #9 0x555d2d8b0b41 in process_sample_event /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-repo=
rt.c:273
    #10 0x555d2dcc1580 in evlist__deliver_sample util/session.c:1464
    #11 0x555d2dcc19de in machines__deliver_event util/session.c:1501
    #12 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #13 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #14 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #15 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #16 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #17 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #18 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #19 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #20 0x555d2dccb69e in process_simple util/session.c:2267
    #21 0x555d2dccaefc in reader__process_events util/session.c:2233
    #22 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #23 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #24 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #25 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #26 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #27 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #28 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #29 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539

Indirect leak of 7 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c0410810 in strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3=
a810)
    #1 0x555d2dc514bd in evlist__set_event_name util/header.c:2292
    #2 0x555d2dc51805 in process_event_desc util/header.c:2313
    #3 0x555d2dc5f604 in perf_file_section__process util/header.c:3651
    #4 0x555d2dc5d6dd in perf_header__process_sections util/header.c:3427
    #5 0x555d2dc61b80 in perf_session__read_header util/header.c:3886
    #6 0x555d2dcafc8c in perf_session__open util/session.c:109
    #7 0x555d2dcb0b91 in perf_session__new util/session.c:213
    #8 0x555d2d8c314b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #9 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #10 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #11 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #12 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #13 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

SUMMARY: AddressSanitizer: 9540611 byte(s) leaked in 126419 allocation(s).
=2E/freq_test/run.sh: line 38: [: : integer expression expected
=2E/freq_test/run.sh: line 38: [: : integer expression expected
util/cpumap.c:48:22: runtime error: member access within misaligned address=
 0x7f6ff0a292ca for type 'struct perf_record_record_cpu_map', which require=
s 8 byte alignment
0x7f6ff0a292ca: note: pointer points here
 20 00  01 00 01 00 08 00 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00=
 00 00  11 00 00 00 00 00
              ^=20
util/cpumap.c:48:33: runtime error: member access within misaligned address=
 0x7f6ff0a292ca for type 'struct perf_record_record_cpu_map', which require=
s 8 byte alignment
0x7f6ff0a292ca: note: pointer points here
 20 00  01 00 01 00 08 00 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00=
 00 00  11 00 00 00 00 00
              ^=20
util/cpumap.c:50:25: runtime error: member access within misaligned address=
 0x7f6ff0a292ca for type 'struct perf_record_record_cpu_map', which require=
s 8 byte alignment
0x7f6ff0a292ca: note: pointer points here
 20 00  01 00 01 00 08 00 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00=
 00 00  11 00 00 00 00 00
              ^=20
=2E./lib/bitmap.c:13:8: runtime error: load of misaligned address 0x7f6ff0a=
292d2 for type 'const long unsigned int', which requires 8 byte alignment
0x7f6ff0a292d2: note: pointer points here
 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00 00 00  11 00 00 00 00 00=
 50 00  90 b4 00 c0 ff ff
              ^=20
util/cpumap.c:56:3: runtime error: member access within misaligned address =
0x7f6ff0a292ca for type 'struct perf_record_record_cpu_map', which requires=
 8 byte alignment
0x7f6ff0a292ca: note: pointer points here
 20 00  01 00 01 00 08 00 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00=
 00 00  11 00 00 00 00 00
              ^=20
=2E./lib/find_bit.c:91:11: runtime error: load of misaligned address 0x7f6f=
f0a292d2 for type 'const long unsigned int', which requires 8 byte alignment
0x7f6ff0a292d2: note: pointer points here
 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00 00 00  11 00 00 00 00 00=
 50 00  90 b4 00 c0 ff ff
              ^=20
=2E./lib/find_bit.c:92:11: runtime error: load of misaligned address 0x7f6f=
f0a292d2 for type 'const long unsigned int', which requires 8 byte alignment
0x7f6ff0a292d2: note: pointer points here
 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00 00 00  11 00 00 00 00 00=
 50 00  90 b4 00 c0 ff ff
              ^=20
util/cpumap.c:56:3: runtime error: member access within misaligned address =
0x7f6ff0a292ca for type 'struct perf_record_record_cpu_map', which requires=
 8 byte alignment
0x7f6ff0a292ca: note: pointer points here
 20 00  01 00 01 00 08 00 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00=
 00 00  11 00 00 00 00 00
              ^=20
=2E./lib/find_bit.c:41:6: runtime error: load of misaligned address 0x7f6ff=
0a292d2 for type 'const long unsigned int', which requires 8 byte alignment
0x7f6ff0a292d2: note: pointer points here
 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00 00 00  11 00 00 00 00 00=
 50 00  90 b4 00 c0 ff ff
              ^=20
util/bpf-event.c:57:7: runtime error: load of misaligned address 0x61500000=
1dae for type 'u64', which requires 8 byte alignment
0x615000001dae: note: pointer points here
 5d 5b c9 c3 90 b4  00 c0 ff ff ff ff c6 00  00 00 7b e4 9e 39 34 a1  25 ba=
 be be be be be be  00 00
             ^=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31883=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 2736 byte(s) in 6 object(s) allocated from:
    #0 0x7f6ff6027330 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/li=
basan.so.5+0xe9330)
    #1 0x55850efb6b2f in process_bpf_prog_info util/header.c:2901
    #2 0x55850efbe604 in perf_file_section__process util/header.c:3651
    #3 0x55850efbc6dd in perf_header__process_sections util/header.c:3427
    #4 0x55850efc0b80 in perf_session__read_header util/header.c:3886
    #5 0x55850f00ec8c in perf_session__open util/session.c:109
    #6 0x55850f00fb91 in perf_session__new util/session.c:213
    #7 0x55850ec2214b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #8 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 2208 byte(s) in 6 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f004506 in map__new2 util/map.c:216
    #2 0x55850efe7ba0 in machine__process_ksymbol_register util/machine.c:7=
78
    #3 0x55850efe8abe in machine__process_ksymbol util/machine.c:844
    #4 0x55850eebfc0d in perf_event__process_ksymbol util/event.c:261
    #5 0x55850f021ae5 in machines__deliver_event util/session.c:1547
    #6 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #7 0x55850f024e7d in perf_session__process_event util/session.c:1803
    #8 0x55850f02a69e in process_simple util/session.c:2267
    #9 0x55850f029efc in reader__process_events util/session.c:2233
    #10 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #11 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #12 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #13 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #14 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #15 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #16 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #17 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #18 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 736 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027720 in __interceptor_realloc (/usr/lib/x86_64-linux-gnu/l=
ibasan.so.5+0xe9720)
    #1 0x55850ef54b94 in strbuf_grow util/strbuf.c:64
    #2 0x55850ef5500c in strbuf_add util/strbuf.c:86
    #3 0x55850f0cb676 in strbuf_addstr util/strbuf.h:87
    #4 0x55850f0ecd54 in add_key util/sort.c:3348
    #5 0x55850f0ecfbe in add_sort_string util/sort.c:3361
    #6 0x55850f0ed2e2 in sort_help util/sort.c:3387
    #7 0x55850ec1cd35 in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1203
    #8 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 736 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027720 in __interceptor_realloc (/usr/lib/x86_64-linux-gnu/l=
ibasan.so.5+0xe9720)
    #1 0x55850ef54b94 in strbuf_grow util/strbuf.c:64
    #2 0x55850ef555ac in strbuf_addv util/strbuf.c:112
    #3 0x55850ef55a92 in strbuf_addf util/strbuf.c:134
    #4 0x55850f0ecdd6 in add_key util/sort.c:3351
    #5 0x55850f0ecfbe in add_sort_string util/sort.c:3361
    #6 0x55850f0ed2e2 in sort_help util/sort.c:3387
    #7 0x55850ec1cea9 in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1205
    #8 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 136 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027330 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/li=
basan.so.5+0xe9330)
    #1 0x55850ef51b2a in memdup ../lib/string.c:31
    #2 0x55850f0e28e5 in __hpp_dimension__alloc_hpp util/sort.c:2126
    #3 0x55850f0e822a in __hpp_dimension__add_output util/sort.c:2761
    #4 0x55850f0e83c4 in hpp_dimension__add_output util/sort.c:2773
    #5 0x55850f3a35f4 in perf_hpp__init ui/hist.c:560
    #6 0x55850f0eca6d in setup_sorting util/sort.c:3311
    #7 0x55850ec23d1f in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1535
    #8 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 129 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027720 in __interceptor_realloc (/usr/lib/x86_64-linux-gnu/l=
ibasan.so.5+0xe9720)
    #1 0x55850ef54b94 in strbuf_grow util/strbuf.c:64
    #2 0x55850ef5459d in strbuf_init util/strbuf.c:25
    #3 0x55850efb8090 in process_cpu_pmu_caps util/header.c:3022
    #4 0x55850efbe604 in perf_file_section__process util/header.c:3651
    #5 0x55850efbc6dd in perf_header__process_sections util/header.c:3427
    #6 0x55850efc0b80 in perf_session__read_header util/header.c:3886
    #7 0x55850f00ec8c in perf_session__open util/session.c:109
    #8 0x55850f00fb91 in perf_session__new util/session.c:213
    #9 0x55850ec2214b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #10 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #11 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #12 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #13 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #14 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 64 byte(s) in 2 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f037e94 in nsinfo__copy util/namespaces.c:169
    #2 0x55850f003f7a in map__new util/map.c:168
    #3 0x55850eff1e3d in machine__process_mmap2_event util/machine.c:1787
    #4 0x55850eec15a8 in perf_event__process_mmap2 util/event.c:368
    #5 0x55850f020c75 in machines__deliver_event util/session.c:1507
    #6 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #7 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #8 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #9 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #10 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #11 0x55850f01c0ca in process_finished_round util/session.c:1061
    #12 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #13 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #14 0x55850f02a69e in process_simple util/session.c:2267
    #15 0x55850f029efc in reader__process_events util/session.c:2233
    #16 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #17 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #18 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #19 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #20 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #21 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #22 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #23 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #24 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 24 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027720 in __interceptor_realloc (/usr/lib/x86_64-linux-gnu/l=
ibasan.so.5+0xe9720)
    #1 0x55850ef54b94 in strbuf_grow util/strbuf.c:64
    #2 0x55850ef5500c in strbuf_add util/strbuf.c:86
    #3 0x55850efb2311 in process_cpu_topology util/header.c:2470
    #4 0x55850efbe604 in perf_file_section__process util/header.c:3651
    #5 0x55850efbc6dd in perf_header__process_sections util/header.c:3427
    #6 0x55850efc0b80 in perf_session__read_header util/header.c:3886
    #7 0x55850f00ec8c in perf_session__open util/session.c:109
    #8 0x55850f00fb91 in perf_session__new util/session.c:213
    #9 0x55850ec2214b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #10 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #11 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #12 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #13 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #14 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 8949742 byte(s) in 123484 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850ef74e04 in symbol__new util/symbol.c:269
    #2 0x55850ef78881 in map__process_kallsym_symbol util/symbol.c:710
    #3 0x55850ef0fbb7 in kallsyms__parse ../lib/symbol/kallsyms.c:71
    #4 0x55850ef7892c in dso__load_all_kallsyms util/symbol.c:729
    #5 0x55850ef7facc in __dso__load_kallsyms util/symbol.c:1453
    #6 0x55850ef7fffa in dso__load_kallsyms util/symbol.c:1476
    #7 0x55850ef86724 in dso__load_kernel_sym util/symbol.c:2235
    #8 0x55850ef83289 in dso__load util/symbol.c:1778
    #9 0x55850f0057fb in map__load util/map.c:332
    #10 0x55850eec4569 in thread__find_map util/event.c:605
    #11 0x55850eec542c in machine__resolve util/event.c:675
    #12 0x55850ec0fb41 in process_sample_event /usr/src/perf_selftests-x86_=
64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-rep=
ort.c:273
    #13 0x55850f020580 in evlist__deliver_sample util/session.c:1464
    #14 0x55850f0209de in machines__deliver_event util/session.c:1501
    #15 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #16 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #17 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #18 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #19 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #20 0x55850f01c0ca in process_finished_round util/session.c:1061
    #21 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #22 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #23 0x55850f02a69e in process_simple util/session.c:2267
    #24 0x55850f029efc in reader__process_events util/session.c:2233
    #25 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #26 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #27 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #28 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #29 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313

Indirect leak of 852800 byte(s) in 1640 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850f0f7a9a in hist_entry__zalloc util/hist.c:535
    #3 0x55850f0f7d1d in hist_entry__new util/hist.c:562
    #4 0x55850f0f8ca0 in hists__findnew_entry util/hist.c:657
    #5 0x55850f0fad74 in __hists__add_entry util/hist.c:751
    #6 0x55850f0fb112 in hists__add_entry util/hist.c:768
    #7 0x55850f0fd6cb in iter_add_single_normal_entry util/hist.c:995
    #8 0x55850f0ffe11 in hist_entry_iter__add util/hist.c:1231
    #9 0x55850ec10733 in process_sample_event /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-repo=
rt.c:315
    #10 0x55850f020580 in evlist__deliver_sample util/session.c:1464
    #11 0x55850f0209de in machines__deliver_event util/session.c:1501
    #12 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #13 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #14 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #15 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #16 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #17 0x55850f01c0ca in process_finished_round util/session.c:1061
    #18 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #19 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #20 0x55850f02a69e in process_simple util/session.c:2267
    #21 0x55850f029efc in reader__process_events util/session.c:2233
    #22 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #23 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #24 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #25 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #26 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #27 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #28 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #29 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539

Indirect leak of 118311 byte(s) in 1957 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850ef74e04 in symbol__new util/symbol.c:269
    #2 0x55850f2b0239 in dso__load_sym util/symbol-elf.c:1283
    #3 0x55850ef83f3a in dso__load util/symbol.c:1897
    #4 0x55850f0057fb in map__load util/map.c:332
    #5 0x55850f005d61 in map__find_symbol util/map.c:366
    #6 0x55850eec649a in machine__resolve util/event.c:707
    #7 0x55850ec0fb41 in process_sample_event /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-repo=
rt.c:273
    #8 0x55850f020580 in evlist__deliver_sample util/session.c:1464
    #9 0x55850f0209de in machines__deliver_event util/session.c:1501
    #10 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #11 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #12 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #13 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #15 0x55850f01c0ca in process_finished_round util/session.c:1061
    #16 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #18 0x55850f02a69e in process_simple util/session.c:2267
    #19 0x55850f029efc in reader__process_events util/session.c:2233
    #20 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #21 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #22 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 8181 byte(s) in 139 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850ef74e04 in symbol__new util/symbol.c:269
    #2 0x55850f2a63e5 in dso__synthesize_plt_symbols util/symbol-elf.c:405
    #3 0x55850ef83f72 in dso__load util/symbol.c:1904
    #4 0x55850f0057fb in map__load util/map.c:332
    #5 0x55850f005d61 in map__find_symbol util/map.c:366
    #6 0x55850eec649a in machine__resolve util/event.c:707
    #7 0x55850ec0fb41 in process_sample_event /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-repo=
rt.c:273
    #8 0x55850f020580 in evlist__deliver_sample util/session.c:1464
    #9 0x55850f0209de in machines__deliver_event util/session.c:1501
    #10 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #11 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #12 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #13 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #15 0x55850f01c0ca in process_finished_round util/session.c:1061
    #16 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #18 0x55850f02a69e in process_simple util/session.c:2267
    #19 0x55850f029efc in reader__process_events util/session.c:2233
    #20 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #21 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #22 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 3640 byte(s) in 7 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850f0f7a9a in hist_entry__zalloc util/hist.c:535
    #3 0x55850f0f7d1d in hist_entry__new util/hist.c:562
    #4 0x55850f0f8ca0 in hists__findnew_entry util/hist.c:657
    #5 0x55850f0fad74 in __hists__add_entry util/hist.c:751
    #6 0x55850f0fb112 in hists__add_entry util/hist.c:768
    #7 0x55850f0fd6cb in iter_add_single_normal_entry util/hist.c:995
    #8 0x55850f0ffe11 in hist_entry_iter__add util/hist.c:1231
    #9 0x55850ec10733 in process_sample_event /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-repo=
rt.c:315
    #10 0x55850f020580 in evlist__deliver_sample util/session.c:1464
    #11 0x55850f0209de in machines__deliver_event util/session.c:1501
    #12 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #13 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #14 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #15 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #16 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #17 0x55850f02ab98 in __perf_session__process_events util/session.c:2294
    #18 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #19 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #20 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #21 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #22 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #23 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #24 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #25 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 2748 byte(s) in 6 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850ef6ae64 in dso__new_id util/dso.c:1256
    #2 0x55850ef6c003 in dso__new util/dso.c:1295
    #3 0x55850efe7aea in machine__process_ksymbol_register util/machine.c:7=
74
    #4 0x55850efe8abe in machine__process_ksymbol util/machine.c:844
    #5 0x55850eebfc0d in perf_event__process_ksymbol util/event.c:261
    #6 0x55850f021ae5 in machines__deliver_event util/session.c:1547
    #7 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #8 0x55850f024e7d in perf_session__process_event util/session.c:1803
    #9 0x55850f02a69e in process_simple util/session.c:2267
    #10 0x55850f029efc in reader__process_events util/session.c:2233
    #11 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #12 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #13 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #14 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #15 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #16 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #17 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #18 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #19 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 2704 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850eec9d31 in evlist__new util/evlist.c:77
    #3 0x55850efbfd16 in perf_session__read_header util/header.c:3797
    #4 0x55850f00ec8c in perf_session__open util/session.c:109
    #5 0x55850f00fb91 in perf_session__new util/session.c:213
    #6 0x55850ec2214b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #7 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #8 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #9 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #10 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #11 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 2263 byte(s) in 5 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850ef6ae64 in dso__new_id util/dso.c:1256
    #2 0x55850ef70a0c in __dsos__addnew_id util/dsos.c:248
    #3 0x55850ef70b99 in __dsos__findnew_id util/dsos.c:271
    #4 0x55850ef70c45 in dsos__findnew_id util/dsos.c:278
    #5 0x55850f000d82 in machine__findnew_dso_id util/machine.c:3139
    #6 0x55850f000dcf in machine__findnew_dso util/machine.c:3144
    #7 0x55850efaddf8 in __event_process_build_id util/header.c:2080
    #8 0x55850efaec81 in perf_header__read_build_ids util/header.c:2199
    #9 0x55850efafacb in process_build_id util/header.c:2232
    #10 0x55850efbe604 in perf_file_section__process util/header.c:3651
    #11 0x55850efbc6dd in perf_header__process_sections util/header.c:3427
    #12 0x55850efc0b80 in perf_session__read_header util/header.c:3886
    #13 0x55850f00ec8c in perf_session__open util/session.c:109
    #14 0x55850f00fb91 in perf_session__new util/session.c:213
    #15 0x55850ec2214b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #16 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #17 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #18 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #19 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #20 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 1808 byte(s) in 2 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850eee2341 in evsel__new_idx util/evsel.c:268
    #3 0x55850ef9a444 in evsel__new util/evsel.h:210
    #4 0x55850efc063f in perf_session__read_header util/header.c:3853
    #5 0x55850f00ec8c in perf_session__open util/session.c:109
    #6 0x55850f00fb91 in perf_session__new util/session.c:213
    #7 0x55850ec2214b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #8 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 1440 byte(s) in 15 object(s) allocated from:
    #0 0x7f6ff6027330 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/li=
basan.so.5+0xe9330)
    #1 0x55850f003be7 in map__new util/map.c:135
    #2 0x55850eff1e3d in machine__process_mmap2_event util/machine.c:1787
    #3 0x55850eec15a8 in perf_event__process_mmap2 util/event.c:368
    #4 0x55850f020c75 in machines__deliver_event util/session.c:1507
    #5 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #6 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #7 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #8 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #9 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #10 0x55850f01c0ca in process_finished_round util/session.c:1061
    #11 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #12 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #13 0x55850f02a69e in process_simple util/session.c:2267
    #14 0x55850f029efc in reader__process_events util/session.c:2233
    #15 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #16 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #17 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #18 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #19 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #20 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #21 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #22 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #23 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 1413 byte(s) in 3 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850ef6ae64 in dso__new_id util/dso.c:1256
    #2 0x55850ef70a0c in __dsos__addnew_id util/dsos.c:248
    #3 0x55850ef70b99 in __dsos__findnew_id util/dsos.c:271
    #4 0x55850ef70c45 in dsos__findnew_id util/dsos.c:278
    #5 0x55850f000d82 in machine__findnew_dso_id util/machine.c:3139
    #6 0x55850f004091 in map__new util/map.c:177
    #7 0x55850eff1e3d in machine__process_mmap2_event util/machine.c:1787
    #8 0x55850eec15a8 in perf_event__process_mmap2 util/event.c:368
    #9 0x55850f020c75 in machines__deliver_event util/session.c:1507
    #10 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #11 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #12 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #13 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #15 0x55850f01c0ca in process_finished_round util/session.c:1061
    #16 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #18 0x55850f02a69e in process_simple util/session.c:2267
    #19 0x55850f029efc in reader__process_events util/session.c:2233
    #20 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #21 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #22 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 1344 byte(s) in 14 object(s) allocated from:
    #0 0x7f6ff6027330 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/li=
basan.so.5+0xe9330)
    #1 0x55850ef51b2a in memdup ../lib/string.c:31
    #2 0x55850f006169 in map__clone util/map.c:391
    #3 0x55850f00b370 in maps__clone util/map.c:849
    #4 0x55850f0403ff in thread__clone_maps util/thread.c:388
    #5 0x55850f04063a in thread__fork util/thread.c:404
    #6 0x55850eff398c in machine__process_fork_event util/machine.c:1965
    #7 0x55850eec188e in perf_event__process_fork util/event.c:383
    #8 0x55850f020e9d in machines__deliver_event util/session.c:1515
    #9 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #10 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #11 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #12 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #13 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #14 0x55850f01c0ca in process_finished_round util/session.c:1061
    #15 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #16 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #17 0x55850f02a69e in process_simple util/session.c:2267
    #18 0x55850f029efc in reader__process_events util/session.c:2233
    #19 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #20 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #21 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #22 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #23 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #24 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #25 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #26 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #27 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 976 byte(s) in 2 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850f4485d4 in xyarray__new /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/lib/perf/xyarray.c:10
    #3 0x55850f4372bc in perf_evsel__alloc_id /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/lib/perf/evsel.c:=
361
    #4 0x55850efc08a2 in perf_session__read_header util/header.c:3871
    #5 0x55850f00ec8c in perf_session__open util/session.c:109
    #6 0x55850f00fb91 in perf_session__new util/session.c:213
    #7 0x55850ec2214b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #8 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 560 byte(s) in 2 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850f03cda8 in thread__new util/thread.c:43
    #3 0x55850efe5dd5 in ____machine__findnew_thread util/machine.c:543
    #4 0x55850efe60e9 in __machine__findnew_thread util/machine.c:574
    #5 0x55850efe619f in machine__findnew_thread util/machine.c:584
    #6 0x55850eff3850 in machine__process_fork_event util/machine.c:1945
    #7 0x55850eec188e in perf_event__process_fork util/event.c:383
    #8 0x55850f020e9d in machines__deliver_event util/session.c:1515
    #9 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #10 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #11 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #12 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #13 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #14 0x55850f01c0ca in process_finished_round util/session.c:1061
    #15 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #16 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #17 0x55850f02a69e in process_simple util/session.c:2267
    #18 0x55850f029efc in reader__process_events util/session.c:2233
    #19 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #20 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #21 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #22 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #23 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #24 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #25 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #26 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #27 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 444 byte(s) in 6 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850ef74e04 in symbol__new util/symbol.c:269
    #2 0x55850efe8467 in machine__process_ksymbol_register util/machine.c:8=
03
    #3 0x55850efe8abe in machine__process_ksymbol util/machine.c:844
    #4 0x55850eebfc0d in perf_event__process_ksymbol util/event.c:261
    #5 0x55850f021ae5 in machines__deliver_event util/session.c:1547
    #6 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #7 0x55850f024e7d in perf_session__process_event util/session.c:1803
    #8 0x55850f02a69e in process_simple util/session.c:2267
    #9 0x55850f029efc in reader__process_events util/session.c:2233
    #10 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #11 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #12 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #13 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #14 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #15 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #16 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #17 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #18 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 368 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f004506 in map__new2 util/map.c:216
    #2 0x55850efebdc4 in __machine__create_kernel_maps util/machine.c:1202
    #3 0x55850eff0a93 in machine__process_kernel_mmap_event util/machine.c:=
1706
    #4 0x55850eff25eb in machine__process_mmap_event util/machine.c:1833
    #5 0x55850eec1554 in perf_event__process_mmap util/event.c:360
    #6 0x55850f020a68 in machines__deliver_event util/session.c:1503
    #7 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #8 0x55850f024e7d in perf_session__process_event util/session.c:1803
    #9 0x55850f02a69e in process_simple util/session.c:2267
    #10 0x55850f029efc in reader__process_events util/session.c:2233
    #11 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #12 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #13 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #14 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #15 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #16 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #17 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #18 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #19 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 280 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850f03cda8 in thread__new util/thread.c:43
    #3 0x55850efe5dd5 in ____machine__findnew_thread util/machine.c:543
    #4 0x55850efe60e9 in __machine__findnew_thread util/machine.c:574
    #5 0x55850efe619f in machine__findnew_thread util/machine.c:584
    #6 0x55850efe66b3 in machine__process_comm_event util/machine.c:631
    #7 0x55850eebf979 in perf_event__process_comm util/event.c:197
    #8 0x55850f020cff in machines__deliver_event util/session.c:1509
    #9 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #10 0x55850f024e7d in perf_session__process_event util/session.c:1803
    #11 0x55850f02a69e in process_simple util/session.c:2267
    #12 0x55850f029efc in reader__process_events util/session.c:2233
    #13 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #14 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #15 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #16 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #17 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #18 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #19 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #20 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #21 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 240 byte(s) in 2 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850f009107 in maps__new util/map.c:630
    #3 0x55850f03cb46 in thread__init_maps util/thread.c:27
    #4 0x55850efe5e98 in ____machine__findnew_thread util/machine.c:555
    #5 0x55850efe60e9 in __machine__findnew_thread util/machine.c:574
    #6 0x55850efe619f in machine__findnew_thread util/machine.c:584
    #7 0x55850eff3850 in machine__process_fork_event util/machine.c:1945
    #8 0x55850eec188e in perf_event__process_fork util/event.c:383
    #9 0x55850f020e9d in machines__deliver_event util/session.c:1515
    #10 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #11 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #12 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #13 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #15 0x55850f01c0ca in process_finished_round util/session.c:1061
    #16 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #18 0x55850f02a69e in process_simple util/session.c:2267
    #19 0x55850f029efc in reader__process_events util/session.c:2233
    #20 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #21 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #22 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 144 byte(s) in 3 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850f03aab6 in comm__new util/comm.c:110
    #3 0x55850f03ec3d in ____thread__set_comm util/thread.c:250
    #4 0x55850f03eec5 in __thread__set_comm util/thread.c:270
    #5 0x55850efe6962 in machine__process_comm_event util/machine.c:644
    #6 0x55850eebf979 in perf_event__process_comm util/event.c:197
    #7 0x55850f020cff in machines__deliver_event util/session.c:1509
    #8 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #9 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #10 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #11 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #12 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #13 0x55850f01c0ca in process_finished_round util/session.c:1061
    #14 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #15 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #16 0x55850f02a69e in process_simple util/session.c:2267
    #17 0x55850f029efc in reader__process_events util/session.c:2233
    #18 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #19 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #20 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #21 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #22 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #23 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #24 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #25 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #26 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 128 byte(s) in 2 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850f4373d6 in perf_evsel__alloc_id /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/lib/perf/evsel.c:=
365
    #3 0x55850efc08a2 in perf_session__read_header util/header.c:3871
    #4 0x55850f00ec8c in perf_session__open util/session.c:109
    #5 0x55850f00fb91 in perf_session__new util/session.c:213
    #6 0x55850ec2214b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #7 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #8 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #9 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #10 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #11 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 120 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850f009107 in maps__new util/map.c:630
    #3 0x55850f03cb46 in thread__init_maps util/thread.c:27
    #4 0x55850efe5e98 in ____machine__findnew_thread util/machine.c:555
    #5 0x55850efe60e9 in __machine__findnew_thread util/machine.c:574
    #6 0x55850efe619f in machine__findnew_thread util/machine.c:584
    #7 0x55850efe66b3 in machine__process_comm_event util/machine.c:631
    #8 0x55850eebf979 in perf_event__process_comm util/event.c:197
    #9 0x55850f020cff in machines__deliver_event util/session.c:1509
    #10 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #11 0x55850f024e7d in perf_session__process_event util/session.c:1803
    #12 0x55850f02a69e in process_simple util/session.c:2267
    #13 0x55850f029efc in reader__process_events util/session.c:2233
    #14 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #15 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #16 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #17 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #18 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #19 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #20 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #21 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #22 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 96 byte(s) in 2 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850f03aab6 in comm__new util/comm.c:110
    #3 0x55850f03d217 in thread__new util/thread.c:61
    #4 0x55850efe5dd5 in ____machine__findnew_thread util/machine.c:543
    #5 0x55850efe60e9 in __machine__findnew_thread util/machine.c:574
    #6 0x55850efe619f in machine__findnew_thread util/machine.c:584
    #7 0x55850eff3850 in machine__process_fork_event util/machine.c:1945
    #8 0x55850eec188e in perf_event__process_fork util/event.c:383
    #9 0x55850f020e9d in machines__deliver_event util/session.c:1515
    #10 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #11 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #12 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #13 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #15 0x55850f01c0ca in process_finished_round util/session.c:1061
    #16 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #18 0x55850f02a69e in process_simple util/session.c:2267
    #19 0x55850f029efc in reader__process_events util/session.c:2233
    #20 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #21 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #22 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 54 byte(s) in 5 object(s) allocated from:
    #0 0x7f6ff5f78810 in strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3=
a810)
    #1 0x55850ef708bd in dso__set_basename util/dsos.c:236
    #2 0x55850ef70a36 in __dsos__addnew_id util/dsos.c:252
    #3 0x55850ef70b99 in __dsos__findnew_id util/dsos.c:271
    #4 0x55850ef70c45 in dsos__findnew_id util/dsos.c:278
    #5 0x55850f000d82 in machine__findnew_dso_id util/machine.c:3139
    #6 0x55850f000dcf in machine__findnew_dso util/machine.c:3144
    #7 0x55850efaddf8 in __event_process_build_id util/header.c:2080
    #8 0x55850efaec81 in perf_header__read_build_ids util/header.c:2199
    #9 0x55850efafacb in process_build_id util/header.c:2232
    #10 0x55850efbe604 in perf_file_section__process util/header.c:3651
    #11 0x55850efbc6dd in perf_header__process_sections util/header.c:3427
    #12 0x55850efc0b80 in perf_session__read_header util/header.c:3886
    #13 0x55850f00ec8c in perf_session__open util/session.c:109
    #14 0x55850f00fb91 in perf_session__new util/session.c:213
    #15 0x55850ec2214b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #16 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #17 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #18 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #19 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #20 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 51 byte(s) in 3 object(s) allocated from:
    #0 0x7f6ff5f78810 in strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3=
a810)
    #1 0x55850ef708bd in dso__set_basename util/dsos.c:236
    #2 0x55850ef70a36 in __dsos__addnew_id util/dsos.c:252
    #3 0x55850ef70b99 in __dsos__findnew_id util/dsos.c:271
    #4 0x55850ef70c45 in dsos__findnew_id util/dsos.c:278
    #5 0x55850f000d82 in machine__findnew_dso_id util/machine.c:3139
    #6 0x55850f004091 in map__new util/map.c:177
    #7 0x55850eff1e3d in machine__process_mmap2_event util/machine.c:1787
    #8 0x55850eec15a8 in perf_event__process_mmap2 util/event.c:368
    #9 0x55850f020c75 in machines__deliver_event util/session.c:1507
    #10 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #11 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #12 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #13 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #15 0x55850f01c0ca in process_finished_round util/session.c:1061
    #16 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #18 0x55850f02a69e in process_simple util/session.c:2267
    #19 0x55850f029efc in reader__process_events util/session.c:2233
    #20 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #21 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #22 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850f03aab6 in comm__new util/comm.c:110
    #3 0x55850f03d217 in thread__new util/thread.c:61
    #4 0x55850efe5dd5 in ____machine__findnew_thread util/machine.c:543
    #5 0x55850efe60e9 in __machine__findnew_thread util/machine.c:574
    #6 0x55850efe619f in machine__findnew_thread util/machine.c:584
    #7 0x55850efe66b3 in machine__process_comm_event util/machine.c:631
    #8 0x55850eebf979 in perf_event__process_comm util/event.c:197
    #9 0x55850f020cff in machines__deliver_event util/session.c:1509
    #10 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #11 0x55850f024e7d in perf_session__process_event util/session.c:1803
    #12 0x55850f02a69e in process_simple util/session.c:2267
    #13 0x55850f029efc in reader__process_events util/session.c:2233
    #14 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #15 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #16 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #17 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #18 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #19 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #20 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #21 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #22 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f037ac2 in nsinfo__new util/namespaces.c:142
    #2 0x55850f03d3bf in thread__new util/thread.c:70
    #3 0x55850efe5dd5 in ____machine__findnew_thread util/machine.c:543
    #4 0x55850efe60e9 in __machine__findnew_thread util/machine.c:574
    #5 0x55850efe619f in machine__findnew_thread util/machine.c:584
    #6 0x55850eff3850 in machine__process_fork_event util/machine.c:1945
    #7 0x55850eec188e in perf_event__process_fork util/event.c:383
    #8 0x55850f020e9d in machines__deliver_event util/session.c:1515
    #9 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #10 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #11 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #12 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #13 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #14 0x55850f01c0ca in process_finished_round util/session.c:1061
    #15 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #16 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #17 0x55850f02a69e in process_simple util/session.c:2267
    #18 0x55850f029efc in reader__process_events util/session.c:2233
    #19 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #20 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #21 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #22 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #23 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #24 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #25 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #26 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #27 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f037e94 in nsinfo__copy util/namespaces.c:169
    #2 0x55850f003f7a in map__new util/map.c:168
    #3 0x55850eff1e3d in machine__process_mmap2_event util/machine.c:1787
    #4 0x55850eec15a8 in perf_event__process_mmap2 util/event.c:368
    #5 0x55850f020c75 in machines__deliver_event util/session.c:1507
    #6 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #7 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #8 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #9 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #10 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #11 0x55850f01c0ca in process_finished_round util/session.c:1061
    #12 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #13 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #14 0x55850f02a69e in process_simple util/session.c:2267
    #15 0x55850f029efc in reader__process_events util/session.c:2233
    #16 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #17 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #18 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #19 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #20 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #21 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #22 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #23 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #24 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 20 byte(s) in 2 object(s) allocated from:
    #0 0x7f6ff5f78810 in strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3=
a810)
    #1 0x55850efb04bd in evlist__set_event_name util/header.c:2292
    #2 0x55850efb0805 in process_event_desc util/header.c:2313
    #3 0x55850efbe604 in perf_file_section__process util/header.c:3651
    #4 0x55850efbc6dd in perf_header__process_sections util/header.c:3427
    #5 0x55850efc0b80 in perf_session__read_header util/header.c:3886
    #6 0x55850f00ec8c in perf_session__open util/session.c:109
    #7 0x55850f00fb91 in perf_session__new util/session.c:213
    #8 0x55850ec2214b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #9 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #10 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #11 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #12 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #13 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 12 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff5f78810 in strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3=
a810)
    #1 0x55850ef7f235 in dso__load_kcore util/symbol.c:1402
    #2 0x55850ef7fe04 in __dso__load_kallsyms util/symbol.c:1467
    #3 0x55850ef7fffa in dso__load_kallsyms util/symbol.c:1476
    #4 0x55850ef86724 in dso__load_kernel_sym util/symbol.c:2235
    #5 0x55850ef83289 in dso__load util/symbol.c:1778
    #6 0x55850f0057fb in map__load util/map.c:332
    #7 0x55850eec4569 in thread__find_map util/event.c:605
    #8 0x55850eec542c in machine__resolve util/event.c:675
    #9 0x55850ec0fb41 in process_sample_event /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-repo=
rt.c:273
    #10 0x55850f020580 in evlist__deliver_sample util/session.c:1464
    #11 0x55850f0209de in machines__deliver_event util/session.c:1501
    #12 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #13 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #14 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #15 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #16 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #17 0x55850f01c0ca in process_finished_round util/session.c:1061
    #18 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #19 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #20 0x55850f02a69e in process_simple util/session.c:2267
    #21 0x55850f029efc in reader__process_events util/session.c:2233
    #22 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #23 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #24 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #25 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #26 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #27 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #28 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #29 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539

SUMMARY: AddressSanitizer: 9956768 byte(s) leaked in 127328 allocation(s).
=2E/freq_test/run.sh: line 38: [: : integer expression expected
=2E/freq_test/run.sh: line 38: [: : integer expression expected
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31936=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address 0=
x602000000a08 at pc 0x55a72bd66dda bp 0x7ffebf157b40 sp 0x7ffebf157b38
READ of size 4 at 0x602000000a08 thread T0
    #0 0x55a72bd66dd9 in process_group_desc util/header.c:2631
    #1 0x55a72bd71604 in perf_file_section__process util/header.c:3651
    #2 0x55a72bd6f6dd in perf_header__process_sections util/header.c:3427
    #3 0x55a72bd73b80 in perf_session__read_header util/header.c:3886
    #4 0x55a72bdc1c8c in perf_session__open util/session.c:109
    #5 0x55a72bdc2b91 in perf_session__new util/session.c:213
    #6 0x55a72b9d514b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #7 0x55a72bc18029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #8 0x55a72bc187d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #9 0x55a72bc18cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #10 0x55a72bc196d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #11 0x7fb747d1709a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)
    #12 0x55a72b943999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

0x602000000a08 is located 8 bytes to the right of 16-byte region [0x6020000=
009f0,0x602000000a00)
allocated by thread T0 here:
    #0 0x7fb748b2a518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55a72bd66702 in process_group_desc util/header.c:2607
    #2 0x55a72bd71604 in perf_file_section__process util/header.c:3651
    #3 0x55a72bd6f6dd in perf_header__process_sections util/header.c:3427
    #4 0x55a72bd73b80 in perf_session__read_header util/header.c:3886
    #5 0x55a72bdc1c8c in perf_session__open util/session.c:109
    #6 0x55a72bdc2b91 in perf_session__new util/session.c:213
    #7 0x55a72b9d514b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #8 0x55a72bc18029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x55a72bc187d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x55a72bc18cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x55a72bc196d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7fb747d1709a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

SUMMARY: AddressSanitizer: heap-buffer-overflow util/header.c:2631 in proce=
ss_group_desc
Shadow bytes around the buggy address:
  0x0c047fff80f0: fa fa 00 fa fa fa 00 00 fa fa 00 fa fa fa 00 fa
  0x0c047fff8100: fa fa 00 00 fa fa 00 00 fa fa 00 00 fa fa 00 00
  0x0c047fff8110: fa fa 01 fa fa fa 00 02 fa fa fd fd fa fa 05 fa
  0x0c047fff8120: fa fa fd fa fa fa 07 fa fa fa 00 05 fa fa fd fd
  0x0c047fff8130: fa fa 05 fa fa fa 07 fa fa fa 00 05 fa fa 00 00
=3D>0x0c047fff8140: fa[fa]fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c047fff8150: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c047fff8160: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c047fff8170: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c047fff8180: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c047fff8190: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07=20
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
=3D=3D31936=3D=3DABORTING
=2E/freq_test/run.sh: line 38: [: : integer expression expected
=2E/freq_test/run.sh: line 38: [: : integer expression expected
Thu May 20 09:09:17 UTC 2021
0 test cases pass for perf_freq_checking test. 3 test cases fail for perf_f=
req_checking test.
Test case finity_noploop_default FAIL!
Test case finity_noploop_cycles_instructions FAIL!
Test case finity_noploop_cycles_instructions_group FAIL!
2021-05-20 09:09:18 ./group_test/run.sh
perf hardware event count group test
Thu May 20 09:09:48 UTC 2021
70 test cases pass for perf_hw_event_count_group test. 0 test cases fail fo=
r perf_hw_event_count_group test.
Test Case count_cache-misses_branch-misses_cpu-cycles_R4 PASS!
Test Case count_group_cache-misses_branch-misses_R4 PASS!
Test Case count_group_branch-misses_cpu-cycles_u_R4 PASS!
Test Case count_group_cache-misses_cpu-cycles_k_R4 PASS!
Test Case count_group_cache-misses_branch-misses_and_group_branch-misses_cp=
u-cycles_R4 PASS!
Test Case count_group_cache-misses_branch-misses_cpu-cycles_R4 PASS!
Test Case count_group_cache-misses_branch-misses_and_group_cache-misses_bra=
nch-misses_cpu-cycles_k_R4 PASS!
Test Case count_group_cache-misses_branch-misses_cpu-cycles_and_group_cache=
-misses_branch-misses_cpu-cycles_R4 PASS!
Test Case count_global_group_branch-misses_cpu-cycles_R4 PASS!
Test Case count_global_group_branch-misses_cpu-cycles_u_R4 PASS!
Test Case count_global_group_branch-misses_cpu-cycles_k_R4 PASS!
Test Case count_global_group_branch-misses_cpu-cycles_cache-misses_R4 PASS!
Test Case count_global_group_branch-misses_cpu-cycles_cache-misses_u_R4 PAS=
S!
Test Case count_global_group_branch-misses_cpu-cycles_cache-misses_k_R4 PAS=
S!
Test Case count_ref-cycles_cache-references_branch-misses_R3 PASS!
Test Case count_group_ref-cycles_cache-references_R3 PASS!
Test Case count_group_cache-references_branch-misses_u_R3 PASS!
Test Case count_group_ref-cycles_branch-misses_k_R3 PASS!
Test Case count_group_ref-cycles_cache-references_and_group_cache-reference=
s_branch-misses_R3 PASS!
Test Case count_group_ref-cycles_cache-references_branch-misses_R3 PASS!
Test Case count_group_ref-cycles_cache-references_and_group_ref-cycles_cach=
e-references_branch-misses_k_R3 PASS!
Test Case count_group_ref-cycles_cache-references_branch-misses_and_group_r=
ef-cycles_cache-references_branch-misses_R3 PASS!
Test Case count_global_group_cache-references_branch-misses_R3 PASS!
Test Case count_global_group_cache-references_branch-misses_u_R3 PASS!
Test Case count_global_group_cache-references_branch-misses_k_R3 PASS!
Test Case count_global_group_cache-references_branch-misses_ref-cycles_R3 P=
ASS!
Test Case count_global_group_cache-references_branch-misses_ref-cycles_u_R3=
 PASS!
Test Case count_global_group_cache-references_branch-misses_ref-cycles_k_R3=
 PASS!
Test Case count_branch-instructions_instructions_cpu-cycles_R2 PASS!
Test Case count_group_branch-instructions_instructions_R2 PASS!
Test Case count_group_instructions_cpu-cycles_u_R2 PASS!
Test Case count_group_branch-instructions_cpu-cycles_k_R2 PASS!
Test Case count_group_branch-instructions_instructions_and_group_instructio=
ns_cpu-cycles_R2 PASS!
Test Case count_group_branch-instructions_instructions_cpu-cycles_R2 PASS!
Test Case count_group_branch-instructions_instructions_and_group_branch-ins=
tructions_instructions_cpu-cycles_k_R2 PASS!
Test Case count_group_branch-instructions_instructions_cpu-cycles_and_group=
_branch-instructions_instructions_cpu-cycles_R2 PASS!
Test Case count_global_group_instructions_cpu-cycles_R2 PASS!
Test Case count_global_group_instructions_cpu-cycles_u_R2 PASS!
Test Case count_global_group_instructions_cpu-cycles_k_R2 PASS!
Test Case count_global_group_instructions_cpu-cycles_branch-instructions_R2=
 PASS!
Test Case count_global_group_instructions_cpu-cycles_branch-instructions_u_=
R2 PASS!
Test Case count_global_group_instructions_cpu-cycles_branch-instructions_k_=
R2 PASS!
Test Case count_cpu-cycles_branch-misses_cache-references_R1 PASS!
Test Case count_group_cpu-cycles_branch-misses_R1 PASS!
Test Case count_group_branch-misses_cache-references_u_R1 PASS!
Test Case count_group_cpu-cycles_cache-references_k_R1 PASS!
Test Case count_group_cpu-cycles_branch-misses_and_group_branch-misses_cach=
e-references_R1 PASS!
Test Case count_group_cpu-cycles_branch-misses_cache-references_R1 PASS!
Test Case count_group_cpu-cycles_branch-misses_and_group_cpu-cycles_branch-=
misses_cache-references_k_R1 PASS!
Test Case count_group_cpu-cycles_branch-misses_cache-references_and_group_c=
pu-cycles_branch-misses_cache-references_R1 PASS!
Test Case count_global_group_branch-misses_cache-references_R1 PASS!
Test Case count_global_group_branch-misses_cache-references_u_R1 PASS!
Test Case count_global_group_branch-misses_cache-references_k_R1 PASS!
Test Case count_global_group_branch-misses_cache-references_cpu-cycles_R1 P=
ASS!
Test Case count_global_group_branch-misses_cache-references_cpu-cycles_u_R1=
 PASS!
Test Case count_global_group_branch-misses_cache-references_cpu-cycles_k_R1=
 PASS!
Test Case count_cpu-cycles_bus-cycles_ref-cycles_R0 PASS!
Test Case count_group_cpu-cycles_bus-cycles_R0 PASS!
Test Case count_group_bus-cycles_ref-cycles_u_R0 PASS!
Test Case count_group_cpu-cycles_ref-cycles_k_R0 PASS!
Test Case count_group_cpu-cycles_bus-cycles_and_group_bus-cycles_ref-cycles=
_R0 PASS!
Test Case count_group_cpu-cycles_bus-cycles_ref-cycles_R0 PASS!
Test Case count_group_cpu-cycles_bus-cycles_and_group_cpu-cycles_bus-cycles=
_ref-cycles_k_R0 PASS!
Test Case count_group_cpu-cycles_bus-cycles_ref-cycles_and_group_cpu-cycles=
_bus-cycles_ref-cycles_R0 PASS!
Test Case count_global_group_bus-cycles_ref-cycles_R0 PASS!
Test Case count_global_group_bus-cycles_ref-cycles_u_R0 PASS!
Test Case count_global_group_bus-cycles_ref-cycles_k_R0 PASS!
Test Case count_global_group_bus-cycles_ref-cycles_cpu-cycles_R0 PASS!
Test Case count_global_group_bus-cycles_ref-cycles_cpu-cycles_u_R0 PASS!
Test Case count_global_group_bus-cycles_ref-cycles_cpu-cycles_k_R0 PASS!
perf hardware cache event count group test
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
Thu May 20 09:09:49 UTC 2021
0 test cases pass for perf_hw_cache_event_count_group test. 0 test cases fa=
il for perf_hw_cache_event_count_group test.
perf kernel cpu PMU event count group test
Thu May 20 09:10:13 UTC 2021
57 test cases pass for perf_pmu_event_count_group test. 0 test cases fail f=
or perf_pmu_event_count_group test.
Test Case count_cpu/branch-misses/_cpu/mem-loads/_cpu/el-conflict/_R4 PASS!
Test Case count_group_cpu/branch-misses/_cpu/mem-loads/_R4 PASS!
Test Case count_group_cpu/mem-loads/_cpu/el-conflict/_u_R4 PASS!
Test Case count_group_cpu/branch-misses/_cpu/el-conflict/_k_R4 PASS!
Test Case count_group_cpu/branch-misses/_cpu/mem-loads/_and_group_cpu/mem-l=
oads/_cpu/el-conflict/_R4 PASS!
Test Case count_group_cpu/branch-misses/_cpu/mem-loads/_cpu/el-conflict/_R4=
 PASS!
Test Case count_group_cpu/branch-misses/_cpu/mem-loads/_and_group_cpu/branc=
h-misses/_cpu/mem-loads/_cpu/el-conflict/_k_R4 PASS!
Test Case count_group_cpu/branch-misses/_cpu/mem-loads/_cpu/el-conflict/_an=
d_group_cpu/branch-misses/_cpu/mem-loads/_cpu/el-conflict/_R4 PASS!
Test Case count_global_group_cpu/mem-loads/_cpu/el-conflict/_R4 PASS!
Test Case count_global_group_cpu/mem-loads/_cpu/el-conflict/_u_R4 PASS!
Test Case count_global_group_cpu/mem-loads/_cpu/el-conflict/_k_R4 PASS!
Test Case count_global_group_cpu/mem-loads/_cpu/el-conflict/_cpu/branch-mis=
ses/_R4 PASS!
Test Case count_global_group_cpu/mem-loads/_cpu/el-conflict/_cpu/branch-mis=
ses/_u_R4 PASS!
Test Case count_global_group_cpu/mem-loads/_cpu/el-conflict/_cpu/branch-mis=
ses/_k_R4 PASS!
Test Case count_cpu/topdown-slots-issued/_cpu/tx-abort/_cpu/tx-start/_R3 PA=
SS!
Test Case count_group_cpu/topdown-slots-issued/_cpu/tx-abort/_R3 PASS!
Test Case count_group_cpu/tx-abort/_cpu/tx-start/_u_R3 PASS!
Test Case count_group_cpu/topdown-slots-issued/_cpu/tx-start/_k_R3 PASS!
Test Case count_group_cpu/topdown-slots-issued/_cpu/tx-abort/_and_group_cpu=
/tx-abort/_cpu/tx-start/_R3 PASS!
Test Case count_group_cpu/topdown-slots-issued/_cpu/tx-abort/_cpu/tx-start/=
_R3 PASS!
Test Case count_group_cpu/topdown-slots-issued/_cpu/tx-abort/_and_group_cpu=
/topdown-slots-issued/_cpu/tx-abort/_cpu/tx-start/_k_R3 PASS!
Test Case count_group_cpu/topdown-slots-issued/_cpu/tx-abort/_cpu/tx-start/=
_and_group_cpu/topdown-slots-issued/_cpu/tx-abort/_cpu/tx-start/_R3 PASS!
Test Case count_global_group_cpu/tx-abort/_cpu/tx-start/_R3 PASS!
Test Case count_global_group_cpu/tx-abort/_cpu/tx-start/_u_R3 PASS!
Test Case count_global_group_cpu/tx-abort/_cpu/tx-start/_k_R3 PASS!
Test Case count_global_group_cpu/tx-abort/_cpu/tx-start/_cpu/topdown-slots-=
issued/_R3 PASS!
Test Case count_global_group_cpu/tx-abort/_cpu/tx-start/_cpu/topdown-slots-=
issued/_u_R3 PASS!
Test Case count_global_group_cpu/tx-abort/_cpu/tx-start/_cpu/topdown-slots-=
issued/_k_R3 PASS!
Test Case count_cpu/bus-cycles/_cpu/branch-instructions/_cpu/el-abort/_R2 P=
ASS!
Test Case count_group_cpu/bus-cycles/_cpu/branch-instructions/_R2 PASS!
Test Case count_group_cpu/branch-instructions/_cpu/el-abort/_u_R2 PASS!
Test Case count_group_cpu/bus-cycles/_cpu/el-abort/_k_R2 PASS!
Test Case count_group_cpu/bus-cycles/_cpu/branch-instructions/_and_group_cp=
u/branch-instructions/_cpu/el-abort/_R2 PASS!
Test Case count_group_cpu/bus-cycles/_cpu/branch-instructions/_cpu/el-abort=
/_R2 PASS!
Test Case count_group_cpu/bus-cycles/_cpu/branch-instructions/_and_group_cp=
u/bus-cycles/_cpu/branch-instructions/_cpu/el-abort/_k_R2 PASS!
Test Case count_group_cpu/bus-cycles/_cpu/branch-instructions/_cpu/el-abort=
/_and_group_cpu/bus-cycles/_cpu/branch-instructions/_cpu/el-abort/_R2 PASS!
Test Case count_global_group_cpu/branch-instructions/_cpu/el-abort/_R2 PASS!
Test Case count_global_group_cpu/branch-instructions/_cpu/el-abort/_u_R2 PA=
SS!
Test Case count_global_group_cpu/branch-instructions/_cpu/el-abort/_k_R2 PA=
SS!
Test Case count_global_group_cpu/branch-instructions/_cpu/el-abort/_cpu/bus=
-cycles/_R2 PASS!
Test Case count_global_group_cpu/branch-instructions/_cpu/el-abort/_cpu/bus=
-cycles/_u_R2 PASS!
Test Case count_global_group_cpu/branch-instructions/_cpu/el-abort/_cpu/bus=
-cycles/_k_R2 PASS!
Test Case count_cpu/topdown-slots-retired/_cpu/topdown-recovery-bubbles/_cp=
u/topdown-total-slots/_R1 PASS!
Test Case count_cpu/topdown-total-slots/_cpu/tx-commit/_cpu/el-commit/_R0 P=
ASS!
Test Case count_group_cpu/topdown-total-slots/_cpu/tx-commit/_R0 PASS!
Test Case count_group_cpu/tx-commit/_cpu/el-commit/_u_R0 PASS!
Test Case count_group_cpu/topdown-total-slots/_cpu/el-commit/_k_R0 PASS!
Test Case count_group_cpu/topdown-total-slots/_cpu/tx-commit/_and_group_cpu=
/tx-commit/_cpu/el-commit/_R0 PASS!
Test Case count_group_cpu/topdown-total-slots/_cpu/tx-commit/_cpu/el-commit=
/_R0 PASS!
Test Case count_group_cpu/topdown-total-slots/_cpu/tx-commit/_and_group_cpu=
/topdown-total-slots/_cpu/tx-commit/_cpu/el-commit/_k_R0 PASS!
Test Case count_group_cpu/topdown-total-slots/_cpu/tx-commit/_cpu/el-commit=
/_and_group_cpu/topdown-total-slots/_cpu/tx-commit/_cpu/el-commit/_R0 PASS!
Test Case count_global_group_cpu/tx-commit/_cpu/el-commit/_R0 PASS!
Test Case count_global_group_cpu/tx-commit/_cpu/el-commit/_u_R0 PASS!
Test Case count_global_group_cpu/tx-commit/_cpu/el-commit/_k_R0 PASS!
Test Case count_global_group_cpu/tx-commit/_cpu/el-commit/_cpu/topdown-tota=
l-slots/_R0 PASS!
Test Case count_global_group_cpu/tx-commit/_cpu/el-commit/_cpu/topdown-tota=
l-slots/_u_R0 PASS!
Test Case count_global_group_cpu/tx-commit/_cpu/el-commit/_cpu/topdown-tota=
l-slots/_k_R0 PASS!
ROUND : perf hardware event sample group test
Thu May 20 09:10:48 UTC 2021
0 test cases pass for perf_hw_event_sample_group test. 80 test cases fail f=
or perf_hw_event_sample_group test.
Test Case sampe_cache-misses_cache-references_bus-cycles_NO_FIX_HAS_NMI_R4 =
FAILED!
Test Case group_sampe_cache-misses_cache-references_NO_FIX_HAS_NMI_R4 FAILE=
D!
Test Case group_sampe_cache-references_bus-cycles_u_NO_FIX_HAS_NMI_R4 FAILE=
D!
Test Case group_sampe_cache-misses_bus-cycles_k_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cache-misses_cache-references_and_cache-references_bu=
s-cycles_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cache-misses_cache-references_bus-cycles_NO_FIX_HAS_N=
MI_R4 FAILED!
Test Case group_sampe_cache-misses_cache-references_and_cache-misses_cache-=
references_bus-cycles_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cache-misses_cache-references_bus-cycles_and_cache-mi=
sses_cache-references_bus-cycles_NO_FIX_HAS_NMI_R4 FAILED!
Test Case sampe_cache-misses_cache-references_bus-cycles_HAS_FIX_NO_NMI_R4 =
FAILED!
Test Case group_sampe_cache-misses_cache-references_HAS_FIX_NO_NMI_R4 FAILE=
D!
Test Case group_sampe_cache-references_bus-cycles_u_HAS_FIX_NO_NMI_R4 FAILE=
D!
Test Case group_sampe_cache-misses_bus-cycles_k_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cache-misses_cache-references_and_cache-references_bu=
s-cycles_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cache-misses_cache-references_bus-cycles_HAS_FIX_NO_N=
MI_R4 FAILED!
Test Case group_sampe_cache-misses_cache-references_and_cache-misses_cache-=
references_bus-cycles_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cache-misses_cache-references_bus-cycles_and_cache-mi=
sses_cache-references_bus-cycles_HAS_FIX_NO_NMI_R4 FAILED!
Test Case sampe_cycles:p_branch-instructions_branch-instructions_NO_FIX_HAS=
_NMI_R3 FAILED!
Test Case group_sampe_cycles:p_branch-instructions_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_branch-instructions_branch-instructions_u_NO_FIX_HAS_=
NMI_R3 FAILED!
Test Case group_sampe_cycles:p_branch-instructions_k_NO_FIX_HAS_NMI_R3 FAIL=
ED!
Test Case group_sampe_cycles:p_branch-instructions_and_branch-instructions_=
branch-instructions_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cycles:p_branch-instructions_branch-instructions_NO_F=
IX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cycles:p_branch-instructions_and_cycles:p_branch-inst=
ructions_branch-instructions_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cycles:p_branch-instructions_branch-instructions_and_=
cycles:p_branch-instructions_branch-instructions_NO_FIX_HAS_NMI_R3 FAILED!
Test Case sampe_cycles:p_branch-instructions_branch-instructions_HAS_FIX_NO=
_NMI_R3 FAILED!
Test Case group_sampe_cycles:p_branch-instructions_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_branch-instructions_branch-instructions_u_HAS_FIX_NO_=
NMI_R3 FAILED!
Test Case group_sampe_cycles:p_branch-instructions_k_HAS_FIX_NO_NMI_R3 FAIL=
ED!
Test Case group_sampe_cycles:p_branch-instructions_and_branch-instructions_=
branch-instructions_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cycles:p_branch-instructions_branch-instructions_HAS_=
FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cycles:p_branch-instructions_and_cycles:p_branch-inst=
ructions_branch-instructions_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cycles:p_branch-instructions_branch-instructions_and_=
cycles:p_branch-instructions_branch-instructions_HAS_FIX_NO_NMI_R3 FAILED!
Test Case sampe_bus-cycles_cycles:pp_instructions_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_bus-cycles_cycles:pp_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cycles:pp_instructions_u_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_bus-cycles_instructions_k_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_bus-cycles_cycles:pp_and_cycles:pp_instructions_NO_FI=
X_HAS_NMI_R2 FAILED!
Test Case group_sampe_bus-cycles_cycles:pp_instructions_NO_FIX_HAS_NMI_R2 F=
AILED!
Test Case group_sampe_bus-cycles_cycles:pp_and_bus-cycles_cycles:pp_instruc=
tions_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_bus-cycles_cycles:pp_instructions_and_bus-cycles_cycl=
es:pp_instructions_NO_FIX_HAS_NMI_R2 FAILED!
Test Case sampe_bus-cycles_cycles:pp_instructions_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_bus-cycles_cycles:pp_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cycles:pp_instructions_u_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_bus-cycles_instructions_k_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_bus-cycles_cycles:pp_and_cycles:pp_instructions_HAS_F=
IX_NO_NMI_R2 FAILED!
Test Case group_sampe_bus-cycles_cycles:pp_instructions_HAS_FIX_NO_NMI_R2 F=
AILED!
Test Case group_sampe_bus-cycles_cycles:pp_and_bus-cycles_cycles:pp_instruc=
tions_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_bus-cycles_cycles:pp_instructions_and_bus-cycles_cycl=
es:pp_instructions_HAS_FIX_NO_NMI_R2 FAILED!
Test Case sampe_branch-instructions_cycles:pp_instructions_NO_FIX_HAS_NMI_R=
1 FAILED!
Test Case group_sampe_branch-instructions_cycles:pp_NO_FIX_HAS_NMI_R1 FAILE=
D!
Test Case group_sampe_cycles:pp_instructions_u_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_branch-instructions_instructions_k_NO_FIX_HAS_NMI_R1 =
FAILED!
Test Case group_sampe_branch-instructions_cycles:pp_and_cycles:pp_instructi=
ons_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_branch-instructions_cycles:pp_instructions_NO_FIX_HAS=
_NMI_R1 FAILED!
Test Case group_sampe_branch-instructions_cycles:pp_and_branch-instructions=
_cycles:pp_instructions_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_branch-instructions_cycles:pp_instructions_and_branch=
-instructions_cycles:pp_instructions_NO_FIX_HAS_NMI_R1 FAILED!
Test Case sampe_branch-instructions_cycles:pp_instructions_HAS_FIX_NO_NMI_R=
1 FAILED!
Test Case group_sampe_branch-instructions_cycles:pp_HAS_FIX_NO_NMI_R1 FAILE=
D!
Test Case group_sampe_cycles:pp_instructions_u_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_branch-instructions_instructions_k_HAS_FIX_NO_NMI_R1 =
FAILED!
Test Case group_sampe_branch-instructions_cycles:pp_and_cycles:pp_instructi=
ons_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_branch-instructions_cycles:pp_instructions_HAS_FIX_NO=
_NMI_R1 FAILED!
Test Case group_sampe_branch-instructions_cycles:pp_and_branch-instructions=
_cycles:pp_instructions_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_branch-instructions_cycles:pp_instructions_and_branch=
-instructions_cycles:pp_instructions_HAS_FIX_NO_NMI_R1 FAILED!
Test Case sampe_branch-misses_ref-cycles_cycles:p_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_branch-misses_ref-cycles_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_ref-cycles_cycles:p_u_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_branch-misses_cycles:p_k_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_branch-misses_ref-cycles_and_ref-cycles_cycles:p_NO_F=
IX_HAS_NMI_R0 FAILED!
Test Case group_sampe_branch-misses_ref-cycles_cycles:p_NO_FIX_HAS_NMI_R0 F=
AILED!
Test Case group_sampe_branch-misses_ref-cycles_and_branch-misses_ref-cycles=
_cycles:p_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_branch-misses_ref-cycles_cycles:p_and_branch-misses_r=
ef-cycles_cycles:p_NO_FIX_HAS_NMI_R0 FAILED!
Test Case sampe_branch-misses_ref-cycles_cycles:p_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_branch-misses_ref-cycles_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_ref-cycles_cycles:p_u_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_branch-misses_cycles:p_k_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_branch-misses_ref-cycles_and_ref-cycles_cycles:p_HAS_=
FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_branch-misses_ref-cycles_cycles:p_HAS_FIX_NO_NMI_R0 F=
AILED!
Test Case group_sampe_branch-misses_ref-cycles_and_branch-misses_ref-cycles=
_cycles:p_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_branch-misses_ref-cycles_cycles:p_and_branch-misses_r=
ef-cycles_cycles:p_HAS_FIX_NO_NMI_R0 FAILED!
perf hardware cache event sample group test
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
Thu May 20 09:10:49 UTC 2021
0 test cases pass for perf_hw_cache_event_sample_group test. 0 test cases f=
ail for perf_hw_cache_event_sample_group test.
perf kernel cpu PMU event sample group test
Thu May 20 09:11:03 UTC 2021
0 test cases pass for perf_pmu_event_sample_group test. 32 test cases fail =
for perf_pmu_event_sample_group test.
Test Case sampe_cpu/mem-loads/pp_cpu/mem-stores/_cpu/cpu-cycles/_NO_FIX_HAS=
_NMI_R4 FAILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/mem-stores/_NO_FIX_HAS_NMI_R4 FA=
ILED!
Test Case group_sampe_cpu/mem-stores/_cpu/cpu-cycles/_u_NO_FIX_HAS_NMI_R4 F=
AILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/cpu-cycles/_k_NO_FIX_HAS_NMI_R4 =
FAILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/mem-stores/_and_cpu/mem-stores/_=
cpu/cpu-cycles/_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/mem-stores/_cpu/cpu-cycles/_NO_F=
IX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/mem-stores/_and_cpu/mem-loads/pp=
_cpu/mem-stores/_cpu/cpu-cycles/_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/mem-stores/_cpu/cpu-cycles/_and_=
cpu/mem-loads/pp_cpu/mem-stores/_cpu/cpu-cycles/_NO_FIX_HAS_NMI_R4 FAILED!
Test Case sampe_cpu/mem-loads/pp_cpu/mem-stores/_cpu/cpu-cycles/_HAS_FIX_NO=
_NMI_R4 FAILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/mem-stores/_HAS_FIX_NO_NMI_R4 FA=
ILED!
Test Case group_sampe_cpu/mem-stores/_cpu/cpu-cycles/_u_HAS_FIX_NO_NMI_R4 F=
AILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/cpu-cycles/_k_HAS_FIX_NO_NMI_R4 =
FAILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/mem-stores/_and_cpu/mem-stores/_=
cpu/cpu-cycles/_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/mem-stores/_cpu/cpu-cycles/_HAS_=
FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/mem-stores/_and_cpu/mem-loads/pp=
_cpu/mem-stores/_cpu/cpu-cycles/_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/mem-stores/_cpu/cpu-cycles/_and_=
cpu/mem-loads/pp_cpu/mem-stores/_cpu/cpu-cycles/_HAS_FIX_NO_NMI_R4 FAILED!
Test Case sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_cpu/el-start/_NO_FIX_HAS_=
NMI_R3 FAILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_NO_FIX_HAS_NMI_R3 F=
AILED!
Test Case group_sampe_cpu/cpu-cycles/p_cpu/el-start/_u_NO_FIX_HAS_NMI_R3 FA=
ILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/el-start/_k_NO_FIX_HAS_NMI_R3 FA=
ILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_and_cpu/cpu-cycles/=
p_cpu/el-start/_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_cpu/el-start/_NO_FI=
X_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_and_cpu/tx-conflict=
/_cpu/cpu-cycles/p_cpu/el-start/_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_cpu/el-start/_and_c=
pu/tx-conflict/_cpu/cpu-cycles/p_cpu/el-start/_NO_FIX_HAS_NMI_R3 FAILED!
Test Case sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_cpu/el-start/_HAS_FIX_NO_=
NMI_R3 FAILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_HAS_FIX_NO_NMI_R3 F=
AILED!
Test Case group_sampe_cpu/cpu-cycles/p_cpu/el-start/_u_HAS_FIX_NO_NMI_R3 FA=
ILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/el-start/_k_HAS_FIX_NO_NMI_R3 FA=
ILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_and_cpu/cpu-cycles/=
p_cpu/el-start/_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_cpu/el-start/_HAS_F=
IX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_and_cpu/tx-conflict=
/_cpu/cpu-cycles/p_cpu/el-start/_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_cpu/el-start/_and_c=
pu/tx-conflict/_cpu/cpu-cycles/p_cpu/el-start/_HAS_FIX_NO_NMI_R3 FAILED!
perf pebs events sample group test
Thu May 20 09:11:38 UTC 2021
0 test cases pass for pebs_event_sample_group test. 80 test cases fail for =
pebs_event_sample_group test.
Test Case sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/umask=
=3D0x02,event=3D0xc0/pp_cpu/umask=3D0x02,event=3D0xd2/pp_NO_FIX_HAS_NMI_R4 =
FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xc0/pp_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xc0/pp_cpu/umask=3D0x02,eve=
nt=3D0xd2/pp_u_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xd2/pp_k_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xc0/pp_and_cpu/umask=3D0x02,event=3D0xc0/pp_cpu/umask=
=3D0x02,event=3D0xd2/pp_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xc0/pp_cpu/umask=3D0x02,event=3D0xd2/pp_NO_FIX_HAS_NM=
I_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xc0/pp_and_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0=
x12/pp_cpu/umask=3D0x02,event=3D0xc0/pp_cpu/umask=3D0x02,event=3D0xd2/pp_NO=
_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xc0/pp_cpu/umask=3D0x02,event=3D0xd2/pp_and_cpu/umask=
=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/umask=3D0x02,event=3D0xc0/pp_cp=
u/umask=3D0x02,event=3D0xd2/pp_NO_FIX_HAS_NMI_R4 FAILED!
Test Case sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/umask=
=3D0x02,event=3D0xc0/pp_cpu/umask=3D0x02,event=3D0xd2/pp_HAS_FIX_NO_NMI_R4 =
FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xc0/pp_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xc0/pp_cpu/umask=3D0x02,eve=
nt=3D0xd2/pp_u_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xd2/pp_k_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xc0/pp_and_cpu/umask=3D0x02,event=3D0xc0/pp_cpu/umask=
=3D0x02,event=3D0xd2/pp_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xc0/pp_cpu/umask=3D0x02,event=3D0xd2/pp_HAS_FIX_NO_NM=
I_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xc0/pp_and_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0=
x12/pp_cpu/umask=3D0x02,event=3D0xc0/pp_cpu/umask=3D0x02,event=3D0xd2/pp_HA=
S_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xc0/pp_cpu/umask=3D0x02,event=3D0xd2/pp_and_cpu/umask=
=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/umask=3D0x02,event=3D0xc0/pp_cp=
u/umask=3D0x02,event=3D0xd2/pp_HAS_FIX_NO_NMI_R4 FAILED!
Test Case sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,event=3D0=
xc4/pp_cpu/umask=3D0x08,event=3D0xd2/pp_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,eve=
nt=3D0xc4/pp_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x04,event=3D0xc4/pp_cpu/umask=3D0x08,eve=
nt=3D0xd2/pp_u_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x08,eve=
nt=3D0xd2/pp_k_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,eve=
nt=3D0xc4/pp_and_cpu/umask=3D0x04,event=3D0xc4/pp_cpu/umask=3D0x08,event=3D=
0xd2/pp_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,eve=
nt=3D0xc4/pp_cpu/umask=3D0x08,event=3D0xd2/pp_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,eve=
nt=3D0xc4/pp_and_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,event=3D=
0xc4/pp_cpu/umask=3D0x08,event=3D0xd2/pp_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,eve=
nt=3D0xc4/pp_cpu/umask=3D0x08,event=3D0xd2/pp_and_cpu/umask=3D0x02,event=3D=
0xca/pp_cpu/umask=3D0x04,event=3D0xc4/pp_cpu/umask=3D0x08,event=3D0xd2/pp_N=
O_FIX_HAS_NMI_R3 FAILED!
Test Case sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,event=3D0=
xc4/pp_cpu/umask=3D0x08,event=3D0xd2/pp_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,eve=
nt=3D0xc4/pp_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x04,event=3D0xc4/pp_cpu/umask=3D0x08,eve=
nt=3D0xd2/pp_u_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x08,eve=
nt=3D0xd2/pp_k_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,eve=
nt=3D0xc4/pp_and_cpu/umask=3D0x04,event=3D0xc4/pp_cpu/umask=3D0x08,event=3D=
0xd2/pp_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,eve=
nt=3D0xc4/pp_cpu/umask=3D0x08,event=3D0xd2/pp_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,eve=
nt=3D0xc4/pp_and_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,event=3D=
0xc4/pp_cpu/umask=3D0x08,event=3D0xd2/pp_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,eve=
nt=3D0xc4/pp_cpu/umask=3D0x08,event=3D0xd2/pp_and_cpu/umask=3D0x02,event=3D=
0xca/pp_cpu/umask=3D0x04,event=3D0xc4/pp_cpu/umask=3D0x08,event=3D0xd2/pp_H=
AS_FIX_NO_NMI_R3 FAILED!
Test Case sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,event=3D0=
xca/pp_cpu/umask=3D0x20,event=3D0xc5/pp_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,eve=
nt=3D0xca/pp_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x20,eve=
nt=3D0xc5/pp_u_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x20,eve=
nt=3D0xc5/pp_k_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,eve=
nt=3D0xca/pp_and_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x20,event=3D=
0xc5/pp_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,eve=
nt=3D0xca/pp_cpu/umask=3D0x20,event=3D0xc5/pp_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,eve=
nt=3D0xca/pp_and_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,event=3D=
0xca/pp_cpu/umask=3D0x20,event=3D0xc5/pp_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,eve=
nt=3D0xca/pp_cpu/umask=3D0x20,event=3D0xc5/pp_and_cpu/umask=3D0x08,event=3D=
0xc4/pp_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x20,event=3D0xc5/pp_N=
O_FIX_HAS_NMI_R2 FAILED!
Test Case sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,event=3D0=
xca/pp_cpu/umask=3D0x20,event=3D0xc5/pp_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,eve=
nt=3D0xca/pp_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x20,eve=
nt=3D0xc5/pp_u_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x20,eve=
nt=3D0xc5/pp_k_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,eve=
nt=3D0xca/pp_and_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x20,event=3D=
0xc5/pp_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,eve=
nt=3D0xca/pp_cpu/umask=3D0x20,event=3D0xc5/pp_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,eve=
nt=3D0xca/pp_and_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,event=3D=
0xca/pp_cpu/umask=3D0x20,event=3D0xc5/pp_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,eve=
nt=3D0xca/pp_cpu/umask=3D0x20,event=3D0xc5/pp_and_cpu/umask=3D0x08,event=3D=
0xc4/pp_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x20,event=3D0xc5/pp_H=
AS_FIX_NO_NMI_R2 FAILED!
Test Case sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,event=3D0=
xd0/pp_cpu/umask=3D0x04,event=3D0xc2/pp_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,eve=
nt=3D0xd0/pp_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x82,event=3D0xd0/pp_cpu/umask=3D0x04,eve=
nt=3D0xc2/pp_u_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x04,eve=
nt=3D0xc2/pp_k_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,eve=
nt=3D0xd0/pp_and_cpu/umask=3D0x82,event=3D0xd0/pp_cpu/umask=3D0x04,event=3D=
0xc2/pp_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,eve=
nt=3D0xd0/pp_cpu/umask=3D0x04,event=3D0xc2/pp_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,eve=
nt=3D0xd0/pp_and_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,event=3D=
0xd0/pp_cpu/umask=3D0x04,event=3D0xc2/pp_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,eve=
nt=3D0xd0/pp_cpu/umask=3D0x04,event=3D0xc2/pp_and_cpu/umask=3D0x40,event=3D=
0xc4/pp_cpu/umask=3D0x82,event=3D0xd0/pp_cpu/umask=3D0x04,event=3D0xc2/pp_N=
O_FIX_HAS_NMI_R1 FAILED!
Test Case sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,event=3D0=
xd0/pp_cpu/umask=3D0x04,event=3D0xc2/pp_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,eve=
nt=3D0xd0/pp_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x82,event=3D0xd0/pp_cpu/umask=3D0x04,eve=
nt=3D0xc2/pp_u_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x04,eve=
nt=3D0xc2/pp_k_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,eve=
nt=3D0xd0/pp_and_cpu/umask=3D0x82,event=3D0xd0/pp_cpu/umask=3D0x04,event=3D=
0xc2/pp_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,eve=
nt=3D0xd0/pp_cpu/umask=3D0x04,event=3D0xc2/pp_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,eve=
nt=3D0xd0/pp_and_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,event=3D=
0xd0/pp_cpu/umask=3D0x04,event=3D0xc2/pp_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,eve=
nt=3D0xd0/pp_cpu/umask=3D0x04,event=3D0xc2/pp_and_cpu/umask=3D0x40,event=3D=
0xc4/pp_cpu/umask=3D0x82,event=3D0xd0/pp_cpu/umask=3D0x04,event=3D0xc2/pp_H=
AS_FIX_NO_NMI_R1 FAILED!
Test Case sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,event=3D0=
xc6,frontend=3D0x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_NO_FIX=
_HAS_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xc6,frontend=3D0x13/pp_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x13/pp_cpu/=
umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_u_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xcd,ldlat=3D0x80/pp_k_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xc6,frontend=3D0x13/pp_and_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0=
x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_NO_FIX_HAS_NMI_R0 FAIL=
ED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xc6,frontend=3D0x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_=
NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xc6,frontend=3D0x13/pp_and_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=
=3D0x01,event=3D0xc6,frontend=3D0x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=
=3D0x80/pp_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xc6,frontend=3D0x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_=
and_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,event=3D0xc6,frontend=
=3D0x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_NO_FIX_HAS_NMI_R0 =
FAILED!
Test Case sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,event=3D0=
xc6,frontend=3D0x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_HAS_FI=
X_NO_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xc6,frontend=3D0x13/pp_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x13/pp_cpu/=
umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_u_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xcd,ldlat=3D0x80/pp_k_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xc6,frontend=3D0x13/pp_and_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0=
x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_HAS_FIX_NO_NMI_R0 FAIL=
ED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xc6,frontend=3D0x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_=
HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xc6,frontend=3D0x13/pp_and_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=
=3D0x01,event=3D0xc6,frontend=3D0x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=
=3D0x80/pp_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xc6,frontend=3D0x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_=
and_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,event=3D0xc6,frontend=
=3D0x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_HAS_FIX_NO_NMI_R0 =
FAILED!
perf all events sample and count group test
Thu May 20 09:12:44 UTC 2021
70 test cases pass for all_event_count_group test. 0 test cases fail for al=
l_event_count_group test.
Test Case count_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0000010080/_c=
pu/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x10,cmask=3D0x6,event=3D0x60/_R4=
 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0000010=
080/_cpu/umask=3D0x01,event=3D0xb0/_R4 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x10,cmask=
=3D0x6,event=3D0x60/_u_R4 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0000010=
080/_cpu/umask=3D0x10,cmask=3D0x6,event=3D0x60/_k_R4 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0000010=
080/_cpu/umask=3D0x01,event=3D0xb0/_and_group_cpu/umask=3D0x01,event=3D0xb0=
/_cpu/umask=3D0x10,cmask=3D0x6,event=3D0x60/_R4 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0000010=
080/_cpu/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x10,cmask=3D0x6,event=3D0x=
60/_R4 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0000010=
080/_cpu/umask=3D0x01,event=3D0xb0/_and_group_cpu/umask=3D0x01,event=3D0xb7=
,offcore_rsp=3D0x0000010080/_cpu/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x1=
0,cmask=3D0x6,event=3D0x60/_k_R4 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0000010=
080/_cpu/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x10,cmask=3D0x6,event=3D0x=
60/_and_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0000010080/_cpu=
/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x10,cmask=3D0x6,event=3D0x60/_R4 P=
ASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x1=
0,cmask=3D0x6,event=3D0x60/_R4 PASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x1=
0,cmask=3D0x6,event=3D0x60/_u_R4 PASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x1=
0,cmask=3D0x6,event=3D0x60/_k_R4 PASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x1=
0,cmask=3D0x6,event=3D0x60/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0=
000010080/_R4 PASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x1=
0,cmask=3D0x6,event=3D0x60/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0=
000010080/_u_R4 PASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x1=
0,cmask=3D0x6,event=3D0x60/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0=
000010080/_k_R4 PASS!
Test Case count_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x3fc0028000/_c=
pu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0=
x0400080080/_R3 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x3fc0028=
000/_cpu/umask=3D0x04,event=3D0x85/_R3 PASS!
Test Case count_group_cpu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x0400080080/_u_R3 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x3fc0028=
000/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0400080080/_k_R3 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x3fc0028=
000/_cpu/umask=3D0x04,event=3D0x85/_and_group_cpu/umask=3D0x04,event=3D0x85=
/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0400080080/_R3 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x3fc0028=
000/_cpu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x01,event=3D0xb7,offcore_r=
sp=3D0x0400080080/_R3 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x3fc0028=
000/_cpu/umask=3D0x04,event=3D0x85/_and_group_cpu/umask=3D0x01,event=3D0xb7=
,offcore_rsp=3D0x3fc0028000/_cpu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x0400080080/_k_R3 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x3fc0028=
000/_cpu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x01,event=3D0xb7,offcore_r=
sp=3D0x0400080080/_and_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x=
3fc0028000/_cpu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x01,event=3D0xb7,of=
fcore_rsp=3D0x0400080080/_R3 PASS!
Test Case count_global_group_cpu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x0400080080/_R3 PASS!
Test Case count_global_group_cpu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x0400080080/_u_R3 PASS!
Test Case count_global_group_cpu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x0400080080/_k_R3 PASS!
Test Case count_global_group_cpu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x0400080080/_cpu/umask=3D0x01,event=3D0xb7,of=
fcore_rsp=3D0x3fc0028000/_R3 PASS!
Test Case count_global_group_cpu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x0400080080/_cpu/umask=3D0x01,event=3D0xb7,of=
fcore_rsp=3D0x3fc0028000/_u_R3 PASS!
Test Case count_global_group_cpu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x0400080080/_cpu/umask=3D0x01,event=3D0xb7,of=
fcore_rsp=3D0x3fc0028000/_k_R3 PASS!
Test Case count_cpu/umask=3D0x02,event=3D0xf/_cpu/umask=3D0x12,event=3D0xbe=
/_cpu/umask=3D0x01,event=3D0x28/_R2 PASS!
Test Case count_group_cpu/umask=3D0x02,event=3D0xf/_cpu/umask=3D0x12,event=
=3D0xbe/_R2 PASS!
Test Case count_group_cpu/umask=3D0x12,event=3D0xbe/_cpu/umask=3D0x01,event=
=3D0x28/_u_R2 PASS!
Test Case count_group_cpu/umask=3D0x02,event=3D0xf/_cpu/umask=3D0x01,event=
=3D0x28/_k_R2 PASS!
Test Case count_group_cpu/umask=3D0x02,event=3D0xf/_cpu/umask=3D0x12,event=
=3D0xbe/_and_group_cpu/umask=3D0x12,event=3D0xbe/_cpu/umask=3D0x01,event=3D=
0x28/_R2 PASS!
Test Case count_group_cpu/umask=3D0x02,event=3D0xf/_cpu/umask=3D0x12,event=
=3D0xbe/_cpu/umask=3D0x01,event=3D0x28/_R2 PASS!
Test Case count_group_cpu/umask=3D0x02,event=3D0xf/_cpu/umask=3D0x12,event=
=3D0xbe/_and_group_cpu/umask=3D0x02,event=3D0xf/_cpu/umask=3D0x12,event=3D0=
xbe/_cpu/umask=3D0x01,event=3D0x28/_k_R2 PASS!
Test Case count_group_cpu/umask=3D0x02,event=3D0xf/_cpu/umask=3D0x12,event=
=3D0xbe/_cpu/umask=3D0x01,event=3D0x28/_and_group_cpu/umask=3D0x02,event=3D=
0xf/_cpu/umask=3D0x12,event=3D0xbe/_cpu/umask=3D0x01,event=3D0x28/_R2 PASS!
Test Case count_global_group_cpu/umask=3D0x12,event=3D0xbe/_cpu/umask=3D0x0=
1,event=3D0x28/_R2 PASS!
Test Case count_global_group_cpu/umask=3D0x12,event=3D0xbe/_cpu/umask=3D0x0=
1,event=3D0x28/_u_R2 PASS!
Test Case count_global_group_cpu/umask=3D0x12,event=3D0xbe/_cpu/umask=3D0x0=
1,event=3D0x28/_k_R2 PASS!
Test Case count_global_group_cpu/umask=3D0x12,event=3D0xbe/_cpu/umask=3D0x0=
1,event=3D0x28/_cpu/umask=3D0x02,event=3D0xf/_R2 PASS!
Test Case count_global_group_cpu/umask=3D0x12,event=3D0xbe/_cpu/umask=3D0x0=
1,event=3D0x28/_cpu/umask=3D0x02,event=3D0xf/_u_R2 PASS!
Test Case count_global_group_cpu/umask=3D0x12,event=3D0xbe/_cpu/umask=3D0x0=
1,event=3D0x28/_cpu/umask=3D0x02,event=3D0xf/_k_R2 PASS!
Test Case count_cpu/umask=3D0x04,event=3D0x60/_cpu/umask=3D0x01,event=3D0xb=
7,offcore_rsp=3D0x2004000080/_cpu/umask=3D0xC2,event=3D0x88/_R1 PASS!
Test Case count_group_cpu/umask=3D0x04,event=3D0x60/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x2004000080/_R1 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x2004000=
080/_cpu/umask=3D0xC2,event=3D0x88/_u_R1 PASS!
Test Case count_group_cpu/umask=3D0x04,event=3D0x60/_cpu/umask=3D0xC2,event=
=3D0x88/_k_R1 PASS!
Test Case count_group_cpu/umask=3D0x04,event=3D0x60/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x2004000080/_and_group_cpu/umask=3D0x01,event=3D0xb7=
,offcore_rsp=3D0x2004000080/_cpu/umask=3D0xC2,event=3D0x88/_R1 PASS!
Test Case count_group_cpu/umask=3D0x04,event=3D0x60/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x2004000080/_cpu/umask=3D0xC2,event=3D0x88/_R1 PASS!
Test Case count_group_cpu/umask=3D0x04,event=3D0x60/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x2004000080/_and_group_cpu/umask=3D0x04,event=3D0x60=
/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x2004000080/_cpu/umask=3D0xC=
2,event=3D0x88/_k_R1 PASS!
Test Case count_group_cpu/umask=3D0x04,event=3D0x60/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x2004000080/_cpu/umask=3D0xC2,event=3D0x88/_and_grou=
p_cpu/umask=3D0x04,event=3D0x60/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=
=3D0x2004000080/_cpu/umask=3D0xC2,event=3D0x88/_R1 PASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x=
2004000080/_cpu/umask=3D0xC2,event=3D0x88/_R1 PASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x=
2004000080/_cpu/umask=3D0xC2,event=3D0x88/_u_R1 PASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x=
2004000080/_cpu/umask=3D0xC2,event=3D0x88/_k_R1 PASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x=
2004000080/_cpu/umask=3D0xC2,event=3D0x88/_cpu/umask=3D0x04,event=3D0x60/_R=
1 PASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x=
2004000080/_cpu/umask=3D0xC2,event=3D0x88/_cpu/umask=3D0x04,event=3D0x60/_u=
_R1 PASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x=
2004000080/_cpu/umask=3D0xC2,event=3D0x88/_cpu/umask=3D0x04,event=3D0x60/_k=
_R1 PASS!
Test Case count_cpu/umask=3D0x01,event=3D0x1f/_cpu/umask=3D0x02,event=3D0x6=
3/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x2000400004/_R0 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0x1f/_cpu/umask=3D0x02,event=
=3D0x63/_R0 PASS!
Test Case count_group_cpu/umask=3D0x02,event=3D0x63/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x2000400004/_u_R0 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0x1f/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x2000400004/_k_R0 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0x1f/_cpu/umask=3D0x02,event=
=3D0x63/_and_group_cpu/umask=3D0x02,event=3D0x63/_cpu/umask=3D0x01,event=3D=
0xb7,offcore_rsp=3D0x2000400004/_R0 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0x1f/_cpu/umask=3D0x02,event=
=3D0x63/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x2000400004/_R0 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0x1f/_cpu/umask=3D0x02,event=
=3D0x63/_and_group_cpu/umask=3D0x01,event=3D0x1f/_cpu/umask=3D0x02,event=3D=
0x63/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x2000400004/_k_R0 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0x1f/_cpu/umask=3D0x02,event=
=3D0x63/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x2000400004/_and_grou=
p_cpu/umask=3D0x01,event=3D0x1f/_cpu/umask=3D0x02,event=3D0x63/_cpu/umask=
=3D0x01,event=3D0xb7,offcore_rsp=3D0x2000400004/_R0 PASS!
Test Case count_global_group_cpu/umask=3D0x02,event=3D0x63/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x2000400004/_R0 PASS!
Test Case count_global_group_cpu/umask=3D0x02,event=3D0x63/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x2000400004/_u_R0 PASS!
Test Case count_global_group_cpu/umask=3D0x02,event=3D0x63/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x2000400004/_k_R0 PASS!
Test Case count_global_group_cpu/umask=3D0x02,event=3D0x63/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x2000400004/_cpu/umask=3D0x01,event=3D0x1f/_R=
0 PASS!
Test Case count_global_group_cpu/umask=3D0x02,event=3D0x63/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x2000400004/_cpu/umask=3D0x01,event=3D0x1f/_u=
_R0 PASS!
Test Case count_global_group_cpu/umask=3D0x02,event=3D0x63/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x2000400004/_cpu/umask=3D0x01,event=3D0x1f/_k=
_R0 PASS!
Thu May 20 09:12:44 UTC 2021
0 test cases pass for all_event_sample_group test. 80 test cases fail for a=
ll_event_sample_group test.
Test Case sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000001/_c=
pu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=
=3D0x0100020002/_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x12,event=3D0xd0/pp_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,eve=
nt=3D0xb7,offcore_rsp=3D0x0100020002/_u_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0100020002/_k_NO_FIX_HAS=
_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x12,event=3D0xd0/pp_and_cpu/umask=3D0x12,event=3D0xd0/pp_=
cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0100020002/_NO_FIX_HAS_NMI_R4=
 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,event=3D0xb7,offcore=
_rsp=3D0x0100020002/_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x12,event=3D0xd0/pp_and_cpu/umask=3D0x01,event=3D0xb7,off=
core_rsp=3D0x043c000001/_cpu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,=
event=3D0xb7,offcore_rsp=3D0x0100020002/_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,event=3D0xb7,offcore=
_rsp=3D0x0100020002/_and_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c=
000001/_cpu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,event=3D0xb7,offc=
ore_rsp=3D0x0100020002/_NO_FIX_HAS_NMI_R4 FAILED!
Test Case sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000001/_c=
pu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=
=3D0x0100020002/_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x12,event=3D0xd0/pp_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,eve=
nt=3D0xb7,offcore_rsp=3D0x0100020002/_u_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0100020002/_k_HAS_FIX_NO=
_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x12,event=3D0xd0/pp_and_cpu/umask=3D0x12,event=3D0xd0/pp_=
cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0100020002/_HAS_FIX_NO_NMI_R4=
 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,event=3D0xb7,offcore=
_rsp=3D0x0100020002/_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x12,event=3D0xd0/pp_and_cpu/umask=3D0x01,event=3D0xb7,off=
core_rsp=3D0x043c000001/_cpu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,=
event=3D0xb7,offcore_rsp=3D0x0100020002/_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,event=3D0xb7,offcore=
_rsp=3D0x0100020002/_and_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c=
000001/_cpu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,event=3D0xb7,offc=
ore_rsp=3D0x0100020002/_HAS_FIX_NO_NMI_R4 FAILED!
Test Case sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=3D0xf=
4/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x007c000002/_NO_FIX_HAS_NMI=
_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=
=3D0xf4/_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x20,event=3D0xf4/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x007c000002/_u_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x007c000002/_k_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=
=3D0xf4/_and_cpu/umask=3D0x20,event=3D0xf4/_cpu/umask=3D0x01,event=3D0xb7,o=
ffcore_rsp=3D0x007c000002/_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=
=3D0xf4/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x007c000002/_NO_FIX_H=
AS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=
=3D0xf4/_and_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=3D0xf4/_=
cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x007c000002/_NO_FIX_HAS_NMI_R3=
 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=
=3D0xf4/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x007c000002/_and_cpu/=
umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=3D0xf4/_cpu/umask=3D0x01,=
event=3D0xb7,offcore_rsp=3D0x007c000002/_NO_FIX_HAS_NMI_R3 FAILED!
Test Case sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=3D0xf=
4/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x007c000002/_HAS_FIX_NO_NMI=
_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=
=3D0xf4/_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x20,event=3D0xf4/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x007c000002/_u_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x007c000002/_k_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=
=3D0xf4/_and_cpu/umask=3D0x20,event=3D0xf4/_cpu/umask=3D0x01,event=3D0xb7,o=
ffcore_rsp=3D0x007c000002/_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=
=3D0xf4/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x007c000002/_HAS_FIX_=
NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=
=3D0xf4/_and_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=3D0xf4/_=
cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x007c000002/_HAS_FIX_NO_NMI_R3=
 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=
=3D0xf4/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x007c000002/_and_cpu/=
umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=3D0xf4/_cpu/umask=3D0x01,=
event=3D0xb7,offcore_rsp=3D0x007c000002/_HAS_FIX_NO_NMI_R3 FAILED!
Test Case sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_cpu/umask=
=3D0x01,event=3D0xb7,offcore_rsp=3D0x10001c0002/_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_NO_F=
IX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xaf/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x10001c0002/_u_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x01,event=3D0xb7,offco=
re_rsp=3D0x10001c0002/_k_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_and_=
cpu/umask=3D0x80,event=3D0xaf/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D=
0x10001c0002/_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_cpu/=
umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x10001c0002/_NO_FIX_HAS_NMI_R2 FAI=
LED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_and_=
cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_cpu/umask=3D0x01,event=3D0=
xb7,offcore_rsp=3D0x10001c0002/_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_cpu/=
umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x10001c0002/_and_cpu/event=3D0xc4/=
_cpu/umask=3D0x80,event=3D0xaf/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=
=3D0x10001c0002/_NO_FIX_HAS_NMI_R2 FAILED!
Test Case sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_cpu/umask=
=3D0x01,event=3D0xb7,offcore_rsp=3D0x10001c0002/_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_HAS_=
FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xaf/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x10001c0002/_u_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x01,event=3D0xb7,offco=
re_rsp=3D0x10001c0002/_k_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_and_=
cpu/umask=3D0x80,event=3D0xaf/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D=
0x10001c0002/_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_cpu/=
umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x10001c0002/_HAS_FIX_NO_NMI_R2 FAI=
LED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_and_=
cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_cpu/umask=3D0x01,event=3D0=
xb7,offcore_rsp=3D0x10001c0002/_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_cpu/=
umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x10001c0002/_and_cpu/event=3D0xc4/=
_cpu/umask=3D0x80,event=3D0xaf/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=
=3D0x10001c0002/_HAS_FIX_NO_NMI_R2 FAILED!
Test Case sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=3D0xbc=
/_cpu/umask=3D0x42,event=3D0x36/_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=
=3D0xbc/_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x28,event=3D0xbc/_cpu/umask=3D0x42,event=
=3D0x36/_u_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x42,event=
=3D0x36/_k_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=
=3D0xbc/_and_cpu/umask=3D0x28,event=3D0xbc/_cpu/umask=3D0x42,event=3D0x36/_=
NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=
=3D0xbc/_cpu/umask=3D0x42,event=3D0x36/_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=
=3D0xbc/_and_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=3D0xbc/_c=
pu/umask=3D0x42,event=3D0x36/_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=
=3D0xbc/_cpu/umask=3D0x42,event=3D0x36/_and_cpu/umask=3D0x80,event=3D0x8/_c=
pu/umask=3D0x28,event=3D0xbc/_cpu/umask=3D0x42,event=3D0x36/_NO_FIX_HAS_NMI=
_R1 FAILED!
Test Case sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=3D0xbc=
/_cpu/umask=3D0x42,event=3D0x36/_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=
=3D0xbc/_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x28,event=3D0xbc/_cpu/umask=3D0x42,event=
=3D0x36/_u_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x42,event=
=3D0x36/_k_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=
=3D0xbc/_and_cpu/umask=3D0x28,event=3D0xbc/_cpu/umask=3D0x42,event=3D0x36/_=
HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=
=3D0xbc/_cpu/umask=3D0x42,event=3D0x36/_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=
=3D0xbc/_and_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=3D0xbc/_c=
pu/umask=3D0x42,event=3D0x36/_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=
=3D0xbc/_cpu/umask=3D0x42,event=3D0x36/_and_cpu/umask=3D0x80,event=3D0x8/_c=
pu/umask=3D0x28,event=3D0xbc/_cpu/umask=3D0x42,event=3D0x36/_HAS_FIX_NO_NMI=
_R1 FAILED!
Test Case sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040100/_c=
pu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=3D0x80,e=
vent=3D0xcc/_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_NO_FIX_HAS_N=
MI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8=
000/_cpu/umask=3D0x80,event=3D0xcc/_u_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x80,event=3D0xcc/_k_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_and_cpu/umas=
k=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=3D0x80,event=3D=
0xcc/_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=3D=
0x80,event=3D0xcc/_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_and_cpu/umas=
k=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040100/_cpu/umask=3D0x01,event=3D=
0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=3D0x80,event=3D0xcc/_NO_FIX_HAS_=
NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=3D=
0x80,event=3D0xcc/_and_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x100004=
0100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=
=3D0x80,event=3D0xcc/_NO_FIX_HAS_NMI_R0 FAILED!
Test Case sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040100/_c=
pu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=3D0x80,e=
vent=3D0xcc/_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_HAS_FIX_NO_N=
MI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8=
000/_cpu/umask=3D0x80,event=3D0xcc/_u_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x80,event=3D0xcc/_k_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_and_cpu/umas=
k=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=3D0x80,event=3D=
0xcc/_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=3D=
0x80,event=3D0xcc/_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_and_cpu/umas=
k=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040100/_cpu/umask=3D0x01,event=3D=
0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=3D0x80,event=3D0xcc/_HAS_FIX_NO_=
NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=3D=
0x80,event=3D0xcc/_and_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x100004=
0100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=
=3D0x80,event=3D0xcc/_HAS_FIX_NO_NMI_R0 FAILED!
Don't do offcore test. NO EXTRA_REG support
2021-05-20 09:12:45 ./ht_leak_test/run.sh
SKIP for ht_leak_test test
2021-05-20 09:12:45 ./lbr_test/run.sh
Thu May 20 09:13:00 UTC 2021
0 test cases pass for lbr_test test. 24 test cases fail for lbr_test test.
Test Case instructions_any_tchain_edit_without_NMI_1_R2 FAILED!
Test Case instructions_any_ret_ind_call_tchain_edit_without_NMI_1_R2 FAILED!
Test Case instructions_any_call_tchain_edit_without_NMI_1_R2 FAILED!
Test Case instructions_any_ret_tchain_edit_without_NMI_1_R2 FAILED!
Test Case instructions_ind_call_tchain_edit_without_NMI_1_R2 FAILED!
Test Case instructions_any_ind_call_tchain_edit_without_NMI_1_R2 FAILED!
Test Case instructions_any_ret_ind_call_tchain_edit_without_NMI_1_R2 FAILED!
Test Case instructions_any_call_ind_call_u_tchain_edit_without_NMI_1_R2 FAI=
LED!
Test Case instructions_any_call_ind_call_k_tchain_edit_without_NMI_1_R2 FAI=
LED!
Test Case instructions_any_any_call_ind_call_u_k_tchain_edit_without_NMI_1_=
R2 FAILED!
Test Case instructions_call_chain_fp_tchain_edit_without_NMI_1_R2 FAILED!
Test Case instructions_call_chain_lbr_tchain_edit_without_NMI_1_R2 FAILED!
Test Case instructions_any_tchain_edit_with_NMI_0_R1 FAILED!
Test Case instructions_any_ret_ind_call_tchain_edit_with_NMI_0_R1 FAILED!
Test Case instructions_any_call_tchain_edit_with_NMI_0_R1 FAILED!
Test Case instructions_any_ret_tchain_edit_with_NMI_0_R1 FAILED!
Test Case instructions_ind_call_tchain_edit_with_NMI_0_R1 FAILED!
Test Case instructions_any_ind_call_tchain_edit_with_NMI_0_R1 FAILED!
Test Case instructions_any_ret_ind_call_tchain_edit_with_NMI_0_R1 FAILED!
Test Case instructions_any_call_ind_call_u_tchain_edit_with_NMI_0_R1 FAILED!
Test Case instructions_any_call_ind_call_k_tchain_edit_with_NMI_0_R1 FAILED!
Test Case instructions_any_any_call_ind_call_u_k_tchain_edit_with_NMI_0_R1 =
FAILED!
Test Case instructions_call_chain_fp_tchain_edit_with_NMI_0_R1 FAILED!
Test Case instructions_call_chain_lbr_tchain_edit_with_NMI_0_R1 FAILED!
2021-05-20 09:13:03 ./mem_addr_profile_test/run.sh
SKIP for mem_addr_profile_test test
2021-05-20 09:13:03 ./msr_test/run.sh
Thu May 20 09:13:13 UTC 2021
1 test cases pass for msr_test test. 0 test cases fail for msr_test test.
Test Case cpu_util_full PASS!
2021-05-20 09:13:14 ./pebs_test/run.sh
Thu May 20 09:13:14 UTC 2021
0 test cases pass for pebs_test test. 0 test cases fail for pebs_test test.
2021-05-20 09:13:14 ./rapl_test/run.sh
SKIP for rapl_test test
2021-05-20 09:13:14 ./rdpmc_test/run.sh
Thu May 20 09:13:15 UTC 2021
4 test cases pass for rdpmc_test test. 0 test cases fail for rdpmc_test tes=
t.
Test Case instructions_branches_sin-lib PASS!
Test Case instructions_branches_triad_loop-lib PASS!
Test Case instructions_branches_million-instruction-lib PASS!
Test Case instructions_branches_branches-lib PASS!
2021-05-20 09:13:15 ./single_event_test/run.sh
ROUND 1: perf hardware event count test
ROUND 1: perf hardware cache event count test
ROUND 1: perf kernel cpu PMU event count test
ROUND 1: perf hardware event sample test
ROUND 1: perf hardware cache event sample test
ROUND 1: perf kernel cpu PMU event sample test
Disable NMI watchdog for special sample test
ROUND 2: perf hardware event count test
ROUND 2: perf hardware cache event count test
ROUND 2: perf kernel cpu PMU event count test
ROUND 2: perf hardware event sample test
ROUND 2: perf hardware cache event sample test
ROUND 2: perf kernel cpu PMU event sample test
Enable NMI watchdog
Thu May 20 09:14:12 UTC 2021
16 test cases pass for hw_event_count test. 0 test cases fail for hw_event_=
count test.
Test Case hardware_event_count_test_branch-instructions_1_2 PASS!
Test Case hardware_event_count_test_branch-misses_1_2 PASS!
Test Case hardware_event_count_test_bus-cycles_1_2 PASS!
Test Case hardware_event_count_test_cache-misses_1_2 PASS!
Test Case hardware_event_count_test_cache-references_1_2 PASS!
Test Case hardware_event_count_test_cpu-cycles_1_2 PASS!
Test Case hardware_event_count_test_instructions_1_2 PASS!
Test Case hardware_event_count_test_ref-cycles_1_2 PASS!
Test Case hardware_event_count_test_branch-instructions_2_1 PASS!
Test Case hardware_event_count_test_branch-misses_2_1 PASS!
Test Case hardware_event_count_test_bus-cycles_2_1 PASS!
Test Case hardware_event_count_test_cache-misses_2_1 PASS!
Test Case hardware_event_count_test_cache-references_2_1 PASS!
Test Case hardware_event_count_test_cpu-cycles_2_1 PASS!
Test Case hardware_event_count_test_instructions_2_1 PASS!
Test Case hardware_event_count_test_ref-cycles_2_1 PASS!
Thu May 20 09:14:12 UTC 2021
0 test cases pass for hw_cache_event_count test. 0 test cases fail for hw_c=
ache_event_count test.
Thu May 20 09:14:12 UTC 2021
44 test cases pass for pmu_event_count test. 0 test cases fail for pmu_even=
t_count test.
Test Case cpu_PMU_event_count_test_cpu/branch-instructions/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/branch-misses/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/bus-cycles/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/cache-misses/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/cache-references/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/cpu-cycles/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/cycles-ct/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/cycles-t/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/el-abort/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/el-capacity/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/el-commit/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/el-conflict/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/el-start/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/instructions/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/mem-loads/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/mem-stores/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/ref-cycles/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/tx-abort/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/tx-capacity/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/tx-commit/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/tx-conflict/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/tx-start/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/branch-instructions/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/branch-misses/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/bus-cycles/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/cache-misses/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/cache-references/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/cpu-cycles/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/cycles-ct/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/cycles-t/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/el-abort/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/el-capacity/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/el-commit/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/el-conflict/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/el-start/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/instructions/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/mem-loads/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/mem-stores/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/ref-cycles/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/tx-abort/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/tx-capacity/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/tx-commit/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/tx-conflict/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/tx-start/_2_1 PASS!
Thu May 20 09:14:12 UTC 2021
0 test cases pass for hw_event_sample test. 20 test cases fail for hw_event=
_sample test.
Test Case hardware_event_sample_test_branch-instructions_1_2 FAILED!
Test Case hardware_event_sample_test_branch-misses_1_2 FAILED!
Test Case hardware_event_sample_test_bus-cycles_1_2 FAILED!
Test Case hardware_event_sample_test_cache-misses_1_2 FAILED!
Test Case hardware_event_sample_test_cache-references_1_2 FAILED!
Test Case hardware_event_sample_test_cpu-cycles_1_2 FAILED!
Test Case hardware_event_sample_test_instructions_1_2 FAILED!
Test Case hardware_event_sample_test_ref-cycles_1_2 FAILED!
Test Case hardware_event_sample_test_cycles:p_1_2 FAILED!
Test Case hardware_event_sample_test_cycles:pp_1_2 FAILED!
Test Case hardware_event_sample_test_branch-instructions_2_1 FAILED!
Test Case hardware_event_sample_test_branch-misses_2_1 FAILED!
Test Case hardware_event_sample_test_bus-cycles_2_1 FAILED!
Test Case hardware_event_sample_test_cache-misses_2_1 FAILED!
Test Case hardware_event_sample_test_cache-references_2_1 FAILED!
Test Case hardware_event_sample_test_cpu-cycles_2_1 FAILED!
Test Case hardware_event_sample_test_instructions_2_1 FAILED!
Test Case hardware_event_sample_test_ref-cycles_2_1 FAILED!
Test Case hardware_event_sample_test_cycles:p_2_1 FAILED!
Test Case hardware_event_sample_test_cycles:pp_2_1 FAILED!
Thu May 20 09:14:12 UTC 2021
0 test cases pass for hw_cache_event_sample test. 0 test cases fail for hw_=
cache_event_sample test.
Thu May 20 09:14:12 UTC 2021
0 test cases pass for pmu_event_sample test. 50 test cases fail for pmu_eve=
nt_sample test.
Test Case cpu_PMU_event_sample_test_cpu/branch-instructions/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/branch-misses/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/bus-cycles/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cache-misses/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cache-references/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cpu-cycles/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cpu-cycles/p_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cpu-cycles/pp_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cycles-t/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/el-abort/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/el-capacity/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/el-commit/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/el-conflict/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/el-start/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/instructions/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/mem-loads/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/mem-loads/pp_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/mem-stores/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/mem-stores/pp_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/ref-cycles/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/tx-abort/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/tx-capacity/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/tx-commit/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/tx-conflict/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/tx-start/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/branch-instructions/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/branch-misses/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/bus-cycles/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cache-misses/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cache-references/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cpu-cycles/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cpu-cycles/p_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cpu-cycles/pp_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cycles-t/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/el-abort/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/el-capacity/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/el-commit/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/el-conflict/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/el-start/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/instructions/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/mem-loads/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/mem-loads/pp_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/mem-stores/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/mem-stores/pp_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/ref-cycles/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/tx-abort/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/tx-capacity/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/tx-commit/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/tx-conflict/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/tx-start/_2_1 FAILED!
2021-05-20 09:14:13 ./skid_test/run.sh
Thu May 20 09:14:17 UTC 2021
4 test cases pass for skid_test test. 2 test cases fail for skid_test test.
Test Case BR_INST_RETIRED.ALL_BRANCHES_PEBS_triad_loop_with_NMI FAILED!
Test Case MEM_LOAD_RETIRED.L2_HIT_dtlb_with_NMI PASS!
Test Case MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_dtlb_with_NMI PASS!
Test Case BR_INST_RETIRED.ALL_BRANCHES_PEBS_triad_loop_without_NMI_fixed_pe=
riod FAILED!
Test Case MEM_LOAD_RETIRED.L2_HIT_dtlb_without_NMI_fixed_period PASS!
Test Case MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_dtlb_without_NMI_fixed_period=
 PASS!
2021-05-20 09:14:18 ./topdown_test/run.sh
Cannot find topdown event list. SKIP for topdown_test test
Thu May 20 09:14:18 UTC 2021
0 test cases pass for topdown_test test. 0 test cases fail for topdown_test=
 test.
2021-05-20 09:14:18 ./tsx_test/run.sh
SKIP for tsx_test test
2021-05-20 09:14:18 ./uncore_test/run.sh
SKIP for uncore_test test
2021-05-20 09:14:18 ./uncore_topology_test/run.sh
SKIP for uncore_topology_test test
2021-05-20 09:14:18 ./virtulization_test/run.sh
SKIP for virtulization_test test



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install                job.yaml  # job file is attached in =
this email
        bin/lkp split-job --compatible job.yaml  # generate the yaml file f=
or lkp run
        bin/lkp run                    generated-yaml-file



---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Cent=
er
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporati=
on

Thanks,
Oliver Sang


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.13.0-rc1-00016-g71d7924b3e8a"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.13.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23502
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23502
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_PRELOAD is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
# CONFIG_XEN_PV is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_PVHVM_GUEST=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
CONFIG_PERF_EVENTS_AMD_POWER=m
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_XEN is not set
CONFIG_KVM_MMU_AUDIT=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=19
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_IO_MAPPING=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
# CONFIG_TIPC_MEDIA_IB is not set
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
# CONFIG_BT_AOSPEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
# CONFIG_BT_HCIBCM203X is not set
# CONFIG_BT_HCIBPA10X is not set
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
# CONFIG_BT_MRVL_SDIO is not set
# CONFIG_BT_MTKSDIO is not set
# CONFIG_BT_VIRTIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_PM_QOS_KUNIT_TEST is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
# CONFIG_DRIVER_PE_KUNIT_TEST is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_RDMA is not set
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
# CONFIG_NVME_TARGET_RDMA is not set
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_MICROSOFT_MANA is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
# CONFIG_LED_TRIGGER_PHY is not set
# CONFIG_FIXED_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7663S is not set
# CONFIG_MT7915E is not set
# CONFIG_MT7921E is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
# CONFIG_WWAN is not set
CONFIG_XEN_NETDEV_FRONTEND=y
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_HYPERV_NET is not set
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_BCM63XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_ALTERA_CORE is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# CONFIG_PTP_1588_CLOCK_OCP is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_ALDERLAKE is not set
CONFIG_PINCTRL_BROXTON=m
CONFIG_PINCTRL_CANNONLAKE=m
CONFIG_PINCTRL_CEDARFORK=m
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=m
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_INTEL_PMT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_IR_ENE=m
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
# CONFIG_IR_STREAMZAP is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_TTUSBIR is not set
# CONFIG_RC_LOOPBACK is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
CONFIG_IR_SIR=m
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
CONFIG_MEDIA_CEC_SUPPORT=y
# CONFIG_CEC_CH7322 is not set
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
# end of Video4Linux options

#
# Media controller options
#
# CONFIG_MEDIA_CONTROLLER_DVB is not set
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=16
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_RADIO_ADAPTERS=y
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
# CONFIG_SMS_SDIO_DRV is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
# CONFIG_DVB_FIREDTV is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
# CONFIG_VIDEO_MSP3400 is not set
# CONFIG_VIDEO_CS3308 is not set
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
# CONFIG_VIDEO_VP27SMPX is not set
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
# CONFIG_VIDEO_SAA711X is not set
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
# CONFIG_VIDEO_SAA717X is not set
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
# CONFIG_VIDEO_M52790 is not set
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_OV02A10 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV5648 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV8865 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV9734 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_M5MOLS is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RDACM21 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_CCS is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=m
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
CONFIG_DVB_S5H1432=m
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB9000=m
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
CONFIG_DVB_ZD1301_DEMOD=m
CONFIG_DVB_CXD2880=m

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m
CONFIG_DVB_MXL692=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
CONFIG_DVB_MN88443X=m

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
CONFIG_DVB_LNBH29=m
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
CONFIG_DVB_LGS8GL5=m
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
CONFIG_DVB_HORUS3A=m
CONFIG_DVB_ASCOT2E=m
CONFIG_DVB_HELENE=m

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
CONFIG_DVB_SP2=m
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
# CONFIG_DVB_DUMMY_FE is not set
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN_FRONTEND is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
CONFIG_HID_CHICONY=m
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PLAYSTATION is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_STUSB160X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_EFA is not set
# CONFIG_INFINIBAND_I40IW is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_USNIC is not set
# CONFIG_INFINIBAND_RDMAVT is not set
CONFIG_RDMA_RXE=m
CONFIG_RDMA_SIW=m
CONFIG_INFINIBAND_IPOIB=m
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
# CONFIG_INFINIBAND_ISER is not set
# CONFIG_INFINIBAND_ISERT is not set
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
# CONFIG_INFINIBAND_RTRS_SERVER is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
# CONFIG_XEN_UNPOPULATED_ALLOC is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_HID_EVENT=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_VBTN=m
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
CONFIG_IOMMU_IO_PGTABLE=y
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_DTPM is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_EXT4_KUNIT_TESTS=m
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
# CONFIG_NETFS_STATS is not set
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=m
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_APPARMOR_KUNIT_TEST is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=m
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
# CONFIG_KUNIT_DEBUGFS is not set
CONFIG_KUNIT_TEST=m
CONFIG_KUNIT_EXAMPLE_TEST=m
# CONFIG_KUNIT_ALL_TESTS is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAULT_INJECTION_USERCOPY is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
CONFIG_TEST_BPF=m
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_BITFIELD_KUNIT is not set
# CONFIG_RESOURCE_KUNIT_TEST is not set
CONFIG_SYSCTL_KUNIT_TEST=m
CONFIG_LIST_KUNIT_TEST=m
# CONFIG_LINEAR_RANGES_TEST is not set
# CONFIG_CMDLINE_KUNIT_TEST is not set
# CONFIG_BITS_TEST is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='perf-test'
	export testcase='perf-test'
	export category='functional'
	export type='lkp'
	export job_origin='perf-test.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-kbl-d01'
	export tbox_group='lkp-kbl-d01'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='60a616a348c941242aac2925'
	export job_file='/lkp/jobs/scheduled/lkp-kbl-d01/perf-test-lkp-ucode=0xde-debian-10.4-x86_64-20200603.cgz-71d7924b3e8acaca6a3b0fc3261170031ada3b70-20210520-74794-5ohzpg-2.yaml'
	export id='3bfc43cd29ea9ef06441de8519e8149ca1f7b15b'
	export queuer_version='/lkp-src'
	export model='Kaby Lake'
	export nr_node=1
	export nr_cpu=8
	export memory='32G'
	export nr_sdd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/ata-ST1000DM003-1CH162_Z1D3X32H-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2KW010X6_BTLT630000X61P0FGN-part2'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2KW010X6_BTLT630000X61P0FGN-part1'
	export brand='Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz'
	export need_linux_perf=true
	export commit='71d7924b3e8acaca6a3b0fc3261170031ada3b70'
	export ucode='0xde'
	export need_kconfig_hw='CONFIG_E1000E=y
CONFIG_SATA_AHCI'
	export bisect_dmesg=true
	export enqueue_time='2021-05-20 15:58:27 +0800'
	export _id='60a616a948c941242aac2926'
	export _rt='/result/perf-test/lkp-ucode=0xde/lkp-kbl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/71d7924b3e8acaca6a3b0fc3261170031ada3b70'
	export user='lkp'
	export compiler='gcc-9'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='fe596c3a53e1baccc0aa17b00fab3636615c353d'
	export base_commit='d07f6ca923ea0927a1024dfccafc5b53b61cfecc'
	export branch='linus/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/perf-test/lkp-ucode=0xde/lkp-kbl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/71d7924b3e8acaca6a3b0fc3261170031ada3b70/3'
	export scheduler_version='/lkp/lkp/.src-20210519-183212'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-kbl-d01/perf-test-lkp-ucode=0xde-debian-10.4-x86_64-20200603.cgz-71d7924b3e8acaca6a3b0fc3261170031ada3b70-20210520-74794-5ohzpg-2.yaml
ARCH=x86_64
kconfig=x86_64-rhel-8.3
branch=linus/master
commit=71d7924b3e8acaca6a3b0fc3261170031ada3b70
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/71d7924b3e8acaca6a3b0fc3261170031ada3b70/vmlinuz-5.13.0-rc1-00016-g71d7924b3e8a
max_uptime=2100
RESULT_ROOT=/result/perf-test/lkp-ucode=0xde/lkp-kbl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/71d7924b3e8acaca6a3b0fc3261170031ada3b70/3
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/71d7924b3e8acaca6a3b0fc3261170031ada3b70/modules.cgz'
	export linux_perf_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-9/71d7924b3e8acaca6a3b0fc3261170031ada3b70/linux-perf.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf-test_20210508.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-test-x86_64-git-1_20210508.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20210222.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.13.0-rc2'
	export repeat_to=6
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-9/71d7924b3e8acaca6a3b0fc3261170031ada3b70/vmlinuz-5.13.0-rc1-00016-g71d7924b3e8a'
	export dequeue_time='2021-05-20 16:54:33 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-kbl-d01/perf-test-lkp-ucode=0xde-debian-10.4-x86_64-20200603.cgz-71d7924b3e8acaca6a3b0fc3261170031ada3b70-20210520-74794-5ohzpg-2.cgz'

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

	run_test $LKP_SRC/tests/wrapper perf-test
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper perf-test
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time perf-test.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--4SFOXa2GPu3tIq4H
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
7pMAAceSAq2BC5v4naqxxGf7AgAAAAAEWVo=

--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=perf-test
Content-Transfer-Encoding: quoted-printable

CPU architecture is skylake
2021-05-20 08:55:33 make ARCH=3D DEBUG=3D1 EXTRA_CFLAGS=3D-fno-omit-frame-p=
ointer -fsanitize=3Dundefined -fsanitize=3Daddress -C /usr/src/linux-perf-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-71d7924b3=
e8acaca6a3b0fc3261170031ada3b70/tools/perf'
  BUILD:   Doing 'make =1B[33m-j8=1B[m' parallel build
  HOSTCC   fixdep.o
  HOSTLD   fixdep-in.o
  LINK     fixdep

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

=2E..                      /tmp/lkp: [ =1B[31mOFF=1B[m ]

  GEN      common-cmds.h
  CC       fd/array.o
  CC       exec-cmd.o
  CC       event-parse.o
  CC       core.o
  CC       cpumap.o
  CC       event-plugin.o
  GEN      bpf_helper_defs.h
  MKDIR    staticobjs/
  CC       trace-seq.o
  CC       staticobjs/libbpf.o
  CC       help.o
  LD       fd/libapi-in.o
  CC       fs/fs.o
  CC       threadmap.o
  CC       parse-filter.o
  CC       parse-utils.o
  CC       kbuffer-parse.o
  CC       fs/tracing_path.o
  CC       evsel.o
  CC       pager.o
  CC       parse-options.o
  CC       fs/cgroup.o
  CC       evlist.o
  LD       fs/libapi-in.o
  CC       tep_strerror.o
  CC       cpu.o
  CC       mmap.o
  CC       event-parse-api.o
  CC       debug.o
  CC       str_error_r.o
  LD       libapi-in.o
  CC       zalloc.o
  AR       libapi.a
  CC       run-command.o
  CC       sigchain.o
  CC       subcmd-config.o
  CC       xyarray.o
  CC       lib.o
  MKDIR    staticobjs/
  CC       staticobjs/bpf.o
  CC       staticobjs/nlattr.o
  LD       libperf-in.o
  LD       libsubcmd-in.o
  AR       libperf.a
  CC       staticobjs/btf.o
  AR       libsubcmd.a
  CC       staticobjs/libbpf_errno.o
  CC       staticobjs/str_error.o
  CC       staticobjs/netlink.o
  CC       staticobjs/bpf_prog_linfo.o
  CC       staticobjs/libbpf_probes.o
  CC       staticobjs/xsk.o
  CC       staticobjs/hashmap.o
  CC       staticobjs/btf_dump.o
  CC       staticobjs/ringbuf.o
  CC       staticobjs/strset.o
  CC       staticobjs/linker.o
  HOSTCC   pmu-events/json.o
  HOSTCC   pmu-events/jsmn.o
  CC       plugin_jbd2.o
  HOSTCC   pmu-events/jevents.o
  LD       plugin_jbd2-in.o
  CC       plugin_hrtimer.o
  LD       libtraceevent-in.o
  CC       plugin_kmem.o
  LD       plugin_hrtimer-in.o
  LINK     libtraceevent.a
  CC       jvmti/libjvmti.o
  CC       plugin_kvm.o
  LD       plugin_kmem-in.o
  GEN      perf-archive
  CC       plugin_mac80211.o
  HOSTLD   pmu-events/jevents-in.o
  CC       plugin_sched_switch.o
  LD       plugin_mac80211-in.o
  GEN      perf-with-kcore
  LD       plugin_kvm-in.o
  GEN      perf-iostat
  CC       plugin_function.o
  CC       jvmti/jvmti_agent.o
  LD       plugin_sched_switch-in.o
  CC       jvmti/libstring.o
  CC       plugin_futex.o
  LD       plugin_function-in.o
  CC       jvmti/libctype.o
  CC       plugin_xen.o
  LD       plugin_futex-in.o
  CC       plugin_scsi.o
  CC       plugin_cfg80211.o
  LD       jvmti/jvmti-in.o
  CC       plugin_tlb.o
  LINK     pmu-events/jevents
  LINK     libperf-jvmti.so
  LD       plugin_cfg80211-in.o
  LINK     plugin_jbd2.so
  LD       plugin_xen-in.o
  LD       plugin_tlb-in.o
  LINK     plugin_hrtimer.so
  LINK     plugin_kmem.so
  LINK     plugin_kvm.so
  LINK     plugin_mac80211.so
  LINK     plugin_sched_switch.so
  LINK     plugin_function.so
  GEN      pmu-events/pmu-events.c
  LINK     plugin_futex.so
  LINK     plugin_xen.so
  LINK     plugin_cfg80211.so
  LD       plugin_scsi-in.o
  LINK     plugin_tlb.so
  LINK     plugin_scsi.so
  CC       builtin-bench.o
  CC       builtin-annotate.o
  CC       builtin-config.o
  CC       builtin-diff.o
  GEN      libtraceevent-dynamic-list
  CC       builtin-evlist.o
  CC       builtin-ftrace.o
  CC       builtin-help.o
  CC       pmu-events/pmu-events.o
  CC       builtin-sched.o
  CC       builtin-buildid-list.o
  CC       builtin-buildid-cache.o
  CC       builtin-kallsyms.o
  CC       builtin-list.o
  CC       builtin-record.o
  CC       builtin-report.o
  CC       builtin-stat.o
  GEN      python/perf.so
  CC       builtin-timechart.o
  LD       staticobjs/libbpf-in.o
  LINK     libbpf.a
  CC       builtin-top.o
  CC       builtin-script.o
  LD       pmu-events/pmu-events-in.o
  CC       builtin-kmem.o
  CC       builtin-lock.o
  CC       builtin-kvm.o
  CC       builtin-inject.o
  CC       builtin-mem.o
  CC       builtin-data.o
  CC       builtin-version.o
  CC       builtin-c2c.o
  CC       builtin-daemon.o
  CC       builtin-trace.o
  CC       builtin-probe.o
  CC       bench/sched-messaging.o
  CC       tests/builtin-test.o
  CC       bench/sched-pipe.o
  CC       bench/syscall.o
  CC       tests/parse-events.o
  CC       bench/mem-functions.o
  CC       bench/futex-hash.o
  CC       util/annotate.o
  CC       bench/futex-wake.o
  CC       bench/futex-wake-parallel.o
  CC       bench/futex-requeue.o
  CC       bench/futex-lock-pi.o
  CC       arch/common.o
  CC       arch/x86/util/header.o
  CC       bench/epoll-wait.o
  CC       arch/x86/tests/regs_load.o
  CC       tests/dso-data.o
  CC       arch/x86/util/tsc.o
  CC       arch/x86/tests/dwarf-unwind.o
  CC       arch/x86/util/pmu.o
  CC       arch/x86/tests/arch-tests.o
  CC       bench/epoll-ctl.o
  CC       arch/x86/tests/rdpmc.o
  CC       arch/x86/util/kvm-stat.o
  CC       arch/x86/util/perf_regs.o
  CC       arch/x86/tests/sample-parsing.o
  CC       arch/x86/util/topdown.o
  CC       bench/synthesize.o
  CC       arch/x86/util/machine.o
  CC       tests/attr.o
  CC       tests/vmlinux-kallsyms.o
  CC       arch/x86/tests/insn-x86.o
  CC       arch/x86/util/event.o
  CC       tests/openat-syscall.o
  CC       bench/kallsyms-parse.o
  CC       tests/openat-syscall-all-cpus.o
  CC       arch/x86/util/evlist.o
  CC       arch/x86/tests/intel-pt-pkt-decoder-test.o
  CC       tests/openat-syscall-tp-fields.o
  CC       bench/find-bit-bench.o
  CC       tests/mmap-basic.o
  CC       arch/x86/util/mem-events.o
  CC       arch/x86/tests/bp-modify.o
  CC       bench/inject-buildid.o
  CC       tests/perf-record.o
  CC       arch/x86/util/evsel.o
  CC       util/block-info.o
  CC       ui/setup.o
  LD       arch/x86/tests/perf-in.o
  CC       ui/helpline.o
  CC       arch/x86/util/iostat.o
  CC       arch/x86/util/dwarf-regs.o
  CC       tests/evsel-roundtrip-name.o
  CC       ui/progress.o
  CC       tests/evsel-tp-sched.o
  CC       tests/fdarray.o
  CC       bench/mem-memcpy-x86-64-asm.o
  CC       ui/util.o
  CC       bench/mem-memset-x86-64-asm.o
  CC       util/block-range.o
  CC       ui/hist.o
  CC       arch/x86/util/unwind-libunwind.o
  CC       tests/pmu.o
  CC       bench/numa.o
  CC       arch/x86/util/auxtrace.o
  CC       tests/pmu-events.o
  CC       tests/hists_common.o
  CC       tests/hists_link.o
  CC       util/build-id.o
  CC       arch/x86/util/archinsn.o
  CC       tests/hists_filter.o
  CC       arch/x86/util/intel-pt.o
  CC       tests/hists_output.o
  CC       ui/stdio/hist.o
  CC       ui/browser.o
  CC       util/cacheline.o
  CC       util/config.o
  CC       tests/hists_cumulate.o
  LD       bench/perf-in.o
  CC       scripts/perl/Perf-Trace-Util/Context.o
  CC       ui/browsers/annotate.o
  CC       ui/tui/setup.o
  CC       tests/python-use.o
  CC       arch/x86/util/intel-bts.o
  CC       util/copyfile.o
  CC       tests/bp_signal.o
  CC       ui/tui/util.o
  CC       util/ctype.o
  CC       tests/bp_signal_overflow.o
  CC       util/db-export.o
  CC       tests/bp_account.o
  CC       ui/tui/helpline.o
  LD       arch/x86/util/perf-in.o
  LD       scripts/perl/Perf-Trace-Util/perf-in.o
  CC       tests/wp.o
  CC       scripts/python/Perf-Trace-Util/Context.o
  CC       ui/browsers/hists.o
  LD       arch/x86/perf-in.o
  CC       tests/task-exit.o
  LD       arch/perf-in.o
  CC       ui/tui/progress.o
  CC       trace/beauty/clone.o
  CC       tests/sw-clock.o
  CC       util/env.o
  LD       ui/tui/perf-in.o
  CC       trace/beauty/fcntl.o
  CC       trace/beauty/flock.o
  LD       scripts/python/Perf-Trace-Util/perf-in.o
  CC       tests/mmap-thread-lookup.o
  LD       scripts/perf-in.o
  CC       perf.o
  CC       tests/thread-maps-share.o
  CC       trace/beauty/fsmount.o
  CC       trace/beauty/fspick.o
  CC       trace/beauty/ioctl.o
  CC       tests/switch-tracking.o
  CC       util/event.o
  CC       trace/beauty/kcmp.o
  CC       util/evlist.o
  CC       ui/browsers/map.o
  CC       trace/beauty/mount_flags.o
  CC       trace/beauty/move_mount.o
  CC       trace/beauty/pkey_alloc.o
  CC       trace/beauty/arch_prctl.o
  CC       ui/browsers/scripts.o
  CC       tests/keep-tracking.o
  CC       trace/beauty/prctl.o
  CC       trace/beauty/renameat.o
  CC       ui/browsers/header.o
  CC       ui/browsers/res_sample.o
  CC       trace/beauty/sockaddr.o
  CC       tests/code-reading.o
  CC       util/evlist-hybrid.o
  CC       trace/beauty/socket.o
  CC       trace/beauty/statx.o
  CC       tests/sample-parsing.o
  CC       trace/beauty/sync_file_range.o
  CC       tests/parse-no-sample-id-all.o
  CC       tests/kmod-path.o
  CC       util/sideband_evlist.o
  CC       trace/beauty/tracepoints/x86_irq_vectors.o
  CC       trace/beauty/tracepoints/x86_msr.o
  CC       util/evsel.o
  CC       tests/thread-map.o
  CC       tests/llvm.o
  LD       trace/beauty/tracepoints/perf-in.o
  LD       trace/beauty/perf-in.o
  CC       util/evsel_fprintf.o
  CC       tests/bpf.o
  CC       tests/topology.o
  CC       tests/mem.o
  CC       tests/cpumap.o
  LD       ui/browsers/perf-in.o
  LD       ui/perf-in.o
  CC       tests/stat.o
  CC       tests/event_update.o
  CC       util/perf_event_attr_fprintf.o
  CC       util/evswitch.o
  CC       tests/event-times.o
  CC       util/find_bit.o
  CC       tests/expr.o
  CC       util/get_current_dir_name.o
  CC       util/kallsyms.o
  CC       tests/backward-ring-buffer.o
  CC       util/levenshtein.o
  CC       util/llvm-utils.o
  CC       tests/sdt.o
  CC       tests/is_printable_array.o
  CC       tests/bitmap.o
  CC       util/mmap.o
  CC       util/memswap.o
  CC       tests/perf-hooks.o
  BISON    util/parse-events-bison.c
  CC       tests/clang.o
  CC       tests/unit_number__scnprintf.o
  CC       util/parse-events-hybrid.o
  CC       util/perf_regs.o
  CC       tests/mem2node.o
  CC       util/path.o
  CC       util/print_binary.o
  CC       tests/maps.o
  CC       util/rlimit.o
  CC       tests/time-utils-test.o
  CC       util/argv_split.o
  CC       tests/genelf.o
  CC       util/rbtree.o
  CC       tests/api-io.o
  CC       util/libstring.o
  CC       tests/demangle-java-test.o
  CC       tests/demangle-ocaml-test.o
  CC       util/bitmap.o
  CC       util/hweight.o
  CC       tests/pfm.o
  CC       tests/parse-metric.o
  CC       tests/pe-file-parsing.o
  CC       tests/expand-cgroup.o
  CC       tests/perf-time-to-tsc.o
  CC       tests/dwarf-unwind.o
  CC       util/smt.o
  CC       util/strbuf.o
  CC       util/string.o
  CC       util/strlist.o
  CC       tests/llvm-src-base.o
  CC       tests/llvm-src-kbuild.o
  CC       util/strfilter.o
  CC       util/top.o
  CC       tests/llvm-src-prologue.o
  CC       util/usage.o
  CC       tests/llvm-src-relocation.o
  CC       util/dso.o
  CC       util/dsos.o
  CC       util/symbol.o
  CC       util/symbol_fprintf.o
  LD       tests/perf-in.o
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
  CC       util/comm.o
  CC       util/thread.o
  CC       util/thread_map.o
  CC       util/trace-event-parse.o
  CC       util/parse-events-bison.o
  BISON    util/pmu-bison.c
  CC       util/pmu-hybrid.o
  CC       util/trace-event-read.o
  CC       util/trace-event-info.o
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
  CC       util/iostat.o
  CC       util/stream.o
  CC       util/auxtrace.o
  CC       util/intel-pt-decoder/intel-pt-pkt-decoder.o
  GEN      util/intel-pt-decoder/inat-tables.c
  CC       util/arm-spe-decoder/arm-spe-pkt-decoder.o
  CC       util/intel-pt-decoder/intel-pt-log.o
  CC       util/arm-spe-decoder/arm-spe-decoder.o
  CC       util/scripting-engines/trace-event-perl.o
  CC       util/intel-pt-decoder/intel-pt-decoder.o
  CC       util/scripting-engines/trace-event-python.o
  LD       util/arm-spe-decoder/perf-in.o
  CC       util/intel-pt.o
  CC       util/intel-bts.o
  CC       util/arm-spe.o
  CC       util/s390-cpumsf.o
  CC       util/parse-branch-options.o
  CC       util/dump-insn.o
  CC       util/parse-regs-options.o
  CC       util/parse-sublevel-options.o
  CC       util/term.o
  CC       util/help-unknown-cmd.o
  LD       util/scripting-engines/perf-in.o
  CC       util/mem-events.o
  CC       util/vsprintf.o
  CC       util/units.o
  CC       util/time-utils.o
  BISON    util/expr-bison.c
  CC       util/branch.o
  CC       util/mem2node.o
  CC       util/clockid.o
  CC       util/intel-pt-decoder/intel-pt-insn-decoder.o
  CC       util/bpf-loader.o
  CC       util/bpf_map.o
  CC       util/bpf-prologue.o
  CC       util/symbol-elf.o
  CC       util/probe-file.o
  CC       util/probe-event.o
  CC       util/probe-finder.o
  LD       util/intel-pt-decoder/perf-in.o
  CC       util/dwarf-aux.o
  CC       util/dwarf-regs.o
  CC       util/unwind-libunwind-local.o
  CC       util/unwind-libunwind.o
  CC       util/data-convert-bt.o
  CC       util/data-convert-json.o
  CC       util/zlib.o
  CC       util/lzma.o
  CC       util/zstd.o
  CC       util/cap.o
  CC       util/demangle-ocaml.o
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
  CC       util/parse-events.o
  CC       util/parse-events-flex.o
  CC       util/pmu.o
  CC       util/pmu-flex.o
  CC       util/expr-flex.o
  CC       util/expr.o
  LD       util/perf-in.o
  LD       perf-in.o
  LINK     perf
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-71d7924b3e=
8acaca6a3b0fc3261170031ada3b70/tools/perf'
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D8027=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x00000000=
0000 (pc 0x55bc424bee4b bp 0x7ffd874c3670 sp 0x7ffd874c3500 T0)
=3D=3D8027=3D=3DThe signal is caused by a READ memory access.
=3D=3D8027=3D=3DHint: address points to the zero page.
    #0 0x55bc424bee4a in print_symbol_events util/parse-events.c:2945
    #1 0x55bc424bf82e in print_events util/parse-events.c:2994
    #2 0x55bc42177d42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x55bc423ee029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x55bc423ee7d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x55bc423eecf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x55bc423ef6d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7fbf13f2f09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x55bc42119999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D8027=3D=3DABORTING
Installing test event list
output file: ../../test_suite/test-primitives-scripts/test-event-list/event=
-list
Dump all  JSON file evens to output event list file
output file: ../../test_suite/test-primitives-scripts/test-event-list/pebs-=
event-list
Dump PEBS  JSON file evens to output event list file
output file: ../../test_suite/test-primitives-scripts/test-event-list/kerne=
l_config_file_list-for-hardware-cache-event
Dump config file hardware cache event to output file
output file: ../../test_suite/test-primitives-scripts/test-event-list/ht_le=
ak_test_rules
Dump ht_leak_event_relation  to output file
output file: ../../test_suite/test-primitives-scripts/test-event-list/kerne=
l-pmu-event-list
Dump kernel omu event to output file
output file: ../../test_suite/test-primitives-scripts/test-event-list/event=
-list-for-skid-check
Dump skid event file  to output file
output file: ../../test_suite/test-primitives-scripts/test-event-list/offco=
re-event-list
Dump all  JSON file evens to output event list file
event file: Skylake_matrix_V25.json
output file: ../../test_suite/test-primitives-scripts/test-event-list/uncor=
e-event-list
Dump uncore event file  to output file
output file: ../../test_suite/test-primitives-scripts/test-event-list/rapl-=
event-list
output file: ../../test_suite/test-primitives-scripts/test-event-list/../.t=
est_case_config_for_host
Dump config file for host to output file
output file: ../../test_suite/test-primitives-scripts/test-event-list/../.t=
est_case_config_for_guest
Dump config file for guest to output file
output file: ../../test_suite/test-primitives-scripts/test-event-list/core_=
event_relation
output file: ../../test_suite/test-primitives-scripts/uncore_test/uncore_ev=
ent_relation
output file: ../../test_suite/test-primitives-scripts/calibrator_uncore_test
output file: ../../test_suite/test-primitives-scripts/test-event-list/topdo=
wn-event-list
output file: ../../test_suite/test-primitives-scripts/test-event-list/event=
-list-for-pebs-test
Dump pebs_test file  to output file

 usage: perf_test [--version] [--help] COMMAND [ARGS]

The perf test cases include:
	count		test primitive for counting
	sample		test primitive for sampling

 See 'perf_test TESTCASE --help' for more information on a specific command.

perf_test sanity case is pass!
rm -f *.o \
tchain_edit
gcc -Wall -c tchain_edit.c
gcc -static tchain_edit.o -o tchain_edit
cp ../../kernels/cache_kernels/code_rw/code_rw ./topdown_test/kernels
cp ../../kernels/cache_kernels/br_instr/br_instr ./calibrator_test/kernels
cp ../../kernels/cache_kernels/dtlb/dtlb ./calibrator_test/kernels
cp ../../kernels/cache_kernels/dtlb/dtlb ./topdown_test/kernels
cp ../../kernels/cache_kernels/hittest/hittest ./calibrator_test/kernels
cp ../../kernels/rdpmc_kernels/*.so ./rdpmc_test/
cp ../../kernels/rdpmc_kernels/rdpmc_reset ./rdpmc_test/
cp ../../kernels/rdpmc_kernels/rdpmc_dtlb ./rdpmc_test/
cp ../../kernels/tl-micros/mispredict1 ./topdown_test/kernels
cp ../../kernels/pebs_kernel/tchain_edit_zero ./pebs_test/
cp ../../kernels/cache_kernels/dtlb/dtlb ./pebs_test/
cd ../../kernels/tsx_kernels && cp capacity cpuid hle-abort-forever long-tx=
 ntload ntload-event-relation rtm-abort rtm-loop string2 hle-loop hle-in-rt=
m rtm-in-hle hle-rtm-event-relation vzeroupper vzeroupper-event-relation rt=
m-nest rtm-nest-event-relation abort-wc conflict-rtm conflict-hle conflict-=
event-relation rtm-abort-watchdog hle-abort-watchdog abort-watchdog-event-r=
elation hle-buffer-full hle-buffer-mismatch hle-buffer-event-relation hle-c=
ommit-nest hle-commit hle-flush rtm-flush hle-store-to-lock hle-unsupported=
-align interrupt-hle interrupt-rtm texception-hle texception-rtm texception=
-event-relation rtm-misc1-flowmarker rtm-string rtm-write-capacity rtm-writ=
e-capacity-event-relation hle-selfmod rtm-selfmod selfmode-event-relation h=
le-read-capacity rtm-read-capacity read-capacity-event-relation ../../test_=
suite/test-primitives-scripts/tsx_test
cp ../../kernels/breakpoint_kernels/bp_test ./breakpoint_test/
cp ../../kernels/breakpoint_kernels/dtlb ./breakpoint_test/
cp ../../kernels/mem_addr_kernels/*.so ./mem_addr_profile_test/
cp ../../kernels/mem_addr_kernels/perf_mem_mix ./mem_addr_profile_test/
cp ../../kernels/skid_test_kernel/dtlb* ../../kernels/skid_test_kernel/tria=
d_loop* ./skid_test/
cp ../../kernels/lbr_kernel/tchain_edit.c ./lbr_test/
cp ../../kernels/lbr_kernel/tchain_edit ./lbr_test/
cp ../../kernels/mlc/mlc_3.1a ./calibrator_uncore_test/kernels/mlc
cp ../../test_primitives/perf_test .
cp ../../kernels/commands/triad_loop .
cp ../../test_primitives/tar_log.sh .
cp ../../test_primitives/event-relation-list ./common_event-relation-list
cp ../../kernels/cache_kernels/itlb/itlb ./topdown_test/kernels
cp ../../kernels/cache_kernels/icmiss/icmiss ./topdown_test/kernels
2021-05-20 08:55:53 ./breakpoint_test/run.sh
Thu May 20 08:55:53 UTC 2021
0 test cases pass for breakpoint_checking test. 0 test cases fail for break=
point_checking test.
2021-05-20 08:55:53 ./calibrator_test/run.sh
SKIP for calibrator_test test
2021-05-20 08:55:53 ./calibrator_uncore_test/run.sh
SKIP for calibrator_uncore_test test
2021-05-20 08:55:53 ./event_list_test/run.sh
Thu May 20 09:08:37 UTC 2021
632 test cases pass for perf_event_list_test test. 0 test cases fail for pe=
rf_event_list_test test.
Test Case perf_event_list_count_branch-instructions PASS!
Test Case perf_event_list_count_branch-misses PASS!
Test Case perf_event_list_count_bus-cycles PASS!
Test Case perf_event_list_count_cache-misses PASS!
Test Case perf_event_list_count_cache-references PASS!
Test Case perf_event_list_count_cpu-cycles PASS!
Test Case perf_event_list_count_cycles-ct PASS!
Test Case perf_event_list_count_cycles-t PASS!
Test Case perf_event_list_count_el-abort PASS!
Test Case perf_event_list_count_el-capacity PASS!
Test Case perf_event_list_count_el-commit PASS!
Test Case perf_event_list_count_el-conflict PASS!
Test Case perf_event_list_count_el-start PASS!
Test Case perf_event_list_count_instructions PASS!
Test Case perf_event_list_count_mem-loads PASS!
Test Case perf_event_list_count_mem-stores PASS!
Test Case perf_event_list_count_ref-cycles PASS!
Test Case perf_event_list_count_tx-abort PASS!
Test Case perf_event_list_count_tx-capacity PASS!
Test Case perf_event_list_count_tx-commit PASS!
Test Case perf_event_list_count_tx-conflict PASS!
Test Case perf_event_list_count_tx-start PASS!
Test Case perf_event_list_count_cstate_core/c3-residency/ PASS!
Test Case perf_event_list_count_cstate_core/c6-residency/ PASS!
Test Case perf_event_list_count_cstate_core/c7-residency/ PASS!
Test Case perf_event_list_count_cstate_pkg/c10-residency/ PASS!
Test Case perf_event_list_count_cstate_pkg/c2-residency/ PASS!
Test Case perf_event_list_count_cstate_pkg/c3-residency/ PASS!
Test Case perf_event_list_count_cstate_pkg/c6-residency/ PASS!
Test Case perf_event_list_count_cstate_pkg/c7-residency/ PASS!
Test Case perf_event_list_count_cstate_pkg/c8-residency/ PASS!
Test Case perf_event_list_count_cstate_pkg/c9-residency/ PASS!
Test Case perf_event_list_count_i915/actual-frequency/ PASS!
Test Case perf_event_list_count_i915/bcs0-busy/ PASS!
Test Case perf_event_list_count_i915/bcs0-sema/ PASS!
Test Case perf_event_list_count_i915/bcs0-wait/ PASS!
Test Case perf_event_list_count_i915/interrupts/ PASS!
Test Case perf_event_list_count_i915/rc6-residency/ PASS!
Test Case perf_event_list_count_i915/rcs0-busy/ PASS!
Test Case perf_event_list_count_i915/rcs0-sema/ PASS!
Test Case perf_event_list_count_i915/rcs0-wait/ PASS!
Test Case perf_event_list_count_i915/requested-frequency/ PASS!
Test Case perf_event_list_count_i915/software-gt-awake-time/ PASS!
Test Case perf_event_list_count_i915/vcs0-busy/ PASS!
Test Case perf_event_list_count_i915/vcs0-sema/ PASS!
Test Case perf_event_list_count_i915/vcs0-wait/ PASS!
Test Case perf_event_list_count_i915/vecs0-busy/ PASS!
Test Case perf_event_list_count_i915/vecs0-sema/ PASS!
Test Case perf_event_list_count_i915/vecs0-wait/ PASS!
Test Case perf_event_list_count_msr/aperf/ PASS!
Test Case perf_event_list_count_msr/cpu_thermal_margin/ PASS!
Test Case perf_event_list_count_msr/mperf/ PASS!
Test Case perf_event_list_count_msr/pperf/ PASS!
Test Case perf_event_list_count_msr/smi/ PASS!
Test Case perf_event_list_count_msr/tsc/ PASS!
Test Case perf_event_list_count_power/energy-cores/ PASS!
Test Case perf_event_list_count_power/energy-gpu/ PASS!
Test Case perf_event_list_count_power/energy-pkg/ PASS!
Test Case perf_event_list_count_power/energy-ram/ PASS!
Test Case perf_event_list_count_uncore_cbox_0/clockticks/ PASS!
Test Case perf_event_list_count_uncore_imc/data_reads/ PASS!
Test Case perf_event_list_count_uncore_imc/data_writes/ PASS!
Test Case perf_event_list_count_uncore_imc/gt_requests/ PASS!
Test Case perf_event_list_count_uncore_imc/ia_requests/ PASS!
Test Case perf_event_list_count_uncore_imc/io_requests/ PASS!
Test Case perf_event_list_count_l1d.replacement PASS!
Test Case perf_event_list_count_l1d_pend_miss.fb_full PASS!
Test Case perf_event_list_count_l1d_pend_miss.pending PASS!
Test Case perf_event_list_count_l1d_pend_miss.pending_cycles PASS!
Test Case perf_event_list_count_l1d_pend_miss.pending_cycles_any PASS!
Test Case perf_event_list_count_l2_lines_in.all PASS!
Test Case perf_event_list_count_l2_lines_out.non_silent PASS!
Test Case perf_event_list_count_l2_lines_out.silent PASS!
Test Case perf_event_list_count_l2_lines_out.useless_hwpf PASS!
Test Case perf_event_list_count_l2_lines_out.useless_pref PASS!
Test Case perf_event_list_count_l2_rqsts.all_code_rd PASS!
Test Case perf_event_list_count_l2_rqsts.all_demand_data_rd PASS!
Test Case perf_event_list_count_l2_rqsts.all_demand_miss PASS!
Test Case perf_event_list_count_l2_rqsts.all_demand_references PASS!
Test Case perf_event_list_count_l2_rqsts.all_pf PASS!
Test Case perf_event_list_count_l2_rqsts.all_rfo PASS!
Test Case perf_event_list_count_l2_rqsts.code_rd_hit PASS!
Test Case perf_event_list_count_l2_rqsts.code_rd_miss PASS!
Test Case perf_event_list_count_l2_rqsts.demand_data_rd_hit PASS!
Test Case perf_event_list_count_l2_rqsts.demand_data_rd_miss PASS!
Test Case perf_event_list_count_l2_rqsts.miss PASS!
Test Case perf_event_list_count_l2_rqsts.pf_hit PASS!
Test Case perf_event_list_count_l2_rqsts.pf_miss PASS!
Test Case perf_event_list_count_l2_rqsts.references PASS!
Test Case perf_event_list_count_l2_rqsts.rfo_hit PASS!
Test Case perf_event_list_count_l2_rqsts.rfo_miss PASS!
Test Case perf_event_list_count_l2_trans.l2_wb PASS!
Test Case perf_event_list_count_longest_lat_cache.miss PASS!
Test Case perf_event_list_count_longest_lat_cache.reference PASS!
Test Case perf_event_list_count_mem_inst_retired.all_loads PASS!
Test Case perf_event_list_count_mem_inst_retired.all_stores PASS!
Test Case perf_event_list_count_mem_inst_retired.lock_loads PASS!
Test Case perf_event_list_count_mem_inst_retired.split_loads PASS!
Test Case perf_event_list_count_mem_inst_retired.split_stores PASS!
Test Case perf_event_list_count_mem_inst_retired.stlb_miss_loads PASS!
Test Case perf_event_list_count_mem_inst_retired.stlb_miss_stores PASS!
Test Case perf_event_list_count_mem_load_l3_hit_retired.xsnp_hit PASS!
Test Case perf_event_list_count_mem_load_l3_hit_retired.xsnp_hitm PASS!
Test Case perf_event_list_count_mem_load_l3_hit_retired.xsnp_miss PASS!
Test Case perf_event_list_count_mem_load_l3_hit_retired.xsnp_none PASS!
Test Case perf_event_list_count_mem_load_misc_retired.uc PASS!
Test Case perf_event_list_count_mem_load_retired.fb_hit PASS!
Test Case perf_event_list_count_mem_load_retired.l1_hit PASS!
Test Case perf_event_list_count_mem_load_retired.l1_miss PASS!
Test Case perf_event_list_count_mem_load_retired.l2_hit PASS!
Test Case perf_event_list_count_mem_load_retired.l2_miss PASS!
Test Case perf_event_list_count_mem_load_retired.l3_hit PASS!
Test Case perf_event_list_count_mem_load_retired.l3_miss PASS!
Test Case perf_event_list_count_offcore_requests.all_data_rd PASS!
Test Case perf_event_list_count_offcore_requests.all_requests PASS!
Test Case perf_event_list_count_offcore_requests.demand_code_rd PASS!
Test Case perf_event_list_count_offcore_requests.demand_data_rd PASS!
Test Case perf_event_list_count_offcore_requests.demand_rfo PASS!
Test Case perf_event_list_count_offcore_requests_buffer.sq_full PASS!
Test Case perf_event_list_count_offcore_requests_outstanding.all_data_rd PA=
SS!
Test Case perf_event_list_count_offcore_requests_outstanding.cycles_with_da=
ta_rd PASS!
Test Case perf_event_list_count_offcore_requests_outstanding.cycles_with_de=
mand_code_rd PASS!
Test Case perf_event_list_count_offcore_requests_outstanding.cycles_with_de=
mand_data_rd PASS!
Test Case perf_event_list_count_offcore_requests_outstanding.cycles_with_de=
mand_rfo PASS!
Test Case perf_event_list_count_offcore_requests_outstanding.demand_code_rd=
 PASS!
Test Case perf_event_list_count_offcore_requests_outstanding.demand_data_rd=
 PASS!
Test Case perf_event_list_count_offcore_requests_outstanding.demand_data_rd=
_ge_6 PASS!
Test Case perf_event_list_count_offcore_requests_outstanding.demand_rfo PAS=
S!
Test Case perf_event_list_count_offcore_response PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.any_respons=
e PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit.any_=
snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit.snoo=
p_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit.snoo=
p_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit.snoo=
p_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit.snoo=
p_none PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit.snoo=
p_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit.spl_=
hit PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_e.an=
y_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_e.sn=
oop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_e.sn=
oop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_e.sn=
oop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_e.sn=
oop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_e.sn=
oop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_e.sp=
l_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_m.an=
y_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_m.sn=
oop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_m.sn=
oop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_m.sn=
oop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_m.sn=
oop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_m.sn=
oop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_m.sp=
l_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_s.an=
y_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_s.sn=
oop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_s.sn=
oop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_s.sn=
oop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_s.sn=
oop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_s.sn=
oop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_s.sp=
l_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l4_hit_loca=
l_l4.any_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l4_hit_loca=
l_l4.snoop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l4_hit_loca=
l_l4.snoop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l4_hit_loca=
l_l4.snoop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l4_hit_loca=
l_l4.snoop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l4_hit_loca=
l_l4.snoop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l4_hit_loca=
l_l4.spl_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.supplier_no=
ne.any_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.supplier_no=
ne.snoop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.supplier_no=
ne.snoop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.supplier_no=
ne.snoop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.supplier_no=
ne.snoop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.supplier_no=
ne.snoop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.supplier_no=
ne.spl_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.any_respons=
e PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit.any_=
snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit.snoo=
p_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit.snoo=
p_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit.snoo=
p_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit.snoo=
p_none PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit.snoo=
p_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit.spl_=
hit PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_e.an=
y_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_e.sn=
oop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_e.sn=
oop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_e.sn=
oop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_e.sn=
oop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_e.sn=
oop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_e.sp=
l_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_m.an=
y_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_m.sn=
oop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_m.sn=
oop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_m.sn=
oop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_m.sn=
oop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_m.sn=
oop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_m.sp=
l_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_s.an=
y_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_s.sn=
oop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_s.sn=
oop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_s.sn=
oop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_s.sn=
oop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_s.sn=
oop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_s.sp=
l_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l4_hit_loca=
l_l4.any_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l4_hit_loca=
l_l4.snoop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l4_hit_loca=
l_l4.snoop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l4_hit_loca=
l_l4.snoop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l4_hit_loca=
l_l4.snoop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l4_hit_loca=
l_l4.snoop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l4_hit_loca=
l_l4.spl_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.supplier_no=
ne.any_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.supplier_no=
ne.snoop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.supplier_no=
ne.snoop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.supplier_no=
ne.snoop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.supplier_no=
ne.snoop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.supplier_no=
ne.snoop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.supplier_no=
ne.spl_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.any_response PA=
SS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit.any_snoo=
p PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit.snoop_hi=
t_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit.snoop_hi=
tm PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit.snoop_mi=
ss PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit.snoop_no=
ne PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit.snoop_no=
t_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit.spl_hit =
PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_e.any_sn=
oop PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_e.snoop_=
hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_e.snoop_=
hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_e.snoop_=
miss PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_e.snoop_=
none PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_e.snoop_=
not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_e.spl_hi=
t PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_m.any_sn=
oop PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_m.snoop_=
hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_m.snoop_=
hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_m.snoop_=
miss PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_m.snoop_=
none PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_m.snoop_=
not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_m.spl_hi=
t PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_s.any_sn=
oop PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_s.snoop_=
hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_s.snoop_=
hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_s.snoop_=
miss PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_s.snoop_=
none PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_s.snoop_=
not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_s.spl_hi=
t PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l4_hit_local_l4=
=2Eany_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l4_hit_local_l4=
=2Esnoop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l4_hit_local_l4=
=2Esnoop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l4_hit_local_l4=
=2Esnoop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l4_hit_local_l4=
=2Esnoop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l4_hit_local_l4=
=2Esnoop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l4_hit_local_l4=
=2Espl_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.supplier_none.a=
ny_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.supplier_none.s=
noop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.supplier_none.s=
noop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.supplier_none.s=
noop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.supplier_none.s=
noop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.supplier_none.s=
noop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.supplier_none.s=
pl_hit PASS!
Test Case perf_event_list_count_offcore_response.other.any_response PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit.any_snoop PAS=
S!
Test Case perf_event_list_count_offcore_response.other.l3_hit.snoop_hit_no_=
fwd PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit.snoop_hitm PA=
SS!
Test Case perf_event_list_count_offcore_response.other.l3_hit.snoop_miss PA=
SS!
Test Case perf_event_list_count_offcore_response.other.l3_hit.snoop_none PA=
SS!
Test Case perf_event_list_count_offcore_response.other.l3_hit.snoop_not_nee=
ded PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit.spl_hit PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_e.any_snoop P=
ASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_e.snoop_hit_n=
o_fwd PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_e.snoop_hitm =
PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_e.snoop_miss =
PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_e.snoop_none =
PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_e.snoop_not_n=
eeded PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_e.spl_hit PAS=
S!
Test Case perf_event_list_count_offcore_response.other.l3_hit_m.any_snoop P=
ASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_m.snoop_hit_n=
o_fwd PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_m.snoop_hitm =
PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_m.snoop_miss =
PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_m.snoop_none =
PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_m.snoop_not_n=
eeded PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_m.spl_hit PAS=
S!
Test Case perf_event_list_count_offcore_response.other.l3_hit_s.any_snoop P=
ASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_s.snoop_hit_n=
o_fwd PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_s.snoop_hitm =
PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_s.snoop_miss =
PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_s.snoop_none =
PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_s.snoop_not_n=
eeded PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_s.spl_hit PAS=
S!
Test Case perf_event_list_count_offcore_response.other.l4_hit_local_l4.any_=
snoop PASS!
Test Case perf_event_list_count_offcore_response.other.l4_hit_local_l4.snoo=
p_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.other.l4_hit_local_l4.snoo=
p_hitm PASS!
Test Case perf_event_list_count_offcore_response.other.l4_hit_local_l4.snoo=
p_miss PASS!
Test Case perf_event_list_count_offcore_response.other.l4_hit_local_l4.snoo=
p_none PASS!
Test Case perf_event_list_count_offcore_response.other.l4_hit_local_l4.snoo=
p_not_needed PASS!
Test Case perf_event_list_count_offcore_response.other.l4_hit_local_l4.spl_=
hit PASS!
Test Case perf_event_list_count_offcore_response.other.supplier_none.any_sn=
oop PASS!
Test Case perf_event_list_count_offcore_response.other.supplier_none.snoop_=
hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.other.supplier_none.snoop_=
hitm PASS!
Test Case perf_event_list_count_offcore_response.other.supplier_none.snoop_=
miss PASS!
Test Case perf_event_list_count_offcore_response.other.supplier_none.snoop_=
none PASS!
Test Case perf_event_list_count_offcore_response.other.supplier_none.snoop_=
not_needed PASS!
Test Case perf_event_list_count_offcore_response.other.supplier_none.spl_hi=
t PASS!
Test Case perf_event_list_count_sq_misc.split_lock PASS!
Test Case perf_event_list_count_fp_arith_inst_retired.128b_packed_double PA=
SS!
Test Case perf_event_list_count_fp_arith_inst_retired.128b_packed_single PA=
SS!
Test Case perf_event_list_count_fp_arith_inst_retired.256b_packed_double PA=
SS!
Test Case perf_event_list_count_fp_arith_inst_retired.256b_packed_single PA=
SS!
Test Case perf_event_list_count_fp_arith_inst_retired.scalar_double PASS!
Test Case perf_event_list_count_fp_arith_inst_retired.scalar_single PASS!
Test Case perf_event_list_count_fp_assist.any PASS!
Test Case perf_event_list_count_baclears.any PASS!
Test Case perf_event_list_count_dsb2mite_switches.count PASS!
Test Case perf_event_list_count_dsb2mite_switches.penalty_cycles PASS!
Test Case perf_event_list_count_frontend_retired.dsb_miss PASS!
Test Case perf_event_list_count_frontend_retired.itlb_miss PASS!
Test Case perf_event_list_count_frontend_retired.l1i_miss PASS!
Test Case perf_event_list_count_frontend_retired.l2_miss PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_1 PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_128 PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_16 PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_2 PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_256 PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_2_bubbles_ge_1 =
PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_2_bubbles_ge_2 =
PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_2_bubbles_ge_3 =
PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_32 PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_4 PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_512 PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_64 PASS!
Test Case perf_event_list_count_frontend_retired.latency_ge_8 PASS!
Test Case perf_event_list_count_frontend_retired.stlb_miss PASS!
Test Case perf_event_list_count_icache_16b.ifdata_stall PASS!
Test Case perf_event_list_count_icache_64b.iftag_hit PASS!
Test Case perf_event_list_count_icache_64b.iftag_miss PASS!
Test Case perf_event_list_count_icache_64b.iftag_stall PASS!
Test Case perf_event_list_count_idq.all_dsb_cycles_4_uops PASS!
Test Case perf_event_list_count_idq.all_dsb_cycles_any_uops PASS!
Test Case perf_event_list_count_idq.all_mite_cycles_4_uops PASS!
Test Case perf_event_list_count_idq.all_mite_cycles_any_uops PASS!
Test Case perf_event_list_count_idq.dsb_cycles PASS!
Test Case perf_event_list_count_idq.dsb_uops PASS!
Test Case perf_event_list_count_idq.mite_cycles PASS!
Test Case perf_event_list_count_idq.mite_uops PASS!
Test Case perf_event_list_count_idq.ms_cycles PASS!
Test Case perf_event_list_count_idq.ms_dsb_cycles PASS!
Test Case perf_event_list_count_idq.ms_mite_uops PASS!
Test Case perf_event_list_count_idq.ms_switches PASS!
Test Case perf_event_list_count_idq.ms_uops PASS!
Test Case perf_event_list_count_idq_uops_not_delivered.core PASS!
Test Case perf_event_list_count_idq_uops_not_delivered.cycles_0_uops_deliv.=
core PASS!
Test Case perf_event_list_count_idq_uops_not_delivered.cycles_fe_was_ok PAS=
S!
Test Case perf_event_list_count_idq_uops_not_delivered.cycles_le_1_uop_deli=
v.core PASS!
Test Case perf_event_list_count_idq_uops_not_delivered.cycles_le_2_uop_deli=
v.core PASS!
Test Case perf_event_list_count_idq_uops_not_delivered.cycles_le_3_uop_deli=
v.core PASS!
Test Case perf_event_list_count_cycle_activity.cycles_l3_miss PASS!
Test Case perf_event_list_count_cycle_activity.stalls_l3_miss PASS!
Test Case perf_event_list_count_hle_retired.aborted PASS!
Test Case perf_event_list_count_hle_retired.aborted_events PASS!
Test Case perf_event_list_count_hle_retired.aborted_mem PASS!
Test Case perf_event_list_count_hle_retired.aborted_memtype PASS!
Test Case perf_event_list_count_hle_retired.aborted_timer PASS!
Test Case perf_event_list_count_hle_retired.aborted_unfriendly PASS!
Test Case perf_event_list_count_hle_retired.commit PASS!
Test Case perf_event_list_count_hle_retired.start PASS!
Test Case perf_event_list_count_machine_clears.memory_ordering PASS!
Test Case perf_event_list_count_mem_trans_retired.load_latency_gt_128 PASS!
Test Case perf_event_list_count_mem_trans_retired.load_latency_gt_16 PASS!
Test Case perf_event_list_count_mem_trans_retired.load_latency_gt_256 PASS!
Test Case perf_event_list_count_mem_trans_retired.load_latency_gt_32 PASS!
Test Case perf_event_list_count_mem_trans_retired.load_latency_gt_4 PASS!
Test Case perf_event_list_count_mem_trans_retired.load_latency_gt_512 PASS!
Test Case perf_event_list_count_mem_trans_retired.load_latency_gt_64 PASS!
Test Case perf_event_list_count_mem_trans_retired.load_latency_gt_8 PASS!
Test Case perf_event_list_count_offcore_requests.l3_miss_demand_data_rd PAS=
S!
Test Case perf_event_list_count_offcore_requests_outstanding.cycles_with_l3=
_miss_demand_data_rd PASS!
Test Case perf_event_list_count_offcore_requests_outstanding.l3_miss_demand=
_data_rd PASS!
Test Case perf_event_list_count_offcore_requests_outstanding.l3_miss_demand=
_data_rd_ge_6 PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit.snoo=
p_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_e.sn=
oop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_m.sn=
oop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_hit_s.sn=
oop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss.any=
_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss.sno=
op_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss.sno=
op_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss.sno=
op_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss.sno=
op_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss.sno=
op_none PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss.sno=
op_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss.spl=
_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss_loc=
al_dram.any_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss_loc=
al_dram.snoop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss_loc=
al_dram.snoop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss_loc=
al_dram.snoop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss_loc=
al_dram.snoop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss_loc=
al_dram.snoop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss_loc=
al_dram.snoop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l3_miss_loc=
al_dram.spl_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.l4_hit_loca=
l_l4.snoop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_code_rd.supplier_no=
ne.snoop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit.snoo=
p_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_e.sn=
oop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_m.sn=
oop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_hit_s.sn=
oop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss.any=
_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss.sno=
op_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss.sno=
op_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss.sno=
op_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss.sno=
op_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss.sno=
op_none PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss.sno=
op_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss.spl=
_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss_loc=
al_dram.any_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss_loc=
al_dram.snoop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss_loc=
al_dram.snoop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss_loc=
al_dram.snoop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss_loc=
al_dram.snoop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss_loc=
al_dram.snoop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss_loc=
al_dram.snoop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l3_miss_loc=
al_dram.spl_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.l4_hit_loca=
l_l4.snoop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_data_rd.supplier_no=
ne.snoop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit.snoop_no=
n_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_e.snoop_=
non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_m.snoop_=
non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_hit_s.snoop_=
non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss.any_sno=
op PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss.snoop_h=
it_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss.snoop_h=
itm PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss.snoop_m=
iss PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss.snoop_n=
on_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss.snoop_n=
one PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss.snoop_n=
ot_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss.spl_hit=
 PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss_local_d=
ram.any_snoop PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss_local_d=
ram.snoop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss_local_d=
ram.snoop_hitm PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss_local_d=
ram.snoop_miss PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss_local_d=
ram.snoop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss_local_d=
ram.snoop_none PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss_local_d=
ram.snoop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l3_miss_local_d=
ram.spl_hit PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.l4_hit_local_l4=
=2Esnoop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.demand_rfo.supplier_none.s=
noop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit.snoop_non_dra=
m PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_e.snoop_non_d=
ram PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_m.snoop_non_d=
ram PASS!
Test Case perf_event_list_count_offcore_response.other.l3_hit_s.snoop_non_d=
ram PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss.any_snoop PA=
SS!
Test Case perf_event_list_count_offcore_response.other.l3_miss.snoop_hit_no=
_fwd PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss.snoop_hitm P=
ASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss.snoop_miss P=
ASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss.snoop_non_dr=
am PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss.snoop_none P=
ASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss.snoop_not_ne=
eded PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss.spl_hit PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss_local_dram.a=
ny_snoop PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss_local_dram.s=
noop_hit_no_fwd PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss_local_dram.s=
noop_hitm PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss_local_dram.s=
noop_miss PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss_local_dram.s=
noop_non_dram PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss_local_dram.s=
noop_none PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss_local_dram.s=
noop_not_needed PASS!
Test Case perf_event_list_count_offcore_response.other.l3_miss_local_dram.s=
pl_hit PASS!
Test Case perf_event_list_count_offcore_response.other.l4_hit_local_l4.snoo=
p_non_dram PASS!
Test Case perf_event_list_count_offcore_response.other.supplier_none.snoop_=
non_dram PASS!
Test Case perf_event_list_count_rtm_retired.aborted PASS!
Test Case perf_event_list_count_rtm_retired.aborted_events PASS!
Test Case perf_event_list_count_rtm_retired.aborted_mem PASS!
Test Case perf_event_list_count_rtm_retired.aborted_memtype PASS!
Test Case perf_event_list_count_rtm_retired.aborted_timer PASS!
Test Case perf_event_list_count_rtm_retired.aborted_unfriendly PASS!
Test Case perf_event_list_count_rtm_retired.commit PASS!
Test Case perf_event_list_count_rtm_retired.start PASS!
Test Case perf_event_list_count_tx_exec.misc1 PASS!
Test Case perf_event_list_count_tx_exec.misc2 PASS!
Test Case perf_event_list_count_tx_exec.misc3 PASS!
Test Case perf_event_list_count_tx_exec.misc4 PASS!
Test Case perf_event_list_count_tx_exec.misc5 PASS!
Test Case perf_event_list_count_tx_mem.abort_capacity PASS!
Test Case perf_event_list_count_tx_mem.abort_conflict PASS!
Test Case perf_event_list_count_tx_mem.abort_hle_elision_buffer_mismatch PA=
SS!
Test Case perf_event_list_count_tx_mem.abort_hle_elision_buffer_not_empty P=
ASS!
Test Case perf_event_list_count_tx_mem.abort_hle_elision_buffer_unsupported=
_alignment PASS!
Test Case perf_event_list_count_tx_mem.abort_hle_store_to_elided_lock PASS!
Test Case perf_event_list_count_tx_mem.hle_elision_buffer_full PASS!
Test Case perf_event_list_count_hw_interrupts.received PASS!
Test Case perf_event_list_count_memory_disambiguation.history_reset PASS!
Test Case perf_event_list_count_sw_prefetch_access.nta PASS!
Test Case perf_event_list_count_sw_prefetch_access.prefetchw PASS!
Test Case perf_event_list_count_sw_prefetch_access.t0 PASS!
Test Case perf_event_list_count_sw_prefetch_access.t1_t2 PASS!
Test Case perf_event_list_count_arith.divider_active PASS!
Test Case perf_event_list_count_br_inst_retired.all_branches PASS!
Test Case perf_event_list_count_br_inst_retired.all_branches_pebs PASS!
Test Case perf_event_list_count_br_inst_retired.cond_ntaken PASS!
Test Case perf_event_list_count_br_inst_retired.conditional PASS!
Test Case perf_event_list_count_br_inst_retired.far_branch PASS!
Test Case perf_event_list_count_br_inst_retired.near_call PASS!
Test Case perf_event_list_count_br_inst_retired.near_return PASS!
Test Case perf_event_list_count_br_inst_retired.near_taken PASS!
Test Case perf_event_list_count_br_inst_retired.not_taken PASS!
Test Case perf_event_list_count_br_misp_retired.all_branches PASS!
Test Case perf_event_list_count_br_misp_retired.all_branches_pebs PASS!
Test Case perf_event_list_count_br_misp_retired.conditional PASS!
Test Case perf_event_list_count_br_misp_retired.near_call PASS!
Test Case perf_event_list_count_br_misp_retired.near_taken PASS!
Test Case perf_event_list_count_cpu_clk_thread_unhalted.one_thread_active P=
ASS!
Test Case perf_event_list_count_cpu_clk_thread_unhalted.ref_xclk PASS!
Test Case perf_event_list_count_cpu_clk_thread_unhalted.ref_xclk_any PASS!
Test Case perf_event_list_count_cpu_clk_unhalted.one_thread_active PASS!
Test Case perf_event_list_count_cpu_clk_unhalted.ref_tsc PASS!
Test Case perf_event_list_count_cpu_clk_unhalted.ref_xclk PASS!
Test Case perf_event_list_count_cpu_clk_unhalted.ref_xclk_any PASS!
Test Case perf_event_list_count_cpu_clk_unhalted.ring0_trans PASS!
Test Case perf_event_list_count_cpu_clk_unhalted.thread PASS!
Test Case perf_event_list_count_cpu_clk_unhalted.thread_any PASS!
Test Case perf_event_list_count_cpu_clk_unhalted.thread_p PASS!
Test Case perf_event_list_count_cpu_clk_unhalted.thread_p_any PASS!
Test Case perf_event_list_count_cycle_activity.cycles_l1d_miss PASS!
Test Case perf_event_list_count_cycle_activity.cycles_l2_miss PASS!
Test Case perf_event_list_count_cycle_activity.cycles_mem_any PASS!
Test Case perf_event_list_count_cycle_activity.stalls_l1d_miss PASS!
Test Case perf_event_list_count_cycle_activity.stalls_l2_miss PASS!
Test Case perf_event_list_count_cycle_activity.stalls_mem_any PASS!
Test Case perf_event_list_count_cycle_activity.stalls_total PASS!
Test Case perf_event_list_count_exe_activity.1_ports_util PASS!
Test Case perf_event_list_count_exe_activity.2_ports_util PASS!
Test Case perf_event_list_count_exe_activity.3_ports_util PASS!
Test Case perf_event_list_count_exe_activity.4_ports_util PASS!
Test Case perf_event_list_count_exe_activity.bound_on_stores PASS!
Test Case perf_event_list_count_exe_activity.exe_bound_0_ports PASS!
Test Case perf_event_list_count_ild_stall.lcp PASS!
Test Case perf_event_list_count_inst_retired.any PASS!
Test Case perf_event_list_count_inst_retired.any_p PASS!
Test Case perf_event_list_count_inst_retired.prec_dist PASS!
Test Case perf_event_list_count_inst_retired.total_cycles_ps PASS!
Test Case perf_event_list_count_int_misc.clear_resteer_cycles PASS!
Test Case perf_event_list_count_int_misc.recovery_cycles PASS!
Test Case perf_event_list_count_int_misc.recovery_cycles_any PASS!
Test Case perf_event_list_count_ld_blocks.no_sr PASS!
Test Case perf_event_list_count_ld_blocks.store_forward PASS!
Test Case perf_event_list_count_ld_blocks_partial.address_alias PASS!
Test Case perf_event_list_count_load_hit_pre.sw_pf PASS!
Test Case perf_event_list_count_lsd.cycles_4_uops PASS!
Test Case perf_event_list_count_lsd.cycles_active PASS!
Test Case perf_event_list_count_lsd.uops PASS!
Test Case perf_event_list_count_machine_clears.count PASS!
Test Case perf_event_list_count_machine_clears.smc PASS!
Test Case perf_event_list_count_other_assists.any PASS!
Test Case perf_event_list_count_partial_rat_stalls.scoreboard PASS!
Test Case perf_event_list_count_resource_stalls.any PASS!
Test Case perf_event_list_count_resource_stalls.sb PASS!
Test Case perf_event_list_count_rob_misc_events.lbr_inserts PASS!
Test Case perf_event_list_count_rob_misc_events.pause_inst PASS!
Test Case perf_event_list_count_rs_events.empty_cycles PASS!
Test Case perf_event_list_count_rs_events.empty_end PASS!
Test Case perf_event_list_count_uops_dispatched_port.port_0 PASS!
Test Case perf_event_list_count_uops_dispatched_port.port_1 PASS!
Test Case perf_event_list_count_uops_dispatched_port.port_2 PASS!
Test Case perf_event_list_count_uops_dispatched_port.port_3 PASS!
Test Case perf_event_list_count_uops_dispatched_port.port_4 PASS!
Test Case perf_event_list_count_uops_dispatched_port.port_5 PASS!
Test Case perf_event_list_count_uops_dispatched_port.port_6 PASS!
Test Case perf_event_list_count_uops_dispatched_port.port_7 PASS!
Test Case perf_event_list_count_uops_executed.core PASS!
Test Case perf_event_list_count_uops_executed.core_cycles_ge_1 PASS!
Test Case perf_event_list_count_uops_executed.core_cycles_ge_2 PASS!
Test Case perf_event_list_count_uops_executed.core_cycles_ge_3 PASS!
Test Case perf_event_list_count_uops_executed.core_cycles_ge_4 PASS!
Test Case perf_event_list_count_uops_executed.core_cycles_none PASS!
Test Case perf_event_list_count_uops_executed.cycles_ge_1_uop_exec PASS!
Test Case perf_event_list_count_uops_executed.cycles_ge_2_uops_exec PASS!
Test Case perf_event_list_count_uops_executed.cycles_ge_3_uops_exec PASS!
Test Case perf_event_list_count_uops_executed.cycles_ge_4_uops_exec PASS!
Test Case perf_event_list_count_uops_executed.stall_cycles PASS!
Test Case perf_event_list_count_uops_executed.thread PASS!
Test Case perf_event_list_count_uops_executed.x87 PASS!
Test Case perf_event_list_count_uops_issued.any PASS!
Test Case perf_event_list_count_uops_issued.slow_lea PASS!
Test Case perf_event_list_count_uops_issued.stall_cycles PASS!
Test Case perf_event_list_count_uops_issued.vector_width_mismatch PASS!
Test Case perf_event_list_count_uops_retired.macro_fused PASS!
Test Case perf_event_list_count_uops_retired.retire_slots PASS!
Test Case perf_event_list_count_uops_retired.stall_cycles PASS!
Test Case perf_event_list_count_uops_retired.total_cycles PASS!
Test Case perf_event_list_count_unc_arb_coh_trk_requests.all PASS!
Test Case perf_event_list_count_unc_arb_trk_occupancy.all PASS!
Test Case perf_event_list_count_unc_arb_trk_occupancy.cycles_with_any_reque=
st PASS!
Test Case perf_event_list_count_unc_arb_trk_requests.all PASS!
Test Case perf_event_list_count_unc_arb_trk_requests.drd_direct PASS!
Test Case perf_event_list_count_unc_arb_trk_requests.writes PASS!
Test Case perf_event_list_count_unc_cbo_cache_lookup.any_es PASS!
Test Case perf_event_list_count_unc_cbo_cache_lookup.any_i PASS!
Test Case perf_event_list_count_unc_cbo_cache_lookup.any_m PASS!
Test Case perf_event_list_count_unc_cbo_cache_lookup.any_mesi PASS!
Test Case perf_event_list_count_unc_cbo_cache_lookup.read_es PASS!
Test Case perf_event_list_count_unc_cbo_cache_lookup.read_i PASS!
Test Case perf_event_list_count_unc_cbo_cache_lookup.read_mesi PASS!
Test Case perf_event_list_count_unc_cbo_cache_lookup.write_es PASS!
Test Case perf_event_list_count_unc_cbo_cache_lookup.write_m PASS!
Test Case perf_event_list_count_unc_cbo_cache_lookup.write_mesi PASS!
Test Case perf_event_list_count_unc_cbo_xsnp_response.hit_xcore PASS!
Test Case perf_event_list_count_unc_cbo_xsnp_response.hitm_xcore PASS!
Test Case perf_event_list_count_unc_cbo_xsnp_response.miss_eviction PASS!
Test Case perf_event_list_count_unc_cbo_xsnp_response.miss_xcore PASS!
Test Case perf_event_list_count_dtlb_load_misses.miss_causes_a_walk PASS!
Test Case perf_event_list_count_dtlb_load_misses.stlb_hit PASS!
Test Case perf_event_list_count_dtlb_load_misses.walk_active PASS!
Test Case perf_event_list_count_dtlb_load_misses.walk_completed PASS!
Test Case perf_event_list_count_dtlb_load_misses.walk_completed_1g PASS!
Test Case perf_event_list_count_dtlb_load_misses.walk_completed_2m_4m PASS!
Test Case perf_event_list_count_dtlb_load_misses.walk_completed_4k PASS!
Test Case perf_event_list_count_dtlb_load_misses.walk_pending PASS!
Test Case perf_event_list_count_dtlb_store_misses.miss_causes_a_walk PASS!
Test Case perf_event_list_count_dtlb_store_misses.stlb_hit PASS!
Test Case perf_event_list_count_dtlb_store_misses.walk_active PASS!
Test Case perf_event_list_count_dtlb_store_misses.walk_completed PASS!
Test Case perf_event_list_count_dtlb_store_misses.walk_completed_1g PASS!
Test Case perf_event_list_count_dtlb_store_misses.walk_completed_2m_4m PASS!
Test Case perf_event_list_count_dtlb_store_misses.walk_completed_4k PASS!
Test Case perf_event_list_count_dtlb_store_misses.walk_pending PASS!
Test Case perf_event_list_count_ept.walk_pending PASS!
Test Case perf_event_list_count_itlb.itlb_flush PASS!
Test Case perf_event_list_count_itlb_misses.miss_causes_a_walk PASS!
Test Case perf_event_list_count_itlb_misses.stlb_hit PASS!
Test Case perf_event_list_count_itlb_misses.walk_active PASS!
Test Case perf_event_list_count_itlb_misses.walk_completed PASS!
Test Case perf_event_list_count_itlb_misses.walk_completed_1g PASS!
Test Case perf_event_list_count_itlb_misses.walk_completed_2m_4m PASS!
Test Case perf_event_list_count_itlb_misses.walk_completed_4k PASS!
Test Case perf_event_list_count_itlb_misses.walk_pending PASS!
Test Case perf_event_list_count_tlb_flush.dtlb_thread PASS!
Test Case perf_event_list_count_tlb_flush.stlb_any PASS!
2021-05-20 09:08:39 ./events_relation_test/run.sh
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31716=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x55d91e51ee4b bp 0x7fffcb59c180 sp 0x7fffcb59c010 T0)
=3D=3D31716=3D=3DThe signal is caused by a READ memory access.
=3D=3D31716=3D=3DHint: address points to the zero page.
    #0 0x55d91e51ee4a in print_symbol_events util/parse-events.c:2945
    #1 0x55d91e51f82e in print_events util/parse-events.c:2994
    #2 0x55d91e1d7d42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x55d91e44e029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x55d91e44e7d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x55d91e44ecf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x55d91e44f6d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f7649d2209a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x55d91e179999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31716=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31719=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x561c83441e4b bp 0x7ffd689d33a0 sp 0x7ffd689d3230 T0)
=3D=3D31719=3D=3DThe signal is caused by a READ memory access.
=3D=3D31719=3D=3DHint: address points to the zero page.
    #0 0x561c83441e4a in print_symbol_events util/parse-events.c:2945
    #1 0x561c8344282e in print_events util/parse-events.c:2994
    #2 0x561c830fad42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x561c83371029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x561c833717d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x561c83371cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x561c833726d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f465cdae09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x561c8309c999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31719=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31722=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x557ef65c6e4b bp 0x7ffd5c093f30 sp 0x7ffd5c093dc0 T0)
=3D=3D31722=3D=3DThe signal is caused by a READ memory access.
=3D=3D31722=3D=3DHint: address points to the zero page.
    #0 0x557ef65c6e4a in print_symbol_events util/parse-events.c:2945
    #1 0x557ef65c782e in print_events util/parse-events.c:2994
    #2 0x557ef627fd42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x557ef64f6029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x557ef64f67d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x557ef64f6cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x557ef64f76d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f577db5009a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x557ef6221999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31722=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31725=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x55989846ee4b bp 0x7fff66e534e0 sp 0x7fff66e53370 T0)
=3D=3D31725=3D=3DThe signal is caused by a READ memory access.
=3D=3D31725=3D=3DHint: address points to the zero page.
    #0 0x55989846ee4a in print_symbol_events util/parse-events.c:2945
    #1 0x55989846f82e in print_events util/parse-events.c:2994
    #2 0x559898127d42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x55989839e029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x55989839e7d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x55989839ecf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x55989839f6d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7fb940c6409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x5598980c9999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31725=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31728=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x55f09f1ebe4b bp 0x7ffe456ba9d0 sp 0x7ffe456ba860 T0)
=3D=3D31728=3D=3DThe signal is caused by a READ memory access.
=3D=3D31728=3D=3DHint: address points to the zero page.
    #0 0x55f09f1ebe4a in print_symbol_events util/parse-events.c:2945
    #1 0x55f09f1ec82e in print_events util/parse-events.c:2994
    #2 0x55f09eea4d42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x55f09f11b029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x55f09f11b7d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x55f09f11bcf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x55f09f11c6d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f7ec568809a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x55f09ee46999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31728=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31731=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x5641a2371e4b bp 0x7ffc78d00da0 sp 0x7ffc78d00c30 T0)
=3D=3D31731=3D=3DThe signal is caused by a READ memory access.
=3D=3D31731=3D=3DHint: address points to the zero page.
    #0 0x5641a2371e4a in print_symbol_events util/parse-events.c:2945
    #1 0x5641a237282e in print_events util/parse-events.c:2994
    #2 0x5641a202ad42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x5641a22a1029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x5641a22a17d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x5641a22a1cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x5641a22a26d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f35344e809a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x5641a1fcc999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31731=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31734=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x558dcf194e4b bp 0x7ffdd414f060 sp 0x7ffdd414eef0 T0)
=3D=3D31734=3D=3DThe signal is caused by a READ memory access.
=3D=3D31734=3D=3DHint: address points to the zero page.
    #0 0x558dcf194e4a in print_symbol_events util/parse-events.c:2945
    #1 0x558dcf19582e in print_events util/parse-events.c:2994
    #2 0x558dcee4dd42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x558dcf0c4029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x558dcf0c47d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x558dcf0c4cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x558dcf0c56d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f463592309a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x558dcedef999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31734=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31737=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x55a67dd24e4b bp 0x7fffff062910 sp 0x7fffff0627a0 T0)
=3D=3D31737=3D=3DThe signal is caused by a READ memory access.
=3D=3D31737=3D=3DHint: address points to the zero page.
    #0 0x55a67dd24e4a in print_symbol_events util/parse-events.c:2945
    #1 0x55a67dd2582e in print_events util/parse-events.c:2994
    #2 0x55a67d9ddd42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x55a67dc54029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x55a67dc547d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x55a67dc54cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x55a67dc556d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f06e9bc809a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x55a67d97f999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31737=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31740=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x564dc3772e4b bp 0x7fffd2ec33d0 sp 0x7fffd2ec3260 T0)
=3D=3D31740=3D=3DThe signal is caused by a READ memory access.
=3D=3D31740=3D=3DHint: address points to the zero page.
    #0 0x564dc3772e4a in print_symbol_events util/parse-events.c:2945
    #1 0x564dc377382e in print_events util/parse-events.c:2994
    #2 0x564dc342bd42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x564dc36a2029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x564dc36a27d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x564dc36a2cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x564dc36a36d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7fb6c761409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x564dc33cd999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31740=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31743=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x5612b2ef7e4b bp 0x7fff51898480 sp 0x7fff51898310 T0)
=3D=3D31743=3D=3DThe signal is caused by a READ memory access.
=3D=3D31743=3D=3DHint: address points to the zero page.
    #0 0x5612b2ef7e4a in print_symbol_events util/parse-events.c:2945
    #1 0x5612b2ef882e in print_events util/parse-events.c:2994
    #2 0x5612b2bb0d42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x5612b2e27029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x5612b2e277d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x5612b2e27cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x5612b2e286d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f34617cf09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x5612b2b52999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31743=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31746=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x5615a0956e4b bp 0x7fffbdb85b00 sp 0x7fffbdb85990 T0)
=3D=3D31746=3D=3DThe signal is caused by a READ memory access.
=3D=3D31746=3D=3DHint: address points to the zero page.
    #0 0x5615a0956e4a in print_symbol_events util/parse-events.c:2945
    #1 0x5615a095782e in print_events util/parse-events.c:2994
    #2 0x5615a060fd42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x5615a0886029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x5615a08867d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x5615a0886cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x5615a08876d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7ff7ce17709a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x5615a05b1999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31746=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31749=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x55f0c2fb4e4b bp 0x7fffa5c49570 sp 0x7fffa5c49400 T0)
=3D=3D31749=3D=3DThe signal is caused by a READ memory access.
=3D=3D31749=3D=3DHint: address points to the zero page.
    #0 0x55f0c2fb4e4a in print_symbol_events util/parse-events.c:2945
    #1 0x55f0c2fb582e in print_events util/parse-events.c:2994
    #2 0x55f0c2c6dd42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x55f0c2ee4029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x55f0c2ee47d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x55f0c2ee4cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x55f0c2ee56d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f51da74309a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x55f0c2c0f999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31749=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31752=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x558a25a30e4b bp 0x7fff522f2970 sp 0x7fff522f2800 T0)
=3D=3D31752=3D=3DThe signal is caused by a READ memory access.
=3D=3D31752=3D=3DHint: address points to the zero page.
    #0 0x558a25a30e4a in print_symbol_events util/parse-events.c:2945
    #1 0x558a25a3182e in print_events util/parse-events.c:2994
    #2 0x558a256e9d42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x558a25960029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x558a259607d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x558a25960cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x558a259616d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f8e46c6009a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x558a2568b999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31752=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31755=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x5629de062e4b bp 0x7ffc2793da00 sp 0x7ffc2793d890 T0)
=3D=3D31755=3D=3DThe signal is caused by a READ memory access.
=3D=3D31755=3D=3DHint: address points to the zero page.
    #0 0x5629de062e4a in print_symbol_events util/parse-events.c:2945
    #1 0x5629de06382e in print_events util/parse-events.c:2994
    #2 0x5629ddd1bd42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x5629ddf92029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x5629ddf927d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x5629ddf92cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x5629ddf936d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f3c13ef009a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x5629ddcbd999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31755=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31761=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x55b18f01be4b bp 0x7ffc6a1b6c30 sp 0x7ffc6a1b6ac0 T0)
=3D=3D31761=3D=3DThe signal is caused by a READ memory access.
=3D=3D31761=3D=3DHint: address points to the zero page.
    #0 0x55b18f01be4a in print_symbol_events util/parse-events.c:2945
    #1 0x55b18f01c82e in print_events util/parse-events.c:2994
    #2 0x55b18ecd4d42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x55b18ef4b029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x55b18ef4b7d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x55b18ef4bcf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x55b18ef4c6d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7f112c20409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x55b18ec76999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31761=3D=3DABORTING
util/parse-events.c:2945:18: runtime error: load of null pointer of type 'c=
onst char'
AddressSanitizer:DEADLYSIGNAL
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31764=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x0000000=
00000 (pc 0x5560d8e8fe4b bp 0x7ffe0bb44fb0 sp 0x7ffe0bb44e40 T0)
=3D=3D31764=3D=3DThe signal is caused by a READ memory access.
=3D=3D31764=3D=3DHint: address points to the zero page.
    #0 0x5560d8e8fe4a in print_symbol_events util/parse-events.c:2945
    #1 0x5560d8e9082e in print_events util/parse-events.c:2994
    #2 0x5560d8b48d42 in cmd_list /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-list.c:60
    #3 0x5560d8dbf029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #4 0x5560d8dbf7d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #5 0x5560d8dbfcf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #6 0x5560d8dc06d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d79=
24b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #7 0x7fabbdea109a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6=
+0x2409a)
    #8 0x5560d8aea999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-71=
d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV util/parse-events.c:2945 in print_symbol_ev=
ents
=3D=3D31764=3D=3DABORTING
Thu May 20 09:08:40 UTC 2021
0 test cases pass for event_relation_checking test. 0 test cases fail for e=
vent_relation_checking test.
2021-05-20 09:08:40 ./freq_test/run.sh
util/cpumap.c:48:22: runtime error: member access within misaligned address=
 0x7fd4bb31103a for type 'struct perf_record_record_cpu_map', which require=
s 8 byte alignment
0x7fd4bb31103a: note: pointer points here
 20 00  01 00 01 00 08 00 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00=
 00 00  11 00 00 00 00 00
              ^=20
util/cpumap.c:48:33: runtime error: member access within misaligned address=
 0x7fd4bb31103a for type 'struct perf_record_record_cpu_map', which require=
s 8 byte alignment
0x7fd4bb31103a: note: pointer points here
 20 00  01 00 01 00 08 00 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00=
 00 00  11 00 00 00 00 00
              ^=20
util/cpumap.c:50:25: runtime error: member access within misaligned address=
 0x7fd4bb31103a for type 'struct perf_record_record_cpu_map', which require=
s 8 byte alignment
0x7fd4bb31103a: note: pointer points here
 20 00  01 00 01 00 08 00 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00=
 00 00  11 00 00 00 00 00
              ^=20
=2E./lib/bitmap.c:13:8: runtime error: load of misaligned address 0x7fd4bb3=
11042 for type 'const long unsigned int', which requires 8 byte alignment
0x7fd4bb311042: note: pointer points here
 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00 00 00  11 00 00 00 00 00=
 48 00  90 b4 00 c0 ff ff
              ^=20
util/cpumap.c:56:3: runtime error: member access within misaligned address =
0x7fd4bb31103a for type 'struct perf_record_record_cpu_map', which requires=
 8 byte alignment
0x7fd4bb31103a: note: pointer points here
 20 00  01 00 01 00 08 00 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00=
 00 00  11 00 00 00 00 00
              ^=20
=2E./lib/find_bit.c:91:11: runtime error: load of misaligned address 0x7fd4=
bb311042 for type 'const long unsigned int', which requires 8 byte alignment
0x7fd4bb311042: note: pointer points here
 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00 00 00  11 00 00 00 00 00=
 48 00  90 b4 00 c0 ff ff
              ^=20
=2E./lib/find_bit.c:92:11: runtime error: load of misaligned address 0x7fd4=
bb311042 for type 'const long unsigned int', which requires 8 byte alignment
0x7fd4bb311042: note: pointer points here
 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00 00 00  11 00 00 00 00 00=
 48 00  90 b4 00 c0 ff ff
              ^=20
util/cpumap.c:56:3: runtime error: member access within misaligned address =
0x7fd4bb31103a for type 'struct perf_record_record_cpu_map', which requires=
 8 byte alignment
0x7fd4bb31103a: note: pointer points here
 20 00  01 00 01 00 08 00 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00=
 00 00  11 00 00 00 00 00
              ^=20
=2E./lib/find_bit.c:41:6: runtime error: load of misaligned address 0x7fd4b=
b311042 for type 'const long unsigned int', which requires 8 byte alignment
0x7fd4bb311042: note: pointer points here
 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00 00 00  11 00 00 00 00 00=
 48 00  90 b4 00 c0 ff ff
              ^=20
util/bpf-event.c:57:7: runtime error: load of misaligned address 0x61500000=
18ae for type 'u64', which requires 8 byte alignment
0x6150000018ae: note: pointer points here
 5d 5b c9 c3 90 b4  00 c0 ff ff ff ff c6 00  00 00 7b e4 9e 39 34 a1  25 ba=
 be be be be be be  00 00
             ^=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31833=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 2736 byte(s) in 6 object(s) allocated from:
    #0 0x7fd4c04bf330 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/li=
basan.so.5+0xe9330)
    #1 0x555d2dc57b2f in process_bpf_prog_info util/header.c:2901
    #2 0x555d2dc5f604 in perf_file_section__process util/header.c:3651
    #3 0x555d2dc5d6dd in perf_header__process_sections util/header.c:3427
    #4 0x555d2dc61b80 in perf_session__read_header util/header.c:3886
    #5 0x555d2dcafc8c in perf_session__open util/session.c:109
    #6 0x555d2dcb0b91 in perf_session__new util/session.c:213
    #7 0x555d2d8c314b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #8 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 2208 byte(s) in 6 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dca5506 in map__new2 util/map.c:216
    #2 0x555d2dc88ba0 in machine__process_ksymbol_register util/machine.c:7=
78
    #3 0x555d2dc89abe in machine__process_ksymbol util/machine.c:844
    #4 0x555d2db60c0d in perf_event__process_ksymbol util/event.c:261
    #5 0x555d2dcc2ae5 in machines__deliver_event util/session.c:1547
    #6 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #7 0x555d2dcc5e7d in perf_session__process_event util/session.c:1803
    #8 0x555d2dccb69e in process_simple util/session.c:2267
    #9 0x555d2dccaefc in reader__process_events util/session.c:2233
    #10 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #11 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #12 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #13 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #14 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #15 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #16 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #17 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #18 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 736 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf720 in __interceptor_realloc (/usr/lib/x86_64-linux-gnu/l=
ibasan.so.5+0xe9720)
    #1 0x555d2dbf5b94 in strbuf_grow util/strbuf.c:64
    #2 0x555d2dbf600c in strbuf_add util/strbuf.c:86
    #3 0x555d2dd6c676 in strbuf_addstr util/strbuf.h:87
    #4 0x555d2dd8dd54 in add_key util/sort.c:3348
    #5 0x555d2dd8dfbe in add_sort_string util/sort.c:3361
    #6 0x555d2dd8e2e2 in sort_help util/sort.c:3387
    #7 0x555d2d8bdd35 in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1203
    #8 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 736 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf720 in __interceptor_realloc (/usr/lib/x86_64-linux-gnu/l=
ibasan.so.5+0xe9720)
    #1 0x555d2dbf5b94 in strbuf_grow util/strbuf.c:64
    #2 0x555d2dbf65ac in strbuf_addv util/strbuf.c:112
    #3 0x555d2dbf6a92 in strbuf_addf util/strbuf.c:134
    #4 0x555d2dd8ddd6 in add_key util/sort.c:3351
    #5 0x555d2dd8dfbe in add_sort_string util/sort.c:3361
    #6 0x555d2dd8e2e2 in sort_help util/sort.c:3387
    #7 0x555d2d8bdea9 in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1205
    #8 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 136 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf330 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/li=
basan.so.5+0xe9330)
    #1 0x555d2dbf2b2a in memdup ../lib/string.c:31
    #2 0x555d2dd838e5 in __hpp_dimension__alloc_hpp util/sort.c:2126
    #3 0x555d2dd8922a in __hpp_dimension__add_output util/sort.c:2761
    #4 0x555d2dd893c4 in hpp_dimension__add_output util/sort.c:2773
    #5 0x555d2e0445f4 in perf_hpp__init ui/hist.c:560
    #6 0x555d2dd8da6d in setup_sorting util/sort.c:3311
    #7 0x555d2d8c4d1f in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1535
    #8 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 129 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf720 in __interceptor_realloc (/usr/lib/x86_64-linux-gnu/l=
ibasan.so.5+0xe9720)
    #1 0x555d2dbf5b94 in strbuf_grow util/strbuf.c:64
    #2 0x555d2dbf559d in strbuf_init util/strbuf.c:25
    #3 0x555d2dc59090 in process_cpu_pmu_caps util/header.c:3022
    #4 0x555d2dc5f604 in perf_file_section__process util/header.c:3651
    #5 0x555d2dc5d6dd in perf_header__process_sections util/header.c:3427
    #6 0x555d2dc61b80 in perf_session__read_header util/header.c:3886
    #7 0x555d2dcafc8c in perf_session__open util/session.c:109
    #8 0x555d2dcb0b91 in perf_session__new util/session.c:213
    #9 0x555d2d8c314b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #10 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #11 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #12 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #13 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #14 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 64 byte(s) in 2 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dcd8e94 in nsinfo__copy util/namespaces.c:169
    #2 0x555d2dca4f7a in map__new util/map.c:168
    #3 0x555d2dc92e3d in machine__process_mmap2_event util/machine.c:1787
    #4 0x555d2db625a8 in perf_event__process_mmap2 util/event.c:368
    #5 0x555d2dcc1c75 in machines__deliver_event util/session.c:1507
    #6 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #7 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #8 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #9 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #10 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #11 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #12 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #13 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #14 0x555d2dccb69e in process_simple util/session.c:2267
    #15 0x555d2dccaefc in reader__process_events util/session.c:2233
    #16 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #17 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #18 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #19 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #20 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #21 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #22 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #23 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #24 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 24 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf720 in __interceptor_realloc (/usr/lib/x86_64-linux-gnu/l=
ibasan.so.5+0xe9720)
    #1 0x555d2dbf5b94 in strbuf_grow util/strbuf.c:64
    #2 0x555d2dbf600c in strbuf_add util/strbuf.c:86
    #3 0x555d2dc53311 in process_cpu_topology util/header.c:2470
    #4 0x555d2dc5f604 in perf_file_section__process util/header.c:3651
    #5 0x555d2dc5d6dd in perf_header__process_sections util/header.c:3427
    #6 0x555d2dc61b80 in perf_session__read_header util/header.c:3886
    #7 0x555d2dcafc8c in perf_session__open util/session.c:109
    #8 0x555d2dcb0b91 in perf_session__new util/session.c:213
    #9 0x555d2d8c314b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #10 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #11 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #12 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #13 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #14 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 8949742 byte(s) in 123484 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dc15e04 in symbol__new util/symbol.c:269
    #2 0x555d2dc19881 in map__process_kallsym_symbol util/symbol.c:710
    #3 0x555d2dbb0bb7 in kallsyms__parse ../lib/symbol/kallsyms.c:71
    #4 0x555d2dc1992c in dso__load_all_kallsyms util/symbol.c:729
    #5 0x555d2dc20acc in __dso__load_kallsyms util/symbol.c:1453
    #6 0x555d2dc20ffa in dso__load_kallsyms util/symbol.c:1476
    #7 0x555d2dc27724 in dso__load_kernel_sym util/symbol.c:2235
    #8 0x555d2dc24289 in dso__load util/symbol.c:1778
    #9 0x555d2dca67fb in map__load util/map.c:332
    #10 0x555d2db65569 in thread__find_map util/event.c:605
    #11 0x555d2db6642c in machine__resolve util/event.c:675
    #12 0x555d2d8b0b41 in process_sample_event /usr/src/perf_selftests-x86_=
64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-rep=
ort.c:273
    #13 0x555d2dcc1580 in evlist__deliver_sample util/session.c:1464
    #14 0x555d2dcc19de in machines__deliver_event util/session.c:1501
    #15 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #16 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #17 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #18 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #19 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #20 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #21 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #22 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #23 0x555d2dccb69e in process_simple util/session.c:2267
    #24 0x555d2dccaefc in reader__process_events util/session.c:2233
    #25 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #26 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #27 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #28 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #29 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313

Indirect leak of 448760 byte(s) in 863 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2dd98a9a in hist_entry__zalloc util/hist.c:535
    #3 0x555d2dd98d1d in hist_entry__new util/hist.c:562
    #4 0x555d2dd99ca0 in hists__findnew_entry util/hist.c:657
    #5 0x555d2dd9bd74 in __hists__add_entry util/hist.c:751
    #6 0x555d2dd9c112 in hists__add_entry util/hist.c:768
    #7 0x555d2dd9e6cb in iter_add_single_normal_entry util/hist.c:995
    #8 0x555d2dda0e11 in hist_entry_iter__add util/hist.c:1231
    #9 0x555d2d8b1733 in process_sample_event /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-repo=
rt.c:315
    #10 0x555d2dcc1580 in evlist__deliver_sample util/session.c:1464
    #11 0x555d2dcc19de in machines__deliver_event util/session.c:1501
    #12 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #13 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #14 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #15 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #16 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #17 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #18 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #19 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #20 0x555d2dccb69e in process_simple util/session.c:2267
    #21 0x555d2dccaefc in reader__process_events util/session.c:2233
    #22 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #23 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #24 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #25 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #26 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #27 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #28 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #29 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539

Indirect leak of 116376 byte(s) in 1927 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dc15e04 in symbol__new util/symbol.c:269
    #2 0x555d2df51239 in dso__load_sym util/symbol-elf.c:1283
    #3 0x555d2dc24f3a in dso__load util/symbol.c:1897
    #4 0x555d2dca67fb in map__load util/map.c:332
    #5 0x555d2dca6d61 in map__find_symbol util/map.c:366
    #6 0x555d2db6749a in machine__resolve util/event.c:707
    #7 0x555d2d8b0b41 in process_sample_event /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-repo=
rt.c:273
    #8 0x555d2dcc1580 in evlist__deliver_sample util/session.c:1464
    #9 0x555d2dcc19de in machines__deliver_event util/session.c:1501
    #10 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #11 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #12 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #13 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #15 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #16 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #18 0x555d2dccb69e in process_simple util/session.c:2267
    #19 0x555d2dccaefc in reader__process_events util/session.c:2233
    #20 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #21 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #22 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 2748 byte(s) in 6 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dc0be64 in dso__new_id util/dso.c:1256
    #2 0x555d2dc0d003 in dso__new util/dso.c:1295
    #3 0x555d2dc88aea in machine__process_ksymbol_register util/machine.c:7=
74
    #4 0x555d2dc89abe in machine__process_ksymbol util/machine.c:844
    #5 0x555d2db60c0d in perf_event__process_ksymbol util/event.c:261
    #6 0x555d2dcc2ae5 in machines__deliver_event util/session.c:1547
    #7 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #8 0x555d2dcc5e7d in perf_session__process_event util/session.c:1803
    #9 0x555d2dccb69e in process_simple util/session.c:2267
    #10 0x555d2dccaefc in reader__process_events util/session.c:2233
    #11 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #12 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #13 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #14 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #15 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #16 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #17 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #18 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #19 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 2704 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2db6ad31 in evlist__new util/evlist.c:77
    #3 0x555d2dc60d16 in perf_session__read_header util/header.c:3797
    #4 0x555d2dcafc8c in perf_session__open util/session.c:109
    #5 0x555d2dcb0b91 in perf_session__new util/session.c:213
    #6 0x555d2d8c314b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #7 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #8 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #9 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #10 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #11 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 2586 byte(s) in 47 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dc15e04 in symbol__new util/symbol.c:269
    #2 0x555d2df473e5 in dso__synthesize_plt_symbols util/symbol-elf.c:405
    #3 0x555d2dc24f72 in dso__load util/symbol.c:1904
    #4 0x555d2dca67fb in map__load util/map.c:332
    #5 0x555d2dca6d61 in map__find_symbol util/map.c:366
    #6 0x555d2db6749a in machine__resolve util/event.c:707
    #7 0x555d2d8b0b41 in process_sample_event /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-repo=
rt.c:273
    #8 0x555d2dcc1580 in evlist__deliver_sample util/session.c:1464
    #9 0x555d2dcc19de in machines__deliver_event util/session.c:1501
    #10 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #11 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #12 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #13 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #15 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #16 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #18 0x555d2dccb69e in process_simple util/session.c:2267
    #19 0x555d2dccaefc in reader__process_events util/session.c:2233
    #20 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #21 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #22 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 2321 byte(s) in 5 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dc0be64 in dso__new_id util/dso.c:1256
    #2 0x555d2dc11a0c in __dsos__addnew_id util/dsos.c:248
    #3 0x555d2dc11b99 in __dsos__findnew_id util/dsos.c:271
    #4 0x555d2dc11c45 in dsos__findnew_id util/dsos.c:278
    #5 0x555d2dca1d82 in machine__findnew_dso_id util/machine.c:3139
    #6 0x555d2dca5091 in map__new util/map.c:177
    #7 0x555d2dc92e3d in machine__process_mmap2_event util/machine.c:1787
    #8 0x555d2db625a8 in perf_event__process_mmap2 util/event.c:368
    #9 0x555d2dcc1c75 in machines__deliver_event util/session.c:1507
    #10 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #11 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #12 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #13 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #15 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #16 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #18 0x555d2dccb69e in process_simple util/session.c:2267
    #19 0x555d2dccaefc in reader__process_events util/session.c:2233
    #20 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #21 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #22 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 1440 byte(s) in 15 object(s) allocated from:
    #0 0x7fd4c04bf330 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/li=
basan.so.5+0xe9330)
    #1 0x555d2dca4be7 in map__new util/map.c:135
    #2 0x555d2dc92e3d in machine__process_mmap2_event util/machine.c:1787
    #3 0x555d2db625a8 in perf_event__process_mmap2 util/event.c:368
    #4 0x555d2dcc1c75 in machines__deliver_event util/session.c:1507
    #5 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #6 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #7 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #8 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #9 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #10 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #11 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #12 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #13 0x555d2dccb69e in process_simple util/session.c:2267
    #14 0x555d2dccaefc in reader__process_events util/session.c:2233
    #15 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #16 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #17 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #18 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #19 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #20 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #21 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #22 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #23 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 1356 byte(s) in 3 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dc0be64 in dso__new_id util/dso.c:1256
    #2 0x555d2dc11a0c in __dsos__addnew_id util/dsos.c:248
    #3 0x555d2dc11b99 in __dsos__findnew_id util/dsos.c:271
    #4 0x555d2dc11c45 in dsos__findnew_id util/dsos.c:278
    #5 0x555d2dca1d82 in machine__findnew_dso_id util/machine.c:3139
    #6 0x555d2dca1dcf in machine__findnew_dso util/machine.c:3144
    #7 0x555d2dc4edf8 in __event_process_build_id util/header.c:2080
    #8 0x555d2dc4fc81 in perf_header__read_build_ids util/header.c:2199
    #9 0x555d2dc50acb in process_build_id util/header.c:2232
    #10 0x555d2dc5f604 in perf_file_section__process util/header.c:3651
    #11 0x555d2dc5d6dd in perf_header__process_sections util/header.c:3427
    #12 0x555d2dc61b80 in perf_session__read_header util/header.c:3886
    #13 0x555d2dcafc8c in perf_session__open util/session.c:109
    #14 0x555d2dcb0b91 in perf_session__new util/session.c:213
    #15 0x555d2d8c314b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #16 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #17 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #18 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #19 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #20 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 1344 byte(s) in 14 object(s) allocated from:
    #0 0x7fd4c04bf330 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/li=
basan.so.5+0xe9330)
    #1 0x555d2dbf2b2a in memdup ../lib/string.c:31
    #2 0x555d2dca7169 in map__clone util/map.c:391
    #3 0x555d2dcac370 in maps__clone util/map.c:849
    #4 0x555d2dce13ff in thread__clone_maps util/thread.c:388
    #5 0x555d2dce163a in thread__fork util/thread.c:404
    #6 0x555d2dc9498c in machine__process_fork_event util/machine.c:1965
    #7 0x555d2db6288e in perf_event__process_fork util/event.c:383
    #8 0x555d2dcc1e9d in machines__deliver_event util/session.c:1515
    #9 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #10 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #11 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #12 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #13 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #14 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #15 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #16 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #17 0x555d2dccb69e in process_simple util/session.c:2267
    #18 0x555d2dccaefc in reader__process_events util/session.c:2233
    #19 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #20 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #21 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #22 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #23 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #24 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #25 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #26 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #27 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 904 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2db83341 in evsel__new_idx util/evsel.c:268
    #3 0x555d2dc3b444 in evsel__new util/evsel.h:210
    #4 0x555d2dc6163f in perf_session__read_header util/header.c:3853
    #5 0x555d2dcafc8c in perf_session__open util/session.c:109
    #6 0x555d2dcb0b91 in perf_session__new util/session.c:213
    #7 0x555d2d8c314b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #8 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 560 byte(s) in 2 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2dcddda8 in thread__new util/thread.c:43
    #3 0x555d2dc86dd5 in ____machine__findnew_thread util/machine.c:543
    #4 0x555d2dc870e9 in __machine__findnew_thread util/machine.c:574
    #5 0x555d2dc8719f in machine__findnew_thread util/machine.c:584
    #6 0x555d2dc94850 in machine__process_fork_event util/machine.c:1945
    #7 0x555d2db6288e in perf_event__process_fork util/event.c:383
    #8 0x555d2dcc1e9d in machines__deliver_event util/session.c:1515
    #9 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #10 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #11 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #12 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #13 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #14 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #15 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #16 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #17 0x555d2dccb69e in process_simple util/session.c:2267
    #18 0x555d2dccaefc in reader__process_events util/session.c:2233
    #19 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #20 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #21 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #22 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #23 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #24 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #25 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #26 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #27 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 520 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2dd98a9a in hist_entry__zalloc util/hist.c:535
    #3 0x555d2dd98d1d in hist_entry__new util/hist.c:562
    #4 0x555d2dd99ca0 in hists__findnew_entry util/hist.c:657
    #5 0x555d2dd9bd74 in __hists__add_entry util/hist.c:751
    #6 0x555d2dd9c112 in hists__add_entry util/hist.c:768
    #7 0x555d2dd9e6cb in iter_add_single_normal_entry util/hist.c:995
    #8 0x555d2dda0e11 in hist_entry_iter__add util/hist.c:1231
    #9 0x555d2d8b1733 in process_sample_event /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-repo=
rt.c:315
    #10 0x555d2dcc1580 in evlist__deliver_sample util/session.c:1464
    #11 0x555d2dcc19de in machines__deliver_event util/session.c:1501
    #12 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #13 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #14 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #15 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #16 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #17 0x555d2dccbb98 in __perf_session__process_events util/session.c:2294
    #18 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #19 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #20 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #21 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #22 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #23 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #24 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #25 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 488 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2e0e95d4 in xyarray__new /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/lib/perf/xyarray.c:10
    #3 0x555d2e0d82bc in perf_evsel__alloc_id /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/lib/perf/evsel.c:=
361
    #4 0x555d2dc618a2 in perf_session__read_header util/header.c:3871
    #5 0x555d2dcafc8c in perf_session__open util/session.c:109
    #6 0x555d2dcb0b91 in perf_session__new util/session.c:213
    #7 0x555d2d8c314b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #8 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 444 byte(s) in 6 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dc15e04 in symbol__new util/symbol.c:269
    #2 0x555d2dc89467 in machine__process_ksymbol_register util/machine.c:8=
03
    #3 0x555d2dc89abe in machine__process_ksymbol util/machine.c:844
    #4 0x555d2db60c0d in perf_event__process_ksymbol util/event.c:261
    #5 0x555d2dcc2ae5 in machines__deliver_event util/session.c:1547
    #6 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #7 0x555d2dcc5e7d in perf_session__process_event util/session.c:1803
    #8 0x555d2dccb69e in process_simple util/session.c:2267
    #9 0x555d2dccaefc in reader__process_events util/session.c:2233
    #10 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #11 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #12 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #13 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #14 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #15 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #16 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #17 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #18 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 368 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dca5506 in map__new2 util/map.c:216
    #2 0x555d2dc8cdc4 in __machine__create_kernel_maps util/machine.c:1202
    #3 0x555d2dc91a93 in machine__process_kernel_mmap_event util/machine.c:=
1706
    #4 0x555d2dc935eb in machine__process_mmap_event util/machine.c:1833
    #5 0x555d2db62554 in perf_event__process_mmap util/event.c:360
    #6 0x555d2dcc1a68 in machines__deliver_event util/session.c:1503
    #7 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #8 0x555d2dcc5e7d in perf_session__process_event util/session.c:1803
    #9 0x555d2dccb69e in process_simple util/session.c:2267
    #10 0x555d2dccaefc in reader__process_events util/session.c:2233
    #11 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #12 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #13 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #14 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #15 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #16 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #17 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #18 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #19 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 280 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2dcddda8 in thread__new util/thread.c:43
    #3 0x555d2dc86dd5 in ____machine__findnew_thread util/machine.c:543
    #4 0x555d2dc870e9 in __machine__findnew_thread util/machine.c:574
    #5 0x555d2dc8719f in machine__findnew_thread util/machine.c:584
    #6 0x555d2dc876b3 in machine__process_comm_event util/machine.c:631
    #7 0x555d2db60979 in perf_event__process_comm util/event.c:197
    #8 0x555d2dcc1cff in machines__deliver_event util/session.c:1509
    #9 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #10 0x555d2dcc5e7d in perf_session__process_event util/session.c:1803
    #11 0x555d2dccb69e in process_simple util/session.c:2267
    #12 0x555d2dccaefc in reader__process_events util/session.c:2233
    #13 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #14 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #15 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #16 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #17 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #18 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #19 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #20 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #21 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 240 byte(s) in 2 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2dcaa107 in maps__new util/map.c:630
    #3 0x555d2dcddb46 in thread__init_maps util/thread.c:27
    #4 0x555d2dc86e98 in ____machine__findnew_thread util/machine.c:555
    #5 0x555d2dc870e9 in __machine__findnew_thread util/machine.c:574
    #6 0x555d2dc8719f in machine__findnew_thread util/machine.c:584
    #7 0x555d2dc94850 in machine__process_fork_event util/machine.c:1945
    #8 0x555d2db6288e in perf_event__process_fork util/event.c:383
    #9 0x555d2dcc1e9d in machines__deliver_event util/session.c:1515
    #10 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #11 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #12 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #13 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #15 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #16 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #18 0x555d2dccb69e in process_simple util/session.c:2267
    #19 0x555d2dccaefc in reader__process_events util/session.c:2233
    #20 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #21 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #22 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 144 byte(s) in 3 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2dcdbab6 in comm__new util/comm.c:110
    #3 0x555d2dcdfc3d in ____thread__set_comm util/thread.c:250
    #4 0x555d2dcdfec5 in __thread__set_comm util/thread.c:270
    #5 0x555d2dc87962 in machine__process_comm_event util/machine.c:644
    #6 0x555d2db60979 in perf_event__process_comm util/event.c:197
    #7 0x555d2dcc1cff in machines__deliver_event util/session.c:1509
    #8 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #9 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #10 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #11 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #12 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #13 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #14 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #15 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #16 0x555d2dccb69e in process_simple util/session.c:2267
    #17 0x555d2dccaefc in reader__process_events util/session.c:2233
    #18 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #19 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #20 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #21 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #22 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #23 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #24 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #25 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #26 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 120 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2dcaa107 in maps__new util/map.c:630
    #3 0x555d2dcddb46 in thread__init_maps util/thread.c:27
    #4 0x555d2dc86e98 in ____machine__findnew_thread util/machine.c:555
    #5 0x555d2dc870e9 in __machine__findnew_thread util/machine.c:574
    #6 0x555d2dc8719f in machine__findnew_thread util/machine.c:584
    #7 0x555d2dc876b3 in machine__process_comm_event util/machine.c:631
    #8 0x555d2db60979 in perf_event__process_comm util/event.c:197
    #9 0x555d2dcc1cff in machines__deliver_event util/session.c:1509
    #10 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #11 0x555d2dcc5e7d in perf_session__process_event util/session.c:1803
    #12 0x555d2dccb69e in process_simple util/session.c:2267
    #13 0x555d2dccaefc in reader__process_events util/session.c:2233
    #14 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #15 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #16 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #17 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #18 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #19 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #20 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #21 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #22 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 96 byte(s) in 2 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2dcdbab6 in comm__new util/comm.c:110
    #3 0x555d2dcde217 in thread__new util/thread.c:61
    #4 0x555d2dc86dd5 in ____machine__findnew_thread util/machine.c:543
    #5 0x555d2dc870e9 in __machine__findnew_thread util/machine.c:574
    #6 0x555d2dc8719f in machine__findnew_thread util/machine.c:584
    #7 0x555d2dc94850 in machine__process_fork_event util/machine.c:1945
    #8 0x555d2db6288e in perf_event__process_fork util/event.c:383
    #9 0x555d2dcc1e9d in machines__deliver_event util/session.c:1515
    #10 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #11 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #12 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #13 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #15 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #16 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #18 0x555d2dccb69e in process_simple util/session.c:2267
    #19 0x555d2dccaefc in reader__process_events util/session.c:2233
    #20 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #21 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #22 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 68 byte(s) in 5 object(s) allocated from:
    #0 0x7fd4c0410810 in strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3=
a810)
    #1 0x555d2dc118bd in dso__set_basename util/dsos.c:236
    #2 0x555d2dc11a36 in __dsos__addnew_id util/dsos.c:252
    #3 0x555d2dc11b99 in __dsos__findnew_id util/dsos.c:271
    #4 0x555d2dc11c45 in dsos__findnew_id util/dsos.c:278
    #5 0x555d2dca1d82 in machine__findnew_dso_id util/machine.c:3139
    #6 0x555d2dca5091 in map__new util/map.c:177
    #7 0x555d2dc92e3d in machine__process_mmap2_event util/machine.c:1787
    #8 0x555d2db625a8 in perf_event__process_mmap2 util/event.c:368
    #9 0x555d2dcc1c75 in machines__deliver_event util/session.c:1507
    #10 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #11 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #12 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #13 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #15 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #16 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #18 0x555d2dccb69e in process_simple util/session.c:2267
    #19 0x555d2dccaefc in reader__process_events util/session.c:2233
    #20 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #21 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #22 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 64 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2e0d83d6 in perf_evsel__alloc_id /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/lib/perf/evsel.c:=
365
    #3 0x555d2dc618a2 in perf_session__read_header util/header.c:3871
    #4 0x555d2dcafc8c in perf_session__open util/session.c:109
    #5 0x555d2dcb0b91 in perf_session__new util/session.c:213
    #6 0x555d2d8c314b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #7 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #8 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #9 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #10 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #11 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2e0e9417 in zalloc ../../lib/zalloc.c:8
    #2 0x555d2dcdbab6 in comm__new util/comm.c:110
    #3 0x555d2dcde217 in thread__new util/thread.c:61
    #4 0x555d2dc86dd5 in ____machine__findnew_thread util/machine.c:543
    #5 0x555d2dc870e9 in __machine__findnew_thread util/machine.c:574
    #6 0x555d2dc8719f in machine__findnew_thread util/machine.c:584
    #7 0x555d2dc876b3 in machine__process_comm_event util/machine.c:631
    #8 0x555d2db60979 in perf_event__process_comm util/event.c:197
    #9 0x555d2dcc1cff in machines__deliver_event util/session.c:1509
    #10 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #11 0x555d2dcc5e7d in perf_session__process_event util/session.c:1803
    #12 0x555d2dccb69e in process_simple util/session.c:2267
    #13 0x555d2dccaefc in reader__process_events util/session.c:2233
    #14 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #15 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #16 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #17 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #18 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #19 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #20 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #21 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #22 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 38 byte(s) in 3 object(s) allocated from:
    #0 0x7fd4c0410810 in strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3=
a810)
    #1 0x555d2dc118bd in dso__set_basename util/dsos.c:236
    #2 0x555d2dc11a36 in __dsos__addnew_id util/dsos.c:252
    #3 0x555d2dc11b99 in __dsos__findnew_id util/dsos.c:271
    #4 0x555d2dc11c45 in dsos__findnew_id util/dsos.c:278
    #5 0x555d2dca1d82 in machine__findnew_dso_id util/machine.c:3139
    #6 0x555d2dca1dcf in machine__findnew_dso util/machine.c:3144
    #7 0x555d2dc4edf8 in __event_process_build_id util/header.c:2080
    #8 0x555d2dc4fc81 in perf_header__read_build_ids util/header.c:2199
    #9 0x555d2dc50acb in process_build_id util/header.c:2232
    #10 0x555d2dc5f604 in perf_file_section__process util/header.c:3651
    #11 0x555d2dc5d6dd in perf_header__process_sections util/header.c:3427
    #12 0x555d2dc61b80 in perf_session__read_header util/header.c:3886
    #13 0x555d2dcafc8c in perf_session__open util/session.c:109
    #14 0x555d2dcb0b91 in perf_session__new util/session.c:213
    #15 0x555d2d8c314b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #16 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #17 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #18 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #19 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #20 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dcd8ac2 in nsinfo__new util/namespaces.c:142
    #2 0x555d2dcde3bf in thread__new util/thread.c:70
    #3 0x555d2dc86dd5 in ____machine__findnew_thread util/machine.c:543
    #4 0x555d2dc870e9 in __machine__findnew_thread util/machine.c:574
    #5 0x555d2dc8719f in machine__findnew_thread util/machine.c:584
    #6 0x555d2dc94850 in machine__process_fork_event util/machine.c:1945
    #7 0x555d2db6288e in perf_event__process_fork util/event.c:383
    #8 0x555d2dcc1e9d in machines__deliver_event util/session.c:1515
    #9 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #10 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #11 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #12 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #13 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #14 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #15 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #16 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #17 0x555d2dccb69e in process_simple util/session.c:2267
    #18 0x555d2dccaefc in reader__process_events util/session.c:2233
    #19 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #20 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #21 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #22 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #23 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #24 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #25 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #26 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #27 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c04bf518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x555d2dcd8e94 in nsinfo__copy util/namespaces.c:169
    #2 0x555d2dca4f7a in map__new util/map.c:168
    #3 0x555d2dc92e3d in machine__process_mmap2_event util/machine.c:1787
    #4 0x555d2db625a8 in perf_event__process_mmap2 util/event.c:368
    #5 0x555d2dcc1c75 in machines__deliver_event util/session.c:1507
    #6 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #7 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #8 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #9 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #10 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #11 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #12 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #13 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #14 0x555d2dccb69e in process_simple util/session.c:2267
    #15 0x555d2dccaefc in reader__process_events util/session.c:2233
    #16 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #17 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #18 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #19 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #20 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #21 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #22 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #23 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #24 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 12 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c0410810 in strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3=
a810)
    #1 0x555d2dc20235 in dso__load_kcore util/symbol.c:1402
    #2 0x555d2dc20e04 in __dso__load_kallsyms util/symbol.c:1467
    #3 0x555d2dc20ffa in dso__load_kallsyms util/symbol.c:1476
    #4 0x555d2dc27724 in dso__load_kernel_sym util/symbol.c:2235
    #5 0x555d2dc24289 in dso__load util/symbol.c:1778
    #6 0x555d2dca67fb in map__load util/map.c:332
    #7 0x555d2db65569 in thread__find_map util/event.c:605
    #8 0x555d2db6642c in machine__resolve util/event.c:675
    #9 0x555d2d8b0b41 in process_sample_event /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-repo=
rt.c:273
    #10 0x555d2dcc1580 in evlist__deliver_sample util/session.c:1464
    #11 0x555d2dcc19de in machines__deliver_event util/session.c:1501
    #12 0x555d2dcc305e in perf_session__deliver_event util/session.c:1577
    #13 0x555d2dcb07e2 in ordered_events__deliver_event util/session.c:184
    #14 0x555d2dcd50e8 in do_flush util/ordered-events.c:244
    #15 0x555d2dcd5ef1 in __ordered_events__flush util/ordered-events.c:323
    #16 0x555d2dcd63ce in ordered_events__flush util/ordered-events.c:341
    #17 0x555d2dcbd0ca in process_finished_round util/session.c:1061
    #18 0x555d2dcc3b9f in perf_session__process_user_event util/session.c:1=
629
    #19 0x555d2dcc5cc8 in perf_session__process_event util/session.c:1789
    #20 0x555d2dccb69e in process_simple util/session.c:2267
    #21 0x555d2dccaefc in reader__process_events util/session.c:2233
    #22 0x555d2dccbb75 in __perf_session__process_events util/session.c:2290
    #23 0x555d2dccbf16 in perf_session__process_events util/session.c:2323
    #24 0x555d2d8b92ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #25 0x555d2d8c58bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #26 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #27 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #28 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #29 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539

Indirect leak of 7 byte(s) in 1 object(s) allocated from:
    #0 0x7fd4c0410810 in strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3=
a810)
    #1 0x555d2dc514bd in evlist__set_event_name util/header.c:2292
    #2 0x555d2dc51805 in process_event_desc util/header.c:2313
    #3 0x555d2dc5f604 in perf_file_section__process util/header.c:3651
    #4 0x555d2dc5d6dd in perf_header__process_sections util/header.c:3427
    #5 0x555d2dc61b80 in perf_session__read_header util/header.c:3886
    #6 0x555d2dcafc8c in perf_session__open util/session.c:109
    #7 0x555d2dcb0b91 in perf_session__new util/session.c:213
    #8 0x555d2d8c314b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #9 0x555d2db06029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #10 0x555d2db067d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #11 0x555d2db06cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #12 0x555d2db076d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #13 0x7fd4bf6ac09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

SUMMARY: AddressSanitizer: 9540611 byte(s) leaked in 126419 allocation(s).
=2E/freq_test/run.sh: line 38: [: : integer expression expected
=2E/freq_test/run.sh: line 38: [: : integer expression expected
util/cpumap.c:48:22: runtime error: member access within misaligned address=
 0x7f6ff0a292ca for type 'struct perf_record_record_cpu_map', which require=
s 8 byte alignment
0x7f6ff0a292ca: note: pointer points here
 20 00  01 00 01 00 08 00 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00=
 00 00  11 00 00 00 00 00
              ^=20
util/cpumap.c:48:33: runtime error: member access within misaligned address=
 0x7f6ff0a292ca for type 'struct perf_record_record_cpu_map', which require=
s 8 byte alignment
0x7f6ff0a292ca: note: pointer points here
 20 00  01 00 01 00 08 00 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00=
 00 00  11 00 00 00 00 00
              ^=20
util/cpumap.c:50:25: runtime error: member access within misaligned address=
 0x7f6ff0a292ca for type 'struct perf_record_record_cpu_map', which require=
s 8 byte alignment
0x7f6ff0a292ca: note: pointer points here
 20 00  01 00 01 00 08 00 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00=
 00 00  11 00 00 00 00 00
              ^=20
=2E./lib/bitmap.c:13:8: runtime error: load of misaligned address 0x7f6ff0a=
292d2 for type 'const long unsigned int', which requires 8 byte alignment
0x7f6ff0a292d2: note: pointer points here
 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00 00 00  11 00 00 00 00 00=
 50 00  90 b4 00 c0 ff ff
              ^=20
util/cpumap.c:56:3: runtime error: member access within misaligned address =
0x7f6ff0a292ca for type 'struct perf_record_record_cpu_map', which requires=
 8 byte alignment
0x7f6ff0a292ca: note: pointer points here
 20 00  01 00 01 00 08 00 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00=
 00 00  11 00 00 00 00 00
              ^=20
=2E./lib/find_bit.c:91:11: runtime error: load of misaligned address 0x7f6f=
f0a292d2 for type 'const long unsigned int', which requires 8 byte alignment
0x7f6ff0a292d2: note: pointer points here
 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00 00 00  11 00 00 00 00 00=
 50 00  90 b4 00 c0 ff ff
              ^=20
=2E./lib/find_bit.c:92:11: runtime error: load of misaligned address 0x7f6f=
f0a292d2 for type 'const long unsigned int', which requires 8 byte alignment
0x7f6ff0a292d2: note: pointer points here
 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00 00 00  11 00 00 00 00 00=
 50 00  90 b4 00 c0 ff ff
              ^=20
util/cpumap.c:56:3: runtime error: member access within misaligned address =
0x7f6ff0a292ca for type 'struct perf_record_record_cpu_map', which requires=
 8 byte alignment
0x7f6ff0a292ca: note: pointer points here
 20 00  01 00 01 00 08 00 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00=
 00 00  11 00 00 00 00 00
              ^=20
=2E./lib/find_bit.c:41:6: runtime error: load of misaligned address 0x7f6ff=
0a292d2 for type 'const long unsigned int', which requires 8 byte alignment
0x7f6ff0a292d2: note: pointer points here
 00 00  00 00 ff 00 00 00 00 00  00 00 00 00 00 00 00 00  11 00 00 00 00 00=
 50 00  90 b4 00 c0 ff ff
              ^=20
util/bpf-event.c:57:7: runtime error: load of misaligned address 0x61500000=
1dae for type 'u64', which requires 8 byte alignment
0x615000001dae: note: pointer points here
 5d 5b c9 c3 90 b4  00 c0 ff ff ff ff c6 00  00 00 7b e4 9e 39 34 a1  25 ba=
 be be be be be be  00 00
             ^=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31883=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 2736 byte(s) in 6 object(s) allocated from:
    #0 0x7f6ff6027330 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/li=
basan.so.5+0xe9330)
    #1 0x55850efb6b2f in process_bpf_prog_info util/header.c:2901
    #2 0x55850efbe604 in perf_file_section__process util/header.c:3651
    #3 0x55850efbc6dd in perf_header__process_sections util/header.c:3427
    #4 0x55850efc0b80 in perf_session__read_header util/header.c:3886
    #5 0x55850f00ec8c in perf_session__open util/session.c:109
    #6 0x55850f00fb91 in perf_session__new util/session.c:213
    #7 0x55850ec2214b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #8 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 2208 byte(s) in 6 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f004506 in map__new2 util/map.c:216
    #2 0x55850efe7ba0 in machine__process_ksymbol_register util/machine.c:7=
78
    #3 0x55850efe8abe in machine__process_ksymbol util/machine.c:844
    #4 0x55850eebfc0d in perf_event__process_ksymbol util/event.c:261
    #5 0x55850f021ae5 in machines__deliver_event util/session.c:1547
    #6 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #7 0x55850f024e7d in perf_session__process_event util/session.c:1803
    #8 0x55850f02a69e in process_simple util/session.c:2267
    #9 0x55850f029efc in reader__process_events util/session.c:2233
    #10 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #11 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #12 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #13 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #14 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #15 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #16 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #17 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #18 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 736 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027720 in __interceptor_realloc (/usr/lib/x86_64-linux-gnu/l=
ibasan.so.5+0xe9720)
    #1 0x55850ef54b94 in strbuf_grow util/strbuf.c:64
    #2 0x55850ef5500c in strbuf_add util/strbuf.c:86
    #3 0x55850f0cb676 in strbuf_addstr util/strbuf.h:87
    #4 0x55850f0ecd54 in add_key util/sort.c:3348
    #5 0x55850f0ecfbe in add_sort_string util/sort.c:3361
    #6 0x55850f0ed2e2 in sort_help util/sort.c:3387
    #7 0x55850ec1cd35 in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1203
    #8 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 736 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027720 in __interceptor_realloc (/usr/lib/x86_64-linux-gnu/l=
ibasan.so.5+0xe9720)
    #1 0x55850ef54b94 in strbuf_grow util/strbuf.c:64
    #2 0x55850ef555ac in strbuf_addv util/strbuf.c:112
    #3 0x55850ef55a92 in strbuf_addf util/strbuf.c:134
    #4 0x55850f0ecdd6 in add_key util/sort.c:3351
    #5 0x55850f0ecfbe in add_sort_string util/sort.c:3361
    #6 0x55850f0ed2e2 in sort_help util/sort.c:3387
    #7 0x55850ec1cea9 in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1205
    #8 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 136 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027330 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/li=
basan.so.5+0xe9330)
    #1 0x55850ef51b2a in memdup ../lib/string.c:31
    #2 0x55850f0e28e5 in __hpp_dimension__alloc_hpp util/sort.c:2126
    #3 0x55850f0e822a in __hpp_dimension__add_output util/sort.c:2761
    #4 0x55850f0e83c4 in hpp_dimension__add_output util/sort.c:2773
    #5 0x55850f3a35f4 in perf_hpp__init ui/hist.c:560
    #6 0x55850f0eca6d in setup_sorting util/sort.c:3311
    #7 0x55850ec23d1f in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1535
    #8 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 129 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027720 in __interceptor_realloc (/usr/lib/x86_64-linux-gnu/l=
ibasan.so.5+0xe9720)
    #1 0x55850ef54b94 in strbuf_grow util/strbuf.c:64
    #2 0x55850ef5459d in strbuf_init util/strbuf.c:25
    #3 0x55850efb8090 in process_cpu_pmu_caps util/header.c:3022
    #4 0x55850efbe604 in perf_file_section__process util/header.c:3651
    #5 0x55850efbc6dd in perf_header__process_sections util/header.c:3427
    #6 0x55850efc0b80 in perf_session__read_header util/header.c:3886
    #7 0x55850f00ec8c in perf_session__open util/session.c:109
    #8 0x55850f00fb91 in perf_session__new util/session.c:213
    #9 0x55850ec2214b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #10 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #11 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #12 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #13 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #14 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 64 byte(s) in 2 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f037e94 in nsinfo__copy util/namespaces.c:169
    #2 0x55850f003f7a in map__new util/map.c:168
    #3 0x55850eff1e3d in machine__process_mmap2_event util/machine.c:1787
    #4 0x55850eec15a8 in perf_event__process_mmap2 util/event.c:368
    #5 0x55850f020c75 in machines__deliver_event util/session.c:1507
    #6 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #7 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #8 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #9 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #10 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #11 0x55850f01c0ca in process_finished_round util/session.c:1061
    #12 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #13 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #14 0x55850f02a69e in process_simple util/session.c:2267
    #15 0x55850f029efc in reader__process_events util/session.c:2233
    #16 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #17 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #18 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #19 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #20 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #21 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #22 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #23 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #24 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Direct leak of 24 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027720 in __interceptor_realloc (/usr/lib/x86_64-linux-gnu/l=
ibasan.so.5+0xe9720)
    #1 0x55850ef54b94 in strbuf_grow util/strbuf.c:64
    #2 0x55850ef5500c in strbuf_add util/strbuf.c:86
    #3 0x55850efb2311 in process_cpu_topology util/header.c:2470
    #4 0x55850efbe604 in perf_file_section__process util/header.c:3651
    #5 0x55850efbc6dd in perf_header__process_sections util/header.c:3427
    #6 0x55850efc0b80 in perf_session__read_header util/header.c:3886
    #7 0x55850f00ec8c in perf_session__open util/session.c:109
    #8 0x55850f00fb91 in perf_session__new util/session.c:213
    #9 0x55850ec2214b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #10 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #11 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #12 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #13 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #14 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 8949742 byte(s) in 123484 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850ef74e04 in symbol__new util/symbol.c:269
    #2 0x55850ef78881 in map__process_kallsym_symbol util/symbol.c:710
    #3 0x55850ef0fbb7 in kallsyms__parse ../lib/symbol/kallsyms.c:71
    #4 0x55850ef7892c in dso__load_all_kallsyms util/symbol.c:729
    #5 0x55850ef7facc in __dso__load_kallsyms util/symbol.c:1453
    #6 0x55850ef7fffa in dso__load_kallsyms util/symbol.c:1476
    #7 0x55850ef86724 in dso__load_kernel_sym util/symbol.c:2235
    #8 0x55850ef83289 in dso__load util/symbol.c:1778
    #9 0x55850f0057fb in map__load util/map.c:332
    #10 0x55850eec4569 in thread__find_map util/event.c:605
    #11 0x55850eec542c in machine__resolve util/event.c:675
    #12 0x55850ec0fb41 in process_sample_event /usr/src/perf_selftests-x86_=
64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-rep=
ort.c:273
    #13 0x55850f020580 in evlist__deliver_sample util/session.c:1464
    #14 0x55850f0209de in machines__deliver_event util/session.c:1501
    #15 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #16 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #17 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #18 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #19 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #20 0x55850f01c0ca in process_finished_round util/session.c:1061
    #21 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #22 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #23 0x55850f02a69e in process_simple util/session.c:2267
    #24 0x55850f029efc in reader__process_events util/session.c:2233
    #25 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #26 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #27 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #28 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #29 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313

Indirect leak of 852800 byte(s) in 1640 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850f0f7a9a in hist_entry__zalloc util/hist.c:535
    #3 0x55850f0f7d1d in hist_entry__new util/hist.c:562
    #4 0x55850f0f8ca0 in hists__findnew_entry util/hist.c:657
    #5 0x55850f0fad74 in __hists__add_entry util/hist.c:751
    #6 0x55850f0fb112 in hists__add_entry util/hist.c:768
    #7 0x55850f0fd6cb in iter_add_single_normal_entry util/hist.c:995
    #8 0x55850f0ffe11 in hist_entry_iter__add util/hist.c:1231
    #9 0x55850ec10733 in process_sample_event /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-repo=
rt.c:315
    #10 0x55850f020580 in evlist__deliver_sample util/session.c:1464
    #11 0x55850f0209de in machines__deliver_event util/session.c:1501
    #12 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #13 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #14 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #15 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #16 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #17 0x55850f01c0ca in process_finished_round util/session.c:1061
    #18 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #19 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #20 0x55850f02a69e in process_simple util/session.c:2267
    #21 0x55850f029efc in reader__process_events util/session.c:2233
    #22 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #23 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #24 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #25 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #26 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #27 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #28 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #29 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539

Indirect leak of 118311 byte(s) in 1957 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850ef74e04 in symbol__new util/symbol.c:269
    #2 0x55850f2b0239 in dso__load_sym util/symbol-elf.c:1283
    #3 0x55850ef83f3a in dso__load util/symbol.c:1897
    #4 0x55850f0057fb in map__load util/map.c:332
    #5 0x55850f005d61 in map__find_symbol util/map.c:366
    #6 0x55850eec649a in machine__resolve util/event.c:707
    #7 0x55850ec0fb41 in process_sample_event /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-repo=
rt.c:273
    #8 0x55850f020580 in evlist__deliver_sample util/session.c:1464
    #9 0x55850f0209de in machines__deliver_event util/session.c:1501
    #10 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #11 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #12 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #13 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #15 0x55850f01c0ca in process_finished_round util/session.c:1061
    #16 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #18 0x55850f02a69e in process_simple util/session.c:2267
    #19 0x55850f029efc in reader__process_events util/session.c:2233
    #20 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #21 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #22 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 8181 byte(s) in 139 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850ef74e04 in symbol__new util/symbol.c:269
    #2 0x55850f2a63e5 in dso__synthesize_plt_symbols util/symbol-elf.c:405
    #3 0x55850ef83f72 in dso__load util/symbol.c:1904
    #4 0x55850f0057fb in map__load util/map.c:332
    #5 0x55850f005d61 in map__find_symbol util/map.c:366
    #6 0x55850eec649a in machine__resolve util/event.c:707
    #7 0x55850ec0fb41 in process_sample_event /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-repo=
rt.c:273
    #8 0x55850f020580 in evlist__deliver_sample util/session.c:1464
    #9 0x55850f0209de in machines__deliver_event util/session.c:1501
    #10 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #11 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #12 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #13 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #15 0x55850f01c0ca in process_finished_round util/session.c:1061
    #16 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #18 0x55850f02a69e in process_simple util/session.c:2267
    #19 0x55850f029efc in reader__process_events util/session.c:2233
    #20 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #21 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #22 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 3640 byte(s) in 7 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850f0f7a9a in hist_entry__zalloc util/hist.c:535
    #3 0x55850f0f7d1d in hist_entry__new util/hist.c:562
    #4 0x55850f0f8ca0 in hists__findnew_entry util/hist.c:657
    #5 0x55850f0fad74 in __hists__add_entry util/hist.c:751
    #6 0x55850f0fb112 in hists__add_entry util/hist.c:768
    #7 0x55850f0fd6cb in iter_add_single_normal_entry util/hist.c:995
    #8 0x55850f0ffe11 in hist_entry_iter__add util/hist.c:1231
    #9 0x55850ec10733 in process_sample_event /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-repo=
rt.c:315
    #10 0x55850f020580 in evlist__deliver_sample util/session.c:1464
    #11 0x55850f0209de in machines__deliver_event util/session.c:1501
    #12 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #13 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #14 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #15 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #16 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #17 0x55850f02ab98 in __perf_session__process_events util/session.c:2294
    #18 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #19 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #20 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #21 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #22 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #23 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #24 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #25 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 2748 byte(s) in 6 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850ef6ae64 in dso__new_id util/dso.c:1256
    #2 0x55850ef6c003 in dso__new util/dso.c:1295
    #3 0x55850efe7aea in machine__process_ksymbol_register util/machine.c:7=
74
    #4 0x55850efe8abe in machine__process_ksymbol util/machine.c:844
    #5 0x55850eebfc0d in perf_event__process_ksymbol util/event.c:261
    #6 0x55850f021ae5 in machines__deliver_event util/session.c:1547
    #7 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #8 0x55850f024e7d in perf_session__process_event util/session.c:1803
    #9 0x55850f02a69e in process_simple util/session.c:2267
    #10 0x55850f029efc in reader__process_events util/session.c:2233
    #11 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #12 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #13 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #14 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #15 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #16 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #17 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #18 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #19 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 2704 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850eec9d31 in evlist__new util/evlist.c:77
    #3 0x55850efbfd16 in perf_session__read_header util/header.c:3797
    #4 0x55850f00ec8c in perf_session__open util/session.c:109
    #5 0x55850f00fb91 in perf_session__new util/session.c:213
    #6 0x55850ec2214b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #7 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #8 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #9 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #10 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #11 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 2263 byte(s) in 5 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850ef6ae64 in dso__new_id util/dso.c:1256
    #2 0x55850ef70a0c in __dsos__addnew_id util/dsos.c:248
    #3 0x55850ef70b99 in __dsos__findnew_id util/dsos.c:271
    #4 0x55850ef70c45 in dsos__findnew_id util/dsos.c:278
    #5 0x55850f000d82 in machine__findnew_dso_id util/machine.c:3139
    #6 0x55850f000dcf in machine__findnew_dso util/machine.c:3144
    #7 0x55850efaddf8 in __event_process_build_id util/header.c:2080
    #8 0x55850efaec81 in perf_header__read_build_ids util/header.c:2199
    #9 0x55850efafacb in process_build_id util/header.c:2232
    #10 0x55850efbe604 in perf_file_section__process util/header.c:3651
    #11 0x55850efbc6dd in perf_header__process_sections util/header.c:3427
    #12 0x55850efc0b80 in perf_session__read_header util/header.c:3886
    #13 0x55850f00ec8c in perf_session__open util/session.c:109
    #14 0x55850f00fb91 in perf_session__new util/session.c:213
    #15 0x55850ec2214b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #16 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #17 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #18 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #19 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #20 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 1808 byte(s) in 2 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850eee2341 in evsel__new_idx util/evsel.c:268
    #3 0x55850ef9a444 in evsel__new util/evsel.h:210
    #4 0x55850efc063f in perf_session__read_header util/header.c:3853
    #5 0x55850f00ec8c in perf_session__open util/session.c:109
    #6 0x55850f00fb91 in perf_session__new util/session.c:213
    #7 0x55850ec2214b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #8 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 1440 byte(s) in 15 object(s) allocated from:
    #0 0x7f6ff6027330 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/li=
basan.so.5+0xe9330)
    #1 0x55850f003be7 in map__new util/map.c:135
    #2 0x55850eff1e3d in machine__process_mmap2_event util/machine.c:1787
    #3 0x55850eec15a8 in perf_event__process_mmap2 util/event.c:368
    #4 0x55850f020c75 in machines__deliver_event util/session.c:1507
    #5 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #6 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #7 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #8 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #9 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #10 0x55850f01c0ca in process_finished_round util/session.c:1061
    #11 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #12 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #13 0x55850f02a69e in process_simple util/session.c:2267
    #14 0x55850f029efc in reader__process_events util/session.c:2233
    #15 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #16 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #17 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #18 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #19 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #20 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #21 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #22 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #23 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 1413 byte(s) in 3 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850ef6ae64 in dso__new_id util/dso.c:1256
    #2 0x55850ef70a0c in __dsos__addnew_id util/dsos.c:248
    #3 0x55850ef70b99 in __dsos__findnew_id util/dsos.c:271
    #4 0x55850ef70c45 in dsos__findnew_id util/dsos.c:278
    #5 0x55850f000d82 in machine__findnew_dso_id util/machine.c:3139
    #6 0x55850f004091 in map__new util/map.c:177
    #7 0x55850eff1e3d in machine__process_mmap2_event util/machine.c:1787
    #8 0x55850eec15a8 in perf_event__process_mmap2 util/event.c:368
    #9 0x55850f020c75 in machines__deliver_event util/session.c:1507
    #10 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #11 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #12 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #13 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #15 0x55850f01c0ca in process_finished_round util/session.c:1061
    #16 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #18 0x55850f02a69e in process_simple util/session.c:2267
    #19 0x55850f029efc in reader__process_events util/session.c:2233
    #20 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #21 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #22 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 1344 byte(s) in 14 object(s) allocated from:
    #0 0x7f6ff6027330 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/li=
basan.so.5+0xe9330)
    #1 0x55850ef51b2a in memdup ../lib/string.c:31
    #2 0x55850f006169 in map__clone util/map.c:391
    #3 0x55850f00b370 in maps__clone util/map.c:849
    #4 0x55850f0403ff in thread__clone_maps util/thread.c:388
    #5 0x55850f04063a in thread__fork util/thread.c:404
    #6 0x55850eff398c in machine__process_fork_event util/machine.c:1965
    #7 0x55850eec188e in perf_event__process_fork util/event.c:383
    #8 0x55850f020e9d in machines__deliver_event util/session.c:1515
    #9 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #10 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #11 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #12 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #13 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #14 0x55850f01c0ca in process_finished_round util/session.c:1061
    #15 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #16 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #17 0x55850f02a69e in process_simple util/session.c:2267
    #18 0x55850f029efc in reader__process_events util/session.c:2233
    #19 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #20 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #21 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #22 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #23 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #24 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #25 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #26 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #27 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 976 byte(s) in 2 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850f4485d4 in xyarray__new /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/lib/perf/xyarray.c:10
    #3 0x55850f4372bc in perf_evsel__alloc_id /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/lib/perf/evsel.c:=
361
    #4 0x55850efc08a2 in perf_session__read_header util/header.c:3871
    #5 0x55850f00ec8c in perf_session__open util/session.c:109
    #6 0x55850f00fb91 in perf_session__new util/session.c:213
    #7 0x55850ec2214b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #8 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 560 byte(s) in 2 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850f03cda8 in thread__new util/thread.c:43
    #3 0x55850efe5dd5 in ____machine__findnew_thread util/machine.c:543
    #4 0x55850efe60e9 in __machine__findnew_thread util/machine.c:574
    #5 0x55850efe619f in machine__findnew_thread util/machine.c:584
    #6 0x55850eff3850 in machine__process_fork_event util/machine.c:1945
    #7 0x55850eec188e in perf_event__process_fork util/event.c:383
    #8 0x55850f020e9d in machines__deliver_event util/session.c:1515
    #9 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #10 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #11 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #12 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #13 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #14 0x55850f01c0ca in process_finished_round util/session.c:1061
    #15 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #16 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #17 0x55850f02a69e in process_simple util/session.c:2267
    #18 0x55850f029efc in reader__process_events util/session.c:2233
    #19 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #20 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #21 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #22 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #23 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #24 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #25 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #26 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #27 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 444 byte(s) in 6 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850ef74e04 in symbol__new util/symbol.c:269
    #2 0x55850efe8467 in machine__process_ksymbol_register util/machine.c:8=
03
    #3 0x55850efe8abe in machine__process_ksymbol util/machine.c:844
    #4 0x55850eebfc0d in perf_event__process_ksymbol util/event.c:261
    #5 0x55850f021ae5 in machines__deliver_event util/session.c:1547
    #6 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #7 0x55850f024e7d in perf_session__process_event util/session.c:1803
    #8 0x55850f02a69e in process_simple util/session.c:2267
    #9 0x55850f029efc in reader__process_events util/session.c:2233
    #10 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #11 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #12 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #13 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #14 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #15 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #16 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #17 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #18 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 368 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f004506 in map__new2 util/map.c:216
    #2 0x55850efebdc4 in __machine__create_kernel_maps util/machine.c:1202
    #3 0x55850eff0a93 in machine__process_kernel_mmap_event util/machine.c:=
1706
    #4 0x55850eff25eb in machine__process_mmap_event util/machine.c:1833
    #5 0x55850eec1554 in perf_event__process_mmap util/event.c:360
    #6 0x55850f020a68 in machines__deliver_event util/session.c:1503
    #7 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #8 0x55850f024e7d in perf_session__process_event util/session.c:1803
    #9 0x55850f02a69e in process_simple util/session.c:2267
    #10 0x55850f029efc in reader__process_events util/session.c:2233
    #11 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #12 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #13 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #14 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #15 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #16 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #17 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #18 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #19 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 280 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850f03cda8 in thread__new util/thread.c:43
    #3 0x55850efe5dd5 in ____machine__findnew_thread util/machine.c:543
    #4 0x55850efe60e9 in __machine__findnew_thread util/machine.c:574
    #5 0x55850efe619f in machine__findnew_thread util/machine.c:584
    #6 0x55850efe66b3 in machine__process_comm_event util/machine.c:631
    #7 0x55850eebf979 in perf_event__process_comm util/event.c:197
    #8 0x55850f020cff in machines__deliver_event util/session.c:1509
    #9 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #10 0x55850f024e7d in perf_session__process_event util/session.c:1803
    #11 0x55850f02a69e in process_simple util/session.c:2267
    #12 0x55850f029efc in reader__process_events util/session.c:2233
    #13 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #14 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #15 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #16 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #17 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #18 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #19 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #20 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #21 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 240 byte(s) in 2 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850f009107 in maps__new util/map.c:630
    #3 0x55850f03cb46 in thread__init_maps util/thread.c:27
    #4 0x55850efe5e98 in ____machine__findnew_thread util/machine.c:555
    #5 0x55850efe60e9 in __machine__findnew_thread util/machine.c:574
    #6 0x55850efe619f in machine__findnew_thread util/machine.c:584
    #7 0x55850eff3850 in machine__process_fork_event util/machine.c:1945
    #8 0x55850eec188e in perf_event__process_fork util/event.c:383
    #9 0x55850f020e9d in machines__deliver_event util/session.c:1515
    #10 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #11 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #12 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #13 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #15 0x55850f01c0ca in process_finished_round util/session.c:1061
    #16 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #18 0x55850f02a69e in process_simple util/session.c:2267
    #19 0x55850f029efc in reader__process_events util/session.c:2233
    #20 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #21 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #22 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 144 byte(s) in 3 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850f03aab6 in comm__new util/comm.c:110
    #3 0x55850f03ec3d in ____thread__set_comm util/thread.c:250
    #4 0x55850f03eec5 in __thread__set_comm util/thread.c:270
    #5 0x55850efe6962 in machine__process_comm_event util/machine.c:644
    #6 0x55850eebf979 in perf_event__process_comm util/event.c:197
    #7 0x55850f020cff in machines__deliver_event util/session.c:1509
    #8 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #9 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #10 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #11 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #12 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #13 0x55850f01c0ca in process_finished_round util/session.c:1061
    #14 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #15 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #16 0x55850f02a69e in process_simple util/session.c:2267
    #17 0x55850f029efc in reader__process_events util/session.c:2233
    #18 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #19 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #20 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #21 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #22 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #23 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #24 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #25 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #26 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 128 byte(s) in 2 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850f4373d6 in perf_evsel__alloc_id /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/lib/perf/evsel.c:=
365
    #3 0x55850efc08a2 in perf_session__read_header util/header.c:3871
    #4 0x55850f00ec8c in perf_session__open util/session.c:109
    #5 0x55850f00fb91 in perf_session__new util/session.c:213
    #6 0x55850ec2214b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #7 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #8 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #9 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #10 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #11 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 120 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850f009107 in maps__new util/map.c:630
    #3 0x55850f03cb46 in thread__init_maps util/thread.c:27
    #4 0x55850efe5e98 in ____machine__findnew_thread util/machine.c:555
    #5 0x55850efe60e9 in __machine__findnew_thread util/machine.c:574
    #6 0x55850efe619f in machine__findnew_thread util/machine.c:584
    #7 0x55850efe66b3 in machine__process_comm_event util/machine.c:631
    #8 0x55850eebf979 in perf_event__process_comm util/event.c:197
    #9 0x55850f020cff in machines__deliver_event util/session.c:1509
    #10 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #11 0x55850f024e7d in perf_session__process_event util/session.c:1803
    #12 0x55850f02a69e in process_simple util/session.c:2267
    #13 0x55850f029efc in reader__process_events util/session.c:2233
    #14 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #15 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #16 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #17 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #18 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #19 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #20 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #21 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #22 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 96 byte(s) in 2 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850f03aab6 in comm__new util/comm.c:110
    #3 0x55850f03d217 in thread__new util/thread.c:61
    #4 0x55850efe5dd5 in ____machine__findnew_thread util/machine.c:543
    #5 0x55850efe60e9 in __machine__findnew_thread util/machine.c:574
    #6 0x55850efe619f in machine__findnew_thread util/machine.c:584
    #7 0x55850eff3850 in machine__process_fork_event util/machine.c:1945
    #8 0x55850eec188e in perf_event__process_fork util/event.c:383
    #9 0x55850f020e9d in machines__deliver_event util/session.c:1515
    #10 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #11 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #12 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #13 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #15 0x55850f01c0ca in process_finished_round util/session.c:1061
    #16 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #18 0x55850f02a69e in process_simple util/session.c:2267
    #19 0x55850f029efc in reader__process_events util/session.c:2233
    #20 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #21 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #22 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 54 byte(s) in 5 object(s) allocated from:
    #0 0x7f6ff5f78810 in strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3=
a810)
    #1 0x55850ef708bd in dso__set_basename util/dsos.c:236
    #2 0x55850ef70a36 in __dsos__addnew_id util/dsos.c:252
    #3 0x55850ef70b99 in __dsos__findnew_id util/dsos.c:271
    #4 0x55850ef70c45 in dsos__findnew_id util/dsos.c:278
    #5 0x55850f000d82 in machine__findnew_dso_id util/machine.c:3139
    #6 0x55850f000dcf in machine__findnew_dso util/machine.c:3144
    #7 0x55850efaddf8 in __event_process_build_id util/header.c:2080
    #8 0x55850efaec81 in perf_header__read_build_ids util/header.c:2199
    #9 0x55850efafacb in process_build_id util/header.c:2232
    #10 0x55850efbe604 in perf_file_section__process util/header.c:3651
    #11 0x55850efbc6dd in perf_header__process_sections util/header.c:3427
    #12 0x55850efc0b80 in perf_session__read_header util/header.c:3886
    #13 0x55850f00ec8c in perf_session__open util/session.c:109
    #14 0x55850f00fb91 in perf_session__new util/session.c:213
    #15 0x55850ec2214b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #16 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #17 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #18 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #19 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #20 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 51 byte(s) in 3 object(s) allocated from:
    #0 0x7f6ff5f78810 in strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3=
a810)
    #1 0x55850ef708bd in dso__set_basename util/dsos.c:236
    #2 0x55850ef70a36 in __dsos__addnew_id util/dsos.c:252
    #3 0x55850ef70b99 in __dsos__findnew_id util/dsos.c:271
    #4 0x55850ef70c45 in dsos__findnew_id util/dsos.c:278
    #5 0x55850f000d82 in machine__findnew_dso_id util/machine.c:3139
    #6 0x55850f004091 in map__new util/map.c:177
    #7 0x55850eff1e3d in machine__process_mmap2_event util/machine.c:1787
    #8 0x55850eec15a8 in perf_event__process_mmap2 util/event.c:368
    #9 0x55850f020c75 in machines__deliver_event util/session.c:1507
    #10 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #11 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #12 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #13 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #14 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #15 0x55850f01c0ca in process_finished_round util/session.c:1061
    #16 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #17 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #18 0x55850f02a69e in process_simple util/session.c:2267
    #19 0x55850f029efc in reader__process_events util/session.c:2233
    #20 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #21 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #22 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #23 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #24 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #25 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #26 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #27 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #28 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f448417 in zalloc ../../lib/zalloc.c:8
    #2 0x55850f03aab6 in comm__new util/comm.c:110
    #3 0x55850f03d217 in thread__new util/thread.c:61
    #4 0x55850efe5dd5 in ____machine__findnew_thread util/machine.c:543
    #5 0x55850efe60e9 in __machine__findnew_thread util/machine.c:574
    #6 0x55850efe619f in machine__findnew_thread util/machine.c:584
    #7 0x55850efe66b3 in machine__process_comm_event util/machine.c:631
    #8 0x55850eebf979 in perf_event__process_comm util/event.c:197
    #9 0x55850f020cff in machines__deliver_event util/session.c:1509
    #10 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #11 0x55850f024e7d in perf_session__process_event util/session.c:1803
    #12 0x55850f02a69e in process_simple util/session.c:2267
    #13 0x55850f029efc in reader__process_events util/session.c:2233
    #14 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #15 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #16 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #17 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #18 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #19 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #20 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #21 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #22 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f037ac2 in nsinfo__new util/namespaces.c:142
    #2 0x55850f03d3bf in thread__new util/thread.c:70
    #3 0x55850efe5dd5 in ____machine__findnew_thread util/machine.c:543
    #4 0x55850efe60e9 in __machine__findnew_thread util/machine.c:574
    #5 0x55850efe619f in machine__findnew_thread util/machine.c:584
    #6 0x55850eff3850 in machine__process_fork_event util/machine.c:1945
    #7 0x55850eec188e in perf_event__process_fork util/event.c:383
    #8 0x55850f020e9d in machines__deliver_event util/session.c:1515
    #9 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #10 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #11 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #12 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #13 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #14 0x55850f01c0ca in process_finished_round util/session.c:1061
    #15 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #16 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #17 0x55850f02a69e in process_simple util/session.c:2267
    #18 0x55850f029efc in reader__process_events util/session.c:2233
    #19 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #20 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #21 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #22 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #23 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #24 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #25 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #26 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #27 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff6027518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55850f037e94 in nsinfo__copy util/namespaces.c:169
    #2 0x55850f003f7a in map__new util/map.c:168
    #3 0x55850eff1e3d in machine__process_mmap2_event util/machine.c:1787
    #4 0x55850eec15a8 in perf_event__process_mmap2 util/event.c:368
    #5 0x55850f020c75 in machines__deliver_event util/session.c:1507
    #6 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #7 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #8 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #9 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #10 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #11 0x55850f01c0ca in process_finished_round util/session.c:1061
    #12 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #13 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #14 0x55850f02a69e in process_simple util/session.c:2267
    #15 0x55850f029efc in reader__process_events util/session.c:2233
    #16 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #17 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #18 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #19 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #20 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #21 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #22 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #23 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #24 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 20 byte(s) in 2 object(s) allocated from:
    #0 0x7f6ff5f78810 in strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3=
a810)
    #1 0x55850efb04bd in evlist__set_event_name util/header.c:2292
    #2 0x55850efb0805 in process_event_desc util/header.c:2313
    #3 0x55850efbe604 in perf_file_section__process util/header.c:3651
    #4 0x55850efbc6dd in perf_header__process_sections util/header.c:3427
    #5 0x55850efc0b80 in perf_session__read_header util/header.c:3886
    #6 0x55850f00ec8c in perf_session__open util/session.c:109
    #7 0x55850f00fb91 in perf_session__new util/session.c:213
    #8 0x55850ec2214b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #9 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #10 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #11 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #12 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #13 0x7f6ff521409a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

Indirect leak of 12 byte(s) in 1 object(s) allocated from:
    #0 0x7f6ff5f78810 in strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3=
a810)
    #1 0x55850ef7f235 in dso__load_kcore util/symbol.c:1402
    #2 0x55850ef7fe04 in __dso__load_kallsyms util/symbol.c:1467
    #3 0x55850ef7fffa in dso__load_kallsyms util/symbol.c:1476
    #4 0x55850ef86724 in dso__load_kernel_sym util/symbol.c:2235
    #5 0x55850ef83289 in dso__load util/symbol.c:1778
    #6 0x55850f0057fb in map__load util/map.c:332
    #7 0x55850eec4569 in thread__find_map util/event.c:605
    #8 0x55850eec542c in machine__resolve util/event.c:675
    #9 0x55850ec0fb41 in process_sample_event /usr/src/perf_selftests-x86_6=
4-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-repo=
rt.c:273
    #10 0x55850f020580 in evlist__deliver_sample util/session.c:1464
    #11 0x55850f0209de in machines__deliver_event util/session.c:1501
    #12 0x55850f02205e in perf_session__deliver_event util/session.c:1577
    #13 0x55850f00f7e2 in ordered_events__deliver_event util/session.c:184
    #14 0x55850f0340e8 in do_flush util/ordered-events.c:244
    #15 0x55850f034ef1 in __ordered_events__flush util/ordered-events.c:323
    #16 0x55850f0353ce in ordered_events__flush util/ordered-events.c:341
    #17 0x55850f01c0ca in process_finished_round util/session.c:1061
    #18 0x55850f022b9f in perf_session__process_user_event util/session.c:1=
629
    #19 0x55850f024cc8 in perf_session__process_event util/session.c:1789
    #20 0x55850f02a69e in process_simple util/session.c:2267
    #21 0x55850f029efc in reader__process_events util/session.c:2233
    #22 0x55850f02ab75 in __perf_session__process_events util/session.c:2290
    #23 0x55850f02af16 in perf_session__process_events util/session.c:2323
    #24 0x55850ec182ce in __cmd_report /usr/src/perf_selftests-x86_64-rhel-=
8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:931
    #25 0x55850ec248bd in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1619
    #26 0x55850ee65029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8=
=2E3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #27 0x55850ee657d4 in handle_internal_command /usr/src/perf_selftests-x=
86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:3=
65
    #28 0x55850ee65cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #29 0x55850ee666d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539

SUMMARY: AddressSanitizer: 9956768 byte(s) leaked in 127328 allocation(s).
=2E/freq_test/run.sh: line 38: [: : integer expression expected
=2E/freq_test/run.sh: line 38: [: : integer expression expected
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D31936=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address 0=
x602000000a08 at pc 0x55a72bd66dda bp 0x7ffebf157b40 sp 0x7ffebf157b38
READ of size 4 at 0x602000000a08 thread T0
    #0 0x55a72bd66dd9 in process_group_desc util/header.c:2631
    #1 0x55a72bd71604 in perf_file_section__process util/header.c:3651
    #2 0x55a72bd6f6dd in perf_header__process_sections util/header.c:3427
    #3 0x55a72bd73b80 in perf_session__read_header util/header.c:3886
    #4 0x55a72bdc1c8c in perf_session__open util/session.c:109
    #5 0x55a72bdc2b91 in perf_session__new util/session.c:213
    #6 0x55a72b9d514b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #7 0x55a72bc18029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #8 0x55a72bc187d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #9 0x55a72bc18cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #10 0x55a72bc196d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #11 0x7fb747d1709a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)
    #12 0x55a72b943999 in _start (/usr/src/perf_selftests-x86_64-rhel-8.3-7=
1d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf+0x1159999)

0x602000000a08 is located 8 bytes to the right of 16-byte region [0x6020000=
009f0,0x602000000a00)
allocated by thread T0 here:
    #0 0x7fb748b2a518 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe=
9518)
    #1 0x55a72bd66702 in process_group_desc util/header.c:2607
    #2 0x55a72bd71604 in perf_file_section__process util/header.c:3651
    #3 0x55a72bd6f6dd in perf_header__process_sections util/header.c:3427
    #4 0x55a72bd73b80 in perf_session__read_header util/header.c:3886
    #5 0x55a72bdc1c8c in perf_session__open util/session.c:109
    #6 0x55a72bdc2b91 in perf_session__new util/session.c:213
    #7 0x55a72b9d514b in cmd_report /usr/src/perf_selftests-x86_64-rhel-8.3=
-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/builtin-report.c:1400
    #8 0x55a72bc18029 in run_builtin /usr/src/perf_selftests-x86_64-rhel-8.=
3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:313
    #9 0x55a72bc187d4 in handle_internal_command /usr/src/perf_selftests-x8=
6_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:365
    #10 0x55a72bc18cf6 in run_argv /usr/src/perf_selftests-x86_64-rhel-8.3-=
71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:409
    #11 0x55a72bc196d6 in main /usr/src/perf_selftests-x86_64-rhel-8.3-71d7=
924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf/perf.c:539
    #12 0x7fb747d1709a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.=
6+0x2409a)

SUMMARY: AddressSanitizer: heap-buffer-overflow util/header.c:2631 in proce=
ss_group_desc
Shadow bytes around the buggy address:
  0x0c047fff80f0: fa fa 00 fa fa fa 00 00 fa fa 00 fa fa fa 00 fa
  0x0c047fff8100: fa fa 00 00 fa fa 00 00 fa fa 00 00 fa fa 00 00
  0x0c047fff8110: fa fa 01 fa fa fa 00 02 fa fa fd fd fa fa 05 fa
  0x0c047fff8120: fa fa fd fa fa fa 07 fa fa fa 00 05 fa fa fd fd
  0x0c047fff8130: fa fa 05 fa fa fa 07 fa fa fa 00 05 fa fa 00 00
=3D>0x0c047fff8140: fa[fa]fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c047fff8150: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c047fff8160: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c047fff8170: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c047fff8180: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c047fff8190: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07=20
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
=3D=3D31936=3D=3DABORTING
=2E/freq_test/run.sh: line 38: [: : integer expression expected
=2E/freq_test/run.sh: line 38: [: : integer expression expected
Thu May 20 09:09:17 UTC 2021
0 test cases pass for perf_freq_checking test. 3 test cases fail for perf_f=
req_checking test.
Test case finity_noploop_default FAIL!
Test case finity_noploop_cycles_instructions FAIL!
Test case finity_noploop_cycles_instructions_group FAIL!
2021-05-20 09:09:18 ./group_test/run.sh
perf hardware event count group test
Thu May 20 09:09:48 UTC 2021
70 test cases pass for perf_hw_event_count_group test. 0 test cases fail fo=
r perf_hw_event_count_group test.
Test Case count_cache-misses_branch-misses_cpu-cycles_R4 PASS!
Test Case count_group_cache-misses_branch-misses_R4 PASS!
Test Case count_group_branch-misses_cpu-cycles_u_R4 PASS!
Test Case count_group_cache-misses_cpu-cycles_k_R4 PASS!
Test Case count_group_cache-misses_branch-misses_and_group_branch-misses_cp=
u-cycles_R4 PASS!
Test Case count_group_cache-misses_branch-misses_cpu-cycles_R4 PASS!
Test Case count_group_cache-misses_branch-misses_and_group_cache-misses_bra=
nch-misses_cpu-cycles_k_R4 PASS!
Test Case count_group_cache-misses_branch-misses_cpu-cycles_and_group_cache=
-misses_branch-misses_cpu-cycles_R4 PASS!
Test Case count_global_group_branch-misses_cpu-cycles_R4 PASS!
Test Case count_global_group_branch-misses_cpu-cycles_u_R4 PASS!
Test Case count_global_group_branch-misses_cpu-cycles_k_R4 PASS!
Test Case count_global_group_branch-misses_cpu-cycles_cache-misses_R4 PASS!
Test Case count_global_group_branch-misses_cpu-cycles_cache-misses_u_R4 PAS=
S!
Test Case count_global_group_branch-misses_cpu-cycles_cache-misses_k_R4 PAS=
S!
Test Case count_ref-cycles_cache-references_branch-misses_R3 PASS!
Test Case count_group_ref-cycles_cache-references_R3 PASS!
Test Case count_group_cache-references_branch-misses_u_R3 PASS!
Test Case count_group_ref-cycles_branch-misses_k_R3 PASS!
Test Case count_group_ref-cycles_cache-references_and_group_cache-reference=
s_branch-misses_R3 PASS!
Test Case count_group_ref-cycles_cache-references_branch-misses_R3 PASS!
Test Case count_group_ref-cycles_cache-references_and_group_ref-cycles_cach=
e-references_branch-misses_k_R3 PASS!
Test Case count_group_ref-cycles_cache-references_branch-misses_and_group_r=
ef-cycles_cache-references_branch-misses_R3 PASS!
Test Case count_global_group_cache-references_branch-misses_R3 PASS!
Test Case count_global_group_cache-references_branch-misses_u_R3 PASS!
Test Case count_global_group_cache-references_branch-misses_k_R3 PASS!
Test Case count_global_group_cache-references_branch-misses_ref-cycles_R3 P=
ASS!
Test Case count_global_group_cache-references_branch-misses_ref-cycles_u_R3=
 PASS!
Test Case count_global_group_cache-references_branch-misses_ref-cycles_k_R3=
 PASS!
Test Case count_branch-instructions_instructions_cpu-cycles_R2 PASS!
Test Case count_group_branch-instructions_instructions_R2 PASS!
Test Case count_group_instructions_cpu-cycles_u_R2 PASS!
Test Case count_group_branch-instructions_cpu-cycles_k_R2 PASS!
Test Case count_group_branch-instructions_instructions_and_group_instructio=
ns_cpu-cycles_R2 PASS!
Test Case count_group_branch-instructions_instructions_cpu-cycles_R2 PASS!
Test Case count_group_branch-instructions_instructions_and_group_branch-ins=
tructions_instructions_cpu-cycles_k_R2 PASS!
Test Case count_group_branch-instructions_instructions_cpu-cycles_and_group=
_branch-instructions_instructions_cpu-cycles_R2 PASS!
Test Case count_global_group_instructions_cpu-cycles_R2 PASS!
Test Case count_global_group_instructions_cpu-cycles_u_R2 PASS!
Test Case count_global_group_instructions_cpu-cycles_k_R2 PASS!
Test Case count_global_group_instructions_cpu-cycles_branch-instructions_R2=
 PASS!
Test Case count_global_group_instructions_cpu-cycles_branch-instructions_u_=
R2 PASS!
Test Case count_global_group_instructions_cpu-cycles_branch-instructions_k_=
R2 PASS!
Test Case count_cpu-cycles_branch-misses_cache-references_R1 PASS!
Test Case count_group_cpu-cycles_branch-misses_R1 PASS!
Test Case count_group_branch-misses_cache-references_u_R1 PASS!
Test Case count_group_cpu-cycles_cache-references_k_R1 PASS!
Test Case count_group_cpu-cycles_branch-misses_and_group_branch-misses_cach=
e-references_R1 PASS!
Test Case count_group_cpu-cycles_branch-misses_cache-references_R1 PASS!
Test Case count_group_cpu-cycles_branch-misses_and_group_cpu-cycles_branch-=
misses_cache-references_k_R1 PASS!
Test Case count_group_cpu-cycles_branch-misses_cache-references_and_group_c=
pu-cycles_branch-misses_cache-references_R1 PASS!
Test Case count_global_group_branch-misses_cache-references_R1 PASS!
Test Case count_global_group_branch-misses_cache-references_u_R1 PASS!
Test Case count_global_group_branch-misses_cache-references_k_R1 PASS!
Test Case count_global_group_branch-misses_cache-references_cpu-cycles_R1 P=
ASS!
Test Case count_global_group_branch-misses_cache-references_cpu-cycles_u_R1=
 PASS!
Test Case count_global_group_branch-misses_cache-references_cpu-cycles_k_R1=
 PASS!
Test Case count_cpu-cycles_bus-cycles_ref-cycles_R0 PASS!
Test Case count_group_cpu-cycles_bus-cycles_R0 PASS!
Test Case count_group_bus-cycles_ref-cycles_u_R0 PASS!
Test Case count_group_cpu-cycles_ref-cycles_k_R0 PASS!
Test Case count_group_cpu-cycles_bus-cycles_and_group_bus-cycles_ref-cycles=
_R0 PASS!
Test Case count_group_cpu-cycles_bus-cycles_ref-cycles_R0 PASS!
Test Case count_group_cpu-cycles_bus-cycles_and_group_cpu-cycles_bus-cycles=
_ref-cycles_k_R0 PASS!
Test Case count_group_cpu-cycles_bus-cycles_ref-cycles_and_group_cpu-cycles=
_bus-cycles_ref-cycles_R0 PASS!
Test Case count_global_group_bus-cycles_ref-cycles_R0 PASS!
Test Case count_global_group_bus-cycles_ref-cycles_u_R0 PASS!
Test Case count_global_group_bus-cycles_ref-cycles_k_R0 PASS!
Test Case count_global_group_bus-cycles_ref-cycles_cpu-cycles_R0 PASS!
Test Case count_global_group_bus-cycles_ref-cycles_cpu-cycles_u_R0 PASS!
Test Case count_global_group_bus-cycles_ref-cycles_cpu-cycles_k_R0 PASS!
perf hardware cache event count group test
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
Thu May 20 09:09:49 UTC 2021
0 test cases pass for perf_hw_cache_event_count_group test. 0 test cases fa=
il for perf_hw_cache_event_count_group test.
perf kernel cpu PMU event count group test
Thu May 20 09:10:13 UTC 2021
57 test cases pass for perf_pmu_event_count_group test. 0 test cases fail f=
or perf_pmu_event_count_group test.
Test Case count_cpu/branch-misses/_cpu/mem-loads/_cpu/el-conflict/_R4 PASS!
Test Case count_group_cpu/branch-misses/_cpu/mem-loads/_R4 PASS!
Test Case count_group_cpu/mem-loads/_cpu/el-conflict/_u_R4 PASS!
Test Case count_group_cpu/branch-misses/_cpu/el-conflict/_k_R4 PASS!
Test Case count_group_cpu/branch-misses/_cpu/mem-loads/_and_group_cpu/mem-l=
oads/_cpu/el-conflict/_R4 PASS!
Test Case count_group_cpu/branch-misses/_cpu/mem-loads/_cpu/el-conflict/_R4=
 PASS!
Test Case count_group_cpu/branch-misses/_cpu/mem-loads/_and_group_cpu/branc=
h-misses/_cpu/mem-loads/_cpu/el-conflict/_k_R4 PASS!
Test Case count_group_cpu/branch-misses/_cpu/mem-loads/_cpu/el-conflict/_an=
d_group_cpu/branch-misses/_cpu/mem-loads/_cpu/el-conflict/_R4 PASS!
Test Case count_global_group_cpu/mem-loads/_cpu/el-conflict/_R4 PASS!
Test Case count_global_group_cpu/mem-loads/_cpu/el-conflict/_u_R4 PASS!
Test Case count_global_group_cpu/mem-loads/_cpu/el-conflict/_k_R4 PASS!
Test Case count_global_group_cpu/mem-loads/_cpu/el-conflict/_cpu/branch-mis=
ses/_R4 PASS!
Test Case count_global_group_cpu/mem-loads/_cpu/el-conflict/_cpu/branch-mis=
ses/_u_R4 PASS!
Test Case count_global_group_cpu/mem-loads/_cpu/el-conflict/_cpu/branch-mis=
ses/_k_R4 PASS!
Test Case count_cpu/topdown-slots-issued/_cpu/tx-abort/_cpu/tx-start/_R3 PA=
SS!
Test Case count_group_cpu/topdown-slots-issued/_cpu/tx-abort/_R3 PASS!
Test Case count_group_cpu/tx-abort/_cpu/tx-start/_u_R3 PASS!
Test Case count_group_cpu/topdown-slots-issued/_cpu/tx-start/_k_R3 PASS!
Test Case count_group_cpu/topdown-slots-issued/_cpu/tx-abort/_and_group_cpu=
/tx-abort/_cpu/tx-start/_R3 PASS!
Test Case count_group_cpu/topdown-slots-issued/_cpu/tx-abort/_cpu/tx-start/=
_R3 PASS!
Test Case count_group_cpu/topdown-slots-issued/_cpu/tx-abort/_and_group_cpu=
/topdown-slots-issued/_cpu/tx-abort/_cpu/tx-start/_k_R3 PASS!
Test Case count_group_cpu/topdown-slots-issued/_cpu/tx-abort/_cpu/tx-start/=
_and_group_cpu/topdown-slots-issued/_cpu/tx-abort/_cpu/tx-start/_R3 PASS!
Test Case count_global_group_cpu/tx-abort/_cpu/tx-start/_R3 PASS!
Test Case count_global_group_cpu/tx-abort/_cpu/tx-start/_u_R3 PASS!
Test Case count_global_group_cpu/tx-abort/_cpu/tx-start/_k_R3 PASS!
Test Case count_global_group_cpu/tx-abort/_cpu/tx-start/_cpu/topdown-slots-=
issued/_R3 PASS!
Test Case count_global_group_cpu/tx-abort/_cpu/tx-start/_cpu/topdown-slots-=
issued/_u_R3 PASS!
Test Case count_global_group_cpu/tx-abort/_cpu/tx-start/_cpu/topdown-slots-=
issued/_k_R3 PASS!
Test Case count_cpu/bus-cycles/_cpu/branch-instructions/_cpu/el-abort/_R2 P=
ASS!
Test Case count_group_cpu/bus-cycles/_cpu/branch-instructions/_R2 PASS!
Test Case count_group_cpu/branch-instructions/_cpu/el-abort/_u_R2 PASS!
Test Case count_group_cpu/bus-cycles/_cpu/el-abort/_k_R2 PASS!
Test Case count_group_cpu/bus-cycles/_cpu/branch-instructions/_and_group_cp=
u/branch-instructions/_cpu/el-abort/_R2 PASS!
Test Case count_group_cpu/bus-cycles/_cpu/branch-instructions/_cpu/el-abort=
/_R2 PASS!
Test Case count_group_cpu/bus-cycles/_cpu/branch-instructions/_and_group_cp=
u/bus-cycles/_cpu/branch-instructions/_cpu/el-abort/_k_R2 PASS!
Test Case count_group_cpu/bus-cycles/_cpu/branch-instructions/_cpu/el-abort=
/_and_group_cpu/bus-cycles/_cpu/branch-instructions/_cpu/el-abort/_R2 PASS!
Test Case count_global_group_cpu/branch-instructions/_cpu/el-abort/_R2 PASS!
Test Case count_global_group_cpu/branch-instructions/_cpu/el-abort/_u_R2 PA=
SS!
Test Case count_global_group_cpu/branch-instructions/_cpu/el-abort/_k_R2 PA=
SS!
Test Case count_global_group_cpu/branch-instructions/_cpu/el-abort/_cpu/bus=
-cycles/_R2 PASS!
Test Case count_global_group_cpu/branch-instructions/_cpu/el-abort/_cpu/bus=
-cycles/_u_R2 PASS!
Test Case count_global_group_cpu/branch-instructions/_cpu/el-abort/_cpu/bus=
-cycles/_k_R2 PASS!
Test Case count_cpu/topdown-slots-retired/_cpu/topdown-recovery-bubbles/_cp=
u/topdown-total-slots/_R1 PASS!
Test Case count_cpu/topdown-total-slots/_cpu/tx-commit/_cpu/el-commit/_R0 P=
ASS!
Test Case count_group_cpu/topdown-total-slots/_cpu/tx-commit/_R0 PASS!
Test Case count_group_cpu/tx-commit/_cpu/el-commit/_u_R0 PASS!
Test Case count_group_cpu/topdown-total-slots/_cpu/el-commit/_k_R0 PASS!
Test Case count_group_cpu/topdown-total-slots/_cpu/tx-commit/_and_group_cpu=
/tx-commit/_cpu/el-commit/_R0 PASS!
Test Case count_group_cpu/topdown-total-slots/_cpu/tx-commit/_cpu/el-commit=
/_R0 PASS!
Test Case count_group_cpu/topdown-total-slots/_cpu/tx-commit/_and_group_cpu=
/topdown-total-slots/_cpu/tx-commit/_cpu/el-commit/_k_R0 PASS!
Test Case count_group_cpu/topdown-total-slots/_cpu/tx-commit/_cpu/el-commit=
/_and_group_cpu/topdown-total-slots/_cpu/tx-commit/_cpu/el-commit/_R0 PASS!
Test Case count_global_group_cpu/tx-commit/_cpu/el-commit/_R0 PASS!
Test Case count_global_group_cpu/tx-commit/_cpu/el-commit/_u_R0 PASS!
Test Case count_global_group_cpu/tx-commit/_cpu/el-commit/_k_R0 PASS!
Test Case count_global_group_cpu/tx-commit/_cpu/el-commit/_cpu/topdown-tota=
l-slots/_R0 PASS!
Test Case count_global_group_cpu/tx-commit/_cpu/el-commit/_cpu/topdown-tota=
l-slots/_u_R0 PASS!
Test Case count_global_group_cpu/tx-commit/_cpu/el-commit/_cpu/topdown-tota=
l-slots/_k_R0 PASS!
ROUND : perf hardware event sample group test
Thu May 20 09:10:48 UTC 2021
0 test cases pass for perf_hw_event_sample_group test. 80 test cases fail f=
or perf_hw_event_sample_group test.
Test Case sampe_cache-misses_cache-references_bus-cycles_NO_FIX_HAS_NMI_R4 =
FAILED!
Test Case group_sampe_cache-misses_cache-references_NO_FIX_HAS_NMI_R4 FAILE=
D!
Test Case group_sampe_cache-references_bus-cycles_u_NO_FIX_HAS_NMI_R4 FAILE=
D!
Test Case group_sampe_cache-misses_bus-cycles_k_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cache-misses_cache-references_and_cache-references_bu=
s-cycles_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cache-misses_cache-references_bus-cycles_NO_FIX_HAS_N=
MI_R4 FAILED!
Test Case group_sampe_cache-misses_cache-references_and_cache-misses_cache-=
references_bus-cycles_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cache-misses_cache-references_bus-cycles_and_cache-mi=
sses_cache-references_bus-cycles_NO_FIX_HAS_NMI_R4 FAILED!
Test Case sampe_cache-misses_cache-references_bus-cycles_HAS_FIX_NO_NMI_R4 =
FAILED!
Test Case group_sampe_cache-misses_cache-references_HAS_FIX_NO_NMI_R4 FAILE=
D!
Test Case group_sampe_cache-references_bus-cycles_u_HAS_FIX_NO_NMI_R4 FAILE=
D!
Test Case group_sampe_cache-misses_bus-cycles_k_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cache-misses_cache-references_and_cache-references_bu=
s-cycles_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cache-misses_cache-references_bus-cycles_HAS_FIX_NO_N=
MI_R4 FAILED!
Test Case group_sampe_cache-misses_cache-references_and_cache-misses_cache-=
references_bus-cycles_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cache-misses_cache-references_bus-cycles_and_cache-mi=
sses_cache-references_bus-cycles_HAS_FIX_NO_NMI_R4 FAILED!
Test Case sampe_cycles:p_branch-instructions_branch-instructions_NO_FIX_HAS=
_NMI_R3 FAILED!
Test Case group_sampe_cycles:p_branch-instructions_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_branch-instructions_branch-instructions_u_NO_FIX_HAS_=
NMI_R3 FAILED!
Test Case group_sampe_cycles:p_branch-instructions_k_NO_FIX_HAS_NMI_R3 FAIL=
ED!
Test Case group_sampe_cycles:p_branch-instructions_and_branch-instructions_=
branch-instructions_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cycles:p_branch-instructions_branch-instructions_NO_F=
IX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cycles:p_branch-instructions_and_cycles:p_branch-inst=
ructions_branch-instructions_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cycles:p_branch-instructions_branch-instructions_and_=
cycles:p_branch-instructions_branch-instructions_NO_FIX_HAS_NMI_R3 FAILED!
Test Case sampe_cycles:p_branch-instructions_branch-instructions_HAS_FIX_NO=
_NMI_R3 FAILED!
Test Case group_sampe_cycles:p_branch-instructions_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_branch-instructions_branch-instructions_u_HAS_FIX_NO_=
NMI_R3 FAILED!
Test Case group_sampe_cycles:p_branch-instructions_k_HAS_FIX_NO_NMI_R3 FAIL=
ED!
Test Case group_sampe_cycles:p_branch-instructions_and_branch-instructions_=
branch-instructions_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cycles:p_branch-instructions_branch-instructions_HAS_=
FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cycles:p_branch-instructions_and_cycles:p_branch-inst=
ructions_branch-instructions_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cycles:p_branch-instructions_branch-instructions_and_=
cycles:p_branch-instructions_branch-instructions_HAS_FIX_NO_NMI_R3 FAILED!
Test Case sampe_bus-cycles_cycles:pp_instructions_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_bus-cycles_cycles:pp_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cycles:pp_instructions_u_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_bus-cycles_instructions_k_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_bus-cycles_cycles:pp_and_cycles:pp_instructions_NO_FI=
X_HAS_NMI_R2 FAILED!
Test Case group_sampe_bus-cycles_cycles:pp_instructions_NO_FIX_HAS_NMI_R2 F=
AILED!
Test Case group_sampe_bus-cycles_cycles:pp_and_bus-cycles_cycles:pp_instruc=
tions_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_bus-cycles_cycles:pp_instructions_and_bus-cycles_cycl=
es:pp_instructions_NO_FIX_HAS_NMI_R2 FAILED!
Test Case sampe_bus-cycles_cycles:pp_instructions_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_bus-cycles_cycles:pp_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cycles:pp_instructions_u_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_bus-cycles_instructions_k_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_bus-cycles_cycles:pp_and_cycles:pp_instructions_HAS_F=
IX_NO_NMI_R2 FAILED!
Test Case group_sampe_bus-cycles_cycles:pp_instructions_HAS_FIX_NO_NMI_R2 F=
AILED!
Test Case group_sampe_bus-cycles_cycles:pp_and_bus-cycles_cycles:pp_instruc=
tions_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_bus-cycles_cycles:pp_instructions_and_bus-cycles_cycl=
es:pp_instructions_HAS_FIX_NO_NMI_R2 FAILED!
Test Case sampe_branch-instructions_cycles:pp_instructions_NO_FIX_HAS_NMI_R=
1 FAILED!
Test Case group_sampe_branch-instructions_cycles:pp_NO_FIX_HAS_NMI_R1 FAILE=
D!
Test Case group_sampe_cycles:pp_instructions_u_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_branch-instructions_instructions_k_NO_FIX_HAS_NMI_R1 =
FAILED!
Test Case group_sampe_branch-instructions_cycles:pp_and_cycles:pp_instructi=
ons_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_branch-instructions_cycles:pp_instructions_NO_FIX_HAS=
_NMI_R1 FAILED!
Test Case group_sampe_branch-instructions_cycles:pp_and_branch-instructions=
_cycles:pp_instructions_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_branch-instructions_cycles:pp_instructions_and_branch=
-instructions_cycles:pp_instructions_NO_FIX_HAS_NMI_R1 FAILED!
Test Case sampe_branch-instructions_cycles:pp_instructions_HAS_FIX_NO_NMI_R=
1 FAILED!
Test Case group_sampe_branch-instructions_cycles:pp_HAS_FIX_NO_NMI_R1 FAILE=
D!
Test Case group_sampe_cycles:pp_instructions_u_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_branch-instructions_instructions_k_HAS_FIX_NO_NMI_R1 =
FAILED!
Test Case group_sampe_branch-instructions_cycles:pp_and_cycles:pp_instructi=
ons_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_branch-instructions_cycles:pp_instructions_HAS_FIX_NO=
_NMI_R1 FAILED!
Test Case group_sampe_branch-instructions_cycles:pp_and_branch-instructions=
_cycles:pp_instructions_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_branch-instructions_cycles:pp_instructions_and_branch=
-instructions_cycles:pp_instructions_HAS_FIX_NO_NMI_R1 FAILED!
Test Case sampe_branch-misses_ref-cycles_cycles:p_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_branch-misses_ref-cycles_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_ref-cycles_cycles:p_u_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_branch-misses_cycles:p_k_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_branch-misses_ref-cycles_and_ref-cycles_cycles:p_NO_F=
IX_HAS_NMI_R0 FAILED!
Test Case group_sampe_branch-misses_ref-cycles_cycles:p_NO_FIX_HAS_NMI_R0 F=
AILED!
Test Case group_sampe_branch-misses_ref-cycles_and_branch-misses_ref-cycles=
_cycles:p_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_branch-misses_ref-cycles_cycles:p_and_branch-misses_r=
ef-cycles_cycles:p_NO_FIX_HAS_NMI_R0 FAILED!
Test Case sampe_branch-misses_ref-cycles_cycles:p_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_branch-misses_ref-cycles_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_ref-cycles_cycles:p_u_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_branch-misses_cycles:p_k_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_branch-misses_ref-cycles_and_ref-cycles_cycles:p_HAS_=
FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_branch-misses_ref-cycles_cycles:p_HAS_FIX_NO_NMI_R0 F=
AILED!
Test Case group_sampe_branch-misses_ref-cycles_and_branch-misses_ref-cycles=
_cycles:p_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_branch-misses_ref-cycles_cycles:p_and_branch-misses_r=
ef-cycles_cycles:p_HAS_FIX_NO_NMI_R0 FAILED!
perf hardware cache event sample group test
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
expr: division by zero
Thu May 20 09:10:49 UTC 2021
0 test cases pass for perf_hw_cache_event_sample_group test. 0 test cases f=
ail for perf_hw_cache_event_sample_group test.
perf kernel cpu PMU event sample group test
Thu May 20 09:11:03 UTC 2021
0 test cases pass for perf_pmu_event_sample_group test. 32 test cases fail =
for perf_pmu_event_sample_group test.
Test Case sampe_cpu/mem-loads/pp_cpu/mem-stores/_cpu/cpu-cycles/_NO_FIX_HAS=
_NMI_R4 FAILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/mem-stores/_NO_FIX_HAS_NMI_R4 FA=
ILED!
Test Case group_sampe_cpu/mem-stores/_cpu/cpu-cycles/_u_NO_FIX_HAS_NMI_R4 F=
AILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/cpu-cycles/_k_NO_FIX_HAS_NMI_R4 =
FAILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/mem-stores/_and_cpu/mem-stores/_=
cpu/cpu-cycles/_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/mem-stores/_cpu/cpu-cycles/_NO_F=
IX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/mem-stores/_and_cpu/mem-loads/pp=
_cpu/mem-stores/_cpu/cpu-cycles/_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/mem-stores/_cpu/cpu-cycles/_and_=
cpu/mem-loads/pp_cpu/mem-stores/_cpu/cpu-cycles/_NO_FIX_HAS_NMI_R4 FAILED!
Test Case sampe_cpu/mem-loads/pp_cpu/mem-stores/_cpu/cpu-cycles/_HAS_FIX_NO=
_NMI_R4 FAILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/mem-stores/_HAS_FIX_NO_NMI_R4 FA=
ILED!
Test Case group_sampe_cpu/mem-stores/_cpu/cpu-cycles/_u_HAS_FIX_NO_NMI_R4 F=
AILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/cpu-cycles/_k_HAS_FIX_NO_NMI_R4 =
FAILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/mem-stores/_and_cpu/mem-stores/_=
cpu/cpu-cycles/_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/mem-stores/_cpu/cpu-cycles/_HAS_=
FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/mem-stores/_and_cpu/mem-loads/pp=
_cpu/mem-stores/_cpu/cpu-cycles/_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/mem-loads/pp_cpu/mem-stores/_cpu/cpu-cycles/_and_=
cpu/mem-loads/pp_cpu/mem-stores/_cpu/cpu-cycles/_HAS_FIX_NO_NMI_R4 FAILED!
Test Case sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_cpu/el-start/_NO_FIX_HAS_=
NMI_R3 FAILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_NO_FIX_HAS_NMI_R3 F=
AILED!
Test Case group_sampe_cpu/cpu-cycles/p_cpu/el-start/_u_NO_FIX_HAS_NMI_R3 FA=
ILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/el-start/_k_NO_FIX_HAS_NMI_R3 FA=
ILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_and_cpu/cpu-cycles/=
p_cpu/el-start/_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_cpu/el-start/_NO_FI=
X_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_and_cpu/tx-conflict=
/_cpu/cpu-cycles/p_cpu/el-start/_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_cpu/el-start/_and_c=
pu/tx-conflict/_cpu/cpu-cycles/p_cpu/el-start/_NO_FIX_HAS_NMI_R3 FAILED!
Test Case sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_cpu/el-start/_HAS_FIX_NO_=
NMI_R3 FAILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_HAS_FIX_NO_NMI_R3 F=
AILED!
Test Case group_sampe_cpu/cpu-cycles/p_cpu/el-start/_u_HAS_FIX_NO_NMI_R3 FA=
ILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/el-start/_k_HAS_FIX_NO_NMI_R3 FA=
ILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_and_cpu/cpu-cycles/=
p_cpu/el-start/_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_cpu/el-start/_HAS_F=
IX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_and_cpu/tx-conflict=
/_cpu/cpu-cycles/p_cpu/el-start/_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/tx-conflict/_cpu/cpu-cycles/p_cpu/el-start/_and_c=
pu/tx-conflict/_cpu/cpu-cycles/p_cpu/el-start/_HAS_FIX_NO_NMI_R3 FAILED!
perf pebs events sample group test
Thu May 20 09:11:38 UTC 2021
0 test cases pass for pebs_event_sample_group test. 80 test cases fail for =
pebs_event_sample_group test.
Test Case sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/umask=
=3D0x02,event=3D0xc0/pp_cpu/umask=3D0x02,event=3D0xd2/pp_NO_FIX_HAS_NMI_R4 =
FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xc0/pp_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xc0/pp_cpu/umask=3D0x02,eve=
nt=3D0xd2/pp_u_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xd2/pp_k_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xc0/pp_and_cpu/umask=3D0x02,event=3D0xc0/pp_cpu/umask=
=3D0x02,event=3D0xd2/pp_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xc0/pp_cpu/umask=3D0x02,event=3D0xd2/pp_NO_FIX_HAS_NM=
I_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xc0/pp_and_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0=
x12/pp_cpu/umask=3D0x02,event=3D0xc0/pp_cpu/umask=3D0x02,event=3D0xd2/pp_NO=
_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xc0/pp_cpu/umask=3D0x02,event=3D0xd2/pp_and_cpu/umask=
=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/umask=3D0x02,event=3D0xc0/pp_cp=
u/umask=3D0x02,event=3D0xd2/pp_NO_FIX_HAS_NMI_R4 FAILED!
Test Case sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/umask=
=3D0x02,event=3D0xc0/pp_cpu/umask=3D0x02,event=3D0xd2/pp_HAS_FIX_NO_NMI_R4 =
FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xc0/pp_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xc0/pp_cpu/umask=3D0x02,eve=
nt=3D0xd2/pp_u_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xd2/pp_k_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xc0/pp_and_cpu/umask=3D0x02,event=3D0xc0/pp_cpu/umask=
=3D0x02,event=3D0xd2/pp_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xc0/pp_cpu/umask=3D0x02,event=3D0xd2/pp_HAS_FIX_NO_NM=
I_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xc0/pp_and_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0=
x12/pp_cpu/umask=3D0x02,event=3D0xc0/pp_cpu/umask=3D0x02,event=3D0xd2/pp_HA=
S_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/=
umask=3D0x02,event=3D0xc0/pp_cpu/umask=3D0x02,event=3D0xd2/pp_and_cpu/umask=
=3D0x01,event=3D0xc6,frontend=3D0x12/pp_cpu/umask=3D0x02,event=3D0xc0/pp_cp=
u/umask=3D0x02,event=3D0xd2/pp_HAS_FIX_NO_NMI_R4 FAILED!
Test Case sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,event=3D0=
xc4/pp_cpu/umask=3D0x08,event=3D0xd2/pp_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,eve=
nt=3D0xc4/pp_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x04,event=3D0xc4/pp_cpu/umask=3D0x08,eve=
nt=3D0xd2/pp_u_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x08,eve=
nt=3D0xd2/pp_k_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,eve=
nt=3D0xc4/pp_and_cpu/umask=3D0x04,event=3D0xc4/pp_cpu/umask=3D0x08,event=3D=
0xd2/pp_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,eve=
nt=3D0xc4/pp_cpu/umask=3D0x08,event=3D0xd2/pp_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,eve=
nt=3D0xc4/pp_and_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,event=3D=
0xc4/pp_cpu/umask=3D0x08,event=3D0xd2/pp_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,eve=
nt=3D0xc4/pp_cpu/umask=3D0x08,event=3D0xd2/pp_and_cpu/umask=3D0x02,event=3D=
0xca/pp_cpu/umask=3D0x04,event=3D0xc4/pp_cpu/umask=3D0x08,event=3D0xd2/pp_N=
O_FIX_HAS_NMI_R3 FAILED!
Test Case sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,event=3D0=
xc4/pp_cpu/umask=3D0x08,event=3D0xd2/pp_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,eve=
nt=3D0xc4/pp_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x04,event=3D0xc4/pp_cpu/umask=3D0x08,eve=
nt=3D0xd2/pp_u_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x08,eve=
nt=3D0xd2/pp_k_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,eve=
nt=3D0xc4/pp_and_cpu/umask=3D0x04,event=3D0xc4/pp_cpu/umask=3D0x08,event=3D=
0xd2/pp_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,eve=
nt=3D0xc4/pp_cpu/umask=3D0x08,event=3D0xd2/pp_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,eve=
nt=3D0xc4/pp_and_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,event=3D=
0xc4/pp_cpu/umask=3D0x08,event=3D0xd2/pp_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x04,eve=
nt=3D0xc4/pp_cpu/umask=3D0x08,event=3D0xd2/pp_and_cpu/umask=3D0x02,event=3D=
0xca/pp_cpu/umask=3D0x04,event=3D0xc4/pp_cpu/umask=3D0x08,event=3D0xd2/pp_H=
AS_FIX_NO_NMI_R3 FAILED!
Test Case sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,event=3D0=
xca/pp_cpu/umask=3D0x20,event=3D0xc5/pp_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,eve=
nt=3D0xca/pp_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x20,eve=
nt=3D0xc5/pp_u_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x20,eve=
nt=3D0xc5/pp_k_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,eve=
nt=3D0xca/pp_and_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x20,event=3D=
0xc5/pp_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,eve=
nt=3D0xca/pp_cpu/umask=3D0x20,event=3D0xc5/pp_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,eve=
nt=3D0xca/pp_and_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,event=3D=
0xca/pp_cpu/umask=3D0x20,event=3D0xc5/pp_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,eve=
nt=3D0xca/pp_cpu/umask=3D0x20,event=3D0xc5/pp_and_cpu/umask=3D0x08,event=3D=
0xc4/pp_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x20,event=3D0xc5/pp_N=
O_FIX_HAS_NMI_R2 FAILED!
Test Case sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,event=3D0=
xca/pp_cpu/umask=3D0x20,event=3D0xc5/pp_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,eve=
nt=3D0xca/pp_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x20,eve=
nt=3D0xc5/pp_u_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x20,eve=
nt=3D0xc5/pp_k_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,eve=
nt=3D0xca/pp_and_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x20,event=3D=
0xc5/pp_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,eve=
nt=3D0xca/pp_cpu/umask=3D0x20,event=3D0xc5/pp_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,eve=
nt=3D0xca/pp_and_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,event=3D=
0xca/pp_cpu/umask=3D0x20,event=3D0xc5/pp_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x08,event=3D0xc4/pp_cpu/umask=3D0x02,eve=
nt=3D0xca/pp_cpu/umask=3D0x20,event=3D0xc5/pp_and_cpu/umask=3D0x08,event=3D=
0xc4/pp_cpu/umask=3D0x02,event=3D0xca/pp_cpu/umask=3D0x20,event=3D0xc5/pp_H=
AS_FIX_NO_NMI_R2 FAILED!
Test Case sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,event=3D0=
xd0/pp_cpu/umask=3D0x04,event=3D0xc2/pp_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,eve=
nt=3D0xd0/pp_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x82,event=3D0xd0/pp_cpu/umask=3D0x04,eve=
nt=3D0xc2/pp_u_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x04,eve=
nt=3D0xc2/pp_k_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,eve=
nt=3D0xd0/pp_and_cpu/umask=3D0x82,event=3D0xd0/pp_cpu/umask=3D0x04,event=3D=
0xc2/pp_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,eve=
nt=3D0xd0/pp_cpu/umask=3D0x04,event=3D0xc2/pp_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,eve=
nt=3D0xd0/pp_and_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,event=3D=
0xd0/pp_cpu/umask=3D0x04,event=3D0xc2/pp_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,eve=
nt=3D0xd0/pp_cpu/umask=3D0x04,event=3D0xc2/pp_and_cpu/umask=3D0x40,event=3D=
0xc4/pp_cpu/umask=3D0x82,event=3D0xd0/pp_cpu/umask=3D0x04,event=3D0xc2/pp_N=
O_FIX_HAS_NMI_R1 FAILED!
Test Case sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,event=3D0=
xd0/pp_cpu/umask=3D0x04,event=3D0xc2/pp_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,eve=
nt=3D0xd0/pp_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x82,event=3D0xd0/pp_cpu/umask=3D0x04,eve=
nt=3D0xc2/pp_u_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x04,eve=
nt=3D0xc2/pp_k_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,eve=
nt=3D0xd0/pp_and_cpu/umask=3D0x82,event=3D0xd0/pp_cpu/umask=3D0x04,event=3D=
0xc2/pp_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,eve=
nt=3D0xd0/pp_cpu/umask=3D0x04,event=3D0xc2/pp_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,eve=
nt=3D0xd0/pp_and_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,event=3D=
0xd0/pp_cpu/umask=3D0x04,event=3D0xc2/pp_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x40,event=3D0xc4/pp_cpu/umask=3D0x82,eve=
nt=3D0xd0/pp_cpu/umask=3D0x04,event=3D0xc2/pp_and_cpu/umask=3D0x40,event=3D=
0xc4/pp_cpu/umask=3D0x82,event=3D0xd0/pp_cpu/umask=3D0x04,event=3D0xc2/pp_H=
AS_FIX_NO_NMI_R1 FAILED!
Test Case sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,event=3D0=
xc6,frontend=3D0x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_NO_FIX=
_HAS_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xc6,frontend=3D0x13/pp_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x13/pp_cpu/=
umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_u_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xcd,ldlat=3D0x80/pp_k_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xc6,frontend=3D0x13/pp_and_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0=
x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_NO_FIX_HAS_NMI_R0 FAIL=
ED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xc6,frontend=3D0x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_=
NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xc6,frontend=3D0x13/pp_and_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=
=3D0x01,event=3D0xc6,frontend=3D0x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=
=3D0x80/pp_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xc6,frontend=3D0x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_=
and_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,event=3D0xc6,frontend=
=3D0x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_NO_FIX_HAS_NMI_R0 =
FAILED!
Test Case sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,event=3D0=
xc6,frontend=3D0x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_HAS_FI=
X_NO_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xc6,frontend=3D0x13/pp_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0x13/pp_cpu/=
umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_u_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xcd,ldlat=3D0x80/pp_k_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xc6,frontend=3D0x13/pp_and_cpu/umask=3D0x01,event=3D0xc6,frontend=3D0=
x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_HAS_FIX_NO_NMI_R0 FAIL=
ED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xc6,frontend=3D0x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_=
HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xc6,frontend=3D0x13/pp_and_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=
=3D0x01,event=3D0xc6,frontend=3D0x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=
=3D0x80/pp_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,eve=
nt=3D0xc6,frontend=3D0x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_=
and_cpu/umask=3D0x80,event=3D0xd1/pp_cpu/umask=3D0x01,event=3D0xc6,frontend=
=3D0x13/pp_cpu/umask=3D0x01,event=3D0xcd,ldlat=3D0x80/pp_HAS_FIX_NO_NMI_R0 =
FAILED!
perf all events sample and count group test
Thu May 20 09:12:44 UTC 2021
70 test cases pass for all_event_count_group test. 0 test cases fail for al=
l_event_count_group test.
Test Case count_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0000010080/_c=
pu/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x10,cmask=3D0x6,event=3D0x60/_R4=
 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0000010=
080/_cpu/umask=3D0x01,event=3D0xb0/_R4 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x10,cmask=
=3D0x6,event=3D0x60/_u_R4 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0000010=
080/_cpu/umask=3D0x10,cmask=3D0x6,event=3D0x60/_k_R4 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0000010=
080/_cpu/umask=3D0x01,event=3D0xb0/_and_group_cpu/umask=3D0x01,event=3D0xb0=
/_cpu/umask=3D0x10,cmask=3D0x6,event=3D0x60/_R4 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0000010=
080/_cpu/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x10,cmask=3D0x6,event=3D0x=
60/_R4 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0000010=
080/_cpu/umask=3D0x01,event=3D0xb0/_and_group_cpu/umask=3D0x01,event=3D0xb7=
,offcore_rsp=3D0x0000010080/_cpu/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x1=
0,cmask=3D0x6,event=3D0x60/_k_R4 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0000010=
080/_cpu/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x10,cmask=3D0x6,event=3D0x=
60/_and_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0000010080/_cpu=
/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x10,cmask=3D0x6,event=3D0x60/_R4 P=
ASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x1=
0,cmask=3D0x6,event=3D0x60/_R4 PASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x1=
0,cmask=3D0x6,event=3D0x60/_u_R4 PASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x1=
0,cmask=3D0x6,event=3D0x60/_k_R4 PASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x1=
0,cmask=3D0x6,event=3D0x60/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0=
000010080/_R4 PASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x1=
0,cmask=3D0x6,event=3D0x60/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0=
000010080/_u_R4 PASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb0/_cpu/umask=3D0x1=
0,cmask=3D0x6,event=3D0x60/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0=
000010080/_k_R4 PASS!
Test Case count_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x3fc0028000/_c=
pu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0=
x0400080080/_R3 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x3fc0028=
000/_cpu/umask=3D0x04,event=3D0x85/_R3 PASS!
Test Case count_group_cpu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x0400080080/_u_R3 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x3fc0028=
000/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0400080080/_k_R3 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x3fc0028=
000/_cpu/umask=3D0x04,event=3D0x85/_and_group_cpu/umask=3D0x04,event=3D0x85=
/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0400080080/_R3 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x3fc0028=
000/_cpu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x01,event=3D0xb7,offcore_r=
sp=3D0x0400080080/_R3 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x3fc0028=
000/_cpu/umask=3D0x04,event=3D0x85/_and_group_cpu/umask=3D0x01,event=3D0xb7=
,offcore_rsp=3D0x3fc0028000/_cpu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x0400080080/_k_R3 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x3fc0028=
000/_cpu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x01,event=3D0xb7,offcore_r=
sp=3D0x0400080080/_and_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x=
3fc0028000/_cpu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x01,event=3D0xb7,of=
fcore_rsp=3D0x0400080080/_R3 PASS!
Test Case count_global_group_cpu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x0400080080/_R3 PASS!
Test Case count_global_group_cpu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x0400080080/_u_R3 PASS!
Test Case count_global_group_cpu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x0400080080/_k_R3 PASS!
Test Case count_global_group_cpu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x0400080080/_cpu/umask=3D0x01,event=3D0xb7,of=
fcore_rsp=3D0x3fc0028000/_R3 PASS!
Test Case count_global_group_cpu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x0400080080/_cpu/umask=3D0x01,event=3D0xb7,of=
fcore_rsp=3D0x3fc0028000/_u_R3 PASS!
Test Case count_global_group_cpu/umask=3D0x04,event=3D0x85/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x0400080080/_cpu/umask=3D0x01,event=3D0xb7,of=
fcore_rsp=3D0x3fc0028000/_k_R3 PASS!
Test Case count_cpu/umask=3D0x02,event=3D0xf/_cpu/umask=3D0x12,event=3D0xbe=
/_cpu/umask=3D0x01,event=3D0x28/_R2 PASS!
Test Case count_group_cpu/umask=3D0x02,event=3D0xf/_cpu/umask=3D0x12,event=
=3D0xbe/_R2 PASS!
Test Case count_group_cpu/umask=3D0x12,event=3D0xbe/_cpu/umask=3D0x01,event=
=3D0x28/_u_R2 PASS!
Test Case count_group_cpu/umask=3D0x02,event=3D0xf/_cpu/umask=3D0x01,event=
=3D0x28/_k_R2 PASS!
Test Case count_group_cpu/umask=3D0x02,event=3D0xf/_cpu/umask=3D0x12,event=
=3D0xbe/_and_group_cpu/umask=3D0x12,event=3D0xbe/_cpu/umask=3D0x01,event=3D=
0x28/_R2 PASS!
Test Case count_group_cpu/umask=3D0x02,event=3D0xf/_cpu/umask=3D0x12,event=
=3D0xbe/_cpu/umask=3D0x01,event=3D0x28/_R2 PASS!
Test Case count_group_cpu/umask=3D0x02,event=3D0xf/_cpu/umask=3D0x12,event=
=3D0xbe/_and_group_cpu/umask=3D0x02,event=3D0xf/_cpu/umask=3D0x12,event=3D0=
xbe/_cpu/umask=3D0x01,event=3D0x28/_k_R2 PASS!
Test Case count_group_cpu/umask=3D0x02,event=3D0xf/_cpu/umask=3D0x12,event=
=3D0xbe/_cpu/umask=3D0x01,event=3D0x28/_and_group_cpu/umask=3D0x02,event=3D=
0xf/_cpu/umask=3D0x12,event=3D0xbe/_cpu/umask=3D0x01,event=3D0x28/_R2 PASS!
Test Case count_global_group_cpu/umask=3D0x12,event=3D0xbe/_cpu/umask=3D0x0=
1,event=3D0x28/_R2 PASS!
Test Case count_global_group_cpu/umask=3D0x12,event=3D0xbe/_cpu/umask=3D0x0=
1,event=3D0x28/_u_R2 PASS!
Test Case count_global_group_cpu/umask=3D0x12,event=3D0xbe/_cpu/umask=3D0x0=
1,event=3D0x28/_k_R2 PASS!
Test Case count_global_group_cpu/umask=3D0x12,event=3D0xbe/_cpu/umask=3D0x0=
1,event=3D0x28/_cpu/umask=3D0x02,event=3D0xf/_R2 PASS!
Test Case count_global_group_cpu/umask=3D0x12,event=3D0xbe/_cpu/umask=3D0x0=
1,event=3D0x28/_cpu/umask=3D0x02,event=3D0xf/_u_R2 PASS!
Test Case count_global_group_cpu/umask=3D0x12,event=3D0xbe/_cpu/umask=3D0x0=
1,event=3D0x28/_cpu/umask=3D0x02,event=3D0xf/_k_R2 PASS!
Test Case count_cpu/umask=3D0x04,event=3D0x60/_cpu/umask=3D0x01,event=3D0xb=
7,offcore_rsp=3D0x2004000080/_cpu/umask=3D0xC2,event=3D0x88/_R1 PASS!
Test Case count_group_cpu/umask=3D0x04,event=3D0x60/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x2004000080/_R1 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x2004000=
080/_cpu/umask=3D0xC2,event=3D0x88/_u_R1 PASS!
Test Case count_group_cpu/umask=3D0x04,event=3D0x60/_cpu/umask=3D0xC2,event=
=3D0x88/_k_R1 PASS!
Test Case count_group_cpu/umask=3D0x04,event=3D0x60/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x2004000080/_and_group_cpu/umask=3D0x01,event=3D0xb7=
,offcore_rsp=3D0x2004000080/_cpu/umask=3D0xC2,event=3D0x88/_R1 PASS!
Test Case count_group_cpu/umask=3D0x04,event=3D0x60/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x2004000080/_cpu/umask=3D0xC2,event=3D0x88/_R1 PASS!
Test Case count_group_cpu/umask=3D0x04,event=3D0x60/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x2004000080/_and_group_cpu/umask=3D0x04,event=3D0x60=
/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x2004000080/_cpu/umask=3D0xC=
2,event=3D0x88/_k_R1 PASS!
Test Case count_group_cpu/umask=3D0x04,event=3D0x60/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x2004000080/_cpu/umask=3D0xC2,event=3D0x88/_and_grou=
p_cpu/umask=3D0x04,event=3D0x60/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=
=3D0x2004000080/_cpu/umask=3D0xC2,event=3D0x88/_R1 PASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x=
2004000080/_cpu/umask=3D0xC2,event=3D0x88/_R1 PASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x=
2004000080/_cpu/umask=3D0xC2,event=3D0x88/_u_R1 PASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x=
2004000080/_cpu/umask=3D0xC2,event=3D0x88/_k_R1 PASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x=
2004000080/_cpu/umask=3D0xC2,event=3D0x88/_cpu/umask=3D0x04,event=3D0x60/_R=
1 PASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x=
2004000080/_cpu/umask=3D0xC2,event=3D0x88/_cpu/umask=3D0x04,event=3D0x60/_u=
_R1 PASS!
Test Case count_global_group_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x=
2004000080/_cpu/umask=3D0xC2,event=3D0x88/_cpu/umask=3D0x04,event=3D0x60/_k=
_R1 PASS!
Test Case count_cpu/umask=3D0x01,event=3D0x1f/_cpu/umask=3D0x02,event=3D0x6=
3/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x2000400004/_R0 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0x1f/_cpu/umask=3D0x02,event=
=3D0x63/_R0 PASS!
Test Case count_group_cpu/umask=3D0x02,event=3D0x63/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x2000400004/_u_R0 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0x1f/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x2000400004/_k_R0 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0x1f/_cpu/umask=3D0x02,event=
=3D0x63/_and_group_cpu/umask=3D0x02,event=3D0x63/_cpu/umask=3D0x01,event=3D=
0xb7,offcore_rsp=3D0x2000400004/_R0 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0x1f/_cpu/umask=3D0x02,event=
=3D0x63/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x2000400004/_R0 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0x1f/_cpu/umask=3D0x02,event=
=3D0x63/_and_group_cpu/umask=3D0x01,event=3D0x1f/_cpu/umask=3D0x02,event=3D=
0x63/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x2000400004/_k_R0 PASS!
Test Case count_group_cpu/umask=3D0x01,event=3D0x1f/_cpu/umask=3D0x02,event=
=3D0x63/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x2000400004/_and_grou=
p_cpu/umask=3D0x01,event=3D0x1f/_cpu/umask=3D0x02,event=3D0x63/_cpu/umask=
=3D0x01,event=3D0xb7,offcore_rsp=3D0x2000400004/_R0 PASS!
Test Case count_global_group_cpu/umask=3D0x02,event=3D0x63/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x2000400004/_R0 PASS!
Test Case count_global_group_cpu/umask=3D0x02,event=3D0x63/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x2000400004/_u_R0 PASS!
Test Case count_global_group_cpu/umask=3D0x02,event=3D0x63/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x2000400004/_k_R0 PASS!
Test Case count_global_group_cpu/umask=3D0x02,event=3D0x63/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x2000400004/_cpu/umask=3D0x01,event=3D0x1f/_R=
0 PASS!
Test Case count_global_group_cpu/umask=3D0x02,event=3D0x63/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x2000400004/_cpu/umask=3D0x01,event=3D0x1f/_u=
_R0 PASS!
Test Case count_global_group_cpu/umask=3D0x02,event=3D0x63/_cpu/umask=3D0x0=
1,event=3D0xb7,offcore_rsp=3D0x2000400004/_cpu/umask=3D0x01,event=3D0x1f/_k=
_R0 PASS!
Thu May 20 09:12:44 UTC 2021
0 test cases pass for all_event_sample_group test. 80 test cases fail for a=
ll_event_sample_group test.
Test Case sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000001/_c=
pu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=
=3D0x0100020002/_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x12,event=3D0xd0/pp_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,eve=
nt=3D0xb7,offcore_rsp=3D0x0100020002/_u_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0100020002/_k_NO_FIX_HAS=
_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x12,event=3D0xd0/pp_and_cpu/umask=3D0x12,event=3D0xd0/pp_=
cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0100020002/_NO_FIX_HAS_NMI_R4=
 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,event=3D0xb7,offcore=
_rsp=3D0x0100020002/_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x12,event=3D0xd0/pp_and_cpu/umask=3D0x01,event=3D0xb7,off=
core_rsp=3D0x043c000001/_cpu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,=
event=3D0xb7,offcore_rsp=3D0x0100020002/_NO_FIX_HAS_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,event=3D0xb7,offcore=
_rsp=3D0x0100020002/_and_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c=
000001/_cpu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,event=3D0xb7,offc=
ore_rsp=3D0x0100020002/_NO_FIX_HAS_NMI_R4 FAILED!
Test Case sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000001/_c=
pu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=
=3D0x0100020002/_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x12,event=3D0xd0/pp_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,eve=
nt=3D0xb7,offcore_rsp=3D0x0100020002/_u_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0100020002/_k_HAS_FIX_NO=
_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x12,event=3D0xd0/pp_and_cpu/umask=3D0x12,event=3D0xd0/pp_=
cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x0100020002/_HAS_FIX_NO_NMI_R4=
 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,event=3D0xb7,offcore=
_rsp=3D0x0100020002/_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x12,event=3D0xd0/pp_and_cpu/umask=3D0x01,event=3D0xb7,off=
core_rsp=3D0x043c000001/_cpu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,=
event=3D0xb7,offcore_rsp=3D0x0100020002/_HAS_FIX_NO_NMI_R4 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c000=
001/_cpu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,event=3D0xb7,offcore=
_rsp=3D0x0100020002/_and_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x043c=
000001/_cpu/umask=3D0x12,event=3D0xd0/pp_cpu/umask=3D0x01,event=3D0xb7,offc=
ore_rsp=3D0x0100020002/_HAS_FIX_NO_NMI_R4 FAILED!
Test Case sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=3D0xf=
4/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x007c000002/_NO_FIX_HAS_NMI=
_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=
=3D0xf4/_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x20,event=3D0xf4/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x007c000002/_u_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x007c000002/_k_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=
=3D0xf4/_and_cpu/umask=3D0x20,event=3D0xf4/_cpu/umask=3D0x01,event=3D0xb7,o=
ffcore_rsp=3D0x007c000002/_NO_FIX_HAS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=
=3D0xf4/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x007c000002/_NO_FIX_H=
AS_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=
=3D0xf4/_and_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=3D0xf4/_=
cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x007c000002/_NO_FIX_HAS_NMI_R3=
 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=
=3D0xf4/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x007c000002/_and_cpu/=
umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=3D0xf4/_cpu/umask=3D0x01,=
event=3D0xb7,offcore_rsp=3D0x007c000002/_NO_FIX_HAS_NMI_R3 FAILED!
Test Case sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=3D0xf=
4/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x007c000002/_HAS_FIX_NO_NMI=
_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=
=3D0xf4/_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x20,event=3D0xf4/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x007c000002/_u_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x007c000002/_k_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=
=3D0xf4/_and_cpu/umask=3D0x20,event=3D0xf4/_cpu/umask=3D0x01,event=3D0xb7,o=
ffcore_rsp=3D0x007c000002/_HAS_FIX_NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=
=3D0xf4/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x007c000002/_HAS_FIX_=
NO_NMI_R3 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=
=3D0xf4/_and_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=3D0xf4/_=
cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x007c000002/_HAS_FIX_NO_NMI_R3=
 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=
=3D0xf4/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x007c000002/_and_cpu/=
umask=3D0x01,event=3D0xc3/_cpu/umask=3D0x20,event=3D0xf4/_cpu/umask=3D0x01,=
event=3D0xb7,offcore_rsp=3D0x007c000002/_HAS_FIX_NO_NMI_R3 FAILED!
Test Case sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_cpu/umask=
=3D0x01,event=3D0xb7,offcore_rsp=3D0x10001c0002/_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_NO_F=
IX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xaf/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x10001c0002/_u_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x01,event=3D0xb7,offco=
re_rsp=3D0x10001c0002/_k_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_and_=
cpu/umask=3D0x80,event=3D0xaf/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D=
0x10001c0002/_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_cpu/=
umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x10001c0002/_NO_FIX_HAS_NMI_R2 FAI=
LED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_and_=
cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_cpu/umask=3D0x01,event=3D0=
xb7,offcore_rsp=3D0x10001c0002/_NO_FIX_HAS_NMI_R2 FAILED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_cpu/=
umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x10001c0002/_and_cpu/event=3D0xc4/=
_cpu/umask=3D0x80,event=3D0xaf/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=
=3D0x10001c0002/_NO_FIX_HAS_NMI_R2 FAILED!
Test Case sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_cpu/umask=
=3D0x01,event=3D0xb7,offcore_rsp=3D0x10001c0002/_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_HAS_=
FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0xaf/_cpu/umask=3D0x01,event=
=3D0xb7,offcore_rsp=3D0x10001c0002/_u_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x01,event=3D0xb7,offco=
re_rsp=3D0x10001c0002/_k_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_and_=
cpu/umask=3D0x80,event=3D0xaf/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D=
0x10001c0002/_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_cpu/=
umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x10001c0002/_HAS_FIX_NO_NMI_R2 FAI=
LED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_and_=
cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_cpu/umask=3D0x01,event=3D0=
xb7,offcore_rsp=3D0x10001c0002/_HAS_FIX_NO_NMI_R2 FAILED!
Test Case group_sampe_cpu/event=3D0xc4/_cpu/umask=3D0x80,event=3D0xaf/_cpu/=
umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x10001c0002/_and_cpu/event=3D0xc4/=
_cpu/umask=3D0x80,event=3D0xaf/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=
=3D0x10001c0002/_HAS_FIX_NO_NMI_R2 FAILED!
Test Case sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=3D0xbc=
/_cpu/umask=3D0x42,event=3D0x36/_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=
=3D0xbc/_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x28,event=3D0xbc/_cpu/umask=3D0x42,event=
=3D0x36/_u_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x42,event=
=3D0x36/_k_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=
=3D0xbc/_and_cpu/umask=3D0x28,event=3D0xbc/_cpu/umask=3D0x42,event=3D0x36/_=
NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=
=3D0xbc/_cpu/umask=3D0x42,event=3D0x36/_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=
=3D0xbc/_and_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=3D0xbc/_c=
pu/umask=3D0x42,event=3D0x36/_NO_FIX_HAS_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=
=3D0xbc/_cpu/umask=3D0x42,event=3D0x36/_and_cpu/umask=3D0x80,event=3D0x8/_c=
pu/umask=3D0x28,event=3D0xbc/_cpu/umask=3D0x42,event=3D0x36/_NO_FIX_HAS_NMI=
_R1 FAILED!
Test Case sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=3D0xbc=
/_cpu/umask=3D0x42,event=3D0x36/_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=
=3D0xbc/_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x28,event=3D0xbc/_cpu/umask=3D0x42,event=
=3D0x36/_u_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x42,event=
=3D0x36/_k_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=
=3D0xbc/_and_cpu/umask=3D0x28,event=3D0xbc/_cpu/umask=3D0x42,event=3D0x36/_=
HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=
=3D0xbc/_cpu/umask=3D0x42,event=3D0x36/_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=
=3D0xbc/_and_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=3D0xbc/_c=
pu/umask=3D0x42,event=3D0x36/_HAS_FIX_NO_NMI_R1 FAILED!
Test Case group_sampe_cpu/umask=3D0x80,event=3D0x8/_cpu/umask=3D0x28,event=
=3D0xbc/_cpu/umask=3D0x42,event=3D0x36/_and_cpu/umask=3D0x80,event=3D0x8/_c=
pu/umask=3D0x28,event=3D0xbc/_cpu/umask=3D0x42,event=3D0x36/_HAS_FIX_NO_NMI=
_R1 FAILED!
Test Case sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040100/_c=
pu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=3D0x80,e=
vent=3D0xcc/_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_NO_FIX_HAS_N=
MI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8=
000/_cpu/umask=3D0x80,event=3D0xcc/_u_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x80,event=3D0xcc/_k_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_and_cpu/umas=
k=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=3D0x80,event=3D=
0xcc/_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=3D=
0x80,event=3D0xcc/_NO_FIX_HAS_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_and_cpu/umas=
k=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040100/_cpu/umask=3D0x01,event=3D=
0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=3D0x80,event=3D0xcc/_NO_FIX_HAS_=
NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=3D=
0x80,event=3D0xcc/_and_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x100004=
0100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=
=3D0x80,event=3D0xcc/_NO_FIX_HAS_NMI_R0 FAILED!
Test Case sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040100/_c=
pu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=3D0x80,e=
vent=3D0xcc/_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_HAS_FIX_NO_N=
MI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8=
000/_cpu/umask=3D0x80,event=3D0xcc/_u_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x80,event=3D0xcc/_k_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_and_cpu/umas=
k=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=3D0x80,event=3D=
0xcc/_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=3D=
0x80,event=3D0xcc/_HAS_FIX_NO_NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_and_cpu/umas=
k=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040100/_cpu/umask=3D0x01,event=3D=
0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=3D0x80,event=3D0xcc/_HAS_FIX_NO_=
NMI_R0 FAILED!
Test Case group_sampe_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x1000040=
100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=3D=
0x80,event=3D0xcc/_and_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x100004=
0100/_cpu/umask=3D0x01,event=3D0xb7,offcore_rsp=3D0x20001c8000/_cpu/umask=
=3D0x80,event=3D0xcc/_HAS_FIX_NO_NMI_R0 FAILED!
Don't do offcore test. NO EXTRA_REG support
2021-05-20 09:12:45 ./ht_leak_test/run.sh
SKIP for ht_leak_test test
2021-05-20 09:12:45 ./lbr_test/run.sh
Thu May 20 09:13:00 UTC 2021
0 test cases pass for lbr_test test. 24 test cases fail for lbr_test test.
Test Case instructions_any_tchain_edit_without_NMI_1_R2 FAILED!
Test Case instructions_any_ret_ind_call_tchain_edit_without_NMI_1_R2 FAILED!
Test Case instructions_any_call_tchain_edit_without_NMI_1_R2 FAILED!
Test Case instructions_any_ret_tchain_edit_without_NMI_1_R2 FAILED!
Test Case instructions_ind_call_tchain_edit_without_NMI_1_R2 FAILED!
Test Case instructions_any_ind_call_tchain_edit_without_NMI_1_R2 FAILED!
Test Case instructions_any_ret_ind_call_tchain_edit_without_NMI_1_R2 FAILED!
Test Case instructions_any_call_ind_call_u_tchain_edit_without_NMI_1_R2 FAI=
LED!
Test Case instructions_any_call_ind_call_k_tchain_edit_without_NMI_1_R2 FAI=
LED!
Test Case instructions_any_any_call_ind_call_u_k_tchain_edit_without_NMI_1_=
R2 FAILED!
Test Case instructions_call_chain_fp_tchain_edit_without_NMI_1_R2 FAILED!
Test Case instructions_call_chain_lbr_tchain_edit_without_NMI_1_R2 FAILED!
Test Case instructions_any_tchain_edit_with_NMI_0_R1 FAILED!
Test Case instructions_any_ret_ind_call_tchain_edit_with_NMI_0_R1 FAILED!
Test Case instructions_any_call_tchain_edit_with_NMI_0_R1 FAILED!
Test Case instructions_any_ret_tchain_edit_with_NMI_0_R1 FAILED!
Test Case instructions_ind_call_tchain_edit_with_NMI_0_R1 FAILED!
Test Case instructions_any_ind_call_tchain_edit_with_NMI_0_R1 FAILED!
Test Case instructions_any_ret_ind_call_tchain_edit_with_NMI_0_R1 FAILED!
Test Case instructions_any_call_ind_call_u_tchain_edit_with_NMI_0_R1 FAILED!
Test Case instructions_any_call_ind_call_k_tchain_edit_with_NMI_0_R1 FAILED!
Test Case instructions_any_any_call_ind_call_u_k_tchain_edit_with_NMI_0_R1 =
FAILED!
Test Case instructions_call_chain_fp_tchain_edit_with_NMI_0_R1 FAILED!
Test Case instructions_call_chain_lbr_tchain_edit_with_NMI_0_R1 FAILED!
2021-05-20 09:13:03 ./mem_addr_profile_test/run.sh
SKIP for mem_addr_profile_test test
2021-05-20 09:13:03 ./msr_test/run.sh
Thu May 20 09:13:13 UTC 2021
1 test cases pass for msr_test test. 0 test cases fail for msr_test test.
Test Case cpu_util_full PASS!
2021-05-20 09:13:14 ./pebs_test/run.sh
Thu May 20 09:13:14 UTC 2021
0 test cases pass for pebs_test test. 0 test cases fail for pebs_test test.
2021-05-20 09:13:14 ./rapl_test/run.sh
SKIP for rapl_test test
2021-05-20 09:13:14 ./rdpmc_test/run.sh
Thu May 20 09:13:15 UTC 2021
4 test cases pass for rdpmc_test test. 0 test cases fail for rdpmc_test tes=
t.
Test Case instructions_branches_sin-lib PASS!
Test Case instructions_branches_triad_loop-lib PASS!
Test Case instructions_branches_million-instruction-lib PASS!
Test Case instructions_branches_branches-lib PASS!
2021-05-20 09:13:15 ./single_event_test/run.sh
ROUND 1: perf hardware event count test
ROUND 1: perf hardware cache event count test
ROUND 1: perf kernel cpu PMU event count test
ROUND 1: perf hardware event sample test
ROUND 1: perf hardware cache event sample test
ROUND 1: perf kernel cpu PMU event sample test
Disable NMI watchdog for special sample test
ROUND 2: perf hardware event count test
ROUND 2: perf hardware cache event count test
ROUND 2: perf kernel cpu PMU event count test
ROUND 2: perf hardware event sample test
ROUND 2: perf hardware cache event sample test
ROUND 2: perf kernel cpu PMU event sample test
Enable NMI watchdog
Thu May 20 09:14:12 UTC 2021
16 test cases pass for hw_event_count test. 0 test cases fail for hw_event_=
count test.
Test Case hardware_event_count_test_branch-instructions_1_2 PASS!
Test Case hardware_event_count_test_branch-misses_1_2 PASS!
Test Case hardware_event_count_test_bus-cycles_1_2 PASS!
Test Case hardware_event_count_test_cache-misses_1_2 PASS!
Test Case hardware_event_count_test_cache-references_1_2 PASS!
Test Case hardware_event_count_test_cpu-cycles_1_2 PASS!
Test Case hardware_event_count_test_instructions_1_2 PASS!
Test Case hardware_event_count_test_ref-cycles_1_2 PASS!
Test Case hardware_event_count_test_branch-instructions_2_1 PASS!
Test Case hardware_event_count_test_branch-misses_2_1 PASS!
Test Case hardware_event_count_test_bus-cycles_2_1 PASS!
Test Case hardware_event_count_test_cache-misses_2_1 PASS!
Test Case hardware_event_count_test_cache-references_2_1 PASS!
Test Case hardware_event_count_test_cpu-cycles_2_1 PASS!
Test Case hardware_event_count_test_instructions_2_1 PASS!
Test Case hardware_event_count_test_ref-cycles_2_1 PASS!
Thu May 20 09:14:12 UTC 2021
0 test cases pass for hw_cache_event_count test. 0 test cases fail for hw_c=
ache_event_count test.
Thu May 20 09:14:12 UTC 2021
44 test cases pass for pmu_event_count test. 0 test cases fail for pmu_even=
t_count test.
Test Case cpu_PMU_event_count_test_cpu/branch-instructions/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/branch-misses/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/bus-cycles/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/cache-misses/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/cache-references/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/cpu-cycles/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/cycles-ct/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/cycles-t/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/el-abort/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/el-capacity/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/el-commit/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/el-conflict/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/el-start/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/instructions/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/mem-loads/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/mem-stores/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/ref-cycles/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/tx-abort/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/tx-capacity/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/tx-commit/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/tx-conflict/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/tx-start/_1_2 PASS!
Test Case cpu_PMU_event_count_test_cpu/branch-instructions/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/branch-misses/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/bus-cycles/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/cache-misses/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/cache-references/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/cpu-cycles/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/cycles-ct/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/cycles-t/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/el-abort/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/el-capacity/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/el-commit/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/el-conflict/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/el-start/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/instructions/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/mem-loads/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/mem-stores/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/ref-cycles/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/tx-abort/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/tx-capacity/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/tx-commit/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/tx-conflict/_2_1 PASS!
Test Case cpu_PMU_event_count_test_cpu/tx-start/_2_1 PASS!
Thu May 20 09:14:12 UTC 2021
0 test cases pass for hw_event_sample test. 20 test cases fail for hw_event=
_sample test.
Test Case hardware_event_sample_test_branch-instructions_1_2 FAILED!
Test Case hardware_event_sample_test_branch-misses_1_2 FAILED!
Test Case hardware_event_sample_test_bus-cycles_1_2 FAILED!
Test Case hardware_event_sample_test_cache-misses_1_2 FAILED!
Test Case hardware_event_sample_test_cache-references_1_2 FAILED!
Test Case hardware_event_sample_test_cpu-cycles_1_2 FAILED!
Test Case hardware_event_sample_test_instructions_1_2 FAILED!
Test Case hardware_event_sample_test_ref-cycles_1_2 FAILED!
Test Case hardware_event_sample_test_cycles:p_1_2 FAILED!
Test Case hardware_event_sample_test_cycles:pp_1_2 FAILED!
Test Case hardware_event_sample_test_branch-instructions_2_1 FAILED!
Test Case hardware_event_sample_test_branch-misses_2_1 FAILED!
Test Case hardware_event_sample_test_bus-cycles_2_1 FAILED!
Test Case hardware_event_sample_test_cache-misses_2_1 FAILED!
Test Case hardware_event_sample_test_cache-references_2_1 FAILED!
Test Case hardware_event_sample_test_cpu-cycles_2_1 FAILED!
Test Case hardware_event_sample_test_instructions_2_1 FAILED!
Test Case hardware_event_sample_test_ref-cycles_2_1 FAILED!
Test Case hardware_event_sample_test_cycles:p_2_1 FAILED!
Test Case hardware_event_sample_test_cycles:pp_2_1 FAILED!
Thu May 20 09:14:12 UTC 2021
0 test cases pass for hw_cache_event_sample test. 0 test cases fail for hw_=
cache_event_sample test.
Thu May 20 09:14:12 UTC 2021
0 test cases pass for pmu_event_sample test. 50 test cases fail for pmu_eve=
nt_sample test.
Test Case cpu_PMU_event_sample_test_cpu/branch-instructions/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/branch-misses/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/bus-cycles/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cache-misses/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cache-references/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cpu-cycles/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cpu-cycles/p_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cpu-cycles/pp_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cycles-t/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/el-abort/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/el-capacity/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/el-commit/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/el-conflict/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/el-start/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/instructions/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/mem-loads/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/mem-loads/pp_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/mem-stores/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/mem-stores/pp_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/ref-cycles/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/tx-abort/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/tx-capacity/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/tx-commit/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/tx-conflict/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/tx-start/_1_2 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/branch-instructions/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/branch-misses/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/bus-cycles/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cache-misses/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cache-references/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cpu-cycles/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cpu-cycles/p_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cpu-cycles/pp_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/cycles-t/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/el-abort/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/el-capacity/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/el-commit/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/el-conflict/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/el-start/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/instructions/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/mem-loads/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/mem-loads/pp_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/mem-stores/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/mem-stores/pp_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/ref-cycles/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/tx-abort/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/tx-capacity/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/tx-commit/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/tx-conflict/_2_1 FAILED!
Test Case cpu_PMU_event_sample_test_cpu/tx-start/_2_1 FAILED!
2021-05-20 09:14:13 ./skid_test/run.sh
Thu May 20 09:14:17 UTC 2021
4 test cases pass for skid_test test. 2 test cases fail for skid_test test.
Test Case BR_INST_RETIRED.ALL_BRANCHES_PEBS_triad_loop_with_NMI FAILED!
Test Case MEM_LOAD_RETIRED.L2_HIT_dtlb_with_NMI PASS!
Test Case MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_dtlb_with_NMI PASS!
Test Case BR_INST_RETIRED.ALL_BRANCHES_PEBS_triad_loop_without_NMI_fixed_pe=
riod FAILED!
Test Case MEM_LOAD_RETIRED.L2_HIT_dtlb_without_NMI_fixed_period PASS!
Test Case MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_dtlb_without_NMI_fixed_period=
 PASS!
2021-05-20 09:14:18 ./topdown_test/run.sh
Cannot find topdown event list. SKIP for topdown_test test
Thu May 20 09:14:18 UTC 2021
0 test cases pass for topdown_test test. 0 test cases fail for topdown_test=
 test.
2021-05-20 09:14:18 ./tsx_test/run.sh
SKIP for tsx_test test
2021-05-20 09:14:18 ./uncore_test/run.sh
SKIP for uncore_test test
2021-05-20 09:14:18 ./uncore_topology_test/run.sh
SKIP for uncore_topology_test test
2021-05-20 09:14:18 ./virtulization_test/run.sh
SKIP for virtulization_test test

--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/perf-test.yaml
suite: perf-test
testcase: perf-test
category: functional
type: lkp
perf-test: 
job_origin: perf-test.yaml

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-kbl-d01
tbox_group: lkp-kbl-d01
kconfig: x86_64-rhel-8.3
submit_id: 60a5ae3c98f6b35d5816e176
job_file: "/lkp/jobs/scheduled/lkp-kbl-d01/perf-test-lkp-ucode=0xde-debian-10.4-x86_64-20200603.cgz-71d7924b3e8acaca6a3b0fc3261170031ada3b70-20210520-23896-16kktud-0.yaml"
id: 5f37a1c9b3601fdce6b458375f86b3b8bc2da7c9
queuer_version: "/lkp-src"

#! hosts/lkp-kbl-d01
model: Kaby Lake
nr_node: 1
nr_cpu: 8
memory: 32G
nr_sdd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/ata-ST1000DM003-1CH162_Z1D3X32H-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2KW010X6_BTLT630000X61P0FGN-part2"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2KW010X6_BTLT630000X61P0FGN-part1"
brand: Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz

#! include/category/functional
kmsg: 
heartbeat: 
meminfo: 

#! include/perf-test
need_linux_perf: true

#! include/queue/cyclic
commit: 71d7924b3e8acaca6a3b0fc3261170031ada3b70

#! include/testbox/lkp-kbl-d01
ucode: '0xde'
need_kconfig_hw:
- CONFIG_E1000E=y
- CONFIG_SATA_AHCI
bisect_dmesg: true
enqueue_time: 2021-05-20 08:33:01.006762790 +08:00
_id: 60a5ae3c98f6b35d5816e176
_rt: "/result/perf-test/lkp-ucode=0xde/lkp-kbl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/71d7924b3e8acaca6a3b0fc3261170031ada3b70"

#! schedule options
user: lkp
compiler: gcc-9
LKP_SERVER: internal-lkp-server
head_commit: fe596c3a53e1baccc0aa17b00fab3636615c353d
base_commit: d07f6ca923ea0927a1024dfccafc5b53b61cfecc
branch: linux-devel/devel-hourly-20210520-010430
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/perf-test/lkp-ucode=0xde/lkp-kbl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/71d7924b3e8acaca6a3b0fc3261170031ada3b70/0"
scheduler_version: "/lkp/lkp/.src-20210519-183212"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-kbl-d01/perf-test-lkp-ucode=0xde-debian-10.4-x86_64-20200603.cgz-71d7924b3e8acaca6a3b0fc3261170031ada3b70-20210520-23896-16kktud-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- branch=linux-devel/devel-hourly-20210520-010430
- commit=71d7924b3e8acaca6a3b0fc3261170031ada3b70
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-9/71d7924b3e8acaca6a3b0fc3261170031ada3b70/vmlinuz-5.13.0-rc1-00016-g71d7924b3e8a
- max_uptime=2100
- RESULT_ROOT=/result/perf-test/lkp-ucode=0xde/lkp-kbl-d01/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/71d7924b3e8acaca6a3b0fc3261170031ada3b70/0
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
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/71d7924b3e8acaca6a3b0fc3261170031ada3b70/modules.cgz"
linux_perf_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-9/71d7924b3e8acaca6a3b0fc3261170031ada3b70/linux-perf.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20201211.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf-test_20210508.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-test-x86_64-git-1_20210508.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20210222.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20210519-183212/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.13.0-rc2

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-9/71d7924b3e8acaca6a3b0fc3261170031ada3b70/vmlinuz-5.13.0-rc1-00016-g71d7924b3e8a"
dequeue_time: 2021-05-20 08:34:06.370085127 +08:00
job_state: finished
loadavg: 1.05 0.87 0.51 1/153 11868
start_time: '1621470973'
end_time: '1621472097'
version: "/lkp/lkp/.src-20210519-183246:dae55264-dirty:b6d608ba2"

--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

 "make" "ARCH=" "DEBUG=1" "EXTRA_CFLAGS=-fno-omit-frame-pointer -fsanitize=undefined -fsanitize=address" "-C" "/usr/src/linux-perf-x86_64-rhel-8.3-71d7924b3e8acaca6a3b0fc3261170031ada3b70/tools/perf"
 "./breakpoint_test/run.sh"
 "./calibrator_test/run.sh"
 "./calibrator_uncore_test/run.sh"
 "./event_list_test/run.sh"
 "./events_relation_test/run.sh"
 "./freq_test/run.sh"
 "./group_test/run.sh"
 "./ht_leak_test/run.sh"
 "./lbr_test/run.sh"
 "./mem_addr_profile_test/run.sh"
 "./msr_test/run.sh"
 "./pebs_test/run.sh"
 "./rapl_test/run.sh"
 "./rdpmc_test/run.sh"
 "./single_event_test/run.sh"
 "./skid_test/run.sh"
 "./topdown_test/run.sh"
 "./tsx_test/run.sh"
 "./uncore_test/run.sh"
 "./uncore_topology_test/run.sh"
 "./virtulization_test/run.sh"

--4SFOXa2GPu3tIq4H--
