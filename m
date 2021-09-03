Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58AC3FF9CF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 07:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbhICFCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 01:02:45 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:55448 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233470AbhICFCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 01:02:21 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 182NR3Nm011810;
        Thu, 2 Sep 2021 22:01:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=aUJXGyM7W4qgOw8NAGDOgXkdyHqgk1WrgB6VtVYSmF8=;
 b=tH+Qgt6xQzsiKT5cZxYV3JVvUOA03j4eh4xnkz6nrKfNsnmQzK7xJzL5mZ705xtUCDqi
 tXndjw/ZmyPucACWUo5hy1YZr9Ed2IeysjQ8+y0Uckkg2uB0PUcfrvIqHD6EFMSQ/0Pt
 uNKx7Xp5OO5jeLLe2zrLkvA8hQ4I0bGWgcE3apiJhKkx465chI8lUHmBLd8QWrsUoqGt
 HnTWsjr0YWp1pSAejM6TfZ8k3t6/rb6xGCiNkaKMFpFcjbYnCzG5kUzde3mD04QX9jvk
 6Y7yXGatkmNJ/EnARzetlTQ13Wqu8jc45OfbRw/Mkxr7FLJUxQQF2sepkJuDx0h6WJKB 2g== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3au8a18u48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 22:01:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFGfQXqcTVWp+CoiHaY0akS56ayZWrBqp9b+2oBWRwWB6yAatIMV7fp+rXns+D5II/jzClra2isKaB5Uh6VRb0BUJY1RVmj9U8X++Xl9Snfq/7qHVembo4rRZ0vi/to2oqlubd/o8Qr7R3oV0IsamYOrEilamNTjngPl85phWsrzmUhxAH+19WPBM+hetAG2agay5B4+FCJwp5gbKC0UTfgpZA1eL6WwgkEFiDwEr/p64M5TDS1SDYb4mRXGeolgmVZ6vedEtefKibm6gP0HkYiS5sANgTcK2axvZVW9jRRztHoBfUTcvlDIUGJg02mvNPnPv5G6NClXhZRcMqWnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUJXGyM7W4qgOw8NAGDOgXkdyHqgk1WrgB6VtVYSmF8=;
 b=FI+4dxUikj+HrQu+osUobKu5hbODqHmMqbpAOaxirpvLJ+H7Xbx3GN9HyGAb20Zl5FWEjDSdOTJYFq2+pmq5cO4+CE0T7o+bZOEMKe6Ga7bvoZjRWOdhXUII7XTdk/DNE8CyQ1HmjgU0MuJzUZMKKrX9x1dCVn5pDKEcj1V4Dim8RWIhra5C9lJQ++Bgxs9tLbWNT5BtohlcBDbJzF9CJHg0LW6a5eyj3atcUf9/PYW90B+XFP6CIXGIzoOa7XeFZvdL6BFMPUB7Lri/4yqgaUsk1uuyrNVY9qVmoCXaUZ7wG7v8DKhmqaEKAvf/P3kmrjb0oKmi3vouCKxQ4p/wiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUJXGyM7W4qgOw8NAGDOgXkdyHqgk1WrgB6VtVYSmF8=;
 b=3HOga7KpIjUOKUL5dNmICzxeWdzU1hXc/Sk4mjnhgRJXtya/6hGwWEmoxahqZUY9JWgwJUKlMO4AeoINXLCF9NWM7P7lUVWzFpYmPfypTYDJSjpUQIgHTrz4GySZOXk75EyDNlXCbXAyvpxTDTJtdYJSNbzVpds9ZKLTl9h26vo=
