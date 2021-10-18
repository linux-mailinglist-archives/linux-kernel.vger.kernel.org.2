Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AE04329BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 00:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhJRW2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 18:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJRW2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 18:28:42 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E26C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 15:26:30 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id r17so4384672uaf.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 15:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HSMERUYQICWmfCm7gWkhpVWJAvw3TMR9wFwO6eYXjRI=;
        b=C/k2Qr7KAVwLZEpPkHZgEHjTV6z0MwjrjwXEWU1HkixUhBDk5gQvGzfIId1u0Aol/B
         j919wR6uI3LPraR80qQrDKxUTM007AKXBNRjBuFpCScgOOnUllAUzSP516ORmnFMFGG3
         CQfUIaNFF9kT4w+DMObIf2F2E18qwlT3WGvS2QiPZZz+XixsEaoC8ajFqhKzfATs0e6k
         xcRLk8tR++m+V+WWS9w0CrkQa51yfztX8lKjzrD9sjJWERTiSVbL8u+qNpTyZeb8QDRy
         NHfAePyniY9rawsPM/AZSA9/iLS2/zMUGExmwIKBfUeWLNJ+g6HA3SYDVnhq+HaBFPow
         RzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HSMERUYQICWmfCm7gWkhpVWJAvw3TMR9wFwO6eYXjRI=;
        b=G9VlwaX/07CWSE4csSGe+MaN3fWHpOnEljOL1OIyq3m1lAzhDENoN2ZbgH5lFbDESF
         V8oAZIl5yrVopIg7jDcW8Yrz4f1Q+A16XmRvxWDpmPBpkAOmx0f9AuYG0ZhG/yg+PC3i
         NeMiAtl/Kwzs6W4Y2JkE4z5zahAK/tBoyt8fo6/Vc8Ixxvo1si3sIWKcusr+z7z7C8M+
         B+zzhZk33ebr/TRV7UDLMnxZaZ9ef9WgN0ENuU3Z2Vna+cSUBIA8RZjXz4bZbDWIJ2w3
         Zup5cZy5Zd6YWDJBEAhh3NgEhMMzgRTn5Rrb3EfPbIqgPTrQBPWF5uDHxIh3HJG22SNU
         Ipug==
X-Gm-Message-State: AOAM533iwhlhxTU0JsxNMmtuGwuQhB6SG4OOxd9UCmhsd38DMT+82Jy+
        +tYZ27Z5DxCOlk/e7XzY+e/dcLyPNYmV1OlNMQjgnQ==
X-Google-Smtp-Source: ABdhPJyQi8WibjZM6DtkIH4qXBrg4nymQ9uhq8ipX+KDHxHFIbDzIFqD1EGHIgMLmh1b4jHaUY/rqP6CV17kH6rdroo=
X-Received: by 2002:a05:6102:160b:: with SMTP id cu11mr16466935vsb.45.1634595989831;
 Mon, 18 Oct 2021 15:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch>
 <87ee9pa6xw.fsf@disp2133> <OJK-F2NSBlem52GqvCQYzaVxs2x9Csq3qO4QbTG4A4UUNaQpebpAQmyyKzUd70CIo27C4K7CL3bhIzcxulIzYMu067QOMXCFz8ejh3ZtFhE=@protonmail.ch>
 <U6ByMUZ9LgvxXX6eb0M9aBx8cw8GpgE1qU22LaxaJ_2bOdnGLLJHDgnLL-6cJT7dKdcG_Ms37APSutc3EIMmtpgpP_2kotVLCNRoUq-wTJ8=@protonmail.ch>
 <878rzw77i3.fsf@disp2133> <o3tuBB58KUQjyQsALqWi0s1tSPlgVPST4PNNjHewIgRB7CUOOVyFSFxSBLCOJdUH3ly21cIjBthNyqQGnDgJD7fjU8NiVHq7i0JcMvYuzUA=@protonmail.ch>
 <20210929173611.fo5traia77o63gpw@example.org> <hPgvCJ2KbKeauk78uWJEsuKJ5VfMqknPJ_oyOZe6M78-6eG7qnj0t0UKC-joPVowo_nOikIsEWP-ZDioARfI-Cl6zrHjCHPJST3drpi5ALE=@protonmail.ch>
 <20210930130640.wudkpmn3cmah2cjz@example.org> <CAOUHufZmAjuKyRcmq6GH8dfdZxchykS=BTZDsk-gDAh3LJTe1Q@mail.gmail.com>
 <878rz8wwb6.fsf@disp2133> <87v92cvhbf.fsf@disp2133> <ccbccf82-dc50-00b2-1cfd-3da5e2c81dbf@infomedia.dk>
 <87mtnavszx.fsf_-_@disp2133> <87fssytizw.fsf_-_@disp2133>
