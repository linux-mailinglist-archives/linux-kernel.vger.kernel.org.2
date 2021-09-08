Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D6E4039CD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349123AbhIHMbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:31:02 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:17372 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348860AbhIHMbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:31:01 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1886dluE030522;
        Wed, 8 Sep 2021 05:29:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=QVW5zowOOqNka9NgAk8b1lOpt/DRuhTeb2B8vX5LFxU=;
 b=bDWWvwBzhGuEwA/SfcmwdFQGDwn3HjKV/MeVQOFIA/ZFDXFpa0MwshhY2BWT79gLkG3Y
 4Y0lpua/hI5VLTUHZd9KdEVuGj8UZRPL2UKeK1mnQHR3M+xsjL9+lqnWkwvBLSOO68Lr
 w104rW1w6uKNXK7+Abyu79ncoq6yjxid/x4oR0zoOIeGceQCSppXr8ysSNDIlVkeMAqJ
 0Ewi3M2m6cHnZjYhPcVznBf+qEvuBM3mwG98lD5IsdZzVrg1mwsURJQIGgLmzVnqGQXz
 9S0pGrWfQAW9ZFs1x4ND4gRumX1mR1cnNdRE9ynvBx2qANSLTXXq1kyNaevegNmhYhdr kw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3axcn5b0xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 05:29:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFjODxd6xoIVM1Mm55nQj325Vai5bm3RTD8fnx4UC0HbRnK0ejPrmVJNeqexRCLTEydKTmbYylVqvsCQuwRi/wHrzgJskdmToN6OB+OBmgaWUZ2nzupkBXwySbkazli3Dot+gpnIahqzL+KeIP76yJQ9ZllaFE8tY5YBnaDvHqpONBnHTg2wDBz+kpCs21kRGz5kuX+1kb2n5MJMKMo6qTIFQ+uqyqR6vX60EQodDKsPr8vXvgeMbFrd3YDdqmQJE9rXXbXTnZqCmDhX4PBnziFjKy8dg/ruQZ3UzuXOcv2YUT1EvFe8h9NzivuxDo3K9rXiag4iqkz6yB3ZHF6/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QVW5zowOOqNka9NgAk8b1lOpt/DRuhTeb2B8vX5LFxU=;
 b=ftFZfgKYbi60BCNoU+o2l9UPNSJt0NdUtQIh6xCs/OOFWDLvibYlnV8zBYpga2JFrL3mxz3UwE/r5Bx3QLH2OliQ+7w7Gf3gmLsEUyRm3e+BLXJRNGO6ra3jl66IM9VSRePK2q7qT3K8bIpFbXxlignXz6Xa4To2My1nUSmsJcxK5Oul/8Gc4aTade+Mo5M+0VtXKmfuUsspho9Go14BT+jTlZ7tU6e3LpHDmGHFcQgc5Xg3YDHbCk4OuwPUQ5eU4hVgzvPehCSi6LyHVtl7IWqB4k7xzay9NVY07XSP8WlQ3ejFR3fs+icTcY5bTJVu2ZYhOPScPCeeB3L2/BNSsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVW5zowOOqNka9NgAk8b1lOpt/DRuhTeb2B8vX5LFxU=;
 b=zt/yNTmqlpwAmHJzwv+zDOoF7pcuLeU7KDvWZSTB1IOM84kQnPAKWQO8e3SSFuHbE/neQC+DAOi+vR9tqAJF+sA18zt6QfUOBhuv7SMkWSEaaLInoVBgEe/kGVlUGP2Nijw9E1lo07dJg/Xp3XrEyw+7XtH0hNiLs7co1oDHC0c=
