Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36AA458952
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 07:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhKVGcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 01:32:04 -0500
Received: from mail-bn8nam11on2066.outbound.protection.outlook.com ([40.107.236.66]:63524
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232591AbhKVGcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 01:32:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMb0c2YdF13YMSgohykCdaYFGVdf4D0O4THZzXuelvOsG178ym4UiA6mGkEcsB00q85BJZv6p8h4ytNbHTBNZ+3+wYKBi2bimRBB3uH915nQ1VFMoQN21jMJC5a1tqO/WyJtn+8LaqY9vdxo04zI3iBvEFHAJII+7hilGYn4FGmsEpk8VEz4vrW3saCmtVrnLFmJFlmNdFkyZa15FwZWqvrg5KslVdVMA7Ip9q78VHcTAFf+RbYsmOm6VxGkaVQ6XrY+Ig1luB42XbMcXOyQ3m1pBL5acnDJjKfadjG82VX6EdxCacppvVwRY4Aq5lfQbKQ9lLWZaj4laatTP5RFyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MnOfSy3F/bEnR8vD0YqgyM1rk/8vLVjYmxTClK4Qjs=;
 b=ZrjTTsi0o8cUKdUgYrl4oqd0CpAiCBZLF+hiHgDqanUyR/ptMKAHMpqHgUvvS4y1ZcYKaO/1DibmuxePisOVUNLDfPBR/2Uw7SOppDsGKDojMNVI5QRWggAVbHevgV/WvzL90lKg05/1R3n9xY8edEy96HANE6B3nzYzWhhvLPovP1V6098pjnAVsgUjzlC/ra/A6ErJasua5LzjGRB0nkFIkgcOyyfMiYX78CPNjj0QT9O6QAs8QtOcT9zQXw7fvnWtiz+dru8eB7VOanQ6Vlo05qQlmdwbdOb1o4aXR5JUDHJU6Q2BjSBgjNbqp9VenALAmpBet+U2uJboCPC4dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MnOfSy3F/bEnR8vD0YqgyM1rk/8vLVjYmxTClK4Qjs=;
 b=I5stB6cFRd+zTiHo7J6eeWsncHxuj3h3d+JH9IbT2NNR3iRjV89yHaZ2UhhMedR0mlZp8UO9CPLtfFl4xgX6f8AqSqUwO3OtxNuIwV0YtGGnNTyarhsic2spti9oRMj//XucsZhYMlB7hi2Td4c/gq+Mp+Y5ypJYFRXN09Yua0s=
Received: from DM6PR08CA0060.namprd08.prod.outlook.com (2603:10b6:5:1e0::34)
 by DM6PR02MB4155.namprd02.prod.outlook.com (2603:10b6:5:97::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Mon, 22 Nov
 2021 06:28:54 +0000
Received: from DM3NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::59) by DM6PR08CA0060.outlook.office365.com
 (2603:10b6:5:1e0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Mon, 22 Nov 2021 06:28:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT012.mail.protection.outlook.com (10.13.5.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Mon, 22 Nov 2021 06:28:54 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 21 Nov 2021 22:28:53 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 21 Nov 2021 22:28:53 -0800
Envelope-to: git@xilinx.com,
 gregkh@linuxfoundation.org,
 robh+dt@kernel.org,
 mka@chromium.org,
 ravisadineni@chromium.org,
 stern@rowland.harvard.edu,
 alcooperx@gmail.com,
 linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.35] (port=53536 helo=xhdsaipava40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1mp2ou-0001Mv-MQ; Sun, 21 Nov 2021 22:28:53 -0800
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mka@chromium.org>, <ravisadineni@chromium.org>,
        <stern@rowland.harvard.edu>, <alcooperx@gmail.com>,
        <michal.simek@xilinx.com>
CC:     <piyush.mehta@xilinx.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, <sgoud@xilinx.com>
Subject: [PATCH V2 1/2] dt-bindings: usb: misc: Add binding for Microchip usb2244 Controller
Date:   Mon, 22 Nov 2021 11:58:33 +0530
Message-ID: <20211122062834.1812005-2-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211122062834.1812005-1-piyush.mehta@xilinx.com>
References: <20211122062834.1812005-1-piyush.mehta@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e7193f7-ee99-4d08-453c-08d9ad815b2d
X-MS-TrafficTypeDiagnostic: DM6PR02MB4155:
X-Microsoft-Antispam-PRVS: <DM6PR02MB415599E00ABAB6A61FE56589D49F9@DM6PR02MB4155.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ET1Wv2RgbNsPPyUDOMhqvJOa8PHMgSJjlxRfhzm49jH0FI9Ko3d2YLnZHS+aKzQYdcyA2vqfY0HravbnbUYWj4K3AuMF8goUQSk5BLfhXr5SyMg4Sk1pQyw8b1KxqL00VyiJSD8t24D8k6tfBH1iZMOeX17EI6M8MW1l2BBbLrUqMiS9S3VNm3Td+pgKjJS1VJExjzVVHMXS/JqMhZo1C5kSawZPnL5Hnz8t15+LsUEUe3gror65A9cSAMoazKmXi41noRGi06FD2HB60Ea50l4P0YJ+4il+PvQjOGkxLQbGrD4pZ11XiqmhDsf+WANW+4n2yxqOO9RzD+ZdFpuRsEfjcsNjvv+FdZxRkYVIbIRFNjLL8TJJuJDEax/ts2mrbmi7vka791Mz4QcB7l46L88wGBJ+IcRoppI+aGBdDq/8HF9oOiBIECRFVAFEhKkHk3c66YUmRJrxKpXK2gS+BHuc8OFALm6Kx032lXbskFZMZ3NOFzMuSLGb4OHGEsMaK3CH61zNnfNmrtWMRj5GeJzhOdH1W2aIWBQTY1i4Er3x24nlawkHXWKTnBWQ0vKU9LhihJNmmvrzI8Ax81HBmVUGdGBhIZJS/9PwwBu6XUOwfZFtp0SEUGAJ7MxoNvnlSFXZnr4j2JxEYQcAD6JvLwxvKbdcC2fCK5QTKU1mEfJLvyPCotiiR7l9sBWH19n0tHQB9uKRN1d1A4TCM/BW4XtpCS5Al6nJquRLrI2PL1WEvL3CI2RAHHarwlcAj2zGlVpCxaaUfeIOb5Lb1T2N0EKweR0nQEuppBqDaWn9eBU6/J28kGKtF6O3sBJKRaPuKE3GxJZfTzP52Vl1pKcvjEqpu/eWgxOXv9tDyxtQauI=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(6666004)(26005)(2906002)(107886003)(83380400001)(6636002)(54906003)(7696005)(36756003)(186003)(7636003)(82310400003)(8936002)(44832011)(36860700001)(2616005)(70206006)(8676002)(110136005)(508600001)(70586007)(4326008)(1076003)(426003)(336012)(36906005)(966005)(47076005)(5660300002)(356005)(9786002)(316002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 06:28:54.0806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7193f7-ee99-4d08-453c-08d9ad815b2d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT012.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4155
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
Changes for V2:
- Update reset polarity, make reset ACTIVE LOW in the dt-binding document.
- Added usbsd node under the usb controller (usb0) node.
- Remove Warning: decoded text below may be mangled, UTF-8 assumed.

Review comments:
Link: https://lore.kernel.org/lkml/CAL_JsqKu6vr3iCz1G7MtK6gyqAvn4s4mpuLOwPzJDEmyZeROig@mail.gmail.com/
---
 .../devicetree/bindings/usb/microchip,usb2244.yaml | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,usb2244.yaml

diff --git a/Documentation/devicetree/bindings/usb/microchip,usb2244.yaml b/Documentation/devicetree/bindings/usb/microchip,usb2244.yaml
new file mode 100644
index 0000000..1854313
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/microchip,usb2244.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/microchip,usb2244.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Bindings for the Microchip USB2244 Ultra Fast USB-SD Controller
+
+description:
+  Microchip USB224x is a USB 2.0 compliant, Hi-Speed bulk only mass
+  storage class peripheral controller intended for reading and writing
+  to popular flash media from the xDPicture Card, Memory Stick (MS),
+  Secure Digital (SD), and MultiMediaCard (MMC) families.
+
+  USB224x is a flash media card reader solution fully compliant with the
+  USB 2.0 specification.
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
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    usb0 {
+        usbsd {
+            compatible = "microchip,usb2244";
+            reset-gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
+        };
+    };
+
+...
-- 
2.7.4

