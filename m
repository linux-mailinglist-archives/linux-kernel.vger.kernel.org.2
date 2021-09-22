Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B24414F44
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 19:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbhIVRjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 13:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbhIVRju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 13:39:50 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4676C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 10:38:19 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id u6-20020ad449a6000000b003798010ad14so13461025qvx.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 10:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=japLK4v+y51csmvOjxrH47VIcfpX7TCEfxL+NB9lmDQ=;
        b=p6jihdXV53RCSA69SvSZ0e2ZdcETDueevrg9P5mFKL9TI9fKlSNB9BRzwPL8s69QHF
         rLs9/Wsf/qkBb9NnID7WEBjxoROp4KDLxww9fOHd3GfATruc16Y5LBZkD6imv9t2dw/K
         Zl/X50l3XN0ssHYmzxvrquHq2ZwJgfidfFL0io7u6UfNfG+SL9a7imcTezLKyMU2lolS
         JaLFRAh3Rtmjbenjd4JAmwZw+KVYuyFteahaLQ6rMn9Mzjc+LM36m2G/SsVTZPXxA2qs
         XJq/HMcAoR+cOhMUbHl1627wUThYHk9d4UwTawys/EtDTR9IVc16XDp5eqYQ+eihz++b
         I/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=japLK4v+y51csmvOjxrH47VIcfpX7TCEfxL+NB9lmDQ=;
        b=KGjetPVB+sU69CtkxGuE7ckuTg/MomA6QM6zAlZOKuvh27knacXAI2jpyVRjIaRTdY
         QK4SA0WORJ/yU/qtbRcTnCJc7S4UaFLjm2X+L4KFFddGbuY8yuSE9m+FuuptOE240ybP
         gXNNlWMfaSAWzKvZc2H3UixAF8FVmK1haAlipI0v8e/EPIGP5oO2WIVZs3ru1N3k4sN/
         vepECz1hqYQB6Uy3liBxtdXive+PDgFygosY7Rh1+zR5NJ39zz0QC4eZ+MwusmDbGEK7
         u1fhPMdS10+sLYvo6SDoAW6x+lVfbVLDVklwlV8L38yYsnqzcDJTxWvMxSOvUuF+Kdtp
         uqMA==
X-Gm-Message-State: AOAM532UdKyF/ZYpfuNpeQA4nrl/y1EQzmPfRK7JzYRJ/L7bbCxj2xar
        nj9JGl1jwKR1MlIHznrv3GQewlOPc9A6
X-Google-Smtp-Source: ABdhPJw2ega6IXrM3Bpu4KXDyOOa83NrP07uabAGtb9V2euPA4It73cvZhoIhyK22YalQ7HSIYOsTd3o4czs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d3ff:e8f7:11f4:c738])
 (user=irogers job=sendgmr) by 2002:a05:6214:13e9:: with SMTP id
 ch9mr282732qvb.65.1632332299113; Wed, 22 Sep 2021 10:38:19 -0700 (PDT)
Date:   Wed, 22 Sep 2021 10:38:12 -0700
Message-Id: <20210922173812.456348-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2] perf test: Fix dwarf unwind for optimized builds.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ensure the stack frames are on the stack tail calls optimizations
need to be inhibited. If your compiler supports an attribute use it,
otherwise use an asm volatile barrier.

The barrier fix was suggested here:
https://lore.kernel.org/lkml/20201028081123.GT2628@hirez.programming.kicks-ass.net/
Tested with an optimized clang build and by forcing the asm barrier
route with an optimized clang build.

A GCC bug tracking a proper disable_tail_calls is:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97831

Fixes: 9ae1e990f1ab ("perf tools: Remove broken __no_tail_call
       attribute")

v2. is a rebase. The original fix patch generated quite a lot of
    discussion over the right place for the fix:
https://lore.kernel.org/lkml/20201114000803.909530-1-irogers@google.com/
    The patch reflects my preference of it being near the use, so that
    future code cleanups don't break this somewhat special usage.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/dwarf-unwind.c | 39 +++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index a288035eb362..c756284b3b13 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -20,6 +20,23 @@
 /* For bsearch. We try to unwind functions in shared object. */
 #include <stdlib.h>
 
+/*
+ * The test will assert frames are on the stack but tail call optimizations lose
+ * the frame of the caller. Clang can disable this optimization on a called
+ * function but GCC currently (11/2020) lacks this attribute. The barrier is
+ * used to inhibit tail calls in these cases.
+ */
+#ifdef __has_attribute
+#if __has_attribute(disable_tail_calls)
+#define NO_TAIL_CALL_ATTRIBUTE __attribute__((disable_tail_calls))
+#define NO_TAIL_CALL_BARRIER
+#endif
+#endif
+#ifndef NO_TAIL_CALL_ATTRIBUTE
+#define NO_TAIL_CALL_ATTRIBUTE
+#define NO_TAIL_CALL_BARRIER __asm__ __volatile__("" : : : "memory");
+#endif
+
 static int mmap_handler(struct perf_tool *tool __maybe_unused,
 			union perf_event *event,
 			struct perf_sample *sample,
@@ -91,7 +108,7 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	return strcmp((const char *) symbol, funcs[idx]);
 }
 
-noinline int test_dwarf_unwind__thread(struct thread *thread)
+NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__thread(struct thread *thread)
 {
 	struct perf_sample sample;
 	unsigned long cnt = 0;
@@ -122,7 +139,7 @@ noinline int test_dwarf_unwind__thread(struct thread *thread)
 
 static int global_unwind_retval = -INT_MAX;
 
-noinline int test_dwarf_unwind__compare(void *p1, void *p2)
+NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__compare(void *p1, void *p2)
 {
 	/* Any possible value should be 'thread' */
 	struct thread *thread = *(struct thread **)p1;
@@ -141,7 +158,7 @@ noinline int test_dwarf_unwind__compare(void *p1, void *p2)
 	return p1 - p2;
 }
 
-noinline int test_dwarf_unwind__krava_3(struct thread *thread)
+NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_3(struct thread *thread)
 {
 	struct thread *array[2] = {thread, thread};
 	void *fp = &bsearch;
@@ -160,14 +177,22 @@ noinline int test_dwarf_unwind__krava_3(struct thread *thread)
 	return global_unwind_retval;
 }
 
-noinline int test_dwarf_unwind__krava_2(struct thread *thread)
+NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_2(struct thread *thread)
 {
-	return test_dwarf_unwind__krava_3(thread);
+	int ret;
+
+	ret =  test_dwarf_unwind__krava_3(thread);
+	NO_TAIL_CALL_BARRIER;
+	return ret;
 }
 
-noinline int test_dwarf_unwind__krava_1(struct thread *thread)
+NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_1(struct thread *thread)
 {
-	return test_dwarf_unwind__krava_2(thread);
+	int ret;
+
+	ret =  test_dwarf_unwind__krava_2(thread);
+	NO_TAIL_CALL_BARRIER;
+	return ret;
 }
 
 int test__dwarf_unwind(struct test *test __maybe_unused, int subtest __maybe_unused)
-- 
2.33.0.464.g1972c5931b-goog

