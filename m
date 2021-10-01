Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71EB41F304
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355262AbhJAR0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354872AbhJAR0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:26:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DFFC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 10:24:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633109086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yViK6IRWpYOTL5KK3NmFsjuoYurx4i5ZJJgh+qEaon4=;
        b=VwYFzaW3EYvsDyZzJfnddn8R8+bbxkFCRrioZsW/LDyA9qMGLqlBjaJPchqT+7ZNga52EE
        Jml47zs6IZL3Ji/ee7RvCMCtcP1vweaBQgcXNdsUWGcHeroz/1rBjXDPaVSRQtnmCdglef
        WWdx73F/lJrNC4qWbHFOWYxi4whwWmd4u8BFUdGKPunu9dsoQz13Ifq55S0W+pCoSJxLbq
        m/ao/YGX3u22lVJ+iaglBt5l4y0tBARfimp0GBCFacC+W/qBYMkqPr6mDQUE+SuuC8XFUT
        bmM7wfnQm9YGUAz+rpk0EG7B0qs00mRCNgw0z2W/KYlSvmhJGDRwA8Fqi8FiAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633109086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yViK6IRWpYOTL5KK3NmFsjuoYurx4i5ZJJgh+qEaon4=;
        b=Bys+mzdFPmjhc6gfr9BDTo6AJvT4hALjIZ9MvLDJV8EA37kwYVwWZ+O840T90H1B0XIuBN
        BxHncAj+2rlwj5Aw==
To:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [patch 4/5] sched: Delay task stack freeing on RT
In-Reply-To: <CALCETrVP3asoqWyNqEe+rDs+YECd9gnp9eFb1==X0140oMZ41g@mail.gmail.com>
References: <20210928122339.502270600@linutronix.de>
 <20210928122411.593486363@linutronix.de>
 <YVRT6QbX5zwiIJkI@hirez.programming.kicks-ass.net>
 <CALCETrVP3asoqWyNqEe+rDs+YECd9gnp9eFb1==X0140oMZ41g@mail.gmail.com>
Date:   Fri, 01 Oct 2021 19:24:45 +0200
Message-ID: <87o8884q02.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01 2021 at 09:12, Andy Lutomirski wrote:
> On Wed, Sep 29, 2021 at 4:54 AM Peter Zijlstra <peterz@infradead.org> wrote:
>> Having this logic split across two files seems unfortunate and prone to
>> 'accidents'. Is there a real down-side to unconditionally doing it in
>> delayed_put_task_struct() ?
>>
>> /me goes out for lunch... meanwhile tglx points at: 68f24b08ee89.
>>
>> Bah.. Andy?
>
> Could we make whatever we do here unconditional?

Sure. I just was unsure about your reasoning in 68f24b08ee89.

> And what actually causes the latency?  If it's vfree, shouldn't the
> existing use of vfree_atomic() in free_thread_stack() handle it?  Or
> is it the accounting?

The accounting muck because it can go into the allocator and sleep in
the worst case, which is nasty even on !RT kernels.

But thinking some more, there is actually a way nastier issue on RT in
the following case:

CPU 0                           CPU 1
  T1                            
  spin_lock(L1)
  rt_mutex_lock()
      schedule()

  T2
     do_exit()
     do_task_dead()             spin_unlock(L1)
                                   wake(T1)
     __schedule()                           
       switch_to(T1)
       finish_task_switch()
         put_task_stack()
           account()
             ....
             spin_lock(L2)

So if L1 == L2 or L1 and L2 have a reverse dependency then this can just
deadlock.

We've never observed that, but the above case is obviously hard to
hit. Nevertheless it's there.

Thanks,

        tglx
