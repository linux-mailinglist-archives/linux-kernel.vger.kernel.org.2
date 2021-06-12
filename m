Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D963A4FA3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 18:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhFLQHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 12:07:12 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:44959 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhFLQHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 12:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623513910; x=1655049910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=m1tGMkGEgA3bTk2zVbBmeOm0qtXePpwPFOVYu9hfMfI=;
  b=lgv4bNWDc4TgBQ2cG1PD8/3hd5W9T1yDVPQbuEIJVE7nE8j3MD1KRdXu
   5T004umQ0SwVCLkQeSKE52dHkpABnQ7yM+pvEnNvwrbEinRrkPqQE7313
   X+1c01rzJTxxaRxO1U5GFqpTj3xMkkNVXNvjJrwJRKwAbqHhvEVl2+U87
   61BXSBbsHkBHUdbc53OUejpDPsj4yh+lo8BGjriKvGrO4sD6l7UjiHBq7
   zpUwDzkcQAVxWDMyGL8GvYqzt6gMTmn02uyEMigtMEhqrbvHGFMwOLseM
   5HM+EYefvT2ioBrf8UZ8AtcTNv8vK24QSl2ERxiH5t4WSYzGVIIvRsEfY
   g==;
IronPort-SDR: Lf7TTgB/4bImPwfdfp21CJPx0PL2cZ4eUoqVGtjXke2/WxSxRmD/lgG488H49OOaX31X3emISy
 2PE72Hh4g1EzzYaJApDiXlVHhpbx2sN1P2tVTiDHliYVo5fzudfl4IUxV0OcSojzBT5yRiVsbL
 ZnnFqAwesYZBTFV72XDJfb2I3Dw7h8QIApCeglYHGX/PFqWa2cGjrgtaLfU4KVThAg4BXSI5FH
 lfrC3oXBeVtRWUL5ckoc6Cp5PTKRlEUlxWP8B0g6mq64azekE4O1O2Y4swy3Dkwr9G+NzE2acj
 mJ0=
X-IronPort-AV: E=Sophos;i="5.83,268,1616428800"; 
   d="scan'208";a="171704681"
