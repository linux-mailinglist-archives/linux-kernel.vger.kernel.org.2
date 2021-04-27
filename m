Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA17E36CB9F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 21:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbhD0T2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 15:28:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235563AbhD0T2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 15:28:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4899613F6;
        Tue, 27 Apr 2021 19:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619551645;
        bh=zODLgaHDmvG4j+p01pswoad3NugaCPrLy4HTzlU8D54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tPdHSJYUrzZXRrBNAweKWhOs+1WcH0Cz8K9syNgDU//9YMirmPLIzn9wO79ETLGhN
         l04LK/nWw1h3R77uBQ7Q/p6x8oGxTeN9RaFh+sSHMGF//W/b+lwkI78f9hh+nhAhpm
         g+TQz4vvjfaqpYCM5YK09+Mu2oT6CEyiJ7KzFNvgKPbCT7hUFM70PMzuOBF2nhHtIk
         fzFw97FuoNbF9ugfEpPh0OPYv8F04SPJrs2XowMoD5MT/BtzKMN7inFRSYnjDPXY9p
         qWUgvXcLW2gpZo/9GhYnD8sh0oL0JtCRGe8xsP5lU8MD0WobYP3j8hhBZ+Fd9ZtBGr
         U7ljp30XIq23A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4B59C40647; Tue, 27 Apr 2021 16:27:22 -0300 (-03)
Date:   Tue, 27 Apr 2021 16:27:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, acme@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org, songliubraving@fb.com
Subject: Re: [PATCH v5 5/5] perf-stat: introduce bpf_counter_ops->disable()
Message-ID: <YIhlmhyBPxTOZRZa@kernel.org>
References: <20210425214333.1090950-1-song@kernel.org>
 <20210425214333.1090950-6-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210425214333.1090950-6-song@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Apr 25, 2021 at 02:43:33PM -0700, Song Liu escreveu:
> Introduce bpf_counter_ops->disable(), which is used stop counting the
> event.

[acme@five perf]$ perf test -v python
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
19: 'import perf' in python                                         :
--- start ---
test child forked, pid 1497924
python usage test: "echo "import sys ; sys.path.append('/tmp/build/perf/python'); import perf" | '/usr/bin/python3' "
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ImportError: /tmp/build/perf/python/perf.cpython-39-x86_64-linux-gnu.so: undefined symbol: bpf_counter__disable
test child finished with -1
---- end ----
'import perf' in python: FAILED!
[acme@five perf]$

I'll fix this up in my local tree, if you need to respin, please pick
patches from tmp.perf/core, will refresh it later today.

- Arnaldo
 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  tools/perf/util/bpf_counter.c | 26 ++++++++++++++++++++++++++
>  tools/perf/util/bpf_counter.h |  7 +++++++
>  tools/perf/util/evlist.c      |  4 ++++
>  3 files changed, 37 insertions(+)
> 
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index f179f57430253..ddb52f748c8e8 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -215,6 +215,17 @@ static int bpf_program_profiler__enable(struct evsel *evsel)
>  	return 0;
>  }
>  
> +static int bpf_program_profiler__disable(struct evsel *evsel)
> +{
> +	struct bpf_counter *counter;
> +
> +	list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
> +		assert(counter->skel != NULL);
> +		bpf_prog_profiler_bpf__detach(counter->skel);
> +	}
> +	return 0;
> +}
> +
>  static int bpf_program_profiler__read(struct evsel *evsel)
>  {
>  	// perf_cpu_map uses /sys/devices/system/cpu/online
> @@ -280,6 +291,7 @@ static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu,
>  struct bpf_counter_ops bpf_program_profiler_ops = {
>  	.load       = bpf_program_profiler__load,
>  	.enable	    = bpf_program_profiler__enable,
> +	.disable    = bpf_program_profiler__disable,
>  	.read       = bpf_program_profiler__read,
>  	.destroy    = bpf_program_profiler__destroy,
>  	.install_pe = bpf_program_profiler__install_pe,
> @@ -627,6 +639,12 @@ static int bperf__enable(struct evsel *evsel)
>  	return 0;
>  }
>  
> +static int bperf__disable(struct evsel *evsel)
> +{
> +	evsel->follower_skel->bss->enabled = 0;
> +	return 0;
> +}
> +
>  static int bperf__read(struct evsel *evsel)
>  {
>  	struct bperf_follower_bpf *skel = evsel->follower_skel;
> @@ -768,6 +786,7 @@ static int bperf__destroy(struct evsel *evsel)
>  struct bpf_counter_ops bperf_ops = {
>  	.load       = bperf__load,
>  	.enable     = bperf__enable,
> +	.disable    = bperf__disable,
>  	.read       = bperf__read,
>  	.install_pe = bperf__install_pe,
>  	.destroy    = bperf__destroy,
> @@ -806,6 +825,13 @@ int bpf_counter__enable(struct evsel *evsel)
>  	return evsel->bpf_counter_ops->enable(evsel);
>  }
>  
> +int bpf_counter__disable(struct evsel *evsel)
> +{
> +	if (bpf_counter_skip(evsel))
> +		return 0;
> +	return evsel->bpf_counter_ops->disable(evsel);
> +}
> +
>  int bpf_counter__read(struct evsel *evsel)
>  {
>  	if (bpf_counter_skip(evsel))
> diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.h
> index cb9c532e0a079..d6d907c3dcf92 100644
> --- a/tools/perf/util/bpf_counter.h
> +++ b/tools/perf/util/bpf_counter.h
> @@ -18,6 +18,7 @@ typedef int (*bpf_counter_evsel_install_pe_op)(struct evsel *evsel,
>  struct bpf_counter_ops {
>  	bpf_counter_evsel_target_op load;
>  	bpf_counter_evsel_op enable;
> +	bpf_counter_evsel_op disable;
>  	bpf_counter_evsel_op read;
>  	bpf_counter_evsel_op destroy;
>  	bpf_counter_evsel_install_pe_op install_pe;
> @@ -32,6 +33,7 @@ struct bpf_counter {
>  
>  int bpf_counter__load(struct evsel *evsel, struct target *target);
>  int bpf_counter__enable(struct evsel *evsel);
> +int bpf_counter__disable(struct evsel *evsel);
>  int bpf_counter__read(struct evsel *evsel);
>  void bpf_counter__destroy(struct evsel *evsel);
>  int bpf_counter__install_pe(struct evsel *evsel, int cpu, int fd);
> @@ -51,6 +53,11 @@ static inline int bpf_counter__enable(struct evsel *evsel __maybe_unused)
>  	return 0;
>  }
>  
> +static inline int bpf_counter__disable(struct evsel *evsel __maybe_unused)
> +{
> +	return 0;
> +}
> +
>  static inline int bpf_counter__read(struct evsel *evsel __maybe_unused)
>  {
>  	return -EAGAIN;
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index d29a8a118973c..e71041c890102 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -17,6 +17,7 @@
>  #include "evsel.h"
>  #include "debug.h"
>  #include "units.h"
> +#include "bpf_counter.h"
>  #include <internal/lib.h> // page_size
>  #include "affinity.h"
>  #include "../perf.h"
> @@ -421,6 +422,9 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name)
>  	if (affinity__setup(&affinity) < 0)
>  		return;
>  
> +	evlist__for_each_entry(evlist, pos)
> +		bpf_counter__disable(pos);
> +
>  	/* Disable 'immediate' events last */
>  	for (imm = 0; imm <= 1; imm++) {
>  		evlist__for_each_cpu(evlist, i, cpu) {
> -- 
> 2.30.2
> 

-- 

- Arnaldo
