Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFA643C3BE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 09:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240431AbhJ0HXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 03:23:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35626 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbhJ0HXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 03:23:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B8DE2218B5;
        Wed, 27 Oct 2021 07:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1635319235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VFQpljpbCgLk+sF7MhiBXlFbEtTZaQ7ckeAcxQinKmk=;
        b=DKwrb7hT4Qg7y1F21w3bh2bfW9jeUm84vVnpTLTHDQZBYl4Rxg7mrjPSDIvXqsbYeC4NKw
        Rrwn8Gmi/xyBlNlXR2h7YA64uTd/gP3DA2LfBJyoD45O3C1VHcInRWNw1Yj1EkS9yqk6dp
        WBbMCtDbPpNEOjE5L0eiaAteZz8U/oY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 676D4A3B84;
        Wed, 27 Oct 2021 07:20:35 +0000 (UTC)
Date:   Wed, 27 Oct 2021 09:20:35 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: have kswapd only reclaiming use min protection
 on memcg
Message-ID: <YXj9w+8Bwlkz5PRy@dhcp22.suse.cz>
References: <1635318110-1905-1-git-send-email-huangzhaoyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635318110-1905-1-git-send-email-huangzhaoyang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-10-21 15:01:50, Huangzhaoyang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> For the kswapd only reclaiming, there is no chance to try again on
> this group while direct reclaim has. fix it by judging gfp flag.

There is no problem description (same as in your last submissions. Have
you looked at the patch submission documentation as recommended
previously?).

Also this patch doesn't make any sense. Both direct reclaim and kswapd
use a gfp mask which contains __GFP_DIRECT_RECLAIM (see balance_pgdat
for the kswapd part)..

> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Nacked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/vmscan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 74296c2..41f5776 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2704,7 +2704,8 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>  			unsigned long protection;
>  
>  			/* memory.low scaling, make sure we retry before OOM */
> -			if (!sc->memcg_low_reclaim && low > min) {
> +			if (!sc->memcg_low_reclaim && low > min
> +				&& sc->gfp_mask & __GFP_DIRECT_RECLAIM) {
>  				protection = low;
>  				sc->memcg_low_skipped = 1;
>  			} else {
> -- 
> 1.9.1

-- 
Michal Hocko
SUSE Labs
