Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E946A4167BB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243383AbhIWVxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbhIWVx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:53:29 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AABC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:51:57 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id z5so1411337ybj.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=uerNcdxCE7vVvw4ndgfZ76p8oont9ncpsW2kNb/6NBs=;
        b=l7B91PiAWLl55bYfcxqKLcw9TiesVg/tf4Y2ADXdf6S7q2YPZzg3BsH14uUL15Fhtt
         6de5bVBK0OWZoTr9+xCJ7mBnCV7ILENRbUviIuge/bRCPoHTfrd2EV8hlgkA4Wz89n7s
         0gB9n8KCc28340Yl7012u6fbx5jh4DiBP4YddjjNpXJwZwJYkLbT+bb30xBXNQNLjveH
         sxlny2tvYIxynHRNA2/rL5Wif8vHKH8qVQUSqaqXvDGTnPdit43+QD8u7Q5fBxVSqTXa
         NFa6S+bC8UsyXEb+t3cz+npUH7tnNrbu6tKX2tOP9UzNIUGUOUwA9ldFrLQnCy+6UCM1
         ovPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=uerNcdxCE7vVvw4ndgfZ76p8oont9ncpsW2kNb/6NBs=;
        b=qK3ULL+RZqwANchoiVAD/w6Z0QgahxDgUglckGGvp8pRuFQZtxpV+WTOaz8nybFukv
         fsL9EDgJFxfDXZG0mtM0Ys9LCtAKzjH8w8+vXaBUgMVBPtUHJC4hUiKFIAlL4MNbx9wu
         hWCWWgZr++56gPt809tvs7qDc9QtcNw5dMqhqLJcUe18S80Kba/aBJuTDsu9M7Xayn5X
         4SwixqcMVbXGFmQG7skbw80eABjWTm1sg1a08ISeaQEURyCUbx/uGJiPte5QUlzzwWrN
         c5IxLkXZ1Vg9yM7iiKTndM/aJBn8NnsXqJbis6k4CwXWsXhqsydizhgarvYcIriNC37o
         r+eQ==
X-Gm-Message-State: AOAM531Th1F0hIYCTpHJSxMkNlxpO6f8ebwPj9ip5Dmc1HwDyuEDqP0G
        2U52muRL6zolVKkdRCzAhFIVS5BVojWg/xh+NFWBLG6JgLa19A==
X-Google-Smtp-Source: ABdhPJy0fLpqlo7AZQBR6/pqKVlE8KhJSa8asNmyrUNipK/cMG1dgwzx6iCBho+3F3b1C7ecCy04ZseLP8VQ0d/Ow9A=
X-Received: by 2002:a25:5b87:: with SMTP id p129mr7909613ybb.188.1632433916243;
 Thu, 23 Sep 2021 14:51:56 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Rankin <rankincj@gmail.com>
Date:   Thu, 23 Sep 2021 22:51:45 +0100
Message-ID: <CAK2bqVL7YXcHLRsWGfL4kbbODzN9=czhydaFm8FmNcbAR9p3DQ@mail.gmail.com>
Subject: [WARNING][AMDGPU] Oops in Linux 5.14.7
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This warning appears in my vanilla 5.14.7 kernel with my Radeon R7 360
(Bonnaire) GPU.

Cheers,
Chris

