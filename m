Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C71395324
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 00:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhE3WPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 18:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23541 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229897AbhE3WPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 18:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622412835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HLuI6HWNEvcLGe0r2GBrYDZYGfmYoJR2FuR9JVQ5yaE=;
        b=jU7+l2jnNfeqXvQK+GPv3bsHXFAPjuKKFY3sdqHe8lvv+BgUM1g6w8V+aQ23U2giw8KkQv
        vP/1EBi3cb8BuU6sP86P1DVKieppH+iS32pxyEOeAsU7f//bogD6PIshGo1EIyusJtktIk
        inwEWVGTGiNOI1yEXgR1CQE61Y/bcU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-pKztLGQ6P72GArvCVOlTAw-1; Sun, 30 May 2021 18:13:53 -0400
X-MC-Unique: pKztLGQ6P72GArvCVOlTAw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E97E107ACC7;
        Sun, 30 May 2021 22:13:52 +0000 (UTC)
Received: from krava (unknown [10.40.192.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id E4B4D5D6D7;
        Sun, 30 May 2021 22:13:49 +0000 (UTC)
Date:   Mon, 31 May 2021 00:13:48 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Disable NMI watchdog message on hybrid
Message-ID: <YLQOHJ4PiRSbXsy0@krava>
References: <20210528035547.19867-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528035547.19867-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 11:55:47AM +0800, Jin Yao wrote:
> If we run a single workload that only runs on big core, there is always a
> ugly message about disabling the NMI watchdog because the atom is not
> counted.
> 
> Before:
> 
>   # perf stat ls
>   ...
> 
>    Performance counter stats for 'ls':
> 
>                 0.94 msec task-clock                #    0.620 CPUs utilized
>                    0      context-switches          #    0.000 /sec
>                    0      cpu-migrations            #    0.000 /sec
>                  111      page-faults               #  118.603 K/sec
>            3,111,368      cpu_core/cycles/          #    3.324 G/sec
>        <not counted>      cpu_atom/cycles/                                              (0.00%)
>            2,965,942      cpu_core/instructions/    #    3.169 G/sec
>        <not counted>      cpu_atom/instructions/                                        (0.00%)
>              596,579      cpu_core/branches/        #  637.442 M/sec
>        <not counted>      cpu_atom/branches/                                            (0.00%)
>               15,744      cpu_core/branch-misses/   #   16.822 M/sec
>        <not counted>      cpu_atom/branch-misses/                                       (0.00%)
> 
>          0.001509271 seconds time elapsed
> 
>          0.001572000 seconds user
>          0.000000000 seconds sys
> 
>   Some events weren't counted. Try disabling the NMI watchdog:
>           echo 0 > /proc/sys/kernel/nmi_watchdog
>           perf stat ...
>           echo 1 > /proc/sys/kernel/nmi_watchdog
> 
> Now we disable the NMI watchdog message on hybrid, otherwise there
> are too many false positives.
> 
> After:
> 
>   # perf stat ls
>   ...
> 
>    Performance counter stats for 'ls':
> 
>                 2.32 msec task-clock                #    0.712 CPUs utilized
>                    0      context-switches          #    0.000 /sec
>                    0      cpu-migrations            #    0.000 /sec
>                  110      page-faults               #   47.327 K/sec
>            2,313,349      cpu_core/cycles/          #  995.308 M/sec
>        <not counted>      cpu_atom/cycles/                                              (0.00%)
>            2,986,113      cpu_core/instructions/    #    1.285 G/sec
>        <not counted>      cpu_atom/instructions/                                        (0.00%)
>              598,861      cpu_core/branches/        #  257.657 M/sec
>        <not counted>      cpu_atom/branches/                                            (0.00%)
>               16,090      cpu_core/branch-misses/   #    6.923 M/sec
>        <not counted>      cpu_atom/branch-misses/                                       (0.00%)
> 
>          0.003265716 seconds time elapsed
> 
>          0.000000000 seconds user
>          0.003307000 seconds sys
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/stat-display.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index b759dfd633b4..db3c7a105a2b 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -465,7 +465,8 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>  			config->csv_sep);
>  
>  		if (counter->supported) {
> -			config->print_free_counters_hint = 1;
> +			if (!perf_pmu__is_hybrid(counter->pmu_name))
> +				config->print_free_counters_hint = 1;
>  			if (is_mixed_hw_group(counter))
>  				config->print_mixed_hw_group_error = 1;
>  		}
> -- 
> 2.17.1
> 

