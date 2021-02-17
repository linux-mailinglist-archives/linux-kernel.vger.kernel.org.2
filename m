Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F2531D809
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhBQLP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:15:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:37262 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231400AbhBQLPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:15:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613560480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PH6CC7cRBkshSV2InMuUxMWSwr3BBhT4qwE65U+YVvU=;
        b=QUZ0dRgEsYA2HRhsgpmyhdUAomeYpEZtLJAIuFtEa2HJ4O1K47cDQqiUaUzMZnUZbJonno
        PNx0CqExSHIIPTuhpJIEUahBInpf4rK+kKCyUr4GbofrahWW82RQZ9RBlQf1zppXNqwh87
        S7bnAWWMn9ZFXV3OLDH4iyIWuFuxRYE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 93DC5AEC4;
        Wed, 17 Feb 2021 11:14:40 +0000 (UTC)
Date:   Wed, 17 Feb 2021 12:14:39 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Yiwei Zhang <zzyiwei@android.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jens Axboe <axboe@kernel.dk>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ilias Stamatis <stamatis.iliass@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Liang Chen <cl@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH] kthread: add kthread_mod_pending_delayed_work api
Message-ID: <YCz6nz4i136z1+H1@alley>
References: <20210214000611.2169820-1-zzyiwei@android.com>
 <20210216091128.GA3973504@infradead.org>
 <CAKB3++aXuCS3WRf1mfrM2oZ0KiJ4xP4ib-ZbJXr8cXVEkU-sXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKB3++aXuCS3WRf1mfrM2oZ0KiJ4xP4ib-ZbJXr8cXVEkU-sXw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-02-16 10:58:36, Yiwei Zhang wrote:
> On Mon, Feb 15, 2021 at 5:28 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Sun 2021-02-14 00:06:11, Yiwei Zhang wrote:
> > > The existing kthread_mod_delayed_work api will queue a new work if
> > > failing to cancel the current work due to no longer being pending.
> > > However, there's a case that the same work can be enqueued from both
> > > an async request and a delayed work, and a racing could happen if the
> > > async request comes right after the timeout delayed work gets
> > > scheduled,
> >
> > By other words, you want to modify the delayed work only when
> > it is still waiting in the queue. You do not want to queue new
> > work when it has not been already queued. Do I get it correctly?
> >
> Yes, you are correct.
> 
> > Could you please provide a patch where the new API is used?
> >
> Currently it will only get used in a downstream gpu driver.
> 
> > > because the clean up work may not be safe to run twice.
> >
> > This looks like a bad design of the code. There is likely
> > another race that might break it. You should ask the following
> > questions:
> >
> > Why anyone tries to modify the clean up work when it has been already
> > queued? There should be only one location/caller that triggers the clean up.
> >
> The clean up work was initially queued as a safe timeout work just in
> case the userspace doesn't queue the cleanup work(e.g. process
> crashing), which leaves the global driver in an incorrect driver
> state(e.g. power state due to some hinting). In addition, the cleanup
> work will also have to clean the cache allocated work struct as well
> in the racing scenario.
> 
> > Could anyone queue any work to the workqueue after the clean up
> > work was queued? The cleanup work should be the last queued one.
> > The workqueue user must inform all other users that the queue
> > is being destroyed and nobody is allowed to queue any work
> > any longer.
> >
> User can queue the initial work(internally it queues a cleanup work
> with a big timeout in case user doesn't queue it later). Then after
> user has done stuff within the scope, the user will queue the cleanup
> work again to cancel out the effect, which is when it may race with
> the underlying timeout'ed cleanup work.

And this is exactly the design problem. If there race is possible
then there are three possible scenarios:

1. User does the clean up before the timeout. This is the scenario
   where things work as expected.

2. User triggered clean up races with the clean up triggered by
   timeout. You try to handle this scenario by this patch.

3. User does clean up after the clean up has already been done
   by the timeout. It means that the user used the driver after
   it has already been cleaned up. This should not happen.
   I guess that the user commands will fail when the device has
   been cleaned up in the meantime.

By other words, you are focusing on a small race window. But there
is much bigger problem when the user could still use the cleaned
up driver.

There must be a better solution. You should avoid the timer because
it is not reliable. The following comes to my mind:

1. The userspace application might do the clean up from SIGKILL
   handler. It will do the clean up even when it crashes. But you
   would still rely on userspace to do the correct thing.

2. I do not see a clean solution in kernel

    One possibility might be to register something called from
   __put_task_struct(). It seems profile_handoff_task() calls
   some notifiers that can be registered from anywhere.

   Another possibility might be to register a notifier called by
   profile_task_exit(tsk) that is called from do_exit().

   It is not a clean solution because profile_task has another
   purpose. It might make sense to introduce a new generic notifier
   that is called during the task exit for this purpose.
   I am sure that it might have even more users.

   Anyway, look for put_task_struct(). It seems to be called in some
   drivers when destroying. I wonder if there is something that
   you might need.

Best Regards,
Petr
