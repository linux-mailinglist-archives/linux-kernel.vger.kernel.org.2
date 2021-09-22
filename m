Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37268414913
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbhIVMjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:39:37 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:64310 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235869AbhIVMje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:39:34 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MC2WD5007309;
        Wed, 22 Sep 2021 05:37:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=VUAy+4bxbgtWEnSipFmQjVDcD+nwg0+iuqj/uBZlFaA=;
 b=gl3lNeUUSFzV5FIHv3Vs6PYg43VsvLl6N4fgWhTpNXYJ7xkvGPbjX99r0k8VDRcpJyv5
 I9tLCYQ+ktpvWfAcgp5dBlvRmtHdlwOwsRDcdKmjC1vZwy8Aa+voOIzCiwwriA/DMThj
 tjow+hvGSXiNlu1OxreKD2tEbYp7AY2STNfJuCdos5VAHifobNgPJQwyZZ0obcDlGyk4
 HGVDYN99IUm2BTyBVxbAanphlzMBC4IheScdIzhw68JbXzlkn3MlFjTPDJiM9E9GWj0+
 OY3Yg7z0YPA+Ol08kjTI6ujbiHPuNa66ZGnMiDc4rLiiJvLVyUJxMfLhm8i/KcXf5arT 9w== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3b7q4va5r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Sep 2021 05:37:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJOaGtA4sJuU3v+mQXF4RgLhUtx64Hhp9klDyzbGk44OyoTYxLjBbWxXpUCS9JVm12+j/ySAnYaOVoZgW5yI9Kt05Id71lABp7Yx6BoG9OaDg3UIpOcYc2Eb6alHSZVI2dafz1EKpI/CeSwQGwJ49qTeea508VQFUlEZDxlRMHhGZ7HiivRC5fEIivNxsw8fJuC58wH2etNdOwdA5fLxqIY1ct3z6GvfbX61gmVtVzqBXHykyFZ/x4yTZx73dtSXaavtaRzk6JBVTPy9Gj7hZpfGeHTV1m8/qHiiNXCI+oH8Ii5y5wnR8xwwWKO+KHVU1ePBMFZOvXpFgJ0g8nGyhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VUAy+4bxbgtWEnSipFmQjVDcD+nwg0+iuqj/uBZlFaA=;
 b=geiR3kEUe3RT0OTXwhhgAo7rjkFvmNyjRwCcEKcrNzXJu9Qp+dVCm3u9ijeZqleRnftczal6x3xsMKp8jzhKQuomcit8RJVKkYyqh1JjMUjvY6yi91q9oBvQbxsEkPUZD6i7YvcakiXXTpMdm+PSbDH/eLmJ3geD8RhlRVPip1XtyGvuUkSGAEYnLS3bxtxwpsbqzw1Y+diYNQlaWy/FVM3c79vpk8AidgZrgZK1N4/WXr4dIlF7AoKnW0IQO8TdHar1ldcZ3vuGnecHzp7U9YdVPtZJXDtFDZscZQW6LjLlBQfmoGd4kxccPro+NZPl8HQwj6RUyTlewhT9htrGaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUAy+4bxbgtWEnSipFmQjVDcD+nwg0+iuqj/uBZlFaA=;
 b=uIpeB4ji3Kg2+HveBpgIgkPSauIVW65gSpTZgZeU+alPxRkawuYczIp4JWOYPdt7kW7J0avmhaSf3G1o/sosRcL0dWof1ivWFh0AcaDzJ56vWGT41k8LRyEkCH4QO20vpF7Bd3I5NhJQjk2oZfTIug+wM6rohDdR2rYkhFfQcKQ=
