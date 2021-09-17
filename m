Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F014100C1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 23:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbhIQVfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 17:35:30 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:50480 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhIQVf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 17:35:29 -0400
Received: from bender.morinfr.org (unknown [82.64.86.27])
        by smtp4-g21.free.fr (Postfix) with ESMTPS id 7290E19F54D;
        Fri, 17 Sep 2021 23:34:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
        ; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hMHLBhjUkp4MDm4/p0njBJYEzSdbL24VqubJNkEb5Dg=; b=jEAy5BmPkNV4a3+73r4xz29Cvu
        MBDL3WhrdFIHpwPaCMnR2x5ALq5qBFEFHZCVCwsGxuUSv2A+YrsNzg7A3NBQj/lUsP2d+Ffe8GbDP
        urnWqm04iLr2s2W9XMWDKBkQ5XTFIbbAwxL1C9i7Acrcl6+rFD77dN87YQCruoZ7A0Nc=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.92)
        (envelope-from <guillaume@morinfr.org>)
        id 1mRLUk-00040M-9C; Fri, 17 Sep 2021 23:34:06 +0200
Date:   Fri, 17 Sep 2021 23:34:06 +0200
From:   Guillaume Morin <guillaume@morinfr.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: call_rcu data race patch
Message-ID: <20210917213404.GA14271@bender.morinfr.org>
Mail-Followup-To: "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210917191555.GA2198@bender.morinfr.org>
 <20210917211148.GU4156@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917211148.GU4156@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Sep 14:11, Paul E. McKenney wrote:
> On Fri, Sep 17, 2021 at 09:15:57PM +0200, Guillaume Morin wrote:
> > Hello Paul,
> > 
> > I've been researching some RCU warnings we see that lead to full lockups
> > with longterm 5.x kernels.
> > 
> > Basically the rcu_advance_cbs() == true warning in
> > rcu_advance_cbs_nowake() is firing then everything eventually gets
> > stuck on RCU synchronization because the GP thread stays asleep while
> > rcu_state.gp_flags & 1 == 1 (this is a bunch of nohz_full cpus)
> > 
> > During that search I found your patch from July 12th
> > https://www.spinics.net/lists/rcu/msg05731.html that seems related (all
> > warnings we've seen happened in the __fput call path). Is there a reason
> > this patch was not pushed? Is there an issue with this patch or did it
> > fall just through the cracks?
> 
> It is still in -rcu:
> 
> 2431774f04d1 ("rcu: Mark accesses to rcu_state.n_force_qs")
> 
> It is slated for the v5.16 merge window.  But does it really fix the
> problem that you are seeing?

I am going to try it soon. Since I could not see it in Linus' tree, I
wanted to make sure there was nothing wrong with the patch, hence my
email :-)

To my dismay, I can't reproduce this issue so this has made debugging
and testing very complicated.

I have a few kdumps from 5.4 and 5.10 kernels (that's how I was able to
observe that the gp thread was sleeping for a long time) and that
rcu_state.gp_flags & 1 == 1.

But this warning has happened a couple of dozen times on multiple
machines in the __fput path (different kind of HW as well). Removing
nohz_full from the command line makes the problem disappear.

Most machines have had fairly long uptime (30+ days) before showing the
warning, though it has happened on a couple occasions only after a few
hours.

That's pretty much all I have been able to gather so far, unfortunately.

> > PS: FYI during my research, I've found another similar report in
> > bugzilla https://bugzilla.kernel.org/show_bug.cgi?id=208685
> 
> Huh.  First I have heard of it.  It looks like they hit this after about
> nine days of uptime.  I have run way more than nine days of testing of
> nohz_full RCU operation with rcutorture, and have never seen it myself.
> 
> Can you reproduce this?  If so, can you reproduce it on mainline kernels
> (as opposed to -stable kernels as in that bugzilla)?

I have at least one prod machine where the problem happens usually
within a couple of days. All my attempts to reproduce on any testing
environment have failed.

> 
> The theory behind that WARN_ON_ONCE() is as follows:
> 
> o	The check of rcu_seq_state(rcu_seq_current(&rnp->gp_seq))
> 	says that there is a grace period either in effect or just
> 	now ending.
> 
> o	In the latter case, the grace-period cleanup has not yet
> 	reached the current rcu_node structure, which means that
> 	it has not yet checked to see if another grace period
> 	is needed.
> 
> o	Either way, the RCU_GP_FLAG_INIT will cause the next grace
> 	period to start.  (This flag is protected by the root
> 	rcu_node structure's ->lock.)
> 
> Again, can you reproduce this, especially in mainline?

I have not tried because running a mainline kernel in our prod
enviroment is quite difficult and requires lot of work for validation.
Though I could probably make it happen but it would take some time.
Patches that I can apply on a stable kernel are much easier for me to
try, as you probably have guessed.

I appreciate your answer,

Guillaume.

-- 
Guillaume Morin <guillaume@morinfr.org>
