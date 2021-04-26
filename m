Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AA436B68B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhDZQPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233736AbhDZQPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:15:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9854E61158;
        Mon, 26 Apr 2021 16:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619453665;
        bh=+xeH23F0LE10Sm4HM5AJUDBLOGxtR3c+xAcE/Eoah6A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=m4u2GksTqGVmk3gn47Y4HlPGnGwUwS3hYSKfXjLx7gcf8hWeRaqzW3dnjG+t5Hggk
         IZb3baUpSGWyDhP8Mgb69yFsG/ec2P0pOPvmH5xoYsoM+U2BuIDqfuk3Pf4YHgbJDh
         a4Vcctg/eUixCLLKRyAJbk+YSr2NI5HIsLKkR4trn5N2U30p4EO9wwFOgI5SK8Lj0X
         Ma7tfWfEwUBKtthat+RdL/mZd18Eob0Qwcb6umhBQqWTv5FlebxLy5pPr9JIGaxRCC
         fxhdzOVTIKFn0mwluZMGrpPph+L5vCOrz3Pzrc2XAuGs1kCZme+glEQrhVR+e9/dhI
         w7eJMbetwe0+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 438AA5C0191; Mon, 26 Apr 2021 09:14:25 -0700 (PDT)
Date:   Mon, 26 Apr 2021 09:14:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@fb.com,
        neeraju@codeaurora.org, feng.tang@intel.com,
        zhengjun.xing@intel.com, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v10 clocksource 1/7] clocksource: Provide module
 parameters to inject delays in watchdog
Message-ID: <20210426161425.GC975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1>
 <20210425224709.1312655-1-paulmck@kernel.org>
 <20210426040736.GS1401198@tassilo.jf.intel.com>
 <20210426152801.GY975577@paulmck-ThinkPad-P17-Gen-1>
 <20210426160008.GY1401198@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426160008.GY1401198@tassilo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 09:00:08AM -0700, Andi Kleen wrote:
> > Boot-time coverage is important, as we saw in kbuild test robot testing
> > of v9 of this patchset, which triggered clocksource_tsc_early, but not
> > clocksource_tsc.  Note that v10 avoids this triggering.
> 
> Not sure how that could happen, I didn't think the kbuild bot knows
> how to set these options.

It didn't need to.  My initial choice of maximum skew in the v9 patch
series exceeded what clocksource_tsc_early could remain within, given its
quick calibration.  In v10 of this patch series, clocksource_tsc_early
is given special dispensation.

> Overall I think you should follow the existing frame works instead
> of inventing your own so that things can be later tested in an
> uniform manner.
> 
> Perhaps the fault injection framework needs boot options, but
> they should be generic.

From Documentation/fault-injection/fault-injection.rst:

------------------------------------------------------------------------

- module parameters

  If the scope of the fault injection capability is limited to a
  single kernel module, it is better to provide module parameters to
  configure the fault attributes.

------------------------------------------------------------------------

And in this case, the fault injection capability is in fact limited to
kernel/clocksource.c.

							Thanx, Paul
