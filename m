Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC55837769F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 14:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhEIMtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 08:49:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhEIMtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 08:49:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BE4A613EC;
        Sun,  9 May 2021 12:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620564497;
        bh=7QsSUDtLeRaWkmJ/kcnV6krCbtDbtPKhsWNuREtl8Ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QwMMK1DbP1tNWPSr6tweLkdZxWFHCsyAdEhWatlqutn252fwA82LjW7KIUnGgn3s5
         cwjf9zV84sFaOs1VwQ7ZFFPHBHwmaS19Rj1J4UgoWoucbRCbPqgj+idiCoGV6nL/Jh
         UjwU3F0aQXO659z6wIXIYr36PWAhzP608ULaqU5s46a17rShoE/zuZfFTzE5M421eP
         PCKaxISbhvID1T0iTCczd/R6S2cG4fq+Y7LLnnQA5K7nY6gWEplaYUbwFJMZrzzEyZ
         opFG2OMHdZDJnAFdFooLFk2YN+ySPSgU2rj2sJ2x2FWRovRi+/mUWEVwLVJfyphAMf
         BrFGeO8b/dtPQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C0AC84034C; Sun,  9 May 2021 09:48:14 -0300 (-03)
Date:   Sun, 9 May 2021 09:48:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        "Justin M . Forbes" <jforbes@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf tools: Fix dynamic libbpf link
Message-ID: <YJfaDjkLygpCJ5IO@kernel.org>
References: <20210508205020.617984-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210508205020.617984-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, May 08, 2021 at 10:50:20PM +0200, Jiri Olsa escreveu:
> Justin reported broken build with LIBBPF_DYNAMIC=1.
> 
> When linking libbpf dynamically we need to use perf's
> hashmap object, because it's not exported in libbpf.so
> (only in libbpf.a).
> 
> Following build is now passing:
> 
>   $ make LIBBPF_DYNAMIC=1
>     BUILD:   Doing 'make -j8' parallel build
>     ...
>   $ ldd perf | grep libbpf
>         libbpf.so.0 => /lib64/libbpf.so.0 (0x00007fa7630db000)

Thanks, applied.

- Arnaldo

 
> Fixes: eee19501926d ("perf tools: Grab a copy of libbpf's hashmap")
> Cc: Ian Rogers <irogers@google.com>
> Reported-by: Justin M. Forbes <jforbes@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/Makefile.config | 1 +
>  tools/perf/util/Build      | 7 +++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 7b195e16040e..dacd16874d3d 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -546,6 +546,7 @@ ifndef NO_LIBELF
>        ifdef LIBBPF_DYNAMIC
>          ifeq ($(feature-libbpf), 1)
>            EXTLIBS += -lbpf
> +          $(call detected,CONFIG_LIBBPF_DYNAMIC)
>          else
>            dummy := $(error Error: No libbpf devel library found, please install libbpf-devel);
>          endif
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index e27a551acd3a..95e15d1035ab 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -145,7 +145,14 @@ perf-$(CONFIG_LIBELF) += symbol-elf.o
>  perf-$(CONFIG_LIBELF) += probe-file.o
>  perf-$(CONFIG_LIBELF) += probe-event.o
>  
> +ifdef CONFIG_LIBBPF_DYNAMIC
> +  hashmap := 1
> +endif
>  ifndef CONFIG_LIBBPF
> +  hashmap := 1
> +endif
> +
> +ifdef hashmap
>  perf-y += hashmap.o
>  endif
>  
> -- 
> 2.31.1
> 

-- 

- Arnaldo
