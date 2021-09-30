Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A924141DC5A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348949AbhI3OfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351931AbhI3OdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:33:12 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937EFC061778
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:29 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id m26so5853703qtn.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hiDX8HDwZgFFsas4OkEqmNALnkk9CtONfrYzDPONMsg=;
        b=gbFRTimS7Mkao9xkEPYbRHZaSmf78Aj8pSH6G1/KFohe9hMG6P20jSLuzhJDqeF/Bo
         tOa6kt9PbJe2vDBc1ovjbpdsqm1TPyx3FgReKagqq4bG9MhZV8T6vLvX0sd/uhkoutJL
         I9pB7aMGLq2Cua3b0/e+Xf79ceuAeJpM/o8h0KJUdEtVN2ujzbjuExv12XVoKsZqexrD
         qpXTF95mNaT6dsxe31Y9MmwQDZIVaYs6cCbmfPNU/o8Z9FI42qFo3GcidOPlNqTY8YbM
         CQmGE1huR7tHEKQ2FAp3ufKRAX2aocQNPrTBnUMWj8KoVckqjmEQiiGSAwjUz+a5g0lG
         ki9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hiDX8HDwZgFFsas4OkEqmNALnkk9CtONfrYzDPONMsg=;
        b=QhUZNuWqvhR00qKpzkCyR2jIIWe8DUpGm75TAF01Jy820P3yC3TpiWPMjALjhxXDVc
         gKT0AiEF1LluFlVX0+mJPab+JFE++8YO6Os3jMtesTSEZg2IfyYvIVZWDhzDQSi9Xsc5
         qH2Hh9L/EtMC3HPYdzlRIX+1es/zYUVk6Eavkfkbu3Ygii/+Prnw/9I3bvLxsKKV75EP
         hdnMK86PDhRvoClceZXSCzdnvKKEXtqLuMB3r3CQxIwvcII3ntC6f7kz3AkTrHPSBoqW
         tKDsf1elUW4PSw+ISVVzP0zdhtZWKyMGcTBZhNYz4ArIrkuTEDg/TBq+KJQOBXX4WrfU
         /QwA==
X-Gm-Message-State: AOAM533A3V+E4dK0bwgVMCTK1jTqe4u0vOaeGjd938m7OkBAz76ukP+M
        6e0SOzzvlUlP0pep1xtGQjiYeg==
X-Google-Smtp-Source: ABdhPJyfgNR+pR4HEDq+pM1gsVASNpdjnBQkyGm2HuLMBJBmfbiE+cFDJ7JjKeGzrdgbRSvxiuKivA==
X-Received: by 2002:ac8:4c8d:: with SMTP id j13mr6612858qtv.155.1633012288410;
        Thu, 30 Sep 2021 07:31:28 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id l195sm1528731qke.98.2021.09.30.07.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:31:27 -0700 (PDT)
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
Subject: [PATCH v18 12/15] arm64: kexec: keep MMU enabled during kexec relocation
Date:   Thu, 30 Sep 2021 14:31:10 +0000
Message-Id: <20210930143113.1502553-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
References: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
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

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Tested-by: Pingfan Liu <piliu@redhat.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/kexec.h      |  3 +++
 arch/arm64/kernel/asm-offsets.c     |  1 +
 arch/arm64/kernel/machine_kexec.c   | 16 +++++++++++----
 arch/arm64/kernel/relocate_kernel.S | 31 +++++++++++++++++++----------
 4 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index d678f0ceb7ee..dca6dedc3b25 100644
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
 };
 
 #ifdef CONFIG_KEXEC_FILE
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 1f565224dafd..2124357c2075 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -176,6 +176,7 @@ int main(void)
   DEFINE(KIMAGE_ARCH_DTB_MEM,		offsetof(struct kimage, arch.dtb_mem));
   DEFINE(KIMAGE_ARCH_EL2_VECTORS,	offsetof(struct kimage, arch.el2_vectors));
   DEFINE(KIMAGE_ARCH_ZERO_PAGE,		offsetof(struct kimage, arch.zero_page));
