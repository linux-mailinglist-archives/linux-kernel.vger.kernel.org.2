Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9B541C7D2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 17:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344973AbhI2PGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 11:06:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344752AbhI2PGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632927912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oNY7lu4CVYlRtCbxUPnrsUuoXnqV93QpWri2uUHzgJc=;
        b=T4JlF2ZCPbXNdOKUYb+aaDWU4EDfwLcwejXOU2SVVMgoIawledq+Ln6zSqN+3HYNG5HXdI
        nDINnSg1hIN4XZPFoBVZdLn+QPV8S1Gyc1tNqwqRWre9WhRB2DGCNqSMZzOCJtjLEOek9W
        GRJq89Lx4s1J9x7odId5N57RLKsA6zk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-lHrTKnq1MdOz966m65giBA-1; Wed, 29 Sep 2021 11:05:11 -0400
X-MC-Unique: lHrTKnq1MdOz966m65giBA-1
Received: by mail-wm1-f70.google.com with SMTP id m9-20020a05600c4f4900b003057c761567so2848237wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 08:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=oNY7lu4CVYlRtCbxUPnrsUuoXnqV93QpWri2uUHzgJc=;
        b=NWlBu+VKK7Q2i+DnGSuRRb54omF1h2J19BchAFVxWX+VOBMWa8M5hnQZyMeT9omtJO
         E2C/lGwHH7dGs0sq3fvmNKrB7Su+YAQX1rIi2fLAuzHkAPgpup0J5XAeFFHZr7kz1tlU
         +/ZVxhUVAVs2k5y0cL+PYkCMnEoQcBnmNm4hDx0vHLCPCdjr6XFuu4SLp+I+fCEn2BXE
         9OyTGl88BK3kR2X4QAGYnQEopdjEQQTlaswpX9sYPzAOlvaTZTW9JP2jvGldo+riCvUH
         E4iWKm7RUos0S/o2d47C0lA5QL+YMD8OYNIMNSz107oKt1BbViMii4iTHmGSnbwd7je7
         fa0A==
X-Gm-Message-State: AOAM532aKYAxABQY9/SGxSSgbHr9/klU8UYA9FKaQJ3FIHrNGouHFgL5
        QRb1mUDjuLM8aCmfhPc5wDsr8VZnHniZUXcmbssQYUJHbx76jFdCFziQ/qDn4PCrNym+AhCWOkf
        mQXfGKUgi87k0s3Cm5S8UX/zV
X-Received: by 2002:a05:6000:1b8d:: with SMTP id r13mr421669wru.230.1632927909885;
        Wed, 29 Sep 2021 08:05:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5yPMk0g1o1wnpWIcweThTcWilK94BqSjhp2G8ePrKT/SUMx6KDIiNd6Aq4yt2b5V85P3H2g==
X-Received: by 2002:a05:6000:1b8d:: with SMTP id r13mr421637wru.230.1632927909676;
        Wed, 29 Sep 2021 08:05:09 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23c3b.dip0.t-ipconnect.de. [79.242.60.59])
        by smtp.gmail.com with ESMTPSA id o19sm164133wrg.60.2021.09.29.08.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 08:05:09 -0700 (PDT)
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ping Fang <pifang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <20210908132727.16165-1-david@redhat.com>
 <CA+KHdyWadbqZ=xVBv6uZwxpZSEndAAk_inK+0962VcntY+mnSA@mail.gmail.com>
 <CA+KHdyUTQLwN0YASOX8XJoWCD_x1QwRmz81BGShCzb_8jZ93XQ@mail.gmail.com>
 <ea75df96-f381-6949-5627-1382a370dc71@redhat.com>
 <20210916193403.GA1940@pc638.lan>
 <221e38c1-4b8a-8608-455a-6bde544adaf0@redhat.com>
 <20210921221337.GA60191@pc638.lan>
 <7f62d710-ca85-7d33-332a-25ff88b5452f@redhat.com>
 <20210922104141.GA27011@pc638.lan>
 <e378e60a-319b-e9aa-7e30-3e280c4431da@redhat.com>
 <CA+KHdyWZ9T2GEuUENXD_OYHX1JxKfZuW5YzmDtqXUYSgkQd8fQ@mail.gmail.com>
 <953ea84a-aabb-f64b-b417-ba60928430e0@redhat.com>
 <CA+KHdyWFjtoVqGd=7-yp33G-5WcZCtf80BaAk+3jx2bW5FCfWA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1] mm/vmalloc: fix exact allocations with an alignment >
 1
