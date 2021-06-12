Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905983A4FA9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 18:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhFLQHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 12:07:31 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:36009 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbhFLQH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 12:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623513926; x=1655049926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=t7ooRGcGck2S7Vt15nsDHpJMupfy1R+frrHSrB2Hzp0=;
  b=KCtPI8Gkk73B5bce9TY1AJ7adYaISJKUpglKyFnfmmLla+XXIAP9Q7Cm
   le/dnZ1Q8jRnHYXXhP2Dky7qodhW5O6goa78VpLvC8vtQV6mEGXgbwz/o
   +Xph0ndSrxHx1izqkyYzPlcmd5opdPIs31jDw5RrIz5q0f57ZlDAESgRf
   n5uEJwMZY5yLCrWM38Nsx/ZvpBOeY61XUss4owW38M0v939qecDRxd63u
   tG9M+SKavWa5sYVJmhi6h531IEvDLvrZ74eIYi0qQH1vZ/FLmNe3CHUvs
   5ekLeWf5hqI68pl7Jr+aMvP3MvjpOPF7ZIuHP1Mtb9wscO74SarZ7BnZR
   A==;
IronPort-SDR: GOl2f94QrWyIfA0Y7NEMILoUdQ1Yt1uRgrXVdPkk5g1M9wQaNN8eYCP2UWEoWVHwiQbuuQn0aT
 y7QU62kq1cS6/pyDQuda+p4HK0p58F9M/uotvNjZ/HH46BdUjGdSs5xZu9GHMtL2T5V+GJcVX+
 hoZdXcLmfkHg1pnGFCHo/X7DHZR6v990I1h89ra+vNMzT1+fcDSZq8GeswX0b+eaNsqG+ba8qs
 zULHKbglA7KzzVOqrghHGioeWHb055VNyMi3k5dGg9s7aWFBzpgqxCsALxDspYCyf8D44ArAAz
 42I=
X-IronPort-AV: E=Sophos;i="5.83,268,1616428800"; 
   d="scan'208";a="283160942"
