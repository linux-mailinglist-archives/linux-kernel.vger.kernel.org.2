Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F216370286
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbhD3U7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 16:59:09 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:51142 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbhD3U7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 16:59:04 -0400
Received: by mail-il1-f199.google.com with SMTP id t4-20020a92c0c40000b02901990d153bb9so11411234ilf.17
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6h1ZxgO6iKfJhFGptmgds8TlS+dggD6dzoUv/YrF7Ew=;
        b=kCJ2tskFC7IWg+UDQC9QqVsx58mfSsXROEZ8WOJbUoU6/Q2QCMeKlcdNWJ1ixXe5e8
         j/GmscSDwz9ZIRTtClVix90WzZp/b79sEI+eX/9pS2uMzQMspP6IJL7eZ9xSldaLvLMK
         eYFG/zFqpWMubpkWaCNgeM6h+52RwrjvihGoNwgHItQYkRGPIwu4hG3zRBaZ1fPs8ynx
         64H4Y+9z98U6X6v5wN6DjpYJ366dZTzCwHkqghgMOlu2JtaMAfZ4kwz5FP9vLPUyGi+O
         mRel4h5UAoAuaFJUxF805fy0sKc3UVEMbmZapoB7WoWlPR8N90QtNPk29SPu2T6iE44l
         TMxw==
X-Gm-Message-State: AOAM533vkSfIYxtYkS5iKxK3d5mouBDbTI+1qNohU93bUA4GZuChfsvX
        /zvWosBpaliaHKbHU/w+72CcLPr00YQHfcRsxJlgHxzKUIqV
X-Google-Smtp-Source: ABdhPJyLPfj71xJBaPCuJcqtA7dvsH2UfjIVzlbqy5cTGhaxzrgGRRe+1jJiFcmglpHT4mv7ODMm87NJPCV6guLJEhmBYIT7Aeem
MIME-Version: 1.0
X-Received: by 2002:a6b:7014:: with SMTP id l20mr5280652ioc.96.1619816295827;
 Fri, 30 Apr 2021 13:58:15 -0700 (PDT)
Date:   Fri, 30 Apr 2021 13:58:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea0f5405c136ded4@google.com>
Subject: [syzbot] WARNING in do_epoll_ctl
From:   syzbot <syzbot+25880e2b56e3a1f8fbc8@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    57e22247 net: wwan: core: Return poll error in case of por..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=105f2ee5d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7668018815a66138
dashboard link: https://syzkaller.appspot.com/bug?extid=25880e2b56e3a1f8fbc8

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+25880e2b56e3a1f8fbc8@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current)
WARNING: CPU: 1 PID: 8398 at kernel/locking/mutex.c:1235 __mutex_unlock_slowpath+0x457/0x610 kernel/locking/mutex.c:1235
Modules linked in:

CPU: 0 PID: 8398 Comm: systemd-udevd Not tainted 5.12.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__mutex_unlock_slowpath+0x457/0x610 kernel/locking/mutex.c:1235
Code: 00 00 44 8b 05 0a f8 da 06 45 85 c0 0f 84 e8 fc ff ff e9 ed fc ff ff 48 c7 c6 20 88 6b 89 48 c7 c7 60 88 6b 89 e8 12 59 bd ff <0f> 0b eb c2 e8 e0 5c fe ff 85 c0 0f 84 04 fe ff ff 48 c7 c0 88 46
RSP: 0018:ffffc9000166fc98 EFLAGS: 00010286

RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: ffff888020711c40 RSI: ffffffff815c5205 RDI: fffff520002cdf85
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815bdf9e R11: 0000000000000000 R12: fffffbfff1fcc2ec
R13: ffff888020711c40 R14: 00000c30ffffea00 R15: ffff888012ca0000
FS:  00007f06b1f238c0(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9bd4c0041c CR3: 0000000017532000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 do_epoll_ctl+0x6c3/0x2d30 fs/eventpoll.c:2147
 __do_sys_epoll_ctl fs/eventpoll.c:2178 [inline]
 __se_sys_epoll_ctl fs/eventpoll.c:2169 [inline]
 __x64_sys_epoll_ctl+0x13f/0x1c0 fs/eventpoll.c:2169
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f06b0da32aa
Code: 48 8b 0d f1 fb 2a 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 e9 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d be fb 2a 00 f7 d8 64 89 01 48
RSP: 002b:00007ffcbd811ce8 EFLAGS: 00000206
 ORIG_RAX: 00000000000000e9
RAX: ffffffffffffffda RBX: 00005645e4b0ad90 RCX: 00007f06b0da32aa
RDX: 0000000000000011 RSI: 0000000000000001 RDI: 0000000000000010
RBP: 00007ffcbd813800 R08: 00007f06b1f238c0 R09: 0000000000000000
R10: 00007ffcbd811d70 R11: 0000000000000206 R12: 00007ffcbd811d70
R13: 000000000aba9500 R14: 000000000000000b R15: 00007ffcbd813800


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
