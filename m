Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410833FF9CD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 07:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbhICFCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 01:02:36 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:38232 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232839AbhICFCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 01:02:20 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1830RqT7011272;
        Thu, 2 Sep 2021 22:01:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=dN1H3/Pon1Y9WEDQfDoHUvfloP9gMocl2sA/vBwFrIk=;
 b=WAEL3XpfCYs83okkyo0XLRibPJDGwajwGrIUMhbUiQJv5/SWhwsLPUuWS32Ss6R8bjpA
 go5VEFE0OSLnWFkpEbwBO7zOmEqNq6SfivbAdQ2IE9NgEnXi3Ed4ptZo+C0sCzw2p5gX
 lX1xUUesbFBGBpKwNIvaErPGeyCk2hTkcKlrXkaieuMoJ2XH85Gm6ToFzw3A2rKNLBsY
 PyLtpyKlIhyA9A3dzDx93v5O8sUWEX87BD/50QWT069rtOGQVtV4ZmIilx3MQ0G+yPYH
 R8Y8v8qp22Tu38E5vWgE2jjo6yM/0tWGcNA1+AHkXqCr1G3uKm9BLShQSvecCU8Huuat Dw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3atdvyek2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 22:01:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFPBb5fgTZQGkR3WmWiWwhm6iXj1wDD06u++eMYzs9sWExPXZKRA/+vwFMPKELnDmfvzLz7Zl3jO8SPD0u53xN/NwBYuGaajUoLmxuC0iKlFaiz2qGXD8U0K3Us5qiEPuBJnwxnP6wUoro9UaHeG5auth2KFAc5/CpldQ2tWhm6d9ZVv3EETY7sSsJteby57fHJUU5fdAQBDkNV9rBNuJlItK8XKVa0LtS5SMZDI9txy/WGof8gq8KHAJH421Txrg5MIlPTdAD9Jr6Yrb0fw52C0+2byYgU9h8kOHem0oLQpKSwz0DhxPDLrABM2lh+Ilre+o/2gSKRCWfQ9fgm+Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dN1H3/Pon1Y9WEDQfDoHUvfloP9gMocl2sA/vBwFrIk=;
 b=RuhLWAMoL7xJgyg2mbhKDlWUr3mocqB7eo9MCRi7hRvzJIK4NVRVZad/DskjnH7i8ZhxB0ZCzV+IIN3wnPVtk70rikf8PzoROGwBQk6QhssN/AcvhPrBqneTUbFQy92ncyuTfV4enrSYNoML8u8EQSVT93W0R4NUiFOd7lxykiqAJxiLHE9AGJ9w3GjriF84XXI09No7zrmpt6i/alXWvPO1SZaf3eNiq+s95c0tTtivBJ53TbZ30Lf+/WONF0XiHlB0ghzVeeKKgXIXN7X8rHtJ+hV8QDcjnnHV11p4utZ0maKrstu9r8iG7Qe8lp0PvW9V28hXCWjfN168oZZwUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dN1H3/Pon1Y9WEDQfDoHUvfloP9gMocl2sA/vBwFrIk=;
 b=2/45TY8qp8W6KKWWG7Jtbb6w2g1e0pfg2DAwqQvpc8PPLFk7N909R3ZOIhez41RFz/CwUFqpIl3KQGdDF40tI2jQ9SgtNp1pHS1dxqz37/k96e/rh/6QSdsUKg8IMr1ldXNsxzOQoSGNKGAAxDKiQIFIMQWzbjtuCBQwq1SyAiE=
