Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725C043D096
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 20:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243490AbhJ0SXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 14:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238525AbhJ0SXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 14:23:36 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29189C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:21:11 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h2so3920211ili.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z0JfEEN3NrvM+koVgKkQP08yJNcZWbT/bek/nNBqnWY=;
        b=o5GZZjcE0JpY0ACMD/cpiyniP/1Qu914TrG4NLFbUDKZjsJ0EYuqrNLhs1o3QZdILP
         1jR8hp77/yegtSY5LuZB1yrEYjLCYKvWr3dKTcYym48grOEKuInyE6QadDnaCUlIpzFk
         ISefsuXnZYgPLjfpCHqszN6GwUqXaAoGFmibtc6Rog41/hccioGCvyPR4ZBItaloWRBL
         wNch8xh6fvo9o+arclkvC8uZMa0HdjTy2m6ftRjbp8gs1qR9uqTk4JMkTOHIXYrGwSJu
         QmmlOMnxHLHCj9NdTvjy9yPjvKRghvi7a2ihTxr+cu9OPPytPI0XH6J+YWkRFtuJSQcv
         kb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0JfEEN3NrvM+koVgKkQP08yJNcZWbT/bek/nNBqnWY=;
        b=EG0WwbAI6nwIBy9qOzzn7icRMddBw3C4IKH2ezCxbusGALHR16dCG4vrK8VxSgsA8L
         IGXFFoKomvLTwESBP4Lcw/Fy692L6rjOALHptsL+GlYXvX0WuG5E2tCDwYyLbptFR115
         Nei20hyE+trjzmKXYN5EdqCGXs7nsZqHSk5sBua+TdYtDJpepwYxEe00TV90Zfi8jdOV
         5n+gufqpDEUQu3w7FRcIF5xq0ZLHKoouAhL43Hr1rI8b/GiEjILo9wSP7qnveQiIWO8/
         B7u+g6FhCRhCrtZfw/2GUP7mrkCFxjhPPQL2PzXAA9QL+JSmSZt44e9NCT4iZUafHCnb
         heEA==
X-Gm-Message-State: AOAM530uC+40SkhmL/MDmukLJxbBmO8Yh024YyTL9LL8ankzNS7LSncX
        0LmyNkt8+aEmjwhQaru+Hxs=
X-Google-Smtp-Source: ABdhPJwzUGpiZjCcUgCB9fnRBnMybvIPpEYdnlR94d9qhLwa5ZjlsNM6c88GT8KAB5x5W7lMssiKtQ==
X-Received: by 2002:a05:6e02:1a2f:: with SMTP id g15mr18235304ile.8.1635358870367;
        Wed, 27 Oct 2021 11:21:10 -0700 (PDT)
Received: from localhost.localdomain ([2600:1008:b008:ef4c:8cf4:62d8:2368:a681])
        by smtp.googlemail.com with ESMTPSA id l13sm362050ilh.14.2021.10.27.11.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 11:21:10 -0700 (PDT)
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     goldstein.w.n@gmail.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] x86/fpu: Add helper function for tracking AVX512 status
Date:   Wed, 27 Oct 2021 13:21:02 -0500
Message-Id: <20211027182103.2569136-1-goldstein.w.n@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new helper function 'fpu_update_avx_timestamp' to perform
the logic from tracking AVX512 feature use.

Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
---
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

