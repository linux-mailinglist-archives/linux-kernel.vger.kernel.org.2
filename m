Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E6332CC78
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 07:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbhCDGLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 01:11:11 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:21002 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234726AbhCDGK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 01:10:59 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1245tlu5026179;
        Wed, 3 Mar 2021 22:08:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=M9ncY3Cpu7bZaAuiLYiP9xpq3D3Zo9BEZzWm9h1QZ54=;
 b=A+19PmfaRNPZpdtvLunMBtNzKvAFnaFaIji8kN4dCmB8Y0F0YS7URstM/voCNEQs2liC
 +jiih10/TL/YWRFHufMGBsLsmkplj0QrW43s/Yu8RIKuIJg47QGfHODH2/SfTfqRhvuD
 vulSlW4D6VJx35I/yESRks2LqPtJ24L74cxPBrq5h3bpiUdoW+ELuTw16H11uPV5987d
 KxazhaQj/8Qz6lc/DkSbd23yIZy/+b/EhWMVajSgEi+erWdpzgOln2VUYHNJQpEkIfAF
 kIVsTtVbaxnQlo1pAkIDV7ofo/ZtdYXK4QVYNgw64bJHbEyDVSji2UaGphfv7kQ7rDTB gA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0b-0014ca01.pphosted.com with ESMTP id 36yjj2r9et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 22:08:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMmSxzIH8bpr6Cw8feH/4jAo76jebCZ+4mrupQvK4/M/9dR5b/v02jBihWZ65+7Kr+cNjKoUricbhY3+B7M7lrZsne+fblc33h5CLTjjFGboIqfk444HTX1/BFGi3nix45H5pj7+obTZuLT/hcYV4QA8fWhbY8M6XHE06DnV7ZPfEo1FHQbDlOa6oQoeE+kfNCSVOBi86kIepqei2s63b6W7jdDYqggkir6KGI7Nb/r9zt8a/4dhO8C1V3gpYxosPKtMBNas6AFx3FbL+PNAEErvxoT5pz/DVQZ1CoJV6/bSxFbROEilNZdBEIohWPOuheyXiruwn0LD73xK2sGX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9ncY3Cpu7bZaAuiLYiP9xpq3D3Zo9BEZzWm9h1QZ54=;
 b=lRhPzL6D+Mm9qwQbYph87TVax4r+03Q2QoVR2BLrqGvKZNlPM+hzWtRQJJvZW+4vBDLhEeMFfsjMOHDEhsKC5qfCV8N6ZTtbq+GVkeB2lLJoqJMaWeWDAfq+swdt7t8NCNDSfhlZC3oihKGw1mTBUi8pgu+uaaXN7VpswYUgvOY+yHVStkTRI3k+dZFby5vg7NFFhBOrftnNTsZhpqz42GlDdpmTTxLoE4S+XRZ8L91r1iWqa3lm5NBg12fxIhWh5xnb/JMpkwknQBuJfYcobFYjypJlKxr6tdXjxCCNMTDDS4USD8cPogqfl8gzdgoGP30uh86ZwqqJneIa3wS1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=cadence.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9ncY3Cpu7bZaAuiLYiP9xpq3D3Zo9BEZzWm9h1QZ54=;
 b=tH/+H2c4+ED4Zb9rTeFwZFpq4pnweeXresg/upUTcsog/MDdEzj//MTrK6174EW3lEFgEkA5EvSLaIIsJ+RLd+cHN8gnGa/SFb8rj+P90B8lPldDl8Q1KsQVqnYSZPSrpiWs4vNLsoDesXbZ/k0DN98Vs2LxQvhc9jAQoVsgQCI=
