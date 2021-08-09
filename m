Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1D43E4B12
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 19:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbhHIRn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 13:43:29 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:39609 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbhHIRn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 13:43:26 -0400
Received: by mail-io1-f72.google.com with SMTP id u22-20020a5d9f560000b02905058dc6c376so12896884iot.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 10:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=X+ee+/KARk/1VGXzgsbviy8LAY/RPWlv/RgXxo2+uTg=;
        b=EApc0ma1pSu7vVPING3h7qsy8vGXRNU/v8bbwIM8sYS5QMZFCUH7CIb7au4s7bF6cJ
         K1aC9KEaj7rSP7/aq8Dgoulk+mMe5Fde39GfWouWKkL23v1mkANYwCOK/Xi8vy4wCJnr
         n3MGLZ+Cvrr1udp4zV/J8BJdeOa2PXjCi2QU2izfgBBzexZCPNLaC4lX4HRy8k3T1Omy
         +QEIRSWu4ACXtMoKnokf5HbUuXRrqGF6UaBGWlfL+Hz6HijsN01PI/ys05tNxncY2IRQ
         sWB3eGjUiCiMAdjgo5X5eiBRDwYGM/vTrPVJekwbdoBAKt/atBRGrztRRLRkrRCje4Pz
         bxMA==
X-Gm-Message-State: AOAM530OxPVg3/uQ29avsd0sgbaUv7tXt30UI8kUGCOJ9Q31QH810X60
        ZR+wZ0cte59qbr8KcZd27P5vZEjdexxr6D3v7hFxi6H/oxP9
X-Google-Smtp-Source: ABdhPJyrL4hlwsUbVqWhzobNIZjfMqSD2KqTxfiqRMnQ/XuMHyUdFAI6Z+HsDoc/CVzLnx2iDaaquvhJ/wwFvp4OdE+6sGz9APee
MIME-Version: 1.0
X-Received: by 2002:a02:9082:: with SMTP id x2mr20088558jaf.44.1628530985492;
 Mon, 09 Aug 2021 10:43:05 -0700 (PDT)
Date:   Mon, 09 Aug 2021 10:43:05 -0700
In-Reply-To: <20210809145209.GD30319@quack2.suse.cz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e568d505c923ea91@google.com>
Subject: Re: [syzbot] possible deadlock in dquot_commit
From:   syzbot <syzbot+3b6f9218b1301ddda3e2@syzkaller.appspotmail.com>
To:     dvyukov@google.com, jack@suse.com, jack@suse.cz,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzkaller@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in dquot_commit

EXT4-fs warning (device loop4): ext4_enable_quotas:6478: Failed to enable quota tracking (type=1, err=-22). Please run e2fsck to fix.
EXT4-fs (loop4): mount failed
======================================================
WARNING: possible circular locking dependency detected
5.14.0-rc4-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.4/28771 is trying to acquire lock:
ffff88803941cea8 (&dquot->dq_lock){+.+.}-{3:3}, at: dquot_commit+0x57/0x360 fs/quota/dquot.c:474

but task is already holding lock:
ffff8880463d2a58 (&ei->i_data_sem/2){++++}-{3:3}, at: ext4_map_blocks+0x9e5/0x1cb0 fs/ext4/inode.c:631

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&ei->i_data_sem/2){++++}-{3:3}:
       lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
       down_read+0x3b/0x50 kernel/locking/rwsem.c:1353
       ext4_map_blocks+0x266/0x1cb0 fs/ext4/inode.c:561
       ext4_getblk+0x187/0x6c0 fs/ext4/inode.c:848
       ext4_bread+0x2a/0x170 fs/ext4/inode.c:900
       ext4_quota_write+0x2c7/0x5b0 fs/ext4/super.c:6602
       write_blk fs/quota/quota_tree.c:64 [inline]
       get_free_dqblk+0x33a/0x660 fs/quota/quota_tree.c:93
       do_insert_tree+0x24c/0x1d30 fs/quota/quota_tree.c:300
       do_insert_tree+0x659/0x1d30 fs/quota/quota_tree.c:331
       do_insert_tree+0x659/0x1d30 fs/quota/quota_tree.c:331
       do_insert_tree+0x659/0x1d30 fs/quota/quota_tree.c:331
       dq_insert_tree fs/quota/quota_tree.c:357 [inline]
       qtree_write_dquot+0x3b6/0x530 fs/quota/quota_tree.c:376
       v2_write_dquot+0x110/0x1a0 fs/quota/quota_v2.c:358
       dquot_acquire+0x2d7/0x5b0 fs/quota/dquot.c:441
       ext4_acquire_dquot+0x2e0/0x400 fs/ext4/super.c:6261
       dqget+0x999/0xdc0 fs/quota/dquot.c:899
       __dquot_initialize+0x291/0xd40 fs/quota/dquot.c:1477
       ext4_create+0xb0/0x550 fs/ext4/namei.c:2731
       lookup_open fs/namei.c:3228 [inline]
       open_last_lookups fs/namei.c:3298 [inline]
       path_openat+0x13b7/0x36b0 fs/namei.c:3504
       do_filp_open+0x253/0x4d0 fs/namei.c:3534
       do_sys_openat2+0x124/0x460 fs/open.c:1204
       do_sys_open fs/open.c:1220 [inline]
       __do_sys_creat fs/open.c:1294 [inline]
       __se_sys_creat fs/open.c:1288 [inline]
       __x64_sys_creat+0x11f/0x160 fs/open.c:1288
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (&s->s_dquot.dqio_sem){++++}-{3:3}:
       lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
       down_read+0x3b/0x50 kernel/locking/rwsem.c:1353
       v2_read_dquot+0x4a/0x100 fs/quota/quota_v2.c:332
       dquot_acquire+0x144/0x5b0 fs/quota/dquot.c:432
       ext4_acquire_dquot+0x2e0/0x400 fs/ext4/super.c:6261
       dqget+0x999/0xdc0 fs/quota/dquot.c:899
       __dquot_initialize+0x291/0xd40 fs/quota/dquot.c:1477
       ext4_create+0xb0/0x550 fs/ext4/namei.c:2731
       lookup_open fs/namei.c:3228 [inline]
       open_last_lookups fs/namei.c:3298 [inline]
       path_openat+0x13b7/0x36b0 fs/namei.c:3504
       do_filp_open+0x253/0x4d0 fs/namei.c:3534
       do_sys_openat2+0x124/0x460 fs/open.c:1204
       do_sys_open fs/open.c:1220 [inline]
       __do_sys_creat fs/open.c:1294 [inline]
       __se_sys_creat fs/open.c:1288 [inline]
       __x64_sys_creat+0x11f/0x160 fs/open.c:1288
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (&dquot->dq_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3051 [inline]
       check_prevs_add+0x4f9/0x5b30 kernel/locking/lockdep.c:3174
       __lo


Tested on:

commit:         902e7f37 Merge tag 'net-5.14-rc5' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=125d6b79300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=702bfdfbf389c324
dashboard link: https://syzkaller.appspot.com/bug?extid=3b6f9218b1301ddda3e2
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
patch:          https://syzkaller.appspot.com/x/patch.diff?x=173c0ee9300000

