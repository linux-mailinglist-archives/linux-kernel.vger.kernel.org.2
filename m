Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A829141009C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 23:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239581AbhIQVNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 17:13:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230515AbhIQVNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 17:13:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FBDA61041;
        Fri, 17 Sep 2021 21:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631913109;
        bh=31CmOBTdFWEQKF5fx7eay9xKs1Wkzq31rvxGvZmKduQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Jw+ntcq7UIyiiEYuh25GWtc0wLCgPY/tcmBDL/Di0iwLE7fB2zdHeQvxDNeh/8VrM
         RCcgc8AtirfGG+Tz3UDDXFxG/bt3iBpC5D9idxdlmMr+NiAMWkBoEvDoWIznww+Vke
         X9L3mZgTCLHkiHoIAq97qRJdOcvyAziQKbgFRgrC0GRjQVHGna5r35EMrIBVcjFAS/
         YPQbw+j2fwEZxUEApJ+f5hSkAcE3Y8maV62xtv2w6PlhFlyahMxI/OVqKiG34WjRkH
         C1ITXsZ4i5VhibxPCqkQDxfdeLjo5iw64wFCAXP5GyktwHrZKC+7ApSUx7gFWc1Z36
         wcPLv/gQRdbkA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E6D8D5C0892; Fri, 17 Sep 2021 14:11:48 -0700 (PDT)
Date:   Fri, 17 Sep 2021 14:11:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Guillaume Morin <guillaume@morinfr.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: call_rcu data race patch
Message-ID: <20210917211148.GU4156@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210917191555.GA2198@bender.morinfr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917191555.GA2198@bender.morinfr.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 09:15:57PM +0200, Guillaume Morin wrote:
> Hello Paul,
> 
> I've been researching some RCU warnings we see that lead to full lockups
> with longterm 5.x kernels.
> 
> Basically the rcu_advance_cbs() == true warning in
> rcu_advance_cbs_nowake() is firing then everything eventually gets
> stuck on RCU synchronization because the GP thread stays asleep while
> rcu_state.gp_flags & 1 == 1 (this is a bunch of nohz_full cpus)
> 
> During that search I found your patch from July 12th
> https://www.spinics.net/lists/rcu/msg05731.html that seems related (all
> warnings we've seen happened in the __fput call path). Is there a reason
> this patch was not pushed? Is there an issue with this patch or did it
> fall just through the cracks?

It is still in -rcu:

2431774f04d1 ("rcu: Mark accesses to rcu_state.n_force_qs")

It is slated for the v5.16 merge window.  But does it really fix the
problem that you are seeing?

> Thanks in advance for your help,
> 
> Guillaume.
> 
> PS: FYI during my research, I've found another similar report in bugzilla https://bugzilla.kernel.org/show_bug.cgi?id=208685

Huh.  First I have heard of it.  It looks like they hit this after about
nine days of uptime.  I have run way more than nine days of testing of
nohz_full RCU operation with rcutorture, and have never seen it myself.

Can you reproduce this?  If so, can you reproduce it on mainline kernels
(as opposed to -stable kernels as in that bugzilla)?

The theory behind that WARN_ON_ONCE() is as follows:

o	The check of rcu_seq_state(rcu_seq_current(&rnp->gp_seq))
	says that there is a grace period either in effect or just
	now ending.

o	In the latter case, the grace-period cleanup has not yet
	reached the current rcu_node structure, which means that
	it has not yet checked to see if another grace period
	is needed.

o	Either way, the RCU_GP_FLAG_INIT will cause the next grace
	period to start.  (This flag is protected by the root
	rcu_node structure's ->lock.)

Again, can you reproduce this, especially in mainline?

							Thanx, Paul
