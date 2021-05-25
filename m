Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFF33908FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 20:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbhEYScD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 14:32:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:9339 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231622AbhEYSb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 14:31:59 -0400
IronPort-SDR: 8bnmSnI4jkQzyVULFPCBMAwVZhyN3hWEJZNQl1RVoVIipS2/oIWdLz5IZZnI/oLlWrjP2WFa7b
 o5uGQQlLCNbA==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="200370313"
X-IronPort-AV: E=Sophos;i="5.82,329,1613462400"; 
   d="scan'208";a="200370313"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 11:30:28 -0700
IronPort-SDR: FcooulSB4W7wmrkisYUyYIKd3TDRfHSx1W1QOGJyznrnum0oLqiNVa2AZNjjvso7r/amqHx/4y
 lHVb9sxcV/yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,329,1613462400"; 
   d="scan'208";a="546878415"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga004.jf.intel.com with ESMTP; 25 May 2021 11:30:26 -0700
Subject: Re: [PATCH 09/10] perf scripting python: Add auxtrace error
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20210525095112.1399-1-adrian.hunter@intel.com>
 <20210525095112.1399-10-adrian.hunter@intel.com>
 <YKz1inwKEPLvx9fr@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a2e8f587-412a-90a8-f12d-218a37a26482@intel.com>
Date:   Tue, 25 May 2021 21:30:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKz1inwKEPLvx9fr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/21 4:03 pm, Arnaldo Carvalho de Melo wrote:
> Em Tue, May 25, 2021 at 12:51:11PM +0300, Adrian Hunter escreveu:
>> Add auxtrace_error to general python scripting.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  tools/perf/builtin-script.c                   | 13 ++++++
>>  .../scripting-engines/trace-event-python.c    | 42 +++++++++++++++++++
>>  tools/perf/util/trace-event.h                 |  2 +
>>  3 files changed, 57 insertions(+)
>>
>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>> index 69bce65ea430..7a7a19f52db5 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
>> @@ -2432,6 +2432,17 @@ static int process_switch_event(struct perf_tool *tool,
>>  			   sample->tid);
>>  }
>>  
>> +static int process_auxtrace_error(struct perf_session *session,
>> +				  union perf_event *event)
>> +{
>> +	if (scripting_ops && scripting_ops->process_auxtrace_error) {
>> +		scripting_ops->process_auxtrace_error(session, event);
>> +		return 0;
>> +	}
>> +
>> +	return perf_event__process_auxtrace_error(session, event);
>> +}
>> +
> 
> Those definitions in auxtrace.h:
> 
> e31f0d017ea19fce9 (Adrian Hunter  2015-04-30 17:37:27 +0300 706) #define perf_event__process_auxtrace_info            0
> e31f0d017ea19fce9 (Adrian Hunter  2015-04-30 17:37:27 +0300 707) #define perf_event__process_auxtrace                 0
> e31f0d017ea19fce9 (Adrian Hunter  2015-04-30 17:37:27 +0300 708) #define perf_event__process_auxtrace_error           0
> 
> came back to haunt us :-)

Sorry about that

> 
> I'll try making them the usual inlines, etc

Thank you! :-)

