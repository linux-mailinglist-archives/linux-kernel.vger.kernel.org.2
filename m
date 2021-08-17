Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB3F3EF165
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhHQSIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:08:47 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:22469 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhHQSIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1629223692;
    s=strato-dkim-0002; d=obiwahn.org;
    h=In-Reply-To:Date:Message-ID:References:To:From:Subject:Cc:Date:From:
    Subject:Sender;
    bh=rw7tWXCw1wrZL67CJkG16qKY5LP4i014BxbQtk8q4XQ=;
    b=m6TqF8SQF9IWOJIIMDVDyVLRTzU3VHDctbzsRLK+zq8nSZj2GTZCLm4otws++aX0RU
    fciukqkukcpQTPeHLD4MBW3aFJ/PSHrCsDol+9A+v1CGuWromPUibHtnfWQYK7ByPnXC
    U1s3mdeZ5CDqxEQ4/IPM+IiSkaIZAAHSw6cRs6ptteaJAu/9ZTsT/xfXzurnj0Kl27G3
    G1WCOnCEb33XYg8UeIucCXn2TwExi9ykY//VQNhK/HpLr7I1zhCkGhahRk/4rmwI8+eT
    2aYt8LfQY6sCx5qxJYQfVkhHZxqLVwk8JBUZQdv50/wr1MEgmMCODiEk6smKlRFshi/H
    e5ww==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":IGUKYFiIdP1J9M0wIogIqR2uGoaf2MGKp4zojMB4Gz2zDSLa96nnaj3AZSvaPEApIsg="
X-RZG-CLASS-ID: mo00
Received: from edward.obiwahn.org
    by smtp.strato.de (RZmta 47.31.0 DYNA|AUTH)
    with ESMTPSA id i09cf8x7HI8BpQk
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate)
    for <linux-kernel@vger.kernel.org>;
    Tue, 17 Aug 2021 20:08:11 +0200 (CEST)
Subject: Re: amdgpu driver lock-up
From:   Jan Christoph Uhde <linux@obiwahn.org>
To:     linux-kernel@vger.kernel.org
References: <c9377a50-603c-7a4a-6c6d-1cf7f26cf758@obiwahn.org>
Message-ID: <26ad8fd2-7158-cf9f-36d1-86a1a91530a2@obiwahn.org>
Date:   Tue, 17 Aug 2021 20:08:11 +0200
User-Agent: Why are you interested in my client, Sir?
MIME-Version: 1.0
In-Reply-To: <c9377a50-603c-7a4a-6c6d-1cf7f26cf758@obiwahn.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> and the system locks up as shown in the attached excerpt of my syslog:

...

