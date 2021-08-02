Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144393DE1F4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 23:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhHBVyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 17:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbhHBVy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:54:28 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CEBC061796
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 14:54:18 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 190so18086074qkk.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 14:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ySRVVRwC++hMLjkNftECyAUjQh43zsO4xteYxz9kO+M=;
        b=dDf0vz0iWjVamQXhs2vdDdV8GxpuCrMHeOrVcKatUZm8kDuGj8aeCscvU0ZKD0PR0u
         P3pwTsllBPlz2qGvsHN3dUnYVn9dSEo6LBJP4H0RtxYomoXuhtxjmIISfIRQ193rnuhP
         7enai/reMUqp8BRJ5yUgJrsJ1VF4UhhHchvnJ/ktN2mn4+i6gV4H1OPJh0qz01OH1/6B
         OQvr+N3zf28VJq15xRpdvv1UhQgnEzM4s2IEP+eICABab0xDNAQhm8X2FjUx1acmwCXi
         Yh399GttIvMrf46wXZgEWsv0Srz2KGWWLNr48vP5KF4aBEf9kYJIUn7GwYCoX3x/AROl
         HE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ySRVVRwC++hMLjkNftECyAUjQh43zsO4xteYxz9kO+M=;
        b=WoVqUrm/20ystWa6/bwqQ21kR1ZPoJEFPO8kzxcqvbmOy9jrqNtnDaEFm0XgqZp0Tt
         En4xMAQDMXFmcqwijel4tKLFJmBHSldcYY1rIia7xCahvSUdecGG3N+A1Z/7JT/KELEo
         us1iqOkkhOURYDyOHkxtFx5Mui1RB+ehrqvQCU0J+GluT8hR0h+LVeCOzoNufJJ+edVl
         XkAiNX1FSrpMZB5Ni9R2JVlW6XQuefjXP6ej5tv3sSRtbS/+OVx+uYmxvY7jQ50RnWIH
         0S1XxJbx5ivNerRyplD7m5tl1phWRh/vxRsOefgLYeHK8GhDzmAu3pRDkAZSZc/9gE1Q
         UnWg==
X-Gm-Message-State: AOAM531raBqw5MEc1m1fBvoRpG++g9Omn+8wWiHcRVjaoneaTFuol/Ro
        NwTeQeqnMs476upJYMdyJrj/jw==
X-Google-Smtp-Source: ABdhPJycxFDEqftDsNgLCqQw0liKmCH9habEesWjmQ0Ce5hXdnSfdBKjeqzPZ1g5aBX40OQ7MsZwFg==
X-Received: by 2002:a05:620a:4d0:: with SMTP id 16mr17965487qks.430.1627941257981;
        Mon, 02 Aug 2021 14:54:17 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id v11sm5479216qtc.0.2021.08.02.14.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:54:17 -0700 (PDT)
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
Subject: [PATCH v16 05/15] arm64: kexec: skip relocation code for inplace kexec
Date:   Mon,  2 Aug 2021 17:53:58 -0400
Message-Id: <20210802215408.804942-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802215408.804942-1-pasha.tatashin@soleen.com>
References: <20210802215408.804942-1-pasha.tatashin@soleen.com>
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
2.25.1

