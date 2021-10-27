Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B736C43C3A0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240384AbhJ0HSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 03:18:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43773 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231203AbhJ0HSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635318940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vh20uhPE29DGhh1j6gWUyV6ou+awoh0PfjpAQqQ+7uY=;
        b=W2c17gvOTz2VrBAx1LY7sKa9Fr+YNl/tS7jU+aXXWYStXT85Fw/2NWqjJUy64XqpsI5ZvG
        bFaeA7gQoa3rn2csUAR8x033h6HWVRXuO2ttRGSv5aEXcsTT/WxHnAEoULViUY1gOaK14l
        g7JSh6K++82NhQKgX8X84q11wmvX8k8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-msJfAkhOMP-V0WNfsRBIaQ-1; Wed, 27 Oct 2021 03:15:38 -0400
X-MC-Unique: msJfAkhOMP-V0WNfsRBIaQ-1
Received: by mail-wm1-f72.google.com with SMTP id o22-20020a1c7516000000b0030d6f9c7f5fso866050wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 00:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Vh20uhPE29DGhh1j6gWUyV6ou+awoh0PfjpAQqQ+7uY=;
        b=nh/4NSJ5Ht/OO198pLYEjeF3a71IxDkym5y9Lm/F2acQk2X0uMX21+F6TFKziH8+J4
         uUG7GqxpDVdwnqRJBpCfeFi0ObmtBy0kTfimcrXqEdwICABIoAmdMuZAcgKKjhPKpudI
         GPtgzwtgRa36oNopWKCEOJYvsFHpwZsDJ65Pd8UhXQTFmGB56LW1JV+vF1RDsJUoDL3i
         e3oIdBXzorjpkO6d3rFk1YWWqnLYj4mffPEBPDfnBmykpUjrpcYRabXOwjRwZ3YikiV3
         s8lWdxMv67v5s49HS3ZVK60CO66yMycvIOBXxN2T7jiySOgUZ2CKvMFq8D4ioCS6yBF0
         Rkzw==
X-Gm-Message-State: AOAM531TsDC8lqZ02QpS855l2+A9a4zvWEg9RCondb4Uao9WQTFY0ZD2
        tnwMaB+QVRvNB6jjp1BhK5snBR1lZMimdYIyXfNJsrGZfS/OohCX8uMhvTJcTBCF29S2Sk9Qh9E
        DuU8NcQxyFy4nuboMvnNChuD1
X-Received: by 2002:a05:6000:2c7:: with SMTP id o7mr29471933wry.95.1635318937350;
        Wed, 27 Oct 2021 00:15:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznZvp77gBBcxv93V3obOyC558qd/Xvo19RDEgI1SmBqRTcw1j72Qn8OGv/YD42ghFdv+fN9g==
X-Received: by 2002:a05:6000:2c7:: with SMTP id o7mr29471900wry.95.1635318937026;
        Wed, 27 Oct 2021 00:15:37 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23d76.dip0.t-ipconnect.de. [79.242.61.118])
        by smtp.gmail.com with ESMTPSA id g10sm3089353wmq.13.2021.10.27.00.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 00:15:36 -0700 (PDT)
Message-ID: <c7b8e28d-cca0-93c7-c1cb-5a9b07e2332d@redhat.com>
Date:   Wed, 27 Oct 2021 09:15:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v1] mm, pagemap: expose hwpoison entry
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Bin Wang <wangbin224@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
References: <20211004115001.1544259-1-naoya.horiguchi@linux.dev>
 <258d0ddb-6c82-0c95-a15e-b085b59d2142@redhat.com>
 <20211004143228.GA1545442@u2004> <20211026232736.GA2704541@u2004>
 <YXi0v9DHCl+aiogP@xz-m1.local> <20211027064513.GA2717516@u2004>
 <YXj5mTFBnuJS3tvT@xz-m1.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YXj5mTFBnuJS3tvT@xz-m1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.10.21 09:02, Peter Xu wrote:
