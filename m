Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E62F3A4FAF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 18:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbhFLQHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 12:07:47 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:42497 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbhFLQHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 12:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623513942; x=1655049942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=qfg/Aq4VfuKMl+XFVyg+80MLJYyE1rKYjxTp8Wix7Ng=;
  b=SUVkg9u8UXB5oys2oK29T7j5v9LBS9/jhreczPrI3n+MbGuRzlFf7iIB
   HAYkTHKWu25S9MN6w/TyGA+0jRJqOQfatOk5HJgLFBGNHGBti73bFDXvM
   OtyVBwRVHtT40twaCjAHzYsggnZcodk7d1pwK5DpNrdn5NzhhjQ/nekrV
   va/g/qmkd6H+1MgphtXRof973PlQeAv1urEZmg8TqXUDtRD3vvmNH/DPT
   Cty6I9E4KqzNYjE3ROlQDuHZLzTcEPkAlUIQLbYU3ExaoD6lDZv+RYNs4
   +nhwwRX3jqtJ1JALpMbJi/6tLZWYOI8mf/q+pBJfkFqSvmsTZsLVXrEaO
   w==;
IronPort-SDR: sgS2cijaG0bFyzthBi4iXM8rzFrqf49xPotANzHPUWYVZJXWmUd354S/POlFgn+RMCiQWcQsoz
 /Qv8IXKA6keud9tcxmkLZEKynEqYc/gL/i0pGXx1uOce6YXTsm7qaBF3RfKiFIS4WOpPhOOKOM
 HYq8E6B6n3AaCjMldwj22DFmifM4wSsNqRH1GQX3ox9nafrFDO//37JckkyIJO8D+wSkntw94X
 LSEPsL5+w6+/t5l/sVbGmjI3L++69DMkycXNkcf8hVm7y9JawJunsc6pE5BMbUAcMrLyUCUREQ
 IwY=
