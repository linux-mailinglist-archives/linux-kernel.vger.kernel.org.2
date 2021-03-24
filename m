Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68A5348059
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbhCXSVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:21:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50492 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237480AbhCXSUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616610050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XqA9gdWkp/GZQ9mJ/2vsxrdD0nxwp+BKmpZyB20zRHU=;
        b=NlPb8oWBXHcan2HidCOJiDzObdV1vDvF717iu3J+bV9zkTY7G19C8cDXN1UVrdQ60KYLE5
        f13oh3BrqSBrrVbm2ynUgyURODmKfJ5VGRWj5paHOMNEB1wRDuk74ZZxkk9+elmi9B+7vk
        Jdbqom85+QutNo3bbVlAVgToz7XuH3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-GRDg9bKfMsCQbgdlmamypw-1; Wed, 24 Mar 2021 14:20:47 -0400
X-MC-Unique: GRDg9bKfMsCQbgdlmamypw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 467C8190681C;
        Wed, 24 Mar 2021 18:20:24 +0000 (UTC)
Received: from krava (unknown [10.40.196.25])
        by smtp.corp.redhat.com (Postfix) with SMTP id CAAFC5D9CA;
        Wed, 24 Mar 2021 18:20:21 +0000 (UTC)
Date:   Wed, 24 Mar 2021 19:20:20 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Nicholas Fraser <nfraser@codeweavers.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf data: export to JSON
Message-ID: <YFuC5ONRvAPKwtKX@krava>
References: <4687bbe5-4ff3-af3a-fcec-06d8bfe5591c@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4687bbe5-4ff3-af3a-fcec-06d8bfe5591c@codeweavers.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 09:06:50AM -0400, Nicholas Fraser wrote:
> This adds preliminary support to dump the contents of a perf.data file to
> human-readable JSON.
> 
> The "perf data" command currently only supports exporting to Common Trace
> Format and it doesn't do symbol resolution among other things. Dumping to JSON
> means the data can be trivially parsed by anything without any dependencies
> (besides a JSON parser.) We use this to import the data into a tool on Windows
> where integrating perf or libbabeltrace is impractical.

hi,
exciting ;-) and curious, which tool is that?

> 
> The JSON is encoded using some trivial fprintf() commands; there is no
> dependency on any JSON library. It currently only outputs samples. Other stuff
> like processes and mappings could easily be added as needed. The output is of
> course huge but it compresses well enough.

we already have zstd support compiled in for compressing samples,
should be easy to use it for compressing the output of this right
away

SNIP

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

condition below should be under bt_convert__perf2json

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

I understand not supporting opts.all or opts.tod, but 'force'
support means just assigning 'force' to struct perf_data

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

please indent above 2 lines under the "The..." start

SNIP

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

you should fail in here

> +	}
> +
> +	if (c->first) {
> +		c->first = false;
> +	} else {
> +		fprintf(out, ",");
> +	}

no need for curlies {} if there's just one line code under condition

SNIP

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

you should close session with perf_session__delete

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

I don't remember why we added util/data-convert-bt.h, but it does not
make sense to me now.. I think both these declarations should be in
util/data-convert.h

it can be done as follow up on top of this change

thanks,
jirka


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

