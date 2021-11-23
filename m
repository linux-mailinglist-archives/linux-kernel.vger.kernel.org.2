Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDDC45AEAB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 22:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239091AbhKWVv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 16:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238458AbhKWVv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 16:51:29 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8949CC061748
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 13:48:20 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id b11so283011qvm.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 13:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jiAKDQYxxJ+CSsXDcxm3MFImsYIzyMDrhrMJtZRrSNY=;
        b=bRs66SlzURHc1dm9GNchHhmZDcGj1ii6Lmw+kxlwWBizKVGOEXqpo1PC6kHomCEtHA
         CQocdGHGLFgiKrTnJwvqN9nxc6+poAD/hcpJ3hHsRtTbUW4ZnQs8Ve8hGjqvqIPX8KGA
         rvK3VciemZwumVfxCxtNTWe2hiib9I8y/xWoBFu+tzzpc+U303trtNjctxTulRNpijzd
         lIpiVGG4vc+JGlOYsLcNmv2fZTTS3i+fxIRNRqadggT7Fk0bWFHhC9Sbuc9NyrLgMJ9A
         nn5NCUPzDG/JGqE3ZPaF80jcZkBAMFN3iicPR2Rxd0YHOIcFtEVNwro9uJBkDs1MkN9g
         u93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jiAKDQYxxJ+CSsXDcxm3MFImsYIzyMDrhrMJtZRrSNY=;
        b=nh3sd3zrpwHjEA9qovO0CbckRZ1k1rVD51aIaxZ4zuf65kv73EKOLhPF1+JObl44Nc
         dIuMx2m3mFY4yFC1JR1yG9WIP+oR+9r/dC2/vv2r6vlNi1PrVI6d5EsQ8kI1QJGcXnnZ
         iMQFtaRB09OJ04P4eb6Uu1q8b9xEL5wE+LPUNWloDLz2WBg/5B9zqlaWsodNMVP9V8Rq
         NtYTQw++SOpgpTn6JZP2in881SNzJKQvFl4B4gqm8zJVr7E+OIbzZVl/ls2KVksgcHZ9
         sMbVwxseY/V3Ou/qGiUypwGnjnklne55ggLdeYNLE1PRK/G3/kCVC0NEJAvXeM+vkDz3
         PWmA==
X-Gm-Message-State: AOAM530diX5Ul7BU/lEyZNM/CN36mNuB7aRRwWR+WAnhtmntp11Lnib9
        EjuwBnLKN4cHyyYGSXQD0MWI+w==
X-Google-Smtp-Source: ABdhPJzfO6X7RmI6pvFKjtOaC3aDxJ/J/XeibTEBtHJwSCO9gAKQf918S0J397xYU7rlugNgWE3Etw==
X-Received: by 2002:a05:6214:246f:: with SMTP id im15mr553204qvb.21.1637704099627;
        Tue, 23 Nov 2021 13:48:19 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id i11sm7356912qko.116.2021.11.23.13.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 13:48:19 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, rientjes@google.com, pjt@google.com,
        weixugc@google.com, gthelen@google.com, mingo@redhat.com,
        corbet@lwn.net, will@kernel.org, rppt@kernel.org,
        keescook@chromium.org, tglx@linutronix.de, peterz@infradead.org,
        masahiroy@kernel.org, samitolvanen@google.com,
        dave.hansen@linux.intel.com, x86@kernel.org, frederic@kernel.org,
        hpa@zytor.com, aneesh.kumar@linux.ibm.com
Subject: [PATCH 2/3] mm: page table check
Date:   Tue, 23 Nov 2021 21:48:13 +0000
Message-Id: <20211123214814.3756047-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
In-Reply-To: <20211123214814.3756047-1-pasha.tatashin@soleen.com>
References: <20211123214814.3756047-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check user page table entries at the time they are added and removed.

Allows to synchronously catch memory corruption issues related to
double mapping.

When a pte for an anonymous page is added into page table, we verify
that this pte does not already point to a file backed page, and vice
versa if this is a file backed page that is being added we verify that
this page does not have an anonymous mapping

We also enforce that read-only sharing for anonymous pages is allowed
(i.e. cow after fork). All other sharing must be for file pages.

