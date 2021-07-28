Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9967D3D9162
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbhG1Ozx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:55:53 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:25258 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237213AbhG1Oz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:55:28 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SEjuEk024292;
        Wed, 28 Jul 2021 07:55:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=9lb9mmOOQyix0GPvKsN7F0ZXgNro6rYkWWjwXieT2sw=;
 b=lRuCcdTlZT5b4kwc7yUoZBPV3pqCJMELJmYPf4GINUL0VTFHTZTt1Ti9bP4D5fHMtSd+
 uwx1TxFQxXVv7EcwfMrqDhTt+cjiYX5pciCJeXi0PhuiiBsPceHcVi4ZV+UxM9fwicEb
 31C5dB0zINYxyIGN2zVRREAtq4snnzzauVoKTj+rC5ZHQmUQnnxxVE7dgEtNd1hQPMnk
 Cl7B+McwclHL+31NkO6hEBFAI7bcDvFzZNsd5eQR7G/q091jiOgiKDi+EwLNyWQp/pGz
 2jautOQDCQIZIhOZuRvgFrL9iyaH3C8v4X0bZruA5JF2dVWlbqVtl7d8mk7OXL3VELFq 3w== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3a234aysbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 07:55:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3ibyPbBlNw+uhtN/DBH7UHWkBBkR9df1CGczju1RVz2CeByPyPnVWf1izHqDh5kr3+2HTZDaUG+sftoWguggrAd170Cd/pAXNRqA1nN2+pwLZmyhzZytOHbQHueLVuaBqLgrQ3C6kzcsC8IVJ9YXPiPpqRejCU/Rn2jfCInjc/nX6tFBQFbjapQfg2TBVEAPyDVLcdK6V5FX76QlJp0jV0L7Iem7Ic61PmLra/OSrYn8LtUNIREOeH99aei1PQ0olDBvRPRHTyE1joR9Sdg5sLFYQzr9Ywlr1D7Q9RzSvoHnzkE9QQB4Dd/wy77lXTsYRjfR89gRii6pFCea16GAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lb9mmOOQyix0GPvKsN7F0ZXgNro6rYkWWjwXieT2sw=;
 b=KqwtXQzukOP70sUqXyG2f3vocX2ZYNDAPwrmI6w4grKzVvtuDuDyiFbpFCM3NKeBDmTh0A0ujTNZ0qbxm4Z99gDce+M/ppx4cAuHdMTh9WuoHzFdWDkciEQ+QUD/OgJRNpSJ9lhfHbpwWdmgT8BYl+02ZM0qijSsIzPqghi3NHjydzAeJF1Cc1I79O1Q6b7FVd+L2KrzotrdJsjhpH8cPPnQs0tWTyEjvn9oLGmRPXshlb3huwd4d90rXiRh7+4uZ2zKVAxGrVysXfx8tOW0jkST5xe7Hso6O75YTVEQaPq02iGNyrahN6O/I3SXJfUX79NR5j+L42yvX5HIj/1IFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lb9mmOOQyix0GPvKsN7F0ZXgNro6rYkWWjwXieT2sw=;
 b=DyPWVeGAG38X2LPv8jIbnpbc677DAjG6EkGKx/Q3lVJ0szdWTTiRbamnqrhNle/gLNqhmzWOuO+m6yfBBMmPyCXE0FRLhiA5jKfG+6ZGzvb5FnD6FMjvfCHj36fkVCVsB+Fnh4IIW+0CGnxBCRndT4jAJJtRWMdOKgorXxixfkI=
