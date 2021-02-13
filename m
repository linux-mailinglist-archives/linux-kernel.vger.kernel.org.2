Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC8131AD49
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 17:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhBMQ64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 11:58:56 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:49974 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhBMQ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 11:58:54 -0500
Received: by mail-il1-f197.google.com with SMTP id q3so2235032ilv.16
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 08:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZMalga4noUH0P3IatCDiyBwxELchBGjLLlOr8eoLRUU=;
        b=U3iDScKRfPOia3A3uEkDr8r8CnruZPpa0MN3LlNi4oCQ8PY3sq1jHoko2BufZEKuBc
         qQotYEsOxNOPTAMsg5rkQTc4Ysuw7f+OC7f2lYS74RZCMVkCv9yqV/HgMl1R1H+NmviS
         Tz9i8+FHya1M8H/h97Ff4hNwLkNw1F4nM3nSsufWtxA4G9ZsWlr0NThpQ7xebswlCp1F
         jp6BqccYYiZg7lFvMPD+l+mp4E9W5h5KbKp1jvRkb/kvoXsz3VU7DqrF2tY1L0aJXRD1
         ySIqJ2c46B3ppd4QMILNq45wF8OgS1Nh/4YSjj2QdsrkVgTAdvxn6rH9vr8UbrG3SCFs
         iYiA==
X-Gm-Message-State: AOAM533TmeEwgYmv6mJuItss48BVrMsnLpj7x4+avM8YQVrFv8BBu14G
        mYYZijzXW6K+bfcGtSbpBTjoAn0gDI9Gz9BxzO2Pn8VudW1n
X-Google-Smtp-Source: ABdhPJwnNnaM/Foz0c3qACuLeuucWoLuoH6+1QEfF9J2UIPZfPhLHwmkIzoNHJOHuQUEnPAN+oUwfNPgYgiphAl3Gceoxl2K+OoS
MIME-Version: 1.0
X-Received: by 2002:a05:6638:42:: with SMTP id a2mr7677936jap.99.1613235493277;
 Sat, 13 Feb 2021 08:58:13 -0800 (PST)
Date:   Sat, 13 Feb 2021 08:58:13 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084130f05bb3aa802@google.com>
Subject: WARNING in pstore_kill_sb
From:   syzbot <syzbot+d0cf0ad6513e9a1da5df@syzkaller.appspotmail.com>
To:     anton@enomsg.org, ccross@android.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e0756cfc Merge tag 'trace-v5.11-rc7' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10692850d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9a66c874a03a1ed
dashboard link: https://syzkaller.appspot.com/bug?extid=d0cf0ad6513e9a1da5df
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d0cf0ad6513e9a1da5df@syzkaller.appspotmail.com

 do_el0_svc_compat+0x40/0x80 arch/arm64/kernel/syscall.c:204
 el0_svc_compat+0x20/0x30 arch/arm64/kernel/entry-common.c:442
 el0_sync_compat_handler+0x90/0x140 arch/arm64/kernel/entry-common.c:451
 el0_sync_compat+0x178/0x180 arch/arm64/kernel/entry.S:708
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5780 at fs/pstore/inode.c:470 pstore_kill_sb+0x88/0x90 fs/pstore/inode.c:480
Modules linked in:
CPU: 0 PID: 5780 Comm: syz-executor.1 Not tainted 5.11.0-rc7-syzkaller-00002-ge0756cfc7d7c #0
Hardware name: linux,dummy-virt (DT)
pstate: 00000005 (nzcv daif -PAN -UAO -TCO BTYPE=--)
pc : pstore_kill_sb+0x88/0x90 fs/pstore/inode.c:470
lr : pstore_kill_sb+0x30/0x90 fs/pstore/inode.c:469
sp : ffff00001d1e7a70
x29: ffff00001d1e7a70 x28: 0000000000000004 
x27: 0000000000008000 x26: ffff000016070a00 
x25: 0000000000000000 x24: ffff00000df2e068 
x23: 1fffe00001be5c0d x22: ffff800011edf070 
x21: ffff80001bbea000 x20: ffff00000df2e000 
x19: ffff800019a97a20 x18: 0000000000000000 
x17: 0000000000000000 x16: 0000000000000002 
x15: ffff800019c06380 x14: 1fffe00003a3cee8 
x13: 0000000000000000 x12: ffff700003352f45 
x11: 1ffff00003352f44 x10: ffff700003352f44 
x9 : dfff800000000000 x8 : ffff800019a97a27 
x7 : 0000000000000001 x6 : 00008ffffccad0bc 
x5 : ffff800019a97a20 x4 : 1fffe00001de59a9 
x3 : 0000000000000000 x2 : 0000000000000000 
x1 : ffff00000ef2cd40 x0 : 0000000000000000 
Call trace:
 pstore_kill_sb+0x88/0x90 fs/pstore/inode.c:480
 deactivate_locked_super+0x94/0x154 fs/super.c:335
 mount_single+0x114/0x180 fs/super.c:1470
 pstore_mount+0x1c/0x30 fs/pstore/inode.c:464
 legacy_get_tree+0xd0/0x190 fs/fs_context.c:592
 vfs_get_tree+0x74/0x2a0 fs/super.c:1496
 do_new_mount fs/namespace.c:2881 [inline]
 path_mount+0xf64/0x2170 fs/namespace.c:3211
 do_mount fs/namespace.c:3224 [inline]
 __do_sys_mount fs/namespace.c:3432 [inline]
 __se_sys_mount fs/namespace.c:3409 [inline]
 __arm64_sys_mount+0x2ec/0x520 fs/namespace.c:3409
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:49 [inline]
 el0_svc_common.constprop.0+0x110/0x3c0 arch/arm64/kernel/syscall.c:159
 do_el0_svc_compat+0x40/0x80 arch/arm64/kernel/syscall.c:204
 el0_svc_compat+0x20/0x30 arch/arm64/kernel/entry-common.c:442
 el0_sync_compat_handler+0x90/0x140 arch/arm64/kernel/entry-common.c:451
 el0_sync_compat+0x178/0x180 arch/arm64/kernel/entry.S:708


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
