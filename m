Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9EF3B6E71
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 08:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhF2G7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 02:59:15 -0400
Received: from mail-eopbgr130051.outbound.protection.outlook.com ([40.107.13.51]:12769
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232195AbhF2G7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 02:59:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJ+aEqlBYNcecLmJMF5X7rla3JaM3l4bZ6CzkeT2ZVxuxiGzRMReVHWhfZeJKXafjnJi7BKtEUw2pHV/x5T83nZ4ztOA0iunBUHou76lDMRv3dy7AwRDubapYYFFi+EFyEL9FQtrJXqh50R+PDzKzdBcA5qypkRFRfwrrgWSDkuNEVxLjizUuCA0QKj5IiZuG+UE6+widM8LSzUAWY6qxgBEAEXzrpaz5i9fhzilQU0Qn/T/9KH5k+t4M6wJWQBHPHKXzPVnxWv/KNJrOXABkgXR/F4VG0R/fagrM4gyVlNnRf6nFIFREWRDBq5NDoXn1kh4+femGtnhH82JyBsz+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aB9k0PrMCYDScMBixgBT3+fJPleWCeHpDcOqnFBs8Q=;
 b=S97McVLbza/2tMfOhqMmBs4Yb+EG1rlN+tBMa+DX+BtQTu8r7bHR1W5uY4kLhpRup6Wl+J9fgNgWzgF4/zsSNYXbTt/nrQsPXOSiRmSDa4Q7Z/QPqgmumisji/KGWAJfJ0Wh4kxs8n9v2ikAzMiSSAnduddvpsSJzN5/Do4qId78e0kmIIVlyDoHrDzA9nmptUzywA0wjy8Fa0HxQrDHkrQWDVOC4+Zhh4ESRJzpfqbZ1/fSFML9ich45GMJv3Y1cTWMiYhP5zMhukDxrvYUJLaAM28IKcw+ZgR0nkx5Rk1TxPTi3Zn4MkFc5JeXP/BhBA4zqTYzSW1JO7dZvkrYtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aB9k0PrMCYDScMBixgBT3+fJPleWCeHpDcOqnFBs8Q=;
 b=N/30//IcBwm8lB6KKHNq5uEaM8yyPrE8y0467QcYgrDfYoDgeo3ODU2bwyhqrXeubKSEm/0SnHdQhKzYB6QLRHrNzx5HaM356AmJRJDRjWcGZVZvlkEYO5NsPe0i+R2OtFmtD27ab57wWA80q0qf9UhjqD+pWM94p+K3TdpIECo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4762.eurprd04.prod.outlook.com (2603:10a6:10:16::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Tue, 29 Jun
 2021 06:56:41 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c445:d742:eb76:86dd%9]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 06:56:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        jagan@amarulasolutions.com, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V8 2/4] dt-bindings: soc: imx: Add bindings for i.MX BLK_CTL
