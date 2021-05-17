Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3015382A14
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbhEQKqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:46:52 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:36640 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbhEQKqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:46:49 -0400
Received: by mail-io1-f69.google.com with SMTP id i15-20020a6bee0f0000b029043af67da217so1512901ioh.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ci9TNO3sk6ZfPoN7cYBZhsWewxbiJdSRX4/qNKu6FyQ=;
        b=pv4u33rhPxh0eN7ovKdH3wQzwEE0kd2Zrm5/MoKMzKi0+N9Kq2+RUw45E5+re+ClBM
         ngqzEc7jMrvCjOx4ekEXq41mbb3r0IH7bu8dk1/wexuEOOpI+nj5ygyEVkyuiFf3Lt4w
         ueQbqjrwMM4Wsv6xglQ2t1tOCtBf559X9fuGjqitFtzlBcX7/5NKe0uZyNsLtMTaZQpd
         bqXk8/Uqvdh/ESbT9u7vGCuXz9nF7/RI9Kd/3Y5MOhcMS0yu9SraVdKpyCzq1nBjKBsv
         qJd3S1bBadWemswRsnIWdh/eq890bVdBtdfAtHJepO2sgvsHGKBQX9T5t7JntMbLQCml
         3QUQ==
X-Gm-Message-State: AOAM531G+NQ7nlXWtHVBCe0t9WwkAclPkpFp+5tMbRVd56nvMlyC/ZuQ
        dQ6k+Ip9mdp6SRUChAcFbFwM6XobKKz+zkssv+l/Qd5rstpz
X-Google-Smtp-Source: ABdhPJzGZdNrHY27D8Ccic4m6oHTkXOBLFT3ziSZSJ+0pFK6P5g3sHVT6X5Ib+mNx5Hf89jWMj7N0U+WDtRjOUVhjimr7OVFM1eJ
MIME-Version: 1.0
X-Received: by 2002:a6b:6c0b:: with SMTP id a11mr7074611ioh.37.1621248333000;
 Mon, 17 May 2021 03:45:33 -0700 (PDT)
Date:   Mon, 17 May 2021 03:45:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb328005c2844acc@google.com>
Subject: [syzbot] divide error in mac80211_hwsim_bss_info_changed
From:   syzbot <syzbot+26727b5e00947e02242c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johannes@sipsolutions.net, kuba@kernel.org,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    eebe426d Merge tag 'fixes-for-5.12-rc7' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e73ceed00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c3d8981d2bdb103
dashboard link: https://syzkaller.appspot.com/bug?extid=26727b5e00947e02242c
compiler:       Debian clang version 11.0.1-2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+26727b5e00947e02242c@syzkaller.appspotmail.com

divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 13049 Comm: kworker/u4:16 Not tainted 5.12.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: phy10 ieee80211_roc_work
RIP: 0010:mac80211_hwsim_bss_info_changed+0x514/0xf90 drivers/net/wireless/mac80211_hwsim.c:2024
Code: 48 b8 00 00 00 00 00 fc ff df 80 7c 05 00 00 74 0a 48 8b 7c 24 08 e8 9b a6 68 fc 48 8b 44 24 08 48 8b 08 89 ce 48 89 d8 31 d2 <48> f7 f6 29 d1 48 69 f1 e8 03 00 00 48 8b 7c 24 10 31 d2 b9 05 00
RSP: 0018:ffffc900023bfb88 EFLAGS: 00010246
RAX: 0005bfe4b761f015 RBX: 0005bfe4b761f015 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000040
RBP: 1ffff11004556dcf R08: ffffffff81698b49 R09: fffffbfff1f272bd
R10: fffffbfff1f272bd R11: 0000000000000000 R12: ffff888022ab0d50
R13: 0000000000000200 R14: ffff888022ab6fd8 R15: 1ffff110045561aa
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000543038 CR3: 000000007746b000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 drv_bss_info_changed net/mac80211/driver-ops.h:177 [inline]
 ieee80211_bss_info_change_notify+0x27c/0x3a0 net/mac80211/main.c:210
 ieee80211_offchannel_return+0x33b/0x470 net/mac80211/offchannel.c:158
 __ieee80211_roc_work+0x282/0x340 net/mac80211/offchannel.c:444
 ieee80211_roc_work+0x2b/0x40 net/mac80211/offchannel.c:458
 process_one_work+0x789/0xfd0 kernel/workqueue.c:2275
 worker_thread+0xac1/0x1300 kernel/workqueue.c:2421
 kthread+0x39a/0x3c0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Modules linked in:
---[ end trace 2380ddc5fa748069 ]---
RIP: 0010:mac80211_hwsim_bss_info_changed+0x514/0xf90 drivers/net/wireless/mac80211_hwsim.c:2024
Code: 48 b8 00 00 00 00 00 fc ff df 80 7c 05 00 00 74 0a 48 8b 7c 24 08 e8 9b a6 68 fc 48 8b 44 24 08 48 8b 08 89 ce 48 89 d8 31 d2 <48> f7 f6 29 d1 48 69 f1 e8 03 00 00 48 8b 7c 24 10 31 d2 b9 05 00
RSP: 0018:ffffc900023bfb88 EFLAGS: 00010246
RAX: 0005bfe4b761f015 RBX: 0005bfe4b761f015 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000040
RBP: 1ffff11004556dcf R08: ffffffff81698b49 R09: fffffbfff1f272bd
R10: fffffbfff1f272bd R11: 0000000000000000 R12: ffff888022ab0d50
R13: 0000000000000200 R14: ffff888022ab6fd8 R15: 1ffff110045561aa
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000219a708 CR3: 000000007746b000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
