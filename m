Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA09135B0DB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 02:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbhDKAWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 20:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234680AbhDKAWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 20:22:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73FC16101D;
        Sun, 11 Apr 2021 00:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618100506;
        bh=zo7E/Ixz9o1yVq9SO812GjKzAtwqAZkTFGeSQE54NfA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VhtZIJmul2m8IH7QFtzQmBDJj11ghSjjckeWUJKFy9O76/tLuLp1gyHkCcV902ofY
         Ku2iZKXeNqFQhNJRSotsLpO3u+AMwXeK+/QiLjQjkzr2FYn03+lALEIfQ5Pd0oc0eK
         jMdMnD87i8A5djg5WKJJQ1AEBU6YtbLb1oLsMos0KxRIQNAZxKdbfL0mhy+goLcZCe
         ckdsrc3HGnO+7EZ+dI+Tij0JHly83ZMf/5iu1HNyRrhTvh8AIavS29o9JlVKqjsZRD
         HlYxGtZFwreN1goV0dxToU/gAv2sJN0dzSrguEYUTQVTCgE2922B84/TQaXjMzXafi
         VOPs/A0bCX/Nw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3FB5B5C0C5F; Sat, 10 Apr 2021 17:21:46 -0700 (PDT)
Date:   Sat, 10 Apr 2021 17:21:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: Re: [PATCH v7 clocksource 5/5] clocksource: Do pairwise
 clock-desynchronization checking
Message-ID: <20210411002146.GW4510@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210402224828.GA3683@paulmck-ThinkPad-P72>
 <20210402224906.3912-5-paulmck@kernel.org>
 <878s5q4iix.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s5q4iix.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 11:04:54AM +0200, Thomas Gleixner wrote:
> On Fri, Apr 02 2021 at 15:49, paulmck wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> >
> > Although smp_call_function() has the advantage of simplicity, using
> > it to check for cross-CPU clock desynchronization means that any CPU
> > being slow reduces the sensitivity of the checking across all CPUs.
> > And it is not uncommon for smp_call_function() latencies to be in the
> > hundreds of microseconds.
> >
> > This commit therefore switches to smp_call_function_single(), so that
> > delays from a given CPU affect only those measurements involving that
> > particular CPU.
> 
> Is there any reason I'm missing why this is not done right in patch 3/5
> which introduces this synchronization check?

None at all.  I will merge this into 3/5.

							Thanx, Paul
