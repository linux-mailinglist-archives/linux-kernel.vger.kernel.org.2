Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141893594B2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbhDIFfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:35:44 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:11632 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233324AbhDIFfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:35:04 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1395XZ2P028234;
        Thu, 8 Apr 2021 22:34:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=isBPEcNdFR/SaGg8fnMe2U0TCb9PnZ6oMjuV5jR3evw=;
 b=YDTDRelErOZGAzoAYyjjZpMLsqDhDXDigiee2iLQWfHMTtaS5Z9bjHYEK4b0oSedaLIQ
 L/RgUqX3NHAqQnfiNbnTSgozBV5D1f/hlRtAyV/8ZqqYPymlriCBwGWCFJLD7vuWi0FW
 tLcSzTtcVEB8bOUfJxe1pNTKhpzVDfCmS9BwB73xW+pZBrCs0Zp8rjm0h6Am25d8ujpe
 LEw7nzCOWpFiUvspZdfYeIZjPvVKIk5armNNPB4/p+JiqvcP6jV/bEzRKHK7rTrzHL+I
 nR+Qamo5+oNDaizR6RLMxoPxPE30LVNK6CT/uypWhCfOGvfAmqRcTTqgkI3kHsuKisK2 9Q== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2057.outbound.protection.outlook.com [104.47.37.57])
        by mx0a-0014ca01.pphosted.com with ESMTP id 37t6ns1sr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 22:34:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tml+/EgHF1vb3IC3XFzhNjVRg4WeAHcEGdvEU5bAmiY/mGDNI5+Q6dWBFAH4qUKPs1KZQ1IuSeqIE1afaEXfRIsygO2Vy2l8HpcI5NHRqP9hAxYaYcXYvN4l54A4LduKXT0SoSU4ExdCjBqKOPU3ggkbBpm7dYgdIEKvfN1l34XSSb1LnX9LS2xGNP9c0wdqVKHrcr94g3byEeyQgrvd8/KQOxr0omaTk7xBQPa1pMqL9GdGWXNJD/bP4XFii3G5opR815m7zC62myaXDrpSWpF6Lkw72nm77pbwzYmEe9PYSwOGRV/k2Kt66JDAkjzpPdQEV8A7eOPj7W3OmJkidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isBPEcNdFR/SaGg8fnMe2U0TCb9PnZ6oMjuV5jR3evw=;
 b=hscuqt7Kj1xD/kRn4B+8vky/YrDiPqMDLA2ses2WZlevQniNukSMH9HcNH21BFKb/af+ktLkbGwSJ7nyzvUyUKl4FxSppuBMdNXAl3s7hJm3mHt2gYThBdKJaMxSxyuAzK6nQ6edQh0NCEoVAo6DxWxvSc2KWecnJWvOLUExgY6sAq2k5C2xVuQOz+S73IXjRzByyO/tVziIYt93JJVOGNeWcR45QE0ZtEg6Mdrh+GQ4mA2nR4GIJQ5Ky1kAuAj7Hirnri744+oZRz0abcT1qxtpEk5qE2D1QTypOkq55SkxLRLN3ba3leEj01xaSvxssLK/s0hC5aZyyg6PIowlJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isBPEcNdFR/SaGg8fnMe2U0TCb9PnZ6oMjuV5jR3evw=;
 b=GTn66BpHKmAeERE4JIPINoV6iKkgvP3kXmqJ3POpd7YHrU07Ed3egXhRaaNDsvxUkDg2Y4vYwD3g1zOG/HXIqd10OuJhEDSZfCKKuLIYlXgvokQYllf90xe6fxgujRnXtBIkvvsTxoUo14uM1aaJzfnkMOPJcVTNWMeeW5OmNeA=
