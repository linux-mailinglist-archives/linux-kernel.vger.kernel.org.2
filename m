Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFDA324A01
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 06:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhBYFXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 00:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhBYFXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 00:23:24 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBCAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 21:22:44 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id a7so4590223iok.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 21:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r+s9+fvKTP1ko4DNUR+SjPDr77SgV1YcUC3XDfpWktw=;
        b=cSNppOZ7kHtP1ePtc7iZ0B4vSdCmJQz69ML1uiMgn/tQqdwRc4E8aXUPYGS5Z1T8hT
         Tg1ifZQirxOlDZ9mgMscgY7olMKNB8Y77Z2B6X5559HghETA2xi5Q204WCYOG7mKEZoz
         tXUsPgOhRiBpw8azkBe+bqp3amKC0EoxbSJtu82nGdTPzeXipvQPagElTSP8IHTaHxJD
         ZRFi6L+hoJ27RV4pyThbgf2LuUuai1OZZ9V+Thw7sW/8YuuRAz27aFQ8kWnkD14g+1yG
         MuDRuBlYuL7k/ejLFc/OlZCWhaw2CQwD2b+3DctUgfmsBT4enNGg7jyn9HJn/WrIabiE
         wCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r+s9+fvKTP1ko4DNUR+SjPDr77SgV1YcUC3XDfpWktw=;
        b=HwpSqqjuKvveKeHqxhCUlqeQGxm7F0AR/ULNXEeNn0t29cWQgIpi+V9gcXqhr/qtGR
         gz7LXUnRZnXb1am0FC6ks1XP057ecHrIfdttO1Kdj0jmYlyLbCghjQPpnTQ3ga7yKjL3
         SQHvIvHqMH2hs4ZSG5GrkWp0q+/wSoVpSxY/7Rj8WYb2GsetD7cuwcamEoCndqeCxOml
         H7rPUMXFQvddZDQoVYIF/po9lZ9L1TUNzTRK6P6oiLKfTjQf6ah1ORMoryqLSKAkSGv2
         hXkv0wxtqPG7G7qB4QCH2CqIqDwjH2SMvZgXjqnSrp0c/UaxckcC5ISeenf9+g54b81W
         hO+g==
X-Gm-Message-State: AOAM533cMLgjwRSGBv7NPQMDX/JFRBaod8VEx28i6iMSXU0XVlKmKdfE
        0wLeM1CjgysG8gkUPdUdlsCoAA==
X-Google-Smtp-Source: ABdhPJznpX4ur7dCFkWsb+5rGGnjar7Tk6GVHB6C9gQYLoJvlI8tMauMGxBAFOgZ2fItDedIldVfVQ==
X-Received: by 2002:a5d:818f:: with SMTP id u15mr1250452ion.95.1614230563269;
        Wed, 24 Feb 2021 21:22:43 -0800 (PST)
Received: from google.com ([2620:15c:183:200:c037:ba21:bf5e:4d1f])
        by smtp.gmail.com with ESMTPSA id q15sm2724735ilt.30.2021.02.24.21.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 21:22:42 -0800 (PST)
Date:   Wed, 24 Feb 2021 22:22:38 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        alex.shi@linux.alibaba.com, guro@fb.com, hannes@cmpxchg.org,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Subject: Re: [PATCH] mm: test page->flags directly in page_lru()
Message-ID: <YDc0Hqk+A4wvN7jg@google.com>
References: <20210122220600.906146-11-yuzhao@google.com>
 <20210224084807.2179942-1-yuzhao@google.com>
 <20210224051558.79e31c60eea2c088f4a1b300@linux-foundation.org>
 <20210224215639.GT2858050@casper.infradead.org>
 <YDbUaJ0j2YisyyuK@google.com>
 <20210224224846.GU2858050@casper.infradead.org>
 <YDbmT87E106uS1Xa@google.com>
 <20210225035553.GX2858050@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225035553.GX2858050@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 03:55:53AM +0000, Matthew Wilcox wrote:
> On Wed, Feb 24, 2021 at 04:50:39PM -0700, Yu Zhao wrote:
> > On Wed, Feb 24, 2021 at 10:48:46PM +0000, Matthew Wilcox wrote:
> > > On Wed, Feb 24, 2021 at 03:34:16PM -0700, Yu Zhao wrote:
> > > > > If only somebody were working on a patch series to get rid of
> > > > > all those calls to compound_head()!  Some reviews on
> > > > > https://lore.kernel.org/linux-mm/20210128070404.1922318-2-willy@infradead.org/
> > > > > would be nice.
> > > > 
> > > > I'm on board with the idea and have done some research in this
> > > > direction. We've found that the ideal *anon* page size for Chrome OS
> > > > is not 4KB or 2MB, but 32KB. I hope we could leverage the folio to
> > > > support flexible anon page size to reduce the number of page faults
> > > > (vs 4KB) or internal fragmentation (vs 2MB).
> > > > 
> > > > That being said, it seems to me this is a long term plan and right
> > > > now we need something smaller. So if you don't mind, I'll just go
> > > > ahead and remove compound_head() from Page{LRU,Active,Unevictable,
> > > > SwapBacked} first?
> > > 
> > > It's really not a big change I'm suggesting here.  You need
> > > https://lore.kernel.org/linux-mm/20210128070404.1922318-2-willy@infradead.org/
> > > https://lore.kernel.org/linux-mm/20210128070404.1922318-5-willy@infradead.org/
> > > https://lore.kernel.org/linux-mm/20210128070404.1922318-8-willy@infradead.org/
> > > and then the patch I sent above to create folio_lru().
> > > 
> > > Then any changes you want to make to use folios more broadly will
> > > incrementally move us towards your goal of 32kB anon pages.
> > 
> > Well, these patches introduce a new concept which I'm on board with.
> 
> It's not really a new concept ... it's a new type for an existing concept
> (a head page).
> 
> > Assume everybody else is too, it still seems to me it's an overkill
> > to employee folio to just get rid of unnecessary compound_head()
> > in page_lru() -- this is not a criticism but a compliment.
> 
> It's not overkill, that really is the point of a folio!  If you
> think about it, only head pages can be on the LRU list (because the
> compound_head is in the union with the lru list_head).  So it
> always makes sense to talk about folios on the LRU list.
> 
> > Let me work out something *conceptually* smaller first, and if you
> > think folio is absolutely more suitable even for this specific issue,
> > I'll go review and test the four patches you listed. Sounds good?
> 
> Umm.  It seems to me that no matter what you do, it'll be equivalent to
> this, only without the type-safety?

I'm thinking about something trivial but still very effective. So far
I've only tested it with PG_{active,unevictable}, and I'm already
seeing a 4KB gain less the 2KB loss from page_lru().

I didn't go with this at the beginning because it's also time-
consuming. I need to go over every single use of
PG_{active,unevictable,swapbacked,lru}.

add/remove: 0/0 grow/shrink: 1/37 up/down: 4/-4129 (-4125)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3cec6fbef725..c866c363bb41 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1712,6 +1712,7 @@ static void gather_stats(struct page *page, struct numa_maps *md, int pte_dirty,
                        unsigned long nr_pages)
 {
        int count = page_mapcount(page);
+       struct page *head = compound_head(page);
 
        md->pages += nr_pages;
        if (pte_dirty || PageDirty(page))
@@ -1720,7 +1721,7 @@ static void gather_stats(struct page *page, struct numa_maps *md, int pte_dirty,
        if (PageSwapCache(page))
                md->swapcache += nr_pages;
 
-       if (PageActive(page) || PageUnevictable(page))
+       if (PageActive(head) || PageUnevictable(head))
                md->active += nr_pages;
 
        if (PageWriteback(page))
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index db914477057b..35b3d272ab4c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -335,8 +335,8 @@ PAGEFLAG(Dirty, dirty, PF_HEAD) TESTSCFLAG(Dirty, dirty, PF_HEAD)
        __CLEARPAGEFLAG(Dirty, dirty, PF_HEAD)
 PAGEFLAG(LRU, lru, PF_HEAD) __CLEARPAGEFLAG(LRU, lru, PF_HEAD)
        TESTCLEARFLAG(LRU, lru, PF_HEAD)
-PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
-       TESTCLEARFLAG(Active, active, PF_HEAD)
+PAGEFLAG(Active, active, PF_ONLY_HEAD) __CLEARPAGEFLAG(Active, active, PF_ONLY_HEAD)
+       TESTCLEARFLAG(Active, active, PF_ONLY_HEAD)
 PAGEFLAG(Workingset, workingset, PF_HEAD)
        TESTCLEARFLAG(Workingset, workingset, PF_HEAD)
 __PAGEFLAG(Slab, slab, PF_NO_TAIL)
@@ -407,9 +407,9 @@ CLEARPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
 PAGEFLAG_FALSE(SwapCache)
 #endif
 
-PAGEFLAG(Unevictable, unevictable, PF_HEAD)
-       __CLEARPAGEFLAG(Unevictable, unevictable, PF_HEAD)
-       TESTCLEARFLAG(Unevictable, unevictable, PF_HEAD)
+PAGEFLAG(Unevictable, unevictable, PF_ONLY_HEAD)
+       __CLEARPAGEFLAG(Unevictable, unevictable, PF_ONLY_HEAD)
+       TESTCLEARFLAG(Unevictable, unevictable, PF_ONLY_HEAD)
 
 #ifdef CONFIG_MMU
 PAGEFLAG(Mlocked, mlocked, PF_NO_TAIL)
