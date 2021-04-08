Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333EE357B1A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 06:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhDHEGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 00:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhDHEGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 00:06:10 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8168FC061761
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 21:05:59 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id u8so440415qtq.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 21:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2MwMRNHUNcBKpMF1hToORmuQtXmVKMCROcbjizX1Pao=;
        b=fpo5AOYCGm3rnQMF4k4Kep/dfrnGm0E++/dJ0VrKIb2VHU6OudZV1VTAwgm8LinIqD
         yxDQzUb6g4ZO7W1zZuk5Xy1KCgLYe0bDuxlE1I85vxW8d11idj7Koq+4BwzP1LqXvRkT
         2dMKemIvcTZ0HaQwfZtVjjuH9s1RAs2kq4RBntnYZxjJOey8rqC25tRwXrVjQzgjG1tZ
         ukpM0SxnmPuiC/eHb6fb/k9eolxaVTtBTwI9qiJ1Ol/j2GzD4T9XnqADIa0xrddwtB1Z
         tx2k9hhtZcvliRagOHSKFqvfv1hCu+4aDq7lVINevfwTKrZ0jmPaYk9rLS/UjlnbLCLd
         mwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2MwMRNHUNcBKpMF1hToORmuQtXmVKMCROcbjizX1Pao=;
        b=St869aDlbrz1lsiExxcmnj5jxqTYad2HRFnY4ZNKzWysPF02Kxc9ACp0NOS/dV0byR
         DwpZknLRMBX9N4W0av4OIf7F6YOMO+A0DJUK3t1d/2tub20GarcjTmRy2D92JcbZyQQ3
         E2NGN3rYm0yMoEgclkZPhW19UzWv8CqULhHoAFr9ijGszY/opbdQVi5mj8THhEkh5+jI
         Vc6i0yd9hFfTq722PW1JweghcdgB6UYLUG8KV1dC5xBQY9TLiJBGUkSnHnWXav1bS3vK
         aqM3Aqpo9NX1OLVKAtgMVGQ/tyJpTgOUGe7ljEITr3Na5WYvtE0k+3aAP2wSd4ksJMOs
         jL8w==
X-Gm-Message-State: AOAM530SGtxyMv9iu9SgbxXpaf1KDqITyKEPwBSEW9XrxMpYijQfUnop
        a1aSgJEqofoG0pU1jEUdGgT5Dw==
X-Google-Smtp-Source: ABdhPJxVaJ3kci0H5jEVPHKEH/dGd4Hj0zfNx1cig37iSok8prwWbLZDkAcKO+o7C9aiRkKogLnWYA==
X-Received: by 2002:ac8:5c95:: with SMTP id r21mr5804477qta.347.1617854758731;
        Wed, 07 Apr 2021 21:05:58 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 207sm18177874qkl.125.2021.04.07.21.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 21:05:58 -0700 (PDT)
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
Subject: [PATCH v13 15/18] arm64: kexec: keep MMU enabled during kexec relocation
Date:   Thu,  8 Apr 2021 00:05:34 -0400
Message-Id: <20210408040537.2703241-16-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
References: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, that we have linear map page tables configured, keep MMU enabled
to allow faster relocation of segments to final destination.


Cavium ThunderX2:
Kernel Image size: 38M Iniramfs size: 46M Total relocation size: 84M
MMU-disabled:
relocation	7.489539915s
MMU-enabled:
relocation	0.03946095s

Broadcom Stingray:
The performance data: for a moderate size kernel + initramfs: 25M the
relocation was taking 0.382s, with enabled MMU it now takes
0.019s only or x20 improvement.

