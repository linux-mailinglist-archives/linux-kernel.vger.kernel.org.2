Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FF5341D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhCSMoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:44:23 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37310 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhCSMnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:43:51 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12JCfgpZ048289;
        Fri, 19 Mar 2021 07:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616157702;
        bh=mdVolyoxYfaWSSCfOY6AdST9Bb6eV0h2HFAlG0kSiCo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YpypftX+37WZZefVasZgkmZ9uS64WhoAI0WYom3LKWWcM9+5YYNECZj+SEea7gKBX
         IMF6Yi5Fqr4IbdWP10ITGN6/2Fg2ycbBqwEOGxaucUA76hAPGs03ne/sDdIvR9Cb0P
         NOfW+QxCOzEAz/i+GYgI1r653O/YZeGkESMXHEc4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12JCfgta090879
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Mar 2021 07:41:42 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 19
 Mar 2021 07:41:41 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 19 Mar 2021 07:41:42 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12JCfTf3011913;
        Fri, 19 Mar 2021 07:41:38 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v7 02/13] phy: ti: j721e-wiz: Invoke wiz_init() before of_platform_device_create()
Date:   Fri, 19 Mar 2021 18:11:17 +0530
Message-ID: <20210319124128.13308-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210319124128.13308-1-kishon@ti.com>
References: <20210319124128.13308-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invoke wiz_init() before configuring anything else in Sierra/Torrent
(invoked as part of of_platform_device_create()). wiz_init() resets the
SERDES device and any configuration done in the probe() of
Sierra/Torrent will be lost. In order to prevent SERDES configuration
from getting reset, invoke wiz_init() immediately before invoking
of_platform_device_create().

Fixes: 091876cc355d ("phy: ti: j721e-wiz: Add support for WIZ module present in TI J721E SoC")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Swapnil Jakhade <sjakhade@cadence.com>
Cc: <stable@vger.kernel.org> # v5.10
---
 drivers/phy/ti/phy-j721e-wiz.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 995c7dbec77b..1bb73822f44a 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -1262,27 +1262,24 @@ static int wiz_probe(struct platform_device *pdev)
 		goto err_get_sync;
 	}
 
+	ret = wiz_init(wiz);
+	if (ret) {
+		dev_err(dev, "WIZ initialization failed\n");
+		goto err_wiz_init;
+	}
+
 	serdes_pdev = of_platform_device_create(child_node, NULL, dev);
 	if (!serdes_pdev) {
 		dev_WARN(dev, "Unable to create SERDES platform device\n");
 		ret = -ENOMEM;
-		goto err_pdev_create;
-	}
-	wiz->serdes_pdev = serdes_pdev;
-
-	ret = wiz_init(wiz);
-	if (ret) {
-		dev_err(dev, "WIZ initialization failed\n");
 		goto err_wiz_init;
 	}
+	wiz->serdes_pdev = serdes_pdev;
 
 	of_node_put(child_node);
 	return 0;
 
 err_wiz_init:
-	of_platform_device_destroy(&serdes_pdev->dev, NULL);
-
-err_pdev_create:
 	wiz_clock_cleanup(wiz, node);
 
 err_get_sync:
-- 
2.17.1

