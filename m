Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451963594E2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhDIFnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:43:41 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:52348 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbhDIFnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:43:33 -0400
Received: by mail-il1-f199.google.com with SMTP id s20so387023ilj.19
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 22:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/ly/4Xm6+8ivV15n83ADfbzIBp0b85vMIRQe3MQRl7o=;
        b=sC2tGNmWLgksXqUoSYHfIGnmXv6tk68G7wx2rludcHlBmOhHjIWB/RH+KNzHxuT9kY
         RhPwtf/Q1soa/+ulPPB+wrBCCAaFy7Mu2nTLpXDnaurPSOKYXBZR3DNGO1xguBmLgHJv
         2rC/rB7gqpGoxvLK/KPVTA6wTPJ6kG/E/brr0M8FPlTQnHcJFFNBaH1Bg1C8oaMcXz5i
         nv4KpteC7LSQkhtJKWARSOh5PYrknslhHui2f4CAv8Pn8Oy4p1tHqj2MiRKJRHC05+PY
         oGVbA7OrQ9q7SCwbiXhwmPO2of0/iZjg0oM+6pVgGaSHLjX9qdHqOIQp2lbLoft35FhG
         quWw==
X-Gm-Message-State: AOAM531e+zn7pYrYXBvo6613GxQBJq1jMvedY1KQjQDDDVOnHkPB873M
        8YX5DaQV9sITwf4kB0D3F4sqK0ulpfiBWMzwq3nmbKpiAvee
X-Google-Smtp-Source: ABdhPJywPyJtv7ooSj0CpwoceEcAzw9/ul9ZWOBL7sVOq2HE4n9irT1sbN79NB+q7VJH7zzMLSUaeL88rbZqr05QNTyU8feZPKPv
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3884:: with SMTP id b4mr12621744jav.18.1617946999193;
 Thu, 08 Apr 2021 22:43:19 -0700 (PDT)
Date:   Thu, 08 Apr 2021 22:43:19 -0700
In-Reply-To: <0000000000002c2f5b05b732ce65@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000027071505bf83a4f3@google.com>
Subject: Re: [syzbot] memory leak in ext4_multi_mount_protect
From:   syzbot <syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, juan.carlos@b2bworthyleads.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    4fa56ad0 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12390a96d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8dbd3c72fdc7777
dashboard link: https://syzkaller.appspot.com/bug?extid=d9e482e303930fa4f6ff
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109aaa7ed00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e77d16d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com

executing program
BUG: memory leak
unreferenced object 0xffff888111edd780 (size 32):
  comm "syz-executor633", pid 8448, jiffies 4294951405 (age 17.620s)
  hex dump (first 32 bytes):
    10 64 d1 0f 81 88 ff ff 00 10 7e 12 81 88 ff ff  .d........~.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81744606>] kmalloc include/linux/slab.h:554 [inline]
    [<ffffffff81744606>] ext4_multi_mount_protect+0x4a6/0x5d0 fs/ext4/mmp.c:367
    [<ffffffff81783614>] ext4_fill_super+0x56a4/0x5b20 fs/ext4/super.c:4769
    [<ffffffff8154ebf3>] mount_bdev+0x223/0x260 fs/super.c:1367
    [<ffffffff815aee7b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:592
    [<ffffffff8154c7e8>] vfs_get_tree+0x28/0x100 fs/super.c:1497
    [<ffffffff8158c8ee>] do_new_mount fs/namespace.c:2903 [inline]
    [<ffffffff8158c8ee>] path_mount+0xc3e/0x1120 fs/namespace.c:3233
    [<ffffffff8158d51e>] do_mount fs/namespace.c:3246 [inline]
    [<ffffffff8158d51e>] __do_sys_mount fs/namespace.c:3454 [inline]
    [<ffffffff8158d51e>] __se_sys_mount fs/namespace.c:3431 [inline]
    [<ffffffff8158d51e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3431
    [<ffffffff842ded2d>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae


