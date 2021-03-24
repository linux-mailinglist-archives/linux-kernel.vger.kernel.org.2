Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB783477B7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 12:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhCXLuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 07:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhCXLuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 07:50:25 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491B1C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 04:50:24 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u10so29841490lju.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 04:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DEpPtg712dR9Yg6u26uvt19w4xOKwxpwCL8SB0AHqVQ=;
        b=WNjwoQ46VKuHtrLDzq+Yh2V0vqL8UDQb9tMqzU9l8tzfE/1m37OqwCIg4JpKAIAvIz
         bgqIumr6DvJ/7Wcu+mf5eXEzy49PjPWEJJlZ206vt10YYWfi3umvw6fVzg7PREMUSUXl
         Qptn6RcWtU4nwGIxXWJAmQJBM0fNX0Xl2+Qe/qVOityM55jxZ+z2EzAAN0PDj6PGX+Oo
         Wy8zTjWmchN1K1s/VORpU0rNKCYFzt2ef6gU33ZM2p9X5f6o6G6iKL7FDX5OMbQknV20
         PSqzNz/4JYTBGF8wsvzUwzZw6K1w6tetgk0mzT+J8JNGbiguEWRrhqAoIv9U2aK0aw1N
         Hxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DEpPtg712dR9Yg6u26uvt19w4xOKwxpwCL8SB0AHqVQ=;
        b=RC1sLPpBLxlbo5Y9LY73WV+lohoYq4CxC2UVi3SQEKZ0lDPrsxXAKPUnh/G8ETlQHH
         GRiVcbvgGkp88jUtTYjpHcW8yHWStHWkHd0uW705jwvu4WOL0SeomuyDj7rmSyV9VaJw
         mcJk6yWnq66042CjwoZzVe7maA2E1m4iWRRRq5EvNPDwAnoASE9XGrukMQ0/vbjWrCLq
         KmC+cfZYZzvx5nt9h6wq/CBh9n4beQ8aJoQWnuwFBDZKjTJo4GkaSbI5IcRfu7unD+Ij
         ulxj+f+xJwNrMOn02e+utRzPTC1NuqjtD3MYBP1VRtAOiZW9MY+clAxvNsEAwCWM25OU
         bBag==
X-Gm-Message-State: AOAM532Aws9JRtBLMpt3jjlPQ8zMjXvrj5SYRmzrdQYAs+JGP/A/ahbi
        PauymfayWF1skWbycyVnrhDqwb0/g4DalvBuw7CQrw==
X-Google-Smtp-Source: ABdhPJwzMPtVYo9+5i9DCjw3JHkSYXop5zqRqFn9W8t+ZmqbEZDOiQByEXXArpFPc2DAnZO2MhUYQboiu+bxW1FIfSQ=
X-Received: by 2002:a2e:1649:: with SMTP id 9mr2000576ljw.74.1616586622690;
 Wed, 24 Mar 2021 04:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210303124149.3149511-1-lee.jones@linaro.org>
 <YD+N/QVRYbm/Idp3@piout.net> <20210303141457.GE2690909@dell>
In-Reply-To: <20210303141457.GE2690909@dell>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 24 Mar 2021 12:50:10 +0100
Message-ID: <CACRpkda_FBzZhf+7KDEA8Xegw-4QWd54ij1W1YrC+qDW39c_mw@mail.gmail.com>
Subject: Re: [RESEND 1/1] arch: arm: mach-at91: pm: Move prototypes to
 mutually included header
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 4:50 PM Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 03 Mar 2021, Alexandre Belloni wrote:
> > On 03/03/2021 12:41:49+0000, Lee Jones wrote:
> > > Both the caller and the supplier's source file should have access to
> > > the include file containing the prototypes.
> > >
> > > Fixes the following W=3D1 kernel build warning(s):
> > >
> > >  drivers/pinctrl/pinctrl-at91.c:1637:6: warning: no previous prototyp=
e for =E2=80=98at91_pinctrl_gpio_suspend=E2=80=99 [-Wmissing-prototypes]
> > >  1637 | void at91_pinctrl_gpio_suspend(void)
> > >  | ^~~~~~~~~~~~~~~~~~~~~~~~~
> > >  drivers/pinctrl/pinctrl-at91.c:1661:6: warning: no previous prototyp=
e for =E2=80=98at91_pinctrl_gpio_resume=E2=80=99 [-Wmissing-prototypes]
> > >  1661 | void at91_pinctrl_gpio_resume(void)
> > >  | ^~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > Cc: Russell King <linux@armlinux.org.uk>
> > > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >
> > I'm pretty sure you had my ack on v3 ;)
> >
> > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> >
> > or again, alternatively, I can apply it with Linus' ack
>
> That would be my preference, thanks.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
