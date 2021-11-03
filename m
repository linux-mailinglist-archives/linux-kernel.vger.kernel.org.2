Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E3444480C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 19:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbhKCSQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 14:16:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230353AbhKCSPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 14:15:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F387E60FC2;
        Wed,  3 Nov 2021 18:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635963196;
        bh=KSzJMSseYebSjzbGvJOlhhgh11pmPhvGaI6rCmwiqAU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=T2RpNEFsmRoZB3W910dppPE61rIqeTVN9XEp5b+nn645WjSOVrd0CAb9lmF1OzN3c
         fQRXruGtzK6lDSFoc9uP/w0tssjJaMdUF7VFCP/IRLMV7NIWlIq/1JhFsoGp/O7bWk
         jUXEGAqPpSKC0U8pBuhPr0LtyywpoOnLab51k3LiMq9gQiVoLa8El4GSIHwbIldXBi
         FYRsCuKj/J0qRmE104aj+26kleU2VemNuiH7AyP09Hijp0Iemm0wN9sm1Z9+Cpjo0K
         2Rj3r3Y39QqP9KADVzuFkRkKgGy2I36S4qHXwUqqNZNwOWFUtHF52IvUOzPgdyyrIa
         wNbUsqgTnetag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C320A5C0848; Wed,  3 Nov 2021 11:13:15 -0700 (PDT)
Date:   Wed, 3 Nov 2021 11:13:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Jun Miao <jun.miao@windriver.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dmitry Vyukov <dvyukov@google.com>, qiang.zhang1211@gmail.com,
        RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        miaojun0823@163.com, ryabinin.a.a@gmail.com,
        Alexander Potapenko <glider@google.com>,
        jianwei.hu@windriver.com, melver@google.com
Subject: Re: [PATCH] rcu: avoid alloc_pages() when recording stack
Message-ID: <20211103181315.GT880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211101103158.3725704-1-jun.miao@windriver.com>
 <96f9d669-b9da-f387-199e-e6bf36081fbd@windriver.com>
 <CA+KHdyU98uHkf1VKbvFs0wcXz7SaizENRXn4BEpKJhe+KmXZuw@mail.gmail.com>
 <baa768a3-aacf-ba3a-8d20-0abc78eca2f7@windriver.com>
 <CA+KHdyUEtBQjh61Xx+4a-AS0+z18CW1W5GzaRVsihuy=PUpUxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KHdyUEtBQjh61Xx+4a-AS0+z18CW1W5GzaRVsihuy=PUpUxA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 02:55:48PM +0100, Uladzislau Rezki wrote:
> On Wed, Nov 3, 2021 at 7:51 AM Jun Miao <jun.miao@windriver.com> wrote:
> >
> >
> > On 11/2/21 10:53 PM, Uladzislau Rezki wrote:
> > > [Please note: This e-mail is from an EXTERNAL e-mail address]
> > >
> > >> Add KASAN maintainers
> > >>
> > >> On 11/1/21 6:31 PM, Jun Miao wrote:
> > >>> The default kasan_record_aux_stack() calls stack_depot_save() with GFP_NOWAIT,
> > >>> which in turn can then call alloc_pages(GFP_NOWAIT, ...).  In general, however,
> > >>> it is not even possible to use either GFP_ATOMIC nor GFP_NOWAIT in certain
> > >>> non-preemptive contexts/RT kernel including raw_spin_locks (see gfp.h and ab00db216c9c7).
> > >>>
> > >>> Fix it by instructing stackdepot to not expand stack storage via alloc_pages()
> > >>> in case it runs out by using kasan_record_aux_stack_noalloc().
> > >>>
> > >>> Jianwei Hu reported:
> > >>>    BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:969
> > >>>    in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 15319, name: python3
> > >>>    INFO: lockdep is turned off.
> > >>>    irq event stamp: 0
> > >>>    hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> > >>>    hardirqs last disabled at (0): [<ffffffff856c8b13>] copy_process+0xaf3/0x2590
> > >>>    softirqs last  enabled at (0): [<ffffffff856c8b13>] copy_process+0xaf3/0x2590
> > >>>    softirqs last disabled at (0): [<0000000000000000>] 0x0
> > >>>    CPU: 6 PID: 15319 Comm: python3 Tainted: G        W  O 5.15-rc7-preempt-rt #1
> > >>>    Hardware name: Supermicro SYS-E300-9A-8C/A2SDi-8C-HLN4F, BIOS 1.1b 12/17/2018
> > >>>    Call Trace:
> > >>>     show_stack+0x52/0x58
> > >>>     dump_stack+0xa1/0xd6
> > >>>     ___might_sleep.cold+0x11c/0x12d
> > >>>     rt_spin_lock+0x3f/0xc0
> > >>>     rmqueue+0x100/0x1460
> > >>>     rmqueue+0x100/0x1460
> > >>>     mark_usage+0x1a0/0x1a0
> > >>>     ftrace_graph_ret_addr+0x2a/0xb0
> > >>>     rmqueue_pcplist.constprop.0+0x6a0/0x6a0
> > >>>      __kasan_check_read+0x11/0x20
> > >>>      __zone_watermark_ok+0x114/0x270
> > >>>      get_page_from_freelist+0x148/0x630
> > >>>      is_module_text_address+0x32/0xa0
> > >>>      __alloc_pages_nodemask+0x2f6/0x790
> > >>>      __alloc_pages_slowpath.constprop.0+0x12d0/0x12d0
> > >>>      create_prof_cpu_mask+0x30/0x30
> > >>>      alloc_pages_current+0xb1/0x150
> > >>>      stack_depot_save+0x39f/0x490
> > >>>      kasan_save_stack+0x42/0x50
> > >>>      kasan_save_stack+0x23/0x50
> > >>>      kasan_record_aux_stack+0xa9/0xc0
> > >>>      __call_rcu+0xff/0x9c0
> > >>>      call_rcu+0xe/0x10
> > >>>      put_object+0x53/0x70
> > >>>      __delete_object+0x7b/0x90
> > >>>      kmemleak_free+0x46/0x70
> > >>>      slab_free_freelist_hook+0xb4/0x160
> > >>>      kfree+0xe5/0x420
> > >>>      kfree_const+0x17/0x30
> > >>>      kobject_cleanup+0xaa/0x230
> > >>>      kobject_put+0x76/0x90
> > >>>      netdev_queue_update_kobjects+0x17d/0x1f0
> > >>>      ... ...
> > >>>      ksys_write+0xd9/0x180
> > >>>      __x64_sys_write+0x42/0x50
> > >>>      do_syscall_64+0x38/0x50
> > >>>      entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > >>>
> > >>> Fixes: 84109ab58590 ("rcu: Record kvfree_call_rcu() call stack for KASAN")
> > >>> Fixes: 26e760c9a7c8 ("rcu: kasan: record and print call_rcu() call stack")
> > >>> Reported-by: Jianwei Hu <jianwei.hu@windriver.com>
> > >>> Signed-off-by: Jun Miao <jun.miao@windriver.com>
> > >>> ---
> > >>>    kernel/rcu/tree.c | 4 ++--
> > >>>    1 file changed, 2 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > >>> index 8270e58cd0f3..2c1034580f15 100644
> > >>> --- a/kernel/rcu/tree.c
> > >>> +++ b/kernel/rcu/tree.c
> > >>> @@ -3026,7 +3026,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >>>        head->func = func;
> > >>>        head->next = NULL;
> > >>>        local_irq_save(flags);
> > >>> -     kasan_record_aux_stack(head);
> > >>> +     kasan_record_aux_stack_noalloc(head);
> > >>>        rdp = this_cpu_ptr(&rcu_data);
> > >>>
> > >>>        /* Add the callback to our list. */
> > >>> @@ -3591,7 +3591,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > >>>                return;
> > >>>        }
> > >>>
> > >>> -     kasan_record_aux_stack(ptr);
> > >>> +     kasan_record_aux_stack_noalloc(ptr);
> > >>>        success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
> > >>>        if (!success) {
> > >>>                run_page_cache_worker(krcp);
> > > Yep an allocation is tricky here. This change looks correct to me at
> > > least from the point that it does not allocate.
> > >
> > > --
> > > Uladzislau Rezki
> >
> > Thanks your approval. Could you like to give me a review?
> >
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

I have queued it for review and testing, thank you both!  I do have
some remaining concerns about this code being starved for memory.  I am
wondering if the code needs to check the interrupt state.  And perhaps
also whether locks are held.  I of course will refrain from sending
this to mainline until these concerns are resolved.

Marco, Dmitry, thoughts?

							Thanx, Paul
