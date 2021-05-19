Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810A73892B5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354903AbhESPdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbhESPdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:33:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32121C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ou5uvPPkq3LxjAbOzolZRT6zjPS/wj+utxll/2Chyf8=; b=BulcEXuXvt/icavt7ywcpRMpW2
        SLHuhaLFlDRbyjrTUT3E7/D3xBwNu7H92/5MYvBaKs8tL4CVb40P+TTR/12TkIvEvFE4COMMtz5k0
        1K1IFsMgAJMDUh9AKsPKMn18Z8T2jNN/BOi+OjMcgvcxJwv26CqH8ZriZR344lrxRJZGv3FFd+FLY
        Rxmkf4HRNM4bgOWrbIFdU8JAZct0bos6hivW1PpArHL2kggQpMcB8Ph0gt4rqbK2EV/Ik3kuvo+BP
        7mRLPU+ndjkFKK9u9wGA/QF/J5WHi1JqhXpYEEUScm1qNYHnFw6Q+eWeeK3QM3AhEoMILTEyHfKDM
        Pq/ShtbA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljOAA-00F4yn-88; Wed, 19 May 2021 15:31:29 +0000
Date:   Wed, 19 May 2021 16:31:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        lkft-triage@lists.linaro.org, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Oliver Sang <oliver.sang@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, x86@kernel.org
Subject: Re: BUG: unable to handle page fault for address - EIP:
 __kmap_local_page_prot
Message-ID: <YKUvPhhvudOv6aP3@casper.infradead.org>
References: <CA+G9fYtAbUGO9oAtL8eZ9Pu-_a1wx3y8Tk=pDO3Fh3dEwoRGWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtAbUGO9oAtL8eZ9Pu-_a1wx3y8Tk=pDO3Fh3dEwoRGWg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I think this is an i386 specific issue.  It shouldn't even have PUDs,
right?  This is a CONFIG_HIGHMEM4G=y kernel, so it uses PGDs, PMDs and
PTEs.

