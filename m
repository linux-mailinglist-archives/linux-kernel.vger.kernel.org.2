Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A5A31A3BE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 18:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhBLRi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 12:38:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:34364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhBLRiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 12:38:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7C549AD19;
        Fri, 12 Feb 2021 17:38:13 +0000 (UTC)
Subject: Re: [PATCH V2] mm: compaction: update the COMPACT[STALL|FAIL] events
 properly
To:     Charan Teja Reddy <charante@codeaurora.org>,
        akpm@linux-foundation.org, rientjes@google.com, linux-mm@kvack.org
Cc:     vinmenon@codeaurora.org, linux-kernel@vger.kernel.org
References: <1613151184-21213-1-git-send-email-charante@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <9d12dc04-9cf0-8dd1-5fb3-9a5f8e34d23f@suse.cz>
Date:   Fri, 12 Feb 2021 18:38:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1613151184-21213-1-git-send-email-charante@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/21 6:33 PM, Charan Teja Reddy wrote:
> By definition, COMPACT[STALL|FAIL] events needs to be counted when there
> is 'At least in one zone compaction wasn't deferred or skipped from the
> direct compaction'. And when compaction is skipped or deferred,
> COMPACT_SKIPPED will be returned but it will still go and update these
> compaction events which is wrong in the sense that COMPACT[STALL|FAIL]
> is counted without even trying the compaction.
> 
> Correct this by skipping the counting of these events when
> COMPACT_SKIPPED is returned for compaction. This indirectly also avoid
> the unnecessary try into the get_page_from_freelist() when compaction is
> not even tried.
> 
> There is a corner case where compaction is skipped but still count
> COMPACTSTALL event, which is that IRQ came and freed the page and the
> same is captured in capture_control.
> 
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Thanks!

> ---
> 
> changes in V1: https://lore.kernel.org/patchwork/patch/1373665/
> 
>  mm/compaction.c | 8 ++++++++
>  mm/page_alloc.c | 2 ++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 190ccda..104ebef 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2487,6 +2487,14 @@ static enum compact_result compact_zone_order(struct zone *zone, int order,
>  	 */
>  	WRITE_ONCE(current->capture_control, NULL);
>  	*capture = READ_ONCE(capc.page);
> +	/*
> +	 * Technically, it is also possible that compaction is skipped but
> +	 * the page is still captured out of luck(IRQ came and freed the page).
> +	 * Returning COMPACT_SUCCESS in such cases helps in properly accounting
> +	 * the COMPACT[STALL|FAIL] when compaction is skipped.
> +	 */
> +	if (*capture)
> +		ret = COMPACT_SUCCESS;
>  
>  	return ret;
>  }
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 519a60d..531f244 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4152,6 +4152,8 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
>  	memalloc_noreclaim_restore(noreclaim_flag);
>  	psi_memstall_leave(&pflags);
>  
> +	if (*compact_result == COMPACT_SKIPPED)
> +		return NULL;
>  	/*
>  	 * At least in one zone compaction wasn't deferred or skipped, so let's
>  	 * count a compaction stall
> 

