Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC0139DB74
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 13:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhFGLhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 07:37:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhFGLhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 07:37:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7C3D61105;
        Mon,  7 Jun 2021 11:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623065755;
        bh=UFdqDSbpojMnollIyNFkJACvzECXyAbHuHQc89tYc/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JovbKNnMZCv+bteGLlApSTLCHGz8Ju4ZZkCX22L3MVjejM8XhZUl642odGRszgm2u
         UpH+D/PEFO1iAGjLo44v/5Eq1oFIT4v2QXh+7nP1oX8/AM9acS3pwah7/KlFNcMsyk
         uvI4Nz5yXEyrM6YneAdfsTWFGFq0boLsXeds04lxMCzkakQQVxXv/WmiWd9qkqPmlJ
         rx9vr3+ZEJsKJeEo2FhMTdislxYJesT5Z2jEZMIFRoEvL3DIhzXAGuwmSwjCHYVpKu
         xiLKac5Emijn4tLfXYhwuZHnI65WRC3hYwQgCrHh1UkciZP5FXkMyO3F8VPZoImWTM
         5MDv0CqvjclCQ==
Date:   Mon, 7 Jun 2021 14:35:47 +0300
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
Message-ID: <YL4Ek6AqMUyiDrxY@kernel.org>
References: <20210525102604.8770-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525102604.8770-1-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 12:26:04PM +0200, David Hildenbrand wrote:
> The memory hot(un)plug documentation is outdated and incomplete. Most of
> the content dates back to 2007, so it's time for a major overhaul.
> 
> Let's rewrite, reorganize and update most parts of the documentation. In
> addition to memory hot(un)plug, also add some details regarding
> ZONE_MOVABLE, with memory hotunplug being one of its main consumers.
> 
> The style of the document is also properly fixed that e.g., "restview"
> renders it cleanly now.
> 
> In the future, we might add some more details about virt users like
> virtio-mem, the XEN balloon, the Hyper-V balloon and ppc64 dlpar.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> Based on linux-next, which includes hugetlb vmemmap changes to the doc
> that are not upstream yet.
> 
> ---
>  .../admin-guide/mm/memory-hotplug.rst         | 738 +++++++++++-------
>  1 file changed, 440 insertions(+), 298 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
> index c6bae2d77160..c95f5c2b30dd 100644
> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst

...

> +ZONE_MOVABLE
> +============
> +
> +ZONE_MOVABLE is an important mechanism for more reliable memory offlining.
> +Further, having system RAM managed by ZONE_MOVABLE instead of one of the
> +kernel zones can increase the number of possible transparent huge pages and
> +dynamically allocated huge pages.
> +

I'd move the first two paragraphs from "Zone Imbalances" here to provide
some context what is movable and what is unmovable allocation.

> +Only movable allocations are served from ZONE_MOVABLE, resulting in
> +unmovable allocations being limited to the kernel zones. Without ZONE_MOVABLE,
> +there is absolutely no guarantee whether a memory block can be offlined
> +successfully.
> +
> +Zone Imbalances
> +---------------
> +
> +Most kernel allocations are unmovable. Important examples include the memmap
> +(usually 1/64 of memory), page tables, and kmalloc(). Such allocations
> +can only be served from the kernel zones.
> +
> +Most user space pages, such as anonymous memory, and page cache pages
> +are movable. Such allocations can be served from ZONE_MOVABLE and the kernel
> +zones.
> +
> +Having too much system RAM managed by ZONE_MOVABLE is called a zone imbalance,
> +which can harm the system or degrade performance. As one example, the kernel
> +might crash because it runs out of free memory for unmovable allocations,
> +although there is still plenty of free memory left in ZONE_MOVABLE.
> +
> +Usually, MOVABLE:KERNEL ratios of up to 3:1 or even 4:1 are fine. Ratios of 63:1
> +are definitely impossible due to the memmap overhead.
> +
> +Actual safe zone ratios depend on the workload. Extreme cases, like excessive
> +long-term pinning of pages, might not be able to deal with ZONE_MOVABLE at all.
>  
>  .. note::
> -   Techniques that rely on long-term pinnings of memory (especially, RDMA and
> -   vfio) are fundamentally problematic with ZONE_MOVABLE and, therefore, memory
> -   hot remove. Pinned pages cannot reside on ZONE_MOVABLE, to guarantee that
> -   memory can still get hot removed - be aware that pinning can fail even if
> -   there is plenty of free memory in ZONE_MOVABLE. In addition, using
> -   ZONE_MOVABLE might make page pinning more expensive, because pages have to be
> -   migrated off that zone first.
>  
> -.. _memory_hotplug_how_to_offline_memory:
> +  CMA memory part of a kernel zone essentially behaves like memory in
> +  ZONE_MOVABLE and similar considerations apply, especially when combining
> +  CMA with ZONE_MOVABLE.
>  
> -How to offline memory
> ----------------------
> +Considerations