Aug 16 21:17:26 horsti kernel: [ 4982.829014]  amdgpu_bo_do_create+0x2a4/0x4f0 [amdgpu]
Aug 16 21:17:26 horsti kernel: [ 4982.829060]  amdgpu_bo_create+0x40/0x270 [amdgpu]
Aug 16 21:17:26 horsti kernel: [ 4982.829107]  amdgpu_gem_create_ioctl+0x123/0x310 [amdgpu]
Aug 16 21:17:26 horsti kernel: [ 4982.829153]  ? amdgpu_gem_object_close+0x200/0x200 [amdgpu]
Aug 16 21:17:26 horsti kernel: [ 4982.829161]  drm_ioctl_kernel+0xaa/0xf0 [drm]
Aug 16 21:17:26 horsti kernel: [ 4982.829170]  drm_ioctl+0x20f/0x3a0 [drm]
Aug 16 21:17:26 horsti kernel: [ 4982.829215]  ? amdgpu_gem_object_close+0x200/0x200 [amdgpu]
Aug 16 21:17:26 horsti kernel: [ 4982.829217]  ? do_setitimer+0x179/0x210
Aug 16 21:17:26 horsti kernel: [ 4982.829261]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
Aug 16 21:17:26 horsti kernel: [ 4982.829264]  __x64_sys_ioctl+0x83/0xb0
Aug 16 21:17:26 horsti kernel: [ 4982.829266]  do_syscall_64+0x33/0x80
Aug 16 21:17:26 horsti kernel: [ 4982.829267]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug 16 21:17:26 horsti kernel: [ 4982.829269] RIP: 0033:0x7f20cd606cc7
Aug 16 21:17:26 horsti kernel: [ 4982.829271] Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 91 0c 00 f7 d8 64 89 01 48
Aug 16 21:17:26 horsti kernel: [ 4982.829271] RSP: 002b:00007fffd44a4028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Aug 16 21:17:26 horsti kernel: [ 4982.829272] RAX: ffffffffffffffda RBX: 00007fffd44a4080 RCX: 00007f20cd606cc7
Aug 16 21:17:26 horsti kernel: [ 4982.829273] RDX: 00007fffd44a4080 RSI: 00000000c0206440 RDI: 000000000000000a
Aug 16 21:17:26 horsti kernel: [ 4982.829274] RBP: 00000000c0206440 R08: 00000000ffffffff R09: 000056258d690010
Aug 16 21:17:26 horsti kernel: [ 4982.829274] R10: 00007f20cd6d0b80 R11: 0000000000000246 R12: 000056258e5f85c0
Aug 16 21:17:26 horsti kernel: [ 4982.829275] R13: 000000000000000a R14: 0000000404000000 R15: 0000000000200000
Aug 16 21:17:34 horsti kernel: [ 4990.525762] rcu: INFO: rcu_sched self-detected stall on CPU
Aug 16 21:17:34 horsti kernel: [ 4990.525768] rcu:  12-....: (399075 ticks this GP) idle=0ee/1/0x4000000000000000 softirq=29128/29128 fqs=183239
Aug 16 21:17:34 horsti kernel: [ 4990.525776]   (t=399075 jiffies g=448893 q=922288)
Aug 16 21:17:34 horsti kernel: [ 4990.525777] NMI backtrace for cpu 12
Aug 16 21:17:34 horsti kernel: [ 4990.525779] CPU: 12 PID: 19156 Comm: Xwayland Tainted: G             L    5.10.0-8-amd64 #1 Debian 5.10.46-4
Aug 16 21:17:34 horsti kernel: [ 4990.525780] Hardware name: System manufacturer System Product Name/ROG ZENITH EXTREME ALPHA, BIOS 2001 07/31/2019
Aug 16 21:17:34 horsti kernel: [ 4990.525781] Call Trace:
Aug 16 21:17:34 horsti kernel: [ 4990.525783]  <IRQ>
Aug 16 21:17:34 horsti kernel: [ 4990.525787]  dump_stack+0x6b/0x83
Aug 16 21:17:34 horsti kernel: [ 4990.525789]  nmi_cpu_backtrace.cold+0x32/0x69
Aug 16 21:17:34 horsti kernel: [ 4990.525791]  ? lapic_can_unplug_cpu+0x80/0x80
Aug 16 21:17:34 horsti kernel: [ 4990.525794]  nmi_trigger_cpumask_backtrace+0xd7/0xe0
Aug 16 21:17:34 horsti kernel: [ 4990.525797]  rcu_dump_cpu_stacks+0xa2/0xd0
Aug 16 21:17:34 horsti kernel: [ 4990.525799]  rcu_sched_clock_irq.cold+0x1ff/0x3d6
Aug 16 21:17:34 horsti kernel: [ 4990.525801]  update_process_times+0x8c/0xc0
Aug 16 21:17:34 horsti kernel: [ 4990.525803]  tick_sched_handle+0x22/0x60
Aug 16 21:17:34 horsti kernel: [ 4990.525805]  tick_sched_timer+0x7c/0xb0
Aug 16 21:17:34 horsti kernel: [ 4990.525806]  ? tick_do_update_jiffies64.part.0+0xc0/0xc0
Aug 16 21:17:34 horsti kernel: [ 4990.525807]  __hrtimer_run_queues+0x12a/0x270
Aug 16 21:17:34 horsti kernel: [ 4990.525809]  hrtimer_interrupt+0x110/0x2c0
Aug 16 21:17:34 horsti kernel: [ 4990.525810]  __sysvec_apic_timer_interrupt+0x5f/0xd0
Aug 16 21:17:34 horsti kernel: [ 4990.525812]  asm_call_irq_on_stack+0x12/0x20
Aug 16 21:17:34 horsti kernel: [ 4990.525814]  </IRQ>
Aug 16 21:17:34 horsti kernel: [ 4990.525816]  sysvec_apic_timer_interrupt+0x72/0x80
Aug 16 21:17:34 horsti kernel: [ 4990.525818]  asm_sysvec_apic_timer_interrupt+0x12/0x20
Aug 16 21:17:34 horsti kernel: [ 4990.525829] RIP: 0010:__drm_dbg+0x21/0x90 [drm]
Aug 16 21:17:34 horsti kernel: [ 4990.525831] Code: 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 48 83 ec 60 48 89 54 24 40 48 89 4c 24 48 4c 89 44 24 50 4c 89 4c 24 58 <65> 48 8b 04 25 28 00 00 00 48 89 44 24 28 31 c0 23 3d 61 1c 05 00
Aug 16 21:17:34 horsti kernel: [ 4990.525832] RSP: 0018:ffffc1544d6efba0 EFLAGS: 00000286
Aug 16 21:17:34 horsti kernel: [ 4990.525833] RAX: ffff9b2b14765838 RBX: ffffc1544d6efd38 RCX: 00000001ff000000
Aug 16 21:17:34 horsti kernel: [ 4990.525834] RDX: 0000000404000000 RSI: ffffffffc26b1270 RDI: 0000000000000001
Aug 16 21:17:34 horsti kernel: [ 4990.525835] RBP: ffffc1544d6efc00 R08: 0000000000000000 R09: 0000000000000000
Aug 16 21:17:34 horsti kernel: [ 4990.525836] R10: 000000000000000a R11: 0000000404000000 R12: ffffc1544d6efd38
Aug 16 21:17:34 horsti kernel: [ 4990.525836] R13: 00000000fffffff4 R14: ffff9b2b14760000 R15: ffffc1544d6efe28
Aug 16 21:17:34 horsti kernel: [ 4990.525892]  amdgpu_bo_do_create+0x2a4/0x4f0 [amdgpu]
Aug 16 21:17:34 horsti kernel: [ 4990.525939]  amdgpu_bo_create+0x40/0x270 [amdgpu]
Aug 16 21:17:34 horsti kernel: [ 4990.525992]  amdgpu_gem_create_ioctl+0x123/0x310 [amdgpu]
Aug 16 21:17:34 horsti kernel: [ 4990.526040]  ? amdgpu_gem_object_close+0x200/0x200 [amdgpu]
Aug 16 21:17:34 horsti kernel: [ 4990.526048]  drm_ioctl_kernel+0xaa/0xf0 [drm]
Aug 16 21:17:34 horsti kernel: [ 4990.526057]  drm_ioctl+0x20f/0x3a0 [drm]
Aug 16 21:17:34 horsti kernel: [ 4990.526105]  ? amdgpu_gem_object_close+0x200/0x200 [amdgpu]
Aug 16 21:17:34 horsti kernel: [ 4990.526107]  ? do_setitimer+0x179/0x210
Aug 16 21:17:34 horsti kernel: [ 4990.526153]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
Aug 16 21:17:34 horsti kernel: [ 4990.526155]  __x64_sys_ioctl+0x83/0xb0
Aug 16 21:17:34 horsti kernel: [ 4990.526157]  do_syscall_64+0x33/0x80
Aug 16 21:17:34 horsti kernel: [ 4990.526159]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug 16 21:17:34 horsti kernel: [ 4990.526160] RIP: 0033:0x7f20cd606cc7
Aug 16 21:17:34 horsti kernel: [ 4990.526161] Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 91 0c 00 f7 d8 64 89 01 48
Aug 16 21:17:34 horsti kernel: [ 4990.526162] RSP: 002b:00007fffd44a4028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Aug 16 21:17:34 horsti kernel: [ 4990.526163] RAX: ffffffffffffffda RBX: 00007fffd44a4080 RCX: 00007f20cd606cc7
Aug 16 21:17:34 horsti kernel: [ 4990.526164] RDX: 00007fffd44a4080 RSI: 00000000c0206440 RDI: 000000000000000a
Aug 16 21:17:34 horsti kernel: [ 4990.526165] RBP: 00000000c0206440 R08: 00000000ffffffff R09: 000056258d690010
Aug 16 21:17:34 horsti kernel: [ 4990.526166] R10: 00007f20cd6d0b80 R11: 0000000000000246 R12: 000056258e5f85c0
Aug 16 21:17:34 horsti kernel: [ 4990.526166] R13: 000000000000000a R14: 0000000404000000 R15: 0000000000200000
Aug 16 21:17:58 horsti kernel: [ 5014.828003] watchdog: BUG: soft lockup - CPU#12 stuck for 22s! [Xwayland:19156]
Aug 16 21:17:58 horsti kernel: [ 5014.828006] Modules linked in: nls_utf8 cifs dns_resolver fscache libdes overlay cmac algif_hash algif_skcipher af_alg bnep binfmt_misc btusb btrtl btbcm btintel bluetooth snd_hda_codec_realtek snd_hda_codec_generic jitterentropy_rn
Aug 16 21:17:58 horsti kernel: [ 5014.828038]  snd ccp sp5100_tco soundcore watchdog rng_core k10temp button acpi_cpufreq parport_pc ppdev lp parport drm fuse configfs sunrpc efivarfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic sd_mod hid_gener
Aug 16 21:17:58 horsti kernel: [ 5014.828060] CPU: 12 PID: 19156 Comm: Xwayland Tainted: G             L    5.10.0-8-amd64 #1 Debian 5.10.46-4
Aug 16 21:17:58 horsti kernel: [ 5014.828061] Hardware name: System manufacturer System Product Name/ROG ZENITH EXTREME ALPHA, BIOS 2001 07/31/2019
Aug 16 21:17:58 horsti kernel: [ 5014.828119] RIP: 0010:amdgpu_gem_create_ioctl+0x1e9/0x310 [amdgpu]
Aug 16 21:17:58 horsti kernel: [ 5014.828120] Code: c0 0f 85 24 01 00 00 49 83 cc 02 45 31 ed e9 08 ff ff ff 3d 00 fe ff ff 74 1b 41 f6 c4 01 75 0f 41 83 fe 04 75 16 4d 8b 77 10 <e9> ec fe ff ff 49 83 e4 fe eb f1 b8 00 fe ff ff eb 9f 4d 8b 47 08
Aug 16 21:17:58 horsti kernel: [ 5014.828121] RSP: 0018:ffffc1544d6efd18 EFLAGS: 00000246
Aug 16 21:17:58 horsti kernel: [ 5014.828123] RAX: 00000000fffffff4 RBX: 0000000000000021 RCX: 00000001ff000000
Aug 16 21:17:58 horsti kernel: [ 5014.828123] RDX: 0000000404000000 RSI: ffffffffc26b1270 RDI: 0000000000000000
Aug 16 21:17:58 horsti kernel: [ 5014.828124] RBP: ffff9b2b14760000 R08: 0000000000000000 R09: 0000000000000000
Aug 16 21:17:58 horsti kernel: [ 5014.828125] R10: 000000000000000a R11: 0000000404000000 R12: 0000000000000006
Aug 16 21:17:58 horsti kernel: [ 5014.828126] R13: 0000000000000000 R14: 0000000000000004 R15: ffffc1544d6efe28
Aug 16 21:17:58 horsti kernel: [ 5014.828127] FS:  00007f20cceeeec0(0000) GS:ffff9b3abde00000(0000) knlGS:0000000000000000
Aug 16 21:17:58 horsti kernel: [ 5014.828128] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Aug 16 21:17:58 horsti kernel: [ 5014.828129] CR2: 000056258d6ad7a8 CR3: 000000014de62000 CR4: 00000000003506e0
Aug 16 21:17:58 horsti kernel: [ 5014.828129] Call Trace:
Aug 16 21:17:58 horsti kernel: [ 5014.828176]  ? amdgpu_gem_object_close+0x200/0x200 [amdgpu]
Aug 16 21:17:58 horsti kernel: [ 5014.828187]  drm_ioctl_kernel+0xaa/0xf0 [drm]
Aug 16 21:17:58 horsti kernel: [ 5014.828195]  drm_ioctl+0x20f/0x3a0 [drm]
Aug 16 21:17:58 horsti kernel: [ 5014.828240]  ? amdgpu_gem_object_close+0x200/0x200 [amdgpu]
Aug 16 21:17:58 horsti kernel: [ 5014.828242]  ? do_setitimer+0x179/0x210
Aug 16 21:17:58 horsti kernel: [ 5014.828284]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
Aug 16 21:17:58 horsti kernel: [ 5014.828287]  __x64_sys_ioctl+0x83/0xb0
Aug 16 21:17:58 horsti kernel: [ 5014.828290]  do_syscall_64+0x33/0x80
Aug 16 21:17:58 horsti kernel: [ 5014.828292]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Aug 16 21:17:58 horsti kernel: [ 5014.828293] RIP: 0033:0x7f20cd606cc7
Aug 16 21:17:58 horsti kernel: [ 5014.828295] Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 91 0c 00 f7 d8 64 89 01 48
Aug 16 21:17:58 horsti kernel: [ 5014.828295] RSP: 002b:00007fffd44a4028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Aug 16 21:17:58 horsti kernel: [ 5014.828296] RAX: ffffffffffffffda RBX: 00007fffd44a4080 RCX: 00007f20cd606cc7
Aug 16 21:17:58 horsti kernel: [ 5014.828297] RDX: 00007fffd44a4080 RSI: 00000000c0206440 RDI: 000000000000000a
Aug 16 21:17:58 horsti kernel: [ 5014.828298] RBP: 00000000c0206440 R08: 00000000ffffffff R09: 000056258d690010
Aug 16 21:17:58 horsti kernel: [ 5014.828298] R10: 00007f20cd6d0b80 R11: 0000000000000246 R12: 000056258e5f85c0
Aug 16 21:17:58 horsti kernel: [ 5014.828299] R13: 000000000000000a R14: 0000000404000000 R15: 0000000000200000
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^

> 
> Thanks
> 
> 
> Jan

