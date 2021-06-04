Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADB039C32F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 00:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhFDWGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 18:06:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:33457 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229668AbhFDWGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 18:06:31 -0400
IronPort-SDR: 9i2T3qK/xUagvad3YjfPzuI2h+5ASUiWDJPJE7gkt45qip4ird6nRpIADO02SKN52AMaHu/puX
 FKjgsUb8YWFw==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="184747223"
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="184747223"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 15:04:43 -0700
IronPort-SDR: nFB2NnIBs1wkX9RHho7+bJCCDgzxCI3KrlcC66rsku3ngvnat7YMJ6tcKSwVOe5lvwj3ALYg/Q
 FKO0gNAEBwFQ==
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="480793221"
Received: from samiredd-mobl1.amr.corp.intel.com (HELO [10.255.230.53]) ([10.255.230.53])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 15:04:43 -0700
Subject: Re: [patch 0/8] x86/fpu: Mop up XSAVES and related damage
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20210602095543.149814064@linutronix.de>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <433086cd-fadf-efe2-955b-0263a2fc969f@intel.com>
Date:   Fri, 4 Jun 2021 15:04:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210602095543.149814064@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nice Intel 0day folks threw some tests at this series.  It managed
to trigger an oops.  I can't right this moment publish the source for
the test, but it looks pretty trivial.  It basically creates a 0'd XSAVE
buffer, sets XCOMP_BV to:

#define XSAVES_FEATURES ( \
        XFEATURE_MASK_PT | \
        XFEATURE_MASK_SHSTK_USER | \
        XFEATURE_MASK_SHSTK_KERNEL | \
        0x8000000000000000 \
        )

Then passes that buffer in to ptrace(PTRACE_SETREGSET, ...).

The oops is below.  It doesn't *look* to be XSAVES-related.  The oops
looks like it's happening in xstateregs_set() itself as opposed to down
in the code actually concerned with supervisor state.

No bug is jumping out of the code as I took a brief look at it.  The
xbuf versus kbuf code looks a bit wonky, but I can't find a hole in it.

I'll see if I can reproduce this locally.

