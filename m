Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81190347A74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 15:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbhCXOQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 10:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbhCXOQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:16:37 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BC9C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 07:16:36 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b14so18960568lfv.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 07:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=X29rG00F2gcospPaQhcxOs2biMH7EWp4qjkQ2L73DT8=;
        b=pQTKdgxymi+9rh0ZrD9EGyveku16WHWCvgpYHT8rD6SrWn15796lMs1EfV7J3zxNFm
         Za8wnDWXEvMgOZbYYmJe5YK4tKMIhojeHnTeOANTDpPbS6kz5wKRfw+nc6ghuAQEiAcd
         +dQjDqqRjSoTwXteD7FO4K78qEW7duDoxU4ZANlPWhvVcogez4XRoPLAR4pujxBirZ8W
         sz+AR1TqMuImIr16WxlRhUIk75Gq68kU8LU3nYClXY63+uYoeVyuIUrJaEnFBjejobH6
         x/0piLF2fA+6DrM8sNT+cS75Jw5Jy5x5brNiVb8LJ5Tp1KLiAxbdhf18ynMRTd0kCZmd
         qZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=X29rG00F2gcospPaQhcxOs2biMH7EWp4qjkQ2L73DT8=;
        b=Br/Ud9A3xj51TKK+O1enh8R8KzVi3DX+rQp36QhdT4R1YsO3c7ZWHWLzqNGwi4QwTo
         dPf+9l+niTX201zMMfTjJ6pWgOSXspGsCMYRBlEBb0+O6aGdM6P5iSNcEUTJ/O0m6WJK
         1g9xnmjIBLtw+CjF+ztHLrGW40cf+nZyK+M04qMukrj+rwbvTcQ2kvH8V8AGX5/k3JvO
         q/FgRSvoLMYJ+dOQCgNmMXYrz5tPTtnuF+UNCk6pr0PZnhSY5ryvps/FHr43mArUpR0K
         MFEpfj2bec87E3t58p6svFcmwadqcHc7Fys46iXkQdbtSauBb0LIBMoLDQfmg0UajrBG
         cusg==
X-Gm-Message-State: AOAM530UXzekLMc+Kf6t+GOToMDYZf0Mn72PTex8zT7iWflkjhSPuY8G
        /B8wI9wtUUlaNc392r0jLKQo36rEsLVJk3Hrygx0ZCIyTfU=
X-Google-Smtp-Source: ABdhPJzcI4JCCIgKSZQDFtJrjdKOC45j0WaUnhE/ff0pOdLBmMcgsYjmWm5nnHQPYyAtHOC0vWKQ1+7UpXjj7QZOBZE=
X-Received: by 2002:a05:6512:3582:: with SMTP id m2mr2165182lfr.10.1616595394266;
 Wed, 24 Mar 2021 07:16:34 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Rankin <rankincj@gmail.com>
Date:   Wed, 24 Mar 2021 14:16:23 +0000
Message-ID: <CAK2bqVJ+=nHTK-hnUC=qL1mcOvHWTCwDMYPBKJp77QCbBvBGGw@mail.gmail.com>
Subject: WARNING: AMDGPU DRM warning in 5.11.9
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Theee warnings ares not present in my dmesg log from 5.11.8:

[   43.390159] ------------[ cut here ]------------
[   43.393574] WARNING: CPU: 2 PID: 1268 at
drivers/gpu/drm/ttm/ttm_bo.c:517 ttm_bo_release+0x172/0x282 [ttm]
[   43.401940] Modules linked in: nf_nat_ftp nf_conntrack_ftp cfg80211
af_packet nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute
ip6table_nat ip6table_mangle ip6table_raw iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_mangle
iptable_raw nfnetlink ebtable_filter ebtables ip6table_filter
ip6_tables iptable_filter bnep it87 hwmon_vid snd_hda_codec_realtek
dm_mod dax snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi
snd_hda_intel btusb btbcm btintel bluetooth uvcvideo videobuf2_vmalloc
snd_usb_audio ecdh_generic videobuf2_memops videobuf2_v4l2
videobuf2_common input_leds led_class rfkill videodev snd_usbmidi_lib
mc joydev ecc coretemp kvm_intel kvm snd_intel_dspcfg irqbypass
snd_hda_codec snd_virtuoso snd_oxygen_lib snd_hwdep snd_hda_core
snd_mpu401_uart snd_rawmidi snd_seq snd_seq_device snd_pcm r8169
mxm_wmi snd_hrtimer iTCO_wdt gpio_ich psmouse realtek i2c_i801 pcspkr
tiny_power_button snd_timer mdio_devres libphy i2c_smbus wmi snd
i7core_edac
[   43.402051]  button soundcore acpi_cpufreq lpc_ich binfmt_misc nfsd
auth_rpcgss nfs_acl lockd fuse grace configfs sunrpc zram zsmalloc
ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 sr_mod cdrom
sd_mod usbhid uhci_hcd ehci_pci ehci_hcd amdgpu xhci_pci xhci_hcd
drm_ttm_helper pata_jmicron ttm ahci mfd_core gpu_sched libahci
firewire_ohci i2c_algo_bit firewire_core libata crc_itu_t
drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt
fb_sys_fops crc32c_intel serio_raw cfbcopyarea scsi_mod usbcore
usb_common drm drm_panel_orientation_quirks msr sha256_ssse3
sha256_generic libsha256 ipv6
[   43.541960] CPU: 2 PID: 1268 Comm: gnome-shell Tainted: G
I       5.11.9 #1
[   43.548677] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[   43.556556] RIP: 0010:ttm_bo_release+0x172/0x282 [ttm]
[   43.560568] Code: 75 05 e8 dd e0 e6 e0 41 ff c5 eb d4 e8 0f c9 b9
e0 c6 43 58 01 48 c7 c7 68 2a 50 a0 e8 08 8e fa e0 83 bb 9c 00 00 00
00 74 20 <0f> 0b c7 83 9c 00 00 00 00 00 00 00 4c 89 e7 e8 29 fc ff ff
48 8d
[   43.578854] RSP: 0000:ffffc900017e3bc8 EFLAGS: 00010202
[   43.582956] RAX: 0000000000000000 RBX: ffff8881076ca580 RCX: 0000000000000007
[   43.589041] RDX: 0000000000000001 RSI: 0000000000000246 RDI: ffffffffa0502a68
[   43.595121] RBP: ffff88810b525638 R08: ffff888101f84f78 R09: ffffc900017e3a80
[   43.601213] R10: 0000000040042000 R11: 0000000000000000 R12: ffff8881076ca400
[   43.607331] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   43.613469] FS:  00007fb19706e480(0000) GS:ffff888343c80000(0000)
knlGS:0000000000000000
[   43.620568] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.625221] CR2: 00007fb1940ff2e0 CR3: 00000001291fe000 CR4: 00000000000006e0
[   43.631329] Call Trace:
[   43.632488]  ttm_bo_move_accel_cleanup+0x109/0x238 [ttm]
[   43.636662]  amdgpu_bo_move+0x3c3/0x507 [amdgpu]
[   43.640332]  ttm_bo_handle_move_mem+0x73/0xf9 [ttm]
[   43.644141]  ttm_bo_validate+0xfa/0x16d [ttm]
[   43.647303]  amdgpu_bo_fault_reserve_notify+0xb7/0x134 [amdgpu]
[   43.652246]  amdgpu_ttm_fault+0x27/0x7c [amdgpu]
[   43.655730]  __do_fault+0x49/0x64
[   43.657826]  handle_mm_fault+0xb19/0xbf8
[   43.660564]  exc_page_fault+0x226/0x32b
[   43.663243]  ? asm_exc_page_fault+0x8/0x30
[   43.666128]  asm_exc_page_fault+0x1e/0x30
[   43.668951] RIP: 0033:0x7fb19b11b1ee
[   43.671328] Code: 4d 29 c1 4c 29 c2 48 3b 15 27 dc 11 00 0f 87 af
00 00 00 0f 10 01 0f 10 49 f0 0f 10 51 e0 0f 10 59 d0 48 83 e9 40 48
83 ea 40 <41> 0f 29 01 41 0f 29 49 f0 41 0f 29 51 e0 41 0f 29 59 d0 49
83 e9
[   43.689572] RSP: 002b:00007fffc11ae478 EFLAGS: 00010202
[   43.693662] RAX: 00007fb1940ff200 RBX: 00000000000000f8 RCX: 000055886456a1e4
[   43.699826] RDX: 00000000000000b0 RSI: 000055886456a144 RDI: 00007fb1940ff200
[   43.705952] RBP: 0000558864563380 R08: 0000000000000008 R09: 00007fb1940ff2e0
[   43.712042] R10: 0000000000000088 R11: 00007fb1940ff2e8 R12: 000055886456a144
[   43.718128] R13: 00007fb17ae55b00 R14: 0000558864563380 R15: 0000558864565d98
[   43.724308] ---[ end trace bee8be573fc5b1ac ]---
[   43.760245] ------------[ cut here ]------------

and

