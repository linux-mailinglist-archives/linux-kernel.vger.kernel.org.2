Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B903ACB27
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhFRMlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:41:51 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2355 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbhFRMlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624019976; x=1655555976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=p9SPIifpgAUMue5YIizFyxOYWdR8ULw0sXEuwEa3Ph8=;
  b=osHurtk4uxmJodP1cj8fTqrsUxKc2br/uTx/FNo6SxSSQEdzMi2yCZjM
   luVGyKM+ClqCoiJX2YIdJb8VHXM43frLN8i0EmHw3d3ZUJAOUhEvpR589
   7GiLMwtAzgrpAVSisI/j+YTxi4VTn7mxyJOyBq5gUGbu392qCsjQ/nhCN
   bT/BT2lrsdAO7nLfQPpNEmODXD13uZDUK5O9zCqF5QyLT3y3FENalHJTz
   T9o0E/bJfFnglGo+rla5nv++R9GBeUaSAgG0vUn60SF7wK/zNf8MpMfDv
   3u+zFjo7RU44oeh5elfGj9nHX3jBnLlVYShQ3DqlwxcZjMOzjN5WwpV9A
   Q==;
IronPort-SDR: KIOtjBgiItoyzOyVC2aqmfGV9m+FcAUUbq8vD2K70VUs7YA0lADfSej5xlfl2JfobmfolXDQ1f
 bJVjfS1JPhuKr7wt3vFxU5PvLFXLpSmmhqPdtLHu1zE7SrgxytE0UeUyrIDfjn75czL/IDoXmm
 TsR4jFZwKGMu6VGSDGQLtCnoU2KiDdCNRJDDM4YDGSNU/Wz39O1lxGc8HtOfVqwH1dHJD5rKNG
 vouXy0A1MtD+AhQnicJnVgF0oFAjIO2fOXlR2yyaTAmCEnF3sl/tgnb7S/pu35H9hzCiD2+gW6
 zEo=
