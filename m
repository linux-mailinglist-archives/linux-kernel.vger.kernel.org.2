Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441A6346679
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhCWRf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhCWRfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:35:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57333C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yuj9lOJ+wwKSOTzadLsiPOfR76BWutBwvcTagO1i1qM=; b=PtjvfWwhchC5qjBTK7f/EiRDhF
        urx2vM9Uto+SYnjM+6Qq2dNPrQVY57LLDemOqyBqGtZSwP2vouB3EGSfINgNyGoTHB6A4c5xCCQB1
        NBV8QwSkbpSUetS4AHQPjq/gWfC39flqmLN+CZTvKLFMcyhJscyj3be4TnlIYnxU2Pu35NSyAFkTx
        191rH3x+g4dC2Q1Rf/efYAKbw1rJzCOo6VNZQFsIPSi+0w32FfbbibCXeKxOtSkCFh6wq0rgPS33N
        66SsnGp0GH3K6/55xtTHnvE2h6ko2xZcmICPwlKpjopaxzdYl4b3OmpS+U7MR5S/S71BPnkeLnPjL
        mfN3QuRA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOkuj-00ALZE-E8; Tue, 23 Mar 2021 17:34:11 +0000
Date:   Tue, 23 Mar 2021 17:33:57 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        yi.l.liu@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iommu/vt-d: Remove SVM_FLAG_PRIVATE_PASID
Message-ID: <20210323173357.GD2463754@infradead.org>
References: <20210323010600.678627-1-baolu.lu@linux.intel.com>
 <20210323010600.678627-4-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323010600.678627-4-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 09:05:58AM +0800, Lu Baolu wrote:
> The SVM_FLAG_PRIVATE_PASID has never been referenced in the tree, and
> there's no plan to have anything to use it. So cleanup it.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

But can we take this a little further?  SVM_FLAG_GUEST_PASID is unused
as well.  SVM_FLAG_GUEST_MODE is only used in drivers/iommu/intel/svm.c,
and SVM_FLAG_SUPERVISOR_MODE is actually used as an API flag to
iommu_sva_bind_device.  So IMHO the latter should be elevated to an
IOMMU API level flag, and then include/linux/intel-svm.h can go away
entirely or at least be moved to drivers/iommu/intel/.
