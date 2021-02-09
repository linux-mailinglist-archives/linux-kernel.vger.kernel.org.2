Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E603159F2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 00:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbhBIXSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 18:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbhBITq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:46:58 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBDEC061793
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 11:22:27 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id w36so16521587lfu.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 11:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c7XimrMWBYfaeW7Cp3jKo/Gu8AZagGCyLJzPBEGorLE=;
        b=FJkpy7eh7BeVjEJza9So+soZk+WyWnIehZ/GOpVf9/vwtJYi0N2qzS33Wnq1MK1deb
         LUZ6I9wJPDhyxUVuF030HKxBm7nv4o1VzMTdyT8c/lQXseZ+jXJbRVGAO/Fjl6nkEkxd
         HIfWbUpO5iFvk2+WQYadUBV98wPYsQUZlDvicS2yPzCdpOs33fLrxXNg/Pr5+X4U4ODN
         XRbhrIV0OXREkavzXVZfhlIy60Lk/EHMkdgUOwCsmA3Faq7UxAVkBlqEuQfZ3TjkPmlN
         buWvzALwQfGdrVILdypEdaQLhX0rbVbZJOFqzLXV569ygWBTnmiSjrChhQJihFrWYXm4
         U/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c7XimrMWBYfaeW7Cp3jKo/Gu8AZagGCyLJzPBEGorLE=;
        b=QuL6XeDLzqSfB5avfCRb8cmrySNWphjCHWewKFt+gtb/NRV+c56+F1UxHc1kExNvds
         5I91rmTgGtcZodOLDbgQBLIIauoVtg4n76DkdhAJgXld0I2RfjMIyVfjM9gdEmE5YCjn
         csfCYAOtkqimjVCpPFTDc6xTuDJ0qC0za8CVRJADZmxzcdG/BPY/z+Q2T/xGhMKd8Xxv
         Yrye0fTn6Tb20+4Wri+aLIm8BSZJ6ogdsYghwLmSeFN88AdlQkFF5XKVJ/G2F+2UnzT7
         z4gzgrhQMtum+4T+bjzMz8cTioqeWJLzWFvUxfUyLDJfg3zbtVVl7HP5Q0376aHmtKs+
         o4lA==
X-Gm-Message-State: AOAM530z4b/Odhdp9+Cff5gzqkhZrvx5BatDN/xUI7v6yuzSW6BkAF0H
        New03os7R2VDcMDGxcMRj5UNnUm3E2RHXdS0oW8=
X-Google-Smtp-Source: ABdhPJzlWC3Gpwa2y/8saAcAbC7UBsIDTQqsZB5vXhyryqVKC5GyVdfCqmZfTdbhAxzlpr/hTdgBi3atp4jB7iz+Uwk=
X-Received: by 2002:a05:6512:3094:: with SMTP id z20mr14732262lfd.441.1612898546343;
 Tue, 09 Feb 2021 11:22:26 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNazWZQGfSnFgQ_K5_H9uBQ=8gBdFORXrU1FEMGMohO2w@mail.gmail.com>
 <4ce29a7e-f58a-aeb4-bef-34a7eada70d0@google.com> <e0c2c823-5f-efe8-cd87-6dd6cc33a33@google.com>
 <7a677c89-1974-0676-ba7d-b057ad2cab3f@gmail.com> <CABXGCsPnGVAGWETYD-dfrqxhciHA0NKBG2EWueOtFzL5xF9z3g@mail.gmail.com>
 <cf60a50d-d3ca-2ce9-918b-0763a26552d8@gmail.com>
In-Reply-To: <cf60a50d-d3ca-2ce9-918b-0763a26552d8@gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Wed, 10 Feb 2021 00:22:14 +0500
Message-ID: <CABXGCsP-ys+bMCYo0QZCcW-fERU6JCGTBAr_H7_ejcWntL26ZA@mail.gmail.com>
Subject: Re: [bug] 5.11-rc5 brought page allocation failure issue [ttm][amdgpu]
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Feb 2021 at 14:18, Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Are the other problems gone as well?
>

