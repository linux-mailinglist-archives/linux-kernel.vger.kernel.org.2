Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B2845D4E2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 07:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348156AbhKYGn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 01:43:26 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:15864 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346209AbhKYGlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 01:41:24 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J07V11J2jz91C3;
        Thu, 25 Nov 2021 14:37:45 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 25 Nov 2021 14:38:12 +0800
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 25 Nov 2021 14:38:11 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <nandhini.srikandan@intel.com>, <rashmi.a@intel.com>,
        <kishon@ti.com>, <vkoul@kernel.org>
CC:     <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] phy: intel: Remove redundant dev_err call in thunderbay_emmc_phy_probe()
Date:   Thu, 25 Nov 2021 14:38:09 +0800
Message-ID: <1637822289-24534-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/phy/intel/phy-intel-thunderbay-emmc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/phy/intel/phy-intel-thunderbay-emmc.c b/drivers/phy/intel/phy-intel-thunderbay-emmc.c
index 2d6ea84..593f697 100644
--- a/drivers/phy/intel/phy-intel-thunderbay-emmc.c
+++ b/drivers/phy/intel/phy-intel-thunderbay-emmc.c
@@ -472,10 +472,8 @@ static int thunderbay_emmc_phy_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	tbh_phy->reg_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(tbh_phy->reg_base)) {
-		dev_err(&pdev->dev, "region map failed\n");
+	if (IS_ERR(tbh_phy->reg_base))
 		return PTR_ERR(tbh_phy->reg_base);
-	}
 
 	tbh_phy->phy_power_sts = PHY_UNINITIALIZED;
 	id = of_match_node(thunderbay_emmc_phy_of_match, pdev->dev.of_node);
-- 
2.6.2

