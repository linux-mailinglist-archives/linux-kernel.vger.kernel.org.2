Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165FE42AE50
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbhJLU7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235219AbhJLU7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:59:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE9676109E;
        Tue, 12 Oct 2021 20:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634072259;
        bh=OvVGLTy+ALMROM7ItOlPKXMoj8E7XTKNv4jZ15+8Gaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JoLhb9gXT81DrAplQNsrgndtLb5NYX1MINzcwv4hJuGHaLeiDDYlCBYi677B2hN0V
         PVe/GKeK7SdHd6B8tLmj/9wZhZgc4NQmJyaIftEsYRks2d/cwstfxs0FvEpgk57k8y
         p9oWCX2OP2iMLg4yuD53tzpmy297vDH6z+aG3Qk7+P2yNUho8V8DISMhihUbyDxRfD
         hXIzk2PveyzWHoiJUEhZpqHIS3wtHNQKaNnv7p9JRDdqTztQg/ms8KYdqsZfh8o0n1
         FUIyVP4KRuWnX4Lu0Z30ePaLr0CPvYd5arD8oykeNMZ8q+hHf3RwaCCk6nTmhc1G+s
         cLOImDDIT07iA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] mm/damon: Implement primitives for physical address space monitoring
Date:   Tue, 12 Oct 2021 20:57:09 +0000
Message-Id: <20211012205711.29216-6-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211012205711.29216-1-sj@kernel.org>
References: <20211012205711.29216-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit implements the monitoring primitives for the physical memory
address space.  Internally, it uses the PTE Accessed bit, similar to
that of the virtual address spaces monitoring primitives.  It supports
only user memory pages, as idle pages tracking does.  If the monitoring
target physical memory address range contains non-user memory pages,
access check of the pages will do nothing but simply treat the pages as
not accessed.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  10 ++
 mm/damon/Kconfig      |   8 ++
 mm/damon/Makefile     |   1 +
 mm/damon/paddr.c      | 224 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 243 insertions(+)
 create mode 100644 mm/damon/paddr.c

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f301bb53381c..715dadd21f7c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -351,4 +351,14 @@ void damon_va_set_primitives(struct damon_ctx *ctx);
 
 #endif	/* CONFIG_DAMON_VADDR */
 
+#ifdef CONFIG_DAMON_PADDR
+
+/* Monitoring primitives for the physical memory address space */
+void damon_pa_prepare_access_checks(struct damon_ctx *ctx);
+unsigned int damon_pa_check_accesses(struct damon_ctx *ctx);
+bool damon_pa_target_valid(void *t);
+void damon_pa_set_primitives(struct damon_ctx *ctx);
+
+#endif	/* CONFIG_DAMON_PADDR */
+
 #endif	/* _DAMON_H */
diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index ba8898c7eb8e..2a5923be631e 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -32,6 +32,14 @@ config DAMON_VADDR
 	  This builds the default data access monitoring primitives for DAMON
 	  that work for virtual address spaces.
 
+config DAMON_PADDR
+	bool "Data access monitoring primitives for the physical address space"
+	depends on DAMON && MMU
+	select PAGE_IDLE_FLAG
+	help
+	  This builds the default data access monitoring primitives for DAMON
+	  that works for the physical address space.
+
 config DAMON_VADDR_KUNIT_TEST
 	bool "Test for DAMON primitives" if !KUNIT_ALL_TESTS
 	depends on DAMON_VADDR && KUNIT=y
diff --git a/mm/damon/Makefile b/mm/damon/Makefile
index 99b1bfe01ff5..8d9b0df79702 100644
--- a/mm/damon/Makefile
+++ b/mm/damon/Makefile
@@ -2,4 +2,5 @@
 
 obj-$(CONFIG_DAMON)		:= core.o
 obj-$(CONFIG_DAMON_VADDR)	+= prmtv-common.o vaddr.o
