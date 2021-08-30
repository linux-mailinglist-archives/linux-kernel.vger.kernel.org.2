Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8493FB059
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 06:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhH3ETB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 00:19:01 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:29560 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhH3ES6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 00:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630297085; x=1661833085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Cx15Qou/sWHshucAv4v1UhYD59B6SbXanyGAok5HBFg=;
  b=pHgW+imsIzLaZTPpvb8kHyTwsuZW95xX1/0uGxsuA2x2W9MALGIWAPJt
   JndBu+vpUf2pP+Ix1WgGQBmOBBQhR/wTNnP//IGXppGdh6pShpo9Mdvlo
   g/4MbhkEBo34so99wdfXNcvBSqaReZHAg2JmYcnXK3xZfNNfT2ry6pNxS
   Ojf3nwt0iPJrMGjLb5sUDy94KE9xYyzjxssP7uEEjGPeXZxGSPBUJUz5i
   BbrQwX1T1bWyTvM/GQygHAwmgcz9JebxF81lqD/cHbIf2N92MJvrH2YBJ
   Sc3L6Nc0N7ZrdPguLAGH+w8eJBtZeAmfugiQ47UpDu8I8X7R0eAlmKupN
   g==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="179285345"
Received: from mail-mw2nam08lp2175.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.175])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 12:18:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXpqurK0WxCS0+Zi9JcnLsEIx9mXRL35IJfJQvRA9DgxAO9SR5vWFpva1i+5BgTouxHb75m4a8Mup4WIc874baahzmyRpwXkuOW72fQT3z7UT3WO5MErQN9HJnbutywwLf0OfKvqn25ZqOs44+C90jSdPQ13M3yQ2NUUeLSgCW09ZketOEmxqflmEIo0RO3nd8ZzxPdrt3QHsUV/zAPRqUyC/anmXwpFFDNbnx9tDt43WTKIx/Mbe5U6rW6zXdMkif5vNYqym2CGbpB0WLiJ9ZOzNuUCcvDGNFO94YSCk/S5qMfmJMYJzd/lKWyDxeThw+Ns0Hmno/IatKjcifrg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyBvuSOEAZNI/lfJCeYih89IeUy/RMfg9Voj/s1Ppyw=;
 b=J347Sw//IxcSO6kAJs/S6kSAanJcpuw+lavaNhYdmGQ/V03T5L/wjD1yjTJeLiiUHiV99ktuY+r+yU1QIQIVwEReWjRfn2yh/i5onV2foqcFp8NPPXES7FYYnBwDWmyKWEXAOEFVc9TyPSaRrUzIg6u4YPzY2GT0vnnvqh0J6zzvLMW18fn00ifurknVDxpmZpPYaNuJBV3Q8G4yk3hJHvLPYKxw15tD7az9DEBDDRTtCcMmOj+Ev2sxGmNtxkLUrtIvTxpkxzoc9V47PneZdcFmE3wJMxTHFuGClJi5nDnBT5IiBNjq8LeTiUcRSGQ0h5WTlcqmbKn+JziSwX4EvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyBvuSOEAZNI/lfJCeYih89IeUy/RMfg9Voj/s1Ppyw=;
 b=dIjgqTDqMaEfGP03WWvaANUs5M9pYmjwlSt/71wFzfbbzD/+nKRHSxIh/mmjIe28nXB9Y1qFy5UVM7VFGT3bq1JGANTmd20o8SJpE48A6a71YaxI/jXlySI4lSIs7jYk9QT+O6p7RK+GyN5mvgpbXOXFFr20A9SeJcytIeytoJE=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com (2603:10b6:a03:3ac::8)
 by SJ0PR04MB8359.namprd04.prod.outlook.com (2603:10b6:a03:3d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 30 Aug
 2021 04:18:02 +0000
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514]) by SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514%8]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 04:18:02 +0000
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
Subject: [RFC PATCH v3 02/11] RISC-V: Treat IPIs as normal Linux IRQs
Date:   Mon, 30 Aug 2021 09:47:20 +0530
Message-Id: <20210830041729.237252-3-anup.patel@wdc.com>
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
Received: from wdc.com (122.179.63.14) by MA1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Mon, 30 Aug 2021 04:17:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c34e37d-b663-4127-ba50-08d96b6d2846
X-MS-TrafficTypeDiagnostic: SJ0PR04MB8359:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR04MB83590EED3D823BC1806A331F8DCB9@SJ0PR04MB8359.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:146;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cfhJTA3hFoqbz42iv52t+SHP+CBSTKo7/rWBMx9tIr9V6p+W5w76EXaHA/amIVqOgXNazqEZsGH+bofHbm6rHKuZLH2QFEOEx+DH2ILwROYwKpXk61FtnBLm1ZTAZWdCkJXB7SA8rzGfkIIYuHM9zTjRRQmFzdt1GlbdafDzr3de00N3yQgeVBaYNYEADu5fkb+yNcfEGiUb6SNdYAY4NhUrHlZqxDik8jwKCymD7u7s55U5mwS/NCVb1FtdsiKg9rMF/JqSDFk45vVgh5E4+/2kFnmaJPInnFhkebUrN2KYGFZxsAAsMct7NuOGykkK9pkMhntA0LGq8UGrt3nYcIhSJgk30Qv6p0yJ/cYP1XXGca5UFt9yHnHSWXvMrXrcX7OQgXTKJHhYQJhxf4fXluC60s3RB/yj82K52wr2wJPR+pcqU5Jp3BMDIIuks/bFbCS7dPhFqG7tPVHmlfp0pm34k97M9R5SE0Xy8AFyrh/EBhRkyKoVRYOoQn1Dr+l6zdA2HPVq0BHyuO2l2vix9tKFQ7JGnO7d1dCzMgtWNT516X57dIM8KVH/OB+p6/ljZ5Q6BMCeSyWHOS2eyPCiu1AW/X/GrTHd7yEXek8+9DQ6ox3shCpEmPJ6PmbDAYu4APoEhpRK2yAiPJDD97WwDuhHLyJ4JmnF04z11Hc6I39Nhf5htid0Hpp32rmWtPTTeDSp3lAka7rJP5+5Pzgpzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7821.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(7696005)(1076003)(316002)(7416002)(66946007)(110136005)(86362001)(26005)(4326008)(8886007)(478600001)(8676002)(83380400001)(2616005)(956004)(52116002)(55016002)(36756003)(44832011)(8936002)(38100700002)(6666004)(186003)(66556008)(30864003)(2906002)(5660300002)(38350700002)(66476007)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sBroe2uw9yZQT89/S0av2bxw5W9LBN+L0thL95P6nIRaMxc0fbJH2mx39hlf?=
 =?us-ascii?Q?a8mLme6TTqXifnkpctQlH3msEwGNexl/KgSSTMMajuhtRz6zb7IZE2WTtyRZ?=
 =?us-ascii?Q?2B/UIiYDVkx9t7M2MEk86zQWmapA4QrnXkNe0CgQ18UsHp/TwubMyfvwn0ge?=
 =?us-ascii?Q?w8Y8UbgL3iI7pR1g7XW4fyr5jxuF2XvTgPqB9zFTx5k2m13aN7T+YqcG2wci?=
 =?us-ascii?Q?ZZWrtmZLyzIBhJUtyCSMXhJI7lbJLnNMKNQSV0AZ8ABXhk5OWK2jbfBjbXyR?=
 =?us-ascii?Q?jyqWSRz/FLq1NfUfbGfUJ/3zobMx4ldLT8caQiIkmyuiHj92Q1igg84sTNJz?=
 =?us-ascii?Q?MrBUQrr/7o8O5btOY1kRZW5f2F8d3I7vFf6eO7zGnXwTW8n6YXeJtSgsJwQS?=
 =?us-ascii?Q?3UVCdqoMzPdRRaTlXfvv6IlLlGabjL/h4qilQDdaNccLZMQ1YxMmRfhuA38R?=
 =?us-ascii?Q?6HfIrT2I2jaWYGtgAzMHjSrRaC9h9LNlsz9LYOCp2qc0+wGUjVieeBSdeCP+?=
 =?us-ascii?Q?euwR2RjvTzD+GkmaW5ZwnaXJGcPnLV6warX5teBYdcEgtsnF1wuWGG4G4GFU?=
 =?us-ascii?Q?dKpJAUT9gDhK7L7PGG3sY+7IIRiYwEVz+ulpYZIO/ec5NLf5mGday+o9ztX2?=
 =?us-ascii?Q?1smHv7ujl6n031KuobR6cZfp4re1DtV9Obrh6WtpJllc8ACLgzMWKSdSTy12?=
 =?us-ascii?Q?4jsHjpNpOwxde91mPVbmiggpSWM2e33lSAwIgF+/jidK5HuqZMExgi/0Xkb1?=
 =?us-ascii?Q?bhIejsTDR9fX+4Xmr75gvL+EP1FkI+ovB3HCiQphq0kK2wdGnHJ1W29/5uRx?=
 =?us-ascii?Q?dM4ov60/Lu9DUdXenBUAiPJq8rTeWAq4ZF4SLAa3mxFZzworw/34B56vucSI?=
 =?us-ascii?Q?OpFC6rYcMsKlZ2Bap+vSZOA8pFZIF8by7D83mf9ndfAs+ZCQ88R/1jcBV0O1?=
 =?us-ascii?Q?kpMgaIFUe7ZJfez24gO7j9VkPSThDrkRy16OhpAFgamgi8vN7AyDtxIxzLud?=
 =?us-ascii?Q?wH6AcXs9mjDLbmcUXY5AeuU+mQZKf2hANJRVbwCT5Ukv0YIDEpG7YiBLj3Dw?=
 =?us-ascii?Q?ddcWb5Obv1bugk1olLbA5k+bBgMHZdA4meoAi5EBqoRk89QwcaW7xJz9ubu+?=
 =?us-ascii?Q?2bDeopcMkpDft3XB0Vzlq8XsAZS7QhLJi7RLnd9IlmEKB6BfG13AH3OBNGGH?=
 =?us-ascii?Q?teRIESj4zKvJpmc0Fw4M/4Bv9fe21mk1TXU+6r29NmsNQnaotVXYJdT9VFq5?=
 =?us-ascii?Q?7l00Hhq9L5KCkNfAFmsN8HJQyEIRuEUz8KA4t85cblAlPo7er5DGF+kjuUiy?=
 =?us-ascii?Q?mJgnmw36VZzijCQCc8R1CNqs?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c34e37d-b663-4127-ba50-08d96b6d2846
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7821.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 04:18:02.4441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbRv5Z/IjwqLAbTLQgVa4akoWNuinpX+XvmVWx6b7MhjvaV9wg8Cg+7hJySC5CFU0aVu2L0LxCmY7sk9ZR9PTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8359
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the RISC-V kernel provides arch specific hooks (i.e.
struct riscv_ipi_ops) to register IPI handling methods. The stats
gathering of IPIs is also arch specific in the RISC-V kernel.

