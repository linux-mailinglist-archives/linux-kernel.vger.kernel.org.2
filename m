Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E415A3B8706
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 18:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhF3Q24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 12:28:56 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:33634 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhF3Q2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 12:28:55 -0400
Received: by mail-io1-f72.google.com with SMTP id i9-20020a0566021349b02904df6556dad4so2321574iov.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 09:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=rim975nXZVZywCYilCGa7/3xyFa5zoe093VUS5CetDo=;
        b=A64jWB3yICwElFDu7hhBISe1EQ1aIbsHL9Tq64Mm8EEQmNMesPSM44+3bkFj4zpicX
         Pr/eSdcEt+RExK/dIxzJirwvr+1eWcI/mB2DYNgutGQ4KfoeVJmkbCMie+R45rpw/h43
         qtZu/eTQDV+Vfi3MD9SAryjS+YI/QMTiZgIQze/rwADOxR0dQdCHB9v4PkqmWcHdyICJ
         estX6/KVglH3TCINn1hwtZNvxmKaW1e1yXWFF05j/einvv7/ooGf97dSyVWG3HFzgZ3m
         m+w9VQkvl7Oj0+ka6W65D5HUUqZY2Ow1orxljIoFnwUwdU54m1K0+HpIquCP5bXrrZJt
         xoKQ==
X-Gm-Message-State: AOAM5302JEHyb3rpcp161ChhylyzhwU0h4RkZ2vDKbf1WxOIwuNA9O1x
        EinM4n5ZqhhJnMQzb3d+Viv0hVaoRXVG/exv8fNhnxaaH6Xg
X-Google-Smtp-Source: ABdhPJyuAAYISWpFuIpXWMRo0V9lQ2ryWt1aE7aRNqU7lu+FrhiNN+1J1fCKXivnvaZvbZ3N5wbFt7ks76sxgkkNmQwbax2cWA3r
MIME-Version: 1.0
X-Received: by 2002:a92:ddc6:: with SMTP id d6mr25187753ilr.51.1625070386323;
 Wed, 30 Jun 2021 09:26:26 -0700 (PDT)
Date:   Wed, 30 Jun 2021 09:26:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ca9eb05c5fe2f21@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in init_sb
From:   syzbot <syzbot+a498b19f2d8b0d716088@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    62fb9874 Linux 5.13
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b490fbd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8e1ef25331bf17e
dashboard link: https://syzkaller.appspot.com/bug?extid=a498b19f2d8b0d716088

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a498b19f2d8b0d716088@syzkaller.appspotmail.com

gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
================================================================================
UBSAN: shift-out-of-bounds in fs/gfs2/ops_fstype.c:299:19
shift exponent 100663299 is too large for 64-bit type 'long unsigned int'
CPU: 1 PID: 30834 Comm: syz-executor.4 Not tainted 5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:327
 gfs2_read_sb fs/gfs2/ops_fstype.c:299 [inline]
 init_sb.cold+0x19/0x109 fs/gfs2/ops_fstype.c:489
 gfs2_fill_super+0x18a6/0x2680 fs/gfs2/ops_fstype.c:1171
 get_tree_bdev+0x440/0x760 fs/super.c:1293
 gfs2_get_tree+0x4a/0x270 fs/gfs2/ops_fstype.c:1273
 vfs_get_tree+0x89/0x2f0 fs/super.c:1498
 do_new_mount fs/namespace.c:2905 [inline]
 path_mount+0x132a/0x1fa0 fs/namespace.c:3235
 do_mount fs/namespace.c:3248 [inline]
 __do_sys_mount fs/namespace.c:3456 [inline]
 __se_sys_mount fs/namespace.c:3433 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3433
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x467afa
Code: 48 c7 c2 bc ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd3a69ebfa8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 0000000000467afa
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fd3a69ec000
RBP: 00007fd3a69ec040 R08: 00007fd3a69ec040 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007fd3a69ec000 R15: 0000000020047a20
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
