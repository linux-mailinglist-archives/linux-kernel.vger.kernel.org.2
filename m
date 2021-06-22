Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DCE3B0CDE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhFVSay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhFVSax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:30:53 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ED0C061756
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:28:33 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso2884589wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 11:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ZRESarJDPkY6qjYc9HPNqJRL29Tb0Y5iNDm2R43Wwg=;
        b=vpYah1ZnJP4oxpRimY85t1NwjzRpYYu413Kk5vt8w+ZsIJV+ejZxFfo2eEdKTDf6M3
         /meOClvKBeJfcCsndJz6CqHNBk8K3pi9aXjkmBzr+CnnRPORR2QTHqxlHMt98fAH0vAI
         cXh7BmZVQ51L3nAFemhS4EOxezqNlNRn2Z/S0Ng+3DpHCfd5voNw3VmxMInGTPpWR1o7
         l6IIeK3XgOtfQ1caEznQyFNxSCzkZQY5mpcreiHFXr9wQwaH5VVkoxgJel7wYJ9srWxh
         xAPGrR3lNd9kDvcXjEsY5HzSQcLgrUsDM6e8vSQ/yXMjpBeCjDfRQ0fv2RBMFA1LAuSq
         Iaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ZRESarJDPkY6qjYc9HPNqJRL29Tb0Y5iNDm2R43Wwg=;
        b=NuSGj2aQ9qLO5ZOW1NAOErCHVFE7v4ppLwMY1R/dF4v9Zt+MPy3VxnAWLUowyIaPMT
         vu3H/8Y2WEd5v7YZQE21vyr40YonwEIymZWxWKXSSUzvMeJsi9s6ij9iIUb+e0Vz2OVn
         GUl++hp9y56TC/VCInfwn23TIShK6ZKKEJkHP4dsKkSA4yaGSRCFB3cTvnp1Nikwr37Z
         fT9+shrqamynRLgZ2JDqYLwlScbW6mmkcQr2F1ituu34UuDcPg3DETmyHQYhpLsPtZyH
         ZDjIiSK0WUTLeqWrmOobGJ8UyG2SIarFyraxObE3a1HhSZgVto+pLWRh+YJd0N1L1Dqp
         27dQ==
X-Gm-Message-State: AOAM533ao0b97WvpyRrLPUNWuu2Sm7TAUQBbtFgQkkubRvbE/9+P0wUw
        VAobjVfT5Xf5u5F8o5NEZbAXboql/k0GTKTo5V3VeA==
X-Google-Smtp-Source: ABdhPJzc5ns+c8Q3EBPkdLtHF1+6Hv9Ihb1JsjRwhsaWyw7KtWoS90LX3gH6PdqM641Yr6DJDRqUO1gudjGEUgdlq1k=
X-Received: by 2002:a05:600c:a01:: with SMTP id z1mr6203292wmp.77.1624386511920;
 Tue, 22 Jun 2021 11:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210621234317.235545-1-rickyman7@gmail.com> <20210621234317.235545-3-rickyman7@gmail.com>
 <CAP-5=fUGRdj=G6=srwoATWMimK5tB4X2Sxa64tTVk_JRwMJdWg@mail.gmail.com>
 <d4921abf8dcff02245ccf7ad8edfd8048e926936.camel@gmail.com>
 <CAP-5=fXGJXmpddPVEjmCCv9oC7bmum3p+1m1m6rem8Pdy+XaXA@mail.gmail.com> <YNIg7OkPi7YgsBZ3@kernel.org>
