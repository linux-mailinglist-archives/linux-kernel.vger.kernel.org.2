Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC824374F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbhJVJo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:44:57 -0400
Received: from mail-eopbgr00080.outbound.protection.outlook.com ([40.107.0.80]:45377
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232469AbhJVJoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:44:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=filwqDSX0boe9aGcSWBfUeb7ZY+f5TzPpkeezXcUm7VBSrfs+qmc3rAOil46sFq5GeuvhC42BvqbMXjJ3mVP3KdGF77fyn5tqHIeg/cH5V7kQ0f2WV643caovsybNCZa79UEt5XxwV9s10XPlBQQ5m5uRPuh48i0r0MP/r0Vzwz06Wy8E9DCTIn/ZfGpsmpQ0022ZujafpP0O2v6sjUMPoMxnvC/k7a28cdyqtKIAujHJ0bx/0zl+S43tnx3MS5E+o+9yPQnyV8MILKKs8vtGY9ez5PPO5PqTvY2ke8lCZPKNYFYYDENRG5xfszcKcx9nWLvuOxXR2pcJY/jblaf4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YipuAQAD4CJLqfJX+8hw4s3DGSz/u52LLDidJ1QJz2E=;
 b=PzRs1Fr6E2XCXGQwWGZFafRkMS/wgkFine4jDX3GLxJmSeuAqxVndzIEtK3dMBOs10rKrKDIMA0IslZvrCqwDkvj/a6OtkYvhrL12JB8wI8vEeyEuwPRlZr+pBoy8g0IpPDqL4IRr+VqQKaAcOUtlIS5bZ+PbYi/eclPf3uPZ4QVOncOEEzDELk6JnY5Zr2ignf+mN6koTmyiEH0u3llHYovSYGy2aH0CJaCuLypsLsTm/M6khgsieHwuYEuINbn83B9RD6iKBahL6YMo0hzTubck68qfBsD06QarjlxfXkS7QbDxbqAtLg59FQp5PxoNxUFmL7biV0WvtCPyMhKoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YipuAQAD4CJLqfJX+8hw4s3DGSz/u52LLDidJ1QJz2E=;
 b=Jsgv8UTvz/9kDwAN3uyXpPnC/LcuOtAyeAEGeh1lJ/P3fUVgtdgqdwBrMc17YlMDNQ2OyqtDJRFjJd1xZ5Iz19aG14RTNts8hmuMuhEhykpvSsgglZtk/Yoy4jD41YBpHa1gp2zK7TQwdP766CZSmGWVUATJpQQrYeTfl+LdQoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com (2603:10a6:10:2e3::9)
 by DU2PR04MB8792.eurprd04.prod.outlook.com (2603:10a6:10:2e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 09:42:36 +0000
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::b928:9230:aa10:639a]) by DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::b928:9230:aa10:639a%9]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 09:42:36 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: mailbox: imx-mu: add i.MX8ULP S400 MU support
Date:   Fri, 22 Oct 2021 18:18:55 +0800
Message-Id: <20211022101856.8612-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20211022101856.8612-1-peng.fan@oss.nxp.com>
References: <20211022101856.8612-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To DU2PR04MB9020.eurprd04.prod.outlook.com
 (2603:10a6:10:2e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR02CA0016.apcprd02.prod.outlook.com (2603:1096:3:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Fri, 22 Oct 2021 09:42:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25ef42f1-35ec-4725-58a6-08d995404752
X-MS-TrafficTypeDiagnostic: DU2PR04MB8792:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB87926519291811FD58586029C9809@DU2PR04MB8792.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G0E8lNEkszwYq8AHzJMvIc9WKvGxcs6O6AeNkUTcw97Sz8BeikZDR0Y/BFa5vuGkBGTx30xqah+cb3dHv6cho7a53AVKTp3hxqPA6PdI0hq2Z9iEQUD0o+Q8nW6SYFJD2Y7OAADuFddVwWtu5FWK29M+QGAZtqZqscTIzy2dBCojN66yqZQ1mw/VJlujfYba6gYJlS97qSnq/w4s2aPxbkDPeCtxOtc0JmE42SjcNDZ1Oq03vVLBBPa/732Zp69qwnlpyu8HEwi8ep2oVOhBW4iggdBQCobUJbF9UhInPNM2e+p09/7A7xyTlR7Ac8hbO8IwUoWiWxzDIhO8UW7t2HaJ5ddQjNQSQx4AK/0XMPYkGlk+RjfkAPAFbbX6QEo1m3iW5qoax+XC9yQwdHN+XyXM80NClLSF1x5c/h2LeBc7wAMe50YZ6iQXpWe+hYJT2tKozCzoITMXLiJz2ELnnMznAMFFqcaKI/y68kJ0OiVgSFrWYjCC6OxN38FSXKbQMrAP7cv/yTDVwxqY6wrSVla67/6kHY+Ie6v8HV6VvOav2/r09dBC/LuqnNDiyxnhY/B6cJyoRky1GXwtwfk3BP3nAtJ2MxZKSxqCQK8KGZ+0IEx4ujH73uKWR9VmJv8F/fd5eIMOySDL9p/Rm4aPKrUgIM0173RwR5aa++qXHmeQJkcWNt/7YHcfLCcSxseDDqur3pfQYbHO50aVqIF/Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9020.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(186003)(508600001)(956004)(4744005)(66946007)(1076003)(83380400001)(26005)(6506007)(2906002)(7416002)(15650500001)(8936002)(6512007)(86362001)(66556008)(316002)(6486002)(2616005)(66476007)(4326008)(38100700002)(8676002)(6666004)(38350700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HH3ISmk09vTfZm/lxuOcCX7xKETrXe+dhUuvs6LjkTOzJY2s7/ixWUxYRzso?=
 =?us-ascii?Q?7Q6tL/ITTutMOWhHkheSia1dNuITNTba+0IY4Zk68biMSSlWzlOZyhZ1jkKa?=
 =?us-ascii?Q?QwT2ruEthmxE68WmQpUYeFOOcZRUEcuJXQ74qk8fXld5Yg97GiNsZ+xqOdtB?=
 =?us-ascii?Q?/Ccaoms5pgRMuqEX4Ij1FINCjEZq3bhHg5kiFVaBggfZMEhGPe0wOh0A3xbh?=
 =?us-ascii?Q?+McEJafNe8c+HyKuTQDZ4wY10dV2U+DVkD2SMBqOkqPl5+ccXffZzqi6YMdY?=
 =?us-ascii?Q?9ad7WJYhWxou2C+aGBwt4avP9D066staw32kvJZbNzfOWmER3WKZoeNl6zkJ?=
 =?us-ascii?Q?Wm32PCAX7Cvc6MN09JeIanbAgQb4ilVcRFH3McdpabiZqws5PU6dWa1utmnl?=
 =?us-ascii?Q?49/TFqe1Ys6lLbMdz0CQ1rzRd1TaZkAzfucnIyhT4RpbITfQFS5gA9xotIO2?=
 =?us-ascii?Q?Sy1DXQwgzhtim/KOsDuRtsseWxb4/k+MfygIMErm+ZggaWSl/n4PhKh7qnWO?=
 =?us-ascii?Q?cx9L04K4CvYmNoUHTqVHE3H5TjujOdn4zRTYaTXa+hPnozyAErzISYwUv8rK?=
 =?us-ascii?Q?825weuoYvC3hiwQDOz8ohKE5XaFDIiOS8rdnPUj5Bu5rCIJN0rl9kfcqkoSx?=
 =?us-ascii?Q?taFjnOg4HJj/r4ZyGc2kahp4woWpj1Rfdm4Cp8RaqFemmssIFFU0KSTobxLa?=
 =?us-ascii?Q?L4OS8pe6aNQkxSY+XOk5/uTyNHCBnmA54J/KyfZ5mlda/BMMFKG5hBwL8Jk4?=
 =?us-ascii?Q?vt5okiYfz8VyrGNAuklcLUofgn+O6X9qaDwJ2Vha7UP6SkktMzsIkapasGxX?=
 =?us-ascii?Q?ajHgNniY8xvw6WtuCL1CTQMVbAPIBWcW+E4Gu6vPo58MWPgiGiREPG+5iDpR?=
 =?us-ascii?Q?IaQKPPkx7jlQZ3/sj+wdn+/kLarsYnmHKou52yUc52lSjmbUqT6Po3gFlDso?=
 =?us-ascii?Q?11UU/6uRC/AVcyQTvKSkvrf1cneOvEttn67aDFRaaqVr+vLqzoVwWGos5/JB?=
 =?us-ascii?Q?Crl30XG7osapyu8IHDbvBzOEuJ3vY3n9PLdjnSThLehNlhpNGtvWQ8OqJrgZ?=
 =?us-ascii?Q?l0QQbrPQvK7rcwEJYVqSQNE8jkCfrc0umsb65q0siHtekCvB2QRyjZt4s06R?=
 =?us-ascii?Q?sEWmXqs4JyRBYEK+kCpWf3w3Ds/f6/pfEup0w+8Zu602Ds6F1oZt58fWtjo+?=
 =?us-ascii?Q?x4Mlef/RlvN4owUUm98DXSALxrsRFHRBotMm1ePjfvzU71qh74LCoSOabAX8?=
 =?us-ascii?Q?oDK4DXqHILriSxFAlrWInh+NHoTOtrr7Gu9d6im03TpWjNqyUIB3Ed3EznUO?=
 =?us-ascii?Q?XD/KDXsDQv1N+0mlV16EgPFTnAm7XgigHy9ir91gsfYlxNTmOsQICtCaRJKE?=
 =?us-ascii?Q?Yeczz2t97v7ZzXhcUwQMwQoX4V3XU+g0se9zKCung5nYPJhp2iQrQcfS2rAw?=
 =?us-ascii?Q?LEeQQrysTo4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ef42f1-35ec-4725-58a6-08d995404752
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9020.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 09:42:35.9677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8792
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Similar to i.MX8QM/QXP SCU, i.MX8ULP SCU MU is dedicated for
communication between S400 and Cortex-A cores from hardware design,
it could not be reused for other purpose. To use S400 MU more
effectivly, add "fsl,imx8ulp-mu-s4" compatile to support fast IPC.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 675ad9de15bb..a337bcd80c4a 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -28,6 +28,7 @@ properties:
       - const: fsl,imx7ulp-mu
       - const: fsl,imx8ulp-mu
       - const: fsl,imx8-mu-scu
+      - const: fsl,imx8ulp-mu-s4
       - items:
           - enum:
               - fsl,imx7s-mu
-- 
2.30.0

