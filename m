Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D973236B5C4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 17:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbhDZP2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 11:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233674AbhDZP2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:28:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C6EB61076;
        Mon, 26 Apr 2021 15:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619450882;
        bh=AwhTbcawstyLCkCKuD8TwEtnhQvod3F3gZm+IW/Bb6I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dRmOo9ZVfxCtmfBY5Durmki5k7x6WWssiMaFS3cJxfhed9VJTllzhWaHAb5tArLjT
         x/Vk2e1SXMq734AzV8ResxZtLdhvYHSvEqXcm7Mevh3lsx7pOEV6aNFWjidjF9SZ3w
         yskZeVInlhAS2UbE1gcnSNHwRW+CsaEcoz2OFxT1dY4KlgYc4n6dw/jqltMGPsXNJN
         VFX4UNzPOlrNxBPZLQYTmQWopzS1H3KWlY7lK9DTs/BsK5aQY49DvUulM7SPqHxV8q
         pVal0imAxPwzOXKS3aSNln4VeOlEPi9Bgf0ta60E5acV6zpnuxlmE2zU9Uyj8K4F44
         PcibNCL8XYtRw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D36E85C0121; Mon, 26 Apr 2021 08:28:01 -0700 (PDT)
Date:   Mon, 26 Apr 2021 08:28:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@fb.com,
        neeraju@codeaurora.org, feng.tang@intel.com,
        zhengjun.xing@intel.com, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v10 clocksource 1/7] clocksource: Provide module
 parameters to inject delays in watchdog
Message-ID: <20210426152801.GY975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1>
 <20210425224709.1312655-1-paulmck@kernel.org>
 <20210426040736.GS1401198@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426040736.GS1401198@tassilo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 09:07:36PM -0700, Andi Kleen wrote:

[ . . . ]

> > +	clocksource.inject_delay_period= [KNL]
> > +			Number of calls to clocksource_watchdog() before
> > +			delays are injected between reads from the
> > +			two clocksources.  Values of zero disable this
> > +			delay injection.  These delays can cause clocks
> > +			to be marked unstable, so use of this parameter
> > +			should therefore be avoided on production systems.
> > +			Defaults to zero (disabled).
> > +
> > +	clocksource.inject_delay_repeat= [KNL]
> > +			Number of repeated clocksource_watchdog() delay
> > +			injections per period.	If inject_delay_period
> > +			is five and inject_delay_repeat is three, there
> > +			will be five delay-free reads followed by three
> > +			delayed reads.
> 
> I'm not sure command line options are the right way to do this.
> How about integrating it with the fault injection framework in debugfs.
> 
> This way syzkaller etc. can play with it, which long term would
> give much better test coverage.
> 
> This wouldn't allow boot time coverage, but presumably that's not
> too important here.

Boot-time coverage is important, as we saw in kbuild test robot testing
of v9 of this patchset, which triggered clocksource_tsc_early, but not
clocksource_tsc.  Note that v10 avoids this triggering.

							Thanx, Paul
