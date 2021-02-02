Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A7C30C455
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 16:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbhBBPso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 10:48:44 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:3118 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbhBBPqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 10:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1612280810; x=1643816810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=Id0o2WokyPHWrS8RD/cb5cRLc0A+ZuQ8G+JvdkxiJ/4=;
  b=cnuEaRbww26fhzmLJUO0VQq/MfR3SeJQ/a51/rjBm+GvYRWcTyxfncLY
   1s5XR61jy4Qw7/vFlLZD7riOex8byYLDhLNzzFjKqAAvuqLuwsCQuuqSl
   tCSpnHMdU1ppQ3dTqYPk+lDsWQ5m2nAoRMCG44LAI62GHGvb/KBmZ9DYT
   c=;
X-IronPort-AV: E=Sophos;i="5.79,395,1602547200"; 
   d="scan'208";a="115209270"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 02 Feb 2021 15:45:49 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id 9A41AA1F01;
        Tue,  2 Feb 2021 15:45:37 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.247) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 2 Feb 2021 15:45:20 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     SeongJae Park <sjpark@amazon.com>,
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
Subject: RE: [PATCH v23 07/15] mm/damon: Implement a debugfs-based user space interface
Date:   Tue, 2 Feb 2021 16:45:06 +0100
Message-ID: <20210202154506.29682-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod7tv=z3XwGx3pn5qNHQd1EAnhvBaM3EGRjWmo7G2RJEuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.247]
X-ClientProxiedBy: EX13D46UWC001.ant.amazon.com (10.43.162.126) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Feb 2021 07:07:24 -0800 Shakeel Butt <shakeelb@google.com> wrote:

> On Tue, Feb 2, 2021 at 2:30 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> >> On Mon, 1 Feb 2021 09:37:39 -0800 Shakeel Butt <shakeelb@google.com> wrote:
> >>
> >>> On Tue, Dec 15, 2020 at 3:59 AM SeongJae Park <sjpark@amazon.com> wrote:
> >>>>
> >>>> From: SeongJae Park <sjpark@amazon.de>
> >>>>
> >>>> DAMON is designed to be used by kernel space code such as the memory
> >>>> management subsystems, and therefore it provides only kernel space API.
> >>>
> >>> Which kernel space APIs are being referred here?
> >>
> >> The symbols in 'include/linux/damon.h'
> >>
> >>>
> >>>> That said, letting the user space control DAMON could provide some
> >>>> benefits to them.  For example, it will allow user space to analyze
> >>>> their specific workloads and make their own special optimizations.
> >>>>
> >>>> For such cases, this commit implements a simple DAMON application kernel
> >>>> module, namely 'damon-dbgfs', which merely wraps the DAMON api and
> >>>> exports those to the user space via the debugfs.
> >>>>
> >> [...]
> >>>> +static ssize_t dbgfs_target_ids_write(struct file *file,
> >>>> +               const char __user *buf, size_t count, loff_t *ppos)
> >>>> +{
> >>>> +       struct damon_ctx *ctx = file->private_data;
> >>>> +       char *kbuf, *nrs;
> >>>> +       unsigned long *targets;
> >>>> +       ssize_t nr_targets;
> >>>> +       ssize_t ret = count;
> >>>> +       int i;
> >>>> +       int err;
> >>>> +
> >>>> +       kbuf = user_input_str(buf, count, ppos);
> >>>> +       if (IS_ERR(kbuf))
> >>>> +               return PTR_ERR(kbuf);
> >>>> +
> >>>> +       nrs = kbuf;
> >>>> +
> >>>> +       targets = str_to_target_ids(nrs, ret, &nr_targets);
> >>>> +       if (!targets) {
> >>>> +               ret = -ENOMEM;
> >>>> +               goto out;
> >>>> +       }
> >>>> +
> >>>> +       if (targetid_is_pid(ctx)) {
> >>>> +               for (i = 0; i < nr_targets; i++)
> >>>> +                       targets[i] = (unsigned long)find_get_pid(
> >>>> +                                       (int)targets[i]);
> >>>> +       }
> >>>> +
> >>>> +       mutex_lock(&ctx->kdamond_lock);
> >>>> +       if (ctx->kdamond) {
> >>>> +               ret = -EINVAL;
> >>>> +               goto unlock_out;
> >>>
> >>> You need to put_pid on the targets array.
> >>
> >> Good catch!
> >>
> >>>
> >>>> +       }
> >>>> +
> >>>> +       err = damon_set_targets(ctx, targets, nr_targets);
> >>>> +       if (err)
> >>>> +               ret = err;
> >>>
> >>> You need to handle the partial failure from damon_set_targets().
> >>
> >> My intention is to keep partial success as is.
> >
> > But, we should put_pid() partial failures...  I will simply make this to
> > completely fail with no registered target.
> >
> 
> You can simplify by simply restricting to one pid/target per each write syscall.

Right, thanks for the suggestion.  However, I already almost finished writing
the fix.  If there is no other concern, I'd like to keep current interface.


Thanks,
SeongJae Park
