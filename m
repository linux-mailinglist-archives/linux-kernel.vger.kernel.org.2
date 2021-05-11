Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5A537A23F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhEKIhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:37:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:56974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230126AbhEKIhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:37:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF93BB162;
        Tue, 11 May 2021 08:36:01 +0000 (UTC)
Subject: Re: [PATCH v2] mm: kmalloc_index: make compiler break when size is
 not supported
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210508221328.7338-1-42.hyeyoo@gmail.com>
 <YJccjBMBiwLqFrB8@casper.infradead.org>
 <CAB=+i9QyxOu_1QDfX5QA=pOxxnRURPnwd2Y0EbhoO1u0e=irBA@mail.gmail.com>
 <c305ec02-a7d6-dd0c-bfee-e5b571d9ca9a@suse.cz> <20210510135857.GA3594@hyeyoo>
 <9d0ffe49-a2e2-6c81-377b-4c8d2147dff8@suse.cz>
 <20210510150230.GA74915@hyeyoo>
 <90591d7e-41e4-9ae5-54ae-ded467c498cf@suse.cz>
 <20210510153846.GA77398@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <de465c4a-d99b-b9da-49c7-6c767918fe78@suse.cz>
Date:   Tue, 11 May 2021 10:36:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210510153846.GA77398@hyeyoo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/21 5:38 PM, Hyeonggon Yoo wrote:
> On Mon, May 10, 2021 at 05:19:58PM +0200, Vlastimil Babka wrote:
> 
>> I'd rephrase the subject:
>> mm, slub: change run-time assertion in kmalloc_index() to compile-time
>>
> 
>> "... compiler will generate a run-time BUG() while a compile-time error is also
>> possible, and better"
> 
>> "there's no need to..."
>>       kmalloc-32M
> 
> 
> Vlastimil Babka and Christoph Lameter, thank you for reviewing the patch.
> 
> I'm not familiar with kernel community yet. should I send patch v3 again,
> or can you update it directly?

I think it would be best if you sent v3, the way you did with v1 - inline. With
v2 it looked like a mail body with you message and patch as attachment. We want
the testing bots to pick it up and they might work only with inline patch. Thanks.


