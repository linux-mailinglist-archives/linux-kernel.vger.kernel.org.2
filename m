Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33844328045
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbhCAOHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbhCAOFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:05:48 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF308C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 06:04:58 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id s7so2766137plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FPe92DhWr1+NZCjM3AdQ4yAKD5JsQ/87Bw6qvODxwc0=;
        b=ZF77APlwP7tt7uOEMCjgo4kVtnA4y2uzNR5Visv+Y/UGiAXZ8qPUcuwZW/zaln/fOI
         aqPnPYWWM4kOk58b4BRP18eM8HIJwFnUh9rGHv+FHjSlEg8UCbqHlErlLh+fceD9ZfPw
         TlVVr4qmboVVb4W6JUOpYWRmpm5WF6Qk9oAmXnzvGs3OWCLho7t2TZD8PK9HKYqKZkpM
         VrrlsRXfuDzKHwvTbxQ85xvKOIiTEK3dVTcKNt1oKfIj+5/siHLnwcvOU2FyzIF9GEz2
         vlUCsOAJIRU9DChWqqAy4/0i/bPtG48ovtgRToblySuDl5xbwP51HAHoKZoeDLOnPZB/
         KMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FPe92DhWr1+NZCjM3AdQ4yAKD5JsQ/87Bw6qvODxwc0=;
        b=hSF1lyll/H6nAf2GknBw6r2fn1bsaXXxzIEfBmeYppF9gn3jJo5wV7t8+0zTykZtUX
         lnVO0c6U0FgPyHjMJE/RY1rBOh/5Xc8mW0DZuQeGu/oPIohwuxMzcF44Obhtq4ZZtsB5
         zF38moY5q/ASun2nq5oZGGswBRXqo2A0c2X2g/BuyZHn/URaOy14VqnyNN+CSVzKlo5W
         zDJg0uzHGxsTx9NPJPI0Ve9Hn2GE4boXUOw36ApNmUwJaJirvpFeWIRpxxvNw9IdtjYy
         +DGm1Bd7Tsrm3+/d+C86E7+awzhtrlhxuOkxFPGRF5kiJodvxykMUi+HoGP+xzYMQflU
         8rqg==
X-Gm-Message-State: AOAM5316VIAkOpIu/Rx8EHcCmQ6UYSpQ3yb05CNbl3oUIDkS8xkcnmhM
        Th1WWMpPI6k666kU7Y0lQuc=
X-Google-Smtp-Source: ABdhPJwCmdn0SKuKDZxRQ0lAR8TbdxBzWLdzejxphbnMP4NkNPXlVGHTSTbOaLP6myvTMj7Dp7HgFA==
X-Received: by 2002:a17:90a:74c6:: with SMTP id p6mr17246501pjl.134.1614607498496;
        Mon, 01 Mar 2021 06:04:58 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id v26sm17357312pff.195.2021.03.01.06.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 06:04:57 -0800 (PST)
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
Subject: [PATCH 11/11] perf test: Fix cpu and thread map leaks in perf_time_to_tsc test
Date:   Mon,  1 Mar 2021 23:04:09 +0900
Message-Id: <20210301140409.184570-12-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210301140409.184570-1-namhyung@kernel.org>
References: <20210301140409.184570-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should release the maps at the end.

  $ perf test -v 71
  71: Convert perf time to TSC                   :
  --- start ---
  test child forked, pid 178744
  mmap size 528384B
  1st event perf time 59207256505278 tsc 13187166645142
  rdtsc          time 59207256542151 tsc 13187166723020
  2nd event perf time 59207256543749 tsc 13187166726393

  =================================================================
  ==178744==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 40 byte(s) in 1 object(s) allocated from:
    #0 0x7faf601f9e8f in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:145
    #1 0x55b620cfc00a in cpu_map__trim_new /home/namhyung/project/linux/tools/lib/perf/cpumap.c:79
    #2 0x55b620cfca2f in perf_cpu_map__read /home/namhyung/project/linux/tools/lib/perf/cpumap.c:149
    #3 0x55b620cfd1ef in cpu_map__read_all_cpu_map /home/namhyung/project/linux/tools/lib/perf/cpumap.c:166
    #4 0x55b620cfd1ef in perf_cpu_map__new /home/namhyung/project/linux/tools/lib/perf/cpumap.c:181
    #5 0x55b6209ef1b2 in test__perf_time_to_tsc tests/perf-time-to-tsc.c:73
    #6 0x55b6209828fb in run_test tests/builtin-test.c:428
    #7 0x55b6209828fb in test_and_print tests/builtin-test.c:458
    #8 0x55b620984a53 in __cmd_test tests/builtin-test.c:679
    #9 0x55b620984a53 in cmd_test tests/builtin-test.c:825
    #10 0x55b6209f0cd4 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:313
    #11 0x55b62087aa88 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:365
    #12 0x55b62087aa88 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:409
    #13 0x55b62087aa88 in main /home/namhyung/project/linux/tools/perf/perf.c:539
    #14 0x7faf5fd2fd09 in __libc_start_main ../csu/libc-start.c:308

  SUMMARY: AddressSanitizer: 72 byte(s) leaked in 2 allocation(s).
  test child finished with 1
  ---- end ----
  Convert perf time to TSC: FAILED!

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/perf-time-to-tsc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
index 7cff02664d0e..680c3cffb128 100644
--- a/tools/perf/tests/perf-time-to-tsc.c
+++ b/tools/perf/tests/perf-time-to-tsc.c
@@ -167,6 +167,8 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 
 out_err:
 	evlist__delete(evlist);
+	perf_cpu_map__put(cpus);
+	perf_thread_map__put(threads);
 	return err;
 }
 
-- 
2.30.1.766.gb4fecdf3b7-goog

