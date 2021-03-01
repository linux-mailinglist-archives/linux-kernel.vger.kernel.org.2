Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7558632803E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbhCAOGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbhCAOFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:05:40 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A36C0617A7
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 06:04:46 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id l18so11903878pji.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zzCt53Is11cWBwQkoHr7IqwPtUqMkGzkL3/gMwG0OTY=;
        b=rEmf5DgonR3+wKVDfhqxrRAodHPa++QptkYPZsnd0/3nqLitqIfJGyPx8XFkzG/J0y
         kOErOHw1SLehoYhK12U+m2SAtsAB6lC5yJPrfO3TBuRVYbTuF6bI4YXj7kbXLsgoXDew
         7AwypdsgzUN1i9OkGiaqCvon/x/IjyScM+CraKUTE7Cx0i2F2HFS2e6D2r9APhp3qzYN
         GFz8qgKDjGLv6qu90o4ggywzX64O98caejysBPqN0PMriA81inDUw/ByK6MFnLMT1wWw
         ktbHpv9jxCe8CrlPwRCVWdVn5pPs492PKE+k/KCLgrEcPpgdi7pyzEjhf/wamLX1JRjN
         CXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zzCt53Is11cWBwQkoHr7IqwPtUqMkGzkL3/gMwG0OTY=;
        b=LL9A0OlJEjlrhFay4JcPIG585Od2dAfinDWoRe6JLSPGFUjgJ6lFtU55EMylzQQKMp
         iO5TmtAAQ9vxypPXvhXUpJs/sWohw9F7utG88Vf2zyk8OjL1qa6TZGIdw3dgtfFshERp
         /bitoQ44X42sUhMEBgCYMUcbtBP1K+QPDlGC8/k3gLVcaaV0pgKu0k+udiaznRiGJVyI
         zZcwqCTSvrPpGCUexCUk0+3jRIKrXGVq8ch+4QJALl1uBL/C2XIumXtAKA4GTHaD+A88
         yvlTyjgLYf37BhelJXYNF9Je8aY31cCqENR/Q8NASXJgntMeB0vYMtOm53f2/bjf/FMs
         11iQ==
X-Gm-Message-State: AOAM532xAak8JJs6qRJgxEouxat3luASm0hTLnCohc8F2umBJRCKTgP2
        A3yJIKnSxQhC3bem9/mE44E=
X-Google-Smtp-Source: ABdhPJwE8dCbpivri0KZLw0HerV6KaQ0eeWIOLgluc5KIWrCwiR/KMvdXVIP8j0wW1yuM2Vy80szNw==
X-Received: by 2002:a17:902:b688:b029:dc:240a:2bd7 with SMTP id c8-20020a170902b688b02900dc240a2bd7mr15564485pls.50.1614607486461;
        Mon, 01 Mar 2021 06:04:46 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id v26sm17357312pff.195.2021.03.01.06.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 06:04:45 -0800 (PST)
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
Subject: [PATCH 08/11] perf test: Fix a thread map leak in thread_map_synthesize test
Date:   Mon,  1 Mar 2021 23:04:06 +0900
Message-Id: <20210301140409.184570-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210301140409.184570-1-namhyung@kernel.org>
References: <20210301140409.184570-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It missed to call perf_thread_map__put() after using the map.

  $ perf test -v 43
  43: Synthesize thread map                      :
  --- start ---
  test child forked, pid 162640

  =================================================================
  ==162640==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7fd48cdaa1f8 in __interceptor_realloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:164
    #1 0x563e6d5f8d0e in perf_thread_map__realloc /home/namhyung/project/linux/tools/lib/perf/threadmap.c:23
    #2 0x563e6d3ef69a in thread_map__new_by_pid util/thread_map.c:46
    #3 0x563e6d2cec90 in test__thread_map_synthesize tests/thread-map.c:97
    #4 0x563e6d27d8fb in run_test tests/builtin-test.c:428
    #5 0x563e6d27d8fb in test_and_print tests/builtin-test.c:458
    #6 0x563e6d27fa53 in __cmd_test tests/builtin-test.c:679
    #7 0x563e6d27fa53 in cmd_test tests/builtin-test.c:825
    #8 0x563e6d2ebce4 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:313
    #9 0x563e6d175a88 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:365
    #10 0x563e6d175a88 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:409
    #11 0x563e6d175a88 in main /home/namhyung/project/linux/tools/perf/perf.c:539
    #12 0x7fd48c8dfd09 in __libc_start_main ../csu/libc-start.c:308

  SUMMARY: AddressSanitizer: 8224 byte(s) leaked in 2 allocation(s).
  test child finished with 1
  ---- end ----
  Synthesize thread map: FAILED!

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/thread-map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index 28f51c4bd373..9e1cf11149ef 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -102,6 +102,7 @@ int test__thread_map_synthesize(struct test *test __maybe_unused, int subtest __
 	TEST_ASSERT_VAL("failed to synthesize map",
 		!perf_event__synthesize_thread_map2(NULL, threads, process_event, NULL));
 
+	perf_thread_map__put(threads);
 	return 0;
 }
 
-- 
2.30.1.766.gb4fecdf3b7-goog

