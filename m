Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A574039E2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351658AbhIHMbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:31:51 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:55798 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349077AbhIHMbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:31:02 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1886dhaZ030393;
        Wed, 8 Sep 2021 05:29:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=tJtYKtNa3Fe2TI4Sez7Y34iukTiR0gj2KRltAejTDnY=;
 b=kr2iPL1m4pIC54SnOHY8Z3kI9Btb3RpH1MBPfgDLUov9XKUV59pCMlfZdHC60QN+lGYf
 j5fqayCRzIPLdWkyRea1a44NlJqZ6YJkLUPjIw86hE9JMy2s6zs2c3r80/XNPnfQYwUd
 LHTTrJozq76odfjw4hpEePeCqtWmnUi3tQgqNWoRkHzJIllqViT05rktIkupVsGDshCf
 MO3siz/Ohobe5lCMqlr71GomDWO0RVCdnDblmrO6URfqehCMMmEZxkdjqyPL6FmLDkPC
 zBQatRXT+HnGy52me6tShUKAX+Ksnq9OQEVFI8TPwpAbjLso/BlXyzFHPzDyWJ/xDFWZ 8A== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3axcn5b0xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 05:29:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnVRaatG37f0Dfu1OJEwd7zheEP+XUk6QZLzPaLoUqHK+xnlAOrYwap7AgtbODDpUOqxb3uWPHP+Xuh40jc/YjdyWStrMIWtwFD2AD3tEzTncEodloW0urcnQdtihhTX96eSxI13mg2Ueuut5IM8Tt6mCLeB/8SzNGL/2ybU8AQeowk13zh5BFihr4MCwfshklC23dD19ZtUniJ/suQQB7173+QYydIW0JA/TOey0xdUoPytYi3iPQ5G9Oo/jhXVNDFYeatfKRIjk32EeraRF3xK17DgfCfChyGGgUKLrEzUYwvGH75yz6eu7d/+GENhGJNcnm3vvoYKBPjOzFVzkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=tJtYKtNa3Fe2TI4Sez7Y34iukTiR0gj2KRltAejTDnY=;
 b=ZZwrUHs3RvpP/FJoo6c3N0npPNlNywgECqPCxAjsuDxTn2UBtyAyVq4GI+y//ck7TJABgXO4xmgYKKHETtaXBgGu3LiBMF+QRfa+RS6FiTwtYB+bv3KmAspEZUaChDi8ix1C5b4G9T7DifNhuimNCFzKBNG7LvF4KR4XGqX53BM9/awuhj4vCWKYGQ/edtViUYJ+S8HF5R/nuC/B4YfINysUHxmuwdH2BYawmr3Uriss1V4jQYb+cP0B3PxgXGe6tPKCnZ8CPyr+OD295gU/uxVcDqCE/JNnDpxiX9hm0HplJxuACyd6AjCJYheasS7icZLls4nzt3pz8aksOrOxJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJtYKtNa3Fe2TI4Sez7Y34iukTiR0gj2KRltAejTDnY=;
 b=GuWqr0GHSA9AzW1mi4SXWZkZkO69c/mA5Gvvs7n9RGlxB2J7zgV3gMjbBJRO26rgunXFta5XlPPnSsOnP7i0AaBF21dmUUi2VQ+//ZIXl0CkZOGtGSzXDKgHHg+ZIVuVO7SKuG6P2YfiIhM0CAl4nTQIw6XtiJyM6f5pBO2AR58=