Received: from mail-bn8nam08lp2043.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.43])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2021 00:05:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUaPa56+ITf2VSszLn6D+87YqM5kNLJ5ZXQIwQpUOBHmP7Xz3drWuP+lAzAhenQFIiuYleS/qMVqNl19H22IPBIpoUFbsacT1e2HdgqOMdyb6VAiOnTJ7jg0q5dP8Xw2sCyZst/Cx8zbN/F7EmXdPrew/KN94QThjDBQ7Jym6027LkerPnq4xO0P0ycWNIwPIZGZz8GOGjy/ai+qXdApa4Vrc2AcceWJrb8XrdPmICgmUj5nD90b632WWhKPzSTUQRWJNs7PVXSRZfOd3vk3VPwKcQ4++76Sro2qt3ReY4WHGtAQRl8GSIUOd3CLOtGJSglJteO57ubPuSFj0di60g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTKeWgJrveQC6f9OF1B//WP7b52NKnhSx3qzAz84bYE=;
 b=UfhECcsL9HagZ6p8O3QMXhTw5jnrSM7XmYblYsnoDwwTzJvGp9ngNeRubzohOEl32FV4LAxNRpzm3rfiq/GwHr3CHWZ0us7IPN+hK7Af4gSULMeshUd3JkJQO9IoubwczLEm3n313TnGPdFrMXcHVynTnHAgyzUCPBUQEN2KLNqJzX2kb16B5GTRDzDLli0/clhX0T6L7W8qU7gwbZa3w7Y72GzWL3WZBhB+K8LjrPCjhUfOWZEVaN73fDFEKyFh8G4nvJqamt7MfVU47epkchNRxSgy7IXh4rI4lBoDgSo9wLMpw5vasfIjqPguD/eK8QNd5KmPbrdrol8E/3mg1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTKeWgJrveQC6f9OF1B//WP7b52NKnhSx3qzAz84bYE=;
 b=QSejbSo/0QYYUTzZ+VAVLL1k+7jWqJYRSXe6UrEhgRcn1haG13r8ZIwc2Fakn9baxRXA9+pAjHFqavODuypLytukDhRnIACjoV29Wm+CWzEnuAoGRyH1XKBJqqHQzHX9eAMQ/oJlcEjaBhwVc5IgcRXZoImQxO/x9vVYNm/bR6k=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (10.242.165.134) by
 CO6PR04MB7795.namprd04.prod.outlook.com (10.242.164.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.23; Sat, 12 Jun 2021 16:05:23 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4219.025; Sat, 12 Jun 2021
 16:05:23 +0000
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
Subject: [RFC PATCH v1 05/10] irqchip: Add ACLINT software interrupt driver
Date:   Sat, 12 Jun 2021 21:34:17 +0530
Message-Id: <20210612160422.330705-6-anup.patel@wdc.com>
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
Received: from wdc.com (122.171.171.205) by MA1PR0101CA0052.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Sat, 12 Jun 2021 16:05:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2326624a-71a8-4979-c8a1-08d92dbbe29e
X-MS-TrafficTypeDiagnostic: CO6PR04MB7795:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7795E097B2EE2B3AE6CA40EF8D339@CO6PR04MB7795.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:605;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQ5FzdDJ9yslUzocy3eAwn2B2amheGcIZEwrgIF24/O4zBZmZY66YfltE7k+1nQPttGj1fBGJATFGbqIDKMeYAP1gnFe5pAb6xDbqtW/V5/DVNKdRb1SHZEfjAq9UhK/gxihuuV0HYM0Oawko5ZftkaMEXOJGDYc/BiDGjXWKsezWH/HCIhi65kWNj0mLBaSV/nOi9+92naADoLe9HpvoZfTgFezeJl1WOg24NFNGxmdMGc4KyjOZszomZYtpDh59xDhYvGTdhi56KLLp2ATwRrPWArjQu1Qr8SXKNrh1Fa4Ksy3vSBxlhm0tHGqTZ6vlU/jH/kCICgSv/MlkE3dY/K4S4K+WmjqCoSlpQZEUrEP/Rxe6fqmXwhidd2bBYJjBxae7IJoC++rSmL3nWlynbg9mt6wTWKmW+TiXAk783nePk9zaj+viZ0v9W4gnEW/fH2f4/f29KpEekFd2+dtjIy+cC02Ae6OGORu2Irrk2bgm/3lr39y07FkjBaEtRmMVX0Cpei7dlP7xGCTxkOTWw6YevUN9fLSHOCbLwbl7vLryfia9ywWfxqPaowbk/UvJWbwR7tSBldHbY4X3Guk28BRwPU6gZRzzXN5Bff/n87WdPqKN+k4vVmj7/V7zjYDh6n9F+4VNpL/wNnmo5TsmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(36756003)(66946007)(316002)(4326008)(38350700002)(86362001)(8936002)(55016002)(1076003)(66476007)(54906003)(66556008)(38100700002)(5660300002)(2906002)(7416002)(8676002)(8886007)(44832011)(26005)(956004)(16526019)(478600001)(186003)(2616005)(110136005)(52116002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uAygxFqlDRonESIW/Oz+rCBl/GQzQgVn4Tw+xcNmXwc3aiu8/l79QomyKVLH?=
 =?us-ascii?Q?AxJhBIScW/dOTEtRWs96RXNdhcNXi69KZ6j6iezV7DHtY3jeENXn8gN6kusS?=
 =?us-ascii?Q?besmq40jZGDhzYcznbgpFFxJJNCn8HqfWunOBGrTwTMb6xsyC0fKngQqFBcZ?=
 =?us-ascii?Q?RPbzBB2rCWCi0rAUr+wIbrt7mrGkQWsusOkNIK6qBOi91UbYdNhVNT5WgAsu?=
 =?us-ascii?Q?XsC1WUXyy2HZHvcWFOMMona1/aiOg4xLTRHioJXT0kIqlP2IEv98YTndi4rs?=
 =?us-ascii?Q?ypzebGph2miy3zCEaG2tts2YD3U2VikrQjbNpaI1FLHaaWBS2Ou2U1jXjhLc?=
 =?us-ascii?Q?6t1dyH5P47+sZ9cOfn5nW0OxjyHJi/euQ+nR6JBq4/agc+zXlCuxHDxlr7Zo?=
 =?us-ascii?Q?f2F34SyCx6YH6ILPQfpWtktbosF6ue+nNfCw0ItbgFCDXpCOBeUNua6nXljo?=
 =?us-ascii?Q?/sG6TchRNVZF4DumorsTxRt4lfjdsKTv7VQ38IuEZ862H+Q1fobOlsT0cUEI?=
 =?us-ascii?Q?9QcDKXoV1DloeZ7+XVRy17O8fLOT2SbHzlx3APfOrd7rZTVyR+iSrvtTYUDA?=
 =?us-ascii?Q?7IuYg0lz/f/uDgzUGUZpgj/fqlf44Wd3o6mDDVwKiyx69dBj6a1NHAzTVWau?=
 =?us-ascii?Q?omMQH7dLg4DkZZAaDdPGOYWMnX79t53tl/4/PZSKasE8+3fzVbPWZKV08RlB?=
 =?us-ascii?Q?Nl/NOE8QGTf6pA4G/Tcow8tomYuvgQi7r3SbBDH7k1WoGrJvpTT5f8zoo7qX?=
 =?us-ascii?Q?Bljnj8tLiMJdDfu5rMm9XOLS5Rx4q52DnHGF3T7JxU6wlkQMHk2faYgb0nXE?=
 =?us-ascii?Q?NT6ZVP43r14SPWrUlJBW3/oHViGZxcSRL2MXQ9KLYG/YOVqp8c4EauvnFZUX?=
 =?us-ascii?Q?Qs4aaUM2mLMwozQC1CvS9cD+NUTeBz3miZ2tngX6+RK0niGrVOvJ6is2Z/UX?=
 =?us-ascii?Q?B2SI3QQVTbyKdi2A1fmATK5sBS1ma08Pw2VuK64+pD84LHxmMppRqd6ZPCkB?=
 =?us-ascii?Q?Ol/EVLPwKxHdNYixk06HCn5IXwBknjQpV2LK7JlHfGWIrtNrDvQJeV2fRlbQ?=
 =?us-ascii?Q?96ZkPbcbU5u/53bNaiI1gAYSqqNGvhCN8kiti+sRTH4UY24ULvPtBbAHOjVe?=
 =?us-ascii?Q?fb9Lg4uUtZQ7i6nul596qrs+fHyp9IX+hEJT3CVDUPxS8C3T86lMi1FQ3ctC?=
 =?us-ascii?Q?EzBgpi9T/A1DKB949Nof9lgqJsIzfo/yzXS9SC6GMNcDBnILczPEJoIXQSMt?=
 =?us-ascii?Q?6yATpgMgeY5ohf4wz9caaUrPgPbA4mxM3gypM2fjOHNob8q0vo8HSEgp0fB7?=
 =?us-ascii?Q?S8alGG4aupEiqJA+bYum5XUa?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2326624a-71a8-4979-c8a1-08d92dbbe29e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2021 16:05:23.7739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MiyLQyzBsWO7L12QfUr0PV8OXI1QtKXkvX78WU9ZAvv2Eogg2ZohiljWbQ+aWwnCcMGGi3g5MCYBC1uMR7Uq4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7795
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V ACLINT provides MSWI and SSWI devices for M-mode and
S-mode software interrupts respectively. We add irqchip driver
which provide IPI operations based on ACLINT [M|S]SWI devices
to the Linux RISC-V kernel.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 drivers/irqchip/Kconfig          |  11 +++
 drivers/irqchip/Makefile         |   1 +
 drivers/irqchip/irq-aclint-swi.c | 122 +++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 drivers/irqchip/irq-aclint-swi.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 62543a4eccc0..2010d493b03b 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -508,6 +508,17 @@ config RISCV_INTC
 
 	   If you don't know what to do here, say Y.
 
+config RISCV_ACLINT_SWI
+	bool "RISC-V Advanced Core Local Interruptor Software Interrupts"
+	depends on RISCV
+	help
+	   This enables support for software interrupts using the Advanced
+	   Core Local Interruptor (ACLINT) found in RISC-V systems.  The
+	   RISC-V ACLINT provides devices for inter-process interrupt and
+	   timer functionality.
+
+	   If you don't know what to do here, say Y.
+
 config SIFIVE_PLIC
 	bool "SiFive Platform-Level Interrupt Controller"
 	depends on RISCV
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index f88cbf36a9d2..a6edf6733c1d 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
 obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
+obj-$(CONFIG_RISCV_ACLINT_SWI)		+= irq-aclint-swi.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
 obj-$(CONFIG_IMX_INTMUX)		+= irq-imx-intmux.o
diff --git a/drivers/irqchip/irq-aclint-swi.c b/drivers/irqchip/irq-aclint-swi.c
new file mode 100644
index 000000000000..f9607072cc7b
--- /dev/null
+++ b/drivers/irqchip/irq-aclint-swi.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ */
+
+#define pr_fmt(fmt) "aclint-swi: " fmt
+#include <linux/cpu.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/smp.h>
+
+struct aclint_swi {
+	void __iomem *sip_reg;
+};
+static DEFINE_PER_CPU(struct aclint_swi, aclint_swis);
+
+static void aclint_swi_send_ipi(const struct cpumask *target)
+{
+	unsigned int cpu;
+	struct aclint_swi *swi;
+
+	for_each_cpu(cpu, target) {
+		swi = per_cpu_ptr(&aclint_swis, cpu);
+		if (!swi->sip_reg) {
+			pr_warn("%s: CPU%d SIP register not available\n",
+				__func__, cpu);
+			continue;
+		}
+
+		writel(1, swi->sip_reg);
+	}
+}
+
+static void aclint_swi_clear_ipi(void)
+{
+	struct aclint_swi *swi = this_cpu_ptr(&aclint_swis);
+
+	if (!swi->sip_reg) {
+		pr_warn("%s: CPU%d SIP register not available\n",
+			__func__, smp_processor_id());
+		return;
+	}
+
+	writel(0, swi->sip_reg);
+}
+
+static struct riscv_ipi_ops aclint_swi_ipi_ops = {
+	.name = "ACLINT-SWI",
+	.use_for_rfence = true,
+	.ipi_inject = aclint_swi_send_ipi,
+	.ipi_clear = aclint_swi_clear_ipi,
+};
+
+static int __init aclint_swi_init(struct device_node *node,
+				  struct device_node *parent)
+{
+	void __iomem *base;
+	struct aclint_swi *swi;
+	u32 i, nr_irqs, nr_cpus = 0;
+
+	/* Map the registers */
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("%pOFP: could not map registers\n", node);
+		return -ENODEV;
+	}
+
+	/* Iterarte over each target CPU connected with this ACLINT */
+	nr_irqs = of_irq_count(node);
+	for (i = 0; i < nr_irqs; i++) {
+		struct of_phandle_args parent;
+		int cpu, hartid;
+
+		if (of_irq_parse_one(node, i, &parent)) {
+			pr_err("%pOFP: failed to parse irq %d.\n",
+			       node, i);
+			continue;
+		}
+
+		if (parent.args[0] != RV_IRQ_SOFT) {
+			pr_err("%pOFP: invalid irq %d (hwirq %d)\n",
+			       node, i, parent.args[0]);
+			continue;
+		}
+
+		hartid = riscv_of_parent_hartid(parent.np);
+		if (hartid < 0) {
+			pr_warn("failed to parse hart ID for irq %d.\n", i);
+			continue;
+		}
+
+		cpu = riscv_hartid_to_cpuid(hartid);
+		if (cpu < 0) {
+			pr_warn("Invalid cpuid for irq %d\n", i);
+			continue;
+		}
+
+		swi = per_cpu_ptr(&aclint_swis, cpu);
+		swi->sip_reg = base + i * sizeof(u32);
+		nr_cpus++;
+	}
+
+	/* Announce the ACLINT SWI device */
+	pr_info("%pOFP: providing IPIs for %d CPUs\n", node, nr_cpus);
+
+	/* Register the IPI operations */
+	riscv_set_ipi_ops(&aclint_swi_ipi_ops);
+
+	return 0;
+}
+
+#ifdef CONFIG_RISCV_M_MODE
+IRQCHIP_DECLARE(riscv_aclint_swi, "riscv,aclint-mswi", aclint_swi_init);
+#else
+IRQCHIP_DECLARE(riscv_aclint_swi, "riscv,aclint-sswi", aclint_swi_init);
+#endif
-- 
2.25.1

