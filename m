Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C8741490F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbhIVMjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:39:33 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:63834 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235913AbhIVMjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:39:31 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MBWLIK010092;
        Wed, 22 Sep 2021 05:37:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=MKg7JQwxA4RPNqr6icqL8NswvNa+SZUHYBXn85QczIs=;
 b=GNEl/k7KCT1jRnZS1TQZNJxQOfivUBbkK8c8S5aBnnDgFmTxBmA4vwVEYA9//x+vwhcO
 rvu5isj4Y3Y050ApvfJDDcfairQRi3X5nWvt8XDYh+LKSNlYi8hqdtkHGvqrR29Mlixf
 8zD5NnGKtWgc8E5wQnl6zr6sOgIl1rc0S0EJqp40ezyazwmG277uPDFdBl2gYebtiYJ2
 GFerpAxoisNRZqZgo8jGVUTme2SRxL5NvLwztqTGWnVzf5YbsH+v0wx6q2YYS198n8T2
 va78fJxuTjnWMDUHTmrvUoZ63EE9aPLCKO2NeZktcFkEbg3b20NXUHWC5bn5uX8IIy3S tQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3b7q41a4y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Sep 2021 05:37:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2B5Wj/vuCAgb99T0krMg2+gHXa1NNs3Ibh5mVkVu9H3wLIdRJ7lu3Shpq4pKMJHCPyy4PldsVFgVC6nlJ1P0EXnCStWYDQL3rcH05RPkYGIMM79awe8rozs2sRbcpKCalwXtEwMJhpMDx6OUkclyCAQCLYPaJX3I8uPmXrcUNJVrrEfaispNsBFNEEOY4tRP8DoY1ENYuA4APsp4s4fc4HvRALz79ZNsZ+OH3mR+EZHojoLxpU2J4Ai1bFmYAAIhONMVYyXuyWQDOpR71H4gEpMIwzD2v66kby9+vOmG+ozK9JDTwbZ0U1dKmy5e0AJ6O87UBD+Krgj9/H/esigtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MKg7JQwxA4RPNqr6icqL8NswvNa+SZUHYBXn85QczIs=;
 b=DXxZ643P+SoYc2RmK4rpI8nTn5wBUJGRh7dAzo8hMk4OGdPCn5+Sc5BYTlbBCEk6SQYr1Cyq0zhptZaKKpbrg9NNhaHmLKUMhUHUatGWWD/BtVc3BTA3WNOwZEmkL7l6FViFmGprxWq475+rDi6f+7FqV02SvUeP2q8D1lcvAF0VbPyoZcjV5uHkdq3f8GgM0YrJ0/djM8znLLgMb4KEcAqFCKlzZpqA22ZkeP7MmHw33BvTH3bD/GaUXdoa+kRHh0aPAPRAr2I8sFNjyeUkggVQfSockEEhxMLftB72U1uaDVvjSncc4V1IuKnbxe/zQjGiGzLT/9F+MsCkra9uAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKg7JQwxA4RPNqr6icqL8NswvNa+SZUHYBXn85QczIs=;
 b=pEhnRKRVcO/8GunJrSXNpsm5kS23RwuOrF5mp6ylogCaWQ8jBbpqMe61uFIeNqWAQ6Uy4tb3iFYWkYhWalS7Jzsk9p9kbNkZZp62DvOwFOyPigxEaWu8wsX/TsUCAzSsCsoctZ0TYQjKHdOLQWb8Pxk2pE1uxV8xTT7vfoBEsf4=
