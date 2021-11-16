Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712A2452F0F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbhKPK3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbhKPK3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:29:44 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F6BC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 02:26:47 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso32652693ots.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 02:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Dvv3p8AhGCNVaVD1e1tbe7DzFesl+DjfsxOQoQusrw=;
        b=KkKSymEqLAsn2XjVnLWw5pathlZuu/RYIcZmMDs7Dfbw4+F4WQCf9AKNiYGp2UnQcG
         RJx3jkKFn3g6f3aaj4Tx44RGmVteItlKyYP212n2hzYQ8cqyLZktsvt/LQ5e8biArnPe
         OYo/Xs/eUBlU7UZLLCk98rs5U6Zo6KyAhEewlLzpQbfB+ot0YnFLMbPPVW30fnZiZsTy
         fB5TEGcCmg/HPR9WfZJ2qtLVGaaWHqHE9bGR5nHqszd+I/uAaTWc6/VFwIHNFCKZ78VZ
         JhEDmFvD0rVJlg0HTdkgTDxb6l8L6WjTYuBDyMFoC6ToV00tYAx6U2lLRGAq4n6TbuLh
         KZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Dvv3p8AhGCNVaVD1e1tbe7DzFesl+DjfsxOQoQusrw=;
        b=e3HPYyqg1DnyXodhDOsIF5ygKpvjGhHxM6ageXNq111EmaaF6+gWdRY3HuaB1h7Ttd
         Tt9e1fPtHZowR7p9Bi7fGZiII7aiGNq0BkGYtsE4LB1FPpufu+L4ES3xDXf+ku3C+5fZ
         i+nGALjc3E218b6vD3Jx3rNh8qSrxV4K8eoAj7j+dAXiihT5KxLk7D22y4+eUPwOTZSZ
         k3ANBFmaHFuJTKVA7Ytzm1aKJqp1OCLizzFx9nAPm6/zfpS/yniW0RNq/MRIo/uXskp4
         29X4LyFwskaHnrTulSz6pcgwQL8T+VnEqeZttIj4Y4kldSR2F07DEDjyIiegrst+/A/I
         lz1Q==
X-Gm-Message-State: AOAM533pX9/wzTVTF72DCP9Cj7TJpfbBaFarNXVrG2rOyPAF7VUUGytr
        PpnQcqgGUxyVWEnoFFMJJPFQr7rH4o0RFdD2h7bYOg==
X-Google-Smtp-Source: ABdhPJyLXEqEcFI01acWY0dYye0LGYIZgjW2Rr0DfEljikEjacL8VzWCz7iNSulN75wRZprm5paZTzPcItY+u32pQSY=
X-Received: by 2002:a9d:662:: with SMTP id 89mr5027714otn.157.1637058407013;
 Tue, 16 Nov 2021 02:26:47 -0800 (PST)
