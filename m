Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B96328040
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhCAOGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbhCAOFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:05:44 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD6AC0617A9
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 06:04:50 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id c19so11251690pjq.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zB8v0ibvHDb15iQ6LaSZi2hKdZTEPMivTYLL6oYfoTg=;
        b=QtsnfwPgskqqLRgxRCQbpj1GAdZXqtacYnsaDFKlEoMuTsbcXMJzF7gK/1pROvZxxS
         nIp1xMW1tFec7IaqtZmAtQymjzNgc3OPY6Fm7H1xPtgWDm1l+xxoOkzYLd09IIi9PqLQ
         4EfG323lJfc3kWVNyv1tno1i1Ftj0+HGf2/7fotI01JC8TA3CcYXyBvYZ7I9OZGgGvUr
         XzYjDoy2kwJCZTCIFZew7jfbyzxjqLiM/vSRiGj+41kA3dHHlF/CkwL8VcEWMa8jPuwM
         OfzQNMYKK2pehhxjPwxg9GaxRNJxgQ1VLAE/8uiktaZ2cg0w3D/uiFizClV9fv0OBBvY
         dTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zB8v0ibvHDb15iQ6LaSZi2hKdZTEPMivTYLL6oYfoTg=;
        b=Xta5jSYGyZ4O+VJkodGH2QYYYsBu4xfix8hgbI6E1DQWOP0cQL3I99TctToVynDUvP
         2M/gciNtWYfBYnUm41sf90FzwRXotML/WusfbZ53hhZn4hijGWx5sVAUpj+S02pWNu5a
         d/VV/V1XwDd5YwZ0YSwy8nGGaYoWy8Up+FCeU+S73lTsKJzK54y/VOxe++x1CD3M6xA+
         He0uahui2eBAmonx/MIz0hGek0EB6A7bKwG1HHfsiJCIolzMpwoQrHxRIGUdOTBaLduP
         xEvLg2/NLXHj6lcmXbWvPO28qjszweSHHFy9jPQ61wKOKl0yx3sTRM7hlosTgiBHdUnD
         sgMA==
X-Gm-Message-State: AOAM533/QoS4cK6C4qrlTZKD2qo31QldLkqbQbxQ1SeE5KiKwGk3mn6B
        j737NWy4jmrKD4A3zKYP8g4=
X-Google-Smtp-Source: ABdhPJxKqhboZyDWmNmY0bb5+67L1paU4id6ybpXY2NRYxr9NqAKVTLATZUBIhXsWB5d0CH7zqjLkg==
X-Received: by 2002:a17:902:c083:b029:e4:84c5:6ac8 with SMTP id j3-20020a170902c083b02900e484c56ac8mr11622017pld.71.1614607490379;
        Mon, 01 Mar 2021 06:04:50 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id v26sm17357312pff.195.2021.03.01.06.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 06:04:49 -0800 (PST)
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
Subject: [PATCH 09/11] perf test: Fix a memory leak in thread_map_remove test
Date:   Mon,  1 Mar 2021 23:04:07 +0900
Message-Id: <20210301140409.184570-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210301140409.184570-1-namhyung@kernel.org>
References: <20210301140409.184570-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The str should be freed after creating a thread map.  Also change the
open-coded thread map deletion to a call to perf_thread_map__put().

  $ perf test -v 44
  44: Remove thread map                          :
  --- start ---
  test child forked, pid 165536
  2 threads: 165535, 165536
  1 thread: 165536
  0 thread:

  =================================================================
  ==165536==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 14 byte(s) in 1 object(s) allocated from:
    #0 0x7f54453ffe8f in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:145
    #1 0x7f5444f8c6a7 in __vasprintf_internal libio/vasprintf.c:71

  SUMMARY: AddressSanitizer: 14 byte(s) leaked in 1 allocation(s).
  test child finished with 1
  ---- end ----
  Remove thread map: FAILED!

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/thread-map.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index 9e1cf11149ef..d1e208b4a571 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -110,12 +110,12 @@ int test__thread_map_remove(struct test *test __maybe_unused, int subtest __mayb
 {
 	struct perf_thread_map *threads;
 	char *str;
-	int i;
 
 	TEST_ASSERT_VAL("failed to allocate map string",
 			asprintf(&str, "%d,%d", getpid(), getppid()) >= 0);
 
 	threads = thread_map__new_str(str, NULL, 0, false);
+	free(str);
 
 	TEST_ASSERT_VAL("failed to allocate thread_map",
 			threads);
@@ -142,9 +142,6 @@ int test__thread_map_remove(struct test *test __maybe_unused, int subtest __mayb
 	TEST_ASSERT_VAL("failed to not remove thread",
 			thread_map__remove(threads, 0));
 
-	for (i = 0; i < threads->nr; i++)
-		zfree(&threads->map[i].comm);
-
-	free(threads);
+	perf_thread_map__put(threads);
 	return 0;
 }
-- 
2.30.1.766.gb4fecdf3b7-goog

