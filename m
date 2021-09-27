Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BB241902F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 09:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbhI0Hs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 03:48:58 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:56269 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhI0Hs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 03:48:57 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MYeV3-1mHiQX3UXL-00VdLo for <linux-kernel@vger.kernel.org>; Mon, 27 Sep
 2021 09:47:18 +0200
Received: by mail-wr1-f47.google.com with SMTP id w29so49558859wra.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 00:47:18 -0700 (PDT)
X-Gm-Message-State: AOAM531UKYOWF8K7H6NDv26/2VQuBxoTDLEEp0RVmtHLUIj3ORWhhbhq
        dKxdWhhfmKFM3GYpQryzDKhgmzF5NBs4GLg3RyQ=
X-Google-Smtp-Source: ABdhPJypUXc3+25nnKq1O90m5FZmRmwNL+qm/7TvZoVtBZ6YVo5H9dMTuC6l63QDxjOc4sdD4BLWcez5jsp80eLlmMc=
X-Received: by 2002:adf:f481:: with SMTP id l1mr26288650wro.411.1632728838525;
 Mon, 27 Sep 2021 00:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210926072925.27845-1-eli.billauer@gmail.com>
In-Reply-To: <20210926072925.27845-1-eli.billauer@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Sep 2021 09:47:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3C+a9-hg4nbFFHR4i6e5HmchD4ZgmijJLs5RLBaCBsBQ@mail.gmail.com>
Message-ID: <CAK8P3a3C+a9-hg4nbFFHR4i6e5HmchD4ZgmijJLs5RLBaCBsBQ@mail.gmail.com>
Subject: Re: [PATCH] char: xillybus: Eliminate redundant wrappers to DMA
 related calls
To:     Eli Billauer <eli.billauer@gmail.com>
Cc:     gregkh <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:epItNzwBDdErXpQKeTbXFYEZzX3OICp+lanLFK5/wx0bN+2d/Pd
 c9h0b9zwXKH2goJmnXvOsTQCg09gsqNiDiMsqhzSS/Hq70IcILzeDX5NbLZLDqnw1Iiha7W
 jTbcIVrG4Jvr+ecpm/G3d9FQm16Il5eyuL6EJhCzznSheh+DDtOj8Meo0VUNK8sHWp57jHj
 04cDnbx6laJX/1shn9QFw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/t7vGQYCLQA=:GbN01iyXtC65H8a3WglEC3
 TkX7d2h0G2Axmoe2hW/oZWpKiQCgbkMyCBfFVXFFCRp6KvuJ2CgIdhhtvxsXjrC1f5OUS9ktl
 xOQhI6iuOmCb2ZvUFpDWv3TqwbnZsleOmWUlOJvGDBedNoKCZLkm3WQwkEUm+t/jIyQc2Mz5W
 CiV2IOerzFlJhWMfxEMt/KAL8Uo31Q7y8/+sB5wVJ8FQeheMMcIrHZicoVHsmUKq+sP7OA1Dm
 ORaOQMLU7DJpNohrFDjULAXOu1cR5IiFL4g+QTDkGVNQP33X6/4kjB689a4s7wdzgKBVGigmI
 C5qq8j4lEbsmR86ihYvyv9WQbQnAcPtHuiaMOSg/4RVfVqeZ4pRRRsJYUMKXw5mb4Kipsgvga
 wV6XvC0mD4vj94ZjqM7vcJVVkMvpjIjP7wlLCMnU4jFOOXe2Y1/GL7xEXj9eU8a0ua18Msl3g
 uMSgE3WFhyLrKa8xmxjWRUtDy6YASNeibbuzl1nWcv8YvYJqzikPj/XKNzQ/mwYzOFm2Bu66+
 KpmqCQb7vIKGzFcRD9TV3ur1GTu71dCXzSklOtMm35OT/+V9jUJP2r2z5owhsI76xQuqs7oWf
 0OjOUtBz+ug1r3zhnuKvAMn+GCaoUNgTsLLmyJP3BgQjjjR/r5Kne/l8qDswrVGKWub8pzDus
 d6A5JdRhzbdLX9SS3nmf4ApVToy7dDyetenfu2tz2jH04BVj2bwWqY9JpxdJt+SQIkytzYUNB
 w/vPNvhCob7QbgqdJ7g3Skva5zYc5Yh4kDeawDXszOKSt3lHNLsmYsx+uS/G0v7SOEd/SNzhP
 8+KIzU8DZL5Buc0HdLvzH0SRZAZavEz4zja9zeY7BZCuERMgdI801jyt+/+GQDZIOMKYQf5qR
 +xxypEjlMEbdXiuFYyKg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 9:31 AM <eli.billauer@gmail.com> wrote:
>
> From: Eli Billauer <eli.billauer@gmail.com>
>
> The driver was originally written with the assumption that a different
> API must be used for DMA-related functions if the device is PCIe based
> or if not. Since Xillybus' driver supports devices on a PCIe bus (with
> xillybus_pcie) as well as connected directly to the processor (with
> xillybus_of), it originally used wrapper functions that ensure that
> a different API is used for each.
>
> This patch eliminates the said wrapper functions, as all use the same
> dma_* API now. This is most notable by the code deleted in xillybus_pcie.c
> and xillybus_of.c.
>
> There is still need for some wrapper functions however, which are merged
> from xillybus_pcie.c and xillybus_of.c into xillybus_core.c:
>
> (1) The two xilly_sync_for_*() functions are necessary, because the
>     calls to the respective dma_sync_single_for_*() must be avoided on
>     Xilinx Zynq-7000 chips iff the Xillybus device is connected
>     through the ACP port, hence performing the device's DMA operations
>     coherently. Since it's also possible to connect the device to a
>     non-coherent port, the choice is conveyed to the driver through the
>     device tree.
>
> (2) The call to dma_map_single() is wrapped by a function that uses the
>     Managed Device (devres) framework, in the absence of a relevant
>     function in the current kernel's API.
>
> Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Signed-off-by: Eli Billauer <eli.billauer@gmail.com>

Very nice cleanup, just one comment:

> +/*
> + * Xilinx' Zynq-7000 allows connecting the device through a coherent DMA
> + * port as well as non-coherent ports. The @make_sync_calls entry is therefore
> + * used to keep track of whether cache synchronization is required. Hence the
> + * two wrapper functions below.
> + */
> +
> +static void xilly_sync_for_cpu(struct xilly_endpoint *ep,
> +                              dma_addr_t dma_handle,
> +                              size_t size,
> +                              int direction)
> +{
> +       if (ep->make_sync_calls)
> +               dma_sync_single_for_cpu(ep->dev, dma_handle,
> +                                       size, direction);
> +}
> +
> +static void xilly_sync_for_device(struct xilly_endpoint *ep,
> +                                 dma_addr_t dma_handle,
> +                                 size_t size,
> +                                 int direction)
> +{
> +       if (ep->make_sync_calls)
> +               dma_sync_single_for_device(ep->dev, dma_handle,
> +                                          size, direction);
> +}

These wrappers should not even be needed. When the device is
marked as coherent in DT, the dma_sync_*() calls are supposed
to do nothing, in a relatively efficient way. I would not expect
the extra conditional to give you any measurable performance
benefit over what you get normally, and it should not make a
functional difference either.

Can you remove the inlines and the ->make_sync_calls flag?

       Arnd
