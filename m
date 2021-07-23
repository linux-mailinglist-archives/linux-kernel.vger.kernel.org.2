Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450C03D390A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 13:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhGWKZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 06:25:24 -0400
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]:11894
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231296AbhGWKZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 06:25:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUSCmlEt7q59FgacyZ2/QHRLhAs+IYFnVVIVPINLyzT0b0OhMuDHyQJ1l+Gb9L+rmVRU7ccgBqagCWozv+WJLOKNPMriSAXbnZ3OPhDel7JiNRT6UWeImAbNu/UWSMRiZyjHNdWMV8Fpcpr/TdArm5aLgnczfB/p9H5y/DLlrMGUALFuW12R5nD4F6+KpMcsrXiH7B5bnrRJZxrxkKzXvYIZBFZ9h7ADAUwwogHmQKHdxaZJ0aUb0wtbs9sGNZsmdDdoH3L3jcIldJU0EkXhM/Kk5TrowMqW8zMkgw7uJ0Pj+KfAtF/6QWFecvYD8FRzzSqz8Z7wzgYrBD71d1yRFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ME702u/TrdZZPWjkJ1PSyZK78m51llgY7kVlj37bZI=;
 b=UIYTclqz1TqHkCV7wlgucJWkcNRHVO0i6zPKPcOwymi8jH64ce/kDtCa+1qhl8lZ8ex5FdsMg2w0wRUFA+9YtaZ3cAWXL0YwaTRP+BDJceZFKxGBWvAT389wz15fBNEy2wK1ESTZDgApOi9ECaaa8nLhvyFBJlkWOjhe/VkLSz88hS8Kxk39YRejVXtu6fNhHKlIgbM6vHqDvcvbT5IbnG7NgYBgO+2IPZ7CoeIJfOqkWOlc70fi6MORwtDFUS7mBGVbvUf+kKLe+8p2thGKkhoI+YjxNgzp0OTRFJozM66zV6Q3AYKu0Bdtyg8WpaAPXkvnEwGMjw1+8/mBXxGp7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ME702u/TrdZZPWjkJ1PSyZK78m51llgY7kVlj37bZI=;
 b=VuR4EiOAglCbDZlVqS0XbZF4vDe4rKD7Oa2JAlZhyWGnLb0Zo/K4Dp04sNwziN2N+aBerTRBj+3BvCjnjnNgZUdu/JORDlPj9thV0yeRWx8pApniyTKqxg1U95yymlHalGPlE/V+8QkeIj1YjiLv94RNrAhI604HAbjT/Mr+3ZY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by VI1PR04MB7168.eurprd04.prod.outlook.com (2603:10a6:800:129::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Fri, 23 Jul
 2021 11:05:54 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::499b:ba92:db2e:3f28]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::499b:ba92:db2e:3f28%7]) with mapi id 15.20.4352.029; Fri, 23 Jul 2021
 11:05:54 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        ping.bai@nxp.com, qiangqing.zhang@nxp.com, alice.guo@nxp.com,
        yibin.gong@nxp.com, linux-imx@nxp.com, peng.fan@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        daniel.baluta@gmail.com, linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v3] arm64: dts: imx8mp: Add dsp node