> On Wed, Oct 27, 2021 at 03:45:13PM +0900, Naoya Horiguchi wrote:
>> On Wed, Oct 27, 2021 at 10:09:03AM +0800, Peter Xu wrote:
>>> On Wed, Oct 27, 2021 at 08:27:36AM +0900, Naoya Horiguchi wrote:
>>>> On Mon, Oct 04, 2021 at 11:32:28PM +0900, Naoya Horiguchi wrote:
>>>>> On Mon, Oct 04, 2021 at 01:55:30PM +0200, David Hildenbrand wrote:
>>>>>> On 04.10.21 13:50, Naoya Horiguchi wrote:
>>>> ...
>>>>>>>
>>>>>>> Hwpoison entry for hugepage is also exposed by this patch. The below
>>>>>>> example shows how pagemap is visible in the case where a memory error
>>>>>>> hit a hugepage mapped to a process.
>>>>>>>
>>>>>>>      $ ./page-types --no-summary --pid $PID --raw --list --addr 0x700000000+0x400
>>>>>>>      voffset offset  len     flags
>>>>>>>      700000000       12fa00  1       ___U_______Ma__H_G_________________f_______1
>>>>>>>      700000001       12fa01  1ff     ___________Ma___TG_________________f_______1
>>>>>>>      700000200       12f800  1       __________B________X_______________f______w_
>>>>>>>      700000201       12f801  1       ___________________X_______________f______w_   // memory failure hit this page
>>>>>>>      700000202       12f802  1fe     __________B________X_______________f______w_
>>>>>>>
>>>>>>> The entries with both of "X" flag (hwpoison flag) and "w" flag (swap
>>>>>>> flag) are considered as hwpoison entries.  So all pages in 2MB range
>>>>>>> are inaccessible from the process.  We can get actual error location
>>>>>>> by page-types in physical address mode.
>>>>>>>
>>>>>>>      $ ./page-types --no-summary --addr 0x12f800+0x200 --raw --list
>>>>>>>      offset  len     flags
>>>>>>>      12f800  1       __________B_________________________________
>>>>>>>      12f801  1       ___________________X________________________
>>>>>>>      12f802  1fe     __________B_________________________________
>>>>>>>
>>>>>>> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>>>>>> ---
>>>>>>>   fs/proc/task_mmu.c      | 41 ++++++++++++++++++++++++++++++++---------
>>>>>>>   include/linux/swapops.h | 13 +++++++++++++
>>>>>>>   tools/vm/page-types.c   |  7 ++++++-
>>>>>>>   3 files changed, 51 insertions(+), 10 deletions(-)
>>>>>>
>>>>>>
>>>>>> Please also update the documentation located at
>>>>>>
>>>>>> Documentation/admin-guide/mm/pagemap.rst
>>>>>
>>>>> I will do this in the next post.
>>>>
>>>> Reading the document, I found that swap type is already exported so we
>>>> could identify hwpoison entry with it (without new PM_HWPOISON bit).
>>>> One problem is that the format of swap types (like SWP_HWPOISON) depends
>>>> on a few config macros like CONFIG_DEVICE_PRIVATE and CONFIG_MIGRATION,
>>>> so we also need to export how the swap type field is interpreted.
>>>
>>> I had similar question before.. though it was more on the generic swap entries
>>> not the special ones yet.
>>>
>>> The thing is I don't know how the userspace could interpret normal swap device
>>> indexes out of reading pagemap, say if we have two swap devices with "swapon
>>> -s" then I've no idea how do we know which device has which swap type index
>>> allocated.  That seems to be a similar question asked above on special swap
>>> types - the interface seems to be incomplete, if not unused at all.
>>>
>>> AFAIU the information on "this page is swapped out to device X on offset Y" is
>>> not reliable too, because the pagein/pageout from kernel is transparent to the
>>> userspace and not under control of userspace at all.  IOW, if the user reads
>>> that swap entry, then reads data upon the disk of that offset out and put it
>>> somewhere else, then it means the data read could already be old if kernel
>>> paged in the page after userspace reading the pagemap but before it reading the
>>> disk, and I don't see any way to make it right unless the userspace could stop
>>> the kernel from page-in a swap entry.  That's why I really wonder whether we
>>> should expose normal swap entry at all, as I don't know how it could be helpful
>>> and used in the 100% right way.
>>
>> Thank you for the feedback.
>>
>> I think that a process interested in controlling swap-in/out behavior in its own
>> typically calls mincore() to get current status and madvise() to trigger swap-in/out.
>> That's not 100% solution for the same reason, but it mostly works well because
>> calling madvise(MADV_PAGEOUT) to already swapped out is not a big issue (although
>> some CPU/memory resource is wasted, but the amount of the waste is small if the
>> returned info is new enough). 
>> So my point is that the concern around information newness might be more generic
>> issue rather than just for pagemap.  If we need 100% accurate in-kernel info,
>> maybe it had better be done in kernel (or some cooler stuff like eBPF)?
> 
> I fully agree the solution you mentioned with mincore() and madvise(), that is
> very sane and working approach.  Though IMHO the major thing I wanted to point
> out is for generic swap devices we exposed (disk_index, disk_offset) tuple as
> the swap entry (besides "whether this page is swapped out or not"; that's
> PM_SWAP, and as you mentioned people'll need to rely on mincore() to make it
> right for shmem), though to use it we need to either record the index/offset or
> read/write data from it.  However none of them will make sense, IMHO..  So I
> think exposing PM_SWAP makes sense, not the swap entries on swap devices.
> 
>>
>>>
>>> Special swap entries seem a bit different - at least for is_pfn_swap_entry()
>>> typed swap entries we can still expose the PFN which might be helpful, which I
>>> can't tell.
>>
>> I'm one who think it helpful for testing, although I know testing might not be
>> considered as a real usecase.
> 
> I think testing is valid use case too.
> 
>>
>>>
>>> I used to send an email to Matt Mackall <mpm@selenic.com> and Dave Hansen
>>> <dave.hansen@linux.intel.com> asking about above but didn't get a reply. Ccing
>>> again this time with the list copied.
>>>
>>>>
>>>> I thought of adding new interfaces for example under /sys/kernel/mm/swap/type_format/,
>>>> which shows info like below (assuming that all CONFIG_{DEVICE_PRIVATE,MIGRATION,MEMORY_FAILURE}
>>>> is enabled):
>>>>
>>>>   $ ls /sys/kernel/mm/swap/type_format/
>>>>   hwpoison
>>>>   migration_read
>>>>   migration_write
>>>>   device_write
>>>>   device_read
>>>>   device_exclusive_write
>>>>   device_exclusive_read
>>>>   
>>>>   $ cat /sys/kernel/mm/swap/type_format/hwpoison
>>>>   25
>>>>   
>>>>   $ cat /sys/kernel/mm/swap/type_format/device_write
>>>>   28
>>>>
>>>> Does it make sense or any better approach?
>>>
>>> Then I'm wondering whether we care about the rest of the normal swap devices
>>> too with pagemap so do we need to expose some information there too (only if
>>> there's a real use case, though..)?  Or... should we just don't expose swap
>>> entries at all, at least generic swap entries?  We can still expose things like
>>> hwpoison via PM_* bits well defined in that case.
>>
>> I didn't think about normal swap devices for no reason. I'm OK to stop exposing
>> normal swap device part.  I don't have strong option yet about which approach
>> (in swaptype or PM_HWPOISON) I'll suggest next (so wait a little more for feedback).
> 
> No strong opinion here too. It's just that the new interface proposed reminded
> me that it's partially complete if considering we're also exposing swap entries
> on swap devices, so the types didn't cover those entries.  However it's more
> like a pure question because I never figured out how those entries will work
> anyway.  I'd be willing to know whether Dave Hanson would comment on this.
> 
> While the PM_HWPOISON approach looks always sane to me.

I consider that somehow cleaner, because how HWPOISON entries are
implemented ("fake swap entries") is somewhat an internal implementation
detail.

(I also agree that PM_SWAP makes sense, but maybe really only when we're
actually dealing with something that has been/is currently being swapped
out. Maybe we should just not expose fake swap entries via PM_SWAP and
instead use proper PM_ types for that. PM_MIGRATION, PM_HWPOISON, ...)

-- 
Thanks,

David / dhildenb

