Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416253DAEE9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 00:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhG2Wdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 18:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhG2Wdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 18:33:41 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D130CC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 15:33:36 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id f22so7574971qke.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 15:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wSwaXGR0ffkfvWSYpOo1mSV78T7UHpROeIuBTm4Z1MA=;
        b=JNsWCZEiSnwSWX4wOvM5A/54GOSNToWAvaSyXaVfkfUMj2iAO83NDeysjcv6v2HSus
         a7FXhiwDzdQMcThODZIAMpFvWYE0wKp+72IRfKZUjq6dJMu3CSvGv9gRIe0mEYk7f4iR
         6lRau+ZIUy3OOBkEyqFaxTXUHZacdvac+hgno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wSwaXGR0ffkfvWSYpOo1mSV78T7UHpROeIuBTm4Z1MA=;
        b=HQstZuUWFZwp+iEge13TVWUJIAgY/mzvJvtvsMSUS6JzSOSL+oFsoZ5a7+n/g4XvDI
         2bi1KNfJO9zjH/YQ64DeeFm2tx4D41WJKhFfb6qrPQamYy5WViIIUFQJnzZQZZeRfUmC
         S6fEB05Kvx0aclWW3iJ5RV0AQ5FFbHK1fl5+tCHdKmleH/IJ8nCv/JdGwnn4WDdGTkmS
         8wgBUlJlfQZXvTvZoB1vQBcyQTFE5BggAMeT1eEPmB4Dfr49H/N2yo/nQp8A9erHcSLu
         2XChDqE1HWevnkH+FE/CkV0+JFwDp+dEVF/erw6z9CIJBs1xXJmNmrrd6VzKDK19Mvzt
         V/Ow==
X-Gm-Message-State: AOAM531+CSHNpVZonqb985CS0W+eMy3zo5Bs4mUNOLCNpFqFRTpH5MkJ
        yKlvsm8EaGp0g4yt8g+5BpZUtqchb7ycEg==
X-Google-Smtp-Source: ABdhPJxg+W+62Gfwg+b0Z4F04rRk3GVaTrc+fKgFoA0doABdyzhIFWjsHjbngQiUpTindTf4qMKqDw==
X-Received: by 2002:a05:620a:8c9:: with SMTP id z9mr3745076qkz.440.1627598015700;
        Thu, 29 Jul 2021 15:33:35 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id t25sm28841qkt.11.2021.07.29.15.33.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 15:33:34 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id f26so12697767ybj.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 15:33:34 -0700 (PDT)
X-Received: by 2002:a25:6088:: with SMTP id u130mr9908544ybb.257.1627598013905;
 Thu, 29 Jul 2021 15:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627468308.git.robin.murphy@arm.com>
