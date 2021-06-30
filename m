Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8530A3B888F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 20:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbhF3Sj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 14:39:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234478AbhF3SjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 14:39:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40974613F1;
        Wed, 30 Jun 2021 18:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625078215;
        bh=i907bq5Q74JNq6szL7VJHZaktp1wkdZJhhYltX8DBhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RNmJXKTllWZXiCehrvEPYk05C4asKJRZqNBi30QGDn4KOW/jOXH4mpGIoreOiKAXJ
         +Gz9MbvQRp8XFxTeA5niEX+P39fMBvhXrvIgm662Alh+exAIPZV+IzVLolA+RmVjir
         Lwk0jGpAcxHo7m3tU4HQCaEK+KMSuBduGrqck2hlnck+GrTv5G/PHRgjESAN/bsdYr
         el7UOr+WPH1qi3OP6HWsPew6Af8m1DmG7PfYjYwA2Df581+LmMYl0GOIkLvqKEOwAy
         b3tYaPVKikoOYoWcaAAs3ZUFuTnmMgXfPMnX21m1DrNwTeloA+EkcRYcJJqVYfGV5N
         rUjWoiggbtnZQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 608CE40B1A; Wed, 30 Jun 2021 15:36:52 -0300 (-03)
Date:   Wed, 30 Jun 2021 15:36:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v8 12/22] perf report: Output data file name in raw trace
 dump
Message-ID: <YNy5xERHrtldjIM8@kernel.org>
References: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <783fdabdb6bd62114a658eb360d2772f9662a55d.1625065643.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <783fdabdb6bd62114a658eb360d2772f9662a55d.1625065643.git.alexey.v.bayduraev@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 30, 2021 at 06:54:51PM +0300, Alexey Bayduraev escreveu:
> Print path and name of a data file into raw dump (-D)
> <file_offset>@<path/file>. Print offset of PERF_RECORD_COMPRESSED
> record instead of zero for decompressed records:
>   0x2226a@perf.data [0x30]: event: 9
> or
>   0x15cc36@perf.data/data.7 [0x30]: event: 9

You're changing the logic in a subtle way here, see below
 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Acked-by: Andi Kleen <ak@linux.intel.com>

<SNIP>

> @@ -2021,7 +2031,8 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
>  		}
>  	}
>  
> -	if ((skip = perf_session__process_event(session, event, head)) < 0) {
> +	skip = perf_session__process_event(session, event, head, "pipe");
> +	if (skip < 0) {


Why do this in this patch? Its not needed, leave it alone to make the
patch smaller.

>  		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
>  		       head, event->header.size, event->header.type);
>  		err = -EINVAL;
> @@ -2102,7 +2113,7 @@ fetch_decomp_event(u64 head, size_t mmap_size, char *buf, bool needs_swap)
>  static int __perf_session__process_decomp_events(struct perf_session *session)
>  {
>  	s64 skip;
> -	u64 size, file_pos = 0;
> +	u64 size;
>  	struct decomp *decomp = session->decomp_last;
>  
>  	if (!decomp)
> @@ -2116,9 +2127,9 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
>  			break;
>  
>  		size = event->header.size;
> -
> -		if (size < sizeof(struct perf_event_header) ||
> -		    (skip = perf_session__process_event(session, event, file_pos)) < 0) {


The call to perf_session__process_event() will not be made if

  (size < sizeof(struct perf_event_header)

evaluates to true, with your change it is being made unconditionally,
also before it was using that file_pos variable, set to zero and
possibly modified by the logic in this function.

And I read just "perf report: Output data file name in raw trace", so
when I saw this separate change to pass 'decomp->file_pos' and remove
that 'file_pos = 0' part I scratched my head, then I read again the
commit log messsage and there it says it also does this separate change.

Please make it separate patch where you explain why this has to be done
this way and what previous cset this fixes, so that the
stable@kernel.org guys pick it as it sounds like a fix.

> +		skip = perf_session__process_event(session, event, decomp->file_pos,
> +						   decomp->file_path);
> +		if (size < sizeof(struct perf_event_header) || skip < 0) {
>  			pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
>  				decomp->file_pos + decomp->head, event->header.size, event->header.type);
>  			return -EINVAL;
> @@ -2149,10 +2160,12 @@ struct reader;
>  
>  typedef s64 (*reader_cb_t)(struct perf_session *session,
>  			   union perf_event *event,
> -			   u64 file_offset);
> +			   u64 file_offset,
> +			   const char *file_path);
>  
>  struct reader {
>  	int		 fd;
> +	const char	 *path;
>  	u64		 data_size;
>  	u64		 data_offset;
>  	reader_cb_t	 process;
> @@ -2234,9 +2247,9 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  	skip = -EINVAL;
>  
>  	if (size < sizeof(struct perf_event_header) ||
> -	    (skip = rd->process(session, event, file_pos)) < 0) {
> -		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%s]\n",
> -		       file_offset + head, event->header.size,
> +	    (skip = rd->process(session, event, file_pos, rd->path)) < 0) {
> +		pr_err("%#" PRIx64 " [%s] [%#x]: failed to process type: %d [%s]\n",
> +		       file_offset + head, rd->path, event->header.size,
>  		       event->header.type, strerror(-skip));
>  		err = skip;
>  		goto out;
> @@ -2266,9 +2279,10 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  
>  static s64 process_simple(struct perf_session *session,
>  			  union perf_event *event,
> -			  u64 file_offset)
> +			  u64 file_offset,
> +			  const char *file_path)
>  {
> -	return perf_session__process_event(session, event, file_offset);
> +	return perf_session__process_event(session, event, file_offset, file_path);
>  }
>  
>  static int __perf_session__process_events(struct perf_session *session)
> @@ -2278,6 +2292,7 @@ static int __perf_session__process_events(struct perf_session *session)
>  		.data_size	= session->header.data_size,
>  		.data_offset	= session->header.data_offset,
>  		.process	= process_simple,
> +		.path		= session->data->file.path,
>  		.in_place_update = session->data->in_place_update,
>  	};
>  	struct ordered_events *oe = &session->ordered_events;
> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> index e31ba4c92a6c..6895a22ab5b7 100644
> --- a/tools/perf/util/session.h
> +++ b/tools/perf/util/session.h
> @@ -46,6 +46,7 @@ struct perf_session {
>  struct decomp {
>  	struct decomp *next;
>  	u64 file_pos;
> +	const char *file_path;
>  	size_t mmap_len;
>  	u64 head;
>  	size_t size;
> diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
> index bbbc0dcd461f..c966531d3eca 100644
> --- a/tools/perf/util/tool.h
> +++ b/tools/perf/util/tool.h
> @@ -28,7 +28,8 @@ typedef int (*event_attr_op)(struct perf_tool *tool,
>  
>  typedef int (*event_op2)(struct perf_session *session, union perf_event *event);
>  typedef s64 (*event_op3)(struct perf_session *session, union perf_event *event);
> -typedef int (*event_op4)(struct perf_session *session, union perf_event *event, u64 data);
> +typedef int (*event_op4)(struct perf_session *session, union perf_event *event, u64 data,
> +			 const char *str);
>  
>  typedef int (*event_oe)(struct perf_tool *tool, union perf_event *event,
>  			struct ordered_events *oe);
> -- 
> 2.19.0
> 

-- 

- Arnaldo