Received: from BN8PR12CA0019.namprd12.prod.outlook.com (2603:10b6:408:60::32)
 by DM5PR0701MB3718.namprd07.prod.outlook.com (2603:10b6:4:7e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 14:55:03 +0000
Received: from BN8NAM12FT010.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::49) by BN8PR12CA0019.outlook.office365.com
 (2603:10b6:408:60::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Wed, 28 Jul 2021 14:55:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT010.mail.protection.outlook.com (10.13.182.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.7 via Frontend Transport; Wed, 28 Jul 2021 14:55:02 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 16SEsvrt095664
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 07:55:01 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 28 Jul 2021 16:54:57 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 28 Jul 2021 16:54:57 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 16SEsvWF016541;
        Wed, 28 Jul 2021 16:54:57 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 16SEsuJY016540;
        Wed, 28 Jul 2021 16:54:56 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH v3 5/9] phy: cadence-torrent: Add PHY registers for DP in array format
Date:   Wed, 28 Jul 2021 16:54:50 +0200
Message-ID: <20210728145454.15945-6-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210728145454.15945-1-sjakhade@cadence.com>
References: <20210728145454.15945-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8458efda-467f-432e-53c5-08d951d7ae16
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3718:
X-Microsoft-Antispam-PRVS: <DM5PR0701MB371899C0941D03BE6E58C8F8C5EA9@DM5PR0701MB3718.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5DCNoCiTNDBuEgdI+QgTj83Iloi9H2pgpzrUxmrQhxxJ3q48dCvV+VOzlyz6aRNHK1q+uz0LYgYcLJAYuymFYoh5K+j+XAQm3R6ngk3Tu+QvD15neiNuey3YDdIJWR9IBb6ZSm66pPiAvntzlhDkYPlsCbFm2LkAE0sSliPrhAxj1ZBADJ2z8kYq15E5EFTApHho6iEFhwzXkhi6N+D3cVFMqdeHrrf8tnH1TRqR9WdsUD/uBervig8dOevQ1Akop083H9lr39I1G6AZBZRacV6DMrgZ/IOWNWcSpqiMfXl6e12+FjDOPlPTs5EGv1s0bhzv3wkumBAXvspIrLZdQtWNO4clWOtX71fnxTyu8RImU5rSwDKr0NBuk9xX8iGxuuDRf/BciaS22SNvdjIJBzjdR/JoZ5YSIyS01GN6Bi6vuje+Sqw1K+usHmopYGSnf6drzvCrIWkX0brVNYszzjMLrGocaM/Xl5gqSoteiEyH3uG0BbWokqWDSQkQkqaMsFo0K+xxncOvjW/uTJUMZYx5V0xXiqLgsTbd2fY8GNeBBal9/9h0UU+BGlBKjihDPZRLMYFAj27jkBsWlDvaj4oXAApdyOdJSRFKIsFvZu/YanE9/9cwMBdebJHTwHTeFQvWrr0r4LN5Vkdhb1dMCLvQdzSL/njfLkRQ2NoBSU3eK8dnvfUwOCLT+m/GvRRtnKbzQm/CcIDzfA/eL1aPW1OVR1+N8kmfB1WNAlmv0utNp12YM7kIfVkSiCWRDnC9i5em0/SqzfZAKWYZpiblvu6Dn1KoxFT4q/XpEvRNZX4=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(36092001)(36840700001)(46966006)(6666004)(1076003)(2616005)(82310400003)(4326008)(30864003)(5660300002)(86362001)(36756003)(426003)(47076005)(2906002)(478600001)(336012)(186003)(110136005)(8936002)(83380400001)(54906003)(82740400003)(356005)(8676002)(26005)(36860700001)(70586007)(316002)(70206006)(81166007)(42186006)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 14:55:02.8034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8458efda-467f-432e-53c5-08d951d7ae16
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT010.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3718
X-Proofpoint-ORIG-GUID: ZHwA1CJk5i5bq-CrC-VuYETrcFZTRrKW
X-Proofpoint-GUID: ZHwA1CJk5i5bq-CrC-VuYETrcFZTRrKW
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

Add PHY registers for single link DP in array format to simplify
code and to improve readability. This supports already supported
frequencies for DP of 19.2MHz and 25MHz.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 622 ++++++++++++----------
 1 file changed, 334 insertions(+), 288 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 86f05817704d..a6331927d775 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -572,50 +572,6 @@ static const struct coefficients vltg_coeff[4][4] = {
 	}
 };
 
