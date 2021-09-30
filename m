Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382FF41DC51
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351958AbhI3Od1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351923AbhI3OdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:33:12 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE288C061772
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:23 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id r1so5796842qta.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5tAiOQNbsPwYQy1X9AyljFW/jKh8PdcAlWcG2o1mwWI=;
        b=XCzx76XQyqYzRm1ibea0WoCNtcgtXq1gejadijr7/Tsm8GnPNst3oyZj3R9I9AnbJG
         lrBnaIGN9DLqClY6Iu3a0cPk49EhlCdK/rDuxQQYANtGNfP8HFek80IgFaJdn1NGVLDJ
         27ChNmLpSzUczm8ERB32kFy54GWlk57lRkLWF4zD1P65qWvy/Iad8ko3u57FmlRhAxP9
         hho1onk8yY5gm6Iw+NSNJ1q5UqXxrZlGyOQYSWjs498DAm/VFk2pIkmf5qWtWOKGMdgF
         ygnW+Ww/+cSezwh8z/XfxMhB2qr8HyapKNi3SW/qFQ+y1Vy8tWorf86vcsOyv9ttqucp
         +12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5tAiOQNbsPwYQy1X9AyljFW/jKh8PdcAlWcG2o1mwWI=;
        b=HXXJR7a0qhqufooB/PrnS0w65JSRkCxhOD2rOFdD0zOol43JfJ/WdMapLYRjz4ikkv
         Yriaf0+EPiZU6T+HcMRRwvpj3ip9jsGAJMto1qQ/QBcLigkTJ7EnOvbDJNRsVFAo+J7L
         Db/HdTNIPHUzLkaBnQysfmmPQRpYC2kgylxNy+LUBvJvlZ+6maXuSa2WYEBF7f5EKFfU
         0RqNaNfR8bu7Boi287zesrC3lOxCudoGkgSrzWHwpyd7j7YwyNt3yiAFeAxog9n1wpft
         i3HW1HSBa3xvji1vODmECvNlWx2zeUb1yE4CBtCCGBrFv+1z9TbQ3iq1WuCQBaLLKkcB
         wIRw==
X-Gm-Message-State: AOAM532Yh4MPWN4QXTCdiQSi7quoQ0J+ZfJ7J053dhvQsdsPWl4+euHf
        xLW0chmrZNDC4+9UeSuDXff7vg==
X-Google-Smtp-Source: ABdhPJy8KG5Co2knAgWKxrqUz+zTSFnivorQOkpsDEWq0y8x/CqeHR1bJLHAsbozgKtfArAnLhmX4Q==
X-Received: by 2002:ac8:4e8f:: with SMTP id 15mr6748304qtp.189.1633012282856;
        Thu, 30 Sep 2021 07:31:22 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id l195sm1528731qke.98.2021.09.30.07.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:31:22 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, kernelfans@gmail.com, akpm@linux-foundation.org
Subject: [PATCH v18 07/15] arm64: kexec: pass kimage as the only argument to relocation function
Date:   Thu, 30 Sep 2021 14:31:05 +0000
Message-Id: <20210930143113.1502553-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
References: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
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

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/asm-offsets.c     |  7 +++++++
 arch/arm64/kernel/machine_kexec.c   |  7 +++++--
 arch/arm64/kernel/relocate_kernel.S | 10 ++++------
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 551427ae8cc5..1d3319c7518e 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -9,6 +9,7 @@
 
 #include <linux/arm_sdei.h>
 #include <linux/sched.h>
+#include <linux/kexec.h>
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
 #include <linux/kvm_host.h>
@@ -170,6 +171,12 @@ int main(void)
   DEFINE(PTRAUTH_KERNEL_KEY_APIA,	offsetof(struct ptrauth_keys_kernel, apia));
 #endif
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
index 7f1cb5a2a463..e210b19592c6 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -84,6 +84,9 @@ static void kexec_list_flush(struct kimage *kimage)
 {
 	kimage_entry_t *entry;
 
+	dcache_clean_inval_poc((unsigned long)kimage,
+			       (unsigned long)kimage + sizeof(*kimage));
+
 	for (entry = &kimage->head; ; entry++) {
 		unsigned int flag;
 		unsigned long addr;
@@ -206,8 +209,8 @@ void machine_kexec(struct kimage *kimage)
 		restart(is_hyp_nvhe(), kimage->start, kimage->arch.dtb_mem,
 			0, 0);
 	} else {
-		cpu_soft_restart(kimage->arch.kern_reloc, kimage->head,
-				 kimage->start, kimage->arch.dtb_mem);
+		cpu_soft_restart(kimage->arch.kern_reloc, virt_to_phys(kimage),
+				 0, 0);
 	}
 
 	BUG(); /* Should never get here. */
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 8c43779e8cc6..63ea19868f63 100644
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
2.33.0.800.g4c38ced690-goog