ZONE_MOVABLE Sizing Considerations ?

I'd also move the contents of "Boot Memory and ZONE_MOVABLE" here (with
some adjustments):

  By default, all the memory configured at boot time is managed by the kernel
  zones and ZONE_MOVABLE is not used.

  To enable ZONE_MOVABLE to include the memory present at boot and to
  control the ratio between movable and kernel zones there are two command
  line options: ``kernelcore=`` and ``movablecore=``. See
  Documentation/admin-guide/kernel-parameters.rst for their description.

> +--------------
>  
> -You can offline a memory block by using the same sysfs interface that was used
> -in memory onlining::
> +We usually expect that a large portion of available system RAM will actually
> +be consumed by user space, either directly or indirectly via the page cache. In
> +the normal case, ZONE_MOVABLE can be used when allocating such pages just fine.
>  
> -	% echo offline > /sys/devices/system/memory/memoryXXX/state
> +With that in mind, it makes sense that we can have a big portion of system RAM
> +managed by ZONE_MOVABLE. However, there are some things to consider when
> +using ZONE_MOVABLE, especially when fine-tuning zone ratios:
>  
> -If offline succeeds, the state of the memory block is changed to be "offline".
> -If it fails, some error core (like -EBUSY) will be returned by the kernel.
> -Even if a memory block does not belong to ZONE_MOVABLE, you can try to offline
> -it.  If it doesn't contain 'unmovable' memory, you'll get success.
> +- Having a lot of offline memory blocks. Even offline memory blocks consume
> +  memory for metadata and page tables in the direct map; having a lot of
> +  offline memory blocks is not a typical case, though.
> +
> +- Memory ballooning. Some memory ballooning implementations, such as
> +  the Hyper-V balloon, the XEN balloon, the vbox balloon and the VMWare

So, everyone except virtio-mem? ;-)
I'd drop the names because if some of those will implement balloon
compaction they surely will forget to update the docs.

> +  balloon with huge pages don't support balloon compaction and, thereby
> +  ZONE_MOVABLE.
> +
> +  Further, CONFIG_BALLOON_COMPACTION might be disabled. In that case, balloon
> +  inflation will only perform unmovable allocations and silently create a
> +  zone imbalance, usually triggered by inflation requests from the
> +  hypervisor.
> +
> +- Gigantic pages are unmovable, resulting in user space consuming a
> +  lot of unmovable memory.
> +
> +- Huge pages are unmovable when an architectures does not support huge
> +  page migration, resulting in a similar issue as with gigantic pages.
> +
> +- Page tables are unmovable. Excessive swapping, mapping extremely large
> +  files or ZONE_DEVICE memory can be problematic, although only
> +  really relevant in corner cases. When we manage a lot of user space memory
> +  that has been swapped out or is served from a file/pmem/... we still need

                                                     ^ persistent memory

> +  a lot of page tables to manage that memory once user space accessed that
> +  memory once.
> +
> +- DAX: when we have a lot of ZONE_DEVICE memory added to the system as DAX
> +  and we are not using an altmap to allocate the memmap from device memory
> +  directly, we will have to allocate the memmap for this memory from the
> +  kernel zones.

I'm not sure admin-guide reader will know when we use altmap when we don't.
Maybe 

  DAX: in certain DAX configurations the memory map for the device memory will
  be allocated from the kernel zones.
  
