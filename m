Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED2F3FF9D5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 07:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhICFDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 01:03:15 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:17022 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233540AbhICFCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 01:02:22 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1830KKIT011808;
        Thu, 2 Sep 2021 22:01:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=Nj8OXT04WwWhy8TcgMCwtkLbeGj5HrzoEApIZ+Ke8CY=;
 b=BL8yoWITnsuabSmPvC1WgxhESj45EnbomZacgJG0x+u7nWcugQKy7WDmcDvcpFUijs+N
 lPFj3kFECVf79MPa7cLqswuS2iSdQCx1wPo1Md3Hma++dpRz/VGI5Vutr3JMGVTWGiys
 Q/64r7mndHpGKLbibN+SMMzYiGkEzQg4K8gOwB36O26ju6rYV+nEEOPLYhTNtnzuuGP8
 /4AXcpE0guiLN//XMIbt5hN8t1VjW1I6rkyL4jU9fRlZkkQwdwnle5aolrKp2avgbhWE
 lcnEzMdpPdfgfbPlzTLtK3GcVe2zznSkNIytbvkD4YajKt3itvPXQJmiW5w2Eqc66mkN oA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3atdvyek2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 22:01:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STMyhGFiMGc0fF0+tqulDpm7mc3iHR48ZHOaEYfOuApUg65JKYA3w9EGjwNB7TBWvXHwb/k2+kXZZ2SwuGwtTie8P08ZGkV6//QByQSx/2yWAwQv9G0Yi8v/dw1pjs3dVrpw3o6j9W4CzXYDcqUHjqdlZCeJb2p5nbpFPFwQwt6V5+L4PolADCfZyV2qhFSCK36yjGZkmsQcKUM61GnEMGe1Z6WhFVCenNPc525ya5FUhauQ1DiCz0IbhusaTwr6RrMXx8UjFv9AQylvK1VsIF8VwuuPBlCzllcgGcm97LKN5AXobs6FfX4A30pRAuK+0J6LBlWR2p6cHa5bLEhEtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Nj8OXT04WwWhy8TcgMCwtkLbeGj5HrzoEApIZ+Ke8CY=;
 b=AIPRIO+NvwvUkG+W9fo99ISgW1fB6KVxWtc6xbsiJZnA2QMqrTVy/+K0sayNVkZfB5I5mAfPfqXpoaVqob9s3GbBEQ1fOWWMArTQwDV6/B/BedWhyTkMGvGRqM6cRqVE7xM9JRubMNew1VBnZO7aOqOCOuls2oXbkon74MSmIp9TbfzbeeAYfx5mkIcPH//7LNpkC+sBzlcMnBSKmDDJXFnfl+FDQKx9CxBByQuOlnqcGKRnVKI1/gGO2Ug0JosDsaoewduQqQGLgKVkyZwWBAsD+DaEChsFGi72kxXUHY8ovfk4+c66enZjNsjU1F/2io0vBzT9jBps4B7zhj7I+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nj8OXT04WwWhy8TcgMCwtkLbeGj5HrzoEApIZ+Ke8CY=;
 b=ZsDi4G/mIn0hgpyK2OY4/72bjaJY38BiRutww/LL0NLP+z9+7KvBYrBdYO34oXzrZ7UdDWUZ9irsGYPejr3+zrf09Zr+wjTT4TlzDzLLFZMxDIyqAJCWgx790qyrrSDQZ1FBzrXwTpAHDioRXSiNMk65RTUo0Z24jKPa4vQCV6Y=
Received: from DM5PR08CA0042.namprd08.prod.outlook.com (2603:10b6:4:60::31) by
 CH2PR07MB6663.namprd07.prod.outlook.com (2603:10b6:610:2b::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.19; Fri, 3 Sep 2021 05:01:02 +0000
Received: from DM6NAM12FT050.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::b) by DM5PR08CA0042.outlook.office365.com
 (2603:10b6:4:60::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Fri, 3 Sep 2021 05:01:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT050.mail.protection.outlook.com (10.13.178.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Fri, 3 Sep 2021 05:01:02 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 18350ufZ020399
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Sep 2021 22:01:01 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Sep 2021 07:00:56 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 3 Sep 2021 07:00:56 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18350u8P025713;
        Fri, 3 Sep 2021 07:00:56 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18350uqG025712;
        Fri, 3 Sep 2021 07:00:56 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 11/14] phy: cadence: Sierra: Add support for PHY multilink configurations
Date:   Fri, 3 Sep 2021 07:00:51 +0200
Message-ID: <20210903050054.25627-12-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210903050054.25627-1-sjakhade@cadence.com>
References: <20210903050054.25627-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36928dd4-e05b-417e-f6be-08d96e97d40b
X-MS-TrafficTypeDiagnostic: CH2PR07MB6663:
X-Microsoft-Antispam-PRVS: <CH2PR07MB66634FFD08D7C7DA9D71B532C5CF9@CH2PR07MB6663.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ud8zI5vkuAKV3UhxCSkOliQdcntF9b/UKl9dUNLbvSwIKtrnTWS0qfMJrz7C57cWgOiASqIHD+SgV0D8I8+gMowuK3W0w3wtQtD5o5W0ZQz6YoGHMiidMU7HEl5vhxtgeofWzjkEjjQ1zZFzefDMsWu0SrpRI2TTVCdwJUGD/+6/VgH1c3nKKuYhUhNWqyK8yvJ3uDDf3VNkQpOU7qlFBNzVYT30YVpmjEGlbShFVpb8wuY/I+rcGIUjnGLII99mGm43rwfa3tQeWOqZjjw97vtl8nwLTP+X3FR73LuAIYQer6Z1AF9oaxJpxgRLosfrPhFPoR0ATplKcp9mTfAovRwNj7glScbp1V39Wmmpzt3TFNwRnbzIegteq6VQ8Xo7jQt0y+GAHyH8hoZjmWAg+E2UkRxBOsyYZCNarBumVWxk6BrqJ7z4O2DJdP8B8ptsHVKgU1I+AnaH8XzJSLrx5G+Upw8bHmfJREVjuBxElit9Endh44HyTXsZ+BBpTxAWhoJABimCqtN1Ty623BA+MlYk9pivVnGnWnwS414GfdjW/0sVG4BiV2UTptWivrzdtUd3H9ZNbTyvD+aEevAoNv87qo0dGoJ73wJ93xKtAY5dyumXTbgdScMnO5soAAhlt4/R3DVokGXQCch1xiasYsqT9+2I4oDMxN0yOCipuLXoSsDqu96aqRU+ynbPii0HQdRl7xrEc2QzxUoOGG6zLrVYFivjr0HNu2fH7AOKL8o=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(36092001)(36840700001)(46966006)(47076005)(110136005)(6666004)(42186006)(83380400001)(4326008)(2906002)(316002)(36860700001)(70586007)(70206006)(426003)(82310400003)(1076003)(54906003)(8676002)(7636003)(356005)(336012)(82740400003)(8936002)(5660300002)(2616005)(26005)(186003)(478600001)(36906005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 05:01:02.5437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36928dd4-e05b-417e-f6be-08d96e97d40b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT050.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB6663
X-Proofpoint-GUID: nG5O5Fkm-wmX6tCVbFHbPnkZvxMX6TKA
X-Proofpoint-ORIG-GUID: nG5O5Fkm-wmX6tCVbFHbPnkZvxMX6TKA
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

