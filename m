Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B677400552
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350595AbhICSwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:52:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350529AbhICSwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:52:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D873660C51;
        Fri,  3 Sep 2021 18:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630695067;
        bh=5NiM8VMO1LIQwTn4L9jl2W54+pPk+RVP77S++CXLuNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FytMIjDlWeOLSPtcCzsc8CA/wPvp/T414Qvz8xw16qJW9dRT+dEk6uvpv4JIC/948
         ZdsLcQSj8o7MalJU6Rn8MGQtb3JbVors9+qO8Qo1TSkQv5rW2XkrZw/JMykzF3XlY6
         SFtWAWEIJqNgQFIKvbQ1MjCuimATZgl0I5Y6rUY7kvgd+2Emu4jMvRuQ5sw+HuLNj9
         yy6xCrpCsoU43dsaSGnDtLD7gk26EMFXbVmeftPK8gIOgQ3oN5237itg+/mu6biuh2
         3p2bF7XHlOA3D+RuVYHJ2H0VA/UVqil+yNxlzrl7gMl3v7dl60Z2ZyB9QDGtJeJN2c
         Nsj/0YmmAGmnQ==
Date:   Fri, 3 Sep 2021 11:51:04 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [vmlinux.lds.h]  d4c6399900:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <YTJumKboBddccDUJ@Ryzen-9-3900X.localdomain>
References: <20210903053159.GA29784@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903053159.GA29784@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 01:31:59PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: d4c6399900364facd84c9e35ce1540b6046c345f ("vmlinux.lds.h: Avoid orphan section with !SMP")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: trinity
> version: trinity-x86_64-03f10b67-1_20210401
> with following parameters:
> 
> 	runtime: 300s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [  103.254262] BUG: unable to handle page fault for address: ffffffffbb443040
> [  103.255486] #PF: supervisor write access in kernel mode
> [  103.256427] #PF: error_code(0x0002) - not-present page
> [  103.257362] PGD 2cec37067 P4D 2cec37067 PUD 2cec38063 PMD 100235063 PTE 800ffffd2f9bc062
> [  103.258757] Oops: 0002 [#1] KASAN PTI
> [  103.259355] CPU: 0 PID: 1 Comm: swapper Not tainted 5.13.0-rc2+ #1
> [  103.260390] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [  103.261811] RIP: 0010:kvm_guest_apic_eoi_write+0x12/0x90
> [  103.262740] Code: 00 48 c7 c7 28 8d b1 ba e8 2b b5 60 00 eb cc 66 0f 1f 84 00 00 00 00 00 53 be 08 00 00 00 48 c7 c7 40 30 44 bb e8 ee b8 60 00 <48> 0f ba 35 95 d0 59 05 00 72 4e 48 c7 c0 80 fc 7f b9 48 ba 00 00
> [  103.265736] RSP: 0018:ffffc90000007fc8 EFLAGS: 00010046
> [  103.266640] RAX: 0000000000000001 RBX: ffffffffb97ffa40 RCX: ffffffffb5ea5fa2
> [  103.267869] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffffffbb443040
> [  103.269087] RBP: 0000000000000000 R08: 0000000000000001 R09: fffffbfff7688609
> [  103.270329] R10: ffffffffbb443047 R11: fffffbfff7688608 R12: 0000000000000000
> [  103.271490] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  103.272646] FS:  0000000000000000(0000) GS:ffffffffb9a7f000(0000) knlGS:0000000000000000
> [  103.273993] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  103.274963] CR2: ffffffffbb443040 CR3: 00000002cec34000 CR4: 00000000000406b0
> [  103.276150] Call Trace:
> [  103.276564]  <IRQ>
> [  103.276913]  __sysvec_apic_timer_interrupt+0x62/0x370
> [  103.277781]  sysvec_apic_timer_interrupt+0x62/0x80
> [  103.278602]  </IRQ>
> [  103.278984]  asm_sysvec_apic_timer_interrupt+0x12/0x20
> [  103.279890] RIP: 0010:call_rcu+0xc/0x150
> [  103.280559] Code: c7 c7 e0 db 05 ba e8 d3 23 33 02 85 c0 75 cc eb 9f 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 b8 00 00 00 00 00 fc ff df 55 53 <48> 89 fb 48 83 c7 08 48 89 fa 48 c1 ea 03 48 83 ec 08 80 3c 02 00
> [  103.283542] RSP: 0018:ffffc9000001fdb8 EFLAGS: 00000246
> [  103.284404] RAX: dffffc0000000000 RBX: fffff52000003fc6 RCX: 1ffffffff75653d5
> [  103.285532] RDX: 1ffff92000003fdd RSI: ffffffffb60b1810 RDI: ffffc9000001fe80
> [  103.286712] RBP: ffffc9000001fe80 R08: ffffc9000001fe60 R09: 0000000000000000
> [  103.287888] R10: 0000000000000001 R11: ffffc9000001fe90 R12: ffffc9000001fe60
> [  103.289058] R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000000
> [  103.290290]  ? rcu_tasks_pregp_step+0x10/0x10
> [  103.291029]  __wait_rcu_gp+0x160/0x440
> [  103.291650]  rcu_barrier+0x83/0xc0
> [  103.292234]  ? poll_state_synchronize_rcu+0x10/0x10
> [  103.293040]  ? synchronize_rcu+0x80/0x80
> [  103.293720]  ? lockdep_hardirqs_on_prepare+0x26b/0x3e0
> [  103.294554]  ? trace_hardirqs_on+0x3d/0x1d0
> [  103.295279]  ? _vdso_data+0xf80/0xf80
> [  103.295919]  ? _vdso_data+0xf80/0xf80
> [  103.296525]  ? free_kernel_image_pages+0xd/0x30
> [  103.297307]  ? rest_init+0x18e/0x18e
> [  103.297937]  kernel_init+0x20/0x112
> [  103.298537]  ret_from_fork+0x22/0x30
> [  103.299197] Modules linked in:
> [  103.299740] CR2: ffffffffbb443040
> [  103.300304] ---[ end trace 733607da50d3f759 ]---
> 
> 
> To reproduce:
> 
>         
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email

Hi,

This command mentions a bzImage but there is not one attached here nor
is the configuration file attached or linked anywhere so I am not really
able to investigate this without either of those :)

Cheers,
Nathan
