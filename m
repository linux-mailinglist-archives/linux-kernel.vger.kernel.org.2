Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E624135EB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbhIUPM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:12:28 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16279 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbhIUPMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:12:18 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HDPx723jDz8tJq;
        Tue, 21 Sep 2021 23:10:03 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 21 Sep 2021 23:10:47 +0800
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 21 Sep 2021 23:10:46 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <andraprs@amazon.com>, <lexnv@amazon.com>, <alcioa@amazon.com>
CC:     <linux-kernel@vger.kernel.org>, <arei.gonglei@huawei.com>,
        <gregkh@linuxfoundation.org>, <kamal@canonical.com>,
        <pbonzini@redhat.com>, <sgarzare@redhat.com>,
        <stefanha@redhat.com>, <vkuznets@redhat.com>,
        <ne-devel-upstream@amazon.com>,
        "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: [PATCH v2 2/4] nitro_enclaves: sanity check the physical region during setting
Date:   Tue, 21 Sep 2021 23:10:37 +0800
Message-ID: <20210921151039.1502-3-longpeng2@huawei.com>
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

Sanity check the physical region before add it to the array, this makes
the code more testable, thus we can test the physical region setup logic
individually.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 drivers/virt/nitro_enclaves/ne_misc_dev.c | 62 +++++++++++++++++--------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index a4776fc..d551b88 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -844,10 +844,28 @@ static int ne_sanity_check_user_mem_region_page(struct ne_enclave *ne_enclave,
 	return 0;
 }
 
-static void ne_add_phys_memory_region(struct phys_contig_mem_region *regions,
-				      u64 paddr, u64 size)
+static inline int ne_sanity_check_phys_mem_region(u64 paddr, u64 size)
+{
+	if (size & (NE_MIN_MEM_REGION_SIZE - 1)) {
+		dev_err_ratelimited(ne_misc_dev.this_device,
+				    "Physical mem region size is not multiple of 2 MiB\n");
+		return -EINVAL;
+	}
+
+	if (!IS_ALIGNED(paddr, NE_MIN_MEM_REGION_SIZE)) {
+		dev_err_ratelimited(ne_misc_dev.this_device,
+				    "Physical mem region address is not 2 MiB aligned\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ne_add_phys_memory_region(struct phys_contig_mem_region *regions,
+				     u64 paddr, u64 size)
 {
 	u64 prev_phys_region_end = 0;
+	int rc = 0;
 
 	if (regions->num) {
 		prev_phys_region_end = regions->region[regions->num - 1].paddr +
@@ -855,14 +873,23 @@ static void ne_add_phys_memory_region(struct phys_contig_mem_region *regions,
 
 		/* Physical contiguous, just merge */
 		if (prev_phys_region_end == paddr) {
+			rc = ne_sanity_check_phys_mem_region(paddr, size);
+			if (rc < 0)
+				return rc;
+
 			regions->region[regions->num - 1].size += size;
-			return;
+			return 0;
 		}
 	}
 
+	rc = ne_sanity_check_phys_mem_region(paddr, size);
+	if (rc < 0)
+		return rc;
+
 	regions->region[regions->num].paddr = paddr;
 	regions->region[regions->num].size = size;
 	regions->num++;
+	return 0;
 }
 
 /**
@@ -942,8 +969,10 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 		if (rc < 0)
 			goto put_pages;
 
-		ne_add_phys_memory_region(phys_regions, page_to_phys(ne_mem_region->pages[i]),
-					  page_size(ne_mem_region->pages[i]));
+		rc = ne_add_phys_memory_region(phys_regions, page_to_phys(ne_mem_region->pages[i]),
+					       page_size(ne_mem_region->pages[i]));
+		if (rc < 0)
+			goto put_pages;
 
 		memory_size += page_size(ne_mem_region->pages[i]);
 
@@ -960,29 +989,6 @@ static int ne_set_user_memory_region_ioctl(struct ne_enclave *ne_enclave,
 		goto put_pages;
 	}
 
-	for (i = 0; i < phys_regions->num; i++) {
-		u64 phys_region_addr = phys_regions->region[i].paddr;
-		u64 phys_region_size = phys_regions->region[i].size;
-
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
-			goto put_pages;
-		}
-	}
-
 	ne_mem_region->memory_size = mem_region.memory_size;
 	ne_mem_region->userspace_addr = mem_region.userspace_addr;
 
-- 
1.8.3.1

