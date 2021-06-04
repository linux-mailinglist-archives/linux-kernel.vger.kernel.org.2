Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51CA39C051
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 21:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhFDTUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 15:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbhFDTUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 15:20:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51E75613F9;
        Fri,  4 Jun 2021 19:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622834329;
        bh=EtZnRJxJS2Fm/0j2Ac/yrQck1AAkNfPWAOHSdC554ZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r7Hg6YxT/J8vrsp9BfXrATr2iQesU8vFWEj2y/vBdW16CtE2hKfQJSxp3aVeGXmNP
         qdBDBEFOrYNJ82h+BMIj9JWTv+RaUaPoQJRe5HgJHm8UnIfNvo0pmt/Mz9twM/P3Dz
         uDEDsQTFHEQMI4/r7tgR3hu0A1Q2keFvGE13tpZPlIMNncS2n2OADLo/IXrTsuQETN
         BEVBfmwdy27o60xf6LRDXXiD0VcknzAp+DUWtZtkLkdbiUsS96q478SNiOw8flVZc/
         Lv9TVajV0OT2DmMTDIcqolpY6Xps/iMSHHmds+SEuOEURZnrL3006ZvPl6rYuX6q7p
         enkLMonjhy41g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 68A0240EFC; Fri,  4 Jun 2021 16:18:47 -0300 (-03)
Date:   Fri, 4 Jun 2021 16:18:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/2] perf/probe: Report possible permission error for
 map__load failure
Message-ID: <YLp8lxoSPmUtQUra@kernel.org>
References: <162282064848.448336.15589262399731095367.stgit@devnote2>
 <162282065877.448336.10047912688119745151.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162282065877.448336.10047912688119745151.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jun 05, 2021 at 12:30:58AM +0900, Masami Hiramatsu escreveu:
> Report possible permission error including kptr_restrict setting
> for map__load() failure. This can happen when non-superuser runs
> perf probe.
> 
> With this patch, perf probe shows the following message.
> 
>  $ perf probe vfs_read
>  Failed to load symbols from /proc/kallsyms
>  Please ensure you can read the /proc/kallsyms symbol addresses.
>  If the /proc/sys/kernel/kptr_restrict is '2', you can not read
>  kernel symbol address even if you are a superuser. Please change
>  it to '1'. If kptr_restrict is '1', the superuser can read the
>  symbol addresses.
>  In that case, please run this command again with sudo.
>    Error: Failed to add events.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/perf/util/probe-event.c |   25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 3a7649835ec9..8fe179d671c3 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2936,7 +2936,7 @@ static int find_probe_functions(struct map *map, char *name,
>  	bool cut_version = true;
>  
>  	if (map__load(map) < 0)
> -		return 0;
> +		return -EACCES;	/* Possible permission error to load symbols */
>  
>  	/* If user gives a version, don't cut off the version from symbols */
>  	if (strchr(name, '@'))
> @@ -2975,6 +2975,17 @@ void __weak arch__fix_tev_from_maps(struct perf_probe_event *pev __maybe_unused,
>  				struct map *map __maybe_unused,
>  				struct symbol *sym __maybe_unused) { }
>  
> +
> +static void pr_kallsyms_access_error(void)
> +{
> +	pr_err("Please ensure you can read the /proc/kallsyms symbol addresses.\n"
> +	       "If the /proc/sys/kernel/kptr_restrict is '2', you can not read\n"
> +	       "kernel symbol address even if you are a superuser. Please change\n"
> +	       "it to '1'. If kptr_restrict is '1', the superuser can read the\n"
> +	       "symbol addresses.\n"
> +	       "In that case, please run this command again with sudo.\n");
> +}
> +
>  /*
>   * Find probe function addresses from map.
>   * Return an error or the number of found probe_trace_event
> @@ -3011,8 +3022,16 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
>  	 */
>  	num_matched_functions = find_probe_functions(map, pp->function, syms);
>  	if (num_matched_functions <= 0) {
> -		pr_err("Failed to find symbol %s in %s\n", pp->function,
> -			pev->target ? : "kernel");
> +		if (num_matched_functions == -EACCES) {
> +			pr_err("Failed to load symbols from %s\n",
> +			       pev->target ?: "/proc/kallsyms");
> +			if (pev->target)
> +				pr_err("Please ensure the file is not stripped.\n");
> +			else
> +				pr_kallsyms_access_error();
> +		} else
> +			pr_err("Failed to find symbol %s in %s\n", pp->function,
> +				pev->target ? : "kernel");
>  		ret = -ENOENT;
>  		goto out;
>  	} else if (num_matched_functions > probe_conf.max_probes) {
> 

-- 

- Arnaldo
