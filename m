Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822FB3BE51C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhGGJJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:09:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58067 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbhGGJJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:09:28 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1m13W3-0003gL-Hy
        for linux-kernel@vger.kernel.org; Wed, 07 Jul 2021 09:06:47 +0000
Received: by mail-ed1-f72.google.com with SMTP id d17-20020a05640208d1b0290399de3a0eecso1113471edz.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 02:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0necEU8e5FhQWXyC3Rvz4/BXveBFcPGobL6M/DCru1A=;
        b=TbGoaOOx8A5P1RYfDYF/RA1aeV1XcBZISrB8i9IyIFXbXzN1s1iILiLHgYAeXC3Jiy
         5n9g8QeiRLR2wn7wurjxNxRt0aJcCjNK6PLiuXVYSC40kFkc/zSDfnT2IMZN+jxMoMtA
         PcR22d98/+aErAle/eKIbgyD8hPB7Tq5P4gBbianRvb9inUPGTjCInIETsoD7NhLuCiM
         RYd3HOSRyzvUTF2tH82waaEGgMrAN9AtTbLxSIlZTJ0wsOBnW+7wvg01KlNfo2rXXV8m
         pti2ar4bcNub7GZPv4/LIV1fsYVOVzprSZywraCSaKZ/seBZ3/xqjHwcYRxz6hC4/FJT
         UT+g==
X-Gm-Message-State: AOAM532U5FmUWl5ucxTZxEp3jiIpO26wvRSg7s1zmbf4/oKQ801Fx8Ed
        fSb609963l8QQAhncoPTbSoI34AuJk6ySrf7CSD0NvwKBhCB1MZ9gOYahwhXomvpl4IZyX3nWoU
        woT6xntj0T788O7/YNi/It+BoaWnSrApwvw8s7ArYehpxvn0Tl2epI+T+cg==
X-Received: by 2002:aa7:c9d8:: with SMTP id i24mr28839312edt.79.1625648807165;
        Wed, 07 Jul 2021 02:06:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8wi+Ed3XHH16Z0vLCEVgGT/EtJ6LgPi+mEC/E+N+VrH4ACMMcZRhglG4+UWYvA8Ujq43rSYhWiKIIZ1O08kA=
X-Received: by 2002:aa7:c9d8:: with SMTP id i24mr28839293edt.79.1625648806897;
 Wed, 07 Jul 2021 02:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210706065106.271765-1-kai.heng.feng@canonical.com>
 <d9fa9a62-6522-7d26-0cca-16f6886136ec@arm.com> <CAAd53p7ZXWkD8DiL0kMP8dZA5qFGRcdAMizv3THgo2XABPe25g@mail.gmail.com>
 <55a31c97-a3f4-97d7-0663-13c15b68d5c0@arm.com>
