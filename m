Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714BC3479A2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbhCXNbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:31:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235293AbhCXNav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:30:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C72C619B4;
        Wed, 24 Mar 2021 13:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616592649;
        bh=/HMRPn+OqaiQM24UAq5CIRuJJxKj88aA8Bx1x0lE42c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZOCdlTMDxZ3UhwjNF5dz8mP38Gbzfl8e0UWNqkMcj6XV2X5FnW0SjsQ5kTf7Lsnwd
         FLg5hji0wDk8y9DM3gt3RHjJWl0HdunjYqRRfbpDnCkhRUP2zmbhAGgxSH1YLFSo6s
         nbxErQgsziDqh15g9AzSe8r7SNRoHLTQwZBbGo3s5P/nu6nyhUFAcaH+zNg+O1EIbR
         oGeR4HhYwH58K8C4/iAXL/Xbma3VIGOp2Fr49nnO5ZBC1gVpeftl9kXvVTg0FkjM+N
         qaUIKta+BwDrpxETzlfWrfvAxU3D0rG6xT7KYdvjuyv9BPtnMj/vTuqgMlboaEoZCH
         Wah4J+7Mz0P/A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 160E640647; Wed, 24 Mar 2021 10:30:47 -0300 (-03)
Date:   Wed, 24 Mar 2021 10:30:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nicholas Fraser <nfraser@codeweavers.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf data: export to JSON
Message-ID: <YFs/B0/S7IEKeL/Y@kernel.org>
References: <4687bbe5-4ff3-af3a-fcec-06d8bfe5591c@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4687bbe5-4ff3-af3a-fcec-06d8bfe5591c@codeweavers.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 24, 2021 at 09:06:50AM -0400, Nicholas Fraser escreveu:
> This adds preliminary support to dump the contents of a perf.data file to
> human-readable JSON.
> 
> The "perf data" command currently only supports exporting to Common Trace
> Format and it doesn't do symbol resolution among other things. Dumping to JSON
> means the data can be trivially parsed by anything without any dependencies
> (besides a JSON parser.) We use this to import the data into a tool on Windows
> where integrating perf or libbabeltrace is impractical.
> 
> The JSON is encoded using some trivial fprintf() commands; there is no
> dependency on any JSON library. It currently only outputs samples. Other stuff
> like processes and mappings could easily be added as needed. The output is of
> course huge but it compresses well enough.
> 
> Use it like this:
> 
>     perf data convert --to-json out.json

Interesting, see below for some minor stuff while others have the chance
to further review this.

I'm ok with how it is right now, not being that versed into JSON
details.

Do you plan to output the headers too? I think we should, for
completeness.
 
- Arnaldo
 
