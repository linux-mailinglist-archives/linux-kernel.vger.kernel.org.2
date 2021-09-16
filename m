Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E2240E781
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 19:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348051AbhIPRde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:33:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348146AbhIPRX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:23:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EE8961BD1;
        Thu, 16 Sep 2021 16:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631810620;
        bh=s/eE8MQCbRlB/JbAF45EWPTDmeJAF5NuQ61zEC913j8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ha3kQcDSm0xzs+5Sf6sq84zgdcKeE8mziK5GvCAiLEafrYXOcSnITqmLtd6LfAidG
         4Or/y6oX8N6gP5Pi6Dbf2gS+O7pNbFR4PSoyRsUO2CxZqlmfMafXchVfYRsID4ekzk
         K/lL/QWvD0fMduiTlZN+j9Hm5bPRMwkIybOdgznJYnhTCw+wN7GFKBhLstu/gUnVRT
         KOFziDKuRzqUfZhtVGUYq3x2seitW1EeTvkh7S+nGWccFpNvi75q3Yx0l5eNPSFDIN
         /5Epp9G9RB0HDpRRUvnHIboFcw6liRhpjBnJrwldnILsUt1CpPNev/NcTHGdkD+7sd
         9eAPgqbVeeEqA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 584E35C028C; Thu, 16 Sep 2021 09:43:40 -0700 (PDT)
Date:   Thu, 16 Sep 2021 09:43:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        urezki@gmail.com, boqun.feng@gmail.com,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        joel@joelfernandes.org
Subject: Re: [PATCH 2/4] rcu: Remove useless WRITE_ONCE() on
 rcu_data.exp_deferred_qs
Message-ID: <20210916164340.GF4156@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210916121048.36623-1-frederic@kernel.org>
 <20210916121048.36623-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916121048.36623-3-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 02:10:46PM +0200, Frederic Weisbecker wrote:
> This variable is never written nor read remotely. Remove this confusion.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/tree_exp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index f3947c49eee7..4266610b4587 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -255,7 +255,7 @@ static void rcu_report_exp_cpu_mult(struct rcu_node *rnp,
>   */
>  static void rcu_report_exp_rdp(struct rcu_data *rdp)
>  {
> -	WRITE_ONCE(rdp->exp_deferred_qs, false);
> +	rdp->exp_deferred_qs = false;

Are you sure that this can never be invoked from an interrupt handler?
And that rdp->exp_deferred_qs is never read from an interrupt handler?
If either can happen, then the WRITE_ONCE() does play a role, right?

							Thanx, Paul

>  	rcu_report_exp_cpu_mult(rdp->mynode, rdp->grpmask, true);
>  }
>  
> -- 
> 2.25.1
> 
