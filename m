Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1747E32FCC4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 20:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhCFT25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 14:28:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:46438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230390AbhCFT21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 14:28:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFF9D650B5;
        Sat,  6 Mar 2021 19:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615058907;
        bh=/cRTkN5iORhsOndKR9uOHKvVeqUAVFqGbXTHgpQzAfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m7yu71zWsA252G+1tar+X9Ox0T0oREHd4pNkuLpq6MEdUzvbJBKsJ9m3zo89rhuWi
         /HxxP+jTcy+og6tctQMcY5CSS+SPTbxjaNf4nCA3EXMcqVuxqENM1F/jBiOxXJ3hB6
         uQ6tOTsuaZ1niqe2R8tD8xc98WPwZd2Ja80MNPXNuW1jDHdtxr7F/2WvJWoZoRPJeG
         deMKFLxHvkT35+ay0BQHJrCbz8aDhaDnqVb21+lb1R8L9INmLmBhSaKNTfiFNGOINr
         ysffzWeYBDawkmxYoTvFgWgtSeyScMA900P1Eoko2S7bfTrJMfCcTj+AVEafeuBKXw
         MoOjF9MgB9pFA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B0FF440647; Sat,  6 Mar 2021 16:28:22 -0300 (-03)
Date:   Sat, 6 Mar 2021 16:28:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Gon Solo <gonsolo@gmail.com>
Cc:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Perf: Clean generated directory, other archs.
Message-ID: <YEPX1oaV6vz5FW05@kernel.org>
References: <20210303183247.217385-1-gonsolo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303183247.217385-1-gonsolo@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 03, 2021 at 07:32:46PM +0100, Gon Solo escreveu:


You forgot to add an explanation here and to add your:

Signed-off-by: Gon Solo <gonsolo@gmail.com>

In this case a:

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>

Is also appropriate, since I pointed you in this direction.

Please take a look at:

Documentation/process/submitting-patches.rst

Direct link for your convenience:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst

Thanks for working on this!

- Arnaldo

> ---
>  tools/perf/arch/arm64/Makefile   | 5 +++--
>  tools/perf/arch/powerpc/Makefile | 5 +++--
>  tools/perf/arch/s390/Makefile    | 5 +++--
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
> index fab3095fb5d0..426aecdd0b71 100644
> --- a/tools/perf/arch/arm64/Makefile
> +++ b/tools/perf/arch/arm64/Makefile
> @@ -10,7 +10,8 @@ HAVE_KVM_STAT_SUPPORT := 1
>  # Syscall table generation for perf
>  #
>  
> -out    := $(OUTPUT)arch/arm64/include/generated/asm
> +generated := $(OUTPUT)arch/arm64/include/generated
> +out    := $(generated)/asm
>  header := $(out)/syscalls.c
>  incpath := $(srctree)/tools
>  sysdef := $(srctree)/tools/arch/arm64/include/uapi/asm/unistd.h
> @@ -24,6 +25,6 @@ $(header): $(sysdef) $(systbl)
>  	$(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(incpath) $(sysdef) > $@
>  
>  clean::
> -	$(call QUIET_CLEAN, arm64) $(RM) $(header)
> +	$(call QUIET_CLEAN, arm64) $(RM) -r $(header) $(generated)
>  
>  archheaders: $(header)
> diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
> index 840ea0e59287..979c2bebc167 100644
> --- a/tools/perf/arch/powerpc/Makefile
> +++ b/tools/perf/arch/powerpc/Makefile
> @@ -11,7 +11,8 @@ PERF_HAVE_JITDUMP := 1
>  # Syscall table generation for perf
>  #
>  
> -out    := $(OUTPUT)arch/powerpc/include/generated/asm
> +generated := $(OUTPUT)arch/powerpc/include/generated
> +out    := $(generated)/asm
>  header32 := $(out)/syscalls_32.c
>  header64 := $(out)/syscalls_64.c
>  sysprf := $(srctree)/tools/perf/arch/powerpc/entry/syscalls
> @@ -28,6 +29,6 @@ $(header32): $(sysdef) $(systbl)
>  	$(Q)$(SHELL) '$(systbl)' '32' $(sysdef) > $@
>  
>  clean::
> -	$(call QUIET_CLEAN, powerpc) $(RM) $(header32) $(header64)
> +	$(call QUIET_CLEAN, powerpc) $(RM) -r $(header32) $(header64) $(generated)
>  
>  archheaders: $(header32) $(header64)
> diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makefile
> index 74bffbea03e2..27cf67f1cc78 100644
> --- a/tools/perf/arch/s390/Makefile
> +++ b/tools/perf/arch/s390/Makefile
> @@ -10,7 +10,8 @@ PERF_HAVE_JITDUMP := 1
>  # Syscall table generation for perf
>  #
>  
> -out    := $(OUTPUT)arch/s390/include/generated/asm
> +generated := $(OUTPUT)arch/s390/include/generated
> +out    := $(generated)/asm
>  header := $(out)/syscalls_64.c
>  sysprf := $(srctree)/tools/perf/arch/s390/entry/syscalls
>  sysdef := $(sysprf)/syscall.tbl
> @@ -23,6 +24,6 @@ $(header): $(sysdef) $(systbl)
>  	$(Q)$(SHELL) '$(systbl)' $(sysdef) > $@
>  
>  clean::
> -	$(call QUIET_CLEAN, s390) $(RM) $(header)
> +	$(call QUIET_CLEAN, s390) $(RM) -r $(header) $(generted)
>  
>  archheaders: $(header)
> -- 
> 2.27.0
> 

-- 

- Arnaldo
