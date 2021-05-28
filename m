Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA09393A95
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 02:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbhE1Axk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 20:53:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235702AbhE1Axf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 20:53:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C9856128B;
        Fri, 28 May 2021 00:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622163121;
        bh=0QaWPrjkB6WGGB1gpdLNx41kPgSJM747S9zrT/p+Xfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQ59ejthgL68KyVgGIKRUR42w8cfbFo3MUd30YN/IWz1+EtF5mkKfpbkUVvsPUDTM
         VREWIAVKMsWnhOUbdbBaoM2DEKxi7oAc/ybErwNaVx+LslxX0K9oF3BBI5CRjOVSLt
         C/IDVVFR0IerG4cP4jSsBoRH5E4vwcqpHfmLHQ6OOYBdUFp/awClcpPK/z300uVoXM
         rPA16cxDcuyijcyt/LPt0OHH1gNvlexIzeXgZdE/jeP54EprkeOz5J8uuTwSQg0pkJ
         UvJ3s7UiDp0fbvIh8AtDrVXvG07t1yCIrAVOpXk5SEs/HRnOPKRJz47zZ5KBrJbYY6
         CgBifrYvLs5OQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 893304011C; Thu, 27 May 2021 21:51:57 -0300 (-03)
Date:   Thu, 27 May 2021 21:51:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH] perf stat: Fix error check for bpf_program__attach
Message-ID: <YLA+rfZ4Jb3oBFun@kernel.org>
References: <20210527220052.1657578-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527220052.1657578-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 27, 2021 at 03:00:52PM -0700, Namhyung Kim escreveu:
> It seems the bpf_program__attach() returns a negative error code
> instead of a NULL pointer in case of error.

Thanks, applied.

- Arnaldo

 
> Fixes: 7fac83aaf2ee ("perf stat: Introduce 'bperf' to share hardware PMCs with BPF")
> Cc: Song Liu <songliubraving@fb.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/bpf_counter.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> index ddb52f748c8e..974f10e356f0 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -451,10 +451,10 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
>  		goto out;
>  	}
>  
> -	err = -1;
>  	link = bpf_program__attach(skel->progs.on_switch);
> -	if (!link) {
> +	if (IS_ERR(link)) {
>  		pr_err("Failed to attach leader program\n");
> +		err = PTR_ERR(link);
>  		goto out;
>  	}
>  
> -- 
> 2.32.0.rc0.204.g9fa02ecfa5-goog
> 

-- 

- Arnaldo
