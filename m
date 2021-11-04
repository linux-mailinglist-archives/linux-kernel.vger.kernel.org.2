Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C25D444F04
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 07:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhKDGpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 02:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhKDGpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:45:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEBEC061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 23:42:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z65-20020a256544000000b005c21b35717dso7442692ybb.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 23:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xO+c0biOEpKmGDxBMmCaEGaPTmit6LThJYdpx/RxS0s=;
        b=tXDZFVGq63LLmVOQk2wSS/xad5RvsNEGK9Nxi6i3Yv20W6NKtthd+qipiWJ/btuRRZ
         PHEV5RSQBQB3EkiSISCAGhoh/RW17+H7A1CIt+o3KPT8bVxVwiOFtWr6hNYoUqmQPS3A
         TF/27KZxY7jDLEIj8rtSUBCokMlqDBm+jAgkX+d2h0j4aKVNBaMxyI1VQu7cbegS3g31
         NM4k1NKwLweGVPo+gw6/i3U+lROmbypFHeHmy7hXj2yeOsh3CvBMJ2x1G5BUCjc0Uf9R
         h7RxQ475Ht5MjpRdjTCxIzkVM1HKeJmLVbY4GcYTrSSeoQH5uwwfrnPVVwS2Uz90/UUL
         2upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xO+c0biOEpKmGDxBMmCaEGaPTmit6LThJYdpx/RxS0s=;
        b=KNb81bRBOxV2IYu3qTgsvKipsVuWtjQwrZpB7fiqO1rGwdSwOu4MjPgQyU9i8ZBZmx
         H8ZGZlZTXa/wJoGxR4AlXasHUHoWImx3p0bphEFd1FnpJaNY1Hv87RuoqCgCnoGoXH1h
         xDDfMAGIIijjtiw/WaMwjCPTDIcqPe0Wi+1bpYWe+kQK0EUtVYYdamdkXK68dSb7qs+Y
         6CSJh1NEyz2pycL1w9d/kKFtrdUi/zECXbOAzMYGxvQipGeuk06nFRsttHuBhMSGWq4b
         2LFfkdTtySq2vp/Mtj3JrvhAcCISgQ7V/mx1RZoAdqGlm7En+AeQoK0wJkWUf0Cnygdl
         tirA==
X-Gm-Message-State: AOAM530nLWvVHOhQEbwfO9H678tOR99l+QY5Cg6VZGBh0DZpCO9ahWLN
        R6Gb/68OHn0h0uA4dFPDtI+ondnct0dV
X-Google-Smtp-Source: ABdhPJw4A/EfILkkDgHfNYRKGiCkT0ylPeIBQPTHN0KNygWROoh/Ng8PWP8uss4EtOiUZodohE1hWiYZl9pU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8ce:af84:2510:3f29])
 (user=irogers job=sendgmr) by 2002:a25:acdd:: with SMTP id
 x29mr52606501ybd.96.1636008141718; Wed, 03 Nov 2021 23:42:21 -0700 (PDT)
Date:   Wed,  3 Nov 2021 23:41:49 -0700
In-Reply-To: <20211104064208.3156807-1-irogers@google.com>
Message-Id: <20211104064208.3156807-4-irogers@google.com>
Mime-Version: 1.0
References: <20211104064208.3156807-1-irogers@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v3 03/22] perf test: Make each test/suite its own struct.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By switching to an array of pointers to tests (later to be suites)
the definition of the tests can be moved to the file containing the
tests.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm/include/arch-tests.h     |   2 +-
 tools/perf/arch/arm/tests/arch-tests.c       |  18 +-
 tools/perf/arch/arm64/include/arch-tests.h   |   2 +-
 tools/perf/arch/arm64/tests/arch-tests.c     |  11 +-
 tools/perf/arch/powerpc/include/arch-tests.h |   2 +-
 tools/perf/arch/powerpc/tests/arch-tests.c   |  11 +-
 tools/perf/arch/x86/include/arch-tests.h     |   2 +-
 tools/perf/arch/x86/tests/arch-tests.c       |  47 ++--
 tools/perf/tests/builtin-test.c              | 273 ++++++++++++-------
 tools/perf/tests/dwarf-unwind.c              |   7 +-
 tools/perf/tests/tests.h                     |   8 +-
 11 files changed, 215 insertions(+), 168 deletions(-)

