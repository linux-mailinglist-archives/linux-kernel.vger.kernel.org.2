Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604B632FE6F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 03:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhCGCTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 21:19:49 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:51792 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhCGCTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 21:19:18 -0500
Received: by mail-io1-f70.google.com with SMTP id i19so4851569ioh.18
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 18:19:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=E4jE1c0vu05pJVwh2PUr/mLeZRPgNa1jNXmZ5KuT2/o=;
        b=j+9dXSDy6oInkf9GahyLjf70dnkKNeAK8NYWRMYn3+ADol9z70r1PKUMasN9gt6JJh
         mXJF47t6t67LGWoEzbKoeQdfJvmsMw1ptpu8/7bseAjd7vC8p0bqz/QX0YDX+2cEb5Ev
         YF9yAL5ZwEmBhkDUWXmnLDdMKbM+SRH4+en/4i+LGTqaYmZX09PPrGhTxO7JX+tUSa8w
         zcndaPDyzFSDiUWjlxpkxlrRQVAJD/d1vLPPrxQ5VLPHtRKsD8unr6maQTO++7Igtbta
         Cpf+qDIzG9xBZpW3hRB3Eu+DrjwTlF9BP94FAUEd/mWPoO+Wsj8wMvX7IDxKfACnVac+
         bI8g==
X-Gm-Message-State: AOAM531Duds+hl8DaraInc/6Q0shTbR13bQZHhdSE8UsNVCE6WqrrT93
        I5yw2z93LmjLaJxasCCfh1k/nRBEzqqcznsXIGV2zs3HQZ9E
X-Google-Smtp-Source: ABdhPJwZqqJpz/Se5pan5wMIeAGD4jKzPHQyu/7FBcYZyzdPR6YGNciGYFMlzlaTHqR4B916tfv+sn7/BBVFIC6eLpjuAW2SD3eE
MIME-Version: 1.0
X-Received: by 2002:a05:6602:80d:: with SMTP id z13mr13225336iow.17.1615083557615;
 Sat, 06 Mar 2021 18:19:17 -0800 (PST)
Date:   Sat, 06 Mar 2021 18:19:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc002505bce8f18b@google.com>
Subject: [syzbot] general protection fault in klist_iter_exit
From:   syzbot <syzbot+e690c969b19e84332c36@syzkaller.appspotmail.com>
To:     bodefang@126.com, davem@davemloft.net, geliangtang@gmail.com,
        kuba@kernel.org, laniel_francis@privacyrequired.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d310ec03 Merge tag 'perf-core-2021-02-17' of git://git.ker..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1350c796d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b8307379601586a
dashboard link: https://syzkaller.appspot.com/bug?extid=e690c969b19e84332c36
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1480f5b6d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e826dad00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e690c969b19e84332c36@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 3882 Comm: kworker/0:3 Not tainted 5.11.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events netlink_sock_destruct_work
RIP: 0010:klist_iter_exit+0x21/0x80 lib/klist.c:313
Code: 66 0f 1f 84 00 00 00 00 00 41 54 55 53 48 89 fb e8 24 30 98 fd 48 8d 6b 08 48 b8 00 00 00 00 00 fc ff df 48 89 ea 48 c1 ea 03 <80> 3c 02 00 75 40 4c 8b 63 08 4d 85 e4 74 2e e8 fb 2f 98 fd 31 f6
RSP: 0018:ffffc9000312fbf8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff83daa98c RDI: 0000000000000000
RBP: 0000000000000008 R08: 0000000000000000 R09: ffffffff8d6fc867
R10: fffffbfff1adf90c R11: 1ffffffff1ede8aa R12: ffff888143cb7540
R13: 0000000000000000 R14: ffff88801bce1520 R15: ffff8880b9c34980
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2a3562f1f0 CR3: 0000000017103000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 nfc_device_iter_exit net/nfc/nfc.h:121 [inline]
 nfc_genl_dump_devices_done+0x31/0x50 net/nfc/netlink.c:639
 genl_lock_done+0x8d/0x100 net/netlink/genetlink.c:636
 netlink_sock_destruct+0x96/0x2b0 net/netlink/af_netlink.c:398
 __sk_destruct+0x4b/0x900 net/core/sock.c:1795
 sk_destruct+0xbd/0xe0 net/core/sock.c:1839
 __sk_free+0xef/0x3d0 net/core/sock.c:1850
 sk_free+0x78/0xa0 net/core/sock.c:1861
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