Received: from BN9PR03CA0743.namprd03.prod.outlook.com (2603:10b6:408:110::28)
 by BYAPR07MB7959.namprd07.prod.outlook.com (2603:10b6:a03:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Fri, 3 Sep
 2021 05:01:04 +0000
Received: from BN8NAM12FT006.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::67) by BN9PR03CA0743.outlook.office365.com
 (2603:10b6:408:110::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Fri, 3 Sep 2021 05:01:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT006.mail.protection.outlook.com (10.13.183.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Fri, 3 Sep 2021 05:01:04 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 18350ufc020399
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Sep 2021 22:01:03 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Sep 2021 07:00:56 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 3 Sep 2021 07:00:56 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18350ucR025725;
        Fri, 3 Sep 2021 07:00:56 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18350uZb025724;
        Fri, 3 Sep 2021 07:00:56 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 14/14] phy: cadence: Sierra: Add support for derived reference clock output
Date:   Fri, 3 Sep 2021 07:00:54 +0200
Message-ID: <20210903050054.25627-15-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210903050054.25627-1-sjakhade@cadence.com>
References: <20210903050054.25627-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a845b0f9-59b9-4613-f479-08d96e97d530
X-MS-TrafficTypeDiagnostic: BYAPR07MB7959:
X-Microsoft-Antispam-PRVS: <BYAPR07MB7959B301AB27B7D92F74940AC5CF9@BYAPR07MB7959.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:586;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6CzfvXkt077rriT7cqGsqm7Oxx0TNeCdtWxNnojfpMPwGp+P9On7JbiBnc3ndF78t5fH9X+Y5utqoKZlD1hZLP5SaGQSvizjAlb0kncgcmYRqO8i4+6/PO+kF4YjyoDQUHltOqQ0RS0r4AdRmF+BWeQiS1KKcFVvJrdRTPg9ls75uwdPMourdpXYre3Y5rDAEHWcxiY9lJ5mc7DbJlt48nKjbkWW/OsOfFX/2bIMWBOcJMQ7aOFDJTgjSQwJmwQJ13u2MUnJ11p+71jWSq/qMoFbROm7JFOHxVYdw+D84y8FjL+Ci0Iq/3UAmlTyQIysvnil62hw/SG4iBLDmZbVYG62yM4wl7G3dzseKhjZecOna4VdYqUvNGa+0gthK6knoyfy91NvcvKsbbc6tWpMpClrZLfdvRQvys7VWyq0AZqghBuMPJKgAjcEBu6jfRXpJ72PEq/wcIuzKviwuXyfBEdnj2G5slEXmTjwMNjifXHdV1RqRky2jh6qT5UezwEtd1o6yX6Cw2pceUQ9bODxHmYRxNRm0BA10Dq7Br9EfNN1+sIqCYSOysHMzwC8aD+d84VXsNwDFsn3TiBd8kyS3gtTpwXWdmdA5P/S27NKeMIl+qT7z/77tKOwzbdf+MTwBrPexkxvj790GUGFveJhywL+sFcUoQufFsm2kFXqTVCOYTlZN72AklkXFKhqDBucSkl2T6FCvZk5ZDJqmI5Yfz+DFO/6k+ROuByzCJSrDDzNY4IyNCgSknLue2jYktX5dWD6oHJm2i5uJevHof5Hkw==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(36092001)(36840700001)(46966006)(316002)(110136005)(42186006)(2906002)(54906003)(336012)(86362001)(36756003)(36906005)(2616005)(26005)(7636003)(5660300002)(356005)(70206006)(8936002)(70586007)(82740400003)(36860700001)(83380400001)(82310400003)(478600001)(426003)(8676002)(4326008)(1076003)(47076005)(186003)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 05:01:04.4148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a845b0f9-59b9-4613-f479-08d96e97d530
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT006.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB7959
X-Proofpoint-ORIG-GUID: zRgnY7-ZebhOABZrBTJCYgRidBFcb3Zb
X-Proofpoint-GUID: zRgnY7-ZebhOABZrBTJCYgRidBFcb3Zb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-03_01,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109030030
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sierra has derived differential reference clock output which is sourced
after the spread spectrum generation has been added. Add support to drive
derived reference clock out of serdes. Model this derived clock as a
"clock" so that platforms using this can enable it.

Sierra Main LC VCO PLL divider 1 clock is programmed to output 100MHz
clock output.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 109 ++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 9e9d26a9259d..c03e65926954 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -34,6 +34,7 @@
 #define SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG		0x49
 #define SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG		0x4A
 #define SIERRA_CMN_PLLLC_LOCK_CNTSTART_PREG		0x4B
+#define SIERRA_CMN_PLLLC_CLK1_PREG			0x4D
 #define SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG		0x4F
 #define SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG		0x50
 #define SIERRA_CMN_PLLLC_DSMCORR_PREG			0x51
@@ -203,7 +204,7 @@
 #define SIERRA_MAX_LANES				16
 #define PLL_LOCK_TIME					100000
 
-#define CDNS_SIERRA_OUTPUT_CLOCKS			2
+#define CDNS_SIERRA_OUTPUT_CLOCKS			3
 #define CDNS_SIERRA_INPUT_CLOCKS			5
 enum cdns_sierra_clock_input {
 	PHY_CLK,
@@ -226,10 +227,15 @@ static const struct reg_field pllctrl_lock =
 				REG_FIELD(SIERRA_PLLCTRL_STATUS_PREG, 0, 0);
 static const struct reg_field phy_iso_link_ctrl_1 =
 				REG_FIELD(SIERRA_PHY_ISO_LINK_CTRL, 1, 1);
+static const struct reg_field cmn_plllc_clk1outdiv_preg =
+				REG_FIELD(SIERRA_CMN_PLLLC_CLK1_PREG, 0, 6);
+static const struct reg_field cmn_plllc_clk1_en_preg =
+				REG_FIELD(SIERRA_CMN_PLLLC_CLK1_PREG, 12, 12);
 
 static const char * const clk_names[] = {
 	[CDNS_SIERRA_PLL_CMNLC] = "pll_cmnlc",
 	[CDNS_SIERRA_PLL_CMNLC1] = "pll_cmnlc1",
+	[CDNS_SIERRA_DERIVED_REFCLK] = "refclk_der",
 };
 
 enum cdns_sierra_cmn_plllc {
@@ -277,6 +283,16 @@ static u32 cdns_sierra_pll_mux_table[][SIERRA_NUM_CMN_PLLC_PARENTS] = {
 	[CMN_PLLLC1] = { 1, 0 },
 };
 
+struct cdns_sierra_derived_refclk {
+	struct clk_hw           hw;
+	struct regmap_field     *cmn_plllc_clk1outdiv_preg;
+	struct regmap_field     *cmn_plllc_clk1_en_preg;
+	struct clk_init_data	clk_data;
+};
+
+#define to_cdns_sierra_derived_refclk(_hw)	\
+			container_of(_hw, struct cdns_sierra_derived_refclk, hw)
+
 enum cdns_sierra_phy_type {
 	TYPE_NONE,
 	TYPE_PCIE,
@@ -766,6 +782,91 @@ static int cdns_sierra_phy_register_pll_mux(struct cdns_sierra_phy *sp)
 	return 0;
 }
 
+static int cdns_sierra_derived_refclk_enable(struct clk_hw *hw)
+{
+	struct cdns_sierra_derived_refclk *derived_refclk = to_cdns_sierra_derived_refclk(hw);
+
+	regmap_field_write(derived_refclk->cmn_plllc_clk1_en_preg, 0x1);
+
+	/* Programming to get 100Mhz clock output in ref_der_clk_out 5GHz VCO/50 = 100MHz */
+	regmap_field_write(derived_refclk->cmn_plllc_clk1outdiv_preg, 0x2E);
+
+	return 0;
+}
+
+static void cdns_sierra_derived_refclk_disable(struct clk_hw *hw)
+{
+	struct cdns_sierra_derived_refclk *derived_refclk = to_cdns_sierra_derived_refclk(hw);
+
+	regmap_field_write(derived_refclk->cmn_plllc_clk1_en_preg, 0);
+}
+
+static int cdns_sierra_derived_refclk_is_enabled(struct clk_hw *hw)
+{
+	struct cdns_sierra_derived_refclk *derived_refclk = to_cdns_sierra_derived_refclk(hw);
+	int val;
+
+	regmap_field_read(derived_refclk->cmn_plllc_clk1_en_preg, &val);
+
+	return !!val;
+}
+
+static const struct clk_ops cdns_sierra_derived_refclk_ops = {
+	.enable = cdns_sierra_derived_refclk_enable,
+	.disable = cdns_sierra_derived_refclk_disable,
+	.is_enabled = cdns_sierra_derived_refclk_is_enabled,
+};
+
+static int cdns_sierra_derived_refclk_register(struct cdns_sierra_phy *sp)
+{
+	struct cdns_sierra_derived_refclk *derived_refclk;
+	struct device *dev = sp->dev;
+	struct regmap_field *field;
+	struct clk_init_data *init;
+	struct regmap *regmap;
+	char clk_name[100];
+	struct clk *clk;
+
+	derived_refclk = devm_kzalloc(dev, sizeof(*derived_refclk), GFP_KERNEL);
+	if (!derived_refclk)
+		return -ENOMEM;
+
+	snprintf(clk_name, sizeof(clk_name), "%s_%s", dev_name(dev),
+		 clk_names[CDNS_SIERRA_DERIVED_REFCLK]);
+
+	init = &derived_refclk->clk_data;
+
+	init->ops = &cdns_sierra_derived_refclk_ops;
+	init->flags = 0;
+	init->name = clk_name;
+
+	regmap = sp->regmap_common_cdb;
+
+	field = devm_regmap_field_alloc(dev, regmap, cmn_plllc_clk1outdiv_preg);
+	if (IS_ERR(field)) {
+		dev_err(dev, "cmn_plllc_clk1outdiv_preg reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	derived_refclk->cmn_plllc_clk1outdiv_preg = field;
+
+	field = devm_regmap_field_alloc(dev, regmap, cmn_plllc_clk1_en_preg);
+	if (IS_ERR(field)) {
+		dev_err(dev, "cmn_plllc_clk1_en_preg reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	derived_refclk->cmn_plllc_clk1_en_preg = field;
+
+	derived_refclk->hw.init = init;
+
+	clk = devm_clk_register(dev, &derived_refclk->hw);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	sp->output_clks[CDNS_SIERRA_DERIVED_REFCLK] = clk;
+
+	return 0;
+}
+
 static void cdns_sierra_clk_unregister(struct cdns_sierra_phy *sp)
 {
 	struct device *dev = sp->dev;
@@ -786,6 +887,12 @@ static int cdns_sierra_clk_register(struct cdns_sierra_phy *sp)
 		return ret;
 	}
 
+	ret = cdns_sierra_derived_refclk_register(sp);
+	if (ret) {
+		dev_err(dev, "Failed to register derived refclk\n");
+		return ret;
+	}
+
 	sp->clk_data.clks = sp->output_clks;
 	sp->clk_data.clk_num = CDNS_SIERRA_OUTPUT_CLOCKS;
 	ret = of_clk_add_provider(node, of_clk_src_onecell_get, &sp->clk_data);
-- 
2.26.1

