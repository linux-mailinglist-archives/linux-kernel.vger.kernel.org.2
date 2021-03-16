Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F9C33D493
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 14:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbhCPNHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 09:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28240 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234502AbhCPNHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 09:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615900036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HvjFoEc95RC6hqw+H0cl0nGVkg6yKzxU3LpEodtRCok=;
        b=RFITR5zGzrzAUNjfN9ezOmV/DoiUZmwh83BpVvTIQ5S+VQE7YYV3v/+zdSEftSFy+YDRuE
        V8zvInqiSI+bUNHaIMLQ5NdlXi2vcblXl+OZQNyScwT99gRNnePap6rn56Z4is/UY5NL8D
        ZSMVYCdfab0R4zRLcK4542yL/a2tCe4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-e-1oJ1DmNHmI_TxD9vgteA-1; Tue, 16 Mar 2021 09:07:14 -0400
X-MC-Unique: e-1oJ1DmNHmI_TxD9vgteA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AA25EC1AA;
        Tue, 16 Mar 2021 13:07:12 +0000 (UTC)
Received: from krava (unknown [10.40.193.217])
        by smtp.corp.redhat.com (Postfix) with SMTP id 301DE62AF8;
        Tue, 16 Mar 2021 13:07:10 +0000 (UTC)
Date:   Tue, 16 Mar 2021 14:07:09 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Align CSV output for summary mode
Message-ID: <YFCtfXlaKbIeEMwk@krava>
References: <20210316072900.1739-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316072900.1739-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 03:29:00PM +0800, Jin Yao wrote:
> perf-stat has supported the summary mode. But the summary
> lines break the CSV output so it's hard for scripts to parse
> the result.
> 
> Before:
> 
>   # perf stat -x, -I1000 --interval-count 1 --summary
>        1.001323097,8013.48,msec,cpu-clock,8013483384,100.00,8.013,CPUs utilized
>        1.001323097,270,,context-switches,8013513297,100.00,0.034,K/sec
>        1.001323097,13,,cpu-migrations,8013530032,100.00,0.002,K/sec
>        1.001323097,184,,page-faults,8013546992,100.00,0.023,K/sec
>        1.001323097,20574191,,cycles,8013551506,100.00,0.003,GHz
>        1.001323097,10562267,,instructions,8013564958,100.00,0.51,insn per cycle
>        1.001323097,2019244,,branches,8013575673,100.00,0.252,M/sec
>        1.001323097,106152,,branch-misses,8013585776,100.00,5.26,of all branches
>   8013.48,msec,cpu-clock,8013483384,100.00,7.984,CPUs utilized
>   270,,context-switches,8013513297,100.00,0.034,K/sec
>   13,,cpu-migrations,8013530032,100.00,0.002,K/sec
>   184,,page-faults,8013546992,100.00,0.023,K/sec
>   20574191,,cycles,8013551506,100.00,0.003,GHz
>   10562267,,instructions,8013564958,100.00,0.51,insn per cycle
>   2019244,,branches,8013575673,100.00,0.252,M/sec
>   106152,,branch-misses,8013585776,100.00,5.26,of all branches
> 
> The summary line loses the timestamp column, which breaks the
> CVS output.
> 
> We add a column at the 'timestamp' position and it just says 'summary'
> for the summary line.
> 
> After:
> 
>   # perf stat -x, -I1000 --interval-count 1 --summary

looks ok, but maybe make the option more related to CVS, like:

  --x-summary, --cvs-summary  ...? 

jirka




>        1.001196053,8012.72,msec,cpu-clock,8012722903,100.00,8.013,CPUs utilized
>        1.001196053,218,,context-switches,8012753271,100.00,0.027,K/sec
>        1.001196053,9,,cpu-migrations,8012769767,100.00,0.001,K/sec
>        1.001196053,0,,page-faults,8012786257,100.00,0.000,K/sec
>        1.001196053,15004518,,cycles,8012790637,100.00,0.002,GHz
>        1.001196053,7954691,,instructions,8012804027,100.00,0.53,insn per cycle
>        1.001196053,1590259,,branches,8012814766,100.00,0.198,M/sec
>        1.001196053,82601,,branch-misses,8012824365,100.00,5.19,of all branches
>            summary,8012.72,msec,cpu-clock,8012722903,100.00,7.986,CPUs utilized
>            summary,218,,context-switches,8012753271,100.00,0.027,K/sec
>            summary,9,,cpu-migrations,8012769767,100.00,0.001,K/sec
>            summary,0,,page-faults,8012786257,100.00,0.000,K/sec
>            summary,15004518,,cycles,8012790637,100.00,0.002,GHz
>            summary,7954691,,instructions,8012804027,100.00,0.53,insn per cycle
>            summary,1590259,,branches,8012814766,100.00,0.198,M/sec
>            summary,82601,,branch-misses,8012824365,100.00,5.19,of all branches
> 
> Now it's easy for script to analyse the summary lines.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/stat-display.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 7f09cdaf5b60..c4183d3e87a4 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -439,6 +439,10 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>  		if (counter->cgrp)
>  			os.nfields++;
>  	}
> +
> +	if (config->csv_output && config->summary && !config->interval)
> +		fprintf(config->output, "%16s%s", "summary", config->csv_sep);
> +
>  	if (run == 0 || ena == 0 || counter->counts->scaled == -1) {
>  		if (config->metric_only) {
>  			pm(config, &os, NULL, "", "", 0);
> -- 
> 2.17.1
> 

