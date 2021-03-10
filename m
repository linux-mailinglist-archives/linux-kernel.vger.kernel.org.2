Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE4B334B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbhCJWG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbhCJWF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:05:59 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F81C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:05:59 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id t4so18680175qkp.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 14:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NWPWYdWvWcOBp2T3gIhmVnLIkAxq/bhGSpQPWfx2I2w=;
        b=iYi0EfVrT6z67CWn2YUps4KYY2aTNsuGmqRf2Z+VTK2I/FXe7CjlVMAms4KumtwoK+
         2u/nDAY95sETpUUpM7iZS/JWizhIye+YnQUVJwHKEhmw8V9P0swH3R+jdvdTU5yOpjVg
         VPsKXcci6F0HIaDR5sW3MM5035f3WkAbficradxylOc85vUZHOKD53NosL8ipzVxrGyn
         h2cLAe+Z5uj+6boOW1dwBIelde7JrkhhcKDiSkHeFYn2h4OF74TxWPMLAh6DyrTrMyKd
         RYLzDX73uYBVR7+GCrTnA5p2g3ry5oPBz4QAlHUgoCVwb+WB7ivrC9+a4mZIoa/qo7+J
         sI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NWPWYdWvWcOBp2T3gIhmVnLIkAxq/bhGSpQPWfx2I2w=;
        b=boRd9Jpn7r05OrSQg6KCSEYNj9J1TltaODV7d4ZREyRc3J5Dmx6JgeLeEPAQiR8jpw
         35y9/YvDzHtf/lbZ7uQVhp+qxgTdAN71V3uoxOviKVFKMJZ4bxVX25Lwc+nAoQEl+Wm1
         O0/d9FNB4ogHIq51IH/fc4W4+lux97S6O0tniqrF0gGUlyFazeuo/OcxHEo8aT5BPesR
         lL4QXtrSAuzz8Xuo5by4Ns1sluUTQlLKoY+uP3+VR3EQs7MvdWkJmo55LMxe9iIWabbx
         Ad7/amrdDQWw2drBZ6iSuEkzgfQZ50Vo75QNTs9TnR5eBxOSiZg3xg0aWCPVBLxngGuO
         c4Ig==
X-Gm-Message-State: AOAM531eCdArygvMQJPSroKY4rfJ8tJToL4Tk1dY+JWMFvtJv+U2K+S6
        /gZRAsK5dtEBsT3IwPlTUGBb5w==
X-Google-Smtp-Source: ABdhPJwYjRYwWe0mtckQIBE9tIbDlVWot/V0zyNS99ti0BBnTawmWK+Mwby35mAWO2gxzFYCOEBSig==
X-Received: by 2002:a37:9d93:: with SMTP id g141mr4746631qke.270.1615413957643;
        Wed, 10 Mar 2021 14:05:57 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 84sm568843qkg.8.2021.03.10.14.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:05:57 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:05:56 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, mhocko@kernel.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com
Subject: Re: [PATCH v3 3/4] mm: memcontrol: use obj_cgroup APIs to charge
 kmem pages
Message-ID: <YElCxDzVgBBLAQhJ@cmpxchg.org>
References: <20210309100717.253-1-songmuchun@bytedance.com>
 <20210309100717.253-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309100717.253-4-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Munchun,

