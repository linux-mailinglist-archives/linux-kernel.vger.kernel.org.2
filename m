Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9301C4226FE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 14:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhJEMrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 08:47:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234080AbhJEMrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:47:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BFEF61247;
        Tue,  5 Oct 2021 12:45:53 +0000 (UTC)
Date:   Tue, 5 Oct 2021 14:45:50 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Christie <michael.christie@oracle.com>, geert@linux-m68k.org,
        vverma@digitalocean.com, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 7/9] fork: Add worker flag to ignore signals
Message-ID: <20211005124550.cm3fff4i2eztwizw@wittgenstein>
References: <20211004192128.381453-1-michael.christie@oracle.com>
 <20211004192128.381453-8-michael.christie@oracle.com>
 <e3840acc-09c0-01bd-ad64-54e9d2dfb888@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3840acc-09c0-01bd-ad64-54e9d2dfb888@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 02:04:12PM -0600, Jens Axboe wrote:
> On 10/4/21 1:21 PM, Mike Christie wrote:
> > The kthread API creates threads that ignore all signals by default so
> > modules like vhost that will move from that API to kernel_worker will
> > not be expecting them. This patch adds a worker flag that tells
> > kernel_worker to setup the task to ignore signals.
> > 
> > Signed-off-by: Mike Christie <michael.christie@oracle.com>
> > Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> >  include/linux/sched/task.h |  1 +
> >  kernel/fork.c              | 11 ++++++++++-
> >  2 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> > index 781abbc1c288..aefa0d221b57 100644
> > --- a/include/linux/sched/task.h
> > +++ b/include/linux/sched/task.h
> > @@ -21,6 +21,7 @@ struct css_set;
> >  #define KERN_WORKER_IO		BIT(0)
> >  #define KERN_WORKER_USER	BIT(1)
> >  #define KERN_WORKER_NO_FILES	BIT(2)
> > +#define KERN_WORKER_NO_SIGS	BIT(3)
> >  
> >  struct kernel_clone_args {
> >  	u64 flags;
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 3f3fcabffa5f..34d3dca70cfb 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -2555,6 +2555,8 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
> >  struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
> >  				  unsigned long clone_flags, u32 worker_flags)
> >  {
> > +	struct task_struct *tsk;
> > +
> >  	struct kernel_clone_args args = {
> >  		.flags		= ((lower_32_bits(clone_flags) | CLONE_VM |
> >  				   CLONE_UNTRACED) & ~CSIGNAL),
> > @@ -2564,7 +2566,14 @@ struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
> >  		.worker_flags	= KERN_WORKER_USER | worker_flags,
> >  	};
> >  
> > -	return copy_process(NULL, 0, node, &args);
> > +	tsk = copy_process(NULL, 0, node, &args);
> > +	if (IS_ERR(tsk))
> > +		return tsk;
> > +
> > +	if (worker_flags & KERN_WORKER_NO_SIGS)
> > +		ignore_signals(tsk);
> > +
> > +	return tsk;
> 
> When I originally did it this way, Eric (correctly) pointed out that
> it's racy. See where it's currently done as part of copy_process(), not
> after.

Since this is mirroring kthread's sig ignore api introduced in commit
10ab825bdef8 ("change kernel threads to ignore signals instead of
blocking them") to ease the transition into the new api we should also
rename KERNEL_WORKER_NO_SIGS to KERNEL_WORKER_SIG_IGN to reflect that in
the name.
Ignoring signals should be moved into copy_process() after
copy_sighand() and copy_signals().
Aside from that we should introduce a helper that verifies the arguments
passed to kernel_worker() are sane so we don't end up with garbage in
there by surprise (CLONE_SIGHAND and CLONE_CLEAR_SIGHAND don't make
sense with KERNEL_WORKER_SIG_IGN). So this should give us sm like:

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 7a5142dcde1b..59891db97d87 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -596,7 +596,7 @@ static int vhost_worker_create(struct vhost_dev *dev)
         */
        task = kernel_worker(vhost_worker, worker, NUMA_NO_NODE,
                             CLONE_FS | CLONE_CLEAR_SIGHAND,
-                            KERN_WORKER_NO_FILES | KERN_WORKER_NO_SIGS);
+                            KERN_WORKER_NO_FILES | KERN_WORKER_SIG_IGN);
        if (IS_ERR(task)) {
                ret = PTR_ERR(task);
                goto free_worker;
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index aefa0d221b57..b4f6007f335b 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -21,7 +21,7 @@ struct css_set;
 #define KERN_WORKER_IO         BIT(0)
 #define KERN_WORKER_USER       BIT(1)
 #define KERN_WORKER_NO_FILES   BIT(2)
-#define KERN_WORKER_NO_SIGS    BIT(3)
+#define KERN_WORKER_SIG_IGN    BIT(3)

 struct kernel_clone_args {
        u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index 34d3dca70cfb..874c356b3e9f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2212,6 +2212,9 @@ static __latent_entropy struct task_struct *copy_process(
        if (retval)
                goto bad_fork_cleanup_io;

+       if (args->worker_flags & KERN_WORKER_SIG_IGN)
+               ignore_signals(p);
+
        stackleak_task_init(p);

        if (pid != &init_struct_pid) {
@@ -2540,6 +2543,24 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
        return copy_process(NULL, 0, node, &args);
 }

+static bool kernel_worker_flags_valid(struct kernel_clone_args *kargs)
+{
+       /* Verify that no unknown flags are passed along. */
+       if (kargs->worker_flags & ~(KERN_WORKER_IO | KERN_WORKER_USER |
+                                   KERN_WORKER_NO_FILES | KERN_WORKER_SIG_IGN))
+               return false;
+
+       /*
+        * If we're ignoring all signals don't allow sharing struct sighand and
+        * don't bother clearing signal handlers.
+        */
+       if ((kargs->flags & (CLONE_SIGHAND | CLONE_CLEAR_SIGHAND)) &&
+           (kargs->worker_flags & KERN_WORKER_SIG_IGN))
+               return false;
+
+       return true;
+}
+
 /**
  * kernel_worker - create a copy of a process to be used by the kernel
  * @fn: thread stack
@@ -2555,8 +2576,6 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
                                  unsigned long clone_flags, u32 worker_flags)
 {
-       struct task_struct *tsk;
-
        struct kernel_clone_args args = {
                .flags          = ((lower_32_bits(clone_flags) | CLONE_VM |
                                   CLONE_UNTRACED) & ~CSIGNAL),
@@ -2566,14 +2585,10 @@ struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
                .worker_flags   = KERN_WORKER_USER | worker_flags,
        };

-       tsk = copy_process(NULL, 0, node, &args);
-       if (IS_ERR(tsk))
-               return tsk;
-
-       if (worker_flags & KERN_WORKER_NO_SIGS)
-               ignore_signals(tsk);
+       if (!kernel_worker_flags_valid(&args))
+               return ERR_PTR(-EINVAL);

-       return tsk;
+       return copy_process(NULL, 0, node, &args);
 }
 EXPORT_SYMBOL_GPL(kernel_worker);

