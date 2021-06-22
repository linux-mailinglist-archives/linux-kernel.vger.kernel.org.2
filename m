Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C694C3B095E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhFVPnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:43:08 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:56056 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232373AbhFVPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:42:40 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MFWO66031493;
        Tue, 22 Jun 2021 08:40:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=FHSq8I9Ogq2bFGvRGOBoL8+KZ04LStSOwep6EWfhZ04=;
 b=gyHL6JZdblIUgtd509HiQTayZNY+QABfaFg8EO77orjeiuqo1x0Zy9OdrzaNWxRSxe1G
 vjQmsJvtwzZaDRRp74T5ftx6AkTxcXp/IWSIAQehHYFfa3o1HUFJjekwpzIeYCAuBelc
 brIba85j9iCwwT6QRuKEo2nJhOIz6s8RXHp5URU+hznqpaLOGa3mkoa6uPHq9ycDHSYh
 cSMBzrO+6r/Of+Sw20bkCpOFEjSrQevnjbO+voXds2UAWddHJlzAgab8k+iD9JC3Vu+q
 QFIsf9hiobhvbeuzxG3A9IASrm0mxoPFxzz4zXR936FNilsz9lnztAE6jwFaHW/y/0wY 8w== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0a-0014ca01.pphosted.com with ESMTP id 39apms59u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 08:40:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFUf7SKfBX5PeQ3BPgQrTY+MmRsWzP/N2fZrsJEwKTIHV4l0DrFtlHKXTfFgGUDJ3eyHykpjwT6cvBEkU+Dw8OGeq4ie0CmjIU3zJilPCPLQDLD/ivEKhrDmpx+FN4ghw4J1K2WWgwEswcyUMrJszryYXhCJN1qL5AVSBVELWhHLEmsMVxGOtU6HA+3so1igSYf6FuD2bE5PG/y4oDxvPKrpK0zPSzkEt512WExHyXKNEu/xMcIqqbZxw6gtVfZPxcZ7DurB4BdX7eLaP9733V99ZtU/qcYIcgoYYMrQyN0f5j1lbNBdflSn7C6V4kGMVTavddQF+ZbB7ssWdrHKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHSq8I9Ogq2bFGvRGOBoL8+KZ04LStSOwep6EWfhZ04=;
 b=k/cAQaYa5a9bBUgNpmd4eEiYh8Fqg9FpcPmmm/lyQt2b1bDsngCTNenatn7IT9VMkMdrtGN0O3MBCd7pNwty7uuy+Uhl+5gByTyvTx23bi4lWfXvs+r1T988yp/qMWdrxnqCcL7FHZYXVrQuJNEKF8VL49tof79lQgX7+4GM5ofnkO3bMDceG+POEipqZtwk728kACS6GfHEi3gzN2tl/1xXFPcAGA8Oly0Rfmg9W8K0ug3MbHmku4mf5gTdgw5XuRN3ftCAZh4/ivHhMRPKsVnWvc0NbxBoTuXZj9ZHspZuQQwXyCWeW2Fx2WACx235vS4NycSwueTsTPTWyzt6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHSq8I9Ogq2bFGvRGOBoL8+KZ04LStSOwep6EWfhZ04=;
 b=h5P/smgtq093UcbKVv+yrpAAn1pUREKEclCqQ56y7+UQKIJc19Qm7JqmxFRuEwfnqX6qaNoB4jxlDZKhjq7muoTyfUaAzfbupA15sPwx3YUXzTqnr3fB5Tgk1JUzqu3b2pCrSOBuS77QZrlSukxcBEvQwo2zDYPOwhZ6e4ALtXU=
