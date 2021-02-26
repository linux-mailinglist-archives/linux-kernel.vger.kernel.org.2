Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40F4326647
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 18:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhBZRZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 12:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhBZRZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 12:25:36 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC20C061756
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 09:24:55 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id b8so9723322oti.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 09:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=46MifqQE4f/PAS/QIgiSzbDRBfO/hWIxYDCH5F8gOGo=;
        b=h6LA10EZslChayy3Ur3LXT2ugyZAipLvkbzRswQ2gMM8RTpMC49WQpw317mvKPkbKN
         cGggGXn06t6hx19TERjXoLlIDHfz7WFiDxk8qwla7OsM0Qwdc++LfVLlXrF5Z7ukbm5/
         alyMQyCoFDUcHcSjRSXUwPrpkxYypingOrvvN80bnpImQYs/vSWL2Pr5GsqfmRzwjVWj
         hDFkdPU6+RV8kpxyPIDjBQHN0e1yZL5f2KdfOufP9nw9t9i0nlFS0raBKIA2Hxf/N8TC
         YSjQiMadpDWhTgmlTHaJd3/2eUCRXs+nqnCYrRfPW5CQxlV/WfzYBT26Uu53MlTOiz7v
         yLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=46MifqQE4f/PAS/QIgiSzbDRBfO/hWIxYDCH5F8gOGo=;
        b=G/vU5h6BBX7eXg93/gh+H/xBrxtGr09eYl9PSnen9o4+nwN7O5gpvsI/zwOyolKKlr
         jzjXpu4GTYx7yvUtJx/vYPe8H440fk4wzqROUbrQue0wRFBIVOfqTdNJUvUKuSOvTw3t
         uUBEU5gUefyZcKWpzwV72yXb9C9Xm8JvTQClkol9iClRrmSa2RCR/2/oddN69ndyA9RC
         By5Qd/SGu+hc6/BvJrIL02aB396fRLaoV1dpxf4oJoVWqwUkfnDz2o2MZi2dLW2oPx41
         ZktWRgKD2AwQFTpWrr6nsLhUeWE3wJRQ2+/ZCH4WjT7rXeceYm92nTlEADiSR3S6qHEJ
         Kpxg==
X-Gm-Message-State: AOAM533ibD+1oQa7hNWWV+cmYomoosEaB4sRRtJUriuym0GSakIApaQa
        SndAsSJluwHt/K4H2tvlD0bYrg==
X-Google-Smtp-Source: ABdhPJz7cnRLcAi6rf0O0EbFSNRRU54HnjS36fldgfxWOIO06Ym10eHK8rx7//LE2c+AXwiJM8G3ug==
X-Received: by 2002:a05:6830:232f:: with SMTP id q15mr3180613otg.165.1614360294902;
        Fri, 26 Feb 2021 09:24:54 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e17sm1938869otl.75.2021.02.26.09.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 09:24:54 -0800 (PST)
Date:   Fri, 26 Feb 2021 11:24:52 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCHv2 2/2] iommu/arm-smmu-qcom: Move the adreno smmu specific
 impl earlier
Message-ID: <YDku5PFQZetP4iG8@builder.lan>
References: <cover.1614332994.git.saiprakash.ranjan@codeaurora.org>
 <c607d71eb0fe507c8b83cc0ea9b393777f22149a.1614332994.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c607d71eb0fe507c8b83cc0ea9b393777f22149a.1614332994.git.saiprakash.ranjan@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26 Feb 03:55 CST 2021, Sai Prakash Ranjan wrote:

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

So you're saying that you have a single SMMU instance that's compatible
with both an entry in qcom_smmu_impl_of_match[] and "qcom,adreno-smmu"?

Per your proposed change we will pick the adreno ops _only_ for this
component, essentially disabling the non-Adreno quirks selected by the
qcom impl. As such keeping the non-adreno compatible in the
qcom_smmu_impl_init[] seems to only serve to obfuscate the situation.

Don't we somehow need the combined set of quirks? (At least if we're
running this with a standard UEFI based boot flow?)

Regards,
Bjorn

> Suggested-by: Akhil P Oommen <akhilpo@codeaurora.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index bea3ee0dabc2..03f048aebb80 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -345,11 +345,17 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
>  {
>  	const struct device_node *np = smmu->dev->of_node;
>  
> -	if (of_match_node(qcom_smmu_impl_of_match, np))
> -		return qcom_smmu_create(smmu, &qcom_smmu_impl);
> -
> +	/*
> +	 * Do not change this order of implementation, i.e., first adreno
> +	 * smmu impl and then apss smmu since we can have both implementing
> +	 * arm,mmu-500 in which case we will miss setting adreno smmu specific
> +	 * features if the order is changed.
> +	 */
>  	if (of_device_is_compatible(np, "qcom,adreno-smmu"))
>  		return qcom_smmu_create(smmu, &qcom_adreno_smmu_impl);
>  
> +	if (of_match_node(qcom_smmu_impl_of_match, np))
> +		return qcom_smmu_create(smmu, &qcom_smmu_impl);
> +
>  	return smmu;
>  }
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
