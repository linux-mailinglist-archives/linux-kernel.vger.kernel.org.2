Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23BE41171F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237894AbhITOe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:34:28 -0400
Received: from mail-ua1-f45.google.com ([209.85.222.45]:33744 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237226AbhITOeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:34:13 -0400
Received: by mail-ua1-f45.google.com with SMTP id r8so11330459uap.0;
        Mon, 20 Sep 2021 07:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d1fA9sD4Re6cy9QvKdyaIPvjv83NrwqIwiME67fS8gw=;
        b=OQdELAZnWArIcYY1p17tpR8mjxmnHq2ON9CKjz56wUzQJx/Xyxjfos4tIyBhFQ3Vp+
         +wB+CmCMRT3LxQU0uqGMmoc7OEIX8JKsv/tJsAiqnkXpoBweaAvd1fxC7LzWA6EnAQg9
         wcPNTDpkVLXBcIHdyGrwMWhTt0CqTs3f+t+25X88D6DImScN2gbKdI2YEXYDu7nHA96d
         21L7Z1MNUckGZgQj3RxO24jCDrLjw4bAH/gueVr+EgwwHJ7Garl6Jt+gjNFjWez/BLIE
         cW9f2TL6nVwAdAmEvgnpYH8MV4BeSJXn3Kzqa08FWgOa4u9JEIIHhD0sG2cIMiMjdPhc
         7usg==
X-Gm-Message-State: AOAM530VMaq9g7ji8RpGT+NTO5z+lmglEksWMhPa+FMx+9KmakI1XNBz
        7/7wbVoc1zULqgdeWQba/tkfDEm4Lfj2He/FGEg=
X-Google-Smtp-Source: ABdhPJyMCIfZZUlLRlGgiTjNjprimvUPIgx9dDOJ6a13gJeOJZt/lIf4W4G47j5QN8TUNgkF0wEBIumzqn+a8381x10=
X-Received: by 2002:ab0:311a:: with SMTP id e26mr12181930ual.122.1632148366041;
 Mon, 20 Sep 2021 07:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210920132830.152802-1-krzysztof.kozlowski@canonical.com> <20210920132830.152802-4-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210920132830.152802-4-krzysztof.kozlowski@canonical.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Sep 2021 16:32:34 +0200
Message-ID: <CAMuHMdX5vhihbKrXh4x_VyA2Cc=nR+53g_fZPHsuHVF56rBvMQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] riscv: dts: microchip: drop unused pinctrl-names
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, Sep 20, 2021 at 3:28 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
> pinctrl-names without pinctrl-0 does not have any sense:
>
>   arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: sdhc@20008000: 'pinctrl-0' is a dependency of 'pinctrl-names'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> ---
>
> Changes since v1:
> 1. Add review.

> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> @@ -33,6 +33,7 @@ properties:
>        - items:
>            - enum:
>                - issi,is25lp016d
> +              - issi,is25wp256
>                - micron,mt25qu02g
>                - mxicy,mx25r1635f
>                - mxicy,mx25u6435f

This one looks like an accidental addition?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
