Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5A13931CB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbhE0PIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236770AbhE0PHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:07:31 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70780C061348
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:50 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id h20so912029qko.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZG1hbdIv3FvUkXzGyiyJBV6DrXE2wtuUaoQN6LGlj1M=;
        b=PxjTnw1/0d/OHXwz8yz4wn5Hg8O1MgJq99+RWaGhWnpC2LB6uhK4c/zxkocCCd5/oC
         e/6xsWOBUGOE90CubgjwvpYuA2I2tZv3Sy5Zrz+zCduX7j0BuclReU68VPVaxOsPdOuh
         +R5wk3dSn+5+xAy+3iFGLGkGhfTBw0ZoQVJPPIdAi60oUBKmlWltJrC62fx9CgwHPz6M
         D59VDhjBcie7Ut7+WdA57iZ1SsSDrONvHXGGYTPo9qBTh09kD6AI68kbSEN5uYj5GaNM
         HXsNg85brLB3CkaI9gBcGyco1YdJubhyzY3XjTbMQBcS6vi6Xnh/IA7FTvLLdlaJenUx
         jr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZG1hbdIv3FvUkXzGyiyJBV6DrXE2wtuUaoQN6LGlj1M=;
        b=doRRobJiOHl9gLHcSmpamjmLMvKuv2cV2Ux0kN4+7xnVR1+j6RvaeWjkhZzjrX2G/U
         //Sz8GmvC5tcWgdzwfY123TSK5dHDQE4ulJWA7ACJ/wrivjvz6HHaJ0UGxShim2WaE8u
         HHBULdY+/sN8Q8W1KznXZgK2COENaNJYywR97CjIXdGu5br25v+JCiXXQclKvh4quj4S
         nXNFGMlFNYxWt9Gj4hHwxr8f9u4wEQHiFoK5P+vUfVEcVm4Fd7vWD2Fg7fK5burGdp0m
         kxADqspDvPWvIN+wKOOjFESxT0eriOTQurAGVkp3gfHL0ZOALbHYcz2T83JgCpUHT23A
         O+KA==
X-Gm-Message-State: AOAM531tSPoVsEJUYazYzotgQn35meZJpaBpTLaEiCArwb4t2X6vTs/7
        jw4PKbNEqXBuF0reudQ8LTMrUQ==
X-Google-Smtp-Source: ABdhPJzJ1Sj2T9cni69jm3ehIaxy4vedgsKsmt7wK9VAMhgxQOjax53s6snUh5lU5bh4C1ZyuNA3UA==
X-Received: by 2002:a05:620a:1126:: with SMTP id p6mr4087741qkk.120.1622127949626;
        Thu, 27 May 2021 08:05:49 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x10sm1447468qkh.124.2021.05.27.08.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:05:49 -0700 (PDT)
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
Subject: [PATCH 14/18] arm64: kexec: install a copy of the linear-map
Date:   Thu, 27 May 2021 11:05:22 -0400
Message-Id: <20210527150526.271941-15-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527150526.271941-1-pasha.tatashin@soleen.com>
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To perform the kexec relocations with the MMU enabled, we need a copy
of the linear map.

Create one, and install it from the relocation code. This has to be done
from the assembly code as it will be idmapped with TTBR0. The kernel
runs in TTRB1, so can't use the break-before-make sequence on the mapping
it is executing from.

The makes no difference yet as the relocation code runs with the MMU
disabled.

Co-developed-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/assembler.h  | 19 +++++++++++++++++++
 arch/arm64/include/asm/kexec.h      |  2 ++
 arch/arm64/kernel/asm-offsets.c     |  2 ++
 arch/arm64/kernel/hibernate-asm.S   | 20 --------------------
 arch/arm64/kernel/machine_kexec.c   | 16 ++++++++++++++--
 arch/arm64/kernel/relocate_kernel.S |  3 +++
 6 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index f1367863d995..7f268bfa98c6 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -447,6 +447,25 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 	isb
 	.endm
 
+/*
+ * To prevent the possibility of old and new partial table walks being visible
+ * in the tlb, switch the ttbr to a zero page when we invalidate the old
+ * records. D4.7.1 'General TLB maintenance requirements' in ARM DDI 0487A.i
+ * Even switching to our copied tables will cause a changed output address at
+ * each stage of the walk.
+ */
+	.macro break_before_make_ttbr_switch zero_page, page_table, tmp, tmp2
+	phys_to_ttbr \tmp, \zero_page
+	msr	ttbr1_el1, \tmp
+	isb
+	tlbi	vmalle1
+	dsb	nsh
+	phys_to_ttbr \tmp, \page_table
+	offset_ttbr1 \tmp, \tmp2
+	msr	ttbr1_el1, \tmp
+	isb
+	.endm
+
 /*
  * reset_pmuserenr_el0 - reset PMUSERENR_EL0 if PMUv3 present
  */
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 753a1c398898..d678f0ceb7ee 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -97,6 +97,8 @@ struct kimage_arch {
 	phys_addr_t dtb_mem;
 	phys_addr_t kern_reloc;
 	phys_addr_t el2_vectors;
+	phys_addr_t ttbr1;
+	phys_addr_t zero_page;
 };
 
 #ifdef CONFIG_KEXEC_FILE
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index ee37d0e0fb6d..f9794cd95eef 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -160,6 +160,8 @@ int main(void)
 #ifdef CONFIG_KEXEC_CORE
   DEFINE(KIMAGE_ARCH_DTB_MEM,		offsetof(struct kimage, arch.dtb_mem));
   DEFINE(KIMAGE_ARCH_EL2_VECTORS,	offsetof(struct kimage, arch.el2_vectors));
