Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5733FB063
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 06:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhH3ETa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 00:19:30 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:45376 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhH3ETT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 00:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630297106; x=1661833106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=MnAyQ1HiHgbLpHJ4fcLV2lkJX2VNxilW1qn/1yH1N6w=;
  b=DWQGFsmBpOESnORSQZT8oGIA/rM/q7sto0hC1pSu1pRg7rNLIHBdy4KW
   QOxe+NfAv8lEQiA4rLimQyARqaLwXCFArJ2WhXJXmtL63jWc9eDZe5Tka
   jtphGQpTBjPOZgRyi0JIQiduW/6BhFPEZsMjXVKa97RdMwD5dOf/mm3g4
   xgbLMEm0yVXuBTVHC/E109dAa/g0BrlkQ5vmTSu8XAO85PDKfNrjy51ok
   ceLFo3SlAdWzU+WQlRw2TuzfMb2CIIOy87Jf+NyouptLdanCV6i9EdRNJ
   BLkZg8GuBrkgoWqLX3j2PF3vpdrnSTgW0f+r97yXrncRdoQahnFdvxXpj
   g==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="177841336"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 12:18:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGm1TpNxrrEa97rvGtwOSWTExs/gCWiaA5rRgGgAdhEw0uQ7MqpIbDbtLQpLBu6YCw2M1RvU1108yHo4of3Lf3UpDGhtaXYGRhzZSDTk0uVpmiGFBq78NYcVKqrjkfjBzVjGhIE4nsentHu4ka85FMiHCfFQJOPqnpp5gyqtzh6n22E+oEmPGMs+s5A/nS2HRGkCiOn5k0ku91JwbaAZOvK0Hso95TBw8+D1IRLG74o+7ul4EEBP+pb0DNvJ+cZinB2+4cfY0/P/kJLb76PVur9oVJNmlR234iw1WobQyzf3NrGs4IIEU0XkFMr75MWliUojKXijXJZYU6VeRQXBOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4BiG3zHdqnY/mJM8drY3TNEtZLaRqBEhgasukGuwbw=;
 b=VUaL/XVz6xecsc1MaYC549bp+ijMwfD0FHiI7vT53yoXkZUQcAiaCDzHsqSagZOhYtTuxrGUShdO8iE58Jfs6NneRnRcqTLCH3QS3s0ZVVj2dDWRq25JAmnJWc9hpNbVqC+VxJrqHYxr1O6Q8TvIm7EY6XlmiDb5IxP80RR2UGwoMRtli7dhAU/BS1gzdvLoTkvAB6criMGKAwk5aVt7GGmS+3qY9OyZ3xesVteF7+IPR5i1PK1o4e/DmquN8Ppa0oKzaBYlVo7GfyZJBANtEESHsGYEUPT62w+nIlNrg7CsBSBCABRxDQ1Mtk8KaMkcjgFGtbxy6dXCyAnz1P6/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4BiG3zHdqnY/mJM8drY3TNEtZLaRqBEhgasukGuwbw=;
 b=zsdNcX8bWKp6h1CQYOrLqMJl2Z9Y+z2AthULbeFUd9xXH4do5Rb41plxD56gJlkkvKgEAmZ0HyuI74b1L5EH8o1saIvw8v0wc9VSGRbnZD0mtdmTkH13YGWzg976jDsdDDfsBG01/rxRoWRthCFEcydYDwW6c8bwJx1dseLYuD0=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com (2603:10b6:a03:3ac::8)
 by SJ0PR04MB7870.namprd04.prod.outlook.com (2603:10b6:a03:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Mon, 30 Aug
 2021 04:18:23 +0000
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514]) by SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514%8]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 04:18:23 +0000
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
Subject: [RFC PATCH v3 07/11] irqchip: Add ACLINT software interrupt driver
Date:   Mon, 30 Aug 2021 09:47:25 +0530
Message-Id: <20210830041729.237252-8-anup.patel@wdc.com>
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
Received: from wdc.com (122.179.63.14) by MA1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Mon, 30 Aug 2021 04:18:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a307f43-4be3-4043-7f8e-08d96b6d3507
X-MS-TrafficTypeDiagnostic: SJ0PR04MB7870:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR04MB7870BADF7B83E148FDD1CF468DCB9@SJ0PR04MB7870.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u9t0OKpMXRlwkjTQnFexHNMa45OCm5d8Cc/aRg50fFvZ3bbcQ2f/HQJr2tayObMI4wvpl/RUesmJTiWkE0oh5evX9tAVgYhcDnc9PaX4qKua3ag00bv4OToKOqJF1UFOLDrRakIziwO4GM/PVvyMw5XjeyMx5et7koH0Zs7co30YsSZUSYJewKQvW7fYUKLXvadrsW8/EnWgyzLn5vauXJoDLCTMlyFxPApk1pkppwTBmNUHftei+mq98Y+456FQvon2x308IKP1EjHxJC7GpRfwtHFPXrQu4dU2mHYt7gOT4H1CA/pFmTSK/JftxT/m35q5kTO6tNCJS/ZOBJ0RmUFzs2x+lBFBL387psQRDyXl2EzA7DIU8PFso33tjYBmrzjyxz5QXK3LWfxxYBTvrU3Gqs3Nzkk7JAI6LCILnPB0KgRKmg39c6AUQWUbzIodqlDbK2kR1YzMKbC4g6A88eOTel/MzNVzmtrMU8DNpIk0t7trVPE2zn+S1U1t4TOXiR2nI5WNp4RvDUjixEOXAAsquzSPnTno6bbrp7/P75RNCZMFXX+0ttVCVx77arpBgGXtbDO1dAd+8zeNJc1R2ev5NrOY1BArDKlx3xWy3ZeduEwcIVXkmCjRX2NqWErZp8BGUC96NE/tNM+DHuWTClvMvptv9odWgMBVZfidEgMH3VbH80s/G9Dk/Tlog1ctn2s9qlaAIsYdHTjEsFmXYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7821.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(55016002)(110136005)(66556008)(66476007)(54906003)(8936002)(7696005)(52116002)(956004)(316002)(66946007)(2616005)(44832011)(8676002)(6666004)(2906002)(8886007)(83380400001)(5660300002)(186003)(86362001)(478600001)(7416002)(4326008)(38350700002)(38100700002)(26005)(36756003)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KlJVAmHe4IDZDpIzcHsEaHnViABhLhiaexc67XDDNRunYMQfB/0j36OGECo/?=
 =?us-ascii?Q?yWPlOKwSNA+mgK4UTNXqykpTyALAEoCANaK6AO8TT7VKcb2we6uwmhYSS3Mz?=
 =?us-ascii?Q?3ZKSzh+vf72kwjTcfc/TKHcjlfaMyxDsjhzeSleq9SZYP01fKQJdtnWLhTs7?=
 =?us-ascii?Q?Y1TPEhBUKQ4XSsS1hFkPMkUmcBKaJWOeHGlxI3TvvJyI68O25ceeum9hA7fX?=
 =?us-ascii?Q?9kApVfCadfiDLw0SctRKhbaxbxLOkI2ugY/mB8ZTbCZrub76w1rjbp2A+7F6?=
 =?us-ascii?Q?l34kwtm6Fv7HsT0htlnp987N4klBMw40C+3E/2DQTIXGrrfh2QMUUSwgIe2Z?=
 =?us-ascii?Q?L3jvqNIjdkN3JfVRMkyE3ZbB5JKHiVNYK9e3RWJ5dttaIAhVis+yUbfNmeUY?=
 =?us-ascii?Q?WvOHBgqNE5BhTgKjbu73OzGUPSRwqE/mzqEPo5gajfPlnuKfITLsqg7wQA/M?=
 =?us-ascii?Q?6cLXi9fjisIFlru0gLNx84Fpws477EiXuZhTKeWQf95nMfbekfO4+IUn8qOm?=
 =?us-ascii?Q?oGKIavjT6n6q3/jwZKYNPcsHL8BVhni993VlL7pytfqc8EfOzxIV52PFVzUH?=
 =?us-ascii?Q?T2/Bs5JEUJWDPzOKN723uLhADe6DLWmUVlQtO1sd9fkhZeH6iw56gfAoRWpE?=
 =?us-ascii?Q?ENtZ7TKJGEhunkygEMEyNTMcWRq5mACw1W/wKIdr7iorldQPVcRjdRD5TMg2?=
 =?us-ascii?Q?ay9zQlQld7oOJhTb4Te5YKg98FFjNrKAAbB+h29jQpefkyBpXnV4F/ma59ls?=
 =?us-ascii?Q?P/ZBTjIb8ZloiKBAfiG/iNcZ7HT2kY3jaEq0NdsI/0qXRtiS6WeFF3wbtubs?=
 =?us-ascii?Q?AMEqbNnFRceDfHxeuWeoObk5c8ORLztS1/S2WJ/G2m51JCs7ZnhQlo9K1s7/?=
 =?us-ascii?Q?5Hp8kz9UTPKA6gy9BzbvSDSHaii0qCg10vAq/uwnPmwb16QGe5a4bGoU9a05?=
 =?us-ascii?Q?BPi9qI0H2s2bvKUMgG0y6CA4pJpa9xoYj5UHZCWMXcxQ0zP46m4h3ze6OGwI?=
 =?us-ascii?Q?+laz6GVIUzsFAtvg8Iu4vDlHBXzprJLGnEFSpMp6C0hUdDDzYdfcFaIFW+bA?=
 =?us-ascii?Q?TB4QeVYpGEXYY1vce+6rdzahyX/iwGyH8nB7g8tPw5iwUiTgL3D5U5dL85Go?=
 =?us-ascii?Q?uIN32kUM50S+zJAuUgDOkTiSyiDaWorb7DIY/V83kXfuy6DeoJn7tef+FWQp?=
 =?us-ascii?Q?s3XwaE+HAREoNJOJMOisebtfyuxhO77/IMnRXMnYqvfU/BXUFANm2ZFCV163?=
 =?us-ascii?Q?NmyOThmdPzQuVgJYguwiGCbwKZ1IoTxESIgn04/X3q71RFb+5+5feMor4dIZ?=
 =?us-ascii?Q?stvrKJ9as7pWPdJ99ZFs7Qzr?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a307f43-4be3-4043-7f8e-08d96b6d3507
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7821.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 04:18:23.6619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11pfm2flX8yPxDlJ/jeZqVZptyiT5NMM2fgQcO4HafpGq+pyYo3IlbRDvu+rsyh1AUYSBgL0yRta1KVywA/5lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7870
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V ACLINT defines MSWI and SSWI devices for M-mode and
S-mode software interrupts respectively. We add irqchip driver
which provide IPI operations based on ACLINT [M|S]SWI devices
to the Linux RISC-V kernel.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 drivers/irqchip/Kconfig                |   9 +
 drivers/irqchip/Makefile               |   1 +
 drivers/irqchip/irq-riscv-aclint-swi.c | 265 +++++++++++++++++++++++++
 3 files changed, 275 insertions(+)
 create mode 100644 drivers/irqchip/irq-riscv-aclint-swi.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 4d5924e9f766..4e7458c551c7 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -508,6 +508,15 @@ config RISCV_INTC
 
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
index 000000000000..c61987d2f823
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-aclint-swi.c
@@ -0,0 +1,265 @@
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
+static int __init aclint_swi_init(struct device_node *node,
+				  struct device_node *parent)
+{
+	int rc;
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
+		swi->sip_reg = base + i * sizeof(u32);
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
+
+#ifdef CONFIG_RISCV_M_MODE
+IRQCHIP_DECLARE(riscv_aclint_swi, "riscv,clint0", aclint_swi_init);
+IRQCHIP_DECLARE(riscv_aclint_swi1, "sifive,clint0", aclint_swi_init);
+IRQCHIP_DECLARE(riscv_aclint_swi2, "riscv,aclint-mswi", aclint_swi_init);
+#else
+IRQCHIP_DECLARE(riscv_aclint_swi, "riscv,aclint-sswi", aclint_swi_init);
+#endif
-- 
2.25.1

