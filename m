Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8264039E5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351776AbhIHMb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:31:59 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:20912 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1349177AbhIHMbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:31:04 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1886da7v016869;
        Wed, 8 Sep 2021 05:29:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=Nj8OXT04WwWhy8TcgMCwtkLbeGj5HrzoEApIZ+Ke8CY=;
 b=B+LAeO8NWWQErgS4SZz0gGRetUTGvcT7oUFCE3xC8rDk4Z1PsjCeLNDLZ5+bFzMUdI8A
 yHxlTNR6w/RymMtXmZ5i5BD06vc9xth9NIrhH4LtWD4tEKMjPV0a7sW98jH4TnGl+Fga
 5gAD41NSKchuRp8i8gNysPCytwyMcejLzHx0IUDmpngB/UU30GfZk8bQGSPmDTxK/jIy
 JUggdiCeC7IuIV9ABTIjl73yq2jcQmYGEtaAIQZStQ5dqHNEESAL86QKqzvVrx7Bznn3
 f7DHaQmnMV60Cg+1IYx84UZTf+BZ29RQPnoPUFy765fiJqbBd7ftoQI2Bc2FK2c48VEt Aw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3axcp9k487-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 05:29:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDYxJpT8vmbVF2k/1ufX7BKuDdTZ/OfYEZrEM7tYTeSKY5iW2H/VLtXDKPy5CFH5osnWFMXMoY3sWDRLAd+JAYq2kq0O92AkWxPj6dJ3niqMwBn89bKe2qZkOoDDLZyb0+J9LWP6BMdOgtD3FlpsuOR5EuvIVzHr0A+uyYP99FIi4rtk+w1h+VtBf73Zchjk/EumcdgdAPkdILne6WhjJmr109devFnQZ150shrRVPWNNFb9vwQYJ3bZd7RT+tJCWYOr3omK8WfFtIX95oZ1y+CRpoeSHB27+rXfodhLhFjYTl95SDPgK/r56vk9VYhFQp0d/T/3LQ1DMsIi226x2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Nj8OXT04WwWhy8TcgMCwtkLbeGj5HrzoEApIZ+Ke8CY=;
 b=b+yGXaYZCoCx4VbOzxUT2LR777HOZp0yLfyK3a5rjAGJZ4l10Kmst9h2Gkc16wcdz3GsSz8HOndAzKEBP/seH+r1WhrBkv/ieXhla+lt+kPDPt1C3LQkYp4KE3anWh0vcmSkM7ZYnLR0tPit1yEX1q7qqRHiAIU5eUhUkZ8q+WU2nOS8Av/ekpShi6t0yy8eFz/3Scyg2TqRG8rtiCAHAacZrtbCpB/+gESYlxVAvViFBP6FWg8Csy9Qkxlr853WEZdyPpHsYBzz0+aKtsQZMB58moKrAn35CL1XO0ALKYUoIPnBbjaZtkiBG1irbQN0gz4ingbHht/h/W2ql3MwdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nj8OXT04WwWhy8TcgMCwtkLbeGj5HrzoEApIZ+Ke8CY=;
 b=VOiIESUP4BfkowuqsY9KPjkmw/F4TOfprBypESSOsla5SsRFtNuqx7wZzVAf7KLAgNqXhICYnV4O2IZpmFPWvvIAExdZjj4gh44r766JTAe1hpS+UIwAFfvV9STLYpf0XVuWhZPUQiVKU2/GsCSs24erRjD166sfpCTNdWoZaBc=
Received: from BN9PR03CA0613.namprd03.prod.outlook.com (2603:10b6:408:106::18)
 by MWHPR07MB2767.namprd07.prod.outlook.com (2603:10b6:300:2a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Wed, 8 Sep
 2021 12:29:43 +0000
Received: from BN8NAM12FT047.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::d1) by BN9PR03CA0613.outlook.office365.com
 (2603:10b6:408:106::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Wed, 8 Sep 2021 12:29:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT047.mail.protection.outlook.com (10.13.183.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 12:29:42 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTX9V026939
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 05:29:41 -0700
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
 15.0.1497.2 via Frontend Transport; Wed, 8 Sep 2021 14:29:33 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTXvP010317;
        Wed, 8 Sep 2021 14:29:33 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 188CTXeY010316;
        Wed, 8 Sep 2021 14:29:33 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH v2 12/15] phy: cadence: Sierra: Add support for PHY multilink configurations
Date:   Wed, 8 Sep 2021 14:29:27 +0200
Message-ID: <20210908122930.10224-13-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210908122930.10224-1-sjakhade@cadence.com>
References: <20210908122930.10224-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d718e99b-3979-48b3-8680-08d972c455b6
X-MS-TrafficTypeDiagnostic: MWHPR07MB2767:
X-Microsoft-Antispam-PRVS: <MWHPR07MB2767C3C7EDE7B866E1B74648C5D49@MWHPR07MB2767.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QmezkuiDYV8XiRJNvivBhZI9RiOjDUxEfYpdzuJotLRUOEHcD/5I9Mb+UFOBP9y8OD6i2fLwZQ5LCeDhQKL9KjHR8oK5nGqyFkYy6fEuyuZwiwJUda5p2GYDWDBXY/liecD+3R1acE8Ty3ywX2Pv5J4GX2igOL3gyGCoLtBq9soBWReoND8Hg1VYJfGCFsTG9U5tGvPEXgTDGxJxZA7Q/LTbg2YqywPLt2VP7kLFjTvZe7q96PI3G/r8z1NINDkUZPowwyOGm9GWv7FD6JK3wG1xtwxublsjVd/f9t5dntCQh0VAckYmCdcjaFIOJ3SBfOt2M4NIM/1O7IC7KMeXDcVWV1xGiUbJ6LIihIew29udnGezB4x9yTlC09Qa+6/hwH0x2Ifyx7dHhNHS+L1qfLHuaskIJ8WAft1WC5LPMYkc4+mz+FJTbuwg1jN+pfbFAe51kX1Rd0DqpKJQucUjNs3KFDiknlBK3z30yRR6OflvbsebtZz5Zq8IkkccsmpNSufTd+8gw61hcGh2E9wxO+LPBk266gx4w4x14nANuvhs/YVRPy0MXFKvn+SeiAfhESiBatKKTxwqyKbJmG0evaPGn0w5NyRRSrViqL/8ckR/2vz4NnANAcMvlf2ERw/gsmzFWa7Z2upp1St28QFpVfM1lC1qpehNFf3moMXbi5QJBZBWRva1bxPjyNnjs469J0cieljV+97tNCI//EFZF7vc+rC3TU/zwAQhjZ8r01I=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(36092001)(36840700001)(46966006)(186003)(42186006)(478600001)(5660300002)(8676002)(110136005)(54906003)(82740400003)(82310400003)(356005)(26005)(316002)(2906002)(7636003)(6666004)(36860700001)(8936002)(70206006)(2616005)(426003)(47076005)(70586007)(1076003)(83380400001)(86362001)(36756003)(336012)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 12:29:42.5448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d718e99b-3979-48b3-8680-08d972c455b6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT047.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB2767
X-Proofpoint-GUID: o8joZt6hM7GMYTBMCzoxpqL7nw5KLyTh
X-Proofpoint-ORIG-GUID: o8joZt6hM7GMYTBMCzoxpqL7nw5KLyTh
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

Add support for multilink configuration of Sierra PHY. Currently,
maximum two links are supported.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 185 ++++++++++++++++++++++-
 1 file changed, 177 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index bab78322078e..fe5b9a2e58df 100644
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
+		/* PMA TX lane registers configurations */
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