+  DEFINE(KIMAGE_ARCH_ZERO_PAGE,		offsetof(struct kimage, arch.zero_page));
+  DEFINE(KIMAGE_ARCH_TTBR1,		offsetof(struct kimage, arch.ttbr1));
   DEFINE(KIMAGE_HEAD,			offsetof(struct kimage, head));
   DEFINE(KIMAGE_START,			offsetof(struct kimage, start));
   BLANK();
diff --git a/arch/arm64/kernel/hibernate-asm.S b/arch/arm64/kernel/hibernate-asm.S
index 8ccca660034e..a31e621ba867 100644
--- a/arch/arm64/kernel/hibernate-asm.S
+++ b/arch/arm64/kernel/hibernate-asm.S
@@ -15,26 +15,6 @@
 #include <asm/page.h>
 #include <asm/virt.h>
 
-/*
- * To prevent the possibility of old and new partial table walks being visible
- * in the tlb, switch the ttbr to a zero page when we invalidate the old
- * records. D4.7.1 'General TLB maintenance requirements' in ARM DDI 0487A.i
- * Even switching to our copied tables will cause a changed output address at
- * each stage of the walk.
- */
-.macro break_before_make_ttbr_switch zero_page, page_table, tmp, tmp2
-	phys_to_ttbr \tmp, \zero_page
-	msr	ttbr1_el1, \tmp
-	isb
-	tlbi	vmalle1
-	dsb	nsh
-	phys_to_ttbr \tmp, \page_table
-	offset_ttbr1 \tmp, \tmp2
-	msr	ttbr1_el1, \tmp
-	isb
-.endm
-
-
 /*
  * Resume from hibernate
  *
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 675d27d7aea4..fe0f9c383c17 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -153,6 +153,8 @@ static void *kexec_page_alloc(void *arg)
 
 int machine_kexec_post_load(struct kimage *kimage)
 {
+	int rc;
+	pgd_t *trans_pgd;
 	void *reloc_code = page_to_virt(kimage->control_code_page);
 	long reloc_size;
 	struct trans_pgd_info info = {
@@ -169,12 +171,22 @@ int machine_kexec_post_load(struct kimage *kimage)
 
 	kimage->arch.el2_vectors = 0;
 	if (is_hyp_callable()) {
-		int rc = trans_pgd_copy_el2_vectors(&info,
-						    &kimage->arch.el2_vectors);
+		rc = trans_pgd_copy_el2_vectors(&info,
+						&kimage->arch.el2_vectors);
 		if (rc)
 			return rc;
 	}
 
+	/* Create a copy of the linear map */
+	trans_pgd = kexec_page_alloc(kimage);
+	if (!trans_pgd)
+		return -ENOMEM;
+	rc = trans_pgd_create_copy(&info, &trans_pgd, PAGE_OFFSET, PAGE_END);
+	if (rc)
+		return rc;
+	kimage->arch.ttbr1 = __pa(trans_pgd);
+	kimage->arch.zero_page = __pa(empty_zero_page);
+
 	reloc_size = __relocate_new_kernel_end - __relocate_new_kernel_start;
 	memcpy(reloc_code, __relocate_new_kernel_start, reloc_size);
 	kimage->arch.kern_reloc = __pa(reloc_code);
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 7a600ba33ae1..e83b6380907d 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -29,10 +29,13 @@
  */
 SYM_CODE_START(arm64_relocate_new_kernel)
 	/* Setup the list loop variables. */
+	ldr	x18, [x0, #KIMAGE_ARCH_ZERO_PAGE] /* x18 = zero page for BBM */
+	ldr	x17, [x0, #KIMAGE_ARCH_TTBR1]	/* x17 = linear map copy */
 	ldr	x16, [x0, #KIMAGE_HEAD]		/* x16 = kimage_head */
 	mov	x14, xzr			/* x14 = entry ptr */
 	mov	x13, xzr			/* x13 = copy dest */
 	raw_dcache_line_size x15, x1		/* x15 = dcache line size */
+	break_before_make_ttbr_switch	x18, x17, x1, x2 /* set linear map */
 .Lloop:
 	and	x12, x16, PAGE_MASK		/* x12 = addr */
 
-- 
2.25.1

