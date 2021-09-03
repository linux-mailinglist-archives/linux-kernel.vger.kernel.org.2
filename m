Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FDD3FF9D7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 07:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345298AbhICFDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 01:03:23 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:63130 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233632AbhICFCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 01:02:22 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 182NR9ok011844;
        Thu, 2 Sep 2021 22:01:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=+ahc9zEkbRWKLcg4An6kKo6Zb5TU8icRxkcvsrkVw3s=;
 b=E5Yzn2C4f2wEDXgeBeh+msserYeeQBniKbqZB1+z9QzjSWAP0yRsF/X7ECmuaYuyyjmk
 wGkcXVxy2jcIyCMYgnaWW+BBjVtLGx+IMN3PW3ym1GsHGTY0JkcrYjwJnjW7RXj+P6kt
 vs+e38HDdNXrvl5fMpKnwiWBeTimOIakbHL9X9HYdDMYTYP8IGIaLQflcdqkn7dKQMwX
 zpoypgLrnrnmclEVBg8gDshgnnPK9yIJxuAzS+S2+xJ0xD+mCbNDPG8V2VPzzZsE23KD
 AGxDefIa4+xnxWUySM5ayt9v/2UmdVo5/mLhA9XJrIr1iYVJEwT6+UsAiGRGdSDt2H+B PA== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3au8a18u4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 22:01:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJL4t41lO+gYRjJvAUEn/QXob79OATribYEjRt5LMn1WqyjbECR5ldQH1ALHDRcC8sP65imQDKhNGuhJfPBKTHa/OhaaRkojws6hSDQ+2Z6QuX66NItoAqMLoWWgLU3WjlwiIqeMhSFeB1vESNJMIlonsuWqW8v6kioOLmsUqyHcmgvj3jW29HbAsguDnVQxh/crVUUc7GwDqWM5psvQi0YKbw+f/CddvvNe8zh2wkK5Kx9To1/GJ0W6uq55+VcJZMVpQjbHSAD4UWTvePZpO1ww5KSW3SH0ZPadvAXtKGKo5v/JpXHSlYjUWepTkWH/MaSlumqmRlJgZJ7jdG8ALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+ahc9zEkbRWKLcg4An6kKo6Zb5TU8icRxkcvsrkVw3s=;
 b=jmHogleo/Hc6kLYOU7Vuynq+EnuoRs36OXQpZPP54JCGh4akSoEdjtgHooOrvQDodDzNcFaZzp8mEop4mkzNO+nXVz8Fwx6lwVlgjkz8TGyyHQTeDA7PrFln7TJl+W1ofZNc6J5Zjl9mi7JN5/tQe+Np9ATDMNym5A9AQfCXxzokj9OYAFXDu/zwiFWozy7mZge3O9Uodd6UU8DM005O5C6uIpvkq1zU79qOIcVeB7CX8pZzg2li4fEpwJUHcFhm83D/AnS3VvNPtj+8IcB4KEbuJsPgX9oLQrw2kAY7wwl49nEPjygE5a8HLGiM3FKKsBKM4N2678Utj/NAUF9rXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ahc9zEkbRWKLcg4An6kKo6Zb5TU8icRxkcvsrkVw3s=;
 b=uaYnOymHlFowTN5usjSl5GkYTWXk3jEJOJ0FI7aLFZPw6q88no+ToMb/1z3dtibiBJc8URH4I080Prb3G4gHJBbGvhFVWmixLS9J9pqFO7i6F/bbLH+Ja7zJXZpwF3w37BkK7j9wbZb7W1DoepOea9rBAF7LreFbWPX4YktveIc=