Received: from DM6PR06CA0052.namprd06.prod.outlook.com (2603:10b6:5:54::29) by
 DM5PR07MB3577.namprd07.prod.outlook.com (2603:10b6:4:67::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21; Fri, 9 Apr 2021 05:34:26 +0000
Received: from DM6NAM12FT017.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::10) by DM6PR06CA0052.outlook.office365.com
 (2603:10b6:5:54::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Fri, 9 Apr 2021 05:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 DM6NAM12FT017.mail.protection.outlook.com (10.13.178.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.6 via Frontend Transport; Fri, 9 Apr 2021 05:34:25 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YJ5X032749
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
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YJri027852;
        Fri, 9 Apr 2021 07:34:19 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1395YJ7G027851;
        Fri, 9 Apr 2021 07:34:19 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 06/14] phy: cadence-torrent: Reorder functions to avoid function declarations
Date:   Fri, 9 Apr 2021 07:34:08 +0200
Message-ID: <1617946456-27773-7-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
References: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e61d3e1a-c8c8-4d55-e8cb-08d8fb192363
X-MS-TrafficTypeDiagnostic: DM5PR07MB3577:
X-Microsoft-Antispam-PRVS: <DM5PR07MB3577DA9AACF4E95015608B14C5739@DM5PR07MB3577.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 021NJToZ1dGtunKQLtbNd+DUzAIHZGjVVEmIx4vIL98tlquDYhYuWja4u8MJQII8vJltx4rkSfZZ3kb5lqof8dAPhmQD2/vDWQAehjx37MlxRztUYmz4ZtcRyGmGAfx9OB8qtk1NBF8ZEyvjknAYT0HPj1c6yHz8jnQDGIjfN09VGm1hSe9MJhBj906UAcGx/4iIWqYsyfYbG+YC64yuVG28DTbkxrU9/O7FqUYIC+0MVmtWwtsCUJiPRt/38jHr5oWhQQTDXH26cDcaykGnOdFQUFmhv0iC5TAgF9RzVTr0KX3KAUBeHrQrQxQYOgODUDW3kT3EY5UztTKlgHwTG7h0SPDXNAicxVZZyjyNx6CHAim/XMxJoe9KEvPZ4jUVXyAzoc9Rz4kmQmrC7TtD/M1qTMGYJIjukohTrZVR27lQqV1lLQbs2PoYzEoflTmOtr3o/W/D+VGZ34NITPLa6VruXxB7dW3iczgzmw2Y4AdwEFvvSpZ7NJsCvREUpSUFfX9heOXcV/g0qRZjaje98D17CmKWB8JjRjSGnvm0hGT5m2eLpvO8J6Q+dUPsMBPY877F46RvNDAPmVM6dEFFfO/owQJXeS5lxvMtS5OKEjbOGD/79YIqu42vluoOnKVldA+6oAWvHE+TQqF+xiZYbXLgRP7OFSruchpNP8y+cnUo2jmJ9MIYFMfIegwjiSViylSMqtqG4mvq4FCPASvyvA==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(36092001)(36840700001)(46966006)(8936002)(42186006)(110136005)(36906005)(316002)(86362001)(54906003)(8676002)(30864003)(2906002)(26005)(186003)(2616005)(6666004)(5660300002)(336012)(426003)(70206006)(70586007)(82740400003)(356005)(7636003)(36860700001)(36756003)(4326008)(478600001)(47076005)(83380400001)(82310400003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 05:34:25.7870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e61d3e1a-c8c8-4d55-e8cb-08d8fb192363
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT017.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3577
X-Proofpoint-ORIG-GUID: 3a9RkHlmgXPMF2k2rhElTeS2QM8_vkHC
X-Proofpoint-GUID: 3a9RkHlmgXPMF2k2rhElTeS2QM8_vkHC
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

Reorder some functions to avoid function declarations. Also, remove
unnecessary line breaks while moving. No functional change.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 305 +++++++++-------------
 1 file changed, 121 insertions(+), 184 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 4ec5909f192c..396c3810a69d 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -342,9 +342,6 @@ struct cdns_torrent_derived_refclk {
 			container_of(_hw, struct cdns_torrent_derived_refclk, hw)
 
 static
-void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
-					     u32 rate, bool ssc);
-static
 void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy,
 					   u32 rate, bool ssc);
 
@@ -579,6 +576,127 @@ static const struct coefficients vltg_coeff[4][4] = {
 	}
 };
 
