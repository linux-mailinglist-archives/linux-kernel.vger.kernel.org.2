Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CF539F602
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhFHMHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 08:07:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29589 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232458AbhFHMHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623153955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9+RQlAmP9Mglt7tSiLtL0tPiVcWxKY+yT42LYj+NpJ4=;
        b=EP0iyIsMqliUjrXU0j6mSHQ4t2Y/JlFNMGlVuUvijWJheXVnRu33m3QTiVWXOUsKOhQXlJ
        o0t/9afwZzdRmnKnGInzQMvG3ZNh9XApcVhvUiKVpr6NxE6j++HrevAd/FuKjT/cjdu9z6
        4P0jmTaPM1bjmMfK2WWOB7Xq5qOAjmM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-Uysd82stONCz9Y6IwWtOFw-1; Tue, 08 Jun 2021 08:05:54 -0400
X-MC-Unique: Uysd82stONCz9Y6IwWtOFw-1
Received: by mail-wm1-f71.google.com with SMTP id a25-20020a7bc1d90000b029019dd2ac7025so675221wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 05:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9+RQlAmP9Mglt7tSiLtL0tPiVcWxKY+yT42LYj+NpJ4=;
        b=VzPBioVtv4yG20wbr6FKMWwvva9ptN8YUU6DllU88uPeE0Pq2Bb93C2GQxdXbx13C0
         8MLrcp1AwZJOub35wgfC2GJ9Ytt4hgT4wzqU91Ffw1KeIkc3r+y2sqs1FxJ0T4JPG6nv
         hgDWMC3mfenUT1Ab2ainzNCs+lzoAXeQ22p/h5VIrrHgzoDsDb/2tJDupQabmeBAuCqS
         FTxD48J+sXRMY0jG7uyiucaGGUKXH4VVrjUD9EKg4TZDvAeJeYHpDa+gM5ULCbopTDqK
         uhSiv/Q3KDY23heyfRtVY0+t3mVWOzorWuk7DLGB5qRfqj+uPa8l8TtSul7EKxhEzvZh
         W2Ag==
X-Gm-Message-State: AOAM5311H+YIIBND7WFyL3xsAuvT2am6aisUNDOV/1ritTd5zcyox4WJ
        ZUykS8xIlZv+QZgvtsIS/mHlS9OZVBSc73a4KQ3zcC74DzOKamo2S8zQL3GVN64TsFbOyDWL8Uy
        VjWItuVipmXvMdpoZWdGMdBkR
X-Received: by 2002:a1c:4c17:: with SMTP id z23mr2305902wmf.164.1623153952275;
        Tue, 08 Jun 2021 05:05:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMPnm1yT1NdRqySW6KZPnKQJHTyFOttKRjVRJAbTL3gzSPg3xdiCwGGR1i5QFW8azK9DHU7A==
X-Received: by 2002:a1c:4c17:: with SMTP id z23mr2305835wmf.164.1623153951689;
        Tue, 08 Jun 2021 05:05:51 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c61cf.dip0.t-ipconnect.de. [91.12.97.207])
        by smtp.gmail.com with ESMTPSA id f12sm4755563wru.81.2021.06.08.05.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 05:05:51 -0700 (PDT)
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-doc@vger.kernel.org
References: <20210525102604.8770-1-david@redhat.com>
 <YK3wvMWaJaS73HXb@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1] memory-hotplug.rst: complete admin-guide overhaul
Message-ID: <385d2bd0-8857-9d40-c8f9-c302f0b56e12@redhat.com>
Date:   Tue, 8 Jun 2021 14:05:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YK3wvMWaJaS73HXb@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

thansk for the review!

>>   
>>   :Created:							Jul 28 2007
>>   :Updated: Add some details about locking internals:		Aug 20 2018
>> +:Updated: Complete overhaul:					May 18 2021
> 
> I'd drop all three, we have git log...

Agreed.

> 
>>   
>> -This document is about memory hotplug including how-to-use and current status.
>> -Because Memory Hotplug is still under development, contents of this text will
>> -be changed often.
>> +This document describes generic Linux support for memory hot(un)plug with
>> +a focus on System RAM, including ZONE_MOVABLE support.
>>   
>>   .. contents:: :local:
>>   
>> -.. note::
>> -
>> -    (1) x86_64's has special implementation for memory hotplug.
>> -        This text does not describe it.
>> -    (2) This text assumes that sysfs is mounted at ``/sys``.
>> -
>> -
>>   Introduction
>>   ============
>>   
>> -Purpose of memory hotplug
>> --------------------------
>> +Memory hot(un)plug allows for increasing and decreasing the physical memory
> 
> Maybe:					          the size of physical memory
> 

