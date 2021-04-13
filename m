Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4964B35E694
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348097AbhDMSjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 14:39:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347975AbhDMSjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:39:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E10E613C5;
        Tue, 13 Apr 2021 18:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618339167;
        bh=faK+eNmZ8G4HjvlBN68jFqX65PE7SsEn7a96rNi/7cg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AYYxOJ0ceOFNnoksXkcCP1APE3c35tAstDdtBPTRPxFdcn0aZrs/EEEEJK7l273Aj
         mzZkfot3vQyAfhdsMFvn/EFianh+ppAOQASaE5gdKjbvO8aq36mfifu6iidVwzS8/y
         8dWiiP2TTeJg+2+wLMjvP83e4KFj6Q2Ms0FCEFPAZW0VzQu+e4nC4WFiSTlaaCUYcQ
         LuA3JtCQei8dq3773vkkCqk8U9umX3ZhCBFzZciUh6RPwlPokwZvBp0Ngf3JKIRsC8
         iQ9zYmIniTinrD3/O6ftVSlhn5Dyvyz4XLX66uW1nr783zvsim/njl+ZkhlhUHawfF
         PGEqzabAcIVQw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7C43F40647; Tue, 13 Apr 2021 15:39:24 -0300 (-03)
Date:   Tue, 13 Apr 2021 15:39:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: Re: [PATCH v7 2/4] libperf: Add evsel mmap support
Message-ID: <YHXlXMd2Bp+90851@kernel.org>
References: <20210413171606.1825808-1-robh@kernel.org>
 <20210413171606.1825808-3-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413171606.1825808-3-robh@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 13, 2021 at 12:16:04PM -0500, Rob Herring escreveu:
> In order to support usersapce access, an event must be mmapped. While
> there's already mmap support for evlist, the usecase is a bit different
> than the self monitoring with userspace access. So let's add a new
> perf_evsel__mmap() function to mmap an evsel. This allows implementing
> userspace access as a fastpath for perf_evsel__read().
> 
> The mmapped address is returned by perf_evsel__mmap_base() which
> primarily for users/tests to check if userspace access is enabled.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v7:
>  - Add NULL fd check to perf_evsel__mmap
> v6:
>  - split mmap struct into it's own xyarray
> v5:
>  - Create an mmap for every underlying event opened. Due to this, we
>    need a different way to get the mmap ptr, so perf_evsel__mmap_base()
>    is introduced.
> v4:
>  - Change perf_evsel__mmap size to pages instead of bytes
> v3:
>  - New patch split out from user access patch
> ---
>  tools/lib/perf/Documentation/libperf.txt |  2 +
>  tools/lib/perf/evsel.c                   | 54 ++++++++++++++++++++++++
>  tools/lib/perf/include/internal/evsel.h  |  1 +
>  tools/lib/perf/include/perf/evsel.h      |  2 +
>  tools/lib/perf/libperf.map               |  2 +
>  5 files changed, 61 insertions(+)
> 
> diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> index 0c74c30ed23a..a2c73df191ca 100644
> --- a/tools/lib/perf/Documentation/libperf.txt
> +++ b/tools/lib/perf/Documentation/libperf.txt
> @@ -136,6 +136,8 @@ SYNOPSIS
>                         struct perf_thread_map *threads);
>    void perf_evsel__close(struct perf_evsel *evsel);
>    void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
> +  int perf_evsel__mmap(struct perf_evsel *evsel, int pages);
> +  void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread);
>    int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
>                         struct perf_counts_values *count);
>    int perf_evsel__enable(struct perf_evsel *evsel);
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 4dc06289f4c7..7e140763552f 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -11,10 +11,12 @@
>  #include <stdlib.h>
>  #include <internal/xyarray.h>
>  #include <internal/cpumap.h>
> +#include <internal/mmap.h>
>  #include <internal/threadmap.h>
>  #include <internal/lib.h>
>  #include <linux/string.h>
>  #include <sys/ioctl.h>
> +#include <sys/mman.h>
>  
>  void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
>  {
> @@ -38,6 +40,7 @@ void perf_evsel__delete(struct perf_evsel *evsel)
>  }
>  
>  #define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
> +#define MMAP(e, x, y) (e->mmap ? ((struct perf_mmap *) xyarray__entry(e->mmap, x, y)) : NULL)
>  
>  int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
>  {
> @@ -55,6 +58,13 @@ int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
>  	return evsel->fd != NULL ? 0 : -ENOMEM;
>  }
>  
> +static int perf_evsel__alloc_mmap(struct perf_evsel *evsel, int ncpus, int nthreads)
> +{
> +	evsel->mmap = xyarray__new(ncpus, nthreads, sizeof(struct perf_mmap));
> +
> +	return evsel->mmap != NULL ? 0 : -ENOMEM;
> +}
> +
>  static int
>  sys_perf_event_open(struct perf_event_attr *attr,
>  		    pid_t pid, int cpu, int group_fd,
> @@ -137,6 +147,8 @@ void perf_evsel__free_fd(struct perf_evsel *evsel)
>  {
>  	xyarray__delete(evsel->fd);
>  	evsel->fd = NULL;
> +	xyarray__delete(evsel->mmap);
> +	evsel->mmap = NULL;
>  }
>  
>  void perf_evsel__close(struct perf_evsel *evsel)
> @@ -156,6 +168,48 @@ void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu)
>  	perf_evsel__close_fd_cpu(evsel, cpu);
>  }
>  
> +int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
> +{
> +	int ret, cpu, thread;
> +	struct perf_mmap_param mp = {
> +		.prot = PROT_READ | PROT_WRITE,
> +		.mask = (pages * page_size) - 1,
> +	};
> +
> +	if (evsel->fd == NULL)
> +		return -EINVAL;
> +
> +	if (evsel->mmap == NULL &&
> +	    perf_evsel__alloc_mmap(evsel, xyarray__max_x(evsel->fd), xyarray__max_y(evsel->fd)) < 0)
> +		return -ENOMEM;
> +
> +	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
> +		for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
> +			int fd = FD(evsel, cpu, thread);
> +			struct perf_mmap *map = MMAP(evsel, cpu, thread);
> +
> +			if (fd < 0)
> +				continue;
> +
> +			perf_mmap__init(map, NULL, false, NULL);
> +
> +			ret = perf_mmap__mmap(map, &mp, fd, cpu);
> +			if (ret)
> +				return -1;
> +		}
> +	}
> +
> +	return 0;
> +}

