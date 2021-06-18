Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871323AC67E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 10:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhFRIvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 04:51:15 -0400
Received: from foss.arm.com ([217.140.110.172]:37218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhFRIvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 04:51:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D1B913D5;
        Fri, 18 Jun 2021 01:49:04 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 658D83F694;
        Fri, 18 Jun 2021 01:48:56 -0700 (PDT)
Date:   Fri, 18 Jun 2021 09:48:47 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, will@kernel.org,
        boqun.feng@gmail.com, peterz@infradead.org, aou@eecs.berkeley.edu,
        arnd@arndb.de, bcain@codeaurora.org, benh@kernel.crashing.org,
        chris@zankel.net, dalias@libc.org, davem@davemloft.net,
        deanbo422@gmail.com, deller@gmx.de, geert@linux-m68k.org,
        gerg@linux-m68k.org, green.hu@gmail.com, guoren@kernel.org,
        ink@jurassic.park.msu.ru, James.Bottomley@HansenPartnership.com,
        jcmvbkbc@gmail.com, jonas@southpole.se, ley.foon.tan@intel.com,
        linux@armlinux.org.uk, mattst88@gmail.com, monstr@monstr.eu,
        mpe@ellerman.id.au, nickhu@andestech.com, palmerdabbelt@google.com,
        paulus@samba.org, paul.walmsley@sifive.com, rth@twiddle.net,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tsbogend@alpha.franken.de, vgupta@synopsys.com,
        ysato@users.sourceforge.jp
Subject: Re: [PATCH v2 00/33] locking/atomic: convert all architectures to
 ARCH_ATOMIC
Message-ID: <20210618084847.GA93984@C02TD0UTHF1T.local>
References: <20210525140232.53872-1-mark.rutland@arm.com>
 <a15122e9-700d-c909-4794-d569ed1f6c61@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a15122e9-700d-c909-4794-d569ed1f6c61@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 10:56:16PM -0700, Randy Dunlap wrote:
> On 5/25/21 7:01 AM, Mark Rutland wrote:
> > This series (based on v5.13-rc2) converts all architectures to
> > ARCH_ATOMIC. This will allow the use of instrumented atomics on all
> > architectures (e.g. for KASAN and similar), and simplifies the core
> > atomic code (which should allow for easier rework of the fallbacks and
> > other bits in future).

[...]

> Hi Mark,
> Sorry for the late reply. 

Hi Randy,

Likewise, apologies in the delay in getting to this!

> I was just trying to update a patch
> to arch/sh/include/asm/cmpxchg.h, in its xchg() macro:
> 
> https://lore.kernel.org/lkml/20210602231443.4670-2-rdunlap@infradead.org/
> 
> The patch simply converts xchg() to a GCC statement expression to
> eliminate a build warning.
> 
> Arnd has done this for m68k and I have done it for sparc in the past.
> 
> Is there any (good) reason that all versions of arch_xchg() are not
> statement expressions?  In this patch series, they seem to be quite
> mixed (as they were before this patch series). I count 11 arches
> that use a statement expression and 4 that do not (including arch/sh/).

Largely I tried to make the minimal change from what was there before,
and I didn't have any specific reason to either use or avoid statement
expressions.

This series has been queued in the tip tree's locking/core branch for a
while now, but we could spin a patch atop. Do you want to spin a patch
to convert the remaining 4 architectures in one go?

Thanks,
Mark.
