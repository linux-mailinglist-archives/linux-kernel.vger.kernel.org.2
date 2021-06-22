Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB97F3B0958
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhFVPm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:42:58 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:1216 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232303AbhFVPmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:42:39 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MFdS5u003976;
        Tue, 22 Jun 2021 08:39:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=K2w+Q/pNlAzaFVFRsI2zzi78PY0GZcxlnBExlAo1HFk=;
 b=B2upzTDaWSQmHfXh8xypLOmUDSLcMvU6rS7UBFGkKwAvNEbSpndZmOSZAjOvQhqizEYI
 ZJelLOv/lDDOPyiu8YKGyK+jTcMNu096aE6YvzIweAokldtYRt632x0eO/9r4p9ZyH0I
 6pmu6W91n3ZZxxlSNn6wR3oPI0uDNd50UDzxIWnj39AULy3vjzXQF57K1uRRCxAiK7Dz
 NE3WvwouUx3MkziNeaEsL/UCumMpItUJUiPneHJKZZB8GyufocN+yjvBIHtYv3os70cu
 fo3C9HDCKyxw4TrjrJXRGiGnU9hg/NM4M7Atp5VoDgVLxa2TyOhe4+0W+KNYEq1zPiJX 2g== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0b-0014ca01.pphosted.com with ESMTP id 39atwmmqcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 08:39:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAlAC1PWZLqiJ3HsP7xitiz/MzqIUobhrpEOYv+OAF+yCPdbaxQKzWXRicSFxCIs2wM0qY+qJP3EEhaHsNShUq46tHqaFFK0rr6MsZLaRR9fR9oH9jsglXL3Lk5ZXqTUpH63fpbRnckawE2AlZWQEP0eWvusxoh+zGJD2oXGrd/Q8gMAdKIHXKU1wZgwdvelH4OfKh9cKoFs9IQnXv6/wlIdlxJgkKD3OMpSuug1jxUYqedHHmLI5GqDJCX3+vLXcrRYeSsFByTCwCFScFY1fdIcLzkdogXSKb26gVu+/ZH7/5bt0TirtTeY51xem+NqwRirgTlsF9lSokFfX5OGUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2w+Q/pNlAzaFVFRsI2zzi78PY0GZcxlnBExlAo1HFk=;
 b=HeAc/H4Xd0xfYL0y3MozpOEo9CmNPto4R8Yg1kg0u7ewbz9UYw2avnTcYof5z5RKfVihsOgtILkG9RDC9awPhQI3R8mOCZ+Pm9dXndjI+MNRmWiRqz7Z/ViXRQ6+yyvWziHM01Zag+kmn4HiNL0BH7NIZV2xAQJI40bZjJNfp/koUapFWaDxqNBESwTE2eGxU/L9yR6Utamm7T0W9/lvD5xj9FSrf/YS5x4pTpvEI4cQbBVhsHSOEY+8CdXS6Bgl36VRihogg8FjGjbaCqaSgXVKltQi39rldvU9ezvhwu/zU9NOwadz0yfl2IFwABAd52J8iyhG4Bv84MVbSd46xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2w+Q/pNlAzaFVFRsI2zzi78PY0GZcxlnBExlAo1HFk=;
 b=jPMVCnBWWFEsx5OfvS54OQg0joKyVSyiQ+yz86nJOK7rf+psQ6BhZLn3kRBuSnnJWM6h9/Y+1TyhRlXja1D6muKKv/XOGb+2WGcioxAuCx9lyFRTA2jY/MabMVonYeLc2QI/A5K1onsJ5N4JlRbezir9w1z2yn3A0Lc6L/Rd820=
