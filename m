Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E59414911
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbhIVMjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:39:35 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:47848 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235889AbhIVMjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:39:31 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MBnBM0010091;
        Wed, 22 Sep 2021 05:37:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=E6gCNz0tD6ZgOgaMvvDvIxHx1QIeTiVcf8ZDEZOe+Fk=;
 b=IaKXqjrlpXU7dMUZdAmI+t98oB+AzfwlcRw4nIrxiVLhj8c36y3kgWLFParuK9YEeg1n
 Ra6ZzoKJgdlPRVXXexMVRzkbxB8Koe7ehT1t2Inr0SKnZXWYLKZhtUA1+rVbM6z3/HrC
 ga3gyhhYoI5VXVDxlKKDDqHN2oQkrrV+e0K5IYTXGsRBwpKp7ZsanMW8w4FO6LFeyUQ7
 E697XJy+ngqBZF7v1cu2ouhbHAhJyz+xmI8AWocOuYsUGreuGfXATxafyXgwNREn6JsT
 UrQs7Ed2Dz2sAaG7II96j7TN4umNBiAkFjzU/RBXzaIppKNnNQNQSdXyZpoIvFrZxsIr kQ== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2044.outbound.protection.outlook.com [104.47.73.44])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3b7q41a4xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Sep 2021 05:37:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuLfv8AgG0uzRyGeENUOy6SUNpnBeAQy2bFFGiUUxfHAH0YQl53vVYZ7yXqNqwyU2rL69oNDchziSJ8RQnn7kjzhgSIfCQu5JHarfij2LqEmo3zhjXglubgS3Mo6dCf952/Xn3Cqq07d479R4igDwur+gAGI5xUGqFnvfnQNhIZtm+d0ydWpQX2BOnjNoO2DX5k7SxVZ+FBM2bnnyUkOaXddlG4aG4aW3q44hggkLAeSUm9q3tczwYv/2qJP+t0cwXufn1ZKbzHwpI3Tsl/EDOHLEJb8dpJpdm5KCaeAnqr0QskA7Jub8nJovoaNSLFg0eM1G8IaQ5BF3ikAhwB4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=E6gCNz0tD6ZgOgaMvvDvIxHx1QIeTiVcf8ZDEZOe+Fk=;
 b=Ql+kUr6rY6HzDnaVEG9HsofacdAySRtcpiYEKze8EG3emvdiQ6V15Czy0O/Zdu/F/CoZz+RQhjKQPJPPMDGp7vw7Ibcm5sZYJp+LSTP+XXhXeHJRZ9lTcIIm3VewQX9W8Vz9sUS8hYluzeDc9z0TSMD5aYSwQq7SCUUlIOuWlVND72vqGqI73WU3jvC2tY/HkkNUVl3A8unXns++pETK1vmTYbEkBzaAwZZq/h9LGLXbkqZYtYCqTx7KRB+vfzg3UAOP2xYa5/RwpkI+UmSBaRaL2gS64s4TB9kKjyCp2bgKyIUGEHzywUSK9pv0QonSCPYRs8EWnP/SJFdEU52u8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6gCNz0tD6ZgOgaMvvDvIxHx1QIeTiVcf8ZDEZOe+Fk=;
 b=cmcm/F9hOBNTVC7T2DFrPa/PNOlRiAhUItYGq7DpQStKowmGjMucznCWffbSb0CRAqZXeH2tWpF04+7JTSsPTKwlXSuKjPULJkqmb9gZyRVw8e47WxFYy+nA8th42sYSqIQootuPKSipzrynSeF1iww3GN7b3n8p8NuTsHw4Jbw=
