Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4ED357B1C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 06:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhDHEGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 00:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhDHEGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 00:06:12 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CB0C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 21:05:58 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id v70so922434qkb.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 21:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Olm+fYXYbuVgp6bWsix/kMAWKOrqJlCkAHr9xCmjIpk=;
        b=Ja74be0u5lOgyjL5ukqrO0VzL48CYNlfDj91JpnAEjnkoyN416LTT1tIEj30DKJcpf
         Ai9oRBcIbMYLQ2oisclkbXG1+0rdbZE+VVnkVlgBsHIr2iyi6ss7QFoVcI1kBO0JKzfz
         rI95EdUlnw+Y1SInEE4X89iYGz8I+BULoYPnbzA4BXxdupnmOcNJhDfz7caMuT93hq3p
         tW6FtoWfwwu8CWNbXaFpZFnAPRKRjmZH0Xre624JmLVDgPZ//DBFf6KEWtw5Kd6Gr/Mp
         Zsu9aoUMoElMIAm3NMXWEJOtC87NzuRbQiH5SOj1fyOSQHYuGPl4v/KtjpYYdo++sILt
         YvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Olm+fYXYbuVgp6bWsix/kMAWKOrqJlCkAHr9xCmjIpk=;
        b=oaG7kYU8jzg3KcDwUKmy5+0EHnWOqScIeWkYDWSqc0iEs0OkohC4CoP8tFebwsRjHx
         P5EgRolwJE3qqgrQXW3o392HV6ewBSdvAWEHTthqsMxsjLAOaLIArnM44o20Uq0zv7jS
         O+8S7a3zHsswj5M9oxe6Hn8yTCdLcRy21xseqXsxDl5GoUYItb8kHKXMZ7Z6n8/fJprA
         3UeZyK6XTw9/O/bZhZ2J1Pkb4jfJX9Zgg7RIteI2MyDlTHScHqoxM8UX8kY+J8XyGt/Z
         SioTLX1w7qPeSexVAFpVdNxcD81HEJAIku39GxLN1ro6rKivOWMvFbNJJHYYZFr4rzrE
         W4QA==
X-Gm-Message-State: AOAM533MGdvqAu4F/H+mnAB41ZPJnzfJDzbd/j7BmvXt0pihbtCp7MKG
        OR7Ia6+TYz9gSVIKrDIWR3JdKQ==
X-Google-Smtp-Source: ABdhPJxH2ZBM/1PaSQCcOMDUpkoTsv/4l1erGBcWQZtAEwuVDDfcl3l2izGRncnix3SDHCHnnzsigA==
X-Received: by 2002:a05:620a:142b:: with SMTP id k11mr6548405qkj.46.1617854757440;
        Wed, 07 Apr 2021 21:05:57 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 207sm18177874qkl.125.2021.04.07.21.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 21:05:57 -0700 (PDT)
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
Subject: [PATCH v13 14/18] arm64: kexec: install a copy of the linear-map
Date:   Thu,  8 Apr 2021 00:05:33 -0400
Message-Id: <20210408040537.2703241-15-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
References: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
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
index 29061b76aab6..3ce8131ad660 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -425,6 +425,25 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
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
index 305cf0840ed3..59ac166daf53 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -97,6 +97,8 @@ struct kimage_arch {
 	phys_addr_t dtb_mem;
 	phys_addr_t kern_reloc;
 	phys_addr_t el2_vectors;
+	phys_addr_t ttbr1;
+	phys_addr_t zero_page;
 	/* Core ELF header buffer */
 	void *elf_headers;
 	unsigned long elf_headers_mem;
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 2e3278df1fc3..609362b5aa76 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -158,6 +158,8 @@ int main(void)
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
index f1451d807708..c875ef522e53 100644
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

