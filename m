Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E691943CEB9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239460AbhJ0Q2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238291AbhJ0Q2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:28:52 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C437C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 09:26:27 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id l13so3588398ilh.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 09:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o7brrv2eIdGkldhIc125Crlzlu+dhxRGy8607dg5Bag=;
        b=JFbTnmL3UiwOGwjPJHVv4VqyFe938jK/h0hVMmpEFoxkT9pwbaAervknsSV/+gTi+1
         qpIL+UV+8qpuzOHvDIXGQyVo0fmy4wbVGropatq7TrdW2fcvWLDY8v8ZV7euTt9FWDkw
         x8kQkS0HiWP8nZQ03UfN5LX0FxGlnYh3Xz4QQguEjam1AAxbkrPcb2yC2ELOmDm8mvOL
         YCUC3inPByaeUoDPU+n1Ek54U+Ijzh5+ChnLKvPpi1w+grYlCqnJRTh3NWdxkUATLkKQ
         Vj0yMqxMjn96qtbt6I32ZfoPRTQh+aTjEDYi89o8NO2RY3y1W+DMLArp7iHPFMxgxiiH
         bJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o7brrv2eIdGkldhIc125Crlzlu+dhxRGy8607dg5Bag=;
        b=FwJpLT28Ncku6px9kZf8PLGT6hNwXXCaqLzuKPZuJSbfD272ckWFpL+DfPwmAOAZi4
         dMxxho+Bu30sZfYU7lOn7wB3gQddINHKc0p7rcVgQvzPBBsCVsMdzReT9XnjN6fLqxUv
         mAy+IcwRPJCjs/fN2wLdGusVQ/EFh62siOAziDK2xnvVuSrLMnC8kzsbFHYOuVuw/0pi
         G79Xctq5M1fig96HmfA0oVm4PV4fMcl440W76+dMGvKNZiVZLtu7yi454yLnjQIh24lz
         km2O4CfQv31Bl09vAeGO5Ce2PHxIWPwzBEkn8SVMDEIiuFKEEC3uZkzCrMitvWIWdfxf
         DtRA==
X-Gm-Message-State: AOAM533BC7k0kwFU4untsSonIvkMs8hOsz3goz3qL2sKyBkOgCUIqOuV
        P8ttC5rsGDNyIaKhLAM+2J8=
X-Google-Smtp-Source: ABdhPJxl3GloT/1VjH31rmaHT6WrBzBhJU6C0QKo85VWnd8UK9ShGdq6NrkrXXGiJzyib67WJxAl/A==
X-Received: by 2002:a05:6e02:1a4d:: with SMTP id u13mr13622705ilv.118.1635351986586;
        Wed, 27 Oct 2021 09:26:26 -0700 (PDT)
Received: from localhost.localdomain ([2600:1008:b008:ef4c:5fd0:5407:cbca:b181])
        by smtp.googlemail.com with ESMTPSA id f4sm182318ioc.15.2021.10.27.09.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 09:26:26 -0700 (PDT)
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     goldstein.w.n@gmail.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] x86/xstate: Make AVX512 status tracking more accurate
Date:   Wed, 27 Oct 2021 11:26:15 -0500
Message-Id: <20211027162615.1989004-2-goldstein.w.n@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211027162615.1989004-1-goldstein.w.n@gmail.com>
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
 <20211027162615.1989004-1-goldstein.w.n@gmail.com>
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
 arch/x86/include/asm/fpu/types.h | 16 ++++++++--
 arch/x86/kernel/fpu/xstate.c     | 53 +++++++++++++++++++++++++++-----
 2 files changed, 58 insertions(+), 11 deletions(-)

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
index 00b495914be2..3bb1a425ce56 100644
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
@@ -1282,8 +1292,35 @@ static void avx512_status(struct seq_file *m, struct task_struct *task)
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
+	long delta_ZMM_Hi256, delta_Hi16_ZMM, delta_unified;
+
+	timestamp = READ_ONCE(task->thread.fpu.avx512_ZMM_Hi256_timestamp);
+	delta_ZMM_Hi256 = avx_status_compute_delta(timestamp);
+
+	timestamp = READ_ONCE(task->thread.fpu.avx512_Hi16_ZMM_timestamp);
+	delta_Hi16_ZMM = avx_status_compute_delta(timestamp);
+
+	/*
+	 * Report unified delta of most recent AVX512 usage from either
+	 * Hi16_ZMM or ZMM_Hi256 xfeature sets.
+	 */
+	delta_unified = timestamp ? delta_Hi16_ZMM : delta_ZMM_Hi256;
+
+	seq_put_decimal_ll(m, "AVX512_elapsed_ms:\t", delta_unified);
+	seq_putc(m, '\n');
+	seq_put_decimal_ll(m, "AVX512_ZMM_Hi256_elapsed_ms:\t", delta_ZMM_Hi256);
+	seq_putc(m, '\n');
+	seq_put_decimal_ll(m, "AVX512_Hi16_ZMM_elapsed_ms:\t", delta_Hi16_ZMM);
 	seq_putc(m, '\n');
 }
 
-- 
2.25.1

