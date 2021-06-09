Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E683A3A0892
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 02:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbhFIArh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 20:47:37 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:45847 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbhFIAre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:47:34 -0400
Received: by mail-qk1-f182.google.com with SMTP id d196so17025763qkg.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 17:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ty+UClaOpOrJ9qBY9R0mQjMrJWAQ6ePXvWjy+fR64ec=;
        b=RR8QUSqJxkab4n7fmJSXo/jzTn32bDpgPv2YsNY/5axM1O6sP1S6nPBHJVZBPF65BJ
         fsAZqSkI/THGc5On0vujnM3SC3SdUHU4Ra7CwQ6fZhMIHhKrJBAAE0mZStEfZAKFqSXT
         c2Kivn4pMHh5Ktn32vJ1Dgcv0/1phq4V31x7KIDAEqnPqpxIFA0h1wtW9XO4p4xMngyQ
         99NKOTeMQ4KiTyHVUHhf2VO8YNI0OBapKZHarsx++HvNdJ8tZ3kFjn4QV9llfCqSo3gt
         1OX4f/fLH1+pA9fgDDiF6L3wl+IDbvcYjhenfAI/N2j5lA8N3y8H1Hq6JfMZU7GZ3Vpb
         3+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ty+UClaOpOrJ9qBY9R0mQjMrJWAQ6ePXvWjy+fR64ec=;
        b=m/NsmtWayLzOrNJwiz0qRpG2cF/UUrRTwV2qtwf4LT8f6dB8C6s/1glM385FFa9fJD
         S71CNAFs4iJDdPuZxN/s6VESXNZWK5iQoRMtq+iT+peY6fZefCGXuvEa+iXzH7gIVkZ3
         CQjs1WlllLbV3Rf7yPYsQJTINljf8nkyB6xBYXUYTCYgbn3UPg+wq37vdI5vEj0v8ZRt
         LxzRWWsNUuafRfGGzZSHAvg4WlqXrvCGg1ewSW8vrVqs6fkAUQQg9I2JjRQwj4ukIFq9
         r3kj2SBsfxsHGnpZxRdADyqOnrRrpjylLX0L+F5zq/ZOwr6MLgdAKse5EB2iAvTzBT8r
         M2IA==
X-Gm-Message-State: AOAM533z7guu7ZsX/81nXd4LVR2YUfllY9wM32H91JQBkQvPbRqf54iW
        Sfms9ZpNVekgNxE9U2LxliRo9A==
X-Google-Smtp-Source: ABdhPJwWZhdJj60QwViLmZW1EwFSY+KG2N/540VAQfq1U7H7vM7bK4gGZ4OWOvVNVTGROjphnexwIw==
X-Received: by 2002:a05:620a:214b:: with SMTP id m11mr21044160qkm.53.1623199464633;
        Tue, 08 Jun 2021 17:44:24 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id n194sm12869011qka.66.2021.06.08.17.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 17:44:24 -0700 (PDT)
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
Subject: [PATCH v15 02/15] arm64: trans_pgd: hibernate: Add trans_pgd_copy_el2_vectors
Date:   Tue,  8 Jun 2021 20:44:06 -0400
Message-Id: <20210609004419.936873-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609004419.936873-1-pasha.tatashin@soleen.com>
References: <20210609004419.936873-1-pasha.tatashin@soleen.com>
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
 arch/arm64/kernel/hibernate.c      | 25 ++++++-------
 arch/arm64/mm/Makefile             |  1 +
 arch/arm64/mm/trans_pgd-asm.S      | 58 ++++++++++++++++++++++++++++++
 arch/arm64/mm/trans_pgd.c          | 22 +++++++++++-
 7 files changed, 98 insertions(+), 69 deletions(-)
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
index 8ccca660034e..e4b0de990dec 100644
--- a/arch/arm64/kernel/hibernate-asm.S
+++ b/arch/arm64/kernel/hibernate-asm.S
@@ -111,56 +111,4 @@ SYM_CODE_START(swsusp_arch_suspend_exit)
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
index 42b5d8105ab9..fa2d1cb844a7 100644
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
 
@@ -431,6 +428,7 @@ int swsusp_arch_resume(void)
 	void *zero_page;
 	size_t exit_size;
 	pgd_t *tmp_pg_dir;
+	phys_addr_t el2_vectors;
 	void __noreturn (*hibernate_exit)(phys_addr_t, phys_addr_t, void *,
 					  void *, phys_addr_t, phys_addr_t);
 	struct trans_pgd_info trans_info = {
@@ -458,6 +456,14 @@ int swsusp_arch_resume(void)
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
@@ -470,25 +476,14 @@ int swsusp_arch_resume(void)
 		return rc;
 	}
 
-	/*
-	 * The hibernate exit text contains a set of el2 vectors, that will
-	 * be executed at el2 with the mmu off in order to reload hyp-stub.
-	 */
-	__flush_dcache_area(hibernate_exit, exit_size);
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
index 527f0a39c3da..d4f0a6492d8f 100644
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
@@ -322,3 +322,23 @@ int trans_pgd_idmap_page(struct trans_pgd_info *info, phys_addr_t *trans_ttbr0,
 
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
+	__flush_icache_range((unsigned long)hyp_stub,
+			     (unsigned long)hyp_stub + ARM64_VECTOR_TABLE_LEN);
+	__flush_dcache_area(hyp_stub, ARM64_VECTOR_TABLE_LEN);
+
+	return 0;
+}
-- 
2.25.1

