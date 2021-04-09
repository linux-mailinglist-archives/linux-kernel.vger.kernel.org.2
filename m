Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA4A3594A9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbhDIFfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:35:03 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:24788 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233303AbhDIFfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:35:00 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1395PgEm030137;
        Thu, 8 Apr 2021 22:34:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=rj+BBguDEa4hJlIk53/312K9VHbjliTchwhI8/b6Ubs=;
 b=fFsNLb6gAA2i/vgVRiLJQgO8X23E9MQKRJal0fZNuxwluQnretOHlYxQClWaTcqZiO41
 yfxWUJ1O/Bz3JbGp90MJwnTfhBB0P0rpX9R46FSe7YipBZmNJAoHSVdw1HJbw8nCcSes
 8GecfJTt33RV66nmqWm5IHJMVn9i7uaiulp4aj1CuGClDUXyvO4mhebhUGfSDnm6bF6E
 j6sP1CEgTBuT6TyTwm70POvkr1HfIto577QhnoNOBx19Obd53szejYIZZ9vvGCa+mfqm
 bIcAhvaBXz6SuQqfXRolzqA+CXpZCkWgKgNRKTd0NfK22UU3SRPkG88G54sxGhd9xMh1 kg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0b-0014ca01.pphosted.com with ESMTP id 37rvb4ttj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 22:34:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQRRg+Svto9i/zet9ZVDXMxMDpBBw9bw4sZNuWROY0sW6b7ui4Q9tqPIY+wXEu8pWqDAhMoxZMKcdvPrxo7WEn9PJGrDAOWBwDc+uA6YTVtll2yjmiwSNCG4agxQdn/a7vaHCWj6qqERHEF7t13kEBuOUDsGPBIkkFffcd6OT2odoxcYRgWPUlif5y+jkeFXfF+K5/a1yJXxyAK7NOPwdaaWoRbr7RntvvNhdZGlnY5XDYcPERNlXEwT0CLBGkyblg6k2INxamEXWxM5vFBMz8z75Grc1Jtw7IzilBU3z/jg1C/aOPDcV6SvnDxY+Q/OrkM/FdmDaILGc6iooTnafQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rj+BBguDEa4hJlIk53/312K9VHbjliTchwhI8/b6Ubs=;
 b=L7khFiDBcJqx3rkINAO7xz2YBKLHfnwXW3ZtcN7Xi5EFlz5PjQ92qDR8kWugJl26XkNQug/nqxpevel6n/k/EDl+ZB70uBPHtYHF4w66lqh+PYWXhV9BHsZ7/BaoOT3m2H9+EMNtuDjFg9Yqy8yXuXSoA+B3x1wDo9lXN+kErU9vmWeOE7mHSlNLcogOp3pHiDhlIW1p79nE8q51F+Am24FGL43v2yt+Befr7vn794b/odA7xv74NLO1PC50Eb+pEgcjKafGzIwLxxy7LbBSf0xZjjuIW5Om8L9elTOnI2TX9l85/YhgKmhsEjqIUK/CyJHdWkZhu3zYnkhQPE6+NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rj+BBguDEa4hJlIk53/312K9VHbjliTchwhI8/b6Ubs=;
 b=lYDAqqYHEKGAxU8i52rySKxwQrGX2RQrKjRiYNjRNfoBzym0lzgolhL6R+s4/Qo8GeITS/as1U07QXBnF5eAfx9ox5p1oG2RDqGIVk80pzEEmolbBopQS7a22RxqiVOkEUzAJ/rx3+ccRP0hJIvfUYan4oRBKbSLQdu8sgnyszc=
