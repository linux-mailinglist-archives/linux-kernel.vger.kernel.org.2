Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA32A38DB1D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 14:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhEWMHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 08:07:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35661 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231735AbhEWMHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 08:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621771584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fbca4TGkvKevqvVIisn5OD+hcWFB2SZBVwQGKJH6JIE=;
        b=I2bD1fysdgtryHgCgH6F4fh+8g7+Cci2Kvh/4fcH02VtTTc+6gv45tjwO4Xw4kRaEbZHRm
        dToiFi3Ih+H+n3EeP7StOP9k9U1iOK7fYI4tQ48wOqgfiwRm7/uJs6RYNxI98Bh5LdHoE7
        u1f5ED78nOQEnBNchvGoIkWBzkg7Zaw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-FrowVd-NOgCI692Z5TtWfQ-1; Sun, 23 May 2021 08:06:23 -0400
X-MC-Unique: FrowVd-NOgCI692Z5TtWfQ-1
Received: by mail-wr1-f69.google.com with SMTP id a9-20020adfc4490000b0290112095ca785so6258240wrg.14
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 05:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Fbca4TGkvKevqvVIisn5OD+hcWFB2SZBVwQGKJH6JIE=;
        b=CLa95PNggbUItz7QgYbeSD9K6qtmznPjkzcCCkM/pMrQk7mqt5waFRQZ1aBkmnwNK0
         tnteP5vuAcbak7YcvCUw06qf5d+quqRD9VeAkwIca8AfREWwbXcFdlV4CJit19ZDjAyM
         I+SABW/bfC7u/WMcnT8sz5Ids06mzNLuJVBaie5rQYVy3kENz1rO6vygNhEsqEp+vofb
         pGLWHFR/xMF14MxOSwYEdxb3zRStk8WxaLmExl4iC13MdxyyAkTKB1HcVhfebnIJQVI0
         QqbTzIGuQ1BbcRXGg3Wj7fR1KWrys+d0xXdKYqIRUk9idPs+KnY7IF+IhjbNOXWrXemH
         WchQ==
X-Gm-Message-State: AOAM5323o+o3mdssMDxfok4DjH7m/4Nm9KTQzWZe7PdpJSbrkbJKoMdY
        RTLzwZ4nx69dDSxMfCQnrIj0GgKyzvpqwbY3EVXHNiTkfp1dRxixiSoa27tQDAIDc9SywVQgKSa
        /Pp60VS3JYWqLLdV5211Glt08
X-Received: by 2002:adf:fd45:: with SMTP id h5mr17244446wrs.383.1621771581826;
        Sun, 23 May 2021 05:06:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwskhrhxyG9geMrYT8Ze0ONFTcfoteIYZZXYoPRqaBcB2+JSavlAvgOYa6Yy9nkhIDVIQ9rgA==
X-Received: by 2002:adf:fd45:: with SMTP id h5mr17244438wrs.383.1621771581629;
        Sun, 23 May 2021 05:06:21 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f38:2400:62f4:c5fa:ba13:ac32? (p200300d82f38240062f4c5faba13ac32.dip0.t-ipconnect.de. [2003:d8:2f38:2400:62f4:c5fa:ba13:ac32])
        by smtp.gmail.com with ESMTPSA id y137sm4851720wmc.11.2021.05.23.05.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 May 2021 05:06:21 -0700 (PDT)
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
 <4c7104bc-6950-9334-a066-c01b92577b57@redhat.com>
 <YKfwXtx7v/tuJQxc@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <586bb64e-b139-bd99-e7cb-f8148db2949a@redhat.com>
Date:   Sun, 23 May 2021 14:06:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKfwXtx7v/tuJQxc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.05.21 19:39, Minchan Kim wrote:
> On Fri, May 21, 2021 at 10:08:15AM +0200, David Hildenbrand wrote:
>> On 20.05.21 22:51, Minchan Kim wrote:
>>> On Thu, May 20, 2021 at 09:28:09PM +0200, David Hildenbrand wrote:
>>>> Minchan Kim <minchan@kernel.org> schrieb am Do. 20. Mai 2021 um 21:20:
>>>>
>>>>> On Wed, May 19, 2021 at 02:33:41PM -0700, Minchan Kim wrote:
>>>>>> alloc_contig_dump_pages aims for helping debugging page migration
>>>>>> failure by page refcount mismatch or something else of page itself
>>>>>> from migration handler function. However, in -ENOMEM case, there is
>>>>>> nothing to get clue from page descriptor information so just
>>>>>> dump pages only when -EBUSY happens.
>>>>>>
>>>>>> Signed-off-by: Minchan Kim <minchan@kernel.org>
>>>>>> ---
>>>>>>    mm/page_alloc.c | 3 ++-
>>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>>> index 3100fcb08500..c0a2971dc755 100644
>>>>>> --- a/mm/page_alloc.c
>>>>>> +++ b/mm/page_alloc.c
>>>>>> @@ -8760,7 +8760,8 @@ static int __alloc_contig_migrate_range(struct
>>>>> compact_control *cc,
>>>>>>
>>>>>>         lru_cache_enable();
>>>>>>         if (ret < 0) {
>>>>>> -             alloc_contig_dump_pages(&cc->migratepages);
>>>>>> +             if (ret == -EBUSY)
>>>>>> +                     alloc_contig_dump_pages(&cc->migratepages);
>>>>>>                 putback_movable_pages(&cc->migratepages);
>>>>>>                 return ret;
>>>>>>         }
>>>>>> --
>>>>>> 2.31.1.751.gd2f1c929bd-goog
>>>>>>
>>>>>
>>>>> Resend with a little modifying description.
>>>>>
>>>>>   From c5a2fea291cf46079b87cc9ac9a25fc7f819d0fd Mon Sep 17 00:00:00 2001
>>>>> From: Minchan Kim <minchan@kernel.org>
>>>>> Date: Wed, 19 May 2021 14:22:18 -0700
>>>>> Subject: [PATCH] mm: page_alloc: dump migrate-failed pages only at -EBUSY
>>>>>
>>>>> alloc_contig_dump_pages aims for helping debugging page migration
>>>>> failure by elevated page refcount compared to expected_count.
>>>>> (for the detail, please look at migrate_page_move_mapping)
>>>>>
>>>>> However, -ENOMEM is just the case that system is under memory
>>>>> pressure state, not relevant with page refcount at all. Thus,
>>>>> the dumping page list is not helpful for the debugging point of view.
>>>>>
>>>>
>>>> what about -ENOMEM when migrating empty/free huge pages? I think there is
>>>> value in having the pages dumped to identify something like that. And it
>>>> doesn‘t require heavy memory pressure to fail allocating a huge page.
>>>>
>>>
>>> -ENOMEM means there is no memory to alloate destination page.
>>> How could it help dumping source pages in those case from dump_page
>>> content point of view?
>>
>> You would spot a huge page in the source list (usually at first position)
>> without any obvious migration blockers I assume?
> 
> It was not a huge page case.
> 
>>
>> I'm wondering, did you actually run into this being suboptimal? If it's a
>> real problem dumping too many stuff when running into -ENOMEM, fine with me.
>> If it's a theoretical issue, I'd prefer to just keep it simple as is.
> 
> That's exactly what I encountered. With -ENOMEM, it dumped bunch of
> pages on migratepages list. It was just useless with just consuming
> logbuffer since there are nothing much to investigate with dumping
> source pages.
> 

Fine with me, then

Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!

-- 
Thanks,

David / dhildenb

