Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178E140D43F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 10:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbhIPIFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 04:05:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56995 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234948AbhIPIFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 04:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631779387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bZ0FCXOzP6c2zCLyHHAXO5rY0Lt3SSa8cnMTTAnyRbw=;
        b=ejkHI2TmDr2QSoeOX+NB4wH1gEtsQmo+jSgpMYaXbI/hvkpUEeI79WKUBBz2cN8mnN2ik8
        JxGnmG9CUH/aLgSsoBO6pdn1TGF4SA2p86JqR2P2MYH885ZS44Xh/Y+cMJpyEf1E9yAJuD
        Y/hFtgIfnYvsfaDwhfH0tQRZ6fNPvgc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-GbQv5e-nMjCd0x-TC2j70A-1; Thu, 16 Sep 2021 04:03:06 -0400
X-MC-Unique: GbQv5e-nMjCd0x-TC2j70A-1
Received: by mail-wm1-f72.google.com with SMTP id m4-20020a05600c3b0400b00303b904380dso2283344wms.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 01:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bZ0FCXOzP6c2zCLyHHAXO5rY0Lt3SSa8cnMTTAnyRbw=;
        b=mQMhvkWOHKirCKCUH25bBYLoW6H9tohzsN3HtFfDhi47Xlknf5vy4/eMqKF2ewRq3C
         mbDtlB28jC9FJ2mh+XtrDvUGmXa8k83loygm3hx8yH66aQXjXQlngNTTZqkgwk28eqLG
         v2yWo9a9Hcdg0ai9VfadpE2g0vfxel+9u/pSwBtBMtBAefvIjYEYZmj2XUGO8HKxr1oi
         xC1NYClTe9vmmwrWA6t6SdVMbR5Fg/CZXbj3ajuTm6jUOk3TsONFcfDRd0wtyaGXJ4Td
         JqY0MKqMdN7lEONQtCllxPCOiBav7s93f//keuXfpm07XAf1GP8gzBxZeEzOKIyYt3LS
         QO5g==
X-Gm-Message-State: AOAM533RbNyOkhMqd21xrgmydr34TNqXYlqfPOXZPhFksG4dRO3UPpwN
        Z4OUxEJa59UX3a86V3otjIAWHa2zIC09wKvjOGmdArEAnQ+CEo8twSxwTb/eUh7IFNEZ1XqLiRd
        IYRyDkovz0LdHN1cooMQvIqzo
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr3776591wmj.110.1631779384809;
        Thu, 16 Sep 2021 01:03:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw18IMWSmW/pHBzA7dkRKVOTtp0BTquaXG3HnDUE7BJ832AYBtvnnsjfO2DPVnkb3iVkbZ3VQ==
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr3776554wmj.110.1631779384444;
        Thu, 16 Sep 2021 01:03:04 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id c23sm2268239wmb.37.2021.09.16.01.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 01:03:04 -0700 (PDT)
Date:   Thu, 16 Sep 2021 10:03:02 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v2] libperf evsel: Make use of FD robust.
Message-ID: <YUL6NoeDwdZQ6gNz@krava>
References: <20210916062239.1894011-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916062239.1894011-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 11:22:39PM -0700, Ian Rogers wrote:

SNIP

