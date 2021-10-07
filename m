Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40877425337
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241472AbhJGMjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:39:06 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:29311 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241443AbhJGMjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633610230; x=1665146230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=0rpjkvTuNvg3nJWP8vJa0VqWQfbFnYcxfveSvgcj6uc=;
  b=oRvJXFhodTuJJ1QQP83oakYfugmcPtMPDzaE0JGhaJ9meJvRM+fy5SYy
   VrSL3y7eDafSud4Yahx8nJLl2IqF0sZl21dQ2r2RTmJ03JBm16vWqEJFh
   r20aYakn14YOzzboISNzfNuy5UaoHAJJiMlCiMsCL7yWNpMoSBBiMglao
   7fRX4xT2mPa1gscq21BGpbelsbnkbR353GewE7QfEu9l4VPX1ydZ0qSxk
   J2zwWGtgKX4ziwLe/F83dkUMUhmoCn2sUdkG+aqGs7HDYCLlpbdEdt/Rt
   GFmwDLTCjIPTzRNoIAJC2k6HtYxnk1ge763uz1LzPGWDp/2uXXpx9+2za
   A==;
X-IronPort-AV: E=Sophos;i="5.85,354,1624291200"; 
   d="scan'208";a="285991603"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2021 20:37:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R27Ov3eE9X/7jE+vd+SJR1x//Nn2NF9W8eD5FhJ4FT1UQ8C8u4dPEPBfIFScqcdvHSaVsK4yeFe4dbkSZ25XEI8GsO1VoTjTkSG5SiVl9wxqnhtMypDqw2WXkmR3CeRzKFeoXkeFB6O2Gne8fPu3VWkI+437sAIUd7IRA8wG6535Y1lx+j+Pi+o/UslF2g28A+8bUWt1Fs2sKz7XXxr49S7peGsy9/2kYAHDtgq0VF6WmdAvPdZtD3eqwpmRpO5N+KhpjRW1Z7uo7LBpTZUW5X9/eBOKt+d+ld9/eDGxcIO3ZbfLzTPsAbj2tZCx+VllBaRjhK147S5w3bUSnwspxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlcZedpb+bGJlRur94ZauG6rsKIkYA0WQBEPZkgbWN0=;
 b=QjqzoCEfwmnce88LU0RKdipKcQzskk2AP1YwpGz/rVZrwL3s95gkbLfCC4G02frXmmwKhBQfaJ6YrMgE1xC+mbLLtTklDV54OVr5gwI/Aih2ub2ZUyY3H4djkrxzCYVLoFLsqO0OAxKPMK8A+DenZ8AHEn4k5mN0x5l3gxAwEhk7KNFPdmhBjNVKmyOiawmK9G0gYhMHtivEhqnGjzAtB9K0CgwX/Gl6ASZ2S1ZOjwiWOxz+huvKa1EphS5j4j7zqnGBUtfFdd23DxNKdrLDiIr3Dskw4DcjEAlGOuAytq8MnCoUAzZdkgaA1Rd49kImu3qqGtZVx3Y2+JJgTWLMZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlcZedpb+bGJlRur94ZauG6rsKIkYA0WQBEPZkgbWN0=;
 b=HaesUMnN4b5oMoE03Cw1ky43iM4xOmNJRJjgjNVJUZIVNbrFu+EzCL6x7ztlphzZz/sTIPnkUZg3mwZB0V8Uw6G3tl98Ds0TTzAf00UGOg9PXKRpJtvQQgV9MrqsBqx9XOgx/+ci8+jW7TiYaUMHJ2xpeQARw64JiFGI1JYhuQw=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7777.namprd04.prod.outlook.com (2603:10b6:5:354::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 12:37:06 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 12:37:06 +0000
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
Subject: [RFC PATCH v4 02/10] RISC-V: Treat IPIs as normal Linux IRQs
Date:   Thu,  7 Oct 2021 18:06:24 +0530
Message-Id: <20211007123632.697666-3-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007123632.697666-1-anup.patel@wdc.com>
References: <20211007123632.697666-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::31) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (171.61.64.222) by MAXPR0101CA0045.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 12:37:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76fd6974-d8a2-48b9-b2b6-08d9898f2c1d
X-MS-TrafficTypeDiagnostic: CO6PR04MB7777:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7777BC267C38292700046E9F8DB19@CO6PR04MB7777.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:146;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ar/1A0IyWbZ6ePVxdwvNlvtzYXAebg7CSQFddwDK7KaA5eFW8ZQdJMfxPPRJppOuV8Iro6p4dFV22WZZkDdCzbnbTy/hMdluFYalOZhj5dfFHoLKroWwVHo2iUnmX9mivX3RYw1MbBrvw6SwNYsrwua6Dyg/yf5iBTPvGXz7REk+JxJDEXz74ma6L4Lg1xnSqMW3NgnQSkInaOV26iRpElHYQpfZmQBwUXu/WQOxkFzYGlrC2HW8Ypc65G9Z5Uhv01Ts8NRgBNEvAw9USG9O7+Lf8GxlNbZUeT5MeKAP6iJqygzz8omyebYX4DeLB9QEghR1V9mXxsoH00nQKre8XehkfwuenT58Nzjxmi7AskcMon9ZpFRci9eq6k+lkxoV6sdQVtVB1ECudeUNjy07bLyN6qBb9aV6m6Djq5LR+lQViwikiI07GAytrMjpOvcGH5dwGhVjkrZuJRvMyLGWUedMRtOTzGs2GeyrKYfGPDh8qG970/uLHe0RLMZqjJRPylW6oSpsJN51KrAtE/3TeXUKKwQZzEBF2RAMqGaYMDtJ26LmGzDejLAT1RosyfFHoLHhHD6Y4OZhb8eRUzGUx5MJ1+sapp3vWlGFNKILSo1eklMLH3wfbaNQXYO8FShOKl6500vOfBfbLysYZG2FsQNnwsrwJgxmGq0EKo+QIeWiqR/axhh/P8NwKaJ0ef6fZzMCp3EpnkNjMZhFS4hJZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(30864003)(54906003)(5660300002)(52116002)(1076003)(316002)(110136005)(8936002)(7696005)(2906002)(38100700002)(38350700002)(55016002)(508600001)(7416002)(86362001)(66556008)(66476007)(36756003)(4326008)(66946007)(83380400001)(8676002)(26005)(6666004)(8886007)(186003)(2616005)(956004)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ODGS7JzbeHGvyEWRaNfNPOuK9iTKBCDXrh3fv5JYSRsXnjM6ZOHYBdi6cWMP?=
 =?us-ascii?Q?LTY7DJRdRqjOqYsk1+7+ju7HAkOUFmo5YBLdYY4+H/1kMeWVHxpsQTxFBB2H?=
 =?us-ascii?Q?XqYUiuZir20ANx+fcapJDMUxbyzOO+1gTElDIsu+mBnP2xQz8x38tgZfiXdY?=
 =?us-ascii?Q?NpSDUFt0YYCsVLyHpvk0cZI9OopYdtkxO3w/0mHaaEdSp3SBiehJQeCm4ml0?=
 =?us-ascii?Q?LVzqFDhqj/Y8bL1g175ZF/0lh9jHC35FcipdpZSn38ZCzK01BFzZcwhiJBPP?=
 =?us-ascii?Q?k+G5v0ymlb1RsLfvwtEtHzedxIeXIoYobqPcm56jCsFZCQMvSQwqN7JZQHP+?=
 =?us-ascii?Q?6vEjCXcqK/8v4jLLIDYw1hlSnqwpVpbAp9MeRA5R9rLNdYsHIWmaiRxSiXPB?=
 =?us-ascii?Q?zVXXFf8+JSeKJw7HznvNoPWL4ms0xpnGF6DYePHvW4C7spCaHOUEVphs6+Yz?=
 =?us-ascii?Q?VjkCWbMHEAmry7zszTmUGQ4gQdP64G7xgVVWqgEDJrXSGam03lMtMRRrYpcW?=
 =?us-ascii?Q?jB/B8xHvmNFcfZ1p+YoTlQsKXOyuDk1440l8UI4rzFK2GLMCvXzYTZxmOda/?=
 =?us-ascii?Q?+cDCVe3JTMqelj5z3Ec4NCbapglpkXiVwIpTO2v/MmTph+I6aEWvkWnYr/f+?=
 =?us-ascii?Q?rvix1ltLnnNQgIikzH2337NKW/MRj0bHPwStyLbm/6fnx6Vjuss8cPB8lIgz?=
 =?us-ascii?Q?naZ90EiRpCIbAns5k37tUEXpzWIbod85g5+/KZeVGyvvqcI4CHHoJB60KM6A?=
 =?us-ascii?Q?r7I0yFbhLKlLRuuRw5TcbOo/wCSx7QdaXAV0GMVfxfZ3xWnjWHsSTNiX3D3m?=
 =?us-ascii?Q?2mElaweTtMQFha5O7efxbsxXaN23mL6UZNna3u+tWemuja//lMZLLRbhQbHA?=
 =?us-ascii?Q?R4csuzRDs/O62/2NytsyzJZEzKbUdxFAQtbSRHvTzPDi1l/sFg0U9z0faJw2?=
 =?us-ascii?Q?weRwJQP6pzduCgZiTHMBLDJRp7vdK0gMCuFFy16TKpJQccv3wuo/LZ5T1gF4?=
 =?us-ascii?Q?7OBNtMd7hgNz+HlxMoGlalbv72BTaXiwp8ckp35QF4+45cNTgCNYhPJ0hDj5?=
 =?us-ascii?Q?MSmlaWEdTjCnCjpLWjGdRcz/hvqrv6o8sJpO0f5O2pbjDmW66q2u6APIB4jW?=
 =?us-ascii?Q?rIsXz7fLwbv4A92hGMSonZbJjZGQSaoFaihtA3vqXkA9NsHFLjkl3tU6YXml?=
 =?us-ascii?Q?7HoanLV0yZn42tjx2aV2eBoG3JXlyuj8sqB/urHcnlrsU8eiN4X4dJ84/CGC?=
 =?us-ascii?Q?N3b2t4eLWz7ftIhhlqxmkNgi198CXo9YIST18to4sT/Zvxr0MifK3+NrmRAp?=
 =?us-ascii?Q?Nbppz/wfodlUxeA+Cq1ED/z9?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fd6974-d8a2-48b9-b2b6-08d9898f2c1d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 12:37:06.4701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Bb/J+jIxSowWvcA1MLKEQVDv8Q/CReG/+6bpDeIVG3ay7RHuM2Z/hSBZYh7JTDzoMJzA0q+LRUAepkLtpBDHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7777
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
 arch/riscv/include/asm/smp.h      |  35 +++--
 arch/riscv/kernel/Makefile        |   1 +
 arch/riscv/kernel/cpu-hotplug.c   |   3 +-
 arch/riscv/kernel/irq.c           |   3 +-
 arch/riscv/kernel/sbi-ipi.c       | 218 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/sbi.c           |  21 ---
 arch/riscv/kernel/smp.c           | 156 ++++++++++-----------
 arch/riscv/kernel/smpboot.c       |   5 +-
 drivers/clocksource/timer-clint.c |  23 ----
 drivers/irqchip/irq-riscv-intc.c  |  55 ++++----
 12 files changed, 347 insertions(+), 176 deletions(-)
 create mode 100644 arch/riscv/kernel/sbi-ipi.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 2251f27aba53..8de2afb460f7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -54,6 +54,7 @@ config RISCV
 	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IOREMAP if MMU
