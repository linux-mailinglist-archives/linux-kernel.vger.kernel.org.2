Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DD63B5804
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 06:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhF1EMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 00:12:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:37631 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229592AbhF1EMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 00:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624853378;
        bh=mEwnJu/IOYGIkmuNpyQfHhYCB0lBkHc+IsynsLqIUh4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=dJLVJ5BStDCmS8x0VChgU+9T60FaBzp0DIAs8PIRd6A5iqU9pPz+G7yToHvqjh5aX
         9DVc0H/pDph7t2xOsdQ/LHdZAGlzoDkunY6gDe5VhTQaiPA+bPDK+5dzx1Cuf/QoKO
         4EKy2pxSiAqkAYeIgQNoO/t4EZRnhz0hAen8uwL8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.107]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MC34h-1m5Aia3t1h-00CU2v; Mon, 28
 Jun 2021 06:09:38 +0200
Message-ID: <f3cb7efc616be532ab2dc9f3ac2e8611dd643888.camel@gmx.de>
Subject: drm/nouveau: lockdep circular locking dependency report
From:   Mike Galbraith <efault@gmx.de>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>
Date:   Mon, 28 Jun 2021 06:09:36 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FwL0p4wbQPnNu/+CePPo5yIQxpcrgSuflBlKcjDUKNdY5fTvMZi
 sjpRoW3q078DBE44uqn27JarymIc2MgO8ue1JbTXykIVStO+pj4aOtKd25KHxsk3v5Dg4sa
 QgV87ags4YMgM/vZ8uRXaFQrNeVSX3nK2ZU1pVNtkcaO639jeemHszDZeXGbAG4KCn9LdrL
 l6axzc1k+5j2ZAv8xB09A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1GOozOlJbBE=:ZduZe+GAMp3ACvLuBru2Q9
 j0QKhflrHpSVyarGI9WrBtS1i7BM8SBpP9/m5xq4y4oFqZzZCC8afuThr7IoJDFNGry5PcxXl
 3yoSoJf57F+wbeqKwZU6vYSe3ktqwNaJZt2QgFDdPgy3afqisMGRPyIPOxtT0brLRrr02nTgW
 rOKx6ZSnjbGIrWcV8GKIsGCyxvui+hUHHRYF2EwWT2O5mJSTJO6K4QOKPCRpJYur7EkpRrh/P
 VeEMXrx0ots5Jg04VqKBiGXIAaYBiU6kiEnft/GrK0VLO5BknXZLF3RpFwx2Jo6MJvFAMMA+2
 j279kJ8jZ9J+hwhC4vtPtndne8M4mx3B7LQ8l22HUAOUucN9a9a0epTG+oXMNQSYMDJ6/Phdn
 YXnIA3fe+7L0DNtWKTWdwhoA5d43gd0ZdfkyxNZAWXLlSN/KPxORyjJC9aKoLmN8GahVkUjST
 0Xp9oAVkFtKmba36qJ9Z/xstrPPulRhYdRBZRs73uizgAf6REspoX6UIew7bWsE3SmWzsLBxt
 Yqd/cTkplY8L/KC9m88/gNqJOiGeV8RP21Ge9UYmZvgJWlFONAqTFQNoSJSAyU/G5aVlqsMXB
 wK/gt0clym7u3zzt69uMEA0Nwx6cE1NRPv4JbqfXbCLpB3n1oghnJJK61kiVPuubgQlUi/A00
 kIPoenfUZDe/hzmY5yb+FRlhaApO6cbOs+gCI3Ptx5bhogo6K1ip4pSaLZbhPT4TubI8SUDGD
 i6pfrYbO9oUnPLyCYnPXjTALRtpkrGFUvRCeO5Q05v/akm+LT+bYrwU/iXTAPw3ao97qrN7Xp
 87YbooowgwnF1rfmCuTYxdOwflseYJ1+6KZGh7khx0o2zl4ulj5qV+JE+YStka+YTc6Rn3qoj
 qrhCp3S9Zl95netmkEvVTKWItV9mX+75sx+KAgqKEbfzU7RwiUCWxjtmSxhRy/R59qg3IXAnc
 XrPhqEco1ctEl97DkX9w5RzQ6SwCc+smS7vqLg+fETfyNuP0vcRx+KJwAcYhiyEFIGCsg4KHr
 xDf3tPBB+SpRUMok6FT9aHLFaIb2YLtdDek6IhLsEe89BV196m6SMKvVNOwDL78fQm30Rbr7O
 CqQMbZGAWkPJkoItHkqPrQS3lbdS8BfgZpL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having forgotten to boot nomodeset when running lockdep enabled
kernels, I was reminded that this gripe is still alive and well.

