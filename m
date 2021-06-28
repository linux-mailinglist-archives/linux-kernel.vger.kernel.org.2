Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5D93B588A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 07:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhF1FQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 01:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbhF1FQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 01:16:42 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37F4C061767
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 22:14:15 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id n20so23858210edv.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 22:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YCETL39Rk/xw5/ylG1x0QnOb3vTiqH4XqnaerOcYwYE=;
        b=LXY4nK115g+As+8uQnn2Vb+hFrSwnR8MG45R+HKTgYQ0GEQ9r+vuD4iswCACtNoGej
         VDm62SXSH9mwm1z1tERDsvmvuNgWs1tdXE5pK59P1CYPyIgvF8Fxbh6Evwhr4FqT3K5d
         3j3Mz/CCFxch9y87BlbrwkG4Gj9IRH557y71Vm/1F1rWVU+QCR6pAjBNbUsQiu0Jf9mm
         cR8od3onAY8l4v9MFehzVMD6mpYajvjDwrGUIifGcAfVUwbz0HOBp2Vu3bqn74rq5A/X
         dbGFrbvltRP0jZGhASW6MOg0Gi+lZUyBmy9njAqZKFnVazlw58iOiQFgKHUkhwCbP7NT
         8bNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YCETL39Rk/xw5/ylG1x0QnOb3vTiqH4XqnaerOcYwYE=;
        b=iBD6L6nGASepXxs0nVBZy5DM0BFmpzHdWplSWqzRoF0nPr+4+2KOtUikGJbyhSwwwc
         0JLX2N8mCiHN1JVuLqHGu5quTzoKVYc7tk4V4WfOgJ92J6mT9lEd1JmP1tW3+AqLhxAC
         mioy+zRW3GJSFT0AjV9q+KlwnZLoU3a9eZlM4tSFLeU5l90BjYIjVWBLVugeNEPDepXS
         RJE0VV+u+TV/ViUm6L9KWygx6ZCbrlG81geLnddMwUdphU0hPnoErIMPMH0BFOR9tqJ7
         scaJvhUtfpLYnN0qt5+GyK3+ucrtmrBjoPkpHkuH3XetySbNl6nqmWdIUzsfj7BCJ+92
         Qkwg==
X-Gm-Message-State: AOAM530Xs8/vBP/rGGZp3GwN0xEuUOGhcywXrYLP1gVKXHqXvK5rCSF/
        9Jeyqot40R7zoZotA0nbpYA=
X-Google-Smtp-Source: ABdhPJyeNAWkXim0P6EzmEhxZzg/rn93SeggwZ40HFf+Do9T8/OpIrtCP5MOpxLjB/QRBI1n8yV1BQ==
X-Received: by 2002:a05:6402:944:: with SMTP id h4mr29713934edz.76.1624857254421;
        Sun, 27 Jun 2021 22:14:14 -0700 (PDT)
Received: from gmail.com (94-21-131-96.pool.digikabel.hu. [94.21.131.96])
        by smtp.gmail.com with ESMTPSA id j19sm6363193ejo.3.2021.06.27.22.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 22:14:13 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Jun 2021 07:14:12 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] sigqueue cache fix
Message-ID: <YNlapAKObfeVPoQO@gmail.com>
References: <YNQwgTR3n3mSO9+3@gmail.com>
 <CAHk-=wiebYt6ZG4Cp8fWqVnNqxMN4pybDZQ6gwsTWFc0XP=XPw@mail.gmail.com>
 <CAHk-=wgEyk9X5NefUL7gaqXOSDkdzCEDi6RafxGvG+Uq8rGrgA@mail.gmail.com>
 <CAHk-=wiJq0Ns7_AFRW+rvZcD_m+1t5cYgvQRO-Gbp8TEK1x1bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiJq0Ns7_AFRW+rvZcD_m+1t5cYgvQRO-Gbp8TEK1x1bQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, Jun 27, 2021 at 11:52 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Ok, I may have confused myself looking at all this, but it does all
> > make me think this is dodgy.
> 
> I also couldn't convince myself that the memory ordering is correct
> for the _contents_ of the sigqueue entry that had its pointer cached,
> although I suspect that is purely a theoretical concern (certainly a
> non-issue on x86).
> 
> So I've reverted the sigqueue cache code, in that I haven't heard
> anything back and I'm not going to delay 5.13 over something small and
> easily undone like this.

I concur that it was the safest to revert this, because it was close to the 
final release.

I think the code is safe, but only by accident. The most critical data race 
isn't well-documented, unless I missed something.

The most fundamental race we can have is this:

      CPU#0

      __sigqueue_alloc()

      [ holds sighand->siglock ]
      [ IRQs off. ]

      q = READ_ONCE(t->sigqueue_cache);
      if (!q || sigqueue_flags)
            q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
      else
            WRITE_ONCE(t->sigqueue_cache, NULL);


                                CPU#1  

                                __sigqueue_free()

                                [ IRQs off. ]

                                if (!READ_ONCE(current->sigqueue_cache))
                                      WRITE_ONCE(current->sigqueue_cache, q);
                                else
                                      kmem_cache_free(sigqueue_cachep, q);

( Let's assume exit_task_sigqueue_cache() happens while there's no new 
  signal sending going on, so that angle is safe. )

Someone confusingly, *alloc() is the consumer and *free() is the producer 
of the sigqueue_cache.

Here's how I see the 3 fundamental races these two pieces of code may have:

 - Producer <-> producer: The producer cannot race with itself, because it 
   only ever produces into current->sigqueue_cache and has interrupts 
   disabled. We don't send signals from NMI context.

 - Consumer <-> consumer: multiple consumers cannot race with themselves, 
   because they serialize on sighand->siglock.

 - Producer <-> consumer: this is the most interesting race, and I think 
   it's unsafe in theory, because the producer doesn't make sure that any 
   previous writes to the actual queue entry (struct sigqueue *q) have 
   reached storage before the new 'free' entry is advertised to consumers.

   So in principle CPU#0 could see a new sigqueue entry and use it, before 
   it's fully freed.

   In *practice* it's probably safe by accident (or by undocumented 
   intent), because there's an atomic op we have shortly before putting the 
   queue entry into the sigqueue_cache, in __sigqueue_free():

         if (atomic_dec_and_test(&q->user->sigpending))
                free_uid(q->user);

   And atomic_dec_and_test() implies a full barrier - although I haven't 
   found the place where we document it and 
   Documentation/memory-ordering.txt is silent on it. We should probably 
   fix that too.

At minimum the patch adding the ->sigqueue_cache should include a 
well-documented race analysis firmly documenting the implicit barrier after 
the atomic_dec_and_test().

Anyway, I agree with the revert.

Thanks,

	Ingo
