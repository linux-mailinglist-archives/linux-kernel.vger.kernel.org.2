Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4345543CF8B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243212AbhJ0RUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243205AbhJ0RUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:20:04 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759BBC061745
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 10:17:38 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z144so3463316iof.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z0JfEEN3NrvM+koVgKkQP08yJNcZWbT/bek/nNBqnWY=;
        b=SL0WXcuB2hS93a6WnSkNvkSiqQkFoX+7fca0xvV30e217wg+jE2fETCEmYyER+j4ah
         BpduKFC24+BE+uLkKrmYKX9VPKgqr2eMXMBeZJClcm97ZzNtnHiOHVRtzQ3xX3j2ir5S
         RaWaJjTr8doqxReReGP+uZvcMQRowMVoQcFvU6Z+5TBCkENKvTSZeMF+RZgg6kdOMPOC
         ai1JbD+oUFqlSbBxj7YAwOhzzOhjcbTa66wAihkeuxXKesuZozY1zz+mZhLM41dAb5nK
         foETbCUf8Rod3DVEM0NmVxiOPMN0EhKxdXfr+cVwoaAOsy3FoIbdsy+vhXpV3BslQ7PA
         Lz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0JfEEN3NrvM+koVgKkQP08yJNcZWbT/bek/nNBqnWY=;
        b=AGfjrDlIuq/LAP7svvep6K9iTF4IZQSZw+U9iqy5mp40OHEnke6AsmAuqmkQ2RertE
         kx8Ar2EOZWI4dpIMQdF28IzP1WxoXWQLqY1BZzhUXJnEyYVX2/2MhTOiazPGvRG4iIG/
         4WLnHyAFmdvvyCmSwdbbrJdwxmpKWKuFizeq46oCGAqV/1qAhwWEBGf3envGduzwWlje
         y3+vWFm44Uyy3WASgLdSZG01WsK75o4lRU1C91OZIHUxb/RE7Ysd1FhTBgtpu2c8Q84M
         AQhbZ3FU0YSB+5gS1JCc7idvK2N+PjZXmPu2N2gRtBre4s12d4WzPziWC4N/8DC9D5qg
         HBkg==
X-Gm-Message-State: AOAM530yU4nYxuFJCKct2kaQ1sYMMx6hTgkhCQlwtNCR2zBXd7GOzpac
        RutWPzuxOY2V5jv7/G6ysM8=
X-Google-Smtp-Source: ABdhPJxX66jYMlSl/H7+xYW9T82tuyS4MgOUu8m8iqR29AqNGEVvU2mjWnYEjdWqENktiwU4VuuH2Q==
X-Received: by 2002:a05:6638:3389:: with SMTP id h9mr20553801jav.4.1635355057361;
        Wed, 27 Oct 2021 10:17:37 -0700 (PDT)
Received: from localhost.localdomain ([2600:1008:b008:ef4c:8cf4:62d8:2368:a681])
        by smtp.googlemail.com with ESMTPSA id h1sm267611iow.12.2021.10.27.10.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 10:17:37 -0700 (PDT)
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     goldstein.w.n@gmail.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] x86/fpu: Add helper function for tracking AVX512 status
Date:   Wed, 27 Oct 2021 12:17:29 -0500
Message-Id: <20211027171730.1992414-1-goldstein.w.n@gmail.com>
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

