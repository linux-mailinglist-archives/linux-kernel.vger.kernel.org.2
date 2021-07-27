Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104BB3D810A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 23:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhG0VNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 17:13:54 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:40678
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231339AbhG0VNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 17:13:52 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AHaTICaNwD51e+MBcTtijsMiBIKoaSvp037Dk?=
 =?us-ascii?q?7SxMoDhuA6+lfqGV/MjzuiWetN98YhsdcLO7WZVoI0mzyXcd2+B4AV7IZmbbUQ?=
 =?us-ascii?q?WTQb1f0Q=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,274,1620684000"; 
   d="scan'208";a="389126479"
Received: from xanadu.blop.info ([178.79.145.134])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 23:13:50 +0200
Date:   Tue, 27 Jul 2021 23:13:43 +0200
From:   Lucas Nussbaum <lucas.nussbaum@inria.fr>
To:     linux-kernel@vger.kernel.org
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Gary Hook <gary.hook@amd.com>
Subject: [BUG] crypto: ccp: random crashes after kexec on AMD with PSP since
 commit 97f9ac3d
Message-ID: <YQB3B1RMhPqcrqzW@xanadu.blop.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On several AMD systems, we see random crashes after kexec, during the
boot of the new system (typically 1 out of 5 boots ends up with a
crash).

According to git bisect, the regression was introduced by commit
97f9ac3d ("crypto: ccp - Add support for SEV-ES to the PSP driver"),
included since 5.8-rc1. 5.14-rc3 is still affected.

Removing the 'ccp' module before kexec makes the problem disappear.

