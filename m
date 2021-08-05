Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2501F3E126A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239909AbhHEKRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240126AbhHEKRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:17:08 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB284C061765;
        Thu,  5 Aug 2021 03:16:54 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mt6so7536358pjb.1;
        Thu, 05 Aug 2021 03:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uxYTdS6bgnfx+2Ini0fwp3kDF4xi+vc1vXsFnljggKE=;
        b=JtEg/md2Yb41+lcJXe0vA8ZSpStUi8dmGPgMckSn8GNINukwB+ruPr97a/iHlXfhPz
         tAalqCJiLpoS195wRcmC8yJvRMyKPo/YkNrM9NUBQ2qlfOc32ztPM7YldPLNnk3r+PeA
         jdJ1aVLKQrfpCupHt43bipmklPq+GVI+oImgws/r3M096q3leCRSbAFXiiW5+twDCZ5a
         C5vHVCdnP1TIvdOukQbc6Mi22tGiMGQ2oTQe3tyyEN92JHvwC4mFFCg/DNPGApK+EZmt
         0x+2mcC8l2PXBFQ9R22X/soj19riBMzXr/o7Vz5pLl1imicG2uHNDO4TwmW2gvW7T3+Y
         ybbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uxYTdS6bgnfx+2Ini0fwp3kDF4xi+vc1vXsFnljggKE=;
        b=ftT7NwwPdUbMlztzUDZ/EuSFmoR6efKuakVm4VjXldSQzb7DP8luFOQgBnVAuDKaWI
         BfLKT7psWwsmdyl2CjZ8bBAL/BL089Cvd2+PF2EQkP+80LWceLsBpyCBxJF9Fgkjauo8
         rcOgx2D6qTRu5DWWG3hf/+bYHOyMvufvVTT4QE4vQKa7KbvXDGPpEe+zM/K+416W8Zpt
         ne3l7AnF5n/JL9HumHHJ/cHrrdg78dv9X76Gt++TRu1aC3QiHN/OKCw0pI0k/hNLvrOF
         gFYRQ2gB4zbuvYkjxxN0fwYSARktZ8A0FHpTaTuf543luQxnenFL3u875Q+m3hcj1jYs
         lpfg==
X-Gm-Message-State: AOAM533dCWFOWJY+ZzwpKdeFr/haCxa0b7OSXeDYSVnag9n1yytAYAbU
        pytcWslV9/3XO3zeKGUghNz3mfmCuUaENPwAOuE=
X-Google-Smtp-Source: ABdhPJzQdp79YDSUT7pRlIuSy1Usr2PJofPj14rvaki1F07Zhcat3klZF8hM1ON/1nirWpPekkeKplXaq4gQ26K/OTY=
X-Received: by 2002:a17:90b:33c5:: with SMTP id lk5mr14831776pjb.129.1628158614242;
 Thu, 05 Aug 2021 03:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <1627098243-2742-1-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1627098243-2742-1-git-send-email-dillon.minfei@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 5 Aug 2021 13:16:14 +0300
Message-ID: <CAHp75Vc5fJM-UiBiosAiTraq=6P0AFefmw1rmtFcvyWVb6rfLA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Add ilitek ili9341 panel driver
To:     dillon.minfei@gmail.com
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        kbuild-all@lists.01.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 6:46 AM <dillon.minfei@gmail.com> wrote:
>
> From: Dillon Min <dillon.minfei@gmail.com>
>
> Since the st,sf-tc240t-9370-t dts binding already exist in stm32f429-disco.dts
> but, the panel driver didn't get accepted from mainline. it's time to submit
> patch fot it.
>
> This driver can support two different interface by different dts bindings:
> - spi+dpi, use spi to configure register, dpi for graphic data.
>   st,sf-tc240t-9370-t
> - only spi, just like tiny/ili9341.c (actually, this part is copy from tiny)
>   adafruit,yx240qv29

...

> I was submited the first patch last year, you can find it at [1].

submitted

> this patch has one major difference from that one, which is replace the low
> level communication way, from spi_sync() to mipi_dbi_{command,
> command_stackbuf}() interface, referred from Linus's patch [2].

Can you shed a light on the road map here.
I have the SPI panel (tiny) based on the ILI9341 and I'm using
actually mi0283qt driver. With yours we will have 3 (three!) drivers
for the same chip. I really do not want this. Without road map on the
prospective of these all drivers, NAK.

-- 
With Best Regards,
Andy Shevchenko
