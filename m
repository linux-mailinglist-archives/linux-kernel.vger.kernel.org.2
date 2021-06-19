Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9A23AD7E3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 06:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhFSErc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 00:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbhFSEra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 00:47:30 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A33C061760
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 21:45:19 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o3so12993321wri.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 21:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=idsAK6GUcXFkxK0P/rvOOxu0Fst33XB043NfWRK/EsI=;
        b=SvnQNhK5Fw2psUOj4KHtI/SAF52lMkQiVEXCSX4RJRXPpY/8BpY60EV/m2Aa9A4g2J
         RmIjnCzLmcmtCV757thEy4OsBlq0DdNvzebs3PeYpiznHTu/bMXWUUf8ULIftJeuibUx
         +I/HE9M+Sb+q8CmGRY034/OZouxVGbl6NkSzhdf0+DFtmNbdt5u+sHhfu7GcYeiOx7m6
         cW1jC5H9O6K7nhAso75Pi60OcHii0DIVHfiwjOxifhA+wn8yCCTXeZ70JPvhfyNEY7hv
         S4GiUyHTZETcOCSdJblRNhoEQdt+PtnpLdIoyvI21Jwc+ebe4iPwcXMocB7Gkc+wzKkQ
         udUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=idsAK6GUcXFkxK0P/rvOOxu0Fst33XB043NfWRK/EsI=;
        b=JnDKHMEdITsTdcVR8JEOn1ocFlymneU8yyyAwqPosAeyba+VTKQsb6cIrnRat7LZXw
         UCf6YTzlFf/I1hx9PjaTzMQnRQBCW/xnM3WKkR8yT9sbFnydV+E6+NLNYa3minYIrgk8
         rGHm5O30fhfKGOG5JsB0iySr+YzfDdt4dNngezvaniiGWC4O13U+D2ZXaWP3v4PHjHgs
         MKN2fumevO6tGzRHwx36BlhKaiqf+aBQM2cHoMSg8hwP3sOAaA02+LJf4w6IEJoVFyRx
         3PZt6T7aw1WQXb5k0o+TTjbpZf5t1l/TzWriuFDf7n6xXyiqRRxN4bPNIjButqyq8vrc
         Eu0w==
X-Gm-Message-State: AOAM530p/qbihuqc6bTBubbYylfKxssCFmXYmv3ka8leiVyNszIkFY6C
        BPRFneFZuPTyxS/TfeA6qq/rfaMnZQORdpl3dGig9Q==
X-Google-Smtp-Source: ABdhPJzRdAi53rmEs5yNcu8lpH3vJulYPlhvTRikeoGaCYRL/vh2fMrYN5Lb/d6rikq3nOqtev+5bHzoG6T8YTvdB30=
X-Received: by 2002:a05:6000:1c1:: with SMTP id t1mr15550367wrx.282.1624077917613;
 Fri, 18 Jun 2021 21:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210617184216.2075588-1-irogers@google.com> <20210617184216.2075588-2-irogers@google.com>
 <YMugKlkH7lTWxTQ/@kernel.org> <YMzOpgZPJeC2jGKf@kernel.org>
In-Reply-To: <YMzOpgZPJeC2jGKf@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 18 Jun 2021 21:45:05 -0700
Message-ID: <CAP-5=fXFgOz5V3_yCHEENtRsQdgCDEK=fWMri84FPD1ivC2w+A@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf test: Pass the verbose option to shell tests
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 9:49 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Jun 17, 2021 at 04:19:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Jun 17, 2021 at 11:42:14AM -0700, Ian Rogers escreveu:
> > > Having a verbose option will allow shell tests to provide extra failure
> > > details when the fail or skip.
> >
> >
> > Thanks, applied to perf/core.
> >
> > - Arnaldo
> >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/tests/builtin-test.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > > index cbbfe48ab802..a8160b1684de 100644
> > > --- a/tools/perf/tests/builtin-test.c
> > > +++ b/tools/perf/tests/builtin-test.c
> > > @@ -577,11 +577,14 @@ struct shell_test {
> > >  static int shell_test__run(struct test *test, int subdir __maybe_unused)
> > >  {
> > >     int err;
> > > -   char script[PATH_MAX];
> > > +   char script[PATH_MAX + 3];
> > >     struct shell_test *st = test->priv;
> > >
> > >     path__join(script, sizeof(script), st->dir, st->file);
>
> probably you need to add a  '- 3' after the sizeof above, right?

Either way is fine, but -3 is ok with me.

> > >
> > > +   if (verbose)
> > > +           strncat(script, " -v", sizeof(script));
> > > +
>
> Seemed simple enough, but gcc knows better, I'm removing this one:
>
>     tests/builtin-test.c:586:26: error: the value of the size argument in 'strncat' is too large, might lead to a buffer overflow [-Werror,-Wstrncat-size]
>                     strncat(script, " -v", sizeof(script));
>                                            ^~~~~~~~~~~~~~
>     tests/builtin-test.c:586:26: note: change the argument to be the free space in the destination buffer minus the terminating null byte
>                     strncat(script, " -v", sizeof(script));
>                                            ^~~~~~~~~~~~~~
>                                            sizeof(script) - strlen(script) - 1
>     1 error generated.
>     make[3]: *** [/git/perf-5.13.0-rc4/tools/build/Makefile.build:139: tests] Error 2
>   77    31.98 ubuntu:21.04                  : FAIL gcc version 10.3.0 (Ubuntu 10.3.0-1ubuntu1)
>     tests/builtin-test.c:586:26: error: the value of the size argument in 'strncat' is too large, might lead to a buffer overflow [-Werror,-Wstrncat-size]
>                     strncat(script, " -v", sizeof(script));
>                                            ^~~~~~~~~~~~~~
>     tests/builtin-test.c:586:26: note: change the argument to be the free space in the destination buffer minus the terminating null byte
>                     strncat(script, " -v", sizeof(script));
>                                            ^~~~~~~~~~~~~~
>                                            sizeof(script) - strlen(script) - 1
>     1 error generated.
>     make[3]: *** [/git/perf-5.13.0-rc4/tools/build/Makefile.build:139: tests] Error 2

Thanks gcc :-) Do you want me to resend the patch?

Ian

> > >     err = system(script);
> > >     if (!err)
> > >             return TEST_OK;
> > > --
> > > 2.32.0.288.g62a8d224e6-goog
> > >
> >
> > --
> >
> > - Arnaldo
>
> --
>
> - Arnaldo