-static
-void cdns_torrent_dp_pma_cmn_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy)
-{
-	struct regmap *regmap = cdns_phy->regmap_common_cdb;
-
-	/* refclock registers - assumes 19.2 MHz refclock */
-	cdns_torrent_phy_write(regmap, CMN_SSM_BIAS_TMR, 0x0014);
-	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLPRE_TMR, 0x0027);
-	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLLOCK_TMR, 0x00A1);
-	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLPRE_TMR, 0x0027);
-	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLLOCK_TMR, 0x00A1);
-	cdns_torrent_phy_write(regmap, CMN_BGCAL_INIT_TMR, 0x0060);
-	cdns_torrent_phy_write(regmap, CMN_BGCAL_ITER_TMR, 0x0060);
-	cdns_torrent_phy_write(regmap, CMN_IBCAL_INIT_TMR, 0x0014);
-	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_INIT_TMR, 0x0018);
-	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_ITER_TMR, 0x0005);
-	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_INIT_TMR, 0x0018);
-	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_ITER_TMR, 0x0005);
-	cdns_torrent_phy_write(regmap, CMN_RXCAL_INIT_TMR, 0x0240);
-	cdns_torrent_phy_write(regmap, CMN_RXCAL_ITER_TMR, 0x0005);
-	cdns_torrent_phy_write(regmap, CMN_SD_CAL_INIT_TMR, 0x0002);
-	cdns_torrent_phy_write(regmap, CMN_SD_CAL_ITER_TMR, 0x0002);
-	cdns_torrent_phy_write(regmap, CMN_SD_CAL_REFTIM_START, 0x000B);
-	cdns_torrent_phy_write(regmap, CMN_SD_CAL_PLLCNT_START, 0x0137);
-
-	/* PLL registers */
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_INIT_TMR, 0x00C0);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_ITER_TMR, 0x0004);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_INIT_TMR, 0x00C0);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_ITER_TMR, 0x0004);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_REFTIM_START, 0x0260);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_TCTRL, 0x0003);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_REFTIM_START, 0x0260);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_TCTRL, 0x0003);
-}
-
 /*
  * Set registers responsible for enabling and configuring SSC, with second and
  * third register values provided by parameters.
@@ -647,148 +603,88 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
 	/* Setting VCO for 10.8GHz */
 	case 2700:
 	case 5400:
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_INTDIV_M0, 0x0119);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_FRACDIVL_M0, 0x4000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_HIGH_THR_M0, 0x00BC);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PDIAG_PLL0_CTRL_M0, 0x0012);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_INTDIV_M0, 0x0119);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_FRACDIVL_M0, 0x4000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_HIGH_THR_M0, 0x00BC);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PDIAG_PLL1_CTRL_M0, 0x0012);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0119);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x4000);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x00BC);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0012);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0119);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x4000);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x00BC);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0012);
 		if (ssc)
-			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x033A,
-							   0x006A);
+			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x033A, 0x006A);
 		break;
 	/* Setting VCO for 9.72GHz */
 	case 1620:
 	case 2430:
 	case 3240:
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_INTDIV_M0, 0x01FA);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_FRACDIVL_M0, 0x4000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_HIGH_THR_M0, 0x0152);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_INTDIV_M0, 0x01FA);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_FRACDIVL_M0, 0x4000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_HIGH_THR_M0, 0x0152);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x01FA);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x4000);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0152);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x01FA);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x4000);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0152);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
 		if (ssc)
-			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x05DD,
-							   0x0069);
+			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x05DD, 0x0069);
 		break;
 	/* Setting VCO for 8.64GHz */
 	case 2160:
 	case 4320:
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_INTDIV_M0, 0x01C2);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_HIGH_THR_M0, 0x012C);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_INTDIV_M0, 0x01C2);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_HIGH_THR_M0, 0x012C);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x01C2);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x012C);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x01C2);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x012C);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
 		if (ssc)
-			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x0536,
-							   0x0069);
+			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x0536, 0x0069);
 		break;
 	/* Setting VCO for 8.1GHz */
 	case 8100:
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_INTDIV_M0, 0x01A5);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_FRACDIVL_M0, 0xE000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_HIGH_THR_M0, 0x011A);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_INTDIV_M0, 0x01A5);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_FRACDIVL_M0, 0xE000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_HIGH_THR_M0, 0x011A);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x01A5);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0xE000);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x011A);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x01A5);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0xE000);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x011A);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
 		if (ssc)
