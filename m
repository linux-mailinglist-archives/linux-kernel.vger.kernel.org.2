Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1696B32FAB7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 13:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhCFMuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 07:50:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:46434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230191AbhCFMt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 07:49:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3D9E64E99;
        Sat,  6 Mar 2021 12:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615034999;
        bh=KzPAYpNOBmjttsGTmuHzzdOdnQdaewefyavHfAmQMyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oFZXaxvFDR1Ss28IAF5e0bIOXsqsjrA6ryMeXV/6BMvTxcsSXhUOO4+mhr4/tNW+3
         mAbUdNAMOkHl9IIPaWvfJgz+asP7HjwFEJVn0qWM2NYb7Cvi/lvjPQO/BtA7AaUPu3
         ugjtwN1ceTvclyMriMFjosG5VFIAiDb17+pyrVF7PYCijuHKF84ZfjPCpAmGHtqlEK
         4+KoDuacdXFMQHLyhW7OdUEkf3rIjPuenzcTXbgSjGvKUNOEgNyujf9ebdi3S8doQp
         LzdnONET0jzB3soEDaFlt/KhpnHupPJfx58ZtKUrdU8yeH+BODU16ZSu0KiB9dD5VX
         GtBhEh3JWwUfA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B449A40647; Sat,  6 Mar 2021 09:49:55 -0300 (-03)
Date:   Sat, 6 Mar 2021 09:49:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/3] perf skel: Remove some unused variables.
Message-ID: <YEN6c5o3IUYWnLxW@kernel.org>
References: <20210306080840.3785816-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210306080840.3785816-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Mar 06, 2021 at 12:08:38AM -0800, Ian Rogers escreveu:
> Fixes -Wall warnings.

Thanks, tested all with:

  $ make BUILD_BPF_SKEL=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin

Which makes me realize we need to turn both python3 and building the bpf
skel to be the default...

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c b/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
> index c7cec92d0236..ab12b4c4ece2 100644
> --- a/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
> +++ b/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
> @@ -52,7 +52,7 @@ int BPF_PROG(fentry_XXX)
>  static inline void
>  fexit_update_maps(struct bpf_perf_event_value *after)
>  {
> -	struct bpf_perf_event_value *before, diff, *accum;
> +	struct bpf_perf_event_value *before, diff;
>  	__u32 zero = 0;
>  
>  	before = bpf_map_lookup_elem(&fentry_readings, &zero);
> @@ -78,7 +78,6 @@ int BPF_PROG(fexit_XXX)
>  {
>  	struct bpf_perf_event_value reading;
>  	__u32 cpu = bpf_get_smp_processor_id();
> -	__u32 one = 1, zero = 0;
>  	int err;
>  
>  	/* read all events before updating the maps, to reduce error */
> -- 
> 2.30.1.766.gb4fecdf3b7-goog
> 

-- 

- Arnaldo
