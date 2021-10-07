Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BE0425342
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241544AbhJGMjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:39:51 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:51014 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241489AbhJGMj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633610253; x=1665146253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=B4KQ5owgxF71t/5+5kv1LHnARsrhX8y/w9R6m9phVCs=;
  b=lYeSp0Bi+xSB5pcAK1I/W8EXzrwG3yEtRgbPdwWYGRL9hKzAuD/YSxGq
   HuRDpR71ruLn3pthDKLMLm5etBcL3hoFrZoB+L3P1r0+Cp4ZzvQuipB4j
   Rktx98pjq9TAAyG0f70JWVcQE+gaIRWQRwlX9Boxs2vb1s5SjttfrEeNy
   02e40+s+OoxfvBg2F6N+/+UiuK8/1oWHQNZmJS5wgijw0/2IOH5dsnuCf
   vI+pGlHPFQu3tU0QyhErbHiKGWMjh4PiAuSZ/oevYMAJBcQlkGh+TSJGN
   Lu38DePQWl7deAUhUrDghaHeeFHvPsPyODoQ4cbLLMAhYXQfkAEqX47To
   A==;
X-IronPort-AV: E=Sophos;i="5.85,354,1624291200"; 
   d="scan'208";a="186926269"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2021 20:37:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwOmjqno6DQl+WxPrdK7LRSE74rzQv+zHLu7DzNSx5q/+V+iLvvFssNueBs2BLiXucpm8YozuCUZ3jEcoV9W7voPUX0ZTCOYijsUn6pv5oHHoBGbKIgmYEmpT1jaTOzPe5uXp9JAf0+cT1RyrIR35XsrPdzY6GbyXJt1fCK46QZy5Og4NPKvFmQ74LicE84XakY0PxRMjYz9FluKvXWX0qbL+876w29PCqbkLxTPRFZSZLnOI5QUFJlDwc040A9fvAg+SMJvITIPTsWIAXbh1ttm99MyOMzIK0PbLwqZx7F8Q2NGDQ+waUoL4BRvZ1B3zJMLMRY/j5N6/XOpbzGg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7eQEKOyVfnV/t/WI49t0azDGir2D1wEEfDQjFQasUk=;
 b=jppWQqJIXdTWPBGWupJZIsC03AOtyR0sSNFQTJyPNUALJdeBJTCnKJi3hL7ySp0Fp2Y/hhWdnE1Gi3DcQ6JcxKre4dq8Z5aVP6OrPHbsbF4jKbTGjZZaDNIWmVnOTg/7uSHFOPLHeJKndYNR+kSsfk++hNmmtv4+etndo7TRqyK4/sRXmcWjrDxKFHTLvcSMK4GxgXq6EkCmz6FZpVjmnOoEqxdDS1EGD69VNFvyA48DHgeFyZGzF9p4jQSizJqfnOGQsfZYkdQ2uBvSSrUEZozMAheN0vqlwCvCmLCn05IxkqWT82XIbrTDl+PREeRtlQ8QCqPi7kPwh/B48HL20w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7eQEKOyVfnV/t/WI49t0azDGir2D1wEEfDQjFQasUk=;
 b=PWUTvdLfl8X6kKbBZOvB4+p0cRS0U5vZxBwQqe8YVPc2JVPKPhdB8dRTSylThjxEcmeVK5UPAHSipzf5REAo3B3aZyqw7ArJirKRdWUrO1krVzZlb37GA3TSGP7XX0Zj3ybPXkzETimK4ji4rMdG2fOf0kEl2Cmg52vFRLuZBM4=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7892.namprd04.prod.outlook.com (2603:10b6:303:13a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 12:37:30 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 12:37:30 +0000
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
Subject: [RFC PATCH v4 08/10] dt-bindings: timer: Add ACLINT MTIMER bindings
Date:   Thu,  7 Oct 2021 18:06:30 +0530
Message-Id: <20211007123632.697666-9-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007123632.697666-1-anup.patel@wdc.com>
References: <20211007123632.697666-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::31) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (171.61.64.222) by MAXPR0101CA0045.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 12:37:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08396c37-1210-4275-3fa6-08d9898f3a64
X-MS-TrafficTypeDiagnostic: CO6PR04MB7892:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB789254F4FE2DD0525C1EA31B8DB19@CO6PR04MB7892.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k/ca0I+hZppjYDW6K6xc8ah/hIEVf5+gAyx1wVQJ++u6/QbTKFpSNPSoZDgerBH3aM8jzzkKovhRDerxolxkfGmv+SjAn6/sNOqdKyrwwHBml6K2QxavIOnjEafryKVWpAMlHzj8+TPq9QuxWC5Lt4QtS2QIn0lXDQ4sI4U19ur48l2hUSFu1uHXKPF+hO8TA5ZQBUw2FIRWOkocX+TPUdvWf+PJRyB4ZX5CiOQtGvQNMtUhhx8NNcjWfEcp1+Rt9c/89iIG2PPegMbni0RzFD0J4ZMU9Byf+X0xOZSYWWLyh3/uaQn9tOymZ0t+wWhH2eqjwF49dxKEuWoTBiU/7yhk3BiInfl7i0R2sw3SzrFqLuWOp5S427/zgiundP9ylYpbbA3FaB7kkA0YT/OivlTe11/xgCIVaTwSGVYzSXIajln/csULPQwk/Y5Pj3e7SOqKAAIJpP2h/T2YAZwdnNfn+NdR4kGon24Ybyb3L+oaXT4P6ZvMU4O4OM69ZcRFbzZ4IuRWz+j8e14HvzDTMVvXNqlqcEW4OIF7MDlMNP/qSKD4yTNzuMflXSSoCf16CxvK0MQWAQG1eMWr9/2nKmyMYda1oyW8GcZp62+Wab4pFWkeml8p60BJp+YmwPBLGN/vKnwmV9hKAy6F0c3uGIgsAWXy/NDC5wBJNNSvl35sP3JUb+2+lmi4Nw2pZURQCKr6tYEh/eSxcjBXNFp4mzp9GT9WO+Y1ycF75Obdck2ibmGWjObSTepM0q5vAHUt1HRCZ8n4RIBUx1jnStQlvn2btIJQ33lXoSdhUSFgoTGApjlWvzcmxgO+gpyW451F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(5660300002)(8676002)(110136005)(316002)(8936002)(508600001)(8886007)(4326008)(36756003)(186003)(26005)(2906002)(38100700002)(66946007)(44832011)(1076003)(55016002)(956004)(2616005)(966005)(52116002)(66476007)(66556008)(7696005)(83380400001)(7416002)(6666004)(86362001)(38350700002)(473944003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6reIMyRhlfLNNrWrFM2Yw0xhNEaGPhsarEbYOvLiEmA4qwyBKJx25EzMoXLf?=
 =?us-ascii?Q?E24SFxXyZYsdyQic+8AkFL/qgf5RTa2XFG6Bemay9s6ouQYM9CZfNv3NLW2r?=
 =?us-ascii?Q?hmn+BIJ+rcFNkS2LcGipCcmGPd659zQkscJPlkXRWRHH2T2y1WxvFSVXKWz2?=
 =?us-ascii?Q?0/5ugdR19tpqSZHagnuTflAJWFvJ85a3ypVf9gj8Y3+LsMitTQ36ICljHlmK?=
 =?us-ascii?Q?0arQCuLEDL1d+Ytfz0kI7LpsjJji5AWbOxSJxdXAydAf6ABGW84GkKv4zng5?=
 =?us-ascii?Q?AHRu8BqSeeOOze7+R8J/3gomn1joICVqjrIEtZ/IoO6LZOCvY+ClSnSyNjcq?=
 =?us-ascii?Q?dAZub3sHV7aLLvGPMi3V2IVRhhiOJo7LilQc4N2n77fLY5mnLfv+j0+jEDKy?=
 =?us-ascii?Q?J0zBccKApASt+fy2mHbfy+VymhHZ/7FD/kTsPGttmbBskbYirSaG3QgA9xK8?=
 =?us-ascii?Q?6F6HFxw5PCU6gHCu7BNrryvIc2m2IELbllyLAtuAPnrgsYbvhJ9LWsFaoPTL?=
 =?us-ascii?Q?GTnbj5SZTv+aG0oWuZKlHWKU7VEWu3Z3pzbW9P6ZRufHww/JPykPDjOMx2W/?=
 =?us-ascii?Q?ZjQOS5Hzfc4HvKjQ9UOudt/ZdQCOHvFffWk3x0AXQTwE6C8/AdZwULbwOofK?=
 =?us-ascii?Q?H4bilTtkghguFIIC80tY4d6LbwxQTO3UtPSilrcAvCUsxZt2nh5b5yNQJoUm?=
 =?us-ascii?Q?Tt1b9Zz7h79D7iaxOaiHbNT/Q+5CsCCezxmeI2WvnMK2vSMMqsFOe0+uMTO0?=
 =?us-ascii?Q?oULaA9K8b423pOW8ZlOLq6rpuenxTphHfJlhTJ6M0ly1ujQg8z5X4PYH2he6?=
 =?us-ascii?Q?jL2qMK1Gd0+o1olhCTyLKJytg75tvbJq5TlpuGSqbLT74fpLuVqyDYW/6keE?=
 =?us-ascii?Q?hryMazMkyZBGML5qmkWW5q9EqkAU1hMBcBsfRZ8dTcnqs9+sXtI9e4FUTSXt?=
 =?us-ascii?Q?zXZFuN+xDv8zzH/j6mHPfEnSXWzEFICIVIsuNsPMlcRGenP+gk1gqse1+Tp6?=
 =?us-ascii?Q?01K2YQrolib/tlADp7wC1CcidwikDmAbe4oE8EHRgFcbav3J9bEYF1nKG7YY?=
 =?us-ascii?Q?RuLR1G8d/ceyCnIcFaLhXNe93iLg7ud8oknIE9jad3WXLd2ytB+eWyUpTEyQ?=
 =?us-ascii?Q?1aU0hM2n5DtCQdtRlNP0vby7IgUi+fNLe37j4IML9FF8wEh0vVAaL/QS4fim?=
 =?us-ascii?Q?6TpmsXhl+vRg4UwG0EOEGJZjkSO9K/xiJva/lg2x5tFKRshnHjuunjHCXXR7?=
 =?us-ascii?Q?bLwCpVetvxZfvZ3vZwQ5ZHxCwm5/JC2+kpSL2+5ItigREA6fDAkTXaJdnzip?=
 =?us-ascii?Q?8UToTcQwAe51WpyELXCfxgbn?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08396c37-1210-4275-3fa6-08d9898f3a64
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 12:37:30.5729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INXk/pEpxoOU7snPaqPiDk1vs3WtlrchH7WxlTFsyt3AqV8uotir9z3gkC0exFtly+ix1+O0wm444lAnuOo2kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7892
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add DT bindings documentation for the ACLINT MTIMER device
found on RISC-V SOCs.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
 .../bindings/timer/riscv,aclint-mtimer.yaml   | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml

diff --git a/Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml b/Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml
new file mode 100644
index 000000000000..ebb7e81a5a12
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/riscv,aclint-mtimer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V ACLINT M-level Timer
+
+maintainers:
+  - Anup Patel <anup.patel@wdc.com>
+
+description:
+  RISC-V SOCs include an implementation of the M-level timer (MTIMER) defined
+  in the RISC-V Advanced Core Local Interruptor (ACLINT) specification. The
+  ACLINT MTIMER device is documented in the RISC-V ACLINT specification found
+  at https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc.
+
+  The ACLINT MTIMER device directly connects to the M-level timer interrupt
+  lines of various HARTs (or CPUs) so the RISC-V per-HART (or per-CPU) local
+  interrupt controller is the parent interrupt controller for the ACLINT
+  MTIMER device.
+
+  The clock frequency of ACLINT is specified via "timebase-frequency" DT
+  property of "/cpus" DT node. The "timebase-frequency" DT property is
+  described in Documentation/devicetree/bindings/riscv/cpus.yaml
+
+properties:
+  compatible:
+    items:
+      - enum:
+         - sifive,fu540-c000-aclint-mtimer
+      - const: riscv,aclint-mtimer
+
+    description:
+      Should be "<vendor>,<chip>-aclint-mtimer" and "riscv,aclint-mtimer".
+
+  reg:
+    description: |
+      Specifies base physical address(s) of the MTIME register and MTIMECMPx
+      registers. The 1st region is the MTIME register base and size. The 2nd
+      region is the MTIMECMPx registers base and size.
+    minItems: 2
+    maxItems: 2
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 4095
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts-extended
+
+examples:
+  - |
+    timer@2004000 {
+      compatible = "sifive,fu540-c000-aclint-mtimer", "riscv,aclint-mtimer";
+      reg = <0x200bff8 0x8>,
+            <0x2004000 0x7ff8>;
+      interrupts-extended = <&cpu1intc 7>,
+                            <&cpu2intc 7>,
+                            <&cpu3intc 7>,
+                            <&cpu4intc 7>;
+    };
+...
-- 
2.25.1

