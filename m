Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7E7341E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 14:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhCSNnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 09:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhCSNms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 09:42:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDAFC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 06:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hyqxq7U5LtljeCAGVk4jeQy+LJbspwfVIdmGiMDlRVY=; b=K6sZZ2c8ZAynBR9zLv5S0z6QDr
        BDwKiB6zrKMHSRXAzjutLw3yP6QFdejiG0QhCjppZUklh/+w2M4Tq+1kMJTaSKJ2zdrllh2iUYBZe
        v9JJRsAcquRaCpiXnXuRWxjvG+jJ/Pm0F68N4WdfeUlbgfx7fFOBmwnmXHFQ7sz+1S+8NfRSfyTCR
        0PbSrfo6JOnc4NrYn+gRusRRcWGy/yiHKUifgFPG9uZDxdqA5VG2SnrtEoWzp9Q1pnr5X/nnzhhcn
        lkcPm3yw/vkzC9VYfSjy0Px0TuyEqiVXZZ9tONpCY48dOQnbmJdHySLAdCL+XmONI81aRyK1uMGJ1
        0adS+lDA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNFON-004Svd-TZ; Fri, 19 Mar 2021 13:42:23 +0000
Date:   Fri, 19 Mar 2021 13:42:19 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu: Streamline registration interface
Message-ID: <20210319134219.GB1063154@infradead.org>
References: <f4de29d8330981301c1935e667b507254a2691ae.1616157612.git.robin.murphy@arm.com>
 <95f69c593aa9dd57a5333e490dc06b8bae27fedf.1616157612.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95f69c593aa9dd57a5333e490dc06b8bae27fedf.1616157612.git.robin.murphy@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +int iommu_device_register(struct iommu_device *iommu, const struct iommu_ops *ops,

It would be nice to avoid the pointlessly overlong line here.

> +			    struct device *hwdev)
>  {
> +	iommu->ops = ops;
> +	if (hwdev)
> +		iommu->fwnode = hwdev->fwnode;

This function could use a kerneldoc comment now.  Especially the hwdev
agument isn't exactly obvious.

