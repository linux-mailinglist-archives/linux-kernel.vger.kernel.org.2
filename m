Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822D839A15C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhFCMrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:47:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50326 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhFCMq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:46:59 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CA0971FD3D;
        Thu,  3 Jun 2021 12:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622724313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZcX19m7FEU1QXRE/lXUIHIQnF4aGZcVkJ8dPzSfOcoA=;
        b=jF25zSqLiEz7CRyAvUR8n7UFywd4oK2hTERgX2HjI+bp+19TdlSBAivRmnD6DQzjWbsWO8
        D7d7rfSKmsUc0o8Xbam6UegpsKDsMWAUg9uYp+FcNd8KuE4upEJfYnR1ypE/zcN1PoVnqs
        tvwmI3DiNWHYpvh2oMb113O7oxgL6bw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7F635A3B8F;
        Thu,  3 Jun 2021 12:45:13 +0000 (UTC)
Date:   Thu, 3 Jun 2021 14:45:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm,page_alloc: Use {get,put}_online_mems() to get
 stable zone's values
Message-ID: <YLjO2YU2G5fTVB3x@dhcp22.suse.cz>
References: <20210602091457.17772-1-osalvador@suse.de>
 <20210602091457.17772-2-osalvador@suse.de>
 <39473305-6e91-262d-bcc2-76b745a5b14a@redhat.com>
 <ed17a39ad61edeb19b04c0f4308d5d36@suse.de>
 <YLiVAAsCTR7B6Db9@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLiVAAsCTR7B6Db9@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03-06-21 10:38:24, Oscar Salvador wrote:
> On Wed, Jun 02, 2021 at 09:45:58PM +0200, Oscar Salvador wrote:
> > It was too nice and easy to be true I guess.
> > Yeah, I missed the point that blocking might be an issue here, and hotplug
> > operations can take really long, so not an option.
> > I must have switched my brain off back there, because now it is just too
> > obvious.
> > 
> > Then I guwmess that seqlock must stay and the only thing than can go is the
> > pgdat resize lock from the hotplug code.
> 
> So, I have been looking into this again.
> Of course, the approach taken here is outrageously wrong, but there are
> some other things that are a bit confusing.
> 
> As pointed out, bad_range() (the function that ends up calling
> page_outside_zone_boundaries) is called from different functions via VM_BUG_ON_*.
> page_outside_zone_boundaries() takes care of taking the seqlock to avoid
> reading stale values that might happen if we race with memhotplug
> operations.
> page_outside_zone_boundaries() calls zone_spans_pfn() to check that.
>  
> Now on the funny thing.
> 
> We do have several places happily calling zone_spans_pfn() without
> holding zone's seqlock, e.g:
> 
> set_pageblock_migratetype
>  set_pfnblock_flags_mask
>   zone_spans_pfn
> 
> move_freepages_block
>  zone_spans_pfn
> 
> alloc_contig_pages
>  zone_spans_last_pfn
>   zone_spans_pfn
> 
> Those places hold zone->lock, while move_pfn_range_to_zone() and
> remove_pfn_range_from_zone() hold zone->seqlock, so AFAICS, those places
> could read a stale value and proceed thinking the range is within the
> zone while it is not.
> 
> So I guess my question is, should we force those places to take the
> seqlock reader as we do in page_outside_zone_boundaries(), (or maybe
> just move the seqlock handling to zone_spans_pfn())?

I believe we need to define the purpose of the locking first. The
existing locking doesn't serve much purpose, does it? The state might
change right after the lock is released and the caller cannot really
rely on the result. So aside of the current implementation, I would
argue that any locking has to be be done on the caller layer.

But the primary question is whether anybody actually cares about
potential races in the first place.
-- 
Michal Hocko
SUSE Labs
