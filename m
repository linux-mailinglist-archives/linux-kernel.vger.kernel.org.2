Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93903341F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhCJPqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:46:54 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43896 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbhCJPql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:46:41 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12AFka7h117406;
        Wed, 10 Mar 2021 09:46:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615391196;
        bh=Fr9ZyGLW31JmJAp0IyWK9eWBsQt1ma4OyJ8An42gTxI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=y2PMiwzWjSsQKas+utyxD1tTNlJ+/l6LepdDa/RqgMy4dvl/WaE5034Qe2Q5YVqry
         2y/PIhXdlPoa/hUQhki9kLnEshpWVV6z73VG/epYHuVgvQwKtWUTzYWtf119dlvfv1
         BfFZemAtAYrpOs6U4mD0Siy+s5PdfbxqTm/hrgrA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12AFkapM015130
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 09:46:36 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 09:46:36 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 09:46:36 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12AFk2KY066370;
        Wed, 10 Mar 2021 09:46:33 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v6 10/13] phy: cadence: cadence-sierra: Add missing clk_disable_unprepare() in .remove callback
Date:   Wed, 10 Mar 2021 21:15:55 +0530
Message-ID: <20210310154558.32078-11-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210310154558.32078-1-kishon@ti.com>
References: <20210310154558.32078-1-kishon@ti.com>
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

