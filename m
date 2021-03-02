Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE5332A626
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573030AbhCBOIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 09:08:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:50832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1442154AbhCBMcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:32:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED67764F0D;
        Tue,  2 Mar 2021 12:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614687794;
        bh=nIxz5EvW+c2Zl9voIp91MQE6tD0opgmdGseUBbonhvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T3B9ASBjSTTtqOQUSKaCij/h2eEfr5IJmL/vaWu3dKGuUhHq1H4qipwxNmFqqFAan
         4rPclXys+P6c0s1fRH9oKWQ0CiEn0DuXz5cz0TYd3s/tK+G5qVuKvZwxgp2C6BK1UB
         4zAO1lBkJzajSP18qolntGRw8Gpv0j7ddGjqV1fvF0Go3sCW7ub5a9D91iPHzH79f1
         DAJalm69h4rkGsCG/nzIcPIBhNt+osLwFJNK+clBF4dBBnnPrn+FgEQ2vtsC5qdWM+
         HwdWaRj2bTIS/TR1QeXFngyLBkW44cldpMPiJlZ5Ogj910b26t75g1TtxLx8lgsM+T
         sxgO/5UGxpcSQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E9F1840CD9; Tue,  2 Mar 2021 09:23:09 -0300 (-03)
Date:   Tue, 2 Mar 2021 09:23:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Gon Solo <gonsolo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andreas Wendleder <andreas.wendleder@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Perf: Clean generated directory.
Message-ID: <YD4uLRARSI16b9eJ@kernel.org>
References: <20210301185642.163396-1-gonsolo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301185642.163396-1-gonsolo@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 01, 2021 at 07:56:42PM +0100, Gon Solo escreveu:
> From: Andreas Wendleder <andreas.wendleder@gmail.com>
> 
> Remove generated directory tools/perf/arch/x86/include/generated.

Thanks applied.

There is one more, consider fixing it too:

  $ make -C tools/perf clean
  make: Entering directory '/home/acme/git/perf/tools/perf'
    CLEAN    x86
    CLEAN    libtraceevent
    CLEAN    libapi
    CLEAN    libbpf
    CLEAN    libsubcmd
    CLEAN    libperf
    CLEAN    fixdep
    CLEAN    feature-detect
    CLEAN    python
    CLEAN    bpf-skel
    CLEAN    core-objs
    CLEAN    core-progs
    CLEAN    core-gen
    CLEAN    Documentation
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $ find tools/perf -name generated
  tools/perf/trace/beauty/generated
  $

- Arnaldo
 
> Signed-off-by: Andreas Wendleder <andreas.wendleder@gmail.com>
> ---
>  tools/perf/arch/x86/Makefile | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
> index 8cc6642fce7a..5a9f9a7bf07d 100644
> --- a/tools/perf/arch/x86/Makefile
> +++ b/tools/perf/arch/x86/Makefile
> @@ -10,10 +10,11 @@ PERF_HAVE_JITDUMP := 1
>  # Syscall table generation
>  #
>  
> -out    := $(OUTPUT)arch/x86/include/generated/asm
> -header := $(out)/syscalls_64.c
> -sys    := $(srctree)/tools/perf/arch/x86/entry/syscalls
> -systbl := $(sys)/syscalltbl.sh
> +generated := $(OUTPUT)arch/x86/include/generated
> +out       := $(generated)/asm
> +header    := $(out)/syscalls_64.c
> +sys       := $(srctree)/tools/perf/arch/x86/entry/syscalls
> +systbl    := $(sys)/syscalltbl.sh
>  
>  # Create output directory if not already present
>  _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
> @@ -22,6 +23,6 @@ $(header): $(sys)/syscall_64.tbl $(systbl)
>  	$(Q)$(SHELL) '$(systbl)' $(sys)/syscall_64.tbl 'x86_64' > $@
>  
>  clean::
> -	$(call QUIET_CLEAN, x86) $(RM) $(header)
> +	$(call QUIET_CLEAN, x86) $(RM) -r $(header) $(generated)
>  
>  archheaders: $(header)
> -- 
> 2.27.0
> 

-- 

- Arnaldo
