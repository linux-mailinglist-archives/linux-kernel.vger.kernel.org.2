Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFC9352B10
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 15:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbhDBNhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 09:37:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235204AbhDBNhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 09:37:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B44F8610C7;
        Fri,  2 Apr 2021 13:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617370624;
        bh=n8iDpuZ2YY49x2xMoPmDXdG45SHe2TLWyNvyZwo/VO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MdnRdqiQNFkuG4F2vVmYJmVdxvITwxnDP+UKCF7fDJ/Fa9s6Lk05svcGlu1cQmfcv
         RvHzZh/7GQd10IO/TgdnIQ6YUKiFh+NPf67zA57qhKmJ1kfPazupewLxU788DLZToC
         6ctTwRMSeXeltE0esQqfZStL7bCnC80pDeHMzjihxaVhlFO3CHi8nDAZ3NN3PeDNDZ
         2iSolBPbKOZ170v+NiLhSiSZY7npay7w50ro/8+lIrqsBcs5PqwTxEk/mN1a+DFqUp
         mVTOQXcEZuQS+w5iqocOv61q1btkXsYZn/CgobZOIiZg2u3fH2i+YkP6/q+8s6Jzv/
         IxlfvD0FnSw1A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 95EB740647; Fri,  2 Apr 2021 10:37:02 -0300 (-03)
Date:   Fri, 2 Apr 2021 10:37:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexey Alexandrov <aalexand@google.com>
Subject: Re: [PATCH] perf record: Disallow -c and -F option at the same time
Message-ID: <YGcd/vz3KyOUReOh@kernel.org>
References: <20210402094020.28164-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402094020.28164-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 02, 2021 at 06:40:20PM +0900, Namhyung Kim escreveu:
> It's confusing which one is effective when the both options are given.
> The current code happens to use -c in this case but users might not be
> aware of it.  We can change it to complain about that instead of
> relying on the implicit priority.
> 
> Before:
>   $ perf record -c 111111 -F 99 true
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.031 MB perf.data (8 samples) ]
> 
>   $ perf evlist -F
>   cycles: sample_period=111111
> 
> After:
>   $ perf record -c 111111 -F 99 true
>   cannot set frequency and period at the same time
> 
> So this change can break existing usages, but I think it's rare to
> have both options and it'd be better changing them.

Humm, perhaps we can just make that an warning stating that -c is used
if both are specified?

$ perf record -c 111111 -F 99 true
Frequency and period can't be used the same time, -c 11111 will be used.

- Arnaldo
 
> Suggested-by: Alexey Alexandrov <aalexand@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/record.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> index f99852d54b14..43e5b563dee8 100644
> --- a/tools/perf/util/record.c
> +++ b/tools/perf/util/record.c
> @@ -157,9 +157,15 @@ static int get_max_rate(unsigned int *rate)
>  static int record_opts__config_freq(struct record_opts *opts)
>  {
>  	bool user_freq = opts->user_freq != UINT_MAX;
> +	bool user_interval = opts->user_interval != ULLONG_MAX;
>  	unsigned int max_rate;
>  
> -	if (opts->user_interval != ULLONG_MAX)
> +	if (user_interval && user_freq) {
> +		pr_err("cannot set frequency and period at the same time\n");
> +		return -1;
> +	}
> +
> +	if (user_interval)
>  		opts->default_interval = opts->user_interval;
>  	if (user_freq)
>  		opts->freq = opts->user_freq;
> -- 
> 2.31.0.208.g409f899ff0-goog
> 

-- 

- Arnaldo
