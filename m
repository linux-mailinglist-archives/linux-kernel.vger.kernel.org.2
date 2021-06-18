Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636C33ACB24
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbhFRMlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:41:45 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:62799 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbhFRMli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624019969; x=1655555969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=g1b2/gDgHvYWATa7oEh+ICidzjQOA9pjNXMVVbcwMoQ=;
  b=DBsOsnmXbmirI3Y2mDxkTvHH0nSQZLJCeI+2IYSq1mec5oOxQ2RAQWXe
   3om2k4HNgfM9EQytGpRz/O+SQH3sNmrwAUQwVWzqmQCXX13/QC3I+4/bM
   uxwSc1W9DnR8kDbYH7pATVSpV4rWFfekvwi2eVpTUi6O5395g3Ofzsxh/
   ZrS1XYccFkJOxsJgul7p4BvvXjDM31IsibF/1ZBwqwXtQj1MZNIgoeW+E
   UT0U5wREUzS/ahCaxuFrvq1H1Etu8N4BvpQGvHZrVRzH6NQQaILDOvriT
   6TJ/wz4GJ/9PnJoYSMlJkpNXQj/X7NgoX6epsfKooz4ks2UIy9zosXJu3
   A==;
IronPort-SDR: hF3Rya+y+Pr4NK90rj3PhZ/tuwDd3saYajaGoM+BUgh5K2BkN/+36E6FMkIC/dyigZm/SivkwR
 fRDB2Kn+F2jKfargPgosowYk614yWrt0mOU1Yg24vnXeeLdaDOcGlMLZYtJoNaDEOUb/4WNa9M
 n3JpdCf6i7FPoCjeCKb7s5OblGkU7Nc8VIkAMeZZ0htIihvBylm1xrQZrFvdIt6/DOlh57DlO7
 yG9eb4TVYdKMb82VANhojdUgmV45X1UUPwdxbDGZSXmz72ucqI/Z4PU/tbJURLFLhhVTf4A/xa
 mc8=
