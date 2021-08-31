Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2243FC559
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 12:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240819AbhHaKAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 06:00:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53658 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240576AbhHaKAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 06:00:05 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0AC6C221D5;
        Tue, 31 Aug 2021 09:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630403950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WiP8R2FARUsYFRgyybzZXk+qgD0ErxdUL7/x1nn4EHc=;
        b=jGmRKaHjiB0LJjuSUiCQxNuc0IQU6ggQnRYlQc5lU2gNvcToeTo/ZDpq3fDTJFmiy61YsT
        fd/IuOQXQx5ZTYzw/1yiGDfqlhwZcClL4HqECu10DBBA/ljjUOk8Wk0ByScFt0RA5WFzBy
        EBlts6L764k93fDF645Tw7QRW/j4dFk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E91A4A3B95;
        Tue, 31 Aug 2021 09:59:08 +0000 (UTC)
Date:   Tue, 31 Aug 2021 11:59:05 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        stable@kernel.org, Chris Down <chris@chrisdown.name>
Subject: Re: [PATCH] mm,vmscan: fix divide by zero in get_scan_count
Message-ID: <YS39aci6yhjIplLx@dhcp22.suse.cz>
References: <20210826220149.058089c6@imladris.surriel.com>
 <YS1EA3U4XXH7X0qz@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS1EA3U4XXH7X0qz@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30-08-21 16:48:03, Johannes Weiner wrote:
> On Thu, Aug 26, 2021 at 10:01:49PM -0400, Rik van Riel wrote:
[...]
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index eeae2f6bc532..f1782b816c98 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2592,7 +2592,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
> >  			cgroup_size = max(cgroup_size, protection);
> >  
> >  			scan = lruvec_size - lruvec_size * protection /
> > -				cgroup_size;
> > +				(cgroup_size + 1);
> 
> I have no overly strong preferences, but if Michal prefers max(), how about:
> 
> 	cgroup_size = max3(cgroup_size, protection, 1);

Yes this is better.

> Or go back to not taking the branch in the first place when there is
> no protection in effect...
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 6247f6f4469a..9c200bb3ae51 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2547,7 +2547,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>  		mem_cgroup_protection(sc->target_mem_cgroup, memcg,
>  				      &min, &low);
>  
> -		if (min || low) {
> +		if (min || (!sc->memcg_low_reclaim && low)) {
>  			/*
>  			 * Scale a cgroup's reclaim pressure by proportioning
>  			 * its current usage to its memory.low or memory.min

This is slightly more complex to read but it is also better than +1
trick.

Either of the two work for me.

-- 
Michal Hocko
SUSE Labs
