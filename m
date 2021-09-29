Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0160C41C865
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 17:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345294AbhI2PbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 11:31:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345289AbhI2Pa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:30:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF1D96147F;
        Wed, 29 Sep 2021 15:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632929355;
        bh=oELRdwNFqn1gSQWVrhAyuj7wmonefirYRjoL+Xb7EG8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jbil2RVDJYBlvywb+uhzaZxZLOXIPc1pwC+4v/18WdvpjPoSEXbxwXb/SjEuD7tdW
         OD4TBx8KvIgCiWv9dSd4yXuMFYNbj4uTS9fiYHnKSisEDZagbKdC73F4S+OfzGAeQy
         Wm/LbyHGc5H8lYaT53akm4yBTnVIxDupZhN0MzO9IW8UDuUi/iwLhc0CEoubZt5YrT
         EBtsg4ZkbmhurXuVObOMOufrB9r+bHfwUfivb6DSPomf0+xodaj9G6pD/mS0n72wR+
         3DwMdsFy1sJn6mjbH5CpPN7WoAK+fVBpot6pmgBdm3Ql+KIZ/b7jbCiWsVKIrlEqUG
         fYvtMhong6aqw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7BB5D5C04F3; Wed, 29 Sep 2021 08:29:15 -0700 (PDT)
Date:   Wed, 29 Sep 2021 08:29:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] rcu,sched: noinstr fixes
Message-ID: <20210929152915.GU880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210928084020.819856223@infradead.org>
 <20210928181559.GD880162@paulmck-ThinkPad-P17-Gen-1>
 <YVQmJqTiplH+/0qL@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVQmJqTiplH+/0qL@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 10:39:02AM +0200, Peter Zijlstra wrote:
> On Tue, Sep 28, 2021 at 11:15:59AM -0700, Paul E. McKenney wrote:
> > On Tue, Sep 28, 2021 at 10:40:20AM +0200, Peter Zijlstra wrote:
> > > A few noinstr fixes.. I'll stick the sched one in sched/urgent, Paul could you pick up the other two?
> > 
> > I queued those two, thank you!  I am guessing that you are looking for
> > me to send them ASAP.  If so, not a problem, but please confirm.
> 
> Either way works, but given syzcaller could potentially trigger these
> holes (it did find a whole bunch of 'interesting' problems in the early
> noinstr days) I'd prefer them earlier rather than later.
> 
> OTOH, the objtool patches that keep triggering them all over the place
> are still in objtool/core for the next cycle.

OK, let's split the difference, then.  Instead of the default v5.17
merge window, I will submit them to the upcoming v5.16 merge window.

							Thanx, Paul
