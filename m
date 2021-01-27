Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE4E306169
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 17:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbhA0Q7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 11:59:10 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:53896 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbhA0Q5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:57:03 -0500
Received: by mail-io1-f71.google.com with SMTP id s21so2044611ioe.20
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 08:56:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=BAFZkHZVCqTETJOe/W7Z1KtkSwQo6pDsmbUH1AUEjKw=;
        b=ah97KvDmpFT3CxSO1sXFmax8pCC0RbpnpmGNuiRFWrRuGa+FzuBu2tTe8kyIPXsnQa
         Szfaf3Ef9K6vR3L1oIygy9Vh7XtIC4BVp6jojc9ViTWlIQH9erK5xkWncjY96ylsHyQw
         rG8wpmlNjMlf/fCcsfDQqa5TOhxdRlIra+z11uZgBCs0IDBcgNEEstd/lSY5iUJzJUBi
         W3wr4xpX0PL5rWquLTD/dTGGBXirT7eWSdg52ZSUEhTaI7oo0LlJDd4KU64BVr4L9q7M
         oL5hpdnFQ2fCCsa8bHMakGrw7OdU+mKihs7YUstZVGPfyd0w19kHTk0LG131b3jThxpe
         3K2A==
X-Gm-Message-State: AOAM531wcm02HNzqHy+ruwLaLVQCgGyAalvJ6U6WNeEl5WZ1AjyQUjV1
        MGNRximDx7TCtcQ99bZMVXyx5QtbV6wJFZTMMAvOvgVzA5O1
X-Google-Smtp-Source: ABdhPJyEsafsti7/bFBg9EyG4UmcYQFwCrINFeZsq0H+Hg9xgTbZW8CBtyFnAqx2mOP8rchP8iz8LNWA6FDkCxA1QDl6Z0IGNsZ4
MIME-Version: 1.0
X-Received: by 2002:a92:d244:: with SMTP id v4mr9272701ilg.191.1611766582457;
 Wed, 27 Jan 2021 08:56:22 -0800 (PST)
Date:   Wed, 27 Jan 2021 08:56:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009bbb7905b9e4a624@google.com>
Subject: WARNING in __do_kernel_fault
From:   syzbot <syzbot+45b6fce29ff97069e2c5@syzkaller.appspotmail.com>
To:     Dave.Martin@arm.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, syzkaller-bugs@googlegroups.com,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2ab38c17 mailmap: remove the "repo-abbrev" comment
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a25264d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ad43be24faf1194c
dashboard link: https://syzkaller.appspot.com/bug?extid=45b6fce29ff97069e2c5
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+45b6fce29ff97069e2c5@syzkaller.appspotmail.com

REISERFS (device loop0): Using rupasov hash to sort names
------------[ cut here ]------------
Ignoring spurious kernel translation fault at virtual address 0000000000000030
WARNING: CPU: 1 PID: 5380 at arch/arm64/mm/fault.c:364 __do_kernel_fault+0x198/0x1c0 arch/arm64/mm/fault.c:364
Modules linked in:
CPU: 1 PID: 5380 Comm: syz-executor.0 Not tainted 5.11.0-rc5-syzkaller-00037-g2ab38c17aac1 #0
Hardware name: linux,dummy-virt (DT)
pstate: 60400009 (nZCv daif +PAN -UAO -TCO BTYPE=--)
pc : __do_kernel_fault+0x198/0x1c0 arch/arm64/mm/fault.c:364
lr : __do_kernel_fault+0x198/0x1c0 arch/arm64/mm/fault.c:364
sp : ffff800014933830
x29: ffff800014933830 x28: f1ff00000c28bc00 
x27: ffff80001231db80 x26: f0ff00002054a0b8 
x25: 0000000000000000 x24: f1ff000004217680 
x23: 0000000097c78006 x22: 0000000000000030 
x21: 0000000000000025 x20: ffff800014933960 
x19: 0000000097c78006 x18: 00000000fffffffb 
x17: 0000000000000000 x16: 0000000000000000 
x15: 0000000000000020 x14: 6c656e72656b2073 
x13: 00000000000006f9 x12: ffff8000149334e0 
x11: ffff80001313b450 x10: 00000000ffffe000 
x9 : ffff80001313b450 x8 : ffff80001308b450 
x7 : ffff80001313b450 x6 : 0000000000000000 
x5 : ffff00007fbe1948 x4 : 0000000000015ff5 
x3 : 0000000000000001 x2 : 0000000000000000 
x1 : 0000000000000000 x0 : f1ff00000c28bc00 
Call trace:
 __do_kernel_fault+0x198/0x1c0 arch/arm64/mm/fault.c:364
 do_page_fault+0x1c0/0x3a0 arch/arm64/mm/fault.c:649
 do_translation_fault+0xb4/0xc4 arch/arm64/mm/fault.c:660
 do_mem_abort+0x44/0xbc arch/arm64/mm/fault.c:793
 el1_abort+0x40/0x6c arch/arm64/kernel/entry-common.c:118
 el1_sync_handler+0xb0/0xcc arch/arm64/kernel/entry-common.c:209
 el1_sync+0x70/0x100 arch/arm64/kernel/entry.S:656
 reiserfs_xattr_jcreate_nblocks fs/reiserfs/xattr.h:79 [inline]
 reiserfs_security_init+0x98/0x10c fs/reiserfs/xattr_security.c:70
 reiserfs_mkdir+0xf4/0x320 fs/reiserfs/namei.c:821
 xattr_mkdir.constprop.0+0x24/0x3c fs/reiserfs/xattr.c:76
 create_privroot fs/reiserfs/xattr.c:889 [inline]
 reiserfs_xattr_init+0x16c/0x320 fs/reiserfs/xattr.c:1011
 reiserfs_fill_super+0xa34/0xd20 fs/reiserfs/super.c:2177
 mount_bdev+0x1c4/0x1f0 fs/super.c:1366
 get_super_block+0x1c/0x30 fs/reiserfs/super.c:2606
 legacy_get_tree+0x34/0x64 fs/fs_context.c:592
 vfs_get_tree+0x2c/0xf0 fs/super.c:1496
 do_new_mount fs/namespace.c:2881 [inline]
 path_mount+0x3e8/0xaf0 fs/namespace.c:3211
 do_mount fs/namespace.c:3224 [inline]
 __do_sys_mount fs/namespace.c:3432 [inline]
 __se_sys_mount fs/namespace.c:3409 [inline]
 __arm64_sys_mount+0x1a8/0x2fc fs/namespace.c:3409
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:49 [inline]
 el0_svc_common.constprop.0+0x74/0x190 arch/arm64/kernel/syscall.c:159
 do_el0_svc+0x78/0x90 arch/arm64/kernel/syscall.c:198
 el0_svc+0x14/0x20 arch/arm64/kernel/entry-common.c:365
 el0_sync_handler+0x1a8/0x1b0 arch/arm64/kernel/entry-common.c:381
 el0_sync+0x190/0x1c0 arch/arm64/kernel/entry.S:699


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