Received: from CO1PR15CA0069.namprd15.prod.outlook.com (2603:10b6:101:20::13)
 by SJ0PR07MB8406.namprd07.prod.outlook.com (2603:10b6:a03:335::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 12:37:50 +0000
Received: from MW2NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::5f) by CO1PR15CA0069.outlook.office365.com
 (2603:10b6:101:20::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Wed, 22 Sep 2021 12:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT056.mail.protection.outlook.com (10.13.181.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.6 via Frontend Transport; Wed, 22 Sep 2021 12:37:48 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 18MCbj47070810
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 05:37:46 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Sep 2021 14:37:38 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 22 Sep 2021 14:37:38 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18MCbckb021981;
        Wed, 22 Sep 2021 14:37:38 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18MCbcBk021980;
        Wed, 22 Sep 2021 14:37:38 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH v2 3/4] phy: cadence-torrent: Model reference clock driver as a clock to enable derived refclk
Date:   Wed, 22 Sep 2021 14:37:34 +0200
Message-ID: <20210922123735.21927-4-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210922123735.21927-1-sjakhade@cadence.com>
References: <20210922123735.21927-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd10da15-6544-4e5b-b456-08d97dc5c911
X-MS-TrafficTypeDiagnostic: SJ0PR07MB8406:
X-Microsoft-Antispam-PRVS: <SJ0PR07MB84062942C7CB393D52333ED7C5A29@SJ0PR07MB8406.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:398;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: skMomNna64khi4KCmJs6ADmiGlByTv6Ur0370slJ3h8mrXLjvRDNSd+jFUnbF6weT0FQCI+KMtL8BuaTdKCFwX/LT3uT6bFRyA0Zpu9ra+O09LJQ9vgQ8mdAdS815f3WtfTUmNLjVp76W5HUur1WT6hMC40BCv6cQBlL/eTmIPJpOwmndXNI0okTUqv6uO4z4JC+XifD3zuDGVGWRGqwuKO27/z/yw0X/ChuGdA6SpX2XUvujKbVw9bCw/IgTAOTqCKre7l60MSByR7h/3HdiLnQd7WFs1+U02s9nfT2wXkOsL/hMRpXTUx5Q86bDI5lfTNWF3AN3lbYJZIjfEs21RvrSIPACzVQK3803hl5AnQNkjLVwnje5H2KUXQTMGL71OruJa3dlWIVlqivymyb1hZZ3XjQbHnFOx3Mh6HlRS3IIrvHx8T2R/jLgb3m9klfAPPIDvPh3MbeLTGcfw84NLV+S8JXRdfDdgEx5hBSussqa+d+Xf6BSwbdZp0Pt6LO9KNTTv/mVWMymn32/dCrO6x5uK+T1U2yb4HTctohyjDwQfbHaFScrsIV8G5V+SwFXY4BIZB/ti9W1Bfc3CI5uPzGvc/AQIZ3dgCIm3t8aiCB1Fl7nvbrONqL+zuTRDe9CkNKStP720WNlwAMIFlJBgEhDiycWPTUsemQlT6ezgCU2amcI1PlUBMD7ICz3b8RvWfQ3YRaF5u1RLO54wvxOnNM2Fvt3hmC75XREuKhPMaZUK+uK1wISv7NMpgxDidKGeu/SRcIruHivB2nNtrS/Kl0xPMKwdCOsuHeM8TueAZ6HaNBnXf/fnGecZnp+ko0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(70586007)(356005)(6666004)(81166007)(2616005)(2906002)(5660300002)(4326008)(82310400003)(316002)(336012)(86362001)(110136005)(83380400001)(36756003)(8936002)(186003)(54906003)(1076003)(36860700001)(42186006)(47076005)(26005)(70206006)(8676002)(426003)(508600001)(2101003)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 12:37:48.3626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd10da15-6544-4e5b-b456-08d97dc5c911
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT056.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB8406
X-Proofpoint-ORIG-GUID: DQrUczRehuhw4XS-VqdhhVcbLwLU80G-
X-Proofpoint-GUID: DQrUczRehuhw4XS-VqdhhVcbLwLU80G-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_04,2021-09-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109200000 definitions=main-2109220089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reference clock driver is enabled, either derived or received refclk
is output on cmn_refclk_p/m. Update the reference clock driver
implementation by modelling reference clock driver as a "clock" with
derived reference clock set as its default parent. The support for
received reference clock will be added in a separate patch.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 157 ++++++++++++++++++----
 1 file changed, 132 insertions(+), 25 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index ecb1aa883c05..615aca6bd52b 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -235,10 +235,11 @@
 #define PHY_PMA_CMN_CTRL2		0x0001U
 #define PHY_PMA_PLL_RAW_CTRL		0x0003U
 
-#define CDNS_TORRENT_OUTPUT_CLOCKS	1
+#define CDNS_TORRENT_OUTPUT_CLOCKS	2
 
 static const char * const clk_names[] = {
 	[CDNS_TORRENT_REFCLK_DRIVER] = "refclk-driver",
+	[CDNS_TORRENT_DERIVED_REFCLK] = "refclk-der",
 };
 
 static const struct reg_field phy_pll_cfg =
@@ -261,10 +262,12 @@ static const struct reg_field phy_pcs_iso_link_ctrl_1 =
 
 static const struct reg_field phy_pipe_cmn_ctrl1_0 = REG_FIELD(PHY_PIPE_CMN_CTRL1, 0, 0);
 
-#define REFCLK_OUT_NUM_CMN_CONFIG	5
+static const struct reg_field cmn_cdiag_refclk_ovrd_4 =
+				REG_FIELD(CMN_CDIAG_REFCLK_OVRD, 4, 4);
+
+#define REFCLK_OUT_NUM_CMN_CONFIG	4
 
 enum cdns_torrent_refclk_out_cmn {
-	CMN_CDIAG_REFCLK_OVRD_4,
 	CMN_CDIAG_REFCLK_DRV0_CTRL_1,
 	CMN_CDIAG_REFCLK_DRV0_CTRL_4,
 	CMN_CDIAG_REFCLK_DRV0_CTRL_5,
@@ -272,7 +275,6 @@ enum cdns_torrent_refclk_out_cmn {
 };
 
 static const struct reg_field refclk_out_cmn_cfg[] = {
-	[CMN_CDIAG_REFCLK_OVRD_4]	= REG_FIELD(CMN_CDIAG_REFCLK_OVRD, 4, 4),
 	[CMN_CDIAG_REFCLK_DRV0_CTRL_1]	= REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 1, 1),
 	[CMN_CDIAG_REFCLK_DRV0_CTRL_4]	= REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 4, 4),
 	[CMN_CDIAG_REFCLK_DRV0_CTRL_5]  = REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 5, 5),
