Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D237A437B60
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbhJVRFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:05:51 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:5062 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233700AbhJVRFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:05:23 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MEhB1t008069;
        Fri, 22 Oct 2021 10:02:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=3fNMjXY5Yo3EUBn8euP3yHJDH41JACdnwDYdNTjWkps=;
 b=SzEIcS/5LNPsxQRbBtssSdZrLZyk7VB2BcYhHN6wxl48HoKY8eBo98g0bGANeq/sfSSB
 9wF3ZRVYNk+WTcvWkbq+ndsuJ0s0xmBHqpq27000VqooFM8HIothQOK7G9CMr/yB5v1o
 1u+uJe6xp9HXKA3onUnKyGWCdCM5JjdIOlsfscwvQeSloImJiYaDsDKxwUmC1YdQoUIA
 iEZj71QV29PyrAD+WnofLT5+8n7cTNwcjQ0sSP2Vmehf2lRUYBVUIcNXPeN4vTYxAEW1
 X+rfphzT6tr4yYvH/RpoNysVGg7UDUU/3OdkIkNzRDeJm7+U3WbeR5vaksOLTUE5ioY8 pA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3buxg0rm4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 10:02:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bS15a+Bwi+o+c9RubHSJ6ZWYXJNPjA3FYturKd8A00qQBBDYRqYN8NChmaDdIShaXgIEGT3u5oAZ3DvoQY1U7qhfRlh9Zz1BgRNC+pvv87gYfVORkUYtqU/NrwmoAstgcIh0bJQyFKBxyS04NtyYBFsNwLrvdLofXPAApsPN3ngPoYLBSZmHRjfWwiPBzbBEUeL7aXNomLDdBKg7fjmoNrBnXG6YvYK7z6Q69LGrQRCtt6FVw2KjYwPQkkzBRPnLnf4QyuskW+oJSGDjW+3fIICPqdqBoI0oUERFxRjznsyXNtYtutzNj+PhOL35Uuf6YRa/FcER8EfmQpJm0HdeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fNMjXY5Yo3EUBn8euP3yHJDH41JACdnwDYdNTjWkps=;
 b=K8k601rvvMoWCZawvQ+P87rHkwqZESqTefqDR8Tv9DYwHkvpU0b2REs9+QlOEYjxLKrFEOFfIzOIK6AG8ylVknJ30BI2fOsx+9Ql+xy1ZKBYJfWwJioIW+qioc81shjqauqwaXm95YYgJ3nhCCjNXzmDo+cQy0dVciQQXs7zEAHT6HEou54F4L7lDpH/ekxFE6Ynr6WAvum7eHJh4l3SEYldXM6UKKPIjUFnppZhY3Va3O8JB6Hh0VwP3O9hi3BvAfb8GQ5zFAl+PoQfew2BSbG4sddtrkuPbWzkazD+ijSs5h6SJYQwQ9kgs7J9sYypIP3eAvtn03JdWcjUZ3IjKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fNMjXY5Yo3EUBn8euP3yHJDH41JACdnwDYdNTjWkps=;
 b=aTx1Z/fFYMvNSC7H7Lu5Fl2O1yrcFQY0LB36IpK1YCNbzBCGVDcvkyNRh/BjRWX8dtCQv6Uz1IuGfby5bA055Ysixthih8t849kG6V2aBm7r1gJuBVSq1J4QYiZ5UyeduY0yeu4f5wFdusrBFLq1QpsLuA1OAfjQ0HqJeqOaZeA=