Received: from MWHPR21CA0071.namprd21.prod.outlook.com (2603:10b6:300:db::33)
 by SN6PR07MB4288.namprd07.prod.outlook.com (2603:10b6:805:53::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Tue, 22 Jun
 2021 15:39:57 +0000
Received: from MW2NAM12FT034.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::31) by MWHPR21CA0071.outlook.office365.com
 (2603:10b6:300:db::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.5 via Frontend
 Transport; Tue, 22 Jun 2021 15:39:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT034.mail.protection.outlook.com (10.13.180.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.10 via Frontend Transport; Tue, 22 Jun 2021 15:39:56 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 15MFdpjF219509
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 08:39:55 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Jun 2021 17:39:51 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 22 Jun 2021 17:39:51 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 15MFdpL6002314;
        Tue, 22 Jun 2021 17:39:51 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 15MFdpvf002313;
        Tue, 22 Jun 2021 17:39:51 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH v2 4/9] phy: cadence-torrent: Configure PHY registers as a function of input reference clock rate
Date:   Tue, 22 Jun 2021 17:39:44 +0200
Message-ID: <20210622153949.2215-5-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210622153949.2215-1-sjakhade@cadence.com>
References: <20210622153949.2215-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fd0110f-6c8c-4f86-ea4e-08d93593fcbd
X-MS-TrafficTypeDiagnostic: SN6PR07MB4288:
X-Microsoft-Antispam-PRVS: <SN6PR07MB42881FDA5477BA963DC806C2C5099@SN6PR07MB4288.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f0KvF6ufYWCNJAzXvgd+KbjvuCLiskSvaUpePkqREEAfgPGY6ja6GJNLohJR3JpaG2nYZzVIsBtsbatOZ2kdgike6InTGsci4yBSo/pbi12iMmUN7TMCuV9DSHJAFFFVk4yD0JiTfL97vboFdwIAJTbCTNedRQLUSDJPQhk0ma2gNorY+WXaweOOdfwQ1vhtudhf9B6G1kDoLwDzH/1gVFiDkSDW7t6jpJlEinOXUcpGUE8yTHwSxh7gbIsUywQEePGKBF1wvevkfiaCFNdU2ql7abmEA00qm8cAf3mZKp+j7a3KWSxP9fvpDUNnxQRHWjsf1IStMePE3FhRUWMY50KEGY+G8ZpwwGRwMSA6CYVGDwzteIxBH+r90dfCxI1cXU3pydD6TdFT7drVLfiOazb+NTD2llGjEFfHqkiwWhBfCqMT91qSFPQBPq9qRiqbQRZQkitLyb+CjAvyjel339RKjCFBc2y6GtMCHV67mcRTGPznuY/SDATIsBQeR8H/dJEq4if54K5Hh8BB9cCgObbxPAkmpAqF7u+Tayu4KplaxmcwRoMz5j3OsGBRRyUNwvBihyRMRK5QeHsg4VP6RPjnTqbJx7S01OzZigKrxn4K4MFDLpL3QOiUHbFc1INay97GThW/0l39BkFWb9MuRDuhHII672Y6/SRk/BcUvo8T1X0KxEMFVa/YRNbKK8eEzezVp0O+dYuCOYx5Z2u1veMMeyIkAg5Nq7Wu1spMNQk=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(42186006)(82310400003)(30864003)(70586007)(356005)(6666004)(83380400001)(36860700001)(5660300002)(54906003)(47076005)(8936002)(81166007)(1076003)(36756003)(2906002)(2616005)(186003)(4326008)(110136005)(498600001)(8676002)(86362001)(426003)(336012)(26005)(70206006)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 15:39:56.5875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd0110f-6c8c-4f86-ea4e-08d93593fcbd
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT034.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4288
X-Proofpoint-ORIG-GUID: U0DbhZ5E1xckCejj5a6EO74-UVRqvH3O
X-Proofpoint-GUID: U0DbhZ5E1xckCejj5a6EO74-UVRqvH3O
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-22_08:2021-06-22,2021-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106220097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Torrent PHY supports multiple serdes standards with different input
reference clock frequencies. PHY register values differ based on the
reference clock rate. Add PHY input reference clock frequency as a
new dimension to select proper register configuration. No functional
change is intended.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 830 +++++++++++-----------
 1 file changed, 422 insertions(+), 408 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index f746553c8089..86f05817704d 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -360,12 +360,12 @@ struct cdns_torrent_data {
 						[NUM_SSC_MODE];
 	struct cdns_torrent_vals *pcs_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
 					      [NUM_SSC_MODE];
-	struct cdns_torrent_vals *cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
-					  [NUM_SSC_MODE];
-	struct cdns_torrent_vals *tx_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
-					    [NUM_SSC_MODE];
-	struct cdns_torrent_vals *rx_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
-					    [NUM_SSC_MODE];
+	struct cdns_torrent_vals *cmn_vals[NUM_REF_CLK][NUM_PHY_TYPE]
+					  [NUM_PHY_TYPE][NUM_SSC_MODE];
+	struct cdns_torrent_vals *tx_ln_vals[NUM_REF_CLK][NUM_PHY_TYPE]
+					    [NUM_PHY_TYPE][NUM_SSC_MODE];
+	struct cdns_torrent_vals *rx_ln_vals[NUM_REF_CLK][NUM_PHY_TYPE]
+					    [NUM_PHY_TYPE][NUM_SSC_MODE];
 };
 
 struct cdns_regmap_cdb_context {
@@ -1943,6 +1943,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
 	const struct cdns_torrent_data *init_data = cdns_phy->init_data;
 	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
+	enum cdns_torrent_ref_clk ref_clk = cdns_phy->ref_clk_rate;
 	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
 	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
 	enum cdns_torrent_phy_type phy_type = inst->phy_type;
@@ -2008,7 +2009,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	}
 
 	/* PMA common registers configurations */
-	cmn_vals = init_data->cmn_vals[phy_type][TYPE_NONE][ssc];
+	cmn_vals = init_data->cmn_vals[ref_clk][phy_type][TYPE_NONE][ssc];
 	if (cmn_vals) {
 		reg_pairs = cmn_vals->reg_pairs;
 		num_regs = cmn_vals->num_regs;
@@ -2019,7 +2020,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	}
 
 	/* PMA TX lane registers configurations */
-	tx_ln_vals = init_data->tx_ln_vals[phy_type][TYPE_NONE][ssc];
+	tx_ln_vals = init_data->tx_ln_vals[ref_clk][phy_type][TYPE_NONE][ssc];
 	if (tx_ln_vals) {
 		reg_pairs = tx_ln_vals->reg_pairs;
 		num_regs = tx_ln_vals->num_regs;
@@ -2032,7 +2033,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	}
 
 	/* PMA RX lane registers configurations */
-	rx_ln_vals = init_data->rx_ln_vals[phy_type][TYPE_NONE][ssc];
+	rx_ln_vals = init_data->rx_ln_vals[ref_clk][phy_type][TYPE_NONE][ssc];
 	if (rx_ln_vals) {
 		reg_pairs = rx_ln_vals->reg_pairs;
 		num_regs = rx_ln_vals->num_regs;
@@ -2073,6 +2074,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 {
 	const struct cdns_torrent_data *init_data = cdns_phy->init_data;
 	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
+	enum cdns_torrent_ref_clk ref_clk = cdns_phy->ref_clk_rate;
 	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
 	enum cdns_torrent_phy_type phy_t1, phy_t2, tmp_phy_type;
 	struct cdns_torrent_vals *pcs_cmn_vals;
@@ -2161,7 +2163,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 		}
 
 		/* PMA common registers configurations */
-		cmn_vals = init_data->cmn_vals[phy_t1][phy_t2][ssc];
+		cmn_vals = init_data->cmn_vals[ref_clk][phy_t1][phy_t2][ssc];
 		if (cmn_vals) {
 			reg_pairs = cmn_vals->reg_pairs;
 			num_regs = cmn_vals->num_regs;
@@ -2172,7 +2174,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 		}
 
 		/* PMA TX lane registers configurations */
-		tx_ln_vals = init_data->tx_ln_vals[phy_t1][phy_t2][ssc];
+		tx_ln_vals = init_data->tx_ln_vals[ref_clk][phy_t1][phy_t2][ssc];
 		if (tx_ln_vals) {
 			reg_pairs = tx_ln_vals->reg_pairs;
 			num_regs = tx_ln_vals->num_regs;
@@ -2185,7 +2187,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 		}
 
 		/* PMA RX lane registers configurations */
-		rx_ln_vals = init_data->rx_ln_vals[phy_t1][phy_t2][ssc];
+		rx_ln_vals = init_data->rx_ln_vals[ref_clk][phy_t1][phy_t2][ssc];
 		if (rx_ln_vals) {
 			reg_pairs = rx_ln_vals->reg_pairs;
 			num_regs = rx_ln_vals->num_regs;
@@ -3481,230 +3483,236 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 		},
 	},
 	.cmn_vals = {
-		[TYPE_PCIE] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
+		[CLK_100_MHZ] = {
+			[TYPE_PCIE] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = NULL,
+					[EXTERNAL_SSC] = NULL,
+					[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+				},
 			},
 			[TYPE_SGMII] = {
-				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_sgmii_100_no_ssc_cmn_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &sgmii_100_int_ssc_cmn_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
+				},
 			},
 			[TYPE_QSGMII] = {
-				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
-			},
-		},
-		[TYPE_SGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_sgmii_100_no_ssc_cmn_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &sgmii_100_int_ssc_cmn_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_qsgmii_100_no_ssc_cmn_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+				},
 			},
 			[TYPE_USB] = {
-				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
-			},
-		},
-		[TYPE_QSGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_qsgmii_100_no_ssc_cmn_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-			},
-		},
-		[TYPE_USB] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
-			},
-			[TYPE_SGMII] = {
-				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
-			},
-			[TYPE_QSGMII] = {
-				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+				},
 			},
 		},
 	},
 	.tx_ln_vals = {
-		[TYPE_PCIE] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = NULL,
+		[CLK_100_MHZ] = {
+			[TYPE_PCIE] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = NULL,
+					[EXTERNAL_SSC] = NULL,
+					[INTERNAL_SSC] = NULL,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = NULL,
+					[EXTERNAL_SSC] = NULL,
+					[INTERNAL_SSC] = NULL,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = NULL,
+					[EXTERNAL_SSC] = NULL,
+					[INTERNAL_SSC] = NULL,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = NULL,
+					[EXTERNAL_SSC] = NULL,
+					[INTERNAL_SSC] = NULL,
+				},
 			},
 			[TYPE_SGMII] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = NULL,
