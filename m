Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01EE3BABC3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 09:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhGDHUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 03:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhGDHT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 03:19:57 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08530C0613DC
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 00:17:22 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f5so5602999pgv.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 00:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WFlg3CrTgiWrG/82i995qBaU4/AO+LdpNtCrOYN1iqs=;
        b=QVgopcqfesqC5fY1wcmSf5gnpsauKXSHgKNJZceLPwM1aXq7HJiQqYvyDSoMhLMLeE
         wxkxqKMR5V+x8xP6vRCukKWI2wGeYOnw6b00FKJ9Y/6IYG/digiEsV7zPgMa12mlmlcC
         8dch0uuVbojMIaTa0+ydQ15ROgkvOdhcmjayGRwznQaGvKOgvYqZWeuksjGLuRWyK+43
         jFKSRVQEn17tGhfRo8vFcPYuHECVlzd8xQ5tnF5/W9CHF/gcMTjtv3uel+UYDq/Omz7Y
         +xWAKfuMfu6D+Bi7lsusb0RTndv7hzCBwtMSqE6UQtfDlgodkMf9XWWQLmtWTqlwgkIQ
         davg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WFlg3CrTgiWrG/82i995qBaU4/AO+LdpNtCrOYN1iqs=;
        b=ChxDg0TZYGNU2bD86IWai2RafF/PDIuHqpP4S++RqLD3kkTx2zeDeYzxyLRwdMn4kf
         aXKVkTQBdbsMm7PHEzdcMZb02Qmv8bFGux/7h2zC8BBaTkZX6QbKa/KjoE5GgNWTuXum
         12irdwXjwDrOnMVqTejnjGy9YIzuzf1hDiyZtA6WiHPoNE38IM9CUlaIm06Oz1cPSGc2
         miuT+rmVYdBizPmn10ygQyxM5aCGMf9q2sDLKwjzjGJdjW9An1t/68bCSX0phSAL1PJK
         T+eyZ4IeL6xYL0Ies3sS4fkQnnkEllKp4bJn41q3iylOdicMlzlno7lZrdGxqnZ4QbPu
         peCw==
X-Gm-Message-State: AOAM532QSuGGkFAi6IAkrSr2bA5PmyzGAeQCppgmi1enitAXKgFt40vp
        tR0C+Kjybcp/y4pOimvwOoDMVA==
X-Google-Smtp-Source: ABdhPJw4Ra53dPv9PE6oo6mR5bJRHgZPZzLtHOc/9HREWmLKUbBaYPlBu4O7ENkyOoZeSjr3VWB4iQ==
X-Received: by 2002:a63:5513:: with SMTP id j19mr9083313pgb.192.1625383042400;
        Sun, 04 Jul 2021 00:17:22 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id z3sm9823033pgl.77.2021.07.04.00.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 00:17:21 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
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
Subject: [PATCH v3 05/10] perf auxtrace: Drop legacy __sync functions
Date:   Sun,  4 Jul 2021 15:16:39 +0800
Message-Id: <20210704071644.107397-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210704071644.107397-1-leo.yan@linaro.org>
References: <20210704071644.107397-1-leo.yan@linaro.org>
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
index cc1c1b9cec9c..f489ca159997 100644
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

