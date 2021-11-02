Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7883044398C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 00:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhKBXYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:24:13 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:38662 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhKBXYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:24:09 -0400
Received: by mail-lj1-f176.google.com with SMTP id v23so790569ljk.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 16:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DtsZciRFHccr1JutIz3sjOj8rylwQ1xZ3FPYcVgwOB0=;
        b=4WoqwKYe30NefE65IDUd38zuplSCq5QOlwS5a8rGw/yK22hhfSxVpMlj5l6sfS2ADE
         YOiUzFO9O6brqt1Dj+348qANH5BUz1ImsqvlMNa1b/XJYpKkbZL1k2qu3+Uv7QsSr26N
         0wzRPWVFCXdBAkiJE6TJ/iiAVTScEdpFhyE7DvI0nvZeNb+y95ymbb0ezoBXykGcPlP9
         IgZ5hs0p4jmeWgFSXLVmCaIMVKAE1KAvVLWutyHL/aTs9nediSg+SYmSuwNg6TSUA72a
         Ei57nNexRnR0jOUkjIFrkrog9RymqRsuMe/C3OEqsvH/74MZP+1eAnOss7pmVqY93ZeI
         0Rmw==
X-Gm-Message-State: AOAM532oLonsFHRvJ7L9sE8lHYpKoKFqEMrJhgqo5pZPvw6zdf4lU9CC
        OXoEBWCrTWFylFQ6cpP7jYOfgV9y2rImS64mgWY=
X-Google-Smtp-Source: ABdhPJwOP5eERE+QF4aLf7ouKTD8t31BcFk/GZcq7wSW37g1UQqgg+RYIkqzdlyavAo0dNAzYQ7Uyxm7sv/4ofDJvb0=
X-Received: by 2002:a05:651c:551:: with SMTP id q17mr12694837ljp.202.1635895292500;
 Tue, 02 Nov 2021 16:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20211029224929.379505-1-namhyung@kernel.org> <YYFGxwFMvTRN5KBI@krava>
In-Reply-To: <YYFGxwFMvTRN5KBI@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 2 Nov 2021 16:21:21 -0700
Message-ID: <CAM9d7cjPq7=HoPAi3Cd3crcNJO8hWu0cU8j4qOTqSMxd7M6BqQ@mail.gmail.com>
Subject: Re: [PATCH v3] perf evsel: Fix missing exclude_{host,guest} setting
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Tue, Nov 2, 2021 at 7:10 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Oct 29, 2021 at 03:49:29PM -0700, Namhyung Kim wrote:
> > The current logic for the perf missing feature has a bug that it can
> > wrongly clear some modifiers like G or H.  Actually some PMUs don't
> > support any filtering or exclusion while others do.  But we check it
> > as a global feature.
> >
> > For example, the cycles event can have 'G' modifier to enable it only
> > in the guest mode on x86.  When you don't run any VMs it'll return 0.
> >
> >   # perf stat -a -e cycles:G sleep 1
> >
> >     Performance counter stats for 'system wide':
> >
> >                     0      cycles:G
> >
> >           1.000721670 seconds time elapsed
> >
> > But when it's used with other pmu events that don't support G modifier,
> > it'll be reset and return non-zero values.
> >
> >   # perf stat -a -e cycles:G,msr/tsc/ sleep 1
> >
> >     Performance counter stats for 'system wide':
> >
> >           538,029,960      cycles:G
> >        16,924,010,738      msr/tsc/
> >
> >           1.001815327 seconds time elapsed
> >
> > This is because of the missing feature detection logic being global.
> > Add a hashmap to set pmu-specific exclude_host/guest features.
> >
> > Reported-by: Stephane Eranian <eranian@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> > v3 changes)
> >  * check memory allocation failure
> >  * add more NULL check
>
> we were discussing this with Arnaldo yesterday and he had an idea to use
> evsel->pmu link to store this info instead of hash.. I first thought we
> needed 'evsel' related data, but after I gave it some thought I think that
> might actually work

I don't get it.. do we have evsel->pmu already?  Or do you want to add it?
Yeah, the filtering facility (attr.exclude_*) should be kept in a PMU data
not in the evsel.  So I added a hashmap to find the pmu data from attr.type.
How do I use evsel->pmu to store the info then?

>
> my argument was following usecase:
>
>   cycles:G,instructions:G,pmu/bla1/:G,pmu/bla2/
>
> that we would falsely clear pmu/bla1/:G if we used the 'evsel->pmu' data..
> but then I realized it's detection if pmu support :G and so if the :G is
> not there, none of the events should have it
>
> thoughts?

I don't think I'm following well... ;-p

If the pmu doesn't support host/guest filtering, pmu/bla1/G
may count something.  Not sure if it's better to error out.
But the cycles:G and instructions:G should result in 0
in case there's no VM running.

Thanks,
Namhyung
