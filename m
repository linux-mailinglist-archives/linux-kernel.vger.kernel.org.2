Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3A743093E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 15:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343635AbhJQNKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 09:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242195AbhJQNK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 09:10:29 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9343DC061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 06:08:19 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id a7so565546yba.6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 06:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=AFQZgh+W6spY1vsVpeEDTs8NkaVb8hN0DxEahcmE9p8=;
        b=bollDn23qfsMjPMfWVxlqL8403qX5dX64D8YsJNzDC8EAsalefPd+Oi690YSZ5hWU8
         HX6Ch+gIv9nYNkMDFe1H1YVwg3HwlRctRBE7OtK2olkLx5WJyFVf1RsZr28wV5eZlGv1
         VuE81hOhGZ+PmaHExUEbwYX9HawyDrEWwofm5vtqw9i5yxuefyOP3YRVyw2A8xBDb/xv
         8z2xvmWJemjyWTB2OjURvinDvELwzJSICMXSgPamHXtutZGBT5oXcRWnxXiaaeERiyEK
         QQG5zCWmt2EpQfdh1eQvspTG3BRo5/UfLPRkmIjsvnfC+T03T5eVkE522PAYUzqB7Zjo
         TUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AFQZgh+W6spY1vsVpeEDTs8NkaVb8hN0DxEahcmE9p8=;
        b=TGK+rdw8ulPqRYSAV2Pbj8FE7pDk9oLHcyXIlbK8/dvZ+IggmK8y26aDSXxgQ9FU2x
         2kTT3/Uw8F2MMgRMV60ldMC1x3ou1i1DpPQJ8VUqzlqypos/nwUF18jO8N0EuvKr8zEp
         QXxXVXjyGoEN1II3lgcpXo4I7NPv0pu/mSh2FUbM0J9lBJh8XxdMiq/GNMDBYZTy1CvJ
         ozawwSbSzXcDJm7j7iLry+gfg+guU6R1YaXR/WeudGvMU0Vku/iA9mVGXv7sxt+94G3J
         SesiXpe0yQwENZ77zdx1xqrmFKGHTLehccMFIvkbug+VTNRR2NihLWfcCM1MMXnoxw6+
         iRPw==
X-Gm-Message-State: AOAM5310wSzYx36nqBkgEfcnv8RsPu+uKsvBn/4WmwoPqW9eqfba4f2s
        SdGWiiZqAT5yAk3HX/LvWXYK23Ql8JxosFnfaKAm8y2bPzo=
X-Google-Smtp-Source: ABdhPJzAq50w3PR0dsNpC6TRO4Ab88OJnNjzEkJWZVG8dO3VJke2njVVKaNLiaXAINPTghl59W+P/COGtuHcIrkuhjs=
X-Received: by 2002:a25:aaec:: with SMTP id t99mr22580186ybi.211.1634476098502;
 Sun, 17 Oct 2021 06:08:18 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Rankin <rankincj@gmail.com>
Date:   Sun, 17 Oct 2021 14:08:07 +0100
Message-ID: <CAK2bqVJ1jAzggrL44A0Q=3okwFU_qKHmw7nCD5kxdMA95P_Q0w@mail.gmail.com>
Subject: [AMDGPU][WARN] dmesg warning with amdgpu module, vanilla 5.14.13
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am still seeing this WARN message in my dmesg output:

