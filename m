Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D6C3D9707
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 22:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhG1UrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 16:47:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:60188 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231674AbhG1UrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 16:47:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="234634461"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="234634461"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 13:47:01 -0700
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="506679877"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 13:47:01 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 3/7] x86/sgx: Initial poison handling for dirty and free pages
Date:   Wed, 28 Jul 2021 13:46:49 -0700
Message-Id: <20210728204653.1509010-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210728204653.1509010-1-tony.luck@intel.com>
References: <20210719182009.1409895-1-tony.luck@intel.com>
 <20210728204653.1509010-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A memory controller patrol scrubber can report poison in a page
that isn't currently being used.

Add a new flag bit (SGX_EPC_PAGE_POISON) that can be set for an
sgx_epc_page. Check for it:
1) When sanitizing dirty pages
2) When allocating pages
3) When freeing epc pages

In all cases drop the poisoned page to make sure it will not be
reallocated.

Add debugfs files /sys/kernel/debug/sgx/poison_page_{count,list}
so that system administrators can see how many enclave pages have
been dropped and get a list of those pages.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 50 +++++++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/sgx.h  |  3 ++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index ce40c010c9cb..354f0abec12d 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -11,6 +11,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sched/signal.h>
 #include <linux/slab.h>
+#include <linux/debugfs.h>
 #include <asm/sgx.h>
 #include "driver.h"
 #include "encl.h"
@@ -34,6 +35,9 @@ static unsigned long sgx_nr_free_pages;
 /* Nodes with one or more EPC sections. */
 static nodemask_t sgx_numa_mask;
 
+/* Maintain a count of poison pages */
+static u32 poison_page_count;
+
 /*
  * Array with one list_head for each possible NUMA node.  Each
  * list contains all the sgx_epc_section's which are on that
@@ -47,6 +51,9 @@ static LIST_HEAD(sgx_dirty_page_list);
  * Reset post-kexec EPC pages to the uninitialized state. The pages are removed
  * from the input list, and made available for the page allocator. SECS pages
  * prepending their children in the input list are left intact.
+ *
+ * Don't try to clean a poisoned page. That might trigger a machine check.
+ * Just drop the page and move on.
  */
 static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
 {
@@ -61,6 +68,11 @@ static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
 
 		page = list_first_entry(dirty_page_list, struct sgx_epc_page, list);
 
+		if (page->flags & SGX_EPC_PAGE_POISON) {
+			list_del(&page->list);
+			continue;
+		}
+
 		ret = __eremove(sgx_get_epc_virt_addr(page));
 		if (!ret) {
 			/*
@@ -567,6 +579,9 @@ int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
  * @reclaim is set to true, directly reclaim pages when we are out of pages. No
  * mm's can be locked when @reclaim is set to true.
  *
+ * A page on the free list might have been reported as poisoned by the patrol
+ * scrubber. If so, skip this page, and try again.
+ *
  * Finally, wake up ksgxd when the number of pages goes below the watermark
  * before returning back to the caller.
  *
@@ -580,6 +595,10 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 
 	for ( ; ; ) {
 		page = __sgx_alloc_epc_page();
+
+		if (page->flags & SGX_EPC_PAGE_POISON)
+			continue;
+
 		if (!IS_ERR(page)) {
 			page->owner = owner ? owner : page;
 			break;
@@ -616,6 +635,8 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
  * responsibility to make sure that the page is in uninitialized state. In other
  * words, do EREMOVE, EWB or whatever operation is necessary before calling
  * this function.
+ *
+ * Drop poison pages so they won't be reallocated.
  */
 void sgx_free_epc_page(struct sgx_epc_page *page)
 {
@@ -625,7 +646,8 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 	spin_lock(&node->lock);
 
 	page->owner = NULL;
-	list_add_tail(&page->list, &node->free_page_list);
+	if (!(page->flags & SGX_EPC_PAGE_POISON))
+		list_add_tail(&page->list, &node->free_page_list);
 	sgx_nr_free_pages++;
 
 	spin_unlock(&node->lock);
@@ -815,8 +837,30 @@ int sgx_set_attribute(unsigned long *allowed_attributes,
 }
 EXPORT_SYMBOL_GPL(sgx_set_attribute);
 
+static int poison_list_show(struct seq_file *m, void *private)
+{
+	struct sgx_epc_section *section;
+	struct sgx_epc_page *page;
+	unsigned long addr;
+	int i;
+
+	for (i = 0; i < SGX_MAX_EPC_SECTIONS; i++) {
+		section = &sgx_epc_sections[i];
+		page = section->pages;
+		for (addr = section->phys_addr; addr < section->end_phys_addr;
+		     addr += PAGE_SIZE, page++) {
+			if (page->flags & SGX_EPC_PAGE_POISON)
+				seq_printf(m, "0x%lx\n", addr);
+		}
+	}
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(poison_list);
+
 static int __init sgx_init(void)
 {
+	struct dentry *dir;
 	int ret;
 	int i;
 
@@ -848,6 +892,10 @@ static int __init sgx_init(void)
 	if (sgx_vepc_init() && ret)
 		goto err_provision;
 
+	dir = debugfs_create_dir("sgx", NULL);
+	debugfs_create_u32("poison_page_count", 0400, dir, &poison_page_count);
+	debugfs_create_file("poison_page_list", 0400, dir, NULL, &poison_list_fops);
+
 	return 0;
 
 err_provision:
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 226b081a4d05..2c3987ecdfe4 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -26,6 +26,9 @@
 /* Pages, which are being tracked by the page reclaimer. */
 #define SGX_EPC_PAGE_RECLAIMER_TRACKED	BIT(0)
 
+/* Poisoned pages */
+#define SGX_EPC_PAGE_POISON		BIT(1)
+
 struct sgx_epc_page {
 	unsigned int section;
 	unsigned int flags;
-- 
2.29.2

