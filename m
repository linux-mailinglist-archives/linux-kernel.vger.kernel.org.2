Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022E6351E7C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241084AbhDASmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59266 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237363AbhDASTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617301152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hgwYknKSgdPGWp+Ftlm12JcG0t+YnhQzWt1SjCg5dbg=;
        b=DnuDKztCAIT0etoMf5IAd4KIwjwg3pqaXKRmbz63xQx50ejoww323zfrzR0vV8XrfGsbrT
        L1pRq7ilivZTdUOd/gjvhewzY2mXsc2dN16eiUcTeIauxsnX2+ECFeF69x1uvhV3WpJSjr
        GpxLLRt8EtXRDLWlC39gjQ0ne+kG3Y0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-aBCEfiLjOj6vi-DfAea4hg-1; Thu, 01 Apr 2021 09:18:10 -0400
X-MC-Unique: aBCEfiLjOj6vi-DfAea4hg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E17A787A83E;
        Thu,  1 Apr 2021 13:18:07 +0000 (UTC)
Received: from krava (unknown [10.40.193.98])
        by smtp.corp.redhat.com (Postfix) with SMTP id 500DC51DCB;
        Thu,  1 Apr 2021 13:18:05 +0000 (UTC)
Date:   Thu, 1 Apr 2021 15:18:04 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Nicholas Fraser <nfraser@codeweavers.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf data: Add JSON export
Message-ID: <YGXIDGfCLVtFuxgT@krava>
References: <c4d0b0f1-79f4-f08d-3d7e-00046120f845@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4d0b0f1-79f4-f08d-3d7e-00046120f845@codeweavers.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 06:42:48AM -0400, Nicholas Fraser wrote:
> From ddcfd620e7cad4100d0076090c4b39dba8aeead3 Mon Sep 17 00:00:00 2001
> From: Nicholas Fraser <nfraser@codeweavers.com>
> Date: Wed, 31 Mar 2021 06:10:00 -0400
> Subject: [PATCH] perf data: Add JSON export

no need to add headers again in here

> 
> This adds a feature to export perf data to JSON. It uses a minimal
> inline JSON encoding, no external dependencies. Currently it only
> outputs some headers and sample metadata but it's easily extensible.
> 
> Use it like this:
> 
>     perf data convert --to-json out.json

please add similar output summary message we have for CTF conversion:

	[ perf data convert: Converted 'perf.data' into CTF data 'data' ]
	[ perf data convert: Converted and wrote 0.000 MB (10 samples) ]

also I will not push hard for test, becase we don't have any for CTF ;-)
but if you could think of any, that'd be great

> +
> +static void output_headers(struct perf_session *session, struct convert_json *c)
> +{
> +	struct stat st;
> +	struct perf_header *header = &session->header;
> +	int ret;
> +	int fd = perf_data__fd(session->data);
> +	int i;
> +	bool first;
> +
> +	fprintf(c->out, "\n\t\t\t\"header-version\": %u", header->version);
> +
> +	ret = fstat(fd, &st);
> +	if (ret >= 0) {
> +		time_t stctime = st.st_mtime;
> +		char buf[256];
> +
> +		strftime(buf, sizeof(buf), "%FT%TZ", gmtime(&stctime));
> +		fprintf(c->out, ",\n\t\t\t\"captured-on\": \"%s\"", buf);
> +	} else {
> +		pr_debug("Failed to get mtime of source file, not writing \"captured-on\"");
> +	}
> +
> +	fprintf(c->out, ",\n\t\t\t\"data-offset\": %" PRIu64, header->data_offset);
> +	fprintf(c->out, ",\n\t\t\t\"data-size\": %" PRIu64, header->data_size);
> +	fprintf(c->out, ",\n\t\t\t\"feat-offset\": %" PRIu64, header->feat_offset);

I was wondering how to make this \t mess more readable,
how about you define function like output_json:

	output_json(FILE, level, field, format, ...);

and use it:

	output_json(c->out, 3, "data-offset", "PRIu64", header->data_offset);
	output_json(c->out, 3, "data-size", "PRIu64", header->data_size);
	output_json(c->out, 3, "feat-offset", PRIu64, header->feat_offset);

similar way as we do for pr_debug -> eprintf

SNIP

> +
> +	fd = open(output_name, O_CREAT | O_WRONLY | (opts->force ? 0 : O_EXCL), 0666);
> +	if (fd == -1) {
> +		if (errno == EEXIST)
> +			pr_err("Output file exists. Use --force to overwrite it.\n");
> +		else
> +			pr_err("Error opening output file!\n");
> +		return -1;
> +	}
> +
> +	c.out = fdopen(fd, "w");
> +	if (!c.out) {
> +		fprintf(stderr, "Error opening output file!\n");
> +		return -1;
> +	}
> +
> +	session = perf_session__new(&data, false, &c.tool);
> +	if (IS_ERR(session)) {
> +		fprintf(stderr, "Error creating perf session!\n");
> +		return -1;

here we should close c.out and call perf_session__delete,
we normaly do goto to the end of the function in this case

> +	}
> +
> +	if (symbol__init(&session->header.env) < 0) {
> +		fprintf(stderr, "Symbol init error!\n");
> +		return -1;
> +	}
> +
> +	// Version number for future-proofing. Most additions should be able to be
> +	// done in a backwards-compatible way so this should only need to be bumped
> +	// if some major breaking change must be made.
> +	fprintf(c.out, "{\n\t\"linux-perf-json-version\": 1,");
> +
> +	// Output headers
> +	fprintf(c.out, "\n\t\"headers\": {");
> +	output_headers(session, &c);
> +	fprintf(c.out, "\n\t},");
> +
> +	// Output samples
> +	fprintf(c.out, "\n\t\"samples\": [");
> +	perf_session__process_events(session);
> +	fprintf(c.out, "\n\t]\n}\n");
> +

you need to close c.out

> +	perf_session__delete(session);
> +	return 0;
> +}
> diff --git a/tools/perf/util/data-convert.h b/tools/perf/util/data-convert.h
> index feab5f114e37..1b4c5f598415 100644
> --- a/tools/perf/util/data-convert.h
> +++ b/tools/perf/util/data-convert.h
> @@ -2,10 +2,20 @@
>  #ifndef __DATA_CONVERT_H
>  #define __DATA_CONVERT_H
>  
> +#include <stdbool.h>
> +
>  struct perf_data_convert_opts {
>  	bool force;
>  	bool all;
>  	bool tod;
>  };
>  
> +#ifdef HAVE_LIBBABELTRACE_SUPPORT
> +int bt_convert__perf2ctf(const char *input_name, const char *to_ctf,
> +			 struct perf_data_convert_opts *opts);
> +#endif /* HAVE_LIBBABELTRACE_SUPPORT */
> +
> +int bt_convert__perf2json(const char *input_name, const char *to_ctf,
> +			 struct perf_data_convert_opts *opts);
> +
>  #endif /* __DATA_CONVERT_H */

great, thanks for this
jirka

