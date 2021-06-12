Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FB73A4FA5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 18:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhFLQHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 12:07:17 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35991 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhFLQHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 12:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623513915; x=1655049915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=7MWX5rkO73M7w4VkaGc9yiSAMhOrAqcVTpPh5/CYyyA=;
  b=E+l4oCy3imrXbl6hzrMhjMgtb5qQv4BI1n8WwqSZsNiWYTaV7MM7WRra
   afzqJS9UPesbYXB9nhtS4FIW7hxyHbMdHwXMAjqbEflUKJ0T/QmcP5l87
   Y8Kwq4EjKAHCLiZIeeT2WM9RzLPK68t0GW6XT5UP7k9kqUQ3AD9vF1xC1
   1jKaroEkHXawzAHyXmVPwyqkqhSwRRKzd78DNtsQIJpHPvvMsraGOYmIZ
   U7ECy10ji+Rd0GBxC8iTS1SYlpUKxV+o7QuiiMwndnnQPUvKTBlWpB9Sp
   DW+UOf6MN5ZovBVdjGLl+jP+Czi4bGXOSJ4T5wwYjhVxKAm7Fl5UDjiMH
   Q==;
IronPort-SDR: 9i0ThQt77I7MCr6GHm0Pf6u2MBn1jtOPjrS3eI+cVTnjdSR9VbbNW+2xuneR1HVaL3KR+8d0l+
 /qqp4P/x8nxfdcMkWbTCUIv6MlRVUxKUGefqDyja5Z01lU7xQt9BhHqVrbwBe0ZXYHcbpkOtUR
 DHLYFDSM7tb8+vMmBGW6uDnxnHsDlQ0G1APARZ92IaMlIF2N4V3zx8kQQVoK9We52qmDHVLlks
 gPW2podpWTUD0vwE/R5ZEktqdF6agO5yaoxllQ1A1PG4kZauiyUgAL9W4zrTVx38zT5EN7bFyf
 YAE=
X-IronPort-AV: E=Sophos;i="5.83,268,1616428800"; 
   d="scan'208";a="283160885"
