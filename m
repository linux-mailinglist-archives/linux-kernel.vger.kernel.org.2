Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E0C437B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhJVRFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:05:41 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:8616 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233690AbhJVRFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:05:23 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MEgUi7012922;
        Fri, 22 Oct 2021 10:02:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=rJ5LvbsV6vF+hIBAZ7qS5ZxOtvz1rhEcV0aiXNdI7sI=;
 b=fS/k76Tiy957jc0BUihVJkNdexnugvBVcM/BFRMGFE89vg90GhJXPnSiLMH9me2mI8n5
 C/7A4Gqt+daTQuw+oUPJvotgNi9Rmmuj62PUzSDxJ19/fgGFsnpdi2OvkxZUGGU16xqF
 JgJeQWHztdgeHykXzUYbVYJEtz3560llI9O4MYLpHlZ08woX6KYYUuV9YlPImvV3vOlR
 rW+kSEIzY7ClRFmX0u2JmLgoX2f60hsBdX4UwVEXQim5fWFsbXxCdTH+BbsxVLvkq/ho
 Np47JGJXygT5kLbpPCBmr/blw4o3Za2KMs+IM5GPWzLwbWlzSCUAVkDXwPy+PSbPNAAn CA== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3buya2rest-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 10:02:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoffKtARQNyUo7Me6xdnzfJRm2v89qaPiXUUHriQlR7/b9ApeI0xONK3ajAtQ6N9D76VmFdMtTDdAIwb3HFVUfnfTgh7h6qkmwP4K/YYv0PSibyplCf7EcPWcp4XK4Zi6luqo35qRkAHPDxn8Rv37Q+leKe4yiZzl/z2/SKHEspubeBUbVyMg7pvBrlBz6FjE8iBpo3a9sAmA3Zs9XT0ZoKEKJ7qmASG2rOlY1izsfkbt6747BPvUgP3vXQ82oosIW1vMcwgkbV8c+pQy22kawnT6ej1+0Js7IKhgw1xBoAumo48wBszP1AqiituPZDJFEgLLt+8dSbbjS3saQu4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJ5LvbsV6vF+hIBAZ7qS5ZxOtvz1rhEcV0aiXNdI7sI=;
 b=HYyBOzMKx3ZZ5XsLp1uiqw6nb4Nbj1E7sRkUNsBdoCv6azuj8z8QZDo/faC60BrOkXzBfQxGNuto9EQmTic0dEavkZsuItLT4e3XkH586P8Al9nHyU1hcXHj5fxyXgIAnasp7eUJLPlJ14FGGM4eAjkErUUgOwFr9b25oCxiJ02JEROhU5G7PMhJna7gKsOsEweeloD/4Z/p0RCI6543PKDkq48P/ZeFou68+88vbJOCQ3IOS45WQrsouk/loR8xh3aGAFXHIU93A4W/6NzMZlfQ9GvGRXqpkAdktwDQAsIEog1dnIx61akRbPG8VkUJpDWYY/Ni90YG1Bg+iJXACg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 158.140.1.147) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=temperror action=none header.from=cadence.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJ5LvbsV6vF+hIBAZ7qS5ZxOtvz1rhEcV0aiXNdI7sI=;
 b=RZNd7FG5cET2+oTd7hWGlaqHwaCt5tQceO6pfxcENyr5bOiAbiFusvPb48NlKAdFlDr9A0svLUeaL6EMsG7uukhXjrREzga0qZnNTnPyo1P3V+YzEo4llxQKq8sL/8hynd05f+RCdDLbxiODRMoK+gWSEpuvzKSWToqakBbHFSo=
