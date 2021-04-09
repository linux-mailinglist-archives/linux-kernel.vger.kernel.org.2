Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7399D3594AB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbhDIFfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:35:15 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:40864 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233309AbhDIFfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:35:01 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1395PpuW030900;
        Thu, 8 Apr 2021 22:34:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=pO+6e7tJaHyPUvhOkuh4cFGMKT6z2go0nP37BeKpdJE=;
 b=HrzoWlNHLg9RVy5nSdFwCqYHD7zr6RYaxhQTj3Y4SmlWtUKpjYybVbdOul64Qe1B/WRX
 TfwjbT6dP63rncOvctzMihagwu9SCzKRKlWNOFHxwZK01keu0hMFhnqfeQa/dP4V4PMx
 57vUl9xJBQxNC3nMLS+BE6mtRvvc+sHdZ0+hOynbe0cu7QvHwI+v18EjMigZbAIqkLA8
 so59/0uBaixYV/GChr501PNTL38lhNuS75wzFTdCoU2nBkNV9uxb3X0x5Hmw+oEavheJ
 IteYKEdXQ0S96ksDmSR2WG/Um/rifFfXvdnRGEAznxpgCJCmc5pcCqoh02c859C8WZdI 4w== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by mx0b-0014ca01.pphosted.com with ESMTP id 37rvb4ttht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 22:34:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCWyNa9QlfOL9gAJuOD3vCYSacojPRUmHeM0IZSWpwI/ENigWo0aGCzzJxGVnryn5gHpIXhh/WdLS/teo+oxa+oHgfqEOKeRjZtJZFvlBJllJmZKWPeyAkT4rk/BNVy9Tw5yDEKtLNqHT/vtvpBbMHc1DUMQVC4QrMIR1Ej+s6LOVNpbFxCQ7NM8kn1779SJ0EfxYWWKhAXAQ1OCxMWS4Xs/kZBxzsHbsPbzu0tLgcnSI5gzU6OhdSyyW4keYLWknzadY49POnPoxgBYtPZeqNqN9QBvjEhPEvxUEpWb1fhL4o403nEGkc5KYhI7o5JvSyUQzYd2uyf9WMvTkXhRDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO+6e7tJaHyPUvhOkuh4cFGMKT6z2go0nP37BeKpdJE=;
 b=GMd2Iuc8UjYpQEPVpzq/XzJa7lV6AnyxZSTyV4XH9Ah2hxd4qFKdZF7wvgRVtOsJyQdwxbveR5fWcZStZSB/FnHAfaWvdLSchDhmryhOwJ5RPJ8WR3xvdvrP8ysIMMOBsYg07TD5/B/MYVUkgo0xJ0U2KoTVZ1bdMxVAeIolEWCswrmylNC7zHa0pkkwGIPutg0h2fLjRwoNr3dTcYVavqbG8P856ozFnVh5wfzkizOPH0ndKThNO4Hu5PDXqC/uGYFev89XiPOJZEZMxL1JnbBQhJ/yohBqoCpP7sAyHIoc/Txe/ewdER06jVbRZ3UB5s55+tKaqZt6ps2TEle4nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO+6e7tJaHyPUvhOkuh4cFGMKT6z2go0nP37BeKpdJE=;
 b=Pqx5L7h2H9GZtKCXsW32aWmDyWSD/iWsZfwSL2I6eO7AY5vcuZYcf0CDvmXRsbf/rwpy5UUyCAf+yz1qypoSYeNnhi69k3qvvz7Y2CUlmgd15OMONM0BHyP1yp8tthpcKeTbjVmGFXTiaxrLyZQj+t5nt82fJYGCcxQdnRKwkkU=
