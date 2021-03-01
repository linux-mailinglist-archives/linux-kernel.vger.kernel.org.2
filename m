Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87790328037
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbhCAOFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbhCAOFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:05:03 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E26C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 06:04:23 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id p21so11625181pgl.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 06:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=609QGj3cXx8NoBV/I+BxsLMaYoFrfPy5EaQ+uT7sdyA=;
        b=N8g9SoOHVIAMoMhg8eh1FndxDY+xpDPJYUlnDoXLENqpIZyPNvt51pmeVFv37ELwbB
         OS8rGsPG+MKMhYoAwTrqsH+96CATSLBsLN1h4RdjLLzwOoCSEpqQLK6Cup7D70uTqTyP
         UlnyZTQInrsHS2qbD+bDnvn1csJj4AlJdO0XYm5h9lvVnVjt9j+fR8eseSSpsN3wWK7H
         smAEwMXDzVX8srhawWTng/xUdI6L8x53RwHwkrCBsUJUgFof7k9DHCyLcm6gxiS0pF+F
         jcs6xKzQteBC71aUJpb7xkSJ4liza4A33VEuyrmkobI/3ZvfbVAgZAvYbXJcJFRxhJU4
         e/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=609QGj3cXx8NoBV/I+BxsLMaYoFrfPy5EaQ+uT7sdyA=;
        b=X0YNHQksM6A2SEKziRvpU06d4hRTmU7g2LYBPmzNFrg9MqZtoCXPMXiQqlSintv6be
         3gOX1vlxjCX+JTR01ODBapxt5XfM6fhoXukRK33L3800/OaYoqgOSvnZrd/yZYJRcDDx
         ro6zwicc+oegGi6G5RfAhv4V/JW1phAnR0CMTvmtkwVRdgwp7tcJj3342CJjvHaM3s5P
         2SbGbNIXGQ/3CUXhDWHH6jlnix+44B/p1wFji7IH0kHppLYXf6boHixi4nxyIPRT5Adh
         pBR6ciJFeDRG2ix6wJ4qkAvKoob97ElkaY+yq2OnG/YM1mWW/AydJ5Aa+b1nKgI+z03P
         9aHA==
X-Gm-Message-State: AOAM532djrEx+qm2L/WnxGC9g3ZcWHrvHj5vbrpcfq1BCeBq4FYEu7vs
        BvGv3QnR4M87H/aMP6UZ6/c=
X-Google-Smtp-Source: ABdhPJwNs70NBSWhbRKjQ9c/rlwzngQ61lGa/LFKHo1L+1njCG6z9jK2cSV2aIPuXgjqIpDwuvzWzg==
X-Received: by 2002:a65:6205:: with SMTP id d5mr13853495pgv.40.1614607462997;
        Mon, 01 Mar 2021 06:04:22 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id v26sm17357312pff.195.2021.03.01.06.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 06:04:22 -0800 (PST)
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
Subject: [PATCH 02/11] perf test: Fix a memory leak in attr test
Date:   Mon,  1 Mar 2021 23:04:00 +0900
Message-Id: <20210301140409.184570-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210301140409.184570-1-namhyung@kernel.org>
References: <20210301140409.184570-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_argv_exec_path() returns a dynamic memory so it should be
freed after use.

  $ perf test -v 17
  ...
  ==141682==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 33 byte(s) in 1 object(s) allocated from:
    #0 0x7f09107d2e8f in __interceptor_malloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:145
    #1 0x7f091035f6a7 in __vasprintf_internal libio/vasprintf.c:71

  SUMMARY: AddressSanitizer: 33 byte(s) leaked in 1 allocation(s).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/attr.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
index ec972e0892ab..dd39ce9b0277 100644
--- a/tools/perf/tests/attr.c
+++ b/tools/perf/tests/attr.c
@@ -182,14 +182,20 @@ int test__attr(struct test *test __maybe_unused, int subtest __maybe_unused)
 	struct stat st;
 	char path_perf[PATH_MAX];
 	char path_dir[PATH_MAX];
+	char *exec_path;
 
 	/* First try development tree tests. */
 	if (!lstat("./tests", &st))
 		return run_dir("./tests", "./perf");
 
+	exec_path = get_argv_exec_path();
+	if (exec_path == NULL)
+		return -1;
+
 	/* Then installed path. */
-	snprintf(path_dir,  PATH_MAX, "%s/tests", get_argv_exec_path());
+	snprintf(path_dir,  PATH_MAX, "%s/tests", exec_path);
 	snprintf(path_perf, PATH_MAX, "%s/perf", BINDIR);
+	free(exec_path);
 
 	if (!lstat(path_dir, &st) &&
 	    !lstat(path_perf, &st))
-- 
2.30.1.766.gb4fecdf3b7-goog

