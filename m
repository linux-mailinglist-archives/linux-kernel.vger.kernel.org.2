Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954E3402207
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 04:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhIGBX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 21:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhIGBX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 21:23:26 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38AEC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 18:22:20 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id k17so4827049pls.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 18:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1OjYMBfrJ+RbM+HLiCrefAmha0Iu/xAS63cBbRMEl1M=;
        b=E6VqmzwBI2l4Li7em7hUtZAcpHnRKKypGdOHxr3PFkgYvBhZpRNbakMzm8wOVwSEa2
         CBRJvT5iAiXPnrTXpaQ+r6MNQwb21v2ibrQbY46AfWL4bflEgVjhBhesB00z3u0dsf2l
         eXQePF/s7cjWYAZMmUfA1HGWZapIkMa/dtd2awKkrud3zWOMpi/GpBnWU3+Op2q1zYB/
         pjsQX8bFMv74Dgdrb9TFmHQdqnDQEtADYT2d+6YAB9wlLwYagIniMY6e1UFpPIVK9MMD
         aUopMGiuWjO6E7eg3SXYoYfCqITbRc/UEzO5Hwo5f4L8UF5mX4qHfRKpFkCQs3Y4WVcB
         EbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1OjYMBfrJ+RbM+HLiCrefAmha0Iu/xAS63cBbRMEl1M=;
        b=B+rT041rXhSYEK2t+y/h66MQhz4AjbBbwYqVVZf/HmGdBJpEvTpwrMmNyju0sf/aoV
         vtRqQtvd64alvqAr4oi5Q5oO5xItm4Bu7iL1g+SScbFTqxhvNsqDNJ2+wJ1gaHZOlmXg
         39r2+efJhO8MJ8wx7QpNVjiKHM7jEvt4F/NOJHCP6APXOIe6QBbtseqywZuGcnmnsd6G
         5sotIUyS3dNw+dXXRXkU48TM+eEb1cyvy9PEjMK2bO8Qp7h8bHrp9ZkXmR35DVyrzXxY
         0+kJ095Yv/YbiDKxw9wWoZa4FsG68yG7T6eW8R6QMXtzHY/LLghhNo+i9byZD6mDCth/
         tqLw==
X-Gm-Message-State: AOAM533VDs906xUUv6bSnS09HGtTAmwS10EIXRGbuF1WfQ8mRYTqzJ3e
        fPpAbWbwPtvqZc+z8nXCczMkz7RrSn+87hZImgzSoNQEN+a4
X-Google-Smtp-Source: ABdhPJyIlqoFe5XHx6pXVzlLm+jy+pqDXUAsvg2ouTX0xgMA/fBzKTEtSQP9cQuXj31+jez/YC4P8XrhtcoUX1PGcqw=
X-Received: by 2002:a17:90b:124c:: with SMTP id gx12mr181692pjb.106.1630977734621;
 Mon, 06 Sep 2021 18:22:14 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Tue, 7 Sep 2021 09:22:03 +0800
Message-ID: <CACkBjsZfAZpOFeYC8mQ03r_JB_eF-dNMEkXf3LNji7_CgOCF2Q@mail.gmail.com>
Subject: WARNING in __init_work
To:     tj@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 27151f177827 Merge tag 'perf-tools-for-v5.15-2021-09-04'
git tree: upstream
console output:
https://drive.google.com/file/d/1M5oyA_IcWSDB2XpnoX8SDmKJA3JhKltz/view?usp=sharing
kernel config: https://drive.google.com/file/d/1ZMVJ2vNe0EiIEeWNVyrGb7hBdOG5Uj3e/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1AtDNXl8XEBfglKXsKsAH2NuXBcrp8Zp9/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1R_XD_cyMNS0Q_SGSqomRy_LIClOrd-gI/view?usp=sharing

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

