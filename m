Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015EC40BF38
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 07:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbhIOFNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 01:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhIOFNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 01:13:32 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AB9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 22:12:13 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id s16so3368805ybe.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 22:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=afdqglmAlZ70ZY8a/2qLu/q9hid1HvJdabpJ0OzynIk=;
        b=OXqacRij9/OkqH4FkdSC68Npzx1SUWfYQSsNLJ4iMVDd9frjKJf3F2UoiozqHZZkOb
         no/oGl6gLPeFiGDTe08/eYPC81Qb3DfMSg3heJK4+SQU4Jrq+gH0/BrjpKTSizZmmtSk
         aeg7f4X1xp19CS3USiFKTDek1jYvfnBKnBY+XmTzUkXNfsM+YPiq8UEn7i6dZaK6krMy
         8roAi2sC+ZKlBixkTXS9zepGx1sA22R83TdeaHmU11uvchjguyFIX7EWYe+BN7wf63ej
         +hvUdiS4YWELMdVP6uWeueVrmLo5lHCWfhlCKbqO9WkXWSUzpX9XRcbJ4zf02eDbrpKb
         tr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=afdqglmAlZ70ZY8a/2qLu/q9hid1HvJdabpJ0OzynIk=;
        b=b1+v4uoIiNAsKZTuux6wg1H8HuA58WCXEjtJGmrW0C/5VyjgefQ9E+vjxOi6Gv9baW
         QgALn1RpAFzRJBrorh8N2ftm8ePHUeczoWfpzOJpKFKvFQnK2m/0JGkNg+O5b/aNig/4
         2fKc9qOGTft727BeATXNG85cun7R8Iwc15AM3Chxx4Kg066qU3BcvuC9N8tRLaID2K1q
         lHP6Brfi9ZFOC7dakGd2W+CZEJoxK4jXpZ/IJOxdg9A6kk9zfftzab5odXJICkDGZdnA
         rKjfJKbO2Evoev+hV+LjDIk2nvMncHayUibcPNq2gpmHU395ddIH86q1p/gNXu+rHkyr
         VYtA==
X-Gm-Message-State: AOAM532S4R+B4GdWnkjDuNX0v2FZaj1M7jgJbN0nEEv5cvgcQ5AZCGKB
        0gNBiy/lH5hSRVGaqattgQuKNF7ztR8syFaVcKS3nlk8H/cqPA==
X-Google-Smtp-Source: ABdhPJyVa0RlrtrWvaTqsTUs6r4coa1nUEJUkYu7KY+9lFSMHmWI1MCoWf4SrkvkdPJea0L57WqakUsmIIXfb7rE+lI=
X-Received: by 2002:a25:9906:: with SMTP id z6mr3659329ybn.373.1631682732832;
 Tue, 14 Sep 2021 22:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006173bf05cb892427@google.com>
In-Reply-To: <0000000000006173bf05cb892427@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 15 Sep 2021 07:12:01 +0200
Message-ID: <CACT4Y+brd8uLnWsnVzyKa=Hr_wQfUktSzXe7FB6OhdmyWS8y-w@mail.gmail.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in hash_ipport_create
To:     syzbot <syzbot+a568bbab323b96631e61@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Sept 2021 at 07:19, syzbot
<syzbot+a568bbab323b96631e61@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    626bf91a292e Merge tag 'net-5.15-rc1' of git://git.kernel...
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=150107a5300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=16e23f04679ec35e
> dashboard link: https://syzkaller.appspot.com/bug?extid=a568bbab323b96631e61
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=178b5d0d300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fad1dd300000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a568bbab323b96631e61@syzkaller.appspotmail.com

#syz dup: WARNING: kmalloc bug in hash_net_create

> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 8419 at mm/util.c:597 kvmalloc_node+0x111/0x120 mm/util.c:597
> Modules linked in:
> CPU: 0 PID: 8419 Comm: syz-executor852 Not tainted 5.14.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:kvmalloc_node+0x111/0x120 mm/util.c:597
> Code: 01 00 00 00 4c 89 e7 e8 3d 13 0d 00 49 89 c5 e9 69 ff ff ff e8 50 9d d0 ff 41 89 ed 41 81 cd 00 20 01 00 eb 95 e8 3f 9d d0 ff <0f> 0b e9 4c ff ff ff 0f 1f 84 00 00 00 00 00 55 48 89 fd 53 e8 26
> RSP: 0018:ffffc9000110f288 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffc9000110f3a0 RCX: 0000000000000000
> RDX: ffff88807ad9d580 RSI: ffffffff81a57421 RDI: 0000000000000003
> RBP: 0000000000400dc0 R08: 000000007fffffff R09: ffff8880b9d3298b
> R10: ffffffff81a573de R11: 000000000000001f R12: 0000000200000018
> R13: 0000000000000000 R14: 00000000ffffffff R15: ffff888027ea2a00
> FS:  0000000001147300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fd51c03d0c8 CR3: 00000000726fe000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  hash_ipport_create+0x3dd/0x1220 net/netfilter/ipset/ip_set_hash_gen.h:1524
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
> RSP: 002b:00007fff01c17cc8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000400488 RCX: 000000000043f039
> RDX: 0000000000000000 RSI: 0000000020001080 RDI: 0000000000000003
> RBP: 0000000000403020 R08: 0000000000000009 R09: 0000000000400488
> R10: 0000000000000003 R11: 0000000000000246 R12: 00000000004030b0
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000006173bf05cb892427%40google.com.
