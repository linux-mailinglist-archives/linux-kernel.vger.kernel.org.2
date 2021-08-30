Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40A73FB060
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 06:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhH3ETU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 00:19:20 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:45376 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhH3ETQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 00:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630297103; x=1661833103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=C9/elSbr5yehmxx7fr0kbidIpXGbyfdwnuv+2zhvAaQ=;
  b=hNjVu/H22aURmsxhTFVRb+CNu6pmSlrb3WHH8qmQ8s+eiZoSVb/u5ku2
   0QgDTiSRhV2VdndRMky+q9IopUj4pF7bous+JCqlwmEo1WZfe/2y9o2Lk
   lZdTEan1oObcFZOEglGanRg3BXkCffEv6vipkEp4y/osqgbxPYw1+7a4C
   +mdfUWCUINrpEIihGQZnZOyeG7/Qxj2ZaVmGn7PT7VP1iwnTyGEZ+3u3r
   FowWc0QMiwTAzvFHS10iAzEaVbQOtyQFFLQeLgAaCLvTFm+iOaiI7z4pP
   FHFSWFrRWj8bCMC6wHxbPv+j7qsdnTEBteDvYVZtcT4E01dCpd6NCBYFp
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="177841324"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 12:18:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOJv7T8E/s9LDUY1/333Oe1OX5QtySHnvKvWHga9xRfBptGF1LwrtlYOlxihDH+ccgBbA0FTVwSWOksrcaWWN14Nbud1A4A6kdNH9qevyJEJIZHRWojt9wuakst/qAc3tQDPGQQyVvE7pc3RnG1QYSH6SSg6hafl/NIoXiENjOm/gYI0z5WxwTzkktGUtO5YRjaytil6BP7sJZd+PFN2ZOztxJlhtwjlddI1odrup4UN6aOHgkan0fPp9Vn8dpUeizTM85roa/GrGrpWxm6V2ZqD3DRQ2h+IaynmDFJoKG1TvaAP0rFI8rwnMTEVV2yIbk0FRvUO08gS78ysqB8xAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRy5w8eBGhfSZgy6uQ9PYs00ukcfzSjzb5Mo08PuMjE=;
 b=ZBFb9+JrWZ8nXt9cwwTYTJ9wU9l07DB7HrpcA6q0Jc7ZF0SYrAwCH2vqPBO5/QWtZONzGGtJUYt7IEZiscwVkNvbwDsDPktv9lCVFN/lWtoKU5gaFURO47yomhHsGQc8JX/AEJ+M97wXDG0eFbWpBoKJRvL0egXn1QHmqHMBA1MIaIlMcJqIx5+AierpzE5vNPVbt3snMUyLFdfjMGqxKx518DHK890v+9io51puSdK08nGMnXMMeynflNED95ngGRY6MZgOodnH5nDq07BCQ8U+vouPgNDJG/V6DvRtxSXQLO7g0737dF+v8gGV09H1GyhPhySVazqacBe123SPMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRy5w8eBGhfSZgy6uQ9PYs00ukcfzSjzb5Mo08PuMjE=;
 b=KZPCuwGVfnnQmLxD4/EC4MBoiyZ9CzLnqK/UeyX/gQMfWteGiEQovHyaNz5Am0cNfM8o8pDoBWfHJGgAG9yTPJZW+R3DHAtzM/0Z8voF5dkegTutInjr/01cOhylaGgtm/YNIBl9tZtJI7D7BD/JVquT+42ecMEkWC/dhArY6+A=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com (2603:10b6:a03:3ac::8)
 by SJ0PR04MB7870.namprd04.prod.outlook.com (2603:10b6:a03:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Mon, 30 Aug
 2021 04:18:19 +0000
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514]) by SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514%8]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 04:18:19 +0000
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
        devicetree@vger.kernel.org, Anup Patel <anup.patel@wdc.com>
