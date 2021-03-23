Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B3B345C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 11:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCWKkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 06:40:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:36406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhCWKkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 06:40:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616496032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j6VJBOqPp1IrCTH90OFeWiL35R+bOlqcNiPTvvstMhI=;
        b=T5gkMXkqrikPtYfoXNhJpidht574S/HQwGQ1absbWzeZSegz3kLGfQHCP6DdMf6DSxRdF4
        U6qaSp6nrENLxnFzbGj5VEoCQ2qn7Xs+mzvJnoL5kZFQjOcjihj1lCPUmktRd2EzShQ0VA
        yKbrRyCAxHIhRMpNs45qpmOPwo5wjao=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EA070AC3E;
        Tue, 23 Mar 2021 10:40:31 +0000 (UTC)
Date:   Tue, 23 Mar 2021 11:40:31 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] acpi,memhotplug: Enable MHP_MEMMAP_ON_MEMORY when
 supported
Message-ID: <YFnFnwC/6bxpFkGi@dhcp22.suse.cz>
References: <20210319092635.6214-1-osalvador@suse.de>
 <20210319092635.6214-3-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319092635.6214-3-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-03-21 10:26:32, Oscar Salvador wrote:
> Let the caller check whether it can pass MHP_MEMMAP_ON_MEMORY by
> checking mhp_supports_memmap_on_memory().
> MHP_MEMMAP_ON_MEMORY can only be set in case
> ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE is enabled, the architecture supports
> altmap, and the range to be added spans a single memory block.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  drivers/acpi/acpi_memhotplug.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index b02fd51e5589..8cc195c4c861 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -171,6 +171,7 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>  	acpi_handle handle = mem_device->device->handle;
>  	int result, num_enabled = 0;
>  	struct acpi_memory_info *info;
> +	mhp_t mhp_flags = MHP_NONE;
>  	int node;
>  
>  	node = acpi_get_node(handle);
> @@ -194,8 +195,10 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>  		if (node < 0)
>  			node = memory_add_physaddr_to_nid(info->start_addr);
>  
> +		if (mhp_supports_memmap_on_memory(info->length))
> +			mhp_flags |= MHP_MEMMAP_ON_MEMORY;
>  		result = __add_memory(node, info->start_addr, info->length,
> -				      MHP_NONE);
> +				      mhp_flags);
>  
>  		/*
>  		 * If the memory block has been used by the kernel, add_memory()
> -- 
> 2.16.3

-- 
Michal Hocko
SUSE Labs
