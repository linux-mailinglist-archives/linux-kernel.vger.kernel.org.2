Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612D3330B51
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhCHKfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:35:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60636 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230125AbhCHKfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:35:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615199709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nclqJ27m5QoP4UshNB90N0ys4ZVj0yjmV7Cz+sGl5Fc=;
        b=cMpprt4fQgrhZr1zXW81xq+awI7vNqOuduS85K14PxDDLeYQCiB4GyOlNyTXHceQtBXinH
        3qIMFpTr5ngjhLbm7QUHQ3/uILHSTLtnUWsVfz1sTY37fB0DgbKTLinFqNeZZsjfQEhqeB
        8g24qJUoWgpWTwJAzTcWtaOl1CunvSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-uqxMuZlWPayLI_3d_vfKxA-1; Mon, 08 Mar 2021 05:35:05 -0500
X-MC-Unique: uqxMuZlWPayLI_3d_vfKxA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3446F57;
        Mon,  8 Mar 2021 10:35:03 +0000 (UTC)
Received: from krava (unknown [10.40.195.248])
        by smtp.corp.redhat.com (Postfix) with SMTP id 269C662460;
        Mon,  8 Mar 2021 10:35:00 +0000 (UTC)
Date:   Mon, 8 Mar 2021 11:35:00 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3] perf pmu: Validate raw event with sysfs exported
 format bits
Message-ID: <YEX91MTGMU41zeuF@krava>
References: <20210308031506.23019-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308031506.23019-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 11:15:06AM +0800, Jin Yao wrote:

SNIP

> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 44ef28302fc7..03ab1e6d0418 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1812,3 +1812,39 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
>  
>  	return nr_caps;
>  }
> +
> +void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
> +				   char *name)
> +{
> +	struct perf_pmu_format *format;
> +	__u64 masks = 0, bits;
> +	char buf[100];
> +	unsigned int i;
> +
> +	list_for_each_entry(format, &pmu->format, list)	{
> +		/*
> +		 * Skip extra configs such as config1/config2.
> +		 */
> +		if (format->value > 0)
> +			continue;

sorry I did not notice before, but could you please use more direct
approach like:

		if (format->value == PERF_PMU_FORMAT_VALUE_CONFIG) {
			break;
		}

this will be more obvious, also no need for the comment.. I spent some
time looking what's the value for ;-)

thanks,
jirka

> +
> +		for_each_set_bit(i, format->bits, PERF_PMU_FORMAT_BITS)
> +			masks |= 1ULL << i;
> +	}
> +
> +	/*
> +	 * Kernel doesn't export any valid format bits.
> +	 */
> +	if (masks == 0)
> +		return;
> +
> +	bits = config & ~masks;
> +	if (bits == 0)
> +		return;
> +
> +	bitmap_scnprintf((unsigned long *)&bits, sizeof(bits) * 8, buf, sizeof(buf));
> +
> +	pr_warning("WARNING: event '%s' not valid (bits %s of config "
> +		   "'%llx' not supported by kernel)!\n",
> +		   name ?: "N/A", buf, config);
> +}
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 8164388478c6..160b0f561771 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -123,4 +123,7 @@ int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
>  
>  int perf_pmu__caps_parse(struct perf_pmu *pmu);
>  
> +void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
> +				   char *name);
> +
>  #endif /* __PMU_H */
> -- 
> 2.17.1
> 

