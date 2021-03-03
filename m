Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D03A32BD7D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384658AbhCCQIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:08:43 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:35417 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357955AbhCCLh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 06:37:29 -0500
Received: from mail-oo1-f53.google.com ([209.85.161.53]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MhDIw-1llmG30Z06-00eLjx; Wed, 03 Mar 2021 09:44:25 +0100
Received: by mail-oo1-f53.google.com with SMTP id n19so5480150ooj.11;
        Wed, 03 Mar 2021 00:44:24 -0800 (PST)
X-Gm-Message-State: AOAM531I5RlSxC1fMxpxwzkcsPAJpnaJFMGKoUsV2NBkaCYTCh1InN3k
        qgP85DrGx8q+yk/Tr4YR5dK1btjxZ7onBt2pcZY=
X-Google-Smtp-Source: ABdhPJx+y1mutrjVZMV70H7WGHtEMsbqS/b6Pacx4upesFv3Pu2rH/lMvNVNl6MT1UBcioMptZHIJHVRvTvRXobxOCo=
X-Received: by 2002:a4a:304a:: with SMTP id z10mr20492940ooz.26.1614761063729;
 Wed, 03 Mar 2021 00:44:23 -0800 (PST)
MIME-Version: 1.0
References: <20210226140305.26356-1-nsaenzjulienne@suse.de>
 <20210226140305.26356-10-nsaenzjulienne@suse.de> <3a4cf13f-c098-9ff3-6c0e-2c94daae452b@arm.com>
In-Reply-To: <3a4cf13f-c098-9ff3-6c0e-2c94daae452b@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 3 Mar 2021 09:44:07 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1px7aC92p+rZOYRV2npbHeMPP94fQz==UopHUrApE5Jw@mail.gmail.com>
Message-ID: <CAK8P3a1px7aC92p+rZOYRV2npbHeMPP94fQz==UopHUrApE5Jw@mail.gmail.com>
Subject: Re: [RFC 09/13] iommu/arm-smmu: Make use of dev_64bit_mmio_supported()
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:7g5UKd+vyI/Ln8q53XNHCBMONOXbq19hSutGtG8ohJvxzZ6ytkq
 kDKPGw9czCqxBsRjWnuuxYuw9k2WHUYh7nCLZ9ZBl0Ewfxl7F8JE+wKMEALu8nxlviKb5TS
 KBn1bzpxt9sMFEgJXzAhY0L7UaooMx4V2fmEWKLyYjfIvgS3p4wfZ5TiYTmektItVml2YY+
 ToZTI/taz2+ShGdyjwbTg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kZG0h7I6VUE=:ssp5mlwCOJ1kjmmq4zkPlT
 0gWoWVf4Gp4PKTzCrocK4x2LN239iQqXeSH+jY62zGYznlhXP6bQ/yBQbYDOkFbMYWwOUpRom
 vtPoyCEuMXm2NFWn0URAtVN+Kfdjq2Ia1v1yfQNdJfNhQZ0uNSj4PC9k7nKs//X97rgTBzQUO
 abzvvQkJrFnTK7bvrivTiMxiaseLAB1WYCeO26vtXQ3VXDyYdOcTeUsfbYxbeD7IiAQ9WyX2R
 UoulpO+iJrXVTR7rjlHV43XyuhP/FeFHhjPDrsHnktpNXcQQBhHMM0r6Nm+vnZD2zYJ6uY1rm
 aZ+hXa2qzNoAK9RIJPsI+LKg+UK2cRaVc6UAOlLvcGWGTbDwc+xm+tnGwm7IU0Mo+WcHjnF/B
 TcsWeqdsqacoJz9oR3dX4U/yGzFy2Xn/pv+tcuqMBYi9GjKoWIuaXaE5cyZ4xtGESpAILNej2
 GB+G9LY9pMbjsbsutKT6slvzywCsxq0QFj6y6aohdCXXAe8uiht6WeaIdLM6zIIhQlzlV51e0
 Ph7h6MymUqoWz+kW3jI2JNZbDTMICYVrG99LRxkSxuP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 12:07 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2021-02-26 14:03, Nicolas Saenz Julienne wrote:

> > index d2a2d1bc58ba..997d13a21717 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> > @@ -477,15 +477,20 @@ static inline void arm_smmu_writel(struct arm_smmu_device *smmu, int page,
> >   {
> >       if (smmu->impl && unlikely(smmu->impl->write_reg))
> >               smmu->impl->write_reg(smmu, page, offset, val);
> > -     else
> > +     else if (dev_64bit_mmio_supported(smmu->dev))
> >               writel_relaxed(val, arm_smmu_page(smmu, page) + offset);
> > +     else
> > +             hi_lo_writeq_relaxed(val, arm_smmu_page(smmu, page) + offset);
>
> As Arnd pointed out, this is in completely the wrong place. Also, in
> general it doesn't work if the implementation already needs a hook to
> filter or override register accesses for any other reason. TBH I'm not
> convinced that this isn't *more* of a mess than handling it on a
> SoC-specific basis...

I think the main problem for handling it in a SoC specific way is that there is
no device-independent way to do a 64-bit store as two 32-bit stores:

- some devices need hi_lo_writeq_relaxed(), others need lo_hi_writeq_relaxed(),
  and some absolutely require 64-bit stores and cannot work at all behind a
  broken PCI bus.

- if the driver requires the store to be atomic, it needs to use a spinlock
  around the two writel(), but if the register is on a PCI bus or mapped
  with page attributes that allow posted writes (like arm64 ioremap), then
  you may need to read back the register before spin_unlock to serialize
  them properly. However, reading back an mmio register is slow and can
  have side-effects, so you can't put that in driver-independent code either.

        Arnd
