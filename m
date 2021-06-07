Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4110539D729
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhFGI0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:26:37 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:49961 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGI0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:26:35 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MLi4c-1m7hPf3HbU-00HdMY; Mon, 07 Jun 2021 10:24:43 +0200
Received: by mail-wr1-f45.google.com with SMTP id i94so11489605wri.4;
        Mon, 07 Jun 2021 01:24:43 -0700 (PDT)
X-Gm-Message-State: AOAM530/ESiBBynJCOBp3R7Gt9hLK2h142l/MTKG42L43T+Cs6/GZ/fb
        73OQ6svbuiGbvowRC8OZ1W5GmVtVg/XJ189sej8=
X-Google-Smtp-Source: ABdhPJwz04e8jvwJBRzJ5UhrNvs0O9SjrDt6vLNSAbWIuNZix1DEpRu/o64cI7axkBk6gW7hm/PDpKHo+QB0zA2ce/I=
X-Received: by 2002:adf:a28c:: with SMTP id s12mr16468295wra.105.1623054283428;
 Mon, 07 Jun 2021 01:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210607061751.89752-1-sven@svenpeter.dev> <CAK8P3a0vbyq-90pUQ6-0Ed=DadR3Pnf0juupLQ70psQSuu_1nw@mail.gmail.com>
 <23348bfc-aad7-4e5f-83b1-e69463e618e5@www.fastmail.com>
In-Reply-To: <23348bfc-aad7-4e5f-83b1-e69463e618e5@www.fastmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 7 Jun 2021 10:22:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0j=vowKpdJxt-GBsFuwqNJZv-dB-XoZihg=XHey1VoCg@mail.gmail.com>
Message-ID: <CAK8P3a0j=vowKpdJxt-GBsFuwqNJZv-dB-XoZihg=XHey1VoCg@mail.gmail.com>
Subject: Re: [PATCH v3] usb: dwc3: support 64 bit DMA in platform driver
To:     Sven Peter <sven@svenpeter.dev>
Cc:     USB list <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:CwClREXvVCXzYzrxMJs+O4HqqbAgUkOxBB5c2fPCi3WFfvGK2m2
 yhDH5o7XU1XHK4N/jYh9wMe+hNLBtuyf42NWTsyZfn/02eAZNXkN1n37pqRMjucIHPBu0bb
 8mbTCaT8V1qChRDcBsEBiHao6SHoKOq1tacSRzZf6Y7FikZmwi0TTXfW5/t/SRGBnt45BLn
 Bvov56q25ea3n6N79nOZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:olORgl+3wOw=:U8AZKGd9FGRwQ4L6GuvbGR
 JU3dZnKTq2sZXPuhLG5uZ4I29k0vYVwA8wOHEETFC0dF0HPVXJ+giiUjY2FKES4LxbZFwt5Xq
 BDzj0zhP4WYS/a7vSqmQNVtaczzlm04S+t0RrMFPGvXdBB6RnX9uXkh0Fr6tSEgWtyGvmYzIq
 EZboZgBz6F3JM1IVhVu8UGFNzu21B7Ya3UvVPGBvQ10Z/ywjnOrKxV63RrZuDOU7ct0Xz6CgS
 jJcDr/Ssv0G46UNZOEziIOk4GTuFidAnqbQWFyqV5pNmzAMgIk0KcG91iaugqwFa5d7WIjupl
 sXYtb5CHp+Ab41DqDHxRH2ja6tiYjgj9+NQv5uX1ilCbbT3PcxIgyVXH2b54TVb1evXEgCNXx
 4HCVHgxZPVjQSsgrBtFptVo5GAJWFJzMNUAiNbw+ByRYy9g+WiUrkJ1fXWwkJlpFLeplQblc6
 /IaL9KDrMJy4hXIyvo7SOlzxI6LRQkG1g/SHA+P/BeP+KwQA2zt1u17p0/MFWgxYdm4BKOF7D
 EVBDKxZRU61TktE8zSmlCsPUPg51oW4o3BmgmIZYKsIx1lktAosGuoTsrTkz75ChdOnimVXbz
 fm3S/d8kf5RVDVO9cC6fpAc9CsbRbSN3+0Ncki/z7jjLiWYLyRND1e2/52NbZRmY0NHIYXe1P
 /VWI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 10:01 AM Sven Peter <sven@svenpeter.dev> wrote:
> On Mon, Jun 7, 2021, at 09:25, Arnd Bergmann wrote:
> > On Mon, Jun 7, 2021 at 8:18 AM Sven Peter <sven@svenpeter.dev> wrote:
> > >
> > > Currently, the dwc3 platform driver does not explicitly ask for
> > > a DMA mask. This makes it fall back to the default 32-bit mask which
> > > breaks the driver on systems that only have RAM starting above the
> > > first 4G like the Apple M1 SoC.
> > >
> > > Fix this by calling dma_set_mask_and_coherent with a 64bit mask.
> > >
> > > Signed-off-by: Sven Peter <sven@svenpeter.dev>
> > > ---
> > >
> > > Third time's a charm I hope - this time much simpler :)
> >
> > I think this is almost good, but there is still one small issue:
> >
> > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > index b6e53d8212cd..ba4792b6a98f 100644
> > > --- a/drivers/usb/dwc3/core.c
> > > +++ b/drivers/usb/dwc3/core.c
> > > @@ -1545,6 +1545,10 @@ static int dwc3_probe(struct platform_device *pdev)
> > >
> > >         dwc3_get_properties(dwc);
> > >
> > > +       ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
> > > +       if (ret)
> > > +               return ret;
> >
> > This will now  fail on machines with dwc3 connected to a 32-bit bus (or a
> > bus that is accidentally not annotated as supporting 64-bit) when there is
> > some memory that is not addressable through that bus.
> >
> > If dma_set_mask_and_coherent() fails, the platform should just fall back to
> > 32-bit addressing as it did before your change. dma_alloc_*() will do that
> > implicitly by allocating from ZONE_DMA32, while dma_map_*() fails
> > on any non-addressable memory, or falls back to swiotlb if that is available.
>
>
> Makes sense, but just to make sure I understand this correctly:
> All that needs to be done is call dma_set_mask_and_coherent with a 64 bit
> mask and then just ignore the return value?

If the driver never calls dma_map_*() on the device, that is correct, otherwise
it has to be careful about what pointers it passes in there to avoid
failing later.
Since it is already working without the dma_set_mask(), I don't expect a
problem there.

I suppose in theory, the dwc3_alloc_scratch_buffers() should use GFP_DMA32
if dma_set_mask_and_coherent() failed. On arm32, it won't matter since
all kernel pointers are generall within ZONE_DMA32, and on arm64 we always
build with SWIOTLB enabled. Not sure where else you'd typically find dwc3,
or if any of them are broken without changing this.

        Arnd
