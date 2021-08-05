Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1A63E1069
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 10:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237465AbhHEIhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhHEIhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:37:53 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE16C061765;
        Thu,  5 Aug 2021 01:37:38 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id s184so5746139ios.2;
        Thu, 05 Aug 2021 01:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9TcUSgLl2dudlEV2Jarkl/ZU40krT4omoii/5z/6FNc=;
        b=VKj9VAa8+Z2erKG8jBl5R8wVbAqltnG2jY6BZIlZUeDN9vMHAeWUXOoj94xufMFtr4
         WA3TtE9hqd7EsWhdTw7YrGMndMF+Ng7m2OHVd4HPesBlOSkRg4JHwX+ZX9qDqmtG7amj
         G4oGvNSKOWM4WYg2+YzYnrBRo1ZdCqaH+fJTe9nWfL1Ijjn+MICORA0pYEzyUjkoUs9T
         s89c1gwJd0X4EGXZncAkD7MZNjZaWc8Wd3RuDN8WlXUDIDgEzizVcovj1G9sW2A6a5vd
         Wi2WcFf5WIti003m2Ns+x1KMXrPK1Ddr34i29zzLCFAUdCINHj29z+wRbPZ6ATtRrdBb
         kL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9TcUSgLl2dudlEV2Jarkl/ZU40krT4omoii/5z/6FNc=;
        b=rhyvmwXg762zFj/vhZjfcMT+D7yW9zQtUnKLjnFm5neNWq/FO6/FDoxEs8lIqaJlCz
         c6fymVfRwCVt9gTaW/6H2vpIn3jEnDELzIbGstf4yUUf7DwXEceWr/Thg04meTBLyoi4
         cFfn8fVTVV1d7HvmSH9nvAomesGiifjvkZ3Tc/2ekcKXwYmIUikQplA+fXB9TWztTE5k
         LvShZwonAfX+/7mD6yomzXIag8EdcDfHdsOpmkUMMSi2MbeC1qDeV7djBehQeajQH+67
         Agx43Moa/5QQGl+evwQtm4PqLLmvY5j8D/oI8cGVj1hYBR9uUvpPX5h3dJlrnH6FF83c
         G9Rg==
X-Gm-Message-State: AOAM5333cPYUmqSJShJGegoR/rA5itOdDGKonW4O+YABuNu6iUYnqN1s
        Jsg1mMJOAtcpliuPSbnCutlNdsSPF+E6bthOxHk=
X-Google-Smtp-Source: ABdhPJychenUBvwLJgXVQE767sPn1pgz0quWLirlavjOKXwMQbJYNrJIWDCpQDCcMcBflx5C7yRn0Mok7aN6gYU9mgU=
X-Received: by 2002:a6b:ef19:: with SMTP id k25mr381112ioh.42.1628152657792;
 Thu, 05 Aug 2021 01:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210803084456.198-1-alistair@alistair23.me> <20210803084456.198-9-alistair@alistair23.me>
 <YQqLiAtAtREWTvD7@google.com> <CAKmqyKO_QeNTRZx9P9vhX7DQoBfE6igOtJroTEer-OKoVO-RGQ@mail.gmail.com>
 <YQugrBPkiSTfh8qB@google.com>
In-Reply-To: <YQugrBPkiSTfh8qB@google.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Thu, 5 Aug 2021 18:37:09 +1000
Message-ID: <CAKmqyKMT6mDZuczsSbztiSVQsfYX1MNr6VsO_Y_3LEZ+w+YzcA@mail.gmail.com>
Subject: Re: [PATCH v8 09/11] ARM: dts: imx7d: remarkable2: Enable silergy,sy7636a
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

On Thu, Aug 5, 2021 at 6:26 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 05 Aug 2021, Alistair Francis wrote:
>
> > On Wed, Aug 4, 2021 at 10:43 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Tue, 03 Aug 2021, Alistair Francis wrote:
> > >
> > > > Enable the silergy,sy7636a and silergy,sy7636a-regulator on the
> > > > reMarkable2.
> > > >
> > > > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > > > ---
> > > >  arch/arm/boot/dts/imx7d-remarkable2.dts | 42 +++++++++++++++++++++=
++++
> > > >  1 file changed, 42 insertions(+)
> > >
> > > I don't see the DT documentation for this device.
> >
> > Which device?
> >
> > The imx7d-remarkable2 is in current master and there is a single line
> > at `Documentation/devicetree/bindings/arm/fsl.yaml`
> >
> > The silergy,sy7636a-regulator is also already in master, but it isn't
>
> I think this is currently in -next.

Sorry, I thought it was in mainline at this point.

>
> It won't land in Mainline (what I believe you're calling "master")
> until the next merge window, which is about a month.

Ah, yep. I meant to say mainline. Every project has different terminology.

>
> > exposed to device tree and the compatible string shouldn't be included
> > in this patch. I'll fix that.
>
> Okay, this is essentially what I was getting at.
>
> The node should really be documented and Acked by the DT guys.

Should the regulator have it's own DT binding documentation? From what
I could tell just including it in mfd bindings was enough.

>
> ..
>
> Anyway, I have a new toy for you to play with.
>
> I'll Cc you on the patch.

I'll keep a look out!

Alistair

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
