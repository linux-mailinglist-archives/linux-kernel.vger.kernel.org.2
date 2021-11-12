Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A3E44E377
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 09:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhKLItE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 03:49:04 -0500
Received: from mail-dm6nam11on2067.outbound.protection.outlook.com ([40.107.223.67]:38176
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233994AbhKLItD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 03:49:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zg4vqNBn4xQr9gpvgjwPu9RGaDvZunQwePiSiAQgBu/YGh7ulHkYGixGSTRM8LKFvzdZLgvaJ9bgz4CrgQVaGkBkSrfWQfjLlzoCaeoprTLqGum1Wii4/vdnWmPXMFgtgIUC3lMy9hjbOs3cVCGWKjSzKEowzrvOqJSQAQNRowVs+7a4LA405wlirzi3KME0DJVPFhXzQoltbV6UNJGhO/lthpRRSrmPNig4MRMuFkQfxpACBSgoJciwh+3BhJiDyp96Ii0i8jRLTbe936g7dkUvf9bYF4rQLVc2iBhm4bDXMY5sirz83LXe1sM4AEis7DoIUFlA4i8qloYgs0louA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMDJoQn8qo1kAfrWNZFjgQJ6jHXwooHNV6DVr38Brp8=;
 b=iUnnQmwvBuWlXieCeSaAcJ+x4WfP+oDSAy6J7wkodPFvKKHtMUSt098ag2EAHiygV3GA/eN4RQIl2OOGwlS+QLG/BmODasB1BcYZCdAYTgWlYKH52xUXZ+NqZDdnKsDGMRsh8Oav1StQmBqQEkLtG9pvraleG8AelwV+faUZ4Mg4xbRfIrLR2qjSjTVr/uxrF1s0fX3SrjV9GYLU265g54tVHABxkss8WdissgJRaZe8zH629P1BATPEIb1MXKLkPNlixjvonapLBRFAOpQGJxktxIMS1H93j5X2Mj+h1VWOf7m9+xct/5fpEsqZPOLbcQio0/431iaH5J+mva8pCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMDJoQn8qo1kAfrWNZFjgQJ6jHXwooHNV6DVr38Brp8=;
 b=EIXIzOAfsNOlhiHrhVFsvbUhzO7wVm8xi2F17s54EQBpA5Ft/8MAnunFqCq4mitRQK4zcMGOjTdla8y51nWVHGsTxiUZXU+m3e03XQgnfaTu52u3MgyGVQy7toAmWx8xvVGNgFyG2HuWwk9is8t/GLRV3/L7uqMwf1KMQBhdLWE=
Received: from DS7PR05CA0007.namprd05.prod.outlook.com (2603:10b6:5:3b9::12)
 by DM6PR02MB6477.namprd02.prod.outlook.com (2603:10b6:5:1bd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 12 Nov
 2021 08:46:10 +0000
Received: from DM3NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::c7) by DS7PR05CA0007.outlook.office365.com
 (2603:10b6:5:3b9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.8 via Frontend
 Transport; Fri, 12 Nov 2021 08:46:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT057.mail.protection.outlook.com (10.13.5.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.19 via Frontend Transport; Fri, 12 Nov 2021 08:46:10 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 12 Nov 2021 00:46:09 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 12 Nov 2021 00:46:09 -0800
Envelope-to: devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 robh+dt@kernel.org
Received: from [10.140.6.39] (port=48926 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1mlSCG-000Bzl-MT; Fri, 12 Nov 2021 00:46:09 -0800
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v2] dt-bindings: mailbox: zynqmp_ipi: convert to yaml
Date:   Fri, 12 Nov 2021 14:16:05 +0530
Message-ID: <20211112084605.230253-1-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 839ba18e-039e-4475-cb3d-08d9a5b8e06d
X-MS-TrafficTypeDiagnostic: DM6PR02MB6477:
X-Microsoft-Antispam-PRVS: <DM6PR02MB64770783CC448E58F1517774AA959@DM6PR02MB6477.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UI2/kw2qqk5TqzJ5iyMUmhGMVZ4f8zdHhjWDaYR8sER8NJSW9b5nPSamK1R+Yl3MBHdARN7IUeJ3bOK0x2cM3d/S/Cp5WU01wxuZlRhCHY6Vhwbz4h776LSNtcNvgZLJD9EMdwOVUebUIN0raGygQNZSqvbOzvT9thXxs7/DHmCjeMaRYx7NxqQzfaPic8nF6E8zam8NaUuQFff+K7j3paBgEmB6Rsq3ugtBoGJpRTcm7vAevECsMeNBMIDfcD4G0kmUcuQ2/a/ajLIrr85wg8vD68Z0qpceEdj0qxgJZ/SxiUWTdxH0JYxXk5MAYhw/AzkDUzD3YHAwhX+df5EvtYvn+jrLWnzspsKZW4fVP7IF6DpBe6wJpELaM/iTLaWh2Bvtfc8eCRS2M9/5iWauhaSFjNZ0MCx4iewGJfpOzRJfeZ2U3HgHGXdoI6ks8cCFhfS563/hZ30ig0lwpy7iL4AjG0e323vqsERIHsVR1tL6uh8VZ0Lb4ZoyK3URhV7Kp48d0BjeHSJ6JLKqlbYxRYwesWWAMvdkf3aNtTdGhHrEgB1YzARzL5KmfHeYsYm2TwronNIsxjDtNViLsjQKUrMdzdUBvlsibwMLHMni6eHZjxjfHlKPfWBGQadQ/IohYOMvQswTVhUFwiGvfi2isPp4mV5aciVlBRw1HtgA94HpnWrqXbtgPGkdHDna6+wX0b8BHT1oYIyl5mNSJihMPn58X3RZAhoXiGL31lcm+UpA5EhMgw3CinN6GGxAvq9DiWQlKKEKruvTalJzeCWSdLxxeDO7WTYIlJ3jpt6U8e6DZAgenRynkjlOVe+S81+09jmXnf41KNzBnOUJMtAT9NZGeNbD5pb4ZVTMpiYHVuQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(36860700001)(70586007)(44832011)(426003)(336012)(2616005)(82310400003)(70206006)(9786002)(6666004)(36906005)(83380400001)(54906003)(7696005)(8676002)(508600001)(8936002)(4326008)(316002)(2906002)(6916009)(15650500001)(107886003)(47076005)(186003)(26005)(5660300002)(1076003)(356005)(7636003)(36756003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 08:46:10.6573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 839ba18e-039e-4475-cb3d-08d9a5b8e06d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6477
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ipi doc to yaml.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v2:
Fix the warnings reported by Rob

 .../mailbox/xlnx,zynqmp-ipi-mailbox.txt       | 127 ------------------
 .../mailbox/xlnx,zynqmp-ipi-mailbox.yaml      |  63 +++++++++
 2 files changed, 63 insertions(+), 127 deletions(-)
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
index 000000000000..8019a7b294ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
@@ -0,0 +1,63 @@
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
+  - xlnx,ipi-id
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
+     };
+
+          /* Client node APU<->RPU0 IPI mailbox controller */
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
+...
-- 
2.25.1