@@ -330,6 +332,8 @@ struct cdns_torrent_phy {
 	struct regmap *regmap_phy_pcs_lane_cdb[MAX_NUM_LANES];
 	struct regmap *regmap_dptx_phy_reg;
 	struct regmap_field *phy_pll_cfg;
+	struct regmap_field *phy_pipe_cmn_ctrl1_0;
+	struct regmap_field *cmn_cdiag_refclk_ovrd_4;
 	struct regmap_field *phy_pma_cmn_ctrl_1;
 	struct regmap_field *phy_pma_cmn_ctrl_2;
 	struct regmap_field *phy_pma_pll_raw_ctrl;
@@ -345,10 +349,19 @@ enum phy_powerstate {
 	POWERSTATE_A3 = 3,
 };
 
+struct cdns_torrent_refclk_driver {
+	struct clk_hw		hw;
+	struct regmap_field	*cmn_fields[REFCLK_OUT_NUM_CMN_CONFIG];
+	struct clk_init_data	clk_data;
+};
+
+#define to_cdns_torrent_refclk_driver(_hw)	\
+			container_of(_hw, struct cdns_torrent_refclk_driver, hw)
+
 struct cdns_torrent_derived_refclk {
 	struct clk_hw		hw;
 	struct regmap_field	*phy_pipe_cmn_ctrl1_0;
-	struct regmap_field	*cmn_fields[REFCLK_OUT_NUM_CMN_CONFIG];
+	struct regmap_field	*cmn_cdiag_refclk_ovrd_4;
 	struct clk_init_data	clk_data;
 };
 
@@ -1618,11 +1631,7 @@ static int cdns_torrent_derived_refclk_enable(struct clk_hw *hw)
 {
 	struct cdns_torrent_derived_refclk *derived_refclk = to_cdns_torrent_derived_refclk(hw);
 
-	regmap_field_write(derived_refclk->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_6], 0);
-	regmap_field_write(derived_refclk->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_4], 1);
-	regmap_field_write(derived_refclk->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_5], 1);
-	regmap_field_write(derived_refclk->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_1], 0);
-	regmap_field_write(derived_refclk->cmn_fields[CMN_CDIAG_REFCLK_OVRD_4], 1);
+	regmap_field_write(derived_refclk->cmn_cdiag_refclk_ovrd_4, 1);
 	regmap_field_write(derived_refclk->phy_pipe_cmn_ctrl1_0, 1);
 
 	return 0;
@@ -1633,6 +1642,7 @@ static void cdns_torrent_derived_refclk_disable(struct clk_hw *hw)
 	struct cdns_torrent_derived_refclk *derived_refclk = to_cdns_torrent_derived_refclk(hw);
 
 	regmap_field_write(derived_refclk->phy_pipe_cmn_ctrl1_0, 0);
