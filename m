Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EEF30F3EE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 14:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbhBDNcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 08:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbhBDNcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:32:41 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970A5C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 05:31:59 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8F0DE387; Thu,  4 Feb 2021 14:31:55 +0100 (CET)
Date:   Thu, 4 Feb 2021 14:31:48 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     Colin King <colin.king@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Anan sun <anan.sun@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        Tomasz Figa <tfiga@chromium.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iommu/mediatek: Fix unsigned domid comparison with
 less than zero
Message-ID: <20210204133148.GA27686@8bytes.org>
References: <20210203135936.23016-1-colin.king@canonical.com>
 <20210204092558.GA20244@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204092558.GA20244@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 09:25:58AM +0000, Will Deacon wrote:
> On Wed, Feb 03, 2021 at 01:59:36PM +0000, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Currently the check for domid < 0 is always false because domid
> > is unsigned.  Fix this by making it signed.
> > 
> > Addresses-CoverityL ("Unsigned comparison against 0")
> 
> Typo here ('L' instead of ':')
> 
> > Fixes: ab1d5281a62b ("iommu/mediatek: Add iova reserved function")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 0ad14a7604b1..823d719945b2 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -640,7 +640,7 @@ static void mtk_iommu_get_resv_regions(struct device *dev,
> >  				       struct list_head *head)
> >  {
> >  	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
> > -	unsigned int domid = mtk_iommu_get_domain_id(dev, data->plat_data), i;
> > +	int domid = mtk_iommu_get_domain_id(dev, data->plat_data), i;
> 
> Not sure if it's intentional, but this also makes 'i' signed. It probably
> should remain 'unsigned' to match 'iova_region_nr' in
> 'struct mtk_iommu_plat_data'.

Yes, 'i' should stay unsigned. Colin, can you please fix that up and
re-send?

Thanks,

	Joerg
