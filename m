Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68A732803F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbhCAOGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbhCAOFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:05:41 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBE0C061797
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 06:04:42 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id a24so9941308plm.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pV0oxiABYROjFhP7iW0oTQED76gXJkIm689C9Uvj9eM=;
        b=bbYrsiX1Id8MOoASEEvdScFqGzy7HjzFI8mh3tfpxAFyJMsW7Lh4G6nnmMI/jS/Dpx
         2YUQ5oOhGSpDJeccMsFYNNYlhe11swHLrFuDa+VQeNyGb3/GBoo4DxMosPGy1es5dTby
         xdq9lZyA7qT2MR7drrzyQyoTHQVSSARA/yx8lFLPD8rTYWrg1ckQEps5yjoxnLV2OB/S
         lpQWDCGi/KU++ncYpXVXCeN5R0Ig3ejBhfwtwH9lZfeFj3BeL36Ng5+asASn9SDz0/lL
         L3UvrrBgJeUm0Gin+2hd+vjJXqxnxKnM5eNB4h33GactqWOmeBJDNQXLmkIm65GWUWTn
         mUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pV0oxiABYROjFhP7iW0oTQED76gXJkIm689C9Uvj9eM=;
        b=WuDciK5b4sk5jwh0lZtF1DqD47iPeYwrOzY+qj8gAu/2dxsC6uXmQfIYGDBFC8Aaeb
         KDSBl26qLfV1u+tRxJyTbyyWIZVi/JoEgP/uwLEgjtQHt6H2v9NzLimiyLLWPbE5vjHd
         igUf++DN+5I3QIQojT/YgMRDkLw4XzwQCfsupvPxxF6f/gh7z36CVfT4Vw8EdPdSchJG
         mf1BdYuuyVNQMl/AHWwrwRpW21IC1Srq/YOcpGz505NLuWkyqFQpBOjuo43jjvw8qrTF
         S16vNOCLFmmuTu3kMDw5ZLl6y6GuKKDQU9HQWSV3/QwN1aWOCtep/C5NZWNFb542gYxx
         FrIw==
X-Gm-Message-State: AOAM530UbJjgSv8LQXi4UUkaLQTFDQv9s2kHymgiNL1yL83Gxgspndhd
        Z6z/QUoqcK5voupnC2BxrXc=
X-Google-Smtp-Source: ABdhPJxKBSaXFpr5MBBpQEm98WOgLIKZt8Ew/gwsoRRImdjacFwPIdAc/8Xrl+63kLcSOZB19Lgdwg==
X-Received: by 2002:a17:902:704c:b029:e3:1bd3:6318 with SMTP id h12-20020a170902704cb02900e31bd36318mr15848560plt.20.1614607482560;
        Mon, 01 Mar 2021 06:04:42 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id v26sm17357312pff.195.2021.03.01.06.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 06:04:42 -0800 (PST)
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
Subject: [PATCH 07/11] perf test: Fix cpu and thread map leaks in switch_tracking test
Date:   Mon,  1 Mar 2021 23:04:05 +0900
Message-Id: <20210301140409.184570-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210301140409.184570-1-namhyung@kernel.org>
References: <20210301140409.184570-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The evlist and cpu/thread maps should be released together.
Otherwise the following error was reported by Asan.

  $ perf test -v 35
  35: Track with sched_switch                    :
  --- start ---
  test child forked, pid 159287
  Using CPUID GenuineIntel-6-8E-C
  mmap size 528384B
  1295 events recorded

  =================================================================
  ==159287==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 40 byte(s) in 1 object(s) allocated from:
    #0 0x7fa28d9a2e8f in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:145
    #1 0x5652f5a5affa in cpu_map__trim_new /home/namhyung/project/linux/tools/lib/perf/cpumap.c:79
    #2 0x5652f5a5ba1f in perf_cpu_map__read /home/namhyung/project/linux/tools/lib/perf/cpumap.c:149
    #3 0x5652f5a5c1df in cpu_map__read_all_cpu_map /home/namhyung/project/linux/tools/lib/perf/cpumap.c:166
    #4 0x5652f5a5c1df in perf_cpu_map__new /home/namhyung/project/linux/tools/lib/perf/cpumap.c:181
    #5 0x5652f5723bbf in test__switch_tracking tests/switch-tracking.c:350
    #6 0x5652f56e18fb in run_test tests/builtin-test.c:428
    #7 0x5652f56e18fb in test_and_print tests/builtin-test.c:458
    #8 0x5652f56e3a53 in __cmd_test tests/builtin-test.c:679
    #9 0x5652f56e3a53 in cmd_test tests/builtin-test.c:825
    #10 0x5652f574fcc4 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:313
    #11 0x5652f55d9a88 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:365
    #12 0x5652f55d9a88 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:409
    #13 0x5652f55d9a88 in main /home/namhyung/project/linux/tools/perf/perf.c:539
    #14 0x7fa28d4d8d09 in __libc_start_main ../csu/libc-start.c:308

  SUMMARY: AddressSanitizer: 72 byte(s) leaked in 2 allocation(s).
  test child finished with 1
  ---- end ----
  Track with sched_switch: FAILED!

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/switch-tracking.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 15a2ab765d89..3ebaa758df77 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -574,10 +574,9 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 	if (evlist) {
 		evlist__disable(evlist);
 		evlist__delete(evlist);
-	} else {
-		perf_cpu_map__put(cpus);
-		perf_thread_map__put(threads);
 	}
+	perf_cpu_map__put(cpus);
+	perf_thread_map__put(threads);
 
 	return err;
 
-- 
2.30.1.766.gb4fecdf3b7-goog

