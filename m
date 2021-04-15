Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC50360E75
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhDOPPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:15:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235428AbhDOPFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 11:05:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3253A61184;
        Thu, 15 Apr 2021 15:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618499027;
        bh=yZNHh6lqIyXIo/eRzDBVQsl56YMqu4TgjyYs/z4BYI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LaWO3WuxZ0ojYLXgCO2JaeZm5ecSOiWY0BQ2pluDglge5fBzyvC/f3n4hxqT2Bwee
         Oyqb6F1Sq8pB7yDOTqq70rW4e4oEpIXGJ341nLehOB1wg3PF7PRMRPADWhKe7pJlDr
         A9vuSsJAP9GsLCRYQ8y7E+CgNOHaJbo0Xj4oC+94=
Date:   Thu, 15 Apr 2021 16:53:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nils Carlson <nils.carlson@ericsson.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/1] char: hpet: Remove unused local variable 'm' in
 hpet_interrupt()
Message-ID: <YHhTVXS4u5jXG5Fc@kroah.com>
References: <20210415142404.3846-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415142404.3846-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 10:24:04PM +0800, Zhen Lei wrote:
> Commit 273ef9509b79 ("drivers/char/hpet.c: fix periodic-emulation for
> delayed interrupt") removed the reference to local variable 'm', but
> forgot to remove the definition and assignment of it. Due to
> read_counter() indirectly calls "read barrier", the performance is
> slightly degraded.
> 
> Since the following comments give some description based on 'm', so move
> the assignment of 'm' into it.
> 
> Fixes: 273ef9509b79 ("drivers/char/hpet.c: fix periodic-emulation for delayed interrupt")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/char/hpet.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> index ed3b7dab678dbd1..46950a0cda181a1 100644
> --- a/drivers/char/hpet.c
> +++ b/drivers/char/hpet.c
> @@ -156,14 +156,16 @@ static irqreturn_t hpet_interrupt(int irq, void *data)
>  	 * This has the effect of treating non-periodic like periodic.
>  	 */
>  	if ((devp->hd_flags & (HPET_IE | HPET_PERIODIC)) == HPET_IE) {
> -		unsigned long m, t, mc, base, k;
> +		unsigned long t, mc, base, k;
>  		struct hpet __iomem *hpet = devp->hd_hpet;
>  		struct hpets *hpetp = devp->hd_hpets;
>  
>  		t = devp->hd_ireqfreq;
> -		m = read_counter(&devp->hd_timer->hpet_compare);
>  		mc = read_counter(&hpet->hpet_mc);
> -		/* The time for the next interrupt would logically be t + m,
> +		/*
> +		 * m = read_counter(&devp->hd_timer->hpet_compare);

Why did you comment this out?

And are you sure that yuou are not required to actually read that
counter, even if you do not do anything with the value?  Lots of
hardware works in odd ways...

Have you tested and verified that this still works properly?

thanks,

greg k-h
