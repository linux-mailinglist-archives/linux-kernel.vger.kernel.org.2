Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2CD3E01A5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbhHDNHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:07:01 -0400
Received: from mail-db8eur05on2074.outbound.protection.outlook.com ([40.107.20.74]:50785
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238326AbhHDNG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:06:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tj3TLTk+A+khWyc8qts9NfwXx62oOyFkvhv1Ckqavwe2Jgg0D8jLKX/Z13zY7Dzy+JaCl7wfeTqVRcUHKHtjFd621LVepOZSQjwPXOb/bZRpO1n1pdJvzRCbYS5QgiY/NtR7gf3PSjNAqSryDgpql3ysZlN6TkddR938Vt/CuSQANlsTGp8N191LnD+GgBaSt2KkKU4XVozn9I82FwXbOGDFmE9JnIashPnYFWpBYBFY0kMoFzfKdIJUlYgAzE4orWfX/XmESvhji/WaK/o3zpL6NoyOCih4hKvDPkGYbI1OhjvkPPGaSnbE1UL4P1hXhwQ3QbMmyf5hcvs3WFQIqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3SrhTEWB6RsTJABTHRL98bEpe62oMj/f0PP0YasWqo=;
 b=Ah2cGhuf6GZEnKqLRILXvMYqBfM0+yllLiyz0zuGdOOVDyVE3ioFPgVsz7PiW7fS0oR6UPNYBr3TNTV9tMQw4KQ2dST1QImUqaWHwwuzXhHPQ1BMEYl+Sf89X/zeZq6W/P9NStMwBzcQm1i17/Pyvp2xgXXWVdsVXh3TrAi5xkoKImKo7A40yNMnP1tPqgVF49e+fFm305mS14MaIgQ5H8uNa4r5zOWW7taVW0Clz3jhyATEHjh0KNMldMtM+ZZXuAOPwOquajSFdQT64tYiuxlS4ugAotP3E83G24nzz1lT7U7XXkOCViW626sqRiZvZLeMxAnDdr7ZFDWXPDV++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3SrhTEWB6RsTJABTHRL98bEpe62oMj/f0PP0YasWqo=;
 b=KYpkK7parughIT1xcpWiA9Zl0jGykxQe2EahZVj0P7rPXGfiznImbJsOaFFdvwjtQESGqVuYOPnQsIXdRjFwOkbHf3idgHvfMqjqOm7ydAPixpZFnEWptXhW0VDGOI/Nu6WmAtr7PuWyi3XpnXpx9ZIgRXYIoAwnEweyRLMJZuQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=wolfvision.net;
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com (2603:10a6:10:c8::19)
 by DB8PR08MB5401.eurprd08.prod.outlook.com (2603:10a6:10:f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Wed, 4 Aug
 2021 13:06:44 +0000
Received: from DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b]) by DBBPR08MB4523.eurprd08.prod.outlook.com
 ([fe80::ade3:93e2:735c:c10b%7]) with mapi id 15.20.4394.016; Wed, 4 Aug 2021
 13:06:44 +0000
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
        Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 1/7] soc: rockchip: io-domain: add rk3568 support