Date:   Tue, 29 Jun 2021 15:29:39 +0800
Message-Id: <20210629072941.7980-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210629072941.7980-1-peng.fan@oss.nxp.com>
References: <20210629072941.7980-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:4:91::20) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR03CA0116.apcprd03.prod.outlook.com (2603:1096:4:91::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.12 via Frontend Transport; Tue, 29 Jun 2021 06:56:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5533f584-e9be-4bea-79ad-08d93acb0c9b
X-MS-TrafficTypeDiagnostic: DB7PR04MB4762:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB47622600DDDC01B3B9EF8B17C9029@DB7PR04MB4762.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KYX4VElckPR6DkUdqu6nZh/pz4EDHZ46pNPoczKiRSV4wwAoch3ozRr4bARO2PCfrJSjo3hMiA5aT591ZUZRS5wrUnYd+rFiBof7uEQIVnIY7Iz/sh0JvfpPbtqjl+DwbaJLQd9XnKInTrf6hSwl7HCg6GJAiKs+cmtfwQxg9hyqCMCIdzfLM0l2aQrnuElOkn/+2aTvoTp0MZIhebE7Tk8dbPKH/Hcsodb4SZiOju+snzj+4alodQwmScyJj5OGdQROTp8i7J9njrzkp0639wzhdx1PQqsxemApz0FFpQSXDAJ7IjOCDFLqeP00AracwjxdQJq3WCzRyPTTBX3ne0Va/U8/03cMTrUjHSpmbWijnHa6ylCs0tnRXHoUh9uXokxa1TUmm4z9tMauuAVjsQUtBeSv+co3ThNaOQWRE79FtNNLyaZ0kyR0pKZKsqqsgLENXLog8ULQ+Oc8fdMd6yq41K4Phf5XaTfP5yuuRK0TtFsZgnz9xjTGRxIwUhtLGWUeiiNXmqlbRv+El1WWnRtODocSasRl8iyQHgnMkMzypghQbfxzdjMbPi2wmXD5qOca2YeNbM0Wv2wdFfyYHdOD2TsxiJNQzaeviPR5o8BxNi7LAPl+Z7qnMTrqFGeb0Hnt+Q8UBvpvHBmvoQBaNueKWQVbxDu6LqLPeUIsbkbX6iBigyjp6EEAH+WWcWsiYTwOw8HWewzDptqUsrTp/GWIWKo1wWU4liNlbb7rUEgT4K7tCFMVwt7A17vxnIai1YrS5Y4qpn/u+E3arCvgTyBbJegMYM4ZppZ+l8fDxaqQJGLm6FJrAPic1z6qpuXeHJGI5RedbBJ0kuIvBTYcWhaGGKCtXWBxu59EXf96BoMhCFsl4DPXsBpxpg2Uepu8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(956004)(38100700002)(1076003)(478600001)(316002)(2616005)(966005)(5660300002)(66946007)(38350700002)(54906003)(6506007)(66556008)(6486002)(66476007)(83380400001)(8936002)(52116002)(8676002)(7416002)(86362001)(16526019)(26005)(186003)(2906002)(6512007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TdSkDCx37hyBs/iMUAUNA9UI9SpX+yp6Uy4zsI4UgvQZvOmo1gyFjm356M7B?=
 =?us-ascii?Q?7+7290yAbgslRt2hgyAzBXHIMcTlOm+N0Yo+Dxurzn3m7tVtke7Mt8hJpHU8?=
 =?us-ascii?Q?cMGU5QPPh3rLmL3CoMnOZZFe3NSop+O4chAcijaBpcA5Uk3FjcqA3KmlXRFH?=
 =?us-ascii?Q?8gh7Lnn6dGcHOZDmbmWrldUjhAHMRSCkrNV1Zv7HfYIjP0WAESYqCr+yuRq8?=
 =?us-ascii?Q?fz6K42FFnk6yVG+6seNbICyRolgP/M8iChXXw8/1FA9/bFudZFehCfaXtSAV?=
 =?us-ascii?Q?xYzYYdGOp6vcTn/8pN/NTu+2y6uZSDPi7WuravDeThF7q5lZxOlsDCznsffc?=
 =?us-ascii?Q?VfLo2Rxm7uwKF8N8V5DkXF/Zm9O0i4+y77sbFsOkL0jFeZ50UoSN7kBJ251J?=
 =?us-ascii?Q?xJScFAl56yik/M4MowJWT9wY1uvBL+dc6VS3VywHsV72yA0On7PnGbuvXZff?=
 =?us-ascii?Q?jIbC6poVoJMpgTFHjhQy80TMs6+7aUtWVNuW+xjX58EbxvH2inoK2/ztD/Gt?=
 =?us-ascii?Q?mOv0ApG8ITfGyQU++Q+YtOKrf5PKH9k04IwTOxJjupHf9nEber4UVilnPS8U?=
 =?us-ascii?Q?7PrB+gI8ffoTuLBwxnQocGifq4uIOt8D+w14T5Q5+89/ZQcKeLxJ4Gn69Ns3?=
 =?us-ascii?Q?RcHv78VaSxK5HDQtXcsW+t1ALy8JJGUQPLUAnsXgupiUirfmbznFG8VsKiB5?=
 =?us-ascii?Q?Um3S0W4VmQKbzrzlTUvCMVtHSly3/RiNgGtoTaLEjAiq1t7oM0N+gtVaVD2d?=
 =?us-ascii?Q?0GHLmV6MTnzlsb/2Kt1q7DlGKoBVoost8Zv7iqr6NiFAAa0rtcec+73hlMqL?=
 =?us-ascii?Q?BHkXe0/zWFNnFaKh88QKd7kqF/mLpodEbUgCwwjYwXQgMfDM7LVDr0D61aYl?=
 =?us-ascii?Q?sF+wY/V5VvbfA8O1PzGhTsZAN90EbGiqsf9SBNvMQVv0n8M4uRWkt0DrL9/x?=
 =?us-ascii?Q?Tmzr3h+3JgzyNh9oo3W22iz/Jw54Sn3YMY2YAceI5Ma4SUbbCZ9Iq7t0mDwx?=
 =?us-ascii?Q?z8iFigffjVJ8rZH69cKM1zrXzJkNpuMW14A48nnxHFr/y7r1Qs0IM9mq+1ZB?=
 =?us-ascii?Q?KFub4Lj7jLO8RfexYlCSec6U+oTeqhAgHVqoaU3cQ9AGeJKF0UjLFQ0DINFf?=
 =?us-ascii?Q?+VfiIz2xkEIyiibiLUVjizk0HQgU5hbzVwcB4fbLK56is4vS2uJQllKpTYGQ?=
 =?us-ascii?Q?KOw+6G1E+6a8Q9lSGIwPIh5Zg2YJo4j+nvGHOeakPeOIaU/kwaYEw/4xY3CL?=
 =?us-ascii?Q?AgCfFnpFfWmm9sKDXAN3N9bXG1imVR60gcQRts54zrk2r55jHyaHyyxJaJ3Z?=
 =?us-ascii?Q?lag6dwBgvTstoZoFug2euC0x?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5533f584-e9be-4bea-79ad-08d93acb0c9b
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 06:56:41.6192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3BJyqOtVKeYEXFg36WwEzLnMJRc9Te0JNAsVwFtFmylZCWEnJikVS69xpvSIPB8+xTimJUjl7kRXYUs2bQO1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4762
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

Reviewed-by: Rob Herring <robh@kernel.org>
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