Received: from CO2PR05CA0064.namprd05.prod.outlook.com (2603:10b6:102:2::32)
 by DM8PR07MB8807.namprd07.prod.outlook.com (2603:10b6:8:10::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 12:37:50 +0000
Received: from MW2NAM12FT031.eop-nam12.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::70) by CO2PR05CA0064.outlook.office365.com
 (2603:10b6:102:2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Wed, 22 Sep 2021 12:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT031.mail.protection.outlook.com (10.13.181.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.6 via Frontend Transport; Wed, 22 Sep 2021 12:37:48 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 18MCbj48070810
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 05:37:47 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Sep 2021 14:37:38 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 22 Sep 2021 14:37:38 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18MCbcNQ021985;
        Wed, 22 Sep 2021 14:37:38 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18MCbcXO021984;
        Wed, 22 Sep 2021 14:37:38 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH v2 4/4] phy: cadence-torrent: Add support to output received reference clock
Date:   Wed, 22 Sep 2021 14:37:35 +0200
Message-ID: <20210922123735.21927-5-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210922123735.21927-1-sjakhade@cadence.com>
References: <20210922123735.21927-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4713f755-4126-4995-8dac-08d97dc5c954
X-MS-TrafficTypeDiagnostic: DM8PR07MB8807:
X-Microsoft-Antispam-PRVS: <DM8PR07MB8807B68252D19506FDDCC3E6C5A29@DM8PR07MB8807.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:381;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A3ZL+IWNXyvTXKZOz6dYklz6w3PXCS+olS8NvEclamnDxwhBVq+BRIj8cMXdckIeno5cIA2ipikjf+jTgAC9Wzxc2vNgf3jwK2bVXz5gRcdBojAgeNt22aNTE/NokX+/MmVbkx0tm/K/NsnuSwivQUXl1SC/kBNr37Kzg/Epizq4uusCNQ5hMmZY/F6HWqu+z/+pgG6ivAW8pfY720dpbBELTQ0GKOoUq+gqGgTca5xIE0/Yc0gmHZe1TNeMJFppB9EM2z9av/jGzpqv+oWY50nILeP0t8NQtUEd8EITx6fZ7PpsQ7ScSeYE0CI9yc9B5nZLsQUYU7qSlj3LDU5zqoSj7IOyJuoxyFAWpC1maHAbHVU+FsJe11Xg/4yldh0zqOo/HTLtiJiJgf1vd5jWyxW2ZNpWDP7FiV9EgVZj6b1dc9+6O9hA5foJj+Sw1Mh1+GP6o3JbdQx28VEDAxJqsgZ1SAKzQfJNB1HvYS75FDlYh6FHQe4qfOplZYJdCiFxQ6UfgA0il+3/2kAL0uOnTqlfG0Mtwv9Nz2nJU987a8scCnTwxzBwWZIAu40Xl/I34ZnZEu+Q4eraD/ZiggKRBBYceVZSbcXf2YokJQxdoxAb3ytufYcIj7Z5YW0en48He8rlheiprNKLS9V23QbAMeFnzlVm1I/gyXSeMKmNI0vXNxiNoGgqFb6PzSb7lt/RrX0qrSfrIdqYOIQAmlSOXRhkDJvZjSs5KMnksAiTJR7vlkqyR1HeVrNfZgQVWBtzdtE/UvnjUo1zDwffB7MBbROYpVsOvX+ys8ble5yVRKM=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(336012)(70206006)(86362001)(2906002)(42186006)(82310400003)(36860700001)(81166007)(83380400001)(26005)(47076005)(316002)(508600001)(5660300002)(2616005)(426003)(356005)(8936002)(8676002)(6666004)(110136005)(54906003)(36756003)(186003)(70586007)(4326008)(1076003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 12:37:48.8057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4713f755-4126-4995-8dac-08d97dc5c954
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT031.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR07MB8807
X-Proofpoint-GUID: QKzScnrrIplW0AbdCvp6Dy4XKJE9SJtw
X-Proofpoint-ORIG-GUID: QKzScnrrIplW0AbdCvp6Dy4XKJE9SJtw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_04,2021-09-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109200000 definitions=main-2109220088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to output received reference clock. Model the received
reference clock as an alternate parent of reference clock driver
clock. When received refclk is selected to output on cmn_refclk_p/m,
this is the internal reference clock driven on the pma_cmn_refclk_int.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 159 ++++++++++++++++++++--
 1 file changed, 148 insertions(+), 11 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 615aca6bd52b..5786166133d3 100644
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
@@ -281,6 +282,13 @@ static const struct reg_field refclk_out_cmn_cfg[] = {
 	[CMN_CDIAG_REFCLK_DRV0_CTRL_6]	= REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 6, 6),
 };
 
+static const int refclk_driver_parent_index[] = {
+	CDNS_TORRENT_DERIVED_REFCLK,
+	CDNS_TORRENT_RECEIVED_REFCLK
+};
+
+static u32 cdns_torrent_refclk_driver_mux_table[] = { 1, 0 };
+
 enum cdns_torrent_phy_type {
 	TYPE_NONE,
 	TYPE_DP,
@@ -368,6 +376,16 @@ struct cdns_torrent_derived_refclk {
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
@@ -1711,12 +1729,94 @@ static int cdns_torrent_derived_refclk_register(struct cdns_torrent_phy *cdns_ph
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
 static int cdns_torrent_refclk_driver_enable(struct clk_hw *hw)
 {
 	struct cdns_torrent_refclk_driver *refclk_driver = to_cdns_torrent_refclk_driver(hw);
 
 	regmap_field_write(refclk_driver->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_6], 0);
-	regmap_field_write(refclk_driver->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_4], 1);
 	regmap_field_write(refclk_driver->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_5], 1);
 	regmap_field_write(refclk_driver->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_1], 0);
 
@@ -1740,10 +1840,30 @@ static int cdns_torrent_refclk_driver_is_enabled(struct clk_hw *hw)
 	return !val;
 }
 
