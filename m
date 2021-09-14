Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDD940A43B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 05:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbhINDQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 23:16:13 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19970 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237213AbhINDQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 23:16:12 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H7pJT2LQ9zbmW8;
        Tue, 14 Sep 2021 11:10:49 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 11:14:54 +0800
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 11:14:53 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <andraprs@amazon.com>, <lexnv@amazon.com>, <alcioa@amazon.com>
CC:     <linux-kernel@vger.kernel.org>, <arei.gonglei@huawei.com>,
        "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: [PATCH] nitro_enclaves: merge contiguous physical memory regions
Date:   Tue, 14 Sep 2021 11:14:50 +0800
Message-ID: <20210914031450.919-1-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There maybe too many physical memory regions if the memory regions
backend with 2M hugetlb pages.

Let's merge the adjacent regions if they are physical contiguous.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 drivers/virt/nitro_enclaves/ne_misc_dev.c | 64 +++++++++++++++++--------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index e21e1e8..2920f26 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -824,6 +824,11 @@ static int ne_sanity_check_user_mem_region_page(struct ne_enclave *ne_enclave,
 	return 0;
 }
 
+struct phys_contig_mem_region {
+	u64 paddr;
+	u64 size;
+};
+
 /**
  * ne_set_user_memory_region_ioctl() - Add user space memory region to the slot
  *				       associated with the current enclave.
@@ -843,9 +848,10 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 	unsigned long max_nr_pages = 0;
 	unsigned long memory_size = 0;
 	struct ne_mem_region *ne_mem_region = NULL;
-	unsigned long nr_phys_contig_mem_regions = 0;
 	struct pci_dev *pdev = ne_devs.ne_pci_dev->pdev;
-	struct page **phys_contig_mem_regions = NULL;
+	struct phys_contig_mem_region *phys_regions = NULL;
+	unsigned long nr_phys_regions = 0;
+	u64 prev_phys_region_end;
 	int rc = -EINVAL;
 
 	rc = ne_sanity_check_user_mem_region(ne_enclave, mem_region);
@@ -866,9 +872,8 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 		goto free_mem_region;
 	}
 
-	phys_contig_mem_regions = kcalloc(max_nr_pages, sizeof(*phys_contig_mem_regions),
-					  GFP_KERNEL);
-	if (!phys_contig_mem_regions) {
+	phys_regions = kcalloc(max_nr_pages, sizeof(*phys_regions), GFP_KERNEL);
+	if (!phys_regions) {
 		rc = -ENOMEM;
 
 		goto free_mem_region;
@@ -903,25 +908,29 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 
 		/*
 		 * TODO: Update once handled non-contiguous memory regions
-		 * received from user space or contiguous physical memory regions
-		 * larger than 2 MiB e.g. 8 MiB.
+		 * received from user space.
 		 */
-		phys_contig_mem_regions[i] = ne_mem_region->pages[i];
+		if (nr_phys_regions &&
+		    prev_phys_region_end == page_to_phys(ne_mem_region->pages[i]))
+			phys_regions[nr_phys_regions - 1].size +=
+							page_size(ne_mem_region->pages[i]);
+		else {
+			phys_regions[nr_phys_regions].paddr =
+							page_to_phys(ne_mem_region->pages[i]);
+			phys_regions[nr_phys_regions].size =
+							page_size(ne_mem_region->pages[i]);
+			nr_phys_regions++;
+		}
+
+		prev_phys_region_end = phys_regions[nr_phys_regions - 1].paddr +
+					phys_regions[nr_phys_regions - 1].size;
 
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
+	if ((ne_enclave->nr_mem_regions + nr_phys_regions) > ne_enclave->max_mem_regions) {
 		dev_err_ratelimited(ne_misc_dev.this_device,
 				    "Reached max memory regions %lld\n",
 				    ne_enclave->max_mem_regions);
@@ -931,11 +940,8 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 		goto put_pages;
 	}
 
-	for (i = 0; i < nr_phys_contig_mem_regions; i++) {
-		u64 phys_region_addr = page_to_phys(phys_contig_mem_regions[i]);
-		u64 phys_region_size = page_size(phys_contig_mem_regions[i]);
-
-		if (phys_region_size & (NE_MIN_MEM_REGION_SIZE - 1)) {
+	for (i = 0; i < nr_phys_regions; i++) {
+		if (phys_regions[i].size & (NE_MIN_MEM_REGION_SIZE - 1)) {
 			dev_err_ratelimited(ne_misc_dev.this_device,
 					    "Physical mem region size is not multiple of 2 MiB\n");
 
@@ -944,7 +950,7 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 			goto put_pages;
 		}
 
-		if (!IS_ALIGNED(phys_region_addr, NE_MIN_MEM_REGION_SIZE)) {
+		if (!IS_ALIGNED(phys_regions[i].paddr, NE_MIN_MEM_REGION_SIZE)) {
 			dev_err_ratelimited(ne_misc_dev.this_device,
 					    "Physical mem region address is not 2 MiB aligned\n");
 
@@ -959,13 +965,13 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 
 	list_add(&ne_mem_region->mem_region_list_entry, &ne_enclave->mem_regions_list);
 
-	for (i = 0; i < nr_phys_contig_mem_regions; i++) {
+	for (i = 0; i < nr_phys_regions; i++) {
 		struct ne_pci_dev_cmd_reply cmd_reply = {};
 		struct slot_add_mem_req slot_add_mem_req = {};
 
 		slot_add_mem_req.slot_uid = ne_enclave->slot_uid;
-		slot_add_mem_req.paddr = page_to_phys(phys_contig_mem_regions[i]);
-		slot_add_mem_req.size = page_size(phys_contig_mem_regions[i]);
+		slot_add_mem_req.paddr = phys_regions[i].paddr;
+		slot_add_mem_req.size = phys_regions[i].size;
 
 		rc = ne_do_request(pdev, SLOT_ADD_MEM,
 				   &slot_add_mem_req, sizeof(slot_add_mem_req),
@@ -974,7 +980,7 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 			dev_err_ratelimited(ne_misc_dev.this_device,
 					    "Error in slot add mem [rc=%d]\n", rc);
 
-			kfree(phys_contig_mem_regions);
+			kfree(phys_regions);
 
 			/*
 			 * Exit here without put pages as memory regions may
@@ -987,7 +993,7 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 		ne_enclave->nr_mem_regions++;
 	}
 
-	kfree(phys_contig_mem_regions);
+	kfree(phys_regions);
 
 	return 0;
 
@@ -995,7 +1001,7 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 	for (i = 0; i < ne_mem_region->nr_pages; i++)
 		put_page(ne_mem_region->pages[i]);
 free_mem_region:
-	kfree(phys_contig_mem_regions);
+	kfree(phys_regions);
 	kfree(ne_mem_region->pages);
 	kfree(ne_mem_region);
 
-- 
1.8.3.1

