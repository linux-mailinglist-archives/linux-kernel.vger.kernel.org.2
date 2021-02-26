Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C4F326A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 23:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBZWpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 17:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhBZWpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 17:45:33 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E96C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 14:44:52 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id q14so12419087ljp.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 14:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6NHS+DCc0VDUVDlRWLeWroebcp3EZTKLhV7o1xUwtuI=;
        b=StstB4qa/tR6fraV9reP/GSLxJ/dVP1PA3PA+ZXectTm3HFkFft6TFlqRs1sBuh4y7
         bDNmcRsTRWxKbKqlDytqtsmi7WJXW/rbVcFZjoGTfoygChUPrvJfaS5/7nAeP568bpVH
         AVjepaCFhaGS5ZyEWEh+ES/idwBLAcrdAZr2UoqO+KKCGzF1wwbswIo8LZvXCAr9BmI0
         aHNw/sn25RUXS0Wa73WhrbwzhsUMD40EUq8BoxcgD1SLtx9fpRM9CcB1A1rXDaT+MRbj
         YpFpp17shamW96gfnSgWgS3f988KjBBfw9T9FQlUNtDfOxGRxZC5kg3tD64AECWWvjRc
         nHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6NHS+DCc0VDUVDlRWLeWroebcp3EZTKLhV7o1xUwtuI=;
        b=ClLi65M/lFyRIV/O7xHpPYEcTVi2GTi/nFo4MzDH+ML6CuIX7KtSfwGGHkB9u6yy8s
         +AqDlI/5sD9VWkE181pWwDM5b8kNRn9dD/0bvi8aDgBPY1i07Wo6+aeDS/cWFqG8sXI1
         54zwxOmim2h7FDD/XAjvoXk4lRlTVyaOmlI7XcNeOlNrIvp2lZHJFvWNqt9c0dPFx9tN
         LohjvL2Dw6tLAiDKyj5dcmCbOWPQcyPleAlFqM4VYmismlbt20XCMbSJRCXtW84AID0X
         75nonfizfpLruo9/9RjfrCvw6gifhvawPTI0tDBH9S1vElNQuXRAJUVeIsq0tw5nd50s
         MdwQ==
X-Gm-Message-State: AOAM533KYfYqk3HFTTYsGvWOqMOweUFtPz7hT4FujiyjVjBryWzH3Bd6
        ti0A6bwFasnoNVEJDQZOJHyobih1pxmJ0EYwt6j9MHnMnQ6oCg==
X-Google-Smtp-Source: ABdhPJxoKo1Qe4rnfBy7xXTQY8vIUSkQDXBaPFc3TrIIiVNj4AkTJd1OU8FX0a/vipCyU37GhfMc+jq2RjQ7bGflpmY=
X-Received: by 2002:a2e:9c0b:: with SMTP id s11mr3008230lji.122.1614379491068;
 Fri, 26 Feb 2021 14:44:51 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f1c03b05bc43aadc@google.com>
