Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3644C3FFB49
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 09:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347621AbhICHwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 03:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbhICHwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 03:52:08 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B961C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 00:51:09 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e7so4793385pgk.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 00:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Hjsv22dmrimYS0bkX3fwkCyqwuVWxkQH7/pESIXJPLs=;
        b=Hf6Yb/1d3sWssHoBuoWR/mnlLeBxhxYLdpPGtFZ/TPWZPolQETZIkXVMhVIvtjiiF9
         FcaPGCIA3jA46RK8jdC9nval4+k0ApK8AO2NxEuB/UY7flqgAmusMmRCcmuCdEqJDv3B
         lYmDUPtUtbGXwGI0qH40qyD/YvXDuH/HQU8GJ712qMBwCwmSQ2o4n5lg7+lFvcfpZ0H0
         d6n3ds1z4nHXrfKqH3OmR7mfaW+M6YL+feXNw2o7tP57ytiDsrHfoJUrdWAf598BgIYP
         sRVOvz+dBlb0XiGM7Xs4as5saXGTGOpVDhsd3LvoeTXWddg4H7b+roK820Xee+2FlZec
         ImhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Hjsv22dmrimYS0bkX3fwkCyqwuVWxkQH7/pESIXJPLs=;
        b=flrLElyYHdF+plIx1hu6M1NDW8cAQu8nZ7dRRStLK5MkPagtd0DLgzCHg/vUoN88Mt
         JmxX4SMc+FGB/jVWxSROOQ77iKS+V7EKeYKUbgib8iVDLGcVPCMUg+4Gtn+WBf4BSEfb
         oHRImkt85z8dqeQ1FE4sV2MeZeNpsCEURt2d54UWeLmWWjvE+6Bq8FQEh9SR35HW0nnZ
         Vshs+/5q5rnaGXVs8/+HRlmwN3jj/TAKCe/9cMU6tAudD9xuQxIc7C5h5e20JlrZ61yk
         /KGwrpoxn+zrBsj/chxnRT+LtShUtHwBsSKoHXC4WN4udmVQ4Q403JbNbgm/TUKZR0FH
         BKNw==
X-Gm-Message-State: AOAM53097ujCp0ved5MD5tyo6KI5bPdJ16xGV1UJ2UBaDNQJ3MeWknKb
        /CofE6wnnz+yW/CeNvxqkw4mNj8n7k4auAmtdUwxcjfAWxPDuQE=
X-Google-Smtp-Source: ABdhPJyYqlEvVM5LMUzINRDVLh9AdDprBGGTzuX8mZlbJQjW279nKH//+peI3iOzvBW2sg5z1LCmUb48ixA61mjTUpA=
X-Received: by 2002:a63:5f08:: with SMTP id t8mr2435324pgb.353.1630655468447;
 Fri, 03 Sep 2021 00:51:08 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Fri, 3 Sep 2021 15:50:57 +0800
Message-ID: <CACkBjsbk01Cif47Bv+=DaXaOdGMbPXA5YmW0Yrf4y4tsKT9sZw@mail.gmail.com>
Subject: possible deadlock in blktrans_open
To:     linux-kernel@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 9e9fb7655ed58 Merge tag 'net-next-5.15'
git tree: upstream
console output:
https://drive.google.com/file/d/1Se_X6iW4GNQ5vqD4k_Bb_Sf8TqCx8eTz/view?usp=sharing
kernel config: https://drive.google.com/file/d/1zgxbwaYkrM26KEmJ-5sUZX57gfXtRrwA/view?usp=sharing
C reproducer:  https://drive.google.com/file/d/1BtlOcxuP74hrKEkaEx4RpOXYcsQq0N7q/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1Lb42gOp9KGtdcfLbsPUJjALcS8Vj5KlM/view?usp=sharing

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

Simplified report:
======================================================
WARNING: possible circular locking dependency detected
5.14.0+ #12 Not tainted
------------------------------------------------------
systemd-udevd/6440 is trying to acquire lock:
ffffffff85ca4b68 (mtd_table_mutex){+.+.}-{3:3}, at:
blktrans_open+0x4b/0x260 drivers/mtd/mtd_blkdevs.c:210

