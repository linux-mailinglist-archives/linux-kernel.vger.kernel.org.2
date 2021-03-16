Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5D833D473
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhCPM5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:57:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233946AbhCPM4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:56:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F6D365050;
        Tue, 16 Mar 2021 12:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615899388;
        bh=QNY2/C5s7/yNAcSklEhOn7tPnbuBUdxeMWDdR9WDRyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ozuC8CSzwRMrk63lyrvPe8PeFox2iWNdrfeBSSd05312pytZnByBS0c6d1UuZwpjW
         oruHlEagmKpMxlQA8EZXLhjlAdXYwYZ/gs+2KteDykZiRm8AdHEklAQYzNOI6HzHNv
         gUGVG6fKWctldeSh4makrw/GVLdY5hf1PmeZsJcrwPXaN8b9pEmVhUWxWEmCZqn/2Q
         6UvNwEEG1URNLOvzgqdEImDq2PKKWOrSv+lHLgpfSqa5tRWg4LzE+mXZvHGWcYt73W
         u4Ik/cF7Msfq8RNFxIs9X1H5Zwf9X0j7uHMSLPo/4BYNw5zb80cnSrQrg/yY1FN4yf
         pqYSdq2osWsvQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5759F40647; Tue, 16 Mar 2021 09:56:26 -0300 (-03)
Date:   Tue, 16 Mar 2021 09:56:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf record: Fix memory leak in vDSO
Message-ID: <YFCq+sIS7M9GAcM2@kernel.org>
References: <20210315045641.700430-1-namhyung@kernel.org>
 <YE9g6VIZkEr8Hoyl@krava>
 <CAM9d7cheph_kjRzfKQSnoowRTQ3p4TF7mHt_3niJWGceSwJPzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cheph_kjRzfKQSnoowRTQ3p4TF7mHt_3niJWGceSwJPzA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 16, 2021 at 11:28:12AM +0900, Namhyung Kim escreveu:
> On Mon, Mar 15, 2021 at 10:28 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Mon, Mar 15, 2021 at 01:56:41PM +0900, Namhyung Kim wrote:
> > > I got several memory leak reports from Asan with a simple command.  It
> > > was because VDSO is not released due to the refcount.  Like in
> > > __dsos_addnew_id(), it should put the refcount after adding to the list.
> > >
> > >   $ perf record true
> > >   [ perf record: Woken up 1 times to write data ]
> > >   [ perf record: Captured and wrote 0.030 MB perf.data (10 samples) ]
> > >
> > >   =================================================================
> > >   ==692599==ERROR: LeakSanitizer: detected memory leaks
> > >
> > >   Direct leak of 439 byte(s) in 1 object(s) allocated from:
> > >     #0 0x7fea52341037 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
> > >     #1 0x559bce4aa8ee in dso__new_id util/dso.c:1256
> > >     #2 0x559bce59245a in __machine__addnew_vdso util/vdso.c:132
> > >     #3 0x559bce59245a in machine__findnew_vdso util/vdso.c:347
> > >     #4 0x559bce50826c in map__new util/map.c:175
> > >     #5 0x559bce503c92 in machine__process_mmap2_event util/machine.c:1787
> > >     #6 0x559bce512f6b in machines__deliver_event util/session.c:1481
> > >     #7 0x559bce515107 in perf_session__deliver_event util/session.c:1551
> > >     #8 0x559bce51d4d2 in do_flush util/ordered-events.c:244
> > >     #9 0x559bce51d4d2 in __ordered_events__flush util/ordered-events.c:323
> > >     #10 0x559bce519bea in __perf_session__process_events util/session.c:2268
> > >     #11 0x559bce519bea in perf_session__process_events util/session.c:2297
> > >     #12 0x559bce2e7a52 in process_buildids /home/namhyung/project/linux/tools/perf/builtin-record.c:1017
> > >     #13 0x559bce2e7a52 in record__finish_output /home/namhyung/project/linux/tools/perf/builtin-record.c:1234
> > >     #14 0x559bce2ed4f6 in __cmd_record /home/namhyung/project/linux/tools/perf/builtin-record.c:2026
> > >     #15 0x559bce2ed4f6 in cmd_record /home/namhyung/project/linux/tools/perf/builtin-record.c:2858
> > >     #16 0x559bce422db4 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:313
> > >     #17 0x559bce2acac8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:365
> > >     #18 0x559bce2acac8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:409
> > >     #19 0x559bce2acac8 in main /home/namhyung/project/linux/tools/perf/perf.c:539
> > >     #20 0x7fea51e76d09 in __libc_start_main ../csu/libc-start.c:308
> > >
> > >   Indirect leak of 32 byte(s) in 1 object(s) allocated from:
> > >     #0 0x7fea52341037 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
> > >     #1 0x559bce520907 in nsinfo__copy util/namespaces.c:169
> > >     #2 0x559bce50821b in map__new util/map.c:168
> > >     #3 0x559bce503c92 in machine__process_mmap2_event util/machine.c:1787
> > >     #4 0x559bce512f6b in machines__deliver_event util/session.c:1481
> > >     #5 0x559bce515107 in perf_session__deliver_event util/session.c:1551
> > >     #6 0x559bce51d4d2 in do_flush util/ordered-events.c:244
> > >     #7 0x559bce51d4d2 in __ordered_events__flush util/ordered-events.c:323
> > >     #8 0x559bce519bea in __perf_session__process_events util/session.c:2268
> > >     #9 0x559bce519bea in perf_session__process_events util/session.c:2297
> > >     #10 0x559bce2e7a52 in process_buildids /home/namhyung/project/linux/tools/perf/builtin-record.c:1017
> > >     #11 0x559bce2e7a52 in record__finish_output /home/namhyung/project/linux/tools/perf/builtin-record.c:1234
> > >     #12 0x559bce2ed4f6 in __cmd_record /home/namhyung/project/linux/tools/perf/builtin-record.c:2026
> > >     #13 0x559bce2ed4f6 in cmd_record /home/namhyung/project/linux/tools/perf/builtin-record.c:2858
> > >     #14 0x559bce422db4 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:313
> > >     #15 0x559bce2acac8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:365
> > >     #16 0x559bce2acac8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:409
> > >     #17 0x559bce2acac8 in main /home/namhyung/project/linux/tools/perf/perf.c:539
> > >     #18 0x7fea51e76d09 in __libc_start_main ../csu/libc-start.c:308
> > >
> > >   SUMMARY: AddressSanitizer: 471 byte(s) leaked in 2 allocation(s).
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/vdso.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
> > > index 3cc91ad048ea..43beb169631d 100644
> > > --- a/tools/perf/util/vdso.c
> > > +++ b/tools/perf/util/vdso.c
> > > @@ -133,6 +133,8 @@ static struct dso *__machine__addnew_vdso(struct machine *machine, const char *s
> > >       if (dso != NULL) {
> > >               __dsos__add(&machine->dsos, dso);
> > >               dso__set_long_name(dso, long_name, false);
> > > +             /* Put dso here because __dsos_add already got it */
> > > +             dso__put(dso);
> >
> > from quick look I don't understand why we take refcnt down
> > right after adding to the list.. it would make sense to me

That is the right pattern, i.e. the list has a reference to it, if it is
removed outside the __dsos__add(), then list traversal may be corrupted.

> > if dso is not stored elsewhere so we want dsos__exit to
> > release it.. but it's still stored in map object
> >
> > I checked and we do extra dso__get in machine__findnew_vdso
> > (and also in dsos__findnew_id) ... so that one seems to me
> > like the one we should remove

findnew _needs_ to grab te refcount while holding the lock, so that what
it returns won't go away in a different thread.

> > but I might be missing something, I'll try to check more
> > deeply later on
 
> I think we assume the find/findnew APIs include increment of
> the refcount, otherwise all callers should be converted to do it
> explicitly.

The callers can't grab the reference safely, i.e. its outside the lock.
 
> Then the 'find' part should increase it but the 'new' part is not
> (as it already has 2) and that's why we have that.
> 
> Thanks,
> Namhyung

-- 

- Arnaldo