-			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x04D7,
-							   0x006A);
+			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x04D7, 0x006A);
 		break;
 	}
 
 	if (ssc) {
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x025E);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0005);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x025E);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0005);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_PLLCNT_START, 0x025E);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_PLLCNT_THR, 0x0005);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_PLLCNT_START, 0x025E);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_THR, 0x0005);
 	} else {
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x0260);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x0260);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_PLLCNT_START, 0x0260);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_PLLCNT_START, 0x0260);
 		/* Set reset register values to disable SSC */
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_SS_CTRL1_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_SS_CTRL2_M0, 0x0000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_SS_CTRL3_M0, 0x0000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_SS_CTRL4_M0, 0x0000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0003);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_SS_CTRL1_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_SS_CTRL2_M0, 0x0000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_SS_CTRL3_M0, 0x0000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_SS_CTRL4_M0, 0x0000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0003);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL2_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL3_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL4_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_PLLCNT_THR, 0x0003);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL2_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL3_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL4_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_THR, 0x0003);
 	}
 
 	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_REFCNT_START, 0x0099);
@@ -797,50 +693,6 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
 	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_START, 0x0099);
 }
 
-static
-void cdns_torrent_dp_pma_cmn_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
-{
-	struct regmap *regmap = cdns_phy->regmap_common_cdb;
-
-	/* refclock registers - assumes 25 MHz refclock */
-	cdns_torrent_phy_write(regmap, CMN_SSM_BIAS_TMR, 0x0019);
-	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLPRE_TMR, 0x0032);
-	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLLOCK_TMR, 0x00D1);
-	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLPRE_TMR, 0x0032);
-	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLLOCK_TMR, 0x00D1);
-	cdns_torrent_phy_write(regmap, CMN_BGCAL_INIT_TMR, 0x007D);
-	cdns_torrent_phy_write(regmap, CMN_BGCAL_ITER_TMR, 0x007D);
-	cdns_torrent_phy_write(regmap, CMN_IBCAL_INIT_TMR, 0x0019);
-	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_INIT_TMR, 0x001E);
-	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_ITER_TMR, 0x0006);
-	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_INIT_TMR, 0x001E);
-	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_ITER_TMR, 0x0006);
-	cdns_torrent_phy_write(regmap, CMN_RXCAL_INIT_TMR, 0x02EE);
-	cdns_torrent_phy_write(regmap, CMN_RXCAL_ITER_TMR, 0x0006);
-	cdns_torrent_phy_write(regmap, CMN_SD_CAL_INIT_TMR, 0x0002);
-	cdns_torrent_phy_write(regmap, CMN_SD_CAL_ITER_TMR, 0x0002);
-	cdns_torrent_phy_write(regmap, CMN_SD_CAL_REFTIM_START, 0x000E);
-	cdns_torrent_phy_write(regmap, CMN_SD_CAL_PLLCNT_START, 0x012B);
-
-	/* PLL registers */
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_INIT_TMR, 0x00FA);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_ITER_TMR, 0x0004);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_INIT_TMR, 0x00FA);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_ITER_TMR, 0x0004);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_REFTIM_START, 0x0317);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_TCTRL, 0x0003);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_REFTIM_START, 0x0317);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_TCTRL, 0x0003);
-}
-
 /*
  * Set registers responsible for enabling and configuring SSC, with second
  * register value provided by a parameter.
@@ -964,66 +816,6 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy,
 	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_START, 0x00C7);
 }
 
-static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
-					 unsigned int lane)
-{
-	/* Per lane, refclock-dependent receiver detection setting */
-	if (cdns_phy->ref_clk_rate == CLK_19_2_MHZ)
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
-				       TX_RCVDET_ST_TMR, 0x0780);
-	else if (cdns_phy->ref_clk_rate == CLK_25_MHZ)
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
-				       TX_RCVDET_ST_TMR, 0x09C4);
-
-	/* Writing Tx/Rx Power State Controllers registers */
-	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
-			       TX_PSC_A0, 0x00FB);
-	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
-			       TX_PSC_A2, 0x04AA);
-	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
-			       TX_PSC_A3, 0x04AA);
-	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
-			       RX_PSC_A0, 0x0000);
-	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
-			       RX_PSC_A2, 0x0000);
-	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
-			       RX_PSC_A3, 0x0000);
-
-	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
-			       RX_PSC_CAL, 0x0000);
-
-	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
-			       RX_REE_GCSM1_CTRL, 0x0000);
-	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
-			       RX_REE_GCSM2_CTRL, 0x0000);
-	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
-			       RX_REE_PERGCSM_CTRL, 0x0000);
-
-	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
-			       XCVR_DIAG_BIDI_CTRL, 0x000F);
-	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
-			       XCVR_DIAG_PLLDRC_CTRL, 0x0001);
-	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
-			       XCVR_DIAG_HSCLK_SEL, 0x0000);
-}
-
-static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy,
-				    struct cdns_torrent_inst *inst)
-{
-	unsigned int i;
-
-	if (cdns_phy->ref_clk_rate == CLK_19_2_MHZ)
-		/* PMA common configuration 19.2MHz */
-		cdns_torrent_dp_pma_cmn_cfg_19_2mhz(cdns_phy);
-	else if (cdns_phy->ref_clk_rate == CLK_25_MHZ)
-		/* PMA common configuration 25MHz */
-		cdns_torrent_dp_pma_cmn_cfg_25mhz(cdns_phy);
-
-	/* PMA lane configuration to deal with multi-link operation */
-	for (i = 0; i < inst->num_lanes; i++)
-		cdns_torrent_dp_pma_lane_cfg(cdns_phy, i);
-}
-
 /*
  * Enable or disable PLL for selected lanes.
  */
