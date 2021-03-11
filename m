Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB91337384
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 14:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhCKNMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 08:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbhCKNMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:12:15 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4397C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 05:12:15 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id f12so1045048qtq.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 05:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=feL7/A09ma6TkVCyJuUvT/OeaJ2NLjYxqF+G33hgph4=;
        b=HuxmYaj9V4l5G7j67S8de0pFn8Yovb4HtPg8s5fZEp8brnV5pf1eZrJeuPyxVEtzxp
         ffnOyFJ8UlcQOyzReK4a/QJpq4l2Ylx64Ms5U6E4KppdqgYXmIUHjTS0zlYQVMCPgBsA
         gyVCWXIaW9cOD4TBFQEbjAka1t6SXsLwQvA3TGM3dxyn+HI8UGxJZOlc2RrcyWgGFE+g
         P1hi/OJ3tDUOH1fCKMFRlv0empELIHYnBg9fy97hG0LLALWiD1noAVaUz3bUEtx1Hp95
         tf0e4ZYYKikfKLd06gD/18SGPoWY2U+tSp5tayik1I+afRy/H0qEmv/eeK/EoYAfhz+x
         aFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=feL7/A09ma6TkVCyJuUvT/OeaJ2NLjYxqF+G33hgph4=;
        b=HSWXMvs90NmHjk3T03yffEsS6L0+kQ9Rub6dTNtRsCeHmLRceflHZOa1UNtU447K8t
         e4dRnVfWjwpJwjHbJFTc3EjN8sYJiibdPk5nWcHnwZaHfdMlgTV61s29YjC42CoJRLx+
         6S41BMEb1tsnNj0cVUk6Hy2QRAoBakOY/vnmOirrSscgbHNFsavM46aXJRNyJGShK/G0
         6GYdH+VoWvLXaZblmEhS+dX9F0TVsHqunflfwZDnzoWv5W0b36bPGSFOqcnNAyW+xCrQ
         0mpzIbzW9ket2Y2K5coIaLYDOHskdXOIy45N1AhCnmWsLFX0K+zVWZ0izzyRhaAi846u
         2DcA==
X-Gm-Message-State: AOAM530TBXETWZT25jo2SLhax/SqUBs/0EFhVMi6tQt7AANR6otzYsNz
        Yp5eMjqdxp7QKiECFQK6V3dIuA==
X-Google-Smtp-Source: ABdhPJybZEIbHTC1T4n1YDCsQ321T4ton4U/Pa0pe7/Z8WhsK0q6fQHUcb7iy7UXAeC0wXjQ8UMAMQ==
X-Received: by 2002:ac8:68b:: with SMTP id f11mr7062158qth.373.1615468334812;
        Thu, 11 Mar 2021 05:12:14 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:e6d2])
        by smtp.gmail.com with ESMTPSA id m16sm1863657qkm.100.2021.03.11.05.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 05:12:14 -0800 (PST)
Date:   Thu, 11 Mar 2021 08:12:13 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, mhocko@kernel.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com
Subject: Re: [PATCH v3 2/4] mm: memcontrol: make page_memcg{_rcu} only
 applicable for non-kmem page
Message-ID: <YEoXLX37sVgULO4A@cmpxchg.org>
References: <20210309100717.253-1-songmuchun@bytedance.com>
 <20210309100717.253-3-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309100717.253-3-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 06:07:15PM +0800, Muchun Song wrote:
> We want to reuse the obj_cgroup APIs to charge the kmem pages.
> If we do that, we should store an object cgroup pointer to
> page->memcg_data for the kmem pages.
> 
> Finally, page->memcg_data can have 3 different meanings.
> 
>   1) For the slab pages, page->memcg_data points to an object cgroups
>      vector.
> 
>   2) For the kmem pages (exclude the slab pages), page->memcg_data
>      points to an object cgroup.
> 
>   3) For the user pages (e.g. the LRU pages), page->memcg_data points
>      to a memory cgroup.
> 
> Currently we always get the memory cgroup associated with a page via
> page_memcg() or page_memcg_rcu(). page_memcg_check() is special, it
> has to be used in cases when it's not known if a page has an
> associated memory cgroup pointer or an object cgroups vector. Because
> the page->memcg_data of the kmem page is not pointing to a memory
> cgroup in the later patch, the page_memcg() and page_memcg_rcu()
> cannot be applicable for the kmem pages. In this patch, make
> page_memcg() and page_memcg_rcu() no longer apply to the kmem pages.
> We do not change the behavior of the page_memcg_check(), it is also
> applicable for the kmem pages.
> 
> In the end, there are 3 helpers to get the memcg associated with a page.
> Usage is as follows.
> 
>   1) Get the memory cgroup associated with a non-kmem page (e.g. the LRU
>      pages).
> 
>      - page_memcg()
>      - page_memcg_rcu()
> 
>   2) Get the memory cgroup associated with a page. It has to be used in
>      cases when it's not known if a page has an associated memory cgroup
>      pointer or an object cgroups vector. Returns NULL for slab pages or
>      uncharged pages. Otherwise, returns memory cgroup for charged pages
>      (e.g. the kmem pages, the LRU pages).
> 
>      - page_memcg_check()
> 
> In some place, we use page_memcg() to check whether the page is charged.
> Now introduce page_memcg_charged() helper to do that.
> 
> This is a preparation for reparenting the kmem pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