Other architectures (such as ARM, ARM64, and MIPS) have moved away
from custom arch specific IPI handling methods. Currently, these
architectures have Linux irqchip drivers providing a range of Linux
IRQ numbers to be used as IPIs and IPI triggering is done using
generic IPI APIs. This approach allows architectures to treat IPIs
as normal Linux IRQs and IPI stats gathering is done by the generic
Linux IRQ subsystem.

We extend the RISC-V IPI handling as-per above approach so that
arch specific IPI handling methods (struct riscv_ipi_ops) can be
removed and the IPI handling is totally contained within Linux
irqchip drivers.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/Kconfig                |   1 +
 arch/riscv/include/asm/sbi.h      |   2 +
 arch/riscv/include/asm/smp.h      |  34 +++--
 arch/riscv/kernel/Makefile        |   1 +
 arch/riscv/kernel/cpu-hotplug.c   |   2 +
 arch/riscv/kernel/irq.c           |   1 +
 arch/riscv/kernel/sbi-ipi.c       | 215 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/sbi.c           |  21 ---
 arch/riscv/kernel/smp.c           | 163 +++++++++++-----------
 arch/riscv/kernel/smpboot.c       |   4 +-
 drivers/clocksource/timer-clint.c |  23 ----
 drivers/irqchip/irq-riscv-intc.c  |  55 ++++----
 12 files changed, 350 insertions(+), 172 deletions(-)
 create mode 100644 arch/riscv/kernel/sbi-ipi.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ab66daadff42..179a14d9e241 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -50,6 +50,7 @@ config RISCV
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
 	select GENERIC_IOREMAP
