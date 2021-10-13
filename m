Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695F342BA8B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 10:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbhJMIg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 04:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238879AbhJMIgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 04:36:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3015461040
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 08:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634114054;
        bh=im3WaSeib0gC+BjVK6fK56Be/lOGMJAnXEQ2iB8iVdE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TcUGpIjnlHOUzg3n1yWPCQ6KtkLgfaK3Oakk1OXUyCPCdC1Rh3p1H9J3RbvY4IAdd
         xQw6C4LOxaSbMIe7OdhFau6OZIxdAW4Lj0FEEGe2C8nZCp7guRuLT+F+9ZZEsfYAzh
         C2mVRPJP9wsKCkPjhn9K1ArEYbT7VXSsy62eCS6IYTonEr4DF9lUSiEtYfVFxkPjfy
         DNp/fuIMywwW54i1AvEdJQ7+CtiiJjD7TVKdOiCEyYOSAV888zMGPp0t934nE0C25R
         iGrZCfBL1nYNM6iOTGCwYHPEYskIt2vb8xSowLYHsu2K11usQrL1NYu5MfcbVEi0Pk
         xiUNKSJ2TeWDw==
Received: by mail-wr1-f43.google.com with SMTP id e12so5618995wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 01:34:14 -0700 (PDT)
X-Gm-Message-State: AOAM530YEPkekJPvS+uSAvUkSIm7hKaGH8s0xIkkrwbx+ejF/7NE1VDz
        hre9HU8qW4L+M4F9YwDcxlW1mvVKhM0RchVQlAY=
X-Google-Smtp-Source: ABdhPJzVNkCgV6mIZ2XLUuFLhH41TCPlTJKGbX2haLXegUVQFo0cnrLHPg78K9gOMcaWbT209IvfuMEdRMlTosZ1lcM=
X-Received: by 2002:adf:f481:: with SMTP id l1mr37302953wro.411.1634114052610;
 Wed, 13 Oct 2021 01:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211012151841.2639732-1-arnd@kernel.org> <20211013075803.GB6701@willie-the-truck>
In-Reply-To: <20211013075803.GB6701@willie-the-truck>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 13 Oct 2021 10:33:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1GaQ1kjkjOP09eTUu6MR+RjhSDU9s-49MPQ1FSOMUDEg@mail.gmail.com>
Message-ID: <CAK8P3a1GaQ1kjkjOP09eTUu6MR+RjhSDU9s-49MPQ1FSOMUDEg@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm: fix ARM_SMMU_QCOM compilation
To:     Will Deacon <will@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 9:58 AM Will Deacon <will@kernel.org> wrote:
> On Tue, Oct 12, 2021 at 05:18:00PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > My previous bugfix ended up making things worse for the QCOM IOMMU
> > driver when it forgot to add the Kconfig symbol that is getting used to
> > control the compilation of the SMMU implementation specific code
> > for Qualcomm.
> >
> > Fixes: 424953cf3c66 ("qcom_scm: hide Kconfig symbol")
> > Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Reported-by: John Stultz <john.stultz@linaro.org>
> > Link: https://lore.kernel.org/lkml/20211010023350.978638-1-dmitry.baryshkov@linaro.org/
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > In case we want fix it this way after all, here is the patch
> > I made. Either this one or Dmitry patch from the link above
> > is required for v5.15
> > ---
> >  drivers/iommu/Kconfig | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index c5c71b7ab7e8..3eb68fa1b8cc 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -355,6 +355,14 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
> >         'arm-smmu.disable_bypass' will continue to override this
> >         config.
> >
> > +config ARM_SMMU_QCOM
> > +     def_tristate y
> > +     depends on ARM_SMMU && ARCH_QCOM
> > +     select QCOM_SCM
> > +     help
> > +       When running on a Qualcomm platform that has the custom variant
> > +       of the ARM SMMU, this needs to be built into the SMMU driver.
> > +
>
> FWIW, I prefer this solution over changing the driver code, so:
>
> Acked-by: Will Deacon <will@kernel.org>
>
> I assume you'll be getting this fixed for 5.15?

I was hoping you and Joerg could just pick your preferred patch
into the iommu fixes tree for v5.15.

I currently have nothing else pending for my asm-generic tree that
introduced the regression, but I can take it through there if that helps
you.

         Arnd
