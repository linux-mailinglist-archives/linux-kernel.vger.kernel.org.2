Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90C042533E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbhJGMjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:39:44 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:50995 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241491AbhJGMjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633610244; x=1665146244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=LpNug1pqArRR7qMJFkETej69IhPolslKocjHVRyhKuU=;
  b=drRXYBp6e7C6qEy6ZUEbgGVygTaRIbVeKBPPknF4Een47VcCz2ksEXkC
   C1yj4T8QGz9U4FG2vkgMkzbz90noqfyooscD2sf9Ucozwmgq7DbCkORC+
   bZrnhZJ6DTLjzU3xWKXyLzbV5kdxVMraHKx2H5EpWmEPkXRebE48TTzaN
   NP9oNOz3P0mltILi0Tq3JyMEEQNezsY00pqSYpEOpI5fHjNFrhnYjOpnq
   0aFObzi3NbAYSxqumE6DpYBbuyrCLZ9mSMsN22HvUZFDoGs437k3sukQy
   sIHdrBk9P1un3AmvzwDcz2S+ZMsgJA9/628o5Z3T6enLHc2KzGiLqNU9E
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,354,1624291200"; 
   d="scan'208";a="186926258"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2021 20:37:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5NsqXNB7AwOqP30GztTAeLSQQ1OeRn1SE2zc8Hi6/vxt0wbviEpccCHtgDulIZ/dtnJFoiBFnx2tei3xScvYONPCzfRCK9IkHP+qgedjpErjQvEebG7O9eGQsG+zMWT5nJ5SCaDzhMshBpfk5r2Bz2AFws5YAOJ0oPzEi4hmSOjsv3VsWxCFCkn9bZxRo5XWTTBXDLDf7G16H4rFx/+1EsxpnOnhZVjEN0/J0xf6++Dz0vVCQGYFDsxaM5Rmu/LDbZxbSkiLnyr956tGNIB6bcSFcgWgbwUG9GhmPaWU6bz+/ziVl6eeCfnIvHN4SxA5mcR0GobXVlR8X6PSKRE7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5Lb3zuEkePAV43vHnfh02vLqPO0JYD30IR8cJf3gFs=;
 b=bBdCplwJTW1XWj/zaTlhR0tUV82vJ/6aXpp344ZR6xCVBUrV6mNs09h6PdUjP3TA+y1Vhx1Lm/eFC9yPgFw/QeEebsaiBQGjQ0/8rSr0q7cF2+qLNmXurjXZy6ql1YeHlNK8bDPEP1gn5WBMROX5xgtK06JodgbIU/ulzqwWY+08lUhfcRL98EV0nzNKi8xTW/FtyxQC94n5My90wCoJcFxAnOHIQGwOHOMM4fYiIZFh+baS3rbWSfO9DOr28ZMwdEDpIxUhsryMN9efxVu0COs0xZ/WSMXfkiyk2PtsT8Mzr1Qs7rlHPJMQc/WZBZ7LfIPkLi9g9ctJI0x51kuz3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5Lb3zuEkePAV43vHnfh02vLqPO0JYD30IR8cJf3gFs=;
 b=uRCvhwIbVbB+KQTPo3Ez4vgsnf0qFcgkS0/D8BhAEPfiCNN+9HPeLUd0cmri93pFl63OScWV0Yf75E46Am8ChVb/aMfrjBZwfsvYc4OS0v3sI27jzlpZLkHmggCSaf66k/mYxvapNtXI5Vz7Rf5GEt7DotAPWGku7e0YstLXWR8=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7777.namprd04.prod.outlook.com (2603:10b6:5:354::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 12:37:22 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 12:37:22 +0000
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
Subject: [RFC PATCH v4 06/10] irqchip: Add ACLINT software interrupt driver
Date:   Thu,  7 Oct 2021 18:06:28 +0530
Message-Id: <20211007123632.697666-7-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007123632.697666-1-anup.patel@wdc.com>
References: <20211007123632.697666-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::31) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (171.61.64.222) by MAXPR0101CA0045.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 12:37:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f57c8f9d-682a-48cd-601e-08d9898f3573
X-MS-TrafficTypeDiagnostic: CO6PR04MB7777:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7777A7E4C890F525F3CEE3D68DB19@CO6PR04MB7777.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++HH0JwZ+dsLy9I1bZVn3d0q/NiL8pIMLn5U8Uuh0fB61r+X84LPezgDsel9XlnW3R1LT+rIdMg9fQWtYLwuEFum2zDp0LnJxRAKa/2tAvXb6iXUDNNzQoLgA2Ym7Ofh2ygiRDHU/c/n/WwKrGaTPNxCNnBibQuNYqQQmMiBRpxpqXd3Mh7Hq1+VzGYOF6A7IvXDMk2PiHrnqJaOgTmxUCpt5tqfXLWmXwmR3xN/6J5Z0DkwafTfs9nYrXbuSDH0FgGtCrcgpbs06ORiOvLC/9JtbV7Gd2wTjTGjOVcuQoey1l+Qoh1oaU9LWoHoSgOVOdBkaDybQWJM4cDu2a81RBEWQ61nIPcgDvi4AzxRY2NtwJ7LbZ2g5BjBP/5JaOGZF/H4y+sysTWglwdYrSZEi05BsyJYWxMfHn44s972Feg5vx/g2a0g4boRiaXnq1dAVuDlSbeey5R3xPDgVrnx/rVphoAFLDqfSr8kX0BDvH56ZqjWGYzT6ShQQlvQMqddXlNuZUBsHhuHyoUZ8Yj9jGI+CZ71KKld/UCzgxQdwW8srzn5YkEvz32VtRFQmNiHjOzIRqZ/DbYYo112Nq9kzNH037iY4maqKkzrIhWAeEmwAEaDjWXt2uxvJc1lX9vZXP9BmWsKHm7oktJObVEtFWvAb0gYnNVhQabuogTn+8dOXsaGyDdPSSogcLcEgU5kA1mvZjhZ9EyCFPrOkdEjZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(5660300002)(52116002)(1076003)(316002)(110136005)(8936002)(7696005)(2906002)(38100700002)(38350700002)(55016002)(508600001)(7416002)(86362001)(66556008)(66476007)(36756003)(4326008)(66946007)(83380400001)(8676002)(26005)(6666004)(8886007)(186003)(2616005)(956004)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UrpA96Va4FVNEbk1b9FPb/Kh20OYn7Os2bFSTyV+lcDGqZNrnEjFwGJQI/Lp?=
 =?us-ascii?Q?eeAHuw4QuOoktmyyKw6Eos85WILGa0zlfS5hVSyguPzwrHyszflENHHITaAr?=
 =?us-ascii?Q?8RNv7pyvV1NBDDsIUFcmZBFD27aA26nvoKqTfFKMvlnQ5LQGm+KINpFUUEZu?=
 =?us-ascii?Q?8+kYjwHQz/atEwB4beGRXCL3J7YfqM3bMFznZPRYJ9/yaYwJ/hq7h6TAz2Rw?=
 =?us-ascii?Q?rk3dEN2M67K01EA7GptCzW7GaQDnORk2vbLl5r4krw3rRBO/TfoYYrCRirVz?=
 =?us-ascii?Q?rEwQG3K8AGxg4lvbVnjSX05uyQtOBb1RI/Tbk+Qs3duMzsBj2CJ4NCLMil43?=
 =?us-ascii?Q?BPOblF0A9JBWWBXbaJ8OhptpSMT+OwPWRvNIr/75yZlaj+tn7OmnnYG+1hCj?=
 =?us-ascii?Q?rDLr2E3bgYWKd4nyPyhwzPlX0BWi9OCd9Mm+A8beUur8oFHZ4xUkq+puXUlm?=
 =?us-ascii?Q?P+pywo91H8B6w28tIC8XG7m8luM38mIQjGJXxmmPOHhpkBD73Sotms8HZ+CT?=
 =?us-ascii?Q?wGRkk1Fyif0NR2F8OUDMlt+jqJv7OPC+gHO5DT2l2kFXOpVFhc98zJrODQEr?=
 =?us-ascii?Q?42yFZEIvjHZWfVcz54aqtI1+axxHPmVJrVvz4tYXW4CI15/0amVyLIP5ztBp?=
 =?us-ascii?Q?MilM9fECSHkJpAy6R37mMJYQkWIRpha1FeuGiJZ2veyd6Qq09z3942fuhwfn?=
 =?us-ascii?Q?mYfQFTIF+lZZehq0Tj8Gj0YKgXk9QnNahDvm061Ohd3pW0yPYLQ29Mc81JfW?=
 =?us-ascii?Q?2hXlvX+KLMbxLY2xo1Ng+0lJRf1eNGicS/Q8WISwZ4HFQco5fOgG91FAB7zz?=
 =?us-ascii?Q?a+JhN+7eHkbSSIj/ZGQpUaVeg/Y7HeMvoc0gY5f/n1gtOfohpxDs6CxB16sG?=
 =?us-ascii?Q?qOWdSLYhI4/SSmmulZRlSen7/fRLalTIWFTF+XHC6NI1R7eY2CeO808Dc17A?=
 =?us-ascii?Q?IWioE1dkCTEJyd6XQf7+IYIROSY8HAHT+vQ09DRtP6eeOcr1xiP3ZFHf9NhU?=
 =?us-ascii?Q?94ohuV0F94k/KdtE6mhVtbi5X4Ksd1Qu5ouDP0zGp1EW4hRb4DaVuuvpe2kJ?=
 =?us-ascii?Q?jSXWEMd1Q+pFeVCS/em+QXWPGwArIgKDUjDcwYGDJKq/uv5fvWWYdaH0ju86?=
 =?us-ascii?Q?sgvet60aaMQi6LUTlrKDsiHnSR3MFuVj9nRYcO2tkdRb41QrxxlE8blPN6Qn?=
 =?us-ascii?Q?yLT0CyKuziUx+69KY5CuP6VHHkbk1In3LnwTI3Nyvkdh1Uo88QSj3loCfqw9?=
 =?us-ascii?Q?6ZSubiU0kqaCWubqltt86RhdWTdZMAAe4fvp3CxDhyxoPpj4S8QdG8YdsC8k?=
 =?us-ascii?Q?YL7373J4GPtdV+ozkUG4Ughw?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57c8f9d-682a-48cd-601e-08d9898f3573
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 12:37:22.1221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8kMbwNPzmMAFDP75iZlm/vtnlRXfWXJrcfbW3CrYbpL77j6A7GmGKmuCXkK6AGgMaQToMhf2kYUiLGZAqO/4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7777
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V ACLINT defines MSWI and SSWI devices for M-mode and
S-mode software interrupts respectively. We add irqchip driver
which provide IPI operations based on ACLINT [M|S]SWI devices
to the Linux RISC-V kernel.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 drivers/irqchip/Kconfig                      |   9 +
 drivers/irqchip/Makefile                     |   1 +
 drivers/irqchip/irq-riscv-aclint-swi.c       | 282 +++++++++++++++++++
 include/linux/irqchip/irq-riscv-aclint-swi.h |  19 ++
 4 files changed, 311 insertions(+)
 create mode 100644 drivers/irqchip/irq-riscv-aclint-swi.c
 create mode 100644 include/linux/irqchip/irq-riscv-aclint-swi.h

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index aca7b595c4c7..c354d0576b1a 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -509,6 +509,15 @@ config RISCV_INTC
 
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
 config SIFIVE_PLIC
 	bool "SiFive Platform-Level Interrupt Controller"
 	depends on RISCV
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index f88cbf36a9d2..81306d560972 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
 obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
