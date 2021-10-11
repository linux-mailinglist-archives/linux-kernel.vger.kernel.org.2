Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF054289C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 11:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbhJKJkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 05:40:37 -0400
Received: from foss.arm.com ([217.140.110.172]:40382 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235500AbhJKJke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 05:40:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 676011FB;
        Mon, 11 Oct 2021 02:38:33 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.22.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A2033F66F;
        Mon, 11 Oct 2021 02:38:30 -0700 (PDT)
Date:   Mon, 11 Oct 2021 10:38:18 +0100
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
Message-ID: <20211011093803.GA1421@C02TD0UTHF1T.local>
References: <1633673269-15048-1-git-send-email-huangzhaoyang@gmail.com>
 <20211008080113.GA441@willie-the-truck>
 <CAGWkznEh6RuEgxTH-vHB1kMjb0CERigqpL4+f0Lg1X1_VBQuMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznEh6RuEgxTH-vHB1kMjb0CERigqpL4+f0Lg1X1_VBQuMQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 08, 2021 at 04:34:12PM +0800, Zhaoyang Huang wrote:
> On Fri, Oct 8, 2021 at 4:01 PM Will Deacon <will@kernel.org> wrote:
> > On Fri, Oct 08, 2021 at 02:07:49PM +0800, Huangzhaoyang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > set_pstate_pan failure is observed in an ARM64 system occasionaly on a reboot
> > > test, which can be work around by a msleep on the sw context. We assume
> > > suspicious on disorder of previous instr of disabling SW_PAN and add an isb here.
> > >
> > > PS:
> > > The bootup test failed with a invalid TTBR1_EL1 that equals 0x34000000, which is
> > > alike racing between on chip PAN and SW_PAN.
> >
> > Sorry, but I'm struggling to understand the problem here. Please could you
> > explain it in more detail?
> >
> >   - Why does a TTBR1_EL1 value of `0x34000000` indicate a race?
> >   - Can you explain the race that you think might be occurring?
> >   - Why does an ISB prevent the race?
> Please find panic logs[1], related codes[2], sample of debug patch[3]
> below. TTBR1_EL1 equals 0x34000000 when panic

Just to check, how do you know the value of TTBR1_EL1 was 0x34000000?
That isn't in the log sample below -- was that from the output of
show_pte(), an external debugger, or something else?

I'm assuming from the "(ptrval)" bits below that can't have been from
show_pte().

> and can NOT be captured
> by the debug patch during retest (all entrances that msr ttbr1_el1 are
> under watch) which should work. Adding ISB here to prevent race on
> TTBR1 from previous access of sysregs which can affect the msr
> result(the test is still ongoing). Could the race be
> ARM64_HAS_PAN(automated by core) and SW_PAN.
> 
> [1]
> [    0.348000]  [0:    migration/0:   11] Synchronous External Abort:
> level 1 (translation table walk) (0x96000055) at 0xffffffc000e06004
> [    0.352000]  [0:    migration/0:   11] Internal error: : 96000055
> [#1] PREEMPT SMP
> [    0.352000]  [0:    migration/0:   11] Modules linked in:
> [    0.352000]  [0:    migration/0:   11] Process migration/0 (pid:
> 11, stack limit = 0x        (ptrval))
> [    0.352000]  [0:    migration/0:   11] CPU: 0 PID: 11 Comm:
> migration/0 Tainted: G S

Assuming I've read the `taint_flags` table correctly, that 'S' is
`TAINT_CPU_OUT_OF_SPEC`, for which we should dump warnings for at boot
time. The 'G' indicates the absence of proprietary modules.

Can you provide a full dmesg for a failed boot, please?

Have you made any changes to arch/arm64/kernel/cpufeature.c?

Are you able to test with a mainline kernel?

> 4.14.199-22631304-abA035FXXU0AUJ4_T4 #2
>
> [    0.352000]  [0:    migration/0:   11] Hardware name: Spreadtrum
> UMS9230 1H10 SoC (DT)
> [    0.352000]  [0:    migration/0:   11] task:         (ptrval)
> task.stack:         (ptrval)
> [    0.352000]  [0:    migration/0:   11] pc : patch_alternative+0x68/0x27c
> [    0.352000]  [0:    migration/0:   11] lr :
> __apply_alternatives.llvm.7450387295891320208+0x60/0x160
> 
> [2]
> __apply_alternatives
>    for()
>        patch_alternative    <----panic here in the 2nd round of loop
> after invoking flush_icache_range
>        flush_icache_range
> 
> [3]
> sub \tmp1, \tmp1, #SWAPPER_DIR_SIZE
> + tst     \tmp1, #0xffff80000000 // check ttbr1_el1 valid
> +    b.le    .

What are you trying to detect for here? This is testing both the ASID
and BADDR[47] bits, so I don;t understand the rationale.

Thanks,
Mark.

> msr ttbr1_el1, \tmp1 // set reserved ASID
> 
> >
> > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > ---
> > >  arch/arm64/kernel/cpufeature.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > > index efed283..3c0de0d 100644
> > > --- a/arch/arm64/kernel/cpufeature.c
> > > +++ b/arch/arm64/kernel/cpufeature.c
> > > @@ -1663,6 +1663,7 @@ static void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
> > >       WARN_ON_ONCE(in_interrupt());
> > >
> > >       sysreg_clear_set(sctlr_el1, SCTLR_EL1_SPAN, 0);
> > > +     isb();
> > >       set_pstate_pan(1);
> >
> > SCTLR_EL1.SPAN only affects the PAN behaviour on taking an exception, which
> > is itself a context-synchronizing event, so I can't see why the ISB makes
> > any difference here (at least, for the purposes of PAN).
> >
> > Thanks,
> >
> > Will
