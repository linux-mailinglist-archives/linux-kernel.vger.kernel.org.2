Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FF73FB4B3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 13:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236601AbhH3Ljo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 07:39:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236434AbhH3Ljm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 07:39:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0379A61131;
        Mon, 30 Aug 2021 11:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630323528;
        bh=Upe31+s3Vm+aMhH42UOXGT5Rq28wmJxeBI1SB0zPJPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T/gTYL7WKiDoKVJKp8opYR4fNFjwZ8Ft8HmTH6KrayUzHpMkmh478OzyuCtYXYuAm
         OlEviD0HjJlhKKD07l6RTB1ibCW26Dn+sKG+OlNImy4FX3vDSnclywQXvW9ezNKZhW
         Vo8p22NdsbAQDw3/HuSf9xjVnNpVLkAI/M4mUisx1tlSOzIu1qns6wn+UNCl8lGLHo
         hliBWKdK+HY87m8MjJjlfNAgeaFWupTJ11j2apt1L/lY9t6IUqtvDM1Z89/6anGFLJ
         UMuyptD8xpcmOrwU29rbJsdnugD8WDTiu2JzHo+oowQPHDJC8fk5mku45pBwDfelyG
         IV1TDV0OG0Xpw==
Date:   Mon, 30 Aug 2021 13:38:46 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [patch V3 2/8] add prctl task isolation prctl docs and samples
Message-ID: <20210830113846.GA17720@lothringen>
References: <20210824152423.300346181@fuller.cnet>
 <20210824152646.706875395@fuller.cnet>
 <20210826095958.GA908505@lothringen>
 <20210826121131.GA152063@fuller.cnet>
 <20210827130820.GA918573@lothringen>
 <20210827144416.GA186908@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827144416.GA186908@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 11:44:16AM -0300, Marcelo Tosatti wrote:
> On Fri, Aug 27, 2021 at 03:08:20PM +0200, Frederic Weisbecker wrote:
> > Ok so to make things clearer, may I suggest:
> > 
> >    s/PR_ISOL_FEAT/PR_ISOL_GET_FEAT

<nit>
In fact PR_ISOL_FEAT_GET so that it follows the same naming convention
than PR_ISOL_CFG_GET/PR_ISOL_PARAM_GET and PR_ISOL_ACTIVATE_GET