Graphics card is same old GTX-980 in same old box as last report.  It's
harmless other than mucking up testing, but since it reminded me again,
I'll pass it along again.

[   29.130076] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   29.130079] WARNING: possible circular locking dependency detected
[   29.130081] 5.13.0.g625acff-master #4 Tainted: G            E
[   29.130084] ------------------------------------------------------
[   29.130087] X/2064 is trying to acquire lock:
[   29.130089] ffff888120a54518 (&cli->mutex){+.+.}-{3:3}, at: nouveau_bo_=
move+0x11c/0x830 [nouveau]
[   29.130160]
               but task is already holding lock:
[   29.130162] ffff888100912da0 (reservation_ww_class_mutex){+.+.}-{3:3}, =
at: nouveau_bo_pin+0x2b/0x320 [nouveau]
[   29.130217]
               which lock already depends on the new lock.

[   29.130220]
               the existing dependency chain (in reverse order) is:
[   29.130223]
               -> #1 (reservation_ww_class_mutex){+.+.}-{3:3}:
[   29.130227]        lock_acquire+0x258/0x2f0
[   29.130232]        __ww_mutex_lock.constprop.17+0xbe/0x1090
[   29.130237]        nouveau_bo_pin+0x2b/0x320 [nouveau]
[   29.130285]        nouveau_channel_prep+0x106/0x2e0 [nouveau]
[   29.130328]        nouveau_channel_new+0x4f/0x760 [nouveau]
[   29.130369]        nouveau_abi16_ioctl_channel_alloc+0xdf/0x350 [nouvea=
u]
[   29.130407]        drm_ioctl_kernel+0x8f/0xe0 [drm]
[   29.130430]        drm_ioctl+0x2db/0x380 [drm]
[   29.130446]        nouveau_drm_ioctl+0x56/0xb0 [nouveau]
[   29.130495]        __x64_sys_ioctl+0x73/0xb0
[   29.130499]        do_syscall_64+0x39/0x80
[   29.130502]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   29.130506]
               -> #0 (&cli->mutex){+.+.}-{3:3}:
[   29.130510]        validate_chain+0xbb8/0x1740
[   29.130514]        __lock_acquire+0x8ab/0xc20
[   29.130516]        lock_acquire+0x258/0x2f0
[   29.130520]        __mutex_lock+0x95/0x9b0
[   29.130523]        nouveau_bo_move+0x11c/0x830 [nouveau]
[   29.130571]        ttm_bo_handle_move_mem+0x76/0x130 [ttm]
[   29.130576]        ttm_bo_validate+0x156/0x1b0 [ttm]
[   29.130581]        nouveau_bo_validate+0x48/0x70 [nouveau]
[   29.130628]        nouveau_bo_pin+0x1ec/0x320 [nouveau]
[   29.130673]        nv50_wndw_prepare_fb+0x53/0x4d0 [nouveau]
[   29.130715]        drm_atomic_helper_prepare_planes+0x87/0x110 [drm_kms=
_helper]
[   29.130731]        nv50_disp_atomic_commit+0xa9/0x1b0 [nouveau]
[   29.130776]        drm_atomic_helper_update_plane+0x10a/0x150 [drm_kms_=
helper]
[   29.130788]        drm_mode_cursor_universal+0x10b/0x220 [drm]
[   29.130810]        drm_mode_cursor_common+0x190/0x200 [drm]
[   29.130828]        drm_mode_cursor_ioctl+0x3d/0x50 [drm]
[   29.130845]        drm_ioctl_kernel+0x8f/0xe0 [drm]
[   29.130870]        drm_ioctl+0x2db/0x380 [drm]
[   29.130884]        nouveau_drm_ioctl+0x56/0xb0 [nouveau]
[   29.130932]        __x64_sys_ioctl+0x73/0xb0
[   29.130936]        do_syscall_64+0x39/0x80
[   29.130939]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   29.130943]
               other info that might help us debug this:

[   29.130947]  Possible unsafe locking scenario:

[   29.130950]        CPU0                    CPU1
[   29.130952]        ----                    ----
[   29.130955]   lock(reservation_ww_class_mutex);
[   29.130958]                                lock(&cli->mutex);
[   29.130961]                                lock(reservation_ww_class_mu=
tex);
[   29.130965]   lock(&cli->mutex);
[   29.130967]
                *** DEADLOCK ***

[   29.130970] 3 locks held by X/2064:
[   29.130973]  #0: ffff888103ecfcf0 (crtc_ww_class_acquire){+.+.}-{0:0}, =
at: drm_mode_cursor_common+0x87/0x200 [drm]
[   29.130996]  #1: ffff8881209e00c0 (crtc_ww_class_mutex){+.+.}-{3:3}, at=
: drm_modeset_backoff+0xe4/0x190 [drm]
[   29.131020]  #2: ffff888100912da0 (reservation_ww_class_mutex){+.+.}-{3=
:3}, at: nouveau_bo_pin+0x2b/0x320 [nouveau]
[   29.131073]
               stack backtrace:
[   29.131076] CPU: 5 PID: 2064 Comm: X Kdump: loaded Tainted: G          =
  E     5.13.0.g625acff-master #4
[   29.131081] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09=
/23/2013
[   29.131084] Call Trace:
[   29.131087]  dump_stack+0x7f/0xad
[   29.131091]  check_noncircular+0x10c/0x120
[   29.131096]  ? nvkm_vmm_map+0xca/0x3c0 [nouveau]
[   29.131144]  ? validate_chain+0xbb8/0x1740
[   29.131148]  validate_chain+0xbb8/0x1740
[   29.131154]  __lock_acquire+0x8ab/0xc20
[   29.131158]  lock_acquire+0x258/0x2f0
[   29.131162]  ? nouveau_bo_move+0x11c/0x830 [nouveau]
[   29.131212]  __mutex_lock+0x95/0x9b0
[   29.131216]  ? nouveau_bo_move+0x11c/0x830 [nouveau]
[   29.131265]  ? nvif_vmm_map+0xf4/0x110 [nouveau]
[   29.131291]  ? nouveau_bo_move+0x11c/0x830 [nouveau]
[   29.131341]  ? nouveau_bo_move+0x11c/0x830 [nouveau]
[   29.131390]  nouveau_bo_move+0x11c/0x830 [nouveau]
[   29.131440]  ? unmap_mapping_pages+0x5c/0x110
[   29.131446]  ttm_bo_handle_move_mem+0x76/0x130 [ttm]
[   29.131452]  ttm_bo_validate+0x156/0x1b0 [ttm]
[   29.131459]  nouveau_bo_validate+0x48/0x70 [nouveau]
[   29.131509]  nouveau_bo_pin+0x1ec/0x320 [nouveau]
[   29.131559]  nv50_wndw_prepare_fb+0x53/0x4d0 [nouveau]
[   29.131605]  drm_atomic_helper_prepare_planes+0x87/0x110 [drm_kms_helpe=
r]
[   29.131618]  ? lockdep_init_map_type+0x58/0x250
[   29.131622]  nv50_disp_atomic_commit+0xa9/0x1b0 [nouveau]
[   29.131669]  drm_atomic_helper_update_plane+0x10a/0x150 [drm_kms_helper=
]
[   29.131682]  drm_mode_cursor_universal+0x10b/0x220 [drm]
[   29.131706]  drm_mode_cursor_common+0x190/0x200 [drm]
[   29.131729]  ? drm_mode_setplane+0x190/0x190 [drm]
[   29.131751]  drm_mode_cursor_ioctl+0x3d/0x50 [drm]
[   29.131773]  drm_ioctl_kernel+0x8f/0xe0 [drm]
[   29.131788]  drm_ioctl+0x2db/0x380 [drm]
[   29.131804]  ? drm_mode_setplane+0x190/0x190 [drm]
[   29.131825]  ? _raw_spin_unlock_irqrestore+0x55/0x70
[   29.131830]  ? lockdep_hardirqs_on+0xbf/0x130
[   29.131833]  ? _raw_spin_unlock_irqrestore+0x42/0x70
[   29.131838]  nouveau_drm_ioctl+0x56/0xb0 [nouveau]
[   29.131889]  __x64_sys_ioctl+0x73/0xb0
[   29.131893]  ? lockdep_hardirqs_on+0xbf/0x130
[   29.131897]  do_syscall_64+0x39/0x80
[   29.131900]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   29.131904] RIP: 0033:0x7fa55f31d807
[   29.131908] Code: b3 66 90 48 8b 05 89 76 2d 00 64 c7 00 26 00 00 00 48=
 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 59 76 2d 00 f7 d8 64 89 01 48
[   29.131914] RSP: 002b:00007ffde6234b48 EFLAGS: 00000246 ORIG_RAX: 00000=
00000000010
[   29.131919] RAX: ffffffffffffffda RBX: 0000564efa74dc20 RCX: 00007fa55f=
31d807
[   29.131922] RDX: 00007ffde6234b80 RSI: 00000000c01c64a3 RDI: 0000000000=
00000e
[   29.131926] RBP: 00007ffde6234b80 R08: 0000000000000040 R09: 0000564efa=
798cd0
[   29.131929] R10: 00007fa560918048 R11: 0000000000000246 R12: 00000000c0=
1c64a3
[   29.131933] R13: 000000000000000e R14: 0000000000000000 R15: 0000000000=
000000
[   38.208089] Adjusting tsc more than 11% (4143767 vs 5184956)

