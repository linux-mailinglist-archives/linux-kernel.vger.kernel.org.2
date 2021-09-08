Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F00403F19
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 20:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349932AbhIHS2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 14:28:48 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:55050 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349870AbhIHS1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 14:27:53 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 188I6GgT030393;
        Wed, 8 Sep 2021 11:26:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=r4LGrKYVFPXf28WdbIK1scsv/PzmLaaE4zedmIKKVwE=;
 b=KeGNFHF88g3pMWJiHY/1U7h1WK2NrP0l4NfvBz3FNtlR3HruNn9LXGDoYSKgj9f5qt/H
 gvK6hLy1Yy6KzYxaK19HCtg9j/Z+34qts0GVdsj9iOkN0uN08N/stYXQTHyqXP382jy6
 tq0s7HhU4FrEijaqYWe6mrE7V1ObXL1mFBEGrRbZUZmH7q2yJtvmNxPpoYV9gypNglXF
 FH/3jz+Tljv4OqTWdWPzD/7SQnMSQuH9RrSBwuhF4OOH7FS4/gqzXNAjm6aEh+ZXuiBv
 1tS7glRqVhJY3rV8KoRISC8lqPgJ51yOdEG6t8zZrJk1oal1V3YQ1BJMqtxD+iTLi8i1 eg== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3axcn5c479-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 11:26:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jahLDl83K1tY7KjlH7sxi1Bn1vrChEb1OZk1hbtcniTZU1DmKJu7Qx7wUdPvil7rNWOHI3FKMs3+2WFtOP3CbnTZtDAzyh8gXSqe0NAFI8znyPzY4inhKDPmu1n9sAJQOsK7Zdzr84cejej9qtUNb9GlXchPf+AZqjmzC0kERoicpxui+bTn3uF6e+0oiw+8JKDFM3khRgexTpWCKXaMJeLpvlo+7M7xEPYJxC+GmLmJwwNF4BN9lcVJTt9OptiM9d4WRKQ0wOYZX8UleBqvbm4h5NdSTETFaDTLB7aZKot1Mnjx/QaTZXvfJ1LRV8rgrgnGl0fKx2mOvL6if1nbQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=r4LGrKYVFPXf28WdbIK1scsv/PzmLaaE4zedmIKKVwE=;
 b=WJauSt05mjF9se6YfQu3bKbaHfgYiImQCuefV9hgvQyjrDtUO/iUkqNEt20TrjK+mfDVfiFP9K+5mQdGQTifxaeulunuSNuyhreg9Tl931u8ewMdEnXSRMWhymQFPsBVQHWKLaS7mKUtEmaSSlfaBMnnNhgzAlQet2dwkGukIqBHNhE+66JQwU/ulZvbnIpVDw8IHrWiVSDoWURpEj/kNnvGoodRU67wNfS0yg+JIpzTgirSK/5ChtTN5i13W6NAdnOzcs2JfQWFqtWMJ1EEaJgifX1KRNA2+fUKTUIzvCa5rC1pvBqp+BfD3EGDwZnb02IycXMxBPonZJ6cE+hw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4LGrKYVFPXf28WdbIK1scsv/PzmLaaE4zedmIKKVwE=;
 b=gD7SpYYLN58GrYO/WRIXsGCPYdSVcHzJkgIfVEGnKklZLWB31E6GGJHLWFH+H06Ftz2XATkLx4s2sJ9TQZmGaeXvTcrPtw4tC3oE7zLFeKKAzTjadJxMpI0u9E/563UvutjSS8+dhuc9dM1InIQmDVm/4w4Ky5MvoIqvsCUv4yk=
