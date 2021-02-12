Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A4A319B32
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 09:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhBLI1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 03:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhBLI1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 03:27:02 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C49C061756
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 00:26:21 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id v6so5946970ljh.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 00:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t1ZkuB2+BZl7gZWvol4UUD/+B0R05rMTkvXfoQW6qLQ=;
        b=e5JRkx8lhBunhzO9peGsC0U3O5Tjj7YO2LQ7itbrLjCECEZdYZSfO6VrlwWTnTDJEM
         QPXM2Tw79Ii+TsaaFOnpOTt0/mGl8qJMJW4vFLQBmCjNoA4gcf4NTxIF0bACJme2fGSG
         NXwPxYw83hbDq6UJZ0RwEFqe0vzgP3wnC17aq8EuROgYpWX2qzUHTsQX2Og0sCKRY2iM
         zNWKZ/VXGFWjzEAsHyzhD4PiTeF0BEoxwEhv4qAOPudzHiHTuCqxejCP9RDiBdjJXAv+
         eKvXO5QrOILU86mlWpT3YGKkgkAiaYRa1tZR92VGzcgNPNgxVad5U9F1/7jTeLkxzjnt
         4OiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t1ZkuB2+BZl7gZWvol4UUD/+B0R05rMTkvXfoQW6qLQ=;
        b=ANfQ6rrLwAElzF4xG+VDO1SsUEZT2chQxqjEp+swh+qsIKhmgeJUXpWujKGKuObyhL
         uJiUBpMej8xvCATv1o7snU/Sr66FTaBmvz6xVIHCya+BPUUYm4C3NSsRyW+JmQQkhYcc
         DBCAQ3ajqjW5gbJ5qAMtoUvPfk3gBTfN70/Wc/glfuzOd0tl7/1wrHrXDntE32bEOINw
         w9OWIkFN+rIgVF0kIIRuwxhpWKP78l/DG+bDawkdHV9LmqnEcDccTY1MW/q4h3S22Aai
         VvVos26DqBca2geGMG1pQsBRQC//gEJIEfr+iQhqRPeWmpI9Rks+w5gshGppRqzGwNXq
         WXbA==
X-Gm-Message-State: AOAM531vJzK99bcgSoAc+aD6odDXvmfP82VvFLkDoRzsmgxO+3GinsKY
        FBoN8KLb9uBgL5uFAPw4euf79dbEr4DUJBN1Lmr9zA==
X-Google-Smtp-Source: ABdhPJxp0b2VxPCWon81vj38O3h55ZYX6ktoTsbasWZrHOTZ/YMHR0KolMG3ny2T8eGLQT0xD02R6tB3IqfRNHadkxU=
X-Received: by 2002:a05:651c:32a:: with SMTP id b10mr1071370ljp.438.1613118380081;
 Fri, 12 Feb 2021 00:26:20 -0800 (PST)
MIME-Version: 1.0
References: <20210130082128.3778939-1-michael@amarulasolutions.com>
 <CAOMZO5DyKDj_RjHM-qwcU9gcuROL6OYzDj3a_fdRRqCwOxWcdw@mail.gmail.com> <CAOf5uwmSR1MjGdFd2ShHWchrdL6Kxo1HJOys9JoVP1vCDX57Lw@mail.gmail.com>
In-Reply-To: <CAOf5uwmSR1MjGdFd2ShHWchrdL6Kxo1HJOys9JoVP1vCDX57Lw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 12 Feb 2021 09:26:09 +0100
Message-ID: <CACRpkdbmZY-v4PD5MieT63uCTTzoYb8CbwWE7rrCCELjCUzrug@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Support pin that does not support configuration option
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Angelo Compagnucci <angelo@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 12:54 PM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
> On Mon, Feb 1, 2021 at 12:47 PM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > Hi Michael,
> >
> > On Sat, Jan 30, 2021 at 5:21 AM Michael Trimarchi
> > <michael@amarulasolutions.com> wrote:
> > >
> > > Some of the iMX25 pins have not an associated configuration register so
> > > when they are configured the standard way through the device tree the
> > > kernel complains with:
> > >
> > > imx25-pinctrl 43fac000.iomuxc: Pin(MX25_PAD_EXT_ARMCLK) does not support
> > > config function
> >
> > Could you please share your device tree that causes this warning?
> >
> > Shouldn't you pass 0x80000000 in the devicetree for this pad then?
> >
> > 0x80000000 means that the kernel should not touch the PAD_CTL register
> > and use the default configuration from the bootloader/POR.
>
> arch/arm/boot/dts/imx25-lisa.dts:
> MX25_PAD_EXT_ARMCLK__GPIO_3_15  0x80000000
>
> The problem that exists pad that can be muxed but not configured

Did you reach any conclusion on this?

I need Fabio's consent to apply the patch, but it seems maybe the
DTS should be changed instead?

Yours,
Linus Walleij
