Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9467B3AA845
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 02:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbhFQAuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 20:50:32 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:35831 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhFQAub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 20:50:31 -0400
Received: by mail-io1-f70.google.com with SMTP id y14-20020a6bc80e0000b02904dc72726661so523452iof.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 17:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bQLVYc/0egDMgAo7Qbl2g2RvIzD2ELXlMK3a6DuGMw4=;
        b=KIUS/KdXE3CBP9HevYXbsrjrOZuAm+WE6BwaESb0clapWf8CW4hIOAy4mzp1ZBGXPQ
         qCsxmWyEMWurcZKQx6pytkGysIUoYuqpl59Vc/HoZw38pdjS+ymlh5M4jMxp0gzNG5TU
         IhyC7/Wc4MhjSLzGq5oMmUSfj2JuhHx9qFsPMWRUy0FWI6Wt4LoxzQbQWaZgpmalH6bX
         E6W64ExgHie0jwiGvpH+tRcp/Lge7PFwoGZtJrcsZE7B/t9ybFnff/OipEClmoBRueXF
         G8Eg6LMk6eJJ2BTK+Y9iIBjqLNJY+BiO7MqSgkW948qPW7vKJtKxB0nTkKKSi34ylZic
         BgHQ==
X-Gm-Message-State: AOAM532v+vAgU3DKTvN1y6tBMNy0sevphI9nH44VBxn7wLzx3g6lV+RD
        BJAA+GjdAVz8JFe8Z9JNOGeq0Zo8t0N1mxsRziT9E93uS510
X-Google-Smtp-Source: ABdhPJyCUDvKIU4XyvKWBO/BWFacrvdOQKI9efl3MV++sWxyfgHOXZ9iwR4M60rDDzz+qbP5+n7QGKlnnT8pOau/H0M6tt0lkKmf
MIME-Version: 1.0
X-Received: by 2002:a6b:5b06:: with SMTP id v6mr1624334ioh.84.1623890903365;
 Wed, 16 Jun 2021 17:48:23 -0700 (PDT)
Date:   Wed, 16 Jun 2021 17:48:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072faae05c4eb9024@google.com>
Subject: [syzbot] WARNING in __page_cache_alloc
From:   syzbot <syzbot+710d700d430546fc3dd5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ad347abe Merge tag 'trace-v5.13-rc5-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ae5b4fd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=30f476588412c065
dashboard link: https://syzkaller.appspot.com/bug?extid=710d700d430546fc3dd5

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+710d700d430546fc3dd5@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 26 at mm/page_alloc.c:4159 __alloc_pages_slowpath.constprop.0+0x1dae/0x2140 mm/page_alloc.c:4961
Modules linked in:
CPU: 1 PID: 26 Comm: kworker/u4:1 Not tainted 5.13.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: writeback wb_workfn (flush-8:0)
RIP: 0010:__alloc_pages_may_oom mm/page_alloc.c:4159 [inline]
RIP: 0010:__alloc_pages_slowpath.constprop.0+0x1dae/0x2140 mm/page_alloc.c:4899
Code: 48 89 54 24 18 e8 d2 09 09 00 8b 74 24 20 48 8b 54 24 18 e9 ff f0 ff ff 48 8b bc 24 80 00 00 00 e8 c7 09 09 00 e9 e2 fe ff ff <0f> 0b 8b 74 24 0c 4c 89 f1 ba 44 00 00 00 8b 7c 24 30 e8 9b ad ff
RSP: 0018:ffffc90000e0f0d8 EFLAGS: 00010206
RAX: 0000000000008000 RBX: ffff888015feb880 RCX: 1ffff920001c1e08
RDX: ffff888015feb880 RSI: ffffffff819ac5dd RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff819ac2d7 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffc90000e0f328 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000031246d0 CR3: 000000002e797000 CR4: 0000000000350ee0
Call Trace:
 __alloc_pages+0x422/0x500 mm/page_alloc.c:5213
 alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2272
 __page_cache_alloc mm/filemap.c:1005 [inline]
 __page_cache_alloc+0x303/0x3a0 mm/filemap.c:990
 pagecache_get_page+0x38f/0x18d0 mm/filemap.c:1885
 find_or_create_page include/linux/pagemap.h:420 [inline]
 grow_dev_page fs/buffer.c:974 [inline]
 grow_buffers fs/buffer.c:1039 [inline]
 __getblk_slow+0x213/0xb60 fs/buffer.c:1066
 __getblk_gfp+0x70/0x80 fs/buffer.c:1359
 sb_getblk include/linux/buffer_head.h:327 [inline]
 __ext4_get_inode_loc+0x348/0x1130 fs/ext4/inode.c:4330
 __ext4_get_inode_loc_noinmem fs/ext4/inode.c:4440 [inline]
 ext4_write_inode+0x38b/0x630 fs/ext4/inode.c:5228
 write_inode fs/fs-writeback.c:1320 [inline]
 __writeback_single_inode+0xae9/0xfd0 fs/fs-writeback.c:1525
 writeback_sb_inodes+0x53d/0xef0 fs/fs-writeback.c:1732
 __writeback_inodes_wb+0xc6/0x280 fs/fs-writeback.c:1801
 wb_writeback+0x814/0xc40 fs/fs-writeback.c:1907
 wb_check_start_all fs/fs-writeback.c:2031 [inline]
 wb_do_writeback fs/fs-writeback.c:2057 [inline]
 wb_workfn+0xb98/0x12d0 fs/fs-writeback.c:2091
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2276
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2422
 kthread+0x3b1/0x4a0 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
