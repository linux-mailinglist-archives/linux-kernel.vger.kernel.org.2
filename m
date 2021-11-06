Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFD6447012
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 20:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhKFT0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 15:26:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232498AbhKFT0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 15:26:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21C7B60F9D;
        Sat,  6 Nov 2021 19:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636226644;
        bh=jQGbXnitLchMei/HJt6evi7umlZCzkT9kLGbjbsg+hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=flwve9EwWJaWib7IpCKyH+YZxli5EQuKuBb+Gel6gCYqH4pWHOcHHA3pSkWhMgVQr
         ppRkdEXijVaUX0Eiq6ULhfgwRvPvrRwcDtfZd9w/JjwR9L6lRBE0TGFe8b/BOiEU4K
         WSiz2pnIkT/2kF2e1Yxzcb0tQPTAd/jiNvb5bzZ6H3SzaTHzAEvRLtjRw8I3o6kjEh
         SkqpoUJpxbhH3KWzwsnrkSe5OF+vSlDc57rs/YDFGAsecP7+e7kjWo0RdfiaCnVUJ/
         G2S57gCEKVEvFtv9fVckeIEfZmGOrxMqcUYjGSZqHSKsIhnrsZYSRlWARA3iQrmO1g
         2M4N0MJCUSW2Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E6B64410A1; Sat,  6 Nov 2021 16:24:01 -0300 (-03)
Date:   Sat, 6 Nov 2021 16:24:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH v3] perf evsel: Fix missing exclude_{host,guest} setting
Message-ID: <YYbWUetkc6keL/Xa@kernel.org>
References: <20211029224929.379505-1-namhyung@kernel.org>
 <20211103072112.32312-1-ravi.bangoria@amd.com>
 <CAM9d7chQH+Br6NJhDdjjOdV7FsODS0_Rj+w-UsfzUud27iPNbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chQH+Br6NJhDdjjOdV7FsODS0_Rj+w-UsfzUud27iPNbQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 05, 2021 at 11:00:29AM -0700, Namhyung Kim escreveu:
> Hello,
> 
> On Wed, Nov 3, 2021 at 12:22 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> >
> > > The current logic for the perf missing feature has a bug that it can
> > > wrongly clear some modifiers like G or H.  Actually some PMUs don't
> > > support any filtering or exclusion while others do.  But we check it
> > > as a global feature.
> >
> > (Sorry to pitch in bit late)
> >
> > AMD has one more problem on a similar line. On AMD, non-precise and
> > precise sampling are provided by core and IBS pmu respectively. Plus,
> > core pmu has filtering capability but IBS does not. Perf by default
> > sets precise_ip=3 and exclude_guest=1 and goes on decreasing precise_ip
> > with exclude_guest set until perf_event_open() succeeds. This is
> > causing perf to always fallback to core pmu (non-precise mode) even if
> > it's perfectly feasible to do precise sampling. Do you guys think this
> > problem should also be addressed while designing solution for Namhyung's
> > patch or solve it seperately like below patch:
> >
> > ---><---
> >
> > From 48808299679199c39ff737a30a7f387669314fd7 Mon Sep 17 00:00:00 2001
> > From: Ravi Bangoria <ravi.bangoria@amd.com>
> > Date: Tue, 2 Nov 2021 11:01:12 +0530
> > Subject: [PATCH] perf/amd/ibs: Don't set exclude_guest by default
> >
> > Perf tool sets exclude_guest by default while calling perf_event_open().
> > Because IBS does not have filtering capability, it always gets rejected
> > by IBS PMU driver and thus perf falls back to non-precise sampling. Fix
> > it by not setting exclude_guest by default on AMD.
> >
> > Before:
> >   $ sudo ./perf record -C 0 -vvv true |& grep precise
> >     precise_ip                       3
> >   decreasing precise_ip by one (2)
> >     precise_ip                       2
> >   decreasing precise_ip by one (1)
> >     precise_ip                       1
> >   decreasing precise_ip by one (0)
> >
> > After:
> >   $ sudo ./perf record -C 0 -vvv true |& grep precise
> >     precise_ip                       3
> >   decreasing precise_ip by one (2)
> >     precise_ip                       2
> >
> > Reported-by: Kim Phillips <kim.phillips@amd.com>
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> 
> It'd be nice if it can cover explicit -e cycles:pp as well.  Anyway,

Ravi, please consider Namhyung's request, a patch on top as I'm adding
this already.
 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

