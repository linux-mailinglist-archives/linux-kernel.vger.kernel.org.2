Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CAD403F17
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 20:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350234AbhIHS2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 14:28:41 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:2960 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349572AbhIHS1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 14:27:52 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 188I6GgR030393;
        Wed, 8 Sep 2021 11:26:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=9RIhqQ/mpOHj6dY0vt9ZTVzyuBi3D89GD/iJZ4UXDSU=;
 b=OK8TMmDBMUMWN4B8NBLgzs60/v6PSeXLl9Y2Ywn2pJpWHH00YttZVBrhhhc0ThuNs9jn
 B1M4Au2cQn2qmPToH6PfGNKk2lREl403DF17787t/GkdQoJsjpEcx+mwE8y88qJ2BY/L
 rlsJL9N/6mercA/FV7g9iY6z1AGUxvPYk+EUk29+L/e5iHfXAXOMwcCIuDYktwvn4wNb
 ZMHgzI3HSXPPwEWEh+mlHGEhuN3BNbSEmaHnWWZFkL9AjMH/3fnEmOyHmVpAiQMGHHyH
 MxVXWCQuoK9MOSjE5L0k01E5crXV8cTmyl82KbV8EWXvLQvicmkyYT33pHjZnX5DFEVi 3Q== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3axcn5c477-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 11:26:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6PMS52RVEVTBaMxXCXdeZFKdLj/tGeyGhQV5F6auuNKgZ/bijjKXgNoY+LK8wyznKJeHhDC//l2hapd/A/N/mg6kC+5n9aD6PbH8iIugJHV+7WITrA/TfIaCJJs3bdj4tNDkURRW9VC/5HSFguP3ycQs1J0JwTFWmgAFxDDeXqFMHJmv4qwOEi3KF26R+bzCBmag9wuTIDCFdnwUem/8pRZkH+eSe0EdvgGHOdtIrdOoEBuo769Vq8kY18NDJULJbYwlMstKdNKByylCGUhFhi95KdnWNUTLNCVS40KFlF556pVHngWvIQas0KTiGpz/TyF57FbHVNKAR/bPsWdnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9RIhqQ/mpOHj6dY0vt9ZTVzyuBi3D89GD/iJZ4UXDSU=;
 b=Rd9Wfi6bnQhx7Zn+4LDQ55L1PfWd8aEvt4C+PXJ9Y6phGPzIDsnMLhFppqB4Sckvoi+Q546OFtq4Ed14dEC+MCJ4U7DAL9/DDhPsZtLzqFce0WyKWmSBwiBHAzhy1sNjwdHrdLZpHxJsxNUvnEyabxz7RUIFwys927+zBgTWCsKtUNucEBY5DR3m69zZrXgsqaBMPi7a+QASI3Hrbf7rkKae39KpQauef10Lz1wSbMHSmNb4O97FoZH+JIF6FyM7jDAxdW7a3TAu89QRxnJ3/65nmQ+KELPvPPm/vP+pEln4Y1WdM4kk/H7HF6oRv88nsm4cs0kH1CiDIRbJ6QnfqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RIhqQ/mpOHj6dY0vt9ZTVzyuBi3D89GD/iJZ4UXDSU=;
 b=uqiKMifwbtkKS7QeF9vwBQZyRj3obFEgB0capYNtiFEdbm9BPwAN8Y8FyPPWppIOiZgmtVhbIEXbJ2OOjTIlr8WlkQetfnUSdhuVXo92rka0JQtZXhAffnYxuMpZq7aAtahcoIx8mT9DbFAPBKroEbLGOYI4ilRgo0IRl8xpAdo=
