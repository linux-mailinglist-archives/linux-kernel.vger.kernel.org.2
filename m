Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC7230A505
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhBAKI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:08:56 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:33507 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbhBAKID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:08:03 -0500
Received: by mail-il1-f197.google.com with SMTP id k5so13211477ilu.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 02:07:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/H/RD7jUVyOe/gcX9FCPW5lRC9NT5HhCLmyAqY3uH9A=;
        b=Lz07blmCGP3QEwvOWb1F1A536NQkA1SS+VoRq0OV/iJB8xGih0QfGpAb4u6UdwFcQk
         tnAwk2RJz6wqKXyvVJ+FhzC6vvqEOfIYp9H67QXCpMU90aZb3+iuut0iDrABf63uGATn
         aFyDimY6RFonMjjhLpOLTCHQoddfOLR+dOIf5d80eDWu2Q9ep4SM6aZ9T5di/5mZbeOJ
         7JhRTri6fZVpAFnA7RerzfnFrJG/VGZwquDu3S9U/x4Gta9LU/Foe/0dF17BbXuorYG2
         YIGxwaPtRBEbhf8U6DMqRfJLYN+CJ6jGk6GqIra1DVNzfzEaCCdujaQEv/m3CEuhJMjF
         9ggw==
X-Gm-Message-State: AOAM533sTMXOwwXrdS3pYpMYpHhKvKFNvsedU0yvbCXVf06yaixSHbuX
        nU8QDCbxz+2XIiYIjRYLJSDeijqjZYXU43xmDCvpND0tubPd
X-Google-Smtp-Source: ABdhPJzTdRPIrsxinaUfZn1G48fd4vPIHCIyyWNd9d7duIsVwJe87cFbzvq3Zrsl61Ztc2BhWG2jAxjI8Pi2dMWVz0A7oWWXNg1X
MIME-Version: 1.0
X-Received: by 2002:a05:6638:248:: with SMTP id w8mr14817077jaq.51.1612174042142;
 Mon, 01 Feb 2021 02:07:22 -0800 (PST)
Date:   Mon, 01 Feb 2021 02:07:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000019201505ba43855e@google.com>
Subject: BUG: Bad page state (8)
From:   syzbot <syzbot+97ef6376738cb5104a71@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d03154e8 Add linux-next specific files for 20210128
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16156808d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6953ffb584722a1
dashboard link: https://syzkaller.appspot.com/bug?extid=97ef6376738cb5104a71
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+97ef6376738cb5104a71@syzkaller.appspotmail.com

BUG: Bad page state in process syz-executor.4  pfn:369c1
page:0000000025f15602 refcount:0 mapcount:0 mapping:0000000000000000 index:0x3d pfn:0x369c1
flags: 0xfff00000020005(locked|uptodate|mappedtodisk)
raw: 00fff00000020005 dead000000000100 dead000000000122 0000000000000000
raw: 000000000000003d 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
Modules linked in:
CPU: 1 PID: 24274 Comm: syz-executor.4 Not tainted 5.11.0-rc5-next-20210128-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 bad_page.cold+0x9c/0xbd mm/page_alloc.c:643
 check_free_page_bad mm/page_alloc.c:1139 [inline]
 check_free_page mm/page_alloc.c:1149 [inline]
 free_pages_prepare mm/page_alloc.c:1265 [inline]
 free_pcp_prepare+0x300/0x400 mm/page_alloc.c:1306
 free_unref_page_prepare mm/page_alloc.c:3201 [inline]
 free_unref_page+0x12/0x1b0 mm/page_alloc.c:3249
 __put_single_page mm/swap.c:97 [inline]
 __put_page+0xe1/0x3e0 mm/swap.c:128
 put_page include/linux/mm.h:1216 [inline]
 filemap_update_page mm/filemap.c:2326 [inline]
 filemap_get_pages+0x1312/0x1920 mm/filemap.c:2415
 filemap_read+0x2c5/0xe40 mm/filemap.c:2475
 generic_file_read_iter+0x397/0x4f0 mm/filemap.c:2626
 ext4_file_read_iter+0x1d4/0x5d0 fs/ext4/file.c:130
 call_read_iter include/linux/fs.h:1971 [inline]
 generic_file_splice_read+0x450/0x6c0 fs/splice.c:311
 do_splice_to+0x1bf/0x250 fs/splice.c:796
 splice_direct_to_actor+0x2c2/0x8c0 fs/splice.c:870
 do_splice_direct+0x1b3/0x280 fs/splice.c:979
 do_sendfile+0x9f0/0x1110 fs/read_write.c:1261
 __do_sys_sendfile64 fs/read_write.c:1326 [inline]
 __se_sys_sendfile64 fs/read_write.c:1312 [inline]
 __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1312
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45e219
Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe714568c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 000000000045e219
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 000000000119bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 00008400fffffff6 R11: 0000000000000246 R12: 000000000119bf8c
R13: 00007ffd78dca10f R14: 00007fe7145699c0 R15: 000000000119bf8c


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
