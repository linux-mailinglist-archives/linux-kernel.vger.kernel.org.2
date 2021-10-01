Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54E741F185
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 17:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353832AbhJAPwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 11:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhJAPwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 11:52:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F429C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 08:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=HAozprAp32k9vluNj0AhWzSv/u8RNIsE8GQbafTAqFI=; b=EjNsxX3QzNlfSlwpynUNG3XhQX
        ZDGss5O+cNt/k7rlRBE9UfxX6J5Il76R3cpedfqVBVUzUHVOmz0df5mzLhZJPsTAPjF4VswLYqVmS
        HokkwmLC6/pzbaicegAjcsnGx9QBWXhCdCAPxCzt9rmpd+AfhEchZSyC0ftj1SWNirudZFRmbTYBw
        uyj4m7xb18tt2JCceUU5ixGNI+ghnZHHdb1yo9DuezH62LjcAVNpnnmgHvtte2RePB3bPReoL50UU
        2cj4T+VLNqMgSbuAXi53xSLVW/mpw/g1VXdGYBFwX3iKdfYduBR9gCzPxmY2hZx1iUpVIJwhcm5MB
        605xK5ww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mWKm1-00E2XF-V6; Fri, 01 Oct 2021 15:48:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A9F95302A0E;
        Fri,  1 Oct 2021 17:48:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 57CE029ACCB62; Fri,  1 Oct 2021 17:48:32 +0200 (CEST)
Date:   Fri, 1 Oct 2021 17:48:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC 1/6] sched: Add nice value change notifier
Message-ID: <YVct0D9kB1KtrwZ3@hirez.programming.kicks-ass.net>
References: <20210930171552.501553-1-tvrtko.ursulin@linux.intel.com>
 <20210930171552.501553-2-tvrtko.ursulin@linux.intel.com>
 <20210930183316.GC4323@worktop.programming.kicks-ass.net>
 <4aca656d-678f-4d61-38a4-d2e7a8fd89ab@linux.intel.com>
 <5c71ec04-9148-0587-c495-11dbd8f77d67@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c71ec04-9148-0587-c495-11dbd8f77d67@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 11:32:16AM +0100, Tvrtko Ursulin wrote:
> 
> On 01/10/2021 10:04, Tvrtko Ursulin wrote:
> > 
> > Hi Peter,
> > 
> > On 30/09/2021 19:33, Peter Zijlstra wrote:
> > > On Thu, Sep 30, 2021 at 06:15:47PM +0100, Tvrtko Ursulin wrote:
> > > >   void set_user_nice(struct task_struct *p, long nice)
> > > >   {
> > > >       bool queued, running;
> > > > -    int old_prio;
> > > > +    int old_prio, ret;
> > > >       struct rq_flags rf;
> > > >       struct rq *rq;
> > > > @@ -6913,6 +6945,9 @@ void set_user_nice(struct task_struct *p,
> > > > long nice)
> > > >        */
> > > >       p->sched_class->prio_changed(rq, p, old_prio);
> > > > +    ret = atomic_notifier_call_chain(&user_nice_notifier_list,
> > > > nice, p);
> > > > +    WARN_ON_ONCE(ret != NOTIFY_DONE);
> > > > +
> > > >   out_unlock:
> > > >       task_rq_unlock(rq, p, &rf);
> > > >   }
> > > 
> > > No, we're not going to call out to exported, and potentially unbounded,
> > > functions under scheduler locks.
> > 
> > Agreed, that's another good point why it is even more hairy, as I have
> > generally alluded in the cover letter.
> > 
> > Do you have any immediate thoughts on possible alternatives?
> > 
> > Like for instance if I did a queue_work from set_user_nice and then ran
> > a notifier chain async from a worker? I haven't looked at yet what
> > repercussion would that have in terms of having to cancel the pending
> > workers when tasks exit. I can try and prototype that and see how it
> > would look.
> 
> Hm or I simply move calling the notifier chain to after task_rq_unlock? That
> would leave it run under the tasklist lock so probably still quite bad.

Hmm? That's for normalize_rt_tasks() only, right? Just don't have it
call the notifier in that special case (that's a magic sysrq thing
anyway).