In-Reply-To: <cover.1627468308.git.robin.murphy@arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Jul 2021 15:33:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U5a=aj5NPOGywVoEGQLuza9T6RhBhw9NT2AT2qxaKzYw@mail.gmail.com>
Message-ID: <CAD=FV=U5a=aj5NPOGywVoEGQLuza9T6RhBhw9NT2AT2qxaKzYw@mail.gmail.com>
Subject: Re: [PATCH v2 00/24] iommu: Refactor DMA domain strictness
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        suravee.suthikulpanit@amd.com, Lu Baolu <baolu.lu@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yong Wu <yong.wu@mediatek.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 28, 2021 at 8:59 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi all,
>
> Here's v2 where things start to look more realistic, hence the expanded
> CC list. The patches are now based on the current iommu/core branch to
> take John's iommu_set_dma_strict() cleanup into account.
>
> The series remiains in two (or possibly 3) logical parts - for people
> CC'd on cookie cleanup patches, the later parts should not affect you
> since your drivers don't implement non-strict mode anyway; the cleanup
> is all pretty straightforward, but please do yell at me if I've managed
> to let a silly mistake slip through and broken your driver.
>
> This time I have also build-tested x86 as well as arm64 :)
>
> Changes in v2:
>
> - Add iommu_is_dma_domain() helper to abstract flag check (and help
>   avoid silly typos like the one in v1).
> - Tweak a few commit messages for spelling and (hopefully) clarity.
> - Move the iommu_create_device_direct_mappings() update to patch #14
>   where it should have been.
> - Rewrite patch #20 as a conversion of the now-existing option.
> - Clean up the ops->flush_iotlb_all check which is also made redundant
>   by the new domain type
> - Add patch #24, which is arguably tangential, but it was something I
>   spotted during the rebase, so...
>
> Once again, the whole lot is available on a branch here:
>
> https://gitlab.arm.com/linux-arm/linux-rm/-/tree/iommu/fq
>
> Thanks,
> Robin.
>
>
> CC: Marek Szyprowski <m.szyprowski@samsung.com>
> CC: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> CC: Geert Uytterhoeven <geert+renesas@glider.be>
> CC: Yong Wu <yong.wu@mediatek.com>
> CC: Heiko Stuebner <heiko@sntech.de>
> CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
> CC: Chunyan Zhang <chunyan.zhang@unisoc.com>
> CC: Maxime Ripard <mripard@kernel.org>
> CC: Jean-Philippe Brucker <jean-philippe@linaro.org>
>
> Robin Murphy (24):
>   iommu: Pull IOVA cookie management into the core
>   iommu/amd: Drop IOVA cookie management
>   iommu/arm-smmu: Drop IOVA cookie management
>   iommu/vt-d: Drop IOVA cookie management
>   iommu/exynos: Drop IOVA cookie management
>   iommu/ipmmu-vmsa: Drop IOVA cookie management
>   iommu/mtk: Drop IOVA cookie management
>   iommu/rockchip: Drop IOVA cookie management
>   iommu/sprd: Drop IOVA cookie management
>   iommu/sun50i: Drop IOVA cookie management
>   iommu/virtio: Drop IOVA cookie management
>   iommu/dma: Unexport IOVA cookie management
>   iommu/dma: Remove redundant "!dev" checks
>   iommu: Introduce explicit type for non-strict DMA domains
>   iommu/amd: Prepare for multiple DMA domain types
>   iommu/arm-smmu: Prepare for multiple DMA domain types
>   iommu/vt-d: Prepare for multiple DMA domain types
>   iommu: Express DMA strictness via the domain type
>   iommu: Expose DMA domain strictness via sysfs
>   iommu: Merge strictness and domain type configs
>   iommu/dma: Factor out flush queue init
>   iommu: Allow enabling non-strict mode dynamically
>   iommu/arm-smmu: Allow non-strict in pgtable_quirks interface
>   iommu: Only log strictness for DMA domains
>
>  .../ABI/testing/sysfs-kernel-iommu_groups     |  2 +
>  drivers/iommu/Kconfig                         | 80 +++++++++----------
>  drivers/iommu/amd/iommu.c                     | 21 +----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 25 ++++--
>  drivers/iommu/arm/arm-smmu/arm-smmu.c         | 29 ++++---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c       |  8 --
>  drivers/iommu/dma-iommu.c                     | 44 +++++-----
>  drivers/iommu/exynos-iommu.c                  | 18 +----
>  drivers/iommu/intel/iommu.c                   | 23 ++----
>  drivers/iommu/iommu.c                         | 53 +++++++-----
>  drivers/iommu/ipmmu-vmsa.c                    | 27 +------
>  drivers/iommu/mtk_iommu.c                     |  6 --
>  drivers/iommu/rockchip-iommu.c                | 11 +--
>  drivers/iommu/sprd-iommu.c                    |  6 --
>  drivers/iommu/sun50i-iommu.c                  | 12 +--
>  drivers/iommu/virtio-iommu.c                  |  8 --
>  include/linux/dma-iommu.h                     |  9 ++-
>  include/linux/iommu.h                         | 15 +++-
>  18 files changed, 171 insertions(+), 226 deletions(-)

I ran with:

a) mainline Linux (at commit 4010a528219e)
b) pulled iommu/next (at commit 9be9f5580ab6)
c) picked from patchwork your series

...and I ran on sc7180-trogdor-lazor.

Things worked OK and I could transition my eMMC to non-strict mode with:

echo DMA-FQ > /sys/devices/platform/soc@0/7c4000.sdhci/iommu_group/type

I was definitely getting some inconsistencies in my tests where the
eMMC speeds were getting into a bad state, but I don't believe it's
related to your patch series. I could transition myself back to strict
DMA with this (only got one unrelated warn splat about
dev_pm_opp_put_clkname when unbinding) because I was booted up from
USB for testing:

cd /sys/bus/mmc/drivers/mmcblk
echo mmc1:0001 > unbind
cd /sys/bus/platform/drivers/sdhci_msm/
echo 7c4000.sdhci > unbind
echo DMA > /sys/devices/platform/soc@0/7c4000.sdhci/iommu_group/type
echo 7c4000.sdhci > bind

...and it was consistently faster with non-strict than with strict so
whatever bad state I sometimes managed to get in it affected both
modes. ;-)

So I guess that's a long-winded way to say this:

Tested-by: Douglas Anderson <dianders@chromium.org>
