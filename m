Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED802423A47
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 11:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbhJFJNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 05:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhJFJNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 05:13:39 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BBAC061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 02:11:47 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 75so1939304pga.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 02:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0v44c70ZP++cd9xhpvdbFUT58ee9eGDACbbgd3ZMrMM=;
        b=MZ3g/otCXMZhQ4UGjJNaTNO4IVwNhB+41mtV12Y3pJyeB2Zb51Khcl8pLLtHhO1DZk
         RXiZ6lb2wxKh0gB48kt2kQwAC1enEQM1l1XIoOQl3SPfLhj1vsu6XZXn9SWD+oojZe3w
         JBTHlyyfiMTEtWWSIyLNIy/bUJxd8QrUwkDV0zg6A0XzfwqKLTmUoFHky1OaPR0sTw3m
         xhcKuwjFE9EpAl9Sw3lFLMxhAmicGk6c6mpHPctiAriKKhgo9t2hybAiBCzzmjH+31hR
         eSUfgrZWdUJp7UqPQBlBIe3QZel9Wna75T/kisOhDGdb4ju0GuF/kZri5X7IDxPKXx91
         prYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0v44c70ZP++cd9xhpvdbFUT58ee9eGDACbbgd3ZMrMM=;
        b=iaD0RBkPNZhoSN19/pq6MOhsd1SkoZdERpNUU9MdJGa/4ag7izNIiuXcjLJEHK5hzD
         IXVjgPNLGywQkQv4h3eZyxRZLexWo8RbsQ37F59K0w43+7/B/g9NKSfhKp6Z57QabX+D
         xAolwfc36ZQywguhHf/FZrus1+XzV7n83x9M4146RDGbYcsHMOOazvOaU/r4HdcTdL9D
         1buZ1NAK7hjmV+prwZKglH/uuVdmbNYnFvLG4ACqFmc3UrOs6n1D9TVKfh2pz9VzTq6m
         Yr3yA6ia2HfvfGDQMyoU7EHb3J+tgGkf2cRP/pQs7GBTR8tSKfwqcQXPFt/7q6o/iUEa
         OITw==
X-Gm-Message-State: AOAM533AB6YRYedvhtF/CPnCAI3OOln2SUqRNoLEIVWGIVGKkdcl+NnZ
        PRa6vdUYq1+UWo/Tz34n110zbiOM00Ni1p7zJg==
X-Google-Smtp-Source: ABdhPJxDb9BBhKcXVnHlko/OerMBSW5PXQPr7iw+358D/v9aAZXdERXiHeG+1M9xmxL5fkLtG4ykg1gi63Ry7WZ+0mA=
X-Received: by 2002:a63:594a:: with SMTP id j10mr19658082pgm.205.1633511507166;
 Wed, 06 Oct 2021 02:11:47 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 6 Oct 2021 17:11:36 +0800
Message-ID: <CACkBjsbFasKU6rX6=r+EJFncL5V310eo3rDTojGggUmea-LZww@mail.gmail.com>
Subject: BUG: unable to handle kernel paging request in drm_fb_helper_damage_work
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 42d43c92fc57  Merge branch 'for-linus'
git tree: upstream
console output:
https://drive.google.com/file/d/1TXbZJ5Reefwpvr_wk3N1rGVKIMnF6fbP/view?usp=sharing
kernel config: https://drive.google.com/file/d/15vWoQRbJuuMu4ovWhUm1h4SrHyNwK8im/view?usp=sharing

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

