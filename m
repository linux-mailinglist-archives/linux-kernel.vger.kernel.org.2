Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753EA311A6E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 04:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhBFDqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 22:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhBFCsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:48:24 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5985C033273
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 17:16:01 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id w20so6454969qta.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 17:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8gWhYRq0iywYBH7TzYnfQ9fWlCOVVPnd7CZq8DoR0+c=;
        b=HAlI4OCFihCqRVXSWwnNXcbihpiw8P4x+YYAGBjJBirPzxtUZRl/odfkOpGig/FdGC
         8NCj/Lne9INJ8i0pSz11etpiOM3EHmuCV/sAMU6d1GUZCJsXNmqhqtKliMq4XMIy+Wpd
         2ydlc+4VpCAMW2FQCUCvNte0ZWE0/+h7GYB1tpxesfjFo7IRIbQczp4lwxeYfjofwIcP
         bVegLnAt7zShVm5L4scLazQrBmT+1hIga4gkeVNqoYXTLQclAxLGP53juIAQ8Gf6JCne
         YfiABOzOT923orWrKRKM0qQZahiZhE83sJtFv8BUPoTQ1EzCplhjjgzFgPdmJl1L5ohm
         3PHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8gWhYRq0iywYBH7TzYnfQ9fWlCOVVPnd7CZq8DoR0+c=;
        b=EdrTUHZ+A0YdJ2OlKipA/IGiRB3ExAuaUzQ6XIL5gSEg2mhwmGcDTJqSZXAtseZjH8
         OfKj3cDgtGHOYvRb2pBYSlWJQXD74vNVf7lwu+COrKBElJbO9eez9QphDPqH51jtRiXv
         Ui33kzcJbYtYZDNvmseaxli7ZW+3FThouDvybRRbRe+WqHYusbX0ew2Oni3iVb9Zsx+O
         +esDMOS39AUc3mn3/UxswCdrLLI6SXVlAJGwRJ2RLG+PMxrkkYLA8nVkG4SpWXiHf/lW
         qW7S7lt97VI50ObuQ9Wo5/PKGOPbrZVJHN9mxQhd9lsYi0lSEZx6FAl7lJNOwj5jIyOO
         Jr5A==
X-Gm-Message-State: AOAM531VMYF0Y4J42jFun97OAmhH20galrWWtZypZJYiy03GzuEsB726
        Hz357W3n1toi9Sfa4QO93sXnoPAjY3sMC1yxf8g2rQ==
X-Google-Smtp-Source: ABdhPJyOIWnpILBxXOPWb+lBkMzkYxhtAOYppE1PzzTv93UQy8/Bj7XxFze7RBdJKQJGamI/BC3VLXyHF2OyfbNjmPI=
X-Received: by 2002:ac8:5d0d:: with SMTP id f13mr6798213qtx.317.1612574160377;
 Fri, 05 Feb 2021 17:16:00 -0800 (PST)
MIME-Version: 1.0
References: <20210123011704.1901835-1-joel@joelfernandes.org>
 <20210123011704.1901835-3-joel@joelfernandes.org> <YB0xgL5x1RM7DJ49@hirez.programming.kicks-ass.net>
In-Reply-To: <YB0xgL5x1RM7DJ49@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 5 Feb 2021 17:15:49 -0800
Message-ID: <CABk29NuSB0ynM3w=o8CwMPAdQPm-z4LTTOsQrdP5Nu4y+v8dsA@mail.gmail.com>
Subject: Re: [PATCH v10 2/5] sched: CGroup tagging interface for core scheduling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ben Segall <bsegall@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 3:53 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jan 22, 2021 at 08:17:01PM -0500, Joel Fernandes (Google) wrote:
>
> > +/* All active sched_core_cookies */
> > +static struct rb_root sched_core_cookies = RB_ROOT;
> > +static DEFINE_RAW_SPINLOCK(sched_core_cookies_lock);
>
> > +/*
> > + * Returns the following:
> > + * a < b  => -1
> > + * a == b => 0
> > + * a > b  => 1
> > + */
> > +static int sched_core_cookie_cmp(const struct sched_core_cookie *a,
> > +                              const struct sched_core_cookie *b)
> > +{
> > +#define COOKIE_CMP_RETURN(field) do {                \
> > +     if (a->field < b->field)                \
> > +             return -1;                      \
> > +     else if (a->field > b->field)           \
> > +             return 1;                       \
> > +} while (0)                                  \
> > +
> > +     COOKIE_CMP_RETURN(task_cookie);
> > +     COOKIE_CMP_RETURN(group_cookie);
> > +
> > +     /* all cookie fields match */
> > +     return 0;
> > +
> > +#undef COOKIE_CMP_RETURN
> > +}
>
> AFAICT all this madness exists because cgroup + task interaction, yet
> none of that code is actually dependent on cgroups being on.
>
> So this seems to implement semantics that will make two tasks that share
> a cookie, but are then placed in different cgroups not actually share.
>
> Is that desired? Can we justify these semantics and the resulting code
> complexity.

Yes that is the desired result. IMO it is less optimal from an
interface perspective if we were to instead have group or task cookie
override the other. Joel gave some additional justification here:
https://lkml.org/lkml/2020/12/6/389.
