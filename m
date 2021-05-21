Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A99838C16C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 10:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbhEUIMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 04:12:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27418 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236426AbhEUIK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 04:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621584499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ioSqPukqM0EZIJQNY+nqzk8IymOGxLsSyLbLH6KWwQ=;
        b=ZwV/NlFuAQ7Iq2ko28Sqr951GRsvqc6jiJw1wF9yRDGfdF00pV4K/2Y2w4ZU3/XAzsI34g
        WBnLdQgGu4k26B8G6ep/diE0QnRRvp3kk8/GIcl8iydzRA+tH95dlEvDlxR8uxdzMtYIDz
        aKgsGKvSLZRHZFcNI3csWfBKfcEv/Xo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-zBV6_cDnMIW7CX3XJSWwRg-1; Fri, 21 May 2021 04:08:17 -0400
X-MC-Unique: zBV6_cDnMIW7CX3XJSWwRg-1
Received: by mail-wr1-f71.google.com with SMTP id 7-20020adf95070000b02901104ad3ef04so9131266wrs.16
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 01:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0ioSqPukqM0EZIJQNY+nqzk8IymOGxLsSyLbLH6KWwQ=;
        b=M2+6IW3+jH8fdfB2F83LiyAhsykfbM5Ir7TzXJrmAwqpML0yKmJhhPbppHqLHc4InO
         xsr6Lvv3GTasJrxlmuhNi1MxxQpPZ++BzVnBPSE4nqBykvJNMwy3KXJ9lZBE3lzUfuJ/
         PjNhj47PU/eckzWv+15kQgjah8XKH/WdTq0HB0YO2KNUWWPc2+9U2eTWklmehG9TuBfj
         H8Ydcw91+Dy3rvKJMtXrfRKytEjg8kva3iTJ/d181KbGwmwTa6UTTPIWKwZ4lri2CeeJ
         czJYaiNQVAtxxExO72ov4GPgcuLpURCY9DSRy/y6mBckg0TyOoX4LHI+W6y8KO4YuU/V
         h4Gw==
X-Gm-Message-State: AOAM531Axqcrm3uihHKklrYPj+ZoBEZhQzK/Wlzurg1YqAGBPk/R63K6
        IGMXwBG1/P3wsFMvMO+4s38oS/Klk6nt8sw0MTo5woyyIrX0uZMQVPJSyDnafBWkouDiSq9CvTw
        JL1nAibmdKHGW6ya00rGUE2ZR
X-Received: by 2002:a05:600c:4f4e:: with SMTP id m14mr7891960wmq.164.1621584496621;
        Fri, 21 May 2021 01:08:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyMtHnMtnBDkXbglc8FJyWOVqwY8TTcC1T+QXa1gWNAOrwVug1xH6DFbmKf39M5cSqCCqcpw==
X-Received: by 2002:a05:600c:4f4e:: with SMTP id m14mr7891945wmq.164.1621584496426;
        Fri, 21 May 2021 01:08:16 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6502.dip0.t-ipconnect.de. [91.12.101.2])
        by smtp.gmail.com with ESMTPSA id x13sm1180497wro.31.2021.05.21.01.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 01:08:16 -0700 (PDT)
Subject: Re: [PATCH] mm: page_alloc: dump migrate-failed pages only at -EBUSY
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        John Dias <joaodias@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-mm <linux-mm@kvack.org>
References: <20210519213341.2620708-1-minchan@kernel.org>
 <YKa2Wyo9xqIErpfa@google.com>
 <CADFyXm6jY1nbBsQ4nVXqJksNZKi1rDBw5igFSOLsVzw5sra6Tw@mail.gmail.com>
 <YKbLtsUY2xg9QrYz@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <4c7104bc-6950-9334-a066-c01b92577b57@redhat.com>
Date:   Fri, 21 May 2021 10:08:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKbLtsUY2xg9QrYz@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.05.21 22:51, Minchan Kim wrote:
> On Thu, May 20, 2021 at 09:28:09PM +0200, David Hildenbrand wrote:
>> Minchan Kim <minchan@kernel.org> schrieb am Do. 20. Mai 2021 um 21:20:
>>
>>> On Wed, May 19, 2021 at 02:33:41PM -0700, Minchan Kim wrote:
>>>> alloc_contig_dump_pages aims for helping debugging page migration
>>>> failure by page refcount mismatch or something else of page itself
>>>> from migration handler function. However, in -ENOMEM case, there is
>>>> nothing to get clue from page descriptor information so just
>>>> dump pages only when -EBUSY happens.
>>>>
>>>> Signed-off-by: Minchan Kim <minchan@kernel.org>
>>>> ---
>>>>   mm/page_alloc.c | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index 3100fcb08500..c0a2971dc755 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -8760,7 +8760,8 @@ static int __alloc_contig_migrate_range(struct
>>> compact_control *cc,
>>>>
>>>>        lru_cache_enable();
>>>>        if (ret < 0) {
>>>> -             alloc_contig_dump_pages(&cc->migratepages);
>>>> +             if (ret == -EBUSY)
>>>> +                     alloc_contig_dump_pages(&cc->migratepages);
>>>>                putback_movable_pages(&cc->migratepages);
>>>>                return ret;
>>>>        }
>>>> --
>>>> 2.31.1.751.gd2f1c929bd-goog
>>>>
>>>
>>> Resend with a little modifying description.
>>>
>>>  From c5a2fea291cf46079b87cc9ac9a25fc7f819d0fd Mon Sep 17 00:00:00 2001
>>> From: Minchan Kim <minchan@kernel.org>
>>> Date: Wed, 19 May 2021 14:22:18 -0700
>>> Subject: [PATCH] mm: page_alloc: dump migrate-failed pages only at -EBUSY
>>>
>>> alloc_contig_dump_pages aims for helping debugging page migration
>>> failure by elevated page refcount compared to expected_count.
>>> (for the detail, please look at migrate_page_move_mapping)
>>>
>>> However, -ENOMEM is just the case that system is under memory
>>> pressure state, not relevant with page refcount at all. Thus,
>>> the dumping page list is not helpful for the debugging point of view.
>>>
>>
>> what about -ENOMEM when migrating empty/free huge pages? I think there is
>> value in having the pages dumped to identify something like that. And it
>> doesn‘t require heavy memory pressure to fail allocating a huge page.
>>
> 
> -ENOMEM means there is no memory to alloate destination page.
> How could it help dumping source pages in those case from dump_page
> content point of view?

You would spot a huge page in the source list (usually at first 
position) without any obvious migration blockers I assume?

I'm wondering, did you actually run into this being suboptimal? If it's 
a real problem dumping too many stuff when running into -ENOMEM, fine 
with me. If it's a theoretical issue, I'd prefer to just keep it simple 
as is.

-- 
Thanks,

David / dhildenb