It is worth noting that there was prior work about getting kexec to
work with PSP/SEV (commit f8903b3e, "crypto: ccp - fix the SEV probe in
kexec boot path").

I can help test patches if needed. If this gets fixed, it would be
fantastic if the fix was backported to 5.10.

Here are some crash logs. As you can see, the kernel seems to crash at
various places.

[   14.724277] BUG: kernel NULL pointer dereference, address: 00000000000002d7
[   14.731260] #PF: supervisor read access in kernel mode
[   14.736408] #PF: error_code(0x0000) - not-present page
[   14.741556] PGD 0 P4D 0 
[   14.744104] Oops: 0000 [#1] SMP NOPTI
[   14.747779] CPU: 8 PID: 1 Comm: systemd Tainted: G            E     5.14.0-rc3 #10
[   14.755356] Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.11.4 09/26/2019
[   14.763015] RIP: 0010:cgroup_rstat_flush_locked+0x7d/0x280
[   14.768516] Code: aa b9 92 4c 89 f7 4c 89 74 24 08 e8 ad df 75 00 48 8b 04 24 48 89 c1 48 85 c0 0f 84 9d 01 00 00 4b 8b 54 e5 00 eb 03 4c 89 f1 <48> 8b 81 d8 02 00 00 48 01 d0 4c 8b 70 30 4c 39 f1 75 ea 4c 8b 48
[   14.787277] RSP: 0018:ffffb9c440107d28 EFLAGS: 00010093
[   14.792505] RAX: ffffd9c02ee63418 RBX: ffff986507051000 RCX: ffffffffffffffff
[   14.799640] RDX: ffff98806fc40000 RSI: 0000000000000000 RDI: ffff98806fc5f764
[   14.806779] RBP: 000000000000004e R08: 0000000000000000 R09: 0000000000000000
[   14.813914] R10: 000000000000000e R11: 0000000000000000 R12: 000000000000004e
[   14.821055] R13: ffffffff92b9aa80 R14: ffffffffffffffff R15: ffff9865072838e8
[   14.828196] FS:  00007f01041a8900(0000) GS:ffff98686f240000(0000) knlGS:0000000000000000
[   14.836294] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   14.842043] CR2: 00000000000002d7 CR3: 00000001073c4000 CR4: 00000000003506e0
[   14.849178] Call Trace:
[   14.851637]  cgroup_base_stat_cputime_show+0x48/0x180
[   14.856703]  cpu_stat_show+0x47/0x110
[   14.860374]  seq_read_iter+0x19e/0x410
[   14.864139]  new_sync_read+0x118/0x1a0
[   14.867901]  vfs_read+0xf1/0x180
[   14.871139]  ksys_read+0x59/0xd0
[   14.874380]  do_syscall_64+0x3a/0xb0
[   14.877970]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   14.883030] RIP: 0033:0x7f0104975e8e
[   14.886617] Code: c0 e9 b6 fe ff ff 50 48 8d 3d 6e 18 0a 00 e8 b9 e7 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
[   14.905376] RSP: 002b:00007ffce2e6f088 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   14.912949] RAX: ffffffffffffffda RBX: 000055e287096200 RCX: 00007f0104975e8e
[   14.920089] RDX: 0000000000001000 RSI: 000055e28717ff80 RDI: 000000000000002c
[   14.927231] RBP: 00007f0104a474a0 R08: 000000000000002c R09: 00007f0104a45be0
[   14.934372] R10: 000000000000006f R11: 0000000000000246 R12: 0000000000000800
[   14.941510] R13: 00007f0104a468a0 R14: 0000000000000d68 R15: 0000000000000d68
[   14.948647] Modules linked in: fuse(E) drm(E) configfs(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc32c_generic(E) crc16(E) mbcache(E) jbd2(E) sd_mod(E) t10_pi(E) crc_t10dif(E) crct10dif_generic(E) ahci(E) tg3(E) libahci(E) xhci_pci(E) crct10dif_pclmul(E) i40e(E) crct10dif_common(E) libphy(E) crc32_pclmul(E) xhci_hcd(E) ptp(E) libata(E) megaraid_sas(E) crc32c_intel(E) i2c_piix4(E) scsi_mod(E) usbcore(E) pps_core(E)
[   14.985828] CR2: 00000000000002d7
[   14.989217] ---[ end trace 2ba942b3a27eeb4b ]---
[   14.993840] RIP: 0010:cgroup_rstat_flush_locked+0x7d/0x280
[   14.999336] Code: aa b9 92 4c 89 f7 4c 89 74 24 08 e8 ad df 75 00 48 8b 04 24 48 89 c1 48 85 c0 0f 84 9d 01 00 00 4b 8b 54 e5 00 eb 03 4c 89 f1 <48> 8b 81 d8 02 00 00 48 01 d0 4c 8b 70 30 4c 39 f1 75 ea 4c 8b 48
[   15.018093] RSP: 0018:ffffb9c440107d28 EFLAGS: 00010093
[   15.023323] RAX: ffffd9c02ee63418 RBX: ffff986507051000 RCX: ffffffffffffffff
[   15.030457] RDX: ffff98806fc40000 RSI: 0000000000000000 RDI: ffff98806fc5f764
[   15.037589] RBP: 000000000000004e R08: 0000000000000000 R09: 0000000000000000
[   15.044723] R10: 000000000000000e R11: 0000000000000000 R12: 000000000000004e
[   15.051864] R13: ffffffff92b9aa80 R14: ffffffffffffffff R15: ffff9865072838e8
[   15.058996] FS:  00007f01041a8900(0000) GS:ffff98686f240000(0000) knlGS:0000000000000000
[   15.067083] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.072838] CR2: 00000000000002d7 CR3: 00000001073c4000 CR4: 00000000003506e0
[   15.079983] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
[   15.088425] Kernel Offset: 0x10a00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   15.099267] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---


