Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E1742533A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241479AbhJGMjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:39:16 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:50995 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241485AbhJGMjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633610236; x=1665146236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=UJUjAKryG57iCnWsRWwXKtNHMbhtu6evH99PaKTVGFg=;
  b=DZ0NOq4k5nIgiG7Ple2WLtG9Lrx6EiSVkPoCav9uP0iVylduuMPplP+h
   jbw7UXu5azVWkXqB5+hBPSqgbD7amqu5M+S0DGmtmUDRYafqWM2j3xoa6
   mHOVpBXhy6N4a/qAmDsJTm6TFy6EuUr0OCiEvV/lB4loJuoGD492uV8vw
   rC0fhZk9KCqri3itCKSUHi/fvOihfbTGlF9oNzPMn5c17Nc6cPiMBvesF
   od8zLtnIWB853I2uab8qmIdHgY/AdW0j7F1rOjiIP2wOUxRvdC3kotXon
   VmzV9jqepySjfT5OUM7wO2sq6tL6Zd7fZaoMcSMDxTDmzIdwdRCeYabYu
   w==;
X-IronPort-AV: E=Sophos;i="5.85,354,1624291200"; 
   d="scan'208";a="186926243"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2021 20:37:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5n75bD8kRJm6trf8vXdjVrIQKhJOeC9ivyYlpvJ/Etn/dWGHl/KSJwUqhlsKovtp0PEEVNuAqr5u7hfgyh+M+WTfsN76Me53euutv0Rl5nokJRPr2S0Mhmt232LpavIcLujuoApdHUJhZfN6BIpLRnIEdQQ60vFOC638b+tAPTYZMq/5JWM6l/s1BOYtlaJgaeIEEulWbgIIdA7pgm5Dcnamc4oAYbjr/QxMeN4NkayRJnDVr5kQyEhzpnrqLlOdRvQVt0KKgI/nIg+SzP86UvTbynpZYAK1FdV0ooeLx4E7XYmUz/CZB7LF9Iy08Lmg19gdvHxRMElsnIKvcxHog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqtLldnDlFw12xq5GioL7eNPoH/2m1O8s3JJ53kbu/w=;
 b=cWLjNcN3U/VO7t8qgQTYhqMW8Ul4tlAF92mM50KRlV60k/vR7fIAqVsWt7kslniXrx9QD0QEg4KF6XWQtyRbdqiQ+p38lDI1DTVzW5o7nxI6Pf0NktieAUF0g31dtvNUvOtriqpeKuZqzdvmtnCaVo0DuHeZCsNJsuLchlqMahCKNfKabIyZBlfhGrbqEuYVQxgDSL4IIjesPOXqB++1/b4aTmIt6ovLsx6JuM6AqMEglxro9smhzuG5UAtvKmfh2Uu863yxX5oNTnjC7dINmoTwm1FCv0wy8mxWAG/Fpdppsth4xf5/r6aB+ZmMvE9yaM93D0iQ7ZESD2r86YetnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqtLldnDlFw12xq5GioL7eNPoH/2m1O8s3JJ53kbu/w=;
 b=ZpIm/H7ILHANultEu+TzM4Qd8z5xsk1EaqoBkVBvDT/2syG5RlColELuzYkWQ6OwX7U166EWcaTybIygzsJoRkRUvQX93yNUbSKHQN3DVw5wrCNIm6RCieeoNe93L8zcp1xPzx9MZR0tV9cZ+C99oxsRdRKrW9MSSJiwPuHMl5w=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7777.namprd04.prod.outlook.com (2603:10b6:5:354::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 12:37:14 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 12:37:14 +0000
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
Subject: [RFC PATCH v4 04/10] RISC-V: Use IPIs for remote TLB flush when possible
Date:   Thu,  7 Oct 2021 18:06:26 +0530
Message-Id: <20211007123632.697666-5-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007123632.697666-1-anup.patel@wdc.com>
References: <20211007123632.697666-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR0101CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::31) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (171.61.64.222) by MAXPR0101CA0045.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 12:37:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 097bb381-fe6a-412c-0b56-08d9898f30d1
X-MS-TrafficTypeDiagnostic: CO6PR04MB7777:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB777739BB3DE5AEC53F872F748DB19@CO6PR04MB7777.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GfKcxgZpWgLbpH7qaXV1CeinxpQrDFezGyQvfEm542bc/BaXFrZmxyFIMZIwJMPBh59orctYC3jk2JQHKKVakbJdiEnQlkHz3jsHNdIH980J7uCBRyfHaEU+yiEk8eAymHOg4FtWhZBpAZGgG21bJBA2WPNKiI0SBR7XihvlbQe2RDeUCzMgw/OGnAQnI37oPWHRTKoTLdeUt4uEIifyfpoJNvvkivjFsN8+6Cj5cXekKF8qGb5y0pds0X35G0lmPkTQmHAQeBcQwxloelOqMpRjBiKCsuOYdKPpc++Yb1roqocEAFDAf50mUyAwwgp8HpNQBpxfguaKdbi8c+DReUdAJ2NOUqIzloREKpJHl1803imtPMfUnStkjqTb0OCinDvQS1Vq7y+iEiRom1ZMRRsTk0/bNPWffUAJZibrGV0C+jLrFx+IWXIm2UugOpoaQY7kT3I9/jTn4ZjpEpNyr1pg1Q77d0MHqyhXrVXLG15EDiex7LONTPs/YgLHD8p+ZKtAYi02IfxHoL2cypdjuhFLskGFwpPz0Dr1X1LW/kXNi68XY5HuoxUUDDiEmEQBv2uO30KDzAot7fqJxLeYEl/6EDAHj8aKUqRV3bxxoYU8KZkPYS2Nbp/R98vtEOvlI6ZTmx41qRN5absHyfcPBMBZ5dza4XzGf3OiYLxPzdWTq7YlorDcXOPBSZXgjR9/Fi5lvB/qpTtx79HPSU6fBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(5660300002)(52116002)(1076003)(316002)(110136005)(8936002)(7696005)(2906002)(38100700002)(38350700002)(55016002)(508600001)(7416002)(86362001)(66556008)(66476007)(36756003)(4326008)(66946007)(83380400001)(8676002)(26005)(6666004)(8886007)(186003)(2616005)(956004)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SGzYGB154nZmXzwtAda2rYVdrHuoa1v3RcSq6fQ7BbBsvY6xkviUxG6jJsVf?=
 =?us-ascii?Q?XFV1sqmwRNFBozGWapG8NzJyrJlMGbgg0RAMabXBPTfah9QQXwnAF7/21AnH?=
 =?us-ascii?Q?5acwPhYbraUsvQQ/+NOcHwFLMQ2YMa+x8CAaHOGSWaGaWJqNtU7JkvlcmyKH?=
 =?us-ascii?Q?FXQ7sHlXDkQSj9NXK0R//4ykBj7wkCyPhBm4BxMJQ1wGNAubRhhygJhoniOX?=
 =?us-ascii?Q?ZC+d+KuXKTLxAIujhb3Ke5v96iuL/SSuNiOaGFIkmtHnbRD+HVbyxY9T3jCy?=
 =?us-ascii?Q?wqI7ppAJghrIRWQnw2GWRnx6qMlMPSmxwZuydsfjdqyzSPtyFB0THKSr/6H+?=
 =?us-ascii?Q?hXQX3xa2yM8XNK3xKR+wdlJrOXyDXTNPJ5U+Bec0Vl4zXEeiz0H9kgkU7cs2?=
 =?us-ascii?Q?J+dCPkCeB1jxYir0lUiDDWResnvCLkJvAUuNtU7aU6CqLEuMYTxmoVJo+6le?=
 =?us-ascii?Q?aWXxwMMHVaeL6k/9so7c0qUEQ+OHyhkBmSsU5fFXWyuTakE0YdZD57I8wuFK?=
 =?us-ascii?Q?4HrpIojf3aUFxMCHuLx3H7vnyvLstis/hqlU4zoGVr2byQC3T49FwLkAog0f?=
 =?us-ascii?Q?VtATLs4kBw1R/Kr25q1+Q46A2RBxdZ+Vus07Sy9xRRjeR3/6fCXf/lMDockJ?=
 =?us-ascii?Q?EOl0dSo9pGajvkWlvW9gsBAwFr5t0pLa6OTNlWSo27T61li2rNA4f+r2xyf/?=
 =?us-ascii?Q?HNgst9XVj0fGsmiklVr6t5F0BgQDwzj6TCZfs+9l/kgX1Fi/QheqNfrB1fBx?=
 =?us-ascii?Q?WdQdgvo/HBMds3pl6sJ4CeGYvdshVKUAlajU7MZ3deKALxOExYUtvVahjqGZ?=
 =?us-ascii?Q?cEo8E43Oj6q2slrgKEd3GtfhQoZmdPxnKSXRSURrnC78xzK7FfmW/Jo9EA90?=
 =?us-ascii?Q?dR0GbcJVipdLeyfPmsxSKzo0dq3xY+oggaDrvpSJmswgFAU9U0p4lVqx2+4/?=
 =?us-ascii?Q?YENZocnJAY/pOVITwGCSNrH3RJl3IE6Xkmus8JVCwq9pPUUwMTyw4pJrr7q7?=
 =?us-ascii?Q?bhKtJvB5nGOEonVaSKaExsl1gIInHS7h3T44cYRtMm/eprjdLwnl/BDCcEFJ?=
 =?us-ascii?Q?+VkyjDVpdlsAfFauhOcrZerEc925VHcwwShycEomd6L67zkz2TsfXGWUCx5v?=
 =?us-ascii?Q?QVSbJaEBnZIpNx7tGuEdavofXDb4IyXgn16fZVnX7RXwWzPjxjuP9pyEZ3SP?=
 =?us-ascii?Q?m2M8eEycY2GrGUloZgNCthPiOLis0s787W8itnjGg4rYnP8q6HZX1Qa1ZpCY?=
 =?us-ascii?Q?GW9GI1YXdiKlgBLtJlf0MhBFtA7bWg4yJwREsoenRqFLXkhq4y1/tu3cETIR?=
 =?us-ascii?Q?R7dMz3evmH8u9kOZinuvt4KF?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097bb381-fe6a-412c-0b56-08d9898f30d1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 12:37:14.2846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: doqf7FGe4491FOAlw0M/dtoMHIpnmbXy+YLgiJolD4DteEXHKdLR6UV/RdMZVwkEN+Ieo34qrU3h4uG3YNSzMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7777
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If IPI calls are injected using SBI IPI calls then remote TLB flush
using SBI RFENCE calls is much faster because using IPIs for remote
TLB flush would still endup as SBI IPI calls with extra processing
on kernel side.

