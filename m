Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B3A394A6F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 06:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhE2Eop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 00:44:45 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2522 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhE2Eoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 00:44:44 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FsTPh73bWzYqqY;
        Sat, 29 May 2021 12:40:24 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 12:43:06 +0800
Received: from [10.174.177.231] (10.174.177.231) by
 dggpemm000001.china.huawei.com (7.185.36.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 12:43:05 +0800
Subject: Re: [PATCH -next] module: fix build error when CONFIG_SMP is disabled
To:     Bixuan Cui <cuibixuan@huawei.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>
CC:     <vincent.chen@sifive.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210529020328.36863-1-cuibixuan@huawei.com>
From:   "Sunnanyong (Nanyong Sun, Intelligent Computing Solution Development
        Dep)" <sunnanyong@huawei.com>
Message-ID: <4798a93f-f0a5-60f6-5b02-7d507fe60d4f@huawei.com>
Date:   Sat, 29 May 2021 12:43:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210529020328.36863-1-cuibixuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.231]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm000001.china.huawei.com (7.185.36.245)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/29 10:03, Bixuan Cui wrote:

> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
> index c84218ad7afc..9d5801f6e2c3 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -44,6 +44,12 @@ static inline void flush_tlb_range(struct vm_area_struct *vma,
>   	local_flush_tlb_all();
>   }
>   
> +static inline void flush_pmd_tlb_range(struct vm_area_struct *vma,
> +		unsigned long start, unsigned long end)
> +{
> +	local_flush_tlb_all();
> +}
> +
>   #define flush_tlb_mm(mm) flush_tlb_all()
>   #endif /* !CONFIG_SMP || !CONFIG_MMU */

Move the prototype of flush_pmd_tlb_range from pgtable.h to tlbflush.h

can also fix this problem, and it seems that declare flush_pmd_tlb_range 
in tlbflush.h

is better.

We could

diff --git a/arch/riscv/include/asm/pgtable.h 
b/arch/riscv/include/asm/pgtable.h
index 29e2c836848d..eda31002c4b1 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -622,11 +622,6 @@ static inline pmd_t pmdp_establish(struct 
vm_area_struct *vma,
  {
         return __pmd(atomic_long_xchg((atomic_long_t *)pmdp, 
pmd_val(pmd)));
  }
-
-#define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
-void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
-                       unsigned long end);
-
  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */

  /*
diff --git a/arch/riscv/include/asm/tlbflush.h 
b/arch/riscv/include/asm/tlbflush.h
index c84218ad7afc..b9b9c64ac974 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -33,6 +33,11 @@ void flush_tlb_mm(struct mm_struct *mm);
  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
                      unsigned long end);
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
+void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
+                       unsigned long end);
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
  #else /* CONFIG_SMP && CONFIG_MMU */

  #define flush_tlb_all() local_flush_tlb_all()

In this way , flush_p(m/u)d_tlb_range will be defined in 
include/linux/pgtable.h if

CONFIG_SMP is not set.