@@ -1196,9 +988,6 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
 	unsigned int hsclk_div_val = 0;
 	unsigned int i;
 
-	/* 16'h0000 for single DP link configuration */
-	regmap_field_write(cdns_phy->phy_pll_cfg, 0x0);
-
 	switch (rate) {
 	case 1620:
 		clk_sel_val = 0x0f01;
@@ -1243,8 +1032,7 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
 static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
 					  struct phy_configure_opts_dp *dp)
 {
-	u32 ret;
-	u32 read_val;
+	u32 read_val, ret;
 
 	/* Disable the cmn_pll0_en before re-programming the new data rate. */
 	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, 0x0);
@@ -1262,17 +1050,12 @@ static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
 	ndelay(200);
 
 	/* DP Rate Change - VCO Output settings. */
-	if (cdns_phy->ref_clk_rate == CLK_19_2_MHZ) {
+	if (cdns_phy->ref_clk_rate == CLK_19_2_MHZ)
 		/* PMA common configuration 19.2MHz */
-		cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy, dp->link_rate,
-							dp->ssc);
-		cdns_torrent_dp_pma_cmn_cfg_19_2mhz(cdns_phy);
-	} else if (cdns_phy->ref_clk_rate == CLK_25_MHZ) {
+		cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy, dp->link_rate, dp->ssc);
+	else if (cdns_phy->ref_clk_rate == CLK_25_MHZ)
 		/* PMA common configuration 25MHz */
-		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy, dp->link_rate,
-						      dp->ssc);
-		cdns_torrent_dp_pma_cmn_cfg_25mhz(cdns_phy);
-	}
+		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy, dp->link_rate, dp->ssc);
 	cdns_torrent_dp_pma_cmn_rate(cdns_phy, dp->link_rate, dp->lanes);
 
 	/* Enable the cmn_pll0_en. */
@@ -1621,9 +1404,6 @@ static int cdns_torrent_dp_init(struct phy *phy)
 
 	cdns_torrent_dp_write(regmap, PHY_AUX_CTRL, 0x0003); /* enable AUX */
 
