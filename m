Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73244416FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 12:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245531AbhIXKHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 06:07:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57796 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245408AbhIXKHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 06:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632477928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G1MHHrRMd/7rgiVSmOO3Ic9tCAKxtmx125cnMX3Uf3g=;
        b=d4UvSGadtf14lt9eIxnn/xuSjGCkHba9PvXSjMAn8ZKgXvaHShtOZ/1A9fpibjlSfFH7dK
        JeG6tntrPc0bW+zvH28V8dfG1KMzoCqqSMI63mNEOfSTkTbGV6gXODSvUwnvl7wsckSPyL
        v6g/oVKIhPkwSZG7/XOWFscQTx4dhts=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-JyFNyxLgPqy-zUmZ9VkmeQ-1; Fri, 24 Sep 2021 06:05:27 -0400
X-MC-Unique: JyFNyxLgPqy-zUmZ9VkmeQ-1
Received: by mail-wr1-f70.google.com with SMTP id x2-20020a5d54c2000000b0015dfd2b4e34so7630907wrv.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 03:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=G1MHHrRMd/7rgiVSmOO3Ic9tCAKxtmx125cnMX3Uf3g=;
        b=1xURjhhhmglhvpF9X7S0HCIoGcFrGRXsvrNJxCTzH6fUeTFCRO9zmm+OfQs0Q+1xkS
         OA/AXdESTfxZOtczxKCFeVFKkwuRBE4edTJXdrQZFSkxcW0S7ExUVkJUdu7Yg5OuCYO2
         0nkrnFaqQFiHWbXK0yZrTZgw/K0QybI5C3ziqp7yuS/nEayv/QZVQZPJIkjzqYqYxj+z
         RYLpL109B0rSOnZyFiIu0l9bIVMt9yBdIJMN0LeNw7qVMk4OyBKJvOu1B3zUsR1DFgCF
         JzlUpI3QD9XqCJE4j5NhKAS1W012Vgl72343UjIZEmraSl644Skw05MbkZfn6LUipbHx
         FZ1A==
X-Gm-Message-State: AOAM532wQCXHGCPf/wA3xGabpg2cFdxt0U04MgMZ7rOcNDdmUvvbg3aQ
        tQp20ED7QMam49ZW4W8SP6o5IVy8U/ffKQLjhDdzncHMKSA8wl7AvzYUPZ3xn8PiGhg/ahcCXLX
        Ph0KSgiKDkIxj2zzrrLJC+D3A
X-Received: by 2002:adf:e481:: with SMTP id i1mr10430155wrm.353.1632477925754;
        Fri, 24 Sep 2021 03:05:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1JpvaN7QXgXQv6sMLeO1OF9LmUYwSp23XprYC2U34yKRztdqKdy9ePX35meKz7gH0zxLCEA==
X-Received: by 2002:adf:e481:: with SMTP id i1mr10430127wrm.353.1632477925517;
        Fri, 24 Sep 2021 03:05:25 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c61fc.dip0.t-ipconnect.de. [91.12.97.252])
        by smtp.gmail.com with ESMTPSA id y64sm8597845wmc.38.2021.09.24.03.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 03:05:25 -0700 (PDT)
Subject: Re: [PATCH] mm/khugepaged: Detecting uffd-wp vma more efficiently
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20210922175156.130228-1-peterx@redhat.com>
 <6bbb8e29-9e21-dfbe-d23d-61de7e3cc6db@redhat.com> <YUt833H6eaYFyHXD@t490s>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <ce656fae-558f-c91a-ea8d-fdd66489b12d@redhat.com>
Date:   Fri, 24 Sep 2021 12:05:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YUt833H6eaYFyHXD@t490s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.21 20:58, Peter Xu wrote:
> On Wed, Sep 22, 2021 at 08:21:40PM +0200, David Hildenbrand wrote:
>> On 22.09.21 19:51, Peter Xu wrote:
>>> We forbid merging thps for uffd-wp enabled regions, by breaking the khugepaged
>>> scanning right after we detected a uffd-wp armed pte (either present, or swap).
>>>
>>> It works, but it's less efficient, because those ptes only exist for VM_UFFD_WP
>>> enabled VMAs.  Checking against the vma flag would be more efficient, and good
>>> enough.  To be explicit, we could still be able to merge some thps for
>>> VM_UFFD_WP regions before this patch as long as they have zero uffd-wp armed
>>> ptes, however that's not a major target for thp collapse anyways.
>>>
>>
>> Hm, are we sure there are no users that could benefit from the current
>> handling?
>>
>> I'm thinking about long-term uffd-wp users that effectively end up wp-ing on
>> only a small fraction of a gigantic vma, or always wp complete blocks in a
>> certain granularity in the range of THP.
> 
> Yes, that's a good question.
> 
>>
>> Databases come to mind ...
> 
> One thing to mention is that this patch didn't forbid thp being used within a
> uffd-wp-ed range.  E.g., we still allow thp exist, we can uffd-wp a thp and
> it'll split only until when the thp is written.
> 
> While what this patch does is it stops khugepaged from proactively merging
> those small pages into thps as long as VM_UFFD_WP|VM_UFFD_MINOR is set.  It may
> still affect some user, but it's not a complete disable on thp.
> 
>>
>> In the past, I played with the idea of using uffd-wp to protect access to
>> logically unplugged memory regions part of virtio-mem devices in QEMU --
>> which would exactly do something as described above. But I'll most probably
>> be using ordinary uffd once any users that might read such logically
>> unplugged memory have been "fixed".
> 
> Yes, even if you'd like to keep using uffd-wp that sounds like a very
> reasonable scenario.
> 
>>
>> The change itself looks sane to me AFAIKT.
> 
> So one major motivation of this patch of mine is to prepare for shmem, because
> the old commit obviously only covered anonymous.
> 
> But after a 2nd thought, I just noticed shmem shouldn't have a problem with
> khugepaged merging at all!
> 
> The thing is, when khugepaged is merging a shmem thp, unlike anonymous, it'll
> not merge the ptes into a pmd, but it'll simply zap the ptes.  It means all
> uffd-wp tracking information won't be lost even if merging happened, those info
> will still be kept inside pgtables using (the upcoming) pte markers.
> 
> When faulted, we'll just do small page mappings while it won't stop the shmem
> thp from being mapped hugely in other mm, afaict.
> 
> With that in mind, indeed I see this patch less necessary to be merged; so for
> sparsely wr-protected vmas like virtio-mem we can still keep some of the ranges
> mergeable, that sounds a good thing to keep it as-is.
> 
> NACK myself for now: let's not lose that good property of both thp+uffd-wp so
> easily, and I'll think more of it.
> 

Thanks for the insights, shmem THP is still mostly unexplored territory 
on my end :)

-- 
Thanks,

David / dhildenb

