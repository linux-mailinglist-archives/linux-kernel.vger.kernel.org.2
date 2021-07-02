Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6B43BA03D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhGBMUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:20:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38140 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhGBMUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:20:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6D10422983;
        Fri,  2 Jul 2021 12:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625228250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AVHSMXF0Qe6z5X1aYrWSnwSZI6rHsSpkp/txd0qcOcc=;
        b=JDsyaSelsP4XpNfIqBErJjN0khgCMBMHw/VEE0FpP3myQtmjEEuYRvWDmEjHUVV3FbGgic
        kBQJAi//EsEKblNipEulzeWrOHmja7sbTd0ph7SXrB+rDP6vNIBCw+OqRm13VhJoWmMhhl
        RQGlA1UDPPMiMPFxMOMbXbxb0m4V9Cg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2FCB1A3B87;
        Fri,  2 Jul 2021 12:17:30 +0000 (UTC)
Date:   Fri, 2 Jul 2021 14:17:28 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Ohhoon Kwon <ohoono.kwon@samsung.com>
Cc:     david@redhat.com, akpm@linux-foundation.org, bhe@redhat.com,
        rppt@linux.ibm.com, ohkwon1043@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: sparse: pass section_nr to find_memory_block
Message-ID: <YN8D2JcxcBDxSucE@dhcp22.suse.cz>
References: <20210702094132.6276-1-ohoono.kwon@samsung.com>
 <CGME20210702094457epcas1p40fba85e22861cf1cc85a085719030c24@epcas1p4.samsung.com>
 <20210702094132.6276-3-ohoono.kwon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702094132.6276-3-ohoono.kwon@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-07-21 18:41:31, Ohhoon Kwon wrote:
> With CONFIG_SPARSEMEM_EXTREME enabled, __section_nr() which converts
> mem_section to section_nr could be costly since it iterates all
> section roots to check if the given mem_section is in its range.
> 
> On the other hand, __nr_to_section() which converts section_nr to
> mem_section can be done in O(1).
> 
> Let's pass section_nr instead of mem_section ptr to
> find_memory_block() in order to reduce needless iterations.

Yeah, it seems like the only existing user (maybe there used to be more
in the past - haven't checked) is just doing pointless translation to
comply with the API that doesn't fit it. Just to undo all that work
in find_memory_block 

Nice cleanup and potentially even a performance improvement!
 
> Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/powerpc/platforms/pseries/hotplug-memory.c | 4 +---
>  drivers/base/memory.c                           | 4 ++--
>  include/linux/memory.h                          | 2 +-
>  3 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 8377f1f7c78e..905790092e0e 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -211,13 +211,11 @@ static int update_lmb_associativity_index(struct drmem_lmb *lmb)
>  static struct memory_block *lmb_to_memblock(struct drmem_lmb *lmb)
>  {
>  	unsigned long section_nr;
> -	struct mem_section *mem_sect;
>  	struct memory_block *mem_block;
>  
>  	section_nr = pfn_to_section_nr(PFN_DOWN(lmb->base_addr));
> -	mem_sect = __nr_to_section(section_nr);
>  
> -	mem_block = find_memory_block(mem_sect);
> +	mem_block = find_memory_block(section_nr);
>  	return mem_block;
>  }
>  
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index d5ffaab3cb61..e31598955cc4 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -578,9 +578,9 @@ static struct memory_block *find_memory_block_by_id(unsigned long block_id)
>  /*
>   * Called under device_hotplug_lock.
>   */
> -struct memory_block *find_memory_block(struct mem_section *section)
> +struct memory_block *find_memory_block(unsigned long section_nr)
>  {
> -	unsigned long block_id = memory_block_id(__section_nr(section));
> +	unsigned long block_id = memory_block_id(section_nr);
>  
>  	return find_memory_block_by_id(block_id);
>  }
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index 97e92e8b556a..d9a0b61cd432 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -90,7 +90,7 @@ int create_memory_block_devices(unsigned long start, unsigned long size,
>  void remove_memory_block_devices(unsigned long start, unsigned long size);
>  extern void memory_dev_init(void);
>  extern int memory_notify(unsigned long val, void *v);
> -extern struct memory_block *find_memory_block(struct mem_section *);
> +extern struct memory_block *find_memory_block(unsigned long section_nr);
>  typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void *);
>  extern int walk_memory_blocks(unsigned long start, unsigned long size,
>  			      void *arg, walk_memory_blocks_func_t func);
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
