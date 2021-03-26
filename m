Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E30349FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 03:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhCZCZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 22:25:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14549 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhCZCYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 22:24:42 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F65Mc6QxrzPmQP;
        Fri, 26 Mar 2021 10:22:04 +0800 (CST)
Received: from [10.67.102.248] (10.67.102.248) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Mar 2021 10:24:30 +0800
Subject: Re: [PATCH v7] perf annotate: Fix sample events lost in stdio mode
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <yao.jin@linux.intel.com>, <gustavoars@kernel.org>,
        <mliska@suse.cz>, <linux-kernel@vger.kernel.org>
CC:     <zhangjinhao2@huawei.com>
References: <20210319123527.173883-1-yangjihong1@huawei.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <33ba152e-b8ef-3057-744a-51cb8c478ff2@huawei.com>
Date:   Fri, 26 Mar 2021 10:24:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210319123527.173883-1-yangjihong1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.248]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
ping :)

On 2021/3/19 20:35, Yang Jihong wrote:
> In hist__find_annotations function, since different hist_entry may point to same
> symbol, we free notes->src to signal already processed this symbol in stdio mode;
> when annotate, entry will skipped if notes->src is NULL to avoid repeated output.
> 
> However, there is a problem, for example, run the following command:
> 
>   # perf record -e branch-misses -e branch-instructions -a sleep 1
> 
> perf.data file contains different types of sample event.
> 
> If the same IP sample event exists in branch-misses and branch-instructions,
> this event uses the same symbol. When annotate branch-misses events, notes->src
> corresponding to this event is set to null, as a result, when annotate
> branch-instructions events, this event is skipped and no annotate is output.
> 
> Solution of this patch is to remove zfree in hists__find_annotations and
> change sort order to "dso,symbol" to avoid duplicate output when different
> processes correspond to the same symbol.
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
> 
> Changes since v6:
>    - Remove separate setup_sorting() for branch mode.
> 
> Changes since v5:
>    - Add Signed-off-by tag.
> 
> Changes since v4:
>    - Use the same sort key "dso,symbol" in branch stack mode.
> 
> Changes since v3:
>    - Modify the first line of comments.
> 
> Changes since v2:
>    - Remove zfree in hists__find_annotations.
>    - Change sort order to avoid duplicate output.
> 
> Changes since v1:
>    - Change processed flag variable from u8 to bool.
> 
>   tools/perf/builtin-annotate.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index a23ba6bb99b6..795c2ac7fcd1 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -374,13 +374,6 @@ static void hists__find_annotations(struct hists *hists,
>   		} else {
>   			hist_entry__tty_annotate(he, evsel, ann);
>   			nd = rb_next(nd);
> -			/*
> -			 * Since we have a hist_entry per IP for the same
> -			 * symbol, free he->ms.sym->src to signal we already
> -			 * processed this symbol.
> -			 */
> -			zfree(&notes->src->cycles_hist);
> -			zfree(&notes->src);
>   		}
>   	}
>   }
> @@ -619,14 +612,22 @@ int cmd_annotate(int argc, const char **argv)
>   
>   	setup_browser(true);
>   
> -	if ((use_browser == 1 || annotate.use_stdio2) && annotate.has_br_stack) {
> +	/*
> +	 * Events of different processes may correspond to the same
> +	 * symbol, we do not care about the processes in annotate,
> +	 * set sort order to avoid repeated output.
> +	 */
> +	sort_order = "dso,symbol";
> +
> +	/*
> +	 * Set SORT_MODE__BRANCH so that annotate display IPC/Cycle
> +	 * if branch info is in perf data in TUI mode.
> +	 */
> +	if ((use_browser == 1 || annotate.use_stdio2) && annotate.has_br_stack)
>   		sort__mode = SORT_MODE__BRANCH;
> -		if (setup_sorting(annotate.session->evlist) < 0)
> -			usage_with_options(annotate_usage, options);
> -	} else {
> -		if (setup_sorting(NULL) < 0)
> -			usage_with_options(annotate_usage, options);
> -	}
> +
> +	if (setup_sorting(NULL) < 0)
> +		usage_with_options(annotate_usage, options);
>   
>   	ret = __cmd_annotate(&annotate);
>   
> 
