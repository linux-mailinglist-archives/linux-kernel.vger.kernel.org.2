Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843FB330724
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 06:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbhCHFIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 00:08:23 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38034 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbhCHFIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 00:08:09 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 128584la023603;
        Sun, 7 Mar 2021 23:08:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615180084;
        bh=WnJojV2RIcrSpG/FMHpx7hS8r2BmwynHcxEFLLXKjTQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lp3NZukRwThTCLbk6tP775r66fCez+U6m8bc7mYbW+Is/I2cDCW0wKqoI6QdmKgSR
         cTScH0KmUKWKmAaS/VEzijH6TOnyu0m8ocE2x+Lzim4qfqvTfq0IhFryktG8DyCcRi
         XgCtSewj3va1c7o58EgWasrWKwgHBgUnYHhN6694=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 128584E2040107
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 7 Mar 2021 23:08:04 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 7 Mar
 2021 23:08:03 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 7 Mar 2021 23:08:03 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12857aL4086547;
        Sun, 7 Mar 2021 23:08:00 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v5 06/13] phy: cadence: cadence-sierra: Move all reset_control_get*() to a separate function
Date:   Mon, 8 Mar 2021 10:37:25 +0530
Message-ID: <20210308050732.7140-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308050732.7140-1-kishon@ti.com>
References: <20210308050732.7140-1-kishon@ti.com>
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

