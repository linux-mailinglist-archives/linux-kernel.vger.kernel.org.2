Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D50B3CB77E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 14:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbhGPMul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 08:50:41 -0400
Received: from mail-db8eur05on2063.outbound.protection.outlook.com ([40.107.20.63]:21198
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232554AbhGPMuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 08:50:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnAt+4MQtosWYz3Bg8rEtEUUvLT7uODlth7hM8B7nxQW47dh4aEzsoluZH13NdumWF0komFD3wTykh5ti8qiRL0Z5uIsLJVju/wxSBX5YkanzmfOe9ZGpffONbj3xGn2aql5lwfxQQIQZE6TyTkG8WiqQQgwiNB/Zzdo0xqLRXjTDfjlptlkxVqbD826bh7pmiT0mg59idgGyooJe625vTIUkpr50mI7E215OBqqWDI4rXSH49D5mOquK73F/PCRExQ7uFL9EUdWnhdJem1Q4JZwXRL+ZMAQ3t6hN840nDUEecMtBMRhONgLdKNj48xup7243qLRpEUTNZD0uuxyBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLiXHCommSRR/WmNqWRGqDz1piTbL65Nb6e63j1rC+Q=;
 b=eGWveQNmLilIRDFulwVatukLX4yvy9ll62XY1ozX2Kk2ENZC6IxBhQhUz+irfxnyQTgZ8UXV+DMbdVgR/+tPAYZfMg6+v3KVkZRUskW7Sav7bXmpcfqJAc3QSTcDlKU8Ze6UUWOMVyvI0DVBtZlVpY2dWiXSAACGtLSaq1MfM+iDIWJAi2haVLDRVN/4yNrzaO4iyOGsB99WF2DGKD8eM8wYfwpl6NYTPaz6RFT6K5OAeX9dIYwLEPJDstNlg8s6jOgyqQQzrWgErSgUcCmQJo9NBFxOUHnY0HHTaa0RxBXJyr9ne8FUE99/RTkBnHe/PrG+GU2Z+9D5wTcbc2r3dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLiXHCommSRR/WmNqWRGqDz1piTbL65Nb6e63j1rC+Q=;
 b=YiS4ILs8fHrSgLrFYp09sFHZStrLXrM1o4UuHbIIboEhLtk9AK0TUC4laC4BbtE1icJsx60NeR6OoWSsEcUmXj82L7dVmYj3V77P19mcIF3A/hara/MWlHcvgVHg1hYfKKIMIbSOoMqP70RHXlGJiKCUWv7E+uRrJlgmUIwTbQ8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by VI1PR0401MB2480.eurprd04.prod.outlook.com (2603:10a6:800:4e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Fri, 16 Jul
 2021 12:47:39 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::499b:ba92:db2e:3f28]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::499b:ba92:db2e:3f28%7]) with mapi id 15.20.4331.025; Fri, 16 Jul 2021
 12:47:39 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, qiangqing.zhang@nxp.com, ping.bai@nxp.com,
        alice.guo@nxp.com, jun.li@nxp.com, peng.fan@nxp.com,
        thunder.leizhen@huawei.com, yibin.gong@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2] arm64: dts: imx8mp: Add dsp node
