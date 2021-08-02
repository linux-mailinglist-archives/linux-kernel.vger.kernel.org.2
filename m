Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9603DE1F8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 23:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhHBVy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 17:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhHBVye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:54:34 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEE4C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 14:54:23 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id e14so579474qkg.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 14:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vllONSCM3KraKyPXhV20IkRxy2MdqODsPqhupnQLd9g=;
        b=FCHt4SLjRX4W0uKz1DC2INGR5UyRTa2DOy8SEOiO8odV0LjPUoY+8Xpup7M9GnxJUb
         M6HoRE2ijwYz85dPiuZGos8rnp6tGoSSiDdIK+KNQPkUPjsGgUKSWEC3/EjNSuDXPf1D
         xtWvr2VRWAjTPlT+W7jihLZucLsaD28uHw5zj1fOarSfM+vRhtRwZCuKxVeykXpY0e0M
         hFMcLjZYveT88rLNMJPd772Qm0WC9fOe6KowiYIfy1izlRpTyV92Kz2HIYoYfWwoiznc
         TvD4oG0+6DA0AcN97ItWekQTJFzr1XShyXpDasCVO0TX1C4KAy8+AaDBlxlYjLTcfQLr
         ODXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vllONSCM3KraKyPXhV20IkRxy2MdqODsPqhupnQLd9g=;
        b=caexlyNmEAdOAVJVGxfyYWe7dO0xB0XRHF7Qe8Jendtpl41eup+FWj4Uqrz2lmxsB6
         6NMOAST7rrrVD1B5yOhXCHSvHZFq47Oab+5QnMTzrJpHnGtFWadWPIuZN+/jskxmBJTK
         bYYcVLjWdushHwVJDvuCF2p6ERTcJ3V0voSNP24R2n7sH5Zo3UQObeclNSU8Bt8pxwWq
         jUa6KqmKMOj6ow0MVWGvEF/MsC0uwenGbJSfJhE7Kie6Hm5vFtZtqyq4Xw/4ZEJxTl3U
         LMu7iEQgQACaFsHeuRTISyc62YVfnfeWlndnHQ3M3zW04cX9JR2oeXuOCR/v9Mgsviu0
         KCyQ==
X-Gm-Message-State: AOAM5306nI5kgQ5WSuK2v8YCYuvkYhA29E6j8GfDyqjqaEUfGbqr7Ss2
        GhcEK4Gi+ANSZmW/eH/nm7LevA==
X-Google-Smtp-Source: ABdhPJy481uCAJREXivorCHdWuWZlyVeqri0ToaKhEh9mzCiyb+NJMFr7CnItwoU5vg1cHArwmCvvQ==
X-Received: by 2002:a05:620a:99b:: with SMTP id x27mr18189913qkx.138.1627941262162;
        Mon, 02 Aug 2021 14:54:22 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id v11sm5479216qtc.0.2021.08.02.14.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 14:54:21 -0700 (PDT)
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
Subject: [PATCH v16 08/15] arm64: kexec: configure EL2 vectors for kexec
Date:   Mon,  2 Aug 2021 17:54:01 -0400
Message-Id: <20210802215408.804942-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802215408.804942-1-pasha.tatashin@soleen.com>
References: <20210802215408.804942-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we have a EL2 mode without VHE, the EL2 vectors are needed in order
to switch to EL2 and jump to new world with hypervisor privileges.

In preparation to MMU enabled relocation, configure our EL2 table now.

Kexec uses #HVC_SOFT_RESTART to branch to the new world, so extend
el1_sync vector that is provided by trans_pgd_copy_el2_vectors() to
support this case.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/Kconfig                |  2 +-
 arch/arm64/include/asm/kexec.h    |  1 +
 arch/arm64/kernel/asm-offsets.c   |  1 +
 arch/arm64/kernel/machine_kexec.c | 31 +++++++++++++++++++++++++++++++
 arch/arm64/mm/trans_pgd-asm.S     |  9 ++++++++-
 5 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b5b13a932561..86dc6ddd2b8a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1138,7 +1138,7 @@ config CRASH_DUMP
 
 config TRANS_TABLE
 	def_bool y
