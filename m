Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFC330A40E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhBAJJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:09:32 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:45720 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbhBAJGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:06:54 -0500
Received: by mail-io1-f69.google.com with SMTP id x7so11268773ion.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 01:06:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=skrbchk+q3WcuOOCbpjGV6FtIqOdfq0s1ZV3HNRF+2U=;
        b=gf3B9gngiMKU9awHcZnrMTZ7i2h/oMqh+u+6ul6AipTl5uh45vxWX099xGdI6XTKmJ
         nN4eHE6HldtPGY42Qlr/VGms99RfvadFmem8grM7eey8+/Si2HJ4mKGDLI4s0Em/CI75
         xPXoXW6yacdWODju/bD0sTgmX03wbIjLrZ30Cx6QH4xPzH10RyzVuvH1XkBGvDLD4VVX
         aYO7Sz56EkUUcqd3QCv9oUpo3W5Klg3+/FM0pe2UnnDMk7T6zTvtyBGWLBcdDIo+Lmms
         EiIe+zRJM69g2TI9xm3wLxBfNKhZtSjy/1r3vKQ2hiXtqgxj+bVWnOn3+qzFGqHuLax0
         uxaw==
X-Gm-Message-State: AOAM533Un6kX7ewVxHslV03Wb7VN61W+0qxjvN47G9AM+gLv75j2TQY7
        MTCNtEP/oqaiLntsRPPdRxkXZ7LhgBoM1Y66WMawVwBJ5tkc
X-Google-Smtp-Source: ABdhPJwz3l2wbfwV/eXjenuMNbHAT+a8/EvweSIjTsMAy1Fcw1jCUbpmRuuRHxiszNqiDJmOSeXihKpm33TCBKGyIUDYaEoy+pU2
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e8:: with SMTP id q8mr11655666ilv.205.1612170373186;
 Mon, 01 Feb 2021 01:06:13 -0800 (PST)
Date:   Mon, 01 Feb 2021 01:06:13 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000694ba505ba42aa9b@google.com>
Subject: KMSAN: uninit-value in crc32_le_base (2)
From:   syzbot <syzbot+ce18ece82e1fede33bf7@syzkaller.appspotmail.com>
To:     glider@google.com, konishi.ryusuke@gmail.com,
        linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    73d62e81 kmsan: random: prevent boot-time reports in _mix_..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=120020acd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31d3b433c9628854
dashboard link: https://syzkaller.appspot.com/bug?extid=ce18ece82e1fede33bf7
compiler:       clang version 11.0.1
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ce18ece82e1fede33bf7@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in crc32_body lib/crc32.c:110 [inline]
BUG: KMSAN: uninit-value in crc32_le_generic lib/crc32.c:179 [inline]
BUG: KMSAN: uninit-value in crc32_le_base+0x558/0xe70 lib/crc32.c:197
CPU: 1 PID: 11631 Comm: segctord Not tainted 5.10.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xfb/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x5f/0xa0 mm/kmsan/kmsan_instr.c:197
 crc32_body lib/crc32.c:110 [inline]
 crc32_le_generic lib/crc32.c:179 [inline]
 crc32_le_base+0x558/0xe70 lib/crc32.c:197
 nilfs_segbuf_fill_in_segsum_crc fs/nilfs2/segbuf.c:182 [inline]
 nilfs_add_checksums_on_logs+0x388/0xde0 fs/nilfs2/segbuf.c:320
 nilfs_segctor_do_construct+0x7dd6/0xbf20 fs/nilfs2/segment.c:2072
 nilfs_segctor_construct+0x302/0x1040 fs/nilfs2/segment.c:2377
 nilfs_segctor_thread_construct+0xd6/0x840 fs/nilfs2/segment.c:2485
 nilfs_segctor_thread+0xf35/0x13c0 fs/nilfs2/segment.c:2568
 kthread+0x51c/0x560 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
 kmsan_memcpy_memmove_metadata+0x25e/0x2d0 mm/kmsan/kmsan.c:226
 kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:246
 __msan_memcpy+0x46/0x60 mm/kmsan/kmsan_instr.c:110
 nilfs_write_dat_node_binfo+0x17a/0x370 fs/nilfs2/segment.c:663
 nilfs_segctor_update_payload_blocknr fs/nilfs2/segment.c:1602 [inline]
 nilfs_segctor_assign fs/nilfs2/segment.c:1625 [inline]
 nilfs_segctor_do_construct+0x4b00/0xbf20 fs/nilfs2/segment.c:2052
 nilfs_segctor_construct+0x302/0x1040 fs/nilfs2/segment.c:2377
 nilfs_segctor_thread_construct+0xd6/0x840 fs/nilfs2/segment.c:2485
 nilfs_segctor_thread+0xf35/0x13c0 fs/nilfs2/segment.c:2568
 kthread+0x51c/0x560 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Local variable ----binfo.i.i@nilfs_segctor_do_construct created at:
 nilfs_segctor_update_payload_blocknr fs/nilfs2/segment.c:1558 [inline]
 nilfs_segctor_assign fs/nilfs2/segment.c:1625 [inline]
 nilfs_segctor_do_construct+0x3deb/0xbf20 fs/nilfs2/segment.c:2052
 nilfs_segctor_update_payload_blocknr fs/nilfs2/segment.c:1558 [inline]
 nilfs_segctor_assign fs/nilfs2/segment.c:1625 [inline]
 nilfs_segctor_do_construct+0x3deb/0xbf20 fs/nilfs2/segment.c:2052
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
