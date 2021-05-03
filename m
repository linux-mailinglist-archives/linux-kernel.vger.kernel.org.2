Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE908371549
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbhECMgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:36:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:51488 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232213AbhECMgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:36:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 183CAAE00;
        Mon,  3 May 2021 12:35:06 +0000 (UTC)
Subject: Re: [PATCH] mm: append __GFP_COMP flag for trace_malloc
To:     Xiongwei Song <sxwjean@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Xiongwei Song <sxwjean@me.com>, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1619491400-1904-1-git-send-email-sxwjean@me.com>
 <20210427025358.GV235567@casper.infradead.org>
 <CAEVVKH_wZJvNAgFEF1OxThxN3AC4mopZ+Pu2GC0Hn_-2JOfC5Q@mail.gmail.com>
 <20210427033632.GW235567@casper.infradead.org>
 <CAEVVKH8ZOt3XSPy1VA1n+MKmqucgcnxjusfhoTbwkitOkErrrw@mail.gmail.com>
 <CAEVVKH-7qRVRKsFmzc9NnhS8Lae5Yq=WhSparOmR3dZmD3PkAw@mail.gmail.com>
 <20210427112527.GX235567@casper.infradead.org>
 <CAEVVKH8AFMqwEcpp=7h7k-_BYqwU+gutoUMNM93pnGPiW=u+gg@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c08e5e63-f66c-211c-5a9b-03ea12ee10bf@suse.cz>
Date:   Mon, 3 May 2021 14:35:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAEVVKH8AFMqwEcpp=7h7k-_BYqwU+gutoUMNM93pnGPiW=u+gg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/21 5:05 AM, Xiongwei Song wrote:
> On Tue, Apr 27, 2021 at 7:26 PM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Tue, Apr 27, 2021 at 01:30:48PM +0800, Xiongwei Song wrote:
>> > Hi Mattew,
>> >
>> > One more thing I should explain, the kmalloc_order() appends the
>> > __GFP_COMP flags,
>> > not by the caller.
>> >
>> > void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
>> > {
>> > ...........................................................
>> >
>> > flags |= __GFP_COMP;
>> > page = alloc_pages(flags, order);
>> > ...........................................................
>> > return ret;
>> > }
>> > EXPORT_SYMBOL(kmalloc_order);
>> >
>> > #ifdef CONFIG_TRACING
>> > void *kmalloc_order_trace(size_t size, gfp_t flags, unsigned int order)
>> > {
>> > void *ret = kmalloc_order(size, flags, order);
>> > trace_kmalloc(_RET_IP_, ret, size, PAGE_SIZE << order, flags);
>> > return ret;
>> > }
>> > EXPORT_SYMBOL(kmalloc_order_trace);
>> > #endif
>>
>> Yes, I understood that.  What I don't understand is why appending the
>> __GFP_COMP to the trace would have been less confusing for you.
>>
>> Suppose I have some code which calls:
>>
>>         kmalloc(10 * 1024, GFP_ATOMIC|__GFP_NOWARN|__GFP_NOMEMALLOC);
>>
>> and I see in my logs
>>
>>      0.08%  call_site=ffffffff851d0cb0 ptr=0xffff8c04a4ca0000 bytes_req=10176 bytes_alloc=16384 gfp_flags=GFP_ATOMIC|__GFP_NOWARN|__GFP_NOMEMALLOC|__GFP_COMP
>>
>> That seems to me _more_ confusing because I would wonder "Where did that
>> __GFP_COMP come from?"
> 
> Thank you for the comments. But I disagree.

FTR, I agree with Matthew. This is a tracepoint for kmalloc() so I would expect
to see what flags were passed to kmalloc().
If I wanted to see how the flags translated to page allocator's flags, I would
have used a page allocator's tracepoint which would show me that.

> When I use trace, I hope I can get the precise data rather than something
> changed that I don't know , then I can get the correct conclusion or
> direction on my issue.

It's precise from the point of the caller.

> Here my question is what the trace events are for if they don't provide the
> real situation? I think that's not graceful and friendly.
> 
> From my perspective, it'd be better to know my flags changed before checking
> code lines one by one. In other words, I need a warning to reminder me on this,
> then I can know quickly my process might do some incorrect things.

Your process should not care about __GFP_COMP if you use properly
kmalloc()+kfree(). Once you start caring about __GFP_COMP, you should be using
page allocator's API, not kmalloc().

> Regards,
> Xiongwei
> 

