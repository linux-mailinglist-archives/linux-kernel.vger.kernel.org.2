Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83485390A09
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 21:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhEYT4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 15:56:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231612AbhEYT4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 15:56:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D87C0610A5;
        Tue, 25 May 2021 19:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621972503;
        bh=bSN88BJd4Pu317qJPPV6aPRET6ajX2jjbHZJuD8RKgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X1AaAaY87dVXqzJxC1gPPj4Mvo9dPOyRvSzZJ2Dz1R/dBLOWLnNN80TGcndcb25WS
         nGrxE6ZGR3N2uFYU+kJeK+uzXxeVmtC/xOVzj/zsm7/NEYgppj9EGWJofH7d2BFh/5
         4WnleCvx2PapmkyQfThKz/MBobtsUW+RwIrweAxBvEfXgVeQq4dN8zDQY99JosCDPB
         chl3l4OM+v04JvTsi1IokE+4wdIiTFoc/3PuRFcfMflR/fIuOR0996lZS/T6grf5In
         gZu8MOgSYRF/VrAq0QjkVRWNE8l3J4vQ/1TkWuClV1qihCyvKNOrncMytYG29RJKpK
         oGJbHM2xfednw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 896B24011C; Tue, 25 May 2021 16:54:58 -0300 (-03)
Date:   Tue, 25 May 2021 16:54:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] perf scripting python: Add auxtrace error
Message-ID: <YK1WErTho7PR/UNs@kernel.org>
References: <20210525095112.1399-1-adrian.hunter@intel.com>
 <20210525095112.1399-10-adrian.hunter@intel.com>
 <YKz1inwKEPLvx9fr@kernel.org>
 <a2e8f587-412a-90a8-f12d-218a37a26482@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2e8f587-412a-90a8-f12d-218a37a26482@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 25, 2021 at 09:30:50PM +0300, Adrian Hunter escreveu:
> On 25/05/21 4:03 pm, Arnaldo Carvalho de Melo wrote:
> > Em Tue, May 25, 2021 at 12:51:11PM +0300, Adrian Hunter escreveu:
> >> Add auxtrace_error to general python scripting.
> >>
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>  tools/perf/builtin-script.c                   | 13 ++++++
> >>  .../scripting-engines/trace-event-python.c    | 42 +++++++++++++++++++
> >>  tools/perf/util/trace-event.h                 |  2 +
> >>  3 files changed, 57 insertions(+)
> >>
> >> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> >> index 69bce65ea430..7a7a19f52db5 100644
> >> --- a/tools/perf/builtin-script.c
> >> +++ b/tools/perf/builtin-script.c
> >> @@ -2432,6 +2432,17 @@ static int process_switch_event(struct perf_tool *tool,
> >>  			   sample->tid);
> >>  }
> >>  
> >> +static int process_auxtrace_error(struct perf_session *session,
> >> +				  union perf_event *event)
> >> +{
> >> +	if (scripting_ops && scripting_ops->process_auxtrace_error) {
> >> +		scripting_ops->process_auxtrace_error(session, event);
> >> +		return 0;
> >> +	}
> >> +
> >> +	return perf_event__process_auxtrace_error(session, event);
> >> +}
> >> +
> > 
> > Those definitions in auxtrace.h:
> > 
> > e31f0d017ea19fce9 (Adrian Hunter  2015-04-30 17:37:27 +0300 706) #define perf_event__process_auxtrace_info            0
> > e31f0d017ea19fce9 (Adrian Hunter  2015-04-30 17:37:27 +0300 707) #define perf_event__process_auxtrace                 0
> > e31f0d017ea19fce9 (Adrian Hunter  2015-04-30 17:37:27 +0300 708) #define perf_event__process_auxtrace_error           0
> > 
> > came back to haunt us :-)
> 
> Sorry about that
> 
> > 
> > I'll try making them the usual inlines, etc
> 
> Thank you! :-)

Its fixed by now and out in my perf/core branch, as all tests passed
successfully, i.e. will not be rebased.

- Arnaldo
 
