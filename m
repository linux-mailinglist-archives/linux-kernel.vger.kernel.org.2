Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899CA3D94C1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 19:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhG1R6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 13:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhG1R63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 13:58:29 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4388CC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 10:58:27 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id h9so4085275ljq.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=st4BTmD3GjnmfHHn6gBxGtmKTmgLmjzYeVnW05cJn0A=;
        b=ckWa5YRohsLqQWO833u/brAzgJGjnutI0P6k82Ud0JVlkVyx7vXtjeSjndZo0mo9mY
         aUBFUVbZIGxF8sMqdngYvzcbCq4CVB2g472PBpiQFre1Kadno8zglUzss61LiyuhHL4n
         DC0o633dF8JUNRXshWFolyaCmL/kwVHPjrAXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=st4BTmD3GjnmfHHn6gBxGtmKTmgLmjzYeVnW05cJn0A=;
        b=ZzCWOe46bAZF3KgA8YGt6ylh8stltK7jU/o9MjmrziayNWRM5Ki2Whd65qziOx9/E9
         B7Su8OtJUFwHpK1r5xSQ6HnvFuB8hU2SKcP9g+OqRF5sK80SDOqth1lWMPOX/xsavCla
         yT/5P0ySZDRm8daxfnO+MWao7ECsfcziV2K1Mng2I4Mo5YWy0nozVVWW77aY2gclaa2f
         DVQVuxyQecYE2hyHuOhDftYR/0fD1TBVylhswEDQJKGAXz99UlKpCRZJfA/8gelADuiD
         8ABLmWn+yEIJ+wM0Uy5FTlNTtc20p+gLYKF35hrrAfg3NBSNUB4RIZzS62l6gDUi70mt
         neLQ==
X-Gm-Message-State: AOAM533gvbWGlxuSAJuuQ0nXq2m+r7mQhkLT/AM0jIuQ4QxbAfcT6FRU
        gQ/SV3y/DR9SiA03c/BrxXnEVo6ksiAZKqwXbts=
X-Google-Smtp-Source: ABdhPJxrnGtp3AIi2is4wXugtqs2VCnBI+y6ItECCVBe8hnlG1g+eogm4ScRrgrdaC5k+tjK9umLsQ==
X-Received: by 2002:a05:651c:22d:: with SMTP id z13mr606036ljn.14.1627495105428;
        Wed, 28 Jul 2021 10:58:25 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id g7sm61795lfb.152.2021.07.28.10.58.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 10:58:24 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id a26so5502072lfr.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 10:58:24 -0700 (PDT)
X-Received: by 2002:a05:6512:2388:: with SMTP id c8mr533031lfv.201.1627495104323;
 Wed, 28 Jul 2021 10:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210721202042.GA1472052@paulmck-ThinkPad-P17-Gen-1>
 <20210721202127.2129660-4-paulmck@kernel.org> <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210728173715.GA9416@paulmck-ThinkPad-P17-Gen-1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Jul 2021 10:58:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjwZzi=Lqsre8C8C4YJiVQNdNnco7jkLq=ohePSPA9JCA@mail.gmail.com>
Message-ID: <CAHk-=wjwZzi=Lqsre8C8C4YJiVQNdNnco7jkLq=ohePSPA9JCA@mail.gmail.com>
Subject: Re: [PATCH v2 rcu 04/18] rcu: Weaken ->dynticks accesses and updates
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

On Wed, Jul 28, 2021 at 10:37 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> +/*
> + * Increment the current CPU's rcu_data structure's ->dynticks field
> + * with ordering.  Return the new value.
> + */
> +static noinstr unsigned long rcu_dynticks_inc(int incby)
> +{
> +       return arch_atomic_add_return(incby, this_cpu_ptr(&rcu_data.dynticks));
> +}

Maybe inline?

But more I reacted to how we sadly don't have percpu atomics. They'd
be fairly easy to add on x86, but I guess it's not a huge deal.

And hey, if this is pretty much the only place that would use them, I
guess that's not much of an issue.

             Linus
