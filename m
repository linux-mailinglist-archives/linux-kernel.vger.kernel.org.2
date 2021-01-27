Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409223062A3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344204AbhA0Rvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbhA0R1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:27:51 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D4FC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:27:10 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id a1so1403643qvd.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 09:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ASygAqr57jUZ78nCjocRBoBMKp4WVYWpgcDuzWEf5/U=;
        b=lTW8AsSeGiTqhrvoe5+DBlxNbXH/Jl+2xyBWNDwB76Bg8MNCuvd6VNwkmJ4+h63cZX
         cuq1Hb5sgFA9btCgFJ1qlG7gFOO9yjiPdnvbbADDuICXgW4ePbFURxqoTvJbgj35gXLl
         cYTYx1IjAV587qwyGmaRdylhQw3z11+nFnsBEcq0EOLmQsJWymmY++T5KvljbsHwL5TZ
         JKP3aTXz5mdnMHXMT1rL/M2j51IVvCKZBnD/YmNSWiVDpKFPuhgDLUuH9M8INScH3Ywl
         j8bNzL4bTdELqLfTU0vHpDFzwa+6thecSerPkkUNYqHGh3aUQs9T6I/ptCm+mYIUblHA
         Hlfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ASygAqr57jUZ78nCjocRBoBMKp4WVYWpgcDuzWEf5/U=;
        b=LQzktLZCL6JhbztU39fjrpaSvawNo8iea0WpCrhO6kb57NreFT9vLSnICypBVM40zm
         NfFRd/vpu9DilZFW2YdGgzU7OLVoQVv9DzW7yXyRMF9WexHtKVceskJT1qNdSKfxySo+
         j//yMglSwusAfJxTImDWhdsR8sRczSu4dcspFyAARn94wC5HyV0E5nI1CkAY6cKZ49yq
         ewW+8M3Pcz5WQ/bs/OWvYi2NvPnEJaWkhzQflSevkAH0OQ7o+OzmGctw+G5SrvIr7QRo
         ZnaHCIRDbU0ydZO8cwycYERB7SOjl5k57focPr1pwk2fORFvVRjipK20tTiQkL0gjjof
         DdHg==
X-Gm-Message-State: AOAM533k5yjziD6p8Y18LuLAZvkiGX94LzZKuYtRyOvUeM6+hxijcrRd
        WXlu3AVpdL28FFVVRDntdbJPyg==
X-Google-Smtp-Source: ABdhPJxIcrcK4iDLzYXxJWKQD6eG4blKjf34bscTuC6KLr/1IGH2MCDgmQpbj2CQsy/4e2VNcDPU/g==
X-Received: by 2002:a0c:a8e7:: with SMTP id h39mr11424788qvc.45.1611768430096;
        Wed, 27 Jan 2021 09:27:10 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id z2sm1728019qtz.71.2021.01.27.09.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 09:27:09 -0800 (PST)
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
Subject: [PATCH v11 1/6] arm64: kexec: add expandable argument to relocation function
Date:   Wed, 27 Jan 2021 12:27:01 -0500
Message-Id: <20210127172706.617195-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210127172706.617195-1-pasha.tatashin@soleen.com>
References: <20210127172706.617195-1-pasha.tatashin@soleen.com>
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
three arguments (hypervisor abi). And, also arm64_relocate_new_kernel is
written in assembly but called without stack, thus no place to move extra
arguments to free registers.

Soon, we will need to pass more arguments: once we enable MMU we
will need to pass information about page tables.

Add a new struct: kern_reloc_arg, and place it in kexec safe page (i.e
memory that is not overwritten during relocation).
Thus, make arm64_relocate_new_kernel to only take one argument, that
contains all the needed information.

Note:
Another benefit of allowing this function to accept more arguments, is that
kernel can actually accept up to 4 arguments (x0-x3), however currently
only one is used, but if in the future we will need for more (for example,
pass information about when previous kernel exited to have a precise
measurement in time spent in purgatory), we won't be easilty do that
if arm64_relocate_new_kernel can't accept more arguments.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h      | 18 ++++++++++++++++++
 arch/arm64/kernel/asm-offsets.c     |  9 +++++++++
 arch/arm64/kernel/cpu-reset.S       | 11 +++--------
 arch/arm64/kernel/cpu-reset.h       |  8 +++-----
 arch/arm64/kernel/machine_kexec.c   | 27 +++++++++++++++++++++++++--
 arch/arm64/kernel/relocate_kernel.S | 21 ++++++++-------------
 6 files changed, 66 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 9befcd87e9a8..990185744148 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -90,12 +90,30 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
