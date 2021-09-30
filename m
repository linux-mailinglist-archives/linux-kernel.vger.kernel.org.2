Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C5441DC4C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350024AbhI3OdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350118AbhI3OdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:33:01 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C26C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:18 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id a9so3727169qvf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+4++pnD78fv084ZJJb31cAwxAfjQdVgmdWKFv3ofNWM=;
        b=PwSkFB5lUIJlNNvHorXkdi5cHBr8TW91BMYYJo/Le3xqGzArqbpyx08n0Ln1FNN8V9
         FAFTqIVj/f6d2W2gsY177xVTv/r9AbnqH4GQjLc5PtOUs8+4OQmadzz3A1Xs43xchghI
         Wh4vRLWrbaVRb9Pb5gtLeFoVmTZXCEB68pVST4gG3jNkJaIE4sHBDcgxA2xRJF9rcc5i
         CM08jBrUniz8B0qRG8PFfjRS7s22iK1OMmYBeFI8eXLY2MI7XDHeoUOCgT3O2uDFTCHN
         esQ15Pe1NoByE+7fmDdFl6Uf/mCv2brr7uhwPGQwntr7Nt5pqreknxdkGI2gzzHDVK1Y
         ipZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+4++pnD78fv084ZJJb31cAwxAfjQdVgmdWKFv3ofNWM=;
        b=ZHjwGoUZZb+oBdKLvcHU70sAjpwlRlFSe8ic9LZeFIhskb8R22juoSsitey+xjCbZ8
         5T4Mun3k/N8qpajbf/SxcnqgXFgCj54+7rPQc+hU6n0qoNSOdbT/Z3jLRm+orRa3w6DL
         CQlbeOz2G+sSw1VHOxYDWbeBIAbTU/3lJ8IVQqlX3MUqXefGpLW28X3w/qKR5E6fMhwF
         AmG4O8XW5yxPkoj4YDK9fZPQ7uz9wnfh3CSLsfLfJN0LS0uooQPOIc+YzhHaOB+9obBw
         D1HOeNc0y5oTIJP2gPtPKI6pAMd+u90+3P4CJSG4a47TtQPDpjpsLjNDmpGTh9PhiJfg
         7p2A==
X-Gm-Message-State: AOAM5334gUImyOyzxgoBv8MA3gKzk2NdGqHYX+h2f0Y7beXknn+BC59Y
        yM7/6D8EnNZJ1xXH4yg+TtdkVQ==
X-Google-Smtp-Source: ABdhPJzkISSDNj6DI6kaZcbl1IAI6lqibUXU1DRHLZaDVciLYY9K0DrqkYiXrO51Bv8hV2XWzusKEg==
X-Received: by 2002:a0c:f38b:: with SMTP id i11mr1177471qvk.20.1633012277774;
        Thu, 30 Sep 2021 07:31:17 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id l195sm1528731qke.98.2021.09.30.07.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:31:17 -0700 (PDT)
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
Subject: [PATCH v18 02/15] arm64: trans_pgd: hibernate: Add trans_pgd_copy_el2_vectors
Date:   Thu, 30 Sep 2021 14:31:00 +0000
Message-Id: <20210930143113.1502553-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
References: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users of trans_pgd may also need a copy of vector table because it is
also may be overwritten if a linear map can be overwritten.

Move setup of EL2 vectors from hibernate to trans_pgd, so it can be
later shared with kexec as well.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/trans_pgd.h |  9 +++--
 arch/arm64/include/asm/virt.h      |  2 ++
 arch/arm64/kernel/hibernate-asm.S  | 52 ---------------------------
 arch/arm64/kernel/hibernate.c      | 26 ++++++--------
 arch/arm64/mm/Makefile             |  1 +
 arch/arm64/mm/trans_pgd-asm.S      | 58 ++++++++++++++++++++++++++++++
 arch/arm64/mm/trans_pgd.c          | 27 ++++++++++++--
 7 files changed, 103 insertions(+), 72 deletions(-)
 create mode 100644 arch/arm64/mm/trans_pgd-asm.S

diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
index 5d08e5adf3d5..7b04d32b102c 100644
--- a/arch/arm64/include/asm/trans_pgd.h
+++ b/arch/arm64/include/asm/trans_pgd.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 /*
- * Copyright (c) 2020, Microsoft Corporation.
- * Pavel Tatashin <pasha.tatashin@soleen.com>
+ * Copyright (c) 2021, Microsoft Corporation.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
  */
 
 #ifndef _ASM_TRANS_TABLE_H
@@ -36,4 +36,9 @@ int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
 int trans_pgd_idmap_page(struct trans_pgd_info *info, phys_addr_t *trans_ttbr0,
 			 unsigned long *t0sz, void *page);
 
+int trans_pgd_copy_el2_vectors(struct trans_pgd_info *info,
+			       phys_addr_t *el2_vectors);
+
+extern char trans_pgd_stub_vectors[];
+
 #endif /* _ASM_TRANS_TABLE_H */
diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index a9457e96203c..3c8af033a997 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -67,6 +67,8 @@
  */
 extern u32 __boot_cpu_mode[2];
 
+#define ARM64_VECTOR_TABLE_LEN	SZ_2K
+
 void __hyp_set_vectors(phys_addr_t phys_vector_base);
 void __hyp_reset_vectors(void);
 
diff --git a/arch/arm64/kernel/hibernate-asm.S b/arch/arm64/kernel/hibernate-asm.S
index 81c0186a5e32..a30a2c3f905e 100644
--- a/arch/arm64/kernel/hibernate-asm.S
+++ b/arch/arm64/kernel/hibernate-asm.S
@@ -112,56 +112,4 @@ alternative_insn "dc cvau, x4",  "dc civac, x4",  ARM64_WORKAROUND_CLEAN_CACHE
 	hvc	#0
 3:	ret
 SYM_CODE_END(swsusp_arch_suspend_exit)
-
-/*
- * Restore the hyp stub.
- * This must be done before the hibernate page is unmapped by _cpu_resume(),
- * but happens before any of the hyp-stub's code is cleaned to PoC.
- *
- * x24: The physical address of __hyp_stub_vectors
- */
-SYM_CODE_START_LOCAL(el1_sync)
-	msr	vbar_el2, x24
-	eret
-SYM_CODE_END(el1_sync)
-
-.macro invalid_vector	label
-SYM_CODE_START_LOCAL(\label)
-	b \label
-SYM_CODE_END(\label)
-.endm
-
-	invalid_vector	el2_sync_invalid
-	invalid_vector	el2_irq_invalid
-	invalid_vector	el2_fiq_invalid
-	invalid_vector	el2_error_invalid
-	invalid_vector	el1_sync_invalid
-	invalid_vector	el1_irq_invalid
-	invalid_vector	el1_fiq_invalid
-	invalid_vector	el1_error_invalid
-
-/* el2 vectors - switch el2 here while we restore the memory image. */
-	.align 11
-SYM_CODE_START(hibernate_el2_vectors)
-	ventry	el2_sync_invalid		// Synchronous EL2t
-	ventry	el2_irq_invalid			// IRQ EL2t
-	ventry	el2_fiq_invalid			// FIQ EL2t
-	ventry	el2_error_invalid		// Error EL2t
-
-	ventry	el2_sync_invalid		// Synchronous EL2h
-	ventry	el2_irq_invalid			// IRQ EL2h
-	ventry	el2_fiq_invalid			// FIQ EL2h
-	ventry	el2_error_invalid		// Error EL2h
-
-	ventry	el1_sync			// Synchronous 64-bit EL1
-	ventry	el1_irq_invalid			// IRQ 64-bit EL1
-	ventry	el1_fiq_invalid			// FIQ 64-bit EL1
-	ventry	el1_error_invalid		// Error 64-bit EL1
-
-	ventry	el1_sync_invalid		// Synchronous 32-bit EL1
-	ventry	el1_irq_invalid			// IRQ 32-bit EL1
-	ventry	el1_fiq_invalid			// FIQ 32-bit EL1
-	ventry	el1_error_invalid		// Error 32-bit EL1
-SYM_CODE_END(hibernate_el2_vectors)
-
 .popsection
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 4c9533f4c0c4..b96ef9060e4c 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -51,9 +51,6 @@ extern int in_suspend;
 /* Do we need to reset el2? */
 #define el2_reset_needed() (is_hyp_nvhe())
 