Agreed.

>> +available to a machine at runtime. In the simplest case, it consists of
>> +physically plugging or unplugging a DIMM at runtime, coordinated with the
>> +operating system.
>>   
>> -Memory Hotplug allows users to increase/decrease the amount of memory.
>> -Generally, there are two purposes.
>> +Memory hot(un)plug is used for various purposes:
>>   
>> -(A) For changing the amount of memory.
>> -    This is to allow a feature like capacity on demand.
>> -(B) For installing/removing DIMMs or NUMA-nodes physically.
>> -    This is to exchange DIMMs/NUMA-nodes, reduce power consumption, etc.
>> +(A) The physical memory available to a machine can be adjusted at runtime,
>> +    up- or downgrading the memory capacity. This dynamic memory
>> +    resizing, sometimes referred to as "capacity on demand", is frequently
>> +    used with virtual machines and logical partitions.
> 
> I like more the bulleted lists, so you just put * or - in the beginning of
> the line and then you don't need to know neither the alphabet nor how to
> count :)
> 
> More seriously, if the letters (or numbers) have no particular meaning it's
> easier to maintain a list with neutral bullets.

Makes sense! It doesn't really help in this case.

>    
>> -(A) is required by highly virtualized environments and (B) is required by
>> -hardware which supports memory power management.
>> +(B) Replacing hardware, such as DIMMs or whole NUMA nodes, without downtime.
>> +    One example is replacing failing memory modules.
>>   
>> -Linux memory hotplug is designed for both purpose.
>> +(C) Reducing memory consumption either by physically unplugging
>> +    memory modules or by logically unplugging (parts of) memory modules
>> +    from Linux.
> 
> It feels like some part of explanation is missing. My understanding of the
> above paragraph is "we remove a DIMM and thus the memory consumption
> drops".
> My guess is that you refer here to VM environments, in this case some more
> details would help.

It was actually supposed to be "Reducing energy consumption" -- which 
will make more sense :) Thanks for catching that!

>    
>> -Phases of memory hotplug
>> +Further, the basic memory hot(un)plug infrastructure in Linux is nowadays
>> +also used to expose PMEM, other performance-differentiated
> 
>                        ^ persistent memory (PMEM)
> 
>> +memory and reserved memory regions as ordinary system RAM to Linux.
>> +
>> +Phases of Memory Hotplug
>>   ------------------------
>>   
>> -There are 2 phases in Memory Hotplug:
>> +Memory hotplug consists of two phases:
>> +
>> +(1) Adding the memory to Linux
>> +(2) Onlining memory blocks
>>   
>> -  1) Physical Memory Hotplug phase
>> -  2) Logical Memory Hotplug phase.
>> +In the first phase, metadata (such as the memmap) is allocated, page tables
>> +for the direct mapping are allocated and initialized, and memory blocks
> 
> User/administrator should not care about memmap or direct map and these
> details are better suited for Documentation/vm but since we don't have it
> how about:
> 
> ... metadata, such as the memory map and page tables for the direct map,
> are allocated and initialized, ...

Admins will have to know/care about the "memmap" terminology, because we 
now have features that use that name (for example, "memmap_on_memory")

So I'll tweak it to

".. metadata, such as the memory map ("memmap") and page tables for the 
direct map,
are allocated and initialized, ..."

> 
>> +are created; the latter also creates sysfs files for managing
> 
> The reader doesn't know what are memory blocks in this context yet. I'd
> suggest to move "Unit of Memory Hot(Un)Plug" before the phases.

Makes sense.

[...]

>> +Unit of Memory Hot(Un)Plug
> 
>    Units?

Or rather "Memory Hot(Un)Plug Granularity"

[...]

>> -Kernel Configuration
>> -====================
>> +There are various ways how Linux is notified about memory hotplug events
>> +such that it can start adding hotplugged memory. This description is
>> +mostly limited to mechanisms present on physical machines; mechanisms specific
>> +to virtual machines or logical partitions are not described.
> 
> ... This description is limited to systems that support ACPI; mechanisms
> specific to other firmware interfaces or virtual machines are not
> described.

Ack

[...]

