Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC8D34194E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhCSKCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhCSKCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:02:17 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75F1C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:16 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id h5so21519185wrr.17
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 03:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JFVgQfdZR3t4wFPbw0y7EcWRf567Mo4BKDT6hmRzVw0=;
        b=uC4I+Adqywaa1+/YF9/p/jYvqaxZ8qWCIRedY8B78OhA0y/o1ywd+e1B6iOpldehhs
         z4Y135SUDFFc04025qo6D3o9sMCOa24gzfbXZOBPzIkZoMCJMJRRWcfwj3fQRN6JqH8q
         xE6RYZwuLWywGG/7G45xXBZDpugTGLZlmBj0Eegy+yMHT6fYnhx+aY0BaHHEx7KxzGPR
         yjgdSr3XJgUjrIvfX5l0HBtDDmq54TJZ1/nOOiKWX0p1QR21MgdF837LCecSGdcEdijc
         RYHjZeP7q31QhmmHJZ4x/UY4gxZhFB5pbCh0OnMqlrpvpDnFOV4++7h3BvMcQFOzUO5I
         +rFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JFVgQfdZR3t4wFPbw0y7EcWRf567Mo4BKDT6hmRzVw0=;
        b=p8X1+r/Z+olaklNnj8q6zM/+QMmUANZLfvrj8hGU0kAPTDXhw25/n7pyMxi5lmUN36
         p1A1jWwRTZT6WjnWaxGmnyR9F0T4sR8lMmo1qHqfq9dwznZW3VVbRlmrlim9NisTjHIS
         sSn6kvCxcEUtkqJP1BcHFWIS3Luamytbcqar7WuiHLAKodm9yBynA8WICNGAAsvVUw/C
         PN+a86euX3AP7G6xaXH8rNhEBXCQjXF0Q4fIlXKxqku4iS8h04spq80LA9Ieweehkl90
         BlOBIR3ZSbPt7x5EYs6RqNjIadjl412cdih+9Y5jPv+b2Lznr2jHQi6FtafOhoOMeW4/
         lMUg==
X-Gm-Message-State: AOAM530q11AMpMQIoFR9UJ25DWbGpQayCv0SP6iUtfYnJLts+1OfvzIm
        jXcD1Ximtjl/zDbymkkKLth8MKVaCCRJ
X-Google-Smtp-Source: ABdhPJw0Wg2RVgEUXpb1r4+Vch/mSQU4xORLnkKvgeh9Qe1yvdhUVnYvo241i0FCnsVTaXOHfqk9Y/Ulgfyg
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a1c:a958:: with SMTP id
 s85mr2901863wme.138.1616148135430; Fri, 19 Mar 2021 03:02:15 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:01:20 +0000
In-Reply-To: <20210319100146.1149909-1-qperret@google.com>
Message-Id: <20210319100146.1149909-13-qperret@google.com>
Mime-Version: 1.0
References: <20210319100146.1149909-1-qperret@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v6 12/38] KVM: arm64: Introduce a Hyp buddy page allocator
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When memory protection is enabled, the hyp code will require a basic
form of memory management in order to allocate and free memory pages at
EL2. This is needed for various use-cases, including the creation of hyp
mappings or the allocation of stage 2 page tables.

To address these use-case, introduce a simple memory allocator in the
hyp code. The allocator is designed as a conventional 'buddy allocator',
working with a page granularity. It allows to allocate and free
physically contiguous pages from memory 'pools', with a guaranteed order
alignment in the PA space. Each page in a memory pool is associated
with a struct hyp_page which holds the page's metadata, including its
refcount, as well as its current order, hence mimicking the kernel's
buddy system in the GFP infrastructure. The hyp_page metadata are made
accessible through a hyp_vmemmap, following the concept of
SPARSE_VMEMMAP in the kernel.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/gfp.h    |  68 ++++++++
 arch/arm64/kvm/hyp/include/nvhe/memory.h |  28 ++++
 arch/arm64/kvm/hyp/nvhe/Makefile         |   2 +-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c     | 195 +++++++++++++++++++++++
 4 files changed, 292 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/gfp.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/page_alloc.c

