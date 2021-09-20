Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589B2411888
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241772AbhITPoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:44:05 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:34575 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbhITPoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:44:03 -0400
Received: by mail-io1-f72.google.com with SMTP id s12-20020a056602168c00b005d611510e15so1264982iow.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 08:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=XNtNgu7JmjE8E630pKonga7MBsNIrdGiBGXQ+O50Gpk=;
        b=jpSeOn/Mc5ZcnWYg/azBmXJY4B8lS9oxvd1M48YH4iRfP5D6GySWNIlzh49P3wcCBc
         H0l9TTzaFl9bGDDIIkjcBRRFVwjjN/OZz1JkVHBeqFmgulqH/l+42t56SK5h9WBoRmnK
         CtqKnwhd00GDsT2rnozzQXFO2nSrX3ra3u3JZzqd8XeIYU3Or6xAJwCTyaHxiJewCt3W
         WVaFGcYnKx0tSRiCDX8wUTIKlLjP8zKtn2hAcUfhPlqP4JBaekslwnqqTgheuOMmhzp8
         bFYouIDG2vbgVMx0miBg4TH4D+2pKjDjw9kkKZYAaeoAiVt+7eJa0fYQivtyBD9lPTc0
         S5Cg==
X-Gm-Message-State: AOAM532pQOSNySegGi6Kj/+dwfYRsmN2hZ+L68CCKLFPjz6pGplWjdxZ
        hQRx/bbutoG8yTI5uwYEj9IF2lVZQMxiIZOp6VZz/29qoj6m
X-Google-Smtp-Source: ABdhPJyPiOTM7nVCe2kUVGnVtPQ+lFP0KY7MOW8csA78jTKkU77YQNmOldzVWeNm5UaN+GLgcwJbEYXFxXZylPLEUIcrv6LCf4Jb
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ed:: with SMTP id q13mr3707547ilv.111.1632152556497;
 Mon, 20 Sep 2021 08:42:36 -0700 (PDT)
Date:   Mon, 20 Sep 2021 08:42:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000059730805cc6f2138@google.com>
Subject: [syzbot] memory leak in prepare_kernel_cred
From:   syzbot <syzbot+b214edc6e43f8da65554@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, ebiederm@xmission.com,
        legion@kernel.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, syzkaller-bugs@googlegroups.com,
        yangyingliang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4357f03d6611 Merge tag 'pm-5.15-rc2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16260b9b300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84e947373389eef5
dashboard link: https://syzkaller.appspot.com/bug?extid=b214edc6e43f8da65554
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a7cb3b300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103f8f2d300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b214edc6e43f8da65554@syzkaller.appspotmail.com

write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
BUG: memory leak
unreferenced object 0xffff8881046d5480 (size 176):
  comm "kworker/u4:0", pid 6631, jiffies 4294994696 (age 35.750s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81275931>] prepare_kernel_cred+0x21/0x2e0 kernel/cred.c:724
    [<ffffffff8125fc6d>] call_usermodehelper_exec_async+0x5d/0x1c0 kernel/umh.c:91
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888102054040 (size 32):
  comm "kworker/u4:0", pid 6631, jiffies 4294994696 (age 35.750s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 b0 12 05 40 81 88 ff ff  ...........@....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8213e79f>] lsm_cred_alloc security/security.c:537 [inline]
    [<ffffffff8213e79f>] security_prepare_creds+0x9f/0xc0 security/security.c:1691
    [<ffffffff81275ab5>] prepare_kernel_cred+0x1a5/0x2e0 kernel/cred.c:760
    [<ffffffff8125fc6d>] call_usermodehelper_exec_async+0x5d/0x1c0 kernel/umh.c:91
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff8881046d50c0 (size 176):
  comm "kworker/u4:0", pid 6633, jiffies 4294994696 (age 35.750s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81275931>] prepare_kernel_cred+0x21/0x2e0 kernel/cred.c:724
    [<ffffffff8125fc6d>] call_usermodehelper_exec_async+0x5d/0x1c0 kernel/umh.c:91
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff88810493f6c0 (size 176):
  comm "kworker/u4:0", pid 6634, jiffies 4294994696 (age 35.750s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81275931>] prepare_kernel_cred+0x21/0x2e0 kernel/cred.c:724
    [<ffffffff8125fc6d>] call_usermodehelper_exec_async+0x5d/0x1c0 kernel/umh.c:91
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888104cec5e0 (size 32):
  comm "kworker/u4:0", pid 6634, jiffies 4294994696 (age 35.750s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 b0 12 05 40 81 88 ff ff  ...........@....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8213e79f>] lsm_cred_alloc security/security.c:537 [inline]
    [<ffffffff8213e79f>] security_prepare_creds+0x9f/0xc0 security/security.c:1691
    [<ffffffff81275ab5>] prepare_kernel_cred+0x1a5/0x2e0 kernel/cred.c:760
    [<ffffffff8125fc6d>] call_usermodehelper_exec_async+0x5d/0x1c0 kernel/umh.c:91
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff88810382b780 (size 176):
  comm "kworker/u4:0", pid 6637, jiffies 4294994700 (age 35.710s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81275931>] prepare_kernel_cred+0x21/0x2e0 kernel/cred.c:724
    [<ffffffff8125fc6d>] call_usermodehelper_exec_async+0x5d/0x1c0 kernel/umh.c:91
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888102054060 (size 32):
  comm "kworker/u4:0", pid 6637, jiffies 4294994700 (age 35.710s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 b0 12 05 40 81 88 ff ff  ...........@....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8213e79f>] lsm_cred_alloc security/security.c:537 [inline]
    [<ffffffff8213e79f>] security_prepare_creds+0x9f/0xc0 security/security.c:1691
    [<ffffffff81275ab5>] prepare_kernel_cred+0x1a5/0x2e0 kernel/cred.c:760
    [<ffffffff8125fc6d>] call_usermodehelper_exec_async+0x5d/0x1c0 kernel/umh.c:91
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888104c0a780 (size 176):
  comm "kworker/u4:0", pid 6630, jiffies 4294994702 (age 35.690s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81275931>] prepare_kernel_cred+0x21/0x2e0 kernel/cred.c:724
    [<ffffffff8125fc6d>] call_usermodehelper_exec_async+0x5d/0x1c0 kernel/umh.c:91
    [<ffffffff8100234f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