+  DEFINE(KIMAGE_ARCH_PHYS_OFFSET,	offsetof(struct kimage, arch.phys_offset));
   DEFINE(KIMAGE_ARCH_TTBR1,		offsetof(struct kimage, arch.ttbr1));
   DEFINE(KIMAGE_HEAD,			offsetof(struct kimage, head));
   DEFINE(KIMAGE_START,			offsetof(struct kimage, start));
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index fbff545565f1..1e9a2a45e016 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -196,6 +196,11 @@ int machine_kexec_post_load(struct kimage *kimage)
 	reloc_size = __relocate_new_kernel_end - __relocate_new_kernel_start;
 	memcpy(reloc_code, __relocate_new_kernel_start, reloc_size);
 	kimage->arch.kern_reloc = __pa(reloc_code);
+	rc = trans_pgd_idmap_page(&info, &kimage->arch.ttbr0,
+				  &kimage->arch.t0sz, reloc_code);
+	if (rc)
+		return rc;
+	kimage->arch.phys_offset = virt_to_phys(kimage) - (long)kimage;
 
 	/* Flush the reloc_code in preparation for its execution. */
 	dcache_clean_inval_poc((unsigned long)reloc_code,
@@ -230,9 +235,9 @@ void machine_kexec(struct kimage *kimage)
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
@@ -246,10 +251,13 @@ void machine_kexec(struct kimage *kimage)
 		restart(is_hyp_nvhe(), kimage->start, kimage->arch.dtb_mem,
 			0, 0);
 	} else {
+		void (*kernel_reloc)(struct kimage *kimage);
+
 		if (is_hyp_nvhe())
 			__hyp_set_vectors(kimage->arch.el2_vectors);
-		cpu_soft_restart(kimage->arch.kern_reloc,
-				 virt_to_phys(kimage), 0, 0);
+		cpu_install_ttbr0(kimage->arch.ttbr0, kimage->arch.t0sz);
+		kernel_reloc = (void *)kimage->arch.kern_reloc;
+		kernel_reloc(kimage);
 	}
 
 	BUG(); /* Should never get here. */
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 2b80232246f7..f0a3df9e18a3 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -4,6 +4,8 @@
  *
  * Copyright (C) Linaro.
  * Copyright (C) Huawei Futurewei Technologies.
+ * Copyright (C) 2021, Microsoft Corporation.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
  */
 
 #include <linux/kexec.h>
@@ -15,6 +17,13 @@
 #include <asm/sysreg.h>
 #include <asm/virt.h>
 
+.macro turn_off_mmu tmp1, tmp2
+	mov_q   \tmp1, INIT_SCTLR_EL1_MMU_OFF
+	pre_disable_mmu_workaround
+	msr	sctlr_el1, \tmp1
+	isb
+.endm
+
 .section    ".kexec_relocate.text", "ax"
 /*
  * arm64_relocate_new_kernel - Put a 2nd stage image in place and boot it.
@@ -32,22 +41,21 @@ SYM_CODE_START(arm64_relocate_new_kernel)
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
-	add	x1, x2, #PAGE_SIZE
-	dcache_by_myline_op ivac, sy, x2, x1, x15, x20
+	mov	x19, x13
 	copy_page x13, x12, x1, x2, x3, x4, x5, x6, x7, x8
+	add	x1, x19, #PAGE_SIZE
+	dcache_by_myline_op civac, sy, x19, x1, x15, x20
 	b	.Lnext
 .Ltest_indirection:
 	tbz	x16, IND_INDIRECTION_BIT, .Ltest_destination
@@ -64,19 +72,20 @@ SYM_CODE_START(arm64_relocate_new_kernel)
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
2.33.0.800.g4c38ced690-goog

