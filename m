Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBE44442F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 15:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhKCODd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 10:03:33 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:25354 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbhKCOD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 10:03:26 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HkpFl2FJ7zbhN9;
        Wed,  3 Nov 2021 21:55:55 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 22:00:39 +0800
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 22:00:39 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <andraprs@amazon.com>, <lexnv@amazon.com>, <alcioa@amazon.com>
CC:     <arei.gonglei@huawei.com>, <gregkh@linuxfoundation.org>,
        <kamal@canonical.com>, <pbonzini@redhat.com>,
        <sgarzare@redhat.com>, <stefanha@redhat.com>,
        <vkuznets@redhat.com>, <linux-kernel@vger.kernel.org>,
        <ne-devel-upstream@amazon.com>, Longpeng <longpeng2@huawei.com>
Subject: [PATCH v4 1/4] nitro_enclaves: Merge contiguous physical memory regions
Date:   Wed, 3 Nov 2021 22:00:32 +0800
Message-ID: <20211103140035.2001-2-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
In-Reply-To: <20211103140035.2001-1-longpeng2@huawei.com>
References: <20211103140035.2001-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Longpeng <longpeng2@huawei.com>

There can be cases when there are more memory regions that need to be
set for an enclave than the maximum supported number of memory regions
per enclave. One example can be when the memory regions are backed by 2
MiB hugepages (the minimum supported hugepage size).

Let's merge the adjacent regions if they are physically contiguous. This
way the final number of memory regions is less than before merging and
could potentially avoid reaching maximum.

Signed-off-by: Longpeng <longpeng2@huawei.com>
---
Changes v3 -> v4:
  - move "#include <linux/range.h>" according to the alphabetical order. [Andra]
  - rename several variables, parameters, structures and functions.  [Andra]
  - add missing "Context" in the comments.  [Andra]
  - some other changes to makes the code much neater.  [Andra]

Changes v2 -> v3:
  - update the commit title and commit message.  [Andra]
  - use 'struct range' to instead of 'struct phys_mem_region'.  [Andra, Greg KH]
  - add comments before the function definition.  [Andra]
  - rename several variables, parameters and function.  [Andra]
---
 drivers/virt/nitro_enclaves/ne_misc_dev.c | 83 ++++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 28 deletions(-)

diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index e21e1e8..b7d2116 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -24,6 +24,7 @@
 #include <linux/nitro_enclaves.h>
 #include <linux/pci.h>
 #include <linux/poll.h>
+#include <linux/range.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <uapi/linux/vm_sockets.h>
@@ -126,6 +127,16 @@ struct ne_cpu_pool {
 static struct ne_cpu_pool ne_cpu_pool;
 
 /**
+ * struct ne_phys_contig_mem_regions - Physical contiguous memory regions
+ * @num:	The number of regions that currently has.
+ * @regions:	The array of physical memory regions.
+ */
+struct ne_phys_contig_mem_regions {
+	unsigned long num;
+	struct range  *regions;
+};
+
+/**
  * ne_check_enclaves_created() - Verify if at least one enclave has been created.
  * @void:	No parameters provided.
  *
@@ -825,6 +836,33 @@ static int ne_sanity_check_user_mem_region_page(struct ne_enclave *ne_enclave,
 }
 
 /**
+ * ne_merge_phys_contig_memory_regions() - Add a memory region and merge the adjacent
+ *                                         regions if they are physically contiguous.
+ * @phys_contig_regions : Private data associated with the contiguous physical memory regions.
+ * @page_paddr :          Physical start address of the region to be added.
+ * @page_size :           Length of the region to be added.
+ *
+ * Context: Process context. This function is called with the ne_enclave mutex held.
+ */
+static void
+ne_merge_phys_contig_memory_regions(struct ne_phys_contig_mem_regions *phys_contig_regions,
+				    u64 page_paddr, u64 page_size)
+{
+	unsigned long num = phys_contig_regions->num;
+
+	/* Physically contiguous, just merge */
+	if (num && (phys_contig_regions->regions[num - 1].end + 1) == page_paddr) {
+		phys_contig_regions->regions[num - 1].end += page_size;
+
+		return;
+	}
+
+	phys_contig_regions->regions[num].start = page_paddr;
+	phys_contig_regions->regions[num].end = page_paddr + page_size - 1;
+	phys_contig_regions->num++;
+}
+
+/**
  * ne_set_user_memory_region_ioctl() - Add user space memory region to the slot
  *				       associated with the current enclave.
  * @ne_enclave :	Private data associated with the current enclave.
@@ -843,9 +881,8 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 	unsigned long max_nr_pages = 0;
 	unsigned long memory_size = 0;
 	struct ne_mem_region *ne_mem_region = NULL;
-	unsigned long nr_phys_contig_mem_regions = 0;
 	struct pci_dev *pdev = ne_devs.ne_pci_dev->pdev;
-	struct page **phys_contig_mem_regions = NULL;
+	struct ne_phys_contig_mem_regions phys_contig_mem_regions = {};
 	int rc = -EINVAL;
 
 	rc = ne_sanity_check_user_mem_region(ne_enclave, mem_region);
@@ -866,9 +903,9 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 		goto free_mem_region;
 	}
 
-	phys_contig_mem_regions = kcalloc(max_nr_pages, sizeof(*phys_contig_mem_regions),
-					  GFP_KERNEL);
-	if (!phys_contig_mem_regions) {
+	phys_contig_mem_regions.regions = kcalloc(max_nr_pages,
+				sizeof(*phys_contig_mem_regions.regions), GFP_KERNEL);
+	if (!phys_contig_mem_regions.regions) {
 		rc = -ENOMEM;
 
 		goto free_mem_region;
@@ -901,26 +938,16 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 		if (rc < 0)
 			goto put_pages;
 
-		/*
-		 * TODO: Update once handled non-contiguous memory regions
-		 * received from user space or contiguous physical memory regions
-		 * larger than 2 MiB e.g. 8 MiB.
-		 */
-		phys_contig_mem_regions[i] = ne_mem_region->pages[i];
+		ne_merge_phys_contig_memory_regions(&phys_contig_mem_regions,
+						    page_to_phys(ne_mem_region->pages[i]),
+						    page_size(ne_mem_region->pages[i]));
 
 		memory_size += page_size(ne_mem_region->pages[i]);
 
 		ne_mem_region->nr_pages++;
 	} while (memory_size < mem_region.memory_size);
 