Received: from MWHPR01CA0026.prod.exchangelabs.com (2603:10b6:300:101::12) by
 BN8PR07MB5828.namprd07.prod.outlook.com (2603:10b6:408:6e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.24; Wed, 8 Sep 2021 18:26:36 +0000
Received: from MW2NAM12FT021.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::da) by MWHPR01CA0026.outlook.office365.com
 (2603:10b6:300:101::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 18:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 MW2NAM12FT021.mail.protection.outlook.com (10.13.180.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 18:26:33 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 188IQUwL017985
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 14:26:32 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Sep 2021 20:26:30 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 8 Sep 2021 20:26:30 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 8 Sep 2021 20:26:30 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 188IQUsU028429;
        Wed, 8 Sep 2021 20:26:30 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 188IQUSj028428;
        Wed, 8 Sep 2021 20:26:30 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH 5/5] phy: cadence-torrent: Model reference clock driver as a gate and mux clock
Date:   Wed, 8 Sep 2021 20:26:28 +0200
Message-ID: <20210908182628.28364-6-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210908182628.28364-1-sjakhade@cadence.com>
References: <20210908182628.28364-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4af95582-e825-4cd3-4feb-08d972f62fe1
X-MS-TrafficTypeDiagnostic: BN8PR07MB5828:
X-Microsoft-Antispam-PRVS: <BN8PR07MB5828B4BCA5DF15205CFB429DC5D49@BN8PR07MB5828.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:139;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8uTb/vC2c/YEv5ppweKVunO7DIzo3e/2PGDRbibaViMZ9D++siyMxQHhlnbqGmCIS7o9blGwjNQ5hl7Ct0QQPSV68tUbDHLVntgjuA91SJZTqgUTeEpoOSo46fucrA+o/GeuB4yjGwVTK8mGJMiEjNm6Q7OLytx7Ujr8L+i5oX1my2/LnTCBKWxkwwbTmUkaKa7NfEin1VMnbNps7HvInLlsKTGeO6taJvprogv5TV5fG3qRRm/OrbFTWKsI5FSuOHHFByBmzmEKVpi7TP6CMh4Kq/l3jpna0aVG8BJ5MxEZ27/G7pnQC41u3J/kWBDHNp3UP4iB78cQ1HISJSpabV//+kzHIbXFfFxYLFn3AyaYcL9M744Kn3QJruI3NB1b/a38tUayNG2V9w3/bOWDzEpHui4c8GmAqMyFeAY/YJSpXNrcU9ZjmnOE2DuG1SGcHy6ICX+Gp6QzypztJa3Oiz3bFNMScvNx2DCyFtM8NjiU862sScdJeJmZg9iGsOCEz8oqHsXbLa0luNjcKlYLMENzYu2WNHoqKPqGMiswa3qVjQNrgmxpg2TkNpH4st4NZEq6evcTC8xANyPoP4FlCAc6a7RI2ZB3UyAA6RO29HnlbeaLuy76MLUTm4geslFC9sv4mfBP0YrSo4IP18G2Vv9hzoJphONTHh0peONPyZOGTazkWoqdqTJr51Tb9dxDiQbEUdgwCj5ME8+3lxgH8fUiFZfOP+Arfr/9a9NssBpe3xvo4LpJJpI9PRc5NagPCJNXQCXb083BRsnJa9ckOE5NrPET6TvAVvR2PGJrG8o=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(36092001)(46966006)(36840700001)(36860700001)(70206006)(81166007)(316002)(36906005)(1076003)(8936002)(110136005)(336012)(70586007)(42186006)(47076005)(82310400003)(478600001)(356005)(82740400003)(26005)(186003)(2906002)(426003)(5660300002)(4326008)(54906003)(83380400001)(2616005)(86362001)(36756003)(8676002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 18:26:33.8913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af95582-e825-4cd3-4feb-08d972f62fe1
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT021.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB5828
X-Proofpoint-ORIG-GUID: bgcQCMbrjumSRLNAjSCgCg8Xp415ip_Y
X-Proofpoint-GUID: bgcQCMbrjumSRLNAjSCgCg8Xp415ip_Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_06,2021-09-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reference clock driver is enabled, either derived or received refclk
is output on cmn_refclk_p/m. Model reference clock driver as a "clock"
with gate and mux clock operations.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 160 ++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 2c42a6690632..5786166133d3 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -266,6 +266,29 @@ static const struct reg_field phy_pipe_cmn_ctrl1_0 = REG_FIELD(PHY_PIPE_CMN_CTRL
 static const struct reg_field cmn_cdiag_refclk_ovrd_4 =
 				REG_FIELD(CMN_CDIAG_REFCLK_OVRD, 4, 4);
 
+#define REFCLK_OUT_NUM_CMN_CONFIG	4
+
+enum cdns_torrent_refclk_out_cmn {
+	CMN_CDIAG_REFCLK_DRV0_CTRL_1,
+	CMN_CDIAG_REFCLK_DRV0_CTRL_4,
+	CMN_CDIAG_REFCLK_DRV0_CTRL_5,
+	CMN_CDIAG_REFCLK_DRV0_CTRL_6,
+};
+
+static const struct reg_field refclk_out_cmn_cfg[] = {
+	[CMN_CDIAG_REFCLK_DRV0_CTRL_1]	= REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 1, 1),
+	[CMN_CDIAG_REFCLK_DRV0_CTRL_4]	= REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 4, 4),
+	[CMN_CDIAG_REFCLK_DRV0_CTRL_5]  = REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 5, 5),
+	[CMN_CDIAG_REFCLK_DRV0_CTRL_6]	= REG_FIELD(CMN_CDIAG_REFCLK_DRV0_CTRL, 6, 6),
+};
+
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
@@ -334,6 +357,15 @@ enum phy_powerstate {
 	POWERSTATE_A3 = 3,
 };
 
