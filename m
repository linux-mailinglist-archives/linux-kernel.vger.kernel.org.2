Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3AA3E1812
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238390AbhHEPdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:33:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhHEPdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:33:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55A9960EE8;
        Thu,  5 Aug 2021 15:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628177590;
        bh=KCw/HboD352KeqrLkTM/GnuIXejBTJnkUaCOM1fsses=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ENULft1j+sRlwYRV3nUNOTZxyyKS2cLJH+rSilFUJbM8uehCsQPCsbJyqcZa7Du+d
         WydicoEL7ihW+8pqqklPoDcutb2fBSCtYPW0AT3PLZkPv/ig9s78y+yVXhsPQgzeZO
         ViX28Azl5Z3w6iqr3jSe9GJkO6WJlZlH+EyjKeVDYh9xmjGub2+yvixEMJbvRIgEJc
         pr8dQUhPBbp6M6u/4sRJ/KcYdkq7jPq2C+/H9YphVULRYaEXTKRrbxlZDCOsMnuRNk
         tOtZnfNd3FK8HTJRyUrJfnaqf6EJRtlbpdeUBzjVoqwMDSlqM6uygStNH5ZzqY4Cmv
         m4h8sDMzOlJdw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 274B45C098A; Thu,  5 Aug 2021 08:33:10 -0700 (PDT)
Date:   Thu, 5 Aug 2021 08:33:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Chao Gao <chao.gao@intel.com>, Feng Tang <feng.tang@intel.com>,
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
Message-ID: <20210805153310.GF4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210526064922.GD5262@shbuild999.sh.intel.com>
 <20210526134911.GB4441@paulmck-ThinkPad-P17-Gen-1>
 <20210527182959.GA437082@paulmck-ThinkPad-P17-Gen-1>
 <20210802062008.GA24720@gao-cwp>
 <20210802170257.GL4397@paulmck-ThinkPad-P17-Gen-1>
 <20210803085759.GA31621@gao-cwp>
 <20210803134816.GO4397@paulmck-ThinkPad-P17-Gen-1>
 <20210805021646.GA11629@gao-cwp>
 <20210805040349.GD4397@paulmck-ThinkPad-P17-Gen-1>
 <a8d99be8-da3f-6c8e-cdbb-efd239ff3f14@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8d99be8-da3f-6c8e-cdbb-efd239ff3f14@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 09:34:13PM -0700, Andi Kleen wrote:
> 
> > My current thought is that if more than (say) 100 consecutive attempts
> > to read the clocksource get hit with excessive delays, it is time to at
> > least do a WARN_ON(), and maybe also time to disable the clocksource
> > due to skew.  The reason is that if reading the clocksource -always-
> > sees excessive delays, perhaps the clock driver or hardware is to blame.
> > 
> > Thoughts?
> 
> On TDX this would be fatal because we don't have a usable fallback source
> 
> (just jiffies). Better try as hard as possible.

At some point, won't the system's suffering in silence become quite the
disservice to its users?

One alternative would be to give a warning splat, but avoid reporting
skew.  Unless there is the traditional 62.5ms of skew, of course.

							Thanx, Paul
