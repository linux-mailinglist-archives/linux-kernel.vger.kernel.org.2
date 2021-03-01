Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0099432803A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbhCAOFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbhCAOFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:05:36 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A546C061793
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 06:04:35 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id g4so11665742pgj.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GssLE2TtrkGhFA0SEQVS06vocvfAKYdNjdR4PUlL8k8=;
        b=Sf/vs58JDgEe7H2xSrpLYlST1x9gANGS2MxEnLml9e01u+UDSVcUYkgvpVSyScR6CR
         1D292e/6ppFjwE5OU7lxbWesBK4DzPbPr1OhCqimvH2FHpybTMUCeDoMiv49feH7kxrD
         e+btvjiuriv1I8PoWuQE29UU1FJP2oJ21aI8XRgaAz1W0ZDsfMSMxN5KbXGdj2T81S7q
         yhVaHp8gwoWbWGIKSpqT8ZuwMZRq4xc1d1efN879CF00Odz4rUg9fijF1u5Pt6UngvMC
         PwF8VUn2oPtHDabP9vGaI9xLK3ZLuKECznxwmKUl5Rep1J1pBtiyH4a72tY9FdUljk3r
         2SKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GssLE2TtrkGhFA0SEQVS06vocvfAKYdNjdR4PUlL8k8=;
        b=WWFIcXmnr89U+JeGndSJUW2g+KuYKbj7sFTFBlftcKJidHKM8vrU8q6WTK8CcFKxlK
         /i0TJth7tnIdek+m+U0erTPuv19jJNAbgG0a73uW8g4r6DzfojUKM8FMA0kk/JEnLiMF
         hCi9zC8Ua4aqnYhkRR75XjdRnou11x1rE6eoamSAs3zam03Zi7YKWTlL2hcTrfveSH/o
         TMJpVHgZQQM8F8md/CKBnREpa79tmlMIFM/ucLYsjF3kjpxG9ebu5yhT2s9BoruGyyu6
         V9P7tfewJqq7Amkn8nHVixGrLRnnD2YyiigywlnFz3zaHL+tEIbuM65jFLNGqwnSTFhU
         c3Bg==
X-Gm-Message-State: AOAM532oBmlEts2/sfT/cdRl2oaBkO86/yhLuWgujvOYLFqGmV7DkYjU
        EGgY0oxK6dBEVrK1EqUlWwQ=
X-Google-Smtp-Source: ABdhPJyCWfRs9jenH6MYl3a2WYmNYijFRnsEGcmkQH9u9PhCaD4UZQQUSA10CU8Bj6IXKaMYqGW5kg==
X-Received: by 2002:a63:cb4c:: with SMTP id m12mr13835970pgi.51.1614607474694;
        Mon, 01 Mar 2021 06:04:34 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id v26sm17357312pff.195.2021.03.01.06.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 06:04:34 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 05/11] perf test: Fix cpu and thread map leaks in code_reading test
Date:   Mon,  1 Mar 2021 23:04:03 +0900
Message-Id: <20210301140409.184570-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210301140409.184570-1-namhyung@kernel.org>
References: <20210301140409.184570-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The evlist and the cpu/thread maps should be released together.
Otherwise following error was reported by Asan.

Note that this test still has memory leaks in DSOs so it still fails
even after this change.  I'll take a look at that too.

  # perf test -v 26
  26: Object code reading                        :
  --- start ---
  test child forked, pid 154184
  Looking at the vmlinux_path (8 entries long)
  symsrc__init: build id mismatch for vmlinux.
  symsrc__init: cannot get elf header.
  Using /proc/kcore for kernel data
  Using /proc/kallsyms for symbols
  Parsing event 'cycles'
  mmap size 528384B
  ...
  =================================================================
  ==154184==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 439 byte(s) in 1 object(s) allocated from:
    #0 0x7fcb66e77037 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
    #1 0x55ad9b7e821e in dso__new_id util/dso.c:1256
    #2 0x55ad9b8cfd4a in __machine__addnew_vdso util/vdso.c:132
    #3 0x55ad9b8cfd4a in machine__findnew_vdso util/vdso.c:347
    #4 0x55ad9b845b7e in map__new util/map.c:176
    #5 0x55ad9b8415a2 in machine__process_mmap2_event util/machine.c:1787
    #6 0x55ad9b8fab16 in perf_tool__process_synth_event util/synthetic-events.c:64
    #7 0x55ad9b8fab16 in perf_event__synthesize_mmap_events util/synthetic-events.c:499
    #8 0x55ad9b8fbfdf in __event__synthesize_thread util/synthetic-events.c:741
    #9 0x55ad9b8ff3e3 in perf_event__synthesize_thread_map util/synthetic-events.c:833
    #10 0x55ad9b738585 in do_test_code_reading tests/code-reading.c:608
    #11 0x55ad9b73b25d in test__code_reading tests/code-reading.c:722
    #12 0x55ad9b6f28fb in run_test tests/builtin-test.c:428
    #13 0x55ad9b6f28fb in test_and_print tests/builtin-test.c:458
    #14 0x55ad9b6f4a53 in __cmd_test tests/builtin-test.c:679
    #15 0x55ad9b6f4a53 in cmd_test tests/builtin-test.c:825
    #16 0x55ad9b760cc4 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:313
    #17 0x55ad9b5eaa88 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:365
    #18 0x55ad9b5eaa88 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:409
    #19 0x55ad9b5eaa88 in main /home/namhyung/project/linux/tools/perf/perf.c:539
    #20 0x7fcb669acd09 in __libc_start_main ../csu/libc-start.c:308

    ...
  SUMMARY: AddressSanitizer: 471 byte(s) leaked in 2 allocation(s).
  test child finished with 1
  ---- end ----
  Object code reading: FAILED!

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/code-reading.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 280f0348a09c..2fdc7b2f996e 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -706,13 +706,9 @@ static int do_test_code_reading(bool try_kcore)
 out_put:
 	thread__put(thread);
 out_err:
-
-	if (evlist) {
-		evlist__delete(evlist);
-	} else {
-		perf_cpu_map__put(cpus);
-		perf_thread_map__put(threads);
-	}
+	evlist__delete(evlist);
+	perf_cpu_map__put(cpus);
+	perf_thread_map__put(threads);
 	machine__delete_threads(machine);
 	machine__delete(machine);
 
-- 
2.30.1.766.gb4fecdf3b7-goog

