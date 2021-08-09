Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D028F3E4DB0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 22:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbhHIUQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 16:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhHIUQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 16:16:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E7AC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 13:16:23 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j1so29784678pjv.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 13:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=44GhGqOetVs4KhXXElqDGKK3CH2oBjGziCm5x/a7ZJs=;
        b=ppVc9A9KMhJFgV6NVDkUHp9yBZ4jvRiPZUcI20A2cQjGlIn028xMoBHpww2tDAiKFl
         9iPhbobR9SHL2adYikPHqF5G4SlWpowSr2j8S6b8do8TbaUnU36v1GfI26941juwBtq0
         lg5uO8fP8v07UWSN2Md7iUeWq8bIHopmUzjvgBBzTK3O6/A+996ZEREB2/UhRgsIQp4H
         MeNfIz09c15Sltk3GsM1Mi4vP42DP3K751s00uC2X0eFx85qHl4u6HDdfFK1q/oVXcJv
         /ei/Pth5mKrn9l+/cEg8baudOVk+TGkbagMYGHp38fVDHIDAu3ZCTHC9yyVDLEU8ttwq
         mKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=44GhGqOetVs4KhXXElqDGKK3CH2oBjGziCm5x/a7ZJs=;
        b=TmP10Q2VOCwkKSBJUiUjyEzrqR03B7vbXuu/4HfNKmS10bLJYdSkes//4kuuuajC2g
         4KoUc69siqdN9yqQ0OCi17nd1RnwxsFUkPxLdJVIpY8r9X+cRm3APnq3K5qXRAril8bW
         M+Irr9qk9BBRFogjK15Umddqs/9OmWw49VWyw1fMGA/ieSz12VCY/+Rvj4/aiJbSRR4J
         pysZ6+0V9N/jVVlywXP6yZuTm3shVra8jqTC1vkquBOXvnFeWUK/VvzAhMbUPnn8W2ki
         3q51r409Nj0iXuf6KpJZBad2a9O69Eo3gSPOWpX96kgBHg3xrsTsQGZ6RPqwArlkcZp9
         QT0A==
X-Gm-Message-State: AOAM533BGwXEx+vkhJYCpYqRp+O9AOk3f60QxNU31q9p0NaBwE5HxVLr
        StB0qscrODiGhoDdIAlAj8FddNLzSX8S2hdly/xOS58BWZTCAQ==
X-Google-Smtp-Source: ABdhPJxHyBboh3cabRdq1cEgdkUUmLFgelCu6EWKllya4Av27+xhycvWAEKPW0Mj0+bvONvbUJBoXz9ti/IsYYB08zs=
X-Received: by 2002:a65:50cb:: with SMTP id s11mr424292pgp.236.1628540182405;
 Mon, 09 Aug 2021 13:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628094600.git.robin.murphy@arm.com> <3b5284ee394f267ba966839173f874fc9a996bb2.1628094601.git.robin.murphy@arm.com>
 <CACK8Z6HSM678q=BZ3FY7spN2S3ZkhdJ3ecnMCbKWrqB5dNWaMA@mail.gmail.com> <00baf83a-5eb3-4d72-309c-5adfd3242c07@arm.com>
In-Reply-To: <00baf83a-5eb3-4d72-309c-5adfd3242c07@arm.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 9 Aug 2021 13:15:46 -0700
Message-ID: <CACK8Z6Gb1O8Ok1GEy80nQJ4ZQeFJ3TOgFHRYfH3Yb=8CNT=ysw@mail.gmail.com>
Subject: Re: [PATCH v3 24/25] iommu/dma: Factor out flush queue init
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org,
        chenxiang66@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 12:59 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-08-09 20:05, Rajat Jain wrote:
