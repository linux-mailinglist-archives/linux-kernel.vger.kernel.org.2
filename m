Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FEC37194F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 18:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhECQdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 12:33:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231182AbhECQdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 12:33:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1860E611AE;
        Mon,  3 May 2021 16:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620059570;
        bh=QTzchORJulSOFGHbgrOpsW5Aa1pjTXf6cVwUx0HhGCc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cycEVgaTuT5m9GKQhAXj9weAF+yCZArQ+fKu7Lxpj2J3h5H5P33oFomgUpVkec73A
         JsS9Jp8ipgvdxzDoaK/nr+OxPEWxdIzZoxSyQC2Oy2xOZhmYLyAjP35VdsBbx+XUEj
         z2WEcj6AIS7g23Ch2dQwuQTXjxuWdyr4+axfE5SU4IuNTt9Enl8Ebw7Bc/WXPX4KYu
         ZXjNQwBuZDVfatcr7TcAx0YeoMuhTF5L4594TUvK6RReIbxqgS+1y0YP4186VK2NzG
         KrBrYP7qYeAsiW7bVkaGUme6ltb62OvrMRMd4lIVvC90KmW/aposID3vHouVdo3Rh1
         /1a4BdDxzLTuQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A8B185C034B; Mon,  3 May 2021 09:32:49 -0700 (PDT)
Date:   Mon, 3 May 2021 09:32:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Linux-MM <linux-mm@kvack.org>,
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
Message-ID: <20210503163249.GW975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <eee7431c-3dc8-ca3c-02fb-9e059d30e951@kernel.org>
 <20210428145823.GA856@lespinasse.org>
 <CALCETrVRGtVqv9cMSryfg5q3iZ9s3jBey20cY4K23YLRhQRzbQ@mail.gmail.com>
 <20210428161108.GP975577@paulmck-ThinkPad-P17-Gen-1>
 <20210429000225.GC10973@lespinasse.org>
 <20210429155250.GV975577@paulmck-ThinkPad-P17-Gen-1>
 <20210429183412.GA278623@paulmck-ThinkPad-P17-Gen-1>
 <20210429211758.GE10973@lespinasse.org>
 <20210503034049.GQ975577@paulmck-ThinkPad-P17-Gen-1>
 <20210503043430.GA16059@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503043430.GA16059@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2021 at 09:34:30PM -0700, Michel Lespinasse wrote:
> On Sun, May 02, 2021 at 08:40:49PM -0700, Paul E. McKenney wrote:
> > @@ -634,6 +644,12 @@ do {									      \
> >   * sections, invocation of the corresponding RCU callback is deferred
> >   * until after the all the other CPUs exit their critical sections.
> >   *
> > + * In recent kernels, synchronize_rcu() and call_rcu() also wait for
> > + * regions of code with preemption disabled, including regions of code
> > + * with interrupts or softirqs disabled.  If your kernel is old enough
> > + * for synchronize_sched() to be defined, only code enclosed within
> > + * rcu_read_lock() and rcu_read_unlock() are guaranteed to be waited for.
> > + *
> >   * Note, however, that RCU callbacks are permitted to run concurrently
> >   * with new RCU read-side critical sections.  One way that this can happen
> >   * is via the following sequence of events: (1) CPU 0 enters an RCU
> 
> You still have "old enough" / "recent kernels" here. But maybe it's OK
> given that you added relevant version numbers elsewhere.
> 
> Everything else looks great to me.

Good point!  Like this?

							Thanx, Paul

------------------------------------------------------------------------

commit fd8393a2a8a5ffd25d0766abb262137c36bda9f3
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Mon May 3 09:32:14 2021 -0700

    fixup! rcu: Improve comments describing RCU read-side critical sections
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 901ab6fa252b..323954363389 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -644,11 +644,11 @@ do {									      \
  * sections, invocation of the corresponding RCU callback is deferred
  * until after the all the other CPUs exit their critical sections.
  *
- * In recent kernels, synchronize_rcu() and call_rcu() also wait for
- * regions of code with preemption disabled, including regions of code
- * with interrupts or softirqs disabled.  If your kernel is old enough
- * for synchronize_sched() to be defined, only code enclosed within
- * rcu_read_lock() and rcu_read_unlock() are guaranteed to be waited for.
+ * In v5.0 and later kernels, synchronize_rcu() and call_rcu() also
+ * wait for regions of code with preemption disabled, including regions of
+ * code with interrupts or softirqs disabled.  In pre-v5.0 kernels, which
+ * define synchronize_sched(), only code enclosed within rcu_read_lock()
+ * and rcu_read_unlock() are guaranteed to be waited for.
  *
  * Note, however, that RCU callbacks are permitted to run concurrently
  * with new RCU read-side critical sections.  One way that this can happen
