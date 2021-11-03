Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BDC444A86
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 22:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhKCV4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 17:56:49 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:62935 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbhKCV4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 17:56:48 -0400
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id iOCvmLlHeBazoiOCvmx3Yo; Wed, 03 Nov 2021 22:54:10 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 03 Nov 2021 22:54:10 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [PATCH] mm/mremap_pages: Save a few cycles in 'get_dev_pagemap()'
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <b4a47154877853cc64be3a35dcfd594d40cc2bce.1635975283.git.christophe.jaillet@wanadoo.fr>
 <YYMCI2S03+azi7nK@casper.infradead.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <5da6ef93-97c6-6165-8a73-eb1050589ba7@wanadoo.fr>
Date:   Wed, 3 Nov 2021 22:54:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YYMCI2S03+azi7nK@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/11/2021 à 22:41, Matthew Wilcox a écrit :
> On Wed, Nov 03, 2021 at 10:35:34PM +0100, Christophe JAILLET wrote:
>> Use 'percpu_ref_tryget_live_rcu()' instead of 'percpu_ref_tryget_live()' to
>> save a few cycles when it is known that the rcu lock is already
>> taken/released.
> 
> If this is really important, we can add an __xa_load() which doesn't
> take the RCU read lock.

There are a few:
    rcu_read_lock();
    mem = xa_load(...);
    rcu_read_unlock();
patterns here and there.

I don't have any numbers of if saving some rcu_read_lock/rcu_read_unlock 
would be useful in these cases.

The only numbers I have are in [1].

[1]: 
https://lore.kernel.org/linux-kernel/cover.1634822969.git.asml.silence@gmail.com/

CJ


> 
> I honestly think that the xarray is the wrong data structure here,
> and we'd be better off with a simple array of (start, pointer)
> tuples.
> 
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   mm/memremap.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/memremap.c b/mm/memremap.c
>> index 84de22c14567..012e8d23d365 100644
>> --- a/mm/memremap.c
>> +++ b/mm/memremap.c
>> @@ -506,7 +506,7 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
>>   	/* fall back to slow path lookup */
>>   	rcu_read_lock();
>>   	pgmap = xa_load(&pgmap_array, PHYS_PFN(phys));
>> -	if (pgmap && !percpu_ref_tryget_live(pgmap->ref))
>> +	if (pgmap && !percpu_ref_tryget_live_rcu(pgmap->ref))
>>   		pgmap = NULL;
>>   	rcu_read_unlock();
>>   
>> -- 
>> 2.30.2
>>
>>
> 

