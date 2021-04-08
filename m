Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07559357B14
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 06:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhDHEGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 00:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhDHEGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 00:06:01 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F75C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 21:05:50 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id 1so498544qtb.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 21:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hiQbfer3Cy+5MCvp23I2bat0V/tLiwOPOJLrW/6qX9o=;
        b=Vd61oEBV7Vn5WTuBeGbCdJHrwIWCibHMtCk++64snK/ZPDtTyhHe0Nq3a+pjo8uswX
         Et4Le8VT1I2fif7zEsz3e8Gdw81BQpEQ9IblPTxGPS2Jfqhz9lwSe307RzNh+knkCGtX
         U+Oiqfv/zT5hYamo3zUvH1r9kESLRvQIuF1PEyslShJ+OFm6TrqzjnvBF5TTn7ibNGl+
         +48FhVVIo0tE5For8Dxkpf9z9605OZzVjFN6r/o6N+nQ3g+/M/fHSa90RaVvzZAH8MJk
         /mj0LHL4p3vKmQFIi9y8+DOJA3AnhqcHU1QgRDtJvhbvjntNHQ7XKTYVbQ8++2ZQu+bc
         eYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hiQbfer3Cy+5MCvp23I2bat0V/tLiwOPOJLrW/6qX9o=;
        b=GmGCsIcxtp9M8VRvxbJN/RWV0ZbSOAwGYukWqLD+izyHgIwmDm7Xi0EXZT2Wv6PmcR
         0l2bC0WV9/OawNzyX1FNeWy315+pQ0IdFF8mwCqbt/GBTHrJq2CoA7Y1cDjj/6N5qUu8
         NyJRnbHVllLRcVwKmeMNLK0jGE8jn4cPz+VRD61ebBLDxvTxwuBado7lU7ap4xGlOEA2
         p/+O+S+HKr7GumcV16V3YyYE4TiRVR+/9RTKsui2YQ4brAzznYClvoBQW6G9iYAd2pOw
         pOMLddkUep2hbunTfGV3gbEuI6NxG6FH15J1xr7wkMjUPgqu1g/9b1EV/nYazdYI71ff
         8JPQ==
X-Gm-Message-State: AOAM530xVTp1IzfvhTxZ4BnqcQu0pmV0BI+KazuEcPGQTB7/DyCOqu+G
        1MD4HGdvqacG/k/f54T85OxdtA==
X-Google-Smtp-Source: ABdhPJwaCeykglUkEXFAvBa1BzVKFnTCf1ecW8WT2k77yBhsz+NHJ2cCh2ZdKNS2R+jDbwph0oQBwQ==
X-Received: by 2002:ac8:7611:: with SMTP id t17mr5459416qtq.361.1617854749679;
        Wed, 07 Apr 2021 21:05:49 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 207sm18177874qkl.125.2021.04.07.21.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 21:05:49 -0700 (PDT)
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
Subject: [PATCH v13 08/18] arm64: kexec: skip relocation code for inplace kexec
Date:   Thu,  8 Apr 2021 00:05:27 -0400
Message-Id: <20210408040537.2703241-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
References: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of kdump or when segments are already in place the relocation
is not needed, therefore the setup of relocation function and call to
it can be skipped.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Suggested-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/machine_kexec.c   | 34 ++++++++++++++++++-----------
 arch/arm64/kernel/relocate_kernel.S |  3 ---
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 3a034bc25709..b150b65f0b84 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -139,21 +139,23 @@ int machine_kexec_post_load(struct kimage *kimage)
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
 	__flush_dcache_area(reloc_code, arm64_relocate_new_kernel_size);
 	flush_icache_range((uintptr_t)reloc_code, (uintptr_t)reloc_code +
 			   arm64_relocate_new_kernel_size);
+	kexec_list_flush(kimage);
+	kexec_image_info(kimage);
 
 	return 0;
 }
@@ -180,19 +182,25 @@ void machine_kexec(struct kimage *kimage)
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
+		restart = (void *)__pa_symbol(__cpu_soft_restart);
+		restart(is_hyp_callable(), kimage->start, kimage->arch.dtb_mem,
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
2.25.1