On Wed, May 19, 2021 at 08:38:19PM +0530, Naresh Kamboju wrote:
> While running LTP mm test suite on i386 kernel the following warning and BUG
> reported on linux next 5.13.0-rc2-next-20210519.
> 
> The warning is not regression, We have been noticing these warnings often on
> i386 but kernel BUG: looks to be a new crash.
> 
>  ------------[ cut here ]------------
> [  696.876399] WARNING: CPU: 1 PID: 24493 at mm/mremap.c:314
> move_page_tables+0x18d/0x6e0
> [  696.884319] Modules linked in: x86_pkg_temp_thermal
> 05.c:78: TPASS: [  696.889246] CPU: 1 PID: 24493 Comm: true Not
> tainted 5.13.0-rc2-next-20210519 #1
> [  696.898018] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.2 05/23/2018
> [  696.905462] EIP: move_page_tables+0x18d/0x6e0
> still alive.
> ks[  696.909865] Code: 40 20 8b 40 24 89 c1 01 d9 0f 84 36 04 00 00 8b
> 55 08 c1 ea 16 8d 04 90 85 c0 0f 84 e5 02 00 00 80 7d bb 00 0f 85 23
> 04 00 00 <0f> 0b 80 7d bb 00 0f 84 f7 fe ff ff 8b 45 c8 e8 1f fe ff ff
> e9 ea
> [  696.929986] EAX: c28a5bf8 EBX: 00000bfc ECX: c28a5bfc EDX: 000002fe
> [  696.936323] ESI: c0000000 EDI: bfc00000 EBP: c86ffe14 ESP: c86ffda8
> m05.c:78: TPASS:[  696.942614] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS:
> 0068 EFLAGS: 00010246
> [  696.950777] CR0: 80050033 CR2: b7e13b50 CR3: 028a5000 CR4: 003506d0
> [  696.957043] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [  696.963310] DR6: fffe0ff0 DR7: 00000400
> [  696.967148] Call Trace:
> [  696.969594]  setup_arg_pages+0x28c/0x380
>  still alive.
> k[  696.973563]  ? get_random_u32+0x35/0x80
> [  696.978779]  ? trace_hardirqs_off+0x2f/0xc0
> sm05.c:78: TPASS[  696.983006]  ? trace_hardirqs_on+0x2d/0xc0
> [  696.988484]  ? _raw_spin_unlock_irqrestore+0x18/0x20
> [  696.993467]  ? get_random_u32+0x4e/0x80
> [  696.997385]  load_elf_binary+0x31e/0x11c0
> [  697.001452]  ? security_file_permission+0x97/0x170
> [  697.006277]  ? kernel_read+0x31/0x40
> [  697.009907]  bprm_execve+0x233/0x5f0
> [  697.013541]  do_execveat_common+0x129/0x150
> [  697.017725]  __ia32_sys_execve+0x28/0x30
> [  697.021650]  __do_fast_syscall_32+0x4c/0xc0
> [  697.025835]  do_fast_syscall_32+0x29/0x60
> [  697.029850]  do_SYSENTER_32+0x15/0x20
> [  697.033516]  entry_SYSENTER_32+0x98/0xe7
> [  697.037441] EIP: 0xb7f12549
> [  697.040243] Code: Unable to access opcode bytes at RIP 0xb7f1251f.
> : still alive.
> [  697.046462] EAX: ffffffda EBX: bfd72c00 ECX: 0806b460 EDX: bfd72e54
> [  697.054106] ESI: 0805af94 EDI: bfd72c09 EBP: bfd72cc8 ESP: bfd72bd8
> [  697.060425] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 007b EFLAGS: 00000296
> [  697.067210] ---[ end trace 7b789866f6f48389 ]---
> [  697.071832] ------------[ cut here ]------------
> 
> ...
> ksm05.c:78: TPASS: still alive.
> 
> [  699.637408] BUG: unable to handle page fault for address: f752b000
> [  699.644091] #PF: supervisor read access in kernel mode
> [  699.649222] #PF: error_code(0x0000) - not-present page
> [  699.654357] *pde = 01106067 *pte = 00000000
> [  699.658666] Oops: 0000 [#1] SMP
> [  699.661806] CPU: 1 PID: 24636 Comm: true Tainted: G        W
>  5.13.0-rc2-next-20210519 #1
> [  699.670583] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.2 05/23/2018
> [  699.677966] EIP: __kmap_local_page_prot+0x6/0x40
> [  699.682614] Code: 00 00 00 00 c6 05 00 cc 2c d4 00 8b 5d fc c9 c3
> 8d 74 26 00 0f 0b 0f 0b 8d b4 26 00 00 00 00 8d 74 26 00 90 3e 8d 74
> 26 00 55 <8b> 08 c1 e9 1e 89 e5 83 f9 02 74 17 83 f9 03 74 09 e8 54 fe
> ff ff
> [  699.701371] EAX: f752b000 EBX: 00000004 ECX: bf400000 EDX: 00000163
> [  699.707640] ESI: f752b000 EDI: c86ffecc EBP: c86ffe60 ESP: c86ffe00
> [  699.713897] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010202
> [  699.720676] CR0: 80050033 CR2: f752b000 CR3: 028a5000 CR4: 003506d0
> [  699.726934] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [  699.733197] DR6: fffe0ff0 DR7: 00000400
> [  699.737027] Call Trace:
> [  699.739474]  ? unmap_page_range+0x154/0x690
> [  699.743658]  unmap_single_vma+0x61/0xc0
> [  699.747489]  unmap_vmas+0x6f/0xf0
> [  699.750800]  exit_mmap+0x71/0x1c0
> [  699.754110]  mmput+0x57/0x100
> [  699.757075]  do_exit+0x2da/0x9e0
> [  699.760306]  ? syscall_trace_enter.isra.0+0x148/0x1b0
> [  699.765372]  do_group_exit+0x36/0x90
> [  699.768955]  __ia32_sys_exit_group+0x15/0x20
> [  699.773220]  __do_fast_syscall_32+0x4c/0xc0
> [  699.777405]  do_fast_syscall_32+0x29/0x60
> [  699.781409]  do_SYSENTER_32+0x15/0x20
> [  699.785066]  entry_SYSENTER_32+0x98/0xe7
> [  699.788984] EIP: 0x1ff58549
> [  699.791774] Code: Unable to access opcode bytes at RIP 0x1ff5851f.
> [  699.797945] EAX: ffffffda EBX: 00000000 ECX: 00000001 EDX: 00000000
> [  699.804202] ESI: 1ff471f0 EDI: 1ff493fc EBP: 00000000 ESP: bf1ff3cc
> [  699.810458] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 007b EFLAGS: 00000296
> [  699.817236] Modules linked in: x86_pkg_temp_thermal
> [  699.822115] CR2: 00000000f752b000
> [  699.825426] ---[ end trace 7b789866f6f4838b ]---
> [  699.830036] EIP: __kmap_local_page_prot+0x6/0x40
> [  699.834655] Code: 00 00 00 00 c6 05 00 cc 2c d4 00 8b 5d fc c9 c3
> 8d 74 26 00 0f 0b 0f 0b 8d b4 26 00 00 00 00 8d 74 26 00 90 3e 8d 74
> 26 00 55 <8b> 08 c1 e9 1e 89 e5 83 f9 02 74 17 83 f9 03 74 09 e8 54 fe
> ff ff
> [  699.853401] EAX: f752b000 EBX: 00000004 ECX: bf400000 EDX: 00000163
> [  699.859658] ESI: f752b000 EDI: c86ffecc EBP: c86ffe60 ESP: c86ffe00
> [  699.865915] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010202
> [  699.872690] CR0: 80050033 CR2: f752b000 CR3: 028a5000 CR4: 003506d0
> [  699.878948] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [  699.885207] DR6: fffe0ff0 DR7: 00000400
> [  699.889036] Fixing recursive fault but reboot is needed!
> 
> ksm05.c:78: TPASS: still alive.
> ..
> [ 1599.651922] BUG: unable to handle page fault for address: f7d64000
> [ 1599.658959] #PF: supervisor read access in kernel mode
> [ 1599.664088] #PF: error_code(0x0000) - not-present page
> [ 1599.669219] *pde = 00000000
> [ 1599.672097] Oops: 0000 [#2] SMP
> [ 1599.675236] CPU: 3 PID: 24646 Comm: thp02 Tainted: G      D W
>   5.13.0-rc2-next-20210519 #1
> [ 1599.684102] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.2 05/23/2018
> [ 1599.691485] EIP: __kmap_local_page_prot+0x6/0x40
> [ 1599.696102] Code: 00 00 00 00 c6 05 00 cc 2c d4 00 8b 5d fc c9 c3
> 8d 74 26 00 0f 0b 0f 0b 8d b4 26 00 00 00 00 8d 74 26 00 90 3e 8d 74
> 26 00 55 <8b> 08 c1 e9 1e 89 e5 83 f9 02 74 17 83 f9 03 74 09 e8 54 fe
> ff ff
> [ 1599.714840] EAX: f7d64000 EBX: b5800000 ECX: b5800000 EDX: 00000163
> [ 1599.721097] ESI: f7d64000 EDI: c1a5decc EBP: c1a5de60 ESP: c1a5de00
> [ 1599.727354] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010202
> [ 1599.734132] CR0: 80050033 CR2: f7d64000 CR3: 19fce000 CR4: 003506d0
> [ 1599.740387] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [ 1599.746646] DR6: fffe0ff0 DR7: 00000400
> [ 1599.750477] Call Trace:
> [ 1599.752919]  ? unmap_page_range+0x154/0x690
> [ 1599.757096]  unmap_single_vma+0x61/0xc0
> [ 1599.760929]  unmap_vmas+0x6f/0xf0
> [ 1599.764246]  exit_mmap+0x71/0x1c0
> [ 1599.767558]  mmput+0x57/0x100
> [ 1599.770531]  do_exit+0x2da/0x9e0
> [ 1599.773763]  ? syscall_trace_enter.isra.0+0x148/0x1b0
> [ 1599.778815]  do_group_exit+0x36/0x90
> [ 1599.782393]  __ia32_sys_exit_group+0x15/0x20
> [ 1599.786659]  __do_fast_syscall_32+0x4c/0xc0
> [ 1599.790845]  do_fast_syscall_32+0x29/0x60
> [ 1599.794857]  do_SYSENTER_32+0x15/0x20
> [ 1599.798513]  entry_SYSENTER_32+0x98/0xe7
> [ 1599.802441] EIP: 0xb7fa6549
> [ 1599.805237] Code: Unable to access opcode bytes at RIP 0xb7fa651f.
> [ 1599.811408] EAX: ffffffda EBX: 00000002 ECX: 00000000 EDX: bfff8660
> [ 1599.817665] ESI: b7f761f0 EDI: b7f783fc EBP: 00000000 ESP: bfff866c
> [ 1599.823922] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 007b EFLAGS: 00000296
> [ 1599.830702] Modules linked in: x86_pkg_temp_thermal
> [ 1599.835579] CR2: 00000000f7d64000
> [ 1599.838890] ---[ end trace 7b789866f6f4838c ]---
> [ 1599.843499] EIP: __kmap_local_page_prot+0x6/0x40
> [ 1599.848111] Code: 00 00 00 00 c6 05 00 cc 2c d4 00 8b 5d fc c9 c3
> 8d 74 26 00 0f 0b 0f 0b 8d b4 26 00 00 00 00 8d 74 26 00 90 3e 8d 74
> 26 00 55 <8b> 08 c1 e9 1e 89 e5 83 f9 02 74 17 83 f9 03 74 09 e8 54 fe
> ff ff
> [ 1599.866849] EAX: f752b000 EBX: 00000004 ECX: bf400000 EDX: 00000163
> [ 1599.873114] ESI: f752b000 EDI: c86ffecc EBP: c86ffe60 ESP: c86ffe00
> [ 1599.879369] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010202
> [ 1599.886148] CR0: 80050033 CR2: f7d64000 CR3: 19fce000 CR4: 003506d0
> [ 1599.892404] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [ 1599.898661] DR6: fffe0ff0 DR7: 00000400
> [ 1599.902493] Fixing recursive fault but reboot is needed!
> O: mremap (0xb6c00000-0xb7bff000) to (0xb5800000-0xb67ff000)
> thp02.c:84: TBROK: mremap bug
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> 
> Links:
> https://lkft.validation.linaro.org/scheduler/job/2742412#L8838
> 
> Step to reproduce:
> ------------------
> # cd /opt/ltp
> # ./runltp -f mm
> 
> metadata:
>   git branch: master
>   git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git commit: 9f24705effef8c3b9eca00d70594ef7e0364a6da
>   git describe: next-20210519
>   make_kernelversion: 5.13.0-rc2
>   kernel-config: https://builds.tuxbuild.com/1sk6bnicwdtrZQO2wqfaMdsZO5z/config
> 
> -- 
> Linaro LKFT
> https://lkft.linaro.org
> 
