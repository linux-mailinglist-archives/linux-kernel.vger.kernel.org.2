Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C423667D4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237850AbhDUJWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhDUJW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:22:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D36C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dxZzTJUxws0neR0ciyKEBuvmF6WDgchSCraIXxN/vmM=; b=HC6vscGoP5PMTnoCU/mdcRHGMr
        LqAsiePoZSD6LwRPVbAQ78AvSaHiPwfo9nTpklNWW4tlmBwZqq94ZNP9+zQvnPvMlM8SwPXYy67OH
        COjNKQKCdGtcqHM4UUk6jeNRKeYfsv/AUrYQMwdn7cNYmuEzPDww//vo4fTYK3w7cS8OfpisFvDPw
        8BV6al+//jMdOlBHYqUMQLcWurj124vZ4SBDSStwt5yLmQ5f7ME3PL802p8BBJHshdrBc3Ry5ZK79
        fcj4S3cVwish6k5xDmicv19FqPZJbcUH6mETzKOIL+GwVVDRBxgzX4VktDGoGd5kl8TZALqAzYK+g
        UbEz0m4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZ92k-00GJwZ-SL; Wed, 21 Apr 2021 09:21:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8A8303001E2;
        Wed, 21 Apr 2021 11:21:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 786922023C206; Wed, 21 Apr 2021 11:21:09 +0200 (CEST)
Date:   Wed, 21 Apr 2021 11:21:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Like Xu <like.xu@linux.intel.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 2/2] perf/x86/lbr: Move cpuc->lbr_xsave allocation
 out of sleeping region
Message-ID: <YH/uhXEmQllOsIeK@hirez.programming.kicks-ass.net>
References: <20210421021825.37872-1-like.xu@linux.intel.com>
 <20210421021825.37872-2-like.xu@linux.intel.com>
 <YH/kikWFlfD260qy@hirez.programming.kicks-ass.net>
 <13fd7ac4-46fd-3fa7-0e80-3f46cfc8edac@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13fd7ac4-46fd-3fa7-0e80-3f46cfc8edac@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 04:48:36PM +0800, Like Xu wrote:
> Hi Peter,
> 
> On 2021/4/21 16:38, Peter Zijlstra wrote:
> > On Wed, Apr 21, 2021 at 10:18:25AM +0800, Like Xu wrote:
> > > -int x86_reserve_hardware(void)
> > > +int x86_reserve_hardware(struct perf_event *event)
> > >   {
> > >   	int err = 0;
> > > @@ -398,8 +398,10 @@ int x86_reserve_hardware(void)
> > >   		if (atomic_read(&pmc_refcount) == 0) {
> > >   			if (!reserve_pmc_hardware())
> > >   				err = -EBUSY;
> > > -			else
> > > +			else {
> > >   				reserve_ds_buffers();
> > > +				reserve_lbr_buffers(event);
> > > +			}
> > >   		}
> > >   		if (!err)
> > >   			atomic_inc(&pmc_refcount);
> > > @@ -650,7 +652,7 @@ static int __x86_pmu_event_init(struct perf_event *event)
> > >   	if (!x86_pmu_initialized())
> > >   		return -ENODEV;
> > > -	err = x86_reserve_hardware();
> > > +	err = x86_reserve_hardware(event);
> > >   	if (err)
> > >   		return err;
> > 
> > This is still complete garbage..
> 
> Hhh,thanks for your comment!

The nice one was here:

  https://lkml.kernel.org/r/20210323214140.GE4746@worktop.programming.kicks-ass.net

> So do we have a better idea to alloc cpuc->lbr_xsave
> to avoid this kind of call trace ?

You thinking this is actually hard scares me. Frob something in
intel_pmu_hw_config() or thereabouts.
