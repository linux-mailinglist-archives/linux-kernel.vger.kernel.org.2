Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4B831A1A4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhBLP0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 10:26:53 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:34287 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhBLPZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:25:24 -0500
Received: from [192.168.1.155] ([77.9.136.38]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MYNS0-1lNJzE1IsU-00VTod; Fri, 12 Feb 2021 16:22:50 +0100
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: BUG: broken overlay causes very strange kernel crash
Message-ID: <271d8801-7428-2a9e-5e6f-1a7ad9a752dc@metux.net>
Date:   Fri, 12 Feb 2021 16:22:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hsiuQ4gq/afV+T0Fe4jTWPyZHDl9shAbPGq4bc1FXXCZtq1evZf
 VSaE03FyNPnYxH7rS8T1IwnwAIa/oPGOyONbzBxaXl6a+IOBtvfbhjykBpHoZsa6wL8k8pe
 T+E9H01wmku4VwCqSAnw2kjhXQdC/8ZsVPKlz9yvDVO5OHaFiGHl9rzMVAcAepO0cYI+Y/C
 hEYSWC9tGJMBlK/yCGFiA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mw5jsP5Yoq0=:KmMLeInbGY6hw3a4NfsDMH
 lhfNRiVGZuM8vV8nyKNDehC7dVwBAZkA6Jw4zyIJu5JaUV/wmKZw/mig+H8jQe6W0nqdHkWoA
 BK0HZDXQdcezJiKa+vUYqQwABXvFdGxcJva2Jx+rzihc+96qlOFo0cWDaDix0z4mWNV9RUTeG
 Tc1K+FHOKR3n3YRpXfMItHFiRG+f458BwItm+YzcicppT3/qh9ND9TjhwNI0S8jdDjcOp08iq
 op2DfEL39WO1fWhkSdLBsXNIJhlXOI4cZcQXcC9xdxPiXJgOKzigEPm3pdJygko39bp4B+QNM
 DhUCgZ4SqA9pav4gmxKzjNk13d8w1j3c/Q2d3piM/Kv32NhY2aN+y/ralHmZqCUGQxECPHzWm
 zDXM2Tw6h8krZqXGPgSD5dXwSUWWQZa63V7WlQh3Mi84sTCloIeBsVy6q7jxI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,


while playing around with overlays, I've encountered a funny crash,
that even seems to affect the filesystem. No idea what really happens,
as oftree code detected the broken phandle.

What I did:

* i've written a driver that loads a builtin oftree overlay and tries
   to apply it.
* as its running on x86 (acpi-based), I'm also creating a of_root node
   and add some properties to it. (yes, calling of_node_init())
* using of_overlay_fdt_apply(), which seemed to work, but still trying
   to find out how to make it add new top-level nodes ...
* if the call fails, the driver does nothing (except printing the err)
* when adding a fragment with target <0> the crash happens

The crash *much* later than loading the overlay, NULL pointer deref in
ext2_error(). Since I can't see any relation between oftree and ext2,
this smells that oftree code is overwriting some unrelated memory.

Maybe something's creating broken pointers and then writing there ?

Obviously my driver code shit, but those strange things happending
smells like some weird is going on deep inside the oftree code, that
maybe *could* provide an attack surface.


Does anyone have an idea what's going here ?


thx
--mtx


[    0.629870] OF: overlay: find target, node: /fragment@0, phandle 0x0 
not found
[    0.631603] OF: overlay: init_overlay_changeset() failed, ret = -22
[    0.633131] ofboard: ret=-22 ovcs_id=0
[    0.634039] ofboard: dumping all nodes ...
[    0.634932] ofboard: ==> of node:
[    0.635579] ofboard:  --> property: model
[    0.636333] ofboard:  --> property: compatible
[    0.637202] ofboard: ret=-22 ovcs_id=0
[    0.637919] ofboard: ofdrv done
[    0.638529] IPI shorthand broadcast: enabled
[    0.640553] VFS: Mounted root (ext2 filesystem) readonly on device 254:0.
[    0.642639] Freeing unused kernel image (initmem) memory: 700K
[    0.649080] Write protecting the kernel read-only data: 10240k
[    0.651415] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    0.653478] Freeing unused kernel image (rodata/data gap) memory: 1124K
[    0.655178] Run /sbin/init as init process
[    0.665905] BUG: kernel NULL pointer dereference, address: 
000000000000003a
[    0.667634] #PF: supervisor write access in kernel mode
[    0.668919] #PF: error_code(0x0002) - not-present page
[    0.669011] PGD 0 P4D 0
[    0.669011] Oops: 0002 [#1] PREEMPT SMP PTI
[    0.669011] CPU: 0 PID: 25 Comm: rcS Not tainted 
5.11.0-rc7-00105-g4fb1c4f664da-dirty #247
[    0.669011] Hardware name: PC engines Standard PC (i440FX + PIIX, 
1996)/APU3, BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 044
[    0.669011] RIP: 0010:ext2_error+0x6d/0x90
[    0.669011] Code: 30 31 c0 f6 47 50 01 0f 85 04 32 15 00 4d 8d bc 24 
80 01 00 00 4c 89 ff e8 f0 a4 16 00 4c 89 ff 66 41 83 8c 24 9f
[    0.669011] RSP: 0018:ffffc900000d7aa8 EFLAGS: 00010206
[    0.669011] RAX: 0000000000000000 RBX: ffff888000256000 RCX: 
0000000000000077
[    0.669011] RDX: 0000000000000001 RSI: ffffffff81895e52 RDI: 
ffff88800025e380
[    0.669011] RBP: ffffc900000d7b38 R08: ffff88800048da78 R09: 
ffff8880019f8ff4
[    0.669011] R10: 0000000000000000 R11: ffffffff8f9a8d98 R12: 
ffff88800025e200
[    0.669011] R13: 0000000000000000 R14: ffffffff81895e52 R15: 
ffff88800025e380
[    0.669011] FS:  00007f500a373740(0000) GS:ffff888007a00000(0000) 
knlGS:0000000000000000
[    0.669011] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.669011] CR2: 000000000000003a CR3: 00000000009cc000 CR4: 
00000000000006b0
[    0.669011] Call Trace:
[    0.669011]  ? kmem_cache_alloc+0x1a/0x150
[    0.669011]  ext2_get_inode+0x5e/0x130
[    0.669011]  ? iget_locked+0x1e3/0x1f0
[    0.669011]  ext2_iget+0x81/0x420
[    0.669011]  ext2_lookup+0x79/0xb0
[    0.669011]  __lookup_slow+0x79/0x130
[    0.669011]  walk_component+0x139/0x1b0
[    0.669011]  ? path_init+0x2bd/0x3e0
[    0.669011]  path_lookupat+0x6d/0x1b0
[    0.669011]  filename_lookup+0xa5/0x170
[    0.669011]  ? strncpy_from_user+0x53/0x140
[    0.669011]  user_path_at_empty+0x35/0x40
[    0.669011]  vfs_statx+0x6e/0x110
[    0.669011]  ? handle_mm_fault+0x11ee/0x1280
[    0.669011]  __do_sys_newstat+0x3e/0x70
[    0.669011]  ? irqentry_exit+0x3c/0x60
[    0.669011]  ? exc_page_fault+0x22c/0x380
[    0.669011]  ? __do_sys_rt_sigreturn+0xc5/0xe0
[    0.669011]  __x64_sys_newstat+0x11/0x20
[    0.669011]  do_syscall_64+0x32/0x50
[    0.669011]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    0.669011] RIP: 0033:0x7f500a462ee6
[    0.669011] Code: 00 00 75 05 48 83 c4 18 c3 e8 e6 ef 01 00 66 0f 1f 
44 00 00 41 89 f8 48 89 f7 48 89 d6 41 83 f8 01 77 29 b8 04 02
[    0.669011] RSP: 002b:00007ffd1fb01848 EFLAGS: 00000246 ORIG_RAX: 
0000000000000004
[    0.669011] RAX: ffffffffffffffda RBX: 00007ffd1fb019d0 RCX: 
00007f500a462ee6
[    0.669011] RDX: 00007ffd1fb01890 RSI: 00007ffd1fb01890 RDI: 
0000561c13db2498
[    0.669011] RBP: 0000561c13db1778 R08: 0000000000000001 R09: 
ff736cff6f647166
[    0.669011] R10: 00007f500a40b020 R11: 0000000000000246 R12: 
0000000000000001
[    0.669011] R13: 0000561c13db2498 R14: 0000000000000000 R15: 
0000000000000000
[    0.669011] Modules linked in:
[    0.669011] CR2: 000000000000003a
[    0.669011] ---[ end trace 05e6cb187fe8bcfc ]---
[    0.669011] RIP: 0010:ext2_error+0x6d/0x90
[    0.669011] Code: 30 31 c0 f6 47 50 01 0f 85 04 32 15 00 4d 8d bc 24 
80 01 00 00 4c 89 ff e8 f0 a4 16 00 4c 89 ff 66 41 83 8c 24 9f
[    0.669011] RSP: 0018:ffffc900000d7aa8 EFLAGS: 00010206
[    0.669011] RAX: 0000000000000000 RBX: ffff888000256000 RCX: 
0000000000000077
[    0.669011] RDX: 0000000000000001 RSI: ffffffff81895e52 RDI: 
ffff88800025e380
[    0.669011] RBP: ffffc900000d7b38 R08: ffff88800048da78 R09: 
ffff8880019f8ff4
[    0.669011] R10: 0000000000000000 R11: ffffffff8f9a8d98 R12: 
ffff88800025e200
[    0.669011] R13: 0000000000000000 R14: ffffffff81895e52 R15: 
ffff88800025e380
[    0.669011] FS:  00007f500a373740(0000) GS:ffff888007a00000(0000) 
knlGS:0000000000000000
[    0.669011] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.669011] CR2: 000000000000003a CR3: 00000000009cc000 CR4: 
00000000000006b0
[    0.669011] note: rcS[25] exited with preempt_count 1
[   21.773182] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   21.773182] 	(detected by 0, t=5252 jiffies, g=-1179, q=23)
[   21.773182] rcu: All QSes seen, last rcu_preempt kthread activity 
5252 (4294897676-4294892424), jiffies_till_next_fqs=1, root ->qs0
[   21.773182] rcu: rcu_preempt kthread starved for 5252 jiffies! g-1179 
f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
[   21.773182] rcu: 	Unless rcu_preempt kthread gets sufficient CPU 
time, OOM is now expected behavior.
[   21.773182] rcu: RCU grace-period kthread stack dump:
[   21.773182] task:rcu_preempt     state:R  running task     stack: 
0 pid:   11 ppid:     2 flags:0x00004000
[   21.773182] Call Trace:
[   21.773182]  __schedule+0x191/0x4b0
[   21.773182]  ? __mod_timer+0x235/0x3b0
[   21.773182]  schedule+0x5b/0xd0
[   21.773182]  schedule_timeout+0x7b/0xf0
[   21.773182]  ? lock_timer_base+0x70/0x70
[   21.773182]  rcu_gp_kthread+0x5b5/0xc10
[   21.773182]  ? rcu_cpu_kthread+0xa0/0xa0
[   21.773182]  kthread+0x128/0x150
[   21.773182]  ? __kthread_bind_mask+0x70/0x70
[   21.773182]  ret_from_fork+0x1f/0x30
[   48.409796] watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [init:1]
[   48.409796] Modules linked in:
[   48.409796] CPU: 0 PID: 1 Comm: init Tainted: G      D 
5.11.0-rc7-00105-g4fb1c4f664da-dirty #247
[   48.409796] Hardware name: PC engines Standard PC (i440FX + PIIX, 
1996)/APU3, BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 044
[   48.409796] RIP: 0010:native_queued_spin_lock_slowpath+0x11/0x1d0
[   48.409796] Code: 4d 89 58 08 4c 89 c0 c3 0f 0b 66 66 2e 0f 1f 84 00 
00 00 00 00 0f 1f 40 00 8b 05 fa 15 9b 00 85 c0 7e 18 ba 01 00
[   48.409796] RSP: 0018:ffffc90000013ae0 EFLAGS: 00000202
[   48.409796] RAX: 0000000000000001 RBX: ffff888000256000 RCX: 
00000000000001ad
[   48.409796] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 
ffff88800025e380
[   48.409796] RBP: ffffc90000013ae8 R08: ffff88800048c268 R09: 
ffff8880019fe3f4
[   48.409796] R10: 0000000000000000 R11: d0918a8dd08d9e89 R12: 
ffff88800025e200
[   48.409796] R13: 0000000000000000 R14: ffffffff81895e52 R15: 
ffff88800025e380
[   48.409796] FS:  00007f1f631eb740(0000) GS:ffff888007a00000(0000) 
knlGS:0000000000000000
[   48.409796] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   48.409796] CR2: 000000000000003a CR3: 00000000009b4000 CR4: 
00000000000006b0
[   48.409796] Call Trace:
[   48.409796]  ? _raw_spin_lock+0x20/0x30
[   48.409796]  ext2_error+0x60/0x90
[   48.409796]  ? kmem_cache_alloc+0x1a/0x150
[   48.409796]  ext2_get_inode+0x5e/0x130
[   48.409796]  ? iget_locked+0x1e3/0x1f0
[   48.409796]  ext2_iget+0x81/0x420
[   48.409796]  ext2_lookup+0x79/0xb0
[   48.409796]  __lookup_slow+0x79/0x130
[   48.409796]  walk_component+0x139/0x1b0
[   48.409796]  link_path_walk.part.0+0x224/0x350
[   48.409796]  ? path_init+0x2bd/0x3e0
[   48.409796]  path_lookupat+0x3a/0x1b0
[   48.409796]  filename_lookup+0xa5/0x170
[   48.409796]  ? __check_object_size+0x131/0x150
[   48.409796]  ? strncpy_from_user+0x53/0x140
[   48.409796]  ? getname_flags+0x47/0x170
[   48.409796]  ? __do_sys_wait4+0x84/0x90
[   48.409796]  user_path_at_empty+0x35/0x40
[   48.409796]  do_faccessat+0x7a/0x240
[   48.409796]  __x64_sys_access+0x18/0x20
[   48.409796]  do_syscall_64+0x32/0x50
[   48.409796]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   48.409796] RIP: 0033:0x7f1f632dbc77
[   48.409796] Code: 77 01 c3 48 8b 15 f1 b1 0c 00 f7 d8 64 89 02 48 c7 
c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 15 08
[   48.409796] RSP: 002b:00007ffe90e9bce8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000015
[   48.409796] RAX: ffffffffffffffda RBX: 0000000000000019 RCX: 
00007f1f632dbc77
[   48.409796] RDX: 0000000000000000 RSI: 0000000000000006 RDI: 
0000557fcababe83
[   48.409796] RBP: 0000000000000008 R08: 0000000000000000 R09: 
0000000000000000
[   48.409796] R10: 0000000000000000 R11: 0000000000000246 R12: 
0000000000000000
[   48.409796] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000019
[   76.410225] watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [init:1]
[   76.410225] Modules linked in:
[   76.410225] CPU: 0 PID: 1 Comm: init Tainted: G      D      L 
5.11.0-rc7-00105-g4fb1c4f664da-dirty #247
[   76.410225] Hardware name: PC engines Standard PC (i440FX + PIIX, 
1996)/APU3, BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 044
[   76.410225] RIP: 0010:native_queued_spin_lock_slowpath+0x20/0x1d0
[   76.410225] Code: 84 00 00 00 00 00 0f 1f 40 00 8b 05 fa 15 9b 00 85 
c0 7e 18 ba 01 00 00 00 8b 07 85 c0 75 09 3e 0f b1 17 85 c0 78
[   76.410225] RSP: 0018:ffffc90000013ae0 EFLAGS: 00000202
[   76.410225] RAX: 0000000000000001 RBX: ffff888000256000 RCX: 
00000000000001ad
[   76.410225] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 
ffff88800025e380
[   76.410225] RBP: ffffc90000013ae8 R08: ffff88800048c268 R09: 
ffff8880019fe3f4
[   76.410225] R10: 0000000000000000 R11: d0918a8dd08d9e89 R12: 
ffff88800025e200
[   76.410225] R13: 0000000000000000 R14: ffffffff81895e52 R15: 
ffff88800025e380
[   76.410225] FS:  00007f1f631eb740(0000) GS:ffff888007a00000(0000) 
knlGS:0000000000000000
[   76.410225] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   76.410225] CR2: 000000000000003a CR3: 00000000009b4000 CR4: 
00000000000006b0
[   76.410225] Call Trace:
[   76.410225]  ? _raw_spin_lock+0x20/0x30
[   76.410225]  ext2_error+0x60/0x90
[   76.410225]  ? kmem_cache_alloc+0x1a/0x150
[   76.410225]  ext2_get_inode+0x5e/0x130
[   76.410225]  ? iget_locked+0x1e3/0x1f0
[   76.410225]  ext2_iget+0x81/0x420
[   76.410225]  ext2_lookup+0x79/0xb0
[   76.410225]  __lookup_slow+0x79/0x130
[   76.410225]  walk_component+0x139/0x1b0
[   76.410225]  link_path_walk.part.0+0x224/0x350
[   76.410225]  ? path_init+0x2bd/0x3e0
[   76.410225]  path_lookupat+0x3a/0x1b0
[   76.410225]  filename_lookup+0xa5/0x170
[   76.410225]  ? __check_object_size+0x131/0x150
[   76.410225]  ? strncpy_from_user+0x53/0x140
[   76.410225]  ? getname_flags+0x47/0x170
[   76.410225]  ? __do_sys_wait4+0x84/0x90
[   76.410225]  user_path_at_empty+0x35/0x40
[   76.410225]  do_faccessat+0x7a/0x240
[   76.410225]  __x64_sys_access+0x18/0x20
[   76.410225]  do_syscall_64+0x32/0x50
[   76.410225]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   76.410225] RIP: 0033:0x7f1f632dbc77
[   76.410225] Code: 77 01 c3 48 8b 15 f1 b1 0c 00 f7 d8 64 89 02 48 c7 
c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 15 08
[   76.410225] RSP: 002b:00007ffe90e9bce8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000015
[   76.410225] RAX: ffffffffffffffda RBX: 0000000000000019 RCX: 
00007f1f632dbc77
[   76.410225] RDX: 0000000000000000 RSI: 0000000000000006 RDI: 
0000557fcababe83
[   76.410225] RBP: 0000000000000008 R08: 0000000000000000 R09: 
0000000000000000
[   76.410225] R10: 0000000000000000 R11: 0000000000000246 R12: 
0000000000000000
[   76.410225] R13: 0000000000000000 R14: 0000000000000000 R15: 
0000000000000019
[   86.094296] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:


-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
