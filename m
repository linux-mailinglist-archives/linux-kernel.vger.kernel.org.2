Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E5431C7DC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 10:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhBPJOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 04:14:35 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:38827 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhBPJNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 04:13:51 -0500
Received: by mail-ot1-f45.google.com with SMTP id e4so8414789ote.5;
        Tue, 16 Feb 2021 01:13:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ucaaQ1ADUQy4A317BM2Jn2gGmRvVOJrGQ3s1YQX0K0s=;
        b=GmpzYCGDEdhAXW6JW0LrjmBkP/eb7mcB6Jz818kA6/nFK92+/8dFFFlYmr3BIxi+dy
         l2Id8+AvvP7IA2hYt83NEg2ns8XknyO/k1bTfXJz8hdUJe3NiYUk424tkgDtL4w0pzT8
         e3mlPcmSHpC4kLWRbVDGMrcIMP3WWRQivKNXef7+kHX180GKpjN7NXu2szGpLDSkLkuf
         FWEJN7QUfCFreJsbb8KqNij3Tm69TyzbYN20yVpZi3GsyR6o5xslHmOLsboHy11Jd21o
         r4x2s2bF3XucPiPFKkrHkt4bbt9WRrmmZI7u8SB2y4T8kHLagVUm4GOXXfG08T0+j88x
         nN7A==
X-Gm-Message-State: AOAM532krd5lP64kI8Lk0n/sa0cPQF82YsgVFtL4yEt1cd0PV5V/G8Gg
        iAYUsQ1oJttLkUW9Ol2iafszJVPgv7CpHE7Lvz8=
X-Google-Smtp-Source: ABdhPJzKXRD65Esy2e90FduDMQfkvF1Tp3lIJAEziXJuUt1F3lOaYzjpwDcyZY6EvWCmnJhfq5UPVT2eCePoy3fhcKI=
X-Received: by 2002:a05:6830:148d:: with SMTP id s13mr13989286otq.250.1613466790398;
 Tue, 16 Feb 2021 01:13:10 -0800 (PST)
MIME-Version: 1.0
References: <20210202175340.3902494-1-robh@kernel.org>
In-Reply-To: <20210202175340.3902494-1-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 16 Feb 2021 10:12:59 +0100
Message-ID: <CAMuHMdWyTWqF=2fwAmkedMCrZ_owF9nhmGWYf6Xe=CRuOB1ZEQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mtd: spi-nor: Convert to DT schema format
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Feb 2, 2021 at 6:54 PM Rob Herring <robh@kernel.org> wrote:
> Convert the SPI-NOR binding to DT schema format. Like other memory chips,
> the compatible strings are a mess with vendor prefixes not being used
> consistently and some compatibles not documented. The resulting schema
> passes on 'compatible' checks for most in tree users with the exception
> of some oddballs.
>
> I dropped the 'm25p.*-nonjedec' compatible strings as these don't appear
> to be used anywhere.
>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/jedec,spi-nor.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SPI NOR flash ST M25Pxx (and similar) serial flash chips
> +
> +maintainers:
> +  - Rob Herring <robh@kernel.org>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - pattern: "^((((micron|spansion|st),)?\
> +              (m25p(40|80|16|32|64|128)|\
> +              n25q(32b|064|128a11|128a13|256a|512a|164k)))|\
> +              atmel,at25df(321a|641|081a)|\
> +              everspin,mr25h(10|40|128|256)|\
> +              (mxicy|macronix),mx25l(4005a|1606e|6405d|8005|12805d|25635e)|\
> +              (mxicy|macronix),mx25u(4033|4035)|\
> +              (spansion,)?s25fl(128s|256s1|512s|008k|064k|164k)|\
> +              (sst|microchip),sst25vf(016b|032b|040b)|\
> +              (sst,)?sst26wf016b|\
> +              (sst,)?sst25wf(040b|080)|\
> +              winbond,w25x(80|32)|\
> +              (winbond,)?w25q(16|32(w|dw)?|64(dw)?|80bl|128(fw)?|256))$"
> +          - const: jedec,spi-nor
> +      - items:
> +          - enum:
> +              - issi,is25lp016d
> +              - micron,mt25qu02g
> +              - mxicy,mx25r1635f
> +              - mxicy,mx25u6435f
> +              - mxicy,mx25v8035f
> +              - spansion,s25sl12801
> +              - spansion,s25fs512s
> +          - const: jedec,spi-nor
> +      - const: jedec,spi-nor
> +    description:
> +      Must also include "jedec,spi-nor" for any SPI NOR flash that can be
> +      identified by the JEDEC READ ID opcode (0x9F).

Is there any value in keeping this paragraph?
The schema already requires "jedec,spi-nor".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