diff --git a/tools/perf/arch/arm/include/arch-tests.h b/tools/perf/arch/arm/include/arch-tests.h
index c62538052404..37039e80f18b 100644
--- a/tools/perf/arch/arm/include/arch-tests.h
+++ b/tools/perf/arch/arm/include/arch-tests.h
@@ -2,6 +2,6 @@
 #ifndef ARCH_TESTS_H
 #define ARCH_TESTS_H
 
-extern struct test arch_tests[];
+extern struct test *arch_tests[];
 
 #endif
diff --git a/tools/perf/arch/arm/tests/arch-tests.c b/tools/perf/arch/arm/tests/arch-tests.c
index 6848101a855f..5287729026ab 100644
--- a/tools/perf/arch/arm/tests/arch-tests.c
+++ b/tools/perf/arch/arm/tests/arch-tests.c
@@ -3,18 +3,12 @@
 #include "tests/tests.h"
 #include "arch-tests.h"
 
-struct test arch_tests[] = {
+DEFINE_SUITE("Vectors page", vectors_page);
+
+struct test *arch_tests[] = {
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
-	{
-		.desc = "DWARF unwind",
-		.func = test__dwarf_unwind,
-	},
+	&dwarf_unwind,
 #endif
-	{
-		.desc = "Vectors page",
-		.func = test__vectors_page,
-	},
-	{
-		.func = NULL,
-	},
+	&vectors_pages,
+	NULL,
 };
diff --git a/tools/perf/arch/arm64/include/arch-tests.h b/tools/perf/arch/arm64/include/arch-tests.h
index c62538052404..37039e80f18b 100644
--- a/tools/perf/arch/arm64/include/arch-tests.h
+++ b/tools/perf/arch/arm64/include/arch-tests.h
@@ -2,6 +2,6 @@
 #ifndef ARCH_TESTS_H
 #define ARCH_TESTS_H
 
-extern struct test arch_tests[];
+extern struct test *arch_tests[];
 
 #endif
diff --git a/tools/perf/arch/arm64/tests/arch-tests.c b/tools/perf/arch/arm64/tests/arch-tests.c
index 5b1543c98022..bc327048b807 100644
--- a/tools/perf/arch/arm64/tests/arch-tests.c
+++ b/tools/perf/arch/arm64/tests/arch-tests.c
@@ -3,14 +3,9 @@
 #include "tests/tests.h"
 #include "arch-tests.h"
 
-struct test arch_tests[] = {
+struct test *arch_tests[] = {
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
-	{
-		.desc = "DWARF unwind",
-		.func = test__dwarf_unwind,
-	},
+	&dwarf_unwind,
 #endif
-	{
-		.func = NULL,
-	},
+	NULL,
 };
diff --git a/tools/perf/arch/powerpc/include/arch-tests.h b/tools/perf/arch/powerpc/include/arch-tests.h
index c62538052404..37039e80f18b 100644
--- a/tools/perf/arch/powerpc/include/arch-tests.h
+++ b/tools/perf/arch/powerpc/include/arch-tests.h
@@ -2,6 +2,6 @@
 #ifndef ARCH_TESTS_H
 #define ARCH_TESTS_H
 
-extern struct test arch_tests[];
+extern struct test *arch_tests[];
 
 #endif
diff --git a/tools/perf/arch/powerpc/tests/arch-tests.c b/tools/perf/arch/powerpc/tests/arch-tests.c
index 8c3fbd4af817..bc327048b807 100644
--- a/tools/perf/arch/powerpc/tests/arch-tests.c
+++ b/tools/perf/arch/powerpc/tests/arch-tests.c
@@ -3,14 +3,9 @@
 #include "tests/tests.h"
 #include "arch-tests.h"
 
-struct test arch_tests[] = {
+struct test *arch_tests[] = {
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
-	{
-		.desc = "Test dwarf unwind",
-		.func = test__dwarf_unwind,
-	},
+	&dwarf_unwind,
 #endif
-	{
-		.func = NULL,
-	},
+	NULL,
 };
diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
index 9599e7a3f1af..d6db9f72b6af 100644
--- a/tools/perf/arch/x86/include/arch-tests.h
+++ b/tools/perf/arch/x86/include/arch-tests.h
@@ -11,6 +11,6 @@ int test__intel_pt_pkt_decoder(struct test *test, int subtest);
 int test__bp_modify(struct test *test, int subtest);
 int test__x86_sample_parsing(struct test *test, int subtest);
 
-extern struct test arch_tests[];
+extern struct test *arch_tests[];
 
 #endif
diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
index 71aa67367ad6..f5e3195768a4 100644
--- a/tools/perf/arch/x86/tests/arch-tests.c
+++ b/tools/perf/arch/x86/tests/arch-tests.c
@@ -3,39 +3,28 @@
 #include "tests/tests.h"
 #include "arch-tests.h"
 
-struct test arch_tests[] = {
-	{
-		.desc = "x86 rdpmc",
-		.func = test__rdpmc,
-	},
+DEFINE_SUITE("x86 rdpmc", rdpmc);
+#ifdef HAVE_AUXTRACE_SUPPORT
+DEFINE_SUITE("x86 instruction decoder - new instructions", insn_x86);
+DEFINE_SUITE("Intel PT packet decoder", intel_pt_pkt_decoder);
+#endif
+#if defined(__x86_64__)
+DEFINE_SUITE("x86 bp modify", bp_modify);
+#endif
+DEFINE_SUITE("x86 Sample parsing", x86_sample_parsing);
+
+struct test *arch_tests[] = {
+	&rdpmc,
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
-	{
-		.desc = "DWARF unwind",
-		.func = test__dwarf_unwind,
-	},
+	&dwarf_unwind,
 #endif
 #ifdef HAVE_AUXTRACE_SUPPORT
-	{
-		.desc = "x86 instruction decoder - new instructions",
-		.func = test__insn_x86,
-	},
-	{
-		.desc = "Intel PT packet decoder",
-		.func = test__intel_pt_pkt_decoder,
-	},
+	&insn_x86,
+	&intel_pt_pkt_decoder,
 #endif
 #if defined(__x86_64__)
-	{
-		.desc = "x86 bp modify",
-		.func = test__bp_modify,
-	},
+	&bp_modify,
 #endif
-	{
-		.desc = "x86 Sample parsing",
-		.func = test__x86_sample_parsing,
-	},
-	{
-		.func = NULL,
-	},
-
+	&x86_sample_parsing,
+	NULL,
 };
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 820fc1ae2210..b2cbc12a70a2 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -30,29 +30,20 @@
 
 static bool dont_fork;
 
-struct test __weak arch_tests[] = {
-	{
-		.func = NULL,
-	},
+struct test *__weak arch_tests[] = {
+	NULL,
 };
 
-#define DEFINE_SUITE(description, name)		\
-	{					\
-		.desc = description,		\
-		.func = test__##name,		\
-	}
-
-static struct test generic_tests[] = {
-DEFINE_SUITE("vmlinux symtab matches kallsyms", vmlinux_matches_kallsyms),
-DEFINE_SUITE("Detect openat syscall event", openat_syscall_event),
-DEFINE_SUITE("Detect openat syscall event on all cpus", openat_syscall_event_on_all_cpus),
-DEFINE_SUITE("Read samples using the mmap interface", basic_mmap),
-DEFINE_SUITE("Test data source output", mem),
-DEFINE_SUITE("Parse event definition strings", parse_events),
-DEFINE_SUITE("Simple expression parser", expr),
-DEFINE_SUITE("PERF_RECORD_* events & perf_sample fields", PERF_RECORD),
-DEFINE_SUITE("Parse perf pmu format", pmu),
-{
+DEFINE_SUITE("vmlinux symtab matches kallsyms", vmlinux_matches_kallsyms);
+DEFINE_SUITE("Detect openat syscall event", openat_syscall_event);
+DEFINE_SUITE("Detect openat syscall event on all cpus", openat_syscall_event_on_all_cpus);
+DEFINE_SUITE("Read samples using the mmap interface", basic_mmap);
+DEFINE_SUITE("Test data source output", mem);
+DEFINE_SUITE("Parse event definition strings", parse_events);
+DEFINE_SUITE("Simple expression parser", expr);
+DEFINE_SUITE("PERF_RECORD_* events & perf_sample fields", PERF_RECORD);
+DEFINE_SUITE("Parse perf pmu format", pmu);
+static struct test pmu_events = {
 	.desc = "PMU events",
 	.func = test__pmu_events,
 	.subtest = {
@@ -61,33 +52,32 @@ DEFINE_SUITE("Parse perf pmu format", pmu),
 		.get_desc	= test__pmu_events_subtest_get_desc,
 		.skip_reason	= test__pmu_events_subtest_skip_reason,
 	},
-
-},
-DEFINE_SUITE("DSO data read", dso_data),
-DEFINE_SUITE("DSO data cache", dso_data_cache),
-DEFINE_SUITE("DSO data reopen", dso_data_reopen),
-DEFINE_SUITE("Roundtrip evsel->name", perf_evsel__roundtrip_name_test),
-DEFINE_SUITE("Parse sched tracepoints fields", perf_evsel__tp_sched_test),
-DEFINE_SUITE("syscalls:sys_enter_openat event fields", syscall_openat_tp_fields),
-DEFINE_SUITE("Setup struct perf_event_attr", attr),
-DEFINE_SUITE("Match and link multiple hists", hists_link),
-DEFINE_SUITE("'import perf' in python", python_use),
-{
+};
+DEFINE_SUITE("DSO data read", dso_data);
+DEFINE_SUITE("DSO data cache", dso_data_cache);
+DEFINE_SUITE("DSO data reopen", dso_data_reopen);
+DEFINE_SUITE("Roundtrip evsel->name", perf_evsel__roundtrip_name_test);
+DEFINE_SUITE("Parse sched tracepoints fields", perf_evsel__tp_sched_test);
+DEFINE_SUITE("syscalls:sys_enter_openat event fields", syscall_openat_tp_fields);
+DEFINE_SUITE("Setup struct perf_event_attr", attr);
+DEFINE_SUITE("Match and link multiple hists", hists_link);
+DEFINE_SUITE("'import perf' in python", python_use);
+static struct test bp_signal = {
 	.desc = "Breakpoint overflow signal handler",
 	.func = test__bp_signal,
 	.is_supported = test__bp_signal_is_supported,
-},
-{
+};
+static struct test bp_signal_overflow = {
 	.desc = "Breakpoint overflow sampling",
 	.func = test__bp_signal_overflow,
 	.is_supported = test__bp_signal_is_supported,
-},
-{
+};
+static struct test bp_accounting = {
 	.desc = "Breakpoint accounting",
 	.func = test__bp_accounting,
 	.is_supported = test__bp_account_is_supported,
-},
-{
+};
+static struct test wp = {
 	.desc = "Watchpoint",
 	.func = test__wp,
 	.is_supported = test__wp_is_supported,
@@ -97,24 +87,24 @@ DEFINE_SUITE("'import perf' in python", python_use),
 		.get_desc	= test__wp_subtest_get_desc,
 		.skip_reason    = test__wp_subtest_skip_reason,
 	},
-},
-DEFINE_SUITE("Number of exit events of a simple workload", task_exit),
-DEFINE_SUITE("Software clock events period values", sw_clock_freq),
-DEFINE_SUITE("Object code reading", code_reading),
-DEFINE_SUITE("Sample parsing", sample_parsing),
-DEFINE_SUITE("Use a dummy software event to keep tracking", keep_tracking),
-DEFINE_SUITE("Parse with no sample_id_all bit set", parse_no_sample_id_all),
-DEFINE_SUITE("Filter hist entries", hists_filter),
-DEFINE_SUITE("Lookup mmap thread", mmap_thread_lookup),
-DEFINE_SUITE("Share thread maps", thread_maps_share),
-DEFINE_SUITE("Sort output of hist entries", hists_output),
-DEFINE_SUITE("Cumulate child hist entries", hists_cumulate),
-DEFINE_SUITE("Track with sched_switch", switch_tracking),
-DEFINE_SUITE("Filter fds with revents mask in a fdarray", fdarray__filter),
-DEFINE_SUITE("Add fd to a fdarray, making it autogrow", fdarray__add),
-DEFINE_SUITE("kmod_path__parse", kmod_path__parse),
-DEFINE_SUITE("Thread map", thread_map),
-{
+};
+DEFINE_SUITE("Number of exit events of a simple workload", task_exit);
+DEFINE_SUITE("Software clock events period values", sw_clock_freq);
+DEFINE_SUITE("Object code reading", code_reading);
+DEFINE_SUITE("Sample parsing", sample_parsing);
+DEFINE_SUITE("Use a dummy software event to keep tracking", keep_tracking);
+DEFINE_SUITE("Parse with no sample_id_all bit set", parse_no_sample_id_all);
+DEFINE_SUITE("Filter hist entries", hists_filter);
+DEFINE_SUITE("Lookup mmap thread", mmap_thread_lookup);
+DEFINE_SUITE("Share thread maps", thread_maps_share);
+DEFINE_SUITE("Sort output of hist entries", hists_output);
+DEFINE_SUITE("Cumulate child hist entries", hists_cumulate);
+DEFINE_SUITE("Track with sched_switch", switch_tracking);
+DEFINE_SUITE("Filter fds with revents mask in a fdarray", fdarray__filter);
+DEFINE_SUITE("Add fd to a fdarray, making it autogrow", fdarray__add);
+DEFINE_SUITE("kmod_path__parse", kmod_path__parse);
+DEFINE_SUITE("Thread map", thread_map);
+static struct test llvm = {
 	.desc = "LLVM search and compile",
 	.func = test__llvm,
 	.subtest = {
@@ -122,9 +112,9 @@ DEFINE_SUITE("Thread map", thread_map),
 		.get_nr		= test__llvm_subtest_get_nr,
 		.get_desc	= test__llvm_subtest_get_desc,
 	},
-},
-DEFINE_SUITE("Session topology", session_topology),
-{
+};
+DEFINE_SUITE("Session topology", session_topology);
+static struct test bpf = {
 	.desc = "BPF filter",
 	.func = test__bpf,
 	.subtest = {
@@ -132,23 +122,23 @@ DEFINE_SUITE("Session topology", session_topology),
 		.get_nr		= test__bpf_subtest_get_nr,
 		.get_desc	= test__bpf_subtest_get_desc,
 	},
-},
-DEFINE_SUITE("Synthesize thread map", thread_map_synthesize),
-DEFINE_SUITE("Remove thread map", thread_map_remove),
-DEFINE_SUITE("Synthesize cpu map", cpu_map_synthesize),
-DEFINE_SUITE("Synthesize stat config", synthesize_stat_config),
-DEFINE_SUITE("Synthesize stat", synthesize_stat),
-DEFINE_SUITE("Synthesize stat round", synthesize_stat_round),
-DEFINE_SUITE("Synthesize attr update", event_update),
-DEFINE_SUITE("Event times", event_times),
-DEFINE_SUITE("Read backward ring buffer", backward_ring_buffer),
-DEFINE_SUITE("Print cpu map", cpu_map_print),
-DEFINE_SUITE("Merge cpu map", cpu_map_merge),
-DEFINE_SUITE("Probe SDT events", sdt_event),
-DEFINE_SUITE("is_printable_array", is_printable_array),
-DEFINE_SUITE("Print bitmap", bitmap_print),
-DEFINE_SUITE("perf hooks", perf_hooks),
-{
+};
+DEFINE_SUITE("Synthesize thread map", thread_map_synthesize);
+DEFINE_SUITE("Remove thread map", thread_map_remove);
+DEFINE_SUITE("Synthesize cpu map", cpu_map_synthesize);
+DEFINE_SUITE("Synthesize stat config", synthesize_stat_config);
+DEFINE_SUITE("Synthesize stat", synthesize_stat);
+DEFINE_SUITE("Synthesize stat round", synthesize_stat_round);
+DEFINE_SUITE("Synthesize attr update", event_update);
+DEFINE_SUITE("Event times", event_times);
+DEFINE_SUITE("Read backward ring buffer", backward_ring_buffer);
+DEFINE_SUITE("Print cpu map", cpu_map_print);
+DEFINE_SUITE("Merge cpu map", cpu_map_merge);
+DEFINE_SUITE("Probe SDT events", sdt_event);
+DEFINE_SUITE("is_printable_array", is_printable_array);
+DEFINE_SUITE("Print bitmap", bitmap_print);
+DEFINE_SUITE("perf hooks", perf_hooks);
+static struct test clang = {
 	.desc = "builtin clang support",
 	.func = test__clang,
 	.subtest = {
@@ -156,12 +146,12 @@ DEFINE_SUITE("perf hooks", perf_hooks),
 		.get_nr		= test__clang_subtest_get_nr,
 		.get_desc	= test__clang_subtest_get_desc,
 	}
-},
-DEFINE_SUITE("unit_number__scnprintf", unit_number__scnprint),
-DEFINE_SUITE("mem2node", mem2node),
-DEFINE_SUITE("time utils", time_utils),
-DEFINE_SUITE("Test jit_write_elf", jit_write_elf),
-{
+};
+DEFINE_SUITE("unit_number__scnprintf", unit_number__scnprint);
+DEFINE_SUITE("mem2node", mem2node);
+DEFINE_SUITE("time utils", time_utils);
+DEFINE_SUITE("Test jit_write_elf", jit_write_elf);
+static struct test pfm = {
 	.desc = "Test libpfm4 support",
 	.func = test__pfm,
 	.subtest = {
@@ -169,26 +159,99 @@ DEFINE_SUITE("Test jit_write_elf", jit_write_elf),
 		.get_nr		= test__pfm_subtest_get_nr,
 		.get_desc	= test__pfm_subtest_get_desc,
 	}
-},
-DEFINE_SUITE("Test api io", api_io),
-DEFINE_SUITE("maps__merge_in", maps__merge_in),
-DEFINE_SUITE("Demangle Java", demangle_java),
-DEFINE_SUITE("Demangle OCaml", demangle_ocaml),
-DEFINE_SUITE("Parse and process metrics", parse_metric),
-DEFINE_SUITE("PE file support", pe_file_parsing),
-DEFINE_SUITE("Event expansion for cgroups", expand_cgroup_events),
-{
+};
+DEFINE_SUITE("Test api io", api_io);
+DEFINE_SUITE("maps__merge_in", maps__merge_in);
+DEFINE_SUITE("Demangle Java", demangle_java);
+DEFINE_SUITE("Demangle OCaml", demangle_ocaml);
+DEFINE_SUITE("Parse and process metrics", parse_metric);
+DEFINE_SUITE("PE file support", pe_file_parsing);
+DEFINE_SUITE("Event expansion for cgroups", expand_cgroup_events);
+static struct test perf_time_to_tsc = {
 	.desc = "Convert perf time to TSC",
 	.func = test__perf_time_to_tsc,
 	.is_supported = test__tsc_is_supported,
-},
-DEFINE_SUITE("dlfilter C API", dlfilter),
-{
-	.func = NULL,
-},
+};
+DEFINE_SUITE("dlfilter C API", dlfilter);
+
+
+static struct test *generic_tests[] = {
+	&vmlinux_matches_kallsyms,
+	&openat_syscall_event,
+	&openat_syscall_event_on_all_cpus,
+	&basic_mmap,
+	&mem,
+	&parse_events,
+	&expr,
+	&PERF_RECORD,
+	&pmu,
+	&pmu_events,
+	&dso_data,
+	&dso_data_cache,
+	&dso_data_reopen,
+	&perf_evsel__roundtrip_name_test,
+	&perf_evsel__tp_sched_test,
+	&syscall_openat_tp_fields,
+	&attr,
+	&hists_link,
+	&python_use,
+	&bp_signal,
+	&bp_signal_overflow,
+	&bp_accounting,
+	&wp,
+	&task_exit,
+	&sw_clock_freq,
+	&code_reading,
+	&sample_parsing,
+	&keep_tracking,
+	&parse_no_sample_id_all,
+	&hists_filter,
+	&mmap_thread_lookup,
+	&thread_maps_share,
+	&hists_output,
+	&hists_cumulate,
+	&switch_tracking,
+	&fdarray__filter,
+	&fdarray__add,
+	&kmod_path__parse,
+	&thread_map,
+	&llvm,
+	&session_topology,
+	&bpf,
+	&thread_map_synthesize,
+	&thread_map_remove,
+	&cpu_map_synthesize,
+	&synthesize_stat_config,
+	&synthesize_stat,
+	&synthesize_stat_round,
+	&event_update,
+	&event_times,
+	&backward_ring_buffer,
+	&cpu_map_print,
+	&cpu_map_merge,
+	&sdt_event,
+	&is_printable_array,
+	&bitmap_print,
+	&perf_hooks,
+	&clang,
+	&unit_number__scnprint,
+	&mem2node,
+	&time_utils,
+	&jit_write_elf,
+	&pfm,
+	&api_io,
+	&maps__merge_in,
+	&demangle_java,
+	&demangle_ocaml,
+	&parse_metric,
+	&pe_file_parsing,
+	&expand_cgroup_events,
+	&perf_time_to_tsc,
+	&dlfilter,
+	NULL,
 };
 
-static struct test *tests[] = {
+static struct test **tests[] = {
 	generic_tests,
 	arch_tests,
 };
@@ -269,9 +332,9 @@ static int run_test(struct test *test, int subtest)
 	return err;
 }
 
-#define for_each_test(j, t)	 				\
+#define for_each_test(j, k, t)			\
 	for (j = 0; j < ARRAY_SIZE(tests); j++)	\
-		for (t = &tests[j][0]; t->func; t++)
+		for (k = 0, t = tests[j][k]; tests[j][k]; k++, t = tests[j][k])
 
 static int test_and_print(struct test *t, bool force_skip, int subtest)
 {
@@ -470,18 +533,18 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
 static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 {
 	struct test *t;
-	unsigned int j;
+	unsigned int j, k;
 	int i = 0;
 	int width = shell_tests__max_desc_width();
 
-	for_each_test(j, t) {
+	for_each_test(j, k, t) {
 		int len = strlen(t->desc);
 
 		if (width < len)
 			width = len;
 	}
 
-	for_each_test(j, t) {
+	for_each_test(j, k, t) {
 		int curr = i++, err;
 		int subi;
 
@@ -597,11 +660,11 @@ static int perf_test__list_shell(int argc, const char **argv, int i)
 
 static int perf_test__list(int argc, const char **argv)
 {
-	unsigned int j;
+	unsigned int j, k;
 	struct test *t;
 	int i = 0;
 
-	for_each_test(j, t) {
+	for_each_test(j, k, t) {
 		int curr = i++;
 
 		if (!perf_test__matches(t->desc, curr, argc, argv) ||
diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index c756284b3b13..38f16a53613f 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -195,7 +195,7 @@ NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_1(struct thread *th
 	return ret;
 }
 
-int test__dwarf_unwind(struct test *test __maybe_unused, int subtest __maybe_unused)
+static int test__dwarf_unwind(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct machine *machine;
 	struct thread *thread;
@@ -237,3 +237,8 @@ int test__dwarf_unwind(struct test *test __maybe_unused, int subtest __maybe_unu
 	machine__delete(machine);
 	return err;
 }
+
+struct test dwarf_unwind = {
+	.desc = "Test dwarf unwind",
+	.func = test__dwarf_unwind,
+};
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 0846f66d67f9..8323a3c88284 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -43,6 +43,12 @@ struct test {
 #define DECLARE_SUITE(name) \
 	int test__##name(struct test *test, int subtest)
 
+#define DEFINE_SUITE(description, name)		\
+	static struct test name = {		\
+		.desc = description,		\
+		.func = test__##name,		\
+	}
+
 /* Tests */
 DECLARE_SUITE(vmlinux_matches_kallsyms);
 DECLARE_SUITE(openat_syscall_event);
@@ -78,7 +84,7 @@ DECLARE_SUITE(code_reading);
 DECLARE_SUITE(sample_parsing);
 DECLARE_SUITE(keep_tracking);
 DECLARE_SUITE(parse_no_sample_id_all);
-DECLARE_SUITE(dwarf_unwind);
+extern struct test dwarf_unwind;
 DECLARE_SUITE(expr);
 DECLARE_SUITE(hists_filter);
 DECLARE_SUITE(mmap_thread_lookup);
-- 
2.33.1.1089.g2158813163f-goog

