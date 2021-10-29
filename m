Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A99F43FA7A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 12:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhJ2KKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 06:10:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231564AbhJ2KKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 06:10:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A07D661181
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 10:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635502095;
        bh=7AK4+4KRKsOLGj2bkq3YRpS6cxr9Gzc2W75P7IgTv+8=;
        h=From:Date:Subject:To:Cc:From;
        b=QBaXenEZhuVyfv1u9J6uPu1xBOt9UUv9dDBn09nJQfax6ACP6Lu2JAjl3HYG1O35m
         D00EblpabI5OOsnO2B1Ld7apCyrI6ru1VnDCUzISZm7o/kiemWToQwwS8YucYkRDLY
         aHk1KqhJcc1o24LhYFhfBcdsCVKQvWaN6lzXegOFDUyXDyCrH3QS6M0VoPRmDwJ2Eo
         HS3rGTTB3PwzI45JjpmhcdXc4Rjr3VGvdiABqUYvvwcuDd8Pvyp44xvIg3Dr0/dXts
         I2qrvzvpm6+LUklv50Q1VO1ZAruMXjFGg2Iuw42WDUkljbGJYnBGjafcw3m2UlvBWl
         tyt0KfOmiNG3Q==
Received: by mail-qk1-f181.google.com with SMTP id bk22so2060791qkb.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 03:08:15 -0700 (PDT)
X-Gm-Message-State: AOAM531nbUqsELhrPx1lsPGYdCA6Zbd7JhegdrCLVILMO89XJd+6knkX
        0wsqPWSxlTIoLp2JNqHDPDCU//TIm5Yl3oNwcG4=
X-Google-Smtp-Source: ABdhPJyq8EH12NFlOVcw+ooYVeyCmHeIzQ0uJBfeUo3Y4CldbPMMHHAPfLbvXQMPr/7O6tDJk3V4nP6/rb4oE0DQcyw=
X-Received: by 2002:a05:620a:e06:: with SMTP id y6mr8077281qkm.163.1635502094713;
 Fri, 29 Oct 2021 03:08:14 -0700 (PDT)
MIME-Version: 1.0
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 29 Oct 2021 11:07:38 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4AyrZ5erimDyO7mOVeppd5BeMw3CS=wGbzrMZrp56ktA@mail.gmail.com>
Message-ID: <CAL3q7H4AyrZ5erimDyO7mOVeppd5BeMw3CS=wGbzrMZrp56ktA@mail.gmail.com>
Subject: crash when bringing cpu online in kcompact
To:     Linux Memory Management List <linux-mm@kvack.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, tglx@linutronix.de,
        peterz@infradead.org, vincent.guittot@linaro.org, mingo@redhat.com,
        will@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have hit the following crash twice in about 1 week, with 5.15-rc6
