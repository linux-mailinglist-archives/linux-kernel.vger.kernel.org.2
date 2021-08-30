Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0643FB06C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 06:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbhH3ET7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 00:19:59 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:29626 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbhH3ETd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 00:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630297120; x=1661833120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=qFRmYs/4BD2hScoaVVYovknXknU/kqFGlTmH1SyVsZE=;
  b=Y0ouP/gcIBvQgB2W9kEfaPzxOV9USWFSULECAQD3S8Zj3gYctsQs6CKH
   2Ig40TxxFl/PAmMG6cqm4oHSg04wg09lmzN3q/j7v0RSfMq1sbV9fxw59
   9KoW7Wq7CVvb+CpiOIIzZhdrzPVHRQLkUDbO8ivcocMXjmWUTedR1pMN8
   o5e7MxaW96AVWEAGoxn3910OoClGKWs0N936ZXrIWOfuk0sBIiJGFcRxu
   mNUpjrNIlsN+V0sh+l0ei+4BvVrns8fg5g9bIm3vdT633zkihc3JD5M0I
   EcqH2znNwRFArDQvwoqHVpbN9gkrmChp4tqujCcBNPbsk7ExFWcpKXnMJ
   w==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="179285393"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 12:18:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oqdu79URI9jFsiMGPldo25iWEB6ORifRi+9paRgaV/GPMaVoSQcatgmCg9A1Af+1YFw7phd/W9U9eEfTk5YfnSMNmZ/ji6W8aXQYxjYiHG3gTDPxijRAVROPTdQfcZO2vDPtCklKN7x+8zaq+7Wcw/oB+ZUkq9Y6XP1v7/t+g6RHAHj4dRFctGUZX3MzWWZSQwwfmVFnc+F/4QEapfMCNuchlBZ6Nc8y3eRvtdm0vfFvIleslo0P+HQKLFY6zNmXQmS/i76AOf7Gw5dIfwpzFBYCs74qhhrqppC8wFoZcz7/1Mk3QRPSYW9CQSsEZwdro7suBfYRjsdo2pdBIRXSqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhWB+D4BHG4ApZjKys8Lk83eb1ti7LYTVRKk6NkHG8c=;
 b=EYVuRQrQxK6RNEf44z39X5wFkSsjvfE9mfoB69Ik1A+aNmJJTDr0lFBE9/a5vaKsZlGw7uWtl9iEmubJl1UjSgwxE2Jap8pvBoKfp3h4JVJw4c0AHFhtI8mypSnZsDesg4A0UBkKsgRewHNjugREw2r/2Gigy9usXLLX4mYtUVpnIwUs98e+mMzsTCeg2exxVMxCRFv9/c+IxHcDlbBhBs9oLReaG9kNcB66UQwMC9Gr8GPtA7VrE9ygx6Ld/FWE2imwBsWneTvCURD74Ue6mfgA7VcGbciKxgdyp2aKGz+UTQaviZ965fLkfIKhQSeHXxc0VLBYAzIE+v/Lbdeg1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhWB+D4BHG4ApZjKys8Lk83eb1ti7LYTVRKk6NkHG8c=;
 b=Px5Y49c4Ls0mEvNo/B1ex0knftXuiU4M7pVrGVeEj+cCKnbLmb+Dk/p2wvGizl7vyVvxLJLKjhu8eoXihe8iBaAh1ruWFVqkecKHhJb0/LjKSRrTWUsHQEUxnmkZGg9bVewIK3iB/ZBiJRZvcd9NgSHMERT+vCuBxs6WEdM2uc0=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com (2603:10b6:a03:3ac::8)
 by SJ0PR04MB8273.namprd04.prod.outlook.com (2603:10b6:a03:3e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 04:18:37 +0000
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514]) by SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514%8]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 04:18:37 +0000
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
Subject: [RFC PATCH v3 10/11] clocksource: clint: Add support for ACLINT MTIMER device
Date:   Mon, 30 Aug 2021 09:47:28 +0530
Message-Id: <20210830041729.237252-11-anup.patel@wdc.com>
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
Received: from wdc.com (122.179.63.14) by MA1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Mon, 30 Aug 2021 04:18:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0605e583-14cd-4b08-f873-08d96b6d3d15
X-MS-TrafficTypeDiagnostic: SJ0PR04MB8273:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR04MB82734DA5A7F9C6C3D267BBE58DCB9@SJ0PR04MB8273.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y4jeQ/khCEY0z58CEKhWIgeF+bbnKilCH32PnruiDZ+Eoae+pa/sNR5+FgMUKi5L6u0d3do6U/EnFS03lFig/p47hfhwxJdXPj3BjERwO1s83JUfKfEKHB7Xn+6Bxg5vSkxA6666sorXcj5vig3/E7ajR1+PsJcQSeHCU20w0wR/sJ4BFsALIvWlV/zu8fXyGP9izmyvRWpRhiJhXXqxY2EZabKNMlWDELyO+gSvXI39K4EKUK0+CC1V1Qj+tvA1DheRyR3z3vnRyC8ABLriR+E4UUf3zuTVkCpquimEKzNHadWC9qPIDqD2/VbS8ZY5cK0OlrPrcM8DxaFBqA77aadv6fNioldXrSnnb6FU3Irav6dlCHzuoDYrvJlYRschet7IqacIWQ7D+4wXDEM0zh/wT+uytGOzLW1AcWkkNWBOJp+6xaHhn3qPZ6Tnwz4/DueD7U7szxfQqlJxX0lx56Lrdyoz7DzP5qXNqNh5gYWuJCt5Cps1Jk1nIy53ssR4TfCR3odUABTLC8cjweFIgdc+MNHi5lFog0d4RphmP0j20KXNB6AkvwnCIk29RZ12q41so4NrYesoFrFhonglYEjAgxYFYOk9BcwRf1iWpJPwCVDkFdN1/eEWOjMRxM6OsWVMLJPHsr0MgSKnOMvDlBakZzYXWhZ2VY6lEVji+oCHePdQPgeLUf+LWBa3QSa21Ga0XpwBXkxGbnqlVAYxVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7821.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(2616005)(6666004)(186003)(110136005)(86362001)(316002)(66476007)(66556008)(956004)(26005)(54906003)(7416002)(36756003)(8886007)(66946007)(1076003)(44832011)(55016002)(4326008)(5660300002)(478600001)(83380400001)(8676002)(8936002)(38100700002)(52116002)(7696005)(2906002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y2DLnsmCICGWW+kRIo8K17d2stKPZh2Gtpr17TjKfjMd0n2vkOugk61z70Xp?=
 =?us-ascii?Q?HvFWx8VojmlafFR2EYPSzSTPkDg6qj38k+5w8m5699uZ4/uzxJ7pgBDvnEg6?=
 =?us-ascii?Q?8SOx+8IhHhDFx+QpYe9Tc+XS1r3IrIzqO/VoNn/nTixlsvW/zbRPyPM53e4o?=
 =?us-ascii?Q?m4aEKYbvnyHAgG3jlfdxPacBtukJF/9IDnCeAUj8lbLEVOeVXzoxROJbrgIs?=
 =?us-ascii?Q?b10IONGgDXitNHOBVoqP0csXmymqdL/d2fC5pAtiZEFvje24202zitv02ARp?=
 =?us-ascii?Q?kQxaPeB7XChLCQXd3bh/lpnk5HKmzmpJgJ3rtYFl1gbBzjS7QP0IV7H4QYVA?=
 =?us-ascii?Q?xATNn87noNpb4oaBOvPCqdImccw6oQmvgvPdtCk/SGeXmkfmwqkoxosv4uwu?=
 =?us-ascii?Q?kZfRAU1AolnYwDvC1WUOdHwG1VVDKfYZqXNxQxLsUNCoS3VPOa+QWWGd1uLY?=
 =?us-ascii?Q?9zwY3CNs62shGWyd21Y0BaMOw3BCjxbzTVlfxYD2NcvcIYhV1KqcR/7PKjQF?=
 =?us-ascii?Q?2hRxznPvue79TkDA8WZGH72tH9XCS11rx/Q7tenfi2P90/zHTxLuu8dYK5uw?=
 =?us-ascii?Q?FRV7iZCLS22jNQolbOCUf0NUrpO8F5O9GfQ9255P+30zKM2D4Dwo+K/qzxOb?=
 =?us-ascii?Q?eTTGz5N6RPa8CUprtbW8x3sHEaHenhKsAYNykr/c9//oh11iyDAhKciIaxoD?=
 =?us-ascii?Q?OiqN1+UoDwG1shPFQa977A4x8PQ7BXJvYeaFCQds4QdXgyyhkdtIkaEwtxKp?=
 =?us-ascii?Q?jdBuyGgRpySlpFzl1eZuIRrmLxKcNWuJl5zsfcTk5nevssP6+LnwHbFoGFVS?=
 =?us-ascii?Q?IxjJ3OXUjxlCvmqz/kKMKZSIpceTelVm5ByYDVa/3Ayu/yl9YmyLm4ilMW2p?=
 =?us-ascii?Q?J1DLyHke14F5DTJ7hfQ0uydt0JGS6i1OHgem0H7zecjVaLgMqk5Q/FqSCqAv?=
 =?us-ascii?Q?20fHzzf3Xw3dOSMzF8/vJPahbQF0wKkOe7/as4U4OEhuKmLlsWEh3TrBxBFw?=
 =?us-ascii?Q?ms/uL6JTHlZdj12rZ+PABAFteZBZqE/Q7JBDukYTuF+2gdZZ/L1WHATP/XYJ?=
 =?us-ascii?Q?nzNuRrY/Z81FHCbjGrtsy/72CtP4HAIWZv8Cn72Z/bwOK5MxADSyIaf8im8x?=
 =?us-ascii?Q?1VPf1S6ymqghNm/IcCI+r+XgV7K5qYh3gFpS0ZZuLJbYfT+LT6u7juJrZAfi?=
 =?us-ascii?Q?REr5JszEW+Y6x3XK/sNlKhHPw9nvZJaEjategHqfs3EW830KqNJmBFwaYOAr?=
 =?us-ascii?Q?sVzvW+NxZV0e9VwfURV5QuW4wDWSlAyL56CruiM9Q5gpfw8IGjMTSmE+U5N2?=
 =?us-ascii?Q?t3JwWKafOIf2ns5v8KPVYJmm?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0605e583-14cd-4b08-f873-08d96b6d3d15
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7821.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 04:18:37.1526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkg8TUG0JqgjjFHIQHVwPVnXgV77LzCdUCfLWevKF05VIYUnISc0L1oMPBR7Da9vpNjwmyHwuAR7biI+1Zt8RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8273
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V ACLINT specification is a modular specification and the
ACLINT MTIMER device is backward compatible with the M-mode timer
functionality of the CLINT device. This patch extends the CLINT
timer driver to support both CLINT device and ACLINT MTIMER device.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
 drivers/clocksource/timer-clint.c | 46 +++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index 3b68ed53fe4a..10bbaf1bcf04 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -2,8 +2,16 @@
 /*
  * Copyright (C) 2020 Western Digital Corporation or its affiliates.
  *
- * Most of the M-mode (i.e. NoMMU) RISC-V systems usually have a
- * CLINT MMIO timer device.
+ * Most of the M-mode (i.e. NoMMU) RISC-V systems usually have a CLINT
+ * MMIO device which is a composite device capable of injecting M-mode
+ * software interrupts and M-mode timer interrupts.
+ *
+ * The RISC-V ACLINT specification is modular in nature and defines
+ * separate devices for M-mode software interrupt (MSWI), M-mode timer
+ * (MTIMER) and S-mode software interrupt (SSWI).
+ *
+ * This is a common timer driver for the CLINT device and the ACLINT
+ * MTIMER device.
  */
 
 #define pr_fmt(fmt) "clint: " fmt
@@ -21,8 +29,11 @@
 #include <linux/smp.h>
 #include <linux/timex.h>
 
-#ifndef CONFIG_RISCV_M_MODE
+#ifdef CONFIG_RISCV_M_MODE
 #include <asm/clint.h>
+
+u64 __iomem *clint_time_val;
+EXPORT_SYMBOL(clint_time_val);
 #endif
 
 #define CLINT_IPI_OFF		0
@@ -35,11 +46,6 @@ static u64 __iomem *clint_timer_val;
 static unsigned long clint_timer_freq;
 static unsigned int clint_timer_irq;
 
-#ifdef CONFIG_RISCV_M_MODE
-u64 __iomem *clint_time_val;
-EXPORT_SYMBOL(clint_time_val);
-#endif
-
 #ifdef CONFIG_64BIT
 #define clint_get_cycles()	readq_relaxed(clint_timer_val)
 #else
@@ -129,7 +135,8 @@ static int __init clint_timer_init_dt(struct device_node *np)
 {
 	int rc;
 	u32 i, nr_irqs;
-	void __iomem *base;
+	void __iomem *base = NULL;
+	void __iomem *base1 = NULL;
 	struct of_phandle_args oirq;
 
 	/*
@@ -170,8 +177,19 @@ static int __init clint_timer_init_dt(struct device_node *np)
 		return -ENODEV;
 	}
 
-	clint_timer_cmp = base + CLINT_TIMER_CMP_OFF;
-	clint_timer_val = base + CLINT_TIMER_VAL_OFF;
+	if (of_device_is_compatible(np, "riscv,aclint-mtimer")) {
+		clint_timer_val = base;
+		base1 = of_iomap(np, 1);
+		if (!base1) {
+			rc = -ENODEV;
+			pr_err("%pOFP: could not map registers\n", np);
+			goto fail_iounmap;
+		}
+		clint_timer_cmp = base1;
+	} else {
+		clint_timer_cmp = base + CLINT_TIMER_CMP_OFF;
+		clint_timer_val = base + CLINT_TIMER_VAL_OFF;
+	}
 	clint_timer_freq = riscv_timebase;
 
 #ifdef CONFIG_RISCV_M_MODE
@@ -213,9 +231,13 @@ static int __init clint_timer_init_dt(struct device_node *np)
 fail_free_irq:
 	free_irq(clint_timer_irq, &clint_clock_event);
 fail_iounmap:
-	iounmap(base);
+	if (base1)
+		iounmap(base1);
+	if (base)
+		iounmap(base);
 	return rc;
 }
 
 TIMER_OF_DECLARE(clint_timer, "riscv,clint0", clint_timer_init_dt);
 TIMER_OF_DECLARE(clint_timer1, "sifive,clint0", clint_timer_init_dt);
+TIMER_OF_DECLARE(clint_timer2, "riscv,aclint-mtimer", clint_timer_init_dt);
-- 
2.25.1

