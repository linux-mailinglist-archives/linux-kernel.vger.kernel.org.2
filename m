Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFB8393641
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbhE0Tbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhE0Tbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:31:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1C8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OmpHNr4TAP41rJ2r2wggyNBZl+LhZ+GtvDxjkk/dx1o=; b=vzGfouo5ojxroNYcpHA0i7jS7G
        ewKzzmf2ehPIB8v3KD52FK+eFXvJVkit+agK8EcnuYjjOO9cZptqgt7/O4dlaXv0umNbFS9peuINi
        wu7mqCXzhwqCzvfBtMNc8Anwb9BesjlGb8Q7VS47lvFKrgH+ZM4GKJW5ZdfpozNTeMN1Hym6m9LL8
        XXsm60i4YupzGbEi9I2SV3UZ3J0eai2uvrpQO+qG9u0XIIBdudx2S7k4KKpZo8go+ZdN1ip9b3gM2
        FCFKCzX7iIJs6cyj9kFMa6rRl1kP0p+5Y0MqS5yhclRgczB+FOn1OtfpDQdyf0e9Lc4G8DcaQtBhe
        RYdZKmyA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lmLhE-005r04-Bi; Thu, 27 May 2021 19:29:34 +0000
Date:   Thu, 27 May 2021 20:29:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Chris Mason <clm@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [clocksource] 8901ecc231: stress-ng.lockbus.ops_per_sec -9.5%
 regression
Message-ID: <YK/zHMPSZSKrmXC6@casper.infradead.org>
References: <20210521083322.GG25531@xsang-OptiPlex-9020>
 <20210521135617.GT4441@paulmck-ThinkPad-P17-Gen-1>
 <20210522160827.GA2625834@paulmck-ThinkPad-P17-Gen-1>
 <20210526064922.GD5262@shbuild999.sh.intel.com>
 <20210526134911.GB4441@paulmck-ThinkPad-P17-Gen-1>
 <20210527182959.GA437082@paulmck-ThinkPad-P17-Gen-1>
 <138f81df-08e1-f96e-1915-c58b44f96a41@linux.intel.com>
 <20210527191923.GD4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527191923.GD4397@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 12:19:23PM -0700, Paul E. McKenney wrote:
> On Thu, May 27, 2021 at 12:01:23PM -0700, Andi Kleen wrote:
> > 
> > >      Nevertheless, it is quite possible that real-world use will result in
> > >      some situation requiring that high-stress workloads run on hardware
> > >      not designed to accommodate them, and also requiring that the kernel
> > >      refrain from marking clocksources unstable.
> > >      Therefore, provide an out-of-tree patch that reacts to this situation
> > 
> > out-of-tree means it will not be submitted?
> > 
> > I think it would make sense upstream, but perhaps guarded with some option.
> 
> The reason I do not intend to immediately upstream this patch is that
> it increases the probability that a real clocksource read-latency issue
> will be ignored, for example, during hardware bringup.  Furthermore,
> the only known need from it comes from hardware that is, in the words
> of the stress-ng man page, "poorly designed".  And the timing of this
> email thread leads me to believe that such hardware is not easy to obtain.

I think you're placing a little too much weight on the documentation
here.  It seems that a continuous stream of locked operations executed
in userspace on a single CPU can cause this problem to occur.  If that's
true all the way out to one guest in a hypervisor can cause problems
for the hypervisor itself, I think cloud providers everywhere are
going to want this patch?

> My thought is therefore to keep this patch out of tree for now.
> If it becomes clear that long-latency clocksource reads really are
> a significant issue in their own right (as opposed to merely being a
> symptom of a hardware or firmware bug), then this patch is available to
> immediately respond to that issue.
> 
> And there would then be strong evidence in favor of me biting the bullet,
> adding the complexity and the additional option (with your Suggested-by),
> and getting that upstream and into -stable.
> 
> Seem reasonable?
> 
> 							Thanx, Paul
> 
