Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53F643949F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 13:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhJYLSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 07:18:43 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:44920 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhJYLSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 07:18:42 -0400
Received: by mail-io1-f71.google.com with SMTP id a1-20020a5d9801000000b005de11aa60b8so8598371iol.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 04:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=e5NZpnxNaJyqowu2CwdQsqPF7xPZW737SvpJi76W8ug=;
        b=55F+4jpXD7pTi5ANHflHamLyxk8hE09Dc2spKZ8+kYMsYl662qp8smvRWmitnTTVIf
         R1zfkSUBmXwz0qyAUfb4Xq4MeJNz4o4vTJqCSYNhh3oiGx6Cg77AKqg6DQlfT+r/eGrP
         TVCBRtDnRvUZcblXdVRvG3ElS4Ghv42loO0BYg+dZCpM/OYzU91b5eVBdabAGe6xcSIF
         S7MHPISXr2mc2W9+vGuaEBC3k2+oVI3f8csE+Kt6qcGkHjQW3EM2dpuFrDzGyf8Rp3gR
         YaB4wq84hPx0VQnY01rwDIBHhwhBbkweYz8AA1fkAFJMjTo8HyN0/IkYf0p25AlZ7aQo
         vZ1g==
X-Gm-Message-State: AOAM533LAaZLG72tKwJqJ68jRUZOlYpJWGNtAAA6gV7vpSU/kmmuFd90
        TpXVXFIc4XMCT80VAKRtiM/Wexf3x2+Q3krOtfPokBJOTjMg
X-Google-Smtp-Source: ABdhPJzo+aUH+MCnAiTyEKu9F1hOnOjluvS1f1YeBNl20elMwblC8Pwoj2lnN2D+PF7gkxeop3KeAPEK/Bec1UkyTKVRAIuRQmsj
MIME-Version: 1.0
X-Received: by 2002:a02:ccfb:: with SMTP id l27mr4492245jaq.98.1635160580260;
 Mon, 25 Oct 2021 04:16:20 -0700 (PDT)
Date:   Mon, 25 Oct 2021 04:16:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089871905cf2b7d09@google.com>
Subject: [syzbot] KCSAN: data-race in sbitmap_queue_clear /
 sbitmap_queue_clear (3)
From:   syzbot <syzbot+4f8bfd804b4a1f95b8f6@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2f111a6fd5b5 Merge tag 'ceph-for-5.15-rc7' of git://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10dae330b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2868748300e5cf6
dashboard link: https://syzkaller.appspot.com/bug?extid=4f8bfd804b4a1f95b8f6
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4f8bfd804b4a1f95b8f6@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in sbitmap_queue_clear / sbitmap_queue_clear

write to 0xffffe8ffffd145b8 of 4 bytes by interrupt on cpu 1:
 sbitmap_queue_clear+0xca/0xf0 lib/sbitmap.c:606
 blk_mq_put_tag+0x82/0x90
 __blk_mq_free_request+0x114/0x180 block/blk-mq.c:507
 blk_mq_free_request+0x2c8/0x340 block/blk-mq.c:541
 __blk_mq_end_request+0x214/0x230 block/blk-mq.c:565
 blk_mq_end_request+0x37/0x50 block/blk-mq.c:574
 lo_complete_rq+0xca/0x170 drivers/block/loop.c:541
 blk_complete_reqs block/blk-mq.c:584 [inline]
 blk_done_softirq+0x69/0x90 block/blk-mq.c:589
 __do_softirq+0x12c/0x26e kernel/softirq.c:558
 run_ksoftirqd+0x13/0x20 kernel/softirq.c:920
 smpboot_thread_fn+0x22f/0x330 kernel/smpboot.c:164
 kthread+0x262/0x280 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30

write to 0xffffe8ffffd145b8 of 4 bytes by interrupt on cpu 0:
 sbitmap_queue_clear+0xca/0xf0 lib/sbitmap.c:606
 blk_mq_put_tag+0x82/0x90
 __blk_mq_free_request+0x114/0x180 block/blk-mq.c:507
 blk_mq_free_request+0x2c8/0x340 block/blk-mq.c:541
 __blk_mq_end_request+0x214/0x230 block/blk-mq.c:565
 blk_mq_end_request+0x37/0x50 block/blk-mq.c:574
 lo_complete_rq+0xca/0x170 drivers/block/loop.c:541
 blk_complete_reqs block/blk-mq.c:584 [inline]
 blk_done_softirq+0x69/0x90 block/blk-mq.c:589
 __do_softirq+0x12c/0x26e kernel/softirq.c:558
 run_ksoftirqd+0x13/0x20 kernel/softirq.c:920
 smpboot_thread_fn+0x22f/0x330 kernel/smpboot.c:164
 kthread+0x262/0x280 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30

value changed: 0x00000035 -> 0x00000044

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 10 Comm: ksoftirqd/0 Not tainted 5.15.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