Received: from mail-bn8nam08lp2043.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.43])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2021 00:05:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7N0wVwNgiU0g763wm4OcRq2Nn/3N5fngjLnbJcMCdBdfEMAbl2iDQaomqELsuThvKY4kD/zZNo3JazcXoehWW0DoYmME+OY6UEiHvFe0r2hipAK1rmAMbhA/MtCMwDhVaNmoZFHrL980/H1JMgODqOWEyDqLk5r9mz5N4kx8MKOVIA3jRvIXwulOoa87IOTe/BXEZ7JAIHsmnOJGIEOZA1NiHoY8uSnbGgl+3nkp3Cseaf0DCQ0DrtDSr2QpSVjeLNZh2Pa2safsrcI73RT/3wd6Rnlku36eb6ryKfRbSSYsXwpYuyBp6yJv+sSYhAMr3aam0dJc33HkSqIGqj5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UimvPwu8qriuH4bRJW9BNpqo978uUwuYWqdNtjjGrI=;
 b=IV/xg9Lle/NVuN5k+UXSXp26KQ6BH3qJXjkSbXrRMSeIFX86Wipc7tUYKYPT+GKwRcb4pX+AdDdYu/y1cuwq92PM+wo+UMZNT/D2oQKm2icXGREoRv4eVNxjqU9EPEWvLoCWBJN5VHyvb/7H3Ewyx6o1k1dih3L3/CaSTKePE6Xi4/TMJajNcNwvPNJwa9OJ1X7GIIVaDDpP+oTZXYEhb8Ed0bRZ0m1K7h8xam+hv9+v4FP927pkmJL1mCPcHn35F6Xh4ttGx2wpiq0LeMiAE5+W/qdo4dnrNTZ3wy4mfb8tQlTuxn5nNwQrBjiLPL35O2dAVO137+N2yfHx98sO5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UimvPwu8qriuH4bRJW9BNpqo978uUwuYWqdNtjjGrI=;
 b=OD9c7Lg3VKcls959TgBgO9iUlIp0XbBudy68LcazUxH6ltHq/9tobPf25x4nL6cDhGmyZ5JaTJNssD1Gmwx0v3/d9XQyxdebWNgTyLByyPwdLzK3i/TtnUKC2sBtZ6V/DYi896s4k7xJyqdNr40GAxt46CvHrl3JKDmA/0Rqf5Y=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (10.242.165.134) by
 CO6PR04MB7795.namprd04.prod.outlook.com (10.242.164.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.23; Sat, 12 Jun 2021 16:05:12 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4219.025; Sat, 12 Jun 2021
 16:05:12 +0000
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
Subject: [RFC PATCH v1 03/10] RISC-V: Allow more details in IPI operations
Date:   Sat, 12 Jun 2021 21:34:15 +0530
Message-Id: <20210612160422.330705-4-anup.patel@wdc.com>
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
Received: from wdc.com (122.171.171.205) by MA1PR0101CA0052.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Sat, 12 Jun 2021 16:05:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b306fb6-a8f8-47b9-89a8-08d92dbbdc15
X-MS-TrafficTypeDiagnostic: CO6PR04MB7795:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7795571A703063D350A2EB2E8D339@CO6PR04MB7795.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V+IOVjZJcy9B21XZpyTZT9oztD1hudAf7Ad10rFqYBRS7zJjFli6KWy6EUZvDAIr30XBFR8nYy6nH9sys1eh1FfoJcIfkoVrojgmqUTUCiDO9DkjVnDLzTBVsRsFJ16t5XeeVveq9zaAwTtThHOEILEDujv84cL76qHKzeKetiouslgtkamhRcur5bpJhRd/+494ffLmm8QtuzQNThF8dv8MdiSkXKTtF4FyGHlq0IEsC3AZH/qCdZzqtBlQaWbBZJmqV6HHBCvDdjeMjfztMaP3GUk3A+6lS+YRvvW+m8LkxT7628ywRQQ9XSvCjWwaxHlUsK4874RXI+LDYca245to2trA3sLxNiqZzcUgFc6juQ1+6a3d1SfEKEdLogWnNe6wJilhQexnXmtOO+gfmsCnmGQAV1om4wtA7iiSgk+eQ+Dqn+FPuyX71m15xUtF9Q6ftSLfjfkPq2HcfhSB63bPzy/FyZTDkbrTGrjs9PxqTVVyjAFr8mlZ9j6l0XafBKUtRVcHrFZJw4mCYdNJ93qWGp34m+N0qtQM/oTr+ox0SKkDz1E3lmOKXUXre6aXrmTT/O1MksUYb2eb+FWWDifRERj9AN13CXiRaliW1amoKU/SmhOITuQTHeGurhjfblPWe776DuWbI2NVcpiMbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(36756003)(66946007)(316002)(4326008)(38350700002)(86362001)(8936002)(55016002)(1076003)(66476007)(54906003)(66556008)(38100700002)(5660300002)(2906002)(7416002)(8676002)(8886007)(6666004)(44832011)(26005)(956004)(16526019)(83380400001)(478600001)(186003)(2616005)(110136005)(52116002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bxWYlu5AX3j0BZoVuai7gqmuWVON6BQY/0svwW9BiSrAD28rTVYsUiubsJOW?=
 =?us-ascii?Q?81pG6ryLhd3Z//eis4ZIuB5b1iR83Jpa+CL14OCtQJOyOUH4CuVEoPjtTSCg?=
 =?us-ascii?Q?xq5BIr2jhPX2b7eLId8AAmzYL+vp5zyhIZYrtkcLLdCbnk5/Lf+10MUu9G0y?=
 =?us-ascii?Q?gamflu0uyCn3+3SUtGsxReGKwH5DiAAp2KSUS3+lbvA0MB0M+Zs+ylAQP6lB?=
 =?us-ascii?Q?YEFly920O7OzlY5jg4emSj77p/rcbADnwrOoqsx1gWBbJEIOuolVXVTTGFOb?=
 =?us-ascii?Q?fP/RHh1skWKMUeIS4C+DslC2RJaVQ2nSdf9FUmVSmCe7J6rt1o0UpOeOUFLk?=
 =?us-ascii?Q?Ht4em5eFDsJ82wlX3dxK5BAAuYBiZQoi01gJf77HRvDuQNwn4u9Z5ezfPhxg?=
 =?us-ascii?Q?X+UL9czbBl427ik9lPAQs3uExcT1UmO3jQH17DzzPf2xblVTupVFmtodw0lo?=
 =?us-ascii?Q?a9gKclFeTeVGhLEi3jFTQI4tZcbXETCJlq8p/kJwv8Hp6LQGF7ka0xs2JYWm?=
 =?us-ascii?Q?JoqZQa8V0RYqgRKReyjrfOLXFgkIWkWrj/XassV2uG0Yztvs1BQ999GV8VMI?=
 =?us-ascii?Q?+ljJ3+Cc5qHdONwdjo3Tp4ZxieyR4jgD5Xp2NSaUVY9heRyXKflGUbpO1HGW?=
 =?us-ascii?Q?nv8SN4gUMW7D7cSHrYJPNybwu4xam0UUh2Py8adZ0TaYf60fxsRSG8n1ALb1?=
 =?us-ascii?Q?58H10lMiy6e8j5SO2rOLMyB/PH1Uquwg41DdqJynJE2mCpuryFWeEGHF8tys?=
 =?us-ascii?Q?A4e7et81k8FuJACd/LT2ClugNMwj+O29eI3w+I9426nMI1qBQS+kA3QaVMSY?=
 =?us-ascii?Q?j+dLXs/otpgKUANJWjVP7Ha9ZOefcZQpPU4eJ6djIRfusGVQvPzaZQ/tTr17?=
 =?us-ascii?Q?UeQ1YeShrIW/F6YPNug1AkQNb9QexJlegaXVo6c3kYWqgCfXkELphx2OE3D/?=
 =?us-ascii?Q?6LoM51727jGn5ehhJONDpiSfb6j2/mKYTdl0P0Jjn7uHGbmzm/FC7TH0yrji?=
 =?us-ascii?Q?V87Zk24zE4Rzjj+jIMM+uBtv64ja6T7jPh8XDpqlMcbyMybnN1MqG5M2hE+o?=
 =?us-ascii?Q?tSBfmQ/AT0dlvZGOWB2Hbt4pDTJWst283sxN0EUgr1Huhuy09qpcqrfrUdig?=
 =?us-ascii?Q?PF6vqprzsEidO+BpF5MvYwnnqv/1aK3I6TdQH7h6/9qABt3/BlGKV6+JK6m/?=
 =?us-ascii?Q?1LelaIV91q415+g4QPD+spasfU8qN4ZU9vzU5glhuV/+i5LPILfW6CwDV/Sq?=
 =?us-ascii?Q?MUw3f2zdHlbSHovEeuiYWHR8mW+x1wW7dwXlBbjbR/l5jL6Nyki4Ff+bXRUa?=
 =?us-ascii?Q?XthNyagXtXuft53zkMyJafyY?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b306fb6-a8f8-47b9-89a8-08d92dbbdc15
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2021 16:05:12.7554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipUoSM5fAnwYQM7+l3iv76gxixjmEwg2RPz44J/nErPZuwFBUX+R1OJRlxvAUQYwYYUpPzmQsUuce0qcv+7S9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7795
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We extend struct riscv_ipi_ops so that the IPI providers (such as
SBI, CLINT driver, ACLINT SWI driver etc) can specify:
1) Name of the IPI operations
2) Whether IPIs are suitable for doing remote FENCEs

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/include/asm/smp.h      | 15 +++++++++++++++
 arch/riscv/kernel/sbi.c           |  2 ++
 arch/riscv/kernel/smp.c           | 25 ++++++++++++++++++++++++-
 arch/riscv/mm/cacheflush.c        |  2 +-
 drivers/clocksource/timer-clint.c |  2 ++
 5 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index a7d2811f3536..4c4f0dde1164 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -16,11 +16,16 @@ struct seq_file;
 extern unsigned long boot_cpu_hartid;
 
 struct riscv_ipi_ops {
+	const char *name;
+	bool use_for_rfence;
 	void (*ipi_inject)(const struct cpumask *target);
 	void (*ipi_clear)(void);
 };
 
 #ifdef CONFIG_SMP
