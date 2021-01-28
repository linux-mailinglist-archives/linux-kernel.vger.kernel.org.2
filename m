Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F37306C84
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 05:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhA1Ewu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 23:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhA1Ews (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 23:52:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C7CC061573;
        Wed, 27 Jan 2021 20:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9y/VA2V4wSgLFwLn/kt/bMejNk1Qb3Do8doupfxo9+8=; b=QF5Wykxm7vID2fOkq5vSONCjGv
        ahDau67byyJHWxrGimMjObP7TKH8srA7xlddR5r+FwXlGn960YUuRc5rq46mGZ6myrKCoSor9FN2Z
        OtmOWXN1iqduSVsPxHhx8t0h9qaiTIAtPZkc6a7ZGhat+bOaZ4C8Pe8d/nTkAs78jcgKZlQ/cdSpL
        LekoH3p34zCN1c4Xpxueh/KaHBjUYW53E+Zq2blKAEwiHvHz6DWkf6lQKnEK4tl/G1tB1GKqqsnkA
        Zeo7QAyFwWNGIFzXZXnAYryrODvcZH4rLufuZq3415SfGTeBGbqMPibq/eMayFmYnD3wYYxl1bHpm
        8gx/Hvsg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4zHd-007x7o-IK; Thu, 28 Jan 2021 04:51:54 +0000
Date:   Thu, 28 Jan 2021 04:51:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Saravanan D <saravanand@fb.com>
Cc:     x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-doc@vger.kernel.org, linux-mm@kvack.org,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH V4] x86/mm: Tracking linear mapping split events
Message-ID: <20210128045153.GW308988@casper.infradead.org>
References: <a936a943-9d8f-7e3c-af38-1c99ae176e1f@intel.com>
 <20210128043547.1560435-1-saravanand@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128043547.1560435-1-saravanand@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You forgot to cc linux-mm.  Adding.  Also I think you should be cc'ing
Song.

