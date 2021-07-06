Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1B73BC797
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 10:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhGFICq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 04:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhGFICp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 04:02:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79D1C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 01:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fnyolh74ErD433UyCKYW1UcltgOqGwfIFxvvtVPYM6g=; b=j5/MpJ4aANLe2U2DkLFi34L3xj
        WxIHgR362Y5c25eymBr3Qp6AfvwT5UX2dXb4DxoSu+9/9IyKaKmEJHm8AhCFLSNOYKQ3zQlRjtbta
        nLSQva1yXN5G2FEBotlvWC/9oNC8bt6Ok8t9KHdAXWPs62VPs24um8iYLMxJnQX9r004Ov2WdgR3Z
        Dojr6Z+aQC4Ph1/Scj67HacavvqLdUlMK7LtgLSDZ4/WltNnSI3fez75dXP/LMFw6jZj5uqU9TJ0z
        XlS6lObuPVvKgNifW/oRgQMgiZrs8/M8g1uSUNIQz8UoWSFxf39cedN+5wYlZmV0pokkXDrsgox7j
        EU0628rw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0fzu-00Eyna-LG; Tue, 06 Jul 2021 08:00:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3B915300233;
        Tue,  6 Jul 2021 10:00:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21AF1200E1E7B; Tue,  6 Jul 2021 10:00:02 +0200 (CEST)
Date:   Tue, 6 Jul 2021 10:00:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: RCU vs data_race()
Message-ID: <YOQNgsS9Tjt4aDmG@hirez.programming.kicks-ass.net>
References: <YMxYR33XEfVg6AoD@hirez.programming.kicks-ass.net>
 <YMxgbuEdrq8k3eZp@elver.google.com>
 <YMyC0iux0wKzc1JG@hirez.programming.kicks-ass.net>
 <20210618204800.GK4397@paulmck-ThinkPad-P17-Gen-1>
 <YM+TlNDJm1Jx1WQW@hirez.programming.kicks-ass.net>
 <20210620210127.GR4397@paulmck-ThinkPad-P17-Gen-1>
 <YNA/gkHbq46A/21C@hirez.programming.kicks-ass.net>
 <20210621133757.GS4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621133757.GS4397@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for the late reply, thread got snowed under :/

On Mon, Jun 21, 2021 at 06:37:57AM -0700, Paul E. McKenney wrote:
> On Mon, Jun 21, 2021 at 09:28:02AM +0200, Peter Zijlstra wrote:
> > On Sun, Jun 20, 2021 at 02:01:27PM -0700, Paul E. McKenney wrote:
> > > On Sun, Jun 20, 2021 at 09:14:28PM +0200, Peter Zijlstra wrote:
> > 
> > > > I don't buy that argument. pr_err() (or worse) is not supposed to
> > > > happen, ever. If it does, *that* is a far worse condition that any data
> > > > race possibly found by kcsan.
> > > > 
> > > > So the only way the pr_err() expression itself can lead to kcsan
> > > > determining a data-race, if something far worse triggered the pr_err()
> > > > itself.
> > > 
> > > Earlier, you said pr_warn().  Above, I said pr_*().  Now you say
> > > pr_err().  But OK...
> > 
> > Same, thing.. also Sundays aren't great for details it seems :-)
> 
> I know that feeling!  ;-)
> 
> > > Let's take for example the pr_err() in __call_rcu(), that is, the
> > > double-free diagnostic.  A KCSAN warning on the unmarked load from
> > > head->func could give valuable information on the whereabouts of the
> > > other code interfering with the callback.  Blanket disabling of KCSAN
> > > across all pr_err() calls (let alone all pr_*() calls) would be the
> > > opposite of helpful.
> > 
> > I'm confused. That pr_err() should never happen in a correct program. If
> > it happens, fix it and any data race as a consequence of that pr_err()
> > no longer exists either.
> > 
> > I fundementally don't see the relevance of a possible data race from a
> > statement that should never happen in a correct program to begin with.
> > 
> > Why do you think otherwise?
> 
> Because detection of that data race can provide valuable debugging help.

In that case, would not an explicit: data_debug(addr) call (implemented
by KASAN/KCSAN/whoever), which would report whatever knowledge they have
about that address, be even more useful?

Then you don't need to hope that there's a data race of sorts in order
to obtain said information.

That is; if you want information, explicitly asking for it seems *much*
better than hoping.