Received: from MWHPR21CA0058.namprd21.prod.outlook.com (2603:10b6:300:db::20)
 by CH2PR07MB6488.namprd07.prod.outlook.com (2603:10b6:610:2e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 15:39:57 +0000
Received: from MW2NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::b9) by MWHPR21CA0058.outlook.office365.com
 (2603:10b6:300:db::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.6 via Frontend
 Transport; Tue, 22 Jun 2021 15:39:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT056.mail.protection.outlook.com (10.13.181.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.10 via Frontend Transport; Tue, 22 Jun 2021 15:39:55 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 15MFdpjE219509
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 08:39:55 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Jun 2021 17:39:51 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 22 Jun 2021 17:39:51 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 15MFdpn1002310;
        Tue, 22 Jun 2021 17:39:51 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 15MFdpZI002309;
        Tue, 22 Jun 2021 17:39:51 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH v2 3/9] phy: cadence-torrent: Add enum for supported input reference clock frequencies
Date:   Tue, 22 Jun 2021 17:39:43 +0200
Message-ID: <20210622153949.2215-4-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210622153949.2215-1-sjakhade@cadence.com>
References: <20210622153949.2215-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcc26d34-811e-4ce2-c8bf-08d93593fc57
X-MS-TrafficTypeDiagnostic: CH2PR07MB6488:
X-Microsoft-Antispam-PRVS: <CH2PR07MB648891F8523B9EFA71D97B2DC5099@CH2PR07MB6488.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dMQfCaslMfxXilxUDYHjG75ojvqiucL8RWPSA3gv+f1YA6GqCX/JbtMwflcLRTFx4mCNEC4Vo2qsyGN889l8K1URMJqejoyLr1oh2SjwHMzV3CDw6jJP+6lCYAmKRUlOBQ2PRPAlM+mtlmMggaVje5xoyJ46V0RrISQysszmG6R47b0a/WFKza1RKRG6GwmpOip3zgD3O2WqN618grLYW14gvmfZeGhXiIUz7aZWVj74cib55ucqCWsh/GNtrMXlIKSqQAR7wSlV5UroswTRLm5SpBKD/9HIWdtEHuVip4iNjeOAIf/DZFJ+YFEXQZZyArv4uG65wNQ+wcIHk/mibTy6EGVBa8TP6ORIkYKZnU7C7ohmlDG75zxMlY0+V0bQjMujWOvcu+brhJ7Pz8I5k3FnVY2Mdp8tJuMoJvKKUBaeyoifajO1y9xHRzBNgAof1UrPQLtNz5Xecro6GQPG+kOOJDHuyXr0DWDVQGMqMJN4axxQajV5NfBfRkAztmcHYNnRudDjP4t0JSLm80+v426np9Tx4998g8gPgr6N1qmIDq5uDZSJmSLy930EjOpFvPTYDV/kpB9nbJRlsoDaeGlndoWUXx8BcwcmPxS1vMXafzzOsmjESADhPAKWSxdecP8BQwdQMoe7CBAl04/HN9CbRcjxLjZp1sIDvu7Jmj5mvZgXTDdWIzN2tjeMB9gR369slXXLpdPj6FiB0SgpLvdyXiWHX36ZX/alI+kqoCs=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(36092001)(46966006)(36840700001)(42186006)(47076005)(83380400001)(336012)(81166007)(8676002)(356005)(26005)(498600001)(110136005)(82310400003)(54906003)(1076003)(426003)(186003)(36756003)(6666004)(5660300002)(36860700001)(70206006)(4326008)(86362001)(2616005)(70586007)(8936002)(2906002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 15:39:55.9172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc26d34-811e-4ce2-c8bf-08d93593fc57
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT056.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB6488
X-Proofpoint-GUID: 2HwQW3Kxmdf1Px1arRVLOZ1vIl4nW5Gp
X-Proofpoint-ORIG-GUID: 2HwQW3Kxmdf1Px1arRVLOZ1vIl4nW5Gp
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

Torrent PHY supports different input reference clock frequencies.
Register configurations will be different based on reference clock value.
Prepare driver to support such multiple reference clock frequencies.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 51 +++++++++++++++++------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 4b2d6d3eace9..f746553c8089 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -26,11 +26,13 @@
 
 #define REF_CLK_19_2MHZ		19200000
 #define REF_CLK_25MHZ		25000000
+#define REF_CLK_100MHZ		100000000
 
 #define MAX_NUM_LANES		4
 #define DEFAULT_MAX_BIT_RATE	8100 /* in Mbps */
 
 #define NUM_SSC_MODE		3
+#define NUM_REF_CLK		3
 #define NUM_PHY_TYPE		6
 
 #define POLL_TIMEOUT_US		5000
@@ -273,6 +275,12 @@ enum cdns_torrent_phy_type {
 	TYPE_USB,
 };
 
+enum cdns_torrent_ref_clk {
+	CLK_19_2_MHZ,
+	CLK_25_MHZ,
+	CLK_100_MHZ
+};
+
 enum cdns_torrent_ssc_mode {
 	NO_SSC,
 	EXTERNAL_SSC,
@@ -296,7 +304,7 @@ struct cdns_torrent_phy {
 	struct reset_control *apb_rst;
 	struct device *dev;
 	struct clk *clk;
-	unsigned long ref_clk_rate;
+	enum cdns_torrent_ref_clk ref_clk_rate;
 	struct cdns_torrent_inst phys[MAX_NUM_LANES];
 	int nsubnodes;
 	const struct cdns_torrent_data *init_data;
@@ -960,10 +968,10 @@ static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
 					 unsigned int lane)
 {
 	/* Per lane, refclock-dependent receiver detection setting */
-	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHZ)
+	if (cdns_phy->ref_clk_rate == CLK_19_2_MHZ)
 		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
 				       TX_RCVDET_ST_TMR, 0x0780);
-	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHZ)
+	else if (cdns_phy->ref_clk_rate == CLK_25_MHZ)
 		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
 				       TX_RCVDET_ST_TMR, 0x09C4);
 
