Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636323594B3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233412AbhDIFfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:35:46 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:16394 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233325AbhDIFfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:35:04 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1395XZbW028240;
        Thu, 8 Apr 2021 22:34:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=EYEdtQSSOhTkRWWy/nC0NqFCu6RO9SArgFzaYLFnEuo=;
 b=Pik4H4ULCL0pBPlxgUmEE2jLra62+Li9/lLzIxVjZnICCYYkye5+GvsE/o3d24WB50aR
 lKxFp9ccDNEC7IBlwEoR+jok6VgzkoSShFL5/VjsT2u4asy3Nx8ubuaa7eqXyL/w3/Mp
 IDAg302WIboTjBtUlXj9epmqNSTvOTXJB6FYxnc4oTR5EcHQb+cYM98BasqMESY9BrTx
 3Nxds5W9w9gruLOnIgOxQkOKc9JaKvnnmgfQG+5Nj9JDOucoJ8hj35yNVZ+MhW1o4dld
 GYeBNQrqPGGTzwFGj5IWPwzaylXz/tOZhv7kLZv2Cu3fIcfwhhI5M6Rilweaim7Eox+4 5A== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by mx0a-0014ca01.pphosted.com with ESMTP id 37t6ns1srg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 22:34:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IT7HuAGqz+az455wqCRZF1JhmK8zUUBzmPg4jRhZ8dpSd2I9vmnWf4wWUfyo1P6Osculti+YTEuv1GwHDIKohpeW0Xw5HDA61kioDEkvN1dHut8TIIpUy1GZX4gUL5RqMPjJKdoOcSz0QYYalFHhR1ebZyb6mlmdoZF/JtCUwtUw1EaXwKkDxPj9se35E3dXpk3s2/UjdRRsai2T3kdEApsswd7IDSkqPrf2saWDgVcAHPebFYTObbytWfHvd1yGieUM1vlF4sCaWovAQ/ON23LCGszGHB0aONovuhsyHIva64nNRJ4IeV4XJ/FlcA7RNoAaOu6JYev8yd7Nj1kIWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYEdtQSSOhTkRWWy/nC0NqFCu6RO9SArgFzaYLFnEuo=;
 b=PQ7mxRG+Pg9XhoOqdTGEs9CA/DBuSi9avTAHuc51DVG6gCI2HVBM5pnVvu7VzEjB1kxVCPbl4ePIQM958cDKUplDvS8nMbm5Y4rWFc89WiDnqyZHLVWaFkAZXdNkn/DeRW/yByZKebCMG1+R5VGoNVBKxnfHvP3l10QhkD/pKxRYa1nKuwTQabIXQweDp7bMsrXZaTfhJbUGe36qYZ9UeBFaARw/IqQrUpXk7ekp3uzDABFvL/sFU2WTExK66qmSVQYJW786EyGg3hWIGPmwkSqH84BNH+eGqx8TrDAJIzfIBr72d4GFlx6x4w/KUEpdZOKtPD+elFXZckaTW+bysA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYEdtQSSOhTkRWWy/nC0NqFCu6RO9SArgFzaYLFnEuo=;
 b=0Pai6Bmy7MjoQ5IpgnlfytK7O+u1IW8M+3yzle308Uu/AftRhGP5FIA2S2iBw8zz0sMcUJwoyxWA3/05TpVeSFsFrIBhD7vf/FzQgx1dAi5xqECmVdx+Pp2snkiQE45narwfSrdOCirBmBRtn1H3uCn0jBI59HVvaLXFPiLICnI=
