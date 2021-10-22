Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A20437B53
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbhJVRFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:05:30 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:10034 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233617AbhJVRFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:05:22 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MEGsnf028858;
        Fri, 22 Oct 2021 10:02:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=1p2a3fWZ97dQn8TPwA1CtbNk9JjzUHVc91jrKVhRVdI=;
 b=R/0suApabnF8ZSaCWVXILvXu90Pwu2l+7NmomRM90cMaKZFmdKOY8hXu/xyBQyiPuf9R
 njSZNf7dOpmIqkrJ9CuInZ/dlJxah7tFJg9j2U0A873Sjmv07Z/QwU/KL6q2uw6DkE8X
 dJZi+wA6+muuJaC7zGBzGAypR3bvlA+M6aBQnCVkXrJZRQgEv5hf1NJ9BWCt2F4qCCHu
 jESxKichDs/vXAo93XVWEkJJMmshn9Lwv+leUeBeBhUJO+UsSf/YTEN5EKBnMCZ5WjAm
 220g3rrP0CpkaZK/H1xATUzYy94BRN9M/cXRIfBpgcDn9Ji136UpiyD6Rou9i61a6BPM Lg== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3buxg0rm4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 10:02:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiPAPmB07e4sJyu5R1sfQS3iUVqfYh94buQndPfUwu66y9DSG9LzMscEBRTle4kKiOpAkPXifybDI8vEnAMBzwkq3R3kAUK6NOCJt1GDQ88/a+H7OJtgm4hZqspynOXo6yHURdhWYco6yD/HoqC6a07Urg+Kh2evf+SPAh7E4WCDtD9ioNRbR1c0hYfezhMTvHs7yEsxBxQ7R9v3QdGP8r+VWivwRZL0p7tDVTARq40kdkYIX6xkPVfzBVk+pmeMv/f6yg0T8AR0axDPPe1tW7H2IKs2U4tReqZWHEgPPy0UPGl7JDgvvzxKSAJwhCf6s2TeO+l2cS0+baHdlBWnqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1p2a3fWZ97dQn8TPwA1CtbNk9JjzUHVc91jrKVhRVdI=;
 b=DCp0yTMzggCVFASKgH5Wm27/zjL+u+k2h1df+eqnXmN5Yr8ooFG0piWndMoJqNa90RGOJfUrV54xa5tmpGttjzRG2dwvLNHT1SKHxdw0MHoWO7idQkKud9KVkxPpRVc6f+2PdWnIQ/qOuRa7uk3q6b3VfKes2yLra/8wersMwdoVSJkPuzGUSDt26Crox+rTj7gAZqdqDkI9EqKLAQ528uk64cg0Qo2nBsNVI7y1pzCy5mf/o0kGSlZ4sta0hHFeMycnGHhoO6cHo2YfJvfB5pweP0cwj/qOVG5mew0BqqvGL8LcaaH0NRUfGqpcvJN6iTSkgo34GjhUQ8QRJQKQnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1p2a3fWZ97dQn8TPwA1CtbNk9JjzUHVc91jrKVhRVdI=;
 b=avkdyaeLFrzVICdORLnvWUUMbUlR5bEELi1bQRT2X/GZ57UCkCwCQx9XUtEofdhHacFXPYalUIrDJiN1sDxm/NQuJP+SVbN/kSPTxEiQorpWS6CFrGpd0x05Hd7yuV4rAi+6BQ/Pc91itBIyoY0x5cTzgn/3ijKq4NB0IAcLdt8=
