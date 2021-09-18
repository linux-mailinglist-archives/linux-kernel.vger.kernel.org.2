Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4A44106FC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 16:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238423AbhIROJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 10:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbhIROJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 10:09:47 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1A5C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 07:08:23 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 72so15038609qkk.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 07:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=lgH42GZq4Rvj9dC6ZTqxsXYQ3tMCRHyhHlLuUVzYyrw=;
        b=GiVXrBSJgfuFE6FoXpVKxneFep8jetgtTwrCU0UKhYyrlmk8OhAZ97jZp/eXY0b2Ct
         s0S9fn1YAcdtq2cYbvT6PGFaBZ3ivyJHACZcFZpB0oJxERpBgj9qPkDqqOBkxnW6Kbxv
         Za6wyikX0iayTHGdwIZAtCtymtkvhCD0Te2Mmdb6V40CSpENMOR49PsT9oERRIVDhFkM
         exyH3hJcHylrPJVFnBQ9mlKYVg30y74abyZ21IHrutUQ1HibvUWp++d9kU/aQ/iyHJxu
         l3hY5yuLM3BH5jbd0r1MHLafgT/OEnosYR1KjTIHJX8mKf6WQ04oVCkCF6EINGQfXCW7
         7KJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lgH42GZq4Rvj9dC6ZTqxsXYQ3tMCRHyhHlLuUVzYyrw=;
        b=4EZYY7ZtBnflDd1xgrYt9tmhs4WvJr6LxxFdrbuEhlSf1Aa/H7uYafiaOWlwXnCp9i
         xMOOY5aTgLQs4KaKm2HWjLgwuG/uCVTFDl/hIGMWI3CRXxPlKqI/KS8K+VjC/5SHg2EU
         /cqXrgPnKD50VR/+d0rWicHSmmFs9O+H515whARCJ/bDik1eWawUxSt6m51LilS15L0x
         Hoc/C67/5NUN/NbyE/XygYgMNjX3DxQ9eOa+VDTmG5mfdHjnNOjSF3rmLa+BgTbEKxLi
         xZHh+Qg+xS+5Twrdj/YP24ZiEQuuaCfvHf97gq1DkFlRsTjwYtzcZ4fPLsfuNhNpgV9h
         D9KQ==
X-Gm-Message-State: AOAM530+XiSH4HIPqWPS1SAK8h3mNufqD6jx/sQmZhgeQXPC/pNWFU5R
        mGSxHL2Um4wAaO9E1d9MLbNjPEJHvrI0yWQKIuVcFS+l6hTnpA==
X-Google-Smtp-Source: ABdhPJwL4xz/wjvm+1s0SfeUfvdAAo4uALW4/WuXTZT2GfOw5whU79Gqb0Oe5Zeb5P4N3aOE09LVD4zvJZvpkSN3zv0=
X-Received: by 2002:a25:d6cf:: with SMTP id n198mr19764512ybg.535.1631974102230;
 Sat, 18 Sep 2021 07:08:22 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Rankin <rankincj@gmail.com>
Date:   Sat, 18 Sep 2021 15:08:11 +0100
Message-ID: <CAK2bqVJo8TZUwu4-5VcY0MEezM7gJJq77prMpCB=FdA24Fe7MA@mail.gmail.com>
Subject: [WARNING][AMDGPU] dmesg warning with vanilla 5.14.6
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've noticed warnings like this with every 5.14.x kernel that I've
tested, i.e. 5.14.3 - 5.14.6.

I am using a Radeon R7 360.

Cheers,
Chris.

