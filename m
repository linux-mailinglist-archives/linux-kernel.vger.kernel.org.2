Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBDC3FF9BC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 07:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhICFCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 01:02:20 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:61812 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229561AbhICFCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 01:02:19 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 182NR44b011814;
        Thu, 2 Sep 2021 22:01:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=QVW5zowOOqNka9NgAk8b1lOpt/DRuhTeb2B8vX5LFxU=;
 b=l8YbrMvSNyYUsXWnDgGQwHlxsPPt797085+yvxLveOuB1CB2T/MgmzQ10DBrujzU5307
 /aJs5F4A3RmhlhmyZANDLw6eSGENdfc6CTUJHrzJFrUsLkFlGeJ2Tf8vRPE1ZUITbuNY
 WKva0cCCRq38O9x9Zv2CZbadYHLhIWqistyKj1E9ks8wyEWQ5allLpSgF4BgdkuN/y7i
 CTHEmnq1HTt/ELvDr/tyQ/0h0s4RbLRe4JdaAHuSz7Me2xcsjj5XjmfttKP15wiq+85G
 0OBukOQY0kebTF8Zs0HRkHIwVEWmcfEf2zsx02OPdzMqXbfxdtFfgRuPh5ciH3Jlprar Iw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3au8a18u3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 22:01:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rz+LsglG+vqQ6PtbV5hK4Umn01CQ0Hf2IZ313wJUUpPxnH+TO8EaA3CFifZKP7Tls8BsUODShMqS8gkXs5uw7qTpo+d5mB+DUx5N/NGTQMEPU8GfCh9brQoj4rvrSC84I8uMOKdXKPMyetxShqrIem6lObeVACxU2TE0u7U6Z0B6326Y8bM5CQ46NBzO7yZmzmHgEOixd7HyA+RAlwN6EO5VMB2C74r8ghbtD3cAT9Jbic0OXODD8y+G/VHKy/srTouz7IFCi2D0DaGZzoN/bhl8oEDl4+gGsNPWCiaeR9cGzd7zezExBGnYPo5ZsSoAN8YzIzhvqIijAJjHH6m7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QVW5zowOOqNka9NgAk8b1lOpt/DRuhTeb2B8vX5LFxU=;
 b=CFU7M63AA+EpWrco6Ll/cYAaexV/H4Vyl8Fyo/HPvYJhKb6AKoEkrNWOZNIJ2eH7MZ+5OAB5dozjhemMrgL6v13EPRpQtfzYICCid/HfTklfPlNC1NO39P4MoCImpFqo3RZsA5bFCd7Em4rpxknAkUhAf+LoXDe4NZnVEiT64PFE/wf6kqZ1UyZPCJsBrTFNgS+xPbyc/Qs7Gm32ejvcPa5xEUo1pd/C9j5O9+LNhYCGqrORWvOQwZSesHGC9Onf6bR9aR4BrtfxwC16Q2DxLn2/hOhxbIqm6hgxgZGnVDxoBbglkdjmRAA69QsdAIPgNQOFOuHn3W1s3l4OHU42zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVW5zowOOqNka9NgAk8b1lOpt/DRuhTeb2B8vX5LFxU=;
 b=vsNFUu02nfyo1k3B2orOwCH/4APkIpgW3DlDtDTCoaSKbNm4Nw3/5DXBFcmTWp5EmZt5haQodr3vNMaUfNkO7clMio0XkC1ZnbvlMOhdZfxIGyCH6lawZS3QZ0ilQxxcezip78AdWg8ucblwtyhVgfkl3LOemveVB4fCHi89RFk=
Received: from DS7PR03CA0220.namprd03.prod.outlook.com (2603:10b6:5:3ba::15)
 by CH0PR07MB8842.namprd07.prod.outlook.com (2603:10b6:610:102::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Fri, 3 Sep
 2021 05:01:01 +0000
Received: from DM6NAM12FT004.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::dd) by DS7PR03CA0220.outlook.office365.com
 (2603:10b6:5:3ba::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20 via Frontend
 Transport; Fri, 3 Sep 2021 05:01:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT004.mail.protection.outlook.com (10.13.178.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Fri, 3 Sep 2021 05:01:00 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 18350ufW020399
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Sep 2021 22:00:59 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Sep 2021 07:00:56 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 3 Sep 2021 07:00:56 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 3 Sep 2021 07:00:55 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18350uc2025689;
        Fri, 3 Sep 2021 07:00:56 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18350uIT025688;
        Fri, 3 Sep 2021 07:00:56 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 05/14] phy: cadence: Sierra: Rename some regmap variables to be in sync with Sierra documentation
Date:   Fri, 3 Sep 2021 07:00:45 +0200
Message-ID: <20210903050054.25627-6-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210903050054.25627-1-sjakhade@cadence.com>
References: <20210903050054.25627-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3060b555-ad28-44be-1fdc-08d96e97d306
X-MS-TrafficTypeDiagnostic: CH0PR07MB8842:
X-Microsoft-Antispam-PRVS: <CH0PR07MB88426FB25320F4F6F88FD9CCC5CF9@CH0PR07MB8842.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ufCO2Vb/qgyYDK1735GrenPrOLzdFxM7Pck9Zy5TIfCEIQaplLQnMpLIkbGsbDA9ZGPigO1SkIZ7nDlTs6nmA1F3ggaB/AHWz8xqRxIjSfGUyBwaCaHcFlLQhT128uSidsmacvS8hqPR/GpkPJ42SmJOAGIqGDKs7dGafXnJm9ymIH97o6I+7F81GdCNZIkOLd9XVSSaUG3I51gcKMdr+k8BsRtdR2dNmtMEFfrEOSQNO7ldrlVowyTlp/9s25ndzZKqlUtBHXPVoz5uqhCZtfMIePGKx4coa6gsuYWt0Isen9bJP4jPkIHw0dqQzOjSmHvbSn+hea4Lppuo6HLyFGcMV2K3ntu9uiwweX6bXQDQXIJ8fRUufo9bq7wPagg33AFKTTzz77GW6Mwsc+OH71ii32kyDLEucvAjBlmDpoNxlhGHlPCceXh2O0FixgRXtf+M3dGDRWTyHswSHQamBY+b8bg21BHeQwmh182mhWqi7ieAT28k2S+BVWWkVr+4GBJ2qksghdc6dLxglxfpDt0TQWjwx29b6xZQZt+90xbguZ9N2H2mKnwXpCh7lqkOP8FRg25XvZtqGWGn6+8Fwt3MDwypqeW+RdWnHzdNYZ/iOIr/PW5cDpyQCHIgglmLSMIbPV5lOWdtfExsFEAO2QBWdZthlLEOsORuCRtpRF+7LGlkFsV2esAxLAFrJLtNbZgVlicdpqyjMy0Bd9RdTMxRvCWhSLg4Wf4ZFNnq9Ts=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(36092001)(46966006)(36840700001)(1076003)(70586007)(47076005)(54906003)(110136005)(83380400001)(82310400003)(8676002)(42186006)(8936002)(82740400003)(70206006)(36756003)(2906002)(86362001)(336012)(7636003)(316002)(6666004)(5660300002)(426003)(478600001)(186003)(4326008)(26005)(2616005)(356005)(36906005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 05:01:00.8287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3060b555-ad28-44be-1fdc-08d96e97d306
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT004.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR07MB8842
X-Proofpoint-ORIG-GUID: fFTioZ-vuB7Ir4LZB6owo5JBNNgaErU0
X-Proofpoint-GUID: fFTioZ-vuB7Ir4LZB6owo5JBNNgaErU0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-03_01,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1011 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109030030
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