Date:   Wed,  4 Aug 2021 15:06:19 +0200
Message-Id: <20210804130625.15449-2-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210804130625.15449-1-michael.riesch@wolfvision.net>
References: <20210804130625.15449-1-michael.riesch@wolfvision.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0202CA0012.eurprd02.prod.outlook.com
 (2603:10a6:200:89::22) To DBBPR08MB4523.eurprd08.prod.outlook.com
 (2603:10a6:10:c8::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carlos.wolfvision-at.intra (91.118.163.37) by AM4PR0202CA0012.eurprd02.prod.outlook.com (2603:10a6:200:89::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 13:06:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f26376e5-0020-46fe-1113-08d95748b57f
X-MS-TrafficTypeDiagnostic: DB8PR08MB5401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB540136016B8B46CB5EE02F92F2F19@DB8PR08MB5401.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uspHaZluyfk2F4BJgrs3rHWtgBSL5qis+au49pRRqSMcXZZ4ZBt/PvMfJ0ogPXMQa1Pj6T3dkLV2Y4qgT5BWfUe0BXe9kkgT3B8XlAV4OA3dyGObqrLrzm5Z59YwDb2/ScST8iJqac8WSlxcTnO2PSwoDNiuhoSP+4LIclC9LR1BOEb7DLbEZG6OBiDj+LW/WNrUyK/uoJXStL0nsEagPXs2N7PN0tp5LjjwnFXybEYzRaeZIxB5g/BXZM0lCeY27uuATRKnS4C4Hy0IRVenTPVpVFX+wXs9y+WmWfffD1vLV7GpnU0rzkneIVvcXWokxn5rIYNx0GrQT1+Q3jcDHs8p55hxUb+ePOyy00Bh4HV1QmAfJbCRy8cLe7ZeBut1mc+lHitMg3AB27PuZeGeLrMFGlm3kCkw1gwYzTzzldR6WPIddDq47UQlV1Zm4De1FlVxVg7I6qIBJ2owH4G0UVXuxbsbcfjN8QiNjDOlWwXVfNOzFkgDufg462b+uyVmIPaqIUJHScZiYjckPboniKQPO5q5lIbQqEOOT1NlK7emxlEeA07UxGqjszeUby1qJO65OF9eJT/xHLY+Jf6x7ggdodJkMhF92IvHoi1NyF6rhfbuJM+Qys21NAmnxueNjI7lNSeYlkvpaDA3kt5CQM2l+wStnCsTCQ/OvBM4hnmfWAgDXzVUabYOjyrmkj1WLGaGZTEWKiMxSZIu4uqtUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4523.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39840400004)(396003)(366004)(346002)(136003)(8676002)(186003)(956004)(1076003)(7416002)(478600001)(2616005)(2906002)(66556008)(8936002)(66476007)(66946007)(52116002)(6666004)(83380400001)(54906003)(36756003)(38350700002)(5660300002)(44832011)(316002)(6512007)(38100700002)(26005)(86362001)(6486002)(4326008)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1U984eUh/OXHDJSNFO4JlVHIDL3VdjElmXpOUNqz3SEUPIo8VdEI14xyTJO+?=
 =?us-ascii?Q?xU0FgZyC+VqgsUMRvCpYxZF32AIWYHdxpO/4Jm1lafDSl7ToCuVmf+I0jdLN?=
 =?us-ascii?Q?b819ZAz8k8yi5/TCYef3LN963EZ1J3X4Dt0BPOUAZuHSq132ZHCvHAawll4D?=
 =?us-ascii?Q?lmmT1ySC5D/sP++qx/KrflVDOpzHeUSYSlbhcHxq9C+Bbp7UluHePjHY/nQ7?=
 =?us-ascii?Q?C/UXm28ChTXLDvOpv4NEWPq+LmF+JlF3f+HN8OKYfAE6x9eEeiGXOJiXcIsw?=
 =?us-ascii?Q?r+/AxCEyZC8XdqEz8oT+PzhGmtvqvyDSFGNSRpceubapNPSAwuO81uN/EA96?=
 =?us-ascii?Q?anNCfH37GlMz8sF+hKq5S4/jPNFP2XRTQb0JcSFv1CWd4Lc9A1MHLvENIIcA?=
 =?us-ascii?Q?/Ew6AVYnLAbMWn7gA0BQsH0NTPufT4NgkDF5JGkbTklv72fwD+608j/JC3U2?=
 =?us-ascii?Q?zx7ptwhqPWz7vCLeZmm76P2cVtnO+OhINqPZ6W17GkM/3jWTCwqGPqXPKvWn?=
 =?us-ascii?Q?VbXQHukzLILWkmGIyExfugeCgwf20XgrV1+6U+9JapTejPrSNGkONiaFl+Hf?=
 =?us-ascii?Q?L2kN4US56Yq40Xy25EcTncNS60tJA2uZvGz2AFsnBpKwBZjZErFwfE6TuaJN?=
 =?us-ascii?Q?iKDqEV5Ar5H7IqBdyZnPXCaeXl8zw1xa4SPT+znxZ9f90ECkKlrNZZ37tDd0?=
 =?us-ascii?Q?QpNRHOfNglNdrPSHFiMKhsGjXYgUzUKkbqsW7Sg444J7z0BUM8tMOyELeJY/?=
 =?us-ascii?Q?u85LS0g/Tft32barRLvUUr+ZaoO6fQlDgqOLXm/wVQkrBOhgxKHZL3CGDWaE?=
 =?us-ascii?Q?aDsAEmpNLK4acYv0GjViAT7jpUXdfC/0e8Ji3QZQu/KiZiAlFVbsGDlJa9vF?=
 =?us-ascii?Q?vbkRVsGav3e3z3s2a7wR3Ag9FPSfyQ8I6OjvuzBLJUDrfKfsjp+yDGsZvyL7?=
 =?us-ascii?Q?lfYd7qoqoo4KQtma+M2J/K7zVKAziXiQn9vznrNfXKoImqd5ApBOZ3TXVcgN?=
 =?us-ascii?Q?Q7dZt+WpiIWp+H41HYz3aYjJT3apZ1dkT5Q6cAWHCG3l4Tb/Fd8cHL7mFf/+?=
 =?us-ascii?Q?LHCdGYiVXkFkcHeaQZDNiTaRoYc2whGdDOR5Nhmj33hiznP7/PA6J8yrbzKq?=
 =?us-ascii?Q?E+hytEv6MKILKj9KA6QucuWMu3oB3QAGFXrOUPeO0f14FZ/enuLVVysaSf05?=
 =?us-ascii?Q?nu8ewI0z+JY7w2XNLv5xsEAMavOTfKOIn8VEZhmM2N5jxP8XZ3t26eV5wYnu?=
 =?us-ascii?Q?kyAcutpFZ4pDbZBqJzsGS38GoguUxKOsbEpaqZDkmSYj02cWZShcyoOveAZi?=
 =?us-ascii?Q?98oRiw7GkZAYCitNwkpbOg97?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f26376e5-0020-46fe-1113-08d95748b57f
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB4523.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 13:06:44.4910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1auCVnimmzs6JGPXuFkP0IQCIY5FGnINEThmLBhAm+ckdgUlw/O07mRQux/+8aBgCbxGKCYwSk0L6esr1mvbIgG/Bxj/+/yHMtVZ1fsnu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5401
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
2.20.1

