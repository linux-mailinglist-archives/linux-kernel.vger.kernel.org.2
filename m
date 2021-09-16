Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9451140EDC7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 01:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241774AbhIPXPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 19:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241574AbhIPXPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 19:15:06 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD42FC061766
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:13:44 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id s32so7141646qtc.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JDZrEF/sCDnWcKlUfW5zJu5PS6tO5sZA6oFNkHkJDRY=;
        b=Rc5YN7zxFvRFzl/O1PJTtlOE7q/0aG1hbqNxGTnAQUocHjgAVlL+c1Z9F6T4TFbyqN
         tIxqNmujTPV7vP1tXrI4hw5+sWHwwhkj7dkO5YBMrjibcMQF1SY6d0/gA30xprUHSPrK
         5bpHgtcy+M0Ye9xVi8oMNq+EF0EjcZrGrcSbBmLGy5IOxg3vxoFxOexVk9DeSdp4u9QC
         xLiw2O7dzu6wSmtrhSiw9JLowsz8FLRaDa05whhIw6IOJD0D6leHB78kf3Fg0Rp0abSG
         XNEY2vIkJAVE4G/uzSkQ5NjNprXzQ4XgO7WVHPmZFRQx7hi0H61+bdlqSJx3HodcOiZH
         DV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JDZrEF/sCDnWcKlUfW5zJu5PS6tO5sZA6oFNkHkJDRY=;
        b=1WsMwMzRTmRodnHiTrOznkXMIdS0YF63bUjLVZlBMhy6SsZESULdzG652lHfnPjdyd
         HVVBtLqZbVeJHZ6IjLPXdW8T20+ftQt+Pix6j9MrWQNWt8FH9h0fxA2ERJbjsOvG7JKv
         2L7FrWd2sZAFNdAJocsq68d7+l/kexqFW9V1Y0n/3A7CEs8ZNLIL+8BdMka1aSZ8WWKi
         uZO/qB7S6r3BaiY8jlxgmm8JcTUJl/p0K9wl48FP4wg/uYG2nEadx1ElQhuFsFpmbzgc
         Wb2RefJ4yKulu6az+0KrUlHzHPumhl0uwVrBidDd2ZLVMgkhQaGz9cY+I+tG5lojfb7K
         krzw==
X-Gm-Message-State: AOAM530StYBwcD4U/zIRGDQXoLkFi9gBRRQ+HmHLgMsJsViTtVnC0D2B
        WfXi5HowYJXcG4XnKknW0rITbg==
X-Google-Smtp-Source: ABdhPJysH2s+WIL4w7gagdK4FBh+E6tL7ZSWKhm5aEaAVpwtx+nGBt3pKhCQPXRi/rFizb+cLcakOg==
X-Received: by 2002:ac8:7354:: with SMTP id q20mr7634239qtp.329.1631834024082;
        Thu, 16 Sep 2021 16:13:44 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id az6sm3312891qkb.70.2021.09.16.16.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 16:13:43 -0700 (PDT)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
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
Subject: [PATCH v17 11/15] arm64: kexec: install a copy of the linear-map
Date:   Thu, 16 Sep 2021 19:13:21 -0400
Message-Id: <20210916231325.125533-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916231325.125533-1-pasha.tatashin@soleen.com>
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To perform the kexec relocation with the MMU enabled, we need a copy
of the linear map.

Create one, and install it from the relocation code. This has to be done
from the assembly code as it will be idmapped with TTBR0. The kernel
runs in TTRB1, so can't use the break-before-make sequence on the mapping
it is executing from.

The makes no difference yet as the relocation code runs with the MMU
disabled.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/assembler.h  | 19 +++++++++++++++++++
 arch/arm64/include/asm/kexec.h      |  2 ++
 arch/arm64/kernel/asm-offsets.c     |  2 ++
 arch/arm64/kernel/hibernate-asm.S   | 20 --------------------
 arch/arm64/kernel/machine_kexec.c   | 16 ++++++++++++++--
 arch/arm64/kernel/relocate_kernel.S |  3 +++
 6 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 71999a325055..4289c4e1c2a3 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -483,6 +483,25 @@ alternative_endif
 	_cond_extable .Licache_op\@, \fixup
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
index 6a2b8b1a4872..1f565224dafd 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -175,6 +175,8 @@ int main(void)
 #ifdef CONFIG_KEXEC_CORE
   DEFINE(KIMAGE_ARCH_DTB_MEM,		offsetof(struct kimage, arch.dtb_mem));
   DEFINE(KIMAGE_ARCH_EL2_VECTORS,	offsetof(struct kimage, arch.el2_vectors));
+  DEFINE(KIMAGE_ARCH_ZERO_PAGE,		offsetof(struct kimage, arch.zero_page));
+  DEFINE(KIMAGE_ARCH_TTBR1,		offsetof(struct kimage, arch.ttbr1));
   DEFINE(KIMAGE_HEAD,			offsetof(struct kimage, head));
   DEFINE(KIMAGE_START,			offsetof(struct kimage, start));
   BLANK();
diff --git a/arch/arm64/kernel/hibernate-asm.S b/arch/arm64/kernel/hibernate-asm.S
index a30a2c3f905e..0e1d9c3c6a93 100644
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
index 83da6045cd45..50bc0a265c86 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -159,6 +159,8 @@ static void *kexec_page_alloc(void *arg)
 
 int machine_kexec_post_load(struct kimage *kimage)
 {
+	int rc;
+	pgd_t *trans_pgd;
 	void *reloc_code = page_to_virt(kimage->control_code_page);
 	long reloc_size;
 	struct trans_pgd_info info = {
@@ -175,12 +177,22 @@ int machine_kexec_post_load(struct kimage *kimage)
 
 	kimage->arch.el2_vectors = 0;
 	if (is_hyp_nvhe()) {
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
index 9d2400855ee4..a07b737533c3 100644
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

