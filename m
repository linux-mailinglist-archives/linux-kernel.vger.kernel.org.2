Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE0333398C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 11:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhCJKJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 05:09:45 -0500
Received: from mout.gmx.net ([212.227.15.15]:56813 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhCJKJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 05:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615370957;
        bh=dcTj9dDVE+utVVt6hWVURSaCrn2Nrwoyd5Fn0x5hGTQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=Z5Whz/ntrltuAp6inMNUsgQWbTZ7OaSjX55+diKQMYgVTDH0PNx5qbp8JWIhYZQOC
         SRJWGqW2Pygvye4ZR6iCnADtvVROz8iiQmJ+r7/hanrGCa9+aAbJORvOGi+YQ04BNd
         cULjRc+ZpfOwRXMXuYTsLkl3NCUqqf6lrU1srzYg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.50.246]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hZD-1lOac93zkH-004mpf; Wed, 10
 Mar 2021 11:09:17 +0100
Message-ID: <8f7cb404c60babde61a6de0ae3f0b8f2b975d571.camel@gmx.de>
Subject: drm: unexpected static_call insn opcode 0xe9 at
 drm_gem_check_release_pagevec+0x2a/0x30 [drm]
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     David Airlie <airlied@linux.ie>
Date:   Wed, 10 Mar 2021 11:09:16 +0100
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+LfqKIFqT+TKFuifYxi0bBYa7N0XGHmXW0QcsrKpH11E6DiBpjE
 5acmBnJLgB8bXDrlQhOtQ4DnCrKFmrBG8hENoXYxbAd8Txh8bR0AboBpfGZwEYc4d+/3hnA
 30Sqb+2srG//dd/X8U2eLSXSuED/qnknmXRao0fx50axPg6FF7TrOsluDy3c2GSI9Zwp2W0
 JqlynW3V1r+Gvz7SllsIw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WM2M4MDRMR4=:lg6PzysK3jbUS4BqT1xVaI
 TM4NJ3cMUbWhJsWSk2KlvgILvM4GgVqcYb08/hGpk8ic09tiU3LGY5P3ZWkFQHscg2tXaqFvP
 mBTw02RmNzznhQmKe+m5RXcxKdCUbbcC/chcjv5goInQUL0JUNMpuFL0exOBNWRoFfuNGf6u9
 Wh09/AApluWilpQI6Wzb28Q7clu3kzbFHbpab4sOfYahKkePT9I1GhaHvYvrOqL+MptdPdiAU
 9c7nlM9jtNVmwhbsoyhfPalvVXB6OS3336ncWXzmDjQO+WYF2OMiGm1/i0HzC6OSqcONoNCvp
 zETK9c6SgjP0nip0/DvPEFV/NhjpvgD8xYjGUCYghPPNFL9zqtPnx/4bfBLfv56eq1PCzGIct
 Q1FYREVwnI2KliVQuHuPLrtBlRJvIs9T320lqVO4BD7Gahc4akeSnRs/e2VZoQiIPdJhbovdN
 x5mjtNxCymRAnpbsmYn6VIsNIY+G2TBNrX9mcpdhkROHOgwk1r3EtPY087rEl8N92MUVb41Y+
 PE7cCvSOewHMatmz20t89G1Irh2rvDOxtmTLPemmqkGVXleLlMxWYBlgrYc9whhA3y0c3shE8
 N7zjUIAVbsTeNNgiDREBnH7tWwiZjOmcEQ6b1BRsE3YSJj/DuWb/KdLprge59EGUkmEqqpuCx
 6+Ls7BJUS/wMK78jAfzmh2ocADzs7q/XAdByWLmRUz1Hoarr59VwjN+NKA0ajPSzZxAhvX9FN
 4XpwZ6sGUtQsViGCjp+YIXLI2uzGUhZSwr5rX3lqH8R3XqIie+uB6agaGdSgz5QbbzoJVrUF3
 FNvdVuCTre5f6kHPhpQgTmIpLtETXuPkdlr7Jekzg68w2xFcK5zO8vXiWfL6I8FFNM17SCYZf
 +iESAx0KZv6ctF4MGbIA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Box is aging i4790 box w. GTX980+nouveau.