It is now possible to have specialized hardware (such as RISC-V AIA
and RISC-V ACLINT) which allows S-mode software to directly inject
IPIs without any assistance from M-mode runtime firmware.

This patch extends remote TLB flush functions to use IPIs whenever
underlying IPI operations are suitable for remote FENCEs.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/mm/tlbflush.c | 91 +++++++++++++++++++++++++++++++---------
 1 file changed, 72 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 64f8201237c2..f96f02ed29ef 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -23,13 +23,60 @@ static inline void local_flush_tlb_page_asid(unsigned long addr,
 			: "memory");
 }
 
+static inline void local_flush_tlb_range(unsigned long start,
+		unsigned long size, unsigned long stride)
+{
+	if (size <= stride)
+		local_flush_tlb_page(start);
+	else
+		local_flush_tlb_all();
+}
+
+static inline void local_flush_tlb_range_asid(unsigned long start,
+		unsigned long size, unsigned long stride, unsigned long asid)
+{
+	if (size <= stride)
+		local_flush_tlb_page_asid(start, asid);
+	else
+		local_flush_tlb_all_asid(asid);
+}
+
+static void __ipi_flush_tlb_all(void *info)
+{
+	local_flush_tlb_all();
+}
+
 void flush_tlb_all(void)
 {
-	sbi_remote_sfence_vma(NULL, 0, -1);
+	if (riscv_use_ipi_for_rfence())
+		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
+	else
+		sbi_remote_sfence_vma(NULL, 0, -1);
+}
+
+struct flush_tlb_range_data {
+	unsigned long asid;
+	unsigned long start;
+	unsigned long size;
+	unsigned long stride;
+};
+
+static void __ipi_flush_tlb_range_asid(void *info)
+{
+	struct flush_tlb_range_data *d = info;
+
+	local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
+}
+
+static void __ipi_flush_tlb_range(void *info)
+{
+	struct flush_tlb_range_data *d = info;
+
+	local_flush_tlb_range(d->start, d->size, d->stride);
 }
 
