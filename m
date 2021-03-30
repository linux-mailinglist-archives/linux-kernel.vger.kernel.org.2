Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6006534E6E5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhC3Lvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:51:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42032 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhC3Lv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:51:27 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lRCu5-0000CA-Sx; Tue, 30 Mar 2021 11:51:25 +0000
Subject: Re: [PATCH] mm/page_alloc: Add a bulk page allocator -fix -fix
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20210330114847.GX3697@techsingularity.net>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <f02d1024-5201-a065-5815-4216b5d0fe1f@canonical.com>
Date:   Tue, 30 Mar 2021 12:51:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210330114847.GX3697@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2021 12:48, Mel Gorman wrote:
> Colin Ian King reported the following problem (slightly edited)
> 
> 	Author: Mel Gorman <mgorman@techsingularity.net>
> 	Date:   Mon Mar 29 11:12:24 2021 +1100
> 
> 	    mm/page_alloc: add a bulk page allocator
> 
> 	...
> 
> 	Static analysis on linux-next with Coverity has found a potential
> 	uninitialized variable issue in function __alloc_pages_bulk with
> 	the following commit:
> 
> 	...
> 
> 	    Uninitialized scalar variable (UNINIT)
> 	    15. uninit_use_in_call: Using uninitialized value alloc_flags when
> 	        calling prepare_alloc_pages.
> 
> 	5056        if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask,
> 						&ac, &alloc_gfp, &alloc_flags))
> 
> The problem is that prepare_alloc_flags only updates alloc_flags
> which must have a valid initial value. The appropriate initial value is
> ALLOC_WMARK_LOW to avoid the bulk allocator pushing a zone below the low
> watermark without waking kswapd assuming the GFP mask allows kswapd to
> be woken.
> 
> This is a second fix to the mmotm patch
> mm-page_alloc-add-a-bulk-page-allocator.patch . It will cause a mild conflict
> with a later patch due to renaming of an adjacent variable that is trivially
> resolved. I can post a full series with the fixes merged if that is preferred.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 92d55f80c289..dabef0b910c9 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4990,7 +4990,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  	struct list_head *pcp_list;
>  	struct alloc_context ac;
>  	gfp_t alloc_gfp;
> -	unsigned int alloc_flags;
> +	unsigned int alloc_flags = ALLOC_WMARK_LOW;
>  	int allocated = 0;
>  
>  	if (WARN_ON_ONCE(nr_pages <= 0))
> 

Thanks Mel, that definitely fixes the issue.

Reviewed-by: Colin Ian King <colin.king@canonical.com>
