Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BCE30D245
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 04:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhBCD7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 22:59:07 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:51165 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhBCD7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 22:59:04 -0500
Received: by mail-il1-f200.google.com with SMTP id x11so23244785ill.17
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 19:58:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wXlcTMxuXTA9JnopaVEiXLjgbf8SiWAZS7qkL4vEMcM=;
        b=h6n6Ul/ZTWE9TCSLbuU4KohkEUuvFQAfrQQIj4Y2yoUba97zG+MIh6OaNKLRE4Y8uz
         0+OnLjXAHuHMZIJASqnWEcbk2F6+xdS8unb5wpjdPq99BxkADfw7zxEJr5ufBzh2J2rf
         xbDAnRFbf05GitleUkL2uaQVfeUoyYDMhn4AyjXieSKbuLANe44SnbZQK4h5R/SAxcTo
         J3caICZreMsqj3YRBDcJKf7ZA5Xy7lecRLCSN3a9SbbdEEsGqtQb9vn+QqfDxSEweml7
         6iTm0oOLvJuIVdLkKRYMhE7xiwI7H9neUxN+39PU6nzacvKRVZa0SGRuDbi2s3AEDWlA
         EQKg==
X-Gm-Message-State: AOAM533k/B5S1YyEEl58oXo8Igo8HFFzZGh5i6KnwNSSU98Hh5NWS4PC
        vymgD+iA6LcTQ31gBHYr2NDy8WScORph4pNs3Cz2Ia+NYInL
X-Google-Smtp-Source: ABdhPJyotqswEP2/6Ey2ejcag/c/3KutI/stJYeOOKtD16yPleM3f0WixEdK7LIQjSXpFFiYxYJ3svYd4/P5EjuRVH4SkEk+bnVy
MIME-Version: 1.0
X-Received: by 2002:a92:1e12:: with SMTP id e18mr1154706ile.270.1612324703619;
 Tue, 02 Feb 2021 19:58:23 -0800 (PST)
Date:   Tue, 02 Feb 2021 19:58:23 -0800
In-Reply-To: <000000000000fef5a905aa76dbf9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038d23a05ba66999d@google.com>
Subject: Re: memory leak in create_pipe_files
From:   syzbot <syzbot+6a137efd811917e8b53c@syzkaller.appspotmail.com>
To:     anant.thazhemadam@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    3aaf0a27 Merge tag 'clang-format-for-linux-v5.11-rc7' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15d87364d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7edd79f26f7c0c3
dashboard link: https://syzkaller.appspot.com/bug?extid=6a137efd811917e8b53c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10df828cd00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c4f2f8d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6a137efd811917e8b53c@syzkaller.appspotmail.com

Warning: Permanently added '10.128.10.43' (ECDSA) to the list of known hosts.
executing program
executing program
BUG: memory leak
unreferenced object 0xffff888110f47600 (size 232):
  comm "kworker/u4:1", pid 8442, jiffies 4294942490 (age 13.540s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    60 2a 04 01 81 88 ff ff 80 2d 37 0f 81 88 ff ff  `*.......-7.....
  backtrace:
    [<000000007ea4ba2d>] kmem_cache_zalloc include/linux/slab.h:672 [inline]
    [<000000007ea4ba2d>] __alloc_file+0x1f/0xf0 fs/file_table.c:101
    [<00000000cdcab42a>] alloc_empty_file+0x69/0x120 fs/file_table.c:150
    [<00000000ca09bf0f>] alloc_file+0x33/0x1b0 fs/file_table.c:192
    [<00000000c44b2f75>] alloc_file_pseudo+0xb2/0x140 fs/file_table.c:232
    [<00000000a7d8ad8d>] create_pipe_files+0x138/0x2e0 fs/pipe.c:911
    [<000000007cde2906>] umd_setup+0x33/0x220 kernel/usermode_driver.c:104
    [<00000000566c5ffa>] call_usermodehelper_exec_async+0xb4/0x1b0 kernel/umh.c:101
    [<00000000f26cfa20>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

BUG: memory leak
unreferenced object 0xffff888113186300 (size 232):
  comm "kworker/u4:1", pid 8442, jiffies 4294942490 (age 13.540s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    60 2a 04 01 81 88 ff ff 00 d6 13 0f 81 88 ff ff  `*..............
  backtrace:
    [<000000007ea4ba2d>] kmem_cache_zalloc include/linux/slab.h:672 [inline]
    [<000000007ea4ba2d>] __alloc_file+0x1f/0xf0 fs/file_table.c:101
    [<00000000cdcab42a>] alloc_empty_file+0x69/0x120 fs/file_table.c:150
    [<00000000ca09bf0f>] alloc_file+0x33/0x1b0 fs/file_table.c:192
    [<0000000053d2fba9>] alloc_file_clone+0x22/0x70 fs/file_table.c:244
    [<000000002475fc17>] create_pipe_files+0x182/0x2e0 fs/pipe.c:922
    [<00000000bcdcee57>] umd_setup+0xad/0x220 kernel/usermode_driver.c:115
    [<00000000566c5ffa>] call_usermodehelper_exec_async+0xb4/0x1b0 kernel/umh.c:101
    [<00000000f26cfa20>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296


