Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92A3403F15
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 20:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350136AbhIHS2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 14:28:06 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:4034 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235224AbhIHS1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 14:27:51 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 188D3ZCA016869;
        Wed, 8 Sep 2021 11:26:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=3CN0SdAMnHg/qTITFD2Vf7qCMq9VUhJg0yPtDcOFM1M=;
 b=MY4TcNw99ZdrnvYa4Si0LCFk8Gn+kuGcn3d9/XMjhky9owhMpKuCNaGvrw/J0MzTTEvQ
 y00Y5u8pAe3xf0QlpsMCe0V6apQ5Owk+6CtzNx1TVlAP/iLy4COH8VHyy/CRPSLyfmPF
 Ucu/5zKgV/cJnfbYmTUKNToKIwVJEfYteMQQt98fSuhUMoQIJHmel+yn+HeJcSDa+QCj
 WDDXPQe7teNB2yauwlO39kTYrQJOTA9kKjUKHCMfrz5/fQfXzgomebvl0JxvJA4ru/jV
 zWUVB+sAFgQcB7bBgxM5W2ZJS1sjuTmQBPEHBXjTSHbjMuF0acZBph7RQMizVc+LYV3P iQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3axcp9m759-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 11:26:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIQb3xH0TbDxWLRN6vsPOXTMI9bTvzK4WcAsI1DbezZAc9xAN1L5QrCmgxaj6FHsFZvnYlCfZD63yat0Lvz7X+eKzToqs4nv1TrAlnEjdQjK5P2vlZ5u/mI7yWtEzXbVWQpXXZUPwH6T9fR56e9Ij3Gbr2mrkxuGLXMFxTlThdK5Bep43GNQEo5N3CIYc3Hosr6nIxT9VPt0zMiZxbdLBhBlcH4TFl1mwMIhyMqSEFft+jKAdOlKkessuhpZaq486qkj4iATnq2Bb3nLPGVb8Bs+EvUq4ekL8T4VfzCXcVNyp7v6rpu8IIAeEIneuCXYLmjyNlEMYSOqH854fdJksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3CN0SdAMnHg/qTITFD2Vf7qCMq9VUhJg0yPtDcOFM1M=;
 b=H5XMpsnt40MyYt/vwodYNxhVJJJSvn1Lhyklnx6csbF2eODwZ35KTEBSrNmQAtX/hbKuwfpi+OFcvHPOvT/oFYaYwQIcw+Y27qEc0tMll96Xwm+1yrXnpQFg7oNI+Rh5HQehuzQy4Ev/Mfwmij/pFhhqpZNItlKbMuW64WxR/Pc5D43FTvid+o5tmwjaBEUslT9Gmnk+eJxdOfjQ6Y7diRn66nbhSSyF3E6jwUXkPgKgc73v4hN4dOfcYdGnoFECnWwA+m8JtHUaC54u0rd8TGXK3yzaPbefguSgvsTEOuiUvCk30YTAODAeNZJQPTPXWHRVWp4jGuocmXur2ZGKRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CN0SdAMnHg/qTITFD2Vf7qCMq9VUhJg0yPtDcOFM1M=;
 b=r0mnYkycxXFH+OBVM/sAj2mj6E+EK74xM14f9YW7mEOKub2ETIqfxX29nRY1TVz89Qce3JHemNDNnFkW3wdNN4qM7zq6z+bggBJ37kuTEl7c46W9AGf3qADDPJgdvPMoVQwPumehipNpbs1JJkRuLXT2QDtYtxu6+snE8oyGE4g=