Page table check allows to protect and debug cases where "struct page"
metadata became corrupted for some reason. For example, when refcnt or
mapcount become invalid.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/vm/index.rst            |   1 +
 Documentation/vm/page_table_check.rst |  56 ++++++
 MAINTAINERS                           |   9 +
 arch/Kconfig                          |   3 +
 include/linux/page_table_check.h      | 147 +++++++++++++++
 mm/Kconfig.debug                      |  24 +++
 mm/Makefile                           |   1 +
 mm/page_alloc.c                       |   4 +
 mm/page_ext.c                         |   4 +
 mm/page_table_check.c                 | 261 ++++++++++++++++++++++++++
 10 files changed, 510 insertions(+)
 create mode 100644 Documentation/vm/page_table_check.rst
 create mode 100644 include/linux/page_table_check.h
 create mode 100644 mm/page_table_check.c

diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
index 6f5ffef4b716..43bb54d897d9 100644
--- a/Documentation/vm/index.rst
+++ b/Documentation/vm/index.rst
@@ -31,6 +31,7 @@ algorithms.  If you are looking for advice on simply allocating memory, see the
    page_migration
    page_frags
    page_owner
+   page_table_check
    remap_file_pages
    slub
    split_page_table_lock
diff --git a/Documentation/vm/page_table_check.rst b/Documentation/vm/page_table_check.rst
new file mode 100644
index 000000000000..51d2e273d345
--- /dev/null
+++ b/Documentation/vm/page_table_check.rst
@@ -0,0 +1,56 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _page_table_check:
+
+================
+Page Table Check
+================
+
+Introduction
+============
+
+Page table check allows to hardern the kernel by ensuring that some types of
+the memory corruptions are prevented.
+
+Page table check performs extra verifications at the time when new pages become
+accessible from the userspace by getting their page table entries (PTEs PMDs
+etc.) added into the table.
+
+In case of detected corruption, the kernel is crashed. There is a small
+performance and memory overhead associated with the page table check. Therefore,
+it is disabled by default, but can be optionally be enabled on systems where
+the extra hardening outweighs the performance costs. Also, because page table
+check is synchronous, it can help with debugging double map memory corruption
+issues, by crashing kernel at the time wrong mapping occurs instead of later
+which is often the case with memory corruptions bugs.
+
+Double mapping detection logic
+==============================
+
++-------------------+-------------------+-------------------+------------------+
+| Current Mapping   | New mapping       | Permissions       | Rule             |
++===================+===================+===================+==================+
+| Anonymous         | Anonymous         | Read              | Allow            |
++-------------------+-------------------+-------------------+------------------+
+| Anonymous         | Anonymous         | Read / Write      | Prohibit         |
++-------------------+-------------------+-------------------+------------------+
+| Anonymous         | Named             | Any               | Prohibit         |
++-------------------+-------------------+-------------------+------------------+
+| Named             | Anonymous         | Any               | Prohibit         |
++-------------------+-------------------+-------------------+------------------+
+| Named             | Named             | Any               | Allow            |
++-------------------+-------------------+-------------------+------------------+
+
+Enabling Page Table Check
+=========================
+
+Build kernel with:
+
+- PAGE_TABLE_CHECK=y
+  Note, it can only be enabled on platforms where ARCH_SUPPORTS_PAGE_TABLE_CHECK
+  is available.
+
+- Boot with 'page_table_check=on' kernel parameter.
+
+Optionally, build kernel with PAGE_TABLE_CHECK_ENFORCED in order to have page
+table support without extra kernel parameter.
diff --git a/MAINTAINERS b/MAINTAINERS
index ab0d25f01ee3..69cc753799d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14421,6 +14421,15 @@ F:	include/net/page_pool.h
 F:	include/trace/events/page_pool.h
 F:	net/core/page_pool.c
 
+PAGE TABLE CHECK
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+M:	Andrew Morton <akpm@linux-foundation.org>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	Documentation/vm/page_table_check.rst
+F:	include/linux/page_table_check.h
+F:	mm/page_table_check.c
+
 PANASONIC LAPTOP ACPI EXTRAS DRIVER
 M:	Kenneth Chan <kenneth.t.chan@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/arch/Kconfig b/arch/Kconfig