BUG: unable to handle page fault for address: ffffc900085e8070
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 10c00067 P4D 10c00067 PUD 10dbc067 PMD 1c94d067 PTE 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 3 PID: 33 Comm: kworker/3:0 Not tainted 5.15.0-rc3+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: events drm_fb_helper_damage_work
RIP: 0010:rep_movs arch/x86/lib/iomem.c:12 [inline]
RIP: 0010:memcpy_toio+0x83/0xe0 arch/x86/lib/iomem.c:57
Code: 7a fd 49 89 dd 31 ff 41 83 e5 02 4c 89 ee e8 44 73 7a fd 4d 85
ed 75 2e e8 ba 71 7a fd 48 89 e9 48 89 df 4c 89 e6 48 c1 e9 02 <f3> a5
40 f6 c5 02 74 02 66 a5 40 f6 c5 01 74 01 a4 5b 5d 41 5c 41
RSP: 0018:ffffc90000887be0 EFLAGS: 00010212
RAX: 0000000000000000 RBX: ffffc900085e8070 RCX: 000000000000094c
RDX: 0000000000000000 RSI: ffffc90006599070 RDI: ffffc900085e8070
RBP: 0000000000002530 R08: ffffffff83fbd9c6 R09: 0000000000000000
R10: 0000000000000007 R11: fffff52000110f56 R12: ffffc90006599070
R13: 0000000000000000 R14: ffff888019db0140 R15: ffffc90006599070
FS:  0000000000000000(0000) GS:ffff888135d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900085e8070 CR3: 000000001d3fd000 CR4: 0000000000350ee0
Call Trace:
 dma_buf_map_memcpy_to ./include/linux/dma-buf-map.h:245 [inline]
 drm_fb_helper_damage_blit_real drivers/gpu/drm/drm_fb_helper.c:388 [inline]
 drm_fb_helper_damage_blit drivers/gpu/drm/drm_fb_helper.c:419 [inline]
 drm_fb_helper_damage_work+0x76d/0xb00 drivers/gpu/drm/drm_fb_helper.c:450
 process_one_work+0x9df/0x16d0 kernel/workqueue.c:2297
 worker_thread+0x90/0xed0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
CR2: ffffc900085e8070
---[ end trace 000e7483a76d6bd7 ]---
RIP: 0010:rep_movs arch/x86/lib/iomem.c:12 [inline]
RIP: 0010:memcpy_toio+0x83/0xe0 arch/x86/lib/iomem.c:57
Code: 7a fd 49 89 dd 31 ff 41 83 e5 02 4c 89 ee e8 44 73 7a fd 4d 85
ed 75 2e e8 ba 71 7a fd 48 89 e9 48 89 df 4c 89 e6 48 c1 e9 02 <f3> a5
40 f6 c5 02 74 02 66 a5 40 f6 c5 01 74 01 a4 5b 5d 41 5c 41
RSP: 0018:ffffc90000887be0 EFLAGS: 00010212
RAX: 0000000000000000 RBX: ffffc900085e8070 RCX: 000000000000094c
RDX: 0000000000000000 RSI: ffffc90006599070 RDI: ffffc900085e8070
RBP: 0000000000002530 R08: ffffffff83fbd9c6 R09: 0000000000000000
R10: 0000000000000007 R11: fffff52000110f56 R12: ffffc90006599070
R13: 0000000000000000 R14: ffff888019db0140 R15: ffffc90006599070
FS:  0000000000000000(0000) GS:ffff888135d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900085e8070 CR3: 000000001d3fd000 CR4: 0000000000350ee0
----------------
Code disassembly (best guess):
   0: 7a fd                jp     0xffffffff
   2: 49 89 dd              mov    %rbx,%r13
   5: 31 ff                xor    %edi,%edi
   7: 41 83 e5 02          and    $0x2,%r13d
   b: 4c 89 ee              mov    %r13,%rsi
   e: e8 44 73 7a fd        callq  0xfd7a7357
  13: 4d 85 ed              test   %r13,%r13
  16: 75 2e                jne    0x46
  18: e8 ba 71 7a fd        callq  0xfd7a71d7
  1d: 48 89 e9              mov    %rbp,%rcx
  20: 48 89 df              mov    %rbx,%rdi
  23: 4c 89 e6              mov    %r12,%rsi
  26: 48 c1 e9 02          shr    $0x2,%rcx
* 2a: f3 a5                rep movsl %ds:(%rsi),%es:(%rdi) <--
trapping instruction
  2c: 40 f6 c5 02          test   $0x2,%bpl
  30: 74 02                je     0x34
  32: 66 a5                movsw  %ds:(%rsi),%es:(%rdi)
  34: 40 f6 c5 01          test   $0x1,%bpl
  38: 74 01                je     0x3b
  3a: a4                    movsb  %ds:(%rsi),%es:(%rdi)
  3b: 5b                    pop    %rbx
  3c: 5d                    pop    %rbp
  3d: 41 5c                pop    %r12
  3f: 41                    rex.B
