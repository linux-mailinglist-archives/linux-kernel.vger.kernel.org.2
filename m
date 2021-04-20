Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07393650BA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 05:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbhDTDQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 23:16:14 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:37812 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbhDTDP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 23:15:58 -0400
Received: by mail-ot1-f45.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso20536331otm.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 20:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i9M35Fv+VDOCbSBe8i/2KVW6Kek+bTdVHKxx9K3ioX0=;
        b=AZQKF2BD/nwH/jaY1AdKBJpP9HtcoGBsmw3BJWNm5KEFDlUXrj2H98Cgnt+2voaom0
         OVaHSVnLazTAINQSMyE1nlgW5Z7w6OQc+uSYvfe4L0U94DOQKzbacHDfuwhi9xkrZF6e
         cIOIGZtla4EVbEchW1ZO0trW/isQ+nacERFMDlqdpyVIScz2bxnsmD15X0YryZWJEXwz
         X0JkGKxYjGijmH/yH1vOftkv98CuBGODOL7UuCsqyt2pdWy5UdaNQVaTO9YPjj0KlQo3
         lDmdJbt3JFMF7DjKeUDuJSxYg3QauiiR6PxC3Trtjq2FZRya9cIEByY5LTT4dBkb7hX1
         BUxg==
X-Gm-Message-State: AOAM530zXtaYo0eJlxoEu9vx5E3b0q0XDIw9OSud8K9jfBwzQneW0bqz
        tdVtYJbMYVZ8LtZmdrkWvQ==
X-Google-Smtp-Source: ABdhPJxGOUQ6nbrkgsTEaASgKlQlD1F+nU/yrW5FYd0NXObGuu+BeFhcAjz/61tbVYJ/iqiQpLc1EQ==
X-Received: by 2002:a05:6830:1e61:: with SMTP id m1mr16417904otr.36.1618888525887;
        Mon, 19 Apr 2021 20:15:25 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id g16sm2347896oof.43.2021.04.19.20.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 20:15:25 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 7/9] perf: arm64: Add test for userspace counter access on heterogeneous systems
Date:   Mon, 19 Apr 2021 22:15:09 -0500
Message-Id: <20210420031511.2348977-8-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210420031511.2348977-1-robh@kernel.org>
References: <20210420031511.2348977-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace counter access only works on heterogeneous systems with some
restrictions. The userspace process must be pinned to a homogeneous
subset of CPUs and must open the corresponding PMU for those CPUs. This
commit adds a test implementing these requirements.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v6:
 - Add a check on cap_user_rdpmc
v5:
 - Adapt to libperf mmap API changes
v4:
 - Update perf_evsel__mmap params
v2:
 - Drop all but heterogeneous test as others covered by libperf tests
 - Rework to use libperf
---
 tools/perf/arch/arm64/include/arch-tests.h |   7 +
 tools/perf/arch/arm64/tests/Build          |   1 +
 tools/perf/arch/arm64/tests/arch-tests.c   |   4 +
 tools/perf/arch/arm64/tests/user-events.c  | 177 +++++++++++++++++++++
 4 files changed, 189 insertions(+)
 create mode 100644 tools/perf/arch/arm64/tests/user-events.c

diff --git a/tools/perf/arch/arm64/include/arch-tests.h b/tools/perf/arch/arm64/include/arch-tests.h
index 90ec4c8cb880..380ad34a3f09 100644
--- a/tools/perf/arch/arm64/include/arch-tests.h
+++ b/tools/perf/arch/arm64/include/arch-tests.h
@@ -2,11 +2,18 @@
 #ifndef ARCH_TESTS_H
 #define ARCH_TESTS_H
 
+#include <linux/compiler.h>
+
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 struct thread;
 struct perf_sample;
+int test__arch_unwind_sample(struct perf_sample *sample,
+			     struct thread *thread);
 #endif
 
 extern struct test arch_tests[];
+int test__rd_pinned(struct test __maybe_unused *test,
+		       int __maybe_unused subtest);
+
 
 #endif
diff --git a/tools/perf/arch/arm64/tests/Build b/tools/perf/arch/arm64/tests/Build
index a61c06bdb757..3f9a20c17fc6 100644
--- a/tools/perf/arch/arm64/tests/Build
+++ b/tools/perf/arch/arm64/tests/Build
@@ -1,4 +1,5 @@
 perf-y += regs_load.o
 perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 
+perf-y += user-events.o
 perf-y += arch-tests.o
diff --git a/tools/perf/arch/arm64/tests/arch-tests.c b/tools/perf/arch/arm64/tests/arch-tests.c
index 5b1543c98022..80ce7bd3c16d 100644
--- a/tools/perf/arch/arm64/tests/arch-tests.c
+++ b/tools/perf/arch/arm64/tests/arch-tests.c
@@ -10,6 +10,10 @@ struct test arch_tests[] = {
 		.func = test__dwarf_unwind,
 	},
 #endif
