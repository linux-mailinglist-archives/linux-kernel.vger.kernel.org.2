Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1DB3FCD0E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 20:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239289AbhHaSrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 14:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45691 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239218AbhHaSr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 14:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630435594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5lwQet41+LOfX6gb+yl91tWdO0e3A6tYLVcBbMPZZEY=;
        b=SEmpQmXQea92wmwtCins/THZxNcVkN0Rr11NWwyy9oOISEZk+GyyXOH+Fp/nyRvcyBwq3e
        s1rf7InDWwtKnW34mQbld0+KsmrrO2fWCb7/kzoAz9ia0NoJAIlQfn+FGXsCrbz4d7kSQA
        COmdd8GQ/p93NuHsZidJaq5kgl0QOLI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-WEae6PK-MXO93oFQ7EhlCw-1; Tue, 31 Aug 2021 14:46:32 -0400
X-MC-Unique: WEae6PK-MXO93oFQ7EhlCw-1
Received: by mail-ed1-f70.google.com with SMTP id s15-20020a056402520f00b003cad788f1f6so3859062edd.22
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 11:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5lwQet41+LOfX6gb+yl91tWdO0e3A6tYLVcBbMPZZEY=;
        b=GkYoUnEe4MrXXKYSS6wHj7ZB60y9bYsmB3X8/LgxaZ2vt/citEMxloB8LEuIDo0W8w
         NYt7ssw6nlaYfDnpVbfb426mS3F/TeXI8uAWO0U6s9VjZ732BWFS5aJA9FQPpjbvVBfW
         cskdyiT0j2UBW8ooaCNhso7VlCudCRHnBzFgo0Y95NKO1Wn6L+KwJFbJ2oVuMs7iCrN7
         45R4THglFvV9X7hgV4TXVdY8SR7j73uuu1yI1LaLWPcDolP/0cZrAnbxgFEtvgHa/SzO
         YKuLgp70PwpVhau4G/QulkEoGjqrRixfD1r8BEpAzBJM3IOwCdBSfP+UPYlcryrUx8lw
         md/A==
X-Gm-Message-State: AOAM5304LR8/0XM+D/CXMN6k4yMhueAQv5MJuWhVtsUaL7cOl02yL8aD
        /R1NoOnir144TYBm3DVX3dkjLEjKGKrRmMKIy8mndu0YXWZE1xU4sru2b3tfD3S3B/nekJJkkSl
        CCxLXPFgH+3pe72WebwnWqVgE
X-Received: by 2002:a17:906:25db:: with SMTP id n27mr31679905ejb.108.1630435591490;
        Tue, 31 Aug 2021 11:46:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSB8R8/V8b7ImkxC5j7YNJdMHMhEC9eEdI6+g85odJIm+SH8a7hVaISebUg+zxVmMsPlmZrg==
X-Received: by 2002:a17:906:25db:: with SMTP id n27mr31679881ejb.108.1630435591267;
        Tue, 31 Aug 2021 11:46:31 -0700 (PDT)
Received: from krava ([2a00:102a:4005:bb4:e4bf:9f13:dbe6:2d14])
        by smtp.gmail.com with ESMTPSA id i11sm9763247edu.97.2021.08.31.11.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 11:46:30 -0700 (PDT)
Date:   Tue, 31 Aug 2021 20:46:28 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] perf script python: Allow reporting [un]throttle
Message-ID: <YS55BApYslmJuqPh@krava>
References: <20210817002133.48097-1-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817002133.48097-1-stephen.s.brennan@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 05:21:33PM -0700, Stephen Brennan wrote:
> perf_events may sometimes throttle an event due to creating too many
> samples during a given timer tick. As of now, the perf tool will not
> report on throttling, which means this is a silent error. Implement a
> callback for the throttle and unthrottle events within the Python
> scripting engine, which can allow scripts to detect and report when
> events may have been lost due to throttling.
> 
> A python script could simply define throttle() and unthrottle()
> functions to begin receiving them, e.g.:
> 
> ```
> from __future__ import print_function
> 
> def process_event(param_dict):
>     print("event cpu={} time={}".format(
>         param_dict["sample"]["cpu"], param_dict["sample"]["time"]))
> 
> def throttle(*args):
>     print("throttle(time={}, cpu={}, pid={}, tid={})".format(*args))
> 
> def unthrottle(*args):
>     print("unthrottle(time={}, cpu={}, pid={}, tid={})".format(*args))
> ```

