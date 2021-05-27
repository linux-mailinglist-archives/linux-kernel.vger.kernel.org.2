Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B7F3931C9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbhE0PIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbhE0PH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:07:27 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEB4C061343
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:46 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id k19so440241qta.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IRY2JW0Z98EgQbSxHxMAz5C8JAIM2WaC06Y7zNJ3ts0=;
        b=boiyFkgbfwJ557d627q5so2dUiE6lq9T3OIPmL9hmxupf/IKh//+zJ11bd9/71UrxU
         4/yFmZxfMnQEIS+a9xTcY8K45N6bfu78nowipvRRn3DekJXFqP1bNQhrlM61+qnG+6U2
         ij8NwJJJetIorTETOnOtqLp31yYSpvkF86AW4MLlWyUbL695KiY8+ZwAQVj/imAl3lpi
         jPy1zngJ8iwtzSEbmLyKysfKzGJBbciUNcKPi6YPKb1SVC28YKAyeFtS3/mNd1WPrsxg
         iKZRAMuk4JrqoixsI49a7oYfLibiVjfBVjiN46k/FwAz4CfK7KMbflX0j9QOdzHCqkkt
         p4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IRY2JW0Z98EgQbSxHxMAz5C8JAIM2WaC06Y7zNJ3ts0=;
        b=sKIdaF34yc06swgjIAjHFe9Kk3pZLaHwJpHq/LyW/jszZ3x39BDpl3jBke+9YPkmq9
         FBbuPWLPRuZDglavg1HlavAkmpfaJkh5A9LC1X1OkYJc0/WUnXzvKyW8UPQ8s8IRjLlk
         AwoliQjd8g1/PXB/zDgY6PKEXihhLLDkQDUu3psuRyniFF+S3KYSvp7UAVGnKRT8UqY4
         IhYmYpGpJ3P8kTZeNvUODwsJHstXfg0SCFs/u2Wbc1elKAzqPkOEiYcdNmDDLqwXstk1
         TmjEQxt7rSfQZ7qdPr7mBbzO7MMkOvw2+zWAFqsA7xpd/ibH4fP+6T/DlUZZ/hdhs2t2
         PcGg==
X-Gm-Message-State: AOAM530ssAT+Rsgm+fkXCDqcWlPMIPxwFKl9uCxrCpHDSNNxGHxhUWWx
        xnyzJVfaFb0Ek6FA8Csk7u4anCotUGgpQ7Jz
X-Google-Smtp-Source: ABdhPJxvoayShnrBYhLGN1MUkwd1W/Ry1DebaPAbHABcNwTi2nuw66ZfhC1rl0DYvGfXedawKnn4vw==
X-Received: by 2002:a05:622a:28f:: with SMTP id z15mr3591511qtw.260.1622127945305;
        Thu, 27 May 2021 08:05:45 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id x10sm1447468qkh.124.2021.05.27.08.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:05:44 -0700 (PDT)
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
Subject: [PATCH 11/18] arm64: kexec: kexec may require EL2 vectors
Date:   Thu, 27 May 2021 11:05:19 -0400
Message-Id: <20210527150526.271941-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527150526.271941-1-pasha.tatashin@soleen.com>
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we have a EL2 mode without VHE, the EL2 vectors are needed in order
to switch to EL2 and jump to new world with hypervisor privileges.

In preporation to MMU enabled relocation, configure our EL2 table now.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/Kconfig                |  2 +-
 arch/arm64/include/asm/kexec.h    |  1 +
 arch/arm64/kernel/asm-offsets.c   |  1 +
 arch/arm64/kernel/machine_kexec.c | 31 +++++++++++++++++++++++++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9f1d8566bbf9..e775e6fb03c5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1148,7 +1148,7 @@ config CRASH_DUMP
 
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
index 92c2ed846730..ee37d0e0fb6d 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -159,6 +159,7 @@ int main(void)
 #endif
 #ifdef CONFIG_KEXEC_CORE
   DEFINE(KIMAGE_ARCH_DTB_MEM,		offsetof(struct kimage, arch.dtb_mem));
+  DEFINE(KIMAGE_ARCH_EL2_VECTORS,	offsetof(struct kimage, arch.el2_vectors));
   DEFINE(KIMAGE_HEAD,			offsetof(struct kimage, head));
   DEFINE(KIMAGE_START,			offsetof(struct kimage, start));
   BLANK();
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 76a757954a70..9f74791cb1d0 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -20,6 +20,7 @@
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/page.h>
+#include <asm/trans_pgd.h>
 
 #include "cpu-reset.h"
 
@@ -42,7 +43,9 @@ static void _kexec_image_info(const char *func, int line,
 	pr_debug("    start:       %lx\n", kimage->start);
 	pr_debug("    head:        %lx\n", kimage->head);
 	pr_debug("    nr_segments: %lu\n", kimage->nr_segments);
+	pr_debug("    dtb_mem: %pa\n", &kimage->arch.dtb_mem);
 	pr_debug("    kern_reloc: %pa\n", &kimage->arch.kern_reloc);
+	pr_debug("    el2_vectors: %pa\n", &kimage->arch.el2_vectors);
 
 	for (i = 0; i < kimage->nr_segments; i++) {
 		pr_debug("      segment[%lu]: %016lx - %016lx, 0x%lx bytes, %lu pages\n",
@@ -137,9 +140,27 @@ static void kexec_segment_flush(const struct kimage *kimage)
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
@@ -148,6 +169,14 @@ int machine_kexec_post_load(struct kimage *kimage)
 		return 0;
 	}
 
+	kimage->arch.el2_vectors = 0;
+	if (is_hyp_callable()) {
+		int rc = trans_pgd_copy_el2_vectors(&info,
+						    &kimage->arch.el2_vectors);
+		if (rc)
+			return rc;
+	}
+
 	memcpy(reloc_code, arm64_relocate_new_kernel,
 	       arm64_relocate_new_kernel_size);
 	kimage->arch.kern_reloc = __pa(reloc_code);
@@ -200,6 +229,8 @@ void machine_kexec(struct kimage *kimage)
 		restart(is_hyp_callable(), kimage->start, kimage->arch.dtb_mem,
 			0, 0);
 	} else {
+		if (is_hyp_callable())
+			__hyp_set_vectors(kimage->arch.el2_vectors);
 		cpu_soft_restart(kimage->arch.kern_reloc, virt_to_phys(kimage),
 				 0, 0);
 	}
-- 
2.25.1

