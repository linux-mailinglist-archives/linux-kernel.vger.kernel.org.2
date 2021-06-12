Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24743A4FA7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 18:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhFLQHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 12:07:23 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35991 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhFLQHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 12:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623513921; x=1655049921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=jkbKSZvRwwjsXmYu1Ws9MweMMyO4gkhzwEKijSyT1hU=;
  b=If7MyT4s3OZknPT/fM28MdGhqWX3fHWKaLvoq4U/1rIND2mk4IhkSdTm
   0r5j93oVxbb7Pqy3Y6fFOywfwoLD/mSmRXp8lcG9Wr3GOOABzEV/qQeIv
   dklurvfjJTpAUWIaiHPNe27Y2IkHrLRvP/MDbCLu+YWsUm6/d2QvQGwgd
   HlP+O6L5pZ4e5OhAoQrOIiv9tyQVrSIHj144yw32rGHK4dQEuD+x4qEpS
   MY/U2prPcO2wxEVHD+mMyZb2GwALPiMaxIFIO3Yp+bewbC6BGsHH57Wgy
   xq4Qxz8jEgCjPh2JSw1A6loeqsS8x1coxGrqFWGXCDpEJWtCilQu3IN6K
   g==;
IronPort-SDR: zuJNsFmdbwRRSy14JrvQgUubScOKoh/GLTxO6LHpKcj4yEPrBasmLHeLjXvD7kztTEA2t2GJYr
 PWYsT8c0AUTvq/5jD1N1+/sNP2N6KcllDw5Kz/+Kr2JwHcOSAA9q49dq3jFbXXeXrf5Vzn4AGq
 bX1Dq3KofsZQZ7iTV1DWPdoU2Q1gnfSK/Gmf1GvWNOMzyNhD8rLssZxvaUTr4IS5GP5y/3yoRd
 uRRIANh9dahavYtkWTBktpKFmC6+CStZIt7CrKW9WWI2KIy8yeoTkGWaJDxN6bDOK3aBCwXbt5
 J68=
X-IronPort-AV: E=Sophos;i="5.83,268,1616428800"; 
   d="scan'208";a="283160914"
