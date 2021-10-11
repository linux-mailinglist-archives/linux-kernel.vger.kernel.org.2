Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6B1428AFF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 12:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbhJKKrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 06:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235446AbhJKKr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 06:47:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 020F16023D;
        Mon, 11 Oct 2021 10:45:22 +0000 (UTC)
Date:   Mon, 11 Oct 2021 12:45:15 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 1/2] pid: add pidfd_get_task() helper
Message-ID: <20211011104515.exvbxumlxhw7deij@wittgenstein>
References: <20211004125050.1153693-1-christian.brauner@ubuntu.com>
 <20211004125050.1153693-2-christian.brauner@ubuntu.com>
 <be830537-18e4-d49b-720a-ca40785c4610@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be830537-18e4-d49b-720a-ca40785c4610@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 10:47:36AM +0200, David Hildenbrand wrote:
> On 04.10.21 14:50, Christian Brauner wrote:
> > The number of system calls making use of pidfds is constantly
> > increasing. Some of those new system calls duplicate the code to turn a
> > pidfd into task_struct it refers to. Give them a simple helper for this.
> > 
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Matthew Bobrowski <repnop@google.com>
> > Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> >   include/linux/pid.h |  1 +
> >   kernel/pid.c        | 34 ++++++++++++++++++++++++++++++++++
> >   2 files changed, 35 insertions(+)
> > 
> > diff --git a/include/linux/pid.h b/include/linux/pid.h
> > index af308e15f174..343abf22092e 100644
> > --- a/include/linux/pid.h
> > +++ b/include/linux/pid.h
> > @@ -78,6 +78,7 @@ struct file;
> >   extern struct pid *pidfd_pid(const struct file *file);
> >   struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
> > +struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
> >   int pidfd_create(struct pid *pid, unsigned int flags);
> >   static inline struct pid *get_pid(struct pid *pid)
> > diff --git a/kernel/pid.c b/kernel/pid.c
> > index efe87db44683..2ffbb87b2ce8 100644
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> > @@ -539,6 +539,40 @@ struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
> >   	return pid;
> >   }
> > +/**
> > + * pidfd_get_task() - Get the task associated with a pidfd
> > + *
> > + * @pidfd: pidfd for which to get the task
> > + * @flags: flags associated with this pidfd
> > + *
> > + * Return the task associated with the given pidfd.
> > + * Currently, the process identified by @pidfd is always a thread-group leader.
> > + * This restriction currently exists for all aspects of pidfds including pidfd
> > + * creation (CLONE_PIDFD cannot be used with CLONE_THREAD) and pidfd polling
> > + * (only supports thread group leaders).
> > + *
> > + * Return: On success, the task_struct associated with the pidfd.
> > + *	   On error, a negative errno number will be returned.
> 
> Nice doc.
> 
> You might want to document what callers of this function are expected to do
> to clean up.

That's a good idea! Let me add that.

> 
> 
> > + */
> > +struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags)
> > +{
> > +	unsigned int f_flags;
> > +	struct pid *pid;
> > +	struct task_struct *task;
> > +
> > +	pid = pidfd_get_pid(pidfd, &f_flags);
> > +	if (IS_ERR(pid))
> > +		return ERR_CAST(pid);
> > +
> > +	task = get_pid_task(pid, PIDTYPE_TGID);
> > +	put_pid(pid);
> 
> The code to be replaced always does the put_pid() after the
> put_task_struct(). Is this new ordering safe? (didn't check)

I at least see no obvious problems and so do think this is safe. 
The lifetimes of struct pid and struct task_struct are independent of
each other. They don't mess with each others refcounts. And the caller's
aren't going back from struct task_struct to struct pid anywhere.

> 
> > +	if (!task)
> > +		return ERR_PTR(-ESRCH);
> > +
> > +	*flags = f_flags;
> > +	return task;
> > +}
> > +
> >   /**
> >    * pidfd_create() - Create a new pid file descriptor.
> >    *
> > 
> 
> I'd have squashed this into the second patch, makes it a lot easier to
> review and it's only a MM cleanup at this point.

Hm, I prefer the split between introducing a helper and making use of a
helper. I find that nicer than mixing up the two steps. I only tend to
do both if it would introduce breakage.
