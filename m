Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DC33E896A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 06:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbhHKEef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 00:34:35 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:46602 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhHKEee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 00:34:34 -0400
Received: by mail-lj1-f171.google.com with SMTP id h17so2345029ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 21:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+JyTIpyUoOH+FpHRKLiZgIeYXX8zEGMVThj9kDtlYpc=;
        b=PzZK2iX4HdZypOyoDUPK1IfE+cJLPaSvU5604zFupruwEQfyjylnLXuxwbA3XUB/Fx
         WMi6ftOQvqbZB/txFnsOUyfQtOLj0rBW3d2pgIDMcoPYbi4n6hEGpI/o8Tk37e1KJhes
         0c1+IrFbTtb8eSKdotbVmphgWgrrifZfUSbmWinnCJ8SNO6VHri4KcNtjnCJZQ8ehLca
         4BaILAkjzmSiePS/lXgnTt9GONgLwuQOOlXWX/L9gpp7iNpzj5fxw4FUmgMTW9bmpDF9
         rWp+vcXOUSBmjIOAmGA4fZf0UuKOBpKfI6IFQZE/IOSD6SCIkF0f7Ojd+q+X6X1TmFjq
         KT8Q==
X-Gm-Message-State: AOAM531/pQJR3qiWj/CaEWu5QPSZ6FY2K31FCphsDsyAmYqn3phqQsvh
        naI66QBeofvrboTXdW635LslCcGhqYYxcSCb07Y=
X-Google-Smtp-Source: ABdhPJzzXj90/px8vI6WeKdY5VSWQADo/rsoqUEf8QnlfMqYmnPa913w3e4I6kZFm76uZuvXzdcJNABj/Ut5FFl9nFQ=
X-Received: by 2002:a05:651c:38f:: with SMTP id e15mr21496438ljp.233.1628656450266;
 Tue, 10 Aug 2021 21:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210724040129.2268452-1-namhyung@kernel.org> <20210724040129.2268452-2-namhyung@kernel.org>
 <YP61gJD91GwvfzwT@krava>
In-Reply-To: <YP61gJD91GwvfzwT@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 10 Aug 2021 21:33:59 -0700
Message-ID: <CAM9d7ci24NW9mn6FBOER_ut=AmgSB5x=8xD8Xhakt1Sxz+62vw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf record: Add --synth option
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Mon, Jul 26, 2021 at 6:15 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Jul 23, 2021 at 09:01:29PM -0700, Namhyung Kim wrote:
> > Add an option to control synthesize behavior.
> >
> >     --synth <no|all|task|mmap|cgroup>
> >                       Fine-tune event synthesis: default=all
> >
> > This can be useful when we know it doesn't need some synthesis like
> > in a specific usecase and/or when using pipe:
> >
> >   $ perf record -a --all-cgroups --synth cgroup -o- sleep 1 | \
> >   > perf report -i- -s cgroup
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/Documentation/perf-record.txt |  9 +++++
> >  tools/perf/builtin-record.c              | 48 +++++++++++++++++++-----
> >  tools/perf/util/record.h                 |  1 +
> >  tools/perf/util/synthetic-events.c       | 28 ++++++++++++++
> >  tools/perf/util/synthetic-events.h       | 12 ++++++
> >  5 files changed, 89 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> > index d71bac847936..03a41bec0583 100644
> > --- a/tools/perf/Documentation/perf-record.txt
> > +++ b/tools/perf/Documentation/perf-record.txt
> > @@ -596,6 +596,15 @@ options.
> >  'perf record --dry-run -e' can act as a BPF script compiler if llvm.dump-obj
> >  in config file is set to true.
> >
> > +--synth=TYPE::
> > +Collect and synthesize given type of events (comma separated).
> > +Available types are:
> > +  'task'    - synthesize FORK and COMM events for each task
> > +  'mmap'    - synthesize MMAP events for each process (implies 'task')
> > +  'cgroup'  - synthesize CGROUP events for each cgroup
> > +  'all'     - synthesize all events (default)
> > +  'no'      - do not synthesize any of the above events
>
> this only affects events we take from proc right?

Right.

>
> should we perhaps mention it, because you'll get mmap
> events from kernel even if you specify --synth=task

Good point, will update.

Thanks,
Namhyung
