Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBB132CB8D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 05:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbhCDEni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 23:43:38 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36630 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbhCDEnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 23:43:25 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1244fjH0101853;
        Wed, 3 Mar 2021 22:41:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614832905;
        bh=OsKa0EDwQKMOxN4rn2UsJ4wTaESxeSKXJwtpa+eVAPs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=a4SKKcwJSResOHBGbaSY/2zNQUKv55yQcMGxCPxxS9hc+VCrD043CixSsr7TiRtAK
         wwfv3r4PswvdS2CcmS/8c3RCe5IoNt6M4A+tirxuc09KWxbllx8CM9V69777od1Tjg
         oTCeX5OfJKvbuB4pHgbVCXja+JgOVi/Ugqs1gqMM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1244fj7j055880
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Mar 2021 22:41:45 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 3 Mar
 2021 22:41:45 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 3 Mar 2021 22:41:45 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1244fQfl042911;
        Wed, 3 Mar 2021 22:41:42 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v4 04/13] phy: ti: j721e-wiz: Get PHY properties only for "phy" or "link" subnode
Date:   Thu, 4 Mar 2021 10:11:13 +0530
Message-ID: <20210304044122.15166-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210304044122.15166-1-kishon@ti.com>
References: <20210304044122.15166-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"serdes" node (child node of WIZ) can have sub-nodes for representing links
or it can have sub-nodes for representing the various clocks within the
serdes. Instead of trying to read "reg" from every child node used for
assigning "lane_phy_type", read only if the child node's name is "phy"
or "link" subnode.
Ideally all PHY dt nodes should have node name as "phy", however
existing devicetree used "link" as subnode. So in order to maintain old
DT compatibility get PHY properties for "phy" or "link" subnode.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 1bb73822f44a..659597645201 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -1102,6 +1102,10 @@ static int wiz_get_lane_phy_types(struct device *dev, struct wiz *wiz)
 		u32 reg, num_lanes = 1, phy_type = PHY_NONE;
 		int ret, i;
 
+		if (!(of_node_name_eq(subnode, "phy") ||
+		      of_node_name_eq(subnode, "link")))
+			continue;
+
 		ret = of_property_read_u32(subnode, "reg", &reg);
 		if (ret) {
 			dev_err(dev,
-- 
2.17.1

