Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7208A3C9E15
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 13:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhGOMCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 08:02:08 -0400
Received: from mail-am6eur05on2043.outbound.protection.outlook.com ([40.107.22.43]:19392
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229556AbhGOMCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 08:02:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIyh47NXBbNPEfCeFCs1O8AL1130/i4etLVAc23MMFSv/98uMKIsG6UDBFPenpf2ZBglnyE39FDNX2PDJAvbvX+69hLGwtRtj+ouPTvLJlBjX6Qb1uiREksDsx2jHHaBElmVDwipKTXDjAQS852Kp0aoDYCTbS72Jn4CQzt5kZO728fHhaNafdZ6MbjQrpkI9KKUVOC3rmhSkgHWQIMD2+e4ze4+392GU7aLblHH/RqaMvcyiZYCGLBFR16NW3/In6GZKoqYUibM/Oyq8UDWmdvkSiGh89yhG/NpHuPkimcxFUAsSvDQgW35ObwsC07MZSqmSze94yxYiWdkR/EVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mN34ikLsSAhTnGl156qEd+E6t6u5vQXpqoYYHoLUNZs=;
 b=MTb/mcPr4G70YeTppn1DWpoq1MHL2zmIDNor3j88Eby/HrBgQZMtm9EzatGED90gCl2vv0Pl+n9iXqt7RD+UbgKbEnusiVZCsZp4wTRy4AkFALAXfGWefL20r1ncjwtFvValBnl8sEFtbRH/mWjmRbbE6xpuCnHawstjQF6Sfdly5YO5MkzYe65CdHjQ5dKEnV79naSRduooP8UUZn0RQ7uDCilr67KNRHLXUkTU9PbrRRYI98ZtQ4c4S+VHxYY8AJkzoxjGHrOm0KzjyQjy0OcowG7tbwjoDYSGEULngV0JJ378ksN4yBbPTKW93zPcpMNhP+ylX2szrk/692T6BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mN34ikLsSAhTnGl156qEd+E6t6u5vQXpqoYYHoLUNZs=;
 b=dp1p9FLiC0V2p0gMvBJynVTEHFRJlCfThHb63JKxlOvnYlwLEPAjUFXmz6t174QVrlAPo+Am1CeEfXgrjj/bfnPdbTQrRQefvYtqBt4Jc+0p4zUYRUgKcrt8kBg5OiEASgBtabq2dLPwFUt2gtbrduSORSG+sW1xEgfYmNmxnKk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5140.eurprd04.prod.outlook.com (2603:10a6:208:ca::21)
 by AM0PR04MB4114.eurprd04.prod.outlook.com (2603:10a6:208:5f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.24; Thu, 15 Jul
 2021 11:59:09 +0000
Received: from AM0PR04MB5140.eurprd04.prod.outlook.com
 ([fe80::1105:2d9f:b790:4ec3]) by AM0PR04MB5140.eurprd04.prod.outlook.com
 ([fe80::1105:2d9f:b790:4ec3%6]) with mapi id 15.20.4331.023; Thu, 15 Jul 2021
 11:59:09 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     shawnguo@kernel.org
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        ping.bai@nxp.com, qiangqing.zhang@nxp.com, alice.guo@nxp.com,
        yibin.gong@nxp.com, linux-imx@nxp.com, peng.fan@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        daniel.baluta@gmail.com, linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] arm64: dts: imx8mp: Add dsp node
Date:   Thu, 15 Jul 2021 14:58:53 +0300
Message-Id: <20210715115853.749025-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0801CA0069.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::13) To AM0PR04MB5140.eurprd04.prod.outlook.com
 (2603:10a6:208:ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2a02:2f08:5503:9f00:58f1:af0b:2fd9:e70) by VI1PR0801CA0069.eurprd08.prod.outlook.com (2603:10a6:800:7d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 11:59:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e047415-4ed3-4b11-e569-08d94787f3e4
X-MS-TrafficTypeDiagnostic: AM0PR04MB4114:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB41142DD824191791C6A185D7B8129@AM0PR04MB4114.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l0G98TfHS/OSWDVZ32Qlnltql7KgRM6YSJwqZ64DuLrq6BLuU3ArCPcMaY4hhMI/bTrdhfc7DRY0UxqTmYVB10RiA+0QgjtzKwFZQhpVrBxd4PfrFnYMCR2nTpKs+PI/ljHrgBDM7ER2Xn8mN5vrJSOS4Fu0fXwiCbLt8BC/UUxKD67rT1ei1aElvMa47rqksThX+e6cuwbpz7gg/QToSMm9YGdsBHLYKM+NPTJrhf+VrQ+/2xor8g04D2K2cc4bau8tNjgXyeT+XmGVqD5vSTl7Lyrzfngizr+3luiw/jFPFd5ugBybPvaTRTHm8Qvd0lGKTsUf/NQeRFFbC5pUHSwdPBaeImAygcR8ouSrzqt+Pf+H/YvESfoJhVaEB9y+dn5K/jTNDixU4O5BJrIVYFtgxGp9g2H0a4OAT+Lyr+1Z3OQSwcACqhusQaLt47WATlcslmVYszdcV/2YrkNyENLg7gdgPfhQYntkD7X40XaCoq4FRsqZhpIxr0TBpogr2y1fBAjbfjvSULHrlpmuzXLKZhXUxOYvsAmrZYXb9u9soB6Nw27V/xptejvrPj6HcxpPs184oyKt7dWbZtG816UA2hTOk8EPCN/qJTwf9POEkYWdrskXQYzq3V8zOUAcgl02u0q+O6SARmEtgp+LDlIoIsPBOs3eH+omSvlrUEWDJtc8Io3NkClfSBWigcgbjqiNOYx+bJxrm490iKwONwG518Nr56nhDXW2Fi/OWfZUSSWby9eWvCMb1DhrQYg6Ao2N6lzMDIjusfKurk3jfCao99sMyV9WQ0xosStASp4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5140.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(39850400004)(396003)(346002)(6512007)(6506007)(83380400001)(52116002)(186003)(8676002)(478600001)(66946007)(966005)(6916009)(8936002)(2616005)(6486002)(1076003)(66556008)(5660300002)(2906002)(86362001)(38100700002)(66476007)(316002)(44832011)(4326008)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ogLzRxiKfJ3qW4BLG/b5czT6eUl8oBjigBlUBYwxgvghowkRtS3CR0fyGXgY?=
 =?us-ascii?Q?roU2S8Ot1Ncq8Km5JZllS1g2tb3J6L1j1U4IwkrYzdHq7YBpmCkbZR/OfhoP?=
 =?us-ascii?Q?PHLsqY8AxuUDatslG2/jTsk8B6Jvlvpjs1GXCQS3GUMja/7Gp6kemQ0t/7IT?=
 =?us-ascii?Q?uHlhksqB4wIckDqmsbNZlpS5oJGfS02kVaRP80v0Cg0qfirwLYOsN9GVEDOP?=
 =?us-ascii?Q?zWzDRxfLb9YW3BFOLhuyupXhEEXOR/vSWRwFNcvMFQ+RuM2uEbcWkgsrfUTY?=
 =?us-ascii?Q?X5C2Ly2SoVAYmCn5DdH6CviKX94iAubvDZv2qBWVad2o8TWHTA7DOCI3xvxb?=
 =?us-ascii?Q?Fgv17BRUO1/MiAiMyd28SH3wJa6UgHVGnAd+inKNBrf8nmU6VP5ffUSjV+Ta?=
 =?us-ascii?Q?euUuHT3cUrwBwxt13al5y1PduojyyanGkDWBXDoQnwv4K5rS1kwwVlFEN8l2?=
 =?us-ascii?Q?1mFnJhHrMUP9UNKXiWMLC6krbcsYUMBS0Wo30JZwFivRNlL2KObpCjbtkNnx?=
 =?us-ascii?Q?wdtoF5lllIxoNx5y9f7+Y4ihAaj5hjp0+xHDGhtdf9x8V4hVgXM8gwccQuNt?=
 =?us-ascii?Q?sApwfMUShoEqvxztVN24ozeLDnM5QMoN2X0BqzLDlHYgVRYGf4xcp7wbS20z?=
 =?us-ascii?Q?XcleSz3J3VUXXKWOzs9RtHbpvimj1XyFyCPqPKnYXuEs9Q1FjHcdPlgQvpfT?=
 =?us-ascii?Q?auh9kPcCtAususcHqbQ14kMUpo5K/UpnHtuMI88Shdky/ku1rbB/cQZD9l03?=
 =?us-ascii?Q?hjYUD8njemr4NmF7cNgprCxtcgVivSX/zh3vpq3vRYyAwkDvcFXQ1r8l08Nv?=
 =?us-ascii?Q?/dEGqE/FPczSs5ozZfFrOo5fEx3GuK+r1h8eSCOXvUtckVwWbACLpXi5uDDY?=
 =?us-ascii?Q?U6wH/jALFbBUWGq7mtkPl18KkmWTI6CP5WwrpD6L1vaDqOL4bJNgfSyHuQI/?=
 =?us-ascii?Q?Gy6/QVo9T3QF6nq1UgBeARIDkehYDvaieIHTQLP1pi7o6tTzC2SkHxztrRv8?=
 =?us-ascii?Q?sFUhKsN6fNd3/tIC/YUSHiIQh7MQQeaFYBxQLoybj0qlUrVVfOxcoKUChIaG?=
 =?us-ascii?Q?2ZVjZQ3IPMuX3CnUJLLH/gTVb03vqLh2b9qRdhDpa8J8GUHbqSXGwe3jhESi?=
 =?us-ascii?Q?Tw8ApPFjQcQj5/ET4r2p8B0Z8oABLmZNIgqWZhHNWDopi27/Utod7OmsrSPH?=
 =?us-ascii?Q?ZsSR02kIwLm0tQRvsLjER+3CUytIxnYHzkszk9Z6nwYKHt/kyPP0qfrVbiYO?=
 =?us-ascii?Q?11gBjwdcvbcRnLKBD67mfdbWY6F8CgRePPMLMkU+hSOogv3i6BxpRhc9/OK5?=
 =?us-ascii?Q?v+HKaTmcnkHq4Rmex3Ddtuug/92LOgYuuuynP8gtxOVkNypJLojBTkvTPjwm?=
 =?us-ascii?Q?k8pSpJQXaTRHOEp1uQomAawgV9Fy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e047415-4ed3-4b11-e569-08d94787f3e4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5140.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 11:59:08.9656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQ6LhB0jcrDRTnjftKhkFbRm693TDB6KfyM/6itvHEXcgbCwXl6WPp27daWU9HbDlamSDCGKwLttmDI9UsfVLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4114
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
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9f7c7f587d38..264ba540f363 100644
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
@@ -698,6 +709,13 @@ mu: mailbox@30aa0000 {
 				#mbox-cells = <2>;
 			};
 
+			mu2: mailbox@30e60000 {
+				compatible = "fsl,imx8mp-mu", "fsl,imx6sx-mu";
+				reg = <0x30e60000 0x10000>;
+				interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+				#mbox-cells = <2>;
+			};
+
 			i2c5: i2c@30ad0000 {
 				compatible = "fsl,imx8mp-i2c", "fsl,imx21-i2c";
 				#address-cells = <1>;
@@ -938,5 +956,15 @@ usb_dwc3_1: usb@38200000 {
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