[    9.559655] list_add corruption. prev->next should be next (ffffa10269ea03c0), but was ffffffffffffffff. (prev=ffffa0f449a34408).
[    9.571352] ------------[ cut here ]------------
[    9.575985] kernel BUG at lib/list_debug.c:28!
[    9.580456] invalid opcode: 0000 [#1] SMP NOPTI
[    9.584441] CPU: 25 PID: 144 Comm: cpuhp/25 Not tainted 5.14.0-rc3 #10
[    9.584441] Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.11.4 09/26/2019
[    9.584441] RIP: 0010:__list_add_valid.cold.0+0x26/0x28
[    9.584441] Code: db 3f bf ff 48 89 d1 48 c7 c7 f8 96 73 8d 48 89 c2 e8 3d 1d ff ff 0f 0b 48 89 c1 4c 89 c6 48 c7 c7 50 97 73 8d e8 29 1d ff ff <0f> 0b 48 89 fe 48 89 c2 48 c7 c7 e0 97 73 8d e8 15 1d ff ff 0f 0b
[    9.584441] RSP: 0018:ffffc2aac6f77c50 EFLAGS: 00010246
[    9.584441] RAX: 0000000000000075 RBX: ffffa103c4d0d000 RCX: 0000000000000000
[    9.584441] RDX: 0000000000000000 RSI: 00000000ffff7fff RDI: ffffffff8e322800
[    9.584441] RBP: ffffa107afad77e8 R08: 0000000000000000 R09: c0000000ffff7fff
[    9.584441] R10: 0000000000000001 R11: ffffc2aac6f77a68 R12: ffffa10269ea03c0
[    9.584441] R13: ffffa0f449a34408 R14: ffffa103c4d0d008 R15: ffffa107afad77e8
[    9.584441] FS:  0000000000000000(0000) GS:ffffa107afac0000(0000) knlGS:0000000000000000
[    9.584441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.584441] CR2: 0000000000000000 CR3: 0000000f2960a000 CR4: 00000000003506e0
[    9.584441] Call Trace:
[    9.584441]  kobject_add_internal+0x7e/0x280
[    9.584441]  kobject_add+0x7d/0xb0
[    9.584441]  ? __slab_alloc+0x1c/0x40
[    9.584441]  ? kmem_cache_alloc_trace+0x2cd/0x3d0
[    9.584441]  device_add+0x11a/0x940
[    9.584441]  ? cpu_device_create+0x6c/0x100
[    9.584441]  cpu_device_create+0xe7/0x100
[    9.584441]  ? subcaches_store+0xa0/0xa0
[    9.584441]  ? __cond_resched+0x15/0x30
[    9.584441]  cacheinfo_cpu_online+0x221/0x420
[    9.584441]  ? cache_setup_acpi+0x40/0x40
[    9.584441]  cpuhp_invoke_callback+0x105/0x400
[    9.584441]  cpuhp_thread_fun+0x8e/0x160
[    9.584441]  smpboot_thread_fn+0xb5/0x150
[    9.584441]  ? sort_range+0x20/0x20
[    9.584441]  kthread+0x11a/0x140
[    9.584441]  ? set_kthread_struct+0x40/0x40
[    9.584441]  ret_from_fork+0x22/0x30
[    9.584441] Modules linked in:
[    9.761630] ---[ end trace f6b243824a565635 ]---
[    9.766265] RIP: 0010:__list_add_valid.cold.0+0x26/0x28
[    9.771504] Code: db 3f bf ff 48 89 d1 48 c7 c7 f8 96 73 8d 48 89 c2 e8 3d 1d ff ff 0f 0b 48 89 c1 4c 89 c6 48 c7 c7 50 97 73 8d e8 29 1d ff ff <0f> 0b 48 89 fe 48 89 c2 48 c7 c7 e0 97 73 8d e8 15 1d ff ff 0f 0b
[    9.790267] RSP: 0018:ffffc2aac6f77c50 EFLAGS: 00010246
[    9.795502] RAX: 0000000000000075 RBX: ffffa103c4d0d000 RCX: 0000000000000000
[    9.802646] RDX: 0000000000000000 RSI: 00000000ffff7fff RDI: ffffffff8e322800
[    9.809787] RBP: ffffa107afad77e8 R08: 0000000000000000 R09: c0000000ffff7fff
[    9.816929] R10: 0000000000000001 R11: ffffc2aac6f77a68 R12: ffffa10269ea03c0
[    9.824072] R13: ffffa0f449a34408 R14: ffffa103c4d0d008 R15: ffffa107afad77e8
[    9.831214] FS:  0000000000000000(0000) GS:ffffa107afac0000(0000) knlGS:0000000000000000
[    9.839309] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.845064] CR2: 0000000000000000 CR3: 0000000f2960a000 CR4: 00000000003506e0
[   10.000752] tsc: Refined TSC clocksource calibration: 2195.874 MHz
[   10.007018] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fa6f9655b2, max_idle_ns: 440795314254 ns
[   10.017271] clocksource: Switched to clocksource tsc



