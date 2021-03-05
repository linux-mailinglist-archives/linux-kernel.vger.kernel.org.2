Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA2E32EEF3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 16:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhCEPfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 10:35:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229465AbhCEPfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614958516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T1T9qTxRJ5XtudGRa/OMLDwpqFc2WRKErn3/668/V68=;
        b=Af+MlQXi7upCjfOawkHTOt2mEfD8lLzonahL4qeyHFau1IQWkmuNb+DDK2IkI6uWjWqlmE
        Ppgf9YquRMulp3O1z2rcrW9baj2SIVo1dR2ru1CiPVeizbxegWH181BPIAlaksPJ1gTDJ/
        IkAUotHU8FQpu9+cuousO53k+2bSafI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-iSbw_ui6P9mNAozTlVgZSA-1; Fri, 05 Mar 2021 10:35:12 -0500
X-MC-Unique: iSbw_ui6P9mNAozTlVgZSA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1510A80006E;
        Fri,  5 Mar 2021 15:35:11 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E9A1100164C;
        Fri,  5 Mar 2021 15:35:09 +0000 (UTC)
Subject: Re: [PATCH v3 3/5] mm,memory_hotplug: Add kernel boot option to
 enable memmap_on_memory
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210304100002.7740-1-osalvador@suse.de>
 <20210304100002.7740-4-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <b139d4fe-fdef-b5d9-4fdf-2f79cb00a24a@redhat.com>
Date:   Fri, 5 Mar 2021 16:35:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210304100002.7740-4-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.21 11:00, Oscar Salvador wrote:
> Self stored memmap leads to a sparse memory situation which is unsuitable
> for workloads that requires large contiguous memory chunks, so make this
> an opt-in which needs to be explicitly enabled.
> 
> To control this, let memory_hotplug have its own memory space, as suggested
> by David, so we can add memory_hotplug.memmap_on_memory parameter.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 14 ++++++++++++++
>   mm/Makefile                                     |  5 ++++-
>   mm/memory_hotplug.c                             |  8 +++++++-
>   3 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 04545725f187..e626dab39c60 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2794,6 +2794,20 @@
>   			seconds.  Use this parameter to check at some
>   			other rate.  0 disables periodic checking.
>   
> +	memory_hotplug.memmap_on_memory
> +			[KNL,X86,ARM] Boolean flag to enable this feature.

Right now it can be set on any arch with memory hotplug, right? It's 
simply not effective.

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

Maybe want to add that even if enabled, there are cases where it is not 
effective?

> +
>   	memtest=	[KNL,X86,ARM,PPC] Enable memtest
>   			Format: <integer>
>   			default : 0 <disable>
> diff --git a/mm/Makefile b/mm/Makefile
> index 72227b24a616..82ae9482f5e3 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -58,9 +58,13 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
>   page-alloc-y := page_alloc.o
>   page-alloc-$(CONFIG_SHUFFLE_PAGE_ALLOCATOR) += shuffle.o
>   
> +# Give 'memory_hotplug' its own module-parameter namespace
> +memory-hotplug-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
> +
>   obj-y += page-alloc.o
>   obj-y += init-mm.o
>   obj-y += memblock.o
> +obj-y += $(memory-hotplug-y)
>   
>   ifdef CONFIG_MMU
>   	obj-$(CONFIG_ADVISE_SYSCALLS)	+= madvise.o
> @@ -83,7 +87,6 @@ obj-$(CONFIG_SLUB) += slub.o
>   obj-$(CONFIG_KASAN)	+= kasan/
>   obj-$(CONFIG_KFENCE) += kfence/
>   obj-$(CONFIG_FAILSLAB) += failslab.o
> -obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
>   obj-$(CONFIG_MEMTEST)		+= memtest.o
>   obj-$(CONFIG_MIGRATION) += migrate.o
>   obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 63e5a0e9a6f3..94b0ec3d2ff2 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -42,7 +42,13 @@
>   #include "internal.h"
>   #include "shuffle.h"
>   
> -static bool memmap_on_memory;
> +
> +/*
> + * memory_hotplug.memmap_on_memory parameter
> + */
> +static bool memmap_on_memory __ro_after_init;
> +module_param(memmap_on_memory, bool, 0444);
> +MODULE_PARM_DESC(memmap_on_memory, "Enable memmap on memory for memory hotplug");
>   

Wondering if this makes sense getting wrapped in

#ifdef CONFIG MHP_MEMMAP_ON_MEMORY

just a thought.

LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

