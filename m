Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656D3458C36
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 11:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239125AbhKVKZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 05:25:38 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:47250 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229983AbhKVKZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 05:25:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UxivPbW_1637576547;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UxivPbW_1637576547)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Nov 2021 18:22:28 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, ying.huang@intel.com,
        dave.hansen@linux.intel.com
Cc:     ziy@nvidia.com, shy828301@gmail.com, baolin.wang@linux.alibaba.com,
        zhongjiang-ali@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: Promote slow memory in advance to improve performance
Date:   Mon, 22 Nov 2021 18:22:17 +0800
Message-Id: <fc80ea7998a98274447cb3be84d5ef705438a3dc.1637571100.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some workloads access a set of data entities will follow the data locality,
also known as locality of reference, which means the probability of accessing
some data soon after some nearby data has been accessed.

On some systems with different memory types, which will rely on the numa
balancing to promote slow hot memory to fast memory to improve performance.
So we can promote several sequential pages on slow memory at one time
according to the data locality for some workloads to improve the performance.

Testing with mysql can show about 5% performance improved as below.

Machine: 16 CPUs, 64G DRAM, 256G AEP

sysbench /usr/share/sysbench/tests/include/oltp_legacy/oltp.lua
--mysql-user=root --mysql-password=root --oltp-test-mode=complex
--oltp-tables-count=65 --oltp-table-size=5000000 --threads=20 --time=600
--report-interval=10

No proactive promotion:
transactions
2259245 (3765.37 per sec.)
2312605 (3854.31 per sec.)
2325907 (3876.47 per sec.)

Proactive promotion bytes=16384:
transactions
2419023 (4031.66 per sec.)
2451903 (4086.47 per sec.)
2441941 (4068.68 per sec.)

Suggested-by: Xunlei Pang <xlpang@linux.alibaba.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Note: This patch is based on "NUMA balancing: optimize memory placement
for memory tiering system" [1] from Huang Ying.

[1] https://lore.kernel.org/lkml/87bl2gsnrd.fsf@yhuang6-desk2.ccr.corp.intel.com/T/
---
 mm/memory.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 89 insertions(+), 9 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 5d9ed74c66f9..626523cbd60f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4058,7 +4058,28 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 static unsigned long fault_around_bytes __read_mostly =
 	rounddown_pow_of_two(65536);
 
+static unsigned long numa_around_bytes __read_mostly;
+
 #ifdef CONFIG_DEBUG_FS
