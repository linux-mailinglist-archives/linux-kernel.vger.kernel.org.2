Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BED3A45BC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 17:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhFKPyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 11:54:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229572AbhFKPyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 11:54:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D4B861004;
        Fri, 11 Jun 2021 15:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623426774;
        bh=k4x9/UGdvNqg0hM2L22Ue7V0RaYQs7FFSXyap35HQeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o6kPrX83fXhoXHv0lBBGKSAcXEAGb8JIOOlQBFJcBVPMH7vBGKDuY2jN4gkkXFbfh
         7cCeesp1f4h+9gA0iBAyutKHdLCMsWLpNWpm3aZzdj+yJlL/cNBbd+kh68oyClxXS3
         vYWVI1TEIPCPZGUFtbMKll6D3fK9NEdSKWJYTpPI25yQnF9GH2j0mgtSUel0774l8S
         PiFcR25/lGMFlRZ5jvawuW/tU9lt0w0lv63L7EJ7d2MP54mWyXM/o+3Ehk+N0qWzx7
         80xXcgN+qwkrE+9k1qTyXMxfuXpPSm86ejrINhzC+8b4Im+MY2VVsmFsJK0n9dHoix
         IoumKozMyuwbw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C30FA40B1A; Fri, 11 Jun 2021 12:52:51 -0300 (-03)
Date:   Fri, 11 Jun 2021 12:52:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf annotate: Add itrace options support
Message-ID: <YMOG04alB0OoBEKz@kernel.org>
References: <20210607025918.118603-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607025918.118603-1-yangjihong1@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 07, 2021 at 10:59:18AM +0800, Yang Jihong escreveu:
> The "auxtrace_info" and "auxtrace" functions are not set in "tool" member of
> "annotate". As a result, perf annotate does not support parsing itrace data.
> 
> A simple example is as follows:
> 
>   # perf record -e arm_spe_0/branch_filter=1/ -a sleep 1
>   [ perf record: Woken up 9 times to write data ]
>   [ perf record: Captured and wrote 20.874 MB perf.data ]
>   # perf annotate --stdio
>   Error:
>   The perf.data data has no samples!
> 
> Solution:
> 1.Add itrace options in help,
> 2.Set hook functions of "auxtrace_info" and "auxtrace" in perf_tool.

So, while we wait for someone to ack/review this, please send a v2
updating tools/perf/Documentation/perf-annotate.txt to have references
to these new 'perf annotate' options.

It all looks ok, so if nobody chimes in, I'll process v2 on my own.

Thanks,

- Arnaldo
 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
> 
> Changes since v1:
>  - Adjust spaces to maintain alignment in "tool".
> 
>  tools/perf/builtin-annotate.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 49627a7bed7c..8f87658eff31 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -474,6 +474,8 @@ int cmd_annotate(int argc, const char **argv)
>  			.attr	= perf_event__process_attr,
>  			.build_id = perf_event__process_build_id,
>  			.tracing_data   = perf_event__process_tracing_data,
> +			.auxtrace_info	= perf_event__process_auxtrace_info,
> +			.auxtrace	= perf_event__process_auxtrace,
>  			.feature	= process_feature_event,
>  			.ordered_events = true,
>  			.ordering_requires_timestamps = true,
> @@ -483,6 +485,9 @@ int cmd_annotate(int argc, const char **argv)
>  	struct perf_data data = {
>  		.mode  = PERF_DATA_MODE_READ,
>  	};
> +	struct itrace_synth_opts itrace_synth_opts = {
> +		.set = 0,
> +	};
>  	struct option options[] = {
>  	OPT_STRING('i', "input", &input_name, "file",
>  		    "input file name"),
> @@ -547,6 +552,9 @@ int cmd_annotate(int argc, const char **argv)
>  	OPT_CALLBACK(0, "percent-type", &annotate.opts, "local-period",
>  		     "Set percent type local/global-period/hits",
>  		     annotate_parse_percent_type),
> +	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
> +			    "Instruction Tracing options\n" ITRACE_HELP,
> +			    itrace_parse_synth_opts),
>  
>  	OPT_END()
>  	};
> @@ -591,6 +599,8 @@ int cmd_annotate(int argc, const char **argv)
>  	if (IS_ERR(annotate.session))
>  		return PTR_ERR(annotate.session);
>  
> +	annotate.session->itrace_synth_opts = &itrace_synth_opts;
> +
>  	annotate.has_br_stack = perf_header__has_feat(&annotate.session->header,
>  						      HEADER_BRANCH_STACK);
>  
> -- 
> 2.30.GIT
> 

-- 

- Arnaldo
