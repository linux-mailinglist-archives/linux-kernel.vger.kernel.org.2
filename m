Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C90A358AB6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhDHREM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230522AbhDHREK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:04:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13FD2608FC;
        Thu,  8 Apr 2021 17:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617901439;
        bh=hnG61I8MApYNUUSFh/GpmupU2Ke6cKDab8yjo+IYME8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WS0PzOmeqqSFDSK5j3d4hFKlmKlOXxieqq/M/mDx0d3bYwtDKJyj6PXNnH3H0Xa2i
         D0nPT1Ioy4+nMNvRn0x8iY9GkGApIlrMIVVr+W4mXibIUZL9//Lkl9Zi1AFdNBv85m
         TwNyPzitrhCRE+vbXw+Ii7p+h9GDObmNHRgh/gHzrcU4tSxujw2/c981BFBbgyj54X
         L8C/vMabewVDuF9TRC3cXXOrdYVGs5zYl0nfpQtv9p+CY9ztrvMMKU/6xuNoRt1qD6
         dApImahBT1PDWyTH3ZZTLb5VidrAq+DENKq1zEEgW0zzxpLbj9cls3ofO5cZADVz4b
         Mq4F6YV7gb5jQ==
Date:   Thu, 8 Apr 2021 18:03:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] arm64: mte: Move MTE TCF0 check in entry-common
Message-ID: <20210408170354.GB18321@willie-the-truck>
References: <20210408143723.13024-1-vincenzo.frascino@arm.com>
 <20210408145604.GB18211@willie-the-truck>
 <20210408150612.GA37165@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408150612.GA37165@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 04:06:23PM +0100, Mark Rutland wrote:
> On Thu, Apr 08, 2021 at 03:56:04PM +0100, Will Deacon wrote:
> > On Thu, Apr 08, 2021 at 03:37:23PM +0100, Vincenzo Frascino wrote:
> > > diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> > > index 9d3588450473..837d3624a1d5 100644
> > > --- a/arch/arm64/kernel/entry-common.c
> > > +++ b/arch/arm64/kernel/entry-common.c
> > > @@ -289,10 +289,16 @@ asmlinkage void noinstr enter_from_user_mode(void)
> > >  	CT_WARN_ON(ct_state() != CONTEXT_USER);
> > >  	user_exit_irqoff();
> > >  	trace_hardirqs_off_finish();
> > > +
> > > +	/* Check for asynchronous tag check faults in user space */
> > > +	check_mte_async_tcf0();
> > >  }
> > 
> > Is enter_from_user_mode() always called when we enter the kernel from EL0?
> > afaict, some paths (e.g. el0_irq()) only end up calling it if
> > CONTEXT_TRACKING or TRACE_IRQFLAGS are enabled.
> 
> Currently everything that's in {enter,exit}_from_user_mode() only
> matters when either CONTEXT_TRACKING or TRACE_IRQFLAGS is selected (and
> expands to an empty stub otherwise).
> 
> We could drop the ifdeffery in user_{enter,exit}_irqoff() to have them
> called regardless, or add CONFIG_MTE to the list.

I'm always in favour of dropping ifdeffery if it's getting in the way.

> > >  asmlinkage void noinstr exit_to_user_mode(void)
> > >  {
> > > +	/* Ignore asynchronous tag check faults in the uaccess routines */
> > > +	clear_mte_async_tcf0();
> > > +
> > 
> > and this one seems to be called even less often.
> 
> This is always done in ret_to_user, so (modulo ifdeferry above) all
> returns to EL0 call this.

Right, I was just saying that if you disabled those CONFIG options then this
isn't called _at all_ whereas I think enter_from_user_mode() still is on
some paths.

Will
