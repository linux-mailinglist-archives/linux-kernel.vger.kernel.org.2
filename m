Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D63333952
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 10:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhCJJ6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 04:58:49 -0500
Received: from mout.gmx.net ([212.227.15.19]:35187 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhCJJ6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 04:58:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615370305;
        bh=kHjJ9yeNHQwRs04k3pxUqHG2EByrtGLPJmDVZKxSo0w=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=AWlNegyl1ZNkgd8q8pNVBSX49mw1ubJz8+9/WDkgo/CBwJedev//EHxbBKp9s8kAI
         gthtzhmOPWELwDaqDQDFUt2nrgx46M1xQ9G0bFNVAW7zxiX9lIijkHs2FRl+70KGkC
         K7UruEYvSox9DqDyhaR+L3m5TQb/oZmvpEWIsNwE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.50.246]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhlV-1lUh7e2g6R-00ApAX; Wed, 10
 Mar 2021 10:58:25 +0100
Message-ID: <987bd1ca15545ca896c4e1c115e89a1bba0ad306.camel@gmx.de>
Subject: nouveau: lockdep cli->mutex vs reservation_ww_class_mutex  deadlock
 report
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
Date:   Wed, 10 Mar 2021 10:58:24 +0100
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SqMISrnRsST5M8n+PLCgrwmSWekhu+csAh8+hgmtewkNHuiIMkm
 z5QOfQ/7a9y2gbuNvPw1qspFoXPhHwIrrVLJeh4hBoinLlDAwPGwit5dz/9lQ+G800OhsOU
 9MHNDJpEANgbRgDXdL/WsQOX3hYZKl7JKnJsyuJXkBOWgv+QjbPrXevEVNtgwdSlVzFwMJZ
 8MICHJkuS6n6BxMVzi80w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/eofxP9CXK0=:bbRtNamIC9RA9VtunQN7TQ
 81ahJoichvwaYfOlE0v3N8z8REbuX7xNHW0pnBChE+XKzCHwOtwjYfN5Q0Hxe9m54U2xDZONK
 girMDwdfH9PRmt5a6L6ahVY0mz8v87l6Adt5gwc+T06Y/9hxuTUODi0xeiChirZOia/DfDBE1
 YhHApFPKumR6crtXRsAITBeoDlIN38MDQeP6eVkNsnYelnVHt3eSFTHNCwGyEqksX4D9cjg8+
 yOMNK1boG668XpJxUIutgOAIs9bOFwkuU5O8EhwXIyG/0/j1sJAdE/MJTt/zq2T1XbjTu6PZB
 QK86bH8+2zMarMREEEhwkE+93ZHqNYXNZLj5iPNBe5k4bdGo8zd+EQEjIno3ZHr8jffseZljD
 E82sTdqsyo+2nSnCT1Q7roMS9BGzDhFrEyTju+TWP6+jOV0iZ9bQ6WRxyBw29HsZCGMI8keHi
 VVUwkm6qLcTzh/wGH4n7G8rwk3gf+1EJrSArujWYmFl+v/YSm84hmOlNpV+jMHwKBdyXBwoGv
 08wrtcPpfQJRnyIl/MRJtso5APOzevTC+8I+CEUKhxEBAl43FAKTmFJwf83eQfthM//S3N2eh
 InY1T+mMNEPrxOdpuWFWZo3XhFJc+RaAxnxI3eMP5aITqCaXUGkXoZG453ntBnedddrykCXh4
 8Xo5zueYgmJ4QFyfzERoSMXzMAIn08E+G6CcXBFzxkxUV+tBJAJ+hgBlCft7MbPXLVf8CoRDN
 yLGQsrhUgtgoQlowx5j0j+4cO6ZrA7nxR93MSzFg6oaLg6j7TYCay+9BN952iDkx/DAw2Jbtk
 RkMV65K4gVkudZ3O1KMKMsYmjD/pUO4/j8GRgBjSNe8bnZ0lUisufBi3PsZTavc//5XscyPFV
 FCKyZgY49u6hfBZWTkzg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[   29.966927] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   29.966929] WARNING: possible circular locking dependency detected
[   29.966932] 5.12.0.g05a59d7-master #2 Tainted: G        W   E
[   29.966934] ------------------------------------------------------
[   29.966937] X/2145 is trying to acquire lock:
[   29.966939] ffff888120714518 (&cli->mutex){+.+.}-{3:3}, at: nouveau_bo_=
move+0x11f/0x980 [nouveau]
[   29.967002]
               but task is already holding lock:
[   29.967004] ffff888123c201a0 (reservation_ww_class_mutex){+.+.}-{3:3}, =
at: nouveau_bo_pin+0x2b/0x310 [nouveau]
[   29.967053]
               which lock already depends on the new lock.

[   29.967056]
               the existing dependency chain (in reverse order) is:
[   29.967058]
               -> #1 (reservation_ww_class_mutex){+.+.}-{3:3}:
[   29.967063]        __ww_mutex_lock.constprop.16+0xbe/0x10d0
[   29.967069]        nouveau_bo_pin+0x2b/0x310 [nouveau]
[   29.967112]        nouveau_channel_prep+0x106/0x2e0 [nouveau]
[   29.967151]        nouveau_channel_new+0x4f/0x760 [nouveau]
[   29.967188]        nouveau_abi16_ioctl_channel_alloc+0xdf/0x350 [nouvea=
u]
[   29.967223]        drm_ioctl_kernel+0x91/0xe0 [drm]
[   29.967245]        drm_ioctl+0x2db/0x380 [drm]
[   29.967259]        nouveau_drm_ioctl+0x56/0xb0 [nouveau]
[   29.967303]        __x64_sys_ioctl+0x76/0xb0
[   29.967307]        do_syscall_64+0x33/0x40
[   29.967310]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   29.967314]
               -> #0 (&cli->mutex){+.+.}-{3:3}:
[   29.967318]        __lock_acquire+0x1494/0x1ac0
[   29.967322]        lock_acquire+0x23e/0x3b0
[   29.967325]        __mutex_lock+0x95/0x9d0
[   29.967330]        nouveau_bo_move+0x11f/0x980 [nouveau]
[   29.967377]        ttm_bo_handle_move_mem+0x79/0x130 [ttm]
[   29.967384]        ttm_bo_validate+0x156/0x1b0 [ttm]
[   29.967390]        nouveau_bo_validate+0x48/0x70 [nouveau]
[   29.967438]        nouveau_bo_pin+0x1de/0x310 [nouveau]
[   29.967487]        nv50_wndw_prepare_fb+0x53/0x4d0 [nouveau]
[   29.967531]        drm_atomic_helper_prepare_planes+0x8a/0x110 [drm_kms=
_helper]
[   29.967547]        nv50_disp_atomic_commit+0xa9/0x1b0 [nouveau]
[   29.967593]        drm_atomic_helper_update_plane+0x10a/0x150 [drm_kms_=
helper]
[   29.967606]        drm_mode_cursor_universal+0x10b/0x220 [drm]
[   29.967627]        drm_mode_cursor_common+0x190/0x200 [drm]
[   29.967648]        drm_mode_cursor_ioctl+0x3d/0x50 [drm]
[   29.967669]        drm_ioctl_kernel+0x91/0xe0 [drm]
[   29.967684]        drm_ioctl+0x2db/0x380 [drm]
[   29.967699]        nouveau_drm_ioctl+0x56/0xb0 [nouveau]
[   29.967748]        __x64_sys_ioctl+0x76/0xb0
[   29.967752]        do_syscall_64+0x33/0x40
[   29.967756]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   29.967760]
               other info that might help us debug this:

[   29.967764]  Possible unsafe locking scenario:

[   29.967767]        CPU0                    CPU1
[   29.967770]        ----                    ----
[   29.967772]   lock(reservation_ww_class_mutex);
[   29.967776]                                lock(&cli->mutex);
[   29.967779]                                lock(reservation_ww_class_mu=
tex);
[   29.967783]   lock(&cli->mutex);
[   29.967786]
                *** DEADLOCK ***

[   29.967790] 3 locks held by X/2145:
[   29.967792]  #0: ffff88810365bcf8 (crtc_ww_class_acquire){+.+.}-{0:0}, =
at: drm_mode_cursor_common+0x87/0x200 [drm]
[   29.967817]  #1: ffff888108d9e098 (crtc_ww_class_mutex){+.+.}-{3:3}, at=
: drm_modeset_lock+0xc3/0xe0 [drm]
[   29.967841]  #2: ffff888123c201a0 (reservation_ww_class_mutex){+.+.}-{3=
:3}, at: nouveau_bo_pin+0x2b/0x310 [nouveau]
[   29.967896]
               stack backtrace:
