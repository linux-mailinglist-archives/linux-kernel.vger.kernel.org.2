Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F793357B16
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 06:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbhDHEGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 00:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhDHEGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 00:06:03 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CC9C061762
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 21:05:53 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 30so254466qva.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 21:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tCKT8dQy3j0JXLfUAkLHptP8jUCHy5Mtlem3XeT2uzw=;
        b=F6JZkU80674Q1VkhfFm80eRIhlT4LTp68/RErf1725v9DYSxSAh29UWw3UDtiBURG4
         u0n2ebEhoDt5HtuTO3kincM93W8gSFAACO87UbFvfg+TKnnlfjDa1iPq5U8D9ey2nSYN
         W4fhKnt/bDMPuHnnAp6P4c6OLXcnEd6kMmzkgMOyEPsn0UhQt+5PjB55hUmuN0Nzpzap
         +0rOYzqOJLSwje/mdtbOjaL0CrjS19OmEbMqcXf4HNwEkMAZ64+V0SJ6fNu52Frq1oIh
         KlDteFSrD5AR4g5pbiIAHi0PC+tohcS908vNFFXwicB+eWCfa4xnX2RXlCj6/FZxVMFm
         scaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tCKT8dQy3j0JXLfUAkLHptP8jUCHy5Mtlem3XeT2uzw=;
        b=T5SoE/YrVJAhi/NyirCn02nIYY7Iw24wYO6fXFPbm5UoTlCDSbEc9pid2NVbV3vrDz
         1crpBb0apjsZCQo0HsEfnfl4JLZ/92n8+jS1NMst3fqxUAnot1x1gPOg7v6+GViWt881
         rW+5V02tarTYq8Qa6RzBB3VxPoTTUdCypX+Qd2oPXiqIRwAuhEevc0PWLxpnERyVdOy7
         5cf6F7w+mBwuM1PokV7p6laANsZJ74AtajQYScrJNj45XoNELLNpc5AayG0onsfZT1X1
         Pr047pbwyF4ZSVyW5Eg4N1PLF4/503KUR4GBqFoljzp4v8MapPnh9sqduQ06rmiXaFAs
         rWtg==
X-Gm-Message-State: AOAM531Q8Ab5PM18m0TLikWgrRmIEI8tOzjGQd7oXb8g6I+o70bMi8xN
        KsJeY08Qdf76MWyulONUqYhRFg==
X-Google-Smtp-Source: ABdhPJy34xVqJvda6lNplCUNEP3hwQatijEVRlmosHFcsSuFccjv0kKbw6AfhQKTmbRewTzaiAP2bw==
X-Received: by 2002:a0c:80e1:: with SMTP id 88mr6471448qvb.43.1617854752265;
        Wed, 07 Apr 2021 21:05:52 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 207sm18177874qkl.125.2021.04.07.21.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 21:05:51 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com,
        kernelfans@gmail.com
Subject: [PATCH v13 10/18] arm64: kexec: pass kimage as the only argument to relocation function
Date:   Thu,  8 Apr 2021 00:05:29 -0400
Message-Id: <20210408040537.2703241-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
References: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
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

