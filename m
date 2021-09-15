Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4127840BF3A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 07:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbhIOFOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 01:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhIOFO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 01:14:29 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ECDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 22:13:10 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id s11so3170168yba.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 22:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=1jsvXsMk7Y/T5FvXQsXTjQ6ewD2rxYnHAxNxFYKSnlI=;
        b=Xx5faSp5+GpLy3BFfN1Wo6z+mEUt0AJe5rkOC08IWbhvIYuFo6XZ6J6yATOmHWdJDa
         NsBIdZSnCm3PwWgki83q2KMBjXLfQ365kTVjFVEYeZyDzx+KKU/3AznqcYCxLt8WZ4zb
         tZYbJ4ZVTEkiunxO8J9sBw+aK6vKfypFZCd0TIp4wjVT6h5AmKFdWxL9gKZOgk7XGqsB
         iHvmX0ZCBUWoFOC1P0lxrw68TyabVNyyBiBtZ4lk+l5Qn1cI5sqrR6USGIVW8mfD06Qf
         vtsdpgzMTGgJh+ONZw8p4PCxosGYNUIfiU08UTO41p4RAFUWKCNRUVOzdqEplTxpNtEz
         ooWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=1jsvXsMk7Y/T5FvXQsXTjQ6ewD2rxYnHAxNxFYKSnlI=;
        b=iUQBiuiqEo5D03OU7cT1pEDjyj77rOX20QLvI6rTIdnuZgOZMWWUTzKAddQa2dbqw2
         PpRiSGhXkz8e++uG+4oz0CrI+GIdRuUqzBGdKgvW/GESbZvn8GoySrhFPL/RBkTOipcb
         4o3N4wGs8aVi8Lzf/JNEFxk02RE5v4NuBylyqr1/F/uuj2fuWVLNKFsDgSsVJLwjLVzk
         dbpy/kmZBqTMESz/btWH6LyFPfvyF0poXs8SjLpbZpGm0Avv42OjcmU6o698sRBV0U4A
         WM9gz6vDcjdepbo4HZZr9k/fTxaF3IwNkzFQ48oZ565hl1al5NyqH9zvNV22MG+M59n5
         q26g==
X-Gm-Message-State: AOAM5325L+JTDzcd5MvE4a8wEAcWWb3Gc+7k+E7lvoFbU56OgtpHK6tH
        lv+wdHJmps4MXXJaiwbTBGunos1NIzpdJ9YLK+p8vA==
X-Google-Smtp-Source: ABdhPJyxyJIEzlSi67Twr/HPaF8pMPXErk3w7Xo2FfgzKpOFBi6fXkuynogVPxQGngn/arDnW+yT4s4jWHIJjzIOI6Y=
X-Received: by 2002:a25:cc55:: with SMTP id l82mr3590430ybf.148.1631682789331;
 Tue, 14 Sep 2021 22:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000acb87205cb2e283c@google.com>
In-Reply-To: <000000000000acb87205cb2e283c@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 15 Sep 2021 07:12:58 +0200
Message-ID: <CACT4Y+ZPUreCt6KQboXMonNmVDJ-6fhzgHR5fN_srrDm=fcpzA@mail.gmail.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in hash_ipportnet_create
To:     syzbot <syzbot+0e73f839b35d0973fb97@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Sept 2021 at 18:46, syzbot
<syzbot+0e73f839b35d0973fb97@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    7cca308cfdc0 Merge tag 'powerpc-5.15-1' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1238fbbd300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8aa56a640db99eb1
> dashboard link: https://syzkaller.appspot.com/bug?extid=0e73f839b35d0973fb97
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10ef4e0b300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1302e115300000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0e73f839b35d0973fb97@syzkaller.appspotmail.com

#syz dup: WARNING: kmalloc bug in hash_net_create

> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 8442 at mm/util.c:597 kvmalloc_node+0x111/0x120 mm/util.c:597
> Modules linked in:
> CPU: 0 PID: 8442 Comm: syz-executor543 Not tainted 5.14.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:kvmalloc_node+0x111/0x120 mm/util.c:597
> Code: 01 00 00 00 4c 89 e7 e8 4d 17 0d 00 49 89 c5 e9 69 ff ff ff e8 30 3e d1 ff 41 89 ed 41 81 cd 00 20 01 00 eb 95 e8 1f 3e d1 ff <0f> 0b e9 4c ff ff ff 0f 1f 84 00 00 00 00 00 55 48 89 fd 53 e8 06
> RSP: 0018:ffffc900019f7288 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffc900019f73a0 RCX: 0000000000000000
> RDX: ffff888018236140 RSI: ffffffff81a41371 RDI: 0000000000000003
> RBP: 0000000000400dc0 R08: 000000007fffffff R09: 000000000000001c
> R10: ffffffff81a4132e R11: 000000000000001f R12: 0000000080000018
> R13: 0000000000000000 R14: 00000000ffffffff R15: ffff8880171e1000
> FS:  00000000020ae300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000246 CR3: 0000000013999000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  hash_ipportnet_create+0x3dd/0x1220 net/netfilter/ipset/ip_set_hash_gen.h:1524
>  ip_set_create+0x782/0x15a0 net/netfilter/ipset/ip_set_core.c:1100
>  nfnetlink_rcv_msg+0xbc9/0x13f0 net/netfilter/nfnetlink.c:296
>  netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2504
>  nfnetlink_rcv+0x1ac/0x420 net/netfilter/nfnetlink.c:654
>  netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
>  netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1340
>  netlink_sendmsg+0x86d/0xdb0 net/netlink/af_netlink.c:1929
>  sock_sendmsg_nosec net/socket.c:704 [inline]
>  sock_sendmsg+0xcf/0x120 net/socket.c:724
>  ____sys_sendmsg+0x6e8/0x810 net/socket.c:2409
>  ___sys_sendmsg+0xf3/0x170 net/socket.c:2463
>  __sys_sendmsg+0xe5/0x1b0 net/socket.c:2492
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x43f039
> Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe5f928db8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000400488 RCX: 000000000043f039
> RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000003
> RBP: 0000000000403020 R08: 0000000000000005 R09: 0000000000400488
> R10: 0000000000000004 R11: 0000000000000246 R12: 00000000004030b0
> R13: 0000000000000000 R14: 00000000004ac018 R15: 0000000000400488
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000acb87205cb2e283c%40google.com.
