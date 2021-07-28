Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27563D9163
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbhG1Oz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:55:59 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:37136 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237385AbhG1OzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:55:23 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SEjtrd024289;
        Wed, 28 Jul 2021 07:55:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=w26g4u9Pf/GU66oQjGWl+lDwhb3NSrsxXIBhUFy3AbM=;
 b=PJvCRJzapr+6+u8TfadtymKk2XUoJv1cVEHfQo853EBGtqVtRSVW3ovsB+cKD9A7JhEY
 CJ0KzdQzBnNnwQ8qnxbFP9DwWP21/it+SoRRddAtaJJvbZ1zuRzXTZcEE3iiUwi7UOKD
 IT5F2BhXAn+h9CToLOQxVnYblrIuyfnykgslnv+DkhB56g/Li9Oae4pD+LEuC3bCyaNw
 9rx0iyHv2fbGOkrh7pDhmn3+KlScYJNceWgf0pQwtGD0UQWsolg+rMJk3N4ZZni9Ykli
 JForSHliLqB2XV27dWMpsR2D1JqN4V9GzrOc1njW7GrWRulQAzf7rvP7zRwzHy4yPdQf SQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3a234aysc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 07:55:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/6lsWbxTAo0ms+IlCKoClQfkRt0+52I9T8dolbRYvUoMjBSFtbkKCeAnhvrjQJmiJgyZz2H7d0WLw37cFS065MBBW1FDFe3SciZGB2m7CL+RfsjgHhgWLbqqTAqnL2pBnBnu1igy8v6kS/bn7mCOc/xzRySsI67Fa772ABwyoiTzNvGDEmHX/N3EUWX2pbYjKyw6nTjQvSVZIo7ppcT4UVBPpYKETRjiRE2C7MKOI9EyPyftEyAgOD+nFlR1MbvqdmIfMJcZISnU3mOzeHNQ6bS+AI3f2+YSsGvqgXS4Sb3+h+JBLcM1Rlr7tiPPlYnJ+Xs3nZW5mlrnJyZGb68xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w26g4u9Pf/GU66oQjGWl+lDwhb3NSrsxXIBhUFy3AbM=;
 b=MKH0emkovhx4N7WYv0fvUECCRMZnCcZPn737q9abXySHDLw9b8SliJ4L6X9YLeFRIBidGuKyfe8D4dJFRTnAj9qSbhWRX9XNGXdOyyt4yRNZRrZj/H/mv7GuPT0KxFLblcz4Sdm5z4xPs7L9yEupLPO+rSbOhP02pxJ9EQWIIPJWXQa2w0PSkpodzQgpHHBZOIFFkU2UBFrxhsC+YgSaP3bbwryYp7h59savC9CwOABjTyf5DnU8T6p8vPs/O/WPsmXF6Rvb5miVwZ6SznhFsibaxZEyT9K+BAfUfsQUU7G/K5H8OLLp3yaGrDrlw5gtHrXhC/jXc1qcG9cGj5twYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w26g4u9Pf/GU66oQjGWl+lDwhb3NSrsxXIBhUFy3AbM=;
 b=g2IqWJvC/UtqTj3Mh33x3+CfBkT7dvxe6cjRh/8y+Tdv+3XUFrq2t9Poydr4PMae7ObzuA1cXYaS0C5EE6jaqm3m13zZ3mtttRefZzL4+3txlc+VWFjvl9siWp8DY2V+dWG06PzRxU5wV6jMlG2QPb1n72Qn3ZfddkcYB/ak1lw=
