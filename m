Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37345460726
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 16:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358167AbhK1Pj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 10:39:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60581 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358060AbhK1Ph2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 10:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638113652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VNpPAkWiidfifefiXJODArZxI0qvSofN4bgHmwfU3Oo=;
        b=Swx1BJB82kS/Uze4oZ6xgSG8gWHB+/jBeaxD4Nvegz0ZKRKs4olqHrCVbWMgafPJyNpkOM
        EPf4jf2XNb4Uk06cLdLaqUJuFGki+LChkPhQhcMuB6o+RicZYZgzS59Rd4m0WWLgiGi3AK
        YVfinz5GWp0K9+uz9Vf+n0UKEgnMveQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-s1JcYG7WPq2SURK_a1wygw-1; Sun, 28 Nov 2021 10:34:09 -0500
X-MC-Unique: s1JcYG7WPq2SURK_a1wygw-1
Received: by mail-wm1-f70.google.com with SMTP id m14-20020a05600c3b0e00b0033308dcc933so8959726wms.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 07:34:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VNpPAkWiidfifefiXJODArZxI0qvSofN4bgHmwfU3Oo=;
        b=uY9VURt2nG8YWCVm2K1O8Ki4t+9QBJf87L2y7A5x7UNsnYAqZHNTvsJm680RpTzEBd
         +aV3f0kErElebk3Gd/lgyMMLWrXIKs55ILCS4yZl7EobiniJgSIPhSaq0bMw+kNrU2d+
         Ckx2xT9JzVUfW0PhVz8u7Dly7K7vxK0R4BIKzJ0CaHSPnnd/AYIL/KtwG/RCVu2mEjLB
         0a5pY1qaHB9v+beelywteqXQnGNszPRqI2nR7jsRhg9G87pivMHVdiyLOhAyWlligZmc
         ZEq8s2BEz46CdezedE2ELqhHREtRjY7Ktc4D/drEFKe2WMXEHSq7rASsJ8iND1hQcTFN
         rRKg==
X-Gm-Message-State: AOAM530KuR7Oeo0GTGMozT3RzT9688yOn1YV6kR7N19ZotzOAMhJ081z
        zIKkfHZVAcboCCSJ7Ew0TNLPMNM0MqrLWBaf9zamHve0TTCc3ISBAyGfMaFO7F09/T6m1QUd7wQ
        G1fOBc36QikuELytI4xa36VaL
X-Received: by 2002:a5d:570b:: with SMTP id a11mr27540299wrv.600.1638113647967;
        Sun, 28 Nov 2021 07:34:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKAI+uCDhKCXKciMPZW3z9b+FqtdLLvtiubB0T9Btutrr4JEImS5bnFpxct/cLy1nlCgwqQA==
X-Received: by 2002:a5d:570b:: with SMTP id a11mr27540271wrv.600.1638113647746;
        Sun, 28 Nov 2021 07:34:07 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id d6sm11115711wrx.60.2021.11.28.07.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 07:34:07 -0800 (PST)
Date:   Sun, 28 Nov 2021 16:34:05 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     irogers@google.com, Riccardo Mancini <rickyman7@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fabian Hemmer <copy@copy.sh>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Unbuffered output when pipe/tee to a file
Message-ID: <YaOhbfWzMv/uvKKi@krava>
References: <20211119061409.78004-1-sohaib.amhmd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119061409.78004-1-sohaib.amhmd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 08:14:08AM +0200, Sohaib Mohamed wrote:
> The output of Perf bench gets buffered when I pipe it to a file or to
> tee, in such a way that I can see it only at the end.
> 
> E.g.
> $ perf bench internals synthesize -t
> < output comes out fine after each test run >
> 
> $ perf bench internals synthesize -t | tee file.txt
> < output comes out only at the end of all tests >
> 
> This patch resolves this issue for 'bench' and 'test' subcommands.

I can reproduce this for bench, but not for test subcommand
other that that it makes sense to me

jirka

> 
> See, also:
> $ perf bench mem all | tee file.txt
> $ perf bench sched all | tee file.txt
> $ perf bench internals all -t | tee file.txt
> $ perf bench internals all | tee file.txt
> 
> Suggested-by: Riccardo Mancini <rickyman7@gmail.com>
> Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
> ---
> v1 -> v2:
> - Use setvbuf(), instead of sprinkling fflush() calls and missing some places.
> 
> v1: https://lore.kernel.org/linux-perf-users/20211112215313.108823-1-sohaib.amhmd@gmail.com/
> ---
>  tools/perf/builtin-bench.c      | 5 +++--
>  tools/perf/tests/builtin-test.c | 3 +++
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
> index d0895162c2ba..d291f3a8af5f 100644
> --- a/tools/perf/builtin-bench.c
> +++ b/tools/perf/builtin-bench.c
> @@ -226,7 +226,6 @@ static void run_collection(struct collection *coll)
>  		if (!bench->fn)
>  			break;
>  		printf("# Running %s/%s benchmark...\n", coll->name, bench->name);
> -		fflush(stdout);
> 
>  		argv[1] = bench->name;
>  		run_bench(coll->name, bench->name, bench->fn, 1, argv);
> @@ -247,6 +246,9 @@ int cmd_bench(int argc, const char **argv)
>  	struct collection *coll;
>  	int ret = 0;
> 
> +	/* Unbuffered output */
> +	setvbuf(stdout, NULL, _IONBF, 0);
> +
>  	if (argc < 2) {
>  		/* No collection specified. */
>  		print_usage();
> @@ -300,7 +302,6 @@ int cmd_bench(int argc, const char **argv)
> 
>  			if (bench_format == BENCH_FORMAT_DEFAULT)
>  				printf("# Running '%s/%s' benchmark:\n", coll->name, bench->name);
> -			fflush(stdout);
>  			ret = run_bench(coll->name, bench->name, bench->fn, argc-1, argv+1);
>  			goto end;
>  		}
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 8cb5a1c3489e..d92ae4efd2e6 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -606,6 +606,9 @@ int cmd_test(int argc, const char **argv)
>          if (ret < 0)
>                  return ret;
> 
> +	/* Unbuffered output */
> +	setvbuf(stdout, NULL, _IONBF, 0);
> +
>  	argc = parse_options_subcommand(argc, argv, test_options, test_subcommands, test_usage, 0);
>  	if (argc >= 1 && !strcmp(argv[0], "list"))
>  		return perf_test__list(argc - 1, argv + 1);
> --
> 2.25.1
> 

