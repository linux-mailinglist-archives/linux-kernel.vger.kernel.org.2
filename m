Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E7B3417AE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbhCSIpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbhCSIp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:45:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D447C06174A;
        Fri, 19 Mar 2021 01:45:28 -0700 (PDT)
Received: from zn.tnic (p200300ec2f091e00ccf0bdf306f8eebc.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:1e00:ccf0:bdf3:6f8:eebc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8E1B91EC0242;
        Fri, 19 Mar 2021 09:45:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1616143526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=czHSEi3bMulUaRRsL1r9AT9YjfYyqRexgHcgJ2lyt3M=;
        b=a/oRHoEF+4zjA1eGOnLmjfilSeSjNsHIuRwZWUnc1iTN2knaYK7ZTa+UtbKBZ8k6/BG5Oc
        v45yxTE+C+9Na7E6MQ0vk0/or4txoAIodvHOFu166aGO2n6rN4CMAXPmOOs7YBW1/X78V0
        /3UMcBDgc/jKp19F+KATITf6A42HCHw=
Date:   Fri, 19 Mar 2021 09:45:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kai Huang <kai.huang@intel.com>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org, jarkko@kernel.org,
        dave.hansen@linux.intel.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/sgx: Avoid returning NULL in __sgx_alloc_epc_page()
Message-ID: <20210319084523.GA6251@zn.tnic>
References: <20210319040602.178558-1-kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210319040602.178558-1-kai.huang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 05:06:02PM +1300, Kai Huang wrote:
> Below kernel bug happened when running simple SGX application when EPC
> is under pressure.  The root cause is with commit 5b8719504e3a
> ("x86/sgx: Add a basic NUMA allocation scheme to sgx_alloc_epc_page()"),
> __sgx_alloc_epc_page() returns NULL when there's no free EPC page can be
> allocated, while old behavior was it always returned ERR_PTR(-ENOMEM) in
> such case.
> 
> Fix by directly returning the page if __sgx_alloc_epc_page_from_node()
> allocates a valid page in fallback to non-local allocation, and always
> returning ERR_PTR(-ENOMEM) if no EPC page can be allocated.
> 
> [  253.474764] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [  253.500101] #PF: supervisor write access in kernel mode
> [  253.525462] #PF: error_code(0x0002) - not-present page
> ...
> [  254.102041] Call Trace:
> [  254.126699]  sgx_ioc_enclave_add_pages+0x241/0x770
> [  254.151305]  sgx_ioctl+0x194/0x4b0
> [  254.174976]  ? handle_mm_fault+0xd0/0x260
> [  254.198470]  ? do_user_addr_fault+0x1ef/0x570
> [  254.221827]  __x64_sys_ioctl+0x91/0xc0
> [  254.244546]  do_syscall_64+0x38/0x90
> [  254.266728]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  254.289232] RIP: 0033:0x7fdc4cf4031b
> ...
> [  254.711480] CR2: 0000000000000008
> [  254.735494] ---[ end trace 970dce6d4cdf7f64 ]---
> [  254.759915] RIP: 0010:sgx_alloc_epc_page+0x46/0x152
> ...
> 
> Fixes: 5b8719504e3a("x86/sgx: Add a basic NUMA allocation scheme to sgx_alloc_epc_page()")
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> ---
>  arch/x86/kernel/cpu/sgx/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I was on the verge whether to merge that into the original patch since
it is the top patch on the branch or create a new one but opted for
former because this way it won't break bisection and people won't have
to pay attention whether there's a fix patch to the NUMA patch too, in
case they wanna backport and whatnot.

Here's the new version:

Thx.

---
From 323950a8a98b492ac2fa168e8e4c0becfb4554dd Mon Sep 17 00:00:00 2001
From: Jarkko Sakkinen <jarkko@kernel.org>
Date: Thu, 18 Mar 2021 01:53:31 +0200
Subject: [PATCH] x86/sgx: Add a basic NUMA allocation scheme to
 sgx_alloc_epc_page()

Background
==========

SGX enclave memory is enumerated by the processor in contiguous physical
ranges called Enclave Page Cache (EPC) sections.  Currently, there is a
free list per section, but allocations simply target the lowest-numbered
sections.  This is functional, but has no NUMA awareness.

Fortunately, EPC sections are covered by entries in the ACPI SRAT table.
These entries allow each EPC section to be associated with a NUMA node,
just like normal RAM.

Solution
========

Implement a NUMA-aware enclave page allocator.  Mirror the buddy allocator
and maintain a list of enclave pages for each NUMA node.  Attempt to
allocate enclave memory first from local nodes, then fall back to other
nodes.

Note that the fallback is not as sophisticated as the buddy allocator
and is itself not aware of NUMA distances.  When a node's free list is
empty, it searches for the next-highest node with enclave pages (and
will wrap if necessary).  This could be improved in the future.

Other
=====

