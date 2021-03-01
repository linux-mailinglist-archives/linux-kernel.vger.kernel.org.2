Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A55328038
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbhCAOFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236161AbhCAOFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:05:07 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310ECC06178B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 06:04:27 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id a24so9940718plm.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=osiE7RNF10zB/zGfCQDT8E15zuDgXM/HjLuWT3AdDhY=;
        b=hiCbmzuRZ1KF9VsJ7KWVcqfEjl4xEXNusWkfvl05B90YiiGKLbcJId78sAJBLN6igP
         LC8mIbGXP6lgpIGFnAQy3Hb7a9y1wepkfSqCjE4nlOxd5CdgUJZNCtuP3YvJIy8OuEz+
         WTzrQTA6FJx04sojHTDWaiYodBNyJwQMIrETM04X0Coi4Hx2D7kRNSgt3xkZYtYV2tiD
         etawXJzMeJzKosnoIydKkteFHlintAE8OvmHXXy0APs/nTKXdP8p9U7HO+83aO9lVTI4
         AjyETetcaE7h9TSTWOsAmB4jSDwkGTzuhtuvW2pKTJS08FXP2Np3nR5dXEt4YIzfAGlE
         /Dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=osiE7RNF10zB/zGfCQDT8E15zuDgXM/HjLuWT3AdDhY=;
        b=f+N9Pgr7TVl6Y9AJ0ozdBv3623e15BBjunjNSLQY88kCNx22sxo1VaNYoRK/7L1PYt
         oYO+H99+AyQXU/7KGzPro0zbnsrirG6mpJLTbHwdMgcDabJA8yy/ha1cGdFsX/u90vRj
         A0C/tSN64JJmDwTEUIr/fIkyFrUYcMlk8qDfCSvqqugM60xJ1fYtoMf8QzycLJMVRlY4
         j+Wk3ObKy5k423f3VCzeaGq27gNpQ+fYxMwPcQp21fntD0MUkfVMgZpMp8t9r5feygzK
         gK/LlzOycDj4FxDISAjn8XGzXE3f2XF1MjtjEZdO4FMjxcFFmc6LYCZoTwhs3pWxg3XF
         a0cA==
X-Gm-Message-State: AOAM53289PQ2e05CWbx66S4wwj1eKwVeQm2Np2vyC0Efw+1MbBgXpgiA
        1ZUfYN9k5b41pGmy96iV/kw=
X-Google-Smtp-Source: ABdhPJw/txhUSJZt5MG8mIvUKe1GstDN+h4sRuQTLo8NDBRfm4f4yf8dAVGP1r1kjK0VTNWZc/ONSw==
X-Received: by 2002:a17:90a:6383:: with SMTP id f3mr17246407pjj.14.1614607466830;
        Mon, 01 Mar 2021 06:04:26 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id v26sm17357312pff.195.2021.03.01.06.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 06:04:26 -0800 (PST)
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
Subject: [PATCH 03/11] perf test: Fix cpu and thread map leaks in task_exit test
Date:   Mon,  1 Mar 2021 23:04:01 +0900
Message-Id: <20210301140409.184570-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210301140409.184570-1-namhyung@kernel.org>
References: <20210301140409.184570-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The evlist has the maps with its own refcounts so we don't need to set
the pointers to NULL.  Otherwise following error was reported by Asan.

Also change the goto label since it doesn't need to have two.

  # perf test -v 24
  24: Number of exit events of a simple workload :
  --- start ---
  test child forked, pid 145915
  mmap size 528384B

  =================================================================
  ==145915==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7fc44e50d1f8 in __interceptor_realloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:164
    #1 0x561cf50f4d2e in perf_thread_map__realloc /home/namhyung/project/linux/tools/lib/perf/threadmap.c:23
    #2 0x561cf4eeb949 in thread_map__new_by_tid util/thread_map.c:63
    #3 0x561cf4db7fd2 in test__task_exit tests/task-exit.c:74
    #4 0x561cf4d798fb in run_test tests/builtin-test.c:428
    #5 0x561cf4d798fb in test_and_print tests/builtin-test.c:458
    #6 0x561cf4d7ba53 in __cmd_test tests/builtin-test.c:679
    #7 0x561cf4d7ba53 in cmd_test tests/builtin-test.c:825
    #8 0x561cf4de7d04 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:313
    #9 0x561cf4c71a88 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:365
    #10 0x561cf4c71a88 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:409
    #11 0x561cf4c71a88 in main /home/namhyung/project/linux/tools/perf/perf.c:539
    #12 0x7fc44e042d09 in __libc_start_main ../csu/libc-start.c:308

    ...
  test child finished with 1
  ---- end ----
  Number of exit events of a simple workload: FAILED!

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/task-exit.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index bbf94e4aa145..4c2969db59b0 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -75,14 +75,11 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	if (!cpus || !threads) {
 		err = -ENOMEM;
 		pr_debug("Not enough memory to create thread/cpu maps\n");
-		goto out_free_maps;
+		goto out_delete_evlist;
 	}
 
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 
-	cpus	= NULL;
-	threads = NULL;
-
 	err = evlist__prepare_workload(evlist, &target, argv, false, workload_exec_failed_signal);
 	if (err < 0) {
 		pr_debug("Couldn't run the workload!\n");
@@ -137,7 +134,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 		if (retry_count++ > 1000) {
 			pr_debug("Failed after retrying 1000 times\n");
 			err = -1;
-			goto out_free_maps;
+			goto out_delete_evlist;
 		}
 
 		goto retry;
@@ -148,10 +145,9 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 		err = -1;
 	}
 
-out_free_maps:
+out_delete_evlist:
 	perf_cpu_map__put(cpus);
 	perf_thread_map__put(threads);
-out_delete_evlist:
 	evlist__delete(evlist);
 	return err;
 }
-- 
2.30.1.766.gb4fecdf3b7-goog