Received: from BN6PR1701CA0024.namprd17.prod.outlook.com
 (2603:10b6:405:15::34) by BL0PR07MB5636.namprd07.prod.outlook.com
 (2603:10b6:208:8c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 18:26:33 +0000
Received: from BN8NAM12FT026.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::44) by BN6PR1701CA0024.outlook.office365.com
 (2603:10b6:405:15::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 18:26:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT026.mail.protection.outlook.com (10.13.182.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 18:26:32 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 188IQUwK017985
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 14:26:32 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Sep 2021 20:26:30 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 8 Sep 2021 20:26:30 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 8 Sep 2021 20:26:30 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 188IQUQ1028417;
        Wed, 8 Sep 2021 20:26:30 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 188IQUnf028416;
        Wed, 8 Sep 2021 20:26:30 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH 3/5] phy: cadence-torrent: Add support for derived reference clock output
Date:   Wed, 8 Sep 2021 20:26:26 +0200
Message-ID: <20210908182628.28364-4-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210908182628.28364-1-sjakhade@cadence.com>
References: <20210908182628.28364-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 613d6761-b2a4-4dd3-3245-08d972f62f18
X-MS-TrafficTypeDiagnostic: BL0PR07MB5636:
X-Microsoft-Antispam-PRVS: <BL0PR07MB56360E6FDDEB7A5E38732464C5D49@BL0PR07MB5636.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:370;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PCWvxaU6Bc/3S+ie0Pd3KC8MUQKGcqSR0rvWMib48LorncFhGTwH/xJEN5D35omJV2NMTbMbi12dL05FsOZUUYgoxe7P+41TcWqBOzAraPZrOnHXoy/lMOE174PjornYmxG3WtxAZq4Gti2rVdto9DkXw0ru/szjEAFNbRiY2gUGnv0yoP0JPXDPH4MSnjShOOHrUtoxNnhdEbdF/8TgHttKZZcJZ6Rua1EY9Citj8o9J+Xe3Ko9J+8fHrDAW3hcEc7Lqv9UpEa3XaBsndOyHlR1WsOfe/NYphV4BHW69JP57TXGGXfXkFdn3W73sIQN9gH3/2Yg1v9DGfayvxSZfeajHFmGpfTomyvuoa4oiqYCjc0Y6QusIzLpxnMN8A3+7UDM8uB6wjwBiOD+mUcmrJVqkpdvR+6Ul6vH3svzDM3pEg6E5WvHHVcYhi9j9XkhMlF4q7/84Ee/nwyuUo6o9qpVYp5R2yTcrOLBbhoTzCpwwdltX1628qLfUonRJSiCgsXuRTPkXZiF1b2rF099D7MjuoA3V0X9UzSCgh+EQXj3Y2vr7gV9TC5klX2fi3EPkQVJcy+yZh2Pk+QdxB4DHox6+rdyOeIwtL64iSPlUGq5Z43nyaHdckfqmvDaUBKOV2Tt5rZZ4Ia2pAFzpavpJk4THFID3hpf/7GWs46EUk8SkWgZza4ZtN2fT83owHZobN8zIJeG5JS9h2tkwqVPAx0cLM9G1j1+CCicru4mWsm26jG+IZ9V4od73YpV4qqSb9MoovbuZPxImG4Roc6sxZ02MKeEhDEtajJv7sGt3piDOlI2XOmXmTLoANi8YqsN
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(36092001)(36840700001)(46966006)(70206006)(336012)(70586007)(356005)(1076003)(478600001)(6666004)(5660300002)(82740400003)(2906002)(8676002)(186003)(26005)(81166007)(83380400001)(36756003)(54906003)(316002)(36906005)(2616005)(82310400003)(8936002)(36860700001)(47076005)(426003)(86362001)(4326008)(110136005)(42186006)(2101003)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 18:26:32.6942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 613d6761-b2a4-4dd3-3245-08d972f62f18
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT026.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB5636
X-Proofpoint-ORIG-GUID: V3n1VEtUxeYlNWA_PBj4np_eE0-W1y4q
X-Proofpoint-GUID: V3n1VEtUxeYlNWA_PBj4np_eE0-W1y4q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_06,2021-09-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the reference clock driver implementation where cmn_refclk_<p/m>
is configured to output the reference clock. cmn_refclk_p/m will output
either derived or received reference clock based on the selection. So,
all these clocks should be modelled separately. Model the derived
reference clock here as a first step to support reference clock driver.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 78 +++++++++--------------
 1 file changed, 31 insertions(+), 47 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index ecb1aa883c05..6dceb12e88c4 100644
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
@@ -261,23 +262,8 @@ static const struct reg_field phy_pcs_iso_link_ctrl_1 =
 
 static const struct reg_field phy_pipe_cmn_ctrl1_0 = REG_FIELD(PHY_PIPE_CMN_CTRL1, 0, 0);
 
-#define REFCLK_OUT_NUM_CMN_CONFIG	5
-
-enum cdns_torrent_refclk_out_cmn {
-	CMN_CDIAG_REFCLK_OVRD_4,
-	CMN_CDIAG_REFCLK_DRV0_CTRL_1,
-	CMN_CDIAG_REFCLK_DRV0_CTRL_4,
-	CMN_CDIAG_REFCLK_DRV0_CTRL_5,
-	CMN_CDIAG_REFCLK_DRV0_CTRL_6,
-};
-
-static const struct reg_field refclk_out_cmn_cfg[] = {
-	[CMN_CDIAG_REFCLK_OVRD_4]	= REG_FIELD(CMN_CDIAG_REFCLK_OVRD, 4, 4),
-	[CMN_CDIAG_REFCLK_DRV0_CTRL_1]	= REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 1, 1),
-	[CMN_CDIAG_REFCLK_DRV0_CTRL_4]	= REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 4, 4),
-	[CMN_CDIAG_REFCLK_DRV0_CTRL_5]  = REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 5, 5),
-	[CMN_CDIAG_REFCLK_DRV0_CTRL_6]	= REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 6, 6),
-};
+static const struct reg_field cmn_cdiag_refclk_ovrd_4 =
+				REG_FIELD(CMN_CDIAG_REFCLK_OVRD, 4, 4);
 
 enum cdns_torrent_phy_type {
 	TYPE_NONE,
@@ -330,6 +316,8 @@ struct cdns_torrent_phy {
 	struct regmap *regmap_phy_pcs_lane_cdb[MAX_NUM_LANES];
 	struct regmap *regmap_dptx_phy_reg;
 	struct regmap_field *phy_pll_cfg;
+	struct regmap_field *phy_pipe_cmn_ctrl1_0;
+	struct regmap_field *cmn_cdiag_refclk_ovrd_4;
 	struct regmap_field *phy_pma_cmn_ctrl_1;
 	struct regmap_field *phy_pma_cmn_ctrl_2;
 	struct regmap_field *phy_pma_pll_raw_ctrl;
@@ -348,7 +336,7 @@ enum phy_powerstate {
 struct cdns_torrent_derived_refclk {
 	struct clk_hw		hw;
 	struct regmap_field	*phy_pipe_cmn_ctrl1_0;
-	struct regmap_field	*cmn_fields[REFCLK_OUT_NUM_CMN_CONFIG];
+	struct regmap_field	*cmn_cdiag_refclk_ovrd_4;
 	struct clk_init_data	clk_data;
 };
 
@@ -1618,11 +1606,7 @@ static int cdns_torrent_derived_refclk_enable(struct clk_hw *hw)
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
@@ -1633,6 +1617,7 @@ static void cdns_torrent_derived_refclk_disable(struct clk_hw *hw)
 	struct cdns_torrent_derived_refclk *derived_refclk = to_cdns_torrent_derived_refclk(hw);
 
 	regmap_field_write(derived_refclk->phy_pipe_cmn_ctrl1_0, 0);
+	regmap_field_write(derived_refclk->cmn_cdiag_refclk_ovrd_4, 0);
 }
 
 static int cdns_torrent_derived_refclk_is_enabled(struct clk_hw *hw)
@@ -1640,7 +1625,7 @@ static int cdns_torrent_derived_refclk_is_enabled(struct clk_hw *hw)
 	struct cdns_torrent_derived_refclk *derived_refclk = to_cdns_torrent_derived_refclk(hw);
 	int val;
 
-	regmap_field_read(derived_refclk->phy_pipe_cmn_ctrl1_0, &val);
+	regmap_field_read(derived_refclk->cmn_cdiag_refclk_ovrd_4, &val);
 
 	return !!val;
 }
@@ -1655,21 +1640,19 @@ static int cdns_torrent_derived_refclk_register(struct cdns_torrent_phy *cdns_ph
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
@@ -1688,23 +1671,8 @@ static int cdns_torrent_derived_refclk_register(struct cdns_torrent_phy *cdns_ph
 	init->flags = 0;
 	init->name = clk_name;
 
-	regmap = cdns_phy->regmap_phy_pcs_common_cdb;
-	field = devm_regmap_field_alloc(dev, regmap, phy_pipe_cmn_ctrl1_0);
-	if (IS_ERR(field)) {
-		dev_err(dev, "phy_pipe_cmn_ctrl1_0 reg field init failed\n");
-		return PTR_ERR(field);
-	}
-	derived_refclk->phy_pipe_cmn_ctrl1_0 = field;
-
-	regmap = cdns_phy->regmap_common_cdb;
-	for (i = 0; i < REFCLK_OUT_NUM_CMN_CONFIG; i++) {
-		field = devm_regmap_field_alloc(dev, regmap, refclk_out_cmn_cfg[i]);
-		if (IS_ERR(field)) {
-			dev_err(dev, "CMN reg field init failed\n");
-			return PTR_ERR(field);
-		}
-		derived_refclk->cmn_fields[i] = field;
-	}
+	derived_refclk->phy_pipe_cmn_ctrl1_0 = cdns_phy->phy_pipe_cmn_ctrl1_0;
+	derived_refclk->cmn_cdiag_refclk_ovrd_4 = cdns_phy->cmn_cdiag_refclk_ovrd_4;
 
 	derived_refclk->hw.init = init;
 
@@ -1713,7 +1681,7 @@ static int cdns_torrent_derived_refclk_register(struct cdns_torrent_phy *cdns_ph
 	if (ret)
 		return ret;
 
-	cdns_phy->clk_hw_data->hws[CDNS_TORRENT_REFCLK_DRIVER] = hw;
+	cdns_phy->clk_hw_data->hws[CDNS_TORRENT_DERIVED_REFCLK] = hw;
 
 	return 0;
 }
@@ -1768,6 +1736,22 @@ static int cdns_torrent_regfield_init(struct cdns_torrent_phy *cdns_phy)
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
-- 
2.26.1

