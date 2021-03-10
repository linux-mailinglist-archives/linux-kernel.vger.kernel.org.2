Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDB93341F3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbhCJPqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:46:50 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47768 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhCJPqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:46:32 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12AFkSB1067849;
        Wed, 10 Mar 2021 09:46:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615391188;
        bh=TsbqIXJs6B38X8Auxf3dPsgKPxUh2cFtxGTPMXU1r1Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=t9NiFOqI27RHPnf8Wx84wbLaW//YiSwBHEJf7OffWCTapLrIEaQkaC8JEuU6zS69D
         iBEvruchhWL0sJIMMT/FAIqkAyJQ2jLEOq69roYUoAVvn3Rq2KMXgtpBKseDHcACCT
         AeXb/96pRIjXfpioe3u3qEYyfGUSHjljvh5Hvs1o=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12AFkSYa014983
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Mar 2021 09:46:28 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 10
 Mar 2021 09:46:27 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 10 Mar 2021 09:46:27 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12AFk2KV066370;
        Wed, 10 Mar 2021 09:46:24 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v6 07/13] phy: cadence: cadence-sierra: Explicitly request exclusive reset control
Date:   Wed, 10 Mar 2021 21:15:52 +0530
Message-ID: <20210310154558.32078-8-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210310154558.32078-1-kishon@ti.com>
References: <20210310154558.32078-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change. Since the reset controls obtained in
Sierra is exclusively used by the Sierra device, use
exclusive reset control request API calls.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 935f165404e4..44c52a0842dc 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -514,14 +514,14 @@ static int cdns_sierra_phy_get_resets(struct cdns_sierra_phy *sp,
 {
 	struct reset_control *rst;
 
-	rst = devm_reset_control_get(dev, "sierra_reset");
+	rst = devm_reset_control_get_exclusive(dev, "sierra_reset");
 	if (IS_ERR(rst)) {
 		dev_err(dev, "failed to get reset\n");
 		return PTR_ERR(rst);
 	}
 	sp->phy_rst = rst;
 
-	rst = devm_reset_control_get_optional(dev, "sierra_apb");
+	rst = devm_reset_control_get_optional_exclusive(dev, "sierra_apb");
 	if (IS_ERR(rst)) {
 		dev_err(dev, "failed to get apb reset\n");
 		return PTR_ERR(rst);
-- 
2.17.1

