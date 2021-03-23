Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AA4346648
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhCWR1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbhCWR11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:27:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198FBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L5dFTyCaSNfaB9YJWhZaMNMyn1Bz//1qVMaB8rmLs2o=; b=e1H9ZYlZwj7JfhkW4XKra6Or6S
        AVthsN0BACiP0ZggL1LeDnaV6+hPlQM2pgyPTUlmzD4hvJq3nsjR7+wAmzl+2hB3TecJb8kY86bsN
        obAQ+tiZmX7RJe7ynqeg3mZsg3B6FQ/PmBLBpGNWa7GhDP0fgl9SmzEBpmybpc6jaVU9nkxDM2vhc
        IZPtTrw+tF3wy+HKwQo9tFES9CPDEtPKVXMgEupfTHs8x6KX7SEEbmPZ+ZqHXHIapcVi01gxrba3J
        oL3adKN6Tqxi8jquaTLwcTh/QyARjmFnD+x7RqVVimvVPX3IC09pzmQo3D9BY4GQ9SoRGscguMRqy
        fxYvnttg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOknB-00AL9W-8F; Tue, 23 Mar 2021 17:26:34 +0000
Date:   Tue, 23 Mar 2021 17:26:09 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        yi.l.liu@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iommu/vt-d: Remove unused dma map/unmap trace events
Message-ID: <20210323172609.GB2463754@infradead.org>
References: <20210323010600.678627-1-baolu.lu@linux.intel.com>
 <20210323010600.678627-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323010600.678627-2-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 09:05:56AM +0800, Lu Baolu wrote:
> With commit c588072bba6b5 ("iommu/vt-d: Convert intel iommu driver to
> the iommu ops"), the trace events for dma map/unmap have no users any
> more. Cleanup them to make the code neat.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
