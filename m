Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD2C3FB05E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 06:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhH3ETO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 00:19:14 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:29589 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhH3ETM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 00:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630297100; x=1661833100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=M+d6WuhqdtGbJNlIOlqoTJqcoUdAtvCI2JyYrvh6f0Q=;
  b=Ga90qmsKOHe6SeCcpwjamyVvisS/n0/YB/Z//CDZPjvxdwBeT2mBb7qU
   R+/q/K2a3G/GHRkieq5asRNrbXyRcMlt9Ru+Um2RUC2kf7RNnpE6//N9m
   8KDEmbUKzpZ7cgFELVjeiMGIc7teJm6vKm1vB39Cl182on2Y8NOK2xVsi
   SAskVxX6IH12fpwNxFuk6SHkgbcqArTqTM6p4nado3zBKHLWHIGdyQfGl
   DM5rfgFOkuLtcRAswNbhWv9GD3rFBnwa8eNqvXpCOy/qnjzX5LVc44JsG
   dFMz1C+++FG8Ch0sm13d4PwB7r48CglVK80lpe1e7aygZM5QNnDQuPic8
   g==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="179285373"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 12:18:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAQGrTTTCAkfCMlC9opSYaEOkA94IkZQ3/BBBrm7tBQj3FQcm0cVtVcQ59alUwQtmM61Du2+AARieMRljgNcinUHR/pcdBN+zocLUgBylMu6odPDkEnFLDuAFOIl55B2pBBj/d76E18amTCgmxvXVkmaiZWxUViSlTOx8inetC+mOR17KcFYmZ6gf8CSZAzo/A/ZfTtHCq/mkjW9yfEZsuM08RpFPhl/wGypkr1/0AnXwg/NEn21F5VBBoMOQcH/Mu7ZMwOEo6G28uLXLWfOqbejUdt3LVgZwVrECVjDWhWiPQLcmtsn1QduB1MO8WanX22TSjYknzBc+HyyL1yuzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNo5Z4uBCY/aL7hdgAW7RN1Sc7UnI7LX5yYKW5Kyg+c=;
 b=ehEE9RqIl69fKhCoZup5V+gT3d0VQRDO/YI7ohnL6OXMKCjREvSv0ZlrN4b/qVCIPk64B66QdTWjX4XwiI9MfNSoUWdMqWuNGpwwVGd7FjfAY+eI0dLh4oY2lma3sCzEWDLgGnZXXuu0ZV+DsDqb3LZVDpzdNhtMaGScoFTJRBEMGw+92K4ily4OF15pBhpuFBM/ppkXd7rgif+CfNphKQOCRbAvoDxUtMsQ+jFWP+V35euUFwjcfhKBv0EyQnK40LqfP+YnCq9s8hS6fYbWXIMZ9S4AWfzE2BY76j0VVAV3HgJRwEzYeGug5oG5qcOUOFq894x1oDWiQq7Hq1uAtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNo5Z4uBCY/aL7hdgAW7RN1Sc7UnI7LX5yYKW5Kyg+c=;
 b=tfXd5ja3mLas51hWFd8pdrmDeYDtZYyl7UeUVGYIiTHViqFny0zKwaCMd6p8OThF92x2BTAaaZHEG5BEeAe4L1wVLvAeA4YuZDjf6bT8yLUVcsseETIsLv5izQPAsbLUy2edih/RgYHCHNnIe7jEXjboRVV7iKgkjau3e3caBO8=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com (2603:10b6:a03:3ac::8)
 by SJ0PR04MB8273.namprd04.prod.outlook.com (2603:10b6:a03:3e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 04:18:15 +0000
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514]) by SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514%8]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 04:18:15 +0000
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
Subject: [RFC PATCH v3 05/11] dt-bindings: interrupt-controller: Add ACLINT MSWI and SSWI bindings
Date:   Mon, 30 Aug 2021 09:47:23 +0530
Message-Id: <20210830041729.237252-6-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210830041729.237252-1-anup.patel@wdc.com>
References: <20210830041729.237252-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::12) To SJ0PR04MB7821.namprd04.prod.outlook.com
 (2603:10b6:a03:3ac::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.179.63.14) by MA1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Mon, 30 Aug 2021 04:18:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d07f3c08-3338-4d49-d492-08d96b6d2fec
