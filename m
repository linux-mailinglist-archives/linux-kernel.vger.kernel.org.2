Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB1F36028B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 08:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhDOGlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 02:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhDOGlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 02:41:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C02DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 23:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kdup9hnwbEiPmwTx9I9NnARK4LM7lXWcWIkr+6fiOPY=; b=QMvRnHEY6v+1+1x3P9v5O1tppt
        PhAkJUgWiFuni09IbxDa4Vfn6J/XKfcCCD1/a+AMGKH+4hu22+yK89okqW8E/5LCCEvtdOZ5yVdsZ
        i3+4WIvI4x3tg0GEQR+6zXdNXAdmPjMElpRDH5aaGTA/NwhPVGMo+1ZUl5Cu8PLb8LJ1VoPdQQ9zZ
        iLMktBmorhbqIwl211yXC1BJj0xuY5JmU4lpWh/mkQvpeqmSotkM8Jf6TbjMCTbKPYbyM2aJepYJJ
        4ur57vX4Vy2k9wLGyjWWKxZbUAqULWbDQDH17DRHU0ifO4PNIC7ZLef1veT07UX4EEymYQT1g8imd
        sUW8idYA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lWvg1-0089BK-MR; Thu, 15 Apr 2021 06:40:34 +0000
Date:   Thu, 15 Apr 2021 07:40:33 +0100
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
Subject: Re: [PATCH v2 1/2] iommu/sva: Tighten SVA bind API with explicit
 flags
Message-ID: <20210415064033.GA1938497@infradead.org>
References: <1618414077-28808-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1618414077-28808-2-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618414077-28808-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 08:27:56AM -0700, Jacob Pan wrote:
>  static int idxd_enable_system_pasid(struct idxd_device *idxd)
>  {
> -	int flags;
> +	unsigned int flags;
>  	unsigned int pasid;
>  	struct iommu_sva *sva;
>  
> -	flags = SVM_FLAG_SUPERVISOR_MODE;
> +	flags = IOMMU_SVA_BIND_SUPERVISOR;
>  
> -	sva = iommu_sva_bind_device(&idxd->pdev->dev, NULL, &flags);
> +	sva = iommu_sva_bind_device(&idxd->pdev->dev, NULL, flags);

Please also remove the now pointless flags variable.

> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int flags)

Pleae avoid the pointless overly long line.

> -#define SVM_FLAG_GUEST_PASID		(1<<3)
> +#define SVM_FLAG_GUEST_PASID		(1<<2)

This flag is entirely unused, please just remove it in a prep patch
rather than renumbering it.

>  static inline struct iommu_sva *
> -iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, unsigned int flags)

Same overy long line here.