(haven't tried rc7 yet):

[187594.825157] run fstests generic/650 at 2021-10-29 03:49:05
[187595.253906] BTRFS: device fsid
8173a0c8-39ff-47d5-bcd2-c2025739a5d9 devid 1 transid 5 /dev/sdb
scanned by mkfs.btrfs (1035376)
[187595.274644] BTRFS info (device sdb): flagging fs with big metadata feature
[187595.276361] BTRFS info (device sdb): disk space caching is enabled
[187595.277548] BTRFS info (device sdb): has skinny extents
[187595.284100] BTRFS info (device sdb): checking UUID tree
[187595.423672] smpboot: CPU 1 is now offline
[187598.017859] smpboot: CPU 4 is now offline
[187598.568422] smpboot: Booting Node 0 Processor 4 APIC 0x4
[187598.569900] kvm-clock: cpu 4, msr 3fd7fb101, secondary cpu clock
[187598.569996] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[187598.572900] kvm-guest: stealtime: cpu 4, msr 42d618400
[187598.573885]
================================================================================
[187598.575377] UBSAN: array-index-out-of-bounds in
kernel/locking/qspinlock.c:130:9
[187598.576677] index 7709 is out of range for type 'long unsigned int [512]'
[187598.577969] CPU: 4 PID: 32 Comm: cpuhp/4 Tainted: G      D W
  5.15.0-rc6-btrfs-next-102 #1
[187598.579655] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[187598.581825] Call Trace:
[187598.582306]  dump_stack_lvl+0x57/0x72
[187598.583078]  ubsan_epilogue+0x5/0x40
[187598.583856]  __ubsan_handle_out_of_bounds.cold+0x43/0x48
[187598.585115]  ? lock_acquire+0x1a0/0x310
[187598.585913]  __pv_queued_spin_lock_slowpath+0x2dc/0x300
[187598.586857]  do_raw_spin_lock+0x94/0xa0
[187598.587541]  _raw_spin_lock_irqsave+0x8f/0xa0
[187598.588372]  task_rq_lock+0x2b/0x160
[187598.589095]  set_cpus_allowed_ptr+0x2a/0x60
[187598.589936]  ? rcu_read_lock_sched_held+0x12/0x80
[187598.590900]  kcompactd_cpu_online+0xc0/0xe0
[187598.591484]  ? compaction_free+0x50/0x50
[187598.591993]  cpuhp_invoke_callback+0x14d/0x3c0
[187598.592569]  cpuhp_thread_fun+0x128/0x280
[187598.593086]  ? smpboot_thread_fn+0x2c/0x270
[187598.593671]  smpboot_thread_fn+0x1c4/0x270
[187598.594197]  ? smpboot_register_percpu_thread+0x140/0x140
[187598.594887]  kthread+0x155/0x180
[187598.595304]  ? set_kthread_struct+0x40/0x40
[187598.595837]  ret_from_fork+0x22/0x30
[187598.596329]
================================================================================
[187598.597448] BUG: unable to handle page fault for address: 000000000227fb3a
[187598.598360] #PF: supervisor write access in kernel mode
[187598.599197] #PF: error_code(0x0002) - not-present page
[187598.600109] PGD 0 P4D 0
[187598.600640] Oops: 0002 [#3] PREEMPT SMP DEBUG_PAGEALLOC PTI
[187598.601881] CPU: 4 PID: 32 Comm: cpuhp/4 Tainted: G      D W
  5.15.0-rc6-btrfs-next-102 #1
[187598.604101] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[187598.605863] RIP: 0010:__pv_queued_spin_lock_slowpath+0x1cd/0x300
[187598.606821] Code: 05 4d 63 f6 49 81 c5 00 b8 1e 00 49 81 fe ff 01
00 00 0f 87 12 01 00 00 4e 03 2c f5 c0 da 78 af 41 bf 01 00 00 00 4c
8d 73 14 <49> 89 5d 00 b8 00 80 00 00 eb 14 84 c0 75 09 41 0f b6 55 14
84 d2
[187598.610338] RSP: 0000:ffffb17f0014fd48 EFLAGS: 00010006
[187598.611406] RAX: ffff8bf300d44040 RBX: ffff8bf62d7eb800 RCX:
0000000000000000
[187598.612653] RDX: 0000000000000000 RSI: ffffffffaf717e22 RDI:
00000000ffffffff
[187598.614018] RBP: ffff8bf301934940 R08: ffffffffb5823ca0 R09:
0000000000000001
[187598.615455] R10: 0000000000000000 R11: 0000000000000001 R12:
0000000000140000
[187598.617206] R13: 000000000227fb3a R14: ffff8bf62d7eb814 R15:
0000000000000001
[187598.618457] FS:  0000000000000000(0000) GS:ffff8bf62d600000(0000)
knlGS:0000000000000000
[187598.619831] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[187598.620823] CR2: 000000000227fb3a CR3: 00000003fb212001 CR4:
0000000000370ee0
[187598.622212] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[187598.623517] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[187598.624826] Call Trace:
[187598.625298]  do_raw_spin_lock+0x94/0xa0
[187598.626020]  _raw_spin_lock_irqsave+0x8f/0xa0
[187598.626843]  task_rq_lock+0x2b/0x160
[187598.627500]  set_cpus_allowed_ptr+0x2a/0x60
[187598.628352]  ? rcu_read_lock_sched_held+0x12/0x80
[187598.629535]  kcompactd_cpu_online+0xc0/0xe0
[187598.630443]  ? compaction_free+0x50/0x50
[187598.631163]  cpuhp_invoke_callback+0x14d/0x3c0
[187598.632216]  cpuhp_thread_fun+0x128/0x280
[187598.633071]  ? smpboot_thread_fn+0x2c/0x270
[187598.633724]  smpboot_thread_fn+0x1c4/0x270
[187598.634255]  ? smpboot_register_percpu_thread+0x140/0x140
[187598.634966]  kthread+0x155/0x180
[187598.635389]  ? set_kthread_struct+0x40/0x40
[187598.636026]  ret_from_fork+0x22/0x30
[187598.636483] Modules linked in: overlay dm_zero btrfs dm_snapshot
dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio dm_log_writes
dm_dust dm_flakey dm_mod loop blake2b_generic xor raid6_pq libcrc32c
intel_rapl_msr intel_rapl_common bochs crct10dif_pclmul ghash_c>
[187598.647323] CR2: 000000000227fb3a
[187598.647925] ---[ end trace d185f1ce344425c8 ]---

It's triggered when running test case generic/650 from fstests. It's
hard to trigger here, it happened twice in about 1 week as mentioned
earlier.

Is this a known issue?

Thanks.
