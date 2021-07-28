Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7B43D9161
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbhG1Ozu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:55:50 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:37244 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237103AbhG1OzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:55:25 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SEqw9S023163;
        Wed, 28 Jul 2021 07:55:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=9erJHIq1mw1g8DNscJvdoSDc2ra9eEuu/mztlAIYTXY=;
 b=XCvuswRAlRKj9+Ire1VrH0vnAU+bA5yV5fHPlc+fIyGLMRl8PKa9pfl1030DBg+hqWm+
 CrtKYxQhUMECzkS977mW3cxVQZfzOcyKsVGOwf2JMsVe/Q2+yxTGl08ZqdmNQ+OKbG9T
 TCHQJR5yUxzA8/3DKejAihBf5i+GNt5/RqrsOn3AvOub5V+rcQg4fPWIyBeUTnBYjlUC
 TvzwoIO8Qm53bYzc1wEnjkin/7+mZiPZCJ2+SdJS/4eO7Ux8IGKKJ4e9frQYDlsL3LkF
 07FIj+oYeAnXiz4Cmmn2TdS8P72eq8r/pzGJBEoLCR4UaH0+amIufJGUifjEnf3iUDGt qA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3a235vfvm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 07:55:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/6TOHLPF/iimWxkpdOpv0MHvDsRskOOtFlTkCAaNbf38XuaROfQ7qZGB2sGgI+K3H18V1IZgxfHAXsq7fJe7WrhqKFAJate0YCVY+8rAK9AmzaueS/xE63aLSOeJsj30/0TJ3q1izX7riKxhSryroizYWm+XjaYX0Zaj7h1xGCsoU8B+byEK6xKDL4UDWLYjEUqjDXNSm3iJ7cuoCBMWaFC2eBblgGpkHt+wLMPy5B+3kVo9yBJftpmZoMiOR/sA+/zd3sc5UB7rM8tHYT4JprHXWO5D/14i0Ud6C9Ao0QVDNABl8+UA5fEQ4xLScN06YwK2WUglh1NPXY2yFpUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9erJHIq1mw1g8DNscJvdoSDc2ra9eEuu/mztlAIYTXY=;
 b=CMUWtv8wLreHUV1Lhosc0B+ctMK1Lk+oHOUwDF4jAR9mMXY6UCE6VGZ33A37W4TZLjDD4lZormi/i9fe2FO/wVFHz2Biy9wTJMjMjzKGO3ghOSWNRyMxzkA1GaIiCmjHhJdpBt5K0a62fJIBrFPU+tps24zIDgv3P68GXuHbE3hWvhMOC9A8xjHuCsMh445WFG3MAyXW8M0nSIeEHheUz9KdQ8VgEyq2HZME1CjFUP7ymFzPfyyaH/8KRdyiDkmya0+AH9gGWtscKigsruh/o7ruv+6dJlgpHYJqlRCgmYLRugfEn3LRm8i3Ols/0Kl3jxmBeQ+lCSNYlu/3T2G9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9erJHIq1mw1g8DNscJvdoSDc2ra9eEuu/mztlAIYTXY=;
 b=TtxrZ28nUxMFgYhF2/aq1f9pf3dR37vLunwY3ckR5welFxD2388OBNz85JfKpqMrmStzMYRFuc/ufnF8IVRsi1Br6UHi0IPlCHrOag1C5hzXc7+2QIdiecm4/L+S6GtLzJ3H/cZBUwZQdR+gBiUSYsk41wN2U86cnd+PSn5NIbw=
