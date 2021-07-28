Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422123D9159
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbhG1Ozh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:55:37 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:8070 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237323AbhG1OzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:55:23 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SEjuEj024292;
        Wed, 28 Jul 2021 07:55:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=VQNha+IUe8NJSuECFA+pFniJ+F+2V+8eruDTardEmXY=;
 b=GHV2W5x+pE1zi9Mn2eNnG1OWGhzn1nw411TxWR1f/DcrVZGu41PZG0oS8xrmUj61av3A
 q/Nn/+ikuJfCr88jSNDDqm90Zvj7cs0VQ+2plsgTSdhoI7UyxnJlNtJakJtU1+vWdRaK
 iKs8MEh/7NniCAmLvbCf8AGKJMr+uhrPFfrAl5yH5JqQD/Ntu32gb45vN8VkO4XcxDKO
 9YblPWtX/Y/yM6sqqI3dGXPS31sKD8u5SN0PofNkhRi9QcMoDJqznTuKc5Ie7bScXMqE
 l2WbOm5l7f/Dz61AIEYkYh9JoAGrnamvOmfPYGRKCg9cUbDFtknquOmhHBPphkm0xDV4 WA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3a234aysbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 07:55:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqW+XQa0KG00zAvXm6iwEUjMxTbfRyQ01hQRg7Wl+KTyM4MGT75hkmarVKwEEq1FvX5RFztSKCgEQWOsh9Yg2pXplIXzTLCX/w98x1vB/NWNAN/rGEiW4YXWOsBDeFoDmqFlJPJ5kQtPYC6xRbXFyZgCZia5wXfxFobs10wzGG18PWfhgQYADDPPVD4YrBB8kur3PDUfW7stXmkzjwgScVs9mUQHdXLGAklBm9FIOGiVDw9PUcHJrMnXDsOcpVSBx40uX86cGXvTAS0hqE3lvP1WQD6L727Jh8tu4NXm3VFB5B72WsDbwBOz50dXfNrp5S3q9CUY/4R87Qgjltyu3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQNha+IUe8NJSuECFA+pFniJ+F+2V+8eruDTardEmXY=;
 b=LwLhmBtkd3/rF16Dh68SRCOltGs8x2j79IxqrBtCad1Xbq3haeXRjyWf8pGb0tH/vZLKwyenj3HqXjFP6KLUUb+DxUYkkWb+waG9XB3lQalbSOE4+P5SLHIhpEZTsBwPsMnPrC8XKETdY8bKHfW7osOxyJhUa5DSwfYt0AwqI9tCzxQZyc70SGcrfbHsG4q3silVXjv3s54K1BgOCvAq5qsaWuvNAdK1FiUOq9sWI99VuHl2iP72PQQ0/DpA/o7KYxLiWAI4O+WtKFnVnjmh/l++WSi/wTPTWCfGmh2wf14JENHroxN9osUNRnAQzDjvbpY1XT1FxBRllNXSdIEB0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQNha+IUe8NJSuECFA+pFniJ+F+2V+8eruDTardEmXY=;
 b=CZgWYASJK/pbN+HHZQtToFHXkedM5gLyKRksZGR8Dphw0Jh+Y+Kr9CC+gBOT/4mbyNPf64ftfzYfNYi1KYi6Pncgo0kUgzrdOY7Caihzp2M9YU02aNFFGlCdyHaKUAoTgegzJMWrgzCT6sT+u6VYmjfgf6FCVxVdWi8teCIavfc=
Received: from BN6PR22CA0066.namprd22.prod.outlook.com (2603:10b6:404:ca::28)
 by BN0PR07MB8816.namprd07.prod.outlook.com (2603:10b6:408:165::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 14:55:01 +0000
Received: from BN8NAM12FT025.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::35) by BN6PR22CA0066.outlook.office365.com
 (2603:10b6:404:ca::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Wed, 28 Jul 2021 14:55:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT025.mail.protection.outlook.com (10.13.183.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.7 via Frontend Transport; Wed, 28 Jul 2021 14:55:00 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 16SEsvrp095664
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 07:54:59 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 28 Jul 2021 16:54:56 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 28 Jul 2021 16:54:56 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 16SEsuWS016517;
        Wed, 28 Jul 2021 16:54:56 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 16SEsuBY016500;
        Wed, 28 Jul 2021 16:54:56 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH v3 1/9] phy: cadence-torrent: Remove use of CamelCase to fix checkpatch CHECK message
Date:   Wed, 28 Jul 2021 16:54:46 +0200
Message-ID: <20210728145454.15945-2-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210728145454.15945-1-sjakhade@cadence.com>
References: <20210728145454.15945-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8204b6c-8055-4db7-364f-08d951d7ace5
X-MS-TrafficTypeDiagnostic: BN0PR07MB8816:
X-Microsoft-Antispam-PRVS: <BN0PR07MB88165FAC1985C4A7F0EA511AC5EA9@BN0PR07MB8816.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFtongNmeIPj1OYcB+pxo0T4NZ4s8mOSMfsDQUHEb76YIOKVM4KaOXoM0NsnRZZes/tMP/qRdaGBEm7Cr986zbmNExHwtbgfrthmCtCKGfpj2k/XImKYUnupC0qPjr0Brdea27I3AvTV8ckfDjfDVBQ2UFRCjFh7shskpTc25BfbDmzlK6Ss0+gWtwdjKJFhrycTr+4xWtBziNdU0exghZrRROFHSRLwj8olLS6awwUJRoMeEqMIOf9gtkEGp7R+dznLOmOdh7S8wXsflG/87g2QeJiZ+NSTSC36zMlhVBO2Ld5cpjS40XSW0b4N9p9YVp1o1tQTv8XQEGTqDmvgzJEAGlBiptHKfqwwQGRpWqfwhzEX2ASr8aOgDaBFAbzXpUIwc30UmNDzBnyCIjSlall4F7+3C17rfhDRfr9yC4as3KLkUH3LMvN+vrB04hyPYUc2jJrjEkT9uH7hE57fMZRWaLn/ZMP/V7gILKoY2K0gMT+/y98M9qTvmr7Aq5uWDir9NuCUKLYaF4shmrw6PfwHrjR9qB2RnChpyL970ObYxeI9aQuq1OBa3vt9vuJfhUwWlsNh/pqQx7z1hWGjegG3qde3itimAzPJGdKeQ0ai8tZR88/rQ6ONxsGiBj2Dbssg2TUdrhvIEiwrKXmschOae8mLRs6Sv3w7+MbTax5NFTP4XckDXkge/1mhmb2GMvw4oqBnK1P6TL7Llx4LH0+N0O1OSG+JCi7DbyJosEXmK0OWilqiRABNhlSwkbgyU+uvbGrVwTjgY9f9Rmg9dX+qENgFZ+XUWs51b8A+xsw=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(36092001)(46966006)(36840700001)(42186006)(1076003)(15650500001)(426003)(54906003)(316002)(36860700001)(5660300002)(6666004)(36756003)(8676002)(110136005)(81166007)(356005)(47076005)(2906002)(83380400001)(26005)(186003)(336012)(70586007)(4326008)(86362001)(82310400003)(508600001)(8936002)(70206006)(2616005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 14:55:00.7958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8204b6c-8055-4db7-364f-08d951d7ace5
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT025.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR07MB8816
X-Proofpoint-ORIG-GUID: h6R8iy05a1bNhcXl5WixgEzMJY55sYBA
X-Proofpoint-GUID: h6R8iy05a1bNhcXl5WixgEzMJY55sYBA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_08:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1011 lowpriorityscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2107280082
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