X-IronPort-AV: E=Sophos;i="5.83,268,1616428800"; 
   d="scan'208";a="176494361"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2021 00:05:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4nAcvfkp5sZ9JV8/QZPrI/Cw1r7KVTlIhLRNXwHq+7qN8T9xTcibeIMmxPJMig2rLQEgLtuPRw1Goq70E8QDUmmOqcQjdcy0GFPmE6avp9iw0zuGEk0wBBfJjn5GVqGi7x16RuahJ54U8QNUgPASeDPp/Qpra0fB2gTeeV4VmdRChJ72YojJ9fy0hnWHgNVjQtVA3Z5+b1o34H46W2FMvRVBoyHchYpNhz4sZLw9I4yUZvylNdTF/0uDyyRrgn3a1mfWjHXx6cRlkrNTFHJNAYeP4oWBq4eTvD7Yssfkn2QAxqq5ZvMfLQxzT8KprE2XBGjajmc379H3ckQq5Tffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6nO9+zvHF2BW8iRaUuUWvLNeem5iqK/wUCxD2y3icA=;
 b=gGCuGT0tHaozY0M2hUifmwIuCSjIzCg8Hl7tsB3KN3cbO/kayPuTQGt4UoPo+evwfF3xy/2F2FjKWmCAufPigb9GZZxlbJ/IY4d69RoEqJZ2j71QRcLoPpRACzKg+dwIbXeBsZWHmZlK/qW6jYxz6eGmIqm8zGerZXq8iRiSvGyAbQklyHg651QrElPhPotW2rWdZloDAq19TvqynAAsipU0HEpIf278vVkmJl2CchdjtW5bLXAJbC/ReJxq3Sfw7qDTcQUTBhYDNucWOH5kHvOF0GD8J2JkBp36aY6F4NnZ18LrmrZY9FiMk+v9wsbjq8zKep0kVYv9lr6T9HCwzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6nO9+zvHF2BW8iRaUuUWvLNeem5iqK/wUCxD2y3icA=;
 b=Y4OlaO7n5pMXqIDOJuNz0hVag8ehNmsvjhomYcubPDhENKRWWZZvMeCgGyHAH0RbatN7LL4ml0lj4qZ2tb5tcXT0WADHDQJx88k3McoPj0vDYrqWqvIIp4COsPild1j39nL368udpuliEH1DHVEFEsyV4PRetMT/O6O/LpM1HZg=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7747.namprd04.prod.outlook.com (2603:10b6:5:35b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Sat, 12 Jun
 2021 16:05:40 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4219.025; Sat, 12 Jun 2021
 16:05:40 +0000
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
Subject: [RFC PATCH v1 08/10] dt-bindings: timer: Add ACLINT MTIMER bindings
Date:   Sat, 12 Jun 2021 21:34:20 +0530
Message-Id: <20210612160422.330705-9-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210612160422.330705-1-anup.patel@wdc.com>
References: <20210612160422.330705-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.171.171.205]
X-ClientProxiedBy: MA1PR0101CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::14) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.171.171.205) by MA1PR0101CA0052.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Sat, 12 Jun 2021 16:05:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1eed982b-58fd-401d-f01f-08d92dbbec9e
X-MS-TrafficTypeDiagnostic: CO6PR04MB7747:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7747C1656B40759195476B738D339@CO6PR04MB7747.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yLbBqSBXgXSTJwFGULF8Gv8P/iMhMZKSBH6huhoeeeMj0EC6V51WY+D9utJfrIw8+EsFGyUuXD7Gxcu2pIF6c9s4UBkFCPjR0dt/7Za/Z+tmsOFrjGARZEtwLHtxthW6vsaep1jY6aQBObqqCLdNFxCSy6988W+jaF47zVElYG51E6JhJisC60eCdyXcMIT0dNkIUbQxtt5y1sJgekZ7A+3WgnR9HU1xUKqOeDzstaWvJ/6WGuzEiyoO1Wr3Xn+0VH0nVMl7oC7k7PuXe71yTPMQlToqDfXC16aBiwds+zuCuUj2iHlnE4kZRqDatHgAMDBZAZqwXhJHgCSJRfbaEdVPbivo++3jIG4nl7s/0CYP79z5qSxF16Vf2D02yCImQ0DN3UjadJAO351KT9yYi16Kam7AdIrU3xisPUVBpzmg/fqkf9IlmvtHlg8KN73dp1g+co1lzgTtzSkiGBhd4tuXQC0txnphmFcVT7lGBIEgsm99Jiz+DhGAnOcc1f43Mcp8g9ridifVcT5bbgZtk2u785uz2ZSSUkRJUKz+GMT35IDeOu63Dzu4IGF/Kr2Swkx205UrNuko5N0J3OiBlqWemNsx3gLSi9RHsIWMYjOQpn9KdxinbAhupFNvmBzk3CgbRO/X4V4EoUH2cWRZJeS2JVLH8EzYqPtw/7u8HaRESc4YpXmWtJ7bUKPk4wvVnhqH6z22RpPVylfTJNGPs5QVRvI7vJjA9eg44BOlrfXsx05BNdfPDuucw0IFSQGo0hsifSczCeNcKyWQcziY2rHU+pFyqvKu9VuQ7qtmSzJf1jPNF4nNLOpxrGTMVgNmLLRG2kVsIQ2MVq/IRXh9Sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(54906003)(8936002)(8676002)(110136005)(4326008)(2616005)(44832011)(16526019)(186003)(66476007)(66556008)(66946007)(2906002)(956004)(316002)(38350700002)(86362001)(38100700002)(55016002)(26005)(7696005)(966005)(7416002)(8886007)(36756003)(52116002)(6666004)(83380400001)(1076003)(478600001)(5660300002)(473944003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+mYz9rzNDGO7iCHksZSAq5UvaZkUIGj14D+PiCMd3E9vzMm7k9nP7Csc5DA2?=
 =?us-ascii?Q?CT60AOzSjkqOWQmz9LMMvM6m773jB4R0wxTRRXgxIokMIE/vOTnSqoI3eWyI?=
 =?us-ascii?Q?bPyD3dyoG5/U7HQ4QgrZCmlpfjdmOifmdOoDskxV/f2u9zE3KfkfWRLs6kaw?=
 =?us-ascii?Q?bQTUFtn4V/t4dhcCo/uOidkrDdJwLlfD886NPgA95t1+gioIpqNEvEdYxiaL?=
 =?us-ascii?Q?vLe9tiV8lkR5/I+MyXCJ5ekk/VZn4WPOCYrhG/iPGO9sqjJlML6sg0QiDAZB?=
 =?us-ascii?Q?dOeZPF3QtWpkdaJL7fXwcB+i1wTecVQlU0SEnlUopR386MqgHHtTVSZhsWfw?=
 =?us-ascii?Q?T2v0ijL+lIlsqbpHzVVKvkq+mvptMn7v0PZo4Y2JxwNMV28vCre/JMn63nCI?=
 =?us-ascii?Q?aiDVGYIPN0I7Gflhf9oDIOjZSvIHWXb5s2Ks5DoXOIm4oj7fjZQATTS4TYtK?=
 =?us-ascii?Q?zVZ+Zm+NwXEJAE9r12sAmRoGs0U2p3dgH+DrOUv/hRxbvBWQ4dQ/QY7u+1ro?=
 =?us-ascii?Q?cwvsE5wmmS7WdWtoqGAZ0xVMwtyytUs3YlUCf6ZHirr5ESLvGeRucXbOW19G?=
 =?us-ascii?Q?jswhADj4n//wmWbx0CClHXTw/vDmlDPvlpVMJm6UIJ77II30W/1VLdRmvF1K?=
 =?us-ascii?Q?LUrCeTfqsCjCeEja0aEAzgADNTP0To/UiOrztmHyC2CNHxTwHhRMy2u/90R/?=
 =?us-ascii?Q?eoXTdXCZMWQqPNdoYPBbtiabpGIQKuXRHg/OzS64bZwErgiFSPGsjGEs+rQE?=
 =?us-ascii?Q?pe/fdgwZKs6Az9TqI626LRTk0ma6y7Vqblj90fQJR3LiLbQG+pCtQzXMWhGB?=
 =?us-ascii?Q?hXcnmEqbCHfQ/GWrXqpjlVg68Nq5Qr8kQ5jgGWTabCM8NKdvBcYoChZkh9i4?=
 =?us-ascii?Q?mKRblWi9x8En0qcLbUuOEcIFsvLAzJ9oj8kA9PcP5sypNMrimT6oR3zGVzJ0?=
 =?us-ascii?Q?hQ3Ly+T3Xg8M9o/Tszhe35lQSmjhKg7xOHlVrcThyRlaftQyKYiO1UAoTSTJ?=
 =?us-ascii?Q?nqhxssyjGjMtJit2ZQcXlt9vx6L0gRksURMmjVu32iLgMtomkCxGr/+Q4hal?=
 =?us-ascii?Q?MSihokO4MJ08KrFkviDnqKpwrGUa5C2Cvwm9BZVlK3OjEgJEiEt3SvtDjPEM?=
 =?us-ascii?Q?uVs/qFM61zIFGnsay4S4xZ7L8Uxas9uf6Niny6uFgGFefto8S5Gt2QITo7Of?=
 =?us-ascii?Q?K8TnkdPRVeQwtfa5Pt84chmx/nZy91mhfIh1cR90fF9L57CfueLW6YCfOc0g?=
 =?us-ascii?Q?c5+6U+XdtqpENGrPdfPGlVpAPaZp6oZNjKkgZUHgDSI0vePkqHvpWF0jpPg9?=
 =?us-ascii?Q?XC5oawT/+b+cMc+i32IQxN1G?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eed982b-58fd-401d-f01f-08d92dbbec9e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2021 16:05:40.3929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04QVyIygWysW0Y+ElnQOKeEBJZipFAI7iT2oynSBo7rhjc6BrGISZBP8Nw8teJM4UIwgT2ZuXv5sjK0CwyLFRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7747
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add DT bindings documentation for the ACLINT MTIMER device
found on RISC-V SOCs.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 .../bindings/timer/riscv,aclint-mtimer.yaml   | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml

diff --git a/Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml b/Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml
new file mode 100644
index 000000000000..21c718f8ab4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml
@@ -0,0 +1,55 @@
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
+  The ACLINT MTIMER device directly connect to the M-level timer interrupt
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
+      - const: riscv,aclint-mtimer
+
+    description:
+      Should be "<vendor>,<chip>-aclint-mtimer" and "riscv,aclint-mtimer".
+
+  reg:
+    maxItems: 1
+
+  interrupts-extended:
+    minItems: 1
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
+      compatible = "riscv,aclint-mtimer";
+      interrupts-extended = <&cpu1intc 7 &cpu2intc 7 &cpu3intc 7 &cpu4intc 7>;
+      reg = <0x2004000 0x8000>;
+    };
+...
-- 
2.25.1

