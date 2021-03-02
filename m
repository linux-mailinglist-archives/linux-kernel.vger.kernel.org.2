Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC45732A0C0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576515AbhCBEaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:30:09 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:46231 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380418AbhCBBvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 20:51:07 -0500
Received: by mail-qk1-f173.google.com with SMTP id a9so4237671qkn.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 17:50:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0KVTqboDCl1Az8bsYJmElz04gJXte4nzJLkiWdnKi5k=;
        b=cOyp4c3ta0bevqQIeVc+nmaH0YbTR1xffRrrifBJXbyqoPPnAlUP+M81Q6vLzemzoC
         bUTGqc3NwToOA86F1EHdA4pX7F+RGVMevGhBzV9nuYMUuj+qVvhi7bKqU07VWpEzW7W1
         3+UFHELQDYrZzFDPNNnRdrQMLkrxQT8vHcfPy5vQvEBKRHL42YZtJXpwx56e8G5p8MS/
         2fiu0jEwarRH/h5As91hiAXIQd6zfZ1nPjtKML+WUXwdolwEQv+D6PuOdXOnIJScO7Na
         yx8Ma8TOm/3rONpnc4riusSqE0hAUV1D/Le0mK7U7/8/KMdGY8vrVMvAInZbT49AMtB0
         hTIA==
X-Gm-Message-State: AOAM532mbgTqrwLOG61HcsA2zK+HTKVOlbB2KkpDbtWfXO7NOEiymqFD
        eZNHi9n0/o9k+xr6ofusBC+f0CbZP+wARuSf0ZI=
X-Google-Smtp-Source: ABdhPJxFAgMOETsGnNqG2H9IKI5B/vR18Es8sLaOnFL7LhMzmWVguuwAjZjsavB0uTlMILUbSeDSYuOMiT7TUjZCazA=
X-Received: by 2002:ae9:efc4:: with SMTP id d187mr17849810qkg.316.1614649826892;
 Mon, 01 Mar 2021 17:50:26 -0800 (PST)
MIME-Version: 1.0
References: <20210301140409.184570-1-namhyung@kernel.org> <20210301140409.184570-5-namhyung@kernel.org>
 <YD0jR7ENbD7u01Zq@krava>
In-Reply-To: <YD0jR7ENbD7u01Zq@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 2 Mar 2021 10:50:15 +0900
Message-ID: <CAM9d7cgNpEzaPYin=PUw9+WCecbUCQaNXAsMFOXnLBHcK8xotw@mail.gmail.com>
Subject: Re: [PATCH 04/11] perf test: Fix cpu and thread map leaks in
 sw_clock_freq test
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Tue, Mar 2, 2021 at 2:24 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Mar 01, 2021 at 11:04:02PM +0900, Namhyung Kim wrote:
> > The evlist has the maps with its own refcounts so we don't need to set
> > the pointers to NULL.  Otherwise following error was reported by Asan.
> >
> > Also change the goto label since it doesn't need to have two.
> >
> >   # perf test -v 25
> >   25: Software clock events period values        :
> >   --- start ---
> >   test child forked, pid 149154
> >   mmap size 528384B
> >   mmap size 528384B
> >
> >   =================================================================
> >   ==149154==ERROR: LeakSanitizer: detected memory leaks
> >
> >   Direct leak of 32 byte(s) in 1 object(s) allocated from:
> >     #0 0x7fef5cd071f8 in __interceptor_realloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:164
> >     #1 0x56260d5e8b8e in perf_thread_map__realloc /home/namhyung/project/linux/tools/lib/perf/threadmap.c:23
> >     #2 0x56260d3df7a9 in thread_map__new_by_tid util/thread_map.c:63
> >     #3 0x56260d2ac6b2 in __test__sw_clock_freq tests/sw-clock.c:65
> >     #4 0x56260d26d8fb in run_test tests/builtin-test.c:428
> >     #5 0x56260d26d8fb in test_and_print tests/builtin-test.c:458
> >     #6 0x56260d26fa53 in __cmd_test tests/builtin-test.c:679
> >     #7 0x56260d26fa53 in cmd_test tests/builtin-test.c:825
> >     #8 0x56260d2dbb64 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:313
> >     #9 0x56260d165a88 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:365
> >     #10 0x56260d165a88 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:409
> >     #11 0x56260d165a88 in main /home/namhyung/project/linux/tools/perf/perf.c:539
> >     #12 0x7fef5c83cd09 in __libc_start_main ../csu/libc-start.c:308
> >
> >     ...
> >   test child finished with 1
> >   ---- end ----
> >   Software clock events period values      : FAILED!
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/tests/sw-clock.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
> > index a49c9e23053b..74988846be1d 100644
> > --- a/tools/perf/tests/sw-clock.c
> > +++ b/tools/perf/tests/sw-clock.c
> > @@ -42,8 +42,8 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
> >               .disabled = 1,
> >               .freq = 1,
> >       };
> > -     struct perf_cpu_map *cpus;
> > -     struct perf_thread_map *threads;
> > +     struct perf_cpu_map *cpus = NULL;
> > +     struct perf_thread_map *threads = NULL;
> >       struct mmap *md;
> >
> >       attr.sample_freq = 500;
> > @@ -66,14 +66,11 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
> >       if (!cpus || !threads) {
> >               err = -ENOMEM;
> >               pr_debug("Not enough memory to create thread/cpu maps\n");
> > -             goto out_free_maps;
> > +             goto out_delete_evlist;
> >       }
> >
> >       perf_evlist__set_maps(&evlist->core, cpus, threads);
> >
> > -     cpus    = NULL;
> > -     threads = NULL;
>
> hum, so IIUC we added these and the other you remove in your patches long time ago,
> because there was no refcounting at that time, right?

It seems my original patch just set the maps directly.

  bc96b361cbf9 perf tests: Add a test case for checking sw clock event frequency

And after that Adrian changed it to use the set_maps() helper.

  c5e6bd2ed3e8 perf tests: Fix software clock events test setting maps

It seems we already had the refcounting at the moment.  And then the libperf
renaming happened later.

Thanks,
Namhyung