+obj-$(CONFIG_RISCV_ACLINT_SWI)		+= irq-riscv-aclint-swi.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
 obj-$(CONFIG_IMX_INTMUX)		+= irq-imx-intmux.o
diff --git a/drivers/irqchip/irq-riscv-aclint-swi.c b/drivers/irqchip/irq-riscv-aclint-swi.c
new file mode 100644
index 000000000000..ffd16cb795ba
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-aclint-swi.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ */
+
+#define pr_fmt(fmt) "aclint-swi: " fmt
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/irq-riscv-aclint-swi.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/smp.h>
+
+struct aclint_swi {
+	void __iomem *sip_reg;
+	unsigned long bits;
+};
+
+static int aclint_swi_parent_irq __ro_after_init;
+static struct irq_domain *aclint_swi_domain __ro_after_init;
+static DEFINE_PER_CPU(struct aclint_swi, aclint_swis);
+
+static void aclint_swi_dummy(struct irq_data *d)
+{
+}
+
+static void aclint_swi_send_mask(struct irq_data *d,
+				  const struct cpumask *mask)
+{
+	int cpu;
+	struct aclint_swi *swi;
+
+	/* Barrier before doing atomic bit update to IPI bits */
+	smp_mb__before_atomic();
+
+	for_each_cpu(cpu, mask) {
+		swi = per_cpu_ptr(&aclint_swis, cpu);
+		set_bit(d->hwirq, &swi->bits);
+		writel(1, swi->sip_reg);
+	}
+
+	/* Barrier after doing atomic bit update to IPI bits */
+	smp_mb__after_atomic();
+}
+
+static struct irq_chip aclint_swi_chip = {
+	.name = "RISC-V ACLINT SWI",
+	.irq_mask	= aclint_swi_dummy,
+	.irq_unmask	= aclint_swi_dummy,
+	.ipi_send_mask	= aclint_swi_send_mask,
+};
+
+static int aclint_swi_domain_map(struct irq_domain *d, unsigned int irq,
+				 irq_hw_number_t hwirq)
+{
+	irq_set_percpu_devid(irq);
+	irq_domain_set_info(d, irq, hwirq, &aclint_swi_chip, d->host_data,
+			    handle_percpu_devid_irq, NULL, NULL);
+
+	return 0;
+}
+
+static int aclint_swi_domain_alloc(struct irq_domain *d, unsigned int virq,
+				   unsigned int nr_irqs, void *arg)
+{
+	int i, ret;
+	irq_hw_number_t hwirq;
+	unsigned int type = IRQ_TYPE_NONE;
+	struct irq_fwspec *fwspec = arg;
+
+	ret = irq_domain_translate_onecell(d, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++) {
+		ret = aclint_swi_domain_map(d, virq + i, hwirq + i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops aclint_swi_domain_ops = {
+	.translate	= irq_domain_translate_onecell,
+	.alloc		= aclint_swi_domain_alloc,
+	.free		= irq_domain_free_irqs_top,
+};
+
+static void aclint_swi_handle_irq(struct irq_desc *desc)
+{
+	int err;
+	unsigned long irqs;
+	irq_hw_number_t hwirq;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct aclint_swi *swi = this_cpu_ptr(&aclint_swis);
+
+	chained_irq_enter(chip, desc);
+
+	while (true) {
+#ifdef CONFIG_RISCV_M_MODE
+		writel(0, swi->sip_reg);
+#else
+		csr_clear(CSR_IP, IE_SIE);
+#endif
+
+		/* Order bit clearing and data access. */
+		mb();
+
+		irqs = xchg(&swi->bits, 0);
+		if (!irqs)
+			goto done;
+
+		for_each_set_bit(hwirq, &irqs, BITS_PER_LONG) {
+			err = generic_handle_domain_irq(aclint_swi_domain,
+							hwirq);
+			if (unlikely(err))
+				pr_warn_ratelimited(
+					"can't find mapping for hwirq %lu\n",
+					hwirq);
+		}
+	}
+
+done:
+	chained_irq_exit(chip, desc);
+}
+
+static int aclint_swi_dying_cpu(unsigned int cpu)
+{
+	disable_percpu_irq(aclint_swi_parent_irq);
+	return 0;
+}
+
+static int aclint_swi_starting_cpu(unsigned int cpu)
+{
+	enable_percpu_irq(aclint_swi_parent_irq,
+			  irq_get_trigger_type(aclint_swi_parent_irq));
+	return 0;
+}
+
+static int __init aclint_swi_domain_init(struct device_node *node)
+{
+	int virq;
+	struct irq_fwspec ipi;
+
+	/*
+	 * We can have multiple ACLINT SWI devices but we only need
+	 * one IRQ domain for providing per-HART (or per-CPU) IPIs.
+	 */
+	if (aclint_swi_domain)
+		return 0;
+
+	aclint_swi_domain = irq_domain_add_linear(node, BITS_PER_LONG,
+						&aclint_swi_domain_ops, NULL);
+	if (!aclint_swi_domain) {
+		pr_err("unable to add ACLINT SWI IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	ipi.fwnode		= aclint_swi_domain->fwnode;
+	ipi.param_count	= 1;
+	ipi.param[0]		= 0;
+	virq = __irq_domain_alloc_irqs(aclint_swi_domain, -1, BITS_PER_LONG,
+				       NUMA_NO_NODE, &ipi,
+				       false, NULL);
+	if (virq <= 0) {
+		pr_err("unable to alloc IRQs from ACLINT SWI IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	riscv_ipi_set_virq_range(virq, BITS_PER_LONG, true);
+
+	return 0;
+}
+
+/**
+ * aclint_swi_init() - Function to initialize ACLINT from SiFive CLINT
+ * timer driver used by NoMMU (M-mode) kernel.
+ * @node: device node pointer
+ * @base: base address of the [M|S]SWI registers
+ */
+int __init aclint_swi_init(struct device_node *node, void __iomem *base)
+{
+	int rc;
+	struct aclint_swi *swi;
+	u32 i, nr_irqs, nr_cpus = 0;
+
+	/* Iterate over each target CPU connected with this ACLINT */
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
+		if (parent.args[0] != RV_IRQ_SOFT)
+			continue;
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
+		/* Find parent domain and register chained handler */
+		if (!aclint_swi_parent_irq && irq_find_host(parent.np)) {
+			aclint_swi_parent_irq = irq_of_parse_and_map(node, i);
+			if (aclint_swi_parent_irq) {
+				irq_set_chained_handler(aclint_swi_parent_irq,
+							aclint_swi_handle_irq);
+				cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+					"irqchip/riscv/aclint-swi:starting",
+					aclint_swi_starting_cpu,
+					aclint_swi_dying_cpu);
+			}
+		}
+
+		swi = per_cpu_ptr(&aclint_swis, cpu);
+		swi->sip_reg = base + nr_cpus * sizeof(u32);
+		writel(0, swi->sip_reg);
+
+		nr_cpus++;
+	}
+
+	/* Create the IPI domain for ACLINT SWI device */
+	rc = aclint_swi_domain_init(node);
+	if (rc)
+		return rc;
+
+	/* Announce the ACLINT SWI device */
+	pr_info("%pOFP: providing IPIs for %d CPUs\n", node, nr_cpus);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(aclint_swi_init);
+
+static int __init aclint_swi_of_init(struct device_node *node,
+				     struct device_node *parent)
+{
+	int rc;
+	void __iomem *base;
+
+	/* Map the registers */
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("%pOFP: could not map registers\n", node);
+		return -ENODEV;
+	}
+
+	/* Call common/exported ACLINT SWI initialization */
+	rc = aclint_swi_init(node, base);
+	if (rc) {
+		iounmap(base);
+		return rc;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_RISCV_M_MODE
+IRQCHIP_DECLARE(riscv_aclint_swi, "riscv,aclint-mswi", aclint_swi_of_init);
+#else
+IRQCHIP_DECLARE(riscv_aclint_swi, "riscv,aclint-sswi", aclint_swi_of_init);
+#endif
diff --git a/include/linux/irqchip/irq-riscv-aclint-swi.h b/include/linux/irqchip/irq-riscv-aclint-swi.h
new file mode 100644
index 000000000000..766b7ec26667
--- /dev/null
+++ b/include/linux/irqchip/irq-riscv-aclint-swi.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __IRQ_RISCV_ACLINT_SWI_H
+#define __IRQ_RISCV_ACLINT_SWI_H
+
+#include <linux/types.h>
+
+struct device_node;
+
+#ifdef CONFIG_RISCV_ACLINT_SWI
+int aclint_swi_init(struct device_node *node, void __iomem *base);
+#else
+static inline int aclint_swi_init(struct device_node *node,
+				  void __iomem *base)
+{
+	return 0;
+}
+#endif
+
+#endif /* __IRQ_RISCV_ACLINT_SWI_H */
-- 
2.25.1