+	regmap_field_write(derived_refclk->cmn_cdiag_refclk_ovrd_4, 0);
 }
 
 static int cdns_torrent_derived_refclk_is_enabled(struct clk_hw *hw)
@@ -1640,7 +1650,7 @@ static int cdns_torrent_derived_refclk_is_enabled(struct clk_hw *hw)
 	struct cdns_torrent_derived_refclk *derived_refclk = to_cdns_torrent_derived_refclk(hw);
 	int val;
 
-	regmap_field_read(derived_refclk->phy_pipe_cmn_ctrl1_0, &val);
+	regmap_field_read(derived_refclk->cmn_cdiag_refclk_ovrd_4, &val);
 
 	return !!val;
 }
@@ -1655,21 +1665,19 @@ static int cdns_torrent_derived_refclk_register(struct cdns_torrent_phy *cdns_ph
 {
 	struct cdns_torrent_derived_refclk *derived_refclk;
 	struct device *dev = cdns_phy->dev;
-	struct regmap_field *field;
 	struct clk_init_data *init;
 	const char *parent_name;
-	struct regmap *regmap;
 	char clk_name[100];
 	struct clk_hw *hw;
 	struct clk *clk;
-	int i, ret;
+	int ret;
 
 	derived_refclk = devm_kzalloc(dev, sizeof(*derived_refclk), GFP_KERNEL);
 	if (!derived_refclk)
 		return -ENOMEM;
 
 	snprintf(clk_name, sizeof(clk_name), "%s_%s", dev_name(dev),
-		 clk_names[CDNS_TORRENT_REFCLK_DRIVER]);
+		 clk_names[CDNS_TORRENT_DERIVED_REFCLK]);
 
 	clk = devm_clk_get_optional(dev, "phy_en_refclk");
 	if (IS_ERR(clk)) {
@@ -1688,27 +1696,104 @@ static int cdns_torrent_derived_refclk_register(struct cdns_torrent_phy *cdns_ph
 	init->flags = 0;
 	init->name = clk_name;
 
-	regmap = cdns_phy->regmap_phy_pcs_common_cdb;
-	field = devm_regmap_field_alloc(dev, regmap, phy_pipe_cmn_ctrl1_0);
-	if (IS_ERR(field)) {
-		dev_err(dev, "phy_pipe_cmn_ctrl1_0 reg field init failed\n");
-		return PTR_ERR(field);
+	derived_refclk->phy_pipe_cmn_ctrl1_0 = cdns_phy->phy_pipe_cmn_ctrl1_0;
+	derived_refclk->cmn_cdiag_refclk_ovrd_4 = cdns_phy->cmn_cdiag_refclk_ovrd_4;
+
+	derived_refclk->hw.init = init;
+
+	hw = &derived_refclk->hw;
+	ret = devm_clk_hw_register(dev, hw);
+	if (ret)
+		return ret;
+
+	cdns_phy->clk_hw_data->hws[CDNS_TORRENT_DERIVED_REFCLK] = hw;
+
+	return 0;
+}
+
+static int cdns_torrent_refclk_driver_enable(struct clk_hw *hw)
+{
+	struct cdns_torrent_refclk_driver *refclk_driver = to_cdns_torrent_refclk_driver(hw);
+
+	regmap_field_write(refclk_driver->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_6], 0);
+	regmap_field_write(refclk_driver->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_4], 1);
+	regmap_field_write(refclk_driver->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_5], 1);
+	regmap_field_write(refclk_driver->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_1], 0);
+
+	return 0;
+}
+
+static void cdns_torrent_refclk_driver_disable(struct clk_hw *hw)
+{
+	struct cdns_torrent_refclk_driver *refclk_driver = to_cdns_torrent_refclk_driver(hw);
+
+	regmap_field_write(refclk_driver->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_1], 1);
+}
+
+static int cdns_torrent_refclk_driver_is_enabled(struct clk_hw *hw)
+{
+	struct cdns_torrent_refclk_driver *refclk_driver = to_cdns_torrent_refclk_driver(hw);
+	int val;
+
+	regmap_field_read(refclk_driver->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_1], &val);
+
+	return !val;
+}
+
+static const struct clk_ops cdns_torrent_refclk_driver_ops = {
+	.enable = cdns_torrent_refclk_driver_enable,
+	.disable = cdns_torrent_refclk_driver_disable,
+	.is_enabled = cdns_torrent_refclk_driver_is_enabled,
+};
+
+static int cdns_torrent_refclk_driver_register(struct cdns_torrent_phy *cdns_phy)
+{
+	struct cdns_torrent_refclk_driver *refclk_driver;
+	struct device *dev = cdns_phy->dev;
+	struct regmap_field *field;
+	struct clk_init_data *init;
+	const char *parent_name;
+	struct regmap *regmap;
+	char clk_name[100];
+	struct clk_hw *hw;
+	int i, ret;
+
+	refclk_driver = devm_kzalloc(dev, sizeof(*refclk_driver), GFP_KERNEL);
+	if (!refclk_driver)
+		return -ENOMEM;
+
+	hw = cdns_phy->clk_hw_data->hws[CDNS_TORRENT_DERIVED_REFCLK];
+	if (IS_ERR_OR_NULL(hw)) {
+		dev_err(dev, "No parent clock for refclk driver clock\n");
+		return IS_ERR(hw) ? PTR_ERR(hw) : -ENOENT;
 	}
-	derived_refclk->phy_pipe_cmn_ctrl1_0 = field;
+	parent_name = clk_hw_get_name(hw);
+
+	snprintf(clk_name, sizeof(clk_name), "%s_%s", dev_name(dev),
+		 clk_names[CDNS_TORRENT_REFCLK_DRIVER]);
+
+	init = &refclk_driver->clk_data;
+
+	init->ops = &cdns_torrent_refclk_driver_ops;
+	init->flags = 0;
+	init->parent_names = &parent_name;
+	init->num_parents = 1;
+	init->name = clk_name;
 
 	regmap = cdns_phy->regmap_common_cdb;
+
 	for (i = 0; i < REFCLK_OUT_NUM_CMN_CONFIG; i++) {
 		field = devm_regmap_field_alloc(dev, regmap, refclk_out_cmn_cfg[i]);
 		if (IS_ERR(field)) {
-			dev_err(dev, "CMN reg field init failed\n");
+			dev_err(dev, "Refclk driver CMN reg field init failed\n");
 			return PTR_ERR(field);
 		}
-		derived_refclk->cmn_fields[i] = field;
+		refclk_driver->cmn_fields[i] = field;
 	}
 
-	derived_refclk->hw.init = init;
+	refclk_driver->hw.init = init;
 
-	hw = &derived_refclk->hw;
+	hw = &refclk_driver->hw;
 	ret = devm_clk_hw_register(dev, hw);
 	if (ret)
 		return ret;
@@ -1768,6 +1853,22 @@ static int cdns_torrent_regfield_init(struct cdns_torrent_phy *cdns_phy)
 	}
 	cdns_phy->phy_pll_cfg = field;
 
