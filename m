Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2BB330F0B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCHNWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:22:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46102 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229690AbhCHNWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615209738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QepiH7o0LvrwYirRzj8uzBG9m05jsx4NbX/GyZA7UMw=;
        b=Pici/6Z5Ahk6+yAu6cCGzslRqMPPX/SVlzr6J8dUenZ8ADm8dVG8XAjCHF9oYw0lQjn8NR
        XeybpjUEGsVep0apZfb1gh1/RhdPl/dn2K6q/6xxYeVEhr1oV6nPQHjuIjKeLpthU1fWel
        ix9Z3ISugDzP1+ULCPle4xERhhkFL34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-jP6MmbyxP72SCDAGql5zqg-1; Mon, 08 Mar 2021 08:22:16 -0500
X-MC-Unique: jP6MmbyxP72SCDAGql5zqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BF761084D69;
        Mon,  8 Mar 2021 13:22:15 +0000 (UTC)
Received: from [10.36.113.123] (ovpn-113-123.ams2.redhat.com [10.36.113.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB21861F55;
        Mon,  8 Mar 2021 13:22:13 +0000 (UTC)
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
To:     Michal Hocko <mhocko@suse.com>, Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com
References: <YC+ErI8KIJV4Wd7u@dhcp22.suse.cz> <YD50pcPuwV456vwm@google.com>
 <YEEES/K8cNi8qOJe@google.com>
 <d83a03dd-fdff-ed62-a2ad-77b25d8249f0@redhat.com>
 <YEEJf0itS/8vn8Iy@google.com>
 <d3095ead-a762-61cd-0990-702e14e03d10@redhat.com>
 <YEEUq8ZRn4WyYWVx@google.com>
 <c08662f3-6ae1-4fb5-1c4f-840a70fad035@redhat.com>
 <YEEi1+TREGBElE5H@google.com> <YEEle5xBAc7FUDNI@google.com>
 <YEYdR8azcawau9Rl@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c1461e51-7ad0-7fb5-9dc2-7f7c5cdf128f@redhat.com>
Date:   Mon, 8 Mar 2021 14:22:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEYdR8azcawau9Rl@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.03.21 13:49, Michal Hocko wrote:
> On Thu 04-03-21 10:22:51, Minchan Kim wrote:
> [...]
>> How about this?
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 238d0fc232aa..489e557b9390 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8481,7 +8481,8 @@ static inline void dump_migrate_failure_pages(struct list_head *page_list)
>>
>>   /* [start, end) must belong to a single zone. */
>>   static int __alloc_contig_migrate_range(struct compact_control *cc,
>> -                                       unsigned long start, unsigned long end)
>> +                                       unsigned long start, unsigned long end,
>> +                                       bool nofail)
> 
> This sounds like a very bad idea to me. Your nofail definition might
> differ from what we actually define as __GFP_NOFAIL but I do not think
> this interface should ever promise anything that strong.
> Sure movable, cma regions should effectively never fail but there will
> never be any _guarantee_ for that.

While there are no guarantees, we want to make such allocations as 
likely as possible to succeed. Not succeeding should be the corner case 
and is worth investigating.

> 
> Earlier in the discussion I have suggested dynamic debugging facility.
> Documentation/admin-guide/dynamic-debug-howto.rst. Have you tried to
> look into that direction?

Did you see the previous mail this is based on:

https://lkml.kernel.org/r/YEEUq8ZRn4WyYWVx@google.com

I agree that "nofail" is misleading. Rather something like 
"dump_on_failure", just a better name :)

-- 
Thanks,

David / dhildenb

