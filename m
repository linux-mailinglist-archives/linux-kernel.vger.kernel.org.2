Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AC63589F3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhDHQoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:44:46 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:34786 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhDHQom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:44:42 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id CD32E72C8B1;
        Thu,  8 Apr 2021 19:44:28 +0300 (MSK)
Received: from example.org (ip-94-113-225-162.net.upcbroadband.cz [94.113.225.162])
        by imap.altlinux.org (Postfix) with ESMTPSA id 9991E4A4726;
        Thu,  8 Apr 2021 19:44:27 +0300 (MSK)
Date:   Thu, 8 Apr 2021 18:44:26 +0200
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>, zhengjun.xing@intel.com,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: 08ed4efad6: stress-ng.sigsegv.ops_per_sec -41.9% regression
Message-ID: <20210408164426.o5cfvv3ixowsto62@example.org>
References: <7abe5ab608c61fc2363ba458bea21cf9a4a64588.1617814298.git.gladkov.alexey@gmail.com>
 <20210408083026.GE1696@xsang-OptiPlex-9020>
 <CAHk-=wigPx+MMQMQ-7EA0pq5_5+kMCNV4qFsOss-WwdCSQmb-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wigPx+MMQMQ-7EA0pq5_5+kMCNV4qFsOss-WwdCSQmb-w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 09:22:40AM -0700, Linus Torvalds wrote:
> On Thu, Apr 8, 2021 at 1:32 AM kernel test robot <oliver.sang@intel.com> wrote:
> >
> > FYI, we noticed a -41.9% regression of stress-ng.sigsegv.ops_per_sec due to commit
> > 08ed4efad684 ("[PATCH v10 6/9] Reimplement RLIMIT_SIGPENDING on top of ucounts")
> 
> Ouch.
> 
> I *think* this test may be testing "send so many signals that it
> triggers the signal queue overflow case".
> 
> And I *think* that the performance degradation may be due to lots of
> unnecessary allocations, because ity looks like that commit changes
> __sigqueue_alloc() to do
> 
>         struct sigqueue *q = kmem_cache_alloc(sigqueue_cachep, flags);
> 
> *before* checking the signal limit, and then if the signal limit was
> exceeded, it will just be free'd instead.
> 
> The old code would check the signal count against RLIMIT_SIGPENDING
> *first*, and if there were m ore pending signals then it wouldn't do
> anything at all (including not incrementing that expensive atomic
> count).
> 
> Also, the old code was very careful to only do the "get_user()" for
> the *first* signal it added to the queue, and do the "put_user()" for
> when removing the last signal. Exactly because those atomics are very
> expensive.
> 
> The new code just does a lot of these atomics unconditionally.

Yes and right now I'm trying to rewrite this patch.

> I dunno. The profile data in there is a bit hard to read, but there's
> a lot more cachee misses, and a *lot* of node crossers:
> 
> >    5961544          +190.4%   17314361        perf-stat.i.cache-misses
> >   22107466          +119.2%   48457656        perf-stat.i.cache-references
> >     163292 ą  3%   +4582.0%    7645410        perf-stat.i.node-load-misses
> >     227388 ą  2%   +3708.8%    8660824        perf-stat.i.node-loads
> 
> and (probably as a result) average instruction costs have gone up enormously:
> 
> >       3.47           +66.8%       5.79        perf-stat.overall.cpi
> >      22849           -65.6%       7866        perf-stat.overall.cycles-between-cache-misses
> 
> and it does seem to be at least partly about "put_ucounts()":
> 
> >       0.00            +4.5        4.46        perf-profile.calltrace.cycles-pp.put_ucounts.__sigqueue_free.get_signal.arch_do_signal_or_restart.exit_to_user_mode_prepare
> 
> and a lot of "get_ucounts()".
> 
> But it may also be that the new "get sigpending" is just *so* much
> more expensive than it used to be.

Thanks for decrypting this! I spent some time to understand this report
and still wasn't sure I understood it.

-- 
Rgrds, legion

