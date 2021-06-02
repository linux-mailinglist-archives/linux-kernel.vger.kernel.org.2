Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7D339868A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhFBKc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbhFBKcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:32:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1197FC061763
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:30:35 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g24so1405593pji.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CUGVcjWHAFZiSQpFiWcs46u9/hPtHfCUkPW2QO50s/E=;
        b=qWBMODYkIE7TtEUAD2cnjvNDYoN9T6k+wDhbdTbYweTRWm0/BluYjDGdJ3RtKnWRxA
         ZoIDaE4fheb8TK7/Z36LlFC/X8bcaNNj9jP1FBjpnknsKIPQXtsDAdCc0wPwyxspEkXe
         9kt9HLXb4abGreF5MiG6kU1qeYe2tPZpBKdL4f3GN2TTX41IDdyKu3dQhXkMeyIKQOSj
         cxlzxyp5JwtElocmliTV6usnPMu4s4vInem5hafNKawKcAtgMIHjzHdUNA24lNNDIU4K
         big+EhLIxSoP5BjeOw7SkD+8vOOnIBymiw8ZyqSRSnYj2w4TZVz0Wp+HRxRiSKu8t369
         WmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CUGVcjWHAFZiSQpFiWcs46u9/hPtHfCUkPW2QO50s/E=;
        b=CyAzMAvjCtQPcdfjU+BMBbvO5Z+EtG3z2KKEzgkk2wwQr2MNY3e2FspT+aA7BB+iNo
         xolxJ7l9LVhnkQQMoAm5lIQoYXe2YjqWM/kUcNTchOzb5BxGzrVuSGOiaCm44ys1wpwL
         6r9yLap7cEfLTi6zjzMCTTMDIbp0+GsIKju3cv3F3Bwqxutvo49N841UMfNRgZ2VK6P0
         AadTGzuPjgkdvn2EtLTaFJywXzR1+PaZO4uJEUlXPB82SfCKJ6VAsHhG0nHbL7M72fKC
         jfhRavGz0o4njDxha9f1O0G9kpdpIizL840jz4tzjV8qQq49ERYKdfozSOs5dh+WaDG+
         xyOg==
X-Gm-Message-State: AOAM533vSlJbKpWSJE1p3ZIOODtMkZ1as8diiwqnE63apw5uaeNLQFPj
        wgIm4XXAZ4DHRfqNDB0dVhoqBQ==
X-Google-Smtp-Source: ABdhPJxmZMOSfAqVmnZSxw6MnC3/8NbTY5FMoti3qh2swJ0OWGwlfyD47F9PecdyLuj4O2+EPLfQNQ==
X-Received: by 2002:a17:902:7244:b029:f5:2ffd:37f9 with SMTP id c4-20020a1709027244b02900f52ffd37f9mr30314548pll.26.1622629834563;
        Wed, 02 Jun 2021 03:30:34 -0700 (PDT)
Received: from localhost (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id j16sm2094111pgi.73.2021.06.02.03.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:30:34 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 6/8] perf auxtrace: Drop legacy __sync functions
Date:   Wed,  2 Jun 2021 18:30:05 +0800
Message-Id: <20210602103007.184993-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602103007.184993-1-leo.yan@linaro.org>
References: <20210602103007.184993-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main purpose for using __sync built-in functions is to support
compat mode for 32-bit perf with 64-bit kernel.  But using these
built-in functions might cause couple potential issues.

Firstly, __sync functions originally support Intel Itanium processoer [1]
but it cannot promise to support all 32-bit archs.  Now these
functions have become the legacy functions.

As Peter also pointed out the logic issue in the function
auxtrace_mmap__write_tail(), it does a cmpxchg with 0 values to load
old_tail, and then executes a further cmpxchg with old_tail to write
the new tail.  If consider the aux_tail might be assigned to '0' in the
middle of loops, this can introduce mess for AUX buffer if the kernel
fetches the temporary value '0'.

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
index 42b7ef811bde..e625bc76cdde 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -432,12 +432,6 @@ struct auxtrace_cache;
 
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
@@ -451,11 +445,7 @@ static inline u64 auxtrace_mmap__read_snapshot_head(struct auxtrace_mmap *mm)
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
@@ -465,19 +455,10 @@ static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
 static inline void auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
 {
 	struct perf_event_mmap_page *pc = mm->userpg;
-#if BITS_PER_LONG != 64 && defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
-	u64 old_tail;
-#endif
 
 	/* Ensure all reads are done before we write the tail out */
 	smp_mb();
-#if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
 	pc->aux_tail = tail;
-#else
-	do {
-		old_tail = __sync_val_compare_and_swap(&pc->aux_tail, 0, 0);
-	} while (!__sync_bool_compare_and_swap(&pc->aux_tail, old_tail, tail));
-#endif
 }
 
 int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
-- 
2.25.1

