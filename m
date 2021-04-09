Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713F23594A8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhDIFfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:35:01 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:29456 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229715AbhDIFe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:34:59 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1395PgEh030137;
        Thu, 8 Apr 2021 22:34:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=faPxnjmejqpdPoegAoq7wyLIl+gLK92+PO2ASZDtccM=;
 b=FRJyRZ0v9SYjqEwypXEV1jcYiKlprtWGD2QTAsSi/EJ3vggA3rkwshmHCKvyTr5oGN/C
 t3+ooQA/kLCAJrS/Vb5z02psvzPpIiSARy93hfXJo/dcCu6IeZPtdGzXkrM7GF++1FMB
 wx91XtpuP2SZLz6Db8mlG6YX2o0JPJ6xhJf6im9Cq37FM0PEV/Y57aQmnte65N5YNj2/
 sIB8+V9GX7+aDGFD6bX/tOYjs90+emdEd/Ot9H/BKo63lP8jUlQQ73c42DDEQ06tLRe+
 r46bwhxxnf6/+GM4I+TbsAouec4V3tQOOZVwbf5obF7QzEekr01a/HFC5YWIyWBuJRIn zg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0b-0014ca01.pphosted.com with ESMTP id 37rvb4tth9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 22:34:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSwwiUIGMzQdQZz9JMB73Eh3qhdw03p811lPP/qt85vHeiRbDo/niJBnsECB6Y9rGt0KzGlU+MehzQVqgoLtvChbBNQT283B+rY0zjY5aw5rth5m5LwA/AZJgYWffTSrpGBObaMZk0XbHWEMlHZcrSYEJwqjCVEYEhoYixeolc1EXjpogx9b/iXzwKuDgQJtfRC2Mlke76JudTnMIyusai0OaRRCc5qqruudZ+vGIlS44wmMf2CNkW3qm0aEHmG8m6bev9xATxEA19z3s6Yb8clh711NohcK7tzD0IeowzEP+RDWBdDdH5O4RMm8arlIMsqg5lhGPSBT1w0ROSm1dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faPxnjmejqpdPoegAoq7wyLIl+gLK92+PO2ASZDtccM=;
 b=ZZ6yAR2DTHnYlKYEpdl1A5LkZhPv3LQjjfeaG3IEaSXryG/rH+PY1m+vBZOKD87EklmDASWZVahxn3UsZ93RjupxgFihAJyd4/qwtWvpWOr6aGvUQ3i5x6Hcp7ireCvvDRVD+bm5WdfvV0EzjRjD8KkYFLE2B5d/amGzpQnyE6F/vzzO+tWSCoB/QD0DhAZfRcWOyVlTzeqN5SCxR41qrAOqc54uu63krkuvGRTkUKLACuUVDVKXDXsGisxg2djwkLB44m56vkbCnOFP3mtiMyHs7FZA0Y6+3aDaFdka+jOf28WlZ3iEKxlxEL+c0BZq82XUxvNaWOkxy4UG02hM5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faPxnjmejqpdPoegAoq7wyLIl+gLK92+PO2ASZDtccM=;
 b=WseV16E0a4PgE18i7HINz7/PeSGRBkcrMe85Tn40Z+qsVeiEhjTH2Fkp6JNlbr65882ud88tkcpmF0o7F8NeGRovy7WYuNeqTWEKxQCofL/TkD+WpWub1UzMwrGsIkht33RSAd6T7uphXs30Xu9BschmNe8eBSqAUtYhtRmnt1o=
Received: from MW4PR04CA0038.namprd04.prod.outlook.com (2603:10b6:303:6a::13)
 by MN2PR07MB6863.namprd07.prod.outlook.com (2603:10b6:208:11b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Fri, 9 Apr
 2021 05:34:22 +0000
Received: from MW2NAM12FT016.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::2) by MW4PR04CA0038.outlook.office365.com
 (2603:10b6:303:6a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Fri, 9 Apr 2021 05:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT016.mail.protection.outlook.com (10.13.180.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.6 via Frontend Transport; Fri, 9 Apr 2021 05:34:22 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YJ5R032749
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 22:34:20 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Apr 2021 07:34:18 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 9 Apr 2021 07:34:18 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YI9V027826;
        Fri, 9 Apr 2021 07:34:18 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1395YIP7027825;
        Fri, 9 Apr 2021 07:34:18 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 01/14] phy: cadence-torrent: Remove use of CamelCase to fix checkpatch CHECK message
Date:   Fri, 9 Apr 2021 07:34:03 +0200
Message-ID: <1617946456-27773-2-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
References: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78336d53-e38e-4c0f-e573-08d8fb192143
X-MS-TrafficTypeDiagnostic: MN2PR07MB6863:
X-Microsoft-Antispam-PRVS: <MN2PR07MB68639A13E5CBFD6AF5FEC5D6C5739@MN2PR07MB6863.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yyzpDj8ucMmyNzZw3avUrTPPC6OAI1b36NIa625kGpKG1gw5NDDw8TE2Hdck2DAzpReSpgf5GuKYy6Mwwr+NMOw4AO2m85Y8U48+RJ7FDtABm8/YLgK2GA/DZHFyt/DApnRFvaBrBaVyAm9N9ewzAeKH5IOGVwHUkVzIoOTLvy5XsF06ZEa36dnWc15JEWcuS+HnT5f88MmGhXyJckdRyIaN7RshmXMF/zzggKLXQ6yCvAXZx0GxJEK4BZ68YM7K5nBMudRpRyfKnGwWePCPrGjklPtWNuL56OGF5r1A480hoJzVLqJVj8wO6G9SUS/w8JaNg+Gra/r7+OewSzRSJGAwKfsLGSP1vhfDJVjkHID7tV7sdSC2IA7t47KAYBAAfUburS8WY1fbt4cEWoUfITJMcnLLQshImbFQ3mTPkgcgCI4aaJVSTTn1N4eLOA1HUtB9auiOJ4dUuzTSLpgitjNWPz0unArjJ0RiL3Pt4Yjc+UQXGIbIypmJl2ivn8RopQ7DudYRxDBFu4BvAjBNP1IPKH+S5XfdqlMurtf7zhoeYkG8UHPdKdFOQpFZ1uw7wqsnFGRNEhUdeskN+CD2g578lkE/nW7tBDiBMeezKeECJnkxBXgyvCkmbDqkeLcHYm7gaD3GnascMMKulLRbOtOaMEsqr1/ZaAgZ4xvfeL+0AhNwYj13QEF+Hixl6s07PMaYE6Vn3cEsCeMP+oznMA==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(36092001)(36840700001)(46966006)(36756003)(82310400003)(8936002)(356005)(83380400001)(336012)(7636003)(478600001)(26005)(4326008)(6666004)(186003)(86362001)(426003)(2616005)(8676002)(82740400003)(70586007)(47076005)(15650500001)(2906002)(42186006)(110136005)(36906005)(316002)(36860700001)(70206006)(5660300002)(54906003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 05:34:22.3247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78336d53-e38e-4c0f-e573-08d8fb192143
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT016.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6863
X-Proofpoint-ORIG-GUID: XdqmQflfoGQRETivBDQIMidvqkg6dSZp
X-Proofpoint-GUID: XdqmQflfoGQRETivBDQIMidvqkg6dSZp
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_03:2021-04-08,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1011 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104090040
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Script checkpatch with --strict option gives message:
CHECK: Avoid CamelCase: <REF_CLK_19_2MHz>
CHECK: Avoid CamelCase: <REF_CLK_25MHz>
Fix this by removing CamelCase usage. No functional change.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
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

