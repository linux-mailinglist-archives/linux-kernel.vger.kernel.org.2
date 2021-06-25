Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBF53B3B44
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 05:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhFYDlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 23:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbhFYDlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 23:41:47 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E53C061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 20:39:26 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so7951134oti.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 20:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NgBcYRoIlctACD+L2YYbad3iw3ek5NyZ4dgv7eQ3Lxs=;
        b=d5Z7R72WbYSoShvKXvQHAJXVwL9hbpA/qb5R/LJlrIh+pVPidB5zbsT9XIsS2eBFAt
         UJ47Eqc334KXUncOythdccWWcpLa66oC85s02pMEYC9A54iPhc3Mhix+k6aEAP+K9W2R
         nxQhXV4ZJJ4+gf11TL6cIq92u+Cc0itFy6GYLedkbkJpC9JU32x6vKXlKxK/HsF+iL0o
         Spw5qiiteoNzA7/ruwNUEyNFWsZOnWjDCh7F/JIiLGmvk8bRAmXhOBcMvC6vOPwi5WbT
         SnJzGZ1JwYqdDihOS3zBQevpoQ+h9uJPXUg3PpaYmnpR+LohY+sA6d0IvlDkWMkGYOpc
         vxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NgBcYRoIlctACD+L2YYbad3iw3ek5NyZ4dgv7eQ3Lxs=;
        b=d9eBtMzDwZmmsbuByLZlg4gMad7/39VhHwIsJETpoi4GJ4tF/rlFf4mFYyPaajCGfY
         CRxvHb+o2ybWyqD/uwOunocAZvSvP1GVdPtV1vTrKEcLXvdbL7PcilOaCRfD9giNuIUQ
         iqzZpzk8R/3Y1vNUKwSRZER2hWvNc0yhgDucx78raFi890U3Pw4Gcc+6oSLqZldPvgJy
         NzQ6uNnljrVraDuEdpcCSNoMPU8VgUDAKG2MgaUF7VQuwcgmHhvQRg3EBj1QmuTnySc6
         ecfipsTOkaVs1AUTRzZPN7g91HLuxhkEbf/LZHM2UckHLWDiuBwS8Yb1pOirAC9MSBi/
         6wfQ==
X-Gm-Message-State: AOAM533rEOmbWN/ntLV4UK68H7wqwyDlKpsNQSs8z/8q1IfDVHtzUhPu
        7YQUI8RdbXjN/uCrDsHLnzRpSw==
X-Google-Smtp-Source: ABdhPJxICvy4DH/gmlYi4aOPrUOcJ+WDYuzwO6ESj2tt39upXIdEx5yfKOxDmtDKbeC3lx3i+SQnUg==
X-Received: by 2002:a9d:1e5:: with SMTP id e92mr5472028ote.353.1624592365276;
        Thu, 24 Jun 2021 20:39:25 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t21sm1140288otd.35.2021.06.24.20.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 20:39:24 -0700 (PDT)
Date:   Thu, 24 Jun 2021 22:39:22 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org,
        Sharat Masetty <smasetty@codeaurora.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sean Paul <sean@poorly.run>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        "Kristian H. Kristensen" <hoegsberg@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        freedreno@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/5] drm/msm: Improve the a6xx page fault handler
Message-ID: <YNVP6rfQ699BejsI@yoga>
References: <20210610214431.539029-1-robdclark@gmail.com>
 <20210610214431.539029-4-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610214431.539029-4-robdclark@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10 Jun 16:44 CDT 2021, Rob Clark wrote:
[..]
> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> index 50d881794758..6975b95c3c29 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -211,8 +211,17 @@ static int msm_fault_handler(struct iommu_domain *domain, struct device *dev,
>  		unsigned long iova, int flags, void *arg)
>  {
>  	struct msm_iommu *iommu = arg;
> +	struct adreno_smmu_priv *adreno_smmu = dev_get_drvdata(iommu->base.dev);
> +	struct adreno_smmu_fault_info info, *ptr = NULL;
> +
> +	if (adreno_smmu->get_fault_info) {

This seemed reasonable when I read it last time, but I didn't realize
that the msm_fault_handler() is installed for all msm_iommu instances.

So while we're trying to recover from the boot splash and setup the new
framebuffer we end up here with iommu->base.dev being the mdss device.
Naturally drvdata of mdss is not a struct adreno_smmu_priv.

> +		adreno_smmu->get_fault_info(adreno_smmu->cookie, &info);

So here we just jump straight out into hyperspace, never to return.

Not sure how to wire this up to avoid the problem, but right now I don't
think we can boot any device with a boot splash.

Regards,
Bjorn

> +		ptr = &info;
> +	}
> +
>  	if (iommu->base.handler)
> -		return iommu->base.handler(iommu->base.arg, iova, flags);
> +		return iommu->base.handler(iommu->base.arg, iova, flags, ptr);
> +
>  	pr_warn_ratelimited("*** fault: iova=%16lx, flags=%d\n", iova, flags);
>  	return 0;
>  }