throttle event has also 'id' and 'stream_id' I guess you don't
need it, but maybe we should add it to be complete

otherwose looks good

jirka

> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
> 
> Since this mailing list thread[1] I've been wondering about ways to
> detect and handle throttling. Perf will warn when events are missed
> because the ring buffer filled up, but it will not give any indication
> about the throttling -- except for the throttle message logged by the
> kernel. Ideally, I'd like to also extend the other perf tools to give
> a warning, but detecting it after the fact via a script was easiest to
> implement, and most flexible for me to use. I'd appreciate feedback on
> this change as well as what such a warning in perf record/report would
> look like. For example:
> 
> [ perf record: WARNING: samples were throttled %u times for %u seconds ]
> 
> [1]: https://lore.kernel.org/linux-perf-users/87lf6rclcm.fsf@stepbren-lnx.us.oracle.com/T/#u
> 
>  tools/perf/builtin-script.c                   | 13 ++++++++
>  .../scripting-engines/trace-event-python.c    | 30 +++++++++++++++++++
>  tools/perf/util/trace-event.h                 |  3 ++
>  3 files changed, 46 insertions(+)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 064da7f3618d..072869a35f85 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2492,6 +2492,17 @@ process_lost_event(struct perf_tool *tool,
>  			   sample->tid);
>  }
>  
> +static int
> +process_throttle_event(struct perf_tool *tool __maybe_unused,
> +		       union perf_event *event,
> +		       struct perf_sample *sample,
> +		       struct machine *machine)
> +{
> +	if (scripting_ops && scripting_ops->process_throttle)
> +		scripting_ops->process_throttle(event, sample, machine);
> +	return 0;
> +}
> +
>  static int
>  process_finished_round_event(struct perf_tool *tool __maybe_unused,
>  			     union perf_event *event,
> @@ -3652,6 +3663,8 @@ int cmd_script(int argc, const char **argv)
>  			.stat_config	 = process_stat_config_event,
>  			.thread_map	 = process_thread_map_event,
>  			.cpu_map	 = process_cpu_map_event,
> +			.throttle	 = process_throttle_event,
> +			.unthrottle	 = process_throttle_event,
>  			.ordered_events	 = true,
>  			.ordering_requires_timestamps = true,
>  		},
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 69129e2aa7a1..5ef1ba5e29bb 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -1422,6 +1422,35 @@ static void python_process_event(union perf_event *event,
>  	}
>  }
>  
> +static void python_process_throttle(union perf_event *event,
> +				    struct perf_sample *sample,
> +				    struct machine *machine)
> +{
> +	const char *handler_name;
> +	PyObject *handler, *t;
> +
> +	if (event->header.type == PERF_RECORD_THROTTLE)
> +		handler_name = "throttle";
> +	else
> +		handler_name = "unthrottle";
> +	handler = get_handler(handler_name);
> +	if (!handler)
> +		return;
> +
> +	t = tuple_new(4);
> +	if (!t)
> +		return;
> +
> +	tuple_set_u64(t, 0, sample->time);
> +	tuple_set_s32(t, 1, sample->cpu);
> +	tuple_set_s32(t, 2, sample->pid);
> +	tuple_set_s32(t, 3, sample->tid);
> +
> +	call_object(handler, t, handler_name);
> +
> +	Py_DECREF(t);
> +}
> +
>  static void python_do_process_switch(union perf_event *event,
>  				     struct perf_sample *sample,
>  				     struct machine *machine)
> @@ -2079,5 +2108,6 @@ struct scripting_ops python_scripting_ops = {
>  	.process_auxtrace_error	= python_process_auxtrace_error,
>  	.process_stat		= python_process_stat,
>  	.process_stat_interval	= python_process_stat_interval,
> +	.process_throttle	= python_process_throttle,
>  	.generate_script	= python_generate_script,
>  };
> diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
> index 54aadeedf28c..640981105788 100644
> --- a/tools/perf/util/trace-event.h
> +++ b/tools/perf/util/trace-event.h
> @@ -90,6 +90,9 @@ struct scripting_ops {
>  	void (*process_stat)(struct perf_stat_config *config,
>  			     struct evsel *evsel, u64 tstamp);
>  	void (*process_stat_interval)(u64 tstamp);
> +	void (*process_throttle)(union perf_event *event,
> +				 struct perf_sample *sample,
> +				 struct machine *machine);
>  	int (*generate_script) (struct tep_handle *pevent, const char *outfile);
>  };
>  
> -- 
> 2.30.2
> 