+	select GENERIC_IRQ_IPI
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
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
index a7d2811f3536..e5480d75b2d9 100644
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
+/* Check if IPI interrupt numbers are available */
+bool riscv_ipi_have_virq_range(void);
+
+/* Set the IPI interrupt numbers for arch (called by irqchip drivers) */
+void riscv_ipi_set_virq_range(int virq, int nr_irqs);
 
 /* Secondary hart entry */
 asmlinkage void smp_callin(void);
@@ -92,11 +90,20 @@ static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
 	cpumask_set_cpu(boot_cpu_hartid, out);
 }
 
-static inline void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops)
+static inline void riscv_ipi_enable(void)
 {
 }
 
-static inline void riscv_clear_ipi(void)
+static inline void riscv_ipi_disable(void)
+{
+}
+
+static inline bool riscv_ipi_have_virq_range(void)
+{
+	return false;
+}
+
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
index df84e0c13db1..141f8a01d706 100644
--- a/arch/riscv/kernel/cpu-hotplug.c
+++ b/arch/riscv/kernel/cpu-hotplug.c
@@ -12,7 +12,7 @@
 #include <linux/sched/hotplug.h>
 #include <asm/irq.h>
 #include <asm/cpu_ops.h>
-#include <asm/sbi.h>
+#include <asm/smp.h>
 
 void cpu_stop(void);
 void arch_cpu_idle_dead(void)
