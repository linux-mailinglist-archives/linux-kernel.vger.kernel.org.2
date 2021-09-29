Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CF241C69F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 16:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344432AbhI2O2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 10:28:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344142AbhI2O2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 10:28:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FF1A613A7;
        Wed, 29 Sep 2021 14:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632925614;
        bh=L4/gUbMB7IXW/+mE5sg2yvzrsdvg/AxRJNdmEImmNm4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LFW54fO7AUdG0exWC/NgjDiA4Nt98dn5yg0hPo3EdvdC/yPNIU47XEiwzYG8CA3BF
         0SNFSR6r2SyIYtkfpzI4LAfwTbTG3DBrFJ5qzRxSS/y+WJJbxgkf49SzQfVT3nyNPB
         9PNRPsZLeUoBBMb3mPdxloLfnyshGTbxNl4rp4JwCqgZq+g0aLnHChxSFXBBXTOGsb
         wfqT3eYHAdisIEprDGJ4H3K1Tjo8GIQX8bf9duGS5vbKKof+zhR+gGolnhRupHx9ON
         Lmk2TH0udml8MKxicJ+4dx20E74mu7RFB1yt8THg5eycDrx7gP2qtlXLGLePaDu6r3
         tJ1l6JW4OhIxw==
Received: by mail-ed1-f45.google.com with SMTP id v18so9294167edc.11;
        Wed, 29 Sep 2021 07:26:54 -0700 (PDT)
X-Gm-Message-State: AOAM530AWTYw6wGELTRpFM0qU68auhQ9t52+FgqKS5KPPvEHvYzJnmh7
        VodpMrl9xpILhfs2+Nc2NDdOK1x+BG4ijKIJoQ==
X-Google-Smtp-Source: ABdhPJxriq+CXUfPdOMlH7SB1VYujcInai/2OpHBeIfsE62+e+avssLCYStnCY2EoBU4Vg3HIl9TOl81k2gGXrsCBvg=
X-Received: by 2002:a50:d887:: with SMTP id p7mr232004edj.164.1632925576614;
 Wed, 29 Sep 2021 07:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210928201214.294737-1-trix@redhat.com>
In-Reply-To: <20210928201214.294737-1-trix@redhat.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 29 Sep 2021 09:26:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKMLu1Vm1x0rVGXf-RD2Mw65f3YPY3QL1mEB8=CQ9GMGw@mail.gmail.com>
Message-ID: <CAL_JsqKMLu1Vm1x0rVGXf-RD2Mw65f3YPY3QL1mEB8=CQ9GMGw@mail.gmail.com>
Subject: Re: [PATCH] of: remove duplicate declaration of of_iomap()
To:     trix@redhat.com
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 3:12 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> A ranconfig produces this linker error
> irq-al-fic.c:252: undefined reference to `of_iomap'
>
> The declaration of of_iomap() is dependent on OF
> The definition of of_iomap() is dependent on OF_ADDRESS
> These should match.  There are duplicate declarations
> of of_iomap(), remove of_iomap() and the
> of_address_to_resource() duplicate.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  include/linux/of_address.h | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/include/linux/of_address.h b/include/linux/of_address.h
> index 45598dbec269..a190996b4b0b 100644
> --- a/include/linux/of_address.h
> +++ b/include/linux/of_address.h
> @@ -122,13 +122,7 @@ static inline bool of_dma_is_coherent(struct device_node *np)
>  {
>         return false;
>  }
> -#endif /* CONFIG_OF_ADDRESS */
>
> -#ifdef CONFIG_OF
> -extern int of_address_to_resource(struct device_node *dev, int index,
> -                                 struct resource *r);
> -void __iomem *of_iomap(struct device_node *node, int index);

This is going to break sparc which has !OF_ADDRESS and its own
of_iomap and of_address_to_resource implementations. I don't want to
add CONFIG_SPARC in here, so I think we should solve this in kconfig.
OF and !OF_ADDRESS is supposed to mean the arch provides these
functions.

I'd really like to do away with HAS_IOMEM. It doesn't serve much
purpose other than disabling a bunch of drivers.

> -#else
>  static inline int of_address_to_resource(struct device_node *dev, int index,
>                                          struct resource *r)
>  {
> @@ -139,7 +133,7 @@ static inline void __iomem *of_iomap(struct device_node *device, int index)
>  {
>         return NULL;
>  }
> -#endif
> +#endif /* CONFIG_OF_ADDRESS */
>  #define of_range_parser_init of_pci_range_parser_init
>
>  static inline const __be32 *of_get_address(struct device_node *dev, int index,
> --
> 2.26.3
>
