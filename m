Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86A633BF02
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241603AbhCOOxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237270AbhCOOgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:36:52 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B0AC0613D7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:51 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id m17so2910942wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 07:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AA7WNBlUpAMSn2MPgzLs0H4xGSlUKHXKOJZW0a7DVr8=;
        b=HeeWafaKs1HfgyYwhqnBsqj7EK/JP92Y1I97LGu+XsaGNx4whjki/w/Xz28ogNllvE
         b0nYVRKWRncPCFEbY0JXosEAosQURum1lxLWf6JY4ooTP7CEqSoUkpG+z3FsL8xKO4sn
         V85Ha8YcUJ/k28GR12KlKLEz8Uz4W6Vf2vyEBz9epFHY6S1Q+U4MS8mR1c6sD/QWlCgc
         I8wdtWxIEQ2QqVHUVh1zepYacBo20vrjz7i8tIJOsNoqxBx0JdsK4KZksiihTA39E4SJ
         8Of/8rpeQD6QG4DxY7Qa3HgzKToUx87gJXhwQx0yE97b3VWUmrjYUOymLfDY67HKJcmu
         D7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AA7WNBlUpAMSn2MPgzLs0H4xGSlUKHXKOJZW0a7DVr8=;
        b=eFWKqM7VkSY64mbKLCdXsMjvL1GBCFJIXFji1pRygysRoS1vIACVfHvsOvYbr8Slbh
         abHS/L6EXjRauFT3P4+kn1RHnHCM6O8iFVDpZSYkiXpcHTov/C2/oLCwEqccPoYU9pMs
         fyuXCMu4YepcAH6LQauVS58itmx+Lps4L3VRtm1UK8gPafvIZWGsBqBsvU3ufFthmevo
         BhMSu6ldP8BFlFw6t4xqd6Z4zQqAqyHaoVMCHsSk+9OWrKH6aq0Oh5vd1Yk5qhcBozcJ
         OLPIEIFbVTYKuP6w2ZM2cl6YfYdmY7pYkHZL0w+3DEUXq8fSZl3kmoLOz3IA63pu7WXm
         7Kfg==
X-Gm-Message-State: AOAM532J2DxHelyTo08Kfw9QrIPiRJJulC3SZGbe709UsuW5K9aur6vh
        FCUwy0sQRzAXq8+OikIT4FfmTW8BN2hq
X-Google-Smtp-Source: ABdhPJxAvSUEErjsvOYHEMkOG9WC8BDpEz7C+7gjZsMj3MWQ0vfpsnAIsGPSV9GXjDX/nZy7FrSUOvIbWZvo
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:600c:b57:: with SMTP id
 k23mr14700303wmr.145.1615819010555; Mon, 15 Mar 2021 07:36:50 -0700 (PDT)
Date:   Mon, 15 Mar 2021 14:35:34 +0000
In-Reply-To: <20210315143536.214621-1-qperret@google.com>
Message-Id: <20210315143536.214621-35-qperret@google.com>
Mime-Version: 1.0
References: <20210315143536.214621-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v5 34/36] KVM: arm64: Page-align the .hyp sections
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will soon unmap the .hyp sections from the host stage 2 in Protected
nVHE mode, which obviously works with at least page granularity, so make
sure to align them correctly.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kernel/vmlinux.lds.S | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index e96173ce211b..709d2c433c5e 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -15,9 +15,11 @@
 
 #define HYPERVISOR_DATA_SECTIONS				\
 	HYP_SECTION_NAME(.rodata) : {				\
+		. = ALIGN(PAGE_SIZE);				\
 		__hyp_rodata_start = .;				\
 		*(HYP_SECTION_NAME(.data..ro_after_init))	\
 		*(HYP_SECTION_NAME(.rodata))			\
+		. = ALIGN(PAGE_SIZE);				\
 		__hyp_rodata_end = .;				\
 	}
 
@@ -72,21 +74,14 @@ ENTRY(_text)
 jiffies = jiffies_64;
 
 #define HYPERVISOR_TEXT					\
-	/*						\
-	 * Align to 4 KB so that			\
-	 * a) the HYP vector table is at its minimum	\
-	 *    alignment of 2048 bytes			\
-	 * b) the HYP init code will not cross a page	\
-	 *    boundary if its size does not exceed	\
-	 *    4 KB (see related ASSERT() below)		\
-	 */						\
-	. = ALIGN(SZ_4K);				\
+	. = ALIGN(PAGE_SIZE);				\
 	__hyp_idmap_text_start = .;			\
 	*(.hyp.idmap.text)				\
 	__hyp_idmap_text_end = .;			\
 	__hyp_text_start = .;				\
 	*(.hyp.text)					\
 	HYPERVISOR_EXTABLE				\
+	. = ALIGN(PAGE_SIZE);				\
 	__hyp_text_end = .;
 
 #define IDMAP_TEXT					\
@@ -322,11 +317,12 @@ SECTIONS
 #include "image-vars.h"
 
 /*
- * The HYP init code and ID map text can't be longer than a page each,
- * and should not cross a page boundary.
+ * The HYP init code and ID map text can't be longer than a page each. The
+ * former is page-aligned, but the latter may not be with 16K or 64K pages, so
+ * it should also not cross a page boundary.
  */
-ASSERT(__hyp_idmap_text_end - (__hyp_idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
-	"HYP init code too big or misaligned")
+ASSERT(__hyp_idmap_text_end - __hyp_idmap_text_start <= PAGE_SIZE,
+	"HYP init code too big")
 ASSERT(__idmap_text_end - (__idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
 	"ID map text too big or misaligned")
 #ifdef CONFIG_HIBERNATION
-- 
2.31.0.rc2.261.g7f71774620-goog