Received: from MW4PR04CA0167.namprd04.prod.outlook.com (2603:10b6:303:85::22)
 by BYAPR07MB4391.namprd07.prod.outlook.com (2603:10b6:a02:cd::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 18:26:33 +0000
Received: from MW2NAM12FT022.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::f) by MW4PR04CA0167.outlook.office365.com
 (2603:10b6:303:85::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 18:26:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 MW2NAM12FT022.mail.protection.outlook.com (10.13.180.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 18:26:33 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 188IQUwI017985
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 14:26:31 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Sep 2021 20:26:29 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 8 Sep 2021 20:26:29 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 188IQTkh028409;
        Wed, 8 Sep 2021 20:26:29 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 188IQTrs028408;
        Wed, 8 Sep 2021 20:26:29 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH 1/5] phy: cadence-torrent: Migrate to clk_hw based registration and OF APIs
Date:   Wed, 8 Sep 2021 20:26:24 +0200
Message-ID: <20210908182628.28364-2-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210908182628.28364-1-sjakhade@cadence.com>
References: <20210908182628.28364-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4992063-4395-4e86-5b52-08d972f62f89
X-MS-TrafficTypeDiagnostic: BYAPR07MB4391:
X-Microsoft-Antispam-PRVS: <BYAPR07MB439159E5D615329AB0E30E57C5D49@BYAPR07MB4391.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:249;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dOjyoofIDEIuFWZ5qxWonnhECm90FaqWKEH8k/8duPWt24xhulwjqgwR4TwDbokksmpkG5DYnXdyDpso9IhdIp0L4rzn0CVZvgmsgYTn4Fj+bGEGJORIWvAKJktXvx2fpLuntE5JUrlYCNmbcCc4Lmu31YZkkqvEc7293klm27foXAteiZ6ArUBEprpJxdoOgA8/RWxfSjl1uBAfC24YEgpiF3cPzj9/Rtx3lhlh51/60DF+YfechNuLVzyJ1m2s19qRmF50CEF5/cunNcWts3HsXXUYWZh2dw3XUgufy1u86b8woOy77PrVHEtJYXhyvq5x0dxbdJONtQ03Rt9uv8tnNV/KssTJdEcYE79x8u88VdpJJOV49SGSMS0PSbB1aJQFTAB7p0+WZrTJ68tl5/QtpxhOD2nVF6AHFy0TPHF87rWQB37gMR2NZEfzlNfVp/8W5FBem4n6fW5KPGNFQ26PcKY2e+zcPYdJW+U2zCIXR2WVjQlaU7pJ71K/Z0+4PVWyJA25io0KAm/GMKvIO0H3x5fYHnx+H4LQrayjor1h/HdkDLrNc+UMIlW09NUuWI5RLchj5Mi7DGLJbV9S4VfmSsPVVj1xcuNJjh9sWWp+LIwWqnj7eHXX/JXNhjmHfewcSbLBHmMZqRXodX3hoyj8w8ABxuDUs/651G4vi6i7BGfIWdH2hdFNwIJN/VXI9DI+5wrtx6IWJLUm1EmRM+hZq7TKhrF0eBf7aVy+82wYN65PJUPTZ2HxQtUYZ3NHbJaWMEEABRwYZLoM8daL9piFRu//Ei5y1B++0k4ciq0=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(26005)(47076005)(70206006)(81166007)(36860700001)(356005)(336012)(70586007)(110136005)(54906003)(508600001)(2616005)(8936002)(82310400003)(42186006)(316002)(2906002)(36756003)(426003)(5660300002)(83380400001)(36906005)(86362001)(8676002)(4326008)(186003)(1076003)(6666004)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 18:26:33.3039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4992063-4395-4e86-5b52-08d972f62f89
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT022.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4391
X-Proofpoint-GUID: YKJQ3WAO587flapfbTa2a0k5mzZQcV-b
X-Proofpoint-ORIG-GUID: YKJQ3WAO587flapfbTa2a0k5mzZQcV-b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_06,2021-09-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=1 bulkscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109080115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use clk_hw based provider APIs to register clks.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 30 ++++++++++++++---------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 415ace64adc5..ecb1aa883c05 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -235,6 +235,8 @@
 #define PHY_PMA_CMN_CTRL2		0x0001U
 #define PHY_PMA_PLL_RAW_CTRL		0x0003U
 
+#define CDNS_TORRENT_OUTPUT_CLOCKS	1
+
 static const char * const clk_names[] = {
 	[CDNS_TORRENT_REFCLK_DRIVER] = "refclk-driver",
 };
@@ -333,8 +335,7 @@ struct cdns_torrent_phy {
 	struct regmap_field *phy_pma_pll_raw_ctrl;
 	struct regmap_field *phy_reset_ctrl;
 	struct regmap_field *phy_pcs_iso_link_ctrl_1[MAX_NUM_LANES];
-	struct clk *clks[CDNS_TORRENT_REFCLK_DRIVER + 1];
-	struct clk_onecell_data clk_data;
+	struct clk_hw_onecell_data *clk_hw_data;
 };
 
 enum phy_powerstate {
@@ -1659,8 +1660,9 @@ static int cdns_torrent_derived_refclk_register(struct cdns_torrent_phy *cdns_ph
 	const char *parent_name;
 	struct regmap *regmap;
 	char clk_name[100];
+	struct clk_hw *hw;
 	struct clk *clk;
-	int i;
+	int i, ret;
 
 	derived_refclk = devm_kzalloc(dev, sizeof(*derived_refclk), GFP_KERNEL);
 	if (!derived_refclk)
@@ -1706,11 +1708,12 @@ static int cdns_torrent_derived_refclk_register(struct cdns_torrent_phy *cdns_ph
 
 	derived_refclk->hw.init = init;
 
-	clk = devm_clk_register(dev, &derived_refclk->hw);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	hw = &derived_refclk->hw;
+	ret = devm_clk_hw_register(dev, hw);
+	if (ret)
+		return ret;
 
-	cdns_phy->clks[CDNS_TORRENT_REFCLK_DRIVER] = clk;
+	cdns_phy->clk_hw_data->hws[CDNS_TORRENT_REFCLK_DRIVER] = hw;
 
 	return 0;
 }
@@ -2188,18 +2191,23 @@ static int cdns_torrent_clk_register(struct cdns_torrent_phy *cdns_phy)
 {
 	struct device *dev = cdns_phy->dev;
 	struct device_node *node = dev->of_node;
+	struct clk_hw_onecell_data *data;
 	int ret;
 
+	data = devm_kzalloc(dev, struct_size(data, hws, CDNS_TORRENT_OUTPUT_CLOCKS), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->num = CDNS_TORRENT_OUTPUT_CLOCKS;
+	cdns_phy->clk_hw_data = data;
+
 	ret = cdns_torrent_derived_refclk_register(cdns_phy);
 	if (ret) {
 		dev_err(dev, "failed to register derived refclk\n");
 		return ret;
 	}
 
-	cdns_phy->clk_data.clks = cdns_phy->clks;
-	cdns_phy->clk_data.clk_num = CDNS_TORRENT_REFCLK_DRIVER + 1;
-
-	ret = of_clk_add_provider(node, of_clk_src_onecell_get, &cdns_phy->clk_data);
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, data);
 	if (ret) {
 		dev_err(dev, "Failed to add clock provider: %s\n", node->name);
 		return ret;
-- 
2.26.1

