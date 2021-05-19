Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D18388FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353783AbhESOFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240179AbhESOEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:04:50 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3822DC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:03:30 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 10so9978640pfl.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kxXfuNlS/xOSvTcuxAtst1GJYgtNU95iIej614YptKs=;
        b=r0PNqUr8bt4M6wTks4TGgdWKQLfopdZMqazDhkaTlnJX8W5JSMGfuVwAic3ahPYSaO
         zR2/Dz5YBPe936mUquW0bDzdfgo+mlWOZq1rrCwsaA8kRZIH6uFLlRjNfGamFD7xW8sv
         SlR0LGHbB9Vx7W7zyq4cCAVnHTiBn8o7RNy81k6TO3ujzL+h/PhVRMT0dC9mM8gXzWvp
         Agol5vPAIE5XQVQpDw5941uexS5vUdddeV3PyfGyDP2nWG9BjDl8i/UVPE4Xh4eOJKG7
         BYhE8Cb2+XLL5oFAPMuxMYfYBNhcUyjOSIivSmCoTpz3faHyqd8swb7GG9t4ADDydYBK
         lSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kxXfuNlS/xOSvTcuxAtst1GJYgtNU95iIej614YptKs=;
        b=edXWOiDx9WZvGPtSuRYZv1LhemJ5LZLC3bLg7NwbXbpMb1up3DdhjoLyXkqHIMOMxb
         51SKJ5rmYBUupfKYdzX8zUhIc5vdMf3ly45P/rA7+smsOdd8eKeObAut0Y+gKdWMbip2
         3vToJ6nMadueO3c7xb1nZUW7/8UBNvf98uh+3GfPRHAbyelGQDQnDO+aOY2I5IfbM/sE
         WpDD0YfpzM8XNmmIYUlS0W/jhuR1mFnesTtsxjqvSh5NR6cnGIRvu4iw1sA3nRoK3brm
         ljr6odyoKwraMwPn3QgtHVoUCglqavwOBYNHLrJgVetRF5ErkWeExbn8T0qz2F8vnf2n
         ZLxQ==
X-Gm-Message-State: AOAM532zAGpQLR/jfohdjh5A+p7IKyspogj7EMJ/KKfOc8VBN44Eoh+t
        wzmvcDhHu9FLAGDtnv21q438wA==
X-Google-Smtp-Source: ABdhPJx2fpDVgc+q9xwFrO9/2LqKSAUWe20sUAPO6MMOiZrzOT2+/DxH2Qlfrd6E3vZtQwzFlCFA6w==
X-Received: by 2002:a63:ba1b:: with SMTP id k27mr11094416pgf.381.1621433009720;
        Wed, 19 May 2021 07:03:29 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id y13sm10107799pgp.16.2021.05.19.07.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:03:29 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/2] perf auxtrace: Optimize barriers with load-acquire and store-release
Date:   Wed, 19 May 2021 22:03:19 +0800
Message-Id: <20210519140319.1673043-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519140319.1673043-1-leo.yan@linaro.org>
References: <20210519140319.1673043-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Load-acquire and store-release are one-way permeable barriers, which can
be used to guarantee the memory ordering between accessing the buffer
data and the buffer's head / tail.

This patch optimizes the memory ordering with the load-acquire and
store-release barriers.

If the load-acquire is not supported by the architectures, it uses the
existed READ_ONCE() + smp_rmb() pair rather than use the fallback
definition of smp_load_acquire().  The reason is smp_rmb() is a minor
improvement than smp_mb() which is called in the fallback macro
smp_load_acquire().

In auxtrace_mmap__write_tail(), updating the tail pointer is removed; if
the store-release barrier is not supported, it rollbacks to use
smp_mb() + WRITE_ONCE() pair which is defined in the fallback macro
smp_store_release() (see include/asm/barrier.h).

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/auxtrace.h | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 8bed284ccc82..f18070f1993f 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -449,16 +449,27 @@ struct auxtrace_cache;
 static inline u64 auxtrace_mmap__read_snapshot_head(struct auxtrace_mmap *mm)
 {
 	struct perf_event_mmap_page *pc = mm->userpg;
+
+#if defined(__x86_64__) || defined(__aarch64__) || defined(__powerpc64__) || \
+    defined(__ia64__) || defined(__sparc__) && defined(__arch64__)
+	return smp_load_acquire(&pc->aux_head);
+#else
 	u64 head = READ_ONCE(pc->aux_head);
 
 	/* Ensure all reads are done after we read the head */
 	smp_rmb();
 	return head;
+#endif
 }
 
 static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
 {
 	struct perf_event_mmap_page *pc = mm->userpg;
+
+#if defined(__x86_64__) || defined(__aarch64__) || defined(__powerpc64__) || \
+    defined(__ia64__) || defined(__sparc__) && defined(__arch64__)
+	return smp_load_acquire(&pc->aux_head);
+#else
 #if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
 	u64 head = READ_ONCE(pc->aux_head);
 #else
@@ -468,20 +479,20 @@ static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
 	/* Ensure all reads are done after we read the head */
 	smp_rmb();
 	return head;
+#endif
 }
 
 static inline void auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
 {
 	struct perf_event_mmap_page *pc = mm->userpg;
-#if BITS_PER_LONG != 64 && defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
+
+#if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
+	smp_store_release(&pc->aux_tail, tail);
+#else
 	u64 old_tail;
-#endif
 
 	/* Ensure all reads are done before we write the tail out */
 	smp_mb();
-#if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
-	pc->aux_tail = tail;
-#else
 	do {
 		old_tail = __sync_val_compare_and_swap(&pc->aux_tail, 0, 0);
 	} while (!__sync_bool_compare_and_swap(&pc->aux_tail, old_tail, tail));
-- 
2.25.1

