Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303053D1847
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhGUUBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 16:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhGUUBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 16:01:30 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CBEC061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 13:42:05 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u14so4725282ljh.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 13:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csX/v4wZK/8khKbWOQHMHKPVkpan3K/PQpV5i6hI1c0=;
        b=RIOdAP9M9gXS951krhcwLpREAahAyipS213qzagLjn9qzHnaba4oO8CHqBJEXCWXL8
         +FxzgIvAS2ZmXmep4rv8XOlP7+zh/uTP17V4d0uuaZivHXqxLDzTHqsr8T2h/2tfvOG+
         baDbARcSNcjAOApHnuGY1cVlFgtvbyDiPc0Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csX/v4wZK/8khKbWOQHMHKPVkpan3K/PQpV5i6hI1c0=;
        b=UPW1o8T1Mq7GstgQZs1Rp+xBEcrOsTVFB2saNa5wb+nxfIJjTaxppjVMPgvfJvA2AI
         8tuS4z+3iydVEyugTtDNf48xn1BXK3wL5eRlTHQnKy5pY6/EKWdTj/hO4mU8AoO/2wxn
         Ee49O+8Ccko/92sqrkfQ/7DvCtMcIGGL1VkJPcglSb6WZpBZPHIBttETM3wbeimWcf8P
         UfmUBIUpfAmqNGvFmHA/E2Kyu5q5f4IIffyTn1mKhzSqCzJwyMpn7KTSHTT7bn5Q4aHM
         FYfo4ILU8ZaAgtEgrMOqwQVwTlnW8WPNkUsj029tapRXWb8RG7A36tK0ZJ1ExMevQdcH
         q4cg==
X-Gm-Message-State: AOAM530N0oWucCMO++e/UjVLFbn9R9cChzzpBsub+ZWMlnkynaAhRvAp
        LfzUKVmP6czJrX9KuVPXzh7KVXP2lrjyZcI/
X-Google-Smtp-Source: ABdhPJxImdZFQdD/9vfnPD4MhHfOVqyZ2emFhkYUH4rDOyIBaRKt5zwSAZSzIzVO5q2TAwvD+5iDqg==
X-Received: by 2002:a2e:bd86:: with SMTP id o6mr33091244ljq.84.1626900123768;
        Wed, 21 Jul 2021 13:42:03 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 10sm1827984lfz.115.2021.07.21.13.42.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 13:42:02 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id h4so4651691ljo.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 13:42:02 -0700 (PDT)
X-Received: by 2002:a2e:90cd:: with SMTP id o13mr16138636ljg.465.1626900121924;
 Wed, 21 Jul 2021 13:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1> <20210721202127.2129660-4-paulmck@kernel.org>
In-Reply-To: <20210721202127.2129660-4-paulmck@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Jul 2021 13:41:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgm_W82CcbiJHZPw45QRwomFbWcHkFoOd5C5hG-5GGoRQ@mail.gmail.com>
Message-ID: <CAHk-=wgm_W82CcbiJHZPw45QRwomFbWcHkFoOd5C5hG-5GGoRQ@mail.gmail.com>
Subject: Re: [PATCH rcu 04/18] rcu: Weaken ->dynticks accesses and updates
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm.

This actually seems to make some of the ordering worse.

I'm not seeing a lot of weakening or optimization, but it depends a
bit on what is common and what is not.

On Wed, Jul 21, 2021 at 1:21 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> +/*
> + * Increment the current CPU's rcu_data structure's ->dynticks field
> + * with ordering.  Return the new value.
> + */
> +static noinstr unsigned long rcu_dynticks_inc(int incby)
> +{
> +       struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> +       int seq;
> +
> +       seq = READ_ONCE(rdp->dynticks) + incby;
> +       smp_store_release(&rdp->dynticks, seq);
> +       smp_mb();  // Fundamental RCU ordering guarantee.
> +       return seq;
> +}

So this is actually likely *more* expensive than the old code was, at
least on x86.

The READ_ONCE/smp_store_release are cheap, but then the smp_mb() is expensive.

The old code did just arch_atomic_inc_return(), which included the
memory barrier.

There *might* be some cache ordering advantage to letting the
READ_ONCE() float upwards, but from a pure barrier standpoint this is
more expensive than what we used to have.

> -       if (atomic_read(&rdp->dynticks) & 0x1)
> +       if (READ_ONCE(rdp->dynticks) & 0x1)
>                 return;
> -       atomic_inc(&rdp->dynticks);
> +       rcu_dynticks_inc(1);

And this one seems to not take advantage of the new rule, so we end up
having two reads, and then that potentially more expensive sequence.

>  static int rcu_dynticks_snap(struct rcu_data *rdp)
>  {
> -       return atomic_add_return(0, &rdp->dynticks);
> +       smp_mb();  // Fundamental RCU ordering guarantee.
> +       return smp_load_acquire(&rdp->dynticks);
>  }

This is likely cheaper - not because of barriers, but simply because
it avoids dirtying the cacheline.

So which operation do we _care_ about, and do we have numbers for why
this improves anything? Because looking at the patch, it's not obvious
that this is an improvement.

              Linus