+obj-$(CONFIG_DAMON_PADDR)	+= prmtv-common.o paddr.o
 obj-$(CONFIG_DAMON_DBGFS)	+= dbgfs.o
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
new file mode 100644
index 000000000000..d7a2ecd09ed0
--- /dev/null
+++ b/mm/damon/paddr.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DAMON Primitives for The Physical Address Space
+ *
+ * Author: SeongJae Park <sj@kernel.org>
+ */
+
+#define pr_fmt(fmt) "damon-pa: " fmt
+
+#include <linux/mmu_notifier.h>
+#include <linux/page_idle.h>
+#include <linux/pagemap.h>
+#include <linux/rmap.h>
+
+#include "prmtv-common.h"
+
+static bool __damon_pa_mkold(struct page *page, struct vm_area_struct *vma,
+		unsigned long addr, void *arg)
+{
+	struct page_vma_mapped_walk pvmw = {
+		.page = page,
+		.vma = vma,
+		.address = addr,
+	};
+
+	while (page_vma_mapped_walk(&pvmw)) {
+		addr = pvmw.address;
+		if (pvmw.pte)
+			damon_ptep_mkold(pvmw.pte, vma->vm_mm, addr);
+		else
+			damon_pmdp_mkold(pvmw.pmd, vma->vm_mm, addr);
+	}
+	return true;
+}
+
+static void damon_pa_mkold(unsigned long paddr)
+{
+	struct page *page = damon_get_page(PHYS_PFN(paddr));
+	struct rmap_walk_control rwc = {
+		.rmap_one = __damon_pa_mkold,
+		.anon_lock = page_lock_anon_vma_read,
+	};
+	bool need_lock;
+
+	if (!page)
+		return;
+
+	if (!page_mapped(page) || !page_rmapping(page)) {
+		set_page_idle(page);
+		goto out;
+	}
+
+	need_lock = !PageAnon(page) || PageKsm(page);
+	if (need_lock && !trylock_page(page))
+		goto out;
+
+	rmap_walk(page, &rwc);
+
+	if (need_lock)
+		unlock_page(page);
+
+out:
+	put_page(page);
+}
+
+static void __damon_pa_prepare_access_check(struct damon_ctx *ctx,
+					    struct damon_region *r)
+{
+	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
+
+	damon_pa_mkold(r->sampling_addr);
+}
+
+void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region(r, t)
+			__damon_pa_prepare_access_check(ctx, r);
+	}
+}
+
+struct damon_pa_access_chk_result {
+	unsigned long page_sz;
+	bool accessed;
+};
+
+static bool __damon_pa_young(struct page *page, struct vm_area_struct *vma,
+		unsigned long addr, void *arg)
+{
+	struct damon_pa_access_chk_result *result = arg;
+	struct page_vma_mapped_walk pvmw = {
+		.page = page,
+		.vma = vma,
+		.address = addr,
+	};
+
+	result->accessed = false;
+	result->page_sz = PAGE_SIZE;
+	while (page_vma_mapped_walk(&pvmw)) {
+		addr = pvmw.address;
+		if (pvmw.pte) {
+			result->accessed = pte_young(*pvmw.pte) ||
+				!page_is_idle(page) ||
+				mmu_notifier_test_young(vma->vm_mm, addr);
+		} else {
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+			result->accessed = pmd_young(*pvmw.pmd) ||
+				!page_is_idle(page) ||
+				mmu_notifier_test_young(vma->vm_mm, addr);
+			result->page_sz = ((1UL) << HPAGE_PMD_SHIFT);
+#else
+			WARN_ON_ONCE(1);
+#endif	/* CONFIG_TRANSPARENT_HUGEPAGE */
+		}
+		if (result->accessed) {
+			page_vma_mapped_walk_done(&pvmw);
+			break;
+		}
+	}
+
+	/* If accessed, stop walking */
+	return !result->accessed;
+}
+
+static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
+{
+	struct page *page = damon_get_page(PHYS_PFN(paddr));
+	struct damon_pa_access_chk_result result = {
+		.page_sz = PAGE_SIZE,
+		.accessed = false,
+	};
+	struct rmap_walk_control rwc = {
+		.arg = &result,
+		.rmap_one = __damon_pa_young,
+		.anon_lock = page_lock_anon_vma_read,
+	};
+	bool need_lock;
+
+	if (!page)
+		return false;
+
+	if (!page_mapped(page) || !page_rmapping(page)) {
+		if (page_is_idle(page))
+			result.accessed = false;
+		else
+			result.accessed = true;
+		put_page(page);
+		goto out;
+	}
+
+	need_lock = !PageAnon(page) || PageKsm(page);
+	if (need_lock && !trylock_page(page)) {
+		put_page(page);
+		return NULL;
+	}
+
+	rmap_walk(page, &rwc);
+
+	if (need_lock)
+		unlock_page(page);
+	put_page(page);
+
+out:
+	*page_sz = result.page_sz;
+	return result.accessed;
+}
+
+static void __damon_pa_check_access(struct damon_ctx *ctx,
+				    struct damon_region *r)
+{
+	static unsigned long last_addr;
+	static unsigned long last_page_sz = PAGE_SIZE;
+	static bool last_accessed;
+
+	/* If the region is in the last checked page, reuse the result */
+	if (ALIGN_DOWN(last_addr, last_page_sz) ==
+				ALIGN_DOWN(r->sampling_addr, last_page_sz)) {
+		if (last_accessed)
+			r->nr_accesses++;
+		return;
+	}
+
+	last_accessed = damon_pa_young(r->sampling_addr, &last_page_sz);
+	if (last_accessed)
+		r->nr_accesses++;
+
+	last_addr = r->sampling_addr;
+}
+
+unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+	unsigned int max_nr_accesses = 0;
+
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region(r, t) {
+			__damon_pa_check_access(ctx, r);
+			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
+		}
+	}
+
+	return max_nr_accesses;
+}
+
+bool damon_pa_target_valid(void *t)
+{
+	return true;
+}
+
+void damon_pa_set_primitives(struct damon_ctx *ctx)
+{
+	ctx->primitive.init = NULL;
+	ctx->primitive.update = NULL;
+	ctx->primitive.prepare_access_checks = damon_pa_prepare_access_checks;
+	ctx->primitive.check_accesses = damon_pa_check_accesses;
+	ctx->primitive.reset_aggregated = NULL;
+	ctx->primitive.target_valid = damon_pa_target_valid;
+	ctx->primitive.cleanup = NULL;
+	ctx->primitive.apply_scheme = NULL;
+}
-- 
2.17.1

