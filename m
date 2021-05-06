Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62698375254
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 12:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhEFKax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 06:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbhEFKaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 06:30:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E1EC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 03:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YHiOmQcboiZT0WmWlONHNVufQWuYbrVaBoVPrk1FeJo=; b=IsMSmLWJ+cjgzChWIiiei/Om7B
        ziblmlpG9Nx2fPC5gk7RLg9xmlD7hpNq+V1GG/BnLSmD3lXysswgqHhElC7ulRZHOEAubKAc6KsKz
        XPmekUU91OLP/n6IAgUVgYKkN8taZVWk5tY6dz0swZyCXLR0OZycOU0BpsQKUtJ394DRgtLc74sWs
        TrneRqsqr1neb4gmRvbUxD8s/bYb+fCZTqhm1EqsuHZ2avJujeQcouMOpe9Z8epVkIkpUQYW78oFU
        QNISP3qWcuisvrmKwkZppEggr3L6PEhv6C8jkYmn7yoiWnngCN0To1Yyg45YkRn8YEVfHw60orwjM
        XF1rPK3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lebCf-001aqc-8T; Thu, 06 May 2021 10:26:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 954B6300103;
        Thu,  6 May 2021 12:25:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F2DE20D11F6F; Thu,  6 May 2021 12:25:55 +0200 (CEST)
Date:   Thu, 6 May 2021 12:25:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Don Hiatt <dhiatt@digitalocean.com>
Cc:     Josh Don <joshdon@google.com>, Aubrey Li <aubrey.intel@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
Message-ID: <YJPEM1DPrG2zlvY0@hirez.programming.kicks-ass.net>
References: <20210422120459.447350175@infradead.org>
 <20210422123308.196692074@infradead.org>
 <CAERHkrsC9rC4Jrkz8r-7kp4SFPM6aU+EHN+Y+uQiTuPG5S72bA@mail.gmail.com>
 <CABk29NuS-B3n4sbmavo0NDA1OCCsz6Zf2VDjjFQvAxBMQoJ_Lg@mail.gmail.com>
 <YJD56sBCGviSDOTK@hirez.programming.kicks-ass.net>
 <CAOY2Wowj-EEARi7b4X2wvaJExj_yQ1w5tgBRdnXX5BYJY0U15g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOY2Wowj-EEARi7b4X2wvaJExj_yQ1w5tgBRdnXX5BYJY0U15g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 09:20:38AM -0700, Don Hiatt wrote:
> On Tue, May 4, 2021 at 12:38 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Apr 29, 2021 at 01:39:54PM -0700, Josh Don wrote:
> >
> > > > > +void double_rq_lock(struct rq *rq1, struct rq *rq2)
> > > > > +{
> > > > > +       lockdep_assert_irqs_disabled();
> > > > > +
> > > > > +       if (rq1->cpu > rq2->cpu)
> > > >
> > > > It's still a bit hard for me to digest this function, I guess using (rq->cpu)
> > > > can't guarantee the sequence of locking when coresched is enabled.
> > > >
> > > > - cpu1 and cpu7 shares lockA
> > > > - cpu2 and cpu8 shares lockB
> > > >
> > > > double_rq_lock(1,8) leads to lock(A) and lock(B)
> > > > double_rq_lock(7,2) leads to lock(B) and lock(A)
> >
> > Good one!
> 
> Hi Peter,
> 
> I've been running the same set-cookie tests on your latest repo for
> the last 24 hours and haven't had a single lockup. Thank you very
> much!

Excellent, applied your Tested-by, thanks!
