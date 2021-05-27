Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011AE3931CA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbhE0PIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbhE0PHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:07:30 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11718C061347
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:49 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id i12so415737qtr.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=M+UnYXxw8nkrHqAjav5617WACApgFL7LNjySWDjNsqw=;
        b=OM8jv6dIvYQ/oU4lPaj545Lb6wcf2ECof0M+ej1+Y+Zo0H/YsWGYtnXhh2nlXF8qzz
         Ae7FdACu6ubQkw8iOcaZWTKXb3SvgrwUOl1OdUNFT0Wv76oAZtQ5DBjnYrbry7/jXH0/
         5ThzZ5f/USoigM/PsymqzJFSNqfgHrhULDkokiDhB8JL6eVaxHY/QGuuRZcY7M5QPpVR
         zMh4PH4RvS17sRS25iqSOVMJYGoSlE+H9TeViZoU4y8wqVULNRlAywaMpnrsLA+R7ULL
         qVC/ljBDadvYtAPXy4npxJ0yHe1c1a21Xt4Tf9L0tQ14+Wfa2HBtlw3qWqNLUAAACY3P
         o2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M+UnYXxw8nkrHqAjav5617WACApgFL7LNjySWDjNsqw=;
        b=ajqBLSskPDm6HH+9pVIfJ1VJsZrTXeNlfgYVXxIyBO5RiAN/ThwTXjHtLmJDvoKm1x
         gIf0/PyG12SmBSftdna+t+b6b3kw+Ec7WhokROLbt7SVb1aHsuHEgQ8cCOD2UJ8VM1tC
         71zBWhRzEfegbvEjUcIriQpyxfkl9sU2nCuVjYWAPLH6B/Qi4fNXFUbYdvK8Pa3Kve8T
         Japn1IOcO+HYl7l64y2cX4QzQoDFQJ8IGEWa9e3iUBIM2uOvKfJjfmkvvW17tpaYlR1P
         wrL0KrwlTSz82C8bxtlWsc/CFoDkhj5ZCME439qOQYZrlOV4/0eU0+iLHk9YvfulNDg+
         rsnQ==
X-Gm-Message-State: AOAM532m8/8dzAS9dh+7ve3TzByD6LIT8OcXh8AfQs28Ti8PEYvVM49R
        w/rknahQv7FX7WLpHRzTh0xtaw==
X-Google-Smtp-Source: ABdhPJykKRJouKWov8JqAp4TT6mHaHetjX4h/gTdtSRZ4IF/EPEd/iut0BXLaxTvC2S2l28hvd4vGg==
X-Received: by 2002:ac8:13c3:: with SMTP id i3mr3613497qtj.322.1622127948200;
        Thu, 27 May 2021 08:05:48 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x10sm1447468qkh.124.2021.05.27.08.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:05:47 -0700 (PDT)
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
Subject: [PATCH 13/18] arm64: kexec: use ld script for relocation function
Date:   Thu, 27 May 2021 11:05:21 -0400
Message-Id: <20210527150526.271941-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527150526.271941-1-pasha.tatashin@soleen.com>
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, relocation code declares start and end variables
which are used to compute its size.

The better way to do this is to use ld script incited, and put relocation
function in its own section.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/sections.h   |  1 +
 arch/arm64/kernel/machine_kexec.c   | 14 ++++++--------
 arch/arm64/kernel/relocate_kernel.S | 15 ++-------------
 arch/arm64/kernel/vmlinux.lds.S     | 19 +++++++++++++++++++
 4 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index e4ad9db53af1..152cb35bf9df 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -21,5 +21,6 @@ extern char __exittext_begin[], __exittext_end[];
 extern char __irqentry_text_start[], __irqentry_text_end[];
 extern char __mmuoff_data_start[], __mmuoff_data_end[];
 extern char __entry_tramp_text_start[], __entry_tramp_text_end[];
+extern char __relocate_new_kernel_start[], __relocate_new_kernel_end[];
 
 #endif /* __ASM_SECTIONS_H */
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index c9993f029262..675d27d7aea4 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -20,14 +20,11 @@
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/page.h>
+#include <asm/sections.h>
 #include <asm/trans_pgd.h>
 
 #include "cpu-reset.h"
 
-/* Global variables for the arm64_relocate_new_kernel routine. */
-extern const unsigned char arm64_relocate_new_kernel[];
-extern const unsigned long arm64_relocate_new_kernel_size;
-
 /**
  * kexec_image_info - For debugging output.
  */
