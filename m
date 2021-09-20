Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4257D4116B9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbhITOWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhITOWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:22:21 -0400
Received: from lb1-smtp-cloud7.xs4all.net (lb1-smtp-cloud7.xs4all.net [IPv6:2001:888:0:108::1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003E3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 07:20:54 -0700 (PDT)
Received: from cust-57f2be97 ([IPv6:fc0c:c196:c6c4:fdf1:aa47:ab6:e251:d2a8])
        by smtp-cloud7.xs4all.net with ESMTPSA
        id SKA7maQuqpQdWSKA8mTyQi; Mon, 20 Sep 2021 16:20:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1632147652; bh=2ei89FKMdHZzIaFnIkuNDWyTHA6MkNCeqmymFqT6cDY=;
        h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type:From:
         Subject;
        b=Ebm1BwvNMshoY4JRai8Su4za69JGi85Z+ZyuQjdGk1E30jzRxmkLiM4KRmX92GKHt
         4t7DX2RupwLXmIHW5mOH+05xf6/TQco4ZiCjwIn2X/srDFqePfga9Lq6UCZ24CO1Ny
         9kAnHxiT26Z2Kk/31uFFJFWOwwdcmlVhTwdLLUBxaFqwcUk6oDZIcIEmnGZ4nMY634
         cYDbTyD2AHkxoTaJKTcxAePenGC3XZ2VMcOTq4snFRaYCtuZSeQMKrQgaZALq5Pz5m
         lJc5ahrp5oz0uCODzg16uAvr0ZSsHF5rCXiZq+7mFjfDwpWLAwKgKw6Aj4t+iRpS5M
         r53BqOTcdWjbA==
Message-ID: <f95a77b7-54be-41dd-a832-91692ab06b48@xs4all.nl>
Date:   Mon, 20 Sep 2021 16:20:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
From:   Udo van den Heuvel <udovdh@xs4all.nl>
Subject: 5.14.6: what happened here?
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Language: en-US
Organization: hierzo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCj2J3fY/Rx8kEMh/nkaeYt/r1fAJ8O/R2xxbe5kIavG01FNrl85YWpzNRZKDMCI9DCEHDBxRTSaiCG4zV/VQRvH/7uqMXPFOgkYYJggQR0/Avgw2XPy
 f5KQh/IcxkEoGczdmnUoDuUPXBh+FqeaNwbe0T0orOA4yY02X1burleKsnORad7FS12hX6UHev6IKEZeIVSZlutpInUW62nHuHo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Found this in dmesg:


[108333.097816] ------------[ cut here ]------------
[108333.097821] Buffer overflow detected (8 < 192)!
[108333.097827] WARNING: CPU: 5 PID: 180717 at 
include/linux/thread_info.h:200 ethtool_rxnfc_copy_to_user+0x11/0x20
[108333.097832] Modules linked in: snd_seq_dummy mq_deadline 
xt_MASQUERADE iptable_nat nf_nat ipt_REJECT nf_reject_ipv4 xt_u32 
xt_multiport iptable_filter nf_conntrack_netbios_ns 
nf_conntrack_broadcast ip6t_REJECT nf_reject_ipv6 xt_tcpudp xt_state 
xt_conntrack nf_conntrack nf_defrag_ipv6 k10temp nf_defrag_ipv4 it87 
ip6table_filter hwmon_vid msr ip6_tables snd_hda_codec_realtek 
snd_hda_codec_generic uvcvideo snd_hda_intel snd_intel_dspcfg 
videobuf2_vmalloc snd_usb_audio videobuf2_memops snd_hda_codec snd_hwdep 
videobuf2_v4l2 snd_hda_core snd_usbmidi_lib videodev lzo_rle snd_rawmidi 
snd_seq videobuf2_common cdc_acm lzo_compress snd_seq_device snd_pcm 
snd_timer i2c_piix4 snd bfq evdev acpi_cpufreq p_lkrg binfmt_misc fuse 
configfs zram zsmalloc ip_tables x_tables hid_generic amdgpu sr_mod 
cdrom usbhid aesni_intel drm_ttm_helper ttm gpu_sched i2c_dev autofs4
[108333.097862] CPU: 5 PID: 180717 Comm: pool Not tainted 5.14.6 #5
[108333.097864] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS 
PRO/X570 AORUS PRO, BIOS F34 07/08/2021
[108333.097865] RIP: 0010:ethtool_rxnfc_copy_to_user+0x11/0x20
[108333.097867] Code: eb 94 b8 f4 ff ff ff eb 8d e8 7b a0 12 00 66 66 2e 
0f 1f 84 00 00 00 00 00 be 08 00 00 00 48 c7 c7 b8 68 e5 82 e8 a7 0c 0f 
00 <0f> 0b b8 f2 ff ff ff c3 0f 1f 80 00 00 00 00 41 56 41 55 41 54 55
[108333.097869] RSP: 0018:ffffadbd8638bb30 EFLAGS: 00010286
[108333.097870] RAX: 0000000000000000 RBX: ffffffff82cca7c0 RCX: 
0000000000000000
[108333.097872] RDX: 0000000000000001 RSI: ffffffff82e7739c RDI: 
00000000ffffffff
[108333.097872] RBP: ffffa04087eae000 R08: ffffa047be2b0c28 R09: 
00000000ffffdfff
[108333.097873] R10: ffffa047be14d000 R11: ffffa047be14d000 R12: 
0000000000000000
[108333.097874] R13: 00007f3bfd70e7e0 R14: 0000000000000000 R15: 
ffffadbd8638bb40
[108333.097875] FS:  00007f3bfd70f640(0000) GS:ffffa047bdd40000(0000) 
knlGS:0000000000000000
[108333.097876] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[108333.097877] CR2: 00007f3bec016148 CR3: 000000010ba38000 CR4: 
0000000000750ee0
[108333.097878] PKRU: 55555554
[108333.097878] Call Trace:
[108333.097880]  ethtool_get_rxnfc+0xc1/0x1b0
[108333.097883]  dev_ethtool+0xb7a/0x2950
[108333.097885]  ? dev_ethtool+0x1c6/0x2950
[108333.097887]  ? _copy_to_user+0x1c/0x30
[108333.097890]  ? dev_ethtool+0x1c6/0x2950
[108333.097892]  ? netdev_name_node_lookup_rcu+0x58/0x70
[108333.097894]  dev_ioctl+0x18c/0x4f0
[108333.097896]  sock_ioctl+0x271/0x3c0
[108333.097899]  __x64_sys_ioctl+0x415/0x930
[108333.097901]  ? exit_to_user_mode_prepare+0x19/0xf0
[108333.097904]  do_syscall_64+0x5c/0x80
[108333.097907]  ? task_work_run+0x57/0x90
[108333.097909]  ? exit_to_user_mode_prepare+0x5e/0xf0
[108333.097910]  ? syscall_exit_to_user_mode+0x1d/0x40
[108333.097911]  ? __x64_sys_close+0x8/0x40
[108333.097913]  ? do_syscall_64+0x69/0x80
[108333.097915]  ? do_syscall_64+0x69/0x80
[108333.097916]  ? do_syscall_64+0x69/0x80
[108333.097917]  ? __x64_sys_socket+0xe/0x20
[108333.097918]  ? do_syscall_64+0x69/0x80
[108333.097919]  ? do_syscall_64+0x69/0x80
[108333.097920]  ? exit_to_user_mode_prepare+0x19/0xf0
[108333.097921]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[108333.097923] RIP: 0033:0x7f3c111e80ab
[108333.097924] Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 
89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 9d bd 0c 00 f7 d8 64 89 01 48
[108333.097925] RSP: 002b:00007f3bfd70e778 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[108333.097927] RAX: ffffffffffffffda RBX: 000000003b9aca00 RCX: 
00007f3c111e80ab
[108333.097927] RDX: 00007f3bfd70e7b0 RSI: 0000000000008946 RDI: 
0000000000000009
[108333.097928] RBP: 0000000000000009 R08: 0000000000000000 R09: 
00007f3bfd70e7b0
[108333.097928] R10: 00007f3bec015fcc R11: 0000000000000246 R12: 
0000000000000001
[108333.097929] R13: 00007f3bec015450 R14: 00007f3bec015f68 R15: 
00007f3bec01600c
[108333.097930] ---[ end trace ef16fbb48219a61f ]---


Yes, a buffer overflow.
But is this a bug or due to somethin that I was doing?

Udo
