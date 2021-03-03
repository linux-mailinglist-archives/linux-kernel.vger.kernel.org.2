Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C82232B73C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443321AbhCCKvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238032AbhCCA0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 19:26:20 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAFCC0611C2
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 16:22:50 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id dj14so3301760qvb.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 16:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IBZj7dYh8lQRd+RkarkK6Bs3S98VDCxIDzsjaOHMyWU=;
        b=bKq3DOfy+ZZ2Br+ZXPwnr++JLsk2BOWy0QyrfsLY6aZS5OS4WSDGnNHfH8Icr0Z8I+
         HOk/5OYLaspLekY1uItNjP9HFswk0cGO5JyOgS4Xbrfa9H7cSB4LdBlvUxuJhK4H+cib
         ru04FyGfJRo+sC3ysELsdQ2o9h1TMC4Jld9NJUUtDG6UjhaCyL1ezmZMZh5s6WU0PGc4
         8bQe9pI4CW2cns5OQYOpxkOSPbubGDDyxQeJyQ9wZ3fHz7qOj0xd3HFKiaLqOqqwWAfP
         tbh9FZQ+wJC+teNKGy/f19ohcQicVlGPjTjHkfLWWPH8aSxnj73rrhZgLmKrV3EOd8Z5
         f6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IBZj7dYh8lQRd+RkarkK6Bs3S98VDCxIDzsjaOHMyWU=;
        b=lGWBXP9M/zFdRSPXK5CRrrjoeThhFM1X79eAS3qMsnl4O0LyqM+ZIeq85RsXH4TX79
         hprA52DjylaRu8vMsa9QGnq5xspYag3bUe05xl8ixLk56V0z6RcqoDJEwHA1JJTuOkw5
         sbWEqEQ4arBYvzmEQcInotueeMipFCZ/idUi8xuRfAE2Zl22xI5G7TJAckWmlH+0nFmn
         cmrGWu7yjO2dgesHmiCZcqAyo9i6j3mGCm6yYaAY+xlzWo/ADYoy2617u1TT4nT2FqJW
         i2hINJq1NVnzbVioyQs9bIVcJGeUM7hPQzP0RDTCFaaEiJaGaUMnURggS+Y5581z9jmx
         OUCA==
X-Gm-Message-State: AOAM5310Oy1B9CxCm30lP7/PrPI38WTz3bF29kYZzx2DbrxM3avOCucn
        bPwJeMCk8q+BTxkZYIBnU8TYzg==
X-Google-Smtp-Source: ABdhPJxvNv+/84aSaILV/bO4Xb7Cban1AhQ63vws8517ykCszMsFD3aYB5zfOTZP/wFR41IfZGWghg==
X-Received: by 2002:a0c:8f1a:: with SMTP id z26mr350314qvd.51.1614730969894;
        Tue, 02 Mar 2021 16:22:49 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id r3sm16690512qkm.129.2021.03.02.16.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 16:22:49 -0800 (PST)
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
Subject: [PATCH v12 13/17] arm64: kexec: use ld script for relocation function
Date:   Tue,  2 Mar 2021 19:22:26 -0500
Message-Id: <20210303002230.1083176-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
References: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
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

