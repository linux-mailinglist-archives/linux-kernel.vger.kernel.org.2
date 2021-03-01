Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D39328039
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbhCAOF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbhCAOFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:05:11 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3496AC06178C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 06:04:31 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p5so9963999plo.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3MgAsdHH6DUOmgF4WFe+vEkgj6PfeMLEDamwoGtvgmM=;
        b=i9eqlhQl/V0b3lvirEb1bj9u3EhOkt1kMvH7B/izwHmDHp6wTpFKSkaQ+rUKWE91Qa
         tXYXJ3lCBW7xFVpUuC7IjKwoDaRJvJxM14HA0lI3vfYf8xWqeqEHy3AExSu1xz6Rk4gh
         eCDo7N0A0Kht5uy5CYzovXfwMxdbWHquMVrqUQ68uVmIJp1p9+6SD+CgmhvW5sNXc3Kf
         ZHFgMs3hqRRkXjyNAWcMqGeAIPK6x8DHcX6FsP1+C0xojEJoOboNFlFgYddbShyCzzuo
         6cpdnt/qlsZnE1IRurlZzpvHN8OuwJnLqDN2spwNDjZh0ObtKTnAHJIs9cv8Zf6xMGjh
         375A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3MgAsdHH6DUOmgF4WFe+vEkgj6PfeMLEDamwoGtvgmM=;
        b=WDiFvpvzP7vooKKBMn5WsZGIYJJiGCgNzNidJ1vtskpegJYKv5rS9GMATpFi1p5g1q
         oj7pZ+uJULC7BAwczcu6x1b/bijCzzogTt9286dbk3bkToW/A3tWEXK4GseMWKNRncXi
         Q5tY4dtOn2UiYXuOpy2jfmdZbd/+ezGU4sWYqL1oTTct1Z2LusiYV5i6W4OHtbuetGl2
         iVXUXFlaufYytA7iDMOnkZmiSZyN/cFjm2HbDOVQReXHFvbA54bcKcBngcL9bSD55ebn
         3Bn3yt5373YpVMWm6RHbF1V5yn8M17QL2/G0FEEvRQkoUd3Sf4eUH87A8wjucLPbV1p8
         s7CA==
X-Gm-Message-State: AOAM5322cYI8iYxUHg637tZZTm5VOWOeOuRSk8mYgc6Kn/5KdrnI7VDA
        FHFFWY4A8B67z5NPubHvJCoqo+ri9ZI=
X-Google-Smtp-Source: ABdhPJxygZo/zatK1rgeUbqBNvEPPsYBT5V6wQk8kebUS/W97f6kgWbNlhMjnaHTGet5NLNd66fETg==
X-Received: by 2002:a17:902:c582:b029:e4:c16d:b5eb with SMTP id p2-20020a170902c582b02900e4c16db5ebmr1310204plx.6.1614607470787;
        Mon, 01 Mar 2021 06:04:30 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id v26sm17357312pff.195.2021.03.01.06.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 06:04:30 -0800 (PST)
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
Subject: [PATCH 04/11] perf test: Fix cpu and thread map leaks in sw_clock_freq test
Date:   Mon,  1 Mar 2021 23:04:02 +0900
Message-Id: <20210301140409.184570-5-namhyung@kernel.org>
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

  # perf test -v 25
  25: Software clock events period values        :
  --- start ---
  test child forked, pid 149154
  mmap size 528384B
  mmap size 528384B

  =================================================================
  ==149154==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7fef5cd071f8 in __interceptor_realloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:164
    #1 0x56260d5e8b8e in perf_thread_map__realloc /home/namhyung/project/linux/tools/lib/perf/threadmap.c:23
    #2 0x56260d3df7a9 in thread_map__new_by_tid util/thread_map.c:63
    #3 0x56260d2ac6b2 in __test__sw_clock_freq tests/sw-clock.c:65
    #4 0x56260d26d8fb in run_test tests/builtin-test.c:428
    #5 0x56260d26d8fb in test_and_print tests/builtin-test.c:458
    #6 0x56260d26fa53 in __cmd_test tests/builtin-test.c:679
    #7 0x56260d26fa53 in cmd_test tests/builtin-test.c:825
    #8 0x56260d2dbb64 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:313
    #9 0x56260d165a88 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:365
    #10 0x56260d165a88 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:409
    #11 0x56260d165a88 in main /home/namhyung/project/linux/tools/perf/perf.c:539
    #12 0x7fef5c83cd09 in __libc_start_main ../csu/libc-start.c:308

    ...
  test child finished with 1
  ---- end ----
  Software clock events period values      : FAILED!

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/sw-clock.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index a49c9e23053b..74988846be1d 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -42,8 +42,8 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 		.disabled = 1,
 		.freq = 1,
 	};
-	struct perf_cpu_map *cpus;
-	struct perf_thread_map *threads;
+	struct perf_cpu_map *cpus = NULL;
+	struct perf_thread_map *threads = NULL;
 	struct mmap *md;
 
 	attr.sample_freq = 500;
@@ -66,14 +66,11 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
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
 	if (evlist__open(evlist)) {
 		const char *knob = "/proc/sys/kernel/perf_event_max_sample_rate";
 
@@ -129,10 +126,9 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
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