Received: from CO2PR05CA0070.namprd05.prod.outlook.com (2603:10b6:102:2::38)
 by DM6PR07MB4267.namprd07.prod.outlook.com (2603:10b6:5:ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Wed, 22 Sep
 2021 12:37:50 +0000
Received: from MW2NAM12FT031.eop-nam12.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::7a) by CO2PR05CA0070.outlook.office365.com
 (2603:10b6:102:2::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.7 via Frontend
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
 15.20.4544.6 via Frontend Transport; Wed, 22 Sep 2021 12:37:49 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 18MCbj49070810
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 05:37:48 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Sep 2021 14:37:44 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 22 Sep 2021 14:37:44 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 22 Sep 2021 14:37:37 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18MCbcw1021973;
        Wed, 22 Sep 2021 14:37:38 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18MCbbj3021972;
        Wed, 22 Sep 2021 14:37:38 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH v2 1/4] phy: cadence-torrent: Migrate to clk_hw based registration and OF APIs
Date:   Wed, 22 Sep 2021 14:37:32 +0200
Message-ID: <20210922123735.21927-2-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210922123735.21927-1-sjakhade@cadence.com>
References: <20210922123735.21927-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68f6160a-aa17-423a-a2e0-08d97dc5c999
X-MS-TrafficTypeDiagnostic: DM6PR07MB4267:
X-Microsoft-Antispam-PRVS: <DM6PR07MB42675505D92BFF3DD980C9DDC5A29@DM6PR07MB4267.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GgBBXcXUefj5ukVjD3GHQ8OQyaXbFdF2dg2mJOgy2b0ktJSvG1NT9JffFVy0nBZERgmT4D0hZ39SKy4q4fCDVJ1eVt6oIyu63rTXg2Upq8CYq9GBYywo8i4yo91exPLA2NQBKpSJHKp8nhCZA0MX+ciXKBcvhCypthsdPomax1QnRC7iMsxaDS77qHmtk4RwK12VpwPxeRILi659BgZsaHQWi3D21R8h8skQJsZoFRUjNcXzy9h+3ZipvVizmdWcyNxZt/OQKEe5/uMEdhwrhFBmTUH9i0eEUdlS256TVvu9z1YMyLc9uUnIHuDZMQbJvz89Dhq4jcgube/8tHLwLMxAaPj+tExS+gcxuEsPewDnmpEjfP72YbhpL3rt/4w5m/+00qNrzmhJL653b201TUUXnvScALsQY9RFN0ofBcsYOj/A88+WmK24toj31ZqJsGm69fiTB5RoaD+S6ZYQBLpunCzsZ4GU1Xx9gghUdApJmP1eClozEUxFo49w/pMgJLtbuwHqa9bIg4q4jbCyuVtIGq6q+k+SOq3jia/TPs1M/L/IA7HH8Vky5HImvxlEnzrzmHMxbktCVCoWIK3/r6spowsOi8IXXR4TIzu1uW2Mo4QeJYDc7gVJUjGCxy20vQvJtseFu3r5Pv1Gi7ycsBzZlRvYh2WXrwGzBC1g3T8dtTUpQObAZGtTX7d9bdHXNQQnqG6wr8UoEQQGbcbGo0pYbMUcDNJhLM+mzZdsKHZhh49UjNxLMf0KZ5q0tBLdOlwaKVaJzauwUGLqrti9Sav6zrT5H8gD9bmR5+CiylE=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(47076005)(6666004)(70586007)(5660300002)(316002)(70206006)(82310400003)(26005)(336012)(426003)(1076003)(36756003)(36860700001)(8936002)(2616005)(8676002)(356005)(81166007)(42186006)(86362001)(54906003)(2906002)(508600001)(186003)(110136005)(4326008)(83380400001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 12:37:49.3354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f6160a-aa17-423a-a2e0-08d97dc5c999
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT031.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4267
X-Proofpoint-ORIG-GUID: SYI7RXkGX5rbq0FWtwKHlSLpD-XVicZ7
X-Proofpoint-GUID: SYI7RXkGX5rbq0FWtwKHlSLpD-XVicZ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_04,2021-09-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 spamscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109200000 definitions=main-2109220089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use clk_hw based provider APIs to register clks to remove the usage of
deprecated APIs.

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

