Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBC7330720
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 06:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbhCHFIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 00:08:20 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36262 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbhCHFH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 00:07:57 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12857rZV077188;
        Sun, 7 Mar 2021 23:07:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615180073;
        bh=VxF8kGigCKqkh77tBFluIHDcpsujh9oOUvSPK2P6qiw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EFUrGEaYjX5lsX5OEztGYkKS3d78ZfBBPEryK2HUNG4ntqNL+MQ/HrQ7jluRBn9SI
         8lEiCf9+BKCmQZw4caI+/4W/Y81xrUQsfLj1G4A8pIxixTUICw71b+0ZJgxDsS9jFZ
         eChTqSDtBqFXzbAtOgqc8uGKNjuFpUe/KboTq98E=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12857rtT068274
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 7 Mar 2021 23:07:53 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 7 Mar
 2021 23:07:52 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 7 Mar 2021 23:07:52 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12857aL1086547;
        Sun, 7 Mar 2021 23:07:49 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v5 03/13] phy: cadence: cadence-sierra: Create PHY only for "phy" or "link" sub-nodes
Date:   Mon, 8 Mar 2021 10:37:22 +0530
Message-ID: <20210308050732.7140-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308050732.7140-1-kishon@ti.com>
References: <20210308050732.7140-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cadence Sierra PHY driver registers PHY using devm_phy_create()
for all sub-nodes of Sierra device tree node. However Sierra device
tree node can have sub-nodes for the various clocks in addtion to the
PHY. Use devm_phy_create() only for nodes with name "phy" (or "link"
for old device tree) which represent the actual PHY.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 19f32ae877b9..f7ba0ed416bc 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -577,6 +577,10 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	for_each_available_child_of_node(dn, child) {
 		struct phy *gphy;
 
+		if (!(of_node_name_eq(child, "phy") ||
+		      of_node_name_eq(child, "link")))
+			continue;
+
 		sp->phys[node].lnk_rst =
 			of_reset_control_array_get_exclusive(child);
 
-- 
2.17.1

