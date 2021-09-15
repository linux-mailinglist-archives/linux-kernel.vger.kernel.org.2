Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABD740BF3E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 07:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbhIOFRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 01:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhIOFRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 01:17:24 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE5BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 22:16:05 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id m70so3242173ybm.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 22:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=5B0+TZksMnndvwWK3f93v1Xnkyo2cNNQSWU9h/st/Qk=;
        b=J16KnBNUnUZXrBGpt8hsvHC/Jzp8m7DMkbZdWov6VKK5BJn3XRWDDJKbzY3eFoF/VS
         i6BSR+i1QE1XWXG3dxK4SvdBETA/UOyxQi0pLY48E3NR6Z1vPf05a70f3y5GvMEmqJet
         L2RVCP8cK76bCVSHEYjaJCWbk2ThtRr6x/XqfGo7cKd8P/0A10NhoIzFtuyBbNlgx4Ir
         k5wNPIN8QgIgR3LtPbELEXxiTv94bNuu9it0JG6XayKKsXNX2VHNQuzym90prrN1Jq0o
         5PPIrdwZHsc8SlMahgOTsqpMd4RT3rpq5a1Mstov0JX4fnO2O1atlhfbKOPWNxHno0h9
         fGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=5B0+TZksMnndvwWK3f93v1Xnkyo2cNNQSWU9h/st/Qk=;
        b=x6hpg7KEyy6mYddsPklJ+N26IAyu/kSzU8iRhHFUqZXDeCpIdvwMioMIO1x99NKuv0
         qvvehVw5iprNotOOFzD8ZXMtT6vpbwRpv8B7bVw9wLoZxbEjg/0d44azjMrLvv6GlN2i
         Va6wokFH/uccpiK+mPw0hFg8L0r/kBVEJctgA2tNpcx1JmEDDgy7o/FV0rOVM7gN4nHF
         HhVC+yoy6+t6a5acxVlhDKQP5s3asnB469APKh90FV5DeAYRKdOKWMtdS/SiU6NgsjlS
         hUiZ1iBb9Egb7jGPv1Au3Z0yvv/XFDdlOlgofSffRC11R78ybeO8LZvXfZMpbjnS2Ntg
         5GKA==
X-Gm-Message-State: AOAM532Qz6yCsI5GCu9BlhO9PCh1uH6xPiGfdRV/3rfwz3A8WmWS7mWj
        +VitAJZA74aAE9j9FNUcVz6ldbNc16/SnrRl4vEhCXpVY+/W4Q==
X-Google-Smtp-Source: ABdhPJyaP6h974btm1EiB5vEkBxkCp6+9U+o5X1nxS+QGy9jgfkDmYcCNSt5WSGukwsnnLzCefn9FRosRF9xr26Zz58=
X-Received: by 2002:a25:2cca:: with SMTP id s193mr4104129ybs.66.1631682964698;
 Tue, 14 Sep 2021 22:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006b591e05cb1ffa15@google.com>
In-Reply-To: <0000000000006b591e05cb1ffa15@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 15 Sep 2021 07:15:53 +0200
Message-ID: <CACT4Y+bJ1e=i=vd8Jv6B_9jeks8OdrNGs+W3hqmBPWoOdRQoTQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in hash_ipmac_create
To:     syzbot <syzbot+cf28dc7802e9fcee1305@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Sept 2021 at 01:51, syzbot
<syzbot+cf28dc7802e9fcee1305@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    a9c9a6f741cd Merge tag 'scsi-misc' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=176e5ccd300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1ac29107aeb2a552
> dashboard link: https://syzkaller.appspot.com/bug?extid=cf28dc7802e9fcee1305
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1076ba86300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b3e6a3300000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+cf28dc7802e9fcee1305@syzkaller.appspotmail.com

#syz dup: WARNING: kmalloc bug in hash_net_create

> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 8431 at mm/util.c:597 kvmalloc_node+0x111/0x120 mm/util.c:597
> Modules linked in:
> CPU: 0 PID: 8431 Comm: syz-executor142 Not tainted 5.14.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:kvmalloc_node+0x111/0x120 mm/util.c:597
> Code: 01 00 00 00 4c 89 e7 e8 ed 11 0d 00 49 89 c5 e9 69 ff ff ff e8 90 55 d1 ff 41 89 ed 41 81 cd 00 20 01 00 eb 95 e8 7f 55 d1 ff <0f> 0b e9 4c ff ff ff 0f 1f 84 00 00 00 00 00 55 48 89 fd 53 e8 66
> RSP: 0018:ffffc90001a27288 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffc90001a273a0 RCX: 0000000000000000
> RDX: ffff8880167301c0 RSI: ffffffff81a3f651 RDI: 0000000000000003
> RBP: 0000000000400dc0 R08: 000000007fffffff R09: 000000000000001f
> R10: ffffffff81a3f60e R11: 000000000000001f R12: 0000000400000018
> R13: 0000000000000000 R14: 00000000ffffffff R15: ffff88801767fe00
> FS:  0000000000d00300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000006 CR3: 000000001e129000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  hash_ipmac_create+0x3dd/0x1220 net/netfilter/ipset/ip_set_hash_gen.h:1524
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
> RSP: 002b:00007fff67f70028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000400488 RCX: 000000000043f039
> RDX: 0000000000000000 RSI: 0000000020000240 RDI: 0000000000000003
> RBP: 0000000000403020 R08: 0000000000000009 R09: 0000000000400488
> R10: 0000000000000001 R11: 0000000000000246 R12: 00000000004030b0
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000006b591e05cb1ffa15%40google.com.
