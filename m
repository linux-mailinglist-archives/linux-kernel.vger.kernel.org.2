Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC7B33751A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbhCKOHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:07:53 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:56529 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbhCKOHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:07:24 -0500
Received: by mail-io1-f72.google.com with SMTP id y2so15385832ioa.23
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 06:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oSSMkoO2iwx+Y3QJBh7Yl6QGzvkcw+HW5CoIi/jlJDo=;
        b=Kombctl+e/3EiI0St1DTxnmBREXd4sPxgFC5RbDqrt0tBmic0TiUv3GJ4zu56DACZx
         wsQyf01yS8E19Jb5mV6Dv1BVlATzOfn3jml+ExSLpm86YY64LpTmlqk1BZVzXgKKfBw3
         5uEgVvW20venefLeATX6bB+nP0/WqueCcsULQHEL92vOMbLRO/48uReSgonjawSjz/Z+
         2hFO9YhAFMycJs0Ht0QCY21Xl1VQXza/jALspncjWpOpM+jGYi8ztr0OjXCFBW8AqSsS
         gzbiFC9IzE84y6M5OZu+HQtfJDtv30EIpuZ91dh3Rgo83ewOgEXleaznOW15b0+0i4qj
         5oUw==
X-Gm-Message-State: AOAM533EbftxqXGGWFdFyv5hjRyQsO3SZSNjQ/izznC7Wu3Xsn6RMl9q
        SfhYfSZJxxVIccOM1piDpBpcIGFX+5fcX395cRoQa+xNGSOD
X-Google-Smtp-Source: ABdhPJzmXgC5fGa8aIKmKXOLrkYQF71/Mz+oI0aHPSljhvDhT5DRbaZ6sFa29XwCgH47zW5XIbrLZ3ouEQNF5ZhgCqeGnwvDZ3xm
MIME-Version: 1.0
X-Received: by 2002:a6b:590e:: with SMTP id n14mr6439081iob.107.1615471644420;
 Thu, 11 Mar 2021 06:07:24 -0800 (PST)
Date:   Thu, 11 Mar 2021 06:07:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082ae5a05bd434d67@google.com>
Subject: [syzbot] WARNING in netlink_broadcast_filtered
From:   syzbot <syzbot+e79c128f58297b9148dc@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a74e6a01 Merge tag 's390-5.12-3' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f7c83ad00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7ac5ce2d1160e16
dashboard link: https://syzkaller.appspot.com/bug?extid=e79c128f58297b9148dc
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e79c128f58297b9148dc@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 7650 at include/linux/seqlock.h:271 __seqprop_assert include/linux/seqlock.h:271 [inline]
WARNING: CPU: 0 PID: 7650 at include/linux/seqlock.h:271 __seqprop_assert.constprop.0+0xf0/0x11c include/linux/seqlock.h:269
Modules linked in:
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 7650 Comm: udevd Not tainted 5.12.0-rc2-syzkaller #0
Hardware name: ARM-Versatile Express
Backtrace: 
[<82107738>] (dump_backtrace) from [<821079ac>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:252)
 r7:00000080 r6:60000093 r5:00000000 r4:83966184
[<82107994>] (show_stack) from [<82110980>] (__dump_stack lib/dump_stack.c:79 [inline])
[<82107994>] (show_stack) from [<82110980>] (dump_stack+0xb8/0xe8 lib/dump_stack.c:120)
[<821108c8>] (dump_stack) from [<82108540>] (panic+0x130/0x378 kernel/panic.c:231)
 r7:8293262c r6:8383dd64 r5:00000000 r4:83b620d0
[<82108410>] (panic) from [<80244924>] (__warn+0xb0/0x164 kernel/panic.c:605)
 r3:83822c8c r2:00000000 r1:00000000 r0:8293262c
 r7:0000010f
[<80244874>] (__warn) from [<821087f0>] (warn_slowpath_fmt+0x68/0xd4 kernel/panic.c:628)
 r7:818c4fc8 r6:0000010f r5:8292aac0 r4:00000000
