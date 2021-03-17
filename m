Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026BD33F23B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhCQOGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:06:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:41784 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231770AbhCQOF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:05:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615989956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cIltC9g3eI67AJ6l+RPM3xTSrdo/DzkDrTkj42+kPZI=;
        b=IwirpRnNtZ039Az7dJVxJaJ53Qk+nMsIIr+VfDUJxpVTVbOmuhulHKuLZOBXPZjwuf+fIC
        yeS0SNi/OxxZof6fMbDpxLHIj45y0xC/PMPGgcuXTOn+/r2qMKh2oLtCRsmXdiSBnqNEWp
        yDLyZ6nM2ufCYPk4G7Xdlb33V2MuiIw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A21ABAC47;
        Wed, 17 Mar 2021 14:05:56 +0000 (UTC)
Date:   Wed, 17 Mar 2021 15:05:40 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] mm,page_alloc: Bail out earlier on -ENOMEM in
 alloc_contig_migrate_range
Message-ID: <YFIMtFu/g3jtGqA8@dhcp22.suse.cz>
References: <20210317111251.17808-1-osalvador@suse.de>
 <20210317111251.17808-2-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317111251.17808-2-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-03-21 12:12:47, Oscar Salvador wrote:
> Currently, __alloc_contig_migrate_range can generate -EINTR, -ENOMEM or -EBUSY,
> and report them down the chain.
> The problem is that when migrate_pages() reports -ENOMEM, we keep going till we
> exhaust all the try-attempts (5 at the moment) instead of bailing out.
> 
> migrate_pages() bails out right away on -ENOMEM because it is considered a fatal
> error. Do the same here instead of keep going and retrying.

I suspect this is not really a real life problem, right? The allocation
would be more costly in the end but this is to be expected under a heavy
memory pressure.

That being said, bailing out early makes sense to me. But now that
you've made me look into the migrate_pages excellent error state reporting
I suspect we have a bug here. Note the 
"Returns the number of pages that were not migrated, or an error code."

but I do not see putback_movable_pages for ret > 0 so it seems we might
leak some pages.

That aside. Now looking at other callers of migrate_pages most of them
do not care about the number of failed pages. The only one which cares
is migrate_pages syscall (do_migrate_pages). I think it would be much
more reasonable to have migrate_pages (kernel function) return error or
0 and make the only caller which cares to count number of failed pages
(e.g. by returning the number of pages from putback_movable_pages).
 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: David Hildenbrand <david@redhat.com>

The patch itself looks reasonable but make sure to mention this is mere
cosmetic change unless there is a real problem fixed by this.
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cfc72873961d..a4f67063b85f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8481,7 +8481,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>  			}
>  			tries = 0;
>  		} else if (++tries == 5) {
> -			ret = ret < 0 ? ret : -EBUSY;
> +			ret = -EBUSY;
>  			break;
>  		}
>  
> @@ -8491,6 +8491,12 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>  
>  		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
>  				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
> +		/*
> +		 * On -ENOMEM, migrate_pages() bails out right away. It is pointless
> +		 * to retry again over this error, so do the same here.
> +		 */
> +		if (ret == -ENOMEM)
> +			break;
>  	}
>  	if (ret < 0) {
>  		putback_movable_pages(&cc->migratepages);
> -- 
> 2.16.3

-- 
Michal Hocko
SUSE Labs