[   29.967899] CPU: 6 PID: 2145 Comm: X Kdump: loaded Tainted: G        W =
  E     5.12.0.g05a59d7-master #2
[   29.967904] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09=
/23/2013
[   29.967908] Call Trace:
[   29.967911]  dump_stack+0x6d/0x89
[   29.967915]  check_noncircular+0xe7/0x100
[   29.967919]  ? nvkm_vram_map+0x48/0x50 [nouveau]
[   29.967959]  ? __lock_acquire+0x1494/0x1ac0
[   29.967963]  __lock_acquire+0x1494/0x1ac0
[   29.967967]  lock_acquire+0x23e/0x3b0
[   29.967971]  ? nouveau_bo_move+0x11f/0x980 [nouveau]
[   29.968020]  __mutex_lock+0x95/0x9d0
[   29.968024]  ? nouveau_bo_move+0x11f/0x980 [nouveau]
[   29.968070]  ? nvif_vmm_map+0xf4/0x110 [nouveau]
[   29.968093]  ? nouveau_bo_move+0x11f/0x980 [nouveau]
[   29.968137]  ? lock_release+0x160/0x280
[   29.968141]  ? nouveau_bo_move+0x11f/0x980 [nouveau]
[   29.968184]  nouveau_bo_move+0x11f/0x980 [nouveau]
[   29.968226]  ? up_write+0x17/0x130
[   29.968229]  ? unmap_mapping_pages+0x53/0x110
[   29.968234]  ttm_bo_handle_move_mem+0x79/0x130 [ttm]
[   29.968240]  ttm_bo_validate+0x156/0x1b0 [ttm]
[   29.968247]  nouveau_bo_validate+0x48/0x70 [nouveau]
[   29.968289]  nouveau_bo_pin+0x1de/0x310 [nouveau]
[   29.968330]  nv50_wndw_prepare_fb+0x53/0x4d0 [nouveau]
[   29.968372]  drm_atomic_helper_prepare_planes+0x8a/0x110 [drm_kms_helpe=
r]
[   29.968384]  ? lockdep_init_map_type+0x58/0x240
[   29.968388]  nv50_disp_atomic_commit+0xa9/0x1b0 [nouveau]
[   29.968430]  drm_atomic_helper_update_plane+0x10a/0x150 [drm_kms_helper=
]
[   29.968442]  drm_mode_cursor_universal+0x10b/0x220 [drm]
[   29.968463]  ? lock_is_held_type+0xdd/0x130
[   29.968468]  drm_mode_cursor_common+0x190/0x200 [drm]
[   29.968486]  ? drm_mode_setplane+0x190/0x190 [drm]
[   29.968502]  drm_mode_cursor_ioctl+0x3d/0x50 [drm]
[   29.968518]  drm_ioctl_kernel+0x91/0xe0 [drm]
[   29.968533]  drm_ioctl+0x2db/0x380 [drm]
[   29.968548]  ? drm_mode_setplane+0x190/0x190 [drm]
[   29.968570]  ? _raw_spin_unlock_irqrestore+0x30/0x60
[   29.968574]  ? lockdep_hardirqs_on+0x79/0x100
[   29.968578]  ? _raw_spin_unlock_irqrestore+0x3b/0x60
[   29.968582]  nouveau_drm_ioctl+0x56/0xb0 [nouveau]
[   29.968632]  __x64_sys_ioctl+0x76/0xb0
[   29.968636]  ? lockdep_hardirqs_on+0x79/0x100
[   29.968640]  do_syscall_64+0x33/0x40
[   29.968644]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   29.968648] RIP: 0033:0x7f1ccfb4e9e7
[   29.968652] Code: b3 66 90 48 8b 05 b1 14 2c 00 64 c7 00 26 00 00 00 48=
 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 81 14 2c 00 f7 d8 64 89 01 48
[   29.968659] RSP: 002b:00007ffca9596058 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000010
[   29.968663] RAX: ffffffffffffffda RBX: 000055da9d0c6470 RCX: 00007f1ccf=
b4e9e7
[   29.968667] RDX: 00007ffca9596090 RSI: 00000000c01c64a3 RDI: 0000000000=
00000e
[   29.968670] RBP: 00007ffca9596090 R08: 0000000000000040 R09: 000055da9d=
0f6310
[   29.968674] R10: 0000000000000093 R11: 0000000000000246 R12: 00000000c0=
1c64a3
[   29.968677] R13: 000000000000000e R14: 0000000000000000 R15: 0000000000=
000000

