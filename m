Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7D635F8AE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352631AbhDNQIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:08:40 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:36538 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352599AbhDNQIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:08:38 -0400
Received: by mail-oo1-f43.google.com with SMTP id c6-20020a4aacc60000b02901e6260b12e2so2219671oon.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 09:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bzPgVlZLxCmiHh36STsjjPnEFDUB3Sr4GyNs58pfJ9I=;
        b=nyaU7IJQBUxPYrHdxNLYwf/MEdwp01uc9WtbvdFlAwcLykSbipr507kaDUNTgYxngI
         ZVx7ekggA1o20xTah3DgozhnNDG69+14LiTg0AfO/CKuVlXR5veMtUJd5JTZT9+ZNEfM
         q6/pt+MYbimjiUitC9TagTbykpSzC3I6bu/qExNluyxT8yluZ+cIVxBjjVgZbjN5hD1l
         xl5SuDaKgDUdogl7nXxUWTEOqa0lxLBMANfKmCPInyrSjlk10uBRz6211ZkZaRm1O66m
         uc2cUh/54SKvAOxGd4NbDtgEjiZMEIyw6ytxVS6HU0MQXfJICXL6qnR8n566pRFhYiTU
         7h9A==
X-Gm-Message-State: AOAM531yScwYFFbvUVXT4NAk9PPpUWDyuITDbQWSdPHts6b1RE+lACAT
        D0R6GI+TKZiMHwEAlvHFKQ==
X-Google-Smtp-Source: ABdhPJwR4YvKhFq5xYG9EPxe7SCwpU+Y6GAf9o7RDst6bcdT/gdoQV5IVVtGmBnfmh3kXtXcdeEtRA==
X-Received: by 2002:a4a:d38c:: with SMTP id i12mr13303936oos.72.1618416497065;
        Wed, 14 Apr 2021 09:08:17 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id t19sm4471239otm.40.2021.04.14.09.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 09:08:09 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: [PATCH v8 4/4] libperf: Add support for user space counter access
Date:   Wed, 14 Apr 2021 11:07:39 -0500
Message-Id: <20210414155412.3697605-4-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414155412.3697605-1-robh@kernel.org>
References: <20210414155412.3697605-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 and arm64 can both support direct access of event counters in
userspace. The access sequence is less than trivial and currently exists
in perf test code (tools/perf/arch/x86/tests/rdpmc.c) with copies in
projects such as PAPI and libpfm4.

In order to support usersapce access, an event must be mmapped first
with perf_evsel__mmap(). Then subsequent calls to perf_evsel__read()
will use the fast path (assuming the arch supports it).

Signed-off-by: Rob Herring <robh@kernel.org>
---
v8:
 - Add call to perf_evsel_munmap() in evsel test
v6:
 - Adapt to mmap changes adding MMAP NULL check
v5:
 - Make raw count s64 instead of u64 so that counter width shifting
   works
 - Adapt to mmap changes
v4:
 - Update perf_evsel__mmap size to pages
v3:
 - Split out perf_evsel__mmap() to separate patch
---
 tools/lib/perf/evsel.c                 |  4 ++
 tools/lib/perf/include/internal/mmap.h |  3 +
 tools/lib/perf/mmap.c                  | 88 ++++++++++++++++++++++++++
 tools/lib/perf/tests/test-evsel.c      | 66 +++++++++++++++++++
 4 files changed, 161 insertions(+)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index cd203998e875..bd8c2f19ef74 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -267,6 +267,10 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 	if (FD(evsel, cpu, thread) < 0)
 		return -EINVAL;

+	if (MMAP(evsel, cpu, thread) &&
+	    !perf_mmap__read_self(MMAP(evsel, cpu, thread), count))
+		return 0;
+
 	if (readn(FD(evsel, cpu, thread), count->values, size) <= 0)
 		return -errno;

diff --git a/tools/lib/perf/include/internal/mmap.h b/tools/lib/perf/include/internal/mmap.h
index be7556e0a2b2..5e3422f40ed5 100644
--- a/tools/lib/perf/include/internal/mmap.h
+++ b/tools/lib/perf/include/internal/mmap.h
@@ -11,6 +11,7 @@
 #define PERF_SAMPLE_MAX_SIZE (1 << 16)

 struct perf_mmap;
+struct perf_counts_values;

 typedef void (*libperf_unmap_cb_t)(struct perf_mmap *map);

@@ -52,4 +53,6 @@ void perf_mmap__put(struct perf_mmap *map);

 u64 perf_mmap__read_head(struct perf_mmap *map);

+int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count);
+
 #endif /* __LIBPERF_INTERNAL_MMAP_H */
diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index 79d5ed6c38cc..915469f00cf4 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -8,9 +8,11 @@
 #include <linux/perf_event.h>
 #include <perf/mmap.h>
 #include <perf/event.h>
+#include <perf/evsel.h>
 #include <internal/mmap.h>
 #include <internal/lib.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include "internal.h"

 void perf_mmap__init(struct perf_mmap *map, struct perf_mmap *prev,
@@ -273,3 +275,89 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map)

 	return event;
 }
