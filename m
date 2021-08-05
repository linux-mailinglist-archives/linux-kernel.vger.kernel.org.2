Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0933E1452
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 14:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241234AbhHEMBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 08:01:44 -0400
Received: from mail-db8eur05on2074.outbound.protection.outlook.com ([40.107.20.74]:53409
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230446AbhHEMBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 08:01:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDY+nUGfMhkVIGXsu4Vaw7c9ztewz4ZDOpQK/v3+4azY1E7csznX1NV7scJrPSXlH04lc/E2ZLtWxUX1xvXRg7gjR9jmpenr/uAFR76EldNHsTiB7xV7pMa4ASDbZ+t7RqqGY0trEYa1PiCFk9qPZj7/H9ExfJFuWTbPWCk24t5+uF1V4X6bWOrQA2JiE24gm1Fu8Vzsv/uuMSK+SH075LKlehpmIJZ7fKQs1ruOMjvuA0CyalnKCpbe3gIr6X+5VM4Fk8nvmC2VOJ+Z8gQODcTDcyTnYrSfzbxS61qxU19oMJ/RQ9TbnJjI8UWNBTTXjOpAEYfqKDhOosLY+7hgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VhqnL0+9ZAb95pJ1bIoH40UmTJ/ugiOMIB+fbj/Oso=;
 b=MUFYixeV88XDoWmalmASZdwW7ee/+mJH3V0fG5dRqX/0KGm7CzB6mUGD2N9+zjSJcr6BmzxuPv/WKO+68eBAXcIqCwS8nLJ9GkqaEL6By2TmCHsnTlWPVfn2SIG334Dz6CGu0zJYrR78fA/C/zG4ELE64qkwKs4v0m2b9M3MwX9R7PxviiiEBNEnQuOZ+fPb4cCK5ABVQc19iG2Rmntq5rd23czxwgZkr/RJus2dof2PVFWArltYpPn4BVUQ6bfRyZO8tGRVUmYgAKuU1fISs1xRb1zkdb+Y9VXVZG5ppjZ2H2+Rba0IY7qFIGm6IdkYKMev+w2+zYazZK/6v3dp5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VhqnL0+9ZAb95pJ1bIoH40UmTJ/ugiOMIB+fbj/Oso=;
 b=vMuW+HT93lxvMmEkX+KWnxlcmtItriGLO1J4V7ZBwIjeo80RY2l6OM05QKSaiHDsLm6INd6j02thwOKphC2YCyhycb7oDlEU6p6ZmyANC2geso6xm9Nmtlcamja2O64lraI26OgEQbT/jHPb7ETBJzHMzc+oCMVg+ErFe6Drglo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB8PR08MB5419.eurprd08.prod.outlook.com (2603:10a6:10:118::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Thu, 5 Aug
 2021 12:01:25 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4394.016; Thu, 5 Aug 2021
 12:01:25 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Simon Xue <xxm@rock-chips.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Zhang Changzhong <zhangchangzhong@huawei.com>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 2/7] soc: rockchip: io-domain: add rk3568 support
Date:   Thu,  5 Aug 2021 14:01:02 +0200
Message-Id: <20210805120107.27007-3-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210805120107.27007-1-michael.riesch@wolfvision.net>
References: <20210805120107.27007-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0099.eurprd04.prod.outlook.com
 (2603:10a6:803:64::34) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carlos.wolfvision-at.intra (91.118.163.37) by VI1PR04CA0099.eurprd04.prod.outlook.com (2603:10a6:803:64::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend Transport; Thu, 5 Aug 2021 12:01:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 495dda20-17e0-4d34-62b2-08d95808c006
X-MS-TrafficTypeDiagnostic: DB8PR08MB5419:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB541912DEB96634B31FE21AF6F2F29@DB8PR08MB5419.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i+wHIKnJVS8gE+RFPTpFGGI4PfLuBYoU+uhS7s2yM8QwZstIuKcIKDeDAyl2hILl69+oTt6bqlugaiG15DbrczQLNNIcCPCkryZ4n9cBPDpsV/mFmZlIGXtg6F4v9pH8pSm5Y08QF7/AqgmaZxsbCMt5HGUaeDtfe56KmjYcNsQED6USRchgvs8JyKUx6KWYwglgUB5sT02dybQEBWaoBddXTsHJHtjzY1pcaDhPJ6smsfRod+x9y1HoUXVlYSqfjzcc5To74pW6KlsO4rxFoQgyeWxh5yuG5jjfxop6g1IEJiNUgcmT5VGsg5bbw+pVahUZQdEQvmIJTLTskxh9uJlLSgs6i5/So2IoRKOHEaeKIpqunuZtPHg1tq8rAqcZnTKvGsj04vhQzXc7yxyXscLi9YO44TlAIPaUs4sJlApyJW5AmqAysosM44q8hJ0z1AEz6nbmnDjlGiNgC6+mQkIcQUQLF9vz/gmzjGwwSecznfVBTstSlzHMEv+IXoWxkn/DOgMSLjPL9Xa/bPVZZ1ZBXePzYHnPvOW6qqyZowcFhe89mBB8PFGDTgwYpskxwfExgPfhu3XFNR0oARP/EXX2Gho/orLFymGbiin7W3utD4ybx/v9Zb8W0BNDI2qkRZHOycOw0sY1xpu0oE4HiA3KpZ4+Tj7CunYK8M6H+3M6p2kLKkEzOGr1yoQgcBpEJVLfekN/dm74pnM/vwl2dA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39840400004)(396003)(376002)(346002)(6512007)(8936002)(66946007)(38100700002)(7416002)(66476007)(6486002)(66556008)(52116002)(1076003)(2906002)(8676002)(4326008)(54906003)(478600001)(44832011)(316002)(36756003)(38350700002)(83380400001)(2616005)(6666004)(186003)(6506007)(956004)(86362001)(26005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I25f8wcwoB9/GbX7TDRx/B6taWAlpN6pJ+MPxlTWoNCkZP31z4TTGirOiIZz?=
 =?us-ascii?Q?Q90ymZHpRAZzbAJZRQwEqBYWVfsJhTPSkUCapFhNeGwIiV8KtFZI+Zdg2wiH?=
 =?us-ascii?Q?eAAM1JnmRLvR2wbteFNsJjyqQgF+LCS+sXaIhWnomgspJ1iOBCqNGIkfy4z1?=
 =?us-ascii?Q?aMPgZRR/Mb4a0XOxB97Qmc8sLqTsHbhy+4n1Bgxl+fLl5vrbnaf5fl7Y3Qm9?=
 =?us-ascii?Q?FQUK1uzS8Om0bKpI1DseX/r5DP3zkHwLdzlppj+Du8V9MAe8CDIOdIXYxDqb?=
 =?us-ascii?Q?U0y2pd1mlgG5bOywepUTjLJykL5L2xgkRzbGGzdlFUOSE0XLI1W/MWlkGHV8?=
 =?us-ascii?Q?qaNOhOK1yXanj/gtx4ktbJri+gzy/im6yeFwn/s8SgCG8tMaAWTKIEe7Gahk?=
 =?us-ascii?Q?0rB0ubMypclC7LNiAHXfNuXqFD6WR82r30FrrNM93Js9XCAPlYh8+OryHiqF?=
 =?us-ascii?Q?w8G2Mk22WeJ5waOJV3jZ31TN7ntawLHhJTCStpJyqeEkMlleFYFD3rYexs5R?=
 =?us-ascii?Q?LbYaiUFmTGcpmpBMrRrrUVKu91hxuGjEZbyBU3vnM1PbYjleHABZnaZp9U9j?=
 =?us-ascii?Q?bO39b0YspcDcVD/bvAVZhw6Vo+6kx2j5y1j0+yiOVERJ4enF+TxzRG2za/9v?=
 =?us-ascii?Q?R67durg3aEOsoqH/3BTlM4pHyc5H3I/S6s9uEwxUKWZFVbGUwiaFeMlbNlY5?=
 =?us-ascii?Q?w655nyI5eUuqVUN0Y8W28PJD9st+7K0l0pKVwvSHJcG25IoEG/QPKx0a+4Yn?=
 =?us-ascii?Q?qo6GYvyNQXv43IvqyoYmDsw7aAZgFJm3JE1ttBUTGuRmUTzce9dmlcztCMlq?=
 =?us-ascii?Q?cLPFlS+V1ab6Zq1y++6gMg+aWuvsOlnb7Liz1I0nG7ADFrl+kFZSC3E/7y00?=
 =?us-ascii?Q?nAJbpKLQLQrtXKDTQ2HsTwRm387jJTiij7onTzrDZThM5g2Twz0O2rz2FJ8/?=
 =?us-ascii?Q?sv+ugzc3WaNRSLOQHtUqCNdLIsVu7p5CTx/dG42hS7/2zUlICqBXZanns+jU?=
 =?us-ascii?Q?3OcGdYskanToNhzBRo42UFI0ppELhl7kLzIf3nva2X3/Z1FSUYtOcMPBHQn5?=
 =?us-ascii?Q?YBl6SL/SA9dq+Hf7Vr7NtwG8psan9WDTTZvXMgh0FEl6RTXZYFbjZPI84K4u?=
 =?us-ascii?Q?CZaCP6y5JA41FqYZqFeyzvCRvo7ZYv9ovKq/vSp2mEjWWBDolZFAnAnbUwAk?=
 =?us-ascii?Q?Y/p2/9TzOi0KeDS4XjwSZCKCyMFQEZ/uFOi/WPs56HsOwig/LasR+Iuf0r/6?=
 =?us-ascii?Q?M5cQa6xdUzxiIddsupYKWystEiB3rECLq/MZKistZvfzC9Ye0Be0oh9RjejE?=
 =?us-ascii?Q?TaYsTfYSTRd8QbvdDC51ZrSi?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 495dda20-17e0-4d34-62b2-08d95808c006
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 12:01:25.5461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cE14FpC7Bo0W4mknNn5mMUO3rRsoXbLdQ9g56Ro7wcdlQtVrjYISGIBITAi125VS7vkGYnkOmrbVT2PSMs/SB+A845MKd1rB6xWjjGUXr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5419
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jianqun Xu <jay.xu@rock-chips.com>

The io-domain registers on RK3568 SoCs have three separated bits to
enable/disable the 1.8v/2.5v/3.3v power.

This patch make the write to be a operation, allow rk3568 uses a private
register set function.

Since the 2.5v is not used on RK3568, so the driver only set
1.8v [enable] + 3.3v [disable] for 1.8v mode
1.8v [disable] + 3.3v [enable] for 3.3v mode

There is not register order requirement which has been cleared by our IC
team.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 drivers/soc/rockchip/io-domain.c | 88 +++++++++++++++++++++++++++++---
 1 file changed, 80 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/rockchip/io-domain.c b/drivers/soc/rockchip/io-domain.c
index cf8182fc3642..13c446fd33a9 100644
--- a/drivers/soc/rockchip/io-domain.c
+++ b/drivers/soc/rockchip/io-domain.c
@@ -51,13 +51,11 @@
 #define RK3399_PMUGRF_CON0_VSEL		BIT(8)
 #define RK3399_PMUGRF_VSEL_SUPPLY_NUM	9
 
-struct rockchip_iodomain;
+#define RK3568_PMU_GRF_IO_VSEL0		(0x0140)
+#define RK3568_PMU_GRF_IO_VSEL1		(0x0144)
+#define RK3568_PMU_GRF_IO_VSEL2		(0x0148)
 
-struct rockchip_iodomain_soc_data {
-	int grf_offset;
-	const char *supply_names[MAX_SUPPLIES];
-	void (*init)(struct rockchip_iodomain *iod);
-};
+struct rockchip_iodomain;
 
 struct rockchip_iodomain_supply {
 	struct rockchip_iodomain *iod;
@@ -66,13 +64,62 @@ struct rockchip_iodomain_supply {
 	int idx;
 };
 
+struct rockchip_iodomain_soc_data {
+	int grf_offset;
+	const char *supply_names[MAX_SUPPLIES];
+	void (*init)(struct rockchip_iodomain *iod);
+	int (*write)(struct rockchip_iodomain_supply *supply, int uV);
+};
+
 struct rockchip_iodomain {
 	struct device *dev;
 	struct regmap *grf;
 	const struct rockchip_iodomain_soc_data *soc_data;
 	struct rockchip_iodomain_supply supplies[MAX_SUPPLIES];
+	int (*write)(struct rockchip_iodomain_supply *supply, int uV);
 };
 
+static int rk3568_iodomain_write(struct rockchip_iodomain_supply *supply, int uV)
+{
+	struct rockchip_iodomain *iod = supply->iod;
+	u32 is_3v3 = uV > MAX_VOLTAGE_1_8;
+	u32 val0, val1;
+	int b;
+
+	switch (supply->idx) {
+	case 0: /* pmuio1 */
+		break;
+	case 1: /* pmuio2 */
+		b = supply->idx;
+		val0 = BIT(16 + b) | (is_3v3 ? 0 : BIT(b));
+		b = supply->idx + 4;
+		val1 = BIT(16 + b) | (is_3v3 ? BIT(b) : 0);
+
+		regmap_write(iod->grf, RK3568_PMU_GRF_IO_VSEL2, val0);
+		regmap_write(iod->grf, RK3568_PMU_GRF_IO_VSEL2, val1);
+		break;
+	case 3: /* vccio2 */
+		break;
+	case 2: /* vccio1 */
+	case 4: /* vccio3 */
+	case 5: /* vccio4 */
+	case 6: /* vccio5 */
+	case 7: /* vccio6 */
+	case 8: /* vccio7 */
+		b = supply->idx - 1;
+		val0 = BIT(16 + b) | (is_3v3 ? 0 : BIT(b));
+		val1 = BIT(16 + b) | (is_3v3 ? BIT(b) : 0);
+
+		regmap_write(iod->grf, RK3568_PMU_GRF_IO_VSEL0, val0);
+		regmap_write(iod->grf, RK3568_PMU_GRF_IO_VSEL1, val1);
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	return 0;
+}
+
 static int rockchip_iodomain_write(struct rockchip_iodomain_supply *supply,
 				   int uV)
 {
@@ -136,7 +183,7 @@ static int rockchip_iodomain_notify(struct notifier_block *nb,
 			return NOTIFY_BAD;
 	}
 
-	ret = rockchip_iodomain_write(supply, uV);
+	ret = supply->iod->write(supply, uV);
 	if (ret && event == REGULATOR_EVENT_PRE_VOLTAGE_CHANGE)
 		return NOTIFY_BAD;
 
@@ -398,6 +445,22 @@ static const struct rockchip_iodomain_soc_data soc_data_rk3399_pmu = {
 	.init = rk3399_pmu_iodomain_init,
 };
 
+static const struct rockchip_iodomain_soc_data soc_data_rk3568_pmu = {
+	.grf_offset = 0x140,
+	.supply_names = {
+		"pmuio1",
+		"pmuio2",
+		"vccio1",
+		"vccio2",
+		"vccio3",
+		"vccio4",
+		"vccio5",
+		"vccio6",
+		"vccio7",
+	},
+	.write = rk3568_iodomain_write,
+};
+
 static const struct rockchip_iodomain_soc_data soc_data_rv1108 = {
 	.grf_offset = 0x404,
 	.supply_names = {
@@ -469,6 +532,10 @@ static const struct of_device_id rockchip_iodomain_match[] = {
 		.compatible = "rockchip,rk3399-pmu-io-voltage-domain",
 		.data = &soc_data_rk3399_pmu
 	},
+	{
+		.compatible = "rockchip,rk3568-pmu-io-voltage-domain",
+		.data = &soc_data_rk3568_pmu
+	},
 	{
 		.compatible = "rockchip,rv1108-io-voltage-domain",
 		.data = &soc_data_rv1108
@@ -502,6 +569,11 @@ static int rockchip_iodomain_probe(struct platform_device *pdev)
 	match = of_match_node(rockchip_iodomain_match, np);
 	iod->soc_data = match->data;
 
+	if (iod->soc_data->write)
+		iod->write = iod->soc_data->write;
+	else
+		iod->write = rockchip_iodomain_write;
+
 	parent = pdev->dev.parent;
 	if (parent && parent->of_node) {
 		iod->grf = syscon_node_to_regmap(parent->of_node);
@@ -562,7 +634,7 @@ static int rockchip_iodomain_probe(struct platform_device *pdev)
 		supply->reg = reg;
 		supply->nb.notifier_call = rockchip_iodomain_notify;
 
-		ret = rockchip_iodomain_write(supply, uV);
+		ret = iod->write(supply, uV);
 		if (ret) {
 			supply->reg = NULL;
 			goto unreg_notify;
-- 
2.17.1