Subject: [RFC PATCH v3 06/11] dt-bindings: timer: Update SiFive CLINT bindings for IPI support
Date:   Mon, 30 Aug 2021 09:47:24 +0530
Message-Id: <20210830041729.237252-7-anup.patel@wdc.com>
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
Received: from wdc.com (122.179.63.14) by MA1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Mon, 30 Aug 2021 04:18:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7b9bd03-85e4-4786-a1ee-08d96b6d3279
X-MS-TrafficTypeDiagnostic: SJ0PR04MB7870:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR04MB7870AF79873234FEE646532A8DCB9@SJ0PR04MB7870.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IAgKJ7wU4VlmmdHmct2SZ4ilH8/6didw6qyPTWNiidaKVSWKZI+IJ8Z25KzFemD2uTnRqptZ78uJE7X82rj0in5cG0/rAHxOJxJfmsqxwE+ROofDClRxbQLDMQd709txau3IGhAe+aD8he+LYSi7ZqjkKX+0xzNU/5FawvX8U/BU1jwhmHM8MXhdpL5o9pOuEp6BekBqCEAfXguBffnUjBOOygxq3s4fxZVhDdnZB62QMclp+rf1p4raxHjo+TfEJJ5KVo0L7kgbxC+8byX1wj3c5RbbRliHhSE2d1u3fH/07bjunYukFa2OHDdMm0dXyqpZj5fwHLHacH+mwcnk61NBjLnwuKDalQe7Xtuh2MCDwgZeDRRMWWvMyr9emwlqTXC1bSnxHewFLfIi1RFW9A4wBCOVIlw4iVmKf9xVdidI046EyMi3n0loDMSOkcOFhTj4uljoRNQOIxReisHppmttWO2yAByzdMFj60DGv49IoMEduRyo2zDYAs+LNuUPR+LajYXMBV0OhL6p6mLAqSNvbYEWp8ZkJyQXJB/dh2rQRSlR0CIkomfSSr/2R1qshb7sJGlfwh4b/Afc9vF3nXSvVgGJjXrurvpEfwos7nh8YL659twuRObMNoD9hZzF/NqMAubqkbDok1bhQcwRgXnLKRdEnpyvFCnSMzLtEsnX9QESJOIezF1Mkrt1q18eqQV9y5Ecibti4z2H2M5hnYVeIoZpseeV5EF1yO2Kr3o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7821.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(55016002)(110136005)(66556008)(66476007)(54906003)(8936002)(7696005)(52116002)(956004)(316002)(66946007)(2616005)(44832011)(8676002)(6666004)(2906002)(8886007)(83380400001)(5660300002)(186003)(86362001)(478600001)(7416002)(4326008)(38350700002)(38100700002)(26005)(36756003)(1076003)(473944003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aIkr+qo01DZPhMi3IKpD1uoZtSSbnepa4vqpQctoEVHuLs1eUbQPGAmDvyPE?=
 =?us-ascii?Q?D9Wga/OKpNqCG4mEo5e1s3TZdW9GrFT8+R/4uh4+RlshiBChpSu4RQ843rUF?=
 =?us-ascii?Q?TU4nOLT6+wjNkK+RA7pDR7UdktUTRRRCnu+PkGgSoyrsv7SMJxCSJfB7wbpV?=
 =?us-ascii?Q?dLp6Hd8llU0N3Yoyh5dl078QOtLFxPKuxFx0OoKTS7+2Szd6QEBdkoryLceC?=
 =?us-ascii?Q?rSIslMV88jOoT3xjT2Ujnt0emflh/oh7MRNQEeaMt29oPO4ux+71gdVUfTH0?=
 =?us-ascii?Q?JYK4I8FRTsL0SaeY4wTrSz+sYK+fV53tCg/cTtSVF4fNI+YS07OnoWihJ19m?=
 =?us-ascii?Q?G4WiOyMlq3h2Ts9Bc6IH6JXB9/XAf/2LNaJGAEZfTVmhITYnoceN+C8qr9ma?=
 =?us-ascii?Q?l4KofxyRfDukvIz4GS0FqOD3aErzDsf99udSfMmtGfKAerpZ1+9RirPSejwx?=
 =?us-ascii?Q?596c6f/etnCGiWlqcR8Gi8aFHKtkR9aHuVt7ftauADOQHTpG01EP+5tc9jox?=
 =?us-ascii?Q?VM2QTsFaPggRs2sVdO0Ur9qvROHUd3x7Lq/bB1MelLgyWXDGXBTTDe5ByuIO?=
 =?us-ascii?Q?UlIIbQxzrz3LbRdnXYnSfOip3PZOkxkTObeozj+Vh6glY9yJuIxNHx2/R5l0?=
 =?us-ascii?Q?uN4smlQpdbkM54fMU8qghLgtIcVbqyYde4ovPmPGbiHOcC55MHPficBLVQ/l?=
 =?us-ascii?Q?ZSiBHX1893gyGytgEpaui2n2QtVTNN5jAc+Gso1vNKX2gKxDOR1uLZiEYJHJ?=
 =?us-ascii?Q?E26s1HkIWhgnxbylVFhcExZYD845E7vrEwIMUY/2fEjMnjv6rl7Tk0FQiNre?=
 =?us-ascii?Q?Ugywy+6ZVDLDSUrm6+Fb0u8h/1x62FXPfvzZXH5FWRCW7yenbZk2M5tk0oky?=
 =?us-ascii?Q?bsexPxx2gJRoykQ6KXFl1BokZoHS0oQ1jKvjBbmjr5Lm9BotuOFI+JdVoNuH?=
 =?us-ascii?Q?yH5Ao5icm+RRpCz1PD4CgqE9JDKsV7Bjup6DuM1Onvm5H0ZPFS+MzgvGst5d?=
 =?us-ascii?Q?aH6mevLWYMKcvdAw2gO1Q/qPi1RMcR41U+AkUS4ifCRlr1dBEZS2ltsg9elG?=
 =?us-ascii?Q?pOFDkmW4xm386uPUzwSRLRrpcHXmoSVfQEfRqrkn77V2XLQxam/PkZmXVTZK?=
 =?us-ascii?Q?33EIkEunjmdjfLL/zEWGuKvKwPL+bhPQF+HAR2fvQfx2dC2OD+g0lZSEbIYJ?=
 =?us-ascii?Q?ZswiHzRXygHmvEFVs2FKMKHPMHkZPEVw5bj7zZ33smkDGpbG2g9X8OOOOEds?=
 =?us-ascii?Q?uZeQ6zNWSSJUFlLw0Q9+/1dWY7mleAX6m/eOwthsF8N34CqPd9bSFqi806Ct?=
 =?us-ascii?Q?QQCxSOkvf0jwmZZmkZh/2z55?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b9bd03-85e4-4786-a1ee-08d96b6d3279
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7821.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 04:18:19.5380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AgkEjRa9J5qdJiLGarNYsgnygSbDaMGImKtKQO0uVUzZEMYOZJlOPuI+evPdN7RjBYCK732m18L44ZemlrzGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7870
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux RISC-V now treats IPIs as regular per-CPU IRQs. This means
we have to create a IPI interrupt domain to use CLINT IPI functionality
hence requiring a "interrupt-controller" and "#interrupt-cells" DT
property in CLINT DT nodes.

Impact of this CLINT DT bindings change only affects Linux RISC-V
NoMMU kernel and has no effect of existing M-mode runtime firmwares
(i.e. OpenSBI).

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 .../bindings/timer/sifive,clint.yaml          | 20 ++++++++++++++-----
 arch/riscv/boot/dts/canaan/k210.dtsi          |  2 ++
 .../boot/dts/microchip/microchip-mpfs.dtsi    |  2 ++
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index a35952f48742..9c8ef9f4094f 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -43,6 +43,12 @@ properties:
 
   interrupts-extended:
     minItems: 1
+    maxItems: 4095
+
+  "#interrupt-cells":
+    const: 0
+
+  interrupt-controller: true
 
 additionalProperties: false
 
@@ -50,15 +56,19 @@ required:
   - compatible
   - reg
   - interrupts-extended
+  - interrupt-controller
+  - "#interrupt-cells"
 
 examples:
   - |
     timer@2000000 {
       compatible = "sifive,fu540-c000-clint", "sifive,clint0";
-      interrupts-extended = <&cpu1intc 3 &cpu1intc 7
-                             &cpu2intc 3 &cpu2intc 7
-                             &cpu3intc 3 &cpu3intc 7
-                             &cpu4intc 3 &cpu4intc 7>;
-       reg = <0x2000000 0x10000>;
+      interrupts-extended = <&cpu1intc 3>, <&cpu1intc 7>,
+                            <&cpu2intc 3>, <&cpu2intc 7>,
+                            <&cpu3intc 3>, <&cpu3intc 7>,
+                            <&cpu4intc 3>, <&cpu4intc 7>;
+      reg = <0x2000000 0x10000>;
+      interrupt-controller;
+      #interrupt-cells = <0>;
     };
 ...
diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
index 5e8ca8142482..67dcda1efadb 100644
--- a/arch/riscv/boot/dts/canaan/k210.dtsi
+++ b/arch/riscv/boot/dts/canaan/k210.dtsi
@@ -105,6 +105,8 @@ clint0: timer@2000000 {
 			reg = <0x2000000 0xC000>;
 			interrupts-extended = <&cpu0_intc 3 &cpu0_intc 7
 					      &cpu1_intc 3 &cpu1_intc 7>;
+			#interrupt-cells = <0>;
+			interrupt-controller;
 		};
 
 		plic0: interrupt-controller@c000000 {
diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index b9819570a7d1..67fb41439f20 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -168,6 +168,8 @@ &cpu1_intc 3 &cpu1_intc 7
 						&cpu2_intc 3 &cpu2_intc 7
 						&cpu3_intc 3 &cpu3_intc 7
 						&cpu4_intc 3 &cpu4_intc 7>;
+			#interrupt-cells = <0>;
+			interrupt-controller;
 		};
 
 		plic: interrupt-controller@c000000 {
-- 
2.25.1

