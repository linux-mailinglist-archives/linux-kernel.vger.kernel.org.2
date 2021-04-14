Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869F935F31C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350656AbhDNMDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57224 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233651AbhDNMDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:03:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618401769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aHEy1xNdFom9dP0EOpBshNDqoumwNcfeRvHic4Mkn7s=;
        b=g82CE/KNiiCBRhsluIJhM5Qthuag5Nud1EDOab4qDyXLaayKiunNTtBX3CSSH4fMmDKhBM
        kE+EXTqbyrJg4rmklybrDR1OzuRieVl57yGZzBsBRXSCwE8Jit+IXXhHMowEiacpMVGwAT
        MDQsDWuvIENg/vHMFiA8UyyNr/L/m4M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-B4pso2gUMUK1eMl9PSOFCA-1; Wed, 14 Apr 2021 08:02:47 -0400
X-MC-Unique: B4pso2gUMUK1eMl9PSOFCA-1
Received: by mail-wm1-f70.google.com with SMTP id y82-20020a1ce1550000b02901262158f1e9so3227494wmg.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aHEy1xNdFom9dP0EOpBshNDqoumwNcfeRvHic4Mkn7s=;
        b=Fe+B5cBXLSNO2L3Lc8QuCSsUE0aU8eB8MC82pcVFyigtFiKzm3b1UX0oTvBddpyzmN
         wwY32RZzc+uprRyYSzq0JbTaG4Y9zZmeybZbYtGYKIlxovYWdkDPkJIhqdKEK0I3wP93
         GJJXXNTHAbrZq3dF4USwM6h7RSQl8CpmVZILYqxvXdKcIgOzkkEhAwAUIJoF2C6Ey5J2
         gyusFwJbpOXY2keFn5QBdVpKMO3HYJ7cu8pYjN4mC8yK7yZHLL8mqCEl6BfIWUx2GO7d
         i8NBLMRhc0Du+T5Q1gE7C3+Pf6Lp9hV0hEf5fIGlGDjj3Cf2jbuHN/lVn/TsTbUSFg2x
         65ZA==
X-Gm-Message-State: AOAM532TFA9/zziDi4xqdRjzaEoRrFVUVVD919GpwD1OV/EcCIDr5jAD
        DmEbbNmgOe1wcmkqOu8d+7sxRC1XRFRHfINpF56dOBZbqinHKh05lNW+RFOFAg14lrUaoAjt+9v
        hbqIQJj1yDMgYnEkb4RIlWt6BMvynGC1cvA79DjT7tAOGFNA2ei1TpqM4dMRnWu6UOnrfSpPk
X-Received: by 2002:a05:600c:1992:: with SMTP id t18mr2646093wmq.125.1618401766319;
        Wed, 14 Apr 2021 05:02:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIckROBZLgsBG6+3ktUXqvlVi8petXLZKUH+TnS84jke/Sld2EXtRQNFhBXCkAQrmXyQQluA==
X-Received: by 2002:a05:600c:1992:: with SMTP id t18mr2646058wmq.125.1618401766042;
        Wed, 14 Apr 2021 05:02:46 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6470.dip0.t-ipconnect.de. [91.12.100.112])
        by smtp.gmail.com with ESMTPSA id j23sm5020393wmo.33.2021.04.14.05.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 05:02:45 -0700 (PDT)
To:     Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-4-osalvador@suse.de> <YHWbPjgPpsLoqGvL@dhcp22.suse.cz>
 <b8f36340-df56-1180-2a14-7b20cc1a0cda@oracle.com>
 <YHaF5efHcJJ71UP9@dhcp22.suse.cz> <20210414074132.GB20401@linux>
 <YHansW/OnNT6/i9d@dhcp22.suse.cz> <20210414100147.GD20886@linux>
 <YHbE2q/Otrdx1cgK@dhcp22.suse.cz> <20210414104953.GF20886@linux>
 <YHbNUjU1Y4sqMVBd@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v7 3/7] mm,hugetlb: Clear HPageFreed outside of the lock
Message-ID: <f8d86f84-b354-cdaf-e1c6-4707dbe33dd9@redhat.com>
Date:   Wed, 14 Apr 2021 14:02:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YHbNUjU1Y4sqMVBd@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.04.21 13:09, Michal Hocko wrote:
> On Wed 14-04-21 12:49:53, Oscar Salvador wrote:
>> On Wed, Apr 14, 2021 at 12:32:58PM +0200, Michal Hocko wrote:
> [...]
>>>> I checked, and when we get there in __alloc_bootmem_huge_page, page->private is
>>>> still zeroed, so I guess it should be safe to assume that we do not really need
>>>> to clear the flag in __prep_new_huge_page() routine?
>>>
>>> It would be quite nasty if the struct pages content would be undefined.
>>> Maybe that is possible but then I would rather stick the initialization
>>> into __alloc_bootmem_huge_page.
>>
>> Yes, but I do not think that is really possible unless I missed something.
> 
> Yeah, it should be fine. I was thinking of a alloc, modify struct pages,
> free back to the bootmem allocator sequence. But I do not remember ever
> seeing sequence like that.

We do have code like that, though.

Take a look at arch/x86/mm/init_64.c:free_pagetable() as one example.

But in general, we assume freeing code (buddy, but also memblock) 
restores the state of the memmap to the original state it obtained the 
memmap. So if it's properly initialized when coming from the allocator 
the first time, it should remain properly initialized when re-entering 
and re-leaving the allocator.

-- 
Thanks,

David / dhildenb