Received: from DM5PR04CA0043.namprd04.prod.outlook.com (2603:10b6:3:12b::29)
 by CY1PR07MB2652.namprd07.prod.outlook.com (2a01:111:e400:c637::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Thu, 4 Mar
 2021 06:08:27 +0000
Received: from DM6NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::cf) by DM5PR04CA0043.outlook.office365.com
 (2603:10b6:3:12b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 4 Mar 2021 06:08:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT056.mail.protection.outlook.com (10.13.179.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.9 via Frontend Transport; Thu, 4 Mar 2021 06:08:25 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 12468Jjq067409
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 3 Mar 2021 22:08:24 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 4 Mar 2021 07:08:18 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 4 Mar 2021 07:08:18 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 12468I3d032353;
        Thu, 4 Mar 2021 07:08:18 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 12468IBq032352;
        Thu, 4 Mar 2021 07:08:18 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <nsekhar@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH 3/4] phy: cadence-torrent: Update SGMII/QSGMII configuration specific to TI
Date:   Thu, 4 Mar 2021 07:08:15 +0100
Message-ID: <1614838096-32291-4-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1614838096-32291-1-git-send-email-sjakhade@cadence.com>
References: <1614838096-32291-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6d2c570-1c77-4d7a-6598-08d8ded3ec45
X-MS-TrafficTypeDiagnostic: CY1PR07MB2652:
X-Microsoft-Antispam-PRVS: <CY1PR07MB26520AC3A2ADBC27CAFA9D03C5979@CY1PR07MB2652.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:381;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1rgMl9NOjQ4llkJngUCVc9rAfKx5cVHQf00wp1pzBqBYEkGEdUtxdV+qy+CkH00ty92jI8Mou+8rBFVAORk9GGw9pt1lRoj3EMSS0RGNL82Fmrn0rhDaXQK3+KC5dZcjPQ3ydLgoFWfn6B/olCR7ZbEemGUdgxtMlaB+uQwabMpyb5j5Vp2+2Ke8+f6881wKCJVKO7QluFfa1k8hLiDzLiTr2u65dB/LCGa+1CnhtAVqMoL1fjsv5D93k9ByD6sQ9UPsIjBzxGFhYW0SgWcwTalbhEaqMQAlZHmdjwHieQ5SYx4Em/x7jL8IMSiyXoUO8Cf3VKwMkG95bPhUs2FmeQEc8v+3Jmk6U2R07r+YHCH7IVFd/eGzLoDg3Ytbgp0X45oDKCd0TboWIhi1Y8u6cAnwN73BxRq6W15NTNL9P6mXA7XhNy7l24NHCYk05WnMCFkSkDHnb8dKeyOVHuHwLlfZXr82C56A6QwDVdbFkRMCG/6F9fUwHP0t7o74Jq6yInYQ5YgBsYSEQchHTfXROwlQ5G+XPV56YHPEifCrXDCDaRScnZn395UND874rFPHopKqR1HX1ptLRdbOTGxm5FKlHuRLXOBnvN+hYHXPrmnSvL3KQNEpuKEHB4FS7XHWVHIHFpYc68+qYno+jrM1WCLs7OsSIrLjUt4ZTK3bsZq1MlnQuETEqnueO3lkKgTJNUXwGXV/asjK7xaD7DmGw==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(36092001)(36840700001)(46966006)(2616005)(2906002)(316002)(82740400003)(54906003)(47076005)(426003)(70586007)(8936002)(478600001)(336012)(186003)(26005)(15650500001)(8676002)(36756003)(42186006)(81166007)(6666004)(4326008)(83380400001)(70206006)(86362001)(5660300002)(356005)(36906005)(110136005)(36860700001)(82310400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 06:08:25.5302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d2c570-1c77-4d7a-6598-08d8ded3ec45
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT056.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2652
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_01:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 mlxlogscore=779 mlxscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103040025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

Update SGMII/QSGMII configuration specific to TI.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 58 +++++++++++++++++------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index ae1cea2271be..f78a6731c26a 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -174,6 +174,7 @@
 #define XCVR_DIAG_PLLDRC_CTRL		0x00E5U
 #define XCVR_DIAG_HSCLK_SEL		0x00E6U
 #define XCVR_DIAG_HSCLK_DIV		0x00E7U
+#define XCVR_DIAG_RXCLK_CTRL		0x00E9U
 #define XCVR_DIAG_BIDI_CTRL		0x00EAU
 #define XCVR_DIAG_PSC_OVRD		0x00EBU
 #define TX_PSC_A0			0x0100U
@@ -2870,6 +2871,15 @@ static struct cdns_reg_pairs sgmii_100_no_ssc_tx_ln_regs[] = {
 	{0x00B3, DRV_DIAG_TX_DRV}
 };
 
+static struct cdns_reg_pairs ti_sgmii_100_no_ssc_tx_ln_regs[] = {
+	{0x00F3, TX_PSC_A0},
+	{0x04A2, TX_PSC_A2},
+	{0x04A2, TX_PSC_A3},
+	{0x0000, TX_TXCC_CPOST_MULT_00},
+	{0x00B3, DRV_DIAG_TX_DRV},
+	{0x4000, XCVR_DIAG_RXCLK_CTRL},
+};
+
 static struct cdns_reg_pairs sgmii_100_no_ssc_rx_ln_regs[] = {
 	{0x091D, RX_PSC_A0},
 	{0x0900, RX_PSC_A2},
@@ -2898,6 +2908,11 @@ static struct cdns_torrent_vals sgmii_100_no_ssc_tx_ln_vals = {
 	.num_regs = ARRAY_SIZE(sgmii_100_no_ssc_tx_ln_regs),
 };
 
+static struct cdns_torrent_vals ti_sgmii_100_no_ssc_tx_ln_vals = {
+	.reg_pairs = ti_sgmii_100_no_ssc_tx_ln_regs,
+	.num_regs = ARRAY_SIZE(ti_sgmii_100_no_ssc_tx_ln_regs),
+};
+
 static struct cdns_torrent_vals sgmii_100_no_ssc_rx_ln_vals = {
 	.reg_pairs = sgmii_100_no_ssc_rx_ln_regs,
 	.num_regs = ARRAY_SIZE(sgmii_100_no_ssc_rx_ln_regs),
@@ -2988,6 +3003,16 @@ static struct cdns_reg_pairs qsgmii_100_no_ssc_tx_ln_regs[] = {
 	{0x0003, DRV_DIAG_TX_DRV}
 };
 
+static struct cdns_reg_pairs ti_qsgmii_100_no_ssc_tx_ln_regs[] = {
+	{0x00F3, TX_PSC_A0},
+	{0x04A2, TX_PSC_A2},
+	{0x04A2, TX_PSC_A3},
+	{0x0000, TX_TXCC_CPOST_MULT_00},
+	{0x0011, TX_TXCC_MGNFS_MULT_100},
+	{0x0003, DRV_DIAG_TX_DRV},
+	{0x4000, XCVR_DIAG_RXCLK_CTRL},
+};
+
 static struct cdns_reg_pairs qsgmii_100_no_ssc_rx_ln_regs[] = {
 	{0x091D, RX_PSC_A0},
 	{0x0900, RX_PSC_A2},
@@ -3016,6 +3041,11 @@ static struct cdns_torrent_vals qsgmii_100_no_ssc_tx_ln_vals = {
 	.num_regs = ARRAY_SIZE(qsgmii_100_no_ssc_tx_ln_regs),
 };
 
+static struct cdns_torrent_vals ti_qsgmii_100_no_ssc_tx_ln_vals = {
+	.reg_pairs = ti_qsgmii_100_no_ssc_tx_ln_regs,
+	.num_regs = ARRAY_SIZE(ti_qsgmii_100_no_ssc_tx_ln_regs),
+};
+
 static struct cdns_torrent_vals qsgmii_100_no_ssc_rx_ln_vals = {
 	.reg_pairs = qsgmii_100_no_ssc_rx_ln_regs,
 	.num_regs = ARRAY_SIZE(qsgmii_100_no_ssc_rx_ln_regs),
@@ -3922,32 +3952,32 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
-				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+				[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
 			},
 			[TYPE_PCIE] = {
-				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+				[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
 			},
 			[TYPE_USB] = {
-				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+				[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
 			},
 		},
 		[TYPE_QSGMII] = {
 			[TYPE_NONE] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+				[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
 			},
 			[TYPE_PCIE] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+				[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
 			},
 			[TYPE_USB] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+				[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
 			},
 		},
 		[TYPE_USB] = {
-- 
2.26.1

