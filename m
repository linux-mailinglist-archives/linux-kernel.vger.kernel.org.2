Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D324233EA1C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhCQGxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:53:51 -0400
Received: from mail-mw2nam10on2084.outbound.protection.outlook.com ([40.107.94.84]:26081
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229986AbhCQGxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:53:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrvLWL00hbxG4FmVtosj/laRTFvLQClN3o4c6itIM9h6sEBJxn3lyIxIv/lcP5Bf2U1kyMFServyDM/sYqUMOQtoTKaQO0q6z9CwVbfRtAesRzsRcogtbwlFSkp7VsXEHw3qQGXewyLfoy5DF/3Se41oTYhkcy5W4sQokMIS974W+t0L00myJnVyxi3Pld0IIv1S3JcgVdgiefPj5AyYo7A0r8Uf5LbAqehckNP2TbME9N3eOETHap5BKbH2QEA3k8tn09rlCxT2DFJsPxe9mZ3DevLPWSPAwsZsgBH+ldcxuNKrdaEolIKJfQMIy/RJettNQXQtAGptPrBIetz5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4znkoa0P40ojNIusJhg42UYe3k8MqAX26HNcAaUdXk=;
 b=dw/dzaP2zkl/vyQ00jBGi6ER5pVz4Ib3MIljwYroPGcMcpvYN74SKXqDPh9/I8U5sZMyuuJjG1IofuSZRz4dNbIuUwTCISDic+PxY31jK4MCrPhdmM0QhdA2WTHX2USWZ3QipdygDKA1FCcE6oMZMUwESlqo1VtEsn3jjiXyfIJ52eJg22mqRjghP2sb0EU2xCYunlO3UkEjbV3NieqAs1GXdNtNZK0BICInphBNQC62ZZFJHgA1y6wdN5z2cPA4/Y/QQevtDGrbkmVZYixWy9Ve8CSMRhcKo2EYFw5JXl9eG1M58BNAWX/VoS+sTfUmi4+NUsXhc9RPQrt9Pis4+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4znkoa0P40ojNIusJhg42UYe3k8MqAX26HNcAaUdXk=;
 b=Nv12BXkO1fy8K+XFHBbS2mSUlN13uvfNxtoF59CpLMAFvW0PnoM2Js3fR73MYW2iLld9MYma78/0EgJ8dNOXssMIFZQlnvka0J7IwhLfaHfS1VZ7loKYhlk4FsJazcA1crnneWFB5nWMvnU0n7EiuXiYruibAzMzqxQY+Cu/b4E=
Received: from MN2PR17CA0034.namprd17.prod.outlook.com (2603:10b6:208:15e::47)
 by CY4PR0201MB3539.namprd02.prod.outlook.com (2603:10b6:910:94::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Wed, 17 Mar
 2021 06:53:09 +0000
Received: from BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:15e:cafe::d4) by MN2PR17CA0034.outlook.office365.com
 (2603:10b6:208:15e::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Wed, 17 Mar 2021 06:53:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT040.mail.protection.outlook.com (10.152.77.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3933.32 via Frontend Transport; Wed, 17 Mar 2021 06:53:09 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Mar 2021 23:52:46 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 16 Mar 2021 23:52:46 -0700
Envelope-to: git@xilinx.com,
 balbi@kernel.org,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 p.zabel@pengutronix.de,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Received: from [172.23.64.106] (port=48678 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1lMQ2v-0003fH-KP; Tue, 16 Mar 2021 23:52:45 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id BA877121032; Wed, 17 Mar 2021 12:22:31 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <balbi@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <git@xilinx.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v4 1/2] dt-bindings: usb: dwc3-xilinx: Add documentation for Versal DWC3 Controller
Date:   Wed, 17 Mar 2021 12:22:28 +0530
Message-ID: <1615963949-75320-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1615963949-75320-1-git-send-email-manish.narani@xilinx.com>
References: <1615963949-75320-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d100ed4-3957-4d48-fb0e-08d8e9115331
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3539:
X-Microsoft-Antispam-PRVS: <CY4PR0201MB353984AB1E110AA74DEC804BC16A9@CY4PR0201MB3539.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ya7l44jp91wrfpzEgz0w3aLeoz+I9FS1yUg7Prltiz61AOABuO1zxyTmRaqb5ppwal3+6pEonBqPX2zxubn2rXipdhW5LKwR0GbJp6dTxU5jZYU6cNqMJMrpBAB+UQ8g5tY+EewJHz2SZvnFV8YWqqAcidXzjkjnbVAJJ7h61UkZWj91+GBJRDzvD4Pna9XkFoNKuhMe1cMFmvpGvBd4W7kpOUlEdNAeGEuK7yJLSNNODC4GcMEuFq34MXhiT75nPDQqimSO0EkP1XqyY+Knq63iRwIDkifkWQIrE36rEF8mXwh+CP9GNifx1vgM/ZY4oUs7S2qtPxpgT4Fe41fVulL2G/UYVDgOmaGbreEeOTDnHmzD5bLU7VQtcp+O9xi8XPn7R8wOSQvUilE5/Tp840zUu8ItdJXQbgLwZQgXYqe3KJJVnuCHJCKEVSdeRTxU6tII9ktUE+2/E/zCAAlnlfiwGBC30yilMm7WVTkTfnTTfNF74b4hwKfPjKlWGtxs9qKiNLBuKM3URMcmKTmBsWS6WtjMtZBy3WIt0u2KC43MVaqdVQzBl5Yfl45AkR9d8fv7cT7QjSNxCjO/4dhF9MTQnimnQSyoY3jgE84tGenF3YXZ9glXWWs+tRqhI0KOGHSp1RClnDQRDcwXJJ/VD2gEXaFWc4Il+a7UZxokvmfW+woBRyHnQruP5ZZu88fW
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966006)(36840700001)(36756003)(7636003)(6666004)(186003)(336012)(316002)(26005)(2616005)(426003)(356005)(82310400003)(83380400001)(42186006)(54906003)(36906005)(4326008)(2906002)(110136005)(70206006)(82740400003)(8936002)(6266002)(5660300002)(107886003)(44832011)(70586007)(36860700001)(47076005)(8676002)(478600001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 06:53:09.0936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d100ed4-3957-4d48-fb0e-08d8e9115331
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3539
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for Versal DWC3 controller. Add required property
'reg' for the same. Also add optional properties for snps,dwc3.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/usb/dwc3-xilinx.txt        | 28 ++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
index a668f43..04813a4 100644
--- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
@@ -1,32 +1,56 @@
 Xilinx SuperSpeed DWC3 USB SoC controller
 
 Required properties:
-- compatible:	Should contain "xlnx,zynqmp-dwc3"
+- compatible:	May contain "xlnx,zynqmp-dwc3" or "xlnx,versal-dwc3"
+- reg:		Base address and length of the register control block
 - clocks:	A list of phandles for the clocks listed in clock-names
 - clock-names:	Should contain the following:
   "bus_clk"	 Master/Core clock, have to be >= 125 MHz for SS
 		 operation and >= 60MHz for HS operation
 
   "ref_clk"	 Clock source to core during PHY power down
+- resets:	A list of phandles for resets listed in reset-names
+- reset-names:
+  "usb_crst"	 USB core reset
+  "usb_hibrst"	 USB hibernation reset
+  "usb_apbrst"	 USB APB reset
 
 Required child node:
 A child node must exist to represent the core DWC3 IP block. The name of
 the node is not important. The content of the node is defined in dwc3.txt.
 
+Optional properties for snps,dwc3:
+- dma-coherent:	Enable this flag if CCI is enabled in design. Adding this
+		flag configures Global SoC bus Configuration Register and
+		Xilinx USB 3.0 IP - USB coherency register to enable CCI.
+- interrupt-names: Should contain the following:
+  "dwc_usb3"	USB gadget mode interrupts
+  "otg"		USB OTG mode interrupts
+  "hiber"	USB hibernation interrupts
+
 Example device node:
 
 		usb@0 {
 			#address-cells = <0x2>;
 			#size-cells = <0x1>;
 			compatible = "xlnx,zynqmp-dwc3";
+			reg = <0x0 0xff9d0000 0x0 0x100>;
 			clock-names = "bus_clk", "ref_clk";
 			clocks = <&clk125>, <&clk125>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_USB1_CORERESET>,
+				 <&zynqmp_reset ZYNQMP_RESET_USB1_HIBERRESET>,
+				 <&zynqmp_reset ZYNQMP_RESET_USB1_APB>;
+			reset-names = "usb_crst", "usb_hibrst", "usb_apbrst";
 			ranges;
 
 			dwc3@fe200000 {
 				compatible = "snps,dwc3";
 				reg = <0x0 0xfe200000 0x40000>;
-				interrupts = <0x0 0x41 0x4>;
+				interrupt-names = "dwc_usb3", "otg", "hiber";
+				interrupts = <0 65 4>, <0 69 4>, <0 75 4>;
+				phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
+				phy-names = "usb3-phy";
 				dr_mode = "host";
+				dma-coherent;
 			};
 		};
-- 
2.1.1

