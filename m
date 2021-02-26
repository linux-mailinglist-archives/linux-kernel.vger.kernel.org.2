Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B19326A78
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 00:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhBZXoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 18:44:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:52298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhBZXoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 18:44:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A93F364EFA;
        Fri, 26 Feb 2021 23:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614383019;
        bh=i7WhdFmzlA0mjbglH66rhrFN4DF/+qhTM2Vt766NUB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S1A5yegPefO3b+YCZaiNIItDKVdDuAFEVkQ1CEkQZ1Y1Yxo9LOSp7FzFctf4nRMnq
         Kpg/OYiNKELavhF66vmVO9GBp4jHi0ypFaGm8SlTm8inbw6XtqxXVaWVx/jvcrZYpb
         srDDx7pCc0MaIiyXqfRpkZHMZwMBhRNHV9nhTPJ9E9OijQhf+ssf61KVS/3AYrNk7C
         w7DuPy5fbTuXmFhPWQ4rOaeiw0LIIr81cNLIF3ebbndOYQr+o1cSnozr08QvrdwdWK
         y0e6Ngz4SQ9Y5/e37h6J7KgJ+Lqpg6Z5BpXa9ICf3TyzWyzylcbm6iLdedrPMk5sxK
         OY8RWawkBghbQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0A6EF40CD9; Fri, 26 Feb 2021 20:43:35 -0300 (-03)
Date:   Fri, 26 Feb 2021 20:43:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf tools: Move feature cleanup under tools/build
Message-ID: <YDmHpmsjj3lEcVBd@kernel.org>
References: <20210224150831.409639-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224150831.409639-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 24, 2021 at 04:08:31PM +0100, Jiri Olsa escreveu:
> Arnaldo reported issue for following build command:
> 
>   $ rm -rf /tmp/krava; mkdir /tmp/krava; make O=/tmp/krava clean
>     CLEAN    config
>   /bin/sh: line 0: cd: /tmp/krava/feature/: No such file or directory
>   ../../scripts/Makefile.include:17: *** output directory "/tmp/krava/feature/" does not exist.  Stop.
>   make[1]: *** [Makefile.perf:1010: config-clean] Error 2
>   make: *** [Makefile:90: clean] Error 2
> 
> The problem is that now that we include scripts/Makefile.include
> in feature's Makefile (which is fine and needed), we need to ensure
> the OUTPUT directory exists, before executing (out of tree) clean
> command.

Thanks, tested and applied.

- Arnaldo
 
> Removing the feature's cleanup from perf Makefile and fixing
> feature's cleanup under build Makefile, so it now checks that
> there's existing OUTPUT directory before calling the clean.
> 
> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Fixes: 211a741cd3e1 ("tools: Factor Clang, LLC and LLVM utils definitions")
> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/build/Makefile     |  8 +++++++-
>  tools/perf/Makefile.perf | 10 +---------
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/build/Makefile b/tools/build/Makefile
> index bae48e6fa995..5ed41b96fcde 100644
> --- a/tools/build/Makefile
> +++ b/tools/build/Makefile
> @@ -30,12 +30,18 @@ build     := -f $(srctree)/tools/build/Makefile.build dir=. obj
>  
>  all: $(OUTPUT)fixdep
>  
> +# Make sure there's anything to clean,
> +# feature contains check for existing OUTPUT
> +TMP_O := $(if $(OUTPUT),$(OUTPUT)/feature,./)
> +
>  clean:
>  	$(call QUIET_CLEAN, fixdep)
>  	$(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
>  	$(Q)rm -f $(OUTPUT)fixdep
>  	$(call QUIET_CLEAN, feature-detect)
> -	$(Q)$(MAKE) -C feature/ clean >/dev/null
> +ifneq ($(wildcard $(TMP_O)),)
> +	$(Q)$(MAKE) -C feature OUTPUT=$(TMP_O) clean >/dev/null
> +endif
>  
>  $(OUTPUT)fixdep-in.o: FORCE
>  	$(Q)$(MAKE) $(build)=fixdep
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 5345ac70cd83..536f6f90af92 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1001,14 +1001,6 @@ $(INSTALL_DOC_TARGETS):
>  
>  ### Cleaning rules
>  
> -#
> -# This is here, not in Makefile.config, because Makefile.config does
> -# not get included for the clean target:
> -#
> -config-clean:
> -	$(call QUIET_CLEAN, config)
> -	$(Q)$(MAKE) -C $(srctree)/tools/build/feature/ $(if $(OUTPUT),OUTPUT=$(OUTPUT)feature/,) clean >/dev/null
> -
>  python-clean:
>  	$(python-clean)
>  
> @@ -1048,7 +1040,7 @@ endif # BUILD_BPF_SKEL
>  bpf-skel-clean:
>  	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
>  
> -clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean config-clean fixdep-clean python-clean bpf-skel-clean
> +clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean
>  	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(LANG_BINDINGS)
>  	$(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
>  	$(Q)$(RM) $(OUTPUT).config-detected
> -- 
> 2.29.2
> 

-- 

- Arnaldo
