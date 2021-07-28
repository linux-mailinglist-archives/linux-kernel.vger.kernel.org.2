Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11F63D95A5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 20:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhG1S5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 14:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhG1S5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 14:57:37 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CFEC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 11:57:34 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id h14so5845330lfv.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/mLJclBpYBjhUfUWPAk4A67K9qVvzDPVHZO2WkQdA/g=;
        b=T07r2c1vyn3l3czDvtg1PT8m1MuOm+AE7RG7tSRhBnbgravg9PfJwDbDkF+a1k0NQr
         AfGvVfhBaow/QsjhXEHnz1RPeEKfFGDu28W7gYXNRoiQJ/4z5tgPJ8XFl5ItVK+yF8qa
         NxCa9TsGsc+a3NyUtJskbZHARtKEs+5g0Gm+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/mLJclBpYBjhUfUWPAk4A67K9qVvzDPVHZO2WkQdA/g=;
        b=hOO7O94bO7Aw9nG5APU3D7u2/PrH6XEEwD4VBc9wvZiBb4EZyug2kGBgDvXu62qzqV
         vq9TBewlAA2jOQq5cQ65zwWHXWb4Lht4ZF3AIpeKPg/UKIBqXZf2LNSAWPJFr26W/THH
         GkEbPrxOz+PAxBv1rfl8b6I6lfkZcqr3XJQCmga9Z0oVL6oSq7Q0/RyPumW6bBWAJB+9
         j9sjrb7nCnfXDdDcnZaBH2C/A28ZXylzUjP9w6mBRh5zdNpv+5a04OnrXwsUiLCo+ul7
         Pr2JWFzwK04AlyC0/y74vYDKULNZyF+qsGy4O1+W4QXpC/jp91Tx6BDGpJDJE7A3VRYI
         LVLA==
X-Gm-Message-State: AOAM531Yn+iu7bMCtXVYQTxphGxxRIi4oNhiWKhRy1ZoP/p9E5ST0B9/
        AERPkvhchZbuqkFa0ep8sAeujzKIfGHcsvo5sAQ=
X-Google-Smtp-Source: ABdhPJxg7o1Qp/QPIXyi/Ybi7PGGOoRGkqwO9QSWGhIHQu9uOLV8uChd4ZaxoN7ESR+rqbe+74q6HA==
X-Received: by 2002:a05:6512:13a9:: with SMTP id p41mr702226lfa.403.1627498652167;
        Wed, 28 Jul 2021 11:57:32 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id m9sm33917ljo.85.2021.07.28.11.57.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 11:57:31 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id bp1so5907353lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 11:57:30 -0700 (PDT)
X-Received: by 2002:a05:6512:2388:: with SMTP id c8mr681760lfv.201.1627498650428;
 Wed, 28 Jul 2021 11:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-4-paulmck@kernel.org> <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wjwZzi=Lqsre8C8C4YJiVQNdNnco7jkLq=ohePSPA9JCA@mail.gmail.com> <20210728184605.GI4397@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210728184605.GI4397@paulmck-ThinkPad-P17-Gen-1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Jul 2021 11:57:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-5vtA_-9xs6zV0U20LRaRhVeE1Ky7X+9kHeucrb6_ig@mail.gmail.com>
Message-ID: <CAHk-=wj-5vtA_-9xs6zV0U20LRaRhVeE1Ky7X+9kHeucrb6_ig@mail.gmail.com>
Subject: Re: [PATCH v2 rcu 04/18] rcu: Weaken ->dynticks accesses and updates
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu <rcu@vger.kernel.org>,
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

On Wed, Jul 28, 2021 at 11:46 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> But atomic_read_this_cpu(&rcu_data.dynticks) isn't all that much shorter
> than atomic_read(this_cpu_ptr(&rcu_data.dynticks)).

It's not so much that it's shorter to write for a human, it's that we
could generate better code for it.

That atomic_read(this_cpu_ptr()) pattern generates code like

        movq    $rcu_data+288, %rax
        add %gs:this_cpu_off(%rip), %rax
        movl    (%rax), %eax

but it *could* just generate

        movl %gs:rcu_data+288, %rax

instead.

Similar patterns for the other per-cpu atomics, ie it would be
possible to just generate

        lock ; xaddl %gs:..., %rax

instead of generating the address by doing that "add %gs:this_cpu_off" thing..

But no, it doesn't look like there are enough users of this to matter.
We're just talking a few extra bytes, and a couple of extra
instructions (and possibly slightly higher register pressure, which
then generates more instructions).

The *expensive* part remains the SMP serialization of the "lock".

                Linus