+static int numa_around_bytes_get(void *data, u64 *val)
+{
+	*val = numa_around_bytes;
+	return 0;
+}
+
+static int numa_around_bytes_set(void *data, u64 val)
+{
+	if (val / PAGE_SIZE > PTRS_PER_PTE)
+		return -EINVAL;
+	if (val > PAGE_SIZE)
+		numa_around_bytes = rounddown_pow_of_two(val);
+	else
+		numa_around_bytes = 0; /* rounddown_pow_of_two(0) is undefined */
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(numa_around_bytes_fops,
+		numa_around_bytes_get, numa_around_bytes_set, "%llu\n");
+
 static int fault_around_bytes_get(void *data, u64 *val)
 {
 	*val = fault_around_bytes;
@@ -4086,6 +4107,9 @@ static int __init fault_around_debugfs(void)
 {
 	debugfs_create_file_unsafe("fault_around_bytes", 0644, NULL, NULL,
 				   &fault_around_bytes_fops);
+
+	debugfs_create_file_unsafe("numa_around_bytes", 0644, NULL, NULL,
+				   &numa_around_bytes_fops);
 	return 0;
 }
 late_initcall(fault_around_debugfs);
@@ -4323,16 +4347,55 @@ int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 	return mpol_misplaced(page, vma, addr);
 }
 
+static bool can_next_numa_page(struct vm_fault *vmf, unsigned long *fault_addr,
+			       unsigned long max_numa_addr)
+{
+	unsigned long next_fault_addr = vmf->address + PAGE_SIZE;
+
+	if (next_fault_addr >= max_numa_addr)
+		return false;
+
+	*fault_addr = next_fault_addr;
+	vmf->pte = pte_offset_map(vmf->pmd, next_fault_addr);
+	vmf->orig_pte = *vmf->pte;
+	if (pte_protnone(vmf->orig_pte))
+		return true;
+
+	return false;
+}
+
 static vm_fault_t do_numa_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page = NULL;
-	int page_nid = NUMA_NO_NODE;
+	int page_nid;
 	int last_cpupid;
 	int target_nid;
 	pte_t pte, old_pte;
-	bool was_writable = pte_savedwrite(vmf->orig_pte);
-	int flags = 0;
+	bool was_writable;
+	int flags;
+	unsigned long max_numa_addr = 0;
+	unsigned long numa_around_size = READ_ONCE(numa_around_bytes);
+	unsigned long fault_address = vmf->address;
+
+	/*
+	 * Make sure the size of proactive numa fault address is less than the
+	 * size of current VMA or PMD.
+	 */
+	if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
+	    numa_around_size > 0) {
+		unsigned long around_addr =
+			(fault_address + numa_around_size) & PAGE_MASK;
+		unsigned long next_pmd = (fault_address & PMD_MASK) + PMD_SIZE;
+
+	    max_numa_addr = min3(around_addr, next_pmd,
+				 vm_end_gap(vmf->vma));
+	}
+
+try_next:
+	was_writable = pte_savedwrite(vmf->orig_pte);
+	flags = 0;
+	page_nid = NUMA_NO_NODE;
 
 	/*
 	 * The "pte" at this point cannot be used safely without
@@ -4350,7 +4413,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	old_pte = ptep_get(vmf->pte);
 	pte = pte_modify(old_pte, vma->vm_page_prot);
 
-	page = vm_normal_page(vma, vmf->address, pte);
+	page = vm_normal_page(vma, fault_address, pte);
 	if (!page)
 		goto out_map;
 
@@ -4369,6 +4432,17 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (!was_writable)
 		flags |= TNF_NO_GROUP;
 
+	/*
+	 * According to the data locality for some workloads, the probability
+	 * of accessing some data soon after some nearby data has been accessed.
+	 * So for tiered memory systems, we can update the sequential page's age
+	 * located on slow memory type, to try to promote it to fast memory in
+	 * advance to improve the performance.
+	 */
+	if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
+	    vmf->address != fault_address)
+		xchg_page_access_time(page, jiffies_to_msecs(jiffies));
+
 	/*
 	 * Flag if the page is shared between multiple address spaces. This
 	 * is later used when determining whether to group tasks together
@@ -4386,7 +4460,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		last_cpupid = (-1 & LAST_CPUPID_MASK);
 	else
 		last_cpupid = page_cpupid_last(page);
-	target_nid = numa_migrate_prep(page, vma, vmf->address, page_nid,
+	target_nid = numa_migrate_prep(page, vma, fault_address, page_nid,
 			&flags);
 	if (target_nid == NUMA_NO_NODE) {
 		put_page(page);
@@ -4400,7 +4474,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		flags |= TNF_MIGRATED;
 	} else {
 		flags |= TNF_MIGRATE_FAIL;
-		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
+		vmf->pte = pte_offset_map(vmf->pmd, fault_address);
 		spin_lock(vmf->ptl);
 		if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -4412,19 +4486,25 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 out:
 	if (page_nid != NUMA_NO_NODE)
 		task_numa_fault(last_cpupid, page_nid, 1, flags);
+
+	if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
+	    max_numa_addr > 0 && page_nid != NUMA_NO_NODE &&
+	    can_next_numa_page(vmf, &fault_address, max_numa_addr))
+		goto try_next;
+
 	return 0;
 out_map:
 	/*
 	 * Make it present again, depending on how arch implements
 	 * non-accessible ptes, some can allow access by kernel mode.
 	 */
-	old_pte = ptep_modify_prot_start(vma, vmf->address, vmf->pte);
+	old_pte = ptep_modify_prot_start(vma, fault_address, vmf->pte);
 	pte = pte_modify(old_pte, vma->vm_page_prot);
 	pte = pte_mkyoung(pte);
 	if (was_writable)
 		pte = pte_mkwrite(pte);
-	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
-	update_mmu_cache(vma, vmf->address, vmf->pte);
+	ptep_modify_prot_commit(vma, fault_address, vmf->pte, old_pte, pte);
+	update_mmu_cache(vma, fault_address, vmf->pte);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	goto out;
 }
-- 
2.27.0

