Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEDC42CF35
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 01:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhJMXec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 19:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhJMXe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 19:34:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D84FC061753
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 16:32:22 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r18so16628702edv.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 16:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ospeyyhqw0CRqoqClIHT3mWhQW06xSFUt4wC+aB72Do=;
        b=J0ppSYQmk6ftQ18xXBFf83hWkQjuJ0uLuFrwp5CEMTzHH9X80jUZcDhXJB4Ryq4mKF
         M2fHKboCOtYZKFEvDiFCbJALu+OngShOiwebyHS6U2HgVMIFe6qAyjjRVan0ulHsTdP1
         0ztcoUX43Hkg9WoIIPCmcUtPpmq+lBFVaQdl4ZO0KpCg1RCattIhLd14HhE/o+5MZ8JM
         ygkgNM9Hw9gOspvT9k5K1ZA9nG5u04QksrR1CFB1YgaM0CPsh7EKr76JkDhnE7oSUhPe
         h8q5pCOZjk9UF7KmI/Pm1RKI8qF+yQXSC4Mn7bGV5CjO5Xj2UA1pNGWkFiK9MWhT10mv
         gq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ospeyyhqw0CRqoqClIHT3mWhQW06xSFUt4wC+aB72Do=;
        b=LeSegona99tPi0XzqAw/VvCs2HkRe+lKD50hriuKs6ODi/AYZwhIABQOFnH0Kz2of/
         PAQOYc1Ogpfe+pIbFUUpGw1FtxL2AEWvqCyVdJ6/5viEyKlyK2mpy/M4RMTdvoubzM8h
         MF62YXF8ohl6M9JLyXGaTIyNcCJUHKzdtNyu9MAsu12R+v2SJRCV+8m3qW6gRXEgqhpN
         +N0LtzoZXVPScjhYK4x0A2ZguPKsvjpE0sfdenFq5FXeBBRO0WNo84CcliwLnzEAln32
         SHTeH886ZFBxWajufvsZhvwn1h78866FMlgrPquF+Cz/6ENOqd+zD8Ir8hp8s2tQ/4tG
         KehQ==
X-Gm-Message-State: AOAM5332x08GKUdRoXBzlNeUC5NXgfs81WhRanzaeOwJzJyWDQwhg4LH
        QjTtZXfbNlHTCi2KwcwP52S1ePphRGAL/+gl7dUdgg==
X-Google-Smtp-Source: ABdhPJyuIYlcFJXtQMXt4pTjgAt118n7IntyXdUFIq9VY1B2uFC6+blRjvGj0T3/x3oVRqgidcVcxpMLoAdd+OF/5zA=
X-Received: by 2002:a05:6402:278a:: with SMTP id b10mr3626283ede.134.1634167940811;
 Wed, 13 Oct 2021 16:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211012134027.684712-1-kernel@esmil.dk>
In-Reply-To: <20211012134027.684712-1-kernel@esmil.dk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Oct 2021 01:32:09 +0200
Message-ID: <CACRpkdaB27Ar0a+Kxh9bmH78bUL_vFush==Suua2TDjt7wpYug@mail.gmail.com>
Subject: Re: [PATCH v1 00/16] Basic StarFive JH7100 RISC-V SoC support
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Drew Fustini <drew@beagleboard.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 3:41 PM Emil Renner Berthing <kernel@esmil.dk> wrote:

>   dt-bindings: pinctrl: Add StarFive pinctrl definitions
>   dt-bindings: pinctrl: Add StarFive JH7100 bindings
>   pinctrl: starfive: Add pinctrl driver for StarFive SoCs

I'd be happy to apply these to the pinctrl tree if everybody is
happy.
If you prefer some other merge path:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
