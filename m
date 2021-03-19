Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C16341D37
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhCSMo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:44:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37462 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhCSMoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:44:05 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12JCfv4J048333;
        Fri, 19 Mar 2021 07:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616157717;
        bh=WnJojV2RIcrSpG/FMHpx7hS8r2BmwynHcxEFLLXKjTQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Z/0OYnUq8Y14U0inB4NQ9WodFC7Fx1QcyxpxgOhFOvlicQQSuAlNZJKfkHvk28XsH
         a90xE809D2H+8Bxa8+YsiJBTh3k+DF0cLN7ubTaVBlHI1uHkeKn8yj2IDlYFSVmDFj
         zDfftVyF7cqnKr/hdRNRUZjgwrnuvxG3VXdGgijM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12JCfvXf084873
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Mar 2021 07:41:57 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 19
 Mar 2021 07:41:57 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 19 Mar 2021 07:41:57 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12JCfTf7011913;
        Fri, 19 Mar 2021 07:41:54 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v7 06/13] phy: cadence: Sierra: Move all reset_control_get*() to a separate function
Date:   Fri, 19 Mar 2021 18:11:21 +0530
Message-ID: <20210319124128.13308-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210319124128.13308-1-kishon@ti.com>
References: <20210319124128.13308-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change. Group devm_reset_control_get() and
devm_reset_control_get_optional() to a separate function.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 36 ++++++++++++++++--------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 7bf1b4c7774a..935f165404e4 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -509,6 +509,28 @@ static int cdns_sierra_phy_get_clocks(struct cdns_sierra_phy *sp,
 	return 0;
 }
 
+static int cdns_sierra_phy_get_resets(struct cdns_sierra_phy *sp,
+				      struct device *dev)
+{
+	struct reset_control *rst;
+
+	rst = devm_reset_control_get(dev, "sierra_reset");
+	if (IS_ERR(rst)) {
+		dev_err(dev, "failed to get reset\n");
+		return PTR_ERR(rst);
+	}
+	sp->phy_rst = rst;
+
+	rst = devm_reset_control_get_optional(dev, "sierra_apb");
+	if (IS_ERR(rst)) {
+		dev_err(dev, "failed to get apb reset\n");
+		return PTR_ERR(rst);
+	}
+	sp->apb_rst = rst;
+
+	return 0;
+}
+
 static int cdns_sierra_phy_probe(struct platform_device *pdev)
 {
 	struct cdns_sierra_phy *sp;
@@ -559,17 +581,9 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	sp->phy_rst = devm_reset_control_get(dev, "sierra_reset");
-	if (IS_ERR(sp->phy_rst)) {
-		dev_err(dev, "failed to get reset\n");
-		return PTR_ERR(sp->phy_rst);
-	}
-
-	sp->apb_rst = devm_reset_control_get_optional(dev, "sierra_apb");
-	if (IS_ERR(sp->apb_rst)) {
-		dev_err(dev, "failed to get apb reset\n");
-		return PTR_ERR(sp->apb_rst);
-	}
+	ret = cdns_sierra_phy_get_resets(sp, dev);
+	if (ret)
+		return ret;
 
 	ret = clk_prepare_enable(sp->clk);
 	if (ret)
-- 
2.17.1

