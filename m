Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D66532A674
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444638AbhCBPFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 10:05:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:51890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1444824AbhCBMlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:41:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01ABB64EF0;
        Tue,  2 Mar 2021 12:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614688601;
        bh=hNe23bhwWYo07CnHga0v5E3+0XsWNHacOjSKOYo1JfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lRYTK5w9zKhk+QslYnkgMIrRuNLJrdJZ6SbXi4vyUsi9oPH2QgwF8btIA3vDfycL8
         kPXl3+YIeoOpeW1NWbD6axEYeVhe9BRxa60otJelX7T2UbWNaPPMQIYlUCMKY+ie3D
         l3K8hVi1tGlVoMWQDvguGeh9TFhcjhboW8iC9ygcSp5H/NecxMHRY+xPsgT+VVFJwf
         325X+/bJcXvVB/ptXyNw744b2/tvjlSmyosYRy4TyHCBLwJ01Azoo21FOJZ6cLTfNp
         9dswhmCmeOCO6vJ3Xb/WGaBXKQE3/1YOyM4BIyBPTTMwQVoMswt0gmev/PjNcp+MkG
         Gd+7IDSwkYp/Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DDD2A40CD9; Tue,  2 Mar 2021 09:36:38 -0300 (-03)
Date:   Tue, 2 Mar 2021 09:36:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf tools: Fix documentation of verbose options
Message-ID: <YD4xVsqs6yqaqB+Z@kernel.org>
References: <20210226183145.1878782-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226183145.1878782-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 26, 2021 at 10:31:44AM -0800, Ian Rogers escreveu:
> Option doesn't take a value, make sure the man pages agree. For example:
> 
> $ perf evlist --verbose=1
>  Error: option `verbose' takes no value

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-evlist.txt   | 2 +-
>  tools/perf/Documentation/perf-ftrace.txt   | 4 ++--
>  tools/perf/Documentation/perf-kallsyms.txt | 2 +-
>  tools/perf/Documentation/perf-trace.txt    | 4 ++--
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-evlist.txt b/tools/perf/Documentation/perf-evlist.txt
> index c0a66400a960..9af8b8dfb7b6 100644
> --- a/tools/perf/Documentation/perf-evlist.txt
> +++ b/tools/perf/Documentation/perf-evlist.txt
> @@ -29,7 +29,7 @@ OPTIONS
>  	Show just the sample frequency used for each event.
>  
>  -v::
> ---verbose=::
> +--verbose::
>  	Show all fields.
>  
>  -g::
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> index 1e91121bac0f..6e82b7cc0bf0 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -28,8 +28,8 @@ OPTIONS
>  	specified: function_graph or function.
>  
>  -v::
> ---verbose=::
> -        Verbosity level.
> +--verbose::
> +        Increase the verbosity level.
>  
>  -F::
>  --funcs::
> diff --git a/tools/perf/Documentation/perf-kallsyms.txt b/tools/perf/Documentation/perf-kallsyms.txt
> index f3c620951f6e..c97527df8ecd 100644
> --- a/tools/perf/Documentation/perf-kallsyms.txt
> +++ b/tools/perf/Documentation/perf-kallsyms.txt
> @@ -20,5 +20,5 @@ modules).
>  OPTIONS
>  -------
>  -v::
> ---verbose=::
> +--verbose::
>  	Increase verbosity level, showing details about symbol table loading, etc.
> diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
> index abc9b5d83312..f0da8cf63e9a 100644
> --- a/tools/perf/Documentation/perf-trace.txt
> +++ b/tools/perf/Documentation/perf-trace.txt
> @@ -97,8 +97,8 @@ filter out the startup phase of the program, which is often very different.
>  	Filter out events for these pids and for 'trace' itself (comma separated list).
>  
>  -v::
> ---verbose=::
> -        Verbosity level.
> +--verbose::
> +        Increase the verbosity level.
>  
>  --no-inherit::
>  	Child tasks do not inherit counters.
> -- 
> 2.30.1.766.gb4fecdf3b7-goog
> 

-- 

- Arnaldo
