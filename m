Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161C43A109E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbhFIJyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 05:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238428AbhFIJya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 05:54:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D206761375;
        Wed,  9 Jun 2021 09:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623232356;
        bh=9O8DXLaMQM9wVBMqS6re6m7iWtxcq4OkN60k7/72jNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rz5e9QJyYBUIFX4wbQiLyfbCr2ONPnv5qZ/sXNbA9h6nEWncd+rc5hcnpU2TD4nyT
         ACJoUjv/x3+cwkrkkd1ZkWHbvlDn9YME8rOTKS55xu0fFWCD9Cmk0Gyogs19ecbGo9
         HvfxvTAvubbRjOMLWKiZ7G4PyIs8geVKrKQ4ELn8=
Date:   Wed, 9 Jun 2021 11:52:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "yekai(A)" <yekai13@huawei.com>
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangfei.gao@linaro.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH] uacce: add print information if not enable sva
Message-ID: <YMCPYmjHnn8S8soC@kroah.com>
References: <1622792769-28017-1-git-send-email-yekai13@huawei.com>
 <YLnbgcJmQZChx1WV@kroah.com>
 <3f1590c4-b9f1-18f5-370a-57d9707f38a0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f1590c4-b9f1-18f5-370a-57d9707f38a0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 09:39:52AM +0800, yekai(A) wrote:
> 
> 
> On 2021/6/4 15:51, Greg KH wrote:
> > On Fri, Jun 04, 2021 at 03:46:09PM +0800, Kai Ye wrote:
> > > Add print information necessary if user not enable sva.
> > > 
> > > Signed-off-by: Kai Ye <yekai13@huawei.com>
> > > ---
> > >  drivers/misc/uacce/uacce.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> > > index bae18ef0..fe38af8 100644
> > > --- a/drivers/misc/uacce/uacce.c
> > > +++ b/drivers/misc/uacce/uacce.c
> > > @@ -387,15 +387,22 @@ static void uacce_release(struct device *dev)
> > > 
> > >  static unsigned int uacce_enable_sva(struct device *parent, unsigned int flags)
> > >  {
> > > +	int ret;
> > > +
> > >  	if (!(flags & UACCE_DEV_SVA))
> > >  		return flags;
> > > 
> > >  	flags &= ~UACCE_DEV_SVA;
> > > 
> > > -	if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_IOPF))
> > > +	ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_IOPF);
> > > +	if (ret) {
> > > +		dev_err(parent, "failed to enable IOPF feature! ret = %d\n", ret);
> > 
> > Why is this needed?  Has this ever happened in real life such that the
> > log message is now required?
> > 
> > 
> > 
> > >  		return flags;
> > > +	}
> > > 
> > > -	if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA)) {
> > > +	ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA);
> > > +	if (ret) {
> > > +		dev_err(parent, "failed to enable SVA feature! ret = %d\n", ret);
> > 
> > Same here, does this happen in real systems?
> > 
> > thanks,
> > 
> > greg k-h
> > .
> > 
> In a other debug version, the SVA feature failed to be enabled, and no
> related information was printed. we don't know the cause of the problem.
> Finally, Although, it's not the problem here. but we find that the sva
> enable function doesn't have debug information. Therefore, it is
> inconvenient to locate the fault.
> so i think the log message is required.

Ok, can you resend with the changes that Joe suggested to make this even
easier to use?

thanks,

greg k-h
