Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC16F30E157
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 18:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhBCRp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 12:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhBCRp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 12:45:27 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA265C0613D6;
        Wed,  3 Feb 2021 09:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=9KPYi1ZkyDHL7NUtRviqQ04hmYB82hAl0iGOYO+e6lE=; b=n2V4w7nv98vN71CUuyoViod1A8
        VZsyXrEwuYNtnxrBrW71oyF0c+dby6fBxgSSKt8o398+DZFnniydLWvY8vPctZubrpEWm7xrVeBrP
        Gr2bFKiZdVQY4N+x6pt4vgVBNMnBeGCf+RcbZNB7BfESglpqbiHXFXoDmwJC5WnUsohcHgCoRZ+nq
        FY1+CyDAsx+O+CxA5c8fx5AJEIau7MEq3d7g+O/5pJS7D7crdGe8LJsephVEA2o8it+p7y9n+QqOG
        /9yyAXCAPnwGaui1UGWIA9zyJXE9v0WTNteA16Df3Q1nT9feVz3Wv3xbBv2O3CmHHTUcOmDWuqaHS
        3DH+fk0w==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7MCh-0001xN-Gk; Wed, 03 Feb 2021 17:44:35 +0000
Subject: Re: [PATCH v3 2/2] iommu: add Unisoc iommu basic driver
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
References: <20210203090727.789939-1-zhang.lyra@gmail.com>
 <20210203090727.789939-3-zhang.lyra@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <eb55a1de-2816-9029-b642-b3067e311417@infradead.org>
Date:   Wed, 3 Feb 2021 09:44:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210203090727.789939-3-zhang.lyra@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 1:07 AM, Chunyan Zhang wrote:
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 192ef8f61310..99e7712f3903 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -408,4 +408,16 @@ config VIRTIO_IOMMU
>  
>  	  Say Y here if you intend to run this kernel as a guest.
>  
> +config SPRD_IOMMU
> +	tristate "Unisoc IOMMU Support"
> +	depends on ARCH_SPRD || COMPILE_TEST
> +	select IOMMU_API
> +	help
> +	  Support for IOMMU on Unisoc's SoCs, this iommu can be used by

	s/iommu/IOMMU/ please

> +	  Unisoc's multimedia devices, such as display, Image codec(jpeg)
> +	  and a few signal processors, including VSP(video), GSP(graphic),
> +	  ISP(image), and CPP(camera pixel processor), etc.
> +
> +	  Say Y here if you want to use the multimedia devices listed above.


-- 
~Randy
