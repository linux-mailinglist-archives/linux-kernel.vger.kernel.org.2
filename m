Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9362325541
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 19:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhBYSLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 13:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbhBYSHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 13:07:36 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C0AC061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 10:06:55 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id n14so6857643iog.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 10:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cosmicpenguin-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=AxUdC6CFDfkAaePAsmcu4sHTgfK+O7KlLijA5jPxuMc=;
        b=u9NJTozlWdTsvfc+K7kM0rOz+KZ/1uTn+oTrFXNsutZHNZdYnzEBaLWkrIpIWv5t4c
         QHSbbRRufna1jHv5hC8izsXX4/s/hvILtl//rENGERBQSgRfUEsII76j7cSoJba5x3FH
         thxrWUGZjri6vHllhc/U78Tcd5QRh+Fpb2MBJmJ/hkeyYvEoSsXv/AT2kfH9XaDEEskK
         Zqq59e3HHxhmAI91dcwy+Lr8nuc24WKwfWSRQMEVCMGkiyyv77beKtvC5/d5TMS2GuWU
         yp58djTf9XDJfcQJMPenk2thMCz2LWuGn2No1m2+sg2WDXtdkDOq7m26Gg9noAosRoz2
         T+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=AxUdC6CFDfkAaePAsmcu4sHTgfK+O7KlLijA5jPxuMc=;
        b=SdN6IgFeRtp3C3uK6PIGWIIs+jC2XJlTCbAfDi/9kfUCz2Sx1di4tqFEjfNI0BsAVx
         0Pwlf6p4PD/p3+mZG/946qzQIv4pKvlJCADIFCX0M8jJ8Mo9aFEHzN2FLgGh5OIG6rCZ
         Pb67LWsx5sYzQWLi53ZXVlfl5eKob1rF0uHDGP7JdNY0yGV/8phOz3rinLr8pB8qeEbP
         kPCHSnw1/r37QwTUxXIu7lnghpyeE+gPdowdrzkaFktUIzl+Rd758A3fstlNMPgGbSxQ
         KgHdUfd2CIraubdiUKuotWZGysa8vioL49Mk52dEs1WER71PSQE3pVxARqNqwPxPo+VT
         IJUg==
X-Gm-Message-State: AOAM532Z6FFQPMpH8iUg4KMF3FGSnHE10bC+aAgU1FoT3Uu3BBjHMXuF
        UvLUZnxdQ8gMI/7EHFNXU/g0jQ==
X-Google-Smtp-Source: ABdhPJz0VfK6tUdxMHD7ZwGQgHp7seGCcT94w6s2c5w6nIBz48v+NYXQMer69FsoVTia/ybsrkoLkQ==
X-Received: by 2002:a5d:93c2:: with SMTP id j2mr3787669ioo.166.1614276415456;
        Thu, 25 Feb 2021 10:06:55 -0800 (PST)
Received: from cosmicpenguin.net (c-71-237-100-236.hsd1.co.comcast.net. [71.237.100.236])
        by smtp.gmail.com with ESMTPSA id u15sm13173iln.84.2021.02.25.10.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 10:06:55 -0800 (PST)
Date:   Thu, 25 Feb 2021 11:06:52 -0700
From:   Jordan Crouse <jordan@cosmicpenguin.net>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robdclark@gmail.com>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] iommu/arm-smmu-qcom: Move the adreno smmu specific
 impl earlier
Message-ID: <20210225180652.zwhyjhff3jxm7hcw@cosmicpenguin.net>
Mail-Followup-To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Clark <robdclark@gmail.com>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1614247752.git.saiprakash.ranjan@codeaurora.org>
 <ed9bedef1546879c5b5e9f0f3f6d4667ec6b4fc4.1614247752.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed9bedef1546879c5b5e9f0f3f6d4667ec6b4fc4.1614247752.git.saiprakash.ranjan@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 03:54:10PM +0530, Sai Prakash Ranjan wrote:
> Adreno(GPU) SMMU and APSS(Application Processor SubSystem) SMMU
> both implement "arm,mmu-500" in some QTI SoCs and to run through
> adreno smmu specific implementation such as enabling split pagetables
> support, we need to match the "qcom,adreno-smmu" compatible first
> before apss smmu or else we will be running apps smmu implementation
> for adreno smmu and the additional features for adreno smmu is never
> set. For ex: we have "qcom,sc7280-smmu-500" compatible for both apps
> and adreno smmu implementing "arm,mmu-500", so the adreno smmu
> implementation is never reached because the current sequence checks
> for apps smmu compatible(qcom,sc7280-smmu-500) first and runs that
> specific impl and we never reach adreno smmu specific implementation.
> 
> Suggested-by: Akhil P Oommen <akhilpo@codeaurora.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
> 
> Its either this or we add a new compatible for adreno smmu implementing
> arm,mmu-500 like "qcom,sc7280-adreno-smmu-500".
> 
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index bea3ee0dabc2..7d0fc2c8e72f 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -345,11 +345,11 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
>  {
>  	const struct device_node *np = smmu->dev->of_node;
>  
> -	if (of_match_node(qcom_smmu_impl_of_match, np))
> -		return qcom_smmu_create(smmu, &qcom_smmu_impl);
> -
>  	if (of_device_is_compatible(np, "qcom,adreno-smmu"))
>  		return qcom_smmu_create(smmu, &qcom_adreno_smmu_impl);
>  
> +	if (of_match_node(qcom_smmu_impl_of_match, np))
> +		return qcom_smmu_create(smmu, &qcom_smmu_impl);
> +

It would be good to add a comment here explaining the order here so we
don't accidentally reorganize ourselves back into a problem later.

Jordan

>  	return smmu;
>  }
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
