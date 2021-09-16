Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9B140E6FF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352735AbhIPR11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:27:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351467AbhIPRRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:17:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10BBD61B5F;
        Thu, 16 Sep 2021 16:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631810438;
        bh=sTifjE5aoQHT9IENncf6l5QV7jqLPD4tygDnE4TPoEc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XcNQuRulG0Bz8OhygC96xsjCzNwD+tMlXDH123iAu1uyCAow6QoZnHRvwEORU+wBv
         lXRPD1afWir0uqFtaeaDdFMof4FT2pAHn6+ZzZhQH04gIVfgiQstjyMz/R3EeC6yDY
         7ecaNkR1grB7C9pGJpFNIIfzXc9ISdRUQWZ0naZ6eKmrPnuEIaGwI6/qy5Wtrl8kvQ
         fRdv2YDxX40U90/+klu9bsWGTEA4XXcvhY+b0O99FX3FOTP/X4IwdquhpV6fNiinA4
         vt36V+hbr86c2BFwxeoWGo8S8rbO4XdrxyIk2II96mNEyUKFqHGyNP0NM/JE6Ol0G0
         7SKgo//umQwCg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CCF9A5C028C; Thu, 16 Sep 2021 09:40:37 -0700 (PDT)
Date:   Thu, 16 Sep 2021 09:40:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        urezki@gmail.com, boqun.feng@gmail.com,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        joel@joelfernandes.org
Subject: Re: [PATCH 0/4] rcu: Unify a bit [non-]PREEMPT expedited quiescent
 state report
Message-ID: <20210916164037.GE4156@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210916121048.36623-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916121048.36623-1-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 02:10:44PM +0200, Frederic Weisbecker wrote:
> This eventually removes rcu_data.exp_deferred_qs to use
> rcu_data.cpu no_qs.b.exp instead.
> 
> For those like me who need a headlamp to walk there: https://ibb.co/3d06r0V

Can't have too many headlamps with this code!  ;-)

							Thanx, Paul

> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	rcu/dev
> 
> HEAD: 7d9d8a0c6141f95cbac4367b12e755bfabb383ee
> 
> Thanks,
> 	Frederic
> ---
> 
> Frederic Weisbecker (4):
>       rcu: Ignore rdp.cpu_no_qs.b.exp on premptible RCU's rcu_qs()
>       rcu: Remove useless WRITE_ONCE() on rcu_data.exp_deferred_qs
>       rcu: Move rcu_data.cpu_no_qs.b.exp reset to rcu_export_exp_rdp()
>       rcu: Remove rcu_data.exp_deferred_qs and convert to rcu_data.cpu no_qs.b.exp
> 
> 
>  kernel/rcu/tree.h        |  1 -
>  kernel/rcu/tree_exp.h    |  6 +++---
>  kernel/rcu/tree_plugin.h | 24 +++++++++++++-----------
>  3 files changed, 16 insertions(+), 15 deletions(-)