+
+#include <linux/jump_label.h>
+
 /*
  * Mapping between linux logical cpu index and hartid.
  */
@@ -45,6 +50,11 @@ void arch_send_call_function_single_ipi(int cpu);
 int riscv_hartid_to_cpuid(int hartid);
 void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
 
+/* Check if we can use IPIs for remote FENCE */
+extern struct static_key_false riscv_ipi_for_rfence;
+#define riscv_use_ipi_for_rfence() \
+	static_branch_unlikely(&riscv_ipi_for_rfence)
+
 /* Set custom IPI operations */
 void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops);
 
@@ -92,6 +102,11 @@ static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
 	cpumask_set_cpu(boot_cpu_hartid, out);
 }
 
+static inline bool riscv_use_ipi_for_rfence(void)
+{
+	return false;
+}
+
 static inline void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops)
 {
 }
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 8aeca26198f2..be2b7a89ce49 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -604,6 +604,8 @@ static void sbi_ipi_clear(void)
 }
 
 static const struct riscv_ipi_ops sbi_ipi_ops = {
+	.name = "SBI",
+	.use_for_rfence = false,
 	.ipi_inject = sbi_send_cpumask_ipi,
 	.ipi_clear = sbi_ipi_clear
 };
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index eea0c9d11d9f..cffe3247b132 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -90,9 +90,32 @@ static void ipi_stop(void)
 
 static const struct riscv_ipi_ops *ipi_ops __ro_after_init;
 