> > On Wed, Aug 4, 2021 at 10:16 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> Factor out flush queue setup from the initial domain init so that we
> >> can potentially trigger it from sysfs later on in a domain's lifetime.
> >>
> >> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> >> Reviewed-by: John Garry <john.garry@huawei.com>
> >> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >> ---
> >>   drivers/iommu/dma-iommu.c | 30 ++++++++++++++++++++----------
> >>   include/linux/dma-iommu.h |  9 ++++++---
> >>   2 files changed, 26 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> >> index 2e19505dddf9..f51b8dc99ac6 100644
> >> --- a/drivers/iommu/dma-iommu.c
> >> +++ b/drivers/iommu/dma-iommu.c
> >> @@ -310,6 +310,25 @@ static bool dev_is_untrusted(struct device *dev)
> >>          return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
> >>   }
> >>
> >> +int iommu_dma_init_fq(struct iommu_domain *domain)
> >> +{
> >> +       struct iommu_dma_cookie *cookie = domain->iova_cookie;
> >> +
> >> +       if (domain->type != IOMMU_DOMAIN_DMA_FQ)
> >> +               return -EINVAL;
> >> +       if (cookie->fq_domain)
> >> +               return 0;
> >> +
> >> +       if (init_iova_flush_queue(&cookie->iovad, iommu_dma_flush_iotlb_all,
> >> +                                 iommu_dma_entry_dtor)) {
> >> +               pr_warn("iova flush queue initialization failed\n");
> >> +               domain->type = IOMMU_DOMAIN_DMA;
> >> +               return -ENODEV;
> >> +       }
> >> +       cookie->fq_domain = domain;
> >> +       return 0;
> >> +}
> >> +
> >>   /**
> >>    * iommu_dma_init_domain - Initialise a DMA mapping domain
> >>    * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
> >> @@ -362,16 +381,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
> >>          }
> >>
> >>          init_iova_domain(iovad, 1UL << order, base_pfn);
> >> -
> >> -       if (domain->type == IOMMU_DOMAIN_DMA_FQ && !cookie->fq_domain) {
> >> -               if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
> >> -                                         iommu_dma_entry_dtor)) {
> >> -                       pr_warn("iova flush queue initialization failed\n");
> >> -                       domain->type = IOMMU_DOMAIN_DMA;
> >> -               } else {
> >> -                       cookie->fq_domain = domain;
> >> -               }
> >> -       }
> >> +       iommu_dma_init_fq(domain);
> >>
> >>          return iova_reserve_iommu_regions(dev, domain);
> >>   }
> >> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> >> index 758ca4694257..81ab647f1618 100644
> >> --- a/include/linux/dma-iommu.h
> >> +++ b/include/linux/dma-iommu.h
> >> @@ -20,6 +20,7 @@ void iommu_put_dma_cookie(struct iommu_domain *domain);
> >>
> >>   /* Setup call for arch DMA mapping code */
> >>   void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit);
> >> +int iommu_dma_init_fq(struct iommu_domain *domain);
> >>
> >>   /* The DMA API isn't _quite_ the whole story, though... */
> >>   /*
> >> @@ -37,9 +38,6 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
> >>
> >>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
> >>
> >> -void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
> >> -               struct iommu_domain *domain);
> >> -
> >
> > This looks like an unrelated code cleanup. Should this be a separate patch?
>
> Ha, busted! Much of this was done in the "stream of consciousness" style
> where I made a big sprawling mess then split it up into patches and
> branches afterwards. TBH it was already feeling pretty tenuous having a
> separate patch just to move this one function, and it only gets more so
> with the simplification Will pointed out earlier. I think I'll squash
> iommu_dma_init_fq() into the next patch then do a thorough header sweep,
> since I've now spotted some things in iova.h which could probably go as
> well.

Thank you. I chanced upon this only because I've backported your
patchset (and some other changes that it depends on) to 5.10 which is
the kernel we currently use for our Intel platforms, and this cleanup
hunk was creating a problem (since 5.10 still uses the symbol you
removed). I'll be giving your v3 patchset a spin in my setup and
update you in case I see any issue.

Thanks,

Rajat


>
> Thanks for the poke!
>
> Robin.
>
> >
> > Thanks,
> >
> > Rajat
> >
> >
> >>   extern bool iommu_dma_forcedac;
> >>
> >>   #else /* CONFIG_IOMMU_DMA */
> >> @@ -54,6 +52,11 @@ static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
> >>   {
> >>   }
> >>
> >> +static inline int iommu_dma_init_fq(struct iommu_domain *domain)
> >> +{
> >> +       return -EINVAL;
> >> +}
> >> +
> >>   static inline int iommu_get_dma_cookie(struct iommu_domain *domain)
> >>   {
> >>          return -ENODEV;
> >> --
> >> 2.25.1
> >>
