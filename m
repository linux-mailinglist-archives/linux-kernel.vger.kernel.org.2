Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8A839B739
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 12:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhFDKi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 06:38:57 -0400
Received: from mail-db8eur05on2084.outbound.protection.outlook.com ([40.107.20.84]:17441
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229667AbhFDKi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 06:38:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8RJHYP62z87KxhfjvyH4UiAlct6IzU+SkKMWcnn7f5WIedVpPBJTweVd9Ld+Z3QWX2xAWtAKa3ZHwpd1p2BnmLfgSN9mesyW/8Hmr5Eh0LeOCtibcG/ZSphbNZjmEk2KnaQEx5Q8XbikrtZCV6DDkLFn7MGEoPJl/jMVCoRlqdF0u2EsIlRXVxZu3cfpkCiYFUjJObpL+OXwIzWcNWa3bDjF0VZ+N7yd6Nt7aalo0+sXEbBBeOSdo8JDTfKkx87opMQ0wBC9HmXjHomewnp/ymP8Ka06GkpU5nkBwHpKD7UZtUFIqO7Wf5qn0fzJ1gKcaBcv+mgnKx2RLIccaiAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKrtWAloRnGyRVFDCZDvOB8m4ve443N9iXxifJ4BCeg=;
 b=K5TrtMiyUBrmGMJ1w40o5x94f4LfabF5fS5ykLxCSYOLx1PIucjVxXZEH1MLWXblIKxf2d0gwWAnnIYMYzjlNf/hf7cKIHE6nm1+1IgdkC19PvfvxIqsBIzmjjhfLrl2LXgUXxTF6Anf4m7mbju3ljopK/rbpXs6CEiS4ulNUH9JKUhZFuDGRQPagebkzi8MPBm5lUDTJ51Tqhv2x6pTaHBs3xyZeOR0cxbPwiiah4Ye++JkwqKKvGpoW6eZRGahRKQAQjRNNIPTbU8SIdHOXk+aiY5Wg0VCL3m7xR4+PA0Skq7sQOH3UHVXG5REuvnH+YUvp4NgNKWXEXmR35B98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKrtWAloRnGyRVFDCZDvOB8m4ve443N9iXxifJ4BCeg=;
 b=aEtT8ELtWJ7Im90NX3MrzBW/FeXeICa8muGPUtHDiuwWPbzf9WyjApz9bzt7ncS75tPaNcv7n21Bme6fGJ3EkX8+22REfzgwX9axNbkpL1wu7RreFO5ugq4Ocpb3U+STmmQTpqcfgSDL5+U6reDBNyNKDAmKNVe+BSjqkD6Anzg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5084.eurprd04.prod.outlook.com (2603:10a6:10:1c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 10:37:05 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 10:37:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx8mm: add pgc/blk_ctl nodes
Date:   Fri,  4 Jun 2021 19:10:05 +0800
Message-Id: <20210604111005.6804-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR02CA0085.apcprd02.prod.outlook.com
 (2603:1096:4:90::25) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR02CA0085.apcprd02.prod.outlook.com (2603:1096:4:90::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Fri, 4 Jun 2021 10:36:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98730190-093d-4db7-b711-08d92744b226
X-MS-TrafficTypeDiagnostic: DB7PR04MB5084:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB508436C2577215706FA16B87C93B9@DB7PR04MB5084.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hcI6Mkfyh3D6kvZWSd1FqJy+ba38pW7Vr5uEvhlVmQmDhWEy+9MCQTD3zPE8+np+1Te9oKp+Kuxp+jJB/OtAG6cjyFZS85v6sgHl2HIgOSOzmlOlz1BzVqxp0+EAehE9PXJFRq3CVRmSvj3jSXp0LvveJFHD6f0CoPkegSFbpS+6f17+pyW+VT4A85df56mYYcXiC8lY/ZGnPKOohxF1Irp79BTe1ZRZ7mKHwuju32Mrc0bYau9ywq8XiV5OrJj/SUqRzAbQv01UPd/Hq4nXgtqn9Rhvaz9PhLanFeWN4YRzxme1SLv68pXMPr6HxMMdGaciRrnXXzPa5iFN/PjF3mneypxlqXpZeJ/r+sK93EzxvFQokEOOQupuJBvaKrpJlPTzLX9EeuEMLfXxn1rm4ZUV0uHq+pZerPEKR6yuTeDpqvI5VsQVvzc9MSn7rv7juV8pvajML85N6uR6boFM1OtVX+ZA+PdgCwJmGGRd2nJFXvFJET1rYuPn3wNP6daxAahM3FvHc+L1MvbEeoXnuazQhn0tbNPrwg5TQYDg7izQMOABP6A8N2h7YQBo3NB8XfqwcfhO13io0zFAXmyag12l/rISRn3HyQWFLzcVG33OAecWU0jiw6rM42NfqWczDPIM38aj5iZZJJmRoJhkcjF1WX/ZUjNYwI55Rzg9UTqhM7KtOzBzHsFZ0HMTGSaM+RIshyoqI/RqNVHyPJZf0sX7N2y3ubasXe8mHRyCU0gy2n59kZmxePiwVS0UdVbkBBHVwukx0ZmFT8I5z7EKyUFsQ8ksbi0M2yiYwyg8w3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(5660300002)(6512007)(26005)(38100700002)(38350700002)(478600001)(16526019)(186003)(83380400001)(966005)(4326008)(956004)(2616005)(1076003)(6666004)(66946007)(8676002)(66476007)(86362001)(6486002)(8936002)(2906002)(52116002)(7416002)(6506007)(66556008)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FvYN+zr9WiMiPJ5v0ZwWykbcVVWB42weeVwDlhXkyJ69BFSMhBBchUBFs11Z?=
 =?us-ascii?Q?At8rG5mQNcGGte/F12r8yIjHEH3BLnLOKBFiCjnWt3vy4CbRDRTHlpX8so/Z?=
 =?us-ascii?Q?vQcC3K3HRocnX3a+MzTCkCnWYd4RJWIJ2klFhoeem1imlGZJXmC+SsGJgOdQ?=
 =?us-ascii?Q?qldL6kUgr8y8HyZVLFW08x8m8hSVJkNspdhpsiJ6DR3lnMHnq7OKgJjXfueX?=
 =?us-ascii?Q?VlM4dYPfDxDfc+t6p6EGGMutE/8Aks8oDU6Y2rVXouBy5TrcDmeOrnnKK7CH?=
 =?us-ascii?Q?6AZoWmaNnZwaC/sz/MPrElhPao+QdTJv61oRQIzQ8FFGTjV8eTdCJvzQAFIT?=
 =?us-ascii?Q?n+IbeA9z93haKjJPDugSbALe/Zo1/HzpJfTEy/QjPjwVVvZOHeSQXOlqw0Wo?=
 =?us-ascii?Q?ItqcIDHsbD7j9UzC8uHtfzQbyj5E9XE6jxOeHiHOZZfdOEesKHYpCTTlLA8F?=
 =?us-ascii?Q?NT/dRTrdyKvnG2/0s11H94hRElviui4jmQDRmwcq0QFbaOqcN5lfsYSaQWqB?=
 =?us-ascii?Q?M9PX0efO5bDv3o9hveqI7ZElGlWWAfC0mhynZR33FVCkDOVMkoOaUQ2AISX9?=
 =?us-ascii?Q?2vHbVROTf7VCcpbT+zmOABWkrrq6DbcvVPM4nGSNnIWQj7DCPUWO0f97NXLE?=
 =?us-ascii?Q?qsZC4kTCilYnwrK91z7Q0T1w2qq/zU3hRw0tZaIjoCa103+v/9OcKMagKPsw?=
 =?us-ascii?Q?Zb4u6JVhntLQbX/Osd4qUTTUIVds1PZRUpFz5hBP5QRqZvaVTAAi+UIOZSDQ?=
 =?us-ascii?Q?AAyKGumokRzj1Xw3bRfVRUmwO4Y5UtbWtYWApnGJ7urOTXAKycQlTyzcRdTi?=
 =?us-ascii?Q?bKfx4/vsA90x3UlPx0EVAZ+1sp2Pr0I7YyRuO0sh5WcHNtWZjHiUhL1LniZn?=
 =?us-ascii?Q?m/GoJgLDkwiT6qhRGht1ba/Y+xFofuVLzWvggXF82VW4QXHrfJMoLTIaleRm?=
 =?us-ascii?Q?kIS/o++mQKVgwgqXpjsIdNOf4G4eLpZSvtKVdFR8rMnpjm4JihdHYuouzQaE?=
 =?us-ascii?Q?1X60pRlasLzE3263qeBKP0maMZAdb77WHfaJp1khKJ5aZZVU3MCPzKQJvKws?=
 =?us-ascii?Q?BwMnKlVz56oH05hpiC0OY+gA+aOS+0ZseYbpS0oQWlwMP7NmHcrUykU0JgB4?=
 =?us-ascii?Q?A2822Ql1JCKWU94n2Y2FQjCovNiPqIa8J1MI2D4mFCB2wmNhFgdIlbe2pxOX?=
 =?us-ascii?Q?RtkBMbYqIkzbXjlBYR5BI3zSxrlN9FqqtRjcmeP8MFyF7HTiDL4Y8vZ/KynN?=
 =?us-ascii?Q?3oVDgrz2Yb8WlWLOtQWP4vAWKKi0uwJB3DwRlb2C5lnl5vdBhjmVxQwnQP16?=
 =?us-ascii?Q?uccMb5y93MU/JbBbTJVKDrdcpJOLEOAy5XRPcOl5OvFVZA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98730190-093d-4db7-b711-08d92744b226
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 10:37:05.2515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxraTNlJ6vDqSFbM/obFzsed9HBrnkT5hmshyh+UhUjgOtU7szXYFSaDgH2Vk100rh/7jTDyRldP1F+tqDC1XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

With PGC and BLK-CTL landed, we could add pgc and blk-ctl nodes,
because some pgc domain relies on blk-ctl power domain, so
they need to be added together.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1:
 Depends on the blk-ctl patchset,
 https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210522134249.15322-1-peng.fan@oss.nxp.com/

 Shawn,
  Since the blk-ctl patchset is in good shape and tested, is it ok for
  you to pick up?
 Thanks

 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 128 ++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index e7648c3b8390..0e01ff649956 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -7,6 +7,8 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/imx8mm-power.h>
+#include <dt-bindings/reset/imx8mq-reset.h>
 #include <dt-bindings/thermal/thermal.h>
 
 #include "imx8mm-pinfunc.h"
@@ -609,6 +611,109 @@ src: reset-controller@30390000 {
 				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 				#reset-cells = <1>;
 			};
+
+			gpc: gpc@303a0000 {
+				compatible = "fsl,imx8mm-gpc";
+				reg = <0x303a0000 0x10000>;
+				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-parent = <&gic>;
+				interrupt-controller;
+				#interrupt-cells = <3>;
+
+				pgc {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					pgc_hsiomix: power-domain@0 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_HSIOMIX>;
+						clocks = <&clk IMX8MM_CLK_USB1_CTRL_ROOT>;
+					};
+
+					pgc_pcie: power-domain@1 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_PCIE>;
+						power-domains = <&pgc_hsiomix>;
+						clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>;
+					};
+
+					pgc_otg1: power-domain@2 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_OTG1>;
+						power-domains = <&pgc_hsiomix>;
+					};
+
+					pgc_otg2: power-domain@3 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_OTG2>;
+						power-domains = <&pgc_hsiomix>;
+					};
+
+					pgc_gpumix: power-domain@4 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_GPUMIX>;
+						clocks = <&clk IMX8MM_CLK_GPU_BUS_ROOT>,
+							 <&clk IMX8MM_CLK_GPU_AHB>;
+					};
+
+					pgc_gpu: power-domain@5 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_GPU>;
+						clocks = <&clk IMX8MM_CLK_GPU_AHB>,
+							 <&clk IMX8MM_CLK_GPU_BUS_ROOT>,
+							 <&clk IMX8MM_CLK_GPU2D_ROOT>,
+							 <&clk IMX8MM_CLK_GPU3D_ROOT>;
+						resets = <&src IMX8MQ_RESET_GPU_RESET>;
+						power-domains = <&pgc_gpumix>;
+					};
+
+					pgc_vpumix: power-domain@6 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_VPUMIX>;
+						clocks = <&clk IMX8MM_CLK_VPU_DEC_ROOT>;
+						resets = <&src IMX8MQ_RESET_VPU_RESET>;
+					};
+
+					pgc_vpu_g1: power-domain@7 {
+						#power-domain-cells = <0>;
+						power-domains =
+						<&vpumix_blk_ctl IMX8MM_BLK_CTL_PD_VPU_BUS>;
+						reg = <IMX8MM_POWER_DOMAIN_VPUG1>;
+						clocks = <&clk IMX8MM_CLK_VPU_G1_ROOT>;
+					};
+
+					pgc_vpu_g2: power-domain@8 {
+						#power-domain-cells = <0>;
+						power-domains =
+						<&vpumix_blk_ctl IMX8MM_BLK_CTL_PD_VPU_BUS>;
+						reg = <IMX8MM_POWER_DOMAIN_VPUG2>;
+						clocks = <&clk IMX8MM_CLK_VPU_G2_ROOT>;
+					};
+
+					pgc_vpu_h1: power-domain@9 {
+						#power-domain-cells = <0>;
+						power-domains =
+						<&vpumix_blk_ctl IMX8MM_BLK_CTL_PD_VPU_BUS>;
+						reg = <IMX8MM_POWER_DOMAIN_VPUH1>;
+						clocks = <&clk IMX8MM_CLK_VPU_H1_ROOT>;
+					};
+
+					pgc_dispmix: power-domain@10 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_DISPMIX>;
+						clocks = <&clk IMX8MM_CLK_DISP_ROOT>,
+							 <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
+							 <&clk IMX8MM_CLK_DISP_APB_ROOT>;
+					};
+
+					pgc_mipi: power-domain@11 {
+						#power-domain-cells = <0>;
+						reg = <IMX8MM_POWER_DOMAIN_MIPI>;
+						power-domains =
+						<&dispmix_blk_ctl IMX8MM_BLK_CTL_PD_DISPMIX_BUS>;
+					};
+				};
+			};
 		};
 
 		aips2: bus@30400000 {
@@ -960,6 +1065,18 @@ aips4: bus@32c00000 {
 			#size-cells = <1>;
 			ranges = <0x32c00000 0x32c00000 0x400000>;
 
+			dispmix_blk_ctl: blk_ctl@32e28000 {
+				compatible = "fsl,imx8mm-dispmix-blk-ctl", "syscon";
+				reg = <0x32e28000 0x100>;
+				#power-domain-cells = <1>;
+				#reset-cells = <1>;
+				power-domains = <&pgc_dispmix>, <&pgc_mipi>;
+				power-domain-names = "dispmix", "mipi";
+				clocks = <&clk IMX8MM_CLK_DISP_ROOT>,
+					 <&clk IMX8MM_CLK_DISP_AXI_ROOT>,
+					 <&clk IMX8MM_CLK_DISP_APB_ROOT>;
+			};
+
 			usbotg1: usb@32e40000 {
 				compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
 				reg = <0x32e40000 0x200>;
@@ -1029,6 +1146,17 @@ gpmi: nand-controller@33002000{
 			status = "disabled";
 		};
 
+		vpumix_blk_ctl: blk-ctl@38330000 {
+			compatible = "fsl,imx8mm-vpumix-blk-ctl", "syscon";
+			reg = <0x38330000 0x100>;
+			#power-domain-cells = <1>;
+			#reset-cells = <1>;
+			power-domains = <&pgc_vpumix>, <&pgc_vpu_g1>, <&pgc_vpu_g2>, <&pgc_vpu_h1>;
+			power-domain-names = "vpumix", "vpu-g1", "vpu-g2", "vpu-h1";
+			clocks = <&clk IMX8MM_CLK_VPU_DEC_ROOT>, <&clk IMX8MM_CLK_VPU_G1_ROOT>,
+				 <&clk IMX8MM_CLK_VPU_G2_ROOT>, <&clk IMX8MM_CLK_VPU_H1_ROOT>;
+		};
+
 		gic: interrupt-controller@38800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x38800000 0x10000>, /* GIC Dist */
-- 
2.30.0

