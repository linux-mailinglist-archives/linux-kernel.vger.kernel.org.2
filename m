Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316AC34E5FE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhC3LCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:02:37 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44578 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhC3LCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:02:19 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12UB1uUX058333;
        Tue, 30 Mar 2021 06:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617102116;
        bh=zVbm80RW9znWpWAXSvX145Ca/gV7RBbyfBNgpqlberw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=i+PtOoQ5w+hwWlXhXJeVBthStrFkR0EjX6mi5mY2Sc6PF/9s/htzsfJvs7TptC1av
         nsCNj1a5wDrMS9X8CEIzGcfxCcXw2ittNwPAEqTI1E77sDlTjBVT8TkSq1NyevH+ip
         eQTEKNZR+0bcNbKdw5qhgHhUWXOLd3ri030nni/k=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12UB1uQ0013153
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Mar 2021 06:01:56 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 30
 Mar 2021 06:01:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 30 Mar 2021 06:01:56 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12UB1dcm094447;
        Tue, 30 Mar 2021 06:01:53 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Swapnil Jakhade <sjakhade@cadence.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 4/5] phy: cadence-torrent: Explicitly request exclusive reset control
Date:   Tue, 30 Mar 2021 16:31:37 +0530
Message-ID: <20210330110138.24356-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210330110138.24356-1-kishon@ti.com>
References: <20210330110138.24356-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change. Since the reset controls obtained in
Torrent is exclusively used by the Torrent device, use
exclusive reset control request API calls.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 5ee1657f5a1c..ff8bb4b724c0 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -2264,7 +2264,7 @@ static int cdns_torrent_reset(struct cdns_torrent_phy *cdns_phy)
 		return PTR_ERR(cdns_phy->phy_rst);
 	}
 
-	cdns_phy->apb_rst = devm_reset_control_get_optional(dev, "torrent_apb");
+	cdns_phy->apb_rst = devm_reset_control_get_optional_exclusive(dev, "torrent_apb");
 	if (IS_ERR(cdns_phy->apb_rst)) {
 		dev_err(dev, "%s: failed to get apb reset\n",
 			dev->of_node->full_name);
-- 
2.17.1

