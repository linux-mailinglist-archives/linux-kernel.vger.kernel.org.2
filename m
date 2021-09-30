Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B4841DC54
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351995AbhI3Ode (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351926AbhI3OdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:33:12 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A009EC061776
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:26 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 73so5974918qki.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=a4UWBG19ndOi78HFaDxtpOvDb/2uQd3EH24/B6Fqa/w=;
        b=Ds4z7LD5Z+Mi2pRwCBj8ySV7y8sqlAsz82jDxaarB1CA8ARQGfNTDZKfqF8Sw6E4Wh
         nq/ud6gBw+F5e/Y2OW/7cL/d/DDweMQR48tmkTJJY5qFyYVoBFrpCziwIyh1lASxIO5x
         ed4MDzfcQ1jkwRMQPZHI8rnx9767iPUYN830/oSF4GY1gF10sLA5M4FSVxSNqSVAh4Vy
         2ItlwMPGrCVYIJfqXFG934ycmp8xkFGhONWCDFfKWRVf2ybRcTQpWx2px7piZpzRGj1A
         c7CbY+TLQanIe+9leu1vf1U2p22xlSETEb/ACrt8zfvpRqXRIt9cbG/H1bR2Ht39X65y
         8Uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a4UWBG19ndOi78HFaDxtpOvDb/2uQd3EH24/B6Fqa/w=;
        b=3puOaqt2NO0CSPcJ0be0KFyQwu7g23D1Yb5ujtgyWa9Aze14YMi9fvFpMgN0IuERIK
         2TUON8wr2lqFJok5iWANimHBcPTt2GJqtgyjx+mcus4S2w6+ehNz/Gg4PJlHTx3hOLDP
         rQPadf7ImfZC4KHBdJYEn65znSbCzJrjXbc3vBnMR59HHdA1+WFB9SQWtuhnD91yjHaj
         mDvqh5aUWsJdC+Fxp4Qz/9J574oibKsuHQ5Td3RgvRXiw/mwF94EpCGodx93oSQd6bOL
         SBAsB5yU0GDqSxub5UVRkoGG42c1duEv7vMLZLUnZOdyHtA5NaUGmt7zOW+nwyUiHLKz
         FysQ==
X-Gm-Message-State: AOAM531uFyz7soKS2CpvUpNp0tF2x44DacytFwbp0TS7gKnC6Kb0p48j
        fenr3eXiw313jTYt4pj8pmGqYw==
X-Google-Smtp-Source: ABdhPJyqI9O+dVJs+vntZTBGZ9pxzbqB0UkHVZ/IqqI1agRY7/nbveVWZblYlDFFkKLclptvtLx9aQ==
X-Received: by 2002:a37:9144:: with SMTP id t65mr5175741qkd.170.1633012285793;
        Thu, 30 Sep 2021 07:31:25 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id l195sm1528731qke.98.2021.09.30.07.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:31:25 -0700 (PDT)
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
Subject: [PATCH v18 10/15] arm64: kexec: use ld script for relocation function
Date:   Thu, 30 Sep 2021 14:31:08 +0000
Message-Id: <20210930143113.1502553-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
References: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, relocation code declares start and end variables
which are used to compute its size.

The better way to do this is to use ld script, and put relocation
function in its own section.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/sections.h   |  1 +
 arch/arm64/kernel/machine_kexec.c   | 16 ++++++----------
 arch/arm64/kernel/relocate_kernel.S | 14 +-------------
 arch/arm64/kernel/vmlinux.lds.S     | 19 +++++++++++++++++++
 4 files changed, 27 insertions(+), 23 deletions(-)

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
index cf5d6f22a041..320442d35811 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -21,14 +21,11 @@
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
@@ -163,6 +160,7 @@ static void *kexec_page_alloc(void *arg)
 int machine_kexec_post_load(struct kimage *kimage)
 {
 	void *reloc_code = page_to_virt(kimage->control_code_page);
+	long reloc_size;
 	struct trans_pgd_info info = {
 		.trans_alloc_page	= kexec_page_alloc,
 		.trans_alloc_arg	= kimage,
@@ -183,17 +181,15 @@ int machine_kexec_post_load(struct kimage *kimage)
 			return rc;
 	}
 
-	memcpy(reloc_code, arm64_relocate_new_kernel,
-	       arm64_relocate_new_kernel_size);
+	reloc_size = __relocate_new_kernel_end - __relocate_new_kernel_start;
+	memcpy(reloc_code, __relocate_new_kernel_start, reloc_size);
 	kimage->arch.kern_reloc = __pa(reloc_code);
 
 	/* Flush the reloc_code in preparation for its execution. */
 	dcache_clean_inval_poc((unsigned long)reloc_code,
-			       (unsigned long)reloc_code +
-			       arm64_relocate_new_kernel_size);
+			       (unsigned long)reloc_code + reloc_size);
 	icache_inval_pou((uintptr_t)reloc_code,
-			 (uintptr_t)reloc_code +
-			 arm64_relocate_new_kernel_size);
+			 (uintptr_t)reloc_code + reloc_size);
 	kexec_list_flush(kimage);
 	kexec_image_info(kimage);
 
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index b4fb97312a80..2227741b96fa 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -15,6 +15,7 @@
 #include <asm/sysreg.h>
 #include <asm/virt.h>
 
+.section    ".kexec_relocate.text", "ax"
 /*
  * arm64_relocate_new_kernel - Put a 2nd stage image in place and boot it.
  *
@@ -77,16 +78,3 @@ SYM_CODE_START(arm64_relocate_new_kernel)
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
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index f6b1a88245db..0760331af85c 100644
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
+ASSERT(KEXEC_CONTROL_PAGE_SIZE >= SZ_4K, "KEXEC_CONTROL_PAGE_SIZE is broken")
+#endif
-- 
2.33.0.800.g4c38ced690-goog

