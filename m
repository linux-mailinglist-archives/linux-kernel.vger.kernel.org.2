Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C713FA026
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 21:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhH0T4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 15:56:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:26658 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230474AbhH0T4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 15:56:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10089"; a="218024425"
X-IronPort-AV: E=Sophos;i="5.84,357,1620716400"; 
   d="scan'208";a="218024425"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 12:55:56 -0700
X-IronPort-AV: E=Sophos;i="5.84,357,1620716400"; 
   d="scan'208";a="528422073"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 12:55:55 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Cathy Zhang <cathy.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 1/6] x86/sgx: Provide indication of life-cycle of EPC pages
Date:   Fri, 27 Aug 2021 12:55:38 -0700
Message-Id: <20210827195543.1667168-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210827195543.1667168-1-tony.luck@intel.com>
References: <20210728204653.1509010-1-tony.luck@intel.com>
 <20210827195543.1667168-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGX EPC pages go through the following life cycle:

        DIRTY ---> FREE ---> IN-USE --\
                    ^                 |
                    \-----------------/

Recovery action for poison for a DIRTY or FREE page is simple. Just
make sure never to allocate the page. IN-USE pages need some extra
handling.

It would be good to use the sgx_epc_page->owner field as an indicator
of where an EPC page is currently in that cycle (owner != NULL means
the EPC page is IN-USE). But there is one caller, sgx_alloc_va_page(),
that calls with NULL.

Since there are multiple uses of the "owner" field with different types
change the sgx_epc_page structure to define an anonymous union with
each of the uses explicitly called out.

Start epc_pages out with a non-NULL owner while they are in DIRTY state.

Fix up the one holdout to provide a non-NULL owner.

