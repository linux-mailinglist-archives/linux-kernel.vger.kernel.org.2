Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EAF39D5FE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 09:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhFGH3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 03:29:25 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:52427 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhFGH3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 03:29:24 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MDQqe-1lgqGI0UZq-00AWb3; Mon, 07 Jun 2021 09:27:32 +0200
Received: by mail-wm1-f45.google.com with SMTP id o127so9319871wmo.4;
        Mon, 07 Jun 2021 00:27:32 -0700 (PDT)
X-Gm-Message-State: AOAM530W7388sFuaOsjGrn+OidP/XQvXA+ABhT3m7To4CDxCiO60vOeB
        XZbZBYY6csbegj/CEpgjb11ywcHh3mAekd2pJq0=
X-Google-Smtp-Source: ABdhPJzFjPuLMDdi3cTmIGomtCJLAaT+d3waRMy2NgSdLhqVckoRa9aJwuTJTkAiZTW6eSgFfSMzReoS7f9+/UdHWLM=
X-Received: by 2002:a1c:7d15:: with SMTP id y21mr15225768wmc.120.1623050851753;
 Mon, 07 Jun 2021 00:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210607061751.89752-1-sven@svenpeter.dev>
In-Reply-To: <20210607061751.89752-1-sven@svenpeter.dev>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 7 Jun 2021 09:25:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0vbyq-90pUQ6-0Ed=DadR3Pnf0juupLQ70psQSuu_1nw@mail.gmail.com>
Message-ID: <CAK8P3a0vbyq-90pUQ6-0Ed=DadR3Pnf0juupLQ70psQSuu_1nw@mail.gmail.com>
Subject: Re: [PATCH v3] usb: dwc3: support 64 bit DMA in platform driver
To:     Sven Peter <sven@svenpeter.dev>
Cc:     USB list <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:FpXRJ6RdhrGnO5lZfKdZ1EfAWrw49CWWETxRA39cqrLf0ZsaN64
 M0wmHW0sI9/cEpCZ6Ca3lKEulPUpS35235ZnG3PX2jz1GHgRcswO2nq0N+iDGHptPU1wztT
 Qf3zXJYB4tb8WTd4XfwiKYvRy1yuYgh2bI51zi4DXXIUHWGQcBMsJFGYVpPfZG5cXUiQ9ex
 eK4IIfy6rpEKT49W67GXg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GOVWqNJm5Oc=:i2w7vP8G+tZb/WmVCUJJYf
 xvM3zGSKW2ybqWS3GWHIA6NaPI+HJRJFz1wl6CzLWtBSK6zCXE93+Gm4VDlnl5WMfMZ9LPdWz
 Q8iRRr/0lBZSrlU+++r/9QDey7nhPpG6Pz+fm+zNj9u97WVfm8v/CB3lsU/yLesKaCThuiyPf
 eOtyfc/bQZ+aq1adh3PeMOOfsQgaBo1tbObur7h82urA3akny7ck6QtL0ldCzbXj2XwX/AVtY
 zYVmQuSL1hvfeo9cuOQw9tOhjD1OwlAN1kpKk6B1a3iJySUuKmpjfbX8NX1fII6fGunI4cdQR
 PlZGuEYPx4pQ9K9dcoOW7XmCxQlKuCVSUjnoIJrpT5v9ZtOQVqcwQwLNBbEzHeZHBNgUvkve9
 k91QdfraphSGsBGD4ZEbasybEPCg0kr/7BNZDwhJ/nOLQgxes8MXx9GvERm2F2ERAi9pLsXDO
 quE97082toG0s2Ukx0YUofNJGotNoFhnOyh1h1DrAeU5d8UHt5S1dgnkYyYRV920o/alB9vqs
 oFw1s9Cgyaa/Z0ZvuxQpVYLxmunjEmY+tpb+QTLykiP4CVYATU4CTcmo1lcF2fAs98soCSGZ+
 5gjv97oflruJbKO0TmLtl776JBSUMBDfP524UFkinWB03e8jvcnulCEXRSjppP8u+RoKIlaHW
 q3zk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 8:18 AM Sven Peter <sven@svenpeter.dev> wrote:
>
> Currently, the dwc3 platform driver does not explicitly ask for
> a DMA mask. This makes it fall back to the default 32-bit mask which
> breaks the driver on systems that only have RAM starting above the
> first 4G like the Apple M1 SoC.
>
> Fix this by calling dma_set_mask_and_coherent with a 64bit mask.
>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>
> Third time's a charm I hope - this time much simpler :)

I think this is almost good, but there is still one small issue:

> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index b6e53d8212cd..ba4792b6a98f 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1545,6 +1545,10 @@ static int dwc3_probe(struct platform_device *pdev)
>
>         dwc3_get_properties(dwc);
>
> +       ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
> +       if (ret)
> +               return ret;

This will now  fail on machines with dwc3 connected to a 32-bit bus (or a
bus that is accidentally not annotated as supporting 64-bit) when there is
some memory that is not addressable through that bus.

If dma_set_mask_and_coherent() fails, the platform should just fall back to
32-bit addressing as it did before your change. dma_alloc_*() will do that
implicitly by allocating from ZONE_DMA32, while dma_map_*() fails
on any non-addressable memory, or falls back to swiotlb if that is available.

        Arnd
