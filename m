Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069593D9160
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbhG1Ozs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:55:48 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:43060 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236939AbhG1OzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:55:25 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SEjtrb024289;
        Wed, 28 Jul 2021 07:55:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=K2w+Q/pNlAzaFVFRsI2zzi78PY0GZcxlnBExlAo1HFk=;
 b=KBBzRhaseuoGKTeMzbwiOhh4ufvAPsV1pft+A2SD8UIzrcop8Wo83NQLAtfWMRwEyify
 ZOnnVWeGb2zwnChj+DPDZ52kg+hmIW+2iOLzQEqXWv40Jr4q401/VR/jwEFYTqlJVO4l
 ZBDVRxX7+RkJvAu7+h0OmBs1mEwkuJ5KYgHRxEBQCxCBKwGgRHwNiCEKkHEztO0ZmAEk
 NOuNFQuLlSzRoiYVQWmN2pKgrNuO621s+Pav8ThZ5JwsL3wBmaZ/vvjuE4A9cPpOuSGV
 wrnZCARBjBS8Tru/wxrNVWEgtQiSD5Ya88K4uAGlomUZnFVreq8Uz/Qk4CXEbSQEy+/Y Qw== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3a234aysbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 07:55:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmK2miNn9NX/5/pzqsBiPJE4/ZjGrSgVmPcy0JaHjssNOW7o4xDgeBstNWcDW9hu0ytf6vStaN0XpCL3Fvjqfh+WjClkrhWTulWFZE6GEawLKG7KP34Kc7+NnvsjlckiDrlIMW+VjffH1niu24zbhEEbgcZ9/HfOygRykmHLU5cf9UnUth6fyub7UTb3QHL8hnM5ZFvo+o0yBP5qWZucHyxUrA04rDbxP31r75NI5tucwZ7GyxpbHy6iP4/GcP1f1s+f7yiHbraS1MC0FmDFBYKVnKKl4rSsZS2YfEijkMA/1zTq6HnSpKSxVIyS4wtO78J63s/Up4ZCg5TCinUEbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2w+Q/pNlAzaFVFRsI2zzi78PY0GZcxlnBExlAo1HFk=;
 b=F4bB9lOaGzLOgEGm9ppClMlveTlVcmPOadn1+PfKEgWvgOyEIZrG2ynrln2CBS5z7FnCoTOyi6PMZLHzm4b9j7tAJv6y9jJC0hPuJibICr5KeEv2wNSOvNaVFptnYf5lLI163wYzZALo4KMQcCJcB4zDPl2O8f1URG1mzKbbBb9dMhQXd/JjUvcUrtiTQsM8BddCN/fBFaIcSGt2eyv7tZqfwA6fFfT7CVU6N21TDjWpY4YroVFkj78HhQXLKg/f8REih6q7liEzAdDLnzIkJizK2Wri7hq3LNpwUgfFi4Wcgc/x7FDXOUDt0YGDpMWXRbClgFr5fTk9QYoRDXiafw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2w+Q/pNlAzaFVFRsI2zzi78PY0GZcxlnBExlAo1HFk=;
 b=ykJJCto0SLOw+0p812ccJYmSRv99eq+2Up/BKyf+9svPJ07qoPOeaCL/TTykoP4Uz5YNueNjnHiRQsuJMdgNZRNLikIotVKAx93Fvkco+AihjPULonZViGwjNLKew9tnZC4GnJZIODO4KfBYtpheDmXeRmp/qgEhd824OgQeS34=
Received: from BN9PR03CA0710.namprd03.prod.outlook.com (2603:10b6:408:ef::25)
 by MW4PR07MB8569.namprd07.prod.outlook.com (2603:10b6:303:be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Wed, 28 Jul
 2021 14:55:03 +0000
Received: from BN8NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::a9) by BN9PR03CA0710.outlook.office365.com
 (2603:10b6:408:ef::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Wed, 28 Jul 2021 14:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT056.mail.protection.outlook.com (10.13.182.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.7 via Frontend Transport; Wed, 28 Jul 2021 14:55:01 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 16SEsvrr095664
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 07:55:00 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 28 Jul 2021 16:54:56 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 28 Jul 2021 16:54:56 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 16SEsupS016533;
        Wed, 28 Jul 2021 16:54:56 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 16SEsu4T016532;
        Wed, 28 Jul 2021 16:54:56 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH v3 3/9] phy: cadence-torrent: Add enum for supported input reference clock frequencies
Date:   Wed, 28 Jul 2021 16:54:48 +0200
Message-ID: <20210728145454.15945-4-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210728145454.15945-1-sjakhade@cadence.com>
References: <20210728145454.15945-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6024ad3e-a270-4668-e45c-08d951d7ad69
X-MS-TrafficTypeDiagnostic: MW4PR07MB8569:
X-Microsoft-Antispam-PRVS: <MW4PR07MB856923C3B8E0EE746EA1E9C1C5EA9@MW4PR07MB8569.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YKvTs5mRSy0AytbLU3XupQTb0hOOAZ82cXj3XeXq5yladOMB/PZCaJagq2K+VQT/CUhjzNYmbXrofQKUFelniMinOVzc787elWnvfPGexmLPXNlGhqA5cH00CDdWBigADl+ly+76OU6u5bf459z8zj6b8dWcGbAnWsgza5P8LZf//9fxwWi5W+euPUnGyP5bAgb9fYEQwIL9dH9hydTok2bILgNi6FwRhev9A/NMtubz+Mc5yV7fg1olAY+o4b4ujJTkVXFyEmo6O7eC4jRqiG2DkZrVzCJsctScgtfh5rqAu3NXkFIohHrXmlHaN5wCn6tnqJvrp2hOlA4lMT7+KIHFnx59fBYT33WZ6EkZG8knGJXW4lcOYJaJ0/jAR5mn3PZ9zakLaL2TxUCNQrhpGIlLvzz5JatpsXRE14bMhw+Nc3LVqF9xFpwB1+GM/eiy+cEgwC5YauTrb5hniDL/Jev/Ww0ItAqB5765vNjV9PtRggAoGjg/9uzx7E/uyoFFuXB/gX2x4cp/dcaxhD/7ttv3vSCy/dmCYaUxFZcDROLEL5LE4vGYFzlXvks3/KrIDFjVGRCDvgFGdF7RDrZiNLxU+HnBhpL7r8TUhIc6AUqcSEyI/aDUiqZ/aZ/IYIS5dVHuBYhCW+YjUIdb25tvUzA+6yOWM+vO+H+QzvE8Wtgz12IHhKBrhzFqyZbRQh8sQ+WXo8lS65ASduFlk3y0fHEum/qBNEf8T0+RK1lWfTvEdbr5IVGtJcu1zfM5ZBMpRojoBTGiGoWizajyQ6ta83QvyVuPpslmPAKn0gJiWpc=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(36092001)(36840700001)(46966006)(26005)(86362001)(8676002)(54906003)(82740400003)(83380400001)(4326008)(110136005)(356005)(6666004)(5660300002)(70586007)(186003)(1076003)(478600001)(81166007)(82310400003)(36756003)(70206006)(42186006)(316002)(2616005)(36860700001)(426003)(2906002)(336012)(47076005)(8936002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 14:55:01.6743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6024ad3e-a270-4668-e45c-08d951d7ad69
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT056.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR07MB8569
X-Proofpoint-ORIG-GUID: bJlXE-YKPu2VQG-ar_4JpGmlEDGSPksb
X-Proofpoint-GUID: bJlXE-YKPu2VQG-ar_4JpGmlEDGSPksb
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

