Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388F2334239
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhCJPz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:55:26 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50368 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbhCJPzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:55:18 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12AFtANJ071321;
        Wed, 10 Mar 2021 09:55:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615391710;
        bh=dm+U4X4EOZxEx+9CgGj+1LJA+tv3/55FfGG9lW8Ffdk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Zhb8WPS2KOTvRel1/RxPtFnx0IhqUkyODogfUFTVgvui80jLTCyKbqo6iHIP3PgC9
         cSBElsGYwd1/5Hg6Gw+vdLjCFVoFfuD2xU1UncrCXtIlnZeu6yql+sQQixx3r+8tWb
         Yn02EpzLR1aQIYR/48q6fjA+LR6QjZyVJKNWfIk4=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12AFtAYH029708
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 09:55:10 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 09:55:10 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 09:55:10 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12AFsq5l082613;
        Wed, 10 Mar 2021 09:55:07 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-phy@lists.infradead.org>
Subject: [PATCH 4/4] phy: cadence-torrent: Explicitly request exclusive reset control
Date:   Wed, 10 Mar 2021 21:24:45 +0530
Message-ID: <20210310155445.534-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210310155445.534-1-kishon@ti.com>
References: <20210310155445.534-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change. Since the reset controls obtained in
Torrent is exclusively used by the Torrent device, use
exclusive reset control request API calls.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 5ee1657f5a1c..ff8bb4b724c0 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -2264,7 +2264,7 @@ static int cdns_torrent_reset(struct cdns_torrent_phy *cdns_phy)
 		return PTR_ERR(cdns_phy->phy_rst);
 	}
 
-	cdns_phy->apb_rst = devm_reset_control_get_optional(dev, "torrent_apb");
+	cdns_phy->apb_rst = devm_reset_control_get_optional_exclusive(dev, "torrent_apb");
 	if (IS_ERR(cdns_phy->apb_rst)) {
 		dev_err(dev, "%s: failed to get apb reset\n",
 			dev->of_node->full_name);
-- 
2.17.1

