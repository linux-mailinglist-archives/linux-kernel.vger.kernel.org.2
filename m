Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328C23FBD97
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 22:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbhH3UrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 16:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhH3UrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 16:47:12 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56A5C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 13:46:17 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id l4so9108108qvl.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0pH8PpB5hRL0OIS0gYNC1zy+deykfUSq1lsoYqQwCuk=;
        b=P6vrQqD/yhdsLPcZ5aGOHX4wuGa0FHILa+hIjGDnI76PBMAAEggZdpfH+smLsaWsf3
         j/ZSkZ+gU27/mSVxuPWWw5UfazmBBnsDrrJgbwohYdBGLSTEq2LIqbQExtCKTC/8YuNk
         BaykjXWWW1d1Sj4E/CPaayPEfGuDLBX6rnb0bybrdvBmpj6QU/aXgtpkUthfcRJUyOFC
         WmdnXEG7YvVuFy3P7+H+MsqmLtTHI5k8AtV476eIP3JS/JxV8mEvwJ2gOM2A1jj1B4lX
         WA1LRPjEVYaNCRN7W78bL3CAHzBwNSO2Tfpx87AQQb/76Xb0uTcv+kzxNQGmbPiaZ+00
         n40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0pH8PpB5hRL0OIS0gYNC1zy+deykfUSq1lsoYqQwCuk=;
        b=Bf8eUqFXNGR3aHdojxIVhH4i50O6Renq9O3k5tBLHJvHvJALJyM0yGNwAwEqzt3t8g
         hSS/ULev+/nhnjDL8mfP23yII9yxRjYoyN//GFeNerAIHSiv8flfEiKfrn3YPW3zMAFY
         JpKqlaFlclIKjfIIcpu1rOFMJsLipVLHkDJ06JbiOfEFbVnNfr3f9WbTCIEC1ZkyFWEV
         byTu5CYhzwAWMO0utXcfaJt2jaL+jKdkaXgiWT+n9zQPMsXlabKra9tds1s6vIdTCRCn
         3qXXxg9tiJ8jxBDi4rwMYQn2WKxInLZElcHp0OM3FTdJuTcu1h/pBFm+ceanEquqxV9O
         ifjg==
X-Gm-Message-State: AOAM533Ok2XvinHrMdLFH9fALIaxzfca2WKeEP31ktKg/m240VPLz3pB
        ux2XbS7hEe/IsWYtMqNjT9LS2w==
X-Google-Smtp-Source: ABdhPJwXkK+L51++yr7RM8pfNjFd4a3l9YJECfFVcwm5mFyXsdyoIfpnsPwInPzhRFXrfbg5ltm2MA==
X-Received: by 2002:a0c:b356:: with SMTP id a22mr25367456qvf.7.1630356376930;
        Mon, 30 Aug 2021 13:46:16 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id b15sm11962348qka.107.2021.08.30.13.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 13:46:16 -0700 (PDT)
Date:   Mon, 30 Aug 2021 16:48:03 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        stable@kernel.org, Michal Hocko <mhocko@suse.com>,
        Chris Down <chris@chrisdown.name>
Subject: Re: [PATCH] mm,vmscan: fix divide by zero in get_scan_count
Message-ID: <YS1EA3U4XXH7X0qz@cmpxchg.org>
References: <20210826220149.058089c6@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826220149.058089c6@imladris.surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 10:01:49PM -0400, Rik van Riel wrote:
> Changeset f56ce412a59d ("mm: memcontrol: fix occasional OOMs due to
> proportional memory.low reclaim") introduced a divide by zero corner
> case when oomd is being used in combination with cgroup memory.low
> protection.
> 
> When oomd decides to kill a cgroup, it will force the cgroup memory
> to be reclaimed after killing the tasks, by writing to the memory.max
> file for that cgroup, forcing the remaining page cache and reclaimable
> slab to be reclaimed down to zero.
> 
> Previously, on cgroups with some memory.low protection that would result
> in the memory being reclaimed down to the memory.low limit, or likely not
> at all, having the page cache reclaimed asynchronously later.
> 
> With f56ce412a59d the oomd write to memory.max tries to reclaim all the
> way down to zero, which may race with another reclaimer, to the point of
> ending up with the divide by zero below.
> 
> This patch implements the obvious fix.
> 
> Fixes: f56ce412a59d ("mm: memcontrol: fix occasional OOMs due to proportional memory.low reclaim")
> Signed-off-by: Rik van Riel <riel@surriel.com>

That took me a second.

Before the patch, that sc->memcg_low_reclaim test was outside of that
whole proportional reclaim branch. So if we were in low reclaim mode
we wouldn't even check if a low setting is in place; if min is zero,
we don't enter the proportional branch.

Now we enter if low is set but ignored, and then end up with
cgroup_size == min == 0 == divide by black hole.

Good catch.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index eeae2f6bc532..f1782b816c98 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2592,7 +2592,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>  			cgroup_size = max(cgroup_size, protection);
>  
>  			scan = lruvec_size - lruvec_size * protection /
> -				cgroup_size;
> +				(cgroup_size + 1);

I have no overly strong preferences, but if Michal prefers max(), how about:

	cgroup_size = max3(cgroup_size, protection, 1);

Or go back to not taking the branch in the first place when there is
no protection in effect...

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6247f6f4469a..9c200bb3ae51 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2547,7 +2547,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 		mem_cgroup_protection(sc->target_mem_cgroup, memcg,
 				      &min, &low);
 
-		if (min || low) {
+		if (min || (!sc->memcg_low_reclaim && low)) {
 			/*
 			 * Scale a cgroup's reclaim pressure by proportioning
 			 * its current usage to its memory.low or memory.min
