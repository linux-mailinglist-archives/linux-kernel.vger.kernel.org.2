Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DD53B0954
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhFVPmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:42:50 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:25054 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232350AbhFVPmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:42:39 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MFdRXC003968;
        Tue, 22 Jun 2021 08:39:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=VQNha+IUe8NJSuECFA+pFniJ+F+2V+8eruDTardEmXY=;
 b=iy8vOw4M8KcHWkjv6oTFIWmGteEQYVelXuNisRRSHU+/+Wv4Z1ZD39x7F0I0bPu8XR66
 DWj+cwS7JsSzhMyFwloZlcMi5DI/xJQrGrGb+MeMbkqDUlroSg4tWgN5iQzpeLVBtAGI
 /t9Ugka3ku0kiZpHnxgTuuseSDvz7ERdwnh8SgoysAXG0Is8Gn42JvhyCFnuWXZtfjVr
 soL0lotykVw/qxja5gVuq0urAy49WIFH3C+peocn6TEIRDZAJ0KUeSBmgN0XYXY8AT0R
 rP+R6KQSKn24DDBzjWJBe0xJAeCD8PAzOA1hTRDQZrbMHRPQ8e2XcQLI6O8tfzBF+g3o AQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0b-0014ca01.pphosted.com with ESMTP id 39atwmmqce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 08:39:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEYUKbXT57fB/8d6uRkkKJoBal13ulQXSG1ap1VQn1is6phbkAef6g7l1lf4QQ1XQ4ZRcMnfwfOkJOvzmNwPx2pYnvCkwWSML/4YcA2yHN93PJEWf5vBnQ5U8dLVOLb5RKzBcVgg8lFZO5yZtvmXccOf4b2j85TbbNqS8Q4Gi6q471yMR5G2QJUT2UipUlFP5Sj6dqok1E7tEIdm628UrfgmQ9+FDlGJbhpBv1phfy+4P7OVsemWXPmBaKm8qS2q37iiYQnVTO1Dfz7wzV6Z1q4rqQWJh+vB5PUwjiNmwzugxVG9667mWNpKrxfIa3lJhcMaiicGlIGmhulIeZfZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQNha+IUe8NJSuECFA+pFniJ+F+2V+8eruDTardEmXY=;
 b=jMCZiXM8jewisybyTz/KYYdxnctAkCwVPvLb/Rg+SueTWTf8QjwcU2Jqjkkll5GFdK5UYV6hy0iEmj6fyelW5CohagYN3Z0UA4TDfRwsE1UHERBaYNN2MsRX01tWX1/6k01saqKAmsPS0tVqb9u+8+5tVyu9kWeqEAPgIDubIx8tmMnRoUD6E+zWJg74M2aEbDeTDudsuX1jmbPDFM+Ox52EPJbMqWkJPfaRdjzQp2XujFyYTxmeuoPsuuh3n3qXnyrFU10pU4KvwH+OTjJ3xloURp7QhXvKl2VgPqXOtsFLk8IcffVx3VFJlNAUZc7WfjWm2rEVLWqrdS59xWBMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQNha+IUe8NJSuECFA+pFniJ+F+2V+8eruDTardEmXY=;
 b=7D41F/f45tuKDBpC0+t6wNLTQxgtFRiR70gnxeESe4OO2p6fpHhLoJRpdZ3cw9EEICbqDOLaGIOnGz1TjxWp14C2jsJ5oShX9IRI3W5itEme2FDx6jy/a1sO/0g5qztZzpKkLN8AWW/CmYhm7SUOClXj6ZQ27EU/r51mDo+hJSw=
