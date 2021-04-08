Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3BE357B17
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 06:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhDHEG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 00:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhDHEGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 00:06:05 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7C7C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 21:05:54 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id iu14so262168qvb.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 21:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SSVgN/Udo7O/9r5aLt7E06oIBMSmNcVup1eFBvvBBwQ=;
        b=W7mAMlhvgMQZA1u+YpBSTaa4U2PlAJoqUUKJLnnt92hGehD3XuH/up8FwYAQYvl2sg
         VA4MzjvZYDTmJc9ylxGHI507Po+vcc8YmZt7tyU4dCv+DCcECJTPoJsTgCFn4QYZ24w2
         siKERh3P/f71yG5Bel6jiapye65oFGsz7/yYDXuN38N9g9vNQ3Z7/FiCsqzJq9w9s7gU
         NE4cAbdyjAmBLaNyyl+kN9arrODHeJPnnkGmT+S2KQSKviXPpzO+kQ5wW7qcXjWPjt95
         xQBpkjftdwMpIfRUxcRQoiWji3IOD5GYTov/9U8UQAMpvKKxNvGN2xjnHfJlkY+Bcu/u
         Mumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SSVgN/Udo7O/9r5aLt7E06oIBMSmNcVup1eFBvvBBwQ=;
        b=MEoblVzP+h/mi/wyPXLzZn4+7y6zr4EX52eJfZkpNMhGsJTU6DAqxu0Uu6x+9MZgob
         yvuIu+yY6zafkqy1a1drb3wGzd68nnCYloxL89Dkn8rgkeY68ExT+KOjqnvkEpYc9Zxx
         ds7I2fnL+2aTyc3JDDfnwJZm9iDUo5FquJ4JeQGzsZB/FyAWFARDxW3B8k5seuisSs5M
         2sh5vgd+UC1R/k07RXmZhsm/dcRCyBmdRZ9+Odz8uatlUtV1Ce8n0m/GGuLU9zYlyL8b
         DSgeuhPo9lwDnGBLFJ/D98lEOBBB3S5lnNBIdw5EEX2rlsd6ym1SEHsYzGsNn1u7MGtD
         yPpw==
X-Gm-Message-State: AOAM5333cDKWHlYenPDX3MNj5jAvKkMPDSotHq6Tn2wzRtWu6grW8Kjb
        p3/sOZg8x/kjbnlLG65/kQhhlg==
X-Google-Smtp-Source: ABdhPJy2AuQlIlurSB61GRRFwjVYnlD1FVCWdmqAS1sn8VdIrau1gL7EH0PszcWgCc7MeQT7AcMizQ==
X-Received: by 2002:a0c:e84e:: with SMTP id l14mr7070045qvo.39.1617854753531;
        Wed, 07 Apr 2021 21:05:53 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 207sm18177874qkl.125.2021.04.07.21.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 21:05:53 -0700 (PDT)
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
Subject: [PATCH v13 11/18] arm64: kexec: kexec may require EL2 vectors
Date:   Thu,  8 Apr 2021 00:05:30 -0400
Message-Id: <20210408040537.2703241-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
References: <20210408040537.2703241-1-pasha.tatashin@soleen.com>
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
index e4e1b6550115..0e876d980a1f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1149,7 +1149,7 @@ config CRASH_DUMP
 
 config TRANS_TABLE
 	def_bool y
-	depends on HIBERNATION
+	depends on HIBERNATION || KEXEC_CORE
 
 config XEN_DOM0
 	def_bool y
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 9befcd87e9a8..305cf0840ed3 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -96,6 +96,7 @@ struct kimage_arch {
 	void *dtb;
 	phys_addr_t dtb_mem;
 	phys_addr_t kern_reloc;
+	phys_addr_t el2_vectors;
 	/* Core ELF header buffer */
 	void *elf_headers;
 	unsigned long elf_headers_mem;
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 0c92e193f866..2e3278df1fc3 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -157,6 +157,7 @@ int main(void)
 #endif
 #ifdef CONFIG_KEXEC_CORE
   DEFINE(KIMAGE_ARCH_DTB_MEM,		offsetof(struct kimage, arch.dtb_mem));
+  DEFINE(KIMAGE_ARCH_EL2_VECTORS,	offsetof(struct kimage, arch.el2_vectors));
   DEFINE(KIMAGE_HEAD,			offsetof(struct kimage, head));
   DEFINE(KIMAGE_START,			offsetof(struct kimage, start));
   BLANK();
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 2e734e4ae12e..fb03b6676fb9 100644
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