index 26b8ed11639d..c5b03b3bd62d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1287,6 +1287,9 @@ config HAVE_ARCH_PFN_VALID
 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	bool
 
+config ARCH_SUPPORTS_PAGE_TABLE_CHECK
+	bool
+
 config ARCH_SPLIT_ARG64
 	bool
 	help
diff --git a/include/linux/page_table_check.h b/include/linux/page_table_check.h
new file mode 100644
index 000000000000..38cace1da7b6
--- /dev/null
+++ b/include/linux/page_table_check.h
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2021, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+#ifndef __LINUX_PAGE_TABLE_CHECK_H
+#define __LINUX_PAGE_TABLE_CHECK_H
+
+#ifdef CONFIG_PAGE_TABLE_CHECK
+#include <linux/jump_label.h>
+
+extern struct static_key_true page_table_check_disabled;
+extern struct page_ext_operations page_table_check_ops;
+
+void __page_table_check_zero(struct page *page, unsigned int order);
+void __page_table_check_pte_clear(struct mm_struct *mm, unsigned long addr,
+				  pte_t pte);
+void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
+				  pmd_t pmd);
+void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
+				  pud_t pud);
+void __page_table_check_pte_set(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, pte_t pte);
+void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
+				pmd_t *pmdp, pmd_t pmd);
+void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
+				pud_t *pudp, pud_t pud);
+
+static inline void page_table_check_alloc(struct page *page, unsigned int order)
+{
+	if (static_branch_likely(&page_table_check_disabled))
+		return;
+
+	__page_table_check_zero(page, order);
+}
+
+static inline void page_table_check_free(struct page *page, unsigned int order)
+{
+	if (static_branch_likely(&page_table_check_disabled))
+		return;
+
+	__page_table_check_zero(page, order);
+}
+
+static inline void page_table_check_pte_clear(struct mm_struct *mm,
+					      unsigned long addr, pte_t pte)
+{
+	if (static_branch_likely(&page_table_check_disabled))
+		return;
+
+	__page_table_check_pte_clear(mm, addr, pte);
+}
+
+static inline void page_table_check_pmd_clear(struct mm_struct *mm,
+					      unsigned long addr, pmd_t pmd)
+{
+	if (static_branch_likely(&page_table_check_disabled))
+		return;
+
+	__page_table_check_pmd_clear(mm, addr, pmd);
+}
+
+static inline void page_table_check_pud_clear(struct mm_struct *mm,
+					      unsigned long addr, pud_t pud)
+{
+	if (static_branch_likely(&page_table_check_disabled))
+		return;
+
+	__page_table_check_pud_clear(mm, addr, pud);
+}
+
+static inline void page_table_check_pte_set(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep,
+					    pte_t pte)
+{
+	if (static_branch_likely(&page_table_check_disabled))
+		return;
+
+	__page_table_check_pte_set(mm, addr, ptep, pte);
+}
+
+static inline void page_table_check_pmd_set(struct mm_struct *mm,
+					    unsigned long addr, pmd_t *pmdp,
+					    pmd_t pmd)
+{
+	if (static_branch_likely(&page_table_check_disabled))
+		return;
+
+	__page_table_check_pmd_set(mm, addr, pmdp, pmd);
+}
+
+static inline void page_table_check_pud_set(struct mm_struct *mm,
+					    unsigned long addr, pud_t *pudp,
+					    pud_t pud)
+{
+	if (static_branch_likely(&page_table_check_disabled))
+		return;
+
+	__page_table_check_pud_set(mm, addr, pudp, pud);
+}
+
+#else
+
+static inline void page_table_check_alloc(struct page *page, unsigned int order)
+{
+}
+
+static inline void page_table_check_free(struct page *page, unsigned int order)
+{
+}
+
+static inline void page_table_check_pte_clear(struct mm_struct *mm,
+					      unsigned long addr, pte_t pte)
+{
+}
+
+static inline void page_table_check_pmd_clear(struct mm_struct *mm,
+					      unsigned long addr, pmd_t pmd)
+{
+}
+
+static inline void page_table_check_pud_clear(struct mm_struct *mm,
+					      unsigned long addr, pud_t pud)
+{
+}
+
+static inline void page_table_check_pte_set(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep,
+					    pte_t pte)
+{
+}
+
+static inline void page_table_check_pmd_set(struct mm_struct *mm,
+					    unsigned long addr, pmd_t *pmdp,
+					    pmd_t pmd)
+{
+}
+
+static inline void page_table_check_pud_set(struct mm_struct *mm,
+					    unsigned long addr, pud_t *pudp,
+					    pud_t pud)
+{
+}
+
+#endif /* CONFIG_PAGE_TABLE_CHECK */
+#endif /* __LINUX_PAGE_TABLE_CHECK_H */
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 1e73717802f8..e5724cd6946b 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -62,6 +62,30 @@ config PAGE_OWNER
 
 	  If unsure, say N.
 
