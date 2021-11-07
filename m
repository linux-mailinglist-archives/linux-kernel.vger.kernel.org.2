Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40709447366
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 16:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbhKGPDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 10:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhKGPC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 10:02:57 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C383C061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 07:00:14 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id y3so36738979ybf.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 07:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=oVRnma9kCVKCxfs3jDNmCk+FTpmaQLC+cnDlmEUahaA=;
        b=j34BtMlpHtyNw45z8HmasoFmeAwbYHZKKcZ6efig6OAnTINZinqDcV7qBHpxU5bPQt
         8G2A93nagjpSyswCdMWNPu6cmfxweTxIc4vObhxxJuqIDFhxUAWJ12fXRfGJ/6l3zKW2
         xAuN5KL9ugM8yav8Dgcrrl80drTf3WO9sIhqeftdQyj9C/zosogIMhNfk8blb9DPaVVg
         gFtjyoBw6CN8gabsR9s3GKfwkNRME2zoA8hmoXFYhTj1DFTW9ACrB/A8CqQVZk2kMsl7
         XaMmUGNgVCKez0zu7/IzfoopCIrE40gQPqurm/MzvXftNbnxI7UMXf2Zvue35I/hnuy/
         yHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oVRnma9kCVKCxfs3jDNmCk+FTpmaQLC+cnDlmEUahaA=;
        b=6TGBmIFjXhGxdwq3mqK6eYhUJwtKmUW3xbuahZB6za5BKWGXE/9AYyvYfq4btw6waI
         6UL51qDLumTTEjHavROtGzT/mXDHTq/2+IG2O+g6Acu6DslstKENFc+ZBJ/YEJwCEzim
         IugZsiPBiaV+BrFAAOs60A8/X92Ym9k9vI48Geq3muDxWaopv3R8yTBCxKWjIrm+loYY
         /IyqSqh1N8j2IZOFRVo8cv1rU2wJsa9mpNaCYZQFZAVmmhRiESgTphXIpApdqqP1Y7mp
         YzzGpX9H+w4U1VmHB8+D2UKtJB10SRkC84aXfdcH7+e0b2NEe71sw360nJ6wZTOokSkd
         79HA==
X-Gm-Message-State: AOAM531pP//v1C1NhSmptFAHkavCknI4389/1k5S0GiwZyMgcU8C2AlT
        2mluzXULuFVPWwG0dGOxpBqYMOZmcg9yda/7zxZ1dzycz/c=
X-Google-Smtp-Source: ABdhPJwOgiCvW3oaKjPmqbMN++vEO5+0gHsxlnw1udI5iUYVQ6LH627DoS5CjsUMfpZ9mr6RulM0BKtzoqCKJ2TA+jk=
X-Received: by 2002:a5b:10a:: with SMTP id 10mr72085153ybx.535.1636297213057;
 Sun, 07 Nov 2021 07:00:13 -0800 (PST)
MIME-Version: 1.0
From:   Chris Rankin <rankincj@gmail.com>
Date:   Sun, 7 Nov 2021 15:00:01 +0000
Message-ID: <CAK2bqVJq7B37BeXFpriwYkB2vtR1JRbiDeOZpRpDXRH7+KW76g@mail.gmail.com>
Subject: [WARN][AMDGPU] TTM problem with vanilla 5.14.17 kernel
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have experienced a warning like this with every 5.14.x kernel that I
have tested. My graphics card is an R7 360 (BONNAIRE):