> [   38.612897] BAT XSAVE
> [   38.612902]
> [   38.619525] os
> [   38.619528]
> [   38.625885] enumeration
> [   38.625890]
> [   38.633098] schedule check
> [   38.633105]
> [   38.640308] fork check
> [   38.640321]
> [   38.647154] signal check
> [   38.647164]
> [   38.654065] thread check
> [   38.654072]
> [   38.661036] multi thread check
> [   38.661042]
> [   75.771095] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [   75.779596] #PF: supervisor read access in kernel mode
> [   75.785980] #PF: error_code(0x0000) - not-present page
> [   75.792321] PGD 0 P4D 0
> [   75.795742] Oops: 0000 [#1] SMP PTI
> [   75.800233] CPU: 94 PID: 2145 Comm: ptrace_sys_stat Not tainted 5.13.0-rc4-00096-g2c38e60b245f #1
> [   75.810753] Hardware name: Intel Corporation BRICKLAND/BRICKLAND, BIOS BRHSXSD1.86B.0067.R02.1507221722 07/22/2015
> [   75.822934] RIP: 0010:xstateregs_set+0x9f/0x140
> [   75.828591] Code: e0 5d 41 5c 41 5d 41 5e 41 5f c3 41 89 cf 4d 89 ce 4c 89 ff e8 32 87 2e 00 48 89 c5 48 85 c0 0f 84 8a 00 00 00 45 85 e4 74 20 <48> 8b 34 25 00 00 00 00 48 85 f6 74 2f 4c 89 fa 48 89 c7 e8 89 78
> [   75.850813] RSP: 0018:ffffc90023a47e38 EFLAGS: 00010202
> [   75.857241] RAX: ffffc9000c9dd000 RBX: ffff88c107824f80 RCX: 8000000000000063
> [   75.865827] RDX: 0000000000000001 RSI: ffff888100000000 RDI: ffff888100203328
> [   75.874376] RBP: ffffc9000c9dd000 R08: ffff88810cdffef0 R09: 8000000000000063
> [   75.882928] R10: 0000000000000ee8 R11: ffff88a08159c3f0 R12: 0000000000000340
> [   75.891427] R13: ffff88c1078273c0 R14: 000055576f8960c0 R15: 0000000000000340
> [   75.899961] FS:  00007f50ad027500(0000) GS:ffff88bfff980000(0000) knlGS:0000000000000000
> [   75.909533] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   75.916458] CR2: 0000000000000000 CR3: 000000208df04004 CR4: 00000000001706e0
> [   75.924975] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   75.933434] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   75.941911] Call Trace:
> [   75.945118]  ptrace_request+0x4cb/0x600
> [   75.949893]  arch_ptrace+0x125/0x300
> [   75.954350]  ? ptrace_check_attach+0x69/0x140
> [   75.959690]  __x64_sys_ptrace+0x80/0x140
> [   75.964532]  do_syscall_64+0x40/0x80
> [   75.969004]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   75.975120] RIP: 0033:0x7f50acf5692f
> [   75.979581] Code: c7 44 24 10 18 00 00 00 48 89 44 24 18 48 8d 44 24 30 8b 70 08 48 8b 50 10 4c 0f 43 50 18 48 89 44 24 20 b8 65 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 48 85 c0 78 06 41 83 f8 02 76 1e 48 8b 4c
> [   76.001535] RSP: 002b:00007fff18a9f6f0 EFLAGS: 00000202 ORIG_RAX: 0000000000000065
> [   76.010465] RAX: ffffffffffffffda RBX: 0000000000000862 RCX: 00007f50acf5692f
> [   76.018960] RDX: 0000000000000202 RSI: 0000000000000862 RDI: 0000000000004205
> [   76.027433] RBP: 000055576f8960c0 R08: 0000000000004204 R09: 00007f50ad027500
> [   76.035947] R10: 00007fff18a9f770 R11: 0000000000000202 R12: 0000000000000340
> [   76.044428] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [   76.052957] Modules linked in: xfs libcrc32c sr_mod sd_mod cdrom t10_pi sg intel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm mgag200 irqbypass crct10dif_pclmul drm_kms_helper crc32_pclmul ipmi_ssif crc32c_intel ghash_clmulni_intel rapl syscopyarea sysfillrect intel_cstate ahci sysimgblt fb_sys_fops libahci mpt3sas acpi_ipmi intel_uncore raid_class drm libata ipmi_si joydev scsi_transport_sas wmi ipmi_devintf ipmi_msghandler acpi_pad ip_tables
> [   76.104215] CR2: 0000000000000000
> [   76.108641] ---[ end trace dd34396ee89519a4 ]---
> [   76.114448] RIP: 0010:xstateregs_set+0x9f/0x140
> [   76.120185] Code: e0 5d 41 5c 41 5d 41 5e 41 5f c3 41 89 cf 4d 89 ce 4c 89 ff e8 32 87 2e 00 48 89 c5 48 85 c0 0f 84 8a 00 00 00 45 85 e4 74 20 <48> 8b 34 25 00 00 00 00 48 85 f6 74 2f 4c 89 fa 48 89 c7 e8 89 78
> [   76.142571] RSP: 0018:ffffc90023a47e38 EFLAGS: 00010202
> [   76.149152] RAX: ffffc9000c9dd000 RBX: ffff88c107824f80 RCX: 8000000000000063
> [   76.157855] RDX: 0000000000000001 RSI: ffff888100000000 RDI: ffff888100203328
> [   76.166562] RBP: ffffc9000c9dd000 R08: ffff88810cdffef0 R09: 8000000000000063
> [   76.175265] R10: 0000000000000ee8 R11: ffff88a08159c3f0 R12: 0000000000000340
> [   76.183967] R13: ffff88c1078273c0 R14: 000055576f8960c0 R15: 0000000000000340
> [   76.192662] FS:  00007f50ad027500(0000) GS:ffff88bfff980000(0000) knlGS:0000000000000000
> [   76.202425] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   76.209590] CR2: 0000000000000000 CR3: 000000208df04004 CR4: 00000000001706e0
> [   76.218266] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   76.226957] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   76.235597] Kernel panic - not syncing: Fatal exception
> [   76.284889] Kernel Offset: disabled
> ACPI MEMORY or I/O RESET_REG.
