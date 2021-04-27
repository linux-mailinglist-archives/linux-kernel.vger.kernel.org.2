Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AD336CBB4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 21:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbhD0Tco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 15:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbhD0Tcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 15:32:43 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89963C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 12:31:59 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id q25so17294338iog.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 12:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z2dfVSyAhAt8vgpBqMWbMDHuRDstq7cheYx2I0gCKqA=;
        b=f+N9LA0t4CUwDpMHIjT1MaiOY0YP0yEI1fdCq6n/9G2sApcPu0kfC7g65PrZSCas0q
         et2NNQvtx3ytlLSajvn/g9dwQLy9IwqF1tmAC4Z2Wbb5I+Ch5gtBC1EMrWz4jvcK7cRt
         BzVK1SMsB3tJk0fk7jkLyb2kxQrjE4ZWpPcEIZ7o4pMgr6mhJqYb+dQUMgERAwDuQnuT
         HZjT+3IRZb6PI3RPSgOlfb2kyWKwrBOn3yf7eoc9FCkyAhJ/Wgl0HqJKfJ1IUrN5ptMx
         F66dcUTstJRLGIfvFqeC68gHCYIb4UfUh4NvcMqsFPQso8Hhnq5J0oEUDdR/Ozo03mHZ
         ak0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z2dfVSyAhAt8vgpBqMWbMDHuRDstq7cheYx2I0gCKqA=;
        b=Q2i8OqdWSNJ+uttVec0SFSM6jxgcMG6TN5ezV4bK4zieWVnyi/USgBcbdF+9Gaibol
         Dhvfl0/i4n0f5KpyVvZq3zNyMghVJsOg3KDcYYszSSpaCdNaoyMPoTk5vGRhnOwmjm00
         6DQUod7GP3Gocuw6XIU6abJbKqEWJOUmAGaUBH+scEQjl/ckpQr/kPxvV+D4vWDU8nHW
         bTGHFQ7ZHYIAM51W/FH6+a1419zKlOeuFCKXAQ3oqhr8u90OaME4H6Zgjh30LGPlfqlD
         Vji6CCC4DV5bN1xBBeiryKVGR1le5eWcqHhEn+LMe0cTLYGDORDVTnxcUGVWDNHyUEbm
         YpWw==
X-Gm-Message-State: AOAM532DFJ174u/SM5e47D1n1vMib02eqLNVeBuLxyIJVkKahNJ7OqPV
        c2lL9fZOEWf92Bn9yicePUv7mw==
X-Google-Smtp-Source: ABdhPJz1PrEuptJElb3400TY97NuVzdikMTMhxSGmMRmyGUliOenKdPiL7SsLe1HAEp58UA3cwiqXQ==
X-Received: by 2002:a5d:84c5:: with SMTP id z5mr20535269ior.33.1619551919040;
        Tue, 27 Apr 2021 12:31:59 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id d8sm340022iow.25.2021.04.27.12.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 12:31:58 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lbTR7-00Dgv4-Ig; Tue, 27 Apr 2021 16:31:57 -0300
Date:   Tue, 27 Apr 2021 16:31:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
Message-ID: <20210427193157.GQ2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-6-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408170123.8788-6-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 11:01:12AM -0600, Logan Gunthorpe wrote:
> +/*
> + * dma_maps_sg_attrs returns 0 on error and > 0 on success.
> + * It should never return a value < 0.
> + */

Also it is weird a function that can't return 0 is returning an int type

> +int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
> +		enum dma_data_direction dir, unsigned long attrs)
> +{
> +	int ents;
> +
> +	ents = __dma_map_sg_attrs(dev, sg, nents, dir, attrs);
>  	BUG_ON(ents < 0);

if (WARN_ON(ents < 0))
     return 0;

instead of bug on?

Also, I see only 8 users of this function. How about just fix them all
to support negative returns and use this as the p2p API instead of
adding new API?

Add the opposite logic flag, 'DMA_ATTRS_NO_ERROR' and pass it through
the other api entry callers that can't handle it?

Jason
