Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE58E341D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhCSMo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:44:58 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46292 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhCSMoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:44:23 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12JCgDSM108055;
        Fri, 19 Mar 2021 07:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616157733;
        bh=Fr9ZyGLW31JmJAp0IyWK9eWBsQt1ma4OyJ8An42gTxI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=AJR8yKasr6kTdlxOcUL9EOLzvJAPgRwH1APAop2UP4TBusht9EvzIlmwDf93mqk6I
         jBofg6w9IhZRXYeDEej2HbWPbGvn4LS6Kp9RdPVy/n3rHqV5Ge7zAIqtcLOIY+/UjT
         K/28xNYpHmU5Gfmn5xVe24Vp+9TwRyF7a08t8d80=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12JCgDXo125451
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Mar 2021 07:42:13 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 19
 Mar 2021 07:42:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 19 Mar 2021 07:42:13 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12JCfTfB011913;
        Fri, 19 Mar 2021 07:42:09 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v7 10/13] phy: cadence: Sierra: Add missing clk_disable_unprepare() in .remove callback
Date:   Fri, 19 Mar 2021 18:11:25 +0530
Message-ID: <20210319124128.13308-11-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210319124128.13308-1-kishon@ti.com>
References: <20210319124128.13308-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 44d30d622821 ("phy: cadence: Add driver for Sierra PHY") enabled
the clock in probe and failed to disable in remove callback. Add missing
clk_disable_unprepare() in cdns_sierra_phy_remove().

Fixes: 44d30d622821 ("phy: cadence: Add driver for Sierra PHY")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index a45278c30948..ac32b7b0289f 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -689,6 +689,9 @@ static int cdns_sierra_phy_remove(struct platform_device *pdev)
 		reset_control_assert(phy->phys[i].lnk_rst);
 		reset_control_put(phy->phys[i].lnk_rst);
 	}
+
+	clk_disable_unprepare(phy->input_clks[PHY_CLK]);
+
 	return 0;
 }
 
-- 
2.17.1