Received: from BN8PR16CA0001.namprd16.prod.outlook.com (2603:10b6:408:4c::14)
 by MWHPR07MB3600.namprd07.prod.outlook.com (2603:10b6:301:69::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Wed, 28 Jul
 2021 14:55:06 +0000
Received: from BN8NAM12FT050.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::18) by BN8PR16CA0001.outlook.office365.com
 (2603:10b6:408:4c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Wed, 28 Jul 2021 14:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT050.mail.protection.outlook.com (10.13.182.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.7 via Frontend Transport; Wed, 28 Jul 2021 14:55:04 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 16SEsvrw095664
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 07:55:03 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 28 Jul 2021 16:54:57 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 28 Jul 2021 16:54:57 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 16SEsv6H016557;
        Wed, 28 Jul 2021 16:54:57 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 16SEsvio016556;
        Wed, 28 Jul 2021 16:54:57 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH v3 9/9] phy: cadence-torrent: Check PIPE mode PHY status to be ready for operation
Date:   Wed, 28 Jul 2021 16:54:54 +0200
Message-ID: <20210728145454.15945-10-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210728145454.15945-1-sjakhade@cadence.com>
References: <20210728145454.15945-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed21cc94-80e8-408d-2bc8-08d951d7af3b
X-MS-TrafficTypeDiagnostic: MWHPR07MB3600:
X-Microsoft-Antispam-PRVS: <MWHPR07MB3600ABBAF6738F3753AA4FCCC5EA9@MWHPR07MB3600.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LiGNjFA5Ly5IB9feZeW+xqBXLLLPZJ+x2cKq4/hZ6VvPd13QvHCl299aKecCPxngWlfmpr8SZ+TxFiK4Qhk95B7ZFmzHEIEOsmsKlmh1nxlCNImPD7o2OPcP1nWELbfwjfmfmGWU3F3ZwUcTbk8IeFwSn/o9gYy5yIBPFh7BzWBxmzuzF3ijocBi5uvuqf68IkNEj+2G9WW+IPZ46cQlhQcl0DkA2JHexSUcuZYLwRbWz/G6dfA04SMLiF8NqNWpvb8klY3UM8zXBhUZtMJui77VD3La6W1H5QrLa65pGMU0YtI7zluTj1DHAFB6WaFessTNeb6x0GqmroVsBQA+c/RZs2KoOGxBKrD4eQdzD4KuYDQUMcTWRsvsfD9wpqrbG0W0xKXRk9w2mWA7Dkr5/hbQxlaKw4AziJng5PWi/Nd+XMMdEGk5iaNweoYaDM53/LSilqaN6RHXmY/P9yavjRdSHRfh78C2bsv/KOa01Tv2s/MbO94N3yfF2o2MggwYKUclJpVTKA1rynyWvVG/fMhLBznD8JF/lrZ9bIxcGYOEbNRxV1IrswH8GTa75TaSTAW1x8tkT4rzCxjwgIuvxmsjw8KLEKp7A51lTEZxhUjg5HWnVD//HERCNWNWus9DHizAYSH12javSTzQSg9qgkN+cQ+kobYYxAimvU0Ko9SGRA/5vQOwKMwgzEKVNeIz+MB0WBosCImpIlnW7T3Wu9qfzahMcz0WxHmujo3wZbBO/4fkkJdm3lPH2nyky3M9mK7OBVBKWqZvXDK7AzoE6DjTLrwvmCqWN1bZhf2XV0E=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(36092001)(46966006)(36840700001)(82310400003)(36756003)(42186006)(70206006)(2906002)(336012)(70586007)(478600001)(1076003)(81166007)(8936002)(47076005)(186003)(426003)(2616005)(316002)(36860700001)(54906003)(83380400001)(82740400003)(5660300002)(26005)(86362001)(8676002)(356005)(6666004)(110136005)(4326008)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 14:55:04.6986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed21cc94-80e8-408d-2bc8-08d951d7af3b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT050.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3600
X-Proofpoint-ORIG-GUID: J3lCZS7iRx_-xnqKUryJTPdTN7i6nvMD
X-Proofpoint-GUID: J3lCZS7iRx_-xnqKUryJTPdTN7i6nvMD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_08:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2107280082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PIPE PHY status is used to communicate the completion of several PHY
functions. Check if PHY is ready for operation while configured for
PIPE mode during startup.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 60 ++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 4024db052cf9..415ace64adc5 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -51,6 +51,10 @@
 #define TORRENT_PHY_PCS_COMMON_OFFSET(block_offset)	\
 				(0xC000 << (block_offset))
 
+#define TORRENT_PHY_PCS_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
+				((0xD000 << (block_offset)) +		\
+				(((ln) << 8) << (reg_offset)))
+
 #define TORRENT_PHY_PMA_COMMON_OFFSET(block_offset)	\
 				(0xE000 << (block_offset))
 
@@ -223,6 +227,9 @@
 #define PHY_PIPE_USB3_GEN2_POST_CFG0	0x0022U
 #define PHY_PIPE_USB3_GEN2_POST_CFG1	0x0023U
 
+/* PHY PCS lane registers */
+#define PHY_PCS_ISO_LINK_CTRL		0x000BU
+
 /* PHY PMA common registers */
 #define PHY_PMA_CMN_CTRL1		0x0000U
 #define PHY_PMA_CMN_CTRL2		0x0001U
@@ -247,6 +254,9 @@ static const struct reg_field phy_pma_pll_raw_ctrl =
 static const struct reg_field phy_reset_ctrl =
 				REG_FIELD(PHY_RESET, 8, 8);
 
+static const struct reg_field phy_pcs_iso_link_ctrl_1 =
+				REG_FIELD(PHY_PCS_ISO_LINK_CTRL, 1, 1);
+
 static const struct reg_field phy_pipe_cmn_ctrl1_0 = REG_FIELD(PHY_PIPE_CMN_CTRL1, 0, 0);
 
 #define REFCLK_OUT_NUM_CMN_CONFIG	5
@@ -315,12 +325,14 @@ struct cdns_torrent_phy {
 	struct regmap *regmap_phy_pma_common_cdb;
 	struct regmap *regmap_tx_lane_cdb[MAX_NUM_LANES];
 	struct regmap *regmap_rx_lane_cdb[MAX_NUM_LANES];
+	struct regmap *regmap_phy_pcs_lane_cdb[MAX_NUM_LANES];
 	struct regmap *regmap_dptx_phy_reg;
 	struct regmap_field *phy_pll_cfg;
 	struct regmap_field *phy_pma_cmn_ctrl_1;
 	struct regmap_field *phy_pma_cmn_ctrl_2;
 	struct regmap_field *phy_pma_pll_raw_ctrl;
 	struct regmap_field *phy_reset_ctrl;
+	struct regmap_field *phy_pcs_iso_link_ctrl_1[MAX_NUM_LANES];
 	struct clk *clks[CDNS_TORRENT_REFCLK_DRIVER + 1];
 	struct clk_onecell_data clk_data;
 };
@@ -455,6 +467,22 @@ static const struct regmap_config cdns_torrent_common_cdb_config = {
 	.reg_read = cdns_regmap_read,
 };
 
+#define TORRENT_PHY_PCS_LANE_CDB_REGMAP_CONF(n) \
+{ \
+	.name = "torrent_phy_pcs_lane" n "_cdb", \
+	.reg_stride = 1, \
+	.fast_io = true, \
+	.reg_write = cdns_regmap_write, \
+	.reg_read = cdns_regmap_read, \
+}
+
+static const struct regmap_config cdns_torrent_phy_pcs_lane_cdb_config[] = {
+	TORRENT_PHY_PCS_LANE_CDB_REGMAP_CONF("0"),
+	TORRENT_PHY_PCS_LANE_CDB_REGMAP_CONF("1"),
+	TORRENT_PHY_PCS_LANE_CDB_REGMAP_CONF("2"),
+	TORRENT_PHY_PCS_LANE_CDB_REGMAP_CONF("3"),
+};
+
 static const struct regmap_config cdns_torrent_phy_pcs_cmn_cdb_config = {
 	.name = "torrent_phy_pcs_cmn_cdb",
 	.reg_stride = 1,
@@ -1469,7 +1497,15 @@ static int cdns_torrent_phy_on(struct phy *phy)
 		return ret;
 	}
 
-	mdelay(10);
+	if (inst->phy_type == TYPE_PCIE || inst->phy_type == TYPE_USB) {
+		ret = regmap_field_read_poll_timeout(cdns_phy->phy_pcs_iso_link_ctrl_1[inst->mlane],
+						     read_val, !read_val, 1000,
+						     PLL_LOCK_TIMEOUT);
+		if (ret == -ETIMEDOUT) {
+			dev_err(cdns_phy->dev, "Timeout waiting for PHY status ready\n");
+			return ret;
+		}
+	}
 
 	return 0;
 }
