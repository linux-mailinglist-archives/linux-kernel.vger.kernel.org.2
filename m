Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14EE4066C1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 07:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhIJFbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 01:31:33 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15403 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhIJFbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 01:31:25 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H5PVV0SBnzR2TJ;
        Fri, 10 Sep 2021 13:26:10 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 10 Sep 2021 13:30:12 +0800
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
Subject: [PATCH v4 3/3] kasan: arm64: Fix pcpu_page_first_chunk crash with KASAN_VMALLOC
Date:   Fri, 10 Sep 2021 13:33:54 +0800
Message-ID: <20210910053354.26721-4-wangkefeng.wang@huawei.com>
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

With KASAN_VMALLOC and NEED_PER_CPU_PAGE_FIRST_CHUNK, it crashs,

Unable to handle kernel paging request at virtual address ffff7000028f2000
...
swapper pgtable: 64k pages, 48-bit VAs, pgdp=0000000042440000
[ffff7000028f2000] pgd=000000063e7c0003, p4d=000000063e7c0003, pud=000000063e7c0003, pmd=000000063e7b0003, pte=0000000000000000
Internal error: Oops: 96000007 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 5.13.0-rc4-00003-gc6e6e28f3f30-dirty #62
Hardware name: linux,dummy-virt (DT)
pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO BTYPE=--)
pc : kasan_check_range+0x90/0x1a0
lr : memcpy+0x88/0xf4
sp : ffff80001378fe20
...
Call trace:
 kasan_check_range+0x90/0x1a0
 pcpu_page_first_chunk+0x3f0/0x568
 setup_per_cpu_areas+0xb8/0x184
 start_kernel+0x8c/0x328

The vm area used in vm_area_register_early() has no kasan shadow memory,
Let's add a new kasan_populate_early_vm_area_shadow() function to populate
the vm area shadow memory to fix the issue.

Acked-by: Marco Elver <elver@google.com> (for KASAN parts)
Acked-by: Andrey Konovalov <andreyknvl@gmail.com> (for KASAN parts)
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/mm/kasan_init.c | 16 ++++++++++++++++
 include/linux/kasan.h      |  6 ++++++
 mm/kasan/init.c            |  5 +++++
 mm/vmalloc.c               |  1 +
 4 files changed, 28 insertions(+)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 61b52a92b8b6..5b996ca4d996 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -287,6 +287,22 @@ static void __init kasan_init_depth(void)
 	init_task.kasan_depth = 0;
 }
 
+#ifdef CONFIG_KASAN_VMALLOC
+void __init kasan_populate_early_vm_area_shadow(void *start, unsigned long size)
+{
+	unsigned long shadow_start, shadow_end;
+
+	if (!is_vmalloc_or_module_addr(start))
+		return;
+
+	shadow_start = (unsigned long)kasan_mem_to_shadow(start);
+	shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
+	shadow_end = (unsigned long)kasan_mem_to_shadow(start + size);
+	shadow_end = ALIGN(shadow_end, PAGE_SIZE);
+	kasan_map_populate(shadow_start, shadow_end, NUMA_NO_NODE);
+}
+#endif
+
 void __init kasan_init(void)
 {
 	kasan_init_shadow();
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index dd874a1ee862..859f1e724ee1 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -434,6 +434,8 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 			   unsigned long free_region_start,
 			   unsigned long free_region_end);
 
+void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
+
 #else /* CONFIG_KASAN_VMALLOC */
 
 static inline int kasan_populate_vmalloc(unsigned long start,
@@ -451,6 +453,10 @@ static inline void kasan_release_vmalloc(unsigned long start,
 					 unsigned long free_region_start,
 					 unsigned long free_region_end) {}
 
+static inline void kasan_populate_early_vm_area_shadow(void *start,
+						       unsigned long size)
+{ }
+
 #endif /* CONFIG_KASAN_VMALLOC */
 
 #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index cc64ed6858c6..d39577d088a1 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -279,6 +279,11 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 	return 0;
 }
 
+void __init __weak kasan_populate_early_vm_area_shadow(void *start,
+						       unsigned long size)
+{
+}
+
 static void kasan_free_pte(pte_t *pte_start, pmd_t *pmd)
 {
 	pte_t *pte;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5ee3cbeffa26..4cb494447910 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2287,6 +2287,7 @@ void __init vm_area_register_early(struct vm_struct *vm, size_t align)
 	vm->addr = (void *)addr;
 	vm->next = *p;
 	*p = vm;
+	kasan_populate_early_vm_area_shadow(vm->addr, vm->size);
 }
 
 static void vmap_init_free_space(void)
-- 
2.26.2

