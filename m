Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB363487CE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 05:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCYEEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 00:04:24 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:42340 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhCYEEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 00:04:20 -0400
Received: by mail-il1-f200.google.com with SMTP id r16so3210887ilj.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 21:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xDVm0DCZ39tefCBbEfz3aIQLf6gyKyfmwt10EcVY2o4=;
        b=LZZlLWL56INi1iKzY11h9YEtjy9wdAWMobRWzIierVcwN5R0dmKsvolTocaFINCjc0
         oOZQzn2D/CB8Z2E8OmDngT3jawt+MUKf5t+BfS1kIZgH3kXXegiaBRc7uEIVIKjrV5NX
         iQSh8ggF7tyAKWGlINeDyJ+lYo+RSezCxS5K9eGz32/NRPwnXogZKoYmZVNoHiYfovAQ
         BQjau4fO6a3VUV7qk+l79jW80BSQJYrfXiKpOo0XWgFYv98hmSmb7j2Q/y+av50pfn0V
         ryWN8Mk5HsHMUFGIqQkGOKN6ckFqHDqsINN++TJKeYKn0pAh7APXl1UMOlov+89f9Opt
         HF/Q==
X-Gm-Message-State: AOAM532gApehI8iafQiEWoK1JaF6TQZNOoHwtIuV+k03vfINrvPubfHl
        xEsNOfXKoS5urh1cP966KBJU3Vo8CrZKAu5ClN4u7os+YwN+
X-Google-Smtp-Source: ABdhPJwugtwquSN11xfhl/SfTYVe8K6sz2fLCxbmViHKQrJo2qetljbZ3CA0wSVzyyfekcENOz9cUbXU58re02nABViFLRw65gSW
MIME-Version: 1.0
X-Received: by 2002:a92:6511:: with SMTP id z17mr5099414ilb.232.1616645059783;
 Wed, 24 Mar 2021 21:04:19 -0700 (PDT)
Date:   Wed, 24 Mar 2021 21:04:19 -0700
In-Reply-To: <0000000000007ad39e05bcb1a38d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084315305be5482b9@google.com>
Subject: Re: [syzbot] WARNING in firmware_fallback_sysfs
From:   syzbot <syzbot+95f2e2439b97575ec3c0@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    20f1b5f9 Add linux-next specific files for 20210324
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1506414ed00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31aa577aa2dca78c
dashboard link: https://syzkaller.appspot.com/bug?extid=95f2e2439b97575ec3c0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e50426d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1388dfe6d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+95f2e2439b97575ec3c0@syzkaller.appspotmail.com

sysfs group 'power' not found for kobject 'ueagle-atm!eagleI.fw'
WARNING: CPU: 1 PID: 36 at fs/sysfs/group.c:279 sysfs_remove_group+0x126/0x170 fs/sysfs/group.c:279
Modules linked in:
CPU: 1 PID: 36 Comm: kworker/1:1 Not tainted 5.12.0-rc4-next-20210324-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events request_firmware_work_func
RIP: 0010:sysfs_remove_group+0x126/0x170 fs/sysfs/group.c:279
Code: 48 89 d9 49 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c 01 00 75 37 48 8b 33 48 c7 c7 e0 7d 7c 89 e8 9d cc d9 06 <0f> 0b eb 98 e8 f1 23 c9 ff e9 01 ff ff ff 48 89 df e8 e4 23 c9 ff
RSP: 0018:ffffc90000e6faa0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffff89da8900 RCX: 0000000000000000
RDX: ffff888011e01c80 RSI: ffffffff815c3fd5 RDI: fffff520001cdf46
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815bd77e R11: 0000000000000000 R12: ffff8880276ac008
R13: ffffffff89da8ea0 R14: ffff8880133e6878 R15: ffff8880133e68c0
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2c3971a0c8 CR3: 000000001cf2a000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 dpm_sysfs_remove+0x97/0xb0 drivers/base/power/sysfs.c:837
 device_del+0x20c/0xd40 drivers/base/core.c:3398
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:543 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:581 [inline]
 firmware_fallback_sysfs+0x9ff/0xe20 drivers/base/firmware_loader/fallback.c:657
 _request_firmware+0xa80/0xe80 drivers/base/firmware_loader/main.c:833
 request_firmware_work_func+0xdd/0x230 drivers/base/firmware_loader/main.c:1079
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

