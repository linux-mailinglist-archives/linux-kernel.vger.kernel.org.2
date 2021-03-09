Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160D1332DF3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 19:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhCISNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 13:13:17 -0500
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:28012 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhCISMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 13:12:47 -0500
Received: from [192.168.8.96] ([90.59.133.149])
        by mwinf5d05 with ME
        id eJCj240073DZbkS03JCjWK; Tue, 09 Mar 2021 19:12:44 +0100
X-ME-Helo: [192.168.8.96]
X-ME-Auth: ZXJpYy52YWxldHRlNkB3YW5hZG9vLmZy
X-ME-Date: Tue, 09 Mar 2021 19:12:44 +0100
X-ME-IP: 90.59.133.149
Reply-To: eric.valette@free.fr
Subject: Re: systematic crash in amdgpu init since 5.10.20. Not fixed with
 5.10.21
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <c288c34d-9989-c45d-4ea7-03c9b11c48ff@free.fr>
 <e426efc9-cc4b-8663-ec92-0c4a4cabcb96@applied-asynchrony.com>
Cc:     gregkh@linuxfoundation.org
From:   Eric Valette <eric.valette@free.fr>
Message-ID: <cbc839ba-f5db-4971-ad83-ddd3154840ea@free.fr>
Date:   Tue, 9 Mar 2021 19:12:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e426efc9-cc4b-8663-ec92-0c4a4cabcb96@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2021 18:27, Holger Hoffstätte wrote:
> On 2021-03-07 17:18, Eric Valette wrote:
>> I have the following systematic crash at boot since 5.10.20 (.19 was ok)
>>
>> This laptop has two graphic cards:
>>
>> 03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] 
>> Navi 14 [Radeon RX 5500/5500M / Pro 5500M] (rev c1)
>> 07:00.0 VGA compatible controller: Advanced Micro Devices, Inc. 
>> [AMD/ATI] Renoir (rev c6)
>>
>> NB: cc me I'm not subscribed
>>
>> CPU: 13 PID: 721 Comm: systemd-udevd Not tainted 5.10.21 #2
>> [    4.446170] Hardware name: Micro-Star International Co., Ltd. Bravo 
>> 17 A4DDR/MS-17FK, BIOS E17FKAMS.117 10/29/2020
>> [    4.446175] RIP: 0010:kernel_fpu_begin_mask+0xc5/0xe0
>> [    4.446179] Code: 65 8a 05 86 32 9f 52 84 c0 74 9a 0f 0b eb 96 48 
>> 8b 07 f6 c4 40 75 b0 f0 80 4f 01 40 48 81 c7 00 0c 00 00 e8 cd fb ff 
>> ff eb 9d <0f> 0b eb 82 db e3 eb b8 e8 3e 63 e0 00 66 66 2e 0f 1f 84 00 
>> 00 00
>> [    4.446182] RSP: 0018:ffffbc70012ef5e8 EFLAGS: 00010202
>> [    4.446185] RAX: 0000000080000001 RBX: 0000000000000003 RCX: 
>> ffffbc70012ef65c
>> [    4.446186] RDX: ffff9bd4415b4000 RSI: ffff9bd4525c0000 RDI: 
>> 0000000000000003
>> [    4.446188] RBP: ffff9bd433e20000 R08: ffffbc70012ef660 R09: 
>> 0000000000000000
>> [    4.446190] R10: ffff9bd415ba4000 R11: ffff9bd4525c10f0 R12: 
>> ffffffffc0c46560
>> [    4.446191] R13: 0000000000000000 R14: ffff9bd4415b4000 R15: 
>> 0000000000000001
>> [    4.446194] FS:  00007f00024218c0(0000) GS:ffff9bd71f940000(0000) 
>> knlGS:0000000000000000
>> [    4.446196] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    4.446199] CR2: 00005575ca8bb8e8 CR3: 00000001117e8000 CR4: 
>> 0000000000350ee0
>> [    4.446200] Call Trace:
>> [    4.446532]  dcn21_calculate_wm+0x49/0x410 [amdgpu]
>> [    4.446848]  dcn21_validate_bandwidth_fp+0x174/0x280 [amdgpu]
>> [    4.447162]  dcn21_validate_bandwidth+0x29/0x40 [amdgpu]
>> [    4.447415]  dc_validate_global_state+0x2f2/0x390 [amdgpu]
>> [    4.447667]  amdgpu_dm_atomic_check+0xb0d/0xc00 [amdgpu]
>> [    4.447704]  drm_atomic_check_only+0x55a/0x7d0 [drm]
>> [    4.447735]  drm_atomic_commit+0x13/0x50 [drm]
>> [    4.447765]  drm_client_modeset_commit_atomic+0x1e4/0x220 [drm]
>> [    4.447795]  drm_client_modeset_commit_locked+0x56/0x150 [drm]
>> [    4.447822]  drm_client_modeset_commit+0x24/0x40 [drm]
>> [    4.447840]  drm_fb_helper_set_par+0xa5/0xd0 [drm_kms_helper]
>> [    4.447846]  fbcon_init+0x2b3/0x570
>> [    4.447850]  visual_init+0xce/0x130
>> [    4.447853]  do_bind_con_driver.isra.0+0x1db/0x2e0
>> [    4.447857]  do_take_over_console+0x116/0x180
>> [    4.447861]  do_fbcon_takeover+0x5c/0xc0
>> [    4.447864]  register_framebuffer+0x1e4/0x300
>> [    4.447881]  __drm_fb_helper_initial_config_and_unlock+0x321/0x4a0 
>> [drm_kms_helper]
>> [    4.448081]  amdgpu_fbdev_init+0xb9/0xf0 [amdgpu]
>> [    4.448326]  amdgpu_device_init.cold+0x166b/0x1a4d [amdgpu]
>> [    4.448334]  ? pci_bus_read_config_word+0x49/0x70
>> [    4.448527]  amdgpu_driver_load_kms+0x2b/0x1f0 [amdgpu]
>> [    4.448718]  amdgpu_pci_probe+0x114/0x1a0 [amdgpu]
>> [    4.448761]  local_pci_probe+0x42/0x80
>> [    4.448770]  ? _cond_resched+0x16/0x40
>> [    4.448774]  pci_device_probe+0xfa/0x1b0
>> [    4.448781]  really_probe+0xf2/0x440
>> [    4.448786]  driver_probe_device+0xe1/0x150
>> [    4.448789]  device_driver_attach+0xa1/0xb0
>> [    4.448792]  __driver_attach+0x8a/0x150
>> [    4.448794]  ? device_driver_attach+0xb0/0xb0
>> [    4.448797]  ? device_driver_attach+0xb0/0xb0
>> [    4.448800]  bus_for_each_dev+0x78/0xc0
>> [    4.448805]  bus_add_driver+0x12b/0x1e0
>> [    4.448808]  driver_register+0x8b/0xe0
>> [    4.448812]  ? 0xffffffffc134a000
>> [    4.448817]  do_one_initcall+0x44/0x1d0
>> [    4.448822]  ? do_init_module+0x23/0x260
>> [    4.448828]  ? kmem_cache_alloc_trace+0xf5/0x200
>> [    4.448831]  do_init_module+0x5c/0x260
>> [    4.448834]  __do_sys_finit_module+0xb1/0x110
>> [    4.448840]  do_syscall_64+0x33/0x80
>> [    4.448844]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [    4.448848] RIP: 0033:0x7f00028da9b9
>> [    4.448853] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 
>> 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 
>> 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 
>> 01 48
>> [    4.448855] RSP: 002b:00007ffcab625508 EFLAGS: 00000246 ORIG_RAX: 
>> 0000000000000139
>> [    4.448860] RAX: ffffffffffffffda RBX: 000056314a23dff0 RCX: 
>> 00007f00028da9b9
>> [    4.448862] RDX: 0000000000000000 RSI: 00007f0002a65e2d RDI: 
>> 0000000000000017
>> [    4.448864] RBP: 0000000000020000 R08: 0000000000000000 R09: 
>> 000056314a243020
>> [    4.448866] R10: 0000000000000017 R11: 0000000000000246 R12: 
>> 00007f0002a65e2d
>> [    4.448868] R13: 0000000000000000 R14: 000056314a24a2d0 R15: 
>> 000056314a23dff0
>> [    4.448873] ---[ end trace 72b8a47f60a3c4b2 ]---
>> [    4.449556] ------------[ cut here ]------------
>> [    4.449562] WARNING: CPU: 13 PID: 721 at 
>> arch/x86/kernel/fpu/core.c:155 kernel_fpu_end+0x19/0x20
>> [    4.449563] Modules linked in: uinput binfmt_misc amdgpu(+) 
>> uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videodev 
>> iwlmvm videobuf2_common gpu_sched ttm msi_wmi drm_kms_helper pcspkr 
>> serio_raw sparse_keymap sp5100_tco cec watchdog btusb i2c_algo_bit 
>> fb_sys_fops syscopyarea iwlwifi sysfillrect sysimgblt tpm_crb tpm_tis 
>> tpm_tis_core tpm drm configfs ip_tables x_tables autofs4 i2c_hid
>> [    4.449590] CPU: 13 PID: 721 Comm: systemd-udevd Tainted: G        
>> W        5.10.21 #2
>> [    4.449592] Hardware name: Micro-Star International Co., Ltd. Bravo 
>> 17 A4DDR/MS-17FK, BIOS E17FKAMS.117 10/29/2020
>> [    4.449595] RIP: 0010:kernel_fpu_end+0x19/0x20
>> [    4.449599] Code: ae 47 40 b8 01 00 00 00 c3 0f 0b eb d7 0f 0b eb 
>> c9 0f 1f 44 00 00 65 8a 05 2c 36 9f 52 84 c0 74 09 65 c6 05 20 36 9f 
>> 52 00 c3 <0f> 0b eb f3 0f 1f 00 0f 1f 44 00 00 8b 15 a5 b6 59 02 31 f6 
>> e8 fe
>> [    4.449600] RSP: 0018:ffffbc70012ef6b0 EFLAGS: 00010246
>> [    4.449602] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
>> 00000000000007a4
>> [    4.449604] RDX: 00000000000007a3 RSI: cade29b7434a9329 RDI: 
>> 000000000002d740
>> [    4.449605] RBP: ffff9bd4525c0000 R08: 0000000000000000 R09: 
>> 0000000000000040
>> [    4.449606] R10: 00000000c4444440 R11: 0000000000000003 R12: 
>> 0000000000000001
>> [    4.449607] R13: ffff9bd415ba4000 R14: ffff9bd4525c1518 R15: 
>> ffff9bd4525c0000
>> [    4.449610] FS:  00007f00024218c0(0000) GS:ffff9bd71f940000(0000) 
>> knlGS:0000000000000000
>> [    4.449611] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    4.449612] CR2: 00005575ca8bb8e8 CR3: 00000001117e8000 CR4: 
>> 0000000000350ee0
>> [    4.449613] Call Trace:
>> [    4.449861]  dcn21_validate_bandwidth+0x31/0x40 [amdgpu]
>> [    4.450104]  dc_validate_global_state+0x2f2/0x390 [amdgpu]
>> [    4.450355]  amdgpu_dm_atomic_check+0xb0d/0xc00 [amdgpu]
>> [    4.450393]  drm_atomic_check_only+0x55a/0x7d0 [drm]
>> [    4.450424]  drm_atomic_commit+0x13/0x50 [drm]
>> [    4.450454]  drm_client_modeset_commit_atomic+0x1e4/0x220 [drm]
>> [    4.450483]  drm_client_modeset_commit_locked+0x56/0x150 [drm]
>> [    4.450511]  drm_client_modeset_commit+0x24/0x40 [drm]
>> [    4.450528]  drm_fb_helper_set_par+0xa5/0xd0 [drm_kms_helper]
>> [    4.450534]  fbcon_init+0x2b3/0x570
>> [    4.450538]  visual_init+0xce/0x130
>> [    4.450543]  do_bind_con_driver.isra.0+0x1db/0x2e0
>> [    4.450547]  do_take_over_console+0x116/0x180
>> [    4.450551]  do_fbcon_takeover+0x5c/0xc0
>> [    4.450554]  register_framebuffer+0x1e4/0x300
>> [    4.450571]  __drm_fb_helper_initial_config_and_unlock+0x321/0x4a0 
>> [drm_kms_helper]
>> [    4.450769]  amdgpu_fbdev_init+0xb9/0xf0 [amdgpu]
>> [    4.451011]  amdgpu_device_init.cold+0x166b/0x1a4d [amdgpu]
>> [    4.451018]  ? pci_bus_read_config_word+0x49/0x70
>> [    4.451211]  amdgpu_driver_load_kms+0x2b/0x1f0 [amdgpu]
>> [    4.451401]  amdgpu_pci_probe+0x114/0x1a0 [amdgpu]
>> [    4.451405]  local_pci_probe+0x42/0x80
>> [    4.451409]  ? _cond_resched+0x16/0x40
>> [    4.451412]  pci_device_probe+0xfa/0x1b0
>> [    4.451417]  really_probe+0xf2/0x440
>> [    4.451420]  driver_probe_device+0xe1/0x150
>> [    4.451422]  device_driver_attach+0xa1/0xb0
>> [    4.451424]  __driver_attach+0x8a/0x150
>> [    4.451426]  ? device_driver_attach+0xb0/0xb0
>> [    4.451427]  ? device_driver_attach+0xb0/0xb0
>> [    4.451430]  bus_for_each_dev+0x78/0xc0
>> [    4.451434]  bus_add_driver+0x12b/0x1e0
>> [    4.451436]  driver_register+0x8b/0xe0
>> [    4.451438]  ? 0xffffffffc134a000
>> [    4.451441]  do_one_initcall+0x44/0x1d0
>> [    4.451444]  ? do_init_module+0x23/0x260
>> [    4.451448]  ? kmem_cache_alloc_trace+0xf5/0x200
>> [    4.451451]  do_init_module+0x5c/0x260
>> [    4.451453]  __do_sys_finit_module+0xb1/0x110
>> [    4.451458]  do_syscall_64+0x33/0x80
>> [    4.451461]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [    4.451464] RIP: 0033:0x7f00028da9b9
>> [    4.451467] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 
>> 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 
>> 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 
>> 01 48
>> [    4.451469] RSP: 002b:00007ffcab625508 EFLAGS: 00000246 ORIG_RAX: 
>> 0000000000000139
>> [    4.451473] RAX: ffffffffffffffda RBX: 000056314a23dff0 RCX: 
>> 00007f00028da9b9
>> [    4.451474] RDX: 0000000000000000 RSI: 00007f0002a65e2d RDI: 
>> 0000000000000017
>> [    4.451475] RBP: 0000000000020000 R08: 0000000000000000 R09: 
>> 000056314a243020
>> [    4.451476] R10: 0000000000000017 R11: 0000000000000246 R12: 
>> 00007f0002a65e2d
>> [    4.451478] R13: 0000000000000000 R14: 000056314a24a2d0 R15: 
>> 000056314a23dff0
>> [    4.451481] ---[ end trace 72b8a47f60a3c4b3 ]---
>> [    4.476162] Console: switching to colour frame buffer device 240x67
>>
> 
> I had the same problem and got annoyed enough to do something about it. 
> Try these
> two fixes on top of .22:
> 
> https://gitlab.freedesktop.org/agd5f/linux/-/commit/b42c68fac891d8c23c81cdfd66f82864c2353d7b 
> 
> https://gitlab.freedesktop.org/agd5f/linux/-/commit/37ba52c6bd13a31fa35008dc0b5790a1b57de7eb 


I confirm it also fixes the problem for me. Thnaks a lot. You saved me 
from a bisect on a slow connection.

-- eric

