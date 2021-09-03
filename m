Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1926B400684
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 22:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350410AbhICUYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 16:24:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350304AbhICUYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 16:24:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3550461058;
        Fri,  3 Sep 2021 20:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630700584;
        bh=w9uFvdy+MMe6lxlbi846nB1abNsuFlQkvxXg31gdmDU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rtOHcC7f+T3YkzmyytyucTKMwmisGPXw6k3cKdSQnV6rVIWJcsRi6KXVwN3WYfzua
         1K/HvRCSF7Yc14UL5Ze++HAsOTI/iQRKPmiO+vNO4o83J2nyevKgcz1kXSCH+7bJwR
         EhSDgwqtAfRJ8jl3PSKKoG3p7B4J1B088sfmciUlJ/G/rJ9DzDEE6JhQfnnMn5eUUs
         wbysxpl+twACy4TAwF/vVU3RxufxVzE7KubEwvBvJCiIqTN2LyRLXI6C11oPqK9lM6
         PzhiMXDasRtwhr/DZ5UZFLcyWp0G+DHzGauLV/kCUd2sicFC16rQEjC1MqrcIeUjJQ
         kj7rS47nXEdAQ==
Received: by mail-ej1-f44.google.com with SMTP id i21so436463ejd.2;
        Fri, 03 Sep 2021 13:23:04 -0700 (PDT)
X-Gm-Message-State: AOAM532aV7PCriadFkY86sZeUcp9JixA7Fc1wNRuoshLhD3ban05KpbD
        PTe7aJtmCiVaJwoluIhTvrrepr3ucv8I6xCoUg==
X-Google-Smtp-Source: ABdhPJx9r2Z/oxX8EPLFAqZlpEwThjib/ZSZ/FcuvcciUQYjXMQaNJZwSccOOM5rMfHD2Gr2jcZoaFcKkriyvOiiXOw=
X-Received: by 2002:a17:906:7217:: with SMTP id m23mr696026ejk.466.1630700582768;
 Fri, 03 Sep 2021 13:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210902092704.2678277-1-zhang.lyra@gmail.com>
In-Reply-To: <20210902092704.2678277-1-zhang.lyra@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 3 Sep 2021 15:22:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJrXPEEJrPnhZKhrddBw3LHwoKEJ3-eoMOsRtGt6k8i7w@mail.gmail.com>
Message-ID: <CAL_JsqJrXPEEJrPnhZKhrddBw3LHwoKEJ3-eoMOsRtGt6k8i7w@mail.gmail.com>
Subject: Re: [PATCH] of: fix of_address_to_resource and of_iomap undefined
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 4:27 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> If CONFIG_OF is selected, but CONFIG_OF_ADDRESS is not, when compiling
> files (sunch as timer_of.c) in which the function of_iomap() is invoked,
> compiler would report 'undefined reference to of_iomap', the same case
> is for of_address_to_resource().

What arch and config are you building?

> This patch also makes sure that of_iomap() and of_address_to_resource()
> are declared for sparc so that sparc can have its specific
> implementations in arch/sparc/kernel/of_device_common.c, even if
> including include/linux/of_address.h in it.
>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  include/linux/of_address.h | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/of_address.h b/include/linux/of_address.h
> index 45598dbec269..02a719d58466 100644
> --- a/include/linux/of_address.h
> +++ b/include/linux/of_address.h
> @@ -80,6 +80,23 @@ static inline u64 of_translate_address(struct device_node *np,
>         return OF_BAD_ADDR;
>  }
>
> +#ifdef CONFIG_SPARC
> +extern int of_address_to_resource(struct device_node *dev, int index,
> +                                 struct resource *r);
> +void __iomem *of_iomap(struct device_node *device, int index);

This is now in the !CONFIG_OF_ADDRESS section. So for
CONFIG_OF_ADDRESS, we'd never have a function declaration.

This change does not look right at all to me.

> +#else
> +static inline int of_address_to_resource(struct device_node *dev, int index,
> +                                        struct resource *r)
> +{
> +       return -EINVAL;
> +}
> +
> +static inline void __iomem *of_iomap(struct device_node *device, int index)
> +{
> +       return NULL;
> +}
> +#endif
> +
>  static inline const __be32 *__of_get_address(struct device_node *dev, int index, int bar_no,
>                                              u64 *size, unsigned int *flags)
>  {
> @@ -124,22 +141,6 @@ static inline bool of_dma_is_coherent(struct device_node *np)
>  }
>  #endif /* CONFIG_OF_ADDRESS */
>
> -#ifdef CONFIG_OF
> -extern int of_address_to_resource(struct device_node *dev, int index,
> -                                 struct resource *r);
> -void __iomem *of_iomap(struct device_node *node, int index);
> -#else
> -static inline int of_address_to_resource(struct device_node *dev, int index,
> -                                        struct resource *r)
> -{
> -       return -EINVAL;
> -}
> -
> -static inline void __iomem *of_iomap(struct device_node *device, int index)
> -{
> -       return NULL;
> -}
> -#endif
>  #define of_range_parser_init of_pci_range_parser_init
>
>  static inline const __be32 *of_get_address(struct device_node *dev, int index,
> --
> 2.25.1
>
