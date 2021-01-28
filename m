Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EDC30728A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 10:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbhA1JWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 04:22:08 -0500
Received: from foss.arm.com ([217.140.110.172]:55028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232471AbhA1JRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 04:17:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DF2D1042;
        Thu, 28 Jan 2021 01:16:42 -0800 (PST)
Received: from [192.168.0.17] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA7D73F766;
        Thu, 28 Jan 2021 01:16:40 -0800 (PST)
Subject: Re: [PATCH V3 08/14] coresight: core: Add support for dedicated
 percpu sinks
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        lcherian@marvell.com, linux-kernel@vger.kernel.org
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-9-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <dce24164-d35b-d9d9-2fcd-e50a1bac0b38@arm.com>
Date:   Thu, 28 Jan 2021 09:16:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1611737738-1493-9-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/21 8:55 AM, Anshuman Khandual wrote:
> Add support for dedicated sinks that are bound to individual CPUs. (e.g,
> TRBE). To allow quicker access to the sink for a given CPU bound source,
> keep a percpu array of the sink devices. Also, add support for building
> a path to the CPU local sink from the ETM.
> 
> This adds a new percpu sink type CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM.
> This new sink type is exclusively available and can only work with percpu
> source type device CORESIGHT_DEV_SUBTYPE_SOURCE_PERCPU_PROC.
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
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Changes in V3:
> 
> - Updated coresight_find_default_sink()
> 
>   drivers/hwtracing/coresight/coresight-core.c | 16 ++++++++++++++--
>   include/linux/coresight.h                    | 12 ++++++++++++
>   2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 0062c89..4795e28 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -23,6 +23,7 @@
>   #include "coresight-priv.h"
>   
>   static DEFINE_MUTEX(coresight_mutex);
> +DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
>   
>   /**
>    * struct coresight_node - elements of a path, from source to sink
> @@ -784,6 +785,13 @@ static int _coresight_build_path(struct coresight_device *csdev,
>   	if (csdev == sink)
>   		goto out;
>   
> +	if (coresight_is_percpu_source(csdev) && coresight_is_percpu_sink(sink) &&
> +	    sink == per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev))) {
> +		_coresight_build_path(sink, sink, path);
> +		found = true;
> +		goto out;
> +	}
> +
>   	/* Not a sink - recursively explore each port found on this element */
>   	for (i = 0; i < csdev->pdata->nr_outport; i++) {
>   		struct coresight_device *child_dev;
> @@ -999,8 +1007,12 @@ coresight_find_default_sink(struct coresight_device *csdev)
>   	int depth = 0;
>   
>   	/* look for a default sink if we have not found for this device */
> -	if (!csdev->def_sink)
> -		csdev->def_sink = coresight_find_sink(csdev, &depth);
> +	if (!csdev->def_sink) {
> +		if (coresight_is_percpu_source(csdev))
> +			csdev->def_sink = per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev));
> +		if (!csdev->def_sink)
> +			csdev->def_sink = coresight_find_sink(csdev, &depth);
> +	}
>   	return csdev->def_sink;
>   }
>   
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 976ec26..bc3a5ca 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -50,6 +50,7 @@ enum coresight_dev_subtype_sink {
>   	CORESIGHT_DEV_SUBTYPE_SINK_PORT,
>   	CORESIGHT_DEV_SUBTYPE_SINK_BUFFER,
>   	CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM,
> +	CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM,
>   };
>   
>   enum coresight_dev_subtype_link {
> @@ -428,6 +429,17 @@ static inline void csdev_access_write64(struct csdev_access *csa, u64 val, u32 o
>   		csa->write(val, offset, false, true);
>   }
>   
> +static inline bool coresight_is_percpu_source(struct coresight_device *csdev)
> +{
> +	return csdev && (csdev->type == CORESIGHT_DEV_TYPE_SOURCE) &&
> +	       csdev->subtype.source_subtype == CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;

Please add () around the last line. Same below.

> +}
> +
> +static inline bool coresight_is_percpu_sink(struct coresight_device *csdev)
> +{
> +	return csdev && (csdev->type == CORESIGHT_DEV_TYPE_SINK) &&
> +	       csdev->subtype.sink_subtype == CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM;
> +}
>   #else	/* !CONFIG_64BIT */
>   
>   static inline u64 csdev_access_relaxed_read64(struct csdev_access *csa,
> 

With the above :

Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
