Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6695D35B5D4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 17:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbhDKPIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 11:08:32 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:52357 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbhDKPI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 11:08:29 -0400
Received: by mail-il1-f199.google.com with SMTP id s20so4204057ilj.19
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 08:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=5Zsgrp3Bc5buiFZb8tuoECeGzKB+1DAlz3H/VQphtA0=;
        b=sQjxvBzKjyq1sM+sHNSrda3Aeq9rbZEFy0zLh2S4IkiA2Z0hurYq8pgzux6NGInC1x
         iR2HvL7lo1Zu7mqK/0ZoUo0HxJCSXFBXCsd33QKLTtmpy4aSu8mc0JEZ4ZFSEJe46OK/
         F48Wu951xgBRsWS7qtQEev739XtgNSm8Uj43yxIliB21faj5M7N84xtgZ52Dc7yTRqWI
         0B6Xk5qvJFX/9DwC1HEJZ1TmG358iKqcUATRPbwpR6oy0AXbAk3mdPPmMV0HZVUOqon6
         Xp44dUtg5Ecxp8JqIoTR2mCOKJpu+ehZMJG06MjVBdd7DdLjt9ByvhWdkGEqTyaFZPCA
         vbrw==
X-Gm-Message-State: AOAM5319dN8RqkVCmngq+nuBMT7FPAASYDPDawKcJiwlRMNh0s3hen7o
        N2AjzF57cZLQ1KZoDI6yIO6Uy5FsVXARkuOxLO0XTeZvgVTh
X-Google-Smtp-Source: ABdhPJy+VQ2g3rRkDMcPgaqkuG4vS0eo+WnKJKRywph3SnBF+MjiYcz2/v/bm6CdsxsqVzLu0Jc7B5n10ZqiUeMjz9nR7v9uQtg6
MIME-Version: 1.0
X-Received: by 2002:a02:a50d:: with SMTP id e13mr23179528jam.109.1618153692740;
 Sun, 11 Apr 2021 08:08:12 -0700 (PDT)
Date:   Sun, 11 Apr 2021 08:08:12 -0700
In-Reply-To: <00000000000020424005bf118296@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c3f5405bfb3c458@google.com>
Subject: Re: [syzbot] WARNING in fw_load_sysfs_fallback
From:   syzbot <syzbot+b064fbd5fc8b2cfae49d@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    52e44129 Merge branch 'for-5.12-fixes' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f1d196d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f91155ccddaf919c
dashboard link: https://syzkaller.appspot.com/bug?extid=b064fbd5fc8b2cfae49d
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a536a6d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11339dd9d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b064fbd5fc8b2cfae49d@syzkaller.appspotmail.com

------------[ cut here ]------------
sysfs group 'power' not found for kobject 'ueagle-atm!adi930.fw'
WARNING: CPU: 0 PID: 5 at fs/sysfs/group.c:281 sysfs_remove_group+0x16e/0x280 fs/sysfs/group.c:279
Modules linked in:
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events request_firmware_work_func
RIP: 0010:sysfs_remove_group+0x16e/0x280 fs/sysfs/group.c:279
Code: 89 e0 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 e7 e8 37 92 cb ff 49 8b 14 24 48 c7 c7 40 1a c2 89 4c 89 f6 31 c0 e8 b2 87 56 ff <0f> 0b 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 40 a3 87 ff 49 8d 5e 20
RSP: 0018:ffffc90000ca7a90 EFLAGS: 00010246
RAX: f97192423f200500 RBX: ffff8880351a4038 RCX: ffff888011528000
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffffffff1459c30 R08: ffffffff8160b932 R09: ffffed1017385fe8
R10: ffffed1017385fe8 R11: 0000000000000000 R12: ffff8880351a4008
R13: dffffc0000000000 R14: ffffffff8a2ce140 R15: ffff888035bbc3a0
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcb4541b47 CR3: 000000001d137000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 device_del+0x26a/0xa90 drivers/base/core.c:3398
 fw_load_sysfs_fallback+0x53e/0x720 drivers/base/firmware_loader/fallback.c:543
 fw_load_from_user_helper+0x242/0x320 drivers/base/firmware_loader/fallback.c:581
 _request_firmware+0x2c5/0x4c0 drivers/base/firmware_loader/main.c:831
 request_firmware_work_func+0xb8/0x1e0 drivers/base/firmware_loader/main.c:1077
 process_one_work+0x789/0xfd0 kernel/workqueue.c:2275
 worker_thread+0xac1/0x1300 kernel/workqueue.c:2421
 kthread+0x39a/0x3c0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

