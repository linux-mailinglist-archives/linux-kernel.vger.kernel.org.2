Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7304A32803B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236196AbhCAOFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbhCAOFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:05:37 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04730C061794
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 06:04:39 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id o10so11648060pgg.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJpozdva3ZbkTa3VmGhZh7jl+riL9WXH2tQS6barL4Q=;
        b=SFfM8WnVH4R6kejHgBFKyu+3HcBwLOC2ylgRr++8nKgYMMg8MU/0tcwzfffOzpOCyq
         rKpY48uIePKS5f6Yq5IxVFqnjdjWzgc3IPCsgoRpYPDkc5ls4/6CypCjllUb5kpDpqqG
         rVXKKvB+eq7ZltxVzXmp8KD/PVvam6a6IFt6X94xYhksQMEibSpjvTsgAJLna/l7+n9p
         1y+TKrnV77Zv8msEcPW2DfagbTTbBQaEUq/ArYbQpAzYPazZz/yE241FfEhP4/wgwjqj
         V8tjEAFnqS+ist4KRmObO5aPqJPaOg7A7B6Al0ZdyDKC9KKZxC4JDgZBzHlJLUTjl/ha
         Gonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=fJpozdva3ZbkTa3VmGhZh7jl+riL9WXH2tQS6barL4Q=;
        b=SbeKSWrXAgGXTE4lDUQ+TG7/luHB3Z3iynR/ql5DA9TfZSZMt7fhdC/IuWonhCdk7p
         IHq4AVKcZAxb2UaRvgbOppeNXHttgwiBP7xO/CFekOSwvQkF+6A9cZZTi8ZobpXumd84
         xXGQOdpKWRRxxZKQdMESIRmHRqEGJKQfYQOnOCUdUxYnmJbue/J2QrAQX9RXtGwr6NHD
         zW6Ok9cNnnbG5qEg/sjFtFs2+fQEbnUcQH5TCUeim1YmFnfioPTvrYWeonNdVgmo3f2P
         CTZO0woUyC1S0wgAZJJZ4kX2OJmKC7mGlEO9TQVi+fkG7wMHhxxaSHMKOR2rsgXQiVy/
         FNFw==
X-Gm-Message-State: AOAM5310c7dDY74I8XH5Vvob6wMTxjVqR/8kKPqTS8hOPapSu5/T1dyR
        shp+XSeHGeexJn8swzCxNDA=
X-Google-Smtp-Source: ABdhPJzvOY4VyQhNOLYSr93TJieRzXAEt52I4ehjtsLguhYp0lF0wS4XeJkvsBa/CcN2EfWQ1Wp4SA==
X-Received: by 2002:a63:cb52:: with SMTP id m18mr14016375pgi.358.1614607478600;
        Mon, 01 Mar 2021 06:04:38 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id v26sm17357312pff.195.2021.03.01.06.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 06:04:38 -0800 (PST)
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
Subject: [PATCH 06/11] perf test: Fix cpu and thread map leaks in keep_tracking test
Date:   Mon,  1 Mar 2021 23:04:04 +0900
Message-Id: <20210301140409.184570-7-namhyung@kernel.org>
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

  $ perf test -v 28
  28: Use a dummy software event to keep tracking:
  --- start ---
  test child forked, pid 156810
  mmap size 528384B

  =================================================================
  ==156810==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 40 byte(s) in 1 object(s) allocated from:
    #0 0x7f637d2bce8f in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:145
    #1 0x55cc6295cffa in cpu_map__trim_new /home/namhyung/project/linux/tools/lib/perf/cpumap.c:79
    #2 0x55cc6295da1f in perf_cpu_map__read /home/namhyung/project/linux/tools/lib/perf/cpumap.c:149
    #3 0x55cc6295e1df in cpu_map__read_all_cpu_map /home/namhyung/project/linux/tools/lib/perf/cpumap.c:166
    #4 0x55cc6295e1df in perf_cpu_map__new /home/namhyung/project/linux/tools/lib/perf/cpumap.c:181
    #5 0x55cc626287cf in test__keep_tracking tests/keep-tracking.c:84
    #6 0x55cc625e38fb in run_test tests/builtin-test.c:428
    #7 0x55cc625e38fb in test_and_print tests/builtin-test.c:458
    #8 0x55cc625e5a53 in __cmd_test tests/builtin-test.c:679
    #9 0x55cc625e5a53 in cmd_test tests/builtin-test.c:825
    #10 0x55cc62651cc4 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:313
    #11 0x55cc624dba88 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:365
    #12 0x55cc624dba88 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:409
    #13 0x55cc624dba88 in main /home/namhyung/project/linux/tools/perf/perf.c:539
    #14 0x7f637cdf2d09 in __libc_start_main ../csu/libc-start.c:308

  SUMMARY: AddressSanitizer: 72 byte(s) leaked in 2 allocation(s).
  test child finished with 1
  ---- end ----
  Use a dummy software event to keep tracking: FAILED!

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/keep-tracking.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index e6f1b2a38e03..a0438b0f0805 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -154,10 +154,9 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
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
 }
-- 
2.30.1.766.gb4fecdf3b7-goog

