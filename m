Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D223FB06B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 06:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhH3ETm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 00:19:42 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24917 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhH3ET3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 00:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630297116; x=1661833116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=JiJChEtiazg7PmlZ9SxLm4HpyxFIb1Rgcy/ImlBAkGk=;
  b=qPGfvA5O6otnf2lwjR3hQiLnD5c2cBNBYzYcBYEyNk4yZBlYfsaQTnV/
   kgHxt5slgLnQjCKtoKY5kB268aITMv9fxtyQCXw16arN+etqb7ZW6rmL3
   j0h9z2UjoeUV5uWuzEN+NgmScgocfGeq5tVqWBDQwBFRGMCNxNY+NpvWS
   S3anb4zWwNEuGH3W09mZ9FL+hbVNNFl9ujKAHLZ9gJMng3QiSGYJY2XHM
   Hg8+NlSef+rdPpci8WOVOvx0bF3fy3ZylpOKC/JzitprmznOcYDALRVtR
   cjWhZ6IJbZ0CF9jmzl9zDuWjsusoDYp6i3QCennYCKQRM+hx7JTzFH+7Y
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="282519965"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 12:18:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOEcS/+c8/B7cr02LVvEkm9VVW/29l6WVBQHMhjd2sXgzdxTB5KMjfhCOJvIB5+azqMXEzIHKt7bVbwqYhGurqnLKnpROhCce5QlMElcdakhrFmJkBNPTLGfVzyqInAuaioSZC0DbDR34PLwhTeQsOySOareO2s88g9mxKAsL1mof11EWVPMfSnxF8gIDMyDkCT6aplb1Q+tvH1bcXm7Rl64ewMuBMlBfc/HX3YamMHGf6XyHpnLvdBWHHTLwVFvXgzaOaXl9OQvd5EyaQbsYLKPUjkzi7ukYQTACs9hsFep5X1Ii7HIQ7LclGvUuVBjqP+HzS9DdloogK9ZAev6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IS46CVB+KKHtfsLQ6z4JkvIjwuUhP4tVuZzo7zdbAg=;
 b=ELiO+aFwz90ICsHKUAIAMLHaz5+AtNJPOLSgnnNVWA8JnMZ08bP8/FBp3NKp32k+xeMbg4GxaYbwMpwurrB2EASCrF7LlAyQjvAtMrUpqqe5hZCqgzFTOfQ7C82HoswmiH+68VUXr01unzuXVs6tS/zOuc1sQuOegDmy5znIDbNUDmOahPGwBm6JmxSStc80aVDAM8EZpfrmQ64mdtDg+WP27Rv4qrYBo10R7D8r1L13AaSCIuGpfZhh4jdZrJj7nrEptKzByO/DKyQ3GE+khoZ+TVqI41KdopzQCoEqiBjY+z/PUf00AIOSCbmbXR5WwC05Qwo7XCZmLhnrKKNmRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IS46CVB+KKHtfsLQ6z4JkvIjwuUhP4tVuZzo7zdbAg=;
 b=qk4dy5uajr1Pnz3Kal0VaPmkstafywTqc/tN5unNYTu6QnaiDkX08agjblKTLYivn/0lEuMGDEF70UeW4W1LAqfhwzugSyIC/UiXl5FxMRXo3aiVCMHcPFIN69kCIvCnNC0DAjSFOpA80JYkDzdXtG2rwmsDK+kEG29rijUSB08=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com (2603:10b6:a03:3ac::8)
 by SJ0PR04MB8273.namprd04.prod.outlook.com (2603:10b6:a03:3e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 04:18:32 +0000
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514]) by SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514%8]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 04:18:32 +0000
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
Subject: [RFC PATCH v3 09/11] dt-bindings: timer: Add ACLINT MTIMER bindings
Date:   Mon, 30 Aug 2021 09:47:27 +0530
Message-Id: <20210830041729.237252-10-anup.patel@wdc.com>
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
Received: from wdc.com (122.179.63.14) by MA1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Mon, 30 Aug 2021 04:18:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 508bcfaa-508e-440a-c102-08d96b6d3a48
X-MS-TrafficTypeDiagnostic: SJ0PR04MB8273:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR04MB8273AD75634E773D7C0D7CA98DCB9@SJ0PR04MB8273.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GqOfYtlGVIrVWG+SSjTLHbuF0K3BGC/ADNs2AEmCabYqNvHxuwy2vsHbKIxoQkK2+fSkKx8oRGFyz4hVyZI9eYlEHOZiiCE43yml7puXoSlir2pamsxX0ieWz5x3hAjCU98pXqjg63pWw5F5057bBwTZXATscCFFuhX6cuDEJL6XTJY/UAIxAwIck0c3FJbT10b0S1gsJQsfJHQ3KZsTVI2VmEUlyVVFGVB95u14b/pINWfHgJORzB6QDNDXwN/83/0Xq3uK4b22FfZip1mw6WdYB9RCUPGV0UazFNCIipe2XkfRDbAvyoLqYPQBd1B9FobeTEg2ndm7JlRHRlwOR1F8mlEDJlpZfaOpOXxjRYWMzR5rcReknkF4fIWMN7acKpzRg8r0lcDvxBJ4xVkzr3W7wi+23xszTUkZrOB+4VCTr/V6uuKhGRqudJAm7mCKVsPH7PUSzG188U2t5O3Rr+ak4tAoKzdSVLAJXFWS/mUmlm8+3AI1zAmZDOCQlqIt+IiO+VSLDV+DLbHFcNmTZ0RHI7QiExyKVk1if5gcpe/8jqRxVCjg+iKF0kXl7hJaJDi6dd+dlwCWkYQcYVunV/GKLt9JzYLNpGvgONovt/8Tgm00z1An3Sssv2wfPFfw+ilGWtrdYyeG32GR/8wxid8dBu2LFqSxMj28Qg5tC1tPzjTg8HkmxyKdfqd2TlzEnvkBGT3BUOvIF1rzM7CZ9dpWNP6CFusPRLJJUr6jSkH+IpApsXNX3Dj698a/1K3SC4Py5otvMKBKw1PuiEJi9po3jRpOg54kcViosk6MRagWF6cLwgjLpNkisqfovdas
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7821.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(2616005)(966005)(186003)(110136005)(86362001)(316002)(66476007)(66556008)(956004)(26005)(54906003)(7416002)(36756003)(8886007)(66946007)(1076003)(44832011)(55016002)(4326008)(5660300002)(478600001)(83380400001)(8676002)(8936002)(38100700002)(52116002)(7696005)(2906002)(38350700002)(473944003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MHfv1FZoZN093pkoPxIPw2TSGQcqdXcsV9LjAkzXXAWFymvSSN6ALZDvRNY4?=
 =?us-ascii?Q?+/HH/4cdTmUQQPHeWwydDYT9ONTmv0t7Yads5d8ddlnXgPOEhpLpo/EoMPpO?=
 =?us-ascii?Q?s563NZcqcT7Y8oHAazjlYzOos/adoLmxDqRnlFoBFCIP0obcqXBp9+m8vXek?=
 =?us-ascii?Q?JmrUj9vpkn7X5zHiTUBA4SxI65RwelHCrujUmM8EmLyVJ5734ZznKvqS+2hv?=
 =?us-ascii?Q?Fu8EUNb6c4T1viutpCqi1j1HcJCvBEcZwszzhRvrGw8M0+mtk4dcwkSnGdv6?=
 =?us-ascii?Q?WZW4XTjXUBAfT6q6WtwfvxK/fsNIchVZPFl9UphWUmmXpcREH2shW1Nhfiag?=
 =?us-ascii?Q?JulmFuL6b3tVWLk6tKUGPpabtf8GiSK58lZue+rD+N442PnFqhgGzzCMv+rO?=
 =?us-ascii?Q?JpVavzMTRbIpvD637xWjgYDMlUg39Qhheg1KYN3fZgdLvfZdat+KEb2bl523?=
 =?us-ascii?Q?avSXKv57uqdZ1a/i45ffPyXf7i7XISGma9AjjiV3C35B4C9KC+oCIwaq972J?=
 =?us-ascii?Q?57VWidUpl3N+atKgZrDJTtoOxC4b+yItE63qO70u8Zot4F91xgNEBK39jojZ?=
 =?us-ascii?Q?61eYo/CfbYPmaRzW2s8oLyXnug10Ho0PEWAyJVzSa/XKc7KJ+OG00aDiIOPZ?=
 =?us-ascii?Q?D/kxIU4UpLhbm8QJlU18rO0LAYk0ih7DDwtod10l1QnNcvyFjm3xDAI5McaL?=
 =?us-ascii?Q?ecpvHhOdYZQixELt/EtFpHAPA3duc6ZbSSVK5ZiH1F/WFWrX9KGM5Lf5lANX?=
 =?us-ascii?Q?nVzzLPr1eN8bnnNS0yCc6uCRwilst5Sn8x3g6s4zm+jTnUWdWLLgVU8M82H/?=
 =?us-ascii?Q?6aa7wiJliAa2S73gn0+3EnL1ti9ZKdNZ2SPb+gYinGjt09EFqf+u2eMRw8Qy?=
 =?us-ascii?Q?uvtwnCOzwAOOk+uHEO8uEtjL0r8n9S7V2FNMB90GDnOBERKAyYm5wet4yG9R?=
 =?us-ascii?Q?Ed/eOU7m9r2On66ycf7DwXT6YK8LRQqDp282CWXz7YZWHaFdT4xNHsm/ZH8g?=
 =?us-ascii?Q?fN6igRBlL4oHqqOt7cSiM7yJDLNv+QLRZYGYd5E3Fx8Vtn8n9Nop9Q+tqjA8?=
 =?us-ascii?Q?BbZvQMOKgzM9cgLB1yd0vrL82UPJvpCAhMIyJeVJ3RzAqv2huSKrVr+QpFGG?=
 =?us-ascii?Q?P6iWB/Uq9TDQv550BlZ0e7n6FaanQxKD3zREPQXVUY0imfNBW0abPNIa9m0U?=
 =?us-ascii?Q?M5lB0Jak9BTK03c/Q4PID+ugD6mc2QGGN8aF017Fz6QzuQ7Z3ftF9tmhkg+V?=
 =?us-ascii?Q?s8F87sqUaFlcmPiLglHGkCnX0LxpgaDwzs2a9eJElqyOXS3TElcXmARm/0XG?=
 =?us-ascii?Q?81474J0M5Bm54ZusreM+MMrf?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508bcfaa-508e-440a-c102-08d96b6d3a48
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7821.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 04:18:32.6733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/OFSKoAf3PjXsJpmzsfCPa96DrI8uJUzcNQSrLV/6dtF6ILuNa/37lFnfVEcacKLpLwmAUJHM5JEnOzrsn3Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8273
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add DT bindings documentation for the ACLINT MTIMER device
found on RISC-V SOCs.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
 .../bindings/timer/riscv,aclint-mtimer.yaml   | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml

diff --git a/Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml b/Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml
new file mode 100644
index 000000000000..b0b2ee6c761c
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml
@@ -0,0 +1,70 @@
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
+    enum:
+      - riscv,aclint-mtimer
+
+    description:
+      Should be "riscv,aclint-mtimer" or "<vendor>,<chip>-aclint-mtimer".
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
+  mtimer,no-64bit-mmio:
+    type: boolean
+    description: If present, the timer does not support 64-bit MMIO accesses
+      for both MTIME and MTIMECMP registers.
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
+    timer@2000000 {
+      compatible = "riscv,aclint-mtimer";
+      reg = <0x2000000 0x8>,
+            <0x2004000 0x7ff8>;
+      interrupts-extended = <&cpu1intc 7>,
+                            <&cpu2intc 7>,
+                            <&cpu3intc 7>,
+                            <&cpu4intc 7>;
+    };
+...
-- 
2.25.1

