Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A165136B74B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbhDZQ4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:56:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233736AbhDZQ4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:56:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F065961076;
        Mon, 26 Apr 2021 16:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619456137;
        bh=K8s2HR2UdDqXVvoQjGH6zirtLDDVxviKtltWnei6bNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wr5110SEyhbwJHa7bvzB/A1tCbCapnx8RlAEka1r87GwMue32H9kwBpLhLD1003IC
         W6lES/hT8xQhZ7OAR4kkTgZ76bjf2zuwXOhhxXXHyQFmtQqHUoe0+dTx4K0g0Jo4fw
         Grmdi15dN8Zu8v32uhbb/TllmUDzVfTVyKviTVM0=
Date:   Mon, 26 Apr 2021 18:55:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Aditya Pakki <pakki001@umn.edu>, kjlu@umn.edu,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>,
        Nicolai Stange <nstange@suse.de>,
        Roland Dreier <roland@purestorage.com>
Subject: Re: [PATCH 113/190] Revert "x86/hpet: Prevent potential NULL pointer
 dereference"
Message-ID: <YIbwhpNDx1KjVbLe@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-114-gregkh@linuxfoundation.org>
 <202104211245.F5FEC8D15D@keescook>
 <87im4dx5cc.ffs@nanos.tec.linutronix.de>
 <202104230201.EEB997CD8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104230201.EEB997CD8@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 02:03:50AM -0700, Kees Cook wrote:
> On Fri, Apr 23, 2021 at 01:33:07AM +0200, Thomas Gleixner wrote:
> > On Wed, Apr 21 2021 at 12:49, Kees Cook wrote:
> > > On Wed, Apr 21, 2021 at 02:59:48PM +0200, Greg Kroah-Hartman wrote:
> > >> diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
> > >> index 08651a4e6aa0..0515a97bf6f5 100644
> > >> --- a/arch/x86/kernel/hpet.c
> > >> +++ b/arch/x86/kernel/hpet.c
> > >> @@ -930,8 +930,6 @@ int __init hpet_enable(void)
> > >>  		return 0;
> > >>  
> > >>  	hpet_set_mapping();
> > >> -	if (!hpet_virt_address)
> > >> -		return 0;
> > >>  
> > >>  	/* Validate that the config register is working */
> > >>  	if (!hpet_cfg_working())
> > >
> > > FWIW, this patch looks harmless. It is checking for a failure in
> > > hpet_set_mapping(), and avoids the following code from performing
> > > 0-offset reads. hpet_set_mapping() is likely to never fail in real-world
> > > situations. *shrug*
> > 
> > 'likely never to fail' is clearly a receipe for disaster and you should
> > know that.
> 
> Of course -- I prefer to keep the sanity check. It just wasn't as good
> as it could have been: it's not clear just by looking at the patch how
> hpet_virt_address and hpet_set_mapping() are related.
> 
> > 
> > > I think it would make more sense for the check to live in
> > > hpet_cfg_working(), though.
> > 
> > No. That does not make any sense at all.
> > 
> > The proper change would have been to make hpet_set_mapping() return
> > an error/success code and act on that.
> > 
> > But that does _NOT_ make the patch invalid.
> > 
> > I'm pretty sure that I looked at it and thought about the proper
> > solution (see above) and then shrugged it off because of overload...
> 
> Right, no, I was saying the original patch should stay. It shouldn't be
> reverted.
> 
> Greg, please drop this patch from the revert list.

Now dropped, thanks for the review.

greg k-h