In-Reply-To: <000000000000f1c03b05bc43aadc@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 26 Feb 2021 14:44:37 -0800
Message-ID: <CALvZod4vGj0P6WKncdKpGaVEb1Ui_fyHm+-hbCJTmbvo43CJ=A@mail.gmail.com>
Subject: Re: possible deadlock in sk_clone_lock
To:     syzbot <syzbot+506c8a2a115201881d45@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 2:09 PM syzbot
<syzbot+506c8a2a115201881d45@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    577c2835 Add linux-next specific files for 20210224
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=137cef82d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e9bb3d369b3bf49
> dashboard link: https://syzkaller.appspot.com/bug?extid=506c8a2a115201881d45
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+506c8a2a115201881d45@syzkaller.appspotmail.com
>
> =====================================================
> WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
> 5.11.0-next-20210224-syzkaller #0 Not tainted
> -----------------------------------------------------
> syz-executor.3/15411 [HC0[0]:SC0[2]:HE1:SE0] is trying to acquire:
> ffffffff8c0a0e18 (hugetlb_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:354 [inline]
> ffffffff8c0a0e18 (hugetlb_lock){+.+.}-{2:2}, at: __free_huge_page+0x4cd/0xc10 mm/hugetlb.c:1390
>
> and this task is already holding:
> ffff88802391c720 (slock-AF_INET){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:354 [inline]
> ffff88802391c720 (slock-AF_INET){+.-.}-{2:2}, at: __tcp_close+0x6d9/0x1170 net/ipv4/tcp.c:2788
> which would create a new lock dependency:
>  (slock-AF_INET){+.-.}-{2:2} -> (hugetlb_lock){+.+.}-{2:2}
>
> but this new dependency connects a SOFTIRQ-irq-safe lock:
>  (slock-AF_INET){+.-.}-{2:2}
>
> ... which became SOFTIRQ-irq-safe at:
>   lock_acquire kernel/locking/lockdep.c:5510 [inline]
>   lock_acquire+0x1ab/0x730 kernel/locking/lockdep.c:5475
>   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
>   spin_lock include/linux/spinlock.h:354 [inline]
>   sk_clone_lock+0x296/0x1070 net/core/sock.c:1913
>   inet_csk_clone_lock+0x21/0x4c0 net/ipv4/inet_connection_sock.c:830
>   tcp_create_openreq_child+0x30/0x16d0 net/ipv4/tcp_minisocks.c:460
>   tcp_v4_syn_recv_sock+0x10c/0x1460 net/ipv4/tcp_ipv4.c:1526
>   tcp_check_req+0x616/0x1860 net/ipv4/tcp_minisocks.c:772
>   tcp_v4_rcv+0x221a/0x3780 net/ipv4/tcp_ipv4.c:2001
>   ip_protocol_deliver_rcu+0x5c/0x8a0 net/ipv4/ip_input.c:204
>   ip_local_deliver_finish+0x20a/0x370 net/ipv4/ip_input.c:231
>   NF_HOOK include/linux/netfilter.h:301 [inline]
>   NF_HOOK include/linux/netfilter.h:295 [inline]
>   ip_local_deliver+0x1b3/0x200 net/ipv4/ip_input.c:252
>   dst_input include/net/dst.h:458 [inline]
>   ip_sublist_rcv_finish+0x9a/0x2c0 net/ipv4/ip_input.c:551
>   ip_list_rcv_finish.constprop.0+0x514/0x6e0 net/ipv4/ip_input.c:601
>   ip_sublist_rcv net/ipv4/ip_input.c:609 [inline]
>   ip_list_rcv+0x34e/0x490 net/ipv4/ip_input.c:644
>   __netif_receive_skb_list_ptype net/core/dev.c:5408 [inline]
>   __netif_receive_skb_list_core+0x549/0x8e0 net/core/dev.c:5456
>   __netif_receive_skb_list net/core/dev.c:5508 [inline]
>   netif_receive_skb_list_internal+0x777/0xd70 net/core/dev.c:5618
>   gro_normal_list net/core/dev.c:5772 [inline]
>   gro_normal_list net/core/dev.c:5768 [inline]
>   napi_complete_done+0x1f1/0x820 net/core/dev.c:6474
>   virtqueue_napi_complete+0x2c/0xc0 drivers/net/virtio_net.c:334
>   virtnet_poll+0xae2/0xd90 drivers/net/virtio_net.c:1455
>   __napi_poll+0xaf/0x440 net/core/dev.c:6892
>   napi_poll net/core/dev.c:6959 [inline]
>   net_rx_action+0x801/0xb40 net/core/dev.c:7036
>   __do_softirq+0x29b/0x9f6 kernel/softirq.c:345
>   invoke_softirq kernel/softirq.c:221 [inline]
>   __irq_exit_rcu kernel/softirq.c:422 [inline]
>   irq_exit_rcu+0x134/0x200 kernel/softirq.c:434
>   common_interrupt+0xa4/0xd0 arch/x86/kernel/irq.c:240
>   asm_common_interrupt+0x1e/0x40 arch/x86/include/asm/idtentry.h:623
>   tomoyo_domain_quota_is_ok+0x2f1/0x550 security/tomoyo/util.c:1093
>   tomoyo_supervisor+0x2f2/0xf00 security/tomoyo/common.c:2089
>   tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
>   tomoyo_path_permission security/tomoyo/file.c:587 [inline]
>   tomoyo_path_permission+0x270/0x3a0 security/tomoyo/file.c:573
>   tomoyo_path_perm+0x39e/0x400 security/tomoyo/file.c:838
>   tomoyo_path_symlink+0x94/0xe0 security/tomoyo/tomoyo.c:200
>   security_path_symlink+0xdf/0x150 security/security.c:1119
>   do_symlinkat+0x123/0x300 fs/namei.c:4201
>   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> to a SOFTIRQ-irq-unsafe lock:
>  (hugetlb_lock){+.+.}-{2:2}
>
> ... which became SOFTIRQ-irq-unsafe at:
> ...
>   lock_acquire kernel/locking/lockdep.c:5510 [inline]
>   lock_acquire+0x1ab/0x730 kernel/locking/lockdep.c:5475
>   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
>   spin_lock include/linux/spinlock.h:354 [inline]
>   hugetlb_overcommit_handler+0x260/0x3e0 mm/hugetlb.c:3448
>   proc_sys_call_handler+0x336/0x610 fs/proc/proc_sysctl.c:591
>   call_write_iter include/linux/fs.h:1977 [inline]
>   new_sync_write+0x426/0x650 fs/read_write.c:519
>   vfs_write+0x796/0xa30 fs/read_write.c:606
>   ksys_write+0x12d/0x250 fs/read_write.c:659
>   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> other info that might help us debug this:
>
>  Possible interrupt unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(hugetlb_lock);
>                                local_irq_disable();
>                                lock(slock-AF_INET);
>                                lock(hugetlb_lock);
>   <Interrupt>
>     lock(slock-AF_INET);
>
>  *** DEADLOCK ***

This has been reproduced on 4.19 stable kernel as well [1] and there
is a reproducer as well.

It seems like sendmsg(MSG_ZEROCOPY) from a buffer backed by hugetlb. I
wonder if we just need to make hugetlb_lock softirq-safe.

[1] https://syzkaller.appspot.com/bug?extid=6383ce4b0b8ec575ad93