In-Reply-To: <87fssytizw.fsf_-_@disp2133>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 18 Oct 2021 16:26:18 -0600
Message-ID: <CAOUHufZJHXNZ1ew2nqNYcCupYXeHDa37i7ojC2k43+2eT_Tn1g@mail.gmail.com>
Subject: Re: [PATCH v2] ucounts: Fix signal ucount refcounting
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Rune Kleveland <rune.kleveland@infomedia.dk>,
        Alexey Gladkov <legion@kernel.org>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "containers\\@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 10:06 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
>
> In commit fda31c50292a ("signal: avoid double atomic counter
> increments for user accounting") Linus made a clever optimization to
> how rlimits and the struct user_struct.  Unfortunately that
> optimization does not work in the obvious way when moved to nested
> rlimits.  The problem is that the last decrement of the per user
> namespace per user sigpending counter might also be the last decrement
> of the sigpending counter in the parent user namespace as well.  Which
> means that simply freeing the leaf ucount in __free_sigqueue is not
> enough.
>
> Maintain the optimization and handle the tricky cases by introducing
> inc_rlimit_get_ucounts and dec_rlimit_put_ucounts.
>
> By moving the entire optimization into functions that perform all of
> the work it becomes possible to ensure that every level is handled
> properly.
>
> The new function inc_rlimit_get_ucounts returns 0 on failure to
> increment the ucount.  This is different than inc_rlimit_ucounts which
> increments the ucounts and returns LONG_MAX if the ucount counter has
> exceeded it's maximum or it wrapped (to indicate the counter needs to
> decremented).
>
> I wish we had a single user to account all pending signals to across
> all of the threads of a process so this complexity was not necessary
>
> Cc: stable@vger.kernel.org
> Fixes: d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of ucounts")
> v1: https://lkml.kernel.org/r/87mtnavszx.fsf_-_@disp2133
> Tested-by: Rune Kleveland <rune.kleveland@infomedia.dk>
> Tested-by: Yu Zhao <yuzhao@google.com>
> Tested-by: Jordan Glover <Golden_Miller83@protonmail.ch>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>
> This is my version of the fix with all of the feedback rolled in.
> I have tested it and believe this is ready to send out.
>
> If folks code take a once over and see if I have spotted things.
>
> For the people who are testing or have tested this I have added your
> tested-by's please let me know if you mind.
>
> Eric

Retested on the latest 5.15-rc6. This patch fixes the following crash:

