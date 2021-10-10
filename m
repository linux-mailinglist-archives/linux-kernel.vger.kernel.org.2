Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B748D428196
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 15:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhJJNz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 09:55:28 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:45034
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231842AbhJJNzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 09:55:24 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E60DE3FFFC
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 13:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633874003;
        bh=cWmRjV0wZ18cbgRf5UvNL+wnZ92ayCL+tBImhmYVm7c=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type;
        b=E+a7qzl82RPQ8zWGA8AK+LMAC2LtdyYIdbvWBS3moTFvZH+eY/Lu4OfJ83TqRHAk5
         qVB52b9AHFpunyq23nPq6qG8yr+J2C0liZbqYpWSDpCbDZKndhBm+WfkTDoVcVdQR3
         BPmrirUa3ZsTS6AVvg9L3mJCn2dUD+GZSgXlq9pDNtbe8lwHuYs9OkViYvF4xKFg4Y
         6/EatVRVmhQNeTywV/M/judBPp421rtp8KUmt01DGaD29WIWS2HLRHQqHmfEm4Q06t
         OO2w1jM0d35GGBRlyoh9JtGctLazb/9szqlZh2rxk7jnJGhYU+C241D6VsZ8xxUJws
         wKxDa5DWQIVWg==
Received: by mail-ed1-f70.google.com with SMTP id cy14-20020a0564021c8e00b003db8c9a6e30so1018618edb.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 06:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=cWmRjV0wZ18cbgRf5UvNL+wnZ92ayCL+tBImhmYVm7c=;
        b=CJMvU7iIzS/fUN4AWWatCRPp4/kZrf1S9cpfRhsnxUZvuVYFWRLVozF9uRP4/7zJh7
         5X/hwgfbDHzxruhSQZjDODewRH0Yf+tUWQGHFL1yduy0iVRaz6zsHTuYB/ZEUZz5phCi
         ERDrZ77AX9Pl4YP9cR0a6X14P2dYyWheGqsHqkWcY11JJwGMU203jPy2BiFQNLJBnh7n
         pkApUsus4Hyk1Vw0sh1CcCdIL5RLDxrzzMqM6O5RUNfaqI4Qu88cF9nWm8LvJm3K8FPm
         9O6Q0rX5Xe5nytJJIP7G3w1s8Dj06xve4ikQlHpjJ84Pw5wkCKifUsaw9DD6SfXoPz0U
         5GjA==
X-Gm-Message-State: AOAM53133N7MbBGUXARgV/41zggA/OizwAIy8yMm01byDb8lbgrGCqxp
        3DJCLA2sqtJqa93qAj77T6Ufd44HJnN/LUTpVrXqUqXZIiJ+1ijTP9ZSwDEI+xGHndLK64YIRFj
        GEwdfff16Lm3tO5VTkq4zVtVhAiYOeIS4i+ZxajZjvw==
X-Received: by 2002:a17:906:52d6:: with SMTP id w22mr16390609ejn.248.1633874003494;
        Sun, 10 Oct 2021 06:53:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcH08UaK3vfKrQhPsmuWveldePCR29myRYTOKsptitQTplwl7k/CZkug08Wt6ewRlkkSbhOA==
X-Received: by 2002:a17:906:52d6:: with SMTP id w22mr16390591ejn.248.1633874003248;
        Sun, 10 Oct 2021 06:53:23 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c1b6])
        by smtp.gmail.com with ESMTPSA id v13sm2111473ejh.62.2021.10.10.06.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 06:53:23 -0700 (PDT)
Date:   Sun, 10 Oct 2021 15:53:21 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: BUG: soft lockup in __kmalloc_node() with KFENCE enabled
Message-ID: <YWLwUUNuRrO7AxtM@arighi-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can systematically reproduce the following soft lockup w/ the latest
5.15-rc4 kernel (and all the 5.14, 5.13 and 5.12 kernels that I've
tested so far).

