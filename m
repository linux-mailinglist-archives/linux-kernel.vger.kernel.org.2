Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE063C6B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 09:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbhGMHii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 03:38:38 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:36452 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbhGMHih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 03:38:37 -0400
Received: by mail-lf1-f45.google.com with SMTP id y42so48651224lfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 00:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EhWuX2EvTnqJ7KMQxrrRRWobsR5fM1g5m3LwftrzoMY=;
        b=udlYz2TTRjLEuevXXcD8lt/wApz+2JXYory7HaJ1KXbx8A+lhFDdccflkLBCHNeu42
         YNvDeOsFvBuyIXwwxNxmGHy2iTjol/eb1kUepPeRwhpDxQVkBIXEvvprnXYPJiyDNFp2
         bfpiGbwahCYUO9+DFaDUhlAEVrC34I+UmTd9ElHjT8hLMN4lfABZh60AnAJs0I6MAjb3
         R2K1aIrwprl0GHYDnIjftWNhUy26pnIDcx2SpnxRYNJOrmwyO3y0mPrq4wzxXU3cl/Ic
         0ZrX3zORC+hdCwngnOYLeEy4e6X0sVRgfxXcYZ1sDSoizYsP0FhDBDcGVRqyAd2IeTE6
         9Qhg==
X-Gm-Message-State: AOAM532mYxsqLNJXGYFg/he8VAmJ3EzdvLLXNDTDawkJ1biwtASqCnBI
        dG9mURTxi8KqyKu2ktnBj9Nhzcn9sGM/pL/sdjE=
X-Google-Smtp-Source: ABdhPJwHhW7K1zTg17q6f9toS4MS8lEEqLQYS5Fzv36c0OnzNoJbxW01A5tzLbGvLmHv2OXe9eZZDinIq6YPjgL0I8o=
X-Received: by 2002:a19:4916:: with SMTP id w22mr2549515lfa.374.1626161746026;
 Tue, 13 Jul 2021 00:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210707180536.72175-1-namhyung@kernel.org> <20210707180536.72175-5-namhyung@kernel.org>
 <YOsRxDnAgE7zNOVP@krava>
In-Reply-To: <YOsRxDnAgE7zNOVP@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 13 Jul 2021 00:35:34 -0700
Message-ID: <CAM9d7cjOsyn3ZRVYEP4fAjvK6AiAd-LagkYSeyH-R9fDmgW4gg@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf inject: Fix output from a file to a pipe
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Sun, Jul 11, 2021 at 8:44 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Jul 07, 2021 at 11:05:36AM -0700, Namhyung Kim wrote:
>
> SNIP
>
> > +     if (!data.is_pipe && inject.output.is_pipe) {
> > +             ret = perf_header__write_pipe(perf_data__fd(&inject.output));
> > +             if (ret < 0) {
> > +                     pr_err("Couldn't write a new pipe header.\n");
> > +                     goto out_delete;
> > +             }
> > +
> > +             ret = perf_event__synthesize_attrs(&inject.tool,
> > +                                                inject.session->evlist,
> > +                                                perf_event__repipe);
> > +             if (ret < 0) {
> > +                     pr_err("Couldn't inject synthesized attrs.\n");
> > +                     goto out_delete;
> > +             }
> > +
> > +             ret = perf_event__synthesize_features(&inject.tool,
> > +                                                   inject.session,
> > +                                                   inject.session->evlist,
> > +                                                   perf_event__repipe);
> > +             if (ret < 0) {
> > +                     pr_err("Couldn't inject synthesized features.\n");
> > +                     goto out_delete;
> > +             }
> > +
> > +             if (have_tracepoints(&inject.session->evlist->core.entries)) {
> > +                     /*
> > +                      * FIXME err <= 0 here actually means that
> > +                      * there were no tracepoints so its not really
> > +                      * an error, just that we don't need to
> > +                      * synthesize anything.  We really have to
> > +                      * return this more properly and also
> > +                      * propagate errors that now are calling die()
> > +                      */
> > +                     ret = perf_event__synthesize_tracing_data(&inject.tool,
> > +                                             perf_data__fd(&inject.output),
> > +                                             inject.session->evlist,
> > +                                             perf_event__repipe);
> > +                     if (ret <= 0) {
> > +                             pr_err("Couldn't inject tracing data.\n");
> > +                             goto out_delete;
> > +                     }
> > +             }
> > +     }
>
> hum.. how bad (too many args?) would be to put this to some function
> in util/record.c, because it's copied directly from builtin-record.c

I don't think they're too many.  Will try to factor it out.

Thanks,
Namhyung
