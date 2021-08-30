Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FD13FB06F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 06:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhH3EUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 00:20:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34860 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbhH3ETF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 00:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630297090; x=1661833090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=UJUjAKryG57iCnWsRWwXKtNHMbhtu6evH99PaKTVGFg=;
  b=pAKOGJ9l+hQfXwl54mK/H3CQHbBjkyj1D/ek28SLuZM9544d/6mdQDRz
   Po6yeDsyMEFHPRxMfpp8rAaLlutBuuiMIew5CShu+wz2OAvk5vwceHjnh
   WBbl5RNG47BRHC9gRUUTzLJQVPDsvxBjtM0PPOTWx9MZgFv9GvNNRkR+m
   bk3MM8mboVPfn86F+4YkWis6zb0qmHGpA+hPTTGwM81Maa1aPPp5puTlF
   RBYJUCLIBUySbPH6AKW1IiVl4ikSk1jpaD1+QaFoQhqu4EJahgdxWHb8r
   YOTlrepjKqQk1pwX6mFFtsmVBjf+PIi/QXPI3N1DNG5DLYfo5NcLN4wxA
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="178734036"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 12:18:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCaww6P+RFI8xmKaBUU+TcPVt0zz0IMtCw9PvNC1HCmvukoKt/hEaa0CucA9Hf2tAjE4P4UXvbyVgAHk7ZOfsgXxy8zK6fvnG+5TeqtuksuMpG5eL13RgajkECxdvYsuH1ShReiiz+h3fNYlEPPYeD1ZDg5cJGa0kllcAYJx47bqs+S1tOCPibawdXgocN2lAgnMhMuE6f7b4M8nVwG37Ejbj7EaDSAmW2dEvb+Ll1teSxJhsKs6KB9m4QVG5AbYwvUEeCqDfQ8sgVpOEg9iildLP+kir9P/1+y4Cm7Lr03XQlruD5WqrLviIgYt4WcqqRag073+/x5Us5B5kfOKwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqtLldnDlFw12xq5GioL7eNPoH/2m1O8s3JJ53kbu/w=;
 b=Qvwge/DBY5u9aDg5HCbRYP797081/G3g+8NKRPG38IMrdUGbo/ZVhuJSG+Ebj3KSTcD8f/AvgYre11uAR7WZi6pcGvFfEA0szecgUisEiAPdJbImJF252daVBAhRjNqAA1VD7pgz6xf/NYQLc/pD87V4YXEO1F5Hl24nfFwDYD0u3uC6voByrE6DNQt02KzyLyFGuxCSN3Q46Nc9btxq2vLsj3S4V6Pcl3TAGn9SxICri0OyXmXBuDbRp2/V93UsSLQndxJJEfk0eg4EAVqTglKxCbXlEIfJgrV7Yh52sxuz77LTZ84syPb3OSXgaTkwDeozsmjIy7Fjb1H3DloymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqtLldnDlFw12xq5GioL7eNPoH/2m1O8s3JJ53kbu/w=;
 b=Xcjb52u9FCxeLEBp90IN3eNRh71AY1nHSqzz9HTaw9cfdrKzTlZ02bgcxtgnzTgbPWs9/w6xdVtMQhPxC2J2xJCDjCFanRghnsm0BxUPiz6LYZDvhrvGYT6eranLs5UCqFuUgbruxANyo3tUa7nMI0Bg5mxtogr2V262YKEb4i8=