And yes and no.
The issue with monitor turns off was gone after rc6 (git3aaf0a27ffc2)
But both traces
1) BUG: sleeping function called from invalid context at
include/linux/sched/mm.h:196 (kernel 5.11 specific)
2) WARNING: CPU: 14 PID: 504 at kernel/locking/lockdep.c:4618
lockdep_init_map_waits+0x18b/0x210 (Navi specific)
are still happening on every boot.

1)
[    5.806032] BUG: sleeping function called from invalid context at
include/linux/sched/mm.h:196
[    5.806048] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
504, name: systemd-udevd
[    5.806064] 1 lock held by systemd-udevd/504:
[    5.806073]  #0: ffff9c5ac2e4f258 (&dev->mutex){....}-{3:3}, at:
device_driver_attach+0x3b/0xb0
[    5.806097] CPU: 14 PID: 504 Comm: systemd-udevd Not tainted
5.11.0-0.rc6.20210204git61556703b610.145.fc34.x86_64 #1
[    5.806117] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 3402 01/13/2021
[    5.806135] Call Trace:
[    5.806142]  dump_stack+0x8b/0xb0
[    5.806153]  ___might_sleep.cold+0xb6/0xc6
[    5.806163]  ? dcn30_clock_source_create+0x34/0xb0 [amdgpu]
[    5.806338]  kmem_cache_alloc_trace+0x204/0x230
[    5.806353]  dcn30_clock_source_create+0x34/0xb0 [amdgpu]
[    5.806516]  dcn30_create_resource_pool+0x1de/0x13b0 [amdgpu]
[    5.806678]  ? rcu_read_lock_sched_held+0x3f/0x80
[    5.806690]  ? trace_kmalloc+0xb2/0xe0
[    5.806699]  ? __kmalloc+0x191/0x280
[    5.806710]  ? dc_create_resource_pool+0x110/0x1d0 [amdgpu]
[    5.806869]  dc_create_resource_pool+0x110/0x1d0 [amdgpu]
[    5.807026]  dc_create+0x205/0x790 [amdgpu]
[    5.807181]  ? trace_kmalloc+0xb2/0xe0
[    5.807190]  ? kmem_cache_alloc_trace+0x174/0x230
[    5.807203]  amdgpu_dm_init.isra.0+0x1b9/0x250 [amdgpu]
[    5.807369]  ? dev_vprintk_emit+0x171/0x195
[    5.807385]  ? dev_printk_emit+0x3e/0x40
[    5.807403]  dm_hw_init+0xe/0x20 [amdgpu]
[    5.807563]  amdgpu_device_init.cold+0x179f/0x1afd [amdgpu]
[    5.807728]  ? pci_conf1_read+0x9b/0xf0
[    5.807741]  amdgpu_driver_load_kms+0x68/0x280 [amdgpu]
[    5.807877]  amdgpu_pci_probe+0x129/0x1b0 [amdgpu]
[    5.808009]  local_pci_probe+0x42/0x80
[    5.808020]  pci_device_probe+0xd9/0x1a0
[    5.808031]  really_probe+0xf2/0x440
[    5.808042]  driver_probe_device+0xe1/0x150
[    5.808053]  device_driver_attach+0xa8/0xb0
[    5.808063]  __driver_attach+0x8c/0x150
[    5.808071]  ? device_driver_attach+0xb0/0xb0
[    5.808080]  ? device_driver_attach+0xb0/0xb0
[    5.808090]  bus_for_each_dev+0x67/0x90
[    5.808101]  bus_add_driver+0x12e/0x1f0
[    5.808111]  driver_register+0x8f/0xe0
[    5.808119]  ? 0xffffffffc0c02000
[    5.808128]  do_one_initcall+0x67/0x320
[    5.808138]  ? rcu_read_lock_sched_held+0x3f/0x80
[    5.808148]  ? trace_kmalloc+0xb2/0xe0
[    5.808157]  ? kmem_cache_alloc_trace+0x174/0x230
[    5.808169]  do_init_module+0x5c/0x270
[    5.808179]  __do_sys_init_module+0x130/0x190
[    5.808196]  do_syscall_64+0x33/0x40
[    5.808205]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    5.808216] RIP: 0033:0x7f4d133aa40e
[    5.808225] Code: 48 8b 0d 65 1a 0c 00 f7 d8 64 89 01 48 83 c8 ff
c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 32 1a 0c 00 f7 d8 64 89
01 48
[    5.808256] RSP: 002b:00007ffc81317fb8 EFLAGS: 00000246 ORIG_RAX:
00000000000000af
[    5.808272] RAX: ffffffffffffffda RBX: 0000563f79509ee0 RCX: 00007f4d133=
aa40e
[    5.808285] RDX: 0000563f7951daa0 RSI: 0000000000b8a85e RDI: 0000563f79f=
03db0
[    5.808298] RBP: 0000563f79f03db0 R08: 0000563f79509fd0 R09: 00007ffc813=
146be
[    5.808311] R10: 0000563a1aa70959 R11: 0000000000000246 R12: 0000563f795=
1daa0
[    5.808324] R13: 0000563f7950e9c0 R14: 0000000000000000 R15: 0000563f795=
1f100


