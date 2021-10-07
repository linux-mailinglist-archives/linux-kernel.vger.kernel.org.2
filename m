Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894A642533C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241533AbhJGMja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:39:30 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:51014 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241500AbhJGMjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633610240; x=1665146240;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=H1p7+JG6FND0OTBgXFibcwJ3DtV+jJ9ZbzBXmYkDEMY=;
  b=DK/aLosryBDu//KUGw8y8f6P8oeKW16uhSzGRNQdCbUbwtrFkfil/MF/
   8j1509zYoK4ikR74RagbkK1pt7sr14uCGv7uSo1k4IvTji+O0IaH0+ye1
   +QPsN7E0Nijz9fiSJU2VIuTS+wDP45MUn4Jt4aGNA+DHaphrNECEdXmsD
   5Ip3xf/zjQ0NlqgOfgJq/85jlykFR0hXgcd7gsRs7j4TvQj3lPvdIOur5
   tqkrOiqFWc298ea1b/V/VMmn0cbZQUP9tWw7UPMxzWjI9pMEjP6vPciNh
   WeQqGaE3U/KFUbBREFDbJw0UPHafwQBOFmXDZNUdPgg3sQPlYyFIXEdcw
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,354,1624291200"; 
   d="scan'208";a="186926249"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2021 20:37:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpDWHpJd+qpm07EcpUCYszup3DWltRwUsXMFRADWmetSQj1COyx1WRIg1kORYTBMW3VjytJjAEU2gbWX7UDo0ANyonUdUW3VDqarc5IQa84MGWjNjTJvimb3BCo0RjWv2QhAyKi4cSmGQWJai7QWMeTXLqEc2FdxqnFM1jPmT0hybdcsxmDUuYKLoA5kMmDI63OsEqnG0eFwg7QonuMf2PA1QPM4PxX+G4ySb0PzxwrQXDpwyWu+PAdkWHjMKhfbrm+qJ7ZcsnsHsb7XH91F9q9fCD8RzL6fugCyHfCdrRwiGUKFoakDWLMt6clVyn140JPBBIMvYoeKejhkP4w5Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEuoI7/T6g1PxgVda2pudgr8X17JMCGySnafXuZUo10=;
 b=NziLMtX61Tvoy0K1xT42sN39lZT0iZTIXx4MZRxiImHN99rZXjH8hN/qwfYXXn3QIbjePxUdrUS92wdOfhwMbAaPUwkW1NV7eYuBXgRVJxfG9teyovPwahYhdqRc7SkQsODbubuUBw4kFZYx5CVkW4Gbq4oosDryz5SfRfspZqaaFVq9bvLoEZm1bP9IlGD+aN0wN5+KUSI2oAk9UmtcLoxeUuSTDnSXKwatHJA7PYho8YxL/SuQgx7IgHfEVd2fSl/2ByeC+VF98xHEZuaWxVIFtdda2pIKK+c64ZwuW4FzHxKSpfSaz8kIlODbrnfSGTyvzSvpDIiktEkD9j+5qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEuoI7/T6g1PxgVda2pudgr8X17JMCGySnafXuZUo10=;
 b=LqE2+sto26JTUKLqRNn+FMUsil9YPmxpAoIT66qxSo8IpduZPNVA9WDD2X91FDvSwTitASUz6dFIe4yLCatAyhZbYigcOGQG2Qs0wMdQW8stnidLnw+AY5mqXEOJ8IGuRgnXgAasKsniKbdNKaX8UhGVXeTiw5T3gwLJq5TvpIw=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7777.namprd04.prod.outlook.com (2603:10b6:5:354::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 12:37:18 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 12:37:18 +0000
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
Subject: [RFC PATCH v4 05/10] dt-bindings: interrupt-controller: Add ACLINT MSWI and SSWI bindings
Date:   Thu,  7 Oct 2021 18:06:27 +0530
Message-Id: <20211007123632.697666-6-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007123632.697666-1-anup.patel@wdc.com>
References: <20211007123632.697666-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::31) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (171.61.64.222) by MAXPR0101CA0045.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 12:37:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6407e6d3-c664-40c1-90ef-08d9898f3330
X-MS-TrafficTypeDiagnostic: CO6PR04MB7777:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7777C4201BC7E6E2110A5E948DB19@CO6PR04MB7777.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zvj73z+xou3lHFTFJfYZJsRrHv0ZAaGKqh9WiNrLsKvseiiiMn85IS0ttJVIBBQ2ei0z0LIZLdL0g+wDNxzZCIzCqe4rUPcK3l7jadKRl72FcZu40M+s4Z/EBI2UogYfTjmNGVrI1zx6OvQfKI5Rwyd4BCE1fOG7SUk4QgRk2HnepFMdWtGqkQHWPJGrS4E5sg3elSn9AJkGt9/nnC+PAR1DZDsxGI8o8TRxNw9C/PtrFvJ67psMygNGOl8Or7c8YbtfLTiduZl+hfv4bKbHEBxExZCodfe490+d9BzYKn9gRz+m5veIRKOurs+cQWr4zsyShXM1L1C+ionHkbpz9lcy4A5WkIVirIeccIb1m0v5MgGNXCS/wWvz3JmQwO5ejbtOOwNnlWBHzCNKkh5FMVC/j4KTAxtMDABiFrj9Z7vXvDLOCiSXN+a/x6aTc9p1m+WdxlrOAX2Xj86X+XIUDcNd1S56NuR3cby55ebXz1niu051ssB05Swl8TxHhQD3olD5enBfv9j1InMgER6KHA35S5Kg/XlfIk+zU1OocykEhAsPDTxSK/0IzMiTtmpwCHNmwqfyA5HWK6E8y9jGuhqg0RIVtBruZn3pqTBRJx0Q2RhiKEXRc3TEanmkrucpRy5g6cxo83c1pvVSjszV16DvjT4rt99SKJSmWgS5jGOb6mrg6jky0ZBrAcsZu78U7yVDCLx86L1eA3PYXzDcxI9X1+lLriWIcOC9e/wyQpZVZG4PthNiCMTnbkE0RkKSD472f+oPDSp6nSMU/mMtCOBRqiwHTjRTVRIfQo2YqXRK8UJ6EgedLut0/vhfMi6r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(5660300002)(52116002)(1076003)(316002)(110136005)(8936002)(7696005)(2906002)(38100700002)(38350700002)(55016002)(508600001)(7416002)(86362001)(966005)(66556008)(66476007)(36756003)(4326008)(66946007)(8676002)(26005)(6666004)(8886007)(186003)(2616005)(956004)(44832011)(473944003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4nCTDqACoDUW+YGUyaZZ18/fNC3kmURcBrIB//8JK1tsfTiUhtzXb5guj/b1?=
 =?us-ascii?Q?ksYh+VtL/i4esyUZW/6uv6C0o/7ZgQH3jQ/twFMBRClbG67c9aKJjmMPfGsn?=
 =?us-ascii?Q?8yp3x8rSGTM2E8TUV8EF4BJGDzHi7msiW2utFaongjWMn9EXT6tvlBZ0viAb?=
 =?us-ascii?Q?HZJpGVbaLs8bgPJcTdBfbn7AFRewu9uwIqSg9r4/iu+4FkMjbxr6ULuSbiD7?=
 =?us-ascii?Q?RgtmdhJgIZUjdOjEGev+YSsaC1Ra8L2aNLJQWENE6D7hewrUGgiLRsAjjK5y?=
 =?us-ascii?Q?sJ7sEj3bbYxHCnAPA/+eKh1rLY87tMdOV/rW1r/TbO23xDTJ1clj4SfErWWl?=
 =?us-ascii?Q?u1JwB98C236AnXGrYlcS6mKOhglNciKsGr99WZG7nBtAU6qdvED55toVuH4M?=
 =?us-ascii?Q?Gx0MBTQhsyhcuSFwZZ/GZTCpErZ7NK/5zBMdnAcR2HIt8TnNHfcjooaw+Ta5?=
 =?us-ascii?Q?4XYhxKIphWOw95ftkOS0B97qqi12cJxc+5ACsZoFIaC4aRSDAYthm/79N0hF?=
 =?us-ascii?Q?RrL0gCEsDa6Z36GCghVzOHmvncTfk14eIWRfLdeaxsZ55iAbA7hT+670pI4V?=
 =?us-ascii?Q?wMSx+wr1WFG5xt4rQZJoS8wIoYVZRgKisH6SfgNANX9c9tNQs3/cImeUagvM?=
 =?us-ascii?Q?o2ttV0AT49LCToTqkSxz65/skPpNoK39Xvjve1aKBZnCHQ6HwDqdNYtgE2w2?=
 =?us-ascii?Q?YQSI1KMlT2JCP9slVLHP4FLUxTyjnIK3iCCyU/23BzXMgjNMM2a80Gm+oNvB?=
 =?us-ascii?Q?zFPcV8+QToNdZ/f1bc+gR0pg1G0JI9a/qioMtJQQ91WKMcLELgxZJEfkI9io?=
 =?us-ascii?Q?nhKZVZIdKYOstIojYb6ubr1Htf8l2cETuyFlNYZmP9tUGYUsu2JRMMlLL57S?=
 =?us-ascii?Q?RIaRPig+C+w6fsZvxoc4ESAUyhc2Gxb3bWeNC5arMoy0vql1Hdnt6wTVyv4U?=
 =?us-ascii?Q?RbtuZdRAjRR2wau4jgm/NZhYa06s/b86k68f4CwnbZSWmCWGeZ+VY2fxEagK?=
 =?us-ascii?Q?PNC+TAasJSUsz9KT3eKeEVr1JP8xq4Rzz+6SpaNmRat+4saKq8YmFUSFIWnH?=
 =?us-ascii?Q?3sCCNdf/a1S+/zMwwctdfVcJm6GWzZSBFcyF46BJyICnnbfGhXrvWorVpEVb?=
 =?us-ascii?Q?hksprYLnSDNuTboBmKjE3IBqKQ3uYzwCaLJFa71aiyO/vi5o0DpLDc37WThd?=
 =?us-ascii?Q?JJdz1esbJ2qqpiWVhHEzZ6+2nBhAIGR0XIjtThV9gcWurAXJH8EwLfnj1txr?=
 =?us-ascii?Q?Zl4aAfYxtEAOUikrc9TgOO3BsmsZUDbv+OqGVy6SIVlIq+3bxhrvL8ptP/IT?=
 =?us-ascii?Q?15ONsDu09Ri6X/m2N6t+kcuK?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6407e6d3-c664-40c1-90ef-08d9898f3330
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 12:37:18.2721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUKZJi0hS7ZxsWulxy2Z2nqNqL1ULCjmLrsYGmuTpVB1zWFI/YspCF9SW7nwlIaGq78RfrC7x95FakZ31BVxAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7777
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add DT bindings documentation for the ACLINT MSWI and SSWI
devices found on RISC-V SOCs.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
 .../riscv,aclint-swi.yaml                     | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
new file mode 100644
index 000000000000..f034c18f46bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
@@ -0,0 +1,97 @@
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
+    oneOf:
+      - items:
+          - enum:
+            - sifive,fu540-c000-aclint-mswi
+          - const: riscv,aclint-mswi
+
+      - items:
+          - enum:
+            - vendor,chip-aclint-sswi
+          - const: riscv,aclint-sswi
+
+    description:
+      For ACLINT MSWI devices, it should be "<vendor>,<chip>-aclint-mswi"
+      and "riscv,aclint-mswi".
+      For ACLINT SSWI devices, it should be "<vendor>,<chip>-aclint-sswi"
+      and "riscv,aclint-sswi".
+
+  reg:
+    maxItems: 1
+
+  "#interrupt-cells":
+    const: 0
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 4095
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
+      compatible = "sifive,fu540-c000-aclint-mswi", "riscv,aclint-mswi";
+      interrupts-extended = <&cpu1intc 3>,
+                            <&cpu2intc 3>,
+                            <&cpu3intc 3>,
+                            <&cpu4intc 3>;
+      reg = <0x2000000 0x4000>;
+      interrupt-controller;
+      #interrupt-cells = <0>;
+    };
+
+  - |
+    // Example 2 (RISC-V SSWI device used by Linux RISC-V MMU kernel):
+
+    interrupt-controller@2f00000 {
+      compatible = "vendor,chip-aclint-sswi", "riscv,aclint-sswi";
+      interrupts-extended = <&cpu1intc 1>,
+                            <&cpu2intc 1>,
+                            <&cpu3intc 1>,
+                            <&cpu4intc 1>;
+      reg = <0x2f00000 0x4000>;
+      interrupt-controller;
+      #interrupt-cells = <0>;
+    };
+...
-- 
2.25.1

