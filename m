Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B6332CC79
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 07:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbhCDGLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 01:11:13 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:29032 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234724AbhCDGK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 01:10:59 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1245tlu4026179;
        Wed, 3 Mar 2021 22:08:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=H/HYDqvp99xauiCPwtqUeDogM5vAS8KWumCbXfeKsAA=;
 b=Xk20vxlnFqNmnrD3OfZQwlVdNRwzOAA5oqysPpoqqfpev0g6sP3SyESOcyP/Cq+/Skdr
 E2WuuL+Nd4HCCpLd/0YVy0nsZncF7Jcw2viLNIuj/Kges9wYFyWft1WMfSJl7HjSynCY
 Mqt1nDWvOTAIlTL2dF037JnC4oD7De/B5cZKDv31R+pWta9SG+j28BXTjX2UKiP6WPfG
 oz2FZhefrDvETJeF+OR6Zw85mdaPz7xgBAgWO3jz1yZ1ATFOwc7DofBVDSv3g9R5NYZ4
 6MQpd0jThAQWbrEz9cLgnug0ZcaASn47fWVKTxvaWD3Ls7vS7wIZQI5Jrsx4QsdrTRMs fg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0b-0014ca01.pphosted.com with ESMTP id 36yjj2r9es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 22:08:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOlpah9SVDRTnl1v+xIoWqCh7bRd7kvWIGxUPDlhRzyG6IeNY9Ofy3r7ckWOoXEwRuOvdXUqa0iz57rxofn3FGyKe6ae9lcDz+uLejY6p0e+HPsmDvV7WWvq7MitcdeqhGNbWpzhcTNPN23cF8YCD7htVhfSNcaExnvc2Ulc1nvgZvw6BsHHGVUJ9A3aR5vencCOg0hjiaXZJEnTwoa5H9zR9R8dPgeWP8iIw+t1NiNAIVDDjGflsr5KcHgo7BCo+cLVVCrEp1m7Pwqx91FjrOYSSswLViRkNuuuDM0tooP/dggHB/8/G3bipby/agBfKBOuh2YCxawaYmObIpfcaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/HYDqvp99xauiCPwtqUeDogM5vAS8KWumCbXfeKsAA=;
 b=km89+tcqGrbxFKVuYQZ1Qe2PnAp2Cb6IxnddJHOGno9qrE1Twf/W9hhfODkwX2EtxFJQgjHf8aU6ZmCgwXL14JYYWYy0848paJ+SgV9cpHGrN+adcg3bi0hAiev2Gy5qOAkpPLwhX7MOSjs2afBITCDddoQ+cRO3/YV50Q/WlUrGzSPkn+imDbA7A7RPlgMPbSMK99zW6shgZeCSM7/TEHZCblHgIh2KdTckDrMP0pR+WgQnJfWK/QqPfGRTRbjKo/VGRSTRgIiGC98tE2l0yTPMg23I8eTXD4yuXcspcSYO0MGBEp35ZWuSaCS18y4sZ6ktxuskMhmrpBtNzO2Yag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=cadence.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/HYDqvp99xauiCPwtqUeDogM5vAS8KWumCbXfeKsAA=;
 b=R+HmPAVfBPQU42KJp9cKrXQ/nRncTBK12TqFOJ4mK+CIeQmzZeEqKOkNyuTpUI2oObMBnr0c93VmuTSlBdvnSPJdMyYNMKYH4vvgibnicNl19+LWcyzpuWuiRuWqjWmt/406nXSDW6uijT+/6vB1IHAFZ4WNR4nVXGFVz87+s74=
