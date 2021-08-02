Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CE23DE1FC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 23:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhHBVzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 17:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhHBVyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:54:39 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FF6C061798
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 14:54:28 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id f91so9638111qva.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 14:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=g35GBw9jaSD1qco5H/zP0F6z/ZxFUbIC9x16s2RQRMM=;
        b=PeCelF4CceooL4R0WLeQssxewvhrDwxcoWv1fuEGyNYV2sBkvR33wwrIrNc9PnAHLz
         vvUY8stQeC6xrhFT5hckDWGiRHWBvBSsrHpwwUwKqZGE9af8eGnLJV7fxri3ZUbBNL1H
         604jWltwg88/FE30M4yJS7FmIjAbUGD/DFN3A3Br3p+VCu+yCldNwBwW/e5jhddMZyVx
         ICehtRETche1bXF/dQh2c4t83jcUj+VdrEwZ4ShfyJ2n8oNJqBlfVLR4NTMH3PlsRMf1
         Bs6KI+zw9fu5VAyIxrVz6HdHhPmwuDrZPKcQ2M6yD7ol6tDU2oxT4Lkl25IZoXNQp5x2
         7iXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g35GBw9jaSD1qco5H/zP0F6z/ZxFUbIC9x16s2RQRMM=;
        b=mn+/NUJQGwEN3yEok/NODAFjGSfuulhJ5P3bfztUW3JN14dAI61wRmAhlkqu6ffeWd
         7Av8ksxny2VpMijTpMTDz8jLty/6OeNSDeyuAbE8W7FXKaMJADQblxF61damHVhTqHVm
         MwQ0aVwVGMle8BAw0cFpqp9rVupLI+xJzqD7SS0SSC55EmrDUyAz6kbWsF6N1p+vfO0X
         /Y66DgikXCFr3ODVgmHU9HgxzZb8Vo4s+5yEHnSorrxLTQDDx7mzcSPM6w0KOo2bJkjg
         vtGDyr/rPgdVm1KsV/PCNxCBeIJKMP6VIP2uYaffVb34JuL3TjmW6Km/8DQnE/lzQdjZ
         KS9A==
X-Gm-Message-State: AOAM5335/9JOELaol9xRhLAYZWJZWR01P4527gtOua3lIGKUVZf+o+sK
        /zHhYcQiwea2P6UrvVImI8BS4g==
X-Google-Smtp-Source: ABdhPJyntDUQbHFwmfsNTZMv/NAE180vNe44uz2fj4AQUWv/1Zz1sP5bFhh/XK2SXb92W0BRzVINlA==
X-Received: by 2002:a0c:fd61:: with SMTP id k1mr18311601qvs.49.1627941267617;
        Mon, 02 Aug 2021 14:54:27 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id v11sm5479216qtc.0.2021.08.02.14.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:54:27 -0700 (PDT)
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
        kernelfans@gmail.com, akpm@linux-foundation.org,
        madvenka@linux.microsoft.com
Subject: [PATCH v16 12/15] arm64: kexec: keep MMU enabled during kexec relocation
Date:   Mon,  2 Aug 2021 17:54:05 -0400
Message-Id: <20210802215408.804942-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802215408.804942-1-pasha.tatashin@soleen.com>
References: <20210802215408.804942-1-pasha.tatashin@soleen.com>
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
index a98384d13ee7..134af7791249 100644
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
index 50bc0a265c86..b43195a7fcb6 100644
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
index a07b737533c3..c81b05ac4650 100644
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
 .pushsection    ".kexec_relocate.text", "ax"
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
2.25.1

