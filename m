Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F8F40FDF7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbhIQQev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:34:51 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:33442 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbhIQQeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:34:50 -0400
Received: by mail-io1-f69.google.com with SMTP id g2-20020a6b7602000000b005be59530196so20393068iom.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 09:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=U3Be+e1nEljiRDJy9JzHj+OzA2tVmF9w+AxnCUvsToY=;
        b=hmq9HQlVnzsLqTvrKy5YttnA3MLcQhLMOzJtI0LYJAScdFFNYltE+gkGwjd4ggOhZ8
         /3Y778AlB9NHtC1c2nhIErOVdjN8ynVi/vsk9wjXdNXcxLjVmtt/78UhTxlCzjL+L7aq
         SzV6WW0NYyGF1n0UK6c8dNawIrd2ZgFKGrrU7BkAq9iSJ67BUMu4GRI993CtcgR02MvO
         gsDqxiMGFbbXb4+S5M59o8XWm5rLASAjV38CnYr4iH5Fx6KC9JNxvI/eWp1SuHZaDRGh
         sCmNfOUdN4W6sxUnPgs9nxEuMaZckOz2kJbdPMddo1dDi52Z8jsG8WNSib8aEOeIxo09
         ketw==
X-Gm-Message-State: AOAM531kXy5h0M7SwPD8PeyW3gznfnmx5m6608N3mmU8as4QlAaV7NOy
        H4xSV1NhIl1nQH8mReWT/8F4JNBzYQo6Syww3F2nNBZn7V2C
X-Google-Smtp-Source: ABdhPJy0+hTmnI9lyt8TPo+Jx+Jj9gRPhXMgEdLmdXGdRxFM+i1TGkH2PJ4mkR+tJa2wK6dpexntpiHqdmQJxemLoupvcVOIEQ+8
MIME-Version: 1.0
X-Received: by 2002:a92:c8c3:: with SMTP id c3mr8361494ilq.165.1631896408280;
 Fri, 17 Sep 2021 09:33:28 -0700 (PDT)
Date:   Fri, 17 Sep 2021 09:33:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9d40e05cc337db1@google.com>
Subject: [syzbot] KASAN: use-after-free Read in copy_page_from_iter_atomic
From:   syzbot <syzbot+ffc4eceb22dfcf9fd6a0@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7d2a07b76933 Linux 5.14
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12fe8af5300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=113c5df900d8cf12
dashboard link: https://syzkaller.appspot.com/bug?extid=ffc4eceb22dfcf9fd6a0
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ffc4eceb22dfcf9fd6a0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in copy_page_from_iter_atomic+0x9c7/0x1520 lib/iov_iter.c:918
Read of size 4096 at addr ffff8880298b0000 by task kworker/u4:8/11701

CPU: 0 PID: 11701 Comm: kworker/u4:8 Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: loop5 loop_rootcg_workfn
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1ae/0x29f lib/dump_stack.c:105
 print_address_description+0x66/0x3b0 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report+0x163/0x210 mm/kasan/report.c:436
 check_region_inline mm/kasan/generic.c:135 [inline]
 kasan_check_range+0x2b5/0x2f0 mm/kasan/generic.c:189
 memcpy+0x25/0x60 mm/kasan/shadow.c:65
 copy_page_from_iter_atomic+0x9c7/0x1520 lib/iov_iter.c:918
 generic_perform_write+0x2dd/0x580 mm/filemap.c:3664
 __generic_file_write_iter+0x225/0x5a0 mm/filemap.c:3783
 generic_file_write_iter+0xa7/0x1b0 mm/filemap.c:3815
 do_iter_readv_writev+0x566/0x770 include/linux/fs.h:2108
 do_iter_write+0x16c/0x5f0 fs/read_write.c:866
 lo_write_bvec+0x267/0x6f0 drivers/block/loop.c:328
 lo_write_simple drivers/block/loop.c:350 [inline]
 do_req_filebacked drivers/block/loop.c:668 [inline]
 loop_handle_cmd drivers/block/loop.c:2204 [inline]
 loop_process_work+0x21c2/0x2cc0 drivers/block/loop.c:2244
 process_one_work+0x833/0x10c0 kernel/workqueue.c:2276
 worker_thread+0xac1/0x1320 kernel/workqueue.c:2422
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

The buggy address belongs to the page:
page:ffffea0000a62c00 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x298b0
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0000bb3348 ffffea0000d492c8 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Unmovable, gfp_mask 0xdc0(GFP_KERNEL|__GFP_ZERO), pid 20552, ts 462739681694, free_ts 462770335978
 prep_new_page mm/page_alloc.c:2436 [inline]
 get_page_from_freelist+0x779/0xa30 mm/page_alloc.c:4168
 __alloc_pages+0x26c/0x5f0 mm/page_alloc.c:5390
 lbmLogInit fs/jfs/jfs_logmgr.c:1824 [inline]
 lmLogInit+0x2fc/0x1e90 fs/jfs/jfs_logmgr.c:1278
 open_inline_log fs/jfs/jfs_logmgr.c:1183 [inline]
 lmLogOpen+0x505/0x1190 fs/jfs/jfs_logmgr.c:1077
 jfs_mount_rw+0xe7/0x710 fs/jfs/jfs_mount.c:260
 jfs_fill_super+0x64c/0xc20 fs/jfs/super.c:570
 mount_bdev+0x26c/0x3a0 fs/super.c:1368
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x86/0x270 fs/super.c:1498
 do_new_mount fs/namespace.c:2923 [inline]
 path_mount+0x1981/0x2c10 fs/namespace.c:3253
 do_mount fs/namespace.c:3266 [inline]
 __do_sys_mount fs/namespace.c:3474 [inline]
 __se_sys_mount+0x2f9/0x3b0 fs/namespace.c:3451
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1346 [inline]
 free_pcp_prepare+0xc29/0xd20 mm/page_alloc.c:1397
 free_unref_page_prepare mm/page_alloc.c:3332 [inline]
 free_unref_page+0x7e/0x550 mm/page_alloc.c:3411
 lbmLogShutdown fs/jfs/jfs_logmgr.c:1872 [inline]
 lmLogShutdown+0x4ad/0x920 fs/jfs/jfs_logmgr.c:1692
 lmLogClose+0x2c2/0x560 fs/jfs/jfs_logmgr.c:1468
 jfs_umount+0x297/0x370 fs/jfs/jfs_umount.c:116
 jfs_fill_super+0x8e5/0xc20 fs/jfs/super.c:605
 mount_bdev+0x26c/0x3a0 fs/super.c:1368
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x86/0x270 fs/super.c:1498
 do_new_mount fs/namespace.c:2923 [inline]
 path_mount+0x1981/0x2c10 fs/namespace.c:3253
 do_mount fs/namespace.c:3266 [inline]
 __do_sys_mount fs/namespace.c:3474 [inline]
 __se_sys_mount+0x2f9/0x3b0 fs/namespace.c:3451
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff8880298aff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880298aff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880298b0000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff8880298b0080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880298b0100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