> > 
> > - Arnaldo
> > 
> > 
> >               make_minimal_O: cd . && make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j24 O=/tmp/tmp.rGrdpQlTCr DESTDIR=/tmp/tmp.png5u8ITR9
> > cd . && make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j24 O=/tmp/tmp.rGrdpQlTCr DESTDIR=/tmp/tmp.png5u8ITR9
> >   BUILD:   Doing 'make -j24' parallel build
> > <SNIP>
> >   CC      /tmp/tmp.rGrdpQlTCr/builtin-daemon.o
> > In file included from util/events_stats.h:8,
> >                  from util/evlist.h:12,
> >                  from builtin-script.c:18:
> > builtin-script.c: In function ‘process_auxtrace_error’:
> > util/auxtrace.h:708:57: error: called object is not a function or function pointer
> >   708 | #define perf_event__process_auxtrace_error              0
> >       |                                                         ^
> > builtin-script.c:2443:16: note: in expansion of macro ‘perf_event__process_auxtrace_error’
> >  2443 |         return perf_event__process_auxtrace_error(session, event);
> >       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   MKDIR   /tmp/tmp.rGrdpQlTCr/tests/
> >   MKDIR   /tmp/tmp.rGrdpQlTCr/bench/
> >   CC      /tmp/tmp.rGrdpQlTCr/tests/builtin-test.o
> >   CC      /tmp/tmp.rGrdpQlTCr/bench/sched-messaging.o
> > builtin-script.c:2444:1: error: control reaches end of non-void function [-Werror=return-type]
> >  2444 | }
> >       | ^
> > cc1: all warnings being treated as errors
> > make[5]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/tmp.rGrdpQlTCr/builtin-script.o] Error 1
> > make[5]: *** Waiting for unfinished jobs....
> >   MKDIR   /tmp/tmp.rGrdpQlTCr/tests/
> >   CC      /tmp/tmp.rGrdpQlTCr/tests/parse-events.o
> >   MKDIR   /tmp/tmp.rGrdpQlTCr/bench/
> >   CC      /tmp/tmp.rGrdpQlTCr/bench/sched-pipe.o
> > 
> > 
> > 
> >>  static int
> >>  process_lost_event(struct perf_tool *tool,
> >>  		   union perf_event *event,
> >> @@ -2571,6 +2582,8 @@ static int __cmd_script(struct perf_script *script)
> >>  	}
> >>  	if (script->show_switch_events || (scripting_ops && scripting_ops->process_switch))
> >>  		script->tool.context_switch = process_switch_event;
> >> +	if (scripting_ops && scripting_ops->process_auxtrace_error)
> >> +		script->tool.auxtrace_error = process_auxtrace_error;
> >>  	if (script->show_namespace_events)
> >>  		script->tool.namespaces = process_namespaces_event;
> >>  	if (script->show_cgroup_events)
> >> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> >> index c422901d5344..ffc5f4cffdba 100644
> >> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> >> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> >> @@ -1014,6 +1014,11 @@ static int tuple_set_u64(PyObject *t, unsigned int pos, u64 val)
> >>  #endif
> >>  }
> >>  
> >> +static int tuple_set_u32(PyObject *t, unsigned int pos, u32 val)
> >> +{
> >> +	return PyTuple_SetItem(t, pos, PyLong_FromUnsignedLong(val));
> >> +}
> >> +
> >>  static int tuple_set_s32(PyObject *t, unsigned int pos, s32 val)
> >>  {
> >>  	return PyTuple_SetItem(t, pos, _PyLong_FromLong(val));
> >> @@ -1461,6 +1466,42 @@ static void python_process_switch(union perf_event *event,
> >>  		python_do_process_switch(event, sample, machine);
> >>  }
> >>  
> >> +static void python_process_auxtrace_error(struct perf_session *session __maybe_unused,
> >> +					  union perf_event *event)
> >> +{
> >> +	struct perf_record_auxtrace_error *e = &event->auxtrace_error;
> >> +	u8 cpumode = e->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
> >> +	const char *handler_name = "auxtrace_error";
> >> +	unsigned long long tm = e->time;
> >> +	const char *msg = e->msg;
> >> +	PyObject *handler, *t;
> >> +
> >> +	handler = get_handler(handler_name);
> >> +	if (!handler)
> >> +		return;
> >> +
> >> +	if (!e->fmt) {
> >> +		tm = 0;
> >> +		msg = (const char *)&e->time;
> >> +	}
> >> +
> >> +	t = tuple_new(9);
> >> +
> >> +	tuple_set_u32(t, 0, e->type);
> >> +	tuple_set_u32(t, 1, e->code);
> >> +	tuple_set_s32(t, 2, e->cpu);
> >> +	tuple_set_s32(t, 3, e->pid);
> >> +	tuple_set_s32(t, 4, e->tid);
> >> +	tuple_set_u64(t, 5, e->ip);
> >> +	tuple_set_u64(t, 6, tm);
> >> +	tuple_set_string(t, 7, msg);
> >> +	tuple_set_u32(t, 8, cpumode);
> >> +
> >> +	call_object(handler, t, handler_name);
> >> +
> >> +	Py_DECREF(t);
> >> +}
> >> +
> >>  static void get_handler_name(char *str, size_t size,
> >>  			     struct evsel *evsel)
> >>  {
> >> @@ -1999,6 +2040,7 @@ struct scripting_ops python_scripting_ops = {
> >>  	.stop_script		= python_stop_script,
> >>  	.process_event		= python_process_event,
> >>  	.process_switch		= python_process_switch,
> >> +	.process_auxtrace_error	= python_process_auxtrace_error,
> >>  	.process_stat		= python_process_stat,
> >>  	.process_stat_interval	= python_process_stat_interval,
> >>  	.generate_script	= python_generate_script,
> >> diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
> >> index 7276674e2971..35c354a15c3a 100644
> >> --- a/tools/perf/util/trace-event.h
> >> +++ b/tools/perf/util/trace-event.h
> >> @@ -83,6 +83,8 @@ struct scripting_ops {
> >>  	void (*process_switch)(union perf_event *event,
> >>  			       struct perf_sample *sample,
> >>  			       struct machine *machine);
> >> +	void (*process_auxtrace_error)(struct perf_session *session,
> >> +				       union perf_event *event);
> >>  	void (*process_stat)(struct perf_stat_config *config,
> >>  			     struct evsel *evsel, u64 tstamp);
> >>  	void (*process_stat_interval)(u64 tstamp);
> >> -- 
> >> 2.17.1
> >>
> > 
> 

-- 

- Arnaldo
