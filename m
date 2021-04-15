Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9852836062A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 11:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhDOJuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 05:50:03 -0400
Received: from foss.arm.com ([217.140.110.172]:41772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhDOJuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 05:50:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C399C1396;
        Thu, 15 Apr 2021 02:49:39 -0700 (PDT)
Received: from [10.57.27.217] (unknown [10.57.27.217])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7610F3F73B;
        Thu, 15 Apr 2021 02:49:32 -0700 (PDT)
Subject: Re: [PATCH] coresight: add support to enable more coresight paths
To:     Tao Zhang <taozha@codeaurora.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        Yuanfang Zhang <zhangyuanfang@codeaurora.org>,
        Satyajit Desai <sadesai@codeaurora.org>,
        Rama Aparna Mallavarapu <aparnam@codeaurora.org>,
        Mulu He <muluhe@codeaurora.org>
References: <1618479207-22243-1-git-send-email-taozha@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <3c280b36-82ec-7ffc-2ad1-4c901899ffe2@arm.com>
Date:   Thu, 15 Apr 2021 10:49:30 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1618479207-22243-1-git-send-email-taozha@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 15/04/2021 10:33, Tao Zhang wrote:
> Current coresight implementation only supports enabling source
> ETMs or STM. This patch adds support to enable more kinds of
> coresight source to sink paths. We build a path from source to
> sink when any source is enabled and store it in a list. When the
> source is disabled, we fetch the corresponding path from the list
> and decrement the refcount on each device in the path. The device
> is disabled if the refcount reaches zero. Don't store path to
> coresight data structure of source to avoid unnecessary change to
> ABI.
> Since some targets may have coresight sources other than STM and
> ETMs, we need to add this change to support these coresight
> devices.

While I am not against the patch, I would like to see why this change is
needed. Which compnents are we talking about , other than STM / ETM ?
Where is the "device" support code ? Without a legitimate user, we 
cannot add this change in.

Some other comments below.

> 
> Signed-off-by: Satyajit Desai <sadesai@codeaurora.org>
> Signed-off-by: Rama Aparna Mallavarapu <aparnam@codeaurora.org>
> Signed-off-by: Mulu He <muluhe@codeaurora.org>
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> Signed-off-by: Tao Zhang <taozha@codeaurora.org>
> ---
>   drivers/hwtracing/coresight/coresight-core.c | 101 +++++++++++++++------------
>   1 file changed, 56 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 4ba801d..7dfadb6 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -35,18 +35,16 @@ struct coresight_node {
>   };
>   
>   /*
> - * When operating Coresight drivers from the sysFS interface, only a single
> - * path can exist from a tracer (associated to a CPU) to a sink.
> + * struct coresight_path - path from source to sink
> + * @path:	Address of path list.
> + * @link:	hook to the list.
>    */
> -static DEFINE_PER_CPU(struct list_head *, tracer_path);
> +struct coresight_path {
> +	struct list_head *path;
> +	struct list_head link;
> +};
>   
> -/*
> - * As of this writing only a single STM can be found in CS topologies.  Since
> - * there is no way to know if we'll ever see more and what kind of
> - * configuration they will enact, for the time being only define a single path
> - * for STM.
> - */
> -static struct list_head *stm_path;
> +static LIST_HEAD(cs_active_paths);
>   
>   /*
>    * When losing synchronisation a new barrier packet needs to be inserted at the
> @@ -326,7 +324,7 @@ static void coresight_disable_sink(struct coresight_device *csdev)
>   	if (ret)
>   		return;
>   	coresight_control_assoc_ectdev(csdev, false);
> -	csdev->enable = false;
> +	csdev->activated = false;
>   }
>   
>   static int coresight_enable_link(struct coresight_device *csdev,
> @@ -562,6 +560,20 @@ int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data)
>   	goto out;
>   }
>   
> +static struct coresight_device *coresight_get_source(struct list_head *path)
> +{
> +	struct coresight_device *csdev;
> +
> +	if (!path)
> +		return NULL;
> +
> +	csdev = list_first_entry(path, struct coresight_node, link)->csdev;
> +	if (csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
> +		return NULL;
> +
> +	return csdev;
> +}
> +
>   struct coresight_device *coresight_get_sink(struct list_head *path)
>   {
>   	struct coresight_device *csdev;
> @@ -1047,9 +1059,23 @@ static int coresight_validate_source(struct coresight_device *csdev,
>   	return 0;
>   }
>   
> +static int coresight_store_path(struct list_head *path)
> +{
> +	struct coresight_path *node;
> +
> +	node = kzalloc(sizeof(struct coresight_path), GFP_KERNEL);

Have you run this with all the "DEBUG" whistles turned on ? This could 
be problematic when called from a context where you are not allowed to 
sleep. e.g, perf enable call back.

> +	if (!node)
> +		return -ENOMEM;
> +
> +	node->path = path;
> +	list_add(&node->link, &cs_active_paths);
> +
> +	return 0;
> +}
> +
>   int coresight_enable(struct coresight_device *csdev)
>   {
> -	int cpu, ret = 0;
> +	int ret = 0;
>   	struct coresight_device *sink;
>   	struct list_head *path;
>   	enum coresight_dev_subtype_source subtype;
> @@ -1094,25 +1120,9 @@ int coresight_enable(struct coresight_device *csdev)
>   	if (ret)
>   		goto err_source;
>   
> -	switch (subtype) {
> -	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
> -		/*
> -		 * When working from sysFS it is important to keep track
> -		 * of the paths that were created so that they can be
> -		 * undone in 'coresight_disable()'.  Since there can only
> -		 * be a single session per tracer (when working from sysFS)
> -		 * a per-cpu variable will do just fine.
> -		 */
> -		cpu = source_ops(csdev)->cpu_id(csdev);
> -		per_cpu(tracer_path, cpu) = path;
> -		break;
> -	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
> -		stm_path = path;
> -		break;
> -	default:
> -		/* We can't be here */
> -		break;
> -	}
> +	ret = coresight_store_path(path);
> +	if (ret)
> +		goto err_source;
>   
>   out:
>   	mutex_unlock(&coresight_mutex);
> @@ -1129,8 +1139,11 @@ EXPORT_SYMBOL_GPL(coresight_enable);
>   
>   void coresight_disable(struct coresight_device *csdev)
>   {
> -	int cpu, ret;
> +	int  ret;
>   	struct list_head *path = NULL;
> +	struct coresight_path *cspath = NULL;
> +	struct coresight_path *cspath_next = NULL;
> +	struct coresight_device *src_csdev = NULL;
>   
>   	mutex_lock(&coresight_mutex);
>   
> @@ -1141,20 +1154,18 @@ void coresight_disable(struct coresight_device *csdev)
>   	if (!csdev->enable || !coresight_disable_source(csdev))
>   		goto out;
>   
> -	switch (csdev->subtype.source_subtype) {
> -	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
> -		cpu = source_ops(csdev)->cpu_id(csdev);
> -		path = per_cpu(tracer_path, cpu);
> -		per_cpu(tracer_path, cpu) = NULL;
> -		break;
> -	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
> -		path = stm_path;
> -		stm_path = NULL;
> -		break;
> -	default:
> -		/* We can't be here */
> -		break;

--> Cut here <---

> +	list_for_each_entry_safe(cspath, cspath_next, &cs_active_paths, link) {
> +		src_csdev = coresight_get_source(cspath->path);
> +		if (!src_csdev)
> +			continue;
> +		if (src_csdev == csdev) {
> +			path = cspath->path;
> +			list_del(&cspath->link);
> +			kfree(cspath);
> +		}
>   	}

Why not add the above to coresight_{retrieve/remove/}_active_path(csdev) ?



Suzuki