X-IronPort-AV: E=Sophos;i="5.83,283,1616428800"; 
   d="scan'208";a="283779300"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2021 20:39:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSIl68JiEN+pxIQKPfMxgiRE2Uvejwqzsh2cBzEpZZE32rhQhTihwDGmAzIvSpXlcUQ8Gvw55T3YG2IGh4q+Vzx2SiqButquJsbz02om4CfUVKYXorUBkQTR8/vgt8CiJrBqGE2HMxzIPvycE0X4jL487iKQoXV6a/kyMTixEnnKLH7XYcJY/6SsACiLFrI9MjgdcB68WSV+Fcrsc3PG4kejpdj6Dt/pSmy859YNjDPxd0MvthJzknhsNP2U5yfWlyNt3/ELnnWOFKTLDRVojAw6f/BVMcy03+kYk7iGryHJ69Hr1LCfIBQs5++ua9TiAGhqOGYBSW40y2VlMDy8NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xw3ZR4ebXmD/CfNfUf3eyoqj9/uqZJYffw2EkdPNHaI=;
 b=glM2oPvqNCEsVrh0In3hYiRdOj6VFI2hKDyOPIztD2uNWM4bEAGNrV4gKbBMNVR1pH0mFP6J6BgSjX9JAUKqYruE/u6Ns6HXdGHSTwNoDaiPqwahbReto56Vd+W+4fFBif1Wq+yLeqTkLyOoUPlvRx4F/GjPppafRb+Hh0zyge3to8duEwnW3unevq5zSoRvl8nnh13KofnEfbnKfRQ5TlverbeJPkFhBQdWOBdTUjsbUwBMxndA6GBFDU9ctV9I3UjHZ0N1b64BgkNxfzrUGiBqXEJhXNgq+rdEUeVvRwioFT2Rxhm+a3uhmDRU3fcvdCAcUErxN9+80yeAoJR/Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xw3ZR4ebXmD/CfNfUf3eyoqj9/uqZJYffw2EkdPNHaI=;
 b=a6VatJdMdfBiSQsTqDbmgv6oleH3l6B6kNiqXrX4gSRnpELoizpztATTkSRc2Dqj0LV1LWa+WIp8jSR2Y8YTiga3F7OZKVW8gOnPIXBlj1lH4OTYIwm0jpnjZ4Sj4csAZPhNMOVyAtzOmNZ2x62OEBnWo8a+PR1aCA4SZ6MnnDU=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7843.namprd04.prod.outlook.com (2603:10b6:5:35f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 12:39:27 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 12:39:27 +0000
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
Subject: [RFC PATCH v2 02/11] RISC-V: Use common print prefix in smp.c
Date:   Fri, 18 Jun 2021 18:08:42 +0530
Message-Id: <20210618123851.1344518-3-anup.patel@wdc.com>
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
Received: from wdc.com (122.171.164.186) by MA1PR0101CA0025.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:22::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Fri, 18 Jun 2021 12:39:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60989b56-104b-48a7-8b6d-08d932561c62
X-MS-TrafficTypeDiagnostic: CO6PR04MB7843:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7843A075B3119FE6E73743188D0D9@CO6PR04MB7843.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jQ3YDaljQ6pMp8+b4378tEnFMuPLg5KMvLgU14rrOyTs1r2nW4jQBQRIuNPkaejnjbvHtFNekhRspuQbIcvpBuVdHO7kLFZqFkIF3dlKj6NEherWEQAQ4R2BKob3xbzqI5FTtSz2iGoC8xB+wFzErFjtPENlJtn1YO2cpLAoIIUszIlU+ZYVxm5uTQ428K1rH31/q4duP21wWdnnoN5UC37k7UkUJRzz1L5rHZgpcG/Scvz5FtbA6n16QO6FZHAtBMaQZTtcQ3AgJeQsIHpTS0KnKf84oloRcDyJph+ZQpEWi8XDMCZJOS3aKrvOyUF/1olIG+HVzCNgQo7DvucCZ8TZX8K0kMlJqdhPay6HJGILWJX3M8WcIhV3DTZ4iBG44cvPTD/UYIgS3BYbA/x7kc0Iq2zoM54eYfc6XH/u0x1k8c7idsU4qj/24G3EcH4MSYbT00mc8f6S6a9vT5mgKz8G0rYvAbb4yid21cTtiI4QyKeyZ/xqGcu9JxEKb26lNHJw9Os1I5KCO40GfKOSzwfei4ntTsqhN/JVzJgSvTUUnKGpSwpfTwdh1cpXawVu66s84rYhS2JW9dgAZQe5phDoha1kwRX05d0w/8QXWcYl7LdwZE7CDdd7z5e79dbzAeHuTr8a6iuBn6kq5k2xW+unqu75sc+4oCylU+iXId0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(83380400001)(316002)(4326008)(16526019)(186003)(110136005)(54906003)(52116002)(26005)(55016002)(2616005)(956004)(2906002)(5660300002)(7416002)(478600001)(38100700002)(38350700002)(8676002)(66556008)(8886007)(44832011)(86362001)(8936002)(36756003)(1076003)(66476007)(66946007)(6666004)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N/QXR0sHc10NZ4Ndsr7a/5fKWKvtfrSXJMunc+WGrSjHixPxzC3ZVxOrVyDM?=
 =?us-ascii?Q?owU+UULvq7gYQSQL0CPGflEBPf5bm3RL+aLVCWG7T+74D+LdyTCUSuyEnYXr?=
 =?us-ascii?Q?VlUOEZ45xLBoyyacehMk88SDvy+AJKyn6LDtrrVeXj0R+DCXyjaT1VIAKI1V?=
 =?us-ascii?Q?ITyRQpH+0C5A1Nj1W/vbzPrZGYDBpVTMNuuD0n5sSLzMZ5w3MOsGsE3fR6Vr?=
 =?us-ascii?Q?0hVPPpXXdQbS5XO0pinFs+uZ2TcX9St8tx8ngFOui//84gb5K6RODd2PgCwS?=
 =?us-ascii?Q?puSuKMb9qt5/GccHd1MWEJIk9aenwfKpUkevCsYBGDrJfBvT7aswZlrz8ghm?=
 =?us-ascii?Q?OGrWcUia2tVzPMUITqIpNgeUQVMzy6+tpcK+5Z/4FPsKgqBSAngVQC+Wxluw?=
 =?us-ascii?Q?TPrcJuyUQ6Je+HCxjshoPAsmgONF4UwaXGqi3rAg1nCpEcc9fQwmJpjuwuOK?=
 =?us-ascii?Q?OmFpnd2OOJOoOjMzV9+HJNZrafGFU0uiJu9HpZ2+1Fdf3nXgeIxsBAgRHIVj?=
 =?us-ascii?Q?8M3V4otscQ1y9IIQ5pRKpPZS1H31Fb5093e/d/UWf4KyB4Ap4qbOlmgRitQS?=
 =?us-ascii?Q?xPT+8NQ+G8RcrUgiJbnyVd61rGOouZ3fRnG0s3ZKdTKUZ/7yqYxL7YQaoGQR?=
 =?us-ascii?Q?DXU7tl6oq/u4xlk03N9RFvmmCxa+6364l7Yc7Q1nhnYr143S0yKFkJMxFRnW?=
 =?us-ascii?Q?f7qUpTNDok1U0vP8vXsWvrUj2/fbl+Ku3vSGcTGdBwrAgakhwBSvQVEvBvgu?=
 =?us-ascii?Q?xW+0SRyIj8fJTcfoKnFWxug6fgxoDx1szjWXRO6gl0evdXihHp3J2IIWxNz+?=
 =?us-ascii?Q?RTufZP7vW/YLfCOSbPdLq79ytwEUDvi+7at6Pnoc2PpDZP7z0Ub3ciVlR9qu?=
 =?us-ascii?Q?jmRtcc5pI5eW+ZrTIKYp5Jz3BwHApBI84Rdh7qefOg39cEG3laqgKFqOa2OD?=
 =?us-ascii?Q?H0SUCKvi1oSbW8HGUH6Qj4OffmvQf9Iv0jAvDStVcCvpUTG/d0REZuysJ1YB?=
 =?us-ascii?Q?NG4Easf7lS+ymuBS/7+CzM0thoBmwy1Z7aziGNi0+/9GdA++T9RZuUv9vu4P?=
 =?us-ascii?Q?k9zgp1n2Z5kuwj9KggNAonN3uRGu6nBorIoSWUzM6uW8C9VVZGjtA+r4zCaM?=
 =?us-ascii?Q?IfvZ/KN9vBFerViUxj6ge3dL0qHhfQJA4dHO/uuWHdtjvyea257cN1FrzCp6?=
 =?us-ascii?Q?vhEBnUlhHit4a8wDtU/NUPE+O7FVR4O7ZOsA8RMft/ZPRfzvuKlAUF4x55BP?=
 =?us-ascii?Q?g2pIf254zQLpMDwDaoJEv6VcMw4bbrnlnuSeC3EPu+0RW3QKQMNiB0HvPSEa?=
 =?us-ascii?Q?wAEugT9UrSijwW/Q4AiZly/+?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60989b56-104b-48a7-8b6d-08d932561c62
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 12:39:27.6174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZfkLvSWppim3CTat0Q1vsNesckl8ViYl80wRR7DlwGTl/e3kigucbE5/aXHt6QW3U9hVCK9syO6Fwe1FIb05zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7843
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add "#define pr_fmt()" in smp.c to use "riscv:" as common
print prefix for all pr_xyz() statements in this file.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
 arch/riscv/kernel/smp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 547dc508f7d1..eea0c9d11d9f 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2017 SiFive
  */
 
+#define pr_fmt(fmt) "riscv: " fmt
 #include <linux/cpu.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
@@ -114,7 +115,7 @@ static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
 	if (ipi_ops && ipi_ops->ipi_inject)
 		ipi_ops->ipi_inject(mask);
 	else
-		pr_warn("SMP: IPI inject method not available\n");
+		pr_warn("IPI inject method not available\n");
 }
 
 static void send_ipi_single(int cpu, enum ipi_message_type op)
@@ -126,7 +127,7 @@ static void send_ipi_single(int cpu, enum ipi_message_type op)
 	if (ipi_ops && ipi_ops->ipi_inject)
 		ipi_ops->ipi_inject(cpumask_of(cpu));
 	else
-		pr_warn("SMP: IPI inject method not available\n");
+		pr_warn("IPI inject method not available\n");
 }
 
 #ifdef CONFIG_IRQ_WORK
@@ -242,7 +243,7 @@ void smp_send_stop(void)
 		cpumask_clear_cpu(smp_processor_id(), &mask);
 
 		if (system_state <= SYSTEM_RUNNING)
-			pr_crit("SMP: stopping secondary CPUs\n");
+			pr_crit("stopping secondary CPUs\n");
 		send_ipi_mask(&mask, IPI_CPU_STOP);
 	}
 
@@ -252,7 +253,7 @@ void smp_send_stop(void)
 		udelay(1);
 
 	if (num_online_cpus() > 1)
-		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
+		pr_warn("failed to stop secondary CPUs %*pbl\n",
 			   cpumask_pr_args(cpu_online_mask));
 }
 
-- 
2.25.1