Refactor the allocation sequence so that changes to/from NULL
value happen together with adding/removing the epc_page from
a free list while the node->lock is held.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/sgx/encl.c  |  5 +++--
 arch/x86/kernel/cpu/sgx/encl.h  |  2 +-
 arch/x86/kernel/cpu/sgx/ioctl.c |  2 +-
 arch/x86/kernel/cpu/sgx/main.c  | 23 ++++++++++++-----------
 arch/x86/kernel/cpu/sgx/sgx.h   | 12 ++++++++----
 5 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 001808e3901c..ad8c61933b0a 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -667,6 +667,7 @@ int sgx_encl_test_and_clear_young(struct mm_struct *mm,
 
 /**
  * sgx_alloc_va_page() - Allocate a Version Array (VA) page
+ * @va_page:	struct sgx_va_page connected to this VA page
  *
  * Allocate a free EPC page and convert it to a Version Array (VA) page.
  *
@@ -674,12 +675,12 @@ int sgx_encl_test_and_clear_young(struct mm_struct *mm,
  *   a VA page,
  *   -errno otherwise
  */
-struct sgx_epc_page *sgx_alloc_va_page(void)
+struct sgx_epc_page *sgx_alloc_va_page(struct sgx_va_page *va_page)
 {
 	struct sgx_epc_page *epc_page;
 	int ret;
 
-	epc_page = sgx_alloc_epc_page(NULL, true);
+	epc_page = sgx_alloc_epc_page(va_page, true);
 	if (IS_ERR(epc_page))
 		return ERR_CAST(epc_page);
 
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index fec43ca65065..3d12dbeae14a 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -111,7 +111,7 @@ void sgx_encl_put_backing(struct sgx_backing *backing, bool do_write);
 int sgx_encl_test_and_clear_young(struct mm_struct *mm,
 				  struct sgx_encl_page *page);
 
-struct sgx_epc_page *sgx_alloc_va_page(void);
+struct sgx_epc_page *sgx_alloc_va_page(struct sgx_va_page *va_page);
 unsigned int sgx_alloc_va_slot(struct sgx_va_page *va_page);
 void sgx_free_va_slot(struct sgx_va_page *va_page, unsigned int offset);
 bool sgx_va_page_full(struct sgx_va_page *va_page);
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 83df20e3e633..655ce0bb069d 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -30,7 +30,7 @@ static struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
 		if (!va_page)
 			return ERR_PTR(-ENOMEM);
 
-		va_page->epc_page = sgx_alloc_va_page();
+		va_page->epc_page = sgx_alloc_va_page(va_page);
 		if (IS_ERR(va_page->epc_page)) {
 			err = ERR_CAST(va_page->epc_page);
 			kfree(va_page);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 63d3de02bbcc..4a5b51d16133 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -457,7 +457,7 @@ static bool __init sgx_page_reclaimer_init(void)
 	return true;
 }
 
-static struct sgx_epc_page *__sgx_alloc_epc_page_from_node(int nid)
+static struct sgx_epc_page *__sgx_alloc_epc_page_from_node(void *private, int nid)
 {
 	struct sgx_numa_node *node = &sgx_numa_nodes[nid];
 	struct sgx_epc_page *page = NULL;
@@ -471,6 +471,7 @@ static struct sgx_epc_page *__sgx_alloc_epc_page_from_node(int nid)
 
 	page = list_first_entry(&node->free_page_list, struct sgx_epc_page, list);
 	list_del_init(&page->list);
+	page->private = private;
 	sgx_nr_free_pages--;
 
 	spin_unlock(&node->lock);
@@ -480,6 +481,7 @@ static struct sgx_epc_page *__sgx_alloc_epc_page_from_node(int nid)
 
 /**
  * __sgx_alloc_epc_page() - Allocate an EPC page
+ * @owner:	the owner of the EPC page
  *
  * Iterate through NUMA nodes and reserve ia free EPC page to the caller. Start
  * from the NUMA node, where the caller is executing.
@@ -488,14 +490,14 @@ static struct sgx_epc_page *__sgx_alloc_epc_page_from_node(int nid)
  * - an EPC page:	A borrowed EPC pages were available.
  * - NULL:		Out of EPC pages.
  */
-struct sgx_epc_page *__sgx_alloc_epc_page(void)
+struct sgx_epc_page *__sgx_alloc_epc_page(void *private)
 {
 	struct sgx_epc_page *page;
 	int nid_of_current = numa_node_id();
 	int nid = nid_of_current;
 
 	if (node_isset(nid_of_current, sgx_numa_mask)) {
-		page = __sgx_alloc_epc_page_from_node(nid_of_current);
+		page = __sgx_alloc_epc_page_from_node(private, nid_of_current);
 		if (page)
 			return page;
 	}
@@ -506,7 +508,7 @@ struct sgx_epc_page *__sgx_alloc_epc_page(void)
 		if (nid == nid_of_current)
 			break;
 
-		page = __sgx_alloc_epc_page_from_node(nid);
+		page = __sgx_alloc_epc_page_from_node(private, nid);
 		if (page)
 			return page;
 	}
@@ -559,7 +561,7 @@ int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
 
 /**
  * sgx_alloc_epc_page() - Allocate an EPC page
- * @owner:	the owner of the EPC page
+ * @private:	per-caller private data
  * @reclaim:	reclaim pages if necessary
  *
  * Iterate through EPC sections and borrow a free EPC page to the caller. When a
@@ -574,16 +576,14 @@ int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
  *   an EPC page,
  *   -errno on error
  */
-struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
+struct sgx_epc_page *sgx_alloc_epc_page(void *private, bool reclaim)
 {
 	struct sgx_epc_page *page;
 
 	for ( ; ; ) {
-		page = __sgx_alloc_epc_page();
-		if (!IS_ERR(page)) {
-			page->owner = owner;
+		page = __sgx_alloc_epc_page(private);
+		if (!IS_ERR(page))
 			break;
-		}
 
 		if (list_empty(&sgx_active_page_list))
 			return ERR_PTR(-ENOMEM);
@@ -624,6 +624,7 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 
 	spin_lock(&node->lock);
 
+	page->private = NULL;
 	list_add_tail(&page->list, &node->free_page_list);
 	sgx_nr_free_pages++;
 
@@ -652,7 +653,7 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 	for (i = 0; i < nr_pages; i++) {
 		section->pages[i].section = index;
 		section->pages[i].flags = 0;
-		section->pages[i].owner = NULL;
+		section->pages[i].private = "dirty";
 		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
 	}
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 4628acec0009..8b1be10a46f6 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -28,8 +28,12 @@
 
 struct sgx_epc_page {
 	unsigned int section;
-	unsigned int flags;
-	struct sgx_encl_page *owner;
+	int flags;
+	union {
+		void *private;
+		struct sgx_encl_page *owner;
+		struct sgx_encl_page *vepc;
+	};
 	struct list_head list;
 };
 
@@ -77,12 +81,12 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_epc_page *page)
 	return section->virt_addr + index * PAGE_SIZE;
 }
 
-struct sgx_epc_page *__sgx_alloc_epc_page(void);
+struct sgx_epc_page *__sgx_alloc_epc_page(void *private);
 void sgx_free_epc_page(struct sgx_epc_page *page);
 
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
-struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
+struct sgx_epc_page *sgx_alloc_epc_page(void *private, bool reclaim);
 
 #ifdef CONFIG_X86_SGX_KVM
 int __init sgx_vepc_init(void);
-- 
2.29.2

