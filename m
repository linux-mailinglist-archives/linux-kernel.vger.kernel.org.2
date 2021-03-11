Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A903379E5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhCKQsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:48:19 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:27707 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhCKQrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615481266; x=1647017266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=7W+sx8e4Cij6s7jeh170Vdld+rK+I5NrG88R46BVLaQ=;
  b=b57zFhy/kTDiAcPx+3kB2Hz5tj+1O2zwdZg3oFW9pn70OokZ+HsaoTQL
   B66SVZqQL8DBclPAY3bwsRgqCVRZ2yEiKdzEdhc4MynXvitAT9eVyNgEZ
   bfU8wcG8eHkGXwMDKLqJxLp6A11kZ2+FFnZqZLAPR1LSxMQU1DP63lY7A
   4pdZ2d7l3pfsZFj8xoQy4bjR+51LaOIahiNG7O0NFiNoZclTLCK09H0l0
   M8oAy6OaXW1IgtV3v6tjJXcRKP64GK4j2C5RO6V6eEMSUeIOZZCF9TLzL
   Ow65GgoaAi+7bc19TKGCVs7BbHlErfhhrtvcPSWzzYD22ablFzpIY40gJ
   g==;
IronPort-SDR: lU3vDpG8bg4fDoj14b2YQGXQmG8TQ0GYUMTqyrAhg38V8739F8FJLI/pI9dgExSJXJKfTG9u6H
 btqU/Orxuu0ngdgtIH7tSZo/qgp4DgQN1BeTgcZpEEKVsKeuch5GeunHxidWVjJmO4g6WrJ+gv
 0tsFkpvauSqR+FfTUF3o+QFXNF3WLJs2HdVAYlxn07MCyrRdQLmwEl0oQnkkIOGaJavgBFmzxq
 KMeatKFrhiHDq6bGOC0/W9ZVRtfuwBrzVdNQWjJ3z1o51CceBuigk5bB5lBW2+ykuCyR4IB9ns
 xNE=
X-IronPort-AV: E=Sophos;i="5.81,241,1610380800"; 
   d="scan'208";a="166429044"