Received: from MWHPR2001CA0012.namprd20.prod.outlook.com
 (2603:10b6:301:15::22) by PH0PR07MB8671.namprd07.prod.outlook.com
 (2603:10b6:510:85::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 9 Apr
 2021 05:34:27 +0000
Received: from MW2NAM12FT032.eop-nam12.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::c3) by MWHPR2001CA0012.outlook.office365.com
 (2603:10b6:301:15::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Fri, 9 Apr 2021 05:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT032.mail.protection.outlook.com (10.13.180.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.6 via Frontend Transport; Fri, 9 Apr 2021 05:34:26 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YJ5Z032749
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 22:34:25 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Apr 2021 07:34:19 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 9 Apr 2021 07:34:19 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YJpR027856;
        Fri, 9 Apr 2021 07:34:19 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1395YJ6L027855;
        Fri, 9 Apr 2021 07:34:19 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 07/14] phy: cadence-torrent: Reorder functions to avoid function declarations
Date:   Fri, 9 Apr 2021 07:34:09 +0200
Message-ID: <1617946456-27773-8-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
References: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49845a36-4c44-4be2-5956-08d8fb192402
X-MS-TrafficTypeDiagnostic: PH0PR07MB8671:
X-Microsoft-Antispam-PRVS: <PH0PR07MB8671EC76AEA630B261446D28C5739@PH0PR07MB8671.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELABjbBoKS3kKPvZhE6oeaL9Cn/hRqKDyeRuL5LGSfw69VGZqRRtGrNHNqdlNWzMnotgjadW0HrCa234MumDvDlQ4omkqLeM15Wns93U0IKVh7Ci4ga8nm6u0FLPdgsc7sDJstDDhULezoPpgHD+M7dUWoyl8K+2burDvdy9YUZo+UtIggSDZGMSaIszGplJkbKgirS2Vo/QA0cJZFFkjHsQssCrP2Zsig3fwa0U77es5j8DLfMnDB7p/owt3AWiWlp/7Lzt9aZh7CxYNidpFNeUCuw3wk5brc3d3XzVtXkLIiyyRziy4y2qdnP/Pma3kmmnXoBYQkEBGfKXU5rPA8GV/rmKnAhzHq/Nx1oDzMxHnGtmJzNqxmc/yeA6Yd/Ho10az2TCAzC77VAv8koXHh5Sy9xl9HnKnO6uSYiCqiCZobUcPxEgonLactDCvKNyX645FVI1dflCsHgrN0K8gx3r1nAcprjhfBNDT7IeDRGxhu3JoxzruGfyyhxxYwdbvkj6fdz3N25AiTuRAntiVoa01hIuQrDwV2U/vJj6Wg/DPP9Sv6da94PvaotNuSn3AqcI7Z9rIQSA1vtytdiWMYAUuVe1mkAOOM2pxtl+ouoI457tJur/G4/ftxbf9FdvigkV33eM9XNLCedW2Rjmyd4WC1kMy+aOL+SNw7rvqHVuyxjIXhcRSqhm+v/DLdON4T0a+iFaQLpB4BYIYZEsBg==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(36092001)(36840700001)(46966006)(186003)(86362001)(82310400003)(47076005)(70586007)(478600001)(336012)(7636003)(70206006)(36756003)(2906002)(356005)(83380400001)(30864003)(82740400003)(6666004)(8936002)(36906005)(42186006)(2616005)(426003)(316002)(26005)(8676002)(4326008)(36860700001)(54906003)(110136005)(5660300002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 05:34:26.9043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49845a36-4c44-4be2-5956-08d8fb192402
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT032.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR07MB8671
X-Proofpoint-ORIG-GUID: J10QB1VHCfoyR4wfNa8RHj-YuwUs661k
X-Proofpoint-GUID: J10QB1VHCfoyR4wfNa8RHj-YuwUs661k
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_03:2021-04-08,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=942 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090041
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder some functions to avoid function declarations.
No functional change.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 250 +++++++++++-----------
 1 file changed, 123 insertions(+), 127 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 396c3810a69d..a6331927d775 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -341,10 +341,6 @@ struct cdns_torrent_derived_refclk {
 #define to_cdns_torrent_derived_refclk(_hw)	\
 			container_of(_hw, struct cdns_torrent_derived_refclk, hw)
 
-static
-void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy,
-					   u32 rate, bool ssc);
-
 struct cdns_reg_pairs {
 	u32 val;
 	u32 off;
@@ -697,6 +693,129 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
 	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_START, 0x0099);
 }
 
+/*
+ * Set registers responsible for enabling and configuring SSC, with second
+ * register value provided by a parameter.
+ */
+static void cdns_torrent_dp_enable_ssc_25mhz(struct cdns_torrent_phy *cdns_phy,
+					     u32 ctrl2_val)
+{
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
+
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x0001);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, ctrl2_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x007F);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL4_M0, 0x0003);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x0001);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, ctrl2_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x007F);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL4_M0, 0x0003);
+}
+
+static
+void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy,
+					   u32 rate, bool ssc)
+{
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
+
+	/* Assumes 25 MHz refclock */
+	switch (rate) {
+	/* Setting VCO for 10.8GHz */
+	case 2700:
+	case 5400:
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x01B0);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0120);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x01B0);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0120);
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x0423);
+		break;
+	/* Setting VCO for 9.72GHz */
+	case 1620:
+	case 2430:
+	case 3240:
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0184);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0xCCCD);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0104);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0184);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0xCCCD);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0104);
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x03B9);
+		break;
+	/* Setting VCO for 8.64GHz */
+	case 2160:
+	case 4320:
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0159);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x999A);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x00E7);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0159);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x999A);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x00E7);
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x034F);
+		break;
+	/* Setting VCO for 8.1GHz */
+	case 8100:
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0144);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x00D8);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0144);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x00D8);
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x031A);
+		break;
+	}
+
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+
+	if (ssc) {
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x0315);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0005);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x0315);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0005);
+	} else {
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x0317);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x0317);
+		/* Set reset register values to disable SSC */
+		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL2_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL3_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL4_M0, 0x0000);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0003);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL2_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL3_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL4_M0, 0x0000);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0003);
+	}
+
+	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_REFCNT_START, 0x00C7);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_PLLCNT_START, 0x00C7);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_REFCNT_START, 0x00C7);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_START, 0x00C7);
+}
+
 /*
  * Enable or disable PLL for selected lanes.
  */
