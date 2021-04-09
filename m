Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1B83594B1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbhDIFfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:35:42 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:10008 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233285AbhDIFfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:35:03 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1395XZbS028240;
        Thu, 8 Apr 2021 22:34:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=aCb/pwhPqtQRKsxM/iA5/IjPXP7Tap47lTJqzfHIuT8=;
 b=RtZE6R1KBbeMtFqDOmpi1cVD71GYcp7c9nSWfyW7qQGWfDU28qL+F5Q6aoxejxrGs3cZ
 vTJUgvVb6AM8C22JOz6Ve6RfY4hzd2olnhhN4eKMAc4s9I2VJXc1hpr07pXCMPrl9Qfd
 8txNGFtLgjBt/UMIQKU1flYUg3gFIJBM4NhgMqu3ugGf9LMBhoFLLP06CRmkmNejPL0J
 51QDAybhPbqVhpsG1Y/NgqvKlZnT+OfmRqYC7kUQRN07oycd93gnFJICA+K0e3XL1gmM
 ssD6/i1+VgM3hvjM0pWJpkyLKyXTwPt/BSS91Y3wz4Cjed/yqvrHyjJw7iX5PihrdBZk Yg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-0014ca01.pphosted.com with ESMTP id 37t6ns1sqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 22:34:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auePsvyXzWJotTEiOrjP/yYPYd9tW3FjHYdfqKMB+MykV8oQ7wWHyOrM2p+VdAa8l0fggFxI98Pia64vc3UGCKsHfNVeH3ACFDgAOyeIiQGrBX3KAF5CNA1HQy9Dl0AZ3SGZLssAZsEshJzZrl/HpNh0n/V9b8+ZPv8dcEo8LPCnGMLYhH72w4TG73klmSmngKC4a67Eocf/TSNXNoZIB4YfknE2aYEjVbzLoLy4zGZq9lb/pD3WWqnsVLrNo+jULSfPcCD4WHNO/74ArZgfAX3JBy22lda3rhJ8uUbl1RTblGgpnATWaXD2MGqT7Jo0u6piAhZdY/8Q/4rAwh/fng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCb/pwhPqtQRKsxM/iA5/IjPXP7Tap47lTJqzfHIuT8=;
 b=Z4s2hbIm+suJx1pVuNQHuCKsDsu8cf87y1cfwdrJd7U636Ohbt+zbXO0cKiU0apdizgk1zf+BUg498W1OhLSneBtWrDV/r/W8jAzEkWPsmwyf5kSY3HOU/SSQM3+nRapikb2xyPaFj1UeH9dykwHOTarLjx+/++FIdYdwaaV7h2nYNDrmKYIkbhcOelBPxyuUFK6YvkATLEXQjeUyPEd3STqn+RJV/kT3TO+G/zguRdQEfBC/UD3L4Ve+n0Xjb8MbrogYnlI66SYJZWuyHA3CV3GIey60qmhOuPe6MrP/qSzI8TsP/xZc4mImr732m80Ivq0SJrATRV6Tvh9Uh4gAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCb/pwhPqtQRKsxM/iA5/IjPXP7Tap47lTJqzfHIuT8=;
 b=sdK7C/MIVm/AHxH9xqrSX+zDf2jiImFIu7hNTTMzIoP1HSGOHA3g7lN1qd1nueFSrQ8xjSbCENakjd8HFvGKCRZ7Tpb9/ReCu2T//UzDtTZUpeoZytdToemAYV2P0o5Iq3PikWjqmwUA5jmbl5TMfbxf4117lkoRIfe6bi/f4Ag=