+config PAGE_TABLE_CHECK
+	bool "Check for invalid mappings in user page tables"
+	depends on ARCH_SUPPORTS_PAGE_TABLE_CHECK
+	select PAGE_EXTENSION
+	help
+	  Check that anonymous page is not being mapped twice with read write
+	  permissions. Check that anonymous and file pages are not being
+	  erroneously shared. Since the checking is performed at the time
+	  entries are added and removed to user page tables, leaking, corruption
+	  and double mapping problems are detected synchronously.
+
+	  If unsure say "n".
+
+config PAGE_TABLE_CHECK_ENFORCED
+	bool "Enforce the page table checking by defauled"
+	depends on PAGE_TABLE_CHECK
+	help
+	  Always enable page table checking.  By default the page table checking
+	  is disabled, and can be optionally enabled via page_table_check=on
+	  kernel parameter. This config enforces that page table check is always
+	  enabled.
+
+	  If unsure say "n".
+
 config PAGE_POISONING
 	bool "Poison pages after freeing"
 	help
diff --git a/mm/Makefile b/mm/Makefile
index d6c0042e3aa0..5c5a3a480fa6 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -112,6 +112,7 @@ obj-$(CONFIG_GENERIC_EARLY_IOREMAP) += early_ioremap.o
 obj-$(CONFIG_CMA)	+= cma.o
 obj-$(CONFIG_MEMORY_BALLOON) += balloon_compaction.o
 obj-$(CONFIG_PAGE_EXTENSION) += page_ext.o
+obj-$(CONFIG_PAGE_TABLE_CHECK) += page_table_check.o
 obj-$(CONFIG_CMA_DEBUGFS) += cma_debug.o
 obj-$(CONFIG_SECRETMEM) += secretmem.o
 obj-$(CONFIG_CMA_SYSFS) += cma_sysfs.o
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 58490fa8948d..1a90a3cf8ef9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -64,6 +64,7 @@
 #include <linux/sched/rt.h>
 #include <linux/sched/mm.h>
 #include <linux/page_owner.h>
+#include <linux/page_table_check.h>
 #include <linux/kthread.h>
 #include <linux/memcontrol.h>
 #include <linux/ftrace.h>
@@ -1298,6 +1299,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 		if (memcg_kmem_enabled() && PageMemcgKmem(page))
 			__memcg_kmem_uncharge_page(page, order);
 		reset_page_owner(page, order);
+		page_table_check_free(page, order);
 		return false;
 	}
 
@@ -1337,6 +1339,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	page_cpupid_reset_last(page);
 	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
 	reset_page_owner(page, order);
+	page_table_check_free(page, order);
 
 	if (!PageHighMem(page)) {
 		debug_check_no_locks_freed(page_address(page),
@@ -2411,6 +2414,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	}
 
 	set_page_owner(page, order, gfp_flags);
+	page_table_check_alloc(page, order);
 }
 
 static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
diff --git a/mm/page_ext.c b/mm/page_ext.c
index 6242afb24d84..bee3240604dc 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -8,6 +8,7 @@
 #include <linux/kmemleak.h>
 #include <linux/page_owner.h>
 #include <linux/page_idle.h>
