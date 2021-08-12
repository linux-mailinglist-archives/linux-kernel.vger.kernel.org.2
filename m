Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53A33EA06C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 10:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbhHLIRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 04:17:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45446 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbhHLIRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 04:17:37 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0B78A221F8;
        Thu, 12 Aug 2021 08:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628756229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XhUBbQGoB6p8bEf2qX/5QpELujZexaxBGuC5JTzfSDM=;
        b=MbGR9PmPkpqmBlcQWHETfLfu3OX7aehs5QhGzYXN+gttgruCc3jw+hRzGD/GApL6AAHS6j
        9emlMqHGYehsZNituVpp24WTEIRThfzcdblZeR3FLSD+msUWjXQIa5RwoNVf6dD7v9+CVn
        OyXzKJ64BAnUupnp6v4ax7i0JCovr9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628756229;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XhUBbQGoB6p8bEf2qX/5QpELujZexaxBGuC5JTzfSDM=;
        b=bIM75yupX0YZsrTG7vsDfKYUhff83BKuiRr7b3LtlCN6LFBrNa7pyBH1yfqT0yJh9KutPI
        lPYtGqDWcmVCngCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D09CB13846;
        Thu, 12 Aug 2021 08:17:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id p2wpMgTZFGHQCAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 08:17:08 +0000
Subject: Re: [PATCH] mm/page_alloc: don't corrupt pcppage_migratetype
To:     Doug Berger <opendmb@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210811182917.2607994-1-opendmb@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e9393682-5429-448a-d151-a3ee05216499@suse.cz>
Date:   Thu, 12 Aug 2021 10:17:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811182917.2607994-1-opendmb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 8:29 PM, Doug Berger wrote:
> When placing pages on a pcp list, migratetype values over
> MIGRATE_PCPTYPES get added to the MIGRATE_MOVABLE pcp list.
> 
> However, the actual migratetype is preserved in the page and
> should not be changed to MIGRATE_MOVABLE or the page may end
> up on the wrong free_list.

Nice, how did you find out? Were there any user-visible effects? (Hint: which?
the changelog should say that so that the severity of the bug can be judged).
Otherwise I agree the bug is there and patch is fixing it. Thanks.

> Fixes: df1acc856923 ("mm/page_alloc: avoid conflating IRQs disabled with zone->lock")
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 73704e836649..8addb4919f75 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3436,19 +3436,10 @@ void free_unref_page_list(struct list_head *list)
>  		 * comment in free_unref_page.
>  		 */
>  		migratetype = get_pcppage_migratetype(page);
> -		if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
> -			if (unlikely(is_migrate_isolate(migratetype))) {
> -				list_del(&page->lru);
> -				free_one_page(page_zone(page), page, pfn, 0,
> -							migratetype, FPI_NONE);
> -				continue;
> -			}
> -
> -			/*
> -			 * Non-isolated types over MIGRATE_PCPTYPES get added
> -			 * to the MIGRATE_MOVABLE pcp list.
> -			 */
> -			set_pcppage_migratetype(page, MIGRATE_MOVABLE);
> +		if (unlikely(is_migrate_isolate(migratetype))) {
> +			list_del(&page->lru);
> +			free_one_page(page_zone(page), page, pfn, 0, migratetype, FPI_NONE);
> +			continue;
>  		}
>  
>  		set_page_private(page, pfn);
> @@ -3458,7 +3449,15 @@ void free_unref_page_list(struct list_head *list)
>  	list_for_each_entry_safe(page, next, list, lru) {
>  		pfn = page_private(page);
>  		set_page_private(page, 0);
> +
> +		/*
> +		 * Non-isolated types over MIGRATE_PCPTYPES get added
> +		 * to the MIGRATE_MOVABLE pcp list.
> +		 */
>  		migratetype = get_pcppage_migratetype(page);
> +		if (unlikely(migratetype >= MIGRATE_PCPTYPES))
> +			migratetype = MIGRATE_MOVABLE;
> +
>  		trace_mm_page_free_batched(page);
>  		free_unref_page_commit(page, pfn, migratetype, 0);
>  
> 