MIME-Version: 1.0
References: <1637018582-10788-1-git-send-email-jun.miao@intel.com>
In-Reply-To: <1637018582-10788-1-git-send-email-jun.miao@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 16 Nov 2021 11:26:35 +0100
Message-ID: <CANpmjNPqwOCwEP374wYaFg=-rLRWZ6fHit6zQxmH8sxuigVvew@mail.gmail.com>
Subject: Re: [V2][PATCH] rcu: avoid alloc_pages() when recording stack
To:     Jun Miao <jun.miao@intel.com>
Cc:     paulmck@kernel.org, urezki@gmail.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        jianwei.hu@windriver.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 at 08:46, Jun Miao <jun.miao@intel.com> wrote:
> The default kasan_record_aux_stack() calls stack_depot_save() with GFP_NOWAIT,
> which in turn can then call alloc_pages(GFP_NOWAIT, ...).  In general, however,
> it is not even possible to use either GFP_ATOMIC nor GFP_NOWAIT in certain
> non-preemptive contexts/RT kernel including raw_spin_locks (see gfp.h and ab00db216c9c7).
> Fix it by instructing stackdepot to not expand stack storage via alloc_pages()
> in case it runs out by using kasan_record_aux_stack_noalloc().
>
> Jianwei Hu reported:
> BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:969
> in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 15319, name: python3
> INFO: lockdep is turned off.
> irq event stamp: 0
>   hardirqs last  enabled at (0): [<0000000000000000>] 0x0
>   hardirqs last disabled at (0): [<ffffffff856c8b13>] copy_process+0xaf3/0x2590
>   softirqs last  enabled at (0): [<ffffffff856c8b13>] copy_process+0xaf3/0x2590
>   softirqs last disabled at (0): [<0000000000000000>] 0x0
>   CPU: 6 PID: 15319 Comm: python3 Tainted: G        W  O 5.15-rc7-preempt-rt #1
>   Hardware name: Supermicro SYS-E300-9A-8C/A2SDi-8C-HLN4F, BIOS 1.1b 12/17/2018
>   Call Trace:
>     show_stack+0x52/0x58
>     dump_stack+0xa1/0xd6
>     ___might_sleep.cold+0x11c/0x12d
>     rt_spin_lock+0x3f/0xc0
>     rmqueue+0x100/0x1460
>     rmqueue+0x100/0x1460
>     mark_usage+0x1a0/0x1a0
>     ftrace_graph_ret_addr+0x2a/0xb0
>     rmqueue_pcplist.constprop.0+0x6a0/0x6a0
>      __kasan_check_read+0x11/0x20
>      __zone_watermark_ok+0x114/0x270
>      get_page_from_freelist+0x148/0x630
>      is_module_text_address+0x32/0xa0
>      __alloc_pages_nodemask+0x2f6/0x790
>      __alloc_pages_slowpath.constprop.0+0x12d0/0x12d0
>      create_prof_cpu_mask+0x30/0x30
>      alloc_pages_current+0xb1/0x150
>      stack_depot_save+0x39f/0x490
>      kasan_save_stack+0x42/0x50
>      kasan_save_stack+0x23/0x50
>      kasan_record_aux_stack+0xa9/0xc0
>      __call_rcu+0xff/0x9c0
>      call_rcu+0xe/0x10
>      put_object+0x53/0x70
>      __delete_object+0x7b/0x90
>      kmemleak_free+0x46/0x70
>      slab_free_freelist_hook+0xb4/0x160
>      kfree+0xe5/0x420
>      kfree_const+0x17/0x30
>      kobject_cleanup+0xaa/0x230
>      kobject_put+0x76/0x90
>      netdev_queue_update_kobjects+0x17d/0x1f0
>      ... ...
>      ksys_write+0xd9/0x180
>      __x64_sys_write+0x42/0x50
>      do_syscall_64+0x38/0x50
>      entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Links: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/kasan.h?id=7cb3007ce2da27ec02a1a3211941e7fe6875b642
> Fixes: 84109ab58590 ("rcu: Record kvfree_call_rcu() call stack for KASAN")
> Fixes: 26e760c9a7c8 ("rcu: kasan: record and print call_rcu() call stack")
> Reported-by: Jianwei Hu <jianwei.hu@windriver.com>
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Jun Miao <jun.miao@intel.com>

Acked-by: Marco Elver <elver@google.com>

> ---
>  kernel/rcu/tree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index ef8d36f580fc..906b6887622d 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2982,7 +2982,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
>         head->func = func;
>         head->next = NULL;
>         local_irq_save(flags);
> -       kasan_record_aux_stack(head);
> +       kasan_record_aux_stack_noalloc(head);
>         rdp = this_cpu_ptr(&rcu_data);
>
>         /* Add the callback to our list. */
> @@ -3547,7 +3547,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>                 return;
>         }
>
> -       kasan_record_aux_stack(ptr);
> +       kasan_record_aux_stack_noalloc(ptr);
>         success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
>         if (!success) {
>                 run_page_cache_worker(krcp);
> --
> 2.32.0
>
