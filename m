Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6718A358FAC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 00:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbhDHWMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 18:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbhDHWMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 18:12:07 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E89C061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 15:11:55 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id o126so6606775lfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 15:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ioJ10CTBsTjkn9xL6Be686Hj+jHT1alauBLQtGYqWa0=;
        b=K/Zcl/K0msGqq95CBiI/1f5tvFQ7Nv4lRy21tpAg8kaxbf7cgeMiS0cv4T3lnWleA2
         r207Yc+Mc+IrxKmIaJAejXh/b1axYFI35RA+oI8EPJ2TVbzqvn3Qoktcl2GYlsPoP+km
         tuN/LsNg4R9HHcPJzt48h60dQkhoN7yXQBWEAKt8hdnvqgTdMxgpS+38Qr2LakAr0bjg
         63f385BWGGOd0XEVBGlPq09IDHeUdXq5duuf/5caUB2YFzHvesvNZXPEgdxhgoMB0kks
         QaCzHzrTuNc3goh9yjVwNeWzmTs73Sr2N4L/0uAwuKdAsYh6x3EFOq0J8wTK8cPglTP6
         Fd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ioJ10CTBsTjkn9xL6Be686Hj+jHT1alauBLQtGYqWa0=;
        b=sXGnbhikUjgfy0H618mwt1iH3yholkRs5wKyaaOaiH2sh6URAaKicfp630MaY8MIlG
         UZhu8v/6onMLb98p/AsGgf72yI15QPD9b8Syb90yFwJ1LqMq3l1iHCxJ55bWha1BP2PD
         r31Oje3Zs1wYHBiq5xCosvuQD1iDjeig6xqn6wLzx8TYzGBHF4OLPqIDioaS5hPZEe32
         jEON574tS01RW1ef6DB4LB4MysJaLIa9LouTXKk9Jh0KRCHM6Lv9+xNOMW8zL3mio2N6
         HtkqUvKtAoHoFkan78+xy2haFfC1I7ylsAUmFmdobHj1EYTA4MczpvN0zWYzISzuuJxk
         +SPg==
X-Gm-Message-State: AOAM531kJcYvEOKcj2vwo0fHU43w6b06NPXTr+6AMeIoY7EIx85614+j
        UGxW5OnI9SVs5NpV5kFLwkFf+kU7aDDYB1iFkKOybw==
X-Google-Smtp-Source: ABdhPJz27ymMDR1dUEGPuUztSRP4eit7GdrXQuLeZavzg3ufC0FEXhTcV+mU85qzPX7FbSTioVON1nl/5qRtMHAr7DQ=
X-Received: by 2002:a05:6512:c0b:: with SMTP id z11mr8544156lfu.586.1617919914405;
 Thu, 08 Apr 2021 15:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1L8rWpR5b66v6Su8-m7-scA0wZQr_g_4KnV4dnrky6ZA@mail.gmail.com>
In-Reply-To: <CAK8P3a1L8rWpR5b66v6Su8-m7-scA0wZQr_g_4KnV4dnrky6ZA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Apr 2021 00:11:43 +0200
Message-ID: <CACRpkdZ8iDwH5EPiZxGzEU5p-69A5X+MUEskooe21u_j12n5Ww@mail.gmail.com>
Subject: Re: New 'make dtbs_check W=1' warnings
To:     Arnd Bergmann <arnd@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        SoC Team <soc@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 5:08 PM Arnd Bergmann <arnd@kernel.org> wrote:

> arch/arm/boot/dts/ste-href520-tvk.dt.yaml: accelerometer@19:
> interrupts: [[18, 1], [19, 1]] is too long
> arch/arm/boot/dts/ste-hrefprev60-tvk.dt.yaml: gyroscope@68:
> interrupts-extended: [[22, 0, 1], [21, 31, 1]] is too long
> arch/arm/boot/dts/ste-hrefv60plus-tvk.dt.yaml: gyroscope@68:
> interrupts-extended: [[25, 0, 1], [24, 31, 1]] is too long
> arch/arm/boot/dts/ste-hrefv60plus-tvk.dt.yaml: accelerometer@1c:
> interrupts: [[18, 1], [19, 1]] is too long

These warnings are all because the bindings in
Documentation/devicetree/bindings/iio/st,st-sensors.yaml
are slightly incorrect. Several sensors have more than 1 IRQ.

I was working on a refined version of the bindings but got
sidetracked.
https://lore.kernel.org/linux-iio/20210104093343.2134410-1-linus.walleij@linaro.org/

I'll try to get to it.

Yours,
Linus Walleij
