Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B7E3D8603
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 05:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbhG1DJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 23:09:59 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7753 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhG1DJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 23:09:58 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GZJQf6y7ZzYhKg;
        Wed, 28 Jul 2021 11:03:54 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 11:09:48 +0800
Received: from [10.174.177.183] (10.174.177.183) by
 dggpemm000001.china.huawei.com (7.185.36.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 11:09:47 +0800
Subject: Re: [PATCH -next] riscv: mm: remove redundant trampoline PGD for
 64bit
To:     Alex Ghiti <alex@ghiti.fr>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <anup.patel@wdc.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <palmerdabbelt@google.com>, <atish.patra@wdc.com>,
        <wangkefeng.wang@huawei.com>
References: <20210527144819.12101-1-sunnanyong@huawei.com>
 <33f93026-cbd2-acd4-e737-c744207f82f2@ghiti.fr>
From:   "Sunnanyong (Nanyong Sun, Intelligent Computing Solution Development
        Dep)" <sunnanyong@huawei.com>
Message-ID: <fe5c5f82-2528-caf9-9bd4-09987bdec05c@huawei.com>
Date:   Wed, 28 Jul 2021 11:09:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <33f93026-cbd2-acd4-e737-c744207f82f2@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.183]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm000001.china.huawei.com (7.185.36.245)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2021/6/29 21:01, Alex Ghiti 写道:

> Hi Nanyong,
>
> Le 27/05/2021 à 16:48, Nanyong Sun a écrit :
>> Remove redundant trampoline PGD for 64bit and add more comment
>> for why 32bit systems need trampoline PGD.
>>
>> There was a patch and discussion similar to this,refer to
>> the link [1][2].
>>
>> The trampoline PGD is redundant for 64bit systems because:
>> 1. The early PGD covers the entire kernel mapping. Directly
>> loading early PGD can achieve the result in boot stage.
>> A more trampoline PGD makes code hard to understand.
>> 2. Directly loading early PGD is safe in 64bit systems since
>> the kernel virtual address starts as 0xFFFFxxxxxxxxxxxx,
>> which has a very big gap with RAM address.It won't fall into
>> the corner case that 32bit system worrys.
>> 3. Remove redundant trampoline PGD can benefit to code maintaince,
>> because 64bit systems have more page table levels.For example:
>> If we want to support SV48 which has 4 page table levels, we have
>> to add a trampoline_pud and insert it before trampoline_pmd.
>
> I do agree with your last point about code maintenance and this would 
> be a welcome improvement before I respin my sv48 series.
>
> Some comments below though.
>
>>
>> Reference link:
>> [1]https://lore.kernel.org/linux-riscv/20190325092234.5451-4-anup.patel@wdc.com/ 
>>
>> [2]https://lkml.org/lkml/2019/3/28/147
>>
>> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
>> ---
>>   arch/riscv/kernel/head.S | 13 +++++++++++--
>>   arch/riscv/mm/init.c     | 21 +++++++--------------
>>   2 files changed, 18 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>> index 89cc58ab52b4..1897b17c5fcc 100644
>> --- a/arch/riscv/kernel/head.S
>> +++ b/arch/riscv/kernel/head.S
>> @@ -93,12 +93,18 @@ relocate:
>>       add a2, a2, a1
>>       csrw CSR_TVEC, a2
>
> This is not needed in 64-bit then.
>
>
I'm afraid this is still needed for 64-bit, which can convert the 
physical address world to the virtual address world.

I also have made a experiment, it could not boot up if this is deleted.

> Thanks,
>
> Alex
> .

Hi Alex,

     Very thanks for your carefully review, I have updated to version 
two just now : )

