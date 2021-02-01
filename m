Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937F830A6D8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhBALtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:49:12 -0500
Received: from foss.arm.com ([217.140.110.172]:57362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhBALtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:49:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6FB6ED1;
        Mon,  1 Feb 2021 03:48:20 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4555D3F718;
        Mon,  1 Feb 2021 03:48:19 -0800 (PST)
Subject: Re: [PATCH] driver/perf: Remove ARM_SMMU_V3_PMU dependency on
 ARM_SMMU_V3
To:     John Garry <john.garry@huawei.com>, will@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jean-philippe@linaro.org, thunder.leizhen@huawei.com,
        shameerali.kolothum.thodi@huawei.com
References: <1612175042-56866-1-git-send-email-john.garry@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <98ce3401-cac9-2111-5ae5-082808a6edc4@arm.com>
Date:   Mon, 1 Feb 2021 11:48:18 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1612175042-56866-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-01 10:24, John Garry wrote:
> The ARM_SMMU_V3_PMU dependency on ARM_SMMU_V3_PMU was added with the idea
> that a SMMUv3 PMCG would only exist on a system with an associated SMMUv3.
> 
> However it is not the job of Kconfig to make these sorts of decisions (even
> if it were true), so remove the dependency.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 3075cf171f78..77522e5efe11 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -62,7 +62,7 @@ config ARM_PMU_ACPI
>   
>   config ARM_SMMU_V3_PMU
>   	 tristate "ARM SMMUv3 Performance Monitors Extension"
> -	 depends on ARM64 && ACPI && ARM_SMMU_V3
> +	 depends on ARM64 && ACPI
>   	   help
>   	   Provides support for the ARM SMMUv3 Performance Monitor Counter
>   	   Groups (PMCG), which provide monitoring of transactions passing
> 