>> -Under each memory block, you can see 5 files:
>> +The Linux kernel can be configured to automatically online added memory
>> +blocks and drivers automatically trigger offlining of memory blocks
>> +when trying hotunplug of memory. Memory blocks can only be removed once offlining
> 
> ... and drivers may trigger offlining of memory blocks when they attempt of
> hotunplug the memory.
> 

I'll rephrase to "... when attempting hotunplug of memory".

[...]

>>
>> -.. note::
>> +One can explicitly request to associate it with ZONE_MOVABLE by::
> 
> 					s/it/added memory block/

I'll use "an offline memory block".

[...]

>>   
>> -	/sys/devices/system/memory/memory9/node0 -> ../../node/node0
>> +The kernel can be configured to try auto-onlining of newly added memory blocks.
>> +If disabled, the memory blocks will stay offline until explicitly onlined
> 
>    ^ If this feature is disabled
> 

Ack

[...]

>> -	/sys/devices/system/memory/probe
>> +In the current implementation, Linux's memory offlining will try migrating
>> +all movable pages off the affected memory block. As most kernel allocations,
>> +such as page tables, are unmovable, page migration can fail and, therefore,
>> +inhibit memory offlining from succeeding.
>>   
>> -You can tell the physical address of new memory to the kernel by::
>> +Having the memory provided by memory block managed by ZONE_MOVABLE severely
> 
>                                                              significantly ^

Indeed

> 
>> +increases memory offlining reliability; still, memory offlining can fail in
>> +some corner cases.
>>   
>> -	% echo start_address_of_new_memory > /sys/devices/system/memory/probe
>> +Further, memory offlining might retry for a long time (or even forever),
>> +until aborted by the user.
>>   
>> -Then, [start_address_of_new_memory, start_address_of_new_memory +
>> -memory_block_size] memory range is hot-added. In this case, hotplug script is
>> -not called (in current implementation). You'll have to online memory by
>> -yourself.  Please see :ref:`memory_hotplug_how_to_online_memory`.
>> +Offlining of a memory block can be triggered via::
>>   
>> -Logical Memory hot-add phase
>> -============================
>> +	% echo offline > /sys/devices/system/memory/memoryXXX/state
>>   
>> -State of memory
>> ----------------
>> +Or alternatively::
>>   
>> -To see (online/offline) state of a memory block, read 'state' file::
>> +	% echo 0 > /sys/devices/system/memory/memoryXXX/online
>>   
>> -	% cat /sys/device/system/memory/memoryXXX/state
>> +If offline succeeds, the state of the memory block is changed to be "offline".
>> +If it fails, an error will be returned by the kernel.
> 
> I think elaborating here how the error is returned would be nice.

I *think* it's returned via the system call that tries modifying the file.

"If it fails, an error will be returned by the kernel via the systemcall 
that triggered modifying of the respective file."

>    
>> +Observing the State of Memory Blocks
>> +------------------------------------
>>   
>> -- If the memory block is online, you'll read "online".
>> -- If the memory block is offline, you'll read "offline".
>> +The state (online/offline/going-offline) of a memory block can be observed
>> +either via::
>>   
>> +	% cat /sys/device/system/memory/memoryXXX/state
>>   
>> -.. _memory_hotplug_how_to_online_memory:
>> +Or alternatively (1/0) via::
>>   
>> -How to online memory
>> ---------------------
>> +	% cat /sys/device/system/memory/memoryXXX/online
>>   
>> -When the memory is hot-added, the kernel decides whether or not to "online"
>> -it according to the policy which can be read from "auto_online_blocks" file::
>> +For an online memory block, the managing zone van be observed via::
> 
>                                            typo: ^ can

Thanks

>>   
>> -	% cat /sys/devices/system/memory/auto_online_blocks
>> +	% cat /sys/device/system/memory/memoryXXX/valid_zones
>>   
>> -The default depends on the CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE kernel config
>> -option. If it is disabled the default is "offline" which means the newly added
>> -memory is not in a ready-to-use state and you have to "online" the newly added
>> -memory blocks manually. Automatic onlining can be requested by writing "online"
>> -to "auto_online_blocks" file::
>> +Configuring Memory Hot(Un)Plug
>> +==============================
>>   
>> -	% echo online > /sys/devices/system/memory/auto_online_blocks
>> +There are various ways how admins can configure memory hot(un)plug and interact
> 
>                               ^ system administrators

Ack

