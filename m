Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2E0357B19
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 06:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhDHEGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 00:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhDHEGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 00:06:07 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E49C061765
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 21:05:56 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id j3so268658qvs.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 21:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IBZj7dYh8lQRd+RkarkK6Bs3S98VDCxIDzsjaOHMyWU=;
        b=XWa9sziZNgfipw2p+fBnm+a/QR10cQILmaujAFu4l6VA+vlVaDGjksM7UsE3OmENKV
         VNucczfet1qHKZ/5/akhn3GRx6lbaaSgBaCSZf1ydSx8NjIkndwUoAG5HuRdZkLBbVIE
         MkqHHktYZswwr8dW1Djt/3BBInIEvh2P8lufEAXfFrn/Rt/5VfbusPDdCIF2C7eq/2L8
         2pSPqmCoZMW3PzGChT+fE1dIZHjIOMOOPu1mI6AC5dXeRe+orGOzpTfQwf6KA2FBhZ3R
         t9p1rvZn1c56KaacZ1E2JNlRU2HvqbI8E1ZTAYwCMHw+AlhL8gIv9J8FfSZdnatgxjtl
         97kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IBZj7dYh8lQRd+RkarkK6Bs3S98VDCxIDzsjaOHMyWU=;
        b=Wb+fxUNU26lDf6Rat1WiuDJyWQ8kG7FFOerXsqeIAQODWae5YRkgR6nMutxbG2Q/EW
         Y7tOQekNpwLcHD9lxvQt9h6/aBxs5q6R+wnzYl4p9YTBC5O1HpMLIzNvMA7aTjk8d+yu
         Mo4S0HiaFm+ws/WRepnJebRvJs0M2bwaoC3qHUb8S16cS2xua23TZJqF+oVz7xFzk1De
         vH2shaZvBe1m4Ta13IKGe3qxZJFZpTlNfDQmxnuN7O1+dCvpLu8741Cg5p2NaKYwiBG3
         l/VLCPfpQpINvEh2irTOSj/3OgmK4hIdgJ5GlSR/xMvTuJmplxJWV9ZwRjch3JLv1PrS
         GcDg==
X-Gm-Message-State: AOAM5316IwPAJ8voARXZBHr1Q1QsylossKIwz5BP6DoLWrwZ1LtjWDB7
        /yfV9xjOXdmMQtX7P1ebgezx8A==
X-Google-Smtp-Source: ABdhPJw4OtlQ8Oa4W1fxbuBoRRZz0Ihai6LuM5gpbSIyFOGLtDUBu9w/nYGR7vBoD5f7IcL9Em6JfQ==
X-Received: by 2002:a05:6214:aa6:: with SMTP id ew6mr6754949qvb.2.1617854756198;
        Wed, 07 Apr 2021 21:05:56 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 207sm18177874qkl.125.2021.04.07.21.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 21:05:55 -0700 (PDT)
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
Subject: [PATCH v13 13/18] arm64: kexec: use ld script for relocation function
Date:   Thu,  8 Apr 2021 00:05:32 -0400
Message-Id: <20210408040537.2703241-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
References: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
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
index 2f36b16a5b5d..31e459af89f6 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -20,5 +20,6 @@ extern char __exittext_begin[], __exittext_end[];
 extern char __irqentry_text_start[], __irqentry_text_end[];
 extern char __mmuoff_data_start[], __mmuoff_data_end[];
 extern char __entry_tramp_text_start[], __entry_tramp_text_end[];
+extern char __relocate_new_kernel_start[], __relocate_new_kernel_end[];
 
 #endif /* __ASM_SECTIONS_H */
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index d5940b7889f8..f1451d807708 100644
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
index 7eea7888bb02..0d9d5e6af66f 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -12,6 +12,7 @@
 #include <asm/cache.h>
 #include <asm/hyp_image.h>
 #include <asm/kernel-pgtable.h>
+#include <asm/kexec.h>
 #include <asm/memory.h>
 #include <asm/page.h>
 
@@ -92,6 +93,16 @@ jiffies = jiffies_64;
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
@@ -152,6 +163,7 @@ SECTIONS
 			HYPERVISOR_TEXT
 			IDMAP_TEXT
 			HIBERNATE_TEXT
+			KEXEC_TEXT
 			TRAMP_TEXT
 			*(.fixup)
 			*(.gnu.warning)
@@ -336,3 +348,10 @@ ASSERT(swapper_pg_dir - reserved_pg_dir == RESERVED_SWAPPER_OFFSET,
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