X-MS-TrafficTypeDiagnostic: SJ0PR04MB8273:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR04MB82737411FF185618FFFABB728DCB9@SJ0PR04MB8273.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QMD+hUWtURVnIRDqMaqZKnE6wsMoGKVHqPmslMHEhcYMFIBmNyTp94Edy24RqM0IBEKf65lGEamecyJoUkiBgr1u7KqORpceDaLQgFmY6SxPahhQav+ygS3dCavxIXVKlPiHKjs517blSOcN5hGE9R+Ljxi4jmYcoB4tAUd2p4hivKtefHQlVHWBd1q/NBGYKsS79j5eJrCwABZ1n3EQgnmIyBLRs5C6XLYg9/ORYbctXCCy9hsa+o6GJri3QWORWVZMnf9w1FqGxWWcPLmLfOJvn02rJM2JUt7UeO/ZJfe8YzWolcnu6go1dc8KpgGbRcjM2CpakTBz0lLdCcBfRKdBUY6LnBe42URYRVEOCgBgJV361AkoS5PdT3FbrfBWorrG2kUxDjNB4gfvgMLzmraXRFcyXmIQ5JiGhPd1VtCKIY6h3kQoXmzYzTYSLV85Xnqw+x39u/jsCucDhoknWXkuZLG+zWZGx7PVGK/RumICcbmw/PNTIsRnPqIJjazHkLvIt/egsjOpPgg/z+2kL7+KCJSoV+L/ngibqJVF/Ts1H/ORd5mqJDoPwq87CsvXgdOl7JbnTOaKdIwN6eSZBvVETIGEe8ozxjjqI1fzJ8uLji21/bwqRMUnpnggTDSOUrLd7uPveK/XxfeZO9Aj87PnxD1Y1ljvzcE111WxiIOwtTbRoKMhdPiSjWei69z5PZ8Ah0ogY0Cub8fHPzTUHziMecPHmWIbWzCM3zs2ymczKSCf7C7m+2mkIUr4cQit5cLAiEiddVbAIGJYh+BSEdV2dvme6Wi3WS+p+cB66reiBLZiIbddsRfqEUFNHVRp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7821.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(2616005)(6666004)(966005)(186003)(110136005)(86362001)(316002)(66476007)(66556008)(956004)(26005)(54906003)(7416002)(36756003)(8886007)(66946007)(1076003)(44832011)(55016002)(4326008)(5660300002)(478600001)(8676002)(8936002)(38100700002)(52116002)(7696005)(2906002)(38350700002)(473944003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fBy0vkYC8nxGf6DltTPgnSXaMOdDvfskMrGdYeNuADS94fVdZ3ILIOk0iU1A?=
 =?us-ascii?Q?5908UaJMtTzRsHEHNYIP9FTUnLEHPFxKAO7tCaGJT5exFi/gBFC4sJPJXAHI?=
 =?us-ascii?Q?JDV8T0E91uD+cdlQukSuweHFjXC4jcK5LnjPcjbVhKWXcnCTi6Z/cTnIFP+h?=
 =?us-ascii?Q?+k+4DNjaPRs6ZueDCPZdQlz1ehxpmziqsUBE8FQO2LSm6ZeXi4ABmMUAwsX/?=
 =?us-ascii?Q?5e4xjMmhhet3C2aziR3w+D80P570AJ7F7/cox8VMXop4PddUwNn9LmNOSBpB?=
 =?us-ascii?Q?RziUmuCzRcadbayagyBpcdxyakQWxBRf9ei+W+mx4FCi1lnbngB4ExzC7dlB?=
 =?us-ascii?Q?DMdaVdDnfHW8SEMa2B2iypAs9b9ejBL1q52dlNlLFq0X//4lQdaJ+2JPuA6G?=
 =?us-ascii?Q?PViJNFIUwP8NDoPIe1wcBSv52PqvNu1BawiAfglGNgfBZROCw3nZnoJFYktB?=
 =?us-ascii?Q?ELp8kgnQgl/vU7hl27y/Yhothz0WB3G1K9lEj22JINUgqrjYIRvMRTuhYNv0?=
 =?us-ascii?Q?cDvBjZiw1XAX/tYLm8GKhwaBNTHKzUprCuw8xWyDjSW2gQIUjaPoAWL+KBiE?=
 =?us-ascii?Q?AQOxS/bkrNk6l7re+12hyxn+AQKtgwf/GnmBoCcuslvMAFebOvSgEXFhCmH3?=
 =?us-ascii?Q?hsPECpnG1mnqQwT937Qi8++9af/pHZxqtVNWGcsulaBoKWUtbP72rbBtHutC?=
 =?us-ascii?Q?l+7rvZzARA0AvU4nu1RLvnTgrD1KOkuwDJBQ4IqeTSisd3kom/krX28VQWCU?=
 =?us-ascii?Q?hbwp5VO/UF1EaB6NdTw8ITME4Fjx5HTLj4B1+Y2LxywvfuShmATlcVlRLhIq?=
 =?us-ascii?Q?jpB5kdS3xxM+Qyqju36UBqx4QZa2Qno23Tlm0tUp4/ebHZyEf1XKFqAFzAg3?=
 =?us-ascii?Q?709tWXrIQN/18aw16wy/LzRZYXlYgL+EKT9qpNs3UDlAz6xKsn7D88NxXD22?=
 =?us-ascii?Q?D6SelEyDcPRsbWtfdvAUQUzPfxtBX52fFx4ZT5mUD4YvKPug6tYA17SmNhMO?=
 =?us-ascii?Q?JunFAmgTpN6lY240zpIZJl7+UITswBFaLxnm/9HJlEfdinlDYeCB1ZvS6TCA?=
 =?us-ascii?Q?zBl/vX5zLdHfqoPE+mO+520BH/EzmmU56fRIAADJcNRjYd8zj2x3HNr2XAHF?=
 =?us-ascii?Q?kWR/QsEA1rXWKaJqNQykoXF2lU/WZlrOAwUD2FV2X0kR4wzTTznypgIeVN0H?=
 =?us-ascii?Q?rvTx3WvSYOxat+cJPL/twzdxV8dNLbLmJcHyMW5hNJRz32elDEH+W16aHB6D?=
 =?us-ascii?Q?7U2dVtDd1RuIzdZqhIS3Ilm20AypSsmtn8kgPvrdDk6TfSd4rgk+xXzb1byE?=
 =?us-ascii?Q?mDM/Jh1Yyz5ey8Z1tE9EIXtu?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07f3c08-3338-4d49-d492-08d96b6d2fec
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7821.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 04:18:15.2638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpwXnTC65TTXPBPa4CqnwDoikJOxELaBSotBkXKGiDCmlrgaFPBdsUMtille9k+NoNpOh+B6Ec7NSki/+PeZTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8273
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add DT bindings documentation for the ACLINT MSWI and SSWI
devices found on RISC-V SOCs.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
 .../riscv,aclint-swi.yaml                     | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
new file mode 100644
index 000000000000..68563259ae24
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aclint-swi.yaml
@@ -0,0 +1,95 @@
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
+        - enum:
+          - riscv,aclint-mswi
+
+      - items:
+        - enum:
+          - riscv,aclint-sswi
+
+    description:
+      For ACLINT MSWI devices, it should be "riscv,aclint-mswi" OR
+      "<vendor>,<chip>-aclint-mswi".
+      For ACLINT SSWI devices, it should be "riscv,aclint-sswi" OR
+      "<vendor>,<chip>-aclint-sswi".
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
+      compatible = "riscv,aclint-mswi";
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
+    interrupt-controller@2100000 {
+      compatible = "riscv,aclint-sswi";
+      interrupts-extended = <&cpu1intc 1>,
+                            <&cpu2intc 1>,
+                            <&cpu3intc 1>,
+                            <&cpu4intc 1>;
+      reg = <0x2100000 0x4000>;
+      interrupt-controller;
+      #interrupt-cells = <0>;
+    };
+...
-- 
2.25.1

