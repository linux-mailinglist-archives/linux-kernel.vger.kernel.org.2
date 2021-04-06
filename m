Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7488735593D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 18:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237651AbhDFQdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 12:33:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232913AbhDFQdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:33:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 262DF61242;
        Tue,  6 Apr 2021 16:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617726796;
        bh=i9cAfTfFodn8EtmRiY0kHTygQzNwzpycJDXRyZy51Es=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Avr4uKmccnZOBbdf+RRmwIRkizkXAM/HaQqwOp2yvm5GAPcngcx3yMCC9kYHuWptX
         /32Yi/dipoysoPYpNblS9RtjiIokQscSglrROaWqO43wSbzabdkAw6S2PPavhKQwBP
         J8FgV5AxlGkcoOiniUkh1WYFrajKFmJdKSE9SVk/88td1vY6OzK+AIgoXznokuy2yD
         dfB0UaCKk5ej+aHQhzUJR2EiHQdN5/HdD1vwgCEIhytfvnJVAyxR0NVONEuLkSbuCm
         UkIJjB3ZqfrexG+4SriLnUNmT11+lUFBFoJSUmFTOUs8Csxr0oBHDMT30ByngwJa/J
         CixUWKtbts5Kg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E00AF40647; Tue,  6 Apr 2021 13:33:12 -0300 (-03)
Date:   Tue, 6 Apr 2021 13:33:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] perf: util/mem-events.h: Remove unnecessary struct
 declaration
Message-ID: <YGyNSMDNlxQk5j7E@kernel.org>
References: <20210406105104.675879-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406105104.675879-1-wanjiabing@vivo.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 06, 2021 at 06:51:02PM +0800, Wan Jiabing escreveu:
> struct mem_info is defined at 22nd line.
> The declaration here is unnecessary. Remove it.
 

Thanks, applied.

- Arnaldo

> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  tools/perf/util/mem-events.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index 755cef7e0625..5ddbeaa057b0 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -44,7 +44,6 @@ bool is_mem_loads_aux_event(struct evsel *leader);
>  
>  void perf_mem_events__list(void);
>  
> -struct mem_info;
>  int perf_mem__tlb_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
>  int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
>  int perf_mem__snp_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
> -- 
> 2.25.1
> 

-- 

- Arnaldo
