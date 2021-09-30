Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1148F41DCB4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352003AbhI3Ox1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:53:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46860 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351935AbhI3Ox0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:53:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AA2232003B;
        Thu, 30 Sep 2021 14:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1633013502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7UMsJP7OUZHXdosqHccx8PfVbVZmFr+TX6TvsVLAlzc=;
        b=p9jN8Yu/BpaUeW4SkvSnWNgOZFT8eYkXWF5kfKD2iHa4ZAK41E9HtNVO69KcpRqfZ/w6/p
        8mKwf3SFDGcFiFbO99VDsahxQRiM2G4poXJjGvf2XOJq+VpOYLW5tAIjEhUkhJxKNiF5MT
        aMDLXu8ipzyoFNYYcp/fyqA1OAFqr+w=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 401D4A4666;
        Thu, 30 Sep 2021 14:51:42 +0000 (UTC)
Date:   Thu, 30 Sep 2021 16:51:42 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        Al Viro <viro@zeniv.linux.org.uk>, christian@brauner.io,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] kernel/fork: allocate task->comm dynamicly
Message-ID: <YVXO/hsDJQh1FOgy@alley>
References: <20210929115036.4851-1-laoar.shao@gmail.com>
 <20210929115036.4851-3-laoar.shao@gmail.com>
 <202109291109.FAF3F47BA@keescook>
 <CALOAHbB3_q0stoUyqZdScZR3_edJE5ncmys6HNiQrBZTEgGVMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbB3_q0stoUyqZdScZR3_edJE5ncmys6HNiQrBZTEgGVMw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-09-30 20:41:40, Yafang Shao wrote:
> On Thu, Sep 30, 2021 at 2:11 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Sep 29, 2021 at 11:50:33AM +0000, Yafang Shao wrote:
> > > task->comm is defined as an array embedded in struct task_struct before.
> > > This patch changes it to a char pointer. It will be allocated in the fork
> > > and freed when the task is freed.
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > ---
> > >  include/linux/sched.h |  2 +-
> > >  kernel/fork.c         | 19 +++++++++++++++++++
> > >  2 files changed, 20 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index e12b524426b0..b387b5943db4 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -1051,7 +1051,7 @@ struct task_struct {
> > >        * - access it with [gs]et_task_comm()
> > >        * - lock it with task_lock()
> > >        */
> > > -     char                            comm[TASK_COMM_LEN];
> > > +     char                            *comm;
> >
> > This, I think, is basically a non-starter. It adds another kmalloc to
> > the fork path without a well-justified reason. TASK_COMM_LEN is small,
> > yes, but why is growing it valuable enough to slow things down?
> >
> > (Or, can you prove that this does NOT slow things down? It seems like
> > it would.)
> >
> 
> Right, the new kmalloc would take some extra latency.
> Seems it is not easy to measure which one is more valuable.

Honestly, I do not think that this exercise is worth it. The patchset
adds a lot of complexity and potential problems just to extend
comm from 16 to 24 for kthreads.

Is the problem real or just cosmetic?

If you really want it then it would be much easier to increase
TASK_COMM_LEN. task_struct is growing rather regularly. Extra
8 bytes should be acceptable.

If you want to make it more acceptable then keep 16 for
CONFIG_BASE_SMALL.


> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index 38681ad44c76..227aec240501 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -753,6 +767,7 @@ void __put_task_struct(struct task_struct *tsk)
> > >       bpf_task_storage_free(tsk);
> > >       exit_creds(tsk);
> > >       delayacct_tsk_free(tsk);
> > > +     task_comm_free(tsk);

Just one example of the potential problems. Are you sure that nobody
will access tsk->comm after this point?

task->comm is widely used to describe the affected task_struct because
it is user friendly.

Also __put_task_struct() later calls also profile_handoff_task() that might
get registered even by some external module.

Best Regards,
Petr

PS: I think that the fork performance is important. It is tested by
benchmarks, for example, lmbench. But for me, the reliability is even
more important and any pointer/alloc/free just adds another weak
point.
