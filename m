Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414A53A3F79
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhFKJuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:50:22 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3967 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhFKJuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:50:18 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G1bYN2dd8z6w8x;
        Fri, 11 Jun 2021 17:45:12 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 17:48:17 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 11 Jun
 2021 17:48:16 +0800
Subject: Re: [PATCH 0/3] scripts/spelling.txt: add some spelling pairs and
 reorder
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
 <CAHp75Vdpgpa=TDt5RgG2Eq_+iLZrRSj9XqB97y01SxhdKUYYgg@mail.gmail.com>
 <CAHp75VdJJdPTnUMVqjwMv+73nQf_-0nosS5su-GiDFRAVCbMyw@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <908eb849-1925-8305-a1f3-aeb48f6f4c75@huawei.com>
Date:   Fri, 11 Jun 2021 17:48:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdJJdPTnUMVqjwMv+73nQf_-0nosS5su-GiDFRAVCbMyw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/11 16:10, Andy Shevchenko wrote:
> On Fri, Jun 11, 2021 at 11:02 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Fri, Jun 11, 2021 at 10:19 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>>
>>> Add spelling_sanitizer.sh and use it to reorder, then add some spelling
>>> "mistake||correction" pairs.
>>
>> The sorting idea is good, but the order is not.
>> What you really need is to use language corpus [1] instead. So in such
>> case you will eliminate false positives (to some extent).
> 
> Perhaps I need to elaborate what I meant. The (important) feature of
> the corpus is sorting by frequency of the word usage. That's what

That's unlikely. Even if that were the case, no one could figure 'the frequency' out.

> would be the best. Unfortunately I don't know if codespell uses linear
> search or hash based (i.o.w. does it convert the input file to the
> Python list() or set() object?).

I think "spelling.txt" will be reprocessed by the tool.

For the same set of data, if the performance differs significantly or even does not work
due to the user's input order, the implementation of the tool itself must be problematic.

So our ranking of "spelling.txt" is how to make it easy to see.

I don't know if it's right. Pure logical reasoning.

> 
>> [1]: https://en.wikipedia.org/wiki/Corpus_of_Contemporary_American_English
> 
> 

