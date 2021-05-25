Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA38938F92F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 06:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhEYEGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 00:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhEYEGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 00:06:48 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DD2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 21:05:19 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id j75so29040278oih.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 21:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=omc7Lbht3vsFqQrJHKPy+phsOveVTMec9psAq7xUFRs=;
        b=lW+ENjoppyZF+M3teNJqDMhEM4jS7ukPBgTud4oBZ9PjDHRDiw/ZalyLv3P7S1t/dW
         GsxOszVqbzg66xOE12z9mRNUAgBKAgXjLlB93kLAxVcw3iU+vyMZZyNlQn8W0DrcgMld
         P0L5+d5+zKJu5uUZzjiB3pxtUXdH016j5DdHQm92AsU9kzotvHyXUZbeOBCUX2JRzeRl
         RWFH/Ae1ePShA4IlZjvuVTRnC7lPGBtWon0Zpm3PCpir6h42m5sMvpe3k20l3p1+jTgU
         dTE2lAD2CKtu9e9aMWj6fhemH8xeo5e+HedHj8KbrSe/3n0Y7XJbWkz+cABGLpdo7G9D
         6vMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=omc7Lbht3vsFqQrJHKPy+phsOveVTMec9psAq7xUFRs=;
        b=qMb5ULfx5Dui0Yv3j1PyEySLKQqecyB1F5WKCIrxJLCSGobX32uUkrhY8ywqwanUHo
         7sdJYAH+a8tpsPGH0mvguVdxivxLD8XDZXy1D2NLRK+avJlgxEM/e3+S30SyxgPLqZNl
         Gb3OWso7pZhyQ/xnfEBd2CexXq3DHjgFI/yid34sRY5c4MtlSC80rbhkaWcSCrDjt6oc
         5wMWBuLl81gTg0IOkFmFYh1T9JeWf6ahTPVFYVuToqfFzFA7+meBT7Jh3SWAmw1dbAuU
         2aEHchu7f6CHLyRZl8TdfkyCe8C5EGl6CR0uGrpcTkLWyCw1BqG7ynx5LGZ9+w8ssGMY
         udsg==
X-Gm-Message-State: AOAM5310ImeVcfey1bU5bsQVW9DroT3oGb3GyuQRn+5gPiOBEqwRDyzt
        /RK/chNjANiduix3PpPkU3smsA==
X-Google-Smtp-Source: ABdhPJyof/NZ4txSI58nh7ZFjrxTbmlqvpY83qtBXTXzytVbcaY/hbiBaivTbN/C5bYEqngzrFImeg==
X-Received: by 2002:a05:6808:d47:: with SMTP id w7mr12999594oik.104.1621915518726;
        Mon, 24 May 2021 21:05:18 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r124sm3038199oig.38.2021.05.24.21.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 21:05:18 -0700 (PDT)
Date:   Mon, 24 May 2021 23:05:16 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Martin Botka <martin.botka@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Rob Clark <robdclark@chromium.org>,
        John Stultz <john.stultz@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] iommu: arm-smmu-qcom: Add sm6125 compatible
Message-ID: <YKx3fHytiRkLXUW/@yoga>
References: <20210523212535.740979-1-martin.botka@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210523212535.740979-1-martin.botka@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 23 May 16:25 CDT 2021, Martin Botka wrote:

> Add compatible for SM6125 SoC
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

But please, don't forget to update the dt-binding.

Regards,
Bjorn

> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
> Changes in V2:
> Add commit description
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 98b3a1c2a181..7455bcc92f43 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -333,6 +333,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>  	{ .compatible = "qcom,sc8180x-smmu-500" },
>  	{ .compatible = "qcom,sdm630-smmu-v2" },
>  	{ .compatible = "qcom,sdm845-smmu-500" },
> +	{ .compatible = "qcom,sm6125-smmu-500" },
>  	{ .compatible = "qcom,sm8150-smmu-500" },
>  	{ .compatible = "qcom,sm8250-smmu-500" },
>  	{ .compatible = "qcom,sm8350-smmu-500" },
> -- 
> 2.31.1
> 
