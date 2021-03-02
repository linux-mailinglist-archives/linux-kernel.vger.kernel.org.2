Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF9232A693
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578555AbhCBPZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 10:25:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:60510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351007AbhCBNCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 08:02:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFB3B64F15;
        Tue,  2 Mar 2021 13:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614690070;
        bh=NGPA082Dlx8vneZtl53YoiOOzh33VotGWrJL+0PbHyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j/vynjlOMTVeGvv9xba32RIEdlcDo0ax7KeJ4DiRsKLHj+RYPXzj43VWGsavW34Al
         zj3ufFl+gH/JyGwt7/qM9kdyRX1UkAY6xvVZSZN1/vfMG/jGT34/N19EirfefQY0Hm
         seX9dX3vyafXaa1soUjFW7gw0yJyacHDgi62GYoOYW9kY7WcTUOGuPCKwjedvKActC
         EpEuSIoZaX2tUxNcylPYRCdCi+GHubQfXccXLznZp+oG23w/0IbVFUg2qb54r+Qy9d
         zJz9Um3U/O/hDBDuqR9FwzJ8mo9QXWF2YUbT73vyXZMCMjJ8+5/KOvijoD5C1r/hh9
         DLny/rYT+C4cw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D0FEC40CD9; Tue,  2 Mar 2021 10:01:06 -0300 (-03)
Date:   Tue, 2 Mar 2021 10:01:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Jin Yao <yao.jin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf tools: Fix event's pmu name parsing
Message-ID: <YD43EnqkAKmN0Q4f@kernel.org>
References: <20210301122315.63471-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301122315.63471-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 01, 2021 at 01:23:15PM +0100, Jiri Olsa escreveu:
> Jin Yao reported parser error for software event:
> 
>   # perf stat -e software/r1a/ -a -- sleep 1
>   event syntax error: 'software/r1a/'
>                        \___ parser error
> 
> This happens after commit 8c3b1ba0e7ea, where new
> software-gt-awake-time event's non-pmu-event-style
> makes event parser conflict with software pmu.
> 
> If we allow PE_PMU_EVENT_PRE to be parsed as pmu name,
> we fix the conflict and the following character '/' for
> pmu or '-' for non-pmu-event-style event allows parser
> to decide what even is specified.

Thanks, applied.

- Arnaldo

 
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Fixes: 8c3b1ba0e7ea ("drm/i915/gt: Track the overall awake/busy time") # 1
> Reported-by: Jin Yao <yao.jin@linux.intel.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/parse-events.y | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index d5b6aff82f21..d57ac86ce7ca 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -89,6 +89,7 @@ static void inc_group_count(struct list_head *list,
>  %type <str> PE_EVENT_NAME
>  %type <str> PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
>  %type <str> PE_DRV_CFG_TERM
> +%type <str> event_pmu_name
>  %destructor { free ($$); } <str>
>  %type <term> event_term
>  %destructor { parse_events_term__delete ($$); } <term>
> @@ -272,8 +273,11 @@ event_def: event_pmu |
>  	   event_legacy_raw sep_dc |
>  	   event_bpf_file
>  
> +event_pmu_name:
> +PE_NAME | PE_PMU_EVENT_PRE
> +
>  event_pmu:
> -PE_NAME opt_pmu_config
> +event_pmu_name opt_pmu_config
>  {
>  	struct parse_events_state *parse_state = _parse_state;
>  	struct parse_events_error *error = parse_state->error;
> -- 
> 2.29.2
> 

-- 

- Arnaldo