Received: from MW4PR03CA0157.namprd03.prod.outlook.com (2603:10b6:303:8d::12)
 by BN7PR07MB4852.namprd07.prod.outlook.com (2603:10b6:406:f3::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 15:39:56 +0000
Received: from MW2NAM12FT044.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::c2) by MW4PR03CA0157.outlook.office365.com
 (2603:10b6:303:8d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Tue, 22 Jun 2021 15:39:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT044.mail.protection.outlook.com (10.13.180.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.10 via Frontend Transport; Tue, 22 Jun 2021 15:39:54 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 15MFdpjC219509
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 08:39:53 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Jun 2021 17:39:51 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 22 Jun 2021 17:39:51 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 15MFdppF002302;
        Tue, 22 Jun 2021 17:39:51 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 15MFdpXt002301;
        Tue, 22 Jun 2021 17:39:51 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH v2 1/9] phy: cadence-torrent: Remove use of CamelCase to fix checkpatch CHECK message
Date:   Tue, 22 Jun 2021 17:39:41 +0200
Message-ID: <20210622153949.2215-2-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210622153949.2215-1-sjakhade@cadence.com>
References: <20210622153949.2215-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39f639a4-ccd1-4f61-147a-08d93593fb9e
X-MS-TrafficTypeDiagnostic: BN7PR07MB4852:
X-Microsoft-Antispam-PRVS: <BN7PR07MB485283FBD5B282DB6A090A87C5099@BN7PR07MB4852.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mNAQSWjk6QSZUyVC5x2dJGJd+GHJovYlond3tbpjCMuqkzy+MVN8jYR5p3IogjZg1r59c6k75Gg7qOxFdPgYZIwHZm/mfI2kjzShwVw+XBJ9omyOgqdjVxwNV4GnOEBV39iQsTVZLvY3AMp2QI0Srgbne0czbd6Us2NK9Xex+HtLd6OMuicFio3ykSMYdr8fcFvXzKRqgelbTJcOD6Fovq9ljnBLcivNtL/J/tBTdurHgV8ki8z4EmB4g6fgdCn+B4150o98NNDawGdGRIwu7mdDeghVC8uSwiVJs2yh+Lcq3BUeYqEuLl5Uh+4HV1eqSlI4EUubLjOq1Lv4sIsPSi03Sx2hZLnlcyd8qXdNTwO3YzOEzrZ9+BdQaZ4NY79cwtubr2E2PQ/hB4033EGcIvZwhaFVL3MfDmS67ud3Lm92+qfZdL5F4acxEsu6+gr2qWa3A7oivUSs139VWkOhYTaClcir7FAWJ9vzfxkF4yrrtFxtgdymR7N3l7gLYv6lJTR9no0pv7GOwEycnkuCrFCGfW0zGVHgxV67F3wiqAfhtn+Bx2zWcY7st3CEI85rcmyAk4eSTaMDLWf3v1YVXWuy2UMiYEhtfCP5s5xafAtNvN7HyuiQA1BrZIOPviHmlmowNK0VqqL73fOP7eMYZ4I5j2knbzUv/q8SC0hlZpzIXm+J/gPlPlPvYaHiG0gbJ/TY3I3Gh2m5yGBMh0XWEUcrNKYxh9bTJMzf6DX/RK0=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(36092001)(36840700001)(46966006)(2906002)(8936002)(316002)(336012)(426003)(478600001)(82310400003)(70206006)(5660300002)(4326008)(70586007)(2616005)(8676002)(36860700001)(15650500001)(186003)(110136005)(42186006)(82740400003)(1076003)(26005)(83380400001)(47076005)(36756003)(54906003)(81166007)(356005)(86362001)(6666004)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 15:39:54.7011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f639a4-ccd1-4f61-147a-08d93593fb9e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT044.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4852
X-Proofpoint-GUID: dznJr3DZ-iGD3V5X1AV91QTHC4I-2jO_
X-Proofpoint-ORIG-GUID: dznJr3DZ-iGD3V5X1AV91QTHC4I-2jO_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-22_08:2021-06-22,2021-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106220098
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Script checkpatch with --strict option gives message:
CHECK: Avoid CamelCase: <REF_CLK_19_2MHz>
CHECK: Avoid CamelCase: <REF_CLK_25MHz>
Fix this by removing CamelCase usage. No functional change.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 0477e7beebbf..ff647669f1a3 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -24,8 +24,8 @@
 #include <linux/reset.h>
 #include <linux/regmap.h>
 
-#define REF_CLK_19_2MHz		19200000
-#define REF_CLK_25MHz		25000000
+#define REF_CLK_19_2MHZ		19200000
+#define REF_CLK_25MHZ		25000000
 
 #define MAX_NUM_LANES		4
 #define DEFAULT_MAX_BIT_RATE	8100 /* in Mbps */
@@ -695,12 +695,12 @@ static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
 	ndelay(200);
 
 	/* DP Rate Change - VCO Output settings. */
-	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHz) {
+	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHZ) {
 		/* PMA common configuration 19.2MHz */
 		cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy, dp->link_rate,
 							dp->ssc);
 		cdns_torrent_dp_pma_cmn_cfg_19_2mhz(cdns_phy);
-	} else if (cdns_phy->ref_clk_rate == REF_CLK_25MHz) {
+	} else if (cdns_phy->ref_clk_rate == REF_CLK_25MHZ) {
 		/* PMA common configuration 25MHz */
 		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy, dp->link_rate,
 						      dp->ssc);
@@ -993,8 +993,8 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 
 	switch (cdns_phy->ref_clk_rate) {
-	case REF_CLK_19_2MHz:
-	case REF_CLK_25MHz:
+	case REF_CLK_19_2MHZ:
+	case REF_CLK_25MHZ:
 		/* Valid Ref Clock Rate */
 		break;
 	default:
@@ -1026,11 +1026,11 @@ static int cdns_torrent_dp_init(struct phy *phy)
 
 	/* PHY PMA registers configuration functions */
 	/* Initialize PHY with max supported link rate, without SSC. */
-	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHz)
+	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHZ)
 		cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy,
 							cdns_phy->max_bit_rate,
 							false);
-	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHz)
+	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHZ)
 		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy,
 						      cdns_phy->max_bit_rate,
 						      false);
@@ -1074,10 +1074,10 @@ static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy,
 {
 	unsigned int i;
 
-	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHz)
+	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHZ)
 		/* PMA common configuration 19.2MHz */
 		cdns_torrent_dp_pma_cmn_cfg_19_2mhz(cdns_phy);
-	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHz)
+	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHZ)
 		/* PMA common configuration 25MHz */
 		cdns_torrent_dp_pma_cmn_cfg_25mhz(cdns_phy);
 
@@ -1529,10 +1529,10 @@ static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
 					 unsigned int lane)
 {
 	/* Per lane, refclock-dependent receiver detection setting */
-	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHz)
+	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHZ)
 		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
 				       TX_RCVDET_ST_TMR, 0x0780);
-	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHz)
+	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHZ)
 		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
 				       TX_RCVDET_ST_TMR, 0x09C4);
 
-- 
2.26.1

