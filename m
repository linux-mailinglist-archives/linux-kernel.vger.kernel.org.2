Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB6E34C23A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 05:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhC2DcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 23:32:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15027 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhC2Dbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 23:31:53 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F7yjm0dqQzNr5m;
        Mon, 29 Mar 2021 11:29:16 +0800 (CST)
Received: from [10.174.177.208] (10.174.177.208) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Mon, 29 Mar 2021 11:31:51 +0800
Subject: Re: [PATCH] arm: 9016/2: Make symbol 'tmp_pmd_table' static
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
References: <20210327083018.1922539-1-liushixin2@huawei.com>
 <20210327102012.GT1463@shell.armlinux.org.uk>
CC:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        <kasan-dev@googlegroups.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <8578f96b-1a86-27a9-86a4-ed97c90b4892@huawei.com>
Date:   Mon, 29 Mar 2021 11:31:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210327102012.GT1463@shell.armlinux.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry for making such a stupid mistake. There was only one patch committed before(5615f69bc209 "ARM: 9016/2: Initialize the mapping of KASan shadow memory"), and I used the same subject by mistake.

Thanks for your correction, I will revise the subject and resend it. How about using "arm: mm: kasan_init" in the subject?


On 2021/3/27 18:20, Russell King - ARM Linux admin wrote:
> Why do you have 9016/2 in the subject line? That's an identifier from
> the patch system which shouldn't be in the subject line.
>
> If you want to refer to something already committed, please do so via
> the sha1 git hash and quote the first line of the commit description
> within ("...") in the body of your commit description.
>
> Thanks.
>
> On Sat, Mar 27, 2021 at 04:30:18PM +0800, Shixin Liu wrote:
>> Symbol 'tmp_pmd_table' is not used outside of kasan_init.c and only used
>> when CONFIG_ARM_LPAE enabled. So marks it static and add it into CONFIG_ARM_LPAE.
>>
>> Signed-off-by: Shixin Liu <liushixin2@huawei.com>
>> ---
>>  arch/arm/mm/kasan_init.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
>> index 9c348042a724..3a06d3b51f97 100644
>> --- a/arch/arm/mm/kasan_init.c
>> +++ b/arch/arm/mm/kasan_init.c
>> @@ -27,7 +27,9 @@
>>  
>>  static pgd_t tmp_pgd_table[PTRS_PER_PGD] __initdata __aligned(PGD_SIZE);
>>  
>> -pmd_t tmp_pmd_table[PTRS_PER_PMD] __page_aligned_bss;
>> +#ifdef CONFIG_ARM_LPAE
>> +static pmd_t tmp_pmd_table[PTRS_PER_PMD] __page_aligned_bss;
>> +#endif
>>  
>>  static __init void *kasan_alloc_block(size_t size)
>>  {
>> -- 
>> 2.25.1
>>
>>

