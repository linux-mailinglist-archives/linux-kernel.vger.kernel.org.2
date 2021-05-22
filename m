Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D247838D5EF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 15:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhEVNLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 09:11:48 -0400
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:8967
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230431AbhEVNLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 09:11:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0XO4wJwZqF+v+9hUu0PDY9ixB85a+NYky91aqtE2fDQDC6jXIRDarhbal8yClQoZoL9tQgKplzv4xHrF4iXW1cnZwtgSQFFGQ8pIUKKbfCYu5LllqBY/v2Pf+UZa4JJzLk9PgJDenTyfjYMXLbrrG3tQKV7lvr23eVmttsWTjB7ZqULoQCcAhbuqsfP0867BNjWY1xPm9IC78NGAfKrbXPRQ3HtS4qwCwbXzdaxEHV5UJ97tCFheKSTA6CK/bSdiXn3A7Yv3TPTLNM66zAJOjuiJv824RYnOw/9YZqSbIjtdB9DNG/ErdK8EYp0B7I2KVi1fZxZKqX5j/SODNyk2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/woyMMdDjmoLpw+OB3GH/kDvCzq6VvqWMWVeZD4Bi+A=;
 b=DcNQ9QgIfelV635uSpa+ta3bKgUsdBmpFc5m2ubrGCx9HrPDhkOr1SlG5hyB+ZqZxAiLqbYwGJ+qSDMop5RoiiOHam3OwsG4YHOB3NzBS9O32laFiGJxIR9RhzG8mnJnxXIeZMp2ZRM8ptZuiurJFe1YlIctaCJ0VKjLnDUq2oKEDKKb3WGO7hZPBV7bJgoJ4gSlLoFeFu1K8nMuJi/WjujQ0+PSOfxlfBLgyG6jrq5/BEm5Uc9lpuei8UfjUC9J7fDzTcjK1Q06nJHw/pbigtVWl5/c8jNyzBJ2HMvjKqB2Iqq39whbItvM/WpGrZLxbfxPVlWJu1Ik0kAvt3NC/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/woyMMdDjmoLpw+OB3GH/kDvCzq6VvqWMWVeZD4Bi+A=;
 b=NgZHk12/XFBcfReO9HUMF+JjZj1Hp4eHQdWMDQWvji4JWFBvykrmqe3a+twgLufxqoeV4qCHSS4RDsynsKsT5uRxcy3jdZ4rgIRuKNqnVwzh6nkO2qEkl6E6bBP7cfi5z0dzTZo9azazofJcTRWAOK6c0VenvpQkOnl1lloHHsk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB5658.eurprd04.prod.outlook.com (2603:10a6:10:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Sat, 22 May
 2021 13:10:18 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4150.027; Sat, 22 May 2021
 13:10:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH V6 1/4] dt-bindings: power: Add defines for i.MX8MM BLK-CTL power domains
