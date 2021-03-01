Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C199327E19
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbhCAMRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 07:17:35 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13397 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbhCAMRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:17:25 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Dpzjb4CP3zjRcB;
        Mon,  1 Mar 2021 20:15:15 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Mon, 1 Mar 2021 20:16:29 +0800
From:   John Garry <john.garry@huawei.com>
To:     <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 3/3] iova: Correct comment for free_cpu_cached_iovas()
Date:   Mon, 1 Mar 2021 20:12:21 +0800
Message-ID: <1614600741-15696-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1614600741-15696-1-git-send-email-john.garry@huawei.com>
References: <1614600741-15696-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function free_cpu_cached_iovas() is not only called when a CPU is
hotplugged, so remove that part of the code comment.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iova.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index c78312560425..465b3b0eeeb0 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -996,7 +996,7 @@ static void free_iova_rcaches(struct iova_domain *iovad)
 }
 
 /*
- * free all the IOVA ranges cached by a cpu (used when cpu is unplugged)
+ * free all the IOVA ranges cached by a cpu
  */
 void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
 {
-- 
2.26.2

