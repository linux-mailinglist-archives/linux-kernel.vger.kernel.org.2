Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16293B57EB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 05:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhF1Dlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 23:41:46 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:44861 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhF1Dlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 23:41:45 -0400
Received: by mail-lj1-f169.google.com with SMTP id u25so7760472ljj.11
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 20:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TA9GkBikXPkJmyUCmRN+fLpWXV97fC3gAkW1HN3aY3A=;
        b=SJOnmEDzsOmte1Cwt5WWx6xVcQt7vODZxGo2CjiXS2aWTvgxjNc6YM64KqRwjI7U/k
         8nRERv6wPamq12OwLBtexFMJL6LwB6UHxLt4Gv803TvIBftClLZrHe/RubkbKGfWSi88
         eulX/vV9rprvdwLkP2P+2IPXj3WYCCldD16+jLbjJBTNJ9GBuQmjY9PjI7rq3i5YaxRY
         0k+PV1N3XnxJcH5tgXnj0Atb1enLMCtgTChJOYf4iBueaiJgQUpw6JLzVr5O89k5PtYs
         +LlUzUZvogif8bg/CgFjT+28qa21ducUSCW17Wly7OJAM/4+RhXVqsVn0lMCXZ3mmgkz
         u50w==
X-Gm-Message-State: AOAM532Z5khF8a9aY10hdH5ZXtgJYd2szWEaqLftb6FgfE0sKR4dUMwQ
        HmR2YX4/wT4fozIGmAz4KG2HaSnnNABPjlRTLAU=
X-Google-Smtp-Source: ABdhPJylA0BUC2OsncY/Qwk7/NHW3cORubGPCJoOy76H21YfiKPDZr8alwWFDLfz25eHHpJ+5DYfffNjqh3l9MzOWA0=
X-Received: by 2002:a2e:8e82:: with SMTP id z2mr18085641ljk.275.1624851558515;
 Sun, 27 Jun 2021 20:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210622153918.688500-1-jolsa@kernel.org> <YNIgXkH1xaF7H3Tr@kernel.org>
 <CAP-5=fU=AAJ0_s1orsF=OCO0=bSmr9BhAmtN251bU_pf0ZFJ6Q@mail.gmail.com>
 <YNIobHgfVbiiNscn@kernel.org> <YNJT0wvghSZzPJ8Y@krava> <CAM9d7chs=4mdRG389G8eDzeKmvB7PDuWp7mxd_ScuFiy0hYt3g@mail.gmail.com>
 <YNi0j8nhh8X6j/ZE@krava>
In-Reply-To: <YNi0j8nhh8X6j/ZE@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 27 Jun 2021 20:39:07 -0700
Message-ID: <CAM9d7cheTJDq89BypiFwC8wEZ9VMUaZjN7JWVM3+AXR4kgjBAA@mail.gmail.com>
Subject: Re: [RFC 00/10] perf: Add build id parsing fault detection/fix
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2021 at 10:25 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Jun 23, 2021 at 12:48:30PM -0700, Namhyung Kim wrote:
> > Hi Jiri,
> >
> > Thanks for your work!
> >
> > On Tue, Jun 22, 2021 at 2:19 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Tue, Jun 22, 2021 at 03:14:04PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Em Tue, Jun 22, 2021 at 10:47:54AM -0700, Ian Rogers escreveu:
> > > > > On Tue, Jun 22, 2021 at 10:39 AM Arnaldo Carvalho de Melo
> > > > > <acme@kernel.org> wrote:
> > > > > >
> > > > > > Em Tue, Jun 22, 2021 at 05:39:08PM +0200, Jiri Olsa escreveu:
> > > > > > > hi,
> > > > > > > this *RFC* patchset adds support to detect faults during
> > > > > > > mmap2's build id parsing and a way to fix such maps in
> > > > > > > generated perf.data.
> > > > > > >
> > > > > > > It adds support to record build id faults count for session
> > > > > > > and store it in perf.data and perf inject support to find
> > > > > > > these maps and reads build ids for them in user space.
> > > > > >
> > > > > > > It's probably best explained by the workflow:
> > > > > > >
> > > > > > >   Record data with --buildid-mmap option:
> > > > > > >
> > > > > > >     # perf record --buildid-mmap ...
> > > > > > >     ...
> > > > > > >     [ perf record: Woken up 1 times to write data ]
> > > > > > >     [ perf record: Failed to parse 4 build ids]
> > > > > > >     [ perf record: Captured and wrote 0.008 MB perf.data ]
> > > > > > >
> > > > > > >   Check if there's any build id fault reported:
> > > > > > >
> > > > > > >     # perf report --header-only
> > > > > > >     ...
> > > > > > >     # build id mmap stats: FAULTS 4, LOST 0, NOT FIXED
> > > > > > >
> > > > > > >   There is, check the stats:
> > > > > > >
> > > > > > >     # perf report --stat
> > > > > > >
> > > > > > >     Aggregated stats:
> > > > > > >              TOTAL events:        104
> > > > > > >                       ....
> > > > > > >            BUILD_ID fails:          4  (14.3%)
> > > > > > >
> > > > > > >   Yep, let's fix it:
> > > > > > >
> > > > > > >     # perf inject --buildid-mmap2 -i perf.data -o perf-fixed.data
> > > > > >
> > > > > > Can we make it possible to automate this with --fixup-buildids or a
> > > > > > perfconfig 'record' knob?
> > > > > >
> > > > > > This would entail requesting that build-ids that _fail_ be sent to the
> > > > > > side-band thread we have in 'perf record', this way we wouldn't have to
> > > > > > traverse the whole perf.data file, be it with 'perf-record' at the end
> > > > > > of a session with faulty build ids, or in a similar fashion using 'perf
> > > > > > inject' as you suggest.
> > > > > >
> > > > > > I even think that we can have all these modes and let the user to decide
> > > > > > how important is this for them and how convenient they want the whole
> > > > > > process to be.
> > >
> > > right, that might be good to decide first.. because as I said,
> > > I never hit faulted build id, so it probably needs the special
> > > setup you guys are using.. could you try on your setup and check
> > > how many faulted build ids you see?
> >
> > Did you check data mmaps?  It might be easy to get faults
> > from data files and we don't know if it's an ELF or not
> > before reading the ELF header in the first page.
>
> well, AFAICS the mmap event is sent right after the elf file
> is loaded, so it does not have a chance to be swapped out

I'm talking about the normal data files when we use
perf record -d.  Those mmap files might not have page 0
in memory.  I'm afraid it's reported as a build-id fault.

Thanks,
Namhyung
