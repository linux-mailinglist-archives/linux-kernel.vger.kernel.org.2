Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D61030E473
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 21:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhBCU6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 15:58:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232311AbhBCU6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 15:58:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C37C64F72;
        Wed,  3 Feb 2021 20:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612385840;
        bh=wHYolCFwrPjIfJng82ybYS2z6yvPzx56ne2rU4LE/VY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E9sSM0fOxFH8eHxoaLL9AT4clTus17JXwgCnOcdj6Sp3PkE3LhVZlyn7+vX86o3GA
         wwQ2N4RG+A3n5y86OkXcfOSbWMg//ZoZzQpg1MtsaqWfS3RgezDnjqvEBtybysumNr
         T7vULbJ5PZa4z66KeVUdzjlHqBEbtrYwGO66ZGAdPYPoOP/VMaUILAkgR5RTRvfTxK
         diNnbhjl8lc4VuJTCb28+A7glu8dTX9tqMjmVSC8zE8DXIYMA++s2G/WW1nHjSaj1F
         J0Fkh+R3dLK2E0yK1TXStdqQpnXZxtg2TJTW5oqTUcxs60c6PD5s3T2JCwGUzkcEeB
         JKcPRLFH/WuSg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E641A40513; Wed,  3 Feb 2021 17:57:17 -0300 (-03)
Date:   Wed, 3 Feb 2021 17:57:17 -0300
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
Subject: Re: [PATCH 03/24] perf daemon: Add base option
Message-ID: <20210203205717.GP854763@kernel.org>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130234856.271282-4-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jan 31, 2021 at 12:48:35AM +0100, Jiri Olsa escreveu:
> Adding base option allowing user to specify base directory.
> It will have precedence over config file base definition
> coming in following patches.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-daemon.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Missing doc update
 
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index 1f2393faad75..8d0ac44ec808 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -6,6 +6,7 @@
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <unistd.h>
> +#include <errno.h>
>  #include "builtin.h"
>  #include "perf.h"
>  #include "debug.h"
> @@ -15,6 +16,7 @@
>  struct daemon {
>  	const char		*config;
>  	char			*config_real;
> +	const char		*base_user;
>  	char			*base;
>  	FILE			*out;
>  	char			 perf[PATH_MAX];
> @@ -38,6 +40,7 @@ static void sig_handler(int sig __maybe_unused)
>  static void daemon__free(struct daemon *daemon)
>  {
>  	free(daemon->config_real);
> +	free(daemon->base);
>  }
>  
>  static void daemon__exit(struct daemon *daemon)
> @@ -47,6 +50,12 @@ static void daemon__exit(struct daemon *daemon)
>  
>  static int setup_config(struct daemon *daemon)
>  {
> +	if (daemon->base_user) {
> +		daemon->base = strdup(daemon->base_user);
> +		if (!daemon->base)
> +			return -ENOMEM;
> +	}
> +
>  	if (daemon->config) {
>  		char *real = realpath(daemon->config, NULL);
>  
> @@ -109,6 +118,8 @@ int cmd_daemon(int argc, const char **argv)
>  		OPT_INCR('v', "verbose", &verbose, "be more verbose"),
>  		OPT_STRING(0, "config", &__daemon.config,
>  			"config file", "config file path"),
> +		OPT_STRING(0, "base", &__daemon.base_user,
> +			"directory", "base directory"),
>  		OPT_END()
>  	};
>  
> -- 
> 2.29.2
> 

-- 

- Arnaldo