Authentication-Results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=wdc.com;
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com (2603:10b6:a03:3ac::8)
 by SJ0PR04MB7823.namprd04.prod.outlook.com (2603:10b6:a03:300::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Mon, 30 Aug
 2021 04:18:10 +0000
Received: from SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514]) by SJ0PR04MB7821.namprd04.prod.outlook.com
 ([fe80::545a:34f7:53c5:6514%8]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 04:18:10 +0000
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
Subject: [RFC PATCH v3 04/11] RISC-V: Use IPIs for remote TLB flush when possible
Date:   Mon, 30 Aug 2021 09:47:22 +0530
Message-Id: <20210830041729.237252-5-anup.patel@wdc.com>
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
Received: from wdc.com (122.179.63.14) by MA1PR0101CA0002.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Mon, 30 Aug 2021 04:18:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4daa3ffa-9a0d-4243-1a74-08d96b6d2d5a
X-MS-TrafficTypeDiagnostic: SJ0PR04MB7823:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR04MB782388720F3803E660E1FE878DCB9@SJ0PR04MB7823.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pnQXKgXl+vEh0Z7i174G542aVFscB24ApRxOxnzfTeFXc1xS9orrCvrYu1JppG7chvEfwWzUjM3fsO69EvzkSN1ODLzzqRcWCDzZb0FH21wDh8h4abwxfTBOa4piSvB4AzWIl0OrZakv+W3vgvxS6YfQHRGBR3WrK+MKe5q7eyWfVQ+itfP/du+/t5v9LX+YTcWCRyBB8NesAXWLf0XLPsPA94gafMUTDvipI5QxNbdQsqJHUeXnXvmdgcx6K5rG2R45uklYDc3jsYVOX/NMj+84KytQRlvDsEEuVbtvUNwexJNRH7v9WMfG7FJs7g2lqjgDnd+Dg5wwiakdF/3A8HAxW3vkstatlsTF6cRJm2zPFSjcgYRGlPc62Z2f7hwB9RlI+1aR6v0fMxQSPAr/lvn7kxxzLaoQvpvLsSVxcIj4Tp4Wf4RiJgLZUO37x4lZrnkMQbIISn8uDbkD1/1Fg0ZpucbqniSTgB3dAZr06be/TS8dDePVuS0YstxQ5VSYoCrD8th1HIKWPOL9jb5dwZ5LK4dcyzL+Oe0a55epLX2bihVRb/skIRVASnChDRB1eZjNJseTfhKVeOBAfgm4MtxpUtBAEyw/lWQo0YZrFHDkcD0a3zNzk78Lrhhv8Hsn/AGf6DsJQyQiebFTwEsGCJgfW0Jh0WzEwzAJ75fJOQuWfnCV/d9CXitKtVeL6VIpkzomEFsqAAEJl9LtgWE7Pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7821.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(478600001)(66946007)(26005)(66556008)(2906002)(316002)(8936002)(52116002)(5660300002)(6666004)(55016002)(66476007)(1076003)(44832011)(36756003)(8676002)(956004)(7696005)(2616005)(54906003)(86362001)(7416002)(110136005)(83380400001)(186003)(38100700002)(8886007)(4326008)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fB7sE3+MSoRDm6bwJf2YUNzaa9xm5bcSO2o8VDjqo2Z1UYLai8Gfbh87SI5I?=
 =?us-ascii?Q?e+ou+7jRj3IwAkGM13dL+KUAAH5DqqUYmfLl6Gchr8nLJmJIRjgvaO2qFUoG?=
 =?us-ascii?Q?NWKyxX09JHQRenoCSBHpKqPvqm/PYgHKnsLgg76YxQTVcS8sqicUxvPr3ocS?=
 =?us-ascii?Q?PtQKAPORJNHLVhiQvfYsy3knUcSKosOeZ6WGiiOie6hThmdqWDoIN7ZHvQtc?=
 =?us-ascii?Q?XsKkPnV5oiYrKOEMEaI7m9pHcJhvMnry2BrF4/Zm1cp65lQi1zEuisJa28O+?=
 =?us-ascii?Q?tkawAuikAubhPJyahA3zX5gYnjJr5F1eHdI9wT8XRhtRZAowJ7SEjOBg/OXQ?=
 =?us-ascii?Q?IW3Q94CzDyX26Ba/9RPlOdcv4ENS4GWLLiDYVsjJXfllriKGjDzO/sNztC2A?=
 =?us-ascii?Q?1Hp4NGUsZn1pmsxoEPLUab2G8vbwHTEAJLgjhqh9Tm7Y68OO8L8HnX01X6KH?=
 =?us-ascii?Q?6mvBkRHgPHueGd7YaoxtzxdjSTOI3McDH4QubvbZIqYgfF/syphf4lmnfjob?=
 =?us-ascii?Q?Q/ng/M2ei38lC3EUhy2rQhZgTkmNuZnJBURhhucPsMzjWTQpUSf7QIHPf1Zu?=
 =?us-ascii?Q?zdWKVle71+n41yhbp40TclmqEAL1vhBI8bJvhhVjaAw8Vh2mxyzqgombzJMA?=
 =?us-ascii?Q?4gr7+X78mLIAnF3a+GjoAgiPEPC90I16DnbMhuDCE+e8lrI3liRTpeW7htGs?=
 =?us-ascii?Q?+67+9xcUWgqWrMMYBywXmvAaNMKrjQx0seOdWTfqCeMtw2WBSIYGtZEPEK/H?=
 =?us-ascii?Q?2j9V/brLChYBAXzrmCvgSaG/ilDeSmzogyFuvH1Vo58++OfNPTKK8LP9oikL?=
 =?us-ascii?Q?i86UUg3vPSoFPn4KsleS/pz1Ci1LyFfb2s/SLxTyh+FAleYKfgMPPwemuF9t?=
 =?us-ascii?Q?JtTkTr7X5eAZc9n9b3KPGU4v48HMHapF41Mcl+vQo3QhKvCTuA9vba/C/4l1?=
 =?us-ascii?Q?/bLOgyQS3kwePkBtzB/3lbDPPCIlL2RfPqR95jC0EwOCGQdeLwBF4YVMjiDx?=
 =?us-ascii?Q?Z+gFT56zf1so18KRaMCb9UYROyAliD1AqrOnTAanQjraBaK5dGHeY7C0esFF?=
 =?us-ascii?Q?IviwEH/ZlzlPyuITwYsjHrOKr8KwwKkvG3cozrGqXL/lCT3Qknfle5MMAeHf?=
 =?us-ascii?Q?VSU+NF3c+pmH83Ib0cCf9DCceaNOhEYFQ0hLVN6k8pK76Gmw6jd2P6A2kaLH?=
 =?us-ascii?Q?mnh4MIBdk7ENBNEUzD37L6/+fFUrqYRdZfFRRbcPRaqt0/IFCMZEMRghCP4V?=
 =?us-ascii?Q?YXtA+IUTE5fOZDbnAbrKHKRzqu4GSXNp1kfQFRnOMeYTRY81GzbDZQmcZ74f?=
 =?us-ascii?Q?ithYGMIqEFf9gjwaK60EdnC2?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4daa3ffa-9a0d-4243-1a74-08d96b6d2d5a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7821.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 04:18:10.7845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9t7R2SMHWQUJZCPF70cZOEEeXQbBtbs4yfiPCpl9ajv/T0VQS3zMUdYVz3AOuzuac8NmZjVTmqW+K/5sTT3rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7823
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

