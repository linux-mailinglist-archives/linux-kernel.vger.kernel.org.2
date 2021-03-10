Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989713341D9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 16:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhCJPpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 10:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhCJPpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:45:23 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AC8C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:45:22 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d23so5454038plq.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 07:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K7J4mK1wcrpYvuUrhe1JER61F+ZE4UvbwDiIPZFXGcc=;
        b=Abi4UsGeZm27KRexhiofdoPc/x71fqlJza7Q5Gdm1PMgUXGdaN4Ccik5MtaP0cjz6y
         5qFGApD4ByCByqGB7qOWaGTOVcSBECT7reWjOIYlL6nArdAlPDIyX8iWchuHTGuuQ075
         Wh3tQGbqbaXT+EOvSjzMqVXCWJ5qGIc9RHbKs4jRhECfss4+t44kETB4LPRt7RVxytqI
         jzl7TVger2GfFNKYAU6NTdvgksn2Ms/Bdj07wMwoS2wlqQQ4ZUSWhH+CUlbfskG8FvMr
         BZ7KyJsRTQPpLdgY3f5ftEgzyPMQlQNpI328/NQiMGSv0gh4ujg2Vuh0GSTTy4n6rSA2
         a3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=K7J4mK1wcrpYvuUrhe1JER61F+ZE4UvbwDiIPZFXGcc=;
        b=WRImY2w3zssXltJ+UAgyf6EzBuMWquvi9num/jaWKFG9u7hFzjbEPDoLZJVTjunxFu
         pnKTVjXDZCyaRj5YSQdUfknZU0WRTqxPaS+hPBeDtWW8NSmGSTw2iis3f5pGBW9HeqeO
         NeZ3OEhEIUcZj8HZVKx4MjAd8mZDLyGWtYkQobIXTP1GVJYgT+1EXbPTkMdgJsxy4wj+
         30KPCG77NIXMU2xcZQFQkYuk3MiZBOLQVCP59IgTpRY34w/awOajGLjLJRn6rzkJRdoG
         O2K86856xz7VK78L+T5X5r6rErKUeMoMDnrZ9LEw4NhrUyBew5lWo1Dxdb80kHY0ohYS
         OBdg==
X-Gm-Message-State: AOAM532m5dMlwqJt1Jeew9C69dA0U380Qo3ulW+TvFrZdFuMs7BNnqVK
        5Pm2OyGRs+S37MVZ7lePJ0s=
X-Google-Smtp-Source: ABdhPJyxum0hAIsGKUQDt+qw44nnnOmGADd+iz0D8A+QyT69wJznXpft6ZD5PBdFWY4GNhNZ5AMA7g==
X-Received: by 2002:a17:90a:a103:: with SMTP id s3mr4274115pjp.158.1615391122367;
        Wed, 10 Mar 2021 07:45:22 -0800 (PST)
Received: from google.com ([2620:15c:211:201:64cb:74c7:f2c:e5e0])
        by smtp.gmail.com with ESMTPSA id jt21sm6448248pjb.51.2021.03.10.07.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 07:45:21 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 10 Mar 2021 07:45:19 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v2] mm: page_alloc: dump migrate-failed pages
Message-ID: <YEjpj9g32ApZFY6u@google.com>
References: <20210308202047.1903802-1-minchan@kernel.org>
 <YEdAw6gnp9XxoWUQ@dhcp22.suse.cz>
 <YEefLYiX6rF3Uk4E@google.com>
 <YEh4doXvyuRl5BDB@google.com>
 <5f0e17f2-b161-f0f1-65a4-a7b3af4d2cce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f0e17f2-b161-f0f1-65a4-a7b3af4d2cce@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 09:20:40AM +0100, David Hildenbrand wrote:
> On 10.03.21 08:42, Minchan Kim wrote:
> > On Tue, Mar 09, 2021 at 08:15:41AM -0800, Minchan Kim wrote:
> > 
> > < snip >
> > 
> > > > [...]
> > > > > +void dump_migrate_failure_pages(struct list_head *page_list)
> > > > > +{
> > > > > +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
> > > > > +			"migrate failure");
> > > > > +	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&
> > > > > +			alloc_contig_ratelimit()) {
> > > > > +		struct page *page;
> > > > > +
> > > > > +		WARN(1, "failed callstack");
> > > > > +		list_for_each_entry(page, page_list, lru)
> > > > > +			dump_page(page, "migration failure");
> > > > > +	}
> > > > 
> > > > Apart from the above, do we have to warn for something that is a
> > > > debugging aid? A similar concern wrt dump_page which uses pr_warn and
> > > 
> > > Make sense.
> > > 
> > > > page owner is using even pr_alert.
> > > > Would it make sense to add a loglevel parameter both into __dump_page
> > > > and dump_page_owner?
> > > 
> > > Let me try it.
> > 
> > I looked though them and made first draft to clean them up.
> > 
> > It's bigger than my initial expectaion because there are many callsites
> > to use dump_page and stack_trace_print inconsistent loglevel.
> > Since it's not a specific problem for this work, I'd like to deal with
> > it as separate patchset since I don't want to be stuck on here for my
> > initial goal.
> 
> Why the need to rush regarding your series?
> 
> If it will clean up your patch significantly, then I think doing the
> cleanups first is the proper way to go.

It doesn't clean up my patch at all. dump_page and internal functions
are already broken in several places from print level point of view.

I agreed that it's good to fix but it shouldn't be a block for the work
since it's not a new particular problem this patch introduce.

> 
> I really don't get why this is a real problem.

That's because it's not my top priority.
