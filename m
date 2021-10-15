Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDBA42FD27
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 22:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243025AbhJOVAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 17:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243021AbhJOVAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 17:00:01 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17063C061764
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 13:57:55 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id b188so4264447iof.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 13:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ng5lmD+yP6i7srl+K6BARDSW+bDnT6b0wLTasZ4P3E=;
        b=EhSHMTa9HUYkAJ+9kWFNRSBfofd2dmFjMcJj2WXrL1IGZ9h9EpUP9K3t+MkpDLv1Us
         5J34HzKM0zwxlNf2TOB/nlss74G+6jVrzbsAbnB3oUYn8bR44cOc5II4QF+nU1SUPoGv
         BLphbZfP9n+Ba6VHMnWhjeVIj+kAqM9XtTrnJLH+EQ39BtNzFGkVw59J+Gvg2srEHr3V
         N295ZXxtvChBlFvCk5d7D2DTvqA/GnJ6tXespyTo0SbnzfWqIcMN+fu0eTrLiD2n9uFg
         /O8cy9Nnb1PSPXHAkMUtc43h5FQBzEAt7oxMFAx5zPzDpv4Enf/o69B2m/8swp4aHv2m
         W98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ng5lmD+yP6i7srl+K6BARDSW+bDnT6b0wLTasZ4P3E=;
        b=MClJx8JlQ3jONIOOCTxS9vjXFu6nRMG3qlPZKkPRjLKnFOZM9DjGeVg/bBtrjErDne
         OQrkHUrk7Bnao9O7gQHD7wWwN3niwkjbwg581cngnxw8t2wdqltSO5mDIE86AiUibzFT
         J6W86eqMBDYJVdn0asIEwO9t4rr6AilAXKpXswJ/j3BVHAdkCwG/YK1UCjpwl+1UCDBq
         1dQq5wtfZHPnQ6ZBcS84xaRoNNlcZbTsOHPDP25FT9gss0LZzA5PKJOGaMMuZixCF1qb
         dl10Ezgq4+yFBjmGbN8S9wfQR6n9ZjVX+0G7xyJQObxKq7bF5AcBllAb6YHCIeNpJJzR
         6bHg==
X-Gm-Message-State: AOAM531xR+eZepZOXD3u1RAueu+L+ETQAcvMyzM5FYxn7Co11JvUhm4r
        0+sOonr/zqvWh2ihp132pkc=
X-Google-Smtp-Source: ABdhPJx2WOuR0qxziSBNDaQgRwRkchV+4yBVPK7vbSgwx2Uz/4D+4lh15oE8/hGHzlhQdLKBW8e0hQ==
X-Received: by 2002:a02:6064:: with SMTP id d36mr9954553jaf.80.1634331474427;
        Fri, 15 Oct 2021 13:57:54 -0700 (PDT)
Received: from localhost.localdomain (mobile-130-126-255-38.near.illinois.edu. [130.126.255.38])
        by smtp.googlemail.com with ESMTPSA id z14sm3256732ill.34.2021.10.15.13.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 13:57:54 -0700 (PDT)
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     goldstein.w.n@gmail.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] x86/xstate: Make AVX512 status tracking more accurate
Date:   Fri, 15 Oct 2021 15:47:17 -0500
Message-Id: <20211015204713.2855996-2-goldstein.w.n@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch splits the timestamps for tracking the AVX512 status into
'avx512_ZMM_Hi256_timestamp' and 'avx512_Hi16_ZMM_timestamp'. They are
used for tracking XFEATURE_ZMM_Hi256 and XFEATURE_Hi16_ZMM use
respectively.

The purpose of tracking the AVX512 status is to convey information
about possible frequency throttling. The current implementation has
false positives on XFEATURE_OPMASK use and any usage of the hi16 xmm
and ymm registers which are included in the XFEATURE_Hi16_ZMM set as
neither will cause frequency throttling.

This patches implementation avoids to add more clarity to the
output. The 'avx512_ZMM_Hi256_timestamp' will not have false positives
so its value will at least be indicative frequency throttling. Since
'avx512_Hi16_ZMM_timestamp' can still indicate frequency throttling
from zmm16...zmm31 use though had false positives it is separated.

Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
---
Because (Hi16_ZMM | ZMM_Hi256) will likely be full of false positives
on any machine that support avx512 I split the avx512_timestamp.

One to track Hi16_ZMM and one for ZMM_Hi256. My though is it's not
good to add more holes where the status doesn't report, but also have
fields that will be useful and not be burdened by false positives.

