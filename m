Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5403A0893
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 02:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbhFIArj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 20:47:39 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:40892 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbhFIArf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:47:35 -0400
Received: by mail-qk1-f175.google.com with SMTP id u30so22139517qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 17:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Emy7G3R4fnJJtixbqFliehFPYNk4E7oq380r2UBbUTg=;
        b=YWf0syBZsse8lc/mMTj8DS7PSWN6ra8Xukco5XvSlESCykwl9Vkz4Uhy+rJytLdhAX
         TsfbCvx+Qf07PG/0Nr25bGgkrY3oUZes58zRrhN1Egyp74h+zKriKvWT1P6QSrpX+Wt9
         cCdqQO+3Vu7ZYgpsC50bbrc5Rn8qYOJjeXvu9QlRVsdn/c2iKRfEv94sjnD8Xilu3CJT
         RIq41RR+cG5Ut8+fzsX1EESUsk8azmnL5AP/DU13BpRy+qv0Mbkco1NhZp5rQX7dYAwj
         uNPidK7FC8OKN0FBEDUi21YhTZMTNrCelEmFBGTuhg+kU3YNeDwuVf+h4p8QIuNwo817
         HKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Emy7G3R4fnJJtixbqFliehFPYNk4E7oq380r2UBbUTg=;
        b=P8XqDvj2Bbo7vxbutGXhliTgap4TEYoR1rrR2M4WnZBXZQDkJKDt+FUg7npoYTlfxE
         +ZhJxx/9xYLivdLSIuPahL1TlcxHbArmhSJiq0x2ofApwYZwgxAKLthK5apBeW156i2z
         a3Xf+8LoYzvBX2pTA/46A+3T8qW40u+t4OdqUg8pY/GR67TiWHb3fLm6sOgirR9cD96X
         1b6I9wvjcYZUlMq3G8k8LAGveEKsBaLlslShd60htHNmCk4uCJv5JLVQMwjKQEBSSN54
         OEOEJn8bad1qqaC5e2XShCjv8pQnNupIQfAabQnzj7n6zKyyxTMrfO2+/UIxI/uof/tJ
         w0yA==
X-Gm-Message-State: AOAM532pm+TzIIAqMIoZXb8VUIfsmHKSvLOJXY3FnUCZ4itZejy++6av
        rjntyWPNnwjXvrWhOSVcOpnjgw==
X-Google-Smtp-Source: ABdhPJzmM3elcFvZ3NQoPrFQ0alk3E3chSyV6enV46/ICZNwkelqZouWMSAEtqgxxJQAPybADdxVXg==
X-Received: by 2002:a37:2ec1:: with SMTP id u184mr2736258qkh.500.1623199473091;
        Tue, 08 Jun 2021 17:44:33 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id n194sm12869011qka.66.2021.06.08.17.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 17:44:32 -0700 (PDT)
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
Subject: [PATCH v15 08/15] arm64: kexec: configure EL2 vectors for kexec
Date:   Tue,  8 Jun 2021 20:44:12 -0400
Message-Id: <20210609004419.936873-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609004419.936873-1-pasha.tatashin@soleen.com>
References: <20210609004419.936873-1-pasha.tatashin@soleen.com>
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
index e88d5cfbef40..e0ef88cc57d2 100644
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
@@ -200,6 +229,8 @@ void machine_kexec(struct kimage *kimage)
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

