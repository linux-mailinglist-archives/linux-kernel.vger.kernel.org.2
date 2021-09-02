Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CA23FEE26
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344690AbhIBMzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbhIBMze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:55:34 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6588C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 05:54:36 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so1386753pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 05:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0ep4NCpmYbrJnytWXXjt0p8Pd2myd+G98CcinMn3pzU=;
        b=PmqrxALEt7K+mMlScjFji7LT+6SiSbaGn1vwwSnCUaukPorGQoGY5g94MqESofpEPL
         e5eXj4rwxqkhXS+WHQhsdADZqFpY0VP90N3aLIVWyIhXrz4PDoVVnjLc0n20amL59yMk
         zdzWbmCXYvIakxY5OLboaK/BvePNcasDyKUTKJoqMedbIat8taXi2+Fo74QDibtgGAk6
         6ZEZolCt3RvkGBPW707/ejWXOgz2EqEMs7C9H97NjFyxbzJOrGv9mqWG/IoNzSEAar9V
         YP52DB2G/Ic0rCC4+uvViNQSYQ/lZPYEJNP81ATew21MgQp2n78+XqJT+DnOKJ7XMs44
         Vv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0ep4NCpmYbrJnytWXXjt0p8Pd2myd+G98CcinMn3pzU=;
        b=YSRR7uyDZCFCHckul9Q83Z3i4ydivoUUpSEPAF/CB3CdDK93DY3Ryp3RhFWNFnv7/b
         y4oOX2Sxa4hMPEbKMWnYkWVqjjH3TGqXPIgLytrSdcZF7rfMSiKnzgmh4uyy3w0+HW+C
         3b6XTzkwraJO+lL6mmKOh+lKRgNytYooxtrdbVfN7A2csWSKb9BlhSeQijm2pvWauIFv
         12pOiV5PIsFxb42XqAGbYmPkc0hDD1qhKtjxEmmFOhp/Z4BSSMqwiqJrPhZdQ2JQsjIT
         hnsN87Gq1UXGbfoZdoBZJD8LcB17z94HbuQOFEfAas3W29MDaUX4NOxYIqY9lmDxXYnj
         h5PA==
X-Gm-Message-State: AOAM532WiaY9sx2iJFZ313uam58KcunqHpwTuTAC90ol/ZRQmMUqvuub
        8w4lV0FQdGBBHPHk6F++TACfDA==
X-Google-Smtp-Source: ABdhPJwMHvXJUO6+PV/yrdv1OrvDvNdZRuRp/gFnWCh8ydT7wdMCtYKf8bnfE+Qgmas84tJeeBT0Ag==
X-Received: by 2002:a17:902:d717:b0:133:a5f6:6be6 with SMTP id w23-20020a170902d71700b00133a5f66be6mr2850570ply.14.1630587276206;
        Thu, 02 Sep 2021 05:54:36 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([213.173.35.225])
        by smtp.gmail.com with ESMTPSA id n1sm2344644pfv.209.2021.09.02.05.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 05:54:35 -0700 (PDT)
Date:   Thu, 2 Sep 2021 20:54:31 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] coresight: tmc-etr: Speed up for bounce buffer in
 flat mode
Message-ID: <20210902125431.GI303522@leoy-ThinkPad-X240s>
References: <20210829135409.186732-1-leo.yan@linaro.org>
 <a94acd88-dab9-048d-ed9b-b4cac6c4d794@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a94acd88-dab9-048d-ed9b-b4cac6c4d794@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wed, Sep 01, 2021 at 09:03:30PM +0100, Robin Murphy wrote:

[...]

> > @@ -600,6 +601,7 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
> >   {
> >   	struct etr_flat_buf *flat_buf;
> >   	struct device *real_dev = drvdata->csdev->dev.parent;
> > +	ssize_t	aligned_size;
> >   	/* We cannot reuse existing pages for flat buf */
> >   	if (pages)
> > @@ -609,11 +611,18 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
> >   	if (!flat_buf)
> >   		return -ENOMEM;
> > -	flat_buf->vaddr = dma_alloc_coherent(real_dev, etr_buf->size,
> > -					     &flat_buf->daddr, GFP_KERNEL);
> > -	if (!flat_buf->vaddr) {
> > -		kfree(flat_buf);
> > -		return -ENOMEM;
> > +	aligned_size = PAGE_ALIGN(etr_buf->size);
> > +	flat_buf->pages = alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO,
> > +					   get_order(aligned_size));
> > +	if (!flat_buf->pages)
> > +		goto fail_alloc_pages;
> > +
> > +	flat_buf->vaddr = page_address(flat_buf->pages);
> > +	flat_buf->daddr = dma_map_page(real_dev, flat_buf->pages, 0,
> > +				       aligned_size, DMA_FROM_DEVICE);
> 
> Use dma_alloc_noncoherent() rather than open-coding this - bare
> alloc_pages() has no understanding of DMA masks, and you wouldn't want to
> end up in the worst case of dma_map_page() bounce-buffering your bounce
> buffer...

Will refine the code with dma_alloc_noncoherent(); it's much reliable
than the self writing code.

Thanks a lot for the suggestion!
