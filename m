Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F93341D39
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 13:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhCSMob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 08:44:31 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46168 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhCSMoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 08:44:10 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12JCg1tV108007;
        Fri, 19 Mar 2021 07:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616157721;
        bh=TsbqIXJs6B38X8Auxf3dPsgKPxUh2cFtxGTPMXU1r1Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MH/ru8TIlcMGgFTsJCMW8zQQ+VM/7LVNbBrC9xUCN++JJR5K4fgnNVY/V7NMFQOUc
         feVLcekWOQmXxdDEp4B3v38epOHiXAeVS53Yv5digEoKrGesPTUnx4jqXEMUxV12tb
         8xYRcuvpQKTd4aylUfCwJrSCYdhMwSIQI/qM6YfU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12JCg1Iw124724
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Mar 2021 07:42:01 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 19
 Mar 2021 07:42:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 19 Mar 2021 07:42:01 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12JCfTf8011913;
        Fri, 19 Mar 2021 07:41:57 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v7 07/13] phy: cadence: Sierra: Explicitly request exclusive reset control
Date:   Fri, 19 Mar 2021 18:11:22 +0530
Message-ID: <20210319124128.13308-8-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210319124128.13308-1-kishon@ti.com>
References: <20210319124128.13308-1-kishon@ti.com>
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

