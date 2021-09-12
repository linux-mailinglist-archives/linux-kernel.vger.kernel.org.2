Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF88407D1A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 13:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbhILMAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 08:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhILMAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 08:00:33 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1678CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 04:59:19 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id m70so13117265ybm.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 04:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=IIHBvruIapOqOohT0NrrHVYEV+3ZxanDs7AfVsKlwxk=;
        b=adp9BSPztz+dPJOCCFZU8wYtUSi52w3/FbS0IJXXIvZZ4E6f9RzJ+7JU5JonKpfeWJ
         lxwhnBq58z68bKBwU1at6BYN4VRJxBKasSaVwvKtaHBF+vqFkHGLqpzIW559ndR4kU9h
         eS2Y0NQbxtKwzkXJFa/SUwBQq1bGAz/st325eMVZFQXTei8Xl6G2NCWa17I4EQJaQ2wo
         8BziMYhFuxoAjOg5bsggQCV8cWkPC6UfHgLfMSmPEwLbDcslf7fGCUmjeNJd89vNHfsd
         2Xkcd8I1svhL4QXoK9G7y0EN7YYMbtJY3ghn8XXZpiyAhY39FKVWLdHdWuMnVZYA1WRA
         BjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IIHBvruIapOqOohT0NrrHVYEV+3ZxanDs7AfVsKlwxk=;
        b=30e/j9CFpdfgSbR2MdhRQJhgCnXCssiX4D4Alu3w6pyJYgNl4N0KN7t0HHXGDtem1r
         fpMLsseqc/5l5A9mak1i4kAO5cbckp+1ILE6FsRcOguNTvo+3T30Vev0PREhwd8NeyYs
         ryaJPyOnFQUNyo53Qt3ywcs30gF2pv4lSM9zmtfIzlh5NQ/OV4+nbJTzW5yDdv7X+piU
         TrFwjvoRf514xUJl0adHZV6JF0QwWFHIFu/+0XQKwH3/zou0OyihFtTE35TZhMrPYZPB
         zDuZMnHmhWTsjYWpIbOAiyRZy33bQBQDF8Sv1divs+HnOR/4x2Vcy30xZVwXzqD558hS
         hlKg==
X-Gm-Message-State: AOAM533MvOeldIPYxh0ItD/ijOlvzVHPgLSWKKYB/o/zFgx5BM50p+MB
        PmmhOO/SJF+HmW/BTMsVcyF1d91Yeh2V9o6QbmKGvTR2x98=
X-Google-Smtp-Source: ABdhPJxJ+5Qw4HvsniSy9dLnGXpDFc8ekyXKifpmpRVmHSMh0F/VxnK7k7eEak5V/5bwDioGTNeGe3yjzv5Ws4ejnGY=
X-Received: by 2002:a25:b7d3:: with SMTP id u19mr8360848ybj.158.1631447957887;
 Sun, 12 Sep 2021 04:59:17 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Rankin <rankincj@gmail.com>
Date:   Sun, 12 Sep 2021 12:59:06 +0100
Message-ID: <CAK2bqVJ07fNtQqVd6_RJzAR+cCzGqFz-GTcRPhhGLudbEEPTUw@mail.gmail.com>
Subject: [WARNING][DRM] Linux 5.14.3
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have just booted a vanilla 5.14.3 kernel and noticed this in the dmesg log.

This is with a fairly old Radeon R7 360:
02:00.0 0300: 1002:665f (rev 81) (prog-if 00 [VGA controller])
    Subsystem: 1682:7360
    Flags: bus master, fast devsel, latency 0, IRQ 42
    Memory at b0000000 (64-bit, prefetchable) [size=256M]
    Memory at cf800000 (64-bit, prefetchable) [size=8M]
    I/O ports at ce00 [size=256]
    Memory at fbc80000 (32-bit, non-prefetchable) [size=256K]
    Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
    Capabilities: <access denied>
    Kernel driver in use: amdgpu
    Kernel modules: amdgpu

02:00.1 0403: 1002:aac0
    Subsystem: 1682:aac0
    Flags: bus master, fast devsel, latency 0, IRQ 45
    Memory at fbcfc000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: <access denied>
    Kernel driver in use: snd_hda_intel
    Kernel modules: snd_hda_intel

Cheers,
Chris

