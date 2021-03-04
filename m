Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F0832DB15
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 21:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238849AbhCDUTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 15:19:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236405AbhCDUTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 15:19:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614889079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NcEeIM4rSQOyEW+04ey55syfNFH6fXFOkJ0byNZRhLc=;
        b=JP+q9C4wzOq9DtvS0ep5EHBNun3hf1zBVg76i7x9BnDbkqAwVktndhVvdfvP/o/q8XsceR
        H6WFwUNz9/vV9wM9qnQfbEmhoRfo1g56/bGyQrV3bfgLgPd0QJumA9Af/LbeoWumAUIgKZ
        9Jh09UFgQOXBPaEYPLo5a1QCzoXBzk8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-yGDbhkT-PQKrKN2212R9TQ-1; Thu, 04 Mar 2021 15:17:55 -0500
X-MC-Unique: yGDbhkT-PQKrKN2212R9TQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3690883DD21;
        Thu,  4 Mar 2021 20:17:54 +0000 (UTC)
Received: from krava (unknown [10.40.196.20])
        by smtp.corp.redhat.com (Postfix) with SMTP id 193ED100164C;
        Thu,  4 Mar 2021 20:17:51 +0000 (UTC)
Date:   Thu, 4 Mar 2021 21:17:51 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf pmu: Validate raw event with sysfs exported format
 bits
Message-ID: <YEFAb7Q7yhkw6g9s@krava>
References: <20210303051736.26974-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303051736.26974-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 01:17:36PM +0800, Jin Yao wrote:

SNIP

> The set bits in 'bits' indicate the invalid bits used in config.
> Finally use strbuf to report the invalid bits.
> 
> Some architectures may not export supported bits through sysfs,
> so if masks is 0, perf_pmu__config_valid just returns true.
> 
> After:
> 
> Single event:
> 
>   # ./perf stat -e cpu/r031234/ -a -- sleep 1
>   WARNING: event config '31234' not valid (bits 16 17 not supported by kernel)!
> 
>    Performance counter stats for 'system wide':
> 
>                    0      cpu/r031234/
> 
>          1.001403757 seconds time elapsed
> 
> Multiple events:
> 
>   # ./perf stat -e cpu/rf01234/,cpu/r031234/ -a -- sleep 1
>   WARNING: event config 'f01234' not valid (bits 20 22 not supported by kernel)!
>   WARNING: event config '31234' not valid (bits 16 17 not supported by kernel)!

right, seems useful

> 
>    Performance counter stats for 'system wide':
> 
>                    0      cpu/rf01234/
>                    0      cpu/r031234/
> 
> The warning is reported for invalid bits.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/parse-events.c | 11 ++++++++++
>  tools/perf/util/pmu.c          | 38 ++++++++++++++++++++++++++++++++++
>  tools/perf/util/pmu.h          |  4 ++++
>  3 files changed, 53 insertions(+)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 42c84adeb2fb..1820b2c0a241 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -356,6 +356,17 @@ __add_event(struct list_head *list, int *idx,
>  	struct perf_cpu_map *cpus = pmu ? perf_cpu_map__get(pmu->cpus) :
>  			       cpu_list ? perf_cpu_map__new(cpu_list) : NULL;
>  

if we want it just for raw/numeric, we could add it earlier on,
like to parse_events_add_numeric call

but perhaps it might be helpful to check any pmu event,
could perhaps reveal some broken format 

> +	if (pmu && attr->type == PERF_TYPE_RAW) {
> +		struct strbuf buf = STRBUF_INIT;
> +
> +		if (!perf_pmu__config_valid(pmu, attr->config, &buf)) {
> +			pr_warning("WARNING: event config '%llx' not valid ("
> +				   "bits%s not supported by kernel)!\n",
> +				   attr->config, buf.buf);
> +		}
> +		strbuf_release(&buf);
> +	}
> +
>  	if (init_attr)
>  		event_attr_init(attr);
>  
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 44ef28302fc7..5e361adb2698 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1812,3 +1812,41 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
>  
>  	return nr_caps;
>  }
> +
> +bool perf_pmu__config_valid(struct perf_pmu *pmu, __u64 config,
> +			    struct strbuf *buf)
> +{
> +	struct perf_pmu_format *format;
> +	__u64 masks = 0, bits;
> +	int i;
> +
> +	list_for_each_entry(format, &pmu->format, list)	{
> +		/*
> +		 * Skip extra configs such as config1/config2.
> +		 */
> +		if (format->value > 0)
> +			continue;
> +
> +		for_each_set_bit(i, format->bits, PERF_PMU_FORMAT_BITS)
> +			masks |= 1ULL << i;
> +	}
> +
> +	/*
> +	 * Kernel doesn't export any valid format bits.
> +	 */
> +	if (masks == 0)
> +		return true;
> +
> +	bits = config & ~masks;
> +	if (bits == 0)
> +		return true;

so in here you now that there's something wrong, so why
bother with the outside strbuf, when we can easily just
do all the printing in here?

> +
> +	for (i = 0; i < PERF_PMU_FORMAT_BITS; i++) {
> +		if (bits & 0x1)
> +			strbuf_addf(buf, " %d", i);
> +
> +		bits >>= 1;

could you use the for_each_set_bit in here?

thanks,
jirka

