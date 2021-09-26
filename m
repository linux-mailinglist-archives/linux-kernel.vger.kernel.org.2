Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D31A418B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 00:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhIZWEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 18:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhIZWEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 18:04:45 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFA3C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 15:03:08 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id v10so19439076ybq.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 15:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=oYXKR/Mag7aXu7AMWAffasa6r7aJ+9lbXrZkTwhLlsI=;
        b=GIROYOKSkEFNbSJYYijXYkX8YpNLNVnQ9PsdRMQp78Yitlf+8toiLKLYytFeQYPfZF
         IIelmkB0X0LKJNR0q3Om8/t/5cbc8LmV3Zr3O8+QdBI+XvhlfwQy4fTPqmBRZYE2lgor
         WlHzvlpWVVnsb5GR49zmaxHK4miIQZihvKwDRSLZGCDfixA1zMwd0hN0R4Yj/IoTDadh
         KRMabCCqwk0oCJ5Fga7hseRqaNcLPh9uTHrHxAka8o8W77btVPE4B4A6XZ8aE8PNfqOz
         jW4+t9xvJJUy2q6XSizjc6M9uK96GWkW4QwWCTxr/UENGcpRT7oIrQC5eRG3u+ocT8iY
         Dxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oYXKR/Mag7aXu7AMWAffasa6r7aJ+9lbXrZkTwhLlsI=;
        b=agncfqGnyqZdOpY6wroNQgvnApKhx4PjkQB2ljWUfeS4X0HIwwfrhjvUQZ/sfJqA0M
         xEsZUE7kLpNwRrdZ6EK02fwU9zDGwnj2JS+iIvZSxx/2bl+H6lg3Q7c/51R5sTpS10Uy
         tN41YeLyMaAEc8Wt2oBxrEwQfJJNoIqckjNv1iD8fTckPgMUA10wBI7xnZWJf/yhh/Zp
         /Wr18FM2O/QMyl4UVBd4Ln886IIilGJ50TleTvkWrMli43LHt2KbIsFfI1DkwOUjzNEc
         x2zvcWQpJhMriyDu5q806j/cQCazAZWwE9XUo2tPnubBcMa3sTqK5Yi8Wn2S3+hMymnC
         fyUg==
X-Gm-Message-State: AOAM5337AIoIHzdYtRXWnHELikTSESndI5KmmwSejo8WXpxPNtapVAnZ
        vzxRmC97MmainlzQnB7TobMi+sGWbb2nFz/5HCVBWJfsydZYVQ==
X-Google-Smtp-Source: ABdhPJxOyFHkENJkkL9psOjtUwF+Z+6kLBM7NKiVjmYmRveEOeJiX9U1wOTWIc1kbFBnynL9j8kBI6yXPJFy9j/soCo=
X-Received: by 2002:a05:6902:1547:: with SMTP id r7mr25358177ybu.72.1632693787653;
 Sun, 26 Sep 2021 15:03:07 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Rankin <rankincj@gmail.com>
Date:   Sun, 26 Sep 2021 23:02:55 +0100
Message-ID: <CAK2bqVJ4SS2Aieh4XWHOxmm12ku174yOursjua=LBwtXy3H=xw@mail.gmail.com>
Subject: [WARNING][AMDGPU] Warning in dmesg log from a vanilla 5.14.8 kernel.
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Warnings like this have appeared in every dmesg log from my vanilla
5.14.x kernels. My graphics card is a Radeon R7 360.

Cheers,
Chris

[  125.337204] ------------[ cut here ]------------
[  125.340617] WARNING: CPU: 0 PID: 1 at
drivers/gpu/drm/ttm/ttm_bo.c:409 ttm_bo_release+0x1c/0x266 [ttm]
[  125.348691] Modules linked in: nf_nat_ftp nf_conntrack_ftp cfg80211
af_packet nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_mangle
iptable_raw iptable_security nfnetlink ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter bnep it87 hwmon_vid dm_mod
dax snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi
ledtrig_audio snd_hda_intel btusb uvcvideo btbcm btintel
videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 bluetooth
videobuf2_common snd_usb_audio videodev ecdh_generic snd_usbmidi_lib
input_leds joydev led_class rfkill mc ecc coretemp kvm_intel kvm
gpio_ich iTCO_wdt mxm_wmi i2c_i801 snd_intel_dspcfg snd_hda_codec
snd_hwdep snd_virtuoso r8169 snd_oxygen_lib psmouse snd_mpu401_uart
realtek irqbypass
[  125.348768]  tiny_power_button snd_rawmidi mdio_devres i2c_smbus
libphy snd_hda_core snd_hrtimer button snd_seq i7core_edac lpc_ich wmi
pcspkr snd_seq_device snd_pcm snd_timer snd soundcore acpi_cpufreq
binfmt_misc nfsd auth_rpcgss nfs_acl lockd grace configfs sunrpc fuse
zram zsmalloc ip_tables x_tables ext4 crc32c_generic crc16 mbcache
jbd2 hid_microsoft usbhid sr_mod cdrom sd_mod amdgpu uhci_hcd
drm_ttm_helper ttm mfd_core ehci_pci ehci_hcd gpu_sched i2c_algo_bit
drm_kms_helper xhci_pci xhci_hcd cfbfillrect syscopyarea cfbimgblt
sysfillrect sysimgblt ahci fb_sys_fops cfbcopyarea libahci
pata_jmicron firewire_ohci firewire_core cec rc_core crc32c_intel
libata serio_raw crc_itu_t scsi_mod drm usbcore usb_common
drm_panel_orientation_quirks msr sha256_ssse3 sha256_generic ipv6
crc_ccitt
[  125.502077] CPU: 0 PID: 1 Comm: systemd Tainted: G          I       5.14.8 #1
[  125.508018] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[  125.515723] RIP: 0010:ttm_bo_release+0x1c/0x266 [ttm]
[  125.519619] Code: 44 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 41 56
41 55 41 54 4c 8d a7 90 fe ff ff 55 53 83 7f 4c 00 48 89 fb 48 8b 6f
e8 74 02 <0f> 0b 80 7b 18 00 48 8b 43 88 0f 85 ac 00 00 00 4c 8d 6b 90
49 39
[  125.537240] RSP: 0018:ffffc90000023e00 EFLAGS: 00010202
[  125.541226] RAX: 0000000000000001 RBX: ffff888125f9b1c8 RCX: 00000000000000b6
[  125.547152] RDX: 00000000000001b1 RSI: ffffffffa03140db RDI: ffff888125f9b1c8
[  125.553154] RBP: ffff888109785308 R08: 0000000000000001 R09: 0000000000000001
[  125.559012] R10: 0000000000000000 R11: ffff888103db3600 R12: ffff888125f9b058
[  125.565089] R13: ffff888144da66c8 R14: ffff888124c94000 R15: 0000000000000000
[  125.570988] FS:  00007f9e13a2e340(0000) GS:ffff888343d00000(0000)
knlGS:0000000000000000
[  125.578007] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  125.582664] CR2: 00007f0b81962388 CR3: 00000001024c8000 CR4: 00000000000006e0
[  125.588559] Call Trace:
[  125.589745]  amdgpu_bo_unref+0x15/0x1e [amdgpu]
[  125.593187]  amdgpu_gem_object_free+0x2b/0x45 [amdgpu]
[  125.597167]  drm_gem_dmabuf_release+0x11/0x1a [drm]
[  125.600849]  dma_buf_release+0x36/0x6e
[  125.603348]  __dentry_kill+0xf5/0x12f
[  125.605770]  dput+0xfc/0x136
[  125.607362]  __fput+0x16a/0x1bc
[  125.609297]  task_work_run+0x64/0x75
[  125.611635]  exit_to_user_mode_prepare+0x88/0x112
[  125.615205]  syscall_exit_to_user_mode+0x14/0x1f
[  125.618652]  do_syscall_64+0x7a/0x80
[  125.621003]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  125.624909] RIP: 0033:0x7f9e146ae9db
[  125.627335] Code: 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48
83 ec 18 89 7c 24 0c e8 33 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 91 fc ff ff
8b 44
[  125.645654] RSP: 002b:00007ffe43bd0760 EFLAGS: 00000293 ORIG_RAX:
0000000000000003
[  125.652171] RAX: 0000000000000000 RBX: 00007f9e13a2e0f8 RCX: 00007f9e146ae9db
[  125.658361] RDX: 0000000000000002 RSI: 000000055fbb59c6 RDI: 0000000000000068
[  125.664514] RBP: 0000000000000068 R08: 0000000000000000 R09: 0000000000000000
[  125.670710] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
[  125.676854] R13: 000055fbb418e300 R14: 000055fbb41490f9 R15: 000055fbb5ac6930
[  125.682937] ---[ end trace a045cf707562d1cb ]---
