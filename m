Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092B53653E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhDTIVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:21:11 -0400
Received: from mail-mw2nam08on2052.outbound.protection.outlook.com ([40.107.101.52]:16353
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229551AbhDTIVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:21:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXT29/+xZztNfo4E5+Dy1KNKAh2QlVY3tNWple6b858eoEd3O1EQklCr94/8MsZY+46E3dTNQb/v0Qh4K3GQyo9EbZS2O77/Wh/ja58UnUWgkUgKZpHn+DizG4kP3SX6qOpubn9DQReT7Azif7ZZFya/dWkpYr+rSIuf0ZSn2JYLExJsi2rvSeDItHer1w9eapLT6MUDlKb4HhdAyw/0IcV4Z60KQ2KQWTkTMccvSQwEiFxuBp928JJORnRbSYVnqpjeCkBMrbFHqypLZbZAh+7vGSBiOVpeklnrmveZqPy09/N/igFrfmi+R4U72nTvwMVZTzOxnRML9n+uV6TJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhW0sO0t14m4GQHMLPmz+t3rSzxBugg6s/CECpOj2fk=;
 b=FNuJ6ZobJYQ1IijjBMK2De2W+ZcwI6xAXyZVhyTvoECjetTCkiz3MMMshyjcr3EU4aLE0L+Gvo4WTRlcXyR5BTWFgFr5zcSiTzn8FgzNohlG8enW9zOAqjJyrwyNM13jcEjzhV9eKIxZGGe8xfYOSEDq2wuI8WTqkEBkceY8UPUQKWbN3rbS63ozp27ss5azTN67T4S6eYyOWoulNGoDiIlr7iSgIjs0XvKCB/yifvPfhjIPhr2aiPyrtIh4TKcnYgiqaoLzXXWjzMhrJWp7WMJb4fvzsFzsG1/EOXkrNQWFO2yypdA6NKyh+KQXAN4yMNnULB0hh0njP29qzW2ZOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhW0sO0t14m4GQHMLPmz+t3rSzxBugg6s/CECpOj2fk=;
 b=V2zZMdTqo1cxa+eDO73kIvltneSescFw8olyxvJS9Efx+b7AtQOH+Pf0i1YwVqKdLVXFljeqH4LAvEuSe0k8/zfgDKBWVMaR0m4Qc7Dln6j6adyWlwNrqLV501wesN0SpNtu1QrUoFNis1dXd69XS0NOp4X7A0RnvTE273qO3P0=
Received: from CY4PR18CA0051.namprd18.prod.outlook.com (2603:10b6:903:13f::13)
 by PH0PR02MB7141.namprd02.prod.outlook.com (2603:10b6:510:1a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 08:20:31 +0000
Received: from CY1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:13f:cafe::f1) by CY4PR18CA0051.outlook.office365.com
 (2603:10b6:903:13f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Tue, 20 Apr 2021 08:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT033.mail.protection.outlook.com (10.152.75.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.19 via Frontend Transport; Tue, 20 Apr 2021 08:20:30 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 20 Apr 2021 01:20:24 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 20 Apr 2021 01:20:24 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=45276 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lYlcM-0007C5-TY; Tue, 20 Apr 2021 01:20:23 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <nava.manne@xilinx.com>, <rajan.vaja@xilinx.com>,
        <jolly.shah@xilinx.com>, <tejas.patel@xilinx.com>,
        <amit.sunil.dhamne@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>,
        <git@xilinx.com>
Subject: [PATCH 1/5] misc: doc: Add binding doc for the afi config driver
Date:   Tue, 20 Apr 2021 13:41:49 +0530
Message-ID: <20210420081153.17020-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210420081153.17020-1-nava.manne@xilinx.com>
References: <20210420081153.17020-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fddfdb8-f280-4cae-b601-08d903d52985
X-MS-TrafficTypeDiagnostic: PH0PR02MB7141:
X-Microsoft-Antispam-PRVS: <PH0PR02MB7141D4031CEC0BB11F869724C2489@PH0PR02MB7141.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xwCH0icqTOxxH9BxGzvUN6LDBJHdeJAyT6m9sXyN2l/gp4629rmoDNsuTOU0gs4k0buPL5pPCExPflxZW0sKR0QI2aXjBVllAt4SVpicSijDBalxMRqHT4YDWxY64O6Od86Bg9t6TS7vS03CVVS6Ab4UWNPtCW4/vNbjct4B/bzCP/s5135ErPc2jCcHPw+XnO/5lWLeRAtNuHENtaj1y9XSqzkqq3eJ0YDEdzZ9Y6J1IgS8dq50HMTysh45UnnCorBDXz9xdqlZ54JzwJs812PTelNbbfpcN5X0a9iny7JlZq2RU8aH0MVHJVmrZ8+sQgjOF266qIXL9z/9u0HRRe6Dz4iw/fTt1rdrbgLvmWV57pPcf3F0Ukz6z8+1c90M1wNBoF48/jPcS2g0GOI0om06pnamhmG8AqyXkOLJQRxxywJSZFgZvAgX+D/KrExefYzY+eb+SLwVtXH0oHZSOpfd8aIv0m1ramastAAst8fo0ip9GqGdsqjjOA68woVijp3SMwVVPeUmXZYSm0k9vtfMZSbGlC1G8qVhJsSinGnpHAty69r6X+SdJTc13GKOQNmda/7Pu+w4MNU29FXRy9C4LVIeM0H/uCon0XKpFqq9wn1MHZ1GE6iOkbPTuS3STF9p9P3QhUW586Oc5jIL806ih3+bgJZ4vAR7rNwOf2QlguwH3WgfI+NxxE9Edl0GcN4N1U2KeO95FDERu+UG8Z/1Fhzj65/WZ2j0ljAtwJs8AtSYh8Knw8tu0opvIcxVJZmJKBiSvW5mm+YJfezoHeVUBybtKTgdV+uNit2sBczqkf8QE+7iUAqaMtQ58YI/G6lDJlWB1fcWKRhMXsnsrA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966006)(36840700001)(82310400003)(5660300002)(26005)(2906002)(36756003)(316002)(356005)(6666004)(186003)(83380400001)(8676002)(110136005)(966005)(9786002)(921005)(70206006)(36860700001)(7636003)(47076005)(7696005)(6636002)(70586007)(336012)(478600001)(8936002)(1076003)(2616005)(426003)(82740400003)(36906005)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 08:20:30.8562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fddfdb8-f280-4cae-b601-08d903d52985
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT033.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7141
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding document for the afi config
driver.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 .../bindings/misc/xlnx,zynq-afi-fpga.yaml     | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,zynq-afi-fpga.yaml

diff --git a/Documentation/devicetree/bindings/misc/xlnx,zynq-afi-fpga.yaml b/Documentation/devicetree/bindings/misc/xlnx,zynq-afi-fpga.yaml
new file mode 100644
index 000000000000..9c20a192d6a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/xlnx,zynq-afi-fpga.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/xlnx,zynq-afi-fpga.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Zynq AFI interface Manager.
+
+maintainers:
+  - Nava kishore Manne <nava.manne@xilinx.com>
+
+description: |
+  The Zynq Processing System core provides access from PL masters to PS
+  internal peripherals, and memory through AXI FIFO interface(AFI)
+  interfaces.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - xlnx,zynq-afi-fpga
+  reg:
+    maxItems: 1
+
+  xlnx,afi-buswidth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+            Size of the afi bus width.
+            0 - 64-bit AXI data width.
+            1 - 32-bit AXI data width.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - xlnx,afi-buswidth
+
+additionalProperties: false
+
+examples:
+  - |
+    afi0: afi@f8008000 {
+        compatible = "xlnx,zynq-afi-fpga";
+        reg = <0xf8008000 0x1000>;
+        xlnx,afi-buswidth = <1>;
+    };
+...
-- 
2.18.0

