Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAC83C3B9B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 12:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhGKKoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 06:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbhGKKoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 06:44:21 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CB4C0613F0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 03:41:34 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id a2so14968552pgi.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 03:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KBSuwCB1b/ChF6VSdcQNyQNSh8bYSwVqW8B8R0ec9VE=;
        b=xhWgw3iFr8/U4uX5kgVIqi8ul9JY2MhFFBYkxejz8PQMqDSEorI99wAJunU2RdzZ17
         eYWXhkgmQawPN+JFA7m1t9Zs7Rxy5NuMFnh1eVuGqL4/Z0kZUTyn7EiTQkruZ1fSAydf
         zqhl+pqNfYK0nR/RmO8sdSNY7xRcAiEUdSy475K10ur+gTOGBArHJbFf/sTAbwSZveUp
         8LnNyciIcuw0hYKnFxxfrH+0Waxw7J/EyRD3eU1XfcPJo3Yra1honTD2gKKT1uRRBQma
         4ibgvKdwYo9P3NTwKRwIvrcKgQYTOV4xF4MksP53rfQLPa6WM1ZKJoO1N08B7KGpIC7m
         5hPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KBSuwCB1b/ChF6VSdcQNyQNSh8bYSwVqW8B8R0ec9VE=;
        b=P62Pq0rC/F42vc2h+evR5EHB6pqa+qTOTlA929H3D6WjbjNjry3c0Qo4elDNVvgIrx
         gIaRgccrJETRXl/FLcyZQOK2aUTW5elYSv8IbF8huZmXMpK0gDQ7vY4MHJr3VfYCNDSo
         FQmAJVhLPOjMtVG0657u8XNIFdZ262jpOE3mq4k3Tta5y7dDvtis7/QtWn9VOiJnKCdx
         E8htpFbZ0e159n/ae+r3FdRqEkgwxP1e6mCWNHsiK58imj2vgMlvXv1QxGUfc9qhB3lM
         rYSv7M4Rz6yLV4rKHEEbYY7r16lwsxgrM1HQBO9ncXFChVzmHu3zBGXa7h+mQXu/pABE
         zfhw==
X-Gm-Message-State: AOAM531Y3o0sEznMhHsLdd3kvlII91dNPP6WwDAoQ1Yr6n5JS8xFzZFA
        lSZFnMl8b8H4sfsuWQYZZ2G0fA==
X-Google-Smtp-Source: ABdhPJwC8GIL92CJjSBM4G2vFFafsb76iiIzhffr9ihFZpGjdy5CpBKQnHtopqY2sy/WZ55qhKoINA==
X-Received: by 2002:a65:56ca:: with SMTP id w10mr39995173pgs.107.1626000093757;
        Sun, 11 Jul 2021 03:41:33 -0700 (PDT)
Received: from localhost ([103.127.241.250])
        by smtp.gmail.com with ESMTPSA id d23sm10206682pjd.25.2021.07.11.03.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 03:41:33 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 06/11] perf auxtrace: Drop legacy __sync functions
Date:   Sun, 11 Jul 2021 18:41:00 +0800
Message-Id: <20210711104105.505728-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210711104105.505728-1-leo.yan@linaro.org>
References: <20210711104105.505728-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main purpose for using __sync built-in functions is to support
compat mode for 32-bit perf with 64-bit kernel.  But using these
built-in functions might cause potential issues.

__sync functions originally support Intel Itanium processoer [1]
but it cannot promise to support all 32-bit archs.  Now these
functions have become the legacy functions.

Considering __sync functions cannot really fix the 64-bit value
atomicity on 32-bit archs, thus this patch drops __sync functions.

Credits to Peter for detailed analysis.

[1] https://gcc.gnu.org/onlinedocs/gcc/_005f_005fsync-Builtins.html#g_t_005f_005fsync-Builtins

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/auxtrace.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 79227b8864cd..4f9176368134 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -440,12 +440,6 @@ struct auxtrace_cache;
 
 #ifdef HAVE_AUXTRACE_SUPPORT
 
-/*
- * In snapshot mode the mmapped page is read-only which makes using
- * __sync_val_compare_and_swap() problematic.  However, snapshot mode expects
- * the buffer is not updated while the snapshot is made (e.g. Intel PT disables
- * the event) so there is not a race anyway.
- */
 static inline u64 auxtrace_mmap__read_snapshot_head(struct auxtrace_mmap *mm)
 {
 	struct perf_event_mmap_page *pc = mm->userpg;
@@ -459,11 +453,7 @@ static inline u64 auxtrace_mmap__read_snapshot_head(struct auxtrace_mmap *mm)
 static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
 {
 	struct perf_event_mmap_page *pc = mm->userpg;
-#if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
 	u64 head = READ_ONCE(pc->aux_head);
-#else
-	u64 head = __sync_val_compare_and_swap(&pc->aux_head, 0, 0);
-#endif
 
 	/* Ensure all reads are done after we read the head */
 	smp_rmb();
@@ -473,19 +463,10 @@ static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
 static inline void auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
 {
 	struct perf_event_mmap_page *pc = mm->userpg;
-#if BITS_PER_LONG != 64 && defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
-	u64 old_tail;
-#endif
 
 	/* Ensure all reads are done before we write the tail out */
 	smp_mb();
-#if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
 	WRITE_ONCE(pc->aux_tail, tail);
-#else
-	do {
-		old_tail = __sync_val_compare_and_swap(&pc->aux_tail, 0, 0);
-	} while (!__sync_bool_compare_and_swap(&pc->aux_tail, old_tail, tail));
-#endif
 }
 
 int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
-- 
2.25.1

