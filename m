Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF05C3BC6E4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 08:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhGFGx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 02:53:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48578 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhGFGxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 02:53:55 -0400
Received: from 1.general.khfeng.us.vpn ([10.172.68.174] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1m0evI-00077K-N5; Tue, 06 Jul 2021 06:51:13 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org (open list:IOMMU DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iommu: Fallback to default setting when def_domain_type() callback returns 0
Date:   Tue,  6 Jul 2021 14:51:06 +0800
Message-Id: <20210706065106.271765-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 28b41e2c6aeb ("iommu: Move def_domain type check for untrusted
device into core") not only moved the check for untrusted device to
IOMMU core, it also introduced a behavioral change by returning
def_domain_type() directly without checking its return value. That makes
many devices no longer use the default IOMMU setting.

So revert back to the old behavior which defaults to
iommu_def_domain_type when driver callback returns 0.

Fixes: 28b41e2c6aeb ("iommu: Move def_domain type check for untrusted device into core")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/iommu/iommu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5419c4b9f27a..faac4f795025 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1507,14 +1507,15 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_group);
 static int iommu_get_def_domain_type(struct device *dev)
 {
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	unsigned int type = 0;
 
 	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
 		return IOMMU_DOMAIN_DMA;
 
 	if (ops->def_domain_type)
-		return ops->def_domain_type(dev);
+		type = ops->def_domain_type(dev);
 
-	return 0;
+	return (type == 0) ? iommu_def_domain_type : type;
 }
 
 static int iommu_group_alloc_default_domain(struct bus_type *bus,
-- 
2.31.1