Received: from DS7PR03CA0276.namprd03.prod.outlook.com (2603:10b6:5:3ad::11)
 by MW2PR07MB3995.namprd07.prod.outlook.com (2603:10b6:907:a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Thu, 4 Mar
 2021 06:08:27 +0000
Received: from DM6NAM12FT017.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::32) by DS7PR03CA0276.outlook.office365.com
 (2603:10b6:5:3ad::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 4 Mar 2021 06:08:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT017.mail.protection.outlook.com (10.13.178.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.9 via Frontend Transport; Thu, 4 Mar 2021 06:08:24 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 12468Jjp067409
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
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 12468ItP032349;
        Thu, 4 Mar 2021 07:08:18 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 12468IMM032348;
        Thu, 4 Mar 2021 07:08:18 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <nsekhar@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH 2/4] phy: ti: j721e-wiz: Add support for configuring QSGMII
Date:   Thu, 4 Mar 2021 07:08:14 +0100
Message-ID: <1614838096-32291-3-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1614838096-32291-1-git-send-email-sjakhade@cadence.com>
References: <1614838096-32291-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30dc8735-089f-42a0-aa07-08d8ded3ebeb
X-MS-TrafficTypeDiagnostic: MW2PR07MB3995:
X-Microsoft-Antispam-PRVS: <MW2PR07MB399595E14A8C95E73824DF18C5979@MW2PR07MB3995.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPaFs/63tS4kHBZ+HnImnl3gSgI36vtC0fmH+UZzIxg0aV2/1fRRgdFew1uTMOJnRRUsNxn/DHCB6wkJx1hrGYb1CBj3+nESSGNbpZky9heSDiP6u7dHnTmMuXbayJCUZQjd3LpuIaMg4V9R8NPTtkqa//jsVAK1EOIU3vEKtXUt3WlbgTISw+SeqAuGXWD9fQKNZo8e/o1Ds7Si7qhqY/cn6C/yYU7lE5iumdjdHit9EwYThfQvQw9O4MEpHBbmSShhBPru831KeF2zRUiK5636sJGIHp7/vCCJVreSqpB4C1Lqa1oWj+lOkvnOBT47ly0GqrSivveWhZc2pcNMyleeMmQAIipynnOBhEfvROwDhXbyz+k9VdjEfrl3kUkVtxJWdt34eWQOKC7GDUYNbKF6Pjiz1/xGoh4qHXpGKFG0rqgsdZ5s77NUWReiUtfO65UIGu2wNxvZtQDWB8aLX+Tcwoe5yeaqZonTjcZxYxui3TXMgNUMju+GIjTZmxnMDg5Qk1NYkGUco5PqItCRSPAlcKE3qgHCIOLqGLbZ7l4lIvUP4ABi2apyEXgr0BHW6/VlzzyiF5mmXeAtqmf3seoAzXjJ2Wz1oZKLmnk9KtJtPbhHOX4SUVWzmUaLeDaqrqPgubC7QgZ6PejzZh6Rk4E2C7WYygRJpWhmLh2Seea0TkSN+oTddh8vCYVPaT5ifgxaIQ7Y23VYBeCj/fnFGA==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(36092001)(46966006)(36840700001)(478600001)(316002)(70586007)(70206006)(81166007)(36906005)(4326008)(6666004)(8676002)(8936002)(356005)(186003)(54906003)(42186006)(36756003)(336012)(26005)(5660300002)(2616005)(110136005)(82740400003)(426003)(83380400001)(86362001)(47076005)(82310400003)(36860700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 06:08:24.9351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30dc8735-089f-42a0-aa07-08d8ded3ebeb
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT017.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB3995
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_01:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103040025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

Configure MAC clock dividers required for QSGMII to be functional.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 64 ++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 03896240a5d5..995c7dbec77b 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -27,6 +27,7 @@
 #define WIZ_SERDES_RST		0x40c
 #define WIZ_SERDES_TYPEC	0x410
 #define WIZ_LANECTL(n)		(0x480 + (0x40 * (n)))
+#define WIZ_LANEDIV(n)		(0x484 + (0x40 * (n)))
 
 #define WIZ_MAX_INPUT_CLOCKS	4
 /* To include mux clocks, divider clocks and gate clocks */
@@ -127,6 +128,20 @@ static const struct reg_field p0_fullrt_div[WIZ_MAX_LANES] = {
 	REG_FIELD(WIZ_LANECTL(3), 22, 23),
 };
 
+static const struct reg_field p_mac_div_sel0[WIZ_MAX_LANES] = {
+	REG_FIELD(WIZ_LANEDIV(0), 16, 22),
+	REG_FIELD(WIZ_LANEDIV(1), 16, 22),
+	REG_FIELD(WIZ_LANEDIV(2), 16, 22),
+	REG_FIELD(WIZ_LANEDIV(3), 16, 22),
+};
+
+static const struct reg_field p_mac_div_sel1[WIZ_MAX_LANES] = {
+	REG_FIELD(WIZ_LANEDIV(0), 0, 8),
+	REG_FIELD(WIZ_LANEDIV(1), 0, 8),
+	REG_FIELD(WIZ_LANEDIV(2), 0, 8),
+	REG_FIELD(WIZ_LANEDIV(3), 0, 8),
+};
+
 static const struct reg_field typec_ln10_swap =
 					REG_FIELD(WIZ_SERDES_TYPEC, 30, 30);
 
@@ -252,6 +267,8 @@ struct wiz {
 	struct regmap_field	*p_align[WIZ_MAX_LANES];
 	struct regmap_field	*p_raw_auto_start[WIZ_MAX_LANES];
 	struct regmap_field	*p_standard_mode[WIZ_MAX_LANES];
+	struct regmap_field	*p_mac_div_sel0[WIZ_MAX_LANES];
+	struct regmap_field	*p_mac_div_sel1[WIZ_MAX_LANES];
 	struct regmap_field	*p0_fullrt_div[WIZ_MAX_LANES];
 	struct regmap_field	*pma_cmn_refclk_int_mode;
 	struct regmap_field	*pma_cmn_refclk_mode;
@@ -290,6 +307,27 @@ static int wiz_reset(struct wiz *wiz)
 	return 0;
 }
 
+static int wiz_p_mac_div_sel(struct wiz *wiz)
+{
+	u32 num_lanes = wiz->num_lanes;
+	int ret;
+	int i;
+
+	for (i = 0; i < num_lanes; i++) {
+		if (wiz->lane_phy_type[i] == PHY_TYPE_QSGMII) {
+			ret = regmap_field_write(wiz->p_mac_div_sel0[i], 1);
+			if (ret)
+				return ret;
+
+			ret = regmap_field_write(wiz->p_mac_div_sel1[i], 2);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int wiz_mode_select(struct wiz *wiz)
 {
 	u32 num_lanes = wiz->num_lanes;
@@ -300,8 +338,8 @@ static int wiz_mode_select(struct wiz *wiz)
 	for (i = 0; i < num_lanes; i++) {
 		if (wiz->lane_phy_type[i] == PHY_TYPE_DP)
 			mode = LANE_MODE_GEN1;
-		else
-			mode = LANE_MODE_GEN4;
+		else if (wiz->lane_phy_type[i] == PHY_TYPE_QSGMII)
+			mode = LANE_MODE_GEN2;
 
 		ret = regmap_field_write(wiz->p_standard_mode[i], mode);
 		if (ret)
@@ -347,6 +385,12 @@ static int wiz_init(struct wiz *wiz)
 		return ret;
 	}
 
+	ret = wiz_p_mac_div_sel(wiz);
+	if (ret) {
+		dev_err(dev, "Configuring P0 MAC DIV SEL failed\n");
+		return ret;
+	}
+
 	ret = wiz_init_raw_interface(wiz, true);
 	if (ret) {
 		dev_err(dev, "WIZ interface initialization failed\n");
@@ -471,6 +515,22 @@ static int wiz_regfield_init(struct wiz *wiz)
 			dev_err(dev, "P%d_FULLRT_DIV reg field init failed\n", i);
 			return PTR_ERR(wiz->p0_fullrt_div[i]);
 		}
+
+		wiz->p_mac_div_sel0[i] =
+		  devm_regmap_field_alloc(dev, regmap, p_mac_div_sel0[i]);
+		if (IS_ERR(wiz->p_mac_div_sel0[i])) {
+			dev_err(dev, "P%d_MAC_DIV_SEL0 reg field init fail\n",
+				i);
+			return PTR_ERR(wiz->p_mac_div_sel0[i]);
+		}
+
+		wiz->p_mac_div_sel1[i] =
+		  devm_regmap_field_alloc(dev, regmap, p_mac_div_sel1[i]);
+		if (IS_ERR(wiz->p_mac_div_sel1[i])) {
+			dev_err(dev, "P%d_MAC_DIV_SEL1 reg field init fail\n",
+				i);
+			return PTR_ERR(wiz->p_mac_div_sel1[i]);
+		}
 	}
 
 	wiz->typec_ln10_swap = devm_regmap_field_alloc(dev, regmap,
-- 
2.26.1