On Tue, Mar 09, 2021 at 06:07:16PM +0800, Muchun Song wrote:
> @@ -6806,11 +6823,23 @@ static inline void uncharge_gather_clear(struct uncharge_gather *ug)
>  static void uncharge_batch(const struct uncharge_gather *ug)
>  {
>  	unsigned long flags;
> +	unsigned long nr_pages;
>  
> -	if (!mem_cgroup_is_root(ug->memcg)) {
> -		page_counter_uncharge(&ug->memcg->memory, ug->nr_pages);
> +	/*
> +	 * The kmem pages can be reparented to the root memcg, in
> +	 * order to prevent the memory counter of root memcg from
> +	 * increasing indefinitely. We should decrease the memory
> +	 * counter when unchange.
> +	 */
> +	if (mem_cgroup_is_root(ug->memcg))
> +		nr_pages = ug->nr_kmem;
> +	else
> +		nr_pages = ug->nr_pages;

Correct or not, I find this unreadable. We're uncharging nr_kmem on
the root, and nr_pages against leaf groups?

It implies several things that might not be immediately obvious to the
reader of this function. Namely, that nr_kmem is a subset of nr_pages.
Or that we don't *want* to account LRU pages for the root cgroup.

The old code followed a very simple pattern: the root memcg's page
counters aren't touched.

This is no longer true: we modify them depending on very specific
circumstances. But that's too clever for the stupid uncharge_batch()
which is only supposed to flush a number of accumulators into their
corresponding page counters.

This distinction really needs to be moved down to uncharge_page() now.

> @@ -6828,7 +6857,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
>  
>  static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  {
> -	unsigned long nr_pages;
> +	unsigned long nr_pages, nr_kmem;
>  	struct mem_cgroup *memcg;
>  
>  	VM_BUG_ON_PAGE(PageLRU(page), page);
> @@ -6836,34 +6865,44 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  	if (!page_memcg_charged(page))
>  		return;
>  
> +	nr_pages = compound_nr(page);
>  	/*
>  	 * Nobody should be changing or seriously looking at
> -	 * page memcg at this point, we have fully exclusive
> -	 * access to the page.
> +	 * page memcg or objcg at this point, we have fully
> +	 * exclusive access to the page.
>  	 */
> -	memcg = page_memcg_check(page);
> +	if (PageMemcgKmem(page)) {
> +		struct obj_cgroup *objcg;
> +
> +		objcg = page_objcg(page);
> +		memcg = obj_cgroup_memcg_get(objcg);
> +
> +		page->memcg_data = 0;
> +		obj_cgroup_put(objcg);
> +		nr_kmem = nr_pages;
> +	} else {
> +		memcg = page_memcg(page);
> +		page->memcg_data = 0;
> +		nr_kmem = 0;
> +	}

Why is all this moved above the uncharge_batch() call?

It separates the pointer manipulations from the refcounting, which
makes the code very difficult to follow.

> +
>  	if (ug->memcg != memcg) {
>  		if (ug->memcg) {
>  			uncharge_batch(ug);
>  			uncharge_gather_clear(ug);
>  		}
>  		ug->memcg = memcg;
> +		ug->dummy_page = page;

Why this change?

>  		/* pairs with css_put in uncharge_batch */
>  		css_get(&ug->memcg->css);
>  	}
>  
> -	nr_pages = compound_nr(page);
>  	ug->nr_pages += nr_pages;
> +	ug->nr_kmem += nr_kmem;
> +	ug->pgpgout += !nr_kmem;

Oof.

Yes, this pgpgout line is an equivalent transformation for counting
LRU compound pages. But unless you already know that, it's completely
impossible to understand what the intent here is.

Please avoid clever tricks like this. If you need to check whether the
page is kmem, test PageMemcgKmem() instead of abusing the counters as
boolean flags. This is supposed to be read by human beings, too.

> -	if (PageMemcgKmem(page))
> -		ug->nr_kmem += nr_pages;
> -	else
> -		ug->pgpgout++;
> -
> -	ug->dummy_page = page;
> -	page->memcg_data = 0;
> -	css_put(&ug->memcg->css);
> +	css_put(&memcg->css);

Sorry, these two functions are no longer readable after your changes.

Please retain the following sequence as discrete steps:

1. look up memcg from the page
2. flush existing batch if memcg changed
3. add page's various counts to the current batch
4. clear page->memcg and decrease the referece count to whatever it was pointing to

And as per above, step 3. is where we should check whether to uncharge
the memcg's page counter at all:

	if (PageMemcgKmem(page)) {
		ug->nr_pages += nr_pages;
		ug->nr_kmem += nr_pages;
	} else {
		/* LRU pages aren't accounted at the root level */
		if (!mem_cgroup_is_root(memcg))
			ug->nr_pages += nr_pages;
		ug->pgpgout++;
	}

In fact, it might be a good idea to rename ug->nr_pages to
ug->nr_memory to highlight how it maps to the page_counter.