In-Reply-To: <YNIg7OkPi7YgsBZ3@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 22 Jun 2021 11:28:19 -0700
Message-ID: <CAP-5=fUp9tAHSW6xp5G9kRu=V+qVnqxnMySPCCAMWfpmgpi4wA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf script: delete evlist when deleting session
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Riccardo Mancini <rickyman7@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 10:42 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Jun 22, 2021 at 09:33:23AM -0700, Ian Rogers escreveu:
> > On Tue, Jun 22, 2021 at 12:44 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > thanks for your comments.
> > >
> > > On Mon, 2021-06-21 at 22:14 -0700, Ian Rogers wrote:
> > > > On Mon, Jun 21, 2021 at 4:44 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
> > > > >
> > > > > ASan reports a memory leak related to session->evlist never being deleted.
> > > > > The evlist member is not deleted in perf_session__delete, so it should be
> > > > > deleted separately.
> > > > > This patch adds the missing deletion in perf-script.
> > > > >
> > > > > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> > > > > ---
> > > > >  tools/perf/builtin-script.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > > > > index 1280cbfad4db..635a1d9cfc88 100644
> > > > > --- a/tools/perf/builtin-script.c
> > > > > +++ b/tools/perf/builtin-script.c
> > > > > @@ -3991,7 +3991,7 @@ int cmd_script(int argc, const char **argv)
> > > > >                 zfree(&script.ptime_range);
> > > > >         }
> > > > >
> > > > > -       evlist__free_stats(session->evlist);
> > > >
> > > > Should this be removed?
> > >
> > > Probably not. I originally thought this was already taken care of by
> > > evlist__delete, but it's not.
> > > Oddly, this issue is not causing a memory leak in my simple test.
> > >
> > > >
> > > > > +       evlist__delete(session->evlist);
>
> This looks like a bug, if it is a 'session' member, its a session method
> that should delete it, probably perf_session__delete().
>
> > > > If the perf session "owns" the evlist, would it be cleaner to add this
> > > > to perf_session__delete?
> > >
> > > I thought about that too, but that's not always true.
> > > E.g., in perf-record, __cmd_record calls perf_session__delete,then cmd_record
> > > calls evlist__delete on rec->evlist, which points to the same location to which
> > > session->evlist pointed.
> >
> > Agreed. I find it hard to understand the ownership properties in the
> > perf code. The missing delete is an example of the owner of the evlist
> > (the caller) not "knowing" it needed cleaning up. I'd like it if we
> > documented things like perf_sessions' evlist to say not owned, user
> > must clean up. The makes it unambiguous who has to take
> > responsibility. Having things clean up after themselves is of course
> > easiest, hence wanting this to be in perf_session__delete.
>
> This specific case, from just reading the description on this message,
> looks just like a bug/thinko.

Ack. Definitely worth merging the change. I think this is about the
7th address sanitizer bug Riccardo has fixed. Namhyung, Numfor, Luke
and myself have also contributed similar fixes. We set up some fuzz
testing on libtraceevent and there are currently 12 issues we've found
there. The nice thing with sparse compared to address sanitizer is the
compiler will point at the problem, you don't need to trigger an issue
in a test. There are some complicated ownership rules in session and
also in the reference counting issues that Riccardo has raised, so
perhaps there's scope for some more comments or other tidy ups.

Thanks,
Ian
> > Fwiw, I've been reading around things like sparse [1, 2] and Clang's
> > similar analysis [3] that people have looked to use like sparse [4]. I
> > don't see anything that handles memory allocation lifetimes, but
> > perhaps something will feed into C's standards by way of C++ [5].
> > Perhaps people have ideas to rewrite in checked C or Rust :-)
> >
> > Some thoughts:
> > 1) we can't have C++ as we're trying to follow kernel conventions [6]
> > 2) we can't annotate code for things like sparse or thread safety
> > analysis, as checking for memory errors is out of scope for them, the
> > annotations don't exist, etc.
> > 3) we can add comments, document the rules around pointers, perhaps
> > even invent empty annotations that may one day help with automated
> > checking.
> > 4) we can try to clean up the ownership model to make bugs less likely.
> >
> > I've heard concerns on non-kernel projects about annotation litter and
> > comments adding to complexity. I think your patch is good, it follows
> > the existing conventions. I wonder if we can learn something from the
> > fact the code was wrong to make it less likely we have wrong code in
> > the future. I'd be interested to hear what others think.
> >
> > Thanks,
> > Ian
> >
> > [1] https://lore.kernel.org/lkml/Pine.LNX.4.58.0410302005270.28839@ppc970.osdl.org/
> > [2] https://lwn.net/Articles/689907/
> > [3] https://clang.llvm.org/docs/ThreadSafetyAnalysis.html
> > [4] https://www.openwall.com/lists/kernel-hardening/2019/05/20/3
> > [5] https://github.com/isocpp/CppCoreGuidelines/blob/master/docs/Lifetime.pdf
> > [6] even concatenating a string is error prone in C :-(
> > https://lore.kernel.org/lkml/YMzOpgZPJeC2jGKf@kernel.org/
> >
> > > Thanks,
> > > Riccardo
> > >
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > > > >         perf_session__delete(session);
> > > > >
> > > > >         if (script_started)
> > > > > --
> > > > > 2.31.1
> > > > >
> > >
> > >
>
> --
>
> - Arnaldo