+/*
+ * Set registers responsible for enabling and configuring SSC, with second and
+ * third register values provided by parameters.
+ */
+static
+void cdns_torrent_dp_enable_ssc_19_2mhz(struct cdns_torrent_phy *cdns_phy,
+					u32 ctrl2_val, u32 ctrl3_val)
+{
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
+
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x0001);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, ctrl2_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, ctrl3_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL4_M0, 0x0003);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x0001);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, ctrl2_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, ctrl3_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL4_M0, 0x0003);
+}
+
+static
+void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
+					     u32 rate, bool ssc)
+{
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
+
+	/* Assumes 19.2 MHz refclock */
+	switch (rate) {
+	/* Setting VCO for 10.8GHz */
+	case 2700:
+	case 5400:
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
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x033A, 0x006A);
+		break;
+	/* Setting VCO for 9.72GHz */
+	case 1620:
+	case 2430:
+	case 3240:
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
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x05DD, 0x0069);
+		break;
+	/* Setting VCO for 8.64GHz */
+	case 2160:
+	case 4320:
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
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x0536, 0x0069);
+		break;
+	/* Setting VCO for 8.1GHz */
+	case 8100:
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
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x04D7, 0x006A);
+		break;
+	}
+
+	if (ssc) {
+		cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_PLLCNT_START, 0x025E);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_PLLCNT_THR, 0x0005);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_PLLCNT_START, 0x025E);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_THR, 0x0005);
+	} else {
+		cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_PLLCNT_START, 0x0260);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_PLLCNT_START, 0x0260);
+		/* Set reset register values to disable SSC */
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
+	}
+
+	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_REFCNT_START, 0x0099);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_PLLCNT_START, 0x0099);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_REFCNT_START, 0x0099);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_START, 0x0099);
+}
+
 /*
  * Enable or disable PLL for selected lanes.
  */
@@ -1211,187 +1329,6 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	return ret;
 }
 
-/*
- * Set registers responsible for enabling and configuring SSC, with second and
- * third register values provided by parameters.
- */
-static
-void cdns_torrent_dp_enable_ssc_19_2mhz(struct cdns_torrent_phy *cdns_phy,
-					u32 ctrl2_val, u32 ctrl3_val)
-{
-	struct regmap *regmap = cdns_phy->regmap_common_cdb;
-
-	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x0001);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, ctrl2_val);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, ctrl3_val);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL4_M0, 0x0003);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x0001);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, ctrl2_val);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, ctrl3_val);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL4_M0, 0x0003);
-}
-
-static
-void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
-					     u32 rate, bool ssc)
-{
-	struct regmap *regmap = cdns_phy->regmap_common_cdb;
-
-	/* Assumes 19.2 MHz refclock */
-	switch (rate) {
-	/* Setting VCO for 10.8GHz */
-	case 2700:
-	case 5400:
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
-		if (ssc)
-			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x033A,
-							   0x006A);
-		break;
-	/* Setting VCO for 9.72GHz */
-	case 1620:
-	case 2430:
-	case 3240:
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
-		if (ssc)
-			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x05DD,
-							   0x0069);
-		break;
-	/* Setting VCO for 8.64GHz */
-	case 2160:
-	case 4320:
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
-		if (ssc)
-			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x0536,
-							   0x0069);
-		break;
-	/* Setting VCO for 8.1GHz */
-	case 8100:
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
-		if (ssc)
-			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x04D7,
-							   0x006A);
-		break;
-	}
-
-	if (ssc) {
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x025E);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0005);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x025E);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0005);
-	} else {
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x0260);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x0260);
-		/* Set reset register values to disable SSC */
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
-	}
-
-	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_REFCNT_START, 0x0099);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_PLLCNT_START, 0x0099);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_REFCNT_START, 0x0099);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_START, 0x0099);
-}
-
 /*
  * Set registers responsible for enabling and configuring SSC, with second
  * register value provided by a parameter.
-- 
2.26.1

