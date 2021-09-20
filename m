Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115D441150D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhITM4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbhITM4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:56:48 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4DBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:55:22 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id w11so1451612plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=F7gypz6XHUK92mVJg5Hzbel+8502bgiOj6M77BMyRoM=;
        b=EEV9bjgGaJNTFb9d0YFeIPYkdF/00PYCRy7xHUpSuMm9sgCMe+uiNU82YTn/H6ZOkQ
         TdI9lQDjfBuFvZMP5Pf03O9qu1aTTNldyQUD+Y+VzJ82xGyk4DlnRnG25pMHF9tUJCSj
         8RJ7/c3DJPevUYrZFhu44TFq9So0EWMAwQ81ebRWTU3E/xjJu9LxdYpl8B8csxTG60tv
         HyE24onSXfIGioVlyLVEG9ihrvh9TJ3hzYjg5lP6kZRhnXeju5/CqMKz05C8sunoc4Kc
         vx6zIN2f2HejnFPmkCpmcWhKemqVp08BzAOQv21rEbdgjhVI6n1NCAyVfQYt0nzCB7zK
         Piyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=F7gypz6XHUK92mVJg5Hzbel+8502bgiOj6M77BMyRoM=;
        b=nsIK5CEFQqBRFPzN/3IEdDzx5SPZUShHZ2gxHm+6tjKSegCsSJ+y9360A6KUqiq59u
         UfoxCTJNvK/ydJFt333+9g0IzrT4L2f2yddRfNJ5XnLbrez5NoOnHSBBnJ86GgSR1gtz
         Bip8KHbE4EczzMOawIkn/zuHLCRAdKy7MsmPNPlzmeiidEe5wIBM/BC5PE3GGdT24bW8
         Pp6SBoTOM8SgN4W8kwAwXojHvusOJCmHG8ncxLC4kBegnSWU/WhkJQ7ic+Zjm1TTDebW
         //qAlFZJOPvEInSQnsk8oxCc3zgTgQ5mSvzxWONZWuw+207VbzP6V8ghDM3LQblakcwj
         OdBw==
X-Gm-Message-State: AOAM533scXsDl6CiRI+56iXtXKnGlknH+zaGta3lgq0AscedL22Ibc91
        KAr6pZXtr34wKsLs6be+1NuP7JY1F2EMXNYyHw==
X-Google-Smtp-Source: ABdhPJxJiE6+5YsjDfAfy5C176h+haGd9avQ17QXk3eujPjmkMRE7Oveslai+whaDWElsP/DnbU74+DzrEodD6DUa3A=
X-Received: by 2002:a17:90b:3447:: with SMTP id lj7mr7541082pjb.112.1632142521541;
 Mon, 20 Sep 2021 05:55:21 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Mon, 20 Sep 2021 20:55:28 +0800
Message-ID: <CACkBjsYVWiSa9KYETi4aT2-0C=xheWjYA9bgoMgqa3y0XzNLMw@mail.gmail.com>
Subject: BUG: unable to handle kernel paging request in drm_fb_helper_damage_work
To:     bp@alien8.de, hpa@zytor.com, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 4357f03d6611 Merge tag 'pm-5.15-rc2
git tree: upstream
console output:
https://drive.google.com/file/d/13NUxvBLIswpoS8NOOAaq9PjOKgTYN19K/view?usp=sharing
kernel config: https://drive.google.com/file/d/1HKZtF_s3l6PL3OoQbNq_ei9CdBus-Tz0/view?usp=sharing

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

