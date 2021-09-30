Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257C341DC5B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349843AbhI3OfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351930AbhI3OdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:33:12 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9379BC061777
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:28 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id m7so5946625qke.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uM7nePTc3Pr5alLDIhJT26d9ASl4ItsEhUSF3SoRlOw=;
        b=NwQN2f451Un2tZ6PYU+nIoolI85dWRHZ/cijulDx9n/s9hwGzuXkW3IZ70abRtcZr1
         UihJG5WIsBZze7Uhc9U6n8ZhFUVV6sjgMxUHqKkALpbBH1aLmHdxIqHLZotMPYuJMUG5
         dtROBU6G+v4Hc99a9FIbqRwzucEMLrSQUt4fG/SlKhwvEU0CMmXsDVfXg4sG/MTZVYZw
         3VfpxwF+KE06wtbGousa78FexB4Ux4sRoD/m79nmaRw9GPDPwN2Qah0Ucj9D5Wit2dNh
         pE1NViWkWEz1soNCMqDHhOse8+PSySe2+kn6mCe+F1oMlNpsMhFX0TDirDbZNOpVKxBo
         mhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uM7nePTc3Pr5alLDIhJT26d9ASl4ItsEhUSF3SoRlOw=;
        b=ORIV7rD36J1F345UqbAhZJimiOTjUFbWNBtRedJ6wWNFsALWwRTk2k5nMWGAVQ6M0u
         MqEIyJZjUQxSwRvUo84NIGIxIaZEZtOuas38pHuZbZ84+GgnvZ05jaHDxFCV57EdUTdU
         nMpLV8mVGaJ2zpj5cmbcFCci3Rhb+PddjTdQMiRTHCvnC6SjjiShzpkZ4CyZuo/eqIsH
         Ja66ph5cMo0zAfWA2wMjreM4hQk+cdh2rDiQ48s1Kv+CmX/zKymnrhPmNAF065WeZiCN
         klSA+/HSHWG/M+6Gax5uD02kmoczgTfC2pOokGeqrdnO1ZFv0unv+D+9nNPdF+ZZwjsP
         ZTeg==
X-Gm-Message-State: AOAM532rUMyVnBMb+z5E9Nhs4+0RMHj/oNtQYC70fXm4N5nYjKZhDpCn
        Fw+S3UguPO6IpFMKkZThAA7ojQ==
X-Google-Smtp-Source: ABdhPJyqaxYjUoVqqI6Z2WRqe7YV7XGmKu6XQqMsK8o/rIRI06qkcwlSoFfm5Mh/Y4OegOULvC+4kQ==
X-Received: by 2002:ae9:eb58:: with SMTP id b85mr4879543qkg.323.1633012287361;
        Thu, 30 Sep 2021 07:31:27 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id l195sm1528731qke.98.2021.09.30.07.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:31:26 -0700 (PDT)
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
Subject: [PATCH v18 11/15] arm64: kexec: install a copy of the linear-map
Date:   Thu, 30 Sep 2021 14:31:09 +0000
Message-Id: <20210930143113.1502553-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
References: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
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
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/assembler.h  | 19 +++++++++++++++++++
 arch/arm64/include/asm/kexec.h      |  2 ++
 arch/arm64/kernel/asm-offsets.c     |  2 ++
 arch/arm64/kernel/hibernate-asm.S   | 20 --------------------
 arch/arm64/kernel/machine_kexec.c   | 16 ++++++++++++++--
 arch/arm64/kernel/relocate_kernel.S |  3 +++
 6 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index d5281f75a58d..5da176dd37a9 100644
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
index 320442d35811..fbff545565f1 100644
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
index 2227741b96fa..2b80232246f7 100644
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
2.33.0.800.g4c38ced690-goog