Date:   Fri, 16 Jul 2021 15:47:19 +0300
Message-Id: <20210716124719.926483-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0024.eurprd05.prod.outlook.com
 (2603:10a6:803:1::37) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2a02:2f08:5503:9f00:b1ca:3c51:6eec:2262) by VI1PR0502CA0024.eurprd05.prod.outlook.com (2603:10a6:803:1::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 12:47:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5acaecab-bea7-41f8-67c9-08d94857e4f9
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2480:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2480D367A6D9B9598428228CB8119@VI1PR0401MB2480.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svp8Bxu69xKIPj9VXNFQm6DmIAAcEO3gpAfhAYor4SdSUTXcRJKz/7eBoStCKo4hrvh0Jy9hX5/vqiVrssWF/0BPrO1Db68oAWbD7EY7Or8Ewpcj1qxPPbCDXMYQPP+IRMN47Od89pXbN6jjBchUdCh5d5RdX/TLhRbjLAPYspF3bnrB7RRa0s8rFExPitPSq/Zda8VP1I5A4eF3rbJWnmcGffcmoniFlbe+e7Go/4nyv0Y0hZqCf842UhT4PD5ILzvZMeNxSodruO7eEFybKvunTYR1idmhVkQxhxS96AXZ6pr8ipQBNY4gPq+or1gdxhDejiSCpe7pvNRWywggUNzmZTP2Glqo8NaFvuAZ5MHWwzieO3L/H+40HmQeveXP++P9RYGpIAijR8AduUea36FvM1R2UZuK186WdkbSnO68slZ0kyidSp0ExzFhdQGCc1E3cAy/MQdaqQcNuYuNvgTa3phbh5CEdpRYVl8wc479Cpynl1KC8nxtREuZOTHijikioLoGTHVQsWRO/dkptQQEvYISubFFqE5xXCpCQZQAWC9FaLPP1o0ntjkEUxoaJcFJSEsA7d5DxN9+eQKJc5SQC7G4yo9FU6/rp13QfIFKj9/tUqDtd9GSjBKTJ10UZ60II7U8wgB24IpS8/XWRhVnxb5GzBqPWkxEHWEJe7E7/tpzG/pjgBeW1FXQlpDH+OPf5ib9FVeUzOYivMZ3LuJOv5LGWy5se0v5eKu6PQUkc9wd7UdH22nWiAB2LkYbt6yCstaCmSfJv1/r8yS1O8huxRKIn8dDTJpoTwtZe/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(498600001)(6512007)(6666004)(52116002)(1076003)(5660300002)(6486002)(86362001)(966005)(2906002)(44832011)(8676002)(4326008)(83380400001)(186003)(2616005)(66476007)(66946007)(8936002)(6506007)(66556008)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qMUQ5qbBBiew30HZeG3WFGKGGPIKaP6cX1+s87zcKotYB9f+qBiry5ruXEsg?=
 =?us-ascii?Q?9ZPQcyvKD/jaC+9WHHpfyshCRvMpShGjGyzHsqrXunyZrtezwDk57XzRvqTY?=
 =?us-ascii?Q?Lg+9EMw9SFLpFTxOT+7cN8ibzk8XjOQrUGGXXSJ8CuipOvo6qqZvKGMkzjYL?=
 =?us-ascii?Q?4hIiwnUeoiTivmQzpFQNV24KA14kG2QxbkLgJIhxbKiRYoc8tu01cf79xVTh?=
 =?us-ascii?Q?4VH7job4rVPzQQDjrsz8UJ+9RRCTwmAoUjJEp5iVOj1X6lpoDP9oay4xi4jS?=
 =?us-ascii?Q?dvst8VxMXlnr+IYfDjcuMulRLJbJLmXwd7VuAS6IJ0fFp7yKSTtR5OmgiaF9?=
 =?us-ascii?Q?2MqLzQWr3fEPL1+Tf8ol/4ej43KFYvQ34RlLBKdiYW0m6pAl0oWee+ANIUjK?=
 =?us-ascii?Q?1BXqeHNtO5hBNvOZxTjEFIat9dCjOxDJaPG0eIw8naqat0rBIBAK2hMUDvrB?=
 =?us-ascii?Q?Hs2/is7ZfZNbqhAZc1CZ0AcuowpZTmFzkez3FF54nsAHyxHjaeFP27BfzmC5?=
 =?us-ascii?Q?92mV/U6gJAQRrg78XJgCZJ14ceA2rf59FooJn5gAwxR5MYREqF9Xnah8f7UI?=
 =?us-ascii?Q?z0xIoWI0Bv8fg2B16lmrf4GwhcuF1p5XSP8fc8ijMNuaOqkV1YJntmHA79d6?=
 =?us-ascii?Q?iDEW2waSP0W9Lv97uUGxxTx4wjDchHu/W1eoYdnw4nN/wf3xo3KplJQKa7ZN?=
 =?us-ascii?Q?1vYRYT7BQ82WfRhTbz3ghL1qS0djeJzd2Obi3tgHu7IWitjDJjM0QA8uMl7z?=
 =?us-ascii?Q?wvMt1PuX5el/0GAn1fATe0CQhq+hKzJ+JyIreHQ0oKi96BxFxgMQM7+fBstS?=
 =?us-ascii?Q?4/RcPMp4anEZ1oiEyRjiW9oYqZuuUK4KwAhHF6wjonCU64YMNbXr5VDrjSHt?=
 =?us-ascii?Q?kb6LJj1XGuINP5nxevg4Op8H86NsaTkaUJLpdWzfuBQVyWGh5Bq5eKxBOD1+?=
 =?us-ascii?Q?FTxhEC12a0CKRgqL1Gt20MMCCASlH+3+8Ei/U3JEp5R4KMhPQP/mrNKO/bOy?=
 =?us-ascii?Q?6zbFs12uS3l6/booOW2qAIQ66pVleO1dmPuGN72KEbzmdoqbTF2byH/S8Lsi?=
 =?us-ascii?Q?LpaeWVHK/arVq6E8JAwN2av+Vhvpi+fGRGjT6WH3OBUJXHFKicyB40zakiE/?=
 =?us-ascii?Q?3h6RTG10ftly4SuzPP97Bzr/cLpMeMARuuR1+39jxs4LqnkZH89pFsQ5rq2A?=
 =?us-ascii?Q?zDMZjxn14JEeCPoAZyBUrrKqXy1LBO/ziu7dI19MLZpDOCyLNAko1C5IDTIs?=
 =?us-ascii?Q?GstLdhfTVRIkKu1ndIxwck4ZHmP/zUWHzt3jNCPCAwpFPcWbbxFKYCT913v/?=
 =?us-ascii?Q?Imvk448Xbp0TzUYY1PEIqv56DvMc+SfJyk2KwoYkVp5+uNLLAvz6hPrVnUO4?=
 =?us-ascii?Q?ebkWTO5Folcu54QvoJrA7sm1yGiQAhTE60qtyT62GRUfLgOM2g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5acaecab-bea7-41f8-67c9-08d94857e4f9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 12:47:39.4058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGZZni8GG88g5A7XJPiQiloSNTC+5cnPotXJ0caeXYQBH4zpBylyhbAW0g4mB4fahfW2N45xPcb2vEeVo2ZFvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2480
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
Changes since v1:
	* mark MU2 node as disabled, because mu2 clock support is not yet upstream.

 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9f7c7f587d38..fb0ac85c8473 100644
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
@@ -938,5 +957,15 @@ usb_dwc3_1: usb@38200000 {
 				snps,dis-u2-freeclk-exists-quirk;
 			};
 		};
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

