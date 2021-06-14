Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71E23A6D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 19:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhFNR2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 13:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbhFNR2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 13:28:13 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C35C061767
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 10:26:09 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id d19so11090988oic.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 10:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dvIEBou67kHJiRTzW5qY/4yBKZTXktpS1R7fvVFvoyU=;
        b=ZKbH0tuAUFkipYD9h+mCBHbR28XpfU/ys/hYkHtXCIOGm44nDdNinPLLEcCU5GJX//
         EijxZeXU/x0BV2qv8lhMmePPbzYj0/P4A84t1g8tpIIQHsunxKyus8bLH2IdtKjLHGLS
         2Hc8yG2lUDTRv3FZEPujYdQcmOvxzQumCwaCXo0gm7BHYgTZ1BkKsFPqpxNqjBeXzJB1
         x2EgXA2+iyGwatUE/KIdasDMtrEHv4MxpkxW+CXSLEqljZiG8mXCzIiM3Cv+ZZ+vMAho
         st2geZgrruff3veHFmiiAEMWJO7F7y6BSPoVlOUIA2lkGkzlOwVKh2LJHzWpkzL8DBEw
         NeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dvIEBou67kHJiRTzW5qY/4yBKZTXktpS1R7fvVFvoyU=;
        b=SgRPSy0bhR3YkHVBDt9we2G1YslxJB9WnbplzVO29BnDEx9mLcPH1aMfkVT9cQSRw/
         VnyJOto7SSMORzbxojvs3OR2fjaRywl4EnLRzcMg95UV+muX/wHabA5UdmWZZsGRyV29
         0+uml6sjXZB1eEgpWg3C/1DVe+5MDrYrWnnhzc8OVLxl96LJtxD2kSVQcOYgVFj8tLKD
         pqxlVrmYFp7mDdlem3fB1VPfjV/0vfM+4SFnk3k6Lom2//I1z8Jhyi0ACqN+xFp0oWm6
         /W9QqkgYdvpI9gDpCrj4nf2mN34IafbGwO/LNBlJoKt19bJJbCQg3hroN1zW44XlY52T
         ORrA==
X-Gm-Message-State: AOAM531AX4EWb/qFXbL48hmqJWTvRWuuaNlD1Gz3n2WpsWqDBt9WWXSz
        v3uc3PM8r1y9pTuQQiyXgHnmcg==
X-Google-Smtp-Source: ABdhPJxYXdUiG7CFB0f563Qo+oUPK0plSEwpIpm/WaXTv3i5kjc+viL5mTEG0vDaC/hAxLm4HBNMjg==
X-Received: by 2002:aca:2410:: with SMTP id n16mr136639oic.56.1623691569228;
        Mon, 14 Jun 2021 10:26:09 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p25sm3200355ood.4.2021.06.14.10.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:26:08 -0700 (PDT)
Date:   Mon, 14 Jun 2021 12:26:06 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        Rob Clark <robdclark@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        freedreno@lists.freedesktop.org,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 1/5] iommu/arm-smmu: Add support for driver IOMMU
 fault handlers
Message-ID: <YMeRLuMkiG4Uv0ZP@yoga>
References: <20210610214431.539029-1-robdclark@gmail.com>
 <20210610214431.539029-2-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610214431.539029-2-robdclark@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10 Jun 16:44 CDT 2021, Rob Clark wrote:

> From: Jordan Crouse <jcrouse@codeaurora.org>
> 
> Call report_iommu_fault() to allow upper-level drivers to register their
> own fault handlers.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Acked-by: Will Deacon <will@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 6f72c4d208ca..b4b32d31fc06 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -408,6 +408,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	int idx = smmu_domain->cfg.cbndx;
> +	int ret;
>  
>  	fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
>  	if (!(fsr & ARM_SMMU_FSR_FAULT))
> @@ -417,8 +418,12 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>  	iova = arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR);
>  	cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(idx));
>  
> -	dev_err_ratelimited(smmu->dev,
> -	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
> +	ret = report_iommu_fault(domain, NULL, iova,
> +		fsynr & ARM_SMMU_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
> +
> +	if (ret == -ENOSYS)
> +		dev_err_ratelimited(smmu->dev,
> +		"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
>  			    fsr, iova, fsynr, cbfrsynra, idx);
>  
>  	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
> -- 
> 2.31.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