[  122.232938] ------------[ cut here ]------------
[  122.236497] WARNING: CPU: 4 PID: 1 at
drivers/gpu/drm/ttm/ttm_bo.c:409 ttm_bo_release+0x1c/0x266 [ttm]
[  122.245484] Modules linked in: nf_nat_ftp nf_conntrack_ftp cfg80211
af_packet nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_mangle
iptable_raw iptable_security nfnetlink ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter bnep it87 hwmon_vid dm_mod
dax snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi
ledtrig_audio snd_hda_intel uvcvideo snd_intel_dspcfg snd_usb_audio
snd_hda_codec btusb snd_hda_core videobuf2_vmalloc snd_usbmidi_lib
videobuf2_memops snd_virtuoso snd_hwdep btbcm snd_oxygen_lib
snd_mpu401_uart videobuf2_v4l2 btintel snd_seq snd_rawmidi
videobuf2_common input_leds bluetooth videodev led_class ecdh_generic
joydev snd_seq_device mc rfkill snd_pcm ecc coretemp kvm_intel r8169
snd_hrtimer kvm
[  122.245552]  snd_timer realtek snd gpio_ich iTCO_wdt mdio_devres
mxm_wmi i2c_i801 irqbypass psmouse libphy tiny_power_button soundcore
lpc_ich i2c_smbus button pcspkr wmi i7core_edac acpi_cpufreq nfsd
auth_rpcgss nfs_acl binfmt_misc lockd grace sunrpc fuse configfs zram
zsmalloc ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2
hid_microsoft usbhid sr_mod cdrom sd_mod amdgpu drm_ttm_helper ttm
uhci_hcd mfd_core gpu_sched i2c_algo_bit ahci firewire_ohci
pata_jmicron libahci drm_kms_helper firewire_core xhci_pci libata
ehci_pci cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt
fb_sys_fops ehci_hcd cfbcopyarea cec crc32c_intel crc_itu_t xhci_hcd
serio_raw scsi_mod rc_core drm usbcore usb_common
drm_panel_orientation_quirks msr sha256_ssse3 sha256_generic ipv6
crc_ccitt
[  122.401389] CPU: 2 PID: 1 Comm: systemd Tainted: G          I       5.14.3 #1
[  122.407508] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[  122.415086] RIP: 0010:ttm_bo_release+0x1c/0x266 [ttm]
[  122.419019] Code: 44 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 41 56
41 55 41 54 4c 8d a7 90 fe ff ff 55 53 83 7f 4c 00 48 89 fb 48 8b 6f
e8 74 02 <0f> 0b 80 7b 18 00 48 8b 43 88 0f 85 ac 00 00 00 4c 8d 6b 90
49 39
[  122.437378] RSP: 0018:ffffc90000023e00 EFLAGS: 00010202
[  122.441459] RAX: 0000000000000001 RBX: ffff88810223f5c8 RCX: 0000000000000001
[  122.447594] RDX: 000000000000013b RSI: ffffffffa03380db RDI: ffff88810223f5c8
[  122.453695] RBP: ffff88810b845308 R08: 0000000000000001 R09: 0000000000000003
[  122.459771] R10: 00000000001d6878 R11: ffff88812675a600 R12: ffff88810223f458
[  122.465851] R13: ffff88813aff2da0 R14: ffff88814859a0c0 R15: 0000000000000000
[  122.471931] FS:  00007fb4861a8340(0000) GS:ffff888343c80000(0000)
knlGS:0000000000000000
[  122.479028] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  122.483683] CR2: 00007f8037604948 CR3: 0000000101ed4000 CR4: 00000000000006e0
[  122.489775] Call Trace:
[  122.490939]  amdgpu_bo_unref+0x15/0x1e [amdgpu]
[  122.494527]  amdgpu_gem_object_free+0x2b/0x45 [amdgpu]
[  122.498733]  drm_gem_dmabuf_release+0x11/0x1a [drm]
[  122.502357]  dma_buf_release+0x36/0x6e
[  122.504852]  __dentry_kill+0xf5/0x12f
[  122.507282]  dput+0xfc/0x136
[  122.508924]  __fput+0x16a/0x1bc
[  122.510844]  task_work_run+0x64/0x75
[  122.513178]  exit_to_user_mode_prepare+0x88/0x112
[  122.516724]  syscall_exit_to_user_mode+0x14/0x1f
[  122.520219]  do_syscall_64+0x7a/0x80
[  122.522586]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  122.526510] RIP: 0033:0x7fb486e289db
[  122.528822] Code: 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48
83 ec 18 89 7c 24 0c e8 33 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 91 fc ff ff
8b 44
[  122.546975] RSP: 002b:00007fff4fa2a920 EFLAGS: 00000293 ORIG_RAX:
0000000000000003
[  122.553586] RAX: 0000000000000000 RBX: 00007fb4861a80f8 RCX: 00007fb486e289db
[  122.559680] RDX: 0000000000000002 RSI: 000000055e185b46 RDI: 0000000000000068
[  122.565763] RBP: 0000000000000068 R08: 0000000000000000 R09: 0000000000000000
[  122.571847] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
[  122.577932] R13: 000055e1854f6300 R14: 000055e1854b10f9 R15: 000055e185c80130
[  122.584027] ---[ end trace fe16ae14a1eb3188 ]---
