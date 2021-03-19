Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48FA34210D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhCSPfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:35:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230241AbhCSPfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:35:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9977B61939;
        Fri, 19 Mar 2021 15:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616168114;
        bh=pgU2KS1nOWcO/GtvyYFLP0IuVFfh+X+AIjuK5boE+C0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XnJ/4RxpZp1LQPH/lkvi6MNu0KeHMQywtvsJzdKga46/nshuN37NoPuxSixQzC/mt
         R4k/qryfgGEdpJMQf0NZKVb14H7HAIVO9LzSGkkQZ490d+OoJIxMfj0+fw5sdmlTHW
         CUu5qZhXsOZaOxKOBObdtWEeAoZWfwMCtzHWYmLiB5IEhpqpbYGq9URLOIrUFMpaHJ
         8WGCNGp+xkSwK/gfHOXdTV7GUhRkQudKW8yJwJWjNzUeVxdlGLeuZNsWBwkospGeus
         jYOVMpapZpX15LWFyWhKG+Gv08/MRlbbgyEmbUD8W3/C9qL/DQs7KdZMAeVbUw/5m1
         o7AysMtOr1yjQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 22C8740647; Fri, 19 Mar 2021 12:35:12 -0300 (-03)
Date:   Fri, 19 Mar 2021 12:35:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 0/3] perf-stat: share hardware PMCs with BPF
Message-ID: <YFTEsOhbx4Il1nji@kernel.org>
References: <20210316211837.910506-1-songliubraving@fb.com>
 <CAM9d7ci=hfFjq3+XuBcCZ0TUJxv6AmdFk0dkHFQD3wx27aJMjA@mail.gmail.com>
 <YFH//FRPvrPswhld@kernel.org>
 <7D48A756-C253-48DE-B536-826314778404@fb.com>
 <YFPCul51MjrlY65P@krava>
 <388AF530-5176-4DB9-93C4-6C302432CE12@gmail.com>
 <3E65B60E-B120-4E1A-BAF2-2FAEF136A4CD@fb.com>
 <CAM9d7ch_axD_4E0W7MEx8ueeq9QsvhxNWaJ0J3AtVgeKqKQmbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ch_axD_4E0W7MEx8ueeq9QsvhxNWaJ0J3AtVgeKqKQmbA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 19, 2021 at 09:54:59AM +0900, Namhyung Kim escreveu:
> On Fri, Mar 19, 2021 at 9:22 AM Song Liu <songliubraving@fb.com> wrote:
> > > On Mar 18, 2021, at 5:09 PM, Arnaldo <arnaldo.melo@gmail.com> wrote:
> > > On March 18, 2021 6:14:34 PM GMT-03:00, Jiri Olsa <jolsa@redhat.com> wrote:
> > >> On Thu, Mar 18, 2021 at 03:52:51AM +0000, Song Liu wrote:
> > >>> perf stat -C 1,3,5                  107.063 [sec]
> > >>> perf stat -C 1,3,5 --bpf-counters   106.406 [sec]

> > >> I can't see why it's actualy faster than normal perf ;-)
> > >> would be worth to find out

> > > Isn't this all about contended cases?

> > Yeah, the normal perf is doing time multiplexing; while --bpf-counters
> > doesn't need it.

> Yep, so for uncontended cases, normal perf should be the same as the
> baseline (faster than the bperf).  But for contended cases, the bperf
> works faster.

The difference should be small enough that for people that use this in a
machine where contention happens most of the time, setting a
~/.perfconfig to use it by default should be advantageous, i.e. no need
to use --bpf-counters on the command line all the time.

So, Namhyung, can I take that as an Acked-by or a Reviewed-by? I'll take
a look again now but I want to have this merged on perf/core so that I
can work on a new BPF SKEL to use this:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.bpf/bpf_perf_enable

:-)

- Arnaldo
