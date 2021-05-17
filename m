Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418AB3823F9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 08:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhEQGMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 02:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbhEQGMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 02:12:45 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4232C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 23:11:28 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id c10so4106532qtx.10
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 23:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8FVV9/p8+s6jHWrY3/jiYO9IJ8asyV8UAQtOuz0B7bg=;
        b=KoaTze1ss0Czw/rd8Jc3GIhztBqPKFUj6B19aKjnVvQiO9Pwds5voQSeMI+nXcbKRq
         jVNgzPOpasiVrF4hRp1Y/HZ1dBUxeJyDE7K9VYP6EMIQKQeTjOptJ2LQloXQUz1cH5sm
         qu6VNNZih1+bAiksip08083lS6fw60GIOT3khDJ3dEJfEyztHpfUnlas0dLWP2vgk/4L
         RCz05JohE3T+2TCokTyjWUHiQEuO30Pfl1ZeeeI//dg2lqQCShEOqsaNcrmuDWWF6cfw
         Brw+kOyRG9V5RYaR3dRcsy2fcMiSNvFqrvBsc2HB8ro8KYcIl7wjhM2bI8bDZjnaKYDb
         UPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FVV9/p8+s6jHWrY3/jiYO9IJ8asyV8UAQtOuz0B7bg=;
        b=KjLFkPp1UiTEBOlAoOkevmqJwWRGkgqg0NjGiR+rBMpmp82tO0nuaRSNPJxRQVyMGR
         aEqSXwGYlvpc7C5BH9C31T87vP6qIYfNI7mh20vU1EIU0bx7ngrQqK87omqBxS/I25wG
         pBmhQi+Bujvn4IxXQfG9ZXed0qHoU1iwOCgCccJ4/STdJ8mlsTeCg0YfyXviv6cSTmCX
         ftdy+Erm/PtzCwSOtMxxJTbjTUsN3L49Uu50JZIJdaDU5Cwa+rBStn31u4wvYcB9k+MK
         9CniihBqKbtYACgMX6VujawHb7nvjshbe+Bf8uvTfDw6VC+HvGYbJ3nDmA9a3/x0T4HF
         ogrg==
X-Gm-Message-State: AOAM531ktUC4CRy3UOqyWbpt5sBy69aodhRfxSAqemoYhXHxDadxE2hn
        snoNbCvqmZf2EFNWaMs3R3NDg5D9D9MWDSJPLdnm+g==
X-Google-Smtp-Source: ABdhPJwv0Hgs+HiIH1skr1oSzK1GOJBvMaH1zWf14IUD+sGOow/dtSjInAVZ9uhA+JlALZI7OUmLDpT49C8Uoarhbaw=
X-Received: by 2002:ac8:518a:: with SMTP id c10mr55038880qtn.66.1621231887592;
 Sun, 16 May 2021 23:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000201e3405c19076a4@google.com>
In-Reply-To: <000000000000201e3405c19076a4@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 17 May 2021 08:11:15 +0200
Message-ID: <CACT4Y+aZMQ1H9ZD540nENN54L0gr808qhZXHhbUhJsSR4rHK1Q@mail.gmail.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in nf_ct_iterate_cleanup (2)
To:     syzbot <syzbot+86efe6206c1373c8a7cc@syzkaller.appspotmail.com>
Cc:     Taehee Yoo <ap420073@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Guillaume Nault <gnault@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 9:51 AM syzbot
<syzbot+86efe6206c1373c8a7cc@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d2b6f8a1 Merge tag 'xfs-5.13-merge-3' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=120f2da3d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=65c207250bba4efe
> dashboard link: https://syzkaller.appspot.com/bug?extid=86efe6206c1373c8a7cc
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+86efe6206c1373c8a7cc@syzkaller.appspotmail.com

#syz fix: rcu: Reject RCU_LOCKDEP_WARN() false positives

> =============================
> WARNING: suspicious RCU usage
> 5.12.0-syzkaller #0 Not tainted
> -----------------------------
> kernel/sched/core.c:8304 Illegal context switch in RCU-bh read-side critical section!
>
> other info that might help us debug this:
>
>
> rcu_scheduler_active = 2, debug_locks = 0
> 3 locks held by kworker/u4:7/11790:
>  #0:
> ffff888011e93138
>  (
> (wq_completion)netns
> ){+.+.}-{0:0}
> , at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
> , at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
> , at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
> , at: set_work_data kernel/workqueue.c:616 [inline]
> , at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
> , at: process_one_work+0x871/0x1600 kernel/workqueue.c:2246
>  #1:
> ffffc90002377da8
>  (
> net_cleanup_work
> ){+.+.}-{0:0}
> , at: process_one_work+0x8a5/0x1600 kernel/workqueue.c:2250
>  #2:
> ffffffff8d672190
>  (
> pernet_ops_rwsem
> ){++++}-{3:3}
> , at: cleanup_net+0x9b/0xb10 net/core/net_namespace.c:557
>
> stack backtrace:
> CPU: 1 PID: 11790 Comm: kworker/u4:7 Not tainted 5.12.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: netns cleanup_net
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x141/0x1d7 lib/dump_stack.c:120
>  ___might_sleep+0x229/0x2c0 kernel/sched/core.c:8304
>  get_next_corpse net/netfilter/nf_conntrack_core.c:2223 [inline]
>  nf_ct_iterate_cleanup+0x16d/0x450 net/netfilter/nf_conntrack_core.c:2245
>  nf_conntrack_cleanup_net_list+0x81/0x250 net/netfilter/nf_conntrack_core.c:2432
>  ops_exit_list+0x10d/0x160 net/core/net_namespace.c:178
>  cleanup_net+0x4ea/0xb10 net/core/net_namespace.c:595
>  process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
>  worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
>  kthread+0x3b1/0x4a0 kernel/kthread.c:313
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000201e3405c19076a4%40google.com.
