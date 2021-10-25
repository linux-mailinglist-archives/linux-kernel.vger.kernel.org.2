Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E84439B82
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 18:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbhJYQcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 12:32:51 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:47962 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhJYQcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:32:50 -0400
Received: by mail-io1-f72.google.com with SMTP id m8-20020a0566022e8800b005de532f3f54so9312540iow.14
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 09:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ED9HaBWqU5sT7krjsMnqS958U0OD+vrR5JGVIAGxfyU=;
        b=z5dMXKMlg57GoBzGdsWt67aBD5RM1ymEwVyxOqJUZfKc8Dfg7LfgyAhV3mUDq+bnhs
         dGJIp91hXEBDtAfEX2DVeY/zI+ZMDjdAVLkCsfi2tJlcFFLzEjEScW71VqvSxT56/s8d
         ZZzxlSxYE1PeFIwgG3tx6z+nrh7/CNqst9/uXUIXwACZLMspH5pn6fSNJFZIBrQBVA8I
         hMqyl7ENEOPiPqlzbLbBdnyDLuGK3TKy/Su2ATBDg2UwQwNfmCMqQ6Mh4imsp/I3hxQC
         OTqUgaieY993AohsJqhSH+dv/yZDWWynH2+3iTUhb9JzZpNeQBva5gM5CeDJ72qfzMNW
         /qFg==
X-Gm-Message-State: AOAM531JySetx9xBUWGJ+rMp6AgnYr6kQ06g+w04f8/J8XPnsLFg7L93
        LQp2l6v2G8FpEwxzWdTeFSIjzwUu7DAbC7fHS/2veD/Hv2iR
X-Google-Smtp-Source: ABdhPJxXkrJYJV80iY0jdxhn9EFabra2d5ekNi5WVz3UGuzf+5S92T5HwcJ39ZEmDR0fR1map4ZfFm8xX6uGJI3PEuGV4BC0Qw+R
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:14d3:: with SMTP id o19mr10571457ilk.257.1635179427889;
 Mon, 25 Oct 2021 09:30:27 -0700 (PDT)
Date:   Mon, 25 Oct 2021 09:30:27 -0700
In-Reply-To: <000000000000b3586105cf0ff45e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1887305cf2fe0d4@google.com>
Subject: Re: [syzbot] WARNING in z_erofs_lz4_decompress
From:   syzbot <syzbot+d8aaffc3719597e8cfb4@syzkaller.appspotmail.com>
To:     chao@kernel.org, dvyukov@google.com, fgheet255t@gmail.com,
        hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    9ae1fbdeabd3 Add linux-next specific files for 20211025
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1300f7c4b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aeb17e42bc109064
dashboard link: https://syzkaller.appspot.com/bug?extid=d8aaffc3719597e8cfb4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103ac24ab00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177194e2b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d8aaffc3719597e8cfb4@syzkaller.appspotmail.com

erofs: (device loop0): z_erofs_lz4_decompress_mem: failed to decompress -4099 in[4096, 0] out[9000]
------------[ cut here ]------------
WARNING: CPU: 1 PID: 45 at fs/erofs/decompressor.c:230 z_erofs_lz4_decompress_mem fs/erofs/decompressor.c:227 [inline]
WARNING: CPU: 1 PID: 45 at fs/erofs/decompressor.c:230 z_erofs_lz4_decompress+0x841/0x1400 fs/erofs/decompressor.c:289
Modules linked in:
CPU: 1 PID: 45 Comm: kworker/u5:0 Not tainted 5.15.0-rc6-next-20211025-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: erofs_unzipd z_erofs_decompressqueue_work
RIP: 0010:z_erofs_lz4_decompress_mem fs/erofs/decompressor.c:230 [inline]
RIP: 0010:z_erofs_lz4_decompress+0x841/0x1400 fs/erofs/decompressor.c:289
Code: e9 03 80 3c 11 00 0f 85 8c 0a 00 00 41 56 48 8b 7d 00 45 89 e9 89 d9 48 c7 c2 00 f0 fb 89 48 c7 c6 20 f2 fb 89 e8 fc 4a 85 05 <0f> 0b 48 b8 00 00 00 00 00 fc ff df 48 8b 4c 24 08 5f 48 89 ca 48
RSP: 0018:ffffc9000115f710 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffffffffeffd RCX: 0000000000000000
RDX: ffff88801599d7c0 RSI: ffffffff815f17d8 RDI: fffff5200022bed2
RBP: ffffc9000115f850 R08: 0000000000000063 R09: 0000000000000000
R10: ffffffff815eb5ae R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000002328 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056199e7f9008 CR3: 000000007f362000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 z_erofs_decompress_pcluster.isra.0+0x1301/0x2250 fs/erofs/zdata.c:975
 z_erofs_decompress_queue fs/erofs/zdata.c:1053 [inline]
 z_erofs_decompressqueue_work+0xe1/0x170 fs/erofs/zdata.c:1064
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>

