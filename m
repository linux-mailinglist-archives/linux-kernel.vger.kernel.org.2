Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764184039D5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351303AbhIHMbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:31:06 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:32206 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1348841AbhIHMbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:31:01 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1886deXQ016935;
        Wed, 8 Sep 2021 05:29:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=+ahc9zEkbRWKLcg4An6kKo6Zb5TU8icRxkcvsrkVw3s=;
 b=sA7TYjATbCWb6q51WKvQWelLG6vOOoRo2V6Lipa+THMVFQ6FAjPEiJprPLNoMJNdmhM+
 tRbLiqVxVkravgZ+zl1h/bCHHrL3xM2PjD8oIQ6Ma0XLg6Ktzekz5T/oKey3FCxtLzDy
 PgggJW+L3zHNxc6dkAPnFVgisAmkoCTTrJBIHEjZRoZRNEhNr4hoQxm7uys3QzLUayuf
 WxT9x9FLOYYFKuRlSVmKAlQtPzBD9VfSeWJF10Ah148YykbWNxopufxbj6al8xQUUpNc
 N10hZsr6qZtymQErtqjjK4FYK2h2xP6WwMjtA8rSGwBXh7Rlw+teFO2pOxxCwIxWOkch oQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3axcp9k47x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 05:29:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TW5yvab5UUB0ClxJu/odxr3NSdmKg43qo7SiJkaWx3mVoUv5THPwudasY26Xe8Fqt8vf2Ltp7IFaXmK3ZZBqMKF/3OqnKZ4U/HTS2FB3Bq1/ZDAgi/eieekyYZQtfbMFLPMYe41N6lTu1qN1c0FqvzAZv51/XYL/e1CB9svCIGrLpc/3hTZrvKOv5bDqg40B4+iTyprnwgZTCT9BgMRJcF5V0/xf41DRzRk9CEM35jyZwNX3uC0ZG9tLCymeg14q5cG21qeR8h3PGaPX99Xu8/gMo+Tmx9dg5Whs7ECK4AN+f8wufGPKcpLWWrqnRjoKB2rzz7tjGB718UBf0KtT0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+ahc9zEkbRWKLcg4An6kKo6Zb5TU8icRxkcvsrkVw3s=;
 b=WYwAjFyvYLDK3J6CqF9SU4Lwsiy/zGdtehxmV/ZLxVHh+Xl4DUYFlpVzBP84EfvnFRbvfQhlCMwrrRdH5L6DpbZOhDbBnTKgoQPgs0V1HA1YvcT3z3eOCpfh2IY9OPXCtvElkfyrcNhQ1j1HKxu8izdtNGBnP+I1sKyS6V0mnRxbNvTgP+Of664z116epkgY9bfnKqnZCoKu3AnDH1euRafAei7Ic1Zjr2vF97clHJ0e9YdPL1CHELrzDbTK7C0T3kYeGMiZsRWy5LKos+AFtKNMuE7hG6Cg8JjN+on0pWoaTOjbt/KPaTDo7aHfGwGjm6UhiNt64Ggtq3CBHWbS6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ahc9zEkbRWKLcg4An6kKo6Zb5TU8icRxkcvsrkVw3s=;
 b=aWP1qalnwGcDzOlOrKLhAUF5ze3aG7dO3SlMerjoTr1GHNG9x2I+UImiltEJyDwPAYOYgFJuVHwyhTIOpTSa2o2KwPdsiRgUewlUuRrJf5rozUSMr59XXbzkAUyroEUYb5mGYi2ri7TQBI3PGeDoD7bdLQYnj1sIzGp0dPlionk=
Received: from MW4PR03CA0340.namprd03.prod.outlook.com (2603:10b6:303:dc::15)
 by BYAPR07MB6104.namprd07.prod.outlook.com (2603:10b6:a03:13a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 12:29:40 +0000
Received: from MW2NAM12FT046.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::81) by MW4PR03CA0340.outlook.office365.com
 (2603:10b6:303:dc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend
 Transport; Wed, 8 Sep 2021 12:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT046.mail.protection.outlook.com (10.13.181.244) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 12:29:39 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTX9Q026939
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 05:29:38 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Sep 2021 14:29:32 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 8 Sep 2021 14:29:32 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTWTu010296;
        Wed, 8 Sep 2021 14:29:32 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 188CTW4H010295;
        Wed, 8 Sep 2021 14:29:32 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH v2 07/15] phy: cadence: Sierra: Add PHY PCS common register configurations