This might be overdoing it. If so we can either use a both of both or
just ZMM_Hi256.

 arch/x86/include/asm/fpu/types.h | 16 +++++++++---
 arch/x86/kernel/fpu/xstate.c     | 45 ++++++++++++++++++++++++++------
 2 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index f5a38a5f3ae1..cb10909fa3da 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -330,11 +330,21 @@ struct fpu {
 	unsigned int			last_cpu;
 
 	/*
-	 * @avx512_timestamp:
+	 * @avx512_ZMM_Hi256_timestamp:
 	 *
-	 * Records the timestamp of AVX512 use during last context switch.
+	 * Records the timestamp of AVX512 use in the ZMM_Hi256 xfeature
+	 * set. This include zmm0...zmm15.
 	 */
-	unsigned long			avx512_timestamp;
+	unsigned long			avx512_ZMM_Hi256_timestamp;
+
+	/*
+	 * @avx512_Hi16_ZMM_timestamp:
+	 *
+	 * Records the timestamp of AVX512 use in the Hi16_ZMM xfeature
+	 * set. This includes usage of any of the hi16 xmm, ymm, or zmm
+	 * registers.
+	 */
+	unsigned long			avx512_Hi16_ZMM_timestamp;
 
 	/*
 	 * @state:
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 00b495914be2..5b0ff609af2f 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1246,7 +1246,7 @@ void xrstors(struct xregs_state *xstate, u64 mask)
 }
 
 /*
- * Track of the state of desired avx architecture features.
+ * Track of the state of desired avx related xfeatures.
  */
 void fpu_update_avx_timestamp(struct fpu *fpu)
 {
@@ -1254,18 +1254,28 @@ void fpu_update_avx_timestamp(struct fpu *fpu)
 	 * AVX512 state is tracked here because its use is known to slow
 	 * the max clock speed of the core.
 	 */
-	if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
-		fpu->avx512_timestamp = jiffies;
+
+	/*
+	 * Store a separate state for ZMM_Hi256 and Hi16_ZMM xfeature use.
+	 * If ZMM_Hi256 is used the machine has certainly used a zmm
+	 * register.  Hi16_ZMM, however, has false positives on usage of
+	 * hi16 xmm and ymm registers.
+	 */
+	if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_ZMM_Hi256)
+		fpu->avx512_ZMM_Hi256_timestamp = jiffies;
+	if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_Hi16_ZMM)
+		fpu->avx512_Hi16_ZMM_timestamp = jiffies;
 }
 
+
 #ifdef CONFIG_PROC_PID_ARCH_STATUS
+
 /*
- * Report the amount of time elapsed in millisecond since last AVX512
- * use in the task.
+ * Helper function for computing proper output for avx512_status
+ * timestamp.
  */
-static void avx512_status(struct seq_file *m, struct task_struct *task)
+static long avx_status_compute_delta(unsigned long timestamp)
 {
-	unsigned long timestamp = READ_ONCE(task->thread.fpu.avx512_timestamp);
 	long delta;
 
 	if (!timestamp) {
@@ -1282,8 +1292,27 @@ static void avx512_status(struct seq_file *m, struct task_struct *task)
 			delta = LONG_MAX;
 		delta = jiffies_to_msecs(delta);
 	}
+	return delta;
+}
 
-	seq_put_decimal_ll(m, "AVX512_elapsed_ms:\t", delta);
+/*
+ * Report the amount of time elapsed in millisecond since last AVX512
+ * use in the task.
+ */
+static void avx512_status(struct seq_file *m, struct task_struct *task)
+{
+	unsigned long timestamp;
+	long delta_ZMM_Hi256, delta_Hi16_ZMM;
+
+	timestamp = READ_ONCE(task->thread.fpu.avx512_ZMM_Hi256_timestamp);
+	delta_ZMM_Hi256 = avx_status_compute_delta(timestamp);
+
+	timestamp = READ_ONCE(task->thread.fpu.avx512_Hi16_ZMM_timestamp);
+	delta_Hi16_ZMM = avx_status_compute_delta(timestamp);
+
+	seq_put_decimal_ll(m, "AVX512_ZMM_Hi256_elapsed_ms:\t", delta_ZMM_Hi256);
+	seq_putc(m, '\n');
+	seq_put_decimal_ll(m, "AVX512_Hi16_ZMM_elapsed_ms:\t", delta_Hi16_ZMM);
 	seq_putc(m, '\n');
 }
 
-- 
2.25.1