The time is proportional to the size of relocation, therefore if initramfs
is larger, 100M it could take over a second.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h      |  3 +++
 arch/arm64/kernel/asm-offsets.c     |  1 +
 arch/arm64/kernel/machine_kexec.c   | 16 ++++++++++----
 arch/arm64/kernel/relocate_kernel.S | 33 +++++++++++++++++++----------
 4 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 59ac166daf53..5fc87b51f8a9 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -97,8 +97,11 @@ struct kimage_arch {
 	phys_addr_t dtb_mem;
 	phys_addr_t kern_reloc;
 	phys_addr_t el2_vectors;
+	phys_addr_t ttbr0;
 	phys_addr_t ttbr1;
 	phys_addr_t zero_page;
+	unsigned long phys_offset;
+	unsigned long t0sz;
 	/* Core ELF header buffer */
 	void *elf_headers;
 	unsigned long elf_headers_mem;
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 609362b5aa76..ec7bb80aedc8 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -159,6 +159,7 @@ int main(void)
   DEFINE(KIMAGE_ARCH_DTB_MEM,		offsetof(struct kimage, arch.dtb_mem));
   DEFINE(KIMAGE_ARCH_EL2_VECTORS,	offsetof(struct kimage, arch.el2_vectors));
   DEFINE(KIMAGE_ARCH_ZERO_PAGE,		offsetof(struct kimage, arch.zero_page));
+  DEFINE(KIMAGE_ARCH_PHYS_OFFSET,	offsetof(struct kimage, arch.phys_offset));
   DEFINE(KIMAGE_ARCH_TTBR1,		offsetof(struct kimage, arch.ttbr1));
   DEFINE(KIMAGE_HEAD,			offsetof(struct kimage, head));
   DEFINE(KIMAGE_START,			offsetof(struct kimage, start));
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index c875ef522e53..d5c8aefc66f3 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -190,6 +190,11 @@ int machine_kexec_post_load(struct kimage *kimage)
 	reloc_size = __relocate_new_kernel_end - __relocate_new_kernel_start;
 	memcpy(reloc_code, __relocate_new_kernel_start, reloc_size);
 	kimage->arch.kern_reloc = __pa(reloc_code);
+	rc = trans_pgd_idmap_page(&info, &kimage->arch.ttbr0,
+				  &kimage->arch.t0sz, reloc_code);
+	if (rc)
+		return rc;
+	kimage->arch.phys_offset = virt_to_phys(kimage) - (long)kimage;
 
 	/* Flush the reloc_code in preparation for its execution. */
 	__flush_dcache_area(reloc_code, reloc_size);
@@ -223,9 +228,9 @@ void machine_kexec(struct kimage *kimage)
 	local_daif_mask();
 
 	/*
-	 * Both restart and cpu_soft_restart will shutdown the MMU, disable data
+	 * Both restart and kernel_reloc will shutdown the MMU, disable data
 	 * caches. However, restart will start new kernel or purgatory directly,
-	 * cpu_soft_restart will transfer control to arm64_relocate_new_kernel
+	 * kernel_reloc contains the body of arm64_relocate_new_kernel
 	 * In kexec case, kimage->start points to purgatory assuming that
 	 * kernel entry and dtb address are embedded in purgatory by
 	 * userspace (kexec-tools).
@@ -239,10 +244,13 @@ void machine_kexec(struct kimage *kimage)
 		restart(is_hyp_callable(), kimage->start, kimage->arch.dtb_mem,
 			0, 0);
 	} else {
+		void (*kernel_reloc)(struct kimage *kimage);
+
 		if (is_hyp_callable())
 			__hyp_set_vectors(kimage->arch.el2_vectors);
-		cpu_soft_restart(kimage->arch.kern_reloc,
-				 virt_to_phys(kimage), 0, 0);
+		cpu_install_ttbr0(kimage->arch.ttbr0, kimage->arch.t0sz);
+		kernel_reloc = (void *)kimage->arch.kern_reloc;
+		kernel_reloc(kimage);
 	}
 
 	BUG(); /* Should never get here. */
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index e83b6380907d..433a57b3d76e 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -4,6 +4,8 @@
  *
  * Copyright (C) Linaro.
  * Copyright (C) Huawei Futurewei Technologies.
+ * Copyright (C) 2020, Microsoft Corporation.
+ * Pavel Tatashin <pasha.tatashin@soleen.com>
  */
 
 #include <linux/kexec.h>
@@ -15,6 +17,15 @@
 #include <asm/sysreg.h>
 #include <asm/virt.h>
 
+.macro turn_off_mmu tmp1, tmp2
+	mrs	\tmp1, sctlr_el1
+	mov_q	\tmp2, SCTLR_ELx_FLAGS
+	bic	\tmp1, \tmp1, \tmp2
+	pre_disable_mmu_workaround
+	msr	sctlr_el1, \tmp1
+	isb
+.endm
+
 .pushsection    ".kexec_relocate.text", "ax"
 /*
  * arm64_relocate_new_kernel - Put a 2nd stage image in place and boot it.
@@ -32,22 +43,21 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 	ldr	x18, [x0, #KIMAGE_ARCH_ZERO_PAGE] /* x18 = zero page for BBM */
 	ldr	x17, [x0, #KIMAGE_ARCH_TTBR1]	/* x17 = linear map copy */
 	ldr	x16, [x0, #KIMAGE_HEAD]		/* x16 = kimage_head */
-	mov	x14, xzr			/* x14 = entry ptr */
-	mov	x13, xzr			/* x13 = copy dest */
+	ldr	x22, [x0, #KIMAGE_ARCH_PHYS_OFFSET]	/* x22 phys_offset */
 	raw_dcache_line_size x15, x1		/* x15 = dcache line size */
 	break_before_make_ttbr_switch	x18, x17, x1, x2 /* set linear map */
 .Lloop:
 	and	x12, x16, PAGE_MASK		/* x12 = addr */
-
+	sub	x12, x12, x22			/* Convert x12 to virt */
 	/* Test the entry flags. */
 .Ltest_source:
 	tbz	x16, IND_SOURCE_BIT, .Ltest_indirection
 
 	/* Invalidate dest page to PoC. */
-	mov	x2, x13
-	mov	x1, #PAGE_SIZE
-	dcache_by_myline_op ivac, sy, x2, x1, x15, x20
+	mov	x19, x13
 	copy_page x13, x12, x1, x2, x3, x4, x5, x6, x7, x8
+	mov	x1, #PAGE_SIZE
+	dcache_by_myline_op civac, sy, x19, x1, x15, x20
 	b	.Lnext
 .Ltest_indirection:
 	tbz	x16, IND_INDIRECTION_BIT, .Ltest_destination
@@ -64,19 +74,20 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 	ic	iallu
 	dsb	nsh
 	isb
+	ldr	x4, [x0, #KIMAGE_START]			/* relocation start */
+	ldr	x1, [x0, #KIMAGE_ARCH_EL2_VECTORS]	/* relocation start */
+	ldr	x0, [x0, #KIMAGE_ARCH_DTB_MEM]		/* dtb address */
+	turn_off_mmu x12, x13
 
 	/* Start new image. */
-	ldr	x1, [x0, #KIMAGE_ARCH_EL2_VECTORS]	/* relocation start */
 	cbz	x1, .Lel1
-	ldr	x1, [x0, #KIMAGE_START]		/* relocation start */
-	ldr	x2, [x0, #KIMAGE_ARCH_DTB_MEM]	/* dtb address */
+	mov	x1, x4				/* relocation start */
+	mov	x2, x0				/* dtb address */
 	mov	x3, xzr
 	mov	x4, xzr
 	mov     x0, #HVC_SOFT_RESTART
 	hvc	#0				/* Jumps from el2 */
 .Lel1:
-	ldr	x4, [x0, #KIMAGE_START]		/* relocation start */
-	ldr	x0, [x0, #KIMAGE_ARCH_DTB_MEM]	/* dtb address */
 	mov	x2, xzr
 	mov	x3, xzr
 	br	x4				/* Jumps from el1 */
-- 
2.25.1