+	regmap = cdns_phy->regmap_phy_pcs_common_cdb;
+	field = devm_regmap_field_alloc(dev, regmap, phy_pipe_cmn_ctrl1_0);
+	if (IS_ERR(field)) {
+		dev_err(dev, "phy_pipe_cmn_ctrl1_0 reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	cdns_phy->phy_pipe_cmn_ctrl1_0 = field;
+
+	regmap = cdns_phy->regmap_common_cdb;
+	field = devm_regmap_field_alloc(dev, regmap, cmn_cdiag_refclk_ovrd_4);
+	if (IS_ERR(field)) {
+		dev_err(dev, "cmn_cdiag_refclk_ovrd_4 reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	cdns_phy->cmn_cdiag_refclk_ovrd_4 = field;
+
 	regmap = cdns_phy->regmap_phy_pma_common_cdb;
 	field = devm_regmap_field_alloc(dev, regmap, phy_pma_cmn_ctrl_1);
 	if (IS_ERR(field)) {
@@ -2207,6 +2308,12 @@ static int cdns_torrent_clk_register(struct cdns_torrent_phy *cdns_phy)
 		return ret;
 	}
 
+	ret = cdns_torrent_refclk_driver_register(cdns_phy);
+	if (ret) {
+		dev_err(dev, "failed to register refclk driver\n");
+		return ret;
+	}
+
 	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, data);
 	if (ret) {
 		dev_err(dev, "Failed to add clock provider: %s\n", node->name);
-- 
2.26.1