Received: from mail-bn8nam08lp2048.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.48])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2021 00:05:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U768wQP2lUvyJd4t0bjk0NjmjGU3agOZe8mtaTErSNasdGS/cFVlVn4aaVqZm4IrREDsqp5mb17zwSq943QdEG8miP3w8pM4I6/1DyAWNGEZpxY4f1KZlRM4wx9mRUpxCQNWYGATcRtEoZYwWdhk3ZByJp4sC6UIAJAUvA1SrAJTW1khlYxnoi12x0RlJM7xcJum4r63RRikUrEN2ev7n+EW0hduuzM0UtSZ5xmUL4wMRHReRpzEomIJgo7PDxj60vQDZNo39ojnvQBVhwUe8LZMvrjLoUd1Yr2DqRUY76LPzqeXY3/aD9Id7AxRAErFgRyPCufi+KNltfl9A1wrMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Jtqet2fuPqM7Ms6NUR+wXwwQts7PJjG2T9FblTTEjs=;
 b=cEtM8ep3iGi4gb0AWbbqNpTXOUjJzHrqJlyZ/tdJcDGLzzOrp5YUg4JWV+Nldm4IwXrKYmp8pms/97jynFFYj5Zv9viVCbVbCSQ7V/80ebSAFTx9uf1a2i5tks7XMwaTibtX8hkze7kudm5QQLeLLRGh2V4/dzPcgqgELAe5JIcAj+GzNLQuEkMwkvK/aYEAik3zZwR2AnZK9pWUiHhOaPDwZLQ5ft26WphlGn8FZC4CpnBDfmonUS67PTWAmqrHB4jAgUZ1bUZUPFwLlfe86k5l7BW4Q2rywHnB5DLqw3rr5ArDvofDtbOCUQzEe1Xn1a/I7UrF0ZoWrNkdTSmtIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Jtqet2fuPqM7Ms6NUR+wXwwQts7PJjG2T9FblTTEjs=;
 b=I4hOcxcYaRCxwuVSNyBDqR7gzhPRf+6gqOpM7615pl3u/ywubo5cqg1SCrtEpjA4G0y3weIDD4LfC33sWY3XWMbKFfObpbGrbn5jqd4o9D2Q574cZdqGhtuPa6FSXtprf40YuRj8I7a4k2GhI8ntcLkaNtS1BjW2fbJVxUKzh68=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (10.242.165.134) by
 CO6PR04MB7795.namprd04.prod.outlook.com (10.242.164.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.23; Sat, 12 Jun 2021 16:05:18 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::a153:b7f8:c87f:89f8%9]) with mapi id 15.20.4219.025; Sat, 12 Jun 2021
 16:05:18 +0000
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
Subject: [RFC PATCH v1 04/10] RISC-V: Use IPIs for remote TLB flush when possible
Date:   Sat, 12 Jun 2021 21:34:16 +0530
Message-Id: <20210612160422.330705-5-anup.patel@wdc.com>
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
Received: from wdc.com (122.171.171.205) by MA1PR0101CA0052.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Sat, 12 Jun 2021 16:05:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f8bcbea-867b-4a7e-cbfe-08d92dbbdf70
X-MS-TrafficTypeDiagnostic: CO6PR04MB7795:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR04MB7795E9F5C01F91D0210081238D339@CO6PR04MB7795.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UD1zDpR1OhGhVRcqxlC26x2C8xY/RDE+r3PT6D9loBqco3NagseKpnb6zAEQsP1wuJJSMdbL/rhOZl1MQ9BmZLLrqFw+H2bsZxCHIZ9thR/2P9ol0RRW8OAN4850s6X3X9By9dHWPDYQDATdVGcvgo6eteiHxD5rg6nRguJSEcCOQGgBwI5XD9uW46fa6/KubT0jfZXQi1090Nw8taRfU4v0xPGeHZvf2gGgAAn6zTVIixOn73BPwvMRiN3LZQDUgjEDkf8pm9LOkWJYPqYZD5+0ZoPAp3gHm905WywFvhX7GQ1BCstxtvf9bpcOdPv17uYwnZzLadu9quqnbetwnQ3TJizfGQTvaDQYTijekUnePjOaW1sNserSt9UiOlYo+gg5r6M/q4qxp3oI9NB2Z+q7rTXxDfaueE9+ocRMdpNHuaHxNW6vj5M8TWqEn1YL3nXX29rEDnINgHcnspLDmmPZsPDy356wl6UQ2nTW14VmE4lAXwJH7AhPEC9pTCk1kklH96NU7Rs0avPox1iAe8arrkzXpp0HkYVIoLg/SjFuRz2g/owU5x7G69mXbiebzEgHZB22cgI7nYqFv8K25TvZXSYgT5vdptlCbIqB8EmaZvkPc/Yh3CMzttf3iI3urPGVfaGd2mjJon7VIosKcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(36756003)(66946007)(316002)(4326008)(38350700002)(86362001)(8936002)(55016002)(1076003)(66476007)(54906003)(66556008)(38100700002)(5660300002)(2906002)(7416002)(8676002)(8886007)(44832011)(26005)(956004)(16526019)(83380400001)(478600001)(186003)(2616005)(110136005)(52116002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AfwnnumttaxpeTuK4z9W4iP7IGvZiI4JTz88PFlSmbqPmv6n5AchFZp/ULKw?=
 =?us-ascii?Q?YayztGC523JS6SFROn+bs0bTO7QKk0YvgSElBUt9HkEWFER7Yeuf1e8I63kf?=
 =?us-ascii?Q?K7OkoNtlmn/CoFB2lKwttJuDSd+Vz58koQe1CXKzd52IC11bsBaXSyxPL1F1?=
 =?us-ascii?Q?+EbiLShP2H468/ouBMmLiAqYtlw8rwyLS1dHkPqBb0sU92WiN7rd1eXJDrw4?=
 =?us-ascii?Q?+utwRNvNc4IgIux19Wg961aJIpEO3GTfVeuL6/UQi4YbdQPlXWZmsoIe3GkK?=
 =?us-ascii?Q?0gYfpuoxn+T7bSzLUGTnhnVo+vO8wOuirhjaCiT51/jx8Jb7LK3/8icrcSrW?=
 =?us-ascii?Q?yW3op+HqJfGHprs0TGn8zCsJWyiuGIZMudMxTbl6lWdgA/wP4YMr2hhyOX/a?=
 =?us-ascii?Q?/sLjRrDZ5+rF4mU69InldnUWrl4kRzavdk7McZS9l3ntovSJNWyDBMSUE76N?=
 =?us-ascii?Q?FrTNRjhRzjbnXQ/6Lw7p9qsu3HxQfilEMO2/S7pm6ulm9Ce2kYFSSirgGap0?=
 =?us-ascii?Q?gz/rzw5aKE64cJVpV+y7/SpUkY3wEXGPkyRuTGa4ipiwiYaPGffe36KUOXXD?=
 =?us-ascii?Q?GJ2IF5tA7EBbVizMDJ4TKn9J1VNdSL3bD3zqGgyjAdDrP4jgUW1fZzZn/GtR?=
 =?us-ascii?Q?wbOzp68voRCu/AU5ta2GoEmPgXoa9jPDhdFAZXLjRp5aGphnqTiGuTZzTeGx?=
 =?us-ascii?Q?X9HzQ+N7nXQHkmAsd8OKaig18HmKPfGWwq498GRlgH43ZYdP+gn4zrq/XHph?=
 =?us-ascii?Q?ONwtpvjOo/gtVteAXpEtVL8UN7cxuSGCiPH4sFGLn6bW/AU5KrDMa4mqCJmW?=
 =?us-ascii?Q?wLX9maByhqZQw8bXFw9LskFEXevyqfZxHS6D8N79CLUPZkRGCeLolCPKqcsP?=
 =?us-ascii?Q?SvSK+eHOoO8c87I+pkzcbXG34RRC4LrCHytQSB/1AgbGpyu3pJKe8Jt6InGo?=
 =?us-ascii?Q?hQz3lRxSwrMQsFe9walJfPVgaf30lNMPQpQ12PpRryIzZnwUxfcdKZBbvPMu?=
 =?us-ascii?Q?9+v9Yyqa5lVyEEuYRa5fAoxMpq8sVz84EXraVkNwKG/2F5Eu2LItqoYpIGo3?=
 =?us-ascii?Q?dZbd0NKUr9jPBMRfsnS6bGr5gns1v/eV8F9KrqVZqccE+KAz5khHzqKrcwlE?=
 =?us-ascii?Q?zqKbpqJx7Zbm4DLC6PVmTO4ZYiehJfxKaxkIrlis7Gy0HQHDlrqV2Rp8PjlY?=
 =?us-ascii?Q?6u8q3XxIYvgtQ+iBLWKfaRka5wp/aTEFpY0hv5A061wmYUWJjh62d/hU7wpH?=
 =?us-ascii?Q?LFcL6HHwc1JQNa/e6EpsrlLpIEbIPQnk8owp4yqVHGj1A/sDnAlQjHN4C3AA?=
 =?us-ascii?Q?5+ZuFS6Kyorw+D0PgnKIKoSU?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8bcbea-867b-4a7e-cbfe-08d92dbbdf70
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2021 16:05:18.4085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEf4g+jy9ZpY0xKMBvkkYrt/MzXl8jIz57PbZr0/JCqD+gxGNzqiappFgYSsPuTExDrxzI7Mdx7D3ZFTKHQZVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7795
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