NUMA_KEEP_MEMINFO dependency is required for phys_to_target_node().

 [ Kai Huang: Do not return NULL from __sgx_alloc_epc_page() because
   callers do not expect that and that leads to a NULL ptr deref. ]

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/lkml/158188326978.894464.217282995221175417.stgit@dwillia2-desk3.amr.corp.intel.com/
Link: https://lkml.kernel.org/r/20210317235332.362001-2-jarkko.sakkinen@intel.com
---
 arch/x86/Kconfig               |   1 +
 arch/x86/kernel/cpu/sgx/main.c | 119 +++++++++++++++++++++------------
 arch/x86/kernel/cpu/sgx/sgx.h  |  16 +++--
 3 files changed, 88 insertions(+), 48 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879d398e..35391e94bd22 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1931,6 +1931,7 @@ config X86_SGX
 	depends on CRYPTO_SHA256=y
 	select SRCU
 	select MMU_NOTIFIER
+	select NUMA_KEEP_MEMINFO if NUMA
 	help
 	  Intel(R) Software Guard eXtensions (SGX) is a set of CPU instructions
 	  that can be used by applications to set aside private regions of code
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index f3a5cd2d27ef..5c9c5e5fb1fb 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -23,9 +23,21 @@ static DECLARE_WAIT_QUEUE_HEAD(ksgxd_waitq);
  * with sgx_reclaimer_lock acquired.
  */
 static LIST_HEAD(sgx_active_page_list);
-
 static DEFINE_SPINLOCK(sgx_reclaimer_lock);
 
+/* The free page list lock protected variables prepend the lock. */
+static unsigned long sgx_nr_free_pages;
+
+/* Nodes with one or more EPC sections. */
+static nodemask_t sgx_numa_mask;
+
+/*
+ * Array with one list_head for each possible NUMA node.  Each
+ * list contains all the sgx_epc_section's which are on that
+ * node.
+ */
+static struct sgx_numa_node *sgx_numa_nodes;
+
 static LIST_HEAD(sgx_dirty_page_list);
 
 /*
@@ -312,6 +324,7 @@ static void sgx_reclaim_pages(void)
 	struct sgx_epc_section *section;
 	struct sgx_encl_page *encl_page;
 	struct sgx_epc_page *epc_page;
+	struct sgx_numa_node *node;
 	pgoff_t page_index;
 	int cnt = 0;
 	int ret;
@@ -383,28 +396,18 @@ static void sgx_reclaim_pages(void)
 		epc_page->flags &= ~SGX_EPC_PAGE_RECLAIMER_TRACKED;
 
 		section = &sgx_epc_sections[epc_page->section];
-		spin_lock(&section->lock);
-		list_add_tail(&epc_page->list, &section->page_list);
-		section->free_cnt++;
-		spin_unlock(&section->lock);
-	}
-}
-
-static unsigned long sgx_nr_free_pages(void)
-{
-	unsigned long cnt = 0;
-	int i;
-
-	for (i = 0; i < sgx_nr_epc_sections; i++)
-		cnt += sgx_epc_sections[i].free_cnt;
+		node = section->node;
 
-	return cnt;
+		spin_lock(&node->lock);
+		list_add_tail(&epc_page->list, &node->free_page_list);
+		sgx_nr_free_pages++;
+		spin_unlock(&node->lock);
+	}
 }
 
 static bool sgx_should_reclaim(unsigned long watermark)
 {
-	return sgx_nr_free_pages() < watermark &&
-	       !list_empty(&sgx_active_page_list);
+	return sgx_nr_free_pages < watermark && !list_empty(&sgx_active_page_list);
 }
 
 static int ksgxd(void *p)
@@ -451,45 +454,56 @@ static bool __init sgx_page_reclaimer_init(void)
 	return true;
 }
 
-static struct sgx_epc_page *__sgx_alloc_epc_page_from_section(struct sgx_epc_section *section)
+static struct sgx_epc_page *__sgx_alloc_epc_page_from_node(int nid)
 {
-	struct sgx_epc_page *page;
+	struct sgx_numa_node *node = &sgx_numa_nodes[nid];
+	struct sgx_epc_page *page = NULL;
 
-	spin_lock(&section->lock);
+	spin_lock(&node->lock);
 
-	if (list_empty(&section->page_list)) {
-		spin_unlock(&section->lock);
+	if (list_empty(&node->free_page_list)) {
+		spin_unlock(&node->lock);
 		return NULL;
 	}
 
-	page = list_first_entry(&section->page_list, struct sgx_epc_page, list);
+	page = list_first_entry(&node->free_page_list, struct sgx_epc_page, list);
 	list_del_init(&page->list);
-	section->free_cnt--;
+	sgx_nr_free_pages--;
+
+	spin_unlock(&node->lock);
 
-	spin_unlock(&section->lock);
 	return page;
 }
 
 /**
  * __sgx_alloc_epc_page() - Allocate an EPC page
  *
- * Iterate through EPC sections and borrow a free EPC page to the caller. When a
- * page is no longer needed it must be released with sgx_free_epc_page().
+ * Iterate through NUMA nodes and reserve ia free EPC page to the caller. Start
+ * from the NUMA node, where the caller is executing.
  *
  * Return:
- *   an EPC page,
- *   -errno on error
+ * - an EPC page:	A borrowed EPC pages were available.
+ * - NULL:		Out of EPC pages.
  */
 struct sgx_epc_page *__sgx_alloc_epc_page(void)
 {
-	struct sgx_epc_section *section;
 	struct sgx_epc_page *page;
-	int i;
+	int nid_of_current = numa_node_id();
+	int nid;
 
-	for (i = 0; i < sgx_nr_epc_sections; i++) {
-		section = &sgx_epc_sections[i];
+	if (node_isset(nid_of_current, sgx_numa_mask)) {
+		page = __sgx_alloc_epc_page_from_node(nid_of_current);
+		if (page)
+			return page;
+	}
+
+	/* Fall back to the non-local NUMA nodes: */
+	while (true) {
+		nid = next_node_in(nid, sgx_numa_mask);
+		if (nid == nid_of_current)
+			break;
 
-		page = __sgx_alloc_epc_page_from_section(section);
+		page = __sgx_alloc_epc_page_from_node(nid);
 		if (page)
 			return page;
 	}
@@ -600,6 +614,7 @@ struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim)
 void sgx_free_epc_page(struct sgx_epc_page *page)
 {
 	struct sgx_epc_section *section = &sgx_epc_sections[page->section];
+	struct sgx_numa_node *node = section->node;
 	int ret;
 
 	WARN_ON_ONCE(page->flags & SGX_EPC_PAGE_RECLAIMER_TRACKED);
@@ -608,10 +623,12 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 	if (WARN_ONCE(ret, "EREMOVE returned %d (0x%x)", ret, ret))
 		return;
 
-	spin_lock(&section->lock);
-	list_add_tail(&page->list, &section->page_list);
-	section->free_cnt++;
-	spin_unlock(&section->lock);
+	spin_lock(&node->lock);
+
+	list_add_tail(&page->list, &node->free_page_list);
+	sgx_nr_free_pages++;
+
+	spin_unlock(&node->lock);
 }
 
 static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
@@ -632,8 +649,6 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 	}
 
 	section->phys_addr = phys_addr;
