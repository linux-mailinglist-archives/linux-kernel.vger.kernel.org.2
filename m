Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6253D88A0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 09:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhG1HN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 03:13:26 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:16013 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbhG1HNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 03:13:20 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GZPtP4t4JzZtjx;
        Wed, 28 Jul 2021 15:09:49 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 15:13:17 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 15:13:16 +0800
Subject: Re: [PATCH] riscv: fix the global name pfn_base confliction error
To:     Kenneth Lee <nek.in.cn@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Vitaly Wool" <vitaly.wool@konsulko.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        "Jisheng Zhang" <jszhang@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <wangzhou1@hisilicon.com>
References: <20210728064318.375747-1-nek.in.cn@gmail.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <0b813cde-ca37-9b83-c0c5-ce9f6b8eab3c@huawei.com>
Date:   Wed, 28 Jul 2021 15:13:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210728064318.375747-1-nek.in.cn@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/28 14:43, Kenneth Lee wrote:
> From: Kenneth Lee <liguozhu@hisilicon.com>
> 
> RISCV use a global variable pfn_base for page/pfn translation. But this
> is a common name and will be used elsewhere. In those case,
> the page-pfn macro which refer this name will refer to the local/input
> variable of those function (such as in vfio_pin_pages_remote). This make
> everything wrong.
> 
> This patch change the name from pfn_base to riscv_global_pfn_base to fix
> this problem
> 
> Signed-off-by: Kenneth Lee <liguozhu@hisilicon.com>
> ---
>   arch/riscv/include/asm/page.h | 4 ++--
>   arch/riscv/mm/init.c          | 6 +++---
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index cca8764aed83..8711e415f37c 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -79,8 +79,8 @@ typedef struct page *pgtable_t;
>   #endif
>   
>   #ifdef CONFIG_MMU
> -extern unsigned long pfn_base;
> -#define ARCH_PFN_OFFSET		(pfn_base)
> +extern unsigned long riscv_global_pfn_base;
> +#define ARCH_PFN_OFFSET		(riscv_global_pfn_base)
>   #else
>   #define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
>   #endif /* CONFIG_MMU */
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index a14bf3910eec..2ce4e9a46ca0 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -228,8 +228,8 @@ static struct pt_alloc_ops _pt_ops __initdata;
>   #define pt_ops _pt_ops
>   #endif
>   
> -unsigned long pfn_base __ro_after_init;
> -EXPORT_SYMBOL(pfn_base);
> +unsigned long riscv_global_pfn_base __ro_after_init;
> +EXPORT_SYMBOL(riscv_global_pfn_base);

Just nit: I didn't see any driver in kernel refers to
the riscv_global_pfn_base, can we just remove the EXPORT_SYMBOL()？

Thanks
Hanjun