+	select GENERIC_IRQ_IPI
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_SHOW
 	select GENERIC_LIB_DEVMEM_IS_ALLOWED
diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 289621da4a2a..a992faeded7e 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -106,6 +106,7 @@ struct sbiret {
 };
 
 void sbi_init(void);
+void sbi_ipi_init(void);
 struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg1, unsigned long arg2,
 			unsigned long arg3, unsigned long arg4,
@@ -175,6 +176,7 @@ static inline unsigned long sbi_mk_version(unsigned long major,
 int sbi_err_map_linux_errno(int err);
 #else /* CONFIG_RISCV_SBI */
 static inline int sbi_remote_fence_i(const unsigned long *hart_mask) { return -1; }
+static inline void sbi_ipi_init(void) { }
 static inline void sbi_init(void) {}
 #endif /* CONFIG_RISCV_SBI */
 #endif /* _ASM_RISCV_SBI_H */
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index a7d2811f3536..6bdaab122ffa 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -15,11 +15,6 @@
 struct seq_file;
 extern unsigned long boot_cpu_hartid;
 
-struct riscv_ipi_ops {
-	void (*ipi_inject)(const struct cpumask *target);
-	void (*ipi_clear)(void);
-};
-
 #ifdef CONFIG_SMP
 /*
  * Mapping between linux logical cpu index and hartid.
@@ -33,9 +28,6 @@ void show_ipi_stats(struct seq_file *p, int prec);
 /* SMP initialization hook for setup_arch */
 void __init setup_smp(void);
 
-/* Called from C code, this handles an IPI. */
-void handle_IPI(struct pt_regs *regs);
-
 /* Hook for the generic smp_call_function_many() routine. */
 void arch_send_call_function_ipi_mask(struct cpumask *mask);
 
@@ -45,11 +37,17 @@ void arch_send_call_function_single_ipi(int cpu);
 int riscv_hartid_to_cpuid(int hartid);
 void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
 
-/* Set custom IPI operations */
-void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops);
+/* Enable IPI for CPU hotplug */
+void riscv_ipi_enable(void);
+
+/* Disable IPI for CPU hotplug */
+void riscv_ipi_disable(void);
 
