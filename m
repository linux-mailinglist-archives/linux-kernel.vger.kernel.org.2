Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136AA3692F2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 15:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242542AbhDWNU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 09:20:59 -0400
Received: from foss.arm.com ([217.140.110.172]:34716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231169AbhDWNU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:20:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D140F1396;
        Fri, 23 Apr 2021 06:20:21 -0700 (PDT)
Received: from [10.57.67.211] (unknown [10.57.67.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 112CF3F73B;
        Fri, 23 Apr 2021 06:20:19 -0700 (PDT)
Subject: Re: [PATCH v1] coresight: add node to reset all coresight devices
To:     Tao Zhang <taozha@codeaurora.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        Yuanfang Zhang <zhangyuanfang@codeaurora.org>
References: <1619166578-28690-1-git-send-email-taozha@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <e753898c-0334-cf84-620e-d9b9f18d87e7@arm.com>
Date:   Fri, 23 Apr 2021 14:20:18 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1619166578-28690-1-git-send-email-taozha@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2021 09:29, Tao Zhang wrote:
> Add new reset_source_sink node to be able to disable all active
> coresight devices.
> In this way, we no longer need to manually disable all active
> coresight devices one by one. After enabling multiple coresight
> paths, users can reset their status more conveniently by this
> node.
> 

What is the use case here ? Why would you trigger a reset for all the
sources/sink without gracefully completing any on-going sessions
(including the perf ones, which are driven by the kernel perf layer)

> This patch base on coresight-next repo
> http://git.linaro.org/kernel/coresight.git/log/?h=next
> 
> And this patch depends on the following patch
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2551216.html

Please post related patches as a series, possibly describing the overall
problem that you are trying to solve, in the cover letter.

> 
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> Signed-off-by: Mao Jinlong <jinlmao@codeaurora.org>
> Signed-off-by: Tao Zhang <taozha@codeaurora.org>
> ---
>   drivers/hwtracing/coresight/coresight-core.c | 72 ++++++++++++++++++++++++----
>   1 file changed, 64 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 7dfadb6..0001b6c 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -107,6 +107,23 @@ static int coresight_source_is_unique(struct coresight_device *csdev)
>   				 csdev, coresight_id_match);
>   }
>   
> +static int coresight_reset_sink(struct device *dev, void *data)
> +{
> +	struct coresight_device *csdev = to_coresight_device(dev);
> +
> +	if ((csdev->type == CORESIGHT_DEV_TYPE_SINK ||
> +	     csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) &&
> +	     csdev->activated)
> +		csdev->activated = false;

Why is this needed, when the disabl_path() should have taken care of this ?

> +
> +	return 0;
> +}
> +
> +static void coresight_reset_all_sink(void)
> +{
> +	bus_for_each_dev(&coresight_bustype, NULL, NULL, coresight_reset_sink);
> +}
> +

How can you disable all the active sinks when some of the sinks could be 
driven by perf ?

>   static int coresight_find_link_inport(struct coresight_device *csdev,
>   				      struct coresight_device *parent)
>   {
> @@ -1137,7 +1154,7 @@ int coresight_enable(struct coresight_device *csdev)
>   }
>   EXPORT_SYMBOL_GPL(coresight_enable);
>   
> -void coresight_disable(struct coresight_device *csdev)
> +static void __coresight_disable(struct coresight_device *csdev)
>   {
>   	int  ret;
>   	struct list_head *path = NULL;
> @@ -1145,14 +1162,12 @@ void coresight_disable(struct coresight_device *csdev)
>   	struct coresight_path *cspath_next = NULL;
>   	struct coresight_device *src_csdev = NULL;
>   
> -	mutex_lock(&coresight_mutex);
> -
>   	ret = coresight_validate_source(csdev, __func__);
>   	if (ret)
> -		goto out;
> +		return;
>   
>   	if (!csdev->enable || !coresight_disable_source(csdev))
> -		goto out;
> +		return;
>   
>   	list_for_each_entry_safe(cspath, cspath_next, &cs_active_paths, link) {
>   		src_csdev = coresight_get_source(cspath->path);
> @@ -1165,12 +1180,16 @@ void coresight_disable(struct coresight_device *csdev)
>   		}
>   	}
>   	if (path == NULL)
> -		goto out;
> +		return;
>   
>   	coresight_disable_path(path);
>   	coresight_release_path(path);
> +}
>   
> -out:
> +void coresight_disable(struct coresight_device *csdev)
> +{
> +	mutex_lock(&coresight_mutex);
> +	__coresight_disable(csdev);
>   	mutex_unlock(&coresight_mutex);
>   }
>   EXPORT_SYMBOL_GPL(coresight_disable);
> @@ -1467,7 +1486,43 @@ int coresight_timeout(void __iomem *addr, u32 offset, int position, int value)
>   
>   	return -EAGAIN;
>   }
> -EXPORT_SYMBOL_GPL(coresight_timeout);

Why ?

> +
> +static ssize_t reset_source_sink_store(struct bus_type *bus,
> +				       const char *buf, size_t size)
> +{
> +	int ret = 0;
> +	unsigned long val;
> +	struct coresight_path *cspath = NULL;
> +	struct coresight_path *cspath_next = NULL;
> +	struct coresight_device *csdev;
> +
> +	ret = kstrtoul(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&coresight_mutex);
> +
> +	list_for_each_entry_safe(cspath, cspath_next, &cs_active_paths, link) {
> +		csdev = coresight_get_source(cspath->path);
> +		if (!csdev)
> +			continue;
> +		atomic_set(csdev->refcnt, 1);

Is this safe ?

> +		__coresight_disable(csdev);
> +	}
> +
> +	/* Reset all activated sinks */
> +	coresight_reset_all_sink();
> +
> +	mutex_unlock(&coresight_mutex);
> +	return size;
> +}
> +static BUS_ATTR_WO(reset_source_sink);
> +
> +static struct attribute *coresight_reset_source_sink_attrs[] = {
> +	&bus_attr_reset_source_sink.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(coresight_reset_source_sink);
>   
>   /*
>    * coresight_release_platform_data: Release references to the devices connected
> @@ -1680,6 +1735,7 @@ EXPORT_SYMBOL_GPL(coresight_alloc_device_name);
>   
>   struct bus_type coresight_bustype = {
>   	.name	= "coresight",
> +	.bus_groups	= coresight_reset_source_sink_groups,
>   };
>   
>   static int __init coresight_init(void)
> 

