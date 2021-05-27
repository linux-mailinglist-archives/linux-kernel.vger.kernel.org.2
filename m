Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD403931C5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbhE0PIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbhE0PHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:07:16 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5CFC06138A
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:41 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id e8so240690qvp.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WOdTNCc8/+vKdXFWJvALf/5jcbGhRyKjqHuE0XK9ac4=;
        b=d8BkTIMDubNMKo8lhGcNu7AKdRus5J2M4TufcGSW4HtAeu3NbJ3XThPB66dQ+1m9p4
         uQSN6tv4/0GLeQQUYYLvH9KTMD/3Y0ymqQQJUncGSGi7O+XI9dAh+bjI/F2JTBUYDI/b
         hG56Miopzkxf4OQah6VFcnupnjMDqnyYzxqclfNuueFAlJIXCIk/mUQkSy0l9hy7LZ63
         8t5Zl2QIKW2FphA5noBR5hutyqZWAAE7ORfjV0j8Vn4IoOBLjWbakCjpSu+mbfcwra9P
         9PA5A7XXtZhKASA48HUe+DjXCCyoKtyblRuv7GcVXybzYhpFeowUdCednMkzMNvzqc3m
         sUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WOdTNCc8/+vKdXFWJvALf/5jcbGhRyKjqHuE0XK9ac4=;
        b=EZzVU6EZ9m6oVQKxC6EU97cxWJ5VmWGWYyOi/mzZUgUzq5Y1MYpHCbLzsR6zCaRKFu
         Gxyt8nldDWz2WmAQ5HUGwgGfXRAeyRRbIF866Me0nocSPUPKSvo8L6/UNJkyLeH++VT4
         Rt264dTPbr+dzZp8mYdcVDAT+9sxihi3+rL8REMAoKz7HE9w0R+USUlsZmrkQxLXUo4V
         XxjYRi08katOEh+u8FET1ZcaBa9Sfi+EBF8cWVGKFqzbJQo256mDhH2sVR2VKH1OyMtM
         8cEUj9hVAyyMtX8tz1XOgg2M/bHTbIiYuC31HvuBee7hHygIBDglJwoTC4DogSfhjZt7
         pQ0w==
X-Gm-Message-State: AOAM532hrXXwi7Fsh0UxCe0tpWkb6AkX1pi3qNEwPFxXXWWNMPvKSzmr
        8+SMcQ3i5zM9guSXDKNYBxst4A==
X-Google-Smtp-Source: ABdhPJxuuInT5boY5wx2h9r0mi/iNoeH4rIqWoxJwXXRJPR79arNDGrkhRpZr8NydkZli6xNGukztQ==
X-Received: by 2002:ad4:4810:: with SMTP id g16mr4197984qvy.21.1622127941083;
        Thu, 27 May 2021 08:05:41 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x10sm1447468qkh.124.2021.05.27.08.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:05:40 -0700 (PDT)
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
Subject: [PATCH 08/18] arm64: kexec: skip relocation code for inplace kexec
Date:   Thu, 27 May 2021 11:05:16 -0400
Message-Id: <20210527150526.271941-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527150526.271941-1-pasha.tatashin@soleen.com>
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
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
index 3a034bc25709..bde623805866 100644
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
+		restart = (void *)__pa_symbol(function_nocfi(__cpu_soft_restart));
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