> Here's what the output looks like:
> 
> {
>         "linux-perf-json-version": 1,
>         "samples": [
>                 {
>                         "timestamp": 3074717308597,
>                         "pid": 8604,
>                         "tid": 8604,
>                         "comm": "sh",
>                         "callchain": [
>                                 {
>                                         "ip": "0x7f1e0deb2d36",
>                                         "symbol": "__strcmp_avx2",
>                                         "dso": "libc-2.33.so"
>                                 },
>                                 {
>                                         "ip": "0x7f1e0dd7f49f",
>                                         "symbol": "__gconv_find_transform",
>                                         "dso": "libc-2.33.so"
>                                 },
>                                 {
>                                         "ip": "0x7f1e0de0b71c",
>                                         "symbol": "__wcsmbs_load_conv",
>                                         "dso": "libc-2.33.so"
>                                 }
>                         ]
>                 },
>                 ...
>         ]
> }
> 
> Signed-off-by: Nicholas Fraser <nfraser@codeweavers.com>
> ---
>  tools/perf/Documentation/perf-data.txt |   5 +-
>  tools/perf/builtin-data.c              |  39 ++++-
>  tools/perf/util/Build                  |   1 +
>  tools/perf/util/data-convert-json.c    | 228 +++++++++++++++++++++++++
>  tools/perf/util/data-convert-json.h    |   9 +
>  tools/perf/util/data-convert.h         |   2 +
>  6 files changed, 276 insertions(+), 8 deletions(-)
>  create mode 100644 tools/perf/util/data-convert-json.c
>  create mode 100644 tools/perf/util/data-convert-json.h
> 
> diff --git a/tools/perf/Documentation/perf-data.txt b/tools/perf/Documentation/perf-data.txt
> index 726b9bc9e1a7..417bf17e265c 100644
> --- a/tools/perf/Documentation/perf-data.txt
> +++ b/tools/perf/Documentation/perf-data.txt
> @@ -17,7 +17,7 @@ Data file related processing.
>  COMMANDS
>  --------
>  convert::
> -	Converts perf data file into another format (only CTF [1] format is support by now).
> +	Converts perf data file into another format.
>  	It's possible to set data-convert debug variable to get debug messages from conversion,
>  	like:
>  	  perf --debug data-convert data convert ...
> @@ -27,6 +27,9 @@ OPTIONS for 'convert'
>  --to-ctf::
>  	Triggers the CTF conversion, specify the path of CTF data directory.
>  
> +--to-json::
> +	Triggers JSON conversion. Specify the JSON filename to output.
> +
>  --tod::
>  	Convert time to wall clock time.
>  
> diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
> index 8d23b8d6ee8e..64546ba517a5 100644
> --- a/tools/perf/builtin-data.c
> +++ b/tools/perf/builtin-data.c
> @@ -8,6 +8,7 @@
>  #include <subcmd/parse-options.h>
>  #include "data-convert.h"
>  #include "data-convert-bt.h"
> +#include "data-convert-json.h"
>  
>  typedef int (*data_cmd_fn_t)(int argc, const char **argv);
>  
> @@ -55,7 +56,8 @@ static const char * const data_convert_usage[] = {
>  
>  static int cmd_data_convert(int argc, const char **argv)
>  {
> -	const char *to_ctf     = NULL;
> +	const char *to_json = NULL;
> +	const char *to_ctf = NULL;
>  	struct perf_data_convert_opts opts = {
>  		.force = false,
>  		.all = false,
> @@ -63,6 +65,7 @@ static int cmd_data_convert(int argc, const char **argv)
>  	const struct option options[] = {
>  		OPT_INCR('v', "verbose", &verbose, "be more verbose"),
>  		OPT_STRING('i', "input", &input_name, "file", "input file name"),
> +		OPT_STRING(0, "to-json", &to_json, NULL, "Convert to JSON format"),
>  #ifdef HAVE_LIBBABELTRACE_SUPPORT
>  		OPT_STRING(0, "to-ctf", &to_ctf, NULL, "Convert to CTF format"),
>  		OPT_BOOLEAN(0, "tod", &opts.tod, "Convert time to wall clock time"),
> @@ -72,11 +75,6 @@ static int cmd_data_convert(int argc, const char **argv)
>  		OPT_END()
>  	};
>  
> -#ifndef HAVE_LIBBABELTRACE_SUPPORT
> -	pr_err("No conversion support compiled in. perf should be compiled with environment variables LIBBABELTRACE=1 and LIBBABELTRACE_DIR=/path/to/libbabeltrace/\n");
> -	return -1;
> -#endif
> -
>  	argc = parse_options(argc, argv, options,
>  			     data_convert_usage, 0);
>  	if (argc) {
> @@ -84,11 +82,38 @@ static int cmd_data_convert(int argc, const char **argv)
>  		return -1;
>  	}
>  
> +	if (to_json && to_ctf) {
> +		pr_err("You cannot specify both --to-ctf and --to-json.\n");
> +		return -1;
> +	}
> +	if (!to_json && !to_ctf) {
> +		pr_err("You must specify one of --to-ctf or --to-json.\n");
> +		return -1;
> +	}
> +
> +	if (to_json) {
> +		if (opts.all) {
> +			pr_err("--all is currently unsupported for JSON output.\n");
> +			return -1;
> +		}
> +		if (opts.tod) {
> +			pr_err("--tod is currently unsupported for JSON output.\n");
> +			return -1;
> +		}
> +		if (opts.force) {
> +			pr_err("--force is currently unsupported for JSON output.\n");
> +			return -1;
> +		}
> +		return bt_convert__perf2json(input_name, to_json, &opts);
> +	}
> +
>  	if (to_ctf) {
>  #ifdef HAVE_LIBBABELTRACE_SUPPORT
>  		return bt_convert__perf2ctf(input_name, to_ctf, &opts);
>  #else
> -		pr_err("The libbabeltrace support is not compiled in.\n");
> +		pr_err("The libbabeltrace support is not compiled in. perf should be "
> +					"compiled with environment variables LIBBABELTRACE=1 and "
> +					"LIBBABELTRACE_DIR=/path/to/libbabeltrace/\n");
>  		return -1;
>  #endif
>  	}
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index e2563d0154eb..de9ac182b25a 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -163,6 +163,7 @@ perf-$(CONFIG_LIBUNWIND_X86)      += libunwind/x86_32.o
>  perf-$(CONFIG_LIBUNWIND_AARCH64)  += libunwind/arm64.o
>  
>  perf-$(CONFIG_LIBBABELTRACE) += data-convert-bt.o
> +perf-y += data-convert-json.o
>  
>  perf-y += scripting-engines/
>  
> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
> new file mode 100644
> index 000000000000..b19674a9f2b8
> --- /dev/null
> +++ b/tools/perf/util/data-convert-json.c
> @@ -0,0 +1,228 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * JSON export.
> + *
> + * Copyright (C) 2021, CodeWeavers Inc. <nfraser@codeweavers.com>
> + */
> +
> +#include "data-convert-json.h"
> +
> +#include <unistd.h>
> +#include <inttypes.h>
> +
> +#include "linux/compiler.h"
> +#include "linux/err.h"
> +#include "util/auxtrace.h"
> +#include "util/debug.h"
> +#include "util/dso.h"
> +#include "util/event.h"
> +#include "util/evsel.h"
> +#include "util/header.h"
> +#include "util/map.h"
> +#include "util/session.h"
> +#include "util/symbol.h"
> +#include "util/thread.h"
> +#include "util/tool.h"
> +
> +struct convert_json {
> +	struct perf_tool tool;
> +	FILE *out;
> +	bool first;
> +};
> +
> +static void output_json_string(FILE *out, const char *s)
> +{
> +	fputc('"', out);
> +	while (*s) {
> +		switch (*s) {
> +
> +		// required escapes with special forms as per RFC 8259
> +		case '"':  fprintf(out, "\\\""); break;
> +		case '\\': fprintf(out, "\\\\"); break;
> +		case '/':  fprintf(out, "\\/");  break;
> +		case '\b': fprintf(out, "\\b");  break;
> +		case '\f': fprintf(out, "\\f");  break;
> +		case '\n': fprintf(out, "\\n");  break;
> +		case '\r': fprintf(out, "\\r");  break;
> +		case '\t': fprintf(out, "\\t");  break;
> +
> +		default:
> +			// all other control characters must be escaped by hex code
> +			if (*s <= 0x1f) {
> +				fprintf(out, "\\u%04x", *s);
> +			} else {
> +				fputc(*s, out);
> +			}
> +			break;
> +		}
> +
> +		++s;
> +	}
> +	fputc('"', out);
> +}
> +
> +static void output_sample_callchain_entry(struct perf_tool *tool,
> +		u64 ip, struct addr_location *al)
> +{
> +	struct convert_json *c = container_of(tool, struct convert_json, tool);
> +	FILE *out = c->out;
> +
> +	fprintf(out, "\n\t\t\t\t{");
> +	fprintf(out, "\n\t\t\t\t\t\"ip\": \"0x%" PRIx64 "\"", ip);
> +
> +	if (al && al->sym && al->sym->name && strlen(al->sym->name) > 0) {
> +		fprintf(out, ",\n\t\t\t\t\t\"symbol\": ");
> +		output_json_string(out, al->sym->name);
> +
> +		if (al->map && al->map->dso) {
> +			const char *dso = al->map->dso->short_name;
> +			if (dso && strlen(dso) > 0) {
> +				fprintf(out, ",\n\t\t\t\t\t\"dso\": ");
> +				output_json_string(out, dso);
> +			}
> +		}
> +	}
> +
> +	fprintf(out, "\n\t\t\t\t}");
> +}
> +
> +static int process_sample_event(struct perf_tool *tool,
> +				union perf_event *event __maybe_unused,
> +				struct perf_sample *sample,
> +				struct evsel *evsel __maybe_unused,
> +				struct machine *machine)
> +{
> +	struct convert_json *c = container_of(tool, struct convert_json, tool);
> +	FILE *out = c->out;
> +	struct addr_location al, tal;
> +	u8 cpumode = PERF_RECORD_MISC_USER;
> +
> +	if (machine__resolve(machine, &al, sample) < 0) {
> +		return 0;
> +	}
> +
> +	if (c->first) {
> +		c->first = false;
> +	} else {
> +		fprintf(out, ",");
> +	}
> +	fprintf(out, "\n\t\t{");
> +
> +	fprintf(out, "\n\t\t\t\"timestamp\": %" PRIi64, sample->time);
> +	fprintf(out, ",\n\t\t\t\"pid\": %i", al.thread->pid_);
> +	fprintf(out, ",\n\t\t\t\"tid\": %i", al.thread->tid);
> +
> +	if (al.thread->cpu >= 0) {
> +		fprintf(out, ",\n\t\t\t\"cpu\": %i", al.thread->cpu);
> +	}
> +
> +	fprintf(out, ",\n\t\t\t\"comm\": ");
> +	output_json_string(out, thread__comm_str(al.thread));
> +
> +	fprintf(out, ",\n\t\t\t\"callchain\": [");
> +	if (sample->callchain) {
> +		unsigned int i;
> +		bool ok;
> +		bool first_callchain = true;
> +
> +		for (i = 0; i < sample->callchain->nr; ++i) {
> +			u64 ip = sample->callchain->ips[i];
> +
> +			if (ip >= PERF_CONTEXT_MAX) {
> +				switch (ip) {
> +				case PERF_CONTEXT_HV:
> +					cpumode = PERF_RECORD_MISC_HYPERVISOR;
> +					break;
> +				case PERF_CONTEXT_KERNEL:
> +					cpumode = PERF_RECORD_MISC_KERNEL;
> +					break;
> +				case PERF_CONTEXT_USER:
> +					cpumode = PERF_RECORD_MISC_USER;
> +					break;
> +				default:
> +					pr_debug("invalid callchain context: "
> +						"%"PRId64"\n", (s64) ip);
> +					break;
> +				}
> +				continue;
> +			}
> +
> +			if (first_callchain) {
> +				first_callchain = false;
> +			} else {
> +				fprintf(out, ",");
> +			}
> +
> +			ok = thread__find_symbol(al.thread, cpumode, ip, &tal);
> +			output_sample_callchain_entry(tool, ip, ok ? &tal : NULL);
> +		}
> +	} else {
> +		output_sample_callchain_entry(tool, sample->ip, &al);
> +	}
> +	fprintf(out, "\n\t\t\t]");
> +
> +	fprintf(out, "\n\t\t}");
> +	return 0;
> +}
> +
> +int bt_convert__perf2json(const char *input_name, const char *output_name,
> +			 struct perf_data_convert_opts *opts __maybe_unused)
> +{
> +	struct perf_session *session;
> +
> +	struct convert_json c = {
> +		.tool = {
> +			.sample = process_sample_event,
> +			.mmap = perf_event__process_mmap,
> +			.mmap2 = perf_event__process_mmap2,
> +			.comm = perf_event__process_comm,
> +			.namespaces = perf_event__process_namespaces,
> +			.cgroup = perf_event__process_cgroup,
> +			.exit = perf_event__process_exit,
> +			.fork = perf_event__process_fork,
> +			.lost = perf_event__process_lost,
> +			.tracing_data = perf_event__process_tracing_data,
> +			.build_id = perf_event__process_build_id,
> +			.id_index = perf_event__process_id_index,
> +			.auxtrace_info = perf_event__process_auxtrace_info,
> +			.auxtrace = perf_event__process_auxtrace,
> +			.event_update = perf_event__process_event_update,
> +			.ordered_events = true,
> +			.ordering_requires_timestamps = true,
> +		},

Please align it as in other tools:

	struct convert_json c = {
		.tool = {
			.sample		= process_sample_event,
			.mmap		= perf_event__process_mmap,
			.mmap2		= perf_event__process_mmap2,
			.comm		= perf_event__process_comm,
			.namespaces	= perf_event__process_namespaces,
			.cgroup		= perf_event__process_cgroup,
			.exit		= perf_event__process_exit,
			.fork		= perf_event__process_fork,
			.lost		= perf_event__process_lost,
			.tracing_data	= perf_event__process_tracing_data,
			.build_id	= perf_event__process_build_id,
			.id_index	= perf_event__process_id_index,
			.auxtrace_info	= perf_event__process_auxtrace_info,
			.auxtrace	= perf_event__process_auxtrace,
			.event_update	= perf_event__process_event_update,
			.ordered_events	= true,
			.ordering_requires_timestamps = true,
		},

> +		.first = true,
> +	};
> +
> +	struct perf_data data = {
> +		.mode = PERF_DATA_MODE_READ,
> +		.path = input_name,
> +	};
> +
> +	c.out = fopen(output_name, "w");
> +	if (!c.out) {
> +		fprintf(stderr, "error opening output file!\n");
> +		return -1;
> +	}
> +
> +	session = perf_session__new(&data, false, &c.tool);
> +	if (IS_ERR(session)) {
> +		fprintf(stderr, "error creating perf session!\n");
> +		return -1;
> +	}
> +
> +	if (symbol__init(&session->header.env) < 0) {
> +		fprintf(stderr, "symbol init error!\n");
> +		return -1;
> +	}
> +
> +	// Version number for future-proofing. Most additions should be able to be
> +	// done in a backwards-compatible way so this should only need to be bumped
> +	// if some major breaking change must be made.
> +	fprintf(c.out, "{\n\t\"linux-perf-json-version\": 1,");
> +
> +	fprintf(c.out, "\n\t\"samples\": [");
> +	perf_session__process_events(session);
> +	fprintf(c.out, "\n\t]\n}\n");
> +
> +	return 0;
> +}
> diff --git a/tools/perf/util/data-convert-json.h b/tools/perf/util/data-convert-json.h
> new file mode 100644
> index 000000000000..1fcac5ce3ec1
> --- /dev/null
> +++ b/tools/perf/util/data-convert-json.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __DATA_CONVERT_JSON_H
> +#define __DATA_CONVERT_JSON_H
> +#include "data-convert.h"
> +
> +int bt_convert__perf2json(const char *input_name, const char *to_ctf,
> +			 struct perf_data_convert_opts *opts);
> +
> +#endif /* __DATA_CONVERT_JSON_H */
> diff --git a/tools/perf/util/data-convert.h b/tools/perf/util/data-convert.h
> index feab5f114e37..17c35eb6ab4f 100644
> --- a/tools/perf/util/data-convert.h
> +++ b/tools/perf/util/data-convert.h
> @@ -2,6 +2,8 @@
>  #ifndef __DATA_CONVERT_H
>  #define __DATA_CONVERT_H
>  
> +#include <stdbool.h>
> +
>  struct perf_data_convert_opts {
>  	bool force;
>  	bool all;
> -- 
> 2.31.0
> 
> 

-- 

- Arnaldo