Received: from BN9PR03CA0245.namprd03.prod.outlook.com (2603:10b6:408:ff::10)
 by DM6PR07MB5290.namprd07.prod.outlook.com (2603:10b6:5:4e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 14:55:05 +0000
Received: from BN8NAM12FT008.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::1f) by BN9PR03CA0245.outlook.office365.com
 (2603:10b6:408:ff::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Wed, 28 Jul 2021 14:55:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT008.mail.protection.outlook.com (10.13.183.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.7 via Frontend Transport; Wed, 28 Jul 2021 14:55:03 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 16SEsvrv095664
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 07:55:02 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 28 Jul 2021 16:54:57 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 28 Jul 2021 16:54:57 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 16SEsvDO016545;
        Wed, 28 Jul 2021 16:54:57 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 16SEsvxw016544;
        Wed, 28 Jul 2021 16:54:57 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH v3 6/9] phy: cadence-torrent: Add PHY configuration for DP with 100MHz ref clock
Date:   Wed, 28 Jul 2021 16:54:51 +0200
Message-ID: <20210728145454.15945-7-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210728145454.15945-1-sjakhade@cadence.com>
References: <20210728145454.15945-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 102b450a-2080-42b7-ef6e-08d951d7aec1
X-MS-TrafficTypeDiagnostic: DM6PR07MB5290:
X-Microsoft-Antispam-PRVS: <DM6PR07MB5290EC1D2D8097DB37A7A182C5EA9@DM6PR07MB5290.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hpAG2QktoA1ns3zpWkb/keLZl945coRqfLfAT8W/ZinT5rDXQpomWTtf2lY0H0leAo6qKWdz+JgBttLpdfM+95TZW/liM/JOWxySXtcUN+6NjrTayw/hfnnKvEnyTgyBQuFGLQNxQ3WAdP/O3+J57mJNZ4G3OXO0W5nVe1D2/DAmuMc0heGf8SPlhg1+63anhRmOMXBxpYc9ioq5/KeWtmAmWBQzYQHRwmds+lr/M5N7uVIB5XxdZzWzC4xsmurO5QowPWApi0N1MLvDzRO7k8+E/ZDZIVYzqSjmS/q3ioKoUXEVKNlB+BUeufhS1uS8sGz6lu0YoChwvskNCUj8tDZ6Fh22BQDLhQsd3d43rPEQ76METyHdEHnbdzA4j+YAuaDJTSDNYQPQ9g9UvM4xVpK4DmYC06RSNWY4gq7ycJH6DykCis6sbsMFPSwZFVjSFLYm1iiNTSpZ4N/P1tQRV3ozBShU/e7SMnVYcQLb3UL6Tdy3EB7/V3CR6zsDzx8Ku/NhrOYZ0ACr4ooNP4/SVKdMrzv5MIMdkcKzc8VE7UEd6AqnEq4/WIx48omApSeXb+xcl6FoddbgG0/XiZMmmgYhzE0007elo0ozdQFOyHSTGR/wpMdZvb90SscyGIDZpfyG+mxuR3B2w5VfcHWDVZx3ytBY4Y9VDo3jlQKsK8eKpkQhoJmk0k5qGOk00hGMqgfteOI6LN1RRBojO9T6F07CdQZEyR2AlSDRf5pPD2pbnb0cPwHEPc03RK2RcumXnEW2Px/O/SZacBrDp2Ujwd2zdNKjDynnjywRoWXFRB4=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(36092001)(36840700001)(46966006)(1076003)(6666004)(2616005)(426003)(26005)(5660300002)(86362001)(4326008)(36756003)(82310400003)(81166007)(2906002)(47076005)(186003)(110136005)(42186006)(54906003)(83380400001)(8936002)(478600001)(70586007)(82740400003)(70206006)(356005)(36860700001)(8676002)(336012)(316002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 14:55:03.9260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 102b450a-2080-42b7-ef6e-08d951d7aec1
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT008.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5290
X-Proofpoint-ORIG-GUID: 3-8ZLmAJQ5fs7JejH8olJcDf2reivlmv
X-Proofpoint-GUID: 3-8ZLmAJQ5fs7JejH8olJcDf2reivlmv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_08:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2107280083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PHY configuration registers for single link DP with 100MHz reference
clock and NO_SSC.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 162 ++++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index a6331927d775..69466481af26 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -103,6 +103,7 @@
 #define CMN_PLL0_FRACDIVH_M0		0x0092U
 #define CMN_PLL0_HIGH_THR_M0		0x0093U
 #define CMN_PLL0_DSM_DIAG_M0		0x0094U
+#define CMN_PLL0_DSM_FBH_OVRD_M0	0x0095U
 #define CMN_PLL0_SS_CTRL1_M0		0x0098U
 #define CMN_PLL0_SS_CTRL2_M0            0x0099U
 #define CMN_PLL0_SS_CTRL3_M0            0x009AU
@@ -816,6 +817,89 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy,
 	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_START, 0x00C7);
 }
 
+static
+void cdns_torrent_dp_pma_cmn_vco_cfg_100mhz(struct cdns_torrent_phy *cdns_phy,
+					    u32 rate, bool ssc)
+{
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
+
+	/* Assumes 100 MHz refclock */
+	switch (rate) {
+	/* Setting VCO for 10.8GHz */
+	case 2700:
+	case 5400:
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0028);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_FBH_OVRD_M0, 0x0022);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_FBH_OVRD_M0, 0x0022);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_FBL_OVRD_M0, 0x000C);
+		break;
+	/* Setting VCO for 9.72GHz */
+	case 1620:
+	case 2430:
+	case 3240:
+		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0061);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0061);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x3333);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x3333);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0042);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0042);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		break;
+	/* Setting VCO for 8.64GHz */
+	case 2160:
+	case 4320:
+		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0056);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0056);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x6666);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x6666);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x003A);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x003A);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		break;
+	/* Setting VCO for 8.1GHz */
+	case 8100:
+		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0051);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0051);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0036);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0036);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		break;
+	}
+}
+
 /*
  * Enable or disable PLL for selected lanes.
  */
