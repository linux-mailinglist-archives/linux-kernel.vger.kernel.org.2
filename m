Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7E04401A9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 20:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJ2SJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 14:09:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhJ2SI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 14:08:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1518860FC3;
        Fri, 29 Oct 2021 18:06:26 +0000 (UTC)
Date:   Fri, 29 Oct 2021 19:06:23 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] arm64: export this_cpu_has_cap
Message-ID: <YXw4H2BNx85KnLDh@arm.com>
References: <20211029113023.760421-1-arnd@kernel.org>
 <9d4e09b4-47dc-ed3c-2b6d-e0d1a081e592@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d4e09b4-47dc-ed3c-2b6d-e0d1a081e592@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 02:31:23PM +0100, Suzuki K Poulose wrote:
> On 29/10/2021 12:30, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > It's now used in a coresight driver that can be a loadable module:
> > 
> > ERROR: modpost: "this_cpu_has_cap" [drivers/hwtracing/coresight/coresight-trbe.ko] undefined!
> > 
> > Fixes: 8a1065127d95 ("coresight: trbe: Add infrastructure for Errata handling")
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Will, Catalin, Mathieu,
> 
> Do you have a preference on how this fix can be pulled in ? This may
> be safe to go via coresight tree if it is not too late. Otherwise,
> it could go via the arm64 tree.

I think Will already closed/tagged the arm64 tree for the upcoming
merging window, though he could take it as a fix afterwards.

If it doesn't conflict with the arm64 for-next/core, it's fine by me to
go through the coresight tree.

> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > Not sure if we actually want this to be exported, this is my local
> > workaround for the randconfig build bot.
> > ---
> >   arch/arm64/kernel/cpufeature.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index ecbdff795f5e..beccbcfa7391 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -2864,6 +2864,7 @@ bool this_cpu_has_cap(unsigned int n)
> >   	return false;
> >   }
> > +EXPORT_SYMBOL(this_cpu_has_cap);

EXPORT_SYMBOL_GPL? I think this_cpu_has_cap() is a bit more more
specialised than cpus_have_const_cap().

With that:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