+				[TYPE_NONE] = {
+					[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+				},
 			},
 			[TYPE_QSGMII] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = NULL,
+				[TYPE_NONE] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+				},
 			},
 			[TYPE_USB] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = NULL,
-			},
-		},
-		[TYPE_SGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-			},
-		},
-		[TYPE_QSGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-			},
-		},
-		[TYPE_USB] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_SGMII] = {
-				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_QSGMII] = {
-				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				},
 			},
 		},
 	},
 	.rx_ln_vals = {
-		[TYPE_PCIE] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+		[CLK_100_MHZ] = {
+			[TYPE_PCIE] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_SGMII] = {
-				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_QSGMII] = {
-				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-			},
-		},
-		[TYPE_SGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_USB] = {
-				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-			},
-		},
-		[TYPE_QSGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-			},
-		},
-		[TYPE_USB] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_SGMII] = {
-				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_QSGMII] = {
-				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				},
 			},
 		},
 	},
@@ -3890,230 +3898,236 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 		},
 	},
 	.cmn_vals = {
-		[TYPE_PCIE] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
+		[CLK_100_MHZ] = {
+			[TYPE_PCIE] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = NULL,
+					[EXTERNAL_SSC] = NULL,
+					[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+				},
 			},
 			[TYPE_SGMII] = {
-				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_sgmii_100_no_ssc_cmn_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &sgmii_100_int_ssc_cmn_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
+				},
 			},
 			[TYPE_QSGMII] = {
-				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
-			},
-		},
-		[TYPE_SGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_sgmii_100_no_ssc_cmn_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &sgmii_100_int_ssc_cmn_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_qsgmii_100_no_ssc_cmn_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+				},
 			},
 			[TYPE_USB] = {
-				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
-			},
-		},
-		[TYPE_QSGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_qsgmii_100_no_ssc_cmn_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-			},
-		},
-		[TYPE_USB] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
-			},
-			[TYPE_SGMII] = {
-				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
-			},
-			[TYPE_QSGMII] = {
-				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+				},
 			},
 		},
 	},
 	.tx_ln_vals = {
-		[TYPE_PCIE] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = NULL,
+		[CLK_100_MHZ] = {
+			[TYPE_PCIE] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = NULL,
+					[EXTERNAL_SSC] = NULL,
+					[INTERNAL_SSC] = NULL,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = NULL,
+					[EXTERNAL_SSC] = NULL,
+					[INTERNAL_SSC] = NULL,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = NULL,
+					[EXTERNAL_SSC] = NULL,
+					[INTERNAL_SSC] = NULL,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = NULL,
+					[EXTERNAL_SSC] = NULL,
+					[INTERNAL_SSC] = NULL,
+				},
 			},
 			[TYPE_SGMII] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = NULL,
+				[TYPE_NONE] = {
+					[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
+				},
 			},
 			[TYPE_QSGMII] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = NULL,
+				[TYPE_NONE] = {
+					[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
+				},
 			},
 			[TYPE_USB] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = NULL,
-			},
-		},
-		[TYPE_SGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
-			},
-		},
-		[TYPE_QSGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
-			},
-		},
-		[TYPE_USB] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_SGMII] = {
-				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_QSGMII] = {
-				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				},
 			},
 		},
 	},
 	.rx_ln_vals = {
-		[TYPE_PCIE] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+		[CLK_100_MHZ] = {
+			[TYPE_PCIE] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_SGMII] = {
-				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_QSGMII] = {
-				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-			},
-		},
-		[TYPE_SGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_USB] = {
-				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-			},
-		},
-		[TYPE_QSGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-			},
-		},
-		[TYPE_USB] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_SGMII] = {
-				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_QSGMII] = {
-				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				},
 			},
 		},
 	},
-- 
2.26.1

