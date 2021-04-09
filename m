Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A696A3594B7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhDIFfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:35:53 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:33790 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233352AbhDIFfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:35:13 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1395PpuU030900;
        Thu, 8 Apr 2021 22:34:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=rsmXs24XN44+1+w+pHIrAns443BOJvgXs4b+LFOrXDI=;
 b=TNfeBTn1J301rcAwrsDwc5sUSotwDo3TzU5EuZ9jBldPaUeS6OTk3n02KkNq7Y4waJis
 nVQAInfO+tnw3vqQEyJ0XevHnUE1BD8uEE20QIedde4rMizpgJJxDPVo4sgIIPxaLP0u
 r2xy8hJu0uLL2ONaWe9dJk9BpK8nKJbHnqbb4y45Wdi4HoLCzf1dGgH93q3rbAMSySII
 mMwRJkFUUoNikVuWjhFAm1TgyefkIHDZUzxgwpoMFk2NG/pethV2q9rMEjlk2FcKjyKP
 zHfEc4fCC6PO1lR7nfK/ZZE4zipghsr5JArFPLXmiOQpyn54BvhAhZFimUizucVaKkbW 4g== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0b-0014ca01.pphosted.com with ESMTP id 37rvb4tthp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 22:34:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUqNurVXFsoI9Pi6LsXONkLjeaJ25dFBtD6Ir+8BpzRvZYmX/QE5CenDFmrr4k3pLhAOe2RFa09kotoaGLWiunT02XDrQT55HlmP6bRbV4I/WxaQ8t4RYYLZCEhpn0NO03K0NhK+K5jj6UiE+LpflyuXKN15sE1XKhLo3aHsBgXl0uVExXCJznO7R+Z2n4dZoMCbTonE3s5raeoeQULqpmajkTfea2R1wO6yWikt4Aqypq9VBk+rfZm7AtS5Z5ACqPdN0olcBI1QUq2XSoeIBM4xyDfwKHgankdw9FXBAV0OVpLZeNZp9aHhv8Hgw2surJMe7BY8ACCh54Z5YjfYWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsmXs24XN44+1+w+pHIrAns443BOJvgXs4b+LFOrXDI=;
 b=ENHOSsZHcEJLP1/lhn/YRtPbcTyqEoAvF1CfYWA07+gtGHpeniXMgpXY1A8F7dhst05P4O4FzFm/QNb5l0c9KNYnEnXOeLQ8Ogm+BjkAIViw95XZPztPr8slBf5APAd6ZGDMGyJmEgAp+gisWazpRt6uP019ofNhJZ31Lbb/ij8PhfD/T8taVUHYi0hTfqKa3qI9rrrb2baThojsdTtF/B6eGaOettredy7Ti13RzTw19FdTFsm4iKAGWqcL5J6R/yk9Dn0yIK77KLSVpYiN4VI8Ze6kBk3bjYmDhvDwkvLeW/Tb4Xb5nhSiugS8z6OZuXBLmy60I9sr4L2/cIVuNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsmXs24XN44+1+w+pHIrAns443BOJvgXs4b+LFOrXDI=;
 b=cPpTe4ZTWw7gR0Tk9jkzPoIFbnMoWYyNjHKmTUqHViQoMYtUjW25cK+08xKTFYtx/3yrWG8CBFSDnIJUOytrp+ijq8DdtL14pJ3t9p8XAdMNUMz8/6dXsCNTDOvVC8ywgo7AdNuoXz5DuhxXvvI4gWet26dy7RkdAETBpaN3+p4=
