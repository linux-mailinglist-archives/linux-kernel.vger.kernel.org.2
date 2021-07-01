Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4122C3B9394
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 16:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbhGAOyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 10:54:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232413AbhGAOyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 10:54:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C23F56141F;
        Thu,  1 Jul 2021 14:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625151109;
        bh=OoCFtaHtPZONNovcwjiQpsNtvKfywEXzvUyvki/4k+A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JDhaqLVqC4BotbIH8uTP3vsF/rd/qk2RLHv4c/haxKk1LsIYriF4ZZGm9VPntRjzT
         J2V0vXMPgAIILb1H2mvt6GLRHWSJHswehtqD3GgTy0xl2B31rdBN8+8+Sp7EsRdluS
         yW2Tuyefd13aE/Dezctt3HyyuJGRhpusdj4kTti6Xbbb0QZrGVLKjACHdhi/97pReX
         u3Q2c83zO7fgz8pkd//g0yrn+NseB4f7qYy2VIjPm/K03rhYN5GPcSHk/WMaZHUTBi
         vPrsItfB3KHIEzN1DrIcy17lu+sGE8RFW+saGohzR8SDwg6RAhTHbFGbCetmC8aeEA
         7CLXiMrywT43Q==
Received: by mail-qk1-f173.google.com with SMTP id b2so6226138qka.7;
        Thu, 01 Jul 2021 07:51:49 -0700 (PDT)
X-Gm-Message-State: AOAM533Esh+JwzIxnFSOfB6XkjFdHAVrhQTGU48/NfF2P9rmzKEghMqV
        zz0mfa6Qeehvh1FEcUEL0EWhhfUWTu3HCHXVyA==
X-Google-Smtp-Source: ABdhPJz1kSVMinw4yLjZ5WWPryE2wCRPjUk7fQZ5mVkY49e+ymIDPafKp9nM007EgQA1pjT2NxXixg440TSkB6+nsE4=
X-Received: by 2002:a05:620a:1487:: with SMTP id w7mr421397qkj.128.1625151109003;
 Thu, 01 Jul 2021 07:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210701140328epcms1p85149318b6c18fa18b3c7c8e966c14db0@epcms1p7>
 <20210701141049epcms1p774955cc32210584be5aca8f1b3126e9c@epcms1p7>
In-Reply-To: <20210701141049epcms1p774955cc32210584be5aca8f1b3126e9c@epcms1p7>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 1 Jul 2021 08:51:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL6LP+ksJSffTF8UU=m=u_aHLucq76HYyUio9_qDH9EdQ@mail.gmail.com>
Message-ID: <CAL_JsqL6LP+ksJSffTF8UU=m=u_aHLucq76HYyUio9_qDH9EdQ@mail.gmail.com>
Subject: Re: [PATCH] of: of_reserved_mem: match memblock_free with memblock_reserve
To:     ohoono.kwon@samsung.com
Cc:     "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "ohkwon1043@gmail.com" <ohkwon1043@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 8:10 AM =EA=B6=8C=EC=98=A4=ED=9B=88 <ohoono.kwon@sam=
sung.com> wrote:
>
> When __reserved_mem_init_node called from fdt_init_reserved_mem fails,
>
> we try to undo __reserved_mem_alloc_size to prevent memory leak.
>
> 'commit d0b8ed47e83a ("of: reserved_mem: fix reserve memory leak")'

Your patch is corrupted and not plain text.

In any case, I believe this issue has already been fixed. Check the
latest kernel tree(s).

>
> Meanwhile, __reserved_mem_alloc_size calls
>
> early_init_dt_alloc_reserved_memory_arch to allocate memory,
>
> which calls
>
> 1) memblock_remove when rmem is declared nomap,
>
> 2) memblock_reserve, otherwise.
>
>
>
> static int __init early_init_dt_alloc_reserved_memory_arch(
>
> ...
>
>         if (nomap)
>
>                 return memblock_remove(base, size);
>
>
>
>         return memblock_reserve(base, size);
>
> }
>
>
>
> Therefore the proper undo-logic should be as follows:
>
> 1) memblock_add when rmem is declared nomap,
>
> 2) memblock_free, otherwise.
>
>
>
> Match the undo functions for readability.
>
>
>
> Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
>
> ---
>
>  drivers/of/of_reserved_mem.c | 3 ++-
>
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
>
>
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
>
> index 15e2417974d6..2279e1b55d1d 100644
>
> --- a/drivers/of/of_reserved_mem.c
>
> +++ b/drivers/of/of_reserved_mem.c
>
> @@ -273,9 +273,10 @@ void __init fdt_init_reserved_mem(void)
>
>                          if (err !=3D 0 && err !=3D -ENOENT) {
>
>                                  pr_info("node %s compatible matching fai=
l\n",
>
>                                          rmem->name);
>
> -                                memblock_free(rmem->base, rmem->size);
>
>                                  if (nomap)
>
>                                          memblock_add(rmem->base, rmem->s=
ize);
>
> +                                else
>
> +                                        memblock_free(rmem->base, rmem->=
size);
>
>                          }
>
>                  }
>
>          }
>
> --
>
> 2.17.1
>
>
>
>
>
>
