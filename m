Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F7232FAE4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 14:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhCFNh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 08:37:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhCFNhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 08:37:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62E5F60233;
        Sat,  6 Mar 2021 13:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615037857;
        bh=PoLzbg2aJfQOMc4vTetdMx94TeNR0p3+MFHnmg6DgMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XIcbKTIYQy7XA9pL2ApnReMnvi5eDVFWGmF2nzq77l0tTSAcderiYIuwaA0aU/SD0
         3oi8wtIvfpYmWdiIDprhsfy4XS05SX9heEt3gPNgU2cb0w4qH3QaS7HKla0sUr0ZMV
         Ofj1oRIBEaEtuwVHzCwSvkiw8sn/UNvtCr9Or25Xw7YVLQi7r8pk5HBEAkPw3/TENj
         XFJwzvvc1aE9Eut48jAh0IaDxNZr3zHKs20RuVKXmkCfTHjmlM2JvIMtdLAubSCPoO
         BG3LU8VnUDOVQu8jm8Cmg+EvMlo/EhyG6KHukmc0QmJgGFvacZAK3tkePs+SgRuWbl
         ZT/BuuHHkjeDQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EE48D40647; Sat,  6 Mar 2021 10:37:33 -0300 (-03)
Date:   Sat, 6 Mar 2021 10:37:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     menglong8.dong@gmail.com
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com, xiong.zhenwu@zte.com.cn,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tool/perf/bench: fix misspellings using codespell
Message-ID: <YEOFnSVwZAuciVTH@kernel.org>
References: <20210305092212.204923-1-xiong.zhenwu@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305092212.204923-1-xiong.zhenwu@zte.com.cn>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 05, 2021 at 01:22:12AM -0800, menglong8.dong@gmail.com escreveu:
> From: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
> 
> $ codespell ./tool/perf/bench
> tools/perf/bench/inject-buildid.c:375: tihs  ==> this 
> 
> Fix a typo found by codespell.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Xiong Zhenwu <xiong.zhenwu@zte.com.cn>
> ---
>  tools/perf/bench/inject-buildid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
> index 280227e3ffd7..55d373b75791 100644
> --- a/tools/perf/bench/inject-buildid.c
> +++ b/tools/perf/bench/inject-buildid.c
> @@ -372,7 +372,7 @@ static int inject_build_id(struct bench_data *data, u64 *max_rss)
>  			len += synthesize_flush(data);
>  	}
>  
> -	/* tihs makes the child to finish */
> +	/* this makes the child to finish */
>  	close(data->input_pipe[1]);
>  
>  	wait4(data->pid, &status, 0, &rusage);
> -- 
> 2.25.1
> 

-- 

- Arnaldo