On Wed, Jan 27, 2021 at 08:35:47PM -0800, Saravanan D wrote:
> To help with debugging the sluggishness caused by TLB miss/reload,
> we introduce monotonic lifetime hugepage split event counts since
> system state: SYSTEM_RUNNING to be displayed as part of
> /proc/vmstat in x86 servers
> 
> The lifetime split event information will be displayed at the bottom of
> /proc/vmstat
> ....
> swap_ra 0
> swap_ra_hit 0
> direct_map_level2_splits 94
> direct_map_level3_splits 4
> nr_unstable 0
> ....
> 
> One of the many lasting (as we don't coalesce back) sources for huge page
> splits is tracing as the granular page attribute/permission changes would
> force the kernel to split code segments mapped to huge pages to smaller
> ones thereby increasing the probability of TLB miss/reload even after
> tracing has been stopped.

Are you talking about kernel text here or application text?

In either case, I don't know why you're saying we don't coalesce
back after tracing is disabled.  I was under the impression we did
(either actively in the case of the kernel or via khugepaged for
user text).

> Documentation regarding linear mapping split events added to admin-guide
> as requested in V3 of the patch.
> 
> Signed-off-by: Saravanan D <saravanand@fb.com>
> ---
>  .../admin-guide/mm/direct_mapping_splits.rst  | 59 +++++++++++++++++++
>  Documentation/admin-guide/mm/index.rst        |  1 +
>  arch/x86/mm/pat/set_memory.c                  | 13 ++++
>  include/linux/vm_event_item.h                 |  4 ++
>  mm/vmstat.c                                   |  4 ++
>  5 files changed, 81 insertions(+)
>  create mode 100644 Documentation/admin-guide/mm/direct_mapping_splits.rst
> 
> diff --git a/Documentation/admin-guide/mm/direct_mapping_splits.rst b/Documentation/admin-guide/mm/direct_mapping_splits.rst
> new file mode 100644
> index 000000000000..298751391deb
> --- /dev/null
> +++ b/Documentation/admin-guide/mm/direct_mapping_splits.rst
> @@ -0,0 +1,59 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================
> +Direct Mapping Splits
> +=====================
> +
> +Kernel maps all of physical memory in linear/direct mapped pages with
> +translation of virtual kernel address to physical address is achieved
> +through a simple subtraction of offset. CPUs maintain a cache of these
> +translations on fast caches called TLBs. CPU architectures like x86 allow
> +direct mapping large portions of memory into hugepages (2M, 1G, etc) in
> +various page table levels.
> +
> +Maintaining huge direct mapped pages greatly reduces TLB miss pressure.
> +The splintering of huge direct pages into smaller ones does result in
> +a measurable performance hit caused by frequent TLB miss and reloads.
> +
> +One of the many lasting (as we don't coalesce back) sources for huge page
> +splits is tracing as the granular page attribute/permission changes would
> +force the kernel to split code segments mapped to hugepages to smaller
> +ones thus increasing the probability of TLB miss/reloads even after
> +tracing has been stopped.
> +
> +On x86 systems, we can track the splitting of huge direct mapped pages
> +through lifetime event counters in ``/proc/vmstat``
> +
> +	direct_map_level2_splits xxx
> +	direct_map_level3_splits yyy
> +
> +where:
> +
> +direct_map_level2_splits
> +	are 2M/4M hugepage split events
> +direct_map_level3_splits
> +	are 1G hugepage split events
> +
> +The distribution of direct mapped system memory in various page sizes
> +post splits can be viewed through ``/proc/meminfo`` whose output
> +will include the following lines depending upon supporting CPU
> +architecture
> +
> +	DirectMap4k:    xxxxx kB
> +	DirectMap2M:    yyyyy kB
> +	DirectMap1G:    zzzzz kB
> +
> +where:
> +
> +DirectMap4k
> +	is the total amount of direct mapped memory (in kB)
> +	accessed through 4k pages
> +DirectMap2M
> +	is the total amount of direct mapped memory (in kB)
> +	accessed through 2M pages
> +DirectMap1G
> +	is the total amount of direct mapped memory (in kB)
> +	accessed through 1G pages
> +
> +
> +-- Saravanan D, Jan 27, 2021
> diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
> index 4b14d8b50e9e..9439780f3f07 100644
> --- a/Documentation/admin-guide/mm/index.rst
> +++ b/Documentation/admin-guide/mm/index.rst
> @@ -38,3 +38,4 @@ the Linux memory management.
>     soft-dirty
>     transhuge
>     userfaultfd
> +   direct_mapping_splits
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 16f878c26667..767cade53bdc 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -16,6 +16,8 @@
>  #include <linux/pci.h>
>  #include <linux/vmalloc.h>
>  #include <linux/libnvdimm.h>
> +#include <linux/vmstat.h>
> +#include <linux/kernel.h>
>  
>  #include <asm/e820/api.h>
>  #include <asm/processor.h>
> @@ -85,12 +87,23 @@ void update_page_count(int level, unsigned long pages)
>  	spin_unlock(&pgd_lock);
>  }
>  
> +void update_split_page_event_count(int level)
> +{
> +	if (system_state == SYSTEM_RUNNING) {
> +		if (level == PG_LEVEL_2M)
> +			count_vm_event(DIRECT_MAP_LEVEL2_SPLIT);
> +		else if (level == PG_LEVEL_1G)
> +			count_vm_event(DIRECT_MAP_LEVEL3_SPLIT);
> +	}
> +}
> +
>  static void split_page_count(int level)
>  {
>  	if (direct_pages_count[level] == 0)
>  		return;
>  
>  	direct_pages_count[level]--;
> +	update_split_page_event_count(level);
>  	direct_pages_count[level - 1] += PTRS_PER_PTE;
>  }
>  
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index 18e75974d4e3..7c06c2bdc33b 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -120,6 +120,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  #ifdef CONFIG_SWAP
>  		SWAP_RA,
>  		SWAP_RA_HIT,
> +#endif
> +#ifdef CONFIG_X86
> +		DIRECT_MAP_LEVEL2_SPLIT,
> +		DIRECT_MAP_LEVEL3_SPLIT,
>  #endif
>  		NR_VM_EVENT_ITEMS
>  };
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index f8942160fc95..a43ac4ac98a2 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1350,6 +1350,10 @@ const char * const vmstat_text[] = {
>  	"swap_ra",
>  	"swap_ra_hit",
>  #endif
> +#ifdef CONFIG_X86
> +	"direct_map_level2_splits",
> +	"direct_map_level3_splits",
> +#endif
>  #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
>  };
>  #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG */
> -- 
> 2.24.1
> 
