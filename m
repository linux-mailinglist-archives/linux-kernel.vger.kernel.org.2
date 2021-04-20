Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41113653EC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhDTIVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:21:38 -0400
Received: from mail-co1nam11on2069.outbound.protection.outlook.com ([40.107.220.69]:8417
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230397AbhDTIVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:21:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJhxK1el9jbQ/An8MozVXAHX1nPu8h5s26y3xN3hT6sWvhGzrKU6wvsIHoc+MfaiBJaqtqIX6yMaWPoFSaUYtASZ390JEwtwPFDIuNecscRLCLmxcfDSwBBl9HpHCcyQheAm/s4dF2oDXIajtlx6bsMmQokmSQr2oZfUm9LbxtOAe2yfp6jdAp7MGb2atqtvvfAH/Q30iHItFDACk5bagruReSUS4dPC6Mu9plOtFqUa7USogNoRGu7o4je/5VRhWKn3q4kO0fzM7TCfhS2VHQ+gxh2eA9tj49T9KDLVYmToMA6whIXxYedz0WWqWfY3yhO12fstubufn3pLNNHxiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FamtMgylmrp4kqZeQtKK+PufEtPsDNHTY7MNJw93WZU=;
 b=bxgrPZ/NghI6cVdoo22vJ3EZnyjk5wyKIq4KuMOcEV+Aen16wQnZg4EoN7yNwzPAZsPraWadmYAPcap61IHcjMcMmAMaRMdEThVw0gPLvP4vvaHIepBPyBQAQaWO7+N+NUz2Zy6gnNAbqRCgsyOJGEH5O9FKgjDZ3mVUVKeZp7n7Gnmi5I6te00Hl0aw+qk4bYtinfGgOH5E0tl2yHAT/D5M7XHbJc/Ym24UyH70AcFB11qsf7GOrLPZj3SZaxnjwP0Qqbw5k9/2P6lsWaol5EmwF/kcbyB3IT/qpGhdKRl7QpPNOBg+e8hp1BO3nnjjOwVqJAlABjJzNOVkJ0N5Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FamtMgylmrp4kqZeQtKK+PufEtPsDNHTY7MNJw93WZU=;
 b=amDiH4GeMfSFon9O0dcvDiVKsxkmCCOddXEdJemjoVaGOs9St3meRwhL38ryx3Rsd705CTBGjxWb0AoBV/ji8r+cphQyO0i+ItgFSgpukSQYtmakOYAbF79buVtTBK0ZWe53QYILDrfE3Iudmg5BHg4O6ONmrSCtGP8TbqHFvhs=
Received: from CY4PR08CA0046.namprd08.prod.outlook.com (2603:10b6:903:151::32)
 by SA2PR02MB7514.namprd02.prod.outlook.com (2603:10b6:806:135::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Tue, 20 Apr
 2021 08:20:46 +0000
Received: from CY1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:151:cafe::aa) by CY4PR08CA0046.outlook.office365.com
 (2603:10b6:903:151::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Tue, 20 Apr 2021 08:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT063.mail.protection.outlook.com (10.152.75.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.19 via Frontend Transport; Tue, 20 Apr 2021 08:20:46 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 20 Apr 2021 01:20:37 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 20 Apr 2021 01:20:37 -0700
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
        id 1lYlcZ-0007C5-Jo; Tue, 20 Apr 2021 01:20:36 -0700
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
Subject: [PATCH 4/5] misc: doc: Add binding doc for the zynqmp afi config driver
Date:   Tue, 20 Apr 2021 13:41:52 +0530
Message-ID: <20210420081153.17020-5-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210420081153.17020-1-nava.manne@xilinx.com>
References: <20210420081153.17020-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e27b8389-648a-4701-028a-08d903d532a0
X-MS-TrafficTypeDiagnostic: SA2PR02MB7514:
X-Microsoft-Antispam-PRVS: <SA2PR02MB7514DA0A407F29CC2472EA7AC2489@SA2PR02MB7514.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zLpXFccDsjwiHPRmo3PJoTKcY4vIq5Ukg3NgiNXT0kTvK/TZLexbDMh+ONOk66R1JSTay3OuXpadwIt++hgni3ut/mM/w3E785hD1BcsoSGOhzHQ1foY5cIa6nG19oYg8XhZ0DwWKhRzhTb7Yzpe+FaESvPfxCRnkWInrCLvK2WVFR8LGquDFhNXiFonmCHDzSP8zM4oot5Y4fnLKx066Ec8B6lAz1mWjqOUPCzp8qos+6jiYWXb2SqhE5EuDmOLeXQuz/dKRq4N4m5ML2RjKLCpyNplpd9r8yTJDeZD9QJCcCuWUkjLiGP0d3h8cpBFTEAAHO9rdYNWkEE/QZ9Gk1SiuQ+27WtBfmRJDmkwtzqmFmMDNjRnAgznd9zbBrus3Zt82T5hFUTMFFPK584H0jiZNKmeWeOhGFfRh9DZ+Ztr+qQLYIJMV98MkOs7jWtnXQ40xrh4mL+I7352bGEKqnk0y7RQRYBDzNmP+yADuOKXA9XnH4g9qjBjUtm8BAlLf3T+AmqrvTSqJYzYVNg/Jl203sbfgUbhIlyYen8AifnQSOVJgY1izL0QiWQeRFLDcxgnzwf8MBcsBsXamDXPIjY/KTk7nfBaNccclrN4/Qhej9O8EMm1GVaWCQAebVHpFKu4ZmSz8X60jAA+kTYExIkBfRGjhQ4Qv+qKv+LzLk5yPcrsWrMCWJ3HnjTyEnVyuqtizTDJGUoWE9oye/eIMcAkYG9NhXEJieT1BmN6MmJB9azP+cHLdnyoGEP9gDMEQE4ufq/HMG2hJlWA8QRniGPkNG3SSrE3zmlSrSl8iYwNQNPS03FG8q+O+TeCw/zV
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(36840700001)(46966006)(6666004)(36906005)(316002)(5660300002)(83380400001)(7696005)(966005)(336012)(110136005)(8936002)(921005)(9786002)(8676002)(478600001)(36756003)(82310400003)(2616005)(2906002)(426003)(26005)(356005)(186003)(47076005)(7636003)(70586007)(70206006)(6636002)(1076003)(82740400003)(36860700001)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 08:20:46.1270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e27b8389-648a-4701-028a-08d903d532a0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT063.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7514
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding document for the zynqmp afi
config driver.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 .../bindings/misc/xlnx,zynqmp-afi-fpga.yaml   | 136 ++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,zynqmp-afi-fpga.yaml

diff --git a/Documentation/devicetree/bindings/misc/xlnx,zynqmp-afi-fpga.yaml b/Documentation/devicetree/bindings/misc/xlnx,zynqmp-afi-fpga.yaml
new file mode 100644
index 000000000000..3ae22096b22a
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/xlnx,zynqmp-afi-fpga.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/xlnx,zynqmp-afi-fpga.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx ZynqMP AFI interface Manager.
+
+maintainers:
+  - Nava kishore Manne <nava.manne@xilinx.com>
+
+description: |
+  The Zynq UltraScale+ MPSoC Processing System core provides access from PL
+  masters to PS internal peripherals, and memory through AXI FIFO interface(AFI)
+  interfaces.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - xlnx,zynqmp-afi-fpga
+
+  config-afi:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Pairs of  <regid value >
+      The possible values of regid and values are
+      regid - Regids of the register to be written possible values
+        0- AFIFM0_RDCTRL
+        1- AFIFM0_WRCTRL
+        2- AFIFM1_RDCTRL
+        3- AFIFM1_WRCTRL
+        4- AFIFM2_RDCTRL
+        5- AFIFM2_WRCTRL
+        6- AFIFM3_RDCTRL
+        7- AFIFM3_WRCTRL
+        8- AFIFM4_RDCTRL
+        9- AFIFM4_WRCTRL
+        10- AFIFM5_RDCTRL
+        11- AFIFM5_WRCTRL
+        12- AFIFM6_RDCTRL
+        13- AFIFM6_WRCTRL
+        14- AFIFS
+        15- AFIFS_SS2
+      value - Array of values to be written.
+        for FM0_RDCTRL(0) the valid values-fabric width
+          2 - 32-bit
+          1 - 64-bit
+          0 - 128-bit
+        for FM0_WRCTRL(1) the valid values-fabric width
+          2 - 32-bit
+          1 - 64-bit
+          0 - 128-bit
+        for FM1_RDCTRL(2) the valid values-fabric width
+          2 - 32-bit
+          1 - 64-bit
+          0 - 128-bit
+        for FM1_WRCTRL(3) the valid values-fabric width
+          2 - 32-bit
+          1 - 64-bit
+          0 - 128-bit
+        for FM2_RDCTRL(4) the valid values-fabric width
+          2 - 32-bit
+          1 - 64-bit
+          0 - 128-bit
+        for FM2_WRCTRL(5) the valid values-fabric width
+          2 - 32-bit
+          1 - 64-bit
+          0 - 128-bit
+        for FM3_RDCTRL(6) the valid values-fabric width
+          2 - 32-bit
+          1 - 64-bit
+          0 - 128-bit
+        for FM3_WRCTRL(7) the valid values-fabric width
+          2 - 32-bit
+          1 - 64-bit
+          0 - 128-bit
+        for FM4_RDCTRL(8) the valid values-fabric width
+          2 - 32-bit
+          1 - 64-bit
+          0 - 128-bit
+        for FM4_WRCTRL(9) the valid values-fabric width
+          2 - 32-bit
+          1 - 64-bit
+          0 - 128-bit
+        for FM5_RDCTRL(10) the valid values-fabric width
+          2 - 32-bit
+          1 - 64-bit
+          0 - 128-bit
+        for FM5_WRCTRL(11) the valid values-fabric width
+          2 - 32-bit
+          1 - 64-bit
+          0 - 128-bit
+        for FM6_RDCTRL(12) the valid values-fabric width
+          2 - 32-bit
+          1 - 64-bit
+          0 - 128-bit
+        for FM6_WRCTRL(13) the valid values-fabric width
+          2 - 32-bit
+          1 - 64-bit
+          0 - 128-bit
+        for AFI_FA(14)
+          dw_ss1_sel      bits (11:10)
+          dw_ss0_sel      bits (9:8)
+            0x0 - 32-bit AXI data width
+            0x1 - 64-bit AXI data width
+            0x2 - 128-bit AXI data width
+            All other bits are 0 write ignored.
+
+        for AFI_FA(15)  selects for ss2AXI data width valid values
+          0x000 - 32-bit AXI data width
+          0x100 - 64-bit AXI data width
+          0x200 - 128-bit AXI data width
+    minItems: 1
+    maxItems: 15
+
+required:
+  - compatible
+  - config-afi
+
+additionalProperties: false
+
+examples:
+  - |
+    firmware {
+      zynqmp_firmware: zynqmp-firmware {
+        compatible = "xlnx,zynqmp-firmware";
+        method = "smc";
+        afi0: afi {
+          compatible = "xlnx,afi-fpga";
+          config-afi = <0 2>, <1 1>, <2 1>;
+        };
+      };
+    };
+
+...
-- 
2.18.0

