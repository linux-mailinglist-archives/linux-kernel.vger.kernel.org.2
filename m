Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648C33A3FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhFKKA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 06:00:56 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:6269 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhFKKAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 06:00:51 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G1blP0dCwz1BLPK;
        Fri, 11 Jun 2021 17:53:53 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 17:58:47 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 11 Jun
 2021 17:58:46 +0800
Subject: Re: [PATCH 1/3] scripts: add spelling_sanitizer.sh script
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Joe Perches <joe@perches.com>, Jason Baron <jbaron@akamai.com>,
        Stefani Seibold <stefani@seibold.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jens Axboe <axboe@kernel.dk>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210611071241.16728-1-thunder.leizhen@huawei.com>
 <20210611071241.16728-2-thunder.leizhen@huawei.com>
 <CAHp75VfX95GVkd6iJ-aYNp7nO56nLSxgreE4fDXAm3h3p6VEjg@mail.gmail.com>
 <81415ec7-078c-fb3f-2373-3f46608fe39e@huawei.com>
 <CAHp75VeybOch9xUwy5vtufenBA2unb61sGAVoCdTpy2tRcCxLg@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <095186fe-b4a5-12dc-15f8-d9337187ffdb@huawei.com>
Date:   Fri, 11 Jun 2021 17:58:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeybOch9xUwy5vtufenBA2unb61sGAVoCdTpy2tRcCxLg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/11 17:41, Andy Shevchenko wrote:
> On Fri, Jun 11, 2021 at 12:30 PM Leizhen (ThunderTown)
> <thunder.leizhen@huawei.com> wrote:
>> On 2021/6/11 15:58, Andy Shevchenko wrote:
>>> On Fri, Jun 11, 2021 at 10:19 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
> 
> ...
> 
>>>> +# Convert the format of 'codespell' to the current
>>>> +sed -r -i 's/ ==> /||/' $src
>>>> +
>>>> +# Move the spelling "mistake||correction" pairs into file $tmp
>>>
>>>> +# There are currently 9 lines of comments in $src, so the text starts at line 10
>>>> +sed -n '10,$p' $src > $tmp
>>>> +sed -i '10,$d' $src
>>>
>>> This is fragile, use proper comment line detection.
>>
>> I've thought about that too. But I'm wondering if it needs to be that
>> complicated.
>>
>> Think about it. It's not something for personal temporary use, so it
>> should be perfect. I'll change to dynamic computing.
> 
> sed has a possibility to choose between two anchors.
> 
> Google for `sed -e '/anchor 1/,/anchor 2/'` expressions. So, it will
> be less complicated than current code.

OK, thanks. I'm off work. I'll post the v2 next week.

> 
> 

