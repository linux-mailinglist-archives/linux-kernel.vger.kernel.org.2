Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8354845373E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 17:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhKPQYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhKPQYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:24:46 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E373FC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 08:21:48 -0800 (PST)
Received: from zn.tnic (p200300ec2f139500c63f2e8e3aeb06f1.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:9500:c63f:2e8e:3aeb:6f1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A98A51EC03C9;
        Tue, 16 Nov 2021 17:21:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1637079706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xu3/F+5C8EDq8ldijfymvLEzkqgXk0D/Bm0pPYbM/bg=;
        b=Vxk3h8CvT5rQgwgxH+z3gOV+Yr9nRD/BhNylMDj2X8wehHWmSxmjzS9dXB5lvdeDtsh50q
        iZIP+7zfat8tq3wLi/6ZBAFVkhAo672aC1cGFme5UkZkrlL8YlvxdGPl4tMam920/4TcME
        gfnIkZ4JgYKXF1wqNIhRRtDk08V6/XI=
Date:   Tue, 16 Nov 2021 17:21:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, luto@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/fpu: Correct AVX512 state tracking
Message-ID: <YZPakmnn75rCvUMo@zn.tnic>
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
 <20211027182103.2569136-1-goldstein.w.n@gmail.com>
 <20211027182103.2569136-2-goldstein.w.n@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211027182103.2569136-2-goldstein.w.n@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does that still work with your test case? (Ontop of -rc1)

---
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Tue, 16 Nov 2021 17:14:21 +0100
Subject: [PATCH] x86/fpu: Correct AVX512 state tracking

Add a separate, local mask for tracking AVX512 usage which does not
include the opmask xfeature set. Opmask registers usage does not cause
frequency throttling so it is a completely unnecessary false positive.

While at it, carve it out into a separate function to keep that
abomination extracted out.

 [ bp: Rediff and cleanup ontop of 5.16-rc1. ]

Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20210920053951.4093668-1-goldstein.w.n@gmail.com
---
 arch/x86/kernel/fpu/core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 8ea306b1bf8e..dd3777ac0443 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -98,6 +98,19 @@ bool irq_fpu_usable(void)
 }
 EXPORT_SYMBOL(irq_fpu_usable);
 
+/*
+ * Track AVX512 state use because it is known to slow the max clock
+ * speed of the core.
+ */
+static void update_avx_timestamp(struct fpu *fpu)
+{
+
+#define AVX512_TRACKING_MASK	(XFEATURE_MASK_ZMM_Hi256 | XFEATURE_MASK_Hi16_ZMM)
+
+	if (fpu->fpstate->regs.xsave.header.xfeatures & AVX512_TRACKING_MASK)
+		fpu->avx512_timestamp = jiffies;
+}
+
 /*
  * Save the FPU register state in fpu->fpstate->regs. The register state is
  * preserved.
@@ -116,13 +129,7 @@ void save_fpregs_to_fpstate(struct fpu *fpu)
 {
 	if (likely(use_xsave())) {
 		os_xsave(fpu->fpstate);
-
-		/*
-		 * AVX512 state is tracked here because its use is
-		 * known to slow the max clock speed of the core.
-		 */
-		if (fpu->fpstate->regs.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
-			fpu->avx512_timestamp = jiffies;
+		update_avx_timestamp(fpu);
 		return;
 	}
 
-- 
2.29.2


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
