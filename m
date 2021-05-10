Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC13377A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhEJDaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:30:13 -0400
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:51171
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230126AbhEJDaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:30:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHBY3buTrOA3v3qmVrrwF606A284JXS+gkTbRKlPGbZdIqcYidoZ3V8lKheS621x6Hfp6k7AHjnpo5br8X9ALbRiDhrJ3xxTgp1F0D5kyTnGJTIAyf+VIKcmhiEzEjOLb/ctakw5V1wkaOMlx5tQIqcyteylI51L61AtpqbfC/dVMK+FdAB7T1EtvMgjDTXQ/Nna4X/AMTEPQTIQ3o07CPoXOuun+6nUuIbiYBrs4BPmXrtolgm+0QaKfkbla/6GDlW+rk5IvsHM7eOOEQRKwMwj2C34XlVM3o0++X3Iad/Ecbch+u+t+X7ob6unXDZdPiF1otDzPV8p70jkAcqqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBtNf8hUw51xpYDxBFthFu3ihl0mHuIhW/BkcGUm2cA=;
 b=OdVXEX7FxV3/LRS7EVAMxv/VGI8mPMAI5Kwm+CvrkagblWsVDFiJe8wPcpsjBWJF4fKjWoHviyMxx/P2esP2O4S37f2pwQ3pNgDvD9tog19x6BXoonExJYCYXMG3p6CuEOhUcQFf+XqGbL3fgKW4J9SupjO4tlsturiEbhs8gCWz5kULhEgRMaZZS8+s5WQnj2/74HwwMnMs3+pQHv4QtM6oy6XvnVQTcr3gLkPdvCh4of1Z8Le92Tx2VU91a2zdR3ZxWr8WaNtSo4KUZ8UR+PqtbzWDXGAIJMmBSVsJD4vFj1VFqjepercktteOqjYdJxhDVYWi+KJohADekNWYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBtNf8hUw51xpYDxBFthFu3ihl0mHuIhW/BkcGUm2cA=;
 b=i96Zh541i2C6YBcoVDoDcRH9dGx+dSJsNEFuCBA2zgrS10F2ZyDWrzh/LGcgUCMyc2SnB0N+eew+4A3zaiIo/D0jTU3jkZsVJPIaFpUty02mcRiteQ6iRZfKfQIXzs3i0wORP6d0Gaag4z6FuNkPawlPmRPvb4o86FsfUQa2MyA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4091.eurprd04.prod.outlook.com (2603:10a6:5:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 03:29:03 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 03:29:03 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 01/13] soc: imx: gpcv2: move to more ideomatic error handling in probe