-	/*
-	 * TODO: Update once handled non-contiguous memory regions received
-	 * from user space or contiguous physical memory regions larger than
-	 * 2 MiB e.g. 8 MiB.
-	 */
-	nr_phys_contig_mem_regions = ne_mem_region->nr_pages;
-
-	if ((ne_enclave->nr_mem_regions + nr_phys_contig_mem_regions) >
+	if ((ne_enclave->nr_mem_regions + phys_contig_mem_regions.num) >
 	    ne_enclave->max_mem_regions) {
 		dev_err_ratelimited(ne_misc_dev.this_device,
 				    "Reached max memory regions %lld\n",
@@ -931,9 +958,9 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 		goto put_pages;
 	}
 
-	for (i = 0; i < nr_phys_contig_mem_regions; i++) {
-		u64 phys_region_addr = page_to_phys(phys_contig_mem_regions[i]);
-		u64 phys_region_size = page_size(phys_contig_mem_regions[i]);
+	for (i = 0; i < phys_contig_mem_regions.num; i++) {
+		u64 phys_region_addr = phys_contig_mem_regions.regions[i].start;
+		u64 phys_region_size = range_len(&phys_contig_mem_regions.regions[i]);
 
 		if (phys_region_size & (NE_MIN_MEM_REGION_SIZE - 1)) {
 			dev_err_ratelimited(ne_misc_dev.this_device,
@@ -959,13 +986,13 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 
 	list_add(&ne_mem_region->mem_region_list_entry, &ne_enclave->mem_regions_list);
 
-	for (i = 0; i < nr_phys_contig_mem_regions; i++) {
+	for (i = 0; i < phys_contig_mem_regions.num; i++) {
 		struct ne_pci_dev_cmd_reply cmd_reply = {};
 		struct slot_add_mem_req slot_add_mem_req = {};
 
 		slot_add_mem_req.slot_uid = ne_enclave->slot_uid;
-		slot_add_mem_req.paddr = page_to_phys(phys_contig_mem_regions[i]);
-		slot_add_mem_req.size = page_size(phys_contig_mem_regions[i]);
+		slot_add_mem_req.paddr = phys_contig_mem_regions.regions[i].start;
+		slot_add_mem_req.size = range_len(&phys_contig_mem_regions.regions[i]);
 
 		rc = ne_do_request(pdev, SLOT_ADD_MEM,
 				   &slot_add_mem_req, sizeof(slot_add_mem_req),
@@ -974,7 +1001,7 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 			dev_err_ratelimited(ne_misc_dev.this_device,
 					    "Error in slot add mem [rc=%d]\n", rc);
 
-			kfree(phys_contig_mem_regions);
+			kfree(phys_contig_mem_regions.regions);
 
 			/*
 			 * Exit here without put pages as memory regions may
@@ -987,7 +1014,7 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 		ne_enclave->nr_mem_regions++;
 	}
 
-	kfree(phys_contig_mem_regions);
+	kfree(phys_contig_mem_regions.regions);
 
 	return 0;
 
@@ -995,7 +1022,7 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 	for (i = 0; i < ne_mem_region->nr_pages; i++)
 		put_page(ne_mem_region->pages[i]);
 free_mem_region:
-	kfree(phys_contig_mem_regions);
+	kfree(phys_contig_mem_regions.regions);
 	kfree(ne_mem_region->pages);
 	kfree(ne_mem_region);
 
-- 
1.8.3.1

