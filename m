Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8776D4066C0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 07:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhIJFbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 01:31:31 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9026 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbhIJFbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 01:31:25 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H5PZ557rKzVr2T;
        Fri, 10 Sep 2021 13:29:17 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 10 Sep 2021 13:30:11 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 10 Sep 2021 13:30:11 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <will@kernel.org>, <catalin.marinas@arm.com>,
        <ryabinin.a.a@gmail.com>, <andreyknvl@gmail.com>,
        <dvyukov@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <elver@google.com>, <akpm@linux-foundation.org>,
        <gregkh@linuxfoundation.org>
CC:     <kasan-dev@googlegroups.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v4 2/3] arm64: Support page mapping percpu first chunk allocator
Date:   Fri, 10 Sep 2021 13:33:53 +0800
Message-ID: <20210910053354.26721-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210910053354.26721-1-wangkefeng.wang@huawei.com>
References: <20210910053354.26721-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Percpu embedded first chunk allocator is the firstly option, but it
could fails on ARM64, eg,
  "percpu: max_distance=0x5fcfdc640000 too large for vmalloc space 0x781fefff0000"
  "percpu: max_distance=0x600000540000 too large for vmalloc space 0x7dffb7ff0000"
  "percpu: max_distance=0x5fff9adb0000 too large for vmalloc space 0x5dffb7ff0000"

then we could meet "WARNING: CPU: 15 PID: 461 at vmalloc.c:3087 pcpu_get_vm_areas+0x488/0x838",
even the system could not boot successfully.

Let's implement page mapping percpu first chunk allocator as a fallback
to the embedding allocator to increase the robustness of the system.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/Kconfig       |  4 ++
 drivers/base/arch_numa.c | 82 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 077f2ec4eeb2..04cfe1b4e98b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1042,6 +1042,10 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
 	def_bool y
 	depends on NUMA
 
+config NEED_PER_CPU_PAGE_FIRST_CHUNK
+	def_bool y
+	depends on NUMA
+
 source "kernel/Kconfig.hz"
 
 config ARCH_SPARSEMEM_ENABLE
diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 46c503486e96..995dca9f3254 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 
 #include <asm/sections.h>
+#include <asm/pgalloc.h>
 
 struct pglist_data *node_data[MAX_NUMNODES] __read_mostly;
 EXPORT_SYMBOL(node_data);
@@ -168,22 +169,83 @@ static void __init pcpu_fc_free(void *ptr, size_t size)
 	memblock_free_early(__pa(ptr), size);
 }
 
+#ifdef CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK
+static void __init pcpu_populate_pte(unsigned long addr)
+{
+	pgd_t *pgd = pgd_offset_k(addr);
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(*p4d)) {
+		pud_t *new;
+
+		new = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+		if (!new)
+			goto err_alloc;
+		p4d_populate(&init_mm, p4d, new);
+	}
+
+	pud = pud_offset(p4d, addr);
+	if (pud_none(*pud)) {
+		pmd_t *new;
+
+		new = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+		if (!new)
+			goto err_alloc;
+		pud_populate(&init_mm, pud, new);
+	}
+
+	pmd = pmd_offset(pud, addr);
+	if (!pmd_present(*pmd)) {
+		pte_t *new;
+
+		new = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+		if (!new)
+			goto err_alloc;
+		pmd_populate_kernel(&init_mm, pmd, new);
+	}
+
+	return;
+
+err_alloc:
+	panic("%s: Failed to allocate %lu bytes align=%lx from=%lx\n",
+	      __func__, PAGE_SIZE, PAGE_SIZE, PAGE_SIZE);
+}
+#endif
+
 void __init setup_per_cpu_areas(void)
 {
 	unsigned long delta;
 	unsigned int cpu;
-	int rc;
+	int rc = -EINVAL;
+
+	if (pcpu_chosen_fc != PCPU_FC_PAGE) {
+		/*
+		 * Always reserve area for module percpu variables.  That's
+		 * what the legacy allocator did.
+		 */
+		rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
+					    PERCPU_DYNAMIC_RESERVE, PAGE_SIZE,
+					    pcpu_cpu_distance,
+					    pcpu_fc_alloc, pcpu_fc_free);
+#ifdef CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK
+		if (rc < 0)
+			pr_warn("PERCPU: %s allocator failed (%d), falling back to page size\n",
+				   pcpu_fc_names[pcpu_chosen_fc], rc);
+#endif
+	}
 
-	/*
-	 * Always reserve area for module percpu variables.  That's
-	 * what the legacy allocator did.
-	 */
-	rc = pcpu_embed_first_chunk(PERCPU_MODULE_RESERVE,
-				    PERCPU_DYNAMIC_RESERVE, PAGE_SIZE,
-				    pcpu_cpu_distance,
-				    pcpu_fc_alloc, pcpu_fc_free);
+#ifdef CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK
+	if (rc < 0)
+		rc = pcpu_page_first_chunk(PERCPU_MODULE_RESERVE,
+					   pcpu_fc_alloc,
+					   pcpu_fc_free,
+					   pcpu_populate_pte);
+#endif
 	if (rc < 0)
-		panic("Failed to initialize percpu areas.");
+		panic("Failed to initialize percpu areas (err=%d).", rc);
 
 	delta = (unsigned long)pcpu_base_addr - (unsigned long)__per_cpu_start;
 	for_each_possible_cpu(cpu)
-- 
2.26.2

