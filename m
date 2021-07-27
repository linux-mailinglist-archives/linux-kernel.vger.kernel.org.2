Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE89D3D7AC9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 18:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhG0QSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 12:18:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhG0QSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 12:18:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BDA961B5F;
        Tue, 27 Jul 2021 16:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627402685;
        bh=IpjnQxpo2H5Oqz+TcYPmeFc383PvQoiuPpIxOqaJwPA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=OV4Yj0zUfEuaLJI4XG+Nan1nlQo7bKOw+FQNdpkw805XmfPPK0z16xDhda2kWw+EL
         sW1vuI1jhdA3fYGHvgD/bPrSjLcdsVguNbMP0vVcbKdZbn5uM7f1FN3aPttgkoHx/Q
         gKx/rBPSCbO0+4uJJIDSpFfMqDCFAte0bW+ak4YLVgjWlPJ4uzz6NSSlwcMLFJgMyU
         nCzi+kifa73c4DLZT2XyY0a7Rf1rnqklgDLF1rEjvnf0qJQLwrK/mmbreXKaS5wuUw
         WmdRqQZAj3ZdY495r+Dwqq+dhKRiBbJvinc0lEjcBkfHAqkoaKeVc7emGMeI7CwFAe
         195ZmGdKT0ymg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 663A65C099F; Tue, 27 Jul 2021 09:18:05 -0700 (PDT)
Date:   Tue, 27 Jul 2021 09:18:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Metzmacher <metze@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] Fix: tracepoint: rcu get state and cond sync for
 static call updates
Message-ID: <20210727161805.GY4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210727150613.20886-1-mathieu.desnoyers@efficios.com>
 <20210727150613.20886-4-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727150613.20886-4-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 11:06:13AM -0400, Mathieu Desnoyers wrote:
