Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8166D37A22D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhEKIeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:34:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:52168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231202AbhEKIeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:34:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 575C4AF88;
        Tue, 11 May 2021 08:33:05 +0000 (UTC)
Subject: Re: [PATCH v2] mm: kmalloc_index: make compiler break when size is
 not supported
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210508221328.7338-1-42.hyeyoo@gmail.com>
 <YJccjBMBiwLqFrB8@casper.infradead.org>
 <CAB=+i9QyxOu_1QDfX5QA=pOxxnRURPnwd2Y0EbhoO1u0e=irBA@mail.gmail.com>
 <c305ec02-a7d6-dd0c-bfee-e5b571d9ca9a@suse.cz> <20210510135857.GA3594@hyeyoo>
 <9d0ffe49-a2e2-6c81-377b-4c8d2147dff8@suse.cz>
 <20210510150230.GA74915@hyeyoo> <YJlUyc8t7MoGTFTe@casper.infradead.org>
 <20210511030343.GB98904@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <cfd5ad12-e589-dcca-52da-6b9db3e26b12@suse.cz>
Date:   Tue, 11 May 2021 10:33:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210511030343.GB98904@hyeyoo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/21 5:03 AM, Hyeonggon Yoo wrote:
> On Mon, May 10, 2021 at 04:44:09PM +0100, Matthew Wilcox wrote:
>> On Tue, May 11, 2021 at 12:02:30AM +0900, Hyeonggon Yoo wrote:
>> > @@ -382,8 +385,8 @@ static __always_inline unsigned int kmalloc_index(size_t size)
>> >  	if (size <=  8 * 1024 * 1024) return 23;
>> >  	if (size <=  16 * 1024 * 1024) return 24;
>> >  	if (size <=  32 * 1024 * 1024) return 25;
>> > -	if (size <=  64 * 1024 * 1024) return 26;
>> > -	BUG();
>> > +
>> > +	BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
>> 
>> we're being encouraged to use static_assert() these days.
>> https://en.cppreference.com/w/c/language/_Static_assert
>> 
> 
> can you tell me difference between static_assert and BUILD_BUG_ON?
> it seems that mm subsystem does not make use of it now.

Some difference is explained in include/linux/build_bug.h near static_assert
definition.
But importantly it seems it's not possible to place static_assert(false) in
place of the BUG() because it will trigger despite not being reachable.
BUILD_BUG_ON_MSG(1  "..."); worked as expected for me.
