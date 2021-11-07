Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A41447336
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 15:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbhKGOMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 09:12:13 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:27183 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbhKGOMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 09:12:10 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HnGKf30dkz8v9M;
        Sun,  7 Nov 2021 22:07:50 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Sun, 7 Nov 2021 22:09:23 +0800
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Sun, 7 Nov 2021 22:09:23 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <andraprs@amazon.com>, <lexnv@amazon.com>, <alcioa@amazon.com>
CC:     <arei.gonglei@huawei.com>, <gregkh@linuxfoundation.org>,
        <kamal@canonical.com>, <pbonzini@redhat.com>,
        <sgarzare@redhat.com>, <stefanha@redhat.com>,
        <vkuznets@redhat.com>, <linux-kernel@vger.kernel.org>,
        <ne-devel-upstream@amazon.com>, Longpeng <longpeng2@huawei.com>
Subject: [PATCH v5 2/4] nitro_enclaves: Sanity check physical memory regions during merging
Date:   Sun, 7 Nov 2021 22:09:15 +0800
Message-ID: <20211107140918.2106-3-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
In-Reply-To: <20211107140918.2106-1-longpeng2@huawei.com>
References: <20211107140918.2106-1-longpeng2@huawei.com>
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

From: Longpeng <longpeng2@huawei.com>

Sanity check the physical memory regions during the merge of contiguous
regions. Thus we can test the physical memory regions setup logic
individually, including the error cases coming from the sanity checks.

Signed-off-by: Longpeng <longpeng2@huawei.com>
Reviewed-by: Andra Paraschiv <andraprs@amazon.com>
---
 drivers/virt/nitro_enclaves/ne_misc_dev.c | 77 +++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 25 deletions(-)

diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index ced58de..83ed9b5 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -836,6 +836,37 @@ static int ne_sanity_check_user_mem_region_page(struct ne_enclave *ne_enclave,
 }
 
 /**
+ * ne_sanity_check_phys_mem_region() - Sanity check the start address and the size
+ *                                     of a physical memory region.
+ * @phys_mem_region_paddr : Physical start address of the region to be sanity checked.
+ * @phys_mem_region_size  : Length of the region to be sanity checked.
+ *
+ * Context: Process context. This function is called with the ne_enclave mutex held.
+ * Return:
+ * * 0 on success.
+ * * Negative return value on failure.
+ */
+static int ne_sanity_check_phys_mem_region(u64 phys_mem_region_paddr,
+					   u64 phys_mem_region_size)
+{
+	if (phys_mem_region_size & (NE_MIN_MEM_REGION_SIZE - 1)) {
+		dev_err_ratelimited(ne_misc_dev.this_device,
+				    "Physical mem region size is not multiple of 2 MiB\n");
+
+		return -EINVAL;
+	}
+
+	if (!IS_ALIGNED(phys_mem_region_paddr, NE_MIN_MEM_REGION_SIZE)) {
+		dev_err_ratelimited(ne_misc_dev.this_device,
+				    "Physical mem region address is not 2 MiB aligned\n");
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
  * ne_merge_phys_contig_memory_regions() - Add a memory region and merge the adjacent
  *                                         regions if they are physically contiguous.
  * @phys_contig_regions : Private data associated with the contiguous physical memory regions.
@@ -843,23 +874,31 @@ static int ne_sanity_check_user_mem_region_page(struct ne_enclave *ne_enclave,
  * @page_size :           Length of the region to be added.
  *
  * Context: Process context. This function is called with the ne_enclave mutex held.
+ * Return:
+ * * 0 on success.
+ * * Negative return value on failure.
  */
-static void
+static int
 ne_merge_phys_contig_memory_regions(struct ne_phys_contig_mem_regions *phys_contig_regions,
 				    u64 page_paddr, u64 page_size)
 {
 	unsigned long num = phys_contig_regions->num;
+	int rc = 0;
+
+	rc = ne_sanity_check_phys_mem_region(page_paddr, page_size);
+	if (rc < 0)
+		return rc;
 
 	/* Physically contiguous, just merge */
 	if (num && (phys_contig_regions->regions[num - 1].end + 1) == page_paddr) {
 		phys_contig_regions->regions[num - 1].end += page_size;
-
-		return;
+	} else {
+		phys_contig_regions->regions[num].start = page_paddr;
+		phys_contig_regions->regions[num].end = page_paddr + page_size - 1;
+		phys_contig_regions->num++;
 	}
 
-	phys_contig_regions->regions[num].start = page_paddr;
-	phys_contig_regions->regions[num].end = page_paddr + page_size - 1;
-	phys_contig_regions->num++;
+	return 0;
 }
 
 /**
@@ -939,9 +978,11 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 		if (rc < 0)
 			goto put_pages;
 
-		ne_merge_phys_contig_memory_regions(&phys_contig_mem_regions,
-						    page_to_phys(ne_mem_region->pages[i]),
-						    page_size(ne_mem_region->pages[i]));
+		rc = ne_merge_phys_contig_memory_regions(&phys_contig_mem_regions,
+							 page_to_phys(ne_mem_region->pages[i]),
+							 page_size(ne_mem_region->pages[i]));
+		if (rc < 0)
+			goto put_pages;
 
 		memory_size += page_size(ne_mem_region->pages[i]);
 
@@ -963,23 +1004,9 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 		u64 phys_region_addr = phys_contig_mem_regions.regions[i].start;
 		u64 phys_region_size = range_len(&phys_contig_mem_regions.regions[i]);
 
-		if (phys_region_size & (NE_MIN_MEM_REGION_SIZE - 1)) {
-			dev_err_ratelimited(ne_misc_dev.this_device,
-					    "Physical mem region size is not multiple of 2 MiB\n");
-
-			rc = -EINVAL;
-
-			goto put_pages;
-		}
-
-		if (!IS_ALIGNED(phys_region_addr, NE_MIN_MEM_REGION_SIZE)) {
-			dev_err_ratelimited(ne_misc_dev.this_device,
-					    "Physical mem region address is not 2 MiB aligned\n");
-
-			rc = -EINVAL;
-
+		rc = ne_sanity_check_phys_mem_region(phys_region_addr, phys_region_size);
+		if (rc < 0)
 			goto put_pages;
-		}
 	}
 
 	ne_mem_region->memory_size = mem_region.memory_size;
-- 
1.8.3.1

