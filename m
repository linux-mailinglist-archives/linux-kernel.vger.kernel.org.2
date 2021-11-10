Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08DD44BE1A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 10:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhKJJzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 04:55:42 -0500
Received: from out0.migadu.com ([94.23.1.103]:17010 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhKJJzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 04:55:40 -0500
Date:   Wed, 10 Nov 2021 17:53:27 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1636537969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZUAU49u0de/GblU7PLi+j9y9Qvhf4Zz1YEtn3bAYdUU=;
        b=pKkXSsrtOKd3UG3a0cvN77dBukGPHnt2oiQtUoTqR1nZISNvEIp3hbU34ih9mb9nIn2tn4
        bdmBAElMC3KyJrl2r6yjZGpyrSKn+SNClPHO2HeQ7EmEerbiuqtqf62Vd+ivtyzTCkIGDp
        PdyqSOSB6N/ICiAaQcdefVbQC7xJa+0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH 1/2] sched/fair: Couple wakee flips with heavy wakers
Message-ID: <YYuWlxNG+d3G4uTo@geo.homenetwork>
References: <20211028094834.1312-1-mgorman@techsingularity.net>
 <20211028094834.1312-2-mgorman@techsingularity.net>
 <YXrNfHcfhp2LutiL@geo.homenetwork>
 <20211029084219.GV3959@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029084219.GV3959@techsingularity.net>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 09:42:19AM +0100, Mel Gorman wrote:
> On Fri, Oct 29, 2021 at 12:19:48AM +0800, Tao Zhou wrote:
> > Hi Mel,
> > 
> > On Thu, Oct 28, 2021 at 10:48:33AM +0100, Mel Gorman wrote:
> > 
> > > @@ -5865,6 +5865,14 @@ static void record_wakee(struct task_struct *p)
> > >  	}
> > >  
> > >  	if (current->last_wakee != p) {
> > > +		int min = __this_cpu_read(sd_llc_size) << 1;
> > > +		/*
> > > +		 * Couple the wakee flips to the waker for the case where it
> > > +		 * doesn't accrue flips, taking care to not push the wakee
> > > +		 * high enough that the wake_wide() heuristic fails.
> > > +		 */
> > > +		if (current->wakee_flips > p->wakee_flips * min)
> > > +			p->wakee_flips++;
> > >  		current->last_wakee = p;
> > >  		current->wakee_flips++;
> > >  	}
> > > @@ -5895,7 +5903,7 @@ static int wake_wide(struct task_struct *p)
> > >  
> > >  	if (master < slave)
> > >  		swap(master, slave);
> > > -	if (slave < factor || master < slave * factor)
> > > +	if ((slave < factor && master < (factor>>1)*factor) || master < slave * factor)
> > 
> > So, the check like this include the above range:
> > 
> >   if ((slave < factor && master < slave * factor) ||
> >        master < slave * factor)
> > 
> > That "factor>>1" filter some.
> > 
> > If "slave < factor" is true and "master < (factor>>1)*factor" is false,
> > then we check "master < slave * factor".(This is one path added by the
> > check "&&  master < (factor>>1)*factor").
> > In the latter check "slave < factor" must be true, the result of this
> > check depend on slave in the range [factor, factor>>1] if there is possibility
> > that "master < slave * factor". If slave in [factor>>1, 0], the check of
> > "master < slave * factor" is absolutly false and this can be filtered if
> > we use a variable to load the result of master < (factor>>1)*factor.
> > 
> > My random random inputs and continue confusing to move on.
> > 
> 
> I'm not sure what point you're trying to make.

Ok, some days later even can not understand what my saying myself. After 
wrong and right aross with my wreck head I just try to make this:

if ((slave < factor && master < (factor>>1)*factor) || (slave >= factor>>1) && master < slave * factor)

check "slave > factor>>1" for filter the cases that is calculated if I
am not wrong. If this have a little effect that will be to not need to
do "master < slave * factor" for some time not sure.