BUG: unable to handle page fault for address: ffffc90003d79000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 8c00067 P4D 8c00067 PUD 8d63067 PMD 104409067 PTE 0
Oops: 0000 [#1] PREEMPT SMP
CPU: 2 PID: 3032 Comm: kworker/2:2 Not tainted 5.15.0-rc1+ #19
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: events drm_fb_helper_damage_work
RIP: 0010:rep_movs arch/x86/lib/iomem.c:12 [inline]
RIP: 0010:memcpy_toio+0x48/0xa0 arch/x86/lib/iomem.c:57
Code: 01 75 41 e8 4a 0d 04 ff 49 83 fc 01 76 0a e8 3f 0d 04 ff f6 c3
02 75 44 e8 35 0d 04 ff 4c 89 e1 48 89 df 48 89 ee 48 c1 e9 02 <f3> a5
41 f6 c4 02 74 02 66 a5 41 f6 c4 01 74 01 a4 5b 5d 41 5c e9
RSP: 0018:ffffc9000088fda8 EFLAGS: 00010206
RAX: 0000000000000000 RBX: ffffc90005aff000 RCX: 0000000000000100
RDX: ffff88800f132240 RSI: ffffc90003d79000 RDI: ffffc90005b00000
RBP: ffffc90003d78000 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc9000088fdc8 R11: 0000000000000004 R12: 0000000000001400
R13: ffff888101fc7000 R14: 00000000000002ff R15: ffffc90003d78000
FS:  0000000000000000(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90003d79000 CR3: 000000010ea77000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 dma_buf_map_memcpy_to include/linux/dma-buf-map.h:245 [inline]
 drm_fb_helper_damage_blit_real drivers/gpu/drm/drm_fb_helper.c:388 [inline]
 drm_fb_helper_damage_blit drivers/gpu/drm/drm_fb_helper.c:419 [inline]
 drm_fb_helper_damage_work+0x30e/0x380 drivers/gpu/drm/drm_fb_helper.c:450
 process_one_work+0x359/0x850 kernel/workqueue.c:2297
 worker_thread+0x41/0x4d0 kernel/workqueue.c:2444
 kthread+0x178/0x1b0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
CR2: ffffc90003d79000
---[ end trace e1f0ecb0884517c4 ]---
RIP: 0010:rep_movs arch/x86/lib/iomem.c:12 [inline]
RIP: 0010:memcpy_toio+0x48/0xa0 arch/x86/lib/iomem.c:57
Code: 01 75 41 e8 4a 0d 04 ff 49 83 fc 01 76 0a e8 3f 0d 04 ff f6 c3
02 75 44 e8 35 0d 04 ff 4c 89 e1 48 89 df 48 89 ee 48 c1 e9 02 <f3> a5
41 f6 c4 02 74 02 66 a5 41 f6 c4 01 74 01 a4 5b 5d 41 5c e9
RSP: 0018:ffffc9000088fda8 EFLAGS: 00010206
RAX: 0000000000000000 RBX: ffffc90005aff000 RCX: 0000000000000100
RDX: ffff88800f132240 RSI: ffffc90003d79000 RDI: ffffc90005b00000
RBP: ffffc90003d78000 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc9000088fdc8 R11: 0000000000000004 R12: 0000000000001400
R13: ffff888101fc7000 R14: 00000000000002ff R15: ffffc90003d78000
FS:  0000000000000000(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90003d79000 CR3: 000000010ea77000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
----------------
Code disassembly (best guess):
   0:   01 75 41                add    %esi,0x41(%rbp)
   3:   e8 4a 0d 04 ff          callq  0xff040d52
   8:   49 83 fc 01             cmp    $0x1,%r12
   c:   76 0a                   jbe    0x18
   e:   e8 3f 0d 04 ff          callq  0xff040d52
  13:   f6 c3 02                test   $0x2,%bl
  16:   75 44                   jne    0x5c
  18:   e8 35 0d 04 ff          callq  0xff040d52
  1d:   4c 89 e1                mov    %r12,%rcx
  20:   48 89 df                mov    %rbx,%rdi
  23:   48 89 ee                mov    %rbp,%rsi
  26:   48 c1 e9 02             shr    $0x2,%rcx
* 2a:   f3 a5                   rep movsl %ds:(%rsi),%es:(%rdi) <--
trapping instruction
  2c:   41 f6 c4 02             test   $0x2,%r12b
  30:   74 02                   je     0x34
  32:   66 a5                   movsw  %ds:(%rsi),%es:(%rdi)
  34:   41 f6 c4 01             test   $0x1,%r12b
  38:   74 01                   je     0x3b
  3a:   a4                      movsb  %ds:(%rsi),%es:(%rdi)
  3b:   5b                      pop    %rbx
  3c:   5d                      pop    %rbp
  3d:   41 5c                   pop    %r12
  3f:   e9                      .byte 0xe9
