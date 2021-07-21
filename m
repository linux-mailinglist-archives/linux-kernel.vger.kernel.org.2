Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378963D07ED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 06:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhGUEJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 00:09:03 -0400
Received: from foss.arm.com ([217.140.110.172]:44934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232549AbhGUEIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 00:08:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CCFC1FB;
        Tue, 20 Jul 2021 21:49:16 -0700 (PDT)
Received: from [10.163.64.235] (unknown [10.163.64.235])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 098023F66F;
        Tue, 20 Jul 2021 21:49:13 -0700 (PDT)
Subject: Re: [PATCH v2 01/12] mm/debug_vm_pgtable: Introduce struct
 pgtable_debug_args
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org, chuhu@redhat.com,
        shan.gavin@gmail.com
References: <20210719054138.198373-1-gshan@redhat.com>
 <20210719054138.198373-2-gshan@redhat.com>
 <8d754894-5c21-1287-82b6-7ac3b064af3d@redhat.com>
 <ff9766a5-3f4e-f821-daf1-b2779a8c81fc@arm.com>
 <1d8c1b0f-3102-5a4a-f3fb-a0fc50d281cc@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <aba5506f-5777-6e57-10f3-c414eb012b01@arm.com>
Date:   Wed, 21 Jul 2021 10:20:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1d8c1b0f-3102-5a4a-f3fb-a0fc50d281cc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/21 4:59 AM, Gavin Shan wrote:
> On 7/20/21 4:42 PM, Anshuman Khandual wrote:
>> On 7/19/21 6:31 PM, Gavin Shan wrote:
>>>> +    if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>>>> +        has_transparent_hugepage()) {
>>>> +        page = alloc_pages(GFP_KERNEL, HPAGE_PMD_ORDER);
>>>> +        if (page) {
>>>> +            args->pmd_pfn = page_to_pfn(page);
>>>> +            args->pte_pfn = args->pmd_pfn;
>>>> +            return 0;
>>>> +        }
>>>> +    }
>>>> +
>>>
>>> As syzbot reported against v1 series, we could allocate pages larger than (1 << (MAX_ORDER - 1)) here.
>>> So __GFP_NOWARN is needed here. I will fix it in v3 series.
>>
>> I could find the following build error reported from lkp on V2.
>>
>> mm/debug_vm_pgtable.c:445:8: warning: variable 'pud' set but not used [-Wunused-but-set-variable]
>>
> 
> Yes, The following line is missed in PATCH[v2 09/12] and fixed in
> PATCH[v3 09/12]: WARN_ON(!pud_none(pud)). With this line added,
> the variable @pud is used in v3.
> 
>> Could you please point to the syzbot reported problem on V1 as you
>> have mentioned above. Are there configs where HPAGE_[PMD|PUD]_ORDER
>> is greater than (MAX_ORDER - 1) ? If yes, how adding __GFP_NOWARN
>> solves the problem ?
>>
> 
> https://syzkaller.appspot.com/bug?extid=8730ec44a441a434a2c8
> https://syzkaller.appspot.com/x/.config?x=29a82c885e192046
> 
> The kernel config has the following options:
> 
> CONFIG_X86_64=y
> CONFIG_TRANSPARENT_HUGEPAGE=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
> #define PUD_SHIFT        30
> #define PMD_SHIFT        21
> 
> CONFIG_FORCE_MAX_ZONEORDER=n
> #define MAX_ORDER    11
> 
> (HPAGE_PUD_SHIFT - PAGE_SHIFT) >= (1 << MAX_ORDER)
> (HPAGE_PMD_ORDER)              <  (1 << MAX_ORDER)
> 
> The warning is triggered in the following path, __GFP_NOWARN helps to
> avoid the WARNING_ON_ONCE(), but NULL is returned as expected.
> 
>    alloc_pages
>      __alloc_pages
> 
>        if (unlikely(order >= MAX_ORDER)) {
>                 WARN_ON_ONCE(!(gfp & __GFP_NOWARN));
>                 return NULL;
>         }

But then that does not allocate the PUD element for the test which
subsequently will be skipped. Isn't it ? So if the order is greater
than MAX_ORDER, allocation needs to happen via alloc_contig_pages()
or something similar.
