Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D035D3A063C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 23:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbhFHVmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 17:42:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:45443 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234365AbhFHVmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:42:43 -0400
IronPort-SDR: VcX9tGpO+JrNzcJ30u+UuyKpn8JHxOAGccRdg3koLhJ/8Q17Q0PBDdZ/D29Z3odOrUHTbYRR2X
 ypxPFELcDUnw==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="226309334"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="226309334"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 14:40:48 -0700
IronPort-SDR: Si6z2X8oymb6ou48J4lc2Z4lx8pHZSD4bnntXLo3+ccZUX0hv9+w2HsJ762WrIX5hP+evUU6tl
 8k9NW0go7sQA==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="448057489"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 14:40:48 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [RFC PATCH 1/4] x86/sgx: Track phase and type of SGX EPC pages
Date:   Tue,  8 Jun 2021 14:40:35 -0700
Message-Id: <20210608214038.1026259-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210608214038.1026259-1-tony.luck@intel.com>
References: <20210608214038.1026259-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory errors can be reported either synchronously as memory is accessed,
or asynchronously by speculative access or by a memory controller page
scrubber.  The life cycle of an EPC page takes it through:
	dirty -> free -> in-use -> free.

Memory errors are reported using physical addresses. It is a simple
matter to find which sgx_epc_page structure maps a given address.
But then recovery code needs to be able to determine the current use of
the page to take the appropriate recovery action. Within the "in-use"
phase different actions are needed based on how the page is used in
the enclave.

Add new flags bits to describe the phase (with an extra bit for the new
phase of "poisoned"). Drop pages marked as poisoned instead of adding
them to a free list to make sure they are not re-used.