-	depends on HIBERNATION
+	depends on HIBERNATION || KEXEC_CORE
 
 config XEN_DOM0
 	def_bool y
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 00dbcc71aeb2..753a1c398898 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -96,6 +96,7 @@ struct kimage_arch {
 	void *dtb;
 	phys_addr_t dtb_mem;
 	phys_addr_t kern_reloc;
+	phys_addr_t el2_vectors;
 };
 
 #ifdef CONFIG_KEXEC_FILE
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index b41409b09d04..47ccb57b787e 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -174,6 +174,7 @@ int main(void)
 #endif
 #ifdef CONFIG_KEXEC_CORE
   DEFINE(KIMAGE_ARCH_DTB_MEM,		offsetof(struct kimage, arch.dtb_mem));
+  DEFINE(KIMAGE_ARCH_EL2_VECTORS,	offsetof(struct kimage, arch.el2_vectors));
   DEFINE(KIMAGE_HEAD,			offsetof(struct kimage, head));
   DEFINE(KIMAGE_START,			offsetof(struct kimage, start));
   BLANK();
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index e210b19592c6..59a4b4172b68 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -21,6 +21,7 @@
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/page.h>
+#include <asm/trans_pgd.h>
 
 #include "cpu-reset.h"
 
@@ -43,7 +44,9 @@ static void _kexec_image_info(const char *func, int line,
 	pr_debug("    start:       %lx\n", kimage->start);
 	pr_debug("    head:        %lx\n", kimage->head);
 	pr_debug("    nr_segments: %lu\n", kimage->nr_segments);
+	pr_debug("    dtb_mem: %pa\n", &kimage->arch.dtb_mem);
 	pr_debug("    kern_reloc: %pa\n", &kimage->arch.kern_reloc);
+	pr_debug("    el2_vectors: %pa\n", &kimage->arch.el2_vectors);
 
 	for (i = 0; i < kimage->nr_segments; i++) {
 		pr_debug("      segment[%lu]: %016lx - %016lx, 0x%lx bytes, %lu pages\n",
@@ -143,9 +146,27 @@ static void kexec_segment_flush(const struct kimage *kimage)
 	}
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
+	struct trans_pgd_info info = {
+		.trans_alloc_page	= kexec_page_alloc,
+		.trans_alloc_arg	= kimage,
+	};
 
 	/* If in place, relocation is not used, only flush next kernel */
 	if (kimage->head & IND_DONE) {
@@ -154,6 +175,14 @@ int machine_kexec_post_load(struct kimage *kimage)
 		return 0;
 	}
 
+	kimage->arch.el2_vectors = 0;
+	if (is_hyp_nvhe()) {
+		int rc = trans_pgd_copy_el2_vectors(&info,
+						    &kimage->arch.el2_vectors);
+		if (rc)
+			return rc;
+	}
+
 	memcpy(reloc_code, arm64_relocate_new_kernel,
 	       arm64_relocate_new_kernel_size);
 	kimage->arch.kern_reloc = __pa(reloc_code);
@@ -209,6 +238,8 @@ void machine_kexec(struct kimage *kimage)
 		restart(is_hyp_nvhe(), kimage->start, kimage->arch.dtb_mem,
 			0, 0);
 	} else {
+		if (is_hyp_nvhe())
+			__hyp_set_vectors(kimage->arch.el2_vectors);
 		cpu_soft_restart(kimage->arch.kern_reloc, virt_to_phys(kimage),
 				 0, 0);
 	}
diff --git a/arch/arm64/mm/trans_pgd-asm.S b/arch/arm64/mm/trans_pgd-asm.S
index 831d6369494e..c1f2ed1be6de 100644
--- a/arch/arm64/mm/trans_pgd-asm.S
+++ b/arch/arm64/mm/trans_pgd-asm.S
@@ -24,7 +24,14 @@ SYM_CODE_START_LOCAL(el1_sync)
 	msr	vbar_el2, x1
 	mov	x0, xzr
 	eret
-1:	/* Unexpected argument, set an error */
+1:	cmp	x0, #HVC_SOFT_RESTART	/* Called from kexec */
+	b.ne	2f
+	mov	x0, x2
+	mov	x2, x4
+	mov	x4, x1
+	mov	x1, x3
+	br	x4
+2:	/* Unexpected argument, set an error */
 	mov_q	x0, HVC_STUB_ERR
 	eret
 SYM_CODE_END(el1_sync)
-- 
2.25.1

