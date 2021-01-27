Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0AA306728
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 23:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbhA0WU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 17:20:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34559 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237124AbhA0WUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 17:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611785924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hx9096HPPsPhXkrrcDROGk4X/WPgwTssCeeC5wT/1PA=;
        b=HAvqIObYTxKqj8znwBw2kLFaobu6F0dq0tJZumUcV9lE8TuUh23u6+Yf1ueqvBYkQx8v5O
        i1a30LdN5YirKLjdVY8OhFT5xWAyuWdBxBibmEMy8zCEVxNwDr97FBlelh+FxeAermUy6m
        8aHt7NO5eCTu4XYb2sy4p5doqRB7Fxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-AbPvc2SQO3yX6qdi9zpyog-1; Wed, 27 Jan 2021 17:18:42 -0500
X-MC-Unique: AbPvc2SQO3yX6qdi9zpyog-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D498010054FF;
        Wed, 27 Jan 2021 22:18:39 +0000 (UTC)
Received: from [10.36.112.48] (ovpn-112-48.ams2.redhat.com [10.36.112.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66DEB1F0;
        Wed, 27 Jan 2021 22:18:35 +0000 (UTC)
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>,
        James Morris <jmorris@namei.org>
References: <CA+CK2bBJKntMP36SzLGvGFp4=sww6Z2LBhqEZm60kGWRWjQMVw@mail.gmail.com>
 <8c2b75fe-a3e5-8eff-7f37-5d23c7ad9742@redhat.com>
 <CA+CK2bDW7Pzj=0WQnPpO+AhvZP9Y9JivJs+6G4wrbuwZfrgyKQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: dax alignment problem on arm64 (and other achitectures)
Message-ID: <94797c92-cd90-8a65-b879-0bb5f12b9fc5@redhat.com>
Date:   Wed, 27 Jan 2021 23:18:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CA+CK2bDW7Pzj=0WQnPpO+AhvZP9Y9JivJs+6G4wrbuwZfrgyKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Ordinary reboots or kexec-style reboots? I assume the latter, because
>> otherwise there is no guarantee about persistence, right?
> 
> Both, our firmware supports cold and warm reboot. When we do warm
> reboot, memory content is not initialized. However, for performance
> reasons, we mostly do kexec reboots.
> 

One issue usually is that often firmware can allocate from available 
system RAM and/or modify/initialize it. I assume you're running some 
custom firmware :)

>>
>> I remember for kexec-style reboots there is a different approach (using
>> tmpfs) on the list.
> 
> Right, we are using a similar approach to that tmpfs, but that tmpfs
> approach was never upstreamed.

I assume that people will follow up on that, because it's getting used 
for fast hypervisor reboots by some companies IIRC.

> 
>>
>>> hotplug that memory back, so we do not lose 2G of system memory
>>> (machine is small, only 8G of RAM total).
>>>
>>> In order to hotplug pmem memory it first must be converted to devdax.
>>> Devdax has a label 2M in size that is placed at the beginning of the
>>> pmem device memory which brings the problem.
>>>
>>> The section size is a hotplugging unit on Linux. Whatever gets
>>> hot-plugged or hot-removed must be section size aligned. On x86
>>> section size is 128M on arm64 it is 1G (because arm64 supports 64K
>>> pages, and 128M does not work with 64K pages). Because the first 2M
>>
>> Note that it's soon 128M with 4k and 16k base pages and 512MB with 64k.
>> The arm64 patch for that is already queued.
> 
> This is great. Do you have a pointer to that series? It means we can
> get rid of our special section size workaround patch, and use the 128M
> section size for 4K pages. However, we still can't move to 64K because
> losing 510M is too much.
> 

Sure

https://lkml.kernel.org/r/cover.1611206601.git.sudaraja@codeaurora.org

Personally, I think the future is 4k, especially for smaller machines. 
(also, imagine right now how many 512MB THP you can actually use in your 
8GB VM ..., simply not suitable for small machines).

>>
>>> are subtracted from the pmem device to create devdax, that actual
>>> hot-pluggable memory is not 1G/128M aligned, and instead we lose 126M
>>> on x86 or 1022M on arm64 of memory that is getting hot-plugged, the
>>> whole first section is skipped when memory gets hot plugged because of
>>> 2M label.
>>>
>>> As a  workaround, so we do not lose 1022M out of 8G of memory on arm64
>>> we have section size reduced to 128M. We are using this patch [1].
>>> This way we are losing 126M (which I still hate!)
>>>
>>> I would like to get rid of this workaround. First, because I would
>>> like us to switch to 64K pages to gain performance, and second so we
>>> do not depend on an unofficial patch which already has given us some
>>> headache with kdump support.
>>
>> I'd want to see 128M sections on arm64 with 64k base pages. "How?" you
>> might ask. One idea would be to switch from 512M THP to 2MB THP (using
>> cont pages), and instead implement 512MB gigantic pages. Then we can
>> reduce pageblock_order / MAX_ORDER - 1 and no longer have the section
>> limitations. Stuff for the future, though (if even ever).
> 
> Interesting, but this is not something that would address the
> immediate issue. Because, even losing 126M is something I would like
> to fix. However, what other benefits reducing section size on arm64
> would bring? Do we have requirement where reducing section size is
> actually needed?

E.g., Memory hot(un)plug granularity/flexibility (DIMMs, virtio-mem in 
the future) and handling large memory holes in a better way (e.g., 
avoiding custom pfn_valid(), not wasting memmap for memory holes).

Reducing pageblock_order / MAX_ORDER - 1 will have other benefits as well.

> 
>>
>>>
>>> Here are some solutions that I think we can do:
>>>
>>> 1. Instead of carving the memory at 1G aligned address, do it at 1G -
>>> 2M address, this way when devdax is created it is perfectly 1G
>>> aligned. On ARM64 it causes a panic because there is a 2M hole in
>>> memory. Even if panic is fixed, I do not think this is a proper fix.
>>> This is simply a workaround to the underlying problem.
>>
>> I remember arm64 already has to deal with all different kinds of memory
>> holes (including huge ones). I don't think this should be a fundamental
>> issue.
> 
> Perhaps not. I can root cause, and report here what actually happens.
> 

Might be related to the broken custom pfn_valid() implementation for 
ZONE_DEVICE.

https://lkml.kernel.org/r/1608621144-4001-1-git-send-email-anshuman.khandual@arm.com

And essentially ignoring sub-section data in there for now as well (but 
might not be that relevant yet). In addition, this might also be related to

https://lkml.kernel.org/r/161058499000.1840162.702316708443239771.stgit@dwillia2-desk3.amr.corp.intel.com

>>
>> I think it might be a reasonable thing to do for such a special use
>> case. Does it work on x86-64?
> 
> It does.

So eventually related to custom pfn_valid() + pfn_to_online_page().

[...]

>>> 3. Allow to hot plug daxdev together with the label, but teach the
>>> kernel not to touch label (i.e. allocate its memory). IMO, kind of
>>> ugly solution, because when devdax is hot-plugged it is not even aware
>>> of label size. But, perhaps that can be changed.
>>
>> I mean, we could teach add_memory() to "skip the first X pages" when
>> onlining/offlining, not exposing them to the buddy. Something similar we
>> already do with Oscars vmemmap-on-memory series.
>>
>> But I guess the issue is that the memmap for the label etc. is already
>> allocated? Is the label memremapped ZONE_DEVICE memory or what is it? Is
>> the label exposed in the resource tree?
> 
> It is exposed:
> 
> # ndctl create-namespace --mode raw -e namespace0.0 -f
> {
>    "dev":"namespace0.0",
>    "mode":"raw",
>    "size":"2.00 GiB (2.15 GB)",
>    "sector_size":512,
>    "blockdev":"pmem0"
> }
> 
> The raw device is exactly 2G
> 
> # cat /proc/iomem | grep 'dax\|namespace'
> 980000000-9ffffffff : namespace0.0
> 
> namespace0.0 is 2G, and there is dax0.0.
> 
> Create devdax device:
> # ndctl create-namespace --mode devdax --map mem -e namespace0.0 -f
> {
>    "dev":"namespace0.0",
>    "mode":"devdax",
>    "map":"mem",
>    "size":"2046.00 MiB (2145.39 MB)",
>    "uuid":"ed4d6a34-6a11-4ced-8a4f-b2487bddf5d7",
>    "daxregion":{
>      "id":0,
>      "size":"2046.00 MiB (2145.39 MB)",
>      "align":2097152,
>      "devices":[
>        {
>          "chardev":"dax0.0",
>          "size":"2046.00 MiB (2145.39 MB)",
>          "mode":"devdax"
>        }
>      ]
>    },
>    "align":2097152
> }
> 
> Now, the device is 2046M in size instead of 2G.
> 
> root@dplat-cp22:/# cat /proc/iomem | grep 'namespace\|dax'
> 980000000-9801fffff : namespace0.0
> 980200000-9ffffffff : dax0.0
> 
> We can see the namespace0.0 is 2M, which is label, and dax0.0 is 2046M.

Thanks, now I recall seeing this when playing with dax/kmem :)