Full Log:

[   19.853374][ T6440] ======================================================
[   19.854238][ T6440] WARNING: possible circular locking dependency detected
[   19.855232][ T6440] 5.14.0+ #12 Not tainted
[   19.855765][ T6440] ------------------------------------------------------
[   19.856628][ T6440] systemd-udevd/6440 is trying to acquire lock:
[   19.857463][ T6440] ffffffff85ca4b68 (mtd_table_mutex){+.+.}-{3:3},
at: blktrans_open+0x4b/0x260
[   19.858586][ T6440]
[   19.858586][ T6440] but task is already holding lock:
[   19.859525][ T6440] ffff88800e29c118
(&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0xe0/0x370
[   19.860768][ T6440]
[   19.860768][ T6440] which lock already depends on the new lock.
[   19.860768][ T6440]
[   19.862050][ T6440]
[   19.862050][ T6440] the existing dependency chain (in reverse order) is:
[   19.863208][ T6440]
[   19.863208][ T6440] -> #1 (&disk->open_mutex){+.+.}-{3:3}:
[   19.864226][ T6440]        __mutex_lock+0x98/0xa50
[   19.864841][ T6440]        bd_register_pending_holders+0x2c/0x140
[   19.865612][ T6440]        device_add_disk+0x2f5/0x4f0
[   19.866270][ T6440]        add_mtd_blktrans_dev+0x436/0x670
         Startin[   19.867011][ T6440]        mtdblock_add_mtd+0x73/0xa0
g Load/Save RF K[   19.867775][ T6440]        blktrans_notify_add+0x36/0x50
ill Switch Statu[   19.868519][ T6440]        add_mtd_device+0x3e1/0x670
s...[   19.869269][ T6440]        mtd_device_parse_register+0x26d/0x410
[   19.870131][ T6440]        mtdram_init_device+0xa9/0xd0

[   19.870881][ T6440]        init_mtdram+0xa9/0x104
[   19.871566][ T6440]        do_one_initcall+0x82/0x430
[   19.872289][ T6440]        kernel_init_freeable+0x370/0x3c3
[   19.873122][ T6440]        kernel_init+0x1b/0x180
[   19.873810][ T6440]        ret_from_fork+0x1f/0x30
[   19.874494][ T6440]
[   19.874494][ T6440] -> #0 (mtd_table_mutex){+.+.}-{3:3}:
[   19.875551][ T6440]        __lock_acquire+0x161f/0x1d60
[   19.876301][ T6440]        lock_acquire+0x1f9/0x340
[   19.876994][ T6440]        __mutex_lock+0x98/0xa50
[   19.877675][ T6440]        blktrans_open+0x4b/0x260
[   19.878365][ T6440]        blkdev_get_whole+0x36/0xd0
[   19.879081][ T6440]        blkdev_get_by_dev+0x173/0x370
[   19.879868][ T6440]        blkdev_open+0x95/0x100
[   19.880547][ T6440]        do_dentry_open+0x327/0x530
[   19.881265][ T6440]        path_openat+0xcf3/0xe20
[   19.881979][ T6440]        do_filp_open+0xe3/0x170
[   19.882673][ T6440]        do_sys_openat2+0x357/0x4a0
[   19.883348][ T6440]        do_sys_open+0x87/0xd0
[   19.883955][ T6440]        do_syscall_64+0x34/0xb0
[   19.884585][ T6440]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   19.885399][ T6440]
[   19.885399][ T6440] other info that might help us debug this:
[   19.885399][ T6440]
[   19.886711][ T6440]  Possible unsafe locking scenario:
[   19.886711][ T6440]
[   19.887661][ T6440]        CPU0                    CPU1
[   19.888324][ T6440]        ----                    ----
[   19.889006][ T6440]   lock(&disk->open_mutex);
[   19.889618][ T6440]                                lock(mtd_table_mutex);
[   19.890506][ T6440]                                lock(&disk->open_mutex);
[   19.891413][ T6440]   lock(mtd_table_mutex);
[   19.891987][ T6440]
[   19.891987][ T6440]  *** DEADLOCK ***
[   19.891987][ T6440]
[   19.893010][ T6440] 1 lock held by systemd-udevd/6440:
[   19.893687][ T6440]  #0: ffff88800e29c118
(&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0xe0/0x370
[   19.894902][ T6440]
[   19.894902][ T6440] stack backtrace:
[   19.895622][ T6440] CPU: 0 PID: 6440 Comm: systemd-udevd Not
tainted 5.14.0+ #12
[   19.896548][ T6440] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[   19.898068][ T6440] Call Trace:
[   19.898474][ T6440]  dump_stack_lvl+0x8d/0xcf
[   19.899029][ T6440]  check_noncircular+0x105/0x120
[   19.899668][ T6440]  ? __lock_acquire+0x161f/0x1d60
[   19.900312][ T6440]  __lock_acquire+0x161f/0x1d60
[   19.901027][ T6440]  lock_acquire+0x1f9/0x340
[   19.901622][ T6440]  ? blktrans_open+0x4b/0x260
[   19.902201][ T6440]  __mutex_lock+0x98/0xa50
[   19.902850][ T6440]  ? blktrans_open+0x4b/0x260
[   19.903538][ T6440]  ? blktrans_dev_get.isra.10+0x63/0xa0
[   19.904345][ T6440]  ? blktrans_open+0x4b/0x260
[   19.905026][ T6440]  ? __mutex_unlock_slowpath+0x3c/0x280
[   19.905820][ T6440]  ? blktrans_release+0x120/0x120
[   19.906557][ T6440]  ? blktrans_open+0x4b/0x260
[   19.907248][ T6440]  blktrans_open+0x4b/0x260
[   19.907894][ T6440]  ? blktrans_release+0x120/0x120
[   19.908628][ T6440]  blkdev_get_whole+0x36/0xd0
[   19.909309][ T6440]  blkdev_get_by_dev+0x173/0x370
[   19.910031][ T6440]  ? blkdev_get_by_dev+0x370/0x370
[   19.910766][ T6440]  blkdev_open+0x95/0x100
[   19.911347][ T6440]  do_dentry_open+0x327/0x530
[   19.911956][ T6440]  ? may_open+0x104/0x1d0
[   19.912520][ T6440]  path_openat+0xcf3/0xe20
[   19.913152][ T6440]  do_filp_open+0xe3/0x170
[   19.913775][ T6440]  ? alloc_fd+0x1a1/0x290
[   19.914385][ T6440]  ? _find_next_bit+0x10a/0x130
[   19.915042][ T6440]  ? do_sys_openat2+0x357/0x4a0
[   19.915690][ T6440]  do_sys_openat2+0x357/0x4a0
[   19.916318][ T6440]  do_sys_open+0x87/0xd0
[   19.916886][ T6440]  do_syscall_64+0x34/0xb0
[   19.917481][ T6440]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   19.918263][ T6440] RIP: 0033:0x7f0db3d91840
[   19.918852][ T6440] Code: 73 01 c3 48 8b 0d 68 77 20 00 f7 d8 64 89
01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 bb 20 00 00 75 10 b8 02
00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e f6 ff ff
48 89 04 24
[   19.921462][ T6440] RSP: 002b:00007ffdba846478 EFLAGS: 00000246
ORIG_RAX: 0000000000000002
[   19.922620][ T6440] RAX: ffffffffffffffda RBX: 000055a6edb8f690
RCX: 00007f0db3d91840
[   19.923703][ T6440] RDX: 000055a6ebc31fe3 RSI: 00000000000a0800
RDI: 000055a6edb83070
[   19.924749][ T6440] RBP: 00007ffdba8465f0 R08: 000055a6ebc31670
R09: 0000000000000020
[   19.925794][ T6440] R10: 000055a6ebc31d0c R11: 0000000000000246
R12: 00007ffdba846540
[   19.926850][ T6440] R13: 000055a6edb86c20 R14: 0000000000000003
R15: 000000000000000e
