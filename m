Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE4A35E6AD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347890AbhDMSt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 14:49:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232517AbhDMSty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:49:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF901613C6;
        Tue, 13 Apr 2021 18:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618339774;
        bh=wYkKKVWaV5MT0O2LXlGiSblzZfxfI4vkyY6nXvYKl88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dx03v8Ttt5/8ikl5S6g9M7JWtqavVmUfcu5v4bvNyjFfbD5LeOJ9JMLPp7ix7D2wp
         8+lpQ/tMWE0li7Uh9TWYrhVm8f8o6tqMXeZE6Ztdbho16w1AxFrljmFGuSoLv6tqOV
         7+Mh5GO73JMY9bGgY8i+IEzkfgwgoVQK5TmTqiyF3Kzgz3ZEN77mLqPmUVGYVkw/SZ
         8gMcxeGXB7r7HPc1kylypKBIzBRz4kQOD1paOGgJUuBQexlRk6WHr3deyQTCYnZcWF
         UGPhV8LEFzXqhONYF/boyALE1uh9fRL4phXiYJ6d9+ZafyH9ycDsbmqM2Rn5LoXndh
         pk6I8AwsF4DkA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3241A40647; Tue, 13 Apr 2021 15:49:31 -0300 (-03)
Date:   Tue, 13 Apr 2021 15:49:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: Re: [PATCH v7 3/4] libperf: tests: Add support for verbose printing
Message-ID: <YHXnu2xRzPpaI3cn@kernel.org>
References: <20210413171606.1825808-1-robh@kernel.org>
 <20210413171606.1825808-4-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413171606.1825808-4-robh@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 13, 2021 at 12:16:05PM -0500, Rob Herring escreveu:
> Add __T_VERBOSE() so tests can add verbose output. The verbose output is
> enabled with the '-v' command line option.

You forgot to show how this is used, I'm trying:

  # cd tools/lib/perf
  # sudo make tests

So how from the command line one asks for verbose output from the tests?

  Should be:

  # sudo make tests V=1

?

The default output, non-verbose, is:

[acme@five perf]$ sudo make tests
  LINK     test-cpumap-a
  LINK     test-threadmap-a
  LINK     test-evlist-a
  LINK     test-evsel-a
  LINK     test-cpumap-so
  LINK     test-threadmap-so
  LINK     test-evlist-so
  LINK     test-evsel-so
running static:
- running test-cpumap.c...OK
- running test-threadmap.c...OK
- running test-evlist.c...OK
- running test-evsel.c...OK
running dynamic:
- running test-cpumap.c...OK
- running test-threadmap.c...OK
- running test-evlist.c...OK
- running test-evsel.c...OK
[acme@five perf]$

Trying a verbose mode:

[acme@five perf]$ sudo make tests V=1
make -f /home/acme/git/perf/tools/build/Makefile.build dir=. obj=libperf
make -C /home/acme/git/perf/tools/lib/api/ O= libapi.a
make -f /home/acme/git/perf/tools/build/Makefile.build dir=./fd obj=libapi
make -f /home/acme/git/perf/tools/build/Makefile.build dir=./fs obj=libapi
make -C tests
gcc -I/home/acme/git/perf/tools/lib/perf/include -I/home/acme/git/perf/tools/include -I/home/acme/git/perf/tools/lib -g -Wall -o test-cpumap-a test-cpumap.c ../libperf.a /home/acme/git/perf/tools/lib/api/libapi.a
gcc -I/home/acme/git/perf/tools/lib/perf/include -I/home/acme/git/perf/tools/include -I/home/acme/git/perf/tools/lib -g -Wall -o test-threadmap-a test-threadmap.c ../libperf.a /home/acme/git/perf/tools/lib/api/libapi.a
gcc -I/home/acme/git/perf/tools/lib/perf/include -I/home/acme/git/perf/tools/include -I/home/acme/git/perf/tools/lib -g -Wall -o test-evlist-a test-evlist.c ../libperf.a /home/acme/git/perf/tools/lib/api/libapi.a
gcc -I/home/acme/git/perf/tools/lib/perf/include -I/home/acme/git/perf/tools/include -I/home/acme/git/perf/tools/lib -g -Wall -o test-evsel-a test-evsel.c ../libperf.a /home/acme/git/perf/tools/lib/api/libapi.a
gcc -I/home/acme/git/perf/tools/lib/perf/include -I/home/acme/git/perf/tools/include -I/home/acme/git/perf/tools/lib -g -Wall -L.. -o test-cpumap-so test-cpumap.c /home/acme/git/perf/tools/lib/api/libapi.a -lperf
gcc -I/home/acme/git/perf/tools/lib/perf/include -I/home/acme/git/perf/tools/include -I/home/acme/git/perf/tools/lib -g -Wall -L.. -o test-threadmap-so test-threadmap.c /home/acme/git/perf/tools/lib/api/libapi.a -lperf
gcc -I/home/acme/git/perf/tools/lib/perf/include -I/home/acme/git/perf/tools/include -I/home/acme/git/perf/tools/lib -g -Wall -L.. -o test-evlist-so test-evlist.c /home/acme/git/perf/tools/lib/api/libapi.a -lperf
gcc -I/home/acme/git/perf/tools/lib/perf/include -I/home/acme/git/perf/tools/include -I/home/acme/git/perf/tools/lib -g -Wall -L.. -o test-evsel-so test-evsel.c /home/acme/git/perf/tools/lib/api/libapi.a -lperf
make -C tests run
running static:
- running test-cpumap.c...OK
- running test-threadmap.c...OK
- running test-evlist.c...OK
- running test-evsel.c...OK
running dynamic:
- running test-cpumap.c...OK
- running test-threadmap.c...OK
- running test-evlist.c...OK
- running test-evsel.c...OK
[acme@five perf]$


