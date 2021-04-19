Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F71236464A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 16:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240116AbhDSOih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 10:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237650AbhDSOif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 10:38:35 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB8DC061761
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 07:38:05 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 101-20020a9d0d6e0000b02902816815ff62so26843226oti.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 07:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KA74mLe8fkXTNtvVxnUD/R9BP6DUvXU6GqQ2V7QKU48=;
        b=bAzz2nqBdmNDb3rFxnWCQS/xFq26jaqJ1ftmMT9fjQKqUQ+ZIT37hcoSvqn+IRFGgT
         GVip74BqDG4qz9eauJZKuBdu13AU7teUbvwlKaK3avT3/JwXHS9clecYMVF191V3lHDo
         WHV9gLkUcYKpeWr80FofB30gMK7aXB8XKdNtneDOVHCgCvl1toUTYefb4j6F7kqLJcwh
         MeFOwJVtLxF9QJ/GfBpeR5f44kwz0iau8kJLvMGhx/7i9NlAN1ebmLP/LpN6jMdqgCQY
         yCdCkYlGQ5AAj1PJ4BgaljpuB1UBYg63Bg/rI++eUqe28RWzzx0uV2P9BUf4v1pRNXZ1
         vuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KA74mLe8fkXTNtvVxnUD/R9BP6DUvXU6GqQ2V7QKU48=;
        b=PdbbrWgOJRqRbnatzSl2LD2wVFxzvFhkQ5iqChnWl6n8JttsMeRg9k0dvuBnhw1rW7
         Fnj/C5Jf1zoNoT7qqiqRvNEdn3VkW9gVOedNfh1gyG3K0xV2DYixxTr8SPSSayqxzC/3
         mQGr9/pVYuNa8MyiF0kxrSCrDfmHx9cB3SO+tGUFbZ50R+6cmC6OBaAV+ePqfKTarW8M
         d43594fgjjKdyfuGda1XygbDMX1K5SuZPWEs4ZElMhyVezrnc+34KmGIJsCDhGqiwgxo
         dHNy5Tot+ZujFbBSkktrOVlEDwlK6TbIcLuzofBwgQooU8BtscPTi6W8YYoESFSoV1Rj
         sLng==
X-Gm-Message-State: AOAM532tssAIDnPXJtLasaR9znF32OXfseo+nC3l2AsMPWeCdz/Vp0dG
        X4o6eY5v+Uq8CBq8AiGl5rXa2Q==
X-Google-Smtp-Source: ABdhPJwpnzs8sEJmdIC3gggfdBnNIayOKuztT5Ad2mhWhCKzjzRYS/+RcMa4CWJUYLuJ6RVpczhslQ==
X-Received: by 2002:a05:6830:1601:: with SMTP id g1mr4499748otr.0.1618843085133;
        Mon, 19 Apr 2021 07:38:05 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q130sm3161649oif.40.2021.04.19.07.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 07:38:04 -0700 (PDT)
Date:   Mon, 19 Apr 2021 09:38:02 -0500
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
Message-ID: <20210419143802.GP1538589@yoga>
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
> Suggested-by: Akhil P Oommen <akhilpo@codeaurora.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Sorry for taking my time thinking about this.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

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