> 
> - Arnaldo
> 
> 
>               make_minimal_O: cd . && make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j24 O=/tmp/tmp.rGrdpQlTCr DESTDIR=/tmp/tmp.png5u8ITR9
> cd . && make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1 FEATURES_DUMP=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j24 O=/tmp/tmp.rGrdpQlTCr DESTDIR=/tmp/tmp.png5u8ITR9
>   BUILD:   Doing 'make -j24' parallel build
> <SNIP>
>   CC      /tmp/tmp.rGrdpQlTCr/builtin-daemon.o
> In file included from util/events_stats.h:8,
>                  from util/evlist.h:12,
>                  from builtin-script.c:18:
> builtin-script.c: In function ‘process_auxtrace_error’:
> util/auxtrace.h:708:57: error: called object is not a function or function pointer
>   708 | #define perf_event__process_auxtrace_error              0
>       |                                                         ^
> builtin-script.c:2443:16: note: in expansion of macro ‘perf_event__process_auxtrace_error’
>  2443 |         return perf_event__process_auxtrace_error(session, event);
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   MKDIR   /tmp/tmp.rGrdpQlTCr/tests/
>   MKDIR   /tmp/tmp.rGrdpQlTCr/bench/
>   CC      /tmp/tmp.rGrdpQlTCr/tests/builtin-test.o
>   CC      /tmp/tmp.rGrdpQlTCr/bench/sched-messaging.o
> builtin-script.c:2444:1: error: control reaches end of non-void function [-Werror=return-type]
>  2444 | }
>       | ^
> cc1: all warnings being treated as errors
> make[5]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/tmp.rGrdpQlTCr/builtin-script.o] Error 1
> make[5]: *** Waiting for unfinished jobs....
>   MKDIR   /tmp/tmp.rGrdpQlTCr/tests/
>   CC      /tmp/tmp.rGrdpQlTCr/tests/parse-events.o
>   MKDIR   /tmp/tmp.rGrdpQlTCr/bench/
>   CC      /tmp/tmp.rGrdpQlTCr/bench/sched-pipe.o
> 
> 
> 
>>  static int
>>  process_lost_event(struct perf_tool *tool,
>>  		   union perf_event *event,
>> @@ -2571,6 +2582,8 @@ static int __cmd_script(struct perf_script *script)
>>  	}
>>  	if (script->show_switch_events || (scripting_ops && scripting_ops->process_switch))
>>  		script->tool.context_switch = process_switch_event;
>> +	if (scripting_ops && scripting_ops->process_auxtrace_error)
>> +		script->tool.auxtrace_error = process_auxtrace_error;
>>  	if (script->show_namespace_events)
>>  		script->tool.namespaces = process_namespaces_event;
>>  	if (script->show_cgroup_events)
>> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
>> index c422901d5344..ffc5f4cffdba 100644
>> --- a/tools/perf/util/scripting-engines/trace-event-python.c
>> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
>> @@ -1014,6 +1014,11 @@ static int tuple_set_u64(PyObject *t, unsigned int pos, u64 val)
>>  #endif
>>  }
>>  
>> +static int tuple_set_u32(PyObject *t, unsigned int pos, u32 val)
>> +{
>> +	return PyTuple_SetItem(t, pos, PyLong_FromUnsignedLong(val));
>> +}
>> +
>>  static int tuple_set_s32(PyObject *t, unsigned int pos, s32 val)
>>  {
>>  	return PyTuple_SetItem(t, pos, _PyLong_FromLong(val));
>> @@ -1461,6 +1466,42 @@ static void python_process_switch(union perf_event *event,
>>  		python_do_process_switch(event, sample, machine);
>>  }
>>  
>> +static void python_process_auxtrace_error(struct perf_session *session __maybe_unused,
>> +					  union perf_event *event)
>> +{
>> +	struct perf_record_auxtrace_error *e = &event->auxtrace_error;
>> +	u8 cpumode = e->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
>> +	const char *handler_name = "auxtrace_error";
>> +	unsigned long long tm = e->time;
>> +	const char *msg = e->msg;
>> +	PyObject *handler, *t;
>> +
>> +	handler = get_handler(handler_name);
>> +	if (!handler)
>> +		return;
>> +
>> +	if (!e->fmt) {
>> +		tm = 0;
>> +		msg = (const char *)&e->time;
>> +	}
>> +
>> +	t = tuple_new(9);
>> +
>> +	tuple_set_u32(t, 0, e->type);
>> +	tuple_set_u32(t, 1, e->code);
>> +	tuple_set_s32(t, 2, e->cpu);
>> +	tuple_set_s32(t, 3, e->pid);
>> +	tuple_set_s32(t, 4, e->tid);
>> +	tuple_set_u64(t, 5, e->ip);
>> +	tuple_set_u64(t, 6, tm);
>> +	tuple_set_string(t, 7, msg);
>> +	tuple_set_u32(t, 8, cpumode);
>> +
>> +	call_object(handler, t, handler_name);
>> +
>> +	Py_DECREF(t);
>> +}
>> +
>>  static void get_handler_name(char *str, size_t size,
>>  			     struct evsel *evsel)
>>  {
>> @@ -1999,6 +2040,7 @@ struct scripting_ops python_scripting_ops = {
>>  	.stop_script		= python_stop_script,
>>  	.process_event		= python_process_event,
>>  	.process_switch		= python_process_switch,
>> +	.process_auxtrace_error	= python_process_auxtrace_error,
>>  	.process_stat		= python_process_stat,
>>  	.process_stat_interval	= python_process_stat_interval,
>>  	.generate_script	= python_generate_script,
>> diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
>> index 7276674e2971..35c354a15c3a 100644
>> --- a/tools/perf/util/trace-event.h
>> +++ b/tools/perf/util/trace-event.h
>> @@ -83,6 +83,8 @@ struct scripting_ops {
>>  	void (*process_switch)(union perf_event *event,
>>  			       struct perf_sample *sample,
>>  			       struct machine *machine);
>> +	void (*process_auxtrace_error)(struct perf_session *session,
>> +				       union perf_event *event);
>>  	void (*process_stat)(struct perf_stat_config *config,
>>  			     struct evsel *evsel, u64 tstamp);
>>  	void (*process_stat_interval)(u64 tstamp);
>> -- 
>> 2.17.1
>>
> 

