Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD1633F957
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 20:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbhCQTb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 15:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbhCQTbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:31:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95AAC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 12:31:38 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so1890468pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 12:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gOINERHmieuwiuvM3DF70DRFGOBE0N4CRVVT5JEdKUI=;
        b=hdYVaEU8zYye5U51YYae9hQw/H5tgU5sTsFgUwWJMRIGDgXdKEILBxlSNnQcbhjOOw
         pdbVXjz5HGfp8c9ZICp3j9j4g8Ck4yqDDvCWrbxW/R2EqBcwJi6qzV1DxyqNjl9VS8lJ
         PWpfglBS1C0w4gcBXc9u97zXaWLQ3jj8uJXXA/EbRkFNRnxz9sus5S6p0LkljA97AHgA
         mJ2/pBXt1Q1J1FnHoB+jV4AR7EoA8O/p+22GwJZ73PEjYHHAKe2JCebs1sbzLOT/WM2z
         1PtVguMbrflgAUSlp9NwaKk017iKH9XuE1KshG80dWALPxlcVYsnajhWXd59Ft5vK277
         6MtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gOINERHmieuwiuvM3DF70DRFGOBE0N4CRVVT5JEdKUI=;
        b=eScTCsynQCvmjf70yzlGvhyyiNDWXmXpbtKMpsTuI+9Jvkxaan+a27XZ/1gQzUVSWA
         qfX3tHYN9FuqCjc5nihs85tLGUdufu+4krMxx3SiOry/+YpiUX1/TwJ43EEM32vad5gQ
         QFzD2yISJK4BnQ2/FE/4ddWwRsTyPE4CnD9nP26qYCNyUt8PorJQpSYclLMS+oGgTHp1
         rTYxVCKbd5vzppHAZtYINCNQqhPNPp637lv9Gkvpj2lKkqLG76If0pZtZW9fc4eSezKN
         ygC4Nuq+3z1XVQEXYYFvaIj9dZrJyRloY69sNziDDiilXrw8HuesOlAz/UqnRVJGiENu
         99MQ==
X-Gm-Message-State: AOAM533rhzz+HxtB/4biooz5Sn0NRf0eDCcsZWVXBoXS9EZK9XKOEyWh
        ybXw6Mekwkc5aJdhW34ffUGvug==
X-Google-Smtp-Source: ABdhPJxT4hcGV1+KfLJYucco05CI4nKXUvozud9Gj0nWBK8A9PDOHr4G+M5XxT94PDL+XqPBwrLUoA==
X-Received: by 2002:a17:90a:e00c:: with SMTP id u12mr393122pjy.133.1616009498414;
        Wed, 17 Mar 2021 12:31:38 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id s28sm21096325pfd.155.2021.03.17.12.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 12:31:37 -0700 (PDT)
Date:   Wed, 17 Mar 2021 13:31:36 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        leo.yan@linaro.org
Subject: Re: [PATCH v4 17/19] coresight: core: Add support for dedicated
 percpu sinks
Message-ID: <20210317193136.GB1498234@xps15>
References: <20210225193543.2920532-1-suzuki.poulose@arm.com>
 <20210225193543.2920532-18-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225193543.2920532-18-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 07:35:41PM +0000, Suzuki K Poulose wrote:
