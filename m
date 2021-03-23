Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C92346AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhCWVKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:10:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233422AbhCWVKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:10:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E453A61879;
        Tue, 23 Mar 2021 21:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616533825;
        bh=5wLyszeDlfv5Q/EYQhea3G/TbWg2xXnHCAzAJckahp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aGhiM384dXnlO0fgh+n5l21MuSHW7KSMBvyy9NbD/rZuwbXyIgdi+DZGf1XlU5w1m
         PnMBT8Qmz5V5TB0xsiS9YQYW7lCBe0XVoAK3OHZeLq5k+n0QBbPhXPI2IgDZ+SYIsl
         mons35+/A9oqior0TnWKdf8IBU7I2o6EePDAmIgElA/84H5OTTuKPSiHGPgtUp9aE2
         MA54Zp9G/wIkpKNXXBL6kU7IZnerYaCSiOBruPHhlnaEEEeHVtDoUzNJrfe75K5I63
         oEqUFRnF3N6UZi/1Ikcw4M43MK8UjMxGtwGMx3S1tCBapB/Jvwf8Noqs/kh5yUbFjZ
         zSiQBxTrooG7A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EB50240647; Tue, 23 Mar 2021 18:10:22 -0300 (-03)
Date:   Tue, 23 Mar 2021 18:10:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 0/3] perf-stat: share hardware PMCs with BPF
Message-ID: <YFpZPijlMSyfIVbl@kernel.org>
References: <CAM9d7ci=hfFjq3+XuBcCZ0TUJxv6AmdFk0dkHFQD3wx27aJMjA@mail.gmail.com>
 <YFH//FRPvrPswhld@kernel.org>
 <7D48A756-C253-48DE-B536-826314778404@fb.com>
 <YFPCul51MjrlY65P@krava>
 <388AF530-5176-4DB9-93C4-6C302432CE12@gmail.com>
 <3E65B60E-B120-4E1A-BAF2-2FAEF136A4CD@fb.com>
 <CAM9d7ch_axD_4E0W7MEx8ueeq9QsvhxNWaJ0J3AtVgeKqKQmbA@mail.gmail.com>
 <YFTEsOhbx4Il1nji@kernel.org>
 <CAM9d7cgoP28V_ONk2AJeu=Y7RQ8vzovzW=pGVYtERe97+ZH0Aw@mail.gmail.com>
 <EC00E37D-8587-4662-8E30-7AD5F874FA84@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EC00E37D-8587-4662-8E30-7AD5F874FA84@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 19, 2021 at 04:14:42PM +0000, Song Liu escreveu:
> > On Mar 19, 2021, at 8:58 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> > On Sat, Mar 20, 2021 at 12:35 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >> Em Fri, Mar 19, 2021 at 09:54:59AM +0900, Namhyung Kim escreveu:
> >>> On Fri, Mar 19, 2021 at 9:22 AM Song Liu <songliubraving@fb.com> wrote:
> >>>>> On Mar 18, 2021, at 5:09 PM, Arnaldo <arnaldo.melo@gmail.com> wrote:
> >>>>> On March 18, 2021 6:14:34 PM GMT-03:00, Jiri Olsa <jolsa@redhat.com> wrote:
> >>>>>> On Thu, Mar 18, 2021 at 03:52:51AM +0000, Song Liu wrote:
> >>>>>>> perf stat -C 1,3,5                  107.063 [sec]
> >>>>>>> perf stat -C 1,3,5 --bpf-counters   106.406 [sec]

> >>>>>> I can't see why it's actualy faster than normal perf ;-)
> >>>>>> would be worth to find out

> >>>>> Isn't this all about contended cases?

> >>>> Yeah, the normal perf is doing time multiplexing; while --bpf-counters
> >>>> doesn't need it.

> >>> Yep, so for uncontended cases, normal perf should be the same as the
> >>> baseline (faster than the bperf).  But for contended cases, the bperf
> >>> works faster.

> >> The difference should be small enough that for people that use this in a
> >> machine where contention happens most of the time, setting a
> >> ~/.perfconfig to use it by default should be advantageous, i.e. no need
> >> to use --bpf-counters on the command line all the time.

> >> So, Namhyung, can I take that as an Acked-by or a Reviewed-by? I'll take
> >> a look again now but I want to have this merged on perf/core so that I
> >> can work on a new BPF SKEL to use this:

> > I have a concern for the per cpu target, but it can be done later, so

> > Acked-by: Namhyung Kim <namhyung@kernel.org>

> >> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.bpf/bpf_perf_enable

> > Interesting!  Actually I was thinking about the similar too. :)
> 
> Hi Namhyung, Jiri, and Arnaldo,
> 
> Thanks a lot for your kind review. 
> 
> Here is updated 3/3, where we use perf-bench instead of stressapptest.

I had to apply this updated 3/3 manually, as there was some munging, its
all now at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf/core

Please take a look at the "Committer testing" section I added to the
main patch, introducing bperf:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=tmp.perf/core&id=7fac83aaf2eecc9e7e7b72da694c49bb4ce7fdfc

And check if I made any mistake or if something else could be added.

It'll move to perf/core after my set of automated tests finishes.

- Arnaldo
