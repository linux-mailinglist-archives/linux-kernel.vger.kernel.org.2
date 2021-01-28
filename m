Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D14030804C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 22:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhA1VLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 16:11:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:59034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231400AbhA1VLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:11:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E203464DDB;
        Thu, 28 Jan 2021 21:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611868226;
        bh=Wa3oCHdbhNI1rC5aNsjPzPLiyWlgSVs5J8jobh+d16o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UDy8g1B6xXUCMyvUCEeP3sXc/2mWaH+aOzhkdIt9x4BNWlNenfnPapZYWW8Am2sA0
         1P2Qr5F1Ssd+GPV0IbsWoNHLqxohnEy/M6feG0Sz6CS1rlYGIKNIUeE1xtVno9B/g4
         9RAF0vPuqOR028QU/LMmX1/Vjw9AQxLEkAw1QMPyVsJza2HePfbkP6rApwZZBXlZZU
         ZWH/oMCV/7zu/gOVT5AD0j2RGsyQ5AILr6L2tyo9xIMQXyLXXXU+e6pEYRYNiq7Rqy
         GlqCM3FSWikkY89/Yil+uuctnscrmmcMqJV/IfckIyfCmg5bgG3FIyDm7NpmplejKK
         j+hxxClSbtcNA==
Date:   Thu, 28 Jan 2021 21:10:20 +0000
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
Message-ID: <20210128211020.GA3531@willie-the-truck>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
 <20210111111914.22211-8-yong.wu@mediatek.com>
 <20210126222305.GB30460@willie-the-truck>
 <1611740356.5302.14.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611740356.5302.14.camel@mhfsdcap03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 05:39:16PM +0800, Yong Wu wrote:
> On Tue, 2021-01-26 at 22:23 +0000, Will Deacon wrote:
> > On Mon, Jan 11, 2021 at 07:18:48PM +0800, Yong Wu wrote:
> > > If group->default_domain exists, avoid reallocate it.
> > > 
> > > In some iommu drivers, there may be several devices share a group. Avoid
> > > realloc the default domain for this case.
> > > 
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >  drivers/iommu/iommu.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index 3d099a31ddca..f4b87e6abe80 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -266,7 +266,8 @@ int iommu_probe_device(struct device *dev)
> > >  	 * support default domains, so the return value is not yet
> > >  	 * checked.
> > >  	 */
> > > -	iommu_alloc_default_domain(group, dev);
> > > +	if (!group->default_domain)
> > > +		iommu_alloc_default_domain(group, dev);
> > 
> > I don't really get what this achieves, since iommu_alloc_default_domain()
> > looks like this:
> > 
> > static int iommu_alloc_default_domain(struct iommu_group *group,
> > 				      struct device *dev)
> > {
> > 	unsigned int type;
> > 
> > 	if (group->default_domain)
> > 		return 0;
> > 
> > 	...
> > 
> > in which case, it should be fine?
> 
> oh. sorry, I overlooked this. the current code is enough.
> I will remove this patch. and send the next version in this week.
> Thanks very much.

Actually, looking at this again, if we're dropping this patch and patch 6
just needs the kfree() moving about, then there's no need to repost. The
issue that Robin and Paul are discussing can be handled separately.

Will
