Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A17230BC09
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 11:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhBBKao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 05:30:44 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:46095 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhBBKak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 05:30:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1612261839; x=1643797839;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=2RDJc6PQy/jNoS1A1iab9BqoPd62gsRlaquyZUslpm4=;
  b=K8J0hrg5Vzscfd3VWNzeLciKKhmA9zUckP2kMiWyHxrfG2hzFy0R2p7f
   ii3a/ALOoLiwAb6EW7K+jsY4bCEnzzKmdC0JXIy901K4+/5TdYwx1GWVE
   Z9NGpxM1YYylz/L9mfQAt+pCdJ9wo5A+ovSsXlEOCb/R0dIfIYlFpkABK
   g=;
X-IronPort-AV: E=Sophos;i="5.79,394,1602547200"; 
   d="scan'208";a="79018249"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 02 Feb 2021 10:29:49 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com (Postfix) with ESMTPS id AE3E5A176A;
        Tue,  2 Feb 2021 10:29:46 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.208) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 2 Feb 2021 10:29:29 +0000
From:   SeongJae Park <sjpark@amazon.com>
CC:     Shakeel Butt <shakeelb@google.com>, <Jonathan.Cameron@huawei.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>, <acme@kernel.org>,
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
Date:   Tue, 2 Feb 2021 11:29:15 +0100
Message-ID: <20210202102915.19902-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.208]
X-ClientProxiedBy: EX13D27UWB004.ant.amazon.com (10.43.161.101) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 1 Feb 2021 09:37:39 -0800 Shakeel Butt <shakeelb@google.com> wrote:
> 
> > On Tue, Dec 15, 2020 at 3:59 AM SeongJae Park <sjpark@amazon.com> wrote:
> > >
> > > From: SeongJae Park <sjpark@amazon.de>
> > >
> > > DAMON is designed to be used by kernel space code such as the memory
> > > management subsystems, and therefore it provides only kernel space API.
> > 
> > Which kernel space APIs are being referred here?
> 
> The symbols in 'include/linux/damon.h'
> 
> > 
> > > That said, letting the user space control DAMON could provide some
> > > benefits to them.  For example, it will allow user space to analyze
> > > their specific workloads and make their own special optimizations.
> > >
> > > For such cases, this commit implements a simple DAMON application kernel
> > > module, namely 'damon-dbgfs', which merely wraps the DAMON api and
> > > exports those to the user space via the debugfs.
> > >
> [...]
> > > +static ssize_t dbgfs_target_ids_write(struct file *file,
> > > +               const char __user *buf, size_t count, loff_t *ppos)
> > > +{
> > > +       struct damon_ctx *ctx = file->private_data;
> > > +       char *kbuf, *nrs;
> > > +       unsigned long *targets;
> > > +       ssize_t nr_targets;
> > > +       ssize_t ret = count;
> > > +       int i;
> > > +       int err;
> > > +
> > > +       kbuf = user_input_str(buf, count, ppos);
> > > +       if (IS_ERR(kbuf))
> > > +               return PTR_ERR(kbuf);
> > > +
> > > +       nrs = kbuf;
> > > +
> > > +       targets = str_to_target_ids(nrs, ret, &nr_targets);
> > > +       if (!targets) {
> > > +               ret = -ENOMEM;
> > > +               goto out;
> > > +       }
> > > +
> > > +       if (targetid_is_pid(ctx)) {
> > > +               for (i = 0; i < nr_targets; i++)
> > > +                       targets[i] = (unsigned long)find_get_pid(
> > > +                                       (int)targets[i]);
> > > +       }
> > > +
> > > +       mutex_lock(&ctx->kdamond_lock);
> > > +       if (ctx->kdamond) {
> > > +               ret = -EINVAL;
> > > +               goto unlock_out;
> > 
> > You need to put_pid on the targets array.
> 
> Good catch!
> 
> > 
> > > +       }
> > > +
> > > +       err = damon_set_targets(ctx, targets, nr_targets);
> > > +       if (err)
> > > +               ret = err;
> > 
> > You need to handle the partial failure from damon_set_targets().
> 
> My intention is to keep partial success as is.

But, we should put_pid() partial failures...  I will simply make this to
completely fail with no registered target.


Thanks,
SeongJae Park
[...]
