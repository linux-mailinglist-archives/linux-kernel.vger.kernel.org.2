Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1653570F6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353851AbhDGPuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:50:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:36838 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353907AbhDGPt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:49:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA294B178;
        Wed,  7 Apr 2021 15:49:14 +0000 (UTC)
Subject: Re: [PATCH] mm: page_owner: fetch backtrace only for tracked pages
To:     Sergei Trofimovich <slyfox@gentoo.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210401212445.3534721-1-slyfox@gentoo.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <0c18e497-07d1-887f-e49e-b6315f396ab8@suse.cz>
Date:   Wed, 7 Apr 2021 17:49:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210401212445.3534721-1-slyfox@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/21 11:24 PM, Sergei Trofimovich wrote:
> Very minor optimization.

I'm not entirely sure about accuracy of "only for tracked pages". Missing
page_ext is something I'm not even sure how possible it is in practice, probably
just an error condition (failed to be allocated?). Or did you observe this in
practice? But anyway, the change is not wrong.

> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: linux-mm@kvack.org
> Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_owner.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 63e4ecaba97b..7147fd34a948 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -140,14 +140,14 @@ void __reset_page_owner(struct page *page, unsigned int order)
>  {
>  	int i;
>  	struct page_ext *page_ext;
> -	depot_stack_handle_t handle = 0;
> +	depot_stack_handle_t handle;
>  	struct page_owner *page_owner;
>  
> -	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
> -
>  	page_ext = lookup_page_ext(page);
>  	if (unlikely(!page_ext))
>  		return;
> +
> +	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
>  	for (i = 0; i < (1 << order); i++) {
>  		__clear_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
>  		page_owner = get_page_owner(page_ext);
> 

