Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111B64039E0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351485AbhIHMbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:31:37 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:28090 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348990AbhIHMbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:31:01 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1886dfYW030276;
        Wed, 8 Sep 2021 05:29:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=dN1H3/Pon1Y9WEDQfDoHUvfloP9gMocl2sA/vBwFrIk=;
 b=Zs5N5ur11r1B/WvIGT5P1ZHsU+vAZlIXyWuIOsVJszAWEBQNcpJsDSEo9kt/Wxjx3+C0
 RxD5uRsDGl6968S9SLG2hICmAs8jSZGK/Q3IqotBWZXkoLlUFRWTdEbzDbF/wiuAT6w3
 /zvjEKOvkho4GjSwyO+5SUIskK/NzdS8wWI5SqGOTlyxCf8CggkTbt15kCEQ/fj9bEos
 0dn/gobt8KxxB3sV89PBp+Qx4+W8ai3SSekQBEymKqM51S43P31KH7qpJ22lMj9Acvm9
 kiOcmSmmEHqgMW923/oqQcoVQouxBgvXrh6+6GDUZq9EH+3rzPmWXVZc9sJHDBzFoTuv tw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3axcn5b0x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 05:29:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anZuZ52icJQ2y+ckNB3nfBAddK8vHSB1mjqTQClt3DRhTWHezwxklbck3X5ZUyOpeA2AKm7EyY8tLK1v8qJ4PMEu5AjBKkGTdU9e4u1c7qAvg76ZBz9hVQI6AvFE2KUF94GICyEfQC2IiZ7WYlF7eigbAAKMA64XAvmOSpgcInlCmUs4cxGsAMgDIL51qItoCgXJm8FxJVqCOW7X4CdhDrYP9ObE/0V+noUG0U6NMJFk/GMyCAWQO+3kVgj5/KctU3oBC/Y6zAJIfJuflRznuQ2VwpakA2REogcMfq7Rdrx0MXN5J54vccovAY0Yw/hIeU4lKwCrKc/4J0HaX0KRbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=dN1H3/Pon1Y9WEDQfDoHUvfloP9gMocl2sA/vBwFrIk=;
 b=ODYP3pAUPlbevxcUCw9OjjJYioYqwugy57QIW5B8ZAVjOrOeOXtU5fBB62prZOuKiNt8EUi46QAVDXcKECBRII+Xu+JLVDO/AFM8K25bYLzgXVQQzmX75ktETIj//Wj8n1b5jPhsXiPQI5l4vPY34Wj9K8vOdcO4fsNf11+nqztB7kG2to75iZfToIspU/xS/SvOS9jKovfIcund/4b+Bgsm13baUtrSUIVmFWveW1j9E4yJiqF9fVUz7KiladscRJua8an5OgmwgubXa729ONPuTFKKzYmsg5yYEB210ygwKBPs6gaNUfrNYc0jZSJt8AFdXQI1kvVrDJXLcV7AyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dN1H3/Pon1Y9WEDQfDoHUvfloP9gMocl2sA/vBwFrIk=;
 b=SSZ4F1FQG4Ow/KIEDbChy7uG4wf/OegQHTA+8NH7iazmEHo0Ss3jWfLNl+puifdbLjIQVgL3pSBB4Eh4QRJqOS+RR97nMluGUEcx3EddqSg4pZYEDgTywBr2n/jjFiToXjt0SCngI97hK39OouimyJPY5CsVwerekAOMvytJGyU=
Received: from CO2PR04CA0081.namprd04.prod.outlook.com (2603:10b6:102:1::49)
 by SN4PR0701MB3677.namprd07.prod.outlook.com (2603:10b6:803:4a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 12:29:39 +0000
Received: from MW2NAM12FT066.eop-nam12.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::8b) by CO2PR04CA0081.outlook.office365.com
 (2603:10b6:102:1::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 12:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT066.mail.protection.outlook.com (10.13.181.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 12:29:38 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTX9N026939
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 05:29:36 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Sep 2021 14:29:32 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 8 Sep 2021 14:29:32 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 8 Sep 2021 14:29:32 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTWjl010276;
        Wed, 8 Sep 2021 14:29:32 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 188CTWa5010275;
        Wed, 8 Sep 2021 14:29:32 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH v2 02/15] phy: cadence: Sierra: Prepare driver to add support for multilink configurations
Date:   Wed, 8 Sep 2021 14:29:17 +0200
Message-ID: <20210908122930.10224-3-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210908122930.10224-1-sjakhade@cadence.com>
References: <20210908122930.10224-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2759c751-b298-4a82-ce40-08d972c45319
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3677:
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3677F1D92FB5D4E0B71F669AC5D49@SN4PR0701MB3677.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QIiUSykQ3ayDo4QDiqWRFupn1zQaEYqkvLfTpMKXZ2JS8VVDEfZk140FlfBg7hWz/12B9hLQmTjyRWSqrt1oQLT+t7tU3v7ehqRjge4IOf4t6VVxLMUZf10MS1B7O2Pck4mtmJJ7LsHk1kAOQ77gs93gIhZ+7sjyftuV6UKUmVR0zYdBBB7pXK/ipUOMvb7J5ciA6rERDjwltCyfPkINTiXtke9cM6moClSb+RMojFLwIlUZ+FXlQJMwpM2RWpj6qNIv6n/pQOxxyZcp/FAyDS0SGnMlSXctytCPlLdgc8Qy0LVLPFNK1WMvEcQ5XOKUGLkEPmaJBZyjxjuTgAphK1tF2CJz26zHrB3Z5ma98FvzYw85WumFmU/nunVIOw72R5z4UtYAlw9P1SPbwKdTrQBDW5van13wXAftVmtUjAYeypdAZsGGBYz01wjxrSOS9Jcai+HA0kAZEhO/KVvqVc9yw40UZg5bKoavQqnQNi0qULPDfFqiUX9/Li8yuvxd092vaQvIT5YVi37EH/r8rbTuCE6VURTDNcIUWc89/b0JK81fqTO9R4VfN2WhPDBZmbZFPBk1lXMIGQRKXqGXalI6x9YKmXuhT0SoLaRGplmDfb6y7fHraa+bS5BNTRlAvhSolm+wbLQFNk2NJdUyuNXSGmKwO9lm2gsVdWA7vyFn+hKol9MOwtnoypx/EbbGhhm7gZwI0SNJTOuPQEsgrBKfS3hgl3QbPsH5737r8/E=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(36092001)(46966006)(36840700001)(26005)(6666004)(4326008)(86362001)(186003)(83380400001)(1076003)(36756003)(316002)(5660300002)(82310400003)(2616005)(82740400003)(54906003)(70206006)(478600001)(110136005)(70586007)(426003)(19627235002)(8676002)(8936002)(42186006)(7636003)(356005)(336012)(36860700001)(47076005)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 12:29:38.2432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2759c751-b298-4a82-ce40-08d972c45319
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT066.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3677
X-Proofpoint-ORIG-GUID: K_PN2rx0s05muwID7M9DZvtpgy6wHH-H
X-Proofpoint-GUID: K_PN2rx0s05muwID7M9DZvtpgy6wHH-H
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