Received: from mail-co1nam04lp2051.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.51])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2021 00:47:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejlxtnWnFsIS+TaDGxhOp7Eh+0Ts0Ih9Hchfj79MwqHMBQWssftXi3XcXUGYeVKNjEnRs5+K2jAX7ZcYzYXMFYfoOXBB7giKl+AoXkkExipuF0fpOQsnExbe4HclMKozVdvO33WLLb7K1Ts869clio9Zo5LeGVKLbPwezy5N5EgnZSpFl+xIFxMIzNyXzNp5kvzL+K13WIzl7/0jbb+cmlWAgbZEc6K26swonANQgtWANqbIKPfdzCSfDL7HGO+gVQLi25YVpg4PLEsfnH9crcS/cDDVD8L5awz25O+IyB+0wujNgZr07runa6K2VGNBxd0BIFpwy9rb6qfAKHhriQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+2K380GJTUU9NILQLzeBq1pUOn453ZEpp9WnrqHoGk=;
 b=V9kAN5TioAh56+H5gWOHT++Y68LcggyEP16JtSJLXJHtKZXtvXN7YPmQRWVUS3M68WujcYmKVmTD5OnYPmvbLjbvC+cSAtqk5UEhPWV/JyXvv9JNl5hYeu6H7jbzWow2RaI0qUSlQ4id8lTqAZMvPGYvroYDtjmEpTeJTjZ/mzjtpbT586nb80uA6mfcEBnzEx/e2Ths8tEWxU4v07bbUBLvT4aJlmQen8SFCA5+x5DKiokBfsNzu7iWtsG1d4SS4RScIEYuMFc3M5qpddylsALm8bFTv5CGYuhOiE+NzitteICqyiu5b4IcW2l14Le7zGA3wsuLwl2trVipC6GirA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+2K380GJTUU9NILQLzeBq1pUOn453ZEpp9WnrqHoGk=;
 b=R5FLFwqaGVaOMfnMco9NTRpz5irqCBMfzpq1kjcOnbKtRyBhk8OzwWV2FBZYoelymR9MxMIzJmHkG7sfOqumOoWufDNcXsUkvxBtdG+NY6FZ66u+qP6TCm1ibpMdcoHjoZ+n+a0Rk5yatjBGHjtiqj5hJ+In0+V79SgshFeoGuc=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR04MB0218.namprd04.prod.outlook.com (2603:10b6:3:77::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.29; Thu, 11 Mar 2021 16:47:44 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3912.031; Thu, 11 Mar 2021
 16:47:44 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [RFC PATCH v1 1/3] RISC-V: IPI provider should specify if we can use IPI for remote FENCE
Date:   Thu, 11 Mar 2021 22:17:10 +0530
Message-Id: <20210311164712.652608-2-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311164712.652608-1-anup.patel@wdc.com>
References: <20210311164712.652608-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [171.61.72.64]
X-ClientProxiedBy: MAXPR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::31) To DM6PR04MB6201.namprd04.prod.outlook.com
 (2603:10b6:5:127::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from wdc.com (171.61.72.64) by MAXPR01CA0113.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 11 Mar 2021 16:47:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a6405e9-9a2e-4144-4a8f-08d8e4ad64a7
X-MS-TrafficTypeDiagnostic: DM5PR04MB0218:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR04MB021882F5207150439F58C4AA8D909@DM5PR04MB0218.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NfRZqeunKhtlgnN6JVLv5m4yOv3WQQJKYSWyPTiw9p3xLRli2z5RYbwScSCE30aV7uByin3G/uwl9omp0K10ezZucDUF1URivh9r2d62UVlGH8kCKPSnXwM07+PEkxpYE89oeQec/2gLv/jlVObKOpzUXOuHPhbVASghQ7xg2IUxeFfWn64PHCYolNbHfpFfLqx/NcizFW0749+Ok/jiXHfy4iwilV61Uj483kMq9gYtsB2Lv1mFxddaTdGOxfj9AhEy0/DmNSAvn8NAzsLJWp1u2qud9W4kReHoKC9c10XmQw4Wztci4/qklwP63nGUiJrr2ym+pBaF7Yh1uKiUFocfOxw3hRHPyG90EE4vuv7hNGR3oI5Hk6skkHEf4rdGrI6RBOfTTm3swI7l0yGG26s0EI6hRn9EVixYmGWgygJnqQ/4bDG9amDCG4Qwj7TsorumywWvQl9gzaL7wGu52OKlYWYfLAdqJsR7OSqHcz4g9v0HmVxNr7+8en+yNqNDuUSrRx42LVrjLv3Uh79raA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(316002)(66476007)(66946007)(44832011)(36756003)(55016002)(8936002)(6666004)(110136005)(66556008)(16526019)(8886007)(2906002)(54906003)(478600001)(5660300002)(86362001)(26005)(1076003)(52116002)(7696005)(8676002)(956004)(2616005)(83380400001)(4326008)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?IySa1O0lBq6tDsVQ25MtCmHk1foqnuk1JXWNWxkFQoA7HQYWyGn/jeNAf3Ub?=
 =?us-ascii?Q?lqYEzZVwWbYaJIZivcV6Lzhe8Lu3IS8eYZlFVag6aauNodcHj+RE0BgOFFg5?=
 =?us-ascii?Q?pRQy67mf8+UNRmKwFgx8HJa50PEW2atcPxYaSDBW+QXNwv3eQTfxtfaDhzKM?=
 =?us-ascii?Q?6FFBpxLXcd85mtywFwhs/LFDDv41QqzAi3F2P0cyfA3mr/pCBIact3b9GXG4?=
 =?us-ascii?Q?8jihgKx4GiTqBirapvhzJicC6z9HAgR+R+sj/6Q969+SfaInbqK6rVYJkOGs?=
 =?us-ascii?Q?Zc0liOp8tJxvC65peUoZ31BGdlujSNXG/3FpJNLTAkM0YEeGRyt/FAKEDk5t?=
 =?us-ascii?Q?DKg4+8xUOPVbmTznAXTUKFIwOYoAXrK5AN3zTCFmohjmflC/FaLN1baX4ZoH?=
 =?us-ascii?Q?HHUrwFWz+C4js8E+v5agSc+J2s2lrFF9KC7Xq9chHqfKwxPJW9PpTw89nDRK?=
 =?us-ascii?Q?kYR+zr7myd8Jhmdz2wBiQx97Hhq+vPWGzusAe+8z+d0K1AaaodqYR5z1dGwd?=
 =?us-ascii?Q?H1Ck8JJpKUVCWiufkfhDiob3xpTw0So4fdLoxEBq2Wgwyc71Ci8NjaAfhEJh?=
 =?us-ascii?Q?E1oU4GseyEf1EnT4FJyvTpInPOjf/jCbPiaokIAo+Eel48UKsPuOdkpZ/qkg?=
 =?us-ascii?Q?z6nCrzFGGzYaH7LjwXJu/JJx2vTLL0P3+8g0s56eKfWzgn0zLnDRi7LYd5dK?=
 =?us-ascii?Q?mf8FZsyXLk4x5APxAcMt5EDwl0KJP3F97CI2ORCAn+/HldhKu5xsI4oiDWLZ?=
 =?us-ascii?Q?lF3cxY4FGz/1HSIrhE1ZozbFoNzElaxR8Wd9FvSO4T/EuX3Vk2JxmQPDjEIq?=
 =?us-ascii?Q?rQMZ/hQjE4a+gfiIOU2vS+Gygfl9OzS637rl3hTXevwvymZ1VRVJG4A8Runa?=
 =?us-ascii?Q?iXlYv+glupdOZD8rTz8oY4j8GJJ5oJnGPMGpUVh+97qNYJMN7svUv3DYVEL9?=
 =?us-ascii?Q?+IfaV3hin6fb7RWmzsa1EEYk9kVP/w66FSA+2oO/jLO5d7PEdjypBX/fQcf0?=
 =?us-ascii?Q?zKTf8g8TiwQc+DkZJVHl7taQOcSfpxRYT/2+wS5VhXJLyHUUf8okL/YcDNog?=
 =?us-ascii?Q?JalJLTSsuNkJXsBNqDPIenQVNVQsr8iLAMIeYq5nLpnVjJCPxfagIjvjWZJa?=
 =?us-ascii?Q?OrVfD5RaNjd9EtVaCARkGbgr9I7adJPZe9cYXN9NXTRqi4yibwVDNkC2NMem?=
 =?us-ascii?Q?7QSDLMCrHxFEROzgYkUYh3U6EaA0axFV6teSmVrRHze1MrkQVMaE9pBfheEH?=
 =?us-ascii?Q?GUqELMQSee7hvQii84pWI1fHzkbSmUpzPZtV09ghFWp9lnlvzPxA32iK/9/a?=
 =?us-ascii?Q?TNgtiBpWSZcJwB1l96nFs1z7?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6405e9-9a2e-4144-4a8f-08d8e4ad64a7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 16:47:44.4234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0qaB9+8ZUTOlqu5PGCUZM+1Ys24XqdRe/YpSf3hqU2YKloWdKDDihxmy/otJc1MmyHEQcjaluWyK86Syp+r/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0218
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We extend riscv_set_ipi_ops() so that IPI providers (such as SBI, CLINT
driver, etc) can specify whether IPIs are suitable for doing remote
FENCEs (i.e remote TLB shoot down).

The upcoming AIA specification allows IPI injection directly from S-mode
(or VS-mode) using IMSIC controller so the extended riscv_set_ipi_ops()
will be useful to AIA IMSIC driver as well.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/include/asm/smp.h      | 13 +++++++++++--
 arch/riscv/kernel/sbi.c           |  2 +-
 arch/riscv/kernel/smp.c           | 10 +++++++++-
 arch/riscv/mm/cacheflush.c        |  2 +-
 drivers/clocksource/timer-clint.c |  2 +-
 5 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index df1f7c4cd433..82c23e5f22f6 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -45,8 +45,11 @@ void arch_send_call_function_single_ipi(int cpu);
 int riscv_hartid_to_cpuid(int hartid);
 void riscv_cpuid_to_hartid_mask(const struct cpumask *in, struct cpumask *out);
 
+/* Check if we can use IPIs for remote FENCE */
+bool riscv_use_ipi_for_rfence(void);
+
 /* Set custom IPI operations */
-void riscv_set_ipi_ops(struct riscv_ipi_ops *ops);
+void riscv_set_ipi_ops(struct riscv_ipi_ops *ops, bool use_for_rfence);
 
 /* Clear IPI for current CPU */
 void riscv_clear_ipi(void);
@@ -92,7 +95,13 @@ static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
 	cpumask_set_cpu(boot_cpu_hartid, out);
 }
 
