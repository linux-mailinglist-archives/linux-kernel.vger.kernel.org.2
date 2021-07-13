Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A963C72C5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbhGMPIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbhGMPIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:08:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBD1C0613DD;
        Tue, 13 Jul 2021 08:05:32 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id hr1so42114602ejc.1;
        Tue, 13 Jul 2021 08:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ptYYbRcdUaGqdzjLb3H+jJHCNcFhan2Bn1jayE6LcgA=;
        b=tR4yp7Ihp42EXJJMuoVskTTc7jSbKuQ1cG9vgRJq/Wjm2L10WeHGPy9UodxhFg61zQ
         kGuNIUIpKCw43MydIDf/k+CcF1m/qBnE74E21xSHwd2IPV5opjL7sI7pRpm48zEAKgLE
         tEXaSINY+9K2Stknhk98Cz3Acu+vaEMrP16oiUXDrPGOIzzlIy1QbgBmO75UBuEED5jk
         OK78wAZ4vAEBz35ltw2+Ky4jVUvmVOE14vXxKhhsqsdzjKPsIuyErV7ENTGlNa1LlXEf
         QXZifY8cu3c+tEOHXaR8etdeb73QxFO7mfTwT8w/i4UgGfgGKqiFTPbrRFvx9W5sC+z+
         er+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ptYYbRcdUaGqdzjLb3H+jJHCNcFhan2Bn1jayE6LcgA=;
        b=NyUQv1NfEbuj3ZDN79WoAovRktQk/dTufgExqk5MWhMjdbraBN1En1fVNqhsBCjqUi
         Bs9pTR7+rSS7/BldTaRPTZnNxFylcayuhrXjx0Yx2PjjNIEbPeX8OyZPY5EkfB845BNS
         PoNfJryOOgFuDCK7bmByFqDjOn9Lt9hfUqFCp6ZhDfuLjo1vZhO6NfeRl8Vvt4pMuING
         C1bo4AUKjtj6I1Qh21PfEhLeWC8s7HUvn0758E6pGUEfBstDgwVPjLcno+wOeO5BjesH
         FPtf8lNLOKyUFLVgjT2BWNIyFbyN2JR64s1fMcv0wh7G4KLX5Bb1jv4kYM7mSaSNJyBh
         ZKmA==
X-Gm-Message-State: AOAM530XAtcHmvAvMM6SfmetpInmXB9hD5V8XtcySGvYainVWqGhcCZL
        GZ8UVOCt/s1hhjm1LkFUbKBE7wYP892+mMCI6Uk=
X-Google-Smtp-Source: ABdhPJytC12yD22WmJvejZr+l30Aph+KR6/YMsim0nlX0u0TaTNOQ0fJCRXXHrVCZIngCK6Q1hF59pqYFsVrvSC5vyA=
X-Received: by 2002:a17:907:207b:: with SMTP id qp27mr6219579ejb.258.1626188730833;
 Tue, 13 Jul 2021 08:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210713055227.1142-1-linux.amoon@gmail.com> <20210713055227.1142-2-linux.amoon@gmail.com>
In-Reply-To: <20210713055227.1142-2-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 13 Jul 2021 17:05:20 +0200
Message-ID: <CAFBinCD3ahpNQhP_jWZ3-4nXx8OqZOAANCpTN3BrsULRbYZHVw@mail.gmail.com>
Subject: Re: [PATCHv1 1/3] ARM: dts: meson8b: odroidc1: Add usb phy power node
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Tue, Jul 13, 2021 at 7:53 AM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Add missing usb phy power node for phy mode fix below warning.
>
> [    1.253149] phy phy-c1108820.phy.0: Looking up phy-supply from device tree
> [    1.253166] phy phy-c1108820.phy.0: Looking up phy-supply property
>                 in node /soc/cbus@c1100000/phy@8820 failed
I did some testing on my own Odroid-C1+ and this patch is not doing
anything for me.
more information below.

[...]
> +               /*
> +                * signal name from schematics: USB_POWER
> +                */
Just a few lines below you're saying that the name from the schematics is PWREN
If this patch is getting another round then please clarify the actual
signal name, or name both signals if the schematics is actually using
both names.

[...]
> +               gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
I booted my Odroid-C1+ with this and USB was working fine.
Then I replaced these two lines with:
  gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_LOW>;
and I found that USB is still working.

Can you please give this a try on your Odroid-C1 as well?
The conclusion from my own testing is that GPIOAO_5 doesn't seem to be
related to USB1 (host-only) because if it was then inverting the
polarity (from active high to active low) should result in a change.

[...]
>  &usb1_phy {
>         status = "okay";
> +       phy-supply = <&usb_pwr_en>;
From the schematics it seems that this is not the PHY supply (which I
admittedly have used incorrectly for VBUS before).
In the schematics that I have (odroid-c1+_rev0.4_20150615.pdf) it
seems to be enabling VBUS.
So in that case a vbus-supply property should be used inside &usb1 instead.


Best regards,
Martin
