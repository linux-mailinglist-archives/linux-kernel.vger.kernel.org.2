Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BF9437B65
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbhJVRGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:06:04 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:30172 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233714AbhJVRFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:05:25 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MEhEBn008220;
        Fri, 22 Oct 2021 10:02:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=GuPW9/WzC1M9tYeEWlvIp7AF3nu9SPdYehR9sfaZgdg=;
 b=aWwEjCmACiM1bps9qQVZsTXKIskkNwiH/M9SL05rSeaSsDpJPL7SHd4TrgoHwTqsFj0T
 UVod3fw1sW2reEAEW4Tuu/kAhM2UCOJDq0pg38xmTK6bfyO2sKeyOZ5/mARXg7GB2GNF
 wfAUKQ/cGlzk+chC7fpGUQ73xGih1Biq0k6XBuwJMviZRebzRvNx8+OK0oHzL4QEb/rO
 2QfkDJt930sxtvq6TTDBUAQqUwbEO+8HBF7WY3XPvETUR/sw1ZzEf68TLlDfQYC8w9m6
 eAAY3CAs7szh9RvdHiW6EHOLXpBwyzbLjg407Y9Owscso8NqO2kuxjxCpajJQMexxW0O Zw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3buxg0rm52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 10:02:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8nIyQPx8iNq37LAH1/9k2JxXD+80udtWSYKYDrHxIX5wm5Rfyu3MfFhJbmIm32lcN4Eouo1zs2LHdER/ZuiSFeNJapxDTYQLe8SJ/g1PRiSRLyX1JMc7w3YigCuDhNQms48jG7Bs40VJwmXI6MvWIeN8ukM7VWDHi0E4oqzmWrf56fLlVHSBjIJbJXLk029XCWLUMqs1Fijehb4JKsMxOspGK6k47QI9EmnQGXH3KFj/jxcAitpY0ZOTCQRrXnuk+QF9r5ninVZoGQV1kT6ewuBjmiCsNOYJsnACKqfyVQoi+6uODLEsUOiYwdMJNx3hbKpeiaxY3OueK5YfATmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuPW9/WzC1M9tYeEWlvIp7AF3nu9SPdYehR9sfaZgdg=;
 b=RP5LdVufpbAfCj+JRYH6edZIZkMNelvpx42mjdZcNlZ4st3Bbi324YfC/8o2jY+/5FXteC2FJnydFIFhi6sRqd49HnCTCDwBgceOeOsp+550NVmEJjRwHM3JNKxw+pc/N0ohbmxDmkWTnXyEGJHh+kLZ0Ft/vkhlHuC9SjVyDPGlaWnaAgFvR47BU6JsPvVbwex5aWco5gGvSHZpmGGr3l/vmPcHnusJjmGpqsxk1CoNJ4BvGl2tBL3fgoAYuaa4/abiBllehhX3WwTUs03zxPvG1bNz6NOwV3sH5JPqh+NU0sLiodV/4OIusOBStIGl+GIcEdIqXR5DU0dG/yOtWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuPW9/WzC1M9tYeEWlvIp7AF3nu9SPdYehR9sfaZgdg=;
 b=iVZvu7uBq9fkmOZgw0/PfqPVWAMm59a++s50xtZLhkMCTIOrLDG3VJdI0sIHAEjijHQCrWdpmr4P32Hgw2Mu0qiVJ4NSc56cy8v14QitRaeqWbted5iuFJm1xqwFheItuKbymnViI/jdL7c2oq/Doe/T57Jm5dYfWlfRfY31QqE=
Received: from BN8PR12CA0024.namprd12.prod.outlook.com (2603:10b6:408:60::37)
 by DM8PR07MB8774.namprd07.prod.outlook.com (2603:10b6:8:21::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Fri, 22 Oct
 2021 17:02:55 +0000
Received: from BN8NAM12FT042.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::22) by BN8PR12CA0024.outlook.office365.com
 (2603:10b6:408:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Fri, 22 Oct 2021 17:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT042.mail.protection.outlook.com (10.13.182.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.8 via Frontend Transport; Fri, 22 Oct 2021 17:02:54 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2iNS008564
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 10:02:54 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Oct 2021 19:02:39 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 22 Oct 2021 19:02:39 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2dHZ018949;
        Fri, 22 Oct 2021 19:02:39 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 19MH2df2018948;
        Fri, 22 Oct 2021 19:02:39 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v3 15/15] phy: cadence: Sierra: Add support for derived reference clock output
Date:   Fri, 22 Oct 2021 19:02:36 +0200
Message-ID: <20211022170236.18839-16-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211022170236.18839-1-sjakhade@cadence.com>
References: <20211022170236.18839-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e90dbd78-7416-49f1-52c9-08d9957dca86
X-MS-TrafficTypeDiagnostic: DM8PR07MB8774:
X-Microsoft-Antispam-PRVS: <DM8PR07MB8774BD6B6AF09EADFF0B28A2C5809@DM8PR07MB8774.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:586;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8P4E3DhZ+AqDagPgaddE1R79MHRmqnAfN+zvk6/0n6RCHiHPQKtRXdUsKecOLLqx+w5dQ2lZa0tBh2T2bsvJtNEYuQM7nVuHjnwEU1JbFtyZay1R9H/8ipzpQXV+08EFmsdsWm3B5aInZVJTFUVno7Lso0Nyf9qXtpu1OJ902Hj/i9Okgd3EhGToeByoUwjZbLZyafOaSHCK+ocl7T20XD5M7Ylap5VvMoULQfQ9CDk4N7X6u6KEaUZQunaATtzy1Vut2vKKxihB4xfNjSGgKL0O7js48jmdjX/xEkQyXR9/gYGYu8Rz1qRxTLRBmCXXRWh+r7yHiuU0SCfORJecBLrlzw6BgUp6/tteCSC7+0XxHHRsa+bV+obkLQDVqPX+Kbwzw951vmOcl7GJEAesYSKZJ1idaTd03k0PirlHEBf1+DSCCAXqfLLSdxWFs0/Hdfea6SFu8lpzDfw27LS1GqzGzGEKFhfo5SxUSZ6eFwHhlL2yKzEad2YGaS5KTVKEtSFy+2S8XCbrK3m4KVpFSbahPpW8KR2HzgaH5XuMDeeoBmi+Wv2PqQZWybrAol0VxDgTlcZhqrcI7eXvyrloq6V9gVByNF5YYWn0GtIORpUxW+HUH6aWLP9IW9A3QYQawmYNc+Dk+YRZ2Sz1syloFbVjiBrNT+pt5TMQajhRau2TNHC8qOKHz3hhAXp8ieprIwlYAbenujQpJWmiw0LQqPTTjkARdODuSGmaRBDkIPyziRc3cHmPWFBHZqsTct+qvJRCtcaJPH/K/BPSu3dtHQ==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(7636003)(2616005)(1076003)(42186006)(426003)(2906002)(83380400001)(6666004)(316002)(70586007)(70206006)(4326008)(26005)(508600001)(36756003)(8676002)(336012)(47076005)(356005)(86362001)(36860700001)(5660300002)(186003)(54906003)(110136005)(82310400003)(8936002)(36906005)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 17:02:54.9457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e90dbd78-7416-49f1-52c9-08d9957dca86
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT042.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR07MB8774
X-Proofpoint-GUID: hwMGsw6qdRNMI8Cwtl6jBofnuxbHfyNt
X-Proofpoint-ORIG-GUID: hwMGsw6qdRNMI8Cwtl6jBofnuxbHfyNt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_04,2021-10-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110220099
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
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 109 ++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 0deb627845b1..626d2d702f6c 100644
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

