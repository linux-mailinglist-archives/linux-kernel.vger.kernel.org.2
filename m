Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83A130BBAD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 11:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBBKB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 05:01:56 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:50782 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhBBKBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 05:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1612260098; x=1643796098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=mLcP0izKWDNsLPjNz5dQdzdBpJthpi2P8wIHv6ID5/w=;
  b=hm2MeAhprkWf7hS8QZQjxki5fBMPy2v45Yyxe7SNjKZ/JLPjV4zUfDXE
   pEo+wROFLqr2sMC3Lv/tsRTpeOiP58YvYm3EXvyOattBdeytVVEbFKu6X
   P7bWzxt8bt1bFdwS/Ou00urWlVsLsDWfuwU0rATjvtuC8qEabUVGOOdn6
   I=;
X-IronPort-AV: E=Sophos;i="5.79,394,1602547200"; 
   d="scan'208";a="79240678"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 02 Feb 2021 10:00:48 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id 5B40AA2A0E;
        Tue,  2 Feb 2021 10:00:45 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.94) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 2 Feb 2021 10:00:28 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        SeongJae Park <sjpark@amazon.de>,
        <Jonathan.Cameron@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David Hildenbrand" <david@redhat.com>, <dwmw@amazon.com>,
        Marco Elver <elver@google.com>, "Du, Fan" <fan.du@intel.com>,
        <foersleo@amazon.de>, "Greg Thelen" <gthelen@google.com>,
        Ian Rogers <irogers@google.com>, <jolsa@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>, <sblbir@amazon.com>,
        Shuah Khan <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, <zgf574564920@gmail.com>,
        <linux-damon@amazon.com>, Linux MM <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v23 07/15] mm/damon: Implement a debugfs-based user space interface
Date:   Tue, 2 Feb 2021 11:00:13 +0100
Message-ID: <20210202100013.9764-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod69dwpS8ibuVD5baTXRwZUZAiqdgZtJUHbER=5SnMB8bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.94]
X-ClientProxiedBy: EX13D31UWA002.ant.amazon.com (10.43.160.82) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Feb 2021 09:37:39 -0800 Shakeel Butt <shakeelb@google.com> wrote:

> On Tue, Dec 15, 2020 at 3:59 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > DAMON is designed to be used by kernel space code such as the memory
> > management subsystems, and therefore it provides only kernel space API.
> 
> Which kernel space APIs are being referred here?

The symbols in 'include/linux/damon.h'

