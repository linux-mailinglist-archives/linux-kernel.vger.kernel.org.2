Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3406374E05
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 05:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhEFDoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 23:44:54 -0400
Received: from mail-db8eur05on2082.outbound.protection.outlook.com ([40.107.20.82]:27233
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231800AbhEFDow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 23:44:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AF6pyAwLKr62jOdGu/2qMaGqlGt9AgnJkUIJIANX8YfvFN4139hTmj4lBH0lOfKMHBWB5ZV9IxJsAS8RorWCBm4ekdY6LS8Qr2jHj8EDDyA5OEckXgKg2R/eEFikGb8CQtDFADAyj69bHxFBrcf6TG+xyGcVAfxEuXQv5bSKGUo3/yjP360bGhXlu1kUVrg8LOB3uwTsz6o4nxL5hBdXjK8n3qRbJizNq4udSFAvqMILMxe2JFB2Vk83esuSQHYzdBORcoWrhp699iDcSXJnVwuXBU+QfivTVlzoQdCLBLJ0QozNeJd+EJCx1ffU8ZGdySo/1LaSuGvKp4opLwVtEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoYuZ6fKfcB+WwVVfZF8+Omv1B3nHCEknsEO01revno=;
 b=EwGKtnazxes8O3p8wUmzDK49Op8HjN3cByyHfKGsBPb+sir3vrZZ10+m/+m+FvTKIiWL6D7zhmuRbS7IDw+rZW0TX6Mc1XNs/089BW1oPag1Dfk1a8i95UvbZXMIGeAhVGjVltxVRr9+LEUxdkh5txkxUUabeqVKkvy4Ui2jCbtQUFRrQxlkdFacd7We8j2UNElJHOehgC0E7jwoXSssoIxy2bNe2QR9gLsHDDIfrgcEhqV3ImJwdiW6koUVb3wqbb8pL0mBmLjkoVHpfKEJIc08SuVkm+kGWk73ngJFTmL1+xr/7hy3z4tcgHff7C4iLVOjL6LZWN6TjR8mkiYFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoYuZ6fKfcB+WwVVfZF8+Omv1B3nHCEknsEO01revno=;
 b=HPk9Fcwcw+LvZPuKBc439FJUQseu7ROAwbma5p06quQWCaE2Q7loW5vgoDH3KcUOpj4YNMn8MfMXzbaM1/AhwM9VBDobyIEVbsd9u5n5kg/cuRZd4hwvyQp25jPwR/atrOY7xdci/UpA7/xNVU6nb7QMJy6gTKljJSeE2U9LBGo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (10.172.251.142) by
 DBBPR04MB7979.eurprd04.prod.outlook.com (20.182.191.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Thu, 6 May 2021 03:43:53 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Thu, 6 May 2021
 03:43:53 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/4] Documentation: bindings: clk: Add bindings for i.MX BLK_CTL
Date:   Thu,  6 May 2021 12:15:53 +0800
Message-Id: <20210506041555.10719-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210506041555.10719-1-peng.fan@oss.nxp.com>
References: <20210506041555.10719-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0115.apcprd06.prod.outlook.com
 (2603:1096:1:1d::17) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0115.apcprd06.prod.outlook.com (2603:1096:1:1d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 03:43:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72ad65e9-5a13-4952-25d6-08d910412af7
X-MS-TrafficTypeDiagnostic: DBBPR04MB7979:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB797964B129ED32C4FA97735DC9589@DBBPR04MB7979.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zesOgzV4AsmccxE0w497twsMwxROT57kk66KDKpOBUVFbNfcUkaoKvAKEi3nwKdhMDFKOSniaYfaO8yVuF0guRqGemsWlXTITar7OifLgU7hEy/v9QpO0Dzb8HpeTRF3Tbis7vL+o4U4TVQ2Jd3R+wf/S5Qs0VDCd+iv4kmecqzzHbnUgk0Gjx5zcepdSNvt/9ZY3CXGh5+N9TFkkrYpMpEPEH5Rv2u6PF5c9pzD+Pc98GJpOBiqGN9/oaBuOV4rZmljsVmd8H6WXLfswG1NPxzpyd0TjOjC12jWRVsV2q4v6mZ7lRgfQ/NL/RHzQrDGIYLDyLwvYmKjyHAHiUNlgR1Q/vAvwHxRkRjsu+N1M5KOfrTW9yZIpaDA69sPdNBtXEd782zeY1+7K9UXX2jpSyvKTz77M05SCqe0m7LYSjTF8xcGOHhyN84RWDFvUN59oLosMhDxL2CZBJnIyK+JGo9+K+Z7Uxwr+ITGAaKcMcAr2oaDYfto1l+XQFxi220aoVFrlLx4gxWOesw2zhWBqJUx1VHt0YgVZtICa8YyWy2xKnjD4rg982NDmOOBXOInql4C7F5+H2U97HRPMitnPOmnRCnzqN+9g4c8FtOCLBnI9177uyjgFfwAF6vbJGCrBuvCxOTK6C4EQ5Y7r2Xz6xv3BYRrtHcBx7huV4YKnz2Ff/bZ7MmKDMyh7/DRWVZoTp0SNeMZ68Zv56Dttd6/NsmCTWptGwBqIfyKP/U4wvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(376002)(39850400004)(4326008)(2906002)(316002)(8676002)(6512007)(956004)(2616005)(5660300002)(6506007)(6666004)(66946007)(8936002)(66476007)(66556008)(83380400001)(52116002)(7416002)(478600001)(26005)(186003)(16526019)(1076003)(6486002)(86362001)(38100700002)(966005)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3a2fATAVE2ZeLQv7y7KfLtrFJeSqivVpDQS4bOFw0/fVYv0OWxgHdK9kZR5/?=
 =?us-ascii?Q?jeejbc1BU4AhwH0EfbX17N4AjwFPXm0OEOmiOsqCiu+Nr4aP5/J9WMI6sBcQ?=
 =?us-ascii?Q?Fsl2L0RWq9TUmjhzEK4y0drLQ1YXcfI1yfHEjwOy7uJ9CWr73/dAgS8I3wZ6?=
 =?us-ascii?Q?ZjopMCAFyeY1wHiBr7Hz0qG2Wz4r2gZPhRDtqj5LYpH5isijEgfp7hKhc7SI?=
 =?us-ascii?Q?9KUyblsozgK9mbr6L9eygM4kZz4fT2SY/C8i/PWP3MmlXyeKKT7G7IWCK9Es?=
 =?us-ascii?Q?Rr2s9oTj7mPS5kx0bstU65MHJtEi0GoZGvtDuYjj34/fK8dRQCc1YavR7t5P?=
 =?us-ascii?Q?F79cWX2u9PkX+pSyhtZNItwZt7SsQdwYVKvyuaj2xZct3mVYZCS0UMdiTXjx?=
 =?us-ascii?Q?HFvTLv6eSAExqLzXFlVXJ5wYIBx6q8AvG1sW1EmtLHGDyyFV4HZrddeZHm52?=
 =?us-ascii?Q?+sWhGzn/YUwdv8QMr3ljfLKmXPSa/bezw19urz9fDCXLMI8bwm9Rg+5/JyjX?=
 =?us-ascii?Q?oWtGP/b7bNf0OOIq3b965m/yoOWLZZv0SBQTDNpLMdwUfLrfegbdTjZI1voD?=
 =?us-ascii?Q?1kAZmr494mYUO+SMIDzmdFOtvxS81j5ViprDy0GZYs+8L+EUwGqwx7/eee8u?=
 =?us-ascii?Q?zU0B+qXBXdlRmwxLE0bc2u1wBGbb0RrYlTsSmGUW06Xt+532tvZs8lSF2mhh?=
 =?us-ascii?Q?ieS5lnV07PnLM2PG04LZ44EC/p4cl8DepQz1XiHP5WzzkoW3h2AXxA0cD00/?=
 =?us-ascii?Q?huAcK1qFSR4kpzv5Cfkc2GCJHk+UDuWmNtpOWjP3iZJrip1MkUXWdCBDoGo9?=
 =?us-ascii?Q?zmk48a+G5Z/X1BlNTEPxWT++gT31+jxUE2zMvYn4JTW8E44BQF3nUb9E9OMQ?=
 =?us-ascii?Q?htDCE+fAhW+Em6dDLpf2QIxu8eiJpk5MeDuZ2Cb61V1x8aECG9D6UNKtl2fY?=
 =?us-ascii?Q?AzvDSte+kFuhjqa5/hVtpsYebgaq9dXcyrHY/H5uTnY4cfdVLo4ZR1cDmsxL?=
 =?us-ascii?Q?Kt7JhCLqtDWtaWOmnvtD8/ySqp9dmDGRo2xS7uredPyBKM7aCjqr4+HGetF0?=
 =?us-ascii?Q?OiPg4oL5R5PKVjAu2N6Ky8QFxm8ym8ZGo4id6MOD1dsOPsYykDvCYGuD5QKk?=
 =?us-ascii?Q?fHGDoI9JCD2NmWvs3GucrsJ898n47aEmG36x6A3Wthfw4ZbSb46CDvpQRLII?=
 =?us-ascii?Q?/8gjLtcPKolKIx/3NR6JswDTROYNvm0gdJ6y8pFcBSq13WNiMPPyxJa33ba7?=
 =?us-ascii?Q?lgZ81DHwQgiulUj856T38mUPRJ+8GNaJzB52oKrl+9TO81/1aX82cYpT0hoo?=
 =?us-ascii?Q?ckn5q6Mx+ZrJUAkaN0G733Fm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ad65e9-5a13-4952-25d6-08d910412af7
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 03:43:53.1343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ug+fw7R5yMru11XqKA5nvv+MzJTYWWxpv2VK9mk1YrUoQyZLCSbLZsLcvS/VpsyNHRfrrJLFnCarw1d8tEHrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7979
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Document the i.MX BLK_CTL with its devicetree properties.

Each BLK CTL have different power domain inputs and they have different
names, so we are not able to list all the power domain names for each
BLK CTL here.

For example:
i.MX8MM dispmix BLK CTL, it has
	power-domains = <&pgc_dispmix>, <&pgc_mipi>;
	power-domain-names = "dispmix", "mipi";

vpumix BLK CTL, it has
	power-domains = <&vpumix_pd>, <&vpu_g1_pd>, <&vpu_g2_pd>,
			<&vpu_h1_pd>;
	power-domain-names = "vpumix", "g1", "g2", "h1";

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/soc/imx/fsl,imx-blk-ctl.yaml     | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
new file mode 100644
index 000000000000..a66f11acc6b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx-blk-ctl.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/imx/fsl,imx-blk-ctl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX BLK_CTL
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+description:
+  i.MX BLK_CTL is a conglomerate of different GPRs that are
+  dedicated to a specific subsystem. It usually contains
+  clocks and resets amongst other things. Here we take the clocks
+  and resets as virtual PDs, the reason we could not take it as
+  clock provider is there is A/B lock issue between power domain
+  and clock.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx8mm-dispmix-blk-ctl
+          - fsl,imx8mm-vpumix-blk-ctl
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  "#power-domain-cells":
+    const: 1
+
+  power-domains:
+    minItems: 1
+    maxItems: 32
+
+  power-domain-names:
+    minItems: 1
+    maxItems: 32
+
+  clocks:
+    minItems: 1
+    maxItems: 32
+
+required:
+  - compatible
+  - reg
+  - power-domains
+  - power-domain-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8mm-clock.h>
+
+    dispmix_blk_ctl: blk-ctl@32e28000 {
+      compatible = "fsl,imx8mm-dispmix-blk-ctl", "syscon";
+      reg = <0x32e28000 0x100>;
+      #power-domain-cells = <1>;
+      power-domains = <&pgc_dispmix>, <&pgc_mipi>;
+      power-domain-names = "dispmix", "mipi";
+      clocks = <&clk IMX8MM_CLK_DISP_ROOT>, <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
+               <&clk IMX8MM_CLK_DISP_APB_ROOT>;
+    };
-- 
2.30.0