@@ -1719,6 +1755,7 @@ static int cdns_torrent_regfield_init(struct cdns_torrent_phy *cdns_phy)
 	struct device *dev = cdns_phy->dev;
 	struct regmap_field *field;
 	struct regmap *regmap;
+	int i;
 
 	regmap = cdns_phy->regmap_phy_pcs_common_cdb;
 	field = devm_regmap_field_alloc(dev, regmap, phy_pll_cfg);
@@ -1752,6 +1789,16 @@ static int cdns_torrent_regfield_init(struct cdns_torrent_phy *cdns_phy)
 	}
 	cdns_phy->phy_pma_pll_raw_ctrl = field;
 
+	for (i = 0; i < MAX_NUM_LANES; i++) {
+		regmap = cdns_phy->regmap_phy_pcs_lane_cdb[i];
+		field = devm_regmap_field_alloc(dev, regmap, phy_pcs_iso_link_ctrl_1);
+		if (IS_ERR(field)) {
+			dev_err(dev, "PHY_PCS_ISO_LINK_CTRL reg field init for ln %d failed\n", i);
+			return PTR_ERR(field);
+		}
+		cdns_phy->phy_pcs_iso_link_ctrl_1[i] = field;
+	}
+
 	return 0;
 }
 
@@ -1812,6 +1859,17 @@ static int cdns_torrent_regmap_init(struct cdns_torrent_phy *cdns_phy)
 			return PTR_ERR(regmap);
 		}
 		cdns_phy->regmap_rx_lane_cdb[i] = regmap;
+
+		block_offset = TORRENT_PHY_PCS_LANE_CDB_OFFSET(i, block_offset_shift,
+							       reg_offset_shift);
+		regmap = cdns_regmap_init(dev, sd_base, block_offset,
+					  reg_offset_shift,
+					  &cdns_torrent_phy_pcs_lane_cdb_config[i]);
+		if (IS_ERR(regmap)) {
+			dev_err(dev, "Failed to init PHY PCS lane CDB regmap\n");
+			return PTR_ERR(regmap);
+		}
+		cdns_phy->regmap_phy_pcs_lane_cdb[i] = regmap;
 	}
 
 	block_offset = TORRENT_COMMON_CDB_OFFSET;
-- 
2.26.1