> > But then suppose I do this:
> > 
> > prctl(PR_ISOL_SET, ISOL_F_QUIESCE_ONCE, ISOL_F_QUIESCE_VMSTATS, ...)
> > prctl(PR_ISOL_CTRL_SET, ISOL_F_QUIESCE_ONCE, ...) //will quiesce on this return only
> > prctl(PR_ISOL_CTRL_GET,  ...)
> > 
> > What should PR_ISOL_CTRL_GET return above? Probably nothing.
> 
> Yeah, nothing.
> 
> So the "quiesce once" feature, as i understand, was suggested by
> Christoph for the following type of application:
> 
> lat_loop:
> 
> 	do {
> 		events = pending_events();
> 		if (events & DATAPATH_EVENT)
> 			process_data()
> 	} while (!(events & UNFREQUENT_ERROR_EVENT))
> 
> 	syscall1()
> 	syscall2()
> 	...
> 	syscallN()
> 	goto lat_loop;
> 
> With the V3 patchset, one would have to:
> 
> 	prctl(PR_ISOL_SET, ISOL_F_OTHER, ...);
> 	prctl(PR_ISOL_SET, ISOL_F_QUIESCE, ISOL_F_QUIESCE_VMSTATS, ...);
> 	...
> 	prctl(PR_ISOL_CTRL_SET, ISOL_F_QUIESCE|ISOL_F_OTHER);
> lat_loop:
> 	do {
> 		events = pending_events();
> 		if (events & DATAPATH_EVENT)
> 			process_data()
> 	} while (!(events & UNFREQUENT_ERROR_EVENT))
> 
> 	/* disables quiescing while executing system calls */
> 	prctl(PR_ISOL_CTRL_SET, ISOL_F_OTHER);
> 	syscall1()
> 	syscall2()
> 	...
> 	syscallN()
> 
> 	/* no more system calls, enables quiescing */
> 	prctl(PR_ISOL_CTRL_SET, ISOL_F_QUIESCE|ISOL_F_OTHER);
> 	goto lat_loop;
> 
> But for an interface with less system calls (true "quiesce once") one could do:
> 
> 	prctl(PR_ISOL_SET, ISOL_F_OTHER, ...);
> 	/* rather than do it at _CTRL_SET as you suggest, enable it at
> 	 * configuration time.
> 	 */
> 	prctl(PR_ISOL_SET, ISOL_F_QUIESCE, ISOL_F_QUIESCE_VMSTATS|ISOL_F_QUIESCE_ONCE, ...);
> 	...
> 
> lat_loop:
> 	prctl(PR_ISOL_CTRL_SET, ISOL_F_QUIESCE|ISOL_F_OTHER);
> 	do {
> 		events = pending_events();
> 		if (events & DATAPATH_EVENT)
> 			process_data()
> 	} while (!(events & UNFREQUENT_ERROR_EVENT))
> 
> 	/* disables quiescing while executing system calls */
> 	syscall1()
> 	syscall2()
> 	...
> 	syscallN()
> 
> 	goto lat_loop;
> 
> But see how it starts to get weird: both versions (new feature, 
> ISOL_F_QUIESCE_ONCE, or new "quiesce feature', ISOL_F_QUIESCE_ONCE)
> are using space reserved to
> 
> "a list of different features" 
> or
> "a list of different quiesce features".
> 
> To add something which is not either a new task isolation 
> feature or quiesce feature, but a separate control
> (which could apply to all of features, or which one might want
> to apply only to certain features, and in that case a bitmap
> might be specified).
> 
> So i think adding a new parameter such as:
> 
> prctl(PR_ISOL_SET, ISOL_F_QUIESCE, CMD, arg, ...);
> 
> is a good idea. So one can have (with two commands, SET_QUIESCE 
> and SET_ONESHOT).
> 
> prctl(PR_ISOL_SET, ISOL_F_QUIESCE, SET_QUIESCE, ISOL_F_QUIESCE_VMSTAT);
> prctl(PR_ISOL_SET, ISOL_F_QUIESCE, SET_ONESHOT, ISOL_F_QUIESCE_VMSTAT);
> 
> Then its possible to add random commands with random parameters
> (rather than be limited by a single bitmask to control quiescing).
> 
> Does that make sense?

We can but it means that the ONESHOT property applies to all ISOL_F_QUIESCE
features. So you can't, for example, quiesce ISOL_F_QUIESCE_VMSTAT only once
and quiesce ISOL_F_QUIESCE_FOO all the time.

I have no idea if it matters or not but be aware of limitations.

> > > +#ifdef PR_ISOL_GET
> > > +       ret = prctl(PR_ISOL_GET, 0, 0, 0, 0);
> > > +	if (ret != -1) {
> > > +               unsigned long mask = ret;
> > > +
> > > +               TEST0(prctl(PR_ISOL_CTRL_SET, mask, 0, 0, 0));
> > > +	}
> > > +#endif
> > > +
> > >         frc(&ts2);
> > >         do {
> > >                 workload_fn(t->dst_buf, t->src_buf, g.workload_mem_size);
> > > 
> > > Makes sense?
> > 
> > Yes! Btw you might want to fetch the mask of PR_ISOL_GET into the
> > second parameter instead of using the return value which is only
> > 32 bits or prctl() and the highest significant bit is even reserved
> > for the error.
> 
> Would be good to do this for all cases, so you can extend the
> struct (or pad it).

Yep.

> > Funny but that would work. Either way, let's keep things that way for now.
> > Just the naming is unfortunate.
> > 
> > Well that could be a clone flag after all... 
> 
> Yes, it could as well. But there are no more bits for older clone
> interfaces, and clone3 seems to be problematic (moreover, this
> interface would need backporting to older kernels).

Another way to go is to use all the features as a mask in PR_ISOL_CFG_SET:

prctl(PR_ISOL_FEAT_GET, 0, &all_features, ...)
prctl(PR_ISOL_CFG_SET, &all_features, PR_ISOL_INHERIT...)

or simply:

prctl(PR_ISOL_CFG_SET, -1, PR_ISOL_INHERIT...)

or even:

prctl(PR_ISOL_CFG_SET, 0, PR_ISOL_INHERIT...)

Thanks.