[ 3307.621443] ==================================================================
[ 3307.628890] BUG: KASAN: use-after-free in dec_ucount+0x50/0xd8
[ 3307.634903] Write of size 8 at addr ffffff80a5e4c520 by task kworker/7:3/201
[ 3307.642149]
[ 3307.643695] CPU: 7 PID: 201 Comm: kworker/7:3 Not tainted
5.15.0-rc6-lockdep+ #7
[ 3307.651291] Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
[ 3307.658001] Workqueue: events free_user_ns
[ 3307.662231] Call trace:
[ 3307.664750]  dump_backtrace+0x0/0x42c
[ 3307.668522]  show_stack+0x24/0x30
[ 3307.671935]  dump_stack_lvl+0xd0/0x100
[ 3307.675797]  print_address_description+0x30/0x304
[ 3307.680646]  kasan_report+0x190/0x1d8
[ 3307.684419]  kasan_check_range+0x1ac/0x1bc
[ 3307.688630]  __kasan_check_write+0x44/0x54
[ 3307.692852]  dec_ucount+0x50/0xd8
[ 3307.696266]  free_user_ns+0x1b0/0x288
[ 3307.700036]  process_one_work+0x7b4/0x1130
[ 3307.704251]  worker_thread+0x800/0xcf4
[ 3307.708111]  kthread+0x2a8/0x358
[ 3307.711437]  ret_from_fork+0x10/0x20
[ 3307.715121]
[ 3307.716664] Allocated by task 6564:
[ 3307.720253]  kasan_save_stack+0x38/0x68
[ 3307.724206]  __kasan_kmalloc+0x9c/0xb8
[ 3307.728068]  kmem_cache_alloc_trace+0x260/0x32c
[ 3307.732729]  alloc_ucounts+0x150/0x374
[ 3307.736589]  set_cred_ucounts+0x178/0x240
[ 3307.740714]  __sys_setresuid+0x31c/0x4f8
[ 3307.744754]  __arm64_sys_setresuid+0x84/0x98
[ 3307.749153]  invoke_syscall+0xcc/0x2bc
[ 3307.753012]  el0_svc_common+0x118/0x1ec
[ 3307.756961]  do_el0_svc_compat+0x50/0x60
[ 3307.761005]  el0_svc_compat+0x5c/0xec
[ 3307.764774]  el0t_32_sync_handler+0xc0/0xf0
[ 3307.769083]  el0t_32_sync+0x1a4/0x1a8
[ 3307.772852]
[ 3307.774399] The buggy address belongs to the object at ffffff80a5e4c500
[ 3307.774399]  which belongs to the cache kmalloc-256 of size 256
[ 3307.787250] The buggy address is located 32 bytes inside of
[ 3307.787250]  256-byte region [ffffff80a5e4c500, ffffff80a5e4c600)
[ 3307.799216] The buggy address belongs to the page:
[ 3307.804141] page:fffffffe02979200 refcount:1 mapcount:0
mapping:0000000000000000 index:0xffffff80a5e4c100 pfn:0x125e48
[ 3307.815127] head:fffffffe02979200 order:3 compound_mapcount:0
compound_pincount:0
[ 3307.822808] flags: 0x8000000000010200(slab|head|zone=2)
[ 3307.828187] raw: 8000000000010200 fffffffe0250ba08 fffffffe00f04a08
ffffff808000c980
[ 3307.836148] raw: ffffff80a5e4c100 0000000000200001 00000001ffffffff
0000000000000000
[ 3307.844104] page dumped because: kasan: bad access detected
[ 3307.849837]
[ 3307.851381] Memory state around the buggy address:
[ 3307.856307]  ffffff80a5e4c400: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[ 3307.863729]  ffffff80a5e4c480: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[ 3307.871146] >ffffff80a5e4c500: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 3307.878562]                                ^
[ 3307.882956]  ffffff80a5e4c580: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 3307.890375]  ffffff80a5e4c600: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[ 3307.897800] ==================================================================