2)
[    6.064107] BUG: key ffff9c5adb339148 has not been registered!
[    6.064119] ------------[ cut here ]------------
[    6.064121] DEBUG_LOCKS_WARN_ON(1)
[    6.064124] WARNING: CPU: 14 PID: 504 at
kernel/locking/lockdep.c:4618 lockdep_init_map_waits+0x18b/0x210
[    6.064131] Modules linked in: amdgpu(+) drm_ttm_helper ttm
iommu_v2 gpu_sched drm_kms_helper crct10dif_pclmul crc32_pclmul
crc32c_intel cec igb drm ghash_clmulni_intel ccp nvme dca i2c_algo_bit
nvme_core wmi pinctrl_amd fuse
[    6.064147] CPU: 14 PID: 504 Comm: systemd-udevd Tainted: G
W        --------- ---
5.11.0-0.rc6.20210204git61556703b610.145.fc34.x86_64 #1
[    6.064152] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 3402 01/13/2021
[    6.064156] RIP: 0010:lockdep_init_map_waits+0x18b/0x210
[    6.064159] Code: 00 85 c0 0f 84 77 ff ff ff 8b 3d 08 5e f1 01 85
ff 0f 85 69 ff ff ff 48 c7 c6 cc 98 60 9a 48 c7 c7 7d d4 5a 9a e8 51
3a b7 00 <0f> 0b e9 4f ff ff ff e8 c9 82 bd 00 85 c0 74 21 44 8b 15 d6
5d f1
[    6.064165] RSP: 0018:ffffbba701be78c8 EFLAGS: 00010292
[    6.064168] RAX: 0000000000000016 RBX: ffffffff9a247b80 RCX: 00000000000=
00027
[    6.064171] RDX: ffff9c61c87db2a8 RSI: 0000000000000001 RDI: ffff9c61c87=
db2a0
[    6.064174] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffbba701b=
e7700
[    6.064177] R10: ffffbba701be76f8 R11: 0000000000000000 R12: ffff9c5adb3=
39148
[    6.064180] R13: 0000000000000000 R14: ffff9c5adb610348 R15: ffff9c5adb6=
10348
[    6.064183] FS:  00007f4d1279c340(0000) GS:ffff9c61c8600000(0000)
knlGS:0000000000000000
[    6.064186] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.064189] CR2: 0000563f79657000 CR3: 0000000111396000 CR4: 00000000003=
50ee0
[    6.064192] Call Trace:
[    6.064194]  __kernfs_create_file+0x7b/0x100
[    6.064198]  sysfs_add_file_mode_ns+0xa2/0x190
[    6.064202]  sysfs_create_bin_file+0x50/0x70
[    6.064205]  hdcp_create_workqueue+0x3bd/0x410 [amdgpu]
[    6.064365]  amdgpu_dm_init.isra.0.cold+0x293/0x13e7 [amdgpu]
[    6.064526]  ? dev_vprintk_emit+0x171/0x195
[    6.064529]  ? psp_set_srm+0xb0/0xb0 [amdgpu]
[    6.064691]  ? hdcp_update_display+0x1f0/0x1f0 [amdgpu]
[    6.064847]  ? dev_printk_emit+0x3e/0x40
[    6.064851]  dm_hw_init+0xe/0x20 [amdgpu]
[    6.065005]  amdgpu_device_init.cold+0x179f/0x1afd [amdgpu]
[    6.065160]  ? pci_conf1_read+0x9b/0xf0
[    6.065164]  amdgpu_driver_load_kms+0x68/0x280 [amdgpu]
[    6.065291]  amdgpu_pci_probe+0x129/0x1b0 [amdgpu]
[    6.065415]  local_pci_probe+0x42/0x80
[    6.065418]  pci_device_probe+0xd9/0x1a0
[    6.065421]  really_probe+0xf2/0x440
[    6.065425]  driver_probe_device+0xe1/0x150
[    6.065428]  device_driver_attach+0xa8/0xb0
[    6.065431]  __driver_attach+0x8c/0x150
[    6.065433]  ? device_driver_attach+0xb0/0xb0
[    6.065435]  ? device_driver_attach+0xb0/0xb0
[    6.065438]  bus_for_each_dev+0x67/0x90
[    6.065441]  bus_add_driver+0x12e/0x1f0
[    6.065445]  driver_register+0x8f/0xe0
[    6.065447]  ? 0xffffffffc0c02000
[    6.065449]  do_one_initcall+0x67/0x320
[    6.065452]  ? rcu_read_lock_sched_held+0x3f/0x80
[    6.065455]  ? trace_kmalloc+0xb2/0xe0
[    6.065458]  ? kmem_cache_alloc_trace+0x174/0x230
[    6.065462]  do_init_module+0x5c/0x270
[    6.065465]  __do_sys_init_module+0x130/0x190
[    6.065469]  do_syscall_64+0x33/0x40
[    6.065472]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    6.065475] RIP: 0033:0x7f4d133aa40e
[    6.065477] Code: 48 8b 0d 65 1a 0c 00 f7 d8 64 89 01 48 83 c8 ff
c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 32 1a 0c 00 f7 d8 64 89
01 48
[    6.065483] RSP: 002b:00007ffc81317fb8 EFLAGS: 00000246 ORIG_RAX:
00000000000000af
[    6.065487] RAX: ffffffffffffffda RBX: 0000563f79509ee0 RCX: 00007f4d133=
aa40e
[    6.065490] RDX: 0000563f7951daa0 RSI: 0000000000b8a85e RDI: 0000563f79f=
03db0
[    6.065493] RBP: 0000563f79f03db0 R08: 0000563f79509fd0 R09: 00007ffc813=
146be
[    6.065496] R10: 0000563a1aa70959 R11: 0000000000000246 R12: 0000563f795=
1daa0
[    6.065499] R13: 0000563f7950e9c0 R14: 0000000000000000 R15: 0000563f795=
1f100
[    6.065503] irq event stamp: 304459
[    6.065505] hardirqs last  enabled at (304459):
[<ffffffff99169d57>] console_unlock+0x527/0x640
[    6.065510] hardirqs last disabled at (304458):
[<ffffffff99169ca2>] console_unlock+0x472/0x640
[    6.065514] softirqs last  enabled at (304350):
[<ffffffff99e01152>] asm_call_irq_on_stack+0x12/0x20
[    6.065518] softirqs last disabled at (304345):
[<ffffffff99e01152>] asm_call_irq_on_stack+0x12/0x20
[    6.065522] ---[ end trace 3e996d7d10608635 ]---


Full kernel log is here: https://pastebin.com/sguf7Tac

--=20
Best Regards,
Mike Gavrilov.