Received: from BN9PR03CA0949.namprd03.prod.outlook.com (2603:10b6:408:108::24)
 by CH0PR07MB8377.namprd07.prod.outlook.com (2603:10b6:610:c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 12:29:40 +0000
Received: from BN8NAM12FT026.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::21) by BN9PR03CA0949.outlook.office365.com
 (2603:10b6:408:108::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21 via Frontend
 Transport; Wed, 8 Sep 2021 12:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT026.mail.protection.outlook.com (10.13.182.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 12:29:40 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTX9R026939
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 05:29:38 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Sep 2021 14:29:33 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 8 Sep 2021 14:29:33 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 8 Sep 2021 14:29:32 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTXSw010300;
        Wed, 8 Sep 2021 14:29:33 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 188CTXSK010299;
        Wed, 8 Sep 2021 14:29:33 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH v2 08/15] phy: cadence: Sierra: Check cmn_ready assertion during PHY power on
Date:   Wed, 8 Sep 2021 14:29:23 +0200
Message-ID: <20210908122930.10224-9-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210908122930.10224-1-sjakhade@cadence.com>
References: <20210908122930.10224-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 728e7fb0-07df-4712-a727-08d972c4544d
X-MS-TrafficTypeDiagnostic: CH0PR07MB8377:
X-Microsoft-Antispam-PRVS: <CH0PR07MB8377D4AD3554673B5D8F5AF8C5D49@CH0PR07MB8377.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7TqE1qXSRjv2rkppkE0KhJBQxDfNuk7v1eEqRW1UenvaE79JdzB7CXUNkDi1J/pOQdpLF7VrS9qiZBWJzTZCfXbrm54EcaHD3dWkMuctfk/EkAsSqXpgklpmmMlwBDtbErUpa+a2wGhuN68r7hOjwJLUp0jh5eCBqt8QKXPaFmYYHYG2wABEkKd2oSuQ93Ynqjty/KGUUjOGOl7uSvWbYPuq9Xdu/0BNzshJbpChr1KTf4B7Lz+mK8zIlrKStLWmoUAB1kN3dZ7EY2kJ7qqe7TRnMx7YSFSlleYGNCXsEqxWUQ6+aEG1Lf/sX5bUVLfEfpCjMLwiyMfwM3joYD2m1kobnVWSSYhhpYLKFotVUZJoSihoFJGL7qNVqvmNQX5ZUp3J9LFuVpEddaenYRDS5uy7ELg2WWTFI7bJLlZGWzxB2FBGW3/wvZPSJHkvtQQ/r4CSsQo+vVcfr6ErC/A4nSy4VFlhrDq87MpQLBTYyhSE+DTmzztFtu73X9OJXTT2WENLxwTrtECGgXJlrZvTXTHGjRdVK1cp3HKB7c3c+Gsx5tWhShH1b7t0Zsy+8KaSTxVz5uCpTTe2DmBWwwHGsKciFviIYdmmQONOtTvtyg5Gsi/jNqimi73AXMJitf82XxVUpAr39XsuL0hvWaaawQu7CVymAdMqNYKeNP3N5OFm7cZYlPq5rYosfzSHX7mNLfHsqISZrw2S5iXct5XgqHVHzvvNNmjHQErnZiZPbgI=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36092001)(36840700001)(46966006)(47076005)(70206006)(83380400001)(8936002)(336012)(36860700001)(186003)(70586007)(2906002)(426003)(42186006)(36756003)(82740400003)(110136005)(356005)(54906003)(4326008)(2616005)(1076003)(6666004)(7636003)(316002)(82310400003)(478600001)(8676002)(86362001)(26005)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 12:29:40.1879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 728e7fb0-07df-4712-a727-08d972c4544d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT026.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR07MB8377
X-Proofpoint-ORIG-GUID: MB7OXMZ3siqfzFgGtkFJbITSMHXpJ2N1
X-Proofpoint-GUID: MB7OXMZ3siqfzFgGtkFJbITSMHXpJ2N1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_06,2021-09-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if PMA cmn_ready is set indicating the startup process is complete.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 45 ++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 4e27886e4b7f..e10ef4ecd6c7 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -151,6 +151,11 @@
 #define SIERRA_PHY_PIPE_CMN_CTRL1			0x0
 #define SIERRA_PHY_PLL_CFG				0xe
 
+/* PHY PMA common registers */
+#define SIERRA_PHY_PMA_COMMON_OFFSET(block_offset)	\
+				     (0xE000 << (block_offset))
+#define SIERRA_PHY_PMA_CMN_CTRL				0x000
+
 #define SIERRA_MACRO_ID					0x00007364
 #define SIERRA_MAX_LANES				16
 #define PLL_LOCK_TIME					100000
