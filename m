Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7745833072E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 06:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbhCHFIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 00:08:54 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38072 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbhCHFIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 00:08:22 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12858HoQ023656;
        Sun, 7 Mar 2021 23:08:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615180097;
        bh=UNoEYKDBGTzOJeT/EP06qqm1sw++l0u4ofBeIhu+mFQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kkGBMFqKaCMFT2cdpHYS0/xT5zBGCTDbhSo6LEzrSkC9V7HH13ml4JfETb/chMaB8
         4R5oOnJ9aJZt3pMjoaLx/1lKSWz6frBGXKtCuJUYLJAFVuWEjEQl+N4g6EpbI63X63
         QWMTfQ/ZvAocYTxcxpqQxOAtRO4Y/K48XjJsCgno=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12858HH4068766
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 7 Mar 2021 23:08:17 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 7 Mar
 2021 23:08:17 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 7 Mar 2021 23:08:17 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12857aL8086547;
        Sun, 7 Mar 2021 23:08:14 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v5 10/13] phy: cadence: cadence-sierra: Add missing clk_disable_unprepare() in .remove callback
Date:   Mon, 8 Mar 2021 10:37:29 +0530
Message-ID: <20210308050732.7140-11-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308050732.7140-1-kishon@ti.com>
References: <20210308050732.7140-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 44d30d622821("phy: cadence: Add driver for Sierra PHY") enabled
the clock in probe and failed to disable in remove callback. Add missing
clk_disable_unprepare() in cdns_sierra_phy_remove().

Fixes: 44d30d622821("phy: cadence: Add driver for Sierra PHY")
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

