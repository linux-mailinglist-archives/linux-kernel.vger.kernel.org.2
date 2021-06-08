Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D626639EEC8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 08:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFHGf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 02:35:26 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:5282 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFHGfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 02:35:25 -0400
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FzgKw3RSMz1BK3W;
        Tue,  8 Jun 2021 14:28:36 +0800 (CST)
Received: from [10.67.110.136] (10.67.110.136) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 8 Jun 2021 14:33:26 +0800
Subject: Re: [PATCH] powerpc: Fix kernel-jump address for ppc64 wrapper boot
To:     Oliver O'Halloran <oohall@gmail.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20210604092228.199588-1-heying24@huawei.com>
 <CAOSf1CELBh4F334LK6+zy+BPOXKcOm92QZw4g71hQ7oQNa68nw@mail.gmail.com>
From:   He Ying <heying24@huawei.com>
Message-ID: <9dc8b323-7846-0975-16f0-6e3e447383a4@huawei.com>
Date:   Tue, 8 Jun 2021 14:33:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAOSf1CELBh4F334LK6+zy+BPOXKcOm92QZw4g71hQ7oQNa68nw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.136]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

在 2021/6/8 13:26, Oliver O'Halloran 写道:
> On Fri, Jun 4, 2021 at 7:39 PM He Ying <heying24@huawei.com> wrote:
>>  From "64-bit PowerPC ELF Application Binary Interface Supplement 1.9",
>> we know that the value of a function pointer in a language like C is
>> the address of the function descriptor and the first doubleword
>> of the function descriptor contains the address of the entry point
>> of the function.
>>
>> So, when we want to jump to an address (e.g. addr) to execute for
>> PPC-elf64abi, we should assign the address of addr *NOT* addr itself
>> to the function pointer or system will jump to the wrong address.
> How have you tested this?

I tested ppc64-elf big-endian. I changed the Kconfig so that ppc64 
big-endian

selects PPC64_WRAPPER_BOOT. I used qemu to run the cuImage and found

the problem. It made me confused. By applying this patch, I found it works.

I thought it works for ppc64le too. So I upstream this patch.

>
> IIRC the 64bit wrapper is only used for ppc64le builds. For that case
> the current code is work because the LE ABI (ABIv2) doesn't use
> function descriptors. I think even for a BE kernel we need the current
> behaviour because the vmlinux's entry point is screwed up (i.e.
> doesn't point a descriptor) and tools in the wild (probably kexec)
> expect it to be screwed up.

Yes, you're right. PPC64_WRAPPER_BOOT is only used for ppc64le builds 
currently.

LE ABI (ABI v2) doesn't use function descriptors. Is that right? I don't 
test that. If so,

this patch should be dropped. But why does ppc64 have different ABIs? So 
strange.


If the wrapper is built to ppc64be, my patch is tested right. The entry 
point in the ELF

header is always right so you can assign the header->e_entry to the 
function pointer

and then jump to the entry by calling the function. But in the ppc  
wrapper, the address

is intialized to 0 or malloced to be an address later. In this 
situation, I think my patch

should be right for ppc64be.

>
> ABIv2 (LE) reference:
> https://openpowerfoundation.org/?resource_lib=64-bit-elf-v2-abi-specification-power-architecture
> .