Received: from mail-bn8nam08lp2042.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.42])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2021 00:05:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESy6zD7mcmAES3vLO6S0VVdotJq5Vj/orOfD4weRMOEDXpXvCQZJYkq/TcDa6ZXyNRmmiW4UoYNWrJLzacIwqEpDcGcFlBtsj7nJw6+mH+buRtay2powLWiw3iitao69/v9vRbROdlxH2u2qlwf//jwgFmwtXE24H5nYbmyS9pQH33mO3D1SkhDJlTwtPPWO7MPawld+ZkUakFc+4fxsxyVi7XQLJGdwjnZxF8sF6euBE0lWGRprLratOIy1s8TgOMnKFm+vHY19WexIG6UjPCo+5XJ1TB2HSWkEQBKC3urZA73Fmg8Yed7zuPFeHFxAd8V0QJ9bnFBqjb1quYHZyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UFAZY/brmNFXxDcegScp2bpGvKxJ4YJYlb8jAB7vIs=;
 b=J6QZ3PtiOCFNk7KyhTWGcdm7/oVFr1UZQAtaivf52SWD1valWMDtXD75FsYr0Zqv5oMwaIvvORfasX9PfSRAmTjWHAt5hCy3W09C3/tZTjWR9wgmKbj+fhl1SWApjIuT61x1tKSL/L93RRA5Nu4Ce5b4vcAKb59T1juVk8XWVfkfk8+za68yx5ihNq/P9uQztJoa3vKosppjX6i0Kzg+ZAFw7N9TKyPS8GyuPSbLSebw0lytaDmrFHIQnJiXvQttMnAIjg+pyfjNP2HZ7l+9mH7mzwqbWH2NJ+CIDlP2hvrGSkOqAm5un28UIoeTQI4Tu/gYmHRcWFATE3o1W1e++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UFAZY/brmNFXxDcegScp2bpGvKxJ4YJYlb8jAB7vIs=;
 b=QryFOts1mR2v7PoSU9/e1l+yjGmeKXR4KmEBNF7t+pZ+fjk7rXdGef1hNNhAz2UshNnMOggtlZ5JH8Lp8tkXruEftCyn2m69hw0yqBxjgpssIzsKT7DZn/VJPlLc0wRr3J6X+mj88s1MSKR3Kj06wJl7ce76VuTC9kepu3dYe/4=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (10.242.165.134) by
 CO6PR04MB7795.namprd04.prod.outlook.com (10.242.164.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.23; Sat, 12 Jun 2021 16:05:07 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4219.025; Sat, 12 Jun 2021
 16:05:07 +0000
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
Subject: [RFC PATCH v1 02/10] RISC-V: Use common print prefix in smp.c
Date:   Sat, 12 Jun 2021 21:34:14 +0530
Message-Id: <20210612160422.330705-3-anup.patel@wdc.com>
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
Received: from wdc.com (122.171.171.205) by MA1PR0101CA0052.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Sat, 12 Jun 2021 16:05:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 347a2de8-2f71-4ea2-af97-08d92dbbd8ca
X-MS-TrafficTypeDiagnostic: CO6PR04MB7795:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB77950F8966D8EA6D74D4BC388D339@CO6PR04MB7795.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2S9BGhM2P/w3X8mjaSEI/upRVXLu81EqhJXwUSNF+8CEjaVzny4Z9bDFAo5UXfIaId0/9UJ7QudNDKxr1aoSsd10SVxQEusMm094WIpz+U03euF79vADaiBvJ4TACNJ3g9MFQb4DjUfk59Z/FerUUsDnEEewtQkKBkvNEb69GJmu7e8/Im3373jRvNEoNwds5P+49FMMdjQv+JNDD3QIMm17ZF6aWr+5gY1oiA3NazV2GLCHPn6OQbqlwtR15eOsKggxkCWq/krRGp1oL3Lr2awQsBUsKFgJPDByepmnSebpVOygw6MGVPmedaEp0onsMn72RwY/Mzzv8IGJ2e4tcGbBkgt8sq5Z9KoabMZs0d9cfT0yWmEpEwIrdIquseWVwnHGsDrPq9fykGLpk0AxUVEqDBO0debdxXz3Ye8fFQKDrUzgwbUn5arVUSPHzazn/QiplNB6g4+elss9+Wa3ryB5xAWIL3w6frPzGnp02x6CRmCxG0IqFAPyQ7ewXQDiwORxVxxfMLSLIyrJIxRfLxL91q/MtgnqR7p2aLnV/iEXgOteWQCGflzV8GKg6UKsXrXKqlYWyygKTnI9ulpsQO0C5FxMnS8p/atP7fzBYxz0aFc9eSOacvTnqhJQVcPAogyu5pObhvy6C5XW/Fi2gA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(36756003)(66946007)(316002)(4326008)(38350700002)(86362001)(8936002)(55016002)(1076003)(66476007)(54906003)(66556008)(38100700002)(5660300002)(2906002)(7416002)(8676002)(8886007)(6666004)(44832011)(26005)(956004)(16526019)(83380400001)(478600001)(186003)(2616005)(110136005)(52116002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uXN1Oldb92TUJ3TMBtYswGZ3xsX2KsYdHOOtEFG4SkMjvlpPLZlac0JoLod8?=
 =?us-ascii?Q?xu1Aui7ZF20WLrgWmYUeaScyG9e2kLD+Cs1HXEI2epnS2nRFiqkEDcj/KXb+?=
 =?us-ascii?Q?0dM63vP+S03+YcAVvylVGiXP9syyw4A+oNeG9L3T5tuz4kBgiEmH7UaVb/8p?=
 =?us-ascii?Q?EGcSKhYR7aE593w4aC78Zwun1I6nAQ8U2OFfeej9E4MmBFSZAa8gvHBwZjEe?=
 =?us-ascii?Q?mGMwkX5VaI87dNyAE54jWcnvf6zif8N/43TTn7AlD6wXbaNs7I/7MyGGHz7J?=
 =?us-ascii?Q?snhbX0VAdy86X0R2Zzx5G6n9TPYj0/FZ0PWVAMNOM9UCsJfq+qmAgUYqIMbn?=
 =?us-ascii?Q?9/3RyCrjLH7ePKezOAuw98I87965IICbPIaRBOztJx/EhGQbaXXM6BPQ6ATP?=
 =?us-ascii?Q?WuiA6qVcWodEjg0Yo7UF1GI3JMeM51/MSU1RuKNYN/ysjtOQzPxub8/5HQ33?=
 =?us-ascii?Q?xtra95E06JudUTb1SiNdKh6D8ze0EAcsGrFxCK111hJnahmoIG2jDCRr6q6b?=
 =?us-ascii?Q?wC55lgfOZyKdyvrZ4nW8I6ew/y62uOrUkZQ8kNRR+Coc5GEppF8N1Covby9u?=
 =?us-ascii?Q?3O/MVsUa94ezKCjx5ACBGmX9Nj/QyEcFpGRDZy+rS4LuTyAPMU4SVF/ImfL/?=
 =?us-ascii?Q?0tM+nTSH4yZ5jDz9XiStu5r2++EPKEuhJ1GIsnsFyOQYtszSzvFjfjXlaCEA?=
 =?us-ascii?Q?VZ4x25vddWLSYWb1eVz44a/q/PRNdNNb9jvBwh/3RSVuvgn6yuUBWnqGPLTL?=
 =?us-ascii?Q?+d6ZMVla05jg4/64QYbhOokZudY7GHZm8bfnLzA1h85t7sZz1g8k/6FXHeT6?=
 =?us-ascii?Q?WybTYBMexN8J0Cb4ATzZdsDcXIpKpUdB3iLpKrn8Pa7S1GuD2FqMtSqkYdQC?=
 =?us-ascii?Q?GQp7j0rdpfEynMCT/hhpWqiyiWm7KTxygwx+ExS3p1IqkQvAFeLIWjjaNrXW?=
 =?us-ascii?Q?2T0zXJWtU2/T/OC2klg1HodTuER6QPXx066W6FTbvxT0WsdrF4g+9U7p6C5Q?=
 =?us-ascii?Q?Gf4pGgO1xI3/qxJajCsPl9/zVjqC47OUOAAudFWGKzB5PLT+n2gq/KqZW/Nt?=
 =?us-ascii?Q?VjZiRxrRjDovB/HI7kox6k5jHK23COoYWInPkzqzwCc1VZeew9SI/xqDiMcE?=
 =?us-ascii?Q?8Mpa3qWJ3XrTpe+Fug2m96sYPYs8ilpnMLCnFrFsRCMa2cLu+MRz72qLGZxc?=
 =?us-ascii?Q?NonQ94JnW5juvlq25etx9woC0JRdkCqXzbN0Otj6uVbbAhnwowTQlnauL1zq?=
 =?us-ascii?Q?a6rSBCQvdpBXFMlwoK8935dJfD1PJBWitjaf2PDqR+1pilygsDwdWUYFtLVR?=
 =?us-ascii?Q?qaID20j3Cy3vOnGxGcvjDrvu?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 347a2de8-2f71-4ea2-af97-08d92dbbd8ca
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2021 16:05:07.0554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UDdLiZEm+idevFlj/zBSIgfl/cqw8QJueqrPNKZGGFut4kEnwTElvvdiK1K/YrC75yZTj+4pepBBikbvA1fAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7795
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add "#define pr_fmt()" in smp.c to use "riscv:" as common
print prefix for all pr_xyz() statements in this file.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
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

