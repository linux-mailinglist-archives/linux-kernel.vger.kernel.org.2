Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9786B4239FF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237826AbhJFIwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237825AbhJFIwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:52:11 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BA3C061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 01:50:17 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id h1so1733060pfv.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 01:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=LxKB3Z4BeksT4+ri8p3FaoCWWPOgr+gZjaYw4P86Xr8=;
        b=dUTpfb53JKjVD33nyU8vcf35bb/uLIKcCQYBkyduUKgBBcfNgfyoWKKX+0K18LZtot
         MKCkvUeWJvzstGoR7YQsM/vQ4wfLtISBXToQ5vV3V+zzPVK7f4K5pVE/alTdaHAldvFo
         Io+VoiyBSs7ChiaQa0842uveXr6ZZ5os1TXL6Z0Z9GSB3WF2Da3sB6RvKEGFLMIldPlP
         y0luWApPdl4tjULcODBqzwcis73qQGGZJdhEUfIbFHag3bLcgYDvscIcw7UTY1rzuuuM
         LP5BGGhvCBwcDcwUtr6YdzLlhMDIkltwBBEHaEDqS8siI8zdTr2u+//cE2407bgP5HML
         PdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LxKB3Z4BeksT4+ri8p3FaoCWWPOgr+gZjaYw4P86Xr8=;
        b=jcOUG58t3UatT2TTLPJMzMksicJ7mRYVEYgCFUg55r/mdaEx6jpPh6ajjN447vU1G2
         j6p0ef1xBnXIT2jjWMEAKtkc+nbQeQTc8KqoDwflroWDmSChwGX9U6eKyW5iN/oGafhG
         RgtK0/6ajpK8E/0oFsQpGFlbQdvkljM8eozYPALi/jlL2tTs2N6kMegpQZZLyLttFqHf
         qGOFaWZx5zPeuGSP09HF/B7ON9PlpJzNaymwSfxkPCqn+dAN/K98tnnaJsSE+0WdkMA5
         lEzqoBXvioWvYR0XxrRoMGsAVZCzJ/B8cd/uomIo06BqD8Bjy5+Dv3+v4oCfh/r5VotR
         BRhg==
X-Gm-Message-State: AOAM530k+0MS59JWMx/ci8hQDXJOffyfeuTlwmPlmb/mMh1lkgIYXrX0
        BXiM24RH9wj3gdSyJs6py+pVzSYnBEhKMNtDA0Pja2KCDBIsSA8=
X-Google-Smtp-Source: ABdhPJyoNc3LWpNUEkZVvte9LOhwYpwfuiD10xHcG/aqb9r50ClL/HDoTtO5p2AU8a3RMnCXreNY8w2lr0DQtmIdL4g=
X-Received: by 2002:a65:6389:: with SMTP id h9mr19768206pgv.83.1633510216787;
 Wed, 06 Oct 2021 01:50:16 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 6 Oct 2021 16:50:05 +0800
Message-ID: <CACkBjsbEcdArgkRDy0QVegPoDCUPNGDikPCa_hBprEQb-6TThQ@mail.gmail.com>
Subject: WARNING in __set_page_dirty
To:     rpeterso@redhat.com, agruenba@redhat.com, cluster-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        akpm@linux-foundation.org, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 0513e464f900 Merge tag 'perf-tools-fixes-for-v5.15-2021-09-27'
git tree: upstream
console output:
https://drive.google.com/file/d/1Tqtv5Qcx5LDPwnv7b2uJS2bilqpGfipG/view?usp=sharing
kernel config: https://drive.google.com/file/d/1Jqhc4DpCVE8X7d-XBdQnrMoQzifTG5ho/view?usp=sharing

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

------------[ cut here ]------------
WARNING: CPU: 0 PID: 19902 at ./include/linux/backing-dev.h:286
inode_to_wb include/linux/backing-dev.h:283 [inline]
WARNING: CPU: 0 PID: 19902 at ./include/linux/backing-dev.h:286
account_page_dirtied mm/page-writeback.c:2452 [inline]
WARNING: CPU: 0 PID: 19902 at ./include/linux/backing-dev.h:286
__set_page_dirty+0x50b/0x6e0 mm/page-writeback.c:2500
Modules linked in:
CPU: 0 PID: 19902 Comm: syz-executor Not tainted 5.15.0-rc3+ #21
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:inode_to_wb include/linux/backing-dev.h:283 [inline]
RIP: 0010:account_page_dirtied mm/page-writeback.c:2452 [inline]
RIP: 0010:__set_page_dirty+0x50b/0x6e0 mm/page-writeback.c:2500
Code: fc ff ff e8 d7 0a f1 ff 49 8b 87 a8 01 00 00 be ff ff ff ff 48
8d 78 70 e8 a2 42 de 02 85 c0 0f 85 18 fc ff ff e8 b5 0a f1 ff <0f> 0b
e9 0c fc ff ff e8 a9 0a f1 ff 48 89 ef e8 f1 ea d8 00 48 8b
RSP: 0018:ffffc90003e7bd08 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffea000083a140 RCX: 0000000000000000
RDX: ffff88810e1b8000 RSI: ffffffff814686ab RDI: ffffffff853ccbb6
RBP: ffff88800ce0bec8 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc90003e7bbb8 R11: 0000000000000003 R12: ffff8881100ecc98
R13: ffff8881045ac000 R14: 0000000000000293 R15: ffff88800ce0bec8
FS:  00007f72d08c8700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000003 CR3: 000000001a0a6000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
PKRU: 55555554
Call Trace:
 mark_buffer_dirty+0x1d4/0x2b0 fs/buffer.c:1108
 gfs2_unpin+0x74/0x460 fs/gfs2/lops.c:111
 buf_lo_after_commit+0x6b/0x80 fs/gfs2/lops.c:750
 lops_after_commit fs/gfs2/lops.h:49 [inline]
 gfs2_log_flush+0x9ba/0x1050 fs/gfs2/log.c:1108
 gfs2_sync_fs+0x3c/0x50 fs/gfs2/super.c:644
 sync_fs_one_sb+0x40/0x50 fs/sync.c:81
 iterate_supers+0xa7/0x130 fs/super.c:695
 ksys_sync+0x60/0xc0 fs/sync.c:116
 __do_sys_sync+0xa/0x10 fs/sync.c:125
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x200008ca
Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 98 4a 2a e9 2c b8 b6 4c 0f 05 <bf> 00
00 40 00 c4 a3 7b f0 c5 01 41 e2 e9 c4 22 e9 aa bb 3c 00 00
RSP: 002b:00007f72d08c7ba8 EFLAGS: 00000a83 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00000000200008ca
RDX: 0000000000004c01 RSI: 0000000000000003 RDI: 0000000000400000
RBP: 00000000000000eb R08: 0000000000000005 R09: 0000000000000006
R10: 0000000000000007 R11: 0000000000000a83 R12: 000000000000000b
R13: 000000000000000c R14: 000000000000000d R15: 00007ffe4f7c7800
