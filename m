Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566423B0E6F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 22:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhFVUOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 16:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhFVUOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 16:14:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5456C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:12:07 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id n20so412029edv.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x32YDuCNYMIMWiusaAMc7PppyDkWuVh9XTNpn/BCcpQ=;
        b=BVWcNCtQ4is0MBgfGJQ+u0YjZxicJsGPzkwdc9vxUNSbSFWNcKLZw9aS8L9VTwoMng
         5wVZHg0BjK1WPhnEpuCI0f/oVS0iBoem0SRuYCxn/sw43fqs2GlFa+851hEpIABucYSp
         NGLRq3KJK8C1J+p3Z0iBqqC48GwvlcAje6NdaafN24SAbViQQ73uZrM4r+JAoIX26/mK
         /lCdftyAfcYiJUDaGm1aFDYfktGqPbJMRofn7i9EEeRjucyQRTbsLpKwVr7jrIrNe+VF
         fOLRAMsgWTJxZtSChOqRG1V73VsWlrXfOSu9u6DvouSU9pQJOsqX9zw7+Fve/RRej9QS
         A5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x32YDuCNYMIMWiusaAMc7PppyDkWuVh9XTNpn/BCcpQ=;
        b=bYgDi8x6B8srQZy3vQV7wpmZvgei3Ta/cPujvgweVNBQDlQ1Hig983o/3pS6BS4u6K
         dQgnLanCWVxiYQp8ohnpBzyWyb2Mqy5e8zwNcbeck0hArTWksHqdHHdaFEA2LwJbnpir
         Kg2DQeGFTJUgJe1PzxJRM+RG1AZ7qlMDxezBLzpaMS+9OCR5+yNET1f4BahGX9+pPwa8
         kSyqCB9duSyDhH4+VKbxBsAPLnQAO2t9BJr0rORL/4bOkymd9yQOHHJ2UEqutQgkzeyO
         JwdFQUBN3R+wZED+x0+QP8JBUZJoZGP0s1gaYgygjq3EaLzkg/TXmrgGeDQXWQam18ga
         /nMw==
X-Gm-Message-State: AOAM5306BXe/tLzt4ko0l2YgnvETXvm6wQHpFAwWawcwtHIdwCsZ+CDr
        vPHE5V0qVloPU+I8AZR5VoZAnR8SbvubyXpzEJM=
X-Google-Smtp-Source: ABdhPJxzgiSFYuAF6bcGf2ZGpBCK4YxwOEs6nOAZgcWJxDPcDT203mzVcUzx3TCooP4yABmGdttrQ+s/KNqNmrNKgNE=
X-Received: by 2002:a05:6402:2694:: with SMTP id w20mr7479552edd.287.1624392726470;
 Tue, 22 Jun 2021 13:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-7-linux.amoon@gmail.com>
 <CAFBinCCE+6G7QtDoxfbcZVVRf-MDX-epSo=_k_PJZgWX+_Whvg@mail.gmail.com>
 <CANAwSgRqixugUr-t2OheLBVwD=EOkaLqxnGkT-Bx=p_A4Nyr8Q@mail.gmail.com>
 <CAFBinCALsnpbJGEb4LBLd_jy3E8fOZAQaacz-P7ijfkeyYg2dA@mail.gmail.com> <CANAwSgRABOyWYJPrrw64Wa6j2D94T4tybn7MHGCTbBowt7UncA@mail.gmail.com>
In-Reply-To: <CANAwSgRABOyWYJPrrw64Wa6j2D94T4tybn7MHGCTbBowt7UncA@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 22 Jun 2021 22:11:55 +0200
Message-ID: <CAFBinCD91eYNXSqnmDKoAvJHWqqRbXVjnaq9RuRNCnip9kKqkw@mail.gmail.com>
Subject: Re: [RFCv1 6/8] phy: amlogic: meson8b-usb2: Use phy reset callback function
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Mon, Jun 21, 2021 at 9:16 AM Anand Moon <linux.amoon@gmail.com> wrote:
[...]
> Ok Thanks for the inputs. got your point.
>
> I was also looking into Amlogic source code for reset. (aml_cbus_update_bits)
> [0] https://github.com/khadas/linux/blob/khadas-vims-4.9.y/drivers/amlogic/usb/phy/phy-aml-new-usb.c
> is there some feature to iomap the USB with cbus?
for that specific code: that's what we do inside drivers/reset/reset-meson.c
Amlogic's vendor kernel uses an increment of 4 bytes per value, so
0x1102 translates to 0x4408

then in mainline's meson8b.dtsi we have:
    compatible = "amlogic,meson8b-reset";
    reg = <0x4404 0x9c>;
as you can see 0x4408 is part of the reset controller node.

next in include/dt-bindings/reset/amlogic,meson8b-reset.h we have:
    #define RESET_USB_OTG                 34

the register used for reset line 34 is translated using:
    0x4404 (first register) + 4 (4 * reset line / 32 = 1) = 0x4408
then the bit inside this register is translated using:
    reset line % 32 = 2

that's how we express aml_cbus_update_bits(0x1102, 0x1<<2, 0x1<<2); in
the mainline kernel (by going through the reset subsystem)

[...]
> > > > > -       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
> > > > > +       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, "phy");
> > > > I think this breaks compatibility with existing .dtbs and our
> > > > dt-bindings (as we're not documenting a "reset-names" property).
> > > > What is the goal of this one?
> > > >
> > >
> > > OK, If we pass NULL over here there is the possibility
> > > USB phy will not get registered.
> > I don't understand why - with NULL everything is working fine for me.
> > Also no matter which name you give to the reset line (in reset-names),
> > it will be the same reset line in all cases. If it's the same reset
> > line before and after: why is this needed?
> >
> I need to investigate this reset feature. With my setup with current changes
> after I update the below.
> -       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, "phy");
> +       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
>         if (PTR_ERR(priv->reset) == -EPROBE_DEFER)
>                 return PTR_ERR(priv->reset);
>
> Reset will break the USB initialization, see below output.
interesting, I have not seen that USB problem before and neither is
Kernel CI seeing it: [0]
Is it only happening with this patch or did you also see it before?


Best regards,
Martin


[0] https://storage.staging.kernelci.org/next/master/next-20210617/arm/multi_v7_defconfig+ltp-ima/gcc-8/lab-baylibre/baseline-meson8b-odroidc1.html
