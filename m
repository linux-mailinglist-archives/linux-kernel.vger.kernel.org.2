Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5BE32CC76
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 07:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbhCDGLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 01:11:07 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:64806 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234732AbhCDGK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 01:10:59 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1245tXCA026048;
        Wed, 3 Mar 2021 22:08:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=Ed/E38DVP6xDQFl5ZXwa+J3X/QlRabm7GeG1fY8OUv8=;
 b=bWDc3+ZCAlCmyyhQdIEclS0KLXgFU8ilivnn/hNc5Sbybs4nKEczP4LoOzZyo6MX4wS2
 n3HiVfgcD/1y96UXF0EyWafredwQZHYhH+GZ580eCBUa6yF+/puLfXH7rYgbZF5s3AhA
 x+xN/Ii1Wk9LHB4jTKDZMMpidi/dZWl19Om4u42IFsLE2ieHEL1WsM4we4a8y2uH8qHB
 mJn59/Lz2enkLqsNWEkoXXGhvdN0mn5IUx5taIzzwkKHRn5AJEd8RgkUBdyQmdhKI3Ty
 kY7AjG9SnZqU5oRYOfqLB9GpwWIqZp2PhDCGDDm1SLmHGQ6QcV4hAzTTWP9xqDQHNtbH 5A== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2051.outbound.protection.outlook.com [104.47.36.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 36yjj2r9en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 22:08:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bf0hJbo6QFWgirBQF0reDX5G16xalY4WygFZweWX2d05bkJMrT+FTJjic24Oswm44JZytMQ4nxlE1zMrfZ0033/xgyHRUhobxePaIvYb7DO3EWDJsJ+N6Z7Dec3FHZs1dJjv6qP47MX4NSMUy4ciujSyUMivWpStxixmhvHMnwZEy4VRXg20nlV9ljiSN761jXbQ85sb/97EBvtrJuZ58Kf56dXX6JL5AzctqxuU/E6sv/z+stRBfqvxswBV405HqNEVwd0ZsqL3746BhFk/eTZt5VpUTHre66PesXlfguPbwlnHiejjg8GBl1wRSxPffZoy8aKz/RbmejG7wzKwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ed/E38DVP6xDQFl5ZXwa+J3X/QlRabm7GeG1fY8OUv8=;
 b=kZL7caNSnc6KbdNb+a5oIRAzW+e+cOUt4cXQe0qJbCmgSAsiuJiVHwmrt+NcPVdCD7w6+CvvCj9LN5AmudrS0b2w3AQ+nSJiEZNuTAElvcleE+NXhisPkChkDRz0BQe/yq3luYgNzdIizRTaW4Ky9D/jxO+oG4IsQntWmV2zjbV+PYs6nK3vf83/C0AecRWMU/av7wp0G+gyELf8ntN6L3mVYkT3iICb63A9aEAkzf7+mdaxe3rlpwllv6MjOJX167SQIqkhDRNytNv5ASL6yCyrehcZjS6uPYrap+ClhGE19GuVa9X2Ki7MuXViP5NUpA6g7KuTag1WdntrRHV6Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=cadence.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ed/E38DVP6xDQFl5ZXwa+J3X/QlRabm7GeG1fY8OUv8=;
 b=jmHKv/eFfjgQoSVHtEKq9VExbTHIctDVBsUNAHwmL883RV5I2TenCH/pqZcCoDWhjOcf3/yxAVU70x78SjQnVmlTS0lu9AA7SddxdOVltwHG+ccSt7JuCWGwHc7+qVTLdIlFjquaueHCrBHI+UBsaJCH/2oD8A1PJnofXR/BKa0=
Received: from BN9PR03CA0348.namprd03.prod.outlook.com (2603:10b6:408:f6::23)
 by DM6PR07MB6348.namprd07.prod.outlook.com (2603:10b6:5:153::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Thu, 4 Mar
 2021 06:08:25 +0000
Received: from BN8NAM12FT023.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::fd) by BN9PR03CA0348.outlook.office365.com
 (2603:10b6:408:f6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 4 Mar 2021 06:08:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT023.mail.protection.outlook.com (10.13.183.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.9 via Frontend Transport; Thu, 4 Mar 2021 06:08:24 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 12468Jjo067409
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 3 Mar 2021 22:08:23 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 4 Mar 2021 07:08:18 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 4 Mar 2021 07:08:18 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 12468IoP032345;
        Thu, 4 Mar 2021 07:08:18 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 12468IXD032344;
        Thu, 4 Mar 2021 07:08:18 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <nsekhar@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH 1/4] phy: cadence-torrent: Update PCIe + QSGMII config for correct PLL1 clock
Date:   Thu, 4 Mar 2021 07:08:13 +0100
Message-ID: <1614838096-32291-2-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1614838096-32291-1-git-send-email-sjakhade@cadence.com>
References: <1614838096-32291-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34b59c8e-25bf-4048-04de-08d8ded3ebac
X-MS-TrafficTypeDiagnostic: DM6PR07MB6348:
X-Microsoft-Antispam-PRVS: <DM6PR07MB6348C2CA0362F5AEE3D2BBFAC5979@DM6PR07MB6348.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:446;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2knfmheyYwut0oVhGMalXqPUckeXU0D0Kya2Xmb+luQmyp5ck9zv6UP83oZ5SOplgrrkTTWIg1qnGl3Y5kyluXu7KEBay/waNRFdbshOZwWDQcVFw/O7ugWJEkL5Oc6x2axQCpOiRsBBpI3ppAuxKl/CcOsggWW/AnWydqP62kRoFXlPZXf7Lw6vvVPiOYT/c1SHADOdhz+E6TFHHACZEQys7zplvfzymAPQTYFdFVTplO0PKvg37y24maLT7ovpvNAoZqVyV7ORoKfqBQvkUb55kHo/LioY8cpDd3EFAeegxN2aF4XNGLvjM1nghkEjexmxwz54/FW6/Lx1KxNgz2luQVX6yd6IpX2LDlBIkSn5pDXQ03O5e1L3O7ufx83ajg6H+IuxPzdJL8iTr5k2lh2fRHYlE6lrktvGfMxfzJ8h7tC0q8HGN/VrfLe9Pt52WgPjbbMDyI69Tu171s4AdbRN6SjwB4J3qD9Gd+2QFM5s/UpzACcZYg/XYOrWSUr7gzOVaS6lJhsOR4tlyps7JnM1/7lz13sLnTdfX4P3QgqEb4osv4Kdo6MWVIgx6KHORxinZYMDxBS5GHLnJp8gLkjZ1ZHWpAiwaeC/zKnYAB0zR6u3Krsy79DMBHvflc58vZN6hQjDWYnUL3efyH6rpYGK1g6EdO5YeGsRXckT3MeTZJMVOYaeWepaoyoxL6Qbeba7XDatQSLwvW4ToNTHjg==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(36092001)(36840700001)(46966006)(42186006)(2906002)(26005)(86362001)(478600001)(81166007)(82310400003)(356005)(426003)(36756003)(2616005)(47076005)(4326008)(36860700001)(15650500001)(8676002)(36906005)(8936002)(336012)(6666004)(186003)(70586007)(5660300002)(83380400001)(70206006)(110136005)(82740400003)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 06:08:24.4830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b59c8e-25bf-4048-04de-08d8ded3ebac
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT023.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6348
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_01:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 clxscore=1011 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103040025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For PCIe + QSGMII configuration where QSGMII was using PLL1 and was
expecting 10GHz clock, configuration was giving 8GHz clock. Update
register sequences to get correct PLL1 configuration.

Also, update single link PCIe and single link SGMII/QSGMII configurations
with related changes.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 77 ++++++++++++++---------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 9a882bcfd7be..ae1cea2271be 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -126,6 +126,8 @@
 #define CMN_PLL1_FRACDIVH_M0		0x00D2U
 #define CMN_PLL1_HIGH_THR_M0		0x00D3U
 #define CMN_PLL1_DSM_DIAG_M0		0x00D4U
+#define CMN_PLL1_DSM_FBH_OVRD_M0	0x00D5U
+#define CMN_PLL1_DSM_FBL_OVRD_M0	0x00D6U
 #define CMN_PLL1_SS_CTRL1_M0		0x00D8U
 #define CMN_PLL1_SS_CTRL2_M0            0x00D9U
 #define CMN_PLL1_SS_CTRL3_M0            0x00DAU
@@ -167,6 +169,7 @@
 #define TX_TXCC_CPOST_MULT_00		0x004CU
 #define TX_TXCC_CPOST_MULT_01		0x004DU
 #define TX_TXCC_MGNFS_MULT_000		0x0050U
+#define TX_TXCC_MGNFS_MULT_100		0x0054U
 #define DRV_DIAG_TX_DRV			0x00C6U
 #define XCVR_DIAG_PLLDRC_CTRL		0x00E5U
 #define XCVR_DIAG_HSCLK_SEL		0x00E6U
@@ -2841,12 +2844,22 @@ static struct cdns_torrent_vals sgmii_pcie_xcvr_diag_ln_vals = {
 };
 
 /* SGMII 100 MHz Ref clk, no SSC */
-static struct cdns_reg_pairs sgmii_100_no_ssc_cmn_regs[] = {
+static struct cdns_reg_pairs sl_sgmii_100_no_ssc_cmn_regs[] = {
+	{0x0028, CMN_PDIAG_PLL1_CP_PADJ_M0},
+	{0x001E, CMN_PLL1_DSM_FBH_OVRD_M0},
+	{0x000C, CMN_PLL1_DSM_FBL_OVRD_M0},
 	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
-	{0x0003, CMN_PLL1_VCOCAL_TCTRL},
-	{0x3700, CMN_DIAG_BIAS_OVRD1},
-	{0x0008, CMN_TXPUCAL_TUNE},
-	{0x0008, CMN_TXPDCAL_TUNE}
+	{0x0003, CMN_PLL1_VCOCAL_TCTRL}
+};
+
+static struct cdns_torrent_vals sl_sgmii_100_no_ssc_cmn_vals = {
+	.reg_pairs = sl_sgmii_100_no_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(sl_sgmii_100_no_ssc_cmn_regs),
+};
+
+static struct cdns_reg_pairs sgmii_100_no_ssc_cmn_regs[] = {
+	{0x007F, CMN_TXPUCAL_TUNE},
+	{0x007F, CMN_TXPDCAL_TUNE}
 };
 
 static struct cdns_reg_pairs sgmii_100_no_ssc_tx_ln_regs[] = {
@@ -2932,17 +2945,14 @@ static struct cdns_reg_pairs sgmii_100_int_ssc_cmn_regs[] = {
 	{0x0C5E, CMN_PLL1_VCOCAL_REFTIM_START},
 	{0x0C56, CMN_PLL0_VCOCAL_PLLCNT_START},
 	{0x0C56, CMN_PLL1_VCOCAL_PLLCNT_START},
-	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
-	{0x0003, CMN_PLL1_VCOCAL_TCTRL},
 	{0x00C7, CMN_PLL0_LOCK_REFCNT_START},
 	{0x00C7, CMN_PLL1_LOCK_REFCNT_START},
 	{0x00C7, CMN_PLL0_LOCK_PLLCNT_START},
 	{0x00C7, CMN_PLL1_LOCK_PLLCNT_START},
 	{0x0005, CMN_PLL0_LOCK_PLLCNT_THR},
 	{0x0005, CMN_PLL1_LOCK_PLLCNT_THR},
-	{0x3700, CMN_DIAG_BIAS_OVRD1},
-	{0x0008, CMN_TXPUCAL_TUNE},
-	{0x0008, CMN_TXPDCAL_TUNE}
+	{0x007F, CMN_TXPUCAL_TUNE},
+	{0x007F, CMN_TXPDCAL_TUNE}
 };
 
 static struct cdns_torrent_vals sgmii_100_int_ssc_cmn_vals = {
@@ -2951,16 +2961,30 @@ static struct cdns_torrent_vals sgmii_100_int_ssc_cmn_vals = {
 };
 
 /* QSGMII 100 MHz Ref clk, no SSC */
-static struct cdns_reg_pairs qsgmii_100_no_ssc_cmn_regs[] = {
+static struct cdns_reg_pairs sl_qsgmii_100_no_ssc_cmn_regs[] = {
+	{0x0028, CMN_PDIAG_PLL1_CP_PADJ_M0},
+	{0x001E, CMN_PLL1_DSM_FBH_OVRD_M0},
+	{0x000C, CMN_PLL1_DSM_FBL_OVRD_M0},
 	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
 	{0x0003, CMN_PLL1_VCOCAL_TCTRL}
 };
 
+static struct cdns_torrent_vals sl_qsgmii_100_no_ssc_cmn_vals = {
+	.reg_pairs = sl_qsgmii_100_no_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(sl_qsgmii_100_no_ssc_cmn_regs),
+};
+
+static struct cdns_reg_pairs qsgmii_100_no_ssc_cmn_regs[] = {
+	{0x007F, CMN_TXPUCAL_TUNE},
+	{0x007F, CMN_TXPDCAL_TUNE}
+};
+
 static struct cdns_reg_pairs qsgmii_100_no_ssc_tx_ln_regs[] = {
 	{0x00F3, TX_PSC_A0},
 	{0x04A2, TX_PSC_A2},
 	{0x04A2, TX_PSC_A3},
 	{0x0000, TX_TXCC_CPOST_MULT_00},
+	{0x0011, TX_TXCC_MGNFS_MULT_100},
 	{0x0003, DRV_DIAG_TX_DRV}
 };
 
@@ -3039,14 +3063,14 @@ static struct cdns_reg_pairs qsgmii_100_int_ssc_cmn_regs[] = {
 	{0x0C5E, CMN_PLL1_VCOCAL_REFTIM_START},
 	{0x0C56, CMN_PLL0_VCOCAL_PLLCNT_START},
 	{0x0C56, CMN_PLL1_VCOCAL_PLLCNT_START},
-	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
-	{0x0003, CMN_PLL1_VCOCAL_TCTRL},
 	{0x00C7, CMN_PLL0_LOCK_REFCNT_START},
 	{0x00C7, CMN_PLL1_LOCK_REFCNT_START},
 	{0x00C7, CMN_PLL0_LOCK_PLLCNT_START},
 	{0x00C7, CMN_PLL1_LOCK_PLLCNT_START},
 	{0x0005, CMN_PLL0_LOCK_PLLCNT_THR},
-	{0x0005, CMN_PLL1_LOCK_PLLCNT_THR}
+	{0x0005, CMN_PLL1_LOCK_PLLCNT_THR},
+	{0x007F, CMN_TXPUCAL_TUNE},
+	{0x007F, CMN_TXPDCAL_TUNE}
 };
 
 static struct cdns_torrent_vals qsgmii_100_int_ssc_cmn_vals = {
@@ -3118,8 +3142,6 @@ static struct cdns_reg_pairs pcie_100_int_ssc_cmn_regs[] = {
 	{0x0C5E, CMN_PLL1_VCOCAL_REFTIM_START},
 	{0x0C56, CMN_PLL0_VCOCAL_PLLCNT_START},
 	{0x0C56, CMN_PLL1_VCOCAL_PLLCNT_START},
-	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
-	{0x0003, CMN_PLL1_VCOCAL_TCTRL},
 	{0x00C7, CMN_PLL0_LOCK_REFCNT_START},
 	{0x00C7, CMN_PLL1_LOCK_REFCNT_START},
 	{0x00C7, CMN_PLL0_LOCK_PLLCNT_START},
@@ -3175,8 +3197,6 @@ static struct cdns_reg_pairs sl_pcie_100_int_ssc_cmn_regs[] = {
 	{0x0C5E, CMN_PLL1_VCOCAL_REFTIM_START},
 	{0x0C56, CMN_PLL0_VCOCAL_PLLCNT_START},
 	{0x0C56, CMN_PLL1_VCOCAL_PLLCNT_START},
-	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
-	{0x0003, CMN_PLL1_VCOCAL_TCTRL},
 	{0x00C7, CMN_PLL0_LOCK_REFCNT_START},
 	{0x00C7, CMN_PLL1_LOCK_REFCNT_START},
 	{0x00C7, CMN_PLL0_LOCK_PLLCNT_START},
@@ -3192,8 +3212,9 @@ static struct cdns_torrent_vals sl_pcie_100_int_ssc_cmn_vals = {
 
 /* PCIe, 100 MHz Ref clk, no SSC & external SSC */
 static struct cdns_reg_pairs pcie_100_ext_no_ssc_cmn_regs[] = {
-	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
-	{0x0003, CMN_PLL1_VCOCAL_TCTRL}
+	{0x0028, CMN_PDIAG_PLL1_CP_PADJ_M0},
+	{0x001E, CMN_PLL1_DSM_FBH_OVRD_M0},
+	{0x000C, CMN_PLL1_DSM_FBL_OVRD_M0}
 };
 
 static struct cdns_reg_pairs pcie_100_ext_no_ssc_rx_ln_regs[] = {
@@ -3394,8 +3415,8 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 	.cmn_vals = {
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
-				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
 				[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
 			},
 			[TYPE_SGMII] = {
@@ -3416,7 +3437,7 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
-				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
+				[NO_SSC] = &sl_sgmii_100_no_ssc_cmn_vals,
 			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
@@ -3431,7 +3452,7 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 		},
 		[TYPE_QSGMII] = {
 			[TYPE_NONE] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+				[NO_SSC] = &sl_qsgmii_100_no_ssc_cmn_vals,
 			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
@@ -3803,8 +3824,8 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 	.cmn_vals = {
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
-				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
 				[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
 			},
 			[TYPE_SGMII] = {
@@ -3825,7 +3846,7 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
-				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
+				[NO_SSC] = &sl_sgmii_100_no_ssc_cmn_vals,
 			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
@@ -3840,7 +3861,7 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 		},
 		[TYPE_QSGMII] = {
 			[TYPE_NONE] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+				[NO_SSC] = &sl_qsgmii_100_no_ssc_cmn_vals,
 			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-- 
2.26.1