+/*
+ * kern_reloc_arg is passed to kernel relocation function as an argument.
+ * head		kimage->head, allows to traverse through relocation segments.
+ * entry_addr	kimage->start, where to jump from relocation function (new
+ *		kernel, or purgatory entry address).
+ * kern_arg0	first argument to kernel is its dtb address. The other
+ *		arguments are currently unused, and must be set to 0
+ */
+struct kern_reloc_arg {
+	phys_addr_t head;
+	phys_addr_t entry_addr;
+	phys_addr_t kern_arg0;
+	phys_addr_t kern_arg1;
+	phys_addr_t kern_arg2;
+	phys_addr_t kern_arg3;
+};
+
 #define ARCH_HAS_KIMAGE_ARCH
 
 struct kimage_arch {
 	void *dtb;
 	phys_addr_t dtb_mem;
 	phys_addr_t kern_reloc;
+	phys_addr_t kern_reloc_arg;
 	/* Core ELF header buffer */
 	void *elf_headers;
 	unsigned long elf_headers_mem;
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 301784463587..6067a288f568 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -23,6 +23,7 @@
 #include <asm/suspend.h>
 #include <linux/kbuild.h>
 #include <linux/arm-smccc.h>
+#include <linux/kexec.h>
 
 int main(void)
 {
@@ -150,6 +151,14 @@ int main(void)
   DEFINE(PTRAUTH_USER_KEY_APGA,		offsetof(struct ptrauth_keys_user, apga));
   DEFINE(PTRAUTH_KERNEL_KEY_APIA,	offsetof(struct ptrauth_keys_kernel, apia));
   BLANK();
+#endif
+#ifdef CONFIG_KEXEC_CORE
+  DEFINE(KEXEC_KRELOC_HEAD,		offsetof(struct kern_reloc_arg, head));
+  DEFINE(KEXEC_KRELOC_ENTRY_ADDR,	offsetof(struct kern_reloc_arg, entry_addr));
+  DEFINE(KEXEC_KRELOC_KERN_ARG0,	offsetof(struct kern_reloc_arg, kern_arg0));
+  DEFINE(KEXEC_KRELOC_KERN_ARG1,	offsetof(struct kern_reloc_arg, kern_arg1));
+  DEFINE(KEXEC_KRELOC_KERN_ARG2,	offsetof(struct kern_reloc_arg, kern_arg2));
+  DEFINE(KEXEC_KRELOC_KERN_ARG3,	offsetof(struct kern_reloc_arg, kern_arg3));
 #endif
   return 0;
 }
diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
index 37721eb6f9a1..bbf70db43744 100644
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -16,14 +16,11 @@
 .pushsection    .idmap.text, "awx"
 
 /*
- * __cpu_soft_restart(el2_switch, entry, arg0, arg1, arg2) - Helper for
- * cpu_soft_restart.
+ * __cpu_soft_restart(el2_switch, entry, arg) - Helper for cpu_soft_restart.
  *
  * @el2_switch: Flag to indicate a switch to EL2 is needed.
  * @entry: Location to jump to for soft reset.
- * arg0: First argument passed to @entry. (relocation list)
- * arg1: Second argument passed to @entry.(physical kernel entry)
- * arg2: Third argument passed to @entry. (physical dtb address)
+ * arg: Entry argument
  *
  * Put the CPU into the same state as it would be if it had been reset, and
  * branch to what would be the reset vector. It must be executed with the
@@ -47,9 +44,7 @@ SYM_CODE_START(__cpu_soft_restart)
 	hvc	#0				// no return
 
 1:	mov	x8, x1				// entry
-	mov	x0, x2				// arg0
-	mov	x1, x3				// arg1
-	mov	x2, x4				// arg2
+	mov	x0, x2				// arg
 	br	x8
 SYM_CODE_END(__cpu_soft_restart)
 
diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
index ed50e9587ad8..7a8720ff186f 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -11,12 +11,10 @@
 #include <asm/virt.h>
 
 void __cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
-	unsigned long arg0, unsigned long arg1, unsigned long arg2);
+			unsigned long arg);
 
 static inline void __noreturn cpu_soft_restart(unsigned long entry,
-					       unsigned long arg0,
-					       unsigned long arg1,
-					       unsigned long arg2)
+					       unsigned long arg)
 {
 	typeof(__cpu_soft_restart) *restart;
 
@@ -25,7 +23,7 @@ static inline void __noreturn cpu_soft_restart(unsigned long entry,
 	restart = (void *)__pa_symbol(__cpu_soft_restart);
 
 	cpu_install_idmap();
-	restart(el2_switch, entry, arg0, arg1, arg2);
+	restart(el2_switch, entry, arg);
 	unreachable();
 }
 
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 90a335c74442..679db3f1e0c5 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -43,6 +43,7 @@ static void _kexec_image_info(const char *func, int line,
 	pr_debug("    head:        %lx\n", kimage->head);
 	pr_debug("    nr_segments: %lu\n", kimage->nr_segments);
 	pr_debug("    kern_reloc: %pa\n", &kimage->arch.kern_reloc);
+	pr_debug("    kern_reloc_arg: %pa\n", &kimage->arch.kern_reloc_arg);
 
 	for (i = 0; i < kimage->nr_segments; i++) {
 		pr_debug("      segment[%lu]: %016lx - %016lx, 0x%lx bytes, %lu pages\n",
@@ -59,19 +60,42 @@ void machine_kexec_cleanup(struct kimage *kimage)
 	/* Empty routine needed to avoid build errors. */
 }
 
