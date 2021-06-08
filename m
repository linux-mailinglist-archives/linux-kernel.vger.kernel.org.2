Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D27B39F8C7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhFHOTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:19:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233178AbhFHOSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:18:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3CE260FE9;
        Tue,  8 Jun 2021 14:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623161815;
        bh=gF49svYEd54M0WQUzTD4wVKyLxtm83atdq+n9wjbLUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JTjhm3VxDHcISK0AaRrckS2Y7FKCPy6k+BgNSVfwvbDBNhsWQ8OYkZh19wPKWJiYL
         4JZDIyk/QYRlwL+kHSYmiP/+btGGzCz1rJ0xVRwO4bxI2iQ+6VfTA0Spj6QJY6a9qY
         eDApnO0knwUYGN9CLzMGGYZWZfo6bcLfv+LUlHBnIyyfUl2GRQgMFygQ7PX/JkxNDt
         nPZiYKQtT91oiRoujWDgK2HgsTmFdwnxBTjo7hiKsxJOna5ODUbfh5ezX8iiMkZ5t4
         e1wiHAd3cyQmoI2FO6nddlk5ubIdXGxXkaiQcC5XmURqxFjJ2+RN2HYFl/pCt/It13
         H9bWeYUBm0JwA==
Date:   Tue, 8 Jun 2021 17:16:47 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
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
Subject: Re: [PATCH v1] memory-hotplug.rst: complete admin-guide overhaul
Message-ID: <YL97z8DsjQfcAYBX@kernel.org>
References: <20210525102604.8770-1-david@redhat.com>
 <YK3wvMWaJaS73HXb@kernel.org>
 <385d2bd0-8857-9d40-c8f9-c302f0b56e12@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <385d2bd0-8857-9d40-c8f9-c302f0b56e12@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Tue, Jun 08, 2021 at 02:05:50PM +0200, David Hildenbrand wrote:
> Hi Mike,
> 
> thansk for the review!

...
 
> > > -Phases of memory hotplug
> > > +Further, the basic memory hot(un)plug infrastructure in Linux is nowadays
> > > +also used to expose PMEM, other performance-differentiated
> > 
> >                        ^ persistent memory (PMEM)
> > 

Just in case you've missed this one ^ ;-)

> > > +memory and reserved memory regions as ordinary system RAM to Linux.
> > > +
> > > +Phases of Memory Hotplug
> > >   ------------------------
> > > -There are 2 phases in Memory Hotplug:
> > > +Memory hotplug consists of two phases:
> > > +
> > > +(1) Adding the memory to Linux
> > > +(2) Onlining memory blocks
> > > -  1) Physical Memory Hotplug phase
> > > -  2) Logical Memory Hotplug phase.
> > > +In the first phase, metadata (such as the memmap) is allocated, page tables
> > > +for the direct mapping are allocated and initialized, and memory blocks
> > 
> > User/administrator should not care about memmap or direct map and these
> > details are better suited for Documentation/vm but since we don't have it
> > how about:
> > 
> > ... metadata, such as the memory map and page tables for the direct map,
> > are allocated and initialized, ...
> 
> Admins will have to know/care about the "memmap" terminology, because we now
> have features that use that name (for example, "memmap_on_memory")

I should have split my comment in two, first would be that admins do not
care about what exact metadata is there and this would have been more
relevant to Documentationvm/vm/memory-hotplug.rst if we had one. And the
second comment would be that I prefer to have things like memmap, pmem etc
fully spelled out even if the short versions are common and understandable.
 
> So I'll tweak it to
> 
> ".. metadata, such as the memory map ("memmap") and page tables for the
> direct map,
> are allocated and initialized, ..."
 
Works for me.
 
...

> > > +increases memory offlining reliability; still, memory offlining can fail in
> > > +some corner cases.
> > > -	% echo start_address_of_new_memory > /sys/devices/system/memory/probe
> > > +Further, memory offlining might retry for a long time (or even forever),
> > > +until aborted by the user.
> > > -Then, [start_address_of_new_memory, start_address_of_new_memory +
> > > -memory_block_size] memory range is hot-added. In this case, hotplug script is
> > > -not called (in current implementation). You'll have to online memory by
> > > -yourself.  Please see :ref:`memory_hotplug_how_to_online_memory`.
> > > +Offlining of a memory block can be triggered via::
> > > -Logical Memory hot-add phase
> > > -============================
> > > +	% echo offline > /sys/devices/system/memory/memoryXXX/state
> > > -State of memory
> > > ----------------
> > > +Or alternatively::
> > > -To see (online/offline) state of a memory block, read 'state' file::
> > > +	% echo 0 > /sys/devices/system/memory/memoryXXX/online
> > > -	% cat /sys/device/system/memory/memoryXXX/state
> > > +If offline succeeds, the state of the memory block is changed to be "offline".
> > > +If it fails, an error will be returned by the kernel.
> > 
> > I think elaborating here how the error is returned would be nice.
> 
> I *think* it's returned via the system call that tries modifying the file.
> 
> "If it fails, an error will be returned by the kernel via the systemcall
> that triggered modifying of the respective file."

I also think that write(2) to /sys/devices/system/memory/memoryXXX/online
will fail.  But the inner workings of system call, its return value and the
ERRNO are probably not very interesting to a person that did

echo 0 > /sys/devices/system/memory/memoryXXX/online

Maybe something like

  If it fails, the state of the memory block will remain unchanged and the
  above command will fail.

And maybe an example of how echo reports some unrelated error message :) 

> > > +Observing the State of Memory Blocks

...

> > > -Now, a boot option for making a memory block which consists of migratable pages
> > > -is supported. By specifying "kernelcore=" or "movablecore=" boot option, you can
> > > -create ZONE_MOVABLE...a zone which is just used for movable pages.
> > > -(See also Documentation/admin-guide/kernel-parameters.rst)
> > > +		    For online memory blocks, ``DMA``, ``DMA32``, ``Normal``,
> > > +		    ``Movable`` and ``none`` may be returned. ``none`` indicates
> > 
> > Highmem? Or we don't support hotplug on 32 bits?
> 
> We only support 64 bit:
> 
> config MEMORY_HOTPLUG
> 	...
> 	depends on 64BIT || BROKEN
> 
> Worth a comment in the document "Introduction":
> 
> "Linux only supports memory hot(un)plug on selected 64 bit architectures,
> such as x86_64, aarch64, ppc64, s390x and ia64."
 
                 ^ arm64 ?

> I can spot that sh also enables it -- but I never even tested it or saw any
> BUG reports related to it, so I'll not mention it for now explicitly in the
> document.

Agree.

-- 
Sincerely yours,
Mike.
