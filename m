Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594ED3DE1F2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 23:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbhHBVyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 17:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhHBVyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:54:25 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0887C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 14:54:14 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id s11so9638413qvz.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 14:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YKdfgXuhu2CUCgXa9ObvPNn0CQc7wFt5Zs9uSkuVOsA=;
        b=gfWVCyeKZPOId7LZeYo8c368E3yisYg9Xgca9a9MXwLGcV4UeBg2K3NyHRFCulISgX
         mzOOWsVW5Cu3kVe8g+ivsmp/XkslZNVQiEPBnpeJrtTUaP5EnwQOfPgvitPaJb9A38ox
         rS9o9gA1l9Nv2Hzyj21wCeqyRVfajIISqCfIWnboqiNYT0W/W+YWZAUAoHqc7ZIAwG1W
         TDKavvZTfY5W5SCP17yVqwJ1qO7EYdOivc3V8+arrtVLtLfp8VqqFtJBt4HXbcoos7z8
         zZO8Ap9KwvLY0TSXIiUTdFBEri21hxWZVyZ1r0cbpMDWJAQ8MLln//7YMR1slBDSg3ec
         13OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YKdfgXuhu2CUCgXa9ObvPNn0CQc7wFt5Zs9uSkuVOsA=;
        b=OOlKMrbJ4mpZ8H051Bg1Kk5x/wr55JAgb28dg1fK8iB7Vf/k/e9c6njspHVbW39kPs
         6ijRL5mgDweWmqgGe+6Zyz3E7HxWlLcnQBk80i38RbTrTaTUtgSP3ATSRGNKcnvrkcMF
         hUBwiwuZ/ghXAfKgdeyCwIf4eb2S2T3Kg3B1OdWo0ABaPFY6H7YFTlNHg9ZBSDueJidB
         lhYmK+VJGH2tcusgdW/A25IxLe0fDhKwX0KRJ55zYoaOIeVekjQQhigmPvA223O6Wizw
         VLjnHzJ43IvgUhfhDdzt3vzDxI98ptYgmkGTqpvbTzFoGY1LUBlHsNptCROtLqXPy7XB
         WkNQ==
X-Gm-Message-State: AOAM532D/VLtduyiNXoQszjSe3GboIgBjc00bkxwsR8mDokvQyj2b+ZK
        aW42Nfb+cWszaH7SsQrFZlw3vg==
X-Google-Smtp-Source: ABdhPJye8pVKXRr53NzwS56TsDSey/dZjhEjDvIMOivgptTWN5vFfw2CKKx6GPR5mqVzfSe590ht6Q==
X-Received: by 2002:a0c:be8e:: with SMTP id n14mr18289595qvi.16.1627941253896;
        Mon, 02 Aug 2021 14:54:13 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id v11sm5479216qtc.0.2021.08.02.14.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:54:13 -0700 (PDT)
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
Subject: [PATCH v16 02/15] arm64: trans_pgd: hibernate: Add trans_pgd_copy_el2_vectors
Date:   Mon,  2 Aug 2021 17:53:55 -0400
Message-Id: <20210802215408.804942-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802215408.804942-1-pasha.tatashin@soleen.com>
References: <20210802215408.804942-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users of trans_pgd may also need a copy of vector table because it is
also may be overwritten if a linear map can be overwritten.

Move setup of EL2 vectors from hibernate to trans_pgd, so it can be
later shared with kexec as well.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/trans_pgd.h |  7 +++-
 arch/arm64/include/asm/virt.h      |  2 ++
 arch/arm64/kernel/hibernate-asm.S  | 52 ---------------------------
 arch/arm64/kernel/hibernate.c      | 26 ++++++--------
 arch/arm64/mm/Makefile             |  1 +
 arch/arm64/mm/trans_pgd-asm.S      | 58 ++++++++++++++++++++++++++++++
 arch/arm64/mm/trans_pgd.c          | 25 ++++++++++++-
 7 files changed, 101 insertions(+), 70 deletions(-)
 create mode 100644 arch/arm64/mm/trans_pgd-asm.S

diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
index 5d08e5adf3d5..411323bda7a4 100644
--- a/arch/arm64/include/asm/trans_pgd.h
+++ b/arch/arm64/include/asm/trans_pgd.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 /*
- * Copyright (c) 2020, Microsoft Corporation.
+ * Copyright (c) 2021, Microsoft Corporation.
  * Pavel Tatashin <pasha.tatashin@soleen.com>
  */
 
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
index 000000000000..831d6369494e
--- /dev/null
+++ b/arch/arm64/mm/trans_pgd-asm.S
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * Copyright (c) 2021, Microsoft Corporation.
+ * Pavel Tatashin <pasha.tatashin@soleen.com>
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
index 527f0a39c3da..a08cf313c858 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -5,7 +5,7 @@
  *
  * This file derived from: arch/arm64/kernel/hibernate.c
  *
- * Copyright (c) 2020, Microsoft Corporation.
+ * Copyright (c) 2021, Microsoft Corporation.
  * Pavel Tatashin <pasha.tatashin@soleen.com>
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
2.25.1

