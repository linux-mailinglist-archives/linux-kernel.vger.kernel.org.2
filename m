Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7CA3A1081
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbhFIJrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 05:47:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30017 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234017AbhFIJrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 05:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623231928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ocQman1zRsrL4s92otV0jdl9RY3ZlJiX9vy7pTHzR3c=;
        b=Y5r7Yqw5/P8cm1gxyXVXkAwBBkhl5QFlYAcg61cCukPWOmDowaGB5PmcP1bFe9A0b12c0G
        GQwMG8VlwMSz0wuxKxKmQWZ7Mme9/PBHZE5qMt7bRBDlZxYEfYZVJoUkCodf+f0rZzw6Bw
        9fyo7cBXfQdBOvE0yT5cCt0iEG3WEDY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-5hb1ia7IOQOUsFGu4U4_CQ-1; Wed, 09 Jun 2021 05:42:17 -0400
X-MC-Unique: 5hb1ia7IOQOUsFGu4U4_CQ-1
Received: by mail-wr1-f69.google.com with SMTP id f22-20020a5d58f60000b029011634e39889so10489076wrd.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 02:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ocQman1zRsrL4s92otV0jdl9RY3ZlJiX9vy7pTHzR3c=;
        b=WTwtPZnlq4RKfuxselwSQvn9iAg5nHXUfRt0ZXpuaW0Ri/hlDBAaOlEnRDliwhDf9q
         Cg7nwK691ws+gewdqi0Jse44yfbZ627DIzJiEvKVe++QYXBnYwKuUtRZ7zJcqRPYQteg
         g8dSv8hor5UgYcTeNsiUInB5fEG+pRHBlqcMqvx9wRsp07MBNUBVy6OacYvaCyqLaTkW
         tR30cTfrD2mr9i/hw7IYb6kg2vfS+e5P4ilSuxklLu0QuEoaDd2FWJHOcnGtW18aQm/6
         U4k+cFdp6jy7bZVcDCVM6/A1XHzR0xJRo7ybA6vR48BWYvYTLiazvouaXmOtCcTMs1Ro
         Kh5A==
X-Gm-Message-State: AOAM531HLbNqjTKEf4c9lpLkammCXA331xbrHMEpmtAlhm4TujEsNXXK
        EFwhXlgNw0eBbTJOW3ehM04ddQUdOt7TejGCGA/9A9RGfU07lPjhAZI1eDnDAhgnssPxhzO0Xf9
        WJA/tB5U1I1Db16YN/FWFFNei6FFePLHvtfwfhMnfb/Wwm7ynMbha9G5n/9ZvVkOlvkjpWzFr
X-Received: by 2002:a5d:4d4d:: with SMTP id a13mr16925571wru.33.1623231736436;
        Wed, 09 Jun 2021 02:42:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQKbmLoyGPrWFEyLWdGLouCNu1JSI/opguRMzImaNdHtILOtj3Kogq1GQJXZ0NTdehycSRhg==
X-Received: by 2002:a5d:4d4d:: with SMTP id a13mr16925538wru.33.1623231736097;
        Wed, 09 Jun 2021 02:42:16 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c611d.dip0.t-ipconnect.de. [91.12.97.29])
        by smtp.gmail.com with ESMTPSA id t1sm22639629wrx.28.2021.06.09.02.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 02:42:15 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] mm,page_alloc: Use {get,put}_online_mems() to get
 stable zone's values
From:   David Hildenbrand <david@redhat.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210602091457.17772-1-osalvador@suse.de>
 <20210602091457.17772-2-osalvador@suse.de>
 <39473305-6e91-262d-bcc2-76b745a5b14a@redhat.com>
 <ed17a39ad61edeb19b04c0f4308d5d36@suse.de>
 <YLiVAAsCTR7B6Db9@localhost.localdomain> <YLjO2YU2G5fTVB3x@dhcp22.suse.cz>
 <20210604074140.GA25063@linux> <20210607075147.GA10554@linux>
 <85984701-55ae-dfa5-2a8d-f637051b612d@redhat.com>
 <20210607102318.GA12683@linux>
 <0eadea9c-5af0-d7e6-071e-898b04294dd3@redhat.com>
Organization: Red Hat
Message-ID: <a1fe74b9-5531-5cbb-f24a-437ac7534904@redhat.com>
Date:   Wed, 9 Jun 2021 11:42:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <0eadea9c-5af0-d7e6-071e-898b04294dd3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.06.21 17:00, David Hildenbrand wrote:
> On 07.06.21 12:23, Oscar Salvador wrote:
>> On Mon, Jun 07, 2021 at 10:49:01AM +0200, David Hildenbrand wrote:
>>> I'd like to point out that I think the seqlock is not in place to
>>> synchronize with actual growing/shrinking but to get consistent zone ranges
>>> -- like using atomics, but we have two inter-dependent values here.
>>
>> I guess so, at least that's what it should do.
>> But the way it is placed right now is misleading.
>>
>> If we really want to get consistent zone ranges, we should start using
>> zone's seqlock where it matters and that is pretty much all those
>> places that use zone_spans_pfn().
> 
> Right, or even only zone_end_pfn() to get a consistent value.
> 
>> Otherwise there is no way you can be sure the pfn you're checking is
>> within the limits. Moreover, as Michal pointed out early, if we really
>> want to go down that road the locking should be made in the caller
>> evolving the operation, otheriwse things might change once the lock
>> is dropped and you're working with a wrong assumption.
>>
>> I can see arguments for both riping it out and doing it right (but none for
>> the way it is right now).
>> For riping it out, one could say that those races might not be fatal,
>> as usually the pfn you're working with (the one you want to check falls
>> within a certain range) you know is valid, so the worst can happen is
>> you get false positives/negatives and that might or might not be detected
>> further down. How bad are false positive/negatives I guess it depends on the
>> situation, but we already do that right now.
>> The zone_spans_pfn() from page_outside_zone_boundaries() is the only one using
>> locking right now, so well, if we survided this long without locks in other places
>> using zone_spans_pfn() makes one wonder if it is that bad.
>>
>> On the other hand, one could argue that for correctness sake, we should be holding
>> zone's seqlock whenever checking for zone_spans_pfn() to avoid any inconsistency.
>>
>>
> 
> IMHO, as we know the race exists and we have a tool to handle it in
> place, we should maybe fix the obvious cases if possible.
> 
> Code that uses zone->zone_start_pfn directly is unlikely to be broken on
> most architectures. We will usually read/write via single instruction
> and won't get inconsistencies, for example, when shrinking or growing
> the zone. We most probably don't want to use an atomic for that right now.
> 
> Code that uses zone->spanned_pages to detect the zone end, however, is
> more likely to be broken. I don't think we have any relevant around
> anymore. Everything was converted to zone_end_pfn().
> 
> I feel like we should just make zone_end_pfn() take the seqlock in read.
> Then, we at least get a consistent value, for example, while growing a zone.
> 
> Just imagine the following case when we grow a section to the front when
> onlining memory:
> 
> 	zone->zone_start_pfn -= new_pages;
> 	zone->spanned_pages += new_pages;
> 
> Note that compilers/CPUs might reshuffle as they like. If someone (e.g.,
> zone_spans_pfn()) races with that code, it might get new
> zone->zone_start_pfn but old zone->spanned_pages. zone_end_pfn() will
> report a "too small zone" and trigger false negatives in zone_spans_pfn().
> 

Thinking again, we could of course also simply convert to 
zone->zone_start_+ pfn zone->zone_end_pfn. Places that need 
spanned_pages() would have the same issue, but I think they are rather a 
concern case.

-- 
Thanks,

David / dhildenb