Message-ID: <689b7c24-623d-c01e-6c0f-ad430f1fa3ae@redhat.com>
Date:   Wed, 29 Sep 2021 17:05:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CA+KHdyWFjtoVqGd=7-yp33G-5WcZCtf80BaAk+3jx2bW5FCfWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.09.21 16:49, Uladzislau Rezki wrote:
> On Wed, Sep 29, 2021 at 4:40 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 29.09.21 16:30, Uladzislau Rezki wrote:
>>>>
>>>> So the idea is that once we run into a dead end because we took a left
>>>> subtree, we rollback to the next possible rigth subtree and try again.
>>>> If we run into another dead end, we repeat ... thus, this can now happen
>>>> more than once.
>>>>
>>>> I assume the only implication is that this can now be slower in some
>>>> corner cases with larger alignment, because it might take longer to find
>>>> something suitable. Fair enough.
>>>>
>>> Yep, your understanding is correct regarding the tree traversal. If no
>>> suitable block
>>> is found in left sub-tree we roll-back and check right one. So it can
>>> be(the scanning)
>>> more than one time.
>>>
>>> I did some performance analyzing using vmalloc test suite to figure
>>> out a performance
>>> loss for allocations with specific alignment. On that syntactic test i
>>> see approx. 30%
>>> of degradation:
>>
>> How realistic is that test case? I assume most alignment we're dealing
>> with is:
>> * 1/PAGE_SIZE
>> * huge page size (for automatic huge page placing)
>>
> Well that is synthetic test. Most of the alignments are 1 or PAGE_SIZE.
> There are users which use internal API where you can specify an alignment
> you want but those are mainly like KASAN, module alloc, etc.
> 
>>>
>>> 2.225 microseconds vs 1.496 microseconds. That time includes both
>>> vmalloc() and vfree()
>>> calls. I do not consider it as a big degrade, but from the other hand
>>> we can still adjust the
>>> search length for alignments > one page:
>>>
>>> # add it on top of previous proposal and search length instead of size
>>> length = align > PAGE_SIZE ? size + align:size;
>>
>> That will not allow to place huge pages in the case of kasan. And I
>> consider that more important than optimizing a syntactic test :) My 2 cents.
>>
> Could you please to be more specific? I mean how is it connected with huge
> pages mappings? Huge-pages are which have order > 0. Or you mean that
> a special alignments are needed for mapping huge pages?

Let me try to clarify:


KASAN does an exact allocation when onlining a memory block, 
__vmalloc_node_range() will try placing huge pages first, increasing the 
alignment to e.g., "1 << PMD_SHIFT".

If we increase the search length in find_vmap_lowest_match(), that 
search will fail if the exact allocation is surrounded by other 
allocations. In that case, we won't place a huge page although we could 
-- because find_vmap_lowest_match() would be imprecise for alignments > 
PAGE_SIZE.


Memory blocks we online/offline on x86 are at least 128MB. The KASAN 
"overhead" we have to allocate is 1/8 of that -- 16 MB, so essentially 8 
huge pages.

__vmalloc_node_range() will increase the alignment to 2MB to try placing 
huge pages first. find_vmap_lowest_match() will search within the given 
exact 16MB are a 18MB area (size + align), which won't work. So 
__vmalloc_node_range() will fallback to the original PAGE_SIZE alignment 
and shift=PAGE_SHIFT.

__vmalloc_area_node() will set the set_vm_area_page_order effectively to 
0 --  small pages.

Does that make sense or am I missing something?

-- 
Thanks,

David / dhildenb

