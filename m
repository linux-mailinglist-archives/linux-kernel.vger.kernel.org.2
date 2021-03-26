Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2498434A942
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhCZOI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhCZOIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:08:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF36BC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UWE8oxlnB4iQrlQemqzlD0fNPSrruUTFVdn7Pmo2P3E=; b=rt/QglS8g1nzit2VZxkl+bj6Zh
        OalzfcEu7kCaWCavIbV6XvU2/SKeOv/C2qnd1/seeFq96GDSoxl3I1Ye3kWDqqvnS8DX/3AIdrrnT
        Hi9yC3GVLkeDVtd3Nx8UVmm+VaGKBRhxbip6DbNLaBrvj6o4nv1F77mzEcT7RqU3fwblGuTfNEIYt
        4bAbJroB9kRfHugdRp4H2e8FyhMRx/az5wiqkZyH5DodSmKvdwW55ggjO03IcIRN9w/P3wG7cFlfL
        FEASj0z0xiPYtxy/BI6aNapJnt3Pn6dFyynpH9voyI1Pbrhip+D+Lh5XofbeAEGEs0EUTv7WmDtKS
        kWUsg3tg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPn7E-00EvXo-3m; Fri, 26 Mar 2021 14:07:12 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E60E498103F; Fri, 26 Mar 2021 15:07:06 +0100 (CET)
Date:   Fri, 26 Mar 2021 15:07:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, bristot@redhat.com, joshdon@google.com,
        valentin.schneider@arm.com, linux-kernel@vger.kernel.org,
        greg@kroah.com
Subject: Re: [PATCH 9/9] sched,fair: Alternative sched_slice()
Message-ID: <20210326140706.GH4746@worktop.programming.kicks-ass.net>
References: <20210326103352.603456266@infradead.org>
 <20210326103935.444833549@infradead.org>
 <6c36c39a-d2da-a110-3f83-fda70a73a1fd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c36c39a-d2da-a110-3f83-fda70a73a1fd@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 01:08:44PM +0100, Dietmar Eggemann wrote:
> On 26/03/2021 11:34, Peter Zijlstra wrote:
> > The current sched_slice() seems to have issues; there's two possible
> > things that could be improved:
> > 
> >  - the 'nr_running' used for __sched_period() is daft when cgroups are
> >    considered. Using the RQ wide h_nr_running seems like a much more
> >    consistent number.
> > 
> >  - (esp) cgroups can slice it real fine, which makes for easy
> >    over-scheduling, ensure min_gran is what the name says.
> 
> So ALT_PERIOD considers all runnable CFS tasks now and BASE_SLICE
> guarantees min_gran as a floor for cgroup (hierarchies) with small
> weight value(s)?

Pretty much.

The previous cfs_rq->nr_running is just how many runnable thingies there
are in whatever cgroup you happen to be in on our CPU, not counting its
child cgroups nor whatever is upwards. Which is a pretty arbitrary
value.

By always using h_nr_running of the root, we get a consistent number and
the period is the same for all tasks on the CPU.

And yes, low weight cgroups, or even just a nice -20 and 19 task
together would result in *tiny* slices, which then leads to
over-scheduling. So by only scaling the part between period and
min_gran, we still get a variable slice, but also avoid the worst cases.

