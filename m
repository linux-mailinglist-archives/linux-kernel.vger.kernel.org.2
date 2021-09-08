Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693A64039E7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351794AbhIHMcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:32:08 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:50796 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348875AbhIHMbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:31:05 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1886dluF030522;
        Wed, 8 Sep 2021 05:29:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=aUJXGyM7W4qgOw8NAGDOgXkdyHqgk1WrgB6VtVYSmF8=;
 b=pdA3wVa3eUEnmo/n9ucfViQ+Pt3H1R0fJ+XQ6rQI+eL+i+CH2HTUzbBOZhlv8gpstLgr
 1PUZYxCUEEhg6bGdWoFOEQ5jPMeCq5+8DMAWP/wT+9JrLwol8jqUK+s+aIYd9/N8TcPS
 RC4UdvyS66U6VxyyXyS4kW/B+Pt5rIsVU/nPU/qHP0WitvzBKnMGcnJ/Z1tKZIFFAuJV
 MH2oJvH4wwXWCYWB7bUqFpRsV9VYzHTMOlbrRZ02HqABzzEzhFq3fJuwQMc0TClrmfum
 u5q3jsMlBGslS3Uosz1ETOIQ8El+ZeV8IR3ULuZvPjhpkTlZ6xRTjIdZFOIYxG4CQwOT Nw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3axcn5b0xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 05:29:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPoBUyGS52igc4dJU/aQnm8AfZ7FgaFWYJj3daBiXwU5aERa/+bhQRbOGwEB5RpTE/P2wQhT0gbhaB8Ewkkt1HM6L+u3vTqTKE6QGvuQ2vBffn/L2gEVf5xfAwCoyIGpK8DlNCvA4yIcDbG3rxIpgcZ8GbH+N27ZSQbXY43iYxjpPaJy/uzdaQKjzCdL0MkNHOrswOTGqcYfbfmuyt118K8zF+ipUxSCg3aU23he15fm8rgkgXCw43hLn9E9XTy+m+m5JJjmgh/7zRqtQZooOMtes8rC2Tu2yKHoWDDAgXL2MWEUwqW/6OejajxVreeQSac+d86+oFHs6ChUk/4AaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=aUJXGyM7W4qgOw8NAGDOgXkdyHqgk1WrgB6VtVYSmF8=;
 b=iMKEVHmFlxYWP4mWuwD+6V0sC+XZPDM1Y7/Mj2teQQhOtlMworzpVc9XqJ3nr+zaWiUW+omW54I99WeoEDfvVCiB1rZK8iFLVHe8CAbCddsKHuSqOflzzGy7oNJ7sHl3NdcDi9uexkM8RGfx74NkqRykoOYPsfoHXnQ9C0s3JsQYr9e4dzRi0+me8ertWYT8KuTc3vNzAUoUnHWSevUJIGV+3+aaHorS5xDXeHps+5hxLdvItTzx3Flc/hCZLRJzedp9N0/iJF2MGp2Os1lIolfAFr0abNDsbUls1FFLCSKFoQ+ofiJubO1juS5WZMWkSmyKw7fMfmcR4+H0rNeTSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUJXGyM7W4qgOw8NAGDOgXkdyHqgk1WrgB6VtVYSmF8=;
 b=YFb9U+pAmTV0wUlDgaH5CfT/IQFSARVs6cK5qHuXOyTTsVk4Tip5qrt41UBfZ9+Wm0deLbmRK12oUDwf8CrANSJvp8gzXqWQ4qNVnDUD2p6jWoFtj3mb6gcKuGaM+s0FTJavtCZEb/JQPeidD/Blc+R7mTihUH69efvOPxGgPiY=
