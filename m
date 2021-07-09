Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047053C2336
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 13:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbhGIMB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 08:01:56 -0400
Received: from foss.arm.com ([217.140.110.172]:51246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhGIMBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 08:01:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2150DED1;
        Fri,  9 Jul 2021 04:59:11 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F26D23F5A1;
        Fri,  9 Jul 2021 04:59:09 -0700 (PDT)
Subject: Re: WARNING: CPU: 5 PID: 0 at kernel/sched/fair.c:3306
To:     Bruno Goncalves <bgoncalv@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     nathan@kernel.org, Xiong Zhou <xzhou@redhat.com>,
        Juri Lelli <jlelli@redhat.com>,
        Memory Management <mm-qe@redhat.com>
References: <CA+QYu4p0+BCc4v6LBvkF9UpfzNYUEQwKBWEE7Br=fsFc7gk19w@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <9a0b208c-7449-a093-ae46-d89bda1fba0b@arm.com>
Date:   Fri, 9 Jul 2021 13:59:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CA+QYu4p0+BCc4v6LBvkF9UpfzNYUEQwKBWEE7Br=fsFc7gk19w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2021 13:12, Bruno Goncalves wrote:
> Hello,
> 
> Since this commit (Commit: 9269d27e519a - Merge tag
> 'timers-nohz-2021-06-28') we started to see the following call trace.
> 
> [ 1765.915152] ------------[ cut here ]------------
> [ 1765.970347] cfs_rq->avg.load_avg || cfs_rq->avg.util_avg ||
> cfs_rq->avg.runnable_avg
> [ 1765.970352] WARNING: CPU: 5 PID: 0 at kernel/sched/fair.c:3306
> update_blocked_averages+0x8e4/0x940
> [ 1766.170307] Modules linked in: dm_log_writes dm_flakey rfkill
> mlx4_ib ipmi_ssif ib_uverbs ib_core mlx4_en intel_rapl_msr
> intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp
> acpi_ipmi sunrpc rapl ipmi_si iTCO_wdt intel_cstate intel_pmc_bxt
> iTCO_vendor_support gpio_ich intel_uncore pcspkr ipmi_devintf lpc_ich
> ipmi_msghandler mlx4_core fuse zram ip_tables x_tables xfs i915
> crct10dif_pclmul crc32_pclmul crc32c_intel i2c_algo_bit drm_kms_helper
> ghash_clmulni_intel cec drm video
> [ 1766.685909] CPU: 5 PID: 0 Comm: swapper/5 Tainted: G        W
>   5.13.0 #1
> [ 1766.773390] Hardware name: HP ProLiant m710 Server Cartridge/, BIOS
> H03 04/26/2019
> [ 1766.863991] RIP: 0010:update_blocked_averages+0x8e4/0x940
> [ 1766.928557] Code: c7 c7 47 b5 5f 9b c6 05 3d ff 03 02 01 e8 29 16
> b3 00 e9 bc fe ff ff 48 c7 c7 b8 c6 5f 9b c6 05 63 0f 04 02 01 e8 ce
> d3 b2 00 <0f> 0b 8b 83 78 01 00 00 e9 2d fb ff ff 48 c7 c7 70 c1 5f 9b
> c6 05
> [ 1767.153523] RSP: 0018:ffffa2b5c01b0ee8 EFLAGS: 00010092
> [ 1767.216002] RAX: 0000000000000048 RBX: ffff91eb87ad9400 RCX: 0000000000000027
> [ 1767.301394] RDX: ffff91f25f358e18 RSI: 0000000000000001 RDI: ffff91f25f358e10
> [ 1767.386785] RBP: ffffa2b5c01b0f60 R08: 0000000000000000 R09: ffffa2b5c01b0d28
> [ 1767.472178] R10: ffffa2b5c01b0d20 R11: ffffffff9bf76208 R12: ffff91f25f36c900
> [ 1767.557568] R13: ffff91eb87ad9580 R14: 0000000000000001 R15: 00000198729d28c5
> [ 1767.642962] FS:  0000000000000000(0000) GS:ffff91f25f340000(0000)
> knlGS:0000000000000000
> [ 1767.739811] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1767.808538] CR2: 00007f9192568590 CR3: 00000001079e6005 CR4: 00000000001706e0
> [ 1767.893931] Call Trace:
> [ 1767.923077]  <IRQ>
> [ 1767.947017]  run_rebalance_domains+0x44/0x60
> [ 1767.998039]  __do_softirq+0xde/0x480
> [ 1768.040734]  __irq_exit_rcu+0xe4/0x110
> [ 1768.085507]  irq_exit_rcu+0xa/0x20
> [ 1768.126111]  sysvec_apic_timer_interrupt+0x72/0x90
> [ 1768.183385]  </IRQ>
> [ 1768.208365]  asm_sysvec_apic_timer_interrupt+0x12/0x20
> [ 1768.269805] RIP: 0010:cpuidle_enter_state+0x104/0x470
> [ 1768.330209] Code: 48 0f a3 05 1e 63 85 01 0f 82 63 02 00 00 31 ff
> e8 21 3d 7c ff 45 84 ff 0f 85 dd 01 00 00 e8 63 8f 8b ff fb 66 0f 1f
> 44 00 00 <45> 85 f6 0f 88 fb 00 00 00 49 63 d6 4c 2b 2c 24 48 8d 04 52
> 48 8d
> [ 1768.555179] RSP: 0018:ffffa2b5c00bbeb0 EFLAGS: 00000246
> [ 1768.617657] RAX: 0000000080000001 RBX: 0000000000000001 RCX: 000000000000001f
> [ 1768.703048] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff9a9fb21d
> [ 1768.788440] RBP: ffffc2b5bfd40260 R08: 0000000000000000 R09: 0000000000000000
> [ 1768.873832] R10: 000000000000002a R11: 000000000000000d R12: ffffffff9c1043a0
> [ 1768.959226] R13: 0000019b28beb466 R14: 0000000000000001 R15: 0000000000000000
> [ 1769.044620]  ? cpuidle_enter_state+0xfd/0x470
> [ 1769.096688]  cpuidle_enter+0x29/0x40
> [ 1769.139377]  do_idle+0x1e9/0x290
> [ 1769.177898]  cpu_startup_entry+0x19/0x20
> [ 1769.224757]  secondary_startup_64_no_verify+0xc2/0xcb
> [ 1769.285164] irq event stamp: 2874708
> [ 1769.327849] hardirqs last  enabled at (2874707):
> [<ffffffff9a242ed5>] tick_nohz_idle_enter+0x65/0x90
> [ 1769.437205] hardirqs last disabled at (2874708):
> [<ffffffff9a1bf08d>] do_idle+0xad/0x290
> [ 1769.534062] softirqs last  enabled at (2874690):
> [<ffffffff9a1808e4>] __irq_exit_rcu+0xe4/0x110
> [ 1769.638207] softirqs last disabled at (2874685):
> [<ffffffff9a1808e4>] __irq_exit_rcu+0xe4/0x110
> [ 1769.742350] ---[ end trace fffd33f79ba8504e ]---
> 
> 
> We hit this issue running different tests and on different arches.

This has been reported already and is fixed with:

https://lkml.kernel.org/r/162488868552.395.3605721602918699622.tip-bot2@tip-bot2


https://lkml.kernel.org/r/162547163867.395.4833924212740469681.tip-bot2@tip-bot2



