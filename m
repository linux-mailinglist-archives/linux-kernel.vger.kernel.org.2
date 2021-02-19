Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1833531F76B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhBSKjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:39:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35570 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229746AbhBSKiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613731042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eS7dBAdZyjIPN0DbbeWZ+nh4DQdjx7xDIzQdhc9Stp8=;
        b=AMGfK4rAuBbvpQOp/2F5aCGI+5nlu4gXgur7fwGnj1FcbkJ4Oj7THObad4ItrHIiO6teaN
        wAp4hNKEscrNFT3zwO+JUkOmTlNk4pS4wTPVqyz+1pAvUbbALaWBuYbpLCJAiDRhFA2T/F
        YYZWxIfShryHYEMsCdW3KT8V00k/FfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-YiCqyU24OaGcz-ba5vZxhA-1; Fri, 19 Feb 2021 05:37:16 -0500
X-MC-Unique: YiCqyU24OaGcz-ba5vZxhA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C749801979;
        Fri, 19 Feb 2021 10:37:15 +0000 (UTC)
Received: from [10.36.113.117] (ovpn-113-117.ams2.redhat.com [10.36.113.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBD6F5D9C2;
        Fri, 19 Feb 2021 10:37:13 +0000 (UTC)
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
To:     Michal Hocko <mhocko@suse.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com
References: <20210217163603.429062-1-minchan@kernel.org>
 <YC4rsr9zkNAvdL4T@dhcp22.suse.cz>
 <2f167b3c-5f0a-444a-c627-49181fc8fe0d@redhat.com>
 <YC402s1vqvC4q041@dhcp22.suse.cz>
 <fa8195f9-4d1b-7a77-1a02-d69710f4208b@redhat.com>
 <YC6TpqT26dSy11fU@google.com> <YC+ErI8KIJV4Wd7u@dhcp22.suse.cz>
 <45f1bffe-8a0b-2969-32d4-e24a911a647d@redhat.com>
 <YC+MpecknddNQ4+o@dhcp22.suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <58d7f10e-227c-eb05-64b5-f0a2ff05bc9c@redhat.com>
Date:   Fri, 19 Feb 2021 11:34:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YC+MpecknddNQ4+o@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.02.21 11:02, Michal Hocko wrote:
> On Fri 19-02-21 10:30:12, David Hildenbrand wrote:
>> On 19.02.21 10:28, Michal Hocko wrote:
>>> On Thu 18-02-21 08:19:50, Minchan Kim wrote:
>>>> On Thu, Feb 18, 2021 at 10:43:21AM +0100, David Hildenbrand wrote:
>>>>> On 18.02.21 10:35, Michal Hocko wrote:
>>>>>> On Thu 18-02-21 10:02:43, David Hildenbrand wrote:
>>>>>>> On 18.02.21 09:56, Michal Hocko wrote:
>>>>>>>> On Wed 17-02-21 08:36:03, Minchan Kim wrote:
>>>>>>>>> alloc_contig_range is usually used on cma area or movable zone.
>>>>>>>>> It's critical if the page migration fails on those areas so
>>>>>>>>> dump more debugging message like memory_hotplug unless user
>>>>>>>>> specifiy __GFP_NOWARN.
>>>>>>>>
>>>>>>>> I agree with David that this has a potential to generate a lot of output
>>>>>>>> and it is not really clear whether it is worth it. Page isolation code
>>>>>>>> already has REPORT_FAILURE mode which currently used only for the memory
>>>>>>>> hotplug because this was just too noisy from the CMA path - d381c54760dc
>>>>>>>> ("mm: only report isolation failures when offlining memory").
>>>>>>>>
>>>>>>>> Maybe migration failures are less likely to fail but still.
>>>>>>>
>>>>>>> Side note: I really dislike that uncontrolled error reporting on memory
>>>>>>> offlining path we have enabled as default. Yeah, it might be useful for
>>>>>>> ZONE_MOVABLE in some cases, but otherwise it's just noise.
>>>>>>>
>>>>>>> Just do a "sudo stress-ng --memhotplug 1" and see the log getting flooded
>>>>>>
>>>>>> Anyway we can discuss this in a separate thread but I think this is not
>>>>>> a representative workload.
>>>>>
>>>>> Sure, but the essence is "this is noise", and we'll have more noise on
>>>>> alloc_contig_range() as we see these calls more frequently. There should be
>>>>> an explicit way to enable such *debug* messages.
>>>>
>>>> alloc_contig_range already has gfp_mask and it respects __GFP_NOWARN.
>>>> Why shouldn't people use it if they don't care the failure?
>>>> Semantically, it makes sense to me.
>>>
>>> Well, alloc_contig_range doesn't really have to implement all the gfp
>>> flags. This is a matter of practicality. alloc_contig_range is quite
>>> different from the page allocator because it is to be expected that it
>>> can fail the request. This is avery optimistic allocation request. That
>>> would suggest that complaining about allocation failures is rather
>>> noisy.
>>>
>>> Now I do understand that some users would like to see why those
>>> allocations have failed. The question is whether that information is
>>> generally useful or it is more of a debugging aid. The amount of
>>> information is also an important aspect. It would be rather unfortunate
>>> to dump thousands of pages just because they cannot be migrated.
>>>
>>> I do not have a strong opinion here. We can make all alloc_contig_range
>>> users use GFP_NOWARN by default and only skip the flag from the cma
>>> allocator but I am slowly leaning towards (ab)using dynamic debugging
>>> infrastructure for this.
>>
>> Just so I understand what you are referring to - trace points?
> 
> Documentation/admin-guide/dynamic-debug-howto.rst
> but I have to confess I have 0 experience with this.

Me too, but it does sound like a good fit.

-- 
Thanks,

David / dhildenb