[   11.010128] general protection fault, probably for non-canonical address 0xff25ff23ff28d4fe: 0000 [#1] SMP NOPTI
[   11.010135] CPU: 0 PID: 666 Comm: kworker/0:3 Tainted: G            E     5.14.0-rc3 #10
[   11.010141] Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.11.4 09/26/2019
[   11.010144] Workqueue: events work_for_cpu_fn
[   11.010157] RIP: 0010:native_queued_spin_lock_slowpath+0x173/0x1b0
[   11.010166] Code: f3 90 48 8b 32 48 85 f6 74 f6 eb d5 c1 ee 12 83 e0 03 83 ee 01 48 c1 e0 05 48 63 f6 48 05 00 d7 02 00 48 03 04 f5 80 aa 79 ad <48> 89 10 8b 42 08 85 c0 75 09 f3 90 8b 42 08 85 c0 74 f7 48 8b 32
[   11.010171] RSP: 0018:ffffaad600003e60 EFLAGS: 00010082
[   11.010176] RAX: ff25ff23ff28d4fe RBX: 0000000000000286 RCX: 0000000000040000
[   11.010180] RDX: ffff94e06f22d700 RSI: 0000000000003ffe RDI: ffffcad5ffdec5e0
[   11.010182] RBP: 000000000000007f R08: 0000000000000000 R09: 0000000000000000
[   11.010185] R10: 000000000000003f R11: 00000000003d0900 R12: ffff94dd07d1df28
[   11.010187] R13: 0000000000000286 R14: ffff94dd07d1d808 R15: ffffcad5ffdec5e0
[   11.010190] FS:  0000000000000000(0000) GS:ffff94e06f200000(0000) knlGS:0000000000000000
[   11.010193] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.010196] CR2: 00007fe6b00d55ac CR3: 00000001090f2000 CR4: 00000000003506f0
[   11.010199] Call Trace:
[   11.010202]  <IRQ>
[   11.010204]  _raw_spin_lock_irqsave+0x30/0x40
[   11.010214]  fq_flush_timeout+0x54/0x90
[   11.010221]  ? fq_ring_free+0xb0/0xb0
[   11.010226]  call_timer_fn+0x26/0xf0
[   11.010232]  run_timer_softirq+0x1cd/0x3e0
[   11.010237]  ? update_process_times+0xb0/0xc0
[   11.010241]  ? tick_sched_handle.isra.22+0x1f/0x60
[   11.010248]  ? timerqueue_add+0x6f/0x80
[   11.010255]  ? enqueue_hrtimer+0x2f/0x70
[   11.010260]  ? ktime_get+0x3e/0xa0
[   11.010265]  ? lapic_next_event+0x1c/0x20
[   11.010271]  ? clockevents_program_event+0x94/0x100
[   11.010277]  __do_softirq+0xd5/0x293
[   11.010284]  irq_exit_rcu+0x88/0xa0
[   11.010290]  sysvec_apic_timer_interrupt+0x6e/0x90
[   11.010297]  </IRQ>
[   11.010298]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   11.010305] RIP: 0010:vprintk_emit+0x1f4/0x270
[   11.010311] Code: 01 48 c7 c1 cc 27 32 ae 84 c0 74 09 f3 90 0f b6 11 84 d2 75 f7 e8 1c 09 00 00 48 85 ed 0f 84 5e ff ff ff fb 66 0f 1f 44 00 00 <e9> 52 ff ff ff fb 66 0f 1f 44 00 00 e9 10 ff ff ff 80 3d 20 25 58
[   11.010316] RSP: 0018:ffffaad60a03bbd0 EFLAGS: 00000206
[   11.010319] RAX: 0000000000000001 RBX: 0000000000000060 RCX: ffffffffae3227cc
[   11.010321] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffffffffae3227d8
[   11.010323] RBP: 0000000000000200 R08: ffffffffae322800 R09: 0000000000000000
[   11.010325] R10: ffff94fc7fe5ca82 R11: ffff94fc7fe5ca7e R12: ffffffffad76287f
[   11.010327] R13: ffffaad60a03bc30 R14: ffffffffad739d6c R15: ffffaad60a03bcb8
[   11.010333]  dev_vprintk_emit+0x170/0x194
[   11.010341]  ? device_add+0x177/0x940
[   11.010347]  dev_printk_emit+0x4e/0x65
[   11.010353]  ? cdev_device_add+0x44/0x70
[   11.010359]  __netdev_printk+0x95/0xff
[   11.010368]  netdev_info+0x6c/0x83
[   11.010372]  ? ktime_get_with_offset+0x54/0xc0
[   11.010378]  tg3_init_one.cold.170+0x162/0x702 [tg3]
[   11.010401]  local_pci_probe+0x42/0x80
[   11.010408]  work_for_cpu_fn+0x16/0x20
[   11.010414]  process_one_work+0x1d1/0x370
[   11.010420]  worker_thread+0x1d4/0x3a0
[   11.010424]  ? process_one_work+0x370/0x370
[   11.010428]  kthread+0x11a/0x140
[   11.010434]  ? set_kthread_struct+0x40/0x40
[   11.010440]  ret_from_fork+0x22/0x30
[   11.010450] Modules linked in: ahci(E) tg3(E+) libahci(E) xhci_pci(E+) crct10dif_pclmul(E) i40e(E+) crct10dif_common(E) libphy(E) crc32_pclmul(E) libata(E) megaraid_sas(E+) ptp(E) xhci_hcd(E) crc32c_intel(E) i2c_piix4(E) scsi_mod(E) usbcore(E) pps_core(E)
[   11.010536] ---[ end trace 16503134d0efa5b1 ]---
[   11.010539] RIP: 0010:native_queued_spin_lock_slowpath+0x173/0x1b0
[   11.010545] Code: f3 90 48 8b 32 48 85 f6 74 f6 eb d5 c1 ee 12 83 e0 03 83 ee 01 48 c1 e0 05 48 63 f6 48 05 00 d7 02 00 48 03 04 f5 80 aa 79 ad <48> 89 10 8b 42 08 85 c0 75 09 f3 90 8b 42 08 85 c0 74 f7 48 8b 32
[   11.010549] RSP: 0018:ffffaad600003e60 EFLAGS: 00010082
[   11.010552] RAX: ff25ff23ff28d4fe RBX: 0000000000000286 RCX: 0000000000040000
[   11.010554] RDX: ffff94e06f22d700 RSI: 0000000000003ffe RDI: ffffcad5ffdec5e0
[   11.010556] RBP: 000000000000007f R08: 0000000000000000 R09: 0000000000000000
[   11.010558] R10: 000000000000003f R11: 00000000003d0900 R12: ffff94dd07d1df28
[   11.010560] R13: 0000000000000286 R14: ffff94dd07d1d808 R15: ffffcad5ffdec5e0
[   11.010563] FS:  0000000000000000(0000) GS:ffff94e06f200000(0000) knlGS:0000000000000000
[   11.010566] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.010569] CR2: 00007fe6b00d55ac CR3: 00000001090f2000 CR4: 00000000003506f0
[   11.010573] Kernel panic - not syncing: Fatal exception in interrupt
[   11.011580] Kernel Offset: 0x2b600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   11.518892] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

Best,

- Lucas
