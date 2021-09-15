Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9137740CDC2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 22:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhIOUOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 16:14:23 -0400
Received: from foss.arm.com ([217.140.110.172]:58648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231487AbhIOUOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 16:14:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCD926D;
        Wed, 15 Sep 2021 13:13:02 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5518B3F59C;
        Wed, 15 Sep 2021 13:13:01 -0700 (PDT)
Subject: Re: [PATCH] ACPI/IORT: Add 'smmu=off' command line option
To:     Yao Hongbo <yaohongbo@linux.alibaba.com>
Cc:     zhangliguang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com, will@kernel.org,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210915120046.62936-1-yaohongbo@linux.alibaba.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <c243d909-b442-02ae-a05c-1a59a5e950d5@arm.com>
Date:   Wed, 15 Sep 2021 21:12:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210915120046.62936-1-yaohongbo@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-15 13:00, Yao Hongbo wrote:
> Add a generic command line option to disable arm smmu drivers.
> iommu.passthrough can only bypass the IOMMU for DMA, but
> sometimes we need to ignore all available SMMUs.

Please elaborate on "sometimes" - what's the use-case for this which 
can't already be achieved by other means like module_blacklist, 
switching kernel images, ACPI table overrides, and so on?

> This patch is only used for acpi on arm64.

And yet the documentation implies that it works for all arm64 systems :/

And furthermore, why? If it's genuinely useful to disable SMMUs on 
ACPI-based systems, surely it must be equally useful to disable SMMUs on 
DT-based systems?

> Signed-off-by: Yao Hongbo <yaohongbo@linux.alibaba.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>   drivers/acpi/arm64/iort.c                       | 18 +++++++++++++++++-
>   2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 91ba391f..6cffd91 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5198,6 +5198,10 @@
>   	smart2=		[HW]
>   			Format: <io1>[,<io2>[,...,<io8>]]
>   
> +	smmu=           [ARM64]
> +			Format: {off}
> +			off: Disable arm smmu driver.

There are at least two Arm SMMU drivers; as a user I might be wondering 
about the ambiguity there.

> +
>   	smsc-ircc2.nopnp	[HW] Don't use PNP to discover SMC devices
>   	smsc-ircc2.ircc_cfg=	[HW] Device configuration I/O port
>   	smsc-ircc2.ircc_sir=	[HW] SIR base I/O port
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 3b23fb7..70f92e7 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -40,6 +40,22 @@ struct iort_fwnode {
>   static LIST_HEAD(iort_fwnode_list);
>   static DEFINE_SPINLOCK(iort_fwnode_lock);
>   
> +static bool acpi_smmu_disabled;
> +
> +static int __init acpi_smmu_parse(char *str)
> +{
> +	if (!str)
> +		return -EINVAL;
> +
> +	if (!strncmp(str, "off", 3)) {
> +		acpi_smmu_disabled = true;
> +		pr_info("SMMU disabled\n");
> +	}
> +
> +	return 0;
> +}
> +__setup("smmu=", acpi_smmu_parse);
> +
>   /**
>    * iort_set_fwnode() - Create iort_fwnode and use it to register
>    *		       iommu data in the iort_fwnode_list
> @@ -1596,7 +1612,7 @@ static void __init iort_init_platform_devices(void)
>   		iort_enable_acs(iort_node);
>   
>   		ops = iort_get_dev_cfg(iort_node);
> -		if (ops) {
> +		if (ops && !acpi_smmu_disabled) {

This will also effectively disable PMCGs, which is an undocumented 
side-effect, and not necessarily desirable - PMCG functionality is 
largely orthogonal, and may potentially be used to monitor traffic even 
when the associated SMMU instance is disabled.

TBH there's really nothing SMMU-specific about this at all. I know I've 
had a number of debugging situations where it would have been handy to 
have a way to prevent a specific built-in driver from binding 
automatically during boot, so if you really have got a compelling reason 
to need it for SMMU, then you could still implement it generically in a 
way that everyone could benefit from.

Thanks,
Robin.

>   			fwnode = acpi_alloc_fwnode_static();
>   			if (!fwnode)
>   				return;
> 
