Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD0F330723
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 06:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhCHFIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 00:08:24 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36308 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbhCHFIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 00:08:12 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 128587V3077248;
        Sun, 7 Mar 2021 23:08:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615180087;
        bh=TsbqIXJs6B38X8Auxf3dPsgKPxUh2cFtxGTPMXU1r1Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PvNl8bYrArU2Gfmx3pDFfnCh1TMxQeqMp/M4pgKducGmhVzlujoDxVuNAPy2QPpmu
         AmXnflDg+tW3qNEo6dmJ5r4sAxOgyfYO1vs4o2uTsJVKMZg+pAfsA0zIW9WcXL6bkE
         tkpI4sqlMzpHEhGXf8kA2y4vISThLvheYc9fPfy0=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 128587gs117135
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 7 Mar 2021 23:08:07 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 7 Mar
 2021 23:08:07 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 7 Mar 2021 23:08:07 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12857aL5086547;
        Sun, 7 Mar 2021 23:08:04 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v5 07/13] phy: cadence: cadence-sierra: Explicitly request exclusive reset control
Date:   Mon, 8 Mar 2021 10:37:26 +0530
Message-ID: <20210308050732.7140-8-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308050732.7140-1-kishon@ti.com>
References: <20210308050732.7140-1-kishon@ti.com>
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

