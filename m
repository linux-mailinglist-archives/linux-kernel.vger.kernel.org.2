Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D39040F34B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240507AbhIQHbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:31:45 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:33756 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhIQHbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:31:43 -0400
Received: by mail-io1-f71.google.com with SMTP id g2-20020a6b7602000000b005be59530196so18898361iom.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=m3nRbhKCaWxS8OkQmfuFA20q5t1TuojdS6u2lz7XyIg=;
        b=agzkLKla5Ei1sneQPKGzcXjm3tnsLTIdtTi0mJBeVqWc5EkOkXHYZur+454Z6V2zQF
         BVczltIrjAkqx8UDUSKxaatCCdcQOq/H6z5Mu8pEp4vawiztIzhGW1/fNHlGU42y2R7J
         gPAuofk4+Zn0nz+26K84hTcYL3m8QEJadBQlKRYqXYFRgC0J8nLJl2sGcXgDe/jsrqAw
         GyyyBsJcJtjxfGXPOMQJBdKUX34MiaN6TOtsfodD86slN1pyO/+SbMMBKivYD4j/aRbE
         Ew5Zjur7yOEEleIJNlDeY7f6ebBRKRx/EszbfOxitpbbNZQfrHpy8biquhvUQxNSyM/6
         VQiA==
X-Gm-Message-State: AOAM533MgK4NTY2lb8qeuHwIhjF93dOrnR58UcTL5tAiHQxGrJgipSoP
        OpnJgOU+CXQpJ89zQxy4jzqFb2XUlVwalEk+wihPLIdADewk
X-Google-Smtp-Source: ABdhPJyeZuMqnpDFXxjm6O9W9SV4ZGifaV5hgG26+z2XjKRZ6Y6MYgNglhtAC3RvKn9D6zriNGPo/kRc5mu8i4LhGAboVLFM3xQN
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1909:: with SMTP id p9mr7767060jal.108.1631863822026;
 Fri, 17 Sep 2021 00:30:22 -0700 (PDT)
Date:   Fri, 17 Sep 2021 00:30:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f0bec05cc2be7dc@google.com>
Subject: [syzbot] BUG: soft lockup in call_usermodehelper_exec_async
From:   syzbot <syzbot+c3963f4f025fa5dfb78b@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8cae8cd89f05 seq_file: disallow extremely large seq buffer..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135dbd12300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=548fbb1e84c1808e
dashboard link: https://syzkaller.appspot.com/bug?extid=c3963f4f025fa5dfb78b
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c3963f4f025fa5dfb78b@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [kworker/u4:5:21352]
Modules linked in:
irq event stamp: 196
hardirqs last  enabled at (195): [<ffff80001457eb88>] exit_to_kernel_mode+0x38/0x230 arch/arm64/kernel/entry-common.c:71
hardirqs last disabled at (196): [<ffff80001457eb40>] enter_el1_irq_or_nmi+0x10/0x20 arch/arm64/kernel/entry-common.c:113
softirqs last  enabled at (116): [<ffff8000100109a4>] _stext+0x9a4/0x1050
softirqs last disabled at (51): [<ffff800010161d30>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
softirqs last disabled at (51): [<ffff800010161d30>] invoke_softirq kernel/softirq.c:439 [inline]
softirqs last disabled at (51): [<ffff800010161d30>] __irq_exit_rcu+0x470/0x520 kernel/softirq.c:636
CPU: 1 PID: 21352 Comm: kworker/u4:5 Not tainted 5.14.0-rc2-syzkaller-00001-g8cae8cd89f05 #0
Hardware name: linux,dummy-virt (DT)
pstate: 00000005 (nzcv daif -PAN -UAO -TCO BTYPE=--)
pc : clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:23
lr : clear_highpage include/linux/highmem.h:184 [inline]
lr : kernel_init_free_pages.part.0+0x6c/0x17c mm/page_alloc.c:1283
sp : ffff800018c67380
x29: ffff800018c67380 x28: 0000000000000000 x27: ffff00007fc11ec0
x26: ffff00000fe7aef8 x25: ffff600001fcf5df x24: 00000000000014b8
x23: ffff00000fe79a40 x22: fffffc0000171340 x21: ffff800015706c40
x20: dfff800000000000 x19: fffffc0000171300 x18: ffff00006aa70bc8
x17: ffff800055045000 x16: ffff800018598000 x15: ffff000010dd0600
x14: 1ffff0000318ce3a x13: 0000000000000014 x12: ffff7f800002e267
x11: 1fffff800002e266 x10: ffff7f800002e266 x9 : 0000000000000000
x8 : ffff600000b89a00 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 1ffff0000304db70 x3 : 1fffe00001fcf349
x2 : 0000000000000004 x1 : 0000000000000040 x0 : ffff000005c4ca40
Call trace:
 clear_page+0x14/0x28 arch/arm64/lib/clear_page.S:21
 kernel_init_free_pages mm/page_alloc.c:1280 [inline]
 post_alloc_hook+0x1ac/0x25c mm/page_alloc.c:2423
 prep_new_page mm/page_alloc.c:2433 [inline]
 get_page_from_freelist+0x1840/0x2310 mm/page_alloc.c:4166
 __alloc_pages+0x1a8/0x2234 mm/page_alloc.c:5388
 alloc_pages_vma+0xb4/0x4dc mm/mempolicy.c:2208
 alloc_zeroed_user_highpage_movable+0x9c/0xd0 arch/arm64/mm/fault.c:939
 do_anonymous_page mm/memory.c:3767 [inline]
 handle_pte_fault mm/memory.c:4547 [inline]
 __handle_mm_fault+0xcbc/0x25e4 mm/memory.c:4684
 handle_mm_fault+0x1dc/0x4ec mm/memory.c:4782
 faultin_page mm/gup.c:951 [inline]
 __get_user_pages+0x3e4/0x744 mm/gup.c:1173
 __get_user_pages_locked mm/gup.c:1359 [inline]
 __get_user_pages_remote+0x10c/0x500 mm/gup.c:1865
 get_user_pages_remote+0x28/0x40 mm/gup.c:1938
 get_arg_page+0x9c/0x1bc fs/exec.c:220
 copy_string_kernel+0x170/0x294 fs/exec.c:631
 kernel_execve+0x1ac/0x380 fs/exec.c:1961
 call_usermodehelper_exec_async+0x260/0x460 kernel/umh.c:112
 ret_from_fork+0x10/0x18 arch/arm64/kernel/entry.S:782


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