+static u8 cdns_torrent_refclk_driver_get_parent(struct clk_hw *hw)
+{
+	struct cdns_torrent_refclk_driver *refclk_driver = to_cdns_torrent_refclk_driver(hw);
+	unsigned int val;
+
+	regmap_field_read(refclk_driver->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_4], &val);
+	return clk_mux_val_to_index(hw, cdns_torrent_refclk_driver_mux_table, 0, val);
+}
+
+static int cdns_torrent_refclk_driver_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct cdns_torrent_refclk_driver *refclk_driver = to_cdns_torrent_refclk_driver(hw);
+	unsigned int val;
+
+	val = cdns_torrent_refclk_driver_mux_table[index];
+	return regmap_field_write(refclk_driver->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_4], val);
+}
+
 static const struct clk_ops cdns_torrent_refclk_driver_ops = {
 	.enable = cdns_torrent_refclk_driver_enable,
 	.disable = cdns_torrent_refclk_driver_disable,
 	.is_enabled = cdns_torrent_refclk_driver_is_enabled,
+	.set_parent = cdns_torrent_refclk_driver_set_parent,
+	.get_parent = cdns_torrent_refclk_driver_get_parent,
 };
 
 static int cdns_torrent_refclk_driver_register(struct cdns_torrent_phy *cdns_phy)
@@ -1752,7 +1872,8 @@ static int cdns_torrent_refclk_driver_register(struct cdns_torrent_phy *cdns_phy
 	struct device *dev = cdns_phy->dev;
 	struct regmap_field *field;
 	struct clk_init_data *init;
-	const char *parent_name;
+	const char **parent_names;
+	unsigned int num_parents;
 	struct regmap *regmap;
 	char clk_name[100];
 	struct clk_hw *hw;
@@ -1762,12 +1883,19 @@ static int cdns_torrent_refclk_driver_register(struct cdns_torrent_phy *cdns_phy
 	if (!refclk_driver)
 		return -ENOMEM;
 
-	hw = cdns_phy->clk_hw_data->hws[CDNS_TORRENT_DERIVED_REFCLK];
-	if (IS_ERR_OR_NULL(hw)) {
-		dev_err(dev, "No parent clock for refclk driver clock\n");
-		return IS_ERR(hw) ? PTR_ERR(hw) : -ENOENT;
+	num_parents = ARRAY_SIZE(refclk_driver_parent_index);
+	parent_names = devm_kzalloc(dev, (sizeof(char *) * num_parents), GFP_KERNEL);
+	if (!parent_names)
+		return -ENOMEM;
+
+	for (i = 0; i < num_parents; i++) {
+		hw = cdns_phy->clk_hw_data->hws[refclk_driver_parent_index[i]];
+		if (IS_ERR_OR_NULL(hw)) {
+			dev_err(dev, "No parent clock for refclk driver clock\n");
+			return IS_ERR(hw) ? PTR_ERR(hw) : -ENOENT;
+		}
+		parent_names[i] = clk_hw_get_name(hw);
 	}
-	parent_name = clk_hw_get_name(hw);
 
 	snprintf(clk_name, sizeof(clk_name), "%s_%s", dev_name(dev),
 		 clk_names[CDNS_TORRENT_REFCLK_DRIVER]);
@@ -1775,9 +1903,9 @@ static int cdns_torrent_refclk_driver_register(struct cdns_torrent_phy *cdns_phy
 	init = &refclk_driver->clk_data;
 
 	init->ops = &cdns_torrent_refclk_driver_ops;
-	init->flags = 0;
-	init->parent_names = &parent_name;
-	init->num_parents = 1;
+	init->flags = CLK_SET_RATE_NO_REPARENT;
+	init->parent_names = parent_names;
+	init->num_parents = num_parents;
 	init->name = clk_name;
 
 	regmap = cdns_phy->regmap_common_cdb;
@@ -1791,6 +1919,9 @@ static int cdns_torrent_refclk_driver_register(struct cdns_torrent_phy *cdns_phy
 		refclk_driver->cmn_fields[i] = field;
 	}
 
+	/* Enable Derived reference clock as default */
+	regmap_field_write(refclk_driver->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_4], 1);
+
 	refclk_driver->hw.init = init;
 
 	hw = &refclk_driver->hw;
@@ -2308,6 +2439,12 @@ static int cdns_torrent_clk_register(struct cdns_torrent_phy *cdns_phy)
 		return ret;
 	}
 
+	ret = cdns_torrent_received_refclk_register(cdns_phy);
+	if (ret) {
+		dev_err(dev, "failed to register received refclk\n");
+		return ret;
+	}
+
 	ret = cdns_torrent_refclk_driver_register(cdns_phy);
 	if (ret) {
 		dev_err(dev, "failed to register refclk driver\n");
-- 
2.26.1

