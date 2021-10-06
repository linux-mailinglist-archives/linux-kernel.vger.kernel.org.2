Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C13423511
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 02:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbhJFAhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 20:37:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230218AbhJFAhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 20:37:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A81BE61207;
        Wed,  6 Oct 2021 00:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633480549;
        bh=PrZNgMx7YzMXM2DrDDSBr5tyPQGCj7j0uu7IMYK3EC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FNg8p9vnOBdjONhlzgt21BQUsX5Ls3sKljcMLq3eH1OjZpIpbSYJ8eytov9AhoTgW
         OsfAD7LOtVg3wT7pKVkoKZFDwqVrkrTFh+BXNcRzu6TeIWAGTfPw2kIhSwGupk86t5
         pw0Qv5KndBfaYbgXxU+dDD491qenPRMsqeEsoJAq1iJE/nyxHt09Ihlw+nhA1JSV7l
         uUOmVK7RLAKhx8oXbApZ7JlCLqeO8M7TNGD8bXn7OpMHSBJYggXqTc8LwRhw9WNbVb
         SpxWHF25iaRwmiLVWVIw7T/KDSVLBMC1ZfqSc2PZj4gKL38PpjF5pb9TWss+1M3urJ
         cOk1IPcGWC+Kw==
Date:   Tue, 5 Oct 2021 17:35:46 -0700
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 3/3] memory-hotplug.rst: document the "auto-movable"
 online policy
Message-ID: <YVzvYmf4xWC1DORO@kernel.org>
References: <20210930144117.23641-1-david@redhat.com>
 <20210930144117.23641-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930144117.23641-4-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 04:41:17PM +0200, David Hildenbrand wrote:
> In commit e83a437faa62 ("mm/memory_hotplug: introduce "auto-movable" online
> policy") we introduced a new memory online policy to automatically
> select a zone for memory blocks to be onlined. We added a way to
> set the active online policy and tunables for the auto-movable online
> policy. In follow-up commits we tweaked the "auto-movable" policy to also
> consider memory device details when selecting zones for memory blocks to
> be onlined.
> 
> Let's document the new toggles and how the two online policies we have
> work.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  .../admin-guide/mm/memory-hotplug.rst         | 128 +++++++++++++++---
>  1 file changed, 108 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
> index ee00b70dedde..c20a2c0031cf 100644
> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
> @@ -165,9 +165,8 @@ Or alternatively::
>  
>  	% echo 1 > /sys/devices/system/memory/memoryXXX/online
>  
> -The kernel will select the target zone automatically, usually defaulting to
> -``ZONE_NORMAL`` unless ``movable_node`` has been specified on the kernel
> -command line or if the memory block would intersect the ZONE_MOVABLE already.
> +The kernel will select the target zone automatically, depending on the
> +configured ``online_policy``.
>  
>  One can explicitly request to associate an offline memory block with
>  ZONE_MOVABLE by::
> @@ -198,6 +197,9 @@ Auto-onlining can be enabled by writing ``online``, ``online_kernel`` or
>  
>  	% echo online > /sys/devices/system/memory/auto_online_blocks
>  
> +Similarly to manual onlining, with ``online`` the kernel will select the
> +target zone automatically, depending on the configured ``online_policy``.
> +
>  Modifying the auto-online behavior will only affect all subsequently added
>  memory blocks only.
>  
> @@ -393,9 +395,11 @@ command line parameters are relevant:
>  ======================== =======================================================
>  ``memhp_default_state``	 configure auto-onlining by essentially setting
>                           ``/sys/devices/system/memory/auto_online_blocks``.
> -``movable_node``	 configure automatic zone selection in the kernel. When
> -			 set, the kernel will default to ZONE_MOVABLE, unless
> -			 other zones can be kept contiguous.
> +``movable_node``	 configure automatic zone selection in the kernel when
> +			 using the ``contig-zones`` online policy. When
> +			 set, the kernel will default to ZONE_MOVABLE when
> +			 onlining a memory block, unless other zones can be kept
> +			 contiguous.

The movable_node main purpose is to allow unplugging an entire node. Zone
selection is a consequence of this. You may want to cite the description of
movable_node in kernel-paramenters.txt here.

And, pardon my ignorance, how movable_node will play with auto-movable
policy?

>  ======================== =======================================================
>  
>  Module Parameters
> @@ -414,20 +418,104 @@ and they can be observed (and some even modified at runtime) via::
>  
>  The following module parameters are currently defined:
>  
> -======================== =======================================================
> -``memmap_on_memory``	 read-write: Allocate memory for the memmap from the
> -			 added memory block itself. Even if enabled, actual
> -			 support depends on various other system properties and
> -			 should only be regarded as a hint whether the behavior
> -			 would be desired.
> -
> -			 While allocating the memmap from the memory block
> -			 itself makes memory hotplug less likely to fail and
> -			 keeps the memmap on the same NUMA node in any case, it
> -			 can fragment physical memory in a way that huge pages
> -			 in bigger granularity cannot be formed on hotplugged
> -			 memory.
> -======================== =======================================================
> +================================ ===============================================
> +``memmap_on_memory``		 read-write: Allocate memory for the memmap from
> +				 the added memory block itself. Even if enabled,
> +				 actual support depends on various other system
> +				 properties and should only be regarded as a
> +				 hint whether the behavior would be desired.
> +
> +				 While allocating the memmap from the memory
> +				 block itself makes memory hotplug less likely
> +				 to fail and keeps the memmap on the same NUMA
> +				 node in any case, it can fragment physical
> +				 memory in a way that huge pages in bigger
> +				 granularity cannot be formed on hotplugged
> +				 memory.
> +``online_policy``		 read-write: Set the basic policy used for
> +				 automatic zone selection when onlining memory
> +				 blocks without specifying a target zone.
> +				 ``contig-zones`` has been the kernel default
> +				 before this parameter was added. After an
> +				 online policy was configured and memory was
> +				 online, the policy should not be changed
> +				 anymore.
> +
> +				 When set to ``contig-zones``, the kernel will
> +				 try keeping zones contiguous. If a memory block
> +				 intersects multiple zones or no zone, the
> +				 behavior depends on the ``movable_node`` kernel
> +				 command line parameter: default to ZONE_MOVABLE
> +				 if set, default to the applicable kernel zone
> +				 (usually ZONE_NORMAL) if not set.
> +
> +				 When set to ``auto-movable``, the kernel will
> +				 try onlining memory blocks to ZONE_MOVABLE if
> +				 possible according to the configuration and
> +				 memory device details. With this policy, one
> +				 can avoid zone imbalances when eventually
> +				 hotplugging a lot of memory later and still
> +				 wanting to be able to hotunplug as much as
> +				 possible reliably, very desirable in
> +				 virtualized environments. As one example, a
> +				 hotplugged DIMM will be onlined either
> +				 completely to ZONE_MOVABLE or completely to
> +				 ZONE_NORMAL, not a mixture.
> +				 As another example, as many memory blocks
> +				 belonging to a virtio-mem device will be
> +				 onlined to ZONE_MOVABLE as possible,
> +				 special-casing units of memory blocks that can
> +				 only get hotunplugged together. *This policy
> +				 does not protect from setups that are
> +				 problematic with ZONE_MOVABLE and does not
> +				 change the zone of memory blocks dynamically
> +				 after they were onlined.*
> +``auto_movable_ratio``		 read-write: Set the maximum MOVABLE:KERNEL
> +				 memory ratio in % for the ``auto-movable``
> +				 online policy. Whether the ratio applies only
> +				 for the system across all NUMA nodes or also
> +				 per NUMA nodes depends on the
> +				 ``auto_movable_numa_aware`` configuration.
> +
> +				 All accounting is based on present memory pages
> +				 in the zones combined with accounting per
> +				 memory device. Memory dedicated to the CMA
> +				 allocator is accounted as MOVABLE, although
> +				 residing on one of the kernel zones. The
> +				 possible ratio depends on the actual workload.
> +				 The kernel default is "301" %, for example,
> +				 allowing for hotplugging 24 GiB to a 8 GiB VM
> +				 and automatically onlining all hotplugged
> +				 memory to ZONE_MOVABLE in many setups. The
> +				 additional 1% deals with some pages being not
> +				 present, for example, because of some firmware
> +				 allocations.
> +
> +				 Note that ZONE_NORMAL memory provided by one
> +				 memory device does not allow for more
> +				 ZONE_MOVABLE memory for a different memory
> +				 device. As one example, onlining memory of a
> +				 hotplugged DIMM to ZONE_NORMAL will not allow
> +				 for another hotplugged DIMM to get onlined to
> +				 ZONE_MOVABLE automatically. In contrast, memory
> +				 hotplugged by a virtio-mem device that got
> +				 onlined to ZONE_NORMAL will allow for more
> +				 ZONE_MOVABLE memory within *the same*
> +				 virtio-mem device.
> +``auto_movable_numa_aware``	 read-write: Configure whether the
> +				 ``auto_movable_ratio`` in the ``auto-movable``
> +				 online policy also applies per NUMA
> +				 node in addition to the whole system across all
> +				 NUMA nodes. The kernel default is "Y".
> +
> +				 Disabling NUMA awareness can be helpful when
> +				 dealing with NUMA nodes that should be
> +				 completely hotunpluggable, onlining the memory
> +				 completely to ZONE_MOVABLE automatically if
> +				 possible.
> +
> +				 Parameter availability depends on CONFIG_NUMA.
> +================================ ===============================================
>  
>  ZONE_MOVABLE
>  ============
> -- 
> 2.31.1
> 

-- 
Sincerely yours,
Mike.