+#include <linux/page_table_check.h>
 
 /*
  * struct page extension
@@ -75,6 +76,9 @@ static struct page_ext_operations *page_ext_ops[] = {
 #if defined(CONFIG_PAGE_IDLE_FLAG) && !defined(CONFIG_64BIT)
 	&page_idle_ops,
 #endif
+#ifdef CONFIG_PAGE_TABLE_CHECK
+	&page_table_check_ops,
+#endif
 };
 
 unsigned long page_ext_size = sizeof(struct page_ext);
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
new file mode 100644
index 000000000000..06f1c9e0a62a
--- /dev/null
+++ b/mm/page_table_check.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2021, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+#include <linux/mm.h>
+#include <linux/page_table_check.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"page_table_check: " fmt
+
+struct page_table_check {
+	atomic_t anon_map_count;
+	atomic_t file_map_count;
+};
+
+static bool __page_table_check_enabled __initdata =
+				IS_ENABLED(CONFIG_PAGE_TABLE_CHECK_ENFORCED);
+
+DEFINE_STATIC_KEY_TRUE_RO(page_table_check_disabled);
+
+static int __init early_page_table_check_param(char *buf)
+{
+	if (!buf)
+		return -EINVAL;
+
+	if (strcmp(buf, "on") == 0)
+		__page_table_check_enabled = true;
+
+	return 0;
+}
+
+early_param("page_table_check", early_page_table_check_param);
+
+static bool __init need_page_table_check(void)
+{
+	return __page_table_check_enabled;
+}
+
+static void __init init_page_table_check(void)
+{
+	if (!__page_table_check_enabled)
+		return;
+	static_branch_disable(&page_table_check_disabled);
+}
+
+struct page_ext_operations page_table_check_ops = {
+	.size = sizeof(struct page_table_check),
+	.need = need_page_table_check,
+	.init = init_page_table_check,
+};
+
+static struct page_table_check *get_page_table_check(struct page_ext *page_ext)
+{
+	BUG_ON(!page_ext);
+	return (void *)(page_ext) + page_table_check_ops.offset;
+}
+
+static inline bool pte_user_accessible_page(pte_t pte)
+{
+	return (pte_val(pte) & _PAGE_PRESENT) && (pte_val(pte) & _PAGE_USER);
+}
+
+static inline bool pmd_user_accessible_page(pmd_t pmd)
+{
+	return pmd_leaf(pmd) && (pmd_val(pmd) & _PAGE_PRESENT) &&
+		(pmd_val(pmd) & _PAGE_USER);
+}
+
+static inline bool pud_user_accessible_page(pud_t pud)
+{
+	return pud_leaf(pud) && (pud_val(pud) & _PAGE_PRESENT) &&
+		(pud_val(pud) & _PAGE_USER);
+}
+
+/*
+ * An enty is removed from the page table, decrement the counters for that page
+ * verify that it is of correct type and counters do not become negative.
+ */
+static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
+				   unsigned long pfn, unsigned int pgcnt)
+{
+	struct page_ext *page_ext;
+	struct page *page;
+	bool anon;
+	int i;
+
+	if (!pfn_valid(pfn))
+		return;
+
+	page = pfn_to_page(pfn);
+	page_ext = lookup_page_ext(page);
+	anon = PageAnon(page);
+
+	for (i = 0; i < pgcnt; i++) {
+		struct page_table_check *ptc = get_page_table_check(page_ext);
+
+		if (anon) {
+			BUG_ON(atomic_read(&ptc->file_map_count));
+			BUG_ON(atomic_dec_return(&ptc->anon_map_count) < 0);
+		} else {
+			BUG_ON(atomic_read(&ptc->anon_map_count));
+			BUG_ON(atomic_dec_return(&ptc->file_map_count) < 0);
+		}
+		page_ext = page_ext_next(page_ext);
+	}
+}
+
+/*
+ * A new enty is added to the page table, increment the counters for that page
+ * verify that it is of correct type and is not being mapped with a different
+ * type to a different process.
+ */
+static void page_table_check_set(struct mm_struct *mm, unsigned long addr,
+				 unsigned long pfn, unsigned long pgcnt,
+				 bool rw)
+{
+	struct page_ext *page_ext;
+	struct page *page;
+	bool anon;
+	int i;
+
+	if (!pfn_valid(pfn))
+		return;
+
+	page = pfn_to_page(pfn);
+	page_ext = lookup_page_ext(page);
+	anon = PageAnon(page);
+
+	for (i = 0; i < pgcnt; i++) {
+		struct page_table_check *ptc = get_page_table_check(page_ext);
+
+		if (anon) {
+			BUG_ON(atomic_read(&ptc->file_map_count));
+			BUG_ON(atomic_inc_return(&ptc->anon_map_count) > 1 && rw);
+		} else {
+			BUG_ON(atomic_read(&ptc->anon_map_count));
+			BUG_ON(atomic_inc_return(&ptc->file_map_count) < 0);
+		}
+		page_ext = page_ext_next(page_ext);
+	}
+}
+
+/*
+ * page is on free list, or is being allocated, verify that counters are zeroes
+ * crash if they are not.
+ */
+void __page_table_check_zero(struct page *page, unsigned int order)
+{
+	struct page_ext *page_ext = lookup_page_ext(page);
+	int i;
+
+	BUG_ON(!page_ext);
+	for (i = 0; i < (1 << order); i++) {
+		struct page_table_check *ptc = get_page_table_check(page_ext);
+
+		BUG_ON(atomic_read(&ptc->anon_map_count));
+		BUG_ON(atomic_read(&ptc->file_map_count));
+		page_ext = page_ext_next(page_ext);
+	}
+}
+
+void __page_table_check_pte_clear(struct mm_struct *mm, unsigned long addr,
+				  pte_t pte)
+{
+	if (&init_mm == mm)
+		return;
+
+	if (pte_user_accessible_page(pte)) {
+		page_table_check_clear(mm, addr, pte_pfn(pte),
+				       PAGE_SIZE >> PAGE_SHIFT);
+	}
+}
+
+void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
+				  pmd_t pmd)
+{
+	if (&init_mm == mm)
+		return;
+
+	if (pmd_user_accessible_page(pmd)) {
+		page_table_check_clear(mm, addr, pmd_pfn(pmd),
+				       PMD_PAGE_SIZE >> PAGE_SHIFT);
+	}
+}
+
+void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
+				  pud_t pud)
+{
+	if (&init_mm == mm)
+		return;
+
+	if (pud_user_accessible_page(pud)) {
+		page_table_check_clear(mm, addr, pud_pfn(pud),
+				       PUD_PAGE_SIZE >> PAGE_SHIFT);
+	}
+}
+
+void __page_table_check_pte_set(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, pte_t pte)
+{
+	pte_t old_pte;
+
+	if (&init_mm == mm)
+		return;
+
+	old_pte = *ptep;
+	if (pte_user_accessible_page(old_pte)) {
+		page_table_check_clear(mm, addr, pte_pfn(old_pte),
+				       PAGE_SIZE >> PAGE_SHIFT);
+	}
+
+	if (pte_user_accessible_page(pte)) {
+		page_table_check_set(mm, addr, pte_pfn(pte),
+				     PAGE_SIZE >> PAGE_SHIFT,
+				     pte_write(pte));
+	}
+}
+
+void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
+				pmd_t *pmdp, pmd_t pmd)
+{
+	pmd_t old_pmd;
+
+	if (&init_mm == mm)
+		return;
+
+	old_pmd = *pmdp;
+	if (pmd_user_accessible_page(old_pmd)) {
+		page_table_check_clear(mm, addr, pmd_pfn(old_pmd),
+				       PMD_PAGE_SIZE >> PAGE_SHIFT);
+	}
+
+	if (pmd_user_accessible_page(pmd)) {
+		page_table_check_set(mm, addr, pmd_pfn(pmd),
+				     PMD_PAGE_SIZE >> PAGE_SHIFT,
+				     pmd_write(pmd));
+	}
+}
+
+void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
+				pud_t *pudp, pud_t pud)
+{
+	pud_t old_pud;
+
+	if (&init_mm == mm)
+		return;
+
+	old_pud = *pudp;
+	if (pud_user_accessible_page(old_pud)) {
+		page_table_check_clear(mm, addr, pud_pfn(old_pud),
+				       PUD_PAGE_SIZE >> PAGE_SHIFT);
+	}
+
+	if (pud_user_accessible_page(pud)) {
+		page_table_check_set(mm, addr, pud_pfn(pud),
+				     PUD_PAGE_SIZE >> PAGE_SHIFT,
+				     pud_write(pud));
+	}
+}
-- 
2.34.0.rc2.393.gf8c9666880-goog

