Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F523A159E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbhFINdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:33:09 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:5310 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbhFINdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:33:08 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G0SYP4sRZz1BJYF;
        Wed,  9 Jun 2021 21:26:17 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 21:31:09 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 21:31:09 +0800
Subject: Re: [PATCH 1/1] lib: remove leading spaces before tabs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Joe Perches <joe@perches.com>, Andy Shevchenko <andy@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210608071430.12687-1-thunder.leizhen@huawei.com>
 <CAHp75VfuMJ5kfRDB4tE2zr2Em79HiwrDJVROnw+kD3H+QNM4sg@mail.gmail.com>
 <da4915c5-fa13-0cf2-f2d2-02779a64af1b@huawei.com>
 <8a70d592e14f93822bf40832c7374d8e491c3afc.camel@perches.com>
 <26ee1009-259d-07a6-495f-87557be9ed8a@huawei.com>
 <3211e76c-d2a0-1e26-940b-9710073ee7d4@huawei.com>
 <CAHp75VfQq=RkjyZQsc-PHLTLRCzXovm-D_Z+Pp3A6vWGA-GKug@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <012cca24-44bd-4135-4082-91225df0ec00@huawei.com>
Date:   Wed, 9 Jun 2021 21:31:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfQq=RkjyZQsc-PHLTLRCzXovm-D_Z+Pp3A6vWGA-GKug@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/9 18:30, Andy Shevchenko wrote:
> On Wed, Jun 9, 2021 at 9:21 AM Leizhen (ThunderTown)
> <thunder.leizhen@huawei.com> wrote:
>> On 2021/6/9 13:15, Leizhen (ThunderTown) wrote:
>>> On 2021/6/9 0:03, Joe Perches wrote:
>>>> On Tue, 2021-06-08 at 17:00 +0800, Leizhen (ThunderTown) wrote:
>>>>> On 2021/6/8 16:44, Andy Shevchenko wrote:
>>>>>> On Tue, Jun 8, 2021 at 10:14 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>>>>>>
>>>>>>> 1) Run the following command to find and remove the leading spaces before
>>>>>>>    tabs:
>>>>>>>    find lib/ -type f | xargs sed -r -i 's/^[ ]+\t/\t/'
>>>>>>
>>>>>> Hint for the future, try to use what Git provides, for example `git
>>>>>> ls-files -- lib/`.
>>>>>
>>>>> Okay, thanks. I learned a new trick.
> 
>>>> For instance:
>>>>
>>>> $ git diff --stat lib
>>>> $ git ls-files lib/ | \
>>>>   xargs ./scripts/checkpatch.pl --types=SPACE_BEFORE_TAB --fix-inplace
>>
>> I just tried it. It's too slow.
> 
> If checkpath accepts infinite positional arguments, then proper way of
> use (that's how I do with simple perl regexps) is to
> 
> scripts/checkpatch.pl --types=SPACE_BEFORE_TAB --fix-inplace -- $(git
> ls-files lib/)

Nice. It's a little more concise.

> 
> Seems like we have a shell lesson :-)
> 
>> The command I used earlier, removing the line start match "^", can also do that.
>>
>> git ls-files lib/ | xargs sed -r -i 's/[ ]+\t/\t/'
> 
> 

