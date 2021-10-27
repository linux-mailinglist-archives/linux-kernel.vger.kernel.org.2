Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B7343CEB8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239399AbhJ0Q2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238291AbhJ0Q2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:28:48 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F91FC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 09:26:23 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id w15so3567821ilv.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 09:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GkHgqsPLWP2Por3hRq6T43PNNF4dsLg88Od58cwYUbk=;
        b=SnS0uiKLrcl9x/TNpWu9JOJYucdB3p+WvNZpkq6njrY90EASO4eyLgcer1rDOkVbUd
         MiU4Nv5Z0VrKscxusMrX9EJbmUHpprjtPQedB9ZX+YCw9vXzcX7/fpXWfmrdpnTVCMAv
         pKrksdoaQnvmxgI8OKbTTMPlb1lB6r1tAjgHHE6L1WDdmbHLLqfdlNwnPcXLG72fIb0l
         a1mlv2w46U1O+wG2izGZYVyuLyhvL8jsQ4c2NQNFndRgf+67p0aX+eZu/b4zhuqjtFVG
         4K0bff4c0ciMt7APgTpeIsF0/ww2zQISPngwMWX0Z6oG/x7dnYjjRv/FHJUdcA51wTWY
         SZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GkHgqsPLWP2Por3hRq6T43PNNF4dsLg88Od58cwYUbk=;
        b=ldxuKaUOjswVzVelHythCwxHEcx7fS1NBRnmQ1ZTAF7bYutQjYIAutsUkx/u5XTeyg
         LCJE3uxXrVJeEUbj992cA/lRs7FsKQ6nmEugjbIHDdIaNXOcSgtYrap3hP99OMPqQJYx
         GNrjb33s7iqc8g7bdPIQvOikMBke2FPr+QvxF/xoQxrrbp7tIqg/4TgZZ6GYmY+G2EjV
         /KrRn5x5ndYWN5TeQOeUBcPoBB1v9K0KjyfrYgwGuZjtyrsSgqdgEgRYpa1FkkqdkJYR
         utqBYJg2cx4ZyhIuGOtJR2jE37Uz10Xxoc8Tkl7jrYn8NKAD4iRPAYJQo1j5KMcQKzYP
         gs5w==
X-Gm-Message-State: AOAM533Rqv7sYvtFKVIUZfn/XJfR1HkqwfEHvsXdb3ZDfIxAlos8lKFV
        nNzArcREMbM4zAIbAnW5OvY=
X-Google-Smtp-Source: ABdhPJwl5DzX0FYgLOaFUUX7ieiaj+EwahzFtaLWMoTjMV9jDh/6oac2b/cus+/DVF32MQV4iFxxgw==
X-Received: by 2002:a05:6e02:19cc:: with SMTP id r12mr18744925ill.277.1635351982814;
        Wed, 27 Oct 2021 09:26:22 -0700 (PDT)
Received: from localhost.localdomain ([2600:1008:b008:ef4c:5fd0:5407:cbca:b181])
        by smtp.googlemail.com with ESMTPSA id f4sm182318ioc.15.2021.10.27.09.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 09:26:22 -0700 (PDT)
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     goldstein.w.n@gmail.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] x86/fpu: Add helper function for tracking AVX512 status
Date:   Wed, 27 Oct 2021 11:26:14 -0500
Message-Id: <20211027162615.1989004-1-goldstein.w.n@gmail.com>
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

