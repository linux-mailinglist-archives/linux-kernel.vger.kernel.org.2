Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0FE3BA44B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 21:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhGBTQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 15:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhGBTQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 15:16:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160C5C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 12:13:32 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id c17so17720722ejk.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 12:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LiyPmQuAW3XlG5gYx+V9yk5pkVvqy7w5OWOrUXZV0n4=;
        b=UqPAdZftWYY/hk0t9QGH80VUUUp/cKIvZzpInyllIdYALv7pGWNN6EYb9DX8rcEMfg
         zBT7n0f90YpRpe4pm+sZHhKKiNbjvLF2Nq/+J+hvaxE5/A95hfGWA+eeDj5jVgoO/m/R
         74L7X1Gw0RgCrJthw0yHiT07xHc8pevXDS70DIK35llk81VFruoaOTMo7fCMeCer2Lpf
         i6uzHmj2HWfaG07TPSFMpbjssHiFUmzNMNWgSvuY34IgN0kLn+4ldpmVceLG+M7b27Gq
         Aq1oAHDLJvyN1O3j/YqXAvULs0h9d8I/HOHuhYMzU892zHesxICaEtGgmqNO2si9HoIp
         BfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LiyPmQuAW3XlG5gYx+V9yk5pkVvqy7w5OWOrUXZV0n4=;
        b=sYH7CNGNY7x+0vN4wMkErxvh8bKzGO/2eChXNqqhCuPz/YHowE9TaldDwMUaUouoX5
         b3sokH7gcZV/IXPDRLE9RU6XkJYC42kOeBZJYHcp0soHw/TmKSoFgz8SW72Q/D8p5n17
         1DfH/QlhP+QkBhkptL75tHzH66ivm9hmaOIz9gYpe5fblX0tZcnlVgYkwMyktxZajvYZ
         RzFxA1vhxAXrWboD7lI62QYoO9CYHxFcjSYnFkB2JMG8OjDlqLa8lHA4Yg1jQrsbcX1u
         cMOtrX/Us7Udr7Vi5vtw04JEsNLk3i1OWru3lg5QFgfYSdveG6htr+a7QpETi0zELQTP
         B1ug==
X-Gm-Message-State: AOAM530tEepBwdld7LRQvEfgu5DWsJYc7X1N7JaX31rqfWcN0+Ipcpdh
        8QM7tjbVPv3niGk/3NJWvNFcG2W96zTMLmsBbvE=
X-Google-Smtp-Source: ABdhPJx6rCEfImxf0/oDRg3iTiYeiezG2pXiv9sBVa07dhGxSS/k1eVBygBfRjdpHHRbL45t/o9PphKHpVMb00DyKjQ=
X-Received: by 2002:a17:906:2dd5:: with SMTP id h21mr1325571eji.522.1625253210735;
 Fri, 02 Jul 2021 12:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210617194154.2397-1-linux.amoon@gmail.com> <20210617194154.2397-7-linux.amoon@gmail.com>
 <CAFBinCCE+6G7QtDoxfbcZVVRf-MDX-epSo=_k_PJZgWX+_Whvg@mail.gmail.com>
 <CANAwSgRqixugUr-t2OheLBVwD=EOkaLqxnGkT-Bx=p_A4Nyr8Q@mail.gmail.com>
 <CAFBinCALsnpbJGEb4LBLd_jy3E8fOZAQaacz-P7ijfkeyYg2dA@mail.gmail.com>
 <CANAwSgRABOyWYJPrrw64Wa6j2D94T4tybn7MHGCTbBowt7UncA@mail.gmail.com>
 <CAFBinCD91eYNXSqnmDKoAvJHWqqRbXVjnaq9RuRNCnip9kKqkw@mail.gmail.com>
 <CANAwSgRzY+699aSS9MVGAJYVR6_0Ni75JPhO9=LKunHQK0p=oA@mail.gmail.com>
 <CANAwSgQktfn9Q=PJhx5Uq0UQ2dHqJwjKu1RWyb2k=-dA9=+BSQ@mail.gmail.com> <CAFBinCD+seUuYUrObiqJNgEi_DaULB3nU+QQFHz9d85dAU06ZA@mail.gmail.com>
In-Reply-To: <CAFBinCD+seUuYUrObiqJNgEi_DaULB3nU+QQFHz9d85dAU06ZA@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sat, 3 Jul 2021 00:43:19 +0530
Message-ID: <CANAwSgSfzwYTtAFeKSxGUW=rtON42AObrXGsRTb31WevFKJQLA@mail.gmail.com>
Subject: Re: [RFCv1 6/8] phy: amlogic: meson8b-usb2: Use phy reset callback function
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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

Hi Martin,

On Mon, 28 Jun 2021 at 01:55, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Sun, Jun 27, 2021 at 10:07 PM Anand Moon <linux.amoon@gmail.com> wrote:
> [...]
> > Sorry for the delay.
> > We could switch the reset logic to
> > *devm_reset_control_get_optional_exclusive* as below
> > to fix the reset line, since both the dwc2 c90c0000.usb and c9040000.usb
> > will have their own context to reset control register, it means the
> > reset line is not share
> > between two USB PHY nodes.
> This is something I don't understand.
> As discussed in our previous mails reset_control_reset in case of the
> USB PHY driver (which uses the RESET_USB_OTG reset line for *both*
> PHYs) is equivalent to the following code in the vendor kernel:
>   aml_cbus_update_bits(0x1102, 0x1<<2, 0x1<<2)
>
> We have two PHYs but only one reset line. So in my own words I
> describe the reset line as being shared.
>
> >
> > -       priv->reset = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
> > +       priv->reset = devm_reset_control_get_optional_exclusive(&pdev->dev,
> > +                                                               "reset");
> Have you boot-tested this?
> Without any .dts changes this will return NULL because there's no
> reset-names = "reset"; in the .dts(i).
> If you replace "reset" with NULL then I assume that the second PHY
> will fail to obtain the reset line because it's shared between two
> devices but we're trying to obtain it exclusively for both (PHYs).
>
Thanks for your review comments.

I have always tested with both the phy enable and with proper DTS changes.
Yes, it gives false-positive results while initialization of the USB PHY.
Odroid C2 it will pass but on Odroid C1 it will fail kid off.

But it seems to me that the order of the PHY reset is kind of a problem.

Thanks for looking into my changes.
>
> Best regards,
> Martin

Thanks
-Anand
