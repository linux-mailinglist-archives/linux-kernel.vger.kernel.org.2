Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A15D3F240F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 02:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbhHTAOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 20:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhHTAN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 20:13:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD101C061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 17:13:21 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id x2-20020a1c7c02000000b002e6f1f69a1eso7886509wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 17:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rL6wbZkCi+kI1IpfH0htaN3P5mXzNSVzl3FCg4p7KhU=;
        b=YpOYkCg4UUxl8krJRUlZVaDNJlaoPJlcU2O4IqzZdDNGcRcmVYWevteDLz3OvsYdjy
         p+dhMg73Npf9WFhgU5CkpFJ8qAotsN7RmrAj7UQ5yMaEjiBrpKlA1dJOYKzXdmvNdcMX
         LIgQv6I3liYK/5JPFHMteQtD1fiTKUfE2zRz9mU9lnTD9YnruNDIcKBODujcgUvG/vtH
         rn9M3Zbsjhgy3E9TK27FzQOyPKuHkm4qPJvfzHTMrlH+vbc/v5UMZtY2c2sRGHqU6fcc
         7T0DBv6WuHWTAr08beBBYBCf7/6r7WYxDELhVkovTy3fW1orACLuxJ7X/SUlLtr4Bajf
         B+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rL6wbZkCi+kI1IpfH0htaN3P5mXzNSVzl3FCg4p7KhU=;
        b=HL2O7wSQrLFA3EX6Q2Hdi9yBoftxVDCTnRq8QBKJhSTPbSBZBvCp+z2lzdcT1OuF5n
         RQqIo6XSIDZnCxKxixzCicxxtOENdukUhb7gAQavp6exoQ80s17JAea+uMtgYnUzdyEA
         BoaQ8Vt+ebahBPrbe6Q2W+h+nJM5g9P9K25qpQGVuYOUkvdtz6IQFwyTZKk2j5Z4tMEJ
         TVs+2rPJT+o6Q/q1g1+pFhYKGPWHVhStsgQ/G7nRjLaTYn1ZxfYnj5feAdwXE/Vj4GIO
         YNEaEM14jVvZbZcjPAQE7XlEJVXGwk7ztYOCUd/qyH+T0W1M/F+jtVJrz9hExBzWG0nv
         M3QA==
X-Gm-Message-State: AOAM532bl4RACHXk9NOT+gp0TcUJqlLardXPLXlc3Sv3mIlaTNhOiHu5
        V+kAxq9I0x8tqedf/UFVL+0cVKy1/DlR8bOFwl9lzA==
X-Google-Smtp-Source: ABdhPJwsAYkVwd2ie+vKlCZX33sCsyBvqq2P3MeajoG1ck/jMUdJLdUyFA19du3/QU6XCf0GJecxzAKOg5MvnJnZU2k=
X-Received: by 2002:a7b:cd10:: with SMTP id f16mr1063025wmj.104.1629418400060;
 Thu, 19 Aug 2021 17:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210819054707.1057819-1-irogers@google.com> <YR6pYoyov8ZGbAvJ@kernel.org>
 <CAM9d7cgBayQFwqW-=3sMYUOTuCQcWYCVy+P9J0bWJOohAn5gAA@mail.gmail.com>
