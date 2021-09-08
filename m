Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C628B403F18
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 20:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350289AbhIHS2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 14:28:43 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:44352 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1349732AbhIHS1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 14:27:53 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 188IFI7b016872;
        Wed, 8 Sep 2021 11:26:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=pgYX0wpmWp7GH5f/5jQmVn8NQbB34wR4K6Sqbw7xq5c=;
 b=sjST+bPm0RVWeOe/70HGCBEjJPjvl9gz93rl+7xJMpf9xkCi9esvi6qLgQTwX/Uasj2M
 E5ZgkAZEqluzMJv204cMHeRdWaRJ0oh3I35TgZXxMP0e+x/QxL+C7W6Xfm5DCupgEgsx
 WPIYkYQp5q0idqV3FWiwrOs6NfPaQxdJZ5qZ9gxRGiK68/S/VEx8LzwLTeeqXTohNzGW
 KTcIumjspvJ0MgytkII+j3dQREnXZeM9ZQZz3XbL+WmuJQkJa0aP2hXGaepKjItsR+b1
 JdYe9SjAjdSWEvpBrC9RlfS8g/Dkdxog0N9g5RrdLDNdo+Dg4IVR8Tp0k1mji/3mDpXT 6w== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3axcp9m75a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 11:26:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibNoRSRMGTV8Csswm4HjDZKvF3c2Go7i2BjjYyCtgl34PDRM6m5DYV4HeCAFnhjrxbyAUF1VyHlPodVRmAbNVmqng2WVkM7ZVSbWmWeglMdDBZ+c+3VgkJVATvQoejmoFTFPRDT5jPmaENVAcNrs8bWa0HQrPfNJ9O1ZKcbqBj9MCclafdfmujWuvAP7+xydKnEongw16ggmVfLEjIW0A5zi9Us/aPVEjGgri0Ox951nwZqAmtOvGMQCP4NXqFp5MlRi+0Aa7ojT/BHSdGrgCAthxbWflNUTfs7ogy2TGCVC+/7dVjrgH/p7uJgjjY8UE9TgmQoItXCSh3oRailBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=pgYX0wpmWp7GH5f/5jQmVn8NQbB34wR4K6Sqbw7xq5c=;
 b=Hg3utsoX5ws8LdBau/3ShJl9fUHlKD7bmzewGYa8KCdySTVtVnQ29dbNcKLuCGwIwExbl+/+x0mt4CiI2QuaNJRp3hEfxPh2RzrMkH297zOwaWahOFSeqmDHHBybrDgfSmcRE0SJBI2Ls/BVvT5GnwhG/26hCtWqd9UtFzjKqVzLtYYRl5K1Zi/pqBWXnSHVhoufG7189r9tFMB2rPku7/OzwJdUgnFMAEPanNmxN05wXB932ibdktLeex0aD2sNQk74yzjbhGLNeGbymS9K5zG7kbXZfdzkgOqKy6wjLjDFqOUasDdNQapIawvFj1EFNSw+tbjmn1oW2edYyX+4ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgYX0wpmWp7GH5f/5jQmVn8NQbB34wR4K6Sqbw7xq5c=;
 b=zsoMQ1hPmaBhV+QfROKd2oKPFCyTO7jFSiDhLiRdHPSC1vAHhnTzyv7To4bOBQQGNuqUlB1ldus4BkfiYwkjwRYlLqZJP2BosIzZ/2g5eWL1c8cS5ADPNmrAHKo4qg7DdEQwmX6Z86hKTi3vOkbXwcCDOQwrcgV4NiLq0kIj1Nw=
