Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F90393629
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbhE0TU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:20:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhE0TU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:20:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5323B6135F;
        Thu, 27 May 2021 19:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622143163;
        bh=+vbV7Wlrg9i5mBOWz4pLtwWeERGO+knXdQnr6MM2iyk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cen0W70oBgszAWFzIszNT+yWCujBCnnwXMKxCjfBsJgPLlw+K6OkLzUqog86n7/DF
         jKg1Jc742vT300GHdkVzxYn6BpJONq8nH0PW8HtZBMAdxsyhNsSHzggu2aLOM1p4wL
         /zhdFHO49zUDnylR0tCf0hQQPcNQHGCBocGWC6ANylP3tUb5bad7oNfpI36dOXcy96
         tqKIYSu0oQrju97KiLMpfTfbQH5Jdw4/RazEbso/e/qXFDhNcza53XXvF2DFEDFTiV
         /1zRWM1K3o7kngXuZDnSaJVQVrP2LUb3BHtsKpSSvs+7+RncR0WF/Bkyl9a4IzEoeP
         2EFDSQMZeMnmw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 175705C032C; Thu, 27 May 2021 12:19:23 -0700 (PDT)
Date:   Thu, 27 May 2021 12:19:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Feng Tang <feng.tang@intel.com>,
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
Message-ID: <20210527191923.GD4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210521083322.GG25531@xsang-OptiPlex-9020>
 <20210521135617.GT4441@paulmck-ThinkPad-P17-Gen-1>
 <20210522160827.GA2625834@paulmck-ThinkPad-P17-Gen-1>
 <20210526064922.GD5262@shbuild999.sh.intel.com>
 <20210526134911.GB4441@paulmck-ThinkPad-P17-Gen-1>
 <20210527182959.GA437082@paulmck-ThinkPad-P17-Gen-1>
 <138f81df-08e1-f96e-1915-c58b44f96a41@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <138f81df-08e1-f96e-1915-c58b44f96a41@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 12:01:23PM -0700, Andi Kleen wrote:
> 
> >      Nevertheless, it is quite possible that real-world use will result in
> >      some situation requiring that high-stress workloads run on hardware
> >      not designed to accommodate them, and also requiring that the kernel
> >      refrain from marking clocksources unstable.
> >      Therefore, provide an out-of-tree patch that reacts to this situation
> 
> out-of-tree means it will not be submitted?
> 
> I think it would make sense upstream, but perhaps guarded with some option.

The reason I do not intend to immediately upstream this patch is that
it increases the probability that a real clocksource read-latency issue
will be ignored, for example, during hardware bringup.  Furthermore,
the only known need from it comes from hardware that is, in the words
of the stress-ng man page, "poorly designed".  And the timing of this
email thread leads me to believe that such hardware is not easy to obtain.

Adding an option would increase complexity, but I agree that such an
option would address some of the patch's downsides.  On the other hand,
there has been some pushback to such options.

My thought is therefore to keep this patch out of tree for now.
If it becomes clear that long-latency clocksource reads really are
a significant issue in their own right (as opposed to merely being a
symptom of a hardware or firmware bug), then this patch is available to
immediately respond to that issue.

And there would then be strong evidence in favor of me biting the bullet,
adding the complexity and the additional option (with your Suggested-by),
and getting that upstream and into -stable.

Seem reasonable?

							Thanx, Paul
