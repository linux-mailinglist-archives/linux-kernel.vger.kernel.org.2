Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F6A341E87
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 14:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhCSNjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 09:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhCSNjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 09:39:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C31C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 06:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zz9OTExqWnVyVHLTeY/MLahbbs3q6nG+4sXDvkfDjns=; b=vvEhNtibtwpUxVKyUI6OVRz4/A
        Qp6liY6gXAiGZ6RXI8w1adnCO4ehL0uPGPiOXmM2YUIwtBkQ0b9MTUTWpRCWH0uwIAm9EXq7cvy4r
        mFxMEk2c6slQ6OMzVB+MXjnNVRGSMn6BFkKrYGsV0SDAZ2lL5rV3jETakxml9M8sqsuAjVdmA3Ti8
        c+h7yJWkjqvnSIPcXt4ImJBOY2tfwjKcwDzX5EACj7kul3zkyWG1CAleFGisTx6qiAyY1DtRSTRfl
        RZV0Egowij7o0BeE27Gc938O0GEDrtNZ7g5MpXzWHdbeRQKSF51FK0pUD1xK5R1KzSQDrcIpM2ybr
        GSwGrIgw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNFLM-004ShW-67; Fri, 19 Mar 2021 13:39:16 +0000
Date:   Fri, 19 Mar 2021 13:39:12 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu: Statically set module owner
Message-ID: <20210319133912.GA1063154@infradead.org>
References: <f4de29d8330981301c1935e667b507254a2691ae.1616157612.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4de29d8330981301c1935e667b507254a2691ae.1616157612.git.robin.murphy@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 12:52:01PM +0000, Robin Murphy wrote:
> It happens that the 3 drivers which first supported being modular are
> also ones which play games with their pgsize_bitmap, so have non-const
> iommu_ops where dynamically setting the owner manages to work out OK.
> However, it's less than ideal to force that upon all drivers which want
> to be modular - like the new sprd-iommu driver which now has a potential
> bug in that regard - so let's just statically set the module owner and
> let ops remain const wherever possible.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> This is something I hadn't got round to sending earlier, so now rebased
> onto iommu/next to accommodate the new driver :)

Ah, nice.  That __iommu_device_set_ops dance always confused me.

Reviewed-by: Christoph Hellwig <hch@lst.de>
