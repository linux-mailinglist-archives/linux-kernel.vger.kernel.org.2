Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB8735312F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 00:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbhDBWhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 18:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhDBWhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 18:37:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FB3761167;
        Fri,  2 Apr 2021 22:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617403040;
        bh=43dxMfdYr7Xqb932tHKUvTmP+2IIFuEen6wvCq2Emso=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=K4sqLgFh4jMtelJyXFNkIja8D9cRwPUDtCIj3H2BWurlGNzfAniahoSDPz2xDdM/+
         S32CVGeq3/XfGQJdgl1WgrbtVnnioANWJQ3L0p7FEW90p6pwr9rmtS9+w0tpmeG8r1
         wcFtIQKtsrmiXmOfU5+85vuxCdm8hfkkJyF+Yr4icTtRjUaLS/2NgCQ5rTjan4uW0m
         F+usRi8GHnCojHJ2O89+sPBNZdUrL6xcUEemSauyGPWgXTPgOblL5JpuJQGh8jiGyC
         nYP3qQpOxntgkTn27kZiQk+yBG2pvwgAXwUoVPxmaczE4zZ0OM3E9cmngmKq5CjOgV
         Gwnc9f1DWdU1w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D180835212A5; Fri,  2 Apr 2021 15:37:19 -0700 (PDT)
Date:   Fri, 2 Apr 2021 15:37:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: Re: [PATCH v6 clocksource] Do not mark clocks unstable
 dueclocksource: Provide module parameters to inject delays in watchdog
Message-ID: <20210402223719.GV2696@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210402202929.GA22273@paulmck-ThinkPad-P72>
 <20210402203137.22479-1-paulmck@kernel.org>
 <87pmzc498v.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmzc498v.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2021 at 12:22:40AM +0200, Thomas Gleixner wrote:
> On Fri, Apr 02 2021 at 13:31, paulmck wrote:
> 
> The subsystem prefix does not parse:
> 
>     [PATCH v6 clocksource] Do not mark clocks unstable dueclocksource: Provide module parameters to inject delays in watchdog

Where is that brown bag when I need it?  :-/

> I look at the actual code changes after the easter break.

I will resend a clean copy as a reply to your message.

							Thanx, Paul
