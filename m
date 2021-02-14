Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436BB31AFCC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 10:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhBNJR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 04:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhBNJRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 04:17:25 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FA7C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 01:16:45 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id t26so2538794pgv.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 01:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LnrmFhPP+bHLppfAnXafOhMn04ZvwK7N/l8/4Hql9vo=;
        b=C+f2wZoXXdHbavXjYmBxvFppW13cgfXRTPv7mtYX0ikvi/G28RDNGeJN8Q/J4EN0SB
         pi9KbBlGaTsZ9iCokuyUKGgTLngyNvOey/VBvGV2QOQ0eDKQtanJDrjifLmP+3gXaCDH
         e2B2LYem8kaMzIQvzKhHuTgPrdzA64k8HpE0lp8kILZ7AKQoW8MzZDASPgORY16hH2xc
         gjajbohGYUkIYazbSVq3uNOSwAlSAZ/zQHLGhA8sMNPaOpGXseGxSJ76UG47ObZSNCJo
         6uu0B5TCSVEf7mUbAVMhmtHP77hkS9UZ7ZmuDo9+FYQceiROaqNnF+5apOfZcem4nkML
         8+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=LnrmFhPP+bHLppfAnXafOhMn04ZvwK7N/l8/4Hql9vo=;
        b=RfMB4E1gb5EWRFX52RGwFBPTtM6stJaMTDuDwOGafowPxT6MhlCwDr4xoV3SH20B9c
         hqXe8ZhCArLcBFqFtOqPWWPZhYaZrKOoagCdRkkkiSGODjG4qiYsfwCuURXI5uXc8tF7
         NRYg8OsRy1CpdQXt4l/v/uWxAjO9oLSYg9r/iCA5/JkOydhvbu1tzeKuEoqSxF6zev8/
         /h92mWdcMFmSXHeF6BKIPBwBKUQwKkuMjUNqGqc36GYW9ktMxqvrRVGGRw3yIUqIXcmq
         Ye0uvLtjwlvZ0DcndE0/UfX6h60SzubjlqFOaZ6QQjq02kxwX2Dpl9oO7J7e0Ol/aUs9
         yJFQ==
X-Gm-Message-State: AOAM532zSjzTuh116oe+MGmpzjex5//gg1mzgbIuNiDp2D+V9bK1c+gG
        IvL15zq49kA17NWXUyLmdvY=
X-Google-Smtp-Source: ABdhPJzSy1SyWcvXyUZSdORBz7QkVvdtueEJBG5FeHJSgXv2qDGYzul1KfMHGFbtCDb1vITc0tPW0w==
X-Received: by 2002:a63:1b1b:: with SMTP id b27mr10421800pgb.377.1613294204572;
        Sun, 14 Feb 2021 01:16:44 -0800 (PST)
Received: from balhae.roam.corp.google.com ([114.129.115.223])
        by smtp.gmail.com with ESMTPSA id a5sm14209422pgh.15.2021.02.14.01.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 01:16:43 -0800 (PST)
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
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] perf test: Fix unaligned access in sample parsing test
Date:   Sun, 14 Feb 2021 18:16:38 +0900
Message-Id: <20210214091638.519643-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ubsan reported the following error.  It was because sample's raw
data missed u32 padding at the end.  So it broke the alignment of the
array after it.

The raw data contains an u32 size prefix so the data size should have
an u32 padding after 8-byte aligned data.

27: Sample parsing  :util/synthetic-events.c:1539:4:
  runtime error: store to misaligned address 0x62100006b9bc for type
  '__u64' (aka 'unsigned long long'), which requires 8 byte alignment
0x62100006b9bc: note: pointer points here
  00 00 00 00 ff ff ff ff  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
              ^
    #0 0x561532a9fc96 in perf_event__synthesize_sample util/synthetic-events.c:1539:13
    #1 0x5615327f4a4f in do_test tests/sample-parsing.c:284:8
    #2 0x5615327f3f50 in test__sample_parsing tests/sample-parsing.c:381:9
    #3 0x56153279d3a1 in run_test tests/builtin-test.c:424:9
    #4 0x56153279c836 in test_and_print tests/builtin-test.c:454:9
    #5 0x56153279b7eb in __cmd_test tests/builtin-test.c:675:4
    #6 0x56153279abf0 in cmd_test tests/builtin-test.c:821:9
    #7 0x56153264e796 in run_builtin perf.c:312:11
    #8 0x56153264cf03 in handle_internal_command perf.c:364:8
    #9 0x56153264e47d in run_argv perf.c:408:2
    #10 0x56153264c9a9 in main perf.c:538:3
    #11 0x7f137ab6fbbc in __libc_start_main (/lib64/libc.so.6+0x38bbc)
    #12 0x561532596828 in _start ...

SUMMARY: UndefinedBehaviorSanitizer: misaligned-pointer-use
 util/synthetic-events.c:1539:4 in

Fixes: 045f8cd8542d ("perf tests: Add a sample parsing test")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/sample-parsing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index f506eabfc269..0dbe3aa99853 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -202,7 +202,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 		.data = {1, -1ULL, 211, 212, 213},
 	};
 	u64 regs[64];
-	const u64 raw_data[] = {0x123456780a0b0c0dULL, 0x1102030405060708ULL};
+	const u32 raw_data[] = {0x12345678, 0x0a0b0c0d, 0x11020304, 0x05060708, 0 };
 	const u64 data[] = {0x2211443366558877ULL, 0, 0xaabbccddeeff4321ULL};
 	const u64 aux_data[] = {0xa55a, 0, 0xeeddee, 0x0282028202820282};
 	struct perf_sample sample = {
-- 
2.30.0.478.g8a0d178c01-goog

