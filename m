Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5986B3B2167
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 21:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhFWTvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 15:51:02 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:43567 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWTvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 15:51:02 -0400
Received: by mail-lf1-f43.google.com with SMTP id x24so6020944lfr.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 12:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G5D/PwsjDpv7DvaHtR2MB7NGnoQW40MbXSgb7YAM9jc=;
        b=Ue0hZhGehaC76DHFzN6gm4ooDWvKWIpHEbWx/HEKKYXgYLpXJGLNSaY5lD8GwouN0f
         /PZTqYcEZnXsh02orbEB6EckaQQF30Uscz7B0EknSC14zI8k1c4vn9jqj3k5Chkjs+Lo
         xTNBzvQR20BJCWOX080Xplqh01AR7LTr6HE6nqizb4K4gmm3LxJ8GnRPbv2DRr1UKiQ/
         6fLEfII4+Szrl8TkoKLylFwN3/csOvK8lAQ+cdVnhbP4ak3jdbFFDqiRIYuKHCdSPq5i
         qDGev3ErRiJAGOJ1TIbgImcoY8YFRmNOwnPryZ+jbF5EEsdm2qhFLjOjtM7ddeCDhBFP
         TwXA==
X-Gm-Message-State: AOAM531rgnaHex5qVmaV5PWYv3dq/jp91UdFHYxkEnWQ/VwXuXHtoFEv
        1x9JoqfZJQiGquPDZ1p07uITEvi6xbZfOmGo1GU=
X-Google-Smtp-Source: ABdhPJwXUOVHy5gJfpp9i52qpr0Gu7+xN6XN5qWU8DWyyBYa2q4+026OY+JyfGOX94JonAR0+OHK82h+u5MPAdL+kDM=
X-Received: by 2002:a05:6512:20ce:: with SMTP id u14mr929666lfr.300.1624477722217;
 Wed, 23 Jun 2021 12:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210622153918.688500-1-jolsa@kernel.org> <YNIgXkH1xaF7H3Tr@kernel.org>
 <CAP-5=fU=AAJ0_s1orsF=OCO0=bSmr9BhAmtN251bU_pf0ZFJ6Q@mail.gmail.com>
 <YNIobHgfVbiiNscn@kernel.org> <YNJT0wvghSZzPJ8Y@krava>
In-Reply-To: <YNJT0wvghSZzPJ8Y@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 23 Jun 2021 12:48:30 -0700
Message-ID: <CAM9d7chs=4mdRG389G8eDzeKmvB7PDuWp7mxd_ScuFiy0hYt3g@mail.gmail.com>
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

Hi Jiri,

Thanks for your work!

On Tue, Jun 22, 2021 at 2:19 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jun 22, 2021 at 03:14:04PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jun 22, 2021 at 10:47:54AM -0700, Ian Rogers escreveu:
> > > On Tue, Jun 22, 2021 at 10:39 AM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > Em Tue, Jun 22, 2021 at 05:39:08PM +0200, Jiri Olsa escreveu:
> > > > > hi,
> > > > > this *RFC* patchset adds support to detect faults during
> > > > > mmap2's build id parsing and a way to fix such maps in
> > > > > generated perf.data.
> > > > >
> > > > > It adds support to record build id faults count for session
> > > > > and store it in perf.data and perf inject support to find
> > > > > these maps and reads build ids for them in user space.
> > > >
> > > > > It's probably best explained by the workflow:
> > > > >
> > > > >   Record data with --buildid-mmap option:
> > > > >
> > > > >     # perf record --buildid-mmap ...
> > > > >     ...
> > > > >     [ perf record: Woken up 1 times to write data ]
> > > > >     [ perf record: Failed to parse 4 build ids]
> > > > >     [ perf record: Captured and wrote 0.008 MB perf.data ]
> > > > >
> > > > >   Check if there's any build id fault reported:
> > > > >
> > > > >     # perf report --header-only
> > > > >     ...
> > > > >     # build id mmap stats: FAULTS 4, LOST 0, NOT FIXED
> > > > >
> > > > >   There is, check the stats:
> > > > >
> > > > >     # perf report --stat
> > > > >
> > > > >     Aggregated stats:
> > > > >              TOTAL events:        104
> > > > >                       ....
> > > > >            BUILD_ID fails:          4  (14.3%)
> > > > >
> > > > >   Yep, let's fix it:
> > > > >
> > > > >     # perf inject --buildid-mmap2 -i perf.data -o perf-fixed.data
> > > >
> > > > Can we make it possible to automate this with --fixup-buildids or a
> > > > perfconfig 'record' knob?
> > > >
> > > > This would entail requesting that build-ids that _fail_ be sent to the
> > > > side-band thread we have in 'perf record', this way we wouldn't have to
> > > > traverse the whole perf.data file, be it with 'perf-record' at the end
> > > > of a session with faulty build ids, or in a similar fashion using 'perf
> > > > inject' as you suggest.
> > > >
> > > > I even think that we can have all these modes and let the user to decide
> > > > how important is this for them and how convenient they want the whole
> > > > process to be.
>
> right, that might be good to decide first.. because as I said,
> I never hit faulted build id, so it probably needs the special
> setup you guys are using.. could you try on your setup and check
> how many faulted build ids you see?

Did you check data mmaps?  It might be easy to get faults
from data files and we don't know if it's an ELF or not
before reading the ELF header in the first page.

I'm not sure if we can limit it to exec mappings, there might
be data-only DSOs and we may want to symbolize them too.

Thanks,
Namhyung
