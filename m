Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006703B3964
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 00:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbhFXWt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 18:49:59 -0400
Received: from foss.arm.com ([217.140.110.172]:40954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhFXWt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 18:49:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 980F6ED1;
        Thu, 24 Jun 2021 15:47:37 -0700 (PDT)
Received: from [10.57.77.225] (unknown [10.57.77.225])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 595243F718;
        Thu, 24 Jun 2021 15:47:36 -0700 (PDT)
Subject: Re: [RFC PATCH 4/4] ultrasoc: Add System Memory Buffer driver
To:     Qi Liu <liuqi115@huawei.com>, alexander.shishkin@linux.intel.com,
        mathieu.poirier@linaro.org, jonathan.zhouwen@huawei.com,
        f.fangjian@huawei.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linuxarm@huawei.com
References: <1623749684-65432-1-git-send-email-liuqi115@huawei.com>
 <1623749684-65432-5-git-send-email-liuqi115@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <da4d5c5e-5536-b8ca-3aa5-601c12d4e5ae@arm.com>
Date:   Thu, 24 Jun 2021 23:47:34 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623749684-65432-5-git-send-email-liuqi115@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qi

On 15/06/2021 10:34, Qi Liu wrote:
> This patch adds driver for System Memory Buffer. It includes
> a platform driver for the SMB device.
> 
> Signed-off-by: Jonathan Zhou <jonathan.zhouwen@huawei.com>
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>   drivers/hwtracing/ultrasoc/Kconfig        |   9 +
>   drivers/hwtracing/ultrasoc/Makefile       |   3 +
>   drivers/hwtracing/ultrasoc/ultrasoc-smb.c | 663 ++++++++++++++++++++++++++++++
>   drivers/hwtracing/ultrasoc/ultrasoc-smb.h | 182 ++++++++
>   4 files changed, 857 insertions(+)
>   create mode 100644 drivers/hwtracing/ultrasoc/ultrasoc-smb.c
>   create mode 100644 drivers/hwtracing/ultrasoc/ultrasoc-smb.h
> 

> +/*
> + * Coresight doesn't export the following
> + * structures(cs_mode,cs_buffers,etm_event_data),
> + * so we redefine a copy here.
> + */

Please do not duplicate them. This indicates, either :

  - You need to place your driver under coresight

  OR

  - Export the required definitions.

> +enum cs_mode {
> +	CS_MODE_DISABLED,
> +	CS_MODE_SYSFS,
> +	CS_MODE_PERF,
> +};
> +

> +struct cs_buffers {
> +	unsigned int		cur;
> +	unsigned int		nr_pages;
> +	unsigned long		offset;
> +	local_t			data_size;
> +	bool			snapshot;
> +	void			**data_pages;
> +};
> +

Why does this need to be replicated ?

> +struct etm_event_data {
> +	struct work_struct work;
> +	cpumask_t mask;
> +	void *snk_config;
> +	struct list_head * __percpu *path;
> +};
> +
> +#if IS_ENABLED(CONFIG_CORESIGHT)
> +int etm_perf_symlink(struct coresight_device *csdev, bool link);
> +int etm_perf_add_symlink_sink(struct coresight_device *csdev);
> +void etm_perf_del_symlink_sink(struct coresight_device *csdev);
> +static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
> +{
> +	struct etm_event_data *data = perf_get_aux(handle);
> +
> +	if (data)
> +		return data->snk_config;
> +	return NULL;
> +}
> +#else
> +static inline int etm_perf_symlink(struct coresight_device *csdev, bool link)
> +{ return -EINVAL; }
> +int etm_perf_add_symlink_sink(struct coresight_device *csdev)
> +{ return -EINVAL; }
> +void etm_perf_del_symlink_sink(struct coresight_device *csdev) {}
> +static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
> +{
> +	return NULL;
> +}
> +
> +#endif /* CONFIG_CORESIGHT */
> +
> +#endif
> 

Suzuki