@@ -47,6 +47,7 @@ int __cpu_disable(void)
 
 	remove_cpu_topology(cpu);
 	set_cpu_online(cpu, false);
+	riscv_ipi_disable();
 	irq_migrate_all_off_this_cpu();
 
 	return ret;
diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 7207fa08d78f..a179350d2208 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -8,7 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <linux/seq_file.h>
-#include <asm/smp.h>
+#include <asm/sbi.h>
 
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
@@ -21,4 +21,5 @@ void __init init_IRQ(void)
 	irqchip_init();
 	if (!handle_arch_irq)
 		panic("No interrupt controller found.");
+	sbi_ipi_init();
 }
diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
new file mode 100644
index 000000000000..8d06b1e3d682
--- /dev/null
+++ b/arch/riscv/kernel/sbi-ipi.c
@@ -0,0 +1,218 @@
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
+	if (riscv_ipi_have_virq_range())
+		return;
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
index 547dc508f7d1..53902cd1671f 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -17,9 +17,9 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/delay.h>
+#include <linux/irq.h>
 #include <linux/irq_work.h>
 
-#include <asm/sbi.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 
@@ -41,11 +41,9 @@ void __init smp_setup_processor_id(void)
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
@@ -87,46 +85,14 @@ static void ipi_stop(void)
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
@@ -136,62 +102,88 @@ void arch_irq_work_raise(void)
 }
 #endif
 
