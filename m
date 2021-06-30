Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3A83B87AE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 19:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhF3RbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 13:31:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhF3RbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 13:31:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 304ED61426;
        Wed, 30 Jun 2021 17:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625074130;
        bh=ieiRIrsZiDELy8gVDCFuEeNIdojqUXTzRrvgvICEWDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XmRYc6iciSOoBgGQbFnqTW3DvINkqm4n5xHEWsS+5kyhrMVG6hoAVlFoFILWh0gHi
         zw2f8Rnvlj5n4sP7l4o0r4lYvPTcglB6ezyd9LypX4OnbfE57xiXBeNSguIDsDMQcX
         vwWlbP9dxoHcxZ8j9dBzd2G2axDX+IiSZu8ckN6KUzGzHmUGGonBDx8Z8wDlrYM0Hv
         MIXBAvoB35RVW1ZoXS4SJbHRSwKhXcydbqfqWVVJgFT4GNSmAsQnMobqBZuLNoQXnL
         zWNDRahRktN7nCIP8PFjlS9Qp7FZAu8MgSuSbasl8+UAJRbjSriR+7NZ/tr2/Go43B
         iTK4hCoy5JmeQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B1F4940F21; Wed, 30 Jun 2021 14:28:46 -0300 (-03)
Date:   Wed, 30 Jun 2021 14:28:46 -0300
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
Subject: Re: [PATCH v8 11/22] perf record: Document parallel data streaming
 mode
Message-ID: <YNypzhn4FTSxRKIy@kernel.org>
References: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <a23ce4bc4722a276cb49808700867f2ceead7f7b.1625065643.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a23ce4bc4722a276cb49808700867f2ceead7f7b.1625065643.git.alexey.v.bayduraev@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 30, 2021 at 06:54:50PM +0300, Alexey Bayduraev escreveu:
> Document --threads option syntax and parallel data streaming modes
> in Documentation/perf-record.txt. Implement compatibility checks for
> other modes and related command line options: asynchronous(--aio)
> trace streaming and affinity (--affinity) modes, pipe mode, AUX
> area tracing --snapshot and --aux-sample options, --switch-output,
> --switch-output-event, --switch-max-files and --timestamp-filename
> options. Parallel data streaming is compatible with Zstd compression
> (--compression-level) and external control commands (--control).
> Cpu mask provided via -C option filters --threads specification masks.

Please don't separate the documentation of an option from the patch
where it is introduced.

- Arnaldo
 