I'm only getting a move verbose output for the Makefile steps, not from
the actual tests.

Perhaps if I read the last cset... will do that now.

- Arnaldo
 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v5:
>  - Pass verbose flag to static tests
>  - Fix getopt loop with unsigned char (arm64)
> v3:
>  - New patch
> ---
>  tools/lib/perf/include/internal/tests.h | 32 +++++++++++++++++++++++++
>  tools/lib/perf/tests/Makefile           |  6 +++--
>  2 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/perf/include/internal/tests.h b/tools/lib/perf/include/internal/tests.h
> index 2093e8868a67..29425c2dabe1 100644
> --- a/tools/lib/perf/include/internal/tests.h
> +++ b/tools/lib/perf/include/internal/tests.h
> @@ -3,11 +3,32 @@
>  #define __LIBPERF_INTERNAL_TESTS_H
>  
>  #include <stdio.h>
> +#include <unistd.h>
>  
>  int tests_failed;
> +int tests_verbose;
> +
> +static inline int get_verbose(char **argv, int argc)
> +{
> +	int c;
> +	int verbose = 0;
> +
> +	while ((c = getopt(argc, argv, "v")) != -1) {
> +		switch (c)
> +		{
> +		case 'v':
> +			verbose = 1;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +	return verbose;
> +}
>  
>  #define __T_START					\
>  do {							\
> +	tests_verbose = get_verbose(argv, argc);	\
>  	fprintf(stdout, "- running %s...", __FILE__);	\
>  	fflush(NULL);					\
>  	tests_failed = 0;				\
> @@ -30,4 +51,15 @@ do {
>  	}                                                                        \
>  } while (0)
>  
> +#define __T_VERBOSE(...)						\
> +do {									\
> +	if (tests_verbose) {						\
> +		if (tests_verbose == 1) {				\
> +			fputc('\n', stderr);				\
> +			tests_verbose++;				\
> +		}							\
> +		fprintf(stderr, ##__VA_ARGS__);				\
> +	}								\
> +} while (0)
> +
>  #endif /* __LIBPERF_INTERNAL_TESTS_H */
> diff --git a/tools/lib/perf/tests/Makefile b/tools/lib/perf/tests/Makefile
> index 96841775feaf..b536cc9a26dd 100644
> --- a/tools/lib/perf/tests/Makefile
> +++ b/tools/lib/perf/tests/Makefile
> @@ -5,6 +5,8 @@ TESTS = test-cpumap test-threadmap test-evlist test-evsel
>  TESTS_SO := $(addsuffix -so,$(TESTS))
>  TESTS_A  := $(addsuffix -a,$(TESTS))
>  
> +TEST_ARGS := $(if $(V),-v)
> +
>  # Set compile option CFLAGS
>  ifdef EXTRA_CFLAGS
>    CFLAGS := $(EXTRA_CFLAGS)
> @@ -28,9 +30,9 @@ all: $(TESTS_A) $(TESTS_SO)
>  
>  run:
>  	@echo "running static:"
> -	@for i in $(TESTS_A); do ./$$i; done
> +	@for i in $(TESTS_A); do ./$$i $(TEST_ARGS); done
>  	@echo "running dynamic:"
> -	@for i in $(TESTS_SO); do LD_LIBRARY_PATH=../ ./$$i; done
> +	@for i in $(TESTS_SO); do LD_LIBRARY_PATH=../ ./$$i $(TEST_ARGS); done
>  
>  clean:
>  	$(call QUIET_CLEAN, tests)$(RM) $(TESTS_A) $(TESTS_SO)
> -- 
> 2.27.0
> 

-- 

- Arnaldo
