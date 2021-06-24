Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05AB3B35F1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 20:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhFXSoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 14:44:00 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41514 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhFXSny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 14:43:54 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15OIfOTw028676;
        Thu, 24 Jun 2021 13:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1624560084;
        bh=pEYv/cVE8dpSFqbeMd7nSL6UuSjcYO8ph/UZQDKS7+g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BVUI5Gfyfsf0T/wpgVpifLysKV5HCcdTvI9Hn6+ldp57PnSawo0/UdvkFArQA/dNM
         RCqgpFBxwgAmreBc28a+Yb9ExdDNADqdHfz/dA6Rq7OmsmR+Txk8kZvxVuoiGpEDJH
         DzK1Z0+qsmrA5hBlAIeIGdvN2imX3xDqeXUmbJSc=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15OIfOAd034296
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jun 2021 13:41:24 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 24
 Jun 2021 13:41:24 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 24 Jun 2021 13:41:23 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15OIf9I0041395;
        Thu, 24 Jun 2021 13:41:21 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Nikhil Devshatwar <nikhil.nd@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Peter Chen <peter.chen@nxp.com>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
Subject: [PATCH v3 3/7] phy: cdns-dphy: Allow setting mode
Date:   Fri, 25 Jun 2021 00:11:04 +0530
Message-ID: <20210624184108.21312-4-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210624184108.21312-1-p.yadav@ti.com>
References: <20210624184108.21312-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow callers to set the PHY mode. The main mode should always be
PHY_MODE_MIPI_DPHY but the submode can either be
PHY_MIPI_DPHY_SUBMODE_RX or PHY_MIPI_DPHY_SUBMODE_TX. Update the ops
based on the requested submode.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---

(no changes since v1)

 drivers/phy/cadence/cdns-dphy.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
index 8656f2102a91..7d5f7b333893 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -365,11 +365,41 @@ static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 	return 0;
 }
 
+static int cdns_dphy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
+{
+	struct cdns_dphy *dphy = phy_get_drvdata(phy);
+	const struct cdns_dphy_driver_data *ddata;
+
+	ddata = of_device_get_match_data(dphy->dev);
+	if (!ddata)
+		return -EINVAL;
+
+	if (mode != PHY_MODE_MIPI_DPHY)
+		return -EINVAL;
+
+	if (submode == PHY_MIPI_DPHY_SUBMODE_TX) {
+		if (!ddata->tx)
+			return -EOPNOTSUPP;
+
+		dphy->ops = ddata->tx;
+	} else if (submode == PHY_MIPI_DPHY_SUBMODE_RX) {
+		if (!ddata->rx)
+			return -EOPNOTSUPP;
+
+		dphy->ops = ddata->rx;
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static const struct phy_ops cdns_dphy_ops = {
 	.configure	= cdns_dphy_configure,
 	.validate	= cdns_dphy_validate,
 	.power_on	= cdns_dphy_power_on,
 	.power_off	= cdns_dphy_power_off,
+	.set_mode	= cdns_dphy_set_mode,
 };
 
 static int cdns_dphy_probe(struct platform_device *pdev)
-- 
2.30.0

