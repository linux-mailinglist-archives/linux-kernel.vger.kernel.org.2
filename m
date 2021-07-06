Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6753BDB44
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 18:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhGFQYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 12:24:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37663 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhGFQYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 12:24:30 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1m0npW-0003Kd-RU
        for linux-kernel@vger.kernel.org; Tue, 06 Jul 2021 16:21:50 +0000
Received: by mail-ej1-f71.google.com with SMTP id p20-20020a1709064994b02903cd421d7803so6036157eju.22
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 09:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kGlDPyrXklpe94l/MLiVRpqx1f3MJLKeH5USkerAr9A=;
        b=CgSzWsyw3VcecprqHKaOdYy5iz87mJAjkPREFeva24aO9Nnq3gDg2UCu8ZkZOnNGHG
         iEv9hvVZa3+ESxnTTAJxYW41cfvNYqywrnQ6P4gGNOHHxvFnvGr+VRMmDK4cZ6g92ZlK
         gW7NJaTP9HoBZhwxljvRU/9Q/WQ3cfoi4psVbiOKHArDf/Pq9mp3v6G5yNynFKFou9lK
         q70lU4X/jocLFPBaLA15b6hWdwDVgCUy11asy52CPUF+ix6Yq6XMcQpfD3VV7thvAJN9
         OzT6/y9Yz36cvlpncC6lhRvkd1OJxX9RUgW7NUFeBFv7SpPrwt+9XFLZ+GFKYwuzvadz
         8cmQ==
X-Gm-Message-State: AOAM533HdVLDsz6SRTjNp7WIOAFaqebV7Ll9lPb4wviO6Y0B54CHR5QR
        yGes9JWrhGCwhvHR6HeLvvCcxnv+79plWn4SDeVSz065FVFQyAAmcsZZ/DFnhKO+vhe3bDMEr9+
        6FN7HIR+ZzGpcNR4R0EWWNUqEzOGSM8emOkijl4dvFZomYPy7A6pQIoJ50Q==
X-Received: by 2002:a17:907:3f0c:: with SMTP id hq12mr14665671ejc.117.1625588510496;
        Tue, 06 Jul 2021 09:21:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGD3eqFpCnyFnDreBKI5Rw1aIANwcSZIzvSAN4eyQ84oiwI3eYBSEyhw/pWhN6pAr3clWkW2sWfpSN/oIjcDA=
X-Received: by 2002:a17:907:3f0c:: with SMTP id hq12mr14665646ejc.117.1625588510203;
 Tue, 06 Jul 2021 09:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210706065106.271765-1-kai.heng.feng@canonical.com> <d9fa9a62-6522-7d26-0cca-16f6886136ec@arm.com>
In-Reply-To: <d9fa9a62-6522-7d26-0cca-16f6886136ec@arm.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 7 Jul 2021 00:21:38 +0800
Message-ID: <CAAd53p7ZXWkD8DiL0kMP8dZA5qFGRcdAMizv3THgo2XABPe25g@mail.gmail.com>
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

On Tue, Jul 6, 2021 at 5:27 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-07-06 07:51, Kai-Heng Feng wrote:
> > Commit 28b41e2c6aeb ("iommu: Move def_domain type check for untrusted
> > device into core") not only moved the check for untrusted device to
> > IOMMU core, it also introduced a behavioral change by returning
> > def_domain_type() directly without checking its return value. That makes
> > many devices no longer use the default IOMMU setting.
> >
> > So revert back to the old behavior which defaults to
> > iommu_def_domain_type when driver callback returns 0.
> >
> > Fixes: 28b41e2c6aeb ("iommu: Move def_domain type check for untrusted device into core")
>
> Are you sure about that? From that same commit:
>
> @@ -1507,7 +1509,7 @@ static int iommu_alloc_default_domain(struct
> iommu_group *group,
>          if (group->default_domain)
>                  return 0;
>
> -       type = iommu_get_def_domain_type(dev);
> +       type = iommu_get_def_domain_type(dev) ? : iommu_def_domain_type;
>
>          return iommu_group_alloc_default_domain(dev->bus, group, type);
>   }
>
> AFAICS the other two callers should also handle 0 correctly. Have you
> seen a problem in practice?

Thanks for pointing out how the return value is being handled by the callers.
However, the same check is missing in probe_get_default_domain_type():
static int probe_get_default_domain_type(struct device *dev, void *data)
{
        struct __group_domain_type *gtype = data;
        unsigned int type = iommu_get_def_domain_type(dev);
...
}

I personally prefer the old way instead of open coding with ternary
operator, so I'll do that in v2.

In practice, this causes a kernel panic when probing Realtek WiFi.
Because of the bug, dma_ops isn't set by probe_finalize(),
dma_map_single() falls back to swiotlb which isn't set and caused a
kernel panic.
I didn't attach the panic log because the system simply is frozen at
that point so the message is not logged to the storage.
I'll see if I can find another way to collect the log and attach it in v2.

Kai-Heng

>
> Robin.
>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >   drivers/iommu/iommu.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 5419c4b9f27a..faac4f795025 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1507,14 +1507,15 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_group);
> >   static int iommu_get_def_domain_type(struct device *dev)
> >   {
> >       const struct iommu_ops *ops = dev->bus->iommu_ops;
> > +     unsigned int type = 0;
> >
> >       if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
> >               return IOMMU_DOMAIN_DMA;
> >
> >       if (ops->def_domain_type)
> > -             return ops->def_domain_type(dev);
> > +             type = ops->def_domain_type(dev);
> >
> > -     return 0;
> > +     return (type == 0) ? iommu_def_domain_type : type;
> >   }
> >
> >   static int iommu_group_alloc_default_domain(struct bus_type *bus,
> >