Received: from BN9PR03CA0860.namprd03.prod.outlook.com (2603:10b6:408:13d::25)
 by BN8PR07MB6194.namprd07.prod.outlook.com (2603:10b6:408:ba::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 12:29:39 +0000
Received: from BN8NAM12FT014.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::9d) by BN9PR03CA0860.outlook.office365.com
 (2603:10b6:408:13d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 12:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT014.mail.protection.outlook.com (10.13.183.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 12:29:39 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTX9P026939
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 05:29:37 -0700
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
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTWxI010292;
        Wed, 8 Sep 2021 14:29:32 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 188CTWN6010291;
        Wed, 8 Sep 2021 14:29:32 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH v2 06/15] phy: cadence: Sierra: Rename some regmap variables to be in sync with Sierra documentation
Date:   Wed, 8 Sep 2021 14:29:21 +0200
Message-ID: <20210908122930.10224-7-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210908122930.10224-1-sjakhade@cadence.com>
References: <20210908122930.10224-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09992880-a930-4495-7ab9-08d972c453a0
X-MS-TrafficTypeDiagnostic: BN8PR07MB6194:
X-Microsoft-Antispam-PRVS: <BN8PR07MB61947BC3EA3FDBEEBECEA3EDC5D49@BN8PR07MB6194.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a4RjDDDMW9++mpgajIdiPKZVgE3wsAZBuA0woxPp1a+mqPpBFi+Vz+1pRkdBVUde0BF0qYAbnEIHaUFMdIlYyxK8Y2ZpUI2hFlfnrXWskx5b/BuB5akoxFMcy+Wu1VDx9i5cabMD6/jvpZOLeN1CYwzYJTCOShzxbB/xHAfF93p9PAjJq/lggVuSKkuOcrk1gQtKWoCCv3d81VXa6dIMFYPHUIp4xoanxxcUhDTQ5FZsUWEnFB7/bOvxrmzi7HVLlsKf08DFJ7CT1QiVwlNygrZ80JfGDM3Yn6kOryfOtdJjfAFpiwLNhJveHvgsMHNFi41tZl6Q5fKnO8ri6WhcteToGy4qpGkTSTdXkJKsxHQ4+aNpueIblUICUB+8mjg5opieti1kqK9nSIBP34FHXMN23pl8zAR4dEneXhcdCtLb4Lh4cZR2YAslpjLsvRJgrFcYbhK5rNSgOVG8xiAHARK2KbRlVMNaIXbl3rsZlNsyhSR/VO9y1vFHlakbZ03uCl1Y74lLxziioeGA71JR0ohWeeOKtE5onp9LWqlAhaJ/WBkwtKbnI9NF/QsRROlweSJkh64O/mbUVS1JdSTLSTrh4E7jJLH8XZVmhYsu81OwI7POAWkSF21YeUHQiV9+kAkl45L0WSrQ4eJAzZfbZ/aKsUC0HfZEgGfm7vsL9+F1YjFIjG2B8wpISoeuY7SUJgNVvW2cdIn3QoudKY2RR5JplF3du91fzbcc58pwsuE=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(36092001)(46966006)(36840700001)(36860700001)(82310400003)(26005)(5660300002)(8936002)(186003)(478600001)(8676002)(336012)(426003)(2616005)(1076003)(86362001)(83380400001)(47076005)(36756003)(110136005)(4326008)(42186006)(70206006)(316002)(2906002)(54906003)(6666004)(70586007)(356005)(7636003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 12:29:39.0419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09992880-a930-4495-7ab9-08d972c453a0
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT014.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB6194
X-Proofpoint-ORIG-GUID: ka15s2M_ZxFWP4XzCMdyVrA-Gr77Q3bU
X-Proofpoint-GUID: ka15s2M_ZxFWP4XzCMdyVrA-Gr77Q3bU
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

No functional change. Rename some regmap variables as mentioned in Sierra
register description documentation.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 31e5d428dc03..a426b12447a7 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -145,8 +145,9 @@
 #define SIERRA_DEQ_TAU_CTRL1_FAST_MAINT_PREG		0x14F
 #define SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG		0x150
 
-#define SIERRA_PHY_CONFIG_CTRL_OFFSET(block_offset)	\
-				      (0xc000 << (block_offset))
+/* PHY PCS common registers */
+#define SIERRA_PHY_PCS_COMMON_OFFSET(block_offset)	\
+				     (0xc000 << (block_offset))
 #define SIERRA_PHY_PLL_CFG				0xe
 
 #define SIERRA_MACRO_ID					0x00007364
@@ -275,7 +276,7 @@ struct cdns_sierra_phy {
 	struct reset_control *phy_rst;
 	struct reset_control *apb_rst;
 	struct regmap *regmap_lane_cdb[SIERRA_MAX_LANES];
-	struct regmap *regmap_phy_config_ctrl;
+	struct regmap *regmap_phy_pcs_common_cdb;
 	struct regmap *regmap_common_cdb;
 	struct regmap_field *macro_id_type;
 	struct regmap_field *phy_pll_cfg_1;
@@ -346,8 +347,8 @@ static const struct regmap_config cdns_sierra_common_cdb_config = {
 	.reg_read = cdns_regmap_read,
 };
 
-static const struct regmap_config cdns_sierra_phy_config_ctrl_config = {
-	.name = "sierra_phy_config_ctrl",
+static const struct regmap_config cdns_sierra_phy_pcs_cmn_cdb_config = {
+	.name = "sierra_phy_pcs_cmn_cdb",
 	.reg_stride = 1,
 	.fast_io = true,
 	.reg_write = cdns_regmap_write,
@@ -689,7 +690,7 @@ static int cdns_regfield_init(struct cdns_sierra_phy *sp)
 		sp->cmn_refrcv_refclk_termen_preg[i] = field;
 	}
 
-	regmap = sp->regmap_phy_config_ctrl;
+	regmap = sp->regmap_phy_pcs_common_cdb;
 	field = devm_regmap_field_alloc(dev, regmap, phy_pll_cfg_1);
 	if (IS_ERR(field)) {
 		dev_err(dev, "PHY_PLL_CFG_1 reg field init failed\n");
@@ -741,14 +742,14 @@ static int cdns_regmap_init_blocks(struct cdns_sierra_phy *sp,
 	}
 	sp->regmap_common_cdb = regmap;
 
-	block_offset = SIERRA_PHY_CONFIG_CTRL_OFFSET(block_offset_shift);
+	block_offset = SIERRA_PHY_PCS_COMMON_OFFSET(block_offset_shift);
 	regmap = cdns_regmap_init(dev, base, block_offset, reg_offset_shift,
-				  &cdns_sierra_phy_config_ctrl_config);
+				  &cdns_sierra_phy_pcs_cmn_cdb_config);
 	if (IS_ERR(regmap)) {
-		dev_err(dev, "Failed to init PHY config and control regmap\n");
+		dev_err(dev, "Failed to init PHY PCS common CDB regmap\n");
 		return PTR_ERR(regmap);
 	}
-	sp->regmap_phy_config_ctrl = regmap;
+	sp->regmap_phy_pcs_common_cdb = regmap;
 
 	return 0;
 }
-- 
2.26.1

