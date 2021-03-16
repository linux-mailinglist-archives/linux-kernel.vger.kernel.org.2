Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B345B33CB6A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 03:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbhCPC2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 22:28:42 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:39933 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbhCPC2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 22:28:24 -0400
Received: by mail-lf1-f53.google.com with SMTP id 18so60009338lff.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 19:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yS6011bMloR7zRKHS4s9pWu4392qTMdCEhzsXiZmMYA=;
        b=cG3q/Y7ChjUFxcg9zCYxMfrRnJeeUzL+p0WPbYCoJh1jgRaLor8kXl8UlRZ6oyhI5r
         ehBgcpA32/AHsx69+EtdHjNaF7hANMZnuG7cTXoTYVe4U9s3xYybDBfZy+bTJ/DlNP9G
         DyqXoxvBbbr17QejWSoAcKYEBnNoR8UXPVcQihGNy/T5D0i090wtBAuFVsfytmkJp8dh
         YUxqiih77rgbPvk6km3QXjxdXABtuLWs7kDodtT23g3iu8l2z+xoRp2oFkaLm4HVO2OX
         aZdZ+ShPlJGCd3t8eo29lfTnQW2hMY8efQwIY9sm3aa8tYHtmbN7RIeTEw/PdKckUYtF
         6JvQ==
X-Gm-Message-State: AOAM530CStquDYeI3eE3HKFKGPb8IEeQ97qbVDVmOKfEY6htK+SOJbT9
        bLUFciMyiJ7ZkKYprihPhOi51IKkx/hbldMFWxQ=
X-Google-Smtp-Source: ABdhPJxztoyNcSn69JXCbCmBD1w9zKvvbx9xL6SGGSNUtOp9c4XZ4ycIsyCE17AawZG1BB33Pg7P3Ay3lVQvQ/bHSZs=
X-Received: by 2002:a05:6512:a8b:: with SMTP id m11mr9440764lfu.112.1615861703408;
 Mon, 15 Mar 2021 19:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210315045641.700430-1-namhyung@kernel.org> <YE9g6VIZkEr8Hoyl@krava>
