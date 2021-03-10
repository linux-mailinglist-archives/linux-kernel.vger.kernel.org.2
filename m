Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5643341F0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbhCJPqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:46:47 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43792 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbhCJPqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:46:23 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12AFkIfu117261;
        Wed, 10 Mar 2021 09:46:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615391178;
        bh=OsKa0EDwQKMOxN4rn2UsJ4wTaESxeSKXJwtpa+eVAPs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=AtZ3bIh+10iAM0fNznHbBw845yGKpgVo6EJCd1H/v5rBVjZAOwqWEstKb6FHgGDaS
         UrynFz4tR41Z9P+zZb9Sr/X8XMjRl4yKhARUDnVI6jArytn985vi+bgShPRJR6GEZE
         mZvxlDFHGfHgH6ShRNormwBW+zzrj7iY5jdXBENw=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12AFkIKE014694
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 09:46:18 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 09:46:18 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 09:46:18 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12AFk2KS066370;
        Wed, 10 Mar 2021 09:46:15 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v6 04/13] phy: ti: j721e-wiz: Get PHY properties only for "phy" or "link" subnode
Date:   Wed, 10 Mar 2021 21:15:49 +0530
Message-ID: <20210310154558.32078-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210310154558.32078-1-kishon@ti.com>
References: <20210310154558.32078-1-kishon@ti.com>
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

