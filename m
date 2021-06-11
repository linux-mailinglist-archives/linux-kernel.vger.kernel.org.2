Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221553A3F10
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhFKJc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:32:56 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5502 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhFKJcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:32:54 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G1b9b42bbzZg84;
        Fri, 11 Jun 2021 17:28:03 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 17:30:52 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 11 Jun
 2021 17:30:52 +0800
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
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <81415ec7-078c-fb3f-2373-3f46608fe39e@huawei.com>
Date:   Fri, 11 Jun 2021 17:30:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfX95GVkd6iJ-aYNp7nO56nLSxgreE4fDXAm3h3p6VEjg@mail.gmail.com>
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



On 2021/6/11 15:58, Andy Shevchenko wrote:
> On Fri, Jun 11, 2021 at 10:19 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>
>> The file scripts/spelling.txt recorded a large number of
>> "mistake||correction" pairs. These entries are currently maintained in
>> order, but the results are not strict. In addition, when someone wants to
>> add some new pairs, he either sort them manually or write a script, which
>> is clearly a waste of labor. So add this script. It removes the duplicates
>> first, then sort by correctly spelled words. Sorting based on misspelled
>> words is not chose because it is uncontrollable.
> 
> chosen

OK

> 
> ...
> 
>> +#!/bin/sh
> 
> If you want to have stricter rules applied, use
> #!/bin/sh -efu
> in all your shell scripts, it will show you a lot of problems.
> 
> Missed SPDX.

OK, I will add it.

> 
>> +src=spelling.txt
> 
>> +tmp=spelling_mistake_correction_pairs.txt
> 
> It will pollute the source tree, so use `mktemp` or utilize O=. In
> case there is no O= supplied (or whatever equivalent to describe
> output folder) you will get it in the source tree, so it needs to be
> Git-ignored.

OK, I will use mktemp to generate the tmp file.

> 
>> +cd `dirname $0`
> 
> Useless use of dirname. Check for %, %%, #, and ## substitutions (`man sh`).
> IIRC dirname equivalent is ${0%/*}.

I just tried it. It works.

> 
>> +# Convert the format of 'codespell' to the current
>> +sed -r -i 's/ ==> /||/' $src
>> +
>> +# Move the spelling "mistake||correction" pairs into file $tmp
> 
>> +# There are currently 9 lines of comments in $src, so the text starts at line 10
>> +sed -n '10,$p' $src > $tmp
>> +sed -i '10,$d' $src
> 
> This is fragile, use proper comment line detection.

I've thought about that too. But I'm wondering if it needs to be that
complicated.

Think about it. It's not something for personal temporary use, so it
should be perfect. I'll change to dynamic computing.

> 
>> +# Remove duplicates first, then sort by correctly spelled words
>> +sort -u $tmp -o $tmp
>> +sort -t '|' -k 3 $tmp -o $tmp
> 
> Can be one pipeline

OK, I will combine it.

> 
>> +# Append sorted results to comments
>> +cat $tmp >> $src
> 
> I believe it can be done in a better way, but I was not thinking about it.

I'll keep searching.

> 
>> +# Delete the temporary file
>> +rm -f $tmp
> 
> What if the script will be trapped? It's good to handle SIGHUP I
> suppose, so we won't leave garbage behind us.

You're very well thought out. I'll take care of it.

> 
>> +cd - > /dev/null
> 

