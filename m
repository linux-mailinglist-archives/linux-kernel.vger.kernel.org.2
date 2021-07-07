Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0813BE563
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhGGJPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:15:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54618 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhGGJPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:15:39 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CC2AA225C9;
        Wed,  7 Jul 2021 09:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625649178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JoKp/ueTWTvINDzusVwgf6ql4EB0CbzpyJO64PWxFeU=;
        b=OnDAjMxETxRzwi5mlwAecuiQGm4eHjTJLy8SrG59l1aU5rbVFCrc+VpJiVH3QiFH/KNE1m
        FfciId9+Iwm6J5RgWkXnch3U5wxFHNAAnro2ejqRN2u3sDjNw/gaMKmvLRriSc+3oZRO16
        R7XRfpY8UhOfYmS+K2YHKDvjeo16lgg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A4880A3B9A;
        Wed,  7 Jul 2021 09:12:58 +0000 (UTC)
Date:   Wed, 7 Jul 2021 11:12:57 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Ohhoon Kwon <ohoono.kwon@samsung.com>
Cc:     david@redhat.com, akpm@linux-foundation.org, bhe@redhat.com,
        rppt@linux.ibm.com, ohkwon1043@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm: sparse: pass section_nr to
 section_mark_present
Message-ID: <YOVwGf8XvEIXScoo@dhcp22.suse.cz>
References: <20210705085538.14557-1-ohoono.kwon@samsung.com>
 <CGME20210705085918epcas1p17e0ac84d91c591897d00fbc3d3caa771@epcas1p1.samsung.com>
 <20210705085538.14557-2-ohoono.kwon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705085538.14557-2-ohoono.kwon@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-07-21 17:55:36, Ohhoon Kwon wrote:
> With CONFIG_SPARSEMEM_EXTREME enabled, __section_nr() which converts
> mem_section to section_nr could be costly since it iterates all
> section roots to check if the given mem_section is in its range.
> 
> On the other hand, __nr_to_section() which converts section_nr to
> mem_section can be done in O(1).
> 
> Let's pass section_nr instead of mem_section ptr to
> section_mark_present() in order to reduce needless iterations.
> 
> Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/sparse.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 6326cdf36c4f..b4fae2fc6276 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -187,13 +187,14 @@ void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
>   * those loops early.
>   */
>  unsigned long __highest_present_section_nr;
> -static void section_mark_present(struct mem_section *ms)
> +static void section_mark_present(unsigned long section_nr)
>  {
> -	unsigned long section_nr = __section_nr(ms);
> +	struct mem_section *ms;
>  
>  	if (section_nr > __highest_present_section_nr)
>  		__highest_present_section_nr = section_nr;
>  
> +	ms = __nr_to_section(section_nr);
>  	ms->section_mem_map |= SECTION_MARKED_PRESENT;

Can you add the ms parameter here so that we get rid of the pointless
__nr_to_section as suggested in the previous review feedback?
-- 
Michal Hocko
SUSE Labs
