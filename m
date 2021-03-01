Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498B5328044
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbhCAOHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236183AbhCAOFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:05:44 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FA1C0617AA
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 06:04:54 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id s23so11913910pji.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W6CTPWiokMKD0QHodMWlzIYXuYU5dBEexD0NQKteVJY=;
        b=R6n/nJyPqGkNPVPIqWLA/c6o6GeT1y9qU/dtYAKc5DzioeWNiBkgHGLoaWTaibjt2E
         TLqcZrrA26KBAMSZh04g1d/Q2yVfYiT9mvkSHQ6NZ2cowa++5JUOQcqz02UrCBRnRS1q
         NBxVRu6aHEcW8iJPDFHP2J1fgUvGOj8Il2l8RIadPH+Q3RToL4HVjy0kkZeZI/5F1xNR
         sT9qxpsmc9FdVm/Xcvi3tBxgpJIzuIBL+Ft7tI9+7M5+AzadEakn1t+U59o052uradaI
         NnW3yBvccH+C04zVbHq4HlbXit0QY8yvRrYKR3gtfLaPLVAlR12CQK5+X6MWvQMzOfa7
         OhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=W6CTPWiokMKD0QHodMWlzIYXuYU5dBEexD0NQKteVJY=;
        b=QYj4f8berLB63/PEoxe4JGcUhfVeE5wMIveSgzYg5OvC6Ka3PvscaB6buRHe6u+F9O
         a24NCgvEEiZM5uxhNwX25iyH4Ev3FXZmg+7idnH7ZvmXIR+O38W+QBi6JJod8N4ieltK
         urjHHRJVOSztkX34VbNJjUeaH+Xf3uIwwhpq+AUV0vEICEDO9o90llvjjX351GZ+JpZy
         PRqz7/nb96ATtz1cRBslZBsTMfhbJlX2nu5ryQygZ7leXvD+lgAB4cA3UiX5wktr3i3V
         NzUWRtnF61Jre4ghZRqoXk248iwqMSett8P5GVVHx8WZqfZivYCA3yESUVdlD8NN0dZq
         Do6g==
X-Gm-Message-State: AOAM532SIO7FF88a1cx8pOLcWoMlMkQfsKDgYODis8SuUyNFguh3dBK0
        HXAoOu4OZlo8Zf2IjOTKTLw=
X-Google-Smtp-Source: ABdhPJwAY3eTnNrCFf584hvJj3hyRNBoCpcSA8r0AufX9f9TleGTFU35ZXkU/Bq/GgZC2L6RO0oxNw==
X-Received: by 2002:a17:902:7c0e:b029:e4:f26:1367 with SMTP id x14-20020a1709027c0eb02900e40f261367mr15869044pll.32.1614607494230;
        Mon, 01 Mar 2021 06:04:54 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id v26sm17357312pff.195.2021.03.01.06.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 06:04:53 -0800 (PST)
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
Subject: [PATCH 10/11] perf test: Fix cpu map leaks in cpu_map_print test
Date:   Mon,  1 Mar 2021 23:04:08 +0900
Message-Id: <20210301140409.184570-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210301140409.184570-1-namhyung@kernel.org>
References: <20210301140409.184570-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be released after printing the map.

  $ perf test -v 52
  52: Print cpu map                              :
  --- start ---
  test child forked, pid 172233

  =================================================================
  ==172233==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 156 byte(s) in 1 object(s) allocated from:
    #0 0x7fc472518e8f in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:145
    #1 0x55e63b378f7a in cpu_map__trim_new /home/namhyung/project/linux/tools/lib/perf/cpumap.c:79
    #2 0x55e63b37a05c in perf_cpu_map__new /home/namhyung/project/linux/tools/lib/perf/cpumap.c:237
    #3 0x55e63b056d16 in cpu_map_print tests/cpumap.c:102
    #4 0x55e63b056d16 in test__cpu_map_print tests/cpumap.c:120
    #5 0x55e63afff8fb in run_test tests/builtin-test.c:428
    #6 0x55e63afff8fb in test_and_print tests/builtin-test.c:458
    #7 0x55e63b001a53 in __cmd_test tests/builtin-test.c:679
    #8 0x55e63b001a53 in cmd_test tests/builtin-test.c:825
    #9 0x55e63b06dc44 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:313
    #10 0x55e63aef7a88 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:365
    #11 0x55e63aef7a88 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:409
    #12 0x55e63aef7a88 in main /home/namhyung/project/linux/tools/perf/perf.c:539
    #13 0x7fc47204ed09 in __libc_start_main ../csu/libc-start.c:308
  ...

  SUMMARY: AddressSanitizer: 448 byte(s) leaked in 7 allocation(s).
  test child finished with 1
  ---- end ----
  Print cpu map: FAILED!

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/cpumap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 29c793ac7d10..0472b110fe65 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -106,6 +106,8 @@ static int cpu_map_print(const char *str)
 		return -1;
 
 	cpu_map__snprint(map, buf, sizeof(buf));
+	perf_cpu_map__put(map);
+
 	return !strcmp(buf, str);
 }
 
-- 
2.30.1.766.gb4fecdf3b7-goog

