Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA02F3DB5E6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 11:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbhG3J2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 05:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhG3J2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:28:50 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BD9C061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:28:45 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x90so12216656ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WxhlzYrYV28az1jXTH92aNSQMW4lNS5B9o0J3BKptsc=;
        b=RVTBKHUPkJGMHQr5TC6/sYRTWrnQgV3jEyRw4RI12fsX+efJSbQOhg3RVAAi0s0MmJ
         D+m9kebK87MkoNUf56TrmJECOkAiYn4jnIuQ0nCu8rGxKrbO0nLoWm+cSP67lKVlxLqJ
         HwbJTvz2w7/kBbdJUZ9sq93DTHT8/TqYPx7lLdYbnSke0ukvdHFP5F5YO1ghHVG/eRoF
         GLM4x2/TJ9VwtOmeVkOyA66sPajVF5QZtCxzYZjUsXALSiF8ByP5s+ThBviMql30Q77M
         fVHU7R1/0CL8c2FK/CBc/a0i4zbQHqM9FlGS82CbnuzBEejzJK+yLwr1Dz9yCxfmidhV
         1jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WxhlzYrYV28az1jXTH92aNSQMW4lNS5B9o0J3BKptsc=;
        b=KHIwXZUMBCwrmloSo1Bq5BwtC5+QkAB7dvYmtCt/7QbKlwlMyyZWtRzblwVhAhjeoN
         bZkGTYb7VuMsd7mQhyWtcFA7Kg8mGbjoaR70m5U54cD7vuPkcQJNtDc0OZO3PmG2NaqA
         cbSBN993bLw+G1p4gxEcusfI+wXV/3z/yblWj+AUAZTycX2yZMFeV7orql/Tpak+LdN2
         Np4L0otrhNF8ubdSEu9vZdWkbUGE2iA8J1ShJnsK8a1TCQW2KUD1pOX76MZpC+m7V7GT
         Fzc/mJun24N17ee8hrM9dQ1v1Kvkm5soWsJL1VsMuaWMpGoZXwsvjqKAwf+UJYbdpBG3
         YxXg==
X-Gm-Message-State: AOAM532cs/7TNSp144uF5OUBmFBY346gX0q53/5YUcuDKLpt3qvNV5bH
        3WbitZU94WA6WAEZ+QXUkaekNQ==
X-Google-Smtp-Source: ABdhPJz7v59AkGLe4ncF8sDSsbs4m/88saDYcXaP0lDGk9+fMwno6QtbmMRD+lr3lYSTMH8XQi1Rcg==
X-Received: by 2002:aa7:dbc8:: with SMTP id v8mr1860784edt.242.1627637324222;
        Fri, 30 Jul 2021 02:28:44 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id fr4sm367026ejc.42.2021.07.30.02.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 02:28:43 -0700 (PDT)
Date:   Fri, 30 Jul 2021 11:28:23 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 19/24] iommu: Expose DMA domain strictness via sysfs
Message-ID: <YQPGNxhgVEagZ28H@myrica>
References: <cover.1627468308.git.robin.murphy@arm.com>
 <dd26592103c7613ef9fdff703d0d2ed2df8305c2.1627468310.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd26592103c7613ef9fdff703d0d2ed2df8305c2.1627468310.git.robin.murphy@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 04:58:40PM +0100, Robin Murphy wrote:
> The sysfs interface for default domain types exists primarily so users
> can choose the performance/security tradeoff relevant to their own
> workload. As such, the choice between the policies for DMA domains fits
> perfectly as an additional point on that scale - downgrading a
> particular device from a strict default to non-strict may be enough to
> let it reach the desired level of performance, while still retaining
> more peace of mind than with a wide-open identity domain. Now that we've
> abstracted non-strict mode as a distinct type of DMA domain, allow it to
> be chosen through the user interface as well.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  Documentation/ABI/testing/sysfs-kernel-iommu_groups | 2 ++
>  drivers/iommu/iommu.c                               | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-iommu_groups b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
> index eae2f1c1e11e..43ba764ba5b7 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-iommu_groups
> +++ b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
> @@ -42,6 +42,8 @@ Description:	/sys/kernel/iommu_groups/<grp_id>/type shows the type of default
>  		========  ======================================================
>  		DMA       All the DMA transactions from the device in this group
>  		          are translated by the iommu.
> +		DMA-FQ    As above, but using batched invalidation to lazily
> +		          remove translations after use.

It might be useful to desribe the security/performance tradeoff here as
well. I guess a normal user is more likely to look at the doc for this
sysfs knob than the kernel config or parameters.

Thanks,
Jean

>  		identity  All the DMA transactions from the device in this group
>  		          are not translated by the iommu.
>  		auto      Change to the type the device was booted with.
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index eecb5657de69..5a08e0806cbb 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3265,6 +3265,8 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
>  		req_type = IOMMU_DOMAIN_IDENTITY;
>  	else if (sysfs_streq(buf, "DMA"))
>  		req_type = IOMMU_DOMAIN_DMA;
> +	else if (sysfs_streq(buf, "DMA-FQ"))
> +		req_type = IOMMU_DOMAIN_DMA_FQ;
>  	else if (sysfs_streq(buf, "auto"))
>  		req_type = 0;
>  	else
> -- 
> 2.25.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
