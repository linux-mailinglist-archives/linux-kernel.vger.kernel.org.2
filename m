Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5653722B9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 23:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhECV6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 17:58:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229497AbhECV6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 17:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620079050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nmvaqsHbI0qIS+u1gFuZv4B9UKhy1ULg1iiDC8R3JJA=;
        b=XI7w6VrY53yQr5yJMRu9ANYaN7nlZ0DF/hlQB0SJqyofb4e/TlI3XfajErpNgw5I60NNGC
        xVf5lT7bv5Eaf9dIwdYYIq38Pp2HLmBoo7Mt4ZqbOezeXOtL2RSrGF6h5ZbNDUEv2uPnw9
        5PLjicVNAb3eKX2PLxtnk1JKw67igXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-d5TXcminP5uby09xhuyC4g-1; Mon, 03 May 2021 17:57:28 -0400
X-MC-Unique: d5TXcminP5uby09xhuyC4g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D889B8015BA;
        Mon,  3 May 2021 21:57:26 +0000 (UTC)
Received: from ovpn-112-143.rdu2.redhat.com (ovpn-112-143.rdu2.redhat.com [10.10.112.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 272242DAC5;
        Mon,  3 May 2021 21:57:25 +0000 (UTC)
Message-ID: <32a536f5688105df515e6ad9fd12fbcdbd781afb.camel@redhat.com>
Subject: Re: [PATCH v2 0/3] newidle_balance() PREEMPT_RT latency mitigations
From:   Scott Wood <swood@redhat.com>
To:     Mike Galbraith <efault@gmx.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Mon, 03 May 2021 16:57:24 -0500
In-Reply-To: <3773421d06bed0beed9971d03e8fa2050a14cc13.camel@gmx.de>
References: <20210428232821.2506201-1-swood@redhat.com>
         <CAKfTPtBrJNBg3847R_b8A-1c5rb9Fb5FFNMX+z11QGAiO0ofkw@mail.gmail.com>
         <7b796a085b0bc638c9df70d3a20718f8d1d776c8.camel@redhat.com>
         <a46f9b6c719666357e568eadd1d615c05c4171ac.camel@gmx.de>
         <4170501b7c4f19ba66d870b671dc90ffbf4623d6.camel@redhat.com>
         <3773421d06bed0beed9971d03e8fa2050a14cc13.camel@gmx.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-05-03 at 20:52 +0200, Mike Galbraith wrote:
> On Mon, 2021-05-03 at 11:33 -0500, Scott Wood wrote:
> > On Sun, 2021-05-02 at 05:25 +0200, Mike Galbraith wrote:
> > > If NEWIDLE balancing migrates one task, how does that manage to
> > > consume
> > > a full *millisecond*, and why would that only be a problem for RT?
> > > 
> > > 	-Mike
> > > 
> > > (rt tasks don't play !rt balancer here, if CPU goes idle, tough titty)
> > 
> > Determining which task to pull is apparently taking that long (again,
> > this is on a 128-cpu system).  RT is singled out because that is the
> > config that makes significant tradeoffs to keep latencies down (I
> > expect this would be far from the only possible 1ms+ latency on a
> > non-RT kernel), and there was concern about the overhead of a double
> > context switch when pulling a task to a newidle cpu.
> 
> What I think has be going on is that you're running a synchronized RT
> load, many CPUs go idle as a thundering herd, and meet at focal point
> busiest.  What I was alluding to was that preventing such size scale
> pile-ups would be way better than poking holes in it for RT to try to
> sneak through.  If pile-up it is, while not particularly likely, the
> same should happen with normal tasks, wasting cycles generating heat.
> 
> The main issue I see with these patches is that the resulting number is
> still so gawd awful as to mean "nope, not rt ready", making the whole
> exercise look a bit like a noop.

It doesn't look like rteval asks cyclictest to synchronize, but
regardless, how is this "poking holes"?  Making sure interrupts are
enabled during potentially long-running activities is pretty fundamental
to PREEMPT_RT.  What specifically is your suggestion?

And yes, 317 us is still not a very good number for PREEMPT_RT, but
progress is progress.  It's hard to address the moderate latency spikes
if they're obscured by large latency spikes.  One also needs to have
realistic expectations when it comes to RT on large systems, particularly
when not isolating the latency-sensitive CPUs.

-Scott


