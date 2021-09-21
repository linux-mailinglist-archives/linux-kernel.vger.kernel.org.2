Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36334135E8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhIUPMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:12:18 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9897 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbhIUPMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:12:17 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HDPrk4k8Cz8xLX;
        Tue, 21 Sep 2021 23:06:14 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 21 Sep 2021 23:10:46 +0800
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 21 Sep 2021 23:10:45 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <andraprs@amazon.com>, <lexnv@amazon.com>, <alcioa@amazon.com>
CC:     <linux-kernel@vger.kernel.org>, <arei.gonglei@huawei.com>,
        <gregkh@linuxfoundation.org>, <kamal@canonical.com>,
        <pbonzini@redhat.com>, <sgarzare@redhat.com>,
        <stefanha@redhat.com>, <vkuznets@redhat.com>,
        <ne-devel-upstream@amazon.com>,
        "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: [PATCH v2 1/4] nitro_enclaves: merge contiguous physical memory regions
Date:   Tue, 21 Sep 2021 23:10:36 +0800
Message-ID: <20210921151039.1502-2-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
In-Reply-To: <20210921151039.1502-1-longpeng2@huawei.com>
References: <20210921151039.1502-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There can be cases when there are more memory regions that need to be
set for an enclave than the maximum supported number of memory regions
per enclave. One example can be when the memory regions are backed by 2
MiB hugepages (the minimum supported hugepage size).

Let's merge the adjacent regions if they are physical contiguous. This
way the final number of memory regions is less than before merging and
could potentially avoid reaching maximum.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 drivers/virt/nitro_enclaves/ne_misc_dev.c | 87 ++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 29 deletions(-)

diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index e21e1e8..a4776fc 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -126,6 +126,26 @@ struct ne_cpu_pool {
 static struct ne_cpu_pool ne_cpu_pool;
 
 /**
+ * struct phys_mem_region - Physical memory region
+ * @paddr:	The start physical address of the region.
+ * @size:	The sizeof of the region.
+ */
+struct phys_mem_region {
+	u64 paddr;
+	u64 size;
+};
+
+/**
+ * struct phys_contig_mem_region - Physical contiguous memory regions
+ * @num:	The number of regions that currently has.
+ * @region:	The array of physical memory regions.
+ */
+struct phys_contig_mem_region {
+	unsigned long num;
+	struct phys_mem_region region[0];
+};
+
+/**
  * ne_check_enclaves_created() - Verify if at least one enclave has been created.
  * @void:	No parameters provided.
  *
@@ -824,6 +844,27 @@ static int ne_sanity_check_user_mem_region_page(struct ne_enclave *ne_enclave,
 	return 0;
 }
 
+static void ne_add_phys_memory_region(struct phys_contig_mem_region *regions,
+				      u64 paddr, u64 size)
+{
+	u64 prev_phys_region_end = 0;
+
+	if (regions->num) {
+		prev_phys_region_end = regions->region[regions->num - 1].paddr +
+					regions->region[regions->num - 1].size;
+
+		/* Physical contiguous, just merge */
+		if (prev_phys_region_end == paddr) {
+			regions->region[regions->num - 1].size += size;
+			return;
+		}
+	}
+
+	regions->region[regions->num].paddr = paddr;
+	regions->region[regions->num].size = size;
+	regions->num++;
+}
+
 /**
  * ne_set_user_memory_region_ioctl() - Add user space memory region to the slot
  *				       associated with the current enclave.
@@ -843,9 +884,9 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 	unsigned long max_nr_pages = 0;
 	unsigned long memory_size = 0;
 	struct ne_mem_region *ne_mem_region = NULL;
-	unsigned long nr_phys_contig_mem_regions = 0;
 	struct pci_dev *pdev = ne_devs.ne_pci_dev->pdev;
-	struct page **phys_contig_mem_regions = NULL;
+	struct phys_contig_mem_region *phys_regions = NULL;
+	size_t size_to_alloc = 0;
 	int rc = -EINVAL;
 
 	rc = ne_sanity_check_user_mem_region(ne_enclave, mem_region);
@@ -866,9 +907,9 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 		goto free_mem_region;
 	}
 
-	phys_contig_mem_regions = kcalloc(max_nr_pages, sizeof(*phys_contig_mem_regions),
-					  GFP_KERNEL);
-	if (!phys_contig_mem_regions) {
+	size_to_alloc = sizeof(*phys_regions) + max_nr_pages * sizeof(struct phys_mem_region);
+	phys_regions = kzalloc(size_to_alloc, GFP_KERNEL);
+	if (!phys_regions) {
 		rc = -ENOMEM;
 
 		goto free_mem_region;
@@ -901,27 +942,15 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 		if (rc < 0)
 			goto put_pages;
 
-		/*
-		 * TODO: Update once handled non-contiguous memory regions
-		 * received from user space or contiguous physical memory regions
-		 * larger than 2 MiB e.g. 8 MiB.
-		 */
-		phys_contig_mem_regions[i] = ne_mem_region->pages[i];
+		ne_add_phys_memory_region(phys_regions, page_to_phys(ne_mem_region->pages[i]),
+					  page_size(ne_mem_region->pages[i]));
 
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
-	    ne_enclave->max_mem_regions) {
+	if ((ne_enclave->nr_mem_regions + phys_regions->num) > ne_enclave->max_mem_regions) {
 		dev_err_ratelimited(ne_misc_dev.this_device,
 				    "Reached max memory regions %lld\n",
 				    ne_enclave->max_mem_regions);
@@ -931,9 +960,9 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 		goto put_pages;
 	}
 
-	for (i = 0; i < nr_phys_contig_mem_regions; i++) {
-		u64 phys_region_addr = page_to_phys(phys_contig_mem_regions[i]);
-		u64 phys_region_size = page_size(phys_contig_mem_regions[i]);
+	for (i = 0; i < phys_regions->num; i++) {
+		u64 phys_region_addr = phys_regions->region[i].paddr;
+		u64 phys_region_size = phys_regions->region[i].size;
 
 		if (phys_region_size & (NE_MIN_MEM_REGION_SIZE - 1)) {
 			dev_err_ratelimited(ne_misc_dev.this_device,
@@ -959,13 +988,13 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 
 	list_add(&ne_mem_region->mem_region_list_entry, &ne_enclave->mem_regions_list);
 
-	for (i = 0; i < nr_phys_contig_mem_regions; i++) {
+	for (i = 0; i < phys_regions->num; i++) {
 		struct ne_pci_dev_cmd_reply cmd_reply = {};
 		struct slot_add_mem_req slot_add_mem_req = {};
 
 		slot_add_mem_req.slot_uid = ne_enclave->slot_uid;
-		slot_add_mem_req.paddr = page_to_phys(phys_contig_mem_regions[i]);
-		slot_add_mem_req.size = page_size(phys_contig_mem_regions[i]);
+		slot_add_mem_req.paddr = phys_regions->region[i].paddr;
+		slot_add_mem_req.size = phys_regions->region[i].size;
 
 		rc = ne_do_request(pdev, SLOT_ADD_MEM,
 				   &slot_add_mem_req, sizeof(slot_add_mem_req),
@@ -974,7 +1003,7 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 			dev_err_ratelimited(ne_misc_dev.this_device,
 					    "Error in slot add mem [rc=%d]\n", rc);
 
-			kfree(phys_contig_mem_regions);
+			kfree(phys_regions);
 
 			/*
 			 * Exit here without put pages as memory regions may
@@ -987,7 +1016,7 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 		ne_enclave->nr_mem_regions++;
 	}
 
-	kfree(phys_contig_mem_regions);
+	kfree(phys_regions);
 
 	return 0;
 
@@ -995,7 +1024,7 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 	for (i = 0; i < ne_mem_region->nr_pages; i++)
 		put_page(ne_mem_region->pages[i]);
 free_mem_region:
-	kfree(phys_contig_mem_regions);
+	kfree(phys_regions);
 	kfree(ne_mem_region->pages);
 	kfree(ne_mem_region);
 
-- 
1.8.3.1

