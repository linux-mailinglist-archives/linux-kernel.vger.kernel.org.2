Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2EA39538C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 03:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhEaBD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 21:03:56 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2108 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhEaBDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 21:03:54 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FtcMf1Y7qzWpTm;
        Mon, 31 May 2021 08:57:34 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 09:02:08 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 09:02:07 +0800
Subject: Re: [PATCH 11/15] powerpc: convert to setup_initial_init_mm()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Santosh Sivaraj <santosh@fossix.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>
References: <20210529105504.180544-1-wangkefeng.wang@huawei.com>
 <20210529105504.180544-12-wangkefeng.wang@huawei.com>
 <87y2bxemi4.fsf@fossix.org>
 <20210529172214.Horde.njR-7XrYj7R9yHI41_Pujw3@messagerie.c-s.fr>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <200bad0a-ed47-310c-4d6e-346e6b5cdf57@huawei.com>
Date:   Mon, 31 May 2021 09:02:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210529172214.Horde.njR-7XrYj7R9yHI41_Pujw3@messagerie.c-s.fr>
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


On 2021/5/29 23:22, Christophe Leroy wrote:
> Santosh Sivaraj <santosh@fossix.org> a écrit :
>
>> Kefeng Wang <wangkefeng.wang@huawei.com> writes:
>>
>>> Use setup_initial_init_mm() helper to simplify code.
>
> I only got that patch, and patchwork as well 
> (https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=246315)
>
> Can you tell where I can see and get the full series ?
>
> And next time can you copy all patches to linuxppc-dev

ok, will be careful next time, thank for your reminding.

>
> Thanks
> Christophe
>
>>>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> Cc: linuxppc-dev@lists.ozlabs.org
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> ---
>>>  arch/powerpc/kernel/setup-common.c | 5 +----
>>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/setup-common.c 
>>> b/arch/powerpc/kernel/setup-common.c
>>> index 046fe21b5c3b..c046d99efd18 100644
>>> --- a/arch/powerpc/kernel/setup-common.c
>>> +++ b/arch/powerpc/kernel/setup-common.c
>>> @@ -928,10 +928,7 @@ void __init setup_arch(char **cmdline_p)
>>>
>>>      klp_init_thread_info(&init_task);
>>>
>>> -    init_mm.start_code = (unsigned long)_stext;
>>> -    init_mm.end_code = (unsigned long) _etext;
>>> -    init_mm.end_data = (unsigned long) _edata;
>>> -    init_mm.brk = klimit;
>>> +    setup_initial_init_mm(_stext, _etext, _edata, _end);
>>
>> This function definition is not visible for those who have subscribed 
>> only to
>> linuxppc-dev mailing list. I had to do a web-search with the ID.
>>
>> Thanks,
>> Santosh
>>
>>>
>>>      mm_iommu_init(&init_mm);
>>>      irqstack_early_init();
>>> -- 
>>> 2.26.2
>
>
> .
>
