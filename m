Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DC43E12DE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240383AbhHEKnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbhHEKnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:43:12 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D188C061765;
        Thu,  5 Aug 2021 03:42:56 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id h18so4590023ilc.5;
        Thu, 05 Aug 2021 03:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5CC+qqYzxNbX02yW8rXrZN1nsewW7OQh6pCCNQCnBFA=;
        b=LEd7dmKXHX4KDfaael/nb3KzkXU/tGl4vxxbobYo40113u3FNcYgtEepeQjEKRaStJ
         x0IHVyDg/65VM4KYpkmM6y2vfO++w3bW3EOwwhU1FR5UL2kWHhrZCiClZ3n3uhJQuvZX
         vQpqup26DbCBcqcOPK4SCCd8OqTD/QXvHEpBXqmuh/SFvuJqVIR0c1jFQvdurOOoiruw
         0Tnn6t4RXNPJ3MrCM3D1KZSKrI1QpDu7yavU/v/LGLewPAI+t6Zog3kCb60lx8x90+up
         KHgPke6ByhzFZuWpFkPlY6j9fIVI7knjtHTkZ0bC1V0v1IIotZMxXHIEwkHvOkjdGJ5p
         K89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5CC+qqYzxNbX02yW8rXrZN1nsewW7OQh6pCCNQCnBFA=;
        b=JkbxY0TxW71wPVWNVSHp896nTjFot2YxZvrcO7oj8ECs28GRxgjdSkG+UnG/kt9E76
         OcpSX9hEVMLzyoAJvJUQIW0oZp8h6Fr12fkesg99y3NzCGjyW/jwuislP8PIqXdxJV8J
         fSWK1gn/tW+OP1eCR87KGSv7u4sdzRrQkZqHffNiLifc0jvzyo7Km20TVgfMgurW0QLY
         h4m38cu2FTh47aER2/Cba59G5rrHYxiTSOi8/4MlBkO75SJIp0jvAZA70SOl6TXfMdCn
         UNqojCflHMvJXm5i8J8+y/J2k9PKIE+5z2pwUb5QF4L7P64+CvDe0H9MXYdJ+dpAF1OH
         9QvA==
X-Gm-Message-State: AOAM532zeYGU+6r7tCiZDN4+1IPs1cGyu1eZ2611himRuiH4dgoOhGOu
        l46gBzQEIjpdcrfcs5163JIum362yjUbQYfCBCM=
X-Google-Smtp-Source: ABdhPJwTqaerJZpRejApHmZ+A8EHtxdWMpoIrp7SBBXp/NRJpTNn+aMXl4SQ6RSi6J+yvY9u14nAqrih4a1io1Tid9g=
X-Received: by 2002:a05:6e02:1905:: with SMTP id w5mr57891ilu.270.1628160175852;
 Thu, 05 Aug 2021 03:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <1627098243-2742-1-git-send-email-dillon.minfei@gmail.com> <CAHp75Vc5fJM-UiBiosAiTraq=6P0AFefmw1rmtFcvyWVb6rfLA@mail.gmail.com>
In-Reply-To: <CAHp75Vc5fJM-UiBiosAiTraq=6P0AFefmw1rmtFcvyWVb6rfLA@mail.gmail.com>
From:   Dillon Min <dillon.minfei@gmail.com>
Date:   Thu, 5 Aug 2021 18:42:20 +0800
Message-ID: <CAL9mu0+_fTTS8rBv63-PQ0H1M=yg4EtZwYXqORNRhHL0U8_KxA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Add ilitek ili9341 panel driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy

Thanks for your question.

On Thu, 5 Aug 2021 at 18:16, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> On Sat, Jul 24, 2021 at 6:46 AM <dillon.minfei@gmail.com> wrote:
> >
> > From: Dillon Min <dillon.minfei@gmail.com>
> >
> > Since the st,sf-tc240t-9370-t dts binding already exist in stm32f429-disco.dts
> > but, the panel driver didn't get accepted from mainline. it's time to submit
> > patch fot it.
> >
> > This driver can support two different interface by different dts bindings:
> > - spi+dpi, use spi to configure register, dpi for graphic data.
> >   st,sf-tc240t-9370-t
> > - only spi, just like tiny/ili9341.c (actually, this part is copy from tiny)
> >   adafruit,yx240qv29
>
> ...
>
> > I was submited the first patch last year, you can find it at [1].
>
> submitted

Thanks.

>
> > this patch has one major difference from that one, which is replace the low
> > level communication way, from spi_sync() to mipi_dbi_{command,
> > command_stackbuf}() interface, referred from Linus's patch [2].
>
> Can you shed a light on the road map here.

Personally, I'd like to merge tiny/mi0283qt.c, tiny/ili9341.c(already
done) into this driver later
(keep original author, copyright, dts compatible string).
then remove these two drivers under tiny, but it's up to Sam and
Laurent agreement.

For long term, just like Peter suggested, let all panel based on
ili9xxx with single-dbi or dbi & dpi interface to be supported by
single ilitek-ili9xxx.c, something like panel/panel-simple.c
 (panel/panel-ilitek-ili9322c, tiny/ili9225.c, tiny/ili9486.c,
tiny/mi0283qt.c, etc).
it's also needs maintainers permission.

> I have the SPI panel (tiny) based on the ILI9341 and I'm using
> actually mi0283qt driver. With yours we will have 3 (three!) drivers
> for the same chip. I really do not want this. Without road map on the
> prospective of these all drivers, NAK.

Yes, it will make users confused if there are three different drivers
for the same chip.
I'll continue to work on this driver.

Thanks again for point this out.

Best Regards
Dillon

>
> --
> With Best Regards,
> Andy Shevchenko
