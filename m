Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24332305E0E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhA0OUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:20:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51840 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233575AbhA0OSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:18:14 -0500
Received: from zn.tnic (p200300ec2f0f5c00182d512fee937b6e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5c00:182d:512f:ee93:7b6e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2334D1EC04BF;
        Wed, 27 Jan 2021 15:17:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611757047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0gUhx+G0BJvfP0mGy0PXt1WgF74e3+vqsdiP9M9v1AA=;
        b=V5qp1DxYbAxpzJ5aWe1+Fr8ixwvDdYQ004K4ja0VQiqWSTeLKru/4ZFp9TU6OHzZ5tnWFd
        HodzFR88Lut6oftFZPoi9rsjkXktB2/rN+eazbre1YwWynf9kh/yxojL8mFo2vZtXlUzKu
        eGMpM7JVvFU7ZNtZxRnK+AqvgEpm1+g=
Date:   Wed, 27 Jan 2021 15:17:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stefan Saecherl <stefan.saecherl@fau.de>, x86@kernel.org,
        linux-kernel@i4.cs.fau.de,
        Lorena Kretzschmar <qy15sije@cip.cs.fau.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kgdb: Allow removal of early BPs
Message-ID: <20210127141721.GC17424@zn.tnic>
References: <20201214141314.5717-1-stefan.saecherl@fau.de>
 <YA//ZcJAyQPEtybr@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YA//ZcJAyQPEtybr@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 12:39:17PM +0100, Peter Zijlstra wrote:
> On Mon, Dec 14, 2020 at 03:13:12PM +0100, Stefan Saecherl wrote:
> 
> > One thing to consider when doing this is that code can go away during boot
> > (e.g. .init.text). Previously kgdb_arch_remove_breakpoint handled this case
> > gracefully by just having copy_to_kernel_nofault fail but if one then calls
> > text_poke_kgdb the system dies due to the BUG_ON we moved out of
> > __text_poke.  To avoid this __text_poke now returns an error in case of a
> > nonpresent code page and the error is handled at call site.
> 
> So what if the page is reused and now exists again?
> 
> We keep track of the init state, how about you look at that and not poke
> at .init.text after it's freed instead?

Dunno if this is related but kgdb doesn't like one of its selftests
either. It triggers in a vm.

[    2.036914] [drm] Initialized cirrus 2.0.0 2019 for 0000:00:02.0 on minor 0
[    2.037803] fbcon: cirrusdrmfb (fb0) is primary device
[    2.180326] Console: switching to colour frame buffer device 128x48
[    2.225910] cirrus 0000:00:02.0: [drm] fb0: cirrusdrmfb frame buffer device
[    2.229397] KGDB: Registered I/O driver kgdbts
[    2.230931] kgdbts:RUN hw breakpoint test

Entering kdb (current=0xffff88800c1f0000, pid 1) on processor 1 due to NonMaskable Interrupt @ 0xffffffff81121490
[1]kdb> [    2.234788] INFO: NMI handler (kgdb_nmi_handler) took too long to run: 3.308 msecs
[    2.234994] INFO: NMI handler (kgdb_nmi_handler) took too long to run: 3.303 msecs
[    2.235003] INFO: NMI handler (kgdb_nmi_handler) took too long to run: 3.306 msecs
[    2.237092] kgdbts:RUN hw write breakpoint test
[    2.245435] kgdbts:RUN access write breakpoint test
[    2.248446] kgdbts: ERROR hw_access_break_test test failed
[    2.249430] ------------[ cut here ]------------
[    2.250233] WARNING: CPU: 1 PID: 1 at drivers/misc/kgdbts.c:903 run_hw_break_test.cold+0x13/0x30
[    2.251790] Modules linked in:
[    2.252341] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.11.0-rc5+ #2
[    2.253444] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
[    2.254925] RIP: 0010:run_hw_break_test.cold+0x13/0x30
[    2.255820] Code: 00 48 8b 35 0f e3 f9 09 48 c7 c7 18 15 12 82 e8 96 1f fe ff 0f 0b c3 48 8b 35 f9 e2 f9 09 48 c7 c7 18 15 12 82 e8 80 1f fe ff <0f> 0b c3 48 8b 35 e3 e2 f9 09 48 c7 c7 38 15 12 82 e8 6a 1f fe ff
[    2.259062] RSP: 0018:ffffc90000013e78 EFLAGS: 00010286
[    2.259971] RAX: 000000000000002e RBX: 0000000000000000 RCX: 00000000ffefffff
[    2.261198] RDX: 00000000ffffffea RSI: ffffc90000013d18 RDI: ffffffff8978d0ec
[    2.263054] RBP: 0000000000000000 R08: ffffffff89249128 R09: 0000000000000058
[    2.264848] R10: ffffffff87a49140 R11: 00000000fff00000 R12: 0000000000000000
[    2.266677] R13: 00000000000003e8 R14: 0000000000000000 R15: 0000000000000064
[    2.268509] FS:  0000000000000000(0000) GS:ffff88807da40000(0000) knlGS:0000000000000000
[    2.271591] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.273193] CR2: 0000000000000000 CR3: 000000000220a000 CR4: 00000000003506e0
[    2.275051] DR0: ffffffff8b7fc8a4 DR1: 0000000000000000 DR2: 0000000000000000
[    2.276841] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[    2.278629] Call Trace:
[    2.279669]  configure_kgdbts+0x2c8/0x560
[    2.280930]  ? regmap_initcall+0xd/0xd
[    2.282144]  do_one_initcall+0x44/0x200
[    2.283404]  kernel_init_freeable+0x16d/0x1b2
[    2.284705]  ? rest_init+0xb9/0xb9
[    2.285845]  kernel_init+0xa/0x107
[    2.287012]  ret_from_fork+0x22/0x30
[    2.288163] ---[ end trace eb784077898119a0 ]---
[    2.289486] kgdbts:RUN plant and detach test
[    2.291842] kgdbts:RUN sw breakpoint test
[    2.296227] kgdbts:RUN bad memory access test
[    2.298555] kgdbts:RUN singlestep test 1000 iterations
[    2.304355] kgdbts:RUN singlestep [0/1000]
[    2.374077] perf: interrupt took too long (2502 > 2500), lowering kernel.perf_event_max_sample_rate to 79750
[    2.411530] perf: interrupt took too long (3581 > 3127), lowering kernel.perf_event_max_sample_rate to 55750
[    2.425941] INFO: NMI handler (kgdb_nmi_handler) took too long to run: 3.975 msecs
[    2.425948] INFO: NMI handler (kgdb_nmi_handler) took too long to run: 3.968 msecs
[    2.425954] INFO: NMI handler (kgdb_nmi_handler) took too long to run: 3.975 msecs
[    2.425960] INFO: NMI handler (kgdb_nmi_handler) took too long to run: 3.973 msecs
[    2.721821] kgdbts:RUN singlestep [100/1000]
[    3.135615] kgdbts:RUN singlestep [200/1000]
[    3.548892] kgdbts:RUN singlestep [300/1000]
[    3.960696] kgdbts:RUN singlestep [400/1000]

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
