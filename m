Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82DB3B589E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 07:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhF1Fch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 01:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhF1Fcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 01:32:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A6FC061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 22:30:07 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bg14so27720077ejb.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 22:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TCOGh443Z3FS98u3j0YSq8PEKcmYhShTJ9+FJzrba6A=;
        b=P7nAnXD2lZjL/Q7FX7HRnoSXdTNgPVjcRood2YevxQ7J/SS5I9eD7s4OTZ/Rou/QVo
         pPhIYuLZIeGDcmoXnBjLuE8z6U6T9Ij/6g1kwTVPYelfb/VEVHdYxyzzzh86aFzdnl7I
         0JRG5kL/Kr3sLEiqMwnEpdwjnHJ236V/PQdZG7JY4TImJxn/Zh/rwghf3TEKPFlgGV8d
         ky2Avp+YM7aEmhT4JUVIaMJsg6sHFZsScSyv+e+grqiW9fS+N6eGXOkbT1iJrIQGNmVy
         YGrhYzZRMXNH7P3VKpkfURtZMprRB4d2hrygxv3rWGyWAECbgk8rDZy1OCH5/ZY/VTS+
         X21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TCOGh443Z3FS98u3j0YSq8PEKcmYhShTJ9+FJzrba6A=;
        b=rqOBj/L4PieuzFo+7g5ZXB+gBSqcQ9V+frjj2OxocHeuW/VznCepd+JuVmWNzFlBkq
         LglfJLzsl6l19tJZHjAT5r2sIKQY8gCzOmgcZ/k9nwU7Sj3MXwURApSpUszUZUoI18oY
         DjIlbJFM0w0tGGQHUy7oknwfr9r+rYhafsbFYLBRWKOOJaUhcCxGSJh/ah6PoH2gDou/
         Ofhf4hEZLGO4RgF9l8OQFSvk2ZsnE6cK6FHc2KLfUfL9U9TjE94Ub+460tQOxE08G6gy
         X4UuI+zQPuiHcYlNUKBmgZsJ+uwVyZkrJV30BNJxo7aCWU4yw2fzx0V2lt8j9GkXyxDR
         HuLg==
X-Gm-Message-State: AOAM5326GM9ZrAwLhADvdsWzX+MFcXVQoiMfnwFVmxRIq/stk6CgoZ57
        p24GPt25WT+xYR9VdNjGBZApKdiSRb8=
X-Google-Smtp-Source: ABdhPJzKHhJG0+SUdmo8JKUmtHDmwpzosoEDUlm87f6DIYAH4/nkL/IqG6i4SlbTSAHqtmyCXDs8wQ==
X-Received: by 2002:a17:906:9419:: with SMTP id q25mr22523851ejx.341.1624858205754;
        Sun, 27 Jun 2021 22:30:05 -0700 (PDT)
Received: from gmail.com (94-21-131-96.pool.digikabel.hu. [94.21.131.96])
        by smtp.gmail.com with ESMTPSA id ee47sm8893562edb.51.2021.06.27.22.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 22:30:05 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 28 Jun 2021 07:30:03 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] sigqueue cache fix
Message-ID: <YNleW59jE1rj0Tq8@gmail.com>
References: <YNQwgTR3n3mSO9+3@gmail.com>
 <CAHk-=wiebYt6ZG4Cp8fWqVnNqxMN4pybDZQ6gwsTWFc0XP=XPw@mail.gmail.com>
 <CAHk-=wgEyk9X5NefUL7gaqXOSDkdzCEDi6RafxGvG+Uq8rGrgA@mail.gmail.com>
 <CAHk-=wiJq0Ns7_AFRW+rvZcD_m+1t5cYgvQRO-Gbp8TEK1x1bQ@mail.gmail.com>
 <YNlapAKObfeVPoQO@gmail.com>
 <YNlcgryyawTxPz//@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNlcgryyawTxPz//@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> >  - Producer <-> consumer: this is the most interesting race, and I think 
> >    it's unsafe in theory, because the producer doesn't make sure that any 
> >    previous writes to the actual queue entry (struct sigqueue *q) have 
> >    reached storage before the new 'free' entry is advertised to consumers.
> > 
> >    So in principle CPU#0 could see a new sigqueue entry and use it, before 
> >    it's fully freed.
> > 
> >    In *practice* it's probably safe by accident (or by undocumented 
> >    intent), because there's an atomic op we have shortly before putting the 
> >    queue entry into the sigqueue_cache, in __sigqueue_free():
> > 
> >          if (atomic_dec_and_test(&q->user->sigpending))
> >                 free_uid(q->user);
> > 
> >    And atomic_dec_and_test() implies a full barrier - although I haven't 
> >    found the place where we document it and 
> >    Documentation/memory-ordering.txt is silent on it. We should probably 
> >    fix that too.
> > 
> > At minimum the patch adding the ->sigqueue_cache should include a 
> > well-documented race analysis firmly documenting the implicit barrier after 
> > the atomic_dec_and_test().
> 
> I just realized that even with that implicit full barrier it's not safe: 
> the producer uses q->user after the atomic_dec_and_test(). That access is 
> not serialized with the later write to ->sigqueue_cache - and another CPU 
> might see that entry and use the ->sigqueue_cache and corrupt q->user ...
> 
> So I think this code might have a real race on LL/SC platforms and we'll 
> need an smp_mb() in sigqueue_cache_or_free()?

pps. free_uid() happens to have an implicit barrier via 
refcount_dec_and_lock_irqsave():

  void free_uid(struct user_struct *up)
  {
        unsigned long flags;

        if (!up)
                return;

        if (refcount_dec_and_lock_irqsave(&up->__count, &uidhash_lock, &flags))
                free_user(up, flags);


So the q->user read in __sigqueue_free() appears to be implicitly 
serialized by free_uid() with the later write of 'q' to ->sigqueue_cache.

This needs to be robustly documented though.

Thanks,

	Ingo
