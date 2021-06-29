Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FD13B782A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 21:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbhF2TDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 15:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbhF2TC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 15:02:56 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C8EC061760;
        Tue, 29 Jun 2021 12:00:27 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i24so32677441edx.4;
        Tue, 29 Jun 2021 12:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T2w95C+qM8k4odXnWTg+Qy+O6s4VgV9B2PzrgUQXnKg=;
        b=BSv5xS6GlW9bzmWJDOWNhjaCgHH2uVlFFzpO6OOCFWUGAayOsUbIpHR2I9n64dwUeT
         0BFcKHQzFU4g+ygEfNZTqJBSYWcwOjYIo5pH+T8xkrTZmYvHfTrvF69lRCqSf8UsfEVa
         0M65hf3m4blUhYbiFgulaMPx9HmmEWZ8Ha0DqOI9fvSd5dFVOakp+txRPhqW48bX2gVH
         4IZ5LSZIA4Vn6UKS6Zq9qIqiW6TSVlTBPcEYZAfsVNB+/J8Iy6h3LRQPnf9J5471L2/X
         NNKmdMbhYRKoPoVV4B3wuywafJ5cFpfHAwhh1nSe91rC41vH9rHThILaSW1z4oCStJfu
         yyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T2w95C+qM8k4odXnWTg+Qy+O6s4VgV9B2PzrgUQXnKg=;
        b=NPSZ4Mq0w8LtklvVLNb2lZEg09kaUqVXOsci2wB3gW7FY1da/B8fWU4D7MThQXRY3h
         KOndGlyye9jfIsny0F9vWRASfFt4FYrZ+A6vwqQXArh+vgECIxE9szZ7zR26SUOPkf5j
         BIQX46qfvxc2s3lhaAK/wnspOMy5gPrOROEYYSSYJWY+6wqMku7C3u09EbyyjJhAJfzE
         UJ668nMkIwBd9QONJB4uTPxV/OCh5E2Tb+FwjpzQfCZ+YWDjlgqYFktpYLX/0CBJ+Dkj
         knCMl/5lAzZd4l9w6uEG9k3Y2dzBjOIOe8K4TTrCLxo+jwKtVP+n6NpuvAFsV/Iw6gog
         dDsQ==
X-Gm-Message-State: AOAM532Fmutsuj4C0l125ABSjrJrESSU2cJ6p/fl1lywXPLPOTo/5MQX
        obULRViNLeq4RQCcrvNaewTgSs6LyBrAGMNTAt0=
X-Google-Smtp-Source: ABdhPJzrCyLePOZbwU/YpHBQ4dDhsP2MEebHmIWdFgk1MHa6jvvw6Bo0yP64kVLq5ru5+iYeULC4Bf9NSf6Uk3j1hlM=
X-Received: by 2002:a05:6402:b83:: with SMTP id cf3mr36314741edb.130.1624993225914;
 Tue, 29 Jun 2021 12:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210629121459.6341-1-linux.amoon@gmail.com> <CAFBinCA=COnsN4Cp-z0HAPgs4kqPdiKtkZkr_LDkGz68s7B7hA@mail.gmail.com>
In-Reply-To: <CAFBinCA=COnsN4Cp-z0HAPgs4kqPdiKtkZkr_LDkGz68s7B7hA@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 30 Jun 2021 00:30:14 +0530
Message-ID: <CANAwSgRD9_B7f5UjPrxeL+x-eMMc2MAG3tXLQw36x0ho+ba_Uw@mail.gmail.com>
Subject: Re: [PATCHv1] arm: dts: meson: Fix the pwm regulator supply property
 in node
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thanks for your review comments.

On Tue, 29 Jun 2021 at 21:31, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Tue, Jun 29, 2021 at 2:15 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > On enable CONFIG_REGULATOR_DEBUG=y we observer below debug logs.
> I (as non-native english speaker) suggest rewording this to:
> After enabling CONFIG_REGULATOR_DEBUG=y we observe below debug logs.
>
Opps: I will fix this in the next version.

> > Changes help link VCCK and VDDEE pwm regulator to 5V regulator supply
> > instead of dummy regulator.
> >
> > [    7.117140] pwm-regulator regulator-vcck: Looking up pwm-supply from device tree
> > [    7.117153] pwm-regulator regulator-vcck: Looking up pwm-supply property in node /regulator-vcck failed
> > [    7.117184] VCCK: supplied by regulator-dummy
> > [    7.117194] regulator-dummy: could not add device link regulator.8: -ENOENT
> > [    7.117266] VCCK: 860 <--> 1140 mV at 986 mV, enabled
> > [    7.118498] VDDEE: will resolve supply early: pwm
> > [    7.118515] pwm-regulator regulator-vddee: Looking up pwm-supply from device tree
> > [    7.118526] pwm-regulator regulator-vddee: Looking up pwm-supply property in node /regulator-vddee failed
> > [    7.118553] VDDEE: supplied by regulator-dummy
> > [    7.118563] regulator-dummy: could not add device link regulator.9: -ENOENT
> excellent catch, thanks for sending a patch!
>
> > Fixes: 524d96083b66 ("ARM: dts: meson8b: odroidc1: add the CPU voltage regulator")
> > Fixes: 8bdf38be712d ("ARM: dts: meson8b: odroidc1: add the VDDEE regulator")
> >
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
Thanks

> For the subject:
> - patches for 32-bit ARM should start with upper-case ARM
> - personally I also include the board name so the git history is easier to read
>
> My suggestion for the subject line is:
> ARM: dts: meson8b: odroidc1: Fix the pwm regulator supply properties
>
Ok I will try to incorporate your suggestion in the next version.

> Are you also planning to send patches for the following 32-bit SoC boards?
> - arch/arm/boot/dts/meson8b-mxq.dts
> - arch/arm/boot/dts/meson8b-ec100.dts
>
Ok I will try to send all updates in the next series.

>
> Best regards,
> Martin