I've found this issue by running systemd autopkgtest (I'm using the
latest systemd in Ubuntu - 248.3-1ubuntu7 - but it should happen with
any recent version of systemd).

I'm running this test inside a local KVM instance and apparently systemd
is starting up its own KVM instances to run its tests, so the context is
a nested KVM scenario (even if I don't think the nested KVM part really
matters).

Here's the oops:

[   36.466565] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [udevadm:333]
[   36.466565] Modules linked in: btrfs blake2b_generic zstd_compress raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear psmouse floppy
[   36.466565] CPU: 0 PID: 333 Comm: udevadm Not tainted 5.15-rc4
[   36.466565] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
[   36.466565] RIP: 0010:__kmalloc_node+0xcf/0x370
[   36.466565] Code: 00 85 c0 74 20 49 8b 45 00 a8 03 0f 85 8e 02 00 00 65 48 ff 08 e8 01 7a e3 ff 45 31 ff e9 a3 00 00 00 45 31 ed 4d 85 f6 74 f0 <0f> 1f 44 00 00 48 c7 45 c8 00 00 00 00 4d 8b 06 65 4c 03 05 19 87
[   36.466565] RSP: 0018:ffffb512802c3aa8 EFLAGS: 00000286
[   36.466565] RAX: 0000000000000000 RBX: 0000000000000dc0 RCX: 0000000000000000
[   36.466565] RDX: 0000000000000000 RSI: 0000000000000dc0 RDI: ffff998601042700
[   36.466565] RBP: ffffb512802c3af0 R08: ffffeb90800b5c00 R09: 0000000000000000
[   36.466565] R10: 0000000000000293 R11: ffff99861e02f448 R12: 0000000000000dc0
[   36.466565] R13: 0000000000000000 R14: ffff998601042700 R15: ffffffff8b519c4d
[   36.466565] FS:  00007f08d0674d00(0000) GS:ffff99861e000000(0000) knlGS:0000000000000000
[   36.466565] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   36.466565] CR2: 00005622f86e3108 CR3: 00000000033c8000 CR4: 00000000000006f0
[   36.466565] Call Trace:
[   36.466565]  memcg_alloc_page_obj_cgroups+0x3d/0x90
[   36.466565]  allocate_slab+0xc1/0x440
[   36.466565]  ? get_any_partial+0x85/0x190
[   36.466565]  new_slab+0x3a/0x60
[   36.466565]  ___slab_alloc+0x562/0x6b0
[   36.466565]  ? __alloc_file+0x28/0xe0
[   36.466565]  ? __alloc_file+0x28/0xe0
[   36.466565]  ? dput+0x84/0x180
[   36.466565]  ? step_into+0x312/0x380
[   36.466565]  kmem_cache_alloc+0x299/0x2d0
[   36.466565]  ? __alloc_file+0x28/0xe0
[   36.466565]  __alloc_file+0x28/0xe0
[   36.466565]  alloc_empty_file+0x45/0xc0
[   36.466565]  path_openat+0x47/0x2b0
[   36.466565]  do_filp_open+0xb2/0x150
[   36.466565]  ? putname+0x55/0x60
[   36.466565]  ? __check_object_size.part.0+0x128/0x150
[   36.466565]  ? __check_object_size+0x19/0x20
[   36.466565]  ? alloc_fd+0x53/0x170
[   36.466565]  do_sys_openat2+0x9b/0x160
[   36.466565]  __x64_sys_openat+0x55/0x90
[   36.466565]  do_syscall_64+0x5c/0xc0
[   36.466565]  ? exit_to_user_mode_prepare+0x37/0xb0
[   36.466565]  ? syscall_exit_to_user_mode+0x27/0x50
[   36.466565]  ? __x64_sys_newfstatat+0x1c/0x20
[   36.466565]  ? do_syscall_64+0x69/0xc0
[   36.466565]  ? do_syscall_64+0x69/0xc0
[   36.466565]  ? do_syscall_64+0x69/0xc0
[   36.466565]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   36.466565] RIP: 0033:0x7f08d0c0466b
[   36.466565] Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 4c 24 28 64 48 2b 0c 25
[   36.466565] RSP: 002b:00007ffe10be08f0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[   36.466565] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f08d0c0466b
[   36.466565] RDX: 0000000000080000 RSI: 00007ffe10be0a70 RDI: 00000000ffffff9c
[   36.466565] RBP: 00007ffe10be0a70 R08: fefefefefefefeff R09: fefefeff716e6c71
[   36.466565] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
[   36.466565] R13: 00005622f86e2520 R14: 0000000000000003 R15: 00007ffe10be0990

