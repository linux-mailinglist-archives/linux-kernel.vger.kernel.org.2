Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D416239F484
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhFHLFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:05:01 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4402 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhFHLFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:05:00 -0400
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FznL94nw5z6tlq;
        Tue,  8 Jun 2021 18:59:13 +0800 (CST)
Received: from [10.67.110.136] (10.67.110.136) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 8 Jun 2021 19:03:04 +0800
Subject: Re: [PATCH] powerpc: Fix kernel-jump address for ppc64 wrapper boot
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <nathan@kernel.org>,
        Oliver O'Halloran <oohall@gmail.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20210604092228.199588-1-heying24@huawei.com>
 <c80f69d0-44b0-24a6-ce4f-ed5a40514597@csgroup.eu>
From:   He Ying <heying24@huawei.com>
Message-ID: <c9495dc0-2a1f-8aed-1088-90e2d0baabe0@huawei.com>
Date:   Tue, 8 Jun 2021 19:03:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c80f69d0-44b0-24a6-ce4f-ed5a40514597@csgroup.eu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.136]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


在 2021/6/8 12:55, Christophe Leroy 写道:
>
>
> Le 04/06/2021 à 11:22, He Ying a écrit :
>>  From "64-bit PowerPC ELF Application Binary Interface Supplement 1.9",
>> we know that the value of a function pointer in a language like C is
>> the address of the function descriptor and the first doubleword
>> of the function descriptor contains the address of the entry point
>> of the function.
>>
>> So, when we want to jump to an address (e.g. addr) to execute for
>> PPC-elf64abi, we should assign the address of addr *NOT* addr itself
>> to the function pointer or system will jump to the wrong address.
>>
>> Link: 
>> https://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi.html#FUNC-DES
>> Signed-off-by: He Ying <heying24@huawei.com>
>> ---
>>   arch/powerpc/boot/main.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
>> index cae31a6e8f02..50fd7f11b642 100644
>> --- a/arch/powerpc/boot/main.c
>> +++ b/arch/powerpc/boot/main.c
>> @@ -268,7 +268,16 @@ void start(void)
>>       if (console_ops.close)
>>           console_ops.close();
>>   +#ifdef CONFIG_PPC64_BOOT_WRAPPER
>
> This kind of need doesn't desserve a #ifdef, see 
> https://www.kernel.org/doc/html/latest/process/coding-style.html#conditional-compilation
>
> You can do:
>
>
>     kentry = (kernel_entry_t)(IS_ENABLED(CONFIG_PPC64_BOOT_WRAPPER) ? 
> &vmlinux.addr : vmlinux.addr);
>
>
> Or, if you prefer something less compact:
>
>
>     if (IS_ENABLED(CONFIG_PPC64_BOOT_WRAPPER))
>         kentry = (kernel_entry_t) &vmlinux.addr;
>     else
>         kentry = (kernel_entry_t) vmlinux.addr;

Thanks for reviewing. But from Oliver's reply, this patch should be dropped.

Because all ppc platforms will not build wrapper to ppc64be ELF currently.

And ppc64le uses LE ABI (ABIv2) which doesn't use function descriptors.

So this may not be a problem for now.


Thanks again.

>
>
>> +    /*
>> +     * For PPC-elf64abi, the value of a function pointer is the address
>> +     * of the function descriptor. And the first doubleword of a 
>> function
>> +     * descriptor contains the address of the entry point of the 
>> function.
>> +     */
>> +    kentry = (kernel_entry_t) &vmlinux.addr;
>> +#else
>>       kentry = (kernel_entry_t) vmlinux.addr;
>> +#endif
>>       if (ft_addr) {
>>           if(platform_ops.kentry)
>>               platform_ops.kentry(ft_addr, vmlinux.addr);
>>
> .