[  171.605463] ------------[ cut here ]------------
[  171.624230] WARNING: CPU: 2 PID: 1 at
drivers/gpu/drm/ttm/ttm_bo.c:409 ttm_bo_release+0x1c/0x266 [ttm]
[  171.632344] Modules linked in: nf_nat_ftp nf_conntrack_ftp cfg80211
af_packet nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_mangle
iptable_raw iptable_security nfnetlink ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter bnep it87 hwmon_vid dm_mod
dax snd_hda_codec_realtek snd_hda_codec_hdmi snd_hda_codec_generic
ledtrig_audio snd_hda_intel uvcvideo videobuf2_vmalloc
videobuf2_memops videobuf2_v4l2 videobuf2_common snd_usb_audio
videodev btusb btbcm snd_usbmidi_lib btintel input_leds joydev
led_class mc bluetooth ecdh_generic rfkill ecc snd_intel_dspcfg
snd_hda_codec snd_virtuoso snd_oxygen_lib snd_mpu401_uart snd_hwdep
snd_rawmidi snd_hda_core snd_seq snd_seq_device coretemp snd_pcm
mxm_wmi snd_hrtimer kvm_intel
[  171.632408]  iTCO_wdt snd_timer kvm gpio_ich snd soundcore
irqbypass psmouse r8169 i2c_i801 pcspkr realtek mdio_devres i2c_smbus
libphy wmi i7core_edac lpc_ich tiny_power_button button acpi_cpufreq
binfmt_misc nfsd auth_rpcgss nfs_acl lockd grace sunrpc configfs fuse
zram zsmalloc ip_tables x_tables ext4 crc32c_generic crc16 mbcache
jbd2 hid_microsoft usbhid sr_mod cdrom sd_mod amdgpu drm_ttm_helper
ttm mfd_core gpu_sched uhci_hcd i2c_algo_bit drm_kms_helper
firewire_ohci firewire_core cfbfillrect syscopyarea cfbimgblt
sysfillrect sysimgblt xhci_pci crc32c_intel crc_itu_t ehci_pci
fb_sys_fops cfbcopyarea cec serio_raw ehci_hcd rc_core xhci_hcd ahci
pata_jmicron libahci libata drm scsi_mod usbcore usb_common
drm_panel_orientation_quirks msr sha256_ssse3 sha256_generic ipv6
crc_ccitt
[  171.788213] CPU: 3 PID: 1 Comm: systemd Tainted: G          I       5.14.7 #1
[  171.794422] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[  171.802359] RIP: 0010:ttm_bo_release+0x1c/0x266 [ttm]
[  171.806146] Code: 44 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 41 56
41 55 41 54 4c 8d a7 90 fe ff ff 55 53 83 7f 4c 00 48 89 fb 48 8b 6f
e8 74 02 <0f> 0b 80 7b 18 00 48 8b 43 88 0f 85 ac 00 00 00 4c 8d 6b 90
49 39
[  171.824154] RSP: 0018:ffffc90000023e00 EFLAGS: 00010202
[  171.828183] RAX: 0000000000000001 RBX: ffff88813bbc09c8 RCX: 0000000000000051
[  171.834267] RDX: 0000000000000191 RSI: ffffffffa03690db RDI: ffff88813bbc09c8
[  171.840229] RBP: ffff888109505308 R08: 0000000000000001 R09: 0000000000000003
[  171.846272] R10: 00000000001d0a5e R11: ffff888126bb6200 R12: ffff88813bbc0858
[  171.852321] R13: ffff88817c130490 R14: ffff88816982be40 R15: 0000000000000000
[  171.858439] FS:  00007f068b32c340(0000) GS:ffff888343cc0000(0000)
knlGS:0000000000000000
[  171.865527] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  171.870173] CR2: 00007f5e2cc32000 CR3: 00000001022bc000 CR4: 00000000000006e0
[  171.876265] Call Trace:
[  171.877500]  amdgpu_bo_unref+0x15/0x1e [amdgpu]
[  171.881001]  amdgpu_gem_object_free+0x2b/0x45 [amdgpu]
[  171.885090]  drm_gem_dmabuf_release+0x11/0x1a [drm]
[  171.888802]  dma_buf_release+0x36/0x6e
[  171.891349]  __dentry_kill+0xf5/0x12f
[  171.893782]  dput+0xfc/0x136
[  171.895448]  __fput+0x16a/0x1bc
[  171.897493]  task_work_run+0x64/0x75
[  171.899911]  exit_to_user_mode_prepare+0x88/0x112
[  171.903448]  syscall_exit_to_user_mode+0x14/0x1f
[  171.906908]  do_syscall_64+0x7a/0x80
[  171.909269]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  171.913185] RIP: 0033:0x7f068bfac9db
[  171.915546] Code: 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48
83 ec 18 89 7c 24 0c e8 33 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 91 fc ff ff
8b 44
[  171.933787] RSP: 002b:00007fff4cbdd7c0 EFLAGS: 00000293 ORIG_RAX:
0000000000000003
[  171.940358] RAX: 0000000000000000 RBX: 00007f068b32c0f8 RCX: 00007f068bfac9db
[  171.946448] RDX: 0000000000000002 RSI: 000000055fdf5096 RDI: 0000000000000068
[  171.952450] RBP: 0000000000000068 R08: 0000000000000000 R09: 0000000000000000
[  171.958521] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
[  171.964616] R13: 000055fdf46b2300 R14: 000055fdf466d0f9 R15: 000055fdf4fe6f50
[  171.970709] ---[ end trace 7e21121d1452c738 ]---