@@ -1004,10 +1012,10 @@ static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy,
 {
 	unsigned int i;
 
-	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHZ)
+	if (cdns_phy->ref_clk_rate == CLK_19_2_MHZ)
 		/* PMA common configuration 19.2MHz */
 		cdns_torrent_dp_pma_cmn_cfg_19_2mhz(cdns_phy);
-	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHZ)
+	else if (cdns_phy->ref_clk_rate == CLK_25_MHZ)
 		/* PMA common configuration 25MHz */
 		cdns_torrent_dp_pma_cmn_cfg_25mhz(cdns_phy);
 
@@ -1254,12 +1262,12 @@ static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
 	ndelay(200);
 
 	/* DP Rate Change - VCO Output settings. */
-	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHZ) {
+	if (cdns_phy->ref_clk_rate == CLK_19_2_MHZ) {
 		/* PMA common configuration 19.2MHz */
 		cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy, dp->link_rate,
 							dp->ssc);
 		cdns_torrent_dp_pma_cmn_cfg_19_2mhz(cdns_phy);
-	} else if (cdns_phy->ref_clk_rate == REF_CLK_25MHZ) {
+	} else if (cdns_phy->ref_clk_rate == CLK_25_MHZ) {
 		/* PMA common configuration 25MHz */
 		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy, dp->link_rate,
 						      dp->ssc);
@@ -1602,8 +1610,8 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 
 	switch (cdns_phy->ref_clk_rate) {
-	case REF_CLK_19_2MHZ:
-	case REF_CLK_25MHZ:
+	case CLK_19_2_MHZ:
+	case CLK_25_MHZ:
 		/* Valid Ref Clock Rate */
 		break;
 	default:
@@ -1635,11 +1643,11 @@ static int cdns_torrent_dp_init(struct phy *phy)
 
 	/* PHY PMA registers configuration functions */
 	/* Initialize PHY with max supported link rate, without SSC. */
-	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHZ)
+	if (cdns_phy->ref_clk_rate == CLK_19_2_MHZ)
 		cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy,
 							cdns_phy->max_bit_rate,
 							false);
-	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHZ)
+	else if (cdns_phy->ref_clk_rate == CLK_25_MHZ)
 		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy,
 						      cdns_phy->max_bit_rate,
 						      false);
@@ -2255,6 +2263,7 @@ static int cdns_torrent_reset(struct cdns_torrent_phy *cdns_phy)
 static int cdns_torrent_clk(struct cdns_torrent_phy *cdns_phy)
 {
 	struct device *dev = cdns_phy->dev;
+	unsigned long ref_clk_rate;
 	int ret;
 
 	cdns_phy->clk = devm_clk_get(dev, "refclk");
@@ -2269,13 +2278,29 @@ static int cdns_torrent_clk(struct cdns_torrent_phy *cdns_phy)
 		return ret;
 	}
 
-	cdns_phy->ref_clk_rate = clk_get_rate(cdns_phy->clk);
-	if (!(cdns_phy->ref_clk_rate)) {
+	ref_clk_rate = clk_get_rate(cdns_phy->clk);
+	if (!ref_clk_rate) {
 		dev_err(cdns_phy->dev, "Failed to get ref clock rate\n");
 		clk_disable_unprepare(cdns_phy->clk);
 		return -EINVAL;
 	}
 
+	switch (ref_clk_rate) {
+	case REF_CLK_19_2MHZ:
+		cdns_phy->ref_clk_rate = CLK_19_2_MHZ;
+		break;
+	case REF_CLK_25MHZ:
+		cdns_phy->ref_clk_rate = CLK_25_MHZ;
+		break;
+	case REF_CLK_100MHZ:
+		cdns_phy->ref_clk_rate = CLK_100_MHZ;
+		break;
+	default:
+		dev_err(cdns_phy->dev, "Invalid Ref Clock Rate\n");
+		clk_disable_unprepare(cdns_phy->clk);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.26.1

