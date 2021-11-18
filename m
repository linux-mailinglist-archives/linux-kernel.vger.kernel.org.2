Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2344562A6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 19:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbhKRSoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 13:44:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29060 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233730AbhKRSoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 13:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637260896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H/2EXvjEWRBka07ANn93tEZDf/F6ZMhQQB8oMKQppL8=;
        b=Eham2C36VqRVjrOfgnLf8BurlG0dlC4d2CuzSp7mN8MBxMO9t1CxGWWrskVWRQTRq7j9LN
        tUTWrfZlOJCGSAcP218JM50kQKJr8djyBWWMcEhVEPxPAHl7xe6z1VXXa4qm4V9FZyRy25
        xqvax5aUZovjhwQOXxZ2rXOotBr2Vko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-200-yqNnAm96M0uBgYYUQKObRw-1; Thu, 18 Nov 2021 13:41:32 -0500
X-MC-Unique: yqNnAm96M0uBgYYUQKObRw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CD77802B78;
        Thu, 18 Nov 2021 18:41:31 +0000 (UTC)
Received: from metal.redhat.com (unknown [10.40.193.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF19160BF1;
        Thu, 18 Nov 2021 18:41:29 +0000 (UTC)
From:   Daniel Vacek <neelx@redhat.com>
To:     paulmck@kernel.org
Cc:     guillaume@morinfr.org, linux-kernel@vger.kernel.org
Subject: Re: call_rcu data race patch
Date:   Thu, 18 Nov 2021 19:41:28 +0100
Message-Id: <20211118184128.1335912-1-neelx@redhat.com>
In-Reply-To: <20210927161046.GU880162@paulmck-ThinkPad-P17-Gen-1>
References: <20210927161046.GU880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2021 15:07:00 -0700, Paul E. McKenney wrote:
> OK, please see below.  This is a complete shot in the dark, but could
> potentially prevent the problem.  Or make it worse, which would at the
> very least speed up debugging.  It might needs a bit of adjustment to
> apply to the -stable kernels, but at first glance should apply cleanly.
> 
> Oh, and FYI I am having to manually paste your email address into the To:
> line in order to get this to go back to you.  Please check your email
> configuration.
> 
> Which might mean that you need to pull this from my -rcu tree here:
> 
> 1a792b59071b ("EXP rcu: Tighten rcu_advance_cbs_nowake() checks")
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 6a1e9d3374db..6d692a591f66 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1590,10 +1590,14 @@ static void __maybe_unused rcu_advance_cbs_nowake(struct rcu_node *rnp,
>  						  struct rcu_data *rdp)
>  {
>  	rcu_lockdep_assert_cblist_protected(rdp);
> -	if (!rcu_seq_state(rcu_seq_current(&rnp->gp_seq)) ||
> +	// Don't do anything unless the current grace period is guaranteed
> +	// not to end.  This means a grace period in progress and at least
> +	// one holdout CPU.
> +	if (!rcu_seq_state(rcu_seq_current(&rnp->gp_seq)) || !READ_ONCE(rnp->qsmask) ||
>  	    !raw_spin_trylock_rcu_node(rnp))
>  		return;
> -	WARN_ON_ONCE(rcu_advance_cbs(rnp, rdp));
> +	if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq)) && READ_ONCE(rnp->qsmask))
> +		WARN_ON_ONCE(rcu_advance_cbs(rnp, rdp));
>  	raw_spin_unlock_rcu_node(rnp);
>  }
>  

Hello Paul,

We've received a few reports of this warning. Reviewing the code I don't really
see any reason for the READ_ONCE(rnp->qsmask) part here and hence I started
tracing the data before applying the patch to see the actual values before
and after the lock is acquired to better understand the situation.

This can be done with a short bash script:

~~~
perf probe 'prelock1=rcu_advance_cbs_nowake+0x29 gp_seq=%ax:x64 rnp->qsmask rnp->lock'			# gp_seq from register after the condition check so this one will always be &3!=0
perf probe 'prelock2=rcu_advance_cbs_nowake+0x2c rnp->gp_seq    rnp->qsmask rnp->lock'			# gp_seq refetched from memory. it could already be &0x3==0
perf probe 'acquired=rcu_advance_cbs_nowake+0x35 rnp->gp_seq    rnp->qsmask rnp->lock'			# gp_seq refetched again after taking the lock, ditto - which is bug
perf probe 'warning_=rcu_advance_cbs_nowake+0x40 rnp->gp_seq    rnp->qsmask rnp->lock condition=%ax:s8'	# 'condition' is the return value from rcu_advance_cbs() call
trace-cmd stream \
	-e probe:prelock1 \
	-e probe:prelock2 -f '!gp_seq&3' \
	-e probe:acquired -f '!gp_seq&3' \
	-e probe:warning_ -f condition==1
~~~

The best part is that adding the kprobes opened the race window so that with
the tracing enabled I could reproduce the bug in matter of seconds on my VM.
One 'top' on an idle system is enough to hit it, though to accelerate I was
using a bunch of them (but still just enough so that the machine remains
mostly idle - the VM has 8 vCPUs):

# for i in {1..40}; do top -b -d 0.1 >/dev/null & done	# kill %{1..40}

Note, that 'rcu_nocbs=1-7' kernel option needs to be used otherwise
rcu_advance_cbs_nowake() is not even beeing called at all as well as there
are no offload threads it could race with.

The results show that indeed (confirming the code review) the node qsmask can
be zero while still there is no warning and no subsequent stall. As long as
rcu_seq_state(...) is true, everything is fine.

Only when the GP state check is true before taking the lock and false after
acquiring it is when rcu_advance_cbs() returns with true and the system is
doomed (with the warning warmly announcing it) as the 'rcu_sched' thread is
never woken again. The system will eventually run out of memory or the tasks
get blocked on synchronize_rcu() indefinitely.

With this observation I was confident enough to finally apply just the grace
period part of your patch (below). After that the system survived 12 hours
over night. Since I could reproduce in matter of seconds before I call it a
success.

So what is your opinion about the quiescent state mask part? Is it needed or
rather really redundant? Perhaps upstream differs to RHEL kernel but on RHEL
I don't really see the need and the below patch is sufficient IMO.

Or perhaps I'm missing the part where the qsmask check is not really needed
but it's just an optimization because in that case we do not need to advance
the callbacks here as they will be advanced soon anyways?

With or without the qsmask part, in both cases I believe this should go to
stable 5.4+ and of course we want it in RHEL asap, so once Linus merges a
version of it, we are going to backport. Since this is only reproducible
with the 'rcu_nocbs' option I understand that the v5.17 merge window is
a reasonable target for upstream. Nevertheless this is still a bugfix.

--nX

----

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1aebb2dfbf90..96df7f68ff4d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1389,7 +1389,8 @@ static void __maybe_unused rcu_advance_cbs_nowake(struct rcu_node *rnp,
 	if (!rcu_seq_state(rcu_seq_current(&rnp->gp_seq)) ||
 	    !raw_spin_trylock_rcu_node(rnp))
 		return;
-	WARN_ON_ONCE(rcu_advance_cbs(rnp, rdp));
+	if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq)))
+		WARN_ON_ONCE(rcu_advance_cbs(rnp, rdp));
 	raw_spin_unlock_rcu_node(rnp);
 }
 
-- 