@@ -157,6 +154,7 @@ static void *kexec_page_alloc(void *arg)
 int machine_kexec_post_load(struct kimage *kimage)
 {
 	void *reloc_code = page_to_virt(kimage->control_code_page);
+	long reloc_size;
 	struct trans_pgd_info info = {
 		.trans_alloc_page	= kexec_page_alloc,
 		.trans_alloc_arg	= kimage,
@@ -177,14 +175,14 @@ int machine_kexec_post_load(struct kimage *kimage)
 			return rc;
 	}
 
-	memcpy(reloc_code, arm64_relocate_new_kernel,
-	       arm64_relocate_new_kernel_size);
+	reloc_size = __relocate_new_kernel_end - __relocate_new_kernel_start;
+	memcpy(reloc_code, __relocate_new_kernel_start, reloc_size);
 	kimage->arch.kern_reloc = __pa(reloc_code);
 
 	/* Flush the reloc_code in preparation for its execution. */
-	__flush_dcache_area(reloc_code, arm64_relocate_new_kernel_size);
+	__flush_dcache_area(reloc_code, reloc_size);
 	flush_icache_range((uintptr_t)reloc_code, (uintptr_t)reloc_code +
-			   arm64_relocate_new_kernel_size);
+			   reloc_size);
 	kexec_list_flush(kimage);
 	kexec_image_info(kimage);
 
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index df023b82544b..7a600ba33ae1 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -15,6 +15,7 @@
 #include <asm/sysreg.h>
 #include <asm/virt.h>
 
+.pushsection    ".kexec_relocate.text", "ax"
 /*
  * arm64_relocate_new_kernel - Put a 2nd stage image in place and boot it.
  *
@@ -77,16 +78,4 @@ SYM_CODE_START(arm64_relocate_new_kernel)
 	mov	x3, xzr
 	br	x4				/* Jumps from el1 */
 SYM_CODE_END(arm64_relocate_new_kernel)
-
-.align 3	/* To keep the 64-bit values below naturally aligned. */
-
-.Lcopy_end:
-.org	KEXEC_CONTROL_PAGE_SIZE
-
-/*
- * arm64_relocate_new_kernel_size - Number of bytes to copy to the
- * control_code_page.
- */
-.globl arm64_relocate_new_kernel_size
-arm64_relocate_new_kernel_size:
-	.quad	.Lcopy_end - arm64_relocate_new_kernel
+.popsection
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 709d2c433c5e..9479d66f03bf 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -63,6 +63,7 @@
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
 #include <asm/kernel-pgtable.h>
+#include <asm/kexec.h>
 #include <asm/memory.h>
 #include <asm/page.h>
 
@@ -100,6 +101,16 @@ jiffies = jiffies_64;
 #define HIBERNATE_TEXT
 #endif
 
+#ifdef CONFIG_KEXEC_CORE
+#define KEXEC_TEXT					\
+	. = ALIGN(SZ_4K);				\
+	__relocate_new_kernel_start = .;		\
+	*(.kexec_relocate.text)				\
+	__relocate_new_kernel_end = .;
+#else
+#define KEXEC_TEXT
+#endif
+
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 #define TRAMP_TEXT					\
 	. = ALIGN(PAGE_SIZE);				\
@@ -160,6 +171,7 @@ SECTIONS
 			HYPERVISOR_TEXT
 			IDMAP_TEXT
 			HIBERNATE_TEXT
+			KEXEC_TEXT
 			TRAMP_TEXT
 			*(.fixup)
 			*(.gnu.warning)
@@ -348,3 +360,10 @@ ASSERT(swapper_pg_dir - reserved_pg_dir == RESERVED_SWAPPER_OFFSET,
 ASSERT(swapper_pg_dir - tramp_pg_dir == TRAMP_SWAPPER_OFFSET,
        "TRAMP_SWAPPER_OFFSET is wrong!")
 #endif
+
+#ifdef CONFIG_KEXEC_CORE
+/* kexec relocation code should fit into one KEXEC_CONTROL_PAGE_SIZE */
+ASSERT(__relocate_new_kernel_end - (__relocate_new_kernel_start & ~(SZ_4K - 1))
+	<= SZ_4K, "kexec relocation code is too big or misaligned")
+ASSERT(KEXEC_CONTROL_PAGE_SIZE >= SZ_4K, "KEXEC_CONTROL_PAGE_SIZE is brokern")
+#endif
-- 
2.25.1