Received: from MWHPR13CA0012.namprd13.prod.outlook.com (2603:10b6:300:16::22)
 by DM6PR07MB7851.namprd07.prod.outlook.com (2603:10b6:5:36::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 9 Apr
 2021 05:34:26 +0000
Received: from MW2NAM12FT009.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::78) by MWHPR13CA0012.outlook.office365.com
 (2603:10b6:300:16::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend
 Transport; Fri, 9 Apr 2021 05:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT009.mail.protection.outlook.com (10.13.180.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.6 via Frontend Transport; Fri, 9 Apr 2021 05:34:25 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YJ5W032749
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 22:34:24 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Apr 2021 07:34:19 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 9 Apr 2021 07:34:19 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YI6e027848;
        Fri, 9 Apr 2021 07:34:18 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1395YIDL027847;
        Fri, 9 Apr 2021 07:34:18 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 05/14] phy: cadence-torrent: Add PHY registers for DP in array format
Date:   Fri, 9 Apr 2021 07:34:07 +0200
Message-ID: <1617946456-27773-6-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
References: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 460bbf3b-539d-4636-d4dd-08d8fb1922ec
X-MS-TrafficTypeDiagnostic: DM6PR07MB7851:
X-Microsoft-Antispam-PRVS: <DM6PR07MB7851ABA69BDF55FF3D7DE1EAC5739@DM6PR07MB7851.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AaOtbXHqg+UH4vLZoo8pJb9wAe92vaJRL9TIIlC9yXlqajzOvwwu3Bregql+ytRpZU0vhl4CyJjENuVtX5oD01fFhAFCJlPSwCy8bHx4hv050u/6+HsjaLCBykOHCbTFTG9El+FM6mdxXzxlXrSbBlm9+zLPPMoiM8IWAhSqo4o+t708sqeAJz5LHQ9as7qP2k/KXjGB6jhTagFnpxD8NbxpmUo7X5BmPCsYZIIDC81MX2d/4PV8LRZBKNCV23/nQneVt7lfM2fy7/Yp7goRlCGyX4U9vNySLdxkE4+uaavx/QGkd6ieecBb8QIsI7nzjMuAcxUxUXVWkWAxp/q02Kt6j43MrQnGSjNbx3DsEYdL6iXTYS4y43yfMFgCmXZH7uT9y17nFsSyiEZssD/QkvqWQt+Rc/KzCwp7DTdI/KE8fqW9uyYTcYOa+nG+Grc4jy3ieROcsEIqFxUcGcqc1rH9f7hSOuco4oYxKImY85YoUC15pgSDC44NsZLd8KfWIKtOR2q2FQ02c8yOqDtgq/tZXgFxktVfJTGlhwvsA/jPhHxdbNWX4H9+9RvPAr4bLfPwjemD/RJSuqBkzvKjUq7OT5S8+bbhOUxTS/LZwTitWHts1/BGJRRQqlsnAecRBfVgOMNt82jzdN51zqDrHZiyB3yncPKhdIwGwRycRCdwJNdgdnWeHq+abnMuNtTx5cIAsddZGl3E2uBFalu1MQ==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(36092001)(36840700001)(46966006)(336012)(426003)(83380400001)(30864003)(6666004)(8936002)(42186006)(110136005)(54906003)(36906005)(36756003)(7636003)(2616005)(8676002)(186003)(356005)(478600001)(5660300002)(82310400003)(47076005)(316002)(70586007)(2906002)(4326008)(70206006)(36860700001)(26005)(86362001)(82740400003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 05:34:25.0826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 460bbf3b-539d-4636-d4dd-08d8fb1922ec
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT009.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7851
X-Proofpoint-ORIG-GUID: pj4AABapafaVjgXE8R-OlKIIC4vje_bL
X-Proofpoint-GUID: pj4AABapafaVjgXE8R-OlKIIC4vje_bL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_03:2021-04-08,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104090040
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PHY registers for single link DP in array format to simplify
code and to improve readability.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 450 +++++++++++++---------
 1 file changed, 274 insertions(+), 176 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 39a26a1a4c51..4ec5909f192c 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -341,20 +341,12 @@ struct cdns_torrent_derived_refclk {
 #define to_cdns_torrent_derived_refclk(_hw)	\
 			container_of(_hw, struct cdns_torrent_derived_refclk, hw)
 
-static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy,
-				    struct cdns_torrent_inst *inst);
-static
-void cdns_torrent_dp_pma_cmn_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy);
 static
 void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
 					     u32 rate, bool ssc);
 static
-void cdns_torrent_dp_pma_cmn_cfg_25mhz(struct cdns_torrent_phy *cdns_phy);
-static
 void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy,
 					   u32 rate, bool ssc);
-static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
-					 unsigned int lane);
 
 struct cdns_reg_pairs {
 	u32 val;
@@ -759,9 +751,6 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
 	unsigned int hsclk_div_val = 0;
 	unsigned int i;
 
-	/* 16'h0000 for single DP link configuration */
-	regmap_field_write(cdns_phy->phy_pll_cfg, 0x0);
-
 	switch (rate) {
 	case 1620:
 		clk_sel_val = 0x0f01;
@@ -806,8 +795,7 @@ static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
 static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
 					  struct phy_configure_opts_dp *dp)
 {
-	u32 ret;
-	u32 read_val;
+	u32 read_val, ret;
 
 	/* Disable the cmn_pll0_en before re-programming the new data rate. */
 	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, 0x0);
@@ -825,17 +813,12 @@ static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
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
@@ -1184,9 +1167,6 @@ static int cdns_torrent_dp_init(struct phy *phy)
 
 	cdns_torrent_dp_write(regmap, PHY_AUX_CTRL, 0x0003); /* enable AUX */
 
-	/* PHY PMA registers configuration function */
-	cdns_torrent_dp_pma_cfg(cdns_phy, inst);
-
 	/*
 	 * Set lines power state to A0
 	 * Set lines pll clk enable to 0
@@ -1231,67 +1211,6 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	return ret;
 }
 
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
@@ -1473,50 +1392,6 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
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
@@ -1640,49 +1515,6 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy,
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
 static int cdns_torrent_derived_refclk_enable(struct clk_hw *hw)
 {
 	struct cdns_torrent_derived_refclk *derived_refclk = to_cdns_torrent_derived_refclk(hw);
@@ -1972,9 +1804,6 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	if (cdns_phy->nsubnodes > 1)
 		return 0;
 
-	if (phy_type == TYPE_DP)
-		return cdns_torrent_dp_init(phy);
-
 	/**
 	 * Spread spectrum generation is not required or supported
 	 * for SGMII/QSGMII
@@ -2060,6 +1889,9 @@ static int cdns_torrent_phy_init(struct phy *phy)
 		}
 	}
 
+	if (phy_type == TYPE_DP)
+		return cdns_torrent_dp_init(phy);
+
 	return 0;
 }
 
@@ -2584,6 +2416,168 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
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
@@ -3322,6 +3316,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
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
@@ -3398,6 +3397,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
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
@@ -3498,6 +3502,20 @@ static const struct cdns_torrent_data cdns_map_torrent = {
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
@@ -3576,6 +3594,20 @@ static const struct cdns_torrent_data cdns_map_torrent = {
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
@@ -3654,6 +3686,20 @@ static const struct cdns_torrent_data cdns_map_torrent = {
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
@@ -3737,6 +3783,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
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
@@ -3813,6 +3864,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
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
@@ -3913,6 +3969,20 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
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
@@ -3991,6 +4061,20 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
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
@@ -4069,6 +4153,20 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
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

