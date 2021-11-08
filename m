Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841ED449B24
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 18:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhKHR6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 12:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhKHR62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 12:58:28 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD7CC061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 09:55:43 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id bk14so5911486oib.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 09:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LhWfz+5JE21inJr4S250OgcbtsWmt4NJR6DvKNs5YBk=;
        b=NLZ/NWmaut34l69Gi0IMn3FhSPoI8MJxyT511eGKct44ivuZgMwua7hT0tOyLsDZUP
         TrgDXxUaUA7ChA+L3cFnC1wxXZ9OKrp2DAiclSjd/0dAqPiEQUMxdLhwh7TJBeW62J0y
         sxa7L/gO7PUUgBqELeaWYWMpjfyrDPN5orMWbR0tgee7qH946wvFrwRkNxmCE20baibN
         k+IRalaydJaBo+7hWaDZNjCRUOsSOX8GaiuqRGVUZ8nIAxdWVmPEL4ubW46Kx7KoptLH
         NXfufoYJtTJtYYpAQh2ZV1xuOG4OC8fEO2gNDc7SVhOr6lUM1CgDwpMx+e8MVxkv1JSD
         yRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LhWfz+5JE21inJr4S250OgcbtsWmt4NJR6DvKNs5YBk=;
        b=TSTfeK4KXkplQhJuVyG9Ne8PYuRv2AvxudQE1nXtSz+sxPYvknbTqIbV/eFGpl7iRc
         4gUMIiFA9oaJ8YP+Ti2vE/hZOr8C54uUkohWa2C1ZliHno+GcdhCdiPcXR1KbHvFIDk+
         nD2i9FU09Of7+X8Gz7CyI4928OzbDQu9nzpHeA94TBF3Wc0P+FttExXRhYVHRkZwT3Jg
         V4jtUxVdkQLX4x0fKyxfLW2eF+yQG6j5Ntm/HOPYxY2psOAagFteWfU7IDnUdSR71q8O
         VJ1FIfUObbCSvNEv5XoBEdb3pvYb91Z+Vnn96AJ4at5YfRFMkh+0/32b62/LYUjn7ckF
         KxVw==
X-Gm-Message-State: AOAM533S+NKZ3s9VWFFgPB2npndMtO+96Lnm9lhFrZglAndaT7thudHm
        AMQMzGqicewxx7Q7I85+PCFWnw==
X-Google-Smtp-Source: ABdhPJz9eQvKIrPc8ta+sw34+CJDdEJVNU0OWR59hAmfrup/u3GDs03M3CvU50HHVxV7g2TUwoHwZA==
X-Received: by 2002:a05:6808:128d:: with SMTP id a13mr98463oiw.29.1636394142851;
        Mon, 08 Nov 2021 09:55:42 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c16sm6822645oiw.31.2021.11.08.09.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 09:55:42 -0800 (PST)
Date:   Mon, 8 Nov 2021 09:57:19 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Eric Anholt <eric@anholt.net>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Fix TTBR0 read
Message-ID: <YYlk/2VZCzX6tokf@ripper>
References: <20211108171724.470973-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108171724.470973-1-robdclark@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 08 Nov 09:17 PST 2021, Rob Clark wrote:

> From: Rob Clark <robdclark@chromium.org>
> 
> It is a 64b register, lets not lose the upper bits.
> 
> Fixes: ab5df7b953d8 ("iommu/arm-smmu-qcom: Add an adreno-smmu-priv callback to get pagefault info")
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 55690af1b25d..c998960495b4 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -51,7 +51,7 @@ static void qcom_adreno_smmu_get_fault_info(const void *cookie,
>  	info->fsynr1 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_FSYNR1);
>  	info->far = arm_smmu_cb_readq(smmu, cfg->cbndx, ARM_SMMU_CB_FAR);
>  	info->cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(cfg->cbndx));
> -	info->ttbr0 = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_TTBR0);
> +	info->ttbr0 = arm_smmu_cb_readq(smmu, cfg->cbndx, ARM_SMMU_CB_TTBR0);
>  	info->contextidr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_CONTEXTIDR);
>  }
>  
> -- 
> 2.31.1
> 
