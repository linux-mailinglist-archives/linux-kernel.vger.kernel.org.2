Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0A642B9CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 09:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbhJMIAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 04:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232692AbhJMIAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 04:00:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39F3F60D42;
        Wed, 13 Oct 2021 07:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634111889;
        bh=D9FlrqNI1J8wIJfmRvfYUVMCVcEi1UrNOTrLK4bJETg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NRxFvKTadup6yfexYdKOPpR6RpmuDeoimcFkuQVLeQj8TNVWR0AcnbfvronX8cNWi
         01d2u5PxqTqB17CCZl7xE/iehLLdR/8y+KHn6iJo859xj6SjhcMbFhpVFeatFlfzDK
         uTuflds0qAo1B2X54WQDuZv/nc9/2wpQA5Kw4+7lX2JSpJRTeE3yXGlKAjs01ACCuI
         CWdkToqqJn8vjO0LIIA1hvMTuWQg8Q4wxRNeNJvbYvYCQYzqgQtVcJ9Bi5n7jXw9zs
         ssstPmLZeND++RljfGI19UP/OVJDhBQG9LBSX4pKBR4XL5F40fpNOSejDf81d38TE6
         YXA2jrvIl7Uaw==
Date:   Wed, 13 Oct 2021 08:58:03 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Alex Elder <elder@linaro.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm: fix ARM_SMMU_QCOM compilation
Message-ID: <20211013075803.GB6701@willie-the-truck>
References: <20211012151841.2639732-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012151841.2639732-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 05:18:00PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> My previous bugfix ended up making things worse for the QCOM IOMMU
> driver when it forgot to add the Kconfig symbol that is getting used to
> control the compilation of the SMMU implementation specific code
> for Qualcomm.
> 
> Fixes: 424953cf3c66 ("qcom_scm: hide Kconfig symbol")
> Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reported-by: John Stultz <john.stultz@linaro.org>
> Link: https://lore.kernel.org/lkml/20211010023350.978638-1-dmitry.baryshkov@linaro.org/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> In case we want fix it this way after all, here is the patch
> I made. Either this one or Dmitry patch from the link above
> is required for v5.15
> ---
>  drivers/iommu/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c5c71b7ab7e8..3eb68fa1b8cc 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -355,6 +355,14 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
>  	  'arm-smmu.disable_bypass' will continue to override this
>  	  config.
>  
> +config ARM_SMMU_QCOM
> +	def_tristate y
> +	depends on ARM_SMMU && ARCH_QCOM
> +	select QCOM_SCM
> +	help
> +	  When running on a Qualcomm platform that has the custom variant
> +	  of the ARM SMMU, this needs to be built into the SMMU driver.
> +

FWIW, I prefer this solution over changing the driver code, so:

Acked-by: Will Deacon <will@kernel.org>

I assume you'll be getting this fixed for 5.15?

Cheers,

Will
