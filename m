Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA053A2F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhFJPa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:30:59 -0400
Received: from foss.arm.com ([217.140.110.172]:34570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231423AbhFJPa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:30:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51706106F;
        Thu, 10 Jun 2021 08:29:01 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3449F3F719;
        Thu, 10 Jun 2021 08:29:00 -0700 (PDT)
Date:   Thu, 10 Jun 2021 16:28:57 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Beata Michalska <beata.michalska@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: iowait boost is broken
Message-ID: <20210610152857.lqtu2xl3364l6fyh@e107158-lin.cambridge.arm.com>
References: <CAEXW_YTcO=hbmdq3nOx2RJfT2yPyoFnQx5niB38R2Lzpsp38bA@mail.gmail.com>
 <20210607191031.GA12489@e120325.cambridge.arm.com>
 <YL+tDv/EL5ogf/0w@hirez.programming.kicks-ass.net>
 <YMCOyL8eiu9UpnEz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMCOyL8eiu9UpnEz@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/21 09:50, Quentin Perret wrote:
> On Tuesday 08 Jun 2021 at 19:46:54 (+0200), Peter Zijlstra wrote:
> > On Mon, Jun 07, 2021 at 08:10:32PM +0100, Beata Michalska wrote:
> > > So back to the expectations.
> > > The main problem, as I see it, is what do we actually want to achieve with
> > > the I/O boosting? Is it supposed to compensate the time lost while waiting
> > > for the I/O request to be completed or is is supposed to optimize the rate
> > > at which I/O requests are being made. 
> > 
> > The latter, you want to increase the race of submission.
> > 
> > > Do we want to boost I/O bound tasks by
> > > default, no limits applied  or should we care about balancing performance
> > > vs power ? And unless those expectations are clearly stated, we might not
> > > get too far with any changes, really.
> > 
> > You want to not increase power beyond what is needed to match the rate
> > of processing I suppose.
> 
> Note that in some cases we also don't care about throughput, and would
> prefer to keep the frequency for some unimportant IO bound tasks (e.g.
> background logging deamons and such). Uclamp.max indicates this to some
> extent.

In theory, one can have a user space daemon that monitors IO (via BPF?) and
auto boost via uclamp. You can have allow/disallow list per-app too to setup
the limits.

So I say rm -rf iowait_boost and let's make it a user space problem :)

/me runs

--
Qais Yousef