> -A memory block under ZONE_MOVABLE is considered to be able to be offlined
> -easily.  But under some busy state, it may return -EBUSY. Even if a memory
> -block cannot be offlined due to -EBUSY, you can retry offlining it and may be
> -able to offline it (or not). (For example, a page is referred to by some kernel
> -internal call and released soon.)
> +- Long-term pinning of pages. Techniques that rely on long-term pinnings
> +  (especially, RDMA and vfio/mdev) are fundamentally problematic with
> +  ZONE_MOVABLE, and therefore, memory offlining. Pinned pages cannot reside
> +  on ZONE_MOVABLE as that would turn these pages unmovable. Therefore, they
> +  have to be migrated off that zone while pinning. Pinning a page can fail
> +  even if there is plenty of free memory in ZONE_MOVABLE.
>  
> -Consideration:
> -  Memory hotplug's design direction is to make the possibility of memory
> -  offlining higher and to guarantee unplugging memory under any situation. But
> -  it needs more work. Returning -EBUSY under some situation may be good because
> -  the user can decide to retry more or not by himself. Currently, memory
> -  offlining code does some amount of retry with 120 seconds timeout.
> +  In addition, using ZONE_MOVABLE might make page pinning more expensive,
> +  because of the page migration overhead.
>  
> -Physical memory remove
> -======================
> +Boot Memory and ZONE_MOVABLE
> +----------------------------
>  
> -Need more implementation yet....
> - - Notification completion of remove works by OS to firmware.
> - - Guard from remove if not yet.
> +Without further configuration, all boot memory will be managed by kernel zones
> +when booting up in most configurations. ZONE_MOVABLE is not used as default.
>  
> +However, there is a mechanism to configure that behavior during boot via the
> +cmdline: ``kernelcore=`` and ``movablecore=``. See
> +Documentation/admin-guide/kernel-parameters.rst for details.
> +
> +Memory Offlining and ZONE_MOVABLE
> +---------------------------------
> +
> +Even with ZONE_MOVABLE, there are some corner cases where offlining a memory
> +block might fail:
> +
> +- Memory blocks with memory holes; this applies to memory blocks present during
> +  boot and can apply to memory blocks hotplugged via the XEN balloon and the
> +  Hyper-V balloon.
> +
> +- Mixed NUMA nodes and mixed zones within a single memory block prevent memory
> +  offlining; this applies to memory blocks present during boot only.
> +
> +- Special memory blocks prevented by the system from getting offlined. Examples
> +  include any memory available during boot on arm64 or memory blocks spanning
> +  the crashkernel area on s390x; this usually applies to memory blocks present
> +  during boot only.
> +
> +- Memory blocks overlapping with CMA areas cannot be offlined, this applies to
> +  memory blocks present during boot only.
> +
> +- Concurrent activity that operates on the same physical memory area, such as
> +  allocating gigantic pages, can result in temporary offlining failures.
> +
> +- Out of memory when dissolving huge pages, especially when freeing unused
> +  vmemmap pages associated with each hugetlb page is enabled.
> +
> +  Offlining code may be able to migrate huge page contents, but may not be able
> +  to dissolve the source huge page because it fails allocating (unmovable) pages
> +  for the vmemmap, because the system might not have free memory in the kernel
> +  zones left.
> +
> +  Users that depend on memory hotplug to succeed for movable zones should
> +  carefully consider whether the memory savings gained from this feature are
> +  worth the risk of possibly not being able to offline memory in certain
> +  situations.
> +
> +Further, when running into out of memory situations while migrating pages, or
> +when still encountering permanently unmovable pages within ZONE_MOVABLE
> +(-> BUG), memory offlining will keep retrying until it eventually succeeds.
>  
>  Locking Internals
>  =================
> @@ -440,8 +594,8 @@ As the device is visible to user space before taking the device_lock(), this
>  can result in a lock inversion.
>  
>  onlining/offlining of memory should be done via device_online()/
> -device_offline() - to make sure it is properly synchronized to actions
> -via sysfs. Holding device_hotplug_lock is advised (to e.g. protect online_type)
> +device_offline() -- to make sure it is properly synchronized to actions
> +via sysfs -- while holding the device_hotplug_lock.
>  
>  When adding/removing/onlining/offlining memory or adding/removing
>  heterogeneous/device memory, we should always hold the mem_hotplug_lock in
> @@ -452,15 +606,3 @@ In addition, mem_hotplug_lock (in contrast to device_hotplug_lock) in read
>  mode allows for a quite efficient get_online_mems/put_online_mems
>  implementation, so code accessing memory can protect from that memory
>  vanishing.
> -
> -
> -Future Work
> -===========
> -
> -  - allowing memory hot-add to ZONE_MOVABLE. maybe we need some switch like
> -    sysctl or new control file.
> -  - showing memory block and physical device relationship.
> -  - test and make it better memory offlining.
> -  - support HugeTLB page migration and offlining.
> -  - memmap removing at memory offline.
> -  - physical remove memory.
> -- 
> 2.31.1
> 

-- 
Sincerely yours,
Mike.