[<8210878c>] (warn_slowpath_fmt) from [<818c4fc8>] (__seqprop_assert include/linux/seqlock.h:271 [inline])
[<8210878c>] (warn_slowpath_fmt) from [<818c4fc8>] (__seqprop_assert.constprop.0+0xf0/0x11c include/linux/seqlock.h:269)
 r8:e85fc000 r7:819ab52c r6:00000001 r5:88799e40 r4:00000001
[<818c4ed8>] (__seqprop_assert.constprop.0) from [<818c7524>] (u64_stats_update_begin include/linux/u64_stats_sync.h:128 [inline])
[<818c4ed8>] (__seqprop_assert.constprop.0) from [<818c7524>] (__bpf_prog_run_save_cb include/linux/filter.h:727 [inline])
[<818c4ed8>] (__seqprop_assert.constprop.0) from [<818c7524>] (bpf_prog_run_save_cb include/linux/filter.h:741 [inline])
[<818c4ed8>] (__seqprop_assert.constprop.0) from [<818c7524>] (sk_filter_trim_cap+0x224/0x434 net/core/filter.c:149)
 r5:88799e40 r4:00000000
[<818c7300>] (sk_filter_trim_cap) from [<819ab52c>] (sk_filter include/linux/filter.h:867 [inline])
[<818c7300>] (sk_filter_trim_cap) from [<819ab52c>] (do_one_broadcast net/netlink/af_netlink.c:1468 [inline])
[<818c7300>] (sk_filter_trim_cap) from [<819ab52c>] (netlink_broadcast_filtered+0x27c/0x4fc net/netlink/af_netlink.c:1520)
 r10:00000001 r9:8430585c r8:00000000 r7:86f24064 r6:88799e40 r5:88f45000
 r4:86f24000
[<819ab2b0>] (netlink_broadcast_filtered) from [<819ae010>] (netlink_broadcast net/netlink/af_netlink.c:1544 [inline])
[<819ab2b0>] (netlink_broadcast_filtered) from [<819ae010>] (netlink_sendmsg+0x3d0/0x478 net/netlink/af_netlink.c:1925)
 r10:00000000 r9:00000002 r8:88f45000 r7:000000ce r6:88799780 r5:88b8ff50
 r4:88e82800
[<819adc40>] (netlink_sendmsg) from [<81867400>] (sock_sendmsg_nosec net/socket.c:654 [inline])
[<819adc40>] (netlink_sendmsg) from [<81867400>] (sock_sendmsg+0x3c/0x4c net/socket.c:674)
 r10:00000000 r9:88b8fdd4 r8:00000000 r7:87dc4680 r6:00000000 r5:87dc4680
 r4:88b8ff50
[<818673c4>] (sock_sendmsg) from [<8186897c>] (____sys_sendmsg+0x230/0x29c net/socket.c:2350)
 r5:00000040 r4:88b8ff50
[<8186874c>] (____sys_sendmsg) from [<8186a968>] (___sys_sendmsg+0xac/0xe4 net/socket.c:2404)
 r10:00000128 r9:88b8e000 r8:00000000 r7:00000000 r6:87dc4680 r5:88b8ff50
 r4:00000000
[<8186a8bc>] (___sys_sendmsg) from [<8186ab50>] (__sys_sendmsg net/socket.c:2433 [inline])
[<8186a8bc>] (___sys_sendmsg) from [<8186ab50>] (__do_sys_sendmsg net/socket.c:2442 [inline])
[<8186a8bc>] (___sys_sendmsg) from [<8186ab50>] (sys_sendmsg+0x58/0xa0 net/socket.c:2440)
 r8:80200224 r7:00000128 r6:00000000 r5:7e90c3dc r4:87dc4680
[<8186aaf8>] (sys_sendmsg) from [<80200060>] (ret_fast_syscall+0x0/0x2c arch/arm/mm/proc-v7.S:64)
Exception stack(0x88b8ffa8 to 0x88b8fff0)
ffa0:                   00000000 00000000 0000000c 7e90c3dc 00000000 00000000
ffc0: 00000000 00000000 76f1f840 00000128 00000000 000000a6 7e90c3dc 000563f8
ffe0: 00056110 7e90c3a0 00036cec 76bfbf44
 r6:76f1f840 r5:00000000 r4:00000000
Dumping ftrace buffer:
   (ftrace buffer empty)
Rebooting in 1 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
