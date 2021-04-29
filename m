Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EED36F1D6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbhD2VSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:18:46 -0400
Received: from server.lespinasse.org ([63.205.204.226]:40475 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237306AbhD2VSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:18:45 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1619731078; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=ihhm4JDgRp4tsnb14+du7QsA3Ya60duhO1ZG+MsWcoY=;
 b=blEo8AgOgCdrZC3Y1y9NVvbVSbqLNKi48emijN0hwv0/FoHa9fQ/EtBnujraMgT6QcKtC
 tQAkWdyK8i2aLU3CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1619731078; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=ihhm4JDgRp4tsnb14+du7QsA3Ya60duhO1ZG+MsWcoY=;
 b=wjXPd0NVVBvXaYyvlEuyVQBantMV2nDbFVPwGi65KvG87kUx0E6Cvr/gtDtD2ewYUJ19/
 i3md/30LYA+z0FbxJQMTLDe8gbiI6SOFzrEbmrV8eZVqo73MM2lDeoUdrhpLoYyks9mCQGY
 gZmjxy6S92ErTOHMjAcSM6aHACLdSzOc8j1bYkyQFbHFuKJREmuf28kozwCold9RIN1s8Mr
 jYFro8S9Jo6tvn7HNQrNm9iV44S9zX0AqbIkkMlzdETW+p7zR8t1S4122KgAOXCZR4Z6Nrg
 8aXajyB1EJZoUjh2C1kqbK7J8ke923I4b6jDicAbZgfrFx47Ty05fjUcPPEA==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 83604160309; Thu, 29 Apr 2021 14:17:58 -0700 (PDT)
Date:   Thu, 29 Apr 2021 14:17:58 -0700
From:   Michel Lespinasse <michel@lespinasse.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Rom Lemarchand <romlem@google.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 13/37] mm: implement speculative handling in
 __handle_mm_fault().
Message-ID: <20210429211758.GE10973@lespinasse.org>
References: <20210407014502.24091-1-michel@lespinasse.org>
 <20210407014502.24091-14-michel@lespinasse.org>
 <eee7431c-3dc8-ca3c-02fb-9e059d30e951@kernel.org>
 <20210428145823.GA856@lespinasse.org>
 <CALCETrVRGtVqv9cMSryfg5q3iZ9s3jBey20cY4K23YLRhQRzbQ@mail.gmail.com>
 <20210428161108.GP975577@paulmck-ThinkPad-P17-Gen-1>
 <20210429000225.GC10973@lespinasse.org>
 <20210429155250.GV975577@paulmck-ThinkPad-P17-Gen-1>
 <20210429183412.GA278623@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429183412.GA278623@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 11:34:12AM -0700, Paul E. McKenney wrote:
> ------------------------------------------------------------------------
> 
> commit 97262c64c2cf807bf06825e454c4bedd228fadfb
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Thu Apr 29 11:18:01 2021 -0700
> 
>     rcu: Improve comments describing RCU read-side critical sections
>     
>     There are a number of places that call out the fact that preempt-disable
>     regions of code now act as RCU read-side critical sections, where
>     preempt-disable regions of code include irq-disable regions of code,
>     bh-disable regions of code, hardirq handlers, and NMI handlers.  However,
>     someone relying solely on (for example) the call_rcu() header comment
>     might well have no idea that preempt-disable regions of code have RCU
>     semantics.
>     
>     This commit therefore updates the header comments for
>     call_rcu(), synchronize_rcu(), rcu_dereference_bh_check(), and
>     rcu_dereference_sched_check() to call out these new(ish) forms of RCU
>     readers.
>     
>     Reported-by: Michel Lespinasse <michel@lespinasse.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index a10480f2b4ef..c01b04ad64c4 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -532,7 +532,10 @@ do {									      \
>   * @p: The pointer to read, prior to dereferencing
>   * @c: The conditions under which the dereference will take place
>   *
> - * This is the RCU-bh counterpart to rcu_dereference_check().
> + * This is the RCU-bh counterpart to rcu_dereference_check().  However,
> + * please note that in recent kernels, synchronize_rcu() waits for
> + * local_bh_disable() regions of code in addition to regions of code
> + * demarked by rcu_read_lock() and rcu_read_unlock().

Two things:
- "recent kernels" could be clarified, as Matthew pointed out
- The above is not 100% clear if call_rcu() also waits for
  local_bh_disable() regions of code ? (you did clarify this in tree.c
  but I think it's better to have that here as well)

>   */
>  #define rcu_dereference_bh_check(p, c) \
>  	__rcu_dereference_check((p), (c) || rcu_read_lock_bh_held(), __rcu)
> @@ -543,6 +546,9 @@ do {									      \
>   * @c: The conditions under which the dereference will take place
>   *
>   * This is the RCU-sched counterpart to rcu_dereference_check().
> + * However, please note that in recent kernels, synchronize_rcu() waits
> + * for preemption-disabled regions of code in addition to regions of code
> + * demarked by rcu_read_lock() and rcu_read_unlock().

Same comments regarding "recent kernels" and call_rcu() here.

>   */
>  #define rcu_dereference_sched_check(p, c) \
>  	__rcu_dereference_check((p), (c) || rcu_read_lock_sched_held(), \
> @@ -634,6 +640,12 @@ do {									      \
>   * sections, invocation of the corresponding RCU callback is deferred
>   * until after the all the other CPUs exit their critical sections.
>   *
> + * In recent kernels, synchronize_rcu() and call_rcu() also wait for
> + * regions of code with preemption disabled, including regions of code
> + * with interrupts or softirqs disabled.  If your kernel is old enough
> + * for synchronize_sched() to be defined, only code enclosed within
> + * rcu_read_lock() and rcu_read_unlock() are guaranteed to be waited for.
> + *

Thanks, this is the quote I was looking for, and also I think it's
important for it to be in rcupdate.h rather than any .c implementation
(I think it's more natural to look at headers for this kind of stuff).

Same comment regarding "old enough" / "recent kernels" though.

>   * Note, however, that RCU callbacks are permitted to run concurrently
>   * with new RCU read-side critical sections.  One way that this can happen
>   * is via the following sequence of events: (1) CPU 0 enters an RCU
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c

The tree.c changes look fine to me.

Thanks a lot for looking into this !

--
Michel "walken" Lespinasse
