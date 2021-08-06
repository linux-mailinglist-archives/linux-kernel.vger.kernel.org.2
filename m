Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6655A3E2A06
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245610AbhHFLr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhHFLry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:47:54 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E5CC061798;
        Fri,  6 Aug 2021 04:47:39 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 188so9210435ioa.8;
        Fri, 06 Aug 2021 04:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zLpVKTCFA11+OnC1v/3aHjajQo+lN8JISFoIQ0gJsWw=;
        b=hu9A7sDTQ5CTLyXUMb5kB1I1W1H5EZNTuovyxktDPPEAO5OnPRdeBrMpZCZeLbJOlc
         /Zu4TAyQPSo1dTrgbymhgLaW2AwBi9vu6dFJPOnet17QVukPhOjRVussRd6MNrdmMbVO
         cyr3ZQe5UdsvJCQCAXGiPWPz8AKUq6ZMk9YWP9DOCUOqdwnue5hicnxVZe5oNc8pDUTt
         Bor14wUM2ozGZcSTXm29zchCH2xImMpLps8RncD1TR5WLsY6V1D769l5hRCwJWL/n21p
         5xq4/gANiiC/3GkvgylENzuJLJQsPeqO/cU9TDdw1QkixzxjHLCS9esRaHkpacXHk+GG
         bqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zLpVKTCFA11+OnC1v/3aHjajQo+lN8JISFoIQ0gJsWw=;
        b=boOGfMSQJYkz3FOtBHxknox3Js8DQ65JvLGft+YIxZTvnFe3zmmOOY3M2+QI0X6M48
         SzsWq6Jrqr7oSOg4CEWEU3o8drWhQL7SBNfS8lq9i7wkbpd2d4ZAGH3VFSbm/mVmb+/G
         cgdf8WREAijMbYiHqweVD1bhRjjLMgk3UkooEtDwqoS50NqTBNCB0VuofEC0e+eTAHZt
         sedOC6OzRvhLURL364F5bBJ7xdwS1tZYWaZuNmk9puriVHj9nkvUnPPWAhIe1ryoBigj
         0wZ0jRBPvsIIe7DuEd8igO5eKH6tgV068J7tm6l4XmnRauoCYCzpF3ZHqMj0sz0o+Xmj
         IFVw==
X-Gm-Message-State: AOAM532R/hMWMkPYqUCn16Lje3CeE/QqmohScHJQKWAeSxbCXQ1mJf5Z
        gxH+P1P0kX5p6y6rNcT9o6huQkhR8BhuxoWF4H0=
X-Google-Smtp-Source: ABdhPJzhZNlw9cWh7E098WLU6XWzjiUzPFJygP7XHy5Y/EnBmPJyrPMNj9BJYH5dgtffBynVPF4A+9oJ8woXfoCYzz4=
X-Received: by 2002:a02:cc22:: with SMTP id o2mr9334421jap.26.1628250458544;
 Fri, 06 Aug 2021 04:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210806091058.141-1-alistair@alistair23.me> <20210806091058.141-3-alistair@alistair23.me>
 <YQ0fi8pV1DNZd4nP@google.com>
In-Reply-To: <YQ0fi8pV1DNZd4nP@google.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Fri, 6 Aug 2021 21:47:12 +1000
Message-ID: <CAKmqyKN6PJR6CiyZ-DVFf7FJVh2B36RGmHBrd+9owABzw8p_iQ@mail.gmail.com>
Subject: Re: [PATCH v9 02/12] mfd: simple-mfd-i2c: Add a Kconfig name
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 6, 2021 at 9:39 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 06 Aug 2021, Alistair Francis wrote:
>
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> >  drivers/mfd/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 6a3fd2d75f96..09a939f8b7ff 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1176,7 +1176,7 @@ config MFD_SI476X_CORE
> >         module will be called si476x-core.
> >
> >  config MFD_SIMPLE_MFD_I2C
> > -     tristate
> > +     tristate "Simple MFD device"
> >       depends on I2C
> >       select REGMAP_I2C
> >       help
>
> For what purpose?

It makes it easier to enable in menuconfig. That's the main reason :)

Alistair

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
