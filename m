Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD584081A7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 22:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbhILUrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 16:47:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20626 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236526AbhILUra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 16:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631479575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wiP1xNtUHVwwciV2F+1NqLRf0YwJlesW+uA61sYdohg=;
        b=DzyPTrSDMDzIuli0NwOsaja6U1ROoWN3bj42Mp6rKKfAo4Dux5P3eb1CekVVJYWbtpDT2C
        +6zN1eXgAKtCkBocEecoLTq8/1F5epzmuEvd03kKWbbiv+6R/pbzoNmo7ne2NtVBZQ7A6G
        St6gIl01o6x/zlLNiSl2JRBzsMwqYHw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-6B6pjCpdOGGJekjyLYVVdQ-1; Sun, 12 Sep 2021 16:46:14 -0400
X-MC-Unique: 6B6pjCpdOGGJekjyLYVVdQ-1
Received: by mail-ed1-f70.google.com with SMTP id y21-20020a056402359500b003cd0257fc7fso3859633edc.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 13:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wiP1xNtUHVwwciV2F+1NqLRf0YwJlesW+uA61sYdohg=;
        b=LYF57EaMh78RNq+Ryj8ehOHG2YI4MzzXC89MtOMIyqUTXWCmxGH8gfPcXGMt9zfHcU
         R/sM5R9qAVBIBIMNiN/JjUleoRMXClS4i8qGbotJ1sHaXJBscZhPhMqsyfcAXg00OAKk
         CGWfzdlkjzmLU+kLe8KpMjQNQ9K8diWT2tNvQA+ZDKP5fvYydEKBUdGk4vo6Gu77TCuf
         CMf5k8qAR0GRe0hVfSdLOMOXzzfF6DPvXsv0JnWoJlndLrW5/z97ZhfbPb7dqEJigHJG
         H3ZyYb2H1OytDSSSO4d9dMbd6MUcOZTTmP1BsTNL/lJasvu4IlsaGzeGxUN3d4X2UuE4
         +iRQ==
X-Gm-Message-State: AOAM533P5rbnRhmkfg2AOOGoCuOAJqgWpkmZnawKbE3QxHl5dsHhyrtA
        SAL1mmEKJigSsl1FQC6evhQhkwTAHPq3zerNjCrydJckAG5iJmcA+J4TTd/nzWPAT4Y1D5NhVwN
        aRfXZGeVG/lSqKVkZVeUl7NpY
X-Received: by 2002:a50:ae21:: with SMTP id c30mr9761876edd.120.1631479573236;
        Sun, 12 Sep 2021 13:46:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1JMX99OqvTVW6HnD69wCNvNkvNxgMvW3yKcLws7JO43mXhIJuk+2VjIqdyZnhBDVksK15ww==
X-Received: by 2002:a50:ae21:: with SMTP id c30mr9761855edd.120.1631479573060;
        Sun, 12 Sep 2021 13:46:13 -0700 (PDT)
Received: from krava ([83.240.60.52])
        by smtp.gmail.com with ESMTPSA id p21sm2429218ejm.88.2021.09.12.13.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:46:12 -0700 (PDT)
Date:   Sun, 12 Sep 2021 22:46:10 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: Re: [PATCH v11 08/24] perf record: Introduce data file at mmap
 buffer object
Message-ID: <YT5nEnJHE2Ec9eRn@krava>
References: <cover.1629186429.git.alexey.v.bayduraev@linux.intel.com>
 <c7a61ee2f342aaf7d940fa8e3876eae38837ce9a.1629186429.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7a61ee2f342aaf7d940fa8e3876eae38837ce9a.1629186429.git.alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 11:23:11AM +0300, Alexey Bayduraev wrote:
> Introduce data file and compressor objects into mmap object so
> they could be used to process and store data stream from the
> corresponding kernel data buffer. Make use of the introduced
> per mmap file and compressor when they are initialized and
> available.
> 
> Acked-by: Andi Kleen <ak@linux.intel.com>
> Acked-by: Namhyung Kim <namhyung@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/builtin-record.c |  3 +++
>  tools/perf/util/mmap.c      | 10 ++++++++++
>  tools/perf/util/mmap.h      |  3 +++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index fb1c1b46dd04..eff6f8db60b2 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -197,6 +197,9 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>  {
>  	struct perf_data_file *file = &rec->session->data->file;
>  
> +	if (map && map->file)
> +		file = map->file;

I understand this change, but not sure how it's related to the changes
below, should this be separated? also should this change be part of the
patch where we actually set map->file?

jirka

> +
>  	if (perf_data_file__write(file, bf, size) < 0) {
>  		pr_err("failed to write perf data, error: %m\n");
>  		return -1;
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index ab7108d22428..b693b828a840 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -230,6 +230,10 @@ void mmap__munmap(struct mmap *map)
>  {
>  	bitmap_free(map->affinity_mask.bits);
>  
> +#ifndef PYTHON_PERF
> +	zstd_fini(&map->zstd_data);
> +#endif
> +
>  	perf_mmap__aio_munmap(map);
>  	if (map->data != NULL) {
>  		munmap(map->data, mmap__mmap_len(map));
> @@ -291,6 +295,12 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
>  	map->core.flush = mp->flush;
>  
>  	map->comp_level = mp->comp_level;
> +#ifndef PYTHON_PERF
> +	if (zstd_init(&map->zstd_data, map->comp_level)) {
> +		pr_debug2("failed to init mmap commpressor, error %d\n", errno);
> +		return -1;
> +	}
> +#endif
>  
>  	if (map->comp_level && !perf_mmap__aio_enabled(map)) {
>  		map->data = mmap(NULL, mmap__mmap_len(map), PROT_READ|PROT_WRITE,
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index 9d5f589f02ae..c4aed6e89549 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -13,6 +13,7 @@
>  #endif
>  #include "auxtrace.h"
>  #include "event.h"
> +#include "util/compress.h"
>  
>  struct aiocb;
>  
> @@ -43,6 +44,8 @@ struct mmap {
>  	struct mmap_cpu_mask	affinity_mask;
>  	void		*data;
>  	int		comp_level;
> +	struct perf_data_file *file;
> +	struct zstd_data      zstd_data;
>  };
>  
>  struct mmap_params {
> -- 
> 2.19.0
> 

