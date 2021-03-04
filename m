Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB00332CE4E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 09:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbhCDIVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 03:21:19 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:36094 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhCDIVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 03:21:02 -0500
Received: by mail-il1-f199.google.com with SMTP id s13so19886862ilp.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 00:20:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/kQ8LB1u3Wuf8KE19cFcLpe+iyreLR8SuYEl8EMB9QU=;
        b=nnxeON4XQas/gLWOZvuPHJ9fXsNxyMQk+HVVbLzqL3tiyY3qOjf57USqu35dayRsOd
         kDGNfJlWPxlRCU19UKxJKaxdhNOH30DzSDBiZnhvFiYF4nYfxsIQg280ETR81lMF3YW+
         RPY9xwZIeB08lpAdEQ2k6/64NoGQYMc2O3/+esyLv66I0g7fxxFPKjZ3cz1AyKqa31sI
         tjIarXle++Zkomf1BPsEm9H0sEOl4IK+zTVslkNopvVLp9VWimqc5FoKrwfetCnx3S7r
         +wOxrEfbyCbuSS0KvZPbZvhoDJsJusSKrElN3H4gRXOraAwwkhQxCcf5srw2VRRbtbgM
         4Vmw==
X-Gm-Message-State: AOAM531GaMbrkNatMsifkuYrszucsdKWryRSoSD2+1bgclQgb4Ef2GXZ
        ytCnLKvhLqveolzvjJTzd6fMBMPhfap8dR517JCjmWxhu9uY
X-Google-Smtp-Source: ABdhPJxaSqKef37VbLKd+0hOjeBhQ+hnlgKUZ+7qnXPmORBbCQdWwO0gd00GYYb6lIuXmKis2nlyjYPd6cTngZjuWRyhU3QyxGxO
MIME-Version: 1.0
X-Received: by 2002:a02:9042:: with SMTP id y2mr3044690jaf.94.1614846021521;
 Thu, 04 Mar 2021 00:20:21 -0800 (PST)
Date:   Thu, 04 Mar 2021 00:20:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ad39e05bcb1a38d@google.com>
Subject: WARNING in firmware_fallback_sysfs
From:   syzbot <syzbot+95f2e2439b97575ec3c0@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5695e516 Merge tag 'io_uring-worker.v3-2021-02-25' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f34e46d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=90173e86f0624adc
dashboard link: https://syzkaller.appspot.com/bug?extid=95f2e2439b97575ec3c0
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+95f2e2439b97575ec3c0@syzkaller.appspotmail.com

------------[ cut here ]------------
sysfs group 'power' not found for kobject 'ueagle-atm!eagleI.fw'
WARNING: CPU: 1 PID: 32 at fs/sysfs/group.c:279 sysfs_remove_group+0x94/0xa0 fs/sysfs/group.c:279
Modules linked in:
CPU: 1 PID: 32 Comm: kworker/1:1 Not tainted 5.11.0-syzkaller-11646-g5695e5161974 #0
Hardware name: linux,dummy-virt (DT)
Workqueue: events request_firmware_work_func
pstate: 60400009 (nZCv daif +PAN -UAO -TCO BTYPE=--)
pc : sysfs_remove_group+0x94/0xa0 fs/sysfs/group.c:279
lr : sysfs_remove_group+0x94/0xa0 fs/sysfs/group.c:279
sp : ffff800013e83bb0
x29: ffff800013e83bb0 x28: ffff800013a9de40 
x27: f5ff00000dff3688 x26: f5ff00000dff3620 
x25: f9ff00000b7e40a0 x24: faff00000a690b00 
x23: f9ff00000b7e40a0 x22: 0000000000000000 
x21: fdff00000de85808 x20: ffff8000124a9818 
x19: 0000000000000000 x18: 00000000fffffffd 
x17: 0000000000000000 x16: 0000000000000000 
x15: 0000000000000020 x14: ffffffffffffffff 
x13: 0000000000000e0b x12: ffff800013e83860 
x11: ffff800013a0b548 x10: 00000000ffffe000 
x9 : ffff800013a0b548 x8 : ffff80001395b548 
x7 : ffff800013a0b548 x6 : 0000000000000000 
x5 : ffff00007fbd7948 x4 : 0000000000015ff5 
x3 : 0000000000000001 x2 : 0000000000000000 
x1 : 0000000000000000 x0 : f5ff00000412eac0 
Call trace:
 sysfs_remove_group+0x94/0xa0 fs/sysfs/group.c:279
 dpm_sysfs_remove+0x60/0x70 drivers/base/power/sysfs.c:837
 device_del+0xa4/0x384 drivers/base/core.c:3398
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:543 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:581 [inline]
 firmware_fallback_sysfs+0x35c/0x460 drivers/base/firmware_loader/fallback.c:657
 _request_firmware+0x4c8/0x6d0 drivers/base/firmware_loader/main.c:831
 request_firmware_work_func+0x40/0xa0 drivers/base/firmware_loader/main.c:1077
 process_one_work+0x1d8/0x364 kernel/workqueue.c:2275
 worker_thread+0x70/0x434 kernel/workqueue.c:2421
 kthread+0x174/0x180 kernel/kthread.c:292
 ret_from_fork+0x10/0x34 arch/arm64/kernel/entry.S:958


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
