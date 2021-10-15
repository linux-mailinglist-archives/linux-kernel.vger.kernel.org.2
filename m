Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AF942FD26
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 22:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243019AbhJOU7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 16:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243008AbhJOU7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 16:59:54 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B41C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 13:57:47 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e144so9179092iof.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 13:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+45kZLjbRoSQ8La61suYeVKn3fR09BjMBbIw4mqmdLw=;
        b=m/Yia34VjTtqTx3ItQvUgwBIz2moghgdwwMp1/C0zdJ7hnAc6VRCT1NJYNLaeo9Xoh
         NVtRG796yPi/4SZIXMWbu/FtnU6cfEEQK7ltBd0cZDPd9Hi327EngI+ncV0Gw3dZ4n1y
         cwxWa4qqG7/xEnoD1G1HgcszBf11AV9dHWE4WbIqEHKnV6lhQ0azzBzmHK59WFOUjIgF
         ZZ+0X6a1oPChcWJzEkXD46WqhW68Dsrg1rZWMmlpArm2s92/LsTOcCKz+U/EyALFp3Bp
         TqifFywfBq+er5+X+aKr2mHxibrCumhaj5yW+MfV8F82RjzoeV6pnRETvV63Ckzq79xT
         L6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+45kZLjbRoSQ8La61suYeVKn3fR09BjMBbIw4mqmdLw=;
        b=jlphbuW8zCg6Dd0SxobMPGv4B8t5s3xfShkw+9ahFqPK8K7eq6SUpNhUS97vkJC4Kj
         KHaDLkxUD7De2gLD+/cY9tuSTcdqYP3ukXytLcbWUMQdZW4riWrBYpFOwS+qqeW5YFvs
         Yze04VstX1HSPce48c/zoEewNqhk7Cw4lXqkrAYyNBJBvbCGwuHFuUG/3bMRLr5vdPst
         Jr87jOE9Q4PN1rWutSNjEMo1vHu26o9hmDAMoq4WdifHyN8Md6Ic5I5t1B1Kc68jQPvQ
         hDSP1YjDuoKKD3eP48yJtwHbjJUyUIcvH2YQQh9j7VK9HePTLWYfb8jDPJbDSPJ99c4I
         u1nA==
X-Gm-Message-State: AOAM532oaDvDVCn5JRYVRe9H9Z+U2/Fr6MzNmPPE8hLkRPTqhHMT65/w
        v6zKfEEFl8cCPOeHS71flHc20tleGSc7RQ==
X-Google-Smtp-Source: ABdhPJwIMDHjTFxlIjeXRTV8gj1aL0GdP3UqUm2VoGa1PCK+BEJUhw3rrpb7Bt8MxcXOKNCH464odg==
X-Received: by 2002:a5d:9751:: with SMTP id c17mr5319525ioo.61.1634331466646;
        Fri, 15 Oct 2021 13:57:46 -0700 (PDT)
Received: from localhost.localdomain (mobile-130-126-255-38.near.illinois.edu. [130.126.255.38])
        by smtp.googlemail.com with ESMTPSA id z14sm3256732ill.34.2021.10.15.13.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 13:57:46 -0700 (PDT)
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     goldstein.w.n@gmail.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] x86/fpu: Add helper function for tracking AVX512 status
Date:   Fri, 15 Oct 2021 15:47:15 -0500
Message-Id: <20211015204713.2855996-1-goldstein.w.n@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a new helper function 'fpu_update_avx_timestamp' to
perform the logic from tracking AVX512 feature use.

Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
---
Since Borislav Petkov is concerned about adding more macro masks and
inlining the AVX512 status this patch adds a new helper function. This
patch does not change the behavior of the current AVX512 status.

 arch/x86/include/asm/fpu/xstate.h |  1 +
 arch/x86/kernel/fpu/core.c        |  6 ++----
 arch/x86/kernel/fpu/xstate.c      | 13 +++++++++++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 109dfcc75299..fe84ac5fb039 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -134,6 +134,7 @@ extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
 extern void __init update_regset_xstate_info(unsigned int size,
 					     u64 xstate_mask);
 
+void fpu_update_avx_timestamp(struct fpu *fpu);
 void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
 int xfeature_size(int xfeature_nr);
 int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 7ada7bd03a32..6dbf3ee642f9 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -102,11 +102,9 @@ void save_fpregs_to_fpstate(struct fpu *fpu)
 		os_xsave(&fpu->state.xsave);
 
 		/*
-		 * AVX512 state is tracked here because its use is
-		 * known to slow the max clock speed of the core.
+		 * Track of the state of desired avx related xfeatures.
 		 */
-		if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
-			fpu->avx512_timestamp = jiffies;
+		fpu_update_avx_timestamp(fpu);
 		return;
 	}
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c8def1b7f8fb..00b495914be2 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1245,6 +1245,19 @@ void xrstors(struct xregs_state *xstate, u64 mask)
 	WARN_ON_ONCE(err);
 }
 
+/*
+ * Track of the state of desired avx architecture features.
+ */
+void fpu_update_avx_timestamp(struct fpu *fpu)
+{
+	/*
+	 * AVX512 state is tracked here because its use is known to slow
+	 * the max clock speed of the core.
+	 */
+	if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
+		fpu->avx512_timestamp = jiffies;
+}
+
 #ifdef CONFIG_PROC_PID_ARCH_STATUS
 /*
  * Report the amount of time elapsed in millisecond since last AVX512
-- 
2.25.1