diff --git a/arch/arm64/kvm/hyp/include/nvhe/gfp.h b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
new file mode 100644
index 000000000000..55b3f0ce5bc8
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/gfp.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __KVM_HYP_GFP_H
+#define __KVM_HYP_GFP_H
+
+#include <linux/list.h>
+
+#include <nvhe/memory.h>
+#include <nvhe/spinlock.h>
+
+#define HYP_NO_ORDER	UINT_MAX
+
+struct hyp_pool {
+	/*
+	 * Spinlock protecting concurrent changes to the memory pool as well as
+	 * the struct hyp_page of the pool's pages until we have a proper atomic
+	 * API at EL2.
+	 */
+	hyp_spinlock_t lock;
+	struct list_head free_area[MAX_ORDER];
+	phys_addr_t range_start;
+	phys_addr_t range_end;
+	unsigned int max_order;
+};
+
+static inline void hyp_page_ref_inc(struct hyp_page *p)
+{
+	struct hyp_pool *pool = hyp_page_to_pool(p);
+
+	hyp_spin_lock(&pool->lock);
+	p->refcount++;
+	hyp_spin_unlock(&pool->lock);
+}
+
+static inline int hyp_page_ref_dec_and_test(struct hyp_page *p)
+{
+	struct hyp_pool *pool = hyp_page_to_pool(p);
+	int ret;
+
+	hyp_spin_lock(&pool->lock);
+	p->refcount--;
+	ret = (p->refcount == 0);
+	hyp_spin_unlock(&pool->lock);
+
+	return ret;
+}
+
+static inline void hyp_set_page_refcounted(struct hyp_page *p)
+{
+	struct hyp_pool *pool = hyp_page_to_pool(p);
+
+	hyp_spin_lock(&pool->lock);
+	if (p->refcount) {
+		hyp_spin_unlock(&pool->lock);
+		hyp_panic();
+	}
+	p->refcount = 1;
+	hyp_spin_unlock(&pool->lock);
+}
+
+/* Allocation */
+void *hyp_alloc_pages(struct hyp_pool *pool, unsigned int order);
+void hyp_get_page(void *addr);
+void hyp_put_page(void *addr);
+
+/* Used pages cannot be freed */
+int hyp_pool_init(struct hyp_pool *pool, u64 pfn, unsigned int nr_pages,
+		  unsigned int reserved_pages);
+#endif /* __KVM_HYP_GFP_H */
diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
index 3e49eaa7e682..d2fb307c5952 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
@@ -6,7 +6,17 @@
 
 #include <linux/types.h>
 
+struct hyp_pool;
+struct hyp_page {
+	unsigned int refcount;
+	unsigned int order;
+	struct hyp_pool *pool;
+	struct list_head node;
+};
+
 extern s64 hyp_physvirt_offset;
+extern u64 __hyp_vmemmap;
+#define hyp_vmemmap ((struct hyp_page *)__hyp_vmemmap)
 
 #define __hyp_pa(virt)	((phys_addr_t)(virt) + hyp_physvirt_offset)
 #define __hyp_va(phys)	((void *)((phys_addr_t)(phys) - hyp_physvirt_offset))
@@ -21,4 +31,22 @@ static inline phys_addr_t hyp_virt_to_phys(void *addr)
 	return __hyp_pa(addr);
 }
 
