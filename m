Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9436A370126
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 21:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhD3T3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:29:12 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:34568 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhD3T3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:29:11 -0400
Received: by mail-io1-f71.google.com with SMTP id v25-20020a0566020159b02904017f565b33so15505770iot.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 12:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+LssqhQ3CtTgVP4n/Oy9CzSRAJLRnEMaEJjdxwjSQYM=;
        b=OOCsBKuE4a7q2Xz8cX5yDmMmG6Nj8F3AjX30rCZq3EOsdV2Yj9TX4EbPhSyVaKgNE3
         Pu4WljyKc3EFEJO2IbWq0kF5DNhRsEKmHrCc1dY24MdNTI26bYw0eS8gYxIurB3cNJT7
         NUtg7vkg33aW+LRW8dedI4+mV4XHgg+zjMxdYmMkKDCQiMV6gTxyJyMsWN5BxSyTYujt
         SEezM9Q+WQfsCkA3iDi/3VjAfcWKdHS37RtlucX8RVyrcQ3aGjIj6JXj2UxNWSHWrpqO
         oDOPV0rwvNWf7oh9I1s4Mn2qdT0VnZfM+ZG8scnInau03p1aUHmMG6XuZo1IT7zwjV2e
         qrZA==
X-Gm-Message-State: AOAM5308S8OhMiDacii3DPpc9/eSNkt3F9ra0BlSXXG9/RnzLMo2OzI3
        I5C2YazaikhMwOhA63nfqJD5bSQrmPEGKTCVBqLBso0Fs91S
X-Google-Smtp-Source: ABdhPJwikPBAJV5j1rUiOGHc/IFGEc1AtTRRefR2SPwyUmiOyW90IvB+4A1Qm5UmxKoO/vnJ7eM9FDBv1yuDyUhwIlO+O/sPDOQq
MIME-Version: 1.0
X-Received: by 2002:a92:d3c1:: with SMTP id c1mr5352358ilh.21.1619810901833;
 Fri, 30 Apr 2021 12:28:21 -0700 (PDT)
Date:   Fri, 30 Apr 2021 12:28:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000683df205c1359d10@google.com>
Subject: [syzbot] UBSAN: array-index-out-of-bounds in udf_statfs
From:   syzbot <syzbot+7fbfe5fed73ebb675748@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e77a830c Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c63e6dd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0a6882014fd3d45
dashboard link: https://syzkaller.appspot.com/bug?extid=7fbfe5fed73ebb675748
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17612825d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132cb56dd00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7fbfe5fed73ebb675748@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 3974
UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2020/09/19 18:44 (1000)
================================================================================
UBSAN: array-index-out-of-bounds in fs/udf/super.c:2524:12
index 0 is out of range for type '__le32 [0]'
CPU: 1 PID: 8363 Comm: syz-executor557 Not tainted 5.12.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x202/0x31e lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:148 [inline]
 __ubsan_handle_out_of_bounds+0xdb/0x130 lib/ubsan.c:288
 udf_count_free fs/udf/super.c:2524 [inline]
 udf_statfs+0x49f/0xd70 fs/udf/super.c:2408
 statfs_by_dentry fs/statfs.c:66 [inline]
 vfs_statfs+0x136/0x310 fs/statfs.c:90
 user_statfs fs/statfs.c:105 [inline]
 __do_sys_statfs fs/statfs.c:195 [inline]
 __se_sys_statfs+0xe5/0x210 fs/statfs.c:192
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x444579
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc428d7b58 EFLAGS: 00000246 ORIG_RAX: 0000000000000089
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 0000000000444579
RDX: 0000000000402b43 RSI: 0000000000000000 RDI: 00000000200001c0
RBP: 0000000000403e10 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffc428d7a20 R11: 0000000000000246 R12: 0000000000403ea0
R13: 0000000000000000 R14: 00000000004b2018 R15: 00000000004004a0
================================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 8363 Comm: syz-executor557 Not tainted 5.12.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x202/0x31e lib/dump_stack.c:120
 panic+0x2e1/0x850 kernel/panic.c:231
 ubsan_epilogue lib/ubsan.c:162 [inline]
 __ubsan_handle_out_of_bounds+0x12b/0x130 lib/ubsan.c:288
 udf_count_free fs/udf/super.c:2524 [inline]
 udf_statfs+0x49f/0xd70 fs/udf/super.c:2408
 statfs_by_dentry fs/statfs.c:66 [inline]
 vfs_statfs+0x136/0x310 fs/statfs.c:90
 user_statfs fs/statfs.c:105 [inline]
 __do_sys_statfs fs/statfs.c:195 [inline]
 __se_sys_statfs+0xe5/0x210 fs/statfs.c:192
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x444579
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc428d7b58 EFLAGS: 00000246 ORIG_RAX: 0000000000000089
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 0000000000444579
RDX: 0000000000402b43 RSI: 0000000000000000 RDI: 00000000200001c0
RBP: 0000000000403e10 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffc428d7a20 R11: 0000000000000246 R12: 0000000000403ea0
R13: 0000000000000000 R14: 00000000004b2018 R15: 00000000004004a0
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