+
+#if defined(__i386__) || defined(__x86_64__)
+static u64 read_perf_counter(unsigned int counter)
+{
+	unsigned int low, high;
+
+	asm volatile("rdpmc" : "=a" (low), "=d" (high) : "c" (counter));
+
+	return low | ((u64)high) << 32;
+}
+
+static u64 read_timestamp(void)
+{
+	unsigned int low, high;
+
+	asm volatile("rdtsc" : "=a" (low), "=d" (high));
+
+	return low | ((u64)high) << 32;
+}
+#else
+static u64 read_perf_counter(unsigned int counter) { return 0; }
+static u64 read_timestamp(void) { return 0; }
+#endif
+
+int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count)
+{
+	struct perf_event_mmap_page *pc = map->base;
+	u32 seq, idx, time_mult = 0, time_shift = 0;
+	u64 cnt, cyc = 0, time_offset = 0, time_cycles = 0, time_mask = ~0ULL;
+
+	if (!pc || !pc->cap_user_rdpmc)
+		return -1;
+
+	do {
+		seq = READ_ONCE(pc->lock);
+		barrier();
+
+		count->ena = READ_ONCE(pc->time_enabled);
+		count->run = READ_ONCE(pc->time_running);
+
+		if (pc->cap_user_time && count->ena != count->run) {
+			cyc = read_timestamp();
+			time_mult = READ_ONCE(pc->time_mult);
+			time_shift = READ_ONCE(pc->time_shift);
+			time_offset = READ_ONCE(pc->time_offset);
+
+			if (pc->cap_user_time_short) {
+				time_cycles = READ_ONCE(pc->time_cycles);
+				time_mask = READ_ONCE(pc->time_mask);
+			}
+		}
+
+		idx = READ_ONCE(pc->index);
+		cnt = READ_ONCE(pc->offset);
+		if (pc->cap_user_rdpmc && idx) {
+			s64 evcnt = read_perf_counter(idx - 1);
+			u16 width = READ_ONCE(pc->pmc_width);
+
+			evcnt <<= 64 - width;
+			evcnt >>= 64 - width;
+			cnt += evcnt;
+		} else
+			return -1;
+
+		barrier();
+	} while (READ_ONCE(pc->lock) != seq);
+
+	if (count->ena != count->run) {
+		u64 delta;
+
+		/* Adjust for cap_usr_time_short, a nop if not */
+		cyc = time_cycles + ((cyc - time_cycles) & time_mask);
+
+		delta = time_offset + mul_u64_u32_shr(cyc, time_mult, time_shift);
+
+		count->ena += delta;
+		if (idx)
+			count->run += delta;
+
+		cnt = mul_u64_u64_div64(cnt, count->ena, count->run);
+	}
+
+	count->val = cnt;
+
+	return 0;
+}
diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
index 0ad82d7a2a51..288b5feaefe2 100644
--- a/tools/lib/perf/tests/test-evsel.c
+++ b/tools/lib/perf/tests/test-evsel.c
@@ -120,6 +120,70 @@ static int test_stat_thread_enable(void)
 	return 0;
 }

+static int test_stat_user_read(int event)
+{
+	struct perf_counts_values counts = { .val = 0 };
+	struct perf_thread_map *threads;
+	struct perf_evsel *evsel;
+	struct perf_event_mmap_page *pc;
+	struct perf_event_attr attr = {
+		.type	= PERF_TYPE_HARDWARE,
+		.config	= event,
+	};
+	int err, i;
+
+	threads = perf_thread_map__new_dummy();
+	__T("failed to create threads", threads);
+
+	perf_thread_map__set_pid(threads, 0, 0);
+
+	evsel = perf_evsel__new(&attr);
+	__T("failed to create evsel", evsel);
+
+	err = perf_evsel__open(evsel, NULL, threads);
+	__T("failed to open evsel", err == 0);
+
+	err = perf_evsel__mmap(evsel, 0);
+	__T("failed to mmap evsel", err == 0);
+
+	pc = perf_evsel__mmap_base(evsel, 0, 0);
+
+#if defined(__i386__) || defined(__x86_64__)
+	__T("userspace counter access not supported", pc->cap_user_rdpmc);
+	__T("userspace counter access not enabled", pc->index);
+	__T("userspace counter width not set", pc->pmc_width >= 32);
+#endif
+
+	perf_evsel__read(evsel, 0, 0, &counts);
+	__T("failed to read value for evsel", counts.val != 0);
+
+	for (i = 0; i < 5; i++) {
+		volatile int count = 0x10000 << i;
+		__u64 start, end, last = 0;
+
+		__T_VERBOSE("\tloop = %u, ", count);
+
+		perf_evsel__read(evsel, 0, 0, &counts);
+		start = counts.val;
+
+		while (count--) ;
+
+		perf_evsel__read(evsel, 0, 0, &counts);
+		end = counts.val;
+
+		__T("invalid counter data", (end - start) > last);
+		last = end - start;
+		__T_VERBOSE("count = %llu\n", end - start);
+	}
+
+	perf_evsel__munmap(evsel);
+	perf_evsel__close(evsel);
+	perf_evsel__delete(evsel);
+
+	perf_thread_map__put(threads);
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	__T_START;
@@ -129,6 +193,8 @@ int main(int argc, char **argv)
 	test_stat_cpu();
 	test_stat_thread();
 	test_stat_thread_enable();
+	test_stat_user_read(PERF_COUNT_HW_INSTRUCTIONS);
+	test_stat_user_read(PERF_COUNT_HW_CPU_CYCLES);

 	__T_END;
 	return tests_failed == 0 ? 0 : -1;
--
2.27.0
