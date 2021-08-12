Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AA63EA3AC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 13:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbhHLL1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 07:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbhHLL1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 07:27:36 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB18C061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 04:27:11 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BD7744D4; Thu, 12 Aug 2021 13:27:08 +0200 (CEST)
Date:   Thu, 12 Aug 2021 13:27:01 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: APPLE_DART should depend on ARCH_APPLE
Message-ID: <YRUFhQ9B7goYvsuN@8bytes.org>
References: <44fcf525273b32c9afcd7e99acbd346d47f0e047.1628603162.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44fcf525273b32c9afcd7e99acbd346d47f0e047.1628603162.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 03:47:19PM +0200, Geert Uytterhoeven wrote:
> The Apple DART (Device Address Resolution Table) IOMMU is only present
> on Apple ARM SoCs like the M1.  Hence add a dependency on ARCH_APPLE, to
> prevent asking the user about this driver when configuring a kernel
> without support for the Apple Silicon SoC family.
> 
> Fixes: 05ce9d20d699b093 ("iommu/dart: Add DART iommu driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/iommu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index dfe81da483e9e073..e908b8222e4ed679 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -292,7 +292,7 @@ config SPAPR_TCE_IOMMU
>  
>  config APPLE_DART
>  	tristate "Apple DART IOMMU Support"
> -	depends on ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
> +	depends on ARCH_APPLE || (COMPILE_TEST && !GENERIC_ATOMIC64)
>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAE
>  	default ARCH_APPLE

Dropped the Fixes tag, as this doesn't fix any real issue. Otherwise
applied with adjusted subject (iommu: -> iommu/dart:), Thanks.