+#define hyp_phys_to_pfn(phys)	((phys) >> PAGE_SHIFT)
+#define hyp_pfn_to_phys(pfn)	((phys_addr_t)((pfn) << PAGE_SHIFT))
+#define hyp_phys_to_page(phys)	(&hyp_vmemmap[hyp_phys_to_pfn(phys)])
+#define hyp_virt_to_page(virt)	hyp_phys_to_page(__hyp_pa(virt))
+#define hyp_virt_to_pfn(virt)	hyp_phys_to_pfn(__hyp_pa(virt))
+
+#define hyp_page_to_pfn(page)	((struct hyp_page *)(page) - hyp_vmemmap)
+#define hyp_page_to_phys(page)  hyp_pfn_to_phys((hyp_page_to_pfn(page)))
+#define hyp_page_to_virt(page)	__hyp_va(hyp_page_to_phys(page))
+#define hyp_page_to_pool(page)	(((struct hyp_page *)page)->pool)
+
+static inline int hyp_page_count(void *addr)
+{
+	struct hyp_page *p = hyp_virt_to_page(addr);
+
+	return p->refcount;
+}
+
 #endif /* __KVM_HYP_MEMORY_H */
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 144da72ad510..6894a917f290 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -13,7 +13,7 @@ lib-objs := clear_page.o copy_page.o memcpy.o memset.o
 lib-objs := $(addprefix ../../../lib/, $(lib-objs))
 
 obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
-	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o stub.o
+	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o stub.o page_alloc.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o
 obj-y += $(lib-objs)
diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
new file mode 100644
index 000000000000..237e03bf0cb1
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 Google LLC
+ * Author: Quentin Perret <qperret@google.com>
+ */
+
+#include <asm/kvm_hyp.h>
+#include <nvhe/gfp.h>
+
+u64 __hyp_vmemmap;
+
+/*
+ * Index the hyp_vmemmap to find a potential buddy page, but make no assumption
+ * about its current state.
+ *
+ * Example buddy-tree for a 4-pages physically contiguous pool:
+ *
+ *                 o : Page 3
+ *                /
+ *               o-o : Page 2
+ *              /
+ *             /   o : Page 1
+ *            /   /
+ *           o---o-o : Page 0
+ *    Order  2   1 0
+ *
+ * Example of requests on this pool:
+ *   __find_buddy_nocheck(pool, page 0, order 0) => page 1
+ *   __find_buddy_nocheck(pool, page 0, order 1) => page 2
+ *   __find_buddy_nocheck(pool, page 1, order 0) => page 0
+ *   __find_buddy_nocheck(pool, page 2, order 0) => page 3
+ */
+static struct hyp_page *__find_buddy_nocheck(struct hyp_pool *pool,
+					     struct hyp_page *p,
+					     unsigned int order)
+{
+	phys_addr_t addr = hyp_page_to_phys(p);
+
+	addr ^= (PAGE_SIZE << order);
+
+	/*
+	 * Don't return a page outside the pool range -- it belongs to
+	 * something else and may not be mapped in hyp_vmemmap.
+	 */
+	if (addr < pool->range_start || addr >= pool->range_end)
+		return NULL;
+
+	return hyp_phys_to_page(addr);
+}
+
+/* Find a buddy page currently available for allocation */
+static struct hyp_page *__find_buddy_avail(struct hyp_pool *pool,
+					   struct hyp_page *p,
+					   unsigned int order)
+{
+	struct hyp_page *buddy = __find_buddy_nocheck(pool, p, order);
+
+	if (!buddy || buddy->order != order || list_empty(&buddy->node))
+		return NULL;
+
+	return buddy;
+
+}
+
+static void __hyp_attach_page(struct hyp_pool *pool,
+			      struct hyp_page *p)
+{
+	unsigned int order = p->order;
+	struct hyp_page *buddy;
+
+	memset(hyp_page_to_virt(p), 0, PAGE_SIZE << p->order);
+
+	/*
+	 * Only the first struct hyp_page of a high-order page (otherwise known
+	 * as the 'head') should have p->order set. The non-head pages should
+	 * have p->order = HYP_NO_ORDER. Here @p may no longer be the head
+	 * after coallescing, so make sure to mark it HYP_NO_ORDER proactively.
+	 */
+	p->order = HYP_NO_ORDER;
+	for (; (order + 1) < pool->max_order; order++) {
+		buddy = __find_buddy_avail(pool, p, order);
+		if (!buddy)
+			break;
+
+		/* Take the buddy out of its list, and coallesce with @p */
+		list_del_init(&buddy->node);
+		buddy->order = HYP_NO_ORDER;
+		p = min(p, buddy);
+	}
+
+	/* Mark the new head, and insert it */
+	p->order = order;
+	list_add_tail(&p->node, &pool->free_area[order]);
+}
+
+static void hyp_attach_page(struct hyp_page *p)
+{
+	struct hyp_pool *pool = hyp_page_to_pool(p);
+
+	hyp_spin_lock(&pool->lock);
+	__hyp_attach_page(pool, p);
+	hyp_spin_unlock(&pool->lock);
+}
+
+static struct hyp_page *__hyp_extract_page(struct hyp_pool *pool,
+					   struct hyp_page *p,
+					   unsigned int order)
+{
+	struct hyp_page *buddy;
+
+	list_del_init(&p->node);
+	while (p->order > order) {
+		/*
+		 * The buddy of order n - 1 currently has HYP_NO_ORDER as it
+		 * is covered by a higher-level page (whose head is @p). Use
+		 * __find_buddy_nocheck() to find it and inject it in the
+		 * free_list[n - 1], effectively splitting @p in half.
+		 */
+		p->order--;
+		buddy = __find_buddy_nocheck(pool, p, p->order);
+		buddy->order = p->order;
+		list_add_tail(&buddy->node, &pool->free_area[buddy->order]);
+	}
+
+	return p;
+}
+
+void hyp_put_page(void *addr)
+{
+	struct hyp_page *p = hyp_virt_to_page(addr);
+
+	if (hyp_page_ref_dec_and_test(p))
+		hyp_attach_page(p);
+}
+
+void hyp_get_page(void *addr)
+{
+	struct hyp_page *p = hyp_virt_to_page(addr);
+
+	hyp_page_ref_inc(p);
+}
+
+void *hyp_alloc_pages(struct hyp_pool *pool, unsigned int order)
+{
+	unsigned int i = order;
+	struct hyp_page *p;
+
+	hyp_spin_lock(&pool->lock);
+
+	/* Look for a high-enough-order page */
+	while (i < pool->max_order && list_empty(&pool->free_area[i]))
+		i++;
+	if (i >= pool->max_order) {
+		hyp_spin_unlock(&pool->lock);
+		return NULL;
+	}
+
+	/* Extract it from the tree at the right order */
+	p = list_first_entry(&pool->free_area[i], struct hyp_page, node);
+	p = __hyp_extract_page(pool, p, order);
+
+	hyp_spin_unlock(&pool->lock);
+	hyp_set_page_refcounted(p);
+
+	return hyp_page_to_virt(p);
+}
+
+int hyp_pool_init(struct hyp_pool *pool, u64 pfn, unsigned int nr_pages,
+		  unsigned int reserved_pages)
+{
+	phys_addr_t phys = hyp_pfn_to_phys(pfn);
+	struct hyp_page *p;
+	int i;
+
+	hyp_spin_lock_init(&pool->lock);
+	pool->max_order = min(MAX_ORDER, get_order(nr_pages << PAGE_SHIFT));
+	for (i = 0; i < pool->max_order; i++)
+		INIT_LIST_HEAD(&pool->free_area[i]);
+	pool->range_start = phys;
+	pool->range_end = phys + (nr_pages << PAGE_SHIFT);
+
+	/* Init the vmemmap portion */
+	p = hyp_phys_to_page(phys);
+	memset(p, 0, sizeof(*p) * nr_pages);
+	for (i = 0; i < nr_pages; i++) {
+		p[i].pool = pool;
+		INIT_LIST_HEAD(&p[i].node);
+	}
+
+	/* Attach the unused pages to the buddy tree */
+	for (i = reserved_pages; i < nr_pages; i++)
+		__hyp_attach_page(pool, &p[i]);
+
+	return 0;
+}
-- 
2.31.0.rc2.261.g7f71774620-goog