Received: from MWHPR10CA0008.namprd10.prod.outlook.com (2603:10b6:301::18) by
 MN2PR07MB6174.namprd07.prod.outlook.com (2603:10b6:208:110::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 17:02:50 +0000
Received: from MW2NAM12FT044.eop-nam12.prod.protection.outlook.com
 (2603:10b6:301:0:cafe::b3) by MWHPR10CA0008.outlook.office365.com
 (2603:10b6:301::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Fri, 22 Oct 2021 17:02:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT044.mail.protection.outlook.com (10.13.180.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.8 via Frontend Transport; Fri, 22 Oct 2021 17:02:50 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2iNK008564
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 10:02:49 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Oct 2021 19:02:39 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 22 Oct 2021 19:02:38 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 22 Oct 2021 19:02:38 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2cGx018894;
        Fri, 22 Oct 2021 19:02:38 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 19MH2cXk018893;
        Fri, 22 Oct 2021 19:02:38 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v3 02/15] phy: cadence: Sierra: Prepare driver to add support for multilink configurations
Date:   Fri, 22 Oct 2021 19:02:23 +0200
Message-ID: <20211022170236.18839-3-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211022170236.18839-1-sjakhade@cadence.com>
References: <20211022170236.18839-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11dd9ace-c83c-48b4-10c3-08d9957dc79a
X-MS-TrafficTypeDiagnostic: MN2PR07MB6174:
X-Microsoft-Antispam-PRVS: <MN2PR07MB6174D97CD01C21BED2C5F261C5809@MN2PR07MB6174.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:595;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l4OBU1zTbcD2WgXR67mxrty7o1wNz+BW0NSuJVpPnJHtFdPHQWadLAIKnMunfByhli6NFXCu+3f+/w6FFkdlsJHOVL2cOLM8gHJgOvpcJOaf5eraFCFHtM4ExSt02K6TrpiOhpqGOaeH0UjaCXmj6of1iC7YK4vtkDPwcMRmSk7eCFzEEh/Nwv5SjmUzmV7XRaT8Xwr/vgSKqt91GkNSG1PTHY4Nx4cj/w9WBKx+7c0d7M1X2sHC56Epi/rDOsRFEII9al14N85DNSYQSZEpcApyBmcqpbaZKar+gXJ9B3NR2OIKtE57ytCahXe/cEyVPYS4QaISLm+LWEv8LOKXjWnyVZZDSncesknjsDCkON32u9AEIjZM7PKCfLkae/H9iGiKWrzcO279r+rJJc8CdcB/0Im5S4C0sCRIhLXLEADtX7TS9kknlR1uJUUdwqwIQyOieK8ivRNUTvgXNB07j2mb05WUZrbrRZNlM9iKlYxvBT4CJPbWr03NEySq0D5JtMIMQWJkCzANk+PHY5yFPa4hqiEUx/ZzyKpcCvFISASEqLeSygNqdcbs7EdmX+bGbmyazIL/af/k+C9LiE3/n1CYPkHtS0UQeizDel70kchrZDvo+0C2zOiNIXjRzEgcZx7KgMgq4DWl/kQTkZw8/ZYMpD731m3qUFLrBkWyRUbhNy92qULWOH8DyoPIcXndCEhYB05sxU9zVm/ggPPXwKzSSdOl02GCqcV8w8Ij+IU=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(46966006)(36840700001)(36860700001)(86362001)(82310400003)(36756003)(6666004)(508600001)(186003)(19627235002)(26005)(336012)(47076005)(4326008)(2616005)(1076003)(8936002)(70206006)(8676002)(5660300002)(70586007)(54906003)(110136005)(7636003)(2906002)(426003)(36906005)(42186006)(316002)(356005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 17:02:50.1239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dd9ace-c83c-48b4-10c3-08d9957dc79a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT044.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6174
X-Proofpoint-GUID: t8kYKpTTPZsbuScSeDMWH2HmnibHvkye
X-Proofpoint-ORIG-GUID: t8kYKpTTPZsbuScSeDMWH2HmnibHvkye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_04,2021-10-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110220099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sierra driver currently supports single link configurations only. Prepare
driver to support multilink multiprotocol configurations along with
different SSC modes.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 195 ++++++++++++++++-------
 1 file changed, 139 insertions(+), 56 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 54d1c63932ac..c82ac6716f5e 100644
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
+	/* PMA lane registers configurations */
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

