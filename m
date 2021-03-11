Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512303379E6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhCKQsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:48:22 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:27707 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhCKQru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:47:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615481270; x=1647017270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=jkbKSZvRwwjsXmYu1Ws9MweMMyO4gkhzwEKijSyT1hU=;
  b=FX0trpQpuzQj7CbwkCH9UD55Kz1b5dUX73V+CIkT9RjE1w04LgVlxpNA
   i8bfZ3Osz6lkrgtVJ2k/zcxCRTTGcy1AH9D+Tp6r2v1f7aWIPFVo5pQI5
   j+PkVuAW1Y/oR9C3ss1GS74f2s0v0cUnga4KAWJ5J5oMFXNUG3M8DOGCp
   ASe5MvuijPRkfgxuu02h7QEEIfV4qDmd1eHMoxY6XD57vOSdcP00SLpwc
   b8zybTbSm+LjjETHnglzvwf2p8vDWOQheF7l9VvQIDZACYT2w7RSmdlKx
   LyGwH+2650wBYaK9rGEKt0mxz0OwbS2jS40HlyAZLWPxFjNsnwqdLyGPK
   g==;
IronPort-SDR: p9fueH5b0bRLujo/jyoq7JptPsoqq0ZEu+R6ly66z43JNo6bYli3TZTIXeyxZfYZ+ddE/XmEP5
 l80j6Zgjbi0kET8TlsR0Np3Lrh1aybjpLdi8f8xmoJRE3nmJrHlvz7FwjZ2zGioCvAj2G1bgaB
 2XnoUlVqzVXHS4buB9IO3MRgwfJGksjDOZ5rkd68hJnd6yFa7AEzvXxnE1wlPz4E4RERHTg6Xe
 t4/tA63nm0mmFwK07nv5i2LLLAR4FzAJ8Hoi9UfdFFiuzcJgpcSSsW+LY5EGOSaFTmzKFj6mG+
 FcQ=
X-IronPort-AV: E=Sophos;i="5.81,241,1610380800"; 
   d="scan'208";a="166429050"