[   95.348074] ------------[ cut here ]------------
[   95.354674] WARNING: CPU: 0 PID: 1 at
drivers/gpu/drm/ttm/ttm_bo.c:409 ttm_bo_release+0x1c/0x266 [ttm]
[   95.386490] Modules linked in: nf_nat_ftp nf_conntrack_ftp cfg80211
af_packet nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_mangle
iptable_raw iptable_security nfnetlink ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter bnep it87 hwmon_vid dm_mod
dax snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio
snd_hda_codec_hdmi snd_hda_intel uvcvideo videobuf2_vmalloc
videobuf2_memops videobuf2_v4l2 videobuf2_common snd_usb_audio
videodev snd_usbmidi_lib mc input_leds joydev snd_intel_dspcfg
led_class btusb snd_hda_codec btbcm btintel bluetooth snd_virtuoso
snd_oxygen_lib snd_mpu401_uart snd_hwdep snd_rawmidi snd_hda_core
ecdh_generic snd_seq rfkill ecc snd_seq_device snd_pcm coretemp
iTCO_wdt mxm_wmi snd_hrtimer gpio_ich
[   95.386603]  kvm_intel kvm pcspkr r8169 psmouse snd_timer snd
i2c_i801 irqbypass i2c_smbus soundcore realtek i7core_edac mdio_devres
wmi libphy tiny_power_button lpc_ich button acpi_cpufreq nfsd
binfmt_misc auth_rpcgss nfs_acl lockd grace sunrpc fuse configfs zram
zsmalloc ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2
hid_microsoft usbhid sr_mod cdrom sd_mod amdgpu uhci_hcd
drm_ttm_helper ttm firewire_ohci mfd_core gpu_sched crc32c_intel
pata_jmicron ahci i2c_algo_bit firewire_core libahci serio_raw
drm_kms_helper ehci_pci crc_itu_t ehci_hcd libata xhci_pci cfbfillrect
syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fops cfbcopyarea
xhci_hcd cec rc_core drm scsi_mod usbcore usb_common
drm_panel_orientation_quirks msr sha256_ssse3 sha256_generic ipv6
crc_ccitt
[   95.539875] CPU: 0 PID: 1 Comm: systemd Tainted: G          I       5.14.6 #1
[   95.545740] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[   95.553331] RIP: 0010:ttm_bo_release+0x1c/0x266 [ttm]
[   95.557140] Code: 44 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 41 56
41 55 41 54 4c 8d a7 90 fe ff ff 55 53 83 7f 4c 00 48 89 fb 48 8b 6f
e8 74 02 <0f> 0b 80 7b 18 00 48 8b 43 88 0f 85 ac 00 00 00 4c 8d 6b 90
49 39
[   95.574603] RSP: 0018:ffffc90000023e00 EFLAGS: 00010202
[   95.578582] RAX: 0000000000000001 RBX: ffff88812164edc8 RCX: 00000000000000d6
[   95.584459] RDX: 00000000000000ef RSI: ffffffffa038f0db RDI: ffff88812164edc8
[   95.590351] RBP: ffff888108365308 R08: 0000000000000001 R09: 0000000000000003
[   95.596208] R10: 000000000014cada R11: ffff8881001c7a00 R12: ffff88812164ec58
[   95.602052] R13: ffff8881095c26c8 R14: ffff88811f94c540 R15: 0000000000000000
[   95.607943] FS:  00007f2ef4aab340(0000) GS:ffff888343c00000(0000)
knlGS:0000000000000000
[   95.614774] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   95.619268] CR2: 000055b1a2855030 CR3: 0000000101c2e000 CR4: 00000000000006f0
[   95.625109] Call Trace:
[   95.626341]  amdgpu_bo_unref+0x15/0x1e [amdgpu]
[   95.629754]  amdgpu_gem_object_free+0x2b/0x45 [amdgpu]
[   95.633693]  drm_gem_dmabuf_release+0x11/0x1a [drm]
[   95.637338]  dma_buf_release+0x36/0x6e
[   95.639832]  __dentry_kill+0xf5/0x12f
[   95.642260]  dput+0xfc/0x136
[   95.643881]  __fput+0x16a/0x1bc
[   95.645789]  task_work_run+0x64/0x75
[   95.648110]  exit_to_user_mode_prepare+0x88/0x112
[   95.651565]  syscall_exit_to_user_mode+0x14/0x1f
[   95.654899]  do_syscall_64+0x7a/0x80
[   95.657235]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   95.661006] RIP: 0033:0x7f2ef572b9b7
[   95.663296] Code: 00 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7
0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 33 fc
ff ff
[   95.680773] RSP: 002b:00007ffe4e05dbd8 EFLAGS: 00000246 ORIG_RAX:
0000000000000003
[   95.687056] RAX: 0000000000000000 RBX: 00007f2ef4aab0f8 RCX: 00007f2ef572b9b7
[   95.692904] RDX: 000055b1a28e2790 RSI: 000055b1a2796010 RDI: 0000000000000068
[   95.698753] RBP: 0000000000000068 R08: 000055b1a2855030 R09: 0000000000000000
[   95.704593] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[   95.710433] R13: 000055b1a20c7300 R14: 000055b1a20820f9 R15: 000055b1a2a331d0
[   95.716311] ---[ end trace ea4570c1033ff6a3 ]---