+struct cdns_torrent_refclk_driver {
+	struct clk_hw		hw;
+	struct regmap_field	*cmn_fields[REFCLK_OUT_NUM_CMN_CONFIG];
+	struct clk_init_data	clk_data;
+};
+
+#define to_cdns_torrent_refclk_driver(_hw)	\
+			container_of(_hw, struct cdns_torrent_refclk_driver, hw)
+
 struct cdns_torrent_derived_refclk {
 	struct clk_hw		hw;
 	struct regmap_field	*phy_pipe_cmn_ctrl1_0;
@@ -1780,6 +1812,128 @@ static int cdns_torrent_received_refclk_register(struct cdns_torrent_phy *cdns_p
 	return 0;
 }
 
+static int cdns_torrent_refclk_driver_enable(struct clk_hw *hw)
+{
+	struct cdns_torrent_refclk_driver *refclk_driver = to_cdns_torrent_refclk_driver(hw);
+
+	regmap_field_write(refclk_driver->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_6], 0);
+	regmap_field_write(refclk_driver->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_5], 1);
+	regmap_field_write(refclk_driver->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_1], 0);
+
+	return 0;
+}
+
+static void cdns_torrent_refclk_driver_disable(struct clk_hw *hw)
+{
+	struct cdns_torrent_refclk_driver *refclk_driver = to_cdns_torrent_refclk_driver(hw);
+
+	regmap_field_write(refclk_driver->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_1], 1);
+}
+
+static int cdns_torrent_refclk_driver_is_enabled(struct clk_hw *hw)
+{
+	struct cdns_torrent_refclk_driver *refclk_driver = to_cdns_torrent_refclk_driver(hw);
+	int val;
+
+	regmap_field_read(refclk_driver->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_1], &val);
+
+	return !val;
+}
+
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
+static const struct clk_ops cdns_torrent_refclk_driver_ops = {
+	.enable = cdns_torrent_refclk_driver_enable,
+	.disable = cdns_torrent_refclk_driver_disable,
+	.is_enabled = cdns_torrent_refclk_driver_is_enabled,
+	.set_parent = cdns_torrent_refclk_driver_set_parent,
+	.get_parent = cdns_torrent_refclk_driver_get_parent,
+};
+
+static int cdns_torrent_refclk_driver_register(struct cdns_torrent_phy *cdns_phy)
+{
+	struct cdns_torrent_refclk_driver *refclk_driver;
+	struct device *dev = cdns_phy->dev;
+	struct regmap_field *field;
+	struct clk_init_data *init;
+	const char **parent_names;
+	unsigned int num_parents;
+	struct regmap *regmap;
+	char clk_name[100];
+	struct clk_hw *hw;
+	int i, ret;
+
+	refclk_driver = devm_kzalloc(dev, sizeof(*refclk_driver), GFP_KERNEL);
+	if (!refclk_driver)
+		return -ENOMEM;
+
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
+	}
+
+	snprintf(clk_name, sizeof(clk_name), "%s_%s", dev_name(dev),
+		 clk_names[CDNS_TORRENT_REFCLK_DRIVER]);
+
+	init = &refclk_driver->clk_data;
+
+	init->ops = &cdns_torrent_refclk_driver_ops;
+	init->flags = CLK_SET_RATE_NO_REPARENT;
+	init->parent_names = parent_names;
+	init->num_parents = num_parents;
+	init->name = clk_name;
+
+	regmap = cdns_phy->regmap_common_cdb;
+
+	for (i = 0; i < REFCLK_OUT_NUM_CMN_CONFIG; i++) {
+		field = devm_regmap_field_alloc(dev, regmap, refclk_out_cmn_cfg[i]);
+		if (IS_ERR(field)) {
+			dev_err(dev, "Refclk driver CMN reg field init failed\n");
+			return PTR_ERR(field);
+		}
+		refclk_driver->cmn_fields[i] = field;
+	}
+
+	/* Enable Derived reference clock as default */
+	regmap_field_write(refclk_driver->cmn_fields[CMN_CDIAG_REFCLK_DRV0_CTRL_4], 1);
+
+	refclk_driver->hw.init = init;
+
+	hw = &refclk_driver->hw;
+	ret = devm_clk_hw_register(dev, hw);
+	if (ret)
+		return ret;
+
+	cdns_phy->clk_hw_data->hws[CDNS_TORRENT_REFCLK_DRIVER] = hw;
+
+	return 0;
+}
+
 static struct regmap *cdns_regmap_init(struct device *dev, void __iomem *base,
 				       u32 block_offset,
 				       u8 reg_offset_shift,
@@ -2291,6 +2445,12 @@ static int cdns_torrent_clk_register(struct cdns_torrent_phy *cdns_phy)
 		return ret;
 	}
 
+	ret = cdns_torrent_refclk_driver_register(cdns_phy);
+	if (ret) {
+		dev_err(dev, "failed to register refclk driver\n");
+		return ret;
+	}
+
 	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, data);
 	if (ret) {
 		dev_err(dev, "Failed to add clock provider: %s\n", node->name);
-- 
2.26.1