I'm pretty excited about the direction this series is taking us. The
direct/raw pinning of memcgs from objects and allocations of various
lifetimes has been causing chronic problems with dying cgroups piling
up, consuming memory, and gumming up the works in everything that
needs to iterate the cgroup tree (page reclaim comes to mind).

The more allocation types we can convert to objcg, the better.

This patch in particular looks mostly good to me too. Some comments
inline:

> ---
>  include/linux/memcontrol.h | 33 +++++++++++++++++++++++++++------
>  mm/memcontrol.c            | 23 +++++++++++++----------
>  mm/page_alloc.c            |  4 ++--
>  3 files changed, 42 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index e6dc793d587d..83cbcdcfcc92 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -358,14 +358,26 @@ enum page_memcg_data_flags {
>  
>  #define MEMCG_DATA_FLAGS_MASK (__NR_MEMCG_DATA_FLAGS - 1)
>  
> +/* Return true for charged page, otherwise false. */
> +static inline bool page_memcg_charged(struct page *page)
> +{
> +	unsigned long memcg_data = page->memcg_data;
> +
> +	VM_BUG_ON_PAGE(PageSlab(page), page);
> +	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
> +
> +	return !!memcg_data;
> +}

This is mosntly used right before a page_memcg_check(), which makes it
somewhat redundant except for the VM_BUG_ON_PAGE() for slab pages.

But it's also a bit of a confusing name: slab pages are charged too,
but this function would crash if you called it on one.

In light of this, and in light of what I wrote above about hopefully
converting more and more allocations from raw memcg pins to
reparentable objcg, it would be bettor to have

	page_memcg() for 1:1 page-memcg mappings, i.e. LRU & kmem
	page_objcg() for 1:n page-memcg mappings, i.e. slab pages
	page_memcg_check() for the very rare ambiguous cases
	drop page_memcg_rcu() since page_memcg() is now rcu-safe

If we wanted to optimize, we could identify places that could do a
page_memcg_raw() that does page->memcg_data & ~MEMCG_DATA_FLAGS_MASK -
without READ_ONCE and without the kmem branch. However, I think the
stat functions are probably the hottest path when it comes to that,
and they now already include the kmem branch*.

* Roman mentioned splitting up the stats interface to optimize that,
  but I think we should be careful optimizing prematurely here. It's a
  bit of a maintainability concern, and it would also get in the way
  of easily converting more allocation types to objcg.

> @@ -855,10 +855,11 @@ void __mod_lruvec_page_state(struct page *page, enum node_stat_item idx,
>  			     int val)
>  {
>  	struct page *head = compound_head(page); /* rmap on tail pages */
> -	struct mem_cgroup *memcg = page_memcg(head);
> +	struct mem_cgroup *memcg;
>  	pg_data_t *pgdat = page_pgdat(page);
>  	struct lruvec *lruvec;
>  
> +	memcg = page_memcg_check(head);

With the proposed variants above, this should be page_memcg() and
actually warn/crash when we pass a slab page to this function.

> @@ -3166,12 +3167,13 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
>   */
>  void __memcg_kmem_uncharge_page(struct page *page, int order)
>  {
> -	struct mem_cgroup *memcg = page_memcg(page);
> +	struct mem_cgroup *memcg;
>  	unsigned int nr_pages = 1 << order;
>  
> -	if (!memcg)
> +	if (!page_memcg_charged(page))
>  		return;
>  
> +	memcg = page_memcg_check(page);

This would remain unchanged:

	memcg = page_memcg(page);
	if (!memcg)
		return;

> @@ -6827,24 +6829,25 @@ static void uncharge_batch(const struct uncharge_gather *ug)
>  static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  {
>  	unsigned long nr_pages;
> +	struct mem_cgroup *memcg;
>  
>  	VM_BUG_ON_PAGE(PageLRU(page), page);
>  
> -	if (!page_memcg(page))
> +	if (!page_memcg_charged(page))
>  		return;
>  
>  	/*
>  	 * Nobody should be changing or seriously looking at
> -	 * page_memcg(page) at this point, we have fully
> -	 * exclusive access to the page.
> +	 * page memcg at this point, we have fully exclusive
> +	 * access to the page.
>  	 */
> -
> -	if (ug->memcg != page_memcg(page)) {
> +	memcg = page_memcg_check(page);

Same situation here:

	memcg = page_memcg(page);
	if (!memcg)
		return;

> @@ -6877,7 +6880,7 @@ void mem_cgroup_uncharge(struct page *page)
>  		return;
>  
>  	/* Don't touch page->lru of any random page, pre-check: */
> -	if (!page_memcg(page))
> +	if (!page_memcg_charged(page))
>  		return;

Same:

	if (!page_memcg(page))
		return;

>  	uncharge_gather_clear(&ug);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f10966e3b4a5..bcb58ae15e24 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1124,7 +1124,7 @@ static inline bool page_expected_state(struct page *page,
>  	if (unlikely((unsigned long)page->mapping |
>  			page_ref_count(page) |
>  #ifdef CONFIG_MEMCG
> -			(unsigned long)page_memcg(page) |
> +			page_memcg_charged(page) |

Actually, I think we might want to just check the raw

			page->memcg_data

here, as neither lru, nor kmem, nor slab page should have anything
left in there by the time the page is freed.

> @@ -1149,7 +1149,7 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
>  			bad_reason = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
>  	}
>  #ifdef CONFIG_MEMCG
> -	if (unlikely(page_memcg(page)))
> +	if (unlikely(page_memcg_charged(page)))
>  		bad_reason = "page still charged to cgroup";

Same here.
