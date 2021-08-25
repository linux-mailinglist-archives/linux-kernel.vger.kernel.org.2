Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0613F7259
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 11:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbhHYJz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 05:55:57 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14418 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236737AbhHYJz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 05:55:56 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gvh7q53XLzbddf;
        Wed, 25 Aug 2021 17:51:19 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 17:55:02 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 25 Aug 2021 17:55:02 +0800
Subject: Re: [PATCH 4/4] mm: kfence: Only load kfence_test when kfence is
 enabled
To:     Alexander Potapenko <glider@google.com>
CC:     Russell King <linux@armlinux.org.uk>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210825092116.149975-1-wangkefeng.wang@huawei.com>
 <20210825092116.149975-5-wangkefeng.wang@huawei.com>
 <CAG_fn=X9oaw0zJrcmShNcvd3UsNSFKsH3kSdD5Yx=4Sk_WtNrQ@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <99daf260-76af-8316-fa9a-a649c8a8d1ab@huawei.com>
Date:   Wed, 25 Aug 2021 17:55:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAG_fn=X9oaw0zJrcmShNcvd3UsNSFKsH3kSdD5Yx=4Sk_WtNrQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/8/25 17:31, Alexander Potapenko wrote:
> On Wed, Aug 25, 2021 at 11:17 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>> Provide kfence_is_enabled() helper, only load kfence_test module
>> when kfence is enabled.
> What's wrong with the current behavior?
> I think we need at least some way to tell the developer that KFENCE
> does not work, and a failing test seems to be the perfect one.

If the kfence is not enabled, eg kfence.sample_interval=0, kfence_test 
spend too much time,

and all tests will fails. It is meaningless. so better to just skip it ;)

>> diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
>> index eb6307c199ea..4087f9f1497e 100644
>> --- a/mm/kfence/kfence_test.c
>> +++ b/mm/kfence/kfence_test.c
>> @@ -847,6 +847,8 @@ static void unregister_tracepoints(struct tracepoint *tp, void *ignore)
>>    */
>>   static int __init kfence_test_init(void)
>>   {
>> +       if (!kfence_is_enabled())

Add a print info here?

>> +               return 0;
>>          /*
>>           * Because we want to be able to build the test as a module, we need to
>>           * iterate through all known tracepoints, since the static registration
>> --
>> 2.26.2
>>
>> --
>> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20210825092116.149975-5-wangkefeng.wang%40huawei.com.
>
>
