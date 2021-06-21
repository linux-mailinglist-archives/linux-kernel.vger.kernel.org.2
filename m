Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548513AE536
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFUIs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:48:59 -0400
Received: from foss.arm.com ([217.140.110.172]:58660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229789AbhFUIs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:48:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E955211D4;
        Mon, 21 Jun 2021 01:46:43 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.12.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E56393F718;
        Mon, 21 Jun 2021 01:46:38 -0700 (PDT)
Date:   Mon, 21 Jun 2021 09:46:35 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
        boqun.feng@gmail.com, bp@alien8.de, catalin.marinas@arm.com,
        dvyukov@google.com, elver@google.com, ink@jurassic.park.msu.ru,
        jonas@southpole.se, juri.lelli@redhat.com, linux@armlinux.org.uk,
        luto@kernel.org, mattst88@gmail.com, mingo@redhat.com,
        monstr@monstr.eu, paulmck@kernel.org, paulus@samba.org,
        peterz@infradead.org, rth@twiddle.net, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        vincent.guittot@linaro.org, will@kernel.org
Subject: Re: [RFC PATCH 09/10] powerpc: snapshot thread flags
Message-ID: <20210621084635.GE37068@C02TD0UTHF1T.local>
References: <20210609122001.18277-1-mark.rutland@arm.com>
 <20210609122001.18277-10-mark.rutland@arm.com>
 <87k0mvtgeb.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0mvtgeb.fsf@mpe.ellerman.id.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 11:18:52PM +1000, Michael Ellerman wrote:
> Mark Rutland <mark.rutland@arm.com> writes:
> > Some thread flags can be set remotely, and so even when IRQs are
> > disabled, the flags can change under our feet. Generally this is
> > unlikely to cause a problem in practice, but it is somewhat unsound, and
> > KCSAN will legitimately warn that there is a data race.
> >
> > To avoid such issues, we should snapshot the flags prior to using them.
> > Let's use the new helpers to do so on powerpc.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Paul Mackerras <paulus@samba.org>
> > ---
> >  arch/powerpc/kernel/interrupt.c     | 16 ++++++++--------
> >  arch/powerpc/kernel/ptrace/ptrace.c |  3 +--
> >  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> This looks good.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> 
> 
> But, it clashes terribly with a series I'm planning to take for v5.14
> that reworks our interrupt return code.
> 
> https://lore.kernel.org/linuxppc-dev/20210610130921.706938-1-npiggin@gmail.com/T/#t
> 
> So if you're also targeting v5.14 then it might be best to drop this
> patch from the series, and we can do the conversion later.

I'll drop this patch for now, and note the clash in the cover letter. It
should be easy enough to respin atop those changes later, and if I don't
get this in for v5.14 I can regenerate it.

Thanks,
Mark.
