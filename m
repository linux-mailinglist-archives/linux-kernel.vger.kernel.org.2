Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB914607C6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 18:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358551AbhK1RDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 12:03:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35862 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353742AbhK1RBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 12:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638118681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tpGHUKYpaVNMq1Y1Pd0vJp6cIrA5ck5KtEzHZ7z/FWA=;
        b=P8mePlWWEXaQlSemS+fCDHX1I6HZsgq35W9gVdmU6N0MMaAGIO8HEJszCiG9nX+pJPbfU7
        OyUXiAo4TGV1fwXULa60SJnmynaYvmZIdHfcoMBo7pLxjS119lYOTOXjPfag+P8WKPHu0/
        JWpueewJDyhdwUBvyZM9/ZinhR7uO4Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-LPh8gTRSPE6FTawHBb8HZA-1; Sun, 28 Nov 2021 11:58:00 -0500
X-MC-Unique: LPh8gTRSPE6FTawHBb8HZA-1
Received: by mail-wm1-f71.google.com with SMTP id r129-20020a1c4487000000b00333629ed22dso10531579wma.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 08:57:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tpGHUKYpaVNMq1Y1Pd0vJp6cIrA5ck5KtEzHZ7z/FWA=;
        b=qmYIu3gznjcYmuWkmIdwyHV5Yipk1u0qD99L7ZNUciLCKfzfmZRJpHAw6rIBEul7Fz
         UyB/5LVTLvTdX9CNXvEZ1xHo4oYV7pc0zpU7V/+WADmxJEszhcnx7rahQwj8LGPgvDmR
         LC3Do+y1A1BZx+LPti6Z0LZC+q2CwrrQNYSL1c78Ux1TiRDg1XoiM/5ij26o2cFIYhET
         eLYb5NLBApD6fehjXOql+rTyc9nnm0M6bXtMBA5iTmXmHeAdbJ2a0ea8//jKe6sxsP3k
         ON8TcQKKXs1UM7RYgxwy+eINKzrF3WHIDw5N7TOJvTvE6YgP8pXiL8ruihZq07S4Blcg
         XPuQ==
X-Gm-Message-State: AOAM533xdZLoPyYZmOVtrpFeyT33rehdVt1REAJXsOqR2aKQvWAmLOlC
        Bv+67KDZmKEvbSS1TMIc6RUsrWDeh6uUHaefhDBegVpeOSVJB6x+3ItKs9fBLDTa/pwITVZvkbT
        kIo3WzSVL3geJz2OIH1EWY3GT
X-Received: by 2002:a5d:6da2:: with SMTP id u2mr27679712wrs.273.1638118678999;
        Sun, 28 Nov 2021 08:57:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzO+Uv4zcLBq6km16KM6CRY+H9R0szixLWE7fiDK/EVPKzwCJ9aJCnO1p7uvI44PAyiOCGEjA==
X-Received: by 2002:a5d:6da2:: with SMTP id u2mr27679699wrs.273.1638118678861;
        Sun, 28 Nov 2021 08:57:58 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id g18sm20503404wmq.4.2021.11.28.08.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 08:57:58 -0800 (PST)
Date:   Sun, 28 Nov 2021 17:57:56 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH 2/2] perf evsel: Improve error message for uncore events
Message-ID: <YaO1FIOYpF/Y5BDK@krava>
References: <20211123020341.3073673-1-irogers@google.com>
 <20211123020341.3073673-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123020341.3073673-2-irogers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 06:03:41PM -0800, Ian Rogers wrote:
> When a group has multiple events and the leader fails it can yield
> errors like:
> 
> $ perf stat -e '{uncore_imc/cas_count_read/},instructions' /bin/true
> Error:
> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (uncore_imc/cas_count_read/).
> /bin/dmesg | grep -i perf may provide additional information.
> 
> However, when not the group leader <not supported> is given:
> 
> $ perf stat -e '{instructions,uncore_imc/cas_count_read/}' /bin/true
> ...
>          1,619,057      instructions
>    <not supported> MiB  uncore_imc/cas_count_read/
> 
> This is necessary because get_group_fd will fail if the leader fails and
> is the direct result of the check on line 750 of builtin-stat.c in
> stat_handle_error that returns COUNTER_SKIP for the latter case.
> 
> This patch improves the error message to:
> 
> $ perf stat -e '{uncore_imc/cas_count_read/},instructions' /bin/true
> Error:
> Invalid event (uncore_imc/cas_count_read/) in per-thread mode, enable system wide with '-a'.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evsel.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a59fb2ecb84e..48696ff4bddb 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2950,6 +2950,11 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>  			return scnprintf(msg, size, "wrong clockid (%d).", clockid);
>  		if (perf_missing_features.aux_output)
>  			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
> +		if ((evsel__leader(evsel) == evsel) &&
> +		    (evsel->core.leader->nr_members > 1))
> +			return scnprintf(msg, size,
> +	"Invalid event (%s) in per-thread mode, enable system wide with '-a'.",
> +					evsel__name(evsel));

should we rather check 'target' pointer for the per-thread mode?
I'm not sure that per-thread mode will always be the case for the failure

jirka

>  		break;
>  	case ENODATA:
>  		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
> -- 
> 2.34.0.rc2.393.gf8c9666880-goog
> 

