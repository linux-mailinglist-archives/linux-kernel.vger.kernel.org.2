Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB994260E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 02:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238736AbhJHAGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 20:06:51 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:27961 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbhJHAGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 20:06:50 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HQSxp5ksLzbn6R;
        Fri,  8 Oct 2021 08:00:30 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 8 Oct 2021 08:04:46 +0800
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 8 Oct 2021 08:04:45 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>,
        <will@kernel.org>, <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <arei.gonglei@huawei.com>, "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: [PATCH v3 1/2] iommu/vt-d: convert the return type of first_pte_in_page to bool
Date:   Fri, 8 Oct 2021 08:04:32 +0800
Message-ID: <20211008000433.1115-2-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
In-Reply-To: <20211008000433.1115-1-longpeng2@huawei.com>
References: <20211008000433.1115-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

first_pte_in_page() returns boolean value, so let's convert its
return type to bool. In addition, use 'IS_ALIGNED' to make the
code more readable and neater.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 include/linux/intel-iommu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 05a65eb..9bcabc7 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -708,9 +708,9 @@ static inline bool dma_pte_superpage(struct dma_pte *pte)
 	return (pte->val & DMA_PTE_LARGE_PAGE);
 }
 
-static inline int first_pte_in_page(struct dma_pte *pte)
+static inline bool first_pte_in_page(struct dma_pte *pte)
 {
-	return !((unsigned long)pte & ~VTD_PAGE_MASK);
+	return IS_ALIGNED((unsigned long)pte, VTD_PAGE_SIZE);
 }
 
 extern struct dmar_drhd_unit * dmar_find_matched_drhd_unit(struct pci_dev *dev);
-- 
1.8.3.1

