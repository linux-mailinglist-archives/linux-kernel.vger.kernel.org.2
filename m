Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41166438B40
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 20:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhJXSJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 14:09:07 -0400
Received: from mail-bn8nam12on2047.outbound.protection.outlook.com ([40.107.237.47]:51168
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231481AbhJXSJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 14:09:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMyBI6Kuyo2adUa5yAU4cq9Ev108Qpv5apgQXtdwDDhdA7LdkueEEter+lrPRRJOWFmwWsuVMfEG5OnIXGFYjGqI8udKUYIEiMO2cGai/oSGwdyRbdEMhUaAkmMgMqYSj6nAvttvF802oPbCpQV2Tccpxm5dnKx59JId+sO1tEmyCmiSPJWrZbomQ+aB0XK5bQd8DvUoTPGgd9oydQG2hjk+ALkX+oXgZBB7jRuZQXN2BeVToXG8fl+hcPzD5/AeQh5ZnzPSCMxYirYzpiH1099HjR35qrrsNxdnJIWKfvbtakkfWI6dlyKfyKU90o8qL9aznHbhRX4uUKUwO0wKhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dk5tNXnnX+xvCSlRCe1U/cDu0RnRVGL4n9ARHEgL0cM=;
 b=W0xya4z1rUfvF/NzRxhhaolUvaD6RWwZyfDabtprRQTRSYnqvbyMN7MDUm6RiRXoTVgH0dewZIK6EiO1PvYklA0giVPPOovQjfgw7k5bbe46J0Km5DxGrjbfRUQgNC12My3vE4+/o87j50dCZUnuz13zREQ5elE5HxdGb8TvGa+xUPyoLdFSsPK9lkxt0r6XCdFq/LctvFpEuAvHNCoFINkwl6XlQeCYAS4fNY/abm+lgJjq3bhaJc4UdhpIdhogLsBtiCaLeoF0P/DHvac5oxR5msZmc93JiOVmQ+dPDskoIChcBteSg0dqOFCRNTdWzjByY/hIuDAyUUy0blRZlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dk5tNXnnX+xvCSlRCe1U/cDu0RnRVGL4n9ARHEgL0cM=;
 b=B+bZTx25ilxMT88TdnZPDbe8mHXcix+WDMzFHNCYC9XaN+lKrlCMdGUAYcPnBk++ZsfNJdUEb5uDSWC0Wzmld+QqV6tGdOZe8FPjCli/qij478JEfiUsYEY3bZKcBdLkE47mMLKQAmEaQ3sRsg6kwDxsZYfLG3G+YFgQ22m94tE=
Received: from SA0PR12CA0024.namprd12.prod.outlook.com (2603:10b6:806:6f::29)
 by SA2PR02MB7851.namprd02.prod.outlook.com (2603:10b6:806:137::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Sun, 24 Oct
 2021 18:06:39 +0000
Received: from SN1NAM02FT0021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:6f:cafe::e9) by SA0PR12CA0024.outlook.office365.com
 (2603:10b6:806:6f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Sun, 24 Oct 2021 18:06:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0021.mail.protection.outlook.com (10.97.5.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.18 via Frontend Transport; Sun, 24 Oct 2021 18:06:39 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 24 Oct 2021 11:06:38 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 24 Oct 2021 11:06:38 -0700
Envelope-to: git@xilinx.com,
 gregkh@linuxfoundation.org,
 --to=robh+dt@kernel.org,
 mka@chromium.org,
 ravisadineni@chromium.org,
 stern@rowland.harvard.edu,
 alcooperx@gmail.com,
 linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.35] (port=56658 helo=xhdsaipava40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1mehtG-0002dJ-9c; Sun, 24 Oct 2021 11:06:38 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <--to=robh+dt@kernel.org>,
        <mka@chromium.org>, <ravisadineni@chromium.org>,
        <stern@rowland.harvard.edu>, <alcooperx@gmail.com>,
        <michal.simek@xilinx.com>
CC:     <piyush.mehta@xilinx.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, <sgoud@xilinx.com>
Subject: [PATCH 1/2] dt-bindings: usb: misc: Add binding for Microchip usb2244 Controller
Date:   Sun, 24 Oct 2021 23:36:27 +0530
Message-ID: <20211024180628.2992108-2-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024180628.2992108-1-piyush.mehta@xilinx.com>
References: <20211024180628.2992108-1-piyush.mehta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af586e6a-b989-4537-728e-08d9971906d0
X-MS-TrafficTypeDiagnostic: SA2PR02MB7851:
X-Microsoft-Antispam-PRVS: <SA2PR02MB7851C5FC6CA6794876DF9D21D4829@SA2PR02MB7851.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dWFuu6fJvYjEFunBjD1/Ry6tnUsNlUWB5l2SPXlcw5hGCAZTIWj6QpmXj9+/OIQJOZXVwNXr9UqUvxKSVGH6ykSG5TwXeM1Ih2ytJOgwTHYsm6KW0Mt4xAtQAeGKu7UQQUtrol+ei7tcOY7dFqc5iSx687PIQaEPNbCXjx16VcUGso2se+JC8riT1Q4dPUBtrI7g/Sug+UNl+O0srA45NT2V3rfly61xZKL2YhZCs3rDM0/foUPci9MM4w4NFfCTZvko3oDPJDJY/4/uS9J0R3aj5hyZcSSBMA+V+bznNNyyKybmrvWy5XdkcOwsvocPVrhwg/bPIhu9iE3Jh0Jas5w8DGQGH7ofclMo/+8IQPR9/56LiQnMT1DyT73O+CjiwDua6v8080kVzEI+INtD0taAhDU06u4HGOv+BMLbJlcyH51jpf0qnuDqcSmm0FQhY2IC+doGvGqMCPGEUEIK7j9HyW1n0K24wJXpFABjjx4EF0q1N8GTFwjCfUN/Xu4+6vj9EzHqAYYCJ5hXH5v5p0bxCljI20j7yh6i86jkcbr01A8hN3Ug/vS6qHT5OMPkccbmZkYdzyPZr/G7Ua+HXGkMrRW7E04mfJlzOAbzoLWiMXxdvo7tEJ6/KErDse1UlrO245afS71M9HKWPrWpeIRjScpZUbthkfKW1bd2vYUj3F7dsGe7vjcJyV4QKcg/I7HtQf3fdJ3DxtEVYITMbYZbhOdhFGGB6PASQzDy7Rjp9a5l2uPFx/pvnyoaZHkG3/PWWlNJ+Bu1b3p1KzcEQ+2HGg54PGl7UI8vMAZKIctpPCPwtw6Rf3OTiCwKF37HfgdMaSS7AHLjLZ77qPNFcSdzdBxtaCB3vwSgIu5iG/A=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(36906005)(107886003)(70206006)(316002)(2906002)(7696005)(8676002)(9786002)(44832011)(36756003)(82310400003)(6636002)(6666004)(508600001)(70586007)(356005)(1076003)(8936002)(110136005)(7636003)(2616005)(186003)(5660300002)(336012)(4326008)(26005)(54906003)(47076005)(426003)(36860700001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 18:06:39.3066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af586e6a-b989-4537-728e-08d9971906d0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0021.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7851
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microchip's USB224x family of Hi-Speed USB 2.0 flash media card controllers
provides an ultra-fast interface between a USB host controller and flash
media cards.

Add dt-bindings documentation for Microchip's usb2244 Controller.
USB224x is a USB 2.0 compliant ultra fast USB 2.0 multi-format,
SD/MMC, and MS Flash Media Controllers.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
---
 .../devicetree/bindings/usb/microchip,usb2244.yaml | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb2244.yaml

diff --git a/Documentation/devicetree/bindings/usb/microchip,usb2244.yaml b/Documentation/devicetree/bindings/usb/microchip,usb2244.yaml
new file mode 100644
index 0000000..ecab0cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/microchip,usb2244.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/microchip,usb2244.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Bindings for the Microchip USB2244 Ultra Fast USB-SD Controller
+
+description:
+  Microchip’s USB224x is a USB 2.0 compliant, Hi-Speed bulk only mass
+  storage class peripheral controller intended for reading and writing
+  to popular flash media from the xDPicture Card™, Memory Stick® (MS),
+  Secure Digital (SD), and MultiMediaCard™ (MMC) families.
+
+  USB224x is a flash media card reader solution fully compliant with the
+  USB 2.0 specification
+
+maintainers:
+  - Piyush Mehta <piyush.mehta@xilinx.com>
+
+properties:
+  compatible:
+    const: microchip,usb2244
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      The phandle and specifier for the GPIO that controls the RESET line of
+      flash media controller.
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    usb {
+       compatible = "microchip,usb2244";
+       reset-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
+    };
-- 
2.7.4

