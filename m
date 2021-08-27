Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5150C3F9644
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 10:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhH0IhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 04:37:20 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15259 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbhH0IhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 04:37:20 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GwtND5BGGz8BMF;
        Fri, 27 Aug 2021 16:36:12 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 27 Aug 2021 16:36:29 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 27 Aug 2021 16:36:28 +0800
Subject: Re: [PATCH v3 1/3] vmalloc: Choose a better start address in
 vm_area_register_early()
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <will@kernel.org>, <ryabinin.a.a@gmail.com>,
        <andreyknvl@gmail.com>, <dvyukov@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kasan-dev@googlegroups.com>,
        <linux-mm@kvack.org>, <elver@google.com>
References: <20210809093750.131091-1-wangkefeng.wang@huawei.com>
 <20210809093750.131091-2-wangkefeng.wang@huawei.com>
 <20210825175953.GI3420@arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <587a3a75-bbee-2ae4-8e69-563b9f277306@huawei.com>
Date:   Fri, 27 Aug 2021 16:36:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210825175953.GI3420@arm.com>
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


On 2021/8/26 1:59, Catalin Marinas wrote:
> On Mon, Aug 09, 2021 at 05:37:48PM +0800, Kefeng Wang wrote:
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index d5cd52805149..1e8fe08725b8 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -2238,11 +2238,17 @@ void __init vm_area_add_early(struct vm_struct *vm)
>>    */
>>   void __init vm_area_register_early(struct vm_struct *vm, size_t align)
>>   {
>> -	static size_t vm_init_off __initdata;
>> -	unsigned long addr;
>> -
>> -	addr = ALIGN(VMALLOC_START + vm_init_off, align);
>> -	vm_init_off = PFN_ALIGN(addr + vm->size) - VMALLOC_START;
>> +	struct vm_struct *head = vmlist, *curr, *next;
>> +	unsigned long addr = ALIGN(VMALLOC_START, align);
>> +
>> +	while (head != NULL) {
> Nitpick: I'd use the same pattern as in vm_area_add_early(), i.e. a
> 'for' loop. You might as well insert it directly than calling the add
> function and going through the loop again. Not a strong preference
> either way.
>
>> +		next = head->next;
>> +		curr = head;
>> +		head = next;
>> +		addr = ALIGN((unsigned long)curr->addr + curr->size, align);
>> +		if (next && (unsigned long)next->addr - addr > vm->size)
> Is greater or equal sufficient?
>
>> +			break;
>> +	}
>>   
>>   	vm->addr = (void *)addr;
> Another nitpick: it's very unlikely on a 64-bit architecture but not
> impossible on 32-bit to hit VMALLOC_END here. Maybe some BUG_ON.

Hi Catalin, thank for your review, I will update in the next version,

Could you take a look the following change, is it OK?

void __init vm_area_register_early(struct vm_struct *vm, size_t align)

{

          struct vm_struct *next, *cur, **p;
          unsigned long addr = ALIGN(VMALLOC_START, align);
BUG_ON(vmap_initialized);

          for (p = &vmlist; (cur = *p) != NULL, next = cur->next; p = 
&next) {
                  addr = ALIGN((unsigned long)cur->addr + cur->size, 
align);
                  if (next && (unsigned long)next->addr - addr >= 
vm->size) {
                          p = &next;
break;
}
}

          BUG_ON(addr > VMALLOC_END - vm->size);
          vm->addr = (void *)addr;
          vm->next = *p;
          *p = vm;
}


>
