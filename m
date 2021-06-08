Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1314239F8DA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 16:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbhFHOVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:21:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233129AbhFHOVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:21:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 348BA6135D;
        Tue,  8 Jun 2021 14:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623161967;
        bh=vgomed/fFV+dy2eA01Kw/duzevIkt+qd3SY8fxSJQqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F8y/iDcySfPiZkIvhGmow9mMEg9/j+KXYzhWk4FubYL/3zr27JWltTfjxBoQ8UQnK
         jpFCivxVElEYPE8vgGcOPiQLoZMDGWv99OcClsUMcuHXiCpHF5hwJTS5sTJ2jJ7UPi
         fSRxxu4hRl3sCuzNE3aTywoIC/KD4ADu1crThHbsTlkQ40Rh9uk6X+tPAkBzl8xff8
         9lBU+n4ccZyI9KOI3qiiZvFYGi70sth7VVpImUup8d3N64Y74QdJzwo4LAi1qQHGwV
         HqSNa9aPcQ/1+4VKOzQuQ4mtNr1nTgKDLYNIi9Br8l0UyiTazHessLkcXd17cdSzl3
         /IuQSo5CeFYQg==
Date:   Tue, 8 Jun 2021 17:19:17 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] memory-hotplug.rst: remove locking details from
 admin-guide
Message-ID: <YL98ZermcxfZ9LJn@kernel.org>
References: <20210608133855.20397-1-david@redhat.com>
 <20210608133855.20397-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608133855.20397-2-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 03:38:54PM +0200, David Hildenbrand wrote:
> We have the same content at Documentation/core-api/memory-hotplug.rst
> and it doesn't fit into the admin-guide. The documentation was
> accidentially duplicated when merging.
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

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  .../admin-guide/mm/memory-hotplug.rst         | 39 -------------------
>  1 file changed, 39 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
> index c6bae2d77160..a783cf7c8e4c 100644
> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
> @@ -415,45 +415,6 @@ Need more implementation yet....
>   - Guard from remove if not yet.
>  
>  
> -Locking Internals
> -=================
> -
> -When adding/removing memory that uses memory block devices (i.e. ordinary RAM),
> -the device_hotplug_lock should be held to:
> -
> -- synchronize against online/offline requests (e.g. via sysfs). This way, memory
> -  block devices can only be accessed (.online/.state attributes) by user
> -  space once memory has been fully added. And when removing memory, we
> -  know nobody is in critical sections.
> -- synchronize against CPU hotplug and similar (e.g. relevant for ACPI and PPC)
> -
> -Especially, there is a possible lock inversion that is avoided using
> -device_hotplug_lock when adding memory and user space tries to online that
> -memory faster than expected:
> -
> -- device_online() will first take the device_lock(), followed by
> -  mem_hotplug_lock
> -- add_memory_resource() will first take the mem_hotplug_lock, followed by
> -  the device_lock() (while creating the devices, during bus_add_device()).
> -
> -As the device is visible to user space before taking the device_lock(), this
> -can result in a lock inversion.
> -
> -onlining/offlining of memory should be done via device_online()/
> -device_offline() - to make sure it is properly synchronized to actions
> -via sysfs. Holding device_hotplug_lock is advised (to e.g. protect online_type)
> -
> -When adding/removing/onlining/offlining memory or adding/removing
> -heterogeneous/device memory, we should always hold the mem_hotplug_lock in
> -write mode to serialise memory hotplug (e.g. access to global/zone
> -variables).
> -
> -In addition, mem_hotplug_lock (in contrast to device_hotplug_lock) in read
> -mode allows for a quite efficient get_online_mems/put_online_mems
> -implementation, so code accessing memory can protect from that memory
> -vanishing.
> -
> -
>  Future Work
>  ===========
>  
> -- 
> 2.31.1
> 

-- 
Sincerely yours,
Mike.
