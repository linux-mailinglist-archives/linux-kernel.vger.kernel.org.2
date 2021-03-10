Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AFE333D47
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 14:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhCJNH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 08:07:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:44632 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230341AbhCJNHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 08:07:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615381633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F3rteK1rjoKCID0RVa44+wY4sdSRp927jm0JGORO7pc=;
        b=uZ2yxxH4t7witfSxpWAjPFnTdlGjURwtmDZYb6U9C5+jBzAUPi40PG0ZsMRUbDk/f/73IR
        sFlKKCCfA3FMzLysw/Zd9BoPpmFuWU9nJCZmUTC0Er5pzpf5blq7k67sJjM1w8Olsqmg0m
        TPisn3IoOEm9SqTqvl9NflHtH3PFBfI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3BE6BAE84;
        Wed, 10 Mar 2021 13:07:13 +0000 (UTC)
Date:   Wed, 10 Mar 2021 14:07:05 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v2] mm: page_alloc: dump migrate-failed pages
Message-ID: <YEjEefQpBHV5eBXj@dhcp22.suse.cz>
References: <20210308202047.1903802-1-minchan@kernel.org>
 <YEdAw6gnp9XxoWUQ@dhcp22.suse.cz>
 <YEefLYiX6rF3Uk4E@google.com>
 <YEh4doXvyuRl5BDB@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEh4doXvyuRl5BDB@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09-03-21 23:42:46, Minchan Kim wrote:
> On Tue, Mar 09, 2021 at 08:15:41AM -0800, Minchan Kim wrote:
> 
> < snip >
> 
> > > [...]
> > > > +void dump_migrate_failure_pages(struct list_head *page_list)
> > > > +{
> > > > +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
> > > > +			"migrate failure");
> > > > +	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&
> > > > +			alloc_contig_ratelimit()) {
> > > > +		struct page *page;
> > > > +
> > > > +		WARN(1, "failed callstack");
> > > > +		list_for_each_entry(page, page_list, lru)
> > > > +			dump_page(page, "migration failure");
> > > > +	}
> > > 
> > > Apart from the above, do we have to warn for something that is a
> > > debugging aid? A similar concern wrt dump_page which uses pr_warn and
> > 
> > Make sense.
> > 
> > > page owner is using even pr_alert.
> > > Would it make sense to add a loglevel parameter both into __dump_page
> > > and dump_page_owner?
> > 
> > Let me try it.
> 
> I looked though them and made first draft to clean them up.
> 
> It's bigger than my initial expectaion because there are many callsites
> to use dump_page and stack_trace_print inconsistent loglevel. 
> Since it's not a specific problem for this work, I'd like to deal with
> it as separate patchset since I don't want to be stuck on here for my
> initial goal.
> 
> FYI,
> 
> Subject: [RFC 0/5] make dump_page aware of loglevel
> 
> - Forked from [1]
> 
> dump_page uses __dump_page and dump_page_owner internally to
> print various information. However, their printk loglevel are
> inconsistent in that
> 
> __dump_page: KERN_WARNING
> __dump_page_owner: KERN_ALERT
>         stack_trace_print: KERN_DEFAULT
> 
> To make them consistent from dump_page, this patch introduces
> pr_loglevel in printk and make the utility functions aware of
> loglevel. Finally, last patch changes dump_page to support
> loglevel to make the printing level consistent.
> 
> [1] https://lore.kernel.org/linux-mm/YEdAw6gnp9XxoWUQ@dhcp22.suse.cz/
> 
> Minchan Kim (5):
>   mm: introduce pr_loglevel for __dump_[page]_owner
>   stacktrace: stack_trace_print aware of loglevel
>   mm: page_owner: dump_page_owner aware of loglevel
>   mm: debug: __dump_page aware of loglevel
>   mm: debug: dump_page aware of loglevel
>   drivers/md/dm-bufio.c       |  2 +-
>  drivers/virtio/virtio_mem.c |  2 +-
>  fs/btrfs/ref-verify.c       |  2 +-
>  fs/fuse/dev.c               |  2 +-
>  include/linux/mmdebug.h     | 10 ++++++----
>  include/linux/page_owner.h  |  8 ++++----
>  include/linux/printk.h      | 12 +++++++++++
>  include/linux/stacktrace.h  |  4 ++--
>  kernel/backtracetest.c      |  2 +-
>  kernel/dma/debug.c          |  3 ++-
>  kernel/kcsan/report.c       |  7 ++++---
>  kernel/locking/lockdep.c    |  3 ++-
>  kernel/stacktrace.c         |  5 +++--
>  mm/debug.c                  | 40 ++++++++++++++++++-------------------
>  mm/filemap.c                |  2 +-
>  mm/gup_test.c               |  4 ++--
>  mm/huge_memory.c            |  4 ++--
>  mm/kasan/report.c           |  4 ++--
>  mm/kfence/report.c          |  3 ++-
>  mm/kmemleak.c               |  2 +-
>  mm/memory.c                 |  2 +-
>  mm/memory_hotplug.c         |  4 ++--
>  mm/page_alloc.c             |  4 ++--
>  mm/page_isolation.c         |  2 +-
>  mm/page_owner.c             | 24 +++++++++++-----------
>  25 files changed, 88 insertions(+), 69 deletions(-)

The is a lot of churn indeed. Have you considered adding $FOO_lglvl
variants for those so that you can use them for your particular case
without affecting most of existing users? Something similar we have
discussed in other email thread regarding lru_add_drain_all?

-- 
Michal Hocko
SUSE Labs
