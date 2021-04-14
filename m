Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0858235EC87
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 07:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347873AbhDNFw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 01:52:56 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:48754 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347790AbhDNFwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 01:52:40 -0400
Received: by mail-il1-f200.google.com with SMTP id w2-20020a92c8820000b0290154cfcf53e5so589966ilo.15
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 22:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+m0E+t8NZADjC4EINZ+KB+2NMPsqESMoZ/gOC8zfLP4=;
        b=ZY4Xq+d+kLr6uk1/1NtdGUrF4i3PXe7K0d3WLw6NvJGusWmz3Q1IJPgTixCo5s1zkh
         CCo+ieilPI1g5G25W1wJkckr2IUXB+9EBer1i2jJvRXuKdgNaB0BfMj7pBXuXpk1+jN9
         sCKuTM6wf3F+fygqupUvtUcD3Zd0tsULyYvpdABboj2xFd1yQJK9yTS+3s0Ie4XN8eSQ
         juHA0YhfMAbO3m263Eay7KqZ16b6ezO0yxyMcOaZRN8b1qfPJto1k6DAw9J7o3hyyPOp
         WoZlDksiL10LiBFYgz3Rd4pwyH37cm73Rzd+2R6TrfuVNffoT2L1/MOWdkAZooo9yMQ+
         cdxg==
X-Gm-Message-State: AOAM533U/FsR1Y7KgjWxzwh8blvYssKIVQzovBGcxhFBgY1VBgRVclcI
        YEsmm8KYIyoimqjyFKAcFIiTbUjV+TwcPGdsdVICJqv/nnCn
X-Google-Smtp-Source: ABdhPJxhbk1xPLzGBuG8XeMEJVetZJW23+svXclqHEp0/RGeO8JYQM02hhRXPijmk6lEGf952Q2njMqLuqp6yGDHAB79j9D4ttPV
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1da:: with SMTP id w26mr30130358iot.170.1618379540028;
 Tue, 13 Apr 2021 22:52:20 -0700 (PDT)
Date:   Tue, 13 Apr 2021 22:52:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009862e005bfe859c8@google.com>
Subject: [syzbot] KASAN: use-after-free Read in get_wchan
From:   syzbot <syzbot+0806291048161061627c@syzkaller.appspotmail.com>
To:     0x7f454c46@gmail.com, akpm@linux-foundation.org,
        aou@eecs.berkeley.edu, chenhuang5@huawei.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        syzkaller-bugs@googlegroups.com, wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b2b3d18f riscv: Make NUMA depend on MMU
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=12b59d16d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=81b3e7c68dad6e
dashboard link: https://syzkaller.appspot.com/bug?extid=0806291048161061627c
userspace arch: riscv64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0806291048161061627c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in walk_stackframe arch/riscv/kernel/stacktrace.c:60 [inline]
BUG: KASAN: use-after-free in get_wchan+0x156/0x196 arch/riscv/kernel/stacktrace.c:136
Read of size 8 at addr ffffffe0058e3d90 by task syz-executor.0/4667

CPU: 1 PID: 4667 Comm: syz-executor.0 Not tainted 5.12.0-rc5-syzkaller-00721-gb2b3d18fc20e #0
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffe000009706>] walk_stackframe+0x0/0x23c arch/riscv/kernel/traps.c:201
[<ffffffe002a5f182>] dump_backtrace+0x40/0x4e arch/riscv/kernel/stacktrace.c:113
[<ffffffe002a5f1b2>] show_stack+0x22/0x2e arch/riscv/kernel/stacktrace.c:118
[<ffffffe002a68a3e>] __dump_stack lib/dump_stack.c:79 [inline]
[<ffffffe002a68a3e>] dump_stack+0x148/0x1d8 lib/dump_stack.c:120
[<ffffffe0003bc802>] print_address_description.constprop.0+0x52/0x31e mm/kasan/report.c:232
[<ffffffe0003bcd24>] __kasan_report mm/kasan/report.c:399 [inline]
[<ffffffe0003bcd24>] kasan_report+0x16e/0x18c mm/kasan/report.c:416
[<ffffffe0003bd588>] check_region_inline mm/kasan/generic.c:180 [inline]
[<ffffffe0003bd588>] __asan_load8+0x6e/0x80 mm/kasan/generic.c:253
[<ffffffe000009a98>] walk_stackframe arch/riscv/kernel/stacktrace.c:60 [inline]
[<ffffffe000009a98>] get_wchan+0x156/0x196 arch/riscv/kernel/stacktrace.c:136
[<ffffffe000553364>] proc_pid_wchan+0x48/0xa4 fs/proc/base.c:390
[<ffffffe000554458>] proc_single_show+0x9c/0x13c fs/proc/base.c:774
[<ffffffe00045000c>] seq_read_iter+0x2e0/0x8f2 fs/seq_file.c:227
[<ffffffe00045081e>] seq_read+0x200/0x298 fs/seq_file.c:159
[<ffffffe0003f9210>] vfs_read+0x108/0x2ac fs/read_write.c:494
[<ffffffe0003f9724>] ksys_read+0xb4/0x1b8 fs/read_write.c:634
[<ffffffe0003f9850>] __do_sys_read fs/read_write.c:644 [inline]
[<ffffffe0003f9850>] sys_read+0x28/0x36 fs/read_write.c:642
[<ffffffe000005572>] ret_from_syscall+0x0/0x2

The buggy address belongs to the page:
page:ffffffcf0216b8c0 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x85ae3
flags: 0xffe000000000000()
raw: 0ffe000000000000 ffffffcf0216b8c8 ffffffcf0216b8c8 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffffffe0058e3c80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffffffe0058e3d00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffffffe0058e3d80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                         ^
 ffffffe0058e3e00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffffffe0058e3e80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
