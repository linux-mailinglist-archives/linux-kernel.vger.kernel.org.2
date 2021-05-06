Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E280374C6C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 02:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhEFAe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 20:34:27 -0400
Received: from mail-eopbgr20084.outbound.protection.outlook.com ([40.107.2.84]:7355
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230335AbhEFAeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 20:34:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meT8QILuKZFejbT9JuxQO+nIRiu4eD1MwMXlJ652q/guEX95JjzWDn5UJis5Nz7Dy2TTMgc9rYKQ3ZxiPPJUw9c++BnPmsp6mbPmGE58MBNF2IS/GjKlbSmO5h7jW2s/6WnIpdLZlKWelUngsoyyF37nXBMnFA4ZVGv2qahJyt7RDKkOEsmFCJNfETOwh2iV1rlh9rPnWiQQhGp75WiHSR7Npi4L6NdJ6DPY7sOHeY+76J52YWLGh6a3H8TP1jAe/IUdXM1+jaWkp4VJHhyJjzsvd9IygmophqBZ3P9AYjbPcDHFIOG0ElHkWJMBbcqVpqacFlLNoMuZQF6/+Znp0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPE/rxdTRtEJdBlQ2Ie6VPB8afos6/Z8WEhpD5L4zBM=;
 b=AfQt1lta/wseO6XRTANjhN/dxIAn+hszSS0gQJOJNVNH6gGokEMhjGFxHe9F6aXwsdeX0e7mzMQt8cjDY8ETZ95b9UDu1Qv1NkNePqPx3WBTGR5jiAwowBvFfO9w88Fs3ozscuGbgoTCyBMARpKcwzY3P+oiphhiTN1ZTn5h4t4QH8FHV8dZFEvU4XTfJM5cOioyqqsKH+0MVjX4PmZrWrgkTUiQ9JZgIODexsHe+idZ97tiI3cLE75qJXs2IlUT+Ef8/SaFQSstNhw4DCJmQIh1HE+KW00baCkfVhSWG3/SZ1UHrnmqSeZ2cJgfsTX+zXY6gqeDTHQXuwplMFcxaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPE/rxdTRtEJdBlQ2Ie6VPB8afos6/Z8WEhpD5L4zBM=;
 b=h8CZRH2kRbMoLYcInqHIN4az1maEeMq0SxdxNjVrIFml9MDDD64jkfqxV95b1VQBqjXTAuUpV3eSSgw44CuiDbVpipf9h3TZWN7QBYGki6bm/lQhjsQGiiwfrCE2J5+4xJEuWcFWo9A1AGVmVZ5LuwwhAkRCy5cJuWE9L6djKuo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6714.eurprd04.prod.outlook.com (2603:10a6:10:10e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 00:33:19 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Thu, 6 May 2021
 00:33:19 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 09/13] soc: imx: gpcv2: add support for optional resets
Date:   Thu,  6 May 2021 09:04:36 +0800
Message-Id: <20210506010440.7016-10-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210506010440.7016-1-peng.fan@oss.nxp.com>
References: <20210506010440.7016-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Thu, 6 May 2021 00:33:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a886ec2-1d8f-4762-8175-08d910268bd3
X-MS-TrafficTypeDiagnostic: DB8PR04MB6714:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6714B985BE34F116D562D984C9589@DB8PR04MB6714.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /khaKrQHtmBtGiRMl/kOajzuoxpoO+loJaNnEeNuE0+aUaDNdp3J9SLpaIb5cjab4SLpyqM5UsAM9CdtVIDq5vKg/ix8IDPzm9+mdT6m3mTV2MHn0xuS1gykFThKPFGBDJHlc6yro/+05BfohwMaTXQe5cQdIl1gm67I0QnKDOFlee4mlsIT55PirkNSmmoPbisT51bKdP6MEpiHwRerxmeHBQ33YZN214xf+RuR6jZnaVJqMHm+mP3TfaRs9wupd9U4bBrQpzE6XLKImaqiT5oRfWpoBHddqq4It9qfOnDUT7xJtyWt8R+Z/VfKrApQBr/OAgWlxNesf5T3YZzSg3Pf9UttVCMjH7q1PrIxTGE9xfJtWDPA2ASvOINOtgXGRv0xrIQsNeIqmK5hEYxxWAFAGFekT9yMoB/5E2fvwYQPZ7NJ5JQg5O4vYO9CY5RLSAy7OdiQspKzDp4m46N3ZStkTA6HNoeIXadCAd/c9DYS3rVZponkfE8xdI/NhegH+VRFRr2OnD4yz7vhFlshRROFH/YneyBEWNnlQePP/MtOCC25dH9RUaxbnuPCbAzaX60qXI+AwDCEbkt316rOpOZsCThvRXszDQ1vE3Elkj9Ih65FftjlQj3WI2OkmTRvaiGfpRJH6HDFCsSzsM+Www==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(52116002)(86362001)(2616005)(16526019)(83380400001)(956004)(6506007)(8936002)(5660300002)(7416002)(6512007)(6486002)(316002)(186003)(4326008)(2906002)(6666004)(478600001)(26005)(1076003)(38350700002)(38100700002)(8676002)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FP5hNO/ts8C2Wjwj7yHv3AByHjgIFPVDHAB9UrBtSOLzpiRXjqn9VFtzL7j1?=
 =?us-ascii?Q?tg0QWIfV9wnrM2ZReZOy2JhcuA/HCQ8j72hmQkf61zu0tyEF1snmK6LlC10r?=
 =?us-ascii?Q?fEn7sC93icFLYrcZ2QseZ8JWtjJcM5mjmBi+D+ARGbSE/n8wzR2Z0GUhz8iR?=
 =?us-ascii?Q?PrN50Fzk5F79Zp0COg9o5P7Q4JfDr60Ul70dH2ljSJrkNtM/Zf9W5tXvw+K/?=
 =?us-ascii?Q?XzaVSyYbeWVlxg76WkG+r5GXwtHhBTkcqP3UjglyxiH6FdnQA91dGP0NBhi6?=
 =?us-ascii?Q?PtiQniVUBfNX5C0ESJjJ2vVX+DbItXl9nIqvxn3ROKb3kKCwJufKDri5QpkI?=
 =?us-ascii?Q?BAxx4KQdsbq0S0F9Nn1ksaaSiiBRwgWXt/tU3+O96gNfFmNrTSUo6trzHhNK?=
 =?us-ascii?Q?DwuKZweGoi8q8uDr8UWNiTqTzVykL2mUs75bpJxC1KQtPIZFkU4c7c9/tvRz?=
 =?us-ascii?Q?9DCf8r9OLN94x26PnsiCo7SeaxZWDONzDe8li0aYphuC7YtdVNQ9qMcl5Jka?=
 =?us-ascii?Q?LljpVBpCCc9EMTGaAMvfxkQcNRpsQd36u5jgGTwWirBFQuEIeZkI0EKO6jOf?=
 =?us-ascii?Q?lTy5Y0iNSH1gnibhK/Qp0AD26C2ML2mzn/fNUaU5b5iVVZ5KFkVB5x2eAZjf?=
 =?us-ascii?Q?3X4GJvv9ES+ML8ix9HktbHTnz2tK0NSqAp32L6+l+UiD9us1w79tqpzQ3eaA?=
 =?us-ascii?Q?RfHLE5WTMVlT4mVoTd8mjBsZ6ltQgPrVvvOvs4EtghD+1X0mAZI2OX9roYd1?=
 =?us-ascii?Q?hrbhso4X57mdKngbD7mpvJ8fI0f1ZlJB6JbJUNiT/W4OaW8dasiC7epx1wcJ?=
 =?us-ascii?Q?v6qnOtLsaaZC0a5KxKf2md/rNIo+W38RBwSkT/yK3FJckMok9khQPNJTFszz?=
 =?us-ascii?Q?x6ZKatrVmad9LT/A4OX/rznsFOZfwX5wQXLQRabXc56Nr0dUkgDBxeMvKHAM?=
 =?us-ascii?Q?YoErZ7GeQCttwBbdWvvstXC2INEziB4o6NlRRT7SnTjD79rGQ2piqRSNf0fe?=
 =?us-ascii?Q?MxxZHsxHVABJ71UgxypQME5h+ALtbgU+bCHfqV2Ddi8X7Qn53VcSID979YIu?=
 =?us-ascii?Q?QavK9mOtvmei4NiExm90ghvjclK9paqUlgOUadBhADYLui/IioPcheeXF0p9?=
 =?us-ascii?Q?cY735g26OL33oeosybpSaPmDNg//ENcXTKCKtc3C7sjEs1BbjILxq+9SBTrP?=
 =?us-ascii?Q?1X6Aq9CNeVE/CTBxDbeTTbG/akoxjyuiWmS27KpxrKOX+mDgm18HFp81yX9E?=
 =?us-ascii?Q?jSEeUnH8wie0pJprDnlm0rSGZpglGal9cZ+J+dP228e1QluAtat7P/EnDF9Z?=
 =?us-ascii?Q?gn+WC+rtyO4aUwHDLdn+92HG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a886ec2-1d8f-4762-8175-08d910268bd3
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 00:33:19.2070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfZHTaw/JSjlELj6noDYjTujdl35PR7uoagyCCg1yMXJWyTvqRd4HEGRHHbJlwsW6+coJvuyd9xdrnY39qs0zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6714
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

Normally the reset for the devices inside the power domain is
triggered automatically from the PGC in the power-up sequencing,
however on i.MX8MM this doesn't work for the GPU power domains.

Add support for triggering the reset explicitly during the power
up sequencing.

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 0428f0eddee0..341c2352ca08 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -15,6 +15,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/sizes.h>
 #include <dt-bindings/power/imx7-power.h>
 #include <dt-bindings/power/imx8mq-power.h>
@@ -108,6 +109,7 @@ struct imx_pgc_domain {
 	struct generic_pm_domain genpd;
 	struct regmap *regmap;
 	struct regulator *regulator;
+	struct reset_control *reset;
 	struct clk_bulk_data *clks;
 	int num_clks;
 
@@ -163,6 +165,8 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 		goto out_regulator_disable;
 	}
 
+	reset_control_assert(domain->reset);
+
 	if (domain->bits.pxx) {
 		/* request the domain to power up */
 		regmap_update_bits(domain->regmap, GPC_PU_PGC_SW_PUP_REQ,
@@ -185,6 +189,11 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 				  GPC_PGC_CTRL_PCR);
 	}
 
+	/* delay for reset to propagate */
+	udelay(5);
+
+	reset_control_deassert(domain->reset);
+
 	/* request the ADB400 to power up */
 	if (domain->bits.hskreq) {
 		regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
@@ -540,6 +549,11 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 		return dev_err_probe(domain->dev, domain->num_clks,
 				     "Failed to get domain's clocks\n");
 
+	domain->reset = devm_reset_control_array_get_optional_exclusive(domain->dev);
+	if (IS_ERR(domain->reset))
+		return dev_err_probe(domain->dev, PTR_ERR(domain->reset),
+				     "Failed to get domain's resets\n");
+
 	pm_runtime_enable(domain->dev);
 
 	if (domain->bits.map)
-- 
2.30.0