> State transitions from 1->0->1 and N->2->1 callbacks require RCU
> synchronization. Rather than performing the RCU synchronization every
> time the state change occurs, which is quite slow when many tracepoints
> are registered in batch, instead keep a snapshot of the RCU state on the
> most recent transitions which belong to a chain, and conditionally wait
> for a grace period on the last transition of the chain if one g.p. has
> not elapsed since the last snapshot.
> 
> This applies to both RCU and SRCU.
> 
> [ Build tested only. ]
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Looks plausible from an RCU viewpoint.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/tracepoint.c | 89 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 77 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index a85e7dc8b490..82f37045cd2b 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -28,6 +28,49 @@ extern tracepoint_ptr_t __stop___tracepoints_ptrs[];
>  DEFINE_SRCU(tracepoint_srcu);
>  EXPORT_SYMBOL_GPL(tracepoint_srcu);
>  
> +enum tp_transition_sync {
> +	TP_TRANSITION_SYNC_1_0_1,
> +	TP_TRANSITION_SYNC_N_2_1,
> +
> +	_NR_TP_TRANSITION_SYNC,
> +};
> +
> +struct tp_transition_snapshot {
> +	unsigned long rcu;
> +	unsigned long srcu;
> +	bool ongoing;
> +};
> +
> +/* Protected by tracepoints_mutex */
> +static struct tp_transition_snapshot tp_transition_snapshot[_NR_TP_TRANSITION_SYNC];
> +
> +static void tp_rcu_get_state(enum tp_transition_sync sync)
> +{
> +	struct tp_transition_snapshot *snapshot = &tp_transition_snapshot[sync];
> +
> +	/* Keep the latest get_state snapshot. */
> +	snapshot->rcu = get_state_synchronize_rcu();
> +	snapshot->srcu = start_poll_synchronize_srcu(&tracepoint_srcu);
> +	snapshot->ongoing = true;
> +}
> +
> +static void tp_rcu_clear_ongoing(enum tp_transition_sync sync)
> +{
> +	tp_transition_snapshot[sync].ongoing = false;
> +}
> +
> +static void tp_rcu_cond_sync(enum tp_transition_sync sync)
> +{
> +	struct tp_transition_snapshot *snapshot = &tp_transition_snapshot[sync];
> +
> +	if (!snapshot->ongoing)
> +		return;
> +	cond_synchronize_rcu(snapshot->rcu);
> +	if (!poll_state_synchronize_srcu(&tracepoint_srcu, snapshot->srcu))
> +		synchronize_srcu(&tracepoint_srcu);
> +	snapshot->ongoing = false;
> +}
> +
>  /* Set to 1 to enable tracepoint debug output */
>  static const int tracepoint_debug;
>  
> @@ -311,6 +354,11 @@ static int tracepoint_add_func(struct tracepoint *tp,
>  	 */
>  	switch (nr_func_state(tp_funcs)) {
>  	case TP_FUNC_1:		/* 0->1 */
> +		/*
> +		 * Make sure new static func never uses old data after a
> +		 * 1->0->1 transition sequence.
> +		 */
> +		tp_rcu_cond_sync(TP_TRANSITION_SYNC_1_0_1);
>  		/* Set static call to first function */
>  		tracepoint_update_call(tp, tp_funcs);
>  		/* Both iterator and static call handle NULL tp->funcs */
> @@ -326,9 +374,21 @@ static int tracepoint_add_func(struct tracepoint *tp,
>  		 * static call update/call.
>  		 */
>  		rcu_assign_pointer(tp->funcs, tp_funcs);
> +		/*
> +		 * Make sure static func never uses incorrect data after a
> +		 * 1->...->2->1 transition sequence.
> +		 */
> +		if (tp_funcs[0].data != old[0].data)
> +			tp_rcu_get_state(TP_TRANSITION_SYNC_N_2_1);
>  		break;
>  	case TP_FUNC_N:		/* N->N+1 (N>1) */
>  		rcu_assign_pointer(tp->funcs, tp_funcs);
> +		/*
> +		 * Make sure static func never uses incorrect data after a
> +		 * N->...->2->1 (N>1) transition sequence.
> +		 */
> +		if (tp_funcs[0].data != old[0].data)
> +			tp_rcu_get_state(TP_TRANSITION_SYNC_N_2_1);
>  		break;
>  	default:
>  		WARN_ON_ONCE(1);
> @@ -372,29 +432,34 @@ static int tracepoint_remove_func(struct tracepoint *tp,
>  		/* Both iterator and static call handle NULL tp->funcs */
>  		rcu_assign_pointer(tp->funcs, NULL);
>  		/*
> -		 * Make sure new func never uses old data after a 1->0->1
> -		 * transition sequence.
> -		 * Considering that transition 0->1 is the common case
> -		 * and don't have rcu-sync, issue rcu-sync after
> -		 * transition 1->0 to break that sequence by waiting for
> -		 * readers to be quiescent.
> +		 * Make sure new static func never uses old data after a
> +		 * 1->0->1 transition sequence.
>  		 */
> -		tracepoint_synchronize_unregister();
> +		tp_rcu_get_state(TP_TRANSITION_SYNC_1_0_1);
>  		break;
>  	case TP_FUNC_1:		/* 2->1 */
>  		rcu_assign_pointer(tp->funcs, tp_funcs);
>  		/*
> -		 * On 2->1 transition, RCU sync is needed before setting
> -		 * static call to first callback, because the observer
> -		 * may have loaded any prior tp->funcs after the last one
> -		 * associated with an rcu-sync.
> +		 * Make sure static func never uses incorrect data after a
> +		 * N->...->2->1 (N>2) transition sequence.
>  		 */
> -		tracepoint_synchronize_unregister();
> +		if (tp_funcs[0].data != old[0].data) {
> +			tracepoint_synchronize_unregister();
> +			tp_rcu_clear_ongoing(TP_TRANSITION_SYNC_N_2_1);
> +		} else {
> +			tp_rcu_cond_sync(TP_TRANSITION_SYNC_N_2_1);
> +		}
>  		/* Set static call to first function */
>  		tracepoint_update_call(tp, tp_funcs);
>  		break;
>  	case TP_FUNC_N:		/* N->N-1 (N>2) */
>  		rcu_assign_pointer(tp->funcs, tp_funcs);
> +		/*
> +		 * Make sure static func never uses incorrect data after a
> +		 * N->...->2->1 (N>2) transition sequence.
> +		 */
> +		if (tp_funcs[0].data != old[0].data)
> +			tp_rcu_get_state(TP_TRANSITION_SYNC_N_2_1);
>  		break;
>  	default:
>  		WARN_ON_ONCE(1);
> -- 
> 2.20.1
> 
