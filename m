Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD740345C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 11:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhCWKsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 06:48:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:40202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230295AbhCWKr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 06:47:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616496475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fW6mA/RAOH8nnf9IdxfeqQ3TVeY0wxpBUV2ZnKWK5vA=;
        b=p/lob3TaiH5PhM3uEOboUu4BtpDVGmQfKG0ycNzqCWuhupDL1aihy1Px5JvWczdwMK3VXx
        5MPZDco1EoMJ6kBN4zxp9DSjul7n7ZJ8mlCTqYrxF46iE2rZnqApqHGXt7i8tDH2PSE/pj
        olVmJhobaDWbSPzQEL7eJEXtbBtnxPY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0099FAC3E;
        Tue, 23 Mar 2021 10:47:54 +0000 (UTC)
Date:   Tue, 23 Mar 2021 11:47:53 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] mm,memory_hotplug: Add kernel boot option to
 enable memmap_on_memory
Message-ID: <YFnHWQ30O5efsdQ1@dhcp22.suse.cz>
References: <20210319092635.6214-1-osalvador@suse.de>
 <20210319092635.6214-4-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319092635.6214-4-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-03-21 10:26:33, Oscar Salvador wrote:
> Self stored memmap leads to a sparse memory situation which is unsuitable
> for workloads that requires large contiguous memory chunks, so make this
> an opt-in which needs to be explicitly enabled.
> 
> To control this, let memory_hotplug have its own memory space, as suggested
> by David, so we can add memory_hotplug.memmap_on_memory parameter.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

I would just rephrased the help text to be less low level
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++++++++
>  mm/Makefile                                     |  5 ++++-
>  mm/memory_hotplug.c                             | 10 +++++++++-
>  3 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 04545725f187..d29b96e50c5c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2794,6 +2794,22 @@
>  			seconds.  Use this parameter to check at some
>  			other rate.  0 disables periodic checking.
>  
> +	memory_hotplug.memmap_on_memory
> +			[KNL,X86,ARM] Boolean flag to enable this feature.
> +			Format: {on | off (default)}
> +			When enabled, memory to build the pages tables for the
> +			memmap array describing the hot-added range will be taken
> +			from the range itself, so the memmap page tables will be
> +			self-hosted.
> +			Since only single memory device ranges are supported at
> +			the moment, this option is disabled by default because
> +			it might have an impact on workloads that needs large
> +			contiguous memory chunks.
> +			The state of the flag can be read in
> +			/sys/module/memory_hotplug/parameters/memmap_on_memory.
> +			Note that even when enabled, there are a few cases where
> +			the feature is not effective.
> +

			When enabled, runtime hotplugged memory will
			allocate its internal metadata (struct pages)
			from the hotadded memory which will allow to
			hotadd a lot of memory without requiring
			additional memory to do so.
			This feature is disabled by default because it
			has some implication on large (e.g. GB)
			allocations in some configurations (e.g. small
			memory blocks).

>  	memtest=	[KNL,X86,ARM,PPC] Enable memtest
>  			Format: <integer>
>  			default : 0 <disable>
> diff --git a/mm/Makefile b/mm/Makefile
> index 72227b24a616..82ae9482f5e3 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -58,9 +58,13 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
>  page-alloc-y := page_alloc.o
>  page-alloc-$(CONFIG_SHUFFLE_PAGE_ALLOCATOR) += shuffle.o
>  
> +# Give 'memory_hotplug' its own module-parameter namespace
> +memory-hotplug-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
> +
>  obj-y += page-alloc.o
>  obj-y += init-mm.o
>  obj-y += memblock.o
> +obj-y += $(memory-hotplug-y)
>  
>  ifdef CONFIG_MMU
>  	obj-$(CONFIG_ADVISE_SYSCALLS)	+= madvise.o
> @@ -83,7 +87,6 @@ obj-$(CONFIG_SLUB) += slub.o
>  obj-$(CONFIG_KASAN)	+= kasan/
>  obj-$(CONFIG_KFENCE) += kfence/
>  obj-$(CONFIG_FAILSLAB) += failslab.o
> -obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
>  obj-$(CONFIG_MEMTEST)		+= memtest.o
>  obj-$(CONFIG_MIGRATION) += migrate.o
>  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 350cde69a97d..c525e5dab859 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -42,7 +42,15 @@
>  #include "internal.h"
>  #include "shuffle.h"
>  
> -static bool memmap_on_memory;

The memmap_on_memory can be dropped from the 1st patch IIUC and only
introduce it now.

> +
> +/*
> + * memory_hotplug.memmap_on_memory parameter
> + */
> +static bool memmap_on_memory __ro_after_init;
> +#ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
> +module_param(memmap_on_memory, bool, 0444);
> +MODULE_PARM_DESC(memmap_on_memory, "Enable memmap on memory for memory hotplug");
> +#endif

I am not very much familiar with the machinery. Does this expose the
state to the userspace?

-- 
Michal Hocko
SUSE Labs
