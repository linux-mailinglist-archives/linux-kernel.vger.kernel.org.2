Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F35333689
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 08:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhCJHnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 02:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhCJHnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 02:43:00 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EC5C061760
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 23:42:49 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id a188so11492587pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 23:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PgzuC8/TNXUF5UZqdDTCIRg3y35yfyPd03qqWgWTsJ4=;
        b=B3az+5aKkQv8oKsx41T73ASQ/XRUUv/PD8x3u6627vmTMF9pgVDTDNCtihfrqX8GLp
         9UZ8xWnW4M47fsyZG3HbPOJ35IpAlSQjREOb+IzE4MglvzO2ACMgQ+YbramzEmSYSkBk
         OOi2OvLF2EMt8uDnol4CyLe3JZ/xACiZTcegeOB5kEFVg11hXo3J51dBjGtkHO4ngZxD
         zkoY1mSLbkhW3mDa7u9VnB4+a9HIdUhqzmZt/6VQL2T3EEu4ACY7k27cL14kEHosDWz6
         hmJssGQnKr7A2XXYVr8O2l003iCimXuE9PKq0cZjCL8j3tZ7hlx8RsVQXEIv8OETPZc6
         U16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=PgzuC8/TNXUF5UZqdDTCIRg3y35yfyPd03qqWgWTsJ4=;
        b=HyK1/UapRWma88nvCH7fufXIf26JVNiC4mVHCN8MXNu98Kbu/c+oGZlksTwx4SW4IC
         PoGaT0lnHFkZskXe0cKa81HFIHhUKlQ3lX7NWpOuAy4zD1cTvW74xnG0DcPbI+dRvNuB
         omB6WDw9cDjuLyV7TFYbvPJQCAWNAogB4zg9Kp+k4DM0m4G7pghlc240gQn6pyHG0ZDg
         HuWRnz66PhydX4Yc22+i+PBC2s3qZrld9oWjNL2IVu8JNWIeiVTo1rNqyemIp1bCgbwu
         igYcmrvZJ53gD/1EeRVmy9tU9WbbsJgivNJyjMF4KZxmQldZ6iTOrEGrtGdm4JakNxgn
         Kz/Q==
X-Gm-Message-State: AOAM533zuIILN6FgkYz5DKTuMTqAnC6ade2eGvS0SCHCYKXWPAf3gBhy
        8YF4dbIj1q4ki/zu8RJVNjo=
X-Google-Smtp-Source: ABdhPJx+aIT0R3oWBbHjfi73oOJplCSsgFHW6973ObD5KeT3MnmeKXtzBeRDUjYBaqJddxjLUxwqwg==
X-Received: by 2002:a63:8f5d:: with SMTP id r29mr1657909pgn.353.1615362168930;
        Tue, 09 Mar 2021 23:42:48 -0800 (PST)
Received: from google.com ([2620:15c:211:201:f896:d6be:86d4:a59b])
        by smtp.gmail.com with ESMTPSA id r184sm15608540pfc.107.2021.03.09.23.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 23:42:48 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 9 Mar 2021 23:42:46 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Dias <joaodias@google.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH v2] mm: page_alloc: dump migrate-failed pages
Message-ID: <YEh4doXvyuRl5BDB@google.com>
References: <20210308202047.1903802-1-minchan@kernel.org>
 <YEdAw6gnp9XxoWUQ@dhcp22.suse.cz>
 <YEefLYiX6rF3Uk4E@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEefLYiX6rF3Uk4E@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 08:15:41AM -0800, Minchan Kim wrote:

< snip >

> > [...]
> > > +void dump_migrate_failure_pages(struct list_head *page_list)
> > > +{
> > > +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor,
> > > +			"migrate failure");
> > > +	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&
> > > +			alloc_contig_ratelimit()) {
> > > +		struct page *page;
> > > +
> > > +		WARN(1, "failed callstack");
> > > +		list_for_each_entry(page, page_list, lru)
> > > +			dump_page(page, "migration failure");
> > > +	}
> > 
> > Apart from the above, do we have to warn for something that is a
> > debugging aid? A similar concern wrt dump_page which uses pr_warn and
> 
> Make sense.
> 
> > page owner is using even pr_alert.
> > Would it make sense to add a loglevel parameter both into __dump_page
> > and dump_page_owner?
> 
> Let me try it.

I looked though them and made first draft to clean them up.

It's bigger than my initial expectaion because there are many callsites
to use dump_page and stack_trace_print inconsistent loglevel. 
Since it's not a specific problem for this work, I'd like to deal with
it as separate patchset since I don't want to be stuck on here for my
initial goal.

FYI,

Subject: [RFC 0/5] make dump_page aware of loglevel

- Forked from [1]

dump_page uses __dump_page and dump_page_owner internally to
print various information. However, their printk loglevel are
inconsistent in that

__dump_page: KERN_WARNING
__dump_page_owner: KERN_ALERT
        stack_trace_print: KERN_DEFAULT

To make them consistent from dump_page, this patch introduces
pr_loglevel in printk and make the utility functions aware of
loglevel. Finally, last patch changes dump_page to support
loglevel to make the printing level consistent.

[1] https://lore.kernel.org/linux-mm/YEdAw6gnp9XxoWUQ@dhcp22.suse.cz/

Minchan Kim (5):
  mm: introduce pr_loglevel for __dump_[page]_owner
  stacktrace: stack_trace_print aware of loglevel
  mm: page_owner: dump_page_owner aware of loglevel
  mm: debug: __dump_page aware of loglevel
  mm: debug: dump_page aware of loglevel
  drivers/md/dm-bufio.c       |  2 +-
 drivers/virtio/virtio_mem.c |  2 +-
 fs/btrfs/ref-verify.c       |  2 +-
 fs/fuse/dev.c               |  2 +-
 include/linux/mmdebug.h     | 10 ++++++----
 include/linux/page_owner.h  |  8 ++++----
 include/linux/printk.h      | 12 +++++++++++
 include/linux/stacktrace.h  |  4 ++--
 kernel/backtracetest.c      |  2 +-
 kernel/dma/debug.c          |  3 ++-
 kernel/kcsan/report.c       |  7 ++++---
 kernel/locking/lockdep.c    |  3 ++-
 kernel/stacktrace.c         |  5 +++--
 mm/debug.c                  | 40 ++++++++++++++++++-------------------
 mm/filemap.c                |  2 +-
 mm/gup_test.c               |  4 ++--
 mm/huge_memory.c            |  4 ++--
 mm/kasan/report.c           |  4 ++--
 mm/kfence/report.c          |  3 ++-
 mm/kmemleak.c               |  2 +-
 mm/memory.c                 |  2 +-
 mm/memory_hotplug.c         |  4 ++--
 mm/page_alloc.c             |  4 ++--
 mm/page_isolation.c         |  2 +-
 mm/page_owner.c             | 24 +++++++++++-----------
 25 files changed, 88 insertions(+), 69 deletions(-)