> From: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Add support for dedicated sinks that are bound to individual CPUs. (e.g,
> TRBE). To allow quicker access to the sink for a given CPU bound source,
> keep a percpu array of the sink devices. Also, add support for building
> a path to the CPU local sink from the ETM.
> 
> This adds a new percpu sink type CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM.
> This new sink type is exclusively available and can only work with percpu
> source type device CORESIGHT_DEV_SUBTYPE_SOURCE_PROC.
> 
> This defines a percpu structure that accommodates a single coresight_device
> which can be used to store an initialized instance from a sink driver. As
> these sinks are exclusively linked and dependent on corresponding percpu
> sources devices, they should also be the default sink device during a perf
> session.
> 
> Outwards device connections are scanned while establishing paths between a
> source and a sink device. But such connections are not present for certain
> percpu source and sink devices which are exclusively linked and dependent.
> Build the path directly and skip connection scanning for such devices.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> [Moved the set/get percpu sink APIs from TRBE patch to here]
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes:
>  - Export methods to set/get percpu sinks for fixing module
>    build for TRBE
>  - Addressed coding style comments (Suzuki)
>  - Check status of _coresight_build_path() (Mathieu)
> ---
>  drivers/hwtracing/coresight/coresight-core.c | 29 ++++++++++++++++++--
>  drivers/hwtracing/coresight/coresight-priv.h |  3 ++
>  include/linux/coresight.h                    | 12 ++++++++
>  3 files changed, 42 insertions(+), 2 deletions(-)

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 0062c8935653..55c645616bf6 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -23,6 +23,7 @@
>  #include "coresight-priv.h"
>  
>  static DEFINE_MUTEX(coresight_mutex);
> +DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
>  
>  /**
>   * struct coresight_node - elements of a path, from source to sink
> @@ -70,6 +71,18 @@ void coresight_remove_cti_ops(void)
>  }
>  EXPORT_SYMBOL_GPL(coresight_remove_cti_ops);
>  
> +void coresight_set_percpu_sink(int cpu, struct coresight_device *csdev)
> +{
> +	per_cpu(csdev_sink, cpu) = csdev;
> +}
> +EXPORT_SYMBOL_GPL(coresight_set_percpu_sink);
> +
> +struct coresight_device *coresight_get_percpu_sink(int cpu)
> +{
> +	return per_cpu(csdev_sink, cpu);
> +}
> +EXPORT_SYMBOL_GPL(coresight_get_percpu_sink);
> +
>  static int coresight_id_match(struct device *dev, void *data)
>  {
>  	int trace_id, i_trace_id;
> @@ -784,6 +797,14 @@ static int _coresight_build_path(struct coresight_device *csdev,
>  	if (csdev == sink)
>  		goto out;
>  
> +	if (coresight_is_percpu_source(csdev) && coresight_is_percpu_sink(sink) &&
> +	    sink == per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev))) {
> +		if (_coresight_build_path(sink, sink, path) == 0) {
> +			found = true;
> +			goto out;
> +		}
> +	}
> +
>  	/* Not a sink - recursively explore each port found on this element */
>  	for (i = 0; i < csdev->pdata->nr_outport; i++) {
>  		struct coresight_device *child_dev;
> @@ -999,8 +1020,12 @@ coresight_find_default_sink(struct coresight_device *csdev)
>  	int depth = 0;
>  
>  	/* look for a default sink if we have not found for this device */
> -	if (!csdev->def_sink)
> -		csdev->def_sink = coresight_find_sink(csdev, &depth);
> +	if (!csdev->def_sink) {
> +		if (coresight_is_percpu_source(csdev))
> +			csdev->def_sink = per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev));
> +		if (!csdev->def_sink)
> +			csdev->def_sink = coresight_find_sink(csdev, &depth);
> +	}
>  	return csdev->def_sink;
>  }
>  
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index f5f654ea2994..ff1dd2092ac5 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -232,4 +232,7 @@ coresight_find_csdev_by_fwnode(struct fwnode_handle *r_fwnode);
>  void coresight_set_assoc_ectdev_mutex(struct coresight_device *csdev,
>  				      struct coresight_device *ect_csdev);
>  
> +void coresight_set_percpu_sink(int cpu, struct coresight_device *csdev);
> +struct coresight_device *coresight_get_percpu_sink(int cpu);
> +
>  #endif
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 976ec2697610..8a3a3c199087 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -50,6 +50,7 @@ enum coresight_dev_subtype_sink {
>  	CORESIGHT_DEV_SUBTYPE_SINK_PORT,
>  	CORESIGHT_DEV_SUBTYPE_SINK_BUFFER,
>  	CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM,
> +	CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM,
>  };
>  
>  enum coresight_dev_subtype_link {
> @@ -428,6 +429,17 @@ static inline void csdev_access_write64(struct csdev_access *csa, u64 val, u32 o
>  		csa->write(val, offset, false, true);
>  }
>  
> +static inline bool coresight_is_percpu_source(struct coresight_device *csdev)
> +{
> +	return csdev && (csdev->type == CORESIGHT_DEV_TYPE_SOURCE) &&
> +	       (csdev->subtype.source_subtype == CORESIGHT_DEV_SUBTYPE_SOURCE_PROC);
> +}
> +
> +static inline bool coresight_is_percpu_sink(struct coresight_device *csdev)
> +{
> +	return csdev && (csdev->type == CORESIGHT_DEV_TYPE_SINK) &&
> +	       (csdev->subtype.sink_subtype == CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM);
> +}
>  #else	/* !CONFIG_64BIT */
>  
>  static inline u64 csdev_access_relaxed_read64(struct csdev_access *csa,
> -- 
> 2.24.1
> 
