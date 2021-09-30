Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7156041DC5C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349955AbhI3OfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350476AbhI3OdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:33:04 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AC5C06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:21 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id d20so260242qvm.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2byFwZTqL6H5T1HwZ3UMFR9jHqf1akMl4mBN/vDMX94=;
        b=CnuAcVa/z2KIcemUvmuCQG3R70S7y0YjOx0S55gdxctiytScgPrJDP6M1fLmRGPYXJ
         YAT3mIXZVlLiki2mw9xhu8NnySDq7DVByfEQjdj7oIecSzThsjjHYPVJQ4VGIOBh5cqz
         VlYyGJ6x1aJFFhC+csTa7NfnPJGU6R7oBZD8MmNrJ4z6rW5X+/OgtPXmPF9tCdlDw8iv
         5gBfKad8IQFE/KHebxTVW7m95rJ16FTAVG6bAoPT9dRSVK92yIipf0bAMwhKETG99lhJ
         JBbcprcZPUyjLRS4jyYAX+2cwdviTgJKdrRmaXT6Z1jEDDgCDbBiPpKZPoxA4uQvLe6A
         kMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2byFwZTqL6H5T1HwZ3UMFR9jHqf1akMl4mBN/vDMX94=;
        b=PXT1NAyb3si0+UAoCf/GflDywu5Ac6Z04H4ocKOZ7JHptpC7eUPPZTPcfSRMJslq22
         u2F12VPfBO6LH/jXjy60SMs56ZYnSdlFxlWVTXr660gBjXMU919iNMcmLfNGYbeLyrwu
         g8G8xEIF1FhF2Z9c7/E0LJIGwSUEacBGfi3RYeT15njGV1z8aXeM2pb81K8jjJrmGQCX
         9ykHy/zSxvLByOf4bgwAkZqv3OcZo1y3l41+ugjdJpX5WDxeo1tYXAppuJAU18CWn4M9
         9LPIz/yd+glGgqfbDmsotWVeTQxApyxMTTtdahZn6hdskJk+XXHJ8RmJ6G+R4Cjf6QrV
         +QWQ==
X-Gm-Message-State: AOAM533okdeRLrYBAX+rZRW37BIBTFyxAK3aPBAf0nzOcSjYL567KTuJ
        BpmBZSKtJNT96Pg+4mI+g428mA==
X-Google-Smtp-Source: ABdhPJx2GA26RZN03kRYmBDCi/gcboAxmrhaWBYq1chXopjjFm1J8tvOWaWK45xUGQBMAOa3uCnDFA==
X-Received: by 2002:ad4:45f0:: with SMTP id q16mr331461qvu.4.1633012281074;
        Thu, 30 Sep 2021 07:31:21 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id l195sm1528731qke.98.2021.09.30.07.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:31:20 -0700 (PDT)
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
Subject: [PATCH v18 05/15] arm64: kexec: skip relocation code for inplace kexec
Date:   Thu, 30 Sep 2021 14:31:03 +0000
Message-Id: <20210930143113.1502553-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
References: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of kdump or when segments are already in place the relocation
is not needed, therefore the setup of relocation function and call to
it can be skipped.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Suggested-by: James Morse <james.morse@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/machine_kexec.c   | 34 ++++++++++++++++++-----------
 arch/arm64/kernel/relocate_kernel.S |  3 ---
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index b6d5a02cba2e..7f1cb5a2a463 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -144,16 +144,16 @@ int machine_kexec_post_load(struct kimage *kimage)
 {
 	void *reloc_code = page_to_virt(kimage->control_code_page);
 
-	/* If in place flush new kernel image, else flush lists and buffers */
-	if (kimage->head & IND_DONE)
+	/* If in place, relocation is not used, only flush next kernel */
+	if (kimage->head & IND_DONE) {
 		kexec_segment_flush(kimage);
-	else
-		kexec_list_flush(kimage);
+		kexec_image_info(kimage);
+		return 0;
+	}
 
 	memcpy(reloc_code, arm64_relocate_new_kernel,
 	       arm64_relocate_new_kernel_size);
 	kimage->arch.kern_reloc = __pa(reloc_code);
-	kexec_image_info(kimage);
 
 	/* Flush the reloc_code in preparation for its execution. */
 	dcache_clean_inval_poc((unsigned long)reloc_code,
@@ -162,6 +162,8 @@ int machine_kexec_post_load(struct kimage *kimage)
 	icache_inval_pou((uintptr_t)reloc_code,
 			 (uintptr_t)reloc_code +
 			 arm64_relocate_new_kernel_size);
+	kexec_list_flush(kimage);
+	kexec_image_info(kimage);
 
 	return 0;
 }
@@ -188,19 +190,25 @@ void machine_kexec(struct kimage *kimage)
 	local_daif_mask();
 
 	/*
-	 * cpu_soft_restart will shutdown the MMU, disable data caches, then
-	 * transfer control to the kern_reloc which contains a copy of
-	 * the arm64_relocate_new_kernel routine.  arm64_relocate_new_kernel
-	 * uses physical addressing to relocate the new image to its final
-	 * position and transfers control to the image entry point when the
-	 * relocation is complete.
+	 * Both restart and cpu_soft_restart will shutdown the MMU, disable data
+	 * caches. However, restart will start new kernel or purgatory directly,
+	 * cpu_soft_restart will transfer control to arm64_relocate_new_kernel
 	 * In kexec case, kimage->start points to purgatory assuming that
 	 * kernel entry and dtb address are embedded in purgatory by
 	 * userspace (kexec-tools).
 	 * In kexec_file case, the kernel starts directly without purgatory.
 	 */
-	cpu_soft_restart(kimage->arch.kern_reloc, kimage->head, kimage->start,
-			 kimage->arch.dtb_mem);
+	if (kimage->head & IND_DONE) {
+		typeof(__cpu_soft_restart) *restart;
+
+		cpu_install_idmap();
+		restart = (void *)__pa_symbol(function_nocfi(__cpu_soft_restart));
+		restart(is_hyp_nvhe(), kimage->start, kimage->arch.dtb_mem,
+			0, 0);
+	} else {
+		cpu_soft_restart(kimage->arch.kern_reloc, kimage->head,
+				 kimage->start, kimage->arch.dtb_mem);
+	}
 
 	BUG(); /* Should never get here. */
 }
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index b78ea5de97a4..8058fabe0a76 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -32,8 +32,6 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 	mov	x16, x0				/* x16 = kimage_head */
 	mov	x14, xzr			/* x14 = entry ptr */
 	mov	x13, xzr			/* x13 = copy dest */
-	/* Check if the new image needs relocation. */
-	tbnz	x16, IND_DONE_BIT, .Ldone
 	raw_dcache_line_size x15, x1		/* x15 = dcache line size */
 .Lloop:
 	and	x12, x16, PAGE_MASK		/* x12 = addr */
@@ -65,7 +63,6 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 .Lnext:
 	ldr	x16, [x14], #8			/* entry = *ptr++ */
 	tbz	x16, IND_DONE_BIT, .Lloop	/* while (!(entry & DONE)) */
-.Ldone:
 	/* wait for writes from copy_page to finish */
 	dsb	nsh
 	ic	iallu
-- 
2.33.0.800.g4c38ced690-goog