It looks like this is pointing at asm_volatile_goto():

crash> gdb list *(__kmalloc_node+0xcf)
0xffffffff8b4f8e3f is in __kmalloc_node (/build/impish/arch/x86/include/asm/jump_label.h:27).
22      
23      #ifdef CONFIG_STACK_VALIDATION
24      
25      static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
26      {
27              asm_volatile_goto("1:"
28                      "jmp %l[l_yes] # objtool NOPs this \n\t"
29                      JUMP_TABLE_ENTRY
30                      : :  "i" (key), "i" (2 | branch) : : l_yes);
31      

And it seems that we're hitting an int3:

crash> bt 1
PID: 1      TASK: ffff998601248000  CPU: 3   COMMAND: "systemd"
    [exception RIP: poke_int3_handler+89]
    RIP: ffffffff8be6ac89  RSP: ffffb51280013b80  RFLAGS: 00000046
    RAX: 000000008c0010a7  RBX: 0000000000000000  RCX: ffffb51280013ba8
    RDX: 0000000000000000  RSI: ffffffff8c000a99  RDI: ffffb51280013ba8
    RBP: ffffb51280013b98   R8: 0000000000000000   R9: 0000000000000000
    R10: 0000000000000000  R11: 0000000000000000  R12: ffffb51280013ba8
    R13: 0000000000000000  R14: 0000000000000000  R15: 0000000000000000
    CS: 0010  SS: 0018
 #0 [ffffb51280013b80] exc_int3 at ffffffff8be69e80
 #1 [ffffb51280013ba0] asm_exc_int3 at ffffffff8c000aa1
 #2 [ffffb51280013c28] __kmalloc_node at ffffffff8b4f8e40
 #3 [ffffb51280013c80] __kmalloc_node at ffffffff8b4f8e16
 #4 [ffffb51280013cd8] kvmalloc_node at ffffffff8b4885c8
 #5 [ffffb51280013d00] seq_read_iter at ffffffff8b56139c
 #6 [ffffb51280013d60] seq_read at ffffffff8b561585
 #7 [ffffb51280013de8] vfs_read at ffffffff8b531b0f
 #8 [ffffb51280013e28] ksys_read at ffffffff8b5321d7
 #9 [ffffb51280013e68] __x64_sys_read at ffffffff8b532269
#10 [ffffb51280013e78] do_syscall_64 at ffffffff8be6900c
#11 [ffffb51280013f50] entry_SYSCALL_64_after_hwframe at ffffffff8c00007c
    RIP: 00007fc076f2e912  RSP: 00007ffde04ba888  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 000055e3b310bc30  RCX: 00007fc076f2e912
    RDX: 0000000000000400  RSI: 000055e3b31415e0  RDI: 0000000000000029
    RBP: 00007fc077031560   R8: 0000000000000029   R9: 0000000000000050
    R10: 0000000000001000  R11: 0000000000000246  R12: 00007fc07679a6c0
    R13: 0000000000000d68  R14: 00007fc077030960  R15: 0000000000000d68
    ORIG_RAX: 0000000000000000  CS: 0033  SS: 002b

If I disable CONFIG_KFENCE the soft lockup doesn't happen and systemd
autotest completes just fine.

We've decided to disable KFENCE in the latest Ubuntu Impish kernel
(5.13) for now, because of this issue, but I'm still investigating
trying to better understand the problem.

Any hint / suggestion?

Thanks,
-Andrea