ODEBUG: object ffffc9000073cda0 is NOT on stack ffffc90005f34000, but annotated.
------------[ cut here ]------------
WARNING: CPU: 2 PID: 27648 at lib/debugobjects.c:548
debug_object_is_on_stack lib/debugobjects.c:545 [inline]
WARNING: CPU: 2 PID: 27648 at lib/debugobjects.c:548
__debug_object_init+0x224/0x520 lib/debugobjects.c:607
Modules linked in:
CPU: 2 PID: 27648 Comm: syz-executor Not tainted 5.14.0+ #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:debug_object_is_on_stack lib/debugobjects.c:545 [inline]
RIP: 0010:__debug_object_init+0x224/0x520 lib/debugobjects.c:607
Code: 84 ca fe ff ff 83 c0 01 4c 89 f6 48 c7 c7 f8 b0 3c 85 89 05 7e
c2 56 06 65 48 8b 04 25 40 70 01 00 48 8b 50 20 e8 05 9b f5 01 <0f> 0b
e9 9e fe ff ff 89 05 87 4d e3 03 e9 c4 fe ff ff 48 c7 c7 e0
RSP: 0018:ffffc9000073ccf0 EFLAGS: 00010282
RAX: 0000000000000050 RBX: ffff88810cf2f398 RCX: 0000000000000100
RDX: 0000000000000000 RSI: ffffffff812cf85c RDI: 00000000ffffffff
RBP: ffffffff88868538 R08: 0000000000000000 R09: 0000000000000001
R10: ffffc9000073cc80 R11: 0000000000000005 R12: 0000000000000203
R13: 0000000000054450 R14: ffffc9000073cda0 R15: ffff88807dd264f0
FS:  0000000002ad0940(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005061ec CR3: 0000000100da5000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <IRQ>
 __init_work+0x3f/0x50 kernel/workqueue.c:519
 synchronize_rcu_expedited+0x26a/0x460 kernel/rcu/tree_exp.h:847
 bdi_remove_from_list mm/backing-dev.c:938 [inline]
 bdi_unregister+0x97/0x270 mm/backing-dev.c:946
 release_bdi+0x4a/0x70 mm/backing-dev.c:968
 kref_put include/linux/kref.h:65 [inline]
 bdi_put+0x47/0x70 mm/backing-dev.c:976
 bdev_free_inode+0x59/0xc0 fs/block_dev.c:819
 i_callback+0x24/0x50 fs/inode.c:224
 rcu_do_batch kernel/rcu/tree.c:2508 [inline]
 rcu_core+0x2d6/0x9f0 kernel/rcu/tree.c:2743
 __do_softirq+0xe9/0x561 kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu kernel/softirq.c:636 [inline]
 irq_exit_rcu+0xe2/0x100 kernel/softirq.c:648
 sysvec_apic_timer_interrupt+0x9e/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:__sanitizer_cov_trace_pc+0x37/0x60 kernel/kcov.c:197
Code: 65 48 8b 14 25 40 70 01 00 81 e1 00 01 00 00 a9 00 01 ff 00 74
0e 85 c9 74 35 8b 82 34 15 00 00 85 c0 74 2b 8b 82 10 15 00 00 <83> f8
02 75 20 48 8b 8a 18 15 00 00 8b 92 14 15 00 00 48 8b 01 48
RSP: 0018:ffffc90005f37b78 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000000000
RDX: ffff888109448000 RSI: ffffffff8212a28c RDI: ffffc90005f37d30
RBP: 0000000000000006 R08: 0000000000000d40 R09: ffff8880165fc5e0
R10: ffffc90005f37cd0 R11: 0000000000000003 R12: 0000000000000375
R13: ffff888107597b40 R14: ffffc90005f37d30 R15: ffff8880174b0ea0
 tomoyo_domain_quota_is_ok+0xac/0x150 security/tomoyo/util.c:1092
 tomoyo_supervisor+0x228/0x7f0 security/tomoyo/common.c:2089
 tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
 tomoyo_path_permission+0xa0/0xf0 security/tomoyo/file.c:587
 tomoyo_path_perm+0x22f/0x2d0 security/tomoyo/file.c:838
 tomoyo_path_symlink+0x43/0x70 security/tomoyo/tomoyo.c:199
 security_path_symlink+0x48/0x80 security/security.c:1164
 do_symlinkat+0x75/0x120 fs/namei.c:4274
 __do_sys_symlink fs/namei.c:4301 [inline]
 __se_sys_symlink fs/namei.c:4299 [inline]
 __x64_sys_symlink+0x3a/0x40 fs/namei.c:4299
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46a597
Code: 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66
2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 58 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd09085778 EFLAGS: 00000206 ORIG_RAX: 0000000000000058
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000046a597
RDX: 0000000000000000 RSI: 00000000004e40f9 RDI: 00007ffd09085810
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000014
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffd09085810 R15: 00007ffd090857cc
----------------
Code disassembly (best guess):
   0: 65 48 8b 14 25 40 70 mov    %gs:0x17040,%rdx
   7: 01 00
   9: 81 e1 00 01 00 00    and    $0x100,%ecx
   f: a9 00 01 ff 00        test   $0xff0100,%eax
  14: 74 0e                je     0x24
  16: 85 c9                test   %ecx,%ecx
  18: 74 35                je     0x4f
  1a: 8b 82 34 15 00 00    mov    0x1534(%rdx),%eax
  20: 85 c0                test   %eax,%eax
  22: 74 2b                je     0x4f
  24: 8b 82 10 15 00 00    mov    0x1510(%rdx),%eax
* 2a: 83 f8 02              cmp    $0x2,%eax <-- trapping instruction
  2d: 75 20                jne    0x4f
  2f: 48 8b 8a 18 15 00 00 mov    0x1518(%rdx),%rcx
  36: 8b 92 14 15 00 00    mov    0x1514(%rdx),%edx
  3c: 48 8b 01              mov    (%rcx),%rax
  3f: 48                    rex.W%
