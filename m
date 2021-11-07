Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D9B4472CB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 12:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbhKGMCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 07:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbhKGMCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 07:02:04 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8170BC061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 03:59:21 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id b2-20020a1c8002000000b0032fb900951eso13002542wmd.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 03:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:message-id:date:mime-version:user-agent:content-language:to:cc
         :subject:content-transfer-encoding;
        bh=llmwcmE22tjFRD9UtHMaQkFq7YD7TLe4YEPT4ZcBWZA=;
        b=KN5/5vCAa9gE51kcFunQbNmXAjNIK+BkmIsowDHONToQli8b/CTXC/Oz7R3i3AyaOq
         oTCt3e8QbFT3XoLR9itJlSEGTHPnf6mIsPg7LJMQOQu02yMG1IlSowVE8+dPj5cHsa4D
         0y+qYTbevb/kM1ED6/zGzP/s9uzYQdKtjXCXgKUzgruY6ZTBuerMMyBFSz13Emxzn6tA
         mJlUzyetMunWeeGgmilXZma7RRVZHPBFVyghHb1R1r4Mtjl1X+THZ4+apDgxrfQXla5L
         uYaTFHshR6iKemhQEo9vpNjD/rS/kvPL9r7OqTVgTGaMXiWjkAPDhKKH7H7xMn3aO5dR
         1hSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent
         :content-language:to:cc:subject:content-transfer-encoding;
        bh=llmwcmE22tjFRD9UtHMaQkFq7YD7TLe4YEPT4ZcBWZA=;
        b=d+pnvn7bxBc0XXkHr1vchyUMqO0AK00w1HXBJxElDZ5yNvhljVAvKkkO4xvsIqbsYq
         S9ppPCuGWCvMp++zCBikGv74WE9PXTHBLZ9yRIUcJFtCbA6Afp5rt/VmYD9QdOkYszxd
         ZljVcTn0Dnbd9WVO460qmd97UtLc4zPBdfG+zrpK+P8grj/MpUNvNB6+rUJgdW6U3MCc
         6FG5YqRtasbsZEms++Y36o/xjfH7etT4si+mzlrse2VQ+PXCXAS5VTXqSpfWlp9W/C1x
         SI5zkNMQpI6qJISrQ5Vn8Fcd58Xmk7XEv8jkIeFpLvebFMfNBinBVrHCYEdUDGTmoizF
         kDHw==
X-Gm-Message-State: AOAM530/GpAJ09P+o6tfP2D7EJE7FvlsSReXWydIVoaFjpgQaFQXz7i/
        CGNufVNmFQB21ZOE6lGFI/7t4Uw=
X-Google-Smtp-Source: ABdhPJwEDybj8h7Ua7j0RS416teZnbXNApRbntgjmrSqjK0gip5JiAIpMYagdqFEnUZ87TtPJptL7Q==
X-Received: by 2002:a7b:c841:: with SMTP id c1mr45562034wml.80.1636286359036;
        Sun, 07 Nov 2021 03:59:19 -0800 (PST)
Received: from [192.168.0.209] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id n15sm17373869wmq.38.2021.11.07.03.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 03:59:18 -0800 (PST)
From:   "Colin King (gmail)" <colin.i.king@googlemail.com>
X-Google-Original-From: "Colin King (gmail)" <colin.i.king@gmail.com>
Message-ID: <f6a0f4be-ad53-489c-0036-09dead99f368@gmail.com>
Date:   Sun, 7 Nov 2021 11:59:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: DEAD callback error for CPU, WARNING: CPU: 3 PID: 1134 at
 kernel/cpu.c:1163 _cpu_down+0x20a/0x3a0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a SMP system in a VM, a deadlock callback error can be reproduced 
with 5.15, tested from head at commit 
d4439a1189f93d0ac1eaf0197db8e6b3e197d5c7

Didn't see this issue on 5.13

How to reproduce:

git clone https://github.com/ColinIanKing/stress-ng
cd stress-ng
make -j $(nproc)
sudo ./stress-ng --cpu-online 0 -t 15 --pathological

Tested on a 8 thread virtual machine, 4MB of memory.

