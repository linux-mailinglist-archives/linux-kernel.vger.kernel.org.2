Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872ED41A5DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 05:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238762AbhI1DIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 23:08:40 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13346 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238746AbhI1DIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 23:08:39 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HJPSF4MqWz8ywq;
        Tue, 28 Sep 2021 11:02:21 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 28 Sep 2021 11:06:58 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 28 Sep 2021 11:06:58 +0800
Subject: Re: [PATCH] powerpc: don't select KFENCE on platform PPC_FSL_BOOK3E
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Marco Elver <elver@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
References: <20210924063927.1341241-1-liushixin2@huawei.com>
 <f8d12860-56d7-5697-7cba-3cac95bb0a1c@csgroup.eu>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <861f4a6d-1a9e-c01c-6b65-a7b66794fa8d@huawei.com>
Date:   Tue, 28 Sep 2021 11:06:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <f8d12860-56d7-5697-7cba-3cac95bb0a1c@csgroup.eu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/24 14:41, Christophe Leroy wrote:
>
>
> Le 24/09/2021 à 08:39, Liu Shixin a écrit :
>> On platform PPC_FSL_BOOK3E, all lowmem is managed by tlbcam. That means
>> we didn't really map the kfence pool with page granularity. Therefore,
>> if KFENCE is enabled, the system will hit the following panic:
>
> Could you please explain a bit more what the problem is ?
>
> KFENCE has been implemented with the same logic as DEBUG_PAGEALLOC.
>
> DEBUG_PAGEALLOC is enabled on FSL_BOOK3E.
>
> In MMU_setup(), __map_without_ltlbs is set to 1 when KFENCE is enabled.
>
> __map_without_ltlbs should disable the use of tlbcam.
>
>
> So what's wrong really ?
>
> Does DEBUG_PAGEALLOC work on FSL_BOOK3E ?
>
> Thanks
> Christophe
hi Christophe,

In the last e-mail I have said that DEBUG_PAGEALLOC works well on FSL_BOOK3E, that is wrong.
Actually, I add some printed information and find DEBUG_PAGEALLOC Skip all pages.
So neither DEBUG_PAGEALLOC nor kfence is really working.

diff --git a/mm/memory.c b/mm/memory.c
index 25fc46e87214..37fb1b14bc3f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2564,8 +2564,10 @@ static int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
        }
        do {
                next = pmd_addr_end(addr, end);
-               if (pmd_none(*pmd) && !create)
+               if (pmd_none(*pmd) && !create) {
+                       pr_info("---------pmd_none----------\n");
                        continue;
+               }
                if (WARN_ON_ONCE(pmd_leaf(*pmd)))
                        return -EINVAL;
                if (!pmd_none(*pmd) && WARN_ON_ONCE(pmd_bad(*pmd))) {

>
>>
>>      BUG: Kernel NULL pointer dereference on read at 0x00000000
>>      Faulting instruction address: 0xc01de598
>>      Oops: Kernel access of bad area, sig: 11 [#1]
>>      BE PAGE_SIZE=4K SMP NR_CPUS=4 MPC8544 DS
>>      Dumping ftrace buffer:
>>         (ftrace buffer empty)
>>      Modules linked in:
>>      CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.12.0-rc3+ #298
>>      NIP:  c01de598 LR: c08ae9c4 CTR: 00000000
>>      REGS: c0b4bea0 TRAP: 0300   Not tainted  (5.12.0-rc3+)
>>      MSR:  00021000 <CE,ME>  CR: 24000228  XER: 20000000
>>      DEAR: 00000000 ESR: 00000000
>>      GPR00: c08ae9c4 c0b4bf60 c0ad64e0 ef720000 00021000 00000000 00000000 00000200
>>      GPR08: c0ad5000 00000000 00000000 00000004 00000000 008fbb30 00000000 00000000
>>      GPR16: 00000000 00000000 00000000 00000000 c0000000 00000000 00000000 00000000
>>      GPR24: c08ca004 c08ca004 c0b6a0e0 c0b60000 c0b58f00 c0850000 c08ca000 ef720000
>>      NIP [c01de598] kfence_protect+0x44/0x6c
>>      LR [c08ae9c4] kfence_init+0xfc/0x2a4
>>      Call Trace:
>>      [c0b4bf60] [efffe160] 0xefffe160 (unreliable)
>>      [c0b4bf70] [c08ae9c4] kfence_init+0xfc/0x2a4
>>      [c0b4bfb0] [c0894d3c] start_kernel+0x3bc/0x574
>>      [c0b4bff0] [c0000470] set_ivor+0x14c/0x188
>>      Instruction dump:
>>      7c0802a6 8109d594 546a653a 90010014 54630026 39200000 7d48502e 2c0a0000
>>      41820010 554a0026 5469b53a 7d295214 <81490000> 38831000 554a003c 91490000
>>      random: get_random_bytes called from print_oops_end_marker+0x40/0x78 with crng_init=0
>>      ---[ end trace 0000000000000000 ]---
>>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> ---
>>   arch/powerpc/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index d46db0bfb998..cffd57bcb5e4 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -185,7 +185,7 @@ config PPC
>>       select HAVE_ARCH_KASAN            if PPC32 && PPC_PAGE_SHIFT <= 14
>>       select HAVE_ARCH_KASAN_VMALLOC        if PPC32 && PPC_PAGE_SHIFT <= 14
>>       select HAVE_ARCH_KGDB
>> -    select HAVE_ARCH_KFENCE            if PPC32
>> +    select HAVE_ARCH_KFENCE            if PPC32 && !PPC_FSL_BOOK3E
>>       select HAVE_ARCH_MMAP_RND_BITS
>>       select HAVE_ARCH_MMAP_RND_COMPAT_BITS    if COMPAT
>>       select HAVE_ARCH_NVRAM_OPS
>>
> .
>