X-IronPort-AV: E=Sophos;i="5.83,283,1616428800"; 
   d="scan'208";a="172868582"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2021 20:39:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMcOySct3iB4tGzrKWCsysaCamxsjav2NNaju0qT5ANkCRIJuJYHQ6BrNL+JwQTCelWyIdz7ZK5Y+4xYjgxNTeqNI5mUtSxOPtZgnUYoPz+7ckmUow7cd8iWdtRFVmU3ZwReg9swxGxUCwZwzX8PNPm3pJsqbjvKknDp8kNd01R1FSYJIKm7fNHkwhjV1RP3WaAWSfZMPJBaevMHzOQ+EfY+8lgcufnwWZJefgsg00QO3KhZtr4yTzEtcZkxdkvaZUM22KuZYwoTtTY/6NmppiLxLyVf/NejZjdf1EynT3A6SIKBnkmya8bjcOiCE1hHWU7Tl+mRnhm2ia9tmLhcFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuAeCHS8L9/8UklSJl6NJXHeOBtv2CoyzvylEjctprw=;
 b=dl0CPS3Ol8VhypRYFfjjXTf2J1cxQwmzHgM4RrYhSeflQ/ru9IG7ug1lCQhGMsIxGi/mr3MmIydlHNZVV5vuO2+gfLuRMuwHQl9MBs72yEue6tW/Lo3CKn32vHlJQgV7N3l5lYphmP4EnMVGKQHcrvtL4rehhDEcOghTp/K9g8rTXUmGXkI1U/WGvoebVAjpmif5zb90Bxl8EJQ+8UR5uXcDM6f3G8a8osxSh+RnwtEf3nXSCmrvclXG39zxMz2IHyqyEWzdSp00YkODFpGhEYk9vwHDpyM9wbR3Au6+G5h8ud3sODs5Rnqzvpib7LMxZQNfl4EkVEyurBRjELCxzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuAeCHS8L9/8UklSJl6NJXHeOBtv2CoyzvylEjctprw=;
 b=DQQgcFU1MhmDiVHD9OCgp6rvCoIPDq1494VwQoPtPPj1Rbf/2OqU66U/tMpl8JTvAIQnBQsovnTaeSLdmCT9LL7pyXs9AcPdDB55EeaGl/3oAZ76GcFhSPCg7yuxHRlIPdHPWNVQfavKNJ6RSKqXHLoTtAYJ7qhCy5N3sSkU1x0=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7843.namprd04.prod.outlook.com (2603:10b6:5:35f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 12:39:32 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 12:39:32 +0000
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
Subject: [RFC PATCH v2 03/11] RISC-V: Treat IPIs as normal Linux IRQs
Date:   Fri, 18 Jun 2021 18:08:43 +0530
Message-Id: <20210618123851.1344518-4-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618123851.1344518-1-anup.patel@wdc.com>
References: <20210618123851.1344518-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [122.171.164.186]
X-ClientProxiedBy: MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::11) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (122.171.164.186) by MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Fri, 18 Jun 2021 12:39:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1db70b4-2124-4873-58d2-08d932561eac
X-MS-TrafficTypeDiagnostic: CO6PR04MB7843:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB78436A35710921E2F15770C98D0D9@CO6PR04MB7843.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:146;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FRGyvwEpCsk/ApmlL5WsoekrB33zILDxMOy0r8K5Bw7eAbB2ezRjuijfqa+c1wUNAlzqYg3gm1uS2+eNcXi2+KY0N3tf+I5sh7R1LnAHpYo97GWMQ0hYRIgA2H78B+1AN2b9h0Nx+sDvWEHhAS9Nz47TCGleZd5FDeRSyj5nucvLGPiJMpMVhg/PaPBy7kMGB6ntH8L1FVll/6MSsFTor/anwHx0kRyKjIHiByXmRSvlcmkzq9KhQQRpUhuBjCc9IbUa3BklP4VieEKomZoyOGokT1RVOVR9+5i8BFaTJENNrJzRUFAjthwihh8glrhFNu3F2iJ0c7bAvkEveYmR4iJpqffS95KxTl6tc9TvuYOkP1Qoyl0t1m3bGbZMcXLzVwvfYpmoeR2jRp7+8304vh0sEXrUDgy+ytqurerGmcIbEbiyGh2mnAyQycUkUu4gJYFVSgf7O6QqCaNKo68eqn/ong4FWf7WqaaSayyJH9N4TgleMWuax0AeBtXwOOmhvsE1BQQnyvZLKlfHuGxc4G+2jNKwKHCwvtkcUAq+NGc33nPHhUHzfKWhcZhVnJpcpjUGCY5U7c5u+xrhBmeE/kD03m3b/5zTu4sF1Kv/uC6Dv+4y3cutBYWzsCoM43m8WzasThdaPKuwJCUBhgN8Sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(83380400001)(316002)(4326008)(16526019)(186003)(110136005)(54906003)(52116002)(26005)(55016002)(2616005)(956004)(2906002)(5660300002)(7416002)(30864003)(478600001)(38100700002)(38350700002)(8676002)(66556008)(8886007)(44832011)(86362001)(8936002)(36756003)(1076003)(66476007)(66946007)(6666004)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oaJuUirsQNiNJDmGMKZmQ+Gb3o9RQZ5DR461s9aZz3XLYslFCTQq2u3Ff1cw?=
 =?us-ascii?Q?fswiKT6Wcc5oQoeZbnbFGlHYy0fZQdRHOVR/ciTu93kg9TWoT13RX3VE8Cf5?=
 =?us-ascii?Q?RhjJsTYolBKtOc5TtH7hNXhH+xsyKSQ6J93PtclVRUimlAjY+B3v2fVWi4ak?=
 =?us-ascii?Q?C7lm77h2RG8Uffa+fU2qb3HyBdoxaxDV0I5rbii6TgABnTAYcl3YiaUYEycu?=
 =?us-ascii?Q?y7fKjd8uK3rhP0q3zqU4p5ha2VL23mdS0lSsOJaqr6xj+t/zUuvj7GDIBHCT?=
 =?us-ascii?Q?ITtlq6uT+BR5QanEiO2n3R1Hz7Wjfo2kDQWauJVWOutfXF3Ua1pB/8BohFZI?=
 =?us-ascii?Q?FxCaHUk+8IjddsUkm1+5aytsuuSv8QRBVfOBA1V7avYXhMBB2FaCcGqX4Udh?=
 =?us-ascii?Q?Kln148dmEjc/G1bHfAn31ZXKbZglY80RuE5AJdhPhrjRXybwLHudt7s1sz82?=
 =?us-ascii?Q?HNAWAee9t+ExAVJVfP3fdLsGdKMxpcYTHs30w5Y3gUkR/GSz1ztvx0Ftyh2X?=
 =?us-ascii?Q?VD6wJ0sTqr40/wRdFqgY7D2BRt1aaP7tJbQ8flK/xLLXJpz1QxAc3DQihHZc?=
 =?us-ascii?Q?xIi2bM14vUIv+bWOyYkjv8zxWUHS03cqygbZSbwwplokqZlBBiuPPfFDsMEl?=
 =?us-ascii?Q?L9n+ItcYq1/NLXj/O71uB+6eqeBGP9sdt1VLR2y9LWuXdq2c2HpbXA8nD/o0?=
 =?us-ascii?Q?S0RQ8BIHfSbNmW8ycTGFvTOLVxgRTE1Mv+WJOT2w1d7rcCK3In6yuhlwFPfb?=
 =?us-ascii?Q?FwF6pV+e8/mOOLnLI9Fs/l7e+jkQ+ZSCi6ZqzeYu0k0IlJvEV82iilHaW7XP?=
 =?us-ascii?Q?mrLDTKU6cVPe9GSqKqvNIZcPQKxzQuwI87MqmO6IOi6qINhCSH9RGnOAXN+4?=
 =?us-ascii?Q?ClQICCzHn/EksZ6I2akTr6XAZhbnnqKTJRg8c3gqqhH4drXkXN5O+LYGoBOe?=
 =?us-ascii?Q?zPKcJoHWacBCR4lW08LILG/JgXq5BW8jR29RaPMtVZM4VqohyJehLrMIzTXd?=
 =?us-ascii?Q?04pMBhUMH90a0sbADgSgWoSIGUUQBd5jbih+iYseBCpISwrWa/FZ+9Z45HpZ?=
 =?us-ascii?Q?K7AK2mzONCWSnwPXuq/6hY/TRfRvtMfmelgfqtPpOtusIPlLYr0fwRCSwj/A?=
 =?us-ascii?Q?m52hrVvxUiMRLbFg5ITRAgs4BgBTTAhcLJacLi3nwkSuoPDvwRSxnxVk5JLF?=
 =?us-ascii?Q?gBQX5z3xjlmo2OTROHD4lGHmiROFHD7PDEvmmpbijgv/ZsTG+fo/PLJatRzG?=
 =?us-ascii?Q?shODwnm7BjsQ7oDU4ad2VIt+mQRl7cZevFQ4idw27J3mB8hLxElBKYk4s2Xs?=
 =?us-ascii?Q?uHq2ieE2tvIauWuGTNa12ARN?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1db70b4-2124-4873-58d2-08d932561eac
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 12:39:32.0828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sfe+2WCvfui3dAPIRttZI3TuklbEBke7DgHEM7sLyAGCuV+HS4Mzl/2ZC4Qjs9aV1tKinzGsxmqgS1pDWGM0sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7843
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

