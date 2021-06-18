Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645363ACB2C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhFRMmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:42:00 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:62817 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbhFRMly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624019985; x=1655555985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=x8j3XS7e5BQGVmi1A6KneDVLcWPft9knQ19eSdgCyiM=;
  b=FF6Sze2xpiCMXTxQSosjBVYr1S06VYNsJdvWelg5O+ACwd2LZ0lXDzLM
   6k3UVmWS4IJsJH+sFvhlAPM95Gq1hJDDeAEq1fZrCIUIHA3OND9FY3P5b
   1QVAq9ChAup/cIQD2rutSWlARLKSaBgceRyUSvuyHyLVcvZNP49xGd5uz
   xgWKTLi9VHgSk8OuBzWrQ4RdsYpMl4tVZsiiuZrjmyeu1dAywcnxUbK3w
   tQz0aj6rJCC4BN4px2HyBhmHdHHFJ6Io6EXE4WJ3xffjRUPOBu/dZ605h
   eebrmIGUPo0o0yAbP0eKQojG1hRrb9/l+p7bPlW6BPX3ZnCS5HyedRZLe
   w==;
IronPort-SDR: LhwP5QXbH+ZjZqewTU1bXJTP3C+x5sRutSsALAiyowbcvZm67KiPf1WrpJDz26WB1V7mvPcrtw
 b+evy/djPmjfLfCVAaeoeDDBAHN6mRHNnGLujYrxZIUDmqikNbu2gCYJsyuEVeHIPGBRcE8cGU
 kR0gphWLtax/FIsniOmX4xDmuivt9utbzgPeWb0Tt2CHTQCxMGDPezPEhA1BFCMDf0mpmVKHte
 U+IwyVLkF0/rG8Jm/DzGu8hy9AHsE0Xj2jO/mwl1CYeZc1BSTXuqajYld+GqjzQKittPzIgOEg
 X3E=
