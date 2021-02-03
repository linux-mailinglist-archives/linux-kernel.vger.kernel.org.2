Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481AC30E46F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhBCU5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 15:57:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:33620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232348AbhBCU5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 15:57:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5301A64E31;
        Wed,  3 Feb 2021 20:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612385825;
        bh=Wu12I4N7mIy7m1ikuqiMinMBQAJwfsPwBvLF/fnkyyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E8oLjjQQITijbMJWteschXoVcKpMqk+PD6wHNawoQMd8qavAi0Fvb3wdTabdVpniR
         ofGthgS/EneK1vwV9487FONs9oluH0cDd8yQmGUbsthvRizKNinTyvhIqixHlHFgO3
         iEe0IT1uD56zcjNhmjse5WZZU+fqirYXS1WI/zk4dLH11qyYxKXM44BZg38hE5k/T1
         0TTxAJ9YE/enprCIhRE7wMEuRNid3fdQmWKUvt1BeGxsEyIIA08+N7n1x2du+ZBA6a
         FkK52l+GaihHW46v0BGXL31kwHT7q65P53DpWt4TuTk4FAZVNDEkr26ZJwEA+BKakr
         7QBtRIZUyIHeg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E721F40513; Wed,  3 Feb 2021 17:57:02 -0300 (-03)
Date:   Wed, 3 Feb 2021 17:57:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 02/24] perf daemon: Add config option
Message-ID: <20210203205702.GO854763@kernel.org>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130234856.271282-3-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jan 31, 2021 at 12:48:34AM +0100, Jiri Olsa escreveu:
> Adding config option and base functionality that takes the option
> argument (if specified) and other system config locations and
> produces 'acting' config file path.
> 
> The actual config file processing is coming in following patches.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-daemon.c | 49 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)

Missing update to tools/perf/Documentation/perf-daemon.txt for  --config
 
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index 8b13e455ac40..1f2393faad75 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -3,14 +3,18 @@
>  #include <linux/limits.h>
>  #include <string.h>
>  #include <signal.h>
> +#include <stdlib.h>
>  #include <stdio.h>
>  #include <unistd.h>
>  #include "builtin.h"
>  #include "perf.h"
>  #include "debug.h"
> +#include "config.h"
>  #include "util.h"
>  
>  struct daemon {
> +	const char		*config;
> +	char			*config_real;
>  	char			*base;
>  	FILE			*out;
>  	char			 perf[PATH_MAX];
> @@ -31,6 +35,37 @@ static void sig_handler(int sig __maybe_unused)
>  	done = true;
>  }
>  
> +static void daemon__free(struct daemon *daemon)
> +{
> +	free(daemon->config_real);
> +}
> +
> +static void daemon__exit(struct daemon *daemon)
> +{
> +	daemon__free(daemon);
> +}
> +
> +static int setup_config(struct daemon *daemon)
> +{
> +	if (daemon->config) {
> +		char *real = realpath(daemon->config, NULL);
> +
> +		if (!real) {
> +			perror("failed: realpath");
> +			return -1;
> +		}
> +		daemon->config_real = real;
> +		return 0;
> +	}
> +
> +	if (perf_config_system() && !access(perf_etc_perfconfig(), R_OK))
> +		daemon->config_real = strdup(perf_etc_perfconfig());
> +	else if (perf_config_global() && perf_home_perfconfig())
> +		daemon->config_real = strdup(perf_home_perfconfig());
> +
> +	return daemon->config_real ? 0 : -1;
> +}
> +
>  static int __cmd_start(struct daemon *daemon, struct option parent_options[],
>  		       int argc, const char **argv)
>  {
> @@ -44,6 +79,11 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
>  	if (argc)
>  		usage_with_options(daemon_usage, start_options);
>  
> +	if (setup_config(daemon)) {
> +		pr_err("failed: config not found\n");
> +		return -1;
> +	}
> +
>  	debug_set_file(daemon->out);
>  	debug_set_display_time(true);
>  
> @@ -56,6 +96,8 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
>  		sleep(1);
>  	}
>  
> +	daemon__exit(daemon);
> +
>  	pr_info("daemon exited\n");
>  	fclose(daemon->out);
>  	return err;
> @@ -65,6 +107,8 @@ int cmd_daemon(int argc, const char **argv)
>  {
>  	struct option daemon_options[] = {
>  		OPT_INCR('v', "verbose", &verbose, "be more verbose"),
> +		OPT_STRING(0, "config", &__daemon.config,
> +			"config file", "config file path"),
>  		OPT_END()
>  	};
>  
> @@ -82,5 +126,10 @@ int cmd_daemon(int argc, const char **argv)
>  		return -1;
>  	}
>  
> +	if (setup_config(&__daemon)) {
> +		pr_err("failed: config not found\n");
> +		return -1;
> +	}
> +
>  	return -1;
>  }
> -- 
> 2.29.2
> 

-- 

- Arnaldo