Date:   Sat, 22 May 2021 21:42:46 +0800
Message-Id: <20210522134249.15322-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210522134249.15322-1-peng.fan@oss.nxp.com>
References: <20210522134249.15322-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Sat, 22 May 2021 13:10:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3dfcece-6e45-4183-a470-08d91d22f1f6
X-MS-TrafficTypeDiagnostic: DB8PR04MB5658:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB565810C964381E5A695DD350C9289@DB8PR04MB5658.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+kryYxwBZKwCNF4M5OynlOt5nsZR+QOOWf986XSt3X8v97erm0NDVi2bQt/6XKTz18Pkl8LhCY3DATM7hsyMjy8MIjIHD1DJnKtJ7tgnrYdsit8I3zksxVcuGZx1D3G1zl/Ayn6/IKkIBk5GNmysoaCeOoB8YJKitSEug5tXoRCwtiaujnvh/Xey0TaWxJuoIn3Y61z8jZTd8mceUYu8DcxWwaDpRz63/ItuMCfTizlJuNSmf8oBcpw1baX6ALZVcEVeCCY9UusfylLoxsIN5A9BApKZWsiwHG8fovPNsfF3DuvoTHiIqUG1cOSVpcUiAn/EDlduXLw2dLYSxkmLmL8B7K02KwSzCCDFKKWlcNTRnToMmU+8ynTnK3ozx74rz3PBRlcpb9CiwPI1Zp5dOOyEw++bvebRGglajEHkjCtmmGRbwv2JdryZCM6p6uZPyb20pAnOFFd2DjiIVLkXschI8D8KiKgXt1xbWs/tj+9Lj0CbcC1wDDDchLheCC1GbJLPYVq7n5ff19p2gpXfHFkGuoPCxtv7Ph9mETZfs3p/HN8U/gQUrKhTbE6TEGwOug5kTujeeHZNlp8NRb0e5QqFmZciDh+AHOHuthGzlwpPcC4n1njT6HZJXtV3v5iyX92wwH50BMTQ+3Yaue9jyvFtDdQzRBbIS1we7k3A18=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(6506007)(66946007)(16526019)(66476007)(66556008)(186003)(4326008)(8936002)(26005)(52116002)(6512007)(38350700002)(38100700002)(5660300002)(478600001)(1076003)(8676002)(956004)(2616005)(54906003)(316002)(86362001)(2906002)(6486002)(6666004)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pM80qOQq6VQFnlKJwq15aozBB3ksQe9EfO20ubdGYj76z6ILrbjb7PCGuB2I?=
 =?us-ascii?Q?k0hgisZb0ppk6oQBrLtAO8qMmmMWXIQLxSeUdeiaYPtNCp6G2kXrYfchCZvm?=
 =?us-ascii?Q?Yzj5+b/7tZpWf31Lslp0oWErhc1+4CDtoXFWll2nXGepma/GIzB15HtMMIl8?=
 =?us-ascii?Q?HMhDoS+4qMYat/+H1EtltEXmOktiy9Z3gZ7LVjyeiI9AP/MDCSCKsZE98h80?=
 =?us-ascii?Q?6yqMpJ5P2LIsjg/aPG617h5dWFtUDtkIVyAJ8gkMNOEjHpH6lw2F7RW0K1KV?=
 =?us-ascii?Q?6vq7gTal1CM7zL/YKb+J33yCPImRYTYNZI78X22kD5ZSrLFlDu1AWXBfv9tC?=
 =?us-ascii?Q?1Hnt4PZxk3V8tIjGizhboZG/wZOCHOo3cX2q/p2fMivY6qjskYmhQ23alwo/?=
 =?us-ascii?Q?TU2pD3mCNu3TSZ12QlDIfpgjmY5JYsmFv8Si5H/v1v1QyEX8QNHlm5YxgErL?=
 =?us-ascii?Q?OKNsd6qx5HMRaJVebwn+fXvOP24opACmyNryrVFMHS7vpRn5t11YYuMMfawN?=
 =?us-ascii?Q?btNvWt/vitA7/rpP5VGQaZ/5A9MA7CmQUWr/Xe0mHtMJrh7Rhzy+wpie83eW?=
 =?us-ascii?Q?1V8zvFNqsy34hftF5/tyZ8sMIgFcd93e+SlcgoqidmaKgvNnNCgNDstuFRB7?=
 =?us-ascii?Q?9dFRoER2JPZG9D1t70VRll/kKYSx0f+IKFay8HXfbiPBtYd4wzvL1nQQ+FxG?=
 =?us-ascii?Q?LCtwGyaJ0tE8fHPKQzXzG4oFNV1sTWvl0cCqlraerGix0T0tcnhjddYbI1Q4?=
 =?us-ascii?Q?zBnnbxqMzrQdYJZP3gGS+LP4ZmvFvGbVmz2LaP9adRw9TLN4Mv9xjI7/lApJ?=
 =?us-ascii?Q?z5KRGMupBVgXyUHN+iUpvgqqRCj7oihZz/LmxubFsauckJk67ExeSAp+OU8p?=
 =?us-ascii?Q?dc7Ehkg6Jfsoh3YhaQ59Sh7LtYIPSUMXxVHYz5QeeXTDNIJXDdvqymXGipT7?=
 =?us-ascii?Q?C9ZYOrcFO470PYzGRaCfB76lv7qMxlrdLBddAevdmApJXQSgDlk6Xv40OBb/?=
 =?us-ascii?Q?4msRf8FfxZ4vEWEXyRbyeZbxQIwcyONCT8eXMujRRe1iKbB84VRAgEhlcOVf?=
 =?us-ascii?Q?G1ArITQBW+0hoELVDrED5DYjUkZwZl22b3gNGD3IxbsgxoeD9B/Pkm2RYjge?=
 =?us-ascii?Q?7eYjHLkuK4oXaWwtS2MbLRq509ZHcbWB8LaHNH+0vlg8kSi8Uqta1o8nNsQ9?=
 =?us-ascii?Q?saCPYZ/aAZGEO5+pCe9kRJ4w38bFcxRVdqb+XgJsaU/dBlxFTVMClixi1ovF?=
 =?us-ascii?Q?hR3fDP1K7ut40rdtutT4SvgJi3jOW7aLcRiUWCSgepX9g1F0qIJf1Ok4hQUo?=
 =?us-ascii?Q?r74IsvWu/QsHcvv8KH7bstqZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3dfcece-6e45-4183-a470-08d91d22f1f6
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2021 13:10:17.9070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fuagunKgG6hiH0CR2N+8jqyFSR8Rej4OuiQdrre2OJ48TPzZspI/QRssZxU1aLXTgFq99ZOQ4EGAhtlZpv3rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5658
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Adding the defines for i.MX8MM BLK-CTL power domains.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/power/imx8mm-power.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/dt-bindings/power/imx8mm-power.h b/include/dt-bindings/power/imx8mm-power.h
index fc9c2e16aadc..982ca2939cdc 100644
--- a/include/dt-bindings/power/imx8mm-power.h
+++ b/include/dt-bindings/power/imx8mm-power.h
@@ -19,4 +19,17 @@
 #define IMX8MM_POWER_DOMAIN_DISPMIX	10
 #define IMX8MM_POWER_DOMAIN_MIPI	11
 
+#define IMX8MM_BLK_CTL_PD_VPU_G2		0
+#define IMX8MM_BLK_CTL_PD_VPU_G1		1
+#define IMX8MM_BLK_CTL_PD_VPU_H1		2
+#define IMX8MM_BLK_CTL_PD_VPU_BUS		3
+#define IMX8MM_BLK_CTL_PD_VPU_MAX		4
+
+#define IMX8MM_BLK_CTL_PD_DISPMIX_CSI_BRIDGE	0
+#define IMX8MM_BLK_CTL_PD_DISPMIX_LCDIF		1
+#define IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_DSI	2
+#define IMX8MM_BLK_CTL_PD_DISPMIX_MIPI_CSI	3
+#define IMX8MM_BLK_CTL_PD_DISPMIX_BUS		4
+#define IMX8MM_BLK_CTL_PD_DISPMIX_MAX		5
+
 #endif
-- 
2.30.0

