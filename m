Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A3632CB92
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 05:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhCDEoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 23:44:12 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36674 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbhCDEne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 23:43:34 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1244ft6u101885;
        Wed, 3 Mar 2021 22:41:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1614832915;
        bh=X8lkmYvm2LZftzAI7MPmXYXTlNDPCOiWt9wiFwCLMFg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pRdjO5KPEHF8ppV53opfdqEHibqTcObpnt6+5WO46MHzwJeRSregGvBnaMelnCF6M
         8rOE3r5Dl1kE4I53XRgCDlfZtsBUqkLfOyQKJk6Zf5kZzMZFMI3rAznbumsZRrdHS4
         F6Bh1pyEwq4RWeZMfm88ad/AG1V7EvUT11TwoRhU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1244ftvE088301
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 Mar 2021 22:41:55 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 3 Mar
 2021 22:41:55 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 3 Mar 2021 22:41:55 -0600
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1244fQfo042911;
        Wed, 3 Mar 2021 22:41:52 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v4 07/13] phy: cadence: cadence-sierra: Explicitly request exclusive reset control
Date:   Thu, 4 Mar 2021 10:11:16 +0530
Message-ID: <20210304044122.15166-8-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210304044122.15166-1-kishon@ti.com>
References: <20210304044122.15166-1-kishon@ti.com>
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