> 
> > That said, letting the user space control DAMON could provide some
> > benefits to them.  For example, it will allow user space to analyze
> > their specific workloads and make their own special optimizations.
> >
> > For such cases, this commit implements a simple DAMON application kernel
> > module, namely 'damon-dbgfs', which merely wraps the DAMON api and
> > exports those to the user space via the debugfs.
> >
[...]
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> > ---
> >  include/linux/damon.h |   3 +
> >  mm/damon/Kconfig      |   9 ++
> >  mm/damon/Makefile     |   1 +
> >  mm/damon/core.c       |  45 ++++++
> >  mm/damon/dbgfs.c      | 366 ++++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 424 insertions(+)
> >  create mode 100644 mm/damon/dbgfs.c
> >
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 39b4d6d3ddee..f9e0d4349352 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -265,9 +265,12 @@ unsigned int damon_nr_regions(struct damon_target *t);
> >
> >  struct damon_ctx *damon_new_ctx(enum damon_target_type type);
> >  void damon_destroy_ctx(struct damon_ctx *ctx);
> > +int damon_set_targets(struct damon_ctx *ctx,
> > +               unsigned long *ids, ssize_t nr_ids);
> >  int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
> >                 unsigned long aggr_int, unsigned long regions_update_int,
> >                 unsigned long min_nr_reg, unsigned long max_nr_reg);
> > +int damon_nr_running_ctxs(void);
> >
> >  int damon_start(struct damon_ctx **ctxs, int nr_ctxs);
> >  int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
> > diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> > index 8ae080c52950..72f1683ba0ee 100644
> > --- a/mm/damon/Kconfig
> > +++ b/mm/damon/Kconfig
> > @@ -21,4 +21,13 @@ config DAMON_VADDR
> >           This builds the default data access monitoring primitives for DAMON
> >           that works for virtual address spaces.
> >
> > +config DAMON_DBGFS
> > +       bool "DAMON debugfs interface"
> > +       depends on DAMON_VADDR && DEBUG_FS
> > +       help
> > +         This builds the debugfs interface for DAMON.  The user space admins
> > +         can use the interface for arbitrary data access monitoring.
> > +
> > +         If unsure, say N.
> > +
> >  endmenu
> > diff --git a/mm/damon/Makefile b/mm/damon/Makefile
> > index 6ebbd08aed67..fed4be3bace3 100644
> > --- a/mm/damon/Makefile
> > +++ b/mm/damon/Makefile
> > @@ -2,3 +2,4 @@
> >
> >  obj-$(CONFIG_DAMON)            := core.o
> >  obj-$(CONFIG_DAMON_VADDR)      += vaddr.o
> > +obj-$(CONFIG_DAMON_DBGFS)      += dbgfs.o
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 5ca9f79ccbb6..b9575a6bebff 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -166,6 +166,37 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
> >         kfree(ctx);
> >  }
> >
> > +/**
> > + * damon_set_targets() - Set monitoring targets.
> > + * @ctx:       monitoring context
> > + * @ids:       array of target ids
> > + * @nr_ids:    number of entries in @ids
> > + *
> > + * This function should not be called while the kdamond is running.
> > + *
> > + * Return: 0 on success, negative error code otherwise.
> > + */
> > +int damon_set_targets(struct damon_ctx *ctx,
> > +                     unsigned long *ids, ssize_t nr_ids)
> > +{
> > +       ssize_t i;
> > +       struct damon_target *t, *next;
> > +
> > +       damon_for_each_target_safe(t, next, ctx)
> > +               damon_destroy_target(t);
> 
> You need to put the reference on the target before destroying.

Oops, you're right.  I will fix this in the next version.

> 
> > +
> > +       for (i = 0; i < nr_ids; i++) {
> > +               t = damon_new_target(ids[i]);
> > +               if (!t) {
> > +                       pr_err("Failed to alloc damon_target\n");
> > +                       return -ENOMEM;
> > +               }
> > +               damon_add_target(ctx, t);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  /**
> >   * damon_set_attrs() - Set attributes for the monitoring.
> >   * @ctx:               monitoring context
> > @@ -206,6 +237,20 @@ int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
> >         return 0;
> >  }
> >
> > +/**
> > + * damon_nr_running_ctxs() - Return number of currently running contexts.
> > + */
> > +int damon_nr_running_ctxs(void)
> > +{
> > +       int nr_ctxs;
> > +
> > +       mutex_lock(&damon_lock);
> > +       nr_ctxs = nr_running_ctxs;
> > +       mutex_unlock(&damon_lock);
> 
> READ_ONCE(nr_running_ctxs) ?

I'd like to keep the code simpler to read, unless this turns out to be a real
performance bottleneck.

> 
> > +
> > +       return nr_ctxs;
> > +}
> > +
[...]
> > +
> > +static ssize_t dbgfs_target_ids_write(struct file *file,
> > +               const char __user *buf, size_t count, loff_t *ppos)
> > +{
> > +       struct damon_ctx *ctx = file->private_data;
> > +       char *kbuf, *nrs;
> > +       unsigned long *targets;
> > +       ssize_t nr_targets;
> > +       ssize_t ret = count;
> > +       int i;
> > +       int err;
> > +
> > +       kbuf = user_input_str(buf, count, ppos);
> > +       if (IS_ERR(kbuf))
> > +               return PTR_ERR(kbuf);
> > +
> > +       nrs = kbuf;
> > +
> > +       targets = str_to_target_ids(nrs, ret, &nr_targets);
> > +       if (!targets) {
> > +               ret = -ENOMEM;
> > +               goto out;
> > +       }
> > +
> > +       if (targetid_is_pid(ctx)) {
> > +               for (i = 0; i < nr_targets; i++)
> > +                       targets[i] = (unsigned long)find_get_pid(
> > +                                       (int)targets[i]);
> > +       }
> > +
> > +       mutex_lock(&ctx->kdamond_lock);
> > +       if (ctx->kdamond) {
> > +               ret = -EINVAL;
> > +               goto unlock_out;
> 
> You need to put_pid on the targets array.

Good catch!

> 
> > +       }
> > +
> > +       err = damon_set_targets(ctx, targets, nr_targets);
> > +       if (err)
> > +               ret = err;
> 
> You need to handle the partial failure from damon_set_targets().

My intention is to keep partial success as is.

> 
> 
> > +unlock_out:
> > +       mutex_unlock(&ctx->kdamond_lock);
> > +       kfree(targets);
> > +out:
> > +       kfree(kbuf);
> > +       return ret;
> > +}
[...]

Thanks,
SeongJae Park
