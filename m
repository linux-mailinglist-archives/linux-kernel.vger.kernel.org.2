Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5704F40D0B9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhIPAQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbhIPAQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:16:10 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDA9C061764
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 17:14:50 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id q3so5776518iot.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 17:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2bhYNIvZhw1Pu4EwCfZvnrNOuUaG9EgxvmCjOYrQTC4=;
        b=WMUqZapexgL0XF/3za9ijZuEsrW8lsacrvIaQLFEJCd1zC78Z3FgkV768ldzEgYt79
         +GFDezuO+fwb2lDJD2xFYpqUxaYHuPbb8IP3pysxFMgDFHhNPfP/frrIngfkAHdMVFct
         XHMRi6Lap0baSSKPgmeDo9NWHSpXuQv2jYGoVpem+88djtO/jp+T0Pqm2GayWSCTKgU/
         3hd3dT1YurhNEWjzXdyDSroifDsyUjMyaMIhvzqZ6ySlXaaJQ2zIXUxCoZ/K4CkGvVaG
         xrGrehbHvgZy5VZFwsiXhZuv7fXmxfQS20BGwHbLWxQQcpkkRYXnH2BqrSnAy9n36CML
         BiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bhYNIvZhw1Pu4EwCfZvnrNOuUaG9EgxvmCjOYrQTC4=;
        b=SppuurWCmYoYhbZ87AP7fMq53k8pvmh7Zl8bm0p7hmm6DIMlOF5hhdFUNV7wh9BIeb
         0g26ub9WdFkw+BhpiAsVbXWeKAhrBvHrRlyGas/vSOwe5VBcwKPUMWWmlN7aSII3xquQ
         w+noz+zk/9e878J/JkeY3lvvGO64UP4KK6AdXZH8mg36C/wqENuoIRSIX+tMW8FFDoKx
         DKqovMQDoaRKqMvv56R4nI68c4+WOkVuHV34mEPSIBvNUuDhFUE9d7EScqFVTzkC08M1
         L9TZKGS1/qx1X5/QkWPLESVQaxW2HRKNpjsTOQrKP9RbtVevjvudTuLgY+WZgHYtkYHq
         eVRg==
X-Gm-Message-State: AOAM530bqd1u/oj5PDyTRxQBU3ag/Ap6jkC8jsoAgVxQQkuj6okujMYD
        a4poJe1W0u/AJSdxvAYidsHQiJYEoIlHtfl30a63Qg==
X-Google-Smtp-Source: ABdhPJwRh16jEualQ9AXgB69frrD0oCOvlcoRnL43yB09g3/8l/+zWP6bTjkns6IG6Ua3APFTh4VLTedsidivoT2GuE=
X-Received: by 2002:a05:6638:dc8:: with SMTP id m8mr2145670jaj.21.1631751289790;
 Wed, 15 Sep 2021 17:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210804072547.1728924-1-irogers@google.com> <74ddb02a-1cdc-24fc-781e-4c87feb638fa@huawei.com>
 <CAP-5=fWWvGi8gGfwGORF-4y7V6G_gCxY7=SX2zo_cyxKxTEf+A@mail.gmail.com> <3e853906-f758-8ad6-2297-27e4f097591a@huawei.com>
