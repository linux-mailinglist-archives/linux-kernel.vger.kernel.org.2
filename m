Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E063B0A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 18:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhFVQfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 12:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVQfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 12:35:52 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1211C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 09:33:36 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c84so13191016wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 09:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=inSC13iBgpJglxK3ELtc1IM/WTbt8WqbVGB4cdlDbJM=;
        b=oiz6ZRUUe2OJ+WNOR2ml1jBZfrcw3QbLLlWIB0etFcnSwrKkN9izWcKvR72jpttb6V
         uvR+pLUe7PZ89vMKc3DhnctQ4/VSwpYuRmfQdE0+lrHOIw3+OcmYRYTHTYzxXK3NqObQ
         xBK2l0ZPcu7YodaZPSa4XaLQ4yTCEDEXuFuSJR35WOtLkxIY206z0eGizlGnIPZHqpAD
         0D4mMpoDjWS3SP0/OEWwTcL+STivOH0Oew9Q1h/9Bu/TtePY7plfC4bzULOQHGRRbybo
         4Q0MU+8+mOXp4TPYL8bjmufwZAGzck8+Q3Lo0gWsn4mWk3PQv3aHdbLj6zGXuLjojw7z
         fGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=inSC13iBgpJglxK3ELtc1IM/WTbt8WqbVGB4cdlDbJM=;
        b=YnB6k4bvzBluoHSmysVlUJBOr+ec9Mhh7tGHH5iNMgads5/o2Tg3xRmJUFA+SJ7UZp
         ON4sJjxHyoB4Mtqj6cruZ5Ri7HwvdTubCcP/r+H0/GXr345/eEtVcm1JFHnX5v1wHVjn
         WP7Rm+/jBPQoXSUIrkFVbm9vN5W5/hTsZU93ejJcl33sSSZZg8+k44jlvXbZwA4jXu/O
         peDw0sh4zb+8LW3h+F42JkL6/uvY9aPOrHWTgxSt5k33LHxV+hhbAvW7og7Hp35htkJd
         76kWEQRyoilKiXs23WghBdpK7703QaKhv5Bwe8ODwLD4o3OXl67gJOf5lzbqT6naGJfO
         CApQ==
X-Gm-Message-State: AOAM530aup7BaWVMe3ebLVZNFfwKmdFA2SrlhrucMBZl1i7XF/F2vZ94
        YPiHInRWVGW1F4XWJ8bFHUYMOPQbUO/0qlPLhIV8+w==
X-Google-Smtp-Source: ABdhPJwhMjka4VNBDn3jeaT0K7fk/yfCHXn7x381RNvqMWF3IOsPjbSkhckpl//TWGiaTCcKBhzM7T1Dj9+BLXIMIeo=
X-Received: by 2002:a05:600c:1d0a:: with SMTP id l10mr5669289wms.124.1624379615206;
 Tue, 22 Jun 2021 09:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210621234317.235545-1-rickyman7@gmail.com> <20210621234317.235545-3-rickyman7@gmail.com>
 <CAP-5=fUGRdj=G6=srwoATWMimK5tB4X2Sxa64tTVk_JRwMJdWg@mail.gmail.com> <d4921abf8dcff02245ccf7ad8edfd8048e926936.camel@gmail.com>
In-Reply-To: <d4921abf8dcff02245ccf7ad8edfd8048e926936.camel@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 22 Jun 2021 09:33:23 -0700
Message-ID: <CAP-5=fXGJXmpddPVEjmCCv9oC7bmum3p+1m1m6rem8Pdy+XaXA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf script: delete evlist when deleting session
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Tue, Jun 22, 2021 at 12:44 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> Hi,
>
> thanks for your comments.
>
> On Mon, 2021-06-21 at 22:14 -0700, Ian Rogers wrote:
> > On Mon, Jun 21, 2021 at 4:44 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
> > >
> > > ASan reports a memory leak related to session->evlist never being deleted.
> > > The evlist member is not deleted in perf_session__delete, so it should be
> > > deleted separately.
> > > This patch adds the missing deletion in perf-script.
> > >
> > > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> > > ---
> > >  tools/perf/builtin-script.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > > index 1280cbfad4db..635a1d9cfc88 100644
> > > --- a/tools/perf/builtin-script.c
> > > +++ b/tools/perf/builtin-script.c
> > > @@ -3991,7 +3991,7 @@ int cmd_script(int argc, const char **argv)
> > >                 zfree(&script.ptime_range);
> > >         }
> > >
> > > -       evlist__free_stats(session->evlist);
> >
> > Should this be removed?
>
> Probably not. I originally thought this was already taken care of by
> evlist__delete, but it's not.
> Oddly, this issue is not causing a memory leak in my simple test.
>
> >
> > > +       evlist__delete(session->evlist);
> >
> > If the perf session "owns" the evlist, would it be cleaner to add this
> > to perf_session__delete?
>
> I thought about that too, but that's not always true.
> E.g., in perf-record, __cmd_record calls perf_session__delete,then cmd_record
> calls evlist__delete on rec->evlist, which points to the same location to which
> session->evlist pointed.

Agreed. I find it hard to understand the ownership properties in the
perf code. The missing delete is an example of the owner of the evlist
(the caller) not "knowing" it needed cleaning up. I'd like it if we
documented things like perf_sessions' evlist to say not owned, user
must clean up. The makes it unambiguous who has to take
responsibility. Having things clean up after themselves is of course
easiest, hence wanting this to be in perf_session__delete.

Fwiw, I've been reading around things like sparse [1, 2] and Clang's
similar analysis [3] that people have looked to use like sparse [4]. I
don't see anything that handles memory allocation lifetimes, but
perhaps something will feed into C's standards by way of C++ [5].
Perhaps people have ideas to rewrite in checked C or Rust :-)

Some thoughts:
1) we can't have C++ as we're trying to follow kernel conventions [6]
2) we can't annotate code for things like sparse or thread safety
analysis, as checking for memory errors is out of scope for them, the
annotations don't exist, etc.
3) we can add comments, document the rules around pointers, perhaps
even invent empty annotations that may one day help with automated
checking.
4) we can try to clean up the ownership model to make bugs less likely.

I've heard concerns on non-kernel projects about annotation litter and
comments adding to complexity. I think your patch is good, it follows
the existing conventions. I wonder if we can learn something from the
fact the code was wrong to make it less likely we have wrong code in
the future. I'd be interested to hear what others think.

Thanks,
Ian

[1] https://lore.kernel.org/lkml/Pine.LNX.4.58.0410302005270.28839@ppc970.osdl.org/
[2] https://lwn.net/Articles/689907/
[3] https://clang.llvm.org/docs/ThreadSafetyAnalysis.html
[4] https://www.openwall.com/lists/kernel-hardening/2019/05/20/3
[5] https://github.com/isocpp/CppCoreGuidelines/blob/master/docs/Lifetime.pdf
[6] even concatenating a string is error prone in C :-(
https://lore.kernel.org/lkml/YMzOpgZPJeC2jGKf@kernel.org/

> Thanks,
> Riccardo
>
> >
> > Thanks,
> > Ian
> >
> > >         perf_session__delete(session);
> > >
> > >         if (script_started)
> > > --
> > > 2.31.1
> > >
>
>
