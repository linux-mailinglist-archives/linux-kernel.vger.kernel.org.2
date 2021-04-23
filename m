Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2626D369A97
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 21:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243695AbhDWTCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 15:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232212AbhDWTCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 15:02:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E14A96023E;
        Fri, 23 Apr 2021 19:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619204519;
        bh=epcsoljHvi9gYrkPaYroz7lAJfkykNkXVTsL93os0ks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZkx44d41/yEe47pLGE2G3jPry1b03Wq2tvpDSSl0iLEMIISYiYMzu+xf7nPWt1si
         EQu6ifWgVO8ob/0t9ig92J6sb1++e92ISWpRhB1OjvVaR3jmcUkdqZVdsRHnxOKyVy
         qSg3fiLucdbVd+/VvirCpJUE+oBVDbMmmGbL0GpQRbY0Lz/T3ug6hiF/qyTfoGG7xW
         MzBphd0AoycNx1aBQMEUTSJcdnAEZwQZ/Wjyukio+KMw+yBvhrn3HFBK7uLyPuD6XB
         WrCwjt6lWmqQ5NfiKHjLGAwlxlFEN6ob/jaoJBaGOPL95gKJ6jEe/iyHN+YROZjsJA
         w3kM664iQpdqg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 45B9340647; Fri, 23 Apr 2021 15:59:55 -0300 (-03)
Date:   Fri, 23 Apr 2021 15:59:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Alexander Schmidt <alexschm@de.ibm.com>
Subject: Re: [PATCH] [PING] perf ftrace: Command fails on s390
Message-ID: <YIMZK3dARqXXsR76@kernel.org>
References: <20210421120400.2126433-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421120400.2126433-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 21, 2021 at 02:04:00PM +0200, Thomas Richter escreveu:
> Command 'perf ftrace -v -- ls' fails in s390 (at least 5.12.0rc6).
> 
> The root cause is a missing pointer dereference which causes an
> array element address to be used as PID.

Since you pinged on this one, and rightly so, please CC:

From the MAINTAINERS file:

PERFORMANCE EVENTS SUBSYSTEM
R:      Jiri Olsa <jolsa@redhat.com>
R:      Namhyung Kim <namhyung@kernel.org>

These reviewers that help me into getting patches processed.

Patch is processed now, good catch, I collected Namhyung's Acked-by.

Thanks,

- Arnaldo

 
> Fix this by extracting the PID.
> 
> Output before:
>   # ./perf ftrace -v -- ls
>   function_graph tracer is used
>   write '-263732416' to tracing/set_ftrace_pid failed: Invalid argument
>   failed to set ftrace pid
>   #
> 
> Output after:
>    ./perf ftrace -v -- ls
>    function_graph tracer is used
>    # tracer: function_graph
>    #
>    # CPU  DURATION                  FUNCTION CALLS
>    # |     |   |                     |   |   |   |
>    4)               |  rcu_read_lock_sched_held() {
>    4)   0.552 us    |    rcu_lockdep_current_cpu_online();
>    4)   6.124 us    |  }
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reported-by: Alexander Schmidt <alexschm@de.ibm.com>
> ---
>  tools/perf/builtin-ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index d49448a1060c..87cb11a7a3ee 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -289,7 +289,7 @@ static int set_tracing_pid(struct perf_ftrace *ftrace)
>  
>  	for (i = 0; i < perf_thread_map__nr(ftrace->evlist->core.threads); i++) {
>  		scnprintf(buf, sizeof(buf), "%d",
> -			  ftrace->evlist->core.threads->map[i]);
> +			  perf_thread_map__pid(ftrace->evlist->core.threads, i));
>  		if (append_tracing_file("set_ftrace_pid", buf) < 0)
>  			return -1;
>  	}
> -- 
> 2.30.2
> 

-- 

- Arnaldo
