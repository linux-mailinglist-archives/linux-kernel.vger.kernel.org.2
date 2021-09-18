Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2233410588
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbhIRJkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:40:40 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:51569 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238420AbhIRJkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:40:39 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MTfgb-1mJbFn2wdZ-00U1XR; Sat, 18 Sep 2021 11:39:14 +0200
Received: by mail-wr1-f50.google.com with SMTP id t18so19270184wrb.0;
        Sat, 18 Sep 2021 02:39:14 -0700 (PDT)
X-Gm-Message-State: AOAM533NydKSw7cjeik02C7zp5qSe4KhEsNrszk6ZtdShAxefc2IyS3e
        dDJ3gAk2JpiivgjuFwgKKL8ecWIqOB2sJ+FsIyw=
X-Google-Smtp-Source: ABdhPJxYge8PPe/SGv/bK8exLLx5Gjb0c2/3o2pUnyS5weWY0uy9cXxNavng5G5bkYB8AoL+9okvaAFCvaSB4NJ4IK8=
X-Received: by 2002:adf:c10b:: with SMTP id r11mr17188561wre.336.1631957954380;
 Sat, 18 Sep 2021 02:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <b5296677f92f7bace957e66479b3d57a5a824ca1.1631942796.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <b5296677f92f7bace957e66479b3d57a5a824ca1.1631942796.git.christophe.jaillet@wanadoo.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 18 Sep 2021 11:38:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2G8Lze=0CkdL8o7OH5M-oyKPmee9x3YcdFAa4KJvDtxA@mail.gmail.com>
Message-ID: <CAK8P3a2G8Lze=0CkdL8o7OH5M-oyKPmee9x3YcdFAa4KJvDtxA@mail.gmail.com>
Subject: Re: [PATCH v2] tifm: Remove usage of the deprecated
 "pci-dma-compat.h" API
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Alex Dubov <oakad@yahoo.com>, Arnd Bergmann <arnd@arndb.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Iga7UAyM3Rg5IdVoU9FCxalWrmmUgvZPTOgWk5KLJOMoZb3BvzO
 MP9V+V8rWYX7p+yHVjZCStvqcpwBa2n4lZIKwsYzSppraY5znEaGJL2UyrbyQDjqjlqIegc
 poQpVY/RqVcMOmaGFAeKGn4ib/aSaN7JmFyvPhYcug0NwSKYqpy6/EAAH+IefZwOjb8kQXO
 7jzMVIrH/DJFErIH8LcZg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7D1WEudNtng=:F63KcyBQ+q3pV6hlFDcANg
 ER9HTZuATsxbUoUNNPx9RFX2EQkbeVhD4269n6Lsk/dg8WqV2jm9s7kYi9t0HuSUju9YU8BlO
 kiZMSVrG6dvP9TkX6WQwxxp2OIczmKkjhrtauS45Wg72OJHZS0ON4+XwglTYXfCKFl73cn9CM
 sF7EfwGeZ29vb37fWQQK844vLDZmEkIklMPpYCxuo/0QZSQyMY3wf62mot9vR7jPiuKtrH2Pi
 gyOi8A/n74oieIezH4C5xqH3hU4PwmyGA3vzKIjSdXxD8eqVDY1VkzOi9yK1p1v18p6Q+RPUP
 vVKJSb1IrWJBEgCE+Ffwh8Lo3Sa98N1ZJUx1fb/vX6DBvoKB5XoE3pCejgdM1NgrjGAkkF1VD
 xIVDuCQ0bG6gIpcGmDMd3SoZ1LhV0hJNLt0WBNsLRT4g7PeF6qUvBnZQrIo62jcE1yOCVvWYT
 peiJ+HopBxRqZYRWeczd30oWnBvFOhGRdQ4pvBfOqE7hcW3DC8/D2Ka1UJkP63klZ4YR1aN4g
 w3W768lk7CTjo3sVA555uwPCkvhYppLiisbBuOIIh+Ev8IOZjPWIHra64vw5sQkvSk8N3GdwL
 49ot6MEh2Jb0SovgKmV3B6kNxdY1w2ydpZ6OVjp07eWl45fHlB/O02FhNbCtmiybWJfBbXGD8
 E8Fa63GzCPuVtmxxXBem4K4MKQV5QaeA5OKKZWs51c6NglWgfgGlc71UplBs1Bsc6dVEkQKZ6
 wDW+oGcQ/rVW8Mdia5GfdfTBlWIfE/u0p3QhgA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 7:32 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> In [1], Christoph Hellwig has proposed to remove the wrappers in
> include/linux/pci-dma-compat.h.
>
> Some reasons why this API should be removed have been given by Julia
> Lawall in [2].
>
> Finally, Arnd Bergmann reminded that the documentation was updated 11 years
> ago to only describe the modern linux/dma-mapping.h interfaces and mark the
> old bus-specific ones as no longer recommended, see commit 216bf58f4092
> ("Documentation: convert PCI-DMA-mapping.txt to use the generic DMA API").
>
> A coccinelle script has been used to perform the needed transformation
> Only relevant parts are given below.
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_map_sg(e1, e2, e3, e4)
> +    dma_map_sg(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_unmap_sg(e1, e2, e3, e4)
> +    dma_unmap_sg(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2;
> @@
> -    pci_set_dma_mask(e1, e2)
> +    dma_set_mask(&e1->dev, e2)
>
> [1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
> [2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: Change Subject to be more explicit
>     Keep only relevant part of the coccinelle script
>     Try to improve the commit message to give some reason of why this change is done

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
