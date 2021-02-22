Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A53932217C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 22:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhBVVej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 16:34:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27790 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230483AbhBVVeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614029569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VHkykbHbCEbhfXQcCGBmKQ16MwG/Vbgco6JD4wruzP4=;
        b=W0aJF6bsBCjCfOSHp45+mTjrXqPmjbUpQPXOz4EcRDyqmJuRT1RJGJQnP885+FiGNWn0nc
        aqN+OueMZXtDI/Ka5dFdQGyzxh6a5xncDjMss7ClZqx/VVZAkrO2w+UF8e/K126WaiTDyf
        nqdksDfY6OwuVwT3gXj267GrCnL6Z04=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-6zMpvab5MqqmPONQh-W39A-1; Mon, 22 Feb 2021 16:32:45 -0500
X-MC-Unique: 6zMpvab5MqqmPONQh-W39A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09F158030BB;
        Mon, 22 Feb 2021 21:32:44 +0000 (UTC)
Received: from krava (unknown [10.40.195.254])
        by smtp.corp.redhat.com (Postfix) with SMTP id E18371346F;
        Mon, 22 Feb 2021 21:32:41 +0000 (UTC)
Date:   Mon, 22 Feb 2021 22:32:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf report: Create option to disable raw event ordering
Message-ID: <YDQi+OxAq256vbKP@krava>
References: <20210219070005.12397-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219070005.12397-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 03:00:05PM +0800, Jin Yao wrote:
> Warning "dso not found" is reported when using "perf report -D".
> 
>  66702781413407 0x32c0 [0x30]: PERF_RECORD_SAMPLE(IP, 0x2): 28177/28177: 0x55e493e00563 period: 106578 addr: 0
>   ... thread: perf:28177
>   ...... dso: <not found>
> 
>  66702727832429 0x9dd8 [0x38]: PERF_RECORD_COMM exec: triad_loop:28177/28177
> 
> The PERF_RECORD_SAMPLE event (timestamp: 66702781413407) should be after the
> PERF_RECORD_COMM event (timestamp: 66702727832429), but it's early processed.
> 
> So for most of cases, it makes sense to keep the event ordered even for dump
> mode. But it would be also useful to disable ordered_events for reporting raw
> dump to see events as they are stored in the perf.data file.
> 
> So now, set ordered_events by default to true and add a new option
> 'disable-order' to disable it. For example,
> 
> perf report -D --disable-order
> 
> Fixes: 977f739b7126b ("perf report: Disable ordered_events for raw dump")
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka


> ---
>  tools/perf/Documentation/perf-report.txt | 3 +++
>  tools/perf/builtin-report.c              | 5 ++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index f546b5e9db05..87112e8d904e 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -224,6 +224,9 @@ OPTIONS
>  --dump-raw-trace::
>          Dump raw trace in ASCII.
>  
> +--disable-order::
> +	Disable raw trace ordering.
> +
>  -g::
>  --call-graph=<print_type,threshold[,print_limit],order,sort_key[,branch],value>::
>          Display call chains using type, min percent threshold, print limit,
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 2a845d6cac09..0d65c98794a8 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -84,6 +84,7 @@ struct report {
>  	bool			nonany_branch_mode;
>  	bool			group_set;
>  	bool			stitch_lbr;
> +	bool			disable_order;
>  	int			max_stack;
>  	struct perf_read_values	show_threads_values;
>  	struct annotation_options annotation_opts;
> @@ -1296,6 +1297,8 @@ int cmd_report(int argc, const char **argv)
>  	OPTS_EVSWITCH(&report.evswitch),
>  	OPT_BOOLEAN(0, "total-cycles", &report.total_cycles_mode,
>  		    "Sort all blocks by 'Sampled Cycles%'"),
> +	OPT_BOOLEAN(0, "disable-order", &report.disable_order,
> +		    "Disable raw trace ordering"),
>  	OPT_END()
>  	};
>  	struct perf_data data = {
> @@ -1329,7 +1332,7 @@ int cmd_report(int argc, const char **argv)
>  	if (report.mmaps_mode)
>  		report.tasks_mode = true;
>  
> -	if (dump_trace)
> +	if (dump_trace && report.disable_order)
>  		report.tool.ordered_events = false;
>  
>  	if (quiet)
> -- 
> 2.17.1
> 

