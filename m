Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCC840C82C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 17:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbhIOPW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 11:22:57 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19985 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbhIOPWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 11:22:54 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H8kNR3SzvzbmSm;
        Wed, 15 Sep 2021 23:17:27 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 23:21:33 +0800
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.148.223) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 23:21:33 +0800
From:   "Longpeng(Mike)" <longpeng2@huawei.com>
To:     <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <arei.gonglei@huawei.com>, "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: [PATCH v1 1/2] iommu/vt-d: convert the return type of first_pte_in_page to bool
Date:   Wed, 15 Sep 2021 23:21:28 +0800
Message-ID: <20210915152129.1254-2-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
In-Reply-To: <20210915152129.1254-1-longpeng2@huawei.com>
References: <20210915152129.1254-1-longpeng2@huawei.com>
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

first_pte_in_page() returns boolean value, so let's convert its
return type to bool.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 include/linux/intel-iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 05a65eb..a590b00 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -708,7 +708,7 @@ static inline bool dma_pte_superpage(struct dma_pte *pte)
 	return (pte->val & DMA_PTE_LARGE_PAGE);
 }
 
-static inline int first_pte_in_page(struct dma_pte *pte)
+static inline bool first_pte_in_page(struct dma_pte *pte)
 {
 	return !((unsigned long)pte & ~VTD_PAGE_MASK);
 }
-- 
1.8.3.1

