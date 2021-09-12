Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C187B407E8B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 18:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhILQX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 12:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhILQXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 12:23:19 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B16C061757
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 09:22:04 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id b15so7083204ils.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 09:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=otoclXzkeEyh1j5woX95Y4BqIi75kMI2Nh4wsDY6AGA=;
        b=J7A03fcq6bX5nWDXODfrfwoyuUGPjfa7chFuRo2TPD+7goaB40SBkbW4Xto5jkU4xX
         C8H1omZlj6UlASwls0BrHY9UEfZn7NU255trKjja3Hi/JlLbuBXthlV9UD/mT2IkqHg4
         9zvUqWbMGuXnYbnKY+xtQfQNQUQykwJG7L6t0jjaSSa0Ap7XxP8AO/DZj+UTc7Z5Fli/
         i7o389nArRNR4GqU4ofkA8aHGlhKF+xh8Adg15p/zYQmvaBB6X/p9qOv3Ygcbn4L9FD8
         p+zdZGAdzHexHUThpwYH5YVpL+2alakEqKGD7WPiGU6w8eSK/QVRTim47zKCCrvAn15y
         BOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=otoclXzkeEyh1j5woX95Y4BqIi75kMI2Nh4wsDY6AGA=;
        b=JJwOshXAAPQDsbZiTyb2KSO17ov98jl465E9JqB/sujCa+U99ayCIHr8YBX4C7rbd7
         s4s9+PfeqbJ1jfTfdaELkc1+qdSrgI4KNc9JbGhUS4YO9FdwOwYD8OTDKFLrr6tyffd6
         sdCOJGchdYvujL/MycYQaFw5I9HqtXHAoINr54JuOW7u765tox4iiY5DcN5yq47uLJ9P
         +zk2bRjFZ4OdN1TXr8R+mgr586xC4YSDZ6Cd5v8akGDcrir25Ts6VSjlnATF621sjsK6
         wqjvCK/38szXqa0+6FffCfeqPh91MkZtqttt28kf5cBm48LvXuaJL2WmiC9X5FV/ia4m
         3eHg==
X-Gm-Message-State: AOAM532P5e5WaacbRAD+KVoXDXNUP6pwSn9lj0s/GTDxGzdyomOCbww/
        dOBAKCY177+8dtmCz5LqVCrsaFzhxNuJFwWilbKolg==
X-Google-Smtp-Source: ABdhPJxZtjAMA83btV+BO9F4/YYS/EF5aCSpX1bcziNEwxakUBREbdF/05VAQ5f5ze/rU14PN/ocF642baXn5FVE/HE=
X-Received: by 2002:a92:870f:: with SMTP id m15mr4804880ild.2.1631463723915;
 Sun, 12 Sep 2021 09:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210910232249.739661-1-irogers@google.com> <YTz3YFXpJ0UT3R7z@kernel.org>
 <YTz8DL1Nuwp+XmzE@kernel.org>
In-Reply-To: <YTz8DL1Nuwp+XmzE@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 12 Sep 2021 09:21:51 -0700
Message-ID: <CAP-5=fVQ7Y1XUmUx74D4ipX59yWGWAi62SdybsQT6OFhhPRr_w@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Ignore Documentation dependency file
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 11:57 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Sat, Sep 11, 2021 at 03:37:20PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Sep 10, 2021 at 04:22:49PM -0700, Ian Rogers escreveu:
> > > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > Fixes: a81df63a5df3 ("perf doc: Fix doc.dep")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Thanks for the patch, but you forgot to mention _why_ we should ignore
> > that file, I'll try to figure out.
>
> Added this, probably anodine, but better than nothing :-)
>
> ---
> When building directly on the checked out repository the build process
> produces a file that should be ignored, so add it to .gitignore.
> ---

Sounds good to me.

Thanks,
Ian

> - Arnaldo
> >
> > > ---
> > >  tools/perf/.gitignore | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
> > > index e555e9729758..8e0163b7ef01 100644
> > > --- a/tools/perf/.gitignore
> > > +++ b/tools/perf/.gitignore
> > > @@ -39,3 +39,4 @@ pmu-events/jevents
> > >  feature/
> > >  fixdep
> > >  libtraceevent-dynamic-list
> > > +Documentation/doc.dep
> > > --
> > > 2.33.0.309.g3052b89438-goog
> >
> > --
> >
> > - Arnaldo
>
> --
>
> - Arnaldo