@@ -1329,129 +1448,6 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	return ret;
 }
 
-/*
- * Set registers responsible for enabling and configuring SSC, with second
- * register value provided by a parameter.
- */
-static void cdns_torrent_dp_enable_ssc_25mhz(struct cdns_torrent_phy *cdns_phy,
-					     u32 ctrl2_val)
-{
-	struct regmap *regmap = cdns_phy->regmap_common_cdb;
-
-	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x0001);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, ctrl2_val);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x007F);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL4_M0, 0x0003);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x0001);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, ctrl2_val);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x007F);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL4_M0, 0x0003);
-}
-
-static
-void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy,
-					   u32 rate, bool ssc)
-{
-	struct regmap *regmap = cdns_phy->regmap_common_cdb;
-
-	/* Assumes 25 MHz refclock */
-	switch (rate) {
-	/* Setting VCO for 10.8GHz */
-	case 2700:
-	case 5400:
-		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x01B0);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0120);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x01B0);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0120);
-		if (ssc)
-			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x0423);
-		break;
-	/* Setting VCO for 9.72GHz */
-	case 1620:
-	case 2430:
-	case 3240:
-		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0184);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0xCCCD);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0104);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0184);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0xCCCD);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0104);
-		if (ssc)
-			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x03B9);
-		break;
-	/* Setting VCO for 8.64GHz */
-	case 2160:
-	case 4320:
-		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0159);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x999A);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x00E7);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0159);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x999A);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x00E7);
-		if (ssc)
-			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x034F);
-		break;
-	/* Setting VCO for 8.1GHz */
-	case 8100:
-		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0144);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x00D8);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0144);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x00D8);
-		if (ssc)
-			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x031A);
-		break;
-	}
-
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
-
-	if (ssc) {
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x0315);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0005);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x0315);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0005);
-	} else {
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x0317);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x0317);
-		/* Set reset register values to disable SSC */
-		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL2_M0, 0x0000);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL3_M0, 0x0000);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL4_M0, 0x0000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0003);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL2_M0, 0x0000);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL3_M0, 0x0000);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL4_M0, 0x0000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0003);
-	}
-
-	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_REFCNT_START, 0x00C7);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_PLLCNT_START, 0x00C7);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_REFCNT_START, 0x00C7);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_START, 0x00C7);
-}
-
 static int cdns_torrent_derived_refclk_enable(struct clk_hw *hw)
 {
 	struct cdns_torrent_derived_refclk *derived_refclk = to_cdns_torrent_derived_refclk(hw);
-- 
2.26.1

