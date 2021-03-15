Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6935833B46F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 14:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhCON2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 09:28:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230433AbhCON2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615814898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lyVS2XKGdVlt6gqn+kMGdjYoFHIFbevN4UzUZHMFXJE=;
        b=MxHwTpmNzfV9bNQl3x/B2oSbR6+2VJVjxss5pOtbkGo+aXWYWukurk5KTbKcMTGQhGff1X
        gqiVb4gLRMDEDCb+3W4OLiKJouAD/0v2VbJM3QKJPZsEKmpJYxxw5Vz2vlrbVf+H36H2BD
        d6F/gThsaaNb5qrs2CnfKtS7UPNnyWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-7m-AxzihO5uxOoHB4C3M6w-1; Mon, 15 Mar 2021 09:28:13 -0400
X-MC-Unique: 7m-AxzihO5uxOoHB4C3M6w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E46A108BD06;
        Mon, 15 Mar 2021 13:28:12 +0000 (UTC)
Received: from krava (unknown [10.40.196.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id 32DBF610F0;
        Mon, 15 Mar 2021 13:28:10 +0000 (UTC)
Date:   Mon, 15 Mar 2021 14:28:09 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf record: Fix memory leak in vDSO
Message-ID: <YE9g6VIZkEr8Hoyl@krava>
References: <20210315045641.700430-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315045641.700430-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 01:56:41PM +0900, Namhyung Kim wrote:
> I got several memory leak reports from Asan with a simple command.  It
> was because VDSO is not released due to the refcount.  Like in
> __dsos_addnew_id(), it should put the refcount after adding to the list.
> 
>   $ perf record true
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.030 MB perf.data (10 samples) ]
> 
>   =================================================================
>   ==692599==ERROR: LeakSanitizer: detected memory leaks
> 
>   Direct leak of 439 byte(s) in 1 object(s) allocated from:
>     #0 0x7fea52341037 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
>     #1 0x559bce4aa8ee in dso__new_id util/dso.c:1256
>     #2 0x559bce59245a in __machine__addnew_vdso util/vdso.c:132
>     #3 0x559bce59245a in machine__findnew_vdso util/vdso.c:347
>     #4 0x559bce50826c in map__new util/map.c:175
>     #5 0x559bce503c92 in machine__process_mmap2_event util/machine.c:1787
>     #6 0x559bce512f6b in machines__deliver_event util/session.c:1481
>     #7 0x559bce515107 in perf_session__deliver_event util/session.c:1551
>     #8 0x559bce51d4d2 in do_flush util/ordered-events.c:244
>     #9 0x559bce51d4d2 in __ordered_events__flush util/ordered-events.c:323
>     #10 0x559bce519bea in __perf_session__process_events util/session.c:2268
>     #11 0x559bce519bea in perf_session__process_events util/session.c:2297
>     #12 0x559bce2e7a52 in process_buildids /home/namhyung/project/linux/tools/perf/builtin-record.c:1017
>     #13 0x559bce2e7a52 in record__finish_output /home/namhyung/project/linux/tools/perf/builtin-record.c:1234
>     #14 0x559bce2ed4f6 in __cmd_record /home/namhyung/project/linux/tools/perf/builtin-record.c:2026
>     #15 0x559bce2ed4f6 in cmd_record /home/namhyung/project/linux/tools/perf/builtin-record.c:2858
>     #16 0x559bce422db4 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:313
>     #17 0x559bce2acac8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:365
>     #18 0x559bce2acac8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:409
>     #19 0x559bce2acac8 in main /home/namhyung/project/linux/tools/perf/perf.c:539
>     #20 0x7fea51e76d09 in __libc_start_main ../csu/libc-start.c:308
> 
>   Indirect leak of 32 byte(s) in 1 object(s) allocated from:
>     #0 0x7fea52341037 in __interceptor_calloc ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:154
>     #1 0x559bce520907 in nsinfo__copy util/namespaces.c:169
>     #2 0x559bce50821b in map__new util/map.c:168
>     #3 0x559bce503c92 in machine__process_mmap2_event util/machine.c:1787
>     #4 0x559bce512f6b in machines__deliver_event util/session.c:1481
>     #5 0x559bce515107 in perf_session__deliver_event util/session.c:1551
>     #6 0x559bce51d4d2 in do_flush util/ordered-events.c:244
>     #7 0x559bce51d4d2 in __ordered_events__flush util/ordered-events.c:323
>     #8 0x559bce519bea in __perf_session__process_events util/session.c:2268
>     #9 0x559bce519bea in perf_session__process_events util/session.c:2297
>     #10 0x559bce2e7a52 in process_buildids /home/namhyung/project/linux/tools/perf/builtin-record.c:1017
>     #11 0x559bce2e7a52 in record__finish_output /home/namhyung/project/linux/tools/perf/builtin-record.c:1234
>     #12 0x559bce2ed4f6 in __cmd_record /home/namhyung/project/linux/tools/perf/builtin-record.c:2026
>     #13 0x559bce2ed4f6 in cmd_record /home/namhyung/project/linux/tools/perf/builtin-record.c:2858
>     #14 0x559bce422db4 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:313
>     #15 0x559bce2acac8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:365
>     #16 0x559bce2acac8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:409
>     #17 0x559bce2acac8 in main /home/namhyung/project/linux/tools/perf/perf.c:539
>     #18 0x7fea51e76d09 in __libc_start_main ../csu/libc-start.c:308
> 
>   SUMMARY: AddressSanitizer: 471 byte(s) leaked in 2 allocation(s).
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/vdso.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/vdso.c b/tools/perf/util/vdso.c
> index 3cc91ad048ea..43beb169631d 100644
> --- a/tools/perf/util/vdso.c
> +++ b/tools/perf/util/vdso.c
> @@ -133,6 +133,8 @@ static struct dso *__machine__addnew_vdso(struct machine *machine, const char *s
>  	if (dso != NULL) {
>  		__dsos__add(&machine->dsos, dso);
>  		dso__set_long_name(dso, long_name, false);
> +		/* Put dso here because __dsos_add already got it */
> +		dso__put(dso);

from quick look I don't understand why we take refcnt down
right after adding to the list.. it would make sense to me
if dso is not stored elsewhere so we want dsos__exit to
release it.. but it's still stored in map object

I checked and we do extra dso__get in machine__findnew_vdso
(and also in dsos__findnew_id) ... so that one seems to me
like the one we should remove

but I might be missing something, I'll try to check more
deeply later on

jirka

