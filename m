Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E4E32B73A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442769AbhCCKvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238025AbhCCA0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 19:26:20 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B74EC0611C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 16:22:48 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id s15so16291553qtq.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 16:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CkOHd4Ubs6QxUZPpaIRvKfllHz4QaZDE7Cb9NwMEurE=;
        b=kv+djcD5Dn8tl5qEcKKg9wUfgrKRtIeHMDiyEGXGQs7F/ZmuhWe//JnMzxmKu3F7AH
         88SbhKfkE78CfHCAU44Ln2BV0iQYNwXNNODQZqJTwJvNp3lruyG1V2IxzYqcxJbNeIZ6
         girfcwSI1nPDGrreCNMXLSEJQko02mF+3Yihp7JjLbeVQdjBz1rF1xU7FCCpI1MADl1I
         pOeZtuW+wh2ejaP/7dgGE0DRh69BVBAUaJ+0RDEenZ88YSFdaBOLm7hTX3jYfk39tjpV
         9gPTcFqCKqbCgpdfet/cTN4tW9o3BcjhJkKgOcD4wkV5+2WV0S3t0adzPBj5dTCa3CUU
         saSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CkOHd4Ubs6QxUZPpaIRvKfllHz4QaZDE7Cb9NwMEurE=;
        b=JdtBv1OoG/mdYLAzd+qAMaoZVXABOrmFeqOkBMIkhMTMQpfSYcRDgBK2cjQDYBhSuB
         p6gWNbc/kQEyEU7KDS840tPCOpO/CxCag1TgM+C50gDkSIP+kAHBTnQRWYfgBEeQM1AU
         PpBZDCKY80KtEjqvL5M+xopNqnRy4hqpZLwNWFMI2xpZfNfe0lnZYkerzCATqDMtaN06
         S2mFFbuU8WBjMRku4qvQhQ2REMQi1IpeHsmyaQ4/q6YD11/KrF7uPW6JEf3E6WJBeuUd
         zWaM0gZXl9KWqCKNiXlltllq/K9p2uBe9sjZ8UtCgXstzWQHbstQOSzhdFnhvz5H6V2W
         9GLw==
X-Gm-Message-State: AOAM532bTFPNQqmndP4nbxx4h0TBT3dx4n++mTInMbq7SB03uCrXbO8g
        6zg5AAhjCf/7eqpys0lPpOhSEQ==
X-Google-Smtp-Source: ABdhPJzh2Sttz/3luOleODmtp3yKBF23rhlq0H6VUfZnw3KEBQCZesiL+EeFQlA4puGBiExt3HvrBQ==
X-Received: by 2002:ac8:5947:: with SMTP id 7mr8369297qtz.60.1614730967312;
        Tue, 02 Mar 2021 16:22:47 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id r3sm16690512qkm.129.2021.03.02.16.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 16:22:46 -0800 (PST)
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
Subject: [PATCH v12 11/17] arm64: kexec: kexec may require EL2 vectors
Date:   Tue,  2 Mar 2021 19:22:24 -0500
Message-Id: <20210303002230.1083176-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
References: <20210303002230.1083176-1-pasha.tatashin@soleen.com>
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
index 1f212b47a48a..825fe88b7c08 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1141,7 +1141,7 @@ config CRASH_DUMP
 
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

