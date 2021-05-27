Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2603931C8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbhE0PI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236789AbhE0PHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:07:21 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246A2C06138D
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:44 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id q6so256382qvb.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wPqWbOC642+FQuLJdmHZY8xtJm1ZVhhgjTRiZDTZY7Q=;
        b=OYcSb6MwLOEpinFGHYb3FQsN6yhufIjwNbxeyeRaz5wrZtQ/5vpDYqcsw6mj8mqgFS
         5UE2pAQSBYMHHc5pzxtMNiWczCnfbE1ewNR25yNAc51ClquEAU42eWpD0wf7yKRwaa8u
         EJ4J1rzwEIAcPfcFUk17zjO/4bk1E+3laPOMgMNvpcUPtx9wdkjNK16ungcGbtUZZggp
         R0htuLwV94wC/5xA6en5rnhOodoYgPQYgWwBNINEbi9IsatqBRJokknUJ9QHGsoZbH40
         o1WrbfLH0KcBdE54RrkTFHAtvePLYHlUx7qY91Nve36OHBX/DaA3M7dEWr+EOsekJxO5
         HojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wPqWbOC642+FQuLJdmHZY8xtJm1ZVhhgjTRiZDTZY7Q=;
        b=HxQnfrHPDHl87yei13XvOYIWL0uYlWz/eN/1YcUPJZ+cuAhYSLhzB7DeWG6mKv87KD
         rAJhMkuq4kj0tDV+J9qraZtD94vobexBag6eXqxdSSsrb04qqQxxSnz7EWBCSbD2Sg6t
         hlAoPvBemWxBkgoacWt7UTWF6rfma/s7CC23qIUjYM/wY6/xmDSh9oAbODt2qCuXWcNc
         xK4+RIwQ+dbFozOcK7+8pPgs/ZCvggQXSUGR39vLeAkUYdK9E8Pw5moGLrGx6e4gl2WO
         t2k7QaHMmPbSIb5Otn3gPODjpag2nSvh8QAj/CGO5ahbMsLLThrxVG4PnIGD25uwRDfa
         sJqQ==
X-Gm-Message-State: AOAM530SrEpqPj6GmSwWw02vwR1/5ztvc/f0/x2TPesgClb/JcPGgH/z
        BdBvSYACyVXvGRTPsIHDbGjUhA==
X-Google-Smtp-Source: ABdhPJyMEicr+0neWvvsEC3Ec9nXUiLYCTi0Iea32NIOel70L8g//7eWi+fs+fDfMn3EnbeZcrliew==
X-Received: by 2002:ad4:536a:: with SMTP id e10mr3765205qvv.9.1622127943895;
        Thu, 27 May 2021 08:05:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x10sm1447468qkh.124.2021.05.27.08.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:05:43 -0700 (PDT)
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
Subject: [PATCH 10/18] arm64: kexec: pass kimage as the only argument to relocation function
Date:   Thu, 27 May 2021 11:05:18 -0400
Message-Id: <20210527150526.271941-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527150526.271941-1-pasha.tatashin@soleen.com>
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kexec relocation function (arm64_relocate_new_kernel) accepts
the following arguments:

head:		start of array that contains relocation information.
entry:		entry point for new kernel or purgatory.
dtb_mem:	first and only argument to entry.

The number of arguments cannot be easily expended, because this
function is also called from HVC_SOFT_RESTART, which preserves only
three arguments. And, also arm64_relocate_new_kernel is written in
assembly but called without stack, thus no place to move extra arguments
to free registers.

Soon, we will need to pass more arguments: once we enable MMU we
will need to pass information about page tables.

Pass kimage to arm64_relocate_new_kernel, and teach it to get the
required fields from kimage.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/asm-offsets.c     |  7 +++++++
 arch/arm64/kernel/machine_kexec.c   |  6 ++++--
 arch/arm64/kernel/relocate_kernel.S | 10 ++++------
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 0cb34ccb6e73..92c2ed846730 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -9,6 +9,7 @@
 
 #include <linux/arm_sdei.h>
 #include <linux/sched.h>
+#include <linux/kexec.h>
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
 #include <linux/kvm_host.h>
@@ -155,6 +156,12 @@ int main(void)
   DEFINE(PTRAUTH_USER_KEY_APIA,		offsetof(struct ptrauth_keys_user, apia));
   DEFINE(PTRAUTH_KERNEL_KEY_APIA,	offsetof(struct ptrauth_keys_kernel, apia));
   BLANK();
+#endif
+#ifdef CONFIG_KEXEC_CORE
+  DEFINE(KIMAGE_ARCH_DTB_MEM,		offsetof(struct kimage, arch.dtb_mem));
+  DEFINE(KIMAGE_HEAD,			offsetof(struct kimage, head));
+  DEFINE(KIMAGE_START,			offsetof(struct kimage, start));
+  BLANK();
 #endif
   return 0;
 }
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index bde623805866..76a757954a70 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -83,6 +83,8 @@ static void kexec_list_flush(struct kimage *kimage)
 {
 	kimage_entry_t *entry;
 
+	__flush_dcache_area(kimage, sizeof(*kimage));
+
 	for (entry = &kimage->head; ; entry++) {
 		unsigned int flag;
 		void *addr;
@@ -198,8 +200,8 @@ void machine_kexec(struct kimage *kimage)
 		restart(is_hyp_callable(), kimage->start, kimage->arch.dtb_mem,
 			0, 0);
 	} else {
-		cpu_soft_restart(kimage->arch.kern_reloc, kimage->head,
-				 kimage->start, kimage->arch.dtb_mem);
+		cpu_soft_restart(kimage->arch.kern_reloc, virt_to_phys(kimage),
+				 0, 0);
 	}
 
 	BUG(); /* Should never get here. */
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 718037bef560..36b4496524c3 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -27,9 +27,7 @@
  */
 SYM_CODE_START(arm64_relocate_new_kernel)
 	/* Setup the list loop variables. */
-	mov	x18, x2				/* x18 = dtb address */
-	mov	x17, x1				/* x17 = kimage_start */
-	mov	x16, x0				/* x16 = kimage_head */
+	ldr	x16, [x0, #KIMAGE_HEAD]		/* x16 = kimage_head */
 	mov	x14, xzr			/* x14 = entry ptr */
 	mov	x13, xzr			/* x13 = copy dest */
 	raw_dcache_line_size x15, x1		/* x15 = dcache line size */
@@ -63,12 +61,12 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 	isb
 
 	/* Start new image. */
-	mov	x0, x18
+	ldr	x4, [x0, #KIMAGE_START]		/* relocation start */
+	ldr	x0, [x0, #KIMAGE_ARCH_DTB_MEM]	/* dtb address */
 	mov	x1, xzr
 	mov	x2, xzr
 	mov	x3, xzr
-	br	x17
-
+	br	x4
 SYM_CODE_END(arm64_relocate_new_kernel)
 
 .align 3	/* To keep the 64-bit values below naturally aligned. */
-- 
2.25.1