Received: from MWHPR1601CA0019.namprd16.prod.outlook.com
 (2603:10b6:300:da::29) by BN3PR07MB2482.namprd07.prod.outlook.com
 (2a01:111:e400:7bbc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 9 Apr
 2021 05:34:23 +0000
Received: from MW2NAM12FT044.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:da:cafe::14) by MWHPR1601CA0019.outlook.office365.com
 (2603:10b6:300:da::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Fri, 9 Apr 2021 05:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT044.mail.protection.outlook.com (10.13.180.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.6 via Frontend Transport; Fri, 9 Apr 2021 05:34:23 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YJ5T032749
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 22:34:22 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Apr 2021 07:34:18 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 9 Apr 2021 07:34:18 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YI6X027840;
        Fri, 9 Apr 2021 07:34:18 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1395YINk027839;
        Fri, 9 Apr 2021 07:34:18 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 03/14] phy: cadence-torrent: Add enum to support different input reference clocks
Date:   Fri, 9 Apr 2021 07:34:05 +0200
Message-ID: <1617946456-27773-4-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
References: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27d038e5-1813-4987-0793-08d8fb1921d0
X-MS-TrafficTypeDiagnostic: BN3PR07MB2482:
X-Microsoft-Antispam-PRVS: <BN3PR07MB2482644A5B976B4F4AA218D0C5739@BN3PR07MB2482.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /opFEoxpXLwbBayd+iCVcb1gA+BxN9Ga+oBziE7YO9+8FcYftWhKzlRtKYjMsiKU4EdVD50RpAAJ154AO+T5r2JNmqvjgo+FZX4DTEC6aeCu5Ez7xEiKxiVSE6cIAgrI/VKccO4bOlP6QbtxRsGbqKuhN0UofSMgVQYg71RIyfvxLXP1q0NLbQttczxj951qYTclYS9ZN1ndu3caxRfEeuPYFVuJ763G9321AVpSKpxz/IMpRUFYX1WnFAvW/mAhTJFrt5SKP6+WXVtIkZcxzz/QnTgJamPRT4Cu20W7ZnTZtmjxu971LPJqFq4ZmHZOKnXuBFe/s16/bxaapzi4PtY1kAjuXlvOfIWokcazW3DsUYvl7vUi3+bpw6/kowJHpjHNcxBJDbdsY7Q+4wp6KDsNhJjtMLRC2GIKQ1Vpvi6USp1HajJjF5vSNhTs1WBjYijp7YXh0xEnPr8D1aCsl8h7yks6kll5vBicEf5jGJV84E+nOhHJ8/JjyGmifA2SlbPmNQM0wuIaxm6EEkcZY2oYLmRi2oIOvd4XEIflBE+LLde5uO5ySyiSEbf6kdOxEcfEuYCjgSAC20/ApTreXmibwV4MIaG3+tHbA9bOqVSZLHVbib9h+W3pwez89hf0yt1/7KrWXCxOTsvZ+zJaLf48R8bTq5crAyx/T7S6PzN8D3GXi07paB0W6KeTW9OhYT8r3rH0vqclB0u64UIcWw==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(36092001)(36840700001)(46966006)(336012)(316002)(70586007)(82310400003)(6666004)(2616005)(54906003)(70206006)(356005)(8676002)(36860700001)(8936002)(86362001)(47076005)(426003)(478600001)(83380400001)(186003)(5660300002)(110136005)(4326008)(42186006)(82740400003)(26005)(36756003)(36906005)(2906002)(7636003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 05:34:23.2421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d038e5-1813-4987-0793-08d8fb1921d0
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT044.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR07MB2482
X-Proofpoint-ORIG-GUID: KrYYvKz8SR9YAi99-3ciJMEOISqFUpS6
X-Proofpoint-GUID: KrYYvKz8SR9YAi99-3ciJMEOISqFUpS6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_03:2021-04-08,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090041
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Torrent PHY supports different input reference clock frequencies.
Register configurations will be different based on reference clock value.
Prepare driver to support register configs for multiple reference clocks.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 51 +++++++++++++++++------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 6eeb753fbb78..252920ea7fdf 100644
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
@@ -817,12 +825,12 @@ static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
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
@@ -1165,8 +1173,8 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 
 	switch (cdns_phy->ref_clk_rate) {
-	case REF_CLK_19_2MHZ:
-	case REF_CLK_25MHZ:
+	case CLK_19_2_MHZ:
+	case CLK_25_MHZ:
 		/* Valid Ref Clock Rate */
 		break;
 	default:
@@ -1198,11 +1206,11 @@ static int cdns_torrent_dp_init(struct phy *phy)
 
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
@@ -1228,10 +1236,10 @@ static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy,
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
 
@@ -1636,10 +1644,10 @@ static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
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
 
@@ -2270,6 +2278,7 @@ static int cdns_torrent_reset(struct cdns_torrent_phy *cdns_phy)
 static int cdns_torrent_clk(struct cdns_torrent_phy *cdns_phy)
 {
 	struct device *dev = cdns_phy->dev;
+	unsigned long ref_clk_rate;
 	int ret;
 
 	cdns_phy->clk = devm_clk_get(dev, "refclk");
@@ -2284,13 +2293,29 @@ static int cdns_torrent_clk(struct cdns_torrent_phy *cdns_phy)
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