In-Reply-To: <55a31c97-a3f4-97d7-0663-13c15b68d5c0@arm.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 7 Jul 2021 17:06:35 +0800
Message-ID: <CAAd53p4e0_Doj3JGU6wU_C6QxQatb=p5N=sGoqAx+yQowJiERA@mail.gmail.com>
Subject: Re: [PATCH] iommu: Fallback to default setting when def_domain_type()
 callback returns 0
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, will@kernel.org,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 2:03 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-07-06 17:21, Kai-Heng Feng wrote:
> > On Tue, Jul 6, 2021 at 5:27 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> On 2021-07-06 07:51, Kai-Heng Feng wrote:
> >>> Commit 28b41e2c6aeb ("iommu: Move def_domain type check for untrusted
> >>> device into core") not only moved the check for untrusted device to
> >>> IOMMU core, it also introduced a behavioral change by returning
> >>> def_domain_type() directly without checking its return value. That makes
> >>> many devices no longer use the default IOMMU setting.
> >>>
> >>> So revert back to the old behavior which defaults to
> >>> iommu_def_domain_type when driver callback returns 0.
> >>>
> >>> Fixes: 28b41e2c6aeb ("iommu: Move def_domain type check for untrusted device into core")
> >>
> >> Are you sure about that? From that same commit:
> >>
> >> @@ -1507,7 +1509,7 @@ static int iommu_alloc_default_domain(struct
> >> iommu_group *group,
> >>           if (group->default_domain)
> >>                   return 0;
> >>
> >> -       type = iommu_get_def_domain_type(dev);
> >> +       type = iommu_get_def_domain_type(dev) ? : iommu_def_domain_type;
> >>
> >>           return iommu_group_alloc_default_domain(dev->bus, group, type);
> >>    }
> >>
> >> AFAICS the other two callers should also handle 0 correctly. Have you
> >> seen a problem in practice?
> >
> > Thanks for pointing out how the return value is being handled by the callers.
> > However, the same check is missing in probe_get_default_domain_type():
> > static int probe_get_default_domain_type(struct device *dev, void *data)
> > {
> >          struct __group_domain_type *gtype = data;
> >          unsigned int type = iommu_get_def_domain_type(dev);
> > ...
> > }
>
> I'm still not following - the next line right after that is "if (type)",
> which means it won't touch gtype, and if that happens for every
> iteration, probe_alloc_default_domain() subsequently hits its "if
> (!gtype.type)" condition and still ends up with iommu_def_domain_type.
> This *was* one of the other two callers I was talking about (the second
> being iommu_change_dev_def_domain()), and in fact on second look I think
> your proposed change will actually break this logic, since it's
> necessary to differentiate between a specific type being requested for
> the given device, and a "don't care" response which only implies to use
> the global default type if it's still standing after *all* the
> appropriate devices have been queried.

You are right, what I am seeing here is that the AMD GFX is using
IOMMU_DOMAIN_IDENTITY, and makes other devices in the same group,
including the Realtek WiFi, to use IOMMU_DOMAIN_IDENTITY as well.

>
> > I personally prefer the old way instead of open coding with ternary
> > operator, so I'll do that in v2.
> >
> > In practice, this causes a kernel panic when probing Realtek WiFi.
> > Because of the bug, dma_ops isn't set by probe_finalize(),
> > dma_map_single() falls back to swiotlb which isn't set and caused a
> > kernel panic.
>
> Hmm, but if that's the case, wouldn't it still be a problem anyway if
> the end result was IOMMU_DOMAIN_IDENTITY? I can't claim to fully
> understand the x86 swiotlb and no_iommu dance, but nothing really stands
> out to give me confidence that it handles the passthrough options correctly.

Yes, I think AMD IOMMU driver needs more thourough check on
static void __init amd_iommu_init_dma_ops(void)
{
        swiotlb = (iommu_default_passthrough() || sme_me_mask) ? 1 : 0;
...
}

Since swiotlb gets disabled by the check, but the Realtek WiFi is only
capable of doing 32bit DMA, the kernel panics because
io_tlb_default_mem is NULL.

Thanks again for pointing to the right direction, this patch is indeed
incorrect.

Kai-Heng

>
> Robin.
>
> > I didn't attach the panic log because the system simply is frozen at
> > that point so the message is not logged to the storage.
> > I'll see if I can find another way to collect the log and attach it in v2.
> >
> > Kai-Heng
> >
> >>
> >> Robin.
> >>
> >>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>> ---
> >>>    drivers/iommu/iommu.c | 5 +++--
> >>>    1 file changed, 3 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> >>> index 5419c4b9f27a..faac4f795025 100644
> >>> --- a/drivers/iommu/iommu.c
> >>> +++ b/drivers/iommu/iommu.c
> >>> @@ -1507,14 +1507,15 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_group);
> >>>    static int iommu_get_def_domain_type(struct device *dev)
> >>>    {
> >>>        const struct iommu_ops *ops = dev->bus->iommu_ops;
> >>> +     unsigned int type = 0;
> >>>
> >>>        if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
> >>>                return IOMMU_DOMAIN_DMA;
> >>>
> >>>        if (ops->def_domain_type)
> >>> -             return ops->def_domain_type(dev);
> >>> +             type = ops->def_domain_type(dev);
> >>>
> >>> -     return 0;
> >>> +     return (type == 0) ? iommu_def_domain_type : type;
> >>>    }
> >>>
> >>>    static int iommu_group_alloc_default_domain(struct bus_type *bus,
> >>>