@@ -1056,6 +1140,10 @@ static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
 	else if (cdns_phy->ref_clk_rate == CLK_25_MHZ)
 		/* PMA common configuration 25MHz */
 		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy, dp->link_rate, dp->ssc);
+	else if (cdns_phy->ref_clk_rate == CLK_100_MHZ)
+		/* PMA common configuration 100MHz */
+		cdns_torrent_dp_pma_cmn_vco_cfg_100mhz(cdns_phy, dp->link_rate, dp->ssc);
+
 	cdns_torrent_dp_pma_cmn_rate(cdns_phy, dp->link_rate, dp->lanes);
 
 	/* Enable the cmn_pll0_en. */
@@ -1395,6 +1483,7 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	switch (cdns_phy->ref_clk_rate) {
 	case CLK_19_2_MHZ:
 	case CLK_25_MHZ:
+	case CLK_100_MHZ:
 		/* Valid Ref Clock Rate */
 		break;
 	default:
@@ -1431,6 +1520,11 @@ static int cdns_torrent_dp_init(struct phy *phy)
 		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy,
 						      cdns_phy->max_bit_rate,
 						      false);
+	else if (cdns_phy->ref_clk_rate == CLK_100_MHZ)
+		cdns_torrent_dp_pma_cmn_vco_cfg_100mhz(cdns_phy,
+						       cdns_phy->max_bit_rate,
+						       false);
+
 	cdns_torrent_dp_pma_cmn_rate(cdns_phy, cdns_phy->max_bit_rate,
 				     inst->num_lanes);
 
@@ -2511,6 +2605,44 @@ static struct cdns_torrent_vals sl_dp_25_no_ssc_rx_ln_vals = {
 	.num_regs = ARRAY_SIZE(sl_dp_25_no_ssc_rx_ln_regs),
 };
 
+/* Single DP, 100 MHz Ref clk, no SSC */
+static struct cdns_reg_pairs sl_dp_100_no_ssc_cmn_regs[] = {
+	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
+	{0x0003, CMN_PLL1_VCOCAL_TCTRL}
+};
+
+static struct cdns_reg_pairs sl_dp_100_no_ssc_tx_ln_regs[] = {
+	{0x00FB, TX_PSC_A0},
+	{0x04AA, TX_PSC_A2},
+	{0x04AA, TX_PSC_A3},
+	{0x000F, XCVR_DIAG_BIDI_CTRL}
+};
+
+static struct cdns_reg_pairs sl_dp_100_no_ssc_rx_ln_regs[] = {
+	{0x0000, RX_PSC_A0},
+	{0x0000, RX_PSC_A2},
+	{0x0000, RX_PSC_A3},
+	{0x0000, RX_PSC_CAL},
+	{0x0000, RX_REE_GCSM1_CTRL},
+	{0x0000, RX_REE_GCSM2_CTRL},
+	{0x0000, RX_REE_PERGCSM_CTRL}
+};
+
+static struct cdns_torrent_vals sl_dp_100_no_ssc_cmn_vals = {
+	.reg_pairs = sl_dp_100_no_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(sl_dp_100_no_ssc_cmn_regs),
+};
+
+static struct cdns_torrent_vals sl_dp_100_no_ssc_tx_ln_vals = {
+	.reg_pairs = sl_dp_100_no_ssc_tx_ln_regs,
+	.num_regs = ARRAY_SIZE(sl_dp_100_no_ssc_tx_ln_regs),
+};
+
+static struct cdns_torrent_vals sl_dp_100_no_ssc_rx_ln_vals = {
+	.reg_pairs = sl_dp_100_no_ssc_rx_ln_regs,
+	.num_regs = ARRAY_SIZE(sl_dp_100_no_ssc_rx_ln_regs),
+};
+
 /* USB and SGMII/QSGMII link configuration */
 static struct cdns_reg_pairs usb_sgmii_link_cmn_regs[] = {
 	{0x0002, PHY_PLL_CFG},
@@ -3450,6 +3582,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[CLK_100_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
+				},
+			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
 					[NO_SSC] = NULL,
@@ -3542,6 +3679,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[CLK_100_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_100_no_ssc_tx_ln_vals,
+				},
+			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
 					[NO_SSC] = NULL,
@@ -3634,6 +3776,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[CLK_100_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_100_no_ssc_rx_ln_vals,
+				},
+			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
@@ -3917,6 +4064,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[CLK_100_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
+				},
+			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
 					[NO_SSC] = NULL,
@@ -4009,6 +4161,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[CLK_100_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_100_no_ssc_tx_ln_vals,
+				},
+			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
 					[NO_SSC] = NULL,
@@ -4101,6 +4258,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[CLK_100_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_100_no_ssc_rx_ln_vals,
+				},
+			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-- 
2.26.1

