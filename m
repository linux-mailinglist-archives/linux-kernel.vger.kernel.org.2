Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46BC9341D32
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhCSMoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:44:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46062 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhCSMny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:43:54 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12JCfk9u107966;
        Fri, 19 Mar 2021 07:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616157706;
        bh=oB57UEadB4VXPn/zIn4lhlpYZUctvKVQXN5TmcBzqmU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KY0US6pTmvVkiWKHdcWadcTO2omgPFQ9EBNwoMw0PWHWjeHpOMy2sS456NZXSLZtv
         BGjQr0Np/ME6LlM8Qi/rENHmExKLRsFjSKd6mT9Gbv8JWj9Epp/sh3w084xVUnIgTs
         f9axkXSIvrgBvnbF1CnIUrCjozLopggDWb0+S13g=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12JCfkZG047308
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Mar 2021 07:41:46 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 19
 Mar 2021 07:41:45 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 19 Mar 2021 07:41:45 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12JCfTf4011913;
        Fri, 19 Mar 2021 07:41:42 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v7 03/13] phy: cadence: Sierra: Create PHY only for "phy" or "link" sub-nodes
Date:   Fri, 19 Mar 2021 18:11:18 +0530
Message-ID: <20210319124128.13308-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210319124128.13308-1-kishon@ti.com>
References: <20210319124128.13308-1-kishon@ti.com>
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
Reviewed-by: Swapnil Jakhade <sjakhade@cadence.com>
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

