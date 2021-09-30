Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6E341DC4F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351907AbhI3OdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351922AbhI3OdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:33:12 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8F9C061773
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:24 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 11so3665742qvd.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WoiHQItxXcz2mVRE9xPdmbdljbzjyyQiR7Sfhvuof+4=;
        b=XkNv35QVeDXA+9ICJFiqcH3hry1Rj1XAj0QdnxsbRz6fwc9oUluTUbenVe9NBN3pnV
         CUtSC8fikhV2y56qoIbIQdAUA9zdrd5Nxa+TFhd+oYTNqu8c8kf0g+ku6eMcAWK/g19w
         GKkIGpvfDKObl1kWlsfqY6H6Si+vIw6XJTqX5Dep2sFYe+/Afg1UNtOAlbIuRexpz+QQ
         pTQo68B12adRqkcXim8b7BbrVZYUDQPxnDXJui5IcH58P0vuYghNKFrgnGhK4AXfsEyX
         03B4BBSipxHXtkVuQI16JQ/KClI21eNiaZVTH04d5cDKAa2eEbm/SAqlRsZ3FbyKuoTh
         ElDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WoiHQItxXcz2mVRE9xPdmbdljbzjyyQiR7Sfhvuof+4=;
        b=R9r7c2ahaV0FWoWkGghP6WISEKpry4MXqa4Y0T4yuP1Ct/s7HzIcHuxkhkYc7PDhsd
         BTCpAz4c+xzJDFSMK6JNYburKd7hIoVXP2VZi7XRBETT9MpRtBxcSFaRHS6I0Wt58y8o
         0eI5UDwTrjV/dMMtWzaVXCSQ5tG/yXFiAWOrRi+9yG/WRMaO5HjxiSZz667Nua+LstqA
         31W31JBZySqaPi+ga4ZEafviR1AaZcly6i+eP7eOYTr/GbeSKeUZTQwjSjwwc2BzB0zX
         rO9VD8gOrRoh1K71p5CByvUVbHh2fWL83X0pyLoKvWp9OD97NhvTNH1AE1J+XZOcDGaj
         TH4g==
X-Gm-Message-State: AOAM530a0J9UXUNiS4xvISkrg7O45TKZPAiJiTxdBGUyxMNZu0SIGIzS
        DNuRMrVr1gCwvIwjobdR3UYt/g==
X-Google-Smtp-Source: ABdhPJycCwt+koTjzhe5LqBKA+zcsOrf0LEcpfr3AGB09z+yDDgnPiU9k7YZduVSbOerYBZTV4y+2Q==
X-Received: by 2002:ad4:4989:: with SMTP id t9mr4126913qvx.29.1633012283934;
        Thu, 30 Sep 2021 07:31:23 -0700 (PDT)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id l195sm1528731qke.98.2021.09.30.07.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:31:23 -0700 (PDT)
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
Subject: [PATCH v18 08/15] arm64: kexec: configure EL2 vectors for kexec
Date:   Thu, 30 Sep 2021 14:31:06 +0000
Message-Id: <20210930143113.1502553-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
References: <20210930143113.1502553-1-pasha.tatashin@soleen.com>
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

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig                |  2 +-
 arch/arm64/include/asm/kexec.h    |  1 +
 arch/arm64/kernel/asm-offsets.c   |  1 +
 arch/arm64/kernel/machine_kexec.c | 31 +++++++++++++++++++++++++++++++
 arch/arm64/mm/trans_pgd-asm.S     |  9 ++++++++-
 5 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5c7ae4c3954b..552a057b40af 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1135,7 +1135,7 @@ config CRASH_DUMP
 
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
index 1d3319c7518e..6a2b8b1a4872 100644
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
index 8c4bffe3089d..021c31573bcb 100644
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
2.33.0.800.g4c38ced690-goog

