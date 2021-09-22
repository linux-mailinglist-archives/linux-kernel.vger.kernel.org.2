Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008DE4152E7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 23:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbhIVVg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 17:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238033AbhIVVg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 17:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632346496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tkHP6mmjG7SBJfcpCC261TiUWmXihHKnsMoMGcToTiQ=;
        b=AGAWeiEqODphpUjFWRt4wwP/HxLrnj0KOg2CWFj+QB45CO01sj+kKQhQN7A1wfMVvRAxvP
        Z0qoPOabiUy3oYpBc/PV3RwHex8Z2UVlJSRELXG8bysMA7KxU8DyuyykE2hDQERycSHlTQ
        Ntm3Ci2Aqs33V4nfpihYCrBjrdVtA2g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-Ffs20lzvPCuLceU8QmO0ew-1; Wed, 22 Sep 2021 17:34:55 -0400
X-MC-Unique: Ffs20lzvPCuLceU8QmO0ew-1
Received: by mail-wr1-f72.google.com with SMTP id e1-20020adfa741000000b0015e424fdd01so3371205wrd.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 14:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tkHP6mmjG7SBJfcpCC261TiUWmXihHKnsMoMGcToTiQ=;
        b=VNh4jPj2CKGkc2Tx6cKuONL1EdMXdpvwqg2BFBBfBSN3oWLWhCEqMkZLqMDXBLvzof
         ej7Qu4LHOPNIQ7yOZ4wL4sVrhE9ITaRZT0tbuIILwnO5KKZ8uIGpWk6KXetjF6Kw+qc5
         pVcnrk6HDfH4bxS0rrlJQnZsC0/eOPh8LzI6RBcyRdasuvaZ/tTxwg/BMZ+dLDwx6CpU
         E5iylrctsyqxjSLxV5Mg+AnQyJtXVphJUxwhyJ1hbFyNE16PR4f0TWUAN1qzXiSwjC+U
         xWu9wjQWjsW8HTX4ej/tcAcggx+Aablq5eBed9xy6R9152J6iCMiqOtng0VN/V4Z166T
         11Tw==
X-Gm-Message-State: AOAM532z9aVUtcwVBHfrLyAspTcLs4YFmksW6dq/YgWcAognUD7XmEV6
        Llro6O7IwOUuf3mUNAlO1lg8WYg2Avk/aiWOYWwq0Y0p7dcEUrb2ZlMDCduweZNGxCgZ0lIupwR
        5hPVmCJl5VC5CYky370g5FrdO
X-Received: by 2002:a1c:4645:: with SMTP id t66mr1125847wma.130.1632346493722;
        Wed, 22 Sep 2021 14:34:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxd1RkKSZkPhwjIrnO7GuZSEPf5kCr25yr28k0XTQOtRFZvlE8bh9XkB8b5QIMw3larpzNauQ==
X-Received: by 2002:a1c:4645:: with SMTP id t66mr1125833wma.130.1632346493521;
        Wed, 22 Sep 2021 14:34:53 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id n186sm7105048wme.31.2021.09.22.14.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 14:34:53 -0700 (PDT)
Date:   Wed, 22 Sep 2021 23:34:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] libperf: Add processing to scale the counters
 obtained during the read() system call when multiplexing
Message-ID: <YUuhe7e0J0PSea+b@krava>
References: <20210922101627.3396398-1-nakamura.shun@fujitsu.com>
 <20210922101627.3396398-2-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922101627.3396398-2-nakamura.shun@fujitsu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 07:16:26PM +0900, Shunsuke Nakamura wrote:
> From: nakamura shunsuke <nakamura.shun@fujitsu.com>
> 
> perf_evsel__read() scales counters obtained by RDPMC during multiplexing, but
> does not scale counters obtained by read() system call.
> 
> Add processing to perf_evsel__read() to scale the counters obtained during the
> read() system call when multiplexing.
> 
> 
> Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> ---
>  tools/lib/perf/evsel.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 8441e3e1aaac..0ebd1d34436f 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -18,6 +18,7 @@
>  #include <sys/ioctl.h>
>  #include <sys/mman.h>
>  #include <asm/bug.h>
> +#include <linux/math64.h>
>  
>  void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
>  		      int idx)
> @@ -321,6 +322,11 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
>  	if (readn(*fd, count->values, size) <= 0)
>  		return -errno;
>  
> +	if (count->ena != count->run) {
> +		if (count->run != 0)
> +			count->val = mul_u64_u64_div64(count->val, count->ena, count->run);
> +	}

so I think perf stat expect raw values in there and does the
scaling by itself, please check following code:

read_counters
  read_affinity_counters
    read_counter_cpu
      read_single_counter
        evsel__read_counter

  perf_stat_process_counter
    process_counter_maps
      process_counter_values
        perf_counts_values__scale


perhaps we could export perf_counts_values__scale if it'd be any help

jirka


> +
>  	return 0;
>  }
>  
> -- 
> 2.27.0
> 

