Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C3233426F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbhCJQGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhCJQFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:05:39 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2719C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 08:05:39 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id p21so11687599pgl.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 08:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/IlSQt+JdroGzkdRffXyJXxruj/9j7m6kLbpUsf+B50=;
        b=DfSVPLK4FHvcXwn0XEJYawc7Fg1vG89qRrbkyKld2NJiUMZ3YmqiPlM8VqDnB9tzTy
         teSe23q3yqMnsFQ4tWo1bNAtiViMRyNQPqc+NifHhX/RLXGnU4AcvhghaGvGu397wT7w
         kAaV74/8MaugvamoYbMZK/f4edWPhuVGJsmUN9MWaUSD9hGzhmeIYfyZ2FBxXUzJKyN5
         jBTTARCxmk5QzaF/qwgGtUqvODd6YwLYsNVHxerGg7yNxOBlR1rhLwhG66Bo1wZXHIGW
         RLZNEwJEkbXk1b4RTn3j1RgPlG/Jst1WXgqDjWdck7cPAYPP34Bpu/s8QYDyvw+8HT2h
         1mJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/IlSQt+JdroGzkdRffXyJXxruj/9j7m6kLbpUsf+B50=;
        b=gablzqFqnd6K7KKDDtIDznbFTvOi4tvo76mnGBb0+ORBEWbQB/XY59szJ3oRkbeg04
         UQIGXx2kc0VlJQPW4o4tgmYHsRFw3Pmyu+Wm4IZzu7f6nNu1wbTXu+5qegQWsA9lJaZP
         pvvvVCpaRNpCIzBDJ1t8xqeNy29/Qeb65bB9kWnNbgXV39rKI2hjf6U+iOA1ZHm2O9pA
         fqgII2YrZZ2DXotOOuQUqFgLlusZVMj+wxqfr9ipqGsTz/Ymp1Bg3EufiyZMgdnRNX6+
         Dvg67drpNsi6fG4k9ULSF10YvEuB3AFE9KvD92CXNVFNZTvY8jIterFZQoWLLpKvdkNT
         pdgg==
X-Gm-Message-State: AOAM531/Ewrcskgg3TT9AOyZftyBMbJxwnFRa/ZJCs9i3rDF3n0DTEru
        YrRZtIBlm/hNKJBL5Wqk5ak=
X-Google-Smtp-Source: ABdhPJzPlQDcNuvakRLyeeXywTieaSeEdksct8IP45dFXbTxviDyI2sxg+hAZjhj3LIu2zC3iBgXHA==
X-Received: by 2002:a63:f912:: with SMTP id h18mr3377253pgi.287.1615392339167;
        Wed, 10 Mar 2021 08:05:39 -0800 (PST)
Received: from google.com ([2620:15c:211:201:64cb:74c7:f2c:e5e0])
        by smtp.gmail.com with ESMTPSA id a21sm17205098pfk.83.2021.03.10.08.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 08:05:38 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 10 Mar 2021 08:05:36 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v2] mm: page_alloc: dump migrate-failed pages
Message-ID: <YEjuUHBDKu2uX4EO@google.com>
References: <20210308202047.1903802-1-minchan@kernel.org>
 <YEdAw6gnp9XxoWUQ@dhcp22.suse.cz>
 <YEefLYiX6rF3Uk4E@google.com>
 <YEh4doXvyuRl5BDB@google.com>
 <YEjEefQpBHV5eBXj@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEjEefQpBHV5eBXj@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 02:07:05PM +0100, Michal Hocko wrote:
> On Tue 09-03-21 23:42:46, Minchan Kim wrote:
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
> > 
> > FYI,
> > 
> > Subject: [RFC 0/5] make dump_page aware of loglevel
> > 
> > - Forked from [1]
> > 
> > dump_page uses __dump_page and dump_page_owner internally to
> > print various information. However, their printk loglevel are
> > inconsistent in that
> > 
> > __dump_page: KERN_WARNING
> > __dump_page_owner: KERN_ALERT
> >         stack_trace_print: KERN_DEFAULT
> > 
> > To make them consistent from dump_page, this patch introduces
> > pr_loglevel in printk and make the utility functions aware of
> > loglevel. Finally, last patch changes dump_page to support
> > loglevel to make the printing level consistent.
> > 
> > [1] https://lore.kernel.org/linux-mm/YEdAw6gnp9XxoWUQ@dhcp22.suse.cz/
> > 
> > Minchan Kim (5):
> >   mm: introduce pr_loglevel for __dump_[page]_owner
> >   stacktrace: stack_trace_print aware of loglevel
> >   mm: page_owner: dump_page_owner aware of loglevel
> >   mm: debug: __dump_page aware of loglevel
> >   mm: debug: dump_page aware of loglevel
> >   drivers/md/dm-bufio.c       |  2 +-
> >  drivers/virtio/virtio_mem.c |  2 +-
> >  fs/btrfs/ref-verify.c       |  2 +-
> >  fs/fuse/dev.c               |  2 +-
> >  include/linux/mmdebug.h     | 10 ++++++----
> >  include/linux/page_owner.h  |  8 ++++----
> >  include/linux/printk.h      | 12 +++++++++++
> >  include/linux/stacktrace.h  |  4 ++--
> >  kernel/backtracetest.c      |  2 +-
> >  kernel/dma/debug.c          |  3 ++-
> >  kernel/kcsan/report.c       |  7 ++++---
> >  kernel/locking/lockdep.c    |  3 ++-
> >  kernel/stacktrace.c         |  5 +++--
> >  mm/debug.c                  | 40 ++++++++++++++++++-------------------
> >  mm/filemap.c                |  2 +-
> >  mm/gup_test.c               |  4 ++--
> >  mm/huge_memory.c            |  4 ++--
> >  mm/kasan/report.c           |  4 ++--
> >  mm/kfence/report.c          |  3 ++-
> >  mm/kmemleak.c               |  2 +-
> >  mm/memory.c                 |  2 +-
> >  mm/memory_hotplug.c         |  4 ++--
> >  mm/page_alloc.c             |  4 ++--
> >  mm/page_isolation.c         |  2 +-
> >  mm/page_owner.c             | 24 +++++++++++-----------
> >  25 files changed, 88 insertions(+), 69 deletions(-)
> 
> The is a lot of churn indeed. Have you considered adding $FOO_lglvl
> variants for those so that you can use them for your particular case
> without affecting most of existing users? Something similar we have
> discussed in other email thread regarding lru_add_drain_all?

I thought that way but didn't try since it couldn't make them
atomic(For example, other printk place in other context will
affect by the $FOO_lglvl).
