Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C015C30BA61
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhBBIyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:54:31 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11671 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhBBIy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:54:26 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DVJTY5ChTzlDXp;
        Tue,  2 Feb 2021 16:52:01 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.184.42) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Feb 2021 16:53:33 +0800
From:   Keqian Zhu <zhukeqian1@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>
CC:     Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Marc Zyngier <maz@kernel.org>, <wanghaibin.wang@huawei.com>,
        <jiangkunkun@huawei.com>
Subject: [PATCH] iommu: Update the document of IOMMU_DOMAIN_UNMANAGED
Date:   Tue, 2 Feb 2021 16:53:30 +0800
Message-ID: <20210202085330.31716-1-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.184.42]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
---
 include/linux/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 77e561ed57fd..e8f2efae212b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -68,7 +68,7 @@ struct iommu_domain_geometry {
  *				  devices
  *	IOMMU_DOMAIN_IDENTITY	- DMA addresses are system physical addresses
  *	IOMMU_DOMAIN_UNMANAGED	- DMA mappings managed by IOMMU-API user, used
- *				  for VMs
+ *				  for VMs or userspace driver frameworks
  *	IOMMU_DOMAIN_DMA	- Internally used for DMA-API implementations.
  *				  This flag allows IOMMU drivers to implement
  *				  certain optimizations for these domains
-- 
2.19.1

