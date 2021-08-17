Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200643EF171
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhHQSKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:10:01 -0400
Received: from gate.crashing.org ([63.228.1.57]:35155 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233417AbhHQSJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:09:58 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 17HI3p37025443;
        Tue, 17 Aug 2021 13:03:51 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 17HI3o06025440;
        Tue, 17 Aug 2021 13:03:50 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 17 Aug 2021 13:03:50 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, userm57@yahoo.com,
        fthain@linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32s: Fix random crashes by adding isync() after locking/unlocking KUEP
Message-ID: <20210817180350.GH1583@gate.crashing.org>
References: <1d28441dd80845e6428d693c0724cb6457247466.1629211378.git.christophe.leroy@csgroup.eu> <20210817162239.GF1583@gate.crashing.org> <0426a0d3-bdc6-1a34-1018-71b34282a6c6@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0426a0d3-bdc6-1a34-1018-71b34282a6c6@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, Aug 17, 2021 at 07:13:44PM +0200, Christophe Leroy wrote:
> Le 17/08/2021 à 18:22, Segher Boessenkool a écrit :
> >On Tue, Aug 17, 2021 at 02:43:15PM +0000, Christophe Leroy wrote:
> >>Commit b5efec00b671 ("powerpc/32s: Move KUEP locking/unlocking in C")
> >>removed the 'isync' instruction after adding/removing NX bit in user
> >>segments. The reasoning behind this change was that when setting the
> >>NX bit we don't mind it taking effect with delay as the kernel never
> >>executes text from userspace, and when clearing the NX bit this is
> >>to return to userspace and then the 'rfi' should synchronise the
> >>context.
> >>
> >>However, it looks like on book3s/32 having a hash page table, at least
> >>on the G3 processor, we get an unexpected fault from userspace, then
> >>this is followed by something wrong in the verification of MSR_PR
> >>at end of another interrupt.
> >>
> >>This is fixed by adding back the removed isync() following update
> >>of NX bit in user segment registers. Only do it for cores with an
> >>hash table, as 603 cores don't exhibit that problem and the two isync
> >>increase ./null_syscall selftest by 6 cycles on an MPC 832x.
> >>
> >>First problem: unexpected PROTFAULT
> >>
> >>	[   62.896426] WARNING: CPU: 0 PID: 1660 at 
> >>	arch/powerpc/mm/fault.c:354 do_page_fault+0x6c/0x5b0
> >>	[   62.918111] Modules linked in:
> >>	[   62.923350] CPU: 0 PID: 1660 Comm: Xorg Not tainted 
> >>	5.13.0-pmac-00028-gb3c15b60339a #40
> >>	[   62.943476] NIP:  c001b5c8 LR: c001b6f8 CTR: 00000000
> >>	[   62.954714] REGS: e2d09e40 TRAP: 0700   Not tainted  
> >>	(5.13.0-pmac-00028-gb3c15b60339a)
> >
> >That is not a protection fault.  What causes this?
> 
> That's the WARN_ON(error_code & DSISR_PROTFAULT) at
> 
> https://elixir.bootlin.com/linux/v5.13/source/arch/powerpc/mm/fault.c#L354

Ah okay.  How confusing :-/

> >A CSI (like isync) is required both before and after mtsr.  It may work
> >on some cores without -- what part of that is luck, if there is anything
> >that guarantees it, is anyone's guess :-/
> 
> kuep_lock() is called when entering interrupts, it means we recently got an 
> 'rfi' to re-enable MMU.
> kuep_unlock() is called when exit interrupts, it means we are soon going to 
> call 'rfi' to go back to user.
> 
> In between, nobody is going to exec any userspace code, so who minds that 
> the 'mtsr' changing user segments is not completely finished ?

Hey, that is my question!  :-)

So why does this not work on 750 then?

> >>@@ -28,6 +30,8 @@ static inline void kuep_lock(void)
> >>  		return;
> >>  
> >>  	update_user_segments(mfsr(0) | SR_NX);
> >>+	if (mmu_has_feature(MMU_FTR_HPTE_TABLE))
> >>+		isync();	/* Context sync required after mtsr() */
> >>  }
> >
> >This needs a comment why you are not doing this for systems without
> >hardware page table walk, at the least?
> 
> Ok, will add a comment tomorrow.

Thanks!


Segher
