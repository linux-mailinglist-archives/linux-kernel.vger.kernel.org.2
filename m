Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6A4371E7D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhECRWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:22:53 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:40696 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbhECRWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 13:22:20 -0400
Received: by mail-il1-f199.google.com with SMTP id d3-20020a056e021c43b029016bec7d6e48so5061044ilg.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 10:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=PmToXBImkI7KxfCI+FowXrQSxpirCmDD8jPohkDzvPA=;
        b=cvTL8JNtxY4+2H/O+gqtjiGW0aN62zIeUCY0BjgATRRFo4uXHW8SJUbScR7Aq9hjtW
         5NdV91+a/GaPzW5tVU5rvE4y2KeurM6BViP7ql0c89Cw/ln7mHnKnt7IscEoDinKseBV
         0AWj0XikzqFSpGR2YTKBpxJ/GbfPYkWoGXkeAPrNepsDRNrAVaMfMFswHR/nrjiYVK/D
         zQ+3m3/DtCth1e3InNCiDkJndtvvVKvyV6rV2P7jOs98DawBezdkcDIKavz44OshnOyH
         lDNEtjQ2N7U4UryP7+OiXsJuqJe16rZp6W+XqoQY5MRXTMcLLTI37FCMiAhaQIMr5FMK
         qMCQ==
X-Gm-Message-State: AOAM5332PNB8TNk4A9r26OOrl4dJlicYD0nQXISZerpuh4v3qwxiv+mT
        MMDTo+M/UYJHMgs08EpvxsvDfTOFQi00uEgOnqloSk8Ec0Xq
X-Google-Smtp-Source: ABdhPJzBdcLciDhmBdRBkgDQi4x+AqgpCqFyNzSauL8Nx0gPbD+rJVhAFXy7De2cTBWgubGJ7Sti4UHJJzxbOmvqTgkrF+p8qS2+
MIME-Version: 1.0
X-Received: by 2002:a92:d682:: with SMTP id p2mr16658854iln.75.1620062486429;
 Mon, 03 May 2021 10:21:26 -0700 (PDT)
Date:   Mon, 03 May 2021 10:21:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000485d705c17031fd@google.com>
Subject: [syzbot] bpf test error: WARNING in __nf_unregister_net_hook
From:   syzbot <syzbot+854457fa0d41f836cd0e@syzkaller.appspotmail.com>
To:     ast@kernel.org, coreteam@netfilter.org, daniel@iogearbox.net,
        davem@davemloft.net, fw@strlen.de, kadlec@netfilter.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f80f88f0 selftests/bpf: Fix the snprintf test
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=16fd921ed00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57b4b78935781045
dashboard link: https://syzkaller.appspot.com/bug?extid=854457fa0d41f836cd0e

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+854457fa0d41f836cd0e@syzkaller.appspotmail.com

------------[ cut here ]------------
hook not found, pf 3 num 0
WARNING: CPU: 1 PID: 9 at net/netfilter/core.c:480 __nf_unregister_net_hook+0x1eb/0x610 net/netfilter/core.c:480
Modules linked in:
CPU: 1 PID: 9 Comm: kworker/u4:0 Not tainted 5.12.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
RIP: 0010:__nf_unregister_net_hook+0x1eb/0x610 net/netfilter/core.c:480
Code: 0f b6 14 02 48 89 c8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 11 04 00 00 8b 53 1c 89 ee 48 c7 c7 c0 78 6d 8a e8 40 4c 8a 01 <0f> 0b e9 e5 00 00 00 e8 59 48 30 fa 44 8b 3c 24 4c 89 f8 48 c1 e0
RSP: 0018:ffffc90000ce7bc0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8881474f6900 RCX: 0000000000000000
RDX: ffff888011d50000 RSI: ffffffff815c8ba5 RDI: fffff5200019cf6a
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815c2a0e R11: 0000000000000000 R12: ffff888028a68f20
R13: 0000000000000000 R14: ffff8880144d9100 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f41d41cb000 CR3: 0000000021c10000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 nf_unregister_net_hook net/netfilter/core.c:502 [inline]
 nf_unregister_net_hooks+0x117/0x160 net/netfilter/core.c:576
 arpt_unregister_table_pre_exit+0x67/0x80 net/ipv4/netfilter/arp_tables.c:1565
 ops_pre_exit_list net/core/net_namespace.c:165 [inline]
 cleanup_net+0x451/0xb10 net/core/net_namespace.c:583
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
