Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927B5428E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 15:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237247AbhJKNmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 09:42:16 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:54580 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237236AbhJKNlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:41:50 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 8923872C8C6;
        Mon, 11 Oct 2021 16:39:48 +0300 (MSK)
Received: from example.org (ip-94-112-79-42.net.upcbroadband.cz [94.112.79.42])
        by imap.altlinux.org (Postfix) with ESMTPSA id D961C4A46FC;
        Mon, 11 Oct 2021 16:39:47 +0300 (MSK)
Date:   Mon, 11 Oct 2021 15:39:46 +0200
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        containers@lists.linux-foundation.org,
        Rune Kleveland <rune.kleveland@infomedia.dk>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: linux 5.14.3: free_user_ns causes NULL pointer dereference
Message-ID: <20211011133946.nazptxobh7g5naug@example.org>
References: <OJK-F2NSBlem52GqvCQYzaVxs2x9Csq3qO4QbTG4A4UUNaQpebpAQmyyKzUd70CIo27C4K7CL3bhIzcxulIzYMu067QOMXCFz8ejh3ZtFhE=@protonmail.ch>
 <U6ByMUZ9LgvxXX6eb0M9aBx8cw8GpgE1qU22LaxaJ_2bOdnGLLJHDgnLL-6cJT7dKdcG_Ms37APSutc3EIMmtpgpP_2kotVLCNRoUq-wTJ8=@protonmail.ch>
 <878rzw77i3.fsf@disp2133>
 <o3tuBB58KUQjyQsALqWi0s1tSPlgVPST4PNNjHewIgRB7CUOOVyFSFxSBLCOJdUH3ly21cIjBthNyqQGnDgJD7fjU8NiVHq7i0JcMvYuzUA=@protonmail.ch>
 <20210929173611.fo5traia77o63gpw@example.org>
 <hPgvCJ2KbKeauk78uWJEsuKJ5VfMqknPJ_oyOZe6M78-6eG7qnj0t0UKC-joPVowo_nOikIsEWP-ZDioARfI-Cl6zrHjCHPJST3drpi5ALE=@protonmail.ch>
 <20210930130640.wudkpmn3cmah2cjz@example.org>
 <CAOUHufZmAjuKyRcmq6GH8dfdZxchykS=BTZDsk-gDAh3LJTe1Q@mail.gmail.com>
 <878rz8wwb6.fsf@disp2133>
 <87v92cvhbf.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v92cvhbf.fsf@disp2133>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 12:19:16PM -0500, Eric W. Biederman wrote:
> ebiederm@xmission.com (Eric W. Biederman) writes:
> 
> > Adding Rune Kleveland to the discussion as he also seems to have
> > reproduced the issue.
> >
> > Alex and I have been starring at the code and the reports and this
> > bug is hiding well.  Here is what we have figured out so far.
> >
> > Both the warning from free_user_ns calling dec_ucount that Jordan Glover
> > reported and the KASAN error that Yu Zhao has reported appear to have
> > the same cause.  Using a ucounts structure after it has been freed and
> > reallocated as something else.
> >
> > I have just skimmed through the recent report from Rune Kleveland
> > and it appears also to be a use after free.  Especially since the
> > second failure in the log is slub complaining about trying to free
> > the ucounts data structure.
> >
> > We looked through the users of put_ucounts and we don't see any obvious
> > buggy users that would be freeing the data structure early.
> >
> > Alex has tried to reproduce this so far is not having any luck.
> > Folks can you tell what compiler versions you are using and share your
> > kernel config with us?  That might help.
> >
> > The little debug diff below is my guess of what is happening.  If the
> > folks who can reproduce this issue can try the patch below and let me
> > know if the warnings fire that would be appreciated.  It is still not
> > enough to track down the bug but at least it will confirm my current
> > hypothesis about how things look before there is a use of memory after
> > it is freed.
> 
> Bah.  Scratch that test patch.  I just double checked myself and
> cred->ucounts and cred->user_ns->ucounts should never be equal,
> as the user namespace is counted in it's parent user namespace.
> 
> That observation now tells me I have a parent user namespace that went
> corrupt.
> 
> Back to the drawing board.
> 
> 
> > Thank you,
> > Eric
> >
> > diff --git a/kernel/cred.c b/kernel/cred.c
> > index f784e08c2fbd..e7ffaa3cf5a6 100644
> > --- a/kernel/cred.c
> > +++ b/kernel/cred.c
> > @@ -120,6 +120,12 @@ static void put_cred_rcu(struct rcu_head *rcu)
> >  	if (cred->group_info)
> >  		put_group_info(cred->group_info);
> >  	free_uid(cred->user);
> > +#if 1
> > +	if ((cred->ucounts == cred->user_ns->ucounts) &&
> > +	    (atomic_read(&cred->ucounts->count) == 1)) {
> > +		WARN_ONCE(1, "put_cred_rcu: ucount count 1\n");
> > +	}
> > +#endif
> >  	if (cred->ucounts)
> >  		put_ucounts(cred->ucounts);
> >  	put_user_ns(cred->user_ns);
> > diff --git a/kernel/exit.c b/kernel/exit.c
> > index 91a43e57a32e..60fd88b34c1a 100644
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -743,6 +743,13 @@ void __noreturn do_exit(long code)
> >  	if (unlikely(!tsk->pid))
> >  		panic("Attempted to kill the idle task!");
> >  
> > +#if 1
> > +	if ((tsk->cred->ucounts == tsk->cred->user_ns->ucounts) &&
> > +	    (atomic_read(tsk->cred->ucounts->count) == 1)) {
> > +		WARN_ONCE(1, "do_exit: ucount count 1\n");
> > +	}
> > +#endif
> > +
> >  	/*
> >  	 * If do_exit is called because this processes oopsed, it's possible
> >  	 * that get_fs() was left as KERNEL_DS, so reset it to USER_DS before
> 

It looks like I found a fairly reliable reproducer. I'm able to reproduce
the problem on ARCH=um.

I added a bit of debugging and it looks like the namespace has a reference
count problem:

[    6.970000] ------------[ cut here ]------------
[    6.970000] WARNING: CPU: 0 PID: 18 at kernel/ucount.c:257 dec_ucount+0x86/0xfc
[    6.970000] dec_ucounts: accessing freed ucounts: 0000000061202780
                                                     ^^^^^^^^^^^^^^^^

This is a pointer to the freed ucounts.

[    6.970000] Modules linked in:
[    6.970000] CPU: 0 PID: 18 Comm: kworker/u2:1 Tainted: G        W         5.15.0-rc3-00082-ga81d1c67022e-dirty #14
[    6.970000] Workqueue: netns cleanup_net
[    6.970000] Stack:
[    6.970000]  800bfca0 602693cb 603d3767 00000000
[    6.970000]  6048c52d 00000009 603d23b5 60046b28
[    6.970000]  800bfcc0 603d37a7 603d3767 800bfd20
[    6.970000] Call Trace:
[    6.970000]  [<603d23b5>] ? _printk+0x0/0xa1
[    6.970000]  [<600238df>] show_stack+0x14b/0x15a
[    6.970000]  [<602693cb>] ? dump_stack_print_info+0xeb/0xfa
[    6.970000]  [<603d3767>] ? dump_stack+0x0/0x45
[    6.970000]  [<603d23b5>] ? _printk+0x0/0xa1
[    6.970000]  [<60046b28>] ? __local_bh_enable_ip+0x0/0xf8
[    6.970000]  [<603d37a7>] dump_stack+0x40/0x45
[    6.970000]  [<603d3767>] ? dump_stack+0x0/0x45
[    6.970000]  [<60043633>] __warn+0x101/0x149
[    6.970000]  [<603d1559>] warn_slowpath_fmt+0xde/0xec
[    6.970000]  [<6003953b>] ? set_signals+0x0/0x48
[    6.970000]  [<60265087>] ? free_object+0x1d/0x73
[    6.970000]  [<603d147b>] ? warn_slowpath_fmt+0x0/0xec
[    6.970000]  [<60083a2d>] ? destroy_rcu_head+0x27/0x29
[    6.970000]  [<60083ba3>] ? __wait_rcu_gp+0x12d/0x14f
[    6.970000]  [<600846bb>] ? rcu_barrier+0x0/0x40
[    6.970000]  [<6006471d>] dec_ucount+0x86/0xfc
[    6.970000]  [<60064697>] ? dec_ucount+0x0/0xfc
[    6.970000]  [<6031221f>] cleanup_net+0x2cb/0x326
[    6.970000]  [<60039468>] ? unblock_signals+0x0/0xd3
[    6.970000]  [<60059daa>] process_one_work+0x1e1/0x2df
[    6.970000]  [<60039445>] ? block_signals+0x0/0x23
[    6.970000]  [<6003947c>] ? unblock_signals+0x14/0xd3
[    6.970000]  [<6005658e>] ? move_linked_works+0x0/0x8a
[    6.970000]  [<6005a49c>] worker_thread+0x293/0x3c0
[    6.970000]  [<600566bc>] ? set_pf_worker+0x0/0x6d
[    6.970000]  [<6005ecf2>] ? arch_local_irq_save+0x0/0x29
[    6.970000]  [<60045960>] ? do_exit+0x0/0x93e
[    6.970000]  [<6005a209>] ? worker_thread+0x0/0x3c0
[    6.970000]  [<60060554>] kthread+0x171/0x179
[    6.970000]  [<6002230e>] new_thread_handler+0x8e/0xbf
[    6.970000] ---[ end trace 02feadf6f35abde2 ]---
[    6.970000]
[    6.970000] Modules linked in:
[    6.970000] Pid: 18, comm: kworker/u2:1 Tainted: G        W         5.15.0-rc3-00082-ga81d1c67022e-dirty
[    6.970000] RIP: 0033:[<000000006006476f>]
[    6.970000] RSP: 00000000800bfe20  EFLAGS: 00010246
[    6.970000] RAX: 0000000000000000 RBX: 0000000000000048 RCX: 0000000000000000
[    6.970000] RDX: 00000000612027c8 RSI: 00000000ffffffff RDI: 0000000000000009
[    6.970000] RBP: 00000000800bfe40 R08: 0000000060551bc8 R09: 0000000000015920
[    6.970000] R10: 00000000600203e0 R11: 0000000000015920 R12: 0000000061202780
[    6.970000] R13: 000000006057bca6 R14: 0000000061202780 R15: 0000000060046b28
[    6.970000] Kernel panic - not syncing: Segfault with no mm
[    6.970000] CPU: 0 PID: 18 Comm: kworker/u2:1 Tainted: G        W         5.15.0-rc3-00082-ga81d1c67022e-dirty #14
[    6.970000] Workqueue: netns cleanup_net
[    6.970000] Stack:
[    6.970000]  800bfe48 612d69c0 800bfe70 60064697
[    6.970000]  800bfeb0 6031221f ffffffff800bfe90 605735c0
[    6.970000]  60039468 ffff8d00 800bfe70 800bfe70
[    6.970000] Call Trace:
[    6.970000]  [<60064697>] ? dec_ucount+0x0/0xfc
[    6.970000]  [<6031221f>] cleanup_net+0x2cb/0x326
[    6.970000]  [<60039468>] ? unblock_signals+0x0/0xd3
[    6.970000]  [<60059daa>] process_one_work+0x1e1/0x2df
[    6.970000]  [<60039445>] ? block_signals+0x0/0x23
[    6.970000]  [<6003947c>] ? unblock_signals+0x14/0xd3
[    6.970000]  [<6005658e>] ? move_linked_works+0x0/0x8a
[    6.970000]  [<6005a49c>] worker_thread+0x293/0x3c0
[    6.970000]  [<600566bc>] ? set_pf_worker+0x0/0x6d
[    6.970000]  [<6005ecf2>] ? arch_local_irq_save+0x0/0x29
[    6.970000]  [<60045960>] ? do_exit+0x0/0x93e
[    6.970000]  [<6005a209>] ? worker_thread+0x0/0x3c0
[    6.970000]  [<60060554>] kthread+0x171/0x179
[    6.970000]  [<6002230e>] new_thread_handler+0x8e/0xbf

This is where this ucounts was created:

[    5.530000] ------------[ cut here ]------------
[    5.530000] WARNING: CPU: 0 PID: 216 at kernel/ucount.c:187 alloc_ucounts+0x174/0x189
[    5.530000] allooc_ucounts: new ucounts ucounts=0000000061202780
[    5.530000] Modules linked in:
[    5.530000] CPU: 0 PID: 216 Comm: unshare Tainted: G        W         5.15.0-rc3-00082-ga81d1c67022e-dirty #14
[    5.530000] Stack:
[    5.530000]  8045bb00 602693cb 603d3767 00000000
[    5.530000]  6048c52d 00000009 603d23b5 6063d388
[    5.530000]  8045bb20 603d37a7 603d3767 8045bb80
[    5.530000] Call Trace:
[    5.530000]  [<603d23b5>] ? _printk+0x0/0xa1
[    5.530000]  [<600238df>] show_stack+0x14b/0x15a
[    5.530000]  [<602693cb>] ? dump_stack_print_info+0xeb/0xfa
[    5.530000]  [<603d3767>] ? dump_stack+0x0/0x45
[    5.530000]  [<603d23b5>] ? _printk+0x0/0xa1
[    5.530000]  [<603d37a7>] dump_stack+0x40/0x45
[    5.530000]  [<603d3767>] ? dump_stack+0x0/0x45
[    5.530000]  [<60043633>] __warn+0x101/0x149
[    5.530000]  [<60039468>] ? unblock_signals+0x0/0xd3
[    5.530000]  [<603d1559>] warn_slowpath_fmt+0xde/0xec
[    5.530000]  [<60274613>] ? memcmp+0x0/0x2f
[    5.530000]  [<60039445>] ? block_signals+0x0/0x23
[    5.530000]  [<603d147b>] ? warn_slowpath_fmt+0x0/0xec
[    5.530000]  [<600ff06d>] ? arch_local_irq_save+0x0/0x29
[    5.530000]  [<600ff8d7>] ? slab_post_alloc_hook+0x5b/0x1ae
[    5.530000]  [<60039445>] ? block_signals+0x0/0x23
[    5.530000]  [<600645e2>] alloc_ucounts+0x174/0x189
[    5.530000]  [<600645f7>] ? inc_ucount+0x0/0xa0
[    5.530000]  [<60064618>] inc_ucount+0x21/0xa0
[    5.530000]  [<6012f6e0>] alloc_mnt_ns+0x53/0x193
[    5.530000]  [<600ff06d>] ? arch_local_irq_save+0x0/0x29
[    5.530000]  [<601334c6>] ? copy_mnt_ns+0x0/0x29e
[    5.530000]  [<60133570>] copy_mnt_ns+0xaa/0x29e
[    5.530000]  [<600609a6>] create_new_namespaces+0x7c/0x2b4
[    5.530000]  [<60060ed7>] unshare_nsproxy_namespaces+0xb1/0xcb
[    5.530000]  [<600b1111>] ? unshare_userns+0x4c/0x78
[    5.530000]  [<60042dcb>] ksys_unshare+0x179/0x345
[    5.530000]  [<60042fb4>] sys_unshare+0x1d/0x21
[    5.530000]  [<60025b0a>] handle_syscall+0x8e/0xbe
[    5.530000]  [<6003c471>] userspace+0x3cf/0x536
[    5.530000]  [<600223e0>] fork_handler+0xa1/0xa3
[    5.530000] ---[ end trace 02feadf6f35abdd7 ]---


-- 
Rgrds, legion