Date:   Mon, 10 May 2021 12:00:33 +0800
Message-Id: <20210510040045.13225-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210510040045.13225-1-peng.fan@oss.nxp.com>
References: <20210510040045.13225-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 03:28:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d43db42-4baa-4110-72c6-08d91363c26a
X-MS-TrafficTypeDiagnostic: DB7PR04MB4091:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB409128BDA32AE6B1DAC3FD0BC9549@DB7PR04MB4091.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D8HLD1v+YvQk7nDFULXkvzkD0oFYJqjbmuItrXeVukIbha00UHY3C/QH/tK4r1PgcTP7CiqSzY1iUkSuSczN+j/ZXIAi7hAOmJFyhaxPihQedFReyge25/yHfZS0CtdPs19ZpF5dYENNySae+8LPhT4EFGLfFLzUIfWb7xa/SzgIGyyTw0nBZqwPMJ6lHAW7iGO2xQ4aWyptECGque7+mbKFe03blXDr0LN8bHuDtQ+dDEKSP6TUUnZtiNYflgVJ0xwpL+TC7NsxCFv06a+n0FWkGq/FVc4mQlvStwPH1X8BLl74SVU9MA/jBmYC4d5TG9E859hdX3N2HiAJSk8gRIgR8T5r7GwnDXMZou1X/J8cDyn7a7n81K8tXvi+m4vsCIhFBZyU5Jsw4OO6EMmPXKfUubHCnObhPgMOsTEliUj53G3sht4LUsTJj8/lPhB8g4wlk8depcWeJ70ir/gEPjv9DUO/n71Ql33TI+OWmr/O/aRkR5zmSCvWMW7DTiM8IVRiTvzGH7IG1CUDCZSuiHdxSQB6lVwsD0lLw+S3V9GJDju7CqpveLRgUixBsgGfBD16kjMjMdTUvM3Uasz4Ivv90uZ9VqSOCgZbXNF4/osGwmS7WMa+PXJvu2MHBQyOv2Jfu0gJCjPTdXMUK2s9K/RWJx1tXxo+vwiaIan1zis=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(316002)(86362001)(478600001)(4326008)(1076003)(2616005)(956004)(5660300002)(16526019)(6666004)(7416002)(66476007)(38100700002)(83380400001)(6506007)(52116002)(26005)(2906002)(38350700002)(6512007)(6486002)(66556008)(8936002)(186003)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KnsAedUVZG6Mt7UthE/2ktt/Uk01xbYF3ffKdWws95WsaWRJ6t8ppN0ZuozT?=
 =?us-ascii?Q?76hcpOyaU9LnGwdKxxs+PPIUgfWFmBWe1tqtrK/KBvXC3iyKYVAkqFoatdTJ?=
 =?us-ascii?Q?brMmu0yxXT8TZbMwaV2yNHWtMu5oQzEM/4IlDEaj+QAQU82k94JSYE1k0IfH?=
 =?us-ascii?Q?LmRg6nvGS4HGZd6EDVLAWRR3g58g42wJO1Lzy5EgwYxvG9Q6IAG9LgCJyOwo?=
 =?us-ascii?Q?+hvxHeVdyoqtK1d5KldOQP0bvaI4PZid/OzzwnLehKI2UKGHzIj9V/lNxxkp?=
 =?us-ascii?Q?Wf6fuZ31nWFG5ZDnN90vvecdSVsITrocOiECht3tQ2hmnA6r5QKi6rb6M6jM?=
 =?us-ascii?Q?6ZW5fitVfh37EERzT/bUCnV/EoyMyQ3zAbkecS1IM0Vx9gLKj9cUuJkB4LM3?=
 =?us-ascii?Q?F1D4eJQTkBVLkCLq45hs1QigTl0B3pSmubJTTU4DR5kNohTt8jJ35MHKRTGT?=
 =?us-ascii?Q?/HwD7atsBLds8m4dLlrpzF4hMwAguE1J3jaoQbByvfo7f9YqokB134p9GtM/?=
 =?us-ascii?Q?VqVw+ML0fvNXyKFYTA5n+Z7+qV8mYHm9v8nuvVZE9qKR2YLc/gwxG/Wsb8km?=
 =?us-ascii?Q?Jfm2OHYss0KZZc/jpfB0MnCRWNdsIf6lUW1WRkXW9HlThrg8sTRGD2EwY97E?=
 =?us-ascii?Q?iFtE6jKVRipGETAwRMTLKYmQ39JNDRW2fwFBps1WiIem0jO1r4CMGHtybW0v?=
 =?us-ascii?Q?9sXSev1TWfJyi5X98AzYA5iBKIjjt5heUdw35idvWOvNzU7nXwsi99sKUwlo?=
 =?us-ascii?Q?Herg9PIqwHxeJEfMAl/tKa8xkKZRBQyLuCzljddTUpZWnjTSarRvi9G4JJ6N?=
 =?us-ascii?Q?Obfd0VciqEHjfE5tXX9XqKVBsYV7dsA4MiC9q4gch23Bih8OGy+otthDSLPq?=
 =?us-ascii?Q?FcRfCyCIykwKkYoyuHYje97Si1HXYm392tilbBd6iTMhdTe93l2TaTeckKxB?=
 =?us-ascii?Q?UM2S7b7a20D12o46sme3JiZY+ZqlGXMNcdsm3kBFk2ZUT85ttUFoZwlqFIz/?=
 =?us-ascii?Q?bOKYdbaez6xlmQN3v060/BwaUjK/2azU37pa0PCeDkwvwtweqJ36mtYLGr62?=
 =?us-ascii?Q?0Cl/Pihvh4wFF0k/UDtXmd0dYbXidUU49du5Gma3N6AVk5x7b7qhPmASTb74?=
 =?us-ascii?Q?XUeqOGTmDBmU7v1pSku4hlSlSvF/VSG/JjD9okenzawHCTxeXebyakYVnTRD?=
 =?us-ascii?Q?hkElD6x2U2TVX0EgVGQjDZGQnhiQ3jKZYy3qqqqbdXqVQLdRSlAccl03PsDA?=
 =?us-ascii?Q?y9l448DHpuztNKQKd5LykGECH1eBgNKA4hIL/7RWTZSsaiHWf25AQwcHtaz4?=
 =?us-ascii?Q?REV4QBOz/vKOah4qOV8C8Rot?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d43db42-4baa-4110-72c6-08d91363c26a
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 03:29:03.6900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0/bXl9dI/D/0qocnqS02MUFRqopycS8WT2T4Jhxnn6PcOGOhqiMP2p0KULKEAEnyaHuK1QbxT3ak0qXJUj5wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

Switch to "goto out..." error handling in domain driver probe to
avoid repeating all the error paths.

Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Marek Vasut <marex@denx.de>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index db7e7fc321b1..512e6f4acafd 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -502,18 +502,23 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 	ret = pm_genpd_init(&domain->genpd, NULL, true);
 	if (ret) {
 		dev_err(domain->dev, "Failed to init power domain\n");
-		imx_pgc_put_clocks(domain);
-		return ret;
+		goto out_put_clocks;
 	}
 
 	ret = of_genpd_add_provider_simple(domain->dev->of_node,
 					   &domain->genpd);
 	if (ret) {
 		dev_err(domain->dev, "Failed to add genpd provider\n");
-		pm_genpd_remove(&domain->genpd);
-		imx_pgc_put_clocks(domain);
+		goto out_genpd_remove;
 	}
 
+	return 0;
+
+out_genpd_remove:
+	pm_genpd_remove(&domain->genpd);
+out_put_clocks:
+	imx_pgc_put_clocks(domain);
+
 	return ret;
 }
 
-- 
2.30.0

