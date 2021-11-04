Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6358E445606
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 16:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhKDPK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 11:10:29 -0400
Received: from foss.arm.com ([217.140.110.172]:48806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229920AbhKDPK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 11:10:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7870C1FB;
        Thu,  4 Nov 2021 08:07:48 -0700 (PDT)
Received: from [10.57.45.134] (unknown [10.57.45.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30D773F7D7;
        Thu,  4 Nov 2021 08:07:47 -0700 (PDT)
Subject: Re: [PATCH v1 2/4] coresight: etm4x: Don't use virtual contextID for
 non-root PID namespace
To:     Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211031144214.237879-1-leo.yan@linaro.org>
 <20211031144214.237879-3-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <2cd79645-2f1f-1e59-1a26-5540aa7b6f3b@arm.com>
Date:   Thu, 4 Nov 2021 15:07:45 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211031144214.237879-3-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo

On 31/10/2021 14:42, Leo Yan wrote:
> As commented in the function ctxid_pid_store(), it can cause the PID
> values mismatching between context ID tracing and PID allocated in a
> non-root namespace, and it can leak kernel information.
> 
> For this reason, when a process runs in non-root PID namespace, the
> driver doesn't allow contextID tracing and returns failure when access
> contextID related sysfs nodes.
> 
> VMID works for virtual contextID when the kernel runs in EL2 mode with
> VHE; on the other hand, the driver doesn't prevent users from accessing
> it when programs run in the non-root namespace.  Thus this can lead
> to same issues with contextID described above.
> 
> This patch imposes the checking on VMID related sysfs knobs, it returns
> failure if current process runs in non-root PID namespace.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Patch looks good to me. Please see minor comment below.


> ---
>   .../coresight/coresight-etm4x-sysfs.c         | 28 +++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index e4c8c44d04ef..e218281703b0 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -2111,6 +2111,13 @@ static ssize_t vmid_val_show(struct device *dev,
>   	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
>   	struct etmv4_config *config = &drvdata->config;
>   
> +	/*
> +	 * Don't use virtual contextID tracing if coming from a PID namespace.
> +	 * See comment in ctxid_pid_store().
> +	 */
> +	if (task_active_pid_ns(current) != &init_pid_ns)
> +		return -EINVAL;
> +
>   	spin_lock(&drvdata->spinlock);
>   	val = (unsigned long)config->vmid_val[config->vmid_idx];
>   	spin_unlock(&drvdata->spinlock);
> @@ -2125,6 +2132,13 @@ static ssize_t vmid_val_store(struct device *dev,
>   	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
>   	struct etmv4_config *config = &drvdata->config;
>   
> +	/*
> +	 * Don't use virtual contextID tracing if coming from a PID namespace.
> +	 * See comment in ctxid_pid_store().
> +	 */
> +	if (task_active_pid_ns(current) != &init_pid_ns)

Please could we add a helper function to make this obvious ?

e.g: task_is_in_root_ns(task) ?

Suzuki