Where is the counterpart? I.e. perf_evsel__munmap(), and it should be
called if perf_evsel__mmap() fails, right?

- Arnaldo

> +void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread)
> +{
> +	if (FD(evsel, cpu, thread) < 0 || MMAP(evsel, cpu, thread) == NULL)
> +		return NULL;
> +
> +	return MMAP(evsel, cpu, thread)->base;
> +}
> +
>  int perf_evsel__read_size(struct perf_evsel *evsel)
>  {
>  	u64 read_format = evsel->attr.read_format;
> diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
> index 1ffd083b235e..1c067d088bc6 100644
> --- a/tools/lib/perf/include/internal/evsel.h
> +++ b/tools/lib/perf/include/internal/evsel.h
> @@ -41,6 +41,7 @@ struct perf_evsel {
>  	struct perf_cpu_map	*own_cpus;
>  	struct perf_thread_map	*threads;
>  	struct xyarray		*fd;
> +	struct xyarray		*mmap;
>  	struct xyarray		*sample_id;
>  	u64			*id;
>  	u32			 ids;
> diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
> index c82ec39a4ad0..9f5265f2f39f 100644
> --- a/tools/lib/perf/include/perf/evsel.h
> +++ b/tools/lib/perf/include/perf/evsel.h
> @@ -27,6 +27,8 @@ LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *
>  				 struct perf_thread_map *threads);
>  LIBPERF_API void perf_evsel__close(struct perf_evsel *evsel);
>  LIBPERF_API void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
> +LIBPERF_API int perf_evsel__mmap(struct perf_evsel *evsel, int pages);
> +LIBPERF_API void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread);
>  LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
>  				 struct perf_counts_values *count);
>  LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
> diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> index 7be1af8a546c..0b993de15830 100644
> --- a/tools/lib/perf/libperf.map
> +++ b/tools/lib/perf/libperf.map
> @@ -23,6 +23,8 @@ LIBPERF_0.0.1 {
>  		perf_evsel__disable;
>  		perf_evsel__open;
>  		perf_evsel__close;
> +		perf_evsel__mmap;
> +		perf_evsel__mmap_base;
>  		perf_evsel__read;
>  		perf_evsel__cpus;
>  		perf_evsel__threads;
> -- 
> 2.27.0
> 

-- 

- Arnaldo
