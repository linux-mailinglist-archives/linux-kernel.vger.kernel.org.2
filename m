Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2B2350104
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 15:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbhCaNOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 09:14:48 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51346 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbhCaNOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 09:14:38 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12VDEKEu004547;
        Wed, 31 Mar 2021 08:14:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1617196460;
        bh=emzISIIaj9DN6ngJlWUurFnk/Mw6N2UJ67+bocEf8FA=;
        h=From:To:CC:Subject:Date;
        b=yRsRt2opczkiM160TTcSWE1JjumxzPh9KCBb8YyPDJvkLglNxoRfRCM+rs0qSdk8J
         bkcfatMSvOOFzxLdAWwlmojRlZhPi632vtIlMJVb5nVqIoZmpJz0p0q9dBSzgxOVpK
         9lRG7wM+h4ghpV9nNlB3p6rj+CnIHIolRIvwAijk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12VDEKFl081787
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Mar 2021 08:14:20 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 31
 Mar 2021 08:14:20 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 31 Mar 2021 08:14:20 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12VDEHLl054143;
        Wed, 31 Mar 2021 08:14:18 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH] phy: ti: j721e-wiz: Configure 'p_standard_mode' only for DP/QSGMII
Date:   Wed, 31 Mar 2021 18:44:17 +0530
Message-ID: <20210331131417.15596-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure 'p_standard_mode' only for DP/QSGMII as for other modes
it's not used as per the programming sequence. Add "continue" in the
else to prevent random value from being written to p_standard_mode.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 95905e5c4f3d..fc636233dbd6 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -340,6 +340,8 @@ static int wiz_mode_select(struct wiz *wiz)
 			mode = LANE_MODE_GEN1;
 		else if (wiz->lane_phy_type[i] == PHY_TYPE_QSGMII)
 			mode = LANE_MODE_GEN2;
+		else
+			continue;
 
 		ret = regmap_field_write(wiz->p_standard_mode[i], mode);
 		if (ret)
-- 
2.17.1

