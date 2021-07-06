Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2823BDE3E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 21:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhGFUBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 16:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229781AbhGFUBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 16:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625601500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AKyr7OEj24r1mpGOY586UciDza+JOs3ExGG+z5RqyrI=;
        b=buPna19l3kR58QijDdDxtgy+CckV3lIjvbWPMayN5eDyybw0qHqD9qF3+49zj80PsHI8k0
        Lje/RZAmw8GIobSkFYL1N2l2KBGRsiYlS9hscfAnZUC/YXo1I3oFyEs+3sP5itaRLkQYTY
        tCd7LaGd/CG6u/n3pJW4BW2ZrQpzz4g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-TrLyaPSkN6mAECru2Y_lFQ-1; Tue, 06 Jul 2021 15:58:19 -0400
X-MC-Unique: TrLyaPSkN6mAECru2Y_lFQ-1
Received: by mail-wr1-f70.google.com with SMTP id t12-20020adff04c0000b029013253c3389dso67704wro.7
        for <Linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 12:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AKyr7OEj24r1mpGOY586UciDza+JOs3ExGG+z5RqyrI=;
        b=rZRtJG2oPDp5EZV5BvQKpV41AfkIoYWT4I7qSXLnURZebOVOJhmXnKK7w4J8JBgVmP
         8mM3g3sUuq7JHovVst3Tf+Ptugxs1JVabqVgECmwPa3PIldZktcQaiJGKsu6KU/jrhdt
         UBLW7v3dwKwFyXNItiGPY51/IjLC61wZvVOmqTsp0RfIr3Q6ZRZT4llfQaFZO44xqb7g
         FwgZ/0wQiVvzA2Lr+SiRmzv0yjIOPX/FyD9kRhXQD/rrzbHo1cc4gSeKgQ3gGvudp0V1
         dUpFQDoQYF5KR7KnDcfmv4+KX1iZFgclCtojkmb/e4WHcnJgD5zpDMxLOfazDP7J3pUb
         sjOA==
X-Gm-Message-State: AOAM5318eGZdBxRaxG7f2IghYWgYlO5GN8/CqzRo5NHXU/EwpTiGx52L
        1WmEFGI10y10jcO9peUpsktpUqQXFZtvYqorPK5QfxtcOflAgyIEtg+4r241/TbZe4yNtK53T3F
        g+Og/L+icQ9+0LqLBUIqQoAFr
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr23387127wrn.226.1625601498436;
        Tue, 06 Jul 2021 12:58:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxagVpDNkJSrfonuLwtNYmVHZ5dcJDC8ukGdzgc0GnuVAtzcdxSgYGoaFOOVGqxhvNFybi3lw==
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr23387107wrn.226.1625601498244;
        Tue, 06 Jul 2021 12:58:18 -0700 (PDT)
Received: from krava ([185.153.78.55])
        by smtp.gmail.com with ESMTPSA id 16sm16244896wmk.18.2021.07.06.12.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 12:58:17 -0700 (PDT)
Date:   Tue, 6 Jul 2021 21:58:15 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf list: Skip the invalid hybrid pmu
Message-ID: <YOS1119y56eH0Uyv@krava>
References: <20210610051646.4003-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610051646.4003-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 01:16:46PM +0800, Jin Yao wrote:
> On hybrid platform, such as Alderlake, if atom CPUs are offlined,
> the kernel still exports the sysfs path '/sys/devices/cpu_atom/' for
> 'cpu_atom' pmu but the file '/sys/devices/cpu_atom/cpus' is empty,
> which indicates this is an invalid pmu.
> 
> The perf-list needs to check and skip the invalid hybrid pmu.
> 
> Before:
> 
>   # perf list
>   ...
>   branch-instructions OR cpu_atom/branch-instructions/ [Kernel PMU event]
>   branch-instructions OR cpu_core/branch-instructions/ [Kernel PMU event]
>   branch-misses OR cpu_atom/branch-misses/           [Kernel PMU event]
>   branch-misses OR cpu_core/branch-misses/           [Kernel PMU event]
>   bus-cycles OR cpu_atom/bus-cycles/                 [Kernel PMU event]
>   bus-cycles OR cpu_core/bus-cycles/                 [Kernel PMU event]
>   ...
> 
> The cpu_atom events are still displayed even if atom CPUs are offlined.
> 
> After:
> 
>   # perf list
>   ...
>   branch-instructions OR cpu_core/branch-instructions/ [Kernel PMU event]
>   branch-misses OR cpu_core/branch-misses/           [Kernel PMU event]
>   bus-cycles OR cpu_core/bus-cycles/                 [Kernel PMU event]
>   ...
> 
> Now only cpu_core events are displayed.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/pmu-hybrid.c | 11 +++++++++++
>  tools/perf/util/pmu-hybrid.h |  2 ++
>  tools/perf/util/pmu.c        |  3 +++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/tools/perf/util/pmu-hybrid.c b/tools/perf/util/pmu-hybrid.c
> index f51ccaac60ee..fcc1182f8fe5 100644
> --- a/tools/perf/util/pmu-hybrid.c
> +++ b/tools/perf/util/pmu-hybrid.c
> @@ -87,3 +87,14 @@ char *perf_pmu__hybrid_type_to_pmu(const char *type)
>  	free(pmu_name);
>  	return NULL;
>  }
> +
> +bool perf_pmu__is_invalid_hybrid(const char *name)
> +{
> +	if (strncmp(name, "cpu_", 4))
> +		return false;
> +
> +	if (perf_pmu__hybrid_mounted(name))
> +		return false;
> +
> +	return true;
> +}
> diff --git a/tools/perf/util/pmu-hybrid.h b/tools/perf/util/pmu-hybrid.h
> index 2b186c26a43e..8261a312c854 100644
> --- a/tools/perf/util/pmu-hybrid.h
> +++ b/tools/perf/util/pmu-hybrid.h
> @@ -30,4 +30,6 @@ static inline int perf_pmu__hybrid_pmu_num(void)
>  	return num;
>  }
>  
> +bool perf_pmu__is_invalid_hybrid(const char *name);
> +
>  #endif /* __PMU_HYBRID_H */
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 88c8ecdc60b0..281670e9c4bd 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1604,6 +1604,9 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
>  	pmu = NULL;
>  	j = 0;
>  	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
> +		if (perf_pmu__is_invalid_hybrid(pmu->name))
> +			continue;

hum why not detect it in pmu_lookup early on
and not add that pmu at all?

thanks,
jirka

> +
>  		list_for_each_entry(alias, &pmu->aliases, list) {
>  			char *name = alias->desc ? alias->name :
>  				format_alias(buf, sizeof(buf), pmu, alias);
> -- 
> 2.17.1
> 