Received: from CO2PR05CA0004.namprd05.prod.outlook.com (2603:10b6:102:2::14)
 by DM6PR07MB4155.namprd07.prod.outlook.com (2603:10b6:5:bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Fri, 9 Apr
 2021 05:34:28 +0000
Received: from MW2NAM12FT031.eop-nam12.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::9) by CO2PR05CA0004.outlook.office365.com
 (2603:10b6:102:2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.8 via Frontend
 Transport; Fri, 9 Apr 2021 05:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT031.mail.protection.outlook.com (10.13.181.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.6 via Frontend Transport; Fri, 9 Apr 2021 05:34:27 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YJ5a032749
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 22:34:26 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Apr 2021 07:34:19 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 9 Apr 2021 07:34:19 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YJoY027864;
        Fri, 9 Apr 2021 07:34:19 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1395YJba027863;
        Fri, 9 Apr 2021 07:34:19 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 09/14] phy: cadence-torrent: Add separate functions for reusable code
Date:   Fri, 9 Apr 2021 07:34:11 +0200
Message-ID: <1617946456-27773-10-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
References: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4da01c1e-e3ea-47e4-133e-08d8fb19243e
X-MS-TrafficTypeDiagnostic: DM6PR07MB4155:
X-Microsoft-Antispam-PRVS: <DM6PR07MB4155F582C8F02C60D8A16039C5739@DM6PR07MB4155.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4iek9kihAGqOrvH036KtRx+NgcHPieCeSubyVFSX4pOaQNYcQzt1EvfVH5v61sMTjGT1sDOzxnBzSGxlIm4KwQQOnuJP5kClsLOt6AoI42Qv6Ads3l7GbtoGHJgzx3QY0fP4fd/8qon0SePYkWcwk7g7GgfkFb3tSm0M6rfe2GKxWbLCeEQk0d/t3uTcZWNc/m824taACU1+nsBxY5BbQomzF91kpre3gySVCwo0fcgj7waebp2tHFDVb0xPNTBPjw3ZYjNwkoT8CzgmIxiQ67epCXoHnDCaEf+AZaMyzTL4nOPj3qpeOVswG9AfNyEoSaWAYXrpHlcFovjbz3K9zmiQIzGxKf/woyeSUXVr1z0z+ZArAAqHuM3p6RE/Qzv0X6hJq5QALtKHA5zJmYSH8bILw4D4OGVAoBnLqfqvr60rOlbltTy35EUgUPAKFEWqF5OiZdaM2AfWX7wUywXIatCKDH7cAKMF0Aikh1bDo/43Psj1wxwVG+qgWGQuHmNqYBZZG+Epr1lL0kDdRxO6iEbVhNwPFE2/DDbQ4/QJ7k0DmXYXB2i1/k6k4c74ifZjpRXBArN0QGCxrGtc9JWKbD072MZdmqLbTAvtno3EaBQ5E2FrPikRO15t01BdEqPXkBPe9u/joCn1fbuXKo1W2NMWvO/hpvTvegdcWaBU13/zI3UhMGNt9I7RUl8i+2+Z0G3tC2j6enI0WGb+peUeng==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(36092001)(36840700001)(46966006)(478600001)(7636003)(83380400001)(356005)(26005)(82740400003)(86362001)(47076005)(336012)(5660300002)(36756003)(186003)(82310400003)(2616005)(70206006)(8936002)(110136005)(6666004)(54906003)(4326008)(42186006)(426003)(316002)(8676002)(36860700001)(36906005)(70586007)(2906002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 05:34:27.3187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da01c1e-e3ea-47e4-133e-08d8fb19243e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT031.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4155
X-Proofpoint-ORIG-GUID: E9sEvbe9CCxuW1aykI1ydO1pe5JeIk4b
X-Proofpoint-GUID: E9sEvbe9CCxuW1aykI1ydO1pe5JeIk4b
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_03:2021-04-08,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104090040
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Torrent PHY driver currently supports single link DP configuration.
Prepare driver to support multilink DP configurations by adding
separate functions for common initialization sequence.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 53 +++++++++++++++--------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 69466481af26..e4dd8d1711a6 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1472,24 +1472,11 @@ static int cdns_torrent_phy_off(struct phy *phy)
 	return reset_control_assert(inst->lnk_rst);
 }
 
-static int cdns_torrent_dp_init(struct phy *phy)
+static void cdns_torrent_dp_common_init(struct cdns_torrent_phy *cdns_phy,
+					struct cdns_torrent_inst *inst)
 {
-	unsigned char lane_bits;
-	int ret;
-	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
-	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
 	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
-
-	switch (cdns_phy->ref_clk_rate) {
-	case CLK_19_2_MHZ:
-	case CLK_25_MHZ:
-	case CLK_100_MHZ:
-		/* Valid Ref Clock Rate */
-		break;
-	default:
-		dev_err(cdns_phy->dev, "Unsupported Ref Clock Rate\n");
-		return -EINVAL;
-	}
+	unsigned char lane_bits;
 
 	cdns_torrent_dp_write(regmap, PHY_AUX_CTRL, 0x0003); /* enable AUX */
 
@@ -1510,8 +1497,10 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
 	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
 
-	/* PHY PMA registers configuration functions */
-	/* Initialize PHY with max supported link rate, without SSC. */
+	/*
+	 * PHY PMA registers configuration functions
+	 * Initialize PHY with max supported link rate, without SSC.
+	 */
 	if (cdns_phy->ref_clk_rate == CLK_19_2_MHZ)
 		cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy,
 							cdns_phy->max_bit_rate,
@@ -1530,6 +1519,13 @@ static int cdns_torrent_dp_init(struct phy *phy)
 
 	/* take out of reset */
 	regmap_field_write(cdns_phy->phy_reset_ctrl, 0x1);
+}
+
+static int cdns_torrent_dp_start(struct cdns_torrent_phy *cdns_phy,
+				 struct cdns_torrent_inst *inst,
+				 struct phy *phy)
+{
+	int ret;
 
 	cdns_torrent_phy_on(phy);
 
@@ -1542,6 +1538,27 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	return ret;
 }
 
+static int cdns_torrent_dp_init(struct phy *phy)
+{
+	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
+	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
+
+	switch (cdns_phy->ref_clk_rate) {
+	case CLK_19_2_MHZ:
+	case CLK_25_MHZ:
+	case CLK_100_MHZ:
+		/* Valid Ref Clock Rate */
+		break;
+	default:
+		dev_err(cdns_phy->dev, "Unsupported Ref Clock Rate\n");
+		return -EINVAL;
+	}
+
+	cdns_torrent_dp_common_init(cdns_phy, inst);
+
+	return cdns_torrent_dp_start(cdns_phy, inst, phy);
+}
+
 static int cdns_torrent_derived_refclk_enable(struct clk_hw *hw)
 {
 	struct cdns_torrent_derived_refclk *derived_refclk = to_cdns_torrent_derived_refclk(hw);
-- 
2.26.1