-	/* PHY PMA registers configuration function */
-	cdns_torrent_dp_pma_cfg(cdns_phy, inst);
-
 	/*
 	 * Set lines power state to A0
 	 * Set lines pll clk enable to 0
@@ -1957,9 +1737,6 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	if (cdns_phy->nsubnodes > 1)
 		return 0;
 
-	if (phy_type == TYPE_DP)
-		return cdns_torrent_dp_init(phy);
-
 	/**
 	 * Spread spectrum generation is not required or supported
 	 * for SGMII/QSGMII
@@ -2045,6 +1822,9 @@ static int cdns_torrent_phy_init(struct phy *phy)
 		}
 	}
 
+	if (phy_type == TYPE_DP)
+		return cdns_torrent_dp_init(phy);
+
 	return 0;
 }
 
@@ -2569,6 +2349,168 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* Single DisplayPort(DP) link configuration */
+static struct cdns_reg_pairs sl_dp_link_cmn_regs[] = {
+	{0x0000, PHY_PLL_CFG},
+};
+
+static struct cdns_reg_pairs sl_dp_xcvr_diag_ln_regs[] = {
+	{0x0000, XCVR_DIAG_HSCLK_SEL},
+	{0x0001, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_torrent_vals sl_dp_link_cmn_vals = {
+	.reg_pairs = sl_dp_link_cmn_regs,
+	.num_regs = ARRAY_SIZE(sl_dp_link_cmn_regs),
+};
+
+static struct cdns_torrent_vals sl_dp_xcvr_diag_ln_vals = {
+	.reg_pairs = sl_dp_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(sl_dp_xcvr_diag_ln_regs),
+};
+
+/* Single DP, 19.2 MHz Ref clk, no SSC */
+static struct cdns_reg_pairs sl_dp_19_2_no_ssc_cmn_regs[] = {
+	{0x0014, CMN_SSM_BIAS_TMR},
+	{0x0027, CMN_PLLSM0_PLLPRE_TMR},
+	{0x00A1, CMN_PLLSM0_PLLLOCK_TMR},
+	{0x0027, CMN_PLLSM1_PLLPRE_TMR},
+	{0x00A1, CMN_PLLSM1_PLLLOCK_TMR},
+	{0x0060, CMN_BGCAL_INIT_TMR},
+	{0x0060, CMN_BGCAL_ITER_TMR},
+	{0x0014, CMN_IBCAL_INIT_TMR},
+	{0x0018, CMN_TXPUCAL_INIT_TMR},
+	{0x0005, CMN_TXPUCAL_ITER_TMR},
+	{0x0018, CMN_TXPDCAL_INIT_TMR},
+	{0x0005, CMN_TXPDCAL_ITER_TMR},
+	{0x0240, CMN_RXCAL_INIT_TMR},
+	{0x0005, CMN_RXCAL_ITER_TMR},
+	{0x0002, CMN_SD_CAL_INIT_TMR},
+	{0x0002, CMN_SD_CAL_ITER_TMR},
+	{0x000B, CMN_SD_CAL_REFTIM_START},
+	{0x0137, CMN_SD_CAL_PLLCNT_START},
+	{0x0509, CMN_PDIAG_PLL0_CP_PADJ_M0},
+	{0x0F00, CMN_PDIAG_PLL0_CP_IADJ_M0},
+	{0x0F08, CMN_PDIAG_PLL0_FILT_PADJ_M0},
+	{0x0004, CMN_PLL0_DSM_DIAG_M0},
+	{0x0509, CMN_PDIAG_PLL1_CP_PADJ_M0},
+	{0x0F00, CMN_PDIAG_PLL1_CP_IADJ_M0},
+	{0x0F08, CMN_PDIAG_PLL1_FILT_PADJ_M0},
+	{0x0004, CMN_PLL1_DSM_DIAG_M0},
+	{0x00C0, CMN_PLL0_VCOCAL_INIT_TMR},
+	{0x0004, CMN_PLL0_VCOCAL_ITER_TMR},
+	{0x00C0, CMN_PLL1_VCOCAL_INIT_TMR},
+	{0x0004, CMN_PLL1_VCOCAL_ITER_TMR},
+	{0x0260, CMN_PLL0_VCOCAL_REFTIM_START},
+	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
+	{0x0260, CMN_PLL1_VCOCAL_REFTIM_START},
+	{0x0003, CMN_PLL1_VCOCAL_TCTRL}
+};
+
+static struct cdns_reg_pairs sl_dp_19_2_no_ssc_tx_ln_regs[] = {
+	{0x0780, TX_RCVDET_ST_TMR},
+	{0x00FB, TX_PSC_A0},
+	{0x04AA, TX_PSC_A2},
+	{0x04AA, TX_PSC_A3},
+	{0x000F, XCVR_DIAG_BIDI_CTRL}
+};
+
+static struct cdns_reg_pairs sl_dp_19_2_no_ssc_rx_ln_regs[] = {
+	{0x0000, RX_PSC_A0},
+	{0x0000, RX_PSC_A2},
+	{0x0000, RX_PSC_A3},
+	{0x0000, RX_PSC_CAL},
+	{0x0000, RX_REE_GCSM1_CTRL},
+	{0x0000, RX_REE_GCSM2_CTRL},
+	{0x0000, RX_REE_PERGCSM_CTRL}
+};
+
+static struct cdns_torrent_vals sl_dp_19_2_no_ssc_cmn_vals = {
+	.reg_pairs = sl_dp_19_2_no_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(sl_dp_19_2_no_ssc_cmn_regs),
+};
+
+static struct cdns_torrent_vals sl_dp_19_2_no_ssc_tx_ln_vals = {
+	.reg_pairs = sl_dp_19_2_no_ssc_tx_ln_regs,
+	.num_regs = ARRAY_SIZE(sl_dp_19_2_no_ssc_tx_ln_regs),
+};
+
+static struct cdns_torrent_vals sl_dp_19_2_no_ssc_rx_ln_vals = {
+	.reg_pairs = sl_dp_19_2_no_ssc_rx_ln_regs,
+	.num_regs = ARRAY_SIZE(sl_dp_19_2_no_ssc_rx_ln_regs),
+};
+
+/* Single DP, 25 MHz Ref clk, no SSC */
+static struct cdns_reg_pairs sl_dp_25_no_ssc_cmn_regs[] = {
+	{0x0019, CMN_SSM_BIAS_TMR},
+	{0x0032, CMN_PLLSM0_PLLPRE_TMR},
+	{0x00D1, CMN_PLLSM0_PLLLOCK_TMR},
+	{0x0032, CMN_PLLSM1_PLLPRE_TMR},
+	{0x00D1, CMN_PLLSM1_PLLLOCK_TMR},
+	{0x007D, CMN_BGCAL_INIT_TMR},
+	{0x007D, CMN_BGCAL_ITER_TMR},
+	{0x0019, CMN_IBCAL_INIT_TMR},
+	{0x001E, CMN_TXPUCAL_INIT_TMR},
+	{0x0006, CMN_TXPUCAL_ITER_TMR},
+	{0x001E, CMN_TXPDCAL_INIT_TMR},
+	{0x0006, CMN_TXPDCAL_ITER_TMR},
+	{0x02EE, CMN_RXCAL_INIT_TMR},
+	{0x0006, CMN_RXCAL_ITER_TMR},
+	{0x0002, CMN_SD_CAL_INIT_TMR},
+	{0x0002, CMN_SD_CAL_ITER_TMR},
+	{0x000E, CMN_SD_CAL_REFTIM_START},
+	{0x012B, CMN_SD_CAL_PLLCNT_START},
+	{0x0509, CMN_PDIAG_PLL0_CP_PADJ_M0},
+	{0x0F00, CMN_PDIAG_PLL0_CP_IADJ_M0},
+	{0x0F08, CMN_PDIAG_PLL0_FILT_PADJ_M0},
+	{0x0004, CMN_PLL0_DSM_DIAG_M0},
+	{0x0509, CMN_PDIAG_PLL1_CP_PADJ_M0},
+	{0x0F00, CMN_PDIAG_PLL1_CP_IADJ_M0},
+	{0x0F08, CMN_PDIAG_PLL1_FILT_PADJ_M0},
+	{0x0004, CMN_PLL1_DSM_DIAG_M0},
+	{0x00FA, CMN_PLL0_VCOCAL_INIT_TMR},
+	{0x0004, CMN_PLL0_VCOCAL_ITER_TMR},
+	{0x00FA, CMN_PLL1_VCOCAL_INIT_TMR},
+	{0x0004, CMN_PLL1_VCOCAL_ITER_TMR},
+	{0x0317, CMN_PLL0_VCOCAL_REFTIM_START},
+	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
+	{0x0317, CMN_PLL1_VCOCAL_REFTIM_START},
+	{0x0003, CMN_PLL1_VCOCAL_TCTRL}
+};
+
+static struct cdns_reg_pairs sl_dp_25_no_ssc_tx_ln_regs[] = {
+	{0x09C4, TX_RCVDET_ST_TMR},
+	{0x00FB, TX_PSC_A0},
+	{0x04AA, TX_PSC_A2},
+	{0x04AA, TX_PSC_A3},
+	{0x000F, XCVR_DIAG_BIDI_CTRL}
+};
+
+static struct cdns_reg_pairs sl_dp_25_no_ssc_rx_ln_regs[] = {
+	{0x0000, RX_PSC_A0},
+	{0x0000, RX_PSC_A2},
+	{0x0000, RX_PSC_A3},
+	{0x0000, RX_PSC_CAL},
+	{0x0000, RX_REE_GCSM1_CTRL},
+	{0x0000, RX_REE_GCSM2_CTRL},
+	{0x0000, RX_REE_PERGCSM_CTRL}
+};
+
+static struct cdns_torrent_vals sl_dp_25_no_ssc_cmn_vals = {
+	.reg_pairs = sl_dp_25_no_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(sl_dp_25_no_ssc_cmn_regs),
+};
+
+static struct cdns_torrent_vals sl_dp_25_no_ssc_tx_ln_vals = {
+	.reg_pairs = sl_dp_25_no_ssc_tx_ln_regs,
+	.num_regs = ARRAY_SIZE(sl_dp_25_no_ssc_tx_ln_regs),
+};
+
+static struct cdns_torrent_vals sl_dp_25_no_ssc_rx_ln_vals = {
+	.reg_pairs = sl_dp_25_no_ssc_rx_ln_regs,
+	.num_regs = ARRAY_SIZE(sl_dp_25_no_ssc_rx_ln_regs),
+};
+
 /* USB and SGMII/QSGMII link configuration */
 static struct cdns_reg_pairs usb_sgmii_link_cmn_regs[] = {
 	{0x0002, PHY_PLL_CFG},
@@ -3307,6 +3249,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 	.block_offset_shift = 0x2,
 	.reg_offset_shift = 0x2,
 	.link_cmn_vals = {
+		[TYPE_DP] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_dp_link_cmn_vals,
+			},
+		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
 				[NO_SSC] = NULL,
@@ -3383,6 +3330,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 		},
 	},
 	.xcvr_diag_vals = {
+		[TYPE_DP] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_dp_xcvr_diag_ln_vals,
+			},
+		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
 				[NO_SSC] = NULL,
@@ -3483,6 +3435,20 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 		},
 	},
 	.cmn_vals = {
+		[CLK_19_2_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_19_2_no_ssc_cmn_vals,
+				},
+			},
+		},
+		[CLK_25_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_25_no_ssc_cmn_vals,
+				},
+			},
+		},
 		[CLK_100_MHZ] = {
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -3561,6 +3527,20 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 		},
 	},
 	.tx_ln_vals = {
+		[CLK_19_2_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_19_2_no_ssc_tx_ln_vals,
+				},
+			},
+		},
+		[CLK_25_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_25_no_ssc_tx_ln_vals,
+				},
+			},
+		},
 		[CLK_100_MHZ] = {
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -3639,6 +3619,20 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 		},
 	},
 	.rx_ln_vals = {
+		[CLK_19_2_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_19_2_no_ssc_rx_ln_vals,
+				},
+			},
+		},
+		[CLK_25_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_25_no_ssc_rx_ln_vals,
+				},
+			},
+		},
 		[CLK_100_MHZ] = {
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -3722,6 +3716,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 	.block_offset_shift = 0x0,
 	.reg_offset_shift = 0x1,
 	.link_cmn_vals = {
+		[TYPE_DP] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_dp_link_cmn_vals,
+			},
+		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
 				[NO_SSC] = NULL,
@@ -3798,6 +3797,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 		},
 	},
 	.xcvr_diag_vals = {
+		[TYPE_DP] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_dp_xcvr_diag_ln_vals,
+			},
+		},
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
 				[NO_SSC] = NULL,
@@ -3898,6 +3902,20 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 		},
 	},
 	.cmn_vals = {
+		[CLK_19_2_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_19_2_no_ssc_cmn_vals,
+				},
+			},
+		},
+		[CLK_25_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_25_no_ssc_cmn_vals,
+				},
+			},
+		},
 		[CLK_100_MHZ] = {
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -3976,6 +3994,20 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 		},
 	},
 	.tx_ln_vals = {
+		[CLK_19_2_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_19_2_no_ssc_tx_ln_vals,
+				},
+			},
+		},
+		[CLK_25_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_25_no_ssc_tx_ln_vals,
+				},
+			},
+		},
 		[CLK_100_MHZ] = {
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
@@ -4054,6 +4086,20 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 		},
 	},
 	.rx_ln_vals = {
+		[CLK_19_2_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_19_2_no_ssc_rx_ln_vals,
+				},
+			},
+		},
+		[CLK_25_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_25_no_ssc_rx_ln_vals,
+				},
+			},
+		},
 		[CLK_100_MHZ] = {
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
-- 
2.26.1

