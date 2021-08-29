Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF323FAAA3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 12:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbhH2KAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 06:00:00 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15223 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbhH2J77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:59:59 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Gy86C0D9fz1DDkT;
        Sun, 29 Aug 2021 17:58:27 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 29 Aug 2021 17:59:05 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sun, 29 Aug 2021 17:59:04 +0800
Subject: Re: [PATCH] riscv: vdso: map data page before vDSO code
To:     Sergey Larin <cerg2010cerg2010@mail.ru>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20210829094708.169037-1-cerg2010cerg2010@mail.ru>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <02601412-6f01-f4e5-699a-e285fc3fdf3a@huawei.com>
Date:   Sun, 29 Aug 2021 17:59:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210829094708.169037-1-cerg2010cerg2010@mail.ru>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey

There is already one fix,

https://patchwork.kernel.org/project/linux-riscv/list/?series=534877

On 2021/8/29 17:47, Sergey Larin wrote:
> Current vDSO implementation assumes that the code size always fits in
> single page, and the data page follows it:
>
> 	PROVIDE(_vdso_data = . + PAGE_SIZE);
>
> However, this was not the case with my kernel build - the
> shared object had the size of 4800 bytes. This, obviously, is more than
> 4096 and requires second page for the rest of the data.
>
> CLOCK_REALTIME_COARSE clock became broken. It was always returning 0
> because vDSO code was reading the second code page, not the
> data page. Glibc uses this clock for the time() function.
>
> So instead of computing the offset for the data page (it is necessary to
> do in runtime - you can't know the size of the binary while you're
> building it) simply move it behind the code like the ARM does:
>
> 	PROVIDE(_vdso_data = . - PAGE_SIZE);
>
> This commit also fixes arch_vma_name for the data page - it was
> reporting the same '[vdso]' name for it in my case.
>
> Since I don't have the real hardware, the change was debugged with KGDB
> in RVVM and also verified in QEMU.
>
> Signed-off-by: Sergey Larin <cerg2010cerg2010@mail.ru>
> ---
>   arch/riscv/kernel/vdso.c          | 22 +++++++++++-----------
>   arch/riscv/kernel/vdso/vdso.lds.S |  2 +-
>   2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
> index 25a3b8849599..0c49390e9be3 100644
> --- a/arch/riscv/kernel/vdso.c
> +++ b/arch/riscv/kernel/vdso.c
> @@ -44,13 +44,13 @@ static int __init vdso_init(void)
>   		return -ENOMEM;
>   	}
>   
> +	vdso_pagelist[0] = virt_to_page(vdso_data);
>   	for (i = 0; i < vdso_pages; i++) {
>   		struct page *pg;
>   
>   		pg = virt_to_page(vdso_start + (i << PAGE_SHIFT));
> -		vdso_pagelist[i] = pg;
> +		vdso_pagelist[i + 1] = pg;
>   	}
> -	vdso_pagelist[i] = virt_to_page(vdso_data);
>   
>   	return 0;
>   }
> @@ -77,21 +77,21 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
>   	 * install_special_mapping or the perf counter mmap tracking code
>   	 * will fail to recognise it as a vDSO (since arch_vma_name fails).
>   	 */
> -	mm->context.vdso = (void *)vdso_base;
> +	mm->context.vdso = (void *)vdso_base + PAGE_SIZE;
>   
> -	ret =
> -	   install_special_mapping(mm, vdso_base, vdso_pages << PAGE_SHIFT,
> -		(VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC),
> -		vdso_pagelist);
> +	ret = install_special_mapping(mm, vdso_base, PAGE_SIZE,
> +		(VM_READ | VM_MAYREAD), &vdso_pagelist[0]);
>   
>   	if (unlikely(ret)) {
>   		mm->context.vdso = NULL;
>   		goto end;
>   	}
>   
> -	vdso_base += (vdso_pages << PAGE_SHIFT);
> -	ret = install_special_mapping(mm, vdso_base, PAGE_SIZE,
> -		(VM_READ | VM_MAYREAD), &vdso_pagelist[vdso_pages]);
> +	vdso_base += PAGE_SIZE;
> +	ret =
> +	   install_special_mapping(mm, vdso_base, vdso_pages << PAGE_SHIFT,
> +		(VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC),
> +		&vdso_pagelist[1]);
>   
>   	if (unlikely(ret))
>   		mm->context.vdso = NULL;
> @@ -105,7 +105,7 @@ const char *arch_vma_name(struct vm_area_struct *vma)
>   	if (vma->vm_mm && (vma->vm_start == (long)vma->vm_mm->context.vdso))
>   		return "[vdso]";
>   	if (vma->vm_mm && (vma->vm_start ==
> -			   (long)vma->vm_mm->context.vdso + PAGE_SIZE))
> +			   (long)vma->vm_mm->context.vdso - PAGE_SIZE))
>   		return "[vdso_data]";
>   	return NULL;
>   }
> diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
> index e6f558bca71b..fd8a31075256 100644
> --- a/arch/riscv/kernel/vdso/vdso.lds.S
> +++ b/arch/riscv/kernel/vdso/vdso.lds.S
> @@ -8,7 +8,7 @@ OUTPUT_ARCH(riscv)
>   
>   SECTIONS
>   {
> -	PROVIDE(_vdso_data = . + PAGE_SIZE);
> +	PROVIDE(_vdso_data = . - PAGE_SIZE);
>   	. = SIZEOF_HEADERS;
>   
>   	.hash		: { *(.hash) }			:text