Received: from MWHPR11CA0019.namprd11.prod.outlook.com (2603:10b6:301:1::29)
 by SN6PR07MB4400.namprd07.prod.outlook.com (2603:10b6:805:5c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 9 Apr
 2021 05:34:30 +0000
Received: from MW2NAM12FT040.eop-nam12.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::99) by MWHPR11CA0019.outlook.office365.com
 (2603:10b6:301:1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Fri, 9 Apr 2021 05:34:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT040.mail.protection.outlook.com (10.13.180.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.6 via Frontend Transport; Fri, 9 Apr 2021 05:34:28 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YJ5c032749
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 22:34:27 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Apr 2021 07:34:19 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 9 Apr 2021 07:34:19 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YJ11027881;
        Fri, 9 Apr 2021 07:34:19 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1395YJTQ027875;
        Fri, 9 Apr 2021 07:34:19 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 12/14] phy: cadence-torrent: Add PCIe + DP multilink configuration
Date:   Fri, 9 Apr 2021 07:34:14 +0200
Message-ID: <1617946456-27773-13-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
References: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fad658e-130f-4858-899f-08d8fb1924e6
X-MS-TrafficTypeDiagnostic: SN6PR07MB4400:
X-Microsoft-Antispam-PRVS: <SN6PR07MB4400AA3DA096A62BEC419761C5739@SN6PR07MB4400.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vSb06Rlm6jjWieUqv9SzPEACzFRwl2pJYJEj2wIQFM61ZX3YWVe/DyzLnUD4a3qU3c/RNzNXuGJARWvATB5hpdufWhpSlOHZAydS8Uf34Q0JE1GapxyqUCwGbMA0l75gzvvXZhMnCzhIxoH35ZLrmaeHO42djKERF3bCXfotb9lOFW3xRZqZbpxXE+JZvTZb6OOyLCX6dRCrqX2k7hDrRMfcADArBYUiGacwx1mst+vdJu9plqQp5YZ09eWECMR+1PQqplRse5HgkIvcDjXGfj8zJqGgs3cGyrYIfFGGtEKFD+fJkLzbcoBocVj94MygFdqKxsa/MeOGTn8V1MXWdAkOaMCdaRZdeBzERw6cAjZLRQGQ/77bUlhQhVVYAKM2gXjhS7RydLEGt3ZtH/nU7NLGORyeeF6OkW2yhZyk9pstQcR27/IunndJ+LTgvnWOLNYnyPKvlnz02Mo1hklabuUU0GYpZUO6V2Ph8jIw6bi02NcjVCiM4DSjuWUWdBnHNUMizYWTck/N2ablCoX2BWzfWZgw0AHL5IJrodFnqh/IMQ983wCmo00/mV1olJmwl0vt+PSbJ4AOfT2dqS1QUYkX2wso8SBAnI6280mk/27Fiv+/BShM8wIHkKObURMPIp0U/VXDqLhrzjg/ucYaipTQMAobrCCm3wXxDvGg4n3JaWOdf4iAWAA1mQ6U/4r4jWzeYTeY1gyfpQI4OdIa4A==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(36092001)(36840700001)(46966006)(316002)(82310400003)(2906002)(36756003)(426003)(54906003)(2616005)(336012)(82740400003)(186003)(26005)(86362001)(47076005)(356005)(6666004)(110136005)(42186006)(478600001)(70206006)(7636003)(36860700001)(8936002)(4326008)(36906005)(5660300002)(8676002)(70586007)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 05:34:28.4227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fad658e-130f-4858-899f-08d8fb1924e6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT040.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4400
X-Proofpoint-ORIG-GUID: XYnp81SlgxvI-837QvS_cdpYwZOnKVAj
X-Proofpoint-GUID: XYnp81SlgxvI-837QvS_cdpYwZOnKVAj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_03:2021-04-08,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=971 clxscore=1015 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104090040
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCIe + DP no SSC multilink configuration sequences.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 131 ++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index becbf8456b2d..bf37569c6c51 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -2572,6 +2572,77 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* PCIe and DP link configuration */
+static struct cdns_reg_pairs pcie_dp_link_cmn_regs[] = {
+	{0x0003, PHY_PLL_CFG},
+	{0x0601, CMN_PDIAG_PLL0_CLK_SEL_M0},
+	{0x0400, CMN_PDIAG_PLL0_CLK_SEL_M1}
+};
+
+static struct cdns_reg_pairs pcie_dp_xcvr_diag_ln_regs[] = {
+	{0x0000, XCVR_DIAG_HSCLK_SEL},
+	{0x0001, XCVR_DIAG_HSCLK_DIV},
+	{0x0012, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_reg_pairs dp_pcie_xcvr_diag_ln_regs[] = {
+	{0x0001, XCVR_DIAG_HSCLK_SEL},
+	{0x0009, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_torrent_vals pcie_dp_link_cmn_vals = {
+	.reg_pairs = pcie_dp_link_cmn_regs,
+	.num_regs = ARRAY_SIZE(pcie_dp_link_cmn_regs),
+};
+
+static struct cdns_torrent_vals pcie_dp_xcvr_diag_ln_vals = {
+	.reg_pairs = pcie_dp_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(pcie_dp_xcvr_diag_ln_regs),
+};
+
+static struct cdns_torrent_vals dp_pcie_xcvr_diag_ln_vals = {
+	.reg_pairs = dp_pcie_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(dp_pcie_xcvr_diag_ln_regs),
+};
+
+/* DP Multilink, 100 MHz Ref clk, no SSC */
+static struct cdns_reg_pairs dp_100_no_ssc_cmn_regs[] = {
+	{0x007F, CMN_TXPUCAL_TUNE},
+	{0x007F, CMN_TXPDCAL_TUNE}
+};
+
+static struct cdns_reg_pairs dp_100_no_ssc_tx_ln_regs[] = {
+	{0x00FB, TX_PSC_A0},
+	{0x04AA, TX_PSC_A2},
+	{0x04AA, TX_PSC_A3},
+	{0x000F, XCVR_DIAG_BIDI_CTRL}
+};
+
+static struct cdns_reg_pairs dp_100_no_ssc_rx_ln_regs[] = {
+	{0x0000, RX_PSC_A0},
+	{0x0000, RX_PSC_A2},
+	{0x0000, RX_PSC_A3},
+	{0x0000, RX_PSC_CAL},
+	{0x0000, RX_REE_GCSM1_CTRL},
+	{0x0000, RX_REE_GCSM2_CTRL},
+	{0x0000, RX_REE_PERGCSM_CTRL}
+};
+
+static struct cdns_torrent_vals dp_100_no_ssc_cmn_vals = {
+	.reg_pairs = dp_100_no_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(dp_100_no_ssc_cmn_regs),
+};
+
+static struct cdns_torrent_vals dp_100_no_ssc_tx_ln_vals = {
+	.reg_pairs = dp_100_no_ssc_tx_ln_regs,
+	.num_regs = ARRAY_SIZE(dp_100_no_ssc_tx_ln_regs),
+};
+
+static struct cdns_torrent_vals dp_100_no_ssc_rx_ln_vals = {
+	.reg_pairs = dp_100_no_ssc_rx_ln_regs,
+	.num_regs = ARRAY_SIZE(dp_100_no_ssc_rx_ln_regs),
+};
+
 /* Single DisplayPort(DP) link configuration */
 static struct cdns_reg_pairs sl_dp_link_cmn_regs[] = {
 	{0x0000, PHY_PLL_CFG},
@@ -3514,6 +3585,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			[TYPE_NONE] = {
 				[NO_SSC] = &sl_dp_link_cmn_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &pcie_dp_link_cmn_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -3536,6 +3610,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &pcie_dp_link_cmn_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -3595,6 +3672,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			[TYPE_NONE] = {
 				[NO_SSC] = &sl_dp_xcvr_diag_ln_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &dp_pcie_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -3617,6 +3697,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &pcie_dp_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -3715,6 +3798,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_cmn_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -3737,6 +3823,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
 					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = NULL,
+				},
 			},
 			[TYPE_SGMII] = {
 				[TYPE_NONE] = {
@@ -3812,6 +3901,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_tx_ln_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -3834,6 +3926,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 					[EXTERNAL_SSC] = NULL,
 					[INTERNAL_SSC] = NULL,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = NULL,
+				},
 			},
 			[TYPE_SGMII] = {
 				[TYPE_NONE] = {
@@ -3909,6 +4004,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -3931,6 +4029,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
 					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_SGMII] = {
 				[TYPE_NONE] = {
@@ -3996,6 +4097,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			[TYPE_NONE] = {
 				[NO_SSC] = &sl_dp_link_cmn_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &pcie_dp_link_cmn_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -4018,6 +4122,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &pcie_dp_link_cmn_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -4077,6 +4184,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			[TYPE_NONE] = {
 				[NO_SSC] = &sl_dp_xcvr_diag_ln_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &dp_pcie_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -4099,6 +4209,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
 			},
+			[TYPE_DP] = {
+				[NO_SSC] = &pcie_dp_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -4197,6 +4310,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_cmn_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4219,6 +4335,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
 					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = NULL,
+				},
 			},
 			[TYPE_SGMII] = {
 				[TYPE_NONE] = {
@@ -4294,6 +4413,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_tx_ln_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_tx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4316,6 +4438,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 					[EXTERNAL_SSC] = NULL,
 					[INTERNAL_SSC] = NULL,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = NULL,
+				},
 			},
 			[TYPE_SGMII] = {
 				[TYPE_NONE] = {
@@ -4391,6 +4516,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &sl_dp_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &dp_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4413,6 +4541,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
 					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
 				},
+				[TYPE_DP] = {
+					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_SGMII] = {
 				[TYPE_NONE] = {
-- 
2.26.1

