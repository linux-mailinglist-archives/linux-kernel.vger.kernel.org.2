Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1D53A0BC3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 07:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbhFIFRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 01:17:03 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5458 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhFIFRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 01:17:02 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G0FbN2xcbzZdjX;
        Wed,  9 Jun 2021 13:12:16 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 13:15:06 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 13:15:05 +0800
Subject: Re: [PATCH 1/1] lib: remove leading spaces before tabs
To:     Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Andy Shevchenko <andy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210608071430.12687-1-thunder.leizhen@huawei.com>
 <CAHp75VfuMJ5kfRDB4tE2zr2Em79HiwrDJVROnw+kD3H+QNM4sg@mail.gmail.com>
 <da4915c5-fa13-0cf2-f2d2-02779a64af1b@huawei.com>
 <8a70d592e14f93822bf40832c7374d8e491c3afc.camel@perches.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <26ee1009-259d-07a6-495f-87557be9ed8a@huawei.com>
Date:   Wed, 9 Jun 2021 13:15:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <8a70d592e14f93822bf40832c7374d8e491c3afc.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/9 0:03, Joe Perches wrote:
> On Tue, 2021-06-08 at 17:00 +0800, Leizhen (ThunderTown) wrote:
>> On 2021/6/8 16:44, Andy Shevchenko wrote:
>>> On Tue, Jun 8, 2021 at 10:14 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>>>
>>>> 1) Run the following command to find and remove the leading spaces before
>>>>    tabs:
>>>>    find lib/ -type f | xargs sed -r -i 's/^[ ]+\t/\t/'
>>>
>>> Hint for the future, try to use what Git provides, for example `git
>>> ls-files -- lib/`.
>>
>> Okay, thanks. I learned a new trick.
> 
> Perhaps another 'trick'.
> 
> checkpatch has SPACE_BEFORE_TAB which does this for any spaces before
> a tab, not just at the start of lines.  But as you've no doubt seen,
> many maintainers do not care for this sort of whitespace only change
> so it's best to do this sparingly or only in drivers/staging/ paths.

I've always thought of kernel, mm, and lib as the core modules of Linux,
and they serve as showcases for successors. I'm not interested in making
coding style improvements unless it's a work-related driver that I
usually read.

> 
> For instance:
> 
> $ git diff --stat lib
> $ git ls-files lib/ | \
>   xargs ./scripts/checkpatch.pl --types=SPACE_BEFORE_TAB --fix-inplace

Wow, It's so powerful. Thanks.

> <checkpatch output>
> $ git diff --stat lib
>  lib/atomic64_test.c             |   2 +-
>  lib/bitmap.c                    |   4 +-
>  lib/btree.c                     |   4 +-
>  lib/decompress_bunzip2.c        |   6 +-
>  lib/fonts/font_mini_4x6.c       | 512 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------

This file is horrible. It's hard not to correct it.

>  lib/locking-selftest.c          |  12 ++--
>  lib/lockref.c                   |   2 +-
>  lib/lru_cache.c                 |   2 +-
>  lib/math/rational-test.c        |   2 +-
>  lib/nlattr.c                    |   4 +-
>  lib/raid6/neon.c                |   2 +-
>  lib/raid6/sse2.c                |  12 ++--
>  lib/reed_solomon/reed_solomon.c |   4 +-
>  lib/scatterlist.c               |   4 +-
>  lib/string.c                    |   4 +-
>  lib/test_firmware.c             |   2 +-
>  lib/test_kmod.c                 |   2 +-
>  lib/test_overflow.c             |   2 +-
>  lib/textsearch.c                |   2 +-
>  lib/ts_bm.c                     |   2 +-
>  lib/zlib_deflate/deflate.c      |   2 +-
>  21 files changed, 294 insertions(+), 294 deletions(-)
> 
> 
> 
> .
> 

