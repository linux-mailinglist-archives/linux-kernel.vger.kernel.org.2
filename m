Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC36433EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 20:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbhJSSpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 14:45:36 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:45741 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhJSSpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 14:45:35 -0400
Received: by mail-io1-f69.google.com with SMTP id k9-20020a5d91c9000000b005dc4a740599so13941626ior.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 11:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/TmOz32LqCZU2Gra3Lfki6YPIXGi50aEZYx+opSR52k=;
        b=4Gq1wFAH/4noJdA6nlZSWfAWOpRcA6LKCpG5CSD0wbCyh4xEF5yilCXdyPnFzgNDs7
         zBQn4orepTFR7RkBIXqq4SCwdNuS5yg57SqbPWoXvZyiFx5flJ+soBAa2iPHKYG/Ys3i
         +4h+RPlgs8fNq3/lp2w3h7Of9YP4cLWWDAOtFiXZFM7IBBD8pxEqXOdDI70Od82WU72Q
         6F0DztGWaamusszhwnI5nqNk/mxv1oALaBCGAygZhXVOOaOsifSZlvM1z/L1XMPpDPnd
         OuTBIaVA8FY8eZGlky3bedl3EpAsYhXGC/LFPg3wkrI8V2LM3h8tvbxtC+0FGHZ0WDbQ
         F6Xw==
X-Gm-Message-State: AOAM533XbTF1Exs+/fxRp+etggoHgrgWM9hFRSWPBgiRbC3jVNnXeoh3
        2ZjSKKGtf/jc54HWMX8aXJ2/myNRUmd91ZgMEFG8S+ZP57Qw
X-Google-Smtp-Source: ABdhPJz2IGVv63qi1hZQu0aDJntHVnSBLaVpb1jMu3ZMhjsNVStTYCkhV7XwVc/JQxI48ek4jAWSSGbMnv2tYYVy0+JYsq9dcEya
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cd0:: with SMTP id j16mr20379206iow.171.1634669001887;
 Tue, 19 Oct 2021 11:43:21 -0700 (PDT)
Date:   Tue, 19 Oct 2021 11:43:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ed23205ceb9097b@google.com>
Subject: [syzbot] WARNING in dpm_sysfs_add
From:   syzbot <syzbot+578bea23bb8e6bd8c33c@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ec681c53f8d2 Merge tag 'net-5.15-rc6' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=166855f4b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bab9d35f204746a7
dashboard link: https://syzkaller.appspot.com/bug?extid=578bea23bb8e6bd8c33c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+578bea23bb8e6bd8c33c@syzkaller.appspotmail.com

usb 7-1: Falling back to sysfs fallback for: ueagle-atm/eagleI.fw
------------[ cut here ]------------
sysfs group 'power' not found for kobject 'ueagle-atm!eagleI.fw'
WARNING: CPU: 0 PID: 5 at fs/sysfs/group.c:279 sysfs_remove_group+0x126/0x170 fs/sysfs/group.c:279
Modules linked in:
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.15.0-rc5-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: events request_firmware_work_func
RIP: 0010:sysfs_remove_group+0x126/0x170 fs/sysfs/group.c:279
Code: 48 89 d9 49 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c 01 00 75 37 48 8b 33 48 c7 c7 a0 4e 9d 89 e8 d6 db fd 06 <0f> 0b eb 98 e8 a1 77 c8 ff e9 01 ff ff ff 48 89 df e8 94 77 c8 ff
RSP: 0018:ffffc9000036fa80 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff89fcfc20 RCX: 0000000000000000
RDX: ffff8880115b0000 RSI: ffffffff815e88a8 RDI: fffff5200006df42
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815e264e R11: 0000000000000000 R12: ffff8880480f9008
R13: ffffffff89fd01c0 R14: 1ffff9200006df63 R15: ffff88804dde40a8
FS:  0000000000000000(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563e4a92aed0 CR3: 00000000221dc000 CR4: 0000000000150ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 dpm_sysfs_add+0x1f4/0x290 drivers/base/power/sysfs.c:734
 device_add+0xac4/0x1ee0 drivers/base/core.c:3352
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:507 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:583 [inline]
 firmware_fallback_sysfs+0x408/0xe70 drivers/base/firmware_loader/fallback.c:659
 _request_firmware+0xbb5/0x1040 drivers/base/firmware_loader/main.c:833
 request_firmware_work_func+0xdd/0x230 drivers/base/firmware_loader/main.c:1079
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
