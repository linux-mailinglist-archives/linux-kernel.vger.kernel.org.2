Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC0B349173
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhCYMCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:02:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230525AbhCYMCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:02:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEF5961A24;
        Thu, 25 Mar 2021 12:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616673744;
        bh=4TdL+O70IMV6Jhj6RSyZtxUtapbBEQpXLdDrtpLf5rU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cGn46pcCNLY/6dAakZPWev1Np3zi0gytcMnBr9OOuSxO2GzF6I5vSsLEFi/6qau1/
         TEt5E6l8ODasenlpOg/rD+Mi0W+hZx1vIah5V1IAzGLOA9TvvHgcOhxuZrJkhWRgml
         YaxSSLN58wqAt+iKJiGPRCgi0gTBjY2/jsoLerUiLHJw4zzuhto4lbVqyiSuWoKysb
         atw3srNroZfB6Cxg3/qJZGlYFrXPnYn8BY0BYHHJ0c6s/lqCg/KUCO4wjkbZlSXKoT
         FtEeiyPjCukvy8qKuCXRmiuqH6zY7+mMgV1P6WU6rol8t1qfM4asA9Hf2N7XJuRTvw
         iz01K5PSl2ntw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9D81A40647; Thu, 25 Mar 2021 09:02:21 -0300 (-03)
Date:   Thu, 25 Mar 2021 09:02:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] tools: perf: util: Remove duplicate declaration
Message-ID: <YFx7zZVxyjGnCTl+@kernel.org>
References: <20210325043947.846093-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325043947.846093-1-wanjiabing@vivo.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 25, 2021 at 12:39:34PM +0800, Wan Jiabing escreveu:
> struct evlist has been declared at 10th line.
> struct comm has been declared at 15th line.
> Remove the duplicate.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  tools/perf/util/metricgroup.h  | 1 -
>  tools/perf/util/thread-stack.h | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> index ed1b9392e624..026bbf416c48 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -9,7 +9,6 @@
>  
>  struct evlist;
>  struct evsel;
> -struct evlist;
>  struct option;
>  struct rblist;
>  struct pmu_events_map;
> diff --git a/tools/perf/util/thread-stack.h b/tools/perf/util/thread-stack.h
> index 3bc47a42af8e..b3cd09beb62f 100644
> --- a/tools/perf/util/thread-stack.h
> +++ b/tools/perf/util/thread-stack.h
> @@ -16,7 +16,6 @@ struct comm;
>  struct ip_callchain;
>  struct symbol;
>  struct dso;
> -struct comm;
>  struct perf_sample;
>  struct addr_location;
>  struct call_path;
> -- 
> 2.25.1
> 

-- 

- Arnaldo
