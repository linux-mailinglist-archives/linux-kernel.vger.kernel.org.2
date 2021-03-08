Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90065330722
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 06:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhCHFIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 00:08:21 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36280 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbhCHFIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 00:08:01 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12857uJS077195;
        Sun, 7 Mar 2021 23:07:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615180076;
        bh=OsKa0EDwQKMOxN4rn2UsJ4wTaESxeSKXJwtpa+eVAPs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ypAwe6Um9TfNu1TEIq711pOm40jXtAglwNi/i2VI9FsciMMhZZbalT3Y5uNJT7Wp1
         brFFnEpPxxlsFPTp3K0pvu+QrpgxjCyHSON736Za8B08Qo+cnNq1wBkW41C9/IxLv5
         ys0dX2vv36gLUCjTV7xuiA09Vs7UHo8hb8g7/zms=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12857ucf068310
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 7 Mar 2021 23:07:56 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 7 Mar
 2021 23:07:56 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 7 Mar 2021 23:07:56 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12857aL2086547;
        Sun, 7 Mar 2021 23:07:53 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v5 04/13] phy: ti: j721e-wiz: Get PHY properties only for "phy" or "link" subnode
Date:   Mon, 8 Mar 2021 10:37:23 +0530
Message-ID: <20210308050732.7140-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308050732.7140-1-kishon@ti.com>
References: <20210308050732.7140-1-kishon@ti.com>
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