[   98.362594] ------------[ cut here ]------------
[   98.365949] WARNING: CPU: 4 PID: 1 at
drivers/gpu/drm/ttm/ttm_bo.c:409 ttm_bo_release+0x1c/0x266 [ttm]
[   98.374148] Modules linked in: nf_nat_ftp nf_conntrack_ftp cfg80211
af_packet nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_mangle
iptable_raw iptable_security nfnetlink ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter bnep it87 hwmon_vid dm_mod
dax snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio
snd_hda_codec_hdmi snd_hda_intel btusb btbcm btintel bluetooth
uvcvideo ecdh_generic videobuf2_vmalloc videobuf2_memops rfkill ecc
videobuf2_v4l2 coretemp videobuf2_common snd_usb_audio videodev
snd_usbmidi_lib mc input_leds joydev kvm_intel led_class kvm
snd_intel_dspcfg snd_hda_codec snd_virtuoso snd_hwdep snd_oxygen_lib
irqbypass snd_hda_core snd_mpu401_uart snd_rawmidi r8169 snd_seq
pcspkr psmouse snd_seq_device
[   98.374246]  i2c_i801 snd_pcm snd_hrtimer iTCO_wdt gpio_ich realtek
mxm_wmi snd_timer snd mdio_devres soundcore libphy tiny_power_button
button i2c_smbus lpc_ich wmi i7core_edac acpi_cpufreq nfsd auth_rpcgss
nfs_acl binfmt_misc lockd grace sunrpc fuse configfs zram zsmalloc
ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2
hid_microsoft usbhid sr_mod cdrom sd_mod amdgpu uhci_hcd pata_jmicron
ehci_pci xhci_pci drm_ttm_helper ehci_hcd ttm mfd_core gpu_sched
i2c_algo_bit drm_kms_helper xhci_hcd ahci libahci cfbfillrect
syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fops cfbcopyarea
crc32c_intel serio_raw cec libata rc_core firewire_ohci firewire_core
crc_itu_t scsi_mod drm usbcore usb_common drm_panel_orientation_quirks
msr sha256_ssse3 sha256_generic ipv6 crc_ccitt
[   98.530199] CPU: 3 PID: 1 Comm: systemd Tainted: G          I
5.14.13 #1
[   98.536463] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[   98.544126] RIP: 0010:ttm_bo_release+0x1c/0x266 [ttm]
[   98.547889] Code: 44 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 41 56
41 55 41 54 4c 8d a7 90 fe ff ff 55 53 83 7f 4c 00 48 89 fb 48 8b 6f
e8 74 02 <0f> 0b 80 7b 18 00 48 8b 43 88 0f 85 ac 00 00 00 4c 8d 6b 90
49 39
[   98.565413] RSP: 0018:ffffc90000023e00 EFLAGS: 00010202
[   98.569340] RAX: 0000000000000001 RBX: ffff88813f64fdc8 RCX: 000000000000004b
[   98.575174] RDX: 00000000000000f5 RSI: ffffffffa02380db RDI: ffff88813f64fdc8
[   98.581004] RBP: ffff88810aca5308 R08: 0000000000000001 R09: 0000000000000003
[   98.586833] R10: 00000000003bd4c9 R11: ffff88810b578000 R12: ffff88813f64fc58
[   98.592668] R13: ffff8881445cdb60 R14: ffff88810f3d8f00 R15: 0000000000000000
[   98.598502] FS:  00007fe4181ab340(0000) GS:ffff888343cc0000(0000)
knlGS:0000000000000000
[   98.605306] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   98.609925] CR2: 00005587fc30f000 CR3: 0000000101ba2000 CR4: 00000000000006e0
[   98.615929] Call Trace:
[   98.617086]  amdgpu_bo_unref+0x15/0x1e [amdgpu]
[   98.620431]  amdgpu_gem_object_free+0x2b/0x45 [amdgpu]
[   98.624353]  drm_gem_dmabuf_release+0x11/0x1a [drm]
[   98.627953]  dma_buf_release+0x36/0x6e
[   98.630410]  __dentry_kill+0xf5/0x12f
[   98.632776]  dput+0xfc/0x136
[   98.634364]  __fput+0x16a/0x1bc
[   98.636209]  task_work_run+0x64/0x75
[   98.638489]  exit_to_user_mode_prepare+0x88/0x112
[   98.641893]  syscall_exit_to_user_mode+0x14/0x1f
[   98.645247]  do_syscall_64+0x7a/0x80
[   98.647526]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   98.651286] RIP: 0033:0x7fe418e2b9db
[   98.653569] Code: 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48
83 ec 18 89 7c 24 0c e8 33 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 91 fc ff ff
8b 44
[   98.671062] RSP: 002b:00007ffdeed45b00 EFLAGS: 00000293 ORIG_RAX:
0000000000000003
[   98.677337] RAX: 0000000000000000 RBX: 00007fe4181ab0f8 RCX: 00007fe418e2b9db
[   98.683174] RDX: 0000000000000002 RSI: 0000000562bdc2dd RDI: 0000000000000068
[   98.689007] RBP: 0000000000000068 R08: 0000000000000000 R09: 0000000000000000
[   98.694861] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
[   98.700698] R13: 0000562bdab7b300 R14: 0000562bdab360f9 R15: 0000562bdc2cfdf0
[   98.706534] ---[ end trace 31ea7d71d5c258a2 ]---

This has happened with every 5.14 series kernel that I have used.

Graphics card: R7 360 "Bonnaire"

Cheers,
Chris