-void handle_IPI(struct pt_regs *regs)
+static irqreturn_t handle_IPI(int irq, void *data)
+{
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
+
+void riscv_ipi_enable(void)
 {
-	struct pt_regs *old_regs = set_irq_regs(regs);
-	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
-	unsigned long *stats = ipi_data[smp_processor_id()].stats;
+	int i;
 
-	irq_enter();
+	if (WARN_ON_ONCE(!ipi_virq_base))
+		return;
 
-	riscv_clear_ipi();
+	for (i = 0; i < nr_ipi; i++)
+		enable_percpu_irq(ipi_virq_base + i, 0);
+}
 
-	while (true) {
-		unsigned long ops;
+void riscv_ipi_disable(void)
+{
+	int i;
 
-		/* Order bit clearing and data access. */
-		mb();
+	if (WARN_ON_ONCE(!ipi_virq_base))
+		return;
 
-		ops = xchg(pending_ipis, 0);
-		if (ops == 0)
-			goto done;
+	for (i = 0; i < nr_ipi; i++)
+		disable_percpu_irq(ipi_virq_base + i);
+}
 
-		if (ops & (1 << IPI_RESCHEDULE)) {
-			stats[IPI_RESCHEDULE]++;
-			scheduler_ipi();
-		}
+bool riscv_ipi_have_virq_range(void)
+{
+	return (ipi_virq_base) ? true : false;
+}
 
-		if (ops & (1 << IPI_CALL_FUNC)) {
-			stats[IPI_CALL_FUNC]++;
-			generic_smp_call_function_interrupt();
-		}
+void riscv_ipi_set_virq_range(int virq, int nr)
+{
+	int i, err;
 
-		if (ops & (1 << IPI_CPU_STOP)) {
-			stats[IPI_CPU_STOP]++;
-			ipi_stop();
-		}
+	if (WARN_ON(ipi_virq_base))
+		return;
 
-		if (ops & (1 << IPI_IRQ_WORK)) {
-			stats[IPI_IRQ_WORK]++;
-			irq_work_run();
-		}
+	WARN_ON(nr < IPI_MAX);
+	nr_ipi = min(nr, IPI_MAX);
+	ipi_virq_base = virq;
 
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
 }
+EXPORT_SYMBOL_GPL(riscv_ipi_set_virq_range);
 
 static const char * const ipi_names[] = {
 	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
@@ -209,7 +201,7 @@ void show_ipi_stats(struct seq_file *p, int prec)
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
 			   prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10lu ", ipi_data[cpu].stats[i]);
+			seq_printf(p, "%10u ", irq_desc_kstat_cpu(ipi_desc[i], cpu));
 		seq_printf(p, " %s\n", ipi_names[i]);
 	}
 }
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index bd82375db51a..775d0026efd4 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -30,7 +30,6 @@
 #include <asm/numa.h>
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
-#include <asm/sbi.h>
 #include <asm/smp.h>
 #include <asm/alternative.h>
 
@@ -159,12 +158,12 @@ asmlinkage __visible void smp_callin(void)
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

