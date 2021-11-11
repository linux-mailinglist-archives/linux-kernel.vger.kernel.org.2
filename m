Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E1844D3AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhKKJFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:05:23 -0500
Received: from mail-mw2nam12on2078.outbound.protection.outlook.com ([40.107.244.78]:34240
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232659AbhKKJDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:03:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ijovd6qTDRmCeR2cYj8Hvl/EGmIN4YEgW6iS+gq9l4u3pchredPDfNCCccArcicNpAnLaATdsW5nVr5YdKmuDp9tTFghU8fYYnuBNs25UHY4j9KIJW+GrSfNDXshSwChfZNyP14P7CJW5OVPy1n7Bmg4QE3IyVahS17026I30NwcUJWwmrSx5Vaql43Kyl+hrqyKsmbSThclzGN5OfVjiNzDZEHYCmCvc5Ytuuc1GRiTcA3L3hqUnuKM73U1i35DUJKYqBrcpCYcs9MarT9EuUJkvpB8C9dOqBGPg4AN1RyfzOvGaRR6CTzFm1Ob85sqOKBSi18Qsmoec/cX5c9QsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usua3qUm54miz0zncdQcT/0f5HmgzzQT2XDwRI+zbTY=;
 b=Aar83DiGLCgI2d3OOW2Ce3WWdrAm3npbCTXeRm2gl9ycEq/zjVXiZxl5Reeu+rzH4/tB7JzKqFUktpapewKS3QS1UqV7st3vouV4lzqi1BJaq8yHc0ajCbe0QZYIXE6hbB3MQQ1WPJoktcp4dsnruqmzNk3ruPMf/T+nnqL1C4tm4q9Xhgtwd79dfxRxK6sKvu6LxwOXbQRsqdMubCTCMgy8cFjNWe/B82mFlNbw15TnvHAnXS7nLkNdJypEUfu9nGVMhHv2VmjZakrU/tgXzd8/qVEBEytkCba3Wa7mTQPXjKMrUkoY6n35yXtTA/bfCxdo5+ltTb6P3dHyIwWZ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usua3qUm54miz0zncdQcT/0f5HmgzzQT2XDwRI+zbTY=;
 b=kwckI9sD7XELjq1XrQ430BfcA6pe3eqcmflpCEUX75BXoSJUwlmr+VK1feW5zGaeeOG8z6BuW3x2qI8zij3W+hCQeKOcd147JElFhGEePUq5SO11qAcqrHiXl0/9T3TRoboG/8FBEMoKZwnj8Em9mcAwQpl0cuZZKsv0VmpgXiA=
Received: from BN0PR04CA0147.namprd04.prod.outlook.com (2603:10b6:408:ed::32)
 by MWHPR02MB3390.namprd02.prod.outlook.com (2603:10b6:301:6b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Thu, 11 Nov
 2021 08:59:46 +0000
Received: from BN1NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::a3) by BN0PR04CA0147.outlook.office365.com
 (2603:10b6:408:ed::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16 via Frontend
 Transport; Thu, 11 Nov 2021 08:59:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT042.mail.protection.outlook.com (10.13.2.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.19 via Frontend Transport; Thu, 11 Nov 2021 08:59:46 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 11 Nov 2021 00:59:44 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 11 Nov 2021 00:59:44 -0800
Envelope-to: devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 robh+dt@kernel.org
Received: from [10.140.6.6] (port=42790 helo=xhdappanad40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1ml5vr-0004ND-1d; Thu, 11 Nov 2021 00:59:43 -0800
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <git-dev@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] dt-bindings: mailbox: zynqmp_ipi: convert to yaml
Date:   Thu, 11 Nov 2021 14:29:39 +0530
Message-ID: <20211111085939.21769-1-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 379e4255-879f-4928-3eb5-08d9a4f19c30
X-MS-TrafficTypeDiagnostic: MWHPR02MB3390:
X-Microsoft-Antispam-PRVS: <MWHPR02MB3390FD9BFD669C36C5541FD8AA949@MWHPR02MB3390.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5q9wnfC2oKcomb77yuvLA4yBRfVwPOCc0Z9pIFeCMOYWP/lz/EdnPcR8PRzTu/cniSRj/oY2ykie6hlQtlit0eTfd+Ku2u73besRoUB4NWMLaQxYQ1jtLFd8wx2BJTPzGsf7p5N3ziikVQ4xO179QRyvwXnmwco2AX6Vank9NGPE6c8qkZgK2W3zUWX922/6j2DH7WQylPVqqm1juqDUmxUGy7U2KiXe76rXDQok48SO15ny4NpTxQLvy6LBcw58CvpZO1Ysl0l6kJXdRThyoT1N8Z20QBHX+G6bdiOVLX5YlM7moAL03uGxb7cKnEuaMvTyEaNzUbF8OnG71GPNsNxXxn3n2ZMmeM2AJ30X8npxRPsgeaAFVX/GCKZylUvTNh5owe8d5/fJD9Svt8/dFolUaPReHu2jYQp+Tphx7qKigj0rwF1bPy4lqb+gzkdHuxdzoD4yBE97I9zjLqjrV5zMKMmlLpqWVpd/UctGxxrdN4kLSV8dftfJhLmhPSYGlTY4gBnRjy3ES6H0dYK8tQM0MMuOOzKHMbxyGXy8aY6VBsHpPTODps7wj549++eLX/YiExdz7YctwZCBAWyrgp/ZwSqbAZxO8PDAIokX7vP28oWfpuqwha30R3f9b47GkQtpH5phiIMi70bXyBZrCV9hCySSqhicp4JFA2awIpuLLom4wEOg8PkyOWWNKda5V4gNni8XmeqaELtPgxRE7tsBDdNDcG2kZ6SSu5/eA3ax3OBF3ikjgKwnHrMy4JWgQcLCeleFjts2gzpVN+JD6HVlfxaRXifEmEWoFT8eXzQnYnN8kATxgCGT7WHw/08Dp91vcbtE2Vu/oaR3ZJorhAGad1dMZEusRLY+GzNBzaY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(336012)(6666004)(15650500001)(26005)(8936002)(7696005)(6916009)(508600001)(2616005)(4326008)(316002)(47076005)(83380400001)(44832011)(426003)(1076003)(107886003)(186003)(356005)(36756003)(9786002)(8676002)(54906003)(36860700001)(70586007)(70206006)(82310400003)(5660300002)(2906002)(36906005)(7636003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 08:59:46.2797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 379e4255-879f-4928-3eb5-08d9a4f19c30
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT042.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3390
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ipi doc to yaml.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 .../mailbox/xlnx,zynqmp-ipi-mailbox.txt       | 127 ------------------
 .../mailbox/xlnx,zynqmp-ipi-mailbox.yaml      |  91 +++++++++++++
 2 files changed, 91 insertions(+), 127 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
deleted file mode 100644
index ad76edccf881..000000000000
--- a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
+++ /dev/null
@@ -1,127 +0,0 @@
-Xilinx IPI Mailbox Controller
-========================================
-
-The Xilinx IPI(Inter Processor Interrupt) mailbox controller is to manage
-messaging between two Xilinx Zynq UltraScale+ MPSoC IPI agents. Each IPI
-agent owns registers used for notification and buffers for message.
-
-               +-------------------------------------+
-               | Xilinx ZynqMP IPI Controller        |
-               +-------------------------------------+
-    +--------------------------------------------------+
-ATF                    |                     |
-                       |                     |
-                       |                     |
-    +--------------------------+             |
-                       |                     |
-                       |                     |
-    +--------------------------------------------------+
-            +------------------------------------------+
-            |  +----------------+   +----------------+ |
-Hardware    |  |  IPI Agent     |   |  IPI Buffers   | |
-            |  |  Registers     |   |                | |
-            |  |                |   |                | |
-            |  +----------------+   +----------------+ |
-            |                                          |
-            | Xilinx IPI Agent Block                   |
-            +------------------------------------------+
-
-
-Controller Device Node:
-===========================
-Required properties:
---------------------
-IPI agent node:
-- compatible:		Shall be: "xlnx,zynqmp-ipi-mailbox"
-- interrupt-parent:	Phandle for the interrupt controller
-- interrupts:		Interrupt information corresponding to the
-			interrupt-names property.
-- xlnx,ipi-id:		local Xilinx IPI agent ID
-- #address-cells:	number of address cells of internal IPI mailbox nodes
-- #size-cells:		number of size cells of internal IPI mailbox nodes
-
-Internal IPI mailbox node:
-- reg:			IPI buffers address ranges
-- reg-names:		Names of the reg resources. It should have:
-			* local_request_region
-			  - IPI request msg buffer written by local and read
-			    by remote
-			* local_response_region
-			  - IPI response msg buffer written by local and read
-			    by remote
-			* remote_request_region
-			  - IPI request msg buffer written by remote and read
-			    by local
-			* remote_response_region
-			  - IPI response msg buffer written by remote and read
-			    by local
-- #mbox-cells:		Shall be 1. It contains:
-			* tx(0) or rx(1) channel
-- xlnx,ipi-id:		remote Xilinx IPI agent ID of which the mailbox is
-			connected to.
-
-Optional properties:
---------------------
-- method:              The method of accessing the IPI agent registers.
-                       Permitted values are: "smc" and "hvc". Default is
-                       "smc".
-
-Client Device Node:
-===========================
-Required properties:
---------------------
-- mboxes:		Standard property to specify a mailbox
-			(See ./mailbox.txt)
-- mbox-names:		List of identifier  strings for each mailbox
-			channel.
-
-Example:
-===========================
-	zynqmp_ipi {
-		compatible = "xlnx,zynqmp-ipi-mailbox";
-		interrupt-parent = <&gic>;
-		interrupts = <0 29 4>;
-		xlnx,ipi-id = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		/* APU<->RPU0 IPI mailbox controller */
-		ipi_mailbox_rpu0: mailbox@ff990400 {
-			reg = <0xff990400 0x20>,
-			      <0xff990420 0x20>,
-			      <0xff990080 0x20>,
-			      <0xff9900a0 0x20>;
-			reg-names = "local_request_region",
-				    "local_response_region",
-				    "remote_request_region",
-				    "remote_response_region";
-			#mbox-cells = <1>;
-			xlnx,ipi-id = <1>;
-		};
-		/* APU<->RPU1 IPI mailbox controller */
-		ipi_mailbox_rpu1: mailbox@ff990440 {
-			reg = <0xff990440 0x20>,
-			      <0xff990460 0x20>,
-			      <0xff990280 0x20>,
-			      <0xff9902a0 0x20>;
-			reg-names = "local_request_region",
-				    "local_response_region",
-				    "remote_request_region",
-				    "remote_response_region";
-			#mbox-cells = <1>;
-			xlnx,ipi-id = <2>;
-		};
-	};
-	rpu0 {
-		...
-		mboxes = <&ipi_mailbox_rpu0 0>,
-			 <&ipi_mailbox_rpu0 1>;
-		mbox-names = "tx", "rx";
-	};
-	rpu1 {
-		...
-		mboxes = <&ipi_mailbox_rpu1 0>,
-			 <&ipi_mailbox_rpu1 1>;
-		mbox-names = "tx", "rx";
-	};
diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
new file mode 100644
index 000000000000..92d080fc0168
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/mailbox/xlnx,zynqmp-ipi-mailbox.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Xilinx IPI Mailbox controller bindings
+
+description:
+  The Xilinx IPI(Inter Processor Interrupt) mailbox controller is to manage
+  messaging between two Xilinx Zynq UltraScale+ MPSoC IPI agents. Each IPI
+  agent owns registers used for notification and buffers for message.
+
+maintainers:
+  - Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
+
+properties:
+  compatible:
+    const: xlnx,zynqmp-ipi-mailbox
+
+  reg:
+    maxItems: 4
+
+  interrupts:
+    maxItems: 1
+
+  "#mbox-cells":
+    const: 1
+
+  xlnx,ipi-id:
+    description: Xilinx IPI agent id
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - xlnx,ipi-id
+  - "#mbox-cells"
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+     zynqmp_ipi {
+          compatible = "xlnx,zynqmp-ipi-mailbox";
+          interrupt-parent = <&gic>;
+          interrupts = <0 29 4>;
+          xlnx,ipi-id = <0>;
+          #address-cells = <1>;
+          #size-cells = <1>;
+          ranges;
+
+          /* APU<->RPU0 IPI mailbox controller */
+          ipi_mailbox_rpu0: mailbox@ff990400 {
+               reg = <0xff990400 0x20>,
+                     <0xff990420 0x20>,
+                     <0xff990080 0x20>,
+                     <0xff9900a0 0x20>;
+               reg-names = "local_request_region",
+                        "local_response_region",
+                        "remote_request_region",
+                        "remote_response_region";
+               #mbox-cells = <1>;
+               xlnx,ipi-id = <1>;
+          };
+          /* APU<->RPU1 IPI mailbox controller */
+          ipi_mailbox_rpu1: mailbox@ff990440 {
+               reg = <0xff990440 0x20>,
+                     <0xff990460 0x20>,
+                     <0xff990280 0x20>,
+                     <0xff9902a0 0x20>;
+               reg-names = "local_request_region",
+                        "local_response_region",
+                        "remote_request_region",
+                        "remote_response_region";
+               #mbox-cells = <1>;
+               xlnx,ipi-id = <2>;
+          };
+     };
+     rpu0 {
+          mboxes = <&ipi_mailbox_rpu0 0>,
+                <&ipi_mailbox_rpu0 1>;
+          mbox-names = "tx", "rx";
+     };
+     rpu1 {
+          mboxes = <&ipi_mailbox_rpu1 0>,
+                <&ipi_mailbox_rpu1 1>;
+          mbox-names = "tx", "rx";
+     };
+...
-- 
2.17.1

