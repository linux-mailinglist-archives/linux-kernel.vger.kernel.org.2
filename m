Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF2330F5F7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 16:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237113AbhBDPQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236977AbhBDPOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:14:53 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40230C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 07:14:12 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id l11so1866825qvt.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 07:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rSIFYGhhFddePwX4nFIG//fqjMTXGZtm1TOG4qBhrCg=;
        b=pUezDEZQ4njLOWPSWqusqTJWSM+RIcwjXnsGMScZPcUpPTHTLLB1LC6j3HQ+NUylpm
         ce8EnFUHaNH7LO9bmQ6KqtQgQgDiECYrr+oucQSZcgmN/7gQ4qzoiKP7fxpHvrGZDA7X
         pwpDgvyVTB0QbFuQOArsSuWeibbvA6gJ90GxJyQQ/4a57SykMlMsFMxHY9huq1qYDGHY
         1cNeyEnMtrXDJZeswRiBim85+PxB64GJmwA+kZeTJHPsT2NUaIyj7CgvoKXGrF9o6PKn
         8iSr36F2vrztBPbao/2Uf1mmJyichJKkZbHjKsxzZD6BJ1+YAWSes7bfeG++EbAgWUtX
         GbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rSIFYGhhFddePwX4nFIG//fqjMTXGZtm1TOG4qBhrCg=;
        b=HSS4YRo0+KBMtwmZfYNVRO/unxfReNxRW+RGAiOm6KzGIQv0RHxIHAyk2D5xxli3J3
         BysvK9gMwSd6VHBjRbAYSUMMJjlNKFcWO4JGLjBREj1J8nfWwTFPLZIqLefq6/rRykmS
         2BOs1ZOo/5Esew2kIOn5Vx9r3vdyjY7n3PjvJQowNO8NPnXf46eHzd/8RHlzAsvksDdD
         hTw69LGgxTsw+h0ZY3HJwwVmuCt7FfRfsLFjq0z+epoxKIFJhUJH8+SAMNRMDhGfLli9
         safIlj4soDmw+dVjBSDTplWEYHcSQw8DSB9y2Op1ggTdwiOH7KhDGKfJXOUIm7QAVJhB
         AsPQ==
X-Gm-Message-State: AOAM533p681BWCR8j46f1mKewIOZq7zu1MISCElH3+J3V4JN/1CEy/Ey
        2uHvfcV6cC3jDtvewywTn1vYig==
X-Google-Smtp-Source: ABdhPJzP8y92J7KSLEQXns0Q1p6Prwa1gm1UJmDRo3mqaTbxA9SwwYF0kVM6eJQzjDycFDbaRyZsDQ==
X-Received: by 2002:ad4:5010:: with SMTP id s16mr8126017qvo.24.1612451651559;
        Thu, 04 Feb 2021 07:14:11 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id u126sm5343288qkc.107.2021.02.04.07.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 07:14:10 -0800 (PST)
Date:   Thu, 4 Feb 2021 10:14:09 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: replace the loop with a
 list_for_each_entry()
Message-ID: <YBwPQUwLQ6hAbdSV@cmpxchg.org>
References: <20210204105320.46072-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204105320.46072-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 06:53:20PM +0800, Muchun Song wrote:
> The rule of list walk has gone since:
> 
>  commit a9d5adeeb4b2 ("mm/memcontrol: allow to uncharge page without using page->lru field")
> 
> So remove the strange comment and replace the loop with a
> list_for_each_entry().
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/memcontrol.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6c7f1ea3955e..43341bd7ea1c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6891,24 +6891,11 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  static void uncharge_list(struct list_head *page_list)
>  {
>  	struct uncharge_gather ug;
> -	struct list_head *next;
> +	struct page *page;
>  
>  	uncharge_gather_clear(&ug);
> -
> -	/*
> -	 * Note that the list can be a single page->lru; hence the
> -	 * do-while loop instead of a simple list_for_each_entry().
> -	 */
> -	next = page_list->next;
> -	do {
> -		struct page *page;
> -
> -		page = list_entry(next, struct page, lru);
> -		next = page->lru.next;
> -
> +	list_for_each_entry(page, page_list, lru)
>  		uncharge_page(page, &ug);
> -	} while (next != page_list);
> -
>  	uncharge_batch(&ug);

Good catch, this makes things much simpler.

Looking at the surrounding code, there also seems to be no reason
anymore to have uncharge_list() as a separate function: there is only
one caller after the mentioned commit, and it's trivial after your
change. Would you mind folding it into mem_cgroup_uncharge_list()?

The list_empty() check in that one is also unnecessary now: the
do-while loop required at least one page to be on the list or it would
crash, but list_for_each() will be just fine on an empty list.

Thanks
