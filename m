Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5D533423F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhCJPzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:55:52 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50380 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbhCJPzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:55:22 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12AFtDr5071336;
        Wed, 10 Mar 2021 09:55:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615391713;
        bh=J2qWef0WUfP/Vl5TQ9acXH6M0zbocwoIq+ewinLGc58=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RiKkWHv23agR/QWl5DElBDLyl4uuD5B+9ZgotP74tr209mY61SQfNNWCDzN5qYnox
         VHLFUpoIqz7MUp3iIyCGHDQGzQu4mjaDqNp+eYb0nwl6gDLOwfSD9U9EEjVTe598dq
         Vyq6OFWrfIdYu6WtuR/J8KoIoIYu4XKhL1hTN8Zc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12AFtDqm029819
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 09:55:13 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 09:55:07 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 09:55:06 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12AFsq5k082613;
        Wed, 10 Mar 2021 09:55:04 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH 3/4] phy: cadence-torrent: Do not configure SERDES if it's already configured
Date:   Wed, 10 Mar 2021 21:24:44 +0530
Message-ID: <20210310155445.534-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210310155445.534-1-kishon@ti.com>
References: <20210310155445.534-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not configure torrent SERDES if it's already configured.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 32 ++++++++++++++++-------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index ab51c4bf7b30..5ee1657f5a1c 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -371,6 +371,10 @@ static const struct phy_ops cdns_torrent_phy_ops = {
 	.owner		= THIS_MODULE,
 };
 
+static const struct phy_ops noop_ops = {
+	.owner		= THIS_MODULE,
+};
+
 struct cdns_reg_pairs {
 	u32 val;
 	u32 off;
@@ -2306,6 +2310,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	struct device_node *child;
 	int ret, subnodes, node = 0, i;
 	u32 total_num_lanes = 0;
+	int already_configured;
 	u8 init_dp_regmap = 0;
 	u32 phy_type;
 
@@ -2344,16 +2349,20 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = cdns_torrent_reset(cdns_phy);
-	if (ret)
-		goto clk_cleanup;
+	regmap_field_read(cdns_phy->phy_pma_cmn_ctrl_1, &already_configured);
 
-	ret = cdns_torrent_clk(cdns_phy);
-	if (ret)
-		goto clk_cleanup;
+	if (!already_configured) {
+		ret = cdns_torrent_reset(cdns_phy);
+		if (ret)
+			goto clk_cleanup;
+
+		ret = cdns_torrent_clk(cdns_phy);
+		if (ret)
+			goto clk_cleanup;
 
-	/* Enable APB */
-	reset_control_deassert(cdns_phy->apb_rst);
+		/* Enable APB */
+		reset_control_deassert(cdns_phy->apb_rst);
+	}
 
 	for_each_available_child_of_node(dev->of_node, child) {
 		struct phy *gphy;
@@ -2423,7 +2432,10 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		of_property_read_u32(child, "cdns,ssc-mode",
 				     &cdns_phy->phys[node].ssc_mode);
 
-		gphy = devm_phy_create(dev, child, &cdns_torrent_phy_ops);
+		if (!already_configured)
+			gphy = devm_phy_create(dev, child, &cdns_torrent_phy_ops);
+		else
+			gphy = devm_phy_create(dev, child, &noop_ops);
 		if (IS_ERR(gphy)) {
 			ret = PTR_ERR(gphy);
 			goto put_child;
@@ -2507,7 +2519,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		goto put_lnk_rst;
 	}
 
-	if (cdns_phy->nsubnodes > 1) {
+	if (cdns_phy->nsubnodes > 1 && !already_configured) {
 		ret = cdns_torrent_phy_configure_multilink(cdns_phy);
 		if (ret)
 			goto put_lnk_rst;
-- 
2.17.1

