Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4405E360295
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 08:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhDOGp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 02:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhDOGp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 02:45:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E10AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 23:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sLaSZVd4EBbrRjPoUQruAkWH+BL8bWgNXBPCwZ3fiOg=; b=uyED9tbYrz+aBtUW6B18Iw8opP
        D0Wt982bXVbzBHSIbZU/Wg0JbrJiPc+os266qo2mrhEm8u5K+gh3ot8uHm9MG1Nm0nV/6ALtH0yz0
        TI5Q5XLe7/NM0YACY1eRihJ8dXEAlyfE554IyG0NDtJOvPwxx//zZilRu2xCTG8xOPR9NgnOedHuF
        n1O0FycpE7bVWtR/B9/e5tt9dDvBv8lxdy7aNsWPtYX0/XBg33IVRXlw1tLIJ0/pz/VYVVYijLB3k
        VVwxP42xMt2coTBqPalf/P6Al+VLBBjuIDCdmmspoSeSiz+kbbtDE0zEVeEzw5h1U7kqxY5G3jWTq
        b+ffu2Ig==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lWvkJ-0089Pg-T4; Thu, 15 Apr 2021 06:45:01 +0000
Date:   Thu, 15 Apr 2021 07:44:59 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, vkoul@kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>, zhangfei.gao@linaro.org
Subject: Re: [PATCH v2 2/2] iommu/sva: Remove mm parameter from SVA bind API
Message-ID: <20210415064459.GB1938497@infradead.org>
References: <1618414077-28808-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1618414077-28808-3-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618414077-28808-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>   *
>   * Returns 0 on success and < 0 on error.
> @@ -28,6 +28,9 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
>  	int ret = 0;
>  	ioasid_t pasid;
>  
> +	if (mm != current->mm)
> +		return -EINVAL;
> +

Why not remove the parameter entirely?

> @@ -2989,8 +2990,11 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int fla
>  		return ERR_PTR(-ENODEV);
>  
>  	/* Supervisor SVA does not need the current mm */
> -	if ((flags & IOMMU_SVA_BIND_SUPERVISOR) && mm)
> -		return ERR_PTR(-EINVAL);
> +	if (!(flags & IOMMU_SVA_BIND_SUPERVISOR)) {
> +		mm = get_task_mm(current);
> +		if (!mm)
> +			return ERR_PTR(-EINVAL);
> +	}

I don't see why we need the reference.  I think we should just stop
passing the mm to ->sva_bind and let the low-level driver deal with
any reference to current->mm where needed.
