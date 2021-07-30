Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224D53DB5C9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 11:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbhG3JU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 05:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbhG3JU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:20:56 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A224C061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:20:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id hw6so1733504ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yScgO+5K8kMvLXSdgAzUDbgBygVn2oY3p7co+ejC8RY=;
        b=uyMWYyaeqqDhutMdu8v6DlYLjabZMV/k588QHhkknUzmU0ef6XiKJGZUjdSB9McEjG
         UxMPoRZTxUmiVR3QmfCAQT7DTXR4ine1XyMgl3TWEygtL5mWPaczA25AkqXZ9MKHjPm7
         BXh2sVGR3V7IAMJ1zBfSeyiVJ1kZUnV/tRAyP0A0RETO60FXQb9s+utY77i+iOGBcEWi
         EbZ4102Ds71YqzCfnk98PsMuxZCKL8NtXPcuxnCdwwRjylKJkFWFYbJA7FyWFp+Hsyuj
         MUA1J6wN21nMVcVAvsmEYTAANme/cKhG9/aACc2p6v2tq+T7UhlVPNzMx/lO7wv9LmCG
         v/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yScgO+5K8kMvLXSdgAzUDbgBygVn2oY3p7co+ejC8RY=;
        b=LqyyiLIQoC2Q6Jh0rKa1lARY/TS7VCs+ytpolO8pDaAVPBaKfmxanrAeyjwzcelim+
         BdFAFLAOu9yKPZ5TYruBKy5tbN6AhTSogrLCm2NJxLG5pqHB5sPuaSI5Y8brSF0vc/7/
         2luZK7eQGd+FvlKk/uliuFSihbw0IVxnAQwzwAhqLPlMXjt2p7XfT4BXr9AJoJgOtUjm
         c0GMBFE+wFftcBX2wL4sNC6cM/ZzjK7NmEdYmUJprWi9B1HmeV0y37h8oXMeHsodXD7y
         95hJ95eEXKSpLcp3l55ua/rLtrgQ78GvqWSpAiP0tYwnwsGVIfp186M/6JHYK+U9YBvb
         T4mQ==
X-Gm-Message-State: AOAM530MRUlIYcNgz/WXNNu62O+Wkvf55wxPTaN9d7X88Wkim1iNiryJ
        UDNXSKb/IYSvqUIeAF73EtXu0A==
X-Google-Smtp-Source: ABdhPJyvE+/FXDDFFPKn2vjWz2vToufjMHW31XnzNuOnMPZO+Nf9/mHtMwMoKC91LEbUZQzAEhlPaQ==
X-Received: by 2002:a17:906:2497:: with SMTP id e23mr1696642ejb.194.1627636848490;
        Fri, 30 Jul 2021 02:20:48 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id f20sm355006ejz.30.2021.07.30.02.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 02:20:47 -0700 (PDT)
Date:   Fri, 30 Jul 2021 11:20:27 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 11/24] iommu/virtio: Drop IOVA cookie management
Message-ID: <YQPEWzJq+7Jfu9+/@myrica>
References: <cover.1627468308.git.robin.murphy@arm.com>
 <d9f524e29a580d094c7f9a7322e1bea6f3637c19.1627468309.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9f524e29a580d094c7f9a7322e1bea6f3637c19.1627468309.git.robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 04:58:32PM +0100, Robin Murphy wrote:
> The core code bakes its own cookies now.
> 
> CC: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Also tested on the Seattle (vsmmuv3/viommu with lazy/strict, still need to
test the runtime switch).

> ---
>  drivers/iommu/virtio-iommu.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 6abdcab7273b..80930ce04a16 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -598,12 +598,6 @@ static struct iommu_domain *viommu_domain_alloc(unsigned type)
>  	spin_lock_init(&vdomain->mappings_lock);
>  	vdomain->mappings = RB_ROOT_CACHED;
>  
> -	if (type == IOMMU_DOMAIN_DMA &&
> -	    iommu_get_dma_cookie(&vdomain->domain)) {
> -		kfree(vdomain);
> -		return NULL;
> -	}
> -
>  	return &vdomain->domain;
>  }
>  
> @@ -643,8 +637,6 @@ static void viommu_domain_free(struct iommu_domain *domain)
>  {
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
>  
> -	iommu_put_dma_cookie(domain);
> -
>  	/* Free all remaining mappings (size 2^64) */
>  	viommu_del_mappings(vdomain, 0, 0);
>  
> -- 
> 2.25.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