Date:   Wed, 8 Sep 2021 14:29:22 +0200
Message-ID: <20210908122930.10224-8-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210908122930.10224-1-sjakhade@cadence.com>
References: <20210908122930.10224-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63d3e642-8d6e-4637-973b-08d972c453cf
X-MS-TrafficTypeDiagnostic: BYAPR07MB6104:
X-Microsoft-Antispam-PRVS: <BYAPR07MB610466B948F71C99D2B95909C5D49@BYAPR07MB6104.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMmNjoLfru1lS4YderEWeVAPrZ0x+pa75v40DgHW6B751QdyaacLFVDg4gDNF7rgiC2vCc6cwhAOIkucecUaJE9xqvielmkrawlNR5+Ign9OX7KxPybGtsJ7AcV84syUI21UiEpZEr2aNJ46mKTFB/r1KELm/wwctbQbHIbPiFweKipSHOTcibP/mB7fCLEjLjc4uPfO0Dauguo93ZXW+gjd6gB0T5Bb+gBMjZj+rxCyTIZXwePX1yTzjzSm7ygVwMReopFTgupPZKVAlJbCYuHKNPe2rmy9tUTABP+7AyXrTiHTQjyHMn4pa0so+9eRzjNpHB6JUM/bNrLMDR7pAeKqB+k/ZuXivbkeC5ugzCWkDSQHaiBVzgenMxcUlCeM/VqN3WRtEMTUDBvp1IEbXfofqzOIuXeQ6G76BQkQw5qwmnJWq9eLc933OwZQOm0lPe9zUPlf7tP3+zEXJUh7GI9RmoOctu87GGl2zG+Lxgb7Il6EDkF+GVnuwU1Lcpp0gkGzO7U8EqF08GHokGBGLvGJfH1KFgiPcmOOXyo5Jz0JyPYu2GSdblO0Eb9NR+/FRllDNjNvoxuo2nOrvU3ZvsbjzGbaajugRoE2e1pmPUN59YwtbKU7K1zDUIMjggWSDpOHC/+WlBW9WPFC0ht0JYLAq5JIWh7YWsvQNh7q0Z0qcQin54mb4825eDzKwt2NCxS+l56YxVUKLgNMeZqcn2YduekL0++eWX2kDV4Vd10=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(42186006)(186003)(110136005)(2616005)(54906003)(508600001)(8936002)(426003)(356005)(83380400001)(316002)(86362001)(19627235002)(26005)(82310400003)(336012)(1076003)(70586007)(4326008)(7636003)(70206006)(36860700001)(8676002)(36756003)(2906002)(6666004)(47076005)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 12:29:39.4286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d3e642-8d6e-4637-973b-08d972c453cf
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT046.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6104
X-Proofpoint-GUID: 7-X-UwJJGuRNvcO6p2MobayyS1io98Ac
X-Proofpoint-ORIG-GUID: 7-X-UwJJGuRNvcO6p2MobayyS1io98Ac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_06,2021-09-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109080080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PHY PCS common register configuration sequences for single link.
Update single link PCIe register sequence accordingly.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 38 ++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index a426b12447a7..4e27886e4b7f 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -148,6 +148,7 @@
 /* PHY PCS common registers */
 #define SIERRA_PHY_PCS_COMMON_OFFSET(block_offset)	\
 				     (0xc000 << (block_offset))
+#define SIERRA_PHY_PIPE_CMN_CTRL1			0x0
 #define SIERRA_PHY_PLL_CFG				0xe
 
 #define SIERRA_MACRO_ID					0x00007364
@@ -256,6 +257,8 @@ struct cdns_sierra_data {
 	u32 id_value;
 	u8 block_offset_shift;
 	u8 reg_offset_shift;
+	struct cdns_sierra_vals *pcs_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
+					     [NUM_SSC_MODE];
 	struct cdns_sierra_vals *pma_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
 					     [NUM_SSC_MODE];
 	struct cdns_sierra_vals *pma_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
@@ -364,6 +367,7 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 	enum cdns_sierra_phy_type phy_type = ins->phy_type;
 	enum cdns_sierra_ssc_mode ssc = ins->ssc_mode;
 	const struct cdns_reg_pairs *reg_pairs;
+	struct cdns_sierra_vals *pcs_cmn_vals;
 	struct regmap *regmap;
 	u32 num_regs;
 	int i, j;
@@ -375,6 +379,16 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 	clk_set_rate(phy->input_clks[CMN_REFCLK_DIG_DIV], 25000000);
 	clk_set_rate(phy->input_clks[CMN_REFCLK1_DIG_DIV], 25000000);
 
+	/* PHY PCS common registers configurations */
+	pcs_cmn_vals = init_data->pcs_cmn_vals[phy_type][TYPE_NONE][ssc];
+	if (pcs_cmn_vals) {
+		reg_pairs = pcs_cmn_vals->reg_pairs;
+		num_regs = pcs_cmn_vals->num_regs;
+		regmap = phy->regmap_phy_pcs_common_cdb;
+		for (i = 0; i < num_regs; i++)
+			regmap_write(regmap, reg_pairs[i].off, reg_pairs[i].val);
+	}
+
 	/* PMA common registers configurations */
 	pma_cmn_vals = init_data->pma_cmn_vals[phy_type][TYPE_NONE][ssc];
 	if (pma_cmn_vals) {
@@ -1022,6 +1036,16 @@ static int cdns_sierra_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* PCIE PHY PCS common configuration */
+static struct cdns_reg_pairs pcie_phy_pcs_cmn_regs[] = {
+	{0x0430, SIERRA_PHY_PIPE_CMN_CTRL1}
+};
+
+static struct cdns_sierra_vals pcie_phy_pcs_cmn_vals = {
+	.reg_pairs = pcie_phy_pcs_cmn_regs,
+	.num_regs = ARRAY_SIZE(pcie_phy_pcs_cmn_regs),
+};
+
 /* refclk100MHz_32b_PCIe_cmn_pll_ext_ssc */
 static const struct cdns_reg_pairs cdns_pcie_cmn_regs_ext_ssc[] = {
 	{0x2106, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
@@ -1173,6 +1197,13 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 	.id_value = SIERRA_MACRO_ID,
 	.block_offset_shift = 0x2,
 	.reg_offset_shift = 0x2,
+	.pcs_cmn_vals = {
+		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+			},
+		},
+	},
 	.pma_cmn_vals = {
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -1203,6 +1234,13 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 	.id_value = SIERRA_MACRO_ID,
 	.block_offset_shift = 0x0,
 	.reg_offset_shift = 0x1,
+	.pcs_cmn_vals = {
+		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+			},
+		},
+	},
 	.pma_cmn_vals = {
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
-- 
2.26.1