-/* temporary el2 vectors in the __hibernate_exit_text section. */
-extern char hibernate_el2_vectors[];
-
 /* hyp-stub vectors, used to restore el2 during resume from hibernate. */
 extern char __hyp_stub_vectors[];
 
@@ -434,6 +431,7 @@ int swsusp_arch_resume(void)
 	void *zero_page;
 	size_t exit_size;
 	pgd_t *tmp_pg_dir;
+	phys_addr_t el2_vectors;
 	void __noreturn (*hibernate_exit)(phys_addr_t, phys_addr_t, void *,
 					  void *, phys_addr_t, phys_addr_t);
 	struct trans_pgd_info trans_info = {
@@ -461,6 +459,14 @@ int swsusp_arch_resume(void)
 		return -ENOMEM;
 	}
 
+	if (el2_reset_needed()) {
+		rc = trans_pgd_copy_el2_vectors(&trans_info, &el2_vectors);
+		if (rc) {
+			pr_err("Failed to setup el2 vectors\n");
+			return rc;
+		}
+	}
+
 	exit_size = __hibernate_exit_text_end - __hibernate_exit_text_start;
 	/*
 	 * Copy swsusp_arch_suspend_exit() to a safe page. This will generate
@@ -473,26 +479,14 @@ int swsusp_arch_resume(void)
 		return rc;
 	}
 
-	/*
-	 * The hibernate exit text contains a set of el2 vectors, that will
-	 * be executed at el2 with the mmu off in order to reload hyp-stub.
-	 */
-	dcache_clean_inval_poc((unsigned long)hibernate_exit,
-			    (unsigned long)hibernate_exit + exit_size);
-
 	/*
 	 * KASLR will cause the el2 vectors to be in a different location in
 	 * the resumed kernel. Load hibernate's temporary copy into el2.
 	 *
 	 * We can skip this step if we booted at EL1, or are running with VHE.
 	 */
-	if (el2_reset_needed()) {
-		phys_addr_t el2_vectors = (phys_addr_t)hibernate_exit;
-		el2_vectors += hibernate_el2_vectors -
-			       __hibernate_exit_text_start;     /* offset */
-
+	if (el2_reset_needed())
 		__hyp_set_vectors(el2_vectors);
-	}
 
 	hibernate_exit(virt_to_phys(tmp_pg_dir), resume_hdr.ttbr1_el1,
 		       resume_hdr.reenter_kernel, restore_pblist,
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index f188c9092696..ff1e800ba7a1 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_PTDUMP_CORE)	+= ptdump.o
 obj-$(CONFIG_PTDUMP_DEBUGFS)	+= ptdump_debugfs.o
 obj-$(CONFIG_TRANS_TABLE)	+= trans_pgd.o
+obj-$(CONFIG_TRANS_TABLE)	+= trans_pgd-asm.o
 obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
 obj-$(CONFIG_ARM64_MTE)		+= mteswap.o
 KASAN_SANITIZE_physaddr.o	+= n
