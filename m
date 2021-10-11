Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E6E428CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 14:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbhJKMRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 08:17:38 -0400
Received: from foss.arm.com ([217.140.110.172]:49934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234961AbhJKMRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 08:17:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52CDE1063;
        Mon, 11 Oct 2021 05:15:35 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.22.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F3F53F70D;
        Mon, 11 Oct 2021 05:15:33 -0700 (PDT)
Date:   Mon, 11 Oct 2021 13:15:30 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Quentin Perret <qperret@google.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>, ping.zhou1@unisoc.com
Subject: Re: [RFC PATCH] arch: ARM64: add isb before enable pan
Message-ID: <20211011121530.GC1421@C02TD0UTHF1T.local>
References: <1633673269-15048-1-git-send-email-huangzhaoyang@gmail.com>
 <20211008080113.GA441@willie-the-truck>
 <CAGWkznEh6RuEgxTH-vHB1kMjb0CERigqpL4+f0Lg1X1_VBQuMQ@mail.gmail.com>
 <20211011093803.GA1421@C02TD0UTHF1T.local>
 <CAGWkznHanuJ-yOhe=_gDF4Tw_m1e9R6bACvP2E+OHqw5Yifx_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznHanuJ-yOhe=_gDF4Tw_m1e9R6bACvP2E+OHqw5Yifx_w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 07:08:00PM +0800, Zhaoyang Huang wrote:
> On Mon, Oct 11, 2021 at 5:38 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, Oct 08, 2021 at 04:34:12PM +0800, Zhaoyang Huang wrote:
> > > On Fri, Oct 8, 2021 at 4:01 PM Will Deacon <will@kernel.org> wrote:
> > > > On Fri, Oct 08, 2021 at 02:07:49PM +0800, Huangzhaoyang wrote:
> > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > >
> > > > > set_pstate_pan failure is observed in an ARM64 system occasionaly on a reboot
> > > > > test, which can be work around by a msleep on the sw context. We assume
> > > > > suspicious on disorder of previous instr of disabling SW_PAN and add an isb here.
> > > > >
> > > > > PS:
> > > > > The bootup test failed with a invalid TTBR1_EL1 that equals 0x34000000, which is
> > > > > alike racing between on chip PAN and SW_PAN.
> > > >
> > > > Sorry, but I'm struggling to understand the problem here. Please could you
> > > > explain it in more detail?
> > > >
> > > >   - Why does a TTBR1_EL1 value of `0x34000000` indicate a race?
> > > >   - Can you explain the race that you think might be occurring?
> > > >   - Why does an ISB prevent the race?
> > > Please find panic logs[1], related codes[2], sample of debug patch[3]
> > > below. TTBR1_EL1 equals 0x34000000 when panic
> >
> > Just to check, how do you know the value of TTBR1_EL1 was 0x34000000?
> > That isn't in the log sample below -- was that from the output of
> > show_pte(), an external debugger, or something else?
> >
> > I'm assuming from the "(ptrval)" bits below that can't have been from
> > show_pte().
> >
> > > and can NOT be captured
> > > by the debug patch during retest (all entrances that msr ttbr1_el1 are
> > > under watch) which should work. Adding ISB here to prevent race on
> > > TTBR1 from previous access of sysregs which can affect the msr
> > > result(the test is still ongoing). Could the race be
> > > ARM64_HAS_PAN(automated by core) and SW_PAN.
> > >
> > > [1]
> > > [    0.348000]  [0:    migration/0:   11] Synchronous External Abort:
> > > level 1 (translation table walk) (0x96000055) at 0xffffffc000e06004
> > > [    0.352000]  [0:    migration/0:   11] Internal error: : 96000055
> > > [#1] PREEMPT SMP
> > > [    0.352000]  [0:    migration/0:   11] Modules linked in:
> > > [    0.352000]  [0:    migration/0:   11] Process migration/0 (pid:
> > > 11, stack limit = 0x        (ptrval))
> > > [    0.352000]  [0:    migration/0:   11] CPU: 0 PID: 11 Comm:
> > > migration/0 Tainted: G S
> >
> > Assuming I've read the `taint_flags` table correctly, that 'S' is
> > `TAINT_CPU_OUT_OF_SPEC`, for which we should dump warnings for at boot
> > time. The 'G' indicates the absence of proprietary modules.
> >
> > Can you provide a full dmesg for a failed boot, please?
> >
> > Have you made any changes to arch/arm64/kernel/cpufeature.c?
> >
> > Are you able to test with a mainline kernel?
> >
> > > 4.14.199-22631304-abA035FXXU0AUJ4_T4 #2
> > >
> > > [    0.352000]  [0:    migration/0:   11] Hardware name: Spreadtrum
> > > UMS9230 1H10 SoC (DT)
> > > [    0.352000]  [0:    migration/0:   11] task:         (ptrval)
> > > task.stack:         (ptrval)
> > > [    0.352000]  [0:    migration/0:   11] pc : patch_alternative+0x68/0x27c
> > > [    0.352000]  [0:    migration/0:   11] lr :
> > > __apply_alternatives.llvm.7450387295891320208+0x60/0x160
> > >
> > > [2]
> > > __apply_alternatives
> > >    for()
> > >        patch_alternative    <----panic here in the 2nd round of loop
> > > after invoking flush_icache_range
> > >        flush_icache_range
> > >
> > > [3]
> > > sub \tmp1, \tmp1, #SWAPPER_DIR_SIZE
> > > + tst     \tmp1, #0xffff80000000 // check ttbr1_el1 valid
> > > +    b.le    .
> >
> > What are you trying to detect for here? This is testing both the ASID
> > and BADDR[47] bits, so I don;t understand the rationale.
> >
> > Thanks,
> > Mark.
> this issue is fixed by the patch 'arm64: Avoid flush_icache_range() in
> alternatives patching code(429388682dc266e7a693f9c27e3aabd341d55343)'.
> thanks

Ah, thanks for this.

So this is because in arch/arm64/mm/cache.S we do (abbreviated):

| ENTRY(flush_icache_range)
| 	/* FALLTHROUGH */
| ENTRY(__flush_cache_user_range)
| 	uaccess_ttbr0_enable x2, x3, x4
| 
| 	...
| 
| 	uaccess_ttbr0_disable x1, x2
| 	ret
| ENDPROC(flush_icache_range)

... and even if I-caches are coherent and we don't execute junk for
something we've patched but not invalidated, since we patch each
alternative site in turn we can end up with unbalanced calls to
enable/disable across a number of patches.

It looks like 429388682dc266e7a693f9c27e3aabd341d55343 isn't in the
current linux-4.14.y, so we should post a backported version. From local
testing, that applies trivially.

Who wants to post that to stable? I can do if people want.

Thanks,
Mark.
