Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AECA32B73E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444827AbhCCKv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238013AbhCCA0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 19:26:20 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BA4C061226
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 16:22:46 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id n79so10743386qke.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 16:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tCKT8dQy3j0JXLfUAkLHptP8jUCHy5Mtlem3XeT2uzw=;
        b=DhKQLAF9gGWy+VQ4vEFv8vyOX67wEL5g+Ibv7M6YGg2GyOsWVpcLrO8l/KN0L5IZAc
         RxUn6cVCLaJEnn1GP49dKDyfXS2S5pAiSCfkfdBs3217gnmAIZ5KJF9kQwUjn08WVXoD
         eVb/xAgyG6HCeSJF560IMqYfvfngZgwPC0Gmto4sET2VI1otYwBlS0xkYWwsZi+5Y5wu
         CiGi9fY2dPpyuaQ0XGJefCQyLBo5uJyBd2Zt5atz0jeIcn/r/0MV3W88wPds72buWKfc
         OID9WDzMy8wulcxcHzZaME1ROXYkHzAQzPpJnO8T7pARrDaLZCrx6HDCoBT9CIwWJebN
         jArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tCKT8dQy3j0JXLfUAkLHptP8jUCHy5Mtlem3XeT2uzw=;
        b=mFrQTOTyuW7t0eAytKvBNhCWt04JXT/dX2uk46I1fYpAnxPmHTJOPQ6DC3U80NjVtv
         jWH4CV7vzvLE3fnOALWPToW/3UrWZ5+9GU+4J8zPz2pqdBR3zwK7r+rea1VJuT6ircPr
         XZCpVU2smwcH5LLBaErapxjOFt9Osio0C5HNOBNlpSEIdvT9+OF447ZJ4xtyRNpjAB9Y
         Bgt4iimm6/blCbLKI50RT/PHq3STk9gYC6gcKIn2o8qOKB2NQZpyzOuIlVUbuFugLsbt
         sxBcQWAdvkmtLRVaEiAShb7QZtnPn2r78qCc3CreH/rcOn6VMHhUa1CeSkJN98pE6t1G
         l68g==
X-Gm-Message-State: AOAM533CLTvx50jnmGMV3DlVx/IVyKb8eu+oSYakXIY0whbVNM9bHvVH
        UU12pcD4ScYDM4cMUrSd1UJOAA==
X-Google-Smtp-Source: ABdhPJz8rw5a4BVvRDYMXLHg55FhSEneNbuZ0yxoLq7h3VikY6X4yYzXWKIMomKucbL+q9Rc23LaTA==
X-Received: by 2002:a05:620a:13a5:: with SMTP id m5mr2243290qki.498.1614730966050;
        Tue, 02 Mar 2021 16:22:46 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id r3sm16690512qkm.129.2021.03.02.16.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 16:22:45 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com
Subject: [PATCH v12 10/17] arm64: kexec: pass kimage as the only argument to relocation function
Date:   Tue,  2 Mar 2021 19:22:23 -0500
Message-Id: <20210303002230.1083176-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
References: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kexec relocation function (arm64_relocate_new_kernel) accepts
the following arguments:

head:		start of array that contains relocation information.
entry:		entry point for new kernel or purgatory.
dtb_mem:	first and only argument to entry.

The number of arguments cannot be easily expended, because this
function is also called from HVC_SOFT_RESTART, which preserves only
three arguments. And, also arm64_relocate_new_kernel is written in
assembly but called without stack, thus no place to move extra arguments
to free registers.

Soon, we will need to pass more arguments: once we enable MMU we
will need to pass information about page tables.

Pass kimage to arm64_relocate_new_kernel, and teach it to get the
required fields from kimage.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/asm-offsets.c     |  7 +++++++
 arch/arm64/kernel/machine_kexec.c   |  6 ++++--
 arch/arm64/kernel/relocate_kernel.S | 10 ++++------
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index a36e2fc330d4..0c92e193f866 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -9,6 +9,7 @@
 
 #include <linux/arm_sdei.h>
 #include <linux/sched.h>
+#include <linux/kexec.h>
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
 #include <linux/kvm_host.h>
@@ -153,6 +154,12 @@ int main(void)
   DEFINE(PTRAUTH_USER_KEY_APGA,		offsetof(struct ptrauth_keys_user, apga));
   DEFINE(PTRAUTH_KERNEL_KEY_APIA,	offsetof(struct ptrauth_keys_kernel, apia));
   BLANK();
+#endif
+#ifdef CONFIG_KEXEC_CORE
+  DEFINE(KIMAGE_ARCH_DTB_MEM,		offsetof(struct kimage, arch.dtb_mem));
+  DEFINE(KIMAGE_HEAD,			offsetof(struct kimage, head));
+  DEFINE(KIMAGE_START,			offsetof(struct kimage, start));
+  BLANK();
 #endif
   return 0;
 }
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index b150b65f0b84..2e734e4ae12e 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -83,6 +83,8 @@ static void kexec_list_flush(struct kimage *kimage)
 {
 	kimage_entry_t *entry;
 
+	__flush_dcache_area(kimage, sizeof(*kimage));
+
 	for (entry = &kimage->head; ; entry++) {
 		unsigned int flag;
 		void *addr;
@@ -198,8 +200,8 @@ void machine_kexec(struct kimage *kimage)
 		restart(is_hyp_callable(), kimage->start, kimage->arch.dtb_mem,
 			0, 0);
 	} else {
-		cpu_soft_restart(kimage->arch.kern_reloc, kimage->head,
-				 kimage->start, kimage->arch.dtb_mem);
+		cpu_soft_restart(kimage->arch.kern_reloc, virt_to_phys(kimage),
+				 0, 0);
 	}
 
 	BUG(); /* Should never get here. */
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 718037bef560..36b4496524c3 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -27,9 +27,7 @@
  */
 SYM_CODE_START(arm64_relocate_new_kernel)
 	/* Setup the list loop variables. */
-	mov	x18, x2				/* x18 = dtb address */
-	mov	x17, x1				/* x17 = kimage_start */
-	mov	x16, x0				/* x16 = kimage_head */
+	ldr	x16, [x0, #KIMAGE_HEAD]		/* x16 = kimage_head */
 	mov	x14, xzr			/* x14 = entry ptr */
 	mov	x13, xzr			/* x13 = copy dest */
 	raw_dcache_line_size x15, x1		/* x15 = dcache line size */
@@ -63,12 +61,12 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 	isb
 
 	/* Start new image. */
-	mov	x0, x18
+	ldr	x4, [x0, #KIMAGE_START]		/* relocation start */
+	ldr	x0, [x0, #KIMAGE_ARCH_DTB_MEM]	/* dtb address */
 	mov	x1, xzr
 	mov	x2, xzr
 	mov	x3, xzr
-	br	x17
-
+	br	x4
 SYM_CODE_END(arm64_relocate_new_kernel)
 
 .align 3	/* To keep the 64-bit values below naturally aligned. */
-- 
2.25.1