> v2. is a rebase.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/evsel.c | 64 +++++++++++++++++++++++++++---------------
>  1 file changed, 41 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index d8886720e83d..ede7af4d183c 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -43,7 +43,7 @@ void perf_evsel__delete(struct perf_evsel *evsel)
>  	free(evsel);
>  }
>  
> -#define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
> +#define FD(e, x, y) (int *) xyarray__entry(e->fd, x, y)
>  #define MMAP(e, x, y) (e->mmap ? ((struct perf_mmap *) xyarray__entry(e->mmap, x, y)) : NULL)
>  
>  int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
> @@ -54,7 +54,10 @@ int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
>  		int cpu, thread;
>  		for (cpu = 0; cpu < ncpus; cpu++) {
>  			for (thread = 0; thread < nthreads; thread++) {
> -				FD(evsel, cpu, thread) = -1;
> +				int *fd = FD(evsel, cpu, thread);
> +
> +				if (fd)
> +					 *fd = -1;

so it's the perf_thread open that uses empty cpus and evlist__close
will have more cpus to work on

I'd expect some symetric fix on close path, but evlist__close is
generic, so it's probably the best fix ;-)

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka


>  			}
>  		}
>  	}
> @@ -80,7 +83,7 @@ sys_perf_event_open(struct perf_event_attr *attr,
>  static int get_group_fd(struct perf_evsel *evsel, int cpu, int thread, int *group_fd)
>  {
>  	struct perf_evsel *leader = evsel->leader;
> -	int fd;
> +	int *fd;
>  
>  	if (evsel == leader) {
>  		*group_fd = -1;
> @@ -95,10 +98,10 @@ static int get_group_fd(struct perf_evsel *evsel, int cpu, int thread, int *grou
>  		return -ENOTCONN;
>  
>  	fd = FD(leader, cpu, thread);
> -	if (fd == -1)
> +	if (fd == NULL || *fd == -1)
>  		return -EBADF;
>  
> -	*group_fd = fd;
> +	*group_fd = *fd;
>  
>  	return 0;
>  }
> @@ -138,7 +141,11 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
>  
>  	for (cpu = 0; cpu < cpus->nr; cpu++) {
>  		for (thread = 0; thread < threads->nr; thread++) {
> -			int fd, group_fd;
> +			int fd, group_fd, *evsel_fd;
> +
> +			evsel_fd = FD(evsel, cpu, thread);
> +			if (evsel_fd == NULL)
> +				return -EINVAL;
>  
>  			err = get_group_fd(evsel, cpu, thread, &group_fd);
>  			if (err < 0)
> @@ -151,7 +158,7 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
>  			if (fd < 0)
>  				return -errno;
>  
> -			FD(evsel, cpu, thread) = fd;
> +			*evsel_fd = fd;
>  		}
>  	}
>  
> @@ -163,9 +170,12 @@ static void perf_evsel__close_fd_cpu(struct perf_evsel *evsel, int cpu)
>  	int thread;
>  
>  	for (thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
> -		if (FD(evsel, cpu, thread) >= 0)
> -			close(FD(evsel, cpu, thread));
> -		FD(evsel, cpu, thread) = -1;
> +		int *fd = FD(evsel, cpu, thread);
> +
> +		if (fd && *fd >= 0) {
> +			close(*fd);
> +			*fd = -1;
> +		}
>  	}
>  }
>  
> @@ -209,13 +219,12 @@ void perf_evsel__munmap(struct perf_evsel *evsel)
>  
>  	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
>  		for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
> -			int fd = FD(evsel, cpu, thread);
> -			struct perf_mmap *map = MMAP(evsel, cpu, thread);
> +			int *fd = FD(evsel, cpu, thread);
>  
> -			if (fd < 0)
> +			if (fd == NULL || *fd < 0)
>  				continue;
>  
> -			perf_mmap__munmap(map);
> +			perf_mmap__munmap(MMAP(evsel, cpu, thread));
>  		}
>  	}
>  
> @@ -239,15 +248,16 @@ int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
>  
>  	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
>  		for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
> -			int fd = FD(evsel, cpu, thread);
> -			struct perf_mmap *map = MMAP(evsel, cpu, thread);
> +			int *fd = FD(evsel, cpu, thread);
> +			struct perf_mmap *map;
>  
> -			if (fd < 0)
> +			if (fd == NULL || *fd < 0)
>  				continue;
>  
> +			map = MMAP(evsel, cpu, thread);
>  			perf_mmap__init(map, NULL, false, NULL);
>  
> -			ret = perf_mmap__mmap(map, &mp, fd, cpu);
> +			ret = perf_mmap__mmap(map, &mp, *fd, cpu);
>  			if (ret) {
>  				perf_evsel__munmap(evsel);
>  				return ret;
> @@ -260,7 +270,9 @@ int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
>  
>  void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread)
>  {
> -	if (FD(evsel, cpu, thread) < 0 || MMAP(evsel, cpu, thread) == NULL)
> +	int *fd = FD(evsel, cpu, thread);
> +
> +	if (fd == NULL || *fd < 0 || MMAP(evsel, cpu, thread) == NULL)
>  		return NULL;
>  
>  	return MMAP(evsel, cpu, thread)->base;
> @@ -295,17 +307,18 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
>  		     struct perf_counts_values *count)
>  {
>  	size_t size = perf_evsel__read_size(evsel);
> +	int *fd = FD(evsel, cpu, thread);
>  
>  	memset(count, 0, sizeof(*count));
>  
> -	if (FD(evsel, cpu, thread) < 0)
> +	if (fd == NULL || *fd < 0)
>  		return -EINVAL;
>  
>  	if (MMAP(evsel, cpu, thread) &&
>  	    !perf_mmap__read_self(MMAP(evsel, cpu, thread), count))
>  		return 0;
>  
> -	if (readn(FD(evsel, cpu, thread), count->values, size) <= 0)
> +	if (readn(*fd, count->values, size) <= 0)
>  		return -errno;
>  
>  	return 0;
> @@ -318,8 +331,13 @@ static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
>  	int thread;
>  
>  	for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
> -		int fd = FD(evsel, cpu, thread),
> -		    err = ioctl(fd, ioc, arg);
> +		int err;
> +		int *fd = FD(evsel, cpu, thread);
> +
> +		if (fd || *fd < 0)
> +			return -1;
> +
> +		err = ioctl(*fd, ioc, arg);
>  
>  		if (err)
>  			return err;
> -- 
> 2.33.0.309.g3052b89438-goog
> 