In-Reply-To: <CAM9d7cgBayQFwqW-=3sMYUOTuCQcWYCVy+P9J0bWJOohAn5gAA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 19 Aug 2021 17:13:08 -0700
Message-ID: <CAP-5=fWHzg=Oh2uKm2CBEyE+evq7DoghQCSUsZoE6J5O5_A3hQ@mail.gmail.com>
Subject: Re: [PATCH] libperf evsel: Make use of FD robust.
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 4:30 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Ian,
>
> On Thu, Aug 19, 2021 at 11:56 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Wed, Aug 18, 2021 at 10:47:07PM -0700, Ian Rogers escreveu:
> > > FD uses xyarray__entry that may return NULL if an index is out of
> > > bounds. If NULL is returned then a segv happens as FD unconditionally
> > > dereferences the pointer. This was happening in a case of with perf
> > > iostat as shown below. The fix is to make FD an "int*" rather than an
> > > int and handle the NULL case as either invalid input or a closed fd.
> > >
> > > $ sudo gdb --args perf stat --iostat  list
> > > ...
> > > Breakpoint 1, perf_evsel__alloc_fd (evsel=0x5555560951a0, ncpus=1, nthreads=1) at evsel.c:50
> > > 50      {
> > > (gdb) bt
> > >  #0  perf_evsel__alloc_fd (evsel=0x5555560951a0, ncpus=1, nthreads=1) at evsel.c:50
> > >  #1  0x000055555585c188 in evsel__open_cpu (evsel=0x5555560951a0, cpus=0x555556093410,
> > >     threads=0x555556086fb0, start_cpu=0, end_cpu=1) at util/evsel.c:1792
> > >  #2  0x000055555585cfb2 in evsel__open (evsel=0x5555560951a0, cpus=0x0, threads=0x555556086fb0)
> > >     at util/evsel.c:2045
> > >  #3  0x000055555585d0db in evsel__open_per_thread (evsel=0x5555560951a0, threads=0x555556086fb0)
> > >     at util/evsel.c:2065
> > >  #4  0x00005555558ece64 in create_perf_stat_counter (evsel=0x5555560951a0,
> > >     config=0x555555c34700 <stat_config>, target=0x555555c2f1c0 <target>, cpu=0) at util/stat.c:590
> > >  #5  0x000055555578e927 in __run_perf_stat (argc=1, argv=0x7fffffffe4a0, run_idx=0)
> > >     at builtin-stat.c:833
> > >  #6  0x000055555578f3c6 in run_perf_stat (argc=1, argv=0x7fffffffe4a0, run_idx=0)
> > >     at builtin-stat.c:1048
> > >  #7  0x0000555555792ee5 in cmd_stat (argc=1, argv=0x7fffffffe4a0) at builtin-stat.c:2534
> > >  #8  0x0000555555835ed3 in run_builtin (p=0x555555c3f540 <commands+288>, argc=3,
> > >     argv=0x7fffffffe4a0) at perf.c:313
> > >  #9  0x0000555555836154 in handle_internal_command (argc=3, argv=0x7fffffffe4a0) at perf.c:365
> > >  #10 0x000055555583629f in run_argv (argcp=0x7fffffffe2ec, argv=0x7fffffffe2e0) at perf.c:409
> > >  #11 0x0000555555836692 in main (argc=3, argv=0x7fffffffe4a0) at perf.c:539
>
> This callstack looks strange that 'perf iostat list' should not call
> run_perf_stat() for the IOSTAT_LIST mode.
>
> Hmm.. maybe it's because the --iostat option is declared
> with OPT_CALLBACK_OPTARG which requires the option
> to be specified like '--iostat=list' (not '--iostat list').
>
> Anyway it should not crash..
>
> Thanks,
> Namhyung
>
>
> > > ...
> > > (gdb) c
> > > Continuing.
> > > Error:
> > > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (uncore_iio_0/event=0x83,umask=0x04,ch_mask=0xF,fc_mask=0x07/).
> > > /bin/dmesg | grep -i perf may provide additional information.
> > >
> > > Program received signal SIGSEGV, Segmentation fault.
> > > 0x00005555559b03ea in perf_evsel__close_fd_cpu (evsel=0x5555560951a0, cpu=1) at evsel.c:166
> > > 166                     if (FD(evsel, cpu, thread) >= 0)
> >
> > Humm
> >
> > static void perf_evsel__close_fd_cpu(struct perf_evsel *evsel, int cpu)
> > {
> >         int thread;
> >
> >         for (thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
> >                 if (FD(evsel, cpu, thread) >= 0)
> >                         close(FD(evsel, cpu, thread));
> >                 FD(evsel, cpu, thread) = -1;
> >         }
> > }
> >
> > void perf_evsel__close_fd(struct perf_evsel *evsel)
> > {
> >         int cpu;
> >
> >         for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++)
> >                 perf_evsel__close_fd_cpu(evsel, cpu);
> > }
> >
> > Isn't bounds checking being performed by the callers?

It looks like things have been confused. There is a default case where
number of CPUs is set to 1, the caller with the segv is using the
affinity CPU code:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evlist.c?h=perf/core#n1287

and so values other than 1 are passed, yielding the out of range
index, NULL and then the segv. I meant to send the stack trace at the
point of the segv, it is:

#0  0x00005555559b03ea in perf_evsel__close_fd_cpu
(evsel=0x5555560951a0, cpu=1) at evsel.c:166
#1  0x00005555559b05d1 in perf_evsel__close_cpu (evsel=0x5555560951a0,
cpu=1) at evsel.c:200
#2  0x0000555555853eb2 in evlist__close (evlist=0x555555e9b5c0) at
util/evlist.c:1287
#3  0x0000555555850eb1 in evlist__delete (evlist=0x555555e9b5c0) at
util/evlist.c:160
#4  0x0000555555793143 in cmd_stat (argc=1, argv=0x7fffffffe4a0) at
builtin-stat.c:2594
#5  0x0000555555835ed3 in run_builtin (p=0x555555c3f540 <commands+288>, argc=3,
    argv=0x7fffffffe4a0) at perf.c:313
#6  0x0000555555836154 in handle_internal_command (argc=3,
argv=0x7fffffffe4a0) at perf.c:365
#7  0x000055555583629f in run_argv (argcp=0x7fffffffe2ec,
argv=0x7fffffffe2e0) at perf.c:409
#8  0x0000555555836692 in main (argc=3, argv=0x7fffffffe4a0) at perf.c:539

Thanks,
Ian

> > - Arnaldo
> >
