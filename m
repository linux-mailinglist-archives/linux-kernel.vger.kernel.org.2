Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0178D3293C2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 22:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbhCAVei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 16:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238004AbhCARV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:21:28 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4972EC0611BC
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 09:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BeoQctyGjDw5v/fyfueGOvkOxrz9/0GKk5LORaN0mXk=; b=vkZGHm7EkMSG0iWx1JDZ7eRsmB
        jCfKViyC/gDD0eeQc52RRX9+rOtpYf79ydZ3vHpXFQETzfxyZrIzjq7+Ve4SgktxSVpXcClwyPTVG
        jldDrMQ3fEpWxclDLzssofn7WRf0i/0jPHL7nFDCc+gq7jfKoKl1N5q2zJc3vp/ccyy0lMElUZWhO
        ZHcr2aw6c9ZDH1qmwE2kPFhXlt2g7/afUOVOUk8s+L4284aIc8OeGAEGGneN97d9bjXYMfHq2c5fg
        Ox13ZGlg/V3O90As249v32D+KfhSvR9YvwrID5wc+6IW+/rGXQ68ouw267oq1Orcm80+p1i3QXpDv
        TU3Bozew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lGmBi-0000QK-3D; Mon, 01 Mar 2021 17:18:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 90A983003E1;
        Mon,  1 Mar 2021 18:18:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 58D522B973BDA; Mon,  1 Mar 2021 18:18:28 +0100 (CET)
Date:   Mon, 1 Mar 2021 18:18:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Rik van Riel <riel@surriel.com>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: Re: [PATCH] sched/fair: Prefer idle CPU to cache affinity
Message-ID: <YD0h5I7qmDO2zlkE@hirez.programming.kicks-ass.net>
References: <20210226164029.122432-1-srikar@linux.vnet.ibm.com>
 <ab046b9d5bcd29b2eb759cd999e2f578a683c673.camel@surriel.com>
 <YD0L6sba9RfXX+tM@hirez.programming.kicks-ass.net>
 <20210301170601.GJ2028034@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301170601.GJ2028034@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 10:36:01PM +0530, Srikar Dronamraju wrote:
> * Peter Zijlstra <peterz@infradead.org> [2021-03-01 16:44:42]:
> 
> > On Sat, Feb 27, 2021 at 02:56:07PM -0500, Rik van Riel wrote:
> > > On Fri, 2021-02-26 at 22:10 +0530, Srikar Dronamraju wrote:
> > 
> > > > +	if (sched_feat(WA_WAKER) && tnr_busy < tllc_size)
> > > > +		return this_cpu;
> > > 
> > > I wonder if we need to use a slightly lower threshold on
> > > very large LLCs, both to account for the fact that the
> > > select_idle_cpu code may not find the single idle CPU
> > > among a dozen busy ones, or because on a system with
> > > hyperthreading we may often be better off picking another
> > > LLC for HT contention issues?
> > > 
> > > Maybe we could use "tnr_busy * 4 <
> > > tllc_size * 3" or
> > > something like that?
> > 
> > How about:
> > 
> > 	tnr_busy < tllc_size / topology_max_smt_threads()
> > 
> > ?
> 
> Isn't topology_max_smt_threads only for x86 as of today?
> Or Am I missing out?

Oh, could be, I didn't grep :/ We could have core code keep track of the
smt count I suppose.
