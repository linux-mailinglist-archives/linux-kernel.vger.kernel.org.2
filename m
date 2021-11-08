Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C8C449BFE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 19:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbhKHSxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 13:53:52 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:45773 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbhKHSxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 13:53:51 -0500
Received: by mail-lj1-f169.google.com with SMTP id s24so31359805lji.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 10:51:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zJ6kkjMcSrUKpNWGyLFF+NGVId+MBm2LNFWTxBNieZI=;
        b=c0pgP6DuWK5+0otUxhMxI1PGPUPJ/yUwbvfv6pYuKmAF0PI8BhezzQHPncxeilRsQm
         fMXi0OtoFs1xABgNRtVcUC7BawRvC25YyE3Z+Kuv6sqmKKWnLJF39EejlhnWdfWLWBXE
         Q3k4QzN+2GqucE3ipI/AN6a/2Uj+kzQfw3ckw7Ko9feKdDXFiZNOGgutuDppkSFjIvZb
         QN/OwjDkZ+q9RVoR65Rl/US+kPuEH+IB6r8Lx1XVeUsjrWIHu6w9khES741cY/V/ty5X
         8+qOe1pja13WLloW+4jZ1aGSUK5ZSDSq62CS9HXvJRBgg8DDwRiFnCRWBlykRbeCHaD8
         DWxA==
X-Gm-Message-State: AOAM533/XhX8dyAIBP6zE3bIKIo6oJBIFOmYf3lxsD8nsLJmVrbEx+6q
        oIBNJmxKJLn2xcY2H5/d3uU9aCfDwek/0hjW4YdgoC+V
X-Google-Smtp-Source: ABdhPJzkmRmfDRpn/xvPKIE0zHJUdHSylY/Z6ZJ5pZC4xAoa/mTeAjFcXK2O2ucQqn55Fi7O/Hftd9c4rBynv7o2JZw=
X-Received: by 2002:a2e:8841:: with SMTP id z1mr1227642ljj.180.1636397465370;
 Mon, 08 Nov 2021 10:51:05 -0800 (PST)
MIME-Version: 1.0
References: <20211029224929.379505-1-namhyung@kernel.org> <20211103072112.32312-1-ravi.bangoria@amd.com>
 <CAM9d7chQH+Br6NJhDdjjOdV7FsODS0_Rj+w-UsfzUud27iPNbQ@mail.gmail.com>
 <YYbWUetkc6keL/Xa@kernel.org> <11a4cec1-8169-0891-b9c8-4d3a7b689d86@amd.com>
In-Reply-To: <11a4cec1-8169-0891-b9c8-4d3a7b689d86@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 8 Nov 2021 10:50:54 -0800
Message-ID: <CAM9d7cgW_BoxzkGFoSc-un=n4j8OOaz7_TsBZpUP4D4SHb3LZA@mail.gmail.com>
Subject: Re: [PATCH v3] perf evsel: Fix missing exclude_{host,guest} setting
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kim Phillips <kim.phillips@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 7, 2021 at 2:26 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
>
>
> On 07-Nov-21 12:54 AM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Nov 05, 2021 at 11:00:29AM -0700, Namhyung Kim escreveu:
> >> Hello,
> >>
> >> On Wed, Nov 3, 2021 at 12:22 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> >>>
> >>>> The current logic for the perf missing feature has a bug that it can
> >>>> wrongly clear some modifiers like G or H.  Actually some PMUs don't
> >>>> support any filtering or exclusion while others do.  But we check it
> >>>> as a global feature.
> >>>
> >>> (Sorry to pitch in bit late)
> >>>
> >>> AMD has one more problem on a similar line. On AMD, non-precise and
> >>> precise sampling are provided by core and IBS pmu respectively. Plus,
> >>> core pmu has filtering capability but IBS does not. Perf by default
> >>> sets precise_ip=3 and exclude_guest=1 and goes on decreasing precise_ip
> >>> with exclude_guest set until perf_event_open() succeeds. This is
> >>> causing perf to always fallback to core pmu (non-precise mode) even if
> >>> it's perfectly feasible to do precise sampling. Do you guys think this
> >>> problem should also be addressed while designing solution for Namhyung's
> >>> patch or solve it seperately like below patch:
> >>>
> >>> ---><---
> >>>
> >>> From 48808299679199c39ff737a30a7f387669314fd7 Mon Sep 17 00:00:00 2001
> >>> From: Ravi Bangoria <ravi.bangoria@amd.com>
> >>> Date: Tue, 2 Nov 2021 11:01:12 +0530
> >>> Subject: [PATCH] perf/amd/ibs: Don't set exclude_guest by default
> >>>
> >>> Perf tool sets exclude_guest by default while calling perf_event_open().
> >>> Because IBS does not have filtering capability, it always gets rejected
> >>> by IBS PMU driver and thus perf falls back to non-precise sampling. Fix
> >>> it by not setting exclude_guest by default on AMD.
> >>>
> >>> Before:
> >>>   $ sudo ./perf record -C 0 -vvv true |& grep precise
> >>>     precise_ip                       3
> >>>   decreasing precise_ip by one (2)
> >>>     precise_ip                       2
> >>>   decreasing precise_ip by one (1)
> >>>     precise_ip                       1
> >>>   decreasing precise_ip by one (0)
> >>>
> >>> After:
> >>>   $ sudo ./perf record -C 0 -vvv true |& grep precise
> >>>     precise_ip                       3
> >>>   decreasing precise_ip by one (2)
> >>>     precise_ip                       2
> >>>
> >>> Reported-by: Kim Phillips <kim.phillips@amd.com>
> >>> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> >>
> >> It'd be nice if it can cover explicit -e cycles:pp as well.  Anyway,
> >
> > Ravi, please consider Namhyung's request, a patch on top as I'm adding
> > this already.
>
> For explicit :pp modifier, evsel->precise_max does not get set and thus perf
> does not try with different attr->precise_ip values while exclude_guest set.
> So no issue with explicit :pp:
>
>   $ sudo ./perf record -C 0 -e cycles:pp -vvv |& grep "precise_ip\|exclude_guest"
>     precise_ip                       2
>     exclude_guest                    1
>     precise_ip                       2
>     exclude_guest                    1
>   switching off exclude_guest, exclude_host
>     precise_ip                       2
>   ^C
>
> Also, with :P modifier, evsel->precise_max gets set but exclude_guest does
> not and thus :P also works fine:
>
>   $ sudo ./perf record -C 0 -e cycles:P -vvv |& grep "precise_ip\|exclude_guest"
>     precise_ip                       3
>   decreasing precise_ip by one (2)
>     precise_ip                       2
>   ^C

Ah, ok.  Thanks for making it clear!

Thanks,
Namhyung
