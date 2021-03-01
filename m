Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1515C328036
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbhCAOFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbhCAOFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:05:00 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750E1C061788
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 06:04:19 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id s16so9947694plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Pd+BhkEAn267J0IOg+vBSRFkkfGLL/M1vewJ82sgQQ=;
        b=RA46DUKn6KKFv7kP0DMB15i3N7xCh7ezQGVxEcxCPhF5madMh7NsDrnhP0LDEYPeCj
         XQHjHJQ2IpRVJ9kO8FHDIXybLXxmWw0qU7oPS4UhcswTsO5EZHazaMgJh4uEPQ2BnWi8
         ZJ4YR0F6BBWDMvuPLgYOIVKN6COqmihmM+hsW/gQ/3cyIvkhIDokvOGb4q3X+nPmHFqs
         d+TXIP8TbBSMneL7KSdR+Nm0wZ7Y1qGD3/BmX1Rz68pHBynh2NfeUsdrVidDQ53FzAw8
         xcXdJBrnUnMUQXS/j+LB5+MzQPYtrMdz4ypSUjImAgWZWUGNMm8erzlfbhqWSmn19aX7
         DJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0Pd+BhkEAn267J0IOg+vBSRFkkfGLL/M1vewJ82sgQQ=;
        b=X1qmKuM5sDgNJf2Ze9e/WsTw30GGgHWo2Gz1zLfI41w8/VdrtkU7+S18MNLGAdEsc6
         0BoU9zLB69iNf9/WhWlIWWxBts4JaIKCTOoEwB7aySS2CBmkz4dDTnVKy6J6P5kS1nzY
         WqNquGNn8LO15Hs1X0784pHW01TlseTWpm1u7jhsKHTRszSqKeVRNC4VpePtv4FUuaWZ
         fcJk4+o/l+nLMqhncyQYJ7Gekt2jlBxl74IO7PlvWa1sFuy8WZMX0bxgvh/t+kOnHpcn
         vTdg0/wxNjxBVR8IK+U0DYiRSHgCV6QYHzeKcePqieFPFVhSZef5c9QknjLt9it38zEQ
         wWzw==
X-Gm-Message-State: AOAM532B3tvPv+kgFWbdx1isUm34oGWeYIbNXq2Gp/ATpZQJJUQrJat3
        hreMIVnwDCNdtI1t0bHJJPY=
X-Google-Smtp-Source: ABdhPJwXrr93auOLewxzuVteAWyQb4Y5mSugMqi9lfzD3qErQ18oi2VnVOSidkVnKTlN3bB88zW/eA==
X-Received: by 2002:a17:90b:1b52:: with SMTP id nv18mr18157687pjb.19.1614607459056;
        Mon, 01 Mar 2021 06:04:19 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id v26sm17357312pff.195.2021.03.01.06.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 06:04:18 -0800 (PST)
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
Subject: [PATCH 01/11] perf test: Fix cpu and thread map leaks in basic mmap test
Date:   Mon,  1 Mar 2021 23:03:59 +0900
Message-Id: <20210301140409.184570-2-namhyung@kernel.org>
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

  # perf test -v 4
   4: Read samples using the mmap interface      :
  --- start ---
  test child forked, pid 139782
  mmap size 528384B

  =================================================================
  ==139782==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 40 byte(s) in 1 object(s) allocated from:
    #0 0x7f1f76daee8f in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:145
    #1 0x564ba21a0fea in cpu_map__trim_new /home/namhyung/project/linux/tools/lib/perf/cpumap.c:79
    #2 0x564ba21a1a0f in perf_cpu_map__read /home/namhyung/project/linux/tools/lib/perf/cpumap.c:149
    #3 0x564ba21a21cf in cpu_map__read_all_cpu_map /home/namhyung/project/linux/tools/lib/perf/cpumap.c:166
    #4 0x564ba21a21cf in perf_cpu_map__new /home/namhyung/project/linux/tools/lib/perf/cpumap.c:181
    #5 0x564ba1e48298 in test__basic_mmap tests/mmap-basic.c:55
    #6 0x564ba1e278fb in run_test tests/builtin-test.c:428
    #7 0x564ba1e278fb in test_and_print tests/builtin-test.c:458
    #8 0x564ba1e29a53 in __cmd_test tests/builtin-test.c:679
    #9 0x564ba1e29a53 in cmd_test tests/builtin-test.c:825
    #10 0x564ba1e95cb4 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:313
    #11 0x564ba1d1fa88 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:365
    #12 0x564ba1d1fa88 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:409
    #13 0x564ba1d1fa88 in main /home/namhyung/project/linux/tools/perf/perf.c:539
    #14 0x7f1f768e4d09 in __libc_start_main ../csu/libc-start.c:308

    ...
  test child finished with 1
  ---- end ----
  Read samples using the mmap interface: FAILED!
  failed to open shell test directory: /home/namhyung/libexec/perf-core/tests/shell

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/mmap-basic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 57093aeacc6f..73ae8f7aa066 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -158,8 +158,6 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 
 out_delete_evlist:
 	evlist__delete(evlist);
-	cpus	= NULL;
-	threads = NULL;
 out_free_cpus:
 	perf_cpu_map__put(cpus);
 out_free_threads:
-- 
2.30.1.766.gb4fecdf3b7-goog

