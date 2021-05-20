Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC4A389B07
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 03:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhETBsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 21:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETBsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 21:48:14 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6528AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 18:46:53 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id k4so3649972qkd.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 18:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z5/RTi1IdELulsUQK1tP18vsyEvr0MuQXrwyi68livE=;
        b=XuIo6OyTgGqSqeFiFhs+TCjPq3TZr2r6LFqHNPmZ6H8wQfpyGQ4BGCAoG3HoD8moOm
         PuNcqFKBgYLelkK1tuU7LvDhc+OJF0bJyxHBYj5pmcxwZFnHEo5XBwf5bMadjgMXO7u7
         OsP8yglY39zCzP8VneQ7j1UcKQHeI4ZKgvDtE62gRlkBDfIqCKVSmQkz0a9D6Y40JwXs
         IbQVsP3Iir7N0LOmz1S8m87Q1VcoWIwxHsGjnjGyQ2oUAcIUOf3KmP6fBApzrRsHGi+o
         rxdh97PEIC2c8h47CzQz+5ez9FJbswG/hslJxWjM8pOBkcKp3VnfY6Ak14420ygy/PVI
         owkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z5/RTi1IdELulsUQK1tP18vsyEvr0MuQXrwyi68livE=;
        b=nfgxGw6tMJrdD4/GkyNf/KLjt5QCJtzdlgOFFglENKdDxAZXbkH5OPxrdmhsQaXl6Z
         zHufqp+3bkRPWbr1Jkg5OsVRodkZrgMSd1RAPGURINMWmYBYt2by0E1Bg+zr1MdNrAlg
         fObZIq0g1ADZQOzv9qGLhgFlByKR9BnuwIlrfms9SMGsGulnT/f7GtMhKZAkEs2MxzuI
         EQ7aWTcsKB7gR6gRUasrcabuw6PmplpcwjX9E5gXeZkwW59jXrLOf9KLJCuYN2Tsc0BL
         WCxyizhA7X2vz/bx6ECpz1GfjlQGEnt2rVZk0WuTP2XLs8IX91dNaqzX9yFaW7fvc/dp
         CBkw==
X-Gm-Message-State: AOAM5333zhpZA9tFbtcSh47bSlOXDkWTQZ0gs65WlcoMWcRwhtp0TaHa
        2I5aUFgmeyUe/qYfrcA+51SNdA==
X-Google-Smtp-Source: ABdhPJykrI/hzK2ExP8boMVXmTf2YcpzghBnUv61y/ZLIHwNqzdAocB0zZcHivGXl8S9bGVrsyrW3g==
X-Received: by 2002:a37:6514:: with SMTP id z20mr2649165qkb.11.1621475212414;
        Wed, 19 May 2021 18:46:52 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id d16sm931619qtw.23.2021.05.19.18.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 18:46:51 -0700 (PDT)
Date:   Wed, 19 May 2021 21:46:51 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH] mm: move idle swap cache pages to the tail of LRU after
 COW
Message-ID: <YKW/ix3Yg5HRuBaC@cmpxchg.org>
References: <20210519013313.1274454-1-ying.huang@intel.com>
 <YKUlfeAiq/vv+dHl@cmpxchg.org>
 <87r1i28ahm.fsf@yhuang6-desk1.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1i28ahm.fsf@yhuang6-desk1.ccr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 09:22:45AM +0800, Huang, Ying wrote:
> Johannes Weiner <hannes@cmpxchg.org> writes:
> 
> > On Wed, May 19, 2021 at 09:33:13AM +0800, Huang Ying wrote:
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index b83f734c4e1d..2b6847f4c03e 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -3012,6 +3012,11 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
> >>  				munlock_vma_page(old_page);
> >>  			unlock_page(old_page);
> >>  		}
> >> +		if (page_copied && PageSwapCache(old_page) &&
> >> +		    !page_mapped(old_page) && trylock_page(old_page)) {
> >> +			try_to_free_idle_swapcache(old_page);
> >> +			unlock_page(old_page);
> >
> > If there are no more swap or pte references, can we just attempt to
> > free the page right away, like we do during regular unmap?
> >
> > 		if (page_copied)
> > 			free_swap_cache(old_page);
> > 		put_page(old_page);
> 
> A previous version of the patch does roughly this.
> 
> https://lore.kernel.org/lkml/20210113024241.179113-1-ying.huang@intel.com/
> 
> But Linus has concerns with the overhead introduced in the hot COW path.

Sorry, I had missed that thread.

It sounds like there were the same concerns about the LRU shuffling
overhead in the COW page. Now we have numbers for that, but not the
free_swap_cache version. Would you be able to run the numbers for that
as well? It would be interesting to see how much the additional code
complexity buys us.

> Another possibility is to move the idle swap cache page to the tail of
> the file LRU list.  But the question is how to identify the page.

The LRU type is identified by PG_swapbacked, and we do clear that for
anon pages to implement MADV_FREE. It may work here too. But I'm
honestly a bit skeptical about the ROI on this...