Received: from MW3PR05CA0012.namprd05.prod.outlook.com (2603:10b6:303:2b::17)
 by BN6PR07MB3860.namprd07.prod.outlook.com (2603:10b6:404:b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 22 Oct
 2021 17:02:52 +0000
Received: from MW2NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::6) by MW3PR05CA0012.outlook.office365.com
 (2603:10b6:303:2b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.11 via Frontend
 Transport; Fri, 22 Oct 2021 17:02:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT056.mail.protection.outlook.com (10.13.181.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.8 via Frontend Transport; Fri, 22 Oct 2021 17:02:52 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2iNO008564
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 10:02:52 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Oct 2021 19:02:39 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 22 Oct 2021 19:02:39 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2dpp018937;
        Fri, 22 Oct 2021 19:02:39 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 19MH2df8018936;
        Fri, 22 Oct 2021 19:02:39 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v3 12/15] phy: cadence: Sierra: Add support for PHY multilink configurations
Date:   Fri, 22 Oct 2021 19:02:33 +0200
Message-ID: <20211022170236.18839-13-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211022170236.18839-1-sjakhade@cadence.com>
References: <20211022170236.18839-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 641092e6-6816-4917-5831-08d9957dc8f7
X-MS-TrafficTypeDiagnostic: BN6PR07MB3860:
X-Microsoft-Antispam-PRVS: <BN6PR07MB386037A26ECB445DDAF507A5C5809@BN6PR07MB3860.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1c7XMgC6o3FSo+hjzgr3s9JWTLjub+AIex424PUYaA46iWb9VawcrIHjuZ+eIindIUSFoIvWXu3NVkeveJkiovhhEh4jqe3qFZ9izxoF23x4PikFeNqWOGHuZ/3sTjZZtZPj+4q/LdDk/bX/lKl/NfRnHpM5AUvmjmKcUs/7ZbbRqIEGeOUuqMaZ/lTt+80YYT3NvT6AOQ14t/fTehmKiQdHWGJRhqqIhOwkrELcenDcKevbJetqmzl6G315q+jfC3n4Zjq/1Mj+nxxVbAe/Wr7IQDN71h72bBEVMtwS07TLzuz9vyFcETj8FmCX4OK4AHJCS0B+PlncB/maMWPzosq/T5Uz0iEr1ZSXjLO2N9Buz+HUXSgtFvEyCV6b42UJjpY0PEuUlTzx/HCW3+dL7NMBcwCT11sQy5TISbIBckNYjubApecBLg1e2la2iw6I2yBQPQQ/e4FWzrowks3OXnvoUKt9IDaxgGu4kvJXsyLHllGNVZVmV9JfLmeWQRJmd1eixDVDXNIpVNPIFc5U3Tq0UidcewiBkFU3W0RNlrZSG7C3e471LtMrQErvE7WQ5Rzf7bQMwe18LQW0dpype1MuoJ/uRE/9gyzNndox+O8FjAH9k39yYnO4r3JYbhZmO2hFfNWPy43lBVSqGw9lxmYKawDgIvVf6pM25BdDYTxqwagI+fmkhUCi+uZtLVwmirVqz0ri/xLwFQXLNRBhaA2nwiWoGUQ7yzA9t4JmqcE=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(1076003)(8676002)(70206006)(426003)(36860700001)(26005)(186003)(356005)(110136005)(54906003)(2616005)(7636003)(86362001)(5660300002)(36756003)(6666004)(82310400003)(70586007)(336012)(47076005)(316002)(42186006)(2906002)(4326008)(36906005)(83380400001)(508600001)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 17:02:52.4109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 641092e6-6816-4917-5831-08d9957dc8f7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT056.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3860
X-Proofpoint-GUID: smJ5JY6vwWpLdsgIEdhSCwrM60LqrPE1
X-Proofpoint-ORIG-GUID: smJ5JY6vwWpLdsgIEdhSCwrM60LqrPE1
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

Add support for multilink configuration of Sierra PHY. Currently,
maximum two links are supported.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 185 ++++++++++++++++++++++-
 1 file changed, 177 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index abdbc6ebd5a8..a39be67424a1 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -24,7 +24,7 @@
 #include <dt-bindings/phy/phy-cadence.h>
 
 #define NUM_SSC_MODE		3
-#define NUM_PHY_TYPE		3
+#define NUM_PHY_TYPE		4
 
 /* PHY register offsets */
 #define SIERRA_COMMON_CDB_OFFSET			0x0
@@ -184,6 +184,13 @@
 				     (0xE000 << (block_offset))
 #define SIERRA_PHY_PMA_CMN_CTRL				0x000
 
+/* PHY PMA lane registers */
+#define SIERRA_PHY_PMA_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
+				       ((0xF000 << (block_offset)) +	\
+				       (((ln) << 8) << (reg_offset)))
+
+#define SIERRA_PHY_PMA_XCVR_CTRL			0x000
+
 #define SIERRA_MACRO_ID					0x00007364
 #define SIERRA_MAX_LANES				16
 #define PLL_LOCK_TIME					100000
@@ -299,6 +306,8 @@ struct cdns_sierra_data {
 	u8 reg_offset_shift;
 	struct cdns_sierra_vals *pcs_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
 					     [NUM_SSC_MODE];
+	struct cdns_sierra_vals *phy_pma_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
+						[NUM_SSC_MODE];
 	struct cdns_sierra_vals *pma_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
 					     [NUM_SSC_MODE];
 	struct cdns_sierra_vals *pma_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
@@ -322,6 +331,7 @@ struct cdns_sierra_phy {
 	struct regmap *regmap_phy_pcs_common_cdb;
 	struct regmap *regmap_phy_pcs_lane_cdb[SIERRA_MAX_LANES];
 	struct regmap *regmap_phy_pma_common_cdb;
+	struct regmap *regmap_phy_pma_lane_cdb[SIERRA_MAX_LANES];
 	struct regmap *regmap_common_cdb;
 	struct regmap_field *macro_id_type;
 	struct regmap_field *phy_pll_cfg_1;
@@ -438,6 +448,34 @@ static const struct regmap_config cdns_sierra_phy_pma_cmn_cdb_config = {
 	.reg_read = cdns_regmap_read,
 };
 
+#define SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF(n) \
+{ \
+	.name = "sierra_phy_pma_lane" n "_cdb", \
+	.reg_stride = 1, \
+	.fast_io = true, \
+	.reg_write = cdns_regmap_write, \
+	.reg_read = cdns_regmap_read, \
+}
+
+static const struct regmap_config cdns_sierra_phy_pma_lane_cdb_config[] = {
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("0"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("1"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("2"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("3"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("4"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("5"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("6"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("7"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("8"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("9"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("10"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("11"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("12"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("13"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("14"),
+	SIERRA_PHY_PMA_LANE_CDB_REGMAP_CONF("15"),
+};
+
 static int cdns_sierra_phy_init(struct phy *gphy)
 {
 	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
@@ -446,6 +484,7 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 	struct cdns_sierra_vals *pma_cmn_vals, *pma_ln_vals;
 	enum cdns_sierra_phy_type phy_type = ins->phy_type;
 	enum cdns_sierra_ssc_mode ssc = ins->ssc_mode;
+	struct cdns_sierra_vals *phy_pma_ln_vals;
 	const struct cdns_reg_pairs *reg_pairs;
 	struct cdns_sierra_vals *pcs_cmn_vals;
 	struct regmap *regmap;
@@ -453,7 +492,7 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 	int i, j;
 
 	/* Initialise the PHY registers, unless auto configured */
-	if (phy->autoconf)
+	if (phy->autoconf || phy->nsubnodes > 1)
 		return 0;
 
 	clk_set_rate(phy->input_clks[CMN_REFCLK_DIG_DIV], 25000000);
@@ -469,6 +508,18 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 			regmap_write(regmap, reg_pairs[i].off, reg_pairs[i].val);
 	}
 
+	/* PHY PMA lane registers configurations */
+	phy_pma_ln_vals = init_data->phy_pma_ln_vals[phy_type][TYPE_NONE][ssc];
+	if (phy_pma_ln_vals) {
+		reg_pairs = phy_pma_ln_vals->reg_pairs;
+		num_regs = phy_pma_ln_vals->num_regs;
+		for (i = 0; i < ins->num_lanes; i++) {
+			regmap = phy->regmap_phy_pma_lane_cdb[i + ins->mlane];
+			for (j = 0; j < num_regs; j++)
+				regmap_write(regmap, reg_pairs[j].off, reg_pairs[j].val);
+		}
+	}
+
 	/* PMA common registers configurations */
 	pma_cmn_vals = init_data->pma_cmn_vals[phy_type][TYPE_NONE][ssc];
 	if (pma_cmn_vals) {
@@ -502,10 +553,13 @@ static int cdns_sierra_phy_on(struct phy *gphy)
 	u32 val;
 	int ret;
 
-	ret = reset_control_deassert(sp->phy_rst);
-	if (ret) {
-		dev_err(dev, "Failed to take the PHY out of reset\n");
-		return ret;
+	if (sp->nsubnodes == 1) {
+		/* Take the PHY out of reset */
+		ret = reset_control_deassert(sp->phy_rst);
+		if (ret) {
+			dev_err(dev, "Failed to take the PHY out of reset\n");
+			return ret;
+		}
 	}
 
 	/* Take the PHY lane group out of reset */
@@ -923,6 +977,19 @@ static int cdns_regmap_init_blocks(struct cdns_sierra_phy *sp,
 	}
 	sp->regmap_phy_pma_common_cdb = regmap;
 
+	for (i = 0; i < SIERRA_MAX_LANES; i++) {
+		block_offset = SIERRA_PHY_PMA_LANE_CDB_OFFSET(i, block_offset_shift,
+							      reg_offset_shift);
+		regmap = cdns_regmap_init(dev, base, block_offset,
+					  reg_offset_shift,
+					  &cdns_sierra_phy_pma_lane_cdb_config[i]);
+		if (IS_ERR(regmap)) {
+			dev_err(dev, "Failed to init PHY PMA lane CDB regmap\n");
+			return PTR_ERR(regmap);
+		}
+		sp->regmap_phy_pma_lane_cdb[i] = regmap;
+	}
+
 	return 0;
 }
 
@@ -1030,6 +1097,105 @@ static int cdns_sierra_phy_get_resets(struct cdns_sierra_phy *sp,
 	return 0;
 }
 
+static int cdns_sierra_phy_configure_multilink(struct cdns_sierra_phy *sp)
+{
+	const struct cdns_sierra_data *init_data = sp->init_data;
+	enum cdns_sierra_phy_type phy_t1, phy_t2, tmp_phy_type;
+	struct cdns_sierra_vals *pma_cmn_vals, *pma_ln_vals;
+	struct cdns_sierra_vals *phy_pma_ln_vals;
+	const struct cdns_reg_pairs *reg_pairs;
+	struct cdns_sierra_vals *pcs_cmn_vals;
+	int i, j, node, mlane, num_lanes, ret;
+	enum cdns_sierra_ssc_mode ssc;
+	struct regmap *regmap;
+	u32 num_regs;
+
+	/* Maximum 2 links (subnodes) are supported */
+	if (sp->nsubnodes != 2)
+		return -EINVAL;
+
+	clk_set_rate(sp->input_clks[CMN_REFCLK_DIG_DIV], 25000000);
+	clk_set_rate(sp->input_clks[CMN_REFCLK1_DIG_DIV], 25000000);
+
+	/* PHY configured to use both PLL LC and LC1 */
+	regmap_field_write(sp->phy_pll_cfg_1, 0x1);
+
+	phy_t1 = sp->phys[0].phy_type;
+	phy_t2 = sp->phys[1].phy_type;
+
+	/*
+	 * First configure the PHY for first link with phy_t1. Get the array
+	 * values as [phy_t1][phy_t2][ssc].
+	 */
+	for (node = 0; node < sp->nsubnodes; node++) {
+		if (node == 1) {
+			/*
+			 * If first link with phy_t1 is configured, then
+			 * configure the PHY for second link with phy_t2.
+			 * Get the array values as [phy_t2][phy_t1][ssc].
+			 */
+			tmp_phy_type = phy_t1;
+			phy_t1 = phy_t2;
+			phy_t2 = tmp_phy_type;
+		}
+
+		mlane = sp->phys[node].mlane;
+		ssc = sp->phys[node].ssc_mode;
+		num_lanes = sp->phys[node].num_lanes;
+
+		/* PHY PCS common registers configurations */
+		pcs_cmn_vals = init_data->pcs_cmn_vals[phy_t1][phy_t2][ssc];
+		if (pcs_cmn_vals) {
+			reg_pairs = pcs_cmn_vals->reg_pairs;
+			num_regs = pcs_cmn_vals->num_regs;
+			regmap = sp->regmap_phy_pcs_common_cdb;
+			for (i = 0; i < num_regs; i++)
+				regmap_write(regmap, reg_pairs[i].off, reg_pairs[i].val);
+		}
+
+		/* PHY PMA lane registers configurations */
+		phy_pma_ln_vals = init_data->phy_pma_ln_vals[phy_t1][phy_t2][ssc];
+		if (phy_pma_ln_vals) {
+			reg_pairs = phy_pma_ln_vals->reg_pairs;
+			num_regs = phy_pma_ln_vals->num_regs;
+			for (i = 0; i < num_lanes; i++) {
+				regmap = sp->regmap_phy_pma_lane_cdb[i + mlane];
+				for (j = 0; j < num_regs; j++)
+					regmap_write(regmap, reg_pairs[j].off, reg_pairs[j].val);
+			}
+		}
+
+		/* PMA common registers configurations */
+		pma_cmn_vals = init_data->pma_cmn_vals[phy_t1][phy_t2][ssc];
+		if (pma_cmn_vals) {
+			reg_pairs = pma_cmn_vals->reg_pairs;
+			num_regs = pma_cmn_vals->num_regs;
+			regmap = sp->regmap_common_cdb;
+			for (i = 0; i < num_regs; i++)
+				regmap_write(regmap, reg_pairs[i].off, reg_pairs[i].val);
+		}
+
+		/* PMA lane registers configurations */
+		pma_ln_vals = init_data->pma_ln_vals[phy_t1][phy_t2][ssc];
+		if (pma_ln_vals) {
+			reg_pairs = pma_ln_vals->reg_pairs;
+			num_regs = pma_ln_vals->num_regs;
+			for (i = 0; i < num_lanes; i++) {
+				regmap = sp->regmap_lane_cdb[i + mlane];
+				for (j = 0; j < num_regs; j++)
+					regmap_write(regmap, reg_pairs[j].off, reg_pairs[j].val);
+			}
+		}
+	}
+
+	/* Take the PHY out of reset */
+	ret = reset_control_deassert(sp->phy_rst);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int cdns_sierra_phy_probe(struct platform_device *pdev)
 {
 	struct cdns_sierra_phy *sp;
@@ -1149,8 +1315,11 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	}
 
 	/* If more than one subnode, configure the PHY as multilink */
-	if (!sp->autoconf && sp->nsubnodes > 1)
-		regmap_field_write(sp->phy_pll_cfg_1, 0x1);
+	if (!sp->autoconf && sp->nsubnodes > 1) {
+		ret = cdns_sierra_phy_configure_multilink(sp);
+		if (ret)
+			goto put_child2;
+	}
 
 	pm_runtime_enable(dev);
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
-- 
2.26.1