Date:   Fri, 23 Jul 2021 14:05:40 +0300
Message-Id: <20210723110540.1332145-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0123.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::21) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2a02:2f08:5709:ef00:eadc:ab0:e88f:efdd) by VI1PR04CA0123.eurprd04.prod.outlook.com (2603:10a6:803:f0::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Fri, 23 Jul 2021 11:05:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 001cb351-0fae-488e-7ef3-08d94dc9d6fb
X-MS-TrafficTypeDiagnostic: VI1PR04MB7168:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB716880A423726671DB2CFE53B8E59@VI1PR04MB7168.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5kZjkrGTHH+fs9KRLmbObUlbeSM2Q+z1bmgXYz67/dWPYXkhdWNGIV0ehct+wf4bttDoqGMVQ5wOmZnK/U6hberT5zl8oTTw4CBZmCIkqWdYJygbpvhvNdo9ls6DboomclffA3MkfF7kzDJDDaZGy54T/ojVGDNdzH6jAwpQQQd9Z6Z/GipqVuYIB8HG4siPgbK28L3jvbQSTtdFXlfY27UF9KDTAo1RCIAsnX6vtSPyVRmW9oVFhzwRln3GlDTZaiA/8d0ashk3swbVEFx2lwRGVxDTjmaovm+wahA8dtWBBzSWOMr+7md2+tlz4Vhfrj6MWT9zCX2HEkhZsk/EUX4flTZIwnzFx1+lf3aqAdJ2N24gMo0sOCpnGDLq/1eHrT39Ak4vH6X+ZfyFjJ/amQMsQaxYDqlvcAYM7bQEQ3ZtIjZBijJDEhACvh4CDw8G3AmtZyS/1IsyqKMUOuBg60PFz5YW9l5fzpvZN0uxXZqJKNEAL4eamWEUswGYXAVfupVZYW8d4uxEkJ7XPnQHHqADWG6GFNhiUn9QwRIkLx0sYEQgT1BpKp4RDvGTI3QR9VipVrGCdOQ+Y+SKZ96nMvho27Oq91nvh/cV/WTPeUj4wY+wxfzbERpqp0yMJUnsd52amwLjJxz/bL50ziFdvVEyakSjDvD1fAWffuEwHleEkB27fGrMZOUyv6hR1LobFPhspDQ1ReWthZfwgX7NSFJKYhkU2Yovkj7PvZ0bGmEB4UPgYQ3x44RgN4F5Ozgp97GhBMn9ARKBzWkvZKTdYE72g38cgJmA1zVjLL7ixOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(83380400001)(8676002)(8936002)(186003)(66946007)(66476007)(4326008)(66556008)(6512007)(6666004)(52116002)(1076003)(44832011)(316002)(6916009)(38100700002)(508600001)(966005)(86362001)(5660300002)(2906002)(6486002)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzM0SWVLTGRlYmlkbnh3VmV5NWpCZTVnWjEvLzZNYVZvckw1WXNVWnZVRy9P?=
 =?utf-8?B?WUpvZDkzUW8xc3NiNlRUWTl1N2ZvekppYWlpZmxEZVFkMzl6c3JNS05oU0c5?=
 =?utf-8?B?dE1xRXRFZEhPTk1Md3FzU1FGemxUK09wcVF4SThFaHpONWcybmR3ajFpYlp4?=
 =?utf-8?B?MiszTExpL2RibFAwVFNDMUo5WTRmMURpcmYwTElwbkpJODRFTlZ4anlySGlB?=
 =?utf-8?B?Vmxjc0VubnN4Nzl2YVhoMlkvc2tuTlhoZHZ2MjlCamFxNTJZbnhUV3huci9Q?=
 =?utf-8?B?RE9LRk5BWjZOWlJLY3h3UW5wTVVVYSsxTTlvZDByUi9GeVhCbm53WFRXWUNL?=
 =?utf-8?B?cEF2aHFzL1ByOWRWb1NTMVp1aDR4STNaRzRXWkI5RmRWYVc2dnRBNFBRZ2pD?=
 =?utf-8?B?aHp4RHdhWEFhTFFtWUhud2E1U290N0FiRmNjSFJrNUMvMDZoR3d0cGNFRXdI?=
 =?utf-8?B?WHZGVGZCOWxzdWdoVEFQcUdOUlRWeE9Jdzl2Ny8rZlNnZ3Bzc25XbDl1bVp4?=
 =?utf-8?B?YS9CTTVQQXhVUmpFdmovalI4YmtValJnNStzV2U5dUZoaVY1aEZvTkdCYU9l?=
 =?utf-8?B?aEppZFNXZkYxMHBCT0dZcFcxMCtoNWJQUy96UGgrY1M0RHEwTXZVVThZb0ls?=
 =?utf-8?B?UVFoVllFOEl1dmlndTBIUXZtMW9laWJXdkFZaGMraE52S0c0aHBJWnNWbEdL?=
 =?utf-8?B?aUd4ZTNDUERLNzN2TUlzNkJMVXhZcmtiekZrcnRMRzN4OXMyRHltcExYVjZZ?=
 =?utf-8?B?cC9zeXNzK0pOSTJETmRWOVMrcjVWdnpBTW42RTl5dGRVa29pTVlvZkphS3Rj?=
 =?utf-8?B?ZVBScnJsank0MmNucnlvKy9FSzFXUGF4citJZ1dQK3pxeUhpc211ejNNRmUy?=
 =?utf-8?B?NkdlM1dUUkFrR05KT0xIMXRFc0laSkNZd0tERlFaZjNsYXgzSTc1andKQUxm?=
 =?utf-8?B?dW1MRnN6SXhnS3JzVGtpTk96MENXdXJTVjJhSDNUZFJsUVdoV09ZN1RhK2Iw?=
 =?utf-8?B?SUxSNFQ4VSt0eTl0QlNuQUlORUUyY3M5ajBiVkxZbmlFREpsYi9xV3Jab3pk?=
 =?utf-8?B?NjdPOHdlTmJINkJXZFVTMm56bE4xckZ4M3pWSTNRbENIaDdqNTJsWmhsSzha?=
 =?utf-8?B?NFE0a2ZPZjVYd2ZxNjRWOTNwTFNybzJsLzNacjhDaU1pZFBoUEJVWlYxTWJI?=
 =?utf-8?B?N0xjRnU5ZnNIRHpUdTlpRGFaZXFDdzloeUp0aVdjVmh5bG1WUXlnL0U5UXcr?=
 =?utf-8?B?bU9YSFhjZEx3N25Ua2VtbXVkeTdMbVU3S1lIM3lQa2YxSmJWQWI1dkYvN3VK?=
 =?utf-8?B?S3IySGtTOTEyY2VRN1hNcDVPUEZQUlFsRTY0ayt4WGRzWWdSc2JsdGxTK2xu?=
 =?utf-8?B?bEZPb3B4aEtjTldtSUdDQXlNdE04V01qWDl3SHJDaDU2R2hOTTdmT3hIQnNY?=
 =?utf-8?B?VjNyVVJ1eFlzK2cwQ3NNVDl4TlQxUjd1RVNoaENUL0loL0V1RE5FNXRzUnY0?=
 =?utf-8?B?cTFKeVhLTTJXc2ROemJvRHlGbDhZQVNzVUI2ZVMyZmxSQlZuSjVMQ0MySWlG?=
 =?utf-8?B?WDJRcUkxY3VxQk9rVmNqZHRZYnpwcGJRN2FuV210SVlxMHM0cnh1emNFYlZ6?=
 =?utf-8?B?TXQ4dTNpbWsvYUR4Tjl2TGNiOUo1bkFrWldBclFJNjJSY3VUZ2hpZnZMc2Vj?=
 =?utf-8?B?amt3d0VSL1FtTGpHT1RLaU5YOExBSnpEN1ZJalZwcjlBd0RPWW5FRHE1Nzdj?=
 =?utf-8?B?OU15K0ZvdmhvOTZzbkhkdzNGdVhhZE9YZ2dnSk9CRzNwcTdVMVVXcm1FZ2du?=
 =?utf-8?B?eW54WXluUUJGQjdOMnRNK1BUY2NVRUIzL2IraHE0RjArV3F0ZjJqcDZxTDg3?=
 =?utf-8?Q?uRSKqoAkna4XE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001cb351-0fae-488e-7ef3-08d94dc9d6fb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 11:05:54.2705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sr7pZIGdxSUyhK94gb23vW4SgKtC+89xIuUFl/vAU5KxdpIH2XWnypSqeu1+T5218srDdXhc5EWEA8COmLLY9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7168
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

i.MX8 MPlus SoC integrates Cadence HIFI4 DSP. This core runs either a
custom firmware or the open source SOF firmware [1]

DSP device is handled by SOF OF driver found in
sound/soc/sof/sof-of-dev.c

Notice that the DSP node makes use of:
	- dsp_reserved, a reserved memory region for various Audio
	  resources (e.g firmware loading, audio buffers, etc).
	- Messaging Unit (mu2) for passing notifications betweem ARM
	  core and DSP.

[1] https://thesofproject.github.io/latest/platforms/index.html
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
Changes since v2:
	* add new line between dts nodes

Changes since v1:
»       * mark MU2 node as disabled, because mu2 clock support is not yet upstream.

 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9f7c7f587d38..2a1a4ff36c67 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -135,6 +135,17 @@ clk_ext4: clock-ext4 {
 		clock-output-names = "clk_ext4";
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		dsp_reserved: dsp@92400000 {
+			reg = <0 0x92400000 0 0x2000000>;
+			no-map;
+		};
+	};
+
 	pmu {
 		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_PPI 7
@@ -698,6 +709,14 @@ mu: mailbox@30aa0000 {
 				#mbox-cells = <2>;
 			};
 
+			mu2: mailbox@30e60000 {
+				compatible = "fsl,imx8mp-mu", "fsl,imx6sx-mu";
+				reg = <0x30e60000 0x10000>;
+				interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+				#mbox-cells = <2>;
+				status = "disabled";
+			};
+
 			i2c5: i2c@30ad0000 {
 				compatible = "fsl,imx8mp-i2c", "fsl,imx21-i2c";
 				#address-cells = <1>;
@@ -938,5 +957,16 @@ usb_dwc3_1: usb@38200000 {
 				snps,dis-u2-freeclk-exists-quirk;
 			};
 		};
+
+		dsp: dsp@3b6e8000 {
+			compatible = "fsl,imx8mp-dsp";
+			reg = <0x3b6e8000 0x88000>;
+			mbox-names = "txdb0", "txdb1",
+				"rxdb0", "rxdb1";
+			mboxes = <&mu2 2 0>, <&mu2 2 1>,
+				<&mu2 3 0>, <&mu2 3 1>;
+			memory-region = <&dsp_reserved>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.27.0

