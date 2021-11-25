Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D0145DB08
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 14:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355033AbhKYN0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 08:26:51 -0500
Received: from foss.arm.com ([217.140.110.172]:50948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355176AbhKYNYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 08:24:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7EC51FB;
        Thu, 25 Nov 2021 05:21:38 -0800 (PST)
Received: from [10.57.56.56] (unknown [10.57.56.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C84213F66F;
        Thu, 25 Nov 2021 05:21:37 -0800 (PST)
Message-ID: <f5c80024-1457-58fc-6c4a-1ef5f60cce8f@arm.com>
Date:   Thu, 25 Nov 2021 13:21:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v4 04/12] ARM: Add basic support for Airoha EN7523 SoC
Content-Language: en-GB
To:     Felix Fietkau <nbd@nbd.name>, linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Cc:     john@phrozen.org, linux-kernel@vger.kernel.org
References: <20211125110738.41028-1-nbd@nbd.name>
 <20211125110738.41028-5-nbd@nbd.name>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211125110738.41028-5-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-25 11:07, Felix Fietkau wrote:
> From: John Crispin <john@phrozen.org>
> 
> EN7523 is an armv8 based silicon used inside broadband access type devices
> such as xPON and xDSL. It shares various silicon blocks with MediaTek
> silicon such as the MT7622.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Bert Vermeulen <bert@biot.com>
> ---
>   arch/arm/Kconfig | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index f0f9e8bec83a..8468361a8721 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -573,6 +573,20 @@ config ARCH_VIRT
>   	select HAVE_ARM_ARCH_TIMER
>   	select ARCH_SUPPORTS_BIG_ENDIAN
>   
> +config ARCH_AIROHA
> +	bool "Airoha SoC Support"
> +	depends on ARCH_MULTI_V7
> +	select ARM_AMBA
> +	select ARM_GIC
> +	select ARM_GIC_V3
> +	select ARM_DMA_USE_IOMMU

Is this really needed? TBH I'd be rather surprised to see IOMMUs in a 
small-scale embedded router SoC, or are there others in a similar vein 
to MT7623N with random multimedia bits thrown in as well?

> +	select ARM_PSCI
> +	select HAVE_ARM_ARCH_TIMER
> +	select IOMMU_DMA

This does nothing (except bloat your image with some dead code which 
won't be called).

Robin.

> +	select COMMON_CLK
> +	help
> +	  Support for Airoha EN7523 SoCs
> +
>   #
>   # This is sorted alphabetically by mach-* pathname.  However, plat-*
>   # Kconfigs may be included either alphabetically (according to the
> 
