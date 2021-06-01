Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657D6396BD4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 05:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhFAD3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 23:29:01 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6100 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbhFAD3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 23:29:00 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvHZj288jzYp4N;
        Tue,  1 Jun 2021 11:24:29 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 11:27:12 +0800
Received: from [10.174.177.231] (10.174.177.231) by
 dggpemm000001.china.huawei.com (7.185.36.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 11:27:12 +0800
Subject: Re: [PATCH -next] riscv: mm: fix build errors caused by mk_pmd()
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Atish Patra" <Atish.Patra@wdc.com>, <wangkefeng.wang@huawei.com>
References: <mhng-5dc6487a-bafb-471f-ac5c-f6ec93cd311c@palmerdabbelt-glaptop>
From:   "Sunnanyong (Nanyong Sun, Intelligent Computing Solution Development
        Dep)" <sunnanyong@huawei.com>
Message-ID: <bb41e44d-b7aa-1522-1ffb-1b352aade064@huawei.com>
Date:   Tue, 1 Jun 2021 11:27:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <mhng-5dc6487a-bafb-471f-ac5c-f6ec93cd311c@palmerdabbelt-glaptop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.231]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm000001.china.huawei.com (7.185.36.245)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/30 9:21, Palmer Dabbelt wrote:

> On Sat, 29 May 2021 15:45:04 PDT (-0700), Palmer Dabbelt wrote:
>> On Mon, 24 May 2021 00:02:20 PDT (-0700), sunnanyong@huawei.com wrote:
>>> With "riscv: mm: add THP support on 64-bit", mk_pmd() function
>>> introduce build errors,
>>> 1.build with CONFIG_ARCH_RV32I=y:
>>> arch/riscv/include/asm/pgtable.h: In function 'mk_pmd':
>>> arch/riscv/include/asm/pgtable.h:513:9: error: implicit declaration 
>>> of function 'pfn_pmd';
>>>  did you mean 'pfn_pgd'? [-Werror=implicit-function-declaration]
>>>
>>> 2.build with CONFIG_SPARSEMEM=y && CONFIG_SPARSEMEM_VMEMMAP=n
>>> arch/riscv/include/asm/pgtable.h: In function 'mk_pmd':
>>> include/asm-generic/memory_model.h:64:14: error: implicit 
>>> declaration of function 'page_to_section';
>>>  did you mean 'present_section'? 
>>> [-Werror=implicit-function-declaration]
>>>
>>> Use macro definition instead of inline function for mk_pmd
>>> to fix the above problems.It is similar to the mk_pte macro.
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
>>> ---
>>>  arch/riscv/include/asm/pgtable.h | 5 +----
>>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/arch/riscv/include/asm/pgtable.h 
>>> b/arch/riscv/include/asm/pgtable.h
>>> index 4b708ae08910..f35d9c90d4cb 100644
>>> --- a/arch/riscv/include/asm/pgtable.h
>>> +++ b/arch/riscv/include/asm/pgtable.h
>>> @@ -508,10 +508,7 @@ static inline unsigned long pmd_pfn(pmd_t pmd)
>>>      return ((__pmd_to_phys(pmd) & PMD_MASK) >> PAGE_SHIFT);
>>>  }
>>>
>>> -static inline pmd_t mk_pmd(struct page *page, pgprot_t prot)
>>> -{
>>> -    return pfn_pmd(page_to_pfn(page), prot);
>>> -}
>>> +#define mk_pmd(page, prot)    pfn_pmd(page_to_pfn(page), prot)
>>>
>>>  static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>>>  {
>>
>> Thanks, this is on for-next.
>
> Sorry, I wasn't looking closely enough.  I think the actual problem 
> here is that mk_pmd() should be in pgtable-64.h.
> .

Moving mk_pmd() to pgtable-64.h can only solve the first problem, but 
not the second.

The second one need mk_pmd() defined as a macro, like this previous 
solution:

https://patchwork.kernel.org/project/linux-riscv/patch/20191023032302.160388-1-wangkefeng.wang@huawei.com/

Or do i need to move the '#define mk_pmd(page, prot) ...' to pgtable-64.h ?