Okay, so add_memory()/remove_memory() would have to deal with starting 
with an offset of sub-sections within a section --- whereby all 
remaining part of the section is either ZONE_DEVICE memory or not 
existent (reading: not system RAM). Then we can just create/remove the 
memory block devices and everything will be fine. In addition 
online_pages()/offline_pages() would have to be tweaked to skip over the 
first X pages.

Not impossible, but I'd like to avoid such hacks if there are better 
alternatives (especially, the trick in 1. sounds appealing to me; but 
also trying to avoid the label sounds interesting).

>>
>> In case "it's just untouched/unexposed memory", it's fairly simple. In
>> case the label is exposed as ZONE_DEVICE already, it's more of an issue
>> and might require further tweaks.
>>
>>>
>>> 4. Other ideas? (move dax label to the end? a special case without a
>>> label? label outside of data?)
>>
>> What does the label include in your example? Sorry, I have no idea about
>> devdax labels.
>>
>> I read "ndctl-create-namespace" - "--no-autolabel: Manage labels for
>> legacy NVDIMMs that do not support labels". So I assume there is at
>> least some theoretical way to not have a label on the memory?
> 
> Right, but I do not think it is possible to do for dax devices (as of
> right now). I assume, it contains information about what kind of
> device it is: devdax, fsdax, sector, uuid etc.
> See [1] namespaces tabel. It contains summary of pmem devices types,
> and which of them have label (all except for raw).

Interesting, I wonder if the label is really required to get this 
special use case running. I mean, all you want is to have dax/kmem 
expose the whole thing as system RAM. You don't want to lose even 2MB if 
it's just for the sake of unnecessary metadata - this is not a real 
device, it's "fake" already.

-- 
Thanks,

David / dhildenb