Received: from DS7PR03CA0231.namprd03.prod.outlook.com (2603:10b6:5:3ba::26)
 by MN2PR07MB7007.namprd07.prod.outlook.com (2603:10b6:208:1a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Fri, 3 Sep
 2021 05:01:06 +0000
Received: from DM6NAM12FT004.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::37) by DS7PR03CA0231.outlook.office365.com
 (2603:10b6:5:3ba::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21 via Frontend
 Transport; Fri, 3 Sep 2021 05:01:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT004.mail.protection.outlook.com (10.13.178.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Fri, 3 Sep 2021 05:01:06 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 18350uff020399
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Sep 2021 22:01:05 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Sep 2021 07:00:57 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 3 Sep 2021 07:00:56 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 3 Sep 2021 07:00:56 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18350uE5025693;
        Fri, 3 Sep 2021 07:00:56 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18350uWF025692;
        Fri, 3 Sep 2021 07:00:56 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 06/14] phy: cadence: Sierra: Add PHY PCS common register configurations
Date:   Fri, 3 Sep 2021 07:00:46 +0200
Message-ID: <20210903050054.25627-7-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210903050054.25627-1-sjakhade@cadence.com>
References: <20210903050054.25627-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a10dd521-f034-4b1a-3b01-08d96e97d61c
X-MS-TrafficTypeDiagnostic: MN2PR07MB7007:
X-Microsoft-Antispam-PRVS: <MN2PR07MB70074347AA2D5E104270647DC5CF9@MN2PR07MB7007.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MoxHrR501U5yVkpKh/vzBK/Ca77nrw4Sm+JoDeH8jV5KbtPEAtSztjcREC/BG9Z8kwH7noovoumTFPSqwZwZzWhZ7ANBn2pW01cqtc8hALEDS/XtBKTXmK7jxAwEgRQP5zJ1XrGNA/6CY8LsMZWEEYPGa0sOJ1epZHSllMdpbSWKxvIy1lS6o/3o49Anz3SrEBA4ArJPh89Wjyom1ADRfBs6ii9Ti+XELZvoKfW+2nFm+liEbrFg5aF/noe/SOhz1dISaxSDzDvSEsy2Q5ATlUdNzl4ClZjPfIK1AEPcDeBWAL7xCzFxzpXdLubUYpBfG7GGWDPAzjMiv7dYmYtKmF3bP7QpRpmfk95+YJRuNicwXygcKtfF7zNm1LoYXqRqpgLZ0blaITCCdSfeRKiVrTLxgvJAVnmzu0q9sZEQ1dQBJfCAVdcOIvGmC7bsa10Kp4v9hWC6U5e4LHG283X/xnymg5fEVLV1xBZ1rE361ef6kBFnJxAUJp4W9eAelOz7LHytoookSq0NDXcARuKkdl+pXNchWETMmBfnBllrViPBgOKPBENyrnKK6ZMTX4Ozrn0IUyjt2MZcbJrygq76zVyf9HROx21on1EYGXUnBZWFM+R7EIfpHL/1zClXeFH5BLTE4JSlo7+A5gpFBrdCcd/QISHr9kAigCLMdVuEwqRFxLU9jdNQpimpYTJeYRAv3P5x7EyT13adMFhYEN9I1QheUSuRgsUBqZelEsZyMYE=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(36092001)(36840700001)(46966006)(54906003)(47076005)(426003)(336012)(42186006)(1076003)(36860700001)(2616005)(6666004)(110136005)(86362001)(316002)(82310400003)(186003)(8936002)(36756003)(36906005)(82740400003)(8676002)(356005)(5660300002)(2906002)(83380400001)(19627235002)(70206006)(478600001)(70586007)(7636003)(4326008)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 05:01:06.0057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a10dd521-f034-4b1a-3b01-08d96e97d61c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT004.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB7007
X-Proofpoint-ORIG-GUID: mjTO1372fn5BTO1WFSd4SVgclIQAa-T-
X-Proofpoint-GUID: mjTO1372fn5BTO1WFSd4SVgclIQAa-T-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-03_01,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109030030
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PHY PCS common register configuration sequences for single link.
Update single link PCIe register sequence accordingly.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 38 ++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index a426b12447a7..4e27886e4b7f 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -148,6 +148,7 @@
 /* PHY PCS common registers */
 #define SIERRA_PHY_PCS_COMMON_OFFSET(block_offset)	\
 				     (0xc000 << (block_offset))
+#define SIERRA_PHY_PIPE_CMN_CTRL1			0x0
 #define SIERRA_PHY_PLL_CFG				0xe
 
 #define SIERRA_MACRO_ID					0x00007364
@@ -256,6 +257,8 @@ struct cdns_sierra_data {
 	u32 id_value;
 	u8 block_offset_shift;
 	u8 reg_offset_shift;
+	struct cdns_sierra_vals *pcs_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
+					     [NUM_SSC_MODE];
 	struct cdns_sierra_vals *pma_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
 					     [NUM_SSC_MODE];
 	struct cdns_sierra_vals *pma_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
@@ -364,6 +367,7 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 	enum cdns_sierra_phy_type phy_type = ins->phy_type;
 	enum cdns_sierra_ssc_mode ssc = ins->ssc_mode;
 	const struct cdns_reg_pairs *reg_pairs;
+	struct cdns_sierra_vals *pcs_cmn_vals;
 	struct regmap *regmap;
 	u32 num_regs;
 	int i, j;
@@ -375,6 +379,16 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 	clk_set_rate(phy->input_clks[CMN_REFCLK_DIG_DIV], 25000000);
 	clk_set_rate(phy->input_clks[CMN_REFCLK1_DIG_DIV], 25000000);
 
+	/* PHY PCS common registers configurations */
+	pcs_cmn_vals = init_data->pcs_cmn_vals[phy_type][TYPE_NONE][ssc];
+	if (pcs_cmn_vals) {
+		reg_pairs = pcs_cmn_vals->reg_pairs;
+		num_regs = pcs_cmn_vals->num_regs;
+		regmap = phy->regmap_phy_pcs_common_cdb;
+		for (i = 0; i < num_regs; i++)
+			regmap_write(regmap, reg_pairs[i].off, reg_pairs[i].val);
+	}
+
 	/* PMA common registers configurations */
 	pma_cmn_vals = init_data->pma_cmn_vals[phy_type][TYPE_NONE][ssc];
 	if (pma_cmn_vals) {
@@ -1022,6 +1036,16 @@ static int cdns_sierra_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* PCIE PHY PCS common configuration */
+static struct cdns_reg_pairs pcie_phy_pcs_cmn_regs[] = {
+	{0x0430, SIERRA_PHY_PIPE_CMN_CTRL1}
+};
+
+static struct cdns_sierra_vals pcie_phy_pcs_cmn_vals = {
+	.reg_pairs = pcie_phy_pcs_cmn_regs,
+	.num_regs = ARRAY_SIZE(pcie_phy_pcs_cmn_regs),
+};
+
 /* refclk100MHz_32b_PCIe_cmn_pll_ext_ssc */
 static const struct cdns_reg_pairs cdns_pcie_cmn_regs_ext_ssc[] = {
 	{0x2106, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
@@ -1173,6 +1197,13 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 	.id_value = SIERRA_MACRO_ID,
 	.block_offset_shift = 0x2,
 	.reg_offset_shift = 0x2,
+	.pcs_cmn_vals = {
+		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+			},
+		},
+	},
 	.pma_cmn_vals = {
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -1203,6 +1234,13 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 	.id_value = SIERRA_MACRO_ID,
 	.block_offset_shift = 0x0,
 	.reg_offset_shift = 0x1,
+	.pcs_cmn_vals = {
+		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+			},
+		},
+	},
 	.pma_cmn_vals = {
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
-- 
2.26.1