[  110.047107] ------------[ cut here ]------------
[  110.050450] WARNING: CPU: 7 PID: 1 at
drivers/gpu/drm/ttm/ttm_bo.c:409 ttm_bo_release+0x1c/0x266 [ttm]
[  110.058504] Modules linked in: nf_nat_ftp nf_conntrack_ftp cfg80211
af_packet nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_mangle
iptable_raw iptable_security nfnetlink ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter bnep it87 hwmon_vid dm_mod
dax snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio
snd_hda_codec_hdmi snd_hda_intel uvcvideo videobuf2_vmalloc btusb
videobuf2_memops videobuf2_v4l2 btbcm btintel videobuf2_common
coretemp videodev bluetooth kvm_intel ecdh_generic snd_usb_audio
snd_usbmidi_lib mc rfkill joydev ecc input_leds led_class
snd_intel_dspcfg snd_virtuoso kvm snd_hda_codec snd_oxygen_lib
snd_hwdep snd_hda_core snd_mpu401_uart r8169 irqbypass snd_rawmidi
psmouse mxm_wmi gpio_ich snd_seq
[  110.058591]  iTCO_wdt pcspkr snd_seq_device realtek snd_pcm
snd_hrtimer mdio_devres snd_timer libphy i2c_i801 snd
tiny_power_button i2c_smbus wmi lpc_ich i7core_edac soundcore button
acpi_cpufreq nfsd auth_rpcgss binfmt_misc nfs_acl lockd grace sunrpc
fuse configfs zram zsmalloc ip_tables x_tables ext4 crc32c_generic
crc16 mbcache jbd2 sr_mod sd_mod cdrom hid_microsoft usbhid amdgpu
uhci_hcd drm_ttm_helper ttm mfd_core gpu_sched i2c_algo_bit ehci_pci
drm_kms_helper ehci_hcd xhci_pci pata_jmicron firewire_ohci xhci_hcd
ahci libahci crc32c_intel firewire_core serio_raw libata crc_itu_t
cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt fb_sys_fops
cfbcopyarea cec rc_core scsi_mod drm usbcore usb_common
drm_panel_orientation_quirks ipmi_devintf ipmi_msghandler msr
sha256_ssse3 sha256_generic ipv6 crc_ccitt
[  110.217782] CPU: 7 PID: 1 Comm: systemd Tainted: G          I
5.14.17 #1
[  110.224122] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[  110.232097] RIP: 0010:ttm_bo_release+0x1c/0x266 [ttm]
[  110.236003] Code: 44 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 41 56
41 55 41 54 4c 8d a7 90 fe ff ff 55 53 83 7f 4c 00 48 89 fb 48 8b 6f
e8 74 02 <0f> 0b 80 7b 18 00 48 8b 43 88 0f 85 ac 00 00 00 4c 8d 6b 90
49 39
[  110.253645] RSP: 0018:ffffc90000023e00 EFLAGS: 00010202
[  110.257643] RAX: 0000000000000001 RBX: ffff8881245291c8 RCX: 000000000000004b
[  110.263635] RDX: 0000000000000283 RSI: ffffffffa02ff0db RDI: ffff8881245291c8
[  110.269668] RBP: ffff888109465308 R08: 0000000000000000 R09: 0000000000000003
[  110.275629] R10: ffff888102311800 R11: ffff888102311800 R12: ffff888124529058
[  110.281679] R13: ffff88814b12b6c0 R14: ffff88814b1553c0 R15: 0000000000000000
[  110.287763] FS:  00007f3bc3979b40(0000) GS:ffff888343cc0000(0000)
knlGS:0000000000000000
[  110.294869] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  110.299319] CR2: 00007f519a23c058 CR3: 0000000101f80000 CR4: 00000000000006e0
[  110.305340] Call Trace:
[  110.306494]  amdgpu_bo_unref+0x15/0x1e [amdgpu]
[  110.309987]  amdgpu_gem_object_free+0x2b/0x45 [amdgpu]
[  110.314068]  drm_gem_dmabuf_release+0x11/0x1a [drm]
[  110.317763]  dma_buf_release+0x36/0x6e
[  110.320321]  __dentry_kill+0xf5/0x12f
[  110.322756]  dput+0xfc/0x136
[  110.324413]  __fput+0x16a/0x1bc
[  110.326319]  task_work_run+0x64/0x75
[  110.328667]  exit_to_user_mode_prepare+0x88/0x112
[  110.332144]  syscall_exit_to_user_mode+0x14/0x1f
[  110.335584]  do_syscall_64+0x7a/0x80
[  110.337976]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  110.341886] RIP: 0033:0x7f3bc44affdb
[  110.344241] Code: 03 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3 48
83 ec 18 89 7c 24 0c e8 33 81 f8 ff 8b 7c 24 0c 41 89 c0 b8 03 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 81 81 f8 ff
8b 44
[  110.362493] RSP: 002b:00007ffd5c1a7c90 EFLAGS: 00000293 ORIG_RAX:
0000000000000003
[  110.369151] RAX: 0000000000000000 RBX: 00007f3bc39798f0 RCX: 00007f3bc44affdb
[  110.375233] RDX: 0000000000000000 RSI: 00000005613756d6 RDI: 0000000000000069
[  110.381319] RBP: 0000000000000069 R08: 0000000000000000 R09: 000000000000007f
[  110.387402] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
[  110.393496] R13: 0000561374c8e680 R14: 0000561374c47719 R15: 0000561375740640
[  110.399580] ---[ end trace 6e25937709a46155 ]---

Cheers,
Chris