Received: from DM6PR06CA0086.namprd06.prod.outlook.com (2603:10b6:5:336::19)
 by PH0PR07MB8638.namprd07.prod.outlook.com (2603:10b6:510:83::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Fri, 3 Sep
 2021 05:01:03 +0000
Received: from DM6NAM12FT003.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::22) by DM6PR06CA0086.outlook.office365.com
 (2603:10b6:5:336::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend
 Transport; Fri, 3 Sep 2021 05:01:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT003.mail.protection.outlook.com (10.13.179.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Fri, 3 Sep 2021 05:01:03 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 18350ufa020399
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Sep 2021 22:01:02 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Sep 2021 07:00:57 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 3 Sep 2021 07:00:55 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 3 Sep 2021 07:00:55 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18350tTm025677;
        Fri, 3 Sep 2021 07:00:55 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18350tFT025676;
        Fri, 3 Sep 2021 07:00:55 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 02/14] phy: cadence: Sierra: Prepare driver to add support for multilink configurations
Date:   Fri, 3 Sep 2021 07:00:42 +0200
Message-ID: <20210903050054.25627-3-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210903050054.25627-1-sjakhade@cadence.com>
References: <20210903050054.25627-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5bb4ea1-ff9a-44ec-d142-08d96e97d46b
X-MS-TrafficTypeDiagnostic: PH0PR07MB8638:
X-Microsoft-Antispam-PRVS: <PH0PR07MB86385F720CBA99FCE55B87F2C5CF9@PH0PR07MB8638.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: twK09IQFkceTTMJPbw5E1mULTv8Pu49nkpf9N1hvaAaqeeWSEoYW+3eAKvw/xoaIJNLiR7HQrum6mjlY2aWKuEgC54zM7xEclXUkmv9MF9rs+MYSC6VVhNZMc1EI0D5HbniJxv8ZOvAnLopmk0cK8rDK+dMWmolADUm/hJpsHo+xp4I/MlzfQezeTIhmRn3pLnwdFpdYX/r72wVxx6m8z8aHZh32qG8w1mrTfG7ghgVSO6lWhnjby6PjmfXPs5Hcazf9n+Oz/2c5DKdglRcfGSNQ1j2XwD1T7UeUfSOiWKt4VcxeRUP0POJ9n/tZPvMZ88Lv68cGNkbNj6pt0msCnxHON4/7hyV/Dj+yf1Yd805iLG43GcaFubR6Cp0aBqQ9DYVKx1f2q23OYdhJ/dkpBC/9FrQzpGzfEcgIOSv9x+tn9ZWVmClgs6ZGJhYEMctebzpygLgL4P7HPKx7DvRyV1FUH6f4BJK0eFWCfH1H/Kyo430fWiCoWDoe/S0IpL3x8RWI7S+MSQ1pdhLZ/NtVmZKD8SJee/SQz5G/DMW64DLqG2eVJQmAzDoKR9/Opx+PJSOx1bkYLVYLLkBKtkgHxaUsD/cH/0Z0NaIsF9jRAi0Ess60062zJg/Xj2+rXn9yQqANUuNwbsjsr/OolfJDZ44Zxi9kgh171Xq4wDbxXW9GCT5Ze77AUXzOyY8gNbK4wI8UgdzPT/abnyL1Eh6UuwwOD8muh+C7GXBdhmaqjmI=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(36092001)(46966006)(36840700001)(36860700001)(6666004)(19627235002)(26005)(8936002)(186003)(36756003)(8676002)(336012)(2906002)(54906003)(110136005)(478600001)(86362001)(47076005)(70206006)(356005)(36906005)(42186006)(316002)(70586007)(2616005)(426003)(83380400001)(5660300002)(4326008)(7636003)(1076003)(82740400003)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 05:01:03.1719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bb4ea1-ff9a-44ec-d142-08d96e97d46b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT003.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR07MB8638
X-Proofpoint-GUID: 9lRtAaA3PGUuVPG1HXyQoKJgxThwuoyW
X-Proofpoint-ORIG-GUID: 9lRtAaA3PGUuVPG1HXyQoKJgxThwuoyW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-03_01,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030030
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sierra driver currently supports single link configurations only. Prepare
driver to support multilink multiprotocol configurations along with
different SSC modes.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 195 ++++++++++++++++-------
 1 file changed, 139 insertions(+), 56 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 54d1c63932ac..7e0f36dabc95 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -23,6 +23,9 @@
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/phy/phy-cadence.h>
 
+#define NUM_SSC_MODE		3
+#define NUM_PHY_TYPE		3
+
 /* PHY register offsets */
 #define SIERRA_COMMON_CDB_OFFSET			0x0
 #define SIERRA_MACRO_ID_REG				0x0
@@ -217,9 +220,21 @@ static const int pll_mux_parent_index[][SIERRA_NUM_CMN_PLLC_PARENTS] = {
 
 static u32 cdns_sierra_pll_mux_table[] = { 0, 1 };
 
+enum cdns_sierra_phy_type {
+	TYPE_NONE,
+	TYPE_PCIE,
+	TYPE_USB
+};
+
+enum cdns_sierra_ssc_mode {
+	NO_SSC,
+	EXTERNAL_SSC,
+	INTERNAL_SSC
+};
+
 struct cdns_sierra_inst {
 	struct phy *phy;
-	u32 phy_type;
+	enum cdns_sierra_phy_type phy_type;
 	u32 num_lanes;
 	u32 mlane;
 	struct reset_control *lnk_rst;
@@ -230,18 +245,19 @@ struct cdns_reg_pairs {
 	u32 off;
 };
 
+struct cdns_sierra_vals {
+	const struct cdns_reg_pairs *reg_pairs;
+	u32 num_regs;
+};
+
 struct cdns_sierra_data {
-		u32 id_value;
-		u8 block_offset_shift;
-		u8 reg_offset_shift;
-		u32 pcie_cmn_regs;
-		u32 pcie_ln_regs;
-		u32 usb_cmn_regs;
-		u32 usb_ln_regs;
-		const struct cdns_reg_pairs *pcie_cmn_vals;
-		const struct cdns_reg_pairs *pcie_ln_vals;
-		const struct cdns_reg_pairs *usb_cmn_vals;
-		const struct cdns_reg_pairs *usb_ln_vals;
+	u32 id_value;
+	u8 block_offset_shift;
+	u8 reg_offset_shift;
+	struct cdns_sierra_vals *pma_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
+					     [NUM_SSC_MODE];
+	struct cdns_sierra_vals *pma_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
+					    [NUM_SSC_MODE];
 };
 
 struct cdns_regmap_cdb_context {
@@ -341,10 +357,14 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 {
 	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
 	struct cdns_sierra_phy *phy = dev_get_drvdata(gphy->dev.parent);
+	const struct cdns_sierra_data *init_data = phy->init_data;
+	struct cdns_sierra_vals *pma_cmn_vals, *pma_ln_vals;
+	enum cdns_sierra_phy_type phy_type = ins->phy_type;
+	enum cdns_sierra_ssc_mode ssc = EXTERNAL_SSC;
+	const struct cdns_reg_pairs *reg_pairs;
 	struct regmap *regmap;
+	u32 num_regs;
 	int i, j;
-	const struct cdns_reg_pairs *cmn_vals, *ln_vals;
-	u32 num_cmn_regs, num_ln_regs;
 
 	/* Initialise the PHY registers, unless auto configured */
 	if (phy->autoconf)
@@ -352,28 +372,26 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 
 	clk_set_rate(phy->input_clks[CMN_REFCLK_DIG_DIV], 25000000);
 	clk_set_rate(phy->input_clks[CMN_REFCLK1_DIG_DIV], 25000000);
-	if (ins->phy_type == PHY_TYPE_PCIE) {
-		num_cmn_regs = phy->init_data->pcie_cmn_regs;
-		num_ln_regs = phy->init_data->pcie_ln_regs;
-		cmn_vals = phy->init_data->pcie_cmn_vals;
-		ln_vals = phy->init_data->pcie_ln_vals;
-	} else if (ins->phy_type == PHY_TYPE_USB3) {
-		num_cmn_regs = phy->init_data->usb_cmn_regs;
-		num_ln_regs = phy->init_data->usb_ln_regs;
-		cmn_vals = phy->init_data->usb_cmn_vals;
-		ln_vals = phy->init_data->usb_ln_vals;
-	} else {
-		return -EINVAL;
-	}
 
-	regmap = phy->regmap_common_cdb;
-	for (j = 0; j < num_cmn_regs ; j++)
-		regmap_write(regmap, cmn_vals[j].off, cmn_vals[j].val);
+	/* PMA common registers configurations */
+	pma_cmn_vals = init_data->pma_cmn_vals[phy_type][TYPE_NONE][ssc];
+	if (pma_cmn_vals) {
+		reg_pairs = pma_cmn_vals->reg_pairs;
+		num_regs = pma_cmn_vals->num_regs;
+		regmap = phy->regmap_common_cdb;
+		for (i = 0; i < num_regs; i++)
+			regmap_write(regmap, reg_pairs[i].off, reg_pairs[i].val);
+	}
 
-	for (i = 0; i < ins->num_lanes; i++) {
-		for (j = 0; j < num_ln_regs ; j++) {
+	/* PMA TX lane registers configurations */
+	pma_ln_vals = init_data->pma_ln_vals[phy_type][TYPE_NONE][ssc];
+	if (pma_ln_vals) {
+		reg_pairs = pma_ln_vals->reg_pairs;
+		num_regs = pma_ln_vals->num_regs;
+		for (i = 0; i < ins->num_lanes; i++) {
 			regmap = phy->regmap_lane_cdb[i + ins->mlane];
-			regmap_write(regmap, ln_vals[j].off, ln_vals[j].val);
+			for (j = 0; j < num_regs; j++)
+				regmap_write(regmap, reg_pairs[j].off, reg_pairs[j].val);
 		}
 	}
 
@@ -583,15 +601,28 @@ static int cdns_sierra_clk_register(struct cdns_sierra_phy *sp)
 static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
 				    struct device_node *child)
 {
+	u32 phy_type;
+
 	if (of_property_read_u32(child, "reg", &inst->mlane))
 		return -EINVAL;
 
 	if (of_property_read_u32(child, "cdns,num-lanes", &inst->num_lanes))
 		return -EINVAL;
 
-	if (of_property_read_u32(child, "cdns,phy-type", &inst->phy_type))
+	if (of_property_read_u32(child, "cdns,phy-type", &phy_type))
 		return -EINVAL;
 
+	switch (phy_type) {
+	case PHY_TYPE_PCIE:
+		inst->phy_type = TYPE_PCIE;
+		break;
+	case PHY_TYPE_USB3:
+		inst->phy_type = TYPE_USB;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -1006,6 +1037,16 @@ static const struct cdns_reg_pairs cdns_pcie_ln_regs_ext_ssc[] = {
 	{0x44CC, SIERRA_CREQ_EQ_OPEN_EYE_THRESH_PREG}
 };
 
+static struct cdns_sierra_vals pcie_100_ext_ssc_cmn_vals = {
+	.reg_pairs = cdns_pcie_cmn_regs_ext_ssc,
+	.num_regs = ARRAY_SIZE(cdns_pcie_cmn_regs_ext_ssc),
+};
+
+static struct cdns_sierra_vals pcie_100_ext_ssc_ln_vals = {
+	.reg_pairs = cdns_pcie_ln_regs_ext_ssc,
+	.num_regs = ARRAY_SIZE(cdns_pcie_ln_regs_ext_ssc),
+};
+
 /* refclk100MHz_20b_USB_cmn_pll_ext_ssc */
 static const struct cdns_reg_pairs cdns_usb_cmn_regs_ext_ssc[] = {
 	{0x2085, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
@@ -1113,32 +1154,74 @@ static const struct cdns_reg_pairs cdns_usb_ln_regs_ext_ssc[] = {
 	{0x4243, SIERRA_RXBUFFER_DFECTRL_PREG}
 };
 
+static struct cdns_sierra_vals usb_100_ext_ssc_cmn_vals = {
+	.reg_pairs = cdns_usb_cmn_regs_ext_ssc,
+	.num_regs = ARRAY_SIZE(cdns_usb_cmn_regs_ext_ssc),
+};
+
+static struct cdns_sierra_vals usb_100_ext_ssc_ln_vals = {
+	.reg_pairs = cdns_usb_ln_regs_ext_ssc,
+	.num_regs = ARRAY_SIZE(cdns_usb_ln_regs_ext_ssc),
+};
+
 static const struct cdns_sierra_data cdns_map_sierra = {
-	SIERRA_MACRO_ID,
-	0x2,
-	0x2,
-	ARRAY_SIZE(cdns_pcie_cmn_regs_ext_ssc),
-	ARRAY_SIZE(cdns_pcie_ln_regs_ext_ssc),
-	ARRAY_SIZE(cdns_usb_cmn_regs_ext_ssc),
-	ARRAY_SIZE(cdns_usb_ln_regs_ext_ssc),
-	cdns_pcie_cmn_regs_ext_ssc,
-	cdns_pcie_ln_regs_ext_ssc,
-	cdns_usb_cmn_regs_ext_ssc,
-	cdns_usb_ln_regs_ext_ssc,
+	.id_value = SIERRA_MACRO_ID,
+	.block_offset_shift = 0x2,
+	.reg_offset_shift = 0x2,
+	.pma_cmn_vals = {
+		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &pcie_100_ext_ssc_cmn_vals,
+			},
+		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &usb_100_ext_ssc_cmn_vals,
+			},
+		},
+	},
+	.pma_ln_vals = {
+		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &pcie_100_ext_ssc_ln_vals,
+			},
+		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &usb_100_ext_ssc_ln_vals,
+			},
+		},
+	},
 };
 
 static const struct cdns_sierra_data cdns_ti_map_sierra = {
-	SIERRA_MACRO_ID,
-	0x0,
-	0x1,
-	ARRAY_SIZE(cdns_pcie_cmn_regs_ext_ssc),
-	ARRAY_SIZE(cdns_pcie_ln_regs_ext_ssc),
-	ARRAY_SIZE(cdns_usb_cmn_regs_ext_ssc),
-	ARRAY_SIZE(cdns_usb_ln_regs_ext_ssc),
-	cdns_pcie_cmn_regs_ext_ssc,
-	cdns_pcie_ln_regs_ext_ssc,
-	cdns_usb_cmn_regs_ext_ssc,
-	cdns_usb_ln_regs_ext_ssc,
+	.id_value = SIERRA_MACRO_ID,
+	.block_offset_shift = 0x0,
+	.reg_offset_shift = 0x1,
+	.pma_cmn_vals = {
+		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &pcie_100_ext_ssc_cmn_vals,
+			},
+		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &usb_100_ext_ssc_cmn_vals,
+			},
+		},
+	},
+	.pma_ln_vals = {
+		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &pcie_100_ext_ssc_ln_vals,
+			},
+		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &usb_100_ext_ssc_ln_vals,
+			},
+		},
+	},
 };
 
 static const struct of_device_id cdns_sierra_id_table[] = {
-- 
2.26.1

