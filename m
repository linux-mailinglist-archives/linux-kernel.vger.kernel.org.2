Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4DC4009BF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 06:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhIDEVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 00:21:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45357 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbhIDEVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 00:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630729215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Cc02D4maFVDrOfuUqOAbFyQQme9XlHg+cnP6n3qtQg=;
        b=XM5B7HypVirwp04FLVtdeWN8AUNhm9HezV8rzp2s/8QQGDquSvhXkvVF2D/jKT+gLLt6wZ
        JlzxvMZRkSJlpTjZTKWNSIEzSDgREvhjFQKuelIYPhcAoWLLbugdkdrI5TcHBoAAa1Dett
        AE/qmgT6GB4KVmGp34LLr6n2GymaJsQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-M9_qSftQOT-M9R9dnLPNMw-1; Sat, 04 Sep 2021 00:20:14 -0400
X-MC-Unique: M9_qSftQOT-M9R9dnLPNMw-1
Received: by mail-qk1-f200.google.com with SMTP id c27-20020a05620a165b00b003d3817c7c23so2461535qko.16
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 21:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Cc02D4maFVDrOfuUqOAbFyQQme9XlHg+cnP6n3qtQg=;
        b=eSmDKrkjLC6dIB2AdZiH+MrfRai8BLpfEr3M5Zu9FggDiCqS6hcuTFZOlt1Xq+pDJv
         THlVqU1nzmPtrdVmwwphbV4UeWvHh6IMsXUEF8/3AF2Xhoit5AXrIVNfzvoqn0LdJ+W+
         TvTleZiZAahqw57AYUwA6xwO0zcmaXyWZdJ0v+GVDyc+rVBK3c4F+1m0ug89oA9CyM+w
         i7rICUEi32y6BlrhIc0TB9LNGxevpIHEgkwH/WUAh3SOcXnmubmsArC+j6SnHC3Tzqrc
         7BnjzRub7VkOxqclryfRb04UPN0ZouSuTI75TNNWjNOSFKJq8qPJIw/eqTAZ+JJq6hbB
         WZuA==
X-Gm-Message-State: AOAM530Dtn/KnK5GlfSPTOSdITtAtaSiDDGzq9U+zX0i+x8G3APeJTDX
        vjd1dOiAe+OarPsUe/IbpRGrtJUl3mRIPz0g0Y2/fiTZu9MRRM2vUUovxm0wFU5JoxlKA5ltgkw
        vXYZs0amNeTNE64N5/05WBJ6b
X-Received: by 2002:a0c:ef4b:: with SMTP id t11mr2368115qvs.57.1630729213867;
        Fri, 03 Sep 2021 21:20:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwppzjIy1ikp6ehsb2tQg2EvQb3sDwOZTqNuNMahHPlqRzd48pyCfmia4p6GUKH7sM73PrT8g==
X-Received: by 2002:a0c:ef4b:: with SMTP id t11mr2368102qvs.57.1630729213659;
        Fri, 03 Sep 2021 21:20:13 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id p187sm907285qkd.101.2021.09.03.21.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 21:20:13 -0700 (PDT)
Date:   Fri, 3 Sep 2021 21:20:10 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     syzbot <syzbot+30622fb04ddd72a4d167@syzkaller.appspotmail.com>
Cc:     ardb@kernel.org, jbaron@akamai.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, Jussi Maki <joamaki@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [syzbot] WARNING in __static_key_slow_dec
Message-ID: <20210904042010.5henc6pn5zotdq6v@treble>
References: <0000000000000a9f3605cb1d2455@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000000a9f3605cb1d2455@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like a jump label usage bug ("jump label: negative count!") may
have been introduced, presumably with the following commit:

  9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")

Jussi, any idea?

