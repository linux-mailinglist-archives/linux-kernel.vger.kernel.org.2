Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B323710EF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 06:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhECEfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 00:35:23 -0400
Received: from server.lespinasse.org ([63.205.204.226]:58935 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhECEfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 00:35:23 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-14-ed;
 t=1620016470; h=date : from : to : cc : subject : message-id :
 references : mime-version : content-type : in-reply-to : from;
 bh=IVSN4rXFsAqhRrOBaOG8oTadR0XsOpnayasis5eGn9U=;
 b=GiTjC8TtRi8A2CDiu0777x7lS1aQSG/UClzMN3PifJJ0qYNcWlGgoD08V63aSXdrhQaCD
 a0zQ+St3HpALbCICA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-14-rsa; t=1620016470; h=date :
 from : to : cc : subject : message-id : references : mime-version :
 content-type : in-reply-to : from;
 bh=IVSN4rXFsAqhRrOBaOG8oTadR0XsOpnayasis5eGn9U=;
 b=HtWQf/wqqDk6NgXnD50nv0QWm5dqjfsaZFbvL2Nw4gMOyDbtnDhWr0HW+xpDBBYtTC52O
 xek042nGdx7+Fx9JDYaqolvI6ByvUSHoVsgheAUf4SwqiKTzoHWoj128m50WOruyxmtDI/h
 tIcrAvsMACJcOWPm2Ir3rH3SMrYv5OI9CcQyHBow4g3v4oGH0DzSMmz3fEo955xd/dGneZ7
 g71w5qh/S4h+5GF8jRzyDRkjf/IcAHtrZVUalbkbGyppCNXhiRiIws6mzPCZgDUKF4OM0aA
 ztyf3YdFTvD4Cgy33gs7gSITuLuFgjF39rbxqkgctAwWXd0GcQp6HJzahL6w==
Received: by server.lespinasse.org (Postfix, from userid 1000)
        id 13274160055; Sun,  2 May 2021 21:34:30 -0700 (PDT)
Date:   Sun, 2 May 2021 21:34:30 -0700
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
Message-ID: <20210503043430.GA16059@lespinasse.org>
References: <20210407014502.24091-14-michel@lespinasse.org>
 <eee7431c-3dc8-ca3c-02fb-9e059d30e951@kernel.org>
 <20210428145823.GA856@lespinasse.org>
 <CALCETrVRGtVqv9cMSryfg5q3iZ9s3jBey20cY4K23YLRhQRzbQ@mail.gmail.com>
 <20210428161108.GP975577@paulmck-ThinkPad-P17-Gen-1>
 <20210429000225.GC10973@lespinasse.org>
 <20210429155250.GV975577@paulmck-ThinkPad-P17-Gen-1>
 <20210429183412.GA278623@paulmck-ThinkPad-P17-Gen-1>
 <20210429211758.GE10973@lespinasse.org>
 <20210503034049.GQ975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503034049.GQ975577@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2021 at 08:40:49PM -0700, Paul E. McKenney wrote:
> @@ -634,6 +644,12 @@ do {									      \
>   * sections, invocation of the corresponding RCU callback is deferred
>   * until after the all the other CPUs exit their critical sections.
>   *
> + * In recent kernels, synchronize_rcu() and call_rcu() also wait for
> + * regions of code with preemption disabled, including regions of code
> + * with interrupts or softirqs disabled.  If your kernel is old enough
> + * for synchronize_sched() to be defined, only code enclosed within
> + * rcu_read_lock() and rcu_read_unlock() are guaranteed to be waited for.
> + *
>   * Note, however, that RCU callbacks are permitted to run concurrently
>   * with new RCU read-side critical sections.  One way that this can happen
>   * is via the following sequence of events: (1) CPU 0 enters an RCU

You still have "old enough" / "recent kernels" here. But maybe it's OK
given that you added relevant version numbers elsewhere.

Everything else looks great to me.

Thanks,

--
Michel "walken" Lespinasse