[ 2239.378724] smpboot: CPU 6 is now offline
[ 2239.379443] smpboot: Booting Node 0 Processor 6 APIC 0x6
[ 2239.380169] kvm-clock: cpu 6, msr 79201181, secondary cpu clock
[ 2239.401652] ------------[ cut here ]------------
[ 2239.401658] DEAD callback error for CPU6
[ 2239.401721] WARNING: CPU: 3 PID: 1134 at kernel/cpu.c:1163 
_cpu_down+0x20a/0x3a0
[ 2239.401856] Modules linked in: dm_multipath scsi_dh_rdac scsi_dh_emc 
scsi_dh_alua intel_rapl_msr intel_rapl_common kvm_intel 
snd_hda_codec_generic ledtrig_audio snd_hda_intel kvm snd_intel_dspcfg 
snd_intel_sdw_acpi snd_hda_codec rapl joydev input_leds snd_hda_core 
snd_hwdep snd_pcm snd_timer snd serio_raw soundcore qemu_fw_cfg mac_hid 
sch_fq_codel msr virtio_rng ip_tables x_tables autofs4 btrfs 
blake2b_generic zstd_compress raid10 raid456 async_raid6_recov 
async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 
raid0 multipath linear qxl hid_generic drm_ttm_helper ttm drm_kms_helper 
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel virtio_net syscopyarea 
aesni_intel sysfillrect sysimgblt fb_sys_fops cec usbhid crypto_simd 
net_failover rc_core i2c_i801 ahci hid cryptd i2c_smbus psmouse libahci 
drm lpc_ich virtio_blk failover
[ 2239.402631] CPU: 3 PID: 1134 Comm: stress-ng Not tainted 5.15.0+ #1
[ 2239.402649] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
1.14.0-2 04/01/2014
[ 2239.402654] RIP: 0010:_cpu_down+0x20a/0x3a0
[ 2239.402664] Code: 8b 03 41 39 c6 7f 6f 39 45 c0 0f 8e 34 ff ff ff 3d 
96 00 00 00 0f 84 be 00 00 00 44 89 ee 48 c7 c7 f3 38 9a 95 e8 26 a2 f9 
ff <0f> 0b e9 13 ff ff ff e8 3a bd 52 ff e9 2a ff ff ff f0 48 0f b3 05
[ 2239.402744] RSP: 0018:ffffa30e008b7cc0 EFLAGS: 00010282
[ 2239.402755] RAX: 0000000000000000 RBX: ffff8ccb7bda0660 RCX: 
0000000000000000
[ 2239.402760] RDX: 0000000000000001 RSI: ffffffff959b6099 RDI: 
00000000ffffffff
[ 2239.402766] RBP: ffffa30e008b7d00 R08: 0000000000000000 R09: 
ffffa30e008b7ab0
[ 2239.402771] R10: ffffa30e008b7aa8 R11: ffffffff96356908 R12: 
0000000000000000
[ 2239.402776] R13: 0000000000000006 R14: 0000000000000096 R15: 
00000000ffffffea
[ 2239.402783] FS:  00007f5ee8713740(0000) GS:ffff8ccb7bcc0000(0000) 
knlGS:0000000000000000
[ 2239.402791] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2239.402796] CR2: 000055e786065c20 CR3: 000000010622e004 CR4: 
0000000000370ee0
[ 2239.402811] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 2239.402816] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[ 2239.402821] Call Trace:
[ 2239.402827]  <TASK>
[ 2239.402938]  cpu_device_down+0x34/0x60
[ 2239.403018]  cpu_subsys_offline+0xe/0x10
[ 2239.403086]  device_offline+0xe6/0x110
[ 2239.403095]  online_store+0x53/0xc0
[ 2239.403103]  dev_attr_store+0x17/0x30
[ 2239.403155]  sysfs_kf_write+0x3e/0x50
[ 2239.403193]  kernfs_fop_write_iter+0x137/0x1c0
[ 2239.403207]  new_sync_write+0x117/0x1a0
[ 2239.403264]  vfs_write+0x211/0x2a0
[ 2239.403276]  ksys_write+0x67/0xe0
[ 2239.403290]  __x64_sys_write+0x19/0x20
[ 2239.403303]  do_syscall_64+0x5c/0xc0
[ 2239.403316]  ? exc_page_fault+0x89/0x180
[ 2239.403323]  ? asm_exc_page_fault+0x8/0x30
[ 2239.403349]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 2239.403359] RIP: 0033:0x7f5ee8c1b777
[ 2239.403395] Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 
1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 
05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[ 2239.403425] RSP: 002b:00007ffe09004648 EFLAGS: 00000246 ORIG_RAX: 
0000000000000001
[ 2239.403432] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 
00007f5ee8c1b777
[ 2239.403436] RDX: 0000000000000003 RSI: 00007ffe0900467d RDI: 
0000000000000004
[ 2239.403439] RBP: 00007ffe09004680 R08: 0000000000000000 R09: 
00007ffe09004500
[ 2239.403442] R10: 0000000000000000 R11: 0000000000000246 R12: 
00007ffe0900467d
[ 2239.403454] R13: 0000000000000004 R14: 0000000000000006 R15: 
000055e785de5f08
[ 2239.403463]  </TASK>
[ 2239.403466] ---[ end trace e92cc28a4b580b82 ]---

See bug report https://bugzilla.kernel.org/show_bug.cgi?id=214955

Colin