> Acked-by: Namhyung Kim <namhyung@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-record.txt | 30 +++++++++++++++
>  tools/perf/builtin-record.c              | 49 ++++++++++++++++++++++--
>  2 files changed, 76 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index d71bac847936..2046b28d9822 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -695,6 +695,36 @@ measurements:
>   wait -n ${perf_pid}
>   exit $?
>  
> +--threads=<spec>::
> +Write collected trace data into several data files using parallel threads.
> +<spec> value can be user defined list of masks. Masks separated by colon
> +define cpus to be monitored by a thread and affinity mask of that thread
> +is separated by slash:
> +
> +    <cpus mask 1>/<affinity mask 1>:<cpus mask 2>/<affinity mask 2>:...
> +
> +For example user specification like the following:
> +
> +    0,2-4/2-4:1,5-7/5-7
> +
> +specifies parallel threads layout that consists of two threads,
> +the first thread monitors cpus 0 and 2-4 with the affinity mask 2-4,
> +the second monitors cpus 1 and 5-7 with the affinity mask 5-7.
> +
> +<spec> value can also be a string meaning predefined parallel threads
> +layout:
> +
> +    cpu    - create new data streaming thread for every monitored cpu
> +    core   - create new thread to monitor cpus grouped by a core
> +    socket - create new thread to monitor cpus grouped by a socket
> +    numa   - create new threed to monitor cpus grouped by a numa domain
> +
> +Predefined layouts can be used on systems with large number of cpus in
> +order not to spawn multiple per-cpu streaming threads but still avoid LOST
> +events in data directory files. Option specified with no or empty value
> +defaults to cpu layout. Masks defined or provided by the option value are
> +filtered through the mask provided by -C option.
> +
>  include::intel-hybrid.txt[]
>  
>  SEE ALSO
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 8d452797d175..c5954cb3e787 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -800,6 +800,12 @@ static int record__auxtrace_init(struct record *rec)
>  {
>  	int err;
>  
> +	if ((rec->opts.auxtrace_snapshot_opts || rec->opts.auxtrace_sample_opts)
> +	    && record__threads_enabled(rec)) {
> +		pr_err("AUX area tracing options are not available in parallel streaming mode.\n");
> +		return -EINVAL;
> +	}
> +
>  	if (!rec->itr) {
>  		rec->itr = auxtrace_record__init(rec->evlist, &err);
>  		if (err)
> @@ -2154,6 +2160,17 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		return PTR_ERR(session);
>  	}
>  
> +	if (record__threads_enabled(rec)) {
> +		if (perf_data__is_pipe(&rec->data)) {
> +			pr_err("Parallel trace streaming is not available in pipe mode.\n");
> +			return -1;
> +		}
> +		if (rec->opts.full_auxtrace) {
> +			pr_err("Parallel trace streaming is not available in AUX area tracing mode.\n");
> +			return -1;
> +		}
> +	}
> +
>  	fd = perf_data__fd(data);
>  	rec->session = session;
>  
> @@ -2922,12 +2939,22 @@ static int switch_output_setup(struct record *rec)
>  	 * --switch-output=signal, as we'll send a SIGUSR2 from the side band
>  	 *  thread to its parent.
>  	 */
> -	if (rec->switch_output_event_set)
> +	if (rec->switch_output_event_set) {
> +		if (record__threads_enabled(rec)) {
> +			pr_warning("WARNING: --switch-output-event option is not available in parallel streaming mode.\n");
> +			return 0;
> +		}
>  		goto do_signal;
> +	}
>  
>  	if (!s->set)
>  		return 0;
>  
> +	if (record__threads_enabled(rec)) {
> +		pr_warning("WARNING: --switch-output option is not available in parallel streaming mode.\n");
> +		return 0;
> +	}
> +
>  	if (!strcmp(s->str, "signal")) {
>  do_signal:
>  		s->signal = true;
> @@ -3225,8 +3252,8 @@ static struct option __record_options[] = {
>  		     "Set affinity mask of trace reading thread to NUMA node cpu mask or cpu of processed mmap buffer",
>  		     record__parse_affinity),
>  #ifdef HAVE_ZSTD_SUPPORT
> -	OPT_CALLBACK_OPTARG('z', "compression-level", &record.opts, &comp_level_default,
> -			    "n", "Compressed records using specified level (default: 1 - fastest compression, 22 - greatest compression)",
> +	OPT_CALLBACK_OPTARG('z', "compression-level", &record.opts, &comp_level_default, "n",
> +			    "Compress records using specified level (default: 1 - fastest compression, 22 - greatest compression)",
>  			    record__parse_comp_level),
>  #endif
>  	OPT_CALLBACK(0, "max-size", &record.output_max_size,
> @@ -3659,6 +3686,17 @@ int cmd_record(int argc, const char **argv)
>  	if (rec->opts.kcore || record__threads_enabled(rec))
>  		rec->data.is_dir = true;
>  
> +	if (record__threads_enabled(rec)) {
> +		if (rec->opts.affinity != PERF_AFFINITY_SYS) {
> +			pr_err("--affinity option is mutually exclusive to parallel streaming mode.\n");
> +			goto out_opts;
> +		}
> +		if (record__aio_enabled(rec)) {
> +			pr_err("Asynchronous streaming mode (--aio) is mutually exclusive to parallel streaming mode.\n");
> +			goto out_opts;
> +		}
> +	}
> +
>  	if (rec->opts.comp_level != 0) {
>  		pr_debug("Compression enabled, disabling build id collection at the end of the session.\n");
>  		rec->no_buildid = true;
> @@ -3692,6 +3730,11 @@ int cmd_record(int argc, const char **argv)
>  		}
>  	}
>  
> +	if (rec->timestamp_filename && record__threads_enabled(rec)) {
> +		rec->timestamp_filename = false;
> +		pr_warning("WARNING: --timestamp-filename option is not available in parallel streaming mode.\n");
> +	}
> +
>  	/*
>  	 * Allow aliases to facilitate the lookup of symbols for address
>  	 * filters. Refer to auxtrace_parse_filters().
> -- 
> 2.19.0
> 

-- 

- Arnaldo