+	{
+		.desc = "Pinned CPU user counter access",
+		.func = test__rd_pinned,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/arch/arm64/tests/user-events.c b/tools/perf/arch/arm64/tests/user-events.c
new file mode 100644
index 000000000000..c8efc6b369e6
--- /dev/null
+++ b/tools/perf/arch/arm64/tests/user-events.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <unistd.h>
+#include <sched.h>
+#include <cpumap.h>
+
+#include <perf/core.h>
+#include <perf/threadmap.h>
+#include <perf/evsel.h>
+
+#include "pmu.h"
+#include "debug.h"
+#include "tests/tests.h"
+#include "arch-tests.h"
+
+static int run_test(struct perf_evsel *evsel)
+{
+	int n;
+	volatile int tmp = 0;
+	u64 delta, i, loops = 1000;
+	struct perf_counts_values counts = { .val = 0 };
+
+	for (n = 0; n < 6; n++) {
+		u64 stamp, now;
+
+		perf_evsel__read(evsel, 0, 0, &counts);
+		stamp = counts.val;
+
+		for (i = 0; i < loops; i++)
+			tmp++;
+
+		perf_evsel__read(evsel, 0, 0, &counts);
+		now = counts.val;
+		loops *= 10;
+
+		delta = now - stamp;
+		pr_debug("%14d: %14llu\n", n, (long long)delta);
+
+		if (!delta)
+			break;
+	}
+	return delta ? 0 : -1;
+}
+
+static struct perf_pmu *pmu_for_cpu(int cpu)
+{
+	int acpu, idx;
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		if (pmu->is_uncore)
+			continue;
+		perf_cpu_map__for_each_cpu(acpu, idx, pmu->cpus)
+			if (acpu == cpu)
+				return pmu;
+	}
+	return NULL;
+}
+
+static bool pmu_is_homogeneous(void)
+{
+	int core_cnt = 0;
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		if (!pmu->is_uncore && !perf_cpu_map__empty(pmu->cpus))
+			core_cnt++;
+	}
+	return core_cnt == 1;
+}
+
+static int libperf_print(enum libperf_print_level level,
+			 const char *fmt, va_list ap)
+{
+	(void)level;
+	return vfprintf(stderr, fmt, ap);
+}
+
+static struct perf_evsel *perf_init(struct perf_event_attr *attr)
+{
+	int err;
+	struct perf_thread_map *threads;
+	struct perf_evsel *evsel;
+	struct perf_event_mmap_page *pc;
+
+	libperf_init(libperf_print);
+
+	threads = perf_thread_map__new_dummy();
+	if (!threads) {
+		pr_err("failed to create threads\n");
+		return NULL;
+	}
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	evsel = perf_evsel__new(attr);
+	if (!evsel) {
+		pr_err("failed to create evsel\n");
+		goto out_thread;
+	}
+
+	err = perf_evsel__open(evsel, NULL, threads);
+	if (err) {
+		pr_err("failed to open evsel\n");
+		goto out_open;
+	}
+
+	if (perf_evsel__mmap(evsel, 0)) {
+		pr_err("failed to mmap evsel\n");
+		goto out_mmap;
+	}
+
+	pc = perf_evsel__mmap_base(evsel, 0, 0);
+	if (!pc->cap_user_rdpmc) {
+		pr_err("userspace access not enabled\n");
+		goto out_mmap;
+	}
+
+	return evsel;
+
+out_mmap:
+	perf_evsel__close(evsel);
+out_open:
+	perf_evsel__delete(evsel);
+out_thread:
+	perf_thread_map__put(threads);
+	return NULL;
+}
+
+int test__rd_pinned(struct test __maybe_unused *test,
+		    int __maybe_unused subtest)
+{
+	int cpu, cputmp, ret = -1;
+	struct perf_evsel *evsel;
+	struct perf_event_attr attr = {
+		.config = 0x8, /* Instruction count */
+		.config1 = 0, /* 32-bit counter */
+		.exclude_kernel = 1,
+	};
+	cpu_set_t cpu_set;
+	struct perf_pmu *pmu;
+
+	if (pmu_is_homogeneous())
+		return TEST_SKIP;
+
+	cpu = sched_getcpu();
+	pmu = pmu_for_cpu(cpu);
+	if (!pmu)
+		return -1;
+	attr.type = pmu->type;
+
+	CPU_ZERO(&cpu_set);
+	perf_cpu_map__for_each_cpu(cpu, cputmp, pmu->cpus)
+		CPU_SET(cpu, &cpu_set);
+	if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set) < 0)
+		pr_err("Could not set affinity\n");
+
+	evsel = perf_init(&attr);
+	if (!evsel)
+		return -1;
+
+	perf_cpu_map__for_each_cpu(cpu, cputmp, pmu->cpus) {
+		CPU_ZERO(&cpu_set);
+		CPU_SET(cpu, &cpu_set);
+		if (sched_setaffinity(0, sizeof(cpu_set), &cpu_set) < 0)
+			pr_err("Could not set affinity\n");
+
+		pr_debug("Running on CPU %d\n", cpu);
+
+		ret = run_test(evsel);
+		if (ret)
+			break;
+	}
+
+	perf_evsel__close(evsel);
+	perf_evsel__delete(evsel);
+	return ret;
+}
-- 
2.27.0

