Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC41631E8A0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 11:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhBRKK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 05:10:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:44214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231261AbhBRI5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:57:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613638579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8RAszh7yrqFMBVVaDFUSTwmQ6Tv/ON0s4M9Tz9qKwYg=;
        b=VeKsaAxMxonW/fD/t12Ia80ScMOR6LGjZl7eGItzFNo4Yxu2+IDqnAMrfmw/FiXSEbHM3f
        HXfyeiLxxftUjGZRFMCg1ZCaP3LQ1lj+pif3w2fU6YWXwOLXZk9U1HHbsqhKLtpmujbkIK
        1GzcAD728DMOsM6asbmcgSVMLoSjEzY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 740FFAD87;
        Thu, 18 Feb 2021 08:56:19 +0000 (UTC)
Date:   Thu, 18 Feb 2021 09:56:18 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, david@redhat.com,
        joaodias@google.com
Subject: Re: [PATCH] mm: be more verbose for alloc_contig_range faliures
Message-ID: <YC4rsr9zkNAvdL4T@dhcp22.suse.cz>
References: <20210217163603.429062-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217163603.429062-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-02-21 08:36:03, Minchan Kim wrote:
> alloc_contig_range is usually used on cma area or movable zone.
> It's critical if the page migration fails on those areas so
> dump more debugging message like memory_hotplug unless user
> specifiy __GFP_NOWARN.

I agree with David that this has a potential to generate a lot of output
and it is not really clear whether it is worth it. Page isolation code
already has REPORT_FAILURE mode which currently used only for the memory
hotplug because this was just too noisy from the CMA path - d381c54760dc
("mm: only report isolation failures when offlining memory").

Maybe migration failures are less likely to fail but still. Doesn't CMA
allocator provide some useful error reporting on its own?

[...]
> @@ -8736,8 +8747,11 @@ struct page *alloc_contig_pages(unsigned long nr_pages, gfp_t gfp_mask,
>  				 * and cause alloc_contig_range() to fail...
>  				 */
>  				spin_unlock_irqrestore(&zone->lock, flags);
> +
> +				if (zone_idx(zone) != ZONE_MOVABLE)
> +					gfp_flags = gfp_mask | __GFP_NOWARN;

Nack to this. Caller shouldn't tweak gfp mask of the caller. If we
really want to control the reporting based on __GFP_NOWARN or a lack of
it then this has to be under control of the caller.

>  				ret = __alloc_contig_pages(pfn, nr_pages,
> -							gfp_mask);
> +							gfp_flags);
>  				if (!ret)
>  					return pfn_to_page(pfn);
>  				spin_lock_irqsave(&zone->lock, flags);
> -- 
> 2.30.0.478.g8a0d178c01-goog
> 

-- 
Michal Hocko
SUSE Labs
