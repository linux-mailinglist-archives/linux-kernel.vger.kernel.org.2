Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8666E379052
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbhEJOKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:10:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:42566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244749AbhEJOFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:05:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4EA16AFE6;
        Mon, 10 May 2021 14:04:08 +0000 (UTC)
Subject: Re: [PATCH] mm: kmalloc_index: remove case when size is more than
 32MB
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210508221328.7338-1-42.hyeyoo@gmail.com>
 <YJccjBMBiwLqFrB8@casper.infradead.org>
 <CAB=+i9QyxOu_1QDfX5QA=pOxxnRURPnwd2Y0EbhoO1u0e=irBA@mail.gmail.com>
 <c305ec02-a7d6-dd0c-bfee-e5b571d9ca9a@suse.cz> <20210510135857.GA3594@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <9d0ffe49-a2e2-6c81-377b-4c8d2147dff8@suse.cz>
Date:   Mon, 10 May 2021 16:04:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210510135857.GA3594@hyeyoo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/21 3:58 PM, Hyeonggon Yoo wrote:
> On Mon, May 10, 2021 at 12:09:55PM +0200, Vlastimil Babka wrote:
>> On 5/9/21 7:33 AM, Hyeonggon Yoo wrote:
>> > On Sun, May 09, 2021 at 12:19:40AM +0100, Matthew Wilcox wrote:
>> >> On Sun, May 09, 2021 at 07:13:28AM +0900, Hyeonggon Yoo wrote:
>> >> > the return value of kmalloc_index is used as index of kmalloc_caches,
>> >>
>> >> it doesn't matter.  every few weeks somebody posts a patch to "optimise"
>> >> kmalloc_index, failing to appreciate that it's only ever run at compile
>> >> time because it's all under __builtin_constant_p().
>> > 
>> > Oh thanks, I didn't know about __builtin_constant_p.
>> > 
>> > But I was not optimizing kmalloc_index. isn't it confusing that
>> > kmalloc_caches alllows maximum size of 32MB, and kmalloc_index allows
>> > maximum size of 64MB?
>> > 
>> > and even if the code I removed is never reached because 64MB is always
>> > bigger than KMALLOC_MAX_CACHE_SIZE, it will cause an error if reached.
>> 
>> KMALLOC_MAX_CACHE_SIZE depends on KMALLOC_SHIFT_HIGH
>> size of kmalloc_caches array depends on KMALLOC_SHIFT_HIGH
>> 
>> So I don't an easy way how it could become reachable while causing the index to
>> overflow - if someone increased KMALLOC_SHIFT_HIGH from 25 to 26, all should be
>> fine, AFAICS.
>> 
>> The problem would be if someone increased it to 27, then we might suddenly get a
>> BUG() in kmalloc_index(). We should probably replace that BUG() with
>> BUILD_BUG_ON(1) to catch that at compile time. Hopefully no supported compiler
>> will break because it's not able to do the proper compile-time evaluation - but
>> if it does, at least we would know.
>> 
>> So I would accept the patch if it also changed BUG() to e.g. BUILD_BUG_ON_MSG(1,
>> "unexpected size in kmalloc_index()");
>> and expanded the function's comment that this is always compile-time evaluated
>> and thus no attempts at "optimizing" the code should be made.
>> 
> 
> Thank you so much reviewing and replying to my patch.
> plecase check if I understood well.
> 
> Okay, I'll do that work. then the following patch will:
> 	- remove case when size is more than 32MB
> 	- change "BUG to BUILD_BUG_ON to let compiler know when the size is not supported"
> 	- add comment that there's no need to optimize it
> 
> is it what you mean. right?

Exactly.

> and I have a question. in the lin 751 of mm/slab_common.c,
> thre's struct kmalloc_info_struct kmalloc_info. and it initializes kmalloc info
> up to 64MB, which is currently not supported. should I change it too? in a separate patch?

Yeah that could be also changed, in the same patch.
