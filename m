Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37153780DE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhEJKLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:11:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:54142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230002AbhEJKLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:11:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 941E8B1B0;
        Mon, 10 May 2021 10:09:56 +0000 (UTC)
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210508221328.7338-1-42.hyeyoo@gmail.com>
 <YJccjBMBiwLqFrB8@casper.infradead.org>
 <CAB=+i9QyxOu_1QDfX5QA=pOxxnRURPnwd2Y0EbhoO1u0e=irBA@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: kmalloc_index: remove case when size is more than
 32MB
Message-ID: <c305ec02-a7d6-dd0c-bfee-e5b571d9ca9a@suse.cz>
Date:   Mon, 10 May 2021 12:09:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAB=+i9QyxOu_1QDfX5QA=pOxxnRURPnwd2Y0EbhoO1u0e=irBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/21 7:33 AM, Hyeonggon Yoo wrote:
> On Sun, May 09, 2021 at 12:19:40AM +0100, Matthew Wilcox wrote:
>> On Sun, May 09, 2021 at 07:13:28AM +0900, Hyeonggon Yoo wrote:
>> > the return value of kmalloc_index is used as index of kmalloc_caches,
>>
>> it doesn't matter.  every few weeks somebody posts a patch to "optimise"
>> kmalloc_index, failing to appreciate that it's only ever run at compile
>> time because it's all under __builtin_constant_p().
> 
> Oh thanks, I didn't know about __builtin_constant_p.
> 
> But I was not optimizing kmalloc_index. isn't it confusing that
> kmalloc_caches alllows maximum size of 32MB, and kmalloc_index allows
> maximum size of 64MB?
> 
> and even if the code I removed is never reached because 64MB is always
> bigger than KMALLOC_MAX_CACHE_SIZE, it will cause an error if reached.

KMALLOC_MAX_CACHE_SIZE depends on KMALLOC_SHIFT_HIGH
size of kmalloc_caches array depends on KMALLOC_SHIFT_HIGH

So I don't an easy way how it could become reachable while causing the index to
overflow - if someone increased KMALLOC_SHIFT_HIGH from 25 to 26, all should be
fine, AFAICS.

The problem would be if someone increased it to 27, then we might suddenly get a
BUG() in kmalloc_index(). We should probably replace that BUG() with
BUILD_BUG_ON(1) to catch that at compile time. Hopefully no supported compiler
will break because it's not able to do the proper compile-time evaluation - but
if it does, at least we would know.

So I would accept the patch if it also changed BUG() to e.g. BUILD_BUG_ON_MSG(1,
"unexpected size in kmalloc_index()");
and expanded the function's comment that this is always compile-time evaluated
and thus no attempts at "optimizing" the code should be made.

