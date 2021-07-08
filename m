Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AA23BF939
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhGHLoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 07:44:46 -0400
Received: from foss.arm.com ([217.140.110.172]:56896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231575AbhGHLoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:44:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06D63ED1;
        Thu,  8 Jul 2021 04:42:04 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.4.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8EF53F5A1;
        Thu,  8 Jul 2021 04:42:00 -0700 (PDT)
Date:   Thu, 8 Jul 2021 12:41:57 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "konrad.dybcio@somainline.org" <konrad.dybcio@somainline.org>,
        "saiprakash.ranjan@codeaurora.org" <saiprakash.ranjan@codeaurora.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linu Cherian <lcherian@marvell.com>
Subject: Re: [EXT] Re: [PATCH] clocksource: Add Marvell Errata-38627
 workaround
Message-ID: <20210708114157.GC24650@C02TD0UTHF1T.local>
References: <20210705060843.3150-1-bbhushan2@marvell.com>
 <20210705090753.GD38629@C02TD0UTHF1T.local>
 <CO6PR18MB4465687A22FE724E59D4225CE3199@CO6PR18MB4465.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO6PR18MB4465687A22FE724E59D4225CE3199@CO6PR18MB4465.namprd18.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 10:47:42AM +0000, Bharat Bhushan wrote:
> Hi Mark,
> 
> Sorry for the delay, was gathering some details.
> Pease see inline
> 
> > -----Original Message-----
> > From: Mark Rutland <mark.rutland@arm.com>
> > Sent: Monday, July 5, 2021 2:38 PM
> > To: Bharat Bhushan <bbhushan2@marvell.com>
> > Cc: catalin.marinas@arm.com; will@kernel.org; daniel.lezcano@linaro.org;
> > maz@kernel.org; konrad.dybcio@somainline.org;
> > saiprakash.ranjan@codeaurora.org; robh@kernel.org; marcan@marcan.st;
> > suzuki.poulose@arm.com; broonie@kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Linu Cherian
> > <lcherian@marvell.com>
> > Subject: [EXT] Re: [PATCH] clocksource: Add Marvell Errata-38627 workaround
> > 
> > External Email
> > 
> > ----------------------------------------------------------------------
> > Hi Bharat,
> > 
> > On Mon, Jul 05, 2021 at 11:38:43AM +0530, Bharat Bhushan wrote:
> > > CPU pipeline have unpredicted behavior when timer interrupt appears
> > > and then disappears prior to the exception happening. Time interrupt
> > > appears on timer expiry and disappears when timer programming or timer
> > > disable. This typically can happen when a load instruction misses in
> > > the cache,  which can take few hundreds of cycles, and an interrupt
> > > appears after the load instruction starts executing but disappears
> > > before the load instruction completes.
> > 
> > Could you elaborate on the scenario? What sort of unpredictable behaviour can
> > occur? e.g:
> 
> This is a race condition where an instruction (except store, system,
> load atomic and load exclusive) becomes "nop" if interrupt appears and
> disappears before taken by CPU. For example interrupt appears after
> the atomic load instruction starts executing and disappears before the
> atomic load instruction completes, in that case instruction (not all)
> can become "nop". As interrupt disappears before atomic instruction
> completes, cpu continues to execute and while take junk from register
> as other dependent got "nop".

Thanks for this; I have a number of further questions below.

You said this doesn't apply to:

* store
* system
* load atomic
* load exclusive

... but your example explains this happening for an atomic load, which
was in that list. Was the example bad, or was the list wrong?

It's not entirely clear to me which instructions this covers. e.g. is
"system" the entire system instruction class (i.e. all opcodes
0b110101010_0xxxxxxx_xxxxxxxx_xxxxxxxx), or did you mean something more
specific? Does "store" include store-exlcusive?

Other than that list, can this occur for *any* instruction? e.g. MOV,
SHA256*, *DIV?

Does this only apply to a single instruction at a time, or can multiple
instructions "become nop"?

When an instruction "becomes nop", will subsequent instructions see a
consistent architectural state (e.g. GPRs as they were exactly before
the instruction which "becomes nop"), or can they see something else
(e.g. garbage forwarded from register renaming or other internal
microarchitectural state)?

> > * Does the CPU lockup?
> No
> 
> > * Does the CPU take the exception at all?
> No
> 
> > * Does the load behave erroneously?
> No,
> 
> > * Does any CPU state (e.g. GPRs, PC, PSTATE) become corrupted?
> 
> yes, GPRs will get corrupted, will have stale value

As above, is that the prior architectural value of the GPRs, or can that
be some bogus microarchitectural state (e.g. from renaming or other
forwarding paths)?

> > Does the problem manifest when IRQs are masked by DAIF.I, or by
> > CNT*_CTL_EL0.{IMASK,ENABLE} ?
> 
> No, there are no issue if interrupts are masked.

If a write to CNTV_CTL_EL0.IMASK races with the interrupt being
asserted, can that trigger the problem?

If a write to DAIF.I races with the interrupt being asserted, can that
trigger the problem?

From your description so far, this doesn't sound like it is specific to
the timer interrupt. Is it possible for a different interrupt to trigger
this, e.g:

* Can the same happen with another PPI, e.g. the PMU interrupt if that
  gets de-asserted, or there's a race with DAIF.I?

* Can the same happen with an SGI, e.g. if one CPU asserts then
  de-asserts an SGI targetting another CPU, or there's a race with
  DAIF.I?

* Can the same happen with an SPI, e.g. if a device asserts then
  de-asserts its IRQ line, or there's a race with DAIF.I?

If not, *why* does this happen specifically for the timer interrupt?

> > > Workaround of this is to ensure maximum 2us of time gap between timer
> > > interrupt and timer programming which can de-assert timer interrupt.
> > 
> > The code below seems to try to enforce a 2us *minimum*. Which is it supposed
> > to be?
> 
> Yes, it is minimum 2us.
> 
> > 
> > Can you explain *why* this is supposed to help?
> With the workaround interrupt assertion and de-assertion will be minimum 2us apart.

I understood that, but why is that deemed to be sufficient? e.g. is it
somehow guaranteed that the CPU will complete the instruction that would
"become nop" in that time?

> > I don't see how we can guarantee this in a VM, or if the CPU misses on an
> > instruction fetch.
> 
> This errata applies to VM (virtual timer) as well, maybe there is some
> gap in my understanding, how it will be different in VM.
> Can you help with what issue we can have VM?

A VCPU can be pre-empted by the host at *any* time, for an arbitrary
length of time. So e.g. you can have a scenario such as:

1. Guest reads CNTx_TVAL, sees interrupt is 4us in the future and
   decides it does not need to wait
2. Host preempts guest
3. Host does some processing for ~3.9us
4. Host returns to guest, with 0.1us left until the interrupt triggers
5. Guest reprograms CNTx_TVAL, and triggers the erratum

Thanks,
Mark.
