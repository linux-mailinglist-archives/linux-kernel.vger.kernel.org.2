Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E7A42C633
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhJMQWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:22:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230222AbhJMQWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:22:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 228A860E96;
        Wed, 13 Oct 2021 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634142030;
        bh=q1ptrLrC6qidLtEaA8q3rDKJGyevclNAp0SRbFWUJrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vi4MyLFV+WA6r1aarNq1pL+TdDzqHkLeCPRw3GzArSh0ZbHYhKxqSN2Z8xphPwxnO
         ThMXThfL0DNa8cTNdCu22rhhFVkPXy60kvmEkp8NLo5+DRg69vBmIDFqy/wXcdhlx1
         Eu44sahlBMVWEm7yzE16riTI3vxHc9t3hiyhUk5CCXrv4ktDlAnQZJ26U5Nlh6PUC/
         2tm4Kluc2HCxgFozhL9fF2icYOLnpyQ8nQDu8b5F6RCjndUXUBSNFYMjzmLHrrmtbm
         ImM8urfLMUrKqsiqUfTBgALN4UZme/QYwcMunWLmI1CVWDvU/oi9ggN+NQDb62RORn
         HOIveP4jTxM0Q==
Date:   Wed, 13 Oct 2021 17:20:24 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Alex Elder <elder@linaro.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/arm: fix ARM_SMMU_QCOM compilation
Message-ID: <20211013162024.GA7134@willie-the-truck>
References: <20211012151841.2639732-1-arnd@kernel.org>
 <20211013075803.GB6701@willie-the-truck>
 <CAK8P3a1GaQ1kjkjOP09eTUu6MR+RjhSDU9s-49MPQ1FSOMUDEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1GaQ1kjkjOP09eTUu6MR+RjhSDU9s-49MPQ1FSOMUDEg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, Oct 13, 2021 at 10:33:55AM +0200, Arnd Bergmann wrote:
> On Wed, Oct 13, 2021 at 9:58 AM Will Deacon <will@kernel.org> wrote:
> > On Tue, Oct 12, 2021 at 05:18:00PM +0200, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > My previous bugfix ended up making things worse for the QCOM IOMMU
> > > driver when it forgot to add the Kconfig symbol that is getting used to
> > > control the compilation of the SMMU implementation specific code
> > > for Qualcomm.
> > >
> > > Fixes: 424953cf3c66 ("qcom_scm: hide Kconfig symbol")
> > > Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > Reported-by: John Stultz <john.stultz@linaro.org>
> > > Link: https://lore.kernel.org/lkml/20211010023350.978638-1-dmitry.baryshkov@linaro.org/
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > > In case we want fix it this way after all, here is the patch
> > > I made. Either this one or Dmitry patch from the link above
> > > is required for v5.15
> > > ---
> > >  drivers/iommu/Kconfig | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > > index c5c71b7ab7e8..3eb68fa1b8cc 100644
> > > --- a/drivers/iommu/Kconfig
> > > +++ b/drivers/iommu/Kconfig
> > > @@ -355,6 +355,14 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
> > >         'arm-smmu.disable_bypass' will continue to override this
> > >         config.
> > >
> > > +config ARM_SMMU_QCOM
> > > +     def_tristate y
> > > +     depends on ARM_SMMU && ARCH_QCOM
> > > +     select QCOM_SCM
> > > +     help
> > > +       When running on a Qualcomm platform that has the custom variant
> > > +       of the ARM SMMU, this needs to be built into the SMMU driver.
> > > +
> >
> > FWIW, I prefer this solution over changing the driver code, so:
> >
> > Acked-by: Will Deacon <will@kernel.org>
> >
> > I assume you'll be getting this fixed for 5.15?
> 
> I was hoping you and Joerg could just pick your preferred patch
> into the iommu fixes tree for v5.15.
> 
> I currently have nothing else pending for my asm-generic tree that
> introduced the regression, but I can take it through there if that helps
> you.

I also don't have any fixes pending, and I don't see any in Joerg's tree so
it's probably quickest if you send it on yourself. Is that ok?

Cheers,

Will
