Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A00632B740
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357532AbhCCKve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238145AbhCCA0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 19:26:41 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39080C0611BC
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 16:22:53 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id g185so3058847qkf.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 16:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UKjtjEDCRzQ4WDzfqfuqgp2BgU7fhP5QVy8I5s6gkYg=;
        b=fSLQuV82Jj2QUma3YmUBsnpeEsIRTLafxYwB28IFsK6PJ2gWAr7BlPSOvdbgCDrY0V
         7HXoOxavXo2LYem8r3aWvfCujfpeTOoQ23KaKeI7QTwWr+XBRtc9A+OLPcoKhyscI06N
         uIGWARRpGBQZaGjaHiw/VVaw/7yLctzYfwfMwMbH/polx4wQEMsB/johD9Y3JLxmUZVz
         aZA24DlpuLA+BHJcNwtQl10b5bntN1CLS/hFgv6E0o7lLCbLeeoW1elkT8BymHot13xH
         0zF/IAF12YxFrhHx+fREOYaZzOCleNBzrBSYZsJZm6LrwYV6MWmBlqfc8CNjPuVFotY8
         NcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UKjtjEDCRzQ4WDzfqfuqgp2BgU7fhP5QVy8I5s6gkYg=;
        b=jXsi4K4BENaufwZ2+acqT5IaUdxdN0KH+sYzjLtcMYi2NERx2Aj2gCP8XnUE4eU4n4
         TKxrc9soG7z+vbSGwhd+rnzcRq7wvh9walT4jDJ5RgGIN7TMX4yMo3eqgP7RWL9E1uUC
         iwh4/Lieg21O/2qfrZNn9judUX4lVsbuA1Puq3lBW9dk3aTrtd/PBrIFOFZc7gT/Qft3
         5UDMI/Mbb7dSUIqwIxn6/kqhZjbLwSR+oZ4b2Qgc8ksMXjziH2EHfDr8zCCixUgv9iIc
         ruTrUD847NlHcOJUb+/T/6xnJqYGrMnNjKmk9XblpLN/c/j5X/WGxylq40MWT8s37X0J
         iIAw==
X-Gm-Message-State: AOAM531Gu6rfzewv1JS0wIbsbfV6i5vwefpI4JdV8Y0MW0TQF9+NBCfj
        oJDNqL+lkBhtoaLZrjHT4NPRvw==
X-Google-Smtp-Source: ABdhPJyKPWdMLDIUss61XZukaIXsHhimeP40sTJYFttLXHFVC8t+0q7qOi4TzBxxIkgsER4FQ5kv4g==
X-Received: by 2002:a37:4743:: with SMTP id u64mr16004437qka.350.1614730972452;
        Tue, 02 Mar 2021 16:22:52 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id r3sm16690512qkm.129.2021.03.02.16.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 16:22:52 -0800 (PST)
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
Subject: [PATCH v12 15/17] arm64: kexec: keep MMU enabled during kexec relocation
Date:   Tue,  2 Mar 2021 19:22:28 -0500
Message-Id: <20210303002230.1083176-16-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
References: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, that we have linear map page tables configured, keep MMU enabled
to allow faster relocation of segments to final destination.

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
index e83b6380907d..8ac4b2d7f5e8 100644
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
+	dcache_by_myline_op ivac, sy, x19, x1, x15, x20
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