Received: from mail-co1nam04lp2050.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.50])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2021 00:47:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVhdYLHx8tox7wiq9Eg8NoOqoFBu62n5EmdK+GParE8duI0Ka/Chr5QQW695Qa/OgMnXLh5mulB4BbU5C5JsnnSlJKvB5Nx8mE/AwFwsWuR1o6cK0MjXv4LwG5NGMcWJD2bPQ3GbE21u+rT2o1YrZWZdlofASB4H+SAiVgrwh27QI3JsB2q7lEIlxrVrgM1fG/mWxG7Yf570DpC51Qmr2ST4Ze3yfRBjeqzo1iz17Oa5LG9yAR/LVATIA0kZ1ddCr22AUsLvDGfSqumh8eoOJWDHyYWUJw47UNODceJ+LrhsJWGEzUf0/tgcdQmRvOxUW+OORLkotksQvOd+NrqfJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Jtqet2fuPqM7Ms6NUR+wXwwQts7PJjG2T9FblTTEjs=;
 b=jKPS8H5YiiKaVC9musGqN0XpuyT0u+vd9E+l2CjBceRHLFcVXPng7jkHvvtMQ4dE087CyHmRjOphz49ogVbmaMJntOjrb6Yo8TrgkwCCPx3CsLtr1VGrno/uK3xKxsXbUc802OL8l4+yKyctRniQwDOmkbejo07jt3eZsxSCkeXsXXpGEcIKy6Sk16a59uYR1Gshun0nZuvY943ljxLV9iQtfnDjWSoCZxdvCIq4Yk7CTnu3kw8nkVusnYYSz6/o818ZU/rTJTLDtfb7WJXTPQpQE6WsAfUwy+IdF10F6tYV5/DinA1u5dA8/WNwvF28QrLtzlD8Xb5qZYnIoshR4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Jtqet2fuPqM7Ms6NUR+wXwwQts7PJjG2T9FblTTEjs=;
 b=qVOJaxGvMfqg2DvilyjvoBqz/XHrQHmdlW5Hh4E4nVw4mOkhqbOW63tHFSMlcmFchQFvmQ63VGpkuIsfOsqFl/fLqpvaR7FIiXT5Fvz3lcz3AjmzuA2q8N0/pWNniJshijOqafp46wyeYYG/7+QBkWLu/rypxszgoTWdXUpUSAo=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM5PR04MB0218.namprd04.prod.outlook.com (2603:10b6:3:77::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.29; Thu, 11 Mar 2021 16:47:48 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3912.031; Thu, 11 Mar 2021
 16:47:48 +0000
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
Subject: [RFC PATCH v1 2/3] RISC-V: Use IPIs for remote TLB flush when possible
Date:   Thu, 11 Mar 2021 22:17:11 +0530
Message-Id: <20210311164712.652608-3-anup.patel@wdc.com>
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
Received: from wdc.com (171.61.72.64) by MAXPR01CA0113.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 11 Mar 2021 16:47:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3dbce72d-4a45-4581-878d-08d8e4ad6726
X-MS-TrafficTypeDiagnostic: DM5PR04MB0218:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR04MB0218905E41F442BDC633E6E18D909@DM5PR04MB0218.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fl390zB5XANdcx3DVCqVlOgS/jE41muVd0IJVEoa7Riqyy6cDfA0PWVRKuybYFQQ/WZYs02/e7rxGqIofZGORMXFtsGj2jzJRl8XJ3cL2JFy/yLtZVpyaMvcOjCIdffU/Q2tvTxwFB3SHXAl9IzdjiGj88kELXix78pal5MDa/qttZQMFFWvvUcX2au/K2HWRnx1cPzNmWsyQe25UwbRDRjUyu4B85klOVlkIAtdGK+xNzT/MsbIeNOTzytPlfi/Q8ViWFGkF13Rx1o3Ji6jtAWtzTZV5CDs3foKMMX32yQYAM7KiQbAKNIeHogbPSJL8MLuvlF5P0vQifLN+TpMX1WXy9fQNJtmbIKPfbTdK+pTOrjq5O8fXcuBOd+1Q8ijSSOoREgKVOiREQQgm6prFxh39ODTf3zTqTkFiB2P62gle6nhuMSUn4KnpAU/P6fG18U6YQRKM97ZTtdWR2Nd6LIDpSyYqXr77t57a+XFwlmQdLAwhoNqj2O99DuH3BwCexVV255Dn5KY9d7x1Bxa7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(316002)(66476007)(66946007)(44832011)(36756003)(55016002)(8936002)(6666004)(110136005)(66556008)(16526019)(8886007)(2906002)(54906003)(478600001)(5660300002)(86362001)(26005)(1076003)(52116002)(7696005)(8676002)(956004)(2616005)(83380400001)(4326008)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FL3qmAYAWaYFpa8SW8w1Szfk8QIkat6milWXTze4aO+mpWYWz2OuIJskLXML?=
 =?us-ascii?Q?Ry7D5vF8EKc+j5Rz3dIJeyK7o34RedBTOcObw+KZgGAEKPj2anIICkjhCWAm?=
 =?us-ascii?Q?5yb5e1U4Mb99JzWvRYsMGmMLtj9LIzpe07gPsXvGit1/Fpl+D0DcoD8UKuKl?=
 =?us-ascii?Q?A/NprlLljPcYvs6MstsnIY2xTNh7t94od0kAtZrn7mT209aNSJBJtQWRmsgr?=
 =?us-ascii?Q?nvR6PuGfrA0aFATFHbiMlv7+CFtxIEn9TO6/tzZoR4YIMtQB0KbIi8NE4JzB?=
 =?us-ascii?Q?ZLNJabT33yLt81J6NeZ8Pa3mZzfqJ1Gq/c7Fp4QiTBMR4ZLCeUYt5xefHjhf?=
 =?us-ascii?Q?TwYBP5Scp+V2u47RncDYEXGmS+EZF9QOzmgTXsK039Df7efVCQZvZaBpVvwS?=
 =?us-ascii?Q?yTWQLD9zfF6FBqgDiDamY/TLUJs/yY5RBEuSHlqdbGaq+HgW5g15eTN27h/1?=
 =?us-ascii?Q?TK51QU0eAfjVeAtKwCA/sr0WlpCMmDv1jJzaeLWeP0Ey/2WlpHkyLJCMqn2Q?=
 =?us-ascii?Q?Arp781+U19usUyKOGkaOE+OqAyOZZw0TlgF3ad7qJE3ypULmwQOjzR3VjOO5?=
 =?us-ascii?Q?jpJPdx3RX8MCiitbvNcplgjekuGJxycpAdNUPgYoKRF58KouDy6ONtVDS8P1?=
 =?us-ascii?Q?EegqJ9BIOaWfD8m0RBmEBP1IhKEh3Gc3B0Scfqm55vuCHEsPRd9/rgFsiXkc?=
 =?us-ascii?Q?TIYgwdPmwpwm2jtcBb4x4IIh7eaWWEwK4jFXwJxMlGcUSuv/rHnm4N00RxPE?=
 =?us-ascii?Q?d3J5C+P0p/PB0yc1sfpS4gzNqfMJ+6V+XEQpFWeJcQE4gxunNUZVdd4Yf3MA?=
 =?us-ascii?Q?yRBMZTu2q0BlCpy26FMs0bvYJMerIim0Dl1GVajeunlnHBe1DFL7scmANQ0a?=
 =?us-ascii?Q?M094ukzJpnw/oezyaoLWYMiyOcynWxp+xKLzzbvMniDb/D6OwXFhOlOiW63c?=
 =?us-ascii?Q?/rY0qYMzolIWT+paA4UBm8fQvuojB4rHrCilZOdjOB2XkXWZuqbl3PnbPS6w?=
 =?us-ascii?Q?fjf0Rs0Zm9VpL0pgYE31IoSaBbxTpirsi2xyrKOfW2cCcGy9puRFtF1ThFc/?=
 =?us-ascii?Q?S2/GaCMwmGnLTmviXuo3PHXzwtvoi1yuBvJ6emAJhq9wHKnd0ukv2ZmBin+7?=
 =?us-ascii?Q?/w7s5PY65MygcZPjhzcQ+0sWHXC4G4H9sovML8uBUz1JSajIWwBqH3oxThGD?=
 =?us-ascii?Q?LMSgKs7DLPVzUmW5duPF2cnI848A3QfQ8SsuWHkuL0iCstxodTxuUnDHQJlY?=
 =?us-ascii?Q?74soaXw6ODlm32zCq1LFWqkKxMa5+dE5BwZoEFxSEAjUMbe9A59dlt0JyU09?=
 =?us-ascii?Q?xga+CvK9YBV6xJjJ8L4dRJov?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbce72d-4a45-4581-878d-08d8e4ad6726
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 16:47:48.5907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5LXGUckZhTBRD+5IM+aYRbWW/UIBM2nwoXn5cVAE2U7B77fvgrlq8dKbtLHy+4xmKoGru2KTf9eq/7HRsO1gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0218
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If IPI calls are injected using SBI IPI calls then remote TLB flush
using SBI RFENCE calls is much faster because using IPIs for remote
TLB flush would still endup as SBI IPI calls with extra processing
on kernel side.

It is now possible to have specialized hardware (such as RISC-V AIA)
which allows S-mode software to directly inject IPIs without any
assistance from M-mode runtime firmware.

This patch extends remote TLB flush functions to use IPIs whenever
underlying IPI operations are suitable for remote FENCEs.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/mm/tlbflush.c | 62 +++++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 720b443c4528..009c56fa102d 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -1,39 +1,73 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * TLB flush implementation.
+ *
+ * Copyright (c) 2021 Western Digital Corporation or its affiliates.
+ */
 
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/sched.h>
 #include <asm/sbi.h>
 
+static void ipi_flush_tlb_all(void *info)
+{
+	local_flush_tlb_all();
+}
+
 void flush_tlb_all(void)
 {
-	sbi_remote_sfence_vma(NULL, 0, -1);
+	if (!riscv_use_ipi_for_rfence())
+		sbi_remote_sfence_vma(NULL, 0, -1);
+	else
+		on_each_cpu(ipi_flush_tlb_all, NULL, 1);
+}
+
+struct flush_range_data {
+	unsigned long start;
+	unsigned long size;
+};
+
+static void ipi_flush_range(void *info)
+{
+	struct flush_range_data *data = info;
+
+	/* local cpu is the only cpu present in cpumask */
+	if (data->size <= PAGE_SIZE)
+		local_flush_tlb_page(data->start);
+	else
+		local_flush_tlb_all();
 }
 
 /*
- * This function must not be called with cmask being null.
+ * This function must not be called with NULL cpumask.
  * Kernel may panic if cmask is NULL.
  */
-static void __sbi_tlb_flush_range(struct cpumask *cmask, unsigned long start,
-				  unsigned long size)
+static void flush_range(struct cpumask *cmask, unsigned long start,
+			unsigned long size)
 {
+	struct flush_range_data info;
 	struct cpumask hmask;
 	unsigned int cpuid;
 
 	if (cpumask_empty(cmask))
 		return;
 
+	info.start = start;
+	info.size = size;
+
 	cpuid = get_cpu();
 
 	if (cpumask_any_but(cmask, cpuid) >= nr_cpu_ids) {
-		/* local cpu is the only cpu present in cpumask */
-		if (size <= PAGE_SIZE)
-			local_flush_tlb_page(start);
-		else
-			local_flush_tlb_all();
+		ipi_flush_range(&info);
 	} else {
-		riscv_cpuid_to_hartid_mask(cmask, &hmask);
-		sbi_remote_sfence_vma(cpumask_bits(&hmask), start, size);
+		if (!riscv_use_ipi_for_rfence()) {
+			riscv_cpuid_to_hartid_mask(cmask, &hmask);
+			sbi_remote_sfence_vma(cpumask_bits(&hmask),
+					      start, size);
+		} else {
+			on_each_cpu_mask(cmask, ipi_flush_range, &info, 1);
+		}
 	}
 
 	put_cpu();
@@ -41,16 +75,16 @@ static void __sbi_tlb_flush_range(struct cpumask *cmask, unsigned long start,
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	__sbi_tlb_flush_range(mm_cpumask(mm), 0, -1);
+	flush_range(mm_cpumask(mm), 0, -1);
 }
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
-	__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), addr, PAGE_SIZE);
+	flush_range(mm_cpumask(vma->vm_mm), addr, PAGE_SIZE);
 }
 
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end)
 {
-	__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), start, end - start);
+	flush_range(mm_cpumask(vma->vm_mm), start, end - start);
 }
-- 
2.25.1