In-Reply-To: <YE9g6VIZkEr8Hoyl@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 16 Mar 2021 11:28:12 +0900
Message-ID: <CAM9d7cheph_kjRzfKQSnoowRTQ3p4TF7mHt_3niJWGceSwJPzA@mail.gmail.com>
Subject: Re: [PATCH] perf record: Fix memory leak in vDSO
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 10:28 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Mar 15, 2021 at 01:56:41PM +0900, Namhyung Kim wrote:
> > I got several memory leak reports from Asan with a simple command.  It
> > was because VDSO is not released due to the refcount.  Like in
> > __dsos_addnew_id(), it should put the refcount after adding to the list.
> >
> >   $ perf record true
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 0.030 MB perf.data (10 samples) ]
> >
> >   =================================================================
> >   ==692599==ERROR: LeakSanitizer: detected memory leaks
> >
> >   Direct leak of 439 byte(s) in 1 object(s) allocated from:
> >     #0 0x7fea52341037 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
> >     #1 0x559bce4aa8ee in dso__new_id util/dso.c:1256
> >     #2 0x559bce59245a in __machine__addnew_vdso util/vdso.c:132
> >     #3 0x559bce59245a in machine__findnew_vdso util/vdso.c:347
> >     #4 0x559bce50826c in map__new util/map.c:175
> >     #5 0x559bce503c92 in machine__process_mmap2_event util/machine.c:1787
> >     #6 0x559bce512f6b in machines__deliver_event util/session.c:1481
> >     #7 0x559bce515107 in perf_session__deliver_event util/session.c:1551
> >     #8 0x559bce51d4d2 in do_flush util/ordered-events.c:244
> >     #9 0x559bce51d4d2 in __ordered_events__flush util/ordered-events.c:323
> >     #10 0x559bce519bea in __perf_session__process_events util/session.c:2268
> >     #11 0x559bce519bea in perf_session__process_events util/session.c:2297
> >     #12 0x559bce2e7a52 in process_buildids /home/namhyung/project/linux/tools/perf/builtin-record.c:1017
> >     #13 0x559bce2e7a52 in record__finish_output /home/namhyung/project/linux/tools/perf/builtin-record.c:1234
> >     #14 0x559bce2ed4f6 in __cmd_record /home/namhyung/project/linux/tools/perf/builtin-record.c:2026
> >     #15 0x559bce2ed4f6 in cmd_record /home/namhyung/project/linux/tools/perf/builtin-record.c:2858
> >     #16 0x559bce422db4 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:313
> >     #17 0x559bce2acac8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:365
> >     #18 0x559bce2acac8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:409
> >     #19 0x559bce2acac8 in main /home/namhyung/project/linux/tools/perf/perf.c:539
> >     #20 0x7fea51e76d09 in __libc_start_main ../csu/libc-start.c:308
> >
> >   Indirect leak of 32 byte(s) in 1 object(s) allocated from:
> >     #0 0x7fea52341037 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
> >     #1 0x559bce520907 in nsinfo__copy util/namespaces.c:169
> >     #2 0x559bce50821b in map__new util/map.c:168
> >     #3 0x559bce503c92 in machine__process_mmap2_event util/machine.c:1787
> >     #4 0x559bce512f6b in machines__deliver_event util/session.c:1481
> >     #5 0x559bce515107 in perf_session__deliver_event util/session.c:1551
> >     #6 0x559bce51d4d2 in do_flush util/ordered-events.c:244
> >     #7 0x559bce51d4d2 in __ordered_events__flush util/ordered-events.c:323
> >     #8 0x559bce519bea in __perf_session__process_events util/session.c:2268
> >     #9 0x559bce519bea in perf_session__process_events util/session.c:2297
> >     #10 0x559bce2e7a52 in process_buildids /home/namhyung/project/linux/tools/perf/builtin-record.c:1017
> >     #11 0x559bce2e7a52 in record__finish_output /home/namhyung/project/linux/tools/perf/builtin-record.c:1234
> >     #12 0x559bce2ed4f6 in __cmd_record /home/namhyung/project/linux/tools/perf/builtin-record.c:2026
> >     #13 0x559bce2ed4f6 in cmd_record /home/namhyung/project/linux/tools/perf/builtin-record.c:2858
> >     #14 0x559bce422db4 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:313
> >     #15 0x559bce2acac8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:365
> >     #16 0x559bce2acac8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:409
> >     #17 0x559bce2acac8 in main /home/namhyung/project/linux/tools/perf/perf.c:539
> >     #18 0x7fea51e76d09 in __libc_start_main ../csu/libc-start.c:308
> >
> >   SUMMARY: AddressSanitizer: 471 byte(s) leaked in 2 allocation(s).
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/vdso.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
> > index 3cc91ad048ea..43beb169631d 100644
> > --- a/tools/perf/util/vdso.c
> > +++ b/tools/perf/util/vdso.c
> > @@ -133,6 +133,8 @@ static struct dso *__machine__addnew_vdso(struct machine *machine, const char *s
> >       if (dso != NULL) {
> >               __dsos__add(&machine->dsos, dso);
> >               dso__set_long_name(dso, long_name, false);
> > +             /* Put dso here because __dsos_add already got it */
> > +             dso__put(dso);
>
> from quick look I don't understand why we take refcnt down
> right after adding to the list.. it would make sense to me
> if dso is not stored elsewhere so we want dsos__exit to
> release it.. but it's still stored in map object
>
> I checked and we do extra dso__get in machine__findnew_vdso
> (and also in dsos__findnew_id) ... so that one seems to me
> like the one we should remove
>
> but I might be missing something, I'll try to check more
> deeply later on

I think we assume the find/findnew APIs include increment of
the refcount, otherwise all callers should be converted to do it
explicitly.

Then the 'find' part should increase it but the 'new' part is not
(as it already has 2) and that's why we have that.

Thanks,
Namhyung