+DEFINE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
+EXPORT_SYMBOL_GPL(riscv_ipi_for_rfence);
+
 void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops)
 {
-	ipi_ops = ops;
+	bool updated = true;
+
+	if (!ops)
+		return;
+
+	if (!ipi_ops) {
+		ipi_ops = ops;
+	} else {
+		if (!ipi_ops->use_for_rfence && ops->use_for_rfence)
+			ipi_ops = ops;
+		else
+			updated = false;
+	}
+
+	if (updated) {
+		if (ipi_ops->use_for_rfence)
+			static_branch_enable(&riscv_ipi_for_rfence);
+		else
+			static_branch_disable(&riscv_ipi_for_rfence);
+		pr_info("switched IPI operations to %s\n", ipi_ops->name);
+	}
 }
 EXPORT_SYMBOL_GPL(riscv_set_ipi_ops);
 
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 094118663285..0ffe7d560dc8 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -16,7 +16,7 @@ static void ipi_remote_fence_i(void *info)
 
 void flush_icache_all(void)
 {
-	if (IS_ENABLED(CONFIG_RISCV_SBI))
+	if (!riscv_use_ipi_for_rfence())
 		sbi_remote_fence_i(NULL);
 	else
 		on_each_cpu(ipi_remote_fence_i, NULL, 1);
diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 6cfe2ab73eb0..dfdcd94c1fd5 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -55,6 +55,8 @@ static void clint_clear_ipi(void)
 }
 
 static struct riscv_ipi_ops clint_ipi_ops = {
+	.name = "CLINT",
+	.use_for_rfence = true,
 	.ipi_inject = clint_send_ipi,
 	.ipi_clear = clint_clear_ipi,
 };
-- 
2.25.1