+/* Allocates pages for kexec page table */
+static void *kexec_page_alloc(void *arg)
+{
+	struct kimage *kimage = (struct kimage *)arg;
+	struct page *page = kimage_alloc_control_pages(kimage, 0);
+
+	if (!page)
+		return NULL;
+
+	memset(page_address(page), 0, PAGE_SIZE);
+
+	return page_address(page);
+}
+
 int machine_kexec_post_load(struct kimage *kimage)
 {
 	void *reloc_code = page_to_virt(kimage->control_code_page);
+	struct kern_reloc_arg *kern_reloc_arg = kexec_page_alloc(kimage);
+
+	if (!kern_reloc_arg)
+		return -ENOMEM;
 
 	memcpy(reloc_code, arm64_relocate_new_kernel,
 	       arm64_relocate_new_kernel_size);
 	kimage->arch.kern_reloc = __pa(reloc_code);
+	kimage->arch.kern_reloc_arg = __pa(kern_reloc_arg);
+	kern_reloc_arg->head = kimage->head;
+	kern_reloc_arg->entry_addr = kimage->start;
+	kern_reloc_arg->kern_arg0 = kimage->arch.dtb_mem;
 	kexec_image_info(kimage);
 
 	/* Flush the reloc_code in preparation for its execution. */
 	__flush_dcache_area(reloc_code, arm64_relocate_new_kernel_size);
 	flush_icache_range((uintptr_t)reloc_code, (uintptr_t)reloc_code +
 			   arm64_relocate_new_kernel_size);
+	__flush_dcache_area(kern_reloc_arg, sizeof(struct kern_reloc_arg));
 
 	return 0;
 }
@@ -192,8 +216,7 @@ void machine_kexec(struct kimage *kimage)
 	 * userspace (kexec-tools).
 	 * In kexec_file case, the kernel starts directly without purgatory.
 	 */
-	cpu_soft_restart(kimage->arch.kern_reloc, kimage->head, kimage->start,
-			 kimage->arch.dtb_mem);
+	cpu_soft_restart(kimage->arch.kern_reloc, kimage->arch.kern_reloc_arg);
 
 	BUG(); /* Should never get here. */
 }
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index b78ea5de97a4..c92228aeddca 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -8,7 +8,7 @@
 
 #include <linux/kexec.h>
 #include <linux/linkage.h>
-
+#include <asm/asm-offsets.h>
 #include <asm/assembler.h>
 #include <asm/kexec.h>
 #include <asm/page.h>
@@ -26,13 +26,8 @@
  * safe memory that has been set up to be preserved during the copy operation.
  */
 SYM_CODE_START(arm64_relocate_new_kernel)
-	/* Setup the list loop variables. */
-	mov	x18, x2				/* x18 = dtb address */
-	mov	x17, x1				/* x17 = kimage_start */
-	mov	x16, x0				/* x16 = kimage_head */
-	mov	x14, xzr			/* x14 = entry ptr */
-	mov	x13, xzr			/* x13 = copy dest */
 	/* Check if the new image needs relocation. */
+	ldr	x16, [x0, #KEXEC_KRELOC_HEAD]	/* x16 = kimage_head */
 	tbnz	x16, IND_DONE_BIT, .Ldone
 	raw_dcache_line_size x15, x1		/* x15 = dcache line size */
 .Lloop:
@@ -73,12 +68,12 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 	isb
 
 	/* Start new image. */
-	mov	x0, x18
-	mov	x1, xzr
-	mov	x2, xzr
-	mov	x3, xzr
-	br	x17
-
+	ldr	x4, [x0, #KEXEC_KRELOC_ENTRY_ADDR]	/* x4 = kimage_start */
+	ldr	x3, [x0, #KEXEC_KRELOC_KERN_ARG3]
+	ldr	x2, [x0, #KEXEC_KRELOC_KERN_ARG2]
+	ldr	x1, [x0, #KEXEC_KRELOC_KERN_ARG1]
+	ldr	x0, [x0, #KEXEC_KRELOC_KERN_ARG0]	/* x0 = dtb address */
+	br	x4
 SYM_CODE_END(arm64_relocate_new_kernel)
 
 .align 3	/* To keep the 64-bit values below naturally aligned. */
-- 
2.25.1

