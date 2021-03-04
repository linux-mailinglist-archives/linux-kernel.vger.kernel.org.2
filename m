Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C4032D778
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbhCDQMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:12:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57400 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236637AbhCDQMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614874258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8oTjiNPaY+OfH4RzRyWMgpu72Kq3Bwxz+uMRr1vbiFg=;
        b=eflWuj3+gyc2qqd2CXTm5baRGDGInoT8Mr6Dr2yf91OPUnoMP10KgtizyJPgF6HZ6dDkOn
        RxgLxG9Ni5KheDgakIBkbAwgDlh8O5CmVrzVXZc5uf+NSVDDU/M/3Nj8kamm9aU9mPJqzO
        /D8PKOKrEvcUuuMrhtnQCyQyK1melPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-rYGw-I6KM4K-1mNpfL3Dmw-1; Thu, 04 Mar 2021 11:10:56 -0500
X-MC-Unique: rYGw-I6KM4K-1mNpfL3Dmw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F077C57;
        Thu,  4 Mar 2021 16:10:54 +0000 (UTC)
Received: from [10.36.113.171] (ovpn-113-171.ams2.redhat.com [10.36.113.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C63619C48;
        Thu,  4 Mar 2021 16:10:53 +0000 (UTC)
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
To:     Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com
References: <20210217163603.429062-1-minchan@kernel.org>
 <YC4rsr9zkNAvdL4T@dhcp22.suse.cz>
 <2f167b3c-5f0a-444a-c627-49181fc8fe0d@redhat.com>
 <YC402s1vqvC4q041@dhcp22.suse.cz>
 <fa8195f9-4d1b-7a77-1a02-d69710f4208b@redhat.com>
 <YC6TpqT26dSy11fU@google.com> <YC+ErI8KIJV4Wd7u@dhcp22.suse.cz>
 <YD50pcPuwV456vwm@google.com> <YEEES/K8cNi8qOJe@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <d83a03dd-fdff-ed62-a2ad-77b25d8249f0@redhat.com>
Date:   Thu, 4 Mar 2021 17:10:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEEES/K8cNi8qOJe@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.21 17:01, Minchan Kim wrote:
> On Tue, Mar 02, 2021 at 09:23:49AM -0800, Minchan Kim wrote:
>> On Fri, Feb 19, 2021 at 10:28:12AM +0100, Michal Hocko wrote:
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
>>
>> Sorry for the late response.
>>
>>>
>>> Well, alloc_contig_range doesn't really have to implement all the gfp
>>> flags. This is a matter of practicality. alloc_contig_range is quite
>>> different from the page allocator because it is to be expected that it
>>> can fail the request. This is avery optimistic allocation request. That
>>> would suggest that complaining about allocation failures is rather
>>> noisy.
>>
>> That was why I'd like to approach for per-call site indicator with
>> __GFP_NOWARN. Even though it was allocation from CMA, some of them
>> wouldn't be critical for the failure so those wouldn't care of
>> the failure. cma_alloc already has carried on "bool no_warn"
>> which was changed into gfp_t recently. What alloc_contig_range
>> should do is to take care of the request.
>>
>>>
>>> Now I do understand that some users would like to see why those
>>> allocations have failed. The question is whether that information is
>>> generally useful or it is more of a debugging aid. The amount of
>>> information is also an important aspect. It would be rather unfortunate
>>> to dump thousands of pages just because they cannot be migrated.
>>
>> Totally, agree dumping thounds of pages as debugging aid are bad.
>> Couldn't we simply ratelimit them like other places?
>>
>>>
>>> I do not have a strong opinion here. We can make all alloc_contig_range
>>> users use GFP_NOWARN by default and only skip the flag from the cma
>>> allocator but I am slowly leaning towards (ab)using dynamic debugging
>>
>> I agree the rest of the places are GFP_NOWARN by default except CMA
>> if they expect alloc_contig_range are optimistic allocation request.
>> However, I'd like to tweak it for CMA - accept gfp_t from cma_alloc
>> and take care of the __GFP_NOWARN since some sites of CMA could be
>> fault tolerant so no need to get the warning.
> 
> Any thought to proceed?

IMHO, add some proper debug mechanisms and don't try squeezing debug 
messages into "WARN" semantics.

Any alloc_contig_range() user can benefit from that.

-- 
Thanks,

David / dhildenb