>  include/linux/user_namespace.h |  2 ++
>  kernel/signal.c                | 25 +++++------------
>  kernel/ucount.c                | 49 ++++++++++++++++++++++++++++++++++
>  3 files changed, 57 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index eb70cabe6e7f..33a4240e6a6f 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -127,6 +127,8 @@ static inline long get_ucounts_value(struct ucounts *ucounts, enum ucount_type t
>
>  long inc_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v);
>  bool dec_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v);
> +long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type);
> +void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum ucount_type type);
>  bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long max);
>
>  static inline void set_rlimit_ucount_max(struct user_namespace *ns,
> diff --git a/kernel/signal.c b/kernel/signal.c
> index a3229add4455..13d2505a14a0 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -425,22 +425,10 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
>          */
>         rcu_read_lock();
>         ucounts = task_ucounts(t);
> -       sigpending = inc_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING, 1);
> -       switch (sigpending) {
> -       case 1:
> -               if (likely(get_ucounts(ucounts)))
> -                       break;
> -               fallthrough;
> -       case LONG_MAX:
> -               /*
> -                * we need to decrease the ucount in the userns tree on any
> -                * failure to avoid counts leaking.
> -                */
> -               dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING, 1);
> -               rcu_read_unlock();
> -               return NULL;
> -       }
> +       sigpending = inc_rlimit_get_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING);
>         rcu_read_unlock();
> +       if (!sigpending)
> +               return NULL;
>
>         if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
>                 q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
> @@ -449,8 +437,7 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
>         }
>
>         if (unlikely(q == NULL)) {
> -               if (dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING, 1))
> -                       put_ucounts(ucounts);
> +               dec_rlimit_put_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING);
>         } else {
>                 INIT_LIST_HEAD(&q->list);
>                 q->flags = sigqueue_flags;
> @@ -463,8 +450,8 @@ static void __sigqueue_free(struct sigqueue *q)
>  {
>         if (q->flags & SIGQUEUE_PREALLOC)
>                 return;
> -       if (q->ucounts && dec_rlimit_ucounts(q->ucounts, UCOUNT_RLIMIT_SIGPENDING, 1)) {
> -               put_ucounts(q->ucounts);
> +       if (q->ucounts) {
> +               dec_rlimit_put_ucounts(q->ucounts, UCOUNT_RLIMIT_SIGPENDING);
>                 q->ucounts = NULL;
>         }
>         kmem_cache_free(sigqueue_cachep, q);
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index bb51849e6375..eb03f3c68375 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -284,6 +284,55 @@ bool dec_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
>         return (new == 0);
>  }
>
> +static void do_dec_rlimit_put_ucounts(struct ucounts *ucounts,
> +                               struct ucounts *last, enum ucount_type type)
> +{
> +       struct ucounts *iter, *next;
> +       for (iter = ucounts; iter != last; iter = next) {
> +               long dec = atomic_long_add_return(-1, &iter->ucount[type]);
> +               WARN_ON_ONCE(dec < 0);
> +               next = iter->ns->ucounts;
> +               if (dec == 0)
> +                       put_ucounts(iter);
> +       }
> +}
> +
> +void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum ucount_type type)
> +{
> +       do_dec_rlimit_put_ucounts(ucounts, NULL, type);
> +}
> +
> +long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type)
> +{
> +       /* Caller must hold a reference to ucounts */
> +       struct ucounts *iter;
> +       long dec, ret = 0;
> +
> +       for (iter = ucounts; iter; iter = iter->ns->ucounts) {
> +               long max = READ_ONCE(iter->ns->ucount_max[type]);
> +               long new = atomic_long_add_return(1, &iter->ucount[type]);
> +               if (new < 0 || new > max)
> +                       goto unwind;
> +               if (iter == ucounts)
> +                       ret = new;
> +               /*
> +                * Grab an extra ucount reference for the caller when
> +                * the rlimit count was previously 0.
> +                */
> +               if (new != 1)
> +                       continue;
> +               if (!get_ucounts(iter))
> +                       goto dec_unwind;
> +       }
> +       return ret;
> +dec_unwind:
> +       dec = atomic_long_add_return(-1, &iter->ucount[type]);
> +       WARN_ON_ONCE(dec < 0);
> +unwind:
> +       do_dec_rlimit_put_ucounts(ucounts, iter, type);
> +       return 0;
> +}
> +
>  bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long max)
>  {
>         struct ucounts *iter;
> --
> 2.20.1
>
