Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D4B3A0897
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 02:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbhFIArv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 20:47:51 -0400
Received: from mail-qv1-f42.google.com ([209.85.219.42]:42844 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbhFIArl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:47:41 -0400
Received: by mail-qv1-f42.google.com with SMTP id c10so9168538qvo.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 17:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iis7jLmMWJqrO4j8bEs42fC5zcjpgKAbVhRTVokGzVo=;
        b=hIZtdQG0l1hp6VYn3jLkRnYmqOspOKZG6tdUGGFo80N8ec7YlGXxpUBrWDY3B4OxKA
         iIsr0x85HR2sTdVQw5KeJ3V+HF5QdifZzV49tR9m1uqifviZTd16PwepNMwuRKg4bPl+
         HaFll3WSZZlN2qmLLRchlnvwxeTd1zH6v/yR9/NImVmr7XBEPE0NChcfjy7F2jsNxhwr
         BYpqX+P/rUtSiHlKSe+n3OjO2R1dHiSlwr4FNSqGh4kGKnWigWhCsvx5Hyq5bk0dTaay
         gQSgXUuM2XiRVZS1G98++2cg+p0YzOaHXrJqxQ4fP9MGSXT+8zQVrLIclkN28L6JaEUK
         tMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iis7jLmMWJqrO4j8bEs42fC5zcjpgKAbVhRTVokGzVo=;
        b=oyo97HWvZCM10COMdlAUXvOApaoiYQGTMAOTswymJTWJ4eaamwx3/h9nFPnnPqty9g
         vNzX33Tm/nwnFE6fgLZxWyFlaIRY5JyhcyGgYnKKT4qj0rEe1l9Yq5SvnTCPM+QWY77u
         rxS3w/GPo3/+a+CiVYDfnD7KL/TzoGFq/DeX9p5u3AG5zAi4AjCvFrict/vIYVoLICqS
         OWAuhSGKhYN7QNL/Zu9KCeIwznYqs131szi8YQzCgVwEqZ54A3S79o0Y2ti/ZEQwxgWn
         0Knlu2YMbewEK/f9n8R5/A+TWCNe/CmOcGkwM4phDx1Husq2D2/5CBWFTCCXAfzAMqkD
         Mz0w==
X-Gm-Message-State: AOAM533PWsRbeZaPtSSuiyj7hZDAR3TkdM3/Nhqph/tUd3tGhYNSXfpM
        ilhwaB4fii5ebMHWasJdsC+ZZg==
X-Google-Smtp-Source: ABdhPJznpfHdSaLE7Nj8U/+ZSKzFicXzREzb8C7HiU/eXa3XPqv3tCX/MIKaB+9KROa4cEA0gtbJKg==
X-Received: by 2002:ad4:5343:: with SMTP id v3mr3232974qvs.45.1623199478651;
        Tue, 08 Jun 2021 17:44:38 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id n194sm12869011qka.66.2021.06.08.17.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 17:44:38 -0700 (PDT)
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
Subject: [PATCH v15 12/15] arm64: kexec: keep MMU enabled during kexec relocation
Date:   Tue,  8 Jun 2021 20:44:16 -0400
Message-Id: <20210609004419.936873-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609004419.936873-1-pasha.tatashin@soleen.com>
References: <20210609004419.936873-1-pasha.tatashin@soleen.com>
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
index f9794cd95eef..bbdf20930491 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -161,6 +161,7 @@ int main(void)
   DEFINE(KIMAGE_ARCH_DTB_MEM,		offsetof(struct kimage, arch.dtb_mem));
   DEFINE(KIMAGE_ARCH_EL2_VECTORS,	offsetof(struct kimage, arch.el2_vectors));
   DEFINE(KIMAGE_ARCH_ZERO_PAGE,		offsetof(struct kimage, arch.zero_page));
+  DEFINE(KIMAGE_ARCH_PHYS_OFFSET,	offsetof(struct kimage, arch.phys_offset));
   DEFINE(KIMAGE_ARCH_TTBR1,		offsetof(struct kimage, arch.ttbr1));
   DEFINE(KIMAGE_HEAD,			offsetof(struct kimage, head));
   DEFINE(KIMAGE_START,			offsetof(struct kimage, start));
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 4e796e46baa3..a2163ea24fc1 100644
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
index e83b6380907d..fc2348584a54 100644
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
-	mov	x1, #PAGE_SIZE
-	dcache_by_myline_op ivac, sy, x2, x1, x15, x20
+	mov	x19, x13
 	copy_page x13, x12, x1, x2, x3, x4, x5, x6, x7, x8
+	mov	x1, #PAGE_SIZE
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