-static inline void riscv_set_ipi_ops(struct riscv_ipi_ops *ops)
+static inline bool riscv_use_ipi_for_rfence(void)
+{
+	return false;
+}
+
+static inline void riscv_set_ipi_ops(struct riscv_ipi_ops *ops,
+				     bool use_for_rfence)
 {
 }
 
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 49155588e56c..15a09680fdb6 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -634,5 +634,5 @@ void __init sbi_init(void)
 		__sbi_rfence	= __sbi_rfence_v01;
 	}
 
-	riscv_set_ipi_ops(&sbi_ipi_ops);
+	riscv_set_ipi_ops(&sbi_ipi_ops, false);
 }
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index ea028d9e0d24..9258e3eaa8c6 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -85,11 +85,19 @@ static void ipi_stop(void)
 		wait_for_interrupt();
 }
 
+static bool ipi_for_rfence;
 static struct riscv_ipi_ops *ipi_ops;
 
-void riscv_set_ipi_ops(struct riscv_ipi_ops *ops)
+bool riscv_use_ipi_for_rfence(void)
+{
+	return ipi_for_rfence;
+}
+EXPORT_SYMBOL_GPL(riscv_use_ipi_for_rfence);
+
+void riscv_set_ipi_ops(struct riscv_ipi_ops *ops, bool use_for_rfence)
 {
 	ipi_ops = ops;
+	ipi_for_rfence = use_for_rfence;
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
index 6cfe2ab73eb0..fe018a2c008f 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -228,7 +228,7 @@ static int __init clint_timer_init_dt(struct device_node *np)
 		goto fail_free_irq;
 	}
 
-	riscv_set_ipi_ops(&clint_ipi_ops);
+	riscv_set_ipi_ops(&clint_ipi_ops, true);
 	clint_clear_ipi();
 
 	return 0;
-- 
2.25.1