In-Reply-To: <3e853906-f758-8ad6-2297-27e4f097591a@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 15 Sep 2021 17:14:37 -0700
Message-ID: <CAP-5=fVZJfXioc5DiurH+LOfcGGmTgd4Cg+qQHQYWzkD64_G+Q@mail.gmail.com>
Subject: Re: [PATCH] perf test: Make metric testing more robust.
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 10:19 AM John Garry <john.garry@huawei.com> wrote:
>
> On 04/08/2021 15:55, Ian Rogers wrote:
> >
> >
> > On Wed, Aug 4, 2021, 2:11 AM John Garry <john.garry@huawei.com
> > <mailto:john.garry@huawei.com>> wrote:
> >
> >     On 04/08/2021 08:25, Ian Rogers wrote:
> >      > When testing metric expressions we fake counter values from 1 going
> >      > upward. For some metrics this can yield negative values that are
> >     clipped
> >      > to zero, and then cause divide by zero failures. A workaround for
> >     this
> >      > case is to try a second time with counter values going in the
> >     opposite
> >      > direction.
> >      >
> >      > This case was seen in a metric like:
> >      >    event1 / max(event2 - event3, 0)
> >
> >     is this the standard method to make the metric evaluation fail when
> >     results are not as expected? In this example, event2 should be greater
> >     than event3 always. Dividing by max(x, 0) would seem a bit silly.
> >
> >
> > I wouldn't say it was standard but it is in a metric a third party gave
> > us.
>
> I agree that making it more robust is a good thing. But masking bogus
> expressions isn't great. After all, we're here to find them :)
>
>  > It would be possible to get the same test failure on more standard
>  > expressions, so it would be nice if these tests were more robust.
>
> so something like this would fail also:
> event1 / (event2 + event3 - 1 - event4)
>
> assuming we have ascending values from 1 for event1. And this would seem
> a valid expression.
>
> Anyway, it would be nice if we could reject max(0, x) and any divide by
> negative numbers, apart from your change.

Thanks John, it'd be nice to have a tool to vet for bogus expressions.
I think that's out of the scope of this change but we should bear it
in mind. Would be nice to land this change if someone has time to
review.

Thanks,
Ian

> Cheers,
> john
>
>
> >      >
> >      > Signed-off-by: Ian Rogers <irogers@google.com
> >     <mailto:irogers@google.com>>
> >      > ---
> >      >   tools/perf/tests/pmu-events.c | 32 ++++++++++++++++++++++++++------
> >      >   1 file changed, 26 insertions(+), 6 deletions(-)
> >      >
> >      > diff --git a/tools/perf/tests/pmu-events.c
> >     b/tools/perf/tests/pmu-events.c
> >      > index b8aff8fb50d8..6c1cd58605c1 100644
> >      > --- a/tools/perf/tests/pmu-events.c
> >      > +++ b/tools/perf/tests/pmu-events.c
> >      > @@ -600,8 +600,18 @@ static int test_parsing(void)
> >      >                       }
> >      >
> >      >                       if (expr__parse(&result, &ctx,
> >     pe->metric_expr, 0)) {
> >      > -                             expr_failure("Parse failed", map, pe);
> >      > -                             ret++;
> >      > +                             /*
> >      > +                              * Parsing failed, make numbers go
> >     from large to
> >      > +                              * small which can resolve divide
> >     by zero
> >      > +                              * issues.
> >      > +                              */
> >      > +                             k = 1024;
> >      > +                             hashmap__for_each_entry((&ctx.ids),
> >     cur, bkt)
> >      > +                                     expr__add_id_val(&ctx,
> >     strdup(cur->key), k--);
> >      > +                             if (expr__parse(&result, &ctx,
> >     pe->metric_expr, 0)) {
> >      > +                                     expr_failure("Parse
> >     failed", map, pe);
> >      > +                                     ret++;
> >      > +                             }
> >      >                       }
> >      >                       expr__ctx_clear(&ctx);
> >      >               }
> >      > @@ -656,10 +666,20 @@ static int metric_parse_fake(const char *str)
> >      >               }
> >      >       }
> >      >
> >      > -     if (expr__parse(&result, &ctx, str, 0))
> >      > -             pr_err("expr__parse failed\n");
> >      > -     else
> >      > -             ret = 0;
> >      > +     ret = 0;
> >      > +     if (expr__parse(&result, &ctx, str, 0)) {
> >      > +             /*
> >      > +              * Parsing failed, make numbers go from large to
> >     small which can
> >      > +              * resolve divide by zero issues.
> >      > +              */
> >      > +             i = 1024;
> >      > +             hashmap__for_each_entry((&ctx.ids), cur, bkt)
> >      > +                     expr__add_id_val(&ctx, strdup(cur->key), i--);
> >      > +             if (expr__parse(&result, &ctx, str, 0)) {
> >      > +                     pr_err("expr__parse failed\n");
> >      > +                     ret = -1;
> >      > +             }
> >      > +     }
> >      >
> >      >   out:
> >      >       expr__ctx_clear(&ctx);
> >      >
> >
>