We extend the RISC-V IPI handling as-per above approach so that arch
specific IPI handling methods (struct riscv_ipi_ops) can be removed
and the IPI handling is totally contained Linux within irqchip drivers.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/Kconfig                |   1 +
 arch/riscv/include/asm/sbi.h      |   2 +
 arch/riscv/include/asm/smp.h      |  34 +++--
 arch/riscv/kernel/Makefile        |   1 +
 arch/riscv/kernel/cpu-hotplug.c   |   2 +
 arch/riscv/kernel/irq.c           |   1 +
 arch/riscv/kernel/sbi-ipi.c       | 223 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/sbi.c           |  21 ---
 arch/riscv/kernel/smp.c           | 157 ++++++++++-----------
 arch/riscv/kernel/smpboot.c       |   4 +-
 drivers/clocksource/timer-clint.c |  23 ---
 drivers/irqchip/irq-riscv-intc.c  |  55 ++++----
 12 files changed, 352 insertions(+), 172 deletions(-)
 create mode 100644 arch/riscv/kernel/sbi-ipi.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e7137d93119a..2afc9df7176f 100644
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
index d3081e4d9600..210c783c8136 100644
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
index 000000000000..6cc0ea95e1af
--- /dev/null
+++ b/arch/riscv/kernel/sbi-ipi.c
@@ -0,0 +1,223 @@
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
+static void sbi_ipi_dummy_mask_unmask(struct irq_data *d)
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
+	.irq_mask	= sbi_ipi_dummy_mask_unmask,
+	.irq_unmask	= sbi_ipi_dummy_mask_unmask,
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
+	int irq;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long irqs, *bits = this_cpu_ptr(&sbi_ipi_bits);
+	irq_hw_number_t hwirq;
+
+	chained_irq_enter(chip, desc);
+
+	csr_clear(CSR_IP, IE_SIE);
+
+	while (true) {
+		/* Order bit clearing and data access. */
+		mb();
+
+		irqs = xchg(bits, 0);
+		if (!irqs)
+			goto done;
+
+		for (hwirq = 0; hwirq < BITS_PER_LONG; hwirq++) {
+			if (!(BIT(hwirq) & irqs))
+				continue;
+
+			irq = irq_find_mapping(sbi_ipi_domain, hwirq);
+			if (unlikely(irq <= 0))
+				pr_warn_ratelimited(
+					"can't find mapping for hwirq %lu\n",
+					hwirq);
+			else
+				generic_handle_irq(irq);
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
+static int __init sbi_ipi_domain_init(struct device_node *node,
+					struct irq_domain *domain)
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
+	sbi_ipi_domain = irq_domain_add_linear(node, BITS_PER_LONG,
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
+	struct device_node *cpu, *child, *node = NULL;
+
+	for_each_of_cpu_node(cpu) {
+		child = of_get_compatible_child(cpu, "riscv,cpu-intc");
+		if (!child) {
+			pr_err("failed to find INTC node [%pOF]\n", cpu);
+			return;
+		}
+
+		domain = irq_find_host(child);
+		if (domain) {
+			node = cpu;
+			break;
+		}
+
+		of_node_put(child);
+	}
+	if (!domain || !node) {
+		pr_err("can't find INTC IRQ domain\n");
+		return;
+	}
+
+	if (sbi_ipi_domain_init(node, domain))
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
index eea0c9d11d9f..26d563615f53 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -18,6 +18,7 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/delay.h>
+#include <linux/irq.h>
 #include <linux/irq_work.h>
 
 #include <asm/sbi.h>
@@ -42,11 +43,9 @@ void __init smp_setup_processor_id(void)
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
@@ -88,46 +87,14 @@ static void ipi_stop(void)
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
-		pr_warn("IPI inject method not available\n");
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
-		pr_warn("IPI inject method not available\n");
+	__ipi_send_mask(ipi_desc[op], cpumask_of(cpu));
 }
 
 #ifdef CONFIG_IRQ_WORK
@@ -137,62 +104,90 @@ void arch_irq_work_raise(void)
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
 
-	irq_enter();
+	return IRQ_HANDLED;
+}
 
-	riscv_clear_ipi();
+void riscv_ipi_enable(void)
+{
+	int i;
 
-	while (true) {
-		unsigned long ops;
+	if (WARN_ON_ONCE(!ipi_virq_base))
+		return;
 
-		/* Order bit clearing and data access. */
-		mb();
+	for (i = 0; i < nr_ipi; i++)
+		enable_percpu_irq(ipi_virq_base + i, 0);
+}
 
-		ops = xchg(pending_ipis, 0);
-		if (ops == 0)
-			goto done;
+void riscv_ipi_disable(void)
+{
+	int i;
 
-		if (ops & (1 << IPI_RESCHEDULE)) {
-			stats[IPI_RESCHEDULE]++;
-			scheduler_ipi();
-		}
+	if (WARN_ON_ONCE(!ipi_virq_base))
+		return;
 
-		if (ops & (1 << IPI_CALL_FUNC)) {
-			stats[IPI_CALL_FUNC]++;
-			generic_smp_call_function_interrupt();
-		}
+	for (i = 0; i < nr_ipi; i++)
+		disable_percpu_irq(ipi_virq_base + i);
+}
 
-		if (ops & (1 << IPI_CPU_STOP)) {
-			stats[IPI_CPU_STOP]++;
-			ipi_stop();
-		}
+void riscv_ipi_setup(void)
+{
+	int i, err;
 
-		if (ops & (1 << IPI_IRQ_WORK)) {
-			stats[IPI_IRQ_WORK]++;
-			irq_work_run();
-		}
+	/* SBI based IPIs is our last option */
+	if (!ipi_virq_base)
+		sbi_ipi_init();
 
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
@@ -210,7 +205,7 @@ void show_ipi_stats(struct seq_file *p, int prec)
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
 			   prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10lu ", ipi_data[cpu].stats[i]);
+			seq_printf(p, "%10u ", irq_desc_kstat_cpu(ipi_desc[i], cpu));
 		seq_printf(p, " %s\n", ipi_names[i]);
 	}
 }
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 9a408e2942ac..b181d981a960 100644
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

