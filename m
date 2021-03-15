Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD45433B086
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhCOLBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 07:01:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:33626 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhCOLAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:00:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E05AAAE3C;
        Mon, 15 Mar 2021 11:00:41 +0000 (UTC)
Subject: Re: [PATCH v4 1/4] mm,page_alloc: Bail out earlier on -ENOMEM in
 alloc_contig_migrate_range
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210310150853.13541-1-osalvador@suse.de>
 <20210310150853.13541-2-osalvador@suse.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <bd60e2e2-3683-69a4-a922-20a446bac61f@suse.cz>
Date:   Mon, 15 Mar 2021 12:00:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210310150853.13541-2-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/21 4:08 PM, Oscar Salvador wrote:
> Currently, __alloc_contig_migrate_range can generate -EINTR, -ENOMEM or -EBUSY,
> and report them down the chain.
> The problem is that when migrate_pages() reports -ENOMEM, we keep going till we
> exhaust all the try-attempts (5 at the moment) instead of bailing out.
> 
> migrate_pages bails out right away on -ENOMEM because it is considered a fatal
> error. Do the same here instead of keep going and retrying.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3e4b29ee2b1e..94467f1b85ff 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8484,7 +8484,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>  			}
>  			tries = 0;
>  		} else if (++tries == 5) {
> -			ret = ret < 0 ? ret : -EBUSY;
> +			ret = -EBUSY;
>  			break;
>  		}
>  
> @@ -8494,6 +8494,12 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
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
> 