-	spin_lock_init(&section->lock);
-	INIT_LIST_HEAD(&section->page_list);
 
 	for (i = 0; i < nr_pages; i++) {
 		section->pages[i].section = index;
@@ -642,7 +657,7 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
 	}
 
-	section->free_cnt = nr_pages;
+	sgx_nr_free_pages += nr_pages;
 	return true;
 }
 
@@ -661,8 +676,13 @@ static bool __init sgx_page_cache_init(void)
 {
 	u32 eax, ebx, ecx, edx, type;
 	u64 pa, size;
+	int nid;
 	int i;
 
+	sgx_numa_nodes = kmalloc_array(num_possible_nodes(), sizeof(*sgx_numa_nodes), GFP_KERNEL);
+	if (!sgx_numa_nodes)
+		return false;
+
 	for (i = 0; i < ARRAY_SIZE(sgx_epc_sections); i++) {
 		cpuid_count(SGX_CPUID, i + SGX_CPUID_EPC, &eax, &ebx, &ecx, &edx);
 
@@ -685,6 +705,21 @@ static bool __init sgx_page_cache_init(void)
 			break;
 		}
 
+		nid = numa_map_to_online_node(phys_to_target_node(pa));
+		if (nid == NUMA_NO_NODE) {
+			/* The physical address is already printed above. */
+			pr_warn(FW_BUG "Unable to map EPC section to online node. Fallback to the NUMA node 0.\n");
+			nid = 0;
+		}
+
+		if (!node_isset(nid, sgx_numa_mask)) {
+			spin_lock_init(&sgx_numa_nodes[nid].lock);
+			INIT_LIST_HEAD(&sgx_numa_nodes[nid].free_page_list);
+			node_set(nid, sgx_numa_mask);
+		}
+
+		sgx_epc_sections[i].node =  &sgx_numa_nodes[nid];
+
 		sgx_nr_epc_sections++;
 	}
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index bc8af0428640..653af8ca1a25 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -29,22 +29,26 @@ struct sgx_epc_page {
 	struct list_head list;
 };
 
+/*
+ * Contains the tracking data for NUMA nodes having EPC pages. Most importantly,
+ * the free page list local to the node is stored here.
+ */
+struct sgx_numa_node {
+	struct list_head free_page_list;
+	spinlock_t lock;
+};
+
 /*
  * The firmware can define multiple chunks of EPC to the different areas of the
  * physical memory e.g. for memory areas of the each node. This structure is
  * used to store EPC pages for one EPC section and virtual memory area where
  * the pages have been mapped.
- *
- * 'lock' must be held before accessing 'page_list' or 'free_cnt'.
  */
 struct sgx_epc_section {
 	unsigned long phys_addr;
 	void *virt_addr;
 	struct sgx_epc_page *pages;
-
-	spinlock_t lock;
-	struct list_head page_list;
-	unsigned long free_cnt;
+	struct sgx_numa_node *node;
 };
 
 extern struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
-- 
2.29.2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
