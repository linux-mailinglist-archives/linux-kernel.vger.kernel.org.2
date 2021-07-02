Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B238A3B9E39
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 11:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhGBJbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 05:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbhGBJa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 05:30:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4996C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 02:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v8zrj1V6xVcbepaiWjbS8RX/IKFy1g4AS4gveeyabo0=; b=M2RmgXOBRo85weL/DN4WbfCTsM
        msh2vX1S2LNpJeOv1OnqIHC3/D2z2XO2JnaPYsB/gML0pm9QEoP/8Zt1dDVhX65HYNhpMsz1qOHUt
        VWN/fIMSINkpa2Je04+48lNrjC1pJPo/SCGId5oJaA7XclfTQT/fnlw0sz2kP12pSZseof8Zkux1r
        r9kRqHgL3XXQQ2pct1v0qdzgqGOVJr1V+AfPz4CA3ONk+tCgJe0F6BdC5hrRFZArCtDLdicb/hJy7
        j/8pNYUqbzX//LWS1RCJhe4fz70uTSJG/ItmIuwlH5ov3yPpz2P0bBL0KasSAxp3sTP0V10vJ7uNj
        iuiq02ZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lzFSy-00DpD7-NH; Fri, 02 Jul 2021 09:28:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 932E2300091;
        Fri,  2 Jul 2021 11:28:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 724F12DD2264A; Fri,  2 Jul 2021 11:28:05 +0200 (CEST)
Date:   Fri, 2 Jul 2021 11:28:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        matthias.bgg@gmail.com, Minchan Kim <minchan@google.com>,
        Tim Murray <timmurray@google.com>,
        YT Chang <yt.chang@mediatek.com>,
        Wenju Xu =?utf-8?B?KOiuuOaWh+S4vik=?= <wenju.xu@mediatek.com>,
        Jonathan JMChen =?utf-8?B?KOmZs+WutuaYjik=?= 
        <jonathan.jmchen@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel-team <kernel-team@android.com>,
        SH Chen <show-hong.chen@mediatek.com>
Subject: Re: [PATCH v2 1/1] psi: stop relying on timer_pending for poll_work
 rescheduling
Message-ID: <YN7cJZOZzjYJFClR@hirez.programming.kicks-ass.net>
References: <20210630205151.137001-1-surenb@google.com>
 <YN2DsLlE+WtxK6K9@hirez.programming.kicks-ass.net>
 <CAJuCfpF=Ty4ruiKQQweVoF6Ojx8P8LxvUBxp1TmMFo2W1xNWfg@mail.gmail.com>
 <YN3pUNgpBjn42f8s@hirez.programming.kicks-ass.net>
 <CAJuCfpFKDhcgjU=MGsz+JuetrWvYCe0EL3FMp91zopH+8T=mMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFKDhcgjU=MGsz+JuetrWvYCe0EL3FMp91zopH+8T=mMQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 09:28:04AM -0700, Suren Baghdasaryan wrote:
> On Thu, Jul 1, 2021 at 9:12 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Jul 01, 2021 at 09:09:25AM -0700, Suren Baghdasaryan wrote:
> > > On Thu, Jul 1, 2021 at 1:59 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Wed, Jun 30, 2021 at 01:51:51PM -0700, Suren Baghdasaryan wrote:
> > > > > +     /* cmpxchg should be called even when !force to set poll_scheduled */
> > > > > +     if (atomic_cmpxchg(&group->poll_scheduled, 0, 1) && !force)
> > > > >               return;
> > > >
> > > > Why is that a cmpxchg() ?
> > >
> > > We want to set poll_scheduled and proceed with rescheduling the timer
> > > unless it's already scheduled, so cmpxchg helps us to make that
> > > decision atomically. Or did I misunderstand your question?
> >
> > What's wrong with: atomic_xchg(&group->poll_scheduled, 1) ?
> 
> Yes, since poll_scheduled can be only 0 or 1 atomic_xchg should work
> fine here. Functionally equivalent but I assume atomic_xchg() is more
> efficient due to no comparison.

Mostly conceptually simpler; the cmpxchg-on-0 makes that you have to
check if there's ever any state outside of {0,1}. The xchg() thing is
the classical test-and-set pattern.

On top of all that, the cmpxchg() can fail, which brings ordering
issues.

Typically, I think, you want to ensure that everything that happens
before psi_schedule_poll_work() is visible to the work when it runs
(also see Johannes' email). In case poll_scheduled is already 1, the
cmpxchg will fail and *NOT* provide that ordering. Meaning the work
might not observe the latest changes. xchg() doesn't have this subtlety.
