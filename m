Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607513A11D6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbhFIK5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:57:47 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:42958 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbhFIK5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:57:43 -0400
Received: by mail-lj1-f174.google.com with SMTP id r16so11898686ljk.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvIuq7yCBZI9oh+HolFFkb/f7sv15WjrCKTD1PWydYE=;
        b=aqmTQ4Tq7tp3JhjxH4GQ9HXZVvX8RRZOYwnTZqi9FwM6DNLCDlVKbHyie15+145qBI
         o6An9yE8okaeikBuxFIdZs9p4u/S/tbNX2MTXDdDPcCd7ychrX5KlcQmqoBHvyS/8y1h
         aZa2dxXYrL9EbKPIUC/kIdVAGRkxfR4+kmzpfVgiI7rkvePdrajM08ARcHhUO88/QK2O
         hdXXraH/qgd3SkAAiB+DPV3k4t8u8A70JSZe7qkIfHciR8T1SK8BsKtLhEhUMBqVjAGZ
         G60hZjGepVKScMs3xNKpAJ8FlPOv6u3jYG45jLhhpQbOIHjrSkCsCl+mSQnRSl74lJpK
         t3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvIuq7yCBZI9oh+HolFFkb/f7sv15WjrCKTD1PWydYE=;
        b=jAuy0GVNxYipF1lRhX1Bp21yBFGCZ+0tIPU3c855bMV1mQOteKKU+Yix0/2LvRI/x/
         tBHW6zUDH4BjzIBEs2dZIEltTFNOn9EdoeulxaGQGXe3c926s/a6A7uB1sziX4dnAQQF
         YzPjb2VETUKwRuD/JpgeYO3sNZSH/XaF70IO8EzYqed2TSjFkkwpFf1VUntYIeJloziH
         u3Pw3b/tAmMwpo8x06R1ng3/Vti8Rch6rgzKG7v4Hx+5LvFJhOJxqe0E8GkfKG+ignS5
         w4rPkR3T3GNAxIlowBdcsVnSa4IuiiDcVS2DplTv36Fr6Jk+Ru86PCicEA3vS86DVtUp
         wVjw==
X-Gm-Message-State: AOAM531at8R9ScqAD/qB9nLY41+GE0DUBJDaq+c9nuKJJfH2hfFvrqaC
        W9slEOoTqtO/tkGDNspzIUUUnD3Li9HrCTT1xXSntFTYYlk=
X-Google-Smtp-Source: ABdhPJy9jtLYPd3PIA6YsEvO5XTv5tO8NP31qTDfX0RScssCc2S2g4ub5LbPM5p6JmfTmLKacK2QOK7wOSZswNzp3KA=
X-Received: by 2002:a05:651c:1411:: with SMTP id u17mr11232132lje.438.1623236088374;
 Wed, 09 Jun 2021 03:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210608102547.4880-1-steven_lee@aspeedtech.com>
In-Reply-To: <20210608102547.4880-1-steven_lee@aspeedtech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Jun 2021 12:54:37 +0200
Message-ID: <CACRpkdZOStr+K9U9QTkAcsk4NxuSqBRVv_-9_VkGJbT69iSxmQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] ASPEED sgpio driver enhancement.
To:     Steven Lee <steven_lee@aspeedtech.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        Hongwei Zhang <Hongweiz@ami.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 8, 2021 at 12:26 PM Steven Lee <steven_lee@aspeedtech.com> wrote:

> AST2600 SoC has 2 SGPIO master interfaces one with 128 pins another one
> with 80 pins, AST2500/AST2400 SoC has 1 SGPIO master interface that
> supports up to 80 pins.
> In the current driver design, the max number of sgpio pins is hardcoded
> in macro MAX_NR_HW_SGPIO and the value is 80.
>
> For supporting sgpio master interfaces of AST2600 SoC, the patch series
> contains the following enhancement:
> - Convert txt dt-bindings to yaml.
> - Update aspeed-g6 dtsi to support the enhanced sgpio.
> - Define max number of gpio pins in ast2600 platform data. Old chip
>   uses the original hardcoded value.
> - Support muiltiple SGPIO master interfaces.
> - Support up to 128 pins.
> - Support wdt reset tolerance.
> - Fix irq_chip issues which causes multiple sgpio devices use the same
>   irq_chip data.
> - Replace all of_*() APIs with device_*().
>
> Changes from v4:

v5 looks good to me!

I just need Rob's or another DT persons nod on the bindings (or timeout)
before I merge it. Poke me if nothing happens.

>   ARM: dts: aspeed-g6: Add SGPIO node.
>   ARM: dts: aspeed-g5: Remove ngpios from sgpio node.

These two need to be merged through the SoC tree, the rest I will handle.

Yours,
Linus Walleij