[   43.760245] ------------[ cut here ]------------
[   43.763635] WARNING: CPU: 6 PID: 1268 at
drivers/gpu/drm/ttm/ttm_bo.c:517 ttm_bo_release+0x172/0x282 [ttm]
[   43.772151] Modules linked in: nf_nat_ftp nf_conntrack_ftp cfg80211
af_packet nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute
ip6table_nat ip6table_mangle ip6table_raw iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_mangle
iptable_raw nfnetlink ebtable_filter ebtables ip6table_filter
ip6_tables iptable_filter bnep it87 hwmon_vid snd_hda_codec_realtek
dm_mod dax snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi
snd_hda_intel btusb btbcm btintel bluetooth uvcvideo videobuf2_vmalloc
snd_usb_audio ecdh_generic videobuf2_memops videobuf2_v4l2
videobuf2_common input_leds led_class rfkill videodev snd_usbmidi_lib
mc joydev ecc coretemp kvm_intel kvm snd_intel_dspcfg irqbypass
snd_hda_codec snd_virtuoso snd_oxygen_lib snd_hwdep snd_hda_core
snd_mpu401_uart snd_rawmidi snd_seq snd_seq_device snd_pcm r8169
mxm_wmi snd_hrtimer iTCO_wdt gpio_ich psmouse realtek i2c_i801 pcspkr
tiny_power_button snd_timer mdio_devres libphy i2c_smbus wmi snd
i7core_edac
[   43.772216]  button soundcore acpi_cpufreq lpc_ich binfmt_misc nfsd
auth_rpcgss nfs_acl lockd fuse grace configfs sunrpc zram zsmalloc
ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 sr_mod cdrom
sd_mod usbhid uhci_hcd ehci_pci ehci_hcd amdgpu xhci_pci xhci_hcd
drm_ttm_helper pata_jmicron ttm ahci mfd_core gpu_sched libahci
firewire_ohci i2c_algo_bit firewire_core libata crc_itu_t
drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt
fb_sys_fops crc32c_intel serio_raw cfbcopyarea scsi_mod usbcore
usb_common drm drm_panel_orientation_quirks msr sha256_ssse3
sha256_generic libsha256 ipv6
[   43.917564] CPU: 6 PID: 1268 Comm: gnome-shell Tainted: G        W
I       5.11.9 #1
[   43.924298] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[   43.932222] RIP: 0010:ttm_bo_release+0x172/0x282 [ttm]
[   43.936216] Code: 75 05 e8 dd e0 e6 e0 41 ff c5 eb d4 e8 0f c9 b9
e0 c6 43 58 01 48 c7 c7 68 2a 50 a0 e8 08 8e fa e0 83 bb 9c 00 00 00
00 74 20 <0f> 0b c7 83 9c 00 00 00 00 00 00 00 4c 89 e7 e8 29 fc ff ff
48 8d
[   43.954467] RSP: 0000:ffffc900017e3bc8 EFLAGS: 00010202
[   43.958556] RAX: 0000000000000000 RBX: ffff888101675180 RCX: 0000000000000007
[   43.964564] RDX: 0000000000000001 RSI: 0000000000000246 RDI: ffffffffa0502a68
[   43.970637] RBP: ffff88810b525638 R08: ffff888128774078 R09: 0000000000000001
[   43.976652] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888101675000
[   43.982736] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   43.988813] FS:  00007fb19706e480(0000) GS:ffff888343d80000(0000)
knlGS:0000000000000000
[   43.995972] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   44.000565] CR2: 00007fb1940ff2e0 CR3: 00000001291fe000 CR4: 00000000000006e0
[   44.006648] Call Trace:
[   44.007804]  ttm_bo_move_accel_cleanup+0x109/0x238 [ttm]
[   44.011950]  amdgpu_bo_move+0x3c3/0x507 [amdgpu]
[   44.015486]  ttm_bo_handle_move_mem+0x73/0xf9 [ttm]
[   44.019215]  ttm_bo_validate+0xfa/0x16d [ttm]
[   44.022389]  amdgpu_bo_fault_reserve_notify+0xb7/0x134 [amdgpu]
[   44.027339]  amdgpu_ttm_fault+0x27/0x7c [amdgpu]
[   44.030823]  __do_fault+0x49/0x64
[   44.032949]  handle_mm_fault+0xb19/0xbf8
[   44.035665]  exc_page_fault+0x226/0x32b
[   44.038292]  ? asm_exc_page_fault+0x8/0x30
[   44.041220]  asm_exc_page_fault+0x1e/0x30
[   44.044066] RIP: 0033:0x7fb19b11b1ee
[   44.046393] Code: 4d 29 c1 4c 29 c2 48 3b 15 27 dc 11 00 0f 87 af
00 00 00 0f 10 01 0f 10 49 f0 0f 10 51 e0 0f 10 59 d0 48 83 e9 40 48
83 ea 40 <41> 0f 29 01 41 0f 29 49 f0 41 0f 29 51 e0 41 0f 29 59 d0 49
83 e9
[   44.064733] RSP: 002b:00007fffc11ae448 EFLAGS: 00010202
[   44.068843] RAX: 00007fb1940ff200 RBX: 00000000000000f8 RCX: 00005588645a6124
[   44.074947] RDX: 00000000000000b0 RSI: 00005588645a6084 RDI: 00007fb1940ff200
[   44.081043] RBP: 000055886459f2c0 R08: 0000000000000008 R09: 00007fb1940ff2e0
[   44.087136] R10: 0000000000000020 R11: 00007fb1940ff2e8 R12: 00005588645a6084
[   44.093210] R13: 00007fb17ae55b00 R14: 000055886459f2c0 R15: 00005588645a1cd8
[   44.099297] ---[ end trace bee8be573fc5b1ad ]---

There are others, but I am assuming there is a common cause here.

Cheers,
Chris
