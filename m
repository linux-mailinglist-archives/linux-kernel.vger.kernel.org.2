Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7A036A8BB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 20:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhDYSEC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Apr 2021 14:04:02 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:39479 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhDYSEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 14:04:00 -0400
Received: by mail-lj1-f176.google.com with SMTP id s9so3469675ljj.6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 11:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q5J9xudjoo8hMtcXfHkZfDpyQujMZHxCp1k4/7VO9A0=;
        b=UCADVueLQK2J2LzMtxcgBzv3fobpDKLigXNTGK9IvqmHug0Z8O8PC5GHq5bBJJ/7pr
         CQcld2MNGAnxhMawibGXI/A5/nhPE/4GUUC/ssnUC9h7BXY+4tCirDjvI/MH64aNB2is
         19vObkYjBwoRVR5drmit1esStAuIKKeznVfhMka5jmtoS1iI2S7F68hkovNpyJtHr9Kg
         Ss4jJ1SjFAxEh4c0P9+p85opq/A+Quf8OEqREbcNKogdVqZc03pJOQdVbDurpqf90jKM
         oZHYkt9iwnkmbION9/9TdwcZjVFTCbP9L7uUBGm3H0YqNew2Nt4LX8BfhUAP+urThtow
         DLHg==
X-Gm-Message-State: AOAM531Y3cOcTsfSbWrXXjFSMIy2AgfszrD8LT9t6pPnOv1d/m3GIclG
        4tHGZEN1TAN0mtbDz5UPKsaVcMvE2DV2GBk8K9U=
X-Google-Smtp-Source: ABdhPJzgyq0JjMgaCwcS5Q8NB5t+t5+27oSfDZjG79ipsnow1Y5x9vhwblv4cAZtyHeKnxhyGSb1zZjl3RKyI5kwF1A=
X-Received: by 2002:a2e:9015:: with SMTP id h21mr9880223ljg.233.1619373797875;
 Sun, 25 Apr 2021 11:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210423182813.1472902-1-namhyung@kernel.org> <20210423184647.GN1401198@tassilo.jf.intel.com>
 <YIQNtxTku/JihU+s@krava>
In-Reply-To: <YIQNtxTku/JihU+s@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 26 Apr 2021 03:03:06 +0900
Message-ID: <CAM9d7chb5dGKYAKg0Q==tYetzXoTuac9FnBQ+V16D0OB57JABw@mail.gmail.com>
Subject: Re: [PATCHSET 0/5] perf report: Make --stat output more compact
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 24, 2021 at 9:23 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Apr 23, 2021 at 11:46:47AM -0700, Andi Kleen wrote:
> > > So I added --skip-empty (and --no-skip-empty automatically) to suppres
> > > the 0 output and add the event stats like below.
> >
> > I doubt we need the option for this.
>
> I agree this could be default, but I'm getting compilation fail:

Actually the patch 5/5 makes it as default.  I just wrote the example
command line to see the difference explicitly.

Anyway, will fix the build error.

Thanks,
Namhyung

>
>   CC       ui/browsers/hists.o
> ui/browsers/hists.c: In function ‘hist_browser__handle_hotkey’:
> ui/browsers/hists.c:699:29: error: ‘struct hists_stats’ has no member named ‘nr_lost_warned’
>   699 |       (browser->hists->stats.nr_lost_warned !=
>       |                             ^
> ui/browsers/hists.c:700:28: error: ‘struct hists_stats’ has no member named ‘nr_events’
>   700 |       browser->hists->stats.nr_events[PERF_RECORD_LOST])) {
>       |                            ^
> ui/browsers/hists.c:701:25: error: ‘struct hists_stats’ has no member named ‘nr_lost_warned’
>   701 |    browser->hists->stats.nr_lost_warned =
>       |                         ^
> ui/browsers/hists.c:702:26: error: ‘struct hists_stats’ has no member named ‘nr_events’
>   702 |     browser->hists->stats.nr_events[PERF_RECORD_LOST];
>       |                          ^
> ui/browsers/hists.c: In function ‘perf_evsel_menu__write’:
> ui/browsers/hists.c:3419:40: error: ‘struct hists_stats’ has no member named ‘nr_events’
>  3419 |  unsigned long nr_events = hists->stats.nr_events[PERF_RECORD_SAMPLE];
>       |                                        ^
> ui/browsers/hists.c:3435:33: error: ‘struct hists_stats’ has no member named ‘nr_events’
>  3435 |    nr_events += pos_hists->stats.nr_events[PERF_RECORD_SAMPLE];
>       |                                 ^
> ui/browsers/hists.c:3444:26: error: ‘struct hists_stats’ has no member named ‘nr_events’
>  3444 |  nr_events = hists->stats.nr_events[PERF_RECORD_LOST];
>       |                          ^
> ui/browsers/hists.c: In function ‘block_hists_browser__title’:
> ui/browsers/hists.c:3650:41: error: ‘struct hists_stats’ has no member named ‘nr_events’
>  3650 |  unsigned long nr_samples = hists->stats.nr_events[PERF_RECORD_SAMPLE];
>       |                                         ^
>
> jirka
>
>
> >
> > But if you change it I would add the percentages after the absolute values.
> >
> > -Andi
> >
>
