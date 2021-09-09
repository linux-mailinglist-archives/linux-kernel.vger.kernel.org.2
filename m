Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE2540427A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 02:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348419AbhIIA7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 20:59:43 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15252 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242915AbhIIA7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 20:59:42 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H4gb81MJXz1DGRh;
        Thu,  9 Sep 2021 08:57:40 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 9 Sep 2021 08:58:32 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 9 Sep 2021 08:58:31 +0800
Subject: Re: [PATCH] riscv: enable GENERIC_FIND_FIRST_BIT
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20210718001423.6b8e1d23@xhacker>
 <20210908230427.3a92fb87@xhacker>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <bbd220c4-b535-d024-6bd3-b620b4702ed3@huawei.com>
Date:   Thu, 9 Sep 2021 08:58:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210908230427.3a92fb87@xhacker>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/9/8 23:04, Jisheng Zhang wrote:
> Hi Palmer,
>
> On Sun, 18 Jul 2021 00:14:23 +0800
> Jisheng Zhang wrote:
>
>> From: Jisheng Zhang <jszhang@kernel.org>
>>
>> riscv doesn't implement architecture-optimized bitsearching functions
>> such as find_first_{zero}_bit() etc.
>>
>> When GENERIC_FIND_FIRST_BIT=n, find_first_bit() is implemented with
>> find_next_bit() which is less efficient. Enable GENERIC_FIND_FIRST_BIT
>> for riscv to get more optimized find_first_bit() implementation, an
>> initial test(lib/find_bit_benchmark) shows find_first_bit() performance
>> is improved by nearly 32%.
> It seems this patch is missed. Is it possible to pick it up for 2nd 5.15-rc1 PR?
>
> Thanks

It is enabled unconditionally by following commit

commit dbbccfe505ef8fae804677abf0564c1e07479102

Author: Yury Norov <yury.norov@gmail.com>
Date:   Tue Aug 24 09:59:56 2021 +1000

     arch: remove GENERIC_FIND_FIRST_BIT entirely

>
>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>> ---
>>   arch/riscv/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 8fcceb8eda07..7ebc54c5c245 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -47,6 +47,7 @@ config RISCV
>>   	select GENERIC_ATOMIC64 if !64BIT
>>   	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>>   	select GENERIC_EARLY_IOREMAP
>> +	select GENERIC_FIND_FIRST_BIT
>>   	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
>>   	select GENERIC_IOREMAP
>>   	select GENERIC_IRQ_MULTI_HANDLER
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> .
>