Received: from DM6PR05CA0051.namprd05.prod.outlook.com (2603:10b6:5:335::20)
 by BN7PR07MB4738.namprd07.prod.outlook.com (2603:10b6:406:f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Wed, 8 Sep
 2021 12:29:44 +0000
Received: from DM6NAM12FT016.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::fd) by DM6PR05CA0051.outlook.office365.com
 (2603:10b6:5:335::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.7 via Frontend
 Transport; Wed, 8 Sep 2021 12:29:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT016.mail.protection.outlook.com (10.13.178.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 12:29:44 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTX9Y026939
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 05:29:42 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Sep 2021 14:29:34 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 8 Sep 2021 14:29:33 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 8 Sep 2021 14:29:33 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTXTv010329;
        Wed, 8 Sep 2021 14:29:33 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 188CTX9Z010328;
        Wed, 8 Sep 2021 14:29:33 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH v2 15/15] phy: cadence: Sierra: Add support for derived reference clock output
Date:   Wed, 8 Sep 2021 14:29:30 +0200
Message-ID: <20210908122930.10224-16-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210908122930.10224-1-sjakhade@cadence.com>
References: <20210908122930.10224-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca368b33-7f1b-4346-e570-08d972c4569e
X-MS-TrafficTypeDiagnostic: BN7PR07MB4738:
X-Microsoft-Antispam-PRVS: <BN7PR07MB47385600F25578318B4CE04FC5D49@BN7PR07MB4738.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:586;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hGn/tiIRy/Ndayv0bFqEGos77Przz0yofAMBbFzD2XMchHcjOHAmJE1h2/w8qwuPzAWzuDAPF93FUDArdXbSBwNTKvwv2SCkqIel/BC7D8Pvg1ltLLLT0EUvPA7U+SA8BGOWv1bGUsbotwG0PPln7/RlUBBZ7MT15PXYUugYQBfJes55lP1pVeqby4V29AmaLr/+gdSM5gyaCLZa6oxZw1fs+wVC8egkAhKGiLnfxNIGk88eHDjsgsCmg/3Ekas6+HHABIjQBLplvmzTIwFzxBtbnDgDx+LTg71vZPtvFq0FC1tNCWt0RPiqM+bygR3m5eb8F6RgWsoUC84aQRdmsbxX3nQ9VeGN7pDpY31o8mz6jOYcDz+TdWrvwQ9hrqgSG3lrXHwVWFL827MJFu6iql6636DSDm5v6YoM6FL8fAf7BFXnVcRTrXAMJeZp+MSUmxoXvSXYKYUeVw6mDif/D30aUZXLnC8eiZHE+ZiiMFssgoDV+8DvjAoqwgnV7bW1YHcSyvTb761bdJb8z9fkxIH+72MbQy2pPg3X36y1wYgUK9IdFIV4W3im2uhMcWakx435TuOlw96oSyifk9sBnHA6hI8QMjxirRobt+ES1HIqTJK21/VHIqfProOavFuQCYxxAlNleAdE/7KJuGIFufjwY4Wbao/sprKR8ztBAWX8wIs8Y8eE2j4o0OuMj7Azqi81ptlg1CiaOMCEISYX2Og+UI8Uy0f3hIj4A3easzm2gfi3RKVoDk9yoDgWx3zRKz07m+4b0S5Aba9tll8Eig==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(36092001)(46966006)(36840700001)(26005)(1076003)(82310400003)(4326008)(336012)(5660300002)(42186006)(83380400001)(86362001)(186003)(8936002)(316002)(2616005)(36756003)(82740400003)(54906003)(478600001)(426003)(110136005)(70586007)(47076005)(7636003)(36860700001)(8676002)(70206006)(356005)(2906002)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 12:29:44.1176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca368b33-7f1b-4346-e570-08d972c4569e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT016.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4738
X-Proofpoint-ORIG-GUID: RlXCiYDHHeVxpB5tR6dWJzlb0le1Vp5l
X-Proofpoint-GUID: RlXCiYDHHeVxpB5tR6dWJzlb0le1Vp5l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_06,2021-09-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080079
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