X-IronPort-AV: E=Sophos;i="5.83,283,1616428800"; 
   d="scan'208";a="283779317"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2021 20:39:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ivc2AQN6yDhAZ/Odw1ZJ7+r2VuB0/qOZzaLGjnopNk5JBSPcNr/cBcqvRKYKtPFSDdThtFEEMEMFWId5g8+/lcwOK7wjrzO9uKG5oozbwSIbeUCqklr4kXeLvLaI6iFAKLiapVRbJwFDHNKvfl1Eyya64k9//rxFIEwl8e8Nfyt2BLaKF8RoTTU44R1Wn79c5TRX44oUyYhq9YY74y428YMPmgSRp5oRY+sILrssdXOzVcRwY0CuiQHE+sfkAXwrTAXx7LCzT01sxLhGndFeK7Bv0SVzdnX3z65B7Gc/GWxMtjwKGnA8A+OCp+e3K8F1Hfr2NuwbTiPX+Rk085Uj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClpfWhRSFYKp1nDVf7arBAxeYy4CtucQm4R9TO82ZIA=;
 b=ZTv+mtvErKxuMfz/ci4DITZk75CoLKvV86Nh5d0eRfp3zkcjupiZebIltFbWBOZ3iBznyHUQn7uGvT9jP2r3LnFEi57YHI58AVSGKkLfkHUuWeQGxogzPGBkbEIcvGlZfIoC6BvQy0ubs5iPJiK+aLb63wppzaFZ+pfO0/QxASY/Psn9efdTJIvO5RgT2bNsaERCrIziQJeaUTAWQKtbhIQoBUKMEg4BNu36ViyrFybQaGTSFwdR7ku0M0kuOLV64SzkHn/24r6+zjG590a1Ahnu88VQ9tFbLbf/VyZaBr3UjctDBk0eBdTOv6oSoF4J0m8H71FB0zE6849oRut98Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClpfWhRSFYKp1nDVf7arBAxeYy4CtucQm4R9TO82ZIA=;
 b=C5FdD0jhUqi49J2Yz4u08mowuBXPBg0BEvz4l4E9gVt3DJhPRCfN3OGY9SeDhLFvXVY+NnPLuyF1ckxvWlDsn3wSqkHZCgZEuSABNxLgx5hI6ODaPukbIuPNBo23vpbRaZx0rReN2XKhyP2Uq4OLFJpEdik9xT4mn1aIzIB4jPo=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7843.namprd04.prod.outlook.com (2603:10b6:5:35f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 12:39:44 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 12:39:44 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anup Patel <anup.patel@wdc.com>,
        Bin Meng <bmeng.cn@gmail.com>
Subject: [RFC PATCH v2 06/11] dt-bindings: interrupt-controller: Add ACLINT MSWI and SSWI bindings
Date:   Fri, 18 Jun 2021 18:08:46 +0530
Message-Id: <20210618123851.1344518-7-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618123851.1344518-1-anup.patel@wdc.com>
References: <20210618123851.1344518-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.171.164.186]
X-ClientProxiedBy: MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::11) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.171.164.186) by MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Fri, 18 Jun 2021 12:39:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09f124e8-6982-4aa2-95ca-08d93256267d
X-MS-TrafficTypeDiagnostic: CO6PR04MB7843:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB78433BF62AD8D87C07BE12B18D0D9@CO6PR04MB7843.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/MWuWzPYJccJ7obiyoPpeZwJvoPAM6ueqWfDAPXeE/dwfqEpqSWU3+VyZ6ygJvpiBNPFYveqmrAnlt2FEOk3F0TXjxLtwxXejGGQkwoPkEJpT9ToDT21AJpb1KG/HX16bXjDSkYnh2JgsVz9jf7BmdtR/W9/DSkORjXGQf18V54hMIWmdytcc9t789qmFp8Aq+Nh+vgmHmgF/6pfjnbfpbwjJNRBPZiO7KDzIOZqmVoR+gJdPoID8j/XLuBdsSwmwCYjwYPy7URFSVVzF4MJMNvhXytzpOScJtITQA/LB3oj48pzRpxEtdckCEUABB3oxQU/7l/OW3cPDzB1SCEzpMIpmgPtHTuMNNYXJOAAsKv4lce5v2/rmKf6dr8nEpt6b6kUldm5v+nrnF1HIWKLUXPhAb7UajTZsAhXFC2n/nQZialnOXkJb+MzG6XoNxtblUZSoXLoLjzYX2eYJKGk4TAoYqrwj5uY1qhhwqrBeDjjDFoNIvrVhB3HKi+yicFG3JGPeY8cNPk/c4kAdwz38ob8UoI0mUDkKteke2uFeAaO0VwF0pDknJ8lH7XsBFU8gIYuLNGpX+E7geDAGp47kiwsHqrI9Oj0BR0X/pqUavX11dxz2ieiGP81C5HYb2wAeDqqRVu0NSCUsAzYq1vALycJ4ip8zN+rS1J/h++Jx203odeMMoQRU4JL6gNzL6NbfVftsJ6x9wOFe45ieurOshoYr0rvcKWfo/fiAnWmFKMyEYu+ZCSN7p37BAVYFIEteg49Xj+HldorW7Ve6OLDV6X9ly4y+E4ig0POIhlYPjifrpg13OAqLiY/3c2fwccCyLtSqd1pnn+G0SXzXpbVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39850400004)(316002)(4326008)(16526019)(186003)(110136005)(54906003)(52116002)(26005)(55016002)(2616005)(956004)(2906002)(5660300002)(7416002)(478600001)(966005)(38100700002)(38350700002)(8676002)(66556008)(8886007)(44832011)(86362001)(8936002)(36756003)(1076003)(66476007)(66946007)(7696005)(473944003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z7au5WeEYcODJlopImJEAvqt3Ez2yBI+dHD8yTo2Nli1gzBwNTSP+BYZMRHo?=
 =?us-ascii?Q?VwOAJbVQHEJWMnqSASHN+R2r9P3UvCbe9IENFYdiMO+sfToVa2gkEpAgH+55?=
 =?us-ascii?Q?Cupv7B2YZoP25WdgYpS7kWVo8MBqle1fWsb+6joSomvI4ylQi9E+D+IWTd+U?=
 =?us-ascii?Q?A6FfCpoPOcQlf/I8Z2eBcHgi3hBs2gp951RiZvgcnrHkpD5Of2mHktq43hTu?=
 =?us-ascii?Q?S+h+iiOAvVLoHhA90s88jzAE5kpdYCO0BPXndBugVZxt4scxklvBZP5EcaNQ?=
 =?us-ascii?Q?cSx9ndypJPea1u9Vpf/xjj5Fnwv9/B/sVmTsQ8F/hHN62DFAsVGnrgsrQkXa?=
 =?us-ascii?Q?Lm/jtOZyGK4bTHzXPTPwuwUsqpfwdhyr0f2xr2Q75yPZ31udGtNKfb1acUYg?=
 =?us-ascii?Q?xpXuBTnYPzVfMTtsDylj+b0Mxd82O+bqKvsd2d41BGlE0WwRUVYMxmUtyRTE?=
 =?us-ascii?Q?qlNRXfIqYEPKGbq93C/iqdMPLQ8UJ0ZZwtUH2nL3JY88j5mv/l75TBVa5DvO?=
 =?us-ascii?Q?xxZ0HPZdCEZGxXTi8Loe9hzfpF47/MMNzs8xpC46EMxPDjVGemPMrlj/oTXo?=
 =?us-ascii?Q?g0yO0kGewarjF29E5euftJf0UIcZYT+1dVF05AB4Y03RuBk0HBqTnQ1bHA09?=
 =?us-ascii?Q?Ml87dODoLzzQE6qAJ1ZbWMbP+nePpl4sTh0jfzfUYviZzAs7AzBTlWZKBCqb?=
 =?us-ascii?Q?WVGtbYlSfIZoXwvdQhhQk+90GTohU5TOQFmR0nOgHdmij/c0mo5pzHe4BTw9?=
 =?us-ascii?Q?cnhVDJBp0542aldJEXcFLkAA9HELplBYWQAMwCXoSy3gGw5wIR5iAy9gkV+c?=
 =?us-ascii?Q?0AL6RGUlFigH1528N1i3zrhlzrH0VeiQyrgtRbY4U6JBSAN1yW5VfMbj0nrV?=
 =?us-ascii?Q?ky3UzHnxd79zFxmUEPxl+NnPa9OGVLjcbpDZPUaV0VlrcYQ8A5ZpYcEcWzLN?=
 =?us-ascii?Q?Wy2pkbFhQfoqZ0D8BcycAnUlX9kQFeoF95q5Z4niIwVNaYb6Eor0UWQdlgA7?=
 =?us-ascii?Q?ilC0s7uXL9HnxWtht8lLsKETLPqLFE2jMWY6J635AfDJYsDsjbKU6PGVpkE0?=
 =?us-ascii?Q?teaorHqAuAbY/OJUxlStcZpGRecDLWzf3EwrzceD7N8h7TBwYGLwPBBZBokj?=
 =?us-ascii?Q?v5isPtO2mJdkwIr4sRBs7eGXVG+jom0LuKjne/8S3A8aU2nxVq0b+xlyYzYz?=
 =?us-ascii?Q?af1S1bC3wBZetbeiyqD2WwSx2IkWy9YKi+XMYmnxSxQmmHhyzevh05MBL5q8?=
 =?us-ascii?Q?qgZ7P7fW57iZrlBxlxQYQ1u1eV6Z77XCELwUmwccYdylqUiXnczZL8I0nmyT?=
 =?us-ascii?Q?p6yEPI0EnqgKZk69t3pqwzTS?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f124e8-6982-4aa2-95ca-08d93256267d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 12:39:44.5051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +beQlTpK112/5GUJYTN3hZbH++RnzmMbKH2PA0GGzQNqiL+C7EM+4Xkz5c0XMQEg7PyIJ6HOXWQYWnobf14x1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7843
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add DT bindings documentation for the ACLINT MSWI and SSWI
devices found on RISC-V SOCs.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
 .../riscv,aclint-swi.yaml                     | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
new file mode 100644
index 000000000000..b74025542866
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/riscv,aclint-swi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V ACLINT Software Interrupt Devices
+
+maintainers:
+  - Anup Patel <anup.patel@wdc.com>
+
+description:
+  RISC-V SOCs include an implementation of the M-level software interrupt
+  (MSWI) device and the S-level software interrupt (SSWI) device defined
+  in the RISC-V Advanced Core Local Interruptor (ACLINT) specification.
+
+  The ACLINT MSWI and SSWI devices are documented in the RISC-V ACLINT
+  specification located at
+  https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc.
+
+  The ACLINT MSWI and SSWI devices directly connect to the M-level and
+  S-level software interrupt lines of various HARTs (or CPUs) respectively
+  so the RISC-V per-HART (or per-CPU) local interrupt controller is the
+  parent interrupt controller for the ACLINT MSWI and SSWI devices.
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - riscv,aclint-mswi
+          - riscv,aclint-sswi
+
+    description:
+      Should be "<vendor>,<chip>-aclint-mswi" and "riscv,aclint-mswi" OR
+      "<vendor>,<chip>-aclint-sswi" and "riscv,aclint-sswi".
+
+  reg:
+    maxItems: 1
+
+  "#interrupt-cells":
+    const: 0
+
+  interrupts-extended:
+    minItems: 1
+
+  interrupt-controller: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts-extended
+  - interrupt-controller
+  - "#interrupt-cells"
+
+examples:
+  - |
+    // Example 1 (RISC-V MSWI device used by Linux RISC-V NoMMU kernel):
+
+    interrupt-controller@2000000 {
+      compatible = "riscv,aclint-mswi";
+      interrupts-extended = <&cpu1intc 3 &cpu2intc 3 &cpu3intc 3 &cpu4intc 3>;
+      reg = <0x2000000 0x4000>;
+      interrupt-controller;
+      #interrupt-cells = <0>;
+    };
+
+  - |
+    // Example 2 (RISC-V SSWI device used by Linux RISC-V MMU kernel):
+
+    interrupt-controller@2100000 {
+      compatible = "riscv,aclint-sswi";
+      interrupts-extended = <&cpu1intc 1 &cpu2intc 1 &cpu3intc 1 &cpu4intc 1>;
+      reg = <0x2100000 0x4000>;
+      interrupt-controller;
+      #interrupt-cells = <0>;
+    };
+...
-- 
2.25.1

