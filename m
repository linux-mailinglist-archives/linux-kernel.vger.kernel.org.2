Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38F0308054
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 22:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhA1VPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 16:15:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229595AbhA1VPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:15:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85E5F64DE8;
        Thu, 28 Jan 2021 21:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611868495;
        bh=XgWvSGSpVv18LahQizgkshnTyUbmYEWq3r/XkahHRII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LziO4BAXRIFn2iS8fwmhSyVoCaoZPy2kSoOBMhp5cYxstDcu5D/J9i7i79+DGGP5o
         48GGfpcm8R9i6X1zxfcGxMKA8ANVE7WymoLs4PDD9xxSjJzrh4Tl6jDYc+QC0UfKqd
         SecnHXT0DqaP6PwKB0nUcfE9nowxuUNBCNX4389tC4oSZJu3YOdXbEUQSK16fYPCqJ
         FyFomm+RDf3zpSa0Ik7u1XjSL0Tl0dWI5kdEww1S8bOgAn6WhrSgw8LpIIRLdIHmq9
         dSGyqCjORMZ4heDOlrzHyC30DWFM06QEs2JGhtUf3gm9jWn+cWeCSrk2tYTjd1Mqmu
         k2mSU9CnqXFpw==
Date:   Thu, 28 Jan 2021 21:14:42 +0000
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com
Subject: Re: [PATCH v6 07/33] iommu: Avoid reallocate default domain for a
 group
Message-ID: <20210128211442.GB3531@willie-the-truck>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
 <20210111111914.22211-8-yong.wu@mediatek.com>
 <20210126222305.GB30460@willie-the-truck>
 <1611740356.5302.14.camel@mhfsdcap03>
 <20210128211020.GA3531@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128211020.GA3531@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 09:10:20PM +0000, Will Deacon wrote:
> On Wed, Jan 27, 2021 at 05:39:16PM +0800, Yong Wu wrote:
> > On Tue, 2021-01-26 at 22:23 +0000, Will Deacon wrote:
> > > On Mon, Jan 11, 2021 at 07:18:48PM +0800, Yong Wu wrote:
> > > > If group->default_domain exists, avoid reallocate it.
> > > > 
> > > > In some iommu drivers, there may be several devices share a group. Avoid
> > > > realloc the default domain for this case.
> > > > 
> > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > ---
> > > >  drivers/iommu/iommu.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > > index 3d099a31ddca..f4b87e6abe80 100644
> > > > --- a/drivers/iommu/iommu.c
> > > > +++ b/drivers/iommu/iommu.c
> > > > @@ -266,7 +266,8 @@ int iommu_probe_device(struct device *dev)
> > > >  	 * support default domains, so the return value is not yet
> > > >  	 * checked.
> > > >  	 */
> > > > -	iommu_alloc_default_domain(group, dev);
> > > > +	if (!group->default_domain)
> > > > +		iommu_alloc_default_domain(group, dev);
> > > 
> > > I don't really get what this achieves, since iommu_alloc_default_domain()
> > > looks like this:
> > > 
> > > static int iommu_alloc_default_domain(struct iommu_group *group,
> > > 				      struct device *dev)
> > > {
> > > 	unsigned int type;
> > > 
> > > 	if (group->default_domain)
> > > 		return 0;
> > > 
> > > 	...
> > > 
> > > in which case, it should be fine?
> > 
> > oh. sorry, I overlooked this. the current code is enough.
> > I will remove this patch. and send the next version in this week.
> > Thanks very much.
> 
> Actually, looking at this again, if we're dropping this patch and patch 6
> just needs the kfree() moving about, then there's no need to repost. The
> issue that Robin and Paul are discussing can be handled separately.

Argh, except that this version of the patches doesn't apply :)

So after all that, please go ahead and post a v7 ASAP based on this branch:

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/mtk

Will
