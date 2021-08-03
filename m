Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD393DF321
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 18:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237247AbhHCQsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 12:48:43 -0400
Received: from smtprelay0201.hostedemail.com ([216.40.44.201]:60542 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236939AbhHCQsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 12:48:40 -0400
Received: from omf17.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 5BB41837F24C;
        Tue,  3 Aug 2021 16:48:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 8C25327DD31;
        Tue,  3 Aug 2021 16:48:24 +0000 (UTC)
Message-ID: <5a494dd8d0e04030204f61067cb1010ef0c78f27.camel@perches.com>
Subject: Re: [PATCH rcu 15/18] rcu: Remove useless "ret" update in
 rcu_gp_fqs_loop()
From:   Joe Perches <joe@perches.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Liu Song <liu.song11@zte.com.cn>
Date:   Tue, 03 Aug 2021 09:48:23 -0700
In-Reply-To: <20210721202127.2129660-15-paulmck@kernel.org>
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
         <20210721202127.2129660-15-paulmck@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.65
X-Stat-Signature: kp19h6n7f9kgx7uxnh7wia3abcfefwce
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 8C25327DD31
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1857Ov4ju+xuMB8Jet2sOrcvo+xjK4vwSs=
X-HE-Tag: 1628009304-571790
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-07-21 at 13:21 -0700, Paul E. McKenney wrote:
> From: Liu Song <liu.song11@zte.com.cn>
> 
> Within rcu_gp_fqs_loop(), the "ret" local variable is set to the
> return value from swait_event_idle_timeout_exclusive(), but "ret" is
> unconditionally overwritten later in the code.  This commit therefore
> removes this useless assignment.
[]
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
[]
> @@ -1960,8 +1960,8 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
>  		trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
>  				       TPS("fqswait"));
>  		WRITE_ONCE(rcu_state.gp_state, RCU_GP_WAIT_FQS);
> -		ret = swait_event_idle_timeout_exclusive(
> -				rcu_state.gp_wq, rcu_gp_fqs_check_wake(&gf), j);
> +		(void)swait_event_idle_timeout_exclusive(rcu_state.gp_wq,
> +				 rcu_gp_fqs_check_wake(&gf), j);

It doesn't seem this is a __must_check routine so why
bother to cast to void ?

>  		rcu_gp_torture_wait();
>  		WRITE_ONCE(rcu_state.gp_state, RCU_GP_DOING_FQS);
>  		/* Locking provides needed memory barriers. */