Received: from MWHPR18CA0032.namprd18.prod.outlook.com (2603:10b6:320:31::18)
 by DM6PR07MB6522.namprd07.prod.outlook.com (2603:10b6:5:1c3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 17:02:52 +0000
Received: from MW2NAM12FT030.eop-nam12.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::3c) by MWHPR18CA0032.outlook.office365.com
 (2603:10b6:320:31::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Fri, 22 Oct 2021 17:02:52 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 158.140.1.147) smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not
 signed) header.d=none;kernel.org; dmarc=temperror action=none
 header.from=cadence.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of cadence.com: DNS Timeout)
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT030.mail.protection.outlook.com (10.13.181.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.8 via Frontend Transport; Fri, 22 Oct 2021 17:02:50 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2iNL008564
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 10:02:50 -0700
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
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2cUF018910;
        Fri, 22 Oct 2021 19:02:38 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 19MH2cJE018909;
        Fri, 22 Oct 2021 19:02:38 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v3 06/15] phy: cadence: Sierra: Rename some regmap variables to be in sync with Sierra documentation
Date:   Fri, 22 Oct 2021 19:02:27 +0200
Message-ID: <20211022170236.18839-7-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211022170236.18839-1-sjakhade@cadence.com>
References: <20211022170236.18839-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8eb1960-7792-481d-e6fa-08d9957dc7f6
X-MS-TrafficTypeDiagnostic: DM6PR07MB6522:
X-Microsoft-Antispam-PRVS: <DM6PR07MB65221B1E0A5220149875ED93C5809@DM6PR07MB6522.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yi6CKyl///m0GSi0rTj9FXfYzmDnLiLA3GysAeIoArSDAcLzL9jD4UtITsD2ohyQht9B0ZlgPHPZuq0FryzugqgPkC4kLn2Yhpa1Rt12FJdQxsVnM6etR1VjVvTHtAyElSNzND4LIarG5uwSSnF3MAEvNDPHiv2+agyHw/D8N/YH2j2zsqBnf3nNajw2lKzhceVa2JHUzRHp0C7AgueG5vj1z7LuhaUWt7tRxTjcSnWTYokkvI4nLWZLfCFEXu2dPw5/76L4pL/dUGGGt1KH418qBq8j2Iaz/HAJk5OFcqpGYo49DBpNdP6CDCujaZBVMYl08A00MPp//ZWqhwAz2eEvrcI9uoZIkv8j006miD8GBF6Op3rTN9LQtuAC5JTvXAVUd9EAk03+DqIjiuHV7n/qV/xjKkXskhHxZVPF7sypqLGMPi/WpG6psoGdiWEAezcmEbJla18OdLKuw3+pe0uP5dU2QtN02F2ZW6pzrSMEahk8WZZZloe14t8bSAXZov+KMNPlsDwtoYr3bt+gjxk7S5XraMzYd7gpAKz7CwuZWBJ7pSoojYJtV60Otiq+ehn/3nHvZbth6tG5dTnIuVSPQeac2HbgEb+utNipsx6XXzXSbc1OMhdo5kJsqOsNLm+AHoaynzmNamo1YfuiAPsetDVrmY49d3zDmfsqrLHVizEv/4XnD/1DA+7doxn+CUxnaNXOI8zH4nVtjg2BXwpleCvDeoFEAu92MxVeJwY=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(46966006)(36840700001)(1076003)(47076005)(7636003)(36860700001)(63350400001)(186003)(426003)(336012)(86362001)(63370400001)(36756003)(4326008)(82310400003)(70206006)(6666004)(110136005)(54906003)(83380400001)(356005)(70586007)(36906005)(42186006)(316002)(2906002)(8936002)(508600001)(5660300002)(8676002)(2616005)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 17:02:50.7303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8eb1960-7792-481d-e6fa-08d9957dc7f6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT030.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6522
X-Proofpoint-GUID: TzQ-5HTF3RTWoesH6idADaNkcL5e4wUi
X-Proofpoint-ORIG-GUID: TzQ-5HTF3RTWoesH6idADaNkcL5e4wUi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_04,2021-10-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110220098
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change. Rename some regmap variables as mentioned in Sierra
register description documentation.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 4674328574f5..9f2b8aefee9c 100644
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

