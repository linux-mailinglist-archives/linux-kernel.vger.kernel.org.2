Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B31632B738
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442454AbhCCKvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbhCCAZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 19:25:50 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3967DC061224
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 16:22:44 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id f124so4158755qkj.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 16:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hiQbfer3Cy+5MCvp23I2bat0V/tLiwOPOJLrW/6qX9o=;
        b=UueDkZWeVdt0ZVUeFCaAS95OcbctawuVt2jRXcfNleEQHioaIPsafjb3iN3wPEqMdt
         J9stLwiFQM/z9W3CKU1wRsTGAe+nD318y5F9IIMtfpYl9ooGJOj9fq3oWyPfDl8EafIQ
         QkbzJVXwjyMJ3s+WeBV5VvNz7u8LvjFGWo2A0yPGEvKqoLl2EWQ4TA6kdAzhcd0pCOxi
         bNZKhhZ2PTEsy6gzqf5i+WWcAhW6s6kBywZl2oPrlqd186gvUOmG2SJ5qEzykeb+bgo7
         zNWjDcSlC0bR7+IcSuyKZ2OqdH/81WqWH4B4D8mKrZgAcxAnonHq8pCXd9qjhhgHBr97
         fnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hiQbfer3Cy+5MCvp23I2bat0V/tLiwOPOJLrW/6qX9o=;
        b=WddxmEDZ9zKH6EQphuQGzmEbZaZCwOCNCN7lnztVp95qutM14YVamtj2k/uw2qAFMu
         0Sas2/q66O38As3tZZtZLYSKIZqcjEv7wt5xY5p1ymkQ2R2vX03SrZWsqKH2DySxLhjd
         Q8xI4yY6HyR7f/S444I1c8PN056VkrpEXdSMSEASdBvoR2UaM5JMYq+zaidEMIB37iEs
         HwDcELqn6cRcdsGp6SHPOPA7MzfthHcjrvvhHNu63zLftr1hIDNOjXWMH1+7SBJz37SV
         9jS9z1LCJmD493x9aJXA1GEydGnJpKooRDOUEIj3fohfbs4IIFFDU/X8amN3rUzdiw4h
         m+gA==
X-Gm-Message-State: AOAM530Brlms2v3rORLH/GFdx8izKACWiBy2kerIZaq/o2bEVboj21p2
        qWpu6lZUThwpxfGRchTFvEmvqA==
X-Google-Smtp-Source: ABdhPJx73Id09SRSbyQ7yttHUhQ1XFsUCayEKdjf5Um64FVS0lPYLKHoeNVlJXLwSpbmAURdNlizvQ==
X-Received: by 2002:a37:2785:: with SMTP id n127mr12916932qkn.320.1614730963459;
        Tue, 02 Mar 2021 16:22:43 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id r3sm16690512qkm.129.2021.03.02.16.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 16:22:43 -0800 (PST)
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
Subject: [PATCH v12 08/17] arm64: kexec: skip relocation code for inplace kexec
Date:   Tue,  2 Mar 2021 19:22:21 -0500
Message-Id: <20210303002230.1083176-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
References: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
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