Received: from BN6PR13CA0006.namprd13.prod.outlook.com (2603:10b6:404:10a::16)
 by MN2PR07MB6894.namprd07.prod.outlook.com (2603:10b6:208:1b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 8 Sep
 2021 18:26:34 +0000
Received: from BN8NAM12FT065.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::22) by BN6PR13CA0006.outlook.office365.com
 (2603:10b6:404:10a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend
 Transport; Wed, 8 Sep 2021 18:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT065.mail.protection.outlook.com (10.13.182.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.8 via Frontend Transport; Wed, 8 Sep 2021 18:26:33 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 188IQUwN017985
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 14:26:33 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Sep 2021 20:26:30 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 8 Sep 2021 20:26:30 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 8 Sep 2021 20:26:30 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 188IQUB3028421;
        Wed, 8 Sep 2021 20:26:30 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 188IQUK8028420;
        Wed, 8 Sep 2021 20:26:30 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH 4/5] phy: cadence-torrent: Add support for received reference clock output
Date:   Wed, 8 Sep 2021 20:26:27 +0200
Message-ID: <20210908182628.28364-5-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210908182628.28364-1-sjakhade@cadence.com>
References: <20210908182628.28364-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39c745c5-9595-4735-c6bc-08d972f62fd9
X-MS-TrafficTypeDiagnostic: MN2PR07MB6894:
X-Microsoft-Antispam-PRVS: <MN2PR07MB6894A833CCBC932F0E05298CC5D49@MN2PR07MB6894.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uHF+Zr6tBw4UhTm5wval/SYssiBVIR7O9vgbeFC+90N2ptHrmAOD7U3I/A4pHwqnlQSnQ4LSKJeqCF/VLI4me2k7HpvdP/YKmYCONk+TTG9R1orw49ZbMMlVPXiQQucgYmGhN996m6dTgXTXn0dQBQ8TUrN4cX/xdbeA4BrW3uMU2WDXWbohuLqeIc2FLIXtZkKlUQH0Qp/AOIAaZBz+ztmYUmqGutegFRUUV5Qy1P+sCtaUOky0WpV+gbZVPB1AeZLZAF/aEdG+nkSiv1yiqpMkYitZVu1IpMk0z3GvIV7RIpS5EBRyFkCGNIuzTCvAtX0t7Irx9d74Y+BowGktCT1wmIvHItw6Cfc7IUZ12407xXZXVvV5+ZrmeDcxO5sfZ7YlexLmgtdZ0KGQqyzZKL823QlrxK3OjIDIOe/HCwpnY/6LucfnftP+5eV4Hoa/B9SPVMIJuERJCs9AIeSHUzAjICDjb/dByVYVDfgXW/NhN4EIKs/fXy2gpm57Q8MQNs6DitmeX8EQNd+kUvp7UefUhYrO1/VhrgrOwKbOVKpAO9l/2Q46dStqxy0UEaKN7VQ9hukyJSqaA02ttx6PB/K4oHdu+OVJmj9kvMKOdXOPEH1DxcREYZnUUsxeBxK1DoH7QHSiVvvYfwGbJcNak586uN+dInhIyjGlIOWTEcYI0pWlhATqyI7P0aKvX/G1C14eK1XUVks1pJ4axO7PJ8elpMG/7rLVny8efZ3SUKEDYXxBT6RqLKjkleXGMfAYEXlnRufyVkqt4KIGYT27BNGGDIl7/WWrlDM5tFlSi7A=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(36092001)(36840700001)(46966006)(70586007)(70206006)(86362001)(5660300002)(8676002)(110136005)(82310400003)(186003)(356005)(82740400003)(36756003)(2616005)(54906003)(47076005)(6666004)(81166007)(4326008)(478600001)(36906005)(2906002)(336012)(426003)(42186006)(36860700001)(83380400001)(316002)(1076003)(26005)(8936002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 18:26:33.9668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c745c5-9595-4735-c6bc-08d972f62fd9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT065.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6894
X-Proofpoint-GUID: zDdtSAeGEJ5cKrG0zkHzIFo8BYbUSO6W
X-Proofpoint-ORIG-GUID: zDdtSAeGEJ5cKrG0zkHzIFo8BYbUSO6W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_06,2021-09-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109080115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Model the received reference clock as a next step to support reference
clock driver. When received refclk is selected to output on
cmn_refclk_p/m, this is the internal reference clock driven on the
pma_cmn_refclk_int.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 102 +++++++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 6dceb12e88c4..2c42a6690632 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -235,11 +235,12 @@
 #define PHY_PMA_CMN_CTRL2		0x0001U
 #define PHY_PMA_PLL_RAW_CTRL		0x0003U
 
-#define CDNS_TORRENT_OUTPUT_CLOCKS	2
+#define CDNS_TORRENT_OUTPUT_CLOCKS	3
 
 static const char * const clk_names[] = {
 	[CDNS_TORRENT_REFCLK_DRIVER] = "refclk-driver",
 	[CDNS_TORRENT_DERIVED_REFCLK] = "refclk-der",
+	[CDNS_TORRENT_RECEIVED_REFCLK] = "refclk-rec",
 };
 
 static const struct reg_field phy_pll_cfg =
@@ -343,6 +344,16 @@ struct cdns_torrent_derived_refclk {
 #define to_cdns_torrent_derived_refclk(_hw)	\
 			container_of(_hw, struct cdns_torrent_derived_refclk, hw)
 
+struct cdns_torrent_received_refclk {
+	struct clk_hw		hw;
+	struct regmap_field	*phy_pipe_cmn_ctrl1_0;
+	struct regmap_field	*cmn_cdiag_refclk_ovrd_4;
+	struct clk_init_data	clk_data;
+};
+
+#define to_cdns_torrent_received_refclk(_hw)	\
+			container_of(_hw, struct cdns_torrent_received_refclk, hw)
+
 struct cdns_reg_pairs {
 	u32 val;
 	u32 off;
@@ -1686,6 +1697,89 @@ static int cdns_torrent_derived_refclk_register(struct cdns_torrent_phy *cdns_ph
 	return 0;
 }
 
+static int cdns_torrent_received_refclk_enable(struct clk_hw *hw)
+{
+	struct cdns_torrent_received_refclk *received_refclk = to_cdns_torrent_received_refclk(hw);
+
+	regmap_field_write(received_refclk->phy_pipe_cmn_ctrl1_0, 1);
+
+	return 0;
+}
+
+static void cdns_torrent_received_refclk_disable(struct clk_hw *hw)
+{
+	struct cdns_torrent_received_refclk *received_refclk = to_cdns_torrent_received_refclk(hw);
+
+	regmap_field_write(received_refclk->phy_pipe_cmn_ctrl1_0, 0);
+}
+
+static int cdns_torrent_received_refclk_is_enabled(struct clk_hw *hw)
+{
+	struct cdns_torrent_received_refclk *received_refclk = to_cdns_torrent_received_refclk(hw);
+	int val, cmn_val;
+
+	regmap_field_read(received_refclk->phy_pipe_cmn_ctrl1_0, &val);
+	regmap_field_read(received_refclk->cmn_cdiag_refclk_ovrd_4, &cmn_val);
+
+	return val && !cmn_val;
+}
+
+static const struct clk_ops cdns_torrent_received_refclk_ops = {
+	.enable = cdns_torrent_received_refclk_enable,
+	.disable = cdns_torrent_received_refclk_disable,
+	.is_enabled = cdns_torrent_received_refclk_is_enabled,
+};
+
+static int cdns_torrent_received_refclk_register(struct cdns_torrent_phy *cdns_phy)
+{
+	struct cdns_torrent_received_refclk *received_refclk;
+	struct device *dev = cdns_phy->dev;
+	struct clk_init_data *init;
+	const char *parent_name;
+	char clk_name[100];
+	struct clk_hw *hw;
+	struct clk *clk;
+	int ret;
+
+	received_refclk = devm_kzalloc(dev, sizeof(*received_refclk), GFP_KERNEL);
+	if (!received_refclk)
+		return -ENOMEM;
+
+	snprintf(clk_name, sizeof(clk_name), "%s_%s", dev_name(dev),
+		 clk_names[CDNS_TORRENT_RECEIVED_REFCLK]);
+
+	clk = devm_clk_get_optional(dev, "phy_en_refclk");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "No parent clock for received_refclk\n");
+		return PTR_ERR(clk);
+	}
+
+	init = &received_refclk->clk_data;
+
+	if (clk) {
+		parent_name = __clk_get_name(clk);
+		init->parent_names = &parent_name;
+		init->num_parents = 1;
+	}
+	init->ops = &cdns_torrent_received_refclk_ops;
+	init->flags = 0;
+	init->name = clk_name;
+
+	received_refclk->phy_pipe_cmn_ctrl1_0 = cdns_phy->phy_pipe_cmn_ctrl1_0;
+	received_refclk->cmn_cdiag_refclk_ovrd_4 = cdns_phy->cmn_cdiag_refclk_ovrd_4;
+
+	received_refclk->hw.init = init;
+
+	hw = &received_refclk->hw;
+	ret = devm_clk_hw_register(dev, hw);
+	if (ret)
+		return ret;
+
+	cdns_phy->clk_hw_data->hws[CDNS_TORRENT_RECEIVED_REFCLK] = hw;
+
+	return 0;
+}
+
 static struct regmap *cdns_regmap_init(struct device *dev, void __iomem *base,
 				       u32 block_offset,
 				       u8 reg_offset_shift,
@@ -2191,6 +2285,12 @@ static int cdns_torrent_clk_register(struct cdns_torrent_phy *cdns_phy)
 		return ret;
 	}
 
+	ret = cdns_torrent_received_refclk_register(cdns_phy);
+	if (ret) {
+		dev_err(dev, "failed to register received refclk\n");
+		return ret;
+	}
+
 	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, data);
 	if (ret) {
 		dev_err(dev, "Failed to add clock provider: %s\n", node->name);
-- 
2.26.1

