Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007763C336F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 09:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhGJHIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 03:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbhGJHIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 03:08:00 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5988C0613DD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 00:05:15 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id b12so10884085pfv.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 00:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NyelH3y/Sii7PCvkumT3IvAArvEB9YXUeii5v7j0syg=;
        b=ej+0sNuNNat0KE9bTIFKRP3jvF3IVHdpZRQVd6NLSVB28jEsDw0mk5ks6v/pvu4YGR
         PxWl9bsnKhrjJBhj5MaLxCcZyRKwOpMSmqF7Wg9cFRuNr1uijseCpES9gt9RMkissZnA
         Y80EXBB3mEjif194IEWYktBKRHnAyDaDpSVSvD2GQrbSoEEnwjIIfBFMOyD93qazqW2C
         7Jh8PucurSVmXZ/aA8SlJDFRMag4wqM5trDo6xIO38fT9TUk65aweePEMR/hl7l+BxMs
         xqULkEoKf12A4ml2KU8Ivbpv8ayDd/eUQ0eS5bWhze81NQ9PydPqLckL9cOXYWkDo3r5
         36/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NyelH3y/Sii7PCvkumT3IvAArvEB9YXUeii5v7j0syg=;
        b=W5TZbtGQ1uSRQOBGBjTPLj0uoJYWLzHjbgSG8xkgZghUZkTr7/QGXslTxmAMoaejGb
         KTiAEkrO5zDexwtmgurmNeAshF3Mp3esng6HDHlNNkXLqTjOhuOTeD7NCQg2Ih4IPL/j
         DqO4TGJijimQwt3egI6NjDBY0vWCkDQm31d9xtQBTP2pdT/kNN8wCykM9XDro0gIVKW0
         hdpn1V2NvBIEpyHvwRIHENMlxNJyjKcQqMq9YiPaJeQUmvYsx5q5q1oDiyra9EMbbzL2
         SV+Mx1HYcK1mv2nn4lGvTv8XRBVndoFUAieZ8osCjqGS2WX0Sh3P+uhLCpSpvBKSPOah
         KiOg==
X-Gm-Message-State: AOAM533B377ApiD630o/oOFAX5SWAPyWnUwpnG6QXrXy9QyLDMCnm8RC
        PqcbOt7JPKG0MU3qnpSP3Mdbmg==
X-Google-Smtp-Source: ABdhPJyTt9ua5bgo9EOj/fAnBbinirlp0+fwpueIPjCZCx3LPza4hc9vG92Nc+5IYw3IO8dTkY71Fw==
X-Received: by 2002:a62:2ec7:0:b029:301:fe50:7d4b with SMTP id u190-20020a622ec70000b0290301fe507d4bmr41511393pfu.78.1625900715175;
        Sat, 10 Jul 2021 00:05:15 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.131.71.237])
        by smtp.gmail.com with ESMTPSA id i8sm8428557pfo.154.2021.07.10.00.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 00:05:14 -0700 (PDT)
Date:   Sat, 10 Jul 2021 15:05:09 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] coresight: tmc-etr: Speed up for bounce buffer in
 flat mode
Message-ID: <20210710070509.GB273828@leoy-ThinkPad-X240s>
References: <20210710050046.414669-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210710050046.414669-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Sat, Jul 10, 2021 at 01:00:46PM +0800, Leo Yan wrote:

[...]

> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -21,6 +21,7 @@
>  
>  struct etr_flat_buf {
>  	struct device	*dev;
> +	struct page	*pages;
>  	dma_addr_t	daddr;
>  	void		*vaddr;
>  	size_t		size;
> @@ -600,6 +601,7 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
>  {
>  	struct etr_flat_buf *flat_buf;
>  	struct device *real_dev = drvdata->csdev->dev.parent;
> +	ssize_t	aligned_size;
>  
>  	/* We cannot reuse existing pages for flat buf */
>  	if (pages)
> @@ -609,12 +611,17 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
>  	if (!flat_buf)
>  		return -ENOMEM;
>  
> -	flat_buf->vaddr = dma_alloc_coherent(real_dev, etr_buf->size,
> -					     &flat_buf->daddr, GFP_KERNEL);
> -	if (!flat_buf->vaddr) {
> -		kfree(flat_buf);
> -		return -ENOMEM;
> -	}
> +	aligned_size = PAGE_ALIGN(etr_buf->size);
> +	flat_buf->pages = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO,
> +					   get_order(aligned_size));
> +	if (!flat_buf->pages)
> +		goto fail_alloc_pages;
> +
> +	flat_buf->vaddr = page_address(flat_buf->pages);
> +	flat_buf->daddr = dma_map_page(real_dev, flat_buf->pages, 0,
> +				       aligned_size, DMA_FROM_DEVICE);
> +	if (dma_mapping_error(real_dev, flat_buf->daddr))
> +		goto fail_dma_map_page;
>  
>  	flat_buf->size = etr_buf->size;
>  	flat_buf->dev = &drvdata->csdev->dev;
> @@ -622,23 +629,34 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
>  	etr_buf->mode = ETR_MODE_FLAT;
>  	etr_buf->private = flat_buf;
>  	return 0;
> +
> +fail_dma_map_page:
> +	__free_pages(flat_buf->pages, get_order(aligned_size));
> +fail_alloc_pages:
> +	kfree(flat_buf);
> +	return -ENOMEM;
>  }
>  
>  static void tmc_etr_free_flat_buf(struct etr_buf *etr_buf)
>  {
>  	struct etr_flat_buf *flat_buf = etr_buf->private;
>  
> -	if (flat_buf && flat_buf->daddr) {
> +	if (flat_buf && flat_buf->vaddr) {

I found here I introduced an unexpected change for checking
"flat_buf->vaddr", we should still check "flat_buf->daddr".

Sent patch v2 to address this issue; please directly review patch
v2.

Thanks,
Leo
