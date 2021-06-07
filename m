Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128B539D776
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhFGIeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:34:50 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4494 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhFGIes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:34:48 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fz64b3jz7zZfBC;
        Mon,  7 Jun 2021 16:30:07 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 16:32:56 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 7 Jun 2021 16:32:55 +0800
Subject: Re: [PATCH v2 7/7] ARM: mm: Fix PXN process with LPAE feature
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>
References: <20210602070246.83990-1-wangkefeng.wang@huawei.com>
 <20210602070246.83990-8-wangkefeng.wang@huawei.com>
 <20210602105255.GK30436@shell.armlinux.org.uk>
 <62f08378-85e7-2a07-3fd0-b287047ce1b5@huawei.com>
 <20210602155843.GN30436@shell.armlinux.org.uk>
 <c9c4a8ec-da51-4de9-4404-b5bf7f017441@huawei.com>
Message-ID: <f2f533fb-ab11-f76c-85b7-20a9196c24fd@huawei.com>
Date:   Mon, 7 Jun 2021 16:32:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c9c4a8ec-da51-4de9-4404-b5bf7f017441@huawei.com>
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

Hi Russell,  any comments, thanks.

On 2021/6/3 17:38, Kefeng Wang wrote:
>
> On 2021/6/2 23:58, Russell King (Oracle) wrote:
>> On Wed, Jun 02, 2021 at 11:13:14PM +0800, Kefeng Wang wrote:
>>>    IFSR format when using the Short-descriptor translation table format
>>>
>>>      Domain fault      01001            First level   01011     
>>> Second level
>>>
>>>      Permission fault 01101            First level   01111 Second level
>>>
>>>    IFSR format when using the Long-descriptor translation table format
>>>
>>>     0011LL Permission fault. LL bits indicate levelb.
>>>
>>> After check the ARM spec, I think for the permission fault, we 
>>> should panic
>>> with or without LPAE, will change to
>> As I explained in one of the previous patches, the page tables that get
>> used for mapping kernel space are the _tasks_ own page tables. Any new
>> kernel mappings are lazily copied to the task page tables - such as
>> when a module is loaded.
>>
>> The first time we touch a page, we could end up with a page translation
>> fault. This will call do_page_fault(), and so with your proposal,
>> loading a module will potentially cause a kernel panic in this case,
>> probably leading to systems that panic early during userspace boot.
>
> Could we add some FSR_FS check， only panic when the permission fault， 
> eg，
>
> +static inline bool is_permission_fault(unsigned int fsr)
> +{
> +       int fs = fsr_fs(fsr);
> +#ifdef CONFIG_ARM_LPAE
> +       if ((fs & FS_PERM_NOLL_MASK) == FS_PERM_NOLL)
> +               return true;
> +#else
> +       if (fs == FS_L1_PERM || fs == FS_L2_PERM )
> +               return true;
> +#endif
> +       return false;
> +}
> +
>  static int __kprobes
>  do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs 
> *regs)
>  {
> @@ -255,8 +268,7 @@ do_page_fault(unsigned long addr, unsigned int 
> fsr, struct pt_regs *regs)
>
>         if (fsr & FSR_LNX_PF) {
>                 vm_flags = VM_EXEC;
> -
> -               if (!user_mode(regs))
> +               if (is_permission_fault && !user_mode(regs))
>                         die_kernel_fault("execution of memory",
>                                          mm, addr, fsr, regs);
>         }
>
> diff --git a/arch/arm/mm/fault.h b/arch/arm/mm/fault.h
> index 9ecc2097a87a..187954b4acca 100644
> --- a/arch/arm/mm/fault.h
> +++ b/arch/arm/mm/fault.h
> @@ -14,6 +14,8 @@
>
>  #ifdef CONFIG_ARM_LPAE
>  #define FSR_FS_AEA             17
> +#define FS_PERM_NOLL           0xC
> +#define FS_PERM_NOLL_MASK      0x3C
>
>  static inline int fsr_fs(unsigned int fsr)
>  {
> @@ -21,6 +23,8 @@ static inline int fsr_fs(unsigned int fsr)
>  }
>  #else
>  #define FSR_FS_AEA             22
> +#define FS_L1_PERM             0xD
> +#define FS_L2_PERM             0xF
>
> and suggestion or proper solution to solve the issue？
>
>>