-static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
-				  unsigned long size, unsigned long stride)
+static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
+			      unsigned long size, unsigned long stride)
 {
 	struct cpumask *cmask = mm_cpumask(mm);
 	struct cpumask hmask;
@@ -46,23 +93,29 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
 		unsigned long asid = atomic_long_read(&mm->context.id);
 
 		if (broadcast) {
-			riscv_cpuid_to_hartid_mask(cmask, &hmask);
-			sbi_remote_sfence_vma_asid(cpumask_bits(&hmask),
-						   start, size, asid);
-		} else if (size <= stride) {
-			local_flush_tlb_page_asid(start, asid);
+			if (riscv_use_ipi_for_rfence()) {
+				on_each_cpu(__ipi_flush_tlb_range_asid,
+					    cmask, 1);
+			} else {
+				riscv_cpuid_to_hartid_mask(cmask, &hmask);
+				sbi_remote_sfence_vma_asid(
+							cpumask_bits(&hmask),
+							start, size, asid);
+			}
 		} else {
-			local_flush_tlb_all_asid(asid);
+			local_flush_tlb_range_asid(start, size, stride, asid);
 		}
 	} else {
 		if (broadcast) {
-			riscv_cpuid_to_hartid_mask(cmask, &hmask);
-			sbi_remote_sfence_vma(cpumask_bits(&hmask),
-					      start, size);
-		} else if (size <= stride) {
-			local_flush_tlb_page(start);
+			if (riscv_use_ipi_for_rfence()) {
+				on_each_cpu(__ipi_flush_tlb_range, cmask, 1);
+			} else {
+				riscv_cpuid_to_hartid_mask(cmask, &hmask);
+				sbi_remote_sfence_vma(cpumask_bits(&hmask),
+						      start, size);
+			}
 		} else {
-			local_flush_tlb_all();
+			local_flush_tlb_range(start, size, stride);
 		}
 	}
 
@@ -71,23 +124,23 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	__sbi_tlb_flush_range(mm, 0, -1, PAGE_SIZE);
+	__flush_tlb_range(mm, 0, -1, PAGE_SIZE);
 }
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
-	__sbi_tlb_flush_range(vma->vm_mm, addr, PAGE_SIZE, PAGE_SIZE);
+	__flush_tlb_range(vma->vm_mm, addr, PAGE_SIZE, PAGE_SIZE);
 }
 
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end)
 {
-	__sbi_tlb_flush_range(vma->vm_mm, start, end - start, PAGE_SIZE);
+	__flush_tlb_range(vma->vm_mm, start, end - start, PAGE_SIZE);
 }
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end)
 {
-	__sbi_tlb_flush_range(vma->vm_mm, start, end - start, PMD_SIZE);
+	__flush_tlb_range(vma->vm_mm, start, end - start, PMD_SIZE);
 }
 #endif
-- 
2.25.1