diff --git a/arch/arm64/mm/trans_pgd-asm.S b/arch/arm64/mm/trans_pgd-asm.S
new file mode 100644
index 000000000000..8c4bffe3089d
--- /dev/null
+++ b/arch/arm64/mm/trans_pgd-asm.S
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * Copyright (c) 2021, Microsoft Corporation.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/kvm_asm.h>
+
+.macro invalid_vector	label
+SYM_CODE_START_LOCAL(\label)
+	.align 7
+	b	\label
+SYM_CODE_END(\label)
+.endm
+
+.macro el1_sync_vector
+SYM_CODE_START_LOCAL(el1_sync)
+	.align 7
+	cmp	x0, #HVC_SET_VECTORS	/* Called from hibernate */
+	b.ne	1f
+	msr	vbar_el2, x1
+	mov	x0, xzr
+	eret
+1:	/* Unexpected argument, set an error */
+	mov_q	x0, HVC_STUB_ERR
+	eret
+SYM_CODE_END(el1_sync)
+.endm
+
+SYM_CODE_START(trans_pgd_stub_vectors)
+	invalid_vector	hyp_stub_el2t_sync_invalid	// Synchronous EL2t
+	invalid_vector	hyp_stub_el2t_irq_invalid	// IRQ EL2t
+	invalid_vector	hyp_stub_el2t_fiq_invalid	// FIQ EL2t
+	invalid_vector	hyp_stub_el2t_error_invalid	// Error EL2t
+
+	invalid_vector	hyp_stub_el2h_sync_invalid	// Synchronous EL2h
+	invalid_vector	hyp_stub_el2h_irq_invalid	// IRQ EL2h
+	invalid_vector	hyp_stub_el2h_fiq_invalid	// FIQ EL2h
+	invalid_vector	hyp_stub_el2h_error_invalid	// Error EL2h
+
+	el1_sync_vector					// Synchronous 64-bit EL1
+	invalid_vector	hyp_stub_el1_irq_invalid	// IRQ 64-bit EL1
+	invalid_vector	hyp_stub_el1_fiq_invalid	// FIQ 64-bit EL1
+	invalid_vector	hyp_stub_el1_error_invalid	// Error 64-bit EL1
+
+	invalid_vector	hyp_stub_32b_el1_sync_invalid	// Synchronous 32-bit EL1
+	invalid_vector	hyp_stub_32b_el1_irq_invalid	// IRQ 32-bit EL1
+	invalid_vector	hyp_stub_32b_el1_fiq_invalid	// FIQ 32-bit EL1
+	invalid_vector	hyp_stub_32b_el1_error_invalid	// Error 32-bit EL1
+	.align 11
+SYM_INNER_LABEL(__trans_pgd_stub_vectors_end, SYM_L_LOCAL)
+SYM_CODE_END(trans_pgd_stub_vectors)
+
+# Check the trans_pgd_stub_vectors didn't overflow
+.org . - (__trans_pgd_stub_vectors_end - trans_pgd_stub_vectors) + SZ_2K
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index 527f0a39c3da..26bd8f2d95af 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -5,8 +5,8 @@
  *
  * This file derived from: arch/arm64/kernel/hibernate.c
  *
- * Copyright (c) 2020, Microsoft Corporation.
- * Pavel Tatashin <pasha.tatashin@soleen.com>
+ * Copyright (c) 2021, Microsoft Corporation.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
  *
  */
 
@@ -322,3 +322,26 @@ int trans_pgd_idmap_page(struct trans_pgd_info *info, phys_addr_t *trans_ttbr0,
 
 	return 0;
 }
+
+/*
+ * Create a copy of the vector table so we can call HVC_SET_VECTORS or
+ * HVC_SOFT_RESTART from contexts where the table may be overwritten.
+ */
+int trans_pgd_copy_el2_vectors(struct trans_pgd_info *info,
+			       phys_addr_t *el2_vectors)
+{
+	void *hyp_stub = trans_alloc(info);
+
+	if (!hyp_stub)
+		return -ENOMEM;
+	*el2_vectors = virt_to_phys(hyp_stub);
+	memcpy(hyp_stub, &trans_pgd_stub_vectors, ARM64_VECTOR_TABLE_LEN);
+	caches_clean_inval_pou((unsigned long)hyp_stub,
+			       (unsigned long)hyp_stub +
+			       ARM64_VECTOR_TABLE_LEN);
+	dcache_clean_inval_poc((unsigned long)hyp_stub,
+			       (unsigned long)hyp_stub +
+			       ARM64_VECTOR_TABLE_LEN);
+
+	return 0;
+}
-- 
2.33.0.800.g4c38ced690-goog

