Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2301B39D885
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhFGJVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 05:21:07 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:51757 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFGJVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:21:05 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mw8cU-1lXH1B0kXE-00s5Rz; Mon, 07 Jun 2021 11:19:13 +0200
Received: by mail-wm1-f45.google.com with SMTP id f20so5322833wmg.0;
        Mon, 07 Jun 2021 02:19:13 -0700 (PDT)
X-Gm-Message-State: AOAM530SJlhYovTtiwvFqWI4UZl/5bCSvQ9o1nBA9r7Vr+L2q1SSNOIx
        YnFdAjYD6ExLC/gXrI7aEuKfdN6M5lxiVmOm8oM=
X-Google-Smtp-Source: ABdhPJzcvd+A9rZtmx0hzRTGYQ0hqEKpsP4vMx0uVDfDg39fUB6bq9wPd4cZ0VuBPozn4Ngt2FUxKpC/JFTJQAj8hTQ=
X-Received: by 2002:a1c:7d15:: with SMTP id y21mr15665529wmc.120.1623057552858;
 Mon, 07 Jun 2021 02:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210607061751.89752-1-sven@svenpeter.dev> <CAK8P3a0vbyq-90pUQ6-0Ed=DadR3Pnf0juupLQ70psQSuu_1nw@mail.gmail.com>
 <23348bfc-aad7-4e5f-83b1-e69463e618e5@www.fastmail.com> <CAK8P3a0j=vowKpdJxt-GBsFuwqNJZv-dB-XoZihg=XHey1VoCg@mail.gmail.com>
 <5b1431bc-64e3-4ecc-a498-eda8e46d5a95@www.fastmail.com>
In-Reply-To: <5b1431bc-64e3-4ecc-a498-eda8e46d5a95@www.fastmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 7 Jun 2021 11:17:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1v1LB8-k7Ak_U23WxCbDbqCJGyCXGsXKJ-dW4QwO-dmw@mail.gmail.com>
Message-ID: <CAK8P3a1v1LB8-k7Ak_U23WxCbDbqCJGyCXGsXKJ-dW4QwO-dmw@mail.gmail.com>
Subject: Re: [PATCH v3] usb: dwc3: support 64 bit DMA in platform driver
To:     Sven Peter <sven@svenpeter.dev>
Cc:     USB list <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+xUF/QijDCdzh/EcoIz1p3tOSkCu6/DihfxelY73cBlT8sG/yzP
 rdJN7iDEJRCk/nKIN/fGBlf35ShBUVfHQIcasjopvFhAuj1FNM4GHNQimcK1CcX/VQO9LNO
 bRmF6Zgl0nhlu9NnlO58Q4irEuObXtlivBqB6wGQHvIXKEecff0QxyzWLHTOEywqjYQR/iw
 gb1/y2ZI8fjKEznsy2TGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SZKk04KpVVQ=:NdoMkavpJiAk4p3mYCAHB9
 8+ZsenxgxIAaOe5vFN+CS5bffEL8/EmPgj8TNQ4Y18xvJ4d5Mc1Ci1sdamKiFggdaIiFNiGKJ
 eoNngKCllCbCrUB2/d0YZliaxv5Z4St+V1VipwB7kyYO3CoZNvTWnIrSlTwkOUSv9WIqafTgR
 L55YSzzu8nSSLAzDQUr0BaLM07HW9YCETavGrA/kIwhcl7f8kSepiLtRwwD8jUELF3C3+0Umg
 OLoFOVUVmhiZleHgD1VE/OktLnvcHu+egslG0MYTNFH++eeyIdwfZZpw4J1kFhTrWYurk1lyc
 5GGd8pUa+y6OuPIDNMOMu2vP3GU0ZaNE4pz8wBvZ7lCLwfj4ohWDfdu+pF1wnw7EVzVqiE1Ic
 EPQB38eD0LHO5i2tR2crXJU0Csctn0M/WsEDbWdqaHDcMUk5tKPLMYkix6Gyj64ngCS1PvOGp
 EIT6YUDzytJa7g3en0lMWGC910gzjzf9jLh3seyl0SizuG2mLvG9yg5VL/zFkMkCOUbKvVLkA
 VoiHKHhpxspNKOrZvULWysmw/KpIGYcBTuxeKu0OfHnQ8FVRLKYkdUyn4YElMFzaWy45aZpiX
 oxv0fQraz+abItVmLe/oMWWelR1eFh8XqZfqrpGXxBDgGsMdWY0B50oL6V8g0KnauPwjssOxn
 0Dmk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 11:06 AM Sven Peter <sven@svenpeter.dev> wrote:
> On Mon, Jun 7, 2021, at 10:22, Arnd Bergmann wrote:
>
> I've looked at Documentation/core-api/dma-api-howto.rst again which mentions that
>
>         By default, the kernel assumes that your device can address 32-bits of DMA
>         addressing.  For a 64-bit capable device, this needs to be increased, and for
>         a device with limitations, it needs to be decreased.
>         [...]
>         These calls usually return zero to indicated your device can perform DMA
>         properly on the machine given the address mask you provided, but they might
>         return an error if the mask is too small to be supportable on the given
>         system.  If it returns non-zero, your device cannot perform DMA properly on
>         this platform, and attempting to do so will result in undefined behavior.
>         You must not use DMA on this device unless the dma_set_mask family of
>         functions has returned success.
>
> which, unless I'm reading this incorrectly, should mean that asking for a 64bit
> mask is always fine. In the worst case the mask will just be downgraded to
> 32bit if the bus is correctly annotated (the places I looked at that use the mask
> take the min of that one and dev->bus_dma_limit).
> Only asking for a mask that is too small would be bad.
>
> I have also found [1],[2] which made changes to that documentation and that also
> seems to confirm that it's fine to just ask for a 64 bit mask either way.

Indeed, I forgot about that change, this does make it easier.

> So for these cases
>
> > > > This will now  fail on machines with dwc3 connected to a 32-bit bus (or a
> > > > bus that is accidentally not annotated as supporting 64-bit) when there is
> > > > some memory that is not addressable through that bus.
>
> the call should return success but the final mask used for allocations should
> remain at 32bit. Before the change no memory above the 32bit limit was used by
> the dwc3 core and after the change we still can't use any memory above the
> 32bit limit.

Right.

> Now if we had a dwc3 controller with
>  * a quirk that only allows 32bit DMA for the core dwc3 controller
>  * but support for >32bit DMA for xhci buffers (xhci already asks for a 64bit mask)
>  * on a bus that's otherwise annotated to support 64bit
> this change will break that.
>
> But that's unrelated to the dma_set_mask_and_coherent return value since
> just calling it with a 64bit mask will already cause trouble (and also be successful!).
>
> The problem I see is that we likely wouldn't know about devices with a quirk like this
> since so far everything has been working fine there. I'm not really sure how to guard
> against that either since we would only notice on the first DMA transfer above the 32bit
> limit. I'm also not sure how likely the existence of such a weird device is.
>
> This hypothetical dwc3 controller should probably either be confined to a bus with a
> proper 32bit limit or get a quirk that enforces allocations from ZONE_DMA32. Doesn't
> change the fact that they used to work but would now break after this patch.

Makes sense, so for your v3 patch:

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
