Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD4F3B9099
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 12:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbhGAKrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 06:47:11 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6031 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbhGAKrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 06:47:11 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GFvpY5TdlzXmNC;
        Thu,  1 Jul 2021 18:39:17 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Jul 2021 18:44:38 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Jul 2021 18:44:38 +0800
Subject: Re: [PATCH 1/3] riscv: Fix memory_limit for 64-bit kernel
To:     Alexandre Ghiti <alex@ghiti.fr>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20210629091349.3802690-1-alex@ghiti.fr>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <6a38fb9a-d658-836b-4ff4-7c47cadb7db0@huawei.com>
Date:   Thu, 1 Jul 2021 18:44:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210629091349.3802690-1-alex@ghiti.fr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/6/29 17:13, Alexandre Ghiti wrote:
> As described in Documentation/riscv/vm-layout.rst, the end of the
> virtual address space for 64-bit kernel is occupied by the modules/BPF/
> kernel mappings so this actually reduces the amount of memory we are able
> to map and then use in the linear mapping. So make sure this limit is
> correctly set.
>
> Fixes: c9811e379b21 ("riscv: Add mem kernel parameter support")


Should the Fixes tag be de043da0b9e7 （“RISC-V: Fix usage of 
memblock_enforce_memory_limit“）,

The -PAGE_OFFSET is set to the maximal physical memory from this point :)

> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>   arch/riscv/mm/init.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 12f956b3a674..04a5db3a9788 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -124,10 +124,17 @@ void __init mem_init(void)
>   }
>   
>   /*
> - * The default maximal physical memory size is -PAGE_OFFSET,
> - * limit the memory size via mem.
> + * The default maximal physical memory size is -PAGE_OFFSET for 32-bit kernel,
> + * whereas for 64-bit kernel, the end of the virtual address space is occupied
> + * by the modules/BPF/kernel mappings which reduces the available size of the
> + * linear mapping.
> + * Limit the memory size via mem.
>    */
> +#ifdef CONFIG_64BIT
> +static phys_addr_t memory_limit = -PAGE_OFFSET - SZ_4G;
> +#else
>   static phys_addr_t memory_limit = -PAGE_OFFSET;
> +#endif
>   
>   static int __init early_mem(char *p)
>   {
