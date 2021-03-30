Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D6034E0FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 08:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhC3GFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 02:05:17 -0400
Received: from mail-dm6nam10on2063.outbound.protection.outlook.com ([40.107.93.63]:42433
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229479AbhC3GEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 02:04:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fy6+Ru7QzNPhIW1Y/kAYmvx3kHyDLb8ObA1bC1SkVELp9naCG1qEa44wbsT+e3DZSDukAI47jtsUNCrhJII37wfocv5CIeSYevWV0/U+1HCrrBM8kr6bL0h1ODBu3YNZpoMrD5n9A8Fpu1ZkoB934j72V7HV5O+5k7b2+JwXXaP8YHLAmP6r4gFfVRXU7a8nbb+YknSondpOTLmokrNq7qW9DJeBx0OFZXMwIdzVjkqVrMZXNkJBlyqcIo72Ng/nmvHn7udw5URREFdXzPzViWh4kw9hudVOfWux/fltoop4JJhhzby0zpiqD1mUK0ij233MCuwxw+KMK3BI9Mi5Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbUL23JQVY/vzRxGYpY/GLh1yvtFaiRkKS6X55J/I20=;
 b=JmBxQg5raa8a+iNCZLqti5nS0n6t5fXrIzxIYun9HgRS8G3lPOYxO71XNRNGxELZdRyk5YUXDpOKHIX9Rch9POjUNvQdeUg9pTP3jYE4oVPjqiutXswbdHk9+F0T3JfqsX5MsHuKH76wxgBl0wqSkfAQs4zfCwQxevnuBB/OJM8X/cH6y98a3Y7CpSW5sVe5Ccg6k4WU9JsuZa+I7snL18TPM8as0y4x8/ZaCEgz7Cv2ZoDrihw2Ilgtrilsjm00CIi5ml692BfjciuBaUvFyu0p2L3RHz5O9Mydib2JvOTbV3rkWA+2vFI+esFn7nQbRDO6QYIV1NUt1oSNJCZjfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbUL23JQVY/vzRxGYpY/GLh1yvtFaiRkKS6X55J/I20=;
 b=UAwWbgufJqM3++Ys6TsOD5jNNrWKDrFqUH0apcEswgsQwQLog61sPlFRoUSgar7MM16KzXGmMkoNsl399zSr2ZrTPhj8rrX6AUU4DHnlS/F2OG7zuZc9MrC4aXWoMQS8lCVwE0cf78MS4hAiY6VoM0owXAUNSd1SKfPsZREDn+M=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by SJ0PR03MB5757.namprd03.prod.outlook.com (2603:10b6:a03:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 06:04:52 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%9]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 06:04:52 +0000
Date:   Tue, 30 Mar 2021 14:04:44 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource/arm_arch_timer: add __ro_after_init and __init
Message-ID: <20210330140444.4fb2a7cb@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::42) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR05CA0029.namprd05.prod.outlook.com (2603:10b6:a03:c0::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.16 via Frontend Transport; Tue, 30 Mar 2021 06:04:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e81156b9-f143-4c58-31cd-08d8f341bbad
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5757:
X-Microsoft-Antispam-PRVS: <SJ0PR03MB57572C3E42767E8790860F5AED7D9@SJ0PR03MB5757.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:421;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 98oLclO8b93TihgZgKF5XDpCpilKq4RnvTHuAwxHeih6C73j/NW1LN28AfWs1txHOhw3wOIqHiPYLFsrTuQmu46Ee/zeaBDadiU5YjfBUP08RORbsVTXgmCLq5Sb9skRuMTssVJw04mmHT7pQh/gci69hn4b7Oe5b/8JBInjj2DVVhMRbns3o6dB/zjG8ZTAtwNvES+D0tMmC9BR2u+kA2Yst11NIFuQwMs03FkOuXyBCalFqy8y7OtPVl+EOVQwIwPApgPjmaF12ojba/S0TpuEcjDV3Pnvsgyg8g26BzuipZJBnTtIpypOuEUsA3I3y6+R3mMmJuHB+W0YSVAG9tgHlPPLJOZSjDaN9+Okpc1MZwbjLmW/s77E/hQLIPDwgK88qugdq6VSDyf1BYNNbCGPCRacIrTjbGqerv8cVDV+NMcNnL1/zoT4AngwmeXhEAJNN8vxcWipjNaUyrJyTWU8umQDMwSRPr8Zh17mCwpgF9dOklELNc+pmXk/6KOEyEj/795lvJ6sdr6FP2GVLxfz+tNFl/OI4UGpJRn7yw4uy6Qrb/Wts7pUFE5ZhhYUzyBYGtR9oyAIKZu+bd1Poxjnytd15Q4r3Og5mR3GYPaTnVYLpEx8RS6BX6A5eaAJZd0GAf9iqxNwY5lympNUVVDiolG6x8JKrxO6JBTXqBE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(366004)(39860400002)(346002)(38100700001)(478600001)(16526019)(110136005)(186003)(2906002)(26005)(86362001)(52116002)(9686003)(66946007)(4326008)(1076003)(7696005)(8936002)(316002)(956004)(8676002)(6506007)(6666004)(83380400001)(55016002)(5660300002)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eVThID5p30PYrGfm9BmmwFsBnf2+6sGrZezKbnKBpwKK8IK5hsnyMniKCJxt?=
 =?us-ascii?Q?TeVwFl6vUn6Z73J87YGFqPyWWfeUb8awl+up/PGeEjD7ZpFVCWUgv53ERwVz?=
 =?us-ascii?Q?ZjmyDM43H7oTveKwUTcf8WHJqRRFkLufurBJux81xWMRSEQcSNNG4pKlfRFV?=
 =?us-ascii?Q?pQeniw1LjTbpEE9EaoRtKupfWw94f1mb9LxnD4UE8p1rHXHSMTzHhILBsyV6?=
 =?us-ascii?Q?goZzmTqSFFZkgqzoI1pikBIrLuSLTbACJ274LCm2sWa84KsAgrqcu07QdPt0?=
 =?us-ascii?Q?gjLk6fZFh3wyUt04hUfLf/S/OYm37N/oCMoFI2Z21qHidbxgdzBjYhthocSA?=
 =?us-ascii?Q?SgmRGpDWsEK+3oLoV9yOxfVYzWRrSvPB1naNXMLo3CL9prMFN7i/4Q9WngGh?=
 =?us-ascii?Q?P31TQG9a1yRRtRQKJL/1p8ehpuybJhflXzCU3SFajRDCBfw3kja9is4ouqmw?=
 =?us-ascii?Q?5e/70yxQTUFSjxssheoRotsEK7IFE5UrGXogoi4L48/wJIBgJt6zaRg3Si9K?=
 =?us-ascii?Q?jdrYBmqTDqLfz0GLV5qMBZZT0qkP4Waqcflm82WcN0t6Aw+VXiNcWH9H+SrU?=
 =?us-ascii?Q?vk80uq4Yol2RmsAgMCGgeBVfFsexyQ3KyDuGdeVSKAf314k1mftYifrWOSlT?=
 =?us-ascii?Q?tojkibbD8dJFrrizaOA0bHYTxd7B9AppISA/YO+CHVUMMb18de0aDXXyGDmf?=
 =?us-ascii?Q?q2UYIDoTUqown/0tHMLUIoij2zknG31KjDy6wEOW9+E/qpkTTcf9BlUK7aiF?=
 =?us-ascii?Q?P92JMU/LA/G6FsYOD++qcqP7sKJHtCMkoIwdEuWlNmJwXRM+cF1Z10/KjOyQ?=
 =?us-ascii?Q?060Ks9SHvp1kJQafvAZCoS664HOGPjeZBfofbxpxtoJnxsdMKiyVtkv2Fv1v?=
 =?us-ascii?Q?cjbSa4Usau57B8shGItK9mAdKG04Zg/xCkzEVVoW7LNpXlXVKJijfOrjLt7s?=
 =?us-ascii?Q?a5HMpTH1qzbXOWHyR1zKaljr/eFRhkirVbx/QFhja1o7OZeIUiqd/dfWSJMj?=
 =?us-ascii?Q?8H/rqOTRSSe4bASNLFdnItKcgS8YGnmiUBAqBftu3InNQEzHvtzeTdtcXJju?=
 =?us-ascii?Q?5+efYZkFpjliYefdw/l10X8ZuUa50n8vWj4bOUITBjPh08mQqd6br46E2wVx?=
 =?us-ascii?Q?nrl+CrWqntcrJsRG10L9KAkt9cBu5me9qk3Ln8isN5lXmKlwL+4BayfUzYC8?=
 =?us-ascii?Q?LJWWwt8urlMonrbB6uv0RdNWkX70ufu8hJ1PMZEVXl2pPLk3wpVpAWqMnbyG?=
 =?us-ascii?Q?9N2VGYh7jAzF3hFhoK6tOOLj6WlUqMnbTVMcei1jjSTBhH+Gf0OVEbY1WLKF?=
 =?us-ascii?Q?cysQ6QfTyn3uBVv1ZjGyNgl4?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e81156b9-f143-4c58-31cd-08d8f341bbad
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 06:04:52.1203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQEvdj6USPn/fKM+rBWe2scHHbgrBnkbzT2PdZwQxWF+J1vEcv34mycp+KUQFWTkSUXsZfXPOU0HYTtp7uVmmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5757
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions are not needed after booting, so mark them as __init
to move them to the .init section.

Some global variables are never modified after init, so can be
__ro_after_init.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/clocksource/arm_arch_timer.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index d0177824c518..1b885964fb34 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -51,7 +51,7 @@
 
 static unsigned arch_timers_present __initdata;
 
-static void __iomem *arch_counter_base;
+static void __iomem *arch_counter_base __ro_after_init;
 
 struct arch_timer {
 	void __iomem *base;
@@ -60,15 +60,16 @@ struct arch_timer {
 
 #define to_arch_timer(e) container_of(e, struct arch_timer, evt)
 
-static u32 arch_timer_rate;
-static int arch_timer_ppi[ARCH_TIMER_MAX_TIMER_PPI];
+static u32 arch_timer_rate __ro_after_init;
+u32 arch_timer_rate1 __ro_after_init;
+static int arch_timer_ppi[ARCH_TIMER_MAX_TIMER_PPI] __ro_after_init;
 
 static struct clock_event_device __percpu *arch_timer_evt;
 
-static enum arch_timer_ppi_nr arch_timer_uses_ppi = ARCH_TIMER_VIRT_PPI;
-static bool arch_timer_c3stop;
-static bool arch_timer_mem_use_virtual;
-static bool arch_counter_suspend_stop;
+static enum arch_timer_ppi_nr arch_timer_uses_ppi __ro_after_init = ARCH_TIMER_VIRT_PPI;
+static bool arch_timer_c3stop __ro_after_init;
+static bool arch_timer_mem_use_virtual __ro_after_init;
+static bool arch_counter_suspend_stop __ro_after_init;
 #ifdef CONFIG_GENERIC_GETTIMEOFDAY
 static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
 #else
@@ -76,7 +77,7 @@ static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_NONE;
 #endif /* CONFIG_GENERIC_GETTIMEOFDAY */
 
 static cpumask_t evtstrm_available = CPU_MASK_NONE;
-static bool evtstrm_enable = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);
+static bool evtstrm_enable __ro_after_init = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);
 
 static int __init early_evtstrm_cfg(char *buf)
 {
@@ -176,7 +177,7 @@ static notrace u64 arch_counter_get_cntvct(void)
  * to exist on arm64. arm doesn't use this before DT is probed so even
  * if we don't have the cp15 accessors we won't have a problem.
  */
-u64 (*arch_timer_read_counter)(void) = arch_counter_get_cntvct;
+u64 (*arch_timer_read_counter)(void) __ro_after_init = arch_counter_get_cntvct;
 EXPORT_SYMBOL_GPL(arch_timer_read_counter);
 
 static u64 arch_counter_read(struct clocksource *cs)
@@ -925,7 +926,7 @@ static int validate_timer_rate(void)
  * rate was probed first, and don't verify that others match. If the first node
  * probed has a clock-frequency property, this overrides the HW register.
  */
-static void arch_timer_of_configure_rate(u32 rate, struct device_node *np)
+static void __init arch_timer_of_configure_rate(u32 rate, struct device_node *np)
 {
 	/* Who has more than one independent system counter? */
 	if (arch_timer_rate)
@@ -939,7 +940,7 @@ static void arch_timer_of_configure_rate(u32 rate, struct device_node *np)
 		pr_warn("frequency not available\n");
 }
 
-static void arch_timer_banner(unsigned type)
+static void __init arch_timer_banner(unsigned type)
 {
 	pr_info("%s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
 		type & ARCH_TIMER_TYPE_CP15 ? "cp15" : "",
-- 
2.31.0

