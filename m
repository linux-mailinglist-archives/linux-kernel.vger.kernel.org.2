Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA5237B63D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 08:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhELGkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 02:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhELGkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 02:40:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0726C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 23:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qT8iDHBtgV77fF8gHSSRJsweWuoLwMxssud1SQ+sMFw=; b=ekg1E450CgRxJwrigDD4HIGXvy
        qTLJcWMI7uNPCzwaWsYYZF/KX0n2Euqn1nzZ8/r3VogDq44psgbEO5tjSxh25+ixKgYQqfeO1nHb8
        hNsnEjGZyXAWFndfUAd/TDMgtXwovpIXfh1ahU9khrB8jQ/bQlEXYRkiQNMXWk41ULbwH1hjsBQUV
        X4a9KsTuYG/ix1dW2e7d+x9efrRhnwZd1yyzfTRSyXa+3BfvYk3DBa0FDiS849nDIE/JEdiCD0ctD
        3Eg1wbBhKB1LxgX3bphe3vXT+rykAg0mfG5Qc5xG5C6lHZkAuoYgqn5sVobKMp2bSZ1Oi8K0fDshc
        0WfcCPuQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgiV2-0081QQ-2F; Wed, 12 May 2021 06:37:54 +0000
Date:   Wed, 12 May 2021 07:37:40 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Christoph Hellwig <hch@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, wangzhou1@hisilicon.com,
        zhangfei.gao@linaro.org, vkoul@kernel.org,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit
 flags
Message-ID: <YJt3tGlzFK3b4E82@infradead.org>
References: <1620653108-44901-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210510233749.GG1002214@nvidia.com>
 <20210510203145.086835cc@jacob-builder>
 <20210511114848.GK1002214@nvidia.com>
 <20210511091452.721e9a03@jacob-builder>
 <20210511163521.GN1002214@nvidia.com>
 <20210511110550.477a434f@jacob-builder>
 <20210511194726.GP1002214@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511194726.GP1002214@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 04:47:26PM -0300, Jason Gunthorpe wrote:
> > Let me try to break down your concerns:
> > 1. portability - driver uses DMA APIs can function w/ and w/o IOMMU. is
> > that your concern? But PASID is intrinsically tied with IOMMU and if
> > the drivers are using a generic sva-lib API, why they are not portable?
> > SVA by its definition is to avoid map/unmap every time.
> 
> Kernel explicitly does not support this programming model. All DMA is
> explicit and the DMA API hides platform details like IOMMU and CPU
> cache coherences. Just because x86 doesn't care about this doesn't
> make any of it optional.

Exactly.

> If you want to do SVA PASID then it also must come with DMA APIs to
> manage the CPU cache coherence that are all NOP's on x86.

Yes.  And we have plenty of precende where an IOMMU is in "bypass" mode
to allow access to all memory and then uses the simple dma-direct case.