[...]

>> -Or you can explicitly request a kernel zone (usually ZONE_NORMAL) by::
>> +.. note::
>>   
>> -	% echo online_kernel > /sys/devices/system/memory/memoryXXX/state
>> +  With CONFIG_MEMORY_FAILURE, two additional files ``hard_offline_page`` and
> 
> When the kernel is built with CONFIG_MEMORY_FAILURE option enabled
> 
> Maybe add a subsection about the configuration options that define sysfs
> behaviour and group all the notes there as simple paragraphs?
> 

I'll move the notes for "auto_online_block" and "probe" right to the 
description. I'll leave the note for hard_offline_page and 
soft_offline_page in the (last remaining) note as they are not really 
releated to memory hot(un)plug.

[...]

>> +``uevent``	    read-write: generic uevent file for devices.
>> +``valid_zones``     read-only: shows by which zone memory provided by an
>> +		    online memory block is managed, and by which zone memory
>> +		    provided by an offline memory block could be managed when
>> +		    onlining.
> 
> Sounds a bit awkward to me. Maybe
> 
> when a block is online shows the zone it belongs to; when a block is offline
> shows what zone will manage it when the block will be onlined.
> 

Ack

>>   
>> -Now, a boot option for making a memory block which consists of migratable pages
>> -is supported. By specifying "kernelcore=" or "movablecore=" boot option, you can
>> -create ZONE_MOVABLE...a zone which is just used for movable pages.
>> -(See also Documentation/admin-guide/kernel-parameters.rst)
>> +		    For online memory blocks, ``DMA``, ``DMA32``, ``Normal``,
>> +		    ``Movable`` and ``none`` may be returned. ``none`` indicates
> 
> Highmem? Or we don't support hotplug on 32 bits?

We only support 64 bit:

config MEMORY_HOTPLUG
	...
	depends on 64BIT || BROKEN

Worth a comment in the document "Introduction":

"Linux only supports memory hot(un)plug on selected 64 bit 
architectures, such as x86_64, aarch64, ppc64, s390x and ia64."

I can spot that sh also enables it -- but I never even tested it or saw 
any BUG reports related to it, so I'll not mention it for now explicitly 
in the document.

> 
>> +		    that memory provided by a memory block is managed by
>> +		    multiple zones or spans multiple nodes; such memory blocks
>> +		    cannot be offlined. ``Movable`` indicates ZONE_MOVABLE.
>> +		    Other values indicate a kernel zone.
>>   
>> -Assume the system has "TOTAL" amount of memory at boot time, this boot option
>> -creates ZONE_MOVABLE as following.
>> +		    For offline memory blocks, the first column shows the
>> +		    zone the kernel would select when onlining the memory block
>> +		    right now without further specifying a zone.
>> +=================== ============================================================
>>   
>> -1) When kernelcore=YYYY boot option is used,
>> -   Size of memory not for movable pages (not for offline) is YYYY.
>> -   Size of memory for movable pages (for offline) is TOTAL-YYYY.
>> +.. note::
>>   
>> -2) When movablecore=ZZZZ boot option is used,
>> -   Size of memory not for movable pages (not for offline) is TOTAL - ZZZZ.
>> -   Size of memory for movable pages (for offline) is ZZZZ.
>> +  ``valid_zones`` is only available with CONFIG_MEMORY_HOTREMOVE.
>>   
>>   .. note::
>>   
>> -   Unfortunately, there is no information to show which memory block belongs
>> -   to ZONE_MOVABLE. This is TBD.
>> +  If CONFIG_NUMA is enabled the memoryXXX/ directories can also be accessed
>> +  via symbolic links located in the ``/sys/devices/system/node/node*``
>> +  directories.
>> +
>> +  For example::
>> +
>> +	/sys/devices/system/node/node0/memory9 -> ../../memory/memory9
>> +
>> +  A backlink will also be created::
>> +
>> +	/sys/devices/system/memory/memory9/node0 -> ../../node/node0
>>   
>> -   Memory offlining can fail when dissolving a free huge page on ZONE_MOVABLE
>> -   and the feature of freeing unused vmemmap pages associated with each hugetlb
>> -   page is enabled.
>> +Cmdline Parameters
> 
> Command line

Ack, will adjust all "cmdline" instances.

Hope I didn't miss any feedback, will do another pass to make sure I 
considered everything. Thanks!

-- 
Thanks,

David / dhildenb

