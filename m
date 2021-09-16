Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFC540EDBF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 01:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241538AbhIPXPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 19:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241495AbhIPXO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 19:14:57 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE58C061768
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:13:36 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d11so7178689qtw.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Q0X9wptyBwxDna881tcar0OeMQAxIOwfXu68NQUnafI=;
        b=CC4algdnAtsH9amZNnT+KVVlnw33h5Jdh3h05XmPiUN9DejKe9AvFtHTA396RlfRui
         B5H1ETmA2DzpAANiNzlbZU4YZ2uJo876rTr+aMD6WhKXS15ifxbdelf3URW4ex4Ox7cw
         Z6Io6u8SGm1V0sTmcBg5MWGbWmana7higW3HVbquVxsXVtlPrZr3pd6tBsjrnK0fVO2W
         HrOZ/as1QBTwiNvsRNV0xyuI6xADyVZvxMmCL9NCErppS6GyuiICDGm/Bj5+zqxHUX3o
         I3YV5awOsn9yp4YAEgotCZ5q/YoPRoTEGPRO0jQmxdlY+wST4bGalHWc4TvU2F5QpDs+
         Eqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q0X9wptyBwxDna881tcar0OeMQAxIOwfXu68NQUnafI=;
        b=dE7BoeJmr54Vf2czkd6aij+4vNPsGw4UMlIjMurMGZnn8iecbynAbg3mGTkYMSa7or
         q/dGPNmg2H64MiO9m08UFyqotVtXmf6NEuxvjHNByljuB897sCZT34mTJqgGqxYMhwhN
         yYaUJMp9MQXJmy1NL3zqFxXVGaBnfEPX4P1qJHDudioBT0rdjH0R4lWDh7962Jxzxt3K
         8o6Nwd7nO4r5n/ZB7zfDgImRiuyEkYLLyO2WwWoEH++U9oG6INxEe5BJqxvXyOjfOpfW
         ZmPM47HWrdz8SMQEdecK8JuVuYrjQ9y6TM+mef6akLUeInVAOsOlibinwxhmwIq/lnzA
         /P9g==
X-Gm-Message-State: AOAM530Ip+LV1ScHpqitqfPAfz6JbwB6zzvZB3UnO659ZN2gyQanIzaN
        ZwTSgsAZRyoX010Ll7m9ovaWlA==
X-Google-Smtp-Source: ABdhPJw9vRYrw4iWZuL7eob/6c1iVPoPfda6H/N97kzq3jld260E01UPVSLZmJD5zdsp5ECEl7t4/Q==
X-Received: by 2002:a05:622a:18c:: with SMTP id s12mr4045444qtw.62.1631834015346;
        Thu, 16 Sep 2021 16:13:35 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id az6sm3312891qkb.70.2021.09.16.16.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 16:13:34 -0700 (PDT)
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
Subject: [PATCH v17 05/15] arm64: kexec: skip relocation code for inplace kexec
Date:   Thu, 16 Sep 2021 19:13:15 -0400
Message-Id: <20210916231325.125533-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916231325.125533-1-pasha.tatashin@soleen.com>
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
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