@@ -172,6 +177,8 @@ static const struct reg_field macro_id_type =
 				REG_FIELD(SIERRA_MACRO_ID_REG, 0, 15);
 static const struct reg_field phy_pll_cfg_1 =
 				REG_FIELD(SIERRA_PHY_PLL_CFG, 1, 1);
+static const struct reg_field pma_cmn_ready =
+				REG_FIELD(SIERRA_PHY_PMA_CMN_CTRL, 0, 0);
 static const struct reg_field pllctrl_lock =
 				REG_FIELD(SIERRA_PLLCTRL_STATUS_PREG, 0, 0);
 
@@ -280,9 +287,11 @@ struct cdns_sierra_phy {
 	struct reset_control *apb_rst;
 	struct regmap *regmap_lane_cdb[SIERRA_MAX_LANES];
 	struct regmap *regmap_phy_pcs_common_cdb;
+	struct regmap *regmap_phy_pma_common_cdb;
 	struct regmap *regmap_common_cdb;
 	struct regmap_field *macro_id_type;
 	struct regmap_field *phy_pll_cfg_1;
+	struct regmap_field *pma_cmn_ready;
 	struct regmap_field *pllctrl_lock[SIERRA_MAX_LANES];
 	struct regmap_field *cmn_refrcv_refclk_plllc1en_preg[SIERRA_NUM_CMN_PLLC];
 	struct regmap_field *cmn_refrcv_refclk_termen_preg[SIERRA_NUM_CMN_PLLC];
@@ -358,6 +367,14 @@ static const struct regmap_config cdns_sierra_phy_pcs_cmn_cdb_config = {
 	.reg_read = cdns_regmap_read,
 };
 
+static const struct regmap_config cdns_sierra_phy_pma_cmn_cdb_config = {
+	.name = "sierra_phy_pma_cmn_cdb",
+	.reg_stride = 1,
+	.fast_io = true,
+	.reg_write = cdns_regmap_write,
+	.reg_read = cdns_regmap_read,
+};
+
 static int cdns_sierra_phy_init(struct phy *gphy)
 {
 	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
@@ -435,6 +452,17 @@ static int cdns_sierra_phy_on(struct phy *gphy)
 		return ret;
 	}
 
+	/*
+	 * Wait for cmn_ready assertion
+	 * PHY_PMA_CMN_CTRL[0] == 1
+	 */
+	ret = regmap_field_read_poll_timeout(sp->pma_cmn_ready, val, val,
+					     1000, PLL_LOCK_TIME);
+	if (ret) {
+		dev_err(dev, "Timeout waiting for CMN ready\n");
+		return ret;
+	}
+
 	ret = regmap_field_read_poll_timeout(sp->pllctrl_lock[ins->mlane],
 					     val, val, 1000, PLL_LOCK_TIME);
 	if (ret < 0)
@@ -712,6 +740,14 @@ static int cdns_regfield_init(struct cdns_sierra_phy *sp)
 	}
 	sp->phy_pll_cfg_1 = field;
 
+	regmap = sp->regmap_phy_pma_common_cdb;
+	field = devm_regmap_field_alloc(dev, regmap, pma_cmn_ready);
+	if (IS_ERR(field)) {
+		dev_err(dev, "PHY_PMA_CMN_CTRL reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	sp->pma_cmn_ready = field;
+
 	for (i = 0; i < SIERRA_MAX_LANES; i++) {
 		regmap = sp->regmap_lane_cdb[i];
 		field = devm_regmap_field_alloc(dev, regmap, pllctrl_lock);
@@ -765,6 +801,15 @@ static int cdns_regmap_init_blocks(struct cdns_sierra_phy *sp,
 	}
 	sp->regmap_phy_pcs_common_cdb = regmap;
 
+	block_offset = SIERRA_PHY_PMA_COMMON_OFFSET(block_offset_shift);
+	regmap = cdns_regmap_init(dev, base, block_offset, reg_offset_shift,
+				  &cdns_sierra_phy_pma_cmn_cdb_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to init PHY PMA common CDB regmap\n");
+		return PTR_ERR(regmap);
+	}
+	sp->regmap_phy_pma_common_cdb = regmap;
+
 	return 0;
 }
 
-- 
2.26.1