[    2.833432] ------------[ cut here ]------------
[    2.833448] unexpected static_call insn opcode 0xe9 at drm_gem_check_release_pagevec+0x2a/0x30 [drm]
[    2.833505] WARNING: CPU: 2 PID: 329 at arch/x86/kernel/static_call.c:77 __static_call_validate+0x71/0x80
[    2.833522] Modules linked in: drm(E+) usbcore(E) video(E) button(E+) sd_mod(E) t10_pi(E) vfat(E) fat(E) virtio_blk(E) virtio_mmio(E) virtio_ring(E) virtio(E) ext4(E) crc32c_intel(E) crc16(E) mbcache(E) jbd2(E) loop(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) efivarfs(E) autofs4(E)
[    2.833595] CPU: 2 PID: 329 Comm: systemd-udevd Tainted: G            E     5.12.0.g05a59d7-master #2
[    2.833598] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[    2.833601] RIP: 0010:__static_call_validate+0x71/0x80
[    2.833605] Code: 75 cc f3 c3 0f b6 49 04 38 4f 04 75 e1 f3 c3 f3 c3 48 89 fa 0f b6 f0 48 c7 c7 48 9f 03 82 c6 05 e6 a3 3e 01 01 e8 1f 59 04 00 <0f> 0b c3 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 41 55
[    2.833608] RSP: 0018:ffff888108d07c70 EFLAGS: 00010286
[    2.833612] RAX: 0000000000000058 RBX: 0000000000000000 RCX: 0000000000000001
[    2.833614] RDX: 0000000080000001 RSI: ffffffff82066fc1 RDI: 00000000ffffffff
[    2.833617] RBP: ffffffff811cbad0 R08: 0000000000000001 R09: 0000000000000001
[    2.833619] R10: ffff888108d07c78 R11: ffff888108d07988 R12: ffffffffa0353cea
[    2.833622] R13: 0000000000000000 R14: ffffffffa0353cea R15: ffffffff8226c140
[    2.833624] FS:  00007fbe0b7e1d40(0000) GS:ffff88841ec80000(0000) knlGS:0000000000000000
[    2.833627] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.833630] CR2: 00007fbe0b7eabb0 CR3: 0000000108d08001 CR4: 00000000001706e0
[    2.833633] Call Trace:
[    2.833635]  arch_static_call_transform+0x5f/0x90
[    2.833657]  __static_call_init.part.2+0xc2/0x210
[    2.833667]  ? __SCT__tp_func_sched_update_nr_running_tp+0x8/0x8
[    2.833672]  static_call_module_notify+0x14c/0x190
[    2.833684]  notifier_call_chain_robust+0x56/0xc0
[    2.833706]  blocking_notifier_call_chain_robust+0x41/0x60
[    2.833720]  ? kfree+0x170/0x2b0
[    2.833729]  load_module+0x1a19/0x21e0
[    2.833767]  ? __do_sys_finit_module+0x94/0xe0
[    2.833772]  __do_sys_finit_module+0x94/0xe0
[    2.833802]  do_syscall_64+0x33/0x40
[    2.833808]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[    2.833812] RIP: 0033:0x7fbe0a620759
[    2.833816] Code: 00 48 81 c4 80 00 00 00 89 f0 c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0f d7 2b 00 f7 d8 64 89 01 48
[    2.833819] RSP: 002b:00007fff37392f08 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[    2.833824] RAX: ffffffffffffffda RBX: 000055792e98ecf0 RCX: 00007fbe0a620759
[    2.833826] RDX: 0000000000000000 RSI: 00007fbe0af5b87d RDI: 0000000000000006
[    2.833829] RBP: 00007fbe0af5b87d R08: 0000000000000000 R09: 0000000000000000
[    2.833831] R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000020000
[    2.833834] R13: 000055792e9a7810 R14: 0000000000000000 R15: 0000000003938700
[    2.833860] irq event stamp: 10273
[    2.833862] hardirqs last  enabled at (10279): [<ffffffff810e9223>] vprintk_emit+0x283/0x2b0
[    2.833867] hardirqs last disabled at (10284): [<ffffffff810e91e0>] vprintk_emit+0x240/0x2b0
[    2.833870] softirqs last  enabled at (7608): [<ffffffff81c00365>] __do_softirq+0x365/0x492
[    2.833875] softirqs last disabled at (7453): [<ffffffff81079136>] irq_exit_rcu+0xf6/0x100
[    2.833879] ---[ end trace d6083471edf28ca7 ]---

