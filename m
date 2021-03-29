Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F2634CD06
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhC2J2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:28:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26921 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231660AbhC2J14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 05:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617010075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HY/7K3I1NjYPuWdSB8Mk/0A7Ott2fmPK37yIBwtI/8c=;
        b=YeXsajPn2EBXfUOsIBGfGD7y8+jFD4F/WGetS+efOnHdRxho3zs5NUZHYabS1vS7f1T8A/
        kKdPQ9YlRjpvsPc6FHB2ZAEBSuvm8etFerlyqg2T0TtQpc5qCEGvzcXZFlT05DEL/TJyDm
        ZkdAgIPjvH8EDkCakiuDdi/a1SeV04E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-jsx6eAjpNm2XesKNsbZMeg-1; Mon, 29 Mar 2021 05:27:53 -0400
X-MC-Unique: jsx6eAjpNm2XesKNsbZMeg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BCCA9CDA0;
        Mon, 29 Mar 2021 09:27:51 +0000 (UTC)
Received: from [10.36.114.205] (ovpn-114-205.ams2.redhat.com [10.36.114.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED27C5D9F0;
        Mon, 29 Mar 2021 09:27:48 +0000 (UTC)
Subject: Re: [PATCH v2] kernel/resource: Fix locking in
 request_free_mem_region
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        daniel.vetter@ffwll.ch, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, jhubbard@nvidia.com,
        jglisse@redhat.com, linux-mm@kvack.org
References: <20210326012035.3853-1-apopple@nvidia.com>
 <9eef1283-28a3-845e-0e3e-80b763c9ec59@redhat.com>
 <3158185.bARUjMUeyn@nvdebian>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <88bca3c7-7958-7bab-317d-1918e47061ee@redhat.com>
Date:   Mon, 29 Mar 2021 11:27:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <3158185.bARUjMUeyn@nvdebian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.03.21 03:37, Alistair Popple wrote:
> On Friday, 26 March 2021 7:57:51 PM AEDT David Hildenbrand wrote:
>> On 26.03.21 02:20, Alistair Popple wrote:
>>> request_free_mem_region() is used to find an empty range of physical
>>> addresses for hotplugging ZONE_DEVICE memory. It does this by iterating
>>> over the range of possible addresses using region_intersects() to see if
>>> the range is free.
>>
>> Just a high-level question: how does this iteract with memory
>> hot(un)plug? IOW, how defines and manages the "range of possible
>> addresses" ?
> 
> Both the driver and the maximum physical address bits available define the
> range of possible addresses for device private memory. From
> __request_free_mem_region():
> 
> end = min_t(unsigned long, base->end, (1UL << MAX_PHYSMEM_BITS) - 1);
> addr = end - size + 1UL;
> 
> There is no lower address range bound here so it is effectively zero. The code
> will try to allocate the highest possible physical address first and continue
> searching down for a free block. Does that answer your question?

Ah, yes, thanks - that makes sense.

> 
>>>
>>> region_intersects() obtains a read lock before walking the resource tree
>>> to protect against concurrent changes. However it drops the lock prior
>>> to returning. This means by the time request_mem_region() is called in
>>> request_free_mem_region() another thread may have already reserved the
>>> requested region resulting in unexpected failures and a message in the
>>> kernel log from hitting this condition:
>>
>> I am confused. Why can't we return an error to the caller and let the
>> caller continue searching? This feels much simpler than what you propose
>> here. What am I missing?
> 
> The search occurs as part of the allocation. To allocate memory free space
> needs to be located and allocated as a single operation. However in this case
> the lock is dropped between locating a free region and allocating it resulting
> in an extra debug check firing and subsequent failure.
> 
> I did originally consider just allowing the caller to retry, but in the end it
> didn't seem any simpler. Callers would have to differentiate between transient
> and permanent failures and figure out how often to retry and no doubt each
> caller would do this differently. There is also the issue of starvation if one

Right, you would want to return -EBUSY, -ENOMEM,... from 
__request_region() - which somehow seems like the right thing to do 
considering that we can have both types of errors already.

> thread constantly looses the race to allocate after the search. Overall it
> seems simpler to me to just have a call that allocates a region (or fails due
> to lack of free space).

Fair enough, but I doubt the starvation is a real issue ...

> 
> I also don't think what I am proposing is particularly complex. I agree the

Well, it adds another 42 LOC to kernel/resource.c for a rather special 
case that just needs a better return value from __request_region() to 
make a decision.

> diff makes it look complex, but at a high level all I'm doing is moving the
> locking to outer function calls. It ends up looking more complex because there
> are some memory allocations which need reordering, but I don't think if things
> were originally written this way it would be considered complex.
> 
>   - Alistair
> 
>> --
>> Thanks,
>>
>> David / dhildenb
>>
> 
> 
> 
> 


-- 
Thanks,

David / dhildenb

