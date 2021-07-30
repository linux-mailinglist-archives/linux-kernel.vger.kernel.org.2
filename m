Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA363DB5A7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 11:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbhG3JIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 05:08:30 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:44764 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhG3JI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:08:28 -0400
Received: by mail-io1-f72.google.com with SMTP id 5-20020a5d9c450000b029050b6f9cfe31so5126666iof.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LOpcD94JT6AcjBsndlStT+OJkcVIsjkFHCRw2q3qaPk=;
        b=I4lpBgHczV3nbpHg00xVWHLToIbtMuxrRmTmOJJMmUaYlxYfYZneU0OJLKiVMykO6o
         /b2b0eOUU2CnkeU3i1tV1EyXx6RLNBg46+yEz1yK7UE0DFH4EBIvOSWrC90EbhzDmaOJ
         NUQ0uXRBwHQUDEl7neToJfznmbQsHUIZgARWuBLdqDZcRwYVAAz37U1HlUbLGlUtgxQZ
         9ON0kHPhlRLhUOpzxXODf+bf8CWkmHq7PqxASZocoZs7IsT8NToT7qifXsR8ysMK81hQ
         6IojjdAR5PopFYFHMw+K4OvUlMVDd1+VG7pKZ7Pd5shFXEzBZFWOGjVOHdBiFO+m2RR2
         vEPw==
X-Gm-Message-State: AOAM533nsXFmC2nhAHDIjbjmtSfo9hoF/gYvoFQdyM277g54ul7PjVjV
        b9+Y/h9giyVGyEknYW3Sy6Y7NXtAlg+QMPw3XucDqdFoQy+U
X-Google-Smtp-Source: ABdhPJwVEG4Km2ZcQNtPuFJ0+Rrl60q/LXm69xoLDvx2qxU+8/1um3GnFQ6DhlsX06A5ZmMys8QUb/Mr7xl7OcTozuXA6BaKU+mG
MIME-Version: 1.0
X-Received: by 2002:a5d:9eda:: with SMTP id a26mr351194ioe.166.1627636104124;
 Fri, 30 Jul 2021 02:08:24 -0700 (PDT)
Date:   Fri, 30 Jul 2021 02:08:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf5b1805c8538f2e@google.com>
Subject: [syzbot] UBSAN: array-index-out-of-bounds in __anon_vma_prepare
From:   syzbot <syzbot+66bddd4a39f264bee945@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ff1176468d36 Linux 5.14-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10034f0e300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=40eef000d7648480
dashboard link: https://syzkaller.appspot.com/bug?extid=66bddd4a39f264bee945
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+66bddd4a39f264bee945@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in kernel/locking/osq_lock.c:34:9
index 117901062 is out of range for type 'long unsigned int [8]'
CPU: 1 PID: 25857 Comm: kworker/u4:3 Not tainted 5.14.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_out_of_bounds.cold+0x62/0x6c lib/ubsan.c:288
 decode_cpu kernel/locking/osq_lock.c:34 [inline]
 osq_lock+0x5ab/0x600 kernel/locking/osq_lock.c:111
 rwsem_optimistic_spin kernel/locking/rwsem.c:746 [inline]
 rwsem_down_write_slowpath+0x1bb/0x11d0 kernel/locking/rwsem.c:1025
 __down_write_common kernel/locking/rwsem.c:1261 [inline]
 __down_write_common kernel/locking/rwsem.c:1258 [inline]
 __down_write kernel/locking/rwsem.c:1270 [inline]
 down_write+0x137/0x150 kernel/locking/rwsem.c:1407
 anon_vma_lock_write include/linux/rmap.h:116 [inline]
 __anon_vma_prepare+0xbf/0x560 mm/rmap.c:203
 anon_vma_prepare include/linux/rmap.h:149 [inline]
 do_anonymous_page mm/memory.c:3765 [inline]
 handle_pte_fault mm/memory.c:4556 [inline]
 __handle_mm_fault+0x4338/0x5320 mm/memory.c:4693
 handle_mm_fault+0x1c8/0x790 mm/memory.c:4791
 faultin_page mm/gup.c:951 [inline]
 __get_user_pages+0x806/0x1430 mm/gup.c:1173
 __get_user_pages_locked mm/gup.c:1359 [inline]
 __get_user_pages_remote+0x18f/0x840 mm/gup.c:1865
 get_user_pages_remote+0x63/0x90 mm/gup.c:1938
 get_arg_page+0xba/0x200 fs/exec.c:220
 copy_string_kernel+0x1b4/0x520 fs/exec.c:631
 kernel_execve+0x25c/0x460 fs/exec.c:1961
 call_usermodehelper_exec_async+0x2e3/0x580 kernel/umh.c:112
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