Add a type field to struct epc_page for how an in-use page has been
allocated. Re-use "enum sgx_page_type" for this type, with a couple
of additions for s/w types.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/sgx.h      |  6 ++++++
 arch/x86/kernel/cpu/sgx/encl.c  |  4 ++--
 arch/x86/kernel/cpu/sgx/ioctl.c |  4 ++--
 arch/x86/kernel/cpu/sgx/main.c  | 21 +++++++++++++++++++--
 arch/x86/kernel/cpu/sgx/sgx.h   | 14 ++++++++++++--
 arch/x86/kernel/cpu/sgx/virt.c  |  2 +-
 6 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index 9c31e0ebc55b..9619a6d77a83 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -216,6 +216,8 @@ struct sgx_pageinfo {
  * %SGX_PAGE_TYPE_REG:	a regular page
  * %SGX_PAGE_TYPE_VA:	a VA page
  * %SGX_PAGE_TYPE_TRIM:	a page in trimmed state
+ *
+ * Also used to track current use of &struct sgx_epc_page
  */
 enum sgx_page_type {
 	SGX_PAGE_TYPE_SECS,
@@ -223,6 +225,10 @@ enum sgx_page_type {
 	SGX_PAGE_TYPE_REG,
 	SGX_PAGE_TYPE_VA,
 	SGX_PAGE_TYPE_TRIM,
+
+	/* sgx_epc_page.type */
+	SGX_PAGE_TYPE_FREE = 100,
+	SGX_PAGE_TYPE_KVM = 101,
 };
 
 #define SGX_NR_PAGE_TYPES	5
diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 3be203297988..abf6e1a704c0 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -72,7 +72,7 @@ static struct sgx_epc_page *sgx_encl_eldu(struct sgx_encl_page *encl_page,
 	struct sgx_epc_page *epc_page;
 	int ret;
 
-	epc_page = sgx_alloc_epc_page(encl_page, false);
+	epc_page = sgx_alloc_epc_page(encl_page, SGX_PAGE_TYPE_REG, false);
 	if (IS_ERR(epc_page))
 		return epc_page;
 
@@ -679,7 +679,7 @@ struct sgx_epc_page *sgx_alloc_va_page(void)
 	struct sgx_epc_page *epc_page;
 	int ret;
 
-	epc_page = sgx_alloc_epc_page(NULL, true);
+	epc_page = sgx_alloc_epc_page(NULL,  SGX_PAGE_TYPE_VA, true);
 	if (IS_ERR(epc_page))
 		return ERR_CAST(epc_page);
 
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 83df20e3e633..a74ae00194cc 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -83,7 +83,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 
 	encl->backing = backing;
 
-	secs_epc = sgx_alloc_epc_page(&encl->secs, true);
+	secs_epc = sgx_alloc_epc_page(&encl->secs, SGX_PAGE_TYPE_SECS, true);
 	if (IS_ERR(secs_epc)) {
 		ret = PTR_ERR(secs_epc);
 		goto err_out_backing;
@@ -300,7 +300,7 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 	if (IS_ERR(encl_page))
 		return PTR_ERR(encl_page);
 
-	epc_page = sgx_alloc_epc_page(encl_page, true);
+	epc_page = sgx_alloc_epc_page(encl_page, SGX_PAGE_TYPE_REG, true);
 	if (IS_ERR(epc_page)) {
 		kfree(encl_page);
 		return PTR_ERR(epc_page);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 63d3de02bbcc..643df87b3e01 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -401,7 +401,12 @@ static void sgx_reclaim_pages(void)
 		section = &sgx_epc_sections[epc_page->section];
 		node = section->node;
 
+		/* drop poison pages instead of adding to free list */
+		if (epc_page->flags & SGX_EPC_PAGE_POISON)
+			continue;
+
 		spin_lock(&node->lock);
+		epc_page->flags = SGX_EPC_PAGE_FREE;
 		list_add_tail(&epc_page->list, &node->free_page_list);
 		sgx_nr_free_pages++;
 		spin_unlock(&node->lock);
@@ -560,6 +565,7 @@ int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
 /**
  * sgx_alloc_epc_page() - Allocate an EPC page
  * @owner:	the owner of the EPC page
+ * @type:	type of page being allocated
  * @reclaim:	reclaim pages if necessary
  *
  * Iterate through EPC sections and borrow a free EPC page to the caller. When a
@@ -574,7 +580,7 @@ int sgx_unmark_page_reclaimable(struct sgx_epc_page *page)
  *   an EPC page,
  *   -errno on error
  */
-struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
+struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_page_type type, bool reclaim)
 {
 	struct sgx_epc_page *page;
 
@@ -582,6 +588,8 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 		page = __sgx_alloc_epc_page();
 		if (!IS_ERR(page)) {
 			page->owner = owner;
+			page->type = type;
+			page->flags = 0;
 			break;
 		}
 
@@ -616,14 +624,22 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
  * responsibility to make sure that the page is in uninitialized state. In other
  * words, do EREMOVE, EWB or whatever operation is necessary before calling
  * this function.
+ *
+ * Note that if the page has been tagged as poisoned, it is simply
+ * dropped on the floor instead of added to the free list to make
+ * sure we do not re-use it.
  */
 void sgx_free_epc_page(struct sgx_epc_page *page)
 {
 	struct sgx_epc_section *section = &sgx_epc_sections[page->section];
 	struct sgx_numa_node *node = section->node;
 
+	if (page->flags & SGX_EPC_PAGE_POISON)
+		return;
+
 	spin_lock(&node->lock);
 
+	page->flags = SGX_EPC_PAGE_FREE;
 	list_add_tail(&page->list, &node->free_page_list);
 	sgx_nr_free_pages++;
 
@@ -651,7 +667,8 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 
 	for (i = 0; i < nr_pages; i++) {
 		section->pages[i].section = index;
-		section->pages[i].flags = 0;
+		section->pages[i].flags = SGX_EPC_PAGE_DIRTY;
+		section->pages[i].type = SGX_PAGE_TYPE_FREE;
 		section->pages[i].owner = NULL;
 		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
 	}
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 4628acec0009..e43d3c27eb96 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -26,9 +26,19 @@
 /* Pages, which are being tracked by the page reclaimer. */
 #define SGX_EPC_PAGE_RECLAIMER_TRACKED	BIT(0)
 
+/* Pages, on the "sgx_dirty_page_list" */
+#define SGX_EPC_PAGE_DIRTY		BIT(1)
+
+/* Pages, on one of the node free lists */
+#define SGX_EPC_PAGE_FREE		BIT(2)
+
+/* Pages, with h/w poison errors */
+#define SGX_EPC_PAGE_POISON		BIT(3)
+
 struct sgx_epc_page {
 	unsigned int section;
-	unsigned int flags;
+	u16 flags;
+	u16 type;
 	struct sgx_encl_page *owner;
 	struct list_head list;
 };
@@ -82,7 +92,7 @@ void sgx_free_epc_page(struct sgx_epc_page *page);
 
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
-struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
+struct sgx_epc_page *sgx_alloc_epc_page(void *owner, enum sgx_page_type type, bool reclaim);
 
 #ifdef CONFIG_X86_SGX_KVM
 int __init sgx_vepc_init(void);
diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
index 6ad165a5c0cc..a9d89e9ddf93 100644
--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -46,7 +46,7 @@ static int __sgx_vepc_fault(struct sgx_vepc *vepc,
 	if (epc_page)
 		return 0;
 
-	epc_page = sgx_alloc_epc_page(vepc, false);
+	epc_page = sgx_alloc_epc_page(vepc, SGX_PAGE_TYPE_KVM, false);
 	if (IS_ERR(epc_page))
 		return PTR_ERR(epc_page);
 
-- 
2.29.2