-/* Clear IPI for current CPU */
-void riscv_clear_ipi(void);
+/* Setup IPI for boot CPU */
+void riscv_ipi_setup(void);
+
+/* Set the IPI interrupt numbers for arch (called by irqchip drivers) */
+void riscv_ipi_set_virq_range(int virq, int nr_irqs);
 
 /* Secondary hart entry */
 asmlinkage void smp_callin(void);
@@ -92,11 +90,19 @@ static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
 	cpumask_set_cpu(boot_cpu_hartid, out);
 }
 
-static inline void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops)
+static inline void riscv_ipi_enable(void)
+{
+}
+
+static inline void riscv_ipi_disable(void)
+{
+}
+
+static inline void riscv_ipi_setup(void)
 {
 }
 
-static inline void riscv_clear_ipi(void)
+static inline void riscv_ipi_set_virq_range(int virq, int nr)
 {
 }
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 3397ddac1a30..38b555edb2ee 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_RISCV_BASE_PMU)	+= perf_event.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
 obj-$(CONFIG_RISCV_SBI)		+= sbi.o
+obj-$(CONFIG_RISCV_SBI)		+= sbi-ipi.o
 ifeq ($(CONFIG_RISCV_SBI), y)
 obj-$(CONFIG_SMP) += cpu_ops_sbi.o
 endif
diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
index df84e0c13db1..0f662b0113f3 100644
--- a/arch/riscv/kernel/cpu-hotplug.c
+++ b/arch/riscv/kernel/cpu-hotplug.c
@@ -13,6 +13,7 @@
 #include <asm/irq.h>
 #include <asm/cpu_ops.h>
 #include <asm/sbi.h>
+#include <asm/smp.h>
 
 void cpu_stop(void);
 void arch_cpu_idle_dead(void)
@@ -47,6 +48,7 @@ int __cpu_disable(void)
 
 	remove_cpu_topology(cpu);
 	set_cpu_online(cpu, false);
+	riscv_ipi_disable();
 	irq_migrate_all_off_this_cpu();
 
 	return ret;
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 7207fa08d78f..2817900a63e8 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -21,4 +21,5 @@ void __init init_IRQ(void)
 	irqchip_init();
 	if (!handle_arch_irq)
 		panic("No interrupt controller found.");
+	riscv_ipi_setup();
 }
diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
new file mode 100644
index 000000000000..dc284ad3551c
--- /dev/null
+++ b/arch/riscv/kernel/sbi-ipi.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SBI based IPI support.
+ *
+ * Copyright (c) 2021 Western Digital Corporation or its affiliates.
+ */
+
+#define pr_fmt(fmt) "riscv-sbi-ipi: " fmt
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/smp.h>
+#include <asm/sbi.h>
+
+static int intc_parent_irq __ro_after_init;
+static struct irq_domain *sbi_ipi_domain __ro_after_init;
+static DEFINE_PER_CPU(unsigned long, sbi_ipi_bits);
+
+static void sbi_ipi_dummy(struct irq_data *d)
+{
+}
+
+static void sbi_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
+{
+	int cpu;
+	struct cpumask hartid_mask;
+
+	/* Barrier before doing atomic bit update to IPI bits */
+	smp_mb__before_atomic();
+	for_each_cpu(cpu, mask)
+		set_bit(d->hwirq, per_cpu_ptr(&sbi_ipi_bits, cpu));
+	/* Barrier after doing atomic bit update to IPI bits */
+	smp_mb__after_atomic();
+
+	riscv_cpuid_to_hartid_mask(mask, &hartid_mask);
+
+	sbi_send_ipi(cpumask_bits(&hartid_mask));
+}
+
+static struct irq_chip sbi_ipi_chip = {
+	.name		= "RISC-V SBI IPI",
+	.irq_mask	= sbi_ipi_dummy,
+	.irq_unmask	= sbi_ipi_dummy,
+	.ipi_send_mask	= sbi_ipi_send_mask,
+};
+
+static int sbi_ipi_domain_map(struct irq_domain *d, unsigned int irq,
+			      irq_hw_number_t hwirq)
+{
+	irq_set_percpu_devid(irq);
+	irq_domain_set_info(d, irq, hwirq, &sbi_ipi_chip, d->host_data,
+			    handle_percpu_devid_irq, NULL, NULL);
+
+	return 0;
+}
+
+static int sbi_ipi_domain_alloc(struct irq_domain *d, unsigned int virq,
+				unsigned int nr_irqs, void *arg)
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
+		ret = sbi_ipi_domain_map(d, virq + i, hwirq + i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops sbi_ipi_domain_ops = {
+	.translate	= irq_domain_translate_onecell,
+	.alloc		= sbi_ipi_domain_alloc,
+	.free		= irq_domain_free_irqs_top,
+};
+
+static void sbi_ipi_handle_irq(struct irq_desc *desc)
+{
+	int err;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long irqs, *bits = this_cpu_ptr(&sbi_ipi_bits);
+	irq_hw_number_t hwirq;
+
+	chained_irq_enter(chip, desc);
+
+	while (true) {
+		csr_clear(CSR_IP, IE_SIE);
+
+		/* Order bit clearing and data access. */
+		mb();
+
+		irqs = xchg(bits, 0);
+		if (!irqs)
+			goto done;
+
+		for_each_set_bit(hwirq, &irqs, BITS_PER_LONG) {
+			err = generic_handle_domain_irq(sbi_ipi_domain,
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
+static int sbi_ipi_dying_cpu(unsigned int cpu)
+{
+	disable_percpu_irq(intc_parent_irq);
+	return 0;
+}
+
+static int sbi_ipi_starting_cpu(unsigned int cpu)
+{
+	enable_percpu_irq(intc_parent_irq,
+			  irq_get_trigger_type(intc_parent_irq));
+	return 0;
+}
+
+static int __init sbi_ipi_set_virq(void)
+{
+	int virq;
+	struct irq_fwspec ipi = {
+		.fwnode		= sbi_ipi_domain->fwnode,
+		.param_count	= 1,
+		.param[0]	= 0,
+	};
+
+	virq = __irq_domain_alloc_irqs(sbi_ipi_domain, -1, BITS_PER_LONG,
+				       NUMA_NO_NODE, &ipi,
+				       false, NULL);
+	if (virq <= 0) {
+		pr_err("unable to alloc IRQs from SBI IPI IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	riscv_ipi_set_virq_range(virq, BITS_PER_LONG);
+
+	return 0;
+}
+
+static int __init sbi_ipi_domain_init(struct irq_domain *domain)
+{
+	struct irq_fwspec swi = {
+		.fwnode		= domain->fwnode,
+		.param_count	= 1,
+		.param[0]	= RV_IRQ_SOFT,
+	};
+
+	intc_parent_irq = __irq_domain_alloc_irqs(domain, -1, 1,
+						  NUMA_NO_NODE, &swi,
+						  false, NULL);
+	if (intc_parent_irq <= 0) {
+		pr_err("unable to alloc IRQ from INTC IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	irq_set_chained_handler(intc_parent_irq, sbi_ipi_handle_irq);
+
+	sbi_ipi_domain = irq_domain_add_linear(NULL, BITS_PER_LONG,
+						&sbi_ipi_domain_ops, NULL);
+	if (!sbi_ipi_domain) {
+		pr_err("unable to add SBI IPI IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+			  "irqchip/riscv/sbi-ipi:starting",
+			  sbi_ipi_starting_cpu, sbi_ipi_dying_cpu);
+
+	return sbi_ipi_set_virq();
+}
+
+void __init sbi_ipi_init(void)
+{
+	struct irq_domain *domain = NULL;
+	struct device_node *cpu, *child;
+
+	for_each_of_cpu_node(cpu) {
+		child = of_get_compatible_child(cpu, "riscv,cpu-intc");
+		if (!child) {
+			pr_err("failed to find INTC node [%pOF]\n", cpu);
+			return;
+		}
+
+		domain = irq_find_host(child);
+		of_node_put(child);
+		if (domain)
+			break;
+	}
+	if (!domain) {
+		pr_err("can't find INTC IRQ domain\n");
+		return;
+	}
+
+	if (sbi_ipi_domain_init(domain))
+		pr_err("failed to register IPI domain\n");
+	else
+		pr_info("registered IPI domain\n");
+}
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 8aeca26198f2..372aa7e181d5 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -589,25 +589,6 @@ long sbi_get_mimpid(void)
 	return __sbi_base_ecall(SBI_EXT_BASE_GET_MIMPID);
 }
 
-static void sbi_send_cpumask_ipi(const struct cpumask *target)
-{
-	struct cpumask hartid_mask;
-
-	riscv_cpuid_to_hartid_mask(target, &hartid_mask);
-
-	sbi_send_ipi(cpumask_bits(&hartid_mask));
-}
-
-static void sbi_ipi_clear(void)
-{
-	csr_clear(CSR_IP, IE_SIE);
-}
-
-static const struct riscv_ipi_ops sbi_ipi_ops = {
-	.ipi_inject = sbi_send_cpumask_ipi,
-	.ipi_clear = sbi_ipi_clear
-};
-
 void __init sbi_init(void)
 {
 	int ret;
@@ -654,6 +635,4 @@ void __init sbi_init(void)
 		__sbi_send_ipi	= __sbi_send_ipi_v01;
 		__sbi_rfence	= __sbi_rfence_v01;
 	}
-
-	riscv_set_ipi_ops(&sbi_ipi_ops);
 }
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 547dc508f7d1..6c9873b7d60e 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/delay.h>
+#include <linux/irq.h>
 #include <linux/irq_work.h>
 
 #include <asm/sbi.h>
@@ -41,11 +42,9 @@ void __init smp_setup_processor_id(void)
 	cpuid_to_hartid_map(0) = boot_cpu_hartid;
 }
 
-/* A collection of single bit ipi messages.  */
-static struct {
-	unsigned long stats[IPI_MAX] ____cacheline_aligned;
-	unsigned long bits ____cacheline_aligned;
-} ipi_data[NR_CPUS] __cacheline_aligned;
+static int ipi_virq_base __ro_after_init;
+static int nr_ipi __ro_after_init = IPI_MAX;
+static struct irq_desc *ipi_desc[IPI_MAX] __read_mostly;
 
 int riscv_hartid_to_cpuid(int hartid)
 {
@@ -87,46 +86,14 @@ static void ipi_stop(void)
 		wait_for_interrupt();
 }
 
-static const struct riscv_ipi_ops *ipi_ops __ro_after_init;
-
-void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops)
-{
-	ipi_ops = ops;
-}
-EXPORT_SYMBOL_GPL(riscv_set_ipi_ops);
-
-void riscv_clear_ipi(void)
-{
-	if (ipi_ops && ipi_ops->ipi_clear)
-		ipi_ops->ipi_clear();
-}
-EXPORT_SYMBOL_GPL(riscv_clear_ipi);
-
 static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
 {
-	int cpu;
-
-	smp_mb__before_atomic();
-	for_each_cpu(cpu, mask)
-		set_bit(op, &ipi_data[cpu].bits);
-	smp_mb__after_atomic();
-
-	if (ipi_ops && ipi_ops->ipi_inject)
-		ipi_ops->ipi_inject(mask);
-	else
-		pr_warn("SMP: IPI inject method not available\n");
+	__ipi_send_mask(ipi_desc[op], mask);
 }
 
 static void send_ipi_single(int cpu, enum ipi_message_type op)
 {
-	smp_mb__before_atomic();
-	set_bit(op, &ipi_data[cpu].bits);
-	smp_mb__after_atomic();
-
-	if (ipi_ops && ipi_ops->ipi_inject)
-		ipi_ops->ipi_inject(cpumask_of(cpu));
-	else
-		pr_warn("SMP: IPI inject method not available\n");
+	__ipi_send_mask(ipi_desc[op], cpumask_of(cpu));
 }
 
 #ifdef CONFIG_IRQ_WORK
@@ -136,62 +103,96 @@ void arch_irq_work_raise(void)
 }
 #endif
 
-void handle_IPI(struct pt_regs *regs)
+static irqreturn_t handle_IPI(int irq, void *data)
 {
-	struct pt_regs *old_regs = set_irq_regs(regs);
-	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
-	unsigned long *stats = ipi_data[smp_processor_id()].stats;
+	int ipi = irq - ipi_virq_base;
+
+	switch (ipi) {
+	case IPI_RESCHEDULE:
+		scheduler_ipi();
+		break;
+	case IPI_CALL_FUNC:
+		generic_smp_call_function_interrupt();
+		break;
+	case IPI_CPU_STOP:
+		ipi_stop();
+		break;
+	case IPI_IRQ_WORK:
+		irq_work_run();
+		break;
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+	case IPI_TIMER:
+		tick_receive_broadcast();
+		break;
+#endif
+	default:
+		pr_warn("CPU%d: unhandled IPI%d\n", smp_processor_id(), ipi);
+		break;
+	};
+
+	return IRQ_HANDLED;
+}
 
-	irq_enter();
+void riscv_ipi_enable(void)
+{
+	int i;
 
-	riscv_clear_ipi();
+	if (WARN_ON_ONCE(!ipi_virq_base))
+		return;
 
-	while (true) {
-		unsigned long ops;
+	for (i = 0; i < nr_ipi; i++)
+		enable_percpu_irq(ipi_virq_base + i, 0);
+}
 
-		/* Order bit clearing and data access. */
-		mb();
+void riscv_ipi_disable(void)
+{
+	int i;
 
-		ops = xchg(pending_ipis, 0);
-		if (ops == 0)
-			goto done;
+	if (WARN_ON_ONCE(!ipi_virq_base))
+		return;
 
-		if (ops & (1 << IPI_RESCHEDULE)) {
-			stats[IPI_RESCHEDULE]++;
-			scheduler_ipi();
-		}
+	for (i = 0; i < nr_ipi; i++)
+		disable_percpu_irq(ipi_virq_base + i);
+}
 
-		if (ops & (1 << IPI_CALL_FUNC)) {
-			stats[IPI_CALL_FUNC]++;
-			generic_smp_call_function_interrupt();
-		}
+void riscv_ipi_setup(void)
+{
+	int i, err;
 
-		if (ops & (1 << IPI_CPU_STOP)) {
-			stats[IPI_CPU_STOP]++;
-			ipi_stop();
-		}
+	/* SBI based IPIs is our last option */
+	if (!ipi_virq_base)
+		sbi_ipi_init();
 
-		if (ops & (1 << IPI_IRQ_WORK)) {
-			stats[IPI_IRQ_WORK]++;
-			irq_work_run();
-		}
+	/* If still don't have IPIs then do nothing */
+	if (!ipi_virq_base) {
+		pr_info("SMP: IPIs not available\n");
+		return;
+	}
 
-#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
-		if (ops & (1 << IPI_TIMER)) {
-			stats[IPI_TIMER]++;
-			tick_receive_broadcast();
-		}
-#endif
-		BUG_ON((ops >> IPI_MAX) != 0);
+	/* Request IPIs */
+	for (i = 0; i < nr_ipi; i++) {
+		err = request_percpu_irq(ipi_virq_base + i, handle_IPI,
+					 "IPI", &ipi_virq_base);
+		WARN_ON(err);
 
-		/* Order data access and bit testing. */
-		mb();
+		ipi_desc[i] = irq_to_desc(ipi_virq_base + i);
+		irq_set_status_flags(ipi_virq_base + i, IRQ_HIDDEN);
 	}
 
-done:
-	irq_exit();
-	set_irq_regs(old_regs);
+	/* Enabled IPIs for boot CPU immediately */
+	riscv_ipi_enable();
+}
+
+void riscv_ipi_set_virq_range(int virq, int nr)
+{
+	if (WARN_ON(ipi_virq_base))
+		return;
+
+	WARN_ON(nr < IPI_MAX);
+	nr_ipi = min(nr, IPI_MAX);
+	ipi_virq_base = virq;
 }
+EXPORT_SYMBOL_GPL(riscv_ipi_set_virq_range);
 
 static const char * const ipi_names[] = {
 	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
@@ -209,7 +210,7 @@ void show_ipi_stats(struct seq_file *p, int prec)
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
 			   prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10lu ", ipi_data[cpu].stats[i]);
+			seq_printf(p, "%10u ", irq_desc_kstat_cpu(ipi_desc[i], cpu));
 		seq_printf(p, " %s\n", ipi_names[i]);
 	}
 }
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index bd82375db51a..a64b5e194e1e 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -159,12 +159,12 @@ asmlinkage __visible void smp_callin(void)
 	struct mm_struct *mm = &init_mm;
 	unsigned int curr_cpuid = smp_processor_id();
 
-	riscv_clear_ipi();
-
 	/* All kernel threads share the same mm context.  */
 	mmgrab(mm);
 	current->active_mm = mm;
 
+	riscv_ipi_enable();
+
 	notify_cpu_starting(curr_cpuid);
 	numa_add_cpu(curr_cpuid);
 	update_siblings_masks(curr_cpuid);
diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 6cfe2ab73eb0..3b68ed53fe4a 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -30,7 +30,6 @@
 #define CLINT_TIMER_VAL_OFF	0xbff8
 
 /* CLINT manages IPI and Timer for RISC-V M-mode  */
-static u32 __iomem *clint_ipi_base;
 static u64 __iomem *clint_timer_cmp;
 static u64 __iomem *clint_timer_val;
 static unsigned long clint_timer_freq;
@@ -41,24 +40,6 @@ u64 __iomem *clint_time_val;
 EXPORT_SYMBOL(clint_time_val);
 #endif
 
-static void clint_send_ipi(const struct cpumask *target)
-{
-	unsigned int cpu;
-
-	for_each_cpu(cpu, target)
-		writel(1, clint_ipi_base + cpuid_to_hartid_map(cpu));
-}
-
-static void clint_clear_ipi(void)
-{
-	writel(0, clint_ipi_base + cpuid_to_hartid_map(smp_processor_id()));
-}
-
-static struct riscv_ipi_ops clint_ipi_ops = {
-	.ipi_inject = clint_send_ipi,
-	.ipi_clear = clint_clear_ipi,
-};
-
 #ifdef CONFIG_64BIT
 #define clint_get_cycles()	readq_relaxed(clint_timer_val)
 #else
@@ -189,7 +170,6 @@ static int __init clint_timer_init_dt(struct device_node *np)
 		return -ENODEV;
 	}
 
-	clint_ipi_base = base + CLINT_IPI_OFF;
 	clint_timer_cmp = base + CLINT_TIMER_CMP_OFF;
 	clint_timer_val = base + CLINT_TIMER_VAL_OFF;
 	clint_timer_freq = riscv_timebase;
@@ -228,9 +208,6 @@ static int __init clint_timer_init_dt(struct device_node *np)
 		goto fail_free_irq;
 	}
 
-	riscv_set_ipi_ops(&clint_ipi_ops);
-	clint_clear_ipi();
-
 	return 0;
 
 fail_free_irq:
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 8017f6d32d52..65d9c5b0ddb8 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -26,20 +26,7 @@ static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 	if (unlikely(cause >= BITS_PER_LONG))
 		panic("unexpected interrupt cause");
 
-	switch (cause) {
-#ifdef CONFIG_SMP
-	case RV_IRQ_SOFT:
-		/*
-		 * We only use software interrupts to pass IPIs, so if a
-		 * non-SMP system gets one, then we don't know what to do.
-		 */
-		handle_IPI(regs);
-		break;
-#endif
-	default:
-		handle_domain_irq(intc_domain, cause, regs);
-		break;
-	}
+	handle_domain_irq(intc_domain, cause, regs);
 }
 
 /*
@@ -59,18 +46,6 @@ static void riscv_intc_irq_unmask(struct irq_data *d)
 	csr_set(CSR_IE, BIT(d->hwirq));
 }
 
-static int riscv_intc_cpu_starting(unsigned int cpu)
-{
-	csr_set(CSR_IE, BIT(RV_IRQ_SOFT));
-	return 0;
-}
-
-static int riscv_intc_cpu_dying(unsigned int cpu)
-{
-	csr_clear(CSR_IE, BIT(RV_IRQ_SOFT));
-	return 0;
-}
-
 static struct irq_chip riscv_intc_chip = {
 	.name = "RISC-V INTC",
 	.irq_mask = riscv_intc_irq_mask,
@@ -87,9 +62,32 @@ static int riscv_intc_domain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
+static int riscv_intc_domain_alloc(struct irq_domain *domain,
+				   unsigned int virq, unsigned int nr_irqs,
+				   void *arg)
+{
+	int i, ret;
+	irq_hw_number_t hwirq;
+	unsigned int type = IRQ_TYPE_NONE;
+	struct irq_fwspec *fwspec = arg;
+
+	ret = irq_domain_translate_onecell(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++) {
+		ret = riscv_intc_domain_map(domain, virq + i, hwirq + i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct irq_domain_ops riscv_intc_domain_ops = {
 	.map	= riscv_intc_domain_map,
 	.xlate	= irq_domain_xlate_onecell,
+	.alloc	= riscv_intc_domain_alloc
 };
 
 static int __init riscv_intc_init(struct device_node *node,
@@ -125,11 +123,6 @@ static int __init riscv_intc_init(struct device_node *node,
 		return rc;
 	}
 
-	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_STARTING,
-			  "irqchip/riscv/intc:starting",
-			  riscv_intc_cpu_starting,
-			  riscv_intc_cpu_dying);
-
 	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
 
 	return 0;
-- 
2.25.1

