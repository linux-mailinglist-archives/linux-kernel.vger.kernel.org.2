Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A6E365CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhDTPwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:52:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:40108 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232916AbhDTPwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:52:16 -0400
IronPort-SDR: 30qJNd0AG1jjNlOhig5zZCoHYhB4hd7w+VyGSNXcyMwldJuOh4VB+hZuqyAxTQ9TxNOce240fK
 N0a9hybgImjg==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="280860104"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="280860104"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 08:50:54 -0700
IronPort-SDR: UWv3gxP9GGiLx+9PMo6a2uIMejjMXkv1kpYqX/ZV0uYKxD7h91qOQbIVyNT2ocI/mCPItsxKJY
 BaTjF5OJBIHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="445564292"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga004.fm.intel.com with ESMTP; 20 Apr 2021 08:50:51 -0700
Subject: Re: [PATCH] perf auxtrace: Fix potential null pointer dereference
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-kernel@vger.kernel.org
References: <20210420151554.2031768-1-leo.yan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <22a1f6b4-0e4f-72df-2873-b4098a6c73dc@intel.com>
Date:   Tue, 20 Apr 2021 18:51:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210420151554.2031768-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/21 6:15 pm, Leo Yan wrote:
> In the function auxtrace_parse_snapshot_options(), the callback pointer
> "itr->parse_snapshot_options" can be NULL if it has not been set during
> the AUX record initialization.  This can cause tool crashing if the
> callback pointer "itr->parse_snapshot_options" is dereferenced without
> performing NULL check.
> 
> Add a NULL check for the pointer "itr->parse_snapshot_options" before
> invoke the callback.
> 
> Fixes: d20031bb63dd ("perf tools: Add AUX area tracing Snapshot Mode")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/auxtrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 953f4afacd3b..320b47f133d3 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -638,7 +638,7 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
>  		break;
>  	}
>  
> -	if (itr)
> +	if (itr && itr->parse_snapshot_options)
>  		return itr->parse_snapshot_options(itr, opts, str);
>  
>  	pr_err("No AUX area tracing to snapshot\n");
> 