On Fri, Sep 03, 2021 at 01:28:22PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    835d31d319d9 Merge tag 'media/v5.15-1' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15193486300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d793523866f2daea
> dashboard link: https://syzkaller.appspot.com/bug?extid=30622fb04ddd72a4d167
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1565e801300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bd5513300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+30622fb04ddd72a4d167@syzkaller.appspotmail.com
> 
> 8021q: adding VLAN 0 to HW filter on device bond5
> ------------[ cut here ]------------
> jump label: negative count!
> WARNING: CPU: 0 PID: 8606 at kernel/jump_label.c:235 static_key_slow_try_dec kernel/jump_label.c:235 [inline]
> WARNING: CPU: 0 PID: 8606 at kernel/jump_label.c:235 __static_key_slow_dec_cpuslocked kernel/jump_label.c:243 [inline]
> WARNING: CPU: 0 PID: 8606 at kernel/jump_label.c:235 __static_key_slow_dec+0xfb/0x150 kernel/jump_label.c:255
> Modules linked in:
> CPU: 0 PID: 8606 Comm: syz-executor165 Not tainted 5.14.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:static_key_slow_try_dec kernel/jump_label.c:235 [inline]
> RIP: 0010:__static_key_slow_dec_cpuslocked kernel/jump_label.c:243 [inline]
> RIP: 0010:__static_key_slow_dec+0xfb/0x150 kernel/jump_label.c:255
> Code: c3 40 0f 94 c6 31 ff e8 63 34 d9 ff 84 db 75 1e e8 8a 31 d9 ff eb 24 e8 83 31 d9 ff 48 c7 c7 40 75 59 8a 31 c0 e8 25 8b a4 ff <0f> 0b eb 9f e8 6c 31 d9 ff 4c 89 f7 e8 54 f6 ff ff 48 c7 c7 c0 88
> RSP: 0018:ffffc9000215e438 EFLAGS: 00010246
> RAX: 5e2d18889f3c9100 RBX: 00000000ffffffff RCX: ffff8880224d3900
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: 00000000ffffffff R08: ffffffff8166aff2 R09: ffffed1017383f2c
> R10: ffffed1017383f2c R11: 0000000000000000 R12: 0000000000000000
> R13: ffff8880356f00b0 R14: ffffffff90d9ec00 R15: 1ffff9200042bc01
> FS:  00000000017be300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000200001c0 CR3: 0000000036bed000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  bond_xdp_set drivers/net/bonding/bond_main.c:5233 [inline]
>  bond_xdp+0x8dd/0xa10 drivers/net/bonding/bond_main.c:5264
>  bond_enslave+0x40b7/0x5e20 drivers/net/bonding/bond_main.c:2187
>  do_set_master net/core/rtnetlink.c:2521 [inline]
>  do_setlink+0xfc3/0x4250 net/core/rtnetlink.c:2726
>  __rtnl_newlink net/core/rtnetlink.c:3391 [inline]
>  rtnl_newlink+0x16ee/0x1cf0 net/core/rtnetlink.c:3506
>  rtnetlink_rcv_msg+0x91c/0xe50 net/core/rtnetlink.c:5572
>  netlink_rcv_skb+0x1f0/0x460 net/netlink/af_netlink.c:2504
>  netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
>  netlink_unicast+0x7de/0x9b0 net/netlink/af_netlink.c:1340
>  netlink_sendmsg+0x9e7/0xe00 net/netlink/af_netlink.c:1929
>  sock_sendmsg_nosec net/socket.c:704 [inline]
>  sock_sendmsg net/socket.c:724 [inline]
>  ____sys_sendmsg+0x5a2/0x900 net/socket.c:2409
>  ___sys_sendmsg net/socket.c:2463 [inline]
>  __sys_sendmsg+0x319/0x400 net/socket.c:2492
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x440db9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffcd41b2788 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000440db9
> RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000005
> RBP: 0000000000000000 R08: 0000000000f0b5ff R09: 0000000000f0b5ff
> R10: 0000000000f0b5ff R11: 0000000000000246 R12: 000000000000bd7b
> R13: 00007ffcd41b27b0 R14: 00007ffcd41b27a0 R15: 00007ffcd41b2794
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

-- 
Josh

